Return-Path: <linux-arch+bounces-12006-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 721B1ABD1F7
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 10:30:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103074A4136
	for <lists+linux-arch@lfdr.de>; Tue, 20 May 2025 08:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AACD25F99A;
	Tue, 20 May 2025 08:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vGhQgzmF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="q2/CXzht";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yGgm1HLO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="EwtpEmha"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55E26462B
	for <linux-arch@vger.kernel.org>; Tue, 20 May 2025 08:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747729830; cv=none; b=sCAEJSOdECGI0qLMfDi47P1BRRerNR4CG0eXNHkxbmRqiwoNI3BhM9CyPFOx9zzkPXt9p0g1KFzN0/KEo/4Ta9mBE2dXi25o6KW9uTYyWXaf6R5xN+tJylH9IZmT5ollhijfjvtdFpYSO7PTQ/1vaEvoxHey0KkGuDD2dW2UOKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747729830; c=relaxed/simple;
	bh=/fQPjhr2FlGu7v6arpnLobAbEo7XcdS+XWUxQulHdHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJIyw8YdZyw27ktZBcsZzetPDn1dHSMyyE8NyfCDBYjpdspfN5cPBGS05A0cYM3oLUv7n81ya7ij7VXzWfPqrdMb6paC3uCFVglhvpS24c5EepWJSxNGV+pERJLrUwAw3PXjWygeXMsyCJxrbEqCE3euvf9+FOVM+Af8GUNXJCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=vGhQgzmF; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=q2/CXzht; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=yGgm1HLO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=EwtpEmha; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7B7B222DA4;
	Tue, 20 May 2025 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747729825; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0vvTc3BqjsfxhPrLYsVT2k24G5VQJhACirAim5nxeQ=;
	b=vGhQgzmFi8fjR+tDGq02qQ5AXFQ5vrkO1m1zPl1wZjAg9J5M8iS6KBkiTvHyve4vGsLBEp
	PihDCwlsV4GygSNPjvqB4UzJ+VxdWBE+Y2bj/msO/ybBxQryUD9qGnD6zNdP9+FJZLc5iR
	9EoFFExxM3RoUCpmuNdNHxEaD1rPIJI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747729825;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0vvTc3BqjsfxhPrLYsVT2k24G5VQJhACirAim5nxeQ=;
	b=q2/CXzhtOBIGik5sGsM3Tu0NBFjPHaci6Yo7JQikg2W9tJ7AUdkdcNoAGG/0+2RlWYiqHx
	qK32bFw0DR7+VlCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yGgm1HLO;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=EwtpEmha
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1747729824; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0vvTc3BqjsfxhPrLYsVT2k24G5VQJhACirAim5nxeQ=;
	b=yGgm1HLOpwL5YAGVO5Jkm3q2rSeWde84wZO0zH/wT+j5LyD0083Atj6URbXHEEknKz1GFn
	ECWJoEnOLqESz1XGe8JKEdFs+lgWmdldE8tgOSsi/1zMmyh7rj1z3ZLD7fprxRKHuFY8HN
	gdEbyNhJWacuQICT90WdCmv73lr4hYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1747729824;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Q0vvTc3BqjsfxhPrLYsVT2k24G5VQJhACirAim5nxeQ=;
	b=EwtpEmhaNTjSHoNWZKk7uvEWahLSNf1tqta7PZN5CsFnmirB1xnHIT105mRBUa0CRV7nwA
	eA2ms+J+3u1loJDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5670213888;
	Tue, 20 May 2025 08:30:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id mUMCFKA9LGjgSgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 20 May 2025 08:30:24 +0000
Date: Tue, 20 May 2025 10:30:18 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Pratyush Yadav <ptyadav@amazon.de>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/cma: make detection of highmem_start more robust
Message-ID: <aCw9mpmhx9SrL8Oy@localhost.localdomain>
References: <20250519171805.1288393-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519171805.1288393-1-rppt@kernel.org>
X-Rspamd-Action: no action
X-Spam-Level: 
X-Rspamd-Queue-Id: 7B7B222DA4
X-Spam-Score: -1.51
X-Spam-Flag: NO
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[rivosinc.com:email,localhost.localdomain:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:dkim];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.de:+]

On Mon, May 19, 2025 at 08:18:05PM +0300, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Pratyush Yadav reports the following crash:
> 
>     ------------[ cut here ]------------
>     kernel BUG at arch/x86/mm/physaddr.c:23!
>     ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
>     CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
>     RIP: 0010:__phys_addr+0x58/0x60
>     Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
>     RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
>     RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
>     RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
>     RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
>     R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
>     R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
>     FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
>     Call Trace:
>      <TASK>
>      ? __cma_declare_contiguous_nid+0x6e/0x340
>      ? cma_declare_contiguous_nid+0x33/0x70
>      ? dma_contiguous_reserve_area+0x2f/0x70
>      ? setup_arch+0x6f1/0x870
>      ? start_kernel+0x52/0x4b0
>      ? x86_64_start_reservations+0x29/0x30
>      ? x86_64_start_kernel+0x7c/0x80
>      ? common_startup_64+0x13e/0x141
> 
>   The reason is that __cma_declare_contiguous_nid() does:
> 
>           highmem_start = __pa(high_memory - 1) + 1;
> 
>   If dma_contiguous_reserve_area() (or any other CMA declaration) is
>   called before free_area_init(), high_memory is uninitialized. Without
>   CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
>   highmem_start.
> 
> The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
> free_area_init()") moved initialization of high_memory after the call to
> dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
> architectures.
> 
> In the case CONFIG_HIGHMEM is enabled, some architectures that actually
> support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
> before a possible call to __cma_declare_contiguous_nid() and some
> initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
> xtensa) even before the commit e120d1bc12da so they are fine with using
> uninitialized value of high_memory.
> 
> And in the case CONFIG_HIGHMEM is disabled high_memory essentially becomes
> the first address after memory end, so instead of relying on high_memory to
> calculate highmem_start use memblock_end_of_DRAM() and eliminate the
> dependency of CMA area creation on high_memory in majority of
> configurations.
> 
> Reported-by: Pratyush Yadav <ptyadav@amazon.de>
> Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

I will note though that it is a bit akward to have highmem involved here
when we might not have CONFIG_HIGHMEM enabled.
I get that for !CONFIG_HIGHMEM it is a no-op situation, but still I
wonder whether we could abstract that from this function.


-- 
Oscar Salvador
SUSE Labs

