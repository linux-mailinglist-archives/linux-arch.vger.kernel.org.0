Return-Path: <linux-arch+bounces-8353-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738E79A6D35
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E5292814F5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 14:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD441F8922;
	Mon, 21 Oct 2024 14:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7jRDk65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQdL5ECs";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="s7jRDk65";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="sQdL5ECs"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEBC1D517D;
	Mon, 21 Oct 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522451; cv=none; b=IdqpS3/B3UFRwA8L0I1mXK2k8PxfM9NLDns8KCSXZOn6xwRKDj0hTI+uxe8Q81YJdq8yGu5uKiCOIbZFP9xxRGzzkOGJmFu12GUGdnb0VFjXbN8GOE3vlYYB5V74J1dn690gyfPy8HPsLSZztMikRkwroswgUmaV4toewjE7arc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522451; c=relaxed/simple;
	bh=oqRZDTTe4MF/DbAWYno+v6i6nbbzjqccUT1JUdfFYSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jwUzTFUB+WMVZ6usYtCuLRjpPiRozAqoYgGhNbkrMNJA9IJImINfy/3G/RLwHnBWd0r9H4klrdvtXSKAYwNVw64V5TkbsFahASQeg0P1voaWyJRrpy007Y/lJEIG0V/uET5riH0ysKJcidtTzgBL1lF8WZOtOTrqNXcc7knbiJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7jRDk65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQdL5ECs; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=s7jRDk65; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=sQdL5ECs; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 099A71F7E9;
	Mon, 21 Oct 2024 14:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729522447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nRI3sbkmnwOK+Lkb9FefXrZ7ZGht1xUlXQS9Se85dJs=;
	b=s7jRDk65dXPM9sqi5FebmAmjOq990Otj25sm+mTxtyacbJmiJCEXID7gzUvpYzrkLOCSlW
	38IrqTGFOR5zzzBbPv0QeBohVAmVJWJ5Qmy5tceuYbG+JDnGVwHUWv/PZ+YG7gBSvmI4dd
	i0CXYQnDjq6LwCymkh4sBMop5v4ZN2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729522447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nRI3sbkmnwOK+Lkb9FefXrZ7ZGht1xUlXQS9Se85dJs=;
	b=sQdL5ECsXTNp2qeCI6E997OfEUobMwAFczHwOsmd8cHt8PaDNU6lmWdd9itCT+EPWaswCA
	By1E737FIhl5z4BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=s7jRDk65;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sQdL5ECs
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729522447; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nRI3sbkmnwOK+Lkb9FefXrZ7ZGht1xUlXQS9Se85dJs=;
	b=s7jRDk65dXPM9sqi5FebmAmjOq990Otj25sm+mTxtyacbJmiJCEXID7gzUvpYzrkLOCSlW
	38IrqTGFOR5zzzBbPv0QeBohVAmVJWJ5Qmy5tceuYbG+JDnGVwHUWv/PZ+YG7gBSvmI4dd
	i0CXYQnDjq6LwCymkh4sBMop5v4ZN2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729522447;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nRI3sbkmnwOK+Lkb9FefXrZ7ZGht1xUlXQS9Se85dJs=;
	b=sQdL5ECsXTNp2qeCI6E997OfEUobMwAFczHwOsmd8cHt8PaDNU6lmWdd9itCT+EPWaswCA
	By1E737FIhl5z4BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BBC18136DC;
	Mon, 21 Oct 2024 14:54:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K03gLA5rFmfDXgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 14:54:06 +0000
Message-ID: <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
Date: Mon, 21 Oct 2024 16:54:06 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
 David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 099A71F7E9
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,hansenpartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLz1534diqmneu69wx1fp4cing)];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On 10/21/24 16:33, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 04:13:34PM +0200, Vlastimil Babka wrote:
>> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>> > Add a new PTE marker that results in any access causing the accessing
>> > process to segfault.
>> >
>> > This is preferable to PTE_MARKER_POISONED, which results in the same
>> > handling as hardware poisoned memory, and is thus undesirable for cases
>> > where we simply wish to 'soft' poison a range.
>> >
>> > This is in preparation for implementing the ability to specify guard pages
>> > at the page table level, i.e. ranges that, when accessed, should cause
>> > process termination.
>> >
>> > Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
>> > function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
>> > purpose was simply incorrect.
>> >
>> > We then reuse the same logic to determine whether a zap should clear a
>> > guard entry - this should only be performed on teardown and never on
>> > MADV_DONTNEED or the like.
>>
>> Since I would have personally put MADV_FREE among "or the like" here, it's
>> surprising to me that it in fact it's tearing down the guard entries now. Is
>> that intentional? It should be at least mentioned very explicitly. But I'd
>> really argue against it, as MADV_FREE is to me a weaker form of
>> MADV_DONTNEED - the existing pages are not zapped immediately but
>> prioritized for reclaim. If MADV_DONTNEED leaves guard PTEs in place, why
>> shouldn't MADV_FREE too?
> 
> That is not, as I understand it, what MADV_FREE is, semantically. From the
> man pages:
> 
>        MADV_FREE (since Linux 4.5)
> 
>               The application no longer requires the pages in the range
>               specified by addr and len.  The kernel can thus free these
>               pages, but the freeing could be delayed until memory pressure
>               occurs.
> 
>        MADV_DONTNEED
> 
>               Do not expect access in the near future.  (For the time
>               being, the application is finished with the given range, so
>               the kernel can free resources associated with it.)
> 
> MADV_FREE is 'we are completely done with this range'. MADV_DONTNEED is 'we
> don't expect to use it in the near future'.

I think the description gives a wrong impression. What I think matters it
what happens (limited to anon private case as MADV_FREE doesn't support any
other)

MADV_DONTNEED - pages discarded immediately, further access gives new
zero-filled pages

MADV_FREE - pages prioritized for discarding, if that happens before next
write, it gets zero-filled page on next access, but a write done soon enough
 can cancel the upcoming discard.

In that sense, MADV_FREE is a weaker form of DONTNEED, no?

>>
>> Seems to me rather currently an artifact of MADV_FREE implementation - if it
>> encounters hwpoison entries it will tear them down because why not, we have
>> detected a hw memory error and are lucky the program wants to discard the
>> pages and not access them, so best use the opportunity and get rid of the
>> PTE entries immediately (if MADV_DONTNEED doesn't do that too, it certainly
>> could).
> 
> Right, but we explicitly do not tear them down in the case of MADV_DONTNEED
> which matches the description in the manpages that the user _might_ come
> back to the range, whereas MADV_FREE means they are truly done but just
> don't want the overhead of actually unmapping at this point.

But it's also defined what happens if user comes back to the range after a
MADV_FREE. I think the overhead saved happens in the case of actually coming
back soon enough to prevent the discard. With MADV_DONTNEED its immediate
and unconditional.

> Seems to be this is moreso that MADV_FREE is a not-really-as-efficient
> version of what Rik wants to do with his MADV_LAZYFREE thing.

I think that further optimizes MADV_FREE, which is already more optimized
than MADV_DONTNEED.

>>
>> But to extend this to guard PTEs which are result of an explicit userspace
>> action feels wrong, unless the semantics is the same for MADV_DONTEED. The
>> semantics chosen for MADV_DONTNEED makes sense, so MADV_FREE should behave
>> the same?
> 
> My understanding from the above is that MADV_FREE is a softer version of
> munmap(), i.e. 'totally done with this range', whereas MADV_DONTNEED is a
> 'revert state to when I first mapped this stuff because I'm done with it
> for now but might use it later'.

From the implementation I get the opposite understanding. Neither tears down
the vma like a proper unmap(). MADV_DONTNEED zaps page tables immediately,
MADV_FREE effectively too but with a delay depending on memory pressure.


