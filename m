Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406FB7B5E1E
	for <lists+linux-arch@lfdr.de>; Tue,  3 Oct 2023 02:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbjJCAWT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 20:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjJCAWJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 20:22:09 -0400
Received: from mail-oa1-x43.google.com (mail-oa1-x43.google.com [IPv6:2001:4860:4864:20::43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F6FAB;
        Mon,  2 Oct 2023 17:22:05 -0700 (PDT)
Received: by mail-oa1-x43.google.com with SMTP id 586e51a60fabf-1e141f543b2so1827081fac.1;
        Mon, 02 Oct 2023 17:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696292525; x=1696897325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GzhlmCAeBw7LKDJVS9wKgjhn+zSbvnR0xVFbPBNPM68=;
        b=UzQTviRDU03JWdFehMvmA4EbpmQt4Gr00LHo+koA/i71HT/L7dep7tu1ZUrRHJEHAs
         71HafbN3F4MZTK9hFX0EpWFgGs8zK4CsjXPKGkl++q02QG0NShCDF8DS3k6F2EpojXMp
         9jYC9nSrKMPlM5Qjeo0qsEb9G/twwuPWIJP1BH9vEPwnPPfTW+Z8Gkv4ConN9GZ8hWX2
         dQzwXLivo5Dx4wDEg75d2EOMY+yzSt8uhz0WGtAW1rSOea35m9SfqLbnk9wRkmYq1BPy
         2PUS2IjemG/9e3IgnOUrXq+0LXwVsnRhc3wW5W+lOTmwR6213YxUwWrEW8QabO1mPI14
         TAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696292525; x=1696897325;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GzhlmCAeBw7LKDJVS9wKgjhn+zSbvnR0xVFbPBNPM68=;
        b=jK8l3TPMsbtFHDJKtPqvFerfE0vi3iTEDU9VsNWHc82fXDYnWMxqGFfUXWZUPPwXct
         grotWUHe9c+5E60W3RuqRrvBWRHIHkYU0p43m9RyzPUtGKQy+SH55t6DL+wYDPChp9TP
         1uiDg08vdA2z61f3uKRuHJgq8Ng5iafF4+fbr98G2dVNGlP4MQmls4JeareE8WTUojOt
         1BoBtbKpTyT9ze6Leb5tmf6aqlY4zIvDofYwhzwabPhYbwHEy3SChryrHddK+xf2gt13
         fQS9v9Hm5qRTpxTsVpTISfU3I/5vPiUJmXr2ExC+4IzpXP+pepeJYIzyyCsUuzWAIiZ3
         xlWg==
X-Gm-Message-State: AOJu0YyQ7JwsKzq5p07MXH2SFfbjLb5WGOeymQL7z5WyuxK/yN/VmVqI
        hUEzaV6fB1/vMVFq14IGfQ==
X-Google-Smtp-Source: AGHT+IEj9tKN67uLDs72Qn+I8fAd0j4gDX1bLRCTXKGugvdnF3kTPlMMBmDjkvf1TbX7SGX5Xn4zaA==
X-Received: by 2002:a05:6870:e611:b0:1d7:1a69:5056 with SMTP id q17-20020a056870e61100b001d71a695056mr629626oag.14.1696292524806;
        Mon, 02 Oct 2023 17:22:04 -0700 (PDT)
Received: from fedora.mshome.net (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id a2-20020a056870618200b001e135f4f849sm24725oah.9.2023.10.02.17.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 17:22:04 -0700 (PDT)
From:   Gregory Price <gourry.memverge@gmail.com>
X-Google-Original-From: Gregory Price <gregory.price@memverge.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, linux-cxl@vger.kernel.org,
        luto@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        arnd@arndb.de, akpm@linux-foundation.org, x86@kernel.org,
        Gregory Price <gregory.price@memverge.com>
Subject: [RFC PATCH v2 2/4] mm/mempolicy: Implement set_mempolicy2 and
Date:   Mon,  2 Oct 2023 20:21:54 -0400
Message-Id: <20231003002156.740595-3-gregory.price@memverge.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20231003002156.740595-1-gregory.price@memverge.com>
References: <20231003002156.740595-1-gregory.price@memverge.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 include/linux/syscalls.h               |   4 +
 include/uapi/asm-generic/unistd.h      |  10 +-
 include/uapi/linux/mempolicy.h         |  29 ++++
 mm/mempolicy.c                         | 196 ++++++++++++++++++++++++-
 6 files changed, 241 insertions(+), 2 deletions(-)

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
index 22bc6bc147f8..0c4a71177df9 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -813,6 +813,10 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
 				unsigned long addr, unsigned long flags);
 asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
 				unsigned long maxnode);
+asmlinkage long sys_get_mempolicy2(struct mempolicy_args __user *args,
+				   size_t size);
+asmlinkage long sys_set_mempolicy2(struct mempolicy_args __user *args,
+				   size_t size);
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
index 046d0ccba4cd..ea386872094b 100644
--- a/include/uapi/linux/mempolicy.h
+++ b/include/uapi/linux/mempolicy.h
@@ -23,9 +23,38 @@ enum {
 	MPOL_INTERLEAVE,
 	MPOL_LOCAL,
 	MPOL_PREFERRED_MANY,
+	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
 	MPOL_MAX,	/* always last member of enum */
 };
 
+struct mempolicy_args {
+	unsigned short mode;
+	unsigned long *nodemask;
+	unsigned long maxnode;
+	unsigned short flags;
+	struct {
+		/* Memory allowed */
+		struct {
+			unsigned long maxnode;
+			unsigned long *nodemask;
+		} allowed;
+		/* Address information */
+		struct {
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
index ad26f41b91de..936c641f554e 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1478,7 +1478,7 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
 	*flags = *mode & MPOL_MODE_FLAGS;
 	*mode &= ~MPOL_MODE_FLAGS;
 
-	if ((unsigned int)(*mode) >=  MPOL_MAX)
+	if ((unsigned int)(*mode) >= MPOL_LEGACY)
 		return -EINVAL;
 	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
 		return -EINVAL;
@@ -1609,6 +1609,200 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
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
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	switch (args->mode) {
+	default:
+		BUG();
+	}
+
+	if (err)
+		goto out;
+
+	err = replace_mempolicy(new, &nodes);
+out:
+	if (err)
+		mpol_put(new);
+	return err;
+};
+
+static bool mempolicy2_args_valid(struct mempolicy_args *kargs)
+{
+	/* Legacy modes are routed through the legacy interface */
+	return kargs->mode > MPOL_LEGACY && kargs->mode < MPOL_MAX;
+}
+
+static long kernel_set_mempolicy2(const struct mempolicy_args __user *uargs,
+				  size_t usize)
+{
+	struct mempolicy_args kargs;
+	int err;
+
+	if (usize < sizeof(kargs))
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
+	int rc = 0;
+
+	kargs->mode = pol->mode;
+	/* Mask off internal flags */
+	kargs->flags = pol->flags & MPOL_MODE_FLAGS;
+
+	if (kargs->nodemask) {
+		if (mpol_store_user_nodemask(pol)) {
+			knodes = pol->w.user_nodemask;
+		} else {
+			task_lock(current);
+			get_policy_nodemask(pol, &knodes);
+			task_unlock(current);
+		}
+		rc = copy_nodes_to_user(kargs->nodemask, kargs->maxnode,
+					&knodes);
+		if (rc)
+			return rc;
+	}
+
+
+	if (kargs->get.allowed.nodemask) {
+		task_lock(current);
+		knodes = cpuset_current_mems_allowed;
+		task_unlock(current);
+		rc = copy_nodes_to_user(kargs->get.allowed.nodemask,
+					kargs->get.allowed.maxnode,
+					&knodes);
+		if (rc)
+			return rc;
+	}
+
+	if (kargs->get.addr.addr) {
+		struct mempolicy *addr_pol;
+		struct vm_area_struct *vma;
+		struct mm_struct *mm = current->mm;
+		unsigned long addr = kargs->get.addr.addr;
+
+		/*
+		 * Do NOT fall back to task policy if the vma/shared policy
+		 * at addr is NULL. Return MPOL_DEFAULT in this case.
+		 */
+		mmap_read_lock(mm);
+		vma = vma_lookup(mm, addr);
+		if (!vma) {
+			mmap_read_unlock(mm);
+			return -EFAULT;
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
+		rc = lookup_node(mm, addr);
+		mpol_put(addr_pol);
+		if (rc < 0)
+			return rc;
+		kargs->get.addr.node = rc;
+	}
+
+	switch (kargs->mode) {
+	case MPOL_INTERLEAVE:
+		kargs->interleave.next_node = next_node_in(current->il_prev,
+							   pol->nodes);
+		rc = 0;
+		break;
+	default:
+		BUG();
+	}
+
+	return rc;
+}
+
+static long kernel_get_mempolicy2(struct mempolicy_args __user *uargs,
+				  size_t usize)
+{
+	struct mempolicy_args kargs;
+	int err;
+
+	if (usize < sizeof(kargs))
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
+	err = copy_to_user(uargs, &kargs, sizeof(kargs));
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

