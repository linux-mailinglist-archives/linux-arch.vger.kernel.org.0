Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5B4E278BEE
	for <lists+linux-arch@lfdr.de>; Fri, 25 Sep 2020 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729516AbgIYPCd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Sep 2020 11:02:33 -0400
Received: from mga04.intel.com ([192.55.52.120]:17795 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729513AbgIYPCc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 25 Sep 2020 11:02:32 -0400
IronPort-SDR: FrPeGfGhdlUkvJ3Ytc0VDGHP8XPswHWFaw5obixpcmm9v+2kBrpQGaxSWCp8BKpCPdUiFBASUq
 Ked+bD3ynpNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9755"; a="158942284"
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="158942284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:57:20 -0700
IronPort-SDR: kZeyPmI4vaAxpJYs/0m8HiVw8F4xDJJkTMT2lPwMF58GzS526xi7Z+2DrmcXlLkp/FT51cYd6k
 t4YgQXsTBIsw==
X-IronPort-AV: E=Sophos;i="5.77,302,1596524400"; 
   d="scan'208";a="487499165"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2020 07:57:19 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        David Airlie <airlied@linux.ie>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Zhenyu Wang <zhenyuw@linux.intel.com>,
        Zhi Wang <zhi.a.wang@intel.com>
Subject: [PATCH v13 09/26] drm/i915/gvt: Change _PAGE_DIRTY to _PAGE_DIRTY_BITS
Date:   Fri, 25 Sep 2020 07:56:32 -0700
Message-Id: <20200925145649.5438-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925145649.5438-1-yu-cheng.yu@intel.com>
References: <20200925145649.5438-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

After the introduction of _PAGE_COW, a modified page's PTE can have either
_PAGE_DIRTY_HW or _PAGE_COW.  Change _PAGE_DIRTY to _PAGE_DIRTY_BITS.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
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
index a3a4305eda01..dd0ab28cfe7d 100644
--- a/drivers/gpu/drm/i915/gvt/gtt.c
+++ b/drivers/gpu/drm/i915/gvt/gtt.c
@@ -1207,7 +1207,7 @@ static int split_2MB_gtt_entry(struct intel_vgpu *vgpu,
 	}
 
 	/* Clear dirty field. */
-	se->val64 &= ~_PAGE_DIRTY;
+	se->val64 &= ~_PAGE_DIRTY_BITS;
 
 	ops->clear_pse(se);
 	ops->clear_ips(se);
-- 
2.21.0

