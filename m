Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 585AB3F3386
	for <lists+linux-arch@lfdr.de>; Fri, 20 Aug 2021 20:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHTSYY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Aug 2021 14:24:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:48116 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238733AbhHTSYS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Aug 2021 14:24:18 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10082"; a="203964951"
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="203964951"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:08 -0700
X-IronPort-AV: E=Sophos;i="5.84,338,1620716400"; 
   d="scan'208";a="523799165"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2021 11:23:08 -0700
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
Subject: [PATCH v29 05/10] x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
Date:   Fri, 20 Aug 2021 11:22:40 -0700
Message-Id: <20210820182245.1188-6-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210820182245.1188-1-yu-cheng.yu@intel.com>
References: <20210820182245.1188-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates features the file supports.
The property is parsed at loading time and passed to arch_setup_elf_
property().  Update it for Indirect Branch Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---
v27:
- Remove selecting of ARCH_USE_GNU_PROPERTY and ARCH_BINFMT_ELF_STATE,
  since they are already selected by X86_64.
---
 arch/x86/kernel/process_64.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4271963fdd8c..4ab751a5146e 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -884,6 +884,12 @@ int arch_setup_elf_property(struct arch_elf_state *state)
 
 	if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_SHSTK)
 		r = shstk_setup();
+
+	if (r < 0)
+		return r;
+
+	if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_IBT)
+		r = ibt_setup();
 #endif
 
 	return r;
-- 
2.21.0

