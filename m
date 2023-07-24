Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7953675F8C1
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jul 2023 15:46:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjGXNqV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Jul 2023 09:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbjGXNqE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Jul 2023 09:46:04 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5DD1B3;
        Mon, 24 Jul 2023 06:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690206235; x=1721742235;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=k5M12onZc7LjlJ3T/aLtJ/tbWke5cSmJgH3mrt/yYJA=;
  b=TU+2I7mEjCvYUWagnDVs6WDHwWJOlwYpA5gAbhMO72YZd8wnP6/94NCD
   y/t5Ne++Q6ADrHMkJkHuw+a4XaUsblkPktEhAjWYbRHirBGwg4gC1fj1a
   XDtuEtCm+w8mxpj9xOs/G70Zp6H+yv7LVDh7gYa2oHdmgsg3fjJ1LKl1m
   tct6WsZv1Nn8Bo+z2oYIFnpfDVdCJvLXeX3nraXl2msFoFtVZlZ1N2gED
   kwlmp8I0C0bZoXrznG/i5BpiubohJw8LGKol6iPigI2ygGKYUp/FyINI/
   x6bbhxWikso7Bnx9XBd9N07OgvEDaVB8tgJqGr30u6eJNuDkCr71+HOQ8
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="371043521"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="371043521"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 06:43:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="1056431915"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="1056431915"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 24 Jul 2023 06:42:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id D2BBA1A6; Mon, 24 Jul 2023 16:43:07 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 1/1] asm-generic: Fix spelling of architecture
Date:   Mon, 24 Jul 2023 16:43:01 +0300
Message-Id: <20230724134301.13980-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.40.0.1.gaa8946217a0b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Fix spelling of "architecture" in the Kbuild file.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/asm-generic/Kbuild | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/Kbuild b/include/asm-generic/Kbuild
index 941be574bbe0..def242528b1d 100644
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -2,7 +2,7 @@
 #
 # asm headers that all architectures except um should have
 # (This file is not included when SRCARCH=um since UML borrows several
-# asm headers from the host architecutre.)
+# asm headers from the host architecture.)
 
 mandatory-y += atomic.h
 mandatory-y += archrandom.h
-- 
2.40.0.1.gaa8946217a0b

