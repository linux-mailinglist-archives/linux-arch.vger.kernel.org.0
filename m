Return-Path: <linux-arch+bounces-12575-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 915B3AF9CB3
	for <lists+linux-arch@lfdr.de>; Sat,  5 Jul 2025 01:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 189901C24983
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 23:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8730620DD54;
	Fri,  4 Jul 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A0kyZuzN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC1222561;
	Fri,  4 Jul 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751671318; cv=none; b=JBwSLoYQ5PVfruq7eJjwO9V870PvaYpp/svSECVYwlowWmfvQhdnSspphZfNdXyq9L2YklsecmCP4EfGELzJxqi0O13B9+ZZBe3ekdT1z889hGsH088Ahgj4J2sjd6lLqkmLpXAUli4JSjEOD4gArqWGHqMzXUNUq2RWZ6auHBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751671318; c=relaxed/simple;
	bh=LaDJkgv2Wcvh/wS4mJsB98uPsSiFdEkQqcCRqOZ8fLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s9gu1cYD/Zj0kAzSynxLtHX300BFxlHVVwd5s6M8oVZUu54KB3FunFUqdqizwNSoVqBGmWAWd3EUhsZFz9fc3lzulGhcBMsJrDQ5BhZrGsvJTMb2bBMIQuuD1XCyFRpX1bEsOHoxh7xavOTsfouD6xxPqm36Em44/5uero6elgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A0kyZuzN; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7d412988b14so141090885a.3;
        Fri, 04 Jul 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751671316; x=1752276116; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a2bN6a1kbvBhBLNS4eOPn3YAj3Ybd1gOLPUSnDWEkdw=;
        b=A0kyZuzNzv3yxq357PuHwXs54xjylZYWcbCSIpUFjhDRzwDd9b1rFWUHxl9/swUPvh
         0kNKMWdUl/WpvrqEG660L7SDq8Yo/uZLRPGagcxHd2QWfMPiBS6kmf5erlOmYTDgYpt7
         qi3NptRSzjWPZc0VV3oBzq/LCA32VJMoXAVJJV2/7om4+bhurVCHFvoAcSk7d/6sEUQA
         4uSVqSf1U0TdqKfBb8B75WbVncnLrZuhbo9Mf4qNic4a/qTR/F1WJPMEClzXLfjgp/Md
         Ft5o66Pm7YEcmTv50QWDRHG1VOntaIkyEZfQ0NkDW3kK13+CAMqjj2cITtCB4WovL1x9
         rFFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751671316; x=1752276116;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a2bN6a1kbvBhBLNS4eOPn3YAj3Ybd1gOLPUSnDWEkdw=;
        b=Q22IygKzShcQIxA+917SdBJYRtMKQLDcPHswSrdaoyyIh4KJRc3oMKP5aO+vvqrm53
         uIjHaFvG/35/Wxm1RvGfjpEgsH7q1Tgks4xcKqHR/qWzzeHiDqF3lOzT7LdrW9qur1Vm
         WJh9sU3uC9uk3XgvJi1E6Gwo+I6Ab5hsrZwucwFi+0DwWE30sPqvMLrNVsIMaLm+jSqz
         XC584g86CmS/A3x0pzPjIUCofTOLcaEBGeImbD8VZDeRvW6RmO5tb3eEXnIwoo3OzZoO
         ZYMg83zXPMp/rZVFCqXELjrLqhkIclEP8Bd857l9ml5uK0j/5DSB5zWl0W7Y3a4UL+oH
         muww==
X-Forwarded-Encrypted: i=1; AJvYcCU2ey5Jzq+1VjOWvmh0KowFGe8jHtonZwITTd/Pbg0RT2mMP+9y2zm5JnVP/p0CqPBtiFk0jANTxkvA@vger.kernel.org, AJvYcCWHNbPHrJHBYMoDOhu9kcRbGE40B+9oKb/JgcAidxPdEa3/Gq2zt/uG0nGG9pWh/M8NyINrrl/o8lA0QCNWMJ0=@vger.kernel.org, AJvYcCWYEefdWoEjD5WgIXpx+CK0Qt6qLsht5ECy83QZPhFXoHeiQp2V4p4LoaqGVTGyXu3bGu8JiQ6hpEvqa7ET@vger.kernel.org
X-Gm-Message-State: AOJu0YyafTyUMZqxtinY0R5hVUzWHg+V/fy057Qd5xTkHz6ZNEhabXBx
	3dviFY72NgrVVybueiwJOjjHUA200s0ToJHjj+HfXuJrv01Yhkx3tEVv
X-Gm-Gg: ASbGnctdQhSDA0vwfF6Qqc/XYvMgus/QmtI15Fpdr9h+b1FCEAZG/DYwFKRfEYrpns8
	SslWsVM+2pDMGlA38nFX8uUqnVkYpGZ1MbGzyeAawCwdFsN19Zz5EO6b4vkK5KMQkiMMsve6muL
	MOZBTaYP3F9+rfY7d5ZGT0rpCrDTtVFu2nVk2RxXDb154cdGYayCyP4lNG9+aNZ16WXaUKIsvEu
	SUA0vfSFn+BEgCmZlLrdYAf7Id3CEdYmToVWjwgvCL3FWQjdB13rtOPjMgWa+9npMBE6m2KKUvB
	3+j+DMPDFwVRTxMfxcg8rSaibcX68JeUMMdrBihJd9oINbI6TyZyxd8exp7goK84ahfBifwYJKk
	pMHkkty7wwVpmEMMHIzdpJQelN+Oy1dZuIxTIPEmHm0km3pK/3XDn
X-Google-Smtp-Source: AGHT+IEokZeuyYjE98X/PaFV89YeUHpxLbon/hptlXPa1HppU1r/PnbDJ7Wzhdztq10Pu5JN3+KlBQ==
X-Received: by 2002:a05:620a:28c7:b0:7c7:ba67:38a with SMTP id af79cd13be357-7d5ef5d83cfmr106481085a.6.1751671315432;
        Fri, 04 Jul 2025 16:21:55 -0700 (PDT)
Received: from fauth-a2-smtp.messagingengine.com (fauth-a2-smtp.messagingengine.com. [103.168.172.201])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbe7c51fsm223594485a.64.2025.07.04.16.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 16:21:55 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8AC52F40066;
	Fri,  4 Jul 2025 19:21:54 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Fri, 04 Jul 2025 19:21:54 -0400
X-ME-Sender: <xms:EmJoaANPLOPj2iTHXxMRRvy4zOVbXLbS4ExIpeJlE_7Llqr3ARJDmQ>
    <xme:EmJoaG9ylEH7tnpqtTIpoE7Ld_JKOIQXR8_aD7OfwzaJsXeJtknojeBceZg1fACRe
    yWXm_oJ_ln3t4m5aA>
X-ME-Received: <xmr:EmJoaHTLuAK46bJDrRj2_R15r2VlEucXR1168y4g6_pX6VBgXogaWQ1tdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddvgeegiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    vdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlohhsshhinheskhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthht
    oheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhigrdguvghvpdhrtghpthhtoheplh
    hinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohhj
    vggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlvgigrdhgrgihnhhorhesgh
    hmrghilhdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:EmJoaItETJsekmZvX5wWrtUfdJhxSuZdtYgqVt_VDlyvCfdoMfIrxg>
    <xmx:EmJoaIfVdZu3vqzxjOzpQ3vdJzeNiZz96L9KJIC8anXuWSOO_U7-SA>
    <xmx:EmJoaM3QXXqlKCmxmZNqoZ8in-172mfa6PHUMRfyZpZeHzZHBdSQ5Q>
    <xmx:EmJoaM-mIxnxTyt9AW5j6XwEaGNztCSSxg4UM1n7rrExlvNQ0KHlSQ>
    <xmx:EmJoaP_MkA0k8pVqnRdzmiLBmL1zOoprrKgZyammspzkCCxp-H0PNUyp>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 4 Jul 2025 19:21:54 -0400 (EDT)
Date: Fri, 4 Jul 2025 16:21:53 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <aGhiEZ4uNzEs4nah@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-5-boqun.feng@gmail.com>
 <20250621123212.66fb016b.gary@garyguo.net>
 <aFjj8AV668pl9jLN@Mac.home>
 <20250623193019.6c425467.gary@garyguo.net>
 <aFmmYSAyvxotYfo7@tardis.local>
 <aGg4sIORQiG02IoD@Mac.home>
 <DB3KC64NSYK7.31KZXSNO1XOGM@kernel.org>
 <aGhFAlpOZJaLNekS@Mac.home>
 <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DB3MQ54N1FLA.3RTNYKTJFDNYY@kernel.org>

On Sat, Jul 05, 2025 at 12:38:05AM +0200, Benno Lossin wrote:
[..]
> >> >   (This is not a safety requirement)
> >> >
> >> >   from_repr() and into_repr(), if exist, should behave like transmute()
> >> >   on the bit pattern of the results, in other words, bit patterns of `T`
> >> >   or `T::Repr` should stay the same before and after these operations.
> >> >
> >> >   Of course if we remove them and replace with transmute(), same result.
> >> >
> >> >   This reflects the fact that customized atomic types should store
> >> >   unmodified bit patterns into atomic variables, and this make atomic
> >> >   operations don't have weird behavior [1] when combined with new(),
> >> >   from_ptr() and get_mut().
> >> 
> >> I remember that this was required to support types like `(u8, u16)`? If
> >
> > My bad, I forgot to put the link to [1]...
> >
> > [1]: https://lore.kernel.org/rust-for-linux/20250621123212.66fb016b.gary@garyguo.net/
> >
> > Basically, without requiring from_repr() and into_repr() to act as a
> > transmute(), you can have weird types in Atomic<T>.
> 
> Ah right, I forgot some context... Is this really a problem? I mean it's

It's not a problem for safety, so it's not a safety requirement. But I
really don't see a reason why we want to support this. Not supporting
this makes the atomic implementation reasoning easier.

> weird sure, but if someone needs this, then it's fine?
> 

They can always play the !value game outside atomic, i.e. !value before
store and !value after load, so I don't think it's reasonable request.

> > `(u8, u16)` (in case it's not clear to other audience, it's tuple with a
> > `u8` and a `u16` in it, so there is a 8-bit hole) is not going to
> > support until we have something like a `Atomic<MaybeUninit<i32>>`.
> 
> Ahh right we also had this issue, could you also include that in your
> writeup? :)
> 

Sure, I will put it in a limitation section maybe.

> >> yes, then it would be good to include a paragraph like the one above for
> >> enums :)
> >> 
> >> > * Provenance preservation.
> >> >
> >> >   (This is not a safety requirement for Atomic itself)
> >> >
> >> >   For a `Atomic<*mut T>`, it should preserve the provenance of the
> >> >   pointer that has been stored into it, i.e. the load result from a
> >> >   `Atomic<*mut T>` should have the same provenance.
> >> >
> >> >   Technically, without this, `Atomic<*mut T>` still work without any
> >> >   safety issue itself, but the user of it must maintain the provenance
> >> >   themselves before store or after load.
> >> >
> >> >   And it turns out it's not very hard to prove the current
> >> >   implementation achieve this:
> >> >
> >> >   - For a non-atomic operation done on the atomic variable, they are
> >> >     already using pointer operation, so the provenance has been
> >> >     preserved.
> >> >   - For an atomic operation, since they are done via inline asm code, in
> >> >     Rust's abstract machine, they can be treated as pointer read and
> >> >     write:
> >> >
> >> >     a) A load of the atomic can be treated as a pointer read and then
> >> >        exposing the provenance.
> >> >     b) A store of the atomic can be treated as a pointer write with a
> >> >        value created with the exposed provenance.
> >> >
> >> >     And our implementation, thanks to no arbitrary type coercion,
> >> >     already guarantee that for each a) there is a from_repr() after and
> >> >     for each b) there is a into_repr() before. And from_repr() acts as
> >> >     a with_exposed_provenance() and into_repr() acts as a
> >> >     expose_provenance(). Hence the provenance is preserved.
> >> 
> >> I'm not sure this point is correct, but I'm an atomics noob, so maybe
> >> Gary should take a look at this :)
> >> 
> >
> > Basically, what I'm trying to prove is that we can have a provenance-
> > preserved Atomic<*mut T> implementation based on the C atomics. Either
> > that is true, or we should write our own atomic pointer implementation.
> 
> That much I remembered :) But since you were going into the specifics
> above, I think we should try to be correct. But maybe natural language
> is the wrong medium for that, just write the rust code and we'll see...
> 

I don't thinking writing rust code can help us here other than duplicate
my reasoning above, so like:

    ipml *mut() {
        pub fn xchg(ptr: *mut *mut (), new: *mut ()) -> *mut () {
	    // SAFTEY: ..
	    // `atomic_long_xchg()` is implemented as asm(), so it can
	    // be treated as a normal pointer swap() hence preserve the
	    // provenance.
	    unsafe { atomic_long_xchg(ptr.cast::<atomic_long_t>(), new as ffi:c_long) }
	}

        pub fn cmpxchg(ptr: *mut *mut (), old: *mut (), new: *mut ()) -> *mut () {
	    // SAFTEY: ..
	    // `atomic_long_xchg()` is implemented as asm(), so it can
	    // be treated as a normal pointer compare_exchange() hence preserve the
	    // provenance.
	    unsafe { atomic_long_cmpxchg(ptr.cast::<atomic_long_t>(), old as ffi::c_long, new as ffi:c_long) }
	}

	<do it for a lot of functions>
    }

So I don't think that approach is worth doing. Again the provenance
preserving is a global property, either we have it as whole or we don't
have it, and adding precise comment of each function call won't change
the result. I don't see much difference between reasoning about a set of
functions vs. reasoning one function by one function with the same
reasoning.

If we have a reason to believe that C atomic doesn't support this we
just need to move to our own implementation. I know you (and probably
Gary) may feel the reasoning about provenance preserving a bit handwavy,
but this is probably the best we can get, and it's technically better
than using Rust native atomics, because that's just UB and no one would
help you.

(I made a copy-pasta on purpose above, just to make another point why
writing each function out is not worth)

Regards,
Boqun


> >> >   Note this is a global property and it has to proven at `Atomic<T>`
> >> >   level.
> >> 
> >> Thanks for he awesome writeup, do you want to put this in some comment
> >> or at least the commit log?
> >> 
> >
> > Yes, so the round-trip transmutability will be in the safe requirement
> > of `AllowAtomic`. And if we still keep `from_repr()` and `into_repr()`
> > (we can give them default implementation using trasnmute()), I will put
> > the "bit-equivalency of from_repr() and into_repr()" in the requirement
> > of `AllowAtomic` as well.
> >
> > For the "Provenance preservation", I will put it before `impl
> > AllowAtomic for *mut T`. (Remember we recently discover that doc comment
> > works for impl block as well? [2])
> 
> Yeah that sounds good!
> 
> ---
> Cheers,
> Benno
> 
> > [2]: https://lore.kernel.org/rust-for-linux/aD4NW2vDc9rKBDPy@tardis.local/

