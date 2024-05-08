Return-Path: <linux-arch+bounces-4279-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2778C081C
	for <lists+linux-arch@lfdr.de>; Thu,  9 May 2024 01:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED40F1F2276D
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 23:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE469133414;
	Wed,  8 May 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdAo28jz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845D350A6D;
	Wed,  8 May 2024 23:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715211996; cv=none; b=VuX12nza8nxFOLOvKCQxh2zo8yyh0SDU/maDBRw5wsK3UlFwgIknga8zum3pBaPTdYstIu8Cv7p5cQDArupUjuDDe+LGwX4SxUK41AIZ2pxZxvhi6rfWa2WXmARYBsM3tlcGDUHGuK2PAComPnpzPOrT3aVQMnMfbRo3+RJqVXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715211996; c=relaxed/simple;
	bh=uLNC520rYGqWSAZsi1Qc0GGuHL1W3mmjcZyfxbd53cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d2YLJt57V4mDYo8W9HD0N+eL94lA8T3UJjr/LZLcIn4FAkUvCjN/ArqKL1w/8HOJ1IYdXy1qciBroGvd2N5mNHtDxRspGAbesLG2aaQrgZTutpuLGyqQqRpt6Nqrxn+l543krFm/yNJHMP+O/bhBfrBVeYrodbd/Hr+uKRuog6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdAo28jz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09970C113CC;
	Wed,  8 May 2024 23:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715211996;
	bh=uLNC520rYGqWSAZsi1Qc0GGuHL1W3mmjcZyfxbd53cA=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=cdAo28jzXAqvtxr52DMqMno8HLd+O5OD58tQDpRpn/9HOEQcLTZiIEse9ofNLMe6t
	 aB9Z6bRItWokto34IEH6+evtxLDTANWIWnGpXTw4yLMWu45AJlDfr5jBFBj48YfNiI
	 B2H+1FfFkWFBZR0vecMuJG+L6rknsIwtT5bfWzZO6l7sLVMqxteHPF3LjMP7OHWouo
	 wln1DPsnQkH/KUkSiQBERLxCowFVQNfB2eGZazVCyXfv6jK19M70g63GK7/hY9ih96
	 jAjIXrqjCNb25mLFjweTM8j13MavBCqmMjN9FVnclB97ZTcaoQMfu1c57XyA0jqJl/
	 Dig2vbWpMvDqQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id ADE9BCE0A6A; Wed,  8 May 2024 16:46:35 -0700 (PDT)
Date: Wed, 8 May 2024 16:46:35 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Akira Yokosawa <akiyks@gmail.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Puranjay Mohan <puranjay@kernel.org>,
	Luc Maranget <luc.maranget@inria.fr>,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	puranjay12@gmail.com
Subject: Re: [PATCH] tools/memory-model: Add atomic_and()/or()/xor() and
 add_negative
Message-ID: <8eaa61a3-4d27-4791-b98e-2a4cb331131c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240508143400.36256-1-puranjay@kernel.org>
 <ZjvXZZiew_shyQA3@boqun-archlinux>
 <7e7167fd-cf4d-4d8b-bd83-d9fe8887dbae@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e7167fd-cf4d-4d8b-bd83-d9fe8887dbae@gmail.com>

On Thu, May 09, 2024 at 06:59:17AM +0900, Akira Yokosawa wrote:
> On Wed, 8 May 2024 12:49:57 -0700, Boqun Feng wrote:
> > On Wed, May 08, 2024 at 02:34:00PM +0000, Puranjay Mohan wrote:
> >> Pull-849[1] added the support of '&', '|', and '^' to the herd7 tool's
> >> atomics operations.
> >>
> >> Use these in linux-kernel.def to implement atomic_and()/or()/xor() with
> >> all their ordering variants.
> >>
> >> atomic_add_negative() is already available so add its acquire, release,
> >> and relaxed ordering variants.
> >>
> >> [1] https://github.com/herd/herdtools7/pull/849
> > 
> > A newer version of herd is required for this feature, right?
> 
> Yes, this requires building herd7 from latest source.
> 
> herdtools7 7.57 (released recently) happened before pull 849.
> 
> Luc, what is your plan on a next release (7.57.1?) ?
> 
> >                                                               So please
> > also do a change in tools/memory-model/README "REQUIREMENTS" session
> > when the new version released.
> 
> Puranjay, it would be great if you add some litmus tests which use
> additional atomic primitives under tools/memory-model/litmus-tests/
> as well.

Thank you for checking, Akira!  I need to hold off sending this upstream
until there is a herdtools7 release that supports it.  So not the merge
window that is likely to open this weekend.  ;-)

							Thanx, Paul

>         Thanks, Akira
> 
> > Boqun
> > 
> >>
> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> >> ---
> >>  tools/memory-model/linux-kernel.def | 21 +++++++++++++++++++++
> >>  1 file changed, 21 insertions(+)
> 

