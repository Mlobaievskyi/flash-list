import { BaseItemAnimator } from "recyclerlistview";
declare const PlatformConfig: {
    defaultDrawDistance: number;
    invertedTransformStyle: {
        transform: {
            rotate: string;
        }[];
    };
    invertedTransformStyleHorizontal: {
        transform: {
            rotate: string;
        }[];
    };
};
declare const getCellContainerPlatformStyles: (inverted: boolean, parentProps: {
    x: number;
    y: number;
    isHorizontal?: boolean;
}) => {
    transform: string;
    WebkitTransform: string;
} | undefined;
declare const getItemAnimator: () => BaseItemAnimator | undefined;
declare const getFooterContainer: () => React.ComponentClass | undefined;
export { PlatformConfig, getCellContainerPlatformStyles, getItemAnimator, getFooterContainer, };
//# sourceMappingURL=PlatformHelper.android.d.ts.map