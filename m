Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644573CFE02
	for <lists+linux-arch@lfdr.de>; Tue, 20 Jul 2021 17:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbhGTPBW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 20 Jul 2021 11:01:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:36054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240453AbhGTOaz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 20 Jul 2021 10:30:55 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DB22D610A0;
        Tue, 20 Jul 2021 15:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626793804;
        bh=waF0yGZ/74FCKFwfsSHiFG6HeMntkph0RFHmK2X6nWk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wr6FlViYO8SKfm17hVN2pUi5fGp+Fk/QoWvAgyq3TtIVH/9dDFxOXPCzB/PejgO0h
         8Qq/kxx409pXMf2qcAkZDEJUP3P3OhSYpV98cvMXDLpN16PoIW0oqNMuitJhNn7Kbg
         8KF+V+QhXxbxgwvQl2ACrYt65CYiMfiTto/fmTyiA6ONeCuH7P9eqSPeOtWrxanZwz
         +t9tPZ6V2N5AFfRROR65fSgKOoRmHIZyG8v+8foim41EfKnVRb0QmOwR+A+AtmsArg
         k1Si2b+axOnw7C72U5GDa35Pk31LCRaatyrxS5eemD40HnSs09wom1B6xJ30duAFln
         SNBm8x0hT5m+g==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Christoph Hellwig <hch@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        kexec@lists.infradead.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v4 2/4] mm: simplify compat_sys_move_pages
Date:   Tue, 20 Jul 2021 17:09:48 +0200
Message-Id: <20210720150950.3669610-3-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210720150950.3669610-1-arnd@kernel.org>
References: <20210720150950.3669610-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The compat move_pages() implementation uses compat_alloc_user_space()
for converting the pointer array. Moving the compat handling into
the function itself is a bit simpler and lets us avoid the
compat_alloc_user_space() call.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/migrate.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 34a9ad3e0a4f..60634d2653b9 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1820,6 +1820,23 @@ static void do_pages_stat_array(struct mm_struct *mm, unsigned long nr_pages,
 	mmap_read_unlock(mm);
 }
 
+static int get_compat_pages_array(const void __user *chunk_pages[],
+				  const void __user * __user *pages,
+				  unsigned long chunk_nr)
+{
+	compat_uptr_t __user *pages32 = (compat_uptr_t __user *)pages;
+	compat_uptr_t p;
+	int i;
+
+	for (i = 0; i < chunk_nr; i++) {
+		if (get_user(p, pages32 + i))
+			return -EFAULT;
+		chunk_pages[i] = compat_ptr(p);
+	}
+
+	return 0;
+}
+
 /*
  * Determine the nodes of a user array of pages and store it in
  * a user array of status.
@@ -1839,8 +1856,15 @@ static int do_pages_stat(struct mm_struct *mm, unsigned long nr_pages,
 		if (chunk_nr > DO_PAGES_STAT_CHUNK_NR)
 			chunk_nr = DO_PAGES_STAT_CHUNK_NR;
 
-		if (copy_from_user(chunk_pages, pages, chunk_nr * sizeof(*chunk_pages)))
-			break;
+		if (in_compat_syscall()) {
+			if (get_compat_pages_array(chunk_pages, pages,
+						   chunk_nr))
+				break;
+		} else {
+			if (copy_from_user(chunk_pages, pages,
+				      chunk_nr * sizeof(*chunk_pages)))
+				break;
+		}
 
 		do_pages_stat_array(mm, chunk_nr, chunk_pages, chunk_status);
 
@@ -1945,23 +1969,14 @@ SYSCALL_DEFINE6(move_pages, pid_t, pid, unsigned long, nr_pages,
 
 #ifdef CONFIG_COMPAT
 COMPAT_SYSCALL_DEFINE6(move_pages, pid_t, pid, compat_ulong_t, nr_pages,
-		       compat_uptr_t __user *, pages32,
+		       compat_uptr_t __user *, pages,
 		       const int __user *, nodes,
 		       int __user *, status,
 		       int, flags)
 {
-	const void __user * __user *pages;
-	int i;
-
-	pages = compat_alloc_user_space(nr_pages * sizeof(void *));
-	for (i = 0; i < nr_pages; i++) {
-		compat_uptr_t p;
-
-		if (get_user(p, pages32 + i) ||
-			put_user(compat_ptr(p), pages + i))
-			return -EFAULT;
-	}
-	return kernel_move_pages(pid, nr_pages, pages, nodes, status, flags);
+	return kernel_move_pages(pid, nr_pages,
+				 (const void __user *__user *)pages,
+				 nodes, status, flags);
 }
 #endif /* CONFIG_COMPAT */
 
-- 
2.29.2

