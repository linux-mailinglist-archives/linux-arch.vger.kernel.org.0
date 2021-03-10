Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 830AB334B09
	for <lists+linux-arch@lfdr.de>; Wed, 10 Mar 2021 23:11:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233866AbhCJWF4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 10 Mar 2021 17:05:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:5154 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233060AbhCJWFv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 10 Mar 2021 17:05:51 -0500
IronPort-SDR: pSd4OTLIBpptGlLiAlRgBQdI/h3giwlGlQH/bmg4X74GSGcM9Dy6wlg61q83xli9E1qgcHnh6i
 lAtI1eNW344w==
X-IronPort-AV: E=McAfee;i="6000,8403,9919"; a="186193983"
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="186193983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:05:46 -0800
IronPort-SDR: LXUp4QfE9Kidn1aC2mHfvCiQv5tVthY+PH0KW5gzvJzIo49EZ1p+ImjfMfkklM4kh4oOiPFPee
 pvf1EVz/qskw==
X-IronPort-AV: E=Sophos;i="5.81,238,1610438400"; 
   d="scan'208";a="410368508"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2021 14:05:46 -0800
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
Subject: [PATCH v22 4/8] x86/cet/ibt: Update ELF header parsing for Indirect Branch Tracking
Date:   Wed, 10 Mar 2021 14:05:15 -0800
Message-Id: <20210310220519.16811-5-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20210310220519.16811-1-yu-cheng.yu@intel.com>
References: <20210310220519.16811-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates features the file supports.
The property is parsed at loading time and passed to arch_setup_elf_
property().  Update it for Indirect Branch Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/kernel/process_64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index cda830b0f7ee..11497689a841 100644
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

