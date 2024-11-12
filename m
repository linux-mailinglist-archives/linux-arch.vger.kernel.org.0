Return-Path: <linux-arch+bounces-9030-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A46D49C4DB5
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 05:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64ECF2844FC
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 04:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAA2204935;
	Tue, 12 Nov 2024 04:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRWxJ4qu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0516CD29;
	Tue, 12 Nov 2024 04:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731385206; cv=none; b=Ze1EBqJe/5nFEswrj9MB+PsOI/uboQZOUf6XzupoYebSYaQaEH8WBzTwmYMPltrADk4ghrHuyoAWtHVIp6mL6dguLILIEjIzmxs85DG4SR+G8LDTR7QI/RE58LUfQK5Hs6ZizZciFjCbH1Tet6ageUf0r+i1EqosVEHndQm25Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731385206; c=relaxed/simple;
	bh=Y8NhY7Adl5BOV1u6OOJfKrr4ga7CKJYt7qunWVKxuq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GXbLnYMGIBDxyHpqBOgeT41Do0Uje+Qd+bAPg/sE7xS9bZaIbkabIvmFmydRrbWM1fVZUoZiuny7cr8Fnn8Yov652EvTmN/e/CH3qbra+RXULIW+jBeACu8ZCpI5GkEhsuU8LjjJ0n7OyQx8wIQaCRq9pTvxL9/zM5ohF7iMNVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FRWxJ4qu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE38BC4CECD;
	Tue, 12 Nov 2024 04:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731385205;
	bh=Y8NhY7Adl5BOV1u6OOJfKrr4ga7CKJYt7qunWVKxuq0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=FRWxJ4qutMqaAFD73k+MrvF/wyzGeAR7BFbxHv3lMfbeWZj/TEoDhUPhsT1iMP5bi
	 s8uGaZZ8dTRNifmL913I9AHLaKXeml+9iLsmcWlI76CXAsV4KNHoEWJ0t1id9g1LWR
	 Fn7oqZw0aWusXE2jEhekcRDPDftMDzcsMJgP8jzBbW60tnULon3NjUEUXqtebgVaaU
	 BUvrXGpt8AtB9HbiEWzngI9M4OKbCvZC/LEE/gS2E6rxE8p7n1m+7scEbpqfU446Tl
	 G++M9eM2E6uKhLXQo8vJZja6MW9HMKZ9EtohePaR8utIPgt51pm8zghbH+snEZr13L
	 aP5k4HWgKkczA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 60A38CE0BA3; Mon, 11 Nov 2024 20:20:05 -0800 (PST)
Date: Mon, 11 Nov 2024 20:20:05 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: =?utf-8?B?U3rFkWtl?= Benjamin <egyszeregy@freemail.hu>,
	parri.andrea@gmail.com, will@kernel.org, peterz@infradead.org,
	boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
	j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
	dlustig@nvidia.com, joel@joelfernandes.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	lkmm@lists.linux.dev, torvalds@linux-foundation.org
Subject: Re: [PATCH] tools/memory-model: Fix litmus-tests's file names for
 case-insensitive filesystem.
Message-ID: <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>

On Mon, Nov 11, 2024 at 07:59:33PM -0500, Alan Stern wrote:
> On Mon, Nov 11, 2024 at 10:15:30PM +0100, Szőke Benjamin wrote:
> > warning: the following paths have collided (e.g. case-sensitive paths
> > on a case-insensitive filesystem) and only one from the same
> > colliding group is in the working tree:
> > 
> >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
> >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
> 
> I support the idea of renaming one of these files.  Not to make things 
> work on case-insensitive filesystems, but simply because having two 
> files with rather long (and almost nonsensical) names that are identical 
> aside from one single letter is an excellent way to confuse users.
> 
> Come on -- just look at the error report above.  Can you tell at a 
> glance, without going through and carefully comparing the two strings 
> letter-by-letter, exactly what the difference is?  Do you really think 
> anybody could?
> 
> I haven't looked to see if there are any other similar examples in the 
> litmus-tests directory, but if there are than they should be changed 
> too.

It does jump out at me, but even if it didn't, the usual use of tab
completion and copy/paste should make it a non-problem, not?

find . -print | tr 'A-Z' 'a-z' | sort | uniq -c | sort -k1nr | awk '{ if ($1 > 1) print }'

The output for the kernel and the github litmus repo are shown below.

							Thanx, Paul

------------------------------------------------------------------------

For the kernel:

------------------------------------------------------------------------

      2 ./include/uapi/linux/netfilter_ipv4/ipt_ecn.h
      2 ./include/uapi/linux/netfilter_ipv4/ipt_ttl.h
      2 ./include/uapi/linux/netfilter_ipv6/ip6t_hl.h
      2 ./include/uapi/linux/netfilter/xt_connmark.h
      2 ./include/uapi/linux/netfilter/xt_dscp.h
      2 ./include/uapi/linux/netfilter/xt_mark.h
      2 ./include/uapi/linux/netfilter/xt_rateest.h
      2 ./include/uapi/linux/netfilter/xt_tcpmss.h
      2 ./net/netfilter/xt_dscp.c
      2 ./net/netfilter/xt_hl.c
      2 ./net/netfilter/xt_rateest.c
      2 ./net/netfilter/xt_tcpmss.c
      2 ./tools/memory-model/litmus-tests/z6.0+pooncelock+pooncelock+pombonce.litmus

------------------------------------------------------------------------

For the github litmus repo, almost all of which are automatically
generated:

------------------------------------------------------------------------

      6 ./auto/c-lb-lrw+r-a+r-oc+r-oc.litmus
      6 ./auto/c-lb-lrw+r-a+r-oc+r-oc.litmus.out
      6 ./auto/c-lb-lrw+r-oc+r-oc+r-oc.litmus
      6 ./auto/c-lb-lrw+r-oc+r-oc+r-oc.litmus.out
      6 ./auto/lb-lrw+r-a+r-oc+r-oc.litmus.out
      6 ./auto/lb-lrw+r-oc+r-oc+r-oc.litmus.out
      5 ./auto/c-lb-lrw+r-oc+r-oc.litmus
      5 ./auto/c-lb-lrw+r-oc+r-oc.litmus.out
      5 ./auto/c-lb-lwr+r-a+r-oc+r-oc.litmus
      5 ./auto/c-lb-lwr+r-a+r-oc+r-oc.litmus.out
      5 ./auto/c-lb-lwr+r-oc+r-oc+r-oc.litmus
      5 ./auto/c-lb-lwr+r-oc+r-oc+r-oc.litmus.out
      5 ./auto/c-lb-lww+r-a+r-oc+r-oc.litmus
      5 ./auto/c-lb-lww+r-a+r-oc+r-oc.litmus.out
      5 ./auto/c-lb-lww+r-oc+r-oc+r-oc.litmus
      5 ./auto/c-lb-lww+r-oc+r-oc+r-oc.litmus.out
      5 ./auto/lb-lrw+r-oc+r-oc.litmus.out
      5 ./auto/lb-lwr+r-a+r-oc+r-oc.litmus.out
      5 ./auto/lb-lwr+r-oc+r-oc+r-oc.litmus.out
      5 ./auto/lb-lww+r-a+r-oc+r-oc.litmus.out
      5 ./auto/lb-lww+r-oc+r-oc+r-oc.litmus.out
      4 ./auto/c-lb-lwr+r-oc+r-oc.litmus
      4 ./auto/c-lb-lwr+r-oc+r-oc.litmus.out
      4 ./auto/c-lb-lww+r-oc+r-oc.litmus
      4 ./auto/c-lb-lww+r-oc+r-oc.litmus.out
      4 ./auto/lb-lwr+r-oc+r-oc.litmus.out
      4 ./auto/lb-lww+r-oc+r-oc.litmus.out
      3 ./auto/c-lb-lrw+r-a+r-a+r-oc.litmus
      3 ./auto/c-lb-lrw+r-a+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lrw+r-a+r-oc.litmus
      3 ./auto/c-lb-lrw+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lrw+r-oc+r-oc+r-d.litmus
      3 ./auto/c-lb-lrw+r-oc+r-oc+r-d.litmus.out
      3 ./auto/c-lb-lrw+r-oc+r-oc+r-od.litmus
      3 ./auto/c-lb-lrw+r-oc+r-oc+r-od.litmus.out
      3 ./auto/c-lb-lwr+r-a+r-a+r-oc.litmus
      3 ./auto/c-lb-lwr+r-a+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lwr+r-a+r-oc.litmus
      3 ./auto/c-lb-lwr+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lwr+r-oc+r-oc+r-d.litmus
      3 ./auto/c-lb-lwr+r-oc+r-oc+r-d.litmus.out
      3 ./auto/c-lb-lwr+r-oc+r-oc+r-od.litmus
      3 ./auto/c-lb-lwr+r-oc+r-oc+r-od.litmus.out
      3 ./auto/c-lb-lww+r-a+r-a+r-oc.litmus
      3 ./auto/c-lb-lww+r-a+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lww+r-a+r-oc.litmus
      3 ./auto/c-lb-lww+r-a+r-oc.litmus.out
      3 ./auto/c-lb-lww+r-oc+r-oc+r-d.litmus
      3 ./auto/c-lb-lww+r-oc+r-oc+r-d.litmus.out
      3 ./auto/c-lb-lww+r-oc+r-oc+r-od.litmus
      3 ./auto/c-lb-lww+r-oc+r-oc+r-od.litmus.out
      3 ./auto/lb-lrw+r-a+r-a+r-oc.litmus.out
      3 ./auto/lb-lrw+r-a+r-oc.litmus.out
      3 ./auto/lb-lrw+r-oc+r-oc+r-d.litmus.out
      3 ./auto/lb-lrw+r-oc+r-oc+r-od.litmus.out
      3 ./auto/lb-lwr+r-a+r-a+r-oc.litmus.out
      3 ./auto/lb-lwr+r-a+r-oc.litmus.out
      3 ./auto/lb-lwr+r-oc+r-oc+r-d.litmus.out
      3 ./auto/lb-lwr+r-oc+r-oc+r-od.litmus.out
      3 ./auto/lb-lww+r-a+r-a+r-oc.litmus.out
      3 ./auto/lb-lww+r-a+r-oc.litmus.out
      3 ./auto/lb-lww+r-oc+r-oc+r-d.litmus.out
      3 ./auto/lb-lww+r-oc+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lrr+r-a+ob-o+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+ob-o+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+ob-o+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+ob-o+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+ob-o+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-a+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-a+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-a+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-a+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-a+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-a+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-oc+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-oc+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-oc+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-a+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-a+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+ob-o+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+ob-o+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-a+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-a+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-a+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-a+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-a+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-a+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-dd+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-dd+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-a+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-dd+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrr+r-oc+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrr+r-oc+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+ob-o+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-a+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-a+ob-o+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-a.litmus
      2 ./auto/c-lb-lrw+r-a+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-a+r-a.litmus
      2 ./auto/c-lb-lrw+r-a+r-a+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-a+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-a+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-a+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-a+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-d+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-d+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-o+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-a+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-d.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-od.litmus
      2 ./auto/c-lb-lrw+r-a+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-oc+r-ov.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-od+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-od+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-a+r-ov+r-oc.litmus
      2 ./auto/c-lb-lrw+r-a+r-ov+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-a+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-a+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-dd+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-dd+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-dd+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-dd+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+r-a.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+r-a.litmus.out
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-dd+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-oc.litmus
      2 ./auto/c-lb-lrw+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+ob-o+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+ob-o+ob-o+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+ob-o+ob-o+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+ob-o+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-d.litmus
      2 ./auto/c-lb-lrw+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-d+r-d.litmus
      2 ./auto/c-lb-lrw+r-oc+r-d+r-d.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-d+r-od.litmus
      2 ./auto/c-lb-lrw+r-oc+r-d+r-od.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-oc+ob-o+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-oc+r-oc+ob-ob.litmus
      2 ./auto/c-lb-lrw+r-oc+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-oc+r-oc+r-oc.litmus
      2 ./auto/c-lb-lrw+r-oc+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-od.litmus
      2 ./auto/c-lb-lrw+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-od+r-d.litmus
      2 ./auto/c-lb-lrw+r-oc+r-od+r-d.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-od+r-od.litmus
      2 ./auto/c-lb-lrw+r-oc+r-od+r-od.litmus.out
      2 ./auto/c-lb-lrw+r-oc+r-ov+r-d.litmus
      2 ./auto/c-lb-lrw+r-oc+r-ov+r-d.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-a.litmus
      2 ./auto/c-lb-lwr+r-a+r-a.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-a+r-a.litmus
      2 ./auto/c-lb-lwr+r-a+r-a+r-a.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-d+r-oc.litmus
      2 ./auto/c-lb-lwr+r-a+r-d+r-oc.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-oc+r-d.litmus
      2 ./auto/c-lb-lwr+r-a+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-oc+r-od.litmus
      2 ./auto/c-lb-lwr+r-a+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-od+r-oc.litmus
      2 ./auto/c-lb-lwr+r-a+r-od+r-oc.litmus.out
      2 ./auto/c-lb-lwr+r-a+r-ov+r-oc.litmus
      2 ./auto/c-lb-lwr+r-a+r-ov+r-oc.litmus.out
      2 ./auto/c-lb-lwr+r-oc.litmus
      2 ./auto/c-lb-lwr+r-oc.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-d.litmus
      2 ./auto/c-lb-lwr+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-d+r-d.litmus
      2 ./auto/c-lb-lwr+r-oc+r-d+r-d.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-d+r-od.litmus
      2 ./auto/c-lb-lwr+r-oc+r-d+r-od.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-od.litmus
      2 ./auto/c-lb-lwr+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-od+r-d.litmus
      2 ./auto/c-lb-lwr+r-oc+r-od+r-d.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-od+r-od.litmus
      2 ./auto/c-lb-lwr+r-oc+r-od+r-od.litmus.out
      2 ./auto/c-lb-lwr+r-oc+r-ov+r-d.litmus
      2 ./auto/c-lb-lwr+r-oc+r-ov+r-d.litmus.out
      2 ./auto/c-lb-lww+r-a+r-a.litmus
      2 ./auto/c-lb-lww+r-a+r-a.litmus.out
      2 ./auto/c-lb-lww+r-a+r-a+r-a.litmus
      2 ./auto/c-lb-lww+r-a+r-a+r-a.litmus.out
      2 ./auto/c-lb-lww+r-a+r-d+r-oc.litmus
      2 ./auto/c-lb-lww+r-a+r-d+r-oc.litmus.out
      2 ./auto/c-lb-lww+r-a+r-oc+r-d.litmus
      2 ./auto/c-lb-lww+r-a+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lww+r-a+r-oc+r-od.litmus
      2 ./auto/c-lb-lww+r-a+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lww+r-a+r-od+r-oc.litmus
      2 ./auto/c-lb-lww+r-a+r-od+r-oc.litmus.out
      2 ./auto/c-lb-lww+r-a+r-ov+r-oc.litmus
      2 ./auto/c-lb-lww+r-a+r-ov+r-oc.litmus.out
      2 ./auto/c-lb-lww+r-oc.litmus
      2 ./auto/c-lb-lww+r-oc.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-d.litmus
      2 ./auto/c-lb-lww+r-oc+r-d.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-d+r-d.litmus
      2 ./auto/c-lb-lww+r-oc+r-d+r-d.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-d+r-od.litmus
      2 ./auto/c-lb-lww+r-oc+r-d+r-od.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-od.litmus
      2 ./auto/c-lb-lww+r-oc+r-od.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-od+r-d.litmus
      2 ./auto/c-lb-lww+r-oc+r-od+r-d.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-od+r-od.litmus
      2 ./auto/c-lb-lww+r-oc+r-od+r-od.litmus.out
      2 ./auto/c-lb-lww+r-oc+r-ov+r-d.litmus
      2 ./auto/c-lb-lww+r-oc+r-ov+r-d.litmus.out
      2 ./auto/lb-lrr+r-a+ob-o+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+ob-o+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-a+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-a+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-a+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-oc+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-a+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+ob-o+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+ob-o+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+ob-o+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-a+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-a+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-a+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-dd+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-dd+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-dd+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc+r-a+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-dd+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrr+r-oc+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-a+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-a.litmus.out
      2 ./auto/lb-lrw+r-a+r-a+r-a.litmus.out
      2 ./auto/lb-lrw+r-a+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-a+r-a+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-d+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+r-a+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+r-d.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-oc+r-od.litmus.out
      2 ./auto/lb-lrw+r-a+r-od+r-oc.litmus.out
      2 ./auto/lb-lrw+r-a+r-ov+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+ob-o+r-oc+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+ob-o+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-a+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-a+r-oc+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-a+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-dd+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-dd+r-oc+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+ob-o+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+ob-o+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-a+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-a+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-a+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-dd+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-dd+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-oc+r-a.litmus.out
      2 ./auto/lb-lrw+r-dd+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-oc.litmus.out
      2 ./auto/lb-lrw+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+ob-o+ob-o+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+ob-o+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+r-d.litmus.out
      2 ./auto/lb-lrw+r-oc+r-d+r-d.litmus.out
      2 ./auto/lb-lrw+r-oc+r-d+r-od.litmus.out
      2 ./auto/lb-lrw+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+r-oc+ob-o+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+r-oc+r-oc+ob-ob.litmus.out
      2 ./auto/lb-lrw+r-oc+r-oc+r-oc+r-oc.litmus.out
      2 ./auto/lb-lrw+r-oc+r-od.litmus.out
      2 ./auto/lb-lrw+r-oc+r-od+r-d.litmus.out
      2 ./auto/lb-lrw+r-oc+r-od+r-od.litmus.out
      2 ./auto/lb-lrw+r-oc+r-ov+r-d.litmus.out
      2 ./auto/lb-lwr+r-a+r-a.litmus.out
      2 ./auto/lb-lwr+r-a+r-a+r-a.litmus.out
      2 ./auto/lb-lwr+r-a+r-d+r-oc.litmus.out
      2 ./auto/lb-lwr+r-a+r-oc+r-d.litmus.out
      2 ./auto/lb-lwr+r-a+r-oc+r-od.litmus.out
      2 ./auto/lb-lwr+r-a+r-od+r-oc.litmus.out
      2 ./auto/lb-lwr+r-a+r-ov+r-oc.litmus.out
      2 ./auto/lb-lwr+r-oc.litmus.out
      2 ./auto/lb-lwr+r-oc+r-d.litmus.out
      2 ./auto/lb-lwr+r-oc+r-d+r-d.litmus.out
      2 ./auto/lb-lwr+r-oc+r-d+r-od.litmus.out
      2 ./auto/lb-lwr+r-oc+r-od.litmus.out
      2 ./auto/lb-lwr+r-oc+r-od+r-d.litmus.out
      2 ./auto/lb-lwr+r-oc+r-od+r-od.litmus.out
      2 ./auto/lb-lwr+r-oc+r-ov+r-d.litmus.out
      2 ./auto/lb-lww+r-a+r-a.litmus.out
      2 ./auto/lb-lww+r-a+r-a+r-a.litmus.out
      2 ./auto/lb-lww+r-a+r-d+r-oc.litmus.out
      2 ./auto/lb-lww+r-a+r-oc+r-d.litmus.out
      2 ./auto/lb-lww+r-a+r-oc+r-od.litmus.out
      2 ./auto/lb-lww+r-a+r-od+r-oc.litmus.out
      2 ./auto/lb-lww+r-a+r-ov+r-oc.litmus.out
      2 ./auto/lb-lww+r-oc.litmus.out
      2 ./auto/lb-lww+r-oc+r-d.litmus.out
      2 ./auto/lb-lww+r-oc+r-d+r-d.litmus.out
      2 ./auto/lb-lww+r-oc+r-d+r-od.litmus.out
      2 ./auto/lb-lww+r-oc+r-od.litmus.out
      2 ./auto/lb-lww+r-oc+r-od+r-d.litmus.out
      2 ./auto/lb-lww+r-oc+r-od+r-od.litmus.out
      2 ./auto/lb-lww+r-oc+r-ov+r-d.litmus.out
      2 ./rculitmusgen/lisa2c.sh

------------------------------------------------------------------------

