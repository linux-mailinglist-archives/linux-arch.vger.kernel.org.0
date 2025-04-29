Return-Path: <linux-arch+bounces-11715-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A938BAA0CE7
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:07:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A7E11896259
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BAC72D3A82;
	Tue, 29 Apr 2025 13:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="UOiQVgPr"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D75E42D29A7;
	Tue, 29 Apr 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931891; cv=none; b=UXai3DBTUzRf1wYt4rFGYHAMudaT8AVFslwLvp9LXsaQJ66G0SCGk0NoSwFi8lHzIBjuh67CLSlUIAmH7r5r3clpJmzwoUrFebAZdHFfe5+ny4d/d0IO4AlUoIlIWgpc6Fg7c97P+WlQSNnIBGg5BwXbQ0lSiJAG0cZKLDMys60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931891; c=relaxed/simple;
	bh=l2dt6UnEWldajLPbUgoG/aPR9rbJ2ThISvj2I7Wsi9Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTmOl9Fbyzyhwa70OJuYSqvTjYY5aZRGUavKs0eCMxM5oYngukD3Pvng2koemgp72AnFSCdysdhMnCeJrQG9O6LC/mPS+4GAdNhqoDKOmE0EvHr/WbBlGBSiafB/TRLjlKgoH2UAOq4a11XWDXwAvpcMkWy76aDqrVpCINHwNlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=UOiQVgPr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931875;
	bh=l2dt6UnEWldajLPbUgoG/aPR9rbJ2ThISvj2I7Wsi9Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UOiQVgPrIT3u4dsR01kf0pJC1XJC8mkPAcB0nLMFFlQTFZaxKHaR6KRMHUV8FyTIV
	 M+jO1PRuMis+9kGlkSwDkVCEgKF3FQh2k1gklniv90JPfuLY9KbveiMXd3JcEEgw6W
	 GxByvlLKPVIoA9Lgd4ikGVnue3WPZtbbKB/1E/S0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:36 +0200
Subject: [PATCH v3 9/9] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-9-00e9258def9e@weissschuh.net>
References: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
In-Reply-To: <20250429-module-hashes-v3-0-00e9258def9e@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Christophe Leroy <christophe.leroy@csgroup.eu>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Nicolas Schier <nicolas.schier@linux.dev>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=16340;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=l2dt6UnEWldajLPbUgoG/aPR9rbJ2ThISvj2I7Wsi9Q=;
 b=G6+C/ycUNVhyZQ01uIVjVykLd1AbePRl3V0+iox5JkKzd6+0VbbkDBFh0cPRoA7/9PVHLetGe
 OPNJKEtREraC0wuMXMEAoiPO6cHePh+1QloP9z1JuYsx26EeVxXPLFz
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

Non-builtin modules can be validated as before through signatures.

Normally the .ko module files depend on a fully built vmlinux to be
available for modpost validation and BTF generation.
With CONFIG_MODULE_HASHES, vmlinux now depends on the modules
to embed their hashes.
This introduces a dependency cycle which does not work.
Work around this by building the modules during link-vmlinux.sh,
after vmlinux is complete enough for modpost and BTF but before the
final module hashes are added to vmlinux.

This mechanism increases the size of vmlinux by 32 bytes,
one sha256 digest, per module.
On a general-purpose distro kernel with ~6k modules this means a total
increase of memory usage of ~200KiB.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                                   |  1 +
 Documentation/kbuild/reproducible-builds.rst |  5 ++-
 Makefile                                     |  8 +++-
 include/asm-generic/vmlinux.lds.h            | 11 ++++++
 include/linux/module_hashes.h                | 17 +++++++++
 kernel/module/Kconfig                        | 17 ++++++++-
 kernel/module/Makefile                       |  1 +
 kernel/module/hashes.c                       | 56 ++++++++++++++++++++++++++++
 kernel/module/internal.h                     |  1 +
 kernel/module/main.c                         |  5 ++-
 scripts/Makefile.modfinal                    |  6 +++
 scripts/Makefile.modinst                     |  4 ++
 scripts/Makefile.vmlinux                     |  5 +++
 scripts/link-vmlinux.sh                      | 25 ++++++++++++-
 scripts/module-hashes.sh                     | 26 +++++++++++++
 security/lockdown/Kconfig                    |  2 +-
 16 files changed, 184 insertions(+), 6 deletions(-)

diff --git a/.gitignore b/.gitignore
index f2f63e47fb88686d5d5ab17d480c9301184134a9..ed55ce77be64a9769da7cc103ef56039648b8759 100644
--- a/.gitignore
+++ b/.gitignore
@@ -29,6 +29,7 @@
 *.gz
 *.i
 *.ko
+*.ko.hash
 *.lex.c
 *.ll
 *.lst
diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index a7762486c93fcd3eba08b836bed622a41e829e41..013265e9766c88e04fc775bbbb6d3de90c7346e4 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -64,7 +64,10 @@ generate a different temporary key for each build, resulting in the
 modules being unreproducible.  However, including a signing key with
 your source would presumably defeat the purpose of signing modules.
 
-One approach to this is to divide up the build process so that the
+Instead ``CONFIG_MODULE_HASHES`` can be used to embed a static list
+of valid modules to load.
+
+Another approach to this is to divide up the build process so that the
 unreproducible parts can be treated as sources:
 
 1. Generate a persistent signing key.  Add the certificate for the key
diff --git a/Makefile b/Makefile
index 38689a0c36052b4ea6541bff8b36048e9689578a..1d04a584d6993a33f7ceefa1bb52727919bb83d0 100644
--- a/Makefile
+++ b/Makefile
@@ -1551,8 +1551,10 @@ endif
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := 1
+ifndef CONFIG_MODULE_HASHES
 modules: vmlinux
 endif
+endif
 
 modules: modules_prepare
 
@@ -1933,7 +1935,11 @@ modules.order: $(build-dir)
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
index 58a635a6d5bdf0c53c267c2a3d21a5ed8678ce73..b45b2950c443a62f6086ed209851421c511e078b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -490,6 +490,8 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 									\
 	PRINTK_INDEX							\
 									\
+	MODULE_HASHES							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
@@ -899,6 +901,15 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
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
index a3146e9378fcd3292a756a2a7ea5241524cbc408..54702f24ace4cbd18ffaa6cf7fdb2936ebe8505d 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -267,7 +267,7 @@ config MODULE_SIG
 
 config MODULE_SIG_POLICY
 	def_bool y
-	depends on MODULE_SIG
+	depends on MODULE_SIG || MODULE_HASHES
 
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
@@ -404,6 +404,21 @@ config MODULE_DECOMPRESS
 
 	  If unsure, say N.
 
+config MODULE_HASHES
+	bool "Module hash validation"
+	depends on $(success,openssl dgst -sha256 -binary /dev/null)
+	select CRYPTO_LIB_SHA256
+	help
+	  Validate modules by their hashes.
+	  Only modules built together with the main kernel image can be
+	  validated that way.
+
+	  This is a reproducible-build compatible alternative to a build-time
+	  generated module keyring, as enabled by
+	  CONFIG_MODULE_SIG_KEY=certs/signing_key.pem.
+
+	  Also see the warning in MODULE_SIG about stripping modules.
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index d9e8759a7b05c2d716ab258ae3b55591f869cd52..b3c0bb7d327806726ab8a23d791513e1a0f92706 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+obj-$(CONFIG_MODULE_HASHES) += hashes.o
diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
new file mode 100644
index 0000000000000000000000000000000000000000..67481b1bb24eb61d364e802d2ab019a9b7f07348
--- /dev/null
+++ b/kernel/module/hashes.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Module hash-based integrity checker
+ *
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ */
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
+	int num_width = num_hashes ? (intlog10(num_hashes) >> 24) + 1 : 0;
+	size_t i;
+
+	pr_debug("Known hashes (%zu):\n", num_hashes);
+
+	for (i = 0; i < num_hashes; i++)
+		pr_debug("%*zu %*phN\n", num_width, i,
+			 (int)sizeof(module_hashes[i]), module_hashes[i]);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_MODULE_DEBUG)
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
+			info->sig_ok = true;
+			return 0;
+		}
+	}
+
+	pr_debug("block %*phN\n", (int)sizeof(digest), digest);
+	return -ENOKEY;
+}
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 42fbc53c6af66a1b531fcad08997742d838eb481..f0ecf7761760cc01e8ec42cde1b5d491be0ee4e3 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -326,6 +326,7 @@ int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
 int module_sig_check(struct load_info *info, int flags);
+int module_hash_check(struct load_info *info, int flags);
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 1c353ece05fd1d2d709204e4d5fa44ecb8832bfa..0daf19b494d3748a6156d0cb4c8eccfcff9154da 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3251,7 +3251,10 @@ static int module_integrity_check(struct load_info *info, int flags)
 {
 	int err = 0;
 
-	if (IS_ENABLED(CONFIG_MODULE_SIG))
+	if (IS_ENABLED(CONFIG_MODULE_HASHES))
+		err = module_hash_check(info, flags);
+
+	if (!info->sig_ok && IS_ENABLED(CONFIG_MODULE_SIG))
 		err = module_sig_check(info, flags);
 
 	if (err)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 527f6b27baff9db94d31c15447de445a05bc0634..cf915acba7ce457f4188415c1d8924922fcc3393 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -43,6 +43,9 @@ quiet_cmd_btf_ko = BTF [M] $@
 		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;		\
 	fi;
 
+quiet_cmd_cksum_ko =
+      cmd_cksum_ko = openssl dgst -sha256 -binary $@ > $@.hash
+
 # Same as newer-prereqs, but allows to exclude specified extra dependencies
 newer_prereqs_except = $(filter-out $(PHONY) $(1),$?)
 
@@ -57,6 +60,9 @@ if_changed_except = $(if $(call newer_prereqs_except,$(2))$(cmd-check),      \
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 	+$(if $(newer-prereqs),$(call cmd,btf_ko))
 endif
+ifdef CONFIG_MODULE_HASHES
+	$(call cmd,cksum_ko)
+endif
 
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
 
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 1628198f3e8309845adb48d5dbf66b700f9b6ebb..b2e207bacbac9437955d361cab91acdafaf8295f 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -79,6 +79,10 @@ quiet_cmd_install = INSTALL $@
 # as the options to the strip command.
 ifdef INSTALL_MOD_STRIP
 
+ifdef CONFIG_MODULE_HASHES
+$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+endif
+
 ifeq ($(INSTALL_MOD_STRIP),1)
 strip-option := --strip-debug
 else
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index b0a6cd5b818c9fe19d20f5ddf4908eb14b888ea9..0024a0de1f325daa21170b68a017ebb35b2a630a 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -97,6 +97,11 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
 vmlinux: scripts/sorttable
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
index 5f060787ce3fbcbcfdca0c95789d619e2a1c7b72..e60762f2a1655cb0acabd8fd7d5299ad5389796d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -105,7 +105,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${module_hashes_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -214,6 +214,7 @@ fi
 
 btf_vmlinux_bin_o=
 kallsymso=
+module_hashes_o=
 strip_debug=
 generate_map=
 
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
@@ -310,6 +322,17 @@ if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
 	fi
 fi
 
+if is_enabled CONFIG_MODULE_HASHES; then
+	info MAKE modules
+	${MAKE} -f Makefile MODULE_HASHES_MODPOST_FINAL=1 modules
+	${srctree}/scripts/module-hashes.sh > .tmp_module_hashes.c
+	info CC ${module_hashes_o}
+	${CC} ${NOSTDINC_FLAGS} ${LINUXINCLUDE} ${KBUILD_CPPFLAGS} ${KBUILD_CFLAGS} \
+		${KBUILD_CFLAGS_KERNEL} -fno-lto -c -o "${module_hashes_o}" ".tmp_module_hashes.c"
+	${OBJCOPY} --dump-section .module_hashes=.tmp_module_hashes.bin ${module_hashes_o}
+	${OBJCOPY} --update-section .module_hashes=.tmp_module_hashes.bin ${VMLINUX}
+fi
+
 # step a (see comment above)
 if is_enabled CONFIG_KALLSYMS; then
 	if ! cmp -s System.map "${kallsyms_sysmap}"; then
diff --git a/scripts/module-hashes.sh b/scripts/module-hashes.sh
new file mode 100755
index 0000000000000000000000000000000000000000..120ce924105c51cdd7a704cbec7e5fa356f9ce1a
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
+		modhash="$(cat "$mod".hash | hexdump -v -e '"0x" 1/1 "%02x, "')"
+	fi
+	echo -e "\t/* $mod */"
+	echo -e "\t{ $modhash},"
+	echo
+done
+
+echo "};"
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index 155959205b8eac2c85897a8c4c8b7ec471156706..60b240e3ef1f9609e3f3241befc0bbc7e4a3db74 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -1,7 +1,7 @@
 config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
-	depends on !MODULES || MODULE_SIG
+	depends on !MODULES || MODULE_SIG || MODULE_HASHES
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.

-- 
2.49.0


