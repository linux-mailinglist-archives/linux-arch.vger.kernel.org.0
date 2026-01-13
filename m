Return-Path: <linux-arch+bounces-15778-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E26D4D18DD5
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 13:43:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC9EF309E635
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 12:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04763921D8;
	Tue, 13 Jan 2026 12:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="U1KnkUqV"
X-Original-To: linux-arch@vger.kernel.org
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40FCB3921F8;
	Tue, 13 Jan 2026 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307873; cv=none; b=IcWnoyIiknrpldNDPBYEmTEDmar7gTEqqdyufPib+Ewo7v6JuXte6F7vmZhK6jrF6cUgBLmjQB0M3hdh+7/eYqlYnSL7+r7FmyTtS3DroR50ugJU3ItgqhFHnvLK5D2mczADlk5nl6mDqlmtI+ivbhR9VLZCI6xoS8iuHoLi8mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307873; c=relaxed/simple;
	bh=b2TM6fz30nYE4pXc7lphgAZV10HkjJO6Y6M5OUfLXpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=M6QNH01hmbQCKH1qE7lk3RyPK4+ckJSIFxba9wrgTSWt2AgWaMoUUu2vtLlFqXQzqUWFQWtx6P4N9HOhXS29DKMPMnW6XMCb1BrOes3KtZX5fwBLSV6fpMAdIa4FgAfRDqi27FIUxwKKsN9xbAPs/PRjtUaA1fmH4ez8Xjil9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=U1KnkUqV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1768307861;
	bh=b2TM6fz30nYE4pXc7lphgAZV10HkjJO6Y6M5OUfLXpI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=U1KnkUqV1THtBM/FnYjupYo4PNuIDXrDa9wv1DZZEcE2tF6N/S6c6EF/7n1DbgEIo
	 qOks4JyottD1KEeI5d5Su4cVMYj6/huuFG1gQCYx8NWdP5UZzwImedmtvEXcdV9YUP
	 QToV2OswA9J3WiLqB4jdefpF4mhb4HxgZoFv100U=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Tue, 13 Jan 2026 13:29:00 +0100
Subject: [PATCH v4 16/17] kbuild: move handling of module stripping to
 Makefile.lib
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260113-module-hashes-v4-16-0b932db9b56b@weissschuh.net>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768307859; l=3531;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=b2TM6fz30nYE4pXc7lphgAZV10HkjJO6Y6M5OUfLXpI=;
 b=Xez2lBrIjdFMFK8Oh5pBpyprlmOXfIFf5MbbX1IYj3vnIscUbHikzrmsTG8b9pMw9G8LxfD6v
 TVK+2le9j2rBEgHkmELEMe8iyvQ9/x6dQX0oXApfSpXVDLL5sLXzdtE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

To allow CONFIG_MODULE_HASHES in combination with INSTALL_MOD_STRIP,
this logc will also be used by Makefile.modfinal.

Move it to a shared location to enable reuse.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
 scripts/Makefile.lib     | 32 ++++++++++++++++++++++++++++++++
 scripts/Makefile.modinst | 37 +++++--------------------------------
 2 files changed, 37 insertions(+), 32 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 28a1c08e3b22..7fcf3c43e408 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -474,6 +474,38 @@ define sed-offsets
 	s:->::; p;}'
 endef
 
+#
+# Module Installation
+#
+quiet_cmd_install_mod = INSTALL $@
+      cmd_install_mod = cp $< $@
+
+# Module Strip
+# ---------------------------------------------------------------------------
+#
+# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
+# are installed. If INSTALL_MOD_STRIP is '1', then the default option
+# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
+# as the options to the strip command.
+ifeq ($(INSTALL_MOD_STRIP),1)
+mod-strip-option := --strip-debug
+else
+mod-strip-option := $(INSTALL_MOD_STRIP)
+endif
+
+# Strip
+ifdef INSTALL_MOD_STRIP
+
+quiet_cmd_strip_mod = STRIP   $@
+      cmd_strip_mod = $(STRIP) $(mod-strip-option) $@
+
+else
+
+quiet_cmd_strip_mod =
+      cmd_strip_mod = :
+
+endif
+
 # Use filechk to avoid rebuilds when a header changes, but the resulting file
 # does not
 define filechk_offsets
diff --git a/scripts/Makefile.modinst b/scripts/Makefile.modinst
index ba4343b40497..07380c7233a0 100644
--- a/scripts/Makefile.modinst
+++ b/scripts/Makefile.modinst
@@ -8,6 +8,7 @@ __modinst:
 
 include $(objtree)/include/config/auto.conf
 include $(srctree)/scripts/Kbuild.include
+include $(srctree)/scripts/Makefile.lib
 
 install-y :=
 
@@ -36,7 +37,7 @@ install-y += $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo)
 install-$(CONFIG_BUILTIN_MODULE_RANGES) += $(MODLIB)/modules.builtin.ranges
 
 $(addprefix $(MODLIB)/, modules.builtin modules.builtin.modinfo modules.builtin.ranges): $(MODLIB)/%: % FORCE
-	$(call cmd,install)
+	$(call cmd,install_mod)
 
 endif
 
@@ -65,40 +66,12 @@ install-$(CONFIG_MODULES) += $(modules)
 __modinst: $(install-y)
 	@:
 
-#
-# Installation
-#
-quiet_cmd_install = INSTALL $@
-      cmd_install = cp $< $@
-
-# Strip
-#
-# INSTALL_MOD_STRIP, if defined, will cause modules to be stripped after they
-# are installed. If INSTALL_MOD_STRIP is '1', then the default option
-# --strip-debug will be used. Otherwise, INSTALL_MOD_STRIP value will be used
-# as the options to the strip command.
-ifdef INSTALL_MOD_STRIP
-
 ifdef CONFIG_MODULE_HASHES
 ifeq ($(KBUILD_EXTMOD),)
+ifdef INSTALL_MOD_STRIP
 $(error CONFIG_MODULE_HASHES and INSTALL_MOD_STRIP are mutually exclusive)
 endif
 endif
-
-ifeq ($(INSTALL_MOD_STRIP),1)
-strip-option := --strip-debug
-else
-strip-option := $(INSTALL_MOD_STRIP)
-endif
-
-quiet_cmd_strip = STRIP   $@
-      cmd_strip = $(STRIP) $(strip-option) $@
-
-else
-
-quiet_cmd_strip =
-      cmd_strip = :
-
 endif
 
 #
@@ -133,8 +106,8 @@ endif
 $(foreach dir, $(sort $(dir $(install-y))), $(shell mkdir -p $(dir)))
 
 $(dst)/%.ko: %.ko FORCE
-	$(call cmd,install)
-	$(call cmd,strip)
+	$(call cmd,install_mod)
+	$(call cmd,strip_mod)
 	$(call cmd,sign)
 
 ifdef CONFIG_MODULES

-- 
2.52.0


