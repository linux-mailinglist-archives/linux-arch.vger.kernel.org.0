Return-Path: <linux-arch+bounces-12268-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC9EAD0F4C
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1411C166290
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BE217F33;
	Sat,  7 Jun 2025 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tl0d//6C"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F595217660;
	Sat,  7 Jun 2025 20:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749326849; cv=none; b=EAgQtJijrCg+qUEt2qGonKqtcuP/HZgrJ/M2oYizlYlJ4OMVVi3781mq4hwe0UevsBddsoc8k2DHu6+sZ/PyVn2NUpEpIaI1FuSKOmS33iQrUyPJr4GZygMrujDP4a6t6oezhoxu9DqtF5PqmIDTdsB22e6Ro7H653/Su8Mxe/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749326849; c=relaxed/simple;
	bh=ul+IYG3QWn7TMt6jwp439C6v/yOYv8veAHOVkfUu8l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tcYLmnFmTApYAmmguwONd2kcZdNv97kmertX9oqsji6wQZW03a64yCB8ae8HlWTr1/r/6cdvxPxJhrX63e3G4AvqPuQeNJEAc6IKdbiSiWVybT3EoDijceXqO4efzmxjK1LX2EDeEGqgn1Wm3Que1JED7V9K9VUpUoAqsWXwlJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tl0d//6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4418FC4CEF0;
	Sat,  7 Jun 2025 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749326848;
	bh=ul+IYG3QWn7TMt6jwp439C6v/yOYv8veAHOVkfUu8l4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Tl0d//6CPdPlG3/4K4xGeIeOptjkdCK+LvF1RDYSDJB4TuDkHyzyAFAy+0o8jdYQD
	 ZWO9MtQqxMp+mvgQFYw51Ub/8YitCHjeMaLDttKZ6869jmFQlDCdxOwq5Ju93rJEA1
	 gfLxWzTirOtlQ++xq8LkB5J2fLk0Ueme2p96jnVzKOeDYv0NZTetnjR2Ea8BfpIKFu
	 lR8dnWC/fbq55jPpeIpU9aLLrGT805No7GgA6KRHsqhF0iSJg0+TCkvEdxXYgM54th
	 KGHrYoe4ZCXLd20Ai4X/asdmD4ikmulcOEmMj3hcnUyXWd6JcdP1uwfwEni1zc6C7y
	 TT61g4vhWl6BQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	linux-arch@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH v2 01/12] lib/crc: move files into lib/crc/
Date: Sat,  7 Jun 2025 13:04:43 -0700
Message-ID: <20250607200454.73587-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250607200454.73587-1-ebiggers@kernel.org>
References: <20250607200454.73587-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Move all CRC files in lib/ into a subdirectory lib/crc/ to keep them
from cluttering up the main lib/ directory.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 Documentation/core-api/kernel-api.rst |  14 ++--
 MAINTAINERS                           |   3 +-
 include/linux/crc64.h                 |   3 -
 lib/Kconfig                           |  87 +-------------------
 lib/Kconfig.debug                     |  21 -----
 lib/Makefile                          |  32 +-------
 lib/crc/.gitignore                    |   5 ++
 lib/crc/Kconfig                       | 111 ++++++++++++++++++++++++++
 lib/crc/Makefile                      |  32 ++++++++
 lib/{ => crc}/crc-ccitt.c             |   3 -
 lib/{ => crc}/crc-itu-t.c             |   0
 lib/{ => crc}/crc-t10dif.c            |   0
 lib/{ => crc}/crc16.c                 |   0
 lib/{ => crc}/crc32.c                 |   0
 lib/{ => crc}/crc4.c                  |   0
 lib/{ => crc}/crc64.c                 |   0
 lib/{ => crc}/crc7.c                  |   0
 lib/{ => crc}/crc8.c                  |   0
 lib/{ => crc}/gen_crc32table.c        |   4 +-
 lib/{ => crc}/gen_crc64table.c        |  11 +--
 lib/crc/tests/Makefile                |   2 +
 lib/{ => crc}/tests/crc_kunit.c       |   0
 lib/tests/Makefile                    |   1 -
 23 files changed, 164 insertions(+), 165 deletions(-)
 create mode 100644 lib/crc/.gitignore
 create mode 100644 lib/crc/Kconfig
 create mode 100644 lib/crc/Makefile
 rename lib/{ => crc}/crc-ccitt.c (98%)
 rename lib/{ => crc}/crc-itu-t.c (100%)
 rename lib/{ => crc}/crc-t10dif.c (100%)
 rename lib/{ => crc}/crc16.c (100%)
 rename lib/{ => crc}/crc32.c (100%)
 rename lib/{ => crc}/crc4.c (100%)
 rename lib/{ => crc}/crc64.c (100%)
 rename lib/{ => crc}/crc7.c (100%)
 rename lib/{ => crc}/crc8.c (100%)
 rename lib/{ => crc}/gen_crc32table.c (95%)
 rename lib/{ => crc}/gen_crc64table.c (81%)
 create mode 100644 lib/crc/tests/Makefile
 rename lib/{ => crc}/tests/crc_kunit.c (100%)

diff --git a/Documentation/core-api/kernel-api.rst b/Documentation/core-api/kernel-api.rst
index ae92a2571388a..c4642d9f13a9c 100644
--- a/Documentation/core-api/kernel-api.rst
+++ b/Documentation/core-api/kernel-api.rst
@@ -134,28 +134,28 @@ Arithmetic Overflow Checking
    :internal:
 
 CRC Functions
 -------------
 
-.. kernel-doc:: lib/crc4.c
+.. kernel-doc:: lib/crc/crc4.c
    :export:
 
-.. kernel-doc:: lib/crc7.c
+.. kernel-doc:: lib/crc/crc7.c
    :export:
 
-.. kernel-doc:: lib/crc8.c
+.. kernel-doc:: lib/crc/crc8.c
    :export:
 
-.. kernel-doc:: lib/crc16.c
+.. kernel-doc:: lib/crc/crc16.c
    :export:
 
-.. kernel-doc:: lib/crc32.c
+.. kernel-doc:: lib/crc/crc32.c
 
-.. kernel-doc:: lib/crc-ccitt.c
+.. kernel-doc:: lib/crc/crc-ccitt.c
    :export:
 
-.. kernel-doc:: lib/crc-itu-t.c
+.. kernel-doc:: lib/crc/crc-itu-t.c
    :export:
 
 Base 2 log and power Functions
 ------------------------------
 
diff --git a/MAINTAINERS b/MAINTAINERS
index 44c70071acb08..05ff204b016c5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6358,12 +6358,11 @@ L:	linux-crypto@vger.kernel.org
 S:	Maintained
 T:	git https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git crc-next
 F:	Documentation/staging/crc*
 F:	arch/*/lib/crc*
 F:	include/linux/crc*
-F:	lib/crc*
-F:	lib/tests/crc_kunit.c
+F:	lib/crc/
 F:	scripts/gen-crc-consts.py
 
 CREATIVE SB0540
 M:	Bastien Nocera <hadess@hadess.net>
 L:	linux-input@vger.kernel.org
diff --git a/include/linux/crc64.h b/include/linux/crc64.h
index 41de30b907dff..b6aa290a79312 100644
--- a/include/linux/crc64.h
+++ b/include/linux/crc64.h
@@ -1,9 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-/*
- * See lib/crc64.c for the related specification and polynomial arithmetic.
- */
 #ifndef _LINUX_CRC64_H
 #define _LINUX_CRC64_H
 
 #include <linux/types.h>
 
diff --git a/lib/Kconfig b/lib/Kconfig
index 6c1b8f1842678..3db88ab0d2b4c 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -134,98 +134,13 @@ config TRACE_MMIO_ACCESS
 	depends on TRACING && ARCH_HAVE_TRACE_MMIO_ACCESS
 	help
 	  Create tracepoints for MMIO read/write operations. These trace events
 	  can be used for logging all MMIO read/write operations.
 
+source "lib/crc/Kconfig"
 source "lib/crypto/Kconfig"
 
-config CRC_CCITT
-	tristate
-	help
-	  The CRC-CCITT library functions.  Select this if your module uses any
-	  of the functions from <linux/crc-ccitt.h>.
-
-config CRC16
-	tristate
-	help
-	  The CRC16 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc16.h>.
-
-config CRC_T10DIF
-	tristate
-	help
-	  The CRC-T10DIF library functions.  Select this if your module uses
-	  any of the functions from <linux/crc-t10dif.h>.
-
-config ARCH_HAS_CRC_T10DIF
-	bool
-
-config CRC_T10DIF_ARCH
-	tristate
-	default CRC_T10DIF if ARCH_HAS_CRC_T10DIF && CRC_OPTIMIZATIONS
-
-config CRC_ITU_T
-	tristate
-	help
-	  The CRC-ITU-T library functions.  Select this if your module uses
-	  any of the functions from <linux/crc-itu-t.h>.
-
-config CRC32
-	tristate
-	select BITREVERSE
-	help
-	  The CRC32 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc32.h> or <linux/crc32c.h>.
-
-config ARCH_HAS_CRC32
-	bool
-
-config CRC32_ARCH
-	tristate
-	default CRC32 if ARCH_HAS_CRC32 && CRC_OPTIMIZATIONS
-
-config CRC64
-	tristate
-	help
-	  The CRC64 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc64.h>.
-
-config ARCH_HAS_CRC64
-	bool
-
-config CRC64_ARCH
-	tristate
-	default CRC64 if ARCH_HAS_CRC64 && CRC_OPTIMIZATIONS
-
-config CRC4
-	tristate
-	help
-	  The CRC4 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc4.h>.
-
-config CRC7
-	tristate
-	help
-	  The CRC7 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc7.h>.
-
-config CRC8
-	tristate
-	help
-	  The CRC8 library functions.  Select this if your module uses any of
-	  the functions from <linux/crc8.h>.
-
-config CRC_OPTIMIZATIONS
-	bool "Enable optimized CRC implementations" if EXPERT
-	default y
-	help
-	  Disabling this option reduces code size slightly by disabling the
-	  architecture-optimized implementations of any CRC variants that are
-	  enabled.  CRC checksumming performance may get much slower.
-
-	  Keep this enabled unless you're really trying to minimize the size of
-	  the kernel.
 
 config XXHASH
 	tristate
 
 config AUDIT_GENERIC
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ebe33181b6e6e..3fda96761adbc 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2899,31 +2899,10 @@ config HW_BREAKPOINT_KUNIT_TEST
 	help
 	  Tests for hw_breakpoint constraints accounting.
 
 	  If unsure, say N.
 
-config CRC_KUNIT_TEST
-	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
-	depends on KUNIT
-	default KUNIT_ALL_TESTS
-	select CRC7
-	select CRC16
-	select CRC_T10DIF
-	select CRC32
-	select CRC64
-	help
-	  Unit tests for the CRC library functions.
-
-	  This is intended to help people writing architecture-specific
-	  optimized versions.  If unsure, say N.
-
-config CRC_BENCHMARK
-	bool "Benchmark for the CRC functions"
-	depends on CRC_KUNIT_TEST
-	help
-	  Include benchmarks in the KUnit test suite for the CRC functions.
-
 config SIPHASH_KUNIT_TEST
 	tristate "Perform selftest on siphash functions" if !KUNIT_ALL_TESTS
 	depends on KUNIT
 	default KUNIT_ALL_TESTS
 	help
diff --git a/lib/Makefile b/lib/Makefile
index c38582f187dd8..14a5928bb57f5 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -120,11 +120,11 @@ CFLAGS_kobject_uevent.o += -DDEBUG
 endif
 
 obj-$(CONFIG_DEBUG_INFO_REDUCED) += debug_info.o
 CFLAGS_debug_info.o += $(call cc-option, -femit-struct-debug-detailed=any)
 
-obj-y += math/ crypto/ tests/ vdso/
+obj-y += math/ crc/ crypto/ tests/ vdso/
 
 obj-$(CONFIG_GENERIC_IOMAP) += iomap.o
 obj-$(CONFIG_HAS_IOMEM) += iomap_copy.o devres.o
 obj-$(CONFIG_CHECK_SIGNATURE) += check_signature.o
 obj-$(CONFIG_DEBUG_LOCKING_API_SELFTESTS) += locking-selftest.o
@@ -146,19 +146,10 @@ obj-$(CONFIG_DEBUG_OBJECTS) += debugobjects.o
 
 obj-$(CONFIG_BITREVERSE) += bitrev.o
 obj-$(CONFIG_LINEAR_RANGES) += linear_ranges.o
 obj-$(CONFIG_PACKING)	+= packing.o
 obj-$(CONFIG_PACKING_KUNIT_TEST) += packing_test.o
-obj-$(CONFIG_CRC_CCITT)	+= crc-ccitt.o
-obj-$(CONFIG_CRC16)	+= crc16.o
-obj-$(CONFIG_CRC_T10DIF)+= crc-t10dif.o
-obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
-obj-$(CONFIG_CRC32)	+= crc32.o
-obj-$(CONFIG_CRC64)     += crc64.o
-obj-$(CONFIG_CRC4)	+= crc4.o
-obj-$(CONFIG_CRC7)	+= crc7.o
-obj-$(CONFIG_CRC8)	+= crc8.o
 obj-$(CONFIG_XXHASH)	+= xxhash.o
 obj-$(CONFIG_GENERIC_ALLOCATOR) += genalloc.o
 
 obj-$(CONFIG_842_COMPRESS) += 842/
 obj-$(CONFIG_842_DECOMPRESS) += 842/
@@ -292,31 +283,10 @@ obj-$(CONFIG_PERCPU_TEST) += percpu_test.o
 obj-$(CONFIG_ASN1) += asn1_decoder.o
 obj-$(CONFIG_ASN1_ENCODER) += asn1_encoder.o
 
 obj-$(CONFIG_FONT_SUPPORT) += fonts/
 
-hostprogs	:= gen_crc32table
-hostprogs	+= gen_crc64table
-clean-files	:= crc32table.h
-clean-files	+= crc64table.h
-
-$(obj)/crc32.o: $(obj)/crc32table.h
-
-quiet_cmd_crc32 = GEN     $@
-      cmd_crc32 = $< > $@
-
-$(obj)/crc32table.h: $(obj)/gen_crc32table
-	$(call cmd,crc32)
-
-$(obj)/crc64.o: $(obj)/crc64table.h
-
-quiet_cmd_crc64 = GEN     $@
-      cmd_crc64 = $< > $@
-
-$(obj)/crc64table.h: $(obj)/gen_crc64table
-	$(call cmd,crc64)
-
 #
 # Build a fast OID lookip registry from include/linux/oid_registry.h
 #
 obj-$(CONFIG_OID_REGISTRY) += oid_registry.o
 
diff --git a/lib/crc/.gitignore b/lib/crc/.gitignore
new file mode 100644
index 0000000000000..a9e48103c9fb1
--- /dev/null
+++ b/lib/crc/.gitignore
@@ -0,0 +1,5 @@
+# SPDX-License-Identifier: GPL-2.0-only
+/crc32table.h
+/crc64table.h
+/gen_crc32table
+/gen_crc64table
diff --git a/lib/crc/Kconfig b/lib/crc/Kconfig
new file mode 100644
index 0000000000000..e0e7168b74c75
--- /dev/null
+++ b/lib/crc/Kconfig
@@ -0,0 +1,111 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Kconfig for the kernel's cyclic redundancy check (CRC) library code
+
+config CRC4
+	tristate
+	help
+	  The CRC4 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc4.h>.
+
+config CRC7
+	tristate
+	help
+	  The CRC7 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc7.h>.
+
+config CRC8
+	tristate
+	help
+	  The CRC8 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc8.h>.
+
+config CRC16
+	tristate
+	help
+	  The CRC16 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc16.h>.
+
+config CRC_CCITT
+	tristate
+	help
+	  The CRC-CCITT library functions.  Select this if your module uses any
+	  of the functions from <linux/crc-ccitt.h>.
+
+config CRC_ITU_T
+	tristate
+	help
+	  The CRC-ITU-T library functions.  Select this if your module uses
+	  any of the functions from <linux/crc-itu-t.h>.
+
+config CRC_T10DIF
+	tristate
+	help
+	  The CRC-T10DIF library functions.  Select this if your module uses
+	  any of the functions from <linux/crc-t10dif.h>.
+
+config ARCH_HAS_CRC_T10DIF
+	bool
+
+config CRC_T10DIF_ARCH
+	tristate
+	default CRC_T10DIF if ARCH_HAS_CRC_T10DIF && CRC_OPTIMIZATIONS
+
+config CRC32
+	tristate
+	select BITREVERSE
+	help
+	  The CRC32 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc32.h> or <linux/crc32c.h>.
+
+config ARCH_HAS_CRC32
+	bool
+
+config CRC32_ARCH
+	tristate
+	default CRC32 if ARCH_HAS_CRC32 && CRC_OPTIMIZATIONS
+
+config CRC64
+	tristate
+	help
+	  The CRC64 library functions.  Select this if your module uses any of
+	  the functions from <linux/crc64.h>.
+
+config ARCH_HAS_CRC64
+	bool
+
+config CRC64_ARCH
+	tristate
+	default CRC64 if ARCH_HAS_CRC64 && CRC_OPTIMIZATIONS
+
+config CRC_OPTIMIZATIONS
+	bool "Enable optimized CRC implementations" if EXPERT
+	default y
+	help
+	  Disabling this option reduces code size slightly by disabling the
+	  architecture-optimized implementations of any CRC variants that are
+	  enabled.  CRC checksumming performance may get much slower.
+
+	  Keep this enabled unless you're really trying to minimize the size of
+	  the kernel.
+
+config CRC_KUNIT_TEST
+	tristate "KUnit tests for CRC functions" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	select CRC7
+	select CRC16
+	select CRC_T10DIF
+	select CRC32
+	select CRC64
+	help
+	  Unit tests for the CRC library functions.
+
+	  This is intended to help people writing architecture-specific
+	  optimized versions.  If unsure, say N.
+
+config CRC_BENCHMARK
+	bool "Benchmark for the CRC functions"
+	depends on CRC_KUNIT_TEST
+	help
+	  Include benchmarks in the KUnit test suite for the CRC functions.
diff --git a/lib/crc/Makefile b/lib/crc/Makefile
new file mode 100644
index 0000000000000..ff4c30dda4528
--- /dev/null
+++ b/lib/crc/Makefile
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: GPL-2.0-only
+
+# Makefile for the kernel's cyclic redundancy check (CRC) library code
+
+obj-$(CONFIG_CRC4) += crc4.o
+obj-$(CONFIG_CRC7) += crc7.o
+obj-$(CONFIG_CRC8) += crc8.o
+obj-$(CONFIG_CRC16) += crc16.o
+obj-$(CONFIG_CRC_CCITT) += crc-ccitt.o
+obj-$(CONFIG_CRC_ITU_T) += crc-itu-t.o
+obj-$(CONFIG_CRC_T10DIF) += crc-t10dif.o
+obj-$(CONFIG_CRC32) += crc32.o
+obj-$(CONFIG_CRC64) += crc64.o
+obj-y += tests/
+
+hostprogs := gen_crc32table gen_crc64table
+clean-files := crc32table.h crc64table.h
+
+$(obj)/crc32.o: $(obj)/crc32table.h
+$(obj)/crc64.o: $(obj)/crc64table.h
+
+quiet_cmd_crc32 = GEN     $@
+      cmd_crc32 = $< > $@
+
+quiet_cmd_crc64 = GEN     $@
+      cmd_crc64 = $< > $@
+
+$(obj)/crc32table.h: $(obj)/gen_crc32table
+	$(call cmd,crc32)
+
+$(obj)/crc64table.h: $(obj)/gen_crc64table
+	$(call cmd,crc64)
diff --git a/lib/crc-ccitt.c b/lib/crc/crc-ccitt.c
similarity index 98%
rename from lib/crc-ccitt.c
rename to lib/crc/crc-ccitt.c
index 9cddf35d3b66e..8d2bc419230b3 100644
--- a/lib/crc-ccitt.c
+++ b/lib/crc/crc-ccitt.c
@@ -1,9 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
-/*
- *	linux/lib/crc-ccitt.c
- */
 
 #include <linux/types.h>
 #include <linux/module.h>
 #include <linux/crc-ccitt.h>
 
diff --git a/lib/crc-itu-t.c b/lib/crc/crc-itu-t.c
similarity index 100%
rename from lib/crc-itu-t.c
rename to lib/crc/crc-itu-t.c
diff --git a/lib/crc-t10dif.c b/lib/crc/crc-t10dif.c
similarity index 100%
rename from lib/crc-t10dif.c
rename to lib/crc/crc-t10dif.c
diff --git a/lib/crc16.c b/lib/crc/crc16.c
similarity index 100%
rename from lib/crc16.c
rename to lib/crc/crc16.c
diff --git a/lib/crc32.c b/lib/crc/crc32.c
similarity index 100%
rename from lib/crc32.c
rename to lib/crc/crc32.c
diff --git a/lib/crc4.c b/lib/crc/crc4.c
similarity index 100%
rename from lib/crc4.c
rename to lib/crc/crc4.c
diff --git a/lib/crc64.c b/lib/crc/crc64.c
similarity index 100%
rename from lib/crc64.c
rename to lib/crc/crc64.c
diff --git a/lib/crc7.c b/lib/crc/crc7.c
similarity index 100%
rename from lib/crc7.c
rename to lib/crc/crc7.c
diff --git a/lib/crc8.c b/lib/crc/crc8.c
similarity index 100%
rename from lib/crc8.c
rename to lib/crc/crc8.c
diff --git a/lib/gen_crc32table.c b/lib/crc/gen_crc32table.c
similarity index 95%
rename from lib/gen_crc32table.c
rename to lib/crc/gen_crc32table.c
index 6d03425b849e4..9a7f31658e355 100644
--- a/lib/gen_crc32table.c
+++ b/lib/crc/gen_crc32table.c
@@ -1,9 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <stdio.h>
-#include "../include/linux/crc32poly.h"
-#include "../include/generated/autoconf.h"
+#include "../../include/linux/crc32poly.h"
+#include "../../include/generated/autoconf.h"
 #include <inttypes.h>
 
 static uint32_t crc32table_le[256];
 static uint32_t crc32table_be[256];
 static uint32_t crc32ctable_le[256];
diff --git a/lib/gen_crc64table.c b/lib/crc/gen_crc64table.c
similarity index 81%
rename from lib/gen_crc64table.c
rename to lib/crc/gen_crc64table.c
index e05a4230a0a08..f2be9f62bab71 100644
--- a/lib/gen_crc64table.c
+++ b/lib/crc/gen_crc64table.c
@@ -1,16 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Generate lookup table for the table-driven CRC64 calculation.
- *
- * gen_crc64table is executed in kernel build time and generates
- * lib/crc64table.h. This header is included by lib/crc64.c for
- * the table-driven CRC64 calculation.
- *
- * See lib/crc64.c for more information about which specification
- * and polynomial arithmetic that gen_crc64table.c follows to
- * generate the lookup table.
+ * This host program runs at kernel build time and generates the lookup tables
+ * used by the generic CRC64 code.
  *
  * Copyright 2018 SUSE Linux.
  *   Author: Coly Li <colyli@suse.de>
  */
 #include <inttypes.h>
diff --git a/lib/crc/tests/Makefile b/lib/crc/tests/Makefile
new file mode 100644
index 0000000000000..65f63c318ef5e
--- /dev/null
+++ b/lib/crc/tests/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
diff --git a/lib/tests/crc_kunit.c b/lib/crc/tests/crc_kunit.c
similarity index 100%
rename from lib/tests/crc_kunit.c
rename to lib/crc/tests/crc_kunit.c
diff --git a/lib/tests/Makefile b/lib/tests/Makefile
index 56d6450144828..741d3ac2cba25 100644
--- a/lib/tests/Makefile
+++ b/lib/tests/Makefile
@@ -8,11 +8,10 @@ obj-$(CONFIG_BITFIELD_KUNIT) += bitfield_kunit.o
 obj-$(CONFIG_BITS_TEST) += test_bits.o
 obj-$(CONFIG_BLACKHOLE_DEV_KUNIT_TEST) += blackhole_dev_kunit.o
 obj-$(CONFIG_CHECKSUM_KUNIT) += checksum_kunit.o
 obj-$(CONFIG_CMDLINE_KUNIT_TEST) += cmdline_kunit.o
 obj-$(CONFIG_CPUMASK_KUNIT_TEST) += cpumask_kunit.o
-obj-$(CONFIG_CRC_KUNIT_TEST) += crc_kunit.o
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, unsequenced)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-overread)
 CFLAGS_fortify_kunit.o += $(call cc-disable-warning, stringop-truncation)
 CFLAGS_fortify_kunit.o += $(DISABLE_STRUCTLEAK_PLUGIN)
 obj-$(CONFIG_FORTIFY_KUNIT_TEST) += fortify_kunit.o
-- 
2.49.0


