Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0216567BC52
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbjAYULX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:11:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236366AbjAYULO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:11:14 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6DC5D11D;
        Wed, 25 Jan 2023 12:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677448; x=1706213448;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=G7N++5tY9N8FPCWRBFWAEI9Nl1zncmIAaWLLx8WidN8=;
  b=bZk7cp6BJrxyuAynxkHk5oL4e7SzLminQa3Mg516fTKg/KhHPDi5SjCp
   LEnZer9ho1hK9kp6lNB8jwfRCHUd60AlexranCxyj4KQz4zit2rW2UA+k
   gArlcLRkEyl3tKEj/cKwMtWvahdw1lUE2ItFrHK5ouqJm+A3POv6RI4Kf
   l5gD65A4YZxqSJGpYM14dhRK9/zfyPuHqXQL14abZcbDqxY/b5/M0b35M
   X90uv6gWUk4oPBwaX5msND8ft1ItRRmsIPD/WDwXMPaTQGu5C7hxGWHEc
   AJp52rtuiKdOys4ySXfo41+jPU0Jn6EbTmBUidDxGSMXoPwnZBYKvVRrq
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694769"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694769"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871612"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871612"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 51273357; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
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
Subject: [PATCH v1 4/5] gpio: Group forward declarations in consumer.h
Date:   Wed, 25 Jan 2023 22:10:19 +0200
Message-Id: <20230125201020.10948-5-andriy.shevchenko@linux.intel.com>
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

For better maintenance group the forward declarations together.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/consumer.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/gpio/consumer.h b/include/linux/gpio/consumer.h
index a7eb8aa1e54c..5432e5d5fbfb 100644
--- a/include/linux/gpio/consumer.h
+++ b/include/linux/gpio/consumer.h
@@ -7,6 +7,7 @@
 #include <linux/compiler_types.h>
 #include <linux/err.h>
 
+struct acpi_device;
 struct device;
 struct fwnode_handle;
 struct gpio_desc;
@@ -602,8 +603,6 @@ struct acpi_gpio_mapping {
 	unsigned int quirks;
 };
 
-struct acpi_device;
-
 #if IS_ENABLED(CONFIG_GPIOLIB) && IS_ENABLED(CONFIG_ACPI)
 
 int acpi_dev_add_driver_gpios(struct acpi_device *adev,
-- 
2.39.0

