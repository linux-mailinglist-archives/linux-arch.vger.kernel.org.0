Return-Path: <linux-arch+bounces-1657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7E4F83C99B
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24942B232FC
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F0BC7316D;
	Thu, 25 Jan 2024 17:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="wWxB6UTz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3C130E2E
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202562; cv=none; b=b4fW3PIIrDNGLvxZrvbmk77UsPPXGiwzvZCzv4BV4QtmNbHujcaWHxvg4vVn4Rvz8M9d12dqZhAD+Jw1RQ2tf6FOYUdyWacAkXgX3vHgor8K7KMNYNgZlNXJkP4l+68+1GvS6H/AZkNY8CtRC5XfQ2io2vwpvlIr2I+n8kxe3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202562; c=relaxed/simple;
	bh=SYP5SuCzecJg/AbMI+aiTjZqTA04WqjPusKcUYsXjXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nNOCnJCOzpXxE7DGKj9RfmwYQU7fCV9M/cua/sncMxrOJTHksTq5gc7cOApgZP5OWRaKbuHWiTmIfd95VzoCYeOzbCza3mBRIh/u3NJtfW8zZVfbFwqc2gFwb9a649Po6av/w2rz8leqWqTgFYwHtuMJrE7FZW55KAG1bdLKqz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=wWxB6UTz; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6dbb003be79so808697b3a.0
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 09:09:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706202560; x=1706807360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EemHHEVJxCejDW2IGmWybsIfYtaSynaTSK4azEaq/DU=;
        b=wWxB6UTzC752chpv9Ex6QtzPlDcXZCYcUzrQ39rHeCXZCx0ugi59QuQ5HcMpjSm2fS
         6lAivpF8m4CyLmGbvvFo9dr6Ve6NuXhKeRS5/kxBJ24Rf9QTbnzvCpUgAZ1K8xSfi3o+
         9dAaOzASZoMzm2tnA5qQoUdKon0uPc042Zor/AJTthSQMkg1DWUGrbDkjjc++8V3imHl
         +RlWnYje6UplVxu8RdlbYeY8EoNa/qaZPjylUEDaxLEQq4r5Bj5mNfrenqAepVh+P1EU
         qAO8x9NbM4c5eGD4CvKZ+MC2e6FupknCCBBthBiBpn6rfcINTVglRhcmFkzmHSTWn2cr
         FI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202560; x=1706807360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EemHHEVJxCejDW2IGmWybsIfYtaSynaTSK4azEaq/DU=;
        b=vm37WH2bUfS8+yUn7i/10477ZFMokJQzKa2x6Z3JuzjNCYT6AvrEd3ZcM2MkWys3f7
         DGdRITMH1y799iYGy+pqObDXUYlgtxXY7PEyvHnkoUrRKk0lPQFmlBGO8BZmsY+8f82l
         GdpBhlwIexZarrxrTlWheSomlLbNGtotFSCJU1RQjuqgQGyjaHIJyeLUJqfpjL9L8RKq
         81ETFi9XO5fW/rZ7Rqmvjz/UTzlGuZwz/Kd1KlaGqCuh1s1WdFL8L6Iy4TaqsBM/0930
         xl65vGMMw4Iq05bcxu7LKiM/tPT4PUBcUxJwaDWJl858MXZfmU7QS4q5IFMPiR532ZIS
         r3uQ==
X-Gm-Message-State: AOJu0Yy4kQz3rDddODwxzo+UPiMjRW1D99jFpwCUC1iUKdg5NRGr55rF
	QWJDYSGF1mJL824uc0kbQYplFHNCkhxmmWHSTVHlmNB4dBu8u8pg5R1r6awiWhM=
X-Google-Smtp-Source: AGHT+IG/zy1hPfIMx5+FBiFJ5BLS8zAqpVXvwWyHDpqTcM52HEkGIjepOlIdme6VNMNiF/zcKBKxqQ==
X-Received: by 2002:a05:6a00:b4f:b0:6db:ac96:f530 with SMTP id p15-20020a056a000b4f00b006dbac96f530mr221939pfo.24.1706202559878;
        Thu, 25 Jan 2024 09:09:19 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id w128-20020a626286000000b006dde0724247sm180477pfb.149.2024.01.25.09.09.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:09:19 -0800 (PST)
Date: Thu, 25 Jan 2024 09:09:14 -0800
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
	david@redhat.com, Charlie Jenkins <charlie@rivosinc.com>,
	panqinglin2020@iscas.ac.cn, willy@infradead.org,
	Vincent Chen <vincent.chen@sifive.com>,
	Andy Chiu <andy.chiu@sifive.com>, Greg Ungerer <gerg@kernel.org>,
	jeeheng.sia@starfivetech.com, mason.huo@starfivetech.com,
	ancientmodern4@gmail.com, mathis.salmen@matsal.de,
	cuiyunhui@bytedance.com, bhe@redhat.com, ruscur@russell.cc,
	bgray@linux.ibm.com, alx@kernel.org, baruch@tkos.co.il,
	zhangqing@loongson.cn, Catalin Marinas <catalin.marinas@arm.com>,
	revest@chromium.org, josh@joshtriplett.org, joey.gouly@arm.com,
	shr@devkernel.io, omosnace@redhat.com, ojeda@kernel.org,
	jhubbard@nvidia.com, linux-doc@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: Re: [RFC PATCH v1 02/28] riscv: envcfg save and restore on trap
 entry/exit
Message-ID: <ZbKVutBWoelt33GM@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-3-debug@rivosinc.com>
 <23d023c0-27cf-44fa-be0a-000d1534ef86@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <23d023c0-27cf-44fa-be0a-000d1534ef86@app.fastmail.com>

On Thu, Jan 25, 2024 at 02:19:29AM -0500, Stefan O'Rear wrote:
>On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
>> From: Deepak Gupta <debug@rivosinc.com>
>>
>> envcfg CSR defines enabling bits for cache management instructions and soon
>> will control enabling for control flow integrity and pointer masking features.
>>
>> Control flow integrity enabling for forward cfi and backward cfi is controlled
>> via envcfg and thus need to be enabled on per thread basis.
>>
>> This patch creates a place holder for envcfg CSR in `thread_info` and adds
>> logic to save and restore on trap entry and exits.
>
>Should only be "restore"?  I don't see saving.

It's always saved in `thread_info` and user mode can't change it.
So no point saving it.

>
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/include/asm/thread_info.h | 1 +
>>  arch/riscv/kernel/asm-offsets.c      | 1 +
>>  arch/riscv/kernel/entry.S            | 4 ++++
>>  3 files changed, 6 insertions(+)
>>
>> diff --git a/arch/riscv/include/asm/thread_info.h
>> b/arch/riscv/include/asm/thread_info.h
>> index 574779900bfb..320bc899a63b 100644
>> --- a/arch/riscv/include/asm/thread_info.h
>> +++ b/arch/riscv/include/asm/thread_info.h
>> @@ -57,6 +57,7 @@ struct thread_info {
>>  	long			user_sp;	/* User stack pointer */
>>  	int			cpu;
>>  	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>> +	unsigned long envcfg;
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  	void			*scs_base;
>>  	void			*scs_sp;
>> diff --git a/arch/riscv/kernel/asm-offsets.c
>> b/arch/riscv/kernel/asm-offsets.c
>> index a03129f40c46..cdd8f095c30c 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -39,6 +39,7 @@ void asm_offsets(void)
>>  	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>>  	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>>  	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>> +	OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
>>  #ifdef CONFIG_SHADOW_CALL_STACK
>>  	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>>  #endif
>> diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>> index 54ca4564a926..63c3855ba80d 100644
>> --- a/arch/riscv/kernel/entry.S
>> +++ b/arch/riscv/kernel/entry.S
>> @@ -129,6 +129,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>  	addi s0, sp, PT_SIZE_ON_STACK
>>  	REG_S s0, TASK_TI_KERNEL_SP(tp)
>>
>> +	/* restore envcfg bits for current thread */
>> +	REG_L s0, TASK_TI_ENVCFG(tp)
>> +	csrw CSR_ENVCFG, s0
>> +
>
>This is redundant if we're repeatedly processing interrupts or exceptions
>within a single task.  We should only be writing envcfg when switching
>between tasks or as part of the prctl.
>
>We need to use an ALTERNATIVE for this since the oldest supported hardware
>does not have envcfg csrs.

Yeah fixing that in next series. Thanks

>
>-s
>
>>  	/* Save the kernel shadow call stack pointer */
>>  	scs_save_current
>>
>> --
>> 2.43.0
>>
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

