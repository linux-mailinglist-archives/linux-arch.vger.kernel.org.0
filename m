Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD603614CB
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbhDOWQ0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:16:26 -0400
Received: from mga14.intel.com ([192.55.52.115]:22365 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236793AbhDOWQG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:16:06 -0400
IronPort-SDR: 0BWrYWP0mxxnEkp2h59WG6sQfuIkAqQgDTSCOog5mEcJ806yual17bmsoIIGCTQiMtaCmSMZik
 3xyJENb2uMtA==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="194513346"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="194513346"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:35 -0700
IronPort-SDR: qvfGocxsYcoXPj/x5mK1bSJ/h43huwhDwZ6Visb0yAgiUlIVZiPcANj1kYnyhbxU4qc2qdOp7b
 h+Z77gA8H2uQ==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="451270888"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:15:35 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: [PATCH v25 10/30] drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
Date:   Thu, 15 Apr 2021 15:13:59 -0700
Message-Id: <20210415221419.31835-11-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221419.31835-1-yu-cheng.yu@intel.com>
References: <20210415221419.31835-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After the introduction of _PAGE_COW, a modified page's PTE can have either
_PAGE_DIRTY or _PAGE_COW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
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
index 897c007ea96a..937b6083b2dc 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1216,7 +1216,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	}
 
 	/* Clear dirty field. */
-	se->val64 &= ~_PAGE_DIRTY;
+	se->val64 &= ~_PAGE_DIRTY_BITS;
 
 	ops->clear_pse(se);
 	ops->clear_ips(se);
-- 
2.21.0

