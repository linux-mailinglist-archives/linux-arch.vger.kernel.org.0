Return-Path: <linux-arch+bounces-9487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2E29FC6B4
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 23:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751C51882F93
	for <lists+linux-arch@lfdr.de>; Wed, 25 Dec 2024 22:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7A41C3C13;
	Wed, 25 Dec 2024 22:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="CWnYDt/W"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B001B87DE;
	Wed, 25 Dec 2024 22:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735167170; cv=none; b=clRQQ+RkQXNT17rDp7ieDeZt4upYMeIiV1RHtNuINwf9Nfw3JjV1ahPdRbVx3O2RD5uJLuUfg4NSmaYCeZo4n1a0L/F+0UToP/c4KE/dAci2lfAFrfrIQry8lovt7UyPRDfwgJwbeMZ+b7iyJGy0vAj8GKv9Ox2FrGfrjob+nqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735167170; c=relaxed/simple;
	bh=PD9l3Aac0xNz7o1+KN157XmkKft4FMj2xHjo8gW3jf8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PTwfCrW7k6pwg2AGy4IO4CuEH3jpgJU9h3FhtgWbhyjxQSyRUhRD4uXTMZCF2WMvd1X7pMYisXuKEt8jKI6v5mRlysjuqLbaR+3GQuHwGzOMcqYxWjS2T/22JYKe21IcCOF7QHh+NLBMaS26S+CtrVh2cKyGPlxVFU2mHeI0z/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=CWnYDt/W; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1735167158;
	bh=PD9l3Aac0xNz7o1+KN157XmkKft4FMj2xHjo8gW3jf8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CWnYDt/WoYXBdKu2tVsdAc2RMFy5u0Nptyr1xLO4sZ9CgTixfnB4LLFgRc3D1Xxw4
	 HZMcGqhasClMQQPPaZoxDdWX+FJ4z7GyP9udtAZiR8o8d6J7b/Fm3XeF+HTBSrTcjS
	 F4TDMMmnjp/hgd4yXBD4xPoCOy/OyKEJcIFV7xN0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Wed, 25 Dec 2024 23:52:00 +0100
Subject: [PATCH RFC 2/2] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241225-module-hashes-v1-2-d710ce7a3fd1@weissschuh.net>
References: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
In-Reply-To: <20241225-module-hashes-v1-0-d710ce7a3fd1@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1735167158; l=11659;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PD9l3Aac0xNz7o1+KN157XmkKft4FMj2xHjo8gW3jf8=;
 b=2PTkN058pqeVRit4SERCyfRjKTtstAiOnU+KmcR5W7Emu7eC3nAWVNlVMv0Ih5IyTDXRz3ZA3
 hz2eLb8JbE5BAMHHttO7eUp0Q8RNFNofwX3Whgw8ug0GPR6q5T60QF7
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds:
Either the module signing key is generated at build time, which makes
the build unreproducible, or a static key is used, which precludes
rebuilds by third parties and makes the whole build and packaging
process much more complicated.
Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a list of hashes of all modules built as part of the full
kernel build into vmlinux.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 Makefile                          |  8 +++++-
 include/asm-generic/vmlinux.lds.h | 11 +++++++++
 include/linux/module_hashes.h     | 17 +++++++++++++
 kernel/module/Kconfig             | 11 +++++++++
 kernel/module/Makefile            |  1 +
 kernel/module/hashes.c            | 51 +++++++++++++++++++++++++++++++++++++++
 kernel/module/internal.h          |  9 +++++++
 kernel/module/main.c              |  4 +++
 scripts/Makefile.vmlinux          |  5 ++++
 scripts/link-vmlinux.sh           | 25 ++++++++++++++++++-
 scripts/module-hashes.sh          | 26 ++++++++++++++++++++
 11 files changed, 166 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 5c9b1d2d59b4dc3d78ce01d917f9f47ab0c0adb6..359cd459440cd1037ecebe660e09f0058a62f49d 100644
--- a/Makefile
+++ b/Makefile
@@ -1535,8 +1535,10 @@ endif
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := 1
+ifndef CONFIG_MODULE_HASHES
 modules: vmlinux
 endif
+endif
 
 modules: modules_prepare
 
@@ -1916,7 +1918,11 @@ modules.order: $(build-dir)
 # KBUILD_MODPOST_NOFINAL can be set to skip the final link of modules.
 # This is solely useful to speed up test compiles.
 modules: modpost
-ifneq ($(KBUILD_MODPOST_NOFINAL),1)
+ifdef CONFIG_MODULE_HASHES
+ifeq ($(MODULE_HASHES_MODPOST_FINAL), 1)
+	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
+endif
+else ifneq ($(KBUILD_MODPOST_NOFINAL),1)
 	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modfinal
 endif
 
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 54504013c74915c2ed923fb3afde024a69cdae6b..aebea528aac3d7209bcee12c25f750ab0f7576a5 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -486,6 +486,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 									\
 	PRINTK_INDEX							\
 									\
+	MODULE_HASHES							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
@@ -895,6 +897,15 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #define PRINTK_INDEX
 #endif
 
+#ifdef CONFIG_MODULE_HASHES
+#define MODULE_HASHES							\
+	.module_hashes : AT(ADDR(.module_hashes) - LOAD_OFFSET) {	\
+	BOUNDED_SECTION_BY(.module_hashes, _module_hashes)		\
+	}
+#else
+#define MODULE_HASHES
+#endif
+
 /*
  * Discard .note.GNU-stack, which is emitted as PROGBITS by the compiler.
  * Otherwise, the type of .notes section would become PROGBITS instead of NOTES.
diff --git a/include/linux/module_hashes.h b/include/linux/module_hashes.h
new file mode 100644
index 0000000000000000000000000000000000000000..5f2f0546e3875e6bc73bdd53aebaada7371b7f79
--- /dev/null
+++ b/include/linux/module_hashes.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+
+#ifndef _LINUX_MODULE_HASHES_H
+#define _LINUX_MODULE_HASHES_H
+
+#include <linux/compiler_attributes.h>
+#include <linux/types.h>
+#include <crypto/sha2.h>
+
+#define __module_hashes_section __section(".module_hashes")
+#define MODULE_HASHES_HASH_SIZE SHA256_DIGEST_SIZE
+
+extern const u8 module_hashes[][MODULE_HASHES_HASH_SIZE];
+
+extern const typeof(module_hashes[0]) __start_module_hashes, __stop_module_hashes;
+
+#endif /* _LINUX_MODULE_HASHES_H */
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..57d317a6fa444195d0806e6bd7a2af6e338a7f01 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -344,6 +344,17 @@ config MODULE_DECOMPRESS
 
 	  If unsure, say N.
 
+config MODULE_HASHES
+	bool "Module hash validation"
+	depends on !MODULE_SIG
+	select CRYPTO_LIB_SHA256
+	help
+	  Validate modules by their hashes.
+	  Only modules built together with the main kernel image can be
+	  validated that way.
+
+	  Also see the warning in MODULE_SIG about stripping modules.
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index 50ffcc413b54504db946af4dce3b41dc4aece1a5..6fe0c14ca5a05b49c1161fcfa8aaa130f89b70e1 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+obj-$(CONFIG_MODULE_HASHES) += hashes.o
diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
new file mode 100644
index 0000000000000000000000000000000000000000..f19eccb0e3754e3edbf5cdea6d418da5c6ae6c65
--- /dev/null
+++ b/kernel/module/hashes.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#define pr_fmt(fmt) "module/hash: " fmt
+
+#include <linux/int_log.h>
+#include <linux/module_hashes.h>
+#include <linux/module.h>
+#include <crypto/sha2.h>
+#include "internal.h"
+
+static inline size_t module_hashes_count(void)
+{
+	return (__stop_module_hashes - __start_module_hashes) / MODULE_HASHES_HASH_SIZE;
+}
+
+static __init __maybe_unused int module_hashes_init(void)
+{
+	size_t num_hashes = module_hashes_count();
+	int num_width = (intlog10(num_hashes) >> 24) + 1;
+	size_t i;
+
+	pr_debug("Builtin hashes (%zu):\n", num_hashes);
+
+	for (i = 0; i < num_hashes; i++)
+		pr_debug("%*zu %*phN\n", num_width, i,
+			 (int)sizeof(module_hashes[i]), module_hashes[i]);
+
+	return 0;
+}
+
+#ifdef DEBUG
+early_initcall(module_hashes_init);
+#endif
+
+int module_hash_check(struct load_info *info, int flags)
+{
+	u8 digest[MODULE_HASHES_HASH_SIZE];
+	size_t i;
+
+	sha256((const u8 *)info->hdr, info->len, digest);
+
+	for (i = 0; i < module_hashes_count(); i++) {
+		if (memcmp(module_hashes[i], digest, MODULE_HASHES_HASH_SIZE) == 0) {
+			pr_debug("allow %*phN\n", (int)sizeof(digest), digest);
+			return 0;
+		}
+	}
+
+	pr_debug("block %*phN\n", (int)sizeof(digest), digest);
+	return -ENOKEY;
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index daef2be8390222c22220e2f168baa8d35ad531b9..418fc4eaadd7070915ed20c3213a78937841b352 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -342,6 +342,15 @@ static inline int module_sig_check(struct load_info *info, int flags)
 }
 #endif /* !CONFIG_MODULE_SIG */
 
+#ifdef CONFIG_MODULE_HASHES
+int module_hash_check(struct load_info *info, int flags);
+#else /* !CONFIG_MODULE_HASHES */
+static inline int module_hash_check(struct load_info *info, int flags)
+{
+	return 0;
+}
+#endif /* !CONFIG_MODULE_HASHES */
+
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
 #else /* !CONFIG_DEBUG_KMEMLEAK */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cbed2dbeea0291f717f30358d8e7fc..008415c21c72dfa45953a9ac6dfc0507650e18ca 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3242,6 +3242,10 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	if (err)
 		goto free_copy;
 
+	err = module_hash_check(info, flags);
+	if (err)
+		goto free_copy;
+
 	/*
 	 * Do basic sanity checks against the ELF header and
 	 * sections. Cache useful sections and set the
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index 873caaa553134e09d034e0c4e0ac7f07c9e3f31b..4b6ba03cdd5e4faad30a0b533407955c542c7a20 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -79,6 +79,11 @@ ifdef CONFIG_DEBUG_INFO_BTF
 vmlinux: $(RESOLVE_BTFIDS)
 endif
 
+ifdef CONFIG_MODULE_HASHES
+vmlinux: $(srctree)/scripts/module-hashes.sh
+vmlinux: modules.order
+endif
+
 # module.builtin.ranges
 # ---------------------------------------------------------------------------
 ifdef CONFIG_BUILTIN_MODULE_RANGES
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 803c8d6f35a7f29fb68b29afa8546f4dde0bd4cb..db072e4e5d6581453a009a9e837042ba28a138ce 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -104,7 +104,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${module_hashes_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -215,6 +215,7 @@ fi
 
 btf_vmlinux_bin_o=
 kallsymso=
+module_hashes_o=
 strip_debug=
 
 if is_enabled CONFIG_KALLSYMS; then
@@ -222,6 +223,17 @@ if is_enabled CONFIG_KALLSYMS; then
 	kallsyms .tmp_vmlinux0.syms .tmp_vmlinux0.kallsyms
 fi
 
+if is_enabled CONFIG_MODULE_HASHES; then
+	# At this point the hashes are still wrong.
+	# This step reserves the exact amount of space for the objcopy step
+	# after BTF generation.
+	${srctree}/scripts/module-hashes.sh prealloc > .tmp_module_hashes.c
+	module_hashes_o=.tmp_module_hashes.o
+	info CC ${module_hashes_o}
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} \
+		${KBUILD_CFLAGS_KERNEL} -c -o "${module_hashes_o}" ".tmp_module_hashes.c"
+fi
+
 if is_enabled CONFIG_KALLSYMS || is_enabled CONFIG_DEBUG_INFO_BTF; then
 
 	# The kallsyms linking does not need debug symbols, but the BTF does.
@@ -302,6 +314,17 @@ if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
 	fi
 fi
 
+if is_enabled CONFIG_MODULE_HASHES; then
+	info MAKE modules
+	${MAKE} -f Makefile MODULE_HASHES_MODPOST_FINAL=1 modules
+	${srctree}/scripts/module-hashes.sh > .tmp_module_hashes.c
+	info CC ${module_hashes_o}
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} \
+		${KBUILD_CFLAGS_KERNEL} -c -o "${module_hashes_o}" ".tmp_module_hashes.c"
+	${OBJCOPY} --dump-section .module_hashes=.tmp_module_hashes.bin ${module_hashes_o}
+	${OBJCOPY} --update-section .module_hashes=.tmp_module_hashes.bin vmlinux
+fi
+
 # step a (see comment above)
 if is_enabled CONFIG_KALLSYMS; then
 	if ! cmp -s System.map "${kallsyms_sysmap}"; then
diff --git a/scripts/module-hashes.sh b/scripts/module-hashes.sh
new file mode 100755
index 0000000000000000000000000000000000000000..7ca4e84f4c74266b9902d9f377aa2c901a06f995
--- /dev/null
+++ b/scripts/module-hashes.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-or-later
+
+set -e
+set -u
+set -o pipefail
+
+prealloc="${1:-}"
+
+echo "#include <linux/module_hashes.h>"
+echo
+echo "const u8 module_hashes[][MODULE_HASHES_HASH_SIZE] __module_hashes_section = {"
+
+for mod in $(< modules.order); do
+	mod="${mod/%.o/.ko}"
+	if [ "$prealloc" = "prealloc" ]; then
+		modhash=""
+	else
+		modhash="$(cksum -a sha256 --raw "$mod" | hexdump -v -e '"0x" 1/1 "%02x, "')"
+	fi
+	echo "	/* $mod */"
+	echo "	{ $modhash },"
+	echo
+done
+
+echo "};"

-- 
2.47.1


