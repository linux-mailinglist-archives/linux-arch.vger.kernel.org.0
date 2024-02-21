Return-Path: <linux-arch+bounces-2588-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D4A785E2B3
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 17:14:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E45528666B
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 16:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183458120D;
	Wed, 21 Feb 2024 16:14:38 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4738C8121A;
	Wed, 21 Feb 2024 16:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532078; cv=none; b=dLp3+HOI9zTHoScSJ3TKblFyT+lVhQDu9nPXJ3HZtYCltc/bDYVF879kBUw0vg/A9zIaacxoN0Ya8mMqdWNfiw4o85wMB1IxLNoH5PqRkvewAbYmkqe4eg3ZTjFx1t9zBH1KAk1BTl9saQSN5ippo9ZNbYQVrBJH9PaAOJihdoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532078; c=relaxed/simple;
	bh=2iWCWyWeXir+yENq3pCgwfuM/1uLLEcUhOADN7bYtWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZsjYn5UeBOm0fVIQveJUzmWLghxWqBIZ/6WmKc/biMeuhB0SUE4HjRQB9gD8HqSTSjqy6Vgxs0nisZC2YW2uq3YWPNihq8ur2hIWTNVm3lL+fsv9E6bE0Y4lqDxmmMSIRiWPFD7YfWeBzNct1WPnQQKgWPxLangzqt2adWgemAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A53D42222F;
	Wed, 21 Feb 2024 16:14:34 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 0385813A42;
	Wed, 21 Feb 2024 16:14:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id KMI5O2kh1mVrYwAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 21 Feb 2024 16:14:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	javierm@redhat.com,
	deller@gmx.de,
	suijingfeng@loongson.cn
Cc: linux-arch@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-parisc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	loongarch@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 1/3] arch: Select fbdev helpers with CONFIG_VIDEO
Date: Wed, 21 Feb 2024 17:05:24 +0100
Message-ID: <20240221161431.8245-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240221161431.8245-1-tzimmermann@suse.de>
References: <20240221161431.8245-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: A53D42222F
X-Spam-Flag: NO

Various Kconfig options selected the per-architecture helpers for
fbdev. But none of the contained code depends on fbdev. Standardize
on CONFIG_VIDEO, which will allow to add more general helpers for
video functionality.

CONFIG_VIDEO protects each architecture's video/ directory. This
allows for the use of more fine-grained control for each directory's
files, such as the use of CONFIG_STI_CORE on parisc.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Andreas Larsson <andreas@gaisler.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
---
 arch/parisc/Makefile      | 2 +-
 arch/sparc/Makefile       | 4 ++--
 arch/sparc/video/Makefile | 2 +-
 arch/x86/Makefile         | 2 +-
 arch/x86/video/Makefile   | 3 ++-
 5 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
index 316f84f1d15c8..21b8166a68839 100644
--- a/arch/parisc/Makefile
+++ b/arch/parisc/Makefile
@@ -119,7 +119,7 @@ export LIBGCC
 
 libs-y	+= arch/parisc/lib/ $(LIBGCC)
 
-drivers-y += arch/parisc/video/
+drivers-$(CONFIG_VIDEO) += arch/parisc/video/
 
 boot	:= arch/parisc/boot
 
diff --git a/arch/sparc/Makefile b/arch/sparc/Makefile
index 5f60359361312..757451c3ea1df 100644
--- a/arch/sparc/Makefile
+++ b/arch/sparc/Makefile
@@ -59,8 +59,8 @@ endif
 libs-y                 += arch/sparc/prom/
 libs-y                 += arch/sparc/lib/
 
-drivers-$(CONFIG_PM) += arch/sparc/power/
-drivers-$(CONFIG_FB) += arch/sparc/video/
+drivers-$(CONFIG_PM)    += arch/sparc/power/
+drivers-$(CONFIG_VIDEO) += arch/sparc/video/
 
 boot := arch/sparc/boot
 
diff --git a/arch/sparc/video/Makefile b/arch/sparc/video/Makefile
index 6baddbd58e4db..9dd82880a027a 100644
--- a/arch/sparc/video/Makefile
+++ b/arch/sparc/video/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-obj-$(CONFIG_FB) += fbdev.o
+obj-y	+= fbdev.o
diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 15a5f4f2ff0aa..c0ea612c62ebe 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -265,7 +265,7 @@ drivers-$(CONFIG_PCI)            += arch/x86/pci/
 # suspend and hibernation support
 drivers-$(CONFIG_PM) += arch/x86/power/
 
-drivers-$(CONFIG_FB_CORE) += arch/x86/video/
+drivers-$(CONFIG_VIDEO) += arch/x86/video/
 
 ####
 # boot loader support. Several targets are kept for legacy purposes
diff --git a/arch/x86/video/Makefile b/arch/x86/video/Makefile
index 5ebe48752ffc4..9dd82880a027a 100644
--- a/arch/x86/video/Makefile
+++ b/arch/x86/video/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_FB_CORE)		+= fbdev.o
+
+obj-y	+= fbdev.o
-- 
2.43.0


