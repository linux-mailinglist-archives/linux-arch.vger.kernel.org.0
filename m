Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2390036CD26
	for <lists+linux-arch@lfdr.de>; Tue, 27 Apr 2021 22:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239083AbhD0UtD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 27 Apr 2021 16:49:03 -0400
Received: from mga09.intel.com ([134.134.136.24]:56328 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238822AbhD0Usy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 27 Apr 2021 16:48:54 -0400
IronPort-SDR: bsNBoN7tvKplVHW0qolX4Y7t0C/9eAqA/nYPDlO9FDcZTXSqXk9aL2CRop6Uneu/bbcpRjqwda
 jhqYfeXCsbFw==
X-IronPort-AV: E=McAfee;i="6200,9189,9967"; a="196699393"
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="196699393"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2021 13:47:48 -0700
IronPort-SDR: YZTpyRz72PGCwgLwYeiqOXflRhnFSy5K/ZvH7jx+osAG/5rZX2MaO78gXUKYCIkkgLkIWRWtk1
 VU4pI0QeRxMA==
X-IronPort-AV: E=Sophos;i="5.82,255,1613462400"; 
   d="scan'208";a="457835092"
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v26 6/9] x86/vdso: Insert endbr32/endbr64 to vDSO
Date:   Tue, 27 Apr 2021 13:47:17 -0700
Message-Id: <20210427204720.25007-7-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210427204720.25007-1-yu-cheng.yu@intel.com>
References: <20210427204720.25007-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

When Indirect Branch Tracking (IBT) is enabled, vDSO functions may be
called indirectly, and must have ENDBR32 or ENDBR64 as the first
instruction.  The compiler must support -fcf-protection=branch so that it
can be used to compile vDSO.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
---
v24:
- Replace CONFIG_X86_CET with CONFIG_X86_IBT to reflect splitting of shadow
  stack and ibt.

 arch/x86/entry/vdso/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 05c4abc2fdfd..a773a5f03b63 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -93,6 +93,10 @@ endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(CC_FLAGS_LTO) $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
+ifdef CONFIG_X86_IBT
+$(vobjs) $(vobjs32): KBUILD_CFLAGS += -fcf-protection=branch
+endif
+
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-- 
2.21.0

