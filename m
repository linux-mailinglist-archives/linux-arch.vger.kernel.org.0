Return-Path: <linux-arch+bounces-12403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01438AE09ED
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 17:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD65D166094
	for <lists+linux-arch@lfdr.de>; Thu, 19 Jun 2025 15:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A01D28BA89;
	Thu, 19 Jun 2025 15:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VTBTsAYk"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99E028B7F1;
	Thu, 19 Jun 2025 15:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345859; cv=none; b=e2I4b/zMFur3TB5GUWO/aI0muY3RlBg6plzOnm9fXrPJQ9VO063KIDHUsd1Flfce4KiXKnGUb75AXgeh6mmhWBeLtaqrPSWOfpWzG21FGv20MbPnS29DqhKFNI0dE1pErp58SARcgla+1oBIToVHaUCY+l95WRZ6zIQcPzA5R3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345859; c=relaxed/simple;
	bh=/9QmKk1T2GjtEd9UC/ntK7dEPc9EzgB1lhYmLYcoBTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBLTvGW7Z4Jc8ptjTwVKlZGdfnfPIOZwzSAfmw8scOX+cjzQGNk1AfgDGmvaGZuMDrmMoS/NzX7G92Owk1DVg6fhjt/aodOJ7cYoUzn18LxcHiaDXCQCUMUAzZtYK/wyaUcGw2+Do8vvKjvNR8odYOLG0cJUbVTblziaMVGkh4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VTBTsAYk; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=THCQxo43AHc9M+QzSpcsRgbbNjRK49mREK/7V5OhuoU=; b=VTBTsAYkcyTgk2KB1P6HqL/h3W
	qj8u1unHK9iM+eBgJ40fd4qhGMaFNO7mLERYC97Rfz/PuGZsVq9Hnf0Az8DJy1myxGNKLZW6tEtvg
	IcvRrdKvuWR1MI1XEjUR/uiEjYbM2qxwfhfVdzP9H/DMsEdbl8AroVdKzfJbzqf0Vuwh1++Pj4PjW
	uE8w6vlq3SOcCPdiap3r1sxYxmN3f7byk/7kZiPnQvI0NYe0bILYK1/KWX/sr1gvhCwwV9hWauGBi
	5qvOW6j05gGxNPaL0BE71B4zk+i4JoCwQm4JXZaL5Mgmf0HykdRQoIf3h1foxdfu+GZDGdW3afT4i
	QME61ASA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uSGuh-00000004Sbd-11r6;
	Thu, 19 Jun 2025 15:10:51 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 326DA30890E; Thu, 19 Jun 2025 17:10:50 +0200 (CEST)
Date: Thu, 19 Jun 2025 17:10:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
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
Message-ID: <20250619151050.GN1613376@noisy.programming.kicks-ass.net>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
 <20250618164934.19817-4-boqun.feng@gmail.com>
 <20250619103155.GD1613376@noisy.programming.kicks-ass.net>
 <aFQQuf44uovVNFCV@Mac.home>
 <20250619143214.GJ1613376@noisy.programming.kicks-ass.net>
 <aFQmDoRSEmUuPIQG@Mac.home>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFQmDoRSEmUuPIQG@Mac.home>

On Thu, Jun 19, 2025 at 08:00:30AM -0700, Boqun Feng wrote:

> > So given we build locks from atomics, this has to come from somewhere.
> > 
> > The simplest lock -- TAS -- is: rmw.acquire + store.release.
> > 
> > So while plain store.release + load.acquire might not make TSO (although
> > IIRC ARM added variants that do just that in an effort to aid x86
> > emulation); store.release + rmw.acquire must, otherwise we cannot
> > satisfy that unlock+lock.
> 
> Make sense, so something like this in the model should work:
> 
> diff --git a/tools/memory-model/linux-kernel.cat b/tools/memory-model/linux-kernel.cat
> index d7e7bf13c831..90cb6db6e335 100644
> --- a/tools/memory-model/linux-kernel.cat
> +++ b/tools/memory-model/linux-kernel.cat
> @@ -27,7 +27,7 @@ include "lock.cat"
>  (* Release Acquire *)
>  let acq-po = [Acquire] ; po ; [M]
>  let po-rel = [M] ; po ; [Release]
> -let po-unlock-lock-po = po ; [UL] ; (po|rf) ; [LKR] ; po
> +let po-unlock-lock-po = po ; (([UL] ; (po|rf) ; [LKR]) | ([Release]; (po;rf); [Acquire & RMW])) ; po
> 
>  (* Fences *)
>  let R4rmb = R \ Noreturn       (* Reads for which rmb works *)
> 

I am forever struggling with cats, but that does look about right :-)

> although I'm not sure whether there will be actual users that use this
> ordering.

include/asm-generic/ticket_spinlock.h comes to mind, as I thing would
kernel/locking/qspinlock.*, no?



