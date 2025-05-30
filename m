Return-Path: <linux-arch+bounces-12153-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13DDFAC8C24
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 12:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8C1B4E1909
	for <lists+linux-arch@lfdr.de>; Fri, 30 May 2025 10:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6ED6218ADE;
	Fri, 30 May 2025 10:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjgckr0N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="grqEvK/Z";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gjgckr0N";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="grqEvK/Z"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CB41AC891
	for <linux-arch@vger.kernel.org>; Fri, 30 May 2025 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748601099; cv=none; b=Zd1/6YJsh8cGWdHF4h2XgsFEdJopFlRJwy75cH9AZNuRJQhTIoh5UXN+FrSsagJ8he0Lx2ZzsEbvnsrF2RnjAkA8g93LoE11UVNERCDa3KBHJBCP43e3xVRXvNgSV2NBS+YXCL+EFSAwoKGhBTPjufTIVKotGocsBd/XIvL/l5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748601099; c=relaxed/simple;
	bh=qHE3qLwYIjhl6eTb7NisuYHjTm89pZJtRPfwwjchJfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3Kb+mOn+QdCLFjvHiZ4YyhLfQN6NaMxMCp5CeDP2O2AJdsKVvSYN+ZQpNH0WVjOI8w+bcd9EAOnKxlE6MVflGu5hMeDWQ2b2cnWcxAKfH1D5jjBTuGY8Fwg4zeOrzV+TFvPXug3zsW/6OIxEUyjFXTgcj3KpK2NyAGPV5JxzrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjgckr0N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=grqEvK/Z; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=gjgckr0N; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=grqEvK/Z; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2E8851F454;
	Fri, 30 May 2025 10:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748601096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLEbuXz0MVeLf1z1ztoUH0xIv4W07L13Oz4jUnnCj00=;
	b=gjgckr0NkJ919yfPSlVFZj8szQ/QSF49Mts9FN0oYXWKlU3624GELPkEgltC7PVOL8vP9s
	QsK7UB967rCqYyecAHaR5DiOE2xSu8xOuEwzTfSjzAai6g576DtjBj/97necoSQE04O/9B
	uVoz2gpgMB+ecdRCJvZ/KdB2IU+ZWXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748601096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLEbuXz0MVeLf1z1ztoUH0xIv4W07L13Oz4jUnnCj00=;
	b=grqEvK/ZN2ybLU6d1J2f67ZFSe4JhZYED4ngy4MrUPwv15moWiGOs7cAZwcyKFLFEJjUm8
	anLZMxr/A3X7MNDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=gjgckr0N;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="grqEvK/Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1748601096; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLEbuXz0MVeLf1z1ztoUH0xIv4W07L13Oz4jUnnCj00=;
	b=gjgckr0NkJ919yfPSlVFZj8szQ/QSF49Mts9FN0oYXWKlU3624GELPkEgltC7PVOL8vP9s
	QsK7UB967rCqYyecAHaR5DiOE2xSu8xOuEwzTfSjzAai6g576DtjBj/97necoSQE04O/9B
	uVoz2gpgMB+ecdRCJvZ/KdB2IU+ZWXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1748601096;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=xLEbuXz0MVeLf1z1ztoUH0xIv4W07L13Oz4jUnnCj00=;
	b=grqEvK/ZN2ybLU6d1J2f67ZFSe4JhZYED4ngy4MrUPwv15moWiGOs7cAZwcyKFLFEJjUm8
	anLZMxr/A3X7MNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A42013889;
	Fri, 30 May 2025 10:31:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pQH1AQiJOWh3BAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 30 May 2025 10:31:36 +0000
Message-ID: <0aeb6d8b-2abb-43a7-b47d-448f37f8a3bf@suse.cz>
Date: Fri, 30 May 2025 12:31:35 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DISCUSSION] proposed mctl() API
Content-Language: en-US
To: Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 David Hildenbrand <david@redhat.com>, Jann Horn <jannh@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Christian Brauner <brauner@kernel.org>,
 SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>,
 Mike Rapoport <rppt@kernel.org>, Barry Song <21cnbao@gmail.com>,
 linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 Pedro Falcato <pfalcato@suse.de>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <aDh9LtSLCiTLjg2X@casper.infradead.org>
 <20250529211423.GA1271329@cmpxchg.org>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 m6M14QORSWTLRg==
In-Reply-To: <20250529211423.GA1271329@cmpxchg.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[oracle.com,linux-foundation.org,linux.dev,redhat.com,google.com,arndb.de,kernel.org,gmail.com,kvack.org,vger.kernel.org,suse.de];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 2E8851F454
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: -4.51

On 5/29/25 23:14, Johannes Weiner wrote:
> On Thu, May 29, 2025 at 04:28:46PM +0100, Matthew Wilcox wrote:
>> Barry's problem is that we're all nervous about possibly regressing
>> performance on some unknown workloads.  Just try Barry's proposal, see
>> if anyone actually compains or if we're just afraid of our own shadows.
> 
> I actually explained why I think this is a terrible idea. But okay, I
> tried the patch anyway.
> 
> This is 'git log' on a hot kernel repo after a large IO stream:
> 
>                                      VANILLA                      BARRY
> Real time                 49.93 (    +0.00%)         60.36 (   +20.48%)
> User time                 32.10 (    +0.00%)         32.09 (    -0.04%)
> System time               14.41 (    +0.00%)         14.64 (    +1.50%)
> pgmajfault              9227.00 (    +0.00%)      18390.00 (   +99.30%)
> workingset_refault_file  184.00 (    +0.00%)    236899.00 (+127954.05%)
> 
> Clearly we can't generally ignore page cache hits just because the
> mmaps() are intermittent.
> 
> The whole point is to cache across processes and their various
> apertures into a common, long-lived filesystem space.
> 
> Barry knows something about the relationship between certain processes
> and certain files that he could exploit with MADV_COLD-on-exit
> semantics. But that's not something the kernel can safely assume. Not
> without defeating the page cache for an entire class of file accesses.

I've just read the previous threads about Barry's proposal and if doing this
always isn't feasible, I'm wondering if memcg would be a better interface to
opt-in for this kind of behavior than both prctl or mctl. I think at least
conceptually it fits what memcg is doing? The question is if the
implementation would be feasible, and if android puts apps in separate memcgs...

