Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B696C6A4EB5
	for <lists+linux-arch@lfdr.de>; Mon, 27 Feb 2023 23:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231138AbjB0Whk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Feb 2023 17:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbjB0WhM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Feb 2023 17:37:12 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B4EC46;
        Mon, 27 Feb 2023 14:33:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677537187; x=1709073187;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ND8Cme6dUKUNgrJvq4rzFWKNWp2gSll9XobN53PYr6I=;
  b=BQf3g2ka1JPjRpogNPS+jUnNnytoIA3ZoZa/cIqizgDH2ZlXEgn76V63
   /tMrSo1iPe2lAyi/gg+pAryAD3MM2fD01nHPr+U+qhRt8QqIMGP8wUzO4
   thdWwmHXojHIPw53RhjGmt5tcYYHUNEDnOwJbB94fopJo4PJXGltPVCCi
   pwolrDZtk0qGOwzNks5ygKklHZUnaU/JnSrybGrxw+HlE1ZH/pUtDKVJs
   ZnR6c3/34RFlZv2nmicJQ81JLR37E9nKzGyRiSTetBQZ2w8DeBMivLzFp
   KmvkO/rDspxsVcRTgytgEwV8YkX3/gBDfOvUhGuP607WeR8FcqRH6pRM/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="313657975"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="313657975"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:37 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="848024819"
X-IronPort-AV: E=Sophos;i="5.98,220,1673942400"; 
   d="scan'208";a="848024819"
Received: from leonqu-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.209.72.19])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 14:31:36 -0800
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
Cc:     rick.p.edgecombe@intel.com, Mike Rapoport <rppt@linux.ibm.com>
Subject: [PATCH v7 40/41] x86/shstk: Add ARCH_SHSTK_UNLOCK
Date:   Mon, 27 Feb 2023 14:29:56 -0800
Message-Id: <20230227222957.24501-41-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
[Merged into recent API changes, added commit log and docs]
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>

---
v4:
 - Add to docs that it is ptrace only.
 - Remove "CET" references

v3:
 - Depend on CONFIG_CHECKPOINT_RESTORE (Kees)
---
 Documentation/x86/shstk.rst       | 4 ++++
 arch/x86/include/uapi/asm/prctl.h | 1 +
 arch/x86/kernel/process_64.c      | 1 +
 arch/x86/kernel/shstk.c           | 9 +++++++--
 4 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/x86/shstk.rst b/Documentation/x86/shstk.rst
index f2e6f323cf68..e8ed5fc0f7ae 100644
--- a/Documentation/x86/shstk.rst
+++ b/Documentation/x86/shstk.rst
@@ -73,6 +73,10 @@ arch_prctl(ARCH_SHSTK_LOCK, unsigned long features)
     are ignored. The mask is ORed with the existing value. So any feature bits
     set here cannot be enabled or disabled afterwards.
 
+arch_prctl(ARCH_SHSTK_UNLOCK, unsigned long features)
+    Unlock features. 'features' is a mask of all features to unlock. All
+    bits set are processed, unset bits are ignored. Only works via ptrace.
+
 The return values are as follows. On success, return 0. On error, errno can
 be::
 
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index e31495668056..200efbbe5809 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -25,6 +25,7 @@
 #define ARCH_SHSTK_ENABLE		0x5001
 #define ARCH_SHSTK_DISABLE		0x5002
 #define ARCH_SHSTK_LOCK			0x5003
+#define ARCH_SHSTK_UNLOCK		0x5004
 
 /* ARCH_SHSTK_ features bits */
 #define ARCH_SHSTK_SHSTK		(1ULL <<  0)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 71094c8a305f..d368854fa9c4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -835,6 +835,7 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_SHSTK_ENABLE:
 	case ARCH_SHSTK_DISABLE:
 	case ARCH_SHSTK_LOCK:
+	case ARCH_SHSTK_UNLOCK:
 		return shstk_prctl(task, option, arg2);
 	default:
 		ret = -EINVAL;
diff --git a/arch/x86/kernel/shstk.c b/arch/x86/kernel/shstk.c
index 2faf9b45ac72..3197ff824809 100644
--- a/arch/x86/kernel/shstk.c
+++ b/arch/x86/kernel/shstk.c
@@ -451,9 +451,14 @@ long shstk_prctl(struct task_struct *task, int option, unsigned long features)
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

