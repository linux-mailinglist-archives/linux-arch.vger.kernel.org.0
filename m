Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F127C4C59E1
	for <lists+linux-arch@lfdr.de>; Sun, 27 Feb 2022 08:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiB0HPf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Feb 2022 02:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiB0HPe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Feb 2022 02:15:34 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812263916F
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 23:14:58 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id d3so10694535wrf.1
        for <linux-arch@vger.kernel.org>; Sat, 26 Feb 2022 23:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=90kXYm1owo7qWdzuK1U2wb5jgDZDFqJf+7rU5xFdf+8=;
        b=M0jmqvupd2d1MK67C/3sFVhHhA6GR+ckG54pyQFuXGhDLs+/v7NBAGc0tRkUyyi3AL
         cwBS7b/Sz51EdQEqgL4E+UrZf0eDkQhHXBS1MR9kL4tWWn+y+DJe1X0KzrhcBFZdWpe2
         R2xPGxOBOWiVnsQ7kVPSR+k2bt4Dvco/6imAGNgiquxojJwE0iyMAPHk09t8huNzDvo4
         DamUC4+CMhMjBidWFMlRV5DDd5MDzK8za5VBdMhMYFS4CJ3PJNMy0Q5revDhrzEmhPWG
         L+v/QaMQ8Ra+EoEFpc+NR8ZLUtFiZP1pqUfQ/fiE6fJAAr9PeO6CUdOHVhsb0+zEd5Cz
         cY0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=90kXYm1owo7qWdzuK1U2wb5jgDZDFqJf+7rU5xFdf+8=;
        b=pVeexQYzsQVjzl7dhLo1lK58JnkV7lQYorMX9BDKIXv4F2YUff41X0Nv7utd82+i/b
         UsJCYvH1Ey7XT8gudXwdtMKGVV7uDKAeYyMOVdOiOYjeYk6gI2iJQaWu6FUijbmPrVa7
         txopeniGM5ABIoVHLSGhRrJYG9m0uzGaOlGdKemK1s6MAAfWDgLPPau2KnatDXufbn66
         DeisY+UIs8IJVvhV8pglC/pB4GUddeahC3F0r1jRFQ+VAuXF/zeXCywOJtSwn8aj9+vR
         0uvMtImPzq8a1VtADFpSF/X1XbWAkkOQWirhk00KrmcBdQdd241CkteiMYIA4hdzrXcJ
         W+gw==
X-Gm-Message-State: AOAM532p7Ii2XcwZo++MuvclxF9HbXSZ98dG5j4W3mcO4vu/bQ/HucOS
        qgxCq+4rj7wXwxQRNVuj+idC9wGzp88tg+FCZ5oso2rNO5YFdVHE
X-Google-Smtp-Source: ABdhPJzks0kirinf8Q3Pdp1TXKnX+DmiSKXvWIAHwVRTpT2SdTc0CMsYZieThPcRqUVKKPgeSom0U2MAhVK8CTzjobo=
X-Received: by 2002:adf:c10b:0:b0:1ed:c40f:7f91 with SMTP id
 r11-20020adfc10b000000b001edc40f7f91mr11642166wre.276.1645946096398; Sat, 26
 Feb 2022 23:14:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:ba0e:0:0:0:0:0 with HTTP; Sat, 26 Feb 2022 23:14:55
 -0800 (PST)
Reply-To: cristinacampel@outlook.com
From:   "Mrs. Cristina Campbell" <fmatt413@gmail.com>
Date:   Sun, 27 Feb 2022 07:14:55 +0000
Message-ID: <CABC1E-ZJBdwNWUpQMLUQCoRSVK8wLWjo2QY6s7Km6_TGcp=-=w@mail.gmail.com>
Subject: =?UTF-8?B?Q3p5IG1vxbxlc3ogbWkgcG9tw7NjPw==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [fmatt413[at]gmail.com]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:42f listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [fmatt413[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  1.5 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Drodzy Umi=C5=82owani,

Przeczytaj to powoli i uwa=C5=BCnie, poniewa=C5=BC mo=C5=BCe to by=C4=87 je=
den z
najwa=C5=BCniejszych e-maili, jakie kiedykolwiek dostaniesz. Nazywam si=C4=
=99
Cristina Campbell, by=C5=82am =C5=BCon=C4=85 zmar=C5=82ego Edwarda Campbell=
a. Pracowa=C5=82 w
Shell Petroleum Development Company London i by=C5=82 r=C3=B3wnie=C5=BC do=
=C5=9Bwiadczony
wykonawca w regionie Azji Wschodniej. Zmar=C5=82 w czwartek 31 lipca 2003
r. w Pary=C5=BCu. Byli=C5=9Bmy ma=C5=82=C5=BCe=C5=84stwem przez siedem lat =
bez dziecka.

Czytaj=C4=85c to, nie chc=C4=99, =C5=BCeby=C5=9B mi wsp=C3=B3=C5=82czu=C5=
=82a, poniewa=C5=BC wierz=C4=99, =C5=BCe kiedy=C5=9B
wszyscy umr=C4=85. Zdiagnozowano u mnie raka prze=C5=82yku i m=C3=B3j lekar=
z
powiedzia=C5=82 mi, =C5=BCe nie wytrzymam d=C5=82ugo z powodu moich skompli=
kowanych
problem=C3=B3w zdrowotnych.

Chc=C4=99, aby B=C3=B3g by=C5=82 dla mnie mi=C5=82osierny i przyj=C4=85=C5=
=82 moj=C4=85 dusz=C4=99, wi=C4=99c
postanowi=C5=82am dawa=C4=87 ja=C5=82mu=C5=BCn=C4=99 organizacjom
charytatywnym/ko=C5=9Bcio=C5=82om/=C5=9Bwi=C4=85tyniom buddyjskim/meczetom/=
dzieciom bez
matki/mniej uprzywilejowanych i wdowom, poniewa=C5=BC chc=C4=99, aby to by=
=C5=82
jeden z ostatnich dobrych uczynk=C3=B3w Robi=C4=99 to na ziemi, zanim umr=
=C4=99. Do
tej pory rozdawa=C5=82em pieni=C4=85dze niekt=C3=B3rym organizacjom charyta=
tywnym w
Szkocji, Walii, Panamie, Finlandii i Grecji. Teraz, kiedy moje zdrowie
tak bardzo si=C4=99 pogorszy=C5=82o, nie mog=C4=99 ju=C5=BC tego robi=C4=87=
.

Kiedy=C5=9B poprosi=C5=82am cz=C5=82onk=C3=B3w rodziny, aby zamkn=C4=99li j=
edno z moich kont i
przekazali pieni=C4=85dze, kt=C3=B3re tam mam, na organizacje charytatywne =
w
Danii, Polsce, Niemczech, W=C5=82oszech i Szwajcarii, odm=C3=B3wili i zatrz=
ymali
pieni=C4=85dze dla siebie. Dlatego nie ufam im wi=C4=99cej, poniewa=C5=BC w=
ydaje si=C4=99,
=C5=BCe nie maj=C4=85 do czynienia z tym, co im zostawi=C5=82em. Ostatnie z=
 moich
pieni=C4=99dzy, o kt=C3=B3rych nikt nie wie, to ogromny depozyt got=C3=B3wk=
owy w
wysoko=C5=9Bci 6 milion=C3=B3w dolar=C3=B3w ameryka=C5=84skich, kt=C3=B3ry =
mam w banku w
Tajlandii, gdzie zdeponowa=C5=82em fundusz. Chc=C4=99, =C5=BCeby=C5=9B wyko=
rzysta=C5=82 ten
fundusz na programy charytatywne i wspiera=C5=82 ludzko=C5=9B=C4=87 w swoim=
 kraju,
je=C5=9Bli tylko b=C4=99dziesz szczery.

Podj=C4=99=C5=82am t=C4=99 decyzj=C4=99, bo nie mam dziecka, kt=C3=B3re odz=
iedziczy te
pieni=C4=85dze, nie boj=C4=99 si=C4=99 =C5=9Bmierci st=C4=85d wiem dok=C4=
=85d id=C4=99. Wiem, =C5=BCe b=C4=99d=C4=99 na
=C5=82onie Pana. Jak tylko otrzymam Twoj=C4=85 odpowied=C5=BA, podam Ci kon=
takt z
Bankiem i wydam upowa=C5=BCnienie, kt=C3=B3re upowa=C5=BCni Ci=C4=99 jako p=
ierwotnego
beneficjenta tego funduszu do natychmiastowego rozpocz=C4=99cia programu
charytatywnego w Twoim kraju.

Tylko =C5=BCycie dla innych jest warte zachodu. Chc=C4=99, =C5=BCeby=C5=9B =
zawsze si=C4=99 za
mnie modli=C5=82. Ka=C5=BCda zw=C5=82oka w Twojej odpowiedzi da mi miejsce =
na
poszukiwanie innej osoby w tym samym celu. Je=C5=9Bli nie jeste=C5=9B
zainteresowany, przepraszam za kontakt. Mo=C5=BCesz si=C4=99 ze mn=C4=85 sk=
ontaktowa=C4=87
lub odpowiedzie=C4=87 na m=C3=B3j prywatny e-mail: (cristinacampel@outlook.=
com).

Dzi=C4=99ki,
Z powa=C5=BCaniem,
Pani Cristina Campbell
E-mail; cristinacampel@outlook.com
