Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CEC06744A7
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:36:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjASVgl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:36:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjASVeo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:34:44 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CF5CA3177;
        Thu, 19 Jan 2023 13:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163616; x=1705699616;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=NJhAPcbhUYo6SN1rH0mb7F3rAzE882GPxl5rAvSEEz0=;
  b=Q1kHlcw7UBkpLpksUL1Cmb/+k3cunnk/ojuV6VYfWRVa/sw7WXi75hi2
   0E/S9HmeHUODsoruMi30PA83n5npVPuxc4dGJVYd93kZcPJXb2//ecVgj
   WQOpsyd+jbOayOmxqZoXpzEfMUB5WmNgfR3t6NBrYqlE5/a21qzsC4EqL
   3cgTiF/pQiRm3v5VG4AtabkvduRZPPyvzBPE0VrM2XQbgvqZutVRhu3Qc
   /qtkgOz73Zbi693mINDHsUXTXOJrSYhgetpZ7XbntgOaZ1jM0u7a3WScr
   cHG4iFYaW+sQtZtGvl5V0uaK03dTYgCSdBAtriGATqU57Lbiszj/RwsrP
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119581"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119581"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:54 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139082"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139082"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:23:52 -0800
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
Cc:     rick.p.edgecombe@intel.com, David Hildenbrand <david@redhat.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
Date:   Thu, 19 Jan 2023 13:22:56 -0800
Message-Id: <20230119212317.8324-19-rick.p.edgecombe@intel.com>
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

The x86 Control-flow Enforcement Technology (CET) feature includes a new
type of memory called shadow stack. This shadow stack memory has some
unusual properties, which requires some core mm changes to function
properly.

Since shadow stack memory can be changed from userspace, is both
VM_SHADOW_STACK and VM_WRITE. But it should not be made conventionally
writable (i.e. pte_mkwrite()). So some code that calls pte_mkwrite() needs
to be adjusted.

One such case is when memory is made writable without an actual write
fault. This happens in some mprotect operations, and also prot_numa faults.
In both cases code checks whether it should be made (conventionally)
writable by calling vma_wants_manual_pte_write_upgrade().

One way to fix this would be have code actually check if memory is also
VM_SHADOW_STACK and in that case call pte_mkwrite_shstk(). But since
most memory won't be shadow stack, just have simpler logic and skip this
optimization by changing vma_wants_manual_pte_write_upgrade() to not
return true for VM_SHADOW_STACK_MEMORY. This will simply handle all
cases of this type.

Cc: David Hildenbrand <david@redhat.com>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v5:
 - Update solution after the recent removal of pte_savedwrite()

v4:
 - Add "why" to comments in code (Peterz)

Yu-cheng v25:
 - Move is_shadow_stack_mapping() to a separate line.

Yu-cheng v24:
 - Change arch_shadow_stack_mapping() to is_shadow_stack_mapping().

 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index e15d2fc04007..139a682d243b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2181,7 +2181,7 @@ static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma
 	 */
 	if (vma->vm_flags & VM_SHARED)
 		return vma_wants_writenotify(vma, vma->vm_page_prot);
-	return !!(vma->vm_flags & VM_WRITE);
+	return (vma->vm_flags & VM_WRITE) && !(vma->vm_flags & VM_SHADOW_STACK);
 
 }
 bool can_change_pte_writable(struct vm_area_struct *vma, unsigned long addr,
-- 
2.17.1

