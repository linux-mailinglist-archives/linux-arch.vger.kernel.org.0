Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E52638D136
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbhEUWTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:19:09 -0400
Received: from mga05.intel.com ([192.55.52.43]:55706 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230087AbhEUWSq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:18:46 -0400
IronPort-SDR: rKscn9/GLbdl0/u6Bzo4I11r0s5OpE/Oxs1Nm2Xg/KrJ2xfYCjDFL6L/L28jSwa7AWs9ThytMQ
 kNUSUPLqc5SA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287124418"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287124418"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:29 -0700
IronPort-SDR: 6FPLG67WGIJ/ad6OETWV3vSK1kPZaiCDZqfLQpIwDoAKgpkklqNQvjZbrJYMbl0gX+Lw/VaLQk
 6TASBfqAQUMg==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441269450"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:29 -0700
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
Subject: [PATCH v27 06/10] x86/cet/ibt: Update arch_prctl functions for Indirect Branch Tracking
Date:   Fri, 21 May 2021 15:15:27 -0700
Message-Id: <20210521221531.30168-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221531.30168-1-yu-cheng.yu@intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
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
 arch/x86/kernel/cet_prctl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/cet_prctl.c b/arch/x86/kernel/cet_prctl.c
index b426d200e070..bd3c80d402e7 100644
--- a/arch/x86/kernel/cet_prctl.c
+++ b/arch/x86/kernel/cet_prctl.c
@@ -22,6 +22,9 @@ static int cet_copy_status_to_user(struct thread_shstk *shstk, u64 __user *ubuf)
 		buf[2] = shstk->size;
 	}
 
+	if (shstk->ibt)
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

