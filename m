Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56BAA4A39FB
	for <lists+linux-arch@lfdr.de>; Sun, 30 Jan 2022 22:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356613AbiA3VWH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 Jan 2022 16:22:07 -0500
Received: from mga06.intel.com ([134.134.136.31]:52019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356485AbiA3VV5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 Jan 2022 16:21:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643577717; x=1675113717;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=+eAnCtRCGeSNI9GSLUBTMzpMHzzkOWpz+oSQRTzFUvU=;
  b=R5qmEBhFh7gdCtULQD9itTCPsFHLB+7JDmovQZlSK1UwgUOWU8ugIX9J
   bqNwIcAVKul2a+05DMoY+KFKP/qeJZ6bwJ+EtH8AGy+gt7kkTVobqXIOY
   2UNeG7nkm1wl0v6Fb25tJGMDit3EZKs41rI6eMVgNcFL+l/PsCmJ/jxoA
   0uz1G6YVhwooy+GkH+f6eNr+biOAycOIEuFB1T5uWL0Q0CU45q+Etrajp
   hHzvqwB6U2j3Juzio9ZHfEOvbsJC24AT7wInw4FJBC5em+eOHlaz7P+be
   RT66qM3b1iaFZEE0PEyeE5+vtVsHhz48jIHNJ2M4nbvfvuW7TSfGdtQCd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10243"; a="308104914"
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="308104914"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:54 -0800
X-IronPort-AV: E=Sophos;i="5.88,329,1635231600"; 
   d="scan'208";a="536856742"
Received: from avmallar-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.123.171])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2022 13:21:53 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: [PATCH 10/35] drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
Date:   Sun, 30 Jan 2022 13:18:13 -0800
Message-Id: <20220130211838.8382-11-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
References: <20220130211838.8382-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

After the introduction of _PAGE_COW, a modified page's PTE can have either
_PAGE_DIRTY or _PAGE_COW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Zhenyu Wang <zhenyuw@linux.intel.com>
Cc: Zhi Wang <zhi.a.wang@intel.com>
---
 drivers/gpu/drm/i915/gvt/gtt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gvt/gtt.c b/drivers/gpu/drm/i915/gvt/gtt.c
index 99d1781fa5f0..75ce4e823902 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1210,7 +1210,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	}
 
 	/* Clear dirty field. */
-	se->val64 &= ~_PAGE_DIRTY;
+	se->val64 &= ~_PAGE_DIRTY_BITS;
 
 	ops->clear_pse(se);
 	ops->clear_ips(se);
-- 
2.17.1

