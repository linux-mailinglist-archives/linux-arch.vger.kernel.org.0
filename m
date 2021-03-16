Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEBF33D71B
	for <lists+linux-arch@lfdr.de>; Tue, 16 Mar 2021 16:18:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbhCPPRs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Mar 2021 11:17:48 -0400
Received: from mga05.intel.com ([192.55.52.43]:18968 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229540AbhCPPRK (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Mar 2021 11:17:10 -0400
IronPort-SDR: lcz7r8/J+0NxJPgP4ojcbf8kjVvJ7OEGR9llYSLPfOTDsygahXYa3Ajt/MYdzsD/xI9Iq8ILe0
 bl76VmOWnxgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9924"; a="274320148"
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="274320148"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:26 -0700
IronPort-SDR: uMY687gh99pXLo1Mj6EVVgzk43L0VwcgKUJ5TPuqIglPMML/cAUIRf6pVMlQZgoJBr+VqDdBVv
 X3GUfHsh65fg==
X-IronPort-AV: E=Sophos;i="5.81,251,1610438400"; 
   d="scan'208";a="449748970"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 08:13:26 -0700
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
Subject: [PATCH v23 1/9] x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
Date:   Tue, 16 Mar 2021 08:13:11 -0700
Message-Id: <20210316151320.6123-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210316151320.6123-1-yu-cheng.yu@intel.com>
References: <20210316151320.6123-1-yu-cheng.yu@intel.com>
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
index 2c93178262f5..96000ed48469 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1953,6 +1953,7 @@ config X86_CET
 	def_bool n
 	depends on AS_WRUSS
 	depends on ARCH_HAS_SHADOW_STACK
+	depends on $(cc-option,-fcf-protection)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_MAYBE_MKWRITE
 	select ARCH_USE_GNU_PROPERTY
-- 
2.21.0

