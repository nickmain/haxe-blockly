package blockly;

import utils.Types.OneOf3;
import utils.Types.OneOf2;

typedef DynamicTipInfo = { var tooltip: Any; }

typedef TipInfo = OneOf3<DynamicTipInfo, 
                         String, 
                         (() -> OneOf2<TipInfo, String>)>;
