Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD41764485D
	for <lists+linux-arch@lfdr.de>; Tue,  6 Dec 2022 16:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiLFPvA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Dec 2022 10:51:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbiLFPuo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Dec 2022 10:50:44 -0500
X-Greylist: delayed 527 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Dec 2022 07:50:37 PST
Received: from mailout.easymail.ca (mailout.easymail.ca [64.68.200.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFA702DA90;
        Tue,  6 Dec 2022 07:50:37 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id A0B62E74B3;
        Tue,  6 Dec 2022 15:41:50 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at emo08-pco.easydns.vpn
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo08-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id o6MELZ_AxPs3; Tue,  6 Dec 2022 15:41:50 +0000 (UTC)
Received: from mail.gonehiking.org (unknown [38.15.45.1])
        by mailout.easymail.ca (Postfix) with ESMTPA id 43637E7494;
        Tue,  6 Dec 2022 15:41:50 +0000 (UTC)
Received: from localhost.localdomain (internal [192.168.1.4])
        by mail.gonehiking.org (Postfix) with ESMTP id 877713EEF7;
        Tue,  6 Dec 2022 08:41:48 -0700 (MST)
From:   Khalid Aziz <khalid@gonehiking.org>
To:     akpm@linux-foundation.org, willy@infradead.org, djwong@kernel.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com
Cc:     Khalid Aziz <khalid@gonehiking.org>, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, 21cnbao@gmail.com,
        arnd@arndb.de, ebiederm@xmission.com, elver@google.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 1/2] mm/ptshare: Add vm flag for shared PTE
Date:   Tue,  6 Dec 2022 08:41:40 -0700
Message-Id: <fb672fcc0aae77214a905e95808f9566f441218a.1670287696.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1670287695.git.khalid.aziz@oracle.com>
References: <cover.1670287695.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
a function to determine if a vma shares PTE by checking this flag.
This is to be used to find the shared page table entries on page fault
for vmas sharing PTE.

Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/mm.h             | 8 ++++++++
 include/trace/events/mmflags.h | 3 ++-
 mm/internal.h                  | 5 +++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 8bbcccbc5565..699323be7502 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -314,11 +314,13 @@ extern unsigned int kobjsize(const void *objp);
 #define VM_HIGH_ARCH_BIT_2	34	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_3	35	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_BIT_4	36	/* bit only usable on 64-bit architectures */
+#define VM_HIGH_ARCH_BIT_5	37	/* bit only usable on 64-bit architectures */
 #define VM_HIGH_ARCH_0	BIT(VM_HIGH_ARCH_BIT_0)
 #define VM_HIGH_ARCH_1	BIT(VM_HIGH_ARCH_BIT_1)
 #define VM_HIGH_ARCH_2	BIT(VM_HIGH_ARCH_BIT_2)
 #define VM_HIGH_ARCH_3	BIT(VM_HIGH_ARCH_BIT_3)
 #define VM_HIGH_ARCH_4	BIT(VM_HIGH_ARCH_BIT_4)
+#define VM_HIGH_ARCH_5	BIT(VM_HIGH_ARCH_BIT_5)
 #endif /* CONFIG_ARCH_USES_HIGH_VMA_FLAGS */
 
 #ifdef CONFIG_ARCH_HAS_PKEYS
@@ -360,6 +362,12 @@ extern unsigned int kobjsize(const void *objp);
 # define VM_MTE_ALLOWED	VM_NONE
 #endif
 
+#ifdef CONFIG_ARCH_USES_HIGH_VMA_FLAGS
+#define VM_SHARED_PT	VM_HIGH_ARCH_5
+#else
+#define VM_SHARED_PT	VM_NONE
+#endif
+
 #ifndef VM_GROWSUP
 # define VM_GROWSUP	VM_NONE
 #endif
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index e87cb2b80ed3..30e56cbac99b 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -194,7 +194,8 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY,	"softdirty"	)		\
 	{VM_MIXEDMAP,			"mixedmap"	},		\
 	{VM_HUGEPAGE,			"hugepage"	},		\
 	{VM_NOHUGEPAGE,			"nohugepage"	},		\
-	{VM_MERGEABLE,			"mergeable"	}		\
+	{VM_MERGEABLE,			"mergeable"	},		\
+	{VM_SHARED_PT,			"sharedpt"	}		\
 
 #define show_vma_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/mm/internal.h b/mm/internal.h
index 6b7ef495b56d..16083eca720e 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -856,4 +856,9 @@ static inline bool vma_soft_dirty_enabled(struct vm_area_struct *vma)
 	return !(vma->vm_flags & VM_SOFTDIRTY);
 }
 
+static inline bool vma_is_shared(const struct vm_area_struct *vma)
+{
+	return vma->vm_flags & VM_SHARED_PT;
+}
+
 #endif	/* __MM_INTERNAL_H */
-- 
2.34.1

