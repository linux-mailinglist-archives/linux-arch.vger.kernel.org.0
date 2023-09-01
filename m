Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EB778FF1A
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 16:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350007AbjIAO1L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349991AbjIAO1K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 10:27:10 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D71C310F9;
        Fri,  1 Sep 2023 07:27:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 6C3E31F891;
        Fri,  1 Sep 2023 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693578423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FP9MTa3lLW880Bb2/na3VAZdvGvajU0vpltsEnzM4sM=;
        b=vTpdS3rQ3UOgZy1x6pB0L41dVuV+YumTOGAdvRWzqxQZyFujlp7sYR2G+/bKrQh6tRm36d
        4zv6MPMR0elLbxuHC7k2VrXGE7+ekoD8TF5SCKD5j0+ZdK9PTsFPSF/vespDt/MDWNgsf+
        SxYUdmRXPVAFeWOQD/oGaNGyE/DXjOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693578423;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FP9MTa3lLW880Bb2/na3VAZdvGvajU0vpltsEnzM4sM=;
        b=Ti46tYWOY1N8/A5C8iV7rjiIpfHLsh3WRDZmzHUuzKjTYNAC4iPi7upuQvuh7FVuJd1u/Q
        UlhUxHNq6nuLOoBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D81713A12;
        Fri,  1 Sep 2023 14:27:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id kGYsCrf08WQGYAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 01 Sep 2023 14:27:03 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/4] arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
Date:   Fri,  1 Sep 2023 16:16:35 +0200
Message-ID: <20230901142659.31787-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901142659.31787-1-tzimmermann@suse.de>
References: <20230901142659.31787-1-tzimmermann@suse.de>
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

Call __phys_mem_access_prot() from the fbdev mmap helper fb_pgprotect().
Allows us to avoid the file argument, which can then be removed from
fB_pgprotect() entirely. No other architecture uses the parameter.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/include/asm/fb.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
index 5f1a2e5f7654..0f1fe1310924 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/fb.h
@@ -9,9 +9,9 @@
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
 {
-	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
-						 vma->vm_end - vma->vm_start,
-						 vma->vm_page_prot);
+	vma->vm_page_prot = __phys_mem_access_prot(PHYS_PFN(off),
+						   vma->vm_end - vma->vm_start,
+						   vma->vm_page_prot);
 }
 #define fb_pgprotect fb_pgprotect
 
-- 
2.41.0

