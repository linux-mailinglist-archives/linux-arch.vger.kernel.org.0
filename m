Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CBC6744C9
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jan 2023 22:38:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjASViz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 19 Jan 2023 16:38:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbjASVh1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 19 Jan 2023 16:37:27 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BC2DB747;
        Thu, 19 Jan 2023 13:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674163657; x=1705699657;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=DRhmUKmYGXqIeL9sLHmMRoFoAPvudeDqkB4y2AZ6uIw=;
  b=RdZYkr2n5BxVtAFGqpX+mnPbHIq+wZyBdpb81fmD1NWsbN63coKldBOF
   eqwEuC7Mf6jq79i1Tx5zn1Zp/2mwalAcbIctODvfk52hwlPzvOodmgFlo
   clKEJsDdqRZCKN98AdMBFhGH/8GdTPgMtb6FroITwpP1xkQ3jXjYFRsmT
   e3A0o/wtL95B8TnvajQpTwGNp2aZ7XnktsfJOs9u80FZd+jptra+CqHSs
   fJMGuy+EHcadOotvygoCeASjQCk8fhm7pbrfVR9UpgepLrT6nvzhGtN4s
   V/rnUYAUvNqbzuzgFbXZ1l2day8LUv/VvBXxgqaEIPdgPe2fVDxurZIrh
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="323119743"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="323119743"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:03 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="989139117"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="989139117"
Received: from hossain3-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.252.128.187])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 13:24:01 -0800
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
Subject: [PATCH v5 24/39] x86/mm: Introduce MAP_ABOVE4G
Date:   Thu, 19 Jan 2023 13:23:02 -0800
Message-Id: <20230119212317.8324-25-rick.p.edgecombe@intel.com>
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
unusual properties, which require some core mm changes to function
properly.

One of the properties is that the shadow stack pointer (SSP), which is a
CPU register that points to the shadow stack like the stack pointer points
to the stack, can't be pointing outside of the 32 bit address space when
the CPU is executing in 32 bit mode. It is desirable to prevent executing
in 32 bit mode when shadow stack is enabled because the kernel can't easily
support 32 bit signals.

On x86 it is possible to transition to 32 bit mode without any special
interaction with the kernel, by doing a "far call" to a 32 bit segment.
So the shadow stack implementation can use this address space behavior
as a feature, by enforcing that shadow stack memory is always crated
outside of the 32 bit address space. This way userspace will trigger a
general protection fault which will in turn trigger a segfault if it
tries to transition to 32 bit mode with shadow stack enabled.

This provides a clean error generating border for the user if they try
attempt to do 32 bit mode shadow stack, rather than leave the kernel in a
half working state for userspace to be surprised by.

So to allow future shadow stack enabling patches to map shadow stacks
out of the 32 bit address space, introduce MAP_ABOVE4G. The behavior
is pretty much like MAP_32BIT, except that it has the opposite address
range. The are a few differences though.

If both MAP_32BIT and MAP_ABOVE4G are provided, the kernel will use the
MAP_ABOVE4G behavior. Like MAP_32BIT, MAP_ABOVE4G is ignored in a 32 bit
syscall.

Since the default search behavior is top down, the normal kaslr base can
be used for MAP_ABOVE4G. This is unlike MAP_32BIT which has to add it's
own randomization in the bottom up case.

For MAP_32BIT, only the bottom up search path is used. For MAP_ABOVE4G
both are potentially valid, so both are used. In the bottomup search
path, the default behavior is already consistent with MAP_ABOVE4G since
mmap base should be above 4GB.

Without MAP_ABOVE4G, the shadow stack will already normally be above 4GB.
So without introducing MAP_ABOVE4G, trying to transition to 32 bit mode
with shadow stack enabled would usually segfault anyway. This is already
pretty decent guard rails. But the addition of MAP_ABOVE4G is some small
complexity spent to make it make it more complete.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v5:
 - New patch

 arch/x86/include/uapi/asm/mman.h | 1 +
 arch/x86/kernel/sys_x86_64.c     | 6 +++++-
 include/linux/mman.h             | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/mman.h b/arch/x86/include/uapi/asm/mman.h
index 775dbd3aff73..5a0256e73f1e 100644
--- a/arch/x86/include/uapi/asm/mman.h
+++ b/arch/x86/include/uapi/asm/mman.h
@@ -3,6 +3,7 @@
 #define _ASM_X86_MMAN_H
 
 #define MAP_32BIT	0x40		/* only give out 32bit addresses */
+#define MAP_ABOVE4G	0x80		/* only map above 4GB */
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 #define arch_calc_vm_prot_bits(prot, key) (		\
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 8cc653ffdccd..06378b5682c1 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -193,7 +193,11 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
-	info.low_limit = PAGE_SIZE;
+	if (!in_32bit_syscall() && (flags & MAP_ABOVE4G))
+		info.low_limit = 0x100000000;
+	else
+		info.low_limit = PAGE_SIZE;
+
 	info.high_limit = get_mmap_base(0);
 
 	/*
diff --git a/include/linux/mman.h b/include/linux/mman.h
index 58b3abd457a3..32156daa985a 100644
--- a/include/linux/mman.h
+++ b/include/linux/mman.h
@@ -15,6 +15,9 @@
 #ifndef MAP_32BIT
 #define MAP_32BIT 0
 #endif
+#ifndef MAP_ABOVE4G
+#define MAP_ABOVE4G 0
+#endif
 #ifndef MAP_HUGE_2MB
 #define MAP_HUGE_2MB 0
 #endif
@@ -50,6 +53,7 @@
 		| MAP_STACK \
 		| MAP_HUGETLB \
 		| MAP_32BIT \
+		| MAP_ABOVE4G \
 		| MAP_HUGE_2MB \
 		| MAP_HUGE_1GB)
 
-- 
2.17.1

