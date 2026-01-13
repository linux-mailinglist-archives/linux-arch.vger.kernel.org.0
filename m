Return-Path: <linux-arch+bounces-15779-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAC5D18D51
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3F7DA3020FE2
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7DB392C3E;
	Tue, 13 Jan 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WFMGTKFM"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9583904DE;
	Tue, 13 Jan 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307873; cv=none; b=RTmimWMVKfxXk4zXiYLHG47bnaBU2yhB9C5MLCaQgN72stTQY6waq+qOsViehefEiOCZtQoaTeXiZ4cN9EAZs6O40Ok+Fs6i5bOHw8GAOGzjZBMKKtjLE3VhTi8PajWpBMO0OuRmnCfrlXzeimV0dzFE0twnVDcqLvhXQmj3+Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307873; c=relaxed/simple;
	bh=mjGdw2yxzWxgtsTNEl1bBGcD2Uicfy0x+S+3g1xrhKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IUqZMOzqnhhFFfBnEw7r6WY8f1DOvGls1MuM3g8+Tdj/Avi5xfufA3yGptkUMoqV5weU8xtJH1vl9bTnlxcaf1mELbvsG4xjFUTwDtm5TJx3WD8OwDRR3wjcCh7MEkkVskRL43zICWthSGh0NTDTWscQegmTuXm8Oa9YT/AONNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WFMGTKFM; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=mjGdw2yxzWxgtsTNEl1bBGcD2Uicfy0x+S+3g1xrhKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WFMGTKFMSCsakSKivcHT5zu72mKHJYU+l6hZ0Ds8YZP6nlir5oVmNph2sjIDlclnG
	 +y3O47iXttG/2e2trcAME/dynWcEVSqoRVgGfwQn4M071eJAIdD7sx4q2lIzsfxZ8h
	 SEtYLkde87SzPAkZ9Mq72QmsJzaGe7nQdHrm0Q20=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:56 +0100
Subject: [PATCH v4 12/17] module: Move signature splitting up
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-12-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=3025;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=mjGdw2yxzWxgtsTNEl1bBGcD2Uicfy0x+S+3g1xrhKs=;
 b=awMfsURUOFCD2iZVVxJ0L7EbCCDNlOcWxUEUE7J742mmPYLUEoPlh9tuteXrcLXkmbAsJ5IEp
 W8BKKGMM5JdC9G+RCkMV/mRthjFNtlf97D2xKTMLMHkvxfe/OH8pPvq
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The signature splitting will also be used by CONFIG_MODULE_HASHES.

Move it up the callchain, so the result can be reused.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/internal.h |  2 +-
 kernel/module/main.c     | 13 ++++++++++++-
 kernel/module/signing.c  | 21 +++++++--------------
 3 files changed, 20 insertions(+), 16 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index e053c29a5d08..e2d49122c2a1 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -337,7 +337,7 @@ int module_enforce_rwx_sections(const Elf_Ehdr *hdr, const Elf_Shdr *sechdrs,
 void module_mark_ro_after_init(const Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 			       const char *secstrings);
 
-int module_sig_check(struct load_info *info, int flags);
+int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len);
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index c09b25c0166a..d65bc300a78c 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3346,10 +3346,21 @@ static int early_mod_check(struct load_info *info, int flags)
 
 static int module_integrity_check(struct load_info *info, int flags)
 {
+	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
+				       MODULE_INIT_IGNORE_VERMAGIC);
+	size_t sig_len;
+	const u8 *sig;
 	int err = 0;
 
+	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
+		err = mod_split_sig(info->hdr, &info->len, mangled_module,
+				    &sig_len, &sig, "module");
+		if (err)
+			return err;
+	}
+
 	if (IS_ENABLED(CONFIG_MODULE_SIG))
-		err = module_sig_check(info, flags);
+		err = module_sig_check(info, sig, sig_len);
 
 	if (err)
 		return err;
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index 8a5f66389116..86164761cac7 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -15,26 +15,19 @@
 #include <uapi/linux/module.h>
 #include "internal.h"
 
-int module_sig_check(struct load_info *info, int flags)
+int module_sig_check(struct load_info *info, const u8 *sig, size_t sig_len)
 {
 	int err;
 	const char *reason;
 	const void *mod = info->hdr;
-	size_t sig_len;
-	const u8 *sig;
-	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
-				       MODULE_INIT_IGNORE_VERMAGIC);
 
-	err = mod_split_sig(info->hdr, &info->len, mangled_module, &sig_len, &sig, "module");
+	err = verify_pkcs7_signature(mod, info->len, sig, sig_len,
+				     VERIFY_USE_SECONDARY_KEYRING,
+				     VERIFYING_MODULE_SIGNATURE,
+				     NULL, NULL);
 	if (!err) {
-		err = verify_pkcs7_signature(mod, info->len, sig, sig_len,
-					     VERIFY_USE_SECONDARY_KEYRING,
-					     VERIFYING_MODULE_SIGNATURE,
-					     NULL, NULL);
-		if (!err) {
-			info->sig_ok = true;
-			return 0;
-		}
+		info->sig_ok = true;
+		return 0;
 	}
 
 	/*

-- 
2.52.0


