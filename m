Return-Path: <linux-arch+bounces-12782-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D35A9B062C1
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 17:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295A87A6FB6
	for <lists+linux-arch@lfdr.de>; Tue, 15 Jul 2025 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40E91F0E56;
	Tue, 15 Jul 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+LAaCuA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F2281EDA09;
	Tue, 15 Jul 2025 15:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752592915; cv=none; b=TPycY638JbGhxceN/ZzPkfTgV8cp5SImgG6jWWK7B4HUL5otewK1UscJw9L2TOWczJbiD9azlQMPi2FeYxLfSupOYlQVOLEBpHthL68c8mO74ebogSSDa8JUB/TGfsVbg3KMcSpAttT1klE/WLgNUWEdm8AbTvEs+/fy4hqZSGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752592915; c=relaxed/simple;
	bh=rbTynBqAgprPlWokZyEUcbbAd8VSay24Ofs37u8CqX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JCO6MCLTnvUkjzDbFGEZtNTAOb7OdlaTWlbKlZ6bk52xf99i1Mn+6HEkhmQUVfqiABp/19lPnPVNS/eFpZgyovBAztXDG/gYbD7dL2a7S/SZEkzFuU9IpecVob9yFRZBF7/MI05Xbuoq85piAWTEBYjCJliZJ24xB6r/E/gD9Z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+LAaCuA; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6facacf521eso47728146d6.3;
        Tue, 15 Jul 2025 08:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752592913; x=1753197713; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/Yn2gqHzUtsfyMlZhxb0ewiuI2/ZmKp/5MquQRDmaw=;
        b=C+LAaCuAIee+m+Qv6sio1Sc5a+5rcveB+0YcYSWApqmkf1UpsnRAsXPpIlGYCLccy2
         u9G8MHEX8MzXpBGo15vVlKXJiZBvLeS4J3G/geQMI0hWlEY1dcRUJtBCO/h1zshUsLOd
         dhSEyqzkD7kVqGYnOgI9A886X4UDPFr9evtFBA4Y8EYkCoJVNUvK7kZV8Bc9BNwMTWYw
         S4JiXpK0jxGE6UBXoVHdELXK6W0dEoNnvQQWRvzUs+bkcXoGQ6G+UOSAkLPZ7PuowwhY
         keU4Nnk0uNiDICJFxe6nGLn2AtoYJxbGhk2A7aeKBoE59tL6dPJ8lzMIddTBYJ0+TC65
         9Tow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752592913; x=1753197713;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/Yn2gqHzUtsfyMlZhxb0ewiuI2/ZmKp/5MquQRDmaw=;
        b=BC60pXkZNnM1yuwh5p1j+zmOGW5v7w+Qo7nRcxvxOJfd0WgnkhWs125fKtP2cvZR++
         sIrYS27LPrGIisAjEyzc7/0J8MUcg1LHZn8Njl4xkMwi5VGWe9U99NseVnEmCxm8eujA
         bwxUocfeFp6p3qU4dFWvKjKvUGOMoq4Ifdoeqzv+qvFa3MtmDpxT6/RaiTN3H2N8BuXS
         fInS0Rwo2pslbj7DWB6x3sa+2l89eR2VrgtG3gbSlksdBcKkL/HPKsaRGtLY1ITJMXoT
         zcyqzHi8nb4KTQeU4rXwkE41i4jh0/6K0iRwI4sviS2zn7Z0Uyg2Mzi/e9cv6FVnQ0lo
         tvFg==
X-Forwarded-Encrypted: i=1; AJvYcCUG7BYnXBwuuxas389bqJ6ThI2qj0vVvuYu14pasndVHp+i0KW93Fv4Eo5NQs92L0LDush3ZN9jB1fqrVriKuc=@vger.kernel.org, AJvYcCUIdGGeRPC4KAa6vQw1/4+QpRfq6oVlTor2l2C31h5iVZjSxe2/U4wJuzvn84xmX5rP1jrqsXku36Hg1P86@vger.kernel.org, AJvYcCUehcclzg4/QrmwUgwrlnSELjeqnT648pyNBJZyIDdPe4k2HVd27Shb9t8/bWk+kudMPUpKH6MFXWZK@vger.kernel.org
X-Gm-Message-State: AOJu0YxapmSV9iaazohZvLYV4nQ2lSSxSlmY9Y+5sSidit1Xst+tRCFK
	ef5nO9bIQkBOmHKr9JO8HBZo4fRb8Qj+Sxd6E19OoVVCoOaeFzAoYRDS
X-Gm-Gg: ASbGncuPH4GPGVddfWWsfSufKcZMHAw9mxsTlm/kdcRrFOmQktTn8dfvipI+cXuyw96
	yGUudA13La4poHY/VOv7lf8Bq04XJEYbhq96ZVYcYPHwpP0+swVSiwZcTPrvWitrLICfK4Dt8N/
	C9XOiNOVmjtYMl6vomhu69vjWkwHv4uOUw2Hu4r4cS5EXMv/xrcszJbOssbpIJgKMlH1nJySQAA
	Rr3YlPXqkCfQD09+r/CxkVkFNd9hziNhAlzj6vcEm58Xu27+nCbGywxYvr1g22v3HM5JXBtgw+d
	xfVic1LsGxPa7R7E3Xg/ImIdo7X/kG7319I4whJnypC4HiJfjwXabcFMzggNXK4yhkeWmB5nq4G
	eRKt8mgv57YEaqM8i1m8RWxbnBPJSdy4JPzB7r8EFF/RegNXsOA2ZTcOBfCfW5YzI0f3eSC2JmW
	iiVjB2+8dzpSEF
X-Google-Smtp-Source: AGHT+IFLFdVTqE/NG8x/+LjxKn51vceStUG2Y01OYG37h3HWQC0M/DnVWP36mL1roxGnO26beZazYw==
X-Received: by 2002:a05:6214:da8:b0:702:d836:6591 with SMTP id 6a1803df08f44-704a39bd1b2mr276753016d6.32.1752592911178;
        Tue, 15 Jul 2025 08:21:51 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-704979b7de3sm58850446d6.34.2025.07.15.08.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jul 2025 08:21:50 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id D8C6DF40069;
	Tue, 15 Jul 2025 11:21:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Tue, 15 Jul 2025 11:21:49 -0400
X-ME-Sender: <xms:DXJ2aEXEiwqZEYQB9NJlDumsQVNrDS2MpF3yiAnVXEpbEWQHtcH4MA>
    <xme:DXJ2aJ1wItNkIyxCmPEbLFX6HcyEYanghc_GydSimcK7CJVNr3n5p-ZsVJ3f1Kymf
    AdRCScJWC4KmjQ2zQ>
X-ME-Received: <xmr:DXJ2aBRUtgow_4OXvNnx6bvwMllDlb2018_CMMkIkQHLWnPa1406NbhKmg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehhedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhepteefheeffeeuiedtgeffkeefffejkefhvdffhedvheekhfejkefglefggfekteff
    necuffhomhgrihhnpehgohgusgholhhtrdhorhhgpdhgihhthhhusgdrtghomhenucevlh
    hushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhm
    vghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekhe
    ehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghm
    vgdpnhgspghrtghpthhtohepvdekpdhmohguvgepshhmthhpohhuthdprhgtphhtthhope
    hpohhsthesrhgrlhhfjhdruggvpdhrtghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehruhhsthdqfhhorhdqlhhinhhugiesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehlkhhmmheslhhishhtshdrlhhinhhugidruggvvh
    dprhgtphhtthhopehlihhnuhigqdgrrhgthhesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgi
    drghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihg
    uhhordhnvght
X-ME-Proxy: <xmx:DXJ2aKWuVh4J-DE1Wg_aAaMmYSUecbVk4AxCXSAenfaQr5-Xa-RU1w>
    <xmx:DXJ2aAMeOF4oRcQfWs1GYoaCS6TYg9OP5OdKfsjgFK8NgmaDmL4hwQ>
    <xmx:DXJ2aB3hBPrtQFRLFd1yQDc43Zb4cEjkE-ojFgH6jC2GZx7osRDlKg>
    <xmx:DXJ2aIPHF_EkxMyrXPwCUAZidhZxG3xRwTG5jtmVQz49KdGdrdIJzg>
    <xmx:DXJ2aPsC-oVDAoYRT4JY5tgSiOKaLUm0LYMy0H0A-RRao-JkR8Cr8zHc>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Jul 2025 11:21:49 -0400 (EDT)
Date: Tue, 15 Jul 2025 08:21:47 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Ralf Jung <post@ralfj.de>
Cc: Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,	Lyude Paul <lyude@redhat.com>,
 Ingo Molnar <mingo@kernel.org>,	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 8/9] rust: sync: Add memory barriers
Message-ID: <aHZyC4xr7jgN6Mgv@Mac.home>
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-9-boqun.feng@gmail.com>
 <DB93NWEAK46D.2YW5P9MSAWVCN@kernel.org>
 <aHFWCsOfcGLSUPAP@tardis-2.local>
 <4d373b56-0f36-4f8a-9052-cee38b90f59b@ralfj.de>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d373b56-0f36-4f8a-9052-cee38b90f59b@ralfj.de>

On Mon, Jul 14, 2025 at 05:42:39PM +0200, Ralf Jung wrote:
> Hi all,
> 
> On 11.07.25 20:20, Boqun Feng wrote:
> > On Fri, Jul 11, 2025 at 10:57:48AM +0200, Benno Lossin wrote:
> > > On Thu Jul 10, 2025 at 8:00 AM CEST, Boqun Feng wrote:
> > > > diff --git a/rust/kernel/sync/barrier.rs b/rust/kernel/sync/barrier.rs
> > > > new file mode 100644
> > > > index 000000000000..df4015221503
> > > > --- /dev/null
> > > > +++ b/rust/kernel/sync/barrier.rs
> > > > @@ -0,0 +1,65 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +
> > > > +//! Memory barriers.
> > > > +//!
> > > > +//! These primitives have the same semantics as their C counterparts: and the precise definitions
> > > > +//! of semantics can be found at [`LKMM`].
> > > > +//!
> > > > +//! [`LKMM`]: srctree/tools/memory-model/
> > > > +
> > > > +/// A compiler barrier.
> > > > +///
> > > > +/// A barrier that prevents compiler from reordering memory accesses across the barrier.
> > > > +pub(crate) fn barrier() {
> > > > +    // By default, Rust inline asms are treated as being able to access any memory or flags, hence
> > > > +    // it suffices as a compiler barrier.
> > > 
> > > I don't know about this, but it also isn't my area of expertise... I
> > > think I heard Ralf talk about this at Rust Week, but I don't remember...
> > > 
> > 
> > Easy, let's Cc Ralf ;-)
> > 
> > Ralf, I believe the question here is:
> > 
> > In kernel C, we define a compiler barrier (barrier()), which is
> > implemented as:
> > 
> > # define barrier() __asm__ __volatile__("": : :"memory")
> > 
> > Now we want to have a Rust version, and I think an empty `asm!()` should
> > be enough as an equivalent as a barrier() in C, because an empty
> > `asm!()` in Rust implies "memory" as the clobber:
> > 
> > 	https://godbolt.org/z/3z3fnWYjs
> > 
> > ?
> > 
> > I know you have some opinions on C++ compiler_fence() [1]. But in LKMM,
> > barrier() and other barriers work for all memory accesses not just
> > atomics, so the problem "So, if your program contains no atomic
> > accesses, but some atomic fences, those fences do nothing." doesn't
> > exist for us. And our barrier() is strictly weaker than other barriers.
> > 
> > And based on my understanding of the consensus on Rust vs LKMM, "do
> > whatever kernel C does and rely on whatever kernel C relies" is the
> > general suggestion, so I think an empty `asm!()` works here. Of course
> > if in practice, we find an issue, I'm happy to look for solutions ;-)
> > 
> > Thoughts?
> > 
> > [1]: https://github.com/rust-lang/unsafe-code-guidelines/issues/347
> 
> If I understood correctly, this is about using "compiler barriers" to order
> volatile accesses that the LKMM uses in lieu of atomic accesses?
> I can't give a principled answer here, unfortunately -- as you know, the
> mapping of LKMM through the compiler isn't really in a state where we can
> make principled formal statements. And making principled formal statements
> is my main expertise so I am a bit out of my depth here. ;)
> 

Understood ;-)

> So I agree with your 2nd paragraph: I would say just like the fact that you
> are using volatile accesses in the first place, this falls under "do
> whatever the C code does, it shouldn't be any more broken in Rust than it is
> in C".
> 
> However, saying that it in general "prevents reordering all memory accesses"
> is unlikely to be fully correct -- if the compiler can prove that the inline
> asm block could not possibly have access to a local variable (e.g. because
> it never had its address taken), its accesses can still be reordered. This
> applies both to C compilers and Rust compilers. Extra annotations such as
> `noalias` (or `restrict` in C) can also give rise to reorderings around
> arbitrary code, including such barriers. This is not a problem for
> concurrent code since it would anyway be wrong to claim that some pointer
> doesn't have aliases when it is accessed by multiple threads, but it shows

Right, it shouldn't be a problem for most of the concurrent code, and
thank you for bringing this up. I believe we can rely on the barrier
behavior if the memory accesses on both sides are done via aliased
references/pointers, which should be the same as C code relies on.

One thing though is we don't use much of `restrict` in kernel C, so I
wonder the compiler's behavior in the following code:

    let mut x = KBox::new_uninit(GFP_KERNEL)?;
    // ^ KBox is our own Box implementation based on kmalloc(), and it
    // accepts a flag in new*() functions for different allocation
    // behavior (can sleep or not, etc), of course we want it to behave
    // like an std Box in term of aliasing.

    let x = KBox::write(x, foo); // A

    smp_mb():
      // using Rust asm!() for explanation, it's really implemented in
      // C.
      asm!("mfence");

    let a: &Atomic<*mut Foo> = ...; // `a` was null initially.

    a.store(KBox::into_raw(x), Relaxed); // B

Now we obviously want A and B to be ordered, because smp_mb() is
supposed to be stronger than Release ordering. So if another thread does
an Acquire read or uses address dependency:

    let a: &Atomic<*mut Foo> = ...;
    let foo_ptr = a.load(Acquire); // or load(Relaxed);

    if !foo_ptr.is_null() {
        let y: KBox<Foo> = unsafe { KBox::from_raw(foo_ptr) };
	// ^ this should be safe.
    }

Is it something Rust AM could guarantee? I think it makes no difference
than 1) allocating some normal memory for DMA; 2) writing to the normal
memory; 3) issuing some io barrier instructions to make sure the device
will see the writes in step 2; 4) doing some MMIO to notify the
device for a DMA read. Therefore reordering of A and B by compiler will
be problematic.

Regards,
Boqun

> that the framing of barriers in terms of preventing reordering of accesses
> is too imprecise. That's why the C++ memory model uses a very different
> framing, and that's why I can't give a definite answer here. :)
> 
> Kind regards,
> Ralf
> 

