Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B46D281746
	for <lists+linux-arch@lfdr.de>; Fri,  2 Oct 2020 17:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgJBP6T (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 11:58:19 -0400
Received: from mga12.intel.com ([192.55.52.136]:3614 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBP6T (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Oct 2020 11:58:19 -0400
IronPort-SDR: 1DFwx49py7rA88vLihJtYVFF5EPGV2+2smjlW8PBnOdYYBAa2B4igq/Ct83wI5zI7GCE+hqSxm
 b+802xx1DxgQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="142406480"
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="142406480"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 08:58:17 -0700
IronPort-SDR: UIER8ztpir42d+P/skPtUqpAth+NDcVX4em72Mfu0y5X2uWzRo8um/fUiNf+rZfjUGFriSSsaT
 qxiCFOSZqR+w==
X-IronPort-AV: E=Sophos;i="5.77,328,1596524400"; 
   d="scan'208";a="295390005"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.143.131]) ([10.212.143.131])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 08:58:15 -0700
Subject: Re: [PATCH v13 19/26] mm: Re-introduce do_mmap_pgoff()
To:     Peter Collingbourne <pcc@google.com>
Cc:     x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Pengfei Xu <pengfei.xu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200925145649.5438-1-yu-cheng.yu@intel.com>
 <20200925145649.5438-20-yu-cheng.yu@intel.com>
 <CAMn1gO4cxSt8-8qVbAei0jPErTtARdsEY4js6Fi=kzozAuE3yQ@mail.gmail.com>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <00a409f0-1e2e-0bd7-83e7-f21a47878916@intel.com>
Date:   Fri, 2 Oct 2020 08:58:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAMn1gO4cxSt8-8qVbAei0jPErTtARdsEY4js6Fi=kzozAuE3yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/1/2020 7:06 PM, Peter Collingbourne wrote:
> On Fri, Sep 25, 2020 at 7:57 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>>
>> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
>> removed from the function's input by:
>>
>>      commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
>>
>> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
>> do_mmap().  Re-introduce the vm_flags and do_mmap_pgoff().
> 
> I would prefer to change the callers to pass the additional 0 argument
> instead of bringing the wrapper function back, but if we're going to
> bring it back then we should fix the naming (both functions take a
> pgoff argument, so the previous name do_mmap_pgoff() was just plain
> confusing).
> 
> Peter
> 

Thanks for your feedback.  Here is the updated patch.  I will re-send 
the whole series later.

Yu-cheng

======

 From 6a9f1e6bcdb6e599a44d5f58cf4cebd28c4634a2 Mon Sep 17 00:00:00 2001
From: Yu-cheng Yu <yu-cheng.yu@intel.com>
Date: Wed, 12 Aug 2020 14:01:58 -0700
Subject: [PATCH 19/26] mm: Re-introduce do_mmap_pgoff()

There was no more caller passing vm_flags to do_mmap(), and vm_flags was
removed from the function's input by:

     commit 45e55300f114 ("mm: remove unnecessary wrapper function 
do_mmap_pgoff()").

There is a new user now.  Shadow stack allocation passes VM_SHSTK to
do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
do_mmap_pgoff().  Instead, fix all callers of the wrapper by passing a zero
vm_flags to do_mmap().

Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc: Peter Collingbourne <pcc@google.com>
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
index d5ec30385566..ca8c11665eea 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -527,7 +527,7 @@ static int aio_setup_ring(struct kioctx *ctx, 
unsigned int nr_events)

  	ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
  				 PROT_READ | PROT_WRITE,
-				 MAP_SHARED, 0, &unused, NULL);
+				 MAP_SHARED, 0, 0, &unused, NULL);
  	mmap_write_unlock(mm);
  	if (IS_ERR((void *)ctx->mmap_base)) {
  		ctx->mmap_size = 0;
diff --git a/include/linux/mm.h b/include/linux/mm.h
index e09d13699bbe..e020eea33138 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2560,7 +2560,8 @@ extern unsigned long mmap_region(struct file 
*file, unsigned long addr,
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
@@ -1556,7 +1556,7 @@ long do_shmat(int shmid, char __user *shmaddr, int 
shmflg,
  			goto invalid;
  	}

-	addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
+	addr = do_mmap(file, addr, size, prot, flags, 0, 0, &populate, NULL);
  	*raddr = addr;
  	err = 0;
  	if (IS_ERR_VALUE(addr))
diff --git a/mm/mmap.c b/mm/mmap.c
index 574b3f273462..fc04184d2eae 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1365,11 +1365,11 @@ static inline bool file_mmap_ok(struct file 
*file, struct inode *inode,
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
@@ -1431,7 +1431,7 @@ unsigned long do_mmap(struct file *file, unsigned 
long addr,
  	 * to. we assume access permissions have been handled by the open
  	 * of the memory object, so we don't do any here.
  	 */
-	vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
+	vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
  			mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;

  	if (flags & MAP_LOCKED)
@@ -3007,7 +3007,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long, 
start, unsigned long, size,

  	file = get_file(vma->vm_file);
  	ret = do_mmap(vma->vm_file, start, size,
-			prot, flags, pgoff, &populate, NULL);
+			prot, flags, 0, pgoff, &populate, NULL);
  	fput(file);
  out:
  	mmap_write_unlock(mm);
diff --git a/mm/nommu.c b/mm/nommu.c
index 75a327149af1..f67d6bcdfc9f 100644
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
diff --git a/mm/util.c b/mm/util.c
index 5ef378a2a038..beb8b881c080 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -503,7 +503,7 @@ unsigned long vm_mmap_pgoff(struct file *file, 
unsigned long addr,
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

