Return-Path: <linux-arch+bounces-15773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC03D18CBE
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 338783015AD5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDFA392812;
	Tue, 13 Jan 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="SQt5bsbc"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA63904CB;
	Tue, 13 Jan 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307871; cv=none; b=epV6CouOiNIzYPw/O2jSF5Zv7b01GpDlrj4sy/y1eP8akB2zVeHsEBvg33aHPR68ccmVbeAINA40flqKTG1Ne0d8bOhlNsbTq3rZVl6veUeH9gwG8SrQGWQoBI7ab5m9lxQtl6CcsHNG3NaSGtbxy5Ezx/KMscMw8g0UGQ1y4WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307871; c=relaxed/simple;
	bh=CQhD/KGKFcEkKh29q46LO6yIz88u0jgba+z/o0psTK8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mJ/BPxk2oYqsi/cfIM9VfUlnjAkdZn/2SVNqaVmFtuy3HteQcPR4XAslp3k0aeB1BV1No/hB1oS7n4eh8o6GNynF3FWIfWbnku7itBQ1zeT2oeOvznFpHa1rhairb+hBNshWz652xQchq4aThP58E+KKr7AiVl+h1UPBC+Cx890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=SQt5bsbc; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=CQhD/KGKFcEkKh29q46LO6yIz88u0jgba+z/o0psTK8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SQt5bsbcTnZS6yVdJ+LbYNoNhZEev1knGv0MjS71iiJfYlcuZyQ0aclRnK2Kr2PEq
	 pavJTbLtAToGXld4GXml/FzTK76fJkWiqqk/Kz8PX+XPWi3Lxu2deHodM7LlKElFYY
	 diHZjbVi1BV4pnlweGQP0Xpvny06OHosoDM+JiQE=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:52 +0100
Subject: [PATCH v4 08/17] module: Deduplicate signature extraction
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-8-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=6766;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=CQhD/KGKFcEkKh29q46LO6yIz88u0jgba+z/o0psTK8=;
 b=Lgwo+6a5vIb8KpZTzvY+IyZL0lz4STVveaUDYDrKMqidgIHufGS8BuIXNHMAXiv7IHzs4yXTq
 YDRiGJTfok3AifwJoS+EQEosFVHWUVaOei8HsTi+t5sMgtnUNgIVDKo
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The logic to extract the signature bits from a module file are
duplicated between the module core and IMA modsig appraisal.

Unify the implementation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 include/linux/module_signature.h    |  4 +--
 kernel/module/signing.c             | 52 +++++++------------------------------
 kernel/module_signature.c           | 41 +++++++++++++++++++++++++++--
 security/integrity/ima/ima_modsig.c | 24 ++++-------------
 4 files changed, 56 insertions(+), 65 deletions(-)

diff --git a/include/linux/module_signature.h b/include/linux/module_signature.h
index 7eb4b00381ac..186a55effa30 100644
--- a/include/linux/module_signature.h
+++ b/include/linux/module_signature.h
@@ -40,7 +40,7 @@ struct module_signature {
 	__be32	sig_len;	/* Length of signature data */
 };
 
-int mod_check_sig(const struct module_signature *ms, size_t file_len,
-		  const char *name);
+int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
+		  size_t *sig_len, const u8 **sig, const char *name);
 
 #endif /* _LINUX_MODULE_SIGNATURE_H */
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index fe3f51ac6199..6d64c0d18d0a 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -37,54 +37,22 @@ void set_module_sig_enforced(void)
 	sig_enforce = true;
 }
 
-/*
- * Verify the signature on a module.
- */
-static int mod_verify_sig(const void *mod, struct load_info *info)
-{
-	struct module_signature ms;
-	size_t sig_len, modlen = info->len;
-	int ret;
-
-	pr_devel("==>%s(,%zu)\n", __func__, modlen);
-
-	if (modlen <= sizeof(ms))
-		return -EBADMSG;
-
-	memcpy(&ms, mod + (modlen - sizeof(ms)), sizeof(ms));
-
-	ret = mod_check_sig(&ms, modlen, "module");
-	if (ret)
-		return ret;
-
-	sig_len = be32_to_cpu(ms.sig_len);
-	modlen -= sig_len + sizeof(ms);
-	info->len = modlen;
-
-	return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
-				      VERIFY_USE_SECONDARY_KEYRING,
-				      VERIFYING_MODULE_SIGNATURE,
-				      NULL, NULL);
-}
-
 int module_sig_check(struct load_info *info, int flags)
 {
-	int err = -ENODATA;
-	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	int err;
 	const char *reason;
 	const void *mod = info->hdr;
+	size_t sig_len;
+	const u8 *sig;
 	bool mangled_module = flags & (MODULE_INIT_IGNORE_MODVERSIONS |
 				       MODULE_INIT_IGNORE_VERMAGIC);
-	/*
-	 * Do not allow mangled modules as a module with version information
-	 * removed is no longer the module that was signed.
-	 */
-	if (!mangled_module &&
-	    info->len > markerlen &&
-	    memcmp(mod + info->len - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
-		/* We truncate the module to discard the signature */
-		info->len -= markerlen;
-		err = mod_verify_sig(mod, info);
+
+	err = mod_split_sig(info->hdr, &info->len, mangled_module, &sig_len, &sig, "module");
+	if (!err) {
+		err = verify_pkcs7_signature(mod, info->len, sig, sig_len,
+					     VERIFY_USE_SECONDARY_KEYRING,
+					     VERIFYING_MODULE_SIGNATURE,
+					     NULL, NULL);
 		if (!err) {
 			info->sig_ok = true;
 			return 0;
diff --git a/kernel/module_signature.c b/kernel/module_signature.c
index 00132d12487c..b2384a73524c 100644
--- a/kernel/module_signature.c
+++ b/kernel/module_signature.c
@@ -8,6 +8,7 @@
 
 #include <linux/errno.h>
 #include <linux/printk.h>
+#include <linux/string.h>
 #include <linux/module_signature.h>
 #include <asm/byteorder.h>
 
@@ -18,8 +19,8 @@
  * @file_len:	Size of the file to which @ms is appended.
  * @name:	What is being checked. Used for error messages.
  */
-int mod_check_sig(const struct module_signature *ms, size_t file_len,
-		  const char *name)
+static int mod_check_sig(const struct module_signature *ms, size_t file_len,
+			 const char *name)
 {
 	if (be32_to_cpu(ms->sig_len) >= file_len - sizeof(*ms))
 		return -EBADMSG;
@@ -44,3 +45,39 @@ int mod_check_sig(const struct module_signature *ms, size_t file_len,
 
 	return 0;
 }
+
+int mod_split_sig(const void *buf, size_t *buf_len, bool mangled,
+		  size_t *sig_len, const u8 **sig, const char *name)
+{
+	const unsigned long markerlen = sizeof(MODULE_SIG_STRING) - 1;
+	struct module_signature ms;
+	size_t modlen = *buf_len;
+	int ret;
+
+	/*
+	 * Do not allow mangled modules as a module with version information
+	 * removed is no longer the module that was signed.
+	 */
+	if (!mangled &&
+	    *buf_len > markerlen &&
+	    memcmp(buf + modlen - markerlen, MODULE_SIG_STRING, markerlen) == 0) {
+		/* We truncate the module to discard the signature */
+		modlen -= markerlen;
+	}
+
+	if (modlen <= sizeof(ms))
+		return -EBADMSG;
+
+	memcpy(&ms, buf + (modlen - sizeof(ms)), sizeof(ms));
+
+	ret = mod_check_sig(&ms, modlen, name);
+	if (ret)
+		return ret;
+
+	*sig_len = be32_to_cpu(ms.sig_len);
+	modlen -= *sig_len + sizeof(ms);
+	*buf_len = modlen;
+	*sig = buf + modlen;
+
+	return 0;
+}
diff --git a/security/integrity/ima/ima_modsig.c b/security/integrity/ima/ima_modsig.c
index 3265d744d5ce..a57342d39b07 100644
--- a/security/integrity/ima/ima_modsig.c
+++ b/security/integrity/ima/ima_modsig.c
@@ -40,44 +40,30 @@ struct modsig {
 int ima_read_modsig(enum ima_hooks func, const void *buf, loff_t buf_len,
 		    struct modsig **modsig)
 {
-	const size_t marker_len = strlen(MODULE_SIG_STRING);
-	const struct module_signature *sig;
+	size_t buf_len_sz = buf_len;
 	struct modsig *hdr;
 	size_t sig_len;
-	const void *p;
+	const u8 *sig;
 	int rc;
 
-	if (buf_len <= marker_len + sizeof(*sig))
-		return -ENOENT;
-
-	p = buf + buf_len - marker_len;
-	if (memcmp(p, MODULE_SIG_STRING, marker_len))
-		return -ENOENT;
-
-	buf_len -= marker_len;
-	sig = (const struct module_signature *)(p - sizeof(*sig));
-
-	rc = mod_check_sig(sig, buf_len, func_tokens[func]);
+	rc = mod_split_sig(buf, &buf_len_sz, true, &sig_len, &sig, func_tokens[func]);
 	if (rc)
 		return rc;
 
-	sig_len = be32_to_cpu(sig->sig_len);
-	buf_len -= sig_len + sizeof(*sig);
-
 	/* Allocate sig_len additional bytes to hold the raw PKCS#7 data. */
 	hdr = kzalloc(struct_size(hdr, raw_pkcs7, sig_len), GFP_KERNEL);
 	if (!hdr)
 		return -ENOMEM;
 
 	hdr->raw_pkcs7_len = sig_len;
-	hdr->pkcs7_msg = pkcs7_parse_message(buf + buf_len, sig_len);
+	hdr->pkcs7_msg = pkcs7_parse_message(sig, sig_len);
 	if (IS_ERR(hdr->pkcs7_msg)) {
 		rc = PTR_ERR(hdr->pkcs7_msg);
 		kfree(hdr);
 		return rc;
 	}
 
-	memcpy(hdr->raw_pkcs7, buf + buf_len, sig_len);
+	memcpy(hdr->raw_pkcs7, sig, sig_len);
 
 	/* We don't know the hash algorithm yet. */
 	hdr->hash_algo = HASH_ALGO__LAST;

-- 
2.52.0


