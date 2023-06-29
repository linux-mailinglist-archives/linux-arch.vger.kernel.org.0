Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A25C7425E9
	for <lists+linux-arch@lfdr.de>; Thu, 29 Jun 2023 14:20:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjF2MUZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Jun 2023 08:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjF2MT7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Jun 2023 08:19:59 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C29B82681;
        Thu, 29 Jun 2023 05:19:58 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 52FDB1FD68;
        Thu, 29 Jun 2023 12:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1688041197; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSCnNOTIHcBHYP1H47mhSWWMU/cUgjzIXzIZqp//59s=;
        b=JGOebDL4XjP7zTfKng4P+h6jtTTgakd2fjixPEvmz/HdvzbYOg1LD8peXmLP0KwXI3FUzx
        9ccjQzWoVuNCFHnkDDDbq3+AKuSJLX39AmuIZpfRBb96CPOqEJ5FQ7RbtqMNbiFXZeA/wl
        pCwVkAFVOTNLvMhnEKrzdAem0Ahs6hE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1688041197;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VSCnNOTIHcBHYP1H47mhSWWMU/cUgjzIXzIZqp//59s=;
        b=PW/o667y7EHsEjtoqDiPRKJQ3VACKqdZligZ3HBaVCmmMwC0zrBZm6NldMzu/wXTM544nR
        IeOPLeAMnpTux8Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D192513905;
        Thu, 29 Jun 2023 12:19:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wNs2Mux2nWRlVAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 29 Jun 2023 12:19:56 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     arnd@arndb.de, deller@gmx.de, daniel@ffwll.ch, airlied@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, loongarch@lists.linux.dev,
        linux-mips@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-hyperv@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-arch@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>
Subject: [PATCH 04/12] staging/sm750fb: Do not include <linux/screen_info.h>
Date:   Thu, 29 Jun 2023 13:45:43 +0200
Message-ID: <20230629121952.10559-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230629121952.10559-1-tzimmermann@suse.de>
References: <20230629121952.10559-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The sm750fb driver does not need anything from <linux/screen_info.h>.
Remove the include statements.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
---
 drivers/staging/sm750fb/sm750.c        | 1 -
 drivers/staging/sm750fb/sm750_accel.c  | 1 -
 drivers/staging/sm750fb/sm750_cursor.c | 1 -
 drivers/staging/sm750fb/sm750_hw.c     | 1 -
 4 files changed, 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 55e302a27847d..c260f73cf570a 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -14,7 +14,6 @@
 #include <linux/mm_types.h>
 #include <linux/vmalloc.h>
 #include <linux/pagemap.h>
-#include <linux/screen_info.h>
 #include <linux/console.h>
 
 #include "sm750.h"
diff --git a/drivers/staging/sm750fb/sm750_accel.c b/drivers/staging/sm750fb/sm750_accel.c
index 24b9077a634a6..44b9e3fe3a41d 100644
--- a/drivers/staging/sm750fb/sm750_accel.c
+++ b/drivers/staging/sm750fb/sm750_accel.c
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
 
 #include "sm750.h"
 #include "sm750_accel.h"
diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index 43e6f52c2551f..eea4d1bd36ce7 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -14,7 +14,6 @@
 #include <linux/pagemap.h>
 #include <linux/console.h>
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
 
 #include "sm750.h"
 #include "sm750_cursor.h"
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 55cb00e8b0d1c..71247eaf26eef 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -17,7 +17,6 @@
 #include <asm/mtrr.h>
 #endif
 #include <linux/platform_device.h>
-#include <linux/screen_info.h>
 #include <linux/sizes.h>
 
 #include "sm750.h"
-- 
2.41.0

