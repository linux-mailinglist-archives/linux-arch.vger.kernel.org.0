Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48D7436A4C
	for <lists+linux-arch@lfdr.de>; Thu, 21 Oct 2021 20:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbhJUSRj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 21 Oct 2021 14:17:39 -0400
Received: from mga14.intel.com ([192.55.52.115]:33015 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230020AbhJUSRj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 21 Oct 2021 14:17:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10144"; a="229377370"
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="229377370"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:20 -0700
X-IronPort-AV: E=Sophos;i="5.87,170,1631602800"; 
   d="scan'208";a="527582106"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2021 11:15:19 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 1/2] drm/i915/gem: stop using PAGE_KERNEL_IO
Date:   Thu, 21 Oct 2021 11:15:10 -0700
Message-Id: <20211021181511.1533377-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211021181511.1533377-1-lucas.demarchi@intel.com>
References: <20211021181511.1533377-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

PAGE_KERNEL_IO is only defined for x86 and nowadays is the same as
PAGE_KERNEL. It was different for some time, OR'ing a `_PAGE_IOMAP` flag
in commit be43d72835ba ("x86: add _PAGE_IOMAP pte flag for IO
mappings").  This got removed in commit f955371ca9d3 ("x86: remove the
Xen-specific _PAGE_IOMAP PTE flag"), so today they are just the same.

This is the same that was done in commit ac96b5566926 ("io-mapping.h:
s/PAGE_KERNEL_IO/PAGE_KERNEL/").

There is a subsequent commit with
'Fixes: ac96b5566926 ("io-mapping.h: s/PAGE_KERNEL_IO/PAGE_KERNEL/")' -
but that is not relevant here since is it's actually fixing the different
names for pgprot_writecombine(), which we also don't have today since
all archs expose pgprot_writecombine(). Microblaze, mentioned in that
discussion, gained pgprot_writecombine() in
commit 97ccedd793ac ("microblaze: Provide pgprot_device/writecombine
macros for nommu").

So, just use PAGE_KERNEL, and just use pgprot_writecombine().

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://patchwork.freedesktop.org/patch/msgid/20211020090625.1037517-1-lucas.demarchi@intel.com
---
 drivers/gpu/drm/i915/gem/i915_gem_pages.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_pages.c b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
index 8eb1c3a6fc9c..68fe1837ef54 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_pages.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_pages.c
@@ -289,7 +289,7 @@ static void *i915_gem_object_map_page(struct drm_i915_gem_object *obj,
 		pgprot = PAGE_KERNEL;
 		break;
 	case I915_MAP_WC:
-		pgprot = pgprot_writecombine(PAGE_KERNEL_IO);
+		pgprot = pgprot_writecombine(PAGE_KERNEL);
 		break;
 	}
 
@@ -333,7 +333,7 @@ static void *i915_gem_object_map_pfn(struct drm_i915_gem_object *obj,
 	i = 0;
 	for_each_sgt_daddr(addr, iter, obj->mm.pages)
 		pfns[i++] = (iomap + addr) >> PAGE_SHIFT;
-	vaddr = vmap_pfn(pfns, n_pfn, pgprot_writecombine(PAGE_KERNEL_IO));
+	vaddr = vmap_pfn(pfns, n_pfn, pgprot_writecombine(PAGE_KERNEL));
 	if (pfns != stack)
 		kvfree(pfns);
 
-- 
2.33.1

