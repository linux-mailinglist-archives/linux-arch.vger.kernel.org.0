Return-Path: <linux-arch+bounces-15772-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BF7ED18D7B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD86B3044201
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0D7392803;
	Tue, 13 Jan 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="c11joj4q"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1C93904D8;
	Tue, 13 Jan 2026 12:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307871; cv=none; b=qSlq2aFnpX0swG2fK/DxSfIzedYplvQYBy9ZtfSP2gtDj7KotMlEqm6//LcdI3VJUK9nTc+ZI7iieVX04gH6W8C5VXgClOxodD9rNfNAp+mYEbORQ2t+lCPKsqhYQgg3jqU/G0b3jZ0cUTVXtwsNzof83dyc202dO9H8YaW2Mb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307871; c=relaxed/simple;
	bh=AQXwlX52KxlPEn4u0pj+ZozDxqAQgmwa0bwnrtMfO2o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=n8adqeqzcQ1VVJRQNgmA8PC1HbEOu1XeLZ9pRP2ykYHEJ8LhBUIgJG/lyw3VHdhE8TCwaYFMOQN4uBJr9MGvxVaMXp6/6gNV9Rvh12WCH6jFkscXpHIXVa8YB+QXL9I5t/rmT1iduYsPcUylJOSqqsP69vtJWm3wimwIMqgGKDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=c11joj4q; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=AQXwlX52KxlPEn4u0pj+ZozDxqAQgmwa0bwnrtMfO2o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c11joj4qS+McPfr25fP7A7kNvS54i2wodhNwGm8BF8MCHBCTbxTURec2JoyZDdRLa
	 Kw17+gExC9oSprSJCnNAf0nQsgFYPfgN6utQbd3WSPey3DtHOjtQxfI3MZ2PKPf3+h
	 eArjJN7G84s4hKv5pQDHE51Nz9g0vsrfcVsPQXdw=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:55 +0100
Subject: [PATCH v4 11/17] module: Move lockdown check into generic module
 loader
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-11-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1463;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=AQXwlX52KxlPEn4u0pj+ZozDxqAQgmwa0bwnrtMfO2o=;
 b=6Vy1azrI605whNaZMGmixiJa2Dmq7kFxo81sevB94fs40VlaNg6/O/Qz3rsQ10vnnq984b5K0
 ZZT91klbjx1D5nQcLz0zpYHmdyhSDmffrqm+1UCDCPp4hIbzpVmoMks
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
index 9c570078aa9c..c09b25c0166a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -3351,7 +3351,11 @@ static int module_integrity_check(struct load_info *info, int flags)
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
index 66d90784de89..8a5f66389116 100644
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
@@ -68,5 +67,5 @@ int module_sig_check(struct load_info *info, int flags)
 		return -EKEYREJECTED;
 	}
 
-	return security_locked_down(LOCKDOWN_MODULE_SIGNATURE);
+	return 0;
 }

-- 
2.52.0


