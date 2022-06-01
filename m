Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F153A4B1
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350506AbiFAMRg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348712AbiFAMRd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:17:33 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E86FC5002C;
        Wed,  1 Jun 2022 05:17:29 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 5177E5C02B1;
        Wed,  1 Jun 2022 08:17:29 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:17:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654085849; x=
        1654172249; bh=NmcQVjutZvdTN75SNPwIsltqoItlYgd1ENRlUXjP0Xc=; b=M
        w/q59FbckTrWhQwZQ6nHFcy8TRaSe9A/GX93S1MD51F1lnSIWylq3Gppsz6UkmCP
        ayihOeMnOVj694QnTInuxTFGOwE38W3+QbkcFiOX0myj7POp2G65pVfNRcvuSjds
        UW1NXteaJHHqb1vSomiPNHAMPXRrPndZYBMzBvnVBxVwsPOeWaWbpHkIWrgxmrvJ
        3ILvM57G3jfwaRPor4TY5Xby4CH9Vez33TJfjIl8louB12Sxwmd0syKQOTW2Q/Td
        Fwvbw8pTVu8QiBAjvkd22rBICwx9T2EbiSYuXlMzRAl3BU5+VBJU30rhIkVDsBm+
        lLF/PCEfEy7/hrgyxhDvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654085849; x=
        1654172249; bh=NmcQVjutZvdTN75SNPwIsltqoItlYgd1ENRlUXjP0Xc=; b=J
        Kcz0kRBI4e1tQIq3Yt2xaWmELZowpHuraJ49oeuzR9Hi/9FKcLyaXMJhaVwdKp2W
        ACou6Y4CIXCqVRFAkHOGhJJsVOYTGEFeGjEbkBW9qUtOn8kthH76DRpOR4enRlmk
        3RLtfZaR2A9rdbQJMoky5b5wgA9gXZewHLQRCCwdwWlkZcUVSnS51Z65wbl4BeET
        4sHA1LzX8xRnwjc43ksckW+vAipjVOZZtHLElIMow7OruA0zQPybbF8ojDnxDosG
        7B1ZdT9O2SXxyp1poOb12H/AgTfHOiBVURxZVEvsvuQttxqiHdHFHTZqSQBtRCu0
        oVIEU4EorhGw1Nd+bsIaw==
X-ME-Sender: <xms:2FiXYvIHfNhoHGSbhv4I7Ov-FHguLsPKnGmN2Mghtru_UeFNnA0thw>
    <xme:2FiXYjLqABPLZjHKg7vd70hBrsPhJWvQd3JfcUwDL4HxKNzXoGvseRlKYD-n_kb5i
    Q1emA_CgEXRUNGeAFE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffvvefu
    tgfgsehtqhertderreejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirg
    iguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepgedv
    gefhuedtffeffefguddtveejleevueefffetvdfhgeeutedtteeghfehfeeinecuffhomh
    grihhnpehlohhonhhgshhonhdrtghnpdhlohhonhhgnhhigidrtghnpdhgihhthhhusgdr
    tghomhdpghhithhhuhgsrdhiohdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:2ViXYnv7RCPN1N3rBKbvOS-wWQFGd2V3bmwCt4MjEFgkjw9GsCJO2g>
    <xmx:2ViXYoYBl8J4UtHQQDEPe_qUuhqvo8zErGdpC_HCGiAxMrbVwrleNA>
    <xmx:2ViXYmbOdV24z0qspnbkmOW_ILrUqIbf2FtmZYAhHPXLpBxem6OPMA>
    <xmx:2ViXYou7hnYiPNd0vD8Si-ilcX1G0PmUxQjoJzHmjXPzaYnHYvV-bQ>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E62AD36A006D; Wed,  1 Jun 2022 08:17:28 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <c79d142c-07f9-4c29-bf00-a446f87d2dcb@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-5-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-5-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:17:07 +0100
From:   "Jiaxun Yang" <jiaxun.yang@flygoat.com>
To:     "Huacai Chen" <chenhuacai@loongson.cn>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "David Airlie" <airlied@linux.ie>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Linus Torvalds" <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, "Xuefeng Li" <lixuefeng@loongson.cn>,
        "Yanteng Si" <siyanteng@loongson.cn>,
        "Huacai Chen" <chenhuacai@gmail.com>,
        "Guo Ren" <guoren@kernel.org>, "Xuerui Wang" <kernel@xen0n.name>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>,
        "Alex Shi" <alexs@kernel.org>, "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 04/24] Documentation/zh_CN: Add basic LoongArch documentations
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



=E5=9C=A82022=E5=B9=B46=E6=9C=881=E6=97=A5=E5=85=AD=E6=9C=88 =E4=B8=8A=E5=
=8D=8810:59=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Add some basic documentation (zh_CN version) for LoongArch. LoongArch =
is
> a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch includes=
 a
> reduced 32-bit version (LA32R), a standard 32-bit version (LA32S) and a
> 64-bit version (LA64).
>
> Reviewed-by: Alex Shi <alexs@kernel.org>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Reviewed-by: Guo Ren <guoren@kernel.org>
> Co-developed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

It=E2=80=99s nice to see Chinese documents can be aligned at a timely ma=
nner.

Thanks
- Jiaxun

> ---
>  Documentation/translations/zh_CN/index.rst    |   1 +
>  .../translations/zh_CN/loongarch/features.rst |   8 +
>  .../translations/zh_CN/loongarch/index.rst    |  26 ++
>  .../zh_CN/loongarch/introduction.rst          | 351 ++++++++++++++++++
>  .../zh_CN/loongarch/irq-chip-model.rst        | 167 +++++++++
>  5 files changed, 553 insertions(+)
>  create mode 100644=20
> Documentation/translations/zh_CN/loongarch/features.rst
>  create mode 100644 Documentation/translations/zh_CN/loongarch/index.r=
st
>  create mode 100644=20
> Documentation/translations/zh_CN/loongarch/introduction.rst
>  create mode 100644=20
> Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
>
> diff --git a/Documentation/translations/zh_CN/index.rst=20
> b/Documentation/translations/zh_CN/index.rst
> index ac32d8e306ac..ad7bb8c17562 100644
> --- a/Documentation/translations/zh_CN/index.rst
> +++ b/Documentation/translations/zh_CN/index.rst
> @@ -171,6 +171,7 @@ TODOList:
>     riscv/index
>     openrisc/index
>     parisc/index
> +   loongarch/index
>=20
>  TODOList:
>=20
> diff --git a/Documentation/translations/zh_CN/loongarch/features.rst=20
> b/Documentation/translations/zh_CN/loongarch/features.rst
> new file mode 100644
> index 000000000000..3886e635ec06
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/features.rst
> @@ -0,0 +1,8 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/features.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +.. kernel-feat:: $srctree/Documentation/features loongarch
> diff --git a/Documentation/translations/zh_CN/loongarch/index.rst=20
> b/Documentation/translations/zh_CN/loongarch/index.rst
> new file mode 100644
> index 000000000000..7d23eb78379d
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/index.rst
> @@ -0,0 +1,26 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/index.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LoongArch=E4=BD=93=E7=B3=BB=E7=BB=93=E6=9E=84
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +.. toctree::
> +   :maxdepth: 2
> +   :numbered:
> +
> +   introduction
> +   irq-chip-model
> +
> +   features
> +
> +.. only::  subproject and html
> +
> +   Indices
> +   =3D=3D=3D=3D=3D=3D=3D
> +
> +   * :ref:`genindex`
> diff --git=20
> a/Documentation/translations/zh_CN/loongarch/introduction.rst=20
> b/Documentation/translations/zh_CN/loongarch/introduction.rst
> new file mode 100644
> index 000000000000..e31a1a928c48
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/introduction.rst
> @@ -0,0 +1,351 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/introduction.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LoongArch=E4=BB=8B=E7=BB=8D
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch=E6=98=AF=E4=B8=80=E7=A7=8D=E6=96=B0=E7=9A=84RISC ISA=EF=BC=8C=
=E5=9C=A8=E4=B8=80=E5=AE=9A=E7=A8=8B=E5=BA=A6=E4=B8=8A=E7=B1=BB=E4=BC=BC=
=E4=BA=8EMIPS=E5=92=8CRISC-V=E3=80=82LoongArch=E6=8C=87=E4=BB=A4=E9=9B=86
> +=E5=8C=85=E6=8B=AC=E4=B8=80=E4=B8=AA=E7=B2=BE=E7=AE=8032=E4=BD=8D=E7=89=
=88=EF=BC=88LA32R=EF=BC=89=E3=80=81=E4=B8=80=E4=B8=AA=E6=A0=87=E5=87=863=
2=E4=BD=8D=E7=89=88=EF=BC=88LA32S=EF=BC=89=E3=80=81=E4=B8=80=E4=B8=AA64=E4=
=BD=8D=E7=89=88=EF=BC=88LA64=EF=BC=89=E3=80=82
> +LoongArch=E5=AE=9A=E4=B9=89=E4=BA=86=E5=9B=9B=E4=B8=AA=E7=89=B9=E6=9D=
=83=E7=BA=A7=EF=BC=88PLV0~PLV3=EF=BC=89=EF=BC=8C=E5=85=B6=E4=B8=ADPLV0=E6=
=98=AF=E6=9C=80=E9=AB=98=E7=89=B9=E6=9D=83=E7=BA=A7=EF=BC=8C=E7=94=A8=E4=
=BA=8E=E5=86=85=E6=A0=B8=EF=BC=9B=E8=80=8CPLV3
> +=E6=98=AF=E6=9C=80=E4=BD=8E=E7=89=B9=E6=9D=83=E7=BA=A7=EF=BC=8C=E7=94=
=A8=E4=BA=8E=E5=BA=94=E7=94=A8=E7=A8=8B=E5=BA=8F=E3=80=82=E6=9C=AC=E6=96=
=87=E6=A1=A3=E4=BB=8B=E7=BB=8D=E4=BA=86LoongArch=E7=9A=84=E5=AF=84=E5=AD=
=98=E5=99=A8=E3=80=81=E5=9F=BA=E7=A1=80=E6=8C=87=E4=BB=A4=E9=9B=86=E3=80=
=81=E8=99=9A=E6=8B=9F=E5=86=85
> +=E5=AD=98=E4=BB=A5=E5=8F=8A=E5=85=B6=E4=BB=96=E4=B8=80=E4=BA=9B=E4=B8=
=BB=E9=A2=98=E3=80=82
> +
> +=E5=AF=84=E5=AD=98=E5=99=A8
> +=3D=3D=3D=3D=3D=3D
> +
> +LoongArch=E7=9A=84=E5=AF=84=E5=AD=98=E5=99=A8=E5=8C=85=E6=8B=AC=E9=80=
=9A=E7=94=A8=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=88GPRs=EF=BC=89=E3=80=81=E6=
=B5=AE=E7=82=B9=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=88FPRs=EF=BC=89=E3=80=81=
=E5=90=91=E9=87=8F=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=88VRs=EF=BC=89
> +=E5=92=8C=E7=94=A8=E4=BA=8E=E7=89=B9=E6=9D=83=E6=A8=A1=E5=BC=8F=EF=BC=
=88PLV0=EF=BC=89=E7=9A=84=E6=8E=A7=E5=88=B6=E7=8A=B6=E6=80=81=E5=AF=84=E5=
=AD=98=E5=99=A8=EF=BC=88CSRs=EF=BC=89=E3=80=82
> +
> +=E9=80=9A=E7=94=A8=E5=AF=84=E5=AD=98=E5=99=A8
> +----------
> +
> +LoongArch=E5=8C=85=E6=8B=AC32=E4=B8=AA=E9=80=9A=E7=94=A8=E5=AF=84=E5=AD=
=98=E5=99=A8=EF=BC=88 ``$r0`` ~ ``$r31`` =EF=BC=89=EF=BC=8CLA32=E4=B8=AD=
=E6=AF=8F=E4=B8=AA=E5=AF=84=E5=AD=98=E5=99=A8=E4=B8=BA32=E4=BD=8D=E5=AE=BD=
=EF=BC=8C
> +LA64=E4=B8=AD=E6=AF=8F=E4=B8=AA=E5=AF=84=E5=AD=98=E5=99=A8=E4=B8=BA64=
=E4=BD=8D=E5=AE=BD=E3=80=82 ``$r0`` =E7=9A=84=E5=86=85=E5=AE=B9=E6=80=BB=
=E6=98=AF=E5=9B=BA=E5=AE=9A=E4=B8=BA0=EF=BC=8C=E8=80=8C=E5=85=B6=E4=BB=96=
=E5=AF=84=E5=AD=98=E5=99=A8=E5=9C=A8=E4=BD=93=E7=B3=BB=E7=BB=93=E6=9E=84=
=E5=B1=82=E9=9D=A2
> +=E6=B2=A1=E6=9C=89=E7=89=B9=E6=AE=8A=E5=8A=9F=E8=83=BD=E3=80=82=EF=BC=
=88 ``$r1`` =E7=AE=97=E6=98=AF=E4=B8=80=E4=B8=AA=E4=BE=8B=E5=A4=96=EF=BC=
=8C=E5=9C=A8BL=E6=8C=87=E4=BB=A4=E4=B8=AD=E5=9B=BA=E5=AE=9A=E7=94=A8=E4=BD=
=9C=E9=93=BE=E6=8E=A5=E8=BF=94=E5=9B=9E=E5=AF=84=E5=AD=98=E5=99=A8=E3=80=
=82=EF=BC=89
> +
> +=E5=86=85=E6=A0=B8=E4=BD=BF=E7=94=A8=E4=BA=86=E4=B8=80=E5=A5=97LoongA=
rch=E5=AF=84=E5=AD=98=E5=99=A8=E7=BA=A6=E5=AE=9A=EF=BC=8C=E5=AE=9A=E4=B9=
=89=E5=9C=A8LoongArch ELF psABI=E8=A7=84=E8=8C=83=E4=B8=AD=EF=BC=8C=E8=AF=
=A6=E7=BB=86=E6=8F=8F=E8=BF=B0=E5=8F=82=E8=A7=81
> +:ref:`=E5=8F=82=E8=80=83=E6=96=87=E7=8C=AE <loongarch-references-zh_C=
N>`:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=AF=84=E5=AD=98=E5=99=A8=E5=90=8D          =E5=88=AB=E5=90=8D     =
       =E7=94=A8=E9=80=94                =E8=B7=A8=E8=B0=83=E7=94=A8=E4=BF=
=9D=E6=8C=81
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``$r0``           ``$zero``       =E5=B8=B8=E9=87=8F0               =E4=
=B8=8D=E4=BD=BF=E7=94=A8
> +``$r1``           ``$ra``         =E8=BF=94=E5=9B=9E=E5=9C=B0=E5=9D=80=
            =E5=90=A6
> +``$r2``           ``$tp``         TLS/=E7=BA=BF=E7=A8=8B=E4=BF=A1=E6=81=
=AF=E6=8C=87=E9=92=88    =E4=B8=8D=E4=BD=BF=E7=94=A8
> +``$r3``           ``$sp``         =E6=A0=88=E6=8C=87=E9=92=88        =
      =E6=98=AF
> +``$r4``-``$r11``  ``$a0``-``$a7`` =E5=8F=82=E6=95=B0=E5=AF=84=E5=AD=98=
=E5=99=A8          =E5=90=A6
> +``$r4``-``$r5``   ``$v0``-``$v1`` =E8=BF=94=E5=9B=9E=E5=80=BC        =
      =E5=90=A6
> +``$r12``-``$r20`` ``$t0``-``$t8`` =E4=B8=B4=E6=97=B6=E5=AF=84=E5=AD=98=
=E5=99=A8          =E5=90=A6
> +``$r21``          ``$u0``         =E6=AF=8FCPU=E5=8F=98=E9=87=8F=E5=9F=
=BA=E5=9C=B0=E5=9D=80     =E4=B8=8D=E4=BD=BF=E7=94=A8
> +``$r22``          ``$fp``         =E5=B8=A7=E6=8C=87=E9=92=88        =
      =E6=98=AF
> +``$r23``-``$r31`` ``$s0``-``$s8`` =E9=9D=99=E6=80=81=E5=AF=84=E5=AD=98=
=E5=99=A8          =E6=98=AF
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=B3=A8=E6=84=8F=EF=BC=9A``$r21``=E5=AF=84=E5=AD=98=E5=99=A8=E5=9C=A8=
ELF psABI=E4=B8=AD=E4=BF=9D=E7=95=99=E6=9C=AA=E4=BD=BF=E7=94=A8=EF=BC=8C=
=E4=BD=86=E6=98=AF=E5=9C=A8Linux=E5=86=85=E6=A0=B8=E7=94=A8=E4=BA=8E=E4=BF=
=9D=E5=AD=98=E6=AF=8FCPU
> +=E5=8F=98=E9=87=8F=E5=9F=BA=E5=9C=B0=E5=9D=80=E3=80=82=E8=AF=A5=E5=AF=
=84=E5=AD=98=E5=99=A8=E6=B2=A1=E6=9C=89ABI=E5=91=BD=E5=90=8D=EF=BC=8C=E4=
=B8=8D=E8=BF=87=E5=9C=A8=E5=86=85=E6=A0=B8=E4=B8=AD=E7=A7=B0=E4=B8=BA``$=
u0``=E3=80=82=E5=9C=A8=E4=B8=80=E4=BA=9B=E9=81=97=E7=95=99=E4=BB=A3=E7=A0=81
> +=E4=B8=AD=E6=9C=89=E6=97=B6=E5=8F=AF=E8=83=BD=E8=A7=81=E5=88=B0``$v0`=
`=E5=92=8C``$v1``=EF=BC=8C=E5=AE=83=E4=BB=AC=E6=98=AF``$a0``=E5=92=8C``$=
a1``=E7=9A=84=E5=88=AB=E5=90=8D=EF=BC=8C=E5=B1=9E=E4=BA=8E=E5=B7=B2=E7=BB=
=8F=E5=BA=9F=E5=BC=83
> +=E7=9A=84=E7=94=A8=E6=B3=95=E3=80=82
> +
> +=E6=B5=AE=E7=82=B9=E5=AF=84=E5=AD=98=E5=99=A8
> +----------
> +
> +=E5=BD=93=E7=B3=BB=E7=BB=9F=E4=B8=AD=E5=AD=98=E5=9C=A8FPU=E6=97=B6=EF=
=BC=8CLoongArch=E6=9C=8932=E4=B8=AA=E6=B5=AE=E7=82=B9=E5=AF=84=E5=AD=98=E5=
=99=A8=EF=BC=88 ``$f0`` ~ ``$f31`` =EF=BC=89=E3=80=82=E5=9C=A8LA64
> +=E7=9A=84CPU=E6=A0=B8=E4=B8=8A=EF=BC=8C=E6=AF=8F=E4=B8=AA=E5=AF=84=E5=
=AD=98=E5=99=A8=E5=9D=87=E4=B8=BA64=E4=BD=8D=E5=AE=BD=E3=80=82
> +
> +=E6=B5=AE=E7=82=B9=E5=AF=84=E5=AD=98=E5=99=A8=E7=9A=84=E4=BD=BF=E7=94=
=A8=E7=BA=A6=E5=AE=9A=E4=B8=8ELoongArch ELF psABI=E8=A7=84=E8=8C=83=E7=9A=
=84=E6=8F=8F=E8=BF=B0=E7=9B=B8=E5=90=8C=EF=BC=9A
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=AF=84=E5=AD=98=E5=99=A8=E5=90=8D          =E5=88=AB=E5=90=8D     =
          =E7=94=A8=E9=80=94                =E8=B7=A8=E8=B0=83=E7=94=A8=E4=
=BF=9D=E6=8C=81
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``$f0``-``$f7``   ``$fa0``-``$fa7``  =E5=8F=82=E6=95=B0=E5=AF=84=E5=AD=
=98=E5=99=A8          =E5=90=A6
> +``$f0``-``$f1``   ``$fv0``-``$fv1``  =E8=BF=94=E5=9B=9E=E5=80=BC     =
         =E5=90=A6
> +``$f8``-``$f23``  ``$ft0``-``$ft15`` =E4=B8=B4=E6=97=B6=E5=AF=84=E5=AD=
=98=E5=99=A8          =E5=90=A6
> +``$f24``-``$f31`` ``$fs0``-``$fs7``  =E9=9D=99=E6=80=81=E5=AF=84=E5=AD=
=98=E5=99=A8          =E6=98=AF
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=B3=A8=E6=84=8F=EF=BC=9A=E5=9C=A8=E4=B8=80=E4=BA=9B=E9=81=97=E7=95=
=99=E4=BB=A3=E7=A0=81=E4=B8=AD=E6=9C=89=E6=97=B6=E5=8F=AF=E8=83=BD=E8=A7=
=81=E5=88=B0 ``$v0`` =E5=92=8C ``$v1`` =EF=BC=8C=E5=AE=83=E4=BB=AC=E6=98=
=AF ``$a0``
> +=E5=92=8C ``$a1`` =E7=9A=84=E5=88=AB=E5=90=8D=EF=BC=8C=E5=B1=9E=E4=BA=
=8E=E5=B7=B2=E7=BB=8F=E5=BA=9F=E5=BC=83=E7=9A=84=E7=94=A8=E6=B3=95=E3=80=82
> +
> +
> +=E5=90=91=E9=87=8F=E5=AF=84=E5=AD=98=E5=99=A8
> +----------
> +
> +LoongArch=E7=8E=B0=E6=9C=89=E4=B8=A4=E7=A7=8D=E5=90=91=E9=87=8F=E6=89=
=A9=E5=B1=95=EF=BC=9A
> +
> +- 128=E4=BD=8D=E5=90=91=E9=87=8F=E6=89=A9=E5=B1=95LSX=EF=BC=88=E5=85=A8=
=E7=A7=B0Loongson SIMD eXtention=EF=BC=89=EF=BC=8C
> +- 256=E4=BD=8D=E5=90=91=E9=87=8F=E6=89=A9=E5=B1=95LASX=EF=BC=88=E5=85=
=A8=E7=A7=B0Loongson Advanced SIMD eXtention=EF=BC=89=E3=80=82
> +
> +LSX=E4=BD=BF=E7=94=A8 ``$v0`` ~ ``$v31`` =E5=90=91=E9=87=8F=E5=AF=84=E5=
=AD=98=E5=99=A8=EF=BC=8C=E8=80=8CLASX=E5=88=99=E4=BD=BF=E7=94=A8 ``$x0``=
 ~ ``$x31`` =E3=80=82
> +
> +=E6=B5=AE=E7=82=B9=E5=AF=84=E5=AD=98=E5=99=A8=E5=92=8C=E5=90=91=E9=87=
=8F=E5=AF=84=E5=AD=98=E5=99=A8=E6=98=AF=E5=A4=8D=E7=94=A8=E7=9A=84=EF=BC=
=8C=E6=AF=94=E5=A6=82=EF=BC=9A=E5=9C=A8=E4=B8=80=E4=B8=AA=E5=AE=9E=E7=8E=
=B0=E4=BA=86LSX=E5=92=8CLASX=E7=9A=84=E6=A0=B8=E4=B8=8A=EF=BC=8C ``$x0``=
 =E7=9A=84
> +=E4=BD=8E128=E4=BD=8D=E4=B8=8E ``$v0`` =E5=85=B1=E7=94=A8=EF=BC=8C ``=
$v0`` =E7=9A=84=E4=BD=8E64=E4=BD=8D=E4=B8=8E ``$f0`` =E5=85=B1=E7=94=A8=EF=
=BC=8C=E5=85=B6=E4=BB=96=E5=AF=84=E5=AD=98=E5=99=A8=E4=BE=9D=E6=AD=A4=E7=
=B1=BB=E6=8E=A8=E3=80=82
> +
> +=E6=8E=A7=E5=88=B6=E7=8A=B6=E6=80=81=E5=AF=84=E5=AD=98=E5=99=A8
> +--------------
> +
> +=E6=8E=A7=E5=88=B6=E7=8A=B6=E6=80=81=E5=AF=84=E5=AD=98=E5=99=A8=E5=8F=
=AA=E8=83=BD=E5=9C=A8=E7=89=B9=E6=9D=83=E6=A8=A1=E5=BC=8F=EF=BC=88PLV0=EF=
=BC=89=E4=B8=8B=E8=AE=BF=E9=97=AE:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=9C=B0=E5=9D=80              =E5=85=A8=E7=A7=B0=E6=8F=8F=E8=BF=B0 =
                            =E7=AE=80=E7=A7=B0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0x0               =E5=BD=93=E5=89=8D=E6=A8=A1=E5=BC=8F=E4=BF=A1=E6=81=
=AF                         CRMD
> +0x1               =E5=BC=82=E5=B8=B8=E5=89=8D=E6=A8=A1=E5=BC=8F=E4=BF=
=A1=E6=81=AF                       PRMD
> +0x2               =E6=89=A9=E5=B1=95=E9=83=A8=E4=BB=B6=E4=BD=BF=E8=83=
=BD                         EUEN
> +0x3               =E6=9D=82=E9=A1=B9=E6=8E=A7=E5=88=B6               =
              MISC
> +0x4               =E5=BC=82=E5=B8=B8=E9=85=8D=E7=BD=AE               =
              ECFG
> +0x5               =E5=BC=82=E5=B8=B8=E7=8A=B6=E6=80=81               =
              ESTAT
> +0x6               =E5=BC=82=E5=B8=B8=E8=BF=94=E5=9B=9E=E5=9C=B0=E5=9D=
=80                         ERA
> +0x7               =E5=87=BA=E9=94=99(Faulting)=E8=99=9A=E6=8B=9F=E5=9C=
=B0=E5=9D=80               BADV
> +0x8               =E5=87=BA=E9=94=99(Faulting)=E6=8C=87=E4=BB=A4=E5=AD=
=97                 BADI
> +0xC               =E5=BC=82=E5=B8=B8=E5=85=A5=E5=8F=A3=E5=9C=B0=E5=9D=
=80                         EENTRY
> +0x10              TLB=E7=B4=A2=E5=BC=95                              =
TLBIDX
> +0x11              TLB=E8=A1=A8=E9=A1=B9=E9=AB=98=E4=BD=8D            =
              TLBEHI
> +0x12              TLB=E8=A1=A8=E9=A1=B9=E4=BD=8E=E4=BD=8D0           =
              TLBELO0
> +0x13              TLB=E8=A1=A8=E9=A1=B9=E4=BD=8E=E4=BD=8D1           =
              TLBELO1
> +0x18              =E5=9C=B0=E5=9D=80=E7=A9=BA=E9=97=B4=E6=A0=87=E8=AF=
=86=E7=AC=A6                       ASID
> +0x19              =E4=BD=8E=E5=8D=8A=E5=9C=B0=E5=9D=80=E7=A9=BA=E9=97=
=B4=E9=A1=B5=E5=85=A8=E5=B1=80=E7=9B=AE=E5=BD=95=E5=9F=BA=E5=9D=80      =
     PGDL
> +0x1A              =E9=AB=98=E5=8D=8A=E5=9C=B0=E5=9D=80=E7=A9=BA=E9=97=
=B4=E9=A1=B5=E5=85=A8=E5=B1=80=E7=9B=AE=E5=BD=95=E5=9F=BA=E5=9D=80      =
     PGDH
> +0x1B              =E9=A1=B5=E5=85=A8=E5=B1=80=E7=9B=AE=E5=BD=95=E5=9F=
=BA=E5=9D=80                       PGD
> +0x1C              =E9=A1=B5=E8=A1=A8=E9=81=8D=E5=8E=86=E6=8E=A7=E5=88=
=B6=E4=BD=8E=E5=8D=8A=E9=83=A8=E5=88=86                 PWCL
> +0x1D              =E9=A1=B5=E8=A1=A8=E9=81=8D=E5=8E=86=E6=8E=A7=E5=88=
=B6=E9=AB=98=E5=8D=8A=E9=83=A8=E5=88=86                 PWCH
> +0x1E              STLB=E9=A1=B5=E5=A4=A7=E5=B0=8F                    =
       STLBPS
> +0x1F              =E7=BC=A9=E5=87=8F=E8=99=9A=E5=9C=B0=E5=9D=80=E9=85=
=8D=E7=BD=AE                       RVACFG
> +0x20              CPU=E7=BC=96=E5=8F=B7                              =
CPUID
> +0x21              =E7=89=B9=E6=9D=83=E8=B5=84=E6=BA=90=E9=85=8D=E7=BD=
=AE=E4=BF=A1=E6=81=AF1                    PRCFG1
> +0x22              =E7=89=B9=E6=9D=83=E8=B5=84=E6=BA=90=E9=85=8D=E7=BD=
=AE=E4=BF=A1=E6=81=AF2                    PRCFG2
> +0x23              =E7=89=B9=E6=9D=83=E8=B5=84=E6=BA=90=E9=85=8D=E7=BD=
=AE=E4=BF=A1=E6=81=AF3                    PRCFG3
> +0x30+n (0=E2=89=A4n=E2=89=A415)   =E6=95=B0=E6=8D=AE=E4=BF=9D=E5=AD=98=
=E5=AF=84=E5=AD=98=E5=99=A8                       SAVEn
> +0x40              =E5=AE=9A=E6=97=B6=E5=99=A8=E7=BC=96=E5=8F=B7      =
                     TID
> +0x41              =E5=AE=9A=E6=97=B6=E5=99=A8=E9=85=8D=E7=BD=AE      =
                     TCFG
> +0x42              =E5=AE=9A=E6=97=B6=E5=99=A8=E5=80=BC               =
              TVAL
> +0x43              =E8=AE=A1=E6=97=B6=E5=99=A8=E8=A1=A5=E5=81=BF      =
                     CNTC
> +0x44              =E5=AE=9A=E6=97=B6=E5=99=A8=E4=B8=AD=E6=96=AD=E6=B8=
=85=E9=99=A4                       TICLR
> +0x60              LLBit=E7=9B=B8=E5=85=B3=E6=8E=A7=E5=88=B6          =
              LLBCTL
> +0x80              =E5=AE=9E=E7=8E=B0=E7=9B=B8=E5=85=B3=E6=8E=A7=E5=88=
=B61                        IMPCTL1
> +0x81              =E5=AE=9E=E7=8E=B0=E7=9B=B8=E5=85=B3=E6=8E=A7=E5=88=
=B62                        IMPCTL2
> +0x88              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E5=85=A5=E5=
=8F=A3=E5=9C=B0=E5=9D=80                  TLBRENTRY
> +0x89              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E5=87=BA=E9=
=94=99(Faulting)=E8=99=9A=E5=9C=B0=E5=9D=80      TLBRBADV
> +0x8A              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E8=BF=94=E5=
=9B=9E=E5=9C=B0=E5=9D=80                  TLBRERA
> +0x8B              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E6=95=B0=E6=
=8D=AE=E4=BF=9D=E5=AD=98                  TLBRSAVE
> +0x8C              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E8=A1=A8=E9=
=A1=B9=E4=BD=8E=E4=BD=8D0                 TLBRELO0
> +0x8D              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E8=A1=A8=E9=
=A1=B9=E4=BD=8E=E4=BD=8D1                 TLBRELO1
> +0x8E              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E8=A1=A8=E9=
=A1=B9=E9=AB=98=E4=BD=8D                  TLBEHI
> +0x8F              TLB=E9=87=8D=E5=A1=AB=E5=BC=82=E5=B8=B8=E5=89=8D=E6=
=A8=A1=E5=BC=8F=E4=BF=A1=E6=81=AF                TLBRPRMD
> +0x90              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E6=8E=A7=E5=88=
=B6                         MERRCTL
> +0x91              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E4=BF=A1=E6=81=
=AF1                        MERRINFO1
> +0x92              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E4=BF=A1=E6=81=
=AF2                        MERRINFO2
> +0x93              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E5=BC=82=E5=B8=
=B8=E5=85=A5=E5=8F=A3=E5=9C=B0=E5=9D=80                 MERRENTRY
> +0x94              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E5=BC=82=E5=B8=
=B8=E8=BF=94=E5=9B=9E=E5=9C=B0=E5=9D=80                 MERRERA
> +0x95              =E6=9C=BA=E5=99=A8=E9=94=99=E8=AF=AF=E5=BC=82=E5=B8=
=B8=E6=95=B0=E6=8D=AE=E4=BF=9D=E5=AD=98                 MERRSAVE
> +0x98              =E9=AB=98=E9=80=9F=E7=BC=93=E5=AD=98=E6=A0=87=E7=AD=
=BE                         CTAG
> +0x180+n (0=E2=89=A4n=E2=89=A43)   =E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=
=E9=85=8D=E7=BD=AE=E7=AA=97=E5=8F=A3n                    DMWn
> +0x200+2n (0=E2=89=A4n=E2=89=A431) =E6=80=A7=E8=83=BD=E7=9B=91=E6=B5=8B=
=E9=85=8D=E7=BD=AEn                        PMCFGn
> +0x201+2n (0=E2=89=A4n=E2=89=A431) =E6=80=A7=E8=83=BD=E7=9B=91=E6=B5=8B=
=E8=AE=A1=E6=95=B0=E5=99=A8n                      PMCNTn
> +0x300             =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=E7=9B=91=E8=A7=
=86=E7=82=B9=E6=95=B4=E4=BD=93=E6=8E=A7=E5=88=B6               MWPC
> +0x301             =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=E7=9B=91=E8=A7=
=86=E7=82=B9=E6=95=B4=E4=BD=93=E7=8A=B6=E6=80=81               MWPS
> +0x310+8n (0=E2=89=A4n=E2=89=A47)  =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=
=E7=9B=91=E8=A7=86=E7=82=B9n=E9=85=8D=E7=BD=AE1                 MWPnCFG1
> +0x311+8n (0=E2=89=A4n=E2=89=A47)  =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=
=E7=9B=91=E8=A7=86=E7=82=B9n=E9=85=8D=E7=BD=AE2                 MWPnCFG2
> +0x312+8n (0=E2=89=A4n=E2=89=A47)  =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=
=E7=9B=91=E8=A7=86=E7=82=B9n=E9=85=8D=E7=BD=AE3                 MWPnCFG3
> +0x313+8n (0=E2=89=A4n=E2=89=A47)  =E5=86=85=E5=AD=98=E8=AF=BB=E5=86=99=
=E7=9B=91=E8=A7=86=E7=82=B9n=E9=85=8D=E7=BD=AE4                 MWPnCFG4
> +0x380             =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=E7=82=B9=E6=95=
=B4=E4=BD=93=E6=8E=A7=E5=88=B6                   FWPC
> +0x381             =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=E7=82=B9=E6=95=
=B4=E4=BD=93=E7=8A=B6=E6=80=81                   FWPS
> +0x390+8n (0=E2=89=A4n=E2=89=A47)  =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=
=E7=82=B9n=E9=85=8D=E7=BD=AE1                     FWPnCFG1
> +0x391+8n (0=E2=89=A4n=E2=89=A47)  =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=
=E7=82=B9n=E9=85=8D=E7=BD=AE2                     FWPnCFG2
> +0x392+8n (0=E2=89=A4n=E2=89=A47)  =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=
=E7=82=B9n=E9=85=8D=E7=BD=AE3                     FWPnCFG3
> +0x393+8n (0=E2=89=A4n=E2=89=A47)  =E5=8F=96=E6=8C=87=E7=9B=91=E8=A7=86=
=E7=82=B9n=E9=85=8D=E7=BD=AE4                     FWPnCFG4
> +0x500             =E8=B0=83=E8=AF=95=E5=AF=84=E5=AD=98=E5=99=A8      =
                     DBG
> +0x501             =E8=B0=83=E8=AF=95=E5=BC=82=E5=B8=B8=E8=BF=94=E5=9B=
=9E=E5=9C=B0=E5=9D=80                     DERA
> +0x502             =E8=B0=83=E8=AF=95=E6=95=B0=E6=8D=AE=E4=BF=9D=E5=AD=
=98                         DSAVE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ERA=EF=BC=8CTLBRERA=EF=BC=8CMERRERA=E5=92=8CDERA=E6=9C=89=E6=97=B6=E4=
=B9=9F=E5=88=86=E5=88=AB=E7=A7=B0=E4=B8=BAEPC=EF=BC=8CTLBREPC=EF=BC=8CME=
RREPC=E5=92=8CDEPC=E3=80=82
> +
> +=E5=9F=BA=E7=A1=80=E6=8C=87=E4=BB=A4=E9=9B=86
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E6=8C=87=E4=BB=A4=E6=A0=BC=E5=BC=8F
> +--------
> +
> +LoongArch=E7=9A=84=E6=8C=87=E4=BB=A4=E5=AD=97=E9=95=BF=E4=B8=BA32=E4=BD=
=8D=EF=BC=8C=E4=B8=80=E5=85=B1=E6=9C=899=E7=A7=8D=E5=9F=BA=E6=9C=AC=E6=8C=
=87=E4=BB=A4=E6=A0=BC=E5=BC=8F=EF=BC=88=E4=BB=A5=E5=8F=8A=E4=B8=80=E4=BA=
=9B=E5=8F=98=E4=BD=93=EF=BC=89:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E6=A0=BC=E5=BC=8F=E5=90=8D=E7=A7=B0    =E6=8C=87=E4=BB=A4=E6=9E=84=E6=
=88=90
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +2R          Opcode + Rj + Rd
> +3R          Opcode + Rk + Rj + Rd
> +4R          Opcode + Ra + Rk + Rj + Rd
> +2RI8        Opcode + I8 + Rj + Rd
> +2RI12       Opcode + I12 + Rj + Rd
> +2RI14       Opcode + I14 + Rj + Rd
> +2RI16       Opcode + I16 + Rj + Rd
> +1RI21       Opcode + I21L + Rj + I21H
> +I26         Opcode + I26L + I26H
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Opcode=E6=98=AF=E6=8C=87=E4=BB=A4=E6=93=8D=E4=BD=9C=E7=A0=81=EF=BC=8C=
Rj=E5=92=8CRk=E6=98=AF=E6=BA=90=E6=93=8D=E4=BD=9C=E6=95=B0=EF=BC=88=E5=AF=
=84=E5=AD=98=E5=99=A8=EF=BC=89=EF=BC=8CRd=E6=98=AF=E7=9B=AE=E6=A0=87=E6=93=
=8D=E4=BD=9C=E6=95=B0=EF=BC=88=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=89=EF=BC=
=8CRa=E6=98=AF
> +4R-type=E6=A0=BC=E5=BC=8F=E7=89=B9=E6=9C=89=E7=9A=84=E9=99=84=E5=8A=A0=
=E6=93=8D=E4=BD=9C=E6=95=B0=EF=BC=88=E5=AF=84=E5=AD=98=E5=99=A8=EF=BC=89=
=E3=80=82I8/I12/I16/I21/I26=E5=88=86=E5=88=AB=E6=98=AF8=E4=BD=8D/12=E4=BD=
=8D/16=E4=BD=8D/
> +21=E4=BD=8D/26=E4=BD=8D=E7=9A=84=E7=AB=8B=E5=8D=B3=E6=95=B0=E3=80=82=E5=
=85=B6=E4=B8=AD=E8=BE=83=E9=95=BF=E7=9A=8421=E4=BD=8D=E5=92=8C26=E4=BD=8D=
=E7=AB=8B=E5=8D=B3=E6=95=B0=E5=9C=A8=E6=8C=87=E4=BB=A4=E5=AD=97=E4=B8=AD=
=E8=A2=AB=E5=88=86=E5=89=B2=E4=B8=BA=E9=AB=98=E4=BD=8D=E9=83=A8=E5=88=86=
=E4=B8=8E=E4=BD=8E=E4=BD=8D
> +=E9=83=A8=E5=88=86=EF=BC=8C=E6=89=80=E4=BB=A5=E4=BD=A0=E4=BB=AC=E5=9C=
=A8=E8=BF=99=E9=87=8C=E7=9A=84=E6=A0=BC=E5=BC=8F=E6=8F=8F=E8=BF=B0=E4=B8=
=AD=E8=83=BD=E5=A4=9F=E7=9C=8B=E5=88=B0I21L/I21H=E5=92=8CI26L/I26H=E8=BF=
=99=E6=A0=B7=E5=B8=A6=E5=90=8E=E7=BC=80=E7=9A=84=E8=A1=A8=E8=BF=B0=E3=80=82
> +
> +=E6=8C=87=E4=BB=A4=E5=88=97=E8=A1=A8
> +--------
> +
> +=E4=B8=BA=E4=BA=86=E7=AE=80=E4=BE=BF=E8=B5=B7=E8=A7=81=EF=BC=8C=E6=88=
=91=E4=BB=AC=E5=9C=A8=E6=AD=A4=E5=8F=AA=E7=BD=97=E5=88=97=E4=B8=80=E4=B8=
=8B=E6=8C=87=E4=BB=A4=E5=90=8D=E7=A7=B0=EF=BC=88=E5=8A=A9=E8=AE=B0=E7=AC=
=A6=EF=BC=89=EF=BC=8C=E9=9C=80=E8=A6=81=E8=AF=A6=E7=BB=86=E4=BF=A1=E6=81=
=AF=E8=AF=B7=E9=98=85=E8=AF=BB
> +:ref:`=E5=8F=82=E8=80=83=E6=96=87=E7=8C=AE <loongarch-references-zh_C=
N>` =E4=B8=AD=E7=9A=84=E6=96=87=E6=A1=A3=E3=80=82
> +
> +1. =E7=AE=97=E6=9C=AF=E8=BF=90=E7=AE=97=E6=8C=87=E4=BB=A4::
> +
> +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +    SLT SLTU SLTI SLTUI
> +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +    PCADDI PCADDU12I PCADDU18I
> +    LU12I.W LU32I.D LU52I.D ADDU16I.D
> +
> +2. =E7=A7=BB=E4=BD=8D=E8=BF=90=E7=AE=97=E6=8C=87=E4=BB=A4::
> +
> +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +
> +3. =E4=BD=8D=E5=9F=9F=E6=93=8D=E4=BD=9C=E6=8C=87=E4=BB=A4::
> +
> +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B=20
> BITREV.W BITREV.D
> +    MASKEQZ MASKNEZ
> +
> +4. =E5=88=86=E6=94=AF=E8=BD=AC=E7=A7=BB=E6=8C=87=E4=BB=A4::
> +
> +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +
> +5. =E8=AE=BF=E5=AD=98=E8=AF=BB=E5=86=99=E6=8C=87=E4=BB=A4::
> +
> +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W=20
> STX.D
> +    LDPTR.W LDPTR.D STPTR.W STPTR.D
> +    PRELD PRELDX
> +
> +6. =E5=8E=9F=E5=AD=90=E6=93=8D=E4=BD=9C=E6=8C=87=E4=BB=A4::
> +
> +    LL.W SC.W LL.D SC.D
> +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D=20
> AMXOR.W AMXOR.D
> +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +
> +7. =E6=A0=85=E9=9A=9C=E6=8C=87=E4=BB=A4::
> +
> +    IBAR DBAR
> +
> +8. =E7=89=B9=E6=AE=8A=E6=8C=87=E4=BB=A4::
> +
> +    SYSCALL BREAK CPUCFG NOP IDLE ERTN(ERET) DBCL(DBGCALL) RDTIMEL.W=20
> RDTIMEH.W RDTIME.D
> +    ASRTLE.D ASRTGT.D
> +
> +9. =E7=89=B9=E6=9D=83=E6=8C=87=E4=BB=A4::
> +
> +    CSRRD CSRWR CSRXCHG
> +    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H=20
> IOCSRWR.W IOCSRWR.D
> +    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB=20
> LDDIR LDPTE
> +
> +=E8=99=9A=E6=8B=9F=E5=86=85=E5=AD=98
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch=E5=8F=AF=E4=BB=A5=E4=BD=BF=E7=94=A8=E7=9B=B4=E6=8E=A5=E6=98=
=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=86=85=E5=AD=98=E5=92=8C=E5=88=86=E9=A1=
=B5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=86=85=E5=AD=98=E3=80=82
> +
> +=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=86=85=E5=AD=
=98=E9=80=9A=E8=BF=87CSR.DMWn=EF=BC=88n=3D0~3=EF=BC=89=E6=9D=A5=E8=BF=9B=
=E8=A1=8C=E9=85=8D=E7=BD=AE=EF=BC=8C=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=9D=80=
=EF=BC=88VA=EF=BC=89=E5=92=8C=E7=89=A9=E7=90=86=E5=9C=B0=E5=9D=80=EF=BC=88=
PA=EF=BC=89
> +=E4=B9=8B=E9=97=B4=E6=9C=89=E7=AE=80=E5=8D=95=E7=9A=84=E6=98=A0=E5=B0=
=84=E5=85=B3=E7=B3=BB::
> +
> + VA =3D PA + =E5=9B=BA=E5=AE=9A=E5=81=8F=E7=A7=BB
> +
> +=E5=88=86=E9=A1=B5=E6=98=A0=E5=B0=84=E7=9A=84=E8=99=9A=E6=8B=9F=E5=9C=
=B0=E5=9D=80=EF=BC=88VA=EF=BC=89=E5=92=8C=E7=89=A9=E7=90=86=E5=9C=B0=E5=9D=
=80=EF=BC=88PA=EF=BC=89=E6=9C=89=E4=BB=BB=E6=84=8F=E7=9A=84=E6=98=A0=E5=B0=
=84=E5=85=B3=E7=B3=BB=EF=BC=8C=E8=BF=99=E7=A7=8D=E5=85=B3=E7=B3=BB=E8=AE=
=B0=E5=BD=95=E5=9C=A8TLB=E5=92=8C=E9=A1=B5
> +=E8=A1=A8=E4=B8=AD=E3=80=82LoongArch=E7=9A=84TLB=E5=8C=85=E6=8B=AC=E4=
=B8=80=E4=B8=AA=E5=85=A8=E7=9B=B8=E8=81=94=E7=9A=84MTLB=EF=BC=88Multiple=
 Page Size TLB=EF=BC=8C=E5=A4=9A=E6=A0=B7=E9=A1=B5=E5=A4=A7=E5=B0=8FTLB=EF=
=BC=89
> +=E5=92=8C=E4=B8=80=E4=B8=AA=E7=BB=84=E7=9B=B8=E8=81=94=E7=9A=84STLB=EF=
=BC=88Single Page Size TLB=EF=BC=8C=E5=8D=95=E4=B8=80=E9=A1=B5=E5=A4=A7=E5=
=B0=8FTLB=EF=BC=89=E3=80=82
> +
> +=E7=BC=BA=E7=9C=81=E7=8A=B6=E6=80=81=E4=B8=8B=EF=BC=8CLA32=E7=9A=84=E6=
=95=B4=E4=B8=AA=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=9D=80=E7=A9=BA=E9=97=B4=E9=
=85=8D=E7=BD=AE=E5=A6=82=E4=B8=8B=EF=BC=9A
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=8C=BA=E6=AE=B5=E5=90=8D       =E5=9C=B0=E5=9D=80=E8=8C=83=E5=9B=B4=
                    =E5=B1=9E=E6=80=A7
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` =E5=88=86=E9=A1=B5=E6=98=A0=E5=
=B0=84, =E5=8F=AF=E7=BC=93=E5=AD=98, PLV0~3
> +``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` =E7=9B=B4=E6=8E=A5=E6=98=A0=E5=
=B0=84, =E9=9D=9E=E7=BC=93=E5=AD=98, PLV0
> +``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` =E7=9B=B4=E6=8E=A5=E6=98=A0=E5=
=B0=84, =E5=8F=AF=E7=BC=93=E5=AD=98, PLV0
> +``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` =E5=88=86=E9=A1=B5=E6=98=A0=E5=
=B0=84, =E5=8F=AF=E7=BC=93=E5=AD=98, PLV0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E7=94=A8=E6=88=B7=E6=80=81=EF=BC=88PLV3=EF=BC=89=E5=8F=AA=E8=83=BD=E8=
=AE=BF=E9=97=AEUVRANGE=EF=BC=8C=E5=AF=B9=E4=BA=8E=E7=9B=B4=E6=8E=A5=E6=98=
=A0=E5=B0=84=E7=9A=84KPRANGE0=E5=92=8CKPRANGE1=EF=BC=8C=E5=B0=86=E8=99=9A=
=E6=8B=9F=E5=9C=B0=E5=9D=80=E7=9A=84=E7=AC=AC
> +30~31=E4=BD=8D=E6=B8=85=E9=9B=B6=E5=B0=B1=E7=AD=89=E4=BA=8E=E7=89=A9=E7=
=90=86=E5=9C=B0=E5=9D=80=E3=80=82=E4=BE=8B=E5=A6=82=EF=BC=9A=E7=89=A9=E7=
=90=86=E5=9C=B0=E5=9D=800x00001000=E5=AF=B9=E5=BA=94=E7=9A=84=E9=9D=9E=E7=
=BC=93=E5=AD=98=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=
=9C=B0=E5=9D=80
> +=E6=98=AF0x80001000=EF=BC=8C=E8=80=8C=E5=85=B6=E5=8F=AF=E7=BC=93=E5=AD=
=98=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=9D=
=80=E6=98=AF0xA0001000=E3=80=82
> +
> +=E7=BC=BA=E7=9C=81=E7=8A=B6=E6=80=81=E4=B8=8B=EF=BC=8CLA64=E7=9A=84=E6=
=95=B4=E4=B8=AA=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=9D=80=E7=A9=BA=E9=97=B4=E9=
=85=8D=E7=BD=AE=E5=A6=82=E4=B8=8B=EF=BC=9A
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +=E5=8C=BA=E6=AE=B5=E5=90=8D       =E5=9C=B0=E5=9D=80=E8=8C=83=E5=9B=B4=
               =E5=B1=9E=E6=80=A7
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``XUVRANGE`` ``0x0000000000000000 - =E5=88=86=E9=A1=B5=E6=98=A0=E5=B0=
=84, =E5=8F=AF=E7=BC=93=E5=AD=98, PLV0~3
> +             0x3FFFFFFFFFFFFFFF``
> +``XSPRANGE`` ``0x4000000000000000 - =E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=
=84, =E5=8F=AF=E7=BC=93=E5=AD=98 / =E9=9D=9E=E7=BC=93=E5=AD=98, PLV0
> +             0x7FFFFFFFFFFFFFFF``
> +``XKPRANGE`` ``0x8000000000000000 - =E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=
=84, =E5=8F=AF=E7=BC=93=E5=AD=98 / =E9=9D=9E=E7=BC=93=E5=AD=98, PLV0
> +             0xBFFFFFFFFFFFFFFF``
> +``XKVRANGE`` ``0xC000000000000000 - =E5=88=86=E9=A1=B5=E6=98=A0=E5=B0=
=84, =E5=8F=AF=E7=BC=93=E5=AD=98, PLV0
> +             0xFFFFFFFFFFFFFFFF``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E7=94=A8=E6=88=B7=E6=80=81=EF=BC=88PLV3=EF=BC=89=E5=8F=AA=E8=83=BD=E8=
=AE=BF=E9=97=AEXUVRANGE=EF=BC=8C=E5=AF=B9=E4=BA=8E=E7=9B=B4=E6=8E=A5=E6=98=
=A0=E5=B0=84=E7=9A=84XSPRANGE=E5=92=8CXKPRANGE=EF=BC=8C=E5=B0=86=E8=99=9A=
=E6=8B=9F=E5=9C=B0=E5=9D=80=E7=9A=84=E7=AC=AC
> +60~63=E4=BD=8D=E6=B8=85=E9=9B=B6=E5=B0=B1=E7=AD=89=E4=BA=8E=E7=89=A9=E7=
=90=86=E5=9C=B0=E5=9D=80=EF=BC=8C=E8=80=8C=E5=85=B6=E7=BC=93=E5=AD=98=E5=
=B1=9E=E6=80=A7=E6=98=AF=E9=80=9A=E8=BF=87=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=
=9D=80=E7=9A=84=E7=AC=AC60~61=E4=BD=8D=E9=85=8D=E7=BD=AE=E7=9A=84=EF=BC=88=
0=E8=A1=A8=E7=A4=BA=E5=BC=BA=E5=BA=8F
> +=E9=9D=9E=E7=BC=93=E5=AD=98=EF=BC=8C1=E8=A1=A8=E7=A4=BA=E4=B8=80=E8=87=
=B4=E5=8F=AF=E7=BC=93=E5=AD=98=EF=BC=8C2=E8=A1=A8=E7=A4=BA=E5=BC=B1=E5=BA=
=8F=E9=9D=9E=E7=BC=93=E5=AD=98=EF=BC=89=E3=80=82
> +
> +=E7=9B=AE=E5=89=8D=EF=BC=8C=E6=88=91=E4=BB=AC=E4=BB=85=E7=94=A8XKPRAN=
GE=E6=9D=A5=E8=BF=9B=E8=A1=8C=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=EF=BC=8C=
XSPRANGE=E4=BF=9D=E7=95=99=E7=BB=99=E4=BB=A5=E5=90=8E=E7=94=A8=E3=80=82
> +
> +=E6=AD=A4=E5=A4=84=E7=BB=99=E5=87=BA=E4=B8=80=E4=B8=AA=E7=9B=B4=E6=8E=
=A5=E6=98=A0=E5=B0=84=E7=9A=84=E4=BE=8B=E5=AD=90=EF=BC=9A=E7=89=A9=E7=90=
=86=E5=9C=B0=E5=9D=800x00000000_00001000=E7=9A=84=E5=BC=BA=E5=BA=8F=E9=9D=
=9E=E7=BC=93=E5=AD=98=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=
=9F=E5=9C=B0=E5=9D=80
> +=EF=BC=88=E5=9C=A8XKPRANGE=E4=B8=AD=EF=BC=89=E6=98=AF0x80000000_00001=
000=EF=BC=8C=E5=85=B6=E4=B8=80=E8=87=B4=E5=8F=AF=E7=BC=93=E5=AD=98=E7=9B=
=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=9A=E6=8B=9F=E5=9C=B0=E5=9D=80=EF=BC=
=88=E5=9C=A8XKPRANGE=E4=B8=AD=EF=BC=89
> +=E6=98=AF0x90000000_00001000=EF=BC=8C=E8=80=8C=E5=85=B6=E5=BC=B1=E5=BA=
=8F=E9=9D=9E=E7=BC=93=E5=AD=98=E7=9B=B4=E6=8E=A5=E6=98=A0=E5=B0=84=E8=99=
=9A=E6=8B=9F=E5=9C=B0=E5=9D=80=EF=BC=88=E5=9C=A8XKPRANGE=E4=B8=AD=EF=BC=89=
=E6=98=AF0xA0000000_
> +00001000=E3=80=82
> +
> +Loongson=E4=B8=8ELoongArch=E7=9A=84=E5=85=B3=E7=B3=BB
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +LoongArch=E6=98=AF=E4=B8=80=E7=A7=8DRISC=E6=8C=87=E4=BB=A4=E9=9B=86=E6=
=9E=B6=E6=9E=84=EF=BC=88ISA=EF=BC=89=EF=BC=8C=E4=B8=8D=E5=90=8C=E4=BA=8E=
=E7=8E=B0=E5=AD=98=E7=9A=84=E4=BB=BB=E4=BD=95=E4=B8=80=E7=A7=8DISA=EF=BC=
=8C=E8=80=8CLoongson=EF=BC=88=E5=8D=B3=E9=BE=99
> +=E8=8A=AF=EF=BC=89=E6=98=AF=E4=B8=80=E4=B8=AA=E5=A4=84=E7=90=86=E5=99=
=A8=E5=AE=B6=E6=97=8F=E3=80=82=E9=BE=99=E8=8A=AF=E5=8C=85=E6=8B=AC=E4=B8=
=89=E4=B8=AA=E7=B3=BB=E5=88=97=EF=BC=9ALoongson-1=EF=BC=88=E9=BE=99=E8=8A=
=AF1=E5=8F=B7=EF=BC=89=E6=98=AF32=E4=BD=8D=E5=A4=84=E7=90=86=E5=99=A8=E7=
=B3=BB=E5=88=97=EF=BC=8C
> +Loongson-2=EF=BC=88=E9=BE=99=E8=8A=AF2=E5=8F=B7=EF=BC=89=E6=98=AF=E4=BD=
=8E=E7=AB=AF64=E4=BD=8D=E5=A4=84=E7=90=86=E5=99=A8=E7=B3=BB=E5=88=97=EF=BC=
=8C=E8=80=8CLoongson-3=EF=BC=88=E9=BE=99=E8=8A=AF3=E5=8F=B7=EF=BC=89=E6=98=
=AF=E9=AB=98=E7=AB=AF64=E4=BD=8D=E5=A4=84=E7=90=86
> +=E5=99=A8=E7=B3=BB=E5=88=97=E3=80=82=E6=97=A7=E7=9A=84=E9=BE=99=E8=8A=
=AF=E5=A4=84=E7=90=86=E5=99=A8=E5=9F=BA=E4=BA=8EMIPS=E6=9E=B6=E6=9E=84=EF=
=BC=8C=E8=80=8C=E6=96=B0=E7=9A=84=E9=BE=99=E8=8A=AF=E5=A4=84=E7=90=86=E5=
=99=A8=E5=9F=BA=E4=BA=8ELoongArch=E6=9E=B6=E6=9E=84=E3=80=82=E4=BB=A5=E9=
=BE=99=E8=8A=AF3=E5=8F=B7
> +=E4=B8=BA=E4=BE=8B=EF=BC=9A=E9=BE=99=E8=8A=AF3A1000/3B1500/3A2000/3A3=
000/3A4000=E9=83=BD=E6=98=AF=E5=85=BC=E5=AE=B9MIPS=E7=9A=84=EF=BC=8C=E8=80=
=8C=E9=BE=99=E8=8A=AF3A5000=EF=BC=88=E4=BB=A5=E5=8F=8A=E5=B0=86
> +=E6=9D=A5=E7=9A=84=E5=9E=8B=E5=8F=B7=EF=BC=89=E9=83=BD=E6=98=AF=E5=9F=
=BA=E4=BA=8ELoongArch=E7=9A=84=E3=80=82
> +
> +.. _loongarch-references-zh_CN:
> +
> +=E5=8F=82=E8=80=83=E6=96=87=E7=8C=AE
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Loongson=E5=AE=98=E6=96=B9=E7=BD=91=E7=AB=99=EF=BC=88=E9=BE=99=E8=8A=AF=
=E4=B8=AD=E7=A7=91=E6=8A=80=E6=9C=AF=E8=82=A1=E4=BB=BD=E6=9C=89=E9=99=90=
=E5=85=AC=E5=8F=B8=EF=BC=89=EF=BC=9A
> +
> +  http://www.loongson.cn/
> +
> +Loongson=E4=B8=8ELoongArch=E7=9A=84=E5=BC=80=E5=8F=91=E8=80=85=E7=BD=91=
=E7=AB=99=EF=BC=88=E8=BD=AF=E4=BB=B6=E4=B8=8E=E6=96=87=E6=A1=A3=E8=B5=84=
=E6=BA=90=EF=BC=89=EF=BC=9A
> +
> +  http://www.loongnix.cn/
> +
> +  https://github.com/loongson/
> +
> +  https://loongson.github.io/LoongArch-Documentation/
> +
> +LoongArch=E6=8C=87=E4=BB=A4=E9=9B=86=E6=9E=B6=E6=9E=84=E7=9A=84=E6=96=
=87=E6=A1=A3=EF=BC=9A
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-Vol1-v1.00-CN.pdf=20
> =EF=BC=88=E4=B8=AD=E6=96=87=E7=89=88=EF=BC=89
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-Vol1-v1.00-EN.pdf=20
> =EF=BC=88=E8=8B=B1=E6=96=87=E7=89=88=EF=BC=89
> +
> +LoongArch=E7=9A=84ELF psABI=E6=96=87=E6=A1=A3=EF=BC=9A
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-ELF-ABI-v1.00-CN.pdf=20
> =EF=BC=88=E4=B8=AD=E6=96=87=E7=89=88=EF=BC=89
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-ELF-ABI-v1.00-EN.pdf=20
> =EF=BC=88=E8=8B=B1=E6=96=87=E7=89=88=EF=BC=89
> +
> +Loongson=E4=B8=8ELoongArch=E7=9A=84Linux=E5=86=85=E6=A0=B8=E6=BA=90=E7=
=A0=81=E4=BB=93=E5=BA=93=EF=BC=9A
> +
> + =20
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loong=
son.git
> diff --git=20
> a/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst=20
> b/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> new file mode 100644
> index 000000000000..9f6c32f3bad0
> --- /dev/null
> +++ b/Documentation/translations/zh_CN/loongarch/irq-chip-model.rst
> @@ -0,0 +1,167 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. include:: ../disclaimer-zh_CN.rst
> +
> +:Original: Documentation/loongarch/irq-chip-model.rst
> +:Translator: Huacai Chen <chenhuacai@loongson.cn>
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LoongArch=E7=9A=84IRQ=E8=8A=AF=E7=89=87=E6=A8=A1=E5=9E=8B=EF=BC=88=E5=
=B1=82=E7=BA=A7=E5=85=B3=E7=B3=BB=EF=BC=89
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E7=9B=AE=E5=89=8D=EF=BC=8C=E5=9F=BA=E4=BA=8ELoongArch=E7=9A=84=E5=A4=
=84=E7=90=86=E5=99=A8=EF=BC=88=E5=A6=82=E9=BE=99=E8=8A=AF3A5000=EF=BC=89=
=E5=8F=AA=E8=83=BD=E4=B8=8ELS7A=E8=8A=AF=E7=89=87=E7=BB=84=E9=85=8D=E5=90=
=88=E5=B7=A5=E4=BD=9C=E3=80=82LoongArch=E8=AE=A1=E7=AE=97=E6=9C=BA
> +=E4=B8=AD=E7=9A=84=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=
=88=E5=8D=B3IRQ=E8=8A=AF=E7=89=87=EF=BC=89=E5=8C=85=E6=8B=ACCPUINTC=EF=BC=
=88CPU Core Interrupt Controller=EF=BC=89=E3=80=81LIOINTC=EF=BC=88
> +Legacy I/O Interrupt Controller=EF=BC=89=E3=80=81EIOINTC=EF=BC=88Exte=
nded I/O Interrupt=20
> Controller=EF=BC=89=E3=80=81
> +HTVECINTC=EF=BC=88Hyper-Transport Vector Interrupt=20
> Controller=EF=BC=89=E3=80=81PCH-PIC=EF=BC=88LS7A=E8=8A=AF=E7=89=87=E7=BB=
=84=E7=9A=84=E4=B8=BB=E4=B8=AD
> +=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=81PCH-LPC=EF=BC=88=
LS7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84LPC=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=
=88=B6=E5=99=A8=EF=BC=89=E5=92=8CPCH-MSI=EF=BC=88MSI=E4=B8=AD=E6=96=AD=E6=
=8E=A7=E5=88=B6=E5=99=A8=EF=BC=89=E3=80=82
> +
> +CPUINTC=E6=98=AF=E4=B8=80=E7=A7=8DCPU=E5=86=85=E9=83=A8=E7=9A=84=E6=AF=
=8F=E4=B8=AA=E6=A0=B8=E6=9C=AC=E5=9C=B0=E7=9A=84=E4=B8=AD=E6=96=AD=E6=8E=
=A7=E5=88=B6=E5=99=A8=EF=BC=8CLIOINTC/EIOINTC/HTVECINTC=E6=98=AFCPU=E5=86=
=85=E9=83=A8=E7=9A=84
> +=E5=85=A8=E5=B1=80=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=
=88=E6=AF=8F=E4=B8=AA=E8=8A=AF=E7=89=87=E4=B8=80=E4=B8=AA=EF=BC=8C=E6=89=
=80=E6=9C=89=E6=A0=B8=E5=85=B1=E4=BA=AB=EF=BC=89=EF=BC=8C=E8=80=8CPCH-PI=
C/PCH-LPC/PCH-MSI=E6=98=AFCPU=E5=A4=96=E9=83=A8=E7=9A=84=E4=B8=AD
> +=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=88=E5=9C=A8=E9=85=8D=E5=A5=
=97=E8=8A=AF=E7=89=87=E7=BB=84=E9=87=8C=E9=9D=A2=EF=BC=89=E3=80=82=E8=BF=
=99=E4=BA=9B=E4=B8=AD=E6=96=AD=E6=8E=A7=E5=88=B6=E5=99=A8=EF=BC=88=E6=88=
=96=E8=80=85=E8=AF=B4IRQ=E8=8A=AF=E7=89=87=EF=BC=89=E4=BB=A5=E4=B8=80=E7=
=A7=8D=E5=B1=82=E6=AC=A1=E6=A0=91=E7=9A=84=E7=BB=84=E7=BB=87=E5=BD=A2=E5=
=BC=8F
> +=E7=BA=A7=E8=81=94=E5=9C=A8=E4=B8=80=E8=B5=B7=EF=BC=8C=E4=B8=80=E5=85=
=B1=E6=9C=89=E4=B8=A4=E7=A7=8D=E5=B1=82=E7=BA=A7=E5=85=B3=E7=B3=BB=E6=A8=
=A1=E5=9E=8B=EF=BC=88=E4=BC=A0=E7=BB=9FIRQ=E6=A8=A1=E5=9E=8B=E5=92=8C=E6=
=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B=EF=BC=89=E3=80=82
> +
> +=E4=BC=A0=E7=BB=9FIRQ=E6=A8=A1=E5=9E=8B
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=
=8CIPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=
=9C=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=
=80=81=E5=88=B0CPUINTC=EF=BC=8C
> +CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=91=
=E9=80=81=E5=88=B0LIOINTC=EF=BC=8C=E8=80=8C=E5=85=B6=E4=BB=96=E6=89=80=E6=
=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=AD=E6=96=AD=E5=88=99=E5=88=86=E5=
=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=E8=BF=9E=E6=8E=A5=E7=9A=84PCH=
-PIC/
> +PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=ABHTVECINTC=E7=BB=9F=
=E4=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E5=8F=91=E9=80=81=E5=88=B0=
LIOINTC=EF=BC=8C=E6=9C=80=E5=90=8E=E5=88=B0=E8=BE=BECPUINTC=E3=80=82
> +
> + +---------------------------------------------+
> + |::                                           |
> + |                                             |
> + |    +-----+     +---------+     +-------+    |
> + |    | IPI | --> | CPUINTC | <-- | Timer |    |
> + |    +-----+     +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |                +---------+     +-------+    |
> + |                | LIOINTC | <-- | UARTs |    |
> + |                +---------+     +-------+    |
> + |                     ^                       |
> + |                     |                       |
> + |               +-----------+                 |
> + |               | HTVECINTC |                 |
> + |               +-----------+                 |
> + |                ^         ^                  |
> + |                |         |                  |
> + |          +---------+ +---------+            |
> + |          | PCH-PIC | | PCH-MSI |            |
> + |          +---------+ +---------+            |
> + |            ^     ^           ^              |
> + |            |     |           |              |
> + |    +---------+ +---------+ +---------+      |
> + |    | PCH-LPC | | Devices | | Devices |      |
> + |    +---------+ +---------+ +---------+      |
> + |         ^                                   |
> + |         |                                   |
> + |    +---------+                              |
> + |    | Devices |                              |
> + |    +---------+                              |
> + |                                             |
> + |                                             |
> + +---------------------------------------------+
> +
> +=E6=89=A9=E5=B1=95IRQ=E6=A8=A1=E5=9E=8B
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E5=9C=A8=E8=BF=99=E7=A7=8D=E6=A8=A1=E5=9E=8B=E9=87=8C=E9=9D=A2=EF=BC=
=8CIPI=EF=BC=88Inter-Processor Interrupt=EF=BC=89=E5=92=8CCPU=E6=9C=AC=E5=
=9C=B0=E6=97=B6=E9=92=9F=E4=B8=AD=E6=96=AD=E7=9B=B4=E6=8E=A5=E5=8F=91=E9=
=80=81=E5=88=B0CPUINTC=EF=BC=8C
> +CPU=E4=B8=B2=E5=8F=A3=EF=BC=88UARTs=EF=BC=89=E4=B8=AD=E6=96=AD=E5=8F=91=
=E9=80=81=E5=88=B0LIOINTC=EF=BC=8C=E8=80=8C=E5=85=B6=E4=BB=96=E6=89=80=E6=
=9C=89=E8=AE=BE=E5=A4=87=E7=9A=84=E4=B8=AD=E6=96=AD=E5=88=99=E5=88=86=E5=
=88=AB=E5=8F=91=E9=80=81=E5=88=B0=E6=89=80=E8=BF=9E=E6=8E=A5=E7=9A=84PCH=
-PIC/
> +PCH-LPC/PCH-MSI=EF=BC=8C=E7=84=B6=E5=90=8E=E8=A2=ABEIOINTC=E7=BB=9F=E4=
=B8=80=E6=94=B6=E9=9B=86=EF=BC=8C=E5=86=8D=E7=9B=B4=E6=8E=A5=E5=88=B0=E8=
=BE=BECPUINTC=E3=80=82
> +
> + +--------------------------------------------------------+
> + |::                                                      |
> + |                                                        |
> + |         +-----+     +---------+     +-------+          |
> + |         | IPI | --> | CPUINTC | <-- | Timer |          |
> + |         +-----+     +---------+     +-------+          |
> + |                      ^       ^                         |
> + |                      |       |                         |
> + |               +---------+ +---------+     +-------+    |
> + |               | EIOINTC | | LIOINTC | <-- | UARTs |    |
> + |               +---------+ +---------+     +-------+    |
> + |                ^       ^                               |
> + |                |       |                               |
> + |         +---------+ +---------+                        |
> + |         | PCH-PIC | | PCH-MSI |                        |
> + |         +---------+ +---------+                        |
> + |           ^     ^           ^                          |
> + |           |     |           |                          |
> + |   +---------+ +---------+ +---------+                  |
> + |   | PCH-LPC | | Devices | | Devices |                  |
> + |   +---------+ +---------+ +---------+                  |
> + |        ^                                               |
> + |        |                                               |
> + |   +---------+                                          |
> + |   | Devices |                                          |
> + |   +---------+                                          |
> + |                                                        |
> + |                                                        |
> + +--------------------------------------------------------+
> +
> +ACPI=E7=9B=B8=E5=85=B3=E7=9A=84=E5=AE=9A=E4=B9=89
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +CPUINTC::
> +
> +  ACPI_MADT_TYPE_CORE_PIC;
> +  struct acpi_madt_core_pic;
> +  enum acpi_madt_core_pic_version;
> +
> +LIOINTC::
> +
> +  ACPI_MADT_TYPE_LIO_PIC;
> +  struct acpi_madt_lio_pic;
> +  enum acpi_madt_lio_pic_version;
> +
> +EIOINTC::
> +
> +  ACPI_MADT_TYPE_EIO_PIC;
> +  struct acpi_madt_eio_pic;
> +  enum acpi_madt_eio_pic_version;
> +
> +HTVECINTC::
> +
> +  ACPI_MADT_TYPE_HT_PIC;
> +  struct acpi_madt_ht_pic;
> +  enum acpi_madt_ht_pic_version;
> +
> +PCH-PIC::
> +
> +  ACPI_MADT_TYPE_BIO_PIC;
> +  struct acpi_madt_bio_pic;
> +  enum acpi_madt_bio_pic_version;
> +
> +PCH-MSI::
> +
> +  ACPI_MADT_TYPE_MSI_PIC;
> +  struct acpi_madt_msi_pic;
> +  enum acpi_madt_msi_pic_version;
> +
> +PCH-LPC::
> +
> +  ACPI_MADT_TYPE_LPC_PIC;
> +  struct acpi_madt_lpc_pic;
> +  enum acpi_madt_lpc_pic_version;
> +
> +=E5=8F=82=E8=80=83=E6=96=87=E7=8C=AE
> +=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +=E9=BE=99=E8=8A=AF3A5000=E7=9A=84=E6=96=87=E6=A1=A3=EF=BC=9A
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-3A5000-usermanual-1.02-CN.pdf=20
> (=E4=B8=AD=E6=96=87=E7=89=88)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-3A5000-usermanual-1.02-EN.pdf=20
> (=E8=8B=B1=E6=96=87=E7=89=88)
> +
> +=E9=BE=99=E8=8A=AFLS7A=E8=8A=AF=E7=89=87=E7=BB=84=E7=9A=84=E6=96=87=E6=
=A1=A3=EF=BC=9A
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-7A1000-usermanual-2.00-CN.pdf=20
> (=E4=B8=AD=E6=96=87=E7=89=88)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-7A1000-usermanual-2.00-EN.pdf=20
> (=E8=8B=B1=E6=96=87=E7=89=88)
> +
> +=E6=B3=A8=EF=BC=9ACPUINTC=E5=8D=B3=E3=80=8A=E9=BE=99=E8=8A=AF=E6=9E=B6=
=E6=9E=84=E5=8F=82=E8=80=83=E6=89=8B=E5=86=8C=E5=8D=B7=E4=B8=80=E3=80=8B=
=E7=AC=AC7.4=E8=8A=82=E6=89=80=E6=8F=8F=E8=BF=B0=E7=9A=84CSR.ECFG/CSR.ES=
TAT=E5=AF=84=E5=AD=98=E5=99=A8=E5=8F=8A=E5=85=B6=E4=B8=AD=E6=96=AD
> +=E6=8E=A7=E5=88=B6=E9=80=BB=E8=BE=91=EF=BC=9BLIOINTC=E5=8D=B3=E3=80=8A=
=E9=BE=99=E8=8A=AF3A5000=E5=A4=84=E7=90=86=E5=99=A8=E4=BD=BF=E7=94=A8=E6=
=89=8B=E5=86=8C=E3=80=8B=E7=AC=AC11.1=E8=8A=82=E6=89=80=E6=8F=8F=E8=BF=B0=
=E7=9A=84=E2=80=9C=E4=BC=A0=E7=BB=9FI/O=E4=B8=AD=E6=96=AD=E2=80=9D=EF=BC=
=9BEIOINTC
> +=E5=8D=B3=E3=80=8A=E9=BE=99=E8=8A=AF3A5000=E5=A4=84=E7=90=86=E5=99=A8=
=E4=BD=BF=E7=94=A8=E6=89=8B=E5=86=8C=E3=80=8B=E7=AC=AC11.2=E8=8A=82=E6=89=
=80=E6=8F=8F=E8=BF=B0=E7=9A=84=E2=80=9C=E6=89=A9=E5=B1=95I/O=E4=B8=AD=E6=
=96=AD=E2=80=9D=EF=BC=9BHTVECINTC=E5=8D=B3=E3=80=8A=E9=BE=99=E8=8A=AF3A5=
000
> +=E5=A4=84=E7=90=86=E5=99=A8=E4=BD=BF=E7=94=A8=E6=89=8B=E5=86=8C=E3=80=
=8B=E7=AC=AC14.3=E8=8A=82=E6=89=80=E6=8F=8F=E8=BF=B0=E7=9A=84=E2=80=9CHy=
perTransport=E4=B8=AD=E6=96=AD=E2=80=9D=EF=BC=9BPCH-PIC/PCH-MSI=E5=8D=B3=
=E3=80=8A=E9=BE=99=E8=8A=AF7A1000=E6=A1=A5
> +=E7=89=87=E7=94=A8=E6=88=B7=E6=89=8B=E5=86=8C=E3=80=8B=E7=AC=AC5=E7=AB=
=A0=E6=89=80=E6=8F=8F=E8=BF=B0=E7=9A=84=E2=80=9C=E4=B8=AD=E6=96=AD=E6=8E=
=A7=E5=88=B6=E5=99=A8=E2=80=9D=EF=BC=9BPCH-LPC=E5=8D=B3=E3=80=8A=E9=BE=99=
=E8=8A=AF7A1000=E6=A1=A5=E7=89=87=E7=94=A8=E6=88=B7=E6=89=8B=E5=86=8C=E3=
=80=8B=E7=AC=AC24.3=E8=8A=82=E6=89=80
> +=E6=8F=8F=E8=BF=B0=E7=9A=84=E2=80=9CLPC=E4=B8=AD=E6=96=AD=E2=80=9D=E3=
=80=82
> --=20
> 2.27.0

--=20
- Jiaxun
