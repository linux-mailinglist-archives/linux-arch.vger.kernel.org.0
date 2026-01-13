Return-Path: <linux-arch+bounces-15771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2011D18D72
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4220730768F6
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E003238F94B;
	Tue, 13 Jan 2026 12:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="l9994pIG"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF8438F947;
	Tue, 13 Jan 2026 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307870; cv=none; b=NSRc+K3tYkCevOYCpNh/p3mMNseensKUPggl0mCy1I5GAcc3wuKORNcixY/Qct9D9LSYf0i42rMfP06udQei+QoP+IMWbe7v+kxkS9sz7tgwjoEiFhzEWOxyuwTm7p8UUw609ynqD507OtMMRZkVP/B2H8ND+ATe1Wcce9kQcFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307870; c=relaxed/simple;
	bh=JwM9XO7r7ZwPZmNYUvzPqz3+qo59nyUUWymAQNZfvpo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjTnndfZYy3vJoH74fgvXJINb51kTH6AhVKzEuEgDKKDEJ5fFBwayKCrBUnQ71omhGapmGEvdolezDk8sR6gehG/tGsFgD762+Q0QEBUoluvegJumOmJiiRpylcqEIukyZwCIjgW9f5GWlQSmwqwzbW5BEN/unnGHnMhFB2lv6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=l9994pIG; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307860;
	bh=JwM9XO7r7ZwPZmNYUvzPqz3+qo59nyUUWymAQNZfvpo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=l9994pIGKwmExvE4gCFwYJW8YrkjrNZSltVWgoZ9dwmLszngXobPMLnFy4MM+XzKw
	 oZ4dkOSX7fmw7biNWd8XPq82MZT9vnWWdszYXSYPq4h1aPT8NbRBIc6A3k3LRWNAW5
	 4J3J4GA0Fp4GIdhYnyAHXqWxjgGyzj+Kq+0uzvx0=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:28:51 +0100
Subject: [PATCH v4 07/17] kbuild: generate module BTF based on
 vmlinux.unstripped
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-7-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=1527;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=JwM9XO7r7ZwPZmNYUvzPqz3+qo59nyUUWymAQNZfvpo=;
 b=g6Ey3pXzp3Z5/IG+TMiYkH+ibJrOnrhRN1yTqeSUxErPazBTG67wvilm9r1m2g0DvKyRqsGVX
 +0CeXumvNPNCwwSRSpBSpnfmI9vv05PLlcldegrpKZHEQFBGXa5BnO1
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The upcoming module hashes functionality will build the modules in
between the generation of the BTF data and the final link of vmlinux.
At this point vmlinux is not yet built and therefore can't be used for
module BTF generation. vmlinux.unstripped however is usable and
sufficient for BTF generation.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.modfinal | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/Makefile.modfinal b/scripts/Makefile.modfinal
index adfef1e002a9..930db0524a0a 100644
--- a/scripts/Makefile.modfinal
+++ b/scripts/Makefile.modfinal
@@ -40,11 +40,11 @@ quiet_cmd_ld_ko_o = LD [M]  $@
 
 quiet_cmd_btf_ko = BTF [M] $@
       cmd_btf_ko = 							\
-	if [ ! -f $(objtree)/vmlinux ]; then				\
-		printf "Skipping BTF generation for %s due to unavailability of vmlinux\n" $@ 1>&2; \
+	if [ ! -f $(objtree)/vmlinux.unstripped ]; then			\
+		printf "Skipping BTF generation for %s due to unavailability of vmlinux.unstripped\n" $@ 1>&2; \
 	else								\
-		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux $@; \
-		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux $@;		\
+		LLVM_OBJCOPY="$(OBJCOPY)" $(PAHOLE) -J $(PAHOLE_FLAGS) $(MODULE_PAHOLE_FLAGS) --btf_base $(objtree)/vmlinux.unstripped $@; \
+		$(RESOLVE_BTFIDS) -b $(objtree)/vmlinux.unstripped $@;	\
 	fi;
 
 # Same as newer-prereqs, but allows to exclude specified extra dependencies

-- 
2.52.0


