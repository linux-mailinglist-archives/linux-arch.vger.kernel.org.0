Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F16028BCC5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 17:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390432AbgJLPp4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 11:45:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:28363 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389679AbgJLPpy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 11:45:54 -0400
IronPort-SDR: MlsyVr1OnNJesxjWWNN6cOaEy0W0rLhZtKyVCDYTyY/5UlkJkM1IjZuTTWzbcjPfQxavxtRMjh
 FaspqaiIamxg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="229939280"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="229939280"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:53 -0700
IronPort-SDR: dT8YBHUy5MplZWJv2T+ldPrELLooBThUCJzDR2lmDsPOfDvwkNvbhOK68/M3QT5ZvXoEE8vOZ2
 6At1tdjY3CWA==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="530012645"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:52 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 5/7] x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
Date:   Mon, 12 Oct 2020 08:45:28 -0700
Message-Id: <20201012154530.28382-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201012154530.28382-1-yu-cheng.yu@intel.com>
References: <20201012154530.28382-1-yu-cheng.yu@intel.com>
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
---
 arch/x86/kernel/cet_prctl.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index bd5ad11763e4..0af1ec5d028f 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -22,6 +22,9 @@ static int copy_status_to_user(struct cet_status *cet, u64 arg2)
 		buf[2] = (u64)cet->shstk_size;
 	}
 
+	if (cet->ibt_enabled)
+		buf[0] |= GNU_PROPERTY_X86_FEATURE_1_IBT;
+
 	return copy_to_user((u64 __user *)arg2, buf, sizeof(buf));
 }
 
@@ -42,7 +45,8 @@ int prctl_cet(int option, u64 arg2)
 	if (option == ARCH_X86_CET_STATUS)
 		return copy_status_to_user(cet, arg2);
 
-	if (!static_cpu_has(X86_FEATURE_SHSTK))
+	if (!static_cpu_has(X86_FEATURE_SHSTK) &&
+	    !static_cpu_has(X86_FEATURE_IBT))
 		return -EOPNOTSUPP;
 
 	switch (option) {
@@ -56,6 +60,8 @@ int prctl_cet(int option, u64 arg2)
 			return -EINVAL;
 		if (features & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 			cet_disable_shstk();
+		if (features & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			cet_disable_ibt();
 		return 0;
 
 	case ARCH_X86_CET_LOCK:
-- 
2.21.0

