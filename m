Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C642B2A2AC0
	for <lists+linux-arch@lfdr.de>; Mon,  2 Nov 2020 13:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728785AbgKBMcb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Nov 2020 07:32:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:43974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728834AbgKBMca (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 2 Nov 2020 07:32:30 -0500
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0AB824102;
        Mon,  2 Nov 2020 12:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604320349;
        bh=NFzeeg/yQugHEBOTvh2kv8ztwy1VtMM6OJaAjWz0K8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jML6uWKrGxP/ST0pte7rtg8s2Z1JgMtur1Y6VqZNBj8MkkZSbGu8YHVITSzJ4iD+a
         4rov11GY/ak50OpNvGV4F7xdiKKs7PIAkegxy4+slQvQIz8qP2IckD66kH+A0bz+75
         AgpBsuPADkL+kKowl8UlLvVuZq0k9QPA1h3nvgG8=
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kexec@lists.infradead.org
Subject: [PATCH v2 3/4] mm: simplify compat numa syscalls
Date:   Mon,  2 Nov 2020 13:31:50 +0100
Message-Id: <20201102123151.2860165-4-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201102123151.2860165-1-arnd@kernel.org>
References: <20201102123151.2860165-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The compat implementations for mbind, get_mempolicy, set_mempolicy
and migrate_pages are just there to handle the subtly different
layout of bitmaps on 32-bit hosts.

The compat implementation however lacks some of the checks that
are present in the native one, in particular for checking that
the extra bits are all zero when user space has a larger mask
size than the kernel. Worse, those extra bits do not get cleared
when copying in or out of the kernel, which can lead to incorrect
data as well.

Unify the implementation to handle the compat bitmap layout directly
in the get_nodes() and copy_nodes_to_user() helpers.  Splitting out
the get_bitmap() helper from get_nodes() also helps readability of the
native case.

On x86, two additional problems are addressed by this: compat tasks can
pass a bitmap at the end of a mapping, causing a fault when reading
across the page boundary for a 64-bit word. x32 tasks might also run
into problems with get_mempolicy corrupting data when an odd number of
32-bit words gets passed.

On parisc the migrate_pages() system call apparently had the wrong
calling convention, as big-endian architectures expect the words
inside of a bitmap to be swapped. This is not a problem though
since parisc has no NUMA support.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 mm/mempolicy.c | 174 +++++++++++++++----------------------------------
 1 file changed, 53 insertions(+), 121 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3fde772ef5ef..fb5e533667f6 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1371,16 +1371,32 @@ static long do_mbind(unsigned long start, unsigned long len,
 /*
  * User space interface with variable sized bitmaps for nodelists.
  */
+static int get_bitmap(unsigned long *mask, const unsigned long __user *nmask,
+		      unsigned long maxnode)
+{
+	unsigned long nlongs = BITS_TO_LONGS(maxnode);
+	int ret;
+
+	if (in_compat_syscall())
+		ret = compat_get_bitmap(mask,
+				(const compat_ulong_t __user *)nmask,
+				maxnode);
+	else
+		ret = copy_from_user(mask, nmask, nlongs*sizeof(unsigned long));
+
+	if (ret)
+		return -EFAULT;
+
+	if (maxnode % BITS_PER_LONG)
+		mask[nlongs-1] &= (1UL << (maxnode % BITS_PER_LONG)) - 1;
+
+	return 0;
+}
 
 /* Copy a node mask from user space. */
 static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 		     unsigned long maxnode)
 {
-	unsigned long k;
-	unsigned long t;
-	unsigned long nlongs;
-	unsigned long endmask;
-
 	--maxnode;
 	nodes_clear(*nodes);
 	if (maxnode == 0 || !nmask)
@@ -1388,49 +1404,29 @@ static int get_nodes(nodemask_t *nodes, const unsigned long __user *nmask,
 	if (maxnode > PAGE_SIZE*BITS_PER_BYTE)
 		return -EINVAL;
 
-	nlongs = BITS_TO_LONGS(maxnode);
-	if ((maxnode % BITS_PER_LONG) == 0)
-		endmask = ~0UL;
-	else
-		endmask = (1UL << (maxnode % BITS_PER_LONG)) - 1;
-
 	/*
 	 * When the user specified more nodes than supported just check
-	 * if the non supported part is all zero.
-	 *
-	 * If maxnode have more longs than MAX_NUMNODES, check
-	 * the bits in that area first. And then go through to
-	 * check the rest bits which equal or bigger than MAX_NUMNODES.
-	 * Otherwise, just check bits [MAX_NUMNODES, maxnode).
+	 * if the non supported part is all zero, one word at a time,
+	 * starting at the end.
 	 */
-	if (nlongs > BITS_TO_LONGS(MAX_NUMNODES)) {
-		for (k = BITS_TO_LONGS(MAX_NUMNODES); k < nlongs; k++) {
-			if (get_user(t, nmask + k))
-				return -EFAULT;
-			if (k == nlongs - 1) {
-				if (t & endmask)
-					return -EINVAL;
-			} else if (t)
-				return -EINVAL;
-		}
-		nlongs = BITS_TO_LONGS(MAX_NUMNODES);
-		endmask = ~0UL;
-	}
+	while (maxnode > MAX_NUMNODES) {
+		unsigned long bits = min_t(unsigned long, maxnode, BITS_PER_LONG);
+		unsigned long t;
 
-	if (maxnode > MAX_NUMNODES && MAX_NUMNODES % BITS_PER_LONG != 0) {
-		unsigned long valid_mask = endmask;
-
-		valid_mask &= ~((1UL << (MAX_NUMNODES % BITS_PER_LONG)) - 1);
-		if (get_user(t, nmask + nlongs - 1))
+		if (get_bitmap(&t, &nmask[maxnode / BITS_PER_LONG], bits))
 			return -EFAULT;
-		if (t & valid_mask)
+
+		if (maxnode - bits >= MAX_NUMNODES) {
+			maxnode -= bits;
+		} else {
+			maxnode = MAX_NUMNODES;
+			t &= ~((1UL << (MAX_NUMNODES % BITS_PER_LONG)) - 1);
+		}
+		if (t)
 			return -EINVAL;
 	}
 
-	if (copy_from_user(nodes_addr(*nodes), nmask, nlongs*sizeof(unsigned long)))
-		return -EFAULT;
-	nodes_addr(*nodes)[nlongs-1] &= endmask;
-	return 0;
+	return get_bitmap(nodes_addr(*nodes), nmask, maxnode);
 }
 
 /* Copy a kernel node mask to user space */
@@ -1439,6 +1435,10 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 {
 	unsigned long copy = ALIGN(maxnode-1, 64) / 8;
 	unsigned int nbytes = BITS_TO_LONGS(nr_node_ids) * sizeof(long);
+	bool compat = in_compat_syscall();
+
+	if (compat)
+		nbytes = BITS_TO_COMPAT_LONGS(nr_node_ids) * sizeof(compat_long_t);
 
 	if (copy > nbytes) {
 		if (copy > PAGE_SIZE)
@@ -1447,6 +1447,11 @@ static int copy_nodes_to_user(unsigned long __user *mask, unsigned long maxnode,
 			return -EFAULT;
 		copy = nbytes;
 	}
+
+	if (compat)
+		return compat_put_bitmap((compat_ulong_t __user *)mask,
+					 nodes_addr(*nodes), maxnode);
+
 	return copy_to_user(mask, nodes_addr(*nodes), copy) ? -EFAULT : 0;
 }
 
@@ -1645,72 +1650,22 @@ COMPAT_SYSCALL_DEFINE5(get_mempolicy, int __user *, policy,
 		       compat_ulong_t, maxnode,
 		       compat_ulong_t, addr, compat_ulong_t, flags)
 {
-	long err;
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
-
-	nr_bits = min_t(unsigned long, maxnode-1, nr_node_ids);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask)
-		nm = compat_alloc_user_space(alloc_size);
-
-	err = kernel_get_mempolicy(policy, nm, nr_bits+1, addr, flags);
-
-	if (!err && nmask) {
-		unsigned long copy_size;
-		copy_size = min_t(unsigned long, sizeof(bm), alloc_size);
-		err = copy_from_user(bm, nm, copy_size);
-		/* ensure entire bitmap is zeroed */
-		err |= clear_user(nmask, ALIGN(maxnode-1, 8) / 8);
-		err |= compat_put_bitmap(nmask, bm, nr_bits);
-	}
-
-	return err;
+	return kernel_get_mempolicy(policy, (unsigned long __user *)nmask,
+				    maxnode, addr, flags);
 }
 
 COMPAT_SYSCALL_DEFINE3(set_mempolicy, int, mode, compat_ulong_t __user *, nmask,
 		       compat_ulong_t, maxnode)
 {
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	DECLARE_BITMAP(bm, MAX_NUMNODES);
-
-	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask) {
-		if (compat_get_bitmap(bm, nmask, nr_bits))
-			return -EFAULT;
-		nm = compat_alloc_user_space(alloc_size);
-		if (copy_to_user(nm, bm, alloc_size))
-			return -EFAULT;
-	}
-
-	return kernel_set_mempolicy(mode, nm, nr_bits+1);
+	return kernel_set_mempolicy(mode, (unsigned long __user *)nmask, maxnode);
 }
 
 COMPAT_SYSCALL_DEFINE6(mbind, compat_ulong_t, start, compat_ulong_t, len,
 		       compat_ulong_t, mode, compat_ulong_t __user *, nmask,
 		       compat_ulong_t, maxnode, compat_ulong_t, flags)
 {
-	unsigned long __user *nm = NULL;
-	unsigned long nr_bits, alloc_size;
-	nodemask_t bm;
-
-	nr_bits = min_t(unsigned long, maxnode-1, MAX_NUMNODES);
-	alloc_size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-
-	if (nmask) {
-		if (compat_get_bitmap(nodes_addr(bm), nmask, nr_bits))
-			return -EFAULT;
-		nm = compat_alloc_user_space(alloc_size);
-		if (copy_to_user(nm, nodes_addr(bm), alloc_size))
-			return -EFAULT;
-	}
-
-	return kernel_mbind(start, len, mode, nm, nr_bits+1, flags);
+	return kernel_mbind(start, len, mode, (unsigned long __user *)nmask,
+			    maxnode, flags);
 }
 
 COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
@@ -1718,32 +1673,9 @@ COMPAT_SYSCALL_DEFINE4(migrate_pages, compat_pid_t, pid,
 		       const compat_ulong_t __user *, old_nodes,
 		       const compat_ulong_t __user *, new_nodes)
 {
-	unsigned long __user *old = NULL;
-	unsigned long __user *new = NULL;
-	nodemask_t tmp_mask;
-	unsigned long nr_bits;
-	unsigned long size;
-
-	nr_bits = min_t(unsigned long, maxnode - 1, MAX_NUMNODES);
-	size = ALIGN(nr_bits, BITS_PER_LONG) / 8;
-	if (old_nodes) {
-		if (compat_get_bitmap(nodes_addr(tmp_mask), old_nodes, nr_bits))
-			return -EFAULT;
-		old = compat_alloc_user_space(new_nodes ? size * 2 : size);
-		if (new_nodes)
-			new = old + size / sizeof(unsigned long);
-		if (copy_to_user(old, nodes_addr(tmp_mask), size))
-			return -EFAULT;
-	}
-	if (new_nodes) {
-		if (compat_get_bitmap(nodes_addr(tmp_mask), new_nodes, nr_bits))
-			return -EFAULT;
-		if (new == NULL)
-			new = compat_alloc_user_space(size);
-		if (copy_to_user(new, nodes_addr(tmp_mask), size))
-			return -EFAULT;
-	}
-	return kernel_migrate_pages(pid, nr_bits + 1, old, new);
+	return kernel_migrate_pages(pid, maxnode,
+				    (const unsigned long __user *)old_nodes,
+				    (const unsigned long __user *)new_nodes);
 }
 
 #endif /* CONFIG_COMPAT */
-- 
2.27.0

