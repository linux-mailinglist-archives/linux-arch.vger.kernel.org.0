Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6819C281EA3
	for <lists+linux-arch@lfdr.de>; Sat,  3 Oct 2020 00:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725554AbgJBWwW (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Oct 2020 18:52:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbgJBWwW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 2 Oct 2020 18:52:22 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FF1C0613E3
        for <linux-arch@vger.kernel.org>; Fri,  2 Oct 2020 15:52:21 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id 91so270087uas.7
        for <linux-arch@vger.kernel.org>; Fri, 02 Oct 2020 15:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DUl0jXow43Nw6zgUQyLrg4bZ2urEhAMRcyb62/mAIWo=;
        b=C4Xe9Wy/oRnx7UfMnr1Boo3qqrAPP2a7qPH/wsAl/Ng77kzoGd+vTtS2Y5mD3Amn3L
         vOf6N8O1Vd0222GnTtIWEwrkO7Cc9gjdT9ELVodD8pTyfD9lJOJvQVHsF00wjDn7Aerb
         RL4MlixbtohKCWc9MdOEn9sxArT3f2vgmEJjtXtgUXhDx0ZiyoXfDB3UoOk8clwipniy
         cQkXmqhb3Ku1zwmHb0HGPHyQAdIfdq8cQXR4Cs4VqDiGN0l9U8pJyg3EBOHwT3Xrg+hD
         Lnh9z/ZaVPiQyfC0UiSZLUFxHuvGqbB/h62biZqIT4GdiWpVaoVPhCSbB1ECOeCHtJ5A
         fFWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DUl0jXow43Nw6zgUQyLrg4bZ2urEhAMRcyb62/mAIWo=;
        b=TvTM81+QRLBiMlDnwkiABVx+/gG3Y4oS9dDqpDbd5wWgy0LdLmF9Et039nIa/O04L4
         0PxwVns0dXGVzOrX/wghx4RVlhfeOLFl8CLvcZHUoH0JiOEMNQYw9q9WRiH2bDzCRrmZ
         ksosEU8MgD4EunEqSpeP2F2pw6M7oudnQuehSP7RSj4GgG3hKIebgmt3/vLvmLZcgtEZ
         UPLyw9VPDCJ78fP/GVGeKbTUMVFUADVEca3FIuIhMtsPImiGpLo8p8frczq79RUngvi2
         xWlFb7cSuOW9bJw1oZDC32mzOxxYyuAQHMvDvvDx3lzKWWpkOaco/I4SPT7IdThc5utV
         0+VQ==
X-Gm-Message-State: AOAM533k577sCfB3DlO0HCd+Vr3bjyWCDpWtOrW7nUH3al1b3np0BFTK
        voDyQjaLNqJ1EHo0YGV/8G0pLKUxP2siNBNWa8aNgw==
X-Google-Smtp-Source: ABdhPJymo7QSpowEd4miTNPbOJ7+YQXVH1C2HR7dwiXEtT8FD0rweS49sQYw8UF9msEsF+ush+f5bGwwbzoVgidodu8=
X-Received: by 2002:ab0:2a43:: with SMTP id p3mr2682059uar.122.1601679140630;
 Fri, 02 Oct 2020 15:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200925145649.5438-1-yu-cheng.yu@intel.com> <20200925145649.5438-20-yu-cheng.yu@intel.com>
 <CAMn1gO4cxSt8-8qVbAei0jPErTtARdsEY4js6Fi=kzozAuE3yQ@mail.gmail.com> <00a409f0-1e2e-0bd7-83e7-f21a47878916@intel.com>
In-Reply-To: <00a409f0-1e2e-0bd7-83e7-f21a47878916@intel.com>
From:   Peter Collingbourne <pcc@google.com>
Date:   Fri, 2 Oct 2020 15:52:09 -0700
Message-ID: <CAMn1gO5H4thZQMKvbWs82DCrXJM1Fu9z1hwt1G_kNwDVGcxeTA@mail.gmail.com>
Subject: Re: [PATCH v13 19/26] mm: Re-introduce do_mmap_pgoff()
To:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
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
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 2, 2020 at 8:58 AM Yu, Yu-cheng <yu-cheng.yu@intel.com> wrote:
>
> On 10/1/2020 7:06 PM, Peter Collingbourne wrote:
> > On Fri, Sep 25, 2020 at 7:57 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> >>
> >> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> >> removed from the function's input by:
> >>
> >>      commit 45e55300f114 ("mm: remove unnecessary wrapper function do_mmap_pgoff()").
> >>
> >> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> >> do_mmap().  Re-introduce the vm_flags and do_mmap_pgoff().
> >
> > I would prefer to change the callers to pass the additional 0 argument
> > instead of bringing the wrapper function back, but if we're going to
> > bring it back then we should fix the naming (both functions take a
> > pgoff argument, so the previous name do_mmap_pgoff() was just plain
> > confusing).
> >
> > Peter
> >
>
> Thanks for your feedback.  Here is the updated patch.  I will re-send
> the whole series later.
>
> Yu-cheng
>
> ======
>
>  From 6a9f1e6bcdb6e599a44d5f58cf4cebd28c4634a2 Mon Sep 17 00:00:00 2001
> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Date: Wed, 12 Aug 2020 14:01:58 -0700
> Subject: [PATCH 19/26] mm: Re-introduce do_mmap_pgoff()

The subject line of the commit message needs to be updated, but aside from that:

Reviewed-by: Peter Collingbourne <pcc@google.com>

Peter

>
> There was no more caller passing vm_flags to do_mmap(), and vm_flags was
> removed from the function's input by:
>
>      commit 45e55300f114 ("mm: remove unnecessary wrapper function
> do_mmap_pgoff()").
>
> There is a new user now.  Shadow stack allocation passes VM_SHSTK to
> do_mmap().  Re-introduce vm_flags to do_mmap(), but without the old wrapper
> do_mmap_pgoff().  Instead, fix all callers of the wrapper by passing a zero
> vm_flags to do_mmap().
>
> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
> Cc: Peter Collingbourne <pcc@google.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Oleg Nesterov <oleg@redhat.com>
> Cc: linux-mm@kvack.org
> ---
>   fs/aio.c           |  2 +-
>   include/linux/mm.h |  3 ++-
>   ipc/shm.c          |  2 +-
>   mm/mmap.c          | 10 +++++-----
>   mm/nommu.c         |  4 ++--
>   mm/util.c          |  2 +-
>   6 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/fs/aio.c b/fs/aio.c
> index d5ec30385566..ca8c11665eea 100644
> --- a/fs/aio.c
> +++ b/fs/aio.c
> @@ -527,7 +527,7 @@ static int aio_setup_ring(struct kioctx *ctx,
> unsigned int nr_events)
>
>         ctx->mmap_base = do_mmap(ctx->aio_ring_file, 0, ctx->mmap_size,
>                                  PROT_READ | PROT_WRITE,
> -                                MAP_SHARED, 0, &unused, NULL);
> +                                MAP_SHARED, 0, 0, &unused, NULL);
>         mmap_write_unlock(mm);
>         if (IS_ERR((void *)ctx->mmap_base)) {
>                 ctx->mmap_size = 0;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index e09d13699bbe..e020eea33138 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2560,7 +2560,8 @@ extern unsigned long mmap_region(struct file
> *file, unsigned long addr,
>         struct list_head *uf);
>   extern unsigned long do_mmap(struct file *file, unsigned long addr,
>         unsigned long len, unsigned long prot, unsigned long flags,
> -       unsigned long pgoff, unsigned long *populate, struct list_head *uf);
> +       vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
> +       struct list_head *uf);
>   extern int __do_munmap(struct mm_struct *, unsigned long, size_t,
>                        struct list_head *uf, bool downgrade);
>   extern int do_munmap(struct mm_struct *, unsigned long, size_t,
> diff --git a/ipc/shm.c b/ipc/shm.c
> index e25c7c6106bc..91474258933d 100644
> --- a/ipc/shm.c
> +++ b/ipc/shm.c
> @@ -1556,7 +1556,7 @@ long do_shmat(int shmid, char __user *shmaddr, int
> shmflg,
>                         goto invalid;
>         }
>
> -       addr = do_mmap(file, addr, size, prot, flags, 0, &populate, NULL);
> +       addr = do_mmap(file, addr, size, prot, flags, 0, 0, &populate, NULL);
>         *raddr = addr;
>         err = 0;
>         if (IS_ERR_VALUE(addr))
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 574b3f273462..fc04184d2eae 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1365,11 +1365,11 @@ static inline bool file_mmap_ok(struct file
> *file, struct inode *inode,
>    */
>   unsigned long do_mmap(struct file *file, unsigned long addr,
>                         unsigned long len, unsigned long prot,
> -                       unsigned long flags, unsigned long pgoff,
> -                       unsigned long *populate, struct list_head *uf)
> +                       unsigned long flags, vm_flags_t vm_flags,
> +                       unsigned long pgoff, unsigned long *populate,
> +                       struct list_head *uf)
>   {
>         struct mm_struct *mm = current->mm;
> -       vm_flags_t vm_flags;
>         int pkey = 0;
>
>         *populate = 0;
> @@ -1431,7 +1431,7 @@ unsigned long do_mmap(struct file *file, unsigned
> long addr,
>          * to. we assume access permissions have been handled by the open
>          * of the memory object, so we don't do any here.
>          */
> -       vm_flags = calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
> +       vm_flags |= calc_vm_prot_bits(prot, pkey) | calc_vm_flag_bits(flags) |
>                         mm->def_flags | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC;
>
>         if (flags & MAP_LOCKED)
> @@ -3007,7 +3007,7 @@ SYSCALL_DEFINE5(remap_file_pages, unsigned long,
> start, unsigned long, size,
>
>         file = get_file(vma->vm_file);
>         ret = do_mmap(vma->vm_file, start, size,
> -                       prot, flags, pgoff, &populate, NULL);
> +                       prot, flags, 0, pgoff, &populate, NULL);
>         fput(file);
>   out:
>         mmap_write_unlock(mm);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index 75a327149af1..f67d6bcdfc9f 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1078,6 +1078,7 @@ unsigned long do_mmap(struct file *file,
>                         unsigned long len,
>                         unsigned long prot,
>                         unsigned long flags,
> +                       vm_flags_t vm_flags,
>                         unsigned long pgoff,
>                         unsigned long *populate,
>                         struct list_head *uf)
> @@ -1085,7 +1086,6 @@ unsigned long do_mmap(struct file *file,
>         struct vm_area_struct *vma;
>         struct vm_region *region;
>         struct rb_node *rb;
> -       vm_flags_t vm_flags;
>         unsigned long capabilities, result;
>         int ret;
>
> @@ -1104,7 +1104,7 @@ unsigned long do_mmap(struct file *file,
>
>         /* we've determined that we can make the mapping, now translate what we
>          * now know into VMA flags */
> -       vm_flags = determine_vm_flags(file, prot, flags, capabilities);
> +       vm_flags |= determine_vm_flags(file, prot, flags, capabilities);
>
>         /* we're going to need to record the mapping */
>         region = kmem_cache_zalloc(vm_region_jar, GFP_KERNEL);
> diff --git a/mm/util.c b/mm/util.c
> index 5ef378a2a038..beb8b881c080 100644
> --- a/mm/util.c
> +++ b/mm/util.c
> @@ -503,7 +503,7 @@ unsigned long vm_mmap_pgoff(struct file *file,
> unsigned long addr,
>         if (!ret) {
>                 if (mmap_write_lock_killable(mm))
>                         return -EINTR;
> -               ret = do_mmap(file, addr, len, prot, flag, pgoff, &populate,
> +               ret = do_mmap(file, addr, len, prot, flag, 0, pgoff, &populate,
>                               &uf);
>                 mmap_write_unlock(mm);
>                 userfaultfd_unmap_complete(mm, &uf);
> --
> 2.21.0
>
