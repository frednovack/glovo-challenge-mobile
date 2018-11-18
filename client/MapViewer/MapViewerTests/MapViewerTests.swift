//
//  MapViewerTests.swift
//  MapViewerTests
//
//  Created by Frederico Novack on 14/11/18.
//  Copyright © 2018 Novack. All rights reserved.
//

import XCTest
import CoreLocation
@testable import MapViewer

class MapViewerTests: XCTestCase {

    override func setUp() {
        let sao_paulo = City()
        sao_paulo.code = "SPO"
        sao_paulo.name = "Sao Paulo"
        sao_paulo.workingArea = ["", "psfoC`_`|G", "vbynCzne|Gk|@dNmgAzdAcr@~z@id@`Bcq@sSgOmRuDqjAyc@uw@{d@q^vLet@dFup@SyXfaAgYdKaPfGaHrDeHj@yL`CiNfBcN~AgUzDy^fLioAtT_oBhl@slBfXmg@~d@mYrd@_Ltf@{Qpx@cLhXo\\rtAc`@~[]t`@c@nS_AdJxKzQpIrCt^`f@~I~b@lOlb@bKvUrTdRrb@jFzl@bDxrAzBx\\iMjJin@~_@oWln@jAhGfm@gC~FrBfC~GtE`ZxGxG~MGbFha@bTlIjDra@x@jbA\\pp@nBn`AlAzNvP~PuA~l@oDt\\ii@gc@qbAy`Asd@@kMdHeMdHyTwF_OgCsPpGsb@d\\yYvP{a@|Ouq@~\\k~@b^",
                                       "bqsnCvz_|G"]
        let zaragoza = City()
        zaragoza.code = "ZAR"
        zaragoza.name = "Zaragoza"
        zaragoza.workingArea = [
            "wka}FdjeD@@",
            "grk}FfeiDXyv@dFgBWcP~D}L~DwEfQiGjHoF~B{i@eBnFkEeA~@iDsBqFrDgCXwBdGiC`Vdu@xWQfJxUsDF_AmEmGbD_@}AkFhDdFpNodAlb@{Kpo@",
            "wkd}FdkmD~Tap@{AaEbTgm@qXiVc\\pTtAnFwJxJi@~ByDzNjQls@",
            "w`i}Fv|jDgBeNxAcRE}QnImYfPkN?uHsEyLsEeRedA~a@wKlo@eKk@Ijg@hPzKnKrDlNb@",
            "ghb}F`zoDpXrQj@~@n\\zVEh@Np@EF_ArBsSze@{B`EyAnAu@RYbAP`BV^mAd@mDvDyBzA_Dn@kD`@qE@_Jq@wBg@iAa@CQeL_JSuDqDw@iEmRgBwK?iEhWcIdFuG",
            "sh`}FxroDlCXx@DTVXnA^xAlAnB^l@Ul@s@eA]?m@^u@z@@l@Nr@AtABbAc@jEi@fBq@xBe@Vq@DoAzC?`AKxAJtACtAFz@m@lAoAIWkABk@m\\uV{@{A\\o@dA{AdBc@dG{@dEsAjFgBrAcAjByBlAy@r@mA",
            "}}}|FlckDaL~`AfEvB~DdCbAZrAXdBb@ZPl@^x@\\x@JxA?dBAzA?n@A`AU~@k@f@u@\\oC\\kCIkDG_BSsBmB_RQUUE]iBk@mEc@_CSyBmBmKg@gAw@s@{@YaAK_ABc@{B`AgA`A_Av@e@n@Nb@?b@Y`@c@Ny@AiAUw@k@e@e@EYe@gBkFwB{EmB_DsCsDyDsD_DwCwEeEcWqUmBaBy@dBiK}L}AkD_IpAJjF_@~@eIpCmCr@sBh@l@~En@|AzCtPlDrGrEzDx@tAd@`BNtFUlE~@QdA{EfGTdKi@jHqCpDiChAi@~AFpDxCnI|FrBfDxAlDd@lEOpAOnBRbA",
            "khc}FzlnDin@sl@_Kg`@yOlIgB~AlE~Ij@~IzF~Q~YnhAtMcH",
            "gcf}FhcqDIk@ZIDl@",
            "yu}|FzckDc@gCpB}Br@g@b@Sf@R`@BXjB`AbGN~@{@Vc@eA{@y@_AW_AK",
            "}{k}FnlhDdI\\I`TaHLBk@",
            "u}_}F~euD`@mAf@mDG{ADk@P}@Js@?_COqDEuEu@m@Qw@?mAoAuAmO_LgOqJkD}AsAOyAVeBb@_A\\sAtAyA`ByBxAyCr@mD`@qE?{Io@kBa@_Cs@~A`GP|DEnQ^xC~BvI^xCe@|Ey@r@_B|AeCpCs@tAeA~Eu@`BhBtJpB\\RpAlFvF~CdEz@GVNP`@KdA~@xCdChEdBd@WbAIfBtDpAlAxApAjAK~IDfFrBGHiCXkDd@wBtAuA`HsHjAoBEaBm@}DFcAdAwBtAgFh@wDTMb@Oj@iA~AcClBeArAxAz@dAtAUbCwDvB_FxAyCVmEn@gBhASv@uC",
            "czd}FndjDj\\kT|DxDbJm[xCyCpBkIrLaVwZ{ZwZcFyO_HaZkHmCYeJpo@lTvObHt^~E`O",
            "eic}Fj`sDSoDeDs@",
            "e|f}FlxmDi@gGhIgq@xAaGyDA}PqOuDyAsFTyBtNaLb]i@v@~R~UpAZhF|N",
            "g}a}FbclD",
            "qya}FvznD|HkPpGnBhKfMzIzElDdHrA~BFdC_@KQjA_AfAoAt@{ArBoBnAcIbCsAj@iJxA{A`CD\\qFeDcQmL",
            "e|d}F|tnD",
            "s}a}FzdjDeAaE~AwJuAqFiE}CoDcFbH_WdLvIrLr@`GQzDgAh@fEv@nBnC`PpBvDk@TwF\\gC`FyB_EiAsDcHpEsBwDiDtAmA|Aa@fF",
            "cfd}F|osDaSsV",
            "qkc}Fn`kD",
            "mug}FfckDwBvNcL|\\g@v@??mCtFoRb\\cIzG}T~FkFgg@]cPJkm@lBJdb@kCKy@\\Ef@tAvM~B",
            "myd}F~nuD~@wEFyo@gCwFsCoFyGqFkFoJgEcHkHtAch@rOsCbAeHzRmPrZsEdP~@nJrDhR~@pJrBhRdF`VxCfC~E?xBmBrB_QdByJ`FkOjCcE`MoIdHeBxLa@rKa@`OgB",
            "kyc}Fx|iD",
            "adc}Fl|uDd@Ln@wA`AyEr@yA`HcHd@{Ea@{C_C}I_@uCFoQSaE}AsFAE^LCOeLaJ?CwDcFMCiEmRgBwK?gEBA?WUq@g@]i@I]T]vA}@PgEz{@",
            "spk}FjljDJki@kIP_@_Us@mAeDBiEaBoFyCeCa@yEQgBvBwAtEcB|F_AjDeB~@gBtAaA?}CQkCf@SzDxEvB?tAe@dE_@dIErFJ~ECjCv@tAvAjKhDtP|AnH^xASdCLpAv@h@f@fD~@lIM`C?dBh@tAOhKY~EKbAd@r@lAtHpBvDxJdErN~DrJxCvAs^Tih@D{a@KkS",
            "egc}FdjnDi@eEu@sJhDmAdLsIbH}EbB?eBcJzBsc@{B{@_^uCmG`KcU|o@pa@p`@l@eA",
            "utk}FpsnDlSxQxPng@lNnv@xUjUdIw@vGgCh@_FzAkUe@wRyDqPk@sHmGaa@jA}p@iItH}TnFsYfFmQzB",
            "_kg}FzoeDyUpPCfFfHtk@h@xAbT{R_B_FiKqT",
            "kug}FjckDvFQ|Kgh@cIaEgVup@YwAG@]cAEBy@|@@c@}BjBaLvJmIlYD|Q{AdR|AfLXEd@tAtM~B",
            "yye}F|lrDwG{h@Gm@a@_B_AeErc@iOvNdr@qa@~Mm@dCe@cA",
            "{`e}FlhpD{c@`O~AfHWHFb@VG~Gdi@uo@`R_AuA_@gJzCwUjN_l@|Aa^rD_KiGwTQqErAQdAeCdDiBlBQrCiBn@`BlTsKrFYJpA|ZjhA",
            "yxf}FjlnDIcCA?s@eEs@sHiL~@iF}NqAY{R_VgWtc@kAjp@pGlc@rAWhKsEjRbHhEwAjGoJxDsb@",
            "km`}FjjjDbJPCyBGmEs@{Bs@uAiEsDcAsBw@\\fAlC|@`Ic@hC",
            "i}e}Fr|eDw[eG}KmA{BoA_FrW|KxUdArDhGYhCbBtL~D",
            "ys`}FniiD",
            "gl`}FldqDj@\\@h@?f@?\\|FnHlDhFnIdJ~ClDxCpCrAhAt@P^Il@B`@j@VnARf@c@hAc@Ck@RY^Wv@vJhKFXE`@oGlWoA|ESXSAUScB~G_JoHyBuAyAXw@]_AyAOuA?_A{ZoT_Ae@eGgDuAUi@Dy@p@eAPs@cASgBXcAx@YrAmAdCqErHcQlL}WCcAX_Af@M",
            "gsh}FbsfDeEyNtF{D^rBhGoDbApEdD?uAdB",
            "qce}F`~kDkEwQxE{ReDyIuIgIgHJiDqN_IeJeLmGaTfbArDxArDxCfKtJ`EBhGv@dP~Q",
            "kui}FpkqD",
            "_jh}F|suDmBtAcE}DyCnGuDv@kDc@wDiGiE_Ee@kBhCqGnBaCt@}J|@gH~B{HSmEk@kD~AyAi@wBiAaAyA?e@sAHiCc@yCfIs@xDgBpAa@XtAnG?bJsH\\zFo@|Jn@vItEvBxCzDsKhRyDvI{BdI]xC~@jK",
            "yhe}FzwkD",
            "_dc}Fh|uDcDfIkFs@cFgB{AfAgB?uBeCMqByLlJgFiVqAi@~@yEFwo@{GgN}GqFiK{Qf@sBpa@yMAIvPuFeEr{@",
            "ukb}FrdmDeBgJxBoc@_Cs@pAaOfGFjEeB`E_JyDsO~D{G^uEjAgB`EeBpBzDxGmErArDxBrD~BuErFYlAbDp@xGe@fFk@xJsCzRsDza@XvJgIcAyAjZsFwBsIeI_BrDmJ}D_A`C",
            "cpf}FncoDuGeVaInO{Dxb@iGfJcExAmRgHmKzEoARb@tFtD`Qb@hRqAfTaAlG^bAhGQ~I}G^nFu@jJt@bJvE|BnB~BhHgSnB{@cA}A[_JrDiWxMij@zAg^",
            "cah}FbbfDOhEdBvM|Dn\\b@xA}FjFyBJ_@cA_AbAH{HwE_MyEgS",
            "keg}FftgD",
            "q_j}FzgnDwYpF{PvBcGNxAe_@T{p@Ius@bPfLlKfDhK\\Idn@^`P",
            "qya}Fd{nD}Ay@_AmBcBeAu@}DuA\\{FGmBeBo@L]l@Q|@}@\\sAc@eHhAeBmAUcBi@o@_@Fa@r@ZX}T|f@uM`HGS}RhJrNnq@vRqGZwA\\Uh@Hf@\\Rr@?VhWcIbFuGdPud@CC",
            "}jb}Fl_iDoGoAmR`e@~A|AsArDfRtWj@pCv@z@tA`@j@{FfG?~DgBfEoJyFqUvA}JoAsFkFoD",
            "yeb}FhdxDd@k@f@oA[sE_@wCYaE_@_DI_C_BiC_AiCLm@Em@u@a@a@FQ?]a@cDiE{BaC_A{@GaA[i@a@GYIc@H}@_Fg@yCk@UcD`IgAdA{BfC_BxBqBrDmC`F_BtC_@lASpCYpG?`GXdI|EbEJzCLzDjAfBrBrApAHxCdBxAvBXtAeAdAmA|ANdBbAj@rAr@jAE~@iBrAaCE}AiAcACuERuFjAyCfByCdAkDlDGrEMxDK",
            "e}_}Fx_pDq@_Ac@?_Ap@g@l@HfAH`@hAlCCp@[jD`@pCbB~BnBzCr@|AlB~@nCi@jCyCDiCHiCkB_CyFeGoEiG",
            "uyb}FlpjD",
            "{fc}FfcjD}OqN`@KrIgZlCqCjAeDx@oDrLgVvRdUeHjWcG}A",
            "cyc}FjtkDjBlEpGgKv]~CTgH{@?gAaA_@cCoReX",
            "_l`}Fh`qDv@r@jA{BbC|CiAvBdH`JfAtBlAnCpBpCk@rBcGuGgLmOBeBQ]",
            "mce}FhxjDpKwKgIoZmGuRkHk^_UoOuNrr@tK`GrHfJxDxNlHK|HrH",
            "shf}FnlgDoLeE_CaBcH\\qSdRsFxEqBLZdBfVzp@dI`E~F{XF@",
            "{mb}FnzkDp@{O",
            "cie}FnqmDeEwQk@cHaE_JyGeIeGcHsGs@_B`G_DjWmD`Y~A|Pr@dE~AYr@qCjHwBxB}Ar@nBrTmL"
        ]
        
        
        MapManager.shared.cities = [sao_paulo, zaragoza]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCoveredLocation(){
        let interactor = MainScreenInteractor()
        var currentUserLocation = CLLocation(latitude: -23.596178, longitude: -46.685045)
        //test Covered location
        XCTAssertEqual(interactor.checkIfLocationIsCovered(location: currentUserLocation), true)
        //test uncovered location
        currentUserLocation = CLLocation(latitude: 37.331705, longitude: -122.030237)
        XCTAssertEqual(interactor.checkIfLocationIsCovered(location: currentUserLocation), false)

    }
    

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
