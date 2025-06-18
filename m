Return-Path: <linux-arch+bounces-12361-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 338BEADE3FD
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 08:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04ADF3B66C4
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 06:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20D2153C6;
	Wed, 18 Jun 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yz+NyiyX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D107212D97;
	Wed, 18 Jun 2025 06:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750229517; cv=none; b=FCO/blGQDEBAB1a/wNguRT5JBUgQkg+kPmZKeCap3hV7F6ntX6jJ923D8a//SSDeSJvwn+8KFxbQJ0j1lRsyGockU5U9VqvOS08ywDtL9g1tSy87nmqzUTl1Smjh2yYO8y6XdgB2Z2r0oj7mFBas1dj9mzzMzGzihA+x2apMQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750229517; c=relaxed/simple;
	bh=WvwQCHstGsP4NHsM2WggCpU1wppw6aSP0CoxaTIrbUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUaDcEiB9uDxDIb+OZaefMVtmjxVjaV2X6zydFoix20SjBWo+y3rC2EU/GQGrJlIUN9I3wgZN5lBSZSPzznzKgey/8YocHcamalgO3f3Sogc3UUtqS2wLi+k/IR0cGH8xlS9MBGcNg8UGtpBaiIdcYAY5auF2nM+M0023W32Pco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yz+NyiyX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C28C4CEE7;
	Wed, 18 Jun 2025 06:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750229516;
	bh=WvwQCHstGsP4NHsM2WggCpU1wppw6aSP0CoxaTIrbUU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Yz+NyiyXoCPo0nGbuEbFKAV9ZKH28VF+Vjvsmm70ndiBhecdB9x2/8FlCdb9v0O/f
	 1hiAUzygX0yiikOIbjbRb4ufZW+A0eHCQE/JQbtpBJ8MoSsp7FZflJPs30xWbM5utp
	 HcxWa9Qy9oWlQYJjf94Mksu/N6Pw/kyLbq5K5RhCoIATQ4YA42+z3vd0zupWbY8gaw
	 ZSzMarEFv9VQME8vx3/SuGvBv/5MGje5gQ1EQ0k0yHJWfM2jG1y5ug8QP6N0Hg32PE
	 JjqomlygSuXtG/O6MJ8bsd5xJR7fYtM0zlpIOOLMH+2HZUkQY82TEMR7OrIcRLd5bg
	 XfMlRgV69R6XQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 90E50CE0A33; Tue, 17 Jun 2025 23:51:49 -0700 (PDT)
Date: Tue, 17 Jun 2025 23:51:49 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Haas <t.haas@tu-bs.de>, Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, hernan.poncedeleon@huaweicloud.com,
	jonas.oberhauser@huaweicloud.com,
	"r.maseli@tu-bs.de" <r.maseli@tu-bs.de>
Subject: Re: [RFC] Potential problem in qspinlock due to mixed-size accesses
Message-ID: <0b20c5e8-ef01-4527-9122-8722f96972ae@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250613075501.GI2273038@noisy.programming.kicks-ass.net>

On Fri, Jun 13, 2025 at 09:55:01AM +0200, Peter Zijlstra wrote:
> On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:

[ . . . ]

> >     - put some other read-read barrier between the xchg_tail and the load.
> > 
> > 
> > ### Implications for qspinlock executed on non-ARM architectures.
> > 
> > Unfortunately, there are no MSA extensions for other hardware memory models,
> > so we have to speculate based on whether the problematic reordering is
> > permitted if the problematic load was treated as two individual
> > instructions.
> > It seems Power and RISCV would have no problem reordering the instructions,
> > so qspinlock might also break on those architectures.
> 
> Power (and RiscV without ZABHA) 'emulate' the short XCHG using a full
> word LL/SC and should be good.
> 
> But yes, ZABHA might be equally broken.

All architectures handle eight-bit atomics and stores, but last I checked,
there were a few systems still around that failed to support 16-bit
atomics and stores.  I will check again.

(But those systems's architectures can simply avoid supporting kernel
features requiring these 16-bit operations.)

It would be good to add multiple sizes to LKMM, and even moreso once we
have 16-bit support across the board.

							Thanx, Paul

