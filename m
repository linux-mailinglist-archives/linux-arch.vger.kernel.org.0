Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3012F72D64B
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239263AbjFMAPu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbjFMAPO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:15:14 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E81FE5;
        Mon, 12 Jun 2023 17:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615179; x=1718151179;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nq8FP2aUY00edE8aipvtg7A+Bog2Zlh3+3MlR+vKuX8=;
  b=VUA03PHEsKf7BGSuEYVz5E8l/PobAViMN6h/hju3XYNwYiRTtNZCV5AC
   x3LNNCJ13NUScqLV9UND5F2QFHvBf2/0O77HQrsBq7NF83s1B7jzlviKA
   G7yIGHLE/rXXSvj46HeXcd0JTRv8xmdNR8Rlq3md4QHaj3n0aFnzAzm+Y
   tgBDIPCs45SkOkTewLEkJHWRKWJU1nAY746E6y2ff/x46bFujzHEknfoh
   KdVA4n3jA1bkInpanNHtTZodo6mB1SrouubvfrLEArDgRgSMMpzX7MRAt
   aWp3omlLb1hLmZEf+7Eg7Qu4SfPLZP4rvp0FYOxggwz1OQp8jozOGkCJu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557169"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557169"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671056"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671056"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:26 -0700
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
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        torvalds@linux-foundation.org, broonie@kernel.org
Cc:     rick.p.edgecombe@intel.com, Pengfei Xu <pengfei.xu@intel.com>
Subject: [PATCH v9 22/42] mm: Don't allow write GUPs to shadow stack memory
Date:   Mon, 12 Jun 2023 17:10:48 -0700
Message-Id: <20230613001108.3040476-23-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 Control-flow Enforcement Technology (CET) feature includes a
new type of memory called shadow stack. This shadow stack memory has
some unusual properties, which requires some core mm changes to
function properly.

In userspace, shadow stack memory is writable only in very specific,
controlled ways. However, since userspace can, even in the limited
ways, modify shadow stack contents, the kernel treats it as writable
memory. As a result, without additional work there would remain many
ways for userspace to trigger the kernel to write arbitrary data to
shadow stacks via get_user_pages(, FOLL_WRITE) based operations. To
help userspace protect their shadow stacks, make this a little less
exposed by blocking writable get_user_pages() operations for shadow
stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections. This is required for debugging use
cases.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5383f7282f89..fce35f5d4a4e 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1630,6 +1630,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
 {
 	unsigned long need_pte_bits = _PAGE_PRESENT|_PAGE_USER;
 
+	/*
+	 * Write=0,Dirty=1 PTEs are shadow stack, which the kernel
+	 * shouldn't generally allow access to, but since they
+	 * are already Write=0, the below logic covers both cases.
+	 */
 	if (write)
 		need_pte_bits |= _PAGE_RW;
 
diff --git a/mm/gup.c b/mm/gup.c
index bbe416236593..cc0dd5267509 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -978,7 +978,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
-- 
2.34.1

