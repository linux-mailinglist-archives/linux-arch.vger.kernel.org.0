Return-Path: <linux-arch+bounces-434-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F557F6DC9
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 09:14:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4302EB20C6D
	for <lists+linux-arch@lfdr.de>; Fri, 24 Nov 2023 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1CF69465;
	Fri, 24 Nov 2023 08:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Zt1f9f9l"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5FC19A2
	for <linux-arch@vger.kernel.org>; Fri, 24 Nov 2023 00:13:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-507a29c7eefso2112028e87.1
        for <linux-arch@vger.kernel.org>; Fri, 24 Nov 2023 00:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700813633; x=1701418433; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BIPK5Hvm18pzHDJO73eIMgzzAL5lmhWxslNB0teYmMk=;
        b=Zt1f9f9lLLl0AT6igTLQgwrz+i2HDgQd0dTDkZXq4rbqzXPey5xh8RNV3iHgcdaOcH
         Lnb06rWrqupjGrHmNfHpR3H8vjjrtN2Do3MxrXbzv4jtvy2hKk1WvcCKcdBVA+HMa69N
         vPP2CWqsGLgFtzJuIy3SHF2JZA/2SD3UEU3ZWOFOoYZq/3Xh7d4iql34WHEcy6qynl5p
         V66l7yT02x9LmedmdV3uUOwP/mzh+alih5Af2ey6HGl8pbJRevdJBviNo/4EGAXbMAEp
         YkD/0h9BDb234wsm7qHrfq2zWCAVxJPFT/64Ryxr+s4XKJMTHMNzudPMqR5sKya+JvDP
         oqmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813633; x=1701418433;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BIPK5Hvm18pzHDJO73eIMgzzAL5lmhWxslNB0teYmMk=;
        b=eDRdqq0UaxxsN+Px1KzpfRplKiMblyk8sY7CDR1SiGJVzc/Et8LxvzHyNisdYb/Ned
         ku6GtJeWL06SxDH5sRqylR7KgH5NgdEGpRazpCzMAI7ljIsPf4Byy5m6vDUe0fZreAp2
         YqlCuBKLBu26Qjmj2E3NOEjzwj583hVAyeAE3uRnrajYsyYhp38/ajjR3CiXVpaYiRs6
         2gFZqTTUGCIyBztjbtf8GvrOH7/OF3bn2fayBSQMIKZOMjv7VLy3Wx865R6+xJz4JzNT
         YDn7nRSdWfTElaIAsjGN3YLauFCzyIbAIqe2YZljGMBJWQRkQNe8q7UWy5KOCnbeyS+c
         jC5g==
X-Gm-Message-State: AOJu0Yztj2h+6zPJ7+sodTuZ7bZowYxHSlbH3eQPFyDB6PgPR5RzO5lp
	MERslo1CqrwckpEq1/FbEGEJIdjG+UTGuB7t9nAhYw==
X-Google-Smtp-Source: AGHT+IENKYtJn7xsQSiBE3z3paskmTKdU9LExQjBtyLHTdb/HOLTWbiQ73NUela9SSYZDTWiu5//+NrPdj5O6kxNjpY=
X-Received: by 2002:a2e:9bc1:0:b0:2c8:3406:6fb5 with SMTP id
 w1-20020a2e9bc1000000b002c834066fb5mr1222293ljj.7.1700813633478; Fri, 24 Nov
 2023 00:13:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
In-Reply-To: <ZV5zGROLefrsEcHJ@r13-u19.micron.com>
From: Zhongkun He <hezhongkun.hzk@bytedance.com>
Date: Fri, 24 Nov 2023 16:13:41 +0800
Message-ID: <CACSyD1OFjROw26+2ojG37eDBParVg721x1HCROMiF2pW2aHj8A@mail.gmail.com>
Subject: Re: [RFC PATCH] mm/mbind: Introduce process_mbind() syscall for
 external memory binding
To: Vinicius Petrucci <vpetrucci@gmail.com>
Cc: akpm@linux-foundation.org, linux-mm@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-api@vger.kernel.org, minchan@kernel.org, 
	dave.hansen@linux.intel.com, x86@kernel.org, Jonathan.Cameron@huawei.com, 
	aneesh.kumar@linux.ibm.com, gregory.price@memverge.com, ying.huang@intel.com, 
	dan.j.williams@intel.com, fvdl@google.com, surenb@google.com, 
	rientjes@google.com, hannes@cmpxchg.org, mhocko@suse.com, Hasan.Maruf@amd.com, 
	jgroves@micron.com, ravis.opensrc@micron.com, sthanneeru@micron.com, 
	emirakhur@micron.com, vtavarespetr@micron.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Vinicius=EF=BC=81

On Thu, Nov 23, 2023 at 5:32=E2=80=AFAM Vinicius Petrucci <vpetrucci@gmail.=
com> wrote:
>
> From: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
>
> This patch introduces `process_mbind()` to enable a userspace orchestrato=
r with
> an understanding of another process's memory layout to alter its memory p=
olicy.
> As system memory configurations become more and more complex (e.g., DDR+H=
BM+CXL memories),
> such a userspace orchestrator can explore more advanced techniques to gui=
de memory placement
> to individual NUMA nodes across memory tiers. This allows for a more effi=
cient allocation of
> memory resources, leading to enhanced application performance.
>
> Alternatively, there are existing methods such as LD_PRELOAD (https://pme=
m.io/memkind/) or
> syscall_intercept (https://github.com/pmem/syscall_intercept), but these =
techniques, beyond the
> lack of portability/universality, can lead to system incompatibility issu=
es, inconsistency in
> application behavior, potential risks due to global system-wide settings,=
 and increased
> complexity in implementation.
>
> The concept of an external entity that understands the layout of another =
process's VM
> is already present with `process_madvise()`. Thus, it seems reasonable to=
 introduce
> the `process_mbind` variant of `mbind`. The implementation framework of `=
process_mbind()`
> is akin to `process_madvise()`. It uses pidfd of an external process to d=
irect the memory
> policy and supports a vector of memory address ranges.
>
> The general use case here is similar to the prior RFC `pidfd_set_mempolic=
y()`
> (https://lore.kernel.org/linux-mm/20221010094842.4123037-1-hezhongkun.hzk=
@bytedance.com/),
> but offers a more fine-grained external control by binding specific memor=
y regions
> (say, heap data structures) to specific NUMA nodes. Another concrete use =
case was described
> by a prior work showing up to 2X runtime improvement (compared to AutoNUM=
A tiering) using
> memory object/region-based memory placement for workloads with irregular =
access patterns
> such as graph analytics: https://iiswc.org/iiswc2022/IISWC2022_42.pdf
>
> The proposed API is as follows:
>
> long process_mbind(int pidfd,
>                 const struct iovec *iovec,
>                 unsigned long vlen,
>                 unsigned long mode,
>                 const unsigned long *nmask,
>                 unsigned int flags);
>
> The `pidfd` argument is used to select the process that is identified by =
the PID file
> descriptor provided in pidfd. (See pidofd_open(2) for more information)
>
> The pointer `iovec` points to an array of iovec structures (as described =
in <sys/uio.h>):
>
> struct iovec {
>     void *iov_base;         /* starting address of region */
>     size_t iov_len;         /* size of region (in bytes) */
> };
>
> The `iovec` defines memory regions that start at the address (iov_base) a=
nd
> have a size measured in bytes (iov_len).

Good idea.

>
> The `vlen` indicates the quantity of elements contained in iovec.
>
> Please note the initial `maxnode` parameter from `mbind` was omitted
> to ensure the API doesn't exceed 6 arguments. Instead, the constant
> MAX_NUMNODES was utilized.

The original parameters should not be omitted,  the patch from
Gregory Price is a good solution to put all of them together.

>
> Please see the mbind(2) man page for more details about other's arguments=
.
>
> Additionally, it is worth noting the following:
> - Using a vector of address ranges as an argument in `process_mbind` prov=
ides more
> flexibility than the original `mbind` system call, even when invoked from=
 a current
> or local process.
> - In contrast to `move_pages`, which requires an array of fixed-size page=
s,
> `process_mbind` (with flags MPOL_MF_MOVE*) offers a more convinient and f=
lexible page
> migration capability on a per object or region basis.
> - Similar to `process_madvise`, manipulating the memory binding of extern=
al processes
> necessitates `CAP_SYS_NICE` and `PTRACE_MODE_READ_FSCREDS` checks (refer =
to ptrace(2)).
>
> Suggested-by: Frank van der Linden <fvdl@google.com>
> Signed-off-by: Vinicius Tavares Petrucci <vtavarespetr@micron.com>
> Signed-off-by: Hasan Al Maruf <Hasan.Maruf@amd.com>
> ---
>  arch/x86/entry/syscalls/syscall_64.tbl |  1 +
>  include/linux/syscalls.h               |  4 ++
>  include/uapi/asm-generic/unistd.h      |  4 +-
>  kernel/sys_ni.c                        |  1 +
>  mm/mempolicy.c                         | 86 +++++++++++++++++++++++++-
>  5 files changed, 92 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/sysc=
alls/syscall_64.tbl
> index 8cb8bf68721c..9d9db49a3242 100644
> --- a/arch/x86/entry/syscalls/syscall_64.tbl
> +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> @@ -378,6 +378,7 @@
>  454    common  futex_wake              sys_futex_wake
>  455    common  futex_wait              sys_futex_wait
>  456    common  futex_requeue           sys_futex_requeue
> +457    common  process_mbind           sys_process_mbind
>
>  #
>  # Due to a historical design error, certain syscalls are numbered differ=
ently
> diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> index fd9d12de7e92..def5250ed625 100644
> --- a/include/linux/syscalls.h
> +++ b/include/linux/syscalls.h
> @@ -816,6 +816,10 @@ asmlinkage long sys_mbind(unsigned long start, unsig=
ned long len,
>                                 const unsigned long __user *nmask,
>                                 unsigned long maxnode,
>                                 unsigned flags);
> +asmlinkage long sys_process_mbind(int pidfd, const struct iovec __user *=
vec,
> +                               size_t vlen, unsigned long mode,
> +                               const unsigned long __user *nmask,
> +                               unsigned flags);
>  asmlinkage long sys_get_mempolicy(int __user *policy,
>                                 unsigned long __user *nmask,
>                                 unsigned long maxnode,
> diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic=
/unistd.h
> index 756b013fb832..9ed2c91940d6 100644
> --- a/include/uapi/asm-generic/unistd.h
> +++ b/include/uapi/asm-generic/unistd.h
> @@ -828,9 +828,11 @@ __SYSCALL(__NR_futex_wake, sys_futex_wake)
>  __SYSCALL(__NR_futex_wait, sys_futex_wait)
>  #define __NR_futex_requeue 456
>  __SYSCALL(__NR_futex_requeue, sys_futex_requeue)
> +#define __NR_process_mbind 457
> +__SYSCALL(__NR_process_mbind, sys_process_mbind)
>
>  #undef __NR_syscalls
> -#define __NR_syscalls 457
> +#define __NR_syscalls 458
>
>  /*
>   * 32 bit systems traditionally used different
> diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> index e1a6e3c675c0..cc5cb5ae3ae7 100644
> --- a/kernel/sys_ni.c
> +++ b/kernel/sys_ni.c
> @@ -187,6 +187,7 @@ COND_SYSCALL(process_madvise);
>  COND_SYSCALL(process_mrelease);
>  COND_SYSCALL(remap_file_pages);
>  COND_SYSCALL(mbind);
> +COND_SYSCALL(process_mbind);
>  COND_SYSCALL(get_mempolicy);
>  COND_SYSCALL(set_mempolicy);
>  COND_SYSCALL(migrate_pages);
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 10a590ee1c89..91ee300fa728 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1215,11 +1215,10 @@ static struct folio *alloc_migration_target_by_mp=
ol(struct folio *src,
>  }
>  #endif
>
> -static long do_mbind(unsigned long start, unsigned long len,
> +static long do_mbind(struct mm_struct *mm, unsigned long start, unsigned=
 long len,
>                      unsigned short mode, unsigned short mode_flags,
>                      nodemask_t *nmask, unsigned long flags)
>  {
> -       struct mm_struct *mm =3D current->mm;
>         struct vm_area_struct *vma, *prev;
>         struct vma_iterator vmi;
>         struct migration_mpol mmpol;
> @@ -1465,10 +1464,84 @@ static inline int sanitize_mpol_flags(int *mode, =
unsigned short *flags)
>         return 0;
>  }
>
> +static long kernel_mbind_process(int pidfd, const struct iovec __user *v=
ec,
> +               size_t vlen, unsigned long mode,
> +               const unsigned long __user *nmask, unsigned int flags)
> +{
> +       ssize_t ret;
> +       struct iovec iovstack[UIO_FASTIOV];
> +       struct iovec *iov =3D iovstack;
> +       struct iov_iter iter;
> +       struct task_struct *task;
> +       struct mm_struct *mm;
> +       unsigned int f_flags;
> +       unsigned short mode_flags;
> +       int lmode =3D mode;
> +       unsigned long maxnode =3D MAX_NUMNODES;
> +       int err;
> +       nodemask_t nodes;
> +
> +       err =3D sanitize_mpol_flags(&lmode, &mode_flags);
> +       if (err)
> +               goto out;
> +
> +       err =3D get_nodes(&nodes, nmask, maxnode);
> +       if (err)
> +               goto out;
> +
> +       ret =3D import_iovec(ITER_DEST, vec, vlen, ARRAY_SIZE(iovstack),
> +                       &iov, &iter);
> +       if (ret < 0)
> +               goto out;
> +
> +       task =3D pidfd_get_task(pidfd, &f_flags);
> +       if (IS_ERR(task)) {
> +               ret =3D PTR_ERR(task);
> +               goto free_iov;
> +       }
> +
> +       /* From process_madvise: Require PTRACE_MODE_READ
> +        * to avoid leaking ASLR metadata. */
> +       mm =3D mm_access(task, PTRACE_MODE_READ_FSCREDS);
> +       if (IS_ERR_OR_NULL(mm)) {
> +               ret =3D IS_ERR(mm) ? PTR_ERR(mm) : -ESRCH;
> +               goto release_task;
> +       }
> +
> +       /* From process_madvise: Require CAP_SYS_NICE for
> +        * influencing process performance. */
> +       if (!capable(CAP_SYS_NICE)) {
> +               ret =3D -EPERM;
> +               goto release_mm;
> +       }
> +
> +       while (iov_iter_count(&iter)) {
> +               unsigned long start =3D untagged_addr(
> +                               (unsigned long)iter_iov_addr(&iter));
> +               unsigned long len =3D iter_iov_len(&iter);
> +
> +               ret =3D do_mbind(mm, start, len, lmode, mode_flags,
> +                               &nodes, flags);
> +               if (ret < 0)
> +                       break;
> +               iov_iter_advance(&iter, iter_iov_len(&iter));
> +       }
> +
> +release_mm:
> +       mmput(mm);
> +release_task:
> +       put_task_struct(task);
> +free_iov:
> +       kfree(iov);
> +out:
> +       return ret;
> +}
> +

The do_mbind function relies on the current task to obtain nodemask
and task policy,
so the current modification is not enough.

>  static long kernel_mbind(unsigned long start, unsigned long len,
>                          unsigned long mode, const unsigned long __user *=
nmask,
>                          unsigned long maxnode, unsigned int flags)
>  {
> +       struct mm_struct *mm =3D current->mm;
>         unsigned short mode_flags;
>         nodemask_t nodes;
>         int lmode =3D mode;
> @@ -1483,7 +1556,7 @@ static long kernel_mbind(unsigned long start, unsig=
ned long len,
>         if (err)
>                 return err;
>
> -       return do_mbind(start, len, lmode, mode_flags, &nodes, flags);
> +       return do_mbind(mm, start, len, lmode, mode_flags, &nodes, flags)=
;
>  }
>
>  SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned long, start, unsigned =
long, len,
> @@ -1553,6 +1626,13 @@ SYSCALL_DEFINE4(set_mempolicy_home_node, unsigned =
long, start, unsigned long, le
>         return err;
>  }
>
> +SYSCALL_DEFINE6(process_mbind, int, pidfd, const struct iovec __user *, =
vec,
> +               size_t, vlen, unsigned long, mode,
> +               const unsigned long __user *, nmask, unsigned int, flags)
> +{
> +       return kernel_mbind_process(pidfd, vec, vlen, mode, nmask, flags)=
;
> +}
> +
>  SYSCALL_DEFINE6(mbind, unsigned long, start, unsigned long, len,
>                 unsigned long, mode, const unsigned long __user *, nmask,
>                 unsigned long, maxnode, unsigned int, flags)
> --
> 2.41.0
>

Per my understanding,  the process_mbind() is implementable without
many difficult challenges=EF=BC=8C
since it is always protected by mm->mmap_lock. But task mempolicy does
not acquire any lock
in alloc_pages().

