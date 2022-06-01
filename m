Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3A253A516
	for <lists+linux-arch@lfdr.de>; Wed,  1 Jun 2022 14:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343562AbiFAMdn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Jun 2022 08:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352897AbiFAMdm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Jun 2022 08:33:42 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE509CC99;
        Wed,  1 Jun 2022 05:33:40 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 0DD5A5C02E7;
        Wed,  1 Jun 2022 08:33:40 -0400 (EDT)
Received: from imap44 ([10.202.2.94])
  by compute4.internal (MEProxy); Wed, 01 Jun 2022 08:33:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1654086820; x=
        1654173220; bh=IReQZu40HMuKJt6G+/lDXOkEOlJDntVBO42UzEHC5Ko=; b=X
        3nl7SndjvRvPN2UhU99txLk8Beb0pyY+mv3F5uR5GbxTJ8efcqzQvt62VXiNOjDz
        jrCgaUyjlnFLVDW2zzPVQI6f8kjjYdmgEAqfQ4hDYEb4gFmGQg6ReTDwggyRJhZ4
        T573tlnNeWq3uwURKCPg25/j+HzGGndQTm2+zlpu0g5qomyxJ+7vGjWFzdkgYuh7
        B59yDr53UqFcHP79UhU/pQfIzOA1nwicl9u8X1H4hoQVP8vvTXlpyd63KH2v4gI5
        DEOnZcBa4iUvnU6JOY/ezVODa3CVrhWBaZVZip7zuMR2Masg/0lXicEIaOVj9pFT
        sHfOHi7WulofT38dBuCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1654086820; x=
        1654173220; bh=IReQZu40HMuKJt6G+/lDXOkEOlJDntVBO42UzEHC5Ko=; b=i
        oO6iTOxpX9D5FjEdD3VQPYzHtz2fvmmgGn4YxVCEEFE1CxOsCsdWYqmPxKwnBTDh
        VpMpRadmFouKCVsvaWBMslcw1Ffxn5JgNcJFAZMea4tLz+jfGwTTLkOEqcXrVrBk
        GIed3rn9hqgX2ozS0jSDP0p9TWVGPfGdJl+UJrsIUjHikqE3eM7vz8PWakQVCGev
        IjD+hlD3mbjx4SsAvUofOWkhhS3kOvHcX3NvcF0Yfb0WkwUKB6KO69H/++u1pFD2
        mwJbRhRPg+EvovMFFGm3SBWW+bEPFO5UKGhnBglI/+pX9POJydXOwxRCj+ge+AfP
        ruZAJCKkeSpUQcsRTAOQg==
X-ME-Sender: <xms:o1yXYjGdhGI80LO0nAbpwG6m5ZFIu5LXkndtqnRl-iBLjTVr1UHUEw>
    <xme:o1yXYgUQ08YVy3hY2Clp9r3ddhKkBzZE7Yvlm-YyRzhgCh4LXwGrkj80KZ-60wKpz
    Rre4AI_XOy-EEh_VQ4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrledtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedflfhi
    rgiguhhnucgjrghnghdfuceojhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
    eqnecuggftrfgrthhtvghrnhepjefhleetteeludegleehhffgledvvddvleeujefghfet
    heeftddugeelgfdukeegnecuffhomhgrihhnpehushgvrhdrshgsnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:o1yXYlKoPlo2FwTRHSSApuCjUW9RSU9hTdm_t1TfuUZ6wqPJofS1bQ>
    <xmx:o1yXYhHDYkQ_n9acmqfpCVtwJrPiX5PY3kUSfAob_4GcwPqEu3Y_Hg>
    <xmx:o1yXYpUYPqd1b8UoRYQI0yvmgkpeaUSlXbIwCSGfttbAe7EBgL9mAQ>
    <xmx:pFyXYtnEUCW9KF6Q04qgjGzmfb2372e0dxk196-57lvsUTEpgXQ-1Q>
Feedback-ID: ifd894703:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C163F36A006D; Wed,  1 Jun 2022 08:33:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-591-gfe6c3a2700-fm-20220427.001-gfe6c3a27
Mime-Version: 1.0
Message-Id: <29c5ec6f-5898-4212-afbb-75f76f5320ff@www.fastmail.com>
In-Reply-To: <20220601100005.2989022-20-chenhuacai@loongson.cn>
References: <20220601100005.2989022-1-chenhuacai@loongson.cn>
 <20220601100005.2989022-20-chenhuacai@loongson.cn>
Date:   Wed, 01 Jun 2022 13:33:18 +0100
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
Subject: Re: [PATCH V12 19/24] LoongArch: Add some library functions
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
=8D=8811:00=EF=BC=8CHuacai Chen=E5=86=99=E9=81=93=EF=BC=9A
> Add some library functions for LoongArch, including: delay, memset,
> memcpy, memmove, copy_user, strncpy_user, strnlen_user and tlb dump
> functions.
>
> Reviewed-by: WANG Xuerui <git@xen0n.name>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>

Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>

I particularly love tlbdump function for MIPS. It=E2=80=99s a handy tool=
 for mm debugging.
Good job for LA one.

Thanks.

> ---
>  arch/loongarch/include/asm/delay.h  |  26 +++++++
>  arch/loongarch/include/asm/string.h |  12 +++
>  arch/loongarch/lib/clear_user.S     |  43 +++++++++++
>  arch/loongarch/lib/copy_user.S      |  47 ++++++++++++
>  arch/loongarch/lib/delay.c          |  43 +++++++++++
>  arch/loongarch/lib/dump_tlb.c       | 111 ++++++++++++++++++++++++++++
>  6 files changed, 282 insertions(+)
>  create mode 100644 arch/loongarch/include/asm/delay.h
>  create mode 100644 arch/loongarch/include/asm/string.h
>  create mode 100644 arch/loongarch/lib/clear_user.S
>  create mode 100644 arch/loongarch/lib/copy_user.S
>  create mode 100644 arch/loongarch/lib/delay.c
>  create mode 100644 arch/loongarch/lib/dump_tlb.c
>
> diff --git a/arch/loongarch/include/asm/delay.h=20
> b/arch/loongarch/include/asm/delay.h
> new file mode 100644
> index 000000000000..36d775191310
> --- /dev/null
> +++ b/arch/loongarch/include/asm/delay.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_DELAY_H
> +#define _ASM_DELAY_H
> +
> +#include <linux/param.h>
> +
> +extern void __delay(unsigned long cycles);
> +extern void __ndelay(unsigned long ns);
> +extern void __udelay(unsigned long us);
> +
> +#define ndelay(ns) __ndelay(ns)
> +#define udelay(us) __udelay(us)
> +
> +/* make sure "usecs *=3D ..." in udelay do not overflow. */
> +#if HZ >=3D 1000
> +#define MAX_UDELAY_MS	1
> +#elif HZ <=3D 200
> +#define MAX_UDELAY_MS	5
> +#else
> +#define MAX_UDELAY_MS	(1000 / HZ)
> +#endif
> +
> +#endif /* _ASM_DELAY_H */
> diff --git a/arch/loongarch/include/asm/string.h=20
> b/arch/loongarch/include/asm/string.h
> new file mode 100644
> index 000000000000..b07e60ded957
> --- /dev/null
> +++ b/arch/loongarch/include/asm/string.h
> @@ -0,0 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#ifndef _ASM_STRING_H
> +#define _ASM_STRING_H
> +
> +extern void *memset(void *__s, int __c, size_t __count);
> +extern void *memcpy(void *__to, __const__ void *__from, size_t __n);
> +extern void *memmove(void *__dest, __const__ void *__src, size_t __n);
> +
> +#endif /* _ASM_STRING_H */
> diff --git a/arch/loongarch/lib/clear_user.S=20
> b/arch/loongarch/lib/clear_user.S
> new file mode 100644
> index 000000000000..25d9be5fbb19
> --- /dev/null
> +++ b/arch/loongarch/lib/clear_user.S
> @@ -0,0 +1,43 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +.macro fixup_ex from, to, offset, fix
> +.if \fix
> +	.section .fixup, "ax"
> +\to:	addi.d	a0, a1, \offset
> +	jr	ra
> +	.previous
> +.endif
> +	.section __ex_table, "a"
> +	PTR	\from\()b, \to\()b
> +	.previous
> +.endm
> +
> +/*
> + * unsigned long __clear_user(void *addr, size_t size)
> + *
> + * a0: addr
> + * a1: size
> + */
> +SYM_FUNC_START(__clear_user)
> +	beqz	a1, 2f
> +
> +1:	st.b	zero, a0, 0
> +	addi.d	a0, a0, 1
> +	addi.d	a1, a1, -1
> +	bgt	a1, zero, 1b
> +
> +2:	move	a0, a1
> +	jr	ra
> +
> +	fixup_ex 1, 3, 0, 1
> +SYM_FUNC_END(__clear_user)
> +
> +EXPORT_SYMBOL(__clear_user)
> diff --git a/arch/loongarch/lib/copy_user.S=20
> b/arch/loongarch/lib/copy_user.S
> new file mode 100644
> index 000000000000..9ae507f851b5
> --- /dev/null
> +++ b/arch/loongarch/lib/copy_user.S
> @@ -0,0 +1,47 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +
> +#include <asm/asm.h>
> +#include <asm/asmmacro.h>
> +#include <asm/export.h>
> +#include <asm/regdef.h>
> +
> +.macro fixup_ex from, to, offset, fix
> +.if \fix
> +	.section .fixup, "ax"
> +\to:	addi.d	a0, a2, \offset
> +	jr	ra
> +	.previous
> +.endif
> +	.section __ex_table, "a"
> +	PTR	\from\()b, \to\()b
> +	.previous
> +.endm
> +
> +/*
> + * unsigned long __copy_user(void *to, const void *from, size_t n)
> + *
> + * a0: to
> + * a1: from
> + * a2: n
> + */
> +SYM_FUNC_START(__copy_user)
> +	beqz	a2, 3f
> +
> +1:	ld.b	t0, a1, 0
> +2:	st.b	t0, a0, 0
> +	addi.d	a0, a0, 1
> +	addi.d	a1, a1, 1
> +	addi.d	a2, a2, -1
> +	bgt	a2, zero, 1b
> +
> +3:	move	a0, a2
> +	jr	ra
> +
> +	fixup_ex 1, 4, 0, 1
> +	fixup_ex 2, 4, 0, 0
> +SYM_FUNC_END(__copy_user)
> +
> +EXPORT_SYMBOL(__copy_user)
> diff --git a/arch/loongarch/lib/delay.c b/arch/loongarch/lib/delay.c
> new file mode 100644
> index 000000000000..5d856694fcfe
> --- /dev/null
> +++ b/arch/loongarch/lib/delay.c
> @@ -0,0 +1,43 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + */
> +#include <linux/delay.h>
> +#include <linux/export.h>
> +#include <linux/smp.h>
> +#include <linux/timex.h>
> +
> +#include <asm/compiler.h>
> +#include <asm/processor.h>
> +
> +void __delay(unsigned long cycles)
> +{
> +	u64 t0 =3D get_cycles();
> +
> +	while ((unsigned long)(get_cycles() - t0) < cycles)
> +		cpu_relax();
> +}
> +EXPORT_SYMBOL(__delay);
> +
> +/*
> + * Division by multiplication: you don't have to worry about
> + * loss of precision.
> + *
> + * Use only for very small delays ( < 1 msec).	Should probably use a
> + * lookup table, really, as the multiplications take much too long wi=
th
> + * short delays.  This is a "reasonable" implementation, though (and=20
> the
> + * first constant multiplications gets optimized away if the delay is
> + * a constant)
> + */
> +
> +void __udelay(unsigned long us)
> +{
> +	__delay((us * 0x000010c7ull * HZ * lpj_fine) >> 32);
> +}
> +EXPORT_SYMBOL(__udelay);
> +
> +void __ndelay(unsigned long ns)
> +{
> +	__delay((ns * 0x00000005ull * HZ * lpj_fine) >> 32);
> +}
> +EXPORT_SYMBOL(__ndelay);
> diff --git a/arch/loongarch/lib/dump_tlb.c=20
> b/arch/loongarch/lib/dump_tlb.c
> new file mode 100644
> index 000000000000..cda2c6bc7f09
> --- /dev/null
> +++ b/arch/loongarch/lib/dump_tlb.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
> + *
> + * Derived from MIPS:
> + * Copyright (C) 1994, 1995 by Waldorf Electronics, written by Ralf=20
> Baechle.
> + * Copyright (C) 1999 by Silicon Graphics, Inc.
> + */
> +#include <linux/kernel.h>
> +#include <linux/mm.h>
> +
> +#include <asm/loongarch.h>
> +#include <asm/page.h>
> +#include <asm/pgtable.h>
> +#include <asm/tlb.h>
> +
> +void dump_tlb_regs(void)
> +{
> +	const int field =3D 2 * sizeof(unsigned long);
> +
> +	pr_info("Index    : %0x\n", read_csr_tlbidx());
> +	pr_info("PageSize : %0x\n", read_csr_pagesize());
> +	pr_info("EntryHi  : %0*llx\n", field, read_csr_entryhi());
> +	pr_info("EntryLo0 : %0*llx\n", field, read_csr_entrylo0());
> +	pr_info("EntryLo1 : %0*llx\n", field, read_csr_entrylo1());
> +}
> +
> +static void dump_tlb(int first, int last)
> +{
> +	unsigned long s_entryhi, entryhi, asid;
> +	unsigned long long entrylo0, entrylo1, pa;
> +	unsigned int index;
> +	unsigned int s_index, s_asid;
> +	unsigned int pagesize, c0, c1, i;
> +	unsigned long asidmask =3D cpu_asid_mask(&current_cpu_data);
> +	int pwidth =3D 11;
> +	int vwidth =3D 11;
> +	int asidwidth =3D DIV_ROUND_UP(ilog2(asidmask) + 1, 4);
> +
> +	s_entryhi =3D read_csr_entryhi();
> +	s_index =3D read_csr_tlbidx();
> +	s_asid =3D read_csr_asid();
> +
> +	for (i =3D first; i <=3D last; i++) {
> +		write_csr_index(i);
> +		tlb_read();
> +		pagesize =3D read_csr_pagesize();
> +		entryhi	 =3D read_csr_entryhi();
> +		entrylo0 =3D read_csr_entrylo0();
> +		entrylo1 =3D read_csr_entrylo1();
> +		index =3D read_csr_tlbidx();
> +		asid =3D read_csr_asid();
> +
> +		/* EHINV bit marks entire entry as invalid */
> +		if (index & CSR_TLBIDX_EHINV)
> +			continue;
> +		/*
> +		 * ASID takes effect in absence of G (global) bit.
> +		 */
> +		if (!((entrylo0 | entrylo1) & ENTRYLO_G) &&
> +		    asid !=3D s_asid)
> +			continue;
> +
> +		/*
> +		 * Only print entries in use
> +		 */
> +		pr_info("Index: %2d pgsize=3D%x ", i, (1 << pagesize));
> +
> +		c0 =3D (entrylo0 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
> +		c1 =3D (entrylo1 & ENTRYLO_C) >> ENTRYLO_C_SHIFT;
> +
> +		pr_cont("va=3D%0*lx asid=3D%0*lx",
> +			vwidth, (entryhi & ~0x1fffUL), asidwidth, asid & asidmask);
> +
> +		/* NR/NX are in awkward places, so mask them off separately */
> +		pa =3D entrylo0 & ~(ENTRYLO_NR | ENTRYLO_NX);
> +		pa =3D pa & PAGE_MASK;
> +		pr_cont("\n\t[");
> +		pr_cont("ri=3D%d xi=3D%d ",
> +			(entrylo0 & ENTRYLO_NR) ? 1 : 0,
> +			(entrylo0 & ENTRYLO_NX) ? 1 : 0);
> +		pr_cont("pa=3D%0*llx c=3D%d d=3D%d v=3D%d g=3D%d plv=3D%lld] [",
> +			pwidth, pa, c0,
> +			(entrylo0 & ENTRYLO_D) ? 1 : 0,
> +			(entrylo0 & ENTRYLO_V) ? 1 : 0,
> +			(entrylo0 & ENTRYLO_G) ? 1 : 0,
> +			(entrylo0 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
> +		/* NR/NX are in awkward places, so mask them off separately */
> +		pa =3D entrylo1 & ~(ENTRYLO_NR | ENTRYLO_NX);
> +		pa =3D pa & PAGE_MASK;
> +		pr_cont("ri=3D%d xi=3D%d ",
> +			(entrylo1 & ENTRYLO_NR) ? 1 : 0,
> +			(entrylo1 & ENTRYLO_NX) ? 1 : 0);
> +		pr_cont("pa=3D%0*llx c=3D%d d=3D%d v=3D%d g=3D%d plv=3D%lld]\n",
> +			pwidth, pa, c1,
> +			(entrylo1 & ENTRYLO_D) ? 1 : 0,
> +			(entrylo1 & ENTRYLO_V) ? 1 : 0,
> +			(entrylo1 & ENTRYLO_G) ? 1 : 0,
> +			(entrylo1 & ENTRYLO_PLV) >> ENTRYLO_PLV_SHIFT);
> +	}
> +	pr_info("\n");
> +
> +	write_csr_entryhi(s_entryhi);
> +	write_csr_tlbidx(s_index);
> +	write_csr_asid(s_asid);
> +}
> +
> +void dump_tlb_all(void)
> +{
> +	dump_tlb(0, current_cpu_data.tlbsize - 1);
> +}
> --=20
> 2.27.0

--=20
- Jiaxun
