Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3934D5F00C0
	for <lists+linux-arch@lfdr.de>; Fri, 30 Sep 2022 00:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiI2Whq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Sep 2022 18:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiI2Wgq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 29 Sep 2022 18:36:46 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3D543FA1A;
        Thu, 29 Sep 2022 15:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664490750; x=1696026750;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=u9CznCATrsGnwa8pqTQLU3Taz6CK/euF7IU8I3CM4v4=;
  b=ODMCljOGIpLFd1l7+quM1tH5rqMCmBJfg7CF8+VTHnjZ24Z8OWBRqtYc
   wdkXJ8sJFeOKkeU5S0kzxrFNj2v/Olrxu8bS/WLuwVPtgV9lIybO7mqCX
   ARY7QZwy3zh9TjRreFnM0D9FpnGIV8IDvHYl5eO2nEuHBC8k7wJdidvf1
   SvYjQvOVb0MSScvoiwNdlbu3PQVazqSDHwHyHzze58zfl4x5TeFQosLoT
   UPVQ+OCvq41I2+u5RFGidrssnRPpnJXbX2Nz9A0OJQn1ZcAksZl9DjFwR
   HqCW6tXPT4/mqFNZFBHAT++ExLw42jbJ12p2uH4jBAPOAFNhhIPWK6yHz
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="285182224"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="285182224"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:31:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10485"; a="691016413"
X-IronPort-AV: E=Sophos;i="5.93,356,1654585200"; 
   d="scan'208";a="691016413"
Received: from sergungo-mobl.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.251.25.88])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 15:31:04 -0700
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
Cc:     rick.p.edgecombe@intel.com, Mike Rapoport <rppt@linux.ibm.com>
Subject: [OPTIONAL/RFC v2 38/39] x86/cet/shstk: Add ARCH_CET_UNLOCK
Date:   Thu, 29 Sep 2022 15:29:35 -0700
Message-Id: <20220929222936.14584-39-rick.p.edgecombe@intel.com>
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

From: Mike Rapoport <rppt@linux.ibm.com>

Userspace loaders may lock features before a CRIU restore operation has
the chance to set them to whatever state is required by the process
being restored. Allow a way for CRIU to unlock features. Add it as an
arch_prctl() like the other CET operations, but restrict it being called
by the ptrace arch_pctl() interface.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[Merged into recent API changes, added commit log and docs]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v2:
 - New patch

 Documentation/x86/cet.rst         | 3 +++
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 9 +++++++--
 4 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
index 4a0dfb6830f9..6b270a24ebc3 100644
--- a/Documentation/x86/cet.rst
+++ b/Documentation/x86/cet.rst
@@ -81,6 +81,9 @@ arch_prctl(ARCH_CET_DISABLE, unsigned int feature)
 arch_prctl(ARCH_CET_LOCK, unsigned int features)
     Lock in features at their current enabled or disabled status.
 
+arch_prctl(ARCH_CET_UNLOCK, unsigned int features)
+    Unlock features.
+
 The return values are as following:
     On success, return 0. On error, errno can be::
 
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index d811f0c5fc4f..2f4d81ab4849 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -25,6 +25,7 @@
 #define ARCH_CET_ENABLE			0x4001
 #define ARCH_CET_DISABLE		0x4002
 #define ARCH_CET_LOCK			0x4003
+#define ARCH_CET_UNLOCK			0x4004
 
 #define CET_SHSTK			0x1
 #define CET_WRSS			0x2
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index be544b4b4c8b..fbb2062dd0d2 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -834,6 +834,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_CET_ENABLE:
 	case ARCH_CET_DISABLE:
 	case ARCH_CET_LOCK:
+	case ARCH_CET_UNLOCK:
 		return cet_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 0efec02dbe6b..af1255164f0c 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -464,9 +464,14 @@ long cet_prctl(struct task_struct *task, int option, unsigned long features)
 		return 0;
 	}
 
-	/* Don't allow via ptrace */
-	if (task != current)
+	/* Only allow via ptrace */
+	if (task != current) {
+		if (option == ARCH_CET_UNLOCK) {
+			task->thread.features_locked &= ~features;
+			return 0;
+		}
 		return -EINVAL;
+	}
 
 	/* Do not allow to change locked features */
 	if (features & task->thread.features_locked)
-- 
2.17.1

