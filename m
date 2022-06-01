Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF5953A4AB
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351904AbiFAMQa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348712AbiFAMQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:16:29 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42ADE5D1AC;
        Wed,  1 Jun 2022 05:16:25 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id A494E5C012C;
        Wed,  1 Jun 2022 08:16:24 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:16:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654085784; x=
        1654172184; bh=y2U8Le8CIHYnPh9HSXzsC7zhQcTy1of33ajb9uj2/qc=; b=1
        5ECkuVoBAiLy7kpFhSPFfTz06B81ry3MhFZv/mLolrIV8EGvrjn4WWsLQefVjHgv
        3JFlqfSMUqhkQRnNj30R25yVGxXA5qIpKaD/OawieiGeTh7W/N9lJyy71NcLGbyV
        wge97Yv60md7Joj25RAnmDM+EvRy5kZyby9m73geo7J0Ir3ArZ4Ol+LKuPakdGl2
        Le51MFA2d6wNpZiUxAjvjAnernHe1daBMf/y1TEr0unEMdsKD1c7U4zk01QxokuO
        hHCBJoIF6FWqFTLbveXWrJnSArPDW8nvvc1A/c1GrQVgYIeBP/HevfocZdDqOoro
        aDQ4nQMMJI+rmrjI5yCVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654085784; x=
        1654172184; bh=y2U8Le8CIHYnPh9HSXzsC7zhQcTy1of33ajb9uj2/qc=; b=V
        DELvJPUTlSPP2lrD4z5XRngEIfLTc8/bYrLxw9Kk5aU/7dEJlhnnbIeyT/xfGWAs
        zTAdZyER5mMlAc25kdIc+/dkZb601BhUgaGV/CsgLiJBExpZgkE9ZCZd31IWRRLF
        BYrgBa8qMFkYexfVoBglkLzQUdpMPGiqY6dLPpa8an2iyCi5jD5OA9sWSYPv7JRs
        K6VxhVLiDe2DsvPY38K/QS8MUsxYsTUxnuf8nnmdwnduikfNkDQ39quRVn77LUGe
        YvKdJn3QF6L3j4OvwJHWndOzgSkW/b1ynY2TRNi2a7UPITT0EUg6tfd8m88b2Yf+
        UfcaCHbaSgqQYWkaHN5VA==
X-ME-Sender: <xms:l1iXYkJ-nIV1VTtIe_zNm6ysHD1bP40K82Lbjomton6V9yydlFLOWw>
    <xme:l1iXYkIq32VD8O7n9DcmHu-d3VSrB2ZVhVFiPUy4BnWXeqsMxY7PuwxVJOwv9NMza
    hZai1Beo5NFf8YnM78>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffvvefu
    tgfgsehtqhertderreejnecuhfhrohhmpedflfhirgiguhhnucgjrghnghdfuceojhhirg
    iguhhnrdihrghnghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepgedv
    gefhuedtffeffefguddtveejleevueefffetvdfhgeeutedtteeghfehfeeinecuffhomh
    grihhnpehlohhonhhgshhonhdrtghnpdhlohhonhhgnhhigidrtghnpdhgihhthhhusgdr
    tghomhdpghhithhhuhgsrdhiohdpkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhl
    hihgohgrthdrtghomh
X-ME-Proxy: <xmx:l1iXYkuiNAheg3CW5qKEz0jmsKJtwZRLXEMnc4MT_yWiAvtYumVSQw>
    <xmx:l1iXYhboP7R2rFHtWdxefw-wHRZyi-B_SJiII2WypRCfJ8m417XTkQ>
    <xmx:l1iXYrZZRW5mwV34fMHlzaZSdUNgqNrN3s0CoeznZcpRucZd1Qxd-w>
    <xmx:mFiXYjLdULA152VoUYuaMA_tSKYMxGyI81FWc0r6amFIm6aOZLpoRA>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id B3FF536A006D; Wed,  1 Jun 2022 08:16:23 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <db505508-f19e-437f-96c8-a6ff48c7870c@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-4-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-4-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:16:03 +0100
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
        "WANG Xuerui" <git@xen0n.name>
Subject: Re: [PATCH V12 03/24] Documentation: LoongArch: Add basic documentations
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
> Add some basic documentation for LoongArch. LoongArch is a new RISC IS=
A,
> which is a bit like MIPS or RISC-V. LoongArch includes a reduced 32-bit
> version (LA32R), a standard 32-bit version (LA32S) and a 64-bit version
> (LA64).
>
> Co-developed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

Did proofread, perfect!
Thanks.

> ---
>  Documentation/arch.rst                     |   1 +
>  Documentation/loongarch/features.rst       |   3 +
>  Documentation/loongarch/index.rst          |  21 ++
>  Documentation/loongarch/introduction.rst   | 387 +++++++++++++++++++++
>  Documentation/loongarch/irq-chip-model.rst | 168 +++++++++
>  5 files changed, 580 insertions(+)
>  create mode 100644 Documentation/loongarch/features.rst
>  create mode 100644 Documentation/loongarch/index.rst
>  create mode 100644 Documentation/loongarch/introduction.rst
>  create mode 100644 Documentation/loongarch/irq-chip-model.rst
>
> diff --git a/Documentation/arch.rst b/Documentation/arch.rst
> index 14bcd8294b93..41a66a8b38e4 100644
> --- a/Documentation/arch.rst
> +++ b/Documentation/arch.rst
> @@ -13,6 +13,7 @@ implementation.
>     arm/index
>     arm64/index
>     ia64/index
> +   loongarch/index
>     m68k/index
>     mips/index
>     nios2/index
> diff --git a/Documentation/loongarch/features.rst=20
> b/Documentation/loongarch/features.rst
> new file mode 100644
> index 000000000000..ebacade3ea45
> --- /dev/null
> +++ b/Documentation/loongarch/features.rst
> @@ -0,0 +1,3 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +.. kernel-feat:: $srctree/Documentation/features loongarch
> diff --git a/Documentation/loongarch/index.rst=20
> b/Documentation/loongarch/index.rst
> new file mode 100644
> index 000000000000..aaba648db907
> --- /dev/null
> +++ b/Documentation/loongarch/index.rst
> @@ -0,0 +1,21 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +LoongArch Architecture
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> diff --git a/Documentation/loongarch/introduction.rst=20
> b/Documentation/loongarch/introduction.rst
> new file mode 100644
> index 000000000000..b4df5b459677
> --- /dev/null
> +++ b/Documentation/loongarch/introduction.rst
> @@ -0,0 +1,387 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +Introduction to LoongArch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
> +
> +LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V. Ther=
e=20
> are
> +currently 3 variants: a reduced 32-bit version (LA32R), a standard=20
> 32-bit
> +version (LA32S) and a 64-bit version (LA64). There are 4 privilege=20
> levels
> +(PLVs) defined in LoongArch: PLV0~PLV3, from high to low. Kernel runs=20
> at PLV0
> +while applications run at PLV3. This document introduces the=20
> registers, basic
> +instruction set, virtual memory and some other topics of LoongArch.
> +
> +Registers
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch registers include general purpose registers (GPRs), floatin=
g=20
> point
> +registers (FPRs), vector registers (VRs) and control status registers=20
> (CSRs)
> +used in privileged mode (PLV0).
> +
> +GPRs
> +----
> +
> +LoongArch has 32 GPRs ( ``$r0`` ~ ``$r31`` ); each one is 32-bit wide=20
> in LA32
> +and 64-bit wide in LA64. ``$r0`` is hard-wired to zero, and the other=20
> registers
> +are not architecturally special. (Except ``$r1``, which is hard-wired=20
> as the
> +link register of the BL instruction.)
> +
> +The kernel uses a variant of the LoongArch register convention, as=20
> described in
> +the LoongArch ELF psABI spec, in :ref:`References=20
> <loongarch-references>`:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name              Alias           Usage               Preserved
> +                                                      across calls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``$r0``           ``$zero``       Constant zero       Unused
> +``$r1``           ``$ra``         Return address      No
> +``$r2``           ``$tp``         TLS/Thread pointer  Unused
> +``$r3``           ``$sp``         Stack pointer       Yes
> +``$r4``-``$r11``  ``$a0``-``$a7`` Argument registers  No
> +``$r4``-``$r5``   ``$v0``-``$v1`` Return value        No
> +``$r12``-``$r20`` ``$t0``-``$t8`` Temp registers      No
> +``$r21``          ``$u0``         Percpu base address Unused
> +``$r22``          ``$fp``         Frame pointer       Yes
> +``$r23``-``$r31`` ``$s0``-``$s8`` Static registers    Yes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Note: The register ``$r21`` is reserved in the ELF psABI, but used by=20
> the Linux
> +kernel for storing the percpu base address. It normally has no ABI=20
> name, but is
> +called ``$u0`` in the kernel. You may also see ``$v0`` or ``$v1`` in=20
> some old code,
> +they are deprecated aliases of ``$a0`` and ``$a1`` respectively.
> +
> +FPRs
> +----
> +
> +LoongArch has 32 FPRs ( ``$f0`` ~ ``$f31`` ) when FPU is present. Eac=
h=20
> one is
> +64-bit wide on the LA64 cores.
> +
> +The floating-point register convention is the same as described in the
> +LoongArch ELF psABI spec:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name              Alias              Usage               Preserved
> +                                                         across calls
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``$f0``-``$f7``   ``$fa0``-``$fa7``  Argument registers  No
> +``$f0``-``$f1``   ``$fv0``-``$fv1``  Return value        No
> +``$f8``-``$f23``  ``$ft0``-``$ft15`` Temp registers      No
> +``$f24``-``$f31`` ``$fs0``-``$fs7``  Static registers    Yes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Note: You may see ``$fv0`` or ``$fv1`` in some old code, they are=20
> deprecated
> +aliases of ``$fa0`` and ``$fa1`` respectively.
> +
> +VRs
> +----
> +
> +There are currently 2 vector extensions to LoongArch:
> +
> +- LSX (Loongson SIMD eXtension) with 128-bit vectors,
> +- LASX (Loongson Advanced SIMD eXtension) with 256-bit vectors.
> +
> +LSX brings ``$v0`` ~ ``$v31`` while LASX brings ``$x0`` ~ ``$x31`` as=20
> the vector
> +registers.
> +
> +The VRs overlap with FPRs: for example, on a core implementing LSX an=
d=20
> LASX,
> +the lower 128 bits of ``$x0`` is shared with ``$v0``, and the lower 6=
4=20
> bits of
> +``$v0`` is shared with ``$f0``; same with all other VRs.
> +
> +CSRs
> +----
> +
> +CSRs can only be accessed from privileged mode (PLV0):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Address           Full Name                             Abbrev Name
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +0x0               Current Mode Information              CRMD
> +0x1               Pre-exception Mode Information        PRMD
> +0x2               Extension Unit Enable                 EUEN
> +0x3               Miscellaneous Control                 MISC
> +0x4               Exception Configuration               ECFG
> +0x5               Exception Status                      ESTAT
> +0x6               Exception Return Address              ERA
> +0x7               Bad (Faulting) Virtual Address        BADV
> +0x8               Bad (Faulting) Instruction Word       BADI
> +0xC               Exception Entrypoint Address          EENTRY
> +0x10              TLB Index                             TLBIDX
> +0x11              TLB Entry High-order Bits             TLBEHI
> +0x12              TLB Entry Low-order Bits 0            TLBELO0
> +0x13              TLB Entry Low-order Bits 1            TLBELO1
> +0x18              Address Space Identifier              ASID
> +0x19              Page Global Directory Address for     PGDL
> +                  Lower-half Address Space
> +0x1A              Page Global Directory Address for     PGDH
> +                  Higher-half Address Space
> +0x1B              Page Global Directory Address         PGD
> +0x1C              Page Walk Control for Lower-          PWCL
> +                  half Address Space
> +0x1D              Page Walk Control for Higher-         PWCH
> +                  half Address Space
> +0x1E              STLB Page Size                        STLBPS
> +0x1F              Reduced Virtual Address Configuration RVACFG
> +0x20              CPU Identifier                        CPUID
> +0x21              Privileged Resource Configuration 1   PRCFG1
> +0x22              Privileged Resource Configuration 2   PRCFG2
> +0x23              Privileged Resource Configuration 3   PRCFG3
> +0x30+n (0=E2=89=A4n=E2=89=A415)   Saved Data register                =
   SAVEn
> +0x40              Timer Identifier                      TID
> +0x41              Timer Configuration                   TCFG
> +0x42              Timer Value                           TVAL
> +0x43              Compensation of Timer Count           CNTC
> +0x44              Timer Interrupt Clearing              TICLR
> +0x60              LLBit Control                         LLBCTL
> +0x80              Implementation-specific Control 1     IMPCTL1
> +0x81              Implementation-specific Control 2     IMPCTL2
> +0x88              TLB Refill Exception Entrypoint       TLBRENTRY
> +                  Address
> +0x89              TLB Refill Exception BAD (Faulting)   TLBRBADV
> +                  Virtual Address
> +0x8A              TLB Refill Exception Return Address   TLBRERA
> +0x8B              TLB Refill Exception Saved Data       TLBRSAVE
> +                  Register
> +0x8C              TLB Refill Exception Entry Low-order  TLBRELO0
> +                  Bits 0
> +0x8D              TLB Refill Exception Entry Low-order  TLBRELO1
> +                  Bits 1
> +0x8E              TLB Refill Exception Entry High-order TLBEHI
> +                  Bits
> +0x8F              TLB Refill Exception Pre-exception    TLBRPRMD
> +                  Mode Information
> +0x90              Machine Error Control                 MERRCTL
> +0x91              Machine Error Information 1           MERRINFO1
> +0x92              Machine Error Information 2           MERRINFO2
> +0x93              Machine Error Exception Entrypoint    MERRENTRY
> +                  Address
> +0x94              Machine Error Exception Return        MERRERA
> +                  Address
> +0x95              Machine Error Exception Saved Data    MERRSAVE
> +                  Register
> +0x98              Cache TAGs                            CTAG
> +0x180+n (0=E2=89=A4n=E2=89=A43)   Direct Mapping Configuration Window=
 n DMWn
> +0x200+2n (0=E2=89=A4n=E2=89=A431) Performance Monitor Configuration n=
   PMCFGn
> +0x201+2n (0=E2=89=A4n=E2=89=A431) Performance Monitor Overall Counter=
 n PMCNTn
> +0x300             Memory Load/Store WatchPoint          MWPC
> +                  Overall Control
> +0x301             Memory Load/Store WatchPoint          MWPS
> +                  Overall Status
> +0x310+8n (0=E2=89=A4n=E2=89=A47)  Memory Load/Store WatchPoint n     =
   MWPnCFG1
> +                  Configuration 1
> +0x311+8n (0=E2=89=A4n=E2=89=A47)  Memory Load/Store WatchPoint n     =
   MWPnCFG2
> +                  Configuration 2
> +0x312+8n (0=E2=89=A4n=E2=89=A47)  Memory Load/Store WatchPoint n     =
   MWPnCFG3
> +                  Configuration 3
> +0x313+8n (0=E2=89=A4n=E2=89=A47)  Memory Load/Store WatchPoint n     =
   MWPnCFG4
> +                  Configuration 4
> +0x380             Instruction Fetch WatchPoint          FWPC
> +                  Overall Control
> +0x381             Instruction Fetch WatchPoint          FWPS
> +                  Overall Status
> +0x390+8n (0=E2=89=A4n=E2=89=A47)  Instruction Fetch WatchPoint n     =
   FWPnCFG1
> +                  Configuration 1
> +0x391+8n (0=E2=89=A4n=E2=89=A47)  Instruction Fetch WatchPoint n     =
   FWPnCFG2
> +                  Configuration 2
> +0x392+8n (0=E2=89=A4n=E2=89=A47)  Instruction Fetch WatchPoint n     =
   FWPnCFG3
> +                  Configuration 3
> +0x393+8n (0=E2=89=A4n=E2=89=A47)  Instruction Fetch WatchPoint n     =
   FWPnCFG4
> +                  Configuration 4
> +0x500             Debug Register                        DBG
> +0x501             Debug Exception Return Address        DERA
> +0x502             Debug Exception Saved Data Register   DSAVE
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +ERA, TLBRERA, MERRERA and DERA are sometimes also known as EPC,=20
> TLBREPC, MERREPC
> +and DEPC respectively.
> +
> +Basic Instruction Set
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Instruction formats
> +-------------------
> +
> +LoongArch instructions are 32 bits wide, belonging to 9 basic=20
> instruction
> +formats (and variants of them):
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Format name Composition
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
> +Rd is the destination register operand, while Rj, Rk and Ra ("a"=20
> stands for
> +"additional") are the source register operands. I8/I12/I16/I21/I26 are
> +immediate operands of respective width. The longer I21 and I26 are=20
> stored
> +in separate higher and lower parts in the instruction word, denoted b=
y=20
> the "L"
> +and "H" suffixes.
> +
> +List of Instructions
> +--------------------
> +
> +For brevity, only instruction names (mnemonics) are listed here;=20
> please see the
> +:ref:`References <loongarch-references>` for details.
> +
> +
> +1. Arithmetic Instructions::
> +
> +    ADD.W SUB.W ADDI.W ADD.D SUB.D ADDI.D
> +    SLT SLTU SLTI SLTUI
> +    AND OR NOR XOR ANDN ORN ANDI ORI XORI
> +    MUL.W MULH.W MULH.WU DIV.W DIV.WU MOD.W MOD.WU
> +    MUL.D MULH.D MULH.DU DIV.D DIV.DU MOD.D MOD.DU
> +    PCADDI PCADDU12I PCADDU18I
> +    LU12I.W LU32I.D LU52I.D ADDU16I.D
> +
> +2. Bit-shift Instructions::
> +
> +    SLL.W SRL.W SRA.W ROTR.W SLLI.W SRLI.W SRAI.W ROTRI.W
> +    SLL.D SRL.D SRA.D ROTR.D SLLI.D SRLI.D SRAI.D ROTRI.D
> +
> +3. Bit-manipulation Instructions::
> +
> +    EXT.W.B EXT.W.H CLO.W CLO.D SLZ.W CLZ.D CTO.W CTO.D CTZ.W CTZ.D
> +    BYTEPICK.W BYTEPICK.D BSTRINS.W BSTRINS.D BSTRPICK.W BSTRPICK.D
> +    REVB.2H REVB.4H REVB.2W REVB.D REVH.2W REVH.D BITREV.4B BITREV.8B=20
> BITREV.W BITREV.D
> +    MASKEQZ MASKNEZ
> +
> +4. Branch Instructions::
> +
> +    BEQ BNE BLT BGE BLTU BGEU BEQZ BNEZ B BL JIRL
> +
> +5. Load/Store Instructions::
> +
> +    LD.B LD.BU LD.H LD.HU LD.W LD.WU LD.D ST.B ST.H ST.W ST.D
> +    LDX.B LDX.BU LDX.H LDX.HU LDX.W LDX.WU LDX.D STX.B STX.H STX.W=20
> STX.D
> +    LDPTR.W LDPTR.D STPTR.W STPTR.D
> +    PRELD PRELDX
> +
> +6. Atomic Operation Instructions::
> +
> +    LL.W SC.W LL.D SC.D
> +    AMSWAP.W AMSWAP.D AMADD.W AMADD.D AMAND.W AMAND.D AMOR.W AMOR.D=20
> AMXOR.W AMXOR.D
> +    AMMAX.W AMMAX.D AMMIN.W AMMIN.D
> +
> +7. Barrier Instructions::
> +
> +    IBAR DBAR
> +
> +8. Special Instructions::
> +
> +    SYSCALL BREAK CPUCFG NOP IDLE ERTN(ERET) DBCL(DBGCALL) RDTIMEL.W=20
> RDTIMEH.W RDTIME.D
> +    ASRTLE.D ASRTGT.D
> +
> +9. Privileged Instructions::
> +
> +    CSRRD CSRWR CSRXCHG
> +    IOCSRRD.B IOCSRRD.H IOCSRRD.W IOCSRRD.D IOCSRWR.B IOCSRWR.H=20
> IOCSRWR.W IOCSRWR.D
> +    CACOP TLBP(TLBSRCH) TLBRD TLBWR TLBFILL TLBCLR TLBFLUSH INVTLB=20
> LDDIR LDPTE
> +
> +Virtual Memory
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch supports direct-mapped virtual memory and page-mapped=20
> virtual memory.
> +
> +Direct-mapped virtual memory is configured by CSR.DMWn (n=3D0~3), it =
has=20
> a simple
> +relationship between virtual address (VA) and physical address (PA)::
> +
> + VA =3D PA + FixedOffset
> +
> +Page-mapped virtual memory has arbitrary relationship between VA and=20
> PA, which
> +is recorded in TLB and page tables. LoongArch's TLB includes a=20
> fully-associative
> +MTLB (Multiple Page Size TLB) and set-associative STLB (Single Page=20
> Size TLB).
> +
> +By default, the whole virtual address space of LA32 is configured lik=
e=20
> this:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name         Address Range               Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``UVRANGE``  ``0x00000000 - 0x7FFFFFFF`` Page-mapped, Cached, PLV0~3
> +``KPRANGE0`` ``0x80000000 - 0x9FFFFFFF`` Direct-mapped, Uncached, PLV0
> +``KPRANGE1`` ``0xA0000000 - 0xBFFFFFFF`` Direct-mapped, Cached, PLV0
> +``KVRANGE``  ``0xC0000000 - 0xFFFFFFFF`` Page-mapped, Cached, PLV0
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +User mode (PLV3) can only access UVRANGE. For direct-mapped KPRANGE0=20
> and
> +KPRANGE1, PA is equal to VA with bit30~31 cleared. For example, the=20
> uncached
> +direct-mapped VA of 0x00001000 is 0x80001000, and the cached=20
> direct-mapped
> +VA of 0x00001000 is 0xA0001000.
> +
> +By default, the whole virtual address space of LA64 is configured lik=
e=20
> this:
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Name         Address Range          Attributes
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +``XUVRANGE`` ``0x0000000000000000 - Page-mapped, Cached, PLV0~3
> +             0x3FFFFFFFFFFFFFFF``
> +``XSPRANGE`` ``0x4000000000000000 - Direct-mapped, Cached / Uncached,=20
> PLV0
> +             0x7FFFFFFFFFFFFFFF``
> +``XKPRANGE`` ``0x8000000000000000 - Direct-mapped, Cached / Uncached,=20
> PLV0
> +             0xBFFFFFFFFFFFFFFF``
> +``XKVRANGE`` ``0xC000000000000000 - Page-mapped, Cached, PLV0
> +             0xFFFFFFFFFFFFFFFF``
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +User mode (PLV3) can only access XUVRANGE. For direct-mapped XSPRANGE=20
> and
> +XKPRANGE, PA is equal to VA with bits 60~63 cleared, and the cache=20
> attribute
> +is configured by bits 60~61 in VA: 0 is for strongly-ordered uncached=
,=20
> 1 is
> +for coherent cached, and 2 is for weakly-ordered uncached.
> +
> +Currently we only use XKPRANGE for direct mapping and XSPRANGE is=20
> reserved.
> +
> +To put this in action: the strongly-ordered uncached direct-mapped VA=20
> (in
> +XKPRANGE) of 0x00000000_00001000 is 0x80000000_00001000, the coherent=20
> cached
> +direct-mapped VA (in XKPRANGE) of 0x00000000_00001000 is=20
> 0x90000000_00001000,
> +and the weakly-ordered uncached direct-mapped VA (in XKPRANGE) of=20
> 0x00000000
> +_00001000 is 0xA0000000_00001000.
> +
> +Relationship of Loongson and LoongArch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +LoongArch is a RISC ISA which is different from any other existing=20
> ones, while
> +Loongson is a family of processors. Loongson includes 3 series:=20
> Loongson-1 is
> +the 32-bit processor series, Loongson-2 is the low-end 64-bit=20
> processor series,
> +and Loongson-3 is the high-end 64-bit processor series. Old Loongson=20
> is based on
> +MIPS, while New Loongson is based on LoongArch. Take Loongson-3 as an=20
> example:
> +Loongson-3A1000/3B1500/3A2000/3A3000/3A4000 are MIPS-compatible, whil=
e=20
> Loongson-
> +3A5000 (and future revisions) are all based on LoongArch.
> +
> +.. _loongarch-references:
> +
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Official web site of Loongson Technology Corp. Ltd.:
> +
> +  http://www.loongson.cn/
> +
> +Developer web site of Loongson and LoongArch (Software and=20
> Documentation):
> +
> +  http://www.loongnix.cn/
> +
> +  https://github.com/loongson/
> +
> +  https://loongson.github.io/LoongArch-Documentation/
> +
> +Documentation of LoongArch ISA:
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-Vol1-v1.00-CN.pdf=20
> (in Chinese)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-Vol1-v1.00-EN.pdf=20
> (in English)
> +
> +Documentation of LoongArch ELF psABI:
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-ELF-ABI-v1.00-CN.pdf=20
> (in Chinese)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/LoongArch-ELF-ABI-v1.00-EN.pdf=20
> (in English)
> +
> +Linux kernel repository of Loongson and LoongArch:
> +
> + =20
> https://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loong=
son.git
> diff --git a/Documentation/loongarch/irq-chip-model.rst=20
> b/Documentation/loongarch/irq-chip-model.rst
> new file mode 100644
> index 000000000000..35c962991283
> --- /dev/null
> +++ b/Documentation/loongarch/irq-chip-model.rst
> @@ -0,0 +1,168 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +IRQ chip model (hierarchy) of LoongArch
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Currently, LoongArch based processors (e.g. Loongson-3A5000) can only=20
> work together
> +with LS7A chipsets. The irq chips in LoongArch computers include=20
> CPUINTC (CPU Core
> +Interrupt Controller), LIOINTC (Legacy I/O Interrupt Controller),=20
> EIOINTC (Extended
> +I/O Interrupt Controller), HTVECINTC (Hyper-Transport Vector Interrup=
t=20
> Controller),
> +PCH-PIC (Main Interrupt Controller in LS7A chipset), PCH-LPC (LPC=20
> Interrupt Controller
> +in LS7A chipset) and PCH-MSI (MSI Interrupt Controller).
> +
> +CPUINTC is a per-core controller (in CPU), LIOINTC/EIOINTC/HTVECINTC=20
> are per-package
> +controllers (in CPU), while PCH-PIC/PCH-LPC/PCH-MSI are controllers=20
> out of CPU (i.e.,
> +in chipsets). These controllers (in other words, irqchips) are linked=20
> in a hierarchy,
> +and there are two models of hierarchy (legacy model and extended=20
> model).
> +
> +Legacy IRQ model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer=20
> interrupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all=20
> other devices
> +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by HTVECINTC,=20
> and then go
> +to LIOINTC, and then CPUINTC.
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
> +Extended IRQ model
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +In this model, IPI (Inter-Processor Interrupt) and CPU Local Timer=20
> interrupt go
> +to CPUINTC directly, CPU UARTS interrupts go to LIOINTC, while all=20
> other devices
> +interrupts go to PCH-PIC/PCH-LPC/PCH-MSI and gathered by EIOINTC, and=20
> then go to
> +to CPUINTC directly.
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
> +ACPI-related definitions
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
> +References
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Documentation of Loongson-3A5000:
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-3A5000-usermanual-1.02-CN.pdf=20
> (in Chinese)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-3A5000-usermanual-1.02-EN.pdf=20
> (in English)
> +
> +Documentation of Loongson's LS7A chipset:
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-7A1000-usermanual-2.00-CN.pdf=20
> (in Chinese)
> +
> + =20
> https://github.com/loongson/LoongArch-Documentation/releases/latest/do=
wnload/Loongson-7A1000-usermanual-2.00-EN.pdf=20
> (in English)
> +
> +Note: CPUINTC is CSR.ECFG/CSR.ESTAT and its interrupt controller=20
> described
> +in Section 7.4 of "LoongArch Reference Manual, Vol 1"; LIOINTC is=20
> "Legacy I/O
> +Interrupts" described in Section 11.1 of "Loongson 3A5000 Processor=20
> Reference
> +Manual"; EIOINTC is "Extended I/O Interrupts" described in Section=20
> 11.2 of
> +"Loongson 3A5000 Processor Reference Manual"; HTVECINTC is=20
> "HyperTransport
> +Interrupts" described in Section 14.3 of "Loongson 3A5000 Processor=20
> Reference
> +Manual"; PCH-PIC/PCH-MSI is "Interrupt Controller" described in=20
> Section 5 of
> +"Loongson 7A1000 Bridge User Manual"; PCH-LPC is "LPC Interrupts"=20
> described in
> +Section 24.3 of "Loongson 7A1000 Bridge User Manual".
> --=20
> 2.27.0

--=20
- Jiaxun
