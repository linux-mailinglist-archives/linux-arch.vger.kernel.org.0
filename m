Return-Path: <linux-arch+bounces-15775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8F9D18CE5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 721B0301907F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BF7392B8A;
	Tue, 13 Jan 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="YE+kQagF"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9443904F9;
	Tue, 13 Jan 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307872; cv=none; b=As1rXW0pcCi9b74IBpJXc4LonhWtVZoGJ0nC9k6L1L6qMQcwDRnFK8zm3Jg9rQ5ww4bKtuTUpTRXjW8z0Y3gK//dB1Rdvojoq428VbN3kNCWFtdmuuY9N7eILZ5lmllPoLe1fkom0tGFa7gGuujJImQZFHzj2uSacy/VwR/uiKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307872; c=relaxed/simple;
	bh=wiGilzlJGxFjaan6NlKlyZZaDBA2UKvl/XF2WjjMx6k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eNMXLXshANoftsrPSY6ya/fTNkifGGccM1wJnGO+uUOahdod3ot4EtyY6oFA3g5HGmxfxZHX/F7RXKhopVcJ4B5CmDz9DIB2ZQNevW0CNXlL+uYktpW4v8m7/9GJEr/x596zDvd4C5YDEq8Z+SwJtMy15S89Xm4IxWrZ7KD654U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=YE+kQagF; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=wiGilzlJGxFjaan6NlKlyZZaDBA2UKvl/XF2WjjMx6k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YE+kQagFKh9daN0RxItnnroaDWonJFctrKTeWMvLqOvMs2i9t3IWQMf9nRQyJDNRJ
	 HSv4PhKj7Vdtix8kAjUS93d/J4s1s75KZcejQntz3rSuVvDFQkV9CEca7KfYBa1uf3
	 On97uSNgCluCpj+piU3wGzomnlrPzTzs1KtBdfVc=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:57 +0100
Subject: [PATCH v4 13/17] module: Report signature type to users
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-13-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=4866;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=wiGilzlJGxFjaan6NlKlyZZaDBA2UKvl/XF2WjjMx6k=;
 b=KAsSSKg1Ln9puX/5OxsRVwQb8QTjxUUu8XwkrwtE72rnkyqXNI+EKOqMaGUlcezXU7vfnPPeu
 YgXgsZUuxtnBrtSgolQua8rPA0Kqtl5vge+JPQPk7zeD40eqoowxPTw
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming CONFIG_MODULE_HASHES will introduce a signature type.
This needs to be handled by callers differently than PKCS7 signatures.

Report the signature type to the caller and let them verify it.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module_signature.h    |  2 +-
 kernel/module/main.c                |  9 +++++++--
 kernel/module_signature.c           | 14 ++++----------
 security/integrity/ima/ima_modsig.c |  8 +++++++-
 4 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 186a55effa30..a45ce3b24403 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -41,6 +41,6 @@ struct module_signature {
 };
 
 int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
-		  size_t *sig_len, const u8 **sig, const char *name);
+		  enum pkey_id_type *sig_type, size_t *sig_len, const u8 **sig, const char *name);
 
 #endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index d65bc300a78c..2a28a0ece809 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3348,19 +3348,24 @@ static int module_integrity_check(struct load_info *info, int flags)
 {
 	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
 				       MODULE_INIT_IGNORE_VERMAGIC);
+	enum pkey_id_type sig_type;
 	size_t sig_len;
 	const u8 *sig;
 	int err = 0;
 
 	if (IS_ENABLED(CONFIG_MODULE_SIG_POLICY)) {
 		err = mod_split_sig(info->hdr, &info->len, mangled_module,
-				    &sig_len, &sig, "module");
+				    &sig_type, &sig_len, &sig, "module");
 		if (err)
 			return err;
 	}
 
-	if (IS_ENABLED(CONFIG_MODULE_SIG))
+	if (IS_ENABLED(CONFIG_MODULE_SIG) && sig_type == PKEY_ID_PKCS7) {
 		err = module_sig_check(info, sig, sig_len);
+	} else {
+		pr_err("module: not signed with expected PKCS#7 message\n");
+		err = -ENOPKG;
+	}
 
 	if (err)
 		return err;
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index b2384a73524c..8e0ac9906c9c 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -19,18 +19,11 @@
  * @file_len:	Size of the file to which @ms is appended.
  * @name:	What is being checked. Used for error messages.
  */
-static int mod_check_sig(const struct module_signature *ms, size_t file_len,
-			 const char *name)
+static int mod_check_sig(const struct module_signature *ms, size_t file_len, const char *name)
 {
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
 		return -EBADMSG;
 
-	if (ms->id_type != PKEY_ID_PKCS7) {
-		pr_err("%s: not signed with expected PKCS#7 message\n",
-		       name);
-		return -ENOPKG;
-	}
-
 	if (ms->algo != 0 ||
 	    ms->hash != 0 ||
 	    ms->signer_len != 0 ||
@@ -38,7 +31,7 @@ static int mod_check_sig(const struct module_signature *ms, size_t file_len,
 	    ms->__pad[0] != 0 ||
 	    ms->__pad[1] != 0 ||
 	    ms->__pad[2] != 0) {
-		pr_err("%s: PKCS#7 signature info has unexpected non-zero params\n",
+		pr_err("%s: signature info has unexpected non-zero params\n",
 		       name);
 		return -EBADMSG;
 	}
@@ -47,7 +40,7 @@ static int mod_check_sig(const struct module_signature *ms, size_t file_len,
 }
 
 int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
-		  size_t *sig_len, const u8 **sig, const char *name)
+		  enum pkey_id_type *sig_type, size_t *sig_len, const u8 **sig, const char *name)
 {
 	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
 	struct module_signature ms;
@@ -74,6 +67,7 @@ int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
 	if (ret)
 		return ret;
 
+	*sig_type = ms.id_type;
 	*sig_len = be32_to_cpu(ms.sig_len);
 	modlen -= *sig_len + sizeof(ms);
 	*buf_len = modlen;
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index a57342d39b07..a05008324a10 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -41,15 +41,21 @@ int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig)
 {
 	size_t buf_len_sz = buf_len;
+	enum pkey_id_type sig_type;
 	struct modsig *hdr;
 	size_t sig_len;
 	const u8 *sig;
 	int rc;
 
-	rc = mod_split_sig(buf, &buf_len_sz, true, &sig_len, &sig, func_tokens[func]);
+	rc = mod_split_sig(buf, &buf_len_sz, true, &sig_type, &sig_len, &sig, func_tokens[func]);
 	if (rc)
 		return rc;
 
+	if (sig_type != PKEY_ID_PKCS7) {
+		pr_err("%s: not signed with expected PKCS#7 message\n", func_tokens[func]);
+		return -ENOPKG;
+	}
+
 	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
 	hdr = kzalloc(struct_size(hdr, raw_pkcs7, sig_len), GFP_KERNEL);
 	if (!hdr)

-- 
2.52.0


