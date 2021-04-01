Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D793522A1
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235836AbhDAWOj (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:14:39 -0400
Received: from mga09.intel.com ([134.134.136.24]:14893 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235847AbhDAWOc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:14:32 -0400
IronPort-SDR: ciZSaEYQdRffxuwZMXqgsYKh5vMRVLS6wcAd0wUPZC5DTPMx6t9FiMvX/G7IsCQH+ZdVrUkNRS
 1qbStlhGbPsw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="192444279"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="192444279"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:22 -0700
IronPort-SDR: LifuTxKaBv1L2f+5d2yrq0QuNEtEJoPxnih+pxcKNyEmbo47tK0KEKM1hFgeQAhbXfD48RSyuY
 vOZvm0dJaD9A==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394700345"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:22 -0700
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
Subject: [PATCH v24 5/9] x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
Date:   Thu,  1 Apr 2021 15:13:59 -0700
Message-Id: <20210401221403.32253-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221403.32253-1-yu-cheng.yu@intel.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
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
index 5f0054177d2a..ae31741d829a 100644
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

