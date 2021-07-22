Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF453D2E9C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 22:58:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGVURi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 16:17:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:54784 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231419AbhGVURc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 16:17:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10053"; a="275561727"
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="275561727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:06 -0700
X-IronPort-AV: E=Sophos;i="5.84,262,1620716400"; 
   d="scan'208";a="433273388"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2021 13:58:05 -0700
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
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Haitao Huang <haitao.huang@intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v28 10/10] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
Date:   Thu, 22 Jul 2021 13:57:23 -0700
Message-Id: <20210722205723.9476-11-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210722205723.9476-1-yu-cheng.yu@intel.com>
References: <20210722205723.9476-1-yu-cheng.yu@intel.com>
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

Add ENDBR to __vdso_sgx_enter_enclave() indirect branch targets, including
EEXIT, which is considered an indirect branch.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
v28:
- Move ENDBR64 below EEXIT comment (no functional change).
- Update change log, state EEXIT is considered an indirect branch.

 arch/x86/entry/vdso/vsgx.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 99dafac992e2..d65a7f9dea8b 100644
--- a/arch/x86/entry/vdso/vsgx.S
+++ b/arch/x86/entry/vdso/vsgx.S
@@ -4,6 +4,7 @@
 #include <asm/export.h>
 #include <asm/errno.h>
 #include <asm/enclu.h>
+#include <asm/vdso.h>
 
 #include "extable.h"
 
@@ -27,6 +28,7 @@
 SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	/* Prolog */
 	.cfi_startproc
+	ENDBR64
 	push	%rbp
 	.cfi_adjust_cfa_offset	8
 	.cfi_rel_offset		%rbp, 0
@@ -64,6 +66,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	enclu
 
 	/* EEXIT jumps here unless the enclave is doing something fancy. */
+	ENDBR64
 	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
 
 	/* Set exit_reason. */
@@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	jmp	.Lout
 
 .Lhandle_exception:
+	ENDBR64
 	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
 
 	/* Set the exception info. */
-- 
2.21.0

