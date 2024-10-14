Return-Path: <linux-arch+bounces-8094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D8D99D413
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 17:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FADC280FCE
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 15:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCEA51ADFEB;
	Mon, 14 Oct 2024 15:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rjCsFmYp"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B61ABEDC
	for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 15:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728921452; cv=none; b=mookAtLQgKhJzvMSiEV8SJMKIHeN3LvYH6jRG8FiCmAan6RasIaUGxGYDHFMLu4JAnUzpdYDk8NJrWViND1Azb/kw33f1crgF5Z/QdhB4E0d/1LdBVW/tq2g474SstuVVE0COSOutNfr0TrT1d0FSXVzT2aJ3ZJhDIM26t1SLE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728921452; c=relaxed/simple;
	bh=iz21pBdE6/PrAsEcs5M2ooHdZ/I9dVVWFMpdoI6Oacs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cROjAYiizYKdWunEf3O1naJMTd9wMht/mhbx4953vCTwVJkP2+DP6XmSYKxhWjH2Ab2JnP8paecBePf19rvQaz28N6t3ad+wvwJvZJ6oBon5qVgjhmwVxBLVp7fToCxINv0dtzX5aDbCkNLKDIV8anYCFShxjJr03Q/vilITnic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rjCsFmYp; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c932b47552so20536a12.0
        for <linux-arch@vger.kernel.org>; Mon, 14 Oct 2024 08:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728921449; x=1729526249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m6UcN7D6a3Y3HeZfL95jmfp9Wnz9QqZMWgnGuOo2iKI=;
        b=rjCsFmYprXtPatr1uyZAR/3ztftfC8w4/fhGfnQ99SwUU3H5xalnl47IkBz/RQXXTM
         pf0fqwMFVponM3Uim5PC/ipyo4A45L95aIaVdvGdW//WTxwRfM5iUAkbmI96z+ZRWRjw
         qatVAMAvuDHrsYpeobwNwn2Kos7kkMMfS8mFt9DDL3NEDaTaVvb9bKNRLtdGloyJZ7//
         GfHZHDdLE69fjcQkQOxqi2EMj5VOs0Y63bObJo4MFctXXyg5EFVoxPg6Wxrua2T3Kps+
         NXtL1mzhTVcmFe2aH2SDeQk4EbSISVbCNHN65FU2UoqvWM0EmRCmEHkhxlMhEa+wXdNV
         LhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728921449; x=1729526249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m6UcN7D6a3Y3HeZfL95jmfp9Wnz9QqZMWgnGuOo2iKI=;
        b=aTev9YpUIQzcrHJ7dx6ZicdOak9i+xIYDMY8UctfuMIlepEgKCMMTZTFsdLNiuxCYN
         62EUile484up1lzg4zLa9cBntd8qhc+YUhtknLJb6kWAHVm0B1UYEQh3PmlXy7NRfOh9
         sLPRtDjy/ay5KJVpMtXyxDhfdhcYYsVGBtOHYcdvxDtvAc23Qt6aHD1mpL00LG9ae+b0
         3aHZguZbDOVEZ2jJq+jPBfmAYP6aWlzgp5L7EFChjYHw/vItr1tfYmQOzIAdjqcMJVpM
         vxOMdzMeh0AiNkJH0bZJLUKW+VmtSXkSJuTOciAKpTUC0yTaeXJ3MUgxBMDg7TiT51q6
         qN+g==
X-Forwarded-Encrypted: i=1; AJvYcCWZTB+4UxkR80oRiqHmWtY0W0VTAYforSqmqNGW+g9ZuLgejHxLLMWMIFPDfD3whE2UIlwGMlIlSVaj@vger.kernel.org
X-Gm-Message-State: AOJu0YwnV0dyB7GQdt1Y+ihXy4nCofUA1qVPLlmhmOAPQ8R+AL9PR49O
	gC9O9YUn5kRdWQAVqO8Pw91ZAKFYZDwGYhg4/z7IR92MDoqzLOve6uUBFJ8W/Ogy5oG8vX+qO38
	CN8ILPTBPbiy09KlnIQxYvFo6uB869nHFxdXe
X-Google-Smtp-Source: AGHT+IEGtZ74IajYTANuZOCN6og9uIMTu7SYAYG5PbPVPdswaALt2lAU33R1qlhZZ1AD7R94hwvEgAiDaN9IhA3SQdQ=
X-Received: by 2002:a05:6402:3586:b0:5c5:c44d:484e with SMTP id
 4fb4d7f45d1cf-5c95c5c820dmr391530a12.1.1728921448200; Mon, 14 Oct 2024
 08:57:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CAG48ez3ursoL-f=mYpV79Do18XPPt+MPPHNUBv6uFE1GhpOwSA@mail.gmail.com> <868739d2-0869-462f-ac86-1a8d1dccb0a4@lucifer.local>
In-Reply-To: <868739d2-0869-462f-ac86-1a8d1dccb0a4@lucifer.local>
From: Jann Horn <jannh@google.com>
Date: Mon, 14 Oct 2024 17:56:50 +0200
Message-ID: <CAG48ez3vqbqyWb4bLdpqSUnhwqGo2OQetecNhEGPdCGDr94nbQ@mail.gmail.com>
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

On Mon, Oct 14, 2024 at 1:09=E2=80=AFPM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
> On Fri, Oct 11, 2024 at 08:11:36PM +0200, Jann Horn wrote:
> > On Fri, Sep 27, 2024 at 2:51=E2=80=AFPM Lorenzo Stoakes <lorenzo.stoake=
s@oracle.com> wrote:
> > >                 return 0;
> > >         default:
> > >                 /* be safe, default to 1. list exceptions explicitly =
*/
> > [...]
> > > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > > +                                struct vm_area_struct **prev,
> > > +                                unsigned long start, unsigned long e=
nd)
> > > +{
> > > +       long err;
> > > +       bool retried =3D false;
> > > +
> > > +       *prev =3D vma;
> > > +       if (!is_valid_guard_vma(vma, /* allow_locked =3D */false))
> > > +               return -EINVAL;
> > > +
> > > +       /*
> > > +        * Optimistically try to install the guard poison pages first=
. If any
> > > +        * non-guard pages are encountered, give up and zap the range=
 before
> > > +        * trying again.
> > > +        */
> > > +       while (true) {
> > > +               unsigned long num_installed =3D 0;
> > > +
> > > +               /* Returns < 0 on error, =3D=3D 0 if success, > 0 if =
zap needed. */
> > > +               err =3D walk_page_range_mm(vma->vm_mm, start, end,
> > > +                                        &guard_poison_walk_ops,
> > > +                                        &num_installed);
> > > +               /*
> > > +                * If we install poison markers, then the range is no=
 longer
> > > +                * empty from a page table perspective and therefore =
it's
> > > +                * appropriate to have an anon_vma.
> > > +                *
> > > +                * This ensures that on fork, we copy page tables cor=
rectly.
> > > +                */
> > > +               if (err >=3D 0 && num_installed > 0) {
> > > +                       int err_anon =3D anon_vma_prepare(vma);
> >
> > I'd move this up, to before we create poison PTEs. There's no harm in
> > attaching an anon_vma to the VMA even if the rest of the operation
> > fails; and I think it would be weird to have error paths that don't
> > attach an anon_vma even though they .
>
> I think you didn't finish this sentence :)

Oops...

> I disagree, we might have absolutely no need to do it, and I'd rather onl=
y
> do so _if_ we have to.

But there's no downside to erroring out after having installed an
anon_vma, right?

> It feels like the logical spot to do it and, while the cases where it
> wouldn't happen are ones where pages are already poisoned (the
> vma->anon_vma =3D=3D NULL test will fail so basically a no-op) or error o=
n page
> walk.

My understanding is that some of the MM code basically assumes that a
VMA without an anon_vma and without userfault-WP can't contain any
state that needs to be preserved; or something along those lines. As
you pointed out, fork() is one such case (which maybe doesn't matter
so much because it can't race with this operation).

khugepaged also relies on this assumption in retract_page_tables(),
though that function is not used on anonymous VMAs. If MADVISE_GUARD
is extended to cover file VMAs in the future, then I think we could
race with retract_page_tables() in a functionally relevant way even
when MADVISE_GUARD succeeds: If khugepaged preempts us between the
page walk and installing the anon_vma, retract_page_tables() could
observe that we don't have an anon_vma yet and throw away a page table
in which we just installed guard PTEs.

Though I guess really that's not the main reason why I'm saying this;
my main reason is that almost any other path that has to ensure an
anon_vma is present does that part first (usually because the ordering
matters and this way around is more or less the only possible
ordering). So even if there are some specific reasons why you can do
the ordering the other way around here, it kinda stands out to me as
being weird...

> > > +                       if (err_anon)
> > > +                               err =3D err_anon;
> > > +               }
> > > +
> > > +               if (err <=3D 0)
> > > +                       return err;
> > > +
> > > +               if (!retried)
> > > +                       /*
> > > +                        * OK some of the range have non-guard pages =
mapped, zap
> > > +                        * them. This leaves existing guard pages in =
place.
> > > +                        */
> > > +                       zap_page_range_single(vma, start, end - start=
, NULL);
> > > +               else
> > > +                       /*
> > > +                        * If we reach here, then there is a racing f=
ault that
> > > +                        * has populated the PTE after we zapped. Giv=
e up and
> > > +                        * let the user know to try again.
> > > +                        */
> > > +                       return -EAGAIN;
> >
> > Hmm, yeah, it would be nice if we could avoid telling userspace to
> > loop on -EAGAIN but I guess we don't have any particularly good
> > options here? Well, we could bail out with -EINTR if a (fatal?) signal
> > is pending and otherwise keep looping... if we'd tell userspace "try
> > again on -EAGAIN", we might as well do that in the kernel...
>
> The problem is you could conceivably go on for quite some time, while
> holding and contending a HIGHLY contended lock (mm->mmap_lock) so I'd
> really rather let userspace take care of it.

Hmm... so if the retry was handled in-kernel, you'd basically ideally
have the retry happen all the way up in do_madvise(), where the mmap
lock can be dropped and re-taken?

> You could avoid this by having the walker be a _replace_ operation, that =
is
> - if we encounter an existing mapping, replace in-place with a poison
> marker rather than install marker/zap.
>
> However doing that would involve either completely abstracting such logic
> from scratch (a significant task in itself) to avoid duplication which be
> hugely off-topic for the patch set or worse, duplicating a whole bunch of
> page walking logic once again.

Mmh, yeah, you'd have to extract the locked part of zap_pte_range()
and add your own copy of all the stuff that happens higher up for
setting up TLB flushes and such... I see how that would be a massive
pain and error-prone.

> By being optimistic and simply having the user having to handle looping
> which seems reasonable (again, it's weird if you're installing poison
> markers and another thread could be racing you) we avoid all of that.

I guess one case in which that could happen legitimately is if you
race a MADV_POISON on the area 0x1ff000-0x200100 (first page is
populated, second page is not, pmd entry corresponding to 0x200000 is
clear) with a page fault at 0x200200? So you could have a scenario
like:

1. MADV_POISON starts walk_page_range()
2. MADV_POISON sees non-zero, non-poison PTE at 0x1ff000, stops the walk
3. MADV_POISON does zap_page_range_single()
4. pagefault at 0x200200 happens and populates with a hugepage
5. MADV_POISON enters walk_page_range()
6. MADV_POISON splits the THP
7. MADV_POISON sees a populated PTE

> > > +               update_mmu_cache(walk->vma, addr, pte);
> > > +       }
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static const struct mm_walk_ops guard_unpoison_walk_ops =3D {
> > > +       .pte_entry              =3D guard_unpoison_pte_entry,
> > > +       .walk_lock              =3D PGWALK_RDLOCK,
> > > +};
> >
> > It is a _little_ weird that unpoisoning creates page tables when they
> > don't already exist, which will also prevent creating THP entries on
> > fault in such areas afterwards... but I guess it doesn't really matter
> > given that poisoning has that effect, too, and you probably usually
> > won't call MADV_GUARD_UNPOISON on an area that hasn't been poisoned
> > before... so I guess this is not an actionable comment.
>
> It doesn't? There's no .install_pte so if an entries are non-present we
> ignore.

Ah, right, of course. Nevermind.

> HOWEVER, we do split THP. I don't think there's any way around it unless =
we
> extended the page walker to handle this more gracefully (pmd level being
> able to hint that we shouldn't do that or something), but that's really o=
ut
> of scope here.

I think the `walk->action =3D=3D ACTION_CONTINUE` check in
walk_pmd_range() would let you do that, see wp_clean_pmd_entry() for
an example. But yeah I guess that might just be unnecessary
complexity.

> The idea is that a caller can lazily call MADV_GUARD_UNPOISON on a range
> knowing things stay as they were, I guess we can add to the manpage a not=
e
> that this will split THP?

Yeah, might make sense...

