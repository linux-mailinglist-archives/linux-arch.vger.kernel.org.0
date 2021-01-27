Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE1306656
	for <lists+linux-arch@lfdr.de>; Wed, 27 Jan 2021 22:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235048AbhA0Vfg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 27 Jan 2021 16:35:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:11286 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235502AbhA0Vdg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 27 Jan 2021 16:33:36 -0500
IronPort-SDR: 1C6kwAypKC3rogyywoycp5gryo9ja19C0/dn2xhAm6e14c6bbnuAbWu3w8I8sY06yKrA1X2T7b
 bMrhdMzfD3Cg==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="159309026"
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="159309026"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:30:38 -0800
IronPort-SDR: IySvv2pF1d3N/60YOMj+QWV+PWVEqCjOBniHDo0zq7hN7/LXpUYviorx1EBF2A3wn4r+l9BG4y
 8m7MDiTqSJvQ==
X-IronPort-AV: E=Sophos;i="5.79,380,1602572400"; 
   d="scan'208";a="362581384"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2021 13:30:38 -0800
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
Subject: [PATCH v18 7/7] x86/vdso: Insert endbr32/endbr64 to vDSO
Date:   Wed, 27 Jan 2021 13:30:28 -0800
Message-Id: <20210127213028.11362-8-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210127213028.11362-1-yu-cheng.yu@intel.com>
References: <20210127213028.11362-1-yu-cheng.yu@intel.com>
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
index 02e3e42f380b..ff7b56feb5c3 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -93,6 +93,10 @@ endif
 
 $(vobjs): KBUILD_CFLAGS := $(filter-out $(GCC_PLUGINS_CFLAGS) $(RETPOLINE_CFLAGS),$(KBUILD_CFLAGS)) $(CFL)
 
+ifdef CONFIG_X86_CET
+$(vobjs) $(vobjs32): KBUILD_CFLAGS += -fcf-protection=branch
+endif
+
 #
 # vDSO code runs in userspace and -pg doesn't help with profiling anyway.
 #
-- 
2.21.0

