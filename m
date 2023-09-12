Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576F279D2B4
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 15:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235218AbjILNu6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 09:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjILNu5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 09:50:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C2110D1;
        Tue, 12 Sep 2023 06:50:53 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 17EE0215D5;
        Tue, 12 Sep 2023 13:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694526652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQtqPTO6zowJiMP7f/KbQAZIhFJEInYimmVKJDBEpdg=;
        b=gCQNKlwJK2JgogRQPwNMiZoL20HLA7nY/ur1AOgmWY+4r5OYVMw2GrgyZCBkj559T0vXhJ
        ItnEZCSXOvlGfs20XjHCf6R9eo1dNT4vH9y9dKp1ClpqXgaPe1un+niBL3SoV7TRFX9GFJ
        SScnw+YmQZjyA1SSH7T/TPb0CmI3wxI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694526652;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQtqPTO6zowJiMP7f/KbQAZIhFJEInYimmVKJDBEpdg=;
        b=9P6uStIOP1GHoMOPcxzfocUHnZKtE8jqy7gv5/j1dAtFs5ppUTfaYbw+tfkvpqLm+nCFVH
        6cilOqXgJVde0NAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D481413A3B;
        Tue, 12 Sep 2023 13:50:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id MEEkM7tsAGVKQwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 12 Sep 2023 13:50:51 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 1/5] fbdev: Avoid file argument in fb_pgprotect()
Date:   Tue, 12 Sep 2023 15:48:59 +0200
Message-ID: <20230912135050.17155-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912135050.17155-1-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 5f1a2e5f76548..61e3b8806db69 100644
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

