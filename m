Return-Path: <linux-arch+bounces-12813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5598B0768F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 15:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8921C21193
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 13:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D73552F0043;
	Wed, 16 Jul 2025 13:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lP37chl0"
X-Original-To: linux-arch@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7513A28CF40;
	Wed, 16 Jul 2025 13:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671090; cv=none; b=HU/Pa55TV0VgBbWqhKvkFLli9dZf2wVGOFEDyN36Um1HQq4Vab6UhVUBArB60N9AjMpH5g7FSck6C8lNWhopnEDkBi13IG9JO9VXJbakQn8cQG7C8DHvbCNaYUqwyvZdlF7EuivHePRmLhbJD3D6DYWcNNwK+asf2fImA7qZg2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671090; c=relaxed/simple;
	bh=poaLY2dXhFx/BvymUIY0+s9bzG5PfACHjy7kR7eXzuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dttrU5wTSKf+PJmVYqNft5Iufn3tZ7MK23S+geJYTtc/duQkW++CLfH6ht3/hTlggAW1y6DqLLJMHaTq1aGSkfVWMC3pzKVY//MN70H41CS+NX2rRCmhhWuE7zauU3UjylEiRfpM63esmFUmEGwOZKwEv6T3qwxj9qt/A0rKH5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lP37chl0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Q9yc7b7ozwfwZqKrgQ/DN+L59F0orla3uKd/arpM1LU=; b=lP37chl09snQGQsqMYqpsCFZpq
	DhoAh0LTNLQxBA98tx56Zqk88OlxjpGtp20FFiD75XzgSu89My4IDi+feTxoEMoJpPmtQIer/IV9p
	c3VjADPirS33PVhOu5kozNr1s6KO2ZJJZLfcLGP9sCRHtVcV9BHJtNQ3yvzf4d1L08CFb30f0bAdj
	rhfSee0aP/bWRSnUkqpa6mb86k8Lar0fncBGyeQdMruoZQTXDIRFqne0KbIkSHs3O2S+YO9I8lOdQ
	s3YFvwaZd5Lwt89iAfnnnI0UERSO4Hr2wk+8lsue7ZuNPS6UiEF8zzNDi35HgAkbtOasRJgwxCXKq
	LJ2Y0Q/g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uc1oR-0000000A6O7-1g6z;
	Wed, 16 Jul 2025 13:04:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id EDB60300186; Wed, 16 Jul 2025 15:04:42 +0200 (CEST)
Date: Wed, 16 Jul 2025 15:04:42 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
Message-ID: <20250716130442.GA3429938@noisy.programming.kicks-ass.net>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh>
 <20250716124713.GW905792@noisy.programming.kicks-ass.net>
 <2025071651-daylong-brunette-ed9e@gregkh>
 <CANiq72kn1MQqY8MXaR9bnSYD=Wo7yC4Wxcq0p0Z4w2K=_dDpiw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72kn1MQqY8MXaR9bnSYD=Wo7yC4Wxcq0p0Z4w2K=_dDpiw@mail.gmail.com>

On Wed, Jul 16, 2025 at 02:57:09PM +0200, Miguel Ojeda wrote:
> On Wed, Jul 16, 2025 at 2:54???PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > Ah, ok, that makes sense in a sad way.  As long as someone knows to
> > regenerate these files when needed, hopefully when the C files change
> > someone knows to update these rust ones...
> 
> IIUC, the line added in `scripts/atomic/gen-atomics.sh` will make sure
> it happens at the same time, right?

Yeah, it should

