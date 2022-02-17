Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25C674BA8C5
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244672AbiBQSub (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244661AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33797532E8;
        Thu, 17 Feb 2022 10:50:10 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id hw13so9371183ejc.9;
        Thu, 17 Feb 2022 10:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9GeIjFGNQlPHjVyxQ9p3WniDxYBdTULWXBibB0Q7WqU=;
        b=AT/d0bDaXwtZUv7jKZa/T/kHh8PiMCYDol1M3oUDLpiPOrdMfuKNcAaeyYOM4FOEDf
         GUPNBXssMOCFu7E1YMimiFFyCBECoRonkTXSm0OEjHiSAq00kFr7fuQgpWsdVWM6bqAj
         pDty8X5XIYiHt1VIXXkhq5giWimZ6IG71n9/9Fn/42JUXQIBj1vJ5R023OqxSadstq/2
         NfwdgdIq2mFCEWH6AnX0S1rr9PS3Fk5FNJ42bjX9ahNZct4ir37/PSwXnYaAomg6hDjI
         2/5s5iNRIbn4btEc2OhD4CmzrblK0tf/jxPq+vK2saGrpMUCPr9fWmIVNy+7u3YVHKQr
         SlVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9GeIjFGNQlPHjVyxQ9p3WniDxYBdTULWXBibB0Q7WqU=;
        b=lGTvUoaxv3Zwrz0FtPf8IgHoy/iHXAFx+KFrvMWFppF9amoL+/v6iTOjUjgXl+bdNM
         /zeWgI9AMLFEL07R8yx5x2WJjL0WEk9YcuAObdJCXxJxcoJ2iSRUFwlqdnOGRtDdzBIm
         NibDDeDBmkHsRBGYHrzPeEeam3km5b86pXPCFmO8BMK7ZZl71VbErIZAVL+gGz/yGPMr
         a6UMLrpOOvIC7rhU30VlnxQn72OJlZkTq5dmOZWbfF2GxlYCSVpYKri0TVuuEIHwJgWp
         7XWgj0VFXqBYoR46Ld2eZdhT2UAMhcI6iGAJuS7Wf1Z2Bi+MVMbXPFMpXlc4u29Flsyg
         gJSQ==
X-Gm-Message-State: AOAM5327cEnJ3tJx4QvUcM4+9G8khdhoCJvk4Db/0bel7B494IDIAlxp
        VeNPBX3Ir6i2KAT0XmhQ154=
X-Google-Smtp-Source: ABdhPJzEhaB0/+2MD0xixooNGABMXJOaaCXHVRbquvgJgqLFVkWEcuyfSRGuWC3n9nrrnkE4qcxY1g==
X-Received: by 2002:a17:906:805:b0:6ce:41a8:113 with SMTP id e5-20020a170906080500b006ce41a80113mr3507086ejd.366.1645123808806;
        Thu, 17 Feb 2022 10:50:08 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:08 -0800 (PST)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     linux-arch@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [RFC PATCH 11/13] ath6kl: remove use of list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:27 +0100
Message-Id: <20220217184829.1991035-12-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220217184829.1991035-1-jakobkoschel@gmail.com>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Since the list iteration cannot abort early, cur_ep_dist->list will
always reference to ep_list and can therefore be replaced.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 drivers/net/wireless/ath/ath6kl/htc_mbox.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath6kl/htc_mbox.c b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
index e3874421c4c0..cf5b05860799 100644
--- a/drivers/net/wireless/ath/ath6kl/htc_mbox.c
+++ b/drivers/net/wireless/ath/ath6kl/htc_mbox.c
@@ -104,7 +104,7 @@ static void ath6kl_credit_init(struct ath6kl_htc_credit_info *cred_info,
 	 * it use list_for_each_entry_reverse to walk around the whole ep list.
 	 * Therefore assign this lowestpri_ep_dist after walk around the ep_list
 	 */
-	cred_info->lowestpri_ep_dist = cur_ep_dist->list;
+	cred_info->lowestpri_ep_dist = *ep_list;
 
 	WARN_ON(cred_info->cur_free_credits <= 0);
 
-- 
2.25.1

