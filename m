Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9902254F3D4
	for <lists+linux-arch@lfdr.de>; Fri, 17 Jun 2022 11:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381308AbiFQJFQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Jun 2022 05:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381460AbiFQJEo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Jun 2022 05:04:44 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFBD47AD4;
        Fri, 17 Jun 2022 02:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655456683; x=1686992683;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9LifgJawyskDRAs2PzhTDj2UVJgMkJu/n5gcY0Ffzw0=;
  b=ZyhLto0rAaX9ZfZBsKV1s6oeKC2cigXTshlZIvw4sRp+kY0U447Y1Vdl
   QthMImmYLxeW1YpUuMMGy3PD0h2lSEfE//knjuYxeAEpjME/UC0Xniaox
   ZqHn47Y1s/1o70dIGWyqJDrCh+4uKY1z5FGyZQsZgbduEgAnhuD1tS6aJ
   djKz5JzGa9lfuuX3HBylMIVIm3rEAyXq8rB+f5T/NyDZMqFsHE95A4XX0
   my23QmmmcCRx+mJyceiWepTHjj7PABHLSf0knrY6h6NBdQweQvsU+cqUK
   iLQA1yCfPKKbnkiX14ZkaaGlx289ce8PFrQJ4XMGlM2DbbcUuUTUPI5/f
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="341114175"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="341114175"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:04:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="613491129"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 02:04:28 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH] compiler.h: Use compound statement for WRITE_ONCE
Date:   Fri, 17 Jun 2022 02:04:24 -0700
Message-Id: <20220617090423.1743297-1-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Instead of a do { } while (0), replace the outer wrapper with compound
statement. It allows to use WRITE_ONCE() inside a _Generic() without
exploding the build with the following error:

	  CC [M]  drivers/gpu/drm/i915/gt/uc/intel_guc_ads.o
	In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
			 from ./include/linux/compiler.h:248,
			 from ./include/linux/build_bug.h:5,
			 from ./include/linux/bitfield.h:10,
			 from ./drivers/gpu/drm/i915/i915_reg_defs.h:9,
			 from ./drivers/gpu/drm/i915/gt/intel_engine_regs.h:9,
			 from drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c:8:
	drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c: In function ‘guc_policies_init’:
	./include/asm-generic/rwonce.h:59:1: error: expected expression before ‘do’
	   59 | do {                                                                    \
	      | ^~
	./include/linux/iosys-map.h:367:13: note: in expansion of macro ‘WRITE_ONCE’
	  367 |         u8: WRITE_ONCE(*((u8 *)vaddr__), val__),                                \
	      |             ^~~~~~~~~~
	./include/linux/iosys-map.h:412:17: note: in expansion of macro ‘__iosys_map_wr_sys’
	  412 |                 __iosys_map_wr_sys(val, (map__)->vaddr + (offset__), type__);   \
	      |                 ^~~~~~~~~~~~~~~~~~
	./include/linux/iosys-map.h:500:9: note: in expansion of macro ‘iosys_map_wr’
	  500 |         iosys_map_wr(map__, struct_offset__ + offsetof(struct_type__, field__),         \
	      |         ^~~~~~~~~~~~
	drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c:68:9: note: in expansion of macro ‘iosys_map_wr_field’
	   68 |         iosys_map_wr_field(&(guc_)->ads_map, 0, struct __guc_ads_blob,  \
	      |         ^~~~~~~~~~~~~~~~~~
	drivers/gpu/drm/i915/gt/uc/intel_guc_ads.c:145:9: note: in expansion of macro ‘ads_blob_write’
	  145 |         ads_blob_write(guc, policies.dpc_promote_time,
	      |         ^~~~~~~~~~~~~~

One alternative would be to wrap the WRITE_ONCE in a compound statement
inside the _Generic(), but there is no downside on simply replacing the
do { } while (0).

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

I hit the above error when adding some additional changes in
include/linux/iosys-map.h. After changing WRITE_ONCE() and checking its
implementation I realized it would be simpler not using a _Generic() for
the WRITE_ONCE, like in
https://lore.kernel.org/dri-devel/20220617085204.1678035-2-lucas.demarchi@intel.com/T/#u

So this patch is not strictly needed, but may be desirable for future
users.

 include/asm-generic/rwonce.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/asm-generic/rwonce.h b/include/asm-generic/rwonce.h
index 8d0a6280e982..6a94c1f21648 100644
--- a/include/asm-generic/rwonce.h
+++ b/include/asm-generic/rwonce.h
@@ -56,10 +56,10 @@ do {									\
 } while (0)
 
 #define WRITE_ONCE(x, val)						\
-do {									\
+({									\
 	compiletime_assert_rwonce_type(x);				\
 	__WRITE_ONCE(x, val);						\
-} while (0)
+})
 
 static __no_sanitize_or_inline
 unsigned long __read_once_word_nocheck(const void *addr)
-- 
2.36.1

