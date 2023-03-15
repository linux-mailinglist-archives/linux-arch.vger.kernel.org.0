Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36586BAF3E
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231532AbjCOLbp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjCOLbo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B30637EB;
        Wed, 15 Mar 2023 04:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879903; x=1710415903;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QBCZQm/SBz0B4srej1vb8GPqV7WaEgnSaSI+esoAbhU=;
  b=bIAbhfVzz5J3HDJT4ozzENKHtlTtY2IlEkQcFSwaXa9CXQ87lf2wgJml
   9Q5bmDJu4bw8GA/lfgwOB2pOEZ4p7193V8lmDtLOF35rp4M6o7z2u3pOy
   wike/23T3F7NTqB2c/WCLUOL7luHnq5XDeCIVmj9dEDn+a4JFRPeFw2T4
   aKSQLSHzxSyHZo2TIVJN7JUeb5TTz2iGwY8uFe/O06vGRrYp5e+n2XLFK
   w9sd2qVLU6D9u2jBpEj3PgYe8b7WLyrfXAT2ZFj1mPVLdrvN0YdgWqaTP
   8QiJLGRgGLJxDZwhJaZKF1FUTeCmufNzDfUdApHbdBdhdd8p/qkwkeaNK
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="317330287"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="317330287"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="925310515"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="925310515"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id B452D10CC9E; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 02/10] um: Fix MAX_ORDER usage in linux_main()
Date:   Wed, 15 Mar 2023 14:31:25 +0300
Message-Id: <20230315113133.11326-3-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
can deliver is MAX_ORDER-1.

Fix MAX_ORDER usage in linux_main().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
---
 arch/um/kernel/um_arch.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 8dcda617b8bf..5e5a9c8e0e5d 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -368,10 +368,10 @@ int __init linux_main(int argc, char **argv)
 	max_physmem = TASK_SIZE - uml_physmem - iomem_size - MIN_VMALLOC;
 
 	/*
-	 * Zones have to begin on a 1 << MAX_ORDER page boundary,
+	 * Zones have to begin on a 1 << MAX_ORDER-1 page boundary,
 	 * so this makes sure that's true for highmem
 	 */
-	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_ORDER)) - 1);
+	max_physmem &= ~((1 << (PAGE_SHIFT + MAX_ORDER - 1)) - 1);
 	if (physmem_size + iomem_size > max_physmem) {
 		highmem = physmem_size + iomem_size - max_physmem;
 		physmem_size -= highmem;
-- 
2.39.2

