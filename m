Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A366E48CB
	for <lists+linux-arch@lfdr.de>; Mon, 17 Apr 2023 14:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjDQM7D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Apr 2023 08:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjDQM5d (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Apr 2023 08:57:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26B59EE8;
        Mon, 17 Apr 2023 05:57:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 21EBA1FE10;
        Mon, 17 Apr 2023 12:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681736226; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52/I0RjnF2uY+VNuyKQOo7WWM29rXSQ8n+JGXAXTUAU=;
        b=tjiSEtlibVPuCXpDlhIvN/Sd4P34nJn8wDwoxf/GwXT4PXVny0z4hkCg1HlpBo/Ys2u/sT
        KUnai4qKMC5VDUzclYKf34+WWPisdB1gazMiAk1iLzlVm/+Yx25nAaGgGGHliPDwknnwux
        QJ6JWez02gt0uChmRoFHiigzG+RT2RY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681736226;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=52/I0RjnF2uY+VNuyKQOo7WWM29rXSQ8n+JGXAXTUAU=;
        b=g3E9UtZBk7rz7F7uVYk9X/osHE+fEvnv+R727XOmCPq/EA2JmbguASBE107BRpgZVn5JFN
        hsnkV2uzaaiX8KCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BF0511391A;
        Mon, 17 Apr 2023 12:57:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0JHPLSFCPWToWwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 17 Apr 2023 12:57:05 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, daniel.vetter@ffwll.ch, deller@gmx.de,
        javierm@redhat.com, gregkh@linuxfoundation.org
Cc:     linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, x86@kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH v3 18/19] arch/sparc: Implement <asm/fb.h> with generic helpers
Date:   Mon, 17 Apr 2023 14:56:50 +0200
Message-Id: <20230417125651.25126-19-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230417125651.25126-1-tzimmermann@suse.de>
References: <20230417125651.25126-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace sparc64's fb_pgprotect() with the generic one
from <asm-generic/fb.h>. On sparc, pgprot_writecombine() and
pgprot_noncached() are the same; hence no functional changes

v3:
	* use default implementation for fb_pgprotect() on
	  sparc64 (Arnd)
v2:
	* restore the original fb_pgprotect()

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: "David S. Miller" <davem@davemloft.net>
---
 arch/sparc/include/asm/fb.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/sparc/include/asm/fb.h b/arch/sparc/include/asm/fb.h
index 28609f7a965c..689ee5c60054 100644
--- a/arch/sparc/include/asm/fb.h
+++ b/arch/sparc/include/asm/fb.h
@@ -2,20 +2,20 @@
 #ifndef _SPARC_FB_H_
 #define _SPARC_FB_H_
 
-#include <linux/fs.h>
-
-#include <asm/page.h>
-
 struct fb_info;
+struct file;
+struct vm_area_struct;
 
+#ifdef CONFIG_SPARC32
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
-{
-#ifdef CONFIG_SPARC64
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+{ }
+#define fb_pgprotect fb_pgprotect
 #endif
-}
 
 int fb_is_primary_device(struct fb_info *info);
+#define fb_is_primary_device fb_is_primary_device
+
+#include <asm-generic/fb.h>
 
 #endif /* _SPARC_FB_H_ */
-- 
2.40.0

