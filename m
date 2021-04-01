Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C369352295
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:15:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236096AbhDAWOd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:14:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:20469 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234548AbhDAWO3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:14:29 -0400
IronPort-SDR: IUtbehfkovujpejnmPJ2uHLLyyQTeazSc4GX6EtDVupDPXBJ+J5IMJq9/Ixs6/Sw4h6Cqe511G
 UCOVl94dFRMw==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="256322609"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="256322609"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:29 -0700
IronPort-SDR: EfFYxmM0btWvPE7M4m9lxafXNEuJwU60qUB73YgMo04Iq28pYo+nQ4DfKzZEaFz/pdcJYC2O8U
 ltnfRXVZd3yQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394700365"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:26 -0700
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
Subject: [PATCH v24 8/9] x86/vdso/32: Add ENDBR to __kernel_vsyscall entry point
Date:   Thu,  1 Apr 2021 15:14:02 -0700
Message-Id: <20210401221403.32253-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221403.32253-1-yu-cheng.yu@intel.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

ENDBR is a special new instruction for the Indirect Branch Tracking (IBT)
component of CET.  IBT prevents attacks by ensuring that (most) indirect
branches and function calls may only land at ENDBR instructions.  Branches
that don't follow the rules will result in control flow (#CF) exceptions.

ENDBR is a noop when IBT is unsupported or disabled.  Most ENDBR
instructions are inserted automatically by the compiler, but branch
targets written in assembly must have ENDBR added manually.

Add that to __kernel_vsyscall entry point.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
 arch/x86/entry/vdso/vdso32/system_call.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index de1fff7188aa..c962e7e4f7e3 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -7,6 +7,7 @@
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative-asm.h>
+#include <asm/vdso.h>
 
 	.text
 	.globl __kernel_vsyscall
@@ -14,6 +15,7 @@
 	ALIGN
 __kernel_vsyscall:
 	CFI_STARTPROC
+	ENDBR
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
-- 
2.21.0

