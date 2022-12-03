Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2859A6412B0
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbiLCAn5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:43:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235145AbiLCAmI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:42:08 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB59CFA477;
        Fri,  2 Dec 2022 16:38:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027917; x=1701563917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ihrpz4xCBLZQivZyXSYIAMTeYpug2An/yX4B7/nlQAk=;
  b=Ldddwqru6iEH6rmHwtdhhdyQofSD9ZDYHWreFVP7PySiP6f5P8z1mrzZ
   6MWo4aS+KFLOVCONv5lQbMiETlTxa0MQf7288+6gWFkT3TvTHcA1VxoGP
   j4Cx+qcn3EU/2973Su44pVd3KT5moTTEnD8XEUD5IuwHyE6L14sWgXnnj
   hT4KOn3sriQy8gS9UoiY2CQ9kjdIVDtJRl1zcfK9xQOhjjACZ2y6B+091
   iS0TRzrs1vLwdGr4F/myFUhLlSYTuJA9n5czDA/vebfKReq7cX6X4N/sH
   g/wnY1C9aYM8YWBUg1a0OnvZBFX2K+WupYiEfP0ctwSugPj7qUBAddQjx
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711666"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711666"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:55 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787480067"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787480067"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:52 -0800
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
Cc:     rick.p.edgecombe@intel.com, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v4 38/39] x86/shstk: Add ARCH_SHSTK_UNLOCK
Date:   Fri,  2 Dec 2022 16:36:05 -0800
Message-Id: <20221203003606.6838-39-rick.p.edgecombe@intel.com>
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

From: Mike Rapoport <rppt@linux.ibm.com>

Userspace loaders may lock features before a CRIU restore operation has
the chance to set them to whatever state is required by the process
being restored. Allow a way for CRIU to unlock features. Add it as an
arch_prctl() like the other shadow stack operations, but restrict it being
called by the ptrace arch_pctl() interface.

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[Merged into recent API changes, added commit log and docs]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

v4:
 - Add to docs that it is ptrace only.
 - Remove "CET" references

v3:
 - Depend on CONFIG_CHECKPOINT_RESTORE (Kees)

 Documentation/x86/shstk.rst       | 4 ++++
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
index 8e0b2fe83ef8..0d7d1ccfff06 100644
--- a/Documentation/x86/shstk.rst
+++ b/Documentation/x86/shstk.rst
@@ -73,6 +73,10 @@ arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
     are ignored. The mask is ORed with the existing value. So any feature bits
     set here cannot be enabled or disabled afterwards.
 
+arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
+    Unlock features. 'features' is a mask of all features to unlock. All
+    bits set are processed, unset bits are ignored. Only works via ptrace.
+
 The return values are as following:
     On success, return 0. On error, errno can be::
 
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index f13751c6bae4..0c95688cf58e 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -30,6 +30,7 @@
 #define ARCH_SHSTK_ENABLE		0x5001
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
+#define ARCH_SHSTK_UNLOCK		0x5004
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4ddd7d9209e1..2be6e01fb144 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -921,6 +921,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_ENABLE:
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
+	case ARCH_SHSTK_UNLOCK:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 5d91e653f77a..95579f7bace3 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -455,9 +455,14 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
 		return 0;
 	}
 
-	/* Don't allow via ptrace */
-	if (task != current)
+	/* Only allow via ptrace */
+	if (task != current) {
+		if (option == ARCH_SHSTK_UNLOCK && IS_ENABLED(CONFIG_CHECKPOINT_RESTORE)) {
+			task->thread.features_locked &= ~features;
+			return 0;
+		}
 		return -EINVAL;
+	}
 
 	/* Do not allow to change locked features */
 	if (features & task->thread.features_locked)
-- 
2.17.1

