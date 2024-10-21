Return-Path: <linux-arch+bounces-8349-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50AAB9A6BD1
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 16:13:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E1280E8E
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 14:13:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE551F472D;
	Mon, 21 Oct 2024 14:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXFYG/M1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="292U25mV";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="qXFYG/M1";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="292U25mV"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1107B1D173A;
	Mon, 21 Oct 2024 14:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729520020; cv=none; b=jXzzeVoAI0QJ3Ejs4oIkJiONykKsJfY9qqx98yAHxg6GaOvJyFzueN+kbkI3YiHi4ZKlALMdgF+igul4yTfScczrpktReGJHmi7TyxgU7z+JRL/N3jvk+X6yzAceCX6nht7AARHEejJoLlfRbQTynl7e5J8cK2XTZdSjKlJyO74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729520020; c=relaxed/simple;
	bh=55zMCuXzSEAvfzXHJj2MHyQminjLF9zOcHArGyQPvy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QuCs0galiL6OMgaikCCBcZVKgdWA/TVD3P+4h47QbfZ7RnlIrKMQCQHl1e7N/+7VDA43aPs21GfkhE6Pn14rtXXpOTTo7NbR78L2Vn4cUMnAWysRcHYzQU48Pv/2cc6iAMiot/6j7jGIfLmSN2At4Y7PkQbdSgGBLG6rzfmdznE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXFYG/M1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=292U25mV; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=qXFYG/M1; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=292U25mV; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 26A7521E7C;
	Mon, 21 Oct 2024 14:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729520015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyhbF/edolYkSSJeB9ofnUaVvEXdp0SuMQyMEkHiIVs=;
	b=qXFYG/M1qE1BVtBLwWkeblrQiBVDTDUZevQAJvwOXeVkm52aPUAsVY5ixIESQjIj+a0yTA
	CcYkoVxKoZhsoe70jnhB8Zv/ZGm+4TapaCBy/aIhaGr3srJdudKpdTvTaKunjxmWFLDnng
	YbE4grGgwSfuAPf/jmB4cBwBnlV+Nm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729520015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyhbF/edolYkSSJeB9ofnUaVvEXdp0SuMQyMEkHiIVs=;
	b=292U25mVoWOZYFQelSghDKj01ojNgCy7hp7TwaRMyAMMUM7rIIWpA9aVHZDGZdYajamZ4N
	Aa0qgMD19s1YxiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1729520015; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyhbF/edolYkSSJeB9ofnUaVvEXdp0SuMQyMEkHiIVs=;
	b=qXFYG/M1qE1BVtBLwWkeblrQiBVDTDUZevQAJvwOXeVkm52aPUAsVY5ixIESQjIj+a0yTA
	CcYkoVxKoZhsoe70jnhB8Zv/ZGm+4TapaCBy/aIhaGr3srJdudKpdTvTaKunjxmWFLDnng
	YbE4grGgwSfuAPf/jmB4cBwBnlV+Nm4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1729520015;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fyhbF/edolYkSSJeB9ofnUaVvEXdp0SuMQyMEkHiIVs=;
	b=292U25mVoWOZYFQelSghDKj01ojNgCy7hp7TwaRMyAMMUM7rIIWpA9aVHZDGZdYajamZ4N
	Aa0qgMD19s1YxiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D7F87139E0;
	Mon, 21 Oct 2024 14:13:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ErIbNI5hFmc4UQAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 21 Oct 2024 14:13:34 +0000
Message-ID: <470886d2-9f6f-4486-a935-daea4c5bea09@suse.cz>
Date: Mon, 21 Oct 2024 16:13:34 +0200
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
 Christoph Hellwig <hch@infradead.org>, linux-api@vger.kernel.org,
 John Hubbard <jhubbard@nvidia.com>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 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
 EP+ylKVEKb0Q2A==
In-Reply-To: <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
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
	FREEMAIL_CC(0.00)[google.com,oracle.com,infradead.org,kernel.org,redhat.com,kvack.org,vger.kernel.org,linux.dev,linaro.org,jurassic.park.msu.ru,gmail.com,alpha.franken.de,HansenPartnership.com,gmx.de,zankel.net,arndb.de,chromium.org,nvidia.com];
	R_RATELIMIT(0.00)[to_ip_from(RL3py1j7x8bxoj6nr7eaeb97sq)];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Flag: NO

On 10/20/24 18:20, Lorenzo Stoakes wrote:
> Add a new PTE marker that results in any access causing the accessing
> process to segfault.
> 
> This is preferable to PTE_MARKER_POISONED, which results in the same
> handling as hardware poisoned memory, and is thus undesirable for cases
> where we simply wish to 'soft' poison a range.
> 
> This is in preparation for implementing the ability to specify guard pages
> at the page table level, i.e. ranges that, when accessed, should cause
> process termination.
> 
> Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
> function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
> purpose was simply incorrect.
> 
> We then reuse the same logic to determine whether a zap should clear a
> guard entry - this should only be performed on teardown and never on
> MADV_DONTNEED or the like.

Since I would have personally put MADV_FREE among "or the like" here, it's
surprising to me that it in fact it's tearing down the guard entries now. Is
that intentional? It should be at least mentioned very explicitly. But I'd
really argue against it, as MADV_FREE is to me a weaker form of
MADV_DONTNEED - the existing pages are not zapped immediately but
prioritized for reclaim. If MADV_DONTNEED leaves guard PTEs in place, why
shouldn't MADV_FREE too?

Seems to me rather currently an artifact of MADV_FREE implementation - if it
encounters hwpoison entries it will tear them down because why not, we have
detected a hw memory error and are lucky the program wants to discard the
pages and not access them, so best use the opportunity and get rid of the
PTE entries immediately (if MADV_DONTNEED doesn't do that too, it certainly
could).

But to extend this to guard PTEs which are result of an explicit userspace
action feels wrong, unless the semantics is the same for MADV_DONTEED. The
semantics chosen for MADV_DONTNEED makes sense, so MADV_FREE should behave
the same?

> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  include/linux/mm_inline.h |  2 +-
>  include/linux/swapops.h   | 26 ++++++++++++++++++++++++--
>  mm/hugetlb.c              |  3 +++
>  mm/memory.c               | 18 +++++++++++++++---
>  4 files changed, 43 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 355cf46a01a6..1b6a917fffa4 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -544,7 +544,7 @@ static inline pte_marker copy_pte_marker(
>  {
>  	pte_marker srcm = pte_marker_get(entry);
>  	/* Always copy error entries. */
> -	pte_marker dstm = srcm & PTE_MARKER_POISONED;
> +	pte_marker dstm = srcm & (PTE_MARKER_POISONED | PTE_MARKER_GUARD);
>  
>  	/* Only copy PTE markers if UFFD register matches. */
>  	if ((srcm & PTE_MARKER_UFFD_WP) && userfaultfd_wp(dst_vma))
> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index cb468e418ea1..4d0606df0791 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -426,9 +426,15 @@ typedef unsigned long pte_marker;
>   * "Poisoned" here is meant in the very general sense of "future accesses are
>   * invalid", instead of referring very specifically to hardware memory errors.
>   * This marker is meant to represent any of various different causes of this.
> + *
> + * Note that, when encountered by the faulting logic, PTEs with this marker will
> + * result in VM_FAULT_HWPOISON and thus regardless trigger hardware memory error
> + * logic.
>   */
>  #define  PTE_MARKER_POISONED			BIT(1)
> -#define  PTE_MARKER_MASK			(BIT(2) - 1)
> +/* Indicates that, on fault, this PTE will case a SIGSEGV signal to be sent. */
> +#define  PTE_MARKER_GUARD			BIT(2)
> +#define  PTE_MARKER_MASK			(BIT(3) - 1)
>  
>  static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
>  {
> @@ -461,9 +467,25 @@ static inline swp_entry_t make_poisoned_swp_entry(void)
>  }
>  
>  static inline int is_poisoned_swp_entry(swp_entry_t entry)
> +{
> +	/*
> +	 * We treat guard pages as poisoned too as these have the same semantics
> +	 * as poisoned ranges, only with different fault handling.
> +	 */
> +	return is_pte_marker_entry(entry) &&
> +		(pte_marker_get(entry) &
> +		 (PTE_MARKER_POISONED | PTE_MARKER_GUARD));
> +}
> +
> +static inline swp_entry_t make_guard_swp_entry(void)
> +{
> +	return make_pte_marker_entry(PTE_MARKER_GUARD);
> +}
> +
> +static inline int is_guard_swp_entry(swp_entry_t entry)
>  {
>  	return is_pte_marker_entry(entry) &&
> -	    (pte_marker_get(entry) & PTE_MARKER_POISONED);
> +		(pte_marker_get(entry) & PTE_MARKER_GUARD);
>  }
>  
>  /*
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 906294ac85dc..50e3f6ed73ac 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
>  				ret = VM_FAULT_HWPOISON_LARGE |
>  				      VM_FAULT_SET_HINDEX(hstate_index(h));
>  				goto out_mutex;
> +			} else if (marker & PTE_MARKER_GUARD) {
> +				ret = VM_FAULT_SIGSEGV;
> +				goto out_mutex;
>  			}
>  		}
>  
> diff --git a/mm/memory.c b/mm/memory.c
> index 0f614523b9f4..551455cd453f 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
>  	return !folio_test_anon(folio);
>  }
>  
> -static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
> +static inline bool zap_drop_markers(struct zap_details *details)
>  {
>  	if (!details)
>  		return false;
> @@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
>  	if (vma_is_anonymous(vma))
>  		return;
>  
> -	if (zap_drop_file_uffd_wp(details))
> +	if (zap_drop_markers(details))
>  		return;
>  
>  	for (;;) {
> @@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			 * drop the marker if explicitly requested.
>  			 */
>  			if (!vma_is_anonymous(vma) &&
> -			    !zap_drop_file_uffd_wp(details))
> +			    !zap_drop_markers(details))
> +				continue;
> +		} else if (is_guard_swp_entry(entry)) {
> +			/*
> +			 * Ordinary zapping should not remove guard PTE
> +			 * markers. Only do so if we should remove PTE markers
> +			 * in general.
> +			 */
> +			if (!zap_drop_markers(details))
>  				continue;
>  		} else if (is_hwpoison_entry(entry) ||
>  			   is_poisoned_swp_entry(entry)) {
> @@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
>  	if (marker & PTE_MARKER_POISONED)
>  		return VM_FAULT_HWPOISON;
>  
> +	/* Hitting a guard page is always a fatal condition. */
> +	if (marker & PTE_MARKER_GUARD)
> +		return VM_FAULT_SIGSEGV;
> +
>  	if (pte_marker_entry_uffd_wp(entry))
>  		return pte_marker_handle_uffd_wp(vmf);
>  


