Return-Path: <linux-arch+bounces-8521-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6499AEBF2
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 18:26:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7B2D1F23A22
	for <lists+linux-arch@lfdr.de>; Thu, 24 Oct 2024 16:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525791F943C;
	Thu, 24 Oct 2024 16:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CdcXpgXe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FEF1F8911
	for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729787142; cv=none; b=LJBUtVi72RhB8I3xPVUfWHwB9l+yspYq1zGkaX28STMzJ0gLF3J9wiLhMjgH7b2BbgCMsF5es5CeTkIgqyEGxs8jmoAtX1s52rp8tPkp7J54c0spZqZAm6HEiqqFCqPx0qRMBMpbkGRGyYubtkksZ/XAQbh+oSA6UKiV9ykQBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729787142; c=relaxed/simple;
	bh=1JvgRGt6u8l7WaG5wCwCD/6HMQh2wO5p+FLLwIZukeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=brVAELKVqvmCFB/jgSVfrsVqzJNC8Z30Y9Mh+P6DFAVUkDoKs3Qgi0T0tAPWZFTX8e6OZMUcNR1Lm0dkLXm/tzsSjrKwjEmRWfv4lCUNKFbnuU0iyRYLYrXh6Uq307r/uIxqpdG68Wzx4FgAa0fFqa00rDgJ7K/lbgC0sTWe5+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CdcXpgXe; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so230555e9.0
        for <linux-arch@vger.kernel.org>; Thu, 24 Oct 2024 09:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729787138; x=1730391938; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PsKck1YTKCCMRyW5+ku5wUHxij3yPa9weScPb3/oZQY=;
        b=CdcXpgXeZoRj3O733DKfkDZFj4JvXK7RHeKnEFthVC6ViyIcWq9Qm8e5TmuBarCYSc
         ItzjWWx+vs2RpeI/LGeaHtlV6ZrKqzSqUP7FYYwKLa+ivglDmVpIOoqDZ/EBfVk8GSoL
         ohe3UbxboTzZDbS1zXFxU5ox2yZnqE8IBb3Op0eUuGeIKL2qrJMvpfVwraXzOfHjhc0F
         qsgg/EIdjiLYM7DbYBR1FFYdvxNYVzSqimdDTx4Sav0JWFoIfKemwd001DlhxpA95pDT
         Tnz1Sda0Wtusr2yMgpzBWPY+waFpmnV+CA/Kf2V9AulCiaH8o3K4c3OPckI5ksyfGGuH
         sKNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729787138; x=1730391938;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PsKck1YTKCCMRyW5+ku5wUHxij3yPa9weScPb3/oZQY=;
        b=P2ZgjzSqDg9ngz63cUDsfKLSEtUOn3GKABacN6EoIFbLujH7nGQFar58nBZPd/WdUT
         A8nlwH8tqKKOMt8dFAxt7oFzq6o4dv2h/lN2OKMwuU5ifZKxO1D1n8SU8Qms4QjrA4KJ
         4IQFlcz/J6h0nWwA9z5lj2scnjKQfu/L+dE5DxIs23Rr4L2tSlCYoeNhV2kSr9Ll2UIl
         +zYpZSqma4DPtqH7qxDuah8ZNzzgl2oHZ1PSi3O9gQO9weMt1a+v3sggE4Tq7L1P7nxq
         lxZz+1EjfFzzL+sT9LkqyUKS12bnFjw2hEF+DSDqkrNqP4JElv2LMCky+JtP0L2HpR5q
         e6ng==
X-Forwarded-Encrypted: i=1; AJvYcCW6jk+Mqn4I6cYZB2Am+r6kxMrp/xJ5sn3wSN4ooOgYxFIUrlPmCYmCjmLVVeuk+78Z9mrhs9xcFwYj@vger.kernel.org
X-Gm-Message-State: AOJu0YyFRyXsQE9t40+Z0dC9p+lsWKQpe+hA/NUD6wDu+VEFdHD3c+Ev
	HyBxAU1YGqWERyb7Ij6FoIGZRUHIvj1QjtlmHHNJiYNbBsjQgwMYzG83ijQOGdb4USi2e9FQlZr
	FDwSshZripioYUFavV2GOH7RBxqd9WtHet4yM
X-Google-Smtp-Source: AGHT+IGLBq2yNokN7929g0eN3iBE3/2qdA2DRQWdC4E2LpDfi93QPPEgbNRjYQqJ+XQ+mG7d0keQ7uvVD5LffkbY/lk=
X-Received: by 2002:a05:600c:5023:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-4318a50525emr5577505e9.2.1729787137882; Thu, 24 Oct 2024
 09:25:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023170759.999909-1-surenb@google.com> <20241023170759.999909-6-surenb@google.com>
 <20241023140017.e165544bf20bcb0c79bfee57@linux-foundation.org> <CAJuCfpH9yc2kYGZqYjYPWbApy05yqiONqziBQ+qF+R3nZRL56w@mail.gmail.com>
In-Reply-To: <CAJuCfpH9yc2kYGZqYjYPWbApy05yqiONqziBQ+qF+R3nZRL56w@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 24 Oct 2024 09:25:22 -0700
Message-ID: <CAJuCfpFEYm-YT7AS6TzOMdLNtuS1E7KJuWJ8YeL9ro2L+3Wb9g@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] alloc_tag: introduce pgtag_ref_handle to abstract
 page tag references
To: Andrew Morton <akpm@linux-foundation.org>
Cc: kent.overstreet@linux.dev, corbet@lwn.net, arnd@arndb.de, 
	mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org, thuth@redhat.com, 
	tglx@linutronix.de, bp@alien8.de, xiongwei.song@windriver.com, 
	ardb@kernel.org, david@redhat.com, vbabka@suse.cz, mhocko@suse.com, 
	hannes@cmpxchg.org, roman.gushchin@linux.dev, dave@stgolabs.net, 
	willy@infradead.org, liam.howlett@oracle.com, pasha.tatashin@soleen.com, 
	souravpanda@google.com, keescook@chromium.org, dennis@kernel.org, 
	jhubbard@nvidia.com, urezki@gmail.com, hch@infradead.org, petr.pavlu@suse.com, 
	samitolvanen@google.com, da.gomez@samsung.com, yuzhao@google.com, 
	vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com, 
	rientjes@google.com, minchan@google.com, kaleshsingh@google.com, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-mm@kvack.org, 
	maple-tree@lists.infradead.org, linux-modules@vger.kernel.org, 
	kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:09=E2=80=AFPM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Wed, Oct 23, 2024 at 2:00=E2=80=AFPM Andrew Morton <akpm@linux-foundat=
ion.org> wrote:
> >
> > On Wed, 23 Oct 2024 10:07:58 -0700 Suren Baghdasaryan <surenb@google.co=
m> wrote:
> >
> > > To simplify later changes to page tag references, introduce new
> > > pgtag_ref_handle type. This allows easy replacement of page_ext
> > > as a storage of page allocation tags.
> > >
> > > ...
> > >
> > >  static inline void pgalloc_tag_copy(struct folio *new, struct folio =
*old)
> > >  {
> > > +     union pgtag_ref_handle handle;
> > > +     union codetag_ref ref;
> > >       struct alloc_tag *tag;
> > > -     union codetag_ref *ref;
> > >
> > >       tag =3D pgalloc_tag_get(&old->page);
> > >       if (!tag)
> > >               return;
> > >
> > > -     ref =3D get_page_tag_ref(&new->page);
> > > -     if (!ref)
> > > +     if (!get_page_tag_ref(&new->page, &ref, &handle))
> > >               return;
> > >
> > >       /* Clear the old ref to the original allocation tag. */
> > >       clear_page_tag_ref(&old->page);
> > >       /* Decrement the counters of the tag on get_new_folio. */
> > > -     alloc_tag_sub(ref, folio_nr_pages(new));
> > > -
> > > -     __alloc_tag_ref_set(ref, tag);
> > > -
> > > -     put_page_tag_ref(ref);
> > > +     alloc_tag_sub(&ref, folio_nr_pages(new));
> >
> > mm-stable has folio_size(new) here, fixed up.
>
> Oh, right. You merged that patch tonight and I formatted my patchset
> yesterday :)
> Thanks for the fixup.
>
> >
> > I think we aleady discussed this, but there's a crazy amount of
> > inlining here.  pgalloc_tag_split() is huge, and has four callsites.
>
> I must have missed that discussion but I am happy to unline this
> function. I think splitting is heavy enough operation that this
> uninlining would not have be noticeable.

Posted requested uninlining at
https://lore.kernel.org/all/20241024162318.1640781-1-surenb@google.com/

> Thanks!

