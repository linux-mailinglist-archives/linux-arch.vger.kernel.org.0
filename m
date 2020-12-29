Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 740FC2E74C8
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 22:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727288AbgL2VfT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 16:35:19 -0500
Received: from mga09.intel.com ([134.134.136.24]:31879 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727275AbgL2VfS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 16:35:18 -0500
IronPort-SDR: oGO0OZ+j9In+cSIsNU6UlRIThO/QD2iUaHIQwUDtI14volZmV2hkgjfCNat4/sYlPlmXxt76gH
 iV7RKFln5cCA==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176695629"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="176695629"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:34:21 -0800
IronPort-SDR: gYCoL2EYiljV1FjHciFY+X8u4oxLg/qUpU6NMkyOsnaYcnFeaXT4QtIZNgBcoF3p+iJ09xR5pw
 SxwmZ2zgjNCQ==
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="376190131"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:34:20 -0800
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
Subject: [PATCH v17 4/7] x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
Date:   Tue, 29 Dec 2020 13:33:47 -0800
Message-Id: <20201229213350.17010-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201229213350.17010-1-yu-cheng.yu@intel.com>
References: <20201229213350.17010-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates features the file supports.
The property is parsed at loading time and passed to arch_setup_elf_
property().  Update it for Indirect Branch Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 arch/x86/kernel/process_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2e8decf79f8c..c646221fd55b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -864,6 +864,14 @@ int arch_setup_elf_property(struct arch_elf_state *state)
 			r = cet_setup_shstk();
 	}
 
+	if (r < 0)
+		return r;
+
+	if (static_cpu_has(X86_FEATURE_IBT)) {
+		if (state->gnu_property & GNU_PROPERTY_X86_FEATURE_1_IBT)
+			r = cet_setup_ibt();
+	}
+
 	return r;
 }
 #endif
-- 
2.21.0

