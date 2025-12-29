Return-Path: <linux-arch+bounces-15580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 914B2CE6D9C
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 14:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A7FE300955F
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 13:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AEE2DAFA8;
	Mon, 29 Dec 2025 13:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeTg/bJi"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3650312805
	for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767014008; cv=none; b=DPO8rECvGBbvp1esXiifHeUz0ijyPPCb1BGYrEiw3L5H//Z00xY4Np62fT+0EBFzieCiG3gFqCjxD057/FQvuEUCNlhngLoKjWonntk5ulXv9eQW+A04mg+FF6rpjgXOg5yQj5xvI1VNfoapCXyoPoyc1iSuCHIVSPdawl8suJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767014008; c=relaxed/simple;
	bh=cVwbsd6n4IiXBqoeJ2wR6D8nbbSxj4EaNA8UYTQIiiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfuYgbDij8scpsEs7aD74zc8gLrJjMdg08mVPtB93BSIyqIU4CW7ARvZ9Xj6EKk3BMVBo7z87Yo17RbTxoBH4Dn+MWMrKG5PczZNutfMzrUjrLWlyiMqzQEA2Vg0xAsb+a0lyCDccacDpnNw+zVzpsXqQMCMHnKNaq/QLHKNjzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeTg/bJi; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4edb6e678ddso135528751cf.2
        for <linux-arch@vger.kernel.org>; Mon, 29 Dec 2025 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767014005; x=1767618805; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHAsk3B2/8g2FJFkCevvoFrEjD/jDXWWvck8I9R2+V0=;
        b=NeTg/bJiJpT5G0vbLpFyv4ci9QlKnQvcWsvaEJeUkY0TMD2PE/jv8/t1wvXCmsaZ7C
         6v7u6mKPU6ou9JGtqDvjZgpfKoClaS+yycSxRQ6S+A3CGS/VZJSlUq3KOqlYR5gy/pub
         jz2dvqXU32KmIT0u7MmmpUwhsnZgeSxB7X0bEfuu5jXzbygBO0KAGS8wDpLAR4pyEDb7
         F05/G8Aea882C9/iF77DOc7EboqIX2wto/gGJJ+Suifwv1TZJU4PpX9a1SaM9cwymQub
         nluvOojFNJ/8+HcchZ3C4kkc6Grl0lEVzkI6IKFJ36Rk7ss3MPMh8nMA4Y952hMWMx1i
         Fv5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767014005; x=1767618805;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dHAsk3B2/8g2FJFkCevvoFrEjD/jDXWWvck8I9R2+V0=;
        b=ru3X6g+5eypzSmffkF969AOY1rRJEeC1x94NVeYdehytl8r2L65EcF6vCEE1iPXSOX
         yh1G6fDm22zHU8na7vDDIjbrYqbGhGCPlmUfJSaxgwFp+Qo/rpTjvNzAzKAYfo0XwDUS
         MF7yprGhNRu8nEQfhj9DLQ7P9/TGvsrmwZkGcPVBXPxs1Km7Dbg54rKE2Jk/Rx7sbb2R
         kMN30XTu47i8xMkp5IohWUPCUxU9Ou158t5XUR+Wi/RlwrhyGc2lJo3EL9BHE3/NnFGk
         iRumEe2rWcUNYvHDUnoDQSKbE+AdwhdTf7lc5ys/hIDaWliUrSIXXkm2sOlo6cAabhmI
         wq9g==
X-Forwarded-Encrypted: i=1; AJvYcCW08RaeQZ7U9RLg50bletg2Rzd5JWgtCcwNJXisWtNulPpwMGDmdshff55PSJqDj3VFxHkauXn6SdKN@vger.kernel.org
X-Gm-Message-State: AOJu0YyzPKf7il6ECsq8cHPcB5ZaNajn3Jo9VJfvhajhd+bHJnt+AZOd
	Cb+LxzUdY4WWwsRR5pAW2huiYZ0ijYu/ES4ajODoiqwcXrT7L8md7eYF
X-Gm-Gg: AY/fxX5HiXpICy9Z4PWBwOEBXjsWsLiHbNCBBAHIwNytJ9bc+u8GlidGEqTmuSEDmHS
	CkHuDBHnWPUkzHK9/3XhtaF9NI36ngeFAMp7VyagC385nIQmT+CbOtN0BYCyYiu9KaiqNfkNdAo
	ld9caauVuhXHZfEx6ngZzwJVQlaSpPFFo6WmzpV3HitwVVKPWfFflIchNyN+7Ie793XY4VVV3Uc
	FZ47yCTDpjzirPSjaxyQq0VyMZQdqritZ/pyJKHxqmPyurrMQcPK+UFQrucoykpjifsyLYu6H9W
	R92VVTgMOLTO/jckjEZCHn9ewTvtH/Ks0qYAQVps/y3duOaxQZBeUaZH4JXnw4b7JDrRSOQtZhX
	tJ3Zfy4otMb7aQCaqTwG/61SPMkTorMlH9R9NMli2MPWgJRkyN97u/GgwOUost05YehqboOusAS
	FQ1jORqitB8oS/WWcXiFUtEU5vl8wWaK7n564VWvUZ20njd2qa5zUa24ph68TM2ncSbO/A/bpv6
	Kq9cdfJ6Fe6Lr4=
X-Google-Smtp-Source: AGHT+IEXV3wFr7xd4rEMsGpXovPKmFvt4sm/srdj18rz3T07iELjL846O3zbsbULxZNdCg9l5ZR1DQ==
X-Received: by 2002:ac8:5a0d:0:b0:4ee:1301:ebb3 with SMTP id d75a77b69052e-4f4abd80fbbmr465203741cf.54.1767014005604;
        Mon, 29 Dec 2025 05:13:25 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f4ac64a47esm233989281cf.24.2025.12.29.05.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 05:13:25 -0800 (PST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id B75EDF40082;
	Mon, 29 Dec 2025 08:13:24 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 29 Dec 2025 08:13:24 -0500
X-ME-Sender: <xms:c35SaTnj-0xpCXlk5wNIeoarIkLSOsl-X9QgE0RaI6FQB7WhopEDQg>
    <xme:c35SadWUXmG1GHH0LGnfr3JYsLxR1v9rJaZm1FF2Uqc8LTOKv1i-FJ-DcGSUpnsiC
    zVKSHZUfokdYpThpZdKbIVq3bzZlu7Q-kOujWQPXyp2hyNG28cqnQ>
X-ME-Received: <xmr:c35SaXrHQvKE3FxTcws9PjGZkGcXWZbCyPJ7S5Xu1UYUyDjaC7gz80oF6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdejjedvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudffiedv
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqh
    hunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddu
    jeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvg
    drnhgrmhgvpdhnsggprhgtphhtthhopedufedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepfhhujhhithgrrdhtohhmohhnohhrihesghhmrghilhdrtghomhdprhgtphhtth
    hopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrrdhhihhnuggsohhr
    gheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvghrhihhlhesghhoohhglh
    gvrdgtohhmpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgt
    ohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehgrg
    hrhiesghgrrhihghhuohdrnhgvthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepthhmghhrohhsshesuhhmihgthhdrvgguuh
X-ME-Proxy: <xmx:c35SaeXWyOOVjVjuXZGWh4-DiF9RptjvJMspKAIZWe-r1FLHRve6ZQ>
    <xmx:c35SaYEgn5hFmUl2x_u1DvdoSgzUYvXDRJge7jrb0H0SsoWmJGJFxQ>
    <xmx:c35SaVCwpmVqAGeSjJsbVbJf1FhRdcpQxpf-Fv0Tzu83Na0AjRIFxg>
    <xmx:c35Saaw_mLtwKK59DFXLjjq48GfhEFFQrN69Heh5stfUYfw8lQ4qwA>
    <xmx:dH5SabfrF7RIszrDjZT0-KG7sNvyhT2B359e6Gb0uQLZlkmvg7ZLpLsH>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Dec 2025 08:13:22 -0500 (EST)
Date: Mon, 29 Dec 2025 21:13:09 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: ojeda@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
	bjorn3_gh@protonmail.com, dakr@kernel.org, gary@garyguo.net,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 3/3] rust: sync: atomic: Add i8/i16 xchg and cmpxchg
 support
Message-ID: <aVJ-ZUmRWUF91vek@tardis-2.local>
References: <20251228120546.1602275-4-fujita.tomonori@gmail.com>
 <aVJzlTWx4ybMi1ym@tardis-2.local>
 <aVJ0gvxe0nYtOXAO@tardis-2.local>
 <20251229.220439.1905548071000498132.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251229.220439.1905548071000498132.fujita.tomonori@gmail.com>

On Mon, Dec 29, 2025 at 10:04:39PM +0900, FUJITA Tomonori wrote:
> On Mon, 29 Dec 2025 20:30:58 +0800
> Boqun Feng <boqun.feng@gmail.com> wrote:
> 
> > On Mon, Dec 29, 2025 at 08:27:01PM +0800, Boqun Feng wrote:
> >> On Sun, Dec 28, 2025 at 09:05:46PM +0900, FUJITA Tomonori wrote:
> >> > Add atomic xchg and cmpxchg operation support for i8 and i16 types
> >> > with tests.
> >> > 
> >> 
> >> I think we also needs the following, otherwise architectures may
> >> accidentally enable Rust but don't have the correct atomic
> >> implementation for i8 and i16.
> >> 
> >> diff --git a/rust/kernel/sync/atomic/predefine.rs b/rust/kernel/sync/atomic/predefine.rs
> >> index 248d26555ccf..a4e5bbd45eb2 100644
> >> --- a/rust/kernel/sync/atomic/predefine.rs
> >> +++ b/rust/kernel/sync/atomic/predefine.rs
> >> @@ -5,14 +5,22 @@
> >>  use crate::static_assert;
> >>  use core::mem::{align_of, size_of};
> >> 
> >> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> >> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> >> +//
> >>  // SAFETY: `i8` has the same size and alignment with itself, and is round-trip transmutable to
> >>  // itself.
> >> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >>  unsafe impl super::AtomicType for i8 {
> >>      type Repr = i8;
> >>  }
> >> 
> >> +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> >> +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> >> +//
> >>  // SAFETY: `i16` has the same size and alignment with itself, and is round-trip transmutable to
> >>  // itself.
> >> +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >>  unsafe impl super::AtomicType for i16 {
> >>      type Repr = i16;
> >>  }
> >> 
> >> I can fold it into your patch if that works.
> >> 
> > 
> > OK, the right place should be at AtomicImpl instead of AtomicType:
> > 
> > diff --git a/rust/kernel/sync/atomic/internal.rs b/rust/kernel/sync/atomic/internal.rs
> > index ac689ce8ee8c..f4760e3a916e 100644
> > --- a/rust/kernel/sync/atomic/internal.rs
> > +++ b/rust/kernel/sync/atomic/internal.rs
> > @@ -37,10 +37,16 @@ pub trait AtomicImpl: Sized + Send + Copy + private::Sealed {
> >      type Delta;
> >  }
> > 
> > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> > +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >  impl AtomicImpl for i8 {
> >      type Delta = Self;
> >  }
> > 
> > +// The current helpers of load/store uses `{WRITE,READ}_ONCE()` hence the atomicity is only
> > +// guaranteed against read-modify-write operations if the architecture supports native atomic RmW.
> > +#[cfg(CONFIG_ARCH_SUPPORTS_ATOMIC_RMW)]
> >  impl AtomicImpl for i16 {
> >      type Delta = Self;
> >  }
> 
> With the above change, won't it cause a compile error on architectures
> where CONFIG_ARCH_SUPPORTS_ATOMIC_RMW is disabled?
> 
> If that is intended, I'm fine with it.
> 

Right, the intention is to cause build errors because then we need to
add lock-based atomic_{i8,i16}_read() and atomic_{i8,i16}_set() when
those archs begin to support Rust.

Regards,
Boqun

