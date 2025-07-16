Return-Path: <linux-arch+bounces-12816-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D7EB077B2
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 16:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1DA75082D1
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D37921D585;
	Wed, 16 Jul 2025 14:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nO0lDnSU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B923021D5BF;
	Wed, 16 Jul 2025 14:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675189; cv=none; b=YAJN2sTYeVqHKQZKWr5JJAQTmaNt9C9Km/j7hS4RpqLWAmHV6B3Fj95QI0pOMAASuLtsv5hGA/coraS4DT05RNZdDLMYI1N+KcJHr8nJTBlTUXogl2I6V/6SLNy4UQBWvhVucz23FlLedihSSi9gVV9PxAox8g+778ShsYR4sEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675189; c=relaxed/simple;
	bh=osujWBWTkv47BDH9MlpLEqmFC0jybWONqJ+k3LU9KlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gaJB/cut8nISfzhLkaDTboUKqsRG7jDoK5oEYqmRPe7UVR5Cc3UGSVc0rA6eeCfbuUcA6yNWAAt8r/htglfA/D1mcMQQsPzK6QersZya7tAUKK3DZe3Wsjrwf8+EoewCzFl9hnKul6IkrTjofLEuQ3N+lWIJtmewJKNxQbwQH2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nO0lDnSU; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7e050bd078cso432772785a.3;
        Wed, 16 Jul 2025 07:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752675186; x=1753279986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5oxEdedDYsBK7iLX0J3I5UZ7nuhhkQxgKr1r6D9i2m0=;
        b=nO0lDnSUsMLxE1jfdScBxLbDnN43bPb+kwBA3yrgYVxJBQd+0lkzhCi7qDQd3vRxEq
         aE7KGBkClAc+6D/xCykuMEH0IrM/vfCYGXdXesnZ6fVYUVr6rxw9RDLP8LDqMughP5/X
         e4W8GLvsfHfpEzdBXcLqaSOca5xTYIPL9hQri/Kp7bF8YBVsjcWnXiCZh9oGaQgzFiXv
         yfFyUBn0DZ4hvBe8WghV0qIz62aiCYjj3NnKz6gMG40Oy5Galjjr9nHZ3zOIVUp7bmgt
         MRzSD8Chlv3F6lOPs40M9nKuVYYD9ZFjIpCyeShEl92Y4v+9M/DfXXnhLi6hPBA7ncDg
         2HiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675186; x=1753279986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5oxEdedDYsBK7iLX0J3I5UZ7nuhhkQxgKr1r6D9i2m0=;
        b=grXPczLVtGnAJh9LcMaVraqGUv2wsVLuReqjBoEes7muiG+S3LTZXxmIXerdjaExKt
         ZBS7a6ieDugvHWscqiDkZ9klUmx4r91eq6HiTajRGpxcn9GlBRMBh/se3YHtHvEYDswo
         vS2YPhrbXV8+yS7yolueorpTUMqHacZcExmRApl7BJOeWRRfrOrdkdgZ24TqStLsHlqN
         NfsAnKVr8wU6oJ5cm75uCtw6WLVtAK/xZvnrpYuxHVPHfRIfKcsjw5bbJN+zzmV2jMDm
         7V1Bs2S+nrqjgXxOyGaq3PzuTjtvtj+FDx1hKkRxhiGPwX0hcXn3kdtTXY5Cok3CjS6f
         fG4Q==
X-Forwarded-Encrypted: i=1; AJvYcCV1B5fvNlNzshMaN1VYCJpoeuBOcJxJmtkgW9P6ViQtHrozLc9earOjDfF4jkBzosFy3ewuS2bmrP2JPcc2qu4=@vger.kernel.org, AJvYcCWyndZB3xhhbGjUQdZuW9ds56rXZlmlT+o8KIDnFm4epODvbU3u39WJqwGhKeOvIleSmh62iDC61KKt@vger.kernel.org
X-Gm-Message-State: AOJu0YxYH9y5QY8dzyt6o8B5zu7/D50zjhfGFlsP0M2F4fwfJAQKnXI2
	3kM2E7V1ry3StNIOp8eE52HUJBMv6RZY1sWTv3uptcEpeb3rmyQzGCul
X-Gm-Gg: ASbGncvCmf0TiFpD7K9ZHvB00NqbweEzcRaSkClKxymYYVePN9sIH4H/GFaRhCCFBmr
	fsXUyZPH7hCH6AD3yX4IVIiQ4BfgRjA/oQgzb7bJrGfaPbZLCdmDoUi5dAsmvg/oe77rblj1bmd
	HEtqzcl0lEPmGLZOMBgdkBSP7rW0qZbNHJPfh/XiD4iNIZNw1DRdFuWSjzG8Hk8OF7beLDdBBcl
	neKeDpNKPG3UZ0cG7BXsbbvAa864sDbye9Qh+KgJVJaBGVHaYiGOK3yy4wuLvIIN+UuFylHhn7q
	1ZZmHvHjrGifhgNhKbsZmZub/AMHgH70aX7B9kNiKix9U6x+7KpP1y2yhPPjzf9fqkEWbkd0iGP
	PQuBoSi7vYkqJyug5l+kBy5cNANWznYj0t8YM3x5gBRrln02nTDMxa+6hfWq5t1YLknS0KggtkN
	Si5m4C5kH04dZU
X-Google-Smtp-Source: AGHT+IEHzLsQAehbbrKU/TVMPV7nXUAj+qML9zKFPbg0x8a0TcuYEYgYT/wn98XUxcliDPTG0VwhTg==
X-Received: by 2002:a05:620a:2285:b0:7e3:4378:ddab with SMTP id af79cd13be357-7e34378ddbbmr274894185a.22.1752675186207;
        Wed, 16 Jul 2025 07:13:06 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7dcdebea43bsm754644885a.102.2025.07.16.07.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:13:04 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8EC99F4006B;
	Wed, 16 Jul 2025 10:13:03 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 16 Jul 2025 10:13:03 -0400
X-ME-Sender: <xms:b7N3aOdt8HjwlA34HF-9A1nbyFA95oonU_oUMuq4L57tOQYqMTSpcw>
    <xme:b7N3aJu-4W3MMgRCpGmUjOj1BZ36GEQrSx6vme7mF6M3tO4Baz-M9eiEgg_74aWtd
    5Nri97zvsUNtF4bVQ>
X-ME-Received: <xmr:b7N3aEHJUP8OQkZKGZ88rrZ1S6ToinilzlOpiMOYVkhj4ZNtSNDt5Oqi6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehjeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:b7N3aLfAE9TdA6tYKOu6CkHcDrFOcD_eHxL9CKTV9GQeTfKB56XZPA>
    <xmx:b7N3aIvPOB7dl_k9Ly8hTQumGsfFzHPzdvIlnXsd_s-QXnEIkBcTbg>
    <xmx:b7N3aKlWb1COumL2IK8veDVN4qcd7bwq2ZJQefO3KsiJixCVShakYw>
    <xmx:b7N3aLDFwAiFUEtLrbbM-6cH4e3hbk-7Yc8lk8ScwpEUCBWOUWOgpw>
    <xmx:b7N3aCwtnscGWHWAGUXbsahp-4mc70Pm2v4EQHNTb9c9VlZv9EZsPD9v>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 10:13:02 -0400 (EDT)
Date: Wed, 16 Jul 2025 07:13:01 -0700
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
Subject: Re: [PATCH v7 6/9] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <aHezbbzk0FyBW9jS@Mac.home>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-7-boqun.feng@gmail.com>
 <DBCL7YUSRMXR.22SMO1P7D5G60@kernel.org>
 <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
 <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>
 <aHa2he81nBDgvA5u@tardis-2.local>
 <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org>

On Wed, Jul 16, 2025 at 12:25:30PM +0200, Benno Lossin wrote:
> On Tue Jul 15, 2025 at 10:13 PM CEST, Boqun Feng wrote:
> > On Tue, Jul 15, 2025 at 08:39:04PM +0200, Benno Lossin wrote:
> > [...]
> >> >> > Hmm.. the CAST comment should explain why a pointer of `T` can be a
> >> >> > valid pointer of `T::Repr` because the atomic_add() below is going to
> >> >> > read through the pointer and write value back. The comment starting with
> >> >> > "`*self`" explains the value written is a valid `T`, therefore
> >> >> > conceptually atomic_add() below writes a valid `T` in form of `T::Repr`
> >> >> > into `a`.
> >> >> 
> >> >> I see, my interpretation was that if we put it on the cast, then the
> >> >> operation that `atomic_add` does also is valid.
> >> >> 
> >> >> But I think this comment should either be part of the `CAST` or the
> >> >> `SAFETY` comment. Going by your interpretation, it would make more sense
> >> >> in the SAFETY one, since there you justify that you're actually writing
> >> >> a value of type `T`.
> >> >> 
> >> >
> >> > Hmm.. you're probably right. There are two safety things about
> >> > atomic_add():
> >> >
> >> > - Whether calling it is safe
> >> > - Whether the operation on `a` (a pointer to `T` essentially) is safe.
> >> 
> >> Well part of calling `T::Repr::atomic_add` is that the pointer is valid.
> >
> > Here by saying "calling `T::Repr::atomic_add`", I think you mean the
> > whole operation, so yeah, we have to consider the validy for `T` of the
> > result.
> 
> I meant just the call to `atomic_add`.
> 
> > But what I'm trying to do is reasoning this in 2 steps:
> >
> > First, let's treat it as an `atomic_add(*mut i32, i32)`, then as long as
> > we provide a valid `*mut i32`, it's safe to call. 
> 
> But the thing is, we're not supplying a valid `*mut i32`. Because the
> pointer points to a value that is not actually an `i32`. You're only
> allowed to write certain values and so you basically have to treat it as
> a transmute + write. And so you need to include a justification for this
> transmute in the write itself. 
> 
> For example, if we had `bool: AllowAtomic`, then writing a `2` in store
> would be insta-UB, since we then have a `&UnsafeCell<bool>` pointing at
> `2`.
> 
> This is part of library vs language UB, writing `2` into a bool and
> having a reference is language-UB (ie instant UB) and writing a `2` into
> a variable of type `i32` that is somewhere cast to `bool` is library-UB
> (since it will lead to language-UB later). 
> 

But we are not writing `2` in this case, right? 

A) we have a pointer `*mut i32`, and the memory location is valid for
   writing an `i32`, so we can pass it to a function that may write
   an `i32` to it.

B) and at the same time, we prove that the value written was a valid
   `bool`.

There is no `2` written in the whole process, the proof contains two
parts, that is it. There is no language-UB or library-UB in the whole
process, and you're missing it.

It's like if you want to prove 3 < x < 5, you first prove that x > 3
and then x < 5. It's just that you don't prove it in one go.

> The safety comments become simpler when you use `UnsafeCell<T::Repr>`
> instead :) since that changes this language-UB into library-UB. (the
> only safety comment that is more complex then is `get_mut`, but that's
> only a single one)
> 
> If you don't want that, then we can solve this in two ways:
> 
> (1) add a guarantee on `atomic_add` (and all other operations) that it
>     will write `*a + v` to `a` and nothing else.
> (2) make the safety requirement only require writes of the addition to
>     be valid.
> 
> My preference precedence is: use `T::Repr`, (2) and finally (1). (2)
> will be very wordy on all operations & the safety comments in this file,
> but it's clean from a formal perspective. (1) works by saying "what
> we're supplying is actually not a valid `*mut i32`, but since the
> guarantee of the function ensures that only specific things are written,
> it's fine" which isn't very clean. And the `T::Repr` approach avoids all
> this by just storing value of `T::Repr` circumventing the whole issue.
> Then we only need to justify why we can point a `&mut T` at it and that
> we can do by having an invariant that should be simple to keep.
> 
> We probably should talk about this in our meeting :)
> 

I have a better solution:

in ops.rs

    pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>)

    impl AtomicArithmeticOps for i32 {
        // a *safe* function
        fn atomic_add(a: &AtomicRepr, v: i32) {
	    ...
	}
    }

in generic.rs

    pub struct Atomic<T>(AtoimcRepr<T::Repr>);

    impl<T: AtomicAdd> Atomic<T> {
        fn add(&self, v: .., ...) {
	    T::Repr::atomic_add(&self.0, ...);
	}
    }

see:

	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-atomic-impl

Regards,
Boqun

> ---
> Cheers,
> Benno
> 
> > And second assume we call it with a valid pointer to `T::Repr`, and a
> > delta from `rhs_into_delta()`, then per the safety guarantee of
> > `AllowAtomicAdd`, the value written at the pointer is a valid `T`.
> >
> > Based on these, we can prove the whole operation is safe for the given
> > input.
> >
> >> But it actually isn't valid for all operations, only for the specific
> >> one you have here. If we want to be 100% correct, we actually need to
> >> change the safety comment of `atomic_add` to say that it only requires
> >> the result of `*a + v` to be writable... But that is most likely very
> >> annoying... (note that we also have this issue for `store`)
> >> 
> >> I'm not too sure on what the right way to do this is. The formal answer
> >> is to "just do it right", but then safety comments really just devolve
> >> into formally proving the correctness of the program. I think -- for now
> >> at least :) -- that we shouldn't do this here & now (since we also have
> >> a lot of other code that isn't using normal good safety comments, let
> >> alone formally correct ones).
> >> 
> >> > How about the following:
> >> >
> >> >         let v = T::rhs_into_delta(v);
> >> >         // CAST: Per the safety requirement of `AllowAtomic`, a valid pointer of `T` is a valid
> >> >         // pointer of `T::Repr` for reads and valid for writes of values transmutable to `T`.
> >> >         let a = self.as_ptr().cast::<T::Repr>();
> >> >
> >> >         // `*self` remains valid after `atomic_add()` because of the safety requirement of
> >> >         // `AllowAtomicAdd`.
> >> >         //
> >> >         // SAFETY:
> >> >         // - For calling `atomic_add()`:
> >> >         //   - `a` is aligned to `align_of::<T::Repr>()` because of the safety requirement of
> >> >         //   `AllowAtomic` and the guarantee of `Atomic::as_ptr()`.
> >> >         //   - `a` is a valid pointer per the CAST justification above.
> >> >         // - For accessing `*a`: the value written is transmutable to `T`
> >> >         //   due to the safety requirement of `AllowAtomicAdd`.
> >> >         unsafe { T::Repr::atomic_add(a, v) };

