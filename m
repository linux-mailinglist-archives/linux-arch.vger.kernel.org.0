Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45AA973D924
	for <lists+linux-arch@lfdr.de>; Mon, 26 Jun 2023 10:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjFZIIb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Jun 2023 04:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbjFZIIZ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 26 Jun 2023 04:08:25 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BE4E53;
        Mon, 26 Jun 2023 01:08:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-313ec24b36bso293177f8f.0;
        Mon, 26 Jun 2023 01:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687766902; x=1690358902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lR9uR4LOeGZi3JSeuBmGvQnkQG6VZQCikIFxZLeRDho=;
        b=XjwPWcsUSuBmv7UxZon833KFLcuf3ep90HG7J7PLTzaAZqlzOarkTCisbenekXUjcI
         WupMUd4Z8npsr9duwWF4YV0PAgS7PWQMRGpHs6vaPhiOH6nT/gNdCKHiDqHvlQEeKOmU
         oLpN7ms273iO+XFQME2Vj2cUABFAuJEckmqg8JbvrttamnADCl79rJKaa0RuE/2dzdAk
         0LhxRHHRZo17P9XwIPjH+/d0Z0VMFzrGcNeRHzzTmE8YEMExqy+HwtX7KroR/2ajJMuj
         h8faiU2NwCMpDg8+JmJEQ2jRQj6JJ29iR0O3erky+R009kvgWiUyxs9Yo90FVkMVbcK9
         GoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687766902; x=1690358902;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR9uR4LOeGZi3JSeuBmGvQnkQG6VZQCikIFxZLeRDho=;
        b=e+eemuWN2S977YWfXL9FCV3aNJhFEfloONxpogNt8/8iPdnWqA0hJ4MWc6r2iRt67i
         7kAgbHxebUpqpjE+bnxfhPLEXjOG7Mb1F63txTJhp9JPb9bgdeBZyfU3M7uLfrTi6mwS
         l/gM07O6vN36XvogC7U0lXnujia8b7S79QOLz6VL1aaYtjbXAS2hSxFJOIT10qWCUAJU
         pIioz+XP3PFFY0teOjsaJtslk309veQU+CGcnOCOhOlo0fAqj4PUOjiRzXmDyAcH93YI
         kleiMzvRP5CsEqPYEsOXkvGZS4g9H+6MbncmmoJ5jedOnvh0RzWwgYH15q+W/BwThjqk
         sCjw==
X-Gm-Message-State: AC+VfDz1jtJ49qHZTH6AtutXSSkHiG+pfFwvOU8SSN2JMl1QIGhUY6u1
        ubSKzY8VKo6W8d/WI7xTg4U=
X-Google-Smtp-Source: ACHHUZ5PuTA/ZN67zVbtCQY+/DHF9OoEyH+dK8n2tigkPjMLvmOkyrpvswhqVLd55n4IdJWiB8XhtQ==
X-Received: by 2002:a5d:5907:0:b0:313:ee56:a6f4 with SMTP id v7-20020a5d5907000000b00313ee56a6f4mr2740248wrd.3.1687766901499;
        Mon, 26 Jun 2023 01:08:21 -0700 (PDT)
Received: from localhost.localdomain (vpn-fn-225.net.ed.ac.uk. [192.41.114.225])
        by smtp.gmail.com with ESMTPSA id f1-20020a5d5681000000b0030647449730sm6618077wrv.74.2023.06.26.01.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 01:08:21 -0700 (PDT)
Date:   Mon, 26 Jun 2023 09:08:23 +0100
From:   Karim Manaouil <kmanaouil.dev@gmail.com>
To:     Khalid Aziz <khalid.aziz@oracle.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org,
        markhemm@googlemail.com, viro@zeniv.linux.org.uk, david@redhat.com,
        mike.kravetz@oracle.com, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
Subject: Re: [PATCH RFC v2 3/4] mm/ptshare: Create new mm struct for page
 table sharing
Message-ID: <CA+uifjO9Q26cS_kYT0ftx0JQnQJ4QMd27tAtPR3s1voDHzet8w@mail.gmail.com>
References: <cover.1682453344.git.khalid.aziz@oracle.com>
 <1fd52581f4e4960a4d07cb9784d56659ec139d3c.1682453344.git.khalid.aziz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd52581f4e4960a4d07cb9784d56659ec139d3c.1682453344.git.khalid.aziz@oracle.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Apr 26, 2023 at 10:49:50AM -0600, Khalid Aziz wrote:
> When a process passes MAP_SHARED_PT flag to mmap(), create a new mm
> struct to hold the shareable page table entries for the newly mapped
> region.  This new mm is not associated with a task.  Its lifetime is
> until the last shared mapping is deleted.  This patch also adds a
> new pointer "ptshare_data" to struct address_space which points to
> the data structure that will contain pointer to this newly created
> mm along with properties of the shared mapping. ptshare_data
> maintains a refcount for the shared mapping so that it can be
> cleaned up upon last unmap.
>
> Signed-off-by: Khalid Aziz <khalid.aziz@oracle.com>
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  include/linux/fs.h |   2 +
>  mm/Makefile        |   2 +-
>  mm/internal.h      |  14 +++++
>  mm/mmap.c          |  72 ++++++++++++++++++++++++++
>  mm/ptshare.c       | 126 +++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 215 insertions(+), 1 deletion(-)
>  create mode 100644 mm/ptshare.c
>
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index c85916e9f7db..db8d3257c712 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -422,6 +422,7 @@ extern const struct address_space_operations empty_aops;
>   * @private_lock: For use by the owner of the address_space.
>   * @private_list: For use by the owner of the address_space.
>   * @private_data: For use by the owner of the address_space.
> + * @ptshare_data: For shared page table use
>   */
>  struct address_space {
>       struct inode            *host;
> @@ -443,6 +444,7 @@ struct address_space {
>       spinlock_t              private_lock;
>       struct list_head        private_list;
>       void                    *private_data;
> +     void                    *ptshare_data;
>  } __attribute__((aligned(sizeof(long)))) __randomize_layout;
>       /*
>        * On most architectures that alignment is already the case; but
> diff --git a/mm/Makefile b/mm/Makefile
> index 8e105e5b3e29..d9bb14fdf220 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -40,7 +40,7 @@ mmu-y                       := nommu.o
>  mmu-$(CONFIG_MMU)    := highmem.o memory.o mincore.o \
>                          mlock.o mmap.o mmu_gather.o mprotect.o mremap.o \
>                          msync.o page_vma_mapped.o pagewalk.o \
> -                        pgtable-generic.o rmap.o vmalloc.o
> +                        pgtable-generic.o rmap.o vmalloc.o ptshare.o
>
>
>  ifdef CONFIG_CROSS_MEMORY_ATTACH
> diff --git a/mm/internal.h b/mm/internal.h
> index 4d60d2d5fe19..3efb8738e26f 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1047,4 +1047,18 @@ static inline bool vma_is_shared(const struct vm_area_struct *vma)
>  {
>       return vma->vm_flags & VM_SHARED_PT;
>  }
> +
> +/*
> + * mm/ptshare.c
> + */
> +struct ptshare_data {
> +     struct mm_struct *mm;
> +     refcount_t refcnt;
> +     unsigned long start;
> +     unsigned long size;
> +     unsigned long mode;
> +};

Why does ptshare_data contain the start address, size and mode of the
mapping? Does it mean ptshare_data can represent only a single mapping
of the file (the one that begins at ptshare_data->start)? What if we
want to share multiple different mappings of the same file (which may
or may not intersect)?

If we choose to use the VMAs in host_mm for that, will this possibly create
a lot of special-cased VMA handling?

> +int ptshare_new_mm(struct file *file, struct vm_area_struct *vma);
> +void ptshare_del_mm(struct vm_area_struct *vm);
> +int ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma);
>  #endif       /* __MM_INTERNAL_H */
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 8b46d465f8d4..c5e9b7f6de90 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1382,6 +1382,60 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>           ((vm_flags & VM_LOCKED) ||
>            (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
>               *populate = len;
> +
> +#if VM_SHARED_PT
> +     /*
> +      * Check if this mapping is a candidate for page table sharing
> +      * at PMD level. It is if following conditions hold:
> +      *      - It is not anonymous mapping
> +      *      - It is not hugetlbfs mapping (for now)
> +      *      - flags conatins MAP_SHARED or MAP_SHARED_VALIDATE and
> +      *        MAP_SHARED_PT
> +      *      - Start address is aligned to PMD size
> +      *      - Mapping size is a multiple of PMD size
> +      */
> +     if (ptshare && file && !is_file_hugepages(file)) {
> +             struct vm_area_struct *vma;
> +
> +             vma = find_vma(mm, addr);
> +             if (!((vma->vm_start | vma->vm_end) & (PMD_SIZE - 1))) {
> +                     struct ptshare_data *info = file->f_mapping->ptshare_data;

This is racy with another process trying to share the same mapping of
the file. It's also racy with the removal (this process can get a
pointer to ptshare_data that's currently being freed).

> +                     /*
> +                      * If this mapping has not been set up for page table
> +                      * sharing yet, do so by creating a new mm to hold the
> +                      * shared page tables for this mapping
> +                      */
> +                     if (info == NULL) {
> +                             int ret;
> +
> +                             ret = ptshare_new_mm(file, vma);
> +                             if (ret < 0)
> +                                     return ret;
> +
> +                             info = file->f_mapping->ptshare_data;
> +                             ret = ptshare_insert_vma(info->mm, vma);
> +                             if (ret < 0)
> +                                     addr = ret;
> +                             else
> +                                     vm_flags_set(vma, VM_SHARED_PT);

Creation might race with another process.

> +                     } else {
> +                             /*
> +                              * Page tables will be shared only if the
> +                              * file is mapped in with the same permissions
> +                              * across all mappers with same starting
> +                              * address and size
> +                              */
> +                             if (((prot & info->mode) == info->mode) &&
> +                                     (addr == info->start) &&
> +                                     (len == info->size)) {
> +                                     vm_flags_set(vma, VM_SHARED_PT);
> +                                     refcount_inc(&info->refcnt);
> +                             }
> +                     }
> +             }
> +     }
> +#endif
> +
>       return addr;
>  }
>
> @@ -2495,6 +2549,22 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>       if (end == start)
>               return -EINVAL;
>
> +     /*
> +      * Check if this vma uses shared page tables
> +      */
> +     vma = find_vma_intersection(mm, start, end);
> +     if (vma && unlikely(vma_is_shared(vma))) {
> +             struct ptshare_data *info = NULL;
> +
> +             if (vma->vm_file && vma->vm_file->f_mapping)
> +                     info = vma->vm_file->f_mapping->ptshare_data;
> +             /* Don't allow partial munmaps */
> +             if (info && ((start != info->start) || (len != info->size)))
> +                     return -EINVAL;
> +             ptshare_del_mm(vma);
> +     }
> +
> +
>        /* arch_unmap() might do unmaps itself.  */
>       arch_unmap(mm, start, end);
>
> @@ -2664,6 +2734,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>                       }
>               }
>
> +             if (vm_flags & VM_SHARED_PT)
> +                     vm_flags_set(vma, VM_SHARED_PT);
>               vm_flags = vma->vm_flags;
>       } else if (vm_flags & VM_SHARED) {
>               error = shmem_zero_setup(vma);
> diff --git a/mm/ptshare.c b/mm/ptshare.c
> new file mode 100644
> index 000000000000..f6784268958c
> --- /dev/null
> +++ b/mm/ptshare.c
> @@ -0,0 +1,126 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Share page table entries when possible to reduce the amount of extra
> + * memory consumed by page tables
> + *
> + * Copyright (C) 2022 Oracle Corp. All rights reserved.
> + * Authors:  Khalid Aziz <khalid.aziz@oracle.com>
> + *           Matthew Wilcox <willy@infradead.org>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/fs.h>
> +#include <asm/pgalloc.h>
> +#include "internal.h"
> +
> +/*
> + * Create a new mm struct that will hold the shared PTEs. Pointer to
> + * this new mm is stored in the data structure ptshare_data which also
> + * includes a refcount for any current references to PTEs in this new
> + * mm. This refcount is used to determine when the mm struct for shared
> + * PTEs can be deleted.
> + */
> +int
> +ptshare_new_mm(struct file *file, struct vm_area_struct *vma)
> +{
> +     struct mm_struct *new_mm;
> +     struct ptshare_data *info = NULL;
> +     int retval = 0;
> +     unsigned long start = vma->vm_start;
> +     unsigned long len = vma->vm_end - vma->vm_start;
> +
> +     new_mm = mm_alloc();
> +     if (!new_mm) {
> +             retval = -ENOMEM;
> +             goto err_free;
> +     }
> +     new_mm->mmap_base = start;
> +     new_mm->task_size = len;
> +     if (!new_mm->task_size)
> +             new_mm->task_size--;
> +
> +     info = kzalloc(sizeof(*info), GFP_KERNEL);
> +     if (!info) {
> +             retval = -ENOMEM;
> +             goto err_free;
> +     }
> +     info->mm = new_mm;
> +     info->start = start;
> +     info->size = len;
> +     refcount_set(&info->refcnt, 1);
> +     file->f_mapping->ptshare_data = info;

Racy assignement. It can lead to a memory leak if another process does
the same concurrently and assigns before or after this one. The new_mm
and ptshare_data of one of them will be lost.

I think this whole process needs to be protected with i_mmap lock.

> +
> +     return retval;
> +
> +err_free:
> +     if (new_mm)
> +             mmput(new_mm);
> +     kfree(info);
> +     return retval;
> +}
> +
> +/*
> + * insert vma into mm holding shared page tables
> + */
> +int
> +ptshare_insert_vma(struct mm_struct *mm, struct vm_area_struct *vma)
> +{
> +     struct vm_area_struct *new_vma;
> +     int err = 0;
> +
> +     new_vma = vm_area_dup(vma);
> +     if (!new_vma)
> +             return -ENOMEM;
> +
> +     new_vma->vm_file = NULL;
> +     /*
> +      * This new vma belongs to host mm, so clear the VM_SHARED_PT
> +      * flag on this so we know this is the host vma when we clean
> +      * up page tables. Do not use THP for page table shared regions
> +      */
> +     vm_flags_clear(new_vma, (VM_SHARED | VM_SHARED_PT));
> +     vm_flags_set(new_vma, VM_NOHUGEPAGE);
> +     new_vma->vm_mm = mm;
> +
> +     err = insert_vm_struct(mm, new_vma);
> +     if (err)
> +             return -ENOMEM;
> +
> +     return err;
> +}
> +
> +/*
> + * Free the mm struct created to hold shared PTEs and associated data
> + * structures
> + */
> +static inline void
> +free_ptshare_mm(struct ptshare_data *info)
> +{
> +     mmput(info->mm);
> +     kfree(info);
> +}
> +
> +/*
> + * This function is called when a reference to the shared PTEs in mm
> + * struct is dropped. It updates refcount and checks to see if last
> + * reference to the mm struct holding shared PTEs has been dropped. If
> + * so, it cleans up the mm struct and associated data structures
> + */
> +void
> +ptshare_del_mm(struct vm_area_struct *vma)
> +{
> +     struct ptshare_data *info;
> +     struct file *file = vma->vm_file;
> +
> +     if (!file || (!file->f_mapping))
> +             return;
> +     info = file->f_mapping->ptshare_data;
> +     WARN_ON(!info);
> +     if (!info)
> +             return;
> +
> +     if (refcount_dec_and_test(&info->refcnt)) {
> +             free_ptshare_mm(info);
> +             file->f_mapping->ptshare_data = NULL;

Maybe those two should be reordered (after keeping a pointer to
ptshare_data). Then setting f_mapping->ptshare_data to NULL can
be performed under a lock and freeing ptshare and host_mm can be
done without a lock.

Cheers
Karim
