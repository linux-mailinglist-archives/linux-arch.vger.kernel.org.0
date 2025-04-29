Return-Path: <linux-arch+bounces-11717-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AAD4AA0CE3
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F5707B3041
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381472D4B7A;
	Tue, 29 Apr 2025 13:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="WtCigX7B"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8970B2D29C7;
	Tue, 29 Apr 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931892; cv=none; b=F6mzS2a8/rxVzNosuGE2rRiaWjt9jznYf8y9Y+jFX4SF0+7iba5h78M313bXvM3Q7Yftn+4UEqjguWUZJ4uqynxUeQVtA6EO96kPcvw9cN1ks/mUTqDR7wjK5UhXcAOd2PFwi1XODqpvtMr0inCRh6hukyD0+EFzJydRpTp/i5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931892; c=relaxed/simple;
	bh=kmQUIW+5wYPfShUIrOsErGdMJNnQUWIZ+BIWQSkTJR8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pfKHsZaSZwZpmPPv9xyzAsXAakQT1fK6cJOXBqozSPGeUoQMW/K1GEKDcWGqLmhGflzyR+GxpJFTBU673qCw5Uk2a1z5mmJwBjNXYP5hcF8X6qD/dc/sKCxhXISvz9b4tc0voWvl3JLemexvxrxx9uytLojfn4b1wsC1z4CNMes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=WtCigX7B; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=kmQUIW+5wYPfShUIrOsErGdMJNnQUWIZ+BIWQSkTJR8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=WtCigX7BHHuvjnDxDfwmcSBeyBTCRfjxFnCfp2BR4OAm8h26gm2cA1/Y41MLSAFgt
	 1Lui6JugA7ZpyRc/IZB1OjD42wB3i+36XOrIwAmkctFHApWN8n8eNQWTRbRgCPvph3
	 brq4Vp0mkbXBZ/i62ncTuTb5J/ZgYF05LkJovw2Q=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:34 +0200
Subject: [PATCH v3 7/9] module: Move lockdown check into generic module
 loader
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-7-00e9258def9e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=1576;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=kmQUIW+5wYPfShUIrOsErGdMJNnQUWIZ+BIWQSkTJR8=;
 b=UeBVXcH7NmJEkR+38OyjzyfoU04GJpL9A/GpeD8/tUNbtYa0RNhFf/oUemhiWfy3i/HNqh5wb
 6448IhPkVJ2DZ12vw7Fz0/2aJ9GNQhLh065QNg6B4NkyTQK1vbDsDIR
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
index 0c88d443a3bc894b18a7aa230cadf396e585c415..1c353ece05fd1d2d709204e4d5fa44ecb8832bfa 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3254,7 +3254,11 @@ static int module_integrity_check(struct load_info *info, int flags)
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
2.49.0


