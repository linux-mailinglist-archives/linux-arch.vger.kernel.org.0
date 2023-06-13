Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C753D72D614
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 02:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239504AbjFMASA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 12 Jun 2023 20:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbjFMAQz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 12 Jun 2023 20:16:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C39530F1;
        Mon, 12 Jun 2023 17:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686615230; x=1718151230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7gc3JiJMbmruUv2dTeFaPrm+ED2TBUgFQFH5yJf4mA=;
  b=VtwaUGGb52YlAWh8RBwn4COZxQR9V4cvBL0nuOeTgM0SrP74fEC6EW3Y
   NMK+5Qm3Ie0kdtQz8rzORUZQEPQXjzP03L6kIiTbi4f+wpmn/eKJV2K2e
   HGEXyqIURRLcS9CkhV4hm/GPqZP1HmTxQtBtuGfV4eVKPx+PWRefSxjHp
   7doUuumQApGo+zlwyBonyBy84tDUw94TtCKjaqAcl16Yrqws6NcsEy9zs
   +9yeMQNhUNF/KTb8sZwIiI5gZSVKcqGH/dnWNt4xIXR3Dn/aok2hkOBQ0
   JbbSrEAv+3B234bj4Q6pelx8q2oHc4lVfEmdCQmNmeCJFvUY9rf/Y5PtB
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="361557436"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="361557436"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="835671121"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; 
   d="scan'208";a="835671121"
Received: from almeisch-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.209.42.242])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2023 17:12:36 -0700
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
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v9 33/42] x86/shstk: Check that signal frame is shadow stack mem
Date:   Mon, 12 Jun 2023 17:10:59 -0700
Message-Id: <20230613001108.3040476-34-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The shadow stack signal frame is read by the kernel on sigreturn. It
relies on shadow stack memory protections to prevent forgeries of this
signal frame (which included the pre-signal SSP). This behavior helps
userspace protect itself. However, using the INCSSP instruction userspace
can adjust the SSP to 8 bytes beyond the end of a shadow stack. INCSSP
performs shadow stack reads to make sure it doesn’t increment off of the
shadow stack, but on the end position it actually reads 8 bytes below the
new SSP.

For the shadow stack HW operations, this situation (INCSSP off the end
of a shadow stack by 8 bytes) would be fine. If the a RET is executed, the
push to the shadow stack would fail to write to the shadow stack. If a
CALL is executed, the SSP will be incremented back onto the stack and the
return address will be written successfully to the very end. That is
expected behavior around shadow stack underflow.

However, the kernel doesn’t have a way to read shadow stack memory using
shadow stack accesses. WRUSS can write to shadow stack memory with a
shadow stack access which ensures the access is to shadow stack memory.
But unfortunately for this case, there is no equivalent instruction for
shadow stack reads. So when reading the shadow stack signal frames, the
kernel currently assumes the SSP is pointing to the shadow stack and uses
a normal read.

The SSP pointing to shadow stack memory will be true in most cases, but as
described above, in can be untrue by 8 bytes. So lookup the VMA of the
shadow stack sigframe being read to verify it is shadow stack.

Since the SSP can only be beyond the shadow stack by 8 bytes, and
shadow stack memory is page aligned, this check only needs to be done
when this type of relative position to a page boundary is encountered.
So skip the extra work otherwise.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
v9:
 - New patch
---
 arch/x86/kernel/shstk.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index a8705f7d966c..50733a510446 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -249,15 +249,38 @@ static int shstk_push_sigframe(unsigned long *ssp)
 
 static int shstk_pop_sigframe(unsigned long *ssp)
 {
+	struct vm_area_struct *vma;
 	unsigned long token_addr;
-	int err;
+	bool need_to_check_vma;
+	int err = 1;
 
+	/*
+	 * It is possible for the SSP to be off the end of a shadow stack by 4
+	 * or 8 bytes. If the shadow stack is at the start of a page or 4 bytes
+	 * before it, it might be this case, so check that the address being
+	 * read is actually shadow stack.
+	 */
 	if (!IS_ALIGNED(*ssp, 8))
 		return -EINVAL;
 
+	need_to_check_vma = PAGE_ALIGN(*ssp) == *ssp;
+
+	if (need_to_check_vma)
+		mmap_read_lock_killable(current->mm);
+
 	err = get_shstk_data(&token_addr, (unsigned long __user *)*ssp);
 	if (unlikely(err))
-		return err;
+		goto out_err;
+
+	if (need_to_check_vma) {
+		vma = find_vma(current->mm, *ssp);
+		if (!vma || !(vma->vm_flags & VM_SHADOW_STACK)) {
+			err = -EFAULT;
+			goto out_err;
+		}
+
+		mmap_read_unlock(current->mm);
+	}
 
 	/* Restore SSP aligned? */
 	if (unlikely(!IS_ALIGNED(token_addr, 8)))
@@ -270,6 +293,10 @@ static int shstk_pop_sigframe(unsigned long *ssp)
 	*ssp = token_addr;
 
 	return 0;
+out_err:
+	if (need_to_check_vma)
+		mmap_read_unlock(current->mm);
+	return err;
 }
 
 int setup_signal_shadow_stack(struct ksignal *ksig)
-- 
2.34.1

