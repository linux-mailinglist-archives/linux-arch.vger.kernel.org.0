Return-Path: <linux-arch+bounces-11708-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28758AA0CAB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 15:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3035A483F5B
	for <lists+linux-arch@lfdr.de>; Tue, 29 Apr 2025 13:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC5E2C2AC2;
	Tue, 29 Apr 2025 13:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="ndr5eUgV"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BCD21325C;
	Tue, 29 Apr 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745931887; cv=none; b=p9Tfecl2YqHoPajQO1glOYhV/hPNDkLIjkcWQIIX2iw5yFb6TdUIjTfov6VkzjbyvzN6i2VNYxPbvJRNqkYk3y5ADvfskvV4+cV/wJHWt2nLQedUaHz5FVmrqtqg4XxTHMqO5E5/PyIC0+aeGK0lCAGKhYromLvMgpQYQvgvg58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745931887; c=relaxed/simple;
	bh=d/NdlzD2KV2pF2aazqdTVXD1jSSYLt8dgjzDd7PvoPo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P0UnnbS11tEtaitF4W3lQk1ZGOuXwQ2Nj2c9F4RX4j8CEAZ0thTICwsSeB/yTeL4dNIyGxor97O2lS4e1CVnITO+GmKMt1djm0OasOo6VKJ07hI29l27Dyt6oa5xNpjs6AaVgF/BGC3zaJtjmIDoFjFcouxA8aPqvvshcHkQhTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=ndr5eUgV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1745931874;
	bh=d/NdlzD2KV2pF2aazqdTVXD1jSSYLt8dgjzDd7PvoPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ndr5eUgVSV+gAn8uBtqf5gkqDazOK0n25l02cugLtcQTuqMr/LNpa6t6wzbfuMAjH
	 12Qulrdyx2c2aBEE5Yq6GwMxJfjD8udHNeMcCf4DwcNNIpMaOWa5/Pa3TCszUfVEud
	 TJ/gfqJ/aj7cVBefjCJblpJsOrMKeMlWCvvIu+FQ=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 29 Apr 2025 15:04:28 +0200
Subject: [PATCH v3 1/9] powerpc/ima: Drop unnecessary check for
 CONFIG_MODULE_SIG
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250429-module-hashes-v3-1-00e9258def9e@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745931873; l=1136;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=d/NdlzD2KV2pF2aazqdTVXD1jSSYLt8dgjzDd7PvoPo=;
 b=xAYAenyFdE04MOoAyCY51VYJoTBGGcK4Soq/RQ+egxA1KIPa8xT21DSMBRyeZrix2b6b8RUK5
 4oPcru3LJfZABty4/kT+0dOo2ZPe8NuL+rpxUHGjPov6s65d3wYcJWl
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

When CONFIG_MODULE_SIG is disabled set_module_sig_enforced() is defined
as an empty stub, so the check is unnecessary.
The specific configuration option for set_module_sig_enforced() is
about to change and removing the check avoids some later churn.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

---
This patch is not strictly necessary right now, but makes looking for
usages of CONFIG_MODULE_SIG easier.
---
 arch/powerpc/kernel/ima_arch.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/ima_arch.c b/arch/powerpc/kernel/ima_arch.c
index b7029beed847dc0acf15b3edbdd7fe9e60626f24..690263bf4265c78331b5f306097543ce12ac7dbd 100644
--- a/arch/powerpc/kernel/ima_arch.c
+++ b/arch/powerpc/kernel/ima_arch.c
@@ -63,8 +63,7 @@ static const char *const secure_and_trusted_rules[] = {
 const char *const *arch_get_ima_policy(void)
 {
 	if (is_ppc_secureboot_enabled()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
+		set_module_sig_enforced();
 
 		if (is_ppc_trustedboot_enabled())
 			return secure_and_trusted_rules;

-- 
2.49.0


