Return-Path: <linux-arch+bounces-1559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D8983BA9D
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 08:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E35B285126
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 154E1125D9;
	Thu, 25 Jan 2024 07:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="4WWqHOsK";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fWat02Ra"
X-Original-To: linux-arch@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3848C125BC;
	Thu, 25 Jan 2024 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167768; cv=none; b=apiliaazNwPVs9edMDwjjAsK0aMZRe+//eOKaqCjmhk/kSPzQ5GXfBiCj4MExo8A4F8ymwVSkM+ermJzM9iNOWanmSxywWWpMnDz+bkd2sUsyUuc71YFiMF8y+ppc8gAtJ3jxHiQd4UPYIJAYgprjzXGJveIMapksasT77kzqoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167768; c=relaxed/simple;
	bh=UDDxqmJwRwfGRdgYCAAJVPgdb8XBmMphX3vXWn1q41I=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=uQoWbb8KsreKxmzEQ6vdGydt64xYL3pA85rjhgY2aRbPXUx5fAlqUPVEu2OITEx6thOWVV93ADKKoJBl772KhoPHDhkzwY7VDVpBRHsFkxZqwq9CYVsHW6jV2YoAvGVAyi0Z6qabtJ+N6Wrwt8No6nnZII72tobscSF0TKt4uhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=4WWqHOsK; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fWat02Ra; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 235435C0095;
	Thu, 25 Jan 2024 02:29:22 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 02:29:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706167762; x=1706254162; bh=4/dVYBNNL2
	9STF+/5i846JO1dRke2hCM5JY24OM2ohU=; b=4WWqHOsKiWwKd8AZBn+R9MaRq0
	o0JaKbYFyW1luubvbv1noVg4Mrlyko5Yl9zZQ9oFnJbyiGuYS7z88GjP7CJIs2br
	hNDgqGEqd1rUryx+AXqc9lrHmRsxIuFSJPVZU3v4ktv52E1ynPbcBVdRtTmTJAtI
	s/gj2vUSM6K8Y6Rh/Fdg7QKAg9xJu0jvqDT0Ghado7JWD9OfSkTZukPkTEa0eoV1
	P+glLGXM4mPNKhUbNuzfGkWf8bCvKxecsOzjgpFm4q+chrU/67Z+NHVa2cg7BetI
	bO3PXjBoaU64EOk9/7Jwbbc2hbtn2LHIZTC79gp2NFhNT1o3ZS9IlRWZwx7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706167762; x=1706254162; bh=4/dVYBNNL29STF+/5i846JO1dRke
	2hCM5JY24OM2ohU=; b=fWat02Ravbdkseak+cwCvRDzjBa5R3ohoLp788UPLofv
	rx9dBbDLsxArc9EKJFXMNMGVWNVSAFGNIBdIuV3eFy3w9mrgPWlfaN0BN2hcY6u2
	tw7d7oc3yXSUKQ8e2Dcx8QNfo+vGCcfZVzAe/FQS/aMwnYId6tpw8tVVke7aspC1
	y2lx357GjC6shwfhUBv7miFC8bP9CUO8B/HHSp7w2DXcOtqOen7uUG2jnwnk0Huu
	ZG/qWxU8QUzm8rKCo9yQbju23D0FyEAli+asS7URM2Lo4dxhJXfLWc8CLg85/PXs
	Ru9AiU2I/Sxr7bFJDEsy++quS8tVXbugzmhRwb0Y6Q==
X-ME-Sender: <xms:0Q2yZZgHwcn24DiOahZrGqrGnvBpm-ZsPC_8Kn5L39IlgEZSHNZ1qg>
    <xme:0Q2yZeDnGGz0_0LGliPx0EXvN9Z7BqjAb-cT42_DFhjNS2uO7XwrZqOOh34j47MFo
    ASeabRK48YLNgAjhA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelvddguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhtefgffelieduudekgeevueegudegueefhfehhfffiefg
    keffvedtuefggfehteenucffohhmrghinhepvghnthhrhidrshgspdhinhhfrhgruggvrg
    gurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:0Q2yZZFSzmAP28-Yw_tJzgxRNKSU-3toWvfbDhR3b_mTG3GoJbIhxw>
    <xmx:0Q2yZeTZlrYF9hZBDnW4R9U05tXmpA06fYTF9UblXerse7ooEN6SfQ>
    <xmx:0Q2yZWxicRgvULAInvriUjS8D6tUBpvVKhQKcf__ndRa8KL4ZWTYEw>
    <xmx:0g2yZbKM5BS9-p4l4K3R6W0ZsBQxfxzHydoICT-YiYLwle95QXW8Uw>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7A9091700093; Thu, 25 Jan 2024 02:29:21 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ab343d4b-d8b0-47fc-8040-83313a3d735e@app.fastmail.com>
In-Reply-To: <20240125062739.1339782-8-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-8-debug@rivosinc.com>
Date: Thu, 25 Jan 2024 02:29:01 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: debug <debug@rivosinc.com>, rick.p.edgecombe@intel.com,
 broonie@kernel.org, Szabolcs.Nagy@arm.com,
 "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Andrew Jones" <ajones@ventanamicro.com>, paul.walmsley@sifive.com,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Conor Dooley" <conor.dooley@microchip.com>, cleger@rivosinc.com,
 "Atish Patra" <atishp@atishpatra.org>, "Alexandre Ghiti" <alex@ghiti.fr>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Albert Ou" <aou@eecs.berkeley.edu>,
 oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
 "Eric W. Biederman" <ebiederm@xmission.com>, shuah@kernel.org,
 "Christian Brauner" <brauner@kernel.org>, guoren <guoren@kernel.org>,
 samitolvanen@google.com, "Evan Green" <evan@rivosinc.com>,
 xiao.w.wang@intel.com, "Anup Patel" <apatel@ventanamicro.com>,
 mchitale@ventanamicro.com, waylingii@gmail.com, greentime.hu@sifive.com,
 "Heiko Stuebner" <heiko@sntech.de>, "Jisheng Zhang" <jszhang@kernel.org>,
 shikemeng@huaweicloud.com, david@redhat.com,
 "Charlie Jenkins" <charlie@rivosinc.com>, panqinglin2020@iscas.ac.cn,
 willy@infradead.org, "Vincent Chen" <vincent.chen@sifive.com>,
 "Andy Chiu" <andy.chiu@sifive.com>, "Greg Ungerer" <gerg@kernel.org>,
 jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
 ancientmodern4@gmail.com, mathis.salmen@matsal.de,
 cuiyunhui@bytedance.com, bhe@redhat.com, chenjiahao16@huawei.com,
 ruscur@russell.cc, bgray@linux.ibm.com, alx@kernel.org,
 baruch@tkos.co.il, zhangqing@loongson.cn,
 "Catalin Marinas" <catalin.marinas@arm.com>, revest@chromium.org,
 josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
 omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/28] riscv: kernel handling on trap entry/exit for user
 cfi
Content-Type: text/plain

On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
>
> Carves out space in arch specific thread struct for cfi status and shadow stack
> in usermode on riscv.
>
> This patch does following
> - defines a new structure cfi_status with status bit for cfi feature
> - defines shadow stack pointer, base and size in cfi_status structure
> - defines offsets to new member fields in thread in asm-offsets.c
> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>   (S --> U)
>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/processor.h   |  1 +
>  arch/riscv/include/asm/thread_info.h |  3 +++
>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>  arch/riscv/kernel/asm-offsets.c      |  5 ++++-
>  arch/riscv/kernel/entry.S            | 25 +++++++++++++++++++++++++
>  5 files changed, 57 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/include/asm/usercfi.h
>
> diff --git a/arch/riscv/include/asm/processor.h 
> b/arch/riscv/include/asm/processor.h
> index ee2f51787ff8..d4dc298880fc 100644
> --- a/arch/riscv/include/asm/processor.h
> +++ b/arch/riscv/include/asm/processor.h
> @@ -14,6 +14,7 @@
> 
>  #include <asm/ptrace.h>
>  #include <asm/hwcap.h>
> +#include <asm/usercfi.h>
> 
>  #ifdef CONFIG_64BIT
>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
> diff --git a/arch/riscv/include/asm/thread_info.h 
> b/arch/riscv/include/asm/thread_info.h
> index 320bc899a63b..6a2acecec546 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -58,6 +58,9 @@ struct thread_info {
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>  	unsigned long envcfg;
> +#ifdef CONFIG_RISCV_USER_CFI
> +	struct cfi_status       user_cfi_state;
> +#endif
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	void			*scs_base;
>  	void			*scs_sp;
> diff --git a/arch/riscv/include/asm/usercfi.h 
> b/arch/riscv/include/asm/usercfi.h
> new file mode 100644
> index 000000000000..080d7077d12c
> --- /dev/null
> +++ b/arch/riscv/include/asm/usercfi.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: GPL-2.0
> + * Copyright (C) 2023 Rivos, Inc.
> + * Deepak Gupta <debug@rivosinc.com>
> + */
> +#ifndef _ASM_RISCV_USERCFI_H
> +#define _ASM_RISCV_USERCFI_H
> +
> +#ifndef __ASSEMBLY__
> +#include <linux/types.h>
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +struct cfi_status {
> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
> +	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
> +	unsigned long shdw_stk_size; /* size of shadow stack */
> +};
> +
> +#endif /* CONFIG_RISCV_USER_CFI */
> +
> +#endif /* __ASSEMBLY__ */
> +
> +#endif /* _ASM_RISCV_USERCFI_H */
> diff --git a/arch/riscv/kernel/asm-offsets.c 
> b/arch/riscv/kernel/asm-offsets.c
> index cdd8f095c30c..5e1f412e96ba 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -43,8 +43,11 @@ void asm_offsets(void)
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> -
>  	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
> +#ifdef CONFIG_RISCV_USER_CFI
> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
> +	OFFSET(TASK_TI_USER_SSP, task_struct, 
> thread_info.user_cfi_state.user_shdw_stk);
> +#endif
>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 63c3855ba80d..410659e2eadb 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -49,6 +49,21 @@ SYM_CODE_START(handle_exception)
>  	REG_S x5,  PT_T0(sp)
>  	save_from_x6_to_x31
> 
> +#ifdef CONFIG_RISCV_USER_CFI
> +	/*
> +	* we need to save cfi status only when previous mode was U
> +	*/
> +	csrr s2, CSR_STATUS
> +	andi s2, s2, SR_SPP
> +	bnez s2, skip_bcfi_save
> +	/* load cfi status word */
> +	lw s3, TASK_TI_CFI_STATUS(tp)
> +	andi s3, s3, 1
> +	beqz s3, skip_bcfi_save
> +	csrr s3, CSR_SSP
> +	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
> +skip_bcfi_save:
> +#endif
>  	/*
>  	 * Disable user-mode memory access as it should only be set in the
>  	 * actual user copy routines.
> @@ -141,6 +156,16 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	 * structures again.
>  	 */
>  	csrw CSR_SCRATCH, tp
> +
> +#ifdef CONFIG_RISCV_USER_CFI
> +	lw s3, TASK_TI_CFI_STATUS(tp)
> +	andi s3, s3, 1
> +	beqz s3, skip_bcfi_resume
> +	REG_L s3, TASK_TI_USER_SSP(tp) /* restore user ssp from thread struct */
> +	csrw CSR_SSP, s3
> +skip_bcfi_resume:
> +#endif
> +

We shouldn't need any of this in the entry/exit code, at least as long as
the kernel itself is not using Zicfiss.  ssp can keep its value in the
kernel and swap it on task switches.  Our entry/exit code is rather short
and I'd like to keep it that way.

-s

>  1:
>  	REG_L a0, PT_STATUS(sp)
>  	/*
> -- 
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

