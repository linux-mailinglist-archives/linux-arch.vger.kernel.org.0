Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC3CB27051D
	for <lists+linux-arch@lfdr.de>; Fri, 18 Sep 2020 21:23:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgIRTXJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 18 Sep 2020 15:23:09 -0400
Received: from mga18.intel.com ([134.134.136.126]:41779 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbgIRTWw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 18 Sep 2020 15:22:52 -0400
IronPort-SDR: 1OzwdQn+r74tfsvbVtwhIFr6gNX9o5lmT2m9YUI11Xff1IWflLPDwkhh4G2eYFvULwJwpPWrlW
 O46eMP++UzLA==
X-IronPort-AV: E=McAfee;i="6000,8403,9748"; a="147766253"
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="147766253"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:24 -0700
IronPort-SDR: UJxugeNmZU2ORv55HZu830MYsPKiee3ITb2kM28K6S93xwO2uDc2hgYDDYe0PHEcWUQsY32u0a
 upQEUa3oI1ig==
X-IronPort-AV: E=Sophos;i="5.77,274,1596524400"; 
   d="scan'208";a="484331901"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2020 12:22:24 -0700
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
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v12 22/26] binfmt_elf: Define GNU_PROPERTY_X86_FEATURE_1_AND properties
Date:   Fri, 18 Sep 2020 12:21:20 -0700
Message-Id: <20200918192125.25473-23-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200918192125.25473-1-yu-cheng.yu@intel.com>
References: <20200918192125.25473-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates architecture features of the
file.. Introduce feature definitions for Shadow Stack and Indirect Branch
Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 include/uapi/linux/elf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 22220945a5fd..ca5875f384f6 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -454,4 +454,13 @@ typedef struct elf64_note {
 /* Bits for GNU_PROPERTY_AARCH64_FEATURE_1_BTI */
 #define GNU_PROPERTY_AARCH64_FEATURE_1_BTI	(1U << 0)
 
+/* .note.gnu.property types for x86: */
+#define GNU_PROPERTY_X86_FEATURE_1_AND		0xc0000002
+
+/* Bits for GNU_PROPERTY_X86_FEATURE_1_AND */
+#define GNU_PROPERTY_X86_FEATURE_1_IBT		0x00000001
+#define GNU_PROPERTY_X86_FEATURE_1_SHSTK	0x00000002
+#define GNU_PROPERTY_X86_FEATURE_1_INVAL ~(GNU_PROPERTY_X86_FEATURE_1_IBT | \
+					    GNU_PROPERTY_X86_FEATURE_1_SHSTK)
+
 #endif /* _UAPI_LINUX_ELF_H */
-- 
2.21.0

