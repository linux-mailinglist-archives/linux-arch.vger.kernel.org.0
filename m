Return-Path: <linux-arch+bounces-1558-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4689B83BA7F
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 08:20:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B22251F22A9B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 07:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B0B111720;
	Thu, 25 Jan 2024 07:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="4e3TmKy0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvInZ0jw"
X-Original-To: linux-arch@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FA811713;
	Thu, 25 Jan 2024 07:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706167198; cv=none; b=KYTwcoijXNddAZl/9QIcbG6sdbn+Zr1R7bVwVA79sjTLuPMeiRjZKCNT/PNMg042h7Ql0/7thAmGZjwBgYe6mo3bCce+LskunRSIVEfKvDXy/QvSlc507vPH4+DadDW0xAZwnSfxWNWq7jUScUcVAksC3xvyN4XW4lBy4wz9qNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706167198; c=relaxed/simple;
	bh=YKHitqv6MpNmX4Os52+BnwqHeGcQk+N0HbPe7Nk2SUI=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=n1tOIWBstVR4uFHXONLBqE0yGuQCZbd+ryY72xWSvl74RDFNPh6aSc9svm+KVwMQRYI0XVA2eXYcDSeLE29jL64W5c7KyTbofkwfq3LfVeK0ba6BSp3lK2nKHAAstFA4pKbdZUbhHZRDYGcsD3pIoVA+oyFPnBp7afnmGp0IqM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=4e3TmKy0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvInZ0jw; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id 142EB5C01D7;
	Thu, 25 Jan 2024 02:19:55 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 02:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706167195; x=1706253595; bh=vWNYCVEsyV
	iu3nUft3Ms12HcBU6UW+6JtvbOuVw1J0c=; b=4e3TmKy05bp9HO9U1/VOfkypZ0
	sWHC5b6bAA+mHGJ7Kq99ptNEilvV5dL2GTJucuUO+OtutUd3Q+KYy8c5gpF1gEtk
	FYrYNcmd00RIucBB4IB0j3xmx9LIz/Sn7queXTSXQMthrEaMuA2NAJ70Ep6bXeyK
	JK8vjj49qCB0qapQN9xcbVaO8NGaIPgGuuBn+AyOEARE4ONPJyihXfbHEaDWfSpX
	Mz8FgCi26FYvdbSiDeKo4poEgASiec0X4uzr+DRUaOxL95C/O93Wfu246jSs7dc3
	bcEQ1O+0l5lcKZGC9kkubTRJGNr7R+EpcMUgn6dvWAlfgvDetmUx2bnpPLVg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706167195; x=1706253595; bh=vWNYCVEsyViu3nUft3Ms12HcBU6U
	W+6JtvbOuVw1J0c=; b=nvInZ0jw0ZHt3KvTD5qMeeY8vGm1AphVSTXW7jRdtGTA
	UJiIw4rafvd7FNYJlsTpKPHrWQkMDjin485xVsVB5o+lFH2p7Fd9mCritpcWrwZB
	lM4bLLr55oNE+y1JvW62Jz0wpBYKD5gR1oOMf+fw8L0YvVB3xowTvoffPjTz2VDZ
	etkwnNkJW6yE3FwRzZFeU4soPheuhvN/OJIDXi1c5TyO3jW1fLxRwgpt+BpoyFF8
	ZWsARpXIC9mEDBwQaH57gzN8+t5SOaOncX3dYAsUGFLqk3s4S2jfk0aU8XZzroGA
	QB+e4NSrJTESaZTE0oTKMOn80P4U4S3gqcghdM1Qkg==
X-ME-Sender: <xms:mAuyZe8iakB7Hq_2uvqh5DFaJjVied9xfvhmECV2s3_cWlQdq0_9xg>
    <xme:mAuyZeu13YaGB1IJElSnR1iY8q90A6EyAml0W8UXkFCJthZlfL0S0qGO5T_up_euZ
    i4-SBPMNzbyHObLsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelvddguddtfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfu
    thgvfhgrnhcuqfdktfgvrghrfdcuoehsohhrvggrrhesfhgrshhtmhgrihhlrdgtohhmqe
    enucggtffrrghtthgvrhhnpefhtefgffelieduudekgeevueegudegueefhfehhfffiefg
    keffvedtuefggfehteenucffohhmrghinhepvghnthhrhidrshgspdhinhhfrhgruggvrg
    gurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:mAuyZUDv2xOV7UK4WzT3j8956Y_6g6wiayc7xcQZnX9XASPYpNnzhg>
    <xmx:mAuyZWfKe2FTP2blU-_ACLLKvXRHejSZf5xrtf0NMrMujT9qSbB-DQ>
    <xmx:mAuyZTN8xd4j8vKqNvcCgipMRoTmWaP8LbXUIh4NPoVSciouSae3AA>
    <xmx:mwuyZalX7bXSREqZzMkGAApYYZ2zYrSF8WxOVg6DCvX09zhBiDVpiQ>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id CBA0C1700093; Thu, 25 Jan 2024 02:19:52 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <23d023c0-27cf-44fa-be0a-000d1534ef86@app.fastmail.com>
In-Reply-To: <20240125062739.1339782-3-debug@rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-3-debug@rivosinc.com>
Date: Thu, 25 Jan 2024 02:19:29 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: debug@rivosinc.com, rick.p.edgecombe@intel.com, broonie@kernel.org,
 Szabolcs.Nagy@arm.com, "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
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
Subject: Re: [RFC PATCH v1 02/28] riscv: envcfg save and restore on trap entry/exit
Content-Type: text/plain

On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
> From: Deepak Gupta <debug@rivosinc.com>
>
> envcfg CSR defines enabling bits for cache management instructions and soon
> will control enabling for control flow integrity and pointer masking features.
>
> Control flow integrity enabling for forward cfi and backward cfi is controlled
> via envcfg and thus need to be enabled on per thread basis.
>
> This patch creates a place holder for envcfg CSR in `thread_info` and adds
> logic to save and restore on trap entry and exits.

Should only be "restore"?  I don't see saving.

>
> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
> ---
>  arch/riscv/include/asm/thread_info.h | 1 +
>  arch/riscv/kernel/asm-offsets.c      | 1 +
>  arch/riscv/kernel/entry.S            | 4 ++++
>  3 files changed, 6 insertions(+)
>
> diff --git a/arch/riscv/include/asm/thread_info.h 
> b/arch/riscv/include/asm/thread_info.h
> index 574779900bfb..320bc899a63b 100644
> --- a/arch/riscv/include/asm/thread_info.h
> +++ b/arch/riscv/include/asm/thread_info.h
> @@ -57,6 +57,7 @@ struct thread_info {
>  	long			user_sp;	/* User stack pointer */
>  	int			cpu;
>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
> +	unsigned long envcfg;
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	void			*scs_base;
>  	void			*scs_sp;
> diff --git a/arch/riscv/kernel/asm-offsets.c 
> b/arch/riscv/kernel/asm-offsets.c
> index a03129f40c46..cdd8f095c30c 100644
> --- a/arch/riscv/kernel/asm-offsets.c
> +++ b/arch/riscv/kernel/asm-offsets.c
> @@ -39,6 +39,7 @@ void asm_offsets(void)
>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
> +	OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
>  #ifdef CONFIG_SHADOW_CALL_STACK
>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>  #endif
> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
> index 54ca4564a926..63c3855ba80d 100644
> --- a/arch/riscv/kernel/entry.S
> +++ b/arch/riscv/kernel/entry.S
> @@ -129,6 +129,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>  	addi s0, sp, PT_SIZE_ON_STACK
>  	REG_S s0, TASK_TI_KERNEL_SP(tp)
> 
> +	/* restore envcfg bits for current thread */
> +	REG_L s0, TASK_TI_ENVCFG(tp)
> +	csrw CSR_ENVCFG, s0
> +

This is redundant if we're repeatedly processing interrupts or exceptions
within a single task.  We should only be writing envcfg when switching
between tasks or as part of the prctl.

We need to use an ALTERNATIVE for this since the oldest supported hardware
does not have envcfg csrs.

-s

>  	/* Save the kernel shadow call stack pointer */
>  	scs_save_current
> 
> -- 
> 2.43.0
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

