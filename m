Return-Path: <linux-arch+bounces-3245-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EC81A88F060
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 21:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EA7CB2129E
	for <lists+linux-arch@lfdr.de>; Wed, 27 Mar 2024 20:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1493153566;
	Wed, 27 Mar 2024 20:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Q6LpThq2";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="areotipk";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="u6kFNc+H";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="eT73RIO4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0C01534E9;
	Wed, 27 Mar 2024 20:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711572303; cv=none; b=jSC6vzUMSC13cHkfcZiXrTWT4Jp1fTHY67QB+D9HG1I8lHyo1HbU8YN/WHne2FiWTwwWFz5Do4dj6/3QQE6PY5CYrW908+nESDSgsn9lAJEBsAy1bHCLo0Idggr+ul/fj+geYjtB+z1KiOw9e4swi6z0bsgIvd/w59L/XM/GnHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711572303; c=relaxed/simple;
	bh=T490lpiF2dOtdIm+UBbB7T59+J9VsIG3ILXpA9KoTIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CO64q8DJ1GT5fi1powKuZciHvT/b0CnNEAuqsK8Eq4fWwVMTlQn2kxaKjJ+W7OoFyC1U+wOLOZx01enip6b/TX+/W9k6aXbJDaL+aL0l4Z1swChgq9EOcZvy/S2uxv3uqHJeW7fNRs28N7vDCiVKBIe3Yw+dCdSGeaQ5rrVoehs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Q6LpThq2; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=areotipk; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=u6kFNc+H; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=eT73RIO4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8BF651FBAB;
	Wed, 27 Mar 2024 20:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572299; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxFTzvxWNMLALj4KoURfwpB4AHBiwJRFdVt6/By2C4I=;
	b=Q6LpThq2LDsX2F/UTqHFemptA+22Hu7yIDbBKE2B4YGXjHRwHoYmTSsVUu85vohJOng1X5
	W5cz8LrZSZPi8nYOZaj20Z5AFqMqf1fHV7GZG6OsyV4py9j6ahgByDMlhZYEdsI1F5S6g4
	kfu1xFHYhbL06KCmoygYPoW4k3FHHP4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572299;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxFTzvxWNMLALj4KoURfwpB4AHBiwJRFdVt6/By2C4I=;
	b=areotipkZmublEyXJzLJq4YyA/yE7YKDhVGfcndkLvDDD7VKmjAKkTkED8MUtWa9fMtQIr
	KVNx341wIPU6iUCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711572298; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxFTzvxWNMLALj4KoURfwpB4AHBiwJRFdVt6/By2C4I=;
	b=u6kFNc+HKxfSB8aM60mcG05bZXSwEFIR3cCZAaeHsHXadDOXCyDRKqs6H4HCd7Wjy9F0hm
	TAyaP4RnhcBwE/a9QDUOH9NijYSaF6JRx9ovFJKJAwOec0y0plDy3vn/JWZGsEVzG7gjw7
	03Ds3uT1uImrGQrdj1NqBcDnlcGDVdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711572298;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xxFTzvxWNMLALj4KoURfwpB4AHBiwJRFdVt6/By2C4I=;
	b=eT73RIO4fB/6qdb48ZUS+nO6DIUGgmgpGBWkyBYCUyHxwNx0HCnvaDpb/Meo+tk4mhRyYo
	Yfu0ylgOVA78idAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id D28AD13AB3;
	Wed, 27 Mar 2024 20:44:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EDseMkmFBGZ2FQAAn2gu4w
	(envelope-from <tzimmermann@suse.de>); Wed, 27 Mar 2024 20:44:57 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	javierm@redhat.com,
	deller@gmx.de,
	sui.jingfeng@linux.dev
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
Subject: [PATCH v2 2/3] arch: Remove struct fb_info from video helpers
Date: Wed, 27 Mar 2024 21:41:30 +0100
Message-ID: <20240327204450.14914-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240327204450.14914-1-tzimmermann@suse.de>
References: <20240327204450.14914-1-tzimmermann@suse.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -1.51
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spamd-Result: default: False [-1.51 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_RATELIMIT(0.00)[to_ip_from(RL8bnzzinbm939qqjaserdumcx)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_TRACE(0.00)[suse.de:+];
	 MX_GOOD(-0.01)[];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FREEMAIL_TO(0.00)[arndb.de,redhat.com,gmx.de,linux.dev];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 FROM_HAS_DN(0.00)[];
	 DWL_DNSWL_MED(-2.00)[suse.de:dkim];
	 FREEMAIL_ENVRCPT(0.00)[gmx.de];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[27];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,davemloft.net:email,hansenpartnership.com:email,zytor.com:email,gmx.de:email,gaisler.com:email,linutronix.de:email,alien8.de:email,suse.de:dkim,suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 RCVD_TLS_ALL(0.00)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:98:from]
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=u6kFNc+H;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=eT73RIO4
X-Rspamd-Queue-Id: 8BF651FBAB

The per-architecture video helpers do not depend on struct fb_info
or anything else from fbdev. Remove it from the interface and replace
fb_is_primary_device() with video_is_primary_device(). The new helper
is similar in functionality, but can operate on non-fbdev devices.

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
 arch/parisc/include/asm/fb.h     |  8 +++++---
 arch/parisc/video/fbdev.c        |  9 +++++----
 arch/sparc/include/asm/fb.h      |  7 ++++---
 arch/sparc/video/fbdev.c         | 17 ++++++++---------
 arch/x86/include/asm/fb.h        |  8 +++++---
 arch/x86/video/fbdev.c           | 18 +++++++-----------
 drivers/video/fbdev/core/fbcon.c |  2 +-
 include/asm-generic/fb.h         | 11 ++++++-----
 8 files changed, 41 insertions(+), 39 deletions(-)

diff --git a/arch/parisc/include/asm/fb.h b/arch/parisc/include/asm/fb.h
index 658a8a7dc5312..ed2a195a3e762 100644
--- a/arch/parisc/include/asm/fb.h
+++ b/arch/parisc/include/asm/fb.h
@@ -2,11 +2,13 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
-struct fb_info;
+#include <linux/types.h>
+
+struct device;
 
 #if defined(CONFIG_STI_CORE)
-int fb_is_primary_device(struct fb_info *info);
-#define fb_is_primary_device fb_is_primary_device
+bool video_is_primary_device(struct device *dev);
+#define video_is_primary_device video_is_primary_device
 #endif
 
 #include <asm-generic/fb.h>
diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
index e4f8ac99fc9e0..540fa0c919d59 100644
--- a/arch/parisc/video/fbdev.c
+++ b/arch/parisc/video/fbdev.c
@@ -5,12 +5,13 @@
  * Copyright (C) 2001-2002 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
  */
 
-#include <linux/fb.h>
 #include <linux/module.h>
 
 #include <video/sticore.h>
 
-int fb_is_primary_device(struct fb_info *info)
+#include <asm/fb.h>
+
+bool video_is_primary_device(struct device *dev)
 {
 	struct sti_struct *sti;
 
@@ -21,6 +22,6 @@ int fb_is_primary_device(struct fb_info *info)
 		return true;
 
 	/* return true if it's the default built-in framebuffer driver */
-	return (sti->dev == info->device);
+	return (sti->dev == dev);
 }
-EXPORT_SYMBOL(fb_is_primary_device);
+EXPORT_SYMBOL(video_is_primary_device);
diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index 24440c0fda490..07f0325d6921c 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -3,10 +3,11 @@
 #define _SPARC_FB_H_
 
 #include <linux/io.h>
+#include <linux/types.h>
 
 #include <asm/page.h>
 
-struct fb_info;
+struct device;
 
 #ifdef CONFIG_SPARC32
 static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
@@ -18,8 +19,8 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 #define pgprot_framebuffer pgprot_framebuffer
 #endif
 
-int fb_is_primary_device(struct fb_info *info);
-#define fb_is_primary_device fb_is_primary_device
+bool video_is_primary_device(struct device *dev);
+#define video_is_primary_device video_is_primary_device
 
 static inline void fb_memcpy_fromio(void *to, const volatile void __iomem *from, size_t n)
 {
diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
index bff66dd1909a4..e46f0499c2774 100644
--- a/arch/sparc/video/fbdev.c
+++ b/arch/sparc/video/fbdev.c
@@ -1,26 +1,25 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include <linux/console.h>
-#include <linux/fb.h>
+#include <linux/device.h>
 #include <linux/module.h>
 
+#include <asm/fb.h>
 #include <asm/prom.h>
 
-int fb_is_primary_device(struct fb_info *info)
+bool video_is_primary_device(struct device *dev)
 {
-	struct device *dev = info->device;
-	struct device_node *node;
+	struct device_node *node = dev->of_node;
 
 	if (console_set_on_cmdline)
-		return 0;
+		return false;
 
-	node = dev->of_node;
 	if (node && node == of_console_device)
-		return 1;
+		return true;
 
-	return 0;
+	return false;
 }
-EXPORT_SYMBOL(fb_is_primary_device);
+EXPORT_SYMBOL(video_is_primary_device);
 
 MODULE_DESCRIPTION("Sparc fbdev helpers");
 MODULE_LICENSE("GPL");
diff --git a/arch/x86/include/asm/fb.h b/arch/x86/include/asm/fb.h
index c3b9582de7efd..999db33792869 100644
--- a/arch/x86/include/asm/fb.h
+++ b/arch/x86/include/asm/fb.h
@@ -2,17 +2,19 @@
 #ifndef _ASM_X86_FB_H
 #define _ASM_X86_FB_H
 
+#include <linux/types.h>
+
 #include <asm/page.h>
 
-struct fb_info;
+struct device;
 
 pgprot_t pgprot_framebuffer(pgprot_t prot,
 			    unsigned long vm_start, unsigned long vm_end,
 			    unsigned long offset);
 #define pgprot_framebuffer pgprot_framebuffer
 
-int fb_is_primary_device(struct fb_info *info);
-#define fb_is_primary_device fb_is_primary_device
+bool video_is_primary_device(struct device *dev);
+#define video_is_primary_device video_is_primary_device
 
 #include <asm-generic/fb.h>
 
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 1dd6528cc947c..4d87ce8e257fe 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -7,7 +7,6 @@
  *
  */
 
-#include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/vgaarb.h>
@@ -25,20 +24,17 @@ pgprot_t pgprot_framebuffer(pgprot_t prot,
 }
 EXPORT_SYMBOL(pgprot_framebuffer);
 
-int fb_is_primary_device(struct fb_info *info)
+bool video_is_primary_device(struct device *dev)
 {
-	struct device *device = info->device;
-	struct pci_dev *pci_dev;
+	struct pci_dev *pdev;
 
-	if (!device || !dev_is_pci(device))
-		return 0;
+	if (!dev_is_pci(dev))
+		return false;
 
-	pci_dev = to_pci_dev(device);
+	pdev = to_pci_dev(dev);
 
-	if (pci_dev == vga_default_device())
-		return 1;
-	return 0;
+	return (pdev == vga_default_device());
 }
-EXPORT_SYMBOL(fb_is_primary_device);
+EXPORT_SYMBOL(video_is_primary_device);
 
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 46823c2e2ba12..85c5c8cbc680a 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2939,7 +2939,7 @@ void fbcon_remap_all(struct fb_info *info)
 static void fbcon_select_primary(struct fb_info *info)
 {
 	if (!map_override && primary_device == -1 &&
-	    fb_is_primary_device(info)) {
+	    video_is_primary_device(info->device)) {
 		int i;
 
 		printk(KERN_INFO "fbcon: %s (fb%i) is primary device\n",
diff --git a/include/asm-generic/fb.h b/include/asm-generic/fb.h
index 6ccabb400aa66..4788c1e1c6bc0 100644
--- a/include/asm-generic/fb.h
+++ b/include/asm-generic/fb.h
@@ -10,8 +10,9 @@
 #include <linux/io.h>
 #include <linux/mm_types.h>
 #include <linux/pgtable.h>
+#include <linux/types.h>
 
-struct fb_info;
+struct device;
 
 #ifndef pgprot_framebuffer
 #define pgprot_framebuffer pgprot_framebuffer
@@ -23,11 +24,11 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 }
 #endif
 
-#ifndef fb_is_primary_device
-#define fb_is_primary_device fb_is_primary_device
-static inline int fb_is_primary_device(struct fb_info *info)
+#ifndef video_is_primary_device
+#define video_is_primary_device video_is_primary_device
+static inline bool video_is_primary_device(struct device *dev)
 {
-	return 0;
+	return false;
 }
 #endif
 
-- 
2.44.0


