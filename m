Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82214537227
	for <lists+linux-arch@lfdr.de>; Sun, 29 May 2022 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbiE2SVB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 May 2022 14:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbiE2SVA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 29 May 2022 14:21:00 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B241187A1E
        for <linux-arch@vger.kernel.org>; Sun, 29 May 2022 11:20:59 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q1so9644452ljb.5
        for <linux-arch@vger.kernel.org>; Sun, 29 May 2022 11:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QTCWBzEezgLv+Z2QZNvCkKQgrxXaSDur4w34RcJaRzY=;
        b=FO3/ulG4X3ue6zejopVqPuRhFiMJzqt4wHq7eOpaH9odrl4xZERbjfVx9SxD1yFLXU
         tEnrEDwLBfLpV1/yGvujdJy56R5VqdK7gqwHeJ3FxfvwrIQj9UwVj3egmkAEYdZHoxvF
         icWFpGXmNAV2p31HCi5ecDMJZWPITw7wJaKZ06eafgxNkkix9GeA4npZsMLoaLpMRUkh
         VFqvcQ3I/r6JrC39W6rFRAh1iYyC4S05BvG205QER8gfBW7rE/Hkbw7tZTmUY6bwtQ7L
         Cpd+yuyGEkMDy15tnXqKL/TwmyT3rJ/tQDaD4+068Q/1mGAxdV3xedOUoZ1+i7jAuFqs
         wldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=QTCWBzEezgLv+Z2QZNvCkKQgrxXaSDur4w34RcJaRzY=;
        b=ilMXe5oOTWG+FqquLniOoXNxZgcWEc08yZu/YYZdCDf5UqqXCyLV6iNhdsYdDSOMWK
         gxNzs2DQOR3nPshSjh2KhAxeNWHg+IJGcB0EQU4JlgCXcVhLg4AJRovLuLv2bO8f6ps0
         FqciwAUjvhZqKJ/bu6XCywTkwv3hLKVve+pP+ut+5jN1Zc8g4ULYfm1KPG1RQ1Re0Lly
         kZYa49uEkf/hnyAKeKl9KJXC5bFCAMbsa7oxh7duYAOi7RvU7zZmzsLlz+PX249gPjx6
         ExX2BFhBvZzditNVdSF9SFgMP7zZTgNGdXDqFpYbyZnrZ0q5Qp0a2z02t8jVfhTsTHmW
         Ba5w==
X-Gm-Message-State: AOAM530XpR781rvtbi4Mt4aNHcTBNm2ST1bYHF87ZjLMmuSxlriLC0uH
        fAT6ADwhvtcpNbIoQ7lXnd4ItKokJVzgeGm2+d8=
X-Google-Smtp-Source: ABdhPJyyPrNjj0796eHbxo1P8AN3ZVS2CHPr/lgfPsGJ3D9I8uQMvjtRI27M+0Jfc29uYsg987cRChK3ykbnXxywu9o=
X-Received: by 2002:a2e:87c6:0:b0:255:49a4:3bf5 with SMTP id
 v6-20020a2e87c6000000b0025549a43bf5mr4128212ljj.447.1653848458049; Sun, 29
 May 2022 11:20:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6504:1b8d:b0:1cd:988f:3318 with HTTP; Sun, 29 May 2022
 11:20:57 -0700 (PDT)
Reply-To: illuminatifame157@gmail.com
From:   illuminati <yusufabawa2@gmail.com>
Date:   Sun, 29 May 2022 11:20:57 -0700
Message-ID: <CAARX4173tgR_Ds0tH=y-Orcd7+=Yfr9awaSEkSaN5LEx2+AYZw@mail.gmail.com>
Subject: illuminati
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:234 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [yusufabawa2[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [yusufabawa2[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatifame157[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

--=20
WILLKOMMEN BEI DER ILLUMINATI BROTHERHOOD ORGANISATION, einem Club der
Reichen und Ber=C3=BChmten, ist die =C3=A4lteste und gr=C3=B6=C3=9Fte Brude=
rschaft der
Welt und besteht aus 3 Millionen Mitgliedern. Wir sind eine gro=C3=9Fe
Familie unter einem Vater, der das h=C3=B6chste Wesen ist. GOTT
. Ich glaube, wir alle haben einen Traum, einen Traum, etwas Gro=C3=9Fes im
Leben zu werden, so viele Menschen sterben heute, ohne ihre Tr=C3=A4ume zu
verwirklichen. Einige von uns sind dazu bestimmt, Pr=C3=A4sident unserer
verschiedenen L=C3=A4nder zu werden oder zu werden. einer der weltbesten
Musiker, Fu=C3=9Fballer, Politiker, Gesch=C3=A4ftsmann, Komiker oder ein He=
lfer
f=C3=BCr andere Menschen zu sein, die in Not sind E.T.C. M=C3=B6chten Sie
Mitglied dieser gro=C3=9Fartigen Organisation werden und Ihren ersten
Vorteil von 1.000.000 Euro erhalten? Wenn JA, antworten Sie bitte auf
diese E-Mail: illuminatifame157@gmail.com oder WhatsApp the great
Grandmaster mit +12312246136
