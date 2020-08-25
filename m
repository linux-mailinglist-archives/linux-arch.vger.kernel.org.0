Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26724250D70
	for <lists+linux-arch@lfdr.de>; Tue, 25 Aug 2020 02:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728351AbgHYAcX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 20:32:23 -0400
Received: from mga17.intel.com ([192.55.52.151]:12299 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgHYA3v (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 20:29:51 -0400
IronPort-SDR: ZeLeKEpSPQgBSSF/lUpvs5tyH6r2Ytgx8CdaDulTTAXyYEAyMq0GLRx2QdbOBNp/22XN1blMoo
 LLRuvoQx/0TQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9723"; a="136075314"
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="136075314"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:41 -0700
IronPort-SDR: rSTwxk7XXewjizOXAq/AoJScn+WIy74vviqcj88Qqm3EojR+vV91fP/JA5UEbXfUF58n2LIyiC
 zSbPghq8DNPA==
X-IronPort-AV: E=Sophos;i="5.76,350,1592895600"; 
   d="scan'208";a="474135014"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2020 17:29:41 -0700
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
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
        "H.J. Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Vedvyas Shanbhogue <vedvyas.shanbhogue@intel.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v11 19/25] mm: Re-introduce do_mmap_pgoff()
Date:   Mon, 24 Aug 2020 17:25:34 -0700
Message-Id: <20200825002540.3351-20-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200825002540.3351-1-yu-cheng.yu@intel.com>
References: <20200825002540.3351-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There was no more caller passing vm_flags to do_mmap(), and vm_flags was
removed from the function's input by:

    commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").

There is a new user now.  Shadow stack allocation passes VM_SHSTK to
do_mmap().  Re-introduce the vm_flags and do_mmap_pgoff().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-mm@kvack.org
---
 fs/aio.c             |  6 +++---
 fs/hugetlbfs/inode.c |  2 +-
 include/linux/fs.h   |  2 +-
 include/linux/mm.h   | 12 +++++++++++-
 ipc/shm.c            |  2 +-
 mm/mmap.c            | 16 ++++++++--------
 mm/nommu.c           |  6 +++---
 mm/shmem.c           |  2 +-
 mm/util.c            |  4 ++--
 9 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 5736bff48e9e..91e7cc4a9f17 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -525,9 +525,9 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 		return -EINTR;
 	}
 
-	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
-				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+	ctx->mmap_base = do_mmap_pgoff(ctx->aio_ring_file, 0, ctx->mmap_size,
+				       PROT_READ | PROT_WRITE,
+				       MAP_SHARED, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index b5c109703daa..f936bcf02cce 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -140,7 +140,7 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	 * already been checked by prepare_hugepage_range.  If you add
 	 * any error returns here, do so after setting VM_HUGETLB, so
 	 * is_vm_hugetlb_page tests below unmap_region go the right
-	 * way when do_mmap unwinds (may be important on powerpc
+	 * way when do_mmap_pgoff unwinds (may be important on powerpc
 	 * and ia64).
 	 */
 	vma->vm_flags |= VM_HUGETLB | VM_DONTEXPAND;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e019ea2f1347..75a98288e7c5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -538,7 +538,7 @@ static inline int mapping_mapped(struct address_space *mapping)
 
 /*
  * Might pages of this file have been modified in userspace?
- * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap
+ * Note that i_mmap_writable counts all VM_SHARED vmas: do_mmap_pgoff
  * marks vma as VM_SHARED if it is shared, and the file was opened for
  * writing i.e. vma may be mprotected writable even if now readonly.
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d437ce0c85ac..36b239aa5aa7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2553,13 +2553,23 @@ extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct list_head *uf);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
+	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf);
 extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
 		     struct list_head *uf);
 extern int do_madvise(unsigned long start, size_t len_in, int behavior);
 
+static inline unsigned long
+do_mmap_pgoff(struct file *file, unsigned long addr,
+	unsigned long len, unsigned long prot, unsigned long flags,
+	unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf)
+{
+	return do_mmap(file, addr, len, prot, flags, 0, pgoff, populate, uf);
+}
+
 #ifdef CONFIG_MMU
 extern int __mm_populate(unsigned long addr, unsigned long len,
 			 int ignore_errors);
diff --git a/ipc/shm.c b/ipc/shm.c
index f1ed36e3ac9f..6cf24a5994ec 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1556,7 +1556,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			goto invalid;
 	}
 
-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap_pgoff(file, addr, size, prot, flags, 0, &populate, NULL);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/mmap.c b/mm/mmap.c
index 574b3f273462..81d4a00092da 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1030,7 +1030,7 @@ static inline int is_mergeable_anon_vma(struct anon_vma *anon_vma1,
  * anon_vmas, nor if same anon_vma is assigned but offsets incompatible.
  *
  * We don't check here for the merged mmap wrapping around the end of pagecache
- * indices (16TB on ia32) because do_mmap() does not permit mmap's which
+ * indices (16TB on ia32) because do_mmap_pgoff() does not permit mmap's which
  * wrap, nor mmaps which cover the final page at index -1UL.
  */
 static int
@@ -1365,11 +1365,11 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
  */
 unsigned long do_mmap(struct file *file, unsigned long addr,
 			unsigned long len, unsigned long prot,
-			unsigned long flags, unsigned long pgoff,
-			unsigned long *populate, struct list_head *uf)
+			unsigned long flags, vm_flags_t vm_flags,
+			unsigned long pgoff, unsigned long *populate,
+			struct list_head *uf)
 {
 	struct mm_struct *mm = current->mm;
-	vm_flags_t vm_flags;
 	int pkey = 0;
 
 	*populate = 0;
@@ -1431,7 +1431,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
@@ -2233,7 +2233,7 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
 		/*
 		 * mmap_region() will call shmem_zero_setup() to create a file,
 		 * so use shmem's get_unmapped_area in case it can be huge.
-		 * do_mmap() will clear pgoff, so match alignment.
+		 * do_mmap_pgoff() will clear pgoff, so match alignment.
 		 */
 		pgoff = 0;
 		get_area = shmem_get_unmapped_area;
@@ -3006,7 +3006,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 	}
 
 	file = get_file(vma->vm_file);
-	ret = do_mmap(vma->vm_file, start, size,
+	ret = do_mmap_pgoff(vma->vm_file, start, size,
 			prot, flags, pgoff, &populate, NULL);
 	fput(file);
 out:
@@ -3226,7 +3226,7 @@ int insert_vm_struct(struct mm_struct *mm, struct vm_area_struct *vma)
 	 * By setting it to reflect the virtual start address of the
 	 * vma, merges and splits can happen in a seamless way, just
 	 * using the existing file pgoff checks and manipulations.
-	 * Similarly in do_mmap and in do_brk.
+	 * Similarly in do_mmap_pgoff and in do_brk.
 	 */
 	if (vma_is_anonymous(vma)) {
 		BUG_ON(vma->anon_vma);
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..71a4ea828f06 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1078,6 +1078,7 @@ unsigned long do_mmap(struct file *file,
 			unsigned long len,
 			unsigned long prot,
 			unsigned long flags,
+			vm_flags_t vm_flags,
 			unsigned long pgoff,
 			unsigned long *populate,
 			struct list_head *uf)
@@ -1085,7 +1086,6 @@ unsigned long do_mmap(struct file *file,
 	struct vm_area_struct *vma;
 	struct vm_region *region;
 	struct rb_node *rb;
-	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
 
@@ -1104,7 +1104,7 @@ unsigned long do_mmap(struct file *file,
 
 	/* we've determined that we can make the mapping, now translate what we
 	 * now know into VMA flags */
-	vm_flags = determine_vm_flags(file, prot, flags, capabilities);
+	vm_flags |= determine_vm_flags(file, prot, flags, capabilities);
 
 	/* we're going to need to record the mapping */
 	region = kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
@@ -1763,7 +1763,7 @@ EXPORT_SYMBOL_GPL(access_process_vm);
  *
  * Check the shared mappings on an inode on behalf of a shrinking truncate to
  * make sure that any outstanding VMAs aren't broken and then shrink the
- * vm_regions that extend beyond so that do_mmap() doesn't
+ * vm_regions that extend beyond so that do_mmap_pgoff() doesn't
  * automatically grant mappings that are too large.
  */
 int nommu_shrink_inode_mappings(struct inode *inode, size_t size,
diff --git a/mm/shmem.c b/mm/shmem.c
index 271548ca20f3..dea76ecc849b 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -4246,7 +4246,7 @@ EXPORT_SYMBOL_GPL(shmem_file_setup_with_mnt);
 
 /**
  * shmem_zero_setup - setup a shared anonymous mapping
- * @vma: the vma to be mmapped is prepared by do_mmap
+ * @vma: the vma to be mmapped is prepared by do_mmap_pgoff
  */
 int shmem_zero_setup(struct vm_area_struct *vma)
 {
diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..8d6280c05238 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -503,8 +503,8 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-		ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
-			      &uf);
+		ret = do_mmap_pgoff(file, addr, len, prot, flag, pgoff,
+				    &populate, &uf);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
 		if (populate)
-- 
2.21.0

