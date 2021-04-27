Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 124BA36CD29
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239232AbhD0UtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:49:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:56332 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238905AbhD0Usy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:48:54 -0400
IronPort-SDR: qrHD+RE+DRSMklvCHzKqg/r7ELFtZ2kSPT06UPd1Yx0bBnomtnzRIJjEizil9dmgf7WG1dw4M5
 NbihUXW8WFmg==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196699395"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="196699395"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:48 -0700
IronPort-SDR: f9inyIWS4gdZNzCtHUkX3aKAiva8vNIjb2Agxbkgs5rvZKph/uQp35BbsuI/yGTappcjSSPtYj
 0kLYOjdstLng==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="457835096"
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v26 7/9] x86/vdso: Introduce ENDBR macro
Date:   Tue, 27 Apr 2021 13:47:18 -0700
Message-Id: <20210427204720.25007-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204720.25007-1-yu-cheng.yu@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
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

Introduce ENDBR64/ENDBR32 macros.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v25:
- Change from using the compiler's cet.h back to just ENDBR64/ENDBR32,
  since the information is already known, and keep it simple.

 arch/x86/include/asm/vdso.h | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index 98aa103eb4ab..97358246e4c7 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -52,6 +52,24 @@ extern int map_vdso_once(const struct vdso_image *image, unsigned long addr);
 extern bool fixup_vdso_exception(struct pt_regs *regs, int trapnr,
 				 unsigned long error_code,
 				 unsigned long fault_addr);
-#endif /* __ASSEMBLER__ */
+#else /* __ASSEMBLER__ */
+
+/*
+ * ENDBR is an instruction for the Indirect Branch Tracking (IBT) component
+ * of CET.  IBT prevents attacks by ensuring that (most) indirect branches
+ * function calls may only land at ENDBR instructions.  Branches that don't
+ * follow the rules will result in control flow (#CF) exceptions.
+ * ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
+ * instructions are inserted automatically by the compiler, but branch
+ * targets written in assembly must have ENDBR added manually.
+ */
+#ifdef CONFIG_X86_IBT
+#define ENDBR64 endbr64
+#define ENDBR32 endbr32
+#else
+#define ENDBR64
+#define ENDBR32
+#endif
 
+#endif /* __ASSEMBLER__ */
 #endif /* _ASM_X86_VDSO_H */
-- 
2.21.0

