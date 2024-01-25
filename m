Return-Path: <linux-arch+bounces-1680-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B16D83CCCD
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 20:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D11DEB23848
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 19:48:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016D61350D3;
	Thu, 25 Jan 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="o1NaNZvm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gsCqhg5W"
X-Original-To: linux-arch@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7477134730;
	Thu, 25 Jan 2024 19:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706212096; cv=none; b=bGwtAIir/vU2JM56TC6/ncDu278D/0LrX9yraJHQyOzStUXWNgbhg2tUpq8KSCy48m1Z2pcYSxngyhpZI25HwuVKt/67lRT8Fdcv+E4WE3UUjJvZ0i9QVJo7/It8QyjT8cUPpRw96m5U5hE7H5SQS0JbN9qV9IHecJUEEbPrc2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706212096; c=relaxed/simple;
	bh=DCQN7d31MIYfsXGNiU/la2ZojX7SsWPDdmKzKAGG4lg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=HOCxoprQbREj2S6UtlbtHOESoPDd5PE4Cvt3YvnQwtb3SGODu1VUUJp/+/4/87zDi65I4mnUi050zbGbEUsBDAA2uOiVnLv1KKDI+6cy3xCSAPw9GGEqW/HasqFvjyt/P5sLIQXllkpcYKxZVkqMSqGo4r5p1np1HDiHwth0wAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=o1NaNZvm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gsCqhg5W; arc=none smtp.client-ip=66.111.4.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D652B5C00FE;
	Thu, 25 Jan 2024 14:48:12 -0500 (EST)
Received: from imap50 ([10.202.2.100])
  by compute3.internal (MEProxy); Thu, 25 Jan 2024 14:48:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1706212092; x=1706298492; bh=mKbYr57mKI
	JjXElGLWWvpOCr9GL5EcE2om0xMVTTcIw=; b=o1NaNZvmowhISqsGutYlLRwb4h
	EHJOI74YWvajIwVN9fjqFTrbK5HhHOHzdaOBlHKG+Ym1smfac6c42AFtJ1U0mOzr
	+n7xSdUkTDpl3Hu9FUTMWUX1+GpK1Dkl9rsz4giKqwVS1S5ALFaf2MzPbv8lhCdF
	/+xNrZKDBAYL6i4K9BGPHmcozaG1xVWNil6594sbY01TtQ51lDuipfLX9U3cjvJH
	SzA1taNTLfnuow12qShQVVJdpBah5CaaS+1y3+qLXrzH6kffurod1jvY2lJ389pz
	qg+SXaAM+CTXpz3KN8joFUSFWhAPdLLzToqOAbFLKxPtj4F4n4Du0wUk9ttA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1706212092; x=1706298492; bh=mKbYr57mKIJjXElGLWWvpOCr9GL5
	EcE2om0xMVTTcIw=; b=gsCqhg5WeJl0O2ALMZ4385mUtrlZw4LAKTzymcpfpnR4
	wGJzWmImoRsa/H33OmYaQEQr2BU3I97TThz7Yug7el+FsT6JWCUVd7FSudyvBjNb
	qoz0PM3Az3Xr/kqbKHsYYaFmCgPQ+S4j8SfOcyrexhriwGk4lfuYvGQxbSJxhG9x
	M5u3br/8LTYZo3suqaFZ0KOY6z1RHDxDXPqdbUck3LUjbmQrrTzpQJSXCEywaYl1
	6KgSf9zuK+fckS3iBCL2582MHGDC0UUT9PBmKdDQ99sdL1jir74XHW9DAx4sOsWu
	1q47aDyG1DGVFD9VvbQ8erfWtb5YN5CGvziVsZZdSw==
X-ME-Sender: <xms:-7qyZefeDXNtNu25OFdrPNDmFCajTXB6Pd0N0O6RreqAQudx4I-s-A>
    <xme:-7qyZYOOFYr_ABFjYzFojN19wZDEdnfi-PcjqjFa92-7HL68MUS9kxy6v48RTqiqG
    HkwesCd_p5vTDG77Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdelhedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedfufht
    vghfrghnucfqkdftvggrrhdfuceoshhorhgvrghrsehfrghsthhmrghilhdrtghomheqne
    cuggftrfgrthhtvghrnhepjeeuhfejjeffkeekgfejjeekffetudeufeektdevueeujedv
    gfeufefghfetjeefnecuffhomhgrihhnpegvnhhtrhihrdhssgdpkhgvrhhnvghlrdhorh
    hgpdhinhhfrhgruggvrggurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshhorhgvrghrsehfrghsthhmrghilhdrtghomh
X-ME-Proxy: <xmx:-7qyZfi3WxuedMdtDIzJcHIEwP5Ei4xTeA3-7QPC1Fv-k4bIjxwC6Q>
    <xmx:-7qyZb-Q2frEJ6ytFUhWF42r-HOxZNwh5OjXgj2mL2wPQqp-h0trAQ>
    <xmx:-7qyZav_BZXuTvAL-5k3Zd0OkVY-7NVvqYb7eytxvCHvbLNVvu7kpA>
    <xmx:_LqyZaFIFsu40Cl2W9ggbGWzwpW_FOBuA7cMxmi8Y5JrgibphnrayA>
Feedback-ID: i84414492:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 9FC541700093; Thu, 25 Jan 2024 14:48:11 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-119-ga8b98d1bd8-fm-20240108.001-ga8b98d1b
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <153fe34e-ba56-478e-b0b9-ae85c6c945b5@app.fastmail.com>
In-Reply-To: <ZbKanLeU7yf9aTkD@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-8-debug@rivosinc.com>
 <ab343d4b-d8b0-47fc-8040-83313a3d735e@app.fastmail.com>
 <ZbKanLeU7yf9aTkD@debug.ba.rivosinc.com>
Date: Thu, 25 Jan 2024 14:47:49 -0500
From: "Stefan O'Rear" <sorear@fastmail.com>
To: debug <debug@rivosinc.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
 "kito.cheng@sifive.com" <kito.cheng@sifive.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Andrew Jones" <ajones@ventanamicro.com>, paul.walmsley@sifive.com,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "Conor Dooley" <conor.dooley@microchip.com>, cleger@rivosinc.com,
 "Atish Patra" <atishp@atishpatra.org>, "Alexandre Ghiti" <alex@ghiti.fr>,
 =?UTF-8?Q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@rivosinc.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>,
 "Jonathan Corbet" <corbet@lwn.net>, "Albert Ou" <aou@eecs.berkeley.edu>,
 oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
 "Eric W. Biederman" <ebiederm@xmission.com>, shuah@kernel.org,
 "Christian Brauner" <brauner@kernel.org>, guoren <guoren@kernel.org>,
 samitolvanen@google.com, "Evan Green" <evan@rivosinc.com>,
 xiao.w.wang@intel.com, "Anup Patel" <apatel@ventanamicro.com>,
 mchitale@ventanamicro.com, waylingii@gmail.com, greentime.hu@sifive.com,
 "Heiko Stuebner" <heiko@sntech.de>, "Jisheng Zhang" <jszhang@kernel.org>,
 shikemeng@huaweicloud.com, "David Hildenbrand" <david@redhat.com>,
 "Charlie Jenkins" <charlie@rivosinc.com>, panqinglin2020@iscas.ac.cn,
 willy@infradead.org, "Vincent Chen" <vincent.chen@sifive.com>,
 "Andy Chiu" <andy.chiu@sifive.com>, "Greg Ungerer" <gerg@kernel.org>,
 jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
 ancientmodern4@gmail.com, mathis.salmen@matsal.de,
 cuiyunhui@bytedance.com, "Baoquan He" <bhe@redhat.com>,
 chenjiahao16@huawei.com, ruscur@russell.cc, bgray@linux.ibm.com,
 alx@kernel.org, baruch@tkos.co.il, zhangqing@loongson.cn,
 "Catalin Marinas" <catalin.marinas@arm.com>, revest@chromium.org,
 josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
 omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
 linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/28] riscv: kernel handling on trap entry/exit for user
 cfi
Content-Type: text/plain

On Thu, Jan 25, 2024, at 12:30 PM, Deepak Gupta wrote:
> On Thu, Jan 25, 2024 at 02:29:01AM -0500, Stefan O'Rear wrote:
>>On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
>>> From: Deepak Gupta <debug@rivosinc.com>
>>>
>>> Carves out space in arch specific thread struct for cfi status and shadow stack
>>> in usermode on riscv.
>>>
>>> This patch does following
>>> - defines a new structure cfi_status with status bit for cfi feature
>>> - defines shadow stack pointer, base and size in cfi_status structure
>>> - defines offsets to new member fields in thread in asm-offsets.c
>>> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>>>   (S --> U)
>>>
>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>> ---
>>>  arch/riscv/include/asm/processor.h   |  1 +
>>>  arch/riscv/include/asm/thread_info.h |  3 +++
>>>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>>>  arch/riscv/kernel/asm-offsets.c      |  5 ++++-
>>>  arch/riscv/kernel/entry.S            | 25 +++++++++++++++++++++++++
>>>  5 files changed, 57 insertions(+), 1 deletion(-)
>>>  create mode 100644 arch/riscv/include/asm/usercfi.h
>>>
>>> diff --git a/arch/riscv/include/asm/processor.h
>>> b/arch/riscv/include/asm/processor.h
>>> index ee2f51787ff8..d4dc298880fc 100644
>>> --- a/arch/riscv/include/asm/processor.h
>>> +++ b/arch/riscv/include/asm/processor.h
>>> @@ -14,6 +14,7 @@
>>>
>>>  #include <asm/ptrace.h>
>>>  #include <asm/hwcap.h>
>>> +#include <asm/usercfi.h>
>>>
>>>  #ifdef CONFIG_64BIT
>>>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>>> diff --git a/arch/riscv/include/asm/thread_info.h
>>> b/arch/riscv/include/asm/thread_info.h
>>> index 320bc899a63b..6a2acecec546 100644
>>> --- a/arch/riscv/include/asm/thread_info.h
>>> +++ b/arch/riscv/include/asm/thread_info.h
>>> @@ -58,6 +58,9 @@ struct thread_info {
>>>  	int			cpu;
>>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>>  	unsigned long envcfg;
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +	struct cfi_status       user_cfi_state;
>>> +#endif
>>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>>  	void			*scs_base;
>>>  	void			*scs_sp;
>>> diff --git a/arch/riscv/include/asm/usercfi.h
>>> b/arch/riscv/include/asm/usercfi.h
>>> new file mode 100644
>>> index 000000000000..080d7077d12c
>>> --- /dev/null
>>> +++ b/arch/riscv/include/asm/usercfi.h
>>> @@ -0,0 +1,24 @@
>>> +/* SPDX-License-Identifier: GPL-2.0
>>> + * Copyright (C) 2023 Rivos, Inc.
>>> + * Deepak Gupta <debug@rivosinc.com>
>>> + */
>>> +#ifndef _ASM_RISCV_USERCFI_H
>>> +#define _ASM_RISCV_USERCFI_H
>>> +
>>> +#ifndef __ASSEMBLY__
>>> +#include <linux/types.h>
>>> +
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +struct cfi_status {
>>> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>> +	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
>>> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
>>> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
>>> +	unsigned long shdw_stk_size; /* size of shadow stack */
>>> +};
>>> +
>>> +#endif /* CONFIG_RISCV_USER_CFI */
>>> +
>>> +#endif /* __ASSEMBLY__ */
>>> +
>>> +#endif /* _ASM_RISCV_USERCFI_H */
>>> diff --git a/arch/riscv/kernel/asm-offsets.c
>>> b/arch/riscv/kernel/asm-offsets.c
>>> index cdd8f095c30c..5e1f412e96ba 100644
>>> --- a/arch/riscv/kernel/asm-offsets.c
>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>> @@ -43,8 +43,11 @@ void asm_offsets(void)
>>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>>>  #endif
>>> -
>>>  	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
>>> +	OFFSET(TASK_TI_USER_SSP, task_struct,
>>> thread_info.user_cfi_state.user_shdw_stk);
>>> +#endif
>>>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>>>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>>>  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>> index 63c3855ba80d..410659e2eadb 100644
>>> --- a/arch/riscv/kernel/entry.S
>>> +++ b/arch/riscv/kernel/entry.S
>>> @@ -49,6 +49,21 @@ SYM_CODE_START(handle_exception)
>>>  	REG_S x5,  PT_T0(sp)
>>>  	save_from_x6_to_x31
>>>
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +	/*
>>> +	* we need to save cfi status only when previous mode was U
>>> +	*/
>>> +	csrr s2, CSR_STATUS
>>> +	andi s2, s2, SR_SPP
>>> +	bnez s2, skip_bcfi_save
>>> +	/* load cfi status word */
>>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>>> +	andi s3, s3, 1
>>> +	beqz s3, skip_bcfi_save
>>> +	csrr s3, CSR_SSP
>>> +	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
>>> +skip_bcfi_save:
>>> +#endif
>>>  	/*
>>>  	 * Disable user-mode memory access as it should only be set in the
>>>  	 * actual user copy routines.
>>> @@ -141,6 +156,16 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>>  	 * structures again.
>>>  	 */
>>>  	csrw CSR_SCRATCH, tp
>>> +
>>> +#ifdef CONFIG_RISCV_USER_CFI
>>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>>> +	andi s3, s3, 1
>>> +	beqz s3, skip_bcfi_resume
>>> +	REG_L s3, TASK_TI_USER_SSP(tp) /* restore user ssp from thread struct */
>>> +	csrw CSR_SSP, s3
>>> +skip_bcfi_resume:
>>> +#endif
>>> +
>>
>>We shouldn't need any of this in the entry/exit code, at least as long as
>>the kernel itself is not using Zicfiss.  ssp can keep its value in the
>>kernel and swap it on task switches.  Our entry/exit code is rather short
>>and I'd like to keep it that way.
>
> I kept it here because sooner or later we will need to establish kernel 
> shadow
> stack. Kernel shadow stack on riscv (compared to other arches) kernel 
> actually will
> be easier to support and adopt because there is already support for 
> shadow call stack
> (SCS, [1]). Difference between existing shadow call stack (SCS) and 
> `zicfiss` based
> kernel shadow stack would be
>
> 	- In prolog instead of using `sd`, we will be inserting `sspush` to 
> save ret addr
> 	- In epilog instead of using `ld` and compare, we will be inserting 
> `sspopchk`
>
> So a lot underlying work and functional testing for shadow kernel stack 
> is already carried
> out with SCS patches. It would be easier and faster to re-use SCS 
> patches to support
> `zicfiss` based shadow stack.

Do you think that realistically, after all the patches are merged, almost all
kernel configurations that enable kernel Zicfiss will also enable userspace
Zicfiss and vice versa?

If not - if Zicfiss exclusively in user mode is likely to be a common
configuration - then the kernel should handle that case in task switch.

If kernel Zicfiss and user Zicfiss are overwhelmingly likely to be supported
together, then I agree it makes sense to handle it in the same place in
entry/exit, but I think what you have is more complicated than necessary.
I'm picturing something like this:

--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -32,6 +32,13 @@ SYM_CODE_START(handle_exception)
        csrr tp, CSR_SCRATCH
        REG_S sp, TASK_TI_KERNEL_SP(tp)
 
+#ifdef CONFIG_SHADOW_CALL_STACK
+       ALTERNATIVE("scs_save_current\n\tnop\n\tnop",
+                    "csrr sp, ssp\n\t"
+                   "REG_S sp, TASK_TI_SCS_SP(tp)\n\t"
+                    "REG_L sp, TASK_TI_KERNEL_SP(tp)")
+#endif
+
 #ifdef CONFIG_VMAP_STACK
        addi sp, sp, -(PT_SIZE_ON_STACK)
        srli sp, sp, THREAD_SHIFT
@@ -80,8 +87,13 @@ SYM_CODE_START(handle_exception)
        /* Load the global pointer */
        load_global_pointer
 
-       /* Load the kernel shadow call stack pointer if coming from userspace */
-       scs_load_current_if_task_changed s5
+       /* Load the kernel shadow call stack pointer (harmless if from kernel) */
+#ifdef CONFIG_SHADOW_CALL_STACK
+       ALTERNATIVE("scs_load_current\n\tnop\n\tnop",
+                    "REG_L s0, TASK_TI_SCS_SP(tp)\n\t"
+                    "csrrw s0, ssp, s0\n\t"
+                    "REG_S s0, PT_SSP(sp)")
+#endif
 
        move a0, sp /* pt_regs */
        la ra, ret_from_exception
@@ -130,7 +142,12 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
        REG_S s0, TASK_TI_KERNEL_SP(tp)
 
        /* Save the kernel shadow call stack pointer */
-       scs_save_current
+#ifdef CONFIG_SHADOW_CALL_STACK
+       ALTERNATIVE("scs_save_current\n\tnop\n\tnop",
+                    "REG_L s0, PT_SSP(sp)\n\t"
+                    "csrrw s0, ssp, s0\n\t"
+                    "REG_S s0, TASK_TI_SCS_SP(tp)")
+#endif
 
        /*
         * Save TP into the scratch register , so we can find the kernel data


I moved the shadow stack pointer into pt_regs because it's nearly a GPR and has a
meaningfully different value on every trap; this allows us to talk about the ssp
at the time of a trap in kernel mode.

Saving both the sp and ssp in Lrestore_kernel_tpsp avoids adding conditional logic
to Lsave_context.  I believe the current code also has a bug: if the U-mode tp is,
by chance or intentional exploit, equal to the thread_info address, kernel code
will be executed with whatever value U-mode left in gp.

I also notice that there is no check for overflow of the shadow stack.  This may be
intentional, since as long as the shadow stack is at least half the size of the
main kernel stack the latter will always overflow first, barring deeper corruption
of the control structures or assembly code issues.  I expect that the result in that
case would be an infinite loop of shadow stack overflows in handle_bad_stack and
do_trap_software_check with occasional visits to handle_kernel_stack_overflow.

I believe that "Save unwound kernel stack pointer in thread_info" and "Save the
kernel shadow call stack pointer" are both no-ops in all cases other than ret_from_fork,
since the ABI requires the C trap handler to return with the same sp and ssp it
was entered with.  Optimizing that would be a separate issue.

-s

>
> I don't have favorites here, if overwhelving opinion of community here 
> is to take this
> logic into task switching and re-work this logic back into entry.S 
> whenever shadow stack for
> kernel patches are posted, I can do that as well.
>
> [1] - 
> https://lore.kernel.org/all/20230828195833.756747-8-samitolvanen@google.com/
>
>>
>>-s
>>
>>>  1:
>>>  	REG_L a0, PT_STATUS(sp)
>>>  	/*
>>> --
>>> 2.43.0
>>>
>>>
>>> _______________________________________________
>>> linux-riscv mailing list
>>> linux-riscv@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

