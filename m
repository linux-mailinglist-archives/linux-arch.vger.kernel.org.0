Return-Path: <linux-arch+bounces-9825-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F0BA17241
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:46:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DA731887FFF
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7D71EEA49;
	Mon, 20 Jan 2025 17:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="D6vm50TG"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF7314F9F7;
	Mon, 20 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395145; cv=none; b=vFqLwNmz5jhQbnLBaJwBEHme0sIbIcXU7C/oeeYPZ9xhR3/zHGJdnsv/JBfTE84VRz14oOxkjX8wOHuenS+JqpV98jAroZ1sijPQfpjlvmKD40/Uv0FXHt0bom8CDCN2JmHAtAXQay02IibuBtO8LfV20PECDe/uMkqJ+hnERpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395145; c=relaxed/simple;
	bh=2c+/qat5XA+uZgTnXYB6U4MX9z83arDQnMX03CXPK+s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XZwlI/k8ItSESk6XZteU60tluwWl7yVnc939ITU+iiV/9J/VlVVTjaK2+ArtXOz8vGySrs+XBARNbNSLU/ySf4RvwS2IXbpgn7X6XdTP0Eoss71UdwvW24C449VpAM4W2mhyA4jjulNNhuRz1mFtMVmXj06a/8pUN5TIFBCzv+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=D6vm50TG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395132;
	bh=2c+/qat5XA+uZgTnXYB6U4MX9z83arDQnMX03CXPK+s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=D6vm50TGB1jQOvVpvu7AVmGxOJ8i/+4/65Bv6iluU7C8EYQQrOH39UaY6dC1AzjjP
	 nWxk/HETwFk8oneQiIcS5MgkzElt8KvZXuW9ensotwXUSBbhx9yuzdA2lqQ4ICdLU6
	 kNyY0jOVuXIMQbmqVfCDEYnsbZC54hg2XJA2TeTw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:22 +0100
Subject: [PATCH v2 3/6] module: Move integrity checks into dedicated
 function
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-3-ba1184e27b7f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=2744;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=2c+/qat5XA+uZgTnXYB6U4MX9z83arDQnMX03CXPK+s=;
 b=drJV/f5DoXRznw97YMXiSAlAgXD0xKYklcfG5wuaksgRDgol3GdfurQjp2Nlf05qIoH+7uhEQ
 cHJr3OrmlnHCwOeUtuPxf13avRmM7nTITERDOcnenlp53V2e/zuXmmD
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
index daef2be8390222c22220e2f168baa8d35ad531b9..c30abeefa60b884c4a69b1eb4f1123a4bbee4b47 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -333,14 +333,7 @@ int module_enable_text_rox(const struct module *mod);
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
index 8aa593fee22a227a482466dceda4a6b657b956e0..c0ab5c37f9710a0091320c4d171275e63be9217e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3214,6 +3214,16 @@ static int early_mod_check(struct load_info *info, int flags)
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
@@ -3227,18 +3237,18 @@ static int load_module(struct load_info *info, const char __user *uargs,
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
2.48.1


