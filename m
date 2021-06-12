Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3A23A4C8E
	for <lists+linux-arch@lfdr.de>; Sat, 12 Jun 2021 06:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbhFLEJp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 12 Jun 2021 00:09:45 -0400
Received: from mga01.intel.com ([192.55.52.88]:9354 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLEJp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 12 Jun 2021 00:09:45 -0400
IronPort-SDR: 5bZEel/UdEykp6jgFtCeejs68XTfKtAqoOh55xQAlV49KPdc5IKuOQREw1yRh8PwWZNe7O1kdO
 jTU6GIE2OXGA==
X-IronPort-AV: E=McAfee;i="6200,9189,10012"; a="227075885"
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="227075885"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 21:07:45 -0700
IronPort-SDR: w9Z6J/r97mO9lFntwTdvcFJR/T8FN7zIqOB14ZTprURZotbf+h18t1ZDpiThnaK4JmnMY6+zNE
 Gq1E7F9H+CgA==
X-IronPort-AV: E=Sophos;i="5.83,268,1616482800"; 
   d="scan'208";a="483489410"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2021 21:07:44 -0700
Date:   Fri, 11 Jun 2021 21:07:43 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Geoff Levand <geoff@infradead.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Dongsheng Yang <dongsheng.yang@easystack.cn>,
        Mike Snitzer <snitzer@redhat.com>, dm-devel@redhat.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        ceph-devel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arch@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 09/16] ps3disk: use memcpy_{from,to}_bvec
Message-ID: <20210612040743.GG1600546@iweiny-DESK2.sc.intel.com>
References: <20210608160603.1535935-1-hch@lst.de>
 <20210608160603.1535935-10-hch@lst.de>
 <20210609014822.GT3697498@iweiny-DESK2.sc.intel.com>
 <20210611065338.GA31210@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210611065338.GA31210@lst.de>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jun 11, 2021 at 08:53:38AM +0200, Christoph Hellwig wrote:
> On Tue, Jun 08, 2021 at 06:48:22PM -0700, Ira Weiny wrote:
> > I'm still not 100% sure that these flushes are needed but the are not no-ops on
> > every arch.  Would it be best to preserve them after the memcpy_to/from_bvec()?
> > 
> > Same thing in patch 11 and 14.
> 
> To me it seems kunmap_local should basically always call the equivalent
> of flush_kernel_dcache_page.  parisc does this through
> kunmap_flush_on_unmap, but none of the other architectures with VIVT
> caches or other coherency issues does.
> 
> Does anyone have a history or other insights here?

I went digging into the current callers of flush_kernel_dcache_page() other
than this one.  To see if adding kunmap_flush_on_unmap() to the other arch's
would cause any problems.

In particular this call site stood out because it is not always called?!?!?!?

void sg_miter_stop(struct sg_mapping_iter *miter)
{
...
                if ((miter->__flags & SG_MITER_TO_SG) &&
                    !PageSlab(miter->page))
                        flush_kernel_dcache_page(miter->page);
...
}

Looking at 

3d77b50c5874 lib/scatterlist.c: don't flush_kernel_dcache_page on slab page[1]

It seems the restrictions they are quoting for the page are completely out of
date.  I don't see any current way for a VM_BUG_ON() to be triggered.  So is
this code really necessary?

More recently this was added:

7e34e0bbc644 crypto: omap-crypto - fix userspace copied buffer access

I'm CC'ing Tero and Herbert to see why they added the SLAB check.


Then we have interesting comments like this...

...
                /* This can go away once MIPS implements
		 * flush_kernel_dcache_page */
		flush_dcache_page(miter->page);
...


And some users optimizing.

...
		/* discard mappings */
		if (direction == DMA_FROM_DEVICE)
			flush_kernel_dcache_page(sg_page(sg));  
...

The uses in fs/exec.c are the most straight forward and can simply rely on the
kunmap() code to replace the call.

In conclusion I don't see a lot of reason to not define kunmap_flush_on_unmap()
on arm, csky, mips, nds32, and sh...  Then remove all the
flush_kernel_dcache_page() call sites and the documentation...

Something like [2] below...  Completely untested of course...

Ira


[1] commit 3d77b50c5874b7e923be946ba793644f82336b75
Author: Ming Lei <ming.lei@canonical.com>
Date:   Thu Oct 31 16:34:17 2013 -0700

    lib/scatterlist.c: don't flush_kernel_dcache_page on slab page
    
    Commit b1adaf65ba03 ("[SCSI] block: add sg buffer copy helper
    functions") introduces two sg buffer copy helpers, and calls
    flush_kernel_dcache_page() on pages in SG list after these pages are
    written to.
    
    Unfortunately, the commit may introduce a potential bug:
    
     - Before sending some SCSI commands, kmalloc() buffer may be passed to
       block layper, so flush_kernel_dcache_page() can see a slab page
       finally
    
     - According to cachetlb.txt, flush_kernel_dcache_page() is only called
       on "a user page", which surely can't be a slab page.
    
     - ARCH's implementation of flush_kernel_dcache_page() may use page
       mapping information to do optimization so page_mapping() will see the
       slab page, then VM_BUG_ON() is triggered.
    
    Aaro Koskinen reported the bug on ARM/kirkwood when DEBUG_VM is enabled,
    and this patch fixes the bug by adding test of '!PageSlab(miter->page)'
    before calling flush_kernel_dcache_page().


[2]


From 70b537c31d16c2a5e4e92c35895e8c59303bcbef Mon Sep 17 00:00:00 2001
From: Ira Weiny <ira.weiny@intel.com>
Date: Fri, 11 Jun 2021 18:24:27 -0700
Subject: [PATCH] COMPLETELY UNTESTED: highmem: Remove direct calls to flush_kernel_dcache_page

When to call flush_kernel_dcache_page() is confusing and inconsistent.  For
architectures which may need to do something the core kmap code should be
leveraged to handle this when direct kernel access is needed.

Like parisc define kunmap_flush_on_unmap() to be called when pages are
unmapped on arm, csky, mpis, nds32, and sh.

Remove all direct calls to flush_kernel_dcache_page() and let the
kunmap() code do this for the users.


Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-csky@vger.kernel.org
Cc: linux-mips@vger.kernel.org
Cc: linux-sh@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 Documentation/core-api/cachetlb.rst  | 13 -------------
 arch/arm/include/asm/cacheflush.h    |  6 ++++++
 arch/csky/abiv1/inc/abi/cacheflush.h |  6 ++++++
 arch/mips/include/asm/cacheflush.h   |  6 ++++++
 arch/nds32/include/asm/cacheflush.h  |  6 ++++++
 arch/sh/include/asm/cacheflush.h     |  6 ++++++
 drivers/crypto/omap-crypto.c         |  3 ---
 drivers/mmc/host/mmc_spi.c           |  3 ---
 drivers/scsi/aacraid/aachba.c        |  1 -
 fs/exec.c                            |  3 ---
 include/linux/highmem.h              |  3 ---
 lib/scatterlist.c                    |  4 ----
 12 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/core-api/cachetlb.rst b/Documentation/core-api/cachetlb.rst
index fe4290e26729..5c39de30e91f 100644
--- a/Documentation/core-api/cachetlb.rst
+++ b/Documentation/core-api/cachetlb.rst
@@ -351,19 +351,6 @@ maps this page at its virtual address.
 	architectures).  For incoherent architectures, it should flush
 	the cache of the page at vmaddr.
 
-  ``void flush_kernel_dcache_page(struct page *page)``
-
-	When the kernel needs to modify a user page is has obtained
-	with kmap, it calls this function after all modifications are
-	complete (but before kunmapping it) to bring the underlying
-	page up to date.  It is assumed here that the user has no
-	incoherent cached copies (i.e. the original page was obtained
-	from a mechanism like get_user_pages()).  The default
-	implementation is a nop and should remain so on all coherent
-	architectures.  On incoherent architectures, this should flush
-	the kernel cache for page (using page_address(page)).
-
-
   ``void flush_icache_range(unsigned long start, unsigned long end)``
 
   	When the kernel stores into addresses that it will execute
diff --git a/arch/arm/include/asm/cacheflush.h b/arch/arm/include/asm/cacheflush.h
index 2e24e765e6d3..1b7cb0af707f 100644
--- a/arch/arm/include/asm/cacheflush.h
+++ b/arch/arm/include/asm/cacheflush.h
@@ -315,6 +315,12 @@ static inline void flush_anon_page(struct vm_area_struct *vma,
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 extern void flush_kernel_dcache_page(struct page *);
 
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
 
diff --git a/arch/csky/abiv1/inc/abi/cacheflush.h b/arch/csky/abiv1/inc/abi/cacheflush.h
index 6cab7afae962..e1ff554850f8 100644
--- a/arch/csky/abiv1/inc/abi/cacheflush.h
+++ b/arch/csky/abiv1/inc/abi/cacheflush.h
@@ -17,6 +17,12 @@ extern void flush_dcache_page(struct page *);
 #define ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
 extern void flush_kernel_dcache_page(struct page *);
 
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+
 #define flush_dcache_mmap_lock(mapping)		xa_lock_irq(&mapping->i_pages)
 #define flush_dcache_mmap_unlock(mapping)	xa_unlock_irq(&mapping->i_pages)
 
diff --git a/arch/mips/include/asm/cacheflush.h b/arch/mips/include/asm/cacheflush.h
index d687b40b9fbb..c3043b600008 100644
--- a/arch/mips/include/asm/cacheflush.h
+++ b/arch/mips/include/asm/cacheflush.h
@@ -132,6 +132,12 @@ static inline void flush_kernel_dcache_page(struct page *page)
 	flush_dcache_page(page);
 }
 
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+
 /*
  * For now flush_kernel_vmap_range and invalidate_kernel_vmap_range both do a
  * cache writeback and invalidate operation.
diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm/cacheflush.h
index 7d6824f7c0e8..bae980846e2a 100644
--- a/arch/nds32/include/asm/cacheflush.h
+++ b/arch/nds32/include/asm/cacheflush.h
@@ -43,6 +43,12 @@ void invalidate_kernel_vmap_range(void *addr, int size);
 #define flush_dcache_mmap_lock(mapping)   xa_lock_irq(&(mapping)->i_pages)
 #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pages)
 
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+
 #else
 void flush_icache_user_page(struct vm_area_struct *vma, struct page *page,
 	                     unsigned long addr, int len);
diff --git a/arch/sh/include/asm/cacheflush.h b/arch/sh/include/asm/cacheflush.h
index 4486a865ff62..2e23a8d71aa7 100644
--- a/arch/sh/include/asm/cacheflush.h
+++ b/arch/sh/include/asm/cacheflush.h
@@ -78,6 +78,12 @@ static inline void flush_kernel_dcache_page(struct page *page)
 	flush_dcache_page(page);
 }
 
+#define ARCH_HAS_FLUSH_ON_KUNMAP
+static inline void kunmap_flush_on_unmap(void *addr)
+{
+	flush_kernel_dcache_page_addr(addr);
+}
+
 extern void copy_to_user_page(struct vm_area_struct *vma,
 	struct page *page, unsigned long vaddr, void *dst, const void *src,
 	unsigned long len);
diff --git a/drivers/crypto/omap-crypto.c b/drivers/crypto/omap-crypto.c
index 94b2dba90f0d..cbc5a4151c3c 100644
--- a/drivers/crypto/omap-crypto.c
+++ b/drivers/crypto/omap-crypto.c
@@ -183,9 +183,6 @@ static void omap_crypto_copy_data(struct scatterlist *src,
 
 		memcpy(dstb, srcb, amt);
 
-		if (!PageSlab(sg_page(dst)))
-			flush_kernel_dcache_page(sg_page(dst));
-
 		kunmap_atomic(srcb);
 		kunmap_atomic(dstb);
 
diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 9776a03a10f5..e1aafbc6a0a1 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -947,9 +947,6 @@ mmc_spi_data_do(struct mmc_spi_host *host, struct mmc_command *cmd,
 				break;
 		}
 
-		/* discard mappings */
-		if (direction == DMA_FROM_DEVICE)
-			flush_kernel_dcache_page(sg_page(sg));
 		kunmap(sg_page(sg));
 		if (dma_dev)
 			dma_unmap_page(dma_dev, dma_addr, PAGE_SIZE, dir);
diff --git a/drivers/scsi/aacraid/aachba.c b/drivers/scsi/aacraid/aachba.c
index f1f62b5da8b7..8897d4ad78c6 100644
--- a/drivers/scsi/aacraid/aachba.c
+++ b/drivers/scsi/aacraid/aachba.c
@@ -25,7 +25,6 @@
 #include <linux/completion.h>
 #include <linux/blkdev.h>
 #include <linux/uaccess.h>
-#include <linux/highmem.h> /* For flush_kernel_dcache_page */
 #include <linux/module.h>
 
 #include <asm/unaligned.h>
diff --git a/fs/exec.c b/fs/exec.c
index 18594f11c31f..da9faa2da36b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -577,7 +577,6 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 				}
 
 				if (kmapped_page) {
-					flush_kernel_dcache_page(kmapped_page);
 					kunmap(kmapped_page);
 					put_arg_page(kmapped_page);
 				}
@@ -595,7 +594,6 @@ static int copy_strings(int argc, struct user_arg_ptr argv,
 	ret = 0;
 out:
 	if (kmapped_page) {
-		flush_kernel_dcache_page(kmapped_page);
 		kunmap(kmapped_page);
 		put_arg_page(kmapped_page);
 	}
@@ -637,7 +635,6 @@ int copy_string_kernel(const char *arg, struct linux_binprm *bprm)
 		kaddr = kmap_atomic(page);
 		flush_arg_page(bprm, pos & PAGE_MASK, page);
 		memcpy(kaddr + offset_in_page(pos), arg, bytes_to_copy);
-		flush_kernel_dcache_page(page);
 		kunmap_atomic(kaddr);
 		put_arg_page(page);
 	}
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 832b49b50c7b..7ef83bf52a6c 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -131,9 +131,6 @@ static inline void flush_anon_page(struct vm_area_struct *vma, struct page *page
 #endif
 
 #ifndef ARCH_HAS_FLUSH_KERNEL_DCACHE_PAGE
-static inline void flush_kernel_dcache_page(struct page *page)
-{
-}
 static inline void flush_kernel_vmap_range(void *vaddr, int size)
 {
 }
diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index a59778946404..579b323a8042 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -887,10 +887,6 @@ void sg_miter_stop(struct sg_mapping_iter *miter)
 		miter->__offset += miter->consumed;
 		miter->__remaining -= miter->consumed;
 
-		if ((miter->__flags & SG_MITER_TO_SG) &&
-		    !PageSlab(miter->page))
-			flush_kernel_dcache_page(miter->page);
-
 		if (miter->__flags & SG_MITER_ATOMIC) {
 			WARN_ON_ONCE(preemptible());
 			kunmap_atomic(miter->addr);
-- 
2.28.0.rc0.12.gb6a658bd00c9

