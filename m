Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDD0E793F48
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 16:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237665AbjIFOsL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 10:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234843AbjIFOsJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 10:48:09 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8A1B172C;
        Wed,  6 Sep 2023 07:48:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A75D122432;
        Wed,  6 Sep 2023 14:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694011683; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WzZFokcrlW6NGGGLWd4i7Dg6KUabGpzZ6FiqlxPoi4=;
        b=TwC2rHXizbdCLcuc98kBNbY1jPzrJH8MUQ4VjQ26oB+ROml5otTq2AfT5GtpArLlOwGnht
        IQy9B+Jfxu2tfWgd4Lw2ZQTYf1zPfGZ597QOFz6AKfgrenZZMsGUIPSHjF0iIRJfqnvV4J
        xMZb5M9XnRlBS4pzz82B3DJdxuiPAlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694011683;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WzZFokcrlW6NGGGLWd4i7Dg6KUabGpzZ6FiqlxPoi4=;
        b=Mc2/HGFn9HSuEP4H4Q5LcaFNnrKaCB1DbKsiLnnyglv9zCM0QPDt/cUM+rpbZCweIcrHIS
        PQ8ERS9CmBjknJBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6269613921;
        Wed,  6 Sep 2023 14:48:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WBgyFyOR+GSNSgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 06 Sep 2023 14:48:03 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/5] fbdev: Avoid file argument in fb_pgprotect()
Date:   Wed,  6 Sep 2023 16:35:02 +0200
Message-ID: <20230906144801.25297-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906144801.25297-1-tzimmermann@suse.de>
References: <20230906144801.25297-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Only PowerPC's fb_pgprotect() needs the file argument, although
the implementation does not use it. Pass NULL to the internal
helper in preparation of further updates. A later patch will remove
the file parameter from fb_pgprotect().

While at it, replace the shift operation with PHYS_PFN().

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/include/asm/fb.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
index 5f1a2e5f7654..61e3b8806db6 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/fb.h
@@ -9,7 +9,12 @@
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
 {
-	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
+	/*
+	 * PowerPC's implementation of phys_mem_access_prot() does
+	 * not use the file argument. Set it to NULL in preparation
+	 * of later updates to the interface.
+	 */
+	vma->vm_page_prot = phys_mem_access_prot(NULL, PHYS_PFN(off),
 						 vma->vm_end - vma->vm_start,
 						 vma->vm_page_prot);
 }
-- 
2.42.0

