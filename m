Return-Path: <linux-arch+bounces-12014-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29CE7ABD712
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 13:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 364FB1BA08A6
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 11:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF12750E5;
	Tue, 20 May 2025 11:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTCJx9D6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOipSqIj";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ZTCJx9D6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xOipSqIj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E531126738B
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 11:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747741280; cv=none; b=MZyo9kGEwPMkDraHo0OF0gmUL2+nHIPFYEMjbYDrR22M/CUnCgMcm6ZRo7lrxtBWpwCqtXfF8+CGXygG0oSjdlKVRFJXkzksNVX7jaUmYA1pVVvfO8JVnfurJsPWuaafZZBS7whnWkNIdB4nBcO3fzupG4tVtuBnUFmUelIh8t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747741280; c=relaxed/simple;
	bh=E8r9RWdFrcTxAoPTPdSFvWx+S9pJA1DmWFvEP1M7JWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QC4tABYCqm8v3t51EQsIyX1Fd0See5yWxfSWE/B5pm+Dha6hKIJArpExJ5ZL+ryjg9g/VMwqY4yhPrY262JPeSBDTd8rQGm6wAiTbTA/QDJzn+lToBCjUpzrqtalTcg3rlwnWsRYl7wa04X3mKUvMIO7xTiz0Ac/kFhHDHqteu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTCJx9D6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOipSqIj; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=ZTCJx9D6; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=xOipSqIj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0BDB620687;
	Tue, 20 May 2025 11:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m2C8j6n/4hnJfqAn276hwrxDOhbyeI9i1wZW36wyC8=;
	b=ZTCJx9D6Viz3UpQ90BKvRqWWBnc56CvG4cCpMe1QqrViFPaLNO28D07lE0K4qTMqTXtJiL
	OsKUdf/r8B2/7UA7e4+M6kW+w92/rRLxWvUyzFmTktimM8wsj7TcI6JMOYZdQLwI7Sejoy
	SMjWnB1eR7fhtdvV7GYdjljFblBPwyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m2C8j6n/4hnJfqAn276hwrxDOhbyeI9i1wZW36wyC8=;
	b=xOipSqIjQa9bRhV9Sy3AnYuBCGyjt+y2+BQY+DwCXU0OnlDlho/366rdEig0Dq5wHdjEnh
	+RKFYl7nj3A6JsCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747741277; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m2C8j6n/4hnJfqAn276hwrxDOhbyeI9i1wZW36wyC8=;
	b=ZTCJx9D6Viz3UpQ90BKvRqWWBnc56CvG4cCpMe1QqrViFPaLNO28D07lE0K4qTMqTXtJiL
	OsKUdf/r8B2/7UA7e4+M6kW+w92/rRLxWvUyzFmTktimM8wsj7TcI6JMOYZdQLwI7Sejoy
	SMjWnB1eR7fhtdvV7GYdjljFblBPwyk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747741277;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0m2C8j6n/4hnJfqAn276hwrxDOhbyeI9i1wZW36wyC8=;
	b=xOipSqIjQa9bRhV9Sy3AnYuBCGyjt+y2+BQY+DwCXU0OnlDlho/366rdEig0Dq5wHdjEnh
	+RKFYl7nj3A6JsCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C228113A3E;
	Tue, 20 May 2025 11:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WOx5LlxqLGiSewAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 20 May 2025 11:41:16 +0000
Date: Tue, 20 May 2025 12:41:00 +0100
From: Pedro Falcato <pfalcato@suse.de>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R . Howlett" <Liam.Howlett@oracle.com>, David Hildenbrand <david@redhat.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>, 
	Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 4/5] mm/madvise: add PMADV_SET_FORK_EXEC_DEFAULT
 process_madvise() flag
Message-ID: <mnaqmyzodrrzzaahupzj5djayqpnt7jojqa5yaay2jdpnnwfx3@b2s4twil5cvl>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
 <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
 <da1281bb-e49a-40f9-ac11-f976358e618e@lucifer.local>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1281bb-e49a-40f9-ac11-f976358e618e@lucifer.local>
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,redhat.com,suse.cz,google.com,arndb.de,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -3.80
X-Spam-Level: 

On Tue, May 20, 2025 at 11:21:33AM +0100, Lorenzo Stoakes wrote:
> On Tue, May 20, 2025 at 09:38:50AM +0100, Pedro Falcato wrote:
> > On Mon, May 19, 2025 at 09:52:41PM +0100, Lorenzo Stoakes wrote:
> > > It's useful in certain cases to be able to default-enable an madvise() flag
> > > for all newly mapped VMAs, and for that to survive fork/exec.
> > >
> > > The natural place to specify something like this is in an madvise()
> > > invocation, and thus providing this functionality as a flag to
> > > process_madvise() makes sense.
> > >
> > > We intentionally limit this only to flags that we know should function
> > > correctly without issue, and to be conservative about this, so we initially
> > > limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
> > > the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.
> > >
> > > We implement this functionality by using the mm_struct->def_flags field.
> >
> > This seems super specific. How about this:
> >
> > - PMADV_FUTURE (mirrors MCL_FUTURE). This only applies the flag to future VMAs in the current process.
> > - PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
> > - PMADV_INHERIT_EXEC. This makes it so the flag is propagated through the execve boundary
> >   (and this is where we'd filter for 'safe' flags, at least through the secureexec boundary). Does not imply
> >   FUTURE nor INHERIT_FORK.
> 
> I don't know how we could implement separate current process, fork, exec, fork/exec.
> mm->def_flags is propagated this way automatically.
> 
> And again on the security stuff, I think the correct answer is to require sys
> admin capability to be able to use this option _at all_. This simplifies
> everything.
> 
> To have this kind of thing we'd have to add a whole new mechanism, literally
> just for this, and I'd really rather not generate brand new mm_struct flags for
> every possible mode (in fact that would probably makes the whole thing
> intractible), or add a new field there for this.
> 
> The idea is that we get the advantages of an improved madvise interface, while
> also providing the interface Usama wants without having to add some hideous
> prctl() whose logic is disconnected from the rest of madvise(), while being, in
> effect, a 'default madvise() for new mappings'.
> 
> So while specific to the case, nothing prevents us in future adding more
> functionality if we want.
> 
> We could also potentially:
> 
> - add PMADV_SET_DEFAULT (I'm iffy about PMADV_FUTURE... but whichever we go with)
> - add PMADV_INHERIT_FORK
> - add PMADV_INHERIT_EXEC
> 
> And only support PMADV_SET_DEFAULT | PMADV_INHERIT_FORK | PMADV_INHERIT_EXEC for
> now.
>
> THen we could have the security semantics you specify (require cap sys admin on
> PMADV_INHERIT_EXEC) but have that propagate to the only supported case.
> 
> What do you think?
>

If you don't want to add new fields, this option seems fine.
And then if any other usecase pops up, we're ready.
 
> >
> > and, while we're at it, rename PMADV_ENTIRE_ADDRESS_SPACE to PMADV_CURRENT, to align it with MCL_CURRENT.
> 
> I'm not sure making the mlock()/madvise() stuff analagous is a good idea, as
> they have different semantics. I'd rather keep these flags descriptive. Though
> I'm open to alternative naming of course...

Semantics are similar I think? And I do think getting shorter names is a good
idea, however I won't insist too hard on this.

-- 
Pedro

