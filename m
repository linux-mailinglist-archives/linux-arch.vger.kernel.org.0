Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A25D3F3394
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 20:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239336AbhHTSYn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 14:24:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:48046 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238756AbhHTSYX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Aug 2021 14:24:23 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203964960"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203964960"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:09 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="523799174"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:09 -0700
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
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v29 07/10] x86/vdso: Insert endbr32/endbr64 to vDSO
Date:   Fri, 20 Aug 2021 11:22:42 -0700
Message-Id: <20210820182245.1188-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820182245.1188-1-yu-cheng.yu@intel.com>
References: <20210820182245.1188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: "H.J. Lu" <hjl.tools@gmail.com>

When Indirect Branch Tracking (IBT) is enabled, vDSO entry points need
ENDBR32/ENDBR64 as first instructions.  Kconfig X86_IBT verifies compiler's
-fcf-protection support.  Update vDso Makefile to enable it.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
---
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

