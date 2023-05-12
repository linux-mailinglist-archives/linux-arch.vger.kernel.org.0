Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7A0700543
	for <lists+linux-arch@lfdr.de>; Fri, 12 May 2023 12:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240606AbjELKZE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 12 May 2023 06:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240699AbjELKYv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 12 May 2023 06:24:51 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854CE1BC1;
        Fri, 12 May 2023 03:24:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2D04E22837;
        Fri, 12 May 2023 10:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683887087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAByYFXXfyQ6LxBft8mvuJgV6t/OqQpXaQEUtMHX5eg=;
        b=XR2wcemv7Hu90f7ekzCtB9jCDgUHSkiiS3v+zhDILyXcOEMgMT8aZHXyXhWOMeGYACEZBi
        zDdhpS5ako4ivi1ir78M/W1nKgxMzb5xsYTnufn94Hs/ggZKm/etQd6sQzGFWWQeVMIaTw
        /4RazVayVWnQJM+Um72OrFVu8PPQTZg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683887087;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZAByYFXXfyQ6LxBft8mvuJgV6t/OqQpXaQEUtMHX5eg=;
        b=JIIix7is7HfKPwEUPfqWWeqtQcubG5MQR66ManTqDUuU+ewTzD6QAwMBZpf7AnM7g/eMel
        Ez7nwSHimWe0FpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE5E013A0A;
        Fri, 12 May 2023 10:24:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id uOCELe4TXmS5XwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 12 May 2023 10:24:46 +0000
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
Subject: [PATCH v7 2/7] fbdev/matrox: Remove trailing whitespaces
Date:   Fri, 12 May 2023 12:24:39 +0200
Message-Id: <20230512102444.5438-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230512102444.5438-1-tzimmermann@suse.de>
References: <20230512102444.5438-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Reviewed-by: Sui Jingfeng <suijingfeng@loongson.cn>
Tested-by: Sui Jingfeng <suijingfeng@loongson.cn>
---
 drivers/video/fbdev/matrox/matroxfb_accel.c | 6 +++---
 drivers/video/fbdev/matrox/matroxfb_base.h  | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/matrox/matroxfb_accel.c b/drivers/video/fbdev/matrox/matroxfb_accel.c
index 9cb0685feddd..ce51227798a1 100644
--- a/drivers/video/fbdev/matrox/matroxfb_accel.c
+++ b/drivers/video/fbdev/matrox/matroxfb_accel.c
@@ -88,7 +88,7 @@
 
 static inline void matrox_cfb4_pal(u_int32_t* pal) {
 	unsigned int i;
-	
+
 	for (i = 0; i < 16; i++) {
 		pal[i] = i * 0x11111111U;
 	}
@@ -96,7 +96,7 @@ static inline void matrox_cfb4_pal(u_int32_t* pal) {
 
 static inline void matrox_cfb8_pal(u_int32_t* pal) {
 	unsigned int i;
-	
+
 	for (i = 0; i < 16; i++) {
 		pal[i] = i * 0x01010101U;
 	}
@@ -482,7 +482,7 @@ static void matroxfb_1bpp_imageblit(struct matrox_fb_info *minfo, u_int32_t fgx,
 			/* Tell... well, why bother... */
 			while (height--) {
 				size_t i;
-				
+
 				for (i = 0; i < step; i += 4) {
 					/* Hope that there are at least three readable bytes beyond the end of bitmap */
 					fb_writel(get_unaligned((u_int32_t*)(chardata + i)),mmio.vaddr);
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.h b/drivers/video/fbdev/matrox/matroxfb_base.h
index 958be6805f87..c93c69bbcd57 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.h
+++ b/drivers/video/fbdev/matrox/matroxfb_base.h
@@ -301,9 +301,9 @@ struct matrox_altout {
 	int		(*verifymode)(void* altout_dev, u_int32_t mode);
 	int		(*getqueryctrl)(void* altout_dev,
 					struct v4l2_queryctrl* ctrl);
-	int		(*getctrl)(void* altout_dev, 
+	int		(*getctrl)(void *altout_dev,
 				   struct v4l2_control* ctrl);
-	int		(*setctrl)(void* altout_dev, 
+	int		(*setctrl)(void *altout_dev,
 				   struct v4l2_control* ctrl);
 };
 
-- 
2.40.1

