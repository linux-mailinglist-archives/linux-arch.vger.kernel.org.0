Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F46F660D
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 09:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjEDHpr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 03:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjEDHpq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 03:45:46 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 508A530EB;
        Thu,  4 May 2023 00:45:44 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AB07E1FE18;
        Thu,  4 May 2023 07:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1683186342; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAY+hm0JbdoN9GPmL+mpKXDG9FbIByWtP6OGBMiB+YI=;
        b=SfvhRD7/OQC2IWHOWciJ9HdwjaPnHJi/7wkmielkw7MBRP0CGthMS1XzW7ps78veqxW56+
        ypDohSk3/F3CyUjCQF6sG00fhMLyxN0H1vdryOJPsqDzTlh53TcNlc5+sY30lJxFQeSGMK
        IOJlZIMH6e/xmqfeWRb00MoDnN2ICDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1683186342;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YAY+hm0JbdoN9GPmL+mpKXDG9FbIByWtP6OGBMiB+YI=;
        b=o3jir1Fnhy+c/kM2blJkLwj6kjFtLc+LCQRJj8YJKER0SLpQFQ373ww5WgVDf34JtlAs0m
        0Sc3/6rwfIqHK5AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 46ACE133F7;
        Thu,  4 May 2023 07:45:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id sK9xEKZiU2S6HAAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Thu, 04 May 2023 07:45:42 +0000
From:   Thomas Zimmermann <tzimmermann@suse.de>
To:     deller@gmx.de, geert@linux-m68k.org, javierm@redhat.com,
        daniel@ffwll.ch, vgupta@kernel.org, chenhuacai@kernel.org,
        kernel@xen0n.name, davem@davemloft.net,
        James.Bottomley@HansenPartnership.com, arnd@arndb.de,
        sam@ravnborg.org
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arch@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org,
        Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 2/6] ipu-v3: Include <linux/io.h>
Date:   Thu,  4 May 2023 09:45:35 +0200
Message-Id: <20230504074539.8181-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230504074539.8181-1-tzimmermann@suse.de>
References: <20230504074539.8181-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The code uses readl() and writel(). Include the header file to
get the declarations.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/ipu-v3/ipu-prv.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/ipu-v3/ipu-prv.h b/drivers/gpu/ipu-v3/ipu-prv.h
index 291ac1bab66d..d4621b1ea7f1 100644
--- a/drivers/gpu/ipu-v3/ipu-prv.h
+++ b/drivers/gpu/ipu-v3/ipu-prv.h
@@ -8,6 +8,7 @@
 
 struct ipu_soc;
 
+#include <linux/io.h>
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/clk.h>
-- 
2.40.1

