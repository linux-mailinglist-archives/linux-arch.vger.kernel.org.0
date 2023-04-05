Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB44A6D80A2
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 17:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238746AbjDEPGV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 11:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238731AbjDEPGR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 11:06:17 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B714E54;
        Wed,  5 Apr 2023 08:06:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id EFED020698;
        Wed,  5 Apr 2023 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680707160; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9+Iga1RG3WJoFtIzMvmVoZTWz2su1dQYDPw2ev3RXk=;
        b=uOUemD8dF6UQc1v7XEhh1Kh0NtYiKEUCtF3+O/1IuR3a+ZLQA74QWPkDGb4E2cpJsaS7Th
        n4EkN/QRbGiyzD2GPH3rcYnUzxcOS6QNmPgItJ56VvnhT0HLdUL4oCuasg74Q6552SSB5f
        2xcsoSTQKp412x6mWwbuNkvFy5/0IXY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680707160;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9+Iga1RG3WJoFtIzMvmVoZTWz2su1dQYDPw2ev3RXk=;
        b=tgdSWNHFnNjXpXh4McPKRX/6YuG+GZ2zZWQt0aTu9Il4D0zeEb2CiQEVIXzgl7s3A6egpJ
        rSc7P3wnp8IQ+FDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E6A013A92;
        Wed,  5 Apr 2023 15:06:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mOToIViOLWTPIAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 05 Apr 2023 15:06:00 +0000
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
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 07/18] arch/m68k: Implement <asm/fb.h> with generic helpers
Date:   Wed,  5 Apr 2023 17:05:43 +0200
Message-Id: <20230405150554.30540-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230405150554.30540-1-tzimmermann@suse.de>
References: <20230405150554.30540-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Replace the architecture's fb_is_primary_device() with the generic
one from <asm-generic/fb.h>. No functional changes. Also use the
generic helper for fb_pgprotect() on systems without MMU.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/include/asm/fb.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/m68k/include/asm/fb.h b/arch/m68k/include/asm/fb.h
index b86c6e2e26dd..f15a14e36826 100644
--- a/arch/m68k/include/asm/fb.h
+++ b/arch/m68k/include/asm/fb.h
@@ -2,8 +2,8 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
-#include <linux/fb.h>
 #include <linux/fs.h>
+
 #include <asm/page.h>
 #include <asm/setup.h>
 
@@ -27,13 +27,9 @@ static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 	}
 }
 #endif /* CONFIG_SUN3 */
-#else
-#define fb_pgprotect(...) do {} while (0)
+#define fb_pgprotect fb_pgprotect
 #endif /* CONFIG_MMU */
 
-static inline int fb_is_primary_device(struct fb_info *info)
-{
-	return 0;
-}
+#include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
-- 
2.40.0

