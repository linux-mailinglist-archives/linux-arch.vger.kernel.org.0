Return-Path: <linux-arch+bounces-8393-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEC79A9118
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A854128071E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEE2B1FCF47;
	Mon, 21 Oct 2024 20:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPUT91ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="56Nl0+Nv";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="TPUT91ei";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="56Nl0+Nv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D883B198A17;
	Mon, 21 Oct 2024 20:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542310; cv=none; b=md6s9d35p5kWoyQ8BLsVA1kUWH3Esds7VitBFYxVE6gDq3ebErsK7oKV8PsqTkxnTrmCsBN08KJ1joup+JnSgSQQn81NJIw6xsIkd3cDZLoqtxAmt76aNJyAiXba6pLpQXGFG7cI5nE8Gbh/XsY+lfog8OfKwakXBCnkP3vM7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542310; c=relaxed/simple;
	bh=y/l3h1Q/dA+2NJ5SSfXgYKWvCr6lTHoF2tPnTaPmwFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NvIPde/EXlr+3Z565lY0onkGEDoXh72GilLxFv5rcpcn+20IWH3AMPqI4i/sVEUbGpL6GZRXaKuvQ45ey4Lch+UltANIQzAsWqoU7jATNT7mCViXKlSjUT7UuTrAaMIYj+0ubG/9gVP4gDcnjTYf7UPiaCbB5LztKV1Ek/9qWNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPUT91ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=56Nl0+Nv; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=TPUT91ei; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=56Nl0+Nv; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 231EF1F845;
	Mon, 21 Oct 2024 20:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729542307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VsgeH+Vv74T0/0FDcb8uC+DNTIop0pOW0YtXLu0F26o=;
	b=TPUT91ei1Xp9k9yndV1wyj1LMjxHV63ZpJ+lhR/oG79eTPsa4dV6/yS59lEgHb5IbNqFJ5
	MKjPS0Z5T25z7lZnZaUPWncdXuA3XzObNvCBJWE/+LNn5dIXwnBSUPLLy3bYFj7hgJ9Au9
	DzJcmpeqX9UUe172w428hHSQ69fsYrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729542307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VsgeH+Vv74T0/0FDcb8uC+DNTIop0pOW0YtXLu0F26o=;
	b=56Nl0+Nv0rTxE9CgCQOaC2vkFNxApHqXMBF4JwNTTvj1BoudktL5gH8aqwTRdy3s11uQgO
	rRvYmntdj6iVg3Aw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729542307; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VsgeH+Vv74T0/0FDcb8uC+DNTIop0pOW0YtXLu0F26o=;
	b=TPUT91ei1Xp9k9yndV1wyj1LMjxHV63ZpJ+lhR/oG79eTPsa4dV6/yS59lEgHb5IbNqFJ5
	MKjPS0Z5T25z7lZnZaUPWncdXuA3XzObNvCBJWE/+LNn5dIXwnBSUPLLy3bYFj7hgJ9Au9
	DzJcmpeqX9UUe172w428hHSQ69fsYrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729542307;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=VsgeH+Vv74T0/0FDcb8uC+DNTIop0pOW0YtXLu0F26o=;
	b=56Nl0+Nv0rTxE9CgCQOaC2vkFNxApHqXMBF4JwNTTvj1BoudktL5gH8aqwTRdy3s11uQgO
	rRvYmntdj6iVg3Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8DAF1139E0;
	Mon, 21 Oct 2024 20:25:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pEuzIaK4FmdKQQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 20:25:06 +0000
Message-ID: <fedd19ce-ea15-4ded-a1b5-ff050de15bba@suse.cz>
Date: Mon, 21 Oct 2024 22:25:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
 Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kselftest@vger.kernel.org, Sidhartha Kumar
 <sidhartha.kumar@oracle.com>, Jeff Xu <jeffxu@chromium.org>,
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <6c282299-506f-45c9-9ddc-9ef4de582394@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-4.28 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.18)[-0.902];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.28
X-Spam-Flag: NO

On 10/21/24 22:17, David Hildenbrand wrote:
> On 21.10.24 22:11, Vlastimil Babka wrote:
>> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>> 
>> <snip>
>> 
>>> +static long madvise_guard_poison(struct vm_area_struct *vma,
>>> +				 struct vm_area_struct **prev,
>>> +				 unsigned long start, unsigned long end)
>>> +{
>>> +	long err;
>>> +
>>> +	*prev = vma;
>>> +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>>> +		return -EINVAL;
>>> +
>>> +	/*
>>> +	 * If we install poison markers, then the range is no longer
>>> +	 * empty from a page table perspective and therefore it's
>>> +	 * appropriate to have an anon_vma.
>>> +	 *
>>> +	 * This ensures that on fork, we copy page tables correctly.
>>> +	 */
>>> +	err = anon_vma_prepare(vma);
>>> +	if (err)
>>> +		return err;
>>> +
>>> +	/*
>>> +	 * Optimistically try to install the guard poison pages first. If any
>>> +	 * non-guard pages are encountered, give up and zap the range before
>>> +	 * trying again.
>>> +	 */
>> 
>> Should the page walker become powerful enough to handle this in one go? :)
>> But sure, if it's too big a task to teach it to zap ptes with all the tlb
>> flushing etc (I assume it's something page walkers don't do today), it makes
>> sense to do it this way.
>> Or we could require userspace to zap first (MADV_DONTNEED), but that would
>> unnecessarily mean extra syscalls for the use case of an allocator debug
>> mode that wants to turn freed memory to guards to catch use after free.
>> So this seems like a good compromise...
> 
> Yes please, KIS.

You mean "require userspace to zap first (MADV_DONTNEED)" ?

I'd normally agree with the KIS principle, but..

> We can always implement support for that later if 

it would either mean later we change behavior (installing guards on
non-zapped PTEs would have to be an error now but maybe start working later,
which is user observable change thus can break somebody)

> really required (leave behavior open when documenting).

and leaving it open when documenting doesn't really mean anything for the
"we don't break userspace" promise vs what the implementation actually does.

Or the changed behavior would need to come with a new MADVISE mode. Not
appealing as it's a mess already.

So since its uapi we should aim for the best from the start.



