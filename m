Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE086BAF44
	for <lists+linux-arch@lfdr.de>; Wed, 15 Mar 2023 12:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjCOLb6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Mar 2023 07:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231563AbjCOLbq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Mar 2023 07:31:46 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C898637EB;
        Wed, 15 Mar 2023 04:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678879905; x=1710415905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iwb00sFFSTPogcirxHway05JjoMe28eGhip2vpTL5qE=;
  b=koXTKplPFP8v3n3Kd+PxTUwBvXmaAjfVoESvEmqtRU6xNetdFIQEfXyv
   bK/oJtj9g3aN0R3lKi1YYcT40J0MZ1wt08AHFjGmu2aJP7PFUrpdJuqZP
   66QcbOtDGLaJAMPLWjAWY7H9V4gxeZGjB9vuQ49HQsjSS0K/ughe85jcT
   FwzUWmkY5/Qbr8CyP5pbAlnTCIexsH+h5ekLF+Vs2J17Ki1DpaVv4tq2s
   Ur/DGd/5xvgZ3SoXX7xjnhC1GYFtNyTzmAC8G3KgGMqjNZRVWAO71zl0c
   RExxRKGiQGxxWK7B+EWLiiiSpRY+efKI+JxfH6vS3MSUgE1jG5e7Ihrqd
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="340040105"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="340040105"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10649"; a="768456009"
X-IronPort-AV: E=Sophos;i="5.98,262,1673942400"; 
   d="scan'208";a="768456009"
Received: from nopopovi-mobl1.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.33.48])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2023 04:31:38 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id C230110CCA0; Wed, 15 Mar 2023 14:31:35 +0300 (+03)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>, Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Subject: [PATCH 04/10] drm/i915: Fix MAX_ORDER usage in i915_gem_object_get_pages_internal()
Date:   Wed, 15 Mar 2023 14:31:27 +0300
Message-Id: <20230315113133.11326-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
References: <20230315113133.11326-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

MAX_ORDER is not inclusive: the maximum allocation order buddy allocator
can deliver is MAX_ORDER-1.

Fix MAX_ORDER usage in i915_gem_object_get_pages_internal().

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_internal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_internal.c b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
index 6bc26b4b06b8..eae9e9f6d3bf 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_internal.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_internal.c
@@ -36,7 +36,7 @@ static int i915_gem_object_get_pages_internal(struct drm_i915_gem_object *obj)
 	struct sg_table *st;
 	struct scatterlist *sg;
 	unsigned int npages; /* restricted by sg_alloc_table */
-	int max_order = MAX_ORDER;
+	int max_order = MAX_ORDER - 1;
 	unsigned int max_segment;
 	gfp_t gfp;
 
-- 
2.39.2

