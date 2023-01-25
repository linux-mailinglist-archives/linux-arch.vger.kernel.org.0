Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF767BC58
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:11:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236324AbjAYULu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:11:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjAYULo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:11:44 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D452C5CFEB;
        Wed, 25 Jan 2023 12:11:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677474; x=1706213474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TmiJH7yegRFkVHybG0Js6InCkhSr5S2J1lLVxKNHjiI=;
  b=dbep2eBvwm7ZqcXWwPw19rxb0/7bTwj5J4heOWNaccelawDkaoDdkxY+
   rxLLF1M+1juO/eH/MgO2BAPT4RuxbvLuJIs/gRDAsM6sNvVhOAuBKLcIE
   oyOd3SKynaSArw2jZ9sSAibHDNWojvfF8Y0dY5Low6wMm53KR/+NwcNYg
   n+zHucbxgYmCWxQ4G9IOEM4Tn8DkM+izV6szXD/yVdJeiAJjTT56LCdTc
   lhVnZ+uSIo6SJ5WpTiQzyfT37RJLmn5MmtLx+m/Orz41/144/KyGKIdA3
   eRpnO5u/Skeo4Dcst3cO9X2SaEDXMona3G2OKfFIKqJ32ijRNP+Q6KRUz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694781"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694781"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871613"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871613"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 4A87A1F0; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-gpio@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 3/5] gpio: Deduplicate forward declarations in consumer.h
Date:   Wed, 25 Jan 2023 22:10:18 +0200
Message-Id: <20230125201020.10948-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
References: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The struct fwnode_handle pointer is used in both branches of ifdeffery,
no need to have a copy of the same in each of them, just make it global.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/consumer.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index 59cb20cfac3d..a7eb8aa1e54c 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -8,6 +8,7 @@
 #include <linux/err.h>
 
 struct device;
+struct fwnode_handle;
 struct gpio_desc;
 struct gpio_array;
 
@@ -171,9 +172,6 @@ int gpiod_set_consumer_name(struct gpio_desc *desc, const char *name);
 struct gpio_desc *gpio_to_desc(unsigned gpio);
 int desc_to_gpio(const struct gpio_desc *desc);
 
-/* Child properties interface */
-struct fwnode_handle;
-
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
 					 enum gpiod_flags flags,
@@ -546,9 +544,6 @@ static inline int desc_to_gpio(const struct gpio_desc *desc)
 	return -EINVAL;
 }
 
-/* Child properties interface */
-struct fwnode_handle;
-
 static inline
 struct gpio_desc *fwnode_gpiod_get_index(struct fwnode_handle *fwnode,
 					 const char *con_id, int index,
-- 
2.39.0

