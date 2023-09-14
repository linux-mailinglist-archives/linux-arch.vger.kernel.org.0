Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369767A120E
	for <lists+linux-arch@lfdr.de>; Fri, 15 Sep 2023 01:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbjINXzO (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Sep 2023 19:55:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjINXzJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 14 Sep 2023 19:55:09 -0400
Received: from mail-yw1-x1143.google.com (mail-yw1-x1143.google.com [IPv6:2607:f8b0:4864:20::1143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E20B269D;
        Thu, 14 Sep 2023 16:55:05 -0700 (PDT)
Received: by mail-yw1-x1143.google.com with SMTP id 00721157ae682-59be8a2099bso17217437b3.0;
        Thu, 14 Sep 2023 16:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694735704; x=1695340504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU+YVbdee9/ukrVxBlOoXUecIi7N3xBmAGT5Qfkumcc=;
        b=cbQCwrfGbWoRFwRkZs4UzAKzst9w2aGQiSQAh1P0asDxKju2fgVJbGBHho01IHnLaK
         lRpTmgdmNK0RfM6L4Eu26lspT4awBVGAWmI4Cz8fW2z5ByZVuMTtxGDMaVV4o6yxmsYC
         CaRSj1dCP01/ZRp6uNLczjW/C4j4Iq0sBu8Mm5tyHrwyOX5CaWkOgHkanqJl0887f3XD
         YN7xVPYd8ZtHQn92wuSfVJjyQRb0OJRFW19CBy5R51nzuzglPt8tKu5lnfRBc/d6s9l5
         6WYsTbomsSNj/WwYL65b3CXfW7kf0imBAeSh7234uRK776hS9ky+5S1nENuNpawx6sye
         tldQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694735704; x=1695340504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU+YVbdee9/ukrVxBlOoXUecIi7N3xBmAGT5Qfkumcc=;
        b=HQzolTuqxha/JXwxSDSqYXVElWbKMmI5koLRT44IpRrFopz46pRPBgyCnUkpIwqQSa
         Adh2XUXGfWs9JPtFCF74MHzihAJDmasZPfJ3vEQHie2X1qT9BnR+HABNUb7apx+6CxKD
         CwFu4mZL7KgdHaLZcl2Gc0VTJQgnzONUl9VPnQIhcEDWZx3ht07ZDo9O5/1SMcElA1ca
         SFFGBT4e1d/suHjUN4jDwyC3YtDVzhPf445W/06Fa16uSJV5LsivCtCA5trPJ0j0gVCN
         WMw6Sv7WN1s2uzpnK/P9COasfPoGSV/8Lj2WUXLqXHq14EWQSbyNNnj/1M8r150foskd
         wztg==
X-Gm-Message-State: AOJu0YyrRc+Km9NalgqDLhVs/0jLjSlEc+3GFqllyVZkmva4umwUdZ9N
        TX3cKKGVN9vbpoh2Mis6ayhP7bfphnlA
X-Google-Smtp-Source: AGHT+IG2b5asOwO5McNRji9qTvhU4BwgyLPo8o0Gp+z/U9++NsjhOfUOITAqDujgPXwuSv1ZjOwhbg==
X-Received: by 2002:a81:a54a:0:b0:589:eec9:a7e8 with SMTP id v10-20020a81a54a000000b00589eec9a7e8mr197202ywg.38.1694735704168;
        Thu, 14 Sep 2023 16:55:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id p188-20020a0dcdc5000000b005777a2c356asm586300ywd.65.2023.09.14.16.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 16:55:03 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH 2/3] mm/mempolicy: Implement set_mempolicy2 and get_mempolicy2 syscalls
Date:   Thu, 14 Sep 2023 19:54:56 -0400
Message-Id: <20230914235457.482710-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230914235457.482710-1-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

sys_set_mempolicy is limited by its current argument structure
(mode, nodes, flags) to implementing policies that can be described
in that manner.

Implement set/get_mempolicy2 with a new mempolicy_args structure
which encapsulates the old behavior, and allows for new mempolicies
which may require additional information.

Signed-off-by: Gregory Price <gregory.price@memverge.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl |   2 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/syscalls.h               |   2 +
 include/uapi/asm-generic/unistd.h      |  10 +-
 include/uapi/linux/mempolicy.h         |  32 ++++
 mm/mempolicy.c                         | 215 ++++++++++++++++++++++++-
 6 files changed, 261 insertions(+), 2 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2d0b1bd866ea..a72ef588a704 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -457,3 +457,5 @@
 450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
 451	i386	cachestat		sys_cachestat
 452	i386	fchmodat2		sys_fchmodat2
+454	i386	set_mempolicy2		sys_set_mempolicy2
+455	i386	get_mempolicy2		sys_get_mempolicy2
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 1d6eee30eceb..ec54064de8b3 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -375,6 +375,8 @@
 451	common	cachestat		sys_cachestat
 452	common	fchmodat2		sys_fchmodat2
 453	64	map_shadow_stack	sys_map_shadow_stack
+454	common	set_mempolicy2		sys_set_mempolicy2
+455	common	get_mempolicy2		sys_get_mempolicy2
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 22bc6bc147f8..d50a452954ae 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -813,6 +813,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
+asmlinkage long sys_get_mempolicy2(struct mempolicy_args __user *args);
+asmlinkage long sys_set_mempolicy2(struct mempolicy_args __user *args);
 asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *from,
 				const unsigned long __user *to);
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index abe087c53b4b..397dcf804941 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -823,8 +823,16 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
 #define __NR_fchmodat2 452
 __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
 
+/* CONFIG_MMU only */
+#ifndef __ARCH_NOMMU
+#define __NR_set_mempolicy 454
+__SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
+#define __NR_set_mempolicy 455
+__SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
+#endif
+
 #undef __NR_syscalls
-#define __NR_syscalls 453
+#define __NR_syscalls 456
 
 /*
  * 32 bit systems traditionally used different
diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
index 046d0ccba4cd..53650f69db2b 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -23,9 +23,41 @@ enum {
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
+	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mempolicy_args {
+	int err;
+	unsigned short mode;
+	unsigned long *nodemask;
+	unsigned long maxnode;
+	unsigned short flags;
+	struct {
+		/* Memory allowed */
+		struct {
+			int err;
+			unsigned long maxnode;
+			unsigned long *nodemask;
+		} allowed;
+		/* Address information */
+		struct {
+			int err;
+			unsigned long addr;
+			unsigned long node;
+			unsigned short mode;
+			unsigned short flags;
+		} addr;
+		/* Interleave */
+	} get;
+	/* Mode specific settings */
+	union {
+		struct {
+			unsigned long next_node; /* get only */
+		} interleave;
+	};
+};
+
 /* Flags for set_mempolicy */
 #define MPOL_F_STATIC_NODES	(1 << 15)
 #define MPOL_F_RELATIVE_NODES	(1 << 14)
diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index f49337f6f300..1cf7709400f1 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1483,7 +1483,7 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	*flags = *mode & MPOL_MODE_FLAGS;
 	*mode &= ~MPOL_MODE_FLAGS;
 
-	if ((unsigned int)(*mode) >=  MPOL_MAX)
+	if ((unsigned int)(*mode) >= MPOL_LEGACY)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
@@ -1614,6 +1614,219 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
 	return kernel_set_mempolicy(mode, nmask, maxnode);
 }
 
+static long do_set_mempolicy2(struct mempolicy_args *args)
+{
+	struct mempolicy *new = NULL;
+	nodemask_t nodes;
+	int err;
+
+	if (args->mode <= MPOL_LEGACY)
+		return -EINVAL;
+
+	if (args->mode >= MPOL_MAX)
+		return -EINVAL;
+
+	err = get_nodes(&nodes, args->nodemask, args->maxnode);
+	if (err)
+		return err;
+
+	new = mpol_new(args->mode, args->flags, &nodes);
+	if (IS_ERR(new)) {
+		err = PTR_ERR(new);
+		goto out;
+	}
+
+	switch (args->mode) {
+	default:
+		BUG();
+	}
+
+	if (err)
+		goto out;
+
+	err = swap_mempolicy(new, &nodes);
+out:
+	if (err && new)
+		mpol_put(new);
+	return err;
+};
+
+static bool mempolicy2_args_valid(struct mempolicy_args *kargs)
+{
+	/* Legacy modes are routed through the legacy interface */
+	if (kargs->mode <= MPOL_LEGACY)
+		return false;
+
+	if (kargs->mode >= MPOL_MAX)
+		return false;
+
+	return true;
+}
+
+static long kernel_set_mempolicy2(const struct mempolicy_args __user *uargs,
+				  size_t usize)
+{
+	struct mempolicy_args kargs;
+	int err;
+
+	if (usize != sizeof(kargs))
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return err;
+
+	/* If the mode is legacy, use the legacy path */
+	if (kargs.mode < MPOL_LEGACY) {
+		int legacy_mode = kargs.mode | kargs.flags;
+		const unsigned long __user *lnmask = kargs.nodemask;
+		unsigned long maxnode = kargs.maxnode;
+
+		return kernel_set_mempolicy(legacy_mode, lnmask, maxnode);
+	}
+
+	if (!mempolicy2_args_valid(&kargs))
+		return -EINVAL;
+
+	return do_set_mempolicy2(&kargs);
+}
+
+SYSCALL_DEFINE2(set_mempolicy2, const struct mempolicy_args __user *, args,
+		size_t, size)
+{
+	return kernel_set_mempolicy2(args, size);
+}
+
+/* Gets extended mempolicy information */
+static long do_get_mempolicy2(struct mempolicy_args *kargs)
+{
+	struct mempolicy *pol = current->mempolicy;
+	nodemask_t knodes;
+	int err = 0;
+
+	kargs->err = 0;
+	kargs->mode = pol->mode;
+	/* Mask off internal flags */
+	kargs->flags = (pol->flags & MPOL_MODE_FLAGS);
+
+	if (kargs->nodemask) {
+		if (mpol_store_user_nodemask(pol)) {
+			knodes = pol->w.user_nodemask;
+		} else {
+			task_lock(current);
+			get_policy_nodemask(pol, &knodes);
+			task_unlock(current);
+		}
+		err = copy_nodes_to_user(kargs->nodemask,
+					 kargs->maxnode,
+					 &knodes);
+		if (err)
+			return -EINVAL;
+	}
+
+
+	if (kargs->get.allowed.nodemask) {
+		kargs->get.allowed.err = 0;
+		task_lock(current);
+		knodes = cpuset_current_mems_allowed;
+		task_unlock(current);
+		err = copy_nodes_to_user(kargs->get.allowed.nodemask,
+					 kargs->get.allowed.maxnode,
+					 &knodes);
+		kargs->get.allowed.err = err ? err : 0;
+		kargs->err |= err ? err : 1;
+	}
+
+	if (kargs->get.addr.addr) {
+		struct mempolicy *addr_pol = NULL;
+		struct vm_area_struct *vma = NULL;
+		struct mm_struct *mm = current->mm;
+		unsigned long addr = kargs->get.addr.addr;
+
+		kargs->get.addr.err = 0;
+
+		/*
+		 * Do NOT fall back to task policy if the
+		 * vma/shared policy at addr is NULL.  We
+		 * want to return MPOL_DEFAULT in this case.
+		 */
+		mmap_read_lock(mm);
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			mmap_read_unlock(mm);
+			kargs->get.addr.err = -EFAULT;
+			kargs->err |= err ? err : 2;
+			goto mode_info;
+		}
+		if (vma->vm_ops && vma->vm_ops->get_policy)
+			addr_pol = vma->vm_ops->get_policy(vma, addr);
+		else
+			addr_pol = vma->vm_policy;
+
+		kargs->get.addr.mode = addr_pol->mode;
+		/* Mask off internal flags */
+		kargs->get.addr.flags = (pol->flags & MPOL_MODE_FLAGS);
+
+		/*
+		 * Take a refcount on the mpol, because we are about to
+		 * drop the mmap_lock, after which only "pol" remains
+		 * valid, "vma" is stale.
+		 */
+		vma = NULL;
+		mpol_get(addr_pol);
+		mmap_read_unlock(mm);
+		err = lookup_node(mm, addr);
+		mpol_put(addr_pol);
+		if (err < 0) {
+			kargs->get.addr.err = err;
+			kargs->err |= err ? err : 4;
+			goto mode_info;
+		}
+		kargs->get.addr.node = err;
+	}
+
+mode_info:
+	switch (kargs->mode) {
+	case MPOL_INTERLEAVE:
+		kargs->interleave.next_node = next_node_in(current->il_prev,
+							   pol->nodes);
+		break;
+	default:
+		break;
+	}
+
+	return err;
+}
+
+static long kernel_get_mempolicy2(struct mempolicy_args __user *uargs,
+				  size_t usize)
+{
+	struct mempolicy_args kargs;
+	int err;
+
+	if (usize != sizeof(struct mempolicy_args))
+		return -EINVAL;
+
+	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
+	if (err)
+		return err;
+
+	/* Get the extended memory policy information (kargs.ext) */
+	err = do_get_mempolicy2(&kargs);
+	if (err)
+		return err;
+
+	err = copy_to_user(uargs, &kargs, sizeof(struct mempolicy_args));
+
+	return err;
+}
+
+SYSCALL_DEFINE2(get_mempolicy2, struct mempolicy_args __user *, policy,
+		size_t, size)
+{
+	return kernel_get_mempolicy2(policy, size);
+}
+
 static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
 				const unsigned long __user *old_nodes,
 				const unsigned long __user *new_nodes)
-- 
2.39.1

