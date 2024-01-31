Return-Path: <linux-arch+bounces-1918-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB30844163
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 15:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87B341F28C04
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 14:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8555F82877;
	Wed, 31 Jan 2024 14:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSEHprF0";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iSEHprF0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 843BE8287D;
	Wed, 31 Jan 2024 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706710106; cv=none; b=W+P6jFmph/eU8KbilBZdUTngfb9B1xPxYaoh56BkCgZOPoLxTi1yeLVOoTFxhQaaow5rRXrl76Q90Ud49YP2DD6ELzeBb84wrK5tdiGBlXQEmxVrcPvItliCExYV0WCQVnLIBZ1SeXdOUsAjxIpXBIhMXpUi90zz6gP8Ydw58co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706710106; c=relaxed/simple;
	bh=3bBGDiC+iLLfbFCr0Y/tzrO6leqGANNw5Kh/oe9Vwg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AbKKGx6WgNvm5GF6atyfmqjVmfaELqSuowWL1xaUFAhdEdu8y6hjYDb1dKZss4wWN2LG+LgitlZ69hGu+kNY1DBxUnDHkIqZjj128u6CQFk3EqpK+rAY/kAwjWNUQbCC7Bz5HGyK6A9hTvVQfsfoQdjg4QsMJfiIguZpUI7FouU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSEHprF0; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=iSEHprF0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 993861FD26;
	Wed, 31 Jan 2024 14:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706710102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QBlcBFQ70dBmJ1QalBIL8KQeMx+/Q9hcR6vftscUEI=;
	b=iSEHprF0INt/D7UKM9hRWvLJnUJagimTIPH9XzuELgAB5oBVBaanBUFxkrpQT+w3xSf7SP
	DdU0hYcxD6j2Zw59sBJlaE+3fR2GmmdLXjul6ib56FGi/8nY+CgfUucJ3Efw+KHMNaWLSF
	3IW7BlmrnYdSbybZBBS8j2jqjj8myAg=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1706710102; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2QBlcBFQ70dBmJ1QalBIL8KQeMx+/Q9hcR6vftscUEI=;
	b=iSEHprF0INt/D7UKM9hRWvLJnUJagimTIPH9XzuELgAB5oBVBaanBUFxkrpQT+w3xSf7SP
	DdU0hYcxD6j2Zw59sBJlaE+3fR2GmmdLXjul6ib56FGi/8nY+CgfUucJ3Efw+KHMNaWLSF
	3IW7BlmrnYdSbybZBBS8j2jqjj8myAg=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F67A139B1;
	Wed, 31 Jan 2024 14:08:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id K5iYGlZUumVrEAAAD6G6ig
	(envelope-from <mhocko@suse.com>); Wed, 31 Jan 2024 14:08:22 +0000
Date: Wed, 31 Jan 2024 15:08:21 +0100
From: Michal Hocko <mhocko@suse.com>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Yin Fengwei <fengwei.yin@intel.com>, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
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
Message-ID: <ZbpUVXa-Aujp6gWO@tiehlicka>
References: <20240129143221.263763-1-david@redhat.com>
 <4ef64fd1-f605-4ddf-82e6-74b5e2c43892@intel.com>
 <ee94b8ca-9723-44c0-aa17-75c9678015c6@redhat.com>
 <1fd26a83-8e6f-4b96-9d27-dd46de9488cc@arm.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fd26a83-8e6f-4b96-9d27-dd46de9488cc@arm.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b=iSEHprF0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.04 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 R_RATELIMIT(0.00)[to_ip_from(RL7kzhjumjg4a5c3mj7potudi1)];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.com:s=susede1];
	 DKIM_TRACE(0.00)[suse.com:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_TWELVE(0.00)[26];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:dkim];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[redhat.com,intel.com,vger.kernel.org,linux-foundation.org,kvack.org,infradead.org,arm.com,kernel.org,linux.ibm.com,gmail.com,ellerman.id.au,csgroup.eu,arndb.de,lists.ozlabs.org];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.03)[54.97%]
X-Spam-Score: -1.04
X-Rspamd-Queue-Id: 993861FD26
X-Spam-Flag: NO

On Wed 31-01-24 10:26:13, Ryan Roberts wrote:
> IIRC there is an option to zero memory when it is freed back to the buddy? So
> that could be a place where time is proportional to size rather than
> proportional to folio count? But I think that option is intended for debug only?
> So perhaps not a problem in practice?

init_on_free is considered a security/hardening feature more than a
debugging one. It will surely add an overhead and I guess this is
something people who use it know about. The batch size limit is a latency
reduction feature for !PREEMPT kernels but by no means it should be
considered low latency guarantee feature. A lot of has changed since
the limit was introduced and the current latency numbers will surely be
different than back then. As long as soft lockups do not trigger again
this should be acceptable IMHO.

-- 
Michal Hocko
SUSE Labs

