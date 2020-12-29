Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3ED2E74BB
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 22:38:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgL2VfE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 16:35:04 -0500
Received: from mga09.intel.com ([134.134.136.24]:31873 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726168AbgL2VfA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 16:35:00 -0500
IronPort-SDR: q1VtnvrXhpKXubld8n35nMknYJf5iXez6WoixVWCEjrapC+tF8iflEYTKfGcDL0iIyG1df3tw4
 8vh/Ickk5shQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176695621"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="176695621"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:34:19 -0800
IronPort-SDR: xKduQI6vS/Ne/1fhpLN/O3KhP08lmGBsDJGR5yQWcmMKkMqp9M7kEPkdkxQvNVOVhKc0RqffPR
 qHKPsf+vGvsg==
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="376190118"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:34:18 -0800
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
Subject: [PATCH v17 1/7] x86/cet/ibt: Update Kconfig for user-mode Indirect Branch Tracking
Date:   Tue, 29 Dec 2020 13:33:44 -0800
Message-Id: <20201229213350.17010-2-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201229213350.17010-1-yu-cheng.yu@intel.com>
References: <20201229213350.17010-1-yu-cheng.yu@intel.com>
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
---
 arch/x86/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b26c79c87558..d19f8aa381db 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1961,6 +1961,7 @@ config X86_CET_USER
 	def_bool n
 	depends on CPU_SUP_INTEL && X86_64
 	depends on AS_WRUSS
+	depends on $(cc-option,-fcf-protection)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_SHADOW_STACK
 	select ARCH_MAYBE_MKWRITE
-- 
2.21.0

