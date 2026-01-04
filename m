Return-Path: <linux-arch+bounces-15650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E660CF0C21
	for <lists+linux-arch@lfdr.de>; Sun, 04 Jan 2026 09:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9724E300ACFE
	for <lists+linux-arch@lfdr.de>; Sun,  4 Jan 2026 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FD234964;
	Sun,  4 Jan 2026 08:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5Vv3wdH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D406221721
	for <linux-arch@vger.kernel.org>; Sun,  4 Jan 2026 08:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767515820; cv=none; b=fZg33Dufy1qDlhDmwQLZiS26Ev/ogL8mvM1LHanA1u8CC3y00tsawMAkV2nliaFh5nNR0x9RYHKQs/uIm4g/9D7r9hyr3tZp8dnjPLQrfOcKTr2ltfZBEGfAz4utkT5/gKSUxTwW/pDJXqNPb0euJzyrHZPlBFyl8Qg3wVMtPLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767515820; c=relaxed/simple;
	bh=61t4IgEPCUvsgF7eRrP54u+CuLdFavfMVw2A6bqiYWE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/5M3H0E09Fk6Q8Q7z/sUypFIALoosFrN2lioMOA/Fzb2MNKgdLFm2o499u1eO6sS0aeOxV0Hd3D0uEXVrRFk4qxrtK+O7ZnVXRDOeEB8fJV/MEI7UY7Hk4xEp6ucWp6PQUtTDL82I8O99oXlVFfKuyL7h0fooN+Jzp75RRXwpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5Vv3wdH; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8bc53dae8c2so2027601185a.2
        for <linux-arch@vger.kernel.org>; Sun, 04 Jan 2026 00:36:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767515818; x=1768120618; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIx/9Xfz3imVI1It6iljITXfA4Emto3M5fiv93Vq6us=;
        b=F5Vv3wdHmwTyOBO2B9MLgH54uzb3t5q0vTF85mDLZNMRNtG7M6WobU6UK0KLqmM/2D
         1BRivEUzDCj+GoijNvA3VWgwTZYWvjNPMVSRQRVu8ZAM7fvQ0nisTHQkdd/WBGgp37WE
         7R2YB1Rgs7QGgrxMaByh464Y2SCriYeaxSrRQp30XUNrwu4e8g0+g9kwwU4fBp9lxjNS
         lxfYscmBPQFgCedXW9nvLd+cO0HxvTIq4zJzRtTjcorxEqIlXaPXo5FTxeh5Qe8TS++p
         YNDX6BiSK0ZKE2VcSNj+yZfkXGrLweX6dpo7DwhmkG/TjN+HE+bf6c0NVny4YRobeWvs
         F3Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767515818; x=1768120618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lIx/9Xfz3imVI1It6iljITXfA4Emto3M5fiv93Vq6us=;
        b=HMjIqoBOGSD+boeTux5/S7aLUYmz87eMuc352ZdXdIYdGUNkoApLfk7N1Bg1QCI4bC
         9tmQUpjWLGjZmpDlTd6N/cxQx3orxE43IGfBhcBalKciEEYwh1cRjvXJHcarb3/r/lyf
         snXEa8cm/4l+VdgmlkPpZSiWtGTNxek/bfg7EfCx710PLyk2AtqEXC9WaIs+uSlV4u1D
         Z3RESUVd92AYmR6do9sBrQ8SdoXUXfeJFcgR3tURGN6O5jsw7W1+cJzhgviXhknDP8Sm
         DQ6WunpzHYvWN7N+0ruirBby47sStvvAfVXz23lnIAIt8EfJlrU7+OzNptEg06oWnpni
         j1sA==
X-Forwarded-Encrypted: i=1; AJvYcCXHu30qzPeNg9nAgmDmNhqQ7V2h4YTvRey7BzA9ZRsSBEaHsVhcy1RKRIubZ4X9HdrVNUtE3HysSjOl@vger.kernel.org
X-Gm-Message-State: AOJu0YzTErUuOqQfRki0fJuTultnF3WGr/R7/fT+/T9fPhBekMG0ECPh
	667I83iQW7wen78CsobjchpqDKyg8ct3AsWG7rnDCck9eyeE8Tb3raFN
X-Gm-Gg: AY/fxX58XsnsGvzNbpK3/xLvs3GgZbQ3/vpj7hnYrwaLpgl2TXVDhfU8ZJvwgUn1ULR
	h30CbsXmKArRkQXgrCX8LO6Xj4lEzNMaDsZ5FGLrYC6730GR6SfhvR7sdx+bsyquJ63sa9HCKAw
	Oyxeg9vyWAyJLkEf0Q400Pu1a6oFxnLsdVe+CLNH7OVOTFt/j/tPSXNYBt+wx6xhMcR6Jtud7lf
	4gDxLd2behaDMoVYfHxOHSFgaH4H+ZfbtpVH31abd9pKViEZNnrK0R1RqSMPZTpnfnaP00Wt2Il
	CdVI8ScZMLeo/jpTAoPXswvdfld4BFEgWzvU8ZekBcFdvoTsAeLsTXaSY2j8F6eXMuUkOwqYam5
	gk/S0CSg1YQIEIXyJ6uqpl+saaD0dsxoxbLarnqjzURWvx25hCjaXK0qNDohYug3CPB00skC6w3
	gDF0+Rj/Z5tFLg547snkbwl4k64osVY1vQpWwAcnlHCOYnEJ8F1OpklHS/MRDZQkgjBTX3em0TQ
	HK7E1nlePxVsmg=
X-Google-Smtp-Source: AGHT+IGxI7VAIIXWwXK0E7LLLUeHnPckTp5tfwxQkHv/pu4eOzleduA9RWCvaIOTJ2zUoT0n5/6i5Q==
X-Received: by 2002:a05:620a:4016:b0:8b2:e922:529a with SMTP id af79cd13be357-8c08fab558emr7237586785a.19.1767515818045;
        Sun, 04 Jan 2026 00:36:58 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c096a8c2ecsm3470355585a.23.2026.01.04.00.36.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 00:36:57 -0800 (PST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id BE70CF40068;
	Sun,  4 Jan 2026 03:36:56 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Sun, 04 Jan 2026 03:36:56 -0500
X-ME-Sender: <xms:qCZaaf9nkp5yibEiAtHjbODiphQx0XcVDIUvIUXVS5DPbGZb88SLbg>
    <xme:qCZaaSMBR3Sb3ann9O0UJ7bTPnmle7Nec_SqbJOGGYSrfHpEcNFXlqzeEdON_6ZzE
    thk0WR5Lt-j6JBHsCg5eMMkRVcW7VNpEmJmvnxVst4ElS7ggkMKtw>
X-ME-Received: <xmr:qCZaabD4bkxFQGr7YqbOqsG2BUDzHBGpwdE3NS238XSYTRm2bpWXUqpb_suQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdelfeeliecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvg
    hrnhephfetvdfgtdeukedvkeeiteeiteejieehvdetheduudejvdektdekfeegvddvhedt
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvg
    hngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohep
    udefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehfuhhjihhtrgdrthhomhhonh
    horhhisehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhn
    vghtpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprg
    drhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhhitggvrhih
    hhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhoth
    honhhmrghilhdrtghomhdprhgtphhtthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtoheplhhoshhsihhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhgrh
    hoshhssehumhhitghhrdgvughu
X-ME-Proxy: <xmx:qCZaaeNOmC5vl_Naf9DZe7mlTjEOsOR7Z6T_atjm5ZkyMzH2plJ77Q>
    <xmx:qCZaaadr67ozoc12xaN-vtp4ka4yvxoX0bhurW3NyqG8Niu1SVDOEQ>
    <xmx:qCZaaX7TrsZlavhCg85c_9rBZFnIMcilNWW3XbUAKTslzAG_kSfMAQ>
    <xmx:qCZaaUKOEq6JWK7vMG2GZZK2rLoZ8QZJ4OKMPPFDbBV_-8BviNjOHQ>
    <xmx:qCZaaZUlDltzWfuD8vv9Z9deqebzadW6GUx53z5poiCMIFXXVXyFepuY>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 4 Jan 2026 03:36:55 -0500 (EST)
Date: Sun, 4 Jan 2026 16:36:53 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: gary@garyguo.net, ojeda@kernel.org, a.hindborg@kernel.org,
	aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
	lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
	rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1] rust: sync: atomic: Add i32-backed Flag for atomic
 booleans
Message-ID: <aVompXdKrDB4sShK@tardis-2.local>
References: <20260101210430.6b210dc6.gary@garyguo.net>
 <20260103.194448.560764475765900721.fujita.tomonori@gmail.com>
 <20260103190511.2d267164.gary@garyguo.net>
 <20260104.065311.609258219418619592.fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260104.065311.609258219418619592.fujita.tomonori@gmail.com>

On Sun, Jan 04, 2026 at 06:53:11AM +0900, FUJITA Tomonori wrote:
[...]
> >> >   
> >> >> Add a new Flag enum (Clear/Set) with #[repr(i32)] and implement
> >> >> AtomicType for it, so users can use Atomic<Flag> for boolean flags.
> >> >> 
> >> >> Document when Atomic<Flag> is generally preferable to Atomic<bool>: in
> >> >> particular, when RMW operations such as xchg()/cmpxchg() may be used
> >> >> and minimizing memory usage is not the top priority. On some
> >> >> architectures without byte-sized RMW instructions, Atomic<bool> can be
> >> >> slower for RMW operations.
> >> >> 
> >> >> Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
> >> >> ---
> >> >>  rust/kernel/sync/atomic.rs | 35 +++++++++++++++++++++++++++++++++++
> >> >>  1 file changed, 35 insertions(+)
> >> >> 
> >> >> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> >> >> index 4aebeacb961a..d98ab51ae4fc 100644
> >> >> --- a/rust/kernel/sync/atomic.rs
> >> >> +++ b/rust/kernel/sync/atomic.rs
> >> >> @@ -560,3 +560,38 @@ pub fn fetch_add<Rhs, Ordering: ordering::Ordering>(&self, v: Rhs, _: Ordering)
> >> >>          unsafe { from_repr(ret) }
> >> >>      }
> >> >>  }
> >> >> +
> >> >> +/// An atomic flag type backed by `i32`.  
> >> > 
> >> > I would recommend that we document that the backing type is the
> >> > (perf-)optimal type on the target architecure, so arch can decide to use
> >> > i8 as backing type if they prefer.  
> >> 
> >> I'm not sure I fully understand the intent yet.
> >> 
> >> Do you mean we should document Flag as being backed by the
> >> (perf-)optimal integer type for the target architecture, so that the
> >> backing type can remain an implementation detail and potentially be
> >> selected per-arch (e.g. i8 on x86) via cfg?
> > 
> > Yes, I don't want anyone to rely on it being i32 (at least for now, before
> > a concrete use case of doing so appears).
> 
> I see, the following comment works for you?
> 
> I thought Boqun had Revocable in mind as the intended use case.
> 

Right, but To me, the most important thing is avoiding the misuse of
Atomic<bool>. A few cases when using Atomic<bool> is not recommended:

* when RmW operations can happen
* when using Atomic<bool> doesn't save memory (because of padding), e.g.
  SomeData(Atomic<bool>, i32)

hence the need of Atomic<Flag>. Therefore Atomic<Flag> needs to be:

1. performing better in contented cases than Atomic<bool>
2. maybe costing more memory than Atomic<bool> because of 1

in that sense, I think Gary's suggestion is reasonable (of course,
whether the space optimization of Atomic<Flag> has any actual value
remains to see, but it won't hurt to start with the possiblity).

FWIW, another usage is for call_once() where you want to use bool for
x86 and i32 for riscv, because using bool on riscv can actually cost
more memory.

[1}: https://lore.kernel.org/rust-for-linux/Zy_oj_k-qUPLSVEr@tardis.local/

Regards,
Boqun

> /// An atomic flag type.
> ///
> /// This type is a performance-oriented boolean for atomic operations.
> /// The integer type used as the backing representation is an implementation detail, selected to
> /// be (perf-)optimal for the target architecture.
> ///
> /// Currently, [`Flag`] uses an `i32` representation. This is because, on some architectures that
> /// do not support byte-sized atomic read-modify-write operations, RMW operations (e.g.
> /// `xchg()`/`cmpxchg()`) on `Atomic<bool>` can be slower than those on `Atomic<Flag>`.
> ///
> /// If you only use `load()`/`store()`, either `Atomic<bool>` or `Atomic<Flag>` is fine.
> 
[...]

