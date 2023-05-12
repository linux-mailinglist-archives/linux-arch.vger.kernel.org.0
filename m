Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB9D0700549
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240743AbjELKZL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240742AbjELKYx (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:24:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A74E10E53;
        Fri, 12 May 2023 03:24:50 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 83B312285A;
        Fri, 12 May 2023 10:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683887088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bA1S89nbzVLJGpGGldE0x8rS0sK8N4zBkW2yX9arAtU=;
        b=1uTjhIHEjfNTWYf4lgDAOxlEPKnEhylVRe6RLH32i7Dw975VGJNUzJ/w/Owz6Gaqx17Kxe
        oBskYAsvrZiv5vu2jWj+/6+QHvWzklmVgji5p8N15BItA5fuAMcu5Pikxy/7++VK1l5yw4
        YHMZ4HyDQkjqGhnlISXwPnUVz7uMutM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683887088;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bA1S89nbzVLJGpGGldE0x8rS0sK8N4zBkW2yX9arAtU=;
        b=g5iIwwIgCpT5twwQb6iRhT2oHOhdkNEYFF73nowGTAupCuyndXcLJSbGq5MONotUa8xnKT
        rMQ86V4iWTac/7DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 18D0413A0A;
        Fri, 12 May 2023 10:24:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mDA3BfATXmS5XwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 May 2023 10:24:48 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org, suijingfeng@loongson.cn
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v7 5/7] fbdev: Include <linux/fb.h> instead of <asm/fb.h>
Date:   Fri, 12 May 2023 12:24:42 +0200
Message-Id: <20230512102444.5438-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102444.5438-1-tzimmermann@suse.de>
References: <20230512102444.5438-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace include statements for <asm/fb.h> with <linux/fb.h>. Fixes
the coding style: if a header is available in asm/ and linux/, it
is preferable to include the header from linux/. This only affects
a few source files, most of which already include <linux/fb.h>.

Suggested-by: Sam Ravnborg <sam@ravnborg.org>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 arch/parisc/video/fbdev.c        | 3 +--
 arch/sparc/video/fbdev.c         | 1 -
 arch/x86/video/fbdev.c           | 2 --
 drivers/staging/sm750fb/sm750.c  | 2 +-
 drivers/video/fbdev/core/fbcon.c | 1 -
 drivers/video/fbdev/core/fbmem.c | 2 --
 include/linux/fb.h               | 2 ++
 7 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/arch/parisc/video/fbdev.c b/arch/parisc/video/fbdev.c
index 4a0ae08fc75b..137561d98246 100644
--- a/arch/parisc/video/fbdev.c
+++ b/arch/parisc/video/fbdev.c
@@ -5,10 +5,9 @@
  * Copyright (C) 2001-2002 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
  */
 
+#include <linux/fb.h>
 #include <linux/module.h>
 
-#include <asm/fb.h>
-
 #include <video/sticore.h>
 
 int fb_is_primary_device(struct fb_info *info)
diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
index dadd5799fbb3..25837f128132 100644
--- a/arch/sparc/video/fbdev.c
+++ b/arch/sparc/video/fbdev.c
@@ -4,7 +4,6 @@
 #include <linux/fb.h>
 #include <linux/module.h>
 
-#include <asm/fb.h>
 #include <asm/prom.h>
 
 int fb_is_primary_device(struct fb_info *info)
diff --git a/arch/x86/video/fbdev.c b/arch/x86/video/fbdev.c
index 57ee3c158f97..f41a17ebac48 100644
--- a/arch/x86/video/fbdev.c
+++ b/arch/x86/video/fbdev.c
@@ -7,8 +7,6 @@
  *
  */
 
-#include <asm/fb.h>
-
 #include <linux/fb.h>
 #include <linux/module.h>
 #include <linux/pci.h>
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 22ace3168723..55e302a27847 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -16,7 +16,7 @@
 #include <linux/pagemap.h>
 #include <linux/screen_info.h>
 #include <linux/console.h>
-#include <asm/fb.h>
+
 #include "sm750.h"
 #include "sm750_accel.h"
 #include "sm750_cursor.h"
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index eb565a10e5cd..c6c9d040bdec 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -75,7 +75,6 @@
 #include <linux/interrupt.h>
 #include <linux/crc32.h> /* For counting font checksums */
 #include <linux/uaccess.h>
-#include <asm/fb.h>
 #include <asm/irq.h>
 
 #include "fbcon.h"
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 700b9f7e1bb8..d5f897b5ba54 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -37,8 +37,6 @@
 #include <linux/mem_encrypt.h>
 #include <linux/pci.h>
 
-#include <asm/fb.h>
-
 #include <video/nomodeset.h>
 #include <video/vga.h>
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index ec978a4969a9..4b4d9a5d200a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -15,6 +15,8 @@
 #include <linux/list.h>
 #include <linux/backlight.h>
 #include <linux/slab.h>
+
+#include <asm/fb.h>
 #include <asm/io.h>
 
 struct vm_area_struct;
-- 
2.40.1

