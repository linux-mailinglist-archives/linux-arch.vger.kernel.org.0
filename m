Return-Path: <linux-arch+bounces-1666-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E994F83CA58
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 18:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64CF31F224CB
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 17:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1E13341F;
	Thu, 25 Jan 2024 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Pz6dvobP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D104E12FF9F
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706205272; cv=none; b=iW2tRbVxmB5RnPfQ9hrYbUsumxsdxAfPrN4JMheUsWYsPymewkmzdekgEb9fTxyTnLKvMWNGcO+YQ0Ww2NivXq59zLAQap3j5YuoBlxteokAGH+eiZWUibHi4jcZS6DDpcoQh25MGFSPTNujNz8V692G/zgrhNezRHKrpN51TcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706205272; c=relaxed/simple;
	bh=VsLFSDl7f7nn/2y4Kg5VSlUgb504F1jxZ9Td7ivSykw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ow9MCLZbV/uWJdUWZU2M0x0x7771CxclAKwGNkcSN5xIPEFNHrF9hO2IA5ia/iNhtv0s8lqNdDeq2pF+ndUfqJQvZ9LpXH1hmFFixRom70MviWveG5ZSSOw9kRG9ITKkaVH/0eYcftX8o6K9AxD165MJPEZZyerSvAJLHKiCNbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Pz6dvobP; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d74678df08so30477785ad.1
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 09:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1706205269; x=1706810069; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nicyzemtTRD4VSL2aIrfR13izgwrVMBCjiaMcBIu4g=;
        b=Pz6dvobP3bBpBIqYOwIRbPEQ0kDqPXzNkD24vhOcQZq61EZBwNBa1p2Rv9tIvMkVre
         wDGHea+x3L8tuQuSnLPbKEEUHu5wzVXFKA62wi1L6hn0S6Ep5grJ53EN+egkxjqxLW1t
         s+dPT8eBwdocV/D+MFYtKa65myLQXzuVM3hD+MPKKBHFXGPJOOMOE31W89jbrsWMmt3n
         FrKDUeTdb/9KlGFs5jzc3dlWHeAb3+Rkw7linE+GOZ3ZYiOEz+vR7pTpq1ISGfQ+FkAx
         /HV/z+7BI+M9OmUnadV/XqmTxrXMPe9B99qL/ubw5PXWSeBTPQVldsxo1dvJgY6DvrUx
         KmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706205269; x=1706810069;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2nicyzemtTRD4VSL2aIrfR13izgwrVMBCjiaMcBIu4g=;
        b=WSjmOhF2P6nbrY8O8JOrGc2UogH10rYDl+upFxLp/v1VpdF6r0IzgtwxlStSgunSd5
         3J+7KdJfH7Umaf5oK86A+JY2B7MPW/H3QXjg6EsVSSbb9SqoG90Kj0XSHgAgG+p779bI
         SZ5DfrbGusGFfhRUYFVl9Z2ZkTHwzUw5P2lZhKfhAXc4zXjS1O9wEEQTah+nie1+7Ciz
         CB65SdRZpgD1XyVGb0qGbCuuYHXI/tYU0klxURV3jispS17uwnkUDYFHktkqANuHv9LN
         /mQQLixp8ptqtDRHbZXT3PphRFR2mXg5R0acM9i7TTpSFulc+CxiCtSC5Txtp5t+xauU
         QWbw==
X-Gm-Message-State: AOJu0YyzMejkjM104DMU0eMi7G9BtAoMA5lmAA4ISBFR2MwhR3F0TW8g
	1s3vlTDeaGJo3p1mGXz+SuMNbx0YP3tDfsT1TiUmn2vJYDpD/YBiFLfOhokUDaI=
X-Google-Smtp-Source: AGHT+IHocjbJl+xR8mMLXKtkqWJu/nhVxybtwo7TBdSkwNgtnoPBjFJ6RTaIl5x14FjrIbULLsROeg==
X-Received: by 2002:a17:903:124c:b0:1d7:eb1:a053 with SMTP id u12-20020a170903124c00b001d70eb1a053mr104655plh.18.1706205269113;
        Thu, 25 Jan 2024 09:54:29 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id u24-20020a170902a61800b001d74343a53dsm7538299plq.81.2024.01.25.09.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:54:28 -0800 (PST)
Date: Thu, 25 Jan 2024 09:54:24 -0800
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
Message-ID: <ZbKgUNR+Em55Moaw@debug.ba.rivosinc.com>
References: <20240125062739.1339782-1-debug@rivosinc.com>
 <20240125062739.1339782-3-debug@rivosinc.com>
 <23d023c0-27cf-44fa-be0a-000d1534ef86@app.fastmail.com>
 <ZbKVutBWoelt33GM@debug.ba.rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <ZbKVutBWoelt33GM@debug.ba.rivosinc.com>

On Thu, Jan 25, 2024 at 09:09:14AM -0800, Deepak Gupta wrote:
>On Thu, Jan 25, 2024 at 02:19:29AM -0500, Stefan O'Rear wrote:
>>On Thu, Jan 25, 2024, at 1:21 AM, debug@rivosinc.com wrote:
>>>From: Deepak Gupta <debug@rivosinc.com>
>>>
>>>envcfg CSR defines enabling bits for cache management instructions and soon
>>>will control enabling for control flow integrity and pointer masking features.
>>>
>>>Control flow integrity enabling for forward cfi and backward cfi is controlled
>>>via envcfg and thus need to be enabled on per thread basis.
>>>
>>>This patch creates a place holder for envcfg CSR in `thread_info` and adds
>>>logic to save and restore on trap entry and exits.
>>
>>Should only be "restore"?  I don't see saving.
>
>It's always saved in `thread_info` and user mode can't change it.
>So no point saving it.

Also I'll fix the commit message. I think that's what you were pointing out.

>
>>
>>>
>>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>>---
>>> arch/riscv/include/asm/thread_info.h | 1 +
>>> arch/riscv/kernel/asm-offsets.c      | 1 +
>>> arch/riscv/kernel/entry.S            | 4 ++++
>>> 3 files changed, 6 insertions(+)
>>>
>>>diff --git a/arch/riscv/include/asm/thread_info.h
>>>b/arch/riscv/include/asm/thread_info.h
>>>index 574779900bfb..320bc899a63b 100644
>>>--- a/arch/riscv/include/asm/thread_info.h
>>>+++ b/arch/riscv/include/asm/thread_info.h
>>>@@ -57,6 +57,7 @@ struct thread_info {
>>> 	long			user_sp;	/* User stack pointer */
>>> 	int			cpu;
>>> 	unsigned long		syscall_work;	/* SYSCALL_WORK_ flags */
>>>+	unsigned long envcfg;
>>> #ifdef CONFIG_SHADOW_CALL_STACK
>>> 	void			*scs_base;
>>> 	void			*scs_sp;
>>>diff --git a/arch/riscv/kernel/asm-offsets.c
>>>b/arch/riscv/kernel/asm-offsets.c
>>>index a03129f40c46..cdd8f095c30c 100644
>>>--- a/arch/riscv/kernel/asm-offsets.c
>>>+++ b/arch/riscv/kernel/asm-offsets.c
>>>@@ -39,6 +39,7 @@ void asm_offsets(void)
>>> 	OFFSET(TASK_TI_PREEMPT_COUNT, task_struct, thread_info.preempt_count);
>>> 	OFFSET(TASK_TI_KERNEL_SP, task_struct, thread_info.kernel_sp);
>>> 	OFFSET(TASK_TI_USER_SP, task_struct, thread_info.user_sp);
>>>+	OFFSET(TASK_TI_ENVCFG, task_struct, thread_info.envcfg);
>>> #ifdef CONFIG_SHADOW_CALL_STACK
>>> 	OFFSET(TASK_TI_SCS_SP, task_struct, thread_info.scs_sp);
>>> #endif
>>>diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
>>>index 54ca4564a926..63c3855ba80d 100644
>>>--- a/arch/riscv/kernel/entry.S
>>>+++ b/arch/riscv/kernel/entry.S
>>>@@ -129,6 +129,10 @@ SYM_CODE_START_NOALIGN(ret_from_exception)
>>> 	addi s0, sp, PT_SIZE_ON_STACK
>>> 	REG_S s0, TASK_TI_KERNEL_SP(tp)
>>>
>>>+	/* restore envcfg bits for current thread */
>>>+	REG_L s0, TASK_TI_ENVCFG(tp)
>>>+	csrw CSR_ENVCFG, s0
>>>+
>>
>>This is redundant if we're repeatedly processing interrupts or exceptions
>>within a single task.  We should only be writing envcfg when switching
>>between tasks or as part of the prctl.
>>
>>We need to use an ALTERNATIVE for this since the oldest supported hardware
>>does not have envcfg csrs.
>
>Yeah fixing that in next series. Thanks
>
>>
>>-s
>>
>>> 	/* Save the kernel shadow call stack pointer */
>>> 	scs_save_current
>>>
>>>--
>>>2.43.0
>>>
>>>
>>>_______________________________________________
>>>linux-riscv mailing list
>>>linux-riscv@lists.infradead.org
>>>http://lists.infradead.org/mailman/listinfo/linux-riscv

