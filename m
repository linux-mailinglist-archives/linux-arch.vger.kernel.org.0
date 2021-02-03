Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD7330E69D
	for <lists+linux-arch@lfdr.de>; Thu,  4 Feb 2021 00:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbhBCXDw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 18:03:52 -0500
Received: from mga06.intel.com ([134.134.136.31]:30209 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233591AbhBCXCx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 3 Feb 2021 18:02:53 -0500
IronPort-SDR: OPZnYxQSa7Pnw+FnPjW2tcVWOILEwTnZvvuUeHZmWk2E6i0HHm8x0dC29E8dxxJQXaZ0qd6Y7H
 PeTtR370s/7A==
X-IronPort-AV: E=McAfee;i="6000,8403,9884"; a="242642710"
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="242642710"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:59:43 -0800
IronPort-SDR: 0Bj1lQC6b8Istb399+hTMKe8nEFRobb64fLPwc9AmnvWaLrvsox0jAgg1z1V4SqkWipBKrbAv3
 e2sxyOZTwh4Q==
X-IronPort-AV: E=Sophos;i="5.79,399,1602572400"; 
   d="scan'208";a="392698020"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2021 14:59:42 -0800
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
Subject: [PATCH v19 6/7] x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
Date:   Wed,  3 Feb 2021 14:59:01 -0800
Message-Id: <20210203225902.479-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210203225902.479-1-yu-cheng.yu@intel.com>
References: <20210203225902.479-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

Add ENDBR32 to __kernel_vsyscall entry point.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vdso32/system_call.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index de1fff7188aa..f19eaec3de3b 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -14,6 +14,9 @@
 	ALIGN
 __kernel_vsyscall:
 	CFI_STARTPROC
+#ifdef CONFIG_X86_CET
+	endbr32
+#endif
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
-- 
2.21.0

