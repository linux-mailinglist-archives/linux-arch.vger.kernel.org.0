Return-Path: <linux-arch+bounces-12402-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F0AE099B
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E304A55E0
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF714278E40;
	Thu, 19 Jun 2025 15:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PLHpWuSo"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083CF221286;
	Thu, 19 Jun 2025 15:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345241; cv=none; b=pFQ63EtoVBODJeZrOcKQ0+zWaEEYMgkhxo3aI4jXo++0V9c+Bo+Mw5C6YWsJISWqfAsx+4O8lq/3f7fFkiLoUfeVu2UbNbNlVQj1tPUsffJoVCcdawd3wkAWNj5LCJMbtzi765cTU2DtCFnS4zl5x1xCbnQAcHUQjySgC34OSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345241; c=relaxed/simple;
	bh=/+Bko24eDljdOfF0LjitP6+XTrQKIvpHH4/veR/E9LA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ay4fWAQuwm6AXYn1QY94EBqai5cdSYKDm1oVdL3yHPJHgLC7gPwmmriEuQfUrjFW6eVxxrUI+MhriFP8hfhy6o8CdgSdxKKdxDm7sSggV/3j86+1ARznAJ0psniabjVM/Td/UyJzp758rZlwM5sKOC8tKsRJ+gnuIjaUPlx+Jz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PLHpWuSo; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6fad4e6d949so4379696d6.0;
        Thu, 19 Jun 2025 08:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750345239; x=1750950039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l0qgDSPa0dr3j9BFPPnb+Nb2S0wfywf654JTxBe1PSY=;
        b=PLHpWuSocXazQrQiDgEHvvYKOCpBjooLuYApZoHE/OqIVwhx3xoYjDmlZ1abHWCxYp
         C3Gb6Werr4f1TIkyPJaiEWFm7PZPDm32J+qbNNVGPNpRML4m0vET858UEA2XxlOKJfbL
         qNzDCy8RsmNRz0z0PZUNS5fwM9VUIP5aN+mduiNC+2gUpEZj+ATH29DHvZEym+poAu24
         ArZ+sP+J+r3nh4PnDC5seUhmwkcUiUcQp8VwuuokkQ2ruH4jOaIlY6qD1gB60BchX8oy
         wg20Lk4qpVAfMydyvuX+fFFsLW1DmRFEPFrrRHFyYfBG0rvHzc+0pSkQwiUmir1mPMgJ
         eQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345239; x=1750950039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l0qgDSPa0dr3j9BFPPnb+Nb2S0wfywf654JTxBe1PSY=;
        b=HynYfGeS0LFYOJ+OQR2GS5RVv+nc1O0iRilDpFBX49v5pT7jjTfA0jY99pbVJBIlq2
         32NhOa4gkoOvSf0jzPpqDqnGux7SML5VyOdhBVcqABFVmgKGKh0920oHgD6tuPeeAfqv
         UqLsZiGZ7ALN94HOlyrWvCkq4WQsGLnR7AhpQe0ktQ+zlS6CwAkLLBKZNuA53lcvDtAN
         29oy6Prekni6DAmY0YkQodcvIjC0dFabtVL+QvaiHOFExWkXJRCit+yZWqfWQ1uZTi9Z
         i1/PTEyTAdigbzki3LuKF8BZCfTeltjsVWh2ilD4+o847A2aeGc8KPB1+K5XyfwPvloc
         IZVg==
X-Forwarded-Encrypted: i=1; AJvYcCUqQQRj9nFZ/oURfAAi0Gw9ncPJfthMwHFQOntO6v1GYfxlz5eZ/JgXE43xHUB2hv4sI7qoWL4jqW+s9Rey5CI=@vger.kernel.org, AJvYcCXBjcCjaqHRMGgH4L3eBraYgMe3RjHu2egLanev47SFbp002tXwjbqJoIAc/KnJTdyF45HWZW0wT3Ey@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8DzekyTKlydycxyKgUgg8jEF1xblmg2KxMIyLrTNNtnwqHUK
	FV9bCEa47Mi6bTkrqSXv2huCDb4ypowVipBAokpZjXCcuwUZXbvg5owE
X-Gm-Gg: ASbGncuBzamgJgSMkUEwut3x51ZXG10bL6A9kJcfqU4xBoGq+efgeMlrKbIOH8E2LO1
	XtRMeDmjnET9+u48lPbKPbWQfmNyWUpsw49BWjUEDh/E3KsX6fmZfdat/iMR6uRduzDoi1hPB+B
	tPP000Ihcgdxnd4YcKUd5aiGzLCkgbAyCJZ1Z8cM1Cdf8aH0Uwsr0BmtQw/8srj9n0p6J+3mLdi
	SCSzFzpPWw+tGHgktEmNb5aNP26nsbtbsDGE2Hg++eJOJPNHo6+qf/l9AJto0YgAt5CjO+E50ee
	C1kuHLTHFYwv5MK8WOoQc1cqioVX2FUZntMHgHD68Nw5gCyU0FNRutd05Egs6P7uNk91xaeUZpK
	/S2cOibSWi+DxNqudzPDDRDOuSwUMNCadADtuvOAm+4mh0BMD3tTo
X-Google-Smtp-Source: AGHT+IHQbX5jbzzLsUYsMtO17qeEOXfNsuHfgvwOwhZW+eoUzR3yoWa7b3nOHKII1uwPGKDVSRX9/g==
X-Received: by 2002:a05:6214:2f8e:b0:6fa:ccb6:601f with SMTP id 6a1803df08f44-6fb4777040bmr302665386d6.21.1750345238193;
        Thu, 19 Jun 2025 08:00:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6fd095382d0sm608346d6.77.2025.06.19.08.00.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 08:00:34 -0700 (PDT)
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfauth.phl.internal (Postfix) with ESMTP id E85561200066;
	Thu, 19 Jun 2025 11:00:31 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 19 Jun 2025 11:00:31 -0400
X-ME-Sender: <xms:DyZUaPkuBfgiEai1Mlh9a3KdMMM3FoDUn9-9LOrwQsCuOoncUo1XpA>
    <xme:DyZUaC3S6sWrYltFzDrj5xqo_esw62eZc-4kVS4nJJQ2_CAgh5GikFoFUomVwAsNo
    gHVMRaP7d_qVavlig>
X-ME-Received: <xmr:DyZUaFpDrPzRCzHN7jGQ5llGvXFV2mcDpiKkE1Ab7znSxw642tKt7b2DWw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdehkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomhepuehoqhhunhcuhfgv
    nhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtthgvrh
    hnpeeghfelleffteekleehieegheetueejvdeiteehhfekvefgfffhleehteeitdeigfen
    ucffohhmrghinhepkhgvrhhnvghlrdhorhhgpdhrvghlvggrshgvrdhsohenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgdp
    nhgspghrtghpthhtohepvdeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpvg
    htvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghr
    nhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehruhhsthdqfhhorh
    dqlhhinhhugiesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlkhhmmhes
    lhhishhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehlihhnuhigqdgrrhgthhesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhef
    pghghhesphhrohhtohhnmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DyZUaHn1tsEtsDCVl8GdwKeYCZGxDGXLzjUn8NUXgHCuLcpd3gAJLQ>
    <xmx:DyZUaN3-QFGbYe8gNIKHS8E9cqz5hhtPbIiO-FWeGimWbIl8_OIa4A>
    <xmx:DyZUaGuuSRjuISwLRLVSsgtCiQbhue5vJpPN0vCkX55ustG7VUltLw>
    <xmx:DyZUaBX3VJEeMn0uICSaGuH4zmrKDSwbAHRPh6B3eR_AAUZpwO3X9Q>
    <xmx:DyZUaM3eNj3VYk-PAJvsXrouMiSIB4zGcdKKDLszmQRGiK7ogGcU_zhR>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Jun 2025 11:00:31 -0400 (EDT)
Date: Thu, 19 Jun 2025 08:00:30 -0700
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
Message-ID: <aFQmDoRSEmUuPIQG@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
 <aFQQuf44uovVNFCV@Mac.home>
 <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>

On Thu, Jun 19, 2025 at 04:32:14PM +0200, Peter Zijlstra wrote:
> On Thu, Jun 19, 2025 at 06:29:29AM -0700, Boqun Feng wrote:
> > On Thu, Jun 19, 2025 at 12:31:55PM +0200, Peter Zijlstra wrote:
> > > On Wed, Jun 18, 2025 at 09:49:27AM -0700, Boqun Feng wrote:
> > > 
> > > > +//! Memory orderings.
> > > > +//!
> > > > +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> > > > +//!
> > > > +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> > > 
> > > So I've no clue what the Rust memory model states, and I'm assuming
> > > it is very similar to the C11 model. I have also forgotten what LKMM
> > > states :/
> > > 
> > > Do they all agree on what RELEASE+ACQUIRE makes?
> > > 
> > 
> > I think the question is irrelevant here, because we are implementing
> > LKMM atomics in Rust using primitives from C, so no C11/Rust memory
> > model in the picture for kernel Rust.
> 
> The question is relevant in so far that the comment refers to them; and
> if their behaviour is different in any way, this is confusing.
> 

I did use the word "similar" and before that I said "The semantics of
these orderings follows the [`LKMM`] definitions and rules." The
referring was merely to avoid repeating the part like:

- [`Acquire`] orders the load part of the operation against all
  following memory operations.

- [`Release`] orders the store part of the operation against all
  preceding memory operations.
  
because of this part, both models agree. But if you think this way is
better, I could change it.

> > But I think they do. I assume you mostly ask whether RELEASE(a) +
> > ACQUIRE(b) (i.e. release and acquire on different variables) makes a TSO
> > barrier [1]? We don't make it a TSO barrier in LKMM either (only
> > unlock(a)+lock(b) is a TSO barrier) and neither does C11/Rust memory
> > model.
> > 
> > [1]: https://lore.kernel.org/lkml/20211202005053.3131071-1-paulmck@kernel.org/
> 
> Right, that!
> 
> So given we build locks from atomics, this has to come from somewhere.
> 
> The simplest lock -- TAS -- is: rmw.acquire + store.release.
> 
> So while plain store.release + load.acquire might not make TSO (although
> IIRC ARM added variants that do just that in an effort to aid x86
> emulation); store.release + rmw.acquire must, otherwise we cannot
> satisfy that unlock+lock.
> 

Make sense, so something like this in the model should work:

diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
index d7e7bf13c831..90cb6db6e335 100644
--- a/tools/memory-model/linux-kernel.cat
+++ b/tools/memory-model/linux-kernel.cat
@@ -27,7 +27,7 @@ include "lock.cat"
 (* Release Acquire *)
 let acq-po = [Acquire] ; po ; [M]
 let po-rel = [M] ; po ; [Release]
-let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
+let po-unlock-lock-po = po ; (([UL] ; (po|rf) ; [LKR]) | ([Release]; (po;rf); [Acquire & RMW])) ; po

 (* Fences *)
 let R4rmb = R \ Noreturn       (* Reads for which rmb works *)


although I'm not sure whether there will be actual users that use this
ordering.

Regards,
Boqun

