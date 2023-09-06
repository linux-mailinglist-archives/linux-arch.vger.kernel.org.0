Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C14793F56
	for <lists+linux-arch@lfdr.de>; Wed,  6 Sep 2023 16:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241959AbjIFOsN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 6 Sep 2023 10:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbjIFOsK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 6 Sep 2023 10:48:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43703198E;
        Wed,  6 Sep 2023 07:48:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id D145922438;
        Wed,  6 Sep 2023 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1694011684; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5N0wfVmZoSdKNylOWdJ83rChXOs2sDBEpX726Fvr9O8=;
        b=j+aSLaFFhnjaMYoT92JSHV/3ccmY5tvnn/XwU4bY3woDW8nThqYN/87LbC0aIqPgLMLfRB
        d94lK+6v462jx8E1giye9Zz+8BIe9hSBeMBiQrMhaHpSwa8BAmCwb5R1Ab5xBOez/7B00G
        S9EmK2A5i2Wq/byT4Mw1V+rel838la0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1694011684;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5N0wfVmZoSdKNylOWdJ83rChXOs2sDBEpX726Fvr9O8=;
        b=yUuRStADy5K5Rw+TauHgnbdBHPhWlw5od1VbMWA+Wdb/bcy36P7jCnZXzZ4Pull4SbB4BV
        K12syMJmOCKDPRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9158213921;
        Wed,  6 Sep 2023 14:48:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id gD+WIiSR+GSNSgAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Wed, 06 Sep 2023 14:48:04 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 5/5] arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
Date:   Wed,  6 Sep 2023 16:35:06 +0200
Message-ID: <20230906144801.25297-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906144801.25297-1-tzimmermann@suse.de>
References: <20230906144801.25297-1-tzimmermann@suse.de>
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

Call __phys_mem_access_prot() from the fbdev mmap helper
fb_pgprot_device(). Allows to avoid the file argument of
NULL.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/include/asm/fb.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/fb.h b/arch/powerpc/include/asm/fb.h
index 3c7486323178..8e6a7fc4ae86 100644
--- a/arch/powerpc/include/asm/fb.h
+++ b/arch/powerpc/include/asm/fb.h
@@ -8,12 +8,7 @@ static inline pgprot_t fb_pgprot_device(pgprot_t prot,
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
 #define fb_pgprot_device fb_pgprot_device
 
-- 
2.42.0

