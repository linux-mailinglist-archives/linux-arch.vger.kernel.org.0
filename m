Return-Path: <linux-arch+bounces-5642-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFF693D5F8
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 17:22:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8C66286528
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 15:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658D17838E;
	Fri, 26 Jul 2024 15:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="q3elkxZE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="947VmE0r";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Kqbq+to/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UfWcXsqC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D589418E1E;
	Fri, 26 Jul 2024 15:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722007363; cv=none; b=ASiskY44UpoM4MyCCFDsuQpprSmB+D0yDilBMOH85+F3EOiGEB3K67OcbyLSAOI/mjkRSPU3sAM93PTsVKlUVZ61pMPfCvkrn9By1IEmP7852nJ7E8IPVWTBjLcsjcFroSKF6v9qx1JUIv9MosgZmu+soRcRQIEUg4z+a0BEzbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722007363; c=relaxed/simple;
	bh=5ea6J4F3xTYQI+FVtmFYyRykx9btGmI+rnvRxLuvejI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+vo8voAcEsgT3R7IxDUF/UqOD+GTSM1tRvCYGyP3ZB32/CmrZE3/v7PU97gY5Lg67TvN8pmdnSYIIZ6VA5ZNjzMhw2Kq9YRUmo8gnslezuEYYjBvbaGWKZrw9jX+S4T7uEoQN6ti5i+avvFXvYr5BI/YtUBkfc3LI2GhZvJv2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=q3elkxZE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=947VmE0r; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Kqbq+to/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UfWcXsqC; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CC7DE219BF;
	Fri, 26 Jul 2024 15:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722007360;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr6jgka+gDBT3QQ7bb9PNkdpnMtXeZV68l1U6OfFaqc=;
	b=q3elkxZESedwoEe0iUED5lOQbJV9ZRWPQltOdic0NpXAtJY/EiN5gMmIEUiMWY9yppgng5
	6vHX74SCzYTqbJL/8+DyEy2mSuBbbVz+24XQLb9uAEUi4AUC1Pe9f11DGPMiyjFaWT3w6p
	Cpc3BoFxDn3frW7nxPk+2nBnWffG11I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722007360;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr6jgka+gDBT3QQ7bb9PNkdpnMtXeZV68l1U6OfFaqc=;
	b=947VmE0rAIutWyXfUgWwi60aZCVln6pfnucIC1mlfeI9IcD5vdNjGGIV1jU6UR7rbKu34N
	JxqUY9Is45qfwpAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722007358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr6jgka+gDBT3QQ7bb9PNkdpnMtXeZV68l1U6OfFaqc=;
	b=Kqbq+to/EyF/FOIb4JQK+wpQDcfHcU09pojkYOkJXt/Nj62vQ62DbUIwyDMnE76fU7JoRl
	h2/v3chroOC3NZ0Ewi2bHzSOBLy8opglAIvdt7tBQnwQtWM5iDPZvq94Ewf73G7p1w2Q0p
	uAi9NZ1qkSPCJ9XKF0LjIlxsF5wjiKw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722007358;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nr6jgka+gDBT3QQ7bb9PNkdpnMtXeZV68l1U6OfFaqc=;
	b=UfWcXsqCQv+u627gdDOwb0Qe5lzmjOGQVAtU2Gfh5f+O7bTWC5rDTkzRE1A+toGuwfcx7G
	OZMIEwnitR8aabAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9485D1396E;
	Fri, 26 Jul 2024 15:22:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cGYKJD6/o2bKLgAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 15:22:38 +0000
Date: Fri, 26 Jul 2024 17:22:37 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Youling Tang <youling.tang@linux.dev>, kreijack@inwind.it,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <20240726152237.GH17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <0a63dfd1-ead3-4db3-a38c-2bc1db65f354@linux.dev>
 <ZqEhMCjdFwC3wF4u@infradead.org>
 <895360e3-97bb-4188-a91d-eaca3302bd43@linux.dev>
 <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqOs84hdYkSV_YWd@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[inwind.it];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,inwind.it,arndb.de,kernel.org,fb.com,toxicpanda.com,suse.com,mit.edu,dilger.ca,vger.kernel.org,lists.sourceforge.net,kylinos.cn];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jul 26, 2024 at 07:04:35AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 26, 2024 at 04:54:59PM +0800, Youling Tang wrote:
> > Based on this patch, we may need to do these things with this
> >
> >
> > 1. Change the order of *.o in the Makefile (the same order as before the
> > change)
> 
> While we'll need to be careful, we don't need to match the exact
> order.  Most of the calls simply create slab caches / mempools and
> similar things and the order for those does not matter at all.
> 
> Of course the register_filesytem calls need to be last, and sysfs
> registration probably should be second to last, but for the vast
> amount of calls the order does not matter as long as it is unwound
> in reverse order.
> 
> > 2. We need to define module_subinit through the ifdef MODULE
> > distinction,
> 
> Yes.
> 
> > When one of the subinit runs in a module fails, it is difficult
> > to rollback execution of subexit.
> 
> By having both section in the same order, you an just walk the
> exit section backwards from the offset that failed.  Of course that
> only matters for the modular case as normal initcalls don't get
> unwound when built-in either.
> 
> > 4. The order in which subinit is called is not intuitively known
> > (although it can be found in the Makefile).
> 
> Link order through make file is already a well known concept due to
> it mattering for built-in code.

All of this sounds overengineered for something that is a simple array
and two helpers. The code is not finalized so I'll wait for the next
version but specific file order in makefile and linker tricks seems
fragile and I'm not sure I want this for btrfs.

