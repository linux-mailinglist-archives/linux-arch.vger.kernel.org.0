Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AE2ADBB9
	for <lists+linux-arch@lfdr.de>; Tue, 10 Nov 2020 17:23:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726344AbgKJQX4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 10 Nov 2020 11:23:56 -0500
Received: from mga04.intel.com ([192.55.52.120]:36544 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730853AbgKJQW6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 10 Nov 2020 11:22:58 -0500
IronPort-SDR: QCBiejELEjWcQj/YXQdqsGIaWYIgAC5NkZieT1po24phRBKIMq7xr0wu+OIQfy2ccYefvk3z2M
 xQfILMNvVAkQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9801"; a="167418678"
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="167418678"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:54 -0800
IronPort-SDR: Z00bkfKti0l1mIp1NdWgXMKUyKC8JtfDpcC6vHYslQF+xdBetCAVgU8szDipHG/w36TNyWCvlD
 Msw9BOVSYYLQ==
X-IronPort-AV: E=Sophos;i="5.77,466,1596524400"; 
   d="scan'208";a="365572901"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2020 08:22:53 -0800
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
        Weijiang Yang <weijiang.yang@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
Cc:     Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v15 19/26] mm: Re-introduce vm_flags to do_mmap()
Date:   Tue, 10 Nov 2020 08:22:04 -0800
Message-Id: <20201110162211.9207-20-yu-cheng.yu@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20201110162211.9207-1-yu-cheng.yu@intel.com>
References: <20201110162211.9207-1-yu-cheng.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There was no more caller passing vm_flags to do_mmap(), and vm_flags was
removed from the function's input by:

    commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").

There is a new user now.  Shadow stack allocation passes VM_SHSTK to
do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
do_mmap_pgoff().  Instead, make all callers of the wrapper pass a zero
vm_flags to do_mmap().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Peter Collingbourne <pcc@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: linux-mm@kvack.org
---
 fs/aio.c           |  2 +-
 include/linux/mm.h |  3 ++-
 ipc/shm.c          |  2 +-
 mm/mmap.c          | 10 +++++-----
 mm/nommu.c         |  4 ++--
 mm/util.c          |  2 +-
 6 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index c45c20d87538..641640288b50 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -527,7 +527,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
 				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+				 MAP_SHARED, 0, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 80cda65bb1ae..ef1bd7c7e88b 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2584,7 +2584,8 @@ extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct list_head *uf);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
+	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf);
 extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
 		       struct list_head *uf, bool downgrade);
 extern int do_munmap(struct mm_struct *, unsigned long, size_t,
diff --git a/ipc/shm.c b/ipc/shm.c
index e25c7c6106bc..91474258933d 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1556,7 +1556,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			goto invalid;
 	}
 
-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap(file, addr, size, prot, flags, 0, 0, &populate, NULL);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/mmap.c b/mm/mmap.c
index 2290a67f4d3f..c4938e4b789b 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1403,11 +1403,11 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
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
@@ -1469,7 +1469,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
@@ -3051,7 +3051,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	file = get_file(vma->vm_file);
 	ret = do_mmap(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate, NULL);
+			prot, flags, 0, pgoff, &populate, NULL);
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 0faf39b32cdb..a03c72f0c3f8 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1071,6 +1071,7 @@ unsigned long do_mmap(struct file *file,
 			unsigned long len,
 			unsigned long prot,
 			unsigned long flags,
+			vm_flags_t vm_flags,
 			unsigned long pgoff,
 			unsigned long *populate,
 			struct list_head *uf)
@@ -1078,7 +1079,6 @@ unsigned long do_mmap(struct file *file,
 	struct vm_area_struct *vma;
 	struct vm_region *region;
 	struct rb_node *rb;
-	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
 
@@ -1097,7 +1097,7 @@ unsigned long do_mmap(struct file *file,
 
 	/* we've determined that we can make the mapping, now translate what we
 	 * now know into VMA flags */
-	vm_flags = determine_vm_flags(file, prot, flags, capabilities);
+	vm_flags |= determine_vm_flags(file, prot, flags, capabilities);
 
 	/* we're going to need to record the mapping */
 	region = kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
diff --git a/mm/util.c b/mm/util.c
index 4ddb6e186dd5..6fd9a272b7f9 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -504,7 +504,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-		ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
+		ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
 			      &uf);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
-- 
2.21.0

