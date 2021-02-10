Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB857316E10
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 19:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbhBJSIz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 13:08:55 -0500
Received: from mga07.intel.com ([134.134.136.100]:19697 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233412AbhBJSGo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 13:06:44 -0500
IronPort-SDR: nrJyvJIdGxR6cEwTxBu3xpnSVcIvUilwo1UBilaSvYSzPsuePeqxjoo8bFwo6yTea6gBx5RWGP
 /J0O3R0fdqSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246189818"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246189818"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:58 -0800
IronPort-SDR: vncLGDX47fOEmp0H2w5gDSaCCkgkMEv2tAsUZoua33xfbaEpri1HJlRIUoubAxfPL1kkcvtN/6
 2PtnyiP0k/eA==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380239228"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:57 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v20 6/7] x86/vdso/32: Add ENDBR32 to __kernel_vsyscall entry point
Date:   Wed, 10 Feb 2021 10:02:44 -0800
Message-Id: <20210210180245.13770-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210210180245.13770-1-yu-cheng.yu@intel.com>
References: <20210210180245.13770-1-yu-cheng.yu@intel.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
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

