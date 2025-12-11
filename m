Return-Path: <linux-arch+bounces-15337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 11E18CB4C7D
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 06:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5DD94300D49C
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D426A1AC;
	Thu, 11 Dec 2025 05:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LfrdNDRS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0EALqYV0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="2Tq+rJ79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="404DSq8H"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0581620F08D
	for <linux-arch@vger.kernel.org>; Thu, 11 Dec 2025 05:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765431677; cv=none; b=WUeIclO/R/wbiFU7gv7KCFpDr9I/wfZL02N/ksFkzTPwKjvklh1KhQMGmdzv7zh+xxznZaEHyAeqlGfzkHbioeKchJpskd1yZREjg4A15xJXBSXrbbwmK4qE2z96VLAnFiI7RQXbrTweqymTrbbd1qdy4WmHm1DiWA8wLQ6dWfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765431677; c=relaxed/simple;
	bh=JrGOQsRV+c+tCt2U9SaFJLz7OEZURpwyslukpQ0/feo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRzq18H3OJsPgdmaZMCIIeny7zWAsFuTTMhwfbfNZXaZoHlYbn1WLdC9UUjvPJzeCDB6e6bX5BrYCm+ErSktYo0shvNuLwWDOvsl5GL+5oMGu15mjXjoB6IH7X6K+Mh6wYCyeu1BaKcMFXOVKcIP5JBJkQS0JgIiEcieqisW4fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=LfrdNDRS; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=0EALqYV0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=2Tq+rJ79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=404DSq8H; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15953336DB;
	Thu, 11 Dec 2025 05:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431674; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=du9Vw+WqFZYX8WYrnsA4KjpWmVFOAiC43jEmgEbVbFY=;
	b=LfrdNDRSDzEjVZQwVgCrlhGuwjLBpbslVk0U//lXUx6GnslouBf2CAT8KLlB8Zyi88dkHN
	YOUnj4EGu4S9/5tjeZE9lFQize7+fTlWyTSONIZIXSfQBBplyD3dV1G0U63Qcv+MQSXZBI
	KufPLQmLyJILZY8/FYi1zERwtqKhqmc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431674;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=du9Vw+WqFZYX8WYrnsA4KjpWmVFOAiC43jEmgEbVbFY=;
	b=0EALqYV05VlztcABwHmdHIix8Cg7/M4snqUNUKziLo8Uf12sD+r8L5HvLHCwV4uIvR0zUw
	72Hr+Ho/+THJH3AQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=2Tq+rJ79;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=404DSq8H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1765431673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=du9Vw+WqFZYX8WYrnsA4KjpWmVFOAiC43jEmgEbVbFY=;
	b=2Tq+rJ79md/OZ353tMg6n2dQDSTYVJ9HXa4Ja7UH+jpTPqbJnAXK4w7ns0MCnxwdrtcDud
	xUW1Std72qszdujnExTNuFwmyDLUCWsmzVF9QtbZL1kYdCbKmweDiGVm8pEhAVuGWebje+
	e2bLZn2o2yj3XHS88+ZlXfCbhg2ANIg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1765431673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=du9Vw+WqFZYX8WYrnsA4KjpWmVFOAiC43jEmgEbVbFY=;
	b=404DSq8HQoDnXLGc6XlgUdvk4NJrKB+UIvumgQz1rWjXIsC8Bjtxew6i2DMaEhWlShwFAb
	ccVT9TTxjpOMpvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D611F3EA63;
	Thu, 11 Dec 2025 05:41:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id cnNVMXdZOmnRMQAAD6G6ig
	(envelope-from <osalvador@suse.de>); Thu, 11 Dec 2025 05:41:11 +0000
Date: Thu, 11 Dec 2025 06:41:10 +0100
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
Subject: Re: [PATCH v1 2/4] mm/hugetlb: fix two comments related to
 huge_pmd_unshare()
Message-ID: <aTpZdhXljlYcnek7@localhost.localdomain>
References: <20251205213558.2980480-1-david@kernel.org>
 <20251205213558.2980480-3-david@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251205213558.2980480-3-david@kernel.org>
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kvack.org,kernel.org,linux-foundation.org,gmail.com,infradead.org,arndb.de,linux.dev,oracle.com,suse.cz,google.com,suse.de,surriel.com,redhat.com,huawei.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,localhost.localdomain:mid,suse.de:dkim,suse.de:email]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 15953336DB
X-Spam-Flag: NO
X-Spam-Score: -3.01

On Fri, Dec 05, 2025 at 10:35:56PM +0100, David Hildenbrand (Red Hat) wrote:
> Ever since we stopped using the page count to detect shared PMD
> page tables, these comments are outdated.
> 
> The only reason we have to flush the TLB early is because once we drop
> the i_mmap_rwsem, the previously shared page table could get freed (to
> then get reallocated and used for other purpose). So we really have to
> flush the TLB before that could happen.
> 
> So let's simplify the comments a bit.
> 
> The "If we unshared PMDs, the TLB flush was not recorded in mmu_gather."
> part introduced as in commit a4a118f2eead ("hugetlbfs: flush TLBs
> correctly after huge_pmd_unshare") was confusing: sure it is recorded
> in the mmu_gather, otherwise tlb_flush_mmu_tlbonly() wouldn't do
> anything. So let's drop that comment while at it as well.
> 
> We'll centralize these comments in a single helper as we rework the code
> next.
> 
> Fixes: 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count")
> Cc: Liu Shixin <liushixin2@huawei.com>
> Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>

Acked-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

