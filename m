Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A44369BCFE
	for <lists+linux-arch@lfdr.de>; Sat, 18 Feb 2023 22:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjBRVWp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 18 Feb 2023 16:22:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjBRVWL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 18 Feb 2023 16:22:11 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8199219F24;
        Sat, 18 Feb 2023 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676755150; x=1708291150;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LBXMAmJiTfFh9q2evgIt9WapwuhYib2Yu77ryjdrcH4=;
  b=Gi0qSIVE/YtcisAgZe3dhDcc+S3sfKvJi+ncqccTxv9ehuNL2LhXTLzz
   pujQklXfi2RPMTd/QjWOz9S45hmQq5kqO/9V2r3Ab11FkTTnMssShxHkY
   xDJJdU4yDkZhgIAtk2CeswphKBOGYZwnLfp90TLjDQwh6xOX1UvJA9MjO
   6yaa2rRKXLmaKBqehtB2IblogR564BgwUQa0767wyrMKSJyM8NsKMDXkU
   YKbvEZrG6Rzlx/zVmEqcKSvJDXIGymY7XjYzWesipcLv/gpUSRXrw+Y1P
   sOqK4k1/DdNhId7sXc5wLd7KZS2f5x0wNL4pdtfXk3G4ijN1863/4MmBM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="418427879"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="418427879"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:26 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10625"; a="664241745"
X-IronPort-AV: E=Sophos;i="5.97,309,1669104000"; 
   d="scan'208";a="664241745"
Received: from adityava-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.80.223])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2023 13:16:25 -0800
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
        david@redhat.com, debug@rivosinc.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v6 36/41] x86/shstk: Wire in shadow stack interface
Date:   Sat, 18 Feb 2023 13:14:28 -0800
Message-Id: <20230218211433.26859-37-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The kernel now has the main shadow stack functionality to support
applications. Wire in the WRSS and shadow stack enable/disable functions
into the existing shadow stack API skeleton.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v4:
 - Remove "CET" references

v2:
 - Split from other patches
---
 arch/x86/kernel/shstk.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 009cb3fa0ae5..2faf9b45ac72 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -464,9 +464,17 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return -EINVAL;
 
 	if (option == ARCH_SHSTK_DISABLE) {
+		if (features & ARCH_SHSTK_WRSS)
+			return wrss_control(false);
+		if (features & ARCH_SHSTK_SHSTK)
+			return shstk_disable();
 		return -EINVAL;
 	}
 
 	/* Handle ARCH_SHSTK_ENABLE */
+	if (features & ARCH_SHSTK_SHSTK)
+		return shstk_setup();
+	if (features & ARCH_SHSTK_WRSS)
+		return wrss_control(true);
 	return -EINVAL;
 }
-- 
2.17.1

