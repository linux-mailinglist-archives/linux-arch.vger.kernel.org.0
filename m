Return-Path: <linux-arch+bounces-11710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2EAAA0CC1
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E31B2188C0CA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75912D029B;
	Tue, 29 Apr 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="InUYUEBx"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F642135DD;
	Tue, 29 Apr 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931887; cv=none; b=rYA8g/EZm/WR4lPU2dxw0n6K5r2ztK4xa2YDV6rzkxgIyi93gHk2BF3OdNSElRrAUlbf7/mPTRqL3Al4c+V/0PI8nsdvLTI/YuJIZC31lsGhGe1ugZTfT56q3sUMBk1/WqMDm2t61OXZWoydF6tfSECQrw9/7ZdjMdONbs6COcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931887; c=relaxed/simple;
	bh=UCCJkeYdVSKNrm9L/l2LgArwTnkqToFIXrGQtz775hQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUcIedCs4Q08POc4qPbckL2tsk38MlLHlnKDEtqBUaxEKNuvrm3/LY3NYQ0S5azbIVZnV4zSnUJBoDrMqmsLdi01Z0VBhCkBAzxDR+8MMue6fDidC3Z880kM11sUJPxdKE/tiEGMvU5hMQXU9Z8jvmqaODELyXoctpbyKVqC4eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=InUYUEBx; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=UCCJkeYdVSKNrm9L/l2LgArwTnkqToFIXrGQtz775hQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=InUYUEBxzcaSdnkfyWEYs5gnGMDG+ZrErjBcXwVYAokpi9GEx8U1OAq8QYl2tMjVP
	 1ekrjrvh9Kq4zyyJzkto/U4Kn8QLoXereQhuqEhHhjjsu1IS7NMnfsLI/u0MH1f9jK
	 qMLc+34JpYBUgNoLb0o6WFDZy5UfMXBeZPj/wmy4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:32 +0200
Subject: [PATCH v3 5/9] module: Make module loading policy usable without
 MODULE_SIG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-5-00e9258def9e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=4529;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=UCCJkeYdVSKNrm9L/l2LgArwTnkqToFIXrGQtz775hQ=;
 b=FFTZUNwOflf9z+ryGT7IH9ClBV+Qgyns9jpZd219As5W1VpY2anGRlh//7RjRR1nc7E7upt8z
 nqLMla0XzUOAp/oDbt2x4NABjz1decy6MVywaUlDbU1LQpYgWKpemko
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
index d94b196d5a34e104d81308df4b150452eb96cdc9..68aa8bbd33acc84e013dc575ee88bd4e3101f9f4 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -453,7 +453,7 @@ struct module {
 	const u32 *gpl_crcs;
 	bool using_gplonly_symbols;
 
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_SIG_POLICY
 	/* Signature was verified. */
 	bool sig_ok;
 #endif
@@ -921,14 +921,14 @@ static inline bool retpoline_module_ok(bool has_retpoline)
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
@@ -938,7 +938,7 @@ static inline bool module_sig_ok(struct module *module)
 {
 	return true;
 }
-#endif	/* CONFIG_MODULE_SIG */
+#endif	/* CONFIG_MODULE_SIG_POLICY */
 
 #if defined(CONFIG_MODULES) && defined(CONFIG_KALLSYMS)
 int module_kallsyms_on_each_symbol(const char *modname,
diff --git a/kernel/module/Kconfig b/kernel/module/Kconfig
index c51f25538d0ea66e6486ad0be6684173cd0140b5..a3146e9378fcd3292a756a2a7ea5241524cbc408 100644
--- a/kernel/module/Kconfig
+++ b/kernel/module/Kconfig
@@ -265,9 +265,13 @@ config MODULE_SIG
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
index a2859dc3eea66ec19991e7e4afb5bbcae2c2d167..83c66205556fdde92152c131f1f58229c4f7f734 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2432,7 +2432,7 @@ static void module_augment_kernel_taints(struct module *mod, struct load_info *i
 				mod->name);
 		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
 	}
-#ifdef CONFIG_MODULE_SIG
+#ifdef CONFIG_MODULE_SIG_POLICY
 	mod->sig_ok = info->sig_ok;
 	if (!mod->sig_ok) {
 		pr_notice_once("%s: module verification failed: signature "
@@ -3808,3 +3808,27 @@ static int module_debugfs_init(void)
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
2.49.0


