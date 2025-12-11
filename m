Return-Path: <linux-arch+bounces-15336-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60388CB4C6B
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 06:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A287B30014D8
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 05:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDED26A1AC;
	Thu, 11 Dec 2025 05:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RzKDUUTv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="enhJYY3w";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="GeSjbtlv";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="wnSsMKH1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B561DF27F
	for <linux-arch@vger.kernel.org>; Thu, 11 Dec 2025 05:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431491; cv=none; b=Pr3ih0S2P5fz10FBVfJuVvhU0Na+aNd+8VUEK6sqLKiKDUu42rOA5IItwgUTsRLNHH1HF1muL2+dW5Ev2vGkbuR2sGxQBSwdLnksUydEoPaqSErrebPTsrQxEveWLKpLD6vDj68n5Y8kpmhMKadAFaLKPGfEUQr+VxyfIoSz/8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431491; c=relaxed/simple;
	bh=yJHDLHWkAIeaHbJweUWq+dIRmmHcEXV9nPFwuwW4glA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/trWmGwNe8iicis5BG2xlovFjpze+F1VE94DIeGNrrt/L4wb+sj1mda1ptPF/Y9Yos0iR+0bXPtxO2jkdoTIfLhExeCbPmdiYZqxifg6whcYwIwYPNKm54d12z9gorAKJRyZy9ATydi18+MgYGrTKQxuWMrM1hqCqxE8Zqqn1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RzKDUUTv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=enhJYY3w; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=GeSjbtlv; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=wnSsMKH1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 864105BDA6;
	Thu, 11 Dec 2025 05:38:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431487; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPZrLEmjQ4PxA/58AozD92W3ErV/wZxGz5NUQYproPQ=;
	b=RzKDUUTvktb6lu4JXR3lHWXoaWHxP2wTZGqQgbFD3xDriMqu6T4saOyqou9uV02lpE6aOu
	S3WX5pcqjd8ZgSoXS2lsfEFNObYyWhI/Id1+mFWvlNrA63JOBfPr/5l2v23upkAcrDiZ82
	+Dz0D2vwO15nDzDVlt5V8Lp/BPkVm4A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431487;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPZrLEmjQ4PxA/58AozD92W3ErV/wZxGz5NUQYproPQ=;
	b=enhJYY3wXxqj14AbSbTlday5ZXhDXMxtnh7uphmTAr7wJFIVbDfHLbq9upeDMjHgbUOUzg
	eQc1Ic/BhfKK9hDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPZrLEmjQ4PxA/58AozD92W3ErV/wZxGz5NUQYproPQ=;
	b=GeSjbtlvbpFSEkYqxK/4MCNW46dr2r39hdVHZsWc1Ja/5wGht0GP2mRrH4+M38jGMrX2sn
	8UGnwPJ74asGzaTRh0bn/dFKLJPiwiSUyeH3rOK0NaPLP4wd75wX6AsGFsrsfg0zbx7J+e
	6RkUB1/DXfkQZrcf1lR9hEtdMUYV32c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JPZrLEmjQ4PxA/58AozD92W3ErV/wZxGz5NUQYproPQ=;
	b=wnSsMKH1sAnyC1qqq1pPo9t5dEHQP3gNip9KHlpJzy97LupYGirH5A1RZ7dr/vhQbhiOfs
	hgVDQuoyDZcb0gCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4020B3EA63;
	Thu, 11 Dec 2025 05:38:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id fuLNC71YOmkmLwAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 11 Dec 2025 05:38:05 +0000
Date: Thu, 11 Dec 2025 06:38:03 +0100
From: Oscar Salvador <osalvador@suse.de>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-mm@kvack.org, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>, Muchun Song <muchun.song@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
	Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Laurence Oberman <loberman@redhat.com>,
	Prakash Sangappa <prakash.sangappa@oracle.com>,
	Nadav Amit <nadav.amit@gmail.com>, stable@vger.kernel.org,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 1/4] mm/hugetlb: fix hugetlb_pmd_shared()
Message-ID: <aTpYu4gQmFCFh69X@localhost.localdomain>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-2-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-2-david@kernel.org>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[23];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,gmail.com,infradead.org,arndb.de,linux.dev,oracle.com,suse.cz,google.com,suse.de,surriel.com,redhat.com,huawei.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:helo,suse.de:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Dec 05, 2025 at 10:35:55PM +0100, David Hildenbrand (Red Hat) wrote:
> We switched from (wrongly) using the page count to an independent
> shared count. Now, shared page tables have a refcount of 1 (excluding
> speculative references) and instead use ptdesc->pt_share_count to
> identify sharing.
> 
> We didn't convert hugetlb_pmd_shared(), so right now, we would never
> detect a shared PMD table as such, because sharing/unsharing no longer
> touches the refcount of a PMD table.
> 
> Page migration, like mbind() or migrate_pages() would allow for migrating
> folios mapped into such shared PMD tables, even though the folios are
> not exclusive. In smaps we would account them as "private" although they
> are "shared", and we would be wrongly setting the PM_MMAP_EXCLUSIVE in the
> pagemap interface.
> 
> Fix it by properly using ptdesc_pmd_is_shared() in hugetlb_pmd_shared().
> 
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: <stable@vger.kernel.org>
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Good catch David,

Acked-by: Oscar Salvador <osalvador@suse.de>

> ---
>  include/linux/hugetlb.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index 019a1c5281e4e..03c8725efa289 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -1326,7 +1326,7 @@ static inline __init void hugetlb_cma_reserve(int order)
>  #ifdef CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
>  {
> -	return page_count(virt_to_page(pte)) > 1;
> +	return ptdesc_pmd_is_shared(virt_to_ptdesc(pte));
>  }
>  #else
>  static inline bool hugetlb_pmd_shared(pte_t *pte)
> -- 
> 2.52.0
> 
> 

-- 
Oscar Salvador
SUSE Labs

