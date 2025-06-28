Return-Path: <linux-arch+bounces-12495-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA84AAEC590
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 373B31BC15E9
	for <lists+linux-arch@lfdr.de>; Sat, 28 Jun 2025 07:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1B621CC58;
	Sat, 28 Jun 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OsZTBqy0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27D53FC2;
	Sat, 28 Jun 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751095889; cv=none; b=kmuAtDMy9uAzT7PP9JBtdqLFTGFSUC+jP1X4hpBUkFJN2R/77ZVapzOdJvu95stR0Uc7XgbvTZm2AcRO8iAjwSp6HFh/bemD/mrN9UZFGLoBEkIO5/bGCLVpzJXsuYZ/fGZShUt9q1FoYRF8oVXHm17pV3zJeVSx9TBlL4RidGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751095889; c=relaxed/simple;
	bh=rraH/40CeB/z1xCCPq4cy8s7e16WZaVGh9+XucJz9v4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A07YvvAOwPKyiArxWXPsDvuUvAOw7SlWcE9VqJlwsw1KwoU6unM1JrxOBX4OfcCA1FcC+7kbOUHbP3CDFMSoOn80cAMoVjxKbFmlHXMgAHV56aZTfzsSKYHh2A1xCLZm606ifAI848c/U8uyz3owUz2S6RlKlnPyLDfre9lYsvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OsZTBqy0; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d44e4d248dso31719185a.2;
        Sat, 28 Jun 2025 00:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751095887; x=1751700687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cFWPdY/EABBUV9SxUGHTvYdphHmwz91gu2pfUGDxwG4=;
        b=OsZTBqy0vOc2ghe331z7DtYgsGIkLY1K3S4jJYWRMYlTJAJZfPkoG4uJXP4iSLsc66
         fvU2kZFRnNVq6p/aM8XJR5pAerJAOJOuoonljdCaU3xygrYRCVIYwxWtjtLQE1tqrCZl
         FPFfFMiEhiuBm2TBlFox3UxMK30QOTf88Tzi0ju/rj14S6r6c9VMYL+DNXw9gVlMbbwS
         5FjVxnA7Pvk80jvmzKOMIB6Q8BhidXEN6wX3YTwHmdhimNXeuuVbCoBz4uNAlig++QK/
         kN24JrrDFo31sJNmTEpqDkfbcCkaYDg8pdGhzEy8CdzFk4U26m1dww5oiPtjnLpZaHrx
         vEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751095887; x=1751700687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cFWPdY/EABBUV9SxUGHTvYdphHmwz91gu2pfUGDxwG4=;
        b=mxc7V61KNErzRLkQuTL+FCQd+G+WqwJJ3zry0EJgQpW5K209rA6VTR5XiB9PxEMf4z
         ZhVuNUngEJufIxetLtW49jTTSgJrIfkurcqT6o2PK5DI8g9FAtJ3GqdGdVcvup+YcSOI
         pc3vi3j8mLA9NT5XZG84EJAc++M3oog+8pvdJItEBpdNjK/8EX/+qdUjD7wAG5MBxyDG
         QPKXynERxiYIKrU1R7UupMyHPpak5q0wWppt1/lekLSsCGfhKRsSvM7jABHQCb4d89wA
         j6+lBxl7GD/tG0n8cq+d3Ex8SrCtIymgQPvLEjl5ebbjyvMVXNfBq0sXp0eSv7AyILUO
         fb8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdstlCVK5U3yndMJZl1fmukPqR1rqvhR8XV3gmnRLDbppshI9CSFTy5j1snu3swkb3xJOaEzgc50ha@vger.kernel.org, AJvYcCVNLYMaiKolwfciRHIrU0jBjvQmIw4yJ4G9kXjxt9Wnvma6mmpyr25vlNp/YpiACG75BgmieAYS8Z6VXqrhXfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPkW5qu/lYMdD+roG3vqbL44wG8DqdWOoHhHRkcOwxpjJC4pVn
	VOCYVL0no+4Yta6Ej/Aiujxgw/QanAtvkAChGWYrVGPpTneRz5e5NgfJ
X-Gm-Gg: ASbGnctiAqccLE1ZxS9uZWy7O0YwNCdMwrWgC1VdDyiQ/BDe7AT/OyuFMpz4IdfPbpO
	4x+FDLFNv1g2S4Yvtvl88Zblp6t4zn5hjQvLZfQVP97dBrNrNhQtMByawHPGbSm5LlMy3tfqaGO
	1HgYp9fXj2k8+bdzCg9k+EUCltAMkavN1B1Ae3b/rKHmL2Dqk6RhhQer0gRsmAcVpUmzhVKPMiw
	IcFmuR/u2xOvTlyAXo+9lj1cyHt2AV1vYEf6tNEavd5JYO/ZGZgkLApmS4SAE0sWoqyQRPeXsQ+
	2FZjCZn50Q6KJi2nXt23jIPq29SMsAUYnHRSLjcAsQKgsnUOjDbXSni7QMbti0aWC+8sIgLuVtp
	OMYmoPUmPwZDLufS2fSDwlRNQ12AP+Tj1yurpmXyueDY+ovr6rWLG
X-Google-Smtp-Source: AGHT+IFv7dAnqmIFnmZHsIZADAIfSUassYGScWuTs6RQJ8WbkWclkqoFG4TDTv4O7YkdraYwqMnulw==
X-Received: by 2002:a05:620a:1713:b0:7d2:284f:e471 with SMTP id af79cd13be357-7d44394fd4dmr869348285a.33.1751095886533;
        Sat, 28 Jun 2025 00:31:26 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d44317a180sm256759585a.43.2025.06.28.00.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Jun 2025 00:31:26 -0700 (PDT)
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 4D00EF40068;
	Sat, 28 Jun 2025 03:31:25 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Sat, 28 Jun 2025 03:31:25 -0400
X-ME-Sender: <xms:TZpfaBmoFKzeQthGt2E1DdHSlQSCIj5SW95Y7byutIhumR2ChEWEGg>
    <xme:TZpfaM0k1MCImu5SSWiF6e7hkmDR4jewLKdgaVRm2LX5KtP4ipZs6QQstiiDazhI6
    WI8R7Y1G6NskZZmug>
X-ME-Received: <xmr:TZpfaHoxwF21bMksQ5APEgNwaRBOrsQw4BIm8-D7pPIsrPNOXWyhAAukag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeelgfeufeekieelkedvfeevheehtdeuudelgfelhfeljeelheefieffgfevfeduhfen
    ucffohhmrghinheprhgvrgguhidrshhtohhrvgenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdgu
    vghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghl
    vgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesghgrrh
    ihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:TZpfaBkZpEQ2tPcYV1_YsgDOKwuFrzgJERYfc1mbX2Yx-l2TfFOeIw>
    <xmx:TZpfaP3purVZiWZvmTBINgS56FY9PkzbbDhL54Ow87gZhMvHKGovhA>
    <xmx:TZpfaAuL8eqoTuTkcKdR7DfsBpB4SO7guKAsYY-LYO3Sng9yYkzN7g>
    <xmx:TZpfaDWnhTY-QeWXmsoz5SiQsBTPjP5C4vCDQ4yQtgupE96mSSQx3w>
    <xmx:TZpfaG2crm5ZAl_A3v2oN43gJxnrGuE_RKLzwSyIp-H5xpZbrTI1RFLB>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Jun 2025 03:31:24 -0400 (EDT)
Date: Sat, 28 Jun 2025 00:31:23 -0700
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
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <aF-aS5FLX7QIiiPa@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-6-boqun.feng@gmail.com>
 <DAX6WZ87S99G.1CMIN6IQXJYPL@kernel.org>
 <aF6iXB6wiHcpAKIU@Mac.home>
 <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DAXY0EJHHDWM.1KRSSJLOTCZ8F@kernel.org>

On Sat, Jun 28, 2025 at 08:12:42AM +0200, Benno Lossin wrote:
> On Fri Jun 27, 2025 at 3:53 PM CEST, Boqun Feng wrote:
> > On Fri, Jun 27, 2025 at 10:58:43AM +0200, Benno Lossin wrote:
> >> On Wed Jun 18, 2025 at 6:49 PM CEST, Boqun Feng wrote:
> >> > +impl<T: AllowAtomic> Atomic<T>
> >> > +where
> >> > +    T::Repr: AtomicHasXchgOps,
> >> > +{
> >> > +    /// Atomic exchange.
> >> > +    ///
> >> > +    /// # Examples
> >> > +    ///
> >> > +    /// ```rust
> >> > +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> >> > +    ///
> >> > +    /// let x = Atomic::new(42);
> >> > +    ///
> >> > +    /// assert_eq!(42, x.xchg(52, Acquire));
> >> > +    /// assert_eq!(52, x.load(Relaxed));
> >> > +    /// ```
> >> > +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> >> > +    #[inline(always)]
> >> > +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
> >> 
> >> Can we name this `exchange`?
> >> 
> >
> > FYI, in Rust std, this operation is called `swap()`, what's the reason
> > of using a name that is neither the Rust convention nor Linux kernel
> > convention?
> 
> Ah, well then my suggestion would be `swap()` instead :)
> 

;-)

> > As for naming, the reason I choose xchg() and cmpxchg() is because they
> > are the name LKMM uses for a long time, to use another name, we have to
> > have a very good reason to do so and I don't see a good reason
> > that the other names are better, especially, in our memory model, we use
> > xchg() and cmpxchg() a lot, and they are different than Rust version
> > where you can specify orderings separately. Naming LKMM xchg()/cmpxchg()
> > would cause more confusion I believe.
> 
> I'm just not used to the name shortening from the kernel... I think it's

I guess it's a bit curse of knowledge from my side...

> fine to use them especially since the ordering parameters differ from
> std's atomics.
> 
> Can you add aliases for the Rust names?
> 

I can, but I also want to see a real user request ;-) As a bi-model user
myself, I generally don't mind the name, as you can see C++ and Rust use
different names as well, what I usually do is just "tell me what's the
name of the function if I need to do this" ;-)

> > Same answer for compare_exchange() vs cmpxchg().
> >
> >> > +        let v = T::into_repr(v);
> >> > +        let a = self.as_ptr().cast::<T::Repr>();
> >> > +
> >> > +        // SAFETY:
> >> > +        // - For calling the atomic_xchg*() function:
> >> > +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> >> > +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> >> > +        //   - per the type invariants, the following atomic operation won't cause data races.
> >> > +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> >> > +        //   - atomic operations are used here.
> >> > +        let ret = unsafe {
> >> > +            match Ordering::TYPE {
> >> > +                OrderingType::Full => T::Repr::atomic_xchg(a, v),
> >> > +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
> >> > +                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
> >> > +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
> >> > +            }
> >> > +        };
> >> > +
> >> > +        T::from_repr(ret)
> >> > +    }
> >> > +
> >> > +    /// Atomic compare and exchange.
> >> > +    ///
> >> > +    /// Compare: The comparison is done via the byte level comparison between the atomic variables
> >> > +    /// with the `old` value.
> >> > +    ///
> >> > +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
> >> > +    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
> >> > +    /// failed cmpxchg should be treated as a relaxed read.
> >> 
> >> This is a bit confusing to me. The operation has a store and a load
> >> operation and both can have different orderings (at least in Rust
> >> userland) depending on the success/failure of the operation. In
> >> userland, I can supply `AcqRel` and `Acquire` to ensure that I always
> >> have Acquire semantics on any read and `Release` semantics on any write
> >> (which I would think is a common case). How do I do this using your API?
> >> 
> >
> > Usually in kernel that means in a failure case you need to use a barrier
> > afterwards, for example:
> >
> > 	if (old != cmpxchg(v, old, new)) {
> > 		smp_mb();
> > 		// ^ following memory operations are ordered against.
> > 	}
> 
> Do we already have abstractions for those?
> 

You mean the smp_mb()? Yes it's in patch #10.

> >> Don't I need `Acquire` semantics on the read in order for
> >> `compare_exchange` to give me the correct behavior in this example:
> >> 
> >>     pub struct Foo {
> >>         data: Atomic<u64>,
> >>         new: Atomic<bool>,
> >>         ready: Atomic<bool>,
> >>     }
> >> 
> >>     impl Foo {
> >>         pub fn new() -> Self {
> >>             Self {
> >>                 data: Atomic::new(0),
> >>                 new: Atomic::new(false),
> >>                 ready: Atomic::new(false),
> >>             }
> >>         }
> >> 
> >>         pub fn get(&self) -> Option<u64> {
> >>             if self.new.compare_exchange(true, false, Release).is_ok() {
> >
> > You should use `Full` if you want AcqRel-like behavior when succeed.
> 
> I think it would be pretty valuable to document this. Also any other
> "direct" translations from the Rust memory model are useful. For example

I don't disagree. But I'm afraid it'll still a learning process for
everyone. Usually as a kernel developer, when working on concurrent
code, the thought process is not 1) "write it in Rust/C++ memory model"
and then 2) "translate to LKMM atomics", it's usually just write
directly because already learned patterns from kernel code.

So while I'm confident that I can answer any translation question you
come up with, but I don't have a full list yet.

Also I don't know whether it's worth doing, because of the thought
process thing I mentioned above.

My sincere suggestion to anyone who wants to do concurrent programming
in kernel is just "learn the LKMM" (or "use a lock" ;-)). There are good
learning materials in LWN, also you can check out the
tools/memory-model/ for the model, documentation and tools.

Either you are familiar with a few concepts in memory model areas, or
you have learned the LKMM, otherwise I'm afraid there's no short-cut for
one to pick up LKMM atomics correctly and precisely with a few
translation rules from Rust native atomics.

The other thing to note is that there could be multiple "translations",
for example for this particular case, we can also do:

    pub fn get(&self) -> Option<u64> {
	if self.new.cmpxchg(true, false, Release).is_ok() {
	    smp_mb(); // Ordering the load part of cmpxchg() with the
	              // following memory accesses, i.e. providing at
		      // least the Acquire ordering.
	    let val = self.data.load(Acquire);
	    self.ready.store(false, Release);
	} else {
	    None
	}
    }

So whatever the document is, it might not be accurate/complete, and
might be misleading.

> is `SeqCst` "equivalent" to `Full`?

No ;-) How many hours do you have? (It's a figurative question, I
probably need to go to sleep now ;-)) For example, `SeqCst` on atomic
read-modify-write operations maps to acquire+release atomics on ARM64 I
believe, but a `Full` atomic is acquire+release plus a full memory
barrier on ARM64. Also a `Full` atomic implies a full memory barrier
(smp_mb()), but a `SeqCst` atomic is not a `SeqCst` fence.

Regards,
Boqun

> 
> ---
> Cheers,
> Benno

