Return-Path: <linux-arch+bounces-8380-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 873EA9A7106
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 19:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42B2B281EEE
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CF11EE032;
	Mon, 21 Oct 2024 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YrXoX5mK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gUlqYEb4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="YrXoX5mK";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gUlqYEb4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D7991CBEBC;
	Mon, 21 Oct 2024 17:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729531575; cv=none; b=sEmVna33Ks60jRP7Dtr8LEEEUWhRT0YCLiQMAidhDTNAPOxd2T3FfoPBOZDkKqUf05siCexWbeFIguMS2LfeL5gLlq13TvCkHeB3mB7l5yDlIQ/qCHFeo/84GXrOP3bpGok48m800VAcY8WFW8JHpNlF8hjrHTPWB8Nuft+e9ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729531575; c=relaxed/simple;
	bh=JEGIqOFF+79SDuGiF1AThx4hL1NHbgkSZoVqIiS+59E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jyqwheGCVJ0irQEyCgXghTvKIH8nDnAQfFMTJq/Acs00u47NilRBFYLQbTjFZkwyCVxUC1W/aY2Lm9CwZvt40MRtBmMQylYjWfHYAakk/3+Rd+Ydi60P3SqLexLQ9rgcuV6vI0pZYrEIF2RlCdFlx5BsSfmVMa4SEWviYe8GwtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YrXoX5mK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gUlqYEb4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=YrXoX5mK; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gUlqYEb4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2A8C51F80C;
	Mon, 21 Oct 2024 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729531571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZv9f7LMlXSjmsbwslEKPBtm1QgaxLmQcoTj3XO9DvQ=;
	b=YrXoX5mKHHiuoR5IRYvUGZw7aCw2cW4dJUqyx/Wr+OjXLNmA6IDzC48BDXVmf5h0Uqq961
	dIq59SQaNRJSShXalIyQAtLNjNrvLJ4IFBkFJmxgD9SueibkCbZzN6Paehxw0pmj6BJC7I
	DDeVrjio0eREaxVRft/ak3LWhywi4Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729531571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZv9f7LMlXSjmsbwslEKPBtm1QgaxLmQcoTj3XO9DvQ=;
	b=gUlqYEb4wQQPD/TGWY9HQQV5JQS00CvegZPA3DRcfBrUorVqmfFeSg/b4IpcR17fANVQFB
	9a2FEH2XJqKLMQDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729531571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZv9f7LMlXSjmsbwslEKPBtm1QgaxLmQcoTj3XO9DvQ=;
	b=YrXoX5mKHHiuoR5IRYvUGZw7aCw2cW4dJUqyx/Wr+OjXLNmA6IDzC48BDXVmf5h0Uqq961
	dIq59SQaNRJSShXalIyQAtLNjNrvLJ4IFBkFJmxgD9SueibkCbZzN6Paehxw0pmj6BJC7I
	DDeVrjio0eREaxVRft/ak3LWhywi4Iw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729531571;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=UZv9f7LMlXSjmsbwslEKPBtm1QgaxLmQcoTj3XO9DvQ=;
	b=gUlqYEb4wQQPD/TGWY9HQQV5JQS00CvegZPA3DRcfBrUorVqmfFeSg/b4IpcR17fANVQFB
	9a2FEH2XJqKLMQDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D966F136DC;
	Mon, 21 Oct 2024 17:26:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HlhSNLKOFmc/EAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 17:26:10 +0000
Message-ID: <8329667f-73b6-48fe-8f3c-07c741462fee@suse.cz>
Date: Mon, 21 Oct 2024 19:26:10 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Content-Language: en-US
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Matthew Wilcox <willy@infradead.org>, "Paul E . McKenney"
 <paulmck@kernel.org>, Jann Horn <jannh@google.com>, linux-mm@kvack.org,
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
References: <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
 <434a440a-d6a4-4144-b4fb-8e0d8535f03f@lucifer.local>
 <caf95a99-e975-4f3d-a94b-298a5fc88b5a@suse.cz>
 <4f4e41f1-531c-4686-b44d-dacdf034c241@lucifer.local>
 <cb0e49be-7b4e-4760-884c-8f4bf74ec1e1@redhat.com>
 <ea771edf-0e38-440f-b264-3cbe285a628b@lucifer.local>
 <49afa956-21e1-4b3d-9dde-82a6891f2902@redhat.com>
 <cbf17dc3-01eb-4416-8ec5-cac05e50d663@lucifer.local>
 <ef0e11c5-13cf-4d47-a277-41da317be165@redhat.com>
 <acf358a4-c503-4347-8156-9269c43bf796@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <acf358a4-c503-4347-8156-9269c43bf796@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,oracle.com,infradead.org,kernel.org,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,hansenpartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/21/24 19:14, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 07:00:53PM +0200, David Hildenbrand wrote:
>>
>> >
>> > >
>> > > >
>> > > > Also the existing logic is that existing markers (HW poison, uffd-simulated HW
>> > > > poison, uffd wp marker) are retained and no error raised on MADV_DONTNEED, and
>> > > > no error on MADV_FREE either, so it'd be consistent with existing behaviour.
>> > >
>> > >
>> > > HW poison / uffd-simulated HW poison are expected to be zapped: it's just
>> > > like a mapped page with HWPOISON. So that is correct.
>> >
>> > Well, poison is _not_ zapped on MADV_DONTNEED but _is_ on MADV_FREE :) anyway, I
>>
>> Huh?
>>
>> madvise_dontneed_single_vma()->zap_page_range_single(details=NULL)->unmap_single_vma(details=NULL)
>> ... zap_pte_range()
>>
>> } else if (is_hwpoison_entry(entry) ||
>> 	   is_poisoned_swp_entry(entry)) {
>> 	if (!should_zap_cows(details))
>> 		continue;
>> 	...
>>
>> Should just zap them.
>>
>> What am I missing?
> 
> Yeah ok it's me who's missing something here, I hadn't noticed details == NULL
> so should_zap_cows() is true, my mistake!

Well, good to know it's consistent then. As I've explained I see why zapping
actual hwpoison makes sense for MADV_DONTNEED/MADV_FREE. That it's done also
for uffd poison is not completely clear, but maybe it was just easier to
implement. But it doesn't mean we have to do the same for GUARD PTEs. Either
behavior of zap/ignore/error could be valid, we just have to pick one and
then live with it as it can't change :) Zapping guards on DONTNEED/FREE
seems wrong to me, so it's between error (and potentially catching some
misuse) and ignore (potentially more performant in case somebody wants to
DOTNEED/FREE an area that contains scattered guards).

And the impossibility to meaningfully unwind on errors in the middle of the
operation (unless we pre-scan for guards) isn't exactly nice, so maybe just
ignore, i.e. the current approach?

> In any case we explicitly add code here to prevent guard pages from going. I
> will correct everything where I wrongly say otherwise, doh!
> 
>>
>> > mean the MADV flags are a confusing mess generally, as per Vlasta's comments
>> > which to begin with I strongly disagreed with then, discussing further, realsed
>> > that no this is just a bit insane and had driven _me_ insane.
>> >
>> > >
>> > > UFFD-WP behavior is ... weird. Would not expect MADV_DONTNEED to zap uffd-wp
>> > > entries.
>> > >
>> > > >
>> > > > Also semantically you are achieving what the calls expect you are freeing the
>> > > > ranges since the guard page regions are unbacked so are already freed... so yeah
>> > > > I don't think an error really makes sense here.
>> > >
>> > > I you compare it to a VMA hole, it make sense to fail. If we treat it like
>> > > PROT_NONE, it make sense to skip them.
>> > >
>> > > >
>> > > > We might also be limiting use cases by assuming they might _only_ be used for
>> > > > allocators and such.
>> > >
>> > > I don't buy that as an argument, sorry :)
>> > >
>> > > "Let's map the kernel writable into all user space because otherwise we
>> > > might be limiting use cases"
>> >
>> > That's a great idea! Patch series incoming, 1st April 2025... :>)
>>
>> :) Just flip the bit on x86 and we're done!
> 
> ;)
> 
>>
>> > >
>> > >
>> > > :P
>> > >
>> > > --
>> > > Cheers,
>> > >
>> > > David / dhildenb
>> > >
>> >
>> > Overall I think just always leaving in place except on remedy err sorry sorry
>> > unpoison and munmap and not returning an error if encountered elsewhere (other
>> > than, of course, GUP) is the right way forward and most in line with user
>> > expectation and practical usage.
>>
>>
>> Fine with me, make sure to document that is behaves like a PROT_NONE VMA,
>> not like a memory hole, except when something would trigger a fault (GUP
>> etc).
> 
> Ack will make sure to document.
> 
>>
>>
>> --
>> Cheers,
>>
>> David / dhildenb
>>


