Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9178FF07
	for <lists+linux-arch@lfdr.de>; Fri,  1 Sep 2023 16:27:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349985AbjIAO1J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 1 Sep 2023 10:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349988AbjIAO1J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 1 Sep 2023 10:27:09 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A5E10F8;
        Fri,  1 Sep 2023 07:27:04 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D36AA1F86C;
        Fri,  1 Sep 2023 14:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693578422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QETxACuLG117Ppkadvcn1KtVg/Yq0288OgnzhzA/ULk=;
        b=tTb6ATZYkM5FNNeKaXMkOL4QJI48iFJt1y+xae4e6Sni0Qo27M2NlefCoxXCM+ZPwuj5tY
        r6xiCRU9xE1ETGEIZu5/kgrkooxMs/C9oh6EIsNPIXVUeTWz4BFtm8DB8Ne72nR4yY5uHC
        CKnY5HhPDRktVXU0PL1grEur0ikDxHE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693578422;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QETxACuLG117Ppkadvcn1KtVg/Yq0288OgnzhzA/ULk=;
        b=r9L0JRZVYTtkWaU2SguMwkS3pjaoQE7s9J2buuvT1wa6t0fpg65RTcSNZfXNjZynX0yed+
        2ppvNK3qFb4vS+CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E69913A12;
        Fri,  1 Sep 2023 14:27:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id WKLZIbb08WQGYAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Fri, 01 Sep 2023 14:27:02 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        arnd@arndb.de, deller@gmx.de
Cc:     linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, sparclinux@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/4] arch/powerpc: Remove trailing whitespaces
Date:   Fri,  1 Sep 2023 16:16:33 +0200
Message-ID: <20230901142659.31787-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230901142659.31787-1-tzimmermann@suse.de>
References: <20230901142659.31787-1-tzimmermann@suse.de>
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

Fix coding style. No functional changes.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/powerpc/include/asm/machdep.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/machdep.h b/arch/powerpc/include/asm/machdep.h
index 4f6e7d7ee388..933465ed4c43 100644
--- a/arch/powerpc/include/asm/machdep.h
+++ b/arch/powerpc/include/asm/machdep.h
@@ -10,7 +10,7 @@
 #include <linux/export.h>
 
 struct pt_regs;
-struct pci_bus;	
+struct pci_bus;
 struct device_node;
 struct iommu_table;
 struct rtc_time;
@@ -78,8 +78,8 @@ struct machdep_calls {
 	unsigned char 	(*nvram_read_val)(int addr);
 	void		(*nvram_write_val)(int addr, unsigned char val);
 	ssize_t		(*nvram_write)(char *buf, size_t count, loff_t *index);
-	ssize_t		(*nvram_read)(char *buf, size_t count, loff_t *index);	
-	ssize_t		(*nvram_size)(void);		
+	ssize_t		(*nvram_read)(char *buf, size_t count, loff_t *index);
+	ssize_t		(*nvram_size)(void);
 	void		(*nvram_sync)(void);
 
 	/* Exception handlers */
@@ -102,9 +102,9 @@ struct machdep_calls {
 	 */
 	long	 	(*feature_call)(unsigned int feature, ...);
 
-	/* Get legacy PCI/IDE interrupt mapping */ 
+	/* Get legacy PCI/IDE interrupt mapping */
 	int		(*pci_get_legacy_ide_irq)(struct pci_dev *dev, int channel);
-	
+
 	/* Get access protection for /dev/mem */
 	pgprot_t	(*phys_mem_access_prot)(struct file *file,
 						unsigned long pfn,
-- 
2.41.0

