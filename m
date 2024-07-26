Return-Path: <linux-arch+bounces-5645-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83EEF93DAC5
	for <lists+linux-arch@lfdr.de>; Sat, 27 Jul 2024 00:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 080131F23AE0
	for <lists+linux-arch@lfdr.de>; Fri, 26 Jul 2024 22:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E79114F133;
	Fri, 26 Jul 2024 22:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A1eLqX/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYynmnwN";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="A1eLqX/o";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LYynmnwN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D81114F118;
	Fri, 26 Jul 2024 22:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722033956; cv=none; b=NM/692P0HDrSpeSfmvhwjb9cng/TTsh1bOqwnoFYUrab/4GOmyccmkmZTXDykbmHOLlSDDkmokoYZa3l4AruQ6zgioGErReBVaYR4SnH9oYjtgxO9SmKT4RmPaZ85jelCjXD9AZLrMuc0uzbK+VaeeEB7Pk8AGtpCdTLRZ/1eIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722033956; c=relaxed/simple;
	bh=hOE0Z1kvdh6uIGZYovKHSoP1hXB54DzI0w7nD3XgJXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B6nJ4ZUXMYbdlWTNuM7K+JtzDaegZdT1Ae+iz66SxGwDvLcgMsRLFs+zvQtKq1bihinkFmQZ9Lt31euNi3r14z7+DU8plQboO117A3T9SBOxXDpysXNdI84oYXvIvl2MzYgmbk5u1n99CLU2dRa4AF3XJBsZau+uYibMI5mmMm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A1eLqX/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYynmnwN; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=A1eLqX/o; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LYynmnwN; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 25F8221B17;
	Fri, 26 Jul 2024 22:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722033952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEH8Vk8Kw3nyR7i95KJItR4+alXownkC8UVtnwJo0OM=;
	b=A1eLqX/o3M7AFIEpMfRvh9UI16KN1MarYEfSLxUe0RcDFUcJJTMzohG8/Enihr7MMxtUYm
	fHpQKSb1thuoBT46Frp0arz9Rhw/cNoJsgJ7SfaIpM4cKz59OTUHO71Eoq5vg/ZKF2awYF
	uqTQchb3NbuddeY6BjyQxGCicc6THvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722033952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEH8Vk8Kw3nyR7i95KJItR4+alXownkC8UVtnwJo0OM=;
	b=LYynmnwNijUa7IM9Aurpnga1UXlEZyj3zZYcbrjnAkj4RhzIKCV8IErRexqSNbnRzeKkac
	HzPg1zOUZPJ/i+Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1722033952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEH8Vk8Kw3nyR7i95KJItR4+alXownkC8UVtnwJo0OM=;
	b=A1eLqX/o3M7AFIEpMfRvh9UI16KN1MarYEfSLxUe0RcDFUcJJTMzohG8/Enihr7MMxtUYm
	fHpQKSb1thuoBT46Frp0arz9Rhw/cNoJsgJ7SfaIpM4cKz59OTUHO71Eoq5vg/ZKF2awYF
	uqTQchb3NbuddeY6BjyQxGCicc6THvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1722033952;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wEH8Vk8Kw3nyR7i95KJItR4+alXownkC8UVtnwJo0OM=;
	b=LYynmnwNijUa7IM9Aurpnga1UXlEZyj3zZYcbrjnAkj4RhzIKCV8IErRexqSNbnRzeKkac
	HzPg1zOUZPJ/i+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E52A4138A7;
	Fri, 26 Jul 2024 22:45:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k1NYNx8npGacGAAAD6G6ig
	(envelope-from <dsterba@suse.cz>); Fri, 26 Jul 2024 22:45:51 +0000
Date: Sat, 27 Jul 2024 00:45:42 +0200
From: David Sterba <dsterba@suse.cz>
To: Christoph Hellwig <hch@infradead.org>
Cc: Theodore Ts'o <tytso@mit.edu>, David Sterba <dsterba@suse.cz>,
	Youling Tang <youling.tang@linux.dev>, kreijack@inwind.it,
	Arnd Bergmann <arnd@arndb.de>, Luis Chamberlain <mcgrof@kernel.org>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
	Linux-Arch <linux-arch@vger.kernel.org>,
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	Youling Tang <tangyouling@kylinos.cn>
Subject: Re: [PATCH 1/4] module: Add module_subinit{_noexit} and
 module_subeixt helper macros
Message-ID: <20240726224542.GP17473@twin.jikos.cz>
Reply-To: dsterba@suse.cz
References: <ZqJjsg3s7H5cTWlT@infradead.org>
 <61beb54b-399b-442d-bfdb-bad23cefa586@app.fastmail.com>
 <ZqJwa2-SsIf0aA_l@infradead.org>
 <68584887-3dec-4ce5-8892-86af50651c41@libero.it>
 <ZqKreStOD-eRkKZU@infradead.org>
 <91bfea9b-ad7e-4f35-a2c1-8cd41499b0c0@linux.dev>
 <ZqOs84hdYkSV_YWd@infradead.org>
 <20240726152237.GH17473@twin.jikos.cz>
 <20240726175800.GC131596@mit.edu>
 <ZqPmPufwqbGOTyGI@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqPmPufwqbGOTyGI@infradead.org>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
X-Spam-Level: 
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	HAS_REPLYTO(0.30)[dsterba@suse.cz];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_ALL(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,suse.cz,linux.dev,inwind.it,arndb.de,kernel.org,fb.com,toxicpanda.com,suse.com,dilger.ca,vger.kernel.org,lists.sourceforge.net,kylinos.cn];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[inwind.it]
X-Spam-Flag: NO
X-Spam-Score: -3.80

On Fri, Jul 26, 2024 at 11:09:02AM -0700, Christoph Hellwig wrote:
> On Fri, Jul 26, 2024 at 01:58:00PM -0400, Theodore Ts'o wrote:
> > Yeah, that's my reaction as well.  This only saves 50 lines of code in
> > ext4, and that includes unrelated changes such as getting rid of "int
> > i" and putting the declaration into the for loop --- "for (int i =
> > ...").  Sure, that saves two lines of code, but yay?
> > 
> > If the ordering how the functions gets called is based on the magic
> > ordering in the Makefile, I'm not sure this actually makes the code
> > clearer, more robust, and easier to maintain for the long term.
> 
> So you two object to kernel initcalls for the same reason and would
> rather go back to calling everything explicitly?

No and not my call to do it for the kernel. Somebody probably had a
reason use the initcalls, there are probably practical reasons for that.
Quick grep shows there are thousands of initcalls scattered over the
whole code base, that does ask for some tricks because updating a single
file with explicit calls would be a nightmare. Unlike for a subsystem
inside one directory, like a filesystem.

