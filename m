Return-Path: <linux-arch+bounces-8398-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81669A917B
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F62D280F62
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A149C1FE0E2;
	Mon, 21 Oct 2024 20:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYQDUBAL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3P7gbDy/";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="oYQDUBAL";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3P7gbDy/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA21E0B74;
	Mon, 21 Oct 2024 20:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543565; cv=none; b=RaoW+n3Vhg066spe8JkOAhNNTGR498bJQKs8e2xe0uUfPV9+yC/tZgNRf6cKHCVGVs0Y45e/8+Msab4d+z/Uy9jNuB0MhDJJoitbPy+DhzyATNI26jQtrMOMUhOikOHymM6LCBxEKHsKj7+dR93HoEozmGpGLgcc+eVTgOA0Uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543565; c=relaxed/simple;
	bh=zyX8ZdeS13O/jnmbdLlxVU3zGlqEczEi96E+RDYzYd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsKaU0puAYi8dlb65Fs3WaKBgmOo4/qAwQa9Dm6hRMqVsINAVZCScYTKtTQ1qR5r9C+BsgWBAYiOY/g/TOz/8WPaSS8bi9YWMFy71whsMwCNKWwMy/U6p58Z+PP0n3hD4H7164eY01Odxsm/SAUKlXXKtiS23NUE4LZ3bxCdIjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYQDUBAL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3P7gbDy/; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=oYQDUBAL; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3P7gbDy/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 0FBAA1F851;
	Mon, 21 Oct 2024 20:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729543561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46VyK051n5rUSp8NYFDgjeFP2weMNY/tKuWhnM3jx28=;
	b=oYQDUBALBMz86YiPvtuxpr8H8Nb6eXCInqBmaHSTHx/sbzTQ17wuj8HRDb8YfFJ8XzS0tH
	r9guFQnpNR7sYRACAAtA1+IdQ9FOm7ULTa8tOd82h3eBdAnPOTtMHvsANJqbeuu0eem+aJ
	IlzXJgSfeGbW0pR+VZAeqk7+sX2KALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729543561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46VyK051n5rUSp8NYFDgjeFP2weMNY/tKuWhnM3jx28=;
	b=3P7gbDy/uz+VHeZF5LtEEayb67byRnVjtt1fTAo8pB/UctBbEhm4U1i5oepSKkUQrn0LG2
	1ujTt03bBy5v69DQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=oYQDUBAL;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="3P7gbDy/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729543561; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46VyK051n5rUSp8NYFDgjeFP2weMNY/tKuWhnM3jx28=;
	b=oYQDUBALBMz86YiPvtuxpr8H8Nb6eXCInqBmaHSTHx/sbzTQ17wuj8HRDb8YfFJ8XzS0tH
	r9guFQnpNR7sYRACAAtA1+IdQ9FOm7ULTa8tOd82h3eBdAnPOTtMHvsANJqbeuu0eem+aJ
	IlzXJgSfeGbW0pR+VZAeqk7+sX2KALo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729543561;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=46VyK051n5rUSp8NYFDgjeFP2weMNY/tKuWhnM3jx28=;
	b=3P7gbDy/uz+VHeZF5LtEEayb67byRnVjtt1fTAo8pB/UctBbEhm4U1i5oepSKkUQrn0LG2
	1ujTt03bBy5v69DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F83E136DC;
	Mon, 21 Oct 2024 20:46:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0Cg5Foi9Fme7RgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 20:46:00 +0000
Message-ID: <f2448c59-0456-49e8-9676-609629227808@suse.cz>
Date: Mon, 21 Oct 2024 22:45:58 +0200
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
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
 <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FBAA1F851
X-Spam-Level: 
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.992];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:mid,oracle.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,hansenpartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	R_RATELIMIT(0.00)[to_ip_from(RLz1534diqmneu69wx1fp4cing)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim,suse.cz:mid]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.51
X-Spam-Flag: NO

On 10/21/24 22:27, Lorenzo Stoakes wrote:
> On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
>> On 10/20/24 18:20, Lorenzo Stoakes wrote:
>> > Implement a new lightweight guard page feature, that is regions of userland
>> > virtual memory that, when accessed, cause a fatal signal to arise.
>> >
>> > Currently users must establish PROT_NONE ranges to achieve this.
>> >
>> > However this is very costly memory-wise - we need a VMA for each and every
>> > one of these regions AND they become unmergeable with surrounding VMAs.
>> >
>> > In addition repeated mmap() calls require repeated kernel context switches
>> > and contention of the mmap lock to install these ranges, potentially also
>> > having to unmap memory if installed over existing ranges.
>> >
>> > The lightweight guard approach eliminates the VMA cost altogether - rather
>> > than establishing a PROT_NONE VMA, it operates at the level of page table
>> > entries - poisoning PTEs such that accesses to them cause a fault followed
>> > by a SIGSGEV signal being raised.
>> >
>> > This is achieved through the PTE marker mechanism, which a previous commit
>> > in this series extended to permit this to be done, installed via the
>> > generic page walking logic, also extended by a prior commit for this
>> > purpose.
>> >
>> > These poison ranges are established with MADV_GUARD_POISON, and if the
>> > range in which they are installed contain any existing mappings, they will
>> > be zapped, i.e. free the range and unmap memory (thus mimicking the
>> > behaviour of MADV_DONTNEED in this respect).
>> >
>> > Any existing poison entries will be left untouched. There is no nesting of
>> > poisoned pages.
>> >
>> > Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
>> > unexpected behaviour, but are cleared on process teardown or unmapping of
>> > memory ranges.
>> >
>> > Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
>> > 'remedying' the poisoning. The ranges over which this is applied, should
>> > they contain non-poison entries, will be untouched, only poison entries
>> > will be cleared.
>> >
>> > We permit this operation on anonymous memory only, and only VMAs which are
>> > non-special, non-huge and not mlock()'d (if we permitted this we'd have to
>> > drop locked pages which would be rather counterintuitive).
>> >
>> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
>> > Suggested-by: Jann Horn <jannh@google.com>
>> > Suggested-by: David Hildenbrand <david@redhat.com>
>> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>>
>> <snip>
>>
>> > +static long madvise_guard_poison(struct vm_area_struct *vma,
>> > +				 struct vm_area_struct **prev,
>> > +				 unsigned long start, unsigned long end)
>> > +{
>> > +	long err;
>> > +
>> > +	*prev = vma;
>> > +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
>> > +		return -EINVAL;
>> > +
>> > +	/*
>> > +	 * If we install poison markers, then the range is no longer
>> > +	 * empty from a page table perspective and therefore it's
>> > +	 * appropriate to have an anon_vma.
>> > +	 *
>> > +	 * This ensures that on fork, we copy page tables correctly.
>> > +	 */
>> > +	err = anon_vma_prepare(vma);
>> > +	if (err)
>> > +		return err;
>> > +
>> > +	/*
>> > +	 * Optimistically try to install the guard poison pages first. If any
>> > +	 * non-guard pages are encountered, give up and zap the range before
>> > +	 * trying again.
>> > +	 */
>>
>> Should the page walker become powerful enough to handle this in one go? :)
> 
> I can tell you've not read previous threads...

Whoops, you're right, I did read v1 but forgot about the RFC.

But we can assume people who'll only see the code after it's merged will not
have read it either, so since a potentially endless loop could be
suspicious, expanding the comment to explain how it's fine wouldn't hurt?

> I've addressed this in discussion with Jann - we'd have to do a full fat
> huge comprehensive thing to do an in-place replace.
> 
> It'd either have to be fully duplicative of the multiple copies of the very
> lengthily code to do this sort of thing right (some in mm/madvise.c itself)
> or I'd have to go off and do a totally new pre-requisite series
> centralising that in a way that people probably wouldn't accept... I'm not
> sure the benefits outway the costs.
> 
>> But sure, if it's too big a task to teach it to zap ptes with all the tlb
>> flushing etc (I assume it's something page walkers don't do today), it makes
>> sense to do it this way.
>> Or we could require userspace to zap first (MADV_DONTNEED), but that would
>> unnecessarily mean extra syscalls for the use case of an allocator debug
>> mode that wants to turn freed memory to guards to catch use after free.
>> So this seems like a good compromise...
> 
> This is optimistic as the comment says, you very often won't need to do
> this, so we do a little extra work in the case that you need to zap,
> vs. the more likely case that you don't when you don't.
> 
> In the face of racing faults, which we can't reasonably prevent without
> having to write _and_ VMA lock which is an egregious requirement, this
> wouldn't really save us anythign anyway.

OK.

>>
>> > +	while (true) {
>> > +		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
>> > +		err = walk_page_range_mm(vma->vm_mm, start, end,
>> > +					 &guard_poison_walk_ops, NULL);
>> > +		if (err <= 0)
>> > +			return err;
>> > +
>> > +		/*
>> > +		 * OK some of the range have non-guard pages mapped, zap
>> > +		 * them. This leaves existing guard pages in place.
>> > +		 */
>> > +		zap_page_range_single(vma, start, end - start, NULL);
>>
>> ... however the potentially endless loop doesn't seem great. Could a
>> malicious program keep refaulting the range (ignoring any segfaults if it
>> loses a race) with one thread while failing to make progress here with
>> another thread? Is that ok because it would only punish itself?
> 
> Sigh. Again, I don't think you've read the previous series have you? Or
> even the changelog... I added this as Jann asked for it. Originally we'd
> -EAGAIN if we got raced. See the discussion over in v1 for details.
> 
> I did it that way specifically to avoid such things, but Jann didn't appear
> to think it was a problem.

If Jann is fine with this then it must be secure enough.

>>
>> I mean if we have to retry the guards page installation more than once, it
>> means the program *is* racing faults with installing guard ptes in the same
>> range, right? So it would be right to segfault it. But I guess when we
>> detect it here, we have no way to send the signal to the right thread and it
>> would be too late? So unless we can do the PTE zap+install marker
>> atomically, maybe there's no better way and this is acceptable as a
>> malicious program can harm only itself?
> 
> Yup you'd only be hurting yourself. I went over this with Jann, who didn't
> appear to have a problem with this approach from a security perspective, in
> fact he explicitly asked me to do this :)
> 
>>
>> Maybe it would be just simpler to install the marker via zap_details rather
>> than the pagewalk?
> 
> Ah the inevitable 'please completely rework how you do everything' comment
> I was expecting at some point :)

Job security :)

j/k

> Obviously I've considered this (and a number of other approaches), it would
> fundamentally change what zap is - right now if it can't traverse a page
> table level that job done (it's job is to remove PTEs not create).
> 
> We'd instead have to completely rework the logic to be able to _install_
> page tables and then carefully check we don't break anything and only do it
> in the specific cases we need.
> 
> Or we could add a mode that says 'replace with a poison marker' rather than
> zap, but that has potential TLB concerns, splits it across two operations
> (installation and zapping), and then could you really be sure that there
> isn't a really really badly timed race that would mean you'd have to loop
> again?
> 
> Right now it's simple, elegant, small and we can only make ourselves
> wait. I don't think this is a huge problem.
> 
> I think I'll need an actual security/DoS-based justification to change this.
> 
>>
>> > +
>> > +		if (fatal_signal_pending(current))
>> > +			return -EINTR;
>> > +		cond_resched();
>> > +	}
>> > +}
>> > +
>> > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
>> > +				    unsigned long next, struct mm_walk *walk)
>> > +{
>> > +	pte_t ptent = ptep_get(pte);
>> > +
>> > +	if (is_guard_pte_marker(ptent)) {
>> > +		/* Simply clear the PTE marker. */
>> > +		pte_clear_not_present_full(walk->mm, addr, pte, false);
>> > +		update_mmu_cache(walk->vma, addr, pte);
>> > +	}
>> > +
>> > +	return 0;
>> > +}
>> > +
>> > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
>> > +	.pte_entry		= guard_unpoison_pte_entry,
>> > +	.walk_lock		= PGWALK_RDLOCK,
>> > +};
>> > +
>> > +static long madvise_guard_unpoison(struct vm_area_struct *vma,
>> > +				   struct vm_area_struct **prev,
>> > +				   unsigned long start, unsigned long end)
>> > +{
>> > +	*prev = vma;
>> > +	/*
>> > +	 * We're ok with unpoisoning mlock()'d ranges, as this is a
>> > +	 * non-destructive action.
>> > +	 */
>> > +	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
>> > +		return -EINVAL;
>> > +
>> > +	return walk_page_range(vma->vm_mm, start, end,
>> > +			       &guard_unpoison_walk_ops, NULL);
>> > +}
>> > +
>> >  /*
>> >   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
>> >   * will handle splitting a vm area into separate areas, each area with its own
>> > @@ -1098,6 +1260,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
>> >  		break;
>> >  	case MADV_COLLAPSE:
>> >  		return madvise_collapse(vma, prev, start, end);
>> > +	case MADV_GUARD_POISON:
>> > +		return madvise_guard_poison(vma, prev, start, end);
>> > +	case MADV_GUARD_UNPOISON:
>> > +		return madvise_guard_unpoison(vma, prev, start, end);
>> >  	}
>> >
>> >  	anon_name = anon_vma_name(vma);
>> > @@ -1197,6 +1363,8 @@ madvise_behavior_valid(int behavior)
>> >  	case MADV_DODUMP:
>> >  	case MADV_WIPEONFORK:
>> >  	case MADV_KEEPONFORK:
>> > +	case MADV_GUARD_POISON:
>> > +	case MADV_GUARD_UNPOISON:
>> >  #ifdef CONFIG_MEMORY_FAILURE
>> >  	case MADV_SOFT_OFFLINE:
>> >  	case MADV_HWPOISON:
>> > diff --git a/mm/mprotect.c b/mm/mprotect.c
>> > index 0c5d6d06107d..d0e3ebfadef8 100644
>> > --- a/mm/mprotect.c
>> > +++ b/mm/mprotect.c
>> > @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
>> >  			} else if (is_pte_marker_entry(entry)) {
>> >  				/*
>> >  				 * Ignore error swap entries unconditionally,
>> > -				 * because any access should sigbus anyway.
>> > +				 * because any access should sigbus/sigsegv
>> > +				 * anyway.
>> >  				 */
>> >  				if (is_poisoned_swp_entry(entry))
>> >  					continue;
>> > diff --git a/mm/mseal.c b/mm/mseal.c
>> > index ece977bd21e1..21bf5534bcf5 100644
>> > --- a/mm/mseal.c
>> > +++ b/mm/mseal.c
>> > @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
>> >  	case MADV_REMOVE:
>> >  	case MADV_DONTFORK:
>> >  	case MADV_WIPEONFORK:
>> > +	case MADV_GUARD_POISON:
>> >  		return true;
>> >  	}
>> >
>>


