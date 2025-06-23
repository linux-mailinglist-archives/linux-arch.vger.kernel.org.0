Return-Path: <linux-arch+bounces-12428-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DB59AE34AF
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 07:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CE73B0AD9
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 05:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB7A7261A;
	Mon, 23 Jun 2025 05:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MmlIyqhq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5C51D88D7;
	Mon, 23 Jun 2025 05:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750655992; cv=none; b=N6yQVGFB17KjCO63WDTefyWkonaqByxqvcHdCIvGQajnMtXtZlYo/KuxmikNEJCmBsYlI7JfkzDtEATNXzGh+Z+FZ3tnhVoOEfol9JiJmwV1xIt5cVBSL0MYPIL2xZ3VNsbi5rKWT9IbqTcaoLxqdnwy2HQKsMW8BdQkRypX7/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750655992; c=relaxed/simple;
	bh=aKgrAEOXNkbld4Ie9Ekp8+h4jmc5lia+a7Els9LYiZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpajnGMJM0wcdshoGKEukvHLIYpEBoalOs046RBI3+WY0xI/vZi15ctM7DmgTcSa1OOcawOxoCii7aq9ZjfWnQjoZTPjyD8PLM7BRu2MHQDr7vCMoWh3Poq75Rb5R/LgxHg5xBXMfZmuf472oHyHZpiC9pQlNME85y5nb4D/ewY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MmlIyqhq; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7d40874b399so128384285a.2;
        Sun, 22 Jun 2025 22:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750655989; x=1751260789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73Dr4y2+KJ1iK7WI0eT42/Q1bwAgdohWfah194RDmnM=;
        b=MmlIyqhqclNoxOQgnv4P2uRuPisCspWFdQKzFoyuJLLYVIhJr0X8kyu8zhl/oiHM7X
         nzfHIsk5zbMkGe90HZ0D4QRl2jLfDDEh1B0gYDOuMFxSOSnrIfdH47f0DVsZRM2TjbI+
         X176nKwWwOULcccIX/Kt5GQl3h+BGwGKX+QQpo1ksI5xvbzqrii9G2Y5RWXVYuwr49rI
         OLXLikJBDlPPOLrxVdhCJ7DDtqThfaceBIZtt2Y61qKPXCXVdkc4WBOnfmaeJcx8fQoi
         Qo2mRBlkd/ROS8uSrWqMdx4CaLhYbDzFPVj9haAgRQ3TxZz2Xrj/V/LK0zkbbt6yONWn
         oUPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750655989; x=1751260789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=73Dr4y2+KJ1iK7WI0eT42/Q1bwAgdohWfah194RDmnM=;
        b=Rgz+fcVUlis+nDrOT1ddX6pP8OnNiPRoweQFxS0RKc5+vdG6RBZSx6zlHDMvVgB6KB
         z3owJSryoDzjoFOfjquhZCfiaB6oeul7qQvkoiEjrXMSL33Qkhu0OHTE2k742+xLAYzo
         Q0idmLo1QJlI35LKTvdR8kpHL1fgydSQ/fDDm5V7KHyy+ZD8GjpPsi1CAfm4AmEJOEG4
         7O7xPzloxSb6R8gHe+0ufXC3rpIZnrx1lYZNUOEUS0QKKbWu5+wRrB3NSEaqA8nZRU2J
         ZoxmuWD5j/qDly8MduJxQKwR+CbabJx0/IDxgQoWJOSLzc5yXii0hJ7ZWdgy5ilQR89p
         5CKw==
X-Forwarded-Encrypted: i=1; AJvYcCU6h/ArWWgLAHmKGYI1JjchiCSuUvYv469DhGJjnntL43wHp+r2o0jpsrbaBTrEJA3CxzGjOeosO5J+@vger.kernel.org, AJvYcCXSS8OkpVu8nGFmn+wZIaXUiK0lR9aRx1t+IPO3lIPU4g89qxC/tvGKsTop9pLyPRjOODXEwv4i3/4XtWDdqeg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq/T7seQZQ2rHZ71oxN2jgIuBvU78i8jAMATw7wuIJnGUzn5cS
	n1CnQDmC1UV1Hq+GYd9Hr8LOPMDbFjdCO/tZYG6owDQYc5v7QuAnyx/l
X-Gm-Gg: ASbGncu5a+slLzL2Z2Ou6MugaRZksvuY5u623GvGPYiAWBq0PJWKxoPswzOQuYNeHks
	rpy33nuUSVXo4V5Xw1kbFbTC0ADtbmkh1iqesZV5Zu7DuFih+cei1eIEepznEQ8H7cfXNTG7hpa
	Ewuk9/hAgW4oUraJaFMFrnYMbmmcVhweaVyExdAJ/VPgJgwvjbm7OhYPN3PEYuka7A6lvZDZ75G
	WJ5Mn+99yQLJIIQQnAocuIOgZugLRW52Mr63hXjIYMGXCEN922HHuSI41lkiP9aGzqVv0zPN6Qq
	EiU8euksEUgQc/EyR18RBRzHJ+jKMNz1tgZvNDnWcxtjUlRdEBvHu8OmNCzjdwnXzim2fhoYPtN
	IAcLjetSOYCU1CO/R4kSHtnHAPpLrDNER4+bJ6jV2p/gUHTkdDLxM
X-Google-Smtp-Source: AGHT+IFUgu9MTo+o7ZlLXs0n5yagf8iorT7usjWfEJ1eCDQe/qT5Km51R5iMbip3uVonSVRuA+licw==
X-Received: by 2002:a05:620a:3195:b0:7ce:d04a:83c2 with SMTP id af79cd13be357-7d3f9947bb5mr1577684685a.50.1750655989132;
        Sun, 22 Jun 2025 22:19:49 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99ef89dsm350864385a.64.2025.06.22.22.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 22:19:46 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id CFD401200043;
	Mon, 23 Jun 2025 01:19:45 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Mon, 23 Jun 2025 01:19:45 -0400
X-ME-Sender: <xms:8eNYaOY2avI1mY8STzEhUawgU0L0acMogLsfbNoNcWRrr-3579UK4w>
    <xme:8eNYaBYgivwdmI9nd8B6j7DioDjCoQ9iVGxrQvO65dv1Re42XiALEYpfxCOExuah3
    CgNznusMSmJjmmphg>
X-ME-Received: <xmr:8eNYaI_FSz-Vcu3KHDcWpVh3TjbEdrWWutWiiFI-h4K7lIYq6GkpCe_Pdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdduieduiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepudejleelueduvddthfdvheeiueehkeefudeuueejjeffvddtuedtieffveekleet
    necuffhomhgrihhnpegrsghovhgvrdhsrghfvghthienucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthht
    ohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihgh
    huohdrnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidr
    uggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegr
    lhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghjohhrnhefpg
    hghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghr
    nhgvlhdrohhrgh
X-ME-Proxy: <xmx:8eNYaAoEeW39R8-LVH2XQRGZ5W-qOkgSJaW1MkjJ7pJyDGGFgvhx-g>
    <xmx:8eNYaJp4o_fKR_jZRzGRJNLlyl1XUiiGcThvaicBXNHKKGd99clZsA>
    <xmx:8eNYaORR04m6kwoJPaYJKJaGiExP94zNm0Q8ny7hASbbJo-ELH-rTw>
    <xmx:8eNYaJpHWjNg7b4yB2tg1MWQqaT7sfapho6ApJzliU6Cyyom9kkgLw>
    <xmx:8eNYaG6lbZBaf_Lsa2hy8Ci7JdL668bLkweWgMr7rNSwLt8YqcQ9F8BX>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 01:19:45 -0400 (EDT)
Date: Sun, 22 Jun 2025 22:19:44 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <aFjj8AV668pl9jLN@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250621123212.66fb016b.gary@garyguo.net>

On Sat, Jun 21, 2025 at 12:32:12PM +0100, Gary Guo wrote:
[...]
> > +#[repr(transparent)]
> > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);
> 
> This should store `Opaque<T::Repr>` instead.
> 

"should" is a strong word ;-) If we still use `into_repr`/`from_repr`
it's a bit impossible, because Atomic::new() wants to be a const
function, so it requires const_trait_impl I believe.

If we require transmutability as a safety requirement for `AllowAtomic`,
then either `T` or `T::Repr` is fine.

> The implementation below essentially assumes that this is
> `Opaque<T::Repr>`:
> * atomic ops cast this to `*mut T::Repr`
> * load/store operates on `T::Repr` then converts to `T` with
>   `T::from_repr`/`T::into_repr`.
> 

Note that we only require one direction of strong transmutability, that
is: for every `T`, it must be able to safe transmute to a `T::Repr`, for
`T::Repr` -> `T` transmutation, only if it's a result of a `transmute<T,
T::Repr>()`. This is mostly due to potential support for unit-only enum.
E.g. using an atomic variable to represent a finite state.

> Note tha the transparent new types restriction on `AllowAtomic` is not
> sufficient for this, as I can define
> 

Nice catch! I do agree we should disallow `MyWeirdI32`, and I also agree
that we should put transmutability as safety requirement for
`AllowAtomic`. However, I would suggest we still keep
`into_repr`/`from_repr`, and require the implementation to make them
provide the same results as transmute(), as a correctness precondition
(instead of a safety precondition), in other words, you can still write
a `MyWeirdI32`, and it won't cause safety issues, but it'll be
incorrect.

The reason why I think we should keep `into_repr`/`from_repr` but add
a correctness precondition is that they are easily to implement as safe
code for basic types, so it'll be better than a transmute() call. Also
considering `Atomic<*mut T>`, would transmuting between integers and
pointers act the same as expose_provenance() and
from_exposed_provenance()?


So something like this for `AllowAtomic`, implementation-wise, no need
to change.

    /// Atomics that support basic atomic operations.
    ///
    /// Implementers must guarantee that `into_repr()` and `from_repr()` provide the same results as
    /// transmute between [`Self`] and [`Self::Repr`].
    ///
    /// TODO: Currently the [`AllowAtomic`] types are restricted within basic integer types (and their
    /// transparent new types). In the future, we could extend the scope to more data types when there
    /// is a clear and meaningful usage, but for now, [`AllowAtomic`] should only be implemented inside
    /// atomic mod for the restricted types mentioned above.
    ///
    /// # Safety
    ///
    /// - [`Self`] must have the same size and alignment as [`Self::Repr`].
    /// - Any value of [`Self`] must be safe to [`transmute()`] to a [`Self::Repr`], this also means
    ///   that a pointer to [`Self`] can be treated as a pointer to [`Self::Repr`].
    /// - If a value of [`Self::Repr`] is a result a [`transmute()`] from a [`Self`], it must be safe
    ///   to [`transmute()`] the value back to a [`Self`].
    ///   that a pointer to [`Self`] can be treated as a pointer to [`Self::Repr`].
    /// - The implementer must guarantee it's safe to transfer ownership from one execution context to
    ///   another, this means it has to be a [`Send`], but because `*mut T` is not [`Send`] and that's
    ///   the basic type needs to support atomic operations, so this safety requirement is added to
    ///   [`AllowAtomic`] trait. This safety requirement is automatically satisfied if the type is a
    ///   [`Send`].
    ///
    /// [`transmute()`]: core::mem::transmute
    pub unsafe trait AllowAtomic: Sized + Copy {

Thoughts?

Regards,
Boqun

> #[repr(transparent)]
> struct MyWeirdI32(pub i32);
> 
> impl AllowAtomic for MyWeirdI32 {
>     type Repr = i32;
> 
>     fn into_repr(self) -> Self::Repr {
>         !self
>     }
> 
>     fn from_repr(repr: Self::Repr) -> Self {
>         !self
>     }
> }
> 
> Then `Atomic<MyWeirdI32>::new(MyWeirdI32(0)).load(Relaxed)` will give me
> `MyWeirdI32(-1)`.
> 
> Alternatively, we should remove `into_repr`/`from_repr` and always cast
> instead. In such case, `AllowAtomic` needs to have the transmutability
> as a safety precondition.
> 
[...]

