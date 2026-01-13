Return-Path: <linux-arch+bounces-15774-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A343D18DA2
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 594D43047D9A
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B823921E7;
	Tue, 13 Jan 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="nykdCqRX"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241B38FF1A;
	Tue, 13 Jan 2026 12:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307871; cv=none; b=kim8t7sNuPFkRN/rfrn0pXMqHS88/ZuDuXB6QqYwX1An4qsXNn1NfbOJnl+N1BcGyGMIcZYvfi8ANmkkWauCAatvDr01Da4PpAuk5zJWt6m8gS9uh0xatDzGF8tagX/eNNCR/jnp14m38me/1prEpOsmO8yc8ag+s7hOoLBSCtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307871; c=relaxed/simple;
	bh=s0y09ejJrfvI6BDYjzt+p3QqNUHYOG0PUerqb17chAU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OByGE0OiU8jcgTjHJTJMIcg8VpFsiV+jIqWsUbxFfSCOrptEiA/fADpNL9rzVrZ4ioGqalKkhjko9IP3z6nAY2j0b01QVrU1I4oRNW98tY0/Sdi1DMAHvEVVDf1ZttnIDQ7pXlh3zvVHoayz0CIA8YYG6tb9Vt6rIanCeLP0aiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=nykdCqRX; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=s0y09ejJrfvI6BDYjzt+p3QqNUHYOG0PUerqb17chAU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nykdCqRXMQEPNNVhqI4IMkhiOVHlWWTvYcRj6i/WpHHMJuriU0oAdA6iaFR0bxyCp
	 RqnMAFimntilzRwbpGFb977FfLmG7lTw2tkOB7UXSOpSKEZ4eUzY5XEw2iK3gIXums
	 KLNufKaP8k/iv8PG/rUfSk4ssFbwf0H+NXhvUH2g=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:48 +0100
Subject: [PATCH v4 04/17] module: Make mod_verify_sig() static
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-4-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1228;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=s0y09ejJrfvI6BDYjzt+p3QqNUHYOG0PUerqb17chAU=;
 b=uwg0wFTAu3Q06NkGGP+SClBTEtm6t/P9IPUONWe98bNwGb9YkRYeWkqllddS3Jy0aw5RpuMhA
 a43F4kdpYaJAlRRI+ZcWb/HGQ+OCDraXpoYd0EBmq25H2uVLsqPNyev
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

It is not used outside of signing.c.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 kernel/module/internal.h | 1 -
 kernel/module/signing.c  | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 618202578b42..e68fbcd60c35 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -119,7 +119,6 @@ struct module_use {
 	struct module *source, *target;
 };
 
-int mod_verify_sig(const void *mod, struct load_info *info);
 int try_to_force_load(struct module *mod, const char *reason);
 bool find_symbol(struct find_symbol_arg *fsa);
 struct module *find_module_all(const char *name, size_t len, bool even_unformed);
diff --git a/kernel/module/signing.c b/kernel/module/signing.c
index a2ff4242e623..fe3f51ac6199 100644
--- a/kernel/module/signing.c
+++ b/kernel/module/signing.c
@@ -40,7 +40,7 @@ void set_module_sig_enforced(void)
 /*
  * Verify the signature on a module.
  */
-int mod_verify_sig(const void *mod, struct load_info *info)
+static int mod_verify_sig(const void *mod, struct load_info *info)
 {
 	struct module_signature ms;
 	size_t sig_len, modlen = info->len;

-- 
2.52.0


