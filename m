Return-Path: <linux-arch+bounces-12115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19DD0AC1CB8
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 08:01:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA721175A8B
	for <lists+linux-arch@lfdr.de>; Fri, 23 May 2025 06:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B27223327;
	Fri, 23 May 2025 06:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="p8pfEUne"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FD07DA8C
	for <linux-arch@vger.kernel.org>; Fri, 23 May 2025 06:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747980068; cv=none; b=OLeF60tbaYpx7orITJafBuyuq0EIeVg9DJI79+piL3VuTpzIdUPQM62VkqDe0nsVHCnAOIiIsIkV9ZnrJODKaDRc8fZd4XBhf1Ym43WX0cxgFcsoWwJpETGr69UzyP59POftKKgInEml+7Ltk+P1bN2ODsDLJqMcnNH0kXfU6CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747980068; c=relaxed/simple;
	bh=VEwefDlpzyTDgxySnKoI464DIi5+w8elqlGS6qhyW3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZeMSc3o0Cn7i7AtHAAGPsJy5oedfgsp6Ntui//F+H6FuTJlcg7/3Qrh5DN0vyFeN4Vnl94yYSh004uW5ZBrwQWcrS+W6QNADiq1w9Ngq3jsytQv/f0T/pNtlzXBw4V7OxhNmapZCZj3kascg7DHDCD+IhFVRywN9ySyiZIDqVxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=p8pfEUne; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-231bf5851b7so68888995ad.0
        for <linux-arch@vger.kernel.org>; Thu, 22 May 2025 23:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1747980065; x=1748584865; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MM8qECzGuabOnUf85/QEm4aqRBTZg6DD4xWO9Ub0wak=;
        b=p8pfEUnebpPG3gKUUyouwKQN/uoJGRPGY+sYOGClWTky3UHrYzw5oVa4u5rRzPldmq
         NLv1a+L2FwZzzkYjmPXZzp1kIgQ0LMeaOiJanoIrcVI57a2N724o4Wf8Ex1aJ4jvHeMP
         p9mWXs1jHUZgf7GK5Ll/PA6+m9B3pLsDqtnqBmNMpWrfaAdXYVBOM4hazmiOVTR46ypk
         m2xfbDY9+tAv1muEL0XbEfjLnkSYLxZdMYfMyczhjhufzGymW+Cjez+ltj4GYCh2IcMe
         UT2vZ3Dq/NDjA2fs4rqKnsC6X/Q3E2zA0AeBdep2fLiG7MXJBAnhtstkNlZ2uWHk1y+6
         lMyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747980065; x=1748584865;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM8qECzGuabOnUf85/QEm4aqRBTZg6DD4xWO9Ub0wak=;
        b=xO484GR+P99fJWAvLIxXud3Inl6ydY5NWIpzWw0JizyM3zRJeVnJDUFS7e9D6JQ6gx
         yf+C2j7vBwGnBQ/Rn9xmDhBjtwPyVGaTMsQjawtbyK6Ib03k4Xf9pEHKbl7mr9HY28G0
         DQSeJ3w5DTYAmRDnmWur+e43Mg0Gt9eK/Y56F+EAWO99V7beSr7VLkJqeMhExDWBO1vG
         W2QRGo9YRb5pan7vAxlSmmeyvuP0vVBuH0uvu/uStVeFSa5qPjHutq7DpEkh11KtrTgH
         OylREjpChPLrqV4GAATK/vFv8qYoh4Zer5nKMoEeHREkOqyl2a4zpH73QZJaTKly3TFr
         ARJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVOV3Be6qs9DRSzSy+wocHS6YRbN/Fic+tijvAk8zlRMoqmBXdEnh9o2ZhTO3vxyovdkA++zikkMQlC@vger.kernel.org
X-Gm-Message-State: AOJu0YxPSD6lmdn0fJ84HXE9Dia+zTTKIBMpXw7R1rjlN0/XIVefeLU2
	rY4pRdVGVHbRcwTimoTHLP1yTXszcPfaJi8qvpbC8ABOdxiwt1+WnC+0Gq5iJSqlrz0=
X-Gm-Gg: ASbGncufxdRyjmeoWjnbuPL1P+hu4nPQ95gMRwmb7nh9bTq7jootfz+NGbpYr2MBgf6
	ffw6fXfz7ben34pTWQZI/bF+dq7DL1w6aKwKiW49caUag50WcK3QbrVq9jssxFMmfbdcNciTKc6
	UtN3HxBc985PLf5NtoHpjL9rQ8YkXpHybIquhAXr720r64+6rtZC5DX/yOkoXCQx9PcDIBRxglh
	YXLFfLxqB8d74jWVx1R2i5KInmc8WPg3sz+GOqrTkec+nz8Bxjalrm+q8wRfF9cONBbucpqyITL
	Lw613zWTf+rg6xCyH133jbv4IMtZvCtW0ai+DgbkIX4c6oTx7/vPzJ+SPQLrpA==
X-Google-Smtp-Source: AGHT+IH2GKe/Xm4Ppo32AJJr6pQEKHz5ShbLWceyV6lc/d0LTWPehEZJe6GO4uOPRwS1AloDMoJLOw==
X-Received: by 2002:a17:902:d4c1:b0:223:54aa:6d15 with SMTP id d9443c01a7336-233f21ccb31mr27879805ad.12.1747980064763;
        Thu, 22 May 2025 23:01:04 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f7a32sm6495296a91.49.2025.05.22.23.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 May 2025 23:01:04 -0700 (PDT)
Date: Thu, 22 May 2025 23:01:00 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
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
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
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
Subject: Re: [PATCH v16 23/27] arch/riscv: compile vdso with landing pad
Message-ID: <aDAPHHN0yRgmqSOI@debug.ba.rivosinc.com>
References: <20250522-v5_user_cfi_series-v16-0-64f61a35eee7@rivosinc.com>
 <20250522-v5_user_cfi_series-v16-23-64f61a35eee7@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250522-v5_user_cfi_series-v16-23-64f61a35eee7@rivosinc.com>

On the topic of vDSO generation, I wanted to have a discussion thread. So
I'll use this patch and create a discussion thread.

Binaries in address space can call into vDSO and thus in order to have
homogenous cfi policies, vDSO is also compiled with cfi extensions enabled.
Thus it has shadow stack and landing pad instructions in it. Shadow stack
instructions encodings are from zimop/zcmop encodings while landing pad is
from HINT space of `auipc x0, imm`. Thus landing pad is truly backward
compatible with existing and future hardware both.

zimop/zcmop encodings are illegal instruction on existing hardware and any
future hardware that will not implement zimop/zcmop encodings. RVA23 profile
mandates zimop/zcmop encodings and thus any RVA23 compatible hardware should
be compatible with libraries (including vDSOs) with zimop/zcmop instructions
in them.

Kernel which is built doesn't know upfront which hardware it is going to run
on. It can be placed on top of a existing hardware, RVA23 compatible hardware
or any future hardware which is not RVA23 compatible but has not implemented
zimop/zcmop extensions. Question is should kernel be building two different
vDSOs (one with cfi/shadow stack instructions compiled and another without
cfi instructions inthem) and expose the one depending on underlying CPU
supports zimop/zcmop or not.

My initial hunch was to go with two different vDSOs in kernel and expose only
one depending on whether zimop/zcmop is implemented by platform or not.

However as ziciflp and zicfiss toolchain support is trickling into gnu-
toolchain, shadow stack instructions are part of libgcc and all small object
files that gets generated as part of toolchain creation (and eventually libc
too). So eventually anyone running on a hardware without zimop/zcmop must be
first building toolchain from scratch in order to build userspace rootfs and
later packages. This sounds like a significant chunk of work and at that point
they might as well just build kernel without `CONFIG_RISCV_USER_CFI` and should
get vDSO without any cfi instructions in them.

Thus I did not decide to provide multi-vDSO support in kernel considering it a
futile exercise. I wanted to put my thought process here so that there is some
discussion on this.

On Thu, May 22, 2025 at 10:31:26PM -0700, Deepak Gupta wrote:
>From: Jim Shu <jim.shu@sifive.com>
>
>user mode tasks compiled with zicfilp may call indirectly into vdso (like
>hwprobe indirect calls). Add landing pad compile support in vdso. vdso
>with landing pad in it will be nop for tasks which have not enabled
>landing pad.
>This patch allows to run user mode tasks with cfi eanbled and do no harm.
>
>Future work can be done on this to do below
> - labeled landing pad on vdso functions (whenever labeling support shows
>   up in gnu-toolchain)
> - emit shadow stack instructions only in vdso compiled objects as part of
>   kernel compile.
>
>Signed-off-by: Jim Shu <jim.shu@sifive.com>
>Reviewed-by: Zong Li <zong.li@sifive.com>
>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>---
> arch/riscv/Makefile                   |  5 +++-
> arch/riscv/include/asm/assembler.h    | 44 +++++++++++++++++++++++++++++++++++
> arch/riscv/kernel/vdso/Makefile       |  6 +++++
> arch/riscv/kernel/vdso/flush_icache.S |  4 ++++
> arch/riscv/kernel/vdso/getcpu.S       |  4 ++++
> arch/riscv/kernel/vdso/rt_sigreturn.S |  4 ++++
> arch/riscv/kernel/vdso/sys_hwprobe.S  |  4 ++++
> 7 files changed, 70 insertions(+), 1 deletion(-)
>
>diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
>index 539d2aef5cab..c2dd09bb9db3 100644
>--- a/arch/riscv/Makefile
>+++ b/arch/riscv/Makefile
>@@ -88,9 +88,12 @@ riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZACAS) := $(riscv-march-y)_zacas
> # Check if the toolchain supports Zabha
> riscv-march-$(CONFIG_TOOLCHAIN_HAS_ZABHA) := $(riscv-march-y)_zabha
>
>+KBUILD_BASE_ISA = -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
>+export KBUILD_BASE_ISA
>+
> # Remove F,D,V from isa string for all. Keep extensions between "fd" and "v" by
> # matching non-v and non-multi-letter extensions out with the filter ([^v_]*)
>-KBUILD_CFLAGS += -march=$(shell echo $(riscv-march-y) | sed -E 's/(rv32ima|rv64ima)fd([^v_]*)v?/\1\2/')
>+KBUILD_CFLAGS += $(KBUILD_BASE_ISA)
>
> KBUILD_AFLAGS += -march=$(riscv-march-y)
>
>diff --git a/arch/riscv/include/asm/assembler.h b/arch/riscv/include/asm/assembler.h
>index 44b1457d3e95..a058ea5e9c58 100644
>--- a/arch/riscv/include/asm/assembler.h
>+++ b/arch/riscv/include/asm/assembler.h
>@@ -80,3 +80,47 @@
> 	.endm
>
> #endif	/* __ASM_ASSEMBLER_H */
>+
>+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
>+.macro vdso_lpad
>+lpad 0
>+.endm
>+#else
>+.macro vdso_lpad
>+.endm
>+#endif
>+
>+/*
>+ * This macro emits a program property note section identifying
>+ * architecture features which require special handling, mainly for
>+ * use in assembly files included in the VDSO.
>+ */
>+#define NT_GNU_PROPERTY_TYPE_0  5
>+#define GNU_PROPERTY_RISCV_FEATURE_1_AND 0xc0000000
>+
>+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP      (1U << 0)
>+#define GNU_PROPERTY_RISCV_FEATURE_1_ZICFISS      (1U << 1)
>+
>+#if defined(CONFIG_RISCV_USER_CFI) && (__riscv_xlen == 64)
>+#define GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT \
>+	(GNU_PROPERTY_RISCV_FEATURE_1_ZICFILP)
>+#endif
>+
>+#ifdef GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
>+.macro emit_riscv_feature_1_and, feat = GNU_PROPERTY_RISCV_FEATURE_1_DEFAULT
>+	.pushsection .note.gnu.property, "a"
>+	.p2align        3
>+	.word           4
>+	.word           16
>+	.word           NT_GNU_PROPERTY_TYPE_0
>+	.asciz          "GNU"
>+	.word           GNU_PROPERTY_RISCV_FEATURE_1_AND
>+	.word           4
>+	.word           \feat
>+	.word           0
>+	.popsection
>+.endm
>+#else
>+.macro emit_riscv_feature_1_and, feat = 0
>+.endm
>+#endif
>diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
>index ad73607abc28..441c5431d27e 100644
>--- a/arch/riscv/kernel/vdso/Makefile
>+++ b/arch/riscv/kernel/vdso/Makefile
>@@ -13,12 +13,18 @@ vdso-syms += flush_icache
> vdso-syms += hwprobe
> vdso-syms += sys_hwprobe
>
>+ifdef CONFIG_RISCV_USER_CFI
>+LPAD_MARCH = _zicfilp_zicfiss -fcf-protection=full
>+endif
>+
> # Files to link into the vdso
> obj-vdso = $(patsubst %, %.o, $(vdso-syms)) note.o
>
> ccflags-y := -fno-stack-protector
> ccflags-y += -DDISABLE_BRANCH_PROFILING
> ccflags-y += -fno-builtin
>+ccflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
>+asflags-y += $(KBUILD_BASE_ISA)$(LPAD_MARCH)
>
> ifneq ($(c-gettimeofday-y),)
>   CFLAGS_vgettimeofday.o += -fPIC -include $(c-gettimeofday-y)
>diff --git a/arch/riscv/kernel/vdso/flush_icache.S b/arch/riscv/kernel/vdso/flush_icache.S
>index 8f884227e8bc..e4c56970905e 100644
>--- a/arch/riscv/kernel/vdso/flush_icache.S
>+++ b/arch/riscv/kernel/vdso/flush_icache.S
>@@ -5,11 +5,13 @@
>
> #include <linux/linkage.h>
> #include <asm/unistd.h>
>+#include <asm/assembler.h>
>
> 	.text
> /* int __vdso_flush_icache(void *start, void *end, unsigned long flags); */
> SYM_FUNC_START(__vdso_flush_icache)
> 	.cfi_startproc
>+	vdso_lpad
> #ifdef CONFIG_SMP
> 	li a7, __NR_riscv_flush_icache
> 	ecall
>@@ -20,3 +22,5 @@ SYM_FUNC_START(__vdso_flush_icache)
> 	ret
> 	.cfi_endproc
> SYM_FUNC_END(__vdso_flush_icache)
>+
>+emit_riscv_feature_1_and
>diff --git a/arch/riscv/kernel/vdso/getcpu.S b/arch/riscv/kernel/vdso/getcpu.S
>index 9c1bd531907f..5c1ecc4e1465 100644
>--- a/arch/riscv/kernel/vdso/getcpu.S
>+++ b/arch/riscv/kernel/vdso/getcpu.S
>@@ -5,14 +5,18 @@
>
> #include <linux/linkage.h>
> #include <asm/unistd.h>
>+#include <asm/assembler.h>
>
> 	.text
> /* int __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused); */
> SYM_FUNC_START(__vdso_getcpu)
> 	.cfi_startproc
>+	vdso_lpad
> 	/* For now, just do the syscall. */
> 	li a7, __NR_getcpu
> 	ecall
> 	ret
> 	.cfi_endproc
> SYM_FUNC_END(__vdso_getcpu)
>+
>+emit_riscv_feature_1_and
>diff --git a/arch/riscv/kernel/vdso/rt_sigreturn.S b/arch/riscv/kernel/vdso/rt_sigreturn.S
>index 3dc022aa8931..e82987dc3739 100644
>--- a/arch/riscv/kernel/vdso/rt_sigreturn.S
>+++ b/arch/riscv/kernel/vdso/rt_sigreturn.S
>@@ -5,12 +5,16 @@
>
> #include <linux/linkage.h>
> #include <asm/unistd.h>
>+#include <asm/assembler.h>
>
> 	.text
> SYM_FUNC_START(__vdso_rt_sigreturn)
> 	.cfi_startproc
> 	.cfi_signal_frame
>+	vdso_lpad
> 	li a7, __NR_rt_sigreturn
> 	ecall
> 	.cfi_endproc
> SYM_FUNC_END(__vdso_rt_sigreturn)
>+
>+emit_riscv_feature_1_and
>diff --git a/arch/riscv/kernel/vdso/sys_hwprobe.S b/arch/riscv/kernel/vdso/sys_hwprobe.S
>index 77e57f830521..f1694451a60c 100644
>--- a/arch/riscv/kernel/vdso/sys_hwprobe.S
>+++ b/arch/riscv/kernel/vdso/sys_hwprobe.S
>@@ -3,13 +3,17 @@
>
> #include <linux/linkage.h>
> #include <asm/unistd.h>
>+#include <asm/assembler.h>
>
> .text
> SYM_FUNC_START(riscv_hwprobe)
> 	.cfi_startproc
>+	vdso_lpad
> 	li a7, __NR_riscv_hwprobe
> 	ecall
> 	ret
>
> 	.cfi_endproc
> SYM_FUNC_END(riscv_hwprobe)
>+
>+emit_riscv_feature_1_and
>
>-- 
>2.43.0
>

