Return-Path: <linux-arch+bounces-12007-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50E4EABD220
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C092B3A948A
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 08:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90762609DF;
	Tue, 20 May 2025 08:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="S5Wkh7oL";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="znplM6+X";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CJFHxz9D";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0GGXyUr6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3976F21CC48
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 08:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747730340; cv=none; b=uYWHtwkNbnO+67uX6A/6gKPICSBJl2mXDMwDJWXv8XxjGia0EPCEGNJyMWx8F6TxJiL7VnRDqT/QIwjdGZmnmW5NlBui+sc12Vvfw4elNmhEqSYxb9+H0853ikQhOhu3VcGFplMx8RVuBcg24/t7Ng1OQArtFr5HmxOv4nVis3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747730340; c=relaxed/simple;
	bh=4TGT2BxXcw1kl67CHogoMdBdlhYQOvV8UOgFydhSV9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WnYK0LdfoSIaIWnnkCsm1d8aDaBqe9BcHJFjVaDbJNi4xJnAdZzY+h/0URdx0WWYbkFcuNN73qcpfHlYmqSz80moSFW4atratPPOG3NrYY+y6lBN3gD9NI7VS2HaRsJmHQ7wHNSDurjJEr+qvwoHcI5kbpvDwJzYCdyYLMDmE0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=S5Wkh7oL; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=znplM6+X; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=CJFHxz9D; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0GGXyUr6; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id D9B702065E;
	Tue, 20 May 2025 08:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747730337; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVYlKjN4zUbpXRhJAkTH7z/CxKiGHqQXzuN/0SLxarg=;
	b=S5Wkh7oLEB79AG9GvXwtSeuvm1Zs6tw/Rh+C9aqjEEb/dDcZ45tFzmUpU1nfBRv0qR/VBm
	tijgRsBh8ni8KgUswuHV937a5wDKtEBxdAMayoAEnBQdyy1mTzKqIlJH8kqZIk2oOKw9jZ
	zO+7jbg0I8rj1d4QPyC9FlVEd+atdzw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747730337;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVYlKjN4zUbpXRhJAkTH7z/CxKiGHqQXzuN/0SLxarg=;
	b=znplM6+XJeTxQbRmMiKHe4Y+wEj7An18tt3bokMp6AeIJCr0afJsY5s7K/2CB5SBoxh31m
	WbQ5ayBn9Rjx9BAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CJFHxz9D;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=0GGXyUr6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747730335; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVYlKjN4zUbpXRhJAkTH7z/CxKiGHqQXzuN/0SLxarg=;
	b=CJFHxz9DD7J4lxijpdZiCPXYbXis1d0zyu8wHB3c6HHFWtu346uEZybT+Rlj5tC/ATOMHG
	2P+B/otJj9iHw1jmBHWsdtU5u931OHlwRcwFsegRKfNubDHoWPmWhdGirG9hYq5qM8dk0L
	eCps+KPLwGzP1BaSK7fBc47f2JPZex8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747730335;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OVYlKjN4zUbpXRhJAkTH7z/CxKiGHqQXzuN/0SLxarg=;
	b=0GGXyUr69SQbPvt64kne5uiuZbabsAkZKrhFd1y3PuhTKXAsGwofLTz81P+D6YePb3BkQ8
	WnxzOMdg84Bt2GAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9CA5A13888;
	Tue, 20 May 2025 08:38:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id GCUiJZ8/LGj9TAAAD6G6ig
	(envelope-from <pfalcato@suse.de>); Tue, 20 May 2025 08:38:55 +0000
Date: Tue, 20 May 2025 09:38:50 +0100
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
Message-ID: <czd62f2vzwv6fow4ikvzlkjdj5odhc3nhtc72onwip52baobg5@yc5pjiqoqnh4>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <617413860ff194dfb1afedb175b2d84a457e449d.1747686021.git.lorenzo.stoakes@oracle.com>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: D9B702065E
X-Spam-Score: -1.01
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.01 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,oracle.com,redhat.com,suse.cz,google.com,arndb.de,kernel.org,kvack.org,vger.kernel.org,gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.de:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim]

On Mon, May 19, 2025 at 09:52:41PM +0100, Lorenzo Stoakes wrote:
> It's useful in certain cases to be able to default-enable an madvise() flag
> for all newly mapped VMAs, and for that to survive fork/exec.
> 
> The natural place to specify something like this is in an madvise()
> invocation, and thus providing this functionality as a flag to
> process_madvise() makes sense.
> 
> We intentionally limit this only to flags that we know should function
> correctly without issue, and to be conservative about this, so we initially
> limit ourselves only to MADV_HUGEPAGE, MADV_NOHUGEPAGE, that is - setting
> the VM_HUGEPAGE, VM_NOHUGEPAGE VMA flags.
> 
> We implement this functionality by using the mm_struct->def_flags field.

This seems super specific. How about this:

- PMADV_FUTURE (mirrors MCL_FUTURE). This only applies the flag to future VMAs in the current process.
- PMADV_INHERIT_FORK. This makes it so the flag is propagated to child processes (does not imply PMADV_FUTURE)
- PMADV_INHERIT_EXEC. This makes it so the flag is propagated through the execve boundary
  (and this is where we'd filter for 'safe' flags, at least through the secureexec boundary). Does not imply
  FUTURE nor INHERIT_FORK.

and, while we're at it, rename PMADV_ENTIRE_ADDRESS_SPACE to PMADV_CURRENT, to align it with MCL_CURRENT.

Thoughts?

-- 
Pedro

