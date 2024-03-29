Return-Path: <linux-arch+bounces-3343-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C910893246
	for <lists+linux-arch@lfdr.de>; Sun, 31 Mar 2024 18:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF9B61F22598
	for <lists+linux-arch@lfdr.de>; Sun, 31 Mar 2024 16:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE01F146A8D;
	Sun, 31 Mar 2024 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SuO/o9hH";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="CFzrdsSx"
X-Original-To: linux-arch@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18FC14601B;
	Sun, 31 Mar 2024 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711900930; cv=pass; b=cr+ZJjXgBkVjlMMIsjOYxl7oC9PjSQMqOGLfWzr15f5GKIccue0faYUZDKT/wouZP4+KALuj4lkmwjj+ER8vzs4HR0547tDF6b8jVFi2G2L4Ef5rd6ofLjV7CRpoBAiiz1G25MF5w5DyiaMKLAbMEfseS2L1g91MrHoXEVlfWy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711900930; c=relaxed/simple;
	bh=wjr0wxurAHUDsgUa3LOd+Gda+u2lXRCA/UsEWyt8a0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+r+4Lt5pxK4bV2jX7aW5Ge9oDb21S6H/NsiAp6M/2Ro2LbU8pN0G/PYVK601TzV03k5KBHV7TI7iDdDKgTF26EaOXGD2jof0H4Mf6q0OkTYffXEFBaP+7S59M/VQLjRnr+vtoUPrtXUjwO+3pPkT3p28mKBcgG1zvQkGz4DUhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=fail smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SuO/o9hH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CFzrdsSx; arc=none smtp.client-ip=195.135.223.131; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; arc=pass smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=suse.de
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 31568207D8;
	Sun, 31 Mar 2024 18:02:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cqbkxE7dvfka; Sun, 31 Mar 2024 18:02:05 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 97B452084A;
	Sun, 31 Mar 2024 18:02:03 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 97B452084A
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 8977580004A;
	Sun, 31 Mar 2024 18:02:03 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:03 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:40 +0000
X-sender: <linux-kernel+bounces-125398-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com NOTIFY=NEVER;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAqwprGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKAH4AAADKigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 26157
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125398-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 57823207E4
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711744505; cv=none; b=D2ofjUhYBPAnqU8lGAhowDvfKwsItz+8XiC0p7wMkxuzWnDcahsqJl+Z5HKtPDPI+MetQI3YaOVOv5tLpSvIPWVaMMXdp4qlViEK/xXHpxCcdra9ZZYwrzYgXUPMe+gtt1DDxvanHOYB5LZYgh8ofD7NZbGMk2iUTxrdnwldbao=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711744505; c=relaxed/simple;
	bh=wjr0wxurAHUDsgUa3LOd+Gda+u2lXRCA/UsEWyt8a0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c6zWdb/QOiyoMceMcDcA8vFwnlVuJc7LbUAkHuhp4UngvEgzwkOlU+xd4pRYMEBWm4nDCWGwYto5FgcEGk+gQpyLpmDmAyhWtlQu7cCQyduJxRLVHrvx2TE59dXWhY+fyvmLekudePofipY77J7tV5atAcY5sj1zdGBfrkj9Vps=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SuO/o9hH; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=CFzrdsSx; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1711744499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPhAoJzxNIA+Zyc3rmr96I44yGrbHHtvC/kao9p1aE=;
	b=SuO/o9hHDFaqftV6eI2MO+utLXpa5M51LlMEE/ka1+JY65aMSjaH8l+mhXYN1LzyI8ehHU
	l3zrsO0NpwIzc6+J2xu7Ll5okFEvpYRyqkfHV/uZdikGklfdJnlx2cBZLXMkLSVp1fsXfp
	fAld15I8m5n7cmZldzEBJFN/cF4IxAM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1711744499;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5zPhAoJzxNIA+Zyc3rmr96I44yGrbHHtvC/kao9p1aE=;
	b=CFzrdsSxhUSmaQoySt/OHi2C7T3Mr3nGK4vRoiBbHJIe1ukVeOpu2ckjXSBd+87oJ2dZu7
	/PzLmNyBpir4viCQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=none
From: Thomas Zimmermann <tzimmermann@suse.de>
To: arnd@arndb.de,
	sam@ravnborg.org,
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
Subject: [PATCH v3 2/3] arch: Remove struct fb_info from video helpers
Date: Fri, 29 Mar 2024 21:32:11 +0100
Message-ID: <20240329203450.7824-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240329203450.7824-1-tzimmermann@suse.de>
References: <20240329203450.7824-1-tzimmermann@suse.de>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C36DD5CACF
X-Spamd-Result: default: False [-1.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.19)[-0.968];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap2.dmz-prg2.suse.org:rdns,imap2.dmz-prg2.suse.org:helo];
	FREEMAIL_TO(0.00)[arndb.de,ravnborg.org,redhat.com,gmx.de,linux.dev];
	R_DKIM_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

The per-architecture video helpers do not depend on struct fb_info
or anything else from fbdev. Remove it from the interface and replace
fb_is_primary_device() with video_is_primary_device(). The new helper
is similar in functionality, but can operate on non-fbdev devices.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
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
index fcabc668e9fbe..3f7333dca508c 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2907,7 +2907,7 @@ void fbcon_remap_all(struct fb_info *info)
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



