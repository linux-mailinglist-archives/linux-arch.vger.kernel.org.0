Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A1F361541
	for <lists+linux-arch@lfdr.de>; Fri, 16 Apr 2021 00:20:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237386AbhDOWUA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Apr 2021 18:20:00 -0400
Received: from mga07.intel.com ([134.134.136.100]:58105 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237465AbhDOWTV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 15 Apr 2021 18:19:21 -0400
IronPort-SDR: Ij9Wqj5WqliQrmkyvRbsLsscbjb4DJdieaKZHz9qIhrM1KnHHA5byZK29uczRVqliiKN7aIFOs
 X6tsSVML1HWw==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258913090"
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="258913090"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:50 -0700
IronPort-SDR: 3Dy8CfCb3Af3VPSu4C8zupswQPc5tBfhVEegbrJ3OzPYmVWUKAckWO+3E9rXuv2A8chZy73pyJ
 lV7S2lARV/lw==
X-IronPort-AV: E=Sophos;i="5.82,225,1613462400"; 
   d="scan'208";a="399720991"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 15:17:49 -0700
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
Subject: [PATCH v25 8/9] x86/vdso/32: Add ENDBR to __kernel_vsyscall entry point
Date:   Thu, 15 Apr 2021 15:17:33 -0700
Message-Id: <20210415221734.32628-9-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210415221734.32628-1-yu-cheng.yu@intel.com>
References: <20210415221734.32628-1-yu-cheng.yu@intel.com>
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
index de1fff7188aa..7793dc221726 100644
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
+	ENDBR32
 	/*
 	 * Reshuffle regs so that all of any of the entry instructions
 	 * will preserve enough state.
-- 
2.21.0

