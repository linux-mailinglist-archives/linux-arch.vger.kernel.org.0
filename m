Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8310B641273
	for <lists+linux-arch@lfdr.de>; Sat,  3 Dec 2022 01:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbiLCAkx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Dec 2022 19:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiLCAkS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Dec 2022 19:40:18 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A7C421A9;
        Fri,  2 Dec 2022 16:38:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670027882; x=1701563882;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=e1Skkfy1bUPFrf6Q3GKORbKcHv2d1Lsi1t/sz8iK3T0=;
  b=dI+zjLmZgQKl4reOc5ild3Xo8n29jQF38wpDrK8gGOXx294gdZsWSG1q
   pE2N5o/H0jQrArrtcxYZhRJpfkldOlQ6VQN7Wnj0ovdeM7pfO86RmvkWR
   m5Uus6P8CyUvFd2AbsC5vnsMkXlbyu7xu9CYtbjg6kxWk65X9K4hKL3eh
   nurw6QVoByszTHLbhoCy+1nPJtvlzR+wp2F4brw61j7vcs1VmdzoKOl6L
   6/ahAo2G9Viw72ydEbJc4ZsZLf+iIPtQKIVAdHiLUVIlc57ZmJLwDvDtV
   eY2J6ZiiZsDrQw0q6LzgZTVrhm56qkh3JJyLHJJo1vmVryrG5y9pUNeFD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="313711190"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="313711190"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:22 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10549"; a="787479929"
X-IronPort-AV: E=Sophos;i="5.96,213,1665471600"; 
   d="scan'208";a="787479929"
Received: from bgordon1-mobl1.amr.corp.intel.com (HELO rpedgeco-desk.amr.corp.intel.com) ([10.212.211.211])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2022 16:37:20 -0800
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
Cc:     rick.p.edgecombe@intel.com, Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: [PATCH v4 22/39] mm: Re-introduce vm_flags to do_mmap()
Date:   Fri,  2 Dec 2022 16:35:49 -0800
Message-Id: <20221203003606.6838-23-rick.p.edgecombe@intel.com>
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

From: Yu-cheng Yu <yu-cheng.yu@intel.com>

There was no more caller passing vm_flags to do_mmap(), and vm_flags was
removed from the function's input by:

    commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").

There is a new user now.  Shadow stack allocation passes VM_SHADOW_STACK to
do_mmap().  Thus, re-introduce vm_flags to do_mmap().

Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Reviewed-by: Peter Collingbourne <pcc@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
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
index 5b2ff20ad322..66119297125a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -554,7 +554,7 @@ static int aio_setup_ring(struct kioctx *ctx, unsigned int nr_events)
 
 	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
 				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+				 MAP_SHARED, 0, 0, &unused, NULL);
 	mmap_write_unlock(mm);
 	if (IS_ERR((void *)ctx->mmap_base)) {
 		ctx->mmap_size = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e0991d2fc5a8..7c10d2a7bbfd 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2731,7 +2731,8 @@ extern unsigned long mmap_region(struct file *file, unsigned long addr,
 	struct list_head *uf);
 extern unsigned long do_mmap(struct file *file, unsigned long addr,
 	unsigned long len, unsigned long prot, unsigned long flags,
-	unsigned long pgoff, unsigned long *populate, struct list_head *uf);
+	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
+	struct list_head *uf);
 extern int do_mas_munmap(struct ma_state *mas, struct mm_struct *mm,
 			 unsigned long start, size_t len, struct list_head *uf,
 			 bool downgrade);
diff --git a/ipc/shm.c b/ipc/shm.c
index bd2fcc4d454e..1c5476bfec8b 100644
--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -1662,7 +1662,7 @@ long do_shmat(int shmid, char __user *shmaddr, int shmflg,
 			goto invalid;
 	}
 
-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap(file, addr, size, prot, flags, 0, 0, &populate, NULL);
 	*raddr = addr;
 	err = 0;
 	if (IS_ERR_VALUE(addr))
diff --git a/mm/mmap.c b/mm/mmap.c
index 7ce04d2d5a10..a3ce13be0767 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1239,11 +1239,11 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
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
 
 	validate_mm(mm);
@@ -1304,7 +1304,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
 	 * to. we assume access permissions have been handled by the open
 	 * of the memory object, so we don't do any here.
 	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
 			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
 
 	if (flags & MAP_LOCKED)
@@ -2877,7 +2877,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, start, unsigned long, size,
 
 	file = get_file(vma->vm_file);
 	ret = do_mmap(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate, NULL);
+			prot, flags, 0, pgoff, &populate, NULL);
 	fput(file);
 out:
 	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 214c70e1d059..20ff1ec89091 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1042,6 +1042,7 @@ unsigned long do_mmap(struct file *file,
 			unsigned long len,
 			unsigned long prot,
 			unsigned long flags,
+			vm_flags_t vm_flags,
 			unsigned long pgoff,
 			unsigned long *populate,
 			struct list_head *uf)
@@ -1049,7 +1050,6 @@ unsigned long do_mmap(struct file *file,
 	struct vm_area_struct *vma;
 	struct vm_region *region;
 	struct rb_node *rb;
-	vm_flags_t vm_flags;
 	unsigned long capabilities, result;
 	int ret;
 	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
@@ -1069,7 +1069,7 @@ unsigned long do_mmap(struct file *file,
 
 	/* we've determined that we can make the mapping, now translate what we
 	 * now know into VMA flags */
-	vm_flags = determine_vm_flags(file, prot, flags, capabilities);
+	vm_flags |= determine_vm_flags(file, prot, flags, capabilities);
 
 
 	/* we're going to need to record the mapping */
diff --git a/mm/util.c b/mm/util.c
index 12984e76767e..aefe4fae7ecf 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -517,7 +517,7 @@ unsigned long vm_mmap_pgoff(struct file *file, unsigned long addr,
 	if (!ret) {
 		if (mmap_write_lock_killable(mm))
 			return -EINTR;
-		ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
+		ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
 			      &uf);
 		mmap_write_unlock(mm);
 		userfaultfd_unmap_complete(mm, &uf);
-- 
2.17.1

