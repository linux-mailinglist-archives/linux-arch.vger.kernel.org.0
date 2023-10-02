Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5A607B53FF
	for <lists+linux-arch@lfdr.de>; Mon,  2 Oct 2023 15:37:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237404AbjJBNaT (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Oct 2023 09:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbjJBNaT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Oct 2023 09:30:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 815D6B0;
        Mon,  2 Oct 2023 06:30:12 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RzhZr4M4Kz67jkV;
        Mon,  2 Oct 2023 21:27:32 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 2 Oct
 2023 14:30:09 +0100
Date:   Mon, 2 Oct 2023 14:30:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <linux-mm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arch@vger.kernel.org>, <linux-api@vger.kernel.org>,
        <linux-cxl@vger.kernel.org>, <luto@kernel.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
        <akpm@linux-foundation.org>, <x86@kernel.org>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [RFC PATCH 2/3] mm/mempolicy: Implement set_mempolicy2 and
 get_mempolicy2 syscalls
Message-ID: <20231002143008.000038ac@Huawei.com>
In-Reply-To: <20230914235457.482710-3-gregory.price@memverge.com>
References: <20230914235457.482710-1-gregory.price@memverge.com>
        <20230914235457.482710-3-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 14 Sep 2023 19:54:56 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> sys_set_mempolicy is limited by its current argument structure
> (mode, nodes, flags) to implementing policies that can be described
> in that manner.
> 
> Implement set/get_mempolicy2 with a new mempolicy_args structure
> which encapsulates the old behavior, and allows for new mempolicies
> which may require additional information.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
Some random comments inline.

Jonathan


> ---
>  arch/x86/entry/syscalls/syscall_32.tbl |   2 +
>  arch/x86/entry/syscalls/syscall_64.tbl |   2 +
>  include/linux/syscalls.h               |   2 +
>  include/uapi/asm-generic/unistd.h      |  10 +-
>  include/uapi/linux/mempolicy.h         |  32 ++++
>  mm/mempolicy.c                         | 215 ++++++++++++++++++++++++-
>  6 files changed, 261 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
> index 2d0b1bd866ea..a72ef588a704 100644
> --- a/arch/x86/entry/syscalls/syscall_32.tbl
> +++ b/arch/x86/entry/syscalls/syscall_32.tbl
> @@ -457,3 +457,5 @@
>  450	i386	set_mempolicy_home_node		sys_set_mempolicy_home_node
>  451	i386	cachestat		sys_cachestat
>  452	i386	fchmodat2		sys_fchmodat2
> +454	i386	set_mempolicy2		sys_set_mempolicy2
> +455	i386	get_mempolicy2		sys_get_mempolicy2
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> index 1d6eee30eceb..ec54064de8b3 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -375,6 +375,8 @@
>  451	common	cachestat		sys_cachestat
>  452	common	fchmodat2		sys_fchmodat2
>  453	64	map_shadow_stack	sys_map_shadow_stack
> +454	common	set_mempolicy2		sys_set_mempolicy2
> +455	common	get_mempolicy2		sys_get_mempolicy2
>  
>  #
>  # Due to a historical design error, certain syscalls are numbered differently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index 22bc6bc147f8..d50a452954ae 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -813,6 +813,8 @@ asmlinkage long sys_get_mempolicy(int __user *policy,
>  				unsigned long addr, unsigned long flags);
>  asmlinkage long sys_set_mempolicy(int mode, const unsigned long __user *nmask,
>  				unsigned long maxnode);
> +asmlinkage long sys_get_mempolicy2(struct mempolicy_args __user *args);
> +asmlinkage long sys_set_mempolicy2(struct mempolicy_args __user *args);
>  asmlinkage long sys_migrate_pages(pid_t pid, unsigned long maxnode,
>  				const unsigned long __user *from,
>  				const unsigned long __user *to);
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> index abe087c53b4b..397dcf804941 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -823,8 +823,16 @@ __SYSCALL(__NR_cachestat, sys_cachestat)
>  #define __NR_fchmodat2 452
>  __SYSCALL(__NR_fchmodat2, sys_fchmodat2)
>  
> +/* CONFIG_MMU only */
> +#ifndef __ARCH_NOMMU
> +#define __NR_set_mempolicy 454
> +__SYSCALL(__NR_set_mempolicy2, sys_set_mempolicy2)
> +#define __NR_set_mempolicy 455
> +__SYSCALL(__NR_get_mempolicy2, sys_get_mempolicy2)
> +#endif
> +
>  #undef __NR_syscalls
> -#define __NR_syscalls 453
> +#define __NR_syscalls 456
+3 for 2 additions?

>  
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/include/uapi/linux/mempolicy.h b/include/uapi/linux/mempolicy.h
> index 046d0ccba4cd..53650f69db2b 100644
> --- a/include/uapi/linux/mempolicy.h
> +++ b/include/uapi/linux/mempolicy.h
> @@ -23,9 +23,41 @@ enum {
>  	MPOL_INTERLEAVE,
>  	MPOL_LOCAL,
>  	MPOL_PREFERRED_MANY,
> +	MPOL_LEGACY,	/* set_mempolicy limited to above modes */
>  	MPOL_MAX,	/* always last member of enum */
>  };
>  
> +struct mempolicy_args {
> +	int err;
> +	unsigned short mode;
> +	unsigned long *nodemask;
> +	unsigned long maxnode;
> +	unsigned short flags;
> +	struct {
> +		/* Memory allowed */
> +		struct {
> +			int err;
> +			unsigned long maxnode;
> +			unsigned long *nodemask;
> +		} allowed;
> +		/* Address information */
> +		struct {
> +			int err;
> +			unsigned long addr;
> +			unsigned long node;
> +			unsigned short mode;
> +			unsigned short flags;
> +		} addr;
> +		/* Interleave */
> +	} get;
> +	/* Mode specific settings */
> +	union {
> +		struct {
> +			unsigned long next_node; /* get only */
> +		} interleave;
> +	};
> +};
> +
>  /* Flags for set_mempolicy */
>  #define MPOL_F_STATIC_NODES	(1 << 15)
>  #define MPOL_F_RELATIVE_NODES	(1 << 14)
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index f49337f6f300..1cf7709400f1 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1483,7 +1483,7 @@ static inline int sanitize_mpol_flags(int *mode, unsigned short *flags)
>  	*flags = *mode & MPOL_MODE_FLAGS;
>  	*mode &= ~MPOL_MODE_FLAGS;
>  
> -	if ((unsigned int)(*mode) >=  MPOL_MAX)
> +	if ((unsigned int)(*mode) >= MPOL_LEGACY)
>  		return -EINVAL;
>  	if ((*flags & MPOL_F_STATIC_NODES) && (*flags & MPOL_F_RELATIVE_NODES))
>  		return -EINVAL;
> @@ -1614,6 +1614,219 @@ SYSCALL_DEFINE3(set_mempolicy, int, mode, const unsigned long __user *, nmask,
>  	return kernel_set_mempolicy(mode, nmask, maxnode);
>  }
>  
> +static long do_set_mempolicy2(struct mempolicy_args *args)
> +{
> +	struct mempolicy *new = NULL;
> +	nodemask_t nodes;
> +	int err;
> +
> +	if (args->mode <= MPOL_LEGACY)
> +		return -EINVAL;
> +
> +	if (args->mode >= MPOL_MAX)
> +		return -EINVAL;
> +
> +	err = get_nodes(&nodes, args->nodemask, args->maxnode);
> +	if (err)
> +		return err;
> +
> +	new = mpol_new(args->mode, args->flags, &nodes);
> +	if (IS_ERR(new)) {
> +		err = PTR_ERR(new);
> +		goto out;

I'd expect mpol_new() to be side effect free on error,
so
		return PTR_ERR(new);
should be fine?

> +	}
> +
> +	switch (args->mode) {
> +	default:
> +		BUG();
> +	}
> +
> +	if (err)
> +		goto out;
> +
> +	err = swap_mempolicy(new, &nodes);
> +out:
> +	if (err && new)

as IS_ERR(new) is true, I think this puts the node even if mpol_new
returned an error.  That seems unwise.

I'd push this block below a return 0 anyway, so as to avoid
error handling in the good path.

> +		mpol_put(new);
> +	return err;
> +};
> +
> +static bool mempolicy2_args_valid(struct mempolicy_args *kargs)
> +{
> +	/* Legacy modes are routed through the legacy interface */
> +	if (kargs->mode <= MPOL_LEGACY)
> +		return false;
> +
> +	if (kargs->mode >= MPOL_MAX)
> +		return false;
> +
> +	return true;

This is a range check, so I think equally clear (and shorter) as..
	/* Legacy modes are routed through the legacy interface */
	return kargs->mode > MPOL_LEGACY && kargs->mode < MPOL_MAX;

> +}
> +
> +static long kernel_set_mempolicy2(const struct mempolicy_args __user *uargs,
> +				  size_t usize)
> +{
> +	struct mempolicy_args kargs;
> +	int err;
> +
> +	if (usize != sizeof(kargs))

As below, maybe allow for bigger with assumption we'll ignore what is in the
extra space.

> +		return -EINVAL;
> +
> +	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
> +	if (err)
> +		return err;
> +
> +	/* If the mode is legacy, use the legacy path */
> +	if (kargs.mode < MPOL_LEGACY) {
> +		int legacy_mode = kargs.mode | kargs.flags;
> +		const unsigned long __user *lnmask = kargs.nodemask;
> +		unsigned long maxnode = kargs.maxnode;
> +
> +		return kernel_set_mempolicy(legacy_mode, lnmask, maxnode);
> +	}
> +
> +	if (!mempolicy2_args_valid(&kargs))
> +		return -EINVAL;
> +
> +	return do_set_mempolicy2(&kargs);
> +}
> +
> +SYSCALL_DEFINE2(set_mempolicy2, const struct mempolicy_args __user *, args,
> +		size_t, size)
> +{
> +	return kernel_set_mempolicy2(args, size);
> +}
> +
> +/* Gets extended mempolicy information */
> +static long do_get_mempolicy2(struct mempolicy_args *kargs)
> +{
> +	struct mempolicy *pol = current->mempolicy;
> +	nodemask_t knodes;
> +	int err = 0;
> +
> +	kargs->err = 0;
> +	kargs->mode = pol->mode;
> +	/* Mask off internal flags */
> +	kargs->flags = (pol->flags & MPOL_MODE_FLAGS);

Excessive brackets.

> +
> +	if (kargs->nodemask) {
> +		if (mpol_store_user_nodemask(pol)) {
> +			knodes = pol->w.user_nodemask;
> +		} else {
> +			task_lock(current);
> +			get_policy_nodemask(pol, &knodes);
> +			task_unlock(current);
> +		}
> +		err = copy_nodes_to_user(kargs->nodemask,
> +					 kargs->maxnode,
> +					 &knodes);
Can wrap this less.

> +		if (err)

return err ?

> +			return -EINVAL;
> +	}
> +
> +
> +	if (kargs->get.allowed.nodemask) {
> +		kargs->get.allowed.err = 0;
> +		task_lock(current);
> +		knodes = cpuset_current_mems_allowed;
> +		task_unlock(current);
> +		err = copy_nodes_to_user(kargs->get.allowed.nodemask,
> +					 kargs->get.allowed.maxnode,
> +					 &knodes);
> +		kargs->get.allowed.err = err ? err : 0;
> +		kargs->err |= err ? err : 1;
		if (err) {
			kargs->get.allowed.err = err;
			kargs->err |= err;
		} else {
			kargs->get.allowed.err = 0;
			kargs->err = 1;
	Not particularly obvious why 1 and if you get an error later it's going to be messy
        as will 1 |= err_code
		}
> +	}
> +
> +	if (kargs->get.addr.addr) {
> +		struct mempolicy *addr_pol = NULL;

Why init here - I think it's always set before use.

> +		struct vm_area_struct *vma = NULL;

Why init here?

> +		struct mm_struct *mm = current->mm;
> +		unsigned long addr = kargs->get.addr.addr;
> +
> +		kargs->get.addr.err = 0;

I'd set this only in the good path. You overwrite it
in the bad paths anyway, so just move it down below the error
checks.

> +
> +		/*
> +		 * Do NOT fall back to task policy if the
> +		 * vma/shared policy at addr is NULL.  We
> +		 * want to return MPOL_DEFAULT in this case.
> +		 */
> +		mmap_read_lock(mm);
> +		vma = vma_lookup(mm, addr);
> +		if (!vma) {
> +			mmap_read_unlock(mm);
> +			kargs->get.addr.err = -EFAULT;
> +			kargs->err |= err ? err : 2;
> +			goto mode_info;
> +		}
> +		if (vma->vm_ops && vma->vm_ops->get_policy)
> +			addr_pol = vma->vm_ops->get_policy(vma, addr);
> +		else
> +			addr_pol = vma->vm_policy;
> +
> +		kargs->get.addr.mode = addr_pol->mode;
> +		/* Mask off internal flags */
> +		kargs->get.addr.flags = (pol->flags & MPOL_MODE_FLAGS);
> +
> +		/*
> +		 * Take a refcount on the mpol, because we are about to
> +		 * drop the mmap_lock, after which only "pol" remains
> +		 * valid, "vma" is stale.
> +		 */
> +		vma = NULL;
> +		mpol_get(addr_pol);
> +		mmap_read_unlock(mm);
> +		err = lookup_node(mm, addr);
> +		mpol_put(addr_pol);
> +		if (err < 0) {
> +			kargs->get.addr.err = err;
> +			kargs->err |= err ? err : 4;
> +			goto mode_info;
> +		}
> +		kargs->get.addr.node = err;

Confusing to call something that isn't an error, err. I'd use a different
local variable for this and set err = rc in error path only.

Could set the get.addr.err = 0; down here as this is only way it remains 0
if you set it earlier.


> +	}
> +
> +mode_info:
> +	switch (kargs->mode) {
> +	case MPOL_INTERLEAVE:
> +		kargs->interleave.next_node = next_node_in(current->il_prev,
> +							   pol->nodes);
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return err;
> +}
> +
> +static long kernel_get_mempolicy2(struct mempolicy_args __user *uargs,
> +				  size_t usize)
> +{
> +	struct mempolicy_args kargs;
> +	int err;
> +
> +	if (usize != sizeof(struct mempolicy_args))

sizeof(kargs) for same reason as below.  I'm not sure on convention here
but is it wise to leave option for a newer userspace to send a larger
struct, knowing that fields in it might be ignored by an older kernel?


> +		return -EINVAL;
> +
> +	err = copy_struct_from_user(&kargs, sizeof(kargs), uargs, usize);
> +	if (err)
> +		return err;
> +
> +	/* Get the extended memory policy information (kargs.ext) */
> +	err = do_get_mempolicy2(&kargs);
> +	if (err)
> +		return err;
> +
> +	err = copy_to_user(uargs, &kargs, sizeof(struct mempolicy_args));
> +
> +	return err;

return copy_to_user(uargs, &kargs, sizeof(kargs));
You are inconsistent on the sizeof.  Better to pick one style, and
given both are used, I'd go with using the sizeof(thing) rather
than sizeof(type) option + shorter lines ;)

> +}
> +
> +SYSCALL_DEFINE2(get_mempolicy2, struct mempolicy_args __user *, policy,
> +		size_t, size)
> +{
> +	return kernel_get_mempolicy2(policy, size);
> +}
> +
>  static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  				const unsigned long __user *old_nodes,
>  				const unsigned long __user *new_nodes)

