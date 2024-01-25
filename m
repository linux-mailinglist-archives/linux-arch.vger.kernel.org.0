Return-Path: <linux-arch+bounces-1578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E14383C0F8
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 12:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A02E1F22562
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jan 2024 11:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C35C58216;
	Thu, 25 Jan 2024 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taaxhFRv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B368E57329
	for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 11:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706182394; cv=none; b=krlnG0qlmkIuE/b/Iy6bK6i9JveCXcn7RtC+XJyRp5vBwWScTmmHe0iS+/tpY2r9pyDxQmIJZF/9XvGy8nIUMOxobm0OulaitoHbgYp9R4y+iqAMmhSteDGZQ5aZOM0/ORGi+4Tbh377a8FZ6o0HaPZhLIVP0HUH8YYiVbcNdik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706182394; c=relaxed/simple;
	bh=53cr8/bRwWd0m61pZCiciaZiTFFAHiTaLmG9qZPd8js=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tdSpCu95tmq2nZFiFfXICyigkK4zFQbfLHrUqqXnucw1f4NdcL99ifjVsJQQVJgbop8n8vEOgSCt/ueCotywld1Ch6YKhelygmaM5rxGh37FLLZtKNXV8AaGecM1iiDp4S3poDlSwOgkU8WP/c2Rhll5zIb9PrrTK5CTG+8KqvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taaxhFRv; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ardb.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc37b0ac33cso4472776276.2
        for <linux-arch@vger.kernel.org>; Thu, 25 Jan 2024 03:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706182392; x=1706787192; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LDdj00C7C86np8himWDzcjTQoz4YXOOGxPlqG/+mK0=;
        b=taaxhFRvBJ7x27l0OSpr3vw8YcmBhyQ4c2nMIVUArmpw+BcvPfxbwyrfACHztLpiTk
         knCWGvpQr2vejXCH8yeUeWNrLRxBNfuRWLE0bdc07HrlzEQihHZu1oBwoAcf4F+c8SAI
         9HJ3QelivOwHj0HG8vIqJSxsZEcqq531Eo6CZixbSsPOCJtOSd0fYwI/4isy6Gp/jzHp
         W5PccyVU8g+03rE5zXUChfWQb0IxL1w3Pu2XziIEViFfESgzYW8TTXNDuFcBkQ5xM64L
         1p6H4uN7aYsC0okITA86UF+N9/r93rJBrs1wuHgsa2ec2aDhd9rSMJZtlDVXaVD9Yr0y
         nOrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706182392; x=1706787192;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7LDdj00C7C86np8himWDzcjTQoz4YXOOGxPlqG/+mK0=;
        b=cxMLXshAKVB3H4UsAP24TUhsQgEOvldDJg9AP/RLDjRwot6XQe+O18/J+XTUj/z1rA
         /T2mC+IKmF5alcDxQxKwv801JfztFETXffOqo2FIihz1qLV6E4EaAmst2OkY+Cs/tWyE
         xpChyBeSYAB/wWUPCGXJkBRQF7VwPbGiYX7M9/RdoAhiW1rHD+3Nb/vDcyaYtmBwZAot
         DlJ1VaxSpisM1m0L6ohrMgCfUqbPOzXo5s9ZEAKcmPnt8gbzCodJGGCGqwdv1kJQVyV/
         Q3QWvOQBDIuFquEu7+227Zuvxq7LUYFlH87ObMnaHW8ZtgGy4+AVcwbd7/NVSTD9ZSNX
         pXAA==
X-Gm-Message-State: AOJu0YwW2xrAnj22G3fnyHKwvBredq31g5FqCwA/l3BZLyzk9gEFYR4L
	DOLLbdcLMeAidJ4ydGl7hgVnZuGgZw2zeF562VGYt4+eAiXDhRWeLR2JPv6P9DbJAMIqKA==
X-Google-Smtp-Source: AGHT+IEYrqY9RO1J4T40n/eazYsD++IwJjE+LuPFxgr4ZWZFXwfWm+alacUdiFpJCu8iH87eqkLxcQjD
X-Received: from palermo.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:118a])
 (user=ardb job=sendgmr) by 2002:a05:6902:108f:b0:dc2:23d8:722d with SMTP id
 v15-20020a056902108f00b00dc223d8722dmr436585ybu.13.1706182391890; Thu, 25 Jan
 2024 03:33:11 -0800 (PST)
Date: Thu, 25 Jan 2024 12:28:34 +0100
In-Reply-To: <20240125112818.2016733-19-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240125112818.2016733-19-ardb+git@google.com>
X-Developer-Key: i=ardb@kernel.org; a=openpgp; fpr=F43D03328115A198C90016883D200E9CA6329909
X-Developer-Signature: v=1; a=openpgp-sha256; l=2380; i=ardb@kernel.org;
 h=from:subject; bh=NfyMVMLTwE2gaCOtLA5OAbEVC8C/2zEsck2HEztektc=;
 b=owGbwMvMwCFmkMcZplerG8N4Wi2JIXWT678l+dzpjnF+wZfLxO/X9M9rvaB34Fq1rvE771Va/
 2WDd+/oKGVhEONgkBVTZBGY/ffdztMTpWqdZ8nCzGFlAhnCwMUpABOZG8TIcPHCL6dXrmYPXq0u
 +/nAkX3twjvhvyf4n/khfu+DqbPAJz2Gv5KiT+q1eYp+JNx95BpofMp0+aemWZPF3+8rX3BPpu7 OSnYA
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240125112818.2016733-34-ardb+git@google.com>
Subject: [PATCH v2 15/17] x86/sev: Use PIC codegen for early SEV startup code
From: Ard Biesheuvel <ardb+git@google.com>
To: linux-kernel@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Kevin Loughlin <kevinloughlin@google.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Dionna Glaze <dionnaglaze@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, 
	Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Justin Stitt <justinstitt@google.com>, 
	Brian Gerst <brgerst@gmail.com>, linux-arch@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

From: Ard Biesheuvel <ardb@kernel.org>

Use PIC codegen for the compilation units containing code that may be
called very early during the boot, at which point the CPU still runs
from the 1:1 mapping of memory. This is necessary to prevent the
compiler from emitting absolute symbol references to addresses that are
not mapped yet.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/Makefile      | 1 +
 arch/x86/kernel/vmlinux.lds.S | 1 +
 arch/x86/lib/Makefile         | 2 +-
 arch/x86/mm/Makefile          | 3 ++-
 4 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 65194ca79b5c..65677b25d803 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -24,6 +24,7 @@ endif
 # head64.c contains C code that may execute from a different virtual address
 # than it was linked at, so we always build it using PIE codegen
 CFLAGS_head64.o += $(PIE_CFLAGS)
+CFLAGS_sev.o += $(PIE_CFLAGS)
 
 KASAN_SANITIZE_head$(BITS).o				:= n
 KASAN_SANITIZE_dumpstack.o				:= n
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 77262e804250..bbdccb6362a9 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -182,6 +182,7 @@ SECTIONS
 
 		DATA_DATA
 		CONSTRUCTORS
+		*(.data.rel .data.rel.*)
 
 		/* rarely changed data like cpu maps */
 		READ_MOSTLY_DATA(INTERNODE_CACHE_BYTES)
diff --git a/arch/x86/lib/Makefile b/arch/x86/lib/Makefile
index ea3a28e7b613..87c79bb8d386 100644
--- a/arch/x86/lib/Makefile
+++ b/arch/x86/lib/Makefile
@@ -24,7 +24,7 @@ ifdef CONFIG_FUNCTION_TRACER
 CFLAGS_REMOVE_cmdline.o = -pg
 endif
 
-CFLAGS_cmdline.o := -fno-stack-protector -fno-jump-tables
+CFLAGS_cmdline.o := $(PIE_CFLAGS)
 endif
 
 inat_tables_script = $(srctree)/arch/x86/tools/gen-insn-attr-x86.awk
diff --git a/arch/x86/mm/Makefile b/arch/x86/mm/Makefile
index c80febc44cd2..b412009ae588 100644
--- a/arch/x86/mm/Makefile
+++ b/arch/x86/mm/Makefile
@@ -31,7 +31,8 @@ obj-y				+= pat/
 
 # Make sure __phys_addr has no stackprotector
 CFLAGS_physaddr.o		:= -fno-stack-protector
-CFLAGS_mem_encrypt_identity.o	:= -fno-stack-protector
+CFLAGS_mem_encrypt_identity.o	:= $(PIE_CFLAGS)
+CFLAGS_pti.o			:= $(PIE_CFLAGS)
 
 CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
 
-- 
2.43.0.429.g432eaa2c6b-goog


