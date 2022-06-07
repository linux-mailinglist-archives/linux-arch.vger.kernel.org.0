Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE77F53A4EC
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344227AbiFAM1y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiFAM1x (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:27:53 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F7355D199;
        Wed,  1 Jun 2022 05:27:50 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C00B35C025E;
        Wed,  1 Jun 2022 08:27:49 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:27:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086469; x=
        1654172869; bh=2JwvFs61kn4h6ZGMwoIh3rsPUxCERM1IRjYwY2xk8uQ=; b=l
        o4UXj/0RrJEyG2p9ahChv7CZJji0hvBj3+D+21h4U0Sast22BnzTBEEgWThXK2lX
        b2HSIc1Bohg5ZGlHH2qiyyJAHDFkplhD0J6zWQUUC0IV8Q7cFt6HfLMutv8D4VhW
        tegnzotW1Foo+6muqXUU+0E0gaKLeSWUsZZZqCUCj+hEa0e5gXrlsO8BwBYyNPWE
        DOrhkm2/4HK5iNoahugxuygpDGOoAjAQx15QzXi1beStSNYcIqnp34/x+qjJEctE
        /CG0XuisZkqg5Kve4pMi+OKjJ+WgHUE3UFz+GrR9l8teLrJjHQMsp1LWko42ezwV
        pPRgeioPkOKDqQduaoe4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086469; x=
        1654172869; bh=2JwvFs61kn4h6ZGMwoIh3rsPUxCERM1IRjYwY2xk8uQ=; b=N
        r03/ATdo5B38ODXU1iefqsV1sHHH7xMwzqdeCbk0hIhB7bqSOWO5xlkqyDf62G8u
        vFfxTbl6UZB128LYWoADwFxBA2IWPoC9bSuk2bLPuPfbs5jYPEIwxReLfw9PjtDC
        M0+fhkM3ziOnlly95N8UC4ZIN8OrX3HFIkMXfbXcE7BniPdbSeoDDwMokSZVt47e
        tPhwekXGK7LRFN8JNnvgtLFQL2ntnEB4NI9S9eOe0tYbuN8VyKCUp4pxng1zrw7S
        SXvCXJy72oJ01eHNE6RAMMawLC+TUovcsA/pNTTGcDAckPaF/hr75QAjXDuxZG0D
        ryXxXuxhioBOWvoSg3T8A==
X-ME-Sender: <xms:RVuXYlTpBIEvT-pqOsdY9l-TdZAZpWVwDij3TX1BmKxKXxrg2uI-Vg>
    <xme:RVuXYuzsHpJYDqrF1lmK97kMjF8JDlAiKGPeuVFH54f6aqYuTBWtOot3YdyTL9ppC
    N4ln0Ff-wcf3kOVG-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:RVuXYq1A9wg5guHzxDRyn6BKLgwXKPsjU6QDB_HV4WzOtwTG-daH1g>
    <xmx:RVuXYtBjwd-AzZTu9g3N4KX9XwK-iQcyiYf8EYLRCb8_AC8nPd-y9w>
    <xmx:RVuXYugjCKUiX12T37sBgR4MRhuSv53PDBjHA2NlpSt0Xx32ygCo1w>
    <xmx:RVuXYlSSuzs5uILKvA4vvg99F6KbXWPERWzhtQtb2iQfPjcU0wxwQw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8D13B36A006D; Wed,  1 Jun 2022 08:27:49 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <b8546cd2-753d-4fd9-a34c-5bb8baada07c@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-11-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-11-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:27:28 +0100
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
Subject: Re: [PATCH V12 10/24] LoongArch: Add other common headers
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
> Add some other common headers for basic LoongArch support.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  arch/loongarch/include/asm/asm-prototypes.h   |   7 +
>  arch/loongarch/include/asm/asm.h              | 191 ++++++++++++
>  arch/loongarch/include/asm/asmmacro.h         | 289 ++++++++++++++++++
>  arch/loongarch/include/asm/clocksource.h      |  12 +
>  arch/loongarch/include/asm/compiler.h         |  15 +
>  arch/loongarch/include/asm/inst.h             | 117 +++++++
>  arch/loongarch/include/asm/linkage.h          |  36 +++
>  arch/loongarch/include/asm/perf_event.h       |  10 +
>  arch/loongarch/include/asm/prefetch.h         |  29 ++
>  arch/loongarch/include/asm/serial.h           |  11 +
>  arch/loongarch/include/asm/time.h             |  50 +++
>  arch/loongarch/include/asm/timex.h            |  33 ++
>  arch/loongarch/include/asm/topology.h         |  15 +
>  arch/loongarch/include/asm/types.h            |  19 ++
>  arch/loongarch/include/uapi/asm/bitsperlong.h |   9 +
>  arch/loongarch/include/uapi/asm/byteorder.h   |  13 +
>  arch/loongarch/include/uapi/asm/reg.h         |  59 ++++
>  tools/include/uapi/asm/bitsperlong.h          |   2 +
>  18 files changed, 917 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/asm-prototypes.h
>  create mode 100644 arch/loongarch/include/asm/asm.h
>  create mode 100644 arch/loongarch/include/asm/asmmacro.h
>  create mode 100644 arch/loongarch/include/asm/clocksource.h
>  create mode 100644 arch/loongarch/include/asm/compiler.h
>  create mode 100644 arch/loongarch/include/asm/inst.h
>  create mode 100644 arch/loongarch/include/asm/linkage.h
>  create mode 100644 arch/loongarch/include/asm/perf_event.h
>  create mode 100644 arch/loongarch/include/asm/prefetch.h
>  create mode 100644 arch/loongarch/include/asm/serial.h
>  create mode 100644 arch/loongarch/include/asm/time.h
>  create mode 100644 arch/loongarch/include/asm/timex.h
>  create mode 100644 arch/loongarch/include/asm/topology.h
>  create mode 100644 arch/loongarch/include/asm/types.h
>  create mode 100644 arch/loongarch/include/uapi/asm/bitsperlong.h
>  create mode 100644 arch/loongarch/include/uapi/asm/byteorder.h
>  create mode 100644 arch/loongarch/include/uapi/asm/reg.h
>
> diff --git a/arch/loongarch/include/asm/asm-prototypes.h=20
> b/arch/loongarch/include/asm/asm-prototypes.h
> new file mode 100644
> index 000000000000..ed06d3997420
> --- /dev/null
> +++ b/arch/loongarch/include/asm/asm-prototypes.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#include <linux/uaccess.h>
> +#include <asm/fpu.h>
> +#include <asm/mmu_context.h>
> +#include <asm/page.h>
> +#include <asm/ftrace.h>
> +#include <asm-generic/asm-prototypes.h>
> diff --git a/arch/loongarch/include/asm/asm.h=20
> b/arch/loongarch/include/asm/asm.h
> new file mode 100644
> index 000000000000..40eea6aa469e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/asm.h
> @@ -0,0 +1,191 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Some useful macros for LoongArch assembler code
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + *
> + * Derived from MIPS:
> + * Copyright (C) 1995, 1996, 1997, 1999, 2001 by Ralf Baechle
> + * Copyright (C) 1999 by Silicon Graphics, Inc.
> + * Copyright (C) 2001 MIPS Technologies, Inc.
> + * Copyright (C) 2002  Maciej W. Rozycki
> + */
> +#ifndef __ASM_ASM_H
> +#define __ASM_ASM_H
> +
> +/* LoongArch pref instruction. */
> +#ifdef CONFIG_CPU_HAS_PREFETCH
> +
> +#define PREF(hint, addr, offs)				\
> +		preld	hint, addr, offs;		\
> +
> +#define PREFX(hint, addr, index)			\
> +		preldx	hint, addr, index;		\
> +
> +#else /* !CONFIG_CPU_HAS_PREFETCH */
> +
> +#define PREF(hint, addr, offs)
> +#define PREFX(hint, addr, index)
> +
> +#endif /* !CONFIG_CPU_HAS_PREFETCH */
> +
> +/*
> + * Stack alignment
> + */
> +#define STACK_ALIGN	~(0xf)
> +
> +/*
> + * Macros to handle different pointer/register sizes for 32/64-bit co=
de
> + */
> +
> +/*
> + * Size of a register
> + */
> +#ifndef __loongarch64
> +#define SZREG	4
> +#else
> +#define SZREG	8
> +#endif
> +
> +/*
> + * Use the following macros in assemblercode to load/store registers,
> + * pointers etc.
> + */
> +#if (SZREG =3D=3D 4)
> +#define REG_L		ld.w
> +#define REG_S		st.w
> +#define REG_ADD		add.w
> +#define REG_SUB		sub.w
> +#else /* SZREG =3D=3D 8 */
> +#define REG_L		ld.d
> +#define REG_S		st.d
> +#define REG_ADD		add.d
> +#define REG_SUB		sub.d
> +#endif
> +
> +/*
> + * How to add/sub/load/store/shift C int variables.
> + */
> +#if (__SIZEOF_INT__ =3D=3D 4)
> +#define INT_ADD		add.w
> +#define INT_ADDI	addi.w
> +#define INT_SUB		sub.w
> +#define INT_L		ld.w
> +#define INT_S		st.w
> +#define INT_SLL		slli.w
> +#define INT_SLLV	sll.w
> +#define INT_SRL		srli.w
> +#define INT_SRLV	srl.w
> +#define INT_SRA		srai.w
> +#define INT_SRAV	sra.w
> +#endif
> +
> +#if (__SIZEOF_INT__ =3D=3D 8)
> +#define INT_ADD		add.d
> +#define INT_ADDI	addi.d
> +#define INT_SUB		sub.d
> +#define INT_L		ld.d
> +#define INT_S		st.d
> +#define INT_SLL		slli.d
> +#define INT_SLLV	sll.d
> +#define INT_SRL		srli.d
> +#define INT_SRLV	srl.d
> +#define INT_SRA		srai.d
> +#define INT_SRAV	sra.d
> +#endif
> +
> +/*
> + * How to add/sub/load/store/shift C long variables.
> + */
> +#if (__SIZEOF_LONG__ =3D=3D 4)
> +#define LONG_ADD	add.w
> +#define LONG_ADDI	addi.w
> +#define LONG_SUB	sub.w
> +#define LONG_L		ld.w
> +#define LONG_S		st.w
> +#define LONG_SLL	slli.w
> +#define LONG_SLLV	sll.w
> +#define LONG_SRL	srli.w
> +#define LONG_SRLV	srl.w
> +#define LONG_SRA	srai.w
> +#define LONG_SRAV	sra.w
> +
> +#ifdef __ASSEMBLY__
> +#define LONG		.word
> +#endif
> +#define LONGSIZE	4
> +#define LONGMASK	3
> +#define LONGLOG		2
> +#endif
> +
> +#if (__SIZEOF_LONG__ =3D=3D 8)
> +#define LONG_ADD	add.d
> +#define LONG_ADDI	addi.d
> +#define LONG_SUB	sub.d
> +#define LONG_L		ld.d
> +#define LONG_S		st.d
> +#define LONG_SLL	slli.d
> +#define LONG_SLLV	sll.d
> +#define LONG_SRL	srli.d
> +#define LONG_SRLV	srl.d
> +#define LONG_SRA	srai.d
> +#define LONG_SRAV	sra.d
> +
> +#ifdef __ASSEMBLY__
> +#define LONG		.dword
> +#endif
> +#define LONGSIZE	8
> +#define LONGMASK	7
> +#define LONGLOG		3
> +#endif
> +
> +/*
> + * How to add/sub/load/store/shift pointers.
> + */
> +#if (__SIZEOF_POINTER__ =3D=3D 4)
> +#define PTR_ADD		add.w
> +#define PTR_ADDI	addi.w
> +#define PTR_SUB		sub.w
> +#define PTR_L		ld.w
> +#define PTR_S		st.w
> +#define PTR_LI		li.w
> +#define PTR_SLL		slli.w
> +#define PTR_SLLV	sll.w
> +#define PTR_SRL		srli.w
> +#define PTR_SRLV	srl.w
> +#define PTR_SRA		srai.w
> +#define PTR_SRAV	sra.w
> +
> +#define PTR_SCALESHIFT	2
> +
> +#ifdef __ASSEMBLY__
> +#define PTR		.word
> +#endif
> +#define PTRSIZE		4
> +#define PTRLOG		2
> +#endif
> +
> +#if (__SIZEOF_POINTER__ =3D=3D 8)
> +#define PTR_ADD		add.d
> +#define PTR_ADDI	addi.d
> +#define PTR_SUB		sub.d
> +#define PTR_L		ld.d
> +#define PTR_S		st.d
> +#define PTR_LI		li.d
> +#define PTR_SLL		slli.d
> +#define PTR_SLLV	sll.d
> +#define PTR_SRL		srli.d
> +#define PTR_SRLV	srl.d
> +#define PTR_SRA		srai.d
> +#define PTR_SRAV	sra.d
> +
> +#define PTR_SCALESHIFT	3
> +
> +#ifdef __ASSEMBLY__
> +#define PTR		.dword
> +#endif
> +#define PTRSIZE		8
> +#define PTRLOG		3
> +#endif
> +
> +#endif /* __ASM_ASM_H */
> diff --git a/arch/loongarch/include/asm/asmmacro.h=20
> b/arch/loongarch/include/asm/asmmacro.h
> new file mode 100644
> index 000000000000..a1a04083bd67
> --- /dev/null
> +++ b/arch/loongarch/include/asm/asmmacro.h
> @@ -0,0 +1,289 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_ASMMACRO_H
> +#define _ASM_ASMMACRO_H
> +
> +#include <asm/asm-offsets.h>
> +#include <asm/regdef.h>
> +#include <asm/fpregdef.h>
> +#include <asm/loongarch.h>
> +
> +	.macro	parse_v var val
> +	\var	=3D \val
> +	.endm
> +
> +	.macro	parse_r var r
> +	\var	=3D -1
> +	.ifc	\r, $r0
> +	\var	=3D 0
> +	.endif
> +	.ifc	\r, $r1
> +	\var	=3D 1
> +	.endif
> +	.ifc	\r, $r2
> +	\var	=3D 2
> +	.endif
> +	.ifc	\r, $r3
> +	\var	=3D 3
> +	.endif
> +	.ifc	\r, $r4
> +	\var	=3D 4
> +	.endif
> +	.ifc	\r, $r5
> +	\var	=3D 5
> +	.endif
> +	.ifc	\r, $r6
> +	\var	=3D 6
> +	.endif
> +	.ifc	\r, $r7
> +	\var	=3D 7
> +	.endif
> +	.ifc	\r, $r8
> +	\var	=3D 8
> +	.endif
> +	.ifc	\r, $r9
> +	\var	=3D 9
> +	.endif
> +	.ifc	\r, $r10
> +	\var	=3D 10
> +	.endif
> +	.ifc	\r, $r11
> +	\var	=3D 11
> +	.endif
> +	.ifc	\r, $r12
> +	\var	=3D 12
> +	.endif
> +	.ifc	\r, $r13
> +	\var	=3D 13
> +	.endif
> +	.ifc	\r, $r14
> +	\var	=3D 14
> +	.endif
> +	.ifc	\r, $r15
> +	\var	=3D 15
> +	.endif
> +	.ifc	\r, $r16
> +	\var	=3D 16
> +	.endif
> +	.ifc	\r, $r17
> +	\var	=3D 17
> +	.endif
> +	.ifc	\r, $r18
> +	\var	=3D 18
> +	.endif
> +	.ifc	\r, $r19
> +	\var	=3D 19
> +	.endif
> +	.ifc	\r, $r20
> +	\var	=3D 20
> +	.endif
> +	.ifc	\r, $r21
> +	\var	=3D 21
> +	.endif
> +	.ifc	\r, $r22
> +	\var	=3D 22
> +	.endif
> +	.ifc	\r, $r23
> +	\var	=3D 23
> +	.endif
> +	.ifc	\r, $r24
> +	\var	=3D 24
> +	.endif
> +	.ifc	\r, $r25
> +	\var	=3D 25
> +	.endif
> +	.ifc	\r, $r26
> +	\var	=3D 26
> +	.endif
> +	.ifc	\r, $r27
> +	\var	=3D 27
> +	.endif
> +	.ifc	\r, $r28
> +	\var	=3D 28
> +	.endif
> +	.ifc	\r, $r29
> +	\var	=3D 29
> +	.endif
> +	.ifc	\r, $r30
> +	\var	=3D 30
> +	.endif
> +	.ifc	\r, $r31
> +	\var	=3D 31
> +	.endif
> +	.iflt	\var
> +	.error	"Unable to parse register name \r"
> +	.endif
> +	.endm
> +
> +	.macro	cpu_save_nonscratch thread
> +	stptr.d	s0, \thread, THREAD_REG23
> +	stptr.d	s1, \thread, THREAD_REG24
> +	stptr.d	s2, \thread, THREAD_REG25
> +	stptr.d	s3, \thread, THREAD_REG26
> +	stptr.d	s4, \thread, THREAD_REG27
> +	stptr.d	s5, \thread, THREAD_REG28
> +	stptr.d	s6, \thread, THREAD_REG29
> +	stptr.d	s7, \thread, THREAD_REG30
> +	stptr.d	s8, \thread, THREAD_REG31
> +	stptr.d	sp, \thread, THREAD_REG03
> +	stptr.d	fp, \thread, THREAD_REG22
> +	.endm
> +
> +	.macro	cpu_restore_nonscratch thread
> +	ldptr.d	s0, \thread, THREAD_REG23
> +	ldptr.d	s1, \thread, THREAD_REG24
> +	ldptr.d	s2, \thread, THREAD_REG25
> +	ldptr.d	s3, \thread, THREAD_REG26
> +	ldptr.d	s4, \thread, THREAD_REG27
> +	ldptr.d	s5, \thread, THREAD_REG28
> +	ldptr.d	s6, \thread, THREAD_REG29
> +	ldptr.d	s7, \thread, THREAD_REG30
> +	ldptr.d	s8, \thread, THREAD_REG31
> +	ldptr.d	ra, \thread, THREAD_REG01
> +	ldptr.d	sp, \thread, THREAD_REG03
> +	ldptr.d	fp, \thread, THREAD_REG22
> +	.endm
> +
> +	.macro fpu_save_csr thread tmp
> +	movfcsr2gr	\tmp, fcsr0
> +	stptr.w	\tmp, \thread, THREAD_FCSR
> +	.endm
> +
> +	.macro fpu_restore_csr thread tmp
> +	ldptr.w	\tmp, \thread, THREAD_FCSR
> +	movgr2fcsr	fcsr0, \tmp
> +	.endm
> +
> +	.macro fpu_save_cc thread tmp0 tmp1
> +	movcf2gr	\tmp0, $fcc0
> +	move	\tmp1, \tmp0
> +	movcf2gr	\tmp0, $fcc1
> +	bstrins.d	\tmp1, \tmp0, 15, 8
> +	movcf2gr	\tmp0, $fcc2
> +	bstrins.d	\tmp1, \tmp0, 23, 16
> +	movcf2gr	\tmp0, $fcc3
> +	bstrins.d	\tmp1, \tmp0, 31, 24
> +	movcf2gr	\tmp0, $fcc4
> +	bstrins.d	\tmp1, \tmp0, 39, 32
> +	movcf2gr	\tmp0, $fcc5
> +	bstrins.d	\tmp1, \tmp0, 47, 40
> +	movcf2gr	\tmp0, $fcc6
> +	bstrins.d	\tmp1, \tmp0, 55, 48
> +	movcf2gr	\tmp0, $fcc7
> +	bstrins.d	\tmp1, \tmp0, 63, 56
> +	stptr.d		\tmp1, \thread, THREAD_FCC
> +	.endm
> +
> +	.macro fpu_restore_cc thread tmp0 tmp1
> +	ldptr.d	\tmp0, \thread, THREAD_FCC
> +	bstrpick.d	\tmp1, \tmp0, 7, 0
> +	movgr2cf	$fcc0, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 15, 8
> +	movgr2cf	$fcc1, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 23, 16
> +	movgr2cf	$fcc2, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 31, 24
> +	movgr2cf	$fcc3, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 39, 32
> +	movgr2cf	$fcc4, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 47, 40
> +	movgr2cf	$fcc5, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 55, 48
> +	movgr2cf	$fcc6, \tmp1
> +	bstrpick.d	\tmp1, \tmp0, 63, 56
> +	movgr2cf	$fcc7, \tmp1
> +	.endm
> +
> +	.macro	fpu_save_double thread tmp
> +	li.w	\tmp, THREAD_FPR0
> +	PTR_ADD \tmp, \tmp, \thread
> +	fst.d	$f0, \tmp, THREAD_FPR0  - THREAD_FPR0
> +	fst.d	$f1, \tmp, THREAD_FPR1  - THREAD_FPR0
> +	fst.d	$f2, \tmp, THREAD_FPR2  - THREAD_FPR0
> +	fst.d	$f3, \tmp, THREAD_FPR3  - THREAD_FPR0
> +	fst.d	$f4, \tmp, THREAD_FPR4  - THREAD_FPR0
> +	fst.d	$f5, \tmp, THREAD_FPR5  - THREAD_FPR0
> +	fst.d	$f6, \tmp, THREAD_FPR6  - THREAD_FPR0
> +	fst.d	$f7, \tmp, THREAD_FPR7  - THREAD_FPR0
> +	fst.d	$f8, \tmp, THREAD_FPR8  - THREAD_FPR0
> +	fst.d	$f9, \tmp, THREAD_FPR9  - THREAD_FPR0
> +	fst.d	$f10, \tmp, THREAD_FPR10 - THREAD_FPR0
> +	fst.d	$f11, \tmp, THREAD_FPR11 - THREAD_FPR0
> +	fst.d	$f12, \tmp, THREAD_FPR12 - THREAD_FPR0
> +	fst.d	$f13, \tmp, THREAD_FPR13 - THREAD_FPR0
> +	fst.d	$f14, \tmp, THREAD_FPR14 - THREAD_FPR0
> +	fst.d	$f15, \tmp, THREAD_FPR15 - THREAD_FPR0
> +	fst.d	$f16, \tmp, THREAD_FPR16 - THREAD_FPR0
> +	fst.d	$f17, \tmp, THREAD_FPR17 - THREAD_FPR0
> +	fst.d	$f18, \tmp, THREAD_FPR18 - THREAD_FPR0
> +	fst.d	$f19, \tmp, THREAD_FPR19 - THREAD_FPR0
> +	fst.d	$f20, \tmp, THREAD_FPR20 - THREAD_FPR0
> +	fst.d	$f21, \tmp, THREAD_FPR21 - THREAD_FPR0
> +	fst.d	$f22, \tmp, THREAD_FPR22 - THREAD_FPR0
> +	fst.d	$f23, \tmp, THREAD_FPR23 - THREAD_FPR0
> +	fst.d	$f24, \tmp, THREAD_FPR24 - THREAD_FPR0
> +	fst.d	$f25, \tmp, THREAD_FPR25 - THREAD_FPR0
> +	fst.d	$f26, \tmp, THREAD_FPR26 - THREAD_FPR0
> +	fst.d	$f27, \tmp, THREAD_FPR27 - THREAD_FPR0
> +	fst.d	$f28, \tmp, THREAD_FPR28 - THREAD_FPR0
> +	fst.d	$f29, \tmp, THREAD_FPR29 - THREAD_FPR0
> +	fst.d	$f30, \tmp, THREAD_FPR30 - THREAD_FPR0
> +	fst.d	$f31, \tmp, THREAD_FPR31 - THREAD_FPR0
> +	.endm
> +
> +	.macro	fpu_restore_double thread tmp
> +	li.w	\tmp, THREAD_FPR0
> +	PTR_ADD \tmp, \tmp, \thread
> +	fld.d	$f0, \tmp, THREAD_FPR0  - THREAD_FPR0
> +	fld.d	$f1, \tmp, THREAD_FPR1  - THREAD_FPR0
> +	fld.d	$f2, \tmp, THREAD_FPR2  - THREAD_FPR0
> +	fld.d	$f3, \tmp, THREAD_FPR3  - THREAD_FPR0
> +	fld.d	$f4, \tmp, THREAD_FPR4  - THREAD_FPR0
> +	fld.d	$f5, \tmp, THREAD_FPR5  - THREAD_FPR0
> +	fld.d	$f6, \tmp, THREAD_FPR6  - THREAD_FPR0
> +	fld.d	$f7, \tmp, THREAD_FPR7  - THREAD_FPR0
> +	fld.d	$f8, \tmp, THREAD_FPR8  - THREAD_FPR0
> +	fld.d	$f9, \tmp, THREAD_FPR9  - THREAD_FPR0
> +	fld.d	$f10, \tmp, THREAD_FPR10 - THREAD_FPR0
> +	fld.d	$f11, \tmp, THREAD_FPR11 - THREAD_FPR0
> +	fld.d	$f12, \tmp, THREAD_FPR12 - THREAD_FPR0
> +	fld.d	$f13, \tmp, THREAD_FPR13 - THREAD_FPR0
> +	fld.d	$f14, \tmp, THREAD_FPR14 - THREAD_FPR0
> +	fld.d	$f15, \tmp, THREAD_FPR15 - THREAD_FPR0
> +	fld.d	$f16, \tmp, THREAD_FPR16 - THREAD_FPR0
> +	fld.d	$f17, \tmp, THREAD_FPR17 - THREAD_FPR0
> +	fld.d	$f18, \tmp, THREAD_FPR18 - THREAD_FPR0
> +	fld.d	$f19, \tmp, THREAD_FPR19 - THREAD_FPR0
> +	fld.d	$f20, \tmp, THREAD_FPR20 - THREAD_FPR0
> +	fld.d	$f21, \tmp, THREAD_FPR21 - THREAD_FPR0
> +	fld.d	$f22, \tmp, THREAD_FPR22 - THREAD_FPR0
> +	fld.d	$f23, \tmp, THREAD_FPR23 - THREAD_FPR0
> +	fld.d	$f24, \tmp, THREAD_FPR24 - THREAD_FPR0
> +	fld.d	$f25, \tmp, THREAD_FPR25 - THREAD_FPR0
> +	fld.d	$f26, \tmp, THREAD_FPR26 - THREAD_FPR0
> +	fld.d	$f27, \tmp, THREAD_FPR27 - THREAD_FPR0
> +	fld.d	$f28, \tmp, THREAD_FPR28 - THREAD_FPR0
> +	fld.d	$f29, \tmp, THREAD_FPR29 - THREAD_FPR0
> +	fld.d	$f30, \tmp, THREAD_FPR30 - THREAD_FPR0
> +	fld.d	$f31, \tmp, THREAD_FPR31 - THREAD_FPR0
> +	.endm
> +
> +.macro not dst src
> +	nor	\dst, \src, zero
> +.endm
> +
> +.macro bgt r0 r1 label
> +	blt	\r1, \r0, \label
> +.endm
> +
> +.macro bltz r0 label
> +	blt	\r0, zero, \label
> +.endm
> +
> +.macro bgez r0 label
> +	bge	\r0, zero, \label
> +.endm
> +
> +#endif /* _ASM_ASMMACRO_H */
> diff --git a/arch/loongarch/include/asm/clocksource.h=20
> b/arch/loongarch/include/asm/clocksource.h
> new file mode 100644
> index 000000000000..58e64aa05d26
> --- /dev/null
> +++ b/arch/loongarch/include/asm/clocksource.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_CLOCKSOURCE_H
> +#define __ASM_CLOCKSOURCE_H
> +
> +#include <asm/vdso/clocksource.h>
> +
> +#endif /* __ASM_CLOCKSOURCE_H */
> diff --git a/arch/loongarch/include/asm/compiler.h=20
> b/arch/loongarch/include/asm/compiler.h
> new file mode 100644
> index 000000000000..657cebe70ace
> --- /dev/null
> +++ b/arch/loongarch/include/asm/compiler.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_COMPILER_H
> +#define _ASM_COMPILER_H
> +
> +#define GCC_OFF_SMALL_ASM() "ZC"
> +
> +#define LOONGARCH_ISA_LEVEL "loongarch"
> +#define LOONGARCH_ISA_ARCH_LEVEL "arch=3Dloongarch"
> +#define LOONGARCH_ISA_LEVEL_RAW loongarch
> +#define LOONGARCH_ISA_ARCH_LEVEL_RAW LOONGARCH_ISA_LEVEL_RAW
> +
> +#endif /* _ASM_COMPILER_H */
> diff --git a/arch/loongarch/include/asm/inst.h=20
> b/arch/loongarch/include/asm/inst.h
> new file mode 100644
> index 000000000000..575d1bb66ffb
> --- /dev/null
> +++ b/arch/loongarch/include/asm/inst.h
> @@ -0,0 +1,117 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_INST_H
> +#define _ASM_INST_H
> +
> +#include <linux/types.h>
> +#include <asm/asm.h>
> +
> +#define ADDR_IMMMASK_LU52ID	0xFFF0000000000000
> +#define ADDR_IMMMASK_LU32ID	0x000FFFFF00000000
> +#define ADDR_IMMMASK_ADDU16ID	0x00000000FFFF0000
> +
> +#define ADDR_IMMSHIFT_LU52ID	52
> +#define ADDR_IMMSHIFT_LU32ID	32
> +#define ADDR_IMMSHIFT_ADDU16ID	16
> +
> +#define ADDR_IMM(addr, INSN)	((addr & ADDR_IMMMASK_##INSN) >>=20
> ADDR_IMMSHIFT_##INSN)
> +
> +enum reg1i20_op {
> +	lu12iw_op	=3D 0x0a,
> +	lu32id_op	=3D 0x0b,
> +};
> +
> +enum reg2i12_op {
> +	lu52id_op	=3D 0x0c,
> +};
> +
> +enum reg2i16_op {
> +	jirl_op		=3D 0x13,
> +};
> +
> +struct reg0i26_format {
> +	unsigned int immediate_h : 10;
> +	unsigned int immediate_l : 16;
> +	unsigned int opcode : 6;
> +};
> +
> +struct reg1i20_format {
> +	unsigned int rd : 5;
> +	unsigned int immediate : 20;
> +	unsigned int opcode : 7;
> +};
> +
> +struct reg1i21_format {
> +	unsigned int immediate_h  : 5;
> +	unsigned int rj : 5;
> +	unsigned int immediate_l : 16;
> +	unsigned int opcode : 6;
> +};
> +
> +struct reg2i12_format {
> +	unsigned int rd : 5;
> +	unsigned int rj : 5;
> +	unsigned int immediate : 12;
> +	unsigned int opcode : 10;
> +};
> +
> +struct reg2i16_format {
> +	unsigned int rd : 5;
> +	unsigned int rj : 5;
> +	unsigned int immediate : 16;
> +	unsigned int opcode : 6;
> +};
> +
> +union loongarch_instruction {
> +	unsigned int word;
> +	struct reg0i26_format reg0i26_format;
> +	struct reg1i20_format reg1i20_format;
> +	struct reg1i21_format reg1i21_format;
> +	struct reg2i12_format reg2i12_format;
> +	struct reg2i16_format reg2i16_format;
> +};
> +
> +#define LOONGARCH_INSN_SIZE	sizeof(union loongarch_instruction)
> +
> +enum loongarch_gpr {
> +	LOONGARCH_GPR_ZERO =3D 0,
> +	LOONGARCH_GPR_RA =3D 1,
> +	LOONGARCH_GPR_TP =3D 2,
> +	LOONGARCH_GPR_SP =3D 3,
> +	LOONGARCH_GPR_A0 =3D 4,	/* Reused as V0 for return value */
> +	LOONGARCH_GPR_A1,	/* Reused as V1 for return value */
> +	LOONGARCH_GPR_A2,
> +	LOONGARCH_GPR_A3,
> +	LOONGARCH_GPR_A4,
> +	LOONGARCH_GPR_A5,
> +	LOONGARCH_GPR_A6,
> +	LOONGARCH_GPR_A7,
> +	LOONGARCH_GPR_T0 =3D 12,
> +	LOONGARCH_GPR_T1,
> +	LOONGARCH_GPR_T2,
> +	LOONGARCH_GPR_T3,
> +	LOONGARCH_GPR_T4,
> +	LOONGARCH_GPR_T5,
> +	LOONGARCH_GPR_T6,
> +	LOONGARCH_GPR_T7,
> +	LOONGARCH_GPR_T8,
> +	LOONGARCH_GPR_FP =3D 22,
> +	LOONGARCH_GPR_S0 =3D 23,
> +	LOONGARCH_GPR_S1,
> +	LOONGARCH_GPR_S2,
> +	LOONGARCH_GPR_S3,
> +	LOONGARCH_GPR_S4,
> +	LOONGARCH_GPR_S5,
> +	LOONGARCH_GPR_S6,
> +	LOONGARCH_GPR_S7,
> +	LOONGARCH_GPR_S8,
> +	LOONGARCH_GPR_MAX
> +};
> +
> +u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm);
> +u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr=20
> rj, int imm);
> +u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj,=20
> unsigned long pc, unsigned long dest);
> +
> +#endif /* _ASM_INST_H */
> diff --git a/arch/loongarch/include/asm/linkage.h=20
> b/arch/loongarch/include/asm/linkage.h
> new file mode 100644
> index 000000000000..81b0c4cfbf4f
> --- /dev/null
> +++ b/arch/loongarch/include/asm/linkage.h
> @@ -0,0 +1,36 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_LINKAGE_H
> +#define __ASM_LINKAGE_H
> +
> +#define __ALIGN		.align 2
> +#define __ALIGN_STR	__stringify(__ALIGN)
> +
> +#define SYM_FUNC_START(name)				\
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_START_NOALIGN(name)			\
> +	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_START_LOCAL(name)			\
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
> +	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_START_WEAK(name)			\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
> +	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
> +	.cfi_startproc;
> +
> +#define SYM_FUNC_END(name)				\
> +	.cfi_endproc;					\
> +	SYM_END(name, SYM_T_FUNC)
> +
> +#endif
> diff --git a/arch/loongarch/include/asm/perf_event.h=20
> b/arch/loongarch/include/asm/perf_event.h
> new file mode 100644
> index 000000000000..dcb3b17053a8
> --- /dev/null
> +++ b/arch/loongarch/include/asm/perf_event.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __LOONGARCH_PERF_EVENT_H__
> +#define __LOONGARCH_PERF_EVENT_H__
> +/* Nothing to show here; the file is required by linux/perf_event.h. =
*/
> +#endif /* __LOONGARCH_PERF_EVENT_H__ */
> diff --git a/arch/loongarch/include/asm/prefetch.h=20
> b/arch/loongarch/include/asm/prefetch.h
> new file mode 100644
> index 000000000000..1672262a5e2e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/prefetch.h
> @@ -0,0 +1,29 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_PREFETCH_H
> +#define __ASM_PREFETCH_H
> +
> +#define Pref_Load	0
> +#define Pref_Store	8
> +
> +#ifdef __ASSEMBLY__
> +
> +	.macro	__pref hint addr
> +#ifdef CONFIG_CPU_HAS_PREFETCH
> +	preld	\hint, \addr, 0
> +#endif
> +	.endm
> +
> +	.macro	pref_load addr
> +	__pref	Pref_Load, \addr
> +	.endm
> +
> +	.macro	pref_store addr
> +	__pref	Pref_Store, \addr
> +	.endm
> +
> +#endif
> +
> +#endif /* __ASM_PREFETCH_H */
> diff --git a/arch/loongarch/include/asm/serial.h=20
> b/arch/loongarch/include/asm/serial.h
> new file mode 100644
> index 000000000000..3fb550eb9115
> --- /dev/null
> +++ b/arch/loongarch/include/asm/serial.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM__SERIAL_H
> +#define __ASM__SERIAL_H
> +
> +#define BASE_BAUD 0
> +#define STD_COM_FLAGS (ASYNC_BOOT_AUTOCONF | ASYNC_SKIP_TEST)
> +
> +#endif /* __ASM__SERIAL_H */
> diff --git a/arch/loongarch/include/asm/time.h=20
> b/arch/loongarch/include/asm/time.h
> new file mode 100644
> index 000000000000..2eae219301d0
> --- /dev/null
> +++ b/arch/loongarch/include/asm/time.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_TIME_H
> +#define _ASM_TIME_H
> +
> +#include <linux/clockchips.h>
> +#include <linux/clocksource.h>
> +#include <asm/loongarch.h>
> +
> +extern u64 cpu_clock_freq;
> +extern u64 const_clock_freq;
> +
> +extern void sync_counter(void);
> +
> +static inline unsigned int calc_const_freq(void)
> +{
> +	unsigned int res;
> +	unsigned int base_freq;
> +	unsigned int cfm, cfd;
> +
> +	res =3D read_cpucfg(LOONGARCH_CPUCFG2);
> +	if (!(res & CPUCFG2_LLFTP))
> +		return 0;
> +
> +	base_freq =3D read_cpucfg(LOONGARCH_CPUCFG4);
> +	res =3D read_cpucfg(LOONGARCH_CPUCFG5);
> +	cfm =3D res & 0xffff;
> +	cfd =3D (res >> 16) & 0xffff;
> +
> +	if (!base_freq || !cfm || !cfd)
> +		return 0;
> +
> +	return (base_freq * cfm / cfd);
> +}
> +
> +/*
> + * Initialize the calling CPU's timer interrupt as clockevent device
> + */
> +extern int constant_clockevent_init(void);
> +extern int constant_clocksource_init(void);
> +
> +static inline void clockevent_set_clock(struct clock_event_device *cd,
> +					unsigned int clock)
> +{
> +	clockevents_calc_mult_shift(cd, clock, 4);
> +}
> +
> +#endif /* _ASM_TIME_H */
> diff --git a/arch/loongarch/include/asm/timex.h=20
> b/arch/loongarch/include/asm/timex.h
> new file mode 100644
> index 000000000000..d3ed99a4fdbd
> --- /dev/null
> +++ b/arch/loongarch/include/asm/timex.h
> @@ -0,0 +1,33 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_TIMEX_H
> +#define _ASM_TIMEX_H
> +
> +#ifdef __KERNEL__
> +
> +#include <linux/compiler.h>
> +
> +#include <asm/cpu.h>
> +#include <asm/cpu-features.h>
> +
> +/*
> + * Standard way to access the cycle counter.
> + * Currently only used on SMP for scheduling.
> + *
> + * We know that all SMP capable CPUs have cycle counters.
> + */
> +
> +typedef unsigned long cycles_t;
> +
> +#define get_cycles get_cycles
> +
> +static inline cycles_t get_cycles(void)
> +{
> +	return drdtime();
> +}
> +
> +#endif /* __KERNEL__ */
> +
> +#endif /*  _ASM_TIMEX_H */
> diff --git a/arch/loongarch/include/asm/topology.h=20
> b/arch/loongarch/include/asm/topology.h
> new file mode 100644
> index 000000000000..9ac71a25207a
> --- /dev/null
> +++ b/arch/loongarch/include/asm/topology.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef __ASM_TOPOLOGY_H
> +#define __ASM_TOPOLOGY_H
> +
> +#include <linux/smp.h>
> +
> +#define cpu_logical_map(cpu)  0
> +
> +#include <asm-generic/topology.h>
> +
> +static inline void arch_fix_phys_package_id(int num, u32 slot) { }
> +#endif /* __ASM_TOPOLOGY_H */
> diff --git a/arch/loongarch/include/asm/types.h=20
> b/arch/loongarch/include/asm/types.h
> new file mode 100644
> index 000000000000..baf15a0dcf8b
> --- /dev/null
> +++ b/arch/loongarch/include/asm/types.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_TYPES_H
> +#define _ASM_TYPES_H
> +
> +#include <asm-generic/int-ll64.h>
> +#include <uapi/asm/types.h>
> +
> +#ifdef __ASSEMBLY__
> +#define _ULCAST_
> +#define _U64CAST_
> +#else
> +#define _ULCAST_ (unsigned long)
> +#define _U64CAST_ (u64)
> +#endif
> +
> +#endif /* _ASM_TYPES_H */
> diff --git a/arch/loongarch/include/uapi/asm/bitsperlong.h=20
> b/arch/loongarch/include/uapi/asm/bitsperlong.h
> new file mode 100644
> index 000000000000..00b4ba1e5cdf
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/bitsperlong.h
> @@ -0,0 +1,9 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef __ASM_LOONGARCH_BITSPERLONG_H
> +#define __ASM_LOONGARCH_BITSPERLONG_H
> +
> +#define __BITS_PER_LONG (__SIZEOF_LONG__ * 8)
> +
> +#include <asm-generic/bitsperlong.h>
> +
> +#endif /* __ASM_LOONGARCH_BITSPERLONG_H */
> diff --git a/arch/loongarch/include/uapi/asm/byteorder.h=20
> b/arch/loongarch/include/uapi/asm/byteorder.h
> new file mode 100644
> index 000000000000..b1722d890deb
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/byteorder.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_BYTEORDER_H
> +#define _ASM_BYTEORDER_H
> +
> +#include <linux/byteorder/little_endian.h>
> +
> +#endif /* _ASM_BYTEORDER_H */
> diff --git a/arch/loongarch/include/uapi/asm/reg.h=20
> b/arch/loongarch/include/uapi/asm/reg.h
> new file mode 100644
> index 000000000000..90ad910c60eb
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/reg.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * Various register offset definitions for debuggers, core file
> + * examiners and whatnot.
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __UAPI_ASM_LOONGARCH_REG_H
> +#define __UAPI_ASM_LOONGARCH_REG_H
> +
> +#define LOONGARCH_EF_R0		0
> +#define LOONGARCH_EF_R1		1
> +#define LOONGARCH_EF_R2		2
> +#define LOONGARCH_EF_R3		3
> +#define LOONGARCH_EF_R4		4
> +#define LOONGARCH_EF_R5		5
> +#define LOONGARCH_EF_R6		6
> +#define LOONGARCH_EF_R7		7
> +#define LOONGARCH_EF_R8		8
> +#define LOONGARCH_EF_R9		9
> +#define LOONGARCH_EF_R10	10
> +#define LOONGARCH_EF_R11	11
> +#define LOONGARCH_EF_R12	12
> +#define LOONGARCH_EF_R13	13
> +#define LOONGARCH_EF_R14	14
> +#define LOONGARCH_EF_R15	15
> +#define LOONGARCH_EF_R16	16
> +#define LOONGARCH_EF_R17	17
> +#define LOONGARCH_EF_R18	18
> +#define LOONGARCH_EF_R19	19
> +#define LOONGARCH_EF_R20	20
> +#define LOONGARCH_EF_R21	21
> +#define LOONGARCH_EF_R22	22
> +#define LOONGARCH_EF_R23	23
> +#define LOONGARCH_EF_R24	24
> +#define LOONGARCH_EF_R25	25
> +#define LOONGARCH_EF_R26	26
> +#define LOONGARCH_EF_R27	27
> +#define LOONGARCH_EF_R28	28
> +#define LOONGARCH_EF_R29	29
> +#define LOONGARCH_EF_R30	30
> +#define LOONGARCH_EF_R31	31
> +
> +/*
> + * Saved special registers
> + */
> +#define LOONGARCH_EF_ORIG_A0	32
> +#define LOONGARCH_EF_CSR_ERA	33
> +#define LOONGARCH_EF_CSR_BADV	34
> +#define LOONGARCH_EF_CSR_CRMD	35
> +#define LOONGARCH_EF_CSR_PRMD	36
> +#define LOONGARCH_EF_CSR_EUEN	37
> +#define LOONGARCH_EF_CSR_ECFG	38
> +#define LOONGARCH_EF_CSR_ESTAT	39
> +
> +#define LOONGARCH_EF_SIZE	320	/* size in bytes */
> +
> +#endif /* __UAPI_ASM_LOONGARCH_REG_H */
> diff --git a/tools/include/uapi/asm/bitsperlong.h=20
> b/tools/include/uapi/asm/bitsperlong.h
> index edba4d93e9e6..da5206517158 100644
> --- a/tools/include/uapi/asm/bitsperlong.h
> +++ b/tools/include/uapi/asm/bitsperlong.h
> @@ -17,6 +17,8 @@
>  #include "../../../arch/riscv/include/uapi/asm/bitsperlong.h"
>  #elif defined(__alpha__)
>  #include "../../../arch/alpha/include/uapi/asm/bitsperlong.h"
> +#elif defined(__loongarch__)
> +#include "../../../arch/loongarch/include/uapi/asm/bitsperlong.h"
>  #else
>  #include <asm-generic/bitsperlong.h>
>  #endif
> --=20
> 2.27.0

--=20
- Jiaxun
