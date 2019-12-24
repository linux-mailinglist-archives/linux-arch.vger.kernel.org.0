Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA90129C9A
	for <lists+linux-arch@lfdr.de>; Tue, 24 Dec 2019 03:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfLXCOc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 23 Dec 2019 21:14:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33034 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfLXCOc (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 23 Dec 2019 21:14:32 -0500
Received: by mail-qk1-f196.google.com with SMTP id d71so7195456qkc.0;
        Mon, 23 Dec 2019 18:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Dn59xurB+BtlhSXYYXwcYKvyxvrHBMqEGd+kiukgqtE=;
        b=dJHA+JDYBFu+hr3tDoWY8mOY/o0a0L1QRcsZt8kkozE+84w3njls/0l6rwOR3/75Qk
         gYsBOXcZVQd4KJLYDE/WoLzyMGar3PwK1veWdc1qIHWf4yji4Awa+OElpuuApuX6sXWU
         Vn0k7xie3QBAh9slLTIycdsgYGfNHyFWJRQVPdRFSyYV98dyvKY+wkCRdoA2Ey7Oiokx
         jeECYboF1HSVvOxqXyp2HQO/3K4ZXgknFMLa731E5XgGeKU7aLG+AMIopXscFPDEDTfJ
         Y9ohtOlYxcYtJ15uTbzVh8pvtKedyJ1F2uiPm9uYKslDe1PHA49fmw5J9/ivwxgN/owD
         NPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Dn59xurB+BtlhSXYYXwcYKvyxvrHBMqEGd+kiukgqtE=;
        b=deBmPDmIYFBs7sJr/Qk8uQK0jjlqraRHY/KM3CMCpqEM70VJpiEJAhVYKOCHEbpoh8
         uVsrQ1oG+gc0ovpSJix2g67Xv1UpeSeDVPdd8RSGvpDGFv1Kue2v8RSAZes3O6lJ/FOi
         PIOBK/6MAOaQd4A0MfLXxp7UYtLodyiIsiZllXgOiiKRODc2SpEkc9JMHuJIRlNlHEYl
         ITmPcXJf6+6VG36B4Dotu9ywN6tMn4Mh3BNqtnhEv+GKVPSvLmwVVkSLeWHWh9gIk3SY
         BgRmBXAwuYzXQEZnqP82G9a23P2b4nTpDHXyMvIE6a7T+7wKVMx82NMoApZ6g/gekE7T
         uapw==
X-Gm-Message-State: APjAAAUMnlDxAYE4koaMcTxI/3iMB1c1fIE63zh9FEB/Is63XvAJhmrO
        NxcCHKYrWIR05gfvoIUyWIUC0Y1PyMEmudnijBo=
X-Google-Smtp-Source: APXvYqwC7pwfR+JtdHeC+QQZ7mwlLkpkVC2Wz0jzZn+khxA7LQgmwhfkE+Fw/um9P5MPCKs9y9YWN0BLpeSkiT3/lN4=
X-Received: by 2002:ae9:e10e:: with SMTP id g14mr29777508qkm.430.1577153670751;
 Mon, 23 Dec 2019 18:14:30 -0800 (PST)
MIME-Version: 1.0
References: <20191223110004.2157-1-rppt@kernel.org> <20191223110004.2157-2-rppt@kernel.org>
In-Reply-To: <20191223110004.2157-2-rppt@kernel.org>
From:   Greentime Hu <green.hu@gmail.com>
Date:   Tue, 24 Dec 2019 10:13:53 +0800
Message-ID: <CAEbi=3eGPkQLALqspua3g0ZLkkm+t7myW8hopZO+dzQhpf4DmQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] asm-generic/nds32: don't redefine cacheflush primitives
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Mike Rapoport <rppt@kernel.org> =E6=96=BC 2019=E5=B9=B412=E6=9C=8823=E6=97=
=A5 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=887:00=E5=AF=AB=E9=81=93=EF=BC=9A
>
> From: Mike Rapoport <rppt@linux.ibm.com>
>
> The commit c296d4dc13ae ("asm-generic: fix a compilation warning") change=
d
> asm-generic/cachflush.h to use static inlines instead of macros and as a
> result the nds32 build with CONFIG_CPU_CACHE_ALIASING=3Dn fails:
>
>   CC      init/main.o
> In file included from arch/nds32/include/asm/cacheflush.h:43,
>                  from include/linux/highmem.h:12,
>                  from include/linux/pagemap.h:11,
>                  from include/linux/blkdev.h:16,
>                  from include/linux/blk-cgroup.h:23,
>                  from include/linux/writeback.h:14,
>                  from init/main.c:44:
> include/asm-generic/cacheflush.h:50:20: error: static declaration of 'flu=
sh_icache_range' follows non-static declaration
>  static inline void flush_icache_range(unsigned long start, unsigned long=
 end)
>                     ^~~~~~~~~~~~~~~~~~
> In file included from include/linux/highmem.h:12,
>                  from include/linux/pagemap.h:11,
>                  from include/linux/blkdev.h:16,
>                  from include/linux/blk-cgroup.h:23,
>                  from include/linux/writeback.h:14,
>                  from init/main.c:44:
> arch/nds32/include/asm/cacheflush.h:11:6: note: previous declaration of '=
flush_icache_range' was here
>  void flush_icache_range(unsigned long start, unsigned long end);
>       ^~~~~~~~~~~~~~~~~~
>
> Surround the inline functions in asm-generic/cacheflush.h by ifdef's so
> that architectures could override them and add the required overrides to
> nds32.
>
> Fixes: c296d4dc13ae ("asm-generic: fix a compilation warning")
> Link: https://lore.kernel.org/lkml/201912212139.yptX8CsV%25lkp@intel.com/
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>  arch/nds32/include/asm/cacheflush.h | 11 ++++++----
>  include/asm-generic/cacheflush.h    | 33 ++++++++++++++++++++++++++++-
>  2 files changed, 39 insertions(+), 5 deletions(-)
>
> diff --git a/arch/nds32/include/asm/cacheflush.h b/arch/nds32/include/asm=
/cacheflush.h
> index d9ac7e6408ef..caddded56e77 100644
> --- a/arch/nds32/include/asm/cacheflush.h
> +++ b/arch/nds32/include/asm/cacheflush.h
> @@ -9,7 +9,11 @@
>  #define PG_dcache_dirty PG_arch_1
>
>  void flush_icache_range(unsigned long start, unsigned long end);
> +#define flush_icache_range flush_icache_range
> +
>  void flush_icache_page(struct vm_area_struct *vma, struct page *page);
> +#define flush_icache_page flush_icache_page
> +
>  #ifdef CONFIG_CPU_CACHE_ALIASING
>  void flush_cache_mm(struct mm_struct *mm);
>  void flush_cache_dup_mm(struct mm_struct *mm);
> @@ -40,12 +44,11 @@ void invalidate_kernel_vmap_range(void *addr, int siz=
e);
>  #define flush_dcache_mmap_unlock(mapping) xa_unlock_irq(&(mapping)->i_pa=
ges)
>
>  #else
> -#include <asm-generic/cacheflush.h>
> -#undef flush_icache_range
> -#undef flush_icache_page
> -#undef flush_icache_user_range
>  void flush_icache_user_range(struct vm_area_struct *vma, struct page *pa=
ge,
>                              unsigned long addr, int len);
> +#define flush_icache_user_range flush_icache_user_range
> +
> +#include <asm-generic/cacheflush.h>
>  #endif
>
>  #endif /* __NDS32_CACHEFLUSH_H__ */
> diff --git a/include/asm-generic/cacheflush.h b/include/asm-generic/cache=
flush.h
> index a950a22c4890..cac7404b2bdd 100644
> --- a/include/asm-generic/cacheflush.h
> +++ b/include/asm-generic/cacheflush.h
> @@ -11,71 +11,102 @@
>   * The cache doesn't need to be flushed when TLB entries change when
>   * the cache is mapped to physical memory, not virtual memory
>   */
> +#ifndef flush_cache_all
>  static inline void flush_cache_all(void)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_mm
>  static inline void flush_cache_mm(struct mm_struct *mm)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_dup_mm
>  static inline void flush_cache_dup_mm(struct mm_struct *mm)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_range
>  static inline void flush_cache_range(struct vm_area_struct *vma,
>                                      unsigned long start,
>                                      unsigned long end)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_page
>  static inline void flush_cache_page(struct vm_area_struct *vma,
>                                     unsigned long vmaddr,
>                                     unsigned long pfn)
>  {
>  }
> +#endif
>
> +#ifndef flush_dcache_page
>  static inline void flush_dcache_page(struct page *page)
>  {
>  }
> +#endif
>
> +#ifndef flush_dcache_mmap_lock
>  static inline void flush_dcache_mmap_lock(struct address_space *mapping)
>  {
>  }
> +#endif
>
> +#ifndef flush_dcache_mmap_unlock
>  static inline void flush_dcache_mmap_unlock(struct address_space *mappin=
g)
>  {
>  }
> +#endif
>
> +#ifndef flush_icache_range
>  static inline void flush_icache_range(unsigned long start, unsigned long=
 end)
>  {
>  }
> +#endif
>
> +#ifndef flush_icache_page
>  static inline void flush_icache_page(struct vm_area_struct *vma,
>                                      struct page *page)
>  {
>  }
> +#endif
>
> +#ifndef flush_icache_user_range
>  static inline void flush_icache_user_range(struct vm_area_struct *vma,
>                                            struct page *page,
>                                            unsigned long addr, int len)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_vmap
>  static inline void flush_cache_vmap(unsigned long start, unsigned long e=
nd)
>  {
>  }
> +#endif
>
> +#ifndef flush_cache_vunmap
>  static inline void flush_cache_vunmap(unsigned long start, unsigned long=
 end)
>  {
>  }
> +#endif
>
> -#define copy_to_user_page(vma, page, vaddr, dst, src, len) \
> +#ifndef copy_to_user_page
> +#define copy_to_user_page(vma, page, vaddr, dst, src, len)     \
>         do { \
>                 memcpy(dst, src, len); \
>                 flush_icache_user_range(vma, page, vaddr, len); \
>         } while (0)
> +#endif
> +
> +#ifndef copy_from_user_page
>  #define copy_from_user_page(vma, page, vaddr, dst, src, len) \
>         memcpy(dst, src, len)
> +#endif
>
>  #endif /* __ASM_CACHEFLUSH_H */

Thank you, Mike.
Reviewed-by: Greentime Hu <green.hu@gmail.com>
