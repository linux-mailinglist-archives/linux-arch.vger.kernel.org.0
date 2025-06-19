Return-Path: <linux-arch+bounces-12396-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34003AE074A
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:32:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D17204A546A
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 13:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F2A26A095;
	Thu, 19 Jun 2025 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJKZWhlq"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA046264602;
	Thu, 19 Jun 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750339775; cv=none; b=MDCo1JVDBWzTL12S5GAGhGvlh0k+mF+5GboAJiT31qpJrtqw+DzF1VERUF350Mhdo8W1AQWarzon9C5QkxexIEGT8GBBdPGczLlDngMVZfb82XOot+sc8KobZD8DBFfEsA1G7SgZfa7TvFREK3zsu6OlC5rFMhKZV9/IbyyAi8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750339775; c=relaxed/simple;
	bh=k1rycoin016Y5oOCyiCPALghuj+7+2zI7ETOOd/al+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UN6CzcVFZbhwsjJNhorFFGFTQoiCAMalJ07IQ6uPNCj7NsT9jAx/tk0YUGFuVzEkwO6gPLXh9lXx+upfDhPLbBSLTTeZwTL2XtahnKxZsxA+8qdFSMGuZot88X5zjhpcAsG0eAsDq1dgPDuKNP64xLYozMdGtV0HpmhcbByidhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJKZWhlq; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7d21f21baf7so97237085a.0;
        Thu, 19 Jun 2025 06:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750339773; x=1750944573; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OE6+E3mACThLS+PEtrJkYrlgdi95WFIgFRjgenTQrJQ=;
        b=FJKZWhlqfgmbrPkfxAp4k1X1yBPhp0mkfee7jQY6FfBT+ZgUw2/25LKlIKwVG+5Rij
         /7idYX3D39MtwPhToYdn6zQWnwA++boo/sUtACd5D41zvC4calfcgmW3zfemcLxPbBuL
         gRe23Ph5+ZsFMDWdmRLktAmKdChIC8HofxkmkBqHjJ1Wj94TwD+XKybxkOHPrhPZHsp4
         /5gpR4eoGfB+0BQ74NENngrmGT8N/46yO+utmnFdAT8r6NkTS/ADXupPS2aeNF+Psz1O
         qqmZmgxd6h3YGrXzZeweHyqntjzgjoMTt6KhPhXHNVrZdccUWUOfGL6PG3yPh7bCzLLF
         Op6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750339773; x=1750944573;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OE6+E3mACThLS+PEtrJkYrlgdi95WFIgFRjgenTQrJQ=;
        b=XiDyrKOU+lKVGygPetwi2i1zaZKsd16m+ki4+C1N+y5B9wwC+9i4JFuhyMPR5AD15Z
         NSs/Zt3GyxIul6sHIl8SiGAOK6p26nDUccV4ql5yplObLyAOHT6liOLuaoWU07TqazSJ
         OhOrWg4XJpVA545+TWtQw+4y8Yma0aLPtXbWHr+CvsQF5cFeBHvgXV+YSlswlnifswTb
         uK94Hpqy1PbFMyHMoPAZKZUccDsSooMtMwMgsuwhRIcDMglIuk/aUukXkHXQBhFW5Hg7
         2trBHL8UEhNKfhsNT0LJr8xuGFiIoqqTFPGD3+sfSLK8yH9EroePuB1fpJhM8sbJ7U/3
         FkOw==
X-Forwarded-Encrypted: i=1; AJvYcCU1/1+oqBLLa7AjkQXGFaFkLPE1KaUjJWAHNunuQsRXQNXFpU+x7NyJK7bhQOnJZw8Uboom5zBWhdkw@vger.kernel.org, AJvYcCVQDFgJoRI6HdnPaznOlWUyUKcbsEOrwsKcKwP830BxbeAIvblTeRyJfduhFxYRPXdyCCprsf9psQocxTu9CX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuDLfcYgNZj9edLzdO9M+9Vygu0C2akV+aIcwBCZY7KmRvGZ8n
	JDngzdc4ghEqgnysKlSOwbUS5+JTGXEuehu8LYjLbkPEg1hpGL8Nadfg
X-Gm-Gg: ASbGncvboxXFPzGAruDvb82LVjL4yWSGKDFvqmLsefCb1WY9kfVomyFrAnQzzE7NFX7
	wX8HUEuaWGH1QBWe6YQE/+WzIGwA0DscVWu8k+9GVUu0yD5DRVx/pMsc7mxwH1b2LPlRR7eXhCe
	+e6ZhwwDuQwF7x+YNfqNGHx1L0lz1AGa56Hcha9C2VYjpTl2clxmphVSey9GHTKUxP851VIvvzS
	amKjaJK8pSaMWZQwg6qRUtM2M0XhP7hZAyx3dpw7r3RBLbj1t1/9KkZ4dyOc2JshKpgMxrbeL8K
	2kevAfK7u8DcecxJONWXslZ0rhFMfArK1y5xwVl8drPxdKRKFuuza6NBvXGSuJvmFqYYTqSVKjm
	xWoKfw++dhL2JPbRxakoe8QgJg7Kk94y4tfvm/bIsr8RN3pSoaKCm
X-Google-Smtp-Source: AGHT+IG0jYJUV5aviMjD5HPm1vyOkmeugKyt/Y/JLGwulOYBKRujCGnV7nb/0X/gOg3ydiOk3qM+4w==
X-Received: by 2002:a05:620a:25d4:b0:7c5:49b7:237c with SMTP id af79cd13be357-7d3c6cdc704mr3070557685a.27.1750339772721;
        Thu, 19 Jun 2025 06:29:32 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3b8eaca67sm878292685a.59.2025.06.19.06.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 06:29:32 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 8C48E1200043;
	Thu, 19 Jun 2025 09:29:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Thu, 19 Jun 2025 09:29:31 -0400
X-ME-Sender: <xms:uxBUaEqPUZEiRlASJATU1Thqs6yZzEn6bBgVZVqb8R7RM8Va89_nbg>
    <xme:uxBUaKqapLLmIlE2DtBf1RV3k19__mwd5LakfACLIaHc3sho5E-3eDQhjKqIibwoH
    w3tj7xk4SpQydfqtA>
X-ME-Received: <xmr:uxBUaJPuIusecdbUoejcPLwLV3Z46HjV2tfDgmJdBl2-kKEV7NqS3HnjkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpefhtedvgfdtueekvdekieetieetjeeihedvteehuddujedvkedtkeefgedvvdehtden
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhs
    ohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnh
    hgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopedv
    iedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphgvthgvrhiisehinhhfrhgrug
    gvrggurdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtoheprhhushhtqdhfohhrqdhlihhnuhigsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhkmhhmsehlihhsthhsrdhlihhnuhig
    rdguvghvpdhrtghpthhtoheplhhinhhugidqrghrtghhsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepohhjvggurgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghlvgigrdhgrgihnhhorhesghhmrghilhdrtghomhdprhgtphhtthhopehgrghrhiesgh
    grrhihghhuohdrnhgvthdprhgtphhtthhopegsjhhorhhnfegpghhhsehprhhothhonhhm
    rghilhdrtghomh
X-ME-Proxy: <xmx:uxBUaL4Sny6CKfAJbw3TXbpu_xWIczu0NcHpy51Pk3tLtVfw0N4gmQ>
    <xmx:uxBUaD5z_QuETSR3iz-WSduY2Km4GIBr8L7BeOXkyhPGTWrBK2zC1g>
    <xmx:uxBUaLhhglI3TRF6mDD2QS_Xt9n7uSTxJ4QWl6cqXGw2z_jZfPsSkg>
    <xmx:uxBUaN58jF1LvA8Y1S-5vlU9PAus-2S7YH2ForbAzjZ4hx5GdawtuQ>
    <xmx:uxBUaGJrWbYNrwuBbR4-Wo_Um4vBAqtx5rtzP1ZeXRjmQ4Sw0O5kA95q>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 09:29:31 -0400 (EDT)
Date: Thu, 19 Jun 2025 06:29:29 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	lkmm@lists.linux.dev, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lyude Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <aFQQuf44uovVNFCV@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619103155.GD1613376@noisy.programming.kicks-ass.net>

On Thu, Jun 19, 2025 at 12:31:55PM +0200, Peter Zijlstra wrote:
> On Wed, Jun 18, 2025 at 09:49:27AM -0700, Boqun Feng wrote:
> 
> > +//! Memory orderings.
> > +//!
> > +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> > +//!
> > +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> 
> So I've no clue what the Rust memory model states, and I'm assuming
> it is very similar to the C11 model. I have also forgotten what LKMM
> states :/
> 
> Do they all agree on what RELEASE+ACQUIRE makes?
> 

I think the question is irrelevant here, because we are implementing
LKMM atomics in Rust using primitives from C, so no C11/Rust memory
model in the picture for kernel Rust.

But I think they do. I assume you mostly ask whether RELEASE(a) +
ACQUIRE(b) (i.e. release and acquire on different variables) makes a TSO
barrier [1]? We don't make it a TSO barrier in LKMM either (only
unlock(a)+lock(b) is a TSO barrier) and neither does C11/Rust memory
model.

[1]: https://lore.kernel.org/lkml/20211202005053.3131071-1-paulmck@kernel.org/

> > +//! - [`Full`] means "fully-ordered", that is:
> > +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> > +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> > +//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
> > +//!     accesses.
> > +//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
> 
> s/strong/strength/ ?
> 

Fixed locally.

Regards,
Boqun

> > +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
> > +//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
> > +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> > +//!
> > +//! [`LKMM`]: srctree/tools/memory-model/
> > +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt

