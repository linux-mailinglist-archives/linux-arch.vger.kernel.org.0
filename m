Return-Path: <linux-arch+bounces-8642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 359EA9B2BCD
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 10:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BFA4B21ECF
	for <lists+linux-arch@lfdr.de>; Mon, 28 Oct 2024 09:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A0DC1D0F44;
	Mon, 28 Oct 2024 09:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aq8Fvakk"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26278A59;
	Mon, 28 Oct 2024 09:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108792; cv=none; b=HLzyM6VPcPWsrbOgjNxkAD+XMeMpQ655wWCs5zH/d3S7MaH9VXq+acMDgASNHv/XtVGfZuYtvWnSHK1n7P/OEvaMJvEywcOSODDTtiP2m09ToSeMmNE3SyFfLSE13NI3wKUXpjbaTk5fTk1gv4F6ERcuxuvUeO/icENsynprpzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108792; c=relaxed/simple;
	bh=esWOg3jL+23bi0dWIcRsd2BbFXdEWl5lcxh3vNT+P1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgGbteiySZMBQeUOduQqSpm8WNmVb+F05r0cCmna+iYyEMBSWpMTPEXF4oB3KXN8lwixg+3GJTloVdtwjcOV0UAOuJY50PlK/7fndBIXLHoNgPsYTLyRBrjA2/c4hp+ObnYDfcw7OtiEOgwKjx2mW83etJtttI8vyATyTEgB6P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aq8Fvakk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=UbI+/ogxnnmJVf8b6VYUNswwOQdnM/YKmug7VOUyJ6c=; b=aq8Fvakkqpjxs2zD/df1RE0Qg4
	Ci8cLKq9nuRrz/gOgaaVeuxr/XA8yA9OIn4i0JxA/Q6bZm45rHuwJtNAUZXece+Noykfyq0jlOd3F
	8phv5acod4K66A1fxVHA9x9u2iY0UmHvrA/R2VoJzGtzkX0xOf9S8uNRSOdEP+sIac1t8QpmtDcPb
	ByRT9ekQQqt5jstorDk0mSrOEZKJaKCkNVnLf59/etxTpNFLVJBtlK7N37coZIdDla2rMBeQKP93X
	4EERZXH4+yvEdaeoOW9pqrwtYROVevkXNonvG9OV6nrpiuAQcmMLzmY2+8A6Bt7rY+unrkn6Heu56
	Nl8OP37g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t5MKJ-00000008Dln-0Eck;
	Mon, 28 Oct 2024 09:46:19 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0606B30083E; Mon, 28 Oct 2024 10:46:19 +0100 (CET)
Date: Mon, 28 Oct 2024 10:46:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Christoph Lameter (Ampere)" <cl@gentwo.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de, llong@redhat.com
Subject: Re: [PATCH 2/6] futex: Implement FUTEX2_NUMA
Message-ID: <20241028094618.GL9767@noisy.programming.kicks-ass.net>
References: <20241025090347.244183920@infradead.org>
 <20241025093944.485691531@infradead.org>
 <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dce4d83c-fb3f-3581-71e4-33dad3f91e07@gentwo.org>

On Fri, Oct 25, 2024 at 12:28:54PM -0700, Christoph Lameter (Ampere) wrote:
> On Fri, 25 Oct 2024, Peter Zijlstra wrote:
> 
> > Extend the futex2 interface to be numa aware.
> >
> > When FUTEX2_NUMA is specified for a futex, the user value is extended
> > to two words (of the same size). The first is the user value we all
> > know, the second one will be the node to place this futex on.
> >
> >   struct futex_numa_32 {
> > 	u32 val;
> > 	u32 node;
> >   };
> >
> > When node is set to ~0, WAIT will set it to the current node_id such
> > that WAKE knows where to find it. If userspace corrupts the node value
> > between WAIT and WAKE, the futex will not be found and no wakeup will
> > happen.
> >
> > When FUTEX2_NUMA is not set, the node is simply an extention of the
> > hash, such that traditional futexes are still interleaved over the
> > nodes.
> 
> 
> Would it be possible to follow the NUMA memory policy set up for a task
> when making these decisions? We may not need a separate FUTEX2_NUMA
> option. There are supportive functions in mm/mempolicy.c that will yield
> a node for the futex logic to use.

Using get_task_policy() seems very dangerous to me. It is explicitly
possible for different tasks in a process to have different policies,
which means (private) futexes would fail to work correctly.

We need something that is process wide consistent -- like the vma
policies. Except at current, those are to expensive to readily access.

