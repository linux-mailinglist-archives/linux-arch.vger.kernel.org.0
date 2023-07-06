Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89BE74A7D9
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jul 2023 01:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231868AbjGFXjJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Jul 2023 19:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGFXjI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Jul 2023 19:39:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295A41BE1;
        Thu,  6 Jul 2023 16:39:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688686748; x=1720222748;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AWBI/d5dHbzI1rw676ZmAwDSgJ5kC4AMyKlnIBoe408=;
  b=S4yJlmH8zryaq1BNZ0y8/HcrdL6l99sFLev04ZUUQvp6LaNn/PHFXPjq
   WB2hqH6ysapmY0LOIzH0YfxTOcjqRHinKmB/EOE180/dn2H7ILGtRjCtF
   j1eOMAtpkdnhAQDt/05ckl92LIV+IIE/W32hcosQodb5DDXjqBbeL3tTb
   LiGV0NNLg2qr4aPe3iz/cTOSpKwqKt6jh05sbHCp7ezN8tLytJLnaUnJB
   fU0JXJwx4HgM2UWnilGkiz5/viRMwwr1YYRvHAK0OYyUntSyaDJZf5fwJ
   Thp/L9H9SXKEnulpfHZU8WlKSp+Q7PENVaqKzu7fiX0sjXy4QNceyz3vh
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="450110552"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="450110552"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:39:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10763"; a="713766518"
X-IronPort-AV: E=Sophos;i="6.01,187,1684825200"; 
   d="scan'208";a="713766518"
Received: from wangmei-mobl.amr.corp.intel.com (HELO rpedgeco-desk4.amr.corp.intel.com) ([10.212.211.11])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2023 16:39:06 -0700
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     rick.p.edgecombe@intel.com
Cc:     akpm@linux-foundation.org, andrew.cooper3@citrix.com,
        arnd@arndb.de, bp@alien8.de, broonie@kernel.org,
        bsingharora@gmail.com, christina.schimpe@intel.com, corbet@lwn.net,
        dave.hansen@intel.com, dave.hansen@linux.intel.com,
        david@redhat.com, debug@rivosinc.com, dethoma@microsoft.com,
        eranian@google.com, esyr@redhat.com, fweimer@redhat.com,
        gorcunov@gmail.com, hjl.tools@gmail.com, hpa@zytor.com,
        jamorris@linux.microsoft.com, jannh@google.com, john.allen@amd.com,
        kcc@google.com, keescook@chromium.org,
        kirill.shutemov@linux.intel.com, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        mike.kravetz@oracle.com, mingo@redhat.com, nadav.amit@gmail.com,
        oleg@redhat.com, pavel@ucw.cz, pengfei.xu@intel.com,
        peterz@infradead.org, rdunlap@infradead.org, rppt@kernel.org,
        szabolcs.nagy@arm.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, weijiang.yang@intel.com,
        x86@kernel.org, yu-cheng.yu@intel.com
Subject: [PATCH] x86/shstk: Don't retry vm_munmap() on -EINTR
Date:   Thu,  6 Jul 2023 16:38:58 -0700
Message-Id: <20230706233858.446232-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6a2309340a17070fd39a1b049ce71188bfb5eba7.camel@intel.com>
References: <6a2309340a17070fd39a1b049ce71188bfb5eba7.camel@intel.com>
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

The existing comment around handling vm_munmap() failure when freeing a
shadow stack is wrong. It asserts that vm_munmap() returns -EINTR when
the mmap lock is only being held for a short time, and so the caller
should retry. Based on this wrong understanding, unmap_shadow_stack() will
loop retrying vm_munmap().

What -EINTR actually means in this case is that the process is going
away (see ae79878), and the whole MM will be torn down soon. In order
to facilitate this, the task should not linger in the kernel, but
actually do the opposite. So don't loop in this scenario, just abandon
the operation and let exit_mmap() clean it up. Also, update the comment
to reflect the actual meaning of the error code.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 arch/x86/kernel/shstk.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 47f5204b0fa9..cd10d074a444 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -134,28 +134,24 @@ static unsigned long adjust_shstk_size(unsigned long size)
 
 static void unmap_shadow_stack(u64 base, u64 size)
 {
-	while (1) {
-		int r;
+	int r;
 
-		r = vm_munmap(base, size);
+	r = vm_munmap(base, size);
 
-		/*
-		 * vm_munmap() returns -EINTR when mmap_lock is held by
-		 * something else, and that lock should not be held for a
-		 * long time.  Retry it for the case.
-		 */
-		if (r == -EINTR) {
-			cond_resched();
-			continue;
-		}
+	/*
+	 * mmap_write_lock_killable() failed with -EINTR. This means
+	 * the process is about to die and have it's MM cleaned up.
+	 * This task shouldn't ever make it back to userspace. In this
+	 * case it is ok to leak a shadow stack, so just exit out.
+	 */
+	if (r == -EINTR)
+		return;
 
-		/*
-		 * For all other types of vm_munmap() failure, either the
-		 * system is out of memory or there is bug.
-		 */
-		WARN_ON_ONCE(r);
-		break;
-	}
+	/*
+	 * For all other types of vm_munmap() failure, either the
+	 * system is out of memory or there is bug.
+	 */
+	WARN_ON_ONCE(r);
 }
 
 static int shstk_setup(void)
-- 
2.34.1

