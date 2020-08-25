Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16168250D0C
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgHYA36 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:29:58 -0400
Received: from mga17.intel.com ([192.55.52.151]:12299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728312AbgHYA35 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:57 -0400
IronPort-SDR: Q8UYXSmbQF9xREpyFcWjs+DxG95NJj642gvOGPQhalOINdLBJrS2EP4Eu7wJFfkxAZwY/RFNlX
 fnGTLg+dTiIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075325"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075325"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:44 -0700
IronPort-SDR: nqn/oHxYk+W8TwVi7hu91ZrST/KUFbw43UdK/LoFf3WVMGZWQYSt+Akcvc9rTUBtDYR3DR8XX9
 N1d4Oi4cqtng==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474135031"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:43 -0700
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
Subject: [PATCH v11 22/25] binfmt_elf: Define GNU_PROPERTY_X86_FEATURE_1_AND properties
Date:   Mon, 24 Aug 2020 17:25:37 -0700
Message-Id: <20200825002540.3351-23-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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

