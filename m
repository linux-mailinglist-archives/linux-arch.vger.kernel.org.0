Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7001F61A4BE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Nov 2022 23:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbiKDWqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 4 Nov 2022 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbiKDWpb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 4 Nov 2022 18:45:31 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37612126F;
        Fri,  4 Nov 2022 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667601658; x=1699137658;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=mTDZ+f4KdYSqV9q+619GLZ5q/2YYY0xPkbFAnS8RyTs=;
  b=def8mlvqYPnYhc3nOZcvqfNWaA1k1m8BtlQQAr+YKbLlUqkbYUNrs2tO
   aN5yrwy65XdbOg+tEpabzei3ae/cJctLJUhxgyewZbEmAS5SszEh96WhH
   /8/skaDavFapsTWE0VP6JJXas5ADW3P/csS9viip+v+DTjE/jix0cX7Zh
   eSJc6HGVtQBEA+CWU2mtXCb2s+ugRFGHZ/I/jhBX1DtRjGR8SQ6xn4hr3
   54LBW0R5CzMmHcbOCHdVnulJf5lCRrei6BH6zE0I9KZWwJVEZ8dGEQg9S
   uEenIOsZ1wqhqbF7JP1v/RmgK0BsgDuzbpksvAZMKxnXZw9Asyd8uhzCF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="311840633"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="311840633"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:55 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="668514181"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="668514181"
Received: from adhjerms-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.227.68])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:39:54 -0700
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
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org
Cc:     rick.p.edgecombe@intel.com, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v3 36/37] x86/cet/shstk: Add ARCH_CET_UNLOCK
Date:   Fri,  4 Nov 2022 15:36:03 -0700
Message-Id: <20221104223604.29615-37-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
References: <20221104223604.29615-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[Merged into recent API changes, added commit log and docs]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v3:
 - Depend on CONFIG_CHECKPOINT_RESTORE (Kees)

 Documentation/x86/cet.rst         | 4 ++++
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/cet.rst b/Documentation/x86/cet.rst
index b56811566531..f69cafb1feff 100644
--- a/Documentation/x86/cet.rst
+++ b/Documentation/x86/cet.rst
@@ -66,6 +66,10 @@ arch_prctl(ARCH_CET_LOCK, unsigned int features)
     are ignored. The mask is ORed with the existing value. So any feature bits
     set here cannot be enabled or disabled afterwards.
 
+arch_prctl(ARCH_CET_UNLOCK, unsigned int features)
+    Unlock features. 'features' is a mask of all features to unlock. All
+    bits set are processed, unset bits are ignored.
+
 The return values are as following:
     On success, return 0. On error, errno can be::
 
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 5f1d3181e4a1..0c37fd0ad8d9 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -25,6 +25,7 @@
 #define ARCH_CET_ENABLE			0x5001
 #define ARCH_CET_DISABLE		0x5002
 #define ARCH_CET_LOCK			0x5003
+#define ARCH_CET_UNLOCK			0x5004
 
 /* ARCH_CET_ features bits */
 #define CET_SHSTK			(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 17fec059317c..03bc16c9cc19 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -835,6 +835,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_CET_ENABLE:
 	case ARCH_CET_DISABLE:
 	case ARCH_CET_LOCK:
+	case ARCH_CET_UNLOCK:
 		return cet_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 71620b77a654..bed7032d35f2 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -450,9 +450,14 @@ long cet_prctl(struct task_struct *task, int option, unsigned long features)
 		return 0;
 	}
 
-	/* Don't allow via ptrace */
-	if (task != current)
+	/* Only allow via ptrace */
+	if (task != current) {
+		if (option == ARCH_CET_UNLOCK && IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)) {
+			task->thread.features_locked &= ~features;
+			return 0;
+		}
 		return -EINVAL;
+	}
 
 	/* Do not allow to change locked features */
 	if (features & task->thread.features_locked)
-- 
2.17.1

