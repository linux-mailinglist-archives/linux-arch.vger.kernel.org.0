Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6D4B37DFA
	for <lists+linux-arch@lfdr.de>; Thu,  6 Jun 2019 22:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbfFFUPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jun 2019 16:15:21 -0400
Received: from mga17.intel.com ([192.55.52.151]:47825 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729089AbfFFUPU (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 6 Jun 2019 16:15:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Jun 2019 13:15:20 -0700
X-ExtLoop1: 1
Received: from yyu32-desk1.sc.intel.com ([143.183.136.147])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2019 13:15:18 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@amacapital.net>,
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
        Dave Martin <Dave.Martin@arm.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v7 09/27] mm/mmap: Prevent Shadow Stack VMA merges
Date:   Thu,  6 Jun 2019 13:06:28 -0700
Message-Id: <20190606200646.3951-10-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190606200646.3951-1-yu-cheng.yu@intel.com>
References: <20190606200646.3951-1-yu-cheng.yu@intel.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

To prevent function call/return spills into the next shadow stack
area, do not merge shadow stack areas.

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
---
 mm/mmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 7e8c3e8ae75f..b1a921c0de63 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1149,6 +1149,12 @@ struct vm_area_struct *vma_merge(struct mm_struct *mm,
 	if (vm_flags & VM_SPECIAL)
 		return NULL;
 
+	/*
+	 * Do not merge shadow stack areas.
+	 */
+	if (vm_flags & VM_SHSTK)
+		return NULL;
+
 	if (prev)
 		next = prev->vm_next;
 	else
-- 
2.17.1

