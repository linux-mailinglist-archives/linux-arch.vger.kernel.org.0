Return-Path: <linux-arch+bounces-15776-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B0D18DA5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 405A6308F169
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D2392B79;
	Tue, 13 Jan 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="AgYCI5R9"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643DE3921C2;
	Tue, 13 Jan 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307872; cv=none; b=OJigXrdUbf06Td9swvoV69A3CrspTY/TJvGBHGIgQ2PekhF1hb0raeO8pg43eofRez3zIXNIy/FfyAV7NzdQea7b2zSDqqmpFHCiUNs7wTPVk/AEzp66GE1cB9ZcPjaYvDRhvvDHMGdh8TPzCLgGerGoyPoMRhbUCkub7tiYPk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307872; c=relaxed/simple;
	bh=NC/OO27F4y33AwnsUK1UgiJc9IBnwzGy7eK0nVFHjZg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XLEoJqDfTLUXJHEJJVRVjV/DuqpMQmz/otyKbgsApCv/IEGYZhiC0jHqcyUHL7IS+3oufcy83ISp+rZqrM7qF4XiNbaDQLeVAtJNp0PwSwMka07itDxbvAMVSGTCO6Aq/QkOZaSBcf5QdWmwhK9+PWWewn6QgGVbYpgCbrCbG28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=AgYCI5R9; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=NC/OO27F4y33AwnsUK1UgiJc9IBnwzGy7eK0nVFHjZg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AgYCI5R9LpSoJyTXMvTIAgayIlcVm6fKXJaMRcPNzD6ZChkkhpsmCspHhyvT/wRt0
	 r2A2sYDAv+HV4VO9S6NhvDe82s4Iq1jpUM2q/EUwPywnwUH/HUqYIeveQ6kcj/QULj
	 pwxGDBSlpXCztDFg/YCdbKX9Kcxw35OQdzp+Tn/c=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:58 +0100
Subject: [PATCH v4 14/17] lockdown: Make the relationship to MODULE_SIG a
 dependency
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-14-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=818;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=NC/OO27F4y33AwnsUK1UgiJc9IBnwzGy7eK0nVFHjZg=;
 b=whnyma/h0t/rLvPiiVgW2QazugD64J2qmm54nGxJEUn52D2Uhg93xQhjG9IWw62Wsy/Kck9gG
 NGxmuX36RlYD9QmNa4U/SZm822fXAG+a85BnQRjLyq6/k6I3VNwuzEA
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
index e84ddf484010..155959205b8e 100644
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
2.52.0


