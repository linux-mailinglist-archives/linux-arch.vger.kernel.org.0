Return-Path: <linux-arch+bounces-8271-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7C69A4354
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD66828057A
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559F20262E;
	Fri, 18 Oct 2024 16:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLnBD6FI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0EyTKeHr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OLnBD6FI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0EyTKeHr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0A133987;
	Fri, 18 Oct 2024 16:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267843; cv=none; b=hgo30RTNl9+TM2YvQURXYvtxIyFe0/Z6m4D8Ujx07kSvHswQP6pLRjbR/7ybV3zVCOBw9JpdDJCglKj7Sp+MNLqo6yRZHEDJ3+0HkcRxihcGcdYb1FuVH/CbzpXyKpBFJHKk0C5g45lALRZhVnNd6dmQrsIpQvkQyn1Lwa0aahI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267843; c=relaxed/simple;
	bh=kTERkXy4JzRjieDtPT96BhnO/Z9tGFzxm2mTx8PdmjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JbxqXSKyGXOU2XYduzOAsfQaFvjHXzol2Qn04XRnMBbU6Iz1cMnsB0P5l42Jbnc3hVe+sbdBSTIogkWXnsnwIvdFeCmwUTWXmIzQZkKRwUmoiRKe59SjkD7d0TDvzRtlJMIsqmw5pMA9T24IPRk/MxHX9Tfp077OR9kEJLB6HhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLnBD6FI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0EyTKeHr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OLnBD6FI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0EyTKeHr; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AE73B21B95;
	Fri, 18 Oct 2024 16:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729267837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZwgNyh5Sz+THCkuj2b3YclZKDHUE50f0u3axSvQI4g=;
	b=OLnBD6FIsyC3KZd83MQhFV2sbSe+RngPX1PSiTD6KNwc4PqXK0tHcxlzXaLclTKPip1/Rh
	u7Da6M4vKEvWgm0seUjKEh+PDARnXl+ZlWj5U8QND6LldFtmB8GsKXgGSTKrCMGjmsQfpo
	/CNS0TXKcpgqEl0xJ9Ef35UEIp4WL7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729267837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZwgNyh5Sz+THCkuj2b3YclZKDHUE50f0u3axSvQI4g=;
	b=0EyTKeHrQ0HxGRnpn92jVrGeHrrdvHSra9SIM144D3mzfXARV6+eCsrX5hEQChScwWvkyR
	dbRLQgXPuVkU1rDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OLnBD6FI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=0EyTKeHr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729267837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZwgNyh5Sz+THCkuj2b3YclZKDHUE50f0u3axSvQI4g=;
	b=OLnBD6FIsyC3KZd83MQhFV2sbSe+RngPX1PSiTD6KNwc4PqXK0tHcxlzXaLclTKPip1/Rh
	u7Da6M4vKEvWgm0seUjKEh+PDARnXl+ZlWj5U8QND6LldFtmB8GsKXgGSTKrCMGjmsQfpo
	/CNS0TXKcpgqEl0xJ9Ef35UEIp4WL7U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729267837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=pZwgNyh5Sz+THCkuj2b3YclZKDHUE50f0u3axSvQI4g=;
	b=0EyTKeHrQ0HxGRnpn92jVrGeHrrdvHSra9SIM144D3mzfXARV6+eCsrX5hEQChScwWvkyR
	dbRLQgXPuVkU1rDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6FB6513680;
	Fri, 18 Oct 2024 16:10:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 9dDNGn2IEmd/VAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 18 Oct 2024 16:10:37 +0000
Message-ID: <e4985328-dbfa-4c47-9cf9-12aa89ba9798@suse.cz>
Date: Fri, 18 Oct 2024 18:10:37 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] implement lightweight guard pages
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
 Christoph Hellwig <hch@infradead.org>, Linux API <linux-api@vger.kernel.org>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AE73B21B95
X-Spam-Level: 
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
	RCPT_COUNT_TWELVE(0.00)[31];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,arndb.de,chromium.org];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLz1534diqmneu69wx1fp4cing)];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

+CC linux-api (also should on future revisions)

On 10/17/24 22:42, Lorenzo Stoakes wrote:
> Userland library functions such as allocators and threading implementations
> often require regions of memory to act as 'guard pages' - mappings which,
> when accessed, result in a fatal signal being sent to the accessing
> process.
> 
> The current means by which these are implemented is via a PROT_NONE mmap()
> mapping, which provides the required semantics however incur an overhead of
> a VMA for each such region.
> 
> With a great many processes and threads, this can rapidly add up and incur
> a significant memory penalty. It also has the added problem of preventing
> merges that might otherwise be permitted.
> 
> This series takes a different approach - an idea suggested by Vlasimil
> Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
> provenance becomes a little tricky to ascertain after this - please forgive
> any omissions!)  - rather than locating the guard pages at the VMA layer,
> instead placing them in page tables mapping the required ranges.
> 
> Early testing of the prototype version of this code suggests a 5 times
> speed up in memory mapping invocations (in conjunction with use of
> process_madvise()) and a 13% reduction in VMAs on an entirely idle android
> system and unoptimised code.
> 
> We expect with optimisation and a loaded system with a larger number of
> guard pages this could significantly increase, but in any case these
> numbers are encouraging.
> 
> This way, rather than having separate VMAs specifying which parts of a
> range are guard pages, instead we have a VMA spanning the entire range of
> memory a user is permitted to access and including ranges which are to be
> 'guarded'.
> 
> After mapping this, a user can specify which parts of the range should
> result in a fatal signal when accessed.
> 
> By restricting the ability to specify guard pages to memory mapped by
> existing VMAs, we can rely on the mappings being torn down when the
> mappings are ultimately unmapped and everything works simply as if the
> memory were not faulted in, from the point of view of the containing VMAs.
> 
> This mechanism in effect poisons memory ranges similar to hardware memory
> poisoning, only it is an entirely software-controlled form of poisoning.
> 
> Any poisoned region of memory is also able to 'unpoisoned', that is, to
> have its poison markers removed.
> 
> The mechanism is implemented via madvise() behaviour - MADV_GUARD_POISON
> which simply poisons ranges - and MADV_GUARD_UNPOISON - which clears this
> poisoning.
> 
> Poisoning can be performed across multiple VMAs and any existing mappings
> will be cleared, that is zapped, before installing the poisoned page table
> mappings.
> 
> There is no concept of 'nested' poisoning, multiple attempts to poison a
> range will, after the first poisoning, have no effect.
> 
> Importantly, unpoisoning of poisoned ranges has no effect on non-poisoned
> memory, so a user can safely unpoison a range of memory and clear only
> poison page table mappings leaving the rest intact.
> 
> The actual mechanism by which the page table entries are specified makes
> use of existing logic - PTE markers, which are used for the userfaultfd
> UFFDIO_POISON mechanism.
> 
> Unfortunately PTE_MARKER_POISONED is not suited for the guard page
> mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
> handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
> logic to handle it.
> 
> We also extend the generic page walk mechanism to allow for installation of
> PTEs (carefully restricted to memory management logic only to prevent
> unwanted abuse).
> 
> We ensure that zapping performed by, for instance, MADV_DONTNEED, does not
> remove guard poison markers, nor does forking (except when VM_WIPEONFORK is
> specified for a VMA which implies a total removal of memory
> characteristics).
> 
> It's important to note that the guard page implementation is emphatically
> NOT a security feature, so a user can remove the poisoning if they wish. We
> simply implement it in such a way as to provide the least surprising
> behaviour.
> 
> An extensive set of self-tests are provided which ensure behaviour is as
> expected and additionally self-documents expected behaviour of poisoned
> ranges.
> 
> Suggested-by: Vlastimil Babka <vbabka@suze.cz>

Please fix the domain typo (also in patch 3 :)

Thanks for implementing this,
Vlastimil

> Suggested-by: Jann Horn <jannh@google.com>
> Suggested-by: David Hildenbrand <david@redhat.com>
> 
> v1
> * Un-RFC'd as appears no major objections to approach but rather debate on
>   implementation.
> * Fixed issue with arches which need mmu_context.h and
>   tlbfush.h. header imports in pagewalker logic to be able to use
>   update_mmu_cache() as reported by the kernel test bot.
> * Added comments in page walker logic to clarify who can use
>   ops->install_pte and why as well as adding a check_ops_valid() helper
>   function, as suggested by Christoph.
> * Pass false in full parameter in pte_clear_not_present_full() as suggested
>   by Jann.
> * Stopped erroneously requiring a write lock for the poison operation as
>   suggested by Jann and Suren.
> * Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
>   consistent with how this is used elsewhere in the kernel as suggested by
>   Jann.
> * Avoid returning -EAGAIN if we are raced on page faults, just keep looping
>   and duck out if a fatal signal is pending or a conditional reschedule is
>   needed, as suggested by Jann.
> * Avoid needlessly splitting huge PUDs and PMDs by specifying
>   ACTION_CONTINUE, as suggested by Jann.
> 
> RFC
> https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/
> 
> Lorenzo Stoakes (4):
>   mm: pagewalk: add the ability to install PTEs
>   mm: add PTE_MARKER_GUARD PTE marker
>   mm: madvise: implement lightweight guard page mechanism
>   selftests/mm: add self tests for guard page feature
> 
>  arch/alpha/include/uapi/asm/mman.h       |    3 +
>  arch/mips/include/uapi/asm/mman.h        |    3 +
>  arch/parisc/include/uapi/asm/mman.h      |    3 +
>  arch/xtensa/include/uapi/asm/mman.h      |    3 +
>  include/linux/mm_inline.h                |    2 +-
>  include/linux/pagewalk.h                 |   18 +-
>  include/linux/swapops.h                  |   26 +-
>  include/uapi/asm-generic/mman-common.h   |    3 +
>  mm/hugetlb.c                             |    3 +
>  mm/internal.h                            |    6 +
>  mm/madvise.c                             |  168 ++++
>  mm/memory.c                              |   18 +-
>  mm/mprotect.c                            |    3 +-
>  mm/mseal.c                               |    1 +
>  mm/pagewalk.c                            |  200 ++--
>  tools/testing/selftests/mm/.gitignore    |    1 +
>  tools/testing/selftests/mm/Makefile      |    1 +
>  tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
>  18 files changed, 1564 insertions(+), 66 deletions(-)
>  create mode 100644 tools/testing/selftests/mm/guard-pages.c
> 
> --
> 2.46.2


