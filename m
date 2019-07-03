Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DBBB5E3BE
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2019 14:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfGCMYC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Jul 2019 08:24:02 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35124 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfGCMYC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Jul 2019 08:24:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dGgF55hFtmmmZc+ieAzS4XO99ZIShl4dVYuogqe2WpY=; b=MUd+Y8oY0cjPM7Ngrrh+1QbvVl
        Iw7GC+wh6WoOk+ROg6w0IVi1yeZnewXKsyHD94h3+H+Ffm6j4+AZ3ZfmDOClO0oeEPCDaGD34se6z
        GV0q3TmKG1k6TxqbQk0XfKokArCLw7Wk/4mphZyt39WFQrIU4fMPt6lt3xkPfPcPB5PbPuBi10Zkh
        1/4+r8JCURCHFpcv7VSmaEv/gFbUZTXz7BqcMFPC35ZpJCyrFhqDsnGTzm+KsVRosQ7jfMNCYvpMR
        VfCCGCghP2oSG5KB90hF+LtbuxRmLjlEj9S/xC+lP1nRbuj0puic+0MpzE6pZa7KX41QhSdkIg52N
        GBd14KhA==;
Received: from [12.46.110.2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hieIp-0002Fp-Lr; Wed, 03 Jul 2019 12:23:59 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-riscv@lists.infradead.org,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Vladimir Murzin <vladimir.murzin@arm.com>
Subject: [PATCH 1/3] mm: fix the MAP_UNINITIALIZED flag
Date:   Wed,  3 Jul 2019 05:23:57 -0700
Message-Id: <20190703122359.18200-2-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190703122359.18200-1-hch@lst.de>
References: <20190703122359.18200-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We can't expose UAPI symbols differently based on CONFIG_ symbols, as
userspace won't have them available.  Instead always define the flag,
but only respect it based on the config option.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 arch/xtensa/include/uapi/asm/mman.h    | 6 +-----
 include/uapi/asm-generic/mman-common.h | 8 +++-----
 mm/nommu.c                             | 4 +++-
 3 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/uapi/asm/mman.h
index be726062412b..ebbb48842190 100644
--- a/arch/xtensa/include/uapi/asm/mman.h
+++ b/arch/xtensa/include/uapi/asm/mman.h
@@ -56,12 +56,8 @@
 #define MAP_STACK	0x40000		/* give out an address that is best suited for process/thread stacks */
 #define MAP_HUGETLB	0x80000		/* create a huge page mapping */
 #define MAP_FIXED_NOREPLACE 0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
 					 * uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
 
 /*
  * Flags for msync
diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-generic/mman-common.h
index abd238d0f7a4..cb556b430e71 100644
--- a/include/uapi/asm-generic/mman-common.h
+++ b/include/uapi/asm-generic/mman-common.h
@@ -19,15 +19,13 @@
 #define MAP_TYPE	0x0f		/* Mask for type of mapping */
 #define MAP_FIXED	0x10		/* Interpret addr exactly */
 #define MAP_ANONYMOUS	0x20		/* don't use a file */
-#ifdef CONFIG_MMAP_ALLOW_UNINITIALIZED
-# define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be uninitialized */
-#else
-# define MAP_UNINITIALIZED 0x0		/* Don't support this flag */
-#endif
 
 /* 0x0100 - 0x80000 flags are defined in asm-generic/mman.h */
 #define MAP_FIXED_NOREPLACE	0x100000	/* MAP_FIXED which doesn't unmap underlying mapping */
 
+#define MAP_UNINITIALIZED 0x4000000	/* For anonymous mmap, memory could be
+					 * uninitialized */
+
 /*
  * Flags for mlock
  */
diff --git a/mm/nommu.c b/mm/nommu.c
index d8c02fbe03b5..ec75a0dffd4f 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -1349,7 +1349,9 @@ unsigned long do_mmap(struct file *file,
 	add_nommu_region(region);
 
 	/* clear anonymous mappings that don't ask for uninitialized data */
-	if (!vma->vm_file && !(flags & MAP_UNINITIALIZED))
+	if (!vma->vm_file &&
+	    (!IS_ENABLED(CONFIG_MMAP_ALLOW_UNINITIALIZED) ||
+	     !(flags & MAP_UNINITIALIZED)))
 		memset((void *)region->vm_start, 0,
 		       region->vm_end - region->vm_start);
 
-- 
2.20.1

