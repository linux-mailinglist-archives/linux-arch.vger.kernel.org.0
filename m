Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6042A67BC55
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 21:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236264AbjAYULh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 15:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236326AbjAYULe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 15:11:34 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7E75D935;
        Wed, 25 Jan 2023 12:11:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674677466; x=1706213466;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gpqb6KvBcErIJTBAMypvgoqzzMOsiIKCE2O3gvvIVKk=;
  b=Im5anm0RCSFWtvyQATvhO/nHLNVXRCIB4WHW48OW3XYdpI3wgZtdBKRE
   BYIdU1Q7tzb2GZ67j08vnO10wyZK5qD/ffnMq7RD2D5wPgXcNRgVt3ECT
   t+d7sCxyq7CHleEWsbDb5OTU1OPjnVYVjeyEGGaHqSXg0m43CPrbwuO3+
   j8SeH97QjHMtSDlNP5lZIHOzrML0maBKiC6zQTx6Jiki/E6Bj7q9dvQ5n
   PYo6Gpj1KkauNbD4iodc1L90SFXEQ25Doba3rqoI7imMuJ5NjaZ5tOXg9
   oEDkmP/0LXxPBdCz+fbVCJgoqVYgkS5gwkH6zeSJu7qK5IpTCEZeIw7JR
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="326694776"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="326694776"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2023 12:09:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10601"; a="770871614"
X-IronPort-AV: E=Sophos;i="5.97,246,1669104000"; 
   d="scan'208";a="770871614"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jan 2023 12:09:49 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 31D55154; Wed, 25 Jan 2023 22:10:25 +0200 (EET)
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
Subject: [PATCH v1 0/5] gpio: First attempt to clean up headers
Date:   Wed, 25 Jan 2023 22:10:15 +0200
Message-Id: <20230125201020.10948-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.0
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

Header inclusions in the _headers_ of GPIO library is semi-random or
outdated. Here is an attempt to fix the mess.

This is based on latest Linux Next with Pierluigi's patch which I
consider a good quick fix to the issue that can't be easily solved.

Patches 2-4 from me are pretty much straightforward, and are not
expected to fail (so may be applied as soon as test is done).
However the last one is to detect any other hellness of the mess.

Andy Shevchenko (4):
  gpio: Drop unused forward declaration from driver.h
  gpio: Deduplicate forward declarations in consumer.h
  gpio: Group forward declarations in consumer.h
  gpio: Clean up headers

Pierluigi Passaro (1):
  gpiolib: fix linker errors when GPIOLIB is disabled

 include/asm-generic/gpio.h    |  8 -----
 include/linux/gpio.h          |  9 ++----
 include/linux/gpio/consumer.h | 24 +++++++--------
 include/linux/gpio/driver.h   | 56 +++++++++++++++++++++++++++--------
 4 files changed, 59 insertions(+), 38 deletions(-)


base-commit: 9fbee811e479aca2f3523787cae1f46553141b40
-- 
2.39.0

