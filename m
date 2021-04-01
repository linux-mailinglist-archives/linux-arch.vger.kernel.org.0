Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95773522A4
	for <lists+linux-arch@lfdr.de>; Fri,  2 Apr 2021 00:15:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236180AbhDAWOk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Apr 2021 18:14:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:20469 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233710AbhDAWOc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 1 Apr 2021 18:14:32 -0400
IronPort-SDR: teoagGWmpeE3VXSLZSJ8A934q3GI2p+WFaIw0jvX45FbQ6A/HXvtEwge7uxjmeMxuiR66ucpRP
 i7+SrwHjaPlA==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="256322613"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="256322613"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:14:29 -0700
IronPort-SDR: 4UZdjzxA+n9288G5UQT4CLuxI057gYd9lwhM+eVMUBVgkVYelhKG0aXgVHfl+NVtS1TJyk6T+C
 Nn7+Hf1MLtKg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="394700370"
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH v24 9/9] x86/vdso: Add ENDBR to __vdso_sgx_enter_enclave
Date:   Thu,  1 Apr 2021 15:14:03 -0700
Message-Id: <20210401221403.32253-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210401221403.32253-1-yu-cheng.yu@intel.com>
References: <20210401221403.32253-1-yu-cheng.yu@intel.com>
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

Add ENDBR to __vdso_sgx_enter_enclave() branch targets.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/entry/vdso/vsgx.S | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/vsgx.S b/arch/x86/entry/vdso/vsgx.S
index 86a0e94f68df..c63eafa54abd 100644
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
+	ENDBR
 	push	%rbp
 	.cfi_adjust_cfa_offset	8
 	.cfi_rel_offset		%rbp, 0
@@ -62,6 +64,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 .Lasync_exit_pointer:
 .Lenclu_eenter_eresume:
 	enclu
+	ENDBR
 
 	/* EEXIT jumps here unless the enclave is doing something fancy. */
 	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
@@ -91,6 +94,7 @@ SYM_FUNC_START(__vdso_sgx_enter_enclave)
 	jmp	.Lout
 
 .Lhandle_exception:
+	ENDBR
 	mov	SGX_ENCLAVE_OFFSET_OF_RUN(%rbp), %rbx
 
 	/* Set the exception info. */
-- 
2.21.0

