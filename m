Return-Path: <linux-arch+bounces-12366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A422AADEB86
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 14:15:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDC283A4122
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 12:11:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A0B27E075;
	Wed, 18 Jun 2025 12:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5vAuRht"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2568A2F530F;
	Wed, 18 Jun 2025 12:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750248720; cv=none; b=owKc3dwSvVigy83Dh4kFsn2/AFwzBfG7yxFfT/Yrs34kNgOiafYYWzMKq0YqcpfzcFWmpNqUZHHc/wEUyhq609c3skdCE4w3VYWv2JaxacjeDs7JZiLGclBahQDeifoKo+uMdsxSghIrpnrXn1uJ2JDJPscSuEMT4j+TSIXqvtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750248720; c=relaxed/simple;
	bh=Bm6AlVdy7rJk76AcQQbQ/HxwJZrHOdNInWoHVKdb28A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kE3pUqZSCkD2lqMwYgwkDefKupi0sX9UPMj7sAdnRYw75umoy2YaObEQX2KksSnSLe5j0iEaFqeD2xi6vFjdhJ6EDKjK/3gGBotHc2WM1z3silFHBd6+lZ+9atMOX/WvdGsicL+ZS0YMZrpbjFiGJR0GOSFT7EuUaflny5TJNLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5vAuRht; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758B8C4CEE7;
	Wed, 18 Jun 2025 12:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750248719;
	bh=Bm6AlVdy7rJk76AcQQbQ/HxwJZrHOdNInWoHVKdb28A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=b5vAuRht8JNoykjTL9HCcNJWeOUIAw3LL1/SFi1TpjB7UzJNy6Usv07+Cfd7M8D2e
	 C4SyOrRGrce4ttdohUxsIT22OXaYqAHAI0v8VzFfgcUmGfalRSBXZdYNrWx41XXEK8
	 qu44zfOOiodyYjcQdKqbxk1zbKFeRCLS4O4N589CJ069I0sa60sSE5DlDhVuwQQb7N
	 KCxtXlQ/RiOiFPbb+OXQsD+ZZJ89uYfb1OX4IGxjqq/BknyjI0AUfthQcMNLltEQhX
	 T0O4gAjKMFhTyjNFAceqNr23GR0F9bw/pGNL1Wm0D0diakiwVpt+J9Krgj4JFJJtvP
	 M/ZAyziH+cRjQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B3F84CE0C98; Wed, 18 Jun 2025 05:11:56 -0700 (PDT)
Date: Wed, 18 Jun 2025 05:11:56 -0700
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
Message-ID: <84e8e3c1-fc7e-4f6b-9c71-39bf7522a498@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <cb83e3e4-9e22-4457-bf61-5614cc4396ad@tu-bs.de>
 <20250613075501.GI2273038@noisy.programming.kicks-ass.net>
 <0b20c5e8-ef01-4527-9122-8722f96972ae@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b20c5e8-ef01-4527-9122-8722f96972ae@paulmck-laptop>

On Tue, Jun 17, 2025 at 11:51:49PM -0700, Paul E. McKenney wrote:
> On Fri, Jun 13, 2025 at 09:55:01AM +0200, Peter Zijlstra wrote:
> > On Thu, Jun 12, 2025 at 04:55:28PM +0200, Thomas Haas wrote:
> 
> [ . . . ]
> 
> > >     - put some other read-read barrier between the xchg_tail and the load.
> > > 
> > > 
> > > ### Implications for qspinlock executed on non-ARM architectures.
> > > 
> > > Unfortunately, there are no MSA extensions for other hardware memory models,
> > > so we have to speculate based on whether the problematic reordering is
> > > permitted if the problematic load was treated as two individual
> > > instructions.
> > > It seems Power and RISCV would have no problem reordering the instructions,
> > > so qspinlock might also break on those architectures.
> > 
> > Power (and RiscV without ZABHA) 'emulate' the short XCHG using a full
> > word LL/SC and should be good.
> > 
> > But yes, ZABHA might be equally broken.
> 
> All architectures handle eight-bit atomics and stores, but last I checked,
> there were a few systems still around that failed to support 16-bit
> atomics and stores.  I will check again.
> 
> (But those systems's architectures can simply avoid supporting kernel
> features requiring these 16-bit operations.)
> 
> It would be good to add multiple sizes to LKMM, and even moreso once we
> have 16-bit support across the board.

And Arnd tells me that the Linux kernel might be safe for 16-bit stores
in core code perhaps as early as the end of this year.  ;-)

							Thanx, Paul

