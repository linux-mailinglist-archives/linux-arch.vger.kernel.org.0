Return-Path: <linux-arch+bounces-1415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A05835DCB
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 10:13:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66CD628882C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 09:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB523A1B6;
	Mon, 22 Jan 2024 09:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GYrGHRpr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E29C3A1AA
	for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705914776; cv=none; b=UFtnO+WZEofEztSL47nNEleJmZHo5jybSuQ7+YKq3fOOcfTO0+0O0y18LSfl9e9rhKfrh3NH/Qbq46gHX3jrZR8SjiI4cVNfYl1fJnqzM4vpZVp6m3JYANh3hs90h5LSwJhpCuAjf/e9KmE7NGK0tihHAWGapqvbbbxBz2EtCr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705914776; c=relaxed/simple;
	bh=WtGP1AHer5Q1wc5J6xuAlLFLTWrN4iBoK96MPonlw1U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Es2elZaDTGlwI6dWW00tE1kLiLGudineCybOpyWRPiRZ7BFWBSl5ck3jA3ESNNCkOMlIT2K+jFgIZHK8ZFFBARq3+gyhUTsmqrBP57vah5ezMvBhkd3+W6PfvO5jezTdMx7E5I1WrtnwlnRJPTJvzmqZHMD62dwr3oXdKOcsLzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GYrGHRpr; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc221fad8c7so4112094276.3
        for <linux-arch@vger.kernel.org>; Mon, 22 Jan 2024 01:12:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705914774; x=1706519574; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ieii7F07e2BhjymXZdDcuN6ywdVvzt+lwy6/7RWUY=;
        b=GYrGHRpru70Fhxxy4VqdIM5MQbC1HdF20WX5HCHqnCI/tUIqzbAd4Khyy2U9uhhu1b
         WVJHpV8fIoPsEA1nEZVl2tkeNFkCtyxWEeRDryV74jEBnITYAr1eH9YnNuRSS59S43zk
         sZ5ePivZYEhvRtzrElRqCIoVT17mMZOLEHB84l8+Y/xtUNIZMKrW1OIbB53rEvxe3nhw
         CiP2iVenVt042QIZYIU0Q4IjVde+a5ceoDhslP+AxIbZJZssR3tf9Saat/z3hv9fX0Mc
         I9JVIeAl9lhm5X0jLJsrVtoxhSWRZQuJ86e8ba1LVlFrcauhTtPOcQI6LlETLea1kHjC
         0idw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705914774; x=1706519574;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V3ieii7F07e2BhjymXZdDcuN6ywdVvzt+lwy6/7RWUY=;
        b=QuBUHZyzbCjkHaimu8987wJ897N9nmBULSFLZTFTmi1lDIJf/PPc2nz70SwU1ETMfo
         lHUf9B5aFqvW62i3UavJeQZEOPfsm3jVHdtZuI73+ubaHVsc4UPx6iVh20xgsclNVt0n
         +2K2zYZ9e86weaqZba8mzoyZKQuICNnM7lDOWCtl5NZkxARI79pwrCBekGGWkliSK0+O
         i0W+M4fmOfgY9FgwKwaxnzNfNB6/fTg1ET/LKGn4qFy/Jn8BYNdXCAQVXk/0FuXIra0+
         qGg7Viw49QpUSnO7TRwafEXZtlswlmutSpQQZEt7TNWu97K9VrELcd/q5DQPqNBpb+16
         8aYQ==
X-Gm-Message-State: AOJu0YysBK1mF8hYAw+tIVm3SUp43uxixpLTxCQdNbAsKy2eLNKj11sc
	+Fj+f6lXupJJWpQ4HbuF84w3CRb0cYxhbnfmLyJmKtxC+9OwMYL35l3fYWofi3dVqr2wHQ==
X-Google-Smtp-Source: AGHT+IFF1NqudMtl1ItqcyY6BXLyvNXoUsI2Du/fPbvE/lmxLMycRC6eE2Fg9I8rYHKTMtJs9zPmI9GF
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:1005:b0:dc2:5525:f6b with SMTP id
 w5-20020a056902100500b00dc255250f6bmr1879931ybt.7.1705914774527; Mon, 22 Jan
 2024 01:12:54 -0800 (PST)
Date: Mon, 22 Jan 2024 10:08:57 +0100
In-Reply-To: <20240122090851.851120-7-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122090851.851120-7-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=4335; i=ardb@kernel.org;
 h=from:subject; bh=NM5aMdSXYlJ+boACvwGHARd4V6ELPnCOafub2dfrC3k=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWdwcq/f7QuR0w79JI76/onzQcqrKlfdTWq06uW7lKdI
 7BeiHlnRykLgxgHg6yYIovA7L/vdp6eKFXrPEsWZg4rE8gQBi5OAZjIViZGhmuyC5eIZNR1xF4U
 +3hyvreGQ1XbpJCYhxeT1FJqs3/c+c3I8P/dL1X2K5ffWd5sXvTUkT/RfkWV3oyZaw7yf/GWsxF 4zwgA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122090851.851120-12-ardb+git@google.com>
Subject: [RFC PATCH 5/5] x86: Build the core kernel with position independent codegen
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Pass the -fpie flag to the compiler when building objects that are
intended for the core kernel. This ensures that all implicit symbol
references are emitted using RIP-relative relocations, allowing the code
to be executed correctly even if it runs from a different virtual
address than the address it was linked/loaded/relocated to run at.

This is necessary to ensure that all C code that gets pulled in by the
early startup code runs correctly without the need for unpalatable hacks
in the code to force RIP-relative references.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/Makefile                 | 7 +++++--
 arch/x86/entry/vdso/Makefile      | 2 +-
 arch/x86/kernel/Makefile          | 4 ----
 arch/x86/realmode/rm/Makefile     | 1 +
 include/asm-generic/vmlinux.lds.h | 2 ++
 5 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index bed0850d91b0..0382a9534099 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -165,11 +165,13 @@ else
         KBUILD_RUSTFLAGS += $(rustflags-y)
 
         KBUILD_CFLAGS += -mno-red-zone
-        KBUILD_CFLAGS += -mcmodel=kernel
+        KBUILD_CFLAGS_MODULE += -mcmodel=kernel
         KBUILD_RUSTFLAGS += -Cno-redzone=y
-        KBUILD_RUSTFLAGS += -Ccode-model=kernel
+        KBUILD_RUSTFLAGS_KERNEL += -Ccode-model=small
+        KBUILD_RUSTFLAGS_MODULE += -Ccode-model=kernel
 
 	PIE_CFLAGS := -fpie -mcmodel=small \
+		      $(call cc-option,-Wa$(comma)-mrelax-relocations=no) \
 		      -include $(srctree)/include/linux/hidden.h
 
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
@@ -178,6 +180,7 @@ else
 		endif
 	endif
 
+	KBUILD_CFLAGS_KERNEL += $(PIE_CFLAGS)
 	export PIE_CFLAGS
 endif
 
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index b1b8dd1608f7..e2c79d4c1417 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -149,7 +149,7 @@ $(obj)/vdso32.so.dbg: KBUILD_AFLAGS = $(KBUILD_AFLAGS_32)
 $(obj)/vdso32.so.dbg: asflags-$(CONFIG_X86_64) += -m32
 
 KBUILD_CFLAGS_32 := $(filter-out -m64,$(KBUILD_CFLAGS))
-KBUILD_CFLAGS_32 := $(filter-out -mcmodel=kernel,$(KBUILD_CFLAGS_32))
+KBUILD_CFLAGS_32 := $(filter-out -mcmodel=small,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -fno-pic,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out -mfentry,$(KBUILD_CFLAGS_32))
 KBUILD_CFLAGS_32 := $(filter-out $(RANDSTRUCT_CFLAGS),$(KBUILD_CFLAGS_32))
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 65194ca79b5c..0000325ab98f 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -21,10 +21,6 @@ CFLAGS_REMOVE_sev.o = -pg
 CFLAGS_REMOVE_rethook.o = -pg
 endif
 
-# head64.c contains C code that may execute from a different virtual address
-# than it was linked at, so we always build it using PIE codegen
-CFLAGS_head64.o += $(PIE_CFLAGS)
-
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
diff --git a/arch/x86/realmode/rm/Makefile b/arch/x86/realmode/rm/Makefile
index f614009d3e4e..fdb8e780f903 100644
--- a/arch/x86/realmode/rm/Makefile
+++ b/arch/x86/realmode/rm/Makefile
@@ -76,5 +76,6 @@ KBUILD_CFLAGS	:= $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
 		   -I$(srctree)/arch/x86/boot
 KBUILD_AFLAGS	:= $(KBUILD_CFLAGS) -D__ASSEMBLY__
 KBUILD_CFLAGS	+= -fno-asynchronous-unwind-tables
+KBUILD_CFLAGS_KERNEL := $(filter-out $(PIE_CFLAGS),$(KBUILD_CFLAGS_KERNEL))
 GCOV_PROFILE := n
 UBSAN_SANITIZE := n
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ef45331fb043..9518b87207e8 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -355,6 +355,7 @@
 	*(.data..decrypted)						\
 	*(.ref.data)							\
 	*(.data..shared_aligned) /* percpu related */			\
+	*(.data.rel .data.rel.*)					\
 	MEM_KEEP(init.data*)						\
 	*(.data.unlikely)						\
 	__start_once = .;						\
@@ -477,6 +478,7 @@
 	.rodata           : AT(ADDR(.rodata) - LOAD_OFFSET) {		\
 		__start_rodata = .;					\
 		*(.rodata) *(.rodata.*)					\
+		*(.data.rel.ro*)					\
 		SCHED_DATA						\
 		RO_AFTER_INIT_DATA	/* Read only after init */	\
 		. = ALIGN(8);						\
-- 
2.43.0.429.g432eaa2c6b-goog


