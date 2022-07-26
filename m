Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E8580F01
	for <lists+linux-arch@lfdr.de>; Tue, 26 Jul 2022 10:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238616AbiGZI3S (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 26 Jul 2022 04:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238545AbiGZI3J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 26 Jul 2022 04:29:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0973130574;
        Tue, 26 Jul 2022 01:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658824143; x=1690360143;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xip+SiKxfrbgvn/EPR0jc0BKZZ5YrIpbvJIba3YLDGc=;
  b=TyVRnagBRlB+961dxxNXDGsXg4YA57EFxQAU/2yfJ/P8bKVlxY2CC6iU
   4w+SqstkepsdyBcITd3pLp2Y9WxUwNuZlw4kYzmEHfM1ET+IuvdaLogxD
   xNEeBBeE8bnpY4BWYVXawDQmdR7T4UxEPOeYllOvFiYYNkRojaSbnPjR4
   nMJEAOVyEF2NOd02eMcj9AZUqB9dFxiajuMhiZ0iI9mIe1uM1lxWrnq+s
   jIoiDgl99+LLU2mREpMzZxvNtkY9cowqEOPbg27Jmaf6LgsDxJ7P6b4GF
   cp2IWVEj7VbOz4vcD9CW9M3d3zZdrGD/kvnfOWDTpfAZ7XCgTXe76GV1r
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10419"; a="351889228"
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="351889228"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 01:29:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="627803966"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 26 Jul 2022 01:28:59 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 511523ED; Tue, 26 Jul 2022 11:29:09 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Jens Axboe <axboe@kernel.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] asm-generic: Make parameter types consisten in _unaligned_be48()
Date:   Tue, 26 Jul 2022 11:29:08 +0300
Message-Id: <20220726082908.71341-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a convention to use internal kernel types, hence replace
__u8 by u8.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/asm-generic/unaligned.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index df30f11b4a46..699650f81970 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -126,7 +126,7 @@ static inline void put_unaligned_le24(const u32 val, void *p)
 	__put_unaligned_le24(val, p);
 }
 
-static inline void __put_unaligned_be48(const u64 val, __u8 *p)
+static inline void __put_unaligned_be48(const u64 val, u8 *p)
 {
 	*p++ = val >> 40;
 	*p++ = val >> 32;
-- 
2.35.1

