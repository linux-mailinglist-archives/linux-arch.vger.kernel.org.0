Return-Path: <linux-arch+bounces-3460-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 777068999FF
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 11:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B84C28513A
	for <lists+linux-arch@lfdr.de>; Fri,  5 Apr 2024 09:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198D0161B49;
	Fri,  5 Apr 2024 09:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="0AXR3Sr9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mv3acM2x";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z0+7rq6f";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lVccGfCI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4C7161318;
	Fri,  5 Apr 2024 09:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712310815; cv=none; b=mIY19KJ4UI01mSUrK/lBBv8QwjcJFR/GcJ6feTqejR8OgeII6d1QwMKbqIJTyzfDe2X7g00bTfU0bh5S7h+NSCXlfxA62h9QQpRYFxXo7OHTIxC2zyX5YlvA7BynzOoUeIx5UKv0uZ6mblIOhEjhQ3rfAySQg7m8fsf0PYzEYx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712310815; c=relaxed/simple;
	bh=iG4O7MMO9gnBVtJZSYs1Hq2UvQRfp2O+8N10zEhPJQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTPANW0a0wV97PEgXPLudGyv3gNtEeQLhpJBkNuIi948I7CrYZ9fV9IXUO9CHKdzxmRFDqRx0rKF1oJDd3VteF75R6+ZlJBtipMSwfwrUNbT5Fxu40VGFfJ1EKKvwLJtoCIlZQ86OWSzO0Xlf9VMAHYCMnI1p2jWMX1LE6MYm2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=0AXR3Sr9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mv3acM2x; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z0+7rq6f; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lVccGfCI; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 65BF721A2E;
	Fri,  5 Apr 2024 09:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712310809; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxLJbVvPYqfzG83pwvoYNu5wMFXj9ZScFtz4XZeGAUk=;
	b=0AXR3Sr9XfI+c7rTPImw5uCIqUd0/09qhqdILdsZtrOOOTHNThWW8IWO2LavomosrDlGR4
	r5zcQ7aU/RB1e9VhO2PeMNtjvZCEdKzHqupTEPNLaoS68JZ7HFWh4OFd1ckPqsmFOlBB7H
	mcwM4kvxTwfCAYfvPvAMLZZtKWx5vB8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712310809;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxLJbVvPYqfzG83pwvoYNu5wMFXj9ZScFtz4XZeGAUk=;
	b=mv3acM2xzaAtD0goPoMaKRbxprQYlRRQRdWeBSj+XgsIgB6XYwFswsOsyAWM2lrdH+uuj0
	DSsBpoDlTl2n1rDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1712310808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxLJbVvPYqfzG83pwvoYNu5wMFXj9ZScFtz4XZeGAUk=;
	b=Z0+7rq6fcjYyrOGJFwhu7EPjxeB2YzEP6/GI4QJE77wXmTpoCFc1mE9dE1Bj/PEGY1tu49
	ESTilKNYDaC1JrKhdHCnLw44UtjznYqGrEfN+CtNGBPA2Dt9MhQgjmAw2Ok0XXX+qUvUQJ
	M0o1kG24lT0V2nbGjew3Qb50utPv0T0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1712310808;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kxLJbVvPYqfzG83pwvoYNu5wMFXj9ZScFtz4XZeGAUk=;
	b=lVccGfCILCM4svVbHjo2v2GSsNkbxp/3kUm/GIkdwdP1GGRDcHYdF3Ew32qMBI0ItKMWtc
	2n16V0vgVrwCANAQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 5716C139F1;
	Fri,  5 Apr 2024 09:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id 2Ig+FRjKD2a3YAAAn2gu4w
	(envelope-from <jack@suse.cz>); Fri, 05 Apr 2024 09:53:28 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0505DA0814; Fri,  5 Apr 2024 11:53:27 +0200 (CEST)
Date: Fri, 5 Apr 2024 11:53:27 +0200
From: Jan Kara <jack@suse.cz>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, joro@8bytes.org,
	will@kernel.org, trond.myklebust@hammerspace.com, anna@kernel.org,
	arnd@arndb.de, herbert@gondor.apana.org.au, davem@davemloft.net,
	jikos@kernel.org, benjamin.tissoires@redhat.com, tytso@mit.edu,
	jack@suse.com, dennis@kernel.org, tj@kernel.org, cl@linux.com,
	jakub@cloudflare.com, penberg@kernel.org, rientjes@google.com,
	iamjoonsoo.kim@lge.com, vbabka@suse.cz, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org,
	linux-acpi@vger.kernel.org, acpica-devel@lists.linux.dev,
	linux-arch@vger.kernel.org, linux-crypto@vger.kernel.org,
	bpf@vger.kernel.org, linux-input@vger.kernel.org,
	linux-ext4@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH 1/1] mm: change inlined allocation helpers to account at
 the call site
Message-ID: <20240405095327.ufsimeplwahh6mem@quack3>
References: <20240404165404.3805498-1-surenb@google.com>
 <Zg7dmp5VJkm1nLRM@casper.infradead.org>
 <CAJuCfpHbTCwDERz+Hh+aLZzNdtSFKA+Q7sW-xzvmFmtyHCqROg@mail.gmail.com>
 <CAJuCfpHy5Xo76S7h9rEuA3cQ1pVqurL=wmtQ2cx9-xN1aa_C_A@mail.gmail.com>
 <Zg8qstJNfK07siNn@casper.infradead.org>
 <jb25mtkveqf63bv74jhynf6ncxmums5s37esveqsv52yurh4z7@5q55ttv34bia>
 <20240404154150.c25ba3a0b98023c8c1eff3a4@linux-foundation.org>
 <jpaw4hdd73ngt7mvtcdryqscivx6m2ic76ikfkcopceb47becp@vox5czt5bec3>
 <CAJuCfpF10COO2nh1nt3CcaZOFe4iSXszsup+a0qAEQ1ngyy5tQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpF10COO2nh1nt3CcaZOFe4iSXszsup+a0qAEQ1ngyy5tQ@mail.gmail.com>
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[39];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_RATELIMIT(0.00)[to_ip_from(RLinodumkc3pofpwycnya9d5a9)];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[c-faq.com:url,suse.com:email,imap2.dmz-prg2.suse.org:helo,imap2.dmz-prg2.suse.org:rdns,linux.dev:email]
X-Spam-Score: -3.80
X-Spam-Flag: NO

On Thu 04-04-24 16:16:15, Suren Baghdasaryan wrote:
> On Thu, Apr 4, 2024 at 4:01 PM Kent Overstreet
> <kent.overstreet@linux.dev> wrote:
> >
> > On Thu, Apr 04, 2024 at 03:41:50PM -0700, Andrew Morton wrote:
> > > On Thu, 4 Apr 2024 18:38:39 -0400 Kent Overstreet <kent.overstreet@linux.dev> wrote:
> > >
> > > > On Thu, Apr 04, 2024 at 11:33:22PM +0100, Matthew Wilcox wrote:
> > > > > On Thu, Apr 04, 2024 at 03:17:43PM -0700, Suren Baghdasaryan wrote:
> > > > > > Ironically, checkpatch generates warnings for these type casts:
> > > > > >
> > > > > > WARNING: unnecessary cast may hide bugs, see
> > > > > > http://c-faq.com/malloc/mallocnocast.html
> > > > > > #425: FILE: include/linux/dma-fence-chain.h:90:
> > > > > > + ((struct dma_fence_chain *)kmalloc(sizeof(struct dma_fence_chain),
> > > > > > GFP_KERNEL))
> > > > > >
> > > > > > I guess I can safely ignore them in this case (since we cast to the
> > > > > > expected type)?
> > > > >
> > > > > I find ignoring checkpatch to be a solid move 99% of the time.
> > > > >
> > > > > I really don't like the codetags.  This is so much churn, and it could
> > > > > all be avoided by just passing in _RET_IP_ or _THIS_IP_ depending on
> > > > > whether we wanted to profile this function or its caller.  vmalloc
> > > > > has done it this way since 2008 (OK, using __builtin_return_address())
> > > > > and lockdep has used _THIS_IP_ / _RET_IP_ since 2006.
> > > >
> > > > Except you can't. We've been over this; using that approach for tracing
> > > > is one thing, using it for actual accounting isn't workable.
> > >
> > > I missed that.  There have been many emails.  Please remind us of the
> > > reasoning here.
> >
> > I think it's on the other people claiming 'oh this would be so easy if
> > you just do it this other way' to put up some code - or at least more
> > than hot takes.
> >
> > But, since you asked - one of the main goals of this patchset was to be
> > fast enough to run in production, and if you do it by return address
> > then you've added at minimum a hash table lookup to every allocate and
> > free; if you do that, running it in production is completely out of the
> > question.
> >
> > Besides that - the issues with annotating and tracking the correct
> > callsite really don't go away, they just shift around a bit. It's true
> > that the return address approach would be easier initially, but that's
> > not all we're concerned with; we're concerned with making sure
> > allocations get accounted to the _correct_ callsite so that we're giving
> > numbers that you can trust, and by making things less explicit you make
> > that harder.
> >
> > Additionally: the alloc_hooks() macro is for more than this. It's also
> > for more usable fault injection - remember every thread we have where
> > people are begging for every allocation to be __GFP_NOFAIL - "oh, error
> > paths are hard to test, let's just get rid of them" - never mind that
> > actually do have to have error paths - but _per callsite_ selectable
> > fault injection will actually make it practical to test memory error
> > paths.
> >
> > And Kees working on stuff that'll make use of the alloc_hooks() macro
> > for segregating kmem_caches.
> 
> Yeah, that pretty much summarizes it. Note that we don't have to make
> the conversions in this patch and accounting will still work but then
> all allocations from different callers will be accounted to the helper
> function and that's less useful than accounting at the call site.
> It's a sizable churn but the conversions are straight-forward and we
> do get accurate, performant and easy to use memory accounting.

OK, fair enough. I guess I can live with the allocation macros in jbd2 if
type safety is preserved. But please provide a short summary of why we need
these macros (e.g. instead of RET_IP approach) in the changelog (or at
least a link to some email explaining this if the explanation would get too
long). Because I was wondering about the same as Andrew (and yes, this is
because I wasn't really following the huge discussion last time).

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

