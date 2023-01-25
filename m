Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8DE867BC4F
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236346AbjAYULN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:11:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236363AbjAYULG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:11:06 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C485CFD4;
        Wed, 25 Jan 2023 12:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677434; x=1706213434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Hlz2xZdhX7D5SV1buuKCO4EsYWA++GKMkQIjgY/afA=;
  b=m/nQUBVFl3vPkJCLZwJb0n4SA9ZngLvxdawu0tZRBAmSE2nXj/nRgQGG
   pyA4Rm400JOZ/Q+rZ98wBT1QWPqinjT5ddgErRfqMe7R7U5I9BxGPMpPr
   ScaYQJ4paGm5PIIg6jS7oXpPChSyReGMI7ZPrrexvLITCvMk37Ae24WPq
   l4nMcGYWLmqLnRZWgIimthmHRah5MS7RFmTfe4vrx8CviPhdvZVFoxXXh
   BzKRsnfhXfNVqWh5JCfdqH8go2ZvPCNmRzf7CM6vc0kq++5NnBuc/0YjH
   Fws9uaTYH2z9zTZaiWjWE0kf8mUk2Z5qm8AGjbUVdMzrDTXRsrXEH997H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694762"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694762"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871611"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871611"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 43C1319C; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
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
Subject: [PATCH v1 2/5] gpio: Drop unused forward declaration from driver.h
Date:   Wed, 25 Jan 2023 22:10:17 +0200
Message-Id: <20230125201020.10948-3-andriy.shevchenko@linux.intel.com>
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

There is no struct device_node pointers anywhere in the header,
drop unused forward declaration.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/gpio/driver.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 67990908a040..caf2376dd98b 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -16,7 +16,6 @@
 
 struct gpio_desc;
 struct of_phandle_args;
-struct device_node;
 struct seq_file;
 struct gpio_device;
 struct module;
-- 
2.39.0

