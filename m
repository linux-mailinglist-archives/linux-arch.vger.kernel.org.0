Return-Path: <linux-arch+bounces-8582-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A52FA9B120C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289511F2263B
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63EC01DD0D8;
	Fri, 25 Oct 2024 21:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sx7dpSNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v73QnpXm";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="sx7dpSNB";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="v73QnpXm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12C71217F57;
	Fri, 25 Oct 2024 21:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893417; cv=none; b=A2G2RZRCbEW/t5CtufAtFTyxkRJ473/hZOOHZ4hbsMttweJsSCalcxRuIK3yrs0Yl3/vSEo7s4EnlpqZbeI6jh0fr7pRE1c8GDB6lJQZoXQ9c645jwYN1GcTMl7YjoiHkyIXVKowp6YTdQn3d/Y08egGfw3dqdhw8JWzBgm58v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893417; c=relaxed/simple;
	bh=+SmlmSp3tuYqa867stridrhJpKRYpwhVjsYgck3gQYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O6QMuorPpcLRP0wbIMpG2NSFS52TRrz/+vl0AF3VP5dxNhiJqpu+uD6C5/nTkS4Z6y55XzmvzM2gor1B70eIFpt52yuQUMPDHLicRqLeCLiM7sJjIv7HNUgWJnXVTZXfVpQgwtEddXgyP+Pif7MasqXV1jICwwUD9vNe3rMODzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sx7dpSNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v73QnpXm; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=sx7dpSNB; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=v73QnpXm; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26E2121D99;
	Fri, 25 Oct 2024 21:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729893413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAcd3SI4ZL2BCPSgobbFjfDYfDj4nX2wo+HlD2YRBjE=;
	b=sx7dpSNBoWm1CnTJxN/H1SLvDQV+Vo3XbRUhDzz93b/zaZCD1A1BN3WvBuvjuIwhZDXoZM
	TbLH2wrQKb0ONyX6LOGsJV8tXQDFHJN9HYM55Pwem+u4X/yY+ye3hPaI/pcjrf+JYIMnre
	rrs2bHviN886raR93JZ5mMvMgnSqdd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729893413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAcd3SI4ZL2BCPSgobbFjfDYfDj4nX2wo+HlD2YRBjE=;
	b=v73QnpXmAlWg2FOQEE8jBEjc0UE7c8dZUuP72Y2KukaUMZXjr9pokk1a1FxDdT4z391xjb
	m1gs3Gt4mRuhXfAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729893413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAcd3SI4ZL2BCPSgobbFjfDYfDj4nX2wo+HlD2YRBjE=;
	b=sx7dpSNBoWm1CnTJxN/H1SLvDQV+Vo3XbRUhDzz93b/zaZCD1A1BN3WvBuvjuIwhZDXoZM
	TbLH2wrQKb0ONyX6LOGsJV8tXQDFHJN9HYM55Pwem+u4X/yY+ye3hPaI/pcjrf+JYIMnre
	rrs2bHviN886raR93JZ5mMvMgnSqdd0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729893413;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=tAcd3SI4ZL2BCPSgobbFjfDYfDj4nX2wo+HlD2YRBjE=;
	b=v73QnpXmAlWg2FOQEE8jBEjc0UE7c8dZUuP72Y2KukaUMZXjr9pokk1a1FxDdT4z391xjb
	m1gs3Gt4mRuhXfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DAF59132D3;
	Fri, 25 Oct 2024 21:56:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RDLHNCQUHGetWwAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 21:56:52 +0000
Message-ID: <7c7185ed-f997-484a-b1d1-91ae6c761266@suse.cz>
Date: Fri, 25 Oct 2024 23:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] mm: madvise: implement lightweight guard page
 mechanism
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Matt Turner <mattst88@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <415da1e6c5828d96db3af480d243a7f68ccabf6d.1729699916.git.lorenzo.stoakes@oracle.com>
 <f09086cd-c49c-4eea-adff-d626c16083de@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <f09086cd-c49c-4eea-adff-d626c16083de@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,gmail.com,alpha.franken.de,hansenpartnership.com,gmx.de,zankel.net,chromium.org,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/25/24 19:12, Lorenzo Stoakes wrote:
> On Wed, Oct 23, 2024 at 05:24:40PM +0100, Lorenzo Stoakes wrote:
>> Implement a new lightweight guard page feature, that is regions of userland
>> virtual memory that, when accessed, cause a fatal signal to arise.
> 
> <snip>
> 
> Hi Andrew - Could you apply the below fix-patch? I realise we must handle
> fatal signals and conditional rescheduling in the vector_madvise() special
> case.
> 
> Thanks!
> 
> ----8<----
> From 546d7e1831c71599fc733d589e0d75f52e84826d Mon Sep 17 00:00:00 2001
> From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Date: Fri, 25 Oct 2024 18:05:48 +0100
> Subject: [PATCH] mm: yield on fatal signal/cond_sched() in vector_madvise()
> 
> While we have to treat -ERESTARTNOINTR specially here as we are looping
> through a vector of operations and can't simply restart the entire
> operation, we mustn't hold up fatal signals or RT kernels.

For plain madvise() syscall returning -ERESTARTNOINTR does the right thing
and checks fatal_signal_pending() before returning, right?

Uh actually can we be just returning -ERESTARTNOINTR or do we need to use
restart_syscall()?

> ---
>  mm/madvise.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 48eba25e25fe..127aa5d86656 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1713,8 +1713,14 @@ static ssize_t vector_madvise(struct mm_struct *mm, struct iov_iter *iter,
>  		 * we have already rescinded locks, it should be no problem to
>  		 * simply try again.
>  		 */
> -		if (ret == -ERESTARTNOINTR)
> +		if (ret == -ERESTARTNOINTR) {
> +			if (fatal_signal_pending(current)) {
> +				ret = -EINTR;
> +				break;
> +			}
> +			cond_resched();

Should be unnecessary as we're calling an operation that takes a rwsem so
there are reschedule points already. And with lazy preempt hopefully
cond_resched()s will become history, so let's not add more only to delete later.

>  			continue;
> +		}
>  		if (ret < 0)
>  			break;
>  		iov_iter_advance(iter, iter_iov_len(iter));
> --
> 2.47.0


