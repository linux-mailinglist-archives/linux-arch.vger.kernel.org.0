Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C978C64F75B
	for <lists+linux-arch@lfdr.de>; Sat, 17 Dec 2022 04:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLQDah (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 16 Dec 2022 22:30:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiLQDag (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 16 Dec 2022 22:30:36 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14B5E26A99
        for <linux-arch@vger.kernel.org>; Fri, 16 Dec 2022 19:30:35 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id z26so6291525lfu.8
        for <linux-arch@vger.kernel.org>; Fri, 16 Dec 2022 19:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wfHIfp2PgzsPQXGTrZ1bDouqyU93n0zRql8slxBHk7o=;
        b=HRyi+WrAMBTb/wQaQGDQCXU8bfZEnhT5TFkJDWnE8WiWIdpI6TnIoU+VoZ6///rOWn
         VBdElP7jI06sCHXpJ/2UGxYTWAdmQbRKK0zCNVeh9PxJGdGxrxjl3tzla6sqWTiVjGt3
         vnVTYpfIaFTWlaEVLbXllugiXTBQnyk78ijc290dBsIaWnq5G0beeUWVjeER4yvZ4XLe
         vvCRG9WRv/QxaL/4YYhsDr90TRyMiJIIl/LAlLx+i9v4pRrtXdJs75cAR0mEKcJZo/xD
         B9r1ZGAxFLSk4Mtt3RQodmX0VQrn/CNvVp5LbDNlTLS8Pj46n1QDjKyhae6BE4XwwLVz
         suiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wfHIfp2PgzsPQXGTrZ1bDouqyU93n0zRql8slxBHk7o=;
        b=qlvvJP2ViUhQZmxGOM5w/Yac3LZXsIvembYbX3usEkvefUNj7jPj0g7bPAm85U/qSV
         wpncibKoaR/VLhHje5REAT0reYvcEMnZbBXr9AeSEvymc26VI0N+zMGqIQW7dm6lR0AY
         XtSW0HLUEDxMC4FlorunKDeoI0H9l4LDKpcA8ewpxE3T8qSQfKfSXuMDr7KAiJFdb3j8
         y7uSY4IF6562Gm8171IcKuBgfOChe632mywp2ycSmb3De18xGTkrwMZesZ/ArSf6LUl6
         FKLiTefdC1lurG+8flaztr6ZMSwjo37CwgERjlokO5tMCfpXE1MDly0svGIKOW4wca+A
         yAFw==
X-Gm-Message-State: ANoB5pkaffdCuF2UBrHO3jPEFNTglt5wcPGIG9xsFAdLfAJHBtVzG/kg
        CESCVb16SJ0sFhPiU80SEvWWVCTlKMUa+MWQLiA=
X-Google-Smtp-Source: AA0mqf5dbmzGjOMCdKmW8WQ3WKjjJJ0V17EL+WG5rzswhocJ8fWYbxgCj6cNQMpbFhu2jgfIBqhpOXfapoESpiKvmpk=
X-Received: by 2002:a05:6512:3907:b0:4aa:cd5c:4c52 with SMTP id
 a7-20020a056512390700b004aacd5c4c52mr26851626lfu.374.1671247833285; Fri, 16
 Dec 2022 19:30:33 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:651c:b27:0:0:0:0 with HTTP; Fri, 16 Dec 2022 19:30:32
 -0800 (PST)
Reply-To: mrstheresaheidi8@gmail.com
From:   "Ms. Theresa Heidi" <ogunbayobabatunde2020@gmail.com>
Date:   Fri, 16 Dec 2022 19:30:32 -0800
Message-ID: <CACe_CMuqJph6xLLQnHdY+GROairfZTsLpsKEEq2reXVW4w2NCg@mail.gmail.com>
Subject: =?UTF-8?B?5oCl5LqL5rGC5Yqp?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: Yes, score=7.7 required=5.0 tests=BAYES_99,BAYES_999,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:134 listed in]
        [list.dnswl.org]
        *  3.5 BAYES_99 BODY: Bayes spam probability is 99 to 100%
        *      [score: 1.0000]
        *  0.2 BAYES_999 BODY: Bayes spam probability is 99.9 to 100%
        *      [score: 1.0000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [ogunbayobabatunde2020[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [ogunbayobabatunde2020[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrstheresaheidi8[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

5oWI5ZaE5o2Q5qy+77yBDQoNCuivt+S7lOe7humYheivu++8jOaIkeefpemBk+i/meWwgeS/oeeh
ruWunuWPr+iDveS8mue7meS9oOS4gOS4quaDiuWWnOOAgiDmiJHlnKjpnIDopoHkvaDluK7liqnn
moTml7blgJnpgJrov4fnp4HkurrmkJzntKLpgYfliLDkuobkvaDnmoTnlLXlrZDpgq7ku7bogZTn
s7vjgIINCuaIkeaAgOedgOayiemHjeeahOaCsuS8pOWGmei/meWwgemCruS7tue7meS9oO+8jOaI
kemAieaLqemAmui/h+S6kuiBlOe9keS4juS9oOiBlOezu++8jOWboOS4uuWug+S7jeeEtuaYr+ac
gOW/q+eahOayn+mAmuWqkuS7i+OAgg0KDQrmiJHmmK82MuWygeeahOeJueiVvuiOjirmtbfokoLl
pKvkurrvvIznm67liY3lm6DogrrnmYzlnKjku6XoibLliJfnmoTkuIDlrrbnp4Hnq4vljLvpmaLk
vY/pmaLmsrvnlpfjgIINCjTlubTliY3vvIzmiJHnmoTkuIjlpKvljrvkuJblkI7vvIzmiJHnq4vl
jbPooqvor4rmlq3lh7rmgqPmnInogrrnmYzvvIzku5bmiorku5bmiYDmnInnmoTkuIDliIfpg73n
lZnnu5nkuobmiJHjgIIg5oiR5bim552A5oiR55qE56yU6K6w5pys55S16ISR5Zyo5LiA5a625Yy7
6Zmi6YeM77yM5oiR5LiA55u05Zyo5o6l5Y+X6IK66YOo55mM55eH55qE5rK755aX44CCDQoNCuaI
keS7juaIkeW3suaVheeahOS4iOWkq+mCo+mHjOe7p+aJv+S6huS4gOeslOi1hOmHke+8jOWPquac
ieS4gOeZvuS4h+S6jOWNgeS4h+e+juWFg++8iDEsMjAwLDAwMCwwMOe+juWFg++8ieOAgueOsOWc
qOW+iOaYjuaYvu+8jOaIkeato+WcqOaOpei/keeUn+WRveeahOacgOWQjuWHoOWkqe+8jOaIkeiu
pOS4uuaIkeS4jeWGjemcgOimgei/meeslOmSseS6huOAgg0K5oiR55qE5Yy755Sf6K6p5oiR5piO
55m977yM55Sx5LqO6IK655mM55qE6Zeu6aKY77yM5oiR5LiN5Lya5oyB57ut5LiA5bm044CCDQoN
Cui/meeslOmSsei/mOWcqOWbveWklumTtuihjO+8jOeuoeeQhuWxguS7peecn+ato+eahOS4u+S6
uueahOi6q+S7veWGmeS/oee7meaIke+8jOimgeaxguaIkeWHuumdouaUtumSse+8jOaIluiAheet
vuWPkeS4gOWwgeaOiOadg+S5pu+8jOiuqeWIq+S6uuS7o+aIkeaUtumSse+8jOWboOS4uuaIkeeU
n+eXheS4jeiDvei/h+adpeOAgg0K5aaC5p6c5LiN6YeH5Y+W6KGM5Yqo77yM6ZO26KGM5Y+v6IO9
5Lya5Zug5Li65L+d5oyB6L+Z5LmI6ZW/5pe26Ze06ICM6KKr5rKh5pS26LWE6YeR44CCDQoNCuaI
keWGs+WumuS4juaCqOiBlOezu++8jOWmguaenOaCqOaEv+aEj+W5tuacieWFtOi2o+W4ruWKqeaI
keS7juWkluWbvemTtuihjOaPkOWPlui/meeslOmSse+8jOeEtuWQjuWwhui1hOmHkeeUqOS6juaF
iOWWhOS6i+S4mu+8jOW4ruWKqeW8seWKv+e+pOS9k+OAgg0K5oiR6KaB5L2g5Zyo5oiR5Ye65LqL
5LmL5YmN55yf6K+a5Zyw5aSE55CG6L+Z5Lqb5L+h5omY5Z+66YeR44CCIOi/meS4jeaYr+S4gOes
lOiiq+ebl+eahOmSse+8jOS5n+ayoeaciea2ieWPiueahOWNsemZqeaYrzEwMCXnmoTpo47pmanl
hY3otLnkuI7lhYXliIbnmoTms5Xlvovor4HmmI7jgIINCg0K5oiR6KaB5L2g5ou/NDUl55qE6ZKx
57uZ5L2g5Liq5Lq65L2/55So77yM6ICMNTUl55qE6ZKx5bCG55So5LqO5oWI5ZaE5bel5L2c44CC
DQrmiJHlsIbmhJ/osKLkvaDlnKjov5nku7bkuovkuIrmnIDlpKfnmoTkv6Hku7vlkozkv53lr4bv
vIzku6Xlrp7njrDmiJHlhoXlv4PnmoTmhL/mnJvvvIzlm6DkuLrmiJHkuI3mg7PopoHku7vkvZXk
vJrljbHlj4rmiJHmnIDlkI7nmoTmhL/mnJvnmoTkuJzopb/jgIINCuaIkeW+iOaKseatie+8jOWm
guaenOaCqOaUtuWIsOi/meWwgeS/oeWcqOaCqOeahOWeg+WcvumCruS7tu+8jOaYr+eUseS6juac
gOi/keeahOi/nuaOpemUmeivr+WcqOi/memHjOeahOWbveWutuOAgg0KDQrkvaDkurLniLHnmoTl
prnlprnjgIINCueJueiVvuiOjirmtbfokoLlpKvkuroNCg==
