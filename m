Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B778279D2C2
	for <lists+linux-arch@lfdr.de>; Tue, 12 Sep 2023 15:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbjILNvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Sep 2023 09:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbjILNu6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Sep 2023 09:50:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2C310D7;
        Tue, 12 Sep 2023 06:50:54 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 2C8EF1F85D;
        Tue, 12 Sep 2023 13:50:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694526653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV/rHFCKWKhe5o/Dlji+h0tSxNvEv9pGQp8HF0qfFsw=;
        b=Ew6/ShMt2eLj+cJ80uJN98SHanYPOov+NxTUOhOU2guO/sjidGDeaB2opl7TgIjsFoZos8
        iOlarOI9lXf4fNYAryBRhul5DvdlSagyy+aXg3gIylx9rejm+0l1lebNZd9nDylzoTpDG0
        KnwoLVFIiyCSTzh2hKHA6n2k7Nv7/qg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694526653;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jV/rHFCKWKhe5o/Dlji+h0tSxNvEv9pGQp8HF0qfFsw=;
        b=mCQGGEEqAUZk6FbEVgwGjMaR7bNzYn80/YZJFR4O0MHHOph1X0dtseZydWjo0aeJynBB8b
        GZfd9/6d+QYFB4Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF0E913A3B;
        Tue, 12 Sep 2023 13:50:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id OMKiNbxsAGVKQwAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 12 Sep 2023 13:50:52 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 5/5] arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
Date:   Tue, 12 Sep 2023 15:49:03 +0200
Message-ID: <20230912135050.17155-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230912135050.17155-1-tzimmermann@suse.de>
References: <20230912135050.17155-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Call __phys_mem_access_prot() from the fbdev mmap helper
pgprot_framebuffer(). Allows to avoid the file argument of NULL.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/include/asm/fb.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
index 3cecf14d51de8..c0c5d1df7ad1e 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/fb.h
@@ -8,12 +8,7 @@ static inline pgprot_t pgprot_framebuffer(pgprot_t prot,
 					  unsigned long vm_start, unsigned long vm_end,
 					  unsigned long offset)
 {
-	/*
-	 * PowerPC's implementation of phys_mem_access_prot() does
-	 * not use the file argument. Set it to NULL in preparation
-	 * of later updates to the interface.
-	 */
-	return phys_mem_access_prot(NULL, PHYS_PFN(offset), vm_end - vm_start, prot);
+	return __phys_mem_access_prot(PHYS_PFN(offset), vm_end - vm_start, prot);
 }
 #define pgprot_framebuffer pgprot_framebuffer
 
-- 
2.42.0

