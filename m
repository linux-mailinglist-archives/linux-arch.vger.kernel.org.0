Return-Path: <linux-arch+bounces-1865-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C88B7842A94
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 18:12:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63B361F23E12
	for <lists+linux-arch@lfdr.de>; Tue, 30 Jan 2024 17:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A651292D0;
	Tue, 30 Jan 2024 17:12:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AADC112BF03;
	Tue, 30 Jan 2024 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706634762; cv=none; b=fo8y6E9I0TJRUW6MSpSAyT1M8ltPAte01pakAIy1LwQwI4iX8D1XdPhk9nyeT9h8tCqzTR/nWLihQDZL34f38YHZez9amuBKC61GSf8D6X9IwF6TOO/PDEiN7IL5wxoUxw4nrZIkzCemG6WPTBFEnbZaxITMuzcw2PEZCVYbaTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706634762; c=relaxed/simple;
	bh=HXl1FyBzCOPH2WUgPaTFyW6YIyaZ0FyPabts9TuNKKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hMJ1QhzC484uYTHPLMS64BnJNc5nZ3F1iCJvPCW3ZMOc5SwISEGk/Klz1CRGezwvKEr0DCXczl77z7/9WkegREEaqBseQDXpJcUvjoyj44kSFsVbtBylSZtPDEehNBqtXXKt+JRZhHnYHoqI5uS3T3ZFSt7xAPcPNvKFQTnA6Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9AB14DA7;
	Tue, 30 Jan 2024 09:13:20 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.45.140])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3BA03F5A1;
	Tue, 30 Jan 2024 09:12:30 -0800 (PST)
Date: Tue, 30 Jan 2024 17:12:23 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	"E."@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>, Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Paul@paulmck-thinkpad-p17-gen-1.smtp.subspace.kernel.org,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH doc] Emphasize that failed atomic operations give no
 ordering
Message-ID: <Zbkt94Q8a-xFXrve@FVFF77S0Q05N>
References: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63d9d6f6-05e8-473d-9d09-ce8d3a33ca39@paulmck-laptop>

On Tue, Jan 30, 2024 at 06:53:38AM -0800, Paul E. McKenney wrote:
> The ORDERING section of Documentation/atomic_t.txt can easily be read as
> saying that conditional atomic RMW operations that fail are ordered when
> those operations have the _acquire() or _release() prefixes.  This is
> not the case, therefore update this section to make it clear that failed
> conditional atomic RMW operations provide no ordering.
> 
> Reported-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Andrea Parri <parri.andrea@gmail.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Jade Alglave <j.alglave@ucl.ac.uk>
> Cc: Luc Maranget <luc.maranget@inria.fr>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Akira Yokosawa <akiyks@gmail.com>
> Cc: Daniel Lustig <dlustig@nvidia.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: <linux-arch@vger.kernel.org>
> Cc: <linux-doc@vger.kernel.org>
> 
> diff --git a/Documentation/atomic_t.txt b/Documentation/atomic_t.txt
> index d7adc6d543db4..bee3b1bca9a7b 100644
> --- a/Documentation/atomic_t.txt
> +++ b/Documentation/atomic_t.txt
> @@ -171,14 +171,14 @@ The rule of thumb:
>   - RMW operations that are conditional are unordered on FAILURE,
>     otherwise the above rules apply.
>  
> -Except of course when an operation has an explicit ordering like:
> +Except of course when a successful operation has an explicit ordering like:
>  
>   {}_relaxed: unordered
>   {}_acquire: the R of the RMW (or atomic_read) is an ACQUIRE
>   {}_release: the W of the RMW (or atomic_set)  is a  RELEASE
>  
>  Where 'unordered' is against other memory locations. Address dependencies are
> -not defeated.
> +not defeated.  Conditional operations are still unordered on FAILURE.
>  
>  Fully ordered primitives are ordered against everything prior and everything
>  subsequent. Therefore a fully ordered primitive is like having an smp_mb()
> 

FWIW:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

