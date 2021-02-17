Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 270A231E269
	for <lists+linux-arch@lfdr.de>; Wed, 17 Feb 2021 23:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhBQWfJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 17 Feb 2021 17:35:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:15553 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234144AbhBQWca (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 17 Feb 2021 17:32:30 -0500
IronPort-SDR: BNaK0ehDTtQDp+2JLJdru5zZazeNwpQdsld/a6/AZ8uy5ySJBnq8WnD75JMWEZ9341/9DR/55m
 EG5urNqKhEyA==
X-IronPort-AV: E=McAfee;i="6000,8403,9898"; a="183409002"
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="183409002"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:31:46 -0800
IronPort-SDR: kw1HrdNyLDd75O4PiZLQx7EPT6vTVbFEPiCxaxLTittvU8btPnqgcVALK/Yaa7aGpKcVLvJ+kk
 iObrai7tz7bg==
X-IronPort-AV: E=Sophos;i="5.81,185,1610438400"; 
   d="scan'208";a="362200458"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2021 14:31:45 -0800
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
Subject: [PATCH v21 1/7] x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
Date:   Wed, 17 Feb 2021 14:31:29 -0800
Message-Id: <20210217223135.16790-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210217223135.16790-1-yu-cheng.yu@intel.com>
References: <20210217223135.16790-1-yu-cheng.yu@intel.com>
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
index cafa4a2c1d2d..5e157031bf82 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1963,6 +1963,7 @@ config X86_CET
 	def_bool n
 	depends on AS_WRUSS
 	depends on ARCH_HAS_SHADOW_STACK
+	depends on $(cc-option,-fcf-protection)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_MAYBE_MKWRITE
 	select ARCH_USE_GNU_PROPERTY
-- 
2.21.0

