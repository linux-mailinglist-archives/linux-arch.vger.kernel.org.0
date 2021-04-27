Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80EA336CD22
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239026AbhD0Us5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:48:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:56333 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239050AbhD0Usm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:48:42 -0400
IronPort-SDR: fS5q1pddt9hFLoXEvuKYjzOzgDxBvYLkQVsZP8Q3FYAmcwMSpGFTzvcM/njqeGCckidwUqViBD
 cOOpisLRmJPA==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196699391"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="196699391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:47 -0700
IronPort-SDR: ZJLrSBbSRJuTYagjrCFfM3ti+f2Obbsudc8GHCim9z3MOQzNlG42ypfvQuFU7lXF7/I5kIRL7P
 tcKg4RVl/h1Q==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="457835088"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:47 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v26 5/9] x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
Date:   Tue, 27 Apr 2021 13:47:16 -0700
Message-Id: <20210427204720.25007-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204720.25007-1-yu-cheng.yu@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

Update ARCH_X86_CET_STATUS and ARCH_X86_CET_DISABLE for Indirect Branch
Tracking.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
v24:
- Update for function name changes introduced from splitting shadow stack and ibt.

 arch/x86/kernel/cet_prctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index 3bb9f32ca70d..ab05597545c5 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -22,6 +22,9 @@ static int cet_copy_status_to_user(struct cet_status *cet, u64 __user *ubuf)
 		buf[2] = cet->shstk_size;
 	}
 
+	if (cet->ibt_enabled)
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_IBT;
+
 	return copy_to_user(ubuf, buf, sizeof(buf));
 }
 
@@ -46,6 +49,8 @@ int prctl_cet(int option, u64 arg2)
 			return -EINVAL;
 		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			shstk_disable();
+		if (arg2 & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			ibt_disable();
 		return 0;
 
 	case ARCH_X86_CET_LOCK:
-- 
2.21.0

