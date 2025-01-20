Return-Path: <linux-arch+bounces-9829-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A32A1725A
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0C17A4BCB
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2666A1F12E3;
	Mon, 20 Jan 2025 17:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="Di/M6gV2"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD7D1F03D0;
	Mon, 20 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395149; cv=none; b=JsTxl9z4HK3yz39TNFYyQKTmhAvYoULAEdohPr0WJX9gOJKSoB27ToLlk0IqHJZ7bjDHfR4GCkIufKJvhJD7FHfFkpXIblx/6XB9rjB7R5fzSfPK1osbUUfkog2mul0FiFZ2jtY9eKfLouwZ1DiVSEeUxiR6MSBUbR6r9aXqC1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395149; c=relaxed/simple;
	bh=MdKjsanauiC7LwdkZFfsgUbSTeQZc+J9ZaaglNxxsks=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tu6b7zp8RViZIY6WE8isYjG3NpUft6UiRgEn9XoicJPhVMP+1JDVHHicNjm+SOpN0fQV7krrqB2P84ReqY3uHowwFLq5nuXyscR7s1ss3CnTETWcuhKef+4zpHEhyS95g6UpEsznQ0iEjNc4qNjM4Pcv/42qKzvqYU47O7PPu1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=Di/M6gV2; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395133;
	bh=MdKjsanauiC7LwdkZFfsgUbSTeQZc+J9ZaaglNxxsks=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Di/M6gV2PZR/Y+ULPHNpx2nP0AYRmpRur97hFwzhHG9qZT82EnocNOEeA3rqp3lz0
	 h2+5CUwBdmHujmMocjg40PdHqjw5a1g3xHKKAaNvJi5l5iniwzPm4ALjx8K8HosPA8
	 5uUlyHHmdUAigVH4CGaYEfN3OXur5Xhu8uUM9F6U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:25 +0100
Subject: [PATCH v2 6/6] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-6-ba1184e27b7f@weissschuh.net>
References: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
In-Reply-To: <20250120-module-hashes-v2-0-ba1184e27b7f@weissschuh.net>
To: Masahiro Yamada <masahiroy@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, 
 Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, linux-kbuild@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
 linux-modules@vger.kernel.org, linux-security-module@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=14935;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=MdKjsanauiC7LwdkZFfsgUbSTeQZc+J9ZaaglNxxsks=;
 b=5IcmE9REX+FAANRF1h1BOnurKOwOaYMYqcpINOm6mCBcRkcTSJcMrGzt0fX37CpcqtYiEvLc0
 1QQkiSWcpjND1eqQ23aAdahsCJmu7W0HC8zogLdLsmo3NKJQWBIePjD
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

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                                   |  1 +
 Documentation/kbuild/reproducible-builds.rst |  5 ++-
 Makefile                                     |  8 ++++-
 include/asm-generic/vmlinux.lds.h            | 11 ++++++
 include/linux/module_hashes.h                | 17 +++++++++
 kernel/module/Kconfig                        | 17 ++++++++-
 kernel/module/Makefile                       |  1 +
 kernel/module/hashes.c                       | 52 ++++++++++++++++++++++++++++
 kernel/module/internal.h                     |  1 +
 kernel/module/main.c                         |  6 ++++
 scripts/Makefile.modfinal                    |  6 ++++
 scripts/Makefile.vmlinux                     |  5 +++
 scripts/link-vmlinux.sh                      | 25 ++++++++++++-
 scripts/module-hashes.sh                     | 26 ++++++++++++++
 security/lockdown/Kconfig                    |  2 +-
 15 files changed, 178 insertions(+), 5 deletions(-)

diff --git a/.gitignore b/.gitignore
index 6839cf84acda0d2d3c236a2e42b0cb0fe1b14965..7c40151c3f5d0c15ac04cead5f21c291a98d779f 100644
--- a/.gitignore
+++ b/.gitignore
@@ -28,6 +28,7 @@
 *.gz
 *.i
 *.ko
+*.ko.hash
 *.lex.c
 *.ll
 *.lst
diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index f2dcc39044e66ddd165646e0b51ccb0209aca7dd..6a742ad745113a9267223b33810dbc7218c47d4c 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -79,7 +79,10 @@ generate a different temporary key for each build, resulting in the
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
index b9464c88ac7230518a756bff5e6c5c8871cc5058..fc862ffd2df843c0b68bebc8f554b88850ba1541 100644
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
index a80de8d22efdd0f13b3eb579a8ff1e69029d0694..cdd30b9a08d8cdf3ec0595b5e414265b869d343e 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -212,7 +212,7 @@ config MODULE_SIG
 
 config MODULE_SIG_POLICY
 	def_bool y
-	depends on MODULE_SIG
+	depends on MODULE_SIG || MODULE_HASHES
 
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
@@ -348,6 +348,21 @@ config MODULE_DECOMPRESS
 
 	  If unsure, say N.
 
+config MODULE_HASHES
+	bool "Module hash validation"
+	depends on $(success,cksum --algorithm sha256 --raw /dev/null)
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
index 0000000000000000000000000000000000000000..1aa49767a39b4e0c495b17d3f2edcb5a6ceb839e
--- /dev/null
+++ b/kernel/module/hashes.c
@@ -0,0 +1,52 @@
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
index c30abeefa60b884c4a69b1eb4f1123a4bbee4b47..9c927c212f862fff7000f1cfac3c7e391a2390ac 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -334,6 +334,7 @@ int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
 int module_sig_check(struct load_info *info, int flags);
+int module_hash_check(struct load_info *info, int flags);
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index effe1db02973d4f60ff6cbc0d3b5241a3576fa3e..094ace81d795711b56d12a2abc75ea35449c8300 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3218,6 +3218,12 @@ static int module_integrity_check(struct load_info *info, int flags)
 {
 	int err = 0;
 
+	if (IS_ENABLED(CONFIG_MODULE_HASHES)) {
+		err = module_hash_check(info, flags);
+		if (!err)
+			return 0;
+	}
+
 	if (IS_ENABLED(CONFIG_MODULE_SIG))
 		err = module_sig_check(info, flags);
 
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 5d01b553ec9a4565c8e5a6edd05665c409003bc1..080b4fc3a9ba5036b45f04a7e79f2fc02364f93a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -43,6 +43,9 @@ quiet_cmd_btf_ko = BTF [M] $@
 		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
 	fi;
 
+quiet_cmd_cksum_ko =
+      cmd_cksum_ko = cksum --algorithm sha256 --raw $@ > $@.hash
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
2.48.1


