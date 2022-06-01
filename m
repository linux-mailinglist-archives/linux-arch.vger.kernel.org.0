Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4926553A509
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352873AbiFAMba (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352876AbiFAMbV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:31:21 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F368A334;
        Wed,  1 Jun 2022 05:31:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailnew.nyi.internal (Postfix) with ESMTP id 82C1258056A;
        Wed,  1 Jun 2022 08:31:15 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:31:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086675; x=
        1654093875; bh=IkdDnjZhsTVKN1U9NON2sW0ylT+CKD8iY36dbYxpd1U=; b=W
        AWZiSQwHoosbcSwmAtIon0o0t3FqJCJFPj8QXIztCD54dsXfSxGwrkQIfLsSVmZJ
        ICHQIgt49gcshOWm7SChEpW+KvH9f83uhVBT1792bRAi42yzXQ4lYVL1KNwhSH9I
        G6Tb4xf+ephtnnusyS7YsuqPfvQ5d7xv3NpZWJYokAmjXiBo/O3MtXwn8VIzprD8
        YysHugiuqpRe1N1+OlKX9INGw0If5zglPAu5HqWobSaJGlcjTJyVNRBxEpLvUExe
        z3WcYoAqXj4n+LK0muhIZdlC7wEmm2OrXkszWKgZw177bYJjM6AubtX7J7qlJnTs
        GbQK//cgTHa41KIsPbisw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086675; x=
        1654093875; bh=IkdDnjZhsTVKN1U9NON2sW0ylT+CKD8iY36dbYxpd1U=; b=m
        T66utg0cmfdyUkwlXmW/82Vhqe7eQHS12bdNJ8jf9zqJJ3lr6LPKrY9hp/4ynWVx
        4dOpf/ggNVv3w0rbo8WcJyBl70RAy0uuX1JB7tSDwMTQwwPC+iDc835Sm01GWkZH
        O6LC9xVbZvvShvVnHMgYnSic143UFnVxAGHOvin5V+KeoUFpyxfsorB1DU020DNj
        Q7TCpMpOV0vN+KCuLvAq5z+6eJ+tGx8izorzBKtxGzEoScEqAasqIBPeE0fLuSyM
        E0aqiHyXY++rJWyJ71DqvfU3Nm5BWNUMnhTt+04QcVJbJOxXMo7aiNygLbKOiw/X
        zF+YHzsR1/BORyInQ+C8Q==
X-ME-Sender: <xms:ElyXYgeGak4Q_pL3eWtMOgT7VD_53LPmIl3XQQZTO9GjQ3ACLjHO_Q>
    <xme:ElyXYiN3LwD-oK5KGQ1V85myPwZz4zV9f5AXBujloKwRVqUSFjvo2qth_fJaZaZNa
    g1uEYiBg4PrL54J0gE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepudefgeeftedugeehffdtheefgfevffelfefghefhjeeu
    geevtefhudduvdeihefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:ElyXYhiE4970TCzFh_YreNAOeJAaUXv6asOJ_heK72_luLqgIPX2Ag>
    <xmx:ElyXYl86kCqKHRHXXwlRODWfDYAKAO8CYrCMCI-sPJAG9xvRMYOtGw>
    <xmx:ElyXYsv4sSGmRK4KjP1S4PgTejyrFcY0MqeMFxaqqWUs-VMEKe_kvg>
    <xmx:E1yXYnmHRKVYZAmVEbo1fZ8fJtDp6E-PajxvJvW4F2irGMeCAB95fw>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9C13936A006D; Wed,  1 Jun 2022 08:31:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <e1bf7cb8-6f4e-4d5f-b6ad-88835fccf1b5@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-18-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-18-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:30:53 +0100
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
        "Jessica Yu" <jeyu@kernel.org>, "WANG Xuerui" <git@xen0n.name>,
        "Luis Chamberlain" <mcgrof@kernel.org>
Subject: Re: [PATCH V12 17/24] LoongArch: Add ELF and module support
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
> Add ELF-related definition and module relocation code for basic
> LoongArch support.
>
> Cc: Jessica Yu <jeyu@kernel.org>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

> ---
>  arch/loongarch/include/asm/cpufeature.h  |  24 ++
>  arch/loongarch/include/asm/elf.h         | 301 ++++++++++++++++++
>  arch/loongarch/include/asm/exec.h        |  10 +
>  arch/loongarch/include/asm/module.h      |  80 +++++
>  arch/loongarch/include/asm/module.lds.h  |   7 +
>  arch/loongarch/include/asm/vermagic.h    |  19 ++
>  arch/loongarch/include/uapi/asm/auxvec.h |  17 ++
>  arch/loongarch/include/uapi/asm/hwcap.h  |  20 ++
>  arch/loongarch/kernel/elf.c              |  30 ++
>  arch/loongarch/kernel/inst.c             |  40 +++
>  arch/loongarch/kernel/module-sections.c  | 121 ++++++++
>  arch/loongarch/kernel/module.c           | 374 +++++++++++++++++++++++
>  12 files changed, 1043 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/cpufeature.h
>  create mode 100644 arch/loongarch/include/asm/elf.h
>  create mode 100644 arch/loongarch/include/asm/exec.h
>  create mode 100644 arch/loongarch/include/asm/module.h
>  create mode 100644 arch/loongarch/include/asm/module.lds.h
>  create mode 100644 arch/loongarch/include/asm/vermagic.h
>  create mode 100644 arch/loongarch/include/uapi/asm/auxvec.h
>  create mode 100644 arch/loongarch/include/uapi/asm/hwcap.h
>  create mode 100644 arch/loongarch/kernel/elf.c
>  create mode 100644 arch/loongarch/kernel/inst.c
>  create mode 100644 arch/loongarch/kernel/module-sections.c
>  create mode 100644 arch/loongarch/kernel/module.c
>
> diff --git a/arch/loongarch/include/asm/cpufeature.h=20
> b/arch/loongarch/include/asm/cpufeature.h
> new file mode 100644
> index 000000000000..4da22a8e63de
> --- /dev/null
> +++ b/arch/loongarch/include/asm/cpufeature.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * CPU feature definitions for module loading, used by
> + * module_cpu_feature_match(), see uapi/asm/hwcap.h for LoongArch CPU=20
> features.
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_CPUFEATURE_H
> +#define __ASM_CPUFEATURE_H
> +
> +#include <uapi/asm/hwcap.h>
> +#include <asm/elf.h>
> +
> +#define MAX_CPU_FEATURES (8 * sizeof(elf_hwcap))
> +
> +#define cpu_feature(x)		ilog2(HWCAP_ ## x)
> +
> +static inline bool cpu_have_feature(unsigned int num)
> +{
> +	return elf_hwcap & (1UL << num);
> +}
> +
> +#endif /* __ASM_CPUFEATURE_H */
> diff --git a/arch/loongarch/include/asm/elf.h=20
> b/arch/loongarch/include/asm/elf.h
> new file mode 100644
> index 000000000000..f3960b18a90e
> --- /dev/null
> +++ b/arch/loongarch/include/asm/elf.h
> @@ -0,0 +1,301 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_ELF_H
> +#define _ASM_ELF_H
> +
> +#include <linux/auxvec.h>
> +#include <linux/fs.h>
> +#include <uapi/linux/elf.h>
> +
> +#include <asm/current.h>
> +#include <asm/vdso.h>
> +
> +/* The ABI of a file. */
> +#define EF_LOONGARCH_ABI_LP64_SOFT_FLOAT	0x1
> +#define EF_LOONGARCH_ABI_LP64_SINGLE_FLOAT	0x2
> +#define EF_LOONGARCH_ABI_LP64_DOUBLE_FLOAT	0x3
> +
> +#define EF_LOONGARCH_ABI_ILP32_SOFT_FLOAT	0x5
> +#define EF_LOONGARCH_ABI_ILP32_SINGLE_FLOAT	0x6
> +#define EF_LOONGARCH_ABI_ILP32_DOUBLE_FLOAT	0x7
> +
> +/* LoongArch relocation types used by the dynamic linker */
> +#define R_LARCH_NONE				0
> +#define R_LARCH_32				1
> +#define R_LARCH_64				2
> +#define R_LARCH_RELATIVE			3
> +#define R_LARCH_COPY				4
> +#define R_LARCH_JUMP_SLOT			5
> +#define R_LARCH_TLS_DTPMOD32			6
> +#define R_LARCH_TLS_DTPMOD64			7
> +#define R_LARCH_TLS_DTPREL32			8
> +#define R_LARCH_TLS_DTPREL64			9
> +#define R_LARCH_TLS_TPREL32			10
> +#define R_LARCH_TLS_TPREL64			11
> +#define R_LARCH_IRELATIVE			12
> +#define R_LARCH_MARK_LA				20
> +#define R_LARCH_MARK_PCREL			21
> +#define R_LARCH_SOP_PUSH_PCREL			22
> +#define R_LARCH_SOP_PUSH_ABSOLUTE		23
> +#define R_LARCH_SOP_PUSH_DUP			24
> +#define R_LARCH_SOP_PUSH_GPREL			25
> +#define R_LARCH_SOP_PUSH_TLS_TPREL		26
> +#define R_LARCH_SOP_PUSH_TLS_GOT		27
> +#define R_LARCH_SOP_PUSH_TLS_GD			28
> +#define R_LARCH_SOP_PUSH_PLT_PCREL		29
> +#define R_LARCH_SOP_ASSERT			30
> +#define R_LARCH_SOP_NOT				31
> +#define R_LARCH_SOP_SUB				32
> +#define R_LARCH_SOP_SL				33
> +#define R_LARCH_SOP_SR				34
> +#define R_LARCH_SOP_ADD				35
> +#define R_LARCH_SOP_AND				36
> +#define R_LARCH_SOP_IF_ELSE			37
> +#define R_LARCH_SOP_POP_32_S_10_5		38
> +#define R_LARCH_SOP_POP_32_U_10_12		39
> +#define R_LARCH_SOP_POP_32_S_10_12		40
> +#define R_LARCH_SOP_POP_32_S_10_16		41
> +#define R_LARCH_SOP_POP_32_S_10_16_S2		42
> +#define R_LARCH_SOP_POP_32_S_5_20		43
> +#define R_LARCH_SOP_POP_32_S_0_5_10_16_S2	44
> +#define R_LARCH_SOP_POP_32_S_0_10_10_16_S2	45
> +#define R_LARCH_SOP_POP_32_U			46
> +#define R_LARCH_ADD8				47
> +#define R_LARCH_ADD16				48
> +#define R_LARCH_ADD24				49
> +#define R_LARCH_ADD32				50
> +#define R_LARCH_ADD64				51
> +#define R_LARCH_SUB8				52
> +#define R_LARCH_SUB16				53
> +#define R_LARCH_SUB24				54
> +#define R_LARCH_SUB32				55
> +#define R_LARCH_SUB64				56
> +#define R_LARCH_GNU_VTINHERIT			57
> +#define R_LARCH_GNU_VTENTRY			58
> +
> +#ifndef ELF_ARCH
> +
> +/* ELF register definitions */
> +
> +/*
> + * General purpose have the following registers:
> + *	Register	Number
> + *	GPRs		32
> + *	ORIG_A0		1
> + *	ERA		1
> + *	BADVADDR	1
> + *	CRMD		1
> + *	PRMD		1
> + *	EUEN		1
> + *	ECFG		1
> + *	ESTAT		1
> + *	Reserved	5
> + */
> +#define ELF_NGREG	45
> +
> +/*
> + * Floating point have the following registers:
> + *	Register	Number
> + *	FPR		32
> + *	FCC		1
> + *	FCSR		1
> + */
> +#define ELF_NFPREG	34
> +
> +typedef unsigned long elf_greg_t;
> +typedef elf_greg_t elf_gregset_t[ELF_NGREG];
> +
> +typedef double elf_fpreg_t;
> +typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
> +
> +void loongarch_dump_regs64(u64 *uregs, const struct pt_regs *regs);
> +
> +#ifdef CONFIG_32BIT
> +/*
> + * This is used to ensure we don't load something for the wrong=20
> architecture.
> + */
> +#define elf_check_arch elf32_check_arch
> +
> +/*
> + * These are used to set parameters in the core dumps.
> + */
> +#define ELF_CLASS	ELFCLASS32
> +
> +#define ELF_CORE_COPY_REGS(dest, regs) \
> +	loongarch_dump_regs32((u32 *)&(dest), (regs));
> +
> +#endif /* CONFIG_32BIT */
> +
> +#ifdef CONFIG_64BIT
> +/*
> + * This is used to ensure we don't load something for the wrong=20
> architecture.
> + */
> +#define elf_check_arch elf64_check_arch
> +
> +/*
> + * These are used to set parameters in the core dumps.
> + */
> +#define ELF_CLASS	ELFCLASS64
> +
> +#define ELF_CORE_COPY_REGS(dest, regs) \
> +	loongarch_dump_regs64((u64 *)&(dest), (regs));
> +
> +#endif /* CONFIG_64BIT */
> +
> +/*
> + * These are used to set parameters in the core dumps.
> + */
> +#define ELF_DATA	ELFDATA2LSB
> +#define ELF_ARCH	EM_LOONGARCH
> +
> +#endif /* !defined(ELF_ARCH) */
> +
> +#define loongarch_elf_check_machine(x) ((x)->e_machine =3D=3D EM_LOON=
GARCH)
> +
> +#define vmcore_elf32_check_arch loongarch_elf_check_machine
> +#define vmcore_elf64_check_arch loongarch_elf_check_machine
> +
> +/*
> + * Return non-zero if HDR identifies an 32bit ELF binary.
> + */
> +#define elf32_check_arch(hdr)						\
> +({									\
> +	int __res =3D 1;							\
> +	struct elfhdr *__h =3D (hdr);					\
> +									\
> +	if (!loongarch_elf_check_machine(__h))				\
> +		__res =3D 0;						\
> +	if (__h->e_ident[EI_CLASS] !=3D ELFCLASS32)			\
> +		__res =3D 0;						\
> +									\
> +	__res;								\
> +})
> +
> +/*
> + * Return non-zero if HDR identifies an 64bit ELF binary.
> + */
> +#define elf64_check_arch(hdr)						\
> +({									\
> +	int __res =3D 1;							\
> +	struct elfhdr *__h =3D (hdr);					\
> +									\
> +	if (!loongarch_elf_check_machine(__h))				\
> +		__res =3D 0;						\
> +	if (__h->e_ident[EI_CLASS] !=3D ELFCLASS64)			\
> +		__res =3D 0;						\
> +									\
> +	__res;								\
> +})
> +
> +#ifdef CONFIG_32BIT
> +
> +#define SET_PERSONALITY2(ex, state)					\
> +do {									\
> +	current->thread.vdso =3D &vdso_info;				\
> +									\
> +	loongarch_set_personality_fcsr(state);				\
> +									\
> +	if (personality(current->personality) !=3D PER_LINUX)		\
> +		set_personality(PER_LINUX);				\
> +} while (0)
> +
> +#endif /* CONFIG_32BIT */
> +
> +#ifdef CONFIG_64BIT
> +
> +#define SET_PERSONALITY2(ex, state)					\
> +do {									\
> +	unsigned int p;							\
> +									\
> +	clear_thread_flag(TIF_32BIT_REGS);				\
> +	clear_thread_flag(TIF_32BIT_ADDR);				\
> +									\
> +	current->thread.vdso =3D &vdso_info;				\
> +	loongarch_set_personality_fcsr(state);				\
> +									\
> +	p =3D personality(current->personality);				\
> +	if (p !=3D PER_LINUX32 && p !=3D PER_LINUX)				\
> +		set_personality(PER_LINUX);				\
> +} while (0)
> +
> +#endif /* CONFIG_64BIT */
> +
> +#define CORE_DUMP_USE_REGSET
> +#define ELF_EXEC_PAGESIZE	PAGE_SIZE
> +
> +/*
> + * This yields a mask that user programs can use to figure out what
> + * instruction set this cpu supports. This could be done in userspace,
> + * but it's not easy, and we've already done it here.
> + */
> +
> +#define ELF_HWCAP	(elf_hwcap)
> +extern unsigned int elf_hwcap;
> +#include <asm/hwcap.h>
> +
> +/*
> + * This yields a string that ld.so will use to load implementation
> + * specific libraries for optimization.	 This is more specific in
> + * intent than poking at uname or /proc/cpuinfo.
> + */
> +
> +#define ELF_PLATFORM  __elf_platform
> +extern const char *__elf_platform;
> +
> +#define ELF_PLAT_INIT(_r, load_addr)	do { \
> +	_r->regs[1] =3D _r->regs[2] =3D _r->regs[3] =3D _r->regs[4] =3D 0;	\
> +	_r->regs[5] =3D _r->regs[6] =3D _r->regs[7] =3D _r->regs[8] =3D 0;	\
> +	_r->regs[9] =3D _r->regs[10] =3D _r->regs[11] =3D _r->regs[12] =3D 0=
;	\
> +	_r->regs[13] =3D _r->regs[14] =3D _r->regs[15] =3D _r->regs[16] =3D =
0;	\
> +	_r->regs[17] =3D _r->regs[18] =3D _r->regs[19] =3D _r->regs[20] =3D =
0;	\
> +	_r->regs[21] =3D _r->regs[22] =3D _r->regs[23] =3D _r->regs[24] =3D =
0;	\
> +	_r->regs[25] =3D _r->regs[26] =3D _r->regs[27] =3D _r->regs[28] =3D =
0;	\
> +	_r->regs[29] =3D _r->regs[30] =3D _r->regs[31] =3D 0;			\
> +} while (0)
> +
> +/*
> + * This is the location that an ET_DYN program is loaded if exec'ed.=20
> Typical
> + * use of this is to invoke "./ld.so someprog" to test out a new=20
> version of
> + * the loader. We need to make sure that it is out of the way of the=20
> program
> + * that it will "exec", and that there is sufficient room for the brk.
> + */
> +
> +#define ELF_ET_DYN_BASE		(TASK_SIZE / 3 * 2)
> +
> +/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries=20
> changes */
> +#define ARCH_DLINFO							\
> +do {									\
> +	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
> +		    (unsigned long)current->mm->context.vdso);		\
> +} while (0)
> +
> +#define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
> +struct linux_binprm;
> +extern int arch_setup_additional_pages(struct linux_binprm *bprm,
> +				       int uses_interp);
> +
> +struct arch_elf_state {
> +	int fp_abi;
> +	int interp_fp_abi;
> +};
> +
> +#define LOONGARCH_ABI_FP_ANY	(0)
> +
> +#define INIT_ARCH_ELF_STATE {			\
> +	.fp_abi =3D LOONGARCH_ABI_FP_ANY,		\
> +	.interp_fp_abi =3D LOONGARCH_ABI_FP_ANY,	\
> +}
> +
> +#define elf_read_implies_exec(ex, exec_stk) (exec_stk =3D=3D=20
> EXSTACK_DEFAULT)
> +
> +extern int arch_elf_pt_proc(void *ehdr, void *phdr, struct file *elf,
> +			    bool is_interp, struct arch_elf_state *state);
> +
> +extern int arch_check_elf(void *ehdr, bool has_interpreter, void=20
> *interp_ehdr,
> +			  struct arch_elf_state *state);
> +
> +extern void loongarch_set_personality_fcsr(struct arch_elf_state=20
> *state);
> +
> +#endif /* _ASM_ELF_H */
> diff --git a/arch/loongarch/include/asm/exec.h=20
> b/arch/loongarch/include/asm/exec.h
> new file mode 100644
> index 000000000000..ba0220812ebb
> --- /dev/null
> +++ b/arch/loongarch/include/asm/exec.h
> @@ -0,0 +1,10 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_EXEC_H
> +#define _ASM_EXEC_H
> +
> +extern unsigned long arch_align_stack(unsigned long sp);
> +
> +#endif /* _ASM_EXEC_H */
> diff --git a/arch/loongarch/include/asm/module.h=20
> b/arch/loongarch/include/asm/module.h
> new file mode 100644
> index 000000000000..9f6718df1854
> --- /dev/null
> +++ b/arch/loongarch/include/asm/module.h
> @@ -0,0 +1,80 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_MODULE_H
> +#define _ASM_MODULE_H
> +
> +#include <asm/inst.h>
> +#include <asm-generic/module.h>
> +
> +#define RELA_STACK_DEPTH 16
> +
> +struct mod_section {
> +	Elf_Shdr *shdr;
> +	int num_entries;
> +	int max_entries;
> +};
> +
> +struct mod_arch_specific {
> +	struct mod_section plt;
> +	struct mod_section plt_idx;
> +};
> +
> +struct plt_entry {
> +	u32 inst_lu12iw;
> +	u32 inst_lu32id;
> +	u32 inst_lu52id;
> +	u32 inst_jirl;
> +};
> +
> +struct plt_idx_entry {
> +	unsigned long symbol_addr;
> +};
> +
> +Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val);
> +
> +static inline struct plt_entry emit_plt_entry(unsigned long val)
> +{
> +	u32 lu12iw, lu32id, lu52id, jirl;
> +
> +	lu12iw =3D (lu12iw_op << 25 | (((val >> 12) & 0xfffff) << 5) |=20
> LOONGARCH_GPR_T1);
> +	lu32id =3D larch_insn_gen_lu32id(LOONGARCH_GPR_T1, ADDR_IMM(val,=20
> LU32ID));
> +	lu52id =3D larch_insn_gen_lu52id(LOONGARCH_GPR_T1, LOONGARCH_GPR_T1,=20
> ADDR_IMM(val, LU52ID));
> +	jirl =3D larch_insn_gen_jirl(0, LOONGARCH_GPR_T1, 0, (val & 0xfff));
> +
> +	return (struct plt_entry) { lu12iw, lu32id, lu52id, jirl };
> +}
> +
> +static inline struct plt_idx_entry emit_plt_idx_entry(unsigned long=20
> val)
> +{
> +	return (struct plt_idx_entry) { val };
> +}
> +
> +static inline int get_plt_idx(unsigned long val, const struct=20
> mod_section *sec)
> +{
> +	int i;
> +	struct plt_idx_entry *plt_idx =3D (struct plt_idx_entry=20
> *)sec->shdr->sh_addr;
> +
> +	for (i =3D 0; i < sec->num_entries; i++) {
> +		if (plt_idx[i].symbol_addr =3D=3D val)
> +			return i;
> +	}
> +
> +	return -1;
> +}
> +
> +static inline struct plt_entry *get_plt_entry(unsigned long val,
> +				      const struct mod_section *sec_plt,
> +				      const struct mod_section *sec_plt_idx)
> +{
> +	int plt_idx =3D get_plt_idx(val, sec_plt_idx);
> +	struct plt_entry *plt =3D (struct plt_entry *)sec_plt->shdr->sh_addr;
> +
> +	if (plt_idx < 0)
> +		return NULL;
> +
> +	return plt + plt_idx;
> +}
> +
> +#endif /* _ASM_MODULE_H */
> diff --git a/arch/loongarch/include/asm/module.lds.h=20
> b/arch/loongarch/include/asm/module.lds.h
> new file mode 100644
> index 000000000000..31c1c0db11a3
> --- /dev/null
> +++ b/arch/loongarch/include/asm/module.lds.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (C) 2020-2022 Loongson Technology Corporation Limited */
> +SECTIONS {
> +	. =3D ALIGN(4);
> +	.plt : { BYTE(0) }
> +	.plt.idx : { BYTE(0) }
> +}
> diff --git a/arch/loongarch/include/asm/vermagic.h=20
> b/arch/loongarch/include/asm/vermagic.h
> new file mode 100644
> index 000000000000..8b47ccfe3aad
> --- /dev/null
> +++ b/arch/loongarch/include/asm/vermagic.h
> @@ -0,0 +1,19 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_VERMAGIC_H
> +#define _ASM_VERMAGIC_H
> +
> +#define MODULE_PROC_FAMILY "LOONGARCH "
> +
> +#ifdef CONFIG_32BIT
> +#define MODULE_KERNEL_TYPE "32BIT "
> +#elif defined CONFIG_64BIT
> +#define MODULE_KERNEL_TYPE "64BIT "
> +#endif
> +
> +#define MODULE_ARCH_VERMAGIC \
> +	MODULE_PROC_FAMILY MODULE_KERNEL_TYPE
> +
> +#endif /* _ASM_VERMAGIC_H */
> diff --git a/arch/loongarch/include/uapi/asm/auxvec.h=20
> b/arch/loongarch/include/uapi/asm/auxvec.h
> new file mode 100644
> index 000000000000..922d9e6b5058
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/auxvec.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0+ WITH Linux-syscall-note */
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#ifndef __ASM_AUXVEC_H
> +#define __ASM_AUXVEC_H
> +
> +/* Location of VDSO image. */
> +#define AT_SYSINFO_EHDR		33
> +
> +#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
> +
> +#endif /* __ASM_AUXVEC_H */
> diff --git a/arch/loongarch/include/uapi/asm/hwcap.h=20
> b/arch/loongarch/include/uapi/asm/hwcap.h
> new file mode 100644
> index 000000000000..8840b72fa8e8
> --- /dev/null
> +++ b/arch/loongarch/include/uapi/asm/hwcap.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +#ifndef _UAPI_ASM_HWCAP_H
> +#define _UAPI_ASM_HWCAP_H
> +
> +/* HWCAP flags */
> +#define HWCAP_LOONGARCH_CPUCFG		(1 << 0)
> +#define HWCAP_LOONGARCH_LAM		(1 << 1)
> +#define HWCAP_LOONGARCH_UAL		(1 << 2)
> +#define HWCAP_LOONGARCH_FPU		(1 << 3)
> +#define HWCAP_LOONGARCH_LSX		(1 << 4)
> +#define HWCAP_LOONGARCH_LASX		(1 << 5)
> +#define HWCAP_LOONGARCH_CRC32		(1 << 6)
> +#define HWCAP_LOONGARCH_COMPLEX		(1 << 7)
> +#define HWCAP_LOONGARCH_CRYPTO		(1 << 8)
> +#define HWCAP_LOONGARCH_LVZ		(1 << 9)
> +#define HWCAP_LOONGARCH_LBT_X86		(1 << 10)
> +#define HWCAP_LOONGARCH_LBT_ARM		(1 << 11)
> +#define HWCAP_LOONGARCH_LBT_MIPS	(1 << 12)
> +
> +#endif /* _UAPI_ASM_HWCAP_H */
> diff --git a/arch/loongarch/kernel/elf.c b/arch/loongarch/kernel/elf.c
> new file mode 100644
> index 000000000000..183e94fc9c69
> --- /dev/null
> +++ b/arch/loongarch/kernel/elf.c
> @@ -0,0 +1,30 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Author: Huacai Chen <chenhuacai@loongson.cn>
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/binfmts.h>
> +#include <linux/elf.h>
> +#include <linux/export.h>
> +#include <linux/sched.h>
> +
> +#include <asm/cpu-features.h>
> +#include <asm/cpu-info.h>
> +
> +int arch_elf_pt_proc(void *_ehdr, void *_phdr, struct file *elf,
> +		     bool is_interp, struct arch_elf_state *state)
> +{
> +	return 0;
> +}
> +
> +int arch_check_elf(void *_ehdr, bool has_interpreter, void=20
> *_interp_ehdr,
> +		   struct arch_elf_state *state)
> +{
> +	return 0;
> +}
> +
> +void loongarch_set_personality_fcsr(struct arch_elf_state *state)
> +{
> +	current->thread.fpu.fcsr =3D boot_cpu_data.fpu_csr0;
> +}
> diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst=
.c
> new file mode 100644
> index 000000000000..b1df0ec34bd1
> --- /dev/null
> +++ b/arch/loongarch/kernel/inst.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#include <asm/inst.h>
> +
> +u32 larch_insn_gen_lu32id(enum loongarch_gpr rd, int imm)
> +{
> +	union loongarch_instruction insn;
> +
> +	insn.reg1i20_format.opcode =3D lu32id_op;
> +	insn.reg1i20_format.rd =3D rd;
> +	insn.reg1i20_format.immediate =3D imm;
> +
> +	return insn.word;
> +}
> +
> +u32 larch_insn_gen_lu52id(enum loongarch_gpr rd, enum loongarch_gpr=20
> rj, int imm)
> +{
> +	union loongarch_instruction insn;
> +
> +	insn.reg2i12_format.opcode =3D lu52id_op;
> +	insn.reg2i12_format.rd =3D rd;
> +	insn.reg2i12_format.rj =3D rj;
> +	insn.reg2i12_format.immediate =3D imm;
> +
> +	return insn.word;
> +}
> +
> +u32 larch_insn_gen_jirl(enum loongarch_gpr rd, enum loongarch_gpr rj,=20
> unsigned long pc, unsigned long dest)
> +{
> +	union loongarch_instruction insn;
> +
> +	insn.reg2i16_format.opcode =3D jirl_op;
> +	insn.reg2i16_format.rd =3D rd;
> +	insn.reg2i16_format.rj =3D rj;
> +	insn.reg2i16_format.immediate =3D (dest - pc) >> 2;
> +
> +	return insn.word;
> +}
> diff --git a/arch/loongarch/kernel/module-sections.c=20
> b/arch/loongarch/kernel/module-sections.c
> new file mode 100644
> index 000000000000..6d498288977d
> --- /dev/null
> +++ b/arch/loongarch/kernel/module-sections.c
> @@ -0,0 +1,121 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <linux/elf.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +
> +Elf_Addr module_emit_plt_entry(struct module *mod, unsigned long val)
> +{
> +	int nr;
> +	struct mod_section *plt_sec =3D &mod->arch.plt;
> +	struct mod_section *plt_idx_sec =3D &mod->arch.plt_idx;
> +	struct plt_entry *plt =3D get_plt_entry(val, plt_sec, plt_idx_sec);
> +	struct plt_idx_entry *plt_idx;
> +
> +	if (plt)
> +		return (Elf_Addr)plt;
> +
> +	nr =3D plt_sec->num_entries;
> +
> +	/* There is no duplicate entry, create a new one */
> +	plt =3D (struct plt_entry *)plt_sec->shdr->sh_addr;
> +	plt[nr] =3D emit_plt_entry(val);
> +	plt_idx =3D (struct plt_idx_entry *)plt_idx_sec->shdr->sh_addr;
> +	plt_idx[nr] =3D emit_plt_idx_entry(val);
> +
> +	plt_sec->num_entries++;
> +	plt_idx_sec->num_entries++;
> +	BUG_ON(plt_sec->num_entries > plt_sec->max_entries);
> +
> +	return (Elf_Addr)&plt[nr];
> +}
> +
> +static int is_rela_equal(const Elf_Rela *x, const Elf_Rela *y)
> +{
> +	return x->r_info =3D=3D y->r_info && x->r_addend =3D=3D y->r_addend;
> +}
> +
> +static bool duplicate_rela(const Elf_Rela *rela, int idx)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < idx; i++) {
> +		if (is_rela_equal(&rela[i], &rela[idx]))
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static void count_max_entries(Elf_Rela *relas, int num, unsigned int=20
> *plts)
> +{
> +	unsigned int i, type;
> +
> +	for (i =3D 0; i < num; i++) {
> +		type =3D ELF_R_TYPE(relas[i].r_info);
> +		if (type =3D=3D R_LARCH_SOP_PUSH_PLT_PCREL) {
> +			if (!duplicate_rela(relas, i))
> +				(*plts)++;
> +		}
> +	}
> +}
> +
> +int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *sechdrs,
> +			      char *secstrings, struct module *mod)
> +{
> +	unsigned int i, num_plts =3D 0;
> +
> +	/*
> +	 * Find the empty .plt sections.
> +	 */
> +	for (i =3D 0; i < ehdr->e_shnum; i++) {
> +		if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
> +			mod->arch.plt.shdr =3D sechdrs + i;
> +		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt.idx"))
> +			mod->arch.plt_idx.shdr =3D sechdrs + i;
> +	}
> +
> +	if (!mod->arch.plt.shdr) {
> +		pr_err("%s: module PLT section(s) missing\n", mod->name);
> +		return -ENOEXEC;
> +	}
> +	if (!mod->arch.plt_idx.shdr) {
> +		pr_err("%s: module PLT.IDX section(s) missing\n", mod->name);
> +		return -ENOEXEC;
> +	}
> +
> +	/* Calculate the maxinum number of entries */
> +	for (i =3D 0; i < ehdr->e_shnum; i++) {
> +		int num_rela =3D sechdrs[i].sh_size / sizeof(Elf_Rela);
> +		Elf_Rela *relas =3D (void *)ehdr + sechdrs[i].sh_offset;
> +		Elf_Shdr *dst_sec =3D sechdrs + sechdrs[i].sh_info;
> +
> +		if (sechdrs[i].sh_type !=3D SHT_RELA)
> +			continue;
> +
> +		/* ignore relocations that operate on non-exec sections */
> +		if (!(dst_sec->sh_flags & SHF_EXECINSTR))
> +			continue;
> +
> +		count_max_entries(relas, num_rela, &num_plts);
> +	}
> +
> +	mod->arch.plt.shdr->sh_type =3D SHT_NOBITS;
> +	mod->arch.plt.shdr->sh_flags =3D SHF_EXECINSTR | SHF_ALLOC;
> +	mod->arch.plt.shdr->sh_addralign =3D L1_CACHE_BYTES;
> +	mod->arch.plt.shdr->sh_size =3D (num_plts + 1) * sizeof(struct=20
> plt_entry);
> +	mod->arch.plt.num_entries =3D 0;
> +	mod->arch.plt.max_entries =3D num_plts;
> +
> +	mod->arch.plt_idx.shdr->sh_type =3D SHT_NOBITS;
> +	mod->arch.plt_idx.shdr->sh_flags =3D SHF_ALLOC;
> +	mod->arch.plt_idx.shdr->sh_addralign =3D L1_CACHE_BYTES;
> +	mod->arch.plt_idx.shdr->sh_size =3D (num_plts + 1) * sizeof(struct=20
> plt_idx_entry);
> +	mod->arch.plt_idx.num_entries =3D 0;
> +	mod->arch.plt_idx.max_entries =3D num_plts;
> +
> +	return 0;
> +}
> diff --git a/arch/loongarch/kernel/module.c=20
> b/arch/loongarch/kernel/module.c
> new file mode 100644
> index 000000000000..87b3768f1eef
> --- /dev/null
> +++ b/arch/loongarch/kernel/module.c
> @@ -0,0 +1,374 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Author: Hanlu Li <lihanlu@loongson.cn>
> + *         Huacai Chen <chenhuacai@loongson.cn>
> + *
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#define pr_fmt(fmt) "kmod: " fmt
> +
> +#include <linux/moduleloader.h>
> +#include <linux/elf.h>
> +#include <linux/mm.h>
> +#include <linux/vmalloc.h>
> +#include <linux/slab.h>
> +#include <linux/fs.h>
> +#include <linux/string.h>
> +#include <linux/kernel.h>
> +
> +static inline bool signed_imm_check(long val, unsigned int bit)
> +{
> +	return -(1L << (bit - 1)) <=3D val && val < (1L << (bit - 1));
> +}
> +
> +static inline bool unsigned_imm_check(unsigned long val, unsigned int=20
> bit)
> +{
> +	return val < (1UL << bit);
> +}
> +
> +static int rela_stack_push(s64 stack_value, s64 *rela_stack, size_t=20
> *rela_stack_top)
> +{
> +	if (*rela_stack_top >=3D RELA_STACK_DEPTH)
> +		return -ENOEXEC;
> +
> +	rela_stack[(*rela_stack_top)++] =3D stack_value;
> +	pr_debug("%s stack_value =3D 0x%llx\n", __func__, stack_value);
> +
> +	return 0;
> +}
> +
> +static int rela_stack_pop(s64 *stack_value, s64 *rela_stack, size_t=20
> *rela_stack_top)
> +{
> +	if (*rela_stack_top =3D=3D 0)
> +		return -ENOEXEC;
> +
> +	*stack_value =3D rela_stack[--(*rela_stack_top)];
> +	pr_debug("%s stack_value =3D 0x%llx\n", __func__, *stack_value);
> +
> +	return 0;
> +}
> +
> +static int apply_r_larch_none(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	return 0;
> +}
> +
> +static int apply_r_larch_error(struct module *me, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	pr_err("%s: Unsupport relocation type %u, please add its support.\n"=
,=20
> me->name, type);
> +	return -EINVAL;
> +}
> +
> +static int apply_r_larch_32(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	*location =3D v;
> +	return 0;
> +}
> +
> +static int apply_r_larch_64(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	*(Elf_Addr *)location =3D v;
> +	return 0;
> +}
> +
> +static int apply_r_larch_sop_push_pcrel(struct module *mod, u32=20
> *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	return rela_stack_push(v - (u64)location, rela_stack, rela_stack_top=
);
> +}
> +
> +static int apply_r_larch_sop_push_absolute(struct module *mod, u32=20
> *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	return rela_stack_push(v, rela_stack, rela_stack_top);
> +}
> +
> +static int apply_r_larch_sop_push_dup(struct module *mod, u32=20
> *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	int err =3D 0;
> +	s64 opr1;
> +
> +	err =3D rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +	err =3D rela_stack_push(opr1, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +	err =3D rela_stack_push(opr1, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +
> +	return 0;
> +}
> +
> +static int apply_r_larch_sop_push_plt_pcrel(struct module *mod, u32=20
> *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	ptrdiff_t offset =3D (void *)v - (void *)location;
> +
> +	if (offset >=3D SZ_128M)
> +		v =3D module_emit_plt_entry(mod, v);
> +
> +	if (offset < -SZ_128M)
> +		v =3D module_emit_plt_entry(mod, v);
> +
> +	return apply_r_larch_sop_push_pcrel(mod, location, v, rela_stack,=20
> rela_stack_top, type);
> +}
> +
> +static int apply_r_larch_sop(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	int err =3D 0;
> +	s64 opr1, opr2, opr3;
> +
> +	if (type =3D=3D R_LARCH_SOP_IF_ELSE) {
> +		err =3D rela_stack_pop(&opr3, rela_stack, rela_stack_top);
> +		if (err)
> +			return err;
> +	}
> +
> +	err =3D rela_stack_pop(&opr2, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +	err =3D rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +
> +	switch (type) {
> +	case R_LARCH_SOP_AND:
> +		err =3D rela_stack_push(opr1 & opr2, rela_stack, rela_stack_top);
> +		break;
> +	case R_LARCH_SOP_ADD:
> +		err =3D rela_stack_push(opr1 + opr2, rela_stack, rela_stack_top);
> +		break;
> +	case R_LARCH_SOP_SUB:
> +		err =3D rela_stack_push(opr1 - opr2, rela_stack, rela_stack_top);
> +		break;
> +	case R_LARCH_SOP_SL:
> +		err =3D rela_stack_push(opr1 << opr2, rela_stack, rela_stack_top);
> +		break;
> +	case R_LARCH_SOP_SR:
> +		err =3D rela_stack_push(opr1 >> opr2, rela_stack, rela_stack_top);
> +		break;
> +	case R_LARCH_SOP_IF_ELSE:
> +		err =3D rela_stack_push(opr1 ? opr2 : opr3, rela_stack,=20
> rela_stack_top);
> +		break;
> +	default:
> +		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
> +		return -EINVAL;
> +	}
> +
> +	return err;
> +}
> +
> +static int apply_r_larch_sop_imm_field(struct module *mod, u32=20
> *location, Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	int err =3D 0;
> +	s64 opr1;
> +	union loongarch_instruction *insn =3D (union loongarch_instruction=20
> *)location;
> +
> +	err =3D rela_stack_pop(&opr1, rela_stack, rela_stack_top);
> +	if (err)
> +		return err;
> +
> +	switch (type) {
> +	case R_LARCH_SOP_POP_32_U_10_12:
> +		if (!unsigned_imm_check(opr1, 12))
> +			goto overflow;
> +
> +		/* (*(uint32_t *) PC) [21 ... 10] =3D opr [11 ... 0] */
> +		insn->reg2i12_format.immediate =3D opr1 & 0xfff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_10_12:
> +		if (!signed_imm_check(opr1, 12))
> +			goto overflow;
> +
> +		insn->reg2i12_format.immediate =3D opr1 & 0xfff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_10_16:
> +		if (!signed_imm_check(opr1, 16))
> +			goto overflow;
> +
> +		insn->reg2i16_format.immediate =3D opr1 & 0xffff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_10_16_S2:
> +		if (opr1 % 4)
> +			goto unaligned;
> +
> +		if (!signed_imm_check(opr1, 18))
> +			goto overflow;
> +
> +		insn->reg2i16_format.immediate =3D (opr1 >> 2) & 0xffff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_5_20:
> +		if (!signed_imm_check(opr1, 20))
> +			goto overflow;
> +
> +		insn->reg1i20_format.immediate =3D (opr1) & 0xfffff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_0_5_10_16_S2:
> +		if (opr1 % 4)
> +			goto unaligned;
> +
> +		if (!signed_imm_check(opr1, 23))
> +			goto overflow;
> +
> +		opr1 >>=3D 2;
> +		insn->reg1i21_format.immediate_l =3D opr1 & 0xffff;
> +		insn->reg1i21_format.immediate_h =3D (opr1 >> 16) & 0x1f;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_S_0_10_10_16_S2:
> +		if (opr1 % 4)
> +			goto unaligned;
> +
> +		if (!signed_imm_check(opr1, 28))
> +			goto overflow;
> +
> +		opr1 >>=3D 2;
> +		insn->reg0i26_format.immediate_l =3D opr1 & 0xffff;
> +		insn->reg0i26_format.immediate_h =3D (opr1 >> 16) & 0x3ff;
> +		return 0;
> +	case R_LARCH_SOP_POP_32_U:
> +		if (!unsigned_imm_check(opr1, 32))
> +			goto overflow;
> +
> +		/* (*(uint32_t *) PC) =3D opr */
> +		*location =3D (u32)opr1;
> +		return 0;
> +	default:
> +		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
> +		return -EINVAL;
> +	}
> +
> +overflow:
> +	pr_err("module %s: opr1 =3D 0x%llx overflow! dangerous %s (%u)=20
> relocation\n",
> +		mod->name, opr1, __func__, type);
> +	return -ENOEXEC;
> +
> +unaligned:
> +	pr_err("module %s: opr1 =3D 0x%llx unaligned! dangerous %s (%u)=20
> relocation\n",
> +		mod->name, opr1, __func__, type);
> +	return -ENOEXEC;
> +}
> +
> +static int apply_r_larch_add_sub(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
> +{
> +	switch (type) {
> +	case R_LARCH_ADD32:
> +		*(s32 *)location +=3D v;
> +		return 0;
> +	case R_LARCH_ADD64:
> +		*(s64 *)location +=3D v;
> +		return 0;
> +	case R_LARCH_SUB32:
> +		*(s32 *)location -=3D v;
> +		return 0;
> +	case R_LARCH_SUB64:
> +		*(s64 *)location -=3D v;
> +		return 0;
> +	default:
> +		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
> +		return -EINVAL;
> +	}
> +}
> +
> +/*
> + * reloc_handlers_rela() - Apply a particular relocation to a module
> + * @mod: the module to apply the reloc to
> + * @location: the address at which the reloc is to be applied
> + * @v: the value of the reloc, with addend for RELA-style
> + * @rela_stack: the stack used for store relocation info, LOCAL to=20
> THIS module
> + * @rela_stac_top: where the stack operation(pop/push) applies to
> + *
> + * Return: 0 upon success, else -ERRNO
> + */
> +typedef int (*reloc_rela_handler)(struct module *mod, u32 *location,=20
> Elf_Addr v,
> +			s64 *rela_stack, size_t *rela_stack_top, unsigned int type);
> +
> +/* The handlers for known reloc types */
> +static reloc_rela_handler reloc_rela_handlers[] =3D {
> +	[R_LARCH_NONE ... R_LARCH_SUB64]		     =3D apply_r_larch_error,
> +
> +	[R_LARCH_NONE]					     =3D apply_r_larch_none,
> +	[R_LARCH_32]					     =3D apply_r_larch_32,
> +	[R_LARCH_64]					     =3D apply_r_larch_64,
> +	[R_LARCH_MARK_LA]				     =3D apply_r_larch_none,
> +	[R_LARCH_MARK_PCREL]				     =3D apply_r_larch_none,
> +	[R_LARCH_SOP_PUSH_PCREL]			     =3D apply_r_larch_sop_push_pcrel,
> +	[R_LARCH_SOP_PUSH_ABSOLUTE]			     =3D apply_r_larch_sop_push_absolu=
te,
> +	[R_LARCH_SOP_PUSH_DUP]				     =3D apply_r_larch_sop_push_dup,
> +	[R_LARCH_SOP_PUSH_PLT_PCREL]			     =3D=20
> apply_r_larch_sop_push_plt_pcrel,
> +	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     =3D apply_r_larch_so=
p,
> +	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] =3D=20
> apply_r_larch_sop_imm_field,
> +	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     =3D apply_r_larch_add_sub,
> +};
> +
> +int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
> +		       unsigned int symindex, unsigned int relsec,
> +		       struct module *mod)
> +{
> +	int i, err;
> +	unsigned int type;
> +	s64 rela_stack[RELA_STACK_DEPTH];
> +	size_t rela_stack_top =3D 0;
> +	reloc_rela_handler handler;
> +	void *location;
> +	Elf_Addr v;
> +	Elf_Sym *sym;
> +	Elf_Rela *rel =3D (void *) sechdrs[relsec].sh_addr;
> +
> +	pr_debug("%s: Applying relocate section %u to %u\n", __func__, relse=
c,
> +	       sechdrs[relsec].sh_info);
> +
> +	rela_stack_top =3D 0;
> +	for (i =3D 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
> +		/* This is where to make the change */
> +		location =3D (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr +=20
> rel[i].r_offset;
> +		/* This is the symbol it is referring to */
> +		sym =3D (Elf_Sym *)sechdrs[symindex].sh_addr +=20
> ELF_R_SYM(rel[i].r_info);
> +		if (IS_ERR_VALUE(sym->st_value)) {
> +			/* Ignore unresolved weak symbol */
> +			if (ELF_ST_BIND(sym->st_info) =3D=3D STB_WEAK)
> +				continue;
> +			pr_warn("%s: Unknown symbol %s\n", mod->name, strtab +=20
> sym->st_name);
> +			return -ENOENT;
> +		}
> +
> +		type =3D ELF_R_TYPE(rel[i].r_info);
> +
> +		if (type < ARRAY_SIZE(reloc_rela_handlers))
> +			handler =3D reloc_rela_handlers[type];
> +		else
> +			handler =3D NULL;
> +
> +		if (!handler) {
> +			pr_err("%s: Unknown relocation type %u\n", mod->name, type);
> +			return -EINVAL;
> +		}
> +
> +		pr_debug("type %d st_value %llx r_addend %llx loc %llx\n",
> +		       (int)ELF_R_TYPE(rel[i].r_info),
> +		       sym->st_value, rel[i].r_addend, (u64)location);
> +
> +		v =3D sym->st_value + rel[i].r_addend;
> +		err =3D handler(mod, location, v, rela_stack, &rela_stack_top, type=
);
> +		if (err)
> +			return err;
> +	}
> +
> +	return 0;
> +}
> +
> +void *module_alloc(unsigned long size)
> +{
> +	return __vmalloc_node_range(size, 1, MODULES_VADDR, MODULES_END,
> +			GFP_KERNEL, PAGE_KERNEL, 0, NUMA_NO_NODE,=20
> __builtin_return_address(0));
> +}
> --=20
> 2.27.0

--=20
- Jiaxun
