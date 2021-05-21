Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DD138D141
	for <lists+linux-arch@lfdr.de>; Sat, 22 May 2021 00:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbhEUWT1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 May 2021 18:19:27 -0400
Received: from mga05.intel.com ([192.55.52.43]:55706 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230023AbhEUWTI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 May 2021 18:19:08 -0400
IronPort-SDR: 178tWkGR9IsLY52PljQerXKxzg8rkVEX3yGvpB769dNByRz1x/dw5DexGUUJ9V1M9a4U+V/+NV
 wIFfCXZF9EkA==
X-IronPort-AV: E=McAfee;i="6200,9189,9991"; a="287124421"
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="287124421"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:30 -0700
IronPort-SDR: /rk/XekRvxxa6kQ91PownmMdhpdvv8W1JSCZzq/hlvloHpBKbcOJG4SIFGMU+/pnzLEodLA8fn
 lbOPjpk81Mrw==
X-IronPort-AV: E=Sophos;i="5.82,319,1613462400"; 
   d="scan'208";a="441269466"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2021 15:16:30 -0700
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
Subject: [PATCH v27 09/10] x86/vdso/32: Add ENDBR to __kernel_vsyscall entry point
Date:   Fri, 21 May 2021 15:15:30 -0700
Message-Id: <20210521221531.30168-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210521221531.30168-1-yu-cheng.yu@intel.com>
References: <20210521221531.30168-1-yu-cheng.yu@intel.com>
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
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/vdso32/system_call.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/entry/vdso/vdso32/system_call.S b/arch/x86/entry/vdso/vdso32/system_call.S
index 6ddd7a937b3e..d321c2ded33a 100644
--- a/arch/x86/entry/vdso/vdso32/system_call.S
+++ b/arch/x86/entry/vdso/vdso32/system_call.S
@@ -7,6 +7,7 @@
 #include <asm/dwarf2.h>
 #include <asm/cpufeatures.h>
 #include <asm/alternative.h>
+#include <asm/vdso.h>
 
 	.text
 	.globl __kernel_vsyscall
@@ -14,6 +15,7 @@
 	ALIGN
 __kernel_vsyscall:
 	CFI_STARTPROC
+	ENDBR32
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
-- 
2.21.0

