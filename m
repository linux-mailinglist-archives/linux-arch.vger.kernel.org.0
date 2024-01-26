Return-Path: <linux-arch+bounces-1705-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C9583D16F
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 01:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 374CEB23BA1
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jan 2024 00:25:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AB67F0;
	Fri, 26 Jan 2024 00:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="qLEpQRLo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A9C63A
	for <linux-arch@vger.kernel.org>; Fri, 26 Jan 2024 00:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228723; cv=none; b=uuSCkAz9SUP043WACpABX4SX3W11/cBQf4Q6r+AtihPtIbhzLPIZhTttLT9IngJ7U/du3ktnbvwnbNZG7TWQEYZ7CkPQlma5Wo3K87RRvHk7sFJFle2upSFMBnMkXMlulUzj3v362pws9HMFABBhSUPVLUqd9pVWHLLFsiBrR0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228723; c=relaxed/simple;
	bh=OFX6zY9ZzKOd6CUOvNstLQM/lbZ9K+V6IO2gt06G8D0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qtN5gH/2OsVdUP9Xbrla7K92gYEQbD2lTN0zKwjxigduRfzOAL8qES8R5qLR0Qh8HPeX+aPz42blgauV9BCw4JyiobYvHbohH93JDXB6g+Q6eTp9egmwVPjMZoyzk9AgWk/oo+ItqujfMliufomGISevnzPzcgX5o0dEMmdrb70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=qLEpQRLo; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ddcfda697cso943956b3a.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 16:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706228720; x=1706833520; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LLSqfOm2POO6p7A9gx9r4kCa+nimqkNcj2tnZ819KhU=;
        b=qLEpQRLoorOVOhfNoWxXoEMAYsBzYgTsRIqbDk6FEmvjG1YJj5OKC/RN6CDeMX6vJV
         XGVz4twcPTTT/iDayGsn8G1/9+bWIbSsN3Uvrp2Z63h8Tm25SVF9PUKeKGLWYiPWVOKb
         gN86xQ1GdFkHJycix0UIzdU/bSHX71qBp22Y3dDleCLXGKlUi9HdD/SuP+6aX3pHY0Mz
         ENmrrfW+HZCWc+03fe3K6w2dIHF+fexRrQTGQo+qB2k/PXdA+dqfTmrJZsK827pdxYkq
         sBbCXB1Mn48CrNGt4B0294NItnRfLMS8Mx9afMLDx/Nc3AjOBVZprOCIeRm/yycVhnYz
         uJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706228720; x=1706833520;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLSqfOm2POO6p7A9gx9r4kCa+nimqkNcj2tnZ819KhU=;
        b=afcIkGU0ytmUDM6oZw49v3WqGGXbMvt1RUpe7cwvaE39+QdaJnt79/4vrsrBIcXks5
         CcDLQrwVZI8k61RSuxhwDpyBCMVRLUDP1xsmD7LwTHv/GsVhND3no5MMgD4bC8swoJGe
         XjfNmBuPRebFudf3MVDiGnbLQRmhBFpwYMIVWLTqa6wTgpBijVoVt8A9VZD4j6HE+8fW
         +e5802bgw1CiwHrwKvKKtNqszKV7aw+I2eezUi95Kfa0JGE87Dlyr0+2TAx0l4f1H212
         lHXRi95A5PfaPY/pFcQxb3wtTGJge78BwjOCmVrh5hBVHZZy8F6cnFi2pVIMcd57teLa
         3ccQ==
X-Gm-Message-State: AOJu0YyKmWNvTLzRwhUC1FbMfCRtMsL4Ly0JMKFkK+Puoasrcwtp/tsZ
	lpDFv0CeRV+WljglZOaSzC4tVziRXxj/DpI4MTUrGLtp3hDEPSYafkj1WXUpcxk=
X-Google-Smtp-Source: AGHT+IEwJOQL+wCF/BXu0jR2YvU413UsghsUUnTdBK/TgLO7Z/hLyZPpV0S4r//d4bR9vtLzCMYfEw==
X-Received: by 2002:a05:6a20:dd88:b0:19a:f27b:a7f7 with SMTP id kw8-20020a056a20dd8800b0019af27ba7f7mr515849pzb.119.1706228720379;
        Thu, 25 Jan 2024 16:25:20 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id gu7-20020a056a004e4700b006db105027basm112600pfb.50.2024.01.25.16.25.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 16:25:20 -0800 (PST)
Date: Thu, 25 Jan 2024 16:25:15 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Stefan O'Rear <sorear@fastmail.com>
Cc: rick.p.edgecombe@intel.com, broonie@kernel.org, Szabolcs.Nagy@arm.com,
	"kito.cheng@sifive.com" <kito.cheng@sifive.com>,
	Kees Cook <keescook@chromium.org>,
	Andrew Jones <ajones@ventanamicro.com>, paul.walmsley@sifive.com,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Conor Dooley <conor.dooley@microchip.com>, cleger@rivosinc.com,
	Atish Patra <atishp@atishpatra.org>,
	Alexandre Ghiti <alex@ghiti.fr>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@rivosinc.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Jonathan Corbet <corbet@lwn.net>, Albert Ou <aou@eecs.berkeley.edu>,
	oleg@redhat.com, akpm@linux-foundation.org, arnd@arndb.de,
	"Eric W. Biederman" <ebiederm@xmission.com>, shuah@kernel.org,
	Christian Brauner <brauner@kernel.org>, guoren <guoren@kernel.org>,
	samitolvanen@google.com, Evan Green <evan@rivosinc.com>,
	xiao.w.wang@intel.com, Anup Patel <apatel@ventanamicro.com>,
	mchitale@ventanamicro.com, waylingii@gmail.com,
	greentime.hu@sifive.com, Heiko Stuebner <heiko@sntech.de>,
	Jisheng Zhang <jszhang@kernel.org>, shikemeng@huaweicloud.com,
	David Hildenbrand <david@redhat.com>,
	Charlie Jenkins <charlie@rivosinc.com>, panqinglin2020@iscas.ac.cn,
	willy@infradead.org, Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>, Greg Ungerer <gerg@kernel.org>,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, Baoquan He <bhe@redhat.com>,
	chenjiahao16@huawei.com, ruscur@russell.cc, bgray@linux.ibm.com,
	alx@kernel.org, baruch@tkos.co.il, zhangqing@loongson.cn,
	Catalin Marinas <catalin.marinas@arm.com>, revest@chromium.org,
	josh@joshtriplett.org, joey.gouly@arm.com, shr@devkernel.io,
	omosnace@redhat.com, ojeda@kernel.org, jhubbard@nvidia.com,
	linux-doc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 07/28] riscv: kernel handling on trap entry/exit
 for user cfi
Message-ID: <ZbL7618N++ygHlM8@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-8-debug@rivosinc.com>
 <ab343d4b-d8b0-47fc-8040-83313a3d735e@app.fastmail.com>
 <ZbKanLeU7yf9aTkD@debug.ba.rivosinc.com>
 <153fe34e-ba56-478e-b0b9-ae85c6c945b5@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <153fe34e-ba56-478e-b0b9-ae85c6c945b5@app.fastmail.com>

On Thu, Jan 25, 2024 at 02:47:49PM -0500, Stefan O'Rear wrote:
>On Thu, Jan 25, 2024, at 12:30 PM, Deepak Gupta wrote:
>> On Thu, Jan 25, 2024 at 02:29:01AM -0500, Stefan O'Rear wrote:
>>>On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
>>>> From: Deepak Gupta <debug@rivosinc.com>
>>>>
>>>> Carves out space in arch specific thread struct for cfi status and shadow stack
>>>> in usermode on riscv.
>>>>
>>>> This patch does following
>>>> - defines a new structure cfi_status with status bit for cfi feature
>>>> - defines shadow stack pointer, base and size in cfi_status structure
>>>> - defines offsets to new member fields in thread in asm-offsets.c
>>>> - Saves and restore shadow stack pointer on trap entry (U --> S) and exit
>>>>   (S --> U)
>>>>
>>>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>> ---
>>>>  arch/riscv/include/asm/processor.h   |  1 +
>>>>  arch/riscv/include/asm/thread_info.h |  3 +++
>>>>  arch/riscv/include/asm/usercfi.h     | 24 ++++++++++++++++++++++++
>>>>  arch/riscv/kernel/asm-offsets.c      |  5 ++++-
>>>>  arch/riscv/kernel/entry.S            | 25 +++++++++++++++++++++++++
>>>>  5 files changed, 57 insertions(+), 1 deletion(-)
>>>>  create mode 100644 arch/riscv/include/asm/usercfi.h
>>>>
>>>> diff --git a/arch/riscv/include/asm/processor.h
>>>> b/arch/riscv/include/asm/processor.h
>>>> index ee2f51787ff8..d4dc298880fc 100644
>>>> --- a/arch/riscv/include/asm/processor.h
>>>> +++ b/arch/riscv/include/asm/processor.h
>>>> @@ -14,6 +14,7 @@
>>>>
>>>>  #include <asm/ptrace.h>
>>>>  #include <asm/hwcap.h>
>>>> +#include <asm/usercfi.h>
>>>>
>>>>  #ifdef CONFIG_64BIT
>>>>  #define DEFAULT_MAP_WINDOW	(UL(1) << (MMAP_VA_BITS - 1))
>>>> diff --git a/arch/riscv/include/asm/thread_info.h
>>>> b/arch/riscv/include/asm/thread_info.h
>>>> index 320bc899a63b..6a2acecec546 100644
>>>> --- a/arch/riscv/include/asm/thread_info.h
>>>> +++ b/arch/riscv/include/asm/thread_info.h
>>>> @@ -58,6 +58,9 @@ struct thread_info {
>>>>  	int			cpu;
>>>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>>>  	unsigned long envcfg;
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +	struct cfi_status       user_cfi_state;
>>>> +#endif
>>>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>>>  	void			*scs_base;
>>>>  	void			*scs_sp;
>>>> diff --git a/arch/riscv/include/asm/usercfi.h
>>>> b/arch/riscv/include/asm/usercfi.h
>>>> new file mode 100644
>>>> index 000000000000..080d7077d12c
>>>> --- /dev/null
>>>> +++ b/arch/riscv/include/asm/usercfi.h
>>>> @@ -0,0 +1,24 @@
>>>> +/* SPDX-License-Identifier: GPL-2.0
>>>> + * Copyright (C) 2023 Rivos, Inc.
>>>> + * Deepak Gupta <debug@rivosinc.com>
>>>> + */
>>>> +#ifndef _ASM_RISCV_USERCFI_H
>>>> +#define _ASM_RISCV_USERCFI_H
>>>> +
>>>> +#ifndef __ASSEMBLY__
>>>> +#include <linux/types.h>
>>>> +
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +struct cfi_status {
>>>> +	unsigned long ubcfi_en : 1; /* Enable for backward cfi. */
>>>> +	unsigned long rsvd : ((sizeof(unsigned long)*8) - 1);
>>>> +	unsigned long user_shdw_stk; /* Current user shadow stack pointer */
>>>> +	unsigned long shdw_stk_base; /* Base address of shadow stack */
>>>> +	unsigned long shdw_stk_size; /* size of shadow stack */
>>>> +};
>>>> +
>>>> +#endif /* CONFIG_RISCV_USER_CFI */
>>>> +
>>>> +#endif /* __ASSEMBLY__ */
>>>> +
>>>> +#endif /* _ASM_RISCV_USERCFI_H */
>>>> diff --git a/arch/riscv/kernel/asm-offsets.c
>>>> b/arch/riscv/kernel/asm-offsets.c
>>>> index cdd8f095c30c..5e1f412e96ba 100644
>>>> --- a/arch/riscv/kernel/asm-offsets.c
>>>> +++ b/arch/riscv/kernel/asm-offsets.c
>>>> @@ -43,8 +43,11 @@ void asm_offsets(void)
>>>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>>>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>>>>  #endif
>>>> -
>>>>  	OFFSET(TASK_TI_CPU_NUM, task_struct, thread_info.cpu);
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +	OFFSET(TASK_TI_CFI_STATUS, task_struct, thread_info.user_cfi_state);
>>>> +	OFFSET(TASK_TI_USER_SSP, task_struct,
>>>> thread_info.user_cfi_state.user_shdw_stk);
>>>> +#endif
>>>>  	OFFSET(TASK_THREAD_F0,  task_struct, thread.fstate.f[0]);
>>>>  	OFFSET(TASK_THREAD_F1,  task_struct, thread.fstate.f[1]);
>>>>  	OFFSET(TASK_THREAD_F2,  task_struct, thread.fstate.f[2]);
>>>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>> index 63c3855ba80d..410659e2eadb 100644
>>>> --- a/arch/riscv/kernel/entry.S
>>>> +++ b/arch/riscv/kernel/entry.S
>>>> @@ -49,6 +49,21 @@ SYM_CODE_START(handle_exception)
>>>>  	REG_S x5,  PT_T0(sp)
>>>>  	save_from_x6_to_x31
>>>>
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +	/*
>>>> +	* we need to save cfi status only when previous mode was U
>>>> +	*/
>>>> +	csrr s2, CSR_STATUS
>>>> +	andi s2, s2, SR_SPP
>>>> +	bnez s2, skip_bcfi_save
>>>> +	/* load cfi status word */
>>>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>>>> +	andi s3, s3, 1
>>>> +	beqz s3, skip_bcfi_save
>>>> +	csrr s3, CSR_SSP
>>>> +	REG_S s3, TASK_TI_USER_SSP(tp) /* save user ssp in thread_info */
>>>> +skip_bcfi_save:
>>>> +#endif
>>>>  	/*
>>>>  	 * Disable user-mode memory access as it should only be set in the
>>>>  	 * actual user copy routines.
>>>> @@ -141,6 +156,16 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>>>  	 * structures again.
>>>>  	 */
>>>>  	csrw CSR_SCRATCH, tp
>>>> +
>>>> +#ifdef CONFIG_RISCV_USER_CFI
>>>> +	lw s3, TASK_TI_CFI_STATUS(tp)
>>>> +	andi s3, s3, 1
>>>> +	beqz s3, skip_bcfi_resume
>>>> +	REG_L s3, TASK_TI_USER_SSP(tp) /* restore user ssp from thread struct */
>>>> +	csrw CSR_SSP, s3
>>>> +skip_bcfi_resume:
>>>> +#endif
>>>> +
>>>
>>>We shouldn't need any of this in the entry/exit code, at least as long as
>>>the kernel itself is not using Zicfiss.  ssp can keep its value in the
>>>kernel and swap it on task switches.  Our entry/exit code is rather short
>>>and I'd like to keep it that way.
>>
>> I kept it here because sooner or later we will need to establish kernel
>> shadow
>> stack. Kernel shadow stack on riscv (compared to other arches) kernel
>> actually will
>> be easier to support and adopt because there is already support for
>> shadow call stack
>> (SCS, [1]). Difference between existing shadow call stack (SCS) and
>> `zicfiss` based
>> kernel shadow stack would be
>>
>> 	- In prolog instead of using `sd`, we will be inserting `sspush` to
>> save ret addr
>> 	- In epilog instead of using `ld` and compare, we will be inserting
>> `sspopchk`
>>
>> So a lot underlying work and functional testing for shadow kernel stack
>> is already carried
>> out with SCS patches. It would be easier and faster to re-use SCS
>> patches to support
>> `zicfiss` based shadow stack.
>
>Do you think that realistically, after all the patches are merged, almost all
>kernel configurations that enable kernel Zicfiss will also enable userspace
>Zicfiss and vice versa?
>
>If not - if Zicfiss exclusively in user mode is likely to be a common
>configuration - then the kernel should handle that case in task switch.
>
>If kernel Zicfiss and user Zicfiss are overwhelmingly likely to be supported
>together, then I agree it makes sense to handle it in the same place in
>entry/exit, but I think what you have is more complicated than necessary.
>I'm picturing something like this:

I expect user mode would be the first target and even if kernel shadow stacks
are enabled, it may not be as pervasive in adoption as I expect for user mode.

I do expect it to be used in settings where both are enabled (if not overwhelmingly)

Since that has to be supported, it's better to have it organized where we are saving/
restoring in a way which serves both needs rather than have two ways to save/restore
depending on how user shadow stacks and kernel shadow stacks are configured.

>
>--- a/arch/riscv/kernel/entry.S
>+++ b/arch/riscv/kernel/entry.S
>@@ -32,6 +32,13 @@ SYM_CODE_START(handle_exception)
>        csrr tp, CSR_SCRATCH
>        REG_S sp, TASK_TI_KERNEL_SP(tp)
>
>+#ifdef CONFIG_SHADOW_CALL_STACK
>+       ALTERNATIVE("scs_save_current\n\tnop\n\tnop",
>+                    "csrr sp, ssp\n\t"
>+                   "REG_S sp, TASK_TI_SCS_SP(tp)\n\t"
>+                    "REG_L sp, TASK_TI_KERNEL_SP(tp)")
>+#endif
>+
> #ifdef CONFIG_VMAP_STACK
>        addi sp, sp, -(PT_SIZE_ON_STACK)
>        srli sp, sp, THREAD_SHIFT
>@@ -80,8 +87,13 @@ SYM_CODE_START(handle_exception)
>        /* Load the global pointer */
>        load_global_pointer
>
>-       /* Load the kernel shadow call stack pointer if coming from userspace */
>-       scs_load_current_if_task_changed s5
>+       /* Load the kernel shadow call stack pointer (harmless if from kernel) */
>+#ifdef CONFIG_SHADOW_CALL_STACK
>+       ALTERNATIVE("scs_load_current\n\tnop\n\tnop",
>+                    "REG_L s0, TASK_TI_SCS_SP(tp)\n\t"
>+                    "csrrw s0, ssp, s0\n\t"
>+                    "REG_S s0, PT_SSP(sp)")
>+#endif
>
>        move a0, sp /* pt_regs */
>        la ra, ret_from_exception
>@@ -130,7 +142,12 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>        REG_S s0, TASK_TI_KERNEL_SP(tp)
>
>        /* Save the kernel shadow call stack pointer */
>-       scs_save_current
>+#ifdef CONFIG_SHADOW_CALL_STACK
>+       ALTERNATIVE("scs_save_current\n\tnop\n\tnop",
>+                    "REG_L s0, PT_SSP(sp)\n\t"
>+                    "csrrw s0, ssp, s0\n\t"
>+                    "REG_S s0, TASK_TI_SCS_SP(tp)")
>+#endif

I've not used alternatives earlier. But yes along with kernel shadow stack
this is much more appealing. Let me munch on it a bit. 

>
>        /*
>         * Save TP into the scratch register , so we can find the kernel data
>
>
>I moved the shadow stack pointer into pt_regs because it's nearly a GPR and has a
>meaningfully different value on every trap; this allows us to talk about the ssp
>at the time of a trap in kernel mode.

I had been under the impression that changing `pt_regs` is something that we don't
do usually. If it doesn't require a high bar, I'll do that. Infact, one my earlier
implementation had ssp in pt_regs.

>
>Saving both the sp and ssp in Lrestore_kernel_tpsp avoids adding conditional logic
>to Lsave_context.  I believe the current code also has a bug: if the U-mode tp is,
>by chance or intentional exploit, equal to the thread_info address, kernel code
>will be executed with whatever value U-mode left in gp.
>
>I also notice that there is no check for overflow of the shadow stack.  This may be
>intentional, since as long as the shadow stack is at least half the size of the
>main kernel stack the latter will always overflow first, barring deeper corruption
>of the control structures or assembly code issues.  I expect that the result in that
>case would be an infinite loop of shadow stack overflows in handle_bad_stack and
>do_trap_software_check with occasional visits to handle_kernel_stack_overflow.
>
>I believe that "Save unwound kernel stack pointer in thread_info" and "Save the
>kernel shadow call stack pointer" are both no-ops in all cases other than ret_from_fork,
>since the ABI requires the C trap handler to return with the same sp and ssp it
>was entered with.  Optimizing that would be a separate issue.
>
>-s
>
>>
>> I don't have favorites here, if overwhelving opinion of community here
>> is to take this
>> logic into task switching and re-work this logic back into entry.S
>> whenever shadow stack for
>> kernel patches are posted, I can do that as well.
>>
>> [1] -
>> https://lore.kernel.org/all/20230828195833.756747-8-samitolvanen@google.com/
>>
>>>
>>>-s
>>>
>>>>  1:
>>>>  	REG_L a0, PT_STATUS(sp)
>>>>  	/*
>>>> --
>>>> 2.43.0
>>>>
>>>>
>>>> _______________________________________________
>>>> linux-riscv mailing list
>>>> linux-riscv@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

