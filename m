Return-Path: <linux-arch+bounces-8550-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C13F9B0CE5
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 20:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EFC21C223AF
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 18:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA1720A5DE;
	Fri, 25 Oct 2024 18:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jnrff6cZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NgZMXIE";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jnrff6cZ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="3NgZMXIE"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C7320BB3C;
	Fri, 25 Oct 2024 18:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729880011; cv=none; b=GfhM+IuwHtthdYlHhPWRByy0m4VNlnESb0nN1phVkchiohmxrNsPGNrtXPl0yCIiBJi4IERvfzlzShqmkS4MeV/RiBSLkpJmZLNQA1V31ZjNoPesZpbu9gHBeNoSbOeqx5rLHsU6IAOwWATy1pYBQjzFvPlODqKjb57IRAM/In4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729880011; c=relaxed/simple;
	bh=/PDztJNHx/avwMtJDa4GSCL4ZVfxliImRbrp3B3rzL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+P85JE1LG8Rx56PoaB3cBxo9+PsF9DL13XKw1kfLYYSH9Z/KIRkqQ53cC7NToQlv5QgyFTPMcUteeubCi52DfGU/8l5lxzDj7hpEKtmCG66GXc2VQ9UDrfrzt1eOxme5X28DNYPE+tQiBPf8bjfYmOKLZEoYMC3VDOodrpavxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jnrff6cZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3NgZMXIE; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Jnrff6cZ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=3NgZMXIE; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 011E31FE29;
	Fri, 25 Oct 2024 18:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729880007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zKXJJEviamphxC/DA/8mSG5DEJnMjhmEflprXxZTXok=;
	b=Jnrff6cZgnegSXi9fKCBaBsAV7wjOxbBywa2Yrbp1Nc5KJ/20qOogMfdqgaUtE2nJye/H0
	vHmQm2sPJgy9stbr1gTKHyF9ii3nypSNfDCQV+A8eC+chXVx42hP3AVoMa6/on5+EkBsqP
	ICKmUybNlTRppjoOCXYCLEtgUtFpHms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729880007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zKXJJEviamphxC/DA/8mSG5DEJnMjhmEflprXxZTXok=;
	b=3NgZMXIE3ZBeAqZQyJ3SQbfDyHo/PPltA0sQ3+akKvPcFgWPIOzY2jRut8HKSvH97pGqSI
	IZTwamiefcKK7LCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729880007; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zKXJJEviamphxC/DA/8mSG5DEJnMjhmEflprXxZTXok=;
	b=Jnrff6cZgnegSXi9fKCBaBsAV7wjOxbBywa2Yrbp1Nc5KJ/20qOogMfdqgaUtE2nJye/H0
	vHmQm2sPJgy9stbr1gTKHyF9ii3nypSNfDCQV+A8eC+chXVx42hP3AVoMa6/on5+EkBsqP
	ICKmUybNlTRppjoOCXYCLEtgUtFpHms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729880007;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=zKXJJEviamphxC/DA/8mSG5DEJnMjhmEflprXxZTXok=;
	b=3NgZMXIE3ZBeAqZQyJ3SQbfDyHo/PPltA0sQ3+akKvPcFgWPIOzY2jRut8HKSvH97pGqSI
	IZTwamiefcKK7LCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D347132D3;
	Fri, 25 Oct 2024 18:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id HFLaG8bfG2edIQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Fri, 25 Oct 2024 18:13:26 +0000
Message-ID: <8b1854b5-5c0a-43b1-aed7-aa4e8b8e8a1a@suse.cz>
Date: Fri, 25 Oct 2024 20:13:26 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
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
 "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
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
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
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
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,chromium.org,nvidia.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)]
X-Spam-Flag: NO
X-Spam-Level: 

On 10/23/24 18:24, Lorenzo Stoakes wrote:
> The existing generic pagewalk logic permits the walking of page tables,
> invoking callbacks at individual page table levels via user-provided
> mm_walk_ops callbacks.
> 
> This is useful for traversing existing page table entries, but precludes
> the ability to establish new ones.
> 
> Existing mechanism for performing a walk which also installs page table
> entries if necessary are heavily duplicated throughout the kernel, each
> with semantic differences from one another and largely unavailable for use
> elsewhere.
> 
> Rather than add yet another implementation, we extend the generic pagewalk
> logic to enable the installation of page table entries by adding a new
> install_pte() callback in mm_walk_ops. If this is specified, then upon
> encountering a missing page table entry, we allocate and install a new one
> and continue the traversal.
> 
> If a THP huge page is encountered at either the PMD or PUD level we split
> it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
> otherwise if there is only an ops->install_pte(), we avoid the unnecessary
> split.
> 
> We do not support hugetlb at this stage.
> 
> If this function returns an error, or an allocation fails during the
> operation, we abort the operation altogether. It is up to the caller to
> deal appropriately with partially populated page table ranges.
> 
> If install_pte() is defined, the semantics of pte_entry() change - this
> callback is then only invoked if the entry already exists. This is a useful
> property, as it allows a caller to handle existing PTEs while installing
> new ones where necessary in the specified range.
> 
> If install_pte() is not defined, then there is no functional difference to
> this patch, so all existing logic will work precisely as it did before.
> 
> As we only permit the installation of PTEs where a mapping does not already
> exist there is no need for TLB management, however we do invoke
> update_mmu_cache() for architectures which require manual maintenance of
> mappings for other CPUs.
> 
> We explicitly do not allow the existing page walk API to expose this
> feature as it is dangerous and intended for internal mm use only. Therefore
> we provide a new walk_page_range_mm() function exposed only to
> mm/internal.h.
> 
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Just a small subjective suggestion in case you agree and there's a respin or
followups:

> @@ -109,18 +131,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
>  
>  		if (walk->action == ACTION_AGAIN)
>  			goto again;
> -
> -		/*
> -		 * Check this here so we only break down trans_huge
> -		 * pages when we _need_ to
> -		 */
> -		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
> -		    walk->action == ACTION_CONTINUE ||
> -		    !(ops->pte_entry))
> +		if (walk->action == ACTION_CONTINUE)
>  			continue;
> +		if (!ops->install_pte && !ops->pte_entry)
> +			continue; /* Nothing to do. */
> +		if (!ops->pte_entry && ops->install_pte &&
> +		    pmd_present(*pmd) &&
> +		    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
> +			continue; /* Avoid unnecessary split. */

Much better now, thanks, but maybe the last 2 parts could be:

if (!ops->pte_entry) {
	if (!ops->install_pte)
		continue; /* Nothing to do. */
	else if (pmd_present(*pmd)
		 && (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
		continue; /* Avoid unnecessary split. */
}

Or at least put !ops->pte_entry first in both conditions?

>  		if (walk->vma)
>  			split_huge_pmd(walk->vma, pmd, addr);
> +		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
> +			continue; /* Nothing to do. */
>  
>  		err = walk_pte_range(pmd, addr, next, walk);
>  		if (err)
> @@ -148,11 +171,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>   again:
>  		next = pud_addr_end(addr, end);
>  		if (pud_none(*pud)) {
> -			if (ops->pte_hole)
> +			if (ops->install_pte)
> +				err = __pmd_alloc(walk->mm, pud, addr);
> +			else if (ops->pte_hole)
>  				err = ops->pte_hole(addr, next, depth, walk);
>  			if (err)
>  				break;
> -			continue;
> +			if (!ops->install_pte)
> +				continue;
>  		}
>  
>  		walk->action = ACTION_SUBTREE;
> @@ -164,14 +190,20 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
>  
>  		if (walk->action == ACTION_AGAIN)
>  			goto again;
> -
> -		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
> -		    walk->action == ACTION_CONTINUE ||
> -		    !(ops->pmd_entry || ops->pte_entry))
> +		if (walk->action == ACTION_CONTINUE)
>  			continue;
> +		if (!ops->install_pte && !ops->pte_entry && !ops->pmd_entry)
> +			continue;  /* Nothing to do. */
> +		if (!ops->pmd_entry && !ops->pte_entry && ops->install_pte &&
> +		    pud_present(*pud) &&
> +		    (pud_trans_huge(*pud) || pud_devmap(*pud)))
> +			continue; /* Avoid unnecessary split. */

Ditto.

Thanks!


