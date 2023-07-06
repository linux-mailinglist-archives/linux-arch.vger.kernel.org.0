Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A962174A7C3
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 01:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjGFXdP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 19:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGFXdO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 19:33:14 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746451BC3;
        Thu,  6 Jul 2023 16:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688686393; x=1720222393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XUkyvmI0jJGp0DdOCiIFtQVqD9lpSuf1e9iWi08ULvo=;
  b=ZoKKqv2MY3ecOmPHtlShuaoSuSE1z+NcRcOfQxCnbn2M/Vy5o4wjl8o+
   vRxL1zsZ/mknO+m781zvnYTJDsYaiH0Fahg7npv5TjqnpSFBHN6xqn+ci
   IBhHrdMb2Gl1E/imdPofSFov4U8WhuJFYKyoG75H5f9w84xO5BCvw8u0Q
   7oDnoU0CakHjui9cA4bYKbBdENp2vUOyDyRSyB9zz9ps7f/c0Kvx+96sS
   hA+OHdGqYGW32s/P+acj24/Tw6IbssZxdO2g2Z8axEoLJfv4qd3dPF9pb
   daHtXdLFrloEpSicFAHzSwsiTLHRntYTRmlMYzgZ3i0dJInxuELZ0bUnK
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="429811673"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="429811673"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:33:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="789741239"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="789741239"
Received: from wangmei-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.212.211.11])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:33:09 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     broonie@kernel.org
Cc:     akpm@linux-foundation.org, andrew.cooper3@citrix.com,
        arnd@arndb.de, bp@alien8.de, bsingharora@gmail.com,
        christina.schimpe@intel.com, corbet@lwn.net,
        dave.hansen@linux.intel.com, david@redhat.com, debug@rivosinc.com,
        dethoma@microsoft.com, eranian@google.com, esyr@redhat.com,
        fweimer@redhat.com, gorcunov@gmail.com, hjl.tools@gmail.com,
        hpa@zytor.com, jamorris@linux.microsoft.com, jannh@google.com,
        john.allen@amd.com, kcc@google.com, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, rdunlap@infradead.org,
        rick.p.edgecombe@intel.com, rppt@kernel.org, szabolcs.nagy@arm.com,
        tglx@linutronix.de, torvalds@linux-foundation.org,
        weijiang.yang@intel.com, willy@infradead.org, x86@kernel.org,
        yu-cheng.yu@intel.com
Subject: [PATCH] x86/shstk: Move arch detail comment out of core mm
Date:   Thu,  6 Jul 2023 16:32:48 -0700
Message-Id: <20230706233248.445713-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ad6df14b-1fbd-4136-abcd-314425c28306@sirena.org.uk>
References: <ad6df14b-1fbd-4136-abcd-314425c28306@sirena.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The comment around VM_SHADOW_STACK in mm.h refers to a lot of x86
specific details that don't belong in a cross arch file. Remove these
out of core mm, and just leave the non-arch details.

Since the comment includes some useful details that would be good to
retain in the source somewhere, put the arch specifics parts in
arch/x86/shstk.c near alloc_shstk(), where memory of this type is
allocated. Include a reference to the existence of the x86 details near
the VM_SHADOW_STACK definition mm.h.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c | 25 +++++++++++++++++++++++++
 include/linux/mm.h      | 32 ++++++--------------------------
 2 files changed, 31 insertions(+), 26 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index b26810c7cd1c..47f5204b0fa9 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -72,6 +72,31 @@ static int create_rstor_token(unsigned long ssp, unsigned long *token_addr)
 	return 0;
 }
 
+/*
+ * VM_SHADOW_STACK will have a guard page. This helps userspace protect
+ * itself from attacks. The reasoning is as follows:
+ *
+ * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
+ * INCSSP instruction can increment the shadow stack pointer. It is the
+ * shadow stack analog of an instruction like:
+ *
+ *   addq $0x80, %rsp
+ *
+ * However, there is one important difference between an ADD on %rsp
+ * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
+ * memory of the first and last elements that were "popped". It can be
+ * thought of as acting like this:
+ *
+ * READ_ONCE(ssp);       // read+discard top element on stack
+ * ssp += nr_to_pop * 8; // move the shadow stack
+ * READ_ONCE(ssp-8);     // read+discard last popped stack element
+ *
+ * The maximum distance INCSSP can move the SSP is 2040 bytes, before
+ * it would read the memory. Therefore a single page gap will be enough
+ * to prevent any operation from shifting the SSP to an adjacent stack,
+ * since it would have to land in the gap at least once, causing a
+ * fault.
+ */
 static unsigned long alloc_shstk(unsigned long addr, unsigned long size,
 				 unsigned long token_offset, bool set_res_tok)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 535c58d3b2e4..b647cf2e94ea 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -343,33 +343,13 @@ extern unsigned int kobjsize(const void *objp);
 
 #ifdef CONFIG_X86_USER_SHADOW_STACK
 /*
- * This flag should not be set with VM_SHARED because of lack of support
- * core mm. It will also get a guard page. This helps userspace protect
- * itself from attacks. The reasoning is as follows:
+ * VM_SHADOW_STACK should not be set with VM_SHARED because of lack of
+ * support core mm.
  *
- * The shadow stack pointer(SSP) is moved by CALL, RET, and INCSSPQ. The
- * INCSSP instruction can increment the shadow stack pointer. It is the
- * shadow stack analog of an instruction like:
- *
- *   addq $0x80, %rsp
- *
- * However, there is one important difference between an ADD on %rsp
- * and INCSSP. In addition to modifying SSP, INCSSP also reads from the
- * memory of the first and last elements that were "popped". It can be
- * thought of as acting like this:
- *
- * READ_ONCE(ssp);       // read+discard top element on stack
- * ssp += nr_to_pop * 8; // move the shadow stack
- * READ_ONCE(ssp-8);     // read+discard last popped stack element
- *
- * The maximum distance INCSSP can move the SSP is 2040 bytes, before
- * it would read the memory. Therefore a single page gap will be enough
- * to prevent any operation from shifting the SSP to an adjacent stack,
- * since it would have to land in the gap at least once, causing a
- * fault.
- *
- * Prevent using INCSSP to move the SSP between shadow stacks by
- * having a PAGE_SIZE guard gap.
+ * These VMAs will get a single end guard page. This helps userspace protect
+ * itself from attacks. A single page is enough for current shadow stack archs
+ * (x86). See the comments near alloc_shstk() in arch/x86/kernel/shstk.c
+ * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
 #else
-- 
2.34.1

