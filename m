Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F6228BCD5
	for <lists+linux-arch@lfdr.de>; Mon, 12 Oct 2020 17:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390394AbgJLPqH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Oct 2020 11:46:07 -0400
Received: from mga07.intel.com ([134.134.136.100]:28367 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390391AbgJLPpz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 12 Oct 2020 11:45:55 -0400
IronPort-SDR: Tt3zefFKzByUYb0rQwEpbeh/U/wFrhZuiONnQR3pquxOsEdWUaHPjLEiTBwpNnYSRfj0oI2yqz
 YT8ReG1Zz2Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9772"; a="229939284"
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="229939284"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:54 -0700
IronPort-SDR: uktNiKl6OrGraGtBexLD49EBKoSk4PWqNdqvRfE9JUhTzhcs8JxM9dleflCvMSf5Pd2el9vp80
 gvY7DK0IsBSA==
X-IronPort-AV: E=Sophos;i="5.77,367,1596524400"; 
   d="scan'208";a="530012655"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2020 08:45:54 -0700
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
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v14 7/7] x86/vdso: Insert endbr32/endbr64 to vDSO
Date:   Mon, 12 Oct 2020 08:45:30 -0700
Message-Id: <20201012154530.28382-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201012154530.28382-1-yu-cheng.yu@intel.com>
References: <20201012154530.28382-1-yu-cheng.yu@intel.com>
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
Acked-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/vdso/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215376d975a2..1f1b6893068a 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -94,6 +94,10 @@ endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
+ifdef CONFIG_X86_BRANCH_TRACKING_USER
+$(vobjs) $(vobjs32): KBUILD_CFLAGS += -fcf-protection=branch
+endif
+
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-- 
2.21.0

