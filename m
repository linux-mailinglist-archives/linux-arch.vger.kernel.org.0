Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6216D9A16
	for <lists+linux-arch@lfdr.de>; Thu,  6 Apr 2023 16:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbjDFOay (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Apr 2023 10:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239153AbjDFOaf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Apr 2023 10:30:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F40E8A7E;
        Thu,  6 Apr 2023 07:30:29 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB6FD2277E;
        Thu,  6 Apr 2023 14:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1680791427; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hepg0DYWNoVEgtpeRDHDiVGtL4xg3TH+o2QLAezNHu8=;
        b=eq+4uVGRps4Mb2U+m3VhJqQkx/WkbaN07Ejyjma6OWSk3DaNXlThnkT0ZOQVn6JV1isskR
        1Eli5Dwor51RB9UhdfpLHKt/pdsmncFNTqDRRqUG2bCsLjZepjJeZMWHd/1wGtluD58BSd
        OqvL+7ikrWsrs+4fwetGRaCccS/MRlk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1680791427;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hepg0DYWNoVEgtpeRDHDiVGtL4xg3TH+o2QLAezNHu8=;
        b=Hnxaeg5HZLCsDZJmZd31s08Z1U4ye1FtMXN1+q1fTdnMaAmZaz8O+m0Z1sh+B50to/AXDT
        uo0v6gvR9H2rZCBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7A2B31351F;
        Thu,  6 Apr 2023 14:30:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ALAFHYPXLmS4LgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 06 Apr 2023 14:30:27 +0000
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
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: [PATCH v2 16/19] arch/sh: Implement <asm/fb.h> with generic helpers
Date:   Thu,  6 Apr 2023 16:30:16 +0200
Message-Id: <20230406143019.6709-17-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230406143019.6709-1-tzimmermann@suse.de>
References: <20230406143019.6709-1-tzimmermann@suse.de>
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

Replace the architecture's fbdev helpers with the generic
ones from <asm-generic/fb.h>. No functional changes.

v2:
	* use default implementation for fb_pgprotect() (Arnd)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
---
 arch/sh/include/asm/fb.h | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/arch/sh/include/asm/fb.h b/arch/sh/include/asm/fb.h
index 9a0bca2686fd..19df13ee9ca7 100644
--- a/arch/sh/include/asm/fb.h
+++ b/arch/sh/include/asm/fb.h
@@ -2,19 +2,6 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
-#include <linux/fb.h>
-#include <linux/fs.h>
-#include <asm/page.h>
-
-static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
-				unsigned long off)
-{
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-}
-
-static inline int fb_is_primary_device(struct fb_info *info)
-{
-	return 0;
-}
+#include <asm-generic/fb.h>
 
 #endif /* _ASM_FB_H_ */
-- 
2.40.0

