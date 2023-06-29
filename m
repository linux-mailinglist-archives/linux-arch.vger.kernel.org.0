Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FF397425E1
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 14:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjF2MUT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 08:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjF2MUF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 08:20:05 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 656563588;
        Thu, 29 Jun 2023 05:20:03 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D03942186E;
        Thu, 29 Jun 2023 12:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041201; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKqppA9yoJZh0DiZwFUWalm8/3eVYO9+kOc1QaTDT1U=;
        b=GNmoPY2llgIzzKGALYCGCXujJoF8v3kumNCXFmuYjsIH7mTC1ESO1hzHUmvWxwEJjXVv+F
        ctb/570RZnfi7nsxRKlV4VzAM8j+Py9XRtnRv5wMp3UxCCXDlLGmUiRVqkWxBLYywKsYy5
        FKlDGCyem5GQ2H/Qk6hWZdY37D1mLw0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041201;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cKqppA9yoJZh0DiZwFUWalm8/3eVYO9+kOc1QaTDT1U=;
        b=zn2ycVN7bMs7MpMjurzeBDZvYIidBZ4ripZC2HXkAKRELmBxT7C4nSZT/5sVnb9LQGf2Kj
        pUzRMoQKnAC0euCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 587A713A43;
        Thu, 29 Jun 2023 12:20:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WD2mFPF2nWRlVAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 12:20:01 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Antonino Daplas <adaplas@gmail.com>,
        Maik Broemme <mbroemme@libmpq.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 10/12] fbdev/core: Use fb_is_primary_device() in fb_firmware_edid()
Date:   Thu, 29 Jun 2023 13:45:49 +0200
Message-ID: <20230629121952.10559-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Detect the primary VGA device with fb_is_primary_device() in the
implementation of fb_firmware_edid(). Remove the existing code.

Adapt the function to receive an instance of struct fb_info and
update all callers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Helge Deller <deller@gmx.de>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Maik Broemme <mbroemme@libmpq.org>
Cc: Randy Dunlap <rdunlap@infradead.org>
---
 drivers/video/fbdev/core/fbmon.c          | 25 +++++++----------------
 drivers/video/fbdev/i810/i810-i2c.c       |  2 +-
 drivers/video/fbdev/intelfb/intelfbdrv.c  |  2 +-
 drivers/video/fbdev/nvidia/nv_i2c.c       |  2 +-
 drivers/video/fbdev/savage/savagefb-i2c.c |  2 +-
 include/linux/fb.h                        |  2 +-
 6 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 79e5bfbdd34c2..35be4431f649a 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -28,7 +28,6 @@
  */
 #include <linux/fb.h>
 #include <linux/module.h>
-#include <linux/pci.h>
 #include <linux/slab.h>
 #include <video/edid.h>
 #include <video/of_videomode.h>
@@ -1482,31 +1481,21 @@ int fb_validate_mode(const struct fb_var_screeninfo *var, struct fb_info *info)
 }
 
 #if defined(CONFIG_FIRMWARE_EDID) && defined(CONFIG_X86)
-
-/*
- * We need to ensure that the EDID block is only returned for
- * the primary graphics adapter.
- */
-
-const unsigned char *fb_firmware_edid(struct device *device)
+const unsigned char *fb_firmware_edid(struct fb_info *info)
 {
-	struct pci_dev *dev = NULL;
-	struct resource *res = NULL;
 	unsigned char *edid = NULL;
 
-	if (device)
-		dev = to_pci_dev(device);
-
-	if (dev)
-		res = &dev->resource[PCI_ROM_RESOURCE];
-
-	if (res && res->flags & IORESOURCE_ROM_SHADOW)
+	/*
+	 * We need to ensure that the EDID block is only
+	 * returned for the primary graphics adapter.
+	 */
+	if (fb_is_primary_device(info))
 		edid = edid_info.dummy;
 
 	return edid;
 }
 #else
-const unsigned char *fb_firmware_edid(struct device *device)
+const unsigned char *fb_firmware_edid(struct fb_info *info)
 {
 	return NULL;
 }
diff --git a/drivers/video/fbdev/i810/i810-i2c.c b/drivers/video/fbdev/i810/i810-i2c.c
index 7db17d0d8a8cf..b605e96620c1f 100644
--- a/drivers/video/fbdev/i810/i810-i2c.c
+++ b/drivers/video/fbdev/i810/i810-i2c.c
@@ -161,7 +161,7 @@ int i810_probe_i2c_connector(struct fb_info *info, u8 **out_edid, int conn)
 	if (conn < par->ddc_num) {
 		edid = fb_ddc_read(&par->chan[conn].adapter);
 	} else {
-		const u8 *e = fb_firmware_edid(info->device);
+		const u8 *e = fb_firmware_edid(info);
 
 		if (e != NULL) {
 			DPRINTK("i810-i2c: Getting EDID from BIOS\n");
diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index a81095b2b1ea5..4633a75e3a613 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -1024,7 +1024,7 @@ static int intelfb_init_var(struct intelfb_info *dinfo)
 		       sizeof(struct fb_var_screeninfo));
 		msrc = 5;
 	} else {
-		const u8 *edid_s = fb_firmware_edid(&dinfo->pdev->dev);
+		const u8 *edid_s = fb_firmware_edid(dinfo->info);
 		u8 *edid_d = NULL;
 
 		if (edid_s) {
diff --git a/drivers/video/fbdev/nvidia/nv_i2c.c b/drivers/video/fbdev/nvidia/nv_i2c.c
index 0b48965a6420c..632e7d622ebfa 100644
--- a/drivers/video/fbdev/nvidia/nv_i2c.c
+++ b/drivers/video/fbdev/nvidia/nv_i2c.c
@@ -159,7 +159,7 @@ int nvidia_probe_i2c_connector(struct fb_info *info, int conn, u8 **out_edid)
 
 	if (!edid && conn == 1) {
 		/* try to get from firmware */
-		const u8 *e = fb_firmware_edid(info->device);
+		const u8 *e = fb_firmware_edid(info);
 
 		if (e != NULL)
 			edid = kmemdup(e, EDID_LENGTH, GFP_KERNEL);
diff --git a/drivers/video/fbdev/savage/savagefb-i2c.c b/drivers/video/fbdev/savage/savagefb-i2c.c
index 80fa87e2ae2ff..cf9c376f76526 100644
--- a/drivers/video/fbdev/savage/savagefb-i2c.c
+++ b/drivers/video/fbdev/savage/savagefb-i2c.c
@@ -227,7 +227,7 @@ int savagefb_probe_i2c_connector(struct fb_info *info, u8 **out_edid)
 
 	if (!edid) {
 		/* try to get from firmware */
-		const u8 *e = fb_firmware_edid(info->device);
+		const u8 *e = fb_firmware_edid(info);
 
 		if (e)
 			edid = kmemdup(e, EDID_LENGTH, GFP_KERNEL);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 1d5c13f34b098..5ffd2223326bf 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -761,7 +761,7 @@ extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
-extern const unsigned char *fb_firmware_edid(struct device *device);
+extern const unsigned char *fb_firmware_edid(struct fb_info *info);
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
 extern void fb_destroy_modedb(struct fb_videomode *modedb);
-- 
2.41.0

