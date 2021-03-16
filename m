Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EAEB33D716
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 16:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbhCPPRv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 11:17:51 -0400
Received: from mga05.intel.com ([192.55.52.43]:18968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235669AbhCPPRd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 11:17:33 -0400
IronPort-SDR: puOPESrcX5kDCxXA8ISL4APA0OVkhbWB3/POxy0NWV0HHNxW+QvD8VV36YzmAQaExPGBQMLpEv
 wxbwM5Oqf4Sg==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274320167"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274320167"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:30 -0700
IronPort-SDR: /RLryx7L59dd3UdJqntuQHMiDOCDuccNgP0d2n9LHTfD/E+xNf6CHs+k8KWgvc8tQfpqTo5rCR
 UxDz5dg8tdwg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449749003"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:29 -0700
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
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v23 6/9] x86/entry: Introduce ENDBR macro
Date:   Tue, 16 Mar 2021 08:13:16 -0700
Message-Id: <20210316151320.6123-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210316151320.6123-1-yu-cheng.yu@intel.com>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
component of CET.  IBT prevents attacks by ensuring that (most) indirect
branches and function calls may only land at ENDBR instructions.  Branches
that don't follow the rules will result in control flow (#CF) exceptions.

ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
instructions are inserted automatically by the compiler, but branch
targets written in assembly must have ENDBR added manually.

There are two ENDBR versions: one for 64-bit and the other for 32.
Introduce a macro to eliminate ifdeffery at call sites.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/entry/calling.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 07a9331d55e7..a63d33f7f069 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -392,3 +392,21 @@ For 32-bit we have the following conventions - kernel is built with
 .endm
 
 #endif /* CONFIG_SMP */
+/*
+ * ENDBR is an instruction for the Indirect Branch Tracking (IBT) component
+ * of CET.  IBT prevents attacks by ensuring that (most) indirect branches
+ * function calls may only land at ENDBR instructions.  Branches that don't
+ * follow the rules will result in control flow (#CF) exceptions.
+ * ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
+ * instructions are inserted automatically by the compiler, but branch
+ * targets written in assembly must have ENDBR added manually.
+ */
+.macro ENDBR
+#ifdef CONFIG_X86_CET
+#ifdef __i386__
+	endbr32
+#else
+	endbr64
+#endif
+#endif
+.endm
-- 
2.21.0

