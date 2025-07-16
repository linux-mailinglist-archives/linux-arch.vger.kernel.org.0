Return-Path: <linux-arch+bounces-12810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D43AB0764F
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 14:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 868BB3B03CD
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B0D62F3C30;
	Wed, 16 Jul 2025 12:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yuST/vnW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682E6290D95;
	Wed, 16 Jul 2025 12:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752670478; cv=none; b=uAeQT6k3ZBoqtKkGSuRqRjYKTi8MVTUUzFiqFmqAv4TjnhdEsod8CSj55IJjE4nDFIR15uARrXmp21Blk2WaiViP+tuSKQm/wwnIDcKj0xQWE7F40uG8NB8h4W5YbK5D+PvSk0CpmVhUC8O4/kgM2WKrwXJaKHMS5jdBm5GPUKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752670478; c=relaxed/simple;
	bh=r5UPxskNEe9Y3A94+Em5aoR9OWJAFR8DTBxMP2ylNbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PvvjGodq7sU5NLJbpyLhv/WT+J7xU3Z0RV0D1egRZx9v3ekjJP1SLbzmVOdAHWxoFE8QNIal2AmoYfAVPL3drrbxbdipm+VNO3LpTa2HlP5kgGnIW40QA5llIstOmQ68tp9z+kOWjuUfMHssccZPmJYSyOAhIIhp0eHnpcoPdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yuST/vnW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A81FC4CEF0;
	Wed, 16 Jul 2025 12:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1752670476;
	bh=r5UPxskNEe9Y3A94+Em5aoR9OWJAFR8DTBxMP2ylNbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yuST/vnWBrTC04sbx5B1Nu7B0H/4rEQR4WhiBlJU7cQi36YAKZkbY6h5Wyuh5pK/q
	 eFi7jxhf+8DJ1i+jGBOuP0DPc50eo0YIOKKibK3F7vUYjrwYSylNBaSFY4VuNMe59t
	 loDznVe7fSe4o/0VPVBFA9k6ib4QUYgIxA3PVUyI=
Date: Wed, 16 Jul 2025 14:54:34 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, lkmm@lists.linux.dev,
	linux-arch@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
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
	Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH v7 1/9] rust: Introduce atomic API helpers
Message-ID: <2025071651-daylong-brunette-ed9e@gregkh>
References: <20250714053656.66712-1-boqun.feng@gmail.com>
 <20250714053656.66712-2-boqun.feng@gmail.com>
 <2025071611-factsheet-sitter-93b6@gregkh>
 <20250716124713.GW905792@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250716124713.GW905792@noisy.programming.kicks-ass.net>

On Wed, Jul 16, 2025 at 02:47:13PM +0200, Peter Zijlstra wrote:
> On Wed, Jul 16, 2025 at 11:23:09AM +0200, Greg Kroah-Hartman wrote:
> > On Sun, Jul 13, 2025 at 10:36:48PM -0700, Boqun Feng wrote:
> > > In order to support LKMM atomics in Rust, add rust_helper_* for atomic
> > > APIs. These helpers ensure the implementation of LKMM atomics in Rust is
> > > the same as in C. This could save the maintenance burden of having two
> > > similar atomic implementations in asm.
> > > 
> > > Originally-by: Mark Rutland <mark.rutland@arm.com>
> > > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > > Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> > > ---
> > >  rust/helpers/atomic.c                     | 1040 +++++++++++++++++++++
> > >  rust/helpers/helpers.c                    |    1 +
> > >  scripts/atomic/gen-atomics.sh             |    1 +
> > >  scripts/atomic/gen-rust-atomic-helpers.sh |   67 ++
> > >  4 files changed, 1109 insertions(+)
> > >  create mode 100644 rust/helpers/atomic.c
> > >  create mode 100755 scripts/atomic/gen-rust-atomic-helpers.sh
> > > 
> > > diff --git a/rust/helpers/atomic.c b/rust/helpers/atomic.c
> > > new file mode 100644
> > > index 000000000000..cf06b7ef9a1c
> > > --- /dev/null
> > > +++ b/rust/helpers/atomic.c
> > > @@ -0,0 +1,1040 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +
> > > +// Generated by scripts/atomic/gen-rust-atomic-helpers.sh
> > > +// DO NOT MODIFY THIS FILE DIRECTLY
> > 
> > As this is auto-generated, how do we know when to auto-generate it
> > again?  What files does it depend on?  And why can't we just
> > auto-generate it at build time instead of having a static file in the
> > tree that no one knows when to regenerate it?  :)
> 
> It depends on the scripts/atomic/* bits. They hardly if ever change. We
> do it this way because:
> 
>  - generating these files every build is 'slow'-ish;
>  - code navigation suffers;
>  - Linus asked for this.
> 
> Specifically, pretty much the entire atomic_*() namespace would
> disappear from ctags / code-browsing-tool-of-choice if we would not
> check in these files.

Ah, ok, that makes sense in a sad way.  As long as someone knows to
regenerate these files when needed, hopefully when the C files change
someone knows to update these rust ones...

thanks,

greg k-h

