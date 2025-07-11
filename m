Return-Path: <linux-arch+bounces-12667-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2EFB01E74
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 15:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B20A56615C
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 13:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B1002D949C;
	Fri, 11 Jul 2025 13:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ce458W9f"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6CD22D77F7;
	Fri, 11 Jul 2025 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752242328; cv=none; b=JXlGjeINr+sH8PxvSHSj91So3IZOg6xl2WY9g9Fv3bMSRLY7wAN12pPrUqh7N2H35biDhj+bUSItFZjjM4lka5/C4y3qyWpf/mUGZmCEReTby77kGYhx46Gzk/N8KrvVAce/Xdb0Vl4uF37y3wr+bhu8amh1odedxiF+apX+vtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752242328; c=relaxed/simple;
	bh=OMImzd5St3+4oJum8FOTYfx97qpQjt+/rd8JkDqKBnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LH5gAlAXYS3b8CVzu5hoDERcn/mxNiJDx45vESHS0dy+cHdl9vJGV2BeS0VJ92LHyaMggLhiKE6EKP2d1pZ0B3b2BBaQvBXI/SGAUnk6mh2B+QyfY3u8JyVLLcGT1HujEz4fEbbfvkevlLfj2brimX8ndftOMUqJpY7nroLtrmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ce458W9f; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7dfd667e539so58018185a.2;
        Fri, 11 Jul 2025 06:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752242326; x=1752847126; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbB1R0UF+o1ox6MiAWxgQBqNVgm6z/q3Tj8d+69HVOg=;
        b=Ce458W9fAhzz0XwdtqbZgl8biWpVFkt70GQi5JxUUPZe9n16uEtF7tIgxicNIF2wgM
         lAt4kybqlgsC1OZyJfSrKh3Ei+N6lhSL8aIHHUdM4ypLTnOYzleZC8dTdwCO4uPHROWY
         5Q4Jo8aAm9QSapFXtD9qrUchu3aNISoA1hnPzmtXn0auz7zHrPqYF4bX1HOJkKzzJ8YM
         0uME6QaDnIM7hemE6SXURkc8aXY6NmoBRFj9d/wkhYYwFIy+0MUNhQ1cXnwhrCLQMEe3
         v6DGhDz6cV6zsIFGg2x9MAn2jYLtwr7XYQ1j8/9CRqMSdq8IFXUrD0PiJxkk2AbrZBIJ
         9xjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752242326; x=1752847126;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jbB1R0UF+o1ox6MiAWxgQBqNVgm6z/q3Tj8d+69HVOg=;
        b=M6RGsme/6z1yBKz6WMcoRdRrp/5jTmHk9PnN6bUO66q1x0x5FcrNmQOOlt3jrHjnrK
         LWTDcoSgDLQnNsPzfdiNHODUSDyusUWQtvsix/czoDt2Eg8fOZpliaoZj+NWEwb3bWWZ
         9oMW1mlpDolmo8kfB1JxYjB1PFxA/Fb+aK9KugKU9z8ZySA1Z5ZzJvVHE0GA2wckhmJx
         EjVll8a2iji1b8xPKMysXt40/bK7qc2ME8Zfs4XKHsDs+bqsOwP80zUzDc2c1HtJCHiU
         3+vq6dt7eRPGgKvoJ0+IOr+hAbpSkgytjLiQ7V5rzkTpvWQLtWmJFcyBU0008zeucy0j
         EeAA==
X-Forwarded-Encrypted: i=1; AJvYcCVoQ4pXeg86pghfxIp3i0bK/bUaTJCm04DsdXl1d0IMJzsjppq9+l/oa4WhN492r7Z77W+fDmiRS23v@vger.kernel.org, AJvYcCWGlrLOXHbxJsVJ7F2oTQW9Y8OOjUdzvMJObu/CALWq1D3hLhK1TsdoErRayDwAJm2hZQp41bK+gf65pfatbNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNBf7SLtneOFBTv1u4FSEq+OG8zpNmAbqa7uXzmtHdVnnJLkhb
	/tvAt31AsKvI757aFj3ADnl+Tg3df5KsOQKDbEOrEXP6jq7YRkLgvIxH
X-Gm-Gg: ASbGncsA5AyS6aU/BOO0xr4FM16VOVgTwX20p+JW8cQrU4AHmG15ngA/HwTwaGb8Twe
	k9uFXIZZLAmnW+91fT31GSaO401SPeMRErgxVE+yw1wCYsr5HJViOMd/NzGqFPmQfs5ZTzES2S3
	idVzQv2dvZU8UkFk7nKP0ULBUpPl5rdMd/rgUraMBWbL0JbiWepBCJDUfvTZIcldvlUYRsn6q72
	RltmlShdLFty4037upR29pYJM0gax6nORXlxVVJmsEoxnfmUkZ1TYFlvstdog+I/qD7UqoETtAO
	C9hY7skkeB6r4AWkh/qqg3WyYfXsFFoDwHo5jkbBnVYyUb4y5ipiK2bYMpe6nit+OuRPf8Iq/Ah
	LhyNSxj986KUNWqerZARhnviEQxCUgYnET8LxRiK+gpOP7iV/e9sDHpSgMYLPwR8vIBgVXg9QpX
	uar1T5SlQJy8FMB00alGYB+4k=
X-Google-Smtp-Source: AGHT+IGYsuwtcaD9p2qDFZIxYfEles6z9LH1aIfFLJPEix8UE5nR53U/JeQa/L99WJAyA5fMWvRKnQ==
X-Received: by 2002:a05:620a:454e:b0:7d3:913e:802e with SMTP id af79cd13be357-7de0709ba58mr438503285a.41.1752242325406;
        Fri, 11 Jul 2025 06:58:45 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcde32bfa7sm223207085a.55.2025.07.11.06.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jul 2025 06:58:44 -0700 (PDT)
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id BAC67F40066;
	Fri, 11 Jul 2025 09:58:43 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 11 Jul 2025 09:58:43 -0400
X-ME-Sender: <xms:kxhxaLlsV-anhNMiiyUlFT22U9-9LUCCQZNTr4woWaphIem-uTcXzA>
    <xme:kxhxaAXqRJHEnyBVsTvZkqos9D2BzY_CwrKC4JwQHOMcOSHC8kM7L5OpgG-790LN5
    fNsr3zuwMnjjmxMHw>
X-ME-Received: <xmr:kxhxaGOBQxt9FWosXRZ_hg6wfSWqBhirRoMMWi4m3dgHmjPvTyTJ6hSvvA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeglecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeeihfdtuedvgedvtddufffggeefhefgtdeivdevveelvefhkeehffdtkeeihedv
    necuffhomhgrihhnpehruhhsthdqlhgrnhhgrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhh
    phgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunh
    drfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphht
    thhopedvjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhoshhsihhnsehkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhu
    gidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:kxhxaDGzMgemcgwMEXssPgVR4J4mm63RviZPLA2049MJNzFnHKlcUg>
    <xmx:kxhxaH2ptwQuN7CKH-2WJ8OdcFC21z16fjUyZJFPxmAXoMnW2y9C3w>
    <xmx:kxhxaLOOWTN36ezpGe6XeIrguqFKu5iAs7doiq57r9UcZIdnOyNUwA>
    <xmx:kxhxaPKdC2pDWJPM2kY1dui55WKKi0Ay5NPfbut5g-3-CmuWmT_Fww>
    <xmx:kxhxaEaNnwsDaJILvhrkG4sW7x2jetU14s0hhM4uy53WktXBz_oNSdnZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 09:58:43 -0400 (EDT)
Date: Fri, 11 Jul 2025 06:58:42 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 4/9] rust: sync: atomic: Add generic atomics
Message-ID: <aHEYkg5K7koUohRo@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-5-boqun.feng@gmail.com>
 <DB92I10114UN.33MAFJVWIX4AB@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB92I10114UN.33MAFJVWIX4AB@kernel.org>

On Fri, Jul 11, 2025 at 10:03:07AM +0200, Benno Lossin wrote:
> On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> > diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> > new file mode 100644
> > index 000000000000..e044fe21b128
> > --- /dev/null
> > +++ b/rust/kernel/sync/atomic/generic.rs
> > @@ -0,0 +1,289 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +//! Generic atomic primitives.
> > +
> > +use super::ops::*;
> > +use super::ordering::*;
> > +use crate::build_error;
> > +use core::cell::UnsafeCell;
> > +
> > +/// A generic atomic variable.
[...]
> 
> > +///
> > +/// # Guarantees
> > +///
> > +/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race,
> > +/// this is guaranteed by the safety requirement of [`Self::from_ptr()`] and the extra safety
> > +/// requirement of the usage on pointers returned by [`Self::as_ptr()`].
> 
> I'd rather think we turn this into an invariant that says any operations
> on `self.0` through a shared reference is atomic.
> 
[...]
> > +/// unit-only enums:
> 
> What are "unit-only" enums? Do you mean enums that don't have associated
> data?
> 

Yes, I used the term mentioned at:

	https://doc.rust-lang.org/reference/items/enumerations.html#r-items.enum.unit-only

> > +///
> > +/// ```
> > +/// #[repr(i32)]
> > +/// enum State { Init = 0, Working = 1, Done = 2, }
> > +/// ```
> > +///
> > +/// # Safety
> > +///
> > +/// - [`Self`] must have the same size and alignment as [`Self::Repr`].
> > +/// - [`Self`] and [`Self::Repr`] must have the [round-trip transmutability].
[...]
> > +        let a = self.as_ptr().cast::<T::Repr>();
> > +
> > +        // SAFETY:
> > +        // - For calling the atomic_read*() function:
> > +        //   - `a` is a valid pointer for the function per the CAST justification above.
> > +        //   - Per the type guarantees, the following atomic operation won't cause data races.
> 
> Which type guarantees? `Self`?
> 

The above "# Guarantees" of `Atomic<T>`, but yeah I think it should be
"# Invariants".

> > +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr()`:
> > +        //   - Atomic operations are used here.
> > +        let v = unsafe {
> > +            match Ordering::TYPE {
> > +                OrderingType::Relaxed => T::Repr::atomic_read(a),
> > +                OrderingType::Acquire => T::Repr::atomic_read_acquire(a),
> > +                _ => build_error!("Wrong ordering"),
> > +            }
> > +        };
> > +
> > +        // SAFETY: The atomic variable holds a valid `T`, so `v` is a valid bit pattern of `T`,
> > +        // therefore it's safe to call `from_repr()`.
[...]

