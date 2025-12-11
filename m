Return-Path: <linux-arch+bounces-15338-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A5EECCB4C83
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 06:42:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 67EDB300E156
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 05:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6596288502;
	Thu, 11 Dec 2025 05:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5x1YOcd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nMWGwcZq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="J5x1YOcd";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nMWGwcZq"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C99256C71
	for <linux-arch@vger.kernel.org>; Thu, 11 Dec 2025 05:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431765; cv=none; b=c+MSYTyy0D6/Q8tKyPLw5VzNP0ZtHHyVo7OaWcdA2gqRfq1mZt82WTic2FBsrLXcoth2j6EHr3gmhiB170kQFBy7EaDq0lOOeo0R1oYIism4LPFtFAJwcF8WczWL2BPlvpukQm8js37wAmSms7wOz8+1MmBn//uVevECne5CLDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431765; c=relaxed/simple;
	bh=OjUepHTD4kO4MhqDAYXErrByLyQ7seB4s6qJqkP+asE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fggGtrgzFO2s/NYTB7G/6YaD5/3qQiAYiYd3kz3qjGvRSZNQyy5r9+eU5M/9fwONM/kdzHhoHvIKlXDkaLRfipjK+iLz7hdrL6ObB95VIFei5rWuc2PUX6jx3sr5mMX8W/LMnzZy1JRTdltmmCvhNg0ZX3g9C8+a3yCx+tsj48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5x1YOcd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nMWGwcZq; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=J5x1YOcd; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=nMWGwcZq; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 71D775BDA6;
	Thu, 11 Dec 2025 05:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpLRwabY1N9l3QqkPFaPN8m63+QPMyhsor2WdHWG+E=;
	b=J5x1YOcdxLiG6sDRFY74G9B6OMUyGnkzquvTad1SVja1yuuZh1uySu9Faw1cy/3fCRaGpx
	lzWIitr+w4dL9cql8kFY0Mvq4YQEJ6aEOYbbp8xdzMf2mMMCWkERitlp6Rb0I+0y6j9FGB
	RU3aTdV1j+OYH07Idb/bVCJ/3DRYI5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpLRwabY1N9l3QqkPFaPN8m63+QPMyhsor2WdHWG+E=;
	b=nMWGwcZqtaKI/QB5LHNEnC8POpFpAZLAlTcFxcpbl6DShkFMtGcn5qhiMgKOoy5/bPJAb9
	AzUiH/LG9yknicAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431762; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpLRwabY1N9l3QqkPFaPN8m63+QPMyhsor2WdHWG+E=;
	b=J5x1YOcdxLiG6sDRFY74G9B6OMUyGnkzquvTad1SVja1yuuZh1uySu9Faw1cy/3fCRaGpx
	lzWIitr+w4dL9cql8kFY0Mvq4YQEJ6aEOYbbp8xdzMf2mMMCWkERitlp6Rb0I+0y6j9FGB
	RU3aTdV1j+OYH07Idb/bVCJ/3DRYI5w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431762;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=UXpLRwabY1N9l3QqkPFaPN8m63+QPMyhsor2WdHWG+E=;
	b=nMWGwcZqtaKI/QB5LHNEnC8POpFpAZLAlTcFxcpbl6DShkFMtGcn5qhiMgKOoy5/bPJAb9
	AzUiH/LG9yknicAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3B6D53EA63;
	Thu, 11 Dec 2025 05:42:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6I2YC9FZOmn9MgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 11 Dec 2025 05:42:41 +0000
Date: Thu, 11 Dec 2025 06:42:35 +0100
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
	Nadav Amit <nadav.amit@gmail.com>,
	Liu Shixin <liushixin2@huawei.com>
Subject: Re: [PATCH v1 3/4] mm/rmap: fix two comments related to
 huge_pmd_unshare()
Message-ID: <aTpZy-_A-aFxpdn5@localhost.localdomain>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-4-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-4-david@kernel.org>
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,gmail.com,infradead.org,arndb.de,linux.dev,oracle.com,suse.cz,google.com,suse.de,surriel.com,redhat.com,huawei.com];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.80

On Fri, Dec 05, 2025 at 10:35:57PM +0100, David Hildenbrand (Red Hat) wrote:
> PMD page table unsharing no longer touches the refcount of a PMD page
> table. Also, it is not about dropping the refcount of a "PMD page" but
> the "PMD page table".
> 
> Let's just simplify by saying that the PMD page table was unmapped,
> consequently also unmapping the folio that was mapped into this page.
> 
> This code should be deduplicated in the future.
> 
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>

 

-- 
Oscar Salvador
SUSE Labs

