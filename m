Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8270B641278
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235086AbiLCAl3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:41:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235167AbiLCAkV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:40:21 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E2F2714D;
        Fri,  2 Dec 2022 16:38:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027885; x=1701563885;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=1B1fGdYaOUBrZLGly7/XqlrrigTtV2P34Ygy1ZAid0o=;
  b=bqCzhTrLzuACW+fDTw40WUtiRqWIcKe1jxjbK2fzdHu7aOzyqvBoUIVD
   UQkMU92E/N3xaky63L4zT+k4pPbqL0MJ1DPIjY5OePhnHac6iYRtbvyzr
   BEai8dkhWPyfaZye8eb5Q7Uj9ccEooMESzVyhPiSB6uuyKlXNihoWoATS
   ifBmVqRTCyCX+FqhPNbhaP344/K1SR3vDcd5AhkOkb2rIhpy0T1/1HW6w
   EeHroZ1BaYZrMyUm/lm+GuYyTRKKK+2TRKrlxmBCqYJMg095tp3wkp4WQ
   5OTcYjelcBnTuObEzpAjHaqNGXNHOI3swaZ9NRqiAfaKp0WTkfb8j07y1
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711220"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:23 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479934"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479934"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:22 -0800
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v4 23/39] mm: Don't allow write GUPs to shadow stack memory
Date:   Fri,  2 Dec 2022 16:35:50 -0800
Message-Id: <20221203003606.6838-24-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
References: <20221203003606.6838-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Shadow stack memory is writable only in very specific, controlled ways.
However, since it is writable, the kernel treats it as such. As a result
there remain many ways for userspace to trigger the kernel to write to
shadow stack's via get_user_pages(, FOLL_WRITE) operations. To make this a
little less exposed, block writable GUPs for shadow stack VMAs.

Still allow FOLL_FORCE to write through shadow stack protections, as it
does for read-only protections.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v3:
 - Add comment in __pte_access_permitted() (Dave)
 - Remove unneeded shadow stack specific check in
   __pte_access_permitted() (Jann)

 arch/x86/include/asm/pgtable.h | 5 +++++
 mm/gup.c                       | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a89dfa9174ae..945d58681a87 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1636,6 +1636,11 @@ static inline bool __pte_access_permitted(unsigned long pteval, bool write)
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
index cdff87343884..75e8d3853ff3 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1062,7 +1062,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		return -EFAULT;
 
 	if (write) {
-		if (!(vm_flags & VM_WRITE)) {
+		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/*
-- 
2.17.1

