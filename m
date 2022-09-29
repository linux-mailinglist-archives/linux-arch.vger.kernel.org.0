Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BF25F00AD
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiI2Wh1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230018AbiI2WgU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:20 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC311ED23B;
        Thu, 29 Sep 2022 15:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490735; x=1696026735;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=/a1pKHmwhVYyv4Ui3rbvLcahiUY8jR6mb1CYyGIJjno=;
  b=OTpadoY8NEPNcnjC9kdrfP00MGEHsI8IUCV14af6DSRzxekgcj+qGz1p
   oEr9Xd5+uVaXghH/K5Aik4WGan1IJIqv2ElbA4z7/gBg1nb7JbAMUf4Kk
   CEHA7pSeb2rL2PmuJugHMyu8dNOmbIS142Tt/SUa3v+kYmcMSpfB1Vr6u
   buctIae5ud39O9LKsi71iZDlr9jDVD/gL45M5CKQiC8cpX8/JARKOpRCF
   5HTDzWME20GIR++UPu+J/UbT8EmBJQP22+TeWV/UYxkINa4U9moaAdxZv
   FamFBF1I24IPB+v2oKpAQyOIxO39FBKHBm1jpeA8lZX1/xLCVEohmD0CB
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182168"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182168"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016364"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016364"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:30:53 -0700
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
        "Ravi V . Shankar" <ravi.v.shankar@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        joao.moreira@intel.com, John Allen <john.allen@amd.com>,
        kcc@google.com, eranian@google.com, rppt@kernel.org,
        jamorris@linux.microsoft.com, dethoma@microsoft.com
Cc:     rick.p.edgecombe@intel.com
Subject: [PATCH v2 33/39] x86/cpufeatures: Limit shadow stack to Intel CPUs
Date:   Thu, 29 Sep 2022 15:29:30 -0700
Message-Id: <20220929222936.14584-34-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Shadow stack is supported on newer AMD processors, but the kernel
implementation has not been tested on them. Prevent basic issues from
showing up for normal users by disabling shadow stack on all CPUs except
Intel until it has been tested. At which point the limitation should be
removed.

Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---

v1:
 - New patch.

 arch/x86/kernel/cpu/common.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index d7415bb556b2..f7cacc5698d5 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -606,6 +606,14 @@ static __always_inline void setup_cet(struct cpuinfo_x86 *c)
 	if (!kernel_ibt && !user_shstk)
 		return;
 
+	/*
+	 * Shadow stack is supported on AMD processors, but has not been
+	 * tested. Only support it on Intel processors until this is done.
+	 * At which point, this vendor check should be removed.
+	 */
+	if (c->x86_vendor != X86_VENDOR_INTEL)
+		setup_clear_cpu_cap(X86_FEATURE_SHSTK);
+
 	if (kernel_ibt)
 		msr = CET_ENDBR_EN;
 
-- 
2.17.1

