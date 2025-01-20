Return-Path: <linux-arch+bounces-9828-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A128A17253
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A822D167D8B
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A721F0E3D;
	Mon, 20 Jan 2025 17:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="seVdC/kI"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633B61F03C6;
	Mon, 20 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395148; cv=none; b=QFq+RJ6O3rhy2G+NtWkNNV+CVY1eD5Q5IDhOpIKgipNGwLcNfXPoJGacUx5cmPf23MtuJ8hSWVdu8Ove/62bCfu92zTlJuDW8iK++FCQJy06oX3976dTS+VGpqQ43kszXG+hTxeysQUb7qke266MfqeCMQ800ApQ2VzK6AaTnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395148; c=relaxed/simple;
	bh=y1mgrnaND/wbt141UjmnEkQzo6komHB3bc5SEQ4EwGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sIGV6zZex8YnHd6NwzHz6JH2iNTb0CNaVjcx6vFyQ73n+aYlklUqPzFo3ayclCz2A8zGoc6znsvuEzxLOTTZ9gauV898GB34GpOxulfD4gHyJOUIeum3NMo+HgjLogHYgNBlsxDuagR6Cfsecalh1tLzKW9zU4TVOsQZqPlyOwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=seVdC/kI; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395132;
	bh=y1mgrnaND/wbt141UjmnEkQzo6komHB3bc5SEQ4EwGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=seVdC/kIx9ku41vBQZtDWVdtKljaDpjT3gCYCrswKvVuKyTicSY0q5/YXGIr7KOSB
	 m6s0w4frFdRMqFCEyp/LcVUM+uGzpooiXw5t455H8ZgbVn3M+EgyIkO8GLY2wqG+2E
	 BZgNqEMLkyZb+SS0hCDiXWvD37axweNkCVihw99I=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:21 +0100
Subject: [PATCH v2 2/6] module: Make module loading policy usable without
 MODULE_SIG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-2-ba1184e27b7f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=4529;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=y1mgrnaND/wbt141UjmnEkQzo6komHB3bc5SEQ4EwGw=;
 b=tyLGwa+HuW9EtJKxaGkD7GTxuCByB+DID2E1ITVJR5exbfWrL77NQhVr5hiuEAzwHu5QyjfM5
 T9xfsr5I16fAcrqFS6jlRXVIgfj6dArJ36LVlQHPPKqyU9h92+sapTQ
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The loading policy functionality will also be used by the hash-based
module validation. Split it out from CONFIG_MODULE_SIG so it is usable
by both.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module.h  |  8 ++++----
 kernel/module/Kconfig   |  6 +++++-
 kernel/module/main.c    | 26 +++++++++++++++++++++++++-
 kernel/module/signing.c | 21 ---------------------
 4 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/include/linux/module.h b/include/linux/module.h
index b3a643435357986f3f9fe852260ca07f371cf86c..ccddab25d277da84d8c2866a9b4ded7c18691c0d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -451,7 +451,7 @@ struct module {
 	const s32 *gpl_crcs;
 	bool using_gplonly_symbols;
 
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_SIG_POLICY
 	/* Signature was verified. */
 	bool sig_ok;
 #endif
@@ -928,14 +928,14 @@ static inline bool retpoline_module_ok(bool has_retpoline)
 }
 #endif
 
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_SIG_POLICY
 bool is_module_sig_enforced(void);
 
 static inline bool module_sig_ok(struct module *module)
 {
 	return module->sig_ok;
 }
-#else	/* !CONFIG_MODULE_SIG */
+#else	/* !CONFIG_MODULE_SIG_POLICY */
 static inline bool is_module_sig_enforced(void)
 {
 	return false;
@@ -945,7 +945,7 @@ static inline bool module_sig_ok(struct module *module)
 {
 	return true;
 }
-#endif	/* CONFIG_MODULE_SIG */
+#endif	/* CONFIG_MODULE_SIG_POLICY */
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(const char *modname,
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index 7b329057997ad2ec310133ca84617d9bfcdb7e9f..a80de8d22efdd0f13b3eb579a8ff1e69029d0694 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -210,9 +210,13 @@ config MODULE_SIG
 	  debuginfo strip done by some packagers (such as rpmbuild) and
 	  inclusion into an initramfs that wants the module size reduced.
 
+config MODULE_SIG_POLICY
+	def_bool y
+	depends on MODULE_SIG
+
 config MODULE_SIG_FORCE
 	bool "Require modules to be validly signed"
-	depends on MODULE_SIG
+	depends on MODULE_SIG_POLICY
 	help
 	  Reject unsigned modules or signed modules for which we don't have a
 	  key.  Without this, such modules will simply taint the kernel.
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 5399c182b3cbed2dbeea0291f717f30358d8e7fc..8aa593fee22a227a482466dceda4a6b657b956e0 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2367,7 +2367,7 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 				mod->name);
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_SIG_POLICY
 	mod->sig_ok = info->sig_ok;
 	if (!mod->sig_ok) {
 		pr_notice_once("%s: module verification failed: signature "
@@ -3779,3 +3779,27 @@ static int module_debugfs_init(void)
 }
 module_init(module_debugfs_init);
 #endif
+
+#ifdef CONFIG_MODULE_SIG_POLICY
+
+#undef MODULE_PARAM_PREFIX
+#define MODULE_PARAM_PREFIX "module."
+
+static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
+module_param(sig_enforce, bool_enable_only, 0644);
+
+/*
+ * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
+ * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
+ */
+bool is_module_sig_enforced(void)
+{
+	return sig_enforce;
+}
+EXPORT_SYMBOL(is_module_sig_enforced);
+
+void set_module_sig_enforced(void)
+{
+	sig_enforce = true;
+}
+#endif
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623d5d4e87d2f3d139d8620fb937579..e51920605da14771601327ea596dad2e12400518 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -16,27 +16,6 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
-#undef MODULE_PARAM_PREFIX
-#define MODULE_PARAM_PREFIX "module."
-
-static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
-module_param(sig_enforce, bool_enable_only, 0644);
-
-/*
- * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
- * on that instead of directly to CONFIG_MODULE_SIG_FORCE config.
- */
-bool is_module_sig_enforced(void)
-{
-	return sig_enforce;
-}
-EXPORT_SYMBOL(is_module_sig_enforced);
-
-void set_module_sig_enforced(void)
-{
-	sig_enforce = true;
-}
-
 /*
  * Verify the signature on a module.
  */

-- 
2.48.1


