Return-Path: <linux-arch+bounces-15765-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 88491D18C97
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:38:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D7473047AE8
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CED538F92C;
	Tue, 13 Jan 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="m5ECJ6X/"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755B438A28E;
	Tue, 13 Jan 2026 12:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307866; cv=none; b=YqnzGoxvUI46dqQ5IFQsHsHM4sPfl7wf/+qf1W+EDbIV6x4NzO8P7ixU2p8wrPoT9vgnaBC4XLCjl0omENfGXVK7VFQNFv+DUyl+OYd3iDDnPbDOpnlYPPt+3muu5NfiLYymrbYcXmCOjUf52O1ZDhltXSIxOzraVz+iy+gLKV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307866; c=relaxed/simple;
	bh=cH9hJBEevnJ49scFzUyUrs+duB8iThavsLBCgzxemds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Deq0KnchX4QfI5187BAtuE5iq1ikbvIsSEdRQws5xGgbNmZs+KHMVpDlZhwdYnP+AUD8WWomH50eitYq81AtaRbgJcryeB8W9YpIt0kktHnyrGgbf5BcYL+dezdvspbeStbi/HjN9Os3lv4JwC7M1P5eyOXPjsFjX3Gyh7NKPFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=m5ECJ6X/; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=cH9hJBEevnJ49scFzUyUrs+duB8iThavsLBCgzxemds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m5ECJ6X/QaGYYVd8gwsKPP3oGytpVyG0r3Uure3LqKvDfD7fS93swFK2vKC7qzTnO
	 zFYbmk4LuDfRARPYZL9g9jAh2pluAJo1Spu3BdNBCB4MygUV9lYuGjf6mh3vf9gxTp
	 x7hqYzB44ciHVigcRi1d+0nk8Ev05d0JMTMoOKLo=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:47 +0100
Subject: [PATCH v4 03/17] ima: efi: Drop unnecessary check for
 CONFIG_MODULE_SIG/CONFIG_KEXEC_SIG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-3-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1076;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=cH9hJBEevnJ49scFzUyUrs+duB8iThavsLBCgzxemds=;
 b=CON7x2gCVyCQfJTzLvPSJLu+RVHaHl90Rmo7S6bsrPvzOetmH8vys3eBJrk7ccHlghC7itUU1
 0QyuXSdksdyD+ykU1MTXaHxR9OmHct0jSB8PawQ2bRSqkoOkmuG6Y9X
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When configuration settings are disabled the guarded functions are
defined as empty stubs, so the check is unnecessary.
The specific configuration option for set_module_sig_enforced() is
about to change and removing the checks avoids some later churn.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 security/integrity/ima/ima_efi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
index 138029bfcce1..a35dd166ad47 100644
--- a/security/integrity/ima/ima_efi.c
+++ b/security/integrity/ima/ima_efi.c
@@ -68,10 +68,8 @@ static const char * const sb_arch_rules[] = {
 const char * const *arch_get_ima_policy(void)
 {
 	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
-		if (IS_ENABLED(CONFIG_KEXEC_SIG))
-			set_kexec_sig_enforced();
+		set_module_sig_enforced();
+		set_kexec_sig_enforced();
 		return sb_arch_rules;
 	}
 	return NULL;

-- 
2.52.0


