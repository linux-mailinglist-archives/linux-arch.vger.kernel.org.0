Return-Path: <linux-arch+bounces-12337-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F8AAD8195
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 05:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D675C3B6E6E
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 135E820E32D;
	Fri, 13 Jun 2025 03:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mM3WqZgI"
X-Original-To: linux-arch@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF09B15278E;
	Fri, 13 Jun 2025 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749784875; cv=none; b=ayWP+iYUrNYcKsraJ43HPrmDmNo87vBuvweDiQaOL4EDfxXI3SmvMrUzaTf5qgchd+D3ulX7q6C4GcSBcR1Q/ZyvbONYN8KOwalj7voSOddltS+zljUtjZFfvFwSVy0Vt778cHyBHp2Jj/ul1pSIC9nMHlewRKM0/PEfjCQybFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749784875; c=relaxed/simple;
	bh=azL5StamfCxOer0bMUohJxx6uHwXifg+3tUWGX7wv0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fm3qEVqhjguSlSh/MX9U7fn70MQ+ICkSwgVQlqcHoSV9oTbkpuxojfnJCKkBMikGvi4SqDYoT3fNkkHT1ykRKY8S5VxlXD+wXAgrmYUNvaEIGoCX/KBIrxT02gfOxmKU/Va1dHTA4dw2ycEQ5Qib0OmjfdZzN4Bed0O35cXHoiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mM3WqZgI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description;
	bh=dPy3+YPjM96m4w0mRmbzfdnzpTV1myn+efhkM8vgURI=; b=mM3WqZgIOER4uqpnsZyYwVGA13
	sW2ZRZkAq9urHblXMxsY7Xy5/Yta84f5uh9blvSBULwxuqI8Csgk/kVGRyoNTwsKJU6d9SpmLxADs
	wWV2d2vosvz4ONyPIFVNEGqRtImE5z7P3XnCO9f9N2L2w9Q0xTXndgkJdmyV+Alm3qlI1lNFgaP2t
	UBkegHnyexuUFSN3UA8szD8m1B7RW5PGyEVjtBWVsU+TLmAnSTwEB0HWjBVu7s1EKnFKnPmOaQFY4
	VjqkYDYEn00dMJqsR9uDb2nLCMrR+V2OW2OqzXyleSqp7GxezSmaV5JwodPSxuA0fYKg9OzMeXkOo
	7Ij/king==;
Received: from [50.53.25.54] (helo=[192.168.254.17])
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPuyP-0000000CY5X-3tCF;
	Fri, 13 Jun 2025 03:20:58 +0000
Message-ID: <14fc8777-a5d2-4877-9707-73c25d9e9bd3@infradead.org>
Date: Thu, 12 Jun 2025 20:20:48 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] tracepoints: Add warnings for unused tracepoints
 and trace events
To: Steven Rostedt <rostedt@goodmis.org>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20250612235827.011358765@goodmis.org>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20250612235827.011358765@goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 6/12/25 4:58 PM, Steven Rostedt wrote:
> Every trace event can take up to 5K of memory in text and meta data regardless

s/meta data/metadata/ unless you are referring to meta's data.

s/meta data/metadata/ in patches 1 and 2 also.

> if they are used or not. Trace events should not be created if they are not
> used.  Currently there's over a hundred events in the kernel that are defined
> but unused, either because their callers were removed without removing the
> trace event with it, or a config hides the trace event caller but not the
> trace event itself. And in some cases, trace events were simply added but were
> never called for whatever reason. The number of unused trace events continues
> to grow.
> 
> This patch series aims to fix this.
> 
> The first patch creates a new section called __tracepoint_check, where all
> callers of a tracepoint creates a variable that is placed in this section with
> a pointer to the tracepoint they use. Then on boot up, it iterates this
> section and will modify the tracepoint's "func" field to a value of 1 (all
> tracepoints "func" fields are initialized to NULL and is only set when they
> are registered). This takes place before any tracepoint can be registered.
> 
> Then each tracepoint is iterated on and if any tracepoint does not have its
> "func" field set to 1 a warning is triggerd and every tracepoint that doesn't

triggered

> have that field set is printed. The "func" field is then reset back to NULL.
> 
> The second patch modifies scripts/sorttable.c to read the __tracepoint_check
> section. It sorts it, and then reads the __tracepoint_ptr section that has all
> compiled in tracepoints. It makes sure that every tracepoint is found in the
> check section and if not, it prints a warning message about it. This lists the
> missing tracepoints at build time.
> 
> The third patch updates sorttable to work for arm64 when compiled with gcc. As
> gcc's arm64 build doesn't put addresses in their section but saves them off in
> the RELA sections. This mostly takes the work done that was needed to do the
> mcount sorting at boot up on arm64.
> 
> The forth patch adds EXPORT_TRACEPOINT() to the __tracepoint_check section as

fourth (or are you coding in forth?)

> well. There was several locations that adds tracepoints in the kernel proper
> that are only used in modules. It was getting quite complex trying to move
> things around that I just decided to make any tracepoint in a
> EXPORT_TRACEPOINT "used". I'm using the analogy of static and global
> functions. An unused static function gets a warning but an unused global one
> does not.
> 
> The last patch updates the trace_ftrace_test_filter boot up self test. That
> selftest creates a trace event to run a bunch of filter tests on it without
> actually calling the tracepoint. To quiet the warning, the selftest tracepoint
> is called within a if (!trace_<event>_enabled()) section, where it will not be
> optimized out, nor will it be called.
> 
> This is v2 from: https://lore.kernel.org/linux-trace-kernel/20250529130138.544ffec4@gandalf.local.home/
> which was simply the first patch. This version adds the other patches.
> 
> Steven Rostedt (5):
>       tracepoints: Add verifier that makes sure all defined tracepoints are used
>       tracing: sorttable: Add a tracepoint verification check at build time
>       tracing: sorttable: Find unused tracepoints for arm64 that uses reloc for address
>       tracepoint: Do not warn for unused event that is exported
>       tracing: Call trace_ftrace_test_filter() for the event
> 
> ----
>  include/asm-generic/vmlinux.lds.h  |   1 +
>  include/linux/tracepoint.h         |  13 ++
>  kernel/trace/Kconfig               |  31 +++
>  kernel/trace/trace_events_filter.c |   4 +
>  kernel/tracepoint.c                |  26 +++
>  scripts/Makefile                   |   4 +
>  scripts/sorttable.c                | 444 ++++++++++++++++++++++++++++++-------
>  7 files changed, 437 insertions(+), 86 deletions(-)
> 

thanks.
-- 
~Randy


