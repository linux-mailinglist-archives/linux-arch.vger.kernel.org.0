Return-Path: <linux-arch+bounces-9041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B989C605F
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 19:26:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E5EF21F2429C
	for <lists+linux-arch@lfdr.de>; Tue, 12 Nov 2024 18:26:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92036216459;
	Tue, 12 Nov 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n5U+LRIh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B982161FE;
	Tue, 12 Nov 2024 18:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435998; cv=none; b=AFQLyGFpkRBu0orLqJG911kG8IbXvlz5H7cXTcNoVv8e9l6a4Pm9J9FLdVWmXKWyO5KkoRAJD/bNTf5X91rVAw0YpFYIXmyy5q58nV4Md/AILIM0ZAP0J7zI72btvQKnCiGokAn0owQdRgl+iUakvcHS0H1ckFIBkm089EcHM4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435998; c=relaxed/simple;
	bh=+k+xazJIGWsZNMEpds/k53QfQTCdhfxkPLySez4LE18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnIrhQKPswfKyOWd0AfJufkxEQYl8Vh6BUSsacUgjFbdlnh2B3ICaEESsakQo6C4TiQZD712BhmUAku1U6GqUWS6vP14Uj2k9KXJ+yiTrauYBou259VVPmxmRa+Fo3gULTdoyA6Uodc6MKYtx4fhghHjbuJjsDRfqQEdQtE02CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n5U+LRIh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3523EC4CECD;
	Tue, 12 Nov 2024 18:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731435998;
	bh=+k+xazJIGWsZNMEpds/k53QfQTCdhfxkPLySez4LE18=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=n5U+LRIhCMYo75eL8Sr2nV5MaLYGBrX+1rI9p2Rl/cmj2K0Hy6U9JwvAuy1FShAaD
	 MzSmxrAfdO98KGMvaAl5zOa23OXRllVvOCFVl77jiHiqQROcjnAaN0GsKqvtDq4HrT
	 xuYA1tA5ioeIr1e83XLPYbmbNF8KA+JEVdQG8LjzbCZcyqdCo2jiVG1HNvXajOb38e
	 ZwygvQZ9ZSQQNRih4aZUdHr/0RGtsZ566QZeVWcppB0kqDPNqaWGuYWQgapne3dtOs
	 zZVrOnlm18nsB5w0UPZnRjt43hrCa1GUWdql6rUZWi/5GDPPp5gxnU8ZbATWOvizFS
	 eIuz8pAaWbRKQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D2396CE0D89; Tue, 12 Nov 2024 10:26:37 -0800 (PST)
Date: Tue, 12 Nov 2024 10:26:37 -0800
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
Message-ID: <de5485b8-6d88-46f6-b982-cdfb3cf80a13@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20241111164248.1060-1-egyszeregy@freemail.hu>
 <69be42c9-331f-4fb5-a6ae-c2932ada0a47@paulmck-laptop>
 <8925322d-1983-4e35-82f9-d8b86d32e6a6@freemail.hu>
 <1a6342c9-e316-4c78-9a07-84f45cbebb54@paulmck-laptop>
 <ec6e297b-02fb-4f57-9fc1-47751106a7d2@freemail.hu>
 <5acaaaa0-7c17-4991-aff6-8ea293667654@paulmck-laptop>
 <a42da186-195c-40af-b4ee-0eaf6672cf2c@freemail.hu>
 <62634bbe-edd6-4973-a96a-df543f39f240@rowland.harvard.edu>
 <61075efa-8d53-455b-bba3-e88bbf4da0a5@paulmck-laptop>
 <75a5a694-1313-44b1-baff-d72559ac9039@rowland.harvard.edu>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <75a5a694-1313-44b1-baff-d72559ac9039@rowland.harvard.edu>

On Tue, Nov 12, 2024 at 10:35:25AM -0500, Alan Stern wrote:
> On Mon, Nov 11, 2024 at 08:20:05PM -0800, Paul E. McKenney wrote:
> > On Mon, Nov 11, 2024 at 07:59:33PM -0500, Alan Stern wrote:
> > > On Mon, Nov 11, 2024 at 10:15:30PM +0100, Szőke Benjamin wrote:
> > > > warning: the following paths have collided (e.g. case-sensitive paths
> > > > on a case-insensitive filesystem) and only one from the same
> > > > colliding group is in the working tree:
> > > > 
> > > >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+poonceLock+pombonce.litmus'
> > > >   'tools/memory-model/litmus-tests/Z6.0+pooncelock+pooncelock+pombonce.litmus'
> > > 
> > > I support the idea of renaming one of these files.  Not to make things 
> > > work on case-insensitive filesystems, but simply because having two 
> > > files with rather long (and almost nonsensical) names that are identical 
> > > aside from one single letter is an excellent way to confuse users.
> > > 
> > > Come on -- just look at the error report above.  Can you tell at a 
> > > glance, without going through and carefully comparing the two strings 
> > > letter-by-letter, exactly what the difference is?  Do you really think 
> > > anybody could?
> > > 
> > > I haven't looked to see if there are any other similar examples in the 
> > > litmus-tests directory, but if there are than they should be changed 
> > > too.
> > 
> > It does jump out at me,
> 
> Maybe this means you've spent too much of your life concentrating on 
> these files!  :-)

It is all too easy to argue that I have spent too much of my life
concentrating on files in general, not just these.  ;-)

> >  but even if it didn't, the usual use of tab
> > completion and copy/paste should make it a non-problem, not?
> 
> Those things help when people want to type in a filename.  They do not 
> help when people are trying to read the filenames, figure out what the 
> difference between them is, compare a name mentioned in one place to a 
> name mentioned in another place, or understand how the names are related 
> to the file contents.

All true, but beyond a certain point, we can solicit help from our
friendly nearby computer.  For example, create a temporary directory,
use "touch" to create the two names (based on copy and paste) in that
temporary directory, then let bash tab completion help us out.

But you make a good point later...

> > find . -print | tr 'A-Z' 'a-z' | sort | uniq -c | sort -k1nr | awk '{ if ($1 > 1) print }'
> > 
> > The output for the kernel and the github litmus repo are shown below.
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > For the kernel:
> > 
> > ------------------------------------------------------------------------
> > 
> >       2 ./include/uapi/linux/netfilter_ipv4/ipt_ecn.h
> >       2 ./include/uapi/linux/netfilter_ipv4/ipt_ttl.h
> >       2 ./include/uapi/linux/netfilter_ipv6/ip6t_hl.h
> >       2 ./include/uapi/linux/netfilter/xt_connmark.h
> >       2 ./include/uapi/linux/netfilter/xt_dscp.h
> >       2 ./include/uapi/linux/netfilter/xt_mark.h
> >       2 ./include/uapi/linux/netfilter/xt_rateest.h
> >       2 ./include/uapi/linux/netfilter/xt_tcpmss.h
> >       2 ./net/netfilter/xt_dscp.c
> >       2 ./net/netfilter/xt_hl.c
> >       2 ./net/netfilter/xt_rateest.c
> >       2 ./net/netfilter/xt_tcpmss.c
> 
> Those are all fine.  The filenames are nice and short, and the case 
> differences really do stand out because they affect entire words, not 
> just a single letter in the middle of a long string of letters.
> 
> >       2 ./tools/memory-model/litmus-tests/z6.0+pooncelock+pooncelock+pombonce.litmus
> 
> This stands for the files we're talking about, right?  It needs help.

We do have a rule for the filenames in that directory that most of
them follow (I am looking at *you*, "dep+plain.litmus"!).  So we have
a few options:

1.	Status quo.  (How boring!!!)

2.	Come up with a better rule mapping the litmus-test file
	contents to the filename, and rename things to follow that rule.
	(Holy bikeshedding, Batman!)

3.	Keep it simple and keep the current rule, but make the
	combination of spin_lock() and smp_mb__after_spinlock()
	have a greater Hamming distance from "lock".  Szőke's
	patch changed only one of the filenames containing "Lock".
	(Bikeshedding, but narrower scope.)

4.	One of the above, but bring the litmus tests not following
	the rule into compliance.

5.	Give up on the idea of the name reflecting the contents of the
	file, and just number them or something.  (More bikeshedding
	and a different form of confusion.)

6.	#5, but accompanied by some tool or script that allows easy
	searching of the litmus tests by pattern of interaction.
	(Easy for *me* to say!)

7.	Something else entirely.

Thoughts?

> > ------------------------------------------------------------------------
> > 
> > For the github litmus repo, almost all of which are automatically
> > generated:
> 
> I'm not so concerned about these.  A litmus test repo isn't in the same 
> category as a kernel source directory.  Maybe it wouldn't hurt to make 
> some of them more distinguishable (I haven't looked at the original 
> names to tell), but they're not our problem here and now.

Plus any changes would require corresponding changes to the scripts
generating them, which I currently lack both enthusiasm and time for.  ;-)

							Thanx, Paul

