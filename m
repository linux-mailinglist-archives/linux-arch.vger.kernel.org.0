Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C462E749C
	for <lists+linux-arch@lfdr.de>; Tue, 29 Dec 2020 22:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgL2VeO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 29 Dec 2020 16:34:14 -0500
Received: from mga03.intel.com ([134.134.136.65]:11899 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgL2VeE (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 29 Dec 2020 16:34:04 -0500
IronPort-SDR: 6ZnXgGnsBBWYlhdFNDNndu6039k0yGsp0TbrpoyzEX+sKaBOR/yDeidgXInuc2Z+Hr/UO7rhDy
 JyQvHL9OHG0w==
X-IronPort-AV: E=McAfee;i="6000,8403,9849"; a="176640552"
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="176640552"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:32:29 -0800
IronPort-SDR: 5d2LZ44wrauYPc/7nbeP9V0/omdscR0o76Ax4KpW9x+6XUYTyxzfS7JWjV0+dT5EuvfuoyPiX3
 aLdklbGU7s2A==
X-IronPort-AV: E=Sophos;i="5.78,459,1599548400"; 
   d="scan'208";a="376189656"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2020 13:32:29 -0800
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
Subject: [PATCH v17 22/26] binfmt_elf: Define GNU_PROPERTY_X86_FEATURE_1_AND properties
Date:   Tue, 29 Dec 2020 13:30:49 -0800
Message-Id: <20201229213053.16395-23-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201229213053.16395-1-yu-cheng.yu@intel.com>
References: <20201229213053.16395-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

An ELF file's .note.gnu.property indicates architecture features of the
file.  Introduce feature definitions for Shadow Stack and Indirect Branch
Tracking.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 include/uapi/linux/elf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index 30f68b42eeb5..7f0e46780a35 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -455,4 +455,13 @@ typedef struct elf64_note {
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

