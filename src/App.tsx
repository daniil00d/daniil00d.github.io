import React, { useEffect, useMemo, useRef, useState } from "react";
import { GraphCanvas, GraphCanvasRef, useSelection } from "reagraph";

interface Node {
  id: number;
  name: string;
  father?: string;
  mother?: string;
  level: number;
  nIndex: number;
}

interface Tree {
  tree: Node[];
}

export default function App() {
  const graphRef = useRef<GraphCanvasRef | null>(null);
  const [tree, setTree] = useState<null | Node[]>(null);

  useEffect(() => {
    fetch("/tree.json")
      .then((res) => res.json())
      .then((response: Tree) => setTree(response.tree));
  }, []);

  const nodes = useMemo(() => {
    const map =
      tree?.reduce(
        (prev, curr) => ({ ...prev, [curr.level]: 0 }),
        {} as Record<number, number>
      ) || {};

    return (
      tree?.map((node) => {
        return {
          ...node,
          id: String(node.id),
          label: node.name,
          nIndex: map[node.level]++,
        };
      }) || []
    );
  }, [tree]);

  const edges = useMemo(() => {
    return (
      tree?.reduce((prev, curr) => {
        const acc = [];
        if (curr.father) {
          acc.push({
            id: `${curr.father}->${curr.id}`,
            source: String(curr.father),
            target: String(curr.id),
            label: "",
          });
        }

        if (curr.mother) {
          acc.push({
            id: `${curr.mother}->${curr.id}`,
            source: String(curr.mother),
            target: String(curr.id),
            label: "",
          });
        }

        return [...prev, ...acc];
      }, [] as { id: string; source: string; target: string; label: string }[]) ||
      []
    );
  }, [tree]);

  const maxLevel = Math.max(...nodes.map((node) => node.level));

  const { selections, actives, onNodeClick, onCanvasClick } = useSelection({
    ref: graphRef,
    nodes: nodes,
    edges: edges,
    pathSelectionType: "in",
  });

  return (
    <GraphCanvas
      // draggable
      ref={graphRef}
      cameraMode="pan"
      labelFontUrl="/fonts/Roboto/Roboto-Light.ttf"
      nodes={nodes}
      edges={edges}
      selections={selections}
      actives={actives}
      onNodeClick={onNodeClick}
      onCanvasClick={onCanvasClick}
      layoutType="treeTd2d"
      layoutOverrides={
        {
          getNodePosition: (id: string, { nodes }: { nodes: any }) => {
            const idx = nodes.findIndex((n: any) => n.id === id);
            const node = nodes[idx] as Node;

            return {
              x: 100 * node.nIndex,
              y: (maxLevel - node.level) * 100,
              z: 1,
            };
          },
        } as any
      }
      labelType="nodes"
    />
  );
}
