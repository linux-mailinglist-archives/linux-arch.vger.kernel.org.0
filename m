Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA431316DFE
	for <lists+linux-arch@lfdr.de>; Wed, 10 Feb 2021 19:09:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhBJSIR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Feb 2021 13:08:17 -0500
Received: from mga07.intel.com ([134.134.136.100]:19832 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233914AbhBJSFi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Feb 2021 13:05:38 -0500
IronPort-SDR: 3rhcLYrP89zmDV16v8lnuGi1VA62Hk5+gmHw4Zse934HOUfp4vpT0b76OeOUSygqOvZmfSO+zw
 wezAXrGaz10Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9891"; a="246189802"
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="246189802"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:57 -0800
IronPort-SDR: DZIyilyq6rAx+vBuMXR52Ljop2B68etNnmpU4O2n2DF5wh4aWDx9zN3kX28Ey7PzADJAvZJRUI
 woeiMmefRb5Q==
X-IronPort-AV: E=Sophos;i="5.81,168,1610438400"; 
   d="scan'208";a="380239198"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2021 10:02:56 -0800
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
        Pengfei Xu <pengfei.xu@intel.com>, <haitao.huang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v20 1/7] x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
Date:   Wed, 10 Feb 2021 10:02:39 -0800
Message-Id: <20210210180245.13770-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210210180245.13770-1-yu-cheng.yu@intel.com>
References: <20210210180245.13770-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Indirect branch tracking is a hardware security feature that verifies near
indirect call/jump instructions arrive at intended targets, which are
labeled by the compiler with ENDBR opcodes.  If such instructions reach
unlabeled locations, the processor raises control-protection faults.

Check the compiler is up-to-date at config time.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 816830e3f062..f462ef9d3305 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1964,6 +1964,7 @@ config X86_CET
 	depends on X86_64
 	depends on AS_WRUSS
 	depends on ARCH_HAS_SHADOW_STACK
+	depends on $(cc-option,-fcf-protection)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_MAYBE_MKWRITE
 	select ARCH_USE_GNU_PROPERTY
-- 
2.21.0

