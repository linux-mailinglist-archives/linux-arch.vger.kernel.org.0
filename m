Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F0473FF21
	for <lists+linux-arch@lfdr.de>; Tue, 27 Jun 2023 16:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjF0O6v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Jun 2023 10:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229931AbjF0O6s (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 27 Jun 2023 10:58:48 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B85DD12C;
        Tue, 27 Jun 2023 07:58:47 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6A0AF21898;
        Tue, 27 Jun 2023 14:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1687877926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+AnPE2EhFo6W/qqAMZnuyc6esjF58TEFFbkBy5JTrLI=;
        b=BzUWwPXwULcHgEZ+gHsTCHFLYHNf3+mXVoMyX0NuLNzWZn6bKnS76Pp1qTrkf1az89ePRg
        f84PJp7Y0ybiW4owISoJPWOQHzJF2aYRmUPpmTgkohzPhhcu+inzbG00DXzicnoBkp3Dv+
        aM6q/C3moA86ooNRJqQl8iUcIxvAoWU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1687877926;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=+AnPE2EhFo6W/qqAMZnuyc6esjF58TEFFbkBy5JTrLI=;
        b=6/gSwSlHsFleByQJBJh3RWHq1sI6orcekPPoVaQ5fTB9iuWJzxyCbcgQZNqYv6Du7y/vME
        5TWLfSlbDV9wYZCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3AC0813462;
        Tue, 27 Jun 2023 14:58:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 8AeNDSb5mmQxHQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Tue, 27 Jun 2023 14:58:46 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     davem@davemloft.net, arnd@arndb.de, linux@roeck-us.net,
        sam@ravnborg.org, deller@gmx.de
Cc:     sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] arch/sparc: Add module license and description for fbdev helpers
Date:   Tue, 27 Jun 2023 16:58:20 +0200
Message-ID: <20230627145843.31794-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add MODULE_LICENSE() and MODULE_DESCRIPTION() for fbdev helpers
on sparc. Fixes the following error:

ERROR: modpost: missing MODULE_LICENSE() in arch/sparc/video/fbdev.o

Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/dri-devel/c525adc9-6623-4660-8718-e0c9311563b8@roeck-us.net/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 4eec0b3048fc ("arch/sparc: Implement fb_is_primary_device() in source file")
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Helge Deller <deller@gmx.de>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 arch/sparc/video/fbdev.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/sparc/video/fbdev.c b/arch/sparc/video/fbdev.c
index 25837f128132d..bff66dd1909a4 100644
--- a/arch/sparc/video/fbdev.c
+++ b/arch/sparc/video/fbdev.c
@@ -21,3 +21,6 @@ int fb_is_primary_device(struct fb_info *info)
 	return 0;
 }
 EXPORT_SYMBOL(fb_is_primary_device);
+
+MODULE_DESCRIPTION("Sparc fbdev helpers");
+MODULE_LICENSE("GPL");
-- 
2.41.0

