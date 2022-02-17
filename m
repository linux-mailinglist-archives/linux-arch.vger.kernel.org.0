Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA22D4BA8CA
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 19:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244662AbiBQSu2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 13:50:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244651AbiBQSu0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 13:50:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75325532D1;
        Thu, 17 Feb 2022 10:50:05 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id c6so8586578edk.12;
        Thu, 17 Feb 2022 10:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWAz7ch1YbYjOBGYWOA+abErwDCwzis1Yy80ikg8D98=;
        b=QMuA/YuZ0W74ytmZVJE4le6ip+JLNZSARf4bF7VHrDDsFsPKRVKoky7jQUbsW5VCkI
         6mU8g2tqTCApm0uEH+kxh2dUOcqBfaeQTwwcNS9osxdvnKeLqM6OpoS7g0uBmBXF1piB
         EIuB2gjllDeTUeDrju15WMiEvC5AvaAFl68paZrX8MWLb8yXID5HLhdYlPy8oxs6kVVg
         LWrS2dEWLdcgMjUKTWeHwoLQlKUlIQGgmXA3QW4twc8qy18z3bMkBT/7ccH0Q19eG+uo
         45Irv//5OACfVLFur0CvKTLUgDWFB72TxE28Ple+aC65+LnoEBmaDZRpOLMeckMwiaJ2
         cjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWAz7ch1YbYjOBGYWOA+abErwDCwzis1Yy80ikg8D98=;
        b=3fAEcTAnyaavys7W9blaDHZH5P09K/xQa1njN2qfrfqsN+B28vF2xzq5NqHzHmaXgQ
         IW6aPdiJCLfK2hdN6csn+lC8YVk16LMtHp76bEog5woh4HzDrNC0IOnXxubjM6bFlDrS
         WCRzANkNILtsWzGX6ugPVksuH7OK1+lVCnXqPuxIbcF7l8BH+xP3jBL34Ai4wSSuT/7s
         efK8E9aN5dwNO3S7kVSzUpQFxs2E++SHmZu9FgoFtDcwgLC2rgzmABK7xB6vRgS9iuI4
         vpaEVkBZx5BsbZ8X3Jq0J7rUoIUx7CiBdCXLmWxLWEYzdqbSiGI09CNik4sPrPFKFBSw
         kYgA==
X-Gm-Message-State: AOAM532Y0+RsEJkPaub7JYjTn/JMU+6wNK4oL+EW7cBFUVbI4y5HYXZw
        giAXi5AR0weU1fOH1+OtsUw=
X-Google-Smtp-Source: ABdhPJxL+kk5YSwPYn5msccPhV06gKGU69gSRSyODQVEtZA0itYwE3YS9fhTydgWYMYHPpG1FMU3TA==
X-Received: by 2002:a05:6402:278b:b0:408:e865:45af with SMTP id b11-20020a056402278b00b00408e86545afmr3489783ede.44.1645123804097;
        Thu, 17 Feb 2022 10:50:04 -0800 (PST)
Received: from localhost.localdomain (dhcp-077-250-038-153.chello.nl. [77.250.38.153])
        by smtp.googlemail.com with ESMTPSA id q7sm3493268edv.93.2022.02.17.10.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 10:50:03 -0800 (PST)
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
Subject: [RFC PATCH 06/13] ARM: mmp: remove the usage of the list iterator after the loop
Date:   Thu, 17 Feb 2022 19:48:22 +0100
Message-Id: <20220217184829.1991035-7-jakobkoschel@gmail.com>
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

To introduce a speculative safe list iterator, the iterator variable
will be set to NULL when the terminating condition of the loop is
hit.

The code before assumed info would be derived from the head if
the break did not hit, this assumption no longer holds.
Once the speculative safe list iterator is merged the condition could
be replace with if (!info) instead.

Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 arch/arm/mach-mmp/sram.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-mmp/sram.c b/arch/arm/mach-mmp/sram.c
index 6794e2db1ad5..b163d2da53e7 100644
--- a/arch/arm/mach-mmp/sram.c
+++ b/arch/arm/mach-mmp/sram.c
@@ -39,6 +39,7 @@ static LIST_HEAD(sram_bank_list);
 struct gen_pool *sram_get_gpool(char *pool_name)
 {
 	struct sram_bank_info *info = NULL;
+	bool found = false;
 
 	if (!pool_name)
 		return NULL;
@@ -46,12 +47,14 @@ struct gen_pool *sram_get_gpool(char *pool_name)
 	mutex_lock(&sram_lock);
 
 	list_for_each_entry(info, &sram_bank_list, node)
-		if (!strcmp(pool_name, info->pool_name))
+		if (!strcmp(pool_name, info->pool_name)) {
+			found = true;
 			break;
+		}
 
 	mutex_unlock(&sram_lock);
 
-	if (&info->node == &sram_bank_list)
+	if (!found)
 		return NULL;
 
 	return info->gpool;
-- 
2.25.1

