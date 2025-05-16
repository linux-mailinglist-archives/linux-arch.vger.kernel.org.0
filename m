Return-Path: <linux-arch+bounces-11975-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94461AB9FB2
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 17:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8641D1892486
	for <lists+linux-arch@lfdr.de>; Fri, 16 May 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE21B4138;
	Fri, 16 May 2025 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="GQfsSeGy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2651A9B3F
	for <linux-arch@vger.kernel.org>; Fri, 16 May 2025 15:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747408578; cv=none; b=rRdoR/zIHsSiD48NhbRwtZb3GNNgpD+/Z6Fr90EELdp9vT14NCApj6RPh/5UaD7L6DdUwLlpdTeMwLQXs6vAKfQptwdyNccnOSf6i19AJdOUp52zHQyoabyCtWChbkTI605Hx8MFn4j+LzqMIW1PMqmVbrmef+2j/JYInMh+0no=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747408578; c=relaxed/simple;
	bh=t+2Gst9xAi5hlIwYx/cxza1UHimWoYdHPusTdQrrccY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr8C6i9sO7TFpspITT6FyXLYhBUeEtTfbdGtbr5QCiV4+Hg30Yc50eSVO46A7IpHDvkZnF+grWEyY+Au/LW9ovHHSZ07Opv24gGZPKI2exPMh6B/dVggwknBQsCxANdSYtKIIcpG6ta+AWiHeG7nIi06biBArvr7cBIbMeoXV7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=GQfsSeGy; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2301ac32320so25842775ad.1
        for <linux-arch@vger.kernel.org>; Fri, 16 May 2025 08:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747408574; x=1748013374; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0GNirFBXfZksDmcLkIx7giCST3II4UpjpZdHFvaex5s=;
        b=GQfsSeGyAB7JAoCVcMbV98hs3mI84XNwIJHFtrgZ90GXZKudh64JoDvi+O3SUidgzX
         wiBkIPz47Q97T6sfusCfCzh0Dk5lLz3omyUJigHsvb/MvSSSToZxSPeDs55kTmN+Dje6
         Ki0sQL/oLrJp6rWPCpfIOTDzB9OS/ZWkGpE4op+b3+LdLJw9FuUA61krpV1YlMV3tJPq
         sjiDQ/w1EIWBYEb6Q1/yCANfG3KI4kwTvTy0TolvE/EhUPFv+EAYz+RSaAjDs5FwXb24
         QgtLTuDiBW3kzQCZJyeDIGKyfXtcikj3A4LntFRTfkmy/zOIk4iF1Nso18z8PWPcJ3sj
         3wIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747408574; x=1748013374;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0GNirFBXfZksDmcLkIx7giCST3II4UpjpZdHFvaex5s=;
        b=e2RidavMRsjH/kl2S7jEmbXAfFC/kwDgHYS8AbwEOzPhYHKk6Gv0Fz1F1EWRm/m9X0
         V9C/A89ogGgMA/Qcc/BJKgtK1T+pLdpmdpBRmKHJFxnX6IQE7skhCgpllsv61tuRpNYD
         RhjiYEiPEdAWnlqfrB8cfq4z9+DqyzgAaR1B8uBxRgh2JOEUwogrWin04s+rSw1yQJ1l
         jIxeTixNAfhj01IQ9aASeaet+hm55aKvMoY5WLStTwqWYDhC+6CyJVUb+zw6qqPgnvct
         PJAxAkLM+N0x8D6l4EL5hmPqmAFuKfpefAntVBi/8eoDL4oAiPX5QyLCXX2fVRKW4IZu
         hwew==
X-Forwarded-Encrypted: i=1; AJvYcCXua7DSnHmDD+XRVpWGoGKDK/ZV9VV6ZAZGhytIXjIhmmTr1/ms3rTl5nP9XsL5K9aPKsFaLq+0Gb3z@vger.kernel.org
X-Gm-Message-State: AOJu0Yw02S4h6ICP+BTZrktRp5yztddSvSY0dwXXRGM/XqBjPyB5LClF
	koIo9AYvW7zkFRkajD8V5F94Ul4gZ6YPoMzg3e0vBEctuF0a9qfLDHUlD+B15vQsAhM=
X-Gm-Gg: ASbGncvZBhn0eZ2S97MD55aPQN0IYbgE1Llxn885yBZdyj6KxRQR7a8hiLyWGq/9+kF
	MUCFxr6ZEgGsMskWVmv1hevNvzIS89d7poJMhigrD0WZBcKmRePZ5nJLNGANmU1r18gxhVDklCC
	zTQ82sFDJgcm7LZjW3cuRlNgz1tOndO3ZGJ67Wz+tQuTEdZgIvwy6bHMNmxY+jMOfMaeZ8clN/2
	lCW+pvX+mwpI4FjqJuucZPvps1+9dJfZQc58Tf1DhIKOuDS0Mt9xxr0yOknn6Anjh/26FKj7Qcm
	1TWX8ryEIjcvyJFbBV2NNJXlS6KPCxl9dWlv6PxxBqmeAaBuMEbDRD8V7mWLUw==
X-Google-Smtp-Source: AGHT+IHSSRQv6UaVUp1uY7YxcQ7Fp0Nkh/iVwU/C9R2BEes+S1JYlxj3SIRdl94BDLGOoJJBYixrLQ==
X-Received: by 2002:a17:903:faf:b0:224:c46:d167 with SMTP id d9443c01a7336-231d44e7049mr42573705ad.16.1747408573939;
        Fri, 16 May 2025 08:16:13 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4ebb0d4sm15446025ad.195.2025.05.16.08.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 08:16:13 -0700 (PDT)
Date: Fri, 16 May 2025 08:16:09 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Alexandre Ghiti <alex@ghiti.fr>
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
	Jann Horn <jannh@google.com>, Conor Dooley <conor+dt@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-riscv@lists.infradead.org,
	devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	alistair.francis@wdc.com, richard.henderson@linaro.org,
	jim.shu@sifive.com, andybnac@gmail.com, kito.cheng@sifive.com,
	charlie@rivosinc.com, atishp@rivosinc.com, evan@rivosinc.com,
	cleger@rivosinc.com, alexghiti@rivosinc.com,
	samitolvanen@google.com, broonie@kernel.org,
	rick.p.edgecombe@intel.com, rust-for-linux@vger.kernel.org,
	Zong Li <zong.li@sifive.com>
Subject: Re: [PATCH v15 22/27] riscv: enable kernel access to shadow stack
 memory via FWFT sbi call
Message-ID: <aCdWueNaGeru4CRW@debug.ba.rivosinc.com>
References: <20250502-v5_user_cfi_series-v15-0-914966471885@rivosinc.com>
 <20250502-v5_user_cfi_series-v15-22-914966471885@rivosinc.com>
 <c911eead-30c4-497d-8a56-1450792b24bd@ghiti.fr>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c911eead-30c4-497d-8a56-1450792b24bd@ghiti.fr>

On Thu, May 15, 2025 at 09:10:08AM +0200, Alexandre Ghiti wrote:
>Hi Deepak,
>
>On 03/05/2025 01:30, Deepak Gupta wrote:
>>Kernel will have to perform shadow stack operations on user shadow stack.
>>Like during signal delivery and sigreturn, shadow stack token must be
>>created and validated respectively. Thus shadow stack access for kernel
>>must be enabled.
>>
>>In future when kernel shadow stacks are enabled for linux kernel, it must
>>be enabled as early as possible for better coverage and prevent imbalance
>>between regular stack and shadow stack. After `relocate_enable_mmu` has
>>been done, this is as early as possible it can enabled.
>>
>>Reviewed-by: Zong Li <zong.li@sifive.com>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  arch/riscv/kernel/asm-offsets.c |  4 ++++
>>  arch/riscv/kernel/head.S        | 27 +++++++++++++++++++++++++++
>>  2 files changed, 31 insertions(+)
>>
>>diff --git a/arch/riscv/kernel/asm-offsets.c b/arch/riscv/kernel/asm-offsets.c
>>index f33945432f8f..7ab41f01aa17 100644
>>--- a/arch/riscv/kernel/asm-offsets.c
>>+++ b/arch/riscv/kernel/asm-offsets.c
>>@@ -514,4 +514,8 @@ void asm_offsets(void)
>>  	DEFINE(FREGS_A6,	    offsetof(struct __arch_ftrace_regs, a6));
>>  	DEFINE(FREGS_A7,	    offsetof(struct __arch_ftrace_regs, a7));
>>  #endif
>>+	DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>>+	DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>>+	DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>>+	DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>
>
>kernel test robot reported errors when !RV64 and !SBI, the following 
>diff fixes it:
>
>diff --git a/arch/riscv/kernel/asm-offsets.c 
>b/arch/riscv/kernel/asm-offsets.c
>index 7fc085d27ca79..3aa5f56a84e9a 100644
>--- a/arch/riscv/kernel/asm-offsets.c
>+++ b/arch/riscv/kernel/asm-offsets.c
>@@ -532,8 +532,10 @@ void asm_offsets(void)
>        DEFINE(FREGS_A6,            offsetof(struct 
>__arch_ftrace_regs, a6));
>        DEFINE(FREGS_A7,            offsetof(struct 
>__arch_ftrace_regs, a7));
> #endif
>+#ifdef CONFIG_RISCV_SBI
>        DEFINE(SBI_EXT_FWFT, SBI_EXT_FWFT);
>        DEFINE(SBI_EXT_FWFT_SET, SBI_EXT_FWFT_SET);
>        DEFINE(SBI_FWFT_SHADOW_STACK, SBI_FWFT_SHADOW_STACK);
>        DEFINE(SBI_FWFT_SET_FLAG_LOCK, SBI_FWFT_SET_FLAG_LOCK);
>+#endif
> }
>
>No need to resend the whole series, I'll squash it.

Thanks.
>
>Thanks,
>
>Alex
>
>
>>  }
>>diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
>>index 356d5397b2a2..7eae9a172351 100644
>>--- a/arch/riscv/kernel/head.S
>>+++ b/arch/riscv/kernel/head.S
>>@@ -15,6 +15,7 @@
>>  #include <asm/image.h>
>>  #include <asm/scs.h>
>>  #include <asm/xip_fixup.h>
>>+#include <asm/usercfi.h>
>>  #include "efi-header.S"
>>  __HEAD
>>@@ -164,6 +165,19 @@ secondary_start_sbi:
>>  	call relocate_enable_mmu
>>  #endif
>>  	call .Lsetup_trap_vector
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_SHADOW_STACK
>>+	li a1, 1 /* enable supervisor to access shadow stack access */
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall
>>+	beqz a0, 1f
>>+	la a1, riscv_nousercfi
>>+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
>>+	REG_S a0, (a1)
>>+1:
>>+#endif
>>  	scs_load_current
>>  	call smp_callin
>>  #endif /* CONFIG_SMP */
>>@@ -320,6 +334,19 @@ SYM_CODE_START(_start_kernel)
>>  	la tp, init_task
>>  	la sp, init_thread_union + THREAD_SIZE
>>  	addi sp, sp, -PT_SIZE_ON_STACK
>>+#if defined(CONFIG_RISCV_SBI) && defined(CONFIG_RISCV_USER_CFI)
>>+	li a7, SBI_EXT_FWFT
>>+	li a6, SBI_EXT_FWFT_SET
>>+	li a0, SBI_FWFT_SHADOW_STACK
>>+	li a1, 1 /* enable supervisor to access shadow stack access */
>>+	li a2, SBI_FWFT_SET_FLAG_LOCK
>>+	ecall
>>+	beqz a0, 1f
>>+	la a1, riscv_nousercfi
>>+	li a0, CMDLINE_DISABLE_RISCV_USERCFI_BCFI
>>+	REG_S a0, (a1)
>>+1:
>>+#endif
>>  	scs_load_current
>>  #ifdef CONFIG_KASAN
>>

