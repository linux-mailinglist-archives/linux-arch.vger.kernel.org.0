Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A489279BE82
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 02:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235517AbjIKVFm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Sep 2023 17:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237702AbjIKNKp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 11 Sep 2023 09:10:45 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE32E7;
        Mon, 11 Sep 2023 06:10:40 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C55AB1F8A6;
        Mon, 11 Sep 2023 13:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694437838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQtqPTO6zowJiMP7f/KbQAZIhFJEInYimmVKJDBEpdg=;
        b=bqwWs5cq53W9DRAIRi/zY8VbRvkwiNS1i7gx1aMnEXcJuf4sxkdI73WiHAqtXCc12Ulsfd
        Q20dCTf4yg+Z3MyUF6d1qRZziS0FzyRgnjlVQAjMW510n8b87QKRE0LPtDF43wBQHQC882
        D7csaZrtRok02oeUvZJChNzOgMD0q8o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694437838;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SQtqPTO6zowJiMP7f/KbQAZIhFJEInYimmVKJDBEpdg=;
        b=gCN6aoBHxkH05NjVEyxOkbuoEmr6Am1TDXSMu7XMsUMczyyDxLKdp7XI9gHTNrdhvwfK/U
        JWthC4eG8eFSKJAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8292113AD1;
        Mon, 11 Sep 2023 13:10:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wAH8Hs4R/2SCIwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Mon, 11 Sep 2023 13:10:38 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 1/5] fbdev: Avoid file argument in fb_pgprotect()
Date:   Mon, 11 Sep 2023 15:08:31 +0200
Message-ID: <20230911131033.27745-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911131033.27745-1-tzimmermann@suse.de>
References: <20230911131033.27745-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

