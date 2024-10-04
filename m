Return-Path: <linux-arch+bounces-7702-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C340990AD5
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 20:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EF671F228EE
	for <lists+linux-arch@lfdr.de>; Fri,  4 Oct 2024 18:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1ED1C3044;
	Fri,  4 Oct 2024 18:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lpPhuM+u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE0E1E3785
	for <linux-arch@vger.kernel.org>; Fri,  4 Oct 2024 18:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728065847; cv=none; b=a6v3m7hfQdqNrqi9mN7VLcCQq1ObbBlpL6DqXB2qWvdLCrPGjugxFldcsFJiUkDxiAWzaXVzifH5+8GZ19fcEa2j/wISaFAxk3r2FITuWaKwy/hTJ+j14v6AQd83FHipL3ve2IiRQu8IEiLIZ3oOHvgcybPDxtX1MLmChrfLncM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728065847; c=relaxed/simple;
	bh=bQtoaaPY3LL/uKF3YMTInrh0Dm1vi999UrSDUhyKl/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgJl9cQ+SCGyhv69TdRuDMi0rjoAal0/WJ1PY+qgaLPfcVhe6hbMqM3TJApQQrl6qyEUbB7y5NPC8XcVweT7U+hF8T/uOfL8VGLzHxzoBgTIFkWDmNosegFNfvrKUJZSe232WT4iNT5SXNHrcxm388P22/102raSlX1Qch+7nTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lpPhuM+u; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-2877da58a20so104393fac.2
        for <linux-arch@vger.kernel.org>; Fri, 04 Oct 2024 11:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728065845; x=1728670645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNH0oJNpe/bTkwrHuGm9kRIw5J8BcCwGdVTZ/6zJlcE=;
        b=lpPhuM+uqUzoMD2uk9UsJHA+pwBz41Rk0Mvf9FR+ax0Hh4i1xQwsxW3TkIxns3cK5m
         xbYTsvlELGkINreoMfRAEhi4ngKWy79+F/hHt9Jpm0PcQYj0UHKgVs+7FXChO8iDtLgg
         BJ/Y2JIHL+/t2sj9xTaVrVHzXZdgDtAonwWMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728065845; x=1728670645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNH0oJNpe/bTkwrHuGm9kRIw5J8BcCwGdVTZ/6zJlcE=;
        b=BOcT3Lse1NkMIA0/zgjRen5cDj5nvmXH5+j4pKsAd3KqFzy6qXo+nvEnrTwGy47x9k
         VGJ2hBwcTWWiG0dNH3BMe9oM2tK2BhKebFNx3eQYEnoL7D6vt4tFiwSfzoBluG7dovai
         cWX5xqlNsrkKfZwMohqU2UjDuMbfqL9eAA11q2UQnqdL1ugH9ORHnJXAAe+mOrCzEI34
         kRkck3nGHgB2SFCOfDQClnzkSxhXEesXuBJ9EmiAFN48w/sWynJAhfcrJFnEBZxc9Ajh
         YRazMhFKnxUG0y0hW6rSBLFh9VSh0wBg+CEWCVMDGFRXlZX1Ih6VbzZ7UBBtgKP06sgC
         JN6A==
X-Forwarded-Encrypted: i=1; AJvYcCVmGk9VsV/zFYT6Z8gZqe9tEOJq7Jrqci2Y3BZWyI3+rP1pYqkMe7QxSrtdUOIUW4vrUfFWoujOZkwQ@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhCb3oYU0KyTiB5O3Yk3sd5++Vrptfo7t6qT7c0Aalb9FBEXk
	kZsAWF5ufFhxxv8cKLeG8ZEDmwhtLAVtaM7gQ16TVHhvG5BSy0nE0FuMXOGMd370bu5/VKzgd4A
	dVDGg+sqmfSQ5kBe3ZQkplijzCJZfU3HIqbwC
X-Google-Smtp-Source: AGHT+IEBuk65mXnQmA+bPkWVVOmPVtTM05MxGP01b7TqmGd4Bj6qVn16brn+k1A6yf9ZtcCEaxdKBLpSxZbHRluDzhE=
X-Received: by 2002:a05:6870:89a3:b0:286:f523:4d76 with SMTP id
 586e51a60fabf-287c1e16b7dmr738482fac.6.1728065844617; Fri, 04 Oct 2024
 11:17:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com> <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Fri, 4 Oct 2024 11:17:13 -0700
Message-ID: <CABi2SkWzjTVjEwED_QjNz385m4aGo8OfAS2RkRjuZdpSviNkJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, 
	David Hildenbrand <david@redhat.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	Muchun Song <muchun.song@linux.dev>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Chris Zankel <chris@zankel.net>, Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org, 
	Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>, linux-kselftest@vger.kernel.org, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, Vlastimil Babka <vbabka@suze.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lorenzo,

Please add me to this series, I 'm interested in everything related to
mseal :-), thanks.

I also added Kees into the cc, since mseal is a security feature.


On Fri, Sep 27, 2024 at 5:52=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> Implement a new lightweight guard page feature, that is regions of userla=
nd
> virtual memory that, when accessed, cause a fatal signal to arise.
>
> Currently users must establish PROT_NONE ranges to achieve this.
>
> However this is very costly memory-wise - we need a VMA for each and ever=
y
> one of these regions AND they become unmergeable with surrounding VMAs.
>
> In addition repeated mmap() calls require repeated kernel context switche=
s
> and contention of the mmap lock to install these ranges, potentially also
> having to unmap memory if installed over existing ranges.
>
> The lightweight guard approach eliminates the VMA cost altogether - rathe=
r
> than establishing a PROT_NONE VMA, it operates at the level of page table
> entries - poisoning PTEs such that accesses to them cause a fault followe=
d
> by a SIGSGEV signal being raised.
>
> This is achieved through the PTE marker mechanism, which a previous commi=
t
> in this series extended to permit this to be done, installed via the
> generic page walking logic, also extended by a prior commit for this
> purpose.
>
> These poison ranges are established with MADV_GUARD_POISON, and if the
> range in which they are installed contain any existing mappings, they wil=
l
> be zapped, i.e. free the range and unmap memory (thus mimicking the
> behaviour of MADV_DONTNEED in this respect).
>
> Any existing poison entries will be left untouched. There is no nesting o=
f
> poisoned pages.
>
> Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
> unexpected behaviour, but are cleared on process teardown or unmapping of
> memory ranges.
>
> Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> 'remedying' the poisoning. The ranges over which this is applied, should
> they contain non-poison entries, will be untouched, only poison entries
> will be cleared.
>
> We permit this operation on anonymous memory only, and only VMAs which ar=
e
> non-special, non-huge and not mlock()'d (if we permitted this we'd have t=
o
> drop locked pages which would be rather counterintuitive).
>
> The poisoning of the range must be performed under mmap write lock as we
> have to install an anon_vma to ensure correct behaviour on fork.
>
> Suggested-by: Vlastimil Babka <vbabka@suze.cz>
> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  arch/alpha/include/uapi/asm/mman.h     |   3 +
>  arch/mips/include/uapi/asm/mman.h      |   3 +
>  arch/parisc/include/uapi/asm/mman.h    |   3 +
>  arch/xtensa/include/uapi/asm/mman.h    |   3 +
>  include/uapi/asm-generic/mman-common.h |   3 +
>  mm/madvise.c                           | 158 +++++++++++++++++++++++++
>  mm/mprotect.c                          |   3 +-
>  mm/mseal.c                             |   1 +
>  8 files changed, 176 insertions(+), 1 deletion(-)
>
> diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/uapi=
/asm/mman.h
> index 763929e814e9..71e13f27742d 100644
> --- a/arch/alpha/include/uapi/asm/mman.h
> +++ b/arch/alpha/include/uapi/asm/mman.h
> @@ -78,6 +78,9 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_GUARD_POISON 102          /* fatal signal on access to rang=
e */
> +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning=
 */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/uapi/a=
sm/mman.h
> index 9c48d9a21aa0..1a2222322f77 100644
> --- a/arch/mips/include/uapi/asm/mman.h
> +++ b/arch/mips/include/uapi/asm/mman.h
> @@ -105,6 +105,9 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_GUARD_POISON 102          /* fatal signal on access to rang=
e */
> +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning=
 */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/include/ua=
pi/asm/mman.h
> index 68c44f99bc93..380905522397 100644
> --- a/arch/parisc/include/uapi/asm/mman.h
> +++ b/arch/parisc/include/uapi/asm/mman.h
> @@ -75,6 +75,9 @@
>  #define MADV_HWPOISON     100          /* poison a page for testing */
>  #define MADV_SOFT_OFFLINE 101          /* soft offline page for testing =
*/
>
> +#define MADV_GUARD_POISON 102          /* fatal signal on access to rang=
e */
> +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning=
 */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/include/ua=
pi/asm/mman.h
> index 1ff0c858544f..e8d5affceb28 100644
> --- a/arch/xtensa/include/uapi/asm/mman.h
> +++ b/arch/xtensa/include/uapi/asm/mman.h
> @@ -113,6 +113,9 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_GUARD_POISON 102          /* fatal signal on access to rang=
e */
> +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning=
 */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/asm-ge=
neric/mman-common.h
> index 6ce1f1ceb432..5dfd3d442de4 100644
> --- a/include/uapi/asm-generic/mman-common.h
> +++ b/include/uapi/asm-generic/mman-common.h
> @@ -79,6 +79,9 @@
>
>  #define MADV_COLLAPSE  25              /* Synchronous hugepage collapse =
*/
>
> +#define MADV_GUARD_POISON 102          /* fatal signal on access to rang=
e */
> +#define MADV_GUARD_UNPOISON 103                /* revoke guard poisoning=
 */
> +
>  /* compatibility flags */
>  #define MAP_FILE       0
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index e871a72a6c32..7216e10723ae 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
>         case MADV_POPULATE_READ:
>         case MADV_POPULATE_WRITE:
>         case MADV_COLLAPSE:
> +       case MADV_GUARD_UNPOISON: /* Only poisoning needs a write lock. *=
/
>                 return 0;
>         default:
>                 /* be safe, default to 1. list exceptions explicitly */
> @@ -1017,6 +1018,157 @@ static long madvise_remove(struct vm_area_struct =
*vma,
>         return error;
>  }
>
> +static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allow_lo=
cked)
> +{
> +       vm_flags_t disallowed =3D VM_SPECIAL | VM_HUGETLB;
> +
> +       /*
> +        * A user could lock after poisoning but that's fine, as they'd n=
ot be
> +        * able to fault in. The issue arises when we try to zap existing=
 locked
> +        * VMAs. We don't want to do that.
> +        */
> +       if (!allow_locked)
> +               disallowed |=3D VM_LOCKED;
> +
> +       if (!vma_is_anonymous(vma))
> +               return false;
> +
> +       if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) !=3D VM_MAYWRITE=
)
> +               return false;
> +
> +       return true;
> +}
> +
> +static int guard_poison_install_pte(unsigned long addr, unsigned long ne=
xt,
> +                                   pte_t *ptep, struct mm_walk *walk)
> +{
> +       unsigned long *num_installed =3D (unsigned long *)walk->private;
> +
> +       (*num_installed)++;
> +       /* Simply install a PTE marker, this causes segfault on access. *=
/
> +       *ptep =3D make_pte_marker(PTE_MARKER_GUARD);
> +
> +       return 0;
> +}
> +
> +static bool is_guard_pte_marker(pte_t ptent)
> +{
> +       return is_pte_marker(ptent) &&
> +               is_guard_swp_entry(pte_to_swp_entry(ptent));
> +}
> +
> +static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
> +                                 unsigned long next, struct mm_walk *wal=
k)
> +{
> +       pte_t ptent =3D ptep_get(pte);
> +
> +       /*
> +        * If not a guard marker, simply abort the operation. We return a=
 value
> +        * > 0 indicating a non-error abort.
> +        */
> +       return !is_guard_pte_marker(ptent);
> +}
> +
> +static const struct mm_walk_ops guard_poison_walk_ops =3D {
> +       .install_pte            =3D guard_poison_install_pte,
> +       .pte_entry              =3D guard_poison_pte_entry,
> +       /* We might need to install an anon_vma. */
> +       .walk_lock              =3D PGWALK_WRLOCK,
> +};
> +
> +static long madvise_guard_poison(struct vm_area_struct *vma,
> +                                struct vm_area_struct **prev,
> +                                unsigned long start, unsigned long end)
> +{
> +       long err;
> +       bool retried =3D false;
> +
> +       *prev =3D vma;
> +       if (!is_valid_guard_vma(vma, /* allow_locked =3D */false))
> +               return -EINVAL;
> +
> +       /*
> +        * Optimistically try to install the guard poison pages first. If=
 any
> +        * non-guard pages are encountered, give up and zap the range bef=
ore
> +        * trying again.
> +        */
> +       while (true) {
> +               unsigned long num_installed =3D 0;
> +
> +               /* Returns < 0 on error, =3D=3D 0 if success, > 0 if zap =
needed. */
> +               err =3D walk_page_range_mm(vma->vm_mm, start, end,
> +                                        &guard_poison_walk_ops,
> +                                        &num_installed);
> +               /*
> +                * If we install poison markers, then the range is no lon=
ger
> +                * empty from a page table perspective and therefore it's
> +                * appropriate to have an anon_vma.
> +                *
> +                * This ensures that on fork, we copy page tables correct=
ly.
> +                */
> +               if (err >=3D 0 && num_installed > 0) {
> +                       int err_anon =3D anon_vma_prepare(vma);
> +
> +                       if (err_anon)
> +                               err =3D err_anon;
> +               }
> +
> +               if (err <=3D 0)
> +                       return err;
> +
> +               if (!retried)
> +                       /*
> +                        * OK some of the range have non-guard pages mapp=
ed, zap
> +                        * them. This leaves existing guard pages in plac=
e.
> +                        */
> +                       zap_page_range_single(vma, start, end - start, NU=
LL);
> +               else
> +                       /*
> +                        * If we reach here, then there is a racing fault=
 that
> +                        * has populated the PTE after we zapped. Give up=
 and
> +                        * let the user know to try again.
> +                        */
> +                       return -EAGAIN;
> +
> +               retried =3D true;
> +       }
> +}
> +
> +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> +                                   unsigned long next, struct mm_walk *w=
alk)
> +{
> +       pte_t ptent =3D ptep_get(pte);
> +
> +       if (is_guard_pte_marker(ptent)) {
> +               /* Simply clear the PTE marker. */
> +               pte_clear_not_present_full(walk->mm, addr, pte, true);
> +               update_mmu_cache(walk->vma, addr, pte);
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct mm_walk_ops guard_unpoison_walk_ops =3D {
> +       .pte_entry              =3D guard_unpoison_pte_entry,
> +       .walk_lock              =3D PGWALK_RDLOCK,
> +};
> +
> +static long madvise_guard_unpoison(struct vm_area_struct *vma,
> +                                  struct vm_area_struct **prev,
> +                                  unsigned long start, unsigned long end=
)
> +{
> +       *prev =3D vma;
> +       /*
> +        * We're ok with unpoisoning mlock()'d ranges, as this is a
> +        * non-destructive action.
> +        */
> +       if (!is_valid_guard_vma(vma, /* allow_locked =3D */true))
> +               return -EINVAL;
> +
> +       return walk_page_range(vma->vm_mm, start, end,
> +                              &guard_unpoison_walk_ops, NULL);
> +}
> +
>  /*
>   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>   * will handle splitting a vm area into separate areas, each area with i=
ts own
> @@ -1098,6 +1250,10 @@ static int madvise_vma_behavior(struct vm_area_str=
uct *vma,
>                 break;
>         case MADV_COLLAPSE:
>                 return madvise_collapse(vma, prev, start, end);
> +       case MADV_GUARD_POISON:
> +               return madvise_guard_poison(vma, prev, start, end);
> +       case MADV_GUARD_UNPOISON:
> +               return madvise_guard_unpoison(vma, prev, start, end);
>         }
>
>         anon_name =3D anon_vma_name(vma);
> @@ -1197,6 +1353,8 @@ madvise_behavior_valid(int behavior)
>         case MADV_DODUMP:
>         case MADV_WIPEONFORK:
>         case MADV_KEEPONFORK:
> +       case MADV_GUARD_POISON:
> +       case MADV_GUARD_UNPOISON:
>  #ifdef CONFIG_MEMORY_FAILURE
>         case MADV_SOFT_OFFLINE:
>         case MADV_HWPOISON:
> diff --git a/mm/mprotect.c b/mm/mprotect.c
> index 0c5d6d06107d..d0e3ebfadef8 100644
> --- a/mm/mprotect.c
> +++ b/mm/mprotect.c
> @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>                         } else if (is_pte_marker_entry(entry)) {
>                                 /*
>                                  * Ignore error swap entries unconditiona=
lly,
> -                                * because any access should sigbus anywa=
y.
> +                                * because any access should sigbus/sigse=
gv
> +                                * anyway.
>                                  */
>                                 if (is_poisoned_swp_entry(entry))
>                                         continue;
> diff --git a/mm/mseal.c b/mm/mseal.c
> index ece977bd21e1..21bf5534bcf5 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
>         case MADV_REMOVE:
>         case MADV_DONTFORK:
>         case MADV_WIPEONFORK:
> +       case MADV_GUARD_POISON:

Can you please describe the rationale to add this to the existing
mseal's semantic ?

I didn't not find any description from the cover letter or this
patch's description, hence asking.

Thanks
-Jeff

>                 return true;
>         }
>
> --
> 2.46.2
>
>

