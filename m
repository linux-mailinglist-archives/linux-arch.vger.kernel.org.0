Return-Path: <linux-arch+bounces-9084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 548889C87F1
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 11:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 788F3B2B1C2
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 10:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741651DE4DF;
	Thu, 14 Nov 2024 10:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/WWCW0D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y398gvQL";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="o/WWCW0D";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="y398gvQL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B11513A3EC;
	Thu, 14 Nov 2024 10:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731580937; cv=none; b=fWEdJlLXIIHmqgrQ8mjh2VKYf9lGu7YREMUB3+JDMxUsB9zN4SJxKQqzTNc7TkmW0XuRhY24EyE3k8ynEY2guBuk3aVmcZ9vF0MqJ10mpSXyjaII9mIUcOpIrF0mJ3XTfSLwaqUGMj96ecLAkP6spai8Fe9Vo+AzAwmOWICStAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731580937; c=relaxed/simple;
	bh=gP/G5bWQY2EiykgkTFYABkRbHF6HpxNcPfbyX3U1fa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=czHLb8ebDwsrjyUHv81THdKh/VlEZNhey2JS/Y06CgtsGyWENPu+PAPZmxWFes5rd14NCE3xHvNL7Yz613M7oS+eUqsUtNMBnNdUs92bsIDownJeItI8V4FHXDX5Sasl4XAowbrlK2o44iuNSefuwz7YEvFHQzZJUqsMyNPn7PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/WWCW0D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y398gvQL; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=o/WWCW0D; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=y398gvQL; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8C65B1F79C;
	Thu, 14 Nov 2024 10:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731580933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDmbYNzWsci4PxZKuq25OJU12sv+lOWhhjNx9ffNUhM=;
	b=o/WWCW0Dt0HI7p5/Q0SshWlz/T1KMjlFcfxyFKl6SsAk/yIozg3tPsphsZur6P+LBaHUbP
	8cnq/t+qdtiKLrKVb0jkwY5m39IyiVXMu4InLOVK1EbBPXgjhIUYxihSXsCIRWXE8Okr8z
	XipZXdyzDCZRfjMsVstwA/SSmyVMdsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731580933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDmbYNzWsci4PxZKuq25OJU12sv+lOWhhjNx9ffNUhM=;
	b=y398gvQLP8okIqeO5M6xapv7ck/Gun6tgRvK8I03Ls5wvVYhyH+4ZZw6XDsfPoBuPW2dAD
	B6qH4dXdI91ayxAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1731580933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDmbYNzWsci4PxZKuq25OJU12sv+lOWhhjNx9ffNUhM=;
	b=o/WWCW0Dt0HI7p5/Q0SshWlz/T1KMjlFcfxyFKl6SsAk/yIozg3tPsphsZur6P+LBaHUbP
	8cnq/t+qdtiKLrKVb0jkwY5m39IyiVXMu4InLOVK1EbBPXgjhIUYxihSXsCIRWXE8Okr8z
	XipZXdyzDCZRfjMsVstwA/SSmyVMdsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1731580933;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hDmbYNzWsci4PxZKuq25OJU12sv+lOWhhjNx9ffNUhM=;
	b=y398gvQLP8okIqeO5M6xapv7ck/Gun6tgRvK8I03Ls5wvVYhyH+4ZZw6XDsfPoBuPW2dAD
	B6qH4dXdI91ayxAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5475D13721;
	Thu, 14 Nov 2024 10:42:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8kr9EwXUNWfCJgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Thu, 14 Nov 2024 10:42:13 +0000
Message-ID: <80d61508-f714-4d4c-b8e1-b5c0db6adbdd@suse.cz>
Date: Thu, 14 Nov 2024 11:42:13 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 11/57] fork: Permit boot-time THREAD_SIZE
 determination
Content-Language: en-US
To: Ryan Roberts <ryan.roberts@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Anshuman Khandual <anshuman.khandual@arm.com>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Catalin Marinas <catalin.marinas@arm.com>,
 David Hildenbrand <david@redhat.com>, Greg Marsden
 <greg.marsden@oracle.com>, Ingo Molnar <mingo@redhat.com>,
 Ivan Ivanov <ivan.ivanov@suse.com>, Juri Lelli <juri.lelli@redhat.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Matthias Brugger <mbrugger@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, Will Deacon <will@kernel.org>
Cc: kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
 <20241014105912.3207374-1-ryan.roberts@arm.com>
 <20241014105912.3207374-11-ryan.roberts@arm.com>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20241014105912.3207374-11-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	FREEMAIL_TO(0.00)[arm.com,linux-foundation.org,gmail.com,kernel.org,arndb.de,redhat.com,oracle.com,suse.com,google.com,suse.cz,infradead.org,linaro.org];
	TAGGED_RCPT(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[25];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,arm.com:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO

On 10/14/24 12:58, Ryan Roberts wrote:
> THREAD_SIZE defines the size of a kernel thread stack. To date, it has
> been set at compile-time. However, when using vmap stacks, the size must
> be a multiple of PAGE_SIZE, and given we are in the process of
> supporting boot-time page size, we must also do the same for
> THREAD_SIZE.
> 
> The alternative would be to define THREAD_SIZE for the largest supported
> page size, but this would waste memory when using a smaller page size.
> For example, arm64 requires THREAD_SIZE to be 16K, but when using 64K
> pages and a vmap stack, we must increase the size to 64K. If we required
> 64K when 4K or 16K page size was in use, we would waste 48K per kernel
> thread.
> 
> So let's refactor to allow THREAD_SIZE to not be a compile-time
> constant. THREAD_SIZE_MAX (and THREAD_ALIGN_MAX) are introduced to
> manage the limits, as is done for PAGE_SIZE.
> 
> When THREAD_SIZE is a compile-time constant, behaviour and code size
> should be equivalent.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>


