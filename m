Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 869EC213CBE
	for <lists+linux-arch@lfdr.de>; Fri,  3 Jul 2020 17:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbgGCPhi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Jul 2020 11:37:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:40854 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726147AbgGCPhi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Jul 2020 11:37:38 -0400
Received: from localhost.localdomain (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA910215A4;
        Fri,  3 Jul 2020 15:37:34 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Price <steven.price@arm.com>
Subject: [PATCH v6 06/26] mm: Add PG_arch_2 page flag
Date:   Fri,  3 Jul 2020 16:36:58 +0100
Message-Id: <20200703153718.16973-7-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200703153718.16973-1-catalin.marinas@arm.com>
References: <20200703153718.16973-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Steven Price <steven.price@arm.com>

For arm64 MTE support it is necessary to be able to mark pages that
contain user space visible tags that will need to be saved/restored e.g.
when swapped out.

To support this add a new arch specific flag (PG_arch_2). This flag is
only available on 64-bit architectures due to the limited number of
spare page flags on the 32-bit ones.

Signed-off-by: Steven Price <steven.price@arm.com>
[catalin.marinas@arm.com: use CONFIG_64BIT for guarding this new flag]
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---

Notes:
    v6:
    - Using CONFIG_64BIT instead of a new CONFIG_ARCH_USES_PG_ARCH_2 option.
    
    New in v4.

 fs/proc/page.c                    | 3 +++
 include/linux/kernel-page-flags.h | 1 +
 include/linux/page-flags.h        | 3 +++
 include/trace/events/mmflags.h    | 9 ++++++++-
 tools/vm/page-types.c             | 2 ++
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index f909243d4a66..9f1077d94cde 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -217,6 +217,9 @@ u64 stable_page_flags(struct page *page)
 	u |= kpf_copy_bit(k, KPF_PRIVATE_2,	PG_private_2);
 	u |= kpf_copy_bit(k, KPF_OWNER_PRIVATE,	PG_owner_priv_1);
 	u |= kpf_copy_bit(k, KPF_ARCH,		PG_arch_1);
+#ifdef CONFIG_64BIT
+	u |= kpf_copy_bit(k, KPF_ARCH_2,	PG_arch_2);
+#endif
 
 	return u;
 };
diff --git a/include/linux/kernel-page-flags.h b/include/linux/kernel-page-flags.h
index abd20ef93c98..eee1877a354e 100644
--- a/include/linux/kernel-page-flags.h
+++ b/include/linux/kernel-page-flags.h
@@ -17,5 +17,6 @@
 #define KPF_ARCH		38
 #define KPF_UNCACHED		39
 #define KPF_SOFTDIRTY		40
+#define KPF_ARCH_2		41
 
 #endif /* LINUX_KERNEL_PAGE_FLAGS_H */
diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 6be1aa559b1e..276140c94f4a 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -135,6 +135,9 @@ enum pageflags {
 #if defined(CONFIG_IDLE_PAGE_TRACKING) && defined(CONFIG_64BIT)
 	PG_young,
 	PG_idle,
+#endif
+#ifdef CONFIG_64BIT
+	PG_arch_2,
 #endif
 	__NR_PAGEFLAGS,
 
diff --git a/include/trace/events/mmflags.h b/include/trace/events/mmflags.h
index 5fb752034386..67018d367b9f 100644
--- a/include/trace/events/mmflags.h
+++ b/include/trace/events/mmflags.h
@@ -79,6 +79,12 @@
 #define IF_HAVE_PG_IDLE(flag,string)
 #endif
 
+#ifdef CONFIG_64BIT
+#define IF_HAVE_PG_ARCH_2(flag,string) ,{1UL << flag, string}
+#else
+#define IF_HAVE_PG_ARCH_2(flag,string)
+#endif
+
 #define __def_pageflag_names						\
 	{1UL << PG_locked,		"locked"	},		\
 	{1UL << PG_waiters,		"waiters"	},		\
@@ -105,7 +111,8 @@ IF_HAVE_PG_MLOCK(PG_mlocked,		"mlocked"	)		\
 IF_HAVE_PG_UNCACHED(PG_uncached,	"uncached"	)		\
 IF_HAVE_PG_HWPOISON(PG_hwpoison,	"hwpoison"	)		\
 IF_HAVE_PG_IDLE(PG_young,		"young"		)		\
-IF_HAVE_PG_IDLE(PG_idle,		"idle"		)
+IF_HAVE_PG_IDLE(PG_idle,		"idle"		)		\
+IF_HAVE_PG_ARCH_2(PG_arch_2,		"arch_2"	)
 
 #define show_page_flags(flags)						\
 	(flags) ? __print_flags(flags, "|",				\
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index 58c0eab71bca..0517c744b04e 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -78,6 +78,7 @@
 #define KPF_ARCH		38
 #define KPF_UNCACHED		39
 #define KPF_SOFTDIRTY		40
+#define KPF_ARCH_2		41
 
 /* [48-] take some arbitrary free slots for expanding overloaded flags
  * not part of kernel API
@@ -135,6 +136,7 @@ static const char * const page_flag_names[] = {
 	[KPF_ARCH]		= "h:arch",
 	[KPF_UNCACHED]		= "c:uncached",
 	[KPF_SOFTDIRTY]		= "f:softdirty",
+	[KPF_ARCH_2]		= "H:arch_2",
 
 	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_SLOB_FREE]		= "P:slob_free",
