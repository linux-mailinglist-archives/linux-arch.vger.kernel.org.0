Return-Path: <linux-arch+bounces-11711-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E4DAA0CB9
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 719153ACDE1
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 016C02D191F;
	Tue, 29 Apr 2025 13:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="jCf1FuP5"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79632AE99;
	Tue, 29 Apr 2025 13:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931887; cv=none; b=ZDWN2h6YuV0hTmTJKrw2CNCZzQymy7lSJEFx3x+LMCUkXCygbyW18Ozj6k9WdPhAuzMiroVK37Nd80eZ+iJQbmi6CEH9WD+4LCiVkF2IwKALrT3dsqG4O42N2YS+TRi5VEj/qt2cfIq+u6LyF6TR2TvcwhDPKu+koZmYSp6egZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931887; c=relaxed/simple;
	bh=7p5y09FCX6rw2O2dfz8EEXV5SO0K/mxanRFmD+rolvo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hy2ugVhByKwO+6Q2a5Cr3BgOVkIeAApoFyHNFk2cICTwr0w1G58w2knl85QHxEp5TPugX/6Mzd6T/WbWxtI1qkXxj8PS2aut1w+KFjCfGv/w6xuQQ9DsuDo9VlFIJtVjHc7ruvIi+CiRpDOUguFqpUv7MbL8zD7AS/rXAlT6PQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=jCf1FuP5; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=7p5y09FCX6rw2O2dfz8EEXV5SO0K/mxanRFmD+rolvo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jCf1FuP5gkPtpI2J67ZEwvsoQWovshmPXIJgnAgTkBIjwpAX1cl+SlZVdP8lbK0lF
	 dyNCKAmz3jl+cPZP+UYIYCLHB6RTBAWzuBWHjoztasuuiDcmPKcQ+dykBBrB4W2yan
	 boTg8x/zKJ/cA9QTJECHOvJd+ozubnscwmhseds8=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:35 +0200
Subject: [PATCH v3 8/9] lockdown: Make the relationship to MODULE_SIG a
 dependency
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-8-00e9258def9e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=874;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=7p5y09FCX6rw2O2dfz8EEXV5SO0K/mxanRFmD+rolvo=;
 b=VEJ2A4fKzTy7xY465KgWvaT7a/7guBneskvjYaYxbUgOTu6Jt4JlWHRzWqSwnAXuU1vhyblv2
 VlDWfdgx/weB5GXKilK4USPkNpBPaQ/yG+9tO8d+lkpC1G8W1BSe/He
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
2.49.0


