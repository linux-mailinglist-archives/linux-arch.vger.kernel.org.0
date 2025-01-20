Return-Path: <linux-arch+bounces-9823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F621A17237
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 18:45:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B01A7A0605
	for <lists+linux-arch@lfdr.de>; Mon, 20 Jan 2025 17:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E635F1EE029;
	Mon, 20 Jan 2025 17:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="pvkeEPHr"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFCE1DFE14;
	Mon, 20 Jan 2025 17:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737395144; cv=none; b=fWNE3xaEsCe8lKQNaXCUkSQu5nW80OpTwezd4J6iFUQUl2/JkxttyH6S2nsSJ+GeqqDXcX4iFDULIykBTqHCbgFjf6ilsfvrc8gg5Q9BEm9edQGKFHQjxvH78akIif20brdz98sIdXcLq28bvnL5AcGQBObQn5YeLLtSmQm9v2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737395144; c=relaxed/simple;
	bh=eFE8eKbO4pWZaL11j78KVv6utQAl0cUhH525xL6hI5o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YoWsUOwYXZSUoW321LP3wInegDIXWnBH72R8BK3R5ej0DTReC0jChPuglvJrtEdIZeOgsFG03O4N1FJ+d0OjelSPurnNAtsgo3z+Gm9LpMTCayOJtAXJhD8DGPCeyoBLNQWswuMdsYNZzpUwikc2gMqtuwQZ+VTwAdX2IMwFW8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=pvkeEPHr; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1737395133;
	bh=eFE8eKbO4pWZaL11j78KVv6utQAl0cUhH525xL6hI5o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pvkeEPHrKRw+yfyKuOPjl3X46G0uP5F+Wg36ErvPQhBHP6vUXdrpZjXrw9NcMcmtK
	 pnRHrNi0dbUlvHnhfakwdOPhXl6r71BLvGs7jYe6Hw9dYkW0nQJ9PWdiIw+7eNvEY/
	 7mh2ctMUYT94pg0iN2/DrP7wCoVBtiNxN1T3a8IY=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Mon, 20 Jan 2025 18:44:24 +0100
Subject: [PATCH v2 5/6] lockdown: Make the relationship to MODULE_SIG a
 dependency
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250120-module-hashes-v2-5-ba1184e27b7f@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1737395132; l=874;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=eFE8eKbO4pWZaL11j78KVv6utQAl0cUhH525xL6hI5o=;
 b=8dA83wKAd3Hc6tOftrWqF/p7g+4ibEoT3lyBhHTbTQ7dsE2V7oG4U+strj5pxZV+ykpvxhAI6
 AgAp3mLUgFkCx2AaxTMMLuYhpt+4Znru3wpqIF3NmQX8OMDaR7EOI78
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The new hash-based module integrity checking will also be able to
satisfy the requirements of lockdown.
Such an alternative is not representable with "select", so use
"depends on" instead.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 security/lockdown/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/lockdown/Kconfig b/security/lockdown/Kconfig
index e84ddf48401010bcc0829a32db58e6f12bfdedcb..155959205b8eac2c85897a8c4c8b7ec471156706 100644
--- a/security/lockdown/Kconfig
+++ b/security/lockdown/Kconfig
@@ -1,7 +1,7 @@
 config SECURITY_LOCKDOWN_LSM
 	bool "Basic module for enforcing kernel lockdown"
 	depends on SECURITY
-	select MODULE_SIG if MODULES
+	depends on !MODULES || MODULE_SIG
 	help
 	  Build support for an LSM that enforces a coarse kernel lockdown
 	  behaviour.

-- 
2.48.1


