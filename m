Return-Path: <linux-arch+bounces-9079-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528FD9C7FB3
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 02:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C5628362D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 01:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0782B1C3F3B;
	Thu, 14 Nov 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="nBgRs0+A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 344671BFE00
	for <linux-arch@vger.kernel.org>; Thu, 14 Nov 2024 01:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546417; cv=none; b=eYB/lk3aemGJVMhYVdLJ4dPxd2QLR+rTsGyQUxlJO9u1LVdmuC3OK6d6JXJDCGG2E90OfxZ+RwCweqilBZhVZ1RtEvRRdxTmV+IJuS36ZP2qEiAxWPTln4ZiXJPHCxnzf7l3l7XTwkb7qpPTeV5tRsdsM0FeNU2DWSQ9jDzTTlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546417; c=relaxed/simple;
	bh=qBuDfnrWjJVjq7psCPaKKe9MZ9ehfUXbn+HJ87+O3ng=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=owmouBNBFAASTzVb9spDZEo9dA9C2wEtLcCnCpjb0eUoYJ4lx6KOxDERCQCDXYX9XNGpb9z+UonaZ8UplTbfZXkg72HVMar8tdikHB4nPhZmUZ6NpjrOMtKtK2lEgLe7+tLg+sNGbyl6OVM1p668QgPS10Ak8uiJMEGgTuris9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=nBgRs0+A; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7242f559a9fso33075b3a.1
        for <linux-arch@vger.kernel.org>; Wed, 13 Nov 2024 17:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1731546414; x=1732151214; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V6zYfn0VZRfW6uGvMs5S79Lwbgkv1rCFmk8b72kjuag=;
        b=nBgRs0+Av2U3Z2uwG1tLbt4cFvuXdSuWpoYnAUtB0yqa53YznjHiKLDJAW3bQdEgtL
         r8e/7g8R+rv7bKKhvcLHrRyyUSSqyWL7EksujX7DB2tI7NV6tmSPAXmozqaXfgCKyl3s
         RO0Lhr7OtT9yEbcD7R44FZLuYunb8hMrQkMZKQfTCQ847jxVxietCO6l95NlyZK7Spwe
         zxeAWGExHnUt9OnLTyKGpj133H9F/X7HTSPOU+hgH4OShDmmKe/rs7KjXbtJeXiMzcgJ
         xQK0uKDOK4suL7f1bFVRH6EkNhzlbwH+IWj4jZYIP4ozHvnKHL2kyYS6sDFip9D9ecIe
         W0yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731546414; x=1732151214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V6zYfn0VZRfW6uGvMs5S79Lwbgkv1rCFmk8b72kjuag=;
        b=e+8onySaTqH1Ck9ukqT4NuMmA9OWOk1Sot56fLxDWeTnOiw/dpEbgivPzaN7vEI9mF
         fvmxRZDYjIPDO2J58o1jQrzykSmHco5eNAK1zhHMWudyopPt0Z2MI1cG0F9soGS7hgU/
         5amo/GIFrHV/t9GxhFIabq6Oa0uQBTV8lQAO4FCdeTZ0/8LJPtoplKbdzYpWmMedxCNu
         Zx2u9aXnPVXiHwBVIgQkrolNoqWpsRrN5hIazCX+RjkV1vpMEo7M6DM7AuuwxUajkz9w
         SP9poVsmus4hhOzoQN7p1ezP6gv2C+tPgB7ZQuaIc34JfcAiUShMHpiZyRFHsLzYgSKi
         XYEw==
X-Forwarded-Encrypted: i=1; AJvYcCXhBY7+iRWOf3HstJfn47lKjhtbECeZ/FqMfxW5XvnyJvYolYdpuJlC0BTpCtk6O3fEyFtPhQ/Zmxu1@vger.kernel.org
X-Gm-Message-State: AOJu0Yw19HUNAadE9F0eJecPQMLOCLaOSC1p3Ee6FkXFZSEmrPfPkORN
	omht6zoJgV8Hfu5Ui7yUj3TiKfiDH8DhQVUIDbfEpMi08UWla6kuE1wF7RQSPw1BC1JzBPKJ1Qd
	d
X-Google-Smtp-Source: AGHT+IHKuTOxiGEAgkHaDhIBBJNYiWEQLb5FEseKdlvV0/9ks9/baTVKfCi8JKR7Lgz6EKvk8XnoGA==
X-Received: by 2002:a05:6a00:23c4:b0:724:603f:1f9c with SMTP id d2e1a72fcca58-724603f20abmr3387327b3a.16.1731546414360;
        Wed, 13 Nov 2024 17:06:54 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7246a6e9cddsm58312b3a.74.2024.11.13.17.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 17:06:53 -0800 (PST)
Date: Wed, 13 Nov 2024 17:06:50 -0800
From: Deepak Gupta <debug@rivosinc.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: Re: [PATCH v8 24/29] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <ZzVNKvCu4MOs7O5z@debug.ba.rivosinc.com>
References: <20241111-v5_user_cfi_series-v8-0-dce14aa30207@rivosinc.com>
 <20241111-v5_user_cfi_series-v8-24-dce14aa30207@rivosinc.com>
 <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKddAkCCVjNHUinPWtOiK8Ki_ZkdoUCawfv1-+0B69J_1aJv5Q@mail.gmail.com>

On Thu, Nov 14, 2024 at 12:13:38AM +0800, Nick Hu wrote:
>Hi Deepak
>
>On Tue, Nov 12, 2024 at 5:08 AM Deepak Gupta <debug@rivosinc.com> wrote:
>>
>> Kernel will have to perform shadow stack operations on user shadow stack.
>> Like during signal delivery and sigreturn, shadow stack token must be
>> created and validated respectively. Thus shadow stack access for kernel
>> must be enabled.
>>
>> In future when kernel shadow stacks are enabled for linux kernel, it must
>> be enabled as early as possible for better coverage and prevent imbalance
>> between regular stack and shadow stack. After `relocate_enable_mmu` has
>> been done, this is as early as possible it can enabled.
>>
>> Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>> ---
>>  arch/riscv/kernel/asm-offsets.c |  4 ++++
>>  arch/riscv/kernel/head.S        | 12 ++++++++++++
>>  2 files changed, 16 insertions(+)
>>
>> diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>> index 766bd33f10cb..a22ab8a41672 100644
>> --- a/arch/riscv/kernel/asm-offsets.c
>> +++ b/arch/riscv/kernel/asm-offsets.c
>> @@ -517,4 +517,8 @@ void asm_offsets(void)
>>         DEFINE(FREGS_A6,            offsetof(struct ftrace_regs, a6));
>>         DEFINE(FREGS_A7,            offsetof(struct ftrace_regs, a7));
>>  #endif
>> +       DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>> +       DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>> +       DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>> +       DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>>  }
>> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>> index 356d5397b2a2..6244408ca917 100644
>> --- a/arch/riscv/kernel/head.S
>> +++ b/arch/riscv/kernel/head.S
>> @@ -164,6 +164,12 @@ secondary_start_sbi:
>>         call relocate_enable_mmu
>>  #endif
>>         call .Lsetup_trap_vector
>> +       li a7, SBI_EXT_FWFT
>> +       li a6, SBI_EXT_FWFT_SET
>> +       li a0, SBI_FWFT_SHADOW_STACK
>> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> +       ecall
>>         scs_load_current
>>         call smp_callin
>>  #endif /* CONFIG_SMP */
>> @@ -320,6 +326,12 @@ SYM_CODE_START(_start_kernel)
>>         la tp, init_task
>>         la sp, init_thread_union + THREAD_SIZE
>>         addi sp, sp, -PT_SIZE_ON_STACK
>> +       li a7, SBI_EXT_FWFT
>> +       li a6, SBI_EXT_FWFT_SET
>> +       li a0, SBI_FWFT_SHADOW_STACK
>> +       li a1, 1 /* enable supervisor to access shadow stack access */
>> +       li a2, SBI_FWFT_SET_FLAG_LOCK
>> +       ecall
>>         scs_load_current
>>
>>  #ifdef CONFIG_KASAN
>>
>> --
>> 2.45.0
>>
>Should we clear the SBI_FWFT_SET_FLAG_LOCK before the cpu hotplug
>otherwise the menvcfg.sse won't be set by the fwft set sbi call when
>the hotplug cpu back to kernel?

Hmm...

An incoming hotplug CPU has no features setup on it.
I see that `sbi_cpu_start` will supply `secondary_start_sbi` as start
up code for incoming CPU. `secondary_start_sbi` is in head.S which converges
in `.Lsecondary_start_common`. And thus hotplugged CPU should be
issuing shadow stack set FWFT sbi as well.

Am I missing something ?

>
>Regards,
>Nick
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv

