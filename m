Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B007157FE
	for <lists+linux-arch@lfdr.de>; Tue, 30 May 2023 10:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjE3IH5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 May 2023 04:07:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjE3IH3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 May 2023 04:07:29 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6E196;
        Tue, 30 May 2023 01:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685434023; x=1716970023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iLg8+BuQb6cfAwix3TzfWOi+K6oPegJSPNVGDscU724=;
  b=GrsIz0w5JHLXgZKnKvK2hqHcRv02qPfxF2wM8z+g9GqWmhw5E3FqLUHP
   Vabw1/vyKCeIEvZyCyNLxj+EIHLytfhyOkY8Zb/TiN5Fk5VKUsg+Rj/yL
   n+/UjPZQ6ZNrYm104t6Y4Mw0Q7xUrhYutzp928iwST7MFHETzlh1llD6j
   4YbjbhLo7sLfEypGH9/1t8oGVL3XdiXMnN2MwZWRngkDF62PqLVfq173G
   sDyobAf4F7FFd/5WiJVP52dfRSShK5O/1VUg178IfE0okAH/eED36ume6
   QPixbGkx5df52EM817hDfMO7nEg7ZJaogsYfDqRXGASJY4+EjTUf+EARg
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="344349314"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="344349314"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2023 01:06:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10725"; a="880678883"
X-IronPort-AV: E=Sophos;i="6.00,203,1681196400"; 
   d="scan'208";a="880678883"
Received: from fyin-dev.sh.intel.com ([10.239.159.32])
  by orsmga005.jf.intel.com with ESMTP; 30 May 2023 01:06:54 -0700
From:   Yin Fengwei <fengwei.yin@intel.com>
To:     willy@infradead.org, ryan.roberts@arm.com,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     fengwei.yin@intel.com
Subject: [PATCH 4/4] filemap: Check address range in filemap_map_folio_range()
Date:   Tue, 30 May 2023 16:07:31 +0800
Message-Id: <20230530080731.1462122-5-fengwei.yin@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230530080731.1462122-1-fengwei.yin@intel.com>
References: <ZBho6Q6Xq/YqRmBT@casper.infradead.org>
 <20230530080731.1462122-1-fengwei.yin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With filemap_map_folio_range(), the addr is updated with range
also. Address range checking is needed to make sure correct
return value (VM_FAULT_NOPAGE) if vmf->address is handled.

Signed-off-by: Yin Fengwei <fengwei.yin@intel.com>
---
 mm/filemap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index fdb3e0a339b3..0f4baba1cd31 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3488,15 +3488,15 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (!pte_none(vmf->pte[count]))
 			goto skip;
 
-		if (vmf->address == addr)
-			ret = VM_FAULT_NOPAGE;
-
 		count++;
 		continue;
 skip:
 		if (count) {
 			set_pte_range(vmf, folio, page, count, addr);
 			folio_ref_add(folio, count);
+			if ((vmf->address < (addr + count * PAGE_SIZE)) &&
+					(vmf->address >= addr))
+				ret = VM_FAULT_NOPAGE;
 		}
 
 		count++;
@@ -3509,6 +3509,9 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 	if (count) {
 		set_pte_range(vmf, folio, page, count, addr);
 		folio_ref_add(folio, count);
+		if ((vmf->address < (addr + count * PAGE_SIZE)) &&
+				(vmf->address >= addr))
+			ret = VM_FAULT_NOPAGE;
 	}
 
 	vmf->pte = old_ptep;
-- 
2.30.2

