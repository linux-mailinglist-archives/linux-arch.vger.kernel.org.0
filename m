Return-Path: <linux-arch+bounces-8053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A735499AADD
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 20:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CB1E1F240B7
	for <lists+linux-arch@lfdr.de>; Fri, 11 Oct 2024 18:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD671CCB51;
	Fri, 11 Oct 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="db04udrj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43121C9EAF
	for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 18:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728670337; cv=none; b=LFvAl7iPUlbtzil8PFHgNsqqE4rZH9JVT9Ka02qWRAoxoZGkt8OgHeTJTnzGDbBb3PyzXyuU7YsGD0qezVI1RC9D5mFG9vAvi2MNpRt/Kp32lYvzepZz3pT38FwigBK/WYjpM+cT0vhwGX/5bJ3rzbfjNPZkq0kYl4vl/14qCg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728670337; c=relaxed/simple;
	bh=r95hHR2I319NNh4LBWo+gWmOZQHDCJgPNbLKzRADYd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XVJXUGso3a5Fiu43cvUhE1uIhDi90igJNS9LIo18ixX96mzbh1nZZMDDt6A6wL6LxREp/gJdeMNJWXX0qpuNo5Uh6ZyOW66FQGRQehcP28O4Tcc7ozZnv6yHS+uweC/rcwSjSm5iHeDxpudmBT0/A+0t7etscutcywbOMiGRfz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=db04udrj; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e19d8c41so2814e87.0
        for <linux-arch@vger.kernel.org>; Fri, 11 Oct 2024 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728670333; x=1729275133; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UUuCTwGEAieQUuHz9Si/8fQwhBeTxrZR6ij+65t6Jm8=;
        b=db04udrjpQmgDQiyivjyJEAepsiIB951idjv00I5B55zlLVCcytCnYDuSY+5MFI6+G
         jWzeh0QQbehoerjomKIJPa7Oo7oVqNL+XblI1IODEQzY/Ku8U5yYgB4QSG33uTr9V2Kj
         VWzJHTABI5iF/FUyF3PbHQI68gA4soJgV9pc+yZGImt+cMR12X9pDyP9wlsW2GsaLkpX
         NtNg+GsDIRYiu6mcDiG1bdYqvujafeQLj4lfVgZ7DIo9KFuOKsb7dKS18IvBLpekZnor
         cVSNn0x4trxgL3quErNxMb17WTIntKONnUpFFP9txBVYU4plfGmBOcfV9AFBOcuZkAAD
         gW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728670333; x=1729275133;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UUuCTwGEAieQUuHz9Si/8fQwhBeTxrZR6ij+65t6Jm8=;
        b=vpJ+PaBAxXF4hKi7SicJKmbYEHc0iF7z6k56CmGoozuV5qt09/kHlTS+ZHZqDrV0FZ
         iA1OkHaY4+819lCvIjamF1q7yxF2ObFE8DNLPECX8qMNS3JXmMmbmn5fDK7QtpvFZWZA
         PhBlFLK2B6aznK55jwcRY+3//E1RVy4RlQZedpjA0owYU9ihXta3ZcgLHXF9kllmD4ut
         LQrMntzoxX5/xAaAeuS2nwevYH1bzoChDoBDlzk9PSSRZvMVZ3fxPK/4OteznaoLYT+N
         Ud/IAR1BO4tJ59fvf37tAsjmaMZzfSmxNZYWKLD3ruRSQVU25qvygda+74vRuz1yTX7v
         qNQA==
X-Forwarded-Encrypted: i=1; AJvYcCUbmZhuNzlSICqipMSeAqeaYA3vIpFqAfnhfMIArpO8rOXLaXBvPQqJRAYsRW1lnNVkwt0giKQHTfk0@vger.kernel.org
X-Gm-Message-State: AOJu0Yyo7NJAmoD+hnzdrl7nuPAaa+kBJKg+ear6v/5x9BVvbUHkeqmC
	unODUZ04Dm0BbpumCCSsgIszHI6Qr+vVe03XYXlkEbOoUF7W3R8NujT3xHIwoo3p6utYKY//Qih
	XzJVtdIrxUL/M4N+rB2bjJIjZ1LcKQP9ccaF0
X-Google-Smtp-Source: AGHT+IGfIw5en7nMNwXR8WTMmoC6i/mmCdwod1VBWf2nU/vOj3kNQZOC5eep3RZM27n5ERgdi0RUSIce8GRDKg8cVxc=
X-Received: by 2002:a05:6512:1154:b0:533:4620:ebe6 with SMTP id
 2adb3069b0e04-539e5f9e005mr23838e87.4.1728670332348; Fri, 11 Oct 2024
 11:12:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com> <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
In-Reply-To: <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 11 Oct 2024 20:11:36 +0200
Message-ID: <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, Matthew Wilcox <willy@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, "Paul E . McKenney" <paulmck@kernel.org>, 
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

On Fri, Sep 27, 2024 at 2:51=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> Implement a new lightweight guard page feature, that is regions of userla=
nd
> virtual memory that, when accessed, cause a fatal signal to arise.
[...]
> ---
>  arch/alpha/include/uapi/asm/mman.h     |   3 +
>  arch/mips/include/uapi/asm/mman.h      |   3 +
>  arch/parisc/include/uapi/asm/mman.h    |   3 +
>  arch/xtensa/include/uapi/asm/mman.h    |   3 +
>  include/uapi/asm-generic/mman-common.h |   3 +

I kinda wonder if we could start moving the parts of those headers
that are the same for all architectures to include/uapi/linux/mman.h
instead... but that's maybe out of scope for this series.

[...]
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

What does poisoning need a write lock for? anon_vma_prepare() doesn't
need it (it only needs mmap_lock held for reading),
zap_page_range_single() doesn't need it, and pagewalk also doesn't
need it as long as the range being walked is covered by a VMA, which
it is...

I see you set PGWALK_WRLOCK in guard_poison_walk_ops with a comment
saying "We might need to install an anon_vma" - is that referring to
an older version of the patch where the anon_vma_prepare() call was
inside the pagewalk callback or something like that? Either way,
anon_vma_prepare() doesn't need write locks (it can't, it has to work
from the page fault handling path).

>                 return 0;
>         default:
>                 /* be safe, default to 1. list exceptions explicitly */
[...]
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

I'd move this up, to before we create poison PTEs. There's no harm in
attaching an anon_vma to the VMA even if the rest of the operation
fails; and I think it would be weird to have error paths that don't
attach an anon_vma even though they .

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

Hmm, yeah, it would be nice if we could avoid telling userspace to
loop on -EAGAIN but I guess we don't have any particularly good
options here? Well, we could bail out with -EINTR if a (fatal?) signal
is pending and otherwise keep looping... if we'd tell userspace "try
again on -EAGAIN", we might as well do that in the kernel...

(Personally I would put curly braces around these branches because
they occupy multiple lines, though the coding style doesn't explicitly
say that, so I guess maybe it's a matter of personal preference...
adding curly braces here would match what is done, for example, in
relocate_vma_down().)

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

I think that last parameter probably should be "false"? The sparc code
calls it "fullmm", which is a term the MM code uses when talking about
operations that remove all mappings in the entire mm_struct because
the process has died, which allows using some faster special-case
version of TLB shootdown or something along those lines.

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

It is a _little_ weird that unpoisoning creates page tables when they
don't already exist, which will also prevent creating THP entries on
fault in such areas afterwards... but I guess it doesn't really matter
given that poisoning has that effect, too, and you probably usually
won't call MADV_GUARD_UNPOISON on an area that hasn't been poisoned
before... so I guess this is not an actionable comment.

