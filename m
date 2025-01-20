Return-Path: <linux-arch+bounces-9827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39363A17249
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0F861887F81
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:46:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBAC1EF0A9;
	Mon, 20 Jan 2025 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="fUAhGFvi"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF3140C03;
	Mon, 20 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395145; cv=none; b=PRMGgG59rjo7jSpCzWfKN3wh+GYbQkPycuTPWOGOYLP/4dqGEw1RokR2FOQl3X4qEyVwvM9hcSZL7ND+BzBbIRbOivrRAV2shaEXkdE6KPQZCJw52kO36NsyVQsuLvb8lJQIOTSxPLq4w41B9+vmvBl6K3FKT3Q/krRLpYuabok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395145; c=relaxed/simple;
	bh=PeJKb4hucwQgPB+ZRwTgF5LxeJD4ryt7mGorsuT2C9g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tr1Xlh97jPW89YyscDAuTiQ9MiQldGnC1Kb1cJ45bN2Ep1qlE2XYzz4XrCzgUlX2fA1ogWltS9wXP/qGY37pJVAz+BdXbvIeSHEn6jVKoHgZ0RhCQsguH0jdhu+J5S4MCw/rLNRaX6Yqbi/P7w/IRW7DM5CoTz/syaSmI4OMKxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=fUAhGFvi; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395132;
	bh=PeJKb4hucwQgPB+ZRwTgF5LxeJD4ryt7mGorsuT2C9g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=fUAhGFvieGibWp2VJmcpy+GwxnXo2KS7qPDW+BktqS1oLNeoxcP2ktKAa1UZ37IdP
	 zjg77gozyVh6X8wJlH94CVtO+kLJBVEEenN88DK0Oa2Sjf71zD4SKKF+NasNo11hGf
	 GL0p+PatwRzAfikNHczJomBPMnodvreHB6hiWkUY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:23 +0100
Subject: [PATCH v2 4/6] module: Move lockdown check into generic module
 loader
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-4-ba1184e27b7f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=1576;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=PeJKb4hucwQgPB+ZRwTgF5LxeJD4ryt7mGorsuT2C9g=;
 b=F83ENlvy7TmkkAZ5zKo3BpFCXUyf+IXj0q3zgdOerpkiq/H1Wyk9IbPP1VIPrf/y3PCF4tE0t
 DcnM4fQ/FUzD7gs+b3l4suCtjYHdrwExXswam8suyFL4bDqqqwyn5+g
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The lockdown check buried in module_sig_check() will not compose well
with the introduction of hash-based module validation.
Move it into module_integrity_check() which will work better.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/main.c    | 6 +++++-
 kernel/module/signing.c | 3 +--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index c0ab5c37f9710a0091320c4d171275e63be9217e..effe1db02973d4f60ff6cbc0d3b5241a3576fa3e 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3221,7 +3221,11 @@ static int module_integrity_check(struct load_info *info, int flags)
 	if (IS_ENABLED(CONFIG_MODULE_SIG))
 		err = module_sig_check(info, flags);
 
-	return err;
+	if (err)
+		return err;
+	if (info->sig_ok)
+		return 0;
+	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
 }
 
 /*
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index e51920605da14771601327ea596dad2e12400518..029e1ef6f0e369fd48e8c81154b6c697ad7a6249 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -11,7 +11,6 @@
 #include <linux/module_signature.h>
 #include <linux/string.h>
 #include <linux/verification.h>
-#include <linux/security.h>
 #include <crypto/public_key.h>
 #include <uapi/linux/module.h>
 #include "internal.h"
@@ -100,5 +99,5 @@ int module_sig_check(struct load_info *info, int flags)
 		return -EKEYREJECTED;
 	}
 
-	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+	return 0;
 }

-- 
2.48.1


