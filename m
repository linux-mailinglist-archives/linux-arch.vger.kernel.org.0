Return-Path: <linux-arch+bounces-7769-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB18499313B
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 17:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B9FA1F24082
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 15:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A6A1DA610;
	Mon,  7 Oct 2024 15:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N3eOmimU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902061DA60B
	for <linux-arch@vger.kernel.org>; Mon,  7 Oct 2024 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728315081; cv=none; b=VvBgEjuQVNAVjUA8DEef5hRRFElrS4JtgQqyEp3+d4gezSXxv7o3HGkqCisKRRWNkdzTTkUvSvurK68Nwgh2ypVrUVBZTRP6b3TNLaMX/CwU4pTKfnWD1q5YRk6luAwUetyypYxTpTs1ZeG+ziEl0MHNknNHHjpu4p25yyN5eJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728315081; c=relaxed/simple;
	bh=wABfdzjaqX8/h5ONr6CadoBlLpcxPp1M2y909ir0UNE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHdN2YV8tPgjUP6I/IpmY2CtvA7WRL1ayn2tNL2eiYGSq0v2XQxSqqnR3iSNVPddYmHdd7LRVc4tpFEwPjLOnmtFF4u4GS0MTdYWuviRbqwNq5m75J6Fx8PlrswDXgMJ/kwI9InhwVl0/VPASV/rxIyFACAErBtI0NqhhwQwl50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N3eOmimU; arc=none smtp.client-ip=209.85.167.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f170.google.com with SMTP id 5614622812f47-3e3a993fc03so297521b6e.3
        for <linux-arch@vger.kernel.org>; Mon, 07 Oct 2024 08:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728315078; x=1728919878; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L4WEqwrZq7bPz4Km+Jp3zyNPl9dhOMj3xp8bD9mdso4=;
        b=N3eOmimUhH/TTMXQyzx8r9LkRFvF0tEEyUK+UbVfVYN2fbIGY2KfOoaoIqUIE3FT/o
         jT2DAic1FiznQ3QNo0qiD+7Y7g30AwTShR0lXzUd6XZGCzUJ987CibHKn8FEC6KXNLGz
         SUOawWIKzdltn9jc/C+3d8pU6e2gAAOXe225A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728315078; x=1728919878;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L4WEqwrZq7bPz4Km+Jp3zyNPl9dhOMj3xp8bD9mdso4=;
        b=Mw++YHpkhqIaSSXz1n49Gn2dAV9W0+n2S+x4JFW3lQsMqHdWv5qUFlFEO15jeAcnPz
         epXJ+iAl3ltavT/4Mff97k4IBVeHIoIs9ZJXvnAOPLyetpv9jrgu6OM6TPs0iEEirp2A
         ZyppP9kR7Jvm+BeKQ8kehHbF3ogaiznGA6bkE6ypkk0SPwnCnqMMWrlKj/GRdhQWnFPh
         AHgFvfCoMVeGxQyu3OvMDNSgvKOSqzTumV/HqnnmoEpl5feOjn61pab2G2pR16JVmAYB
         QOAnPBJ3k+54T8EsreQ3JwwXvGb23NX5tlgZNArOhY4Z2193aP83P/Z4+alDsV2Vaf3y
         INqg==
X-Forwarded-Encrypted: i=1; AJvYcCWBjBpUqLXbLHGxb4MGcZns1utAjZGTAvNsu5d8yKpthEPN35ffduLfkhqvoOGK2Mh9559j3A1n9N9r@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5XsPc5BGTLMT1jbYaPfAI4EJVH6PvN3NYTgfeAJHQ9HsMQLQx
	qWOEvzOkvRmw/xfUdaA4YpchnpqsEF/lqPr6J8epbFa7dF/tCy/Y1Y9J3og90pDI8ji03fh6xee
	gYYWRUGhvNoSsOIB3uTB5/mrFSMte8K9JdNtH
X-Google-Smtp-Source: AGHT+IF13B85o77zgdXRCS9I+dpEvNjCs/SJC+ox1mA0OGDWxtmr/PbDB3/IM62HopXLbs/umGTk+Z44qNgnpk5xF+E=
X-Received: by 2002:a05:6870:d201:b0:27b:9f8b:7e49 with SMTP id
 586e51a60fabf-287c22913fdmr2428259fac.11.1728315077534; Mon, 07 Oct 2024
 08:31:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <a578ee9bb656234d3a19bf9e97c3012378d31a19.1727440966.git.lorenzo.stoakes@oracle.com>
 <CABi2SkWzjTVjEwED_QjNz385m4aGo8OfAS2RkRjuZdpSviNkJQ@mail.gmail.com> <dd62c167-f8d5-4c48-b92e-9efde6a61d7e@lucifer.local>
In-Reply-To: <dd62c167-f8d5-4c48-b92e-9efde6a61d7e@lucifer.local>
From: Jeff Xu <jeffxu@chromium.org>
Date: Mon, 7 Oct 2024 08:30:00 -0700
Message-ID: <CABi2SkX2Giz5LaLbipbwx0B9G464pkK79WQ+dnbAjD2Zv5RzwQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/4] mm: madvise: implement lightweight guard page mechanism
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Kees Cook <keescook@chromium.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Suren Baghdasaryan <surenb@google.com>, "Liam R . Howlett" <Liam.Howlett@oracle.com>, 
	Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>, 
	"Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>, 
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

Hi Lorenzo

On Fri, Oct 4, 2024 at 11:26=E2=80=AFAM Lorenzo Stoakes
<lorenzo.stoakes@oracle.com> wrote:
>
> On Fri, Oct 04, 2024 at 11:17:13AM -0700, Jeff Xu wrote:
> > Hi Lorenzo,
> >
> > Please add me to this series, I 'm interested in everything related to
> > mseal :-), thanks.
>
> Hi Jeff, more than happy to cc you on this going forward :)
>
> The only change to mseal is a trivial change because the poison operation
> discards, wasn't intentional, but apologies, I should have cc'd you
> regardless! Will do so on any such interaction with mseal moving forward.
>
No problems :-).

I do sometimes scan the emails to search for mseal keyword and that is
how I find this patch series.

> >
> > I also added Kees into the cc, since mseal is a security feature.
>
> Sure no problem happy to keep Kees cc-d too (Kees - ping me if you'd pref=
er
> not :>), however a note on this - guard pages _themselves_ are emphatical=
ly
> NOT a security feature, and make no guarantees on this front, but rather
> are a convenience/effiency thing.
>
It is a nice feature nevertheless. I imagine the guide page can detect
cases such as trying to go-over  the main stack ?

> Obviously however I am adding madvise() functionality here, and all such
> functionality must take into account whether or not they are discard
> operations as to ensure mseal semantics are obeyed - see below for my
> argument as to why I feel the poison operation falls under this.
>
> >
> >
> > On Fri, Sep 27, 2024 at 5:52=E2=80=AFAM Lorenzo Stoakes
> > <lorenzo.stoakes@oracle.com> wrote:
> > >
> > > Implement a new lightweight guard page feature, that is regions of us=
erland
> > > virtual memory that, when accessed, cause a fatal signal to arise.
> > >
> > > Currently users must establish PROT_NONE ranges to achieve this.
> > >
> > > However this is very costly memory-wise - we need a VMA for each and =
every
> > > one of these regions AND they become unmergeable with surrounding VMA=
s.
> > >
> > > In addition repeated mmap() calls require repeated kernel context swi=
tches
> > > and contention of the mmap lock to install these ranges, potentially =
also
> > > having to unmap memory if installed over existing ranges.
> > >
> > > The lightweight guard approach eliminates the VMA cost altogether - r=
ather
> > > than establishing a PROT_NONE VMA, it operates at the level of page t=
able
> > > entries - poisoning PTEs such that accesses to them cause a fault fol=
lowed
> > > by a SIGSGEV signal being raised.
> > >
> > > This is achieved through the PTE marker mechanism, which a previous c=
ommit
> > > in this series extended to permit this to be done, installed via the
> > > generic page walking logic, also extended by a prior commit for this
> > > purpose.
> > >
> > > These poison ranges are established with MADV_GUARD_POISON, and if th=
e
> > > range in which they are installed contain any existing mappings, they=
 will
> > > be zapped, i.e. free the range and unmap memory (thus mimicking the
> > > behaviour of MADV_DONTNEED in this respect).
> > >
> > > Any existing poison entries will be left untouched. There is no nesti=
ng of
> > > poisoned pages.
> > >
> > > Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be ra=
ther
> > > unexpected behaviour, but are cleared on process teardown or unmappin=
g of
> > > memory ranges.
> > >
> > > Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> > > 'remedying' the poisoning. The ranges over which this is applied, sho=
uld
> > > they contain non-poison entries, will be untouched, only poison entri=
es
> > > will be cleared.
> > >
> > > We permit this operation on anonymous memory only, and only VMAs whic=
h are
> > > non-special, non-huge and not mlock()'d (if we permitted this we'd ha=
ve to
> > > drop locked pages which would be rather counterintuitive).
> > >
> > > The poisoning of the range must be performed under mmap write lock as=
 we
> > > have to install an anon_vma to ensure correct behaviour on fork.
> > >
> > > Suggested-by: Vlastimil Babka <vbabka@suze.cz>
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > ---
> > >  arch/alpha/include/uapi/asm/mman.h     |   3 +
> > >  arch/mips/include/uapi/asm/mman.h      |   3 +
> > >  arch/parisc/include/uapi/asm/mman.h    |   3 +
> > >  arch/xtensa/include/uapi/asm/mman.h    |   3 +
> > >  include/uapi/asm-generic/mman-common.h |   3 +
> > >  mm/madvise.c                           | 158 +++++++++++++++++++++++=
++
> > >  mm/mprotect.c                          |   3 +-
> > >  mm/mseal.c                             |   1 +
> > >  8 files changed, 176 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/alpha/include/uapi/asm/mman.h b/arch/alpha/include/=
uapi/asm/mman.h
> > > index 763929e814e9..71e13f27742d 100644
> > > --- a/arch/alpha/include/uapi/asm/mman.h
> > > +++ b/arch/alpha/include/uapi/asm/mman.h
> > > @@ -78,6 +78,9 @@
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > >
> > > +#define MADV_GUARD_POISON 102          /* fatal signal on access to =
range */
> > > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poiso=
ning */
> > > +
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > >
> > > diff --git a/arch/mips/include/uapi/asm/mman.h b/arch/mips/include/ua=
pi/asm/mman.h
> > > index 9c48d9a21aa0..1a2222322f77 100644
> > > --- a/arch/mips/include/uapi/asm/mman.h
> > > +++ b/arch/mips/include/uapi/asm/mman.h
> > > @@ -105,6 +105,9 @@
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > >
> > > +#define MADV_GUARD_POISON 102          /* fatal signal on access to =
range */
> > > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poiso=
ning */
> > > +
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > >
> > > diff --git a/arch/parisc/include/uapi/asm/mman.h b/arch/parisc/includ=
e/uapi/asm/mman.h
> > > index 68c44f99bc93..380905522397 100644
> > > --- a/arch/parisc/include/uapi/asm/mman.h
> > > +++ b/arch/parisc/include/uapi/asm/mman.h
> > > @@ -75,6 +75,9 @@
> > >  #define MADV_HWPOISON     100          /* poison a page for testing =
*/
> > >  #define MADV_SOFT_OFFLINE 101          /* soft offline page for test=
ing */
> > >
> > > +#define MADV_GUARD_POISON 102          /* fatal signal on access to =
range */
> > > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poiso=
ning */
> > > +
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > >
> > > diff --git a/arch/xtensa/include/uapi/asm/mman.h b/arch/xtensa/includ=
e/uapi/asm/mman.h
> > > index 1ff0c858544f..e8d5affceb28 100644
> > > --- a/arch/xtensa/include/uapi/asm/mman.h
> > > +++ b/arch/xtensa/include/uapi/asm/mman.h
> > > @@ -113,6 +113,9 @@
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > >
> > > +#define MADV_GUARD_POISON 102          /* fatal signal on access to =
range */
> > > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poiso=
ning */
> > > +
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > >
> > > diff --git a/include/uapi/asm-generic/mman-common.h b/include/uapi/as=
m-generic/mman-common.h
> > > index 6ce1f1ceb432..5dfd3d442de4 100644
> > > --- a/include/uapi/asm-generic/mman-common.h
> > > +++ b/include/uapi/asm-generic/mman-common.h
> > > @@ -79,6 +79,9 @@
> > >
> > >  #define MADV_COLLAPSE  25              /* Synchronous hugepage colla=
pse */
> > >
> > > +#define MADV_GUARD_POISON 102          /* fatal signal on access to =
range */
> > > +#define MADV_GUARD_UNPOISON 103                /* revoke guard poiso=
ning */
> > > +
> > >  /* compatibility flags */
> > >  #define MAP_FILE       0
> > >
> > > diff --git a/mm/madvise.c b/mm/madvise.c
> > > index e871a72a6c32..7216e10723ae 100644
> > > --- a/mm/madvise.c
> > > +++ b/mm/madvise.c
> > > @@ -60,6 +60,7 @@ static int madvise_need_mmap_write(int behavior)
> > >         case MADV_POPULATE_READ:
> > >         case MADV_POPULATE_WRITE:
> > >         case MADV_COLLAPSE:
> > > +       case MADV_GUARD_UNPOISON: /* Only poisoning needs a write loc=
k. */
> > >                 return 0;
> > >         default:
> > >                 /* be safe, default to 1. list exceptions explicitly =
*/
> > > @@ -1017,6 +1018,157 @@ static long madvise_remove(struct vm_area_str=
uct *vma,
> > >         return error;
> > >  }
> > >
> > > +static bool is_valid_guard_vma(struct vm_area_struct *vma, bool allo=
w_locked)
> > > +{
> > > +       vm_flags_t disallowed =3D VM_SPECIAL | VM_HUGETLB;
> > > +
> > > +       /*
> > > +        * A user could lock after poisoning but that's fine, as they=
'd not be
> > > +        * able to fault in. The issue arises when we try to zap exis=
ting locked
> > > +        * VMAs. We don't want to do that.
> > > +        */
> > > +       if (!allow_locked)
> > > +               disallowed |=3D VM_LOCKED;
> > > +
> > > +       if (!vma_is_anonymous(vma))
> > > +               return false;
> > > +
> > > +       if ((vma->vm_flags & (VM_MAYWRITE | disallowed)) !=3D VM_MAYW=
RITE)
> > > +               return false;
> > > +
> > > +       return true;
> > > +}
> > > +
> > > +static int guard_poison_install_pte(unsigned long addr, unsigned lon=
g next,
> > > +                                   pte_t *ptep, struct mm_walk *walk=
)
> > > +{
> > > +       unsigned long *num_installed =3D (unsigned long *)walk->priva=
te;
> > > +
> > > +       (*num_installed)++;
> > > +       /* Simply install a PTE marker, this causes segfault on acces=
s. */
> > > +       *ptep =3D make_pte_marker(PTE_MARKER_GUARD);
> > > +
> > > +       return 0;
> > > +}
> > > +
> > > +static bool is_guard_pte_marker(pte_t ptent)
> > > +{
> > > +       return is_pte_marker(ptent) &&
> > > +               is_guard_swp_entry(pte_to_swp_entry(ptent));
> > > +}
> > > +
> > > +static int guard_poison_pte_entry(pte_t *pte, unsigned long addr,
> > > +                                 unsigned long next, struct mm_walk =
*walk)
> > > +{
> > > +       pte_t ptent =3D ptep_get(pte);
> > > +
> > > +       /*
> > > +        * If not a guard marker, simply abort the operation. We retu=
rn a value
> > > +        * > 0 indicating a non-error abort.
> > > +        */
> > > +       return !is_guard_pte_marker(ptent);
> > > +}
> > > +
> > > +static const struct mm_walk_ops guard_poison_walk_ops =3D {
> > > +       .install_pte            =3D guard_poison_install_pte,
> > > +       .pte_entry              =3D guard_poison_pte_entry,
> > > +       /* We might need to install an anon_vma. */
> > > +       .walk_lock              =3D PGWALK_WRLOCK,
> > > +};
> > > +
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
> > > +
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
> > > +
> > > +               retried =3D true;
> > > +       }
> > > +}
> > > +
> > > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> > > +                                   unsigned long next, struct mm_wal=
k *walk)
> > > +{
> > > +       pte_t ptent =3D ptep_get(pte);
> > > +
> > > +       if (is_guard_pte_marker(ptent)) {
> > > +               /* Simply clear the PTE marker. */
> > > +               pte_clear_not_present_full(walk->mm, addr, pte, true)=
;
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
> > > +
> > > +static long madvise_guard_unpoison(struct vm_area_struct *vma,
> > > +                                  struct vm_area_struct **prev,
> > > +                                  unsigned long start, unsigned long=
 end)
> > > +{
> > > +       *prev =3D vma;
> > > +       /*
> > > +        * We're ok with unpoisoning mlock()'d ranges, as this is a
> > > +        * non-destructive action.
> > > +        */
> > > +       if (!is_valid_guard_vma(vma, /* allow_locked =3D */true))
> > > +               return -EINVAL;
> > > +
> > > +       return walk_page_range(vma->vm_mm, start, end,
> > > +                              &guard_unpoison_walk_ops, NULL);
> > > +}
> > > +
> > >  /*
> > >   * Apply an madvise behavior to a region of a vma.  madvise_update_v=
ma
> > >   * will handle splitting a vm area into separate areas, each area wi=
th its own
> > > @@ -1098,6 +1250,10 @@ static int madvise_vma_behavior(struct vm_area=
_struct *vma,
> > >                 break;
> > >         case MADV_COLLAPSE:
> > >                 return madvise_collapse(vma, prev, start, end);
> > > +       case MADV_GUARD_POISON:
> > > +               return madvise_guard_poison(vma, prev, start, end);
> > > +       case MADV_GUARD_UNPOISON:
> > > +               return madvise_guard_unpoison(vma, prev, start, end);
> > >         }
> > >
> > >         anon_name =3D anon_vma_name(vma);
> > > @@ -1197,6 +1353,8 @@ madvise_behavior_valid(int behavior)
> > >         case MADV_DODUMP:
> > >         case MADV_WIPEONFORK:
> > >         case MADV_KEEPONFORK:
> > > +       case MADV_GUARD_POISON:
> > > +       case MADV_GUARD_UNPOISON:
> > >  #ifdef CONFIG_MEMORY_FAILURE
> > >         case MADV_SOFT_OFFLINE:
> > >         case MADV_HWPOISON:
> > > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > > index 0c5d6d06107d..d0e3ebfadef8 100644
> > > --- a/mm/mprotect.c
> > > +++ b/mm/mprotect.c
> > > @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *t=
lb,
> > >                         } else if (is_pte_marker_entry(entry)) {
> > >                                 /*
> > >                                  * Ignore error swap entries uncondit=
ionally,
> > > -                                * because any access should sigbus a=
nyway.
> > > +                                * because any access should sigbus/s=
igsegv
> > > +                                * anyway.
> > >                                  */
> > >                                 if (is_poisoned_swp_entry(entry))
> > >                                         continue;
> > > diff --git a/mm/mseal.c b/mm/mseal.c
> > > index ece977bd21e1..21bf5534bcf5 100644
> > > --- a/mm/mseal.c
> > > +++ b/mm/mseal.c
> > > @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
> > >         case MADV_REMOVE:
> > >         case MADV_DONTFORK:
> > >         case MADV_WIPEONFORK:
> > > +       case MADV_GUARD_POISON:
> >
> > Can you please describe the rationale to add this to the existing
> > mseal's semantic ?
> >
> > I didn't not find any description from the cover letter or this
> > patch's description, hence asking.
>
> Sure, this is because when you guard-poison ranges that have existing
> mappings, it zaps them, which performs basically the exact same operation
> as MADV_DONTNEED, and obviously discards any underlying data in doing so.
>
> As a result, I felt it was correct to add this operation to the list of
> discard operations from the perspective of mseal.
>
That makes sense.  Thanks for thinking about memory sealing when
adding new features.

 If possible, please add the reasoning here in the commit description
in the next version, for future reference. As far as I am concerned,
the mseal.c changes LGTM.

Thanks
-Jeff


> >
> > Thanks
> > -Jeff
> >
> > >                 return true;
> > >         }
> > >
> > > --
> > > 2.46.2
> > >
> > >

