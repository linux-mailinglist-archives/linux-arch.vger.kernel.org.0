Return-Path: <linux-arch+bounces-399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CDAD7F5295
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4DD0EB20D6B
	for <lists+linux-arch@lfdr.de>; Wed, 22 Nov 2023 21:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AD61C2B9;
	Wed, 22 Nov 2023 21:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntADCO52"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FC51A4;
	Wed, 22 Nov 2023 13:31:12 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cf6af8588fso1917155ad.0;
        Wed, 22 Nov 2023 13:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700688671; x=1701293471; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8YHcJrVA3B+7BnFIZDKn+9VseQtxV3EDqLRBy0nrns=;
        b=ntADCO52YtfU9Ay4pXk2kO8EsKzo8ru6sncQi/EPni5ilXwMlJNXPKRVZQOv+dUM7Z
         VOPAuhNCLuEoPp0nHDca06lyzMufoeF00lZLycn+F4jTg+xArCVmK29I426D+A330hBo
         nhcakz3rDG64zsMvbPrXqkvnGaMMpd+PdGa2m5I5G7C6sdly0TY/PqWy/oqoyXGaJV+U
         8shUBQ9xwL4MXPquBymLz2an/i6OJ3LGoynNG/koWnHrXdlzKY259ZOSz57bvK6ItA/P
         IZDG30spBgSDUkKYdqMODjp4r3WdZ13uh9BNFz67Q5mPGiR6yTA9rMU/Vb+iPD4qmZNU
         WhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700688671; x=1701293471;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T8YHcJrVA3B+7BnFIZDKn+9VseQtxV3EDqLRBy0nrns=;
        b=tl9cN1VoS1EJDgJ0IwFNva7+MTQ+sPLvhRpwYt57fOf2FypTRWdfoKjI/xonGr5DVn
         Cysdm3Qoo0fHo2RQUd+55imPCrkv8XRR5NdW/7Y9E8PBalpLiSuzbaJEa28HmkmSiQql
         i3FF4RUFaU8vbZlzhd9R1BEUFGMzuImcM1JxOTcqPSVn7HYktZtS7aKhIkPG28FgU+AA
         DaQ6og6DGNkOLzwUr4hSQR1MW1Ye1h1gnCmnLUbmHFMofRYgEPShQox1efyJEqoEvAdx
         XjtIvKCgNyW62CFYXwAUrS0NJy/4iI+99UYk0UhxQQQ1o3xofWWTHftOy3uJnG7WQLB3
         oDIw==
X-Gm-Message-State: AOJu0Yy24aU/7SW3/FTkgjQd1wqLSVaAy4r+wHltXCoCS1b6hV3vkaS4
	+McNLqSDO/9im7BLrqrtdfA=
X-Google-Smtp-Source: AGHT+IHMpg50GDCHwxIzCQw+0Xu3Qk1HhYDZWqMBovoQdAPUyBcR0iK37BF2NuSlokSb3jjoQ3/KiQ==
X-Received: by 2002:a17:903:1207:b0:1cc:53d1:10b8 with SMTP id l7-20020a170903120700b001cc53d110b8mr4168520plh.50.1700688671321;
        Wed, 22 Nov 2023 13:31:11 -0800 (PST)
Received: from r13-u19.micron.com ([165.225.243.112])
        by smtp.gmail.com with ESMTPSA id jl13-20020a170903134d00b001c736746d33sm134845plb.217.2023.11.22.13.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:31:10 -0800 (PST)
Date: Wed, 22 Nov 2023 15:31:05 -0600
From: Vinicius Petrucci <vpetrucci@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-mm@vger.kernel.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-api@vger.kernel.org, minchan@kernel.org,
	dave.hansen@linux.intel.com, x86@kernel.org,
	Jonathan.Cameron@huawei.com, aneesh.kumar@linux.ibm.com,
	gregory.price@memverge.com, ying.huang@intel.com,
	dan.j.williams@intel.com, hezhongkun.hzk@bytedance.com,
	fvdl@google.com, surenb@google.com, rientjes@google.com,
	hannes@cmpxchg.org, mhocko@suse.com, Hasan.Maruf@amd.com,
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com,
	emirakhur@micron.com, vtavarespetr@micron.com
Subject: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for external
 memory binding
Message-ID: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>

This patch introduces `process_mbind()` to enable a userspace orchestrator with 
an understanding of another process's memory layout to alter its memory policy. 
As system memory configurations become more and more complex (e.g., DDR+HBM+CXL memories), 
such a userspace orchestrator can explore more advanced techniques to guide memory placement
to individual NUMA nodes across memory tiers. This allows for a more efficient allocation of 
memory resources, leading to enhanced application performance.

Alternatively, there are existing methods such as LD_PRELOAD (https://pmem.io/memkind/) or
syscall_intercept (https://github.com/pmem/syscall_intercept), but these techniques, beyond the
lack of portability/universality, can lead to system incompatibility issues, inconsistency in
application behavior, potential risks due to global system-wide settings, and increased
complexity in implementation.

The concept of an external entity that understands the layout of another process's VM 
is already present with `process_madvise()`. Thus, it seems reasonable to introduce 
the `process_mbind` variant of `mbind`. The implementation framework of `process_mbind()` 
is akin to `process_madvise()`. It uses pidfd of an external process to direct the memory 
policy and supports a vector of memory address ranges.

The general use case here is similar to the prior RFC `pidfd_set_mempolicy()` 
(https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk@bytedance.com/), 
but offers a more fine-grained external control by binding specific memory regions 
(say, heap data structures) to specific NUMA nodes. Another concrete use case was described 
by a prior work showing up to 2X runtime improvement (compared to AutoNUMA tiering) using
memory object/region-based memory placement for workloads with irregular access patterns
such as graph analytics: https://iiswc.org/iiswc2022/IISWC2022_42.pdf

The proposed API is as follows:

long process_mbind(int pidfd, 
                const struct iovec *iovec, 
                unsigned long vlen, 
                unsigned long mode, 
                const unsigned long *nmask,
                unsigned int flags);

The `pidfd` argument is used to select the process that is identified by the PID file 
descriptor provided in pidfd. (See pidofd_open(2) for more information)

The pointer `iovec` points to an array of iovec structures (as described in <sys/uio.h>):

struct iovec {
    void *iov_base;         /* starting address of region */
    size_t iov_len;         /* size of region (in bytes) */
};

The `iovec` defines memory regions that start at the address (iov_base) and 
have a size measured in bytes (iov_len).

The `vlen` indicates the quantity of elements contained in iovec.

Please note the initial `maxnode` parameter from `mbind` was omitted 
to ensure the API doesn't exceed 6 arguments. Instead, the constant 
MAX_NUMNODES was utilized.

Please see the mbind(2) man page for more details about other's arguments.

Additionally, it is worth noting the following:
- Using a vector of address ranges as an argument in `process_mbind` provides more 
flexibility than the original `mbind` system call, even when invoked from a current
or local process.
- In contrast to `move_pages`, which requires an array of fixed-size pages,
`process_mbind` (with flags MPOL_MF_MOVE*) offers a more convinient and flexible page
migration capability on a per object or region basis.
- Similar to `process_madvise`, manipulating the memory binding of external processes
necessitates `CAP_SYS_NICE` and `PTRACE_MODE_READ_FSCREDS` checks (refer to ptrace(2)).

Suggested-by: Frank van der Linden <fvdl@google.com>
Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
Signed-off-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
---
 arch/x86/entry/syscalls/syscall_64.tbl |  1 +
 include/linux/syscalls.h               |  4 ++
 include/uapi/asm-generic/unistd.h      |  4 +-
 kernel/sys_ni.c                        |  1 +
 mm/mempolicy.c                         | 86 +++++++++++++++++++++++++-
 5 files changed, 92 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8cb8bf68721c..9d9db49a3242 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -378,6 +378,7 @@
 454	common	futex_wake		sys_futex_wake
 455	common	futex_wait		sys_futex_wait
 456	common	futex_requeue		sys_futex_requeue
+457	common	process_mbind		sys_process_mbind
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index fd9d12de7e92..def5250ed625 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -816,6 +816,10 @@ asmlinkage long sys_mbind(unsigned long start, unsigned long len,
 				const unsigned long __user *nmask,
 				unsigned long maxnode,
 				unsigned flags);
+asmlinkage long sys_process_mbind(int pidfd, const struct iovec __user *vec,
+				size_t vlen, unsigned long mode,
+				const unsigned long __user *nmask,
+				unsigned flags);
 asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long __user *nmask,
 				unsigned long maxnode,
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 756b013fb832..9ed2c91940d6 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
 __SYSCALL(__NR_futex_wait, sys_futex_wait)
 #define __NR_futex_requeue 456
 __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
+#define __NR_process_mbind 457
+__SYSCALL(__NR_process_mbind, sys_process_mbind)
 
 #undef __NR_syscalls
-#define __NR_syscalls 457
+#define __NR_syscalls 458
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
index e1a6e3c675c0..cc5cb5ae3ae7 100644
--- a/kernel/sys_ni.c
+++ b/kernel/sys_ni.c
@@ -187,6 +187,7 @@ COND_SYSCALL(process_madvise);
 COND_SYSCALL(process_mrelease);
 COND_SYSCALL(remap_file_pages);
 COND_SYSCALL(mbind);
+COND_SYSCALL(process_mbind);
 COND_SYSCALL(get_mempolicy);
 COND_SYSCALL(set_mempolicy);
 COND_SYSCALL(migrate_pages);
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 10a590ee1c89..91ee300fa728 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1215,11 +1215,10 @@ static struct folio *alloc_migration_target_by_mpol(struct folio *src,
 }
 #endif
 
-static long do_mbind(unsigned long start, unsigned long len,
+static long do_mbind(struct mm_struct *mm, unsigned long start, unsigned long len,
 		     unsigned short mode, unsigned short mode_flags,
 		     nodemask_t *nmask, unsigned long flags)
 {
-	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma, *prev;
 	struct vma_iterator vmi;
 	struct migration_mpol mmpol;
@@ -1465,10 +1464,84 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	return 0;
 }
 
+static long kernel_mbind_process(int pidfd, const struct iovec __user *vec,
+		size_t vlen, unsigned long mode,
+		const unsigned long __user *nmask, unsigned int flags)
+{
+	ssize_t ret;
+	struct iovec iovstack[UIO_FASTIOV];
+	struct iovec *iov = iovstack;
+	struct iov_iter iter;
+	struct task_struct *task;
+	struct mm_struct *mm;
+	unsigned int f_flags;
+	unsigned short mode_flags;
+	int lmode = mode;
+	unsigned long maxnode = MAX_NUMNODES;
+	int err;
+	nodemask_t nodes;
+
+	err = sanitize_mpol_flags(&lmode, &mode_flags);
+	if (err)
+		goto out;
+
+	err = get_nodes(&nodes, nmask, maxnode);
+	if (err)
+		goto out;
+
+	ret = import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack),
+			&iov, &iter);
+	if (ret < 0)
+		goto out;
+
+	task = pidfd_get_task(pidfd, &f_flags);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_iov;
+	}
+
+	/* From process_madvise: Require PTRACE_MODE_READ
+	 * to avoid leaking ASLR metadata. */
+	mm = mm_access(task, PTRACE_MODE_READ_FSCREDS);
+	if (IS_ERR_OR_NULL(mm)) {
+		ret = IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
+		goto release_task;
+	}
+
+	/* From process_madvise: Require CAP_SYS_NICE for
+	 * influencing process performance. */
+	if (!capable(CAP_SYS_NICE)) {
+		ret = -EPERM;
+		goto release_mm;
+	}
+
+	while (iov_iter_count(&iter)) {
+		unsigned long start = untagged_addr(
+				(unsigned long)iter_iov_addr(&iter));
+		unsigned long len = iter_iov_len(&iter);
+
+		ret = do_mbind(mm, start, len, lmode, mode_flags,
+				&nodes, flags);
+		if (ret < 0)
+			break;
+		iov_iter_advance(&iter, iter_iov_len(&iter));
+	}
+
+release_mm:
+	mmput(mm);
+release_task:
+	put_task_struct(task);
+free_iov:
+	kfree(iov);
+out:
+	return ret;
+}
+
 static long kernel_mbind(unsigned long start, unsigned long len,
 			 unsigned long mode, const unsigned long __user *nmask,
 			 unsigned long maxnode, unsigned int flags)
 {
+	struct mm_struct *mm = current->mm;
 	unsigned short mode_flags;
 	nodemask_t nodes;
 	int lmode = mode;
@@ -1483,7 +1556,7 @@ static long kernel_mbind(unsigned long start, unsigned long len,
 	if (err)
 		return err;
 
-	return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
+	return do_mbind(mm, start, len, lmode, mode_flags, &nodes, flags);
 }
 
 SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, len,
@@ -1553,6 +1626,13 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned long, le
 	return err;
 }
 
+SYSCALL_DEFINE6(process_mbind, int, pidfd, const struct iovec __user *, vec,
+		size_t, vlen, unsigned long, mode,
+		const unsigned long __user *, nmask, unsigned int, flags)
+{
+	return kernel_mbind_process(pidfd, vec, vlen, mode, nmask, flags);
+}
+
 SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
 		unsigned long, mode, const unsigned long __user *, nmask,
 		unsigned long, maxnode, unsigned int, flags)
-- 
2.41.0


