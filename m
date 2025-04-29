Return-Path: <linux-arch+bounces-11709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28124AA0CAE
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8ABB73A752E
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919F2274670;
	Tue, 29 Apr 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="IP1DdbS6"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8859922AE76;
	Tue, 29 Apr 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931887; cv=none; b=FDFHRS193GJCHyJf1+H0DPL42ICBd2TGtmi55HvnmVjOhuFosZhSqeJccctXoFq+jzenusazl6wvY93OgX2AN4rZQvvnNLg8VAntJRrA6v+FEs0FAqpBtxxz2fMUvLnLxxjPeBLoM7ZM0aNiGyl2k2X7fCWKBQ9li7xWmb/CD1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931887; c=relaxed/simple;
	bh=uAWB6PT9KWFnBAMA3cbexNOM6gBbMJ+pc0ZLJPh/nCk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oSKtpvqqmgK4JSwp3YY1LiVldt+YC3bz4oDI4qKEAfZkh+HMVC+RsK4KY67HG5oowV/l2EHxsFIAT8sCf8Jb1FMI+mLQQg2WTI8jk/C2IuFiLuuQy+d30DlnrK9QWrpIeSMmRaFzdaUzXpRSykwORhuYzEitD+REfodYGeyVK+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=IP1DdbS6; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=uAWB6PT9KWFnBAMA3cbexNOM6gBbMJ+pc0ZLJPh/nCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IP1DdbS6IzaBothHocjADf+qL4oAkLdiurq64F5MflZ0CZDa/lYpWrsml+742YHst
	 iOyI0+5LcIsIS/W4HFdjoT/ntGDbtphulyydXha40XALs+kRmGLCiVLEfgRlEXd44i
	 i3j7qFAN06WEqLbuj3qkp+iO8C4pKXai2Bd1HOA8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:33 +0200
Subject: [PATCH v3 6/9] module: Move integrity checks into dedicated
 function
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-6-00e9258def9e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=2744;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=uAWB6PT9KWFnBAMA3cbexNOM6gBbMJ+pc0ZLJPh/nCk=;
 b=iRF9YHFRJ0F5rufwXzvY22fLGkR188SEbIQOvxK8Ykc40lMoYTbbn3dxF8M1U6Io0VBFSQnub
 DLlawF/4eSbCgHUqpSnuVTwGNU8WrJh6r3nnQCGoXmCtSCexZ7mG2aR
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

With the addition of hash-based integrity checking, the configuration
matrix is easier to represent in a dedicated function and with explicit
usage of IS_ENABLED().

Drop the now unnecessary stub for module_sig_check().

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/internal.h |  7 -------
 kernel/module/main.c     | 18 ++++++++++++++----
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 626cf8668a7eb9202fce13d631f39429a4fe0ace..42fbc53c6af66a1b531fcad08997742d838eb481 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -325,14 +325,7 @@ int module_enable_text_rox(const struct module *mod);
 int module_enforce_rwx_sections(Elf_Ehdr *hdr, Elf_Shdr *sechdrs,
 				char *secstrings, struct module *mod);
 
-#ifdef CONFIG_MODULE_SIG
 int module_sig_check(struct load_info *info, int flags);
-#else /* !CONFIG_MODULE_SIG */
-static inline int module_sig_check(struct load_info *info, int flags)
-{
-	return 0;
-}
-#endif /* !CONFIG_MODULE_SIG */
 
 #ifdef CONFIG_DEBUG_KMEMLEAK
 void kmemleak_load_module(const struct module *mod, const struct load_info *info);
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 83c66205556fdde92152c131f1f58229c4f7f734..0c88d443a3bc894b18a7aa230cadf396e585c415 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3247,6 +3247,16 @@ static int early_mod_check(struct load_info *info, int flags)
 	return err;
 }
 
+static int module_integrity_check(struct load_info *info, int flags)
+{
+	int err = 0;
+
+	if (IS_ENABLED(CONFIG_MODULE_SIG))
+		err = module_sig_check(info, flags);
+
+	return err;
+}
+
 /*
  * Allocate and load the module: note that size of section 0 is always
  * zero, and we rely on this for optional sections.
@@ -3260,18 +3270,18 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	char *after_dashes;
 
 	/*
-	 * Do the signature check (if any) first. All that
-	 * the signature check needs is info->len, it does
+	 * Do the integrity checks (if any) first. All that
+	 * they need is info->len, it does
 	 * not need any of the section info. That can be
 	 * set up later. This will minimize the chances
 	 * of a corrupt module causing problems before
-	 * we even get to the signature check.
+	 * we even get to the integrity check.
 	 *
 	 * The check will also adjust info->len by stripping
 	 * off the sig length at the end of the module, making
 	 * checks against info->len more correct.
 	 */
-	err = module_sig_check(info, flags);
+	err = module_integrity_check(info, flags);
 	if (err)
 		goto free_copy;
 

-- 
2.49.0


