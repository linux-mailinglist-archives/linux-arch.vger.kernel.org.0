Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F3F07157FA
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 10:07:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230095AbjE3IHc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 04:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbjE3IHL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 04:07:11 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A2D3E5F;
        Tue, 30 May 2023 01:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685434006; x=1716970006;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3NUJ2cV526DtOmRsdjgiB8BAWkISfmdbH9OrsnpKKCA=;
  b=ePA0Sj4et55eLFzeuvoOqqtw9lnmEFV7f/t413xNcDEHZiWCYdZlUnQD
   lvEqYmfdmbho0vUVORm+9jOtpY/B13XvgSmYXgRptxe/7+U3dO10YcOKK
   QfT701J0TQYILBE9/z63L364amL2YdjGrfbc8s2H2qFOKx/L/MmbyMLqW
   w5mansNW0WptJ6mRYmvb3GnffIcqf0Dwc7miErg493dZ3bkJpb5HitIOW
   B7OLD3R0Pi4h3CC0xxvxGz1WRab2S59R9Z4+5pb78PBpd557Vc6i+HrQG
   iFFxJqRos3LK75H3Dis8UTCGght0r/pVENy/J+DEfU0w7dxoWarhKeTyR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="335196940"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="335196940"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:06:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="706326971"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="706326971"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga002.jf.intel.com with ESMTP; 30 May 2023 01:06:43 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     willy@infradead.org, ryan.roberts@arm.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH 3/4] mm: mark PTEs referencing the accessed folio young
Date:   Tue, 30 May 2023 16:07:30 +0800
Message-Id: <20230530080731.1462122-4-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230530080731.1462122-1-fengwei.yin@intel.com>
References: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
 <20230530080731.1462122-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To allow using larger TLB entries, it's better to mark the
PTEs of same folio accessed when setup the PTEs.

Reported-by: Ryan Roberts <ryan.roberts@arm.com>
Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/memory.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c359fb8643e5..2615ea552613 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4259,7 +4259,7 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
 	struct vm_area_struct *vma = vmf->vma;
 	bool uffd_wp = pte_marker_uffd_wp(vmf->orig_pte);
 	bool write = vmf->flags & FAULT_FLAG_WRITE;
-	bool prefault = vmf->address != addr;
+	bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
 	pte_t entry;
 
 	flush_icache_pages(vma, page, nr);
-- 
2.30.2

