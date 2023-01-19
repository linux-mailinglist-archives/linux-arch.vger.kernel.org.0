Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E015E6744B6
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbjASVha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:37:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjASVfb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:35:31 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA74A1024;
        Thu, 19 Jan 2023 13:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163626; x=1705699626;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=Sqmbg6aViWSIuyH7MnUz0YCJC/oOzGtcIb7+8J/qX00=;
  b=lCqPhsz5Ligt4SU1XQzj7I8rtmx+ohVt4v+2Yjeefot2JPgXHGv7447r
   ecS8rKgKl6iQM9rH95Qxn9sWY5fLnOaOc7wC1P7N+ghAIjEpsCCPpWyMZ
   rX+GhueS+wgKabuxRQ0qpkFI0hHowWe8XfMhWD717+OopZTzF8FKa1PsO
   YJuV6bz0BQv+1MndopB2/1EkDKIU00OTPxp48kUcpLz8gUDjJQMC8jw21
   GdeXpI7iej9QBGB7QwxXVbPC61lfc8TEDACLISeYTrHsubc9AWgM99Pe5
   fLQe/7Wpw68nwphVrmYo8jJKhHZgFoFflVYNfU01d4TyInY3s8aQ6h2fj
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119660"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119660"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139099"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139099"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:57 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
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
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 21/39] mm/mmap: Add shadow stack pages to memory accounting
Date:   Thu, 19 Jan 2023 13:22:59 -0800
Message-Id: <20230119212317.8324-22-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Account shadow stack pages to stack memory.

Reviewed-by: Kees Cook <keescook@chromium.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Co-developed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: Kees Cook <keescook@chromium.org>
---

v3:
 - Remove unneeded VM_SHADOW_STACK check in accountable_mapping()
   (Kirill)

v2:
 - Remove is_shadow_stack_mapping() and just change it to directly bitwise
   and VM_SHADOW_STACK.

Yu-cheng v26:
 - Remove redundant #ifdef CONFIG_MMU.

Yu-cheng v25:
 - Remove #ifdef CONFIG_ARCH_HAS_SHADOW_STACK for is_shadow_stack_mapping().

 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 425a9349e610..9f85596cce31 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3290,6 +3290,8 @@ void vm_stat_account(struct mm_struct *mm, vm_flags_t flags, long npages)
 		mm->exec_vm += npages;
 	else if (is_stack_mapping(flags))
 		mm->stack_vm += npages;
+	else if (flags & VM_SHADOW_STACK)
+		mm->stack_vm += npages;
 	else if (is_data_mapping(flags))
 		mm->data_vm += npages;
 }
-- 
2.17.1

