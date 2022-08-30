Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31B15A6A8E
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 19:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbiH3Ran (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 13:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231841AbiH3RaG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 13:30:06 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A300C164C;
        Tue, 30 Aug 2022 10:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661880426; x=1693416426;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nfjAquwvPrsZjW+HCh9ZbW4jSr2IWvP1RhPAokUj0yc=;
  b=Cbg44QkN4eYXqJU87I/D7qVbNSIac2AEYfMu/OFhaCr5481bXhMKG8sU
   /LrY409a01tScoEa75IF2dvmp3ZgrFBrbgr7xhj0P18afcOg8vKKeEIlb
   KLOmHNPzjP7cQs77X+IoDEuSWpT6X+tqZEQQYFYn5T5ubLU1Ingkm/QQP
   t7hzG/ROzaMJjLYTpEpKHDcaPY/G++jvRm2p3siGu5ut3ooMSCyN95tGG
   +mvp460Y0WJ6bs+lEEwHyjDf7lZQwjhZZY+xT0IpDXixst0JAkpSzpR/X
   2QPSQ+mXpSjIsivsENKiHTgxHWQfnS8Lj4sHRPtyBgj6GiVNHIzld7zZk
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="321383664"
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="321383664"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 10:27:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="754124084"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 30 Aug 2022 10:27:03 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id AF24CAD; Tue, 30 Aug 2022 20:27:17 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Keith Busch <kbusch@kernel.org>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [RESEND][PATCH v1 1/1] asm-generic: Make parameter types consisten in _unaligned_be48()
Date:   Tue, 30 Aug 2022 20:27:13 +0300
Message-Id: <20220830172713.43686-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is a convention to use internal kernel types, hence replace
__u8 by u8.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Cc'ed to Andrew since original code authors didn't respond for a month
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

