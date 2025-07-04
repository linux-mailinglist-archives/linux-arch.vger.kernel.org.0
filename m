Return-Path: <linux-arch+bounces-12566-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A29EAF9BAB
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 22:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 006C53A80B4
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 20:25:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B90021930A;
	Fri,  4 Jul 2025 20:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqi2iFfU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB521E4AE;
	Fri,  4 Jul 2025 20:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751660726; cv=none; b=W6OBQNinTZyhdLEt1L89HsyOE+sFbMUgUBTP7PUYMSPGdkvNYv65UoOXTxpBP7HEAJLBOnmo2/4qApZfY3mNTwEh1tTi4pwGkHihvxjNZ89BnWFauKFPDAJJyd1Ooji8X33CsVasSAaaw+z0a/W3umIrVqueLbxm7e4KKH2UFFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751660726; c=relaxed/simple;
	bh=8ONKBczAcoAupa0sWz4Fs7VvElHdMFKermzcLXdRHnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yp4mOgun0G5jKywIMq1/cHRkl9RGn7Xg20bjiC2BToRriNs0z+J+vjZ6Q6AYfzDGxed30efQKUpa8jwfXb9WV0UbKnXK1U/ml9COlzJUnBu1ruwQzXVvfGgbrA9808VlatfOzxbBcEQZDVlUmQ23ry8P5OuBn4JpeH8q78IVCSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqi2iFfU; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6fad4e6d949so8053416d6.0;
        Fri, 04 Jul 2025 13:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751660723; x=1752265523; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ieDkWPWYpbEbfvpC14I2yn3YD4poh1OnnQQlUX+8JM=;
        b=Tqi2iFfURwxLeRCdkSPeTfytWvEwp8uOcSzwxegA09FxBGhdKa2yFlfW6Sx54iDQjC
         5oiuf2Wl1jAqULwp2mbdt8YaoFkireQaubzlQ3KrI8T6W6uL41/MMvNmuuM8fqZvV8LX
         gBN+Evdf+lnEcqWzpGfdtCnF9gPkkbxTY4HGQzxwITBrlseIeQ5AGUmbT1UWiZfRl0pX
         g8U4M3h/SLrY8I0vUs/KK/teKTRhy8KiFIBcS7c8KFJtFwhAnC67TsyEWXX7eL17Q/W0
         nxsneQJDyMNNj8Wx50ZL71xi2CzlaMqNzV6siB/mUKog0ppYAMPvz5RyBH0TxwsoCjM8
         yAwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751660723; x=1752265523;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ieDkWPWYpbEbfvpC14I2yn3YD4poh1OnnQQlUX+8JM=;
        b=N5d/Lq8l2jkBJt6WDQYTRZYhzGqyrtnzKOuywA+m83ab4KtQLxxfHTxo9SUCwgy0B4
         PGwmOmmXlACUabS7jWT13x8SegFUCYL3fnJn5OSHbKN13CLuX0zJkagdI8EMSe7x3Ue9
         Lu9LL23RLVh1vd1lB2hAqJo3oMMKNgv6iEYQJbgEZjzbE1ewruXv/DkjHxEhe6lzlIX7
         RY1PsGmzZYtcb5cM/odR7rEnLshkOCW2HNyMQfiYjfIpcZ2ksgXITkkDr9Gz8AQ41EY9
         FsJbkbVnRFYf1Xl4v8BVwpWt9YRSNqxRV3Y1Wz+uZjfQPK/iwc+91iaWuYjOuuy68pog
         6YnQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1YtscA/2KRa0ZFOrtjIhhd6ZenKwgQcyFksLjw19P5kJBxdP5V5nNHSABjmX6rVZRLsMqiZmI9w9bicsGMVs=@vger.kernel.org, AJvYcCV6ExBJKWKQvQQV5RX+rTJTEw949akZCGXUchOeHGDdw+iFywIcUE/kI14+hjVBN1+xubCo+CTr62xN@vger.kernel.org
X-Gm-Message-State: AOJu0YyvOjXSPsn6seTWptVnL30mALYqKigm45UKXFmC5FQAEaxzEGwT
	iEV2rtT4JMJNp5VLG0dgK5zy/EwXVnhyqFnGKRPH4xzvPq/gNh4ITvLV
X-Gm-Gg: ASbGnctMZS3Oc9G0fjY1K08oDNdb0jGeO2KUcM8qVyiB+domCdbKdQTH5zuKnSYNysi
	nAbofbsD8ScPx5WDMq/hDFyxiPio9O1mvzAp3dymPzyi0BnVjGYFVW8DPP/p2dCc4zf1WIkJ19Y
	oz5ZoMpVvgvs6ToKZx6p6tCGKsnnO47bjoG96/7tG76Iw/rtg/fJZeV5jS/IYwGuxqtfhOj+SDV
	VHnWJa7ql3ydixRrMBO4mFlibhUdW14gkjXw3g58/1k/CJSM7JEtsRiO/57gnkXj3K+Tj8SnH/9
	481XLmyCIZh5yjB0G5NhYOepmEJo9a1mIur8XIgJJrsqW+83ronsbOxhnMtmj0GxQnLuGGfw/Dd
	WLsyzYGzWvzMzlKMb00zTOZ/mu4DFWIySwRLDT7nWOJak7zOtJQaD
X-Google-Smtp-Source: AGHT+IHUPSjkAPnAQgg+ShSWKvcuKJlXl3+Jkt7DJ6lGqMF2S5k/FpndMrTnv45qROvemTwVLrDYcA==
X-Received: by 2002:ad4:5ba2:0:b0:700:c1c9:9c24 with SMTP id 6a1803df08f44-702c8b90447mr47131726d6.14.1751660723391;
        Fri, 04 Jul 2025 13:25:23 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4cc75a2sm18185486d6.15.2025.07.04.13.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 13:25:23 -0700 (PDT)
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 42435F40068;
	Fri,  4 Jul 2025 16:25:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 04 Jul 2025 16:25:22 -0400
X-ME-Sender: <xms:sjhoaKIo2ReoaKQcdUzWvqExKdI1ONYO_XF3_luzvz1uFjNJsbIsXQ>
    <xme:sjhoaCL1RXsFavr4W53hEA9S7JQVM8Kd3__4Dar6fATugn4X5TL6W5yQ-tjmeAUaf
    rg2hevqe26xJS1Dag>
X-ME-Received: <xmr:sjhoaKtDvsUZ3VTDGzKYwvp199fpOdXIJTPbtIAR_UtqUUVSkLmBT0GM3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrhiesghgrrhihghhuoh
    drnhgvthdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggv
    vhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgv
    gidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepsghjohhrnhefpghghh
    esphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgv
    lhdrohhrgh
X-ME-Proxy: <xmx:sjhoaPbdVRMS21nw8AO5EaWPJjZgKXNbWKcMQU__Dn1nidRipR_yUg>
    <xmx:sjhoaBZKBpBuj8WVXDxuwdImUnwZO07szFNDylwbW__dv34Wijk_Jw>
    <xmx:sjhoaLDra9ptDDgL1viTKR0zx06YrMmf1uzZcE2UQW4xjHxExz87pg>
    <xmx:sjhoaHYLkU75PhpVsI8_mSBoMpkW-OtIylWM8VI08qmJZqBKUPWdfQ>
    <xmx:sjhoaBqyhrGp5pdFH18GitbXQFjrvr5K6AQUBgI_DfDuf4ZH16zJpja8>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 16:25:21 -0400 (EDT)
Date: Fri, 4 Jul 2025 13:25:20 -0700
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
Message-ID: <aGg4sIORQiG02IoD@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFmmYSAyvxotYfo7@tardis.local>

On Mon, Jun 23, 2025 at 12:09:21PM -0700, Boqun Feng wrote:
> On Mon, Jun 23, 2025 at 07:30:19PM +0100, Gary Guo wrote:
> > On Sun, 22 Jun 2025 22:19:44 -0700
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> > 
> > > On Sat, Jun 21, 2025 at 12:32:12PM +0100, Gary Guo wrote:
> > > [...]
> > > > > +#[repr(transparent)]
> > > > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);  
> > > > 
> > > > This should store `Opaque<T::Repr>` instead.
> > > >   
> > > 
> > > "should" is a strong word ;-) If we still use `into_repr`/`from_repr`
> > > it's a bit impossible, because Atomic::new() wants to be a const
> > > function, so it requires const_trait_impl I believe.
> > > 
> > > If we require transmutability as a safety requirement for `AllowAtomic`,
> > > then either `T` or `T::Repr` is fine.
> > > 
> > > > The implementation below essentially assumes that this is
> > > > `Opaque<T::Repr>`:
> > > > * atomic ops cast this to `*mut T::Repr`
> > > > * load/store operates on `T::Repr` then converts to `T` with
> > > >   `T::from_repr`/`T::into_repr`.
> > > >   
> > > 
> > > Note that we only require one direction of strong transmutability, that
> > > is: for every `T`, it must be able to safe transmute to a `T::Repr`, for
> > > `T::Repr` -> `T` transmutation, only if it's a result of a `transmute<T,
> > > T::Repr>()`. This is mostly due to potential support for unit-only enum.  
> > > E.g. using an atomic variable to represent a finite state.
> > > 
> > > > Note tha the transparent new types restriction on `AllowAtomic` is not
> > > > sufficient for this, as I can define
> > > >   
> > > 
> > > Nice catch! I do agree we should disallow `MyWeirdI32`, and I also agree
> > > that we should put transmutability as safety requirement for
> > > `AllowAtomic`. However, I would suggest we still keep
> > > `into_repr`/`from_repr`, and require the implementation to make them
> > > provide the same results as transmute(), as a correctness precondition
> > > (instead of a safety precondition), in other words, you can still write
> > > a `MyWeirdI32`, and it won't cause safety issues, but it'll be
> > > incorrect.
> > > 
> > > The reason why I think we should keep `into_repr`/`from_repr` but add
> > > a correctness precondition is that they are easily to implement as safe
> > > code for basic types, so it'll be better than a transmute() call. Also
> > > considering `Atomic<*mut T>`, would transmuting between integers and
> > > pointers act the same as expose_provenance() and
> > > from_exposed_provenance()?
> > 
> > Okay, this is more problematic than I thought then. For pointers, you
> 
> Welcome to my nightmare ;-)
> 
> > cannot just transmute between from pointers to usize (which is its
> > Repr):
> > * Transmuting from pointer to usize discards provenance
> > * Transmuting from usize to pointer gives invalid provenance
> > 
> > We want neither behaviour, so we must store `usize` directly and
> > always call into repr functions.
> > 
> 
> If we store `usize`, how can we support the `get_mut()` then? E.g.
> 
>     static V: i32 = 32;
> 
>     let mut x = Atomic::new(&V as *const i32 as *mut i32);
>     // ^ assume we expose_provenance() in new().
> 
>     let ptr: &mut *mut i32 = x.get_mut(); // which is `&mut self.0.get()`.
> 
>     let ptr_val = *ptr; // Does `ptr_val` have the proper provenance?
> 

There are a few off-list discussions, and I've been trying some
experiment myself, here are a few points/concepts that will help future
discussion or documentation, so I put it down here:

* Round-trip transmutability (thank Benno for the name!).

  We realize this should be a safety requirement of `AllowAtomic` type
  (i.e. the type that can be put in a Atomic<T>). What it means is:

  - If `T: AllowAtomic`, transmute() from `T` to `T::Repr` is always
    safe and
  - if a value of `T::Repr` is a result of transmute() from `T` to
    `T::Repr`, then `transmute()` for that value to `T` is also safe.

  This essentially means a valid bit pattern of `T: AllowAtomic` has to
  be a valid bit pattern of `T::Repr`.

  This is needed because the atomic framework operates on `T::Repr` to
  implement atomic operations on `T`.

  Note that this is more relaxed than bi-direct transmutability (i.e.
  transmute() between `T` and `T::Repr`) because we want to support
  atomic type over unit-only enums:

    #[repr(i32)]
    pub enum State {
        Init = 0,
	Working = 1,
	Done = 2,
    }

  This should be really helpful to support atomics as states, for
  example:

    https://lore.kernel.org/rust-for-linux/20250702-module-params-v3-v14-1-5b1cc32311af@kernel.org/

* transmute()-equivalent from_repr() and into_repr().

  (This is not a safety requirement)

  from_repr() and into_repr(), if exist, should behave like transmute()
  on the bit pattern of the results, in other words, bit patterns of `T`
  or `T::Repr` should stay the same before and after these operations.

  Of course if we remove them and replace with transmute(), same result.

  This reflects the fact that customized atomic types should store
  unmodified bit patterns into atomic variables, and this make atomic
  operations don't have weird behavior [1] when combined with new(),
  from_ptr() and get_mut().

* Provenance preservation.

  (This is not a safety requirement for Atomic itself)

  For a `Atomic<*mut T>`, it should preserve the provenance of the
  pointer that has been stored into it, i.e. the load result from a
  `Atomic<*mut T>` should have the same provenance.

  Technically, without this, `Atomic<*mut T>` still work without any
  safety issue itself, but the user of it must maintain the provenance
  themselves before store or after load.

  And it turns out it's not very hard to prove the current
  implementation achieve this:

  - For a non-atomic operation done on the atomic variable, they are
    already using pointer operation, so the provenance has been
    preserved.
  - For an atomic operation, since they are done via inline asm code, in
    Rust's abstract machine, they can be treated as pointer read and
    write:

    a) A load of the atomic can be treated as a pointer read and then
       exposing the provenance.
    b) A store of the atomic can be treated as a pointer write with a
       value created with the exposed provenance.

    And our implementation, thanks to no arbitrary type coercion,
    already guarantee that for each a) there is a from_repr() after and
    for each b) there is a into_repr() before. And from_repr() acts as
    a with_exposed_provenance() and into_repr() acts as a
    expose_provenance(). Hence the provenance is preserved.

  Note this is a global property and it has to proven at `Atomic<T>`
  level.

Regards,
Boqun

