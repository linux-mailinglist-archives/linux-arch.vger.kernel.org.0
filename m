Return-Path: <linux-arch+bounces-12823-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5890BB07C2C
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 19:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F073B041D
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 17:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23EB2F5339;
	Wed, 16 Jul 2025 17:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1e29Vue"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B55E61E0E14;
	Wed, 16 Jul 2025 17:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752687498; cv=none; b=rn/vWNQZA0I1ejV78i1Ssbzgit9JjZYOYahxH8Gdcy9V1aKdXhqpyNpApOI3yCNRnlU4fTx/ibNRqWoiS/TKDVRirbRUvY3avPtBUsjnxXUZtNLL1kcZk5zm95dttxxIC0CQJmt+cXF9a1Fhaz6SFqptFb2UaWFFqq3U9xlhSXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752687498; c=relaxed/simple;
	bh=hwFt5JgyJnM6fRddKezbFqDWwSiXWnG7mQ3pfMQpna0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HzJiwWFPHw+pKdXVQ1cL/tKvG565XxjFknQ2aR3vRV0b94VedXTGfphZUn1Bfw2s7GZt/iRahfVknRq86KWfZT8JM7fQ9kPGJMgx982O9gl5HneH9hnuU0x52cSymWQGgBRSUnN5kYi27IAwnm9JtQVdtHGdXp5H/rGDEpFUtwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1e29Vue; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6facacf521eso1774756d6.3;
        Wed, 16 Jul 2025 10:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752687496; x=1753292296; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R0w70VSXxhIR5wvQCxbTzFCPPCvDaebArjr1LK5bYl4=;
        b=a1e29VueSMUdS3RDpX8ew8Y64mTN/l0V55HqQt7+5J8tPrmnDcWUtVZyNOKibJ/tf3
         TlZadntFo11gkhB6FLVJndPukHZcGmdQCu9yvCOZ3ZrA0Qbq6wnHuGsXmpBDFI4Nr7FD
         oj6CSos0rR2eeOYsAr7zOFHheL/5B+MAHpVaOlfOGaw2tjt5IWUBDaflFRA2NynaHjWy
         61e5M47yS2T2mCrDiQzP4l4wV42BA76CKEDoB1M2EGODHYsxoDf/W7thvAxBKSMMt29r
         iQdMRmuE4+CyjjszLRtrTrBRMkfct2QkhBkc6Als7q4Dv/AaUFI64dBcuZoDDZI9xYOz
         RHNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752687496; x=1753292296;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R0w70VSXxhIR5wvQCxbTzFCPPCvDaebArjr1LK5bYl4=;
        b=cJyrTlnWnP8EemcXz6gcS03H3HePH2iJWVrtFS/SyE8oAMjSNMgr7ZXPyVnsYaa7VO
         Vv1+DsAXiCnoar4sW4udxFfuICS5fg/8PnhxUokD0kig1KOCYCoBCdLlUtcDb5tmJUPS
         P9sK+p08t86UBWFvPKWJpWOgoZsfoe6tg7snqkMkeclDdtXSNCNkXrl6k3E/wiMBI940
         x20n40tSxKWHCJ7i737FI7KjXA7vyxNKepB2JuQOMsXz+U5rD2TITBxH1766pOUc1zeA
         0vZhhznoSoy01GS1ENQJxGPB2xu1moyIZZsLZ76XHT+84qaeOFEZBMCZ++/Ys3+KNPwA
         n2Zw==
X-Forwarded-Encrypted: i=1; AJvYcCVixAAky9fgK6vGr38SmjoPXk8Bzjgv/PvS9WpxRU4vlZHIXwLoBTw4lPTBBaktS2n7+m+DbeIffGGu@vger.kernel.org, AJvYcCXvFy0FmTHUcmQQhx7qu7JGbFbXAmfAgkRoYsrtp0QZTLHVqdUqvwcaUeFub5n9ZJZnpjatT5MijWtNm91xIyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDTk/czvaoiBeeTqUOmP4TBYNB4E5o+A7G2qZ7pfA9DiVa3R1k
	0tneShDlPwBNpX8S+hULlzHtIQ3LS6iFqr/S5STpY5riNflWKYwczcEJ
X-Gm-Gg: ASbGncsxlKXzz+TB/4eiHRopwuKzQLaxA9xFgaiNIheRPbT4LhYn5BZRtlK905hToOX
	9R+XGVVB14LBA7a4chBo+d4ikyIMJwosVUthvPs+1GmUT/Qltx7G3EFb2JZufJU3J4WphtCBsSl
	gNzz9IwZtsMzd93bv2ekc4FSnlFFZGPX02QZhh+bf7bPlFTu5NucgXzzOircMIPcARaZFfakjNH
	7aIqwcDGKtoacCcxqXrdcOniOVT81YgcvMs/XRaNBWkxpZST3MKuZXZwH9uAVo8IccS22FzXE6K
	0ckMGR6lpuQUi1fdaYge8xOri3+6ohy+BQ1Dm/zAEeX3sr2e2a5guLoA/qVryR1JBvwDkduo6y1
	Bc/YfGbT4UJZ4JYsAwwkPlBtew9fhjUS7y/DjUKiZQZXL5ADGXJuZK7iBrPAF6Q1wfv45Gp1sit
	XNeWNbZDa+T50zdEweaMIQ4mw=
X-Google-Smtp-Source: AGHT+IHXXkjwOxGahH8fFj1RMMHTFy2y+TzXu8ch0VEcl1er1f6Qb+4zYOHN9wmf6UbbwIebNk4j+A==
X-Received: by 2002:a05:6214:440f:b0:702:c4d8:ec02 with SMTP id 6a1803df08f44-704f4aed57amr60900036d6.40.1752687495480;
        Wed, 16 Jul 2025 10:38:15 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70497d94538sm72665236d6.99.2025.07.16.10.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 10:38:15 -0700 (PDT)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4AC26F40068;
	Wed, 16 Jul 2025 13:38:14 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 16 Jul 2025 13:38:14 -0400
X-ME-Sender: <xms:huN3aLqweUz7lDKDE7jAY5LxjGROOpssYd2rQHCYaRg9yb72KGBu0A>
    <xme:huN3aHLE4GU4wo90VxqmEZkq2jS9H0xkQo7ZkDd6FjP0SFOK-1-wlmDyEq3a6i4GL
    cSkCrYV5E7C8-3wAg>
X-ME-Received: <xmr:huN3aMxvWYqdGX_IkalqREt-YGRB9jUgftzJ7jBTWTZfoeVOJ62q7sEgxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehkeefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepjeffgeeijedvtdfgkeekhfejgeejveeuudfgheeftdekffejtdelieeuhfdvfeeg
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
X-ME-Proxy: <xmx:huN3aOaLh96VjlM0tAa_5JffFeuwfyJDCnPHeTp-MBLX6mVQIXt1cw>
    <xmx:huN3aI6MZquKk6JUl0Ao7_26RgoJA56aXEzstorl-KlYEaB9C75mvw>
    <xmx:huN3aPCCfV2um4Jsag1kwZpOfMLt6m4nf02yFxRxxnrHQ5WxsMMvLA>
    <xmx:huN3aOtpBbdf2aJCyRM4onktF4vLuQIk9khtjuTphy2DvyGhIQKK0Q>
    <xmx:huN3aEscyTaoW9zX8nna3ZyB5WOaQyxKi7Jrdv4luenGEHhyreMS7rSr>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Jul 2025 13:38:13 -0400 (EDT)
Date: Wed, 16 Jul 2025 10:38:12 -0700
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
Message-ID: <aHfjhFqSinNOvMkf@Mac.home>
References: <aHZYt3Csy29GF2HM@Mac.home>
 <DBCQUAA42DHH.23BNUVOKS38UI@kernel.org>
 <aHZ-HP1ErzlERfpI@Mac.home>
 <DBCUJ4RNRNHP.W4QH5QM3TBHU@kernel.org>
 <aHa2he81nBDgvA5u@tardis-2.local>
 <DBDENRP6Z2L7.1BU1I3ZTJ21ZY@kernel.org>
 <aHezbbzk0FyBW9jS@Mac.home>
 <DBDL9KI7VNO2.1QZBWS222KQGP@kernel.org>
 <aHfJx5_kMcULUd7t@Mac.home>
 <DBDNE3CNUOZP.1H168Z8BD6ZKK@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBDNE3CNUOZP.1H168Z8BD6ZKK@kernel.org>

On Wed, Jul 16, 2025 at 07:16:02PM +0200, Benno Lossin wrote:
> On Wed Jul 16, 2025 at 5:48 PM CEST, Boqun Feng wrote:
> > On Wed, Jul 16, 2025 at 05:36:05PM +0200, Benno Lossin wrote:
> > [..]
> >> >
> >> > I have a better solution:
> >> >
> >> > in ops.rs
> >> >
> >> >     pub struct AtomicRepr<T: AtomicImpl>(UnsafeCell<T>)
> >> >
> >> >     impl AtomicArithmeticOps for i32 {
> >> >         // a *safe* function
> >> >         fn atomic_add(a: &AtomicRepr, v: i32) {
> >> > 	    ...
> >> > 	}
> >> >     }
> >> >
> >> > in generic.rs
> >> >
> >> >     pub struct Atomic<T>(AtoimcRepr<T::Repr>);
> >> >
> >> >     impl<T: AtomicAdd> Atomic<T> {
> >> >         fn add(&self, v: .., ...) {
> >> > 	    T::Repr::atomic_add(&self.0, ...);
> >> > 	}
> >> >     }
> >> >
> >> > see:
> >> >
> >> > 	https://git.kernel.org/pub/scm/linux/kernel/git/boqun/linux.git/log/?h=rust-atomic-impl
> >> 
> >> Hmm what does the additional indirection give you?
> >> 
> >
> > What additional indirection you mean? You cannot make atomic_add() safe
> > with only `UnsafeCell<T::Repr>`.
> 
> What is the advantage of making it safe? It just moves the safety

Well, first we in general are in favor of safe functions when we can
make it safe, right? Second, at Atomic<T> level, the major unsafe stuff
comes from the T <-> T::Repr transmutable and making `Atomic<T>` a valid
`T`, the safety of i{32, 64}::atomic_add() would be a bit distraction
when implementing Atomic::add(). With i{32, 64}::atomic_add() being
safe, I can implementation Atomic::add() as:

impl<T: ..> Atomic<T> {
    #[inline(always)]
    pub fn add<Rhs>(&self, v: Rhs, _: ordering::Relaxed)
    where
        T: AtomicAdd<Rhs>,
    {
        let v = T::rhs_into_delta(v);

        // INVARIANT: `self.0` is a valid `T` due to safety requirement of `AtomicAdd`.
        T::Repr::atomic_add(&self.0, v);
    }
}

then all the safety related comments will be focused on why `self.0` is
still a valid `T` after the operation (if you want to be extra detailed
about it, it's fine, and can be done easily)

> comments into `ops.rs` which makes it harder to read due to the macros.

Does it? Add `i32` and `i64` level, you only need the pointer to be a
valid `* mut i{32, 64}`. So the following is pretty clear to me.

    /// Atomic arithmetic operations
    pub trait AtomicArithmeticOps {
        /// Atomic add (wrapping).
        ///
        /// Atomically updates `*a` to `(*a).wrapping_add(v)`.
        fn add[](a: &AtomicRepr<Self>, v: Self::Delta) {
            // SAFETY: `a.as_ptr()` is valid and properly aligned.
            bindings::#call(v, a.as_ptr().cast())
        }
    }

it is at least better than:

            $(
                $(#[$($p_attr)*])*
                $pvis unsafe fn $p_field<E>(
                    self,
                    slot: *mut $p_type,
                    init: impl $crate::PinInit<$p_type, E>,
                ) -> ::core::result::Result<(), E> {
                    // SAFETY: TODO.
                    unsafe { $crate::PinInit::__pinned_init(init, slot) }
                }
            )*

;-)

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

