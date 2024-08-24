Return-Path: <linux-arch+bounces-6567-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E715695E04F
	for <lists+linux-arch@lfdr.de>; Sun, 25 Aug 2024 01:07:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A4D21C20D91
	for <lists+linux-arch@lfdr.de>; Sat, 24 Aug 2024 23:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C27D1448EF;
	Sat, 24 Aug 2024 23:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b="gK56Mtz0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-io1-f65.google.com (mail-io1-f65.google.com [209.85.166.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A79143C46
	for <linux-arch@vger.kernel.org>; Sat, 24 Aug 2024 23:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724540825; cv=none; b=f4UYSsAoN93CAj5DoCBIhin9uMDg3GUWKgLAcxqkaG99xsdK04cUJJ7aPbxt5PllsOukaQDiMq0Q7gYRQiUjVkkpQbTcTR02gdd/XxLiMebCOg1U7ksY8t/nLc9RnWPx4lo7IcG3kmYGImULiW9LTMp0MVas4UzQo8yfzrewTvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724540825; c=relaxed/simple;
	bh=HFFgMUe0sXLt8uy3R2lYoPH0xrrMmgwABqkiDy8B3Qo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kDaokf5jmL0LqHzfgmxSDiW6Fb3dnvwbwgGgCZRab79vqzFNqmOkBrCsIxZAf+R9h8SAL5OMk4dxGeJ49WbhQeDRrGbLgOi1bT1SidWzvzSAyBEXtHGqd/ze5vtnj+i6GxH7i+RBxkE/sIP3kfUp+4goJwrZKh+m9bFVxInb4GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu; spf=pass smtp.mailfrom=illinois.edu; dkim=pass (2048-bit key) header.d=illinois-edu.20230601.gappssmtp.com header.i=@illinois-edu.20230601.gappssmtp.com header.b=gK56Mtz0; arc=none smtp.client-ip=209.85.166.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=illinois.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=illinois.edu
Received: by mail-io1-f65.google.com with SMTP id ca18e2360f4ac-82521c46feaso113287939f.2
        for <linux-arch@vger.kernel.org>; Sat, 24 Aug 2024 16:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=illinois-edu.20230601.gappssmtp.com; s=20230601; t=1724540822; x=1725145622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6KIwALI9lcPb0lT76UFCEG4r4cwMraGgAV9q6NNiJF4=;
        b=gK56Mtz0TjsY+Rp/mE17J30X/dypHWfN5918T/Q8RxwkDOL+OH78rpLMhjofuwOABh
         Wri0Kp7WQu6vPvLYRFaayGyuQgYcnUm92Cl2hy9kx20In2BLbj1aO7KoYifZw/GU+jKp
         qK/SrjtRea7aqwzd45sIEf3soIUPPjbxgsxJBuR4UjCQGYRRi+zhbK8+QtanYt4TV8p4
         r4daB55RbkEAC4c7ax4KwKjaRgZ26+6G00OZ8n79yNaOx+w5bqQPlWcaU+m1nX0chI9w
         GMzzV5yQ1mWMPl9pQIbLSblPhDjqG9wvJW10qegj40vUDNLUA8hANz+a+Weokkat/6yp
         lEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724540822; x=1725145622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6KIwALI9lcPb0lT76UFCEG4r4cwMraGgAV9q6NNiJF4=;
        b=uMbugvhf8EtXDOmTcuWW3xrTScwTw8HnhI1hhW6ZEms/w8b3LfcyqR+g32oczNMoGw
         AfVNEkf11euFkYSdNQ2wNQKiHahR98EklndfnYAFsNJk6tarXDimUWOAnF6UshIqSyGq
         4/6t5owxJJSIKRi4h8lqJcManYPnZy26TBrKdsgxkqIWTXuEmg9SQKjSTbV9+f8Y7YId
         ZRQ9JTnBS/14tKmZs2zWYS2WQ8J8IBvMqJ4AswE0F/KtFdsdicyP6sC29lh1DKA+gy6d
         3PmA/f7tZFQAyHux98YMH/b6tjZBEtVVaz9AQos/gU8mA5SCEQzUQO4jQnAyyfrhONw0
         dKcg==
X-Forwarded-Encrypted: i=1; AJvYcCViS+Pb4xXyPxYsFupqkeULGQ/6HDCHjecSyy+vsd4qEWJcgafoWYPv9323pZDXOd/ipv0RlATUBhOp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+/vgsqp0GKYNqFm7WPZtM7nuboOpW+FO7gKaIf/OcPeIKadqa
	wHOMHLY30yKFm6eZZRYzrsmWSawIwoD+NzdxS4/BUZ4ESqfG1D/JO7GKbm1KRg==
X-Google-Smtp-Source: AGHT+IF5JX0Jk4k4VxnekA9ZAMpPy+eSge9GLI2pHIyDjL7LjOoFyPID7Vz4y3rMhqO0ju3PL8Nfvg==
X-Received: by 2002:a05:6602:2c94:b0:824:e42e:a1bd with SMTP id ca18e2360f4ac-827881eb403mr770732339f.17.1724540822378;
        Sat, 24 Aug 2024 16:07:02 -0700 (PDT)
Received: from shizuku.. (mobile-130-126-255-62.near.illinois.edu. [130.126.255.62])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4ce70f85671sm1563938173.80.2024.08.24.16.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Aug 2024 16:07:01 -0700 (PDT)
From: Wentao Zhang <wentaoz5@illinois.edu>
To: linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	x86@kernel.org
Cc: wentaoz5@illinois.edu,
	marinov@illinois.edu,
	tyxu@illinois.edu,
	jinghao7@illinois.edu,
	tingxur@illinois.edu,
	steven.h.vanderleest@boeing.com,
	chuck.wolber@boeing.com,
	matthew.l.weber3@boeing.com,
	Matt.Kelly2@boeing.com,
	andrew.j.oppelt@boeing.com,
	samuel.sarkisian@boeing.com,
	morbo@google.com,
	samitolvanen@google.com,
	masahiroy@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	ardb@kernel.org,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	arnd@arndb.de,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	oberpar@linux.ibm.com,
	akpm@linux-foundation.org,
	paulmck@kernel.org,
	bhelgaas@google.com,
	kees@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org,
	kent.overstreet@linux.dev,
	nathan@kernel.org,
	hpa@zytor.com,
	mathieu.desnoyers@efficios.com,
	ndesaulniers@google.com,
	justinstitt@google.com,
	maskray@google.com,
	dvyukov@google.com
Subject: [RFC PATCH 1/3] llvm-cov: add Clang's Source-based Code Coverage support
Date: Sat, 24 Aug 2024 18:06:39 -0500
Message-Id: <20240824230641.385839-2-wentaoz5@illinois.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240824230641.385839-1-wentaoz5@illinois.edu>
References: <20240824230641.385839-1-wentaoz5@illinois.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement debugfs entries for serializing profiles and resetting
counters/bitmaps. Also adds Source-based Code Coverage flags and kconfig
options.

This work reuses a portion of code from a previous effort by Sami
Tolvanen et al. [1], specifically its debugfs interface and the
underlying profile processing, but discards all its PGO-specific parts,
notably value profiling.  To our end (code coverage, like MC/DC,
required for high assurance), we do instrumentation at the compiler
frontend, instead of IR; we care about counters and bitmaps, but not
value profiling.

[1] https://lore.kernel.org/lkml/20210407211704.367039-1-morbo@google.com/

Signed-off-by: Wentao Zhang <wentaoz5@illinois.edu>
Signed-off-by: Chuck Wolber <chuck.wolber@boeing.com>
---
 Makefile                          |   3 +
 arch/Kconfig                      |   1 +
 arch/x86/Kconfig                  |   1 +
 arch/x86/kernel/vmlinux.lds.S     |   2 +
 include/asm-generic/vmlinux.lds.h |  38 +++++
 kernel/Makefile                   |   1 +
 kernel/llvm-cov/Kconfig           |  29 ++++
 kernel/llvm-cov/Makefile          |   5 +
 kernel/llvm-cov/fs.c              | 253 ++++++++++++++++++++++++++++++
 kernel/llvm-cov/llvm-cov.h        | 156 ++++++++++++++++++
 scripts/Makefile.lib              |  10 ++
 scripts/mod/modpost.c             |   2 +
 12 files changed, 501 insertions(+)
 create mode 100644 kernel/llvm-cov/Kconfig
 create mode 100644 kernel/llvm-cov/Makefile
 create mode 100644 kernel/llvm-cov/fs.c
 create mode 100644 kernel/llvm-cov/llvm-cov.h

diff --git a/Makefile b/Makefile
index 68ebd6d6b444..1750a2b7dfe8 100644
--- a/Makefile
+++ b/Makefile
@@ -737,6 +737,9 @@ endif # KBUILD_EXTMOD
 # Defaults to vmlinux, but the arch makefile usually adds further targets
 all: vmlinux
 
+CFLAGS_LLVM_COV := -fprofile-instr-generate -fcoverage-mapping
+export CFLAGS_LLVM_COV
+
 CFLAGS_GCOV	:= -fprofile-arcs -ftest-coverage
 ifdef CONFIG_CC_IS_GCC
 CFLAGS_GCOV	+= -fno-tree-loop-im
diff --git a/arch/Kconfig b/arch/Kconfig
index 975dd22a2dbd..0727265f677f 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1601,6 +1601,7 @@ config ARCH_HAS_KERNEL_FPU_SUPPORT
 	  the kernel, as described in Documentation/core-api/floating-point.rst.
 
 source "kernel/gcov/Kconfig"
+source "kernel/llvm-cov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
 
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 007bab9f2a0e..87a793b82bab 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -85,6 +85,7 @@ config X86
 	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_HAS_GCOV_PROFILE_ALL
 	select ARCH_HAS_KCOV			if X86_64
+	select ARCH_HAS_LLVM_COV		if X86_64
 	select ARCH_HAS_KERNEL_FPU_SUPPORT
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index 6e73403e874f..90433772240a 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -191,6 +191,8 @@ SECTIONS
 
 	BUG_TABLE
 
+	LLVM_COV_DATA
+
 	ORC_UNWIND_TABLE
 
 	. = ALIGN(PAGE_SIZE);
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 1ae44793132a..770ff8469dcd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -334,6 +334,44 @@
 #define THERMAL_TABLE(name)
 #endif
 
+#ifdef CONFIG_LLVM_COV_KERNEL
+#define LLVM_COV_DATA							\
+	__llvm_prf_data : AT(ADDR(__llvm_prf_data) - LOAD_OFFSET) {	\
+		__llvm_prf_start = .;					\
+		__llvm_prf_data_start = .;				\
+		*(__llvm_prf_data)					\
+		__llvm_prf_data_end = .;				\
+	}								\
+	__llvm_prf_cnts : AT(ADDR(__llvm_prf_cnts) - LOAD_OFFSET) {	\
+		__llvm_prf_cnts_start = .;				\
+		*(__llvm_prf_cnts)					\
+		__llvm_prf_cnts_end = .;				\
+	}								\
+	__llvm_prf_names : AT(ADDR(__llvm_prf_names) - LOAD_OFFSET) {	\
+		__llvm_prf_names_start = .;				\
+		*(__llvm_prf_names)					\
+		__llvm_prf_names_end = .;				\
+	}								\
+	__llvm_prf_bits : AT(ADDR(__llvm_prf_bits) - LOAD_OFFSET) {	\
+		__llvm_prf_bits_start = .;				\
+		*(__llvm_prf_bits)					\
+		__llvm_prf_bits_end = .;				\
+	}								\
+	__llvm_covfun : AT(ADDR(__llvm_covfun) - LOAD_OFFSET) {		\
+		__llvm_covfun_start = .;				\
+		*(__llvm_covfun)					\
+		__llvm_covfun_end = .;					\
+	}								\
+	__llvm_covmap : AT(ADDR(__llvm_covmap) - LOAD_OFFSET) {		\
+		__llvm_covmap_start = .;				\
+		*(__llvm_covmap)					\
+		__llvm_covmap_end = .;					\
+		__llvm_prf_end = .;					\
+	}
+#else
+#define LLVM_COV_DATA
+#endif
+
 #define KERNEL_DTB()							\
 	STRUCT_ALIGN();							\
 	__dtb_start = .;						\
diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..773e6a9ee00a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -117,6 +117,7 @@ obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
 obj-$(CONFIG_NUMA) += numa.o
+obj-$(CONFIG_LLVM_COV_KERNEL) += llvm-cov/
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/kernel/llvm-cov/Kconfig b/kernel/llvm-cov/Kconfig
new file mode 100644
index 000000000000..505eba5bd23c
--- /dev/null
+++ b/kernel/llvm-cov/Kconfig
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: GPL-2.0-only
+menu "Clang's source-based kernel coverage measurement (EXPERIMENTAL)"
+
+config ARCH_HAS_LLVM_COV
+	bool
+
+config LLVM_COV_KERNEL
+	bool "Enable Clang's source-based kernel coverage measurement"
+	depends on DEBUG_FS
+	depends on ARCH_HAS_LLVM_COV
+	depends on CC_IS_CLANG && CLANG_VERSION >= 180000
+	default n
+	help
+	  This option enables Clang's Source-based Code Coverage.
+
+	  If unsure, say N.
+
+	  On a kernel compiled with this option, run your test suites, and
+	  download the raw profile from /sys/kernel/debug/llvm-cov/profraw.
+	  This file can then be converted into the indexed format with
+	  llvm-profdata and used to generate coverage reports with llvm-cov.
+
+	  Note that a kernel compiled with coverage flags will be significantly
+	  larger and run slower.
+
+	  Note that the debugfs filesystem has to be mounted to access the raw
+	  profile.
+
+endmenu
diff --git a/kernel/llvm-cov/Makefile b/kernel/llvm-cov/Makefile
new file mode 100644
index 000000000000..a0f45e05f8fb
--- /dev/null
+++ b/kernel/llvm-cov/Makefile
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0
+GCOV_PROFILE		:= n
+LLVM_COV_PROFILE	:= n
+
+obj-y	+= fs.o
\ No newline at end of file
diff --git a/kernel/llvm-cov/fs.c b/kernel/llvm-cov/fs.c
new file mode 100644
index 000000000000..c56f660a174e
--- /dev/null
+++ b/kernel/llvm-cov/fs.c
@@ -0,0 +1,253 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#define pr_fmt(fmt)	"llvm-cov: " fmt
+
+#include <linux/kernel.h>
+#include <linux/debugfs.h>
+#include <linux/fs.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/spinlock.h>
+#include "llvm-cov.h"
+
+/*
+ * This lock guards both counter/bitmap reset and serialization of the
+ * raw profile data. Keeping both of these activities separate via locking
+ * ensures that we don't try to serialize data that's being reset.
+ */
+DEFINE_SPINLOCK(llvm_cov_lock);
+
+static struct dentry *directory;
+
+struct llvm_cov_private_data {
+	char *buffer;
+	unsigned long size;
+};
+
+/*
+ * Raw profile data format:
+ * https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format. We will
+ * only populate information that's relevant to basic Source-based Code Coverage
+ * before serialization. Other features like binary IDs, continuous mode,
+ * single-byte mode, value profiling, type profiling etc are not implemented.
+ */
+
+static void llvm_cov_fill_raw_profile_header(void **buffer)
+{
+	struct __llvm_profile_header *header = *(struct __llvm_profile_header **)buffer;
+
+	header->magic = INSTR_PROF_RAW_MAGIC_64;
+	header->version = INSTR_PROF_RAW_VERSION;
+	header->binary_ids_size = 0;
+	header->num_data = __llvm_prf_data_count();
+	header->padding_bytes_before_counters = 0;
+	header->num_counters = __llvm_prf_cnts_count();
+	header->padding_bytes_after_counters =
+		__llvm_prf_get_padding(__llvm_prf_cnts_size());
+	header->num_bitmap_bytes = __llvm_prf_bits_size();
+	header->padding_bytes_after_bitmap_bytes =
+		__llvm_prf_get_padding(__llvm_prf_bits_size());
+	header->names_size = __llvm_prf_names_size();
+	header->counters_delta = (u64)__llvm_prf_cnts_start -
+				 (u64)__llvm_prf_data_start;
+	header->bitmap_delta   = (u64)__llvm_prf_bits_start -
+				 (u64)__llvm_prf_data_start;
+	header->names_delta    = (u64)__llvm_prf_names_start;
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+	header->num_v_tables = 0;
+	header->v_names_size = 0;
+#endif
+	header->value_kind_last = IPVK_LAST;
+
+	*buffer += sizeof(*header);
+}
+
+/*
+ * Copy the source into the buffer, incrementing the pointer into buffer in the
+ * process.
+ */
+static void llvm_cov_copy_section_to_buffer(void **buffer, void *src,
+					    unsigned long size)
+{
+	memcpy(*buffer, src, size);
+	*buffer += size;
+}
+
+static unsigned long llvm_cov_get_raw_profile_size(void)
+{
+	return sizeof(struct __llvm_profile_header) +
+	       __llvm_prf_data_size() +
+	       __llvm_prf_cnts_size() +
+	       __llvm_prf_get_padding(__llvm_prf_cnts_size()) +
+	       __llvm_prf_bits_size() +
+	       __llvm_prf_get_padding(__llvm_prf_bits_size()) +
+	       __llvm_prf_names_size() +
+	       __llvm_prf_get_padding(__llvm_prf_names_size());
+}
+
+/*
+ * Serialize in-memory data into a format LLVM tools can understand
+ * (https://llvm.org/docs/InstrProfileFormat.html#raw-profile-format)
+ */
+static int llvm_cov_serialize_raw_profile(struct llvm_cov_private_data *p)
+{
+	int err = 0;
+	void *buffer;
+
+	p->size = llvm_cov_get_raw_profile_size();
+	p->buffer = vzalloc(p->size);
+
+	if (!p->buffer) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	buffer = p->buffer;
+
+	llvm_cov_fill_raw_profile_header(&buffer);
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_data_start,
+					__llvm_prf_data_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_cnts_start,
+					__llvm_prf_cnts_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_cnts_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_bits_start,
+					__llvm_prf_bits_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_bits_size());
+	llvm_cov_copy_section_to_buffer(&buffer, __llvm_prf_names_start,
+					__llvm_prf_names_size());
+	buffer += __llvm_prf_get_padding(__llvm_prf_names_size());
+
+out:
+	return err;
+}
+
+/* open() implementation for llvm-cov data file. */
+static int llvm_cov_open(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data;
+	unsigned long flags;
+	int err;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	flags = llvm_cov_claim_lock();
+
+	err = llvm_cov_serialize_raw_profile(data);
+	if (unlikely(err)) {
+		kfree(data);
+		goto out_unlock;
+	}
+
+	file->private_data = data;
+
+out_unlock:
+	llvm_cov_release_lock(flags);
+out:
+	return err;
+}
+
+/* read() implementation for llvm-cov data file. */
+static ssize_t llvm_cov_read(struct file *file, char __user *buf, size_t count,
+			loff_t *ppos)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	if (!data)
+		return -EBADF;
+
+	return simple_read_from_buffer(buf, count, ppos, data->buffer,
+				       data->size);
+}
+
+/* release() implementation for llvm-cov data file. */
+static int llvm_cov_release(struct inode *inode, struct file *file)
+{
+	struct llvm_cov_private_data *data = file->private_data;
+
+	if (data) {
+		vfree(data->buffer);
+		kfree(data);
+	}
+
+	return 0;
+}
+
+static const struct file_operations llvm_cov_data_fops = {
+	.owner		= THIS_MODULE,
+	.open		= llvm_cov_open,
+	.read		= llvm_cov_read,
+	.llseek		= default_llseek,
+	.release	= llvm_cov_release
+};
+
+/* write() implementation for llvm-cov reset file */
+static ssize_t reset_write(struct file *file, const char __user *addr,
+			   size_t len, loff_t *pos)
+{
+	unsigned long flags;
+
+	flags = llvm_cov_claim_lock();
+	memset(__llvm_prf_cnts_start, 0, __llvm_prf_cnts_size());
+	memset(__llvm_prf_bits_start, 0, __llvm_prf_bits_size());
+	llvm_cov_release_lock(flags);
+
+	return len;
+}
+
+static const struct file_operations llvm_cov_reset_fops = {
+	.owner		= THIS_MODULE,
+	.write		= reset_write,
+	.llseek		= noop_llseek,
+};
+
+/* Create debugfs entries. */
+static int __init llvm_cov_init(void)
+{
+	directory = debugfs_create_dir("llvm-cov", NULL);
+	if (!directory)
+		goto err_remove;
+
+	if (!debugfs_create_file("profraw", 0400, directory, NULL,
+				 &llvm_cov_data_fops))
+		goto err_remove;
+
+	if (!debugfs_create_file("reset", 0200, directory, NULL,
+				 &llvm_cov_reset_fops))
+		goto err_remove;
+
+	return 0;
+
+err_remove:
+	debugfs_remove_recursive(directory);
+	pr_err("initialization failed\n");
+	return -EIO;
+}
+
+/* Remove debugfs entries. */
+static void __exit llvm_cov_exit(void)
+{
+	debugfs_remove_recursive(directory);
+}
+
+module_init(llvm_cov_init);
+module_exit(llvm_cov_exit);
diff --git a/kernel/llvm-cov/llvm-cov.h b/kernel/llvm-cov/llvm-cov.h
new file mode 100644
index 000000000000..d9551a685756
--- /dev/null
+++ b/kernel/llvm-cov/llvm-cov.h
@@ -0,0 +1,156 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019	Sami Tolvanen <samitolvanen@google.com>, Google, Inc.
+ * Copyright (C) 2024	Jinghao Jia   <jinghao7@illinois.edu>,   UIUC
+ * Copyright (C) 2024	Wentao Zhang  <wentaoz5@illinois.edu>,   UIUC
+ *
+ * This software is licensed under the terms of the GNU General Public
+ * License version 2, as published by the Free Software Foundation, and
+ * may be copied, distributed, and modified under those terms.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LLVM_COV_H
+#define _LLVM_COV_H
+
+extern spinlock_t llvm_cov_lock;
+
+static __always_inline unsigned long llvm_cov_claim_lock(void)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&llvm_cov_lock, flags);
+
+	return flags;
+}
+
+static __always_inline void llvm_cov_release_lock(unsigned long flags)
+{
+	spin_unlock_irqrestore(&llvm_cov_lock, flags);
+}
+
+/*
+ * Note: These internal LLVM definitions must match the compiler version.
+ * See llvm/include/llvm/ProfileData/InstrProfData.inc in LLVM's source code.
+ */
+
+#define INSTR_PROF_RAW_MAGIC_64		\
+		((u64)255 << 56 |	\
+		 (u64)'l' << 48 |	\
+		 (u64)'p' << 40 |	\
+		 (u64)'r' << 32 |	\
+		 (u64)'o' << 24 |	\
+		 (u64)'f' << 16 |	\
+		 (u64)'r' << 8  |	\
+		 (u64)129)
+
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+#define INSTR_PROF_RAW_VERSION		10
+#define INSTR_PROF_DATA_ALIGNMENT	8
+#define IPVK_LAST			2
+#elif defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 180000
+#define INSTR_PROF_RAW_VERSION		9
+#define INSTR_PROF_DATA_ALIGNMENT	8
+#define IPVK_LAST			1
+#endif
+
+/**
+ * struct __llvm_profile_header - represents the raw profile header data
+ * structure. Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#header.
+ */
+struct __llvm_profile_header {
+	u64 magic;
+	u64 version;
+	u64 binary_ids_size;
+	u64 num_data;
+	u64 padding_bytes_before_counters;
+	u64 num_counters;
+	u64 padding_bytes_after_counters;
+	u64 num_bitmap_bytes;
+	u64 padding_bytes_after_bitmap_bytes;
+	u64 names_size;
+	u64 counters_delta;
+	u64 bitmap_delta;
+	u64 names_delta;
+#if defined(CONFIG_CC_IS_CLANG) && CONFIG_CLANG_VERSION >= 190000
+	u64 num_v_tables;
+	u64 v_names_size;
+#endif
+	u64 value_kind_last;
+};
+
+/**
+ * struct __llvm_profile_data - represents the per-function control structure.
+ * Description of each member can be found here:
+ * https://llvm.org/docs/InstrProfileFormat.html#profile-metadata. To measure
+ * Source-based Code Coverage, the internals of this struct don't matter at run
+ * time. The only purpose of the definition below is to run sizeof() against it
+ * so that we can calculate the "num_data" field in header.
+ */
+struct __llvm_profile_data {
+	const u64 name_ref;
+	const u64 func_hash;
+	const void *counter_ptr;
+	const void *bitmap_ptr;
+	const void *function_pointer;
+	void *values;
+	const u32 num_counters;
+	const u16 num_value_sites[IPVK_LAST + 1];
+	const u32 num_bitmap_bytes;
+} __aligned(INSTR_PROF_DATA_ALIGNMENT);
+
+/* Payload sections */
+
+extern struct __llvm_profile_data __llvm_prf_data_start[];
+extern struct __llvm_profile_data __llvm_prf_data_end[];
+
+extern u64 __llvm_prf_cnts_start[];
+extern u64 __llvm_prf_cnts_end[];
+
+extern char __llvm_prf_names_start[];
+extern char __llvm_prf_names_end[];
+
+extern char __llvm_prf_bits_start[];
+extern char __llvm_prf_bits_end[];
+
+#define __DEFINE_SECTION_SIZE(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _size(void)	\
+	{								\
+		unsigned long start =					\
+			(unsigned long)__llvm_prf_ ## s ## _start;	\
+		unsigned long end =					\
+			(unsigned long)__llvm_prf_ ## s ## _end;	\
+		return end - start;					\
+	}
+#define __DEFINE_SECTION_COUNT(s)					\
+	static inline unsigned long __llvm_prf_ ## s ## _count(void)	\
+	{								\
+		return __llvm_prf_ ## s ## _size() /			\
+			sizeof(__llvm_prf_ ## s ## _start[0]);		\
+	}
+
+__DEFINE_SECTION_SIZE(data)
+__DEFINE_SECTION_SIZE(cnts)
+__DEFINE_SECTION_SIZE(names)
+__DEFINE_SECTION_SIZE(bits)
+
+__DEFINE_SECTION_COUNT(data)
+__DEFINE_SECTION_COUNT(cnts)
+__DEFINE_SECTION_COUNT(names)
+__DEFINE_SECTION_COUNT(bits)
+
+#undef __DEFINE_SECTION_SIZE
+#undef __DEFINE_SECTION_COUNT
+
+static inline unsigned long __llvm_prf_get_padding(unsigned long size)
+{
+	return 7 & (sizeof(u64) - size % sizeof(u64));
+}
+
+#endif /* _LLVM_COV_H */
diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index fe3668dc4954..b9ceaee34b28 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -158,6 +158,16 @@ _c_flags += $(if $(patsubst n%,, \
 		$(CFLAGS_GCOV))
 endif
 
+#
+# Enable Clang's Source-based Code Coverage flags for a file or directory
+# depending on variables LLVM_COV_PROFILE_obj.o and LLVM_COV_PROFILE.
+#
+ifeq ($(CONFIG_LLVM_COV_KERNEL),y)
+_c_flags += $(if $(patsubst n%,, \
+		$(LLVM_COV_PROFILE_$(basetarget).o)$(LLVM_COV_PROFILE)y), \
+		$(CFLAGS_LLVM_COV))
+endif
+
 #
 # Enable address sanitizer flags for kernel except some files or directories
 # we don't want to check (depends on variables KASAN_SANITIZE_obj.o, KASAN_SANITIZE)
diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index d16d0ace2775..836c2289b8d8 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -743,6 +743,8 @@ static const char *const section_white_list[] =
 	".gnu.lto*",
 	".discard.*",
 	".llvm.call-graph-profile",	/* call graph */
+	"__llvm_covfun",
+	"__llvm_covmap",
 	NULL
 };
 
-- 
2.45.2


