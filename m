Return-Path: <linux-arch+bounces-15781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F542D18E1D
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA784305E58F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11AB3939BF;
	Tue, 13 Jan 2026 12:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="JwVKXFZL"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC19392B69;
	Tue, 13 Jan 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307876; cv=none; b=jKq8KPSv6vpmwj51CUL0isniDq0AcOv/tigNT6H4gWv5UOqWcFUxOO78V4OAn/kFLO+f4pMcst0MQNel8Mwmfa2qIQzv74plp4k+wZU7SrYOKFULoXSS0fXFdpXp00MOXnDEISefhmvaPweK4J20IbigxZVnGIuIo2Bjt9hhsYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307876; c=relaxed/simple;
	bh=uo+q0Kly5GHHRWNz1xrlmWkaJngnhqqDNyjrM//3gk0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sq4dCuHn0iAjcJgm+WzNi+S4xpvl9LQSQFonEB5A67YkGOEYkobI738L03+MGhjEVB8MCqVErD5OzXYAW+N6grdf07B7pz6yRTtSo1BnVOoIwAcz/ggS0lI+YHjay4Zqlb1hg+zzurk6UcKczMvuNbobrBG6GFN57H+24RNzcX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=JwVKXFZL; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=uo+q0Kly5GHHRWNz1xrlmWkaJngnhqqDNyjrM//3gk0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JwVKXFZLPBs+ylq0NvDxhxOJKa58/cuTZWVVmmtPGDFAKYVzzGy/ECPZatwGeZGxY
	 faQ0rlz1UfqJa4V9eTPur9m37t9/5Gvlyc0myMUYEVS0iNuHSIRGKI64jVi/JsrkgH
	 VSRuZjthINCWGS1P78FYvDWfLZTn15z/5biOKaSc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:59 +0100
Subject: [PATCH v4 15/17] module: Introduce hash-based integrity checking
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-15-0b932db9b56b@weissschuh.net>
References: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
In-Reply-To: <20260113-module-hashes-v4-0-0b932db9b56b@weissschuh.net>
To: Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Sami Tolvanen <samitolvanen@google.com>, 
 Daniel Gomez <da.gomez@samsung.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
 Naveen N Rao <naveen@kernel.org>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, 
 Nicolas Schier <nicolas.schier@linux.dev>, 
 Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 Nicolas Schier <nsc@kernel.org>, 
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, 
 Xiu Jianfeng <xiujianfeng@huawei.com>, Nicolas Schier <nsc@kernel.org>, 
 Christophe Leroy <chleroy@kernel.org>
Cc: =?utf-8?q?Fabian_Gr=C3=BCnbichler?= <f.gruenbichler@proxmox.com>, 
 Arnout Engelen <arnout@bzzt.net>, Mattia Rizzolo <mattia@mapreri.org>, 
 kpcyrd <kpcyrd@archlinux.org>, Christian Heusel <christian@heusel.eu>, 
 =?utf-8?q?C=C3=A2ju_Mihai-Drosi?= <mcaju95@gmail.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-modules@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
 linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=29909;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uo+q0Kly5GHHRWNz1xrlmWkaJngnhqqDNyjrM//3gk0=;
 b=hPEF8hnXHOEblo9e+HAcNRJQPPn2o0qLgEGbV2wEXG/dm26PgZy1+2gjPO0eTGbGcvH3v/iNv
 IU8IUZFTe8hASLEjeChDWs4urXLWVSEf4pugIwmr/c/eUx2N2J0yHem
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The current signature-based module integrity checking has some drawbacks
in combination with reproducible builds. Either the module signing key
is generated at build time, which makes the build unreproducible, or a
static signing key is used, which precludes rebuilds by third parties
and makes the whole build and packaging process much more complicated.

The goal is to reach bit-for-bit reproducibility. Excluding certain
parts of the build output from the reproducibility analysis would be
error-prone and force each downstream consumer to introduce new tooling.

Introduce a new mechanism to ensure only well-known modules are loaded
by embedding a merkle tree root of all modules built as part of the full
kernel build into vmlinux.

Non-builtin modules can be validated as before through signatures.

Normally the .ko module files depend on a fully built vmlinux to be
available for modpost validation and BTF generation. With
CONFIG_MODULE_HASHES, vmlinux now depends on the modules
to build a merkle tree. This introduces a dependency cycle which is
impossible to satisfy. Work around this by building the modules during
link-vmlinux.sh, after vmlinux is complete enough for modpost and BTF
but before the final module hashes are

The PKCS7 format which is used for regular module signatures can not
represent Merkle proofs, so a new kind of module signature is
introduced. As this signature type is only ever used for builtin
modules, no compatibility issues can arise.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 .gitignore                                   |   1 +
 Documentation/kbuild/reproducible-builds.rst |   5 +-
 Makefile                                     |   8 +-
 include/asm-generic/vmlinux.lds.h            |  11 +
 include/linux/module_hashes.h                |  25 ++
 include/linux/module_signature.h             |   1 +
 kernel/module/Kconfig                        |  21 +-
 kernel/module/Makefile                       |   1 +
 kernel/module/hashes.c                       |  92 ++++++
 kernel/module/hashes_root.c                  |   6 +
 kernel/module/internal.h                     |   1 +
 kernel/module/main.c                         |   4 +-
 scripts/.gitignore                           |   1 +
 scripts/Makefile                             |   3 +
 scripts/Makefile.modfinal                    |  11 +
 scripts/Makefile.modinst                     |  13 +
 scripts/Makefile.vmlinux                     |   5 +
 scripts/link-vmlinux.sh                      |  14 +-
 scripts/modules-merkle-tree.c                | 467 +++++++++++++++++++++++++++
 security/lockdown/Kconfig                    |   2 +-
 20 files changed, 685 insertions(+), 7 deletions(-)

diff --git a/.gitignore b/.gitignore
index 3a7241c941f5..299c54083672 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,7 @@
 *.lz4
 *.lzma
 *.lzo
+*.merkle
 *.mod
 *.mod.c
 *.o
diff --git a/Documentation/kbuild/reproducible-builds.rst b/Documentation/kbuild/reproducible-builds.rst
index 96d208e578cd..bfde81e47b2d 100644
--- a/Documentation/kbuild/reproducible-builds.rst
+++ b/Documentation/kbuild/reproducible-builds.rst
@@ -82,7 +82,10 @@ generate a different temporary key for each build, resulting in the
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
index e404e4767944..841772a5a260 100644
--- a/Makefile
+++ b/Makefile
@@ -1588,8 +1588,10 @@ endif
 # is an exception.
 ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 KBUILD_BUILTIN := y
+ifndef CONFIG_MODULE_HASHES
 modules: vmlinux
 endif
+endif
 
 modules: modules_prepare
 
@@ -1981,7 +1983,11 @@ modules.order: $(build-dir)
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
index 8ca130af301f..d3846845e37b 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -508,6 +508,8 @@
 									\
 	PRINTK_INDEX							\
 									\
+	MODULE_HASHES							\
+									\
 	/* Kernel symbol table: Normal symbols */			\
 	__ksymtab         : AT(ADDR(__ksymtab) - LOAD_OFFSET) {		\
 		__start___ksymtab = .;					\
@@ -918,6 +920,15 @@
 #define PRINTK_INDEX
 #endif
 
+#ifdef CONFIG_MODULE_HASHES
+#define MODULE_HASHES							\
+	.module_hashes : AT(ADDR(.module_hashes) - LOAD_OFFSET) {	\
+		KEEP(*(SORT(.module_hashes)))				\
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
index 000000000000..de61072627cc
--- /dev/null
+++ b/include/linux/module_hashes.h
@@ -0,0 +1,25 @@
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
+struct module_hashes_proof {
+	__be32 pos;
+	u8 hash_sigs[][MODULE_HASHES_HASH_SIZE];
+} __packed;
+
+struct module_hashes_root {
+	u32 levels;
+	u8 hash[MODULE_HASHES_HASH_SIZE];
+};
+
+extern const struct module_hashes_root module_hashes_root;
+
+#endif /* _LINUX_MODULE_HASHES_H */
diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index a45ce3b24403..3b510651830d 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -18,6 +18,7 @@ enum pkey_id_type {
 	PKEY_ID_PGP,		/* OpenPGP generated key ID */
 	PKEY_ID_X509,		/* X.509 arbitrary subjectKeyIdentifier */
 	PKEY_ID_PKCS7,		/* Signature in PKCS#7 message */
+	PKEY_ID_MERKLE,		/* Merkle proof for modules */
 };
 
 /*
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index db3b61fb3e73..c00ca830330c 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -271,7 +271,7 @@ config MODULE_SIG
 	  inclusion into an initramfs that wants the module size reduced.
 
 config MODULE_SIG_POLICY
-	def_bool MODULE_SIG
+	def_bool MODULE_SIG || MODULE_HASHES
 
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
@@ -289,7 +289,7 @@ config MODULE_SIG_ALL
 	  modules must be signed manually, using the scripts/sign-file tool.
 
 comment "Do not forget to sign required modules with scripts/sign-file"
-	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL
+	depends on MODULE_SIG_FORCE && !MODULE_SIG_ALL && !MODULE_HASHES
 
 choice
 	prompt "Hash algorithm to sign modules"
@@ -408,6 +408,23 @@ config MODULE_DECOMPRESS
 
 	  If unsure, say N.
 
+config MODULE_HASHES
+	bool "Module hash validation"
+	depends on !MODULE_SIG_ALL
+	depends on !IMA_APPRAISE_MODSIG
+	select MODULE_SIG_FORMAT
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
index d9e8759a7b05..dd37aaf4a61a 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -25,3 +25,4 @@ obj-$(CONFIG_KGDB_KDB) += kdb.o
 obj-$(CONFIG_MODVERSIONS) += version.o
 obj-$(CONFIG_MODULE_UNLOAD_TAINT_TRACKING) += tracking.o
 obj-$(CONFIG_MODULE_STATS) += stats.o
+obj-$(CONFIG_MODULE_HASHES) += hashes.o hashes_root.o
diff --git a/kernel/module/hashes.c b/kernel/module/hashes.c
new file mode 100644
index 000000000000..23ca9f66652f
--- /dev/null
+++ b/kernel/module/hashes.c
@@ -0,0 +1,92 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Module hash-based integrity checker
+ *
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ */
+
+#define pr_fmt(fmt) "module/hash: " fmt
+
+#include <linux/module_hashes.h>
+#include <linux/module.h>
+#include <linux/unaligned.h>
+
+#include <crypto/sha2.h>
+
+#include "internal.h"
+
+static __init __maybe_unused int module_hashes_init(void)
+{
+	pr_debug("root: levels=%u hash=%*phN\n",
+		 module_hashes_root.levels,
+		 (int)sizeof(module_hashes_root.hash), module_hashes_root.hash);
+
+	return 0;
+}
+
+#if IS_ENABLED(CONFIG_MODULE_DEBUG)
+early_initcall(module_hashes_init);
+#endif
+
+static void hash_entry(const void *left, const void *right, void *out)
+{
+	struct sha256_ctx ctx;
+	u8 magic = 0x02;
+
+	sha256_init(&ctx);
+	sha256_update(&ctx, &magic, sizeof(magic));
+	sha256_update(&ctx, left, MODULE_HASHES_HASH_SIZE);
+	sha256_update(&ctx, right, MODULE_HASHES_HASH_SIZE);
+	sha256_final(&ctx, out);
+}
+
+static void hash_data(const void *d, size_t len, unsigned int pos, void *out)
+{
+	struct sha256_ctx ctx;
+	u8 magic = 0x01;
+	__be32 pos_be;
+
+	pos_be = cpu_to_be32(pos);
+
+	sha256_init(&ctx);
+	sha256_update(&ctx, &magic, sizeof(magic));
+	sha256_update(&ctx, (const u8 *)&pos_be, sizeof(pos_be));
+	sha256_update(&ctx, d, len);
+	sha256_final(&ctx, out);
+}
+
+static bool module_hashes_verify_proof(u32 pos, const u8 hash_sigs[][MODULE_HASHES_HASH_SIZE],
+				       u8 *cur)
+{
+	for (unsigned int i = 0; i < module_hashes_root.levels; i++, pos >>= 1) {
+		if ((pos & 1) == 0)
+			hash_entry(cur, hash_sigs[i], cur);
+		else
+			hash_entry(hash_sigs[i], cur, cur);
+	}
+
+	return !memcmp(cur, module_hashes_root.hash, MODULE_HASHES_HASH_SIZE);
+}
+
+int module_hash_check(struct load_info *info, const u8 *sig, size_t sig_len)
+{
+	u8 modhash[MODULE_HASHES_HASH_SIZE];
+	const struct module_hashes_proof *proof;
+	size_t proof_size;
+	u32 pos;
+
+	proof_size = struct_size(proof, hash_sigs, module_hashes_root.levels);
+
+	if (sig_len != proof_size)
+		return -ENOPKG;
+
+	proof = (const struct module_hashes_proof *)sig;
+	pos = get_unaligned_be32(&proof->pos);
+
+	hash_data(info->hdr, info->len, pos, &modhash);
+
+	if (module_hashes_verify_proof(pos, proof->hash_sigs, modhash))
+		info->sig_ok = true;
+
+	return 0;
+}
diff --git a/kernel/module/hashes_root.c b/kernel/module/hashes_root.c
new file mode 100644
index 000000000000..1abfcd3aa679
--- /dev/null
+++ b/kernel/module/hashes_root.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+#include <linux/module_hashes.h>
+
+/* Blank dummy data. Will be overridden by link-vmlinux.sh */
+const struct module_hashes_root module_hashes_root __module_hashes_section = {};
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e2d49122c2a1..e22837d3ac76 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -338,6 +338,7 @@ void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
 int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len);
+int module_hash_check(struct load_info *info, const u8 *sig, size_t sig_len);
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2a28a0ece809..fa30b6387936 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3362,8 +3362,10 @@ static int module_integrity_check(struct load_info *info, int flags)
 
 	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
 		err = module_sig_check(info, sig, sig_len);
+	} else if (IS_ENABLED(CONFIG_MODULE_HASHES) && sig_type == PKEY_ID_MERKLE) {
+		err = module_hash_check(info, sig, sig_len);
 	} else {
-		pr_err("module: not signed with expected PKCS#7 message\n");
+		pr_err("module: not signed with signature mechanism\n");
 		err = -ENOPKG;
 	}
 
diff --git a/scripts/.gitignore b/scripts/.gitignore
index 4215c2208f7e..8dad9b0d3b2d 100644
--- a/scripts/.gitignore
+++ b/scripts/.gitignore
@@ -5,6 +5,7 @@
 /insert-sys-cert
 /kallsyms
 /module.lds
+/modules-merkle-tree
 /recordmcount
 /rustdoc_test_builder
 /rustdoc_test_gen
diff --git a/scripts/Makefile b/scripts/Makefile
index 0941e5ce7b57..f539e4d93af7 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -11,6 +11,7 @@ hostprogs-always-$(CONFIG_MODULE_SIG_FORMAT)		+= sign-file
 hostprogs-always-$(CONFIG_SYSTEM_EXTRA_CERTIFICATE)	+= insert-sys-cert
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_builder
 hostprogs-always-$(CONFIG_RUST_KERNEL_DOCTESTS)		+= rustdoc_test_gen
+hostprogs-always-$(CONFIG_MODULE_HASHES)		+= modules-merkle-tree
 hostprogs-always-$(CONFIG_TRACEPOINTS)			+= tracepoint-update
 
 sorttable-objs := sorttable.o elf-parse.o
@@ -36,6 +37,8 @@ HOSTLDLIBS_sorttable = -lpthread
 HOSTCFLAGS_asn1_compiler.o = -I$(srctree)/include
 HOSTCFLAGS_sign-file.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
 HOSTLDLIBS_sign-file = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
+HOSTCFLAGS_modules-merkle-tree.o = $(shell $(HOSTPKG_CONFIG) --cflags libcrypto 2> /dev/null)
+HOSTLDLIBS_modules-merkle-tree = $(shell $(HOSTPKG_CONFIG) --libs libcrypto 2> /dev/null || echo -lcrypto)
 
 ifdef CONFIG_UNWINDER_ORC
 ifeq ($(ARCH),x86_64)
diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index 930db0524a0a..5b8e94170beb 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -63,7 +63,18 @@ ifdef CONFIG_DEBUG_INFO_BTF_MODULES
 endif
 	+$(call cmd,check_tracepoint)
 
+quiet_cmd_merkle = MERKLE  $@
+      cmd_merkle = $(objtree)/scripts/modules-merkle-tree $@ .ko
+
+.tmp_module_hashes.c: $(modules:%.o=%.ko) $(objtree)/scripts/modules-merkle-tree FORCE
+	$(call cmd,merkle)
+
+ifdef CONFIG_MODULE_HASHES
+__modfinal: .tmp_module_hashes.c
+endif
+
 targets += $(modules:%.o=%.ko) $(modules:%.o=%.mod.o) .module-common.o
+targets += $(modules:%.o=%.merkle) .tmp_module_hashes.c
 
 # Add FORCE to the prerequisites of a target to force it to be always rebuilt.
 # ---------------------------------------------------------------------------
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index 9ba45e5b32b1..ba4343b40497 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -79,6 +79,12 @@ quiet_cmd_install = INSTALL $@
 # as the options to the strip command.
 ifdef INSTALL_MOD_STRIP
 
+ifdef CONFIG_MODULE_HASHES
+ifeq ($(KBUILD_EXTMOD),)
+$(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
+endif
+endif
+
 ifeq ($(INSTALL_MOD_STRIP),1)
 strip-option := --strip-debug
 else
@@ -116,6 +122,13 @@ quiet_cmd_sign :=
       cmd_sign := :
 endif
 
+ifeq ($(KBUILD_EXTMOD),)
+ifdef CONFIG_MODULE_HASHES
+quiet_cmd_sign = MERKLE [M] $@
+      cmd_sign = cat $(objtree)/$*.merkle >> $@
+endif
+endif
+
 # Create necessary directories
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
diff --git a/scripts/Makefile.vmlinux b/scripts/Makefile.vmlinux
index cd788cac9d91..f4e38b953b01 100644
--- a/scripts/Makefile.vmlinux
+++ b/scripts/Makefile.vmlinux
@@ -78,6 +78,11 @@ ifdef CONFIG_BUILDTIME_TABLE_SORT
 vmlinux.unstripped: scripts/sorttable
 endif
 
+ifdef CONFIG_MODULE_HASHES
+vmlinux.unstripped: $(objtree)/scripts/modules-merkle-tree
+vmlinux.unstripped: modules.order
+endif
+
 # vmlinux
 # ---------------------------------------------------------------------------
 
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 8c98f8645a5c..bfeff1f5753d 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -103,7 +103,7 @@ vmlinux_link()
 	${ld} ${ldflags} -o ${output}					\
 		${wl}--whole-archive ${objs} ${wl}--no-whole-archive	\
 		${wl}--start-group ${libs} ${wl}--end-group		\
-		${kallsymso} ${btf_vmlinux_bin_o} ${arch_vmlinux_o} ${ldlibs}
+		${kallsymso} ${btf_vmlinux_bin_o} ${module_hashes_o} ${arch_vmlinux_o} ${ldlibs}
 }
 
 # generate .BTF typeinfo from DWARF debuginfo
@@ -212,6 +212,7 @@ fi
 
 btf_vmlinux_bin_o=
 kallsymso=
+module_hashes_o=
 strip_debug=
 generate_map=
 
@@ -315,6 +316,17 @@ if is_enabled CONFIG_BUILDTIME_TABLE_SORT; then
 	fi
 fi
 
+if is_enabled CONFIG_MODULE_HASHES; then
+	info MAKE modules
+	${MAKE} -f Makefile MODULE_HASHES_MODPOST_FINAL=1 modules
+	module_hashes_o=.tmp_module_hashes.o
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
diff --git a/scripts/modules-merkle-tree.c b/scripts/modules-merkle-tree.c
new file mode 100644
index 000000000000..a6ec0e21213b
--- /dev/null
+++ b/scripts/modules-merkle-tree.c
@@ -0,0 +1,467 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Compute hashes for modules files and build a merkle tree.
+ *
+ * Copyright (C) 2025 Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
+ * Copyright (C) 2025 Thomas Weißschuh <linux@weissschuh.net>
+ *
+ */
+#define _GNU_SOURCE 1
+#include <arpa/inet.h>
+#include <err.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdbool.h>
+#include <stdlib.h>
+
+#include <sys/stat.h>
+#include <sys/mman.h>
+
+#include <openssl/evp.h>
+#include <openssl/err.h>
+
+#include "ssl-common.h"
+
+static int hash_size;
+static EVP_MD_CTX *ctx;
+
+struct module_signature {
+	uint8_t		algo;		/* Public-key crypto algorithm [0] */
+	uint8_t		hash;		/* Digest algorithm [0] */
+	uint8_t		id_type;	/* Key identifier type [PKEY_ID_PKCS7] */
+	uint8_t		signer_len;	/* Length of signer's name [0] */
+	uint8_t		key_id_len;	/* Length of key identifier [0] */
+	uint8_t		__pad[3];
+	uint32_t	sig_len;	/* Length of signature data */
+};
+
+#define PKEY_ID_MERKLE 3
+
+static const char magic_number[] = "~Module signature appended~\n";
+
+struct file_entry {
+	char *name;
+	unsigned int pos;
+	unsigned char hash[EVP_MAX_MD_SIZE];
+};
+
+static struct file_entry *fh_list;
+static size_t num_files;
+
+struct leaf_hash {
+	unsigned char hash[EVP_MAX_MD_SIZE];
+};
+
+struct mtree {
+	struct leaf_hash **l;
+	unsigned int *entries;
+	unsigned int levels;
+};
+
+static inline void *xcalloc(size_t n, size_t size)
+{
+	void *p;
+
+	p = calloc(n, size);
+	if (!p)
+		errx(1, "Memory allocation failed");
+
+	return p;
+}
+
+static void *xmalloc(size_t size)
+{
+	void *p;
+
+	p = malloc(size);
+	if (!p)
+		errx(1, "Memory allocation failed");
+
+	return p;
+}
+
+static inline void *xreallocarray(void *oldp, size_t n, size_t size)
+{
+	void *p;
+
+	p = reallocarray(oldp, n, size);
+	if (!p)
+		errx(1, "Memory allocation failed");
+
+	return p;
+}
+
+static inline char *xasprintf(const char *fmt, ...)
+{
+	va_list ap;
+	char *strp;
+	int ret;
+
+	va_start(ap, fmt);
+	ret = vasprintf(&strp, fmt, ap);
+	va_end(ap);
+	if (ret == -1)
+		err(1, "Memory allocation failed");
+
+	return strp;
+}
+
+static unsigned int get_pow2(unsigned int val)
+{
+	return 31 - __builtin_clz(val);
+}
+
+static unsigned int roundup_pow2(unsigned int val)
+{
+	return 1 << (get_pow2(val - 1) + 1);
+}
+
+static unsigned int log2_roundup(unsigned int val)
+{
+	return get_pow2(roundup_pow2(val));
+}
+
+static void hash_data(void *p, unsigned int pos, size_t size, void *ret_hash)
+{
+	unsigned char magic = 0x01;
+	unsigned int pos_be;
+
+	pos_be = htonl(pos);
+
+	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
+	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
+	ERR(EVP_DigestUpdate(ctx, &pos_be, sizeof(pos_be)) != 1, "EVP_DigestUpdate(pos)");
+	ERR(EVP_DigestUpdate(ctx, p, size) != 1, "EVP_DigestUpdate(data)");
+	ERR(EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1, "EVP_DigestFinal_ex()");
+}
+
+static void hash_entry(void *left, void *right, void *ret_hash)
+{
+	int hash_size = EVP_MD_CTX_get_size_ex(ctx);
+	unsigned char magic = 0x02;
+
+	ERR(EVP_DigestInit_ex(ctx, NULL, NULL) != 1, "EVP_DigestInit_ex()");
+	ERR(EVP_DigestUpdate(ctx, &magic, sizeof(magic)) != 1, "EVP_DigestUpdate(magic)");
+	ERR(EVP_DigestUpdate(ctx, left, hash_size) != 1, "EVP_DigestUpdate(left)");
+	ERR(EVP_DigestUpdate(ctx, right, hash_size) != 1, "EVP_DigestUpdate(right)");
+	ERR(EVP_DigestFinal_ex(ctx, ret_hash, NULL) != 1, "EVP_DigestFinal_ex()");
+}
+
+static void hash_file(struct file_entry *fe)
+{
+	struct stat sb;
+	int fd, ret;
+	void *mem;
+
+	fd = open(fe->name, O_RDONLY);
+	if (fd < 0)
+		err(1, "Failed to open %s", fe->name);
+
+	ret = fstat(fd, &sb);
+	if (ret)
+		err(1, "Failed to stat %s", fe->name);
+
+	mem = mmap(NULL, sb.st_size, PROT_READ, MAP_SHARED, fd, 0);
+	close(fd);
+
+	if (mem == MAP_FAILED)
+		err(1, "Failed to mmap %s", fe->name);
+
+	hash_data(mem, fe->pos, sb.st_size, fe->hash);
+
+	munmap(mem, sb.st_size);
+}
+
+static struct mtree *build_merkle(struct file_entry *fh, size_t num)
+{
+	struct mtree *mt;
+	unsigned int le;
+
+	if (!num)
+		return NULL;
+
+	mt = xmalloc(sizeof(*mt));
+	mt->levels = log2_roundup(num);
+
+	mt->l = xcalloc(sizeof(*mt->l), mt->levels);
+
+	mt->entries = xcalloc(sizeof(*mt->entries), mt->levels);
+	le = num / 2;
+	if (num & 1)
+		le++;
+	mt->entries[0] = le;
+	mt->l[0] = xcalloc(sizeof(**mt->l), le);
+
+	/* First level of pairs */
+	for (unsigned int i = 0; i < num; i += 2) {
+		if (i == num - 1) {
+			/* Odd number of files, no pair. Hash with itself */
+			hash_entry(fh[i].hash, fh[i].hash, mt->l[0][i / 2].hash);
+		} else {
+			hash_entry(fh[i].hash, fh[i + 1].hash, mt->l[0][i / 2].hash);
+		}
+	}
+	for (unsigned int i = 1; i < mt->levels; i++) {
+		int odd = 0;
+
+		if (le & 1) {
+			le++;
+			odd++;
+		}
+
+		mt->entries[i] = le / 2;
+		mt->l[i] = xcalloc(sizeof(**mt->l), le);
+
+		for (unsigned int n = 0; n < le; n += 2) {
+			if (n == le - 2 && odd) {
+				/* Odd number of pairs, no pair. Hash with itself */
+				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n].hash,
+					   mt->l[i][n / 2].hash);
+			} else {
+				hash_entry(mt->l[i - 1][n].hash, mt->l[i - 1][n + 1].hash,
+					   mt->l[i][n / 2].hash);
+			}
+		}
+		le =  mt->entries[i];
+	}
+	return mt;
+}
+
+static void free_mtree(struct mtree *mt)
+{
+	if (!mt)
+		return;
+
+	for (unsigned int i = 0; i < mt->levels; i++)
+		free(mt->l[i]);
+
+	free(mt->l);
+	free(mt->entries);
+	free(mt);
+}
+
+static void write_be_int(int fd, unsigned int v)
+{
+	unsigned int be_val = htonl(v);
+
+	if (write(fd, &be_val, sizeof(be_val)) != sizeof(be_val))
+		err(1, "Failed writing to file");
+}
+
+static void write_hash(int fd, const void *h)
+{
+	ssize_t wr;
+
+	wr = write(fd, h, hash_size);
+	if (wr != hash_size)
+		err(1, "Failed writing to file");
+}
+
+static void build_proof(struct mtree *mt, unsigned int n, int fd)
+{
+	unsigned char cur[EVP_MAX_MD_SIZE];
+	unsigned char tmp[EVP_MAX_MD_SIZE];
+	struct file_entry *fe, *fe_sib;
+
+	fe = &fh_list[n];
+
+	if ((n & 1) == 0) {
+		/* No pair, hash with itself */
+		if (n + 1 == num_files)
+			fe_sib = fe;
+		else
+			fe_sib = &fh_list[n + 1];
+	} else {
+		fe_sib = &fh_list[n - 1];
+	}
+	/* First comes the node position into the file */
+	write_be_int(fd, n);
+
+	if ((n & 1) == 0)
+		hash_entry(fe->hash, fe_sib->hash, cur);
+	else
+		hash_entry(fe_sib->hash, fe->hash, cur);
+
+	/* Next is the sibling hash, followed by hashes in the tree */
+	write_hash(fd, fe_sib->hash);
+
+	for (unsigned int i = 0; i < mt->levels - 1; i++) {
+		n >>= 1;
+		if ((n & 1) == 0) {
+			void *h;
+
+			/* No pair, hash with itself */
+			if (n + 1 == mt->entries[i])
+				h = cur;
+			else
+				h = mt->l[i][n + 1].hash;
+
+			hash_entry(cur, h, tmp);
+			write_hash(fd, h);
+		} else {
+			hash_entry(mt->l[i][n - 1].hash, cur, tmp);
+			write_hash(fd, mt->l[i][n - 1].hash);
+		}
+		memcpy(cur, tmp, hash_size);
+	}
+
+	 /* After all that, the end hash should match the root hash */
+	if (memcmp(cur, mt->l[mt->levels - 1][0].hash, hash_size))
+		errx(1, "hash mismatch");
+}
+
+static void append_module_signature_magic(int fd, unsigned int sig_len)
+{
+	struct module_signature sig_info = {
+		.id_type	= PKEY_ID_MERKLE,
+		.sig_len	= htonl(sig_len),
+	};
+
+	if (write(fd, &sig_info, sizeof(sig_info)) < 0)
+		err(1, "write(sig_info) failed");
+
+	if (write(fd, &magic_number, sizeof(magic_number) - 1) < 0)
+		err(1, "write(magic_number) failed");
+}
+
+static void write_merkle_root(struct mtree *mt, const char *fp)
+{
+	char buf[1024];
+	unsigned int levels;
+	unsigned char *h;
+	FILE *f;
+
+	if (mt) {
+		levels = mt->levels;
+		h = mt->l[mt->levels - 1][0].hash;
+	} else {
+		levels = 0;
+		h = xcalloc(1, hash_size);
+	}
+
+	f = fopen(fp, "w");
+	if (!f)
+		err(1, "Failed to create %s", buf);
+
+	fprintf(f, "#include <linux/module_hashes.h>\n\n");
+	fprintf(f, "const struct module_hashes_root module_hashes_root __module_hashes_section = {\n");
+
+	fprintf(f, "\t.levels = %u,\n", levels);
+	fprintf(f, "\t.hash = {");
+	for (unsigned int i = 0; i < hash_size; i++) {
+		char *space = "";
+
+		if (!(i % 8))
+			fprintf(f, "\n\t\t");
+
+		if ((i + 1) % 8)
+			space = " ";
+
+		fprintf(f, "0x%02x,%s", h[i], space);
+	}
+	fprintf(f, "\n\t},");
+
+	fprintf(f, "\n};\n");
+	fclose(f);
+
+	if (!mt)
+		free(h);
+}
+
+static char *xstrdup_replace_suffix(const char *str, const char *new_suffix)
+{
+	const char *current_suffix;
+	size_t base_len;
+
+	current_suffix = strchr(str, '.');
+	if (!current_suffix)
+		errx(1, "No existing suffix in '%s'", str);
+
+	base_len = current_suffix - str;
+
+	return xasprintf("%.*s%s", (int)base_len, str, new_suffix);
+}
+
+static void read_modules_order(const char *fname, const char *suffix)
+{
+	char line[PATH_MAX];
+	FILE *in;
+
+	in = fopen(fname, "r");
+	if (!in)
+		err(1, "fopen(%s)", fname);
+
+	while (fgets(line, PATH_MAX, in)) {
+		struct file_entry *entry;
+
+		fh_list = xreallocarray(fh_list, num_files + 1, sizeof(*fh_list));
+		entry = &fh_list[num_files];
+
+		entry->pos = num_files;
+		entry->name = xstrdup_replace_suffix(line, suffix);
+		hash_file(entry);
+
+		num_files++;
+	}
+
+	fclose(in);
+}
+
+static __attribute__((noreturn))
+void format(void)
+{
+	fprintf(stderr,
+		"Usage: scripts/modules-merkle-tree <root definition>\n");
+	exit(2);
+}
+
+int main(int argc, char *argv[])
+{
+	const EVP_MD *hash_evp;
+	struct mtree *mt;
+
+	if (argc != 3)
+		format();
+
+	hash_evp = EVP_get_digestbyname("sha256");
+	ERR(!hash_evp, "EVP_get_digestbyname");
+
+	ctx = EVP_MD_CTX_new();
+	ERR(!ctx, "EVP_MD_CTX_new()");
+
+	hash_size = EVP_MD_get_size(hash_evp);
+	ERR(hash_size <= 0, "EVP_get_digestbyname");
+
+	if (EVP_DigestInit_ex(ctx, hash_evp, NULL) != 1)
+		ERR(1, "EVP_DigestInit_ex()");
+
+	read_modules_order("modules.order", argv[2]);
+
+	mt = build_merkle(fh_list, num_files);
+	write_merkle_root(mt, argv[1]);
+	for (unsigned int i = 0; i < num_files; i++) {
+		char *signame;
+		int fd;
+
+		signame = xstrdup_replace_suffix(fh_list[i].name, ".merkle");
+
+		fd = open(signame, O_WRONLY | O_CREAT | O_TRUNC, 0644);
+		if (fd < 0)
+			err(1, "Can't create %s", signame);
+
+		build_proof(mt, i, fd);
+		append_module_signature_magic(fd, lseek(fd, 0, SEEK_CUR));
+		close(fd);
+	}
+
+	free_mtree(mt);
+	for (unsigned int i = 0; i < num_files; i++)
+		free(fh_list[i].name);
+	free(fh_list);
+
+	EVP_MD_CTX_free(ctx);
+	return 0;
+}
diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index 155959205b8e..60b240e3ef1f 100644
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
2.52.0


