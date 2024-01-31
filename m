Return-Path: <linux-arch+bounces-1916-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2642A84413D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 15:04:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE98D2883CB
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817A079DB8;
	Wed, 31 Jan 2024 14:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WLhYD4V/";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="WLhYD4V/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D7956B9D;
	Wed, 31 Jan 2024 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706709835; cv=none; b=KqnzXkBtc3Q43GTitseB39PWa172hE4w13j6sikBANWgrCUeAXjNSoZH9Q3RtKX+hImiXPisqnPeVSgGqnKfKDNOKLB0ik5nMcIbb21Dx7Tne0uWZwklqMsru/jX5UA29qk4Y1GrDnBY3D9IDtWxG0uo0bZC8g0USShOGJZZzZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706709835; c=relaxed/simple;
	bh=yK5tDuzjN62NKpY1IUEhVf1AyPpCBKY++LbxRsHYWaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rJmhGH16zyr2Pzj47wm/QsITtiIBca4LC2cejiipW1OLciE7ZbBu4wV1rPTjSEAJnuUetoPdFtB2YL8j0X7FeTc4BeiZVIlJBgCmvohhnac7z6Dj4X2N7NAHyiZdANr7ThviBhrDpibv2W07p0+bsxy/98JO/QUbqJ5v3uzDgyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WLhYD4V/; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=WLhYD4V/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E1AE41FB8A;
	Wed, 31 Jan 2024 14:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706709827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2cxDnakp497+YroEa+q5vx8Sh99BmyBojVBJFGfpzs=;
	b=WLhYD4V/x/UZrHhY+6rCUJyqgymCrrsKeuLtGDQJmSHaoC3k23j7X0NG3vOMfDtXnIsMtY
	jZ5h10f3ZWcsECbVFDV7u/QcfFFmgBDZc+aS1k+0Rtk506F6YwOW9pHPE/hJ/vKoBvOmPc
	ryDw7jWI4W009OBH2S6hA4+jm0itigA=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706709827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m2cxDnakp497+YroEa+q5vx8Sh99BmyBojVBJFGfpzs=;
	b=WLhYD4V/x/UZrHhY+6rCUJyqgymCrrsKeuLtGDQJmSHaoC3k23j7X0NG3vOMfDtXnIsMtY
	jZ5h10f3ZWcsECbVFDV7u/QcfFFmgBDZc+aS1k+0Rtk506F6YwOW9pHPE/hJ/vKoBvOmPc
	ryDw7jWI4W009OBH2S6hA4+jm0itigA=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BDC6F1347F;
	Wed, 31 Jan 2024 14:03:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mJp5LENTumVaDwAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 31 Jan 2024 14:03:47 +0000
Date: Wed, 31 Jan 2024 15:03:47 +0100
From: Michal Hocko <mhocko@suse.com>
To: David Hildenbrand <david@redhat.com>
Cc: Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATCH v1 0/9] mm/memory: optimize unmap/zap with PTE-mapped THP
Message-ID: <ZbpTQ80ebCUnAXW0@tiehlicka>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
 <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 R_RATELIMIT(0.00)[to_ip_from(RLmz57jmx331iqhbrcj9q94ym8)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 RCPT_COUNT_TWELVE(0.00)[26];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[intel.com,vger.kernel.org,linux-foundation.org,kvack.org,infradead.org,arm.com,kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,csgroup.eu,arndb.de,lists.ozlabs.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[28.90%]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: 0.40

On Wed 31-01-24 11:16:01, David Hildenbrand wrote:
[...]
> This 10000 pages limit was introduced in 53a59fc67f97 ("mm: limit mmu_gather
> batching to fix soft lockups on !CONFIG_PREEMPT") where we wanted to handle
> soft-lockups.

AFAIR at the time of this patch this was mostly just to put some cap on
the number of batches to collect and free at once. If there is a lot of
free memory and a large process exiting this could grow really high. Now
that those pages^Wfolios can represent larger memory chunks it could
mean more physical memory being freed but from which might make the
operation take longer but still far from soft lockup triggering.

Now latency might suck on !PREEMPT kernels with too many pages to
free in a single batch but I guess this is somehow expected for this
preemption model. The soft lockup has to be avoided because this can
panic the machine in some configurations.

-- 
Michal Hocko
SUSE Labs

