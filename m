Return-Path: <linux-arch+bounces-12340-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40468AD8B93
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 14:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D74F1758A4
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 12:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FC223182D;
	Fri, 13 Jun 2025 12:06:13 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF4D1FF61E;
	Fri, 13 Jun 2025 12:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816373; cv=none; b=mCUsMS+PjX+IJAA4EL7viHH33o4aduA3SnrZfpPeOEU1qFQLi1ny6jI09VtfB0F5wGby+Q1HjOxboiT44/pvAi6LZmuUcvxg85qFCYJ1qYxs438Vo1pJxG5wcgiGc0oEVNRzrsQlk/cF6uNVngRmUDuIUZTowuaF0MdHWguMvXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816373; c=relaxed/simple;
	bh=dy183kHYjGwHoCMN7pVrHMJgDWE/i9RF/XCaMmJP/Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sOr83mMiTczj6VHkijMQwhx0qZve5H6P+b564eAmF5qhyjS3twwFqzj3aWjZZMDaltS4B0VBCVJMn4dpS5opOO3MMqnjLAQrfDB+cIln1J0RY+EozGNplTlr33bCl1saG9FIgTPDSpA00j+Y7pmo7+d96cSOxI855loh+Y5+2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf07.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 2BB53C0459;
	Fri, 13 Jun 2025 12:06:08 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id 0B0DB2002D;
	Fri, 13 Jun 2025 12:06:04 +0000 (UTC)
Date: Fri, 13 Jun 2025 08:07:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, Nick
 Desaulniers <nick.desaulniers+lkml@gmail.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] tracepoints: Add warnings for unused tracepoints
 and trace events
Message-ID: <20250613080741.55de0429@gandalf.local.home>
In-Reply-To: <14fc8777-a5d2-4877-9707-73c25d9e9bd3@infradead.org>
References: <20250612235827.011358765@goodmis.org>
	<14fc8777-a5d2-4877-9707-73c25d9e9bd3@infradead.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7mqzf3awyn1mrdt43cekibahainqkhx9
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 0B0DB2002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX198NosNg0VWHJpbZw25v/HmbXrnlMNRfls=
X-HE-Tag: 1749816364-802972
X-HE-Meta: U2FsdGVkX1/SRYXKIc/bGFvB/8qKJp8ttNVRvnR8Mwf8M3ZCyOq0tIb4Y9YnmzpJt00MxcjffXc4/c/BIdQQ6+CvngQpwBNYGgB6lABNnzivrSER0hJRRSuMfYVTT47s9sXXhQMKNUkJtclXujk1DJuL363HjO+oPbQhC4kErPe2W86DPxzfeaaN6xHpKb5253zt9QQHELihZ3usO5MqEdoO1X6Bn4MlChv50EWAY4cMzVuYLBtOXV/bc5AAEwC3KE7pfPNgX8B0rRvBHdGjUyw7jcI3YVImujmPRtjauvHc/8+ll7AsFMGmc+j0BlsYPW6mQ4qeSaCQLXJ4jvZOXVMayBb74AEA7Fa+OuQKPwDbipN7KTiv1dpG20SZR6mvRysC/oq8XaQNGBUnYCraQQ==

On Thu, 12 Jun 2025 20:20:48 -0700
Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
> 
> On 6/12/25 4:58 PM, Steven Rostedt wrote:
> > Every trace event can take up to 5K of memory in text and meta data regardless  
> 
> s/meta data/metadata/ unless you are referring to meta's data.

Oh so I need to give Meta royalties?

> 
> s/meta data/metadata/ in patches 1 and 2 also.

I'll update when I pull them in. Note, the cover letter isn't something
that I put into git. But I'll try to remember to update if I send a v3.

> 
> > if they are used or not. Trace events should not be created if they are not
> > used.  Currently there's over a hundred events in the kernel that are defined
> > but unused, either because their callers were removed without removing the
> > trace event with it, or a config hides the trace event caller but not the
> > trace event itself. And in some cases, trace events were simply added but were
> > never called for whatever reason. The number of unused trace events continues
> > to grow.
> > 
> > This patch series aims to fix this.
> > 
> > The first patch creates a new section called __tracepoint_check, where all
> > callers of a tracepoint creates a variable that is placed in this section with
> > a pointer to the tracepoint they use. Then on boot up, it iterates this
> > section and will modify the tracepoint's "func" field to a value of 1 (all
> > tracepoints "func" fields are initialized to NULL and is only set when they
> > are registered). This takes place before any tracepoint can be registered.
> > 
> > Then each tracepoint is iterated on and if any tracepoint does not have its
> > "func" field set to 1 a warning is triggerd and every tracepoint that doesn't  
> 
> triggered

Yes I am!

> 
> > have that field set is printed. The "func" field is then reset back to NULL.
> > 
> > The second patch modifies scripts/sorttable.c to read the __tracepoint_check
> > section. It sorts it, and then reads the __tracepoint_ptr section that has all
> > compiled in tracepoints. It makes sure that every tracepoint is found in the
> > check section and if not, it prints a warning message about it. This lists the
> > missing tracepoints at build time.
> > 
> > The third patch updates sorttable to work for arm64 when compiled with gcc. As
> > gcc's arm64 build doesn't put addresses in their section but saves them off in
> > the RELA sections. This mostly takes the work done that was needed to do the
> > mcount sorting at boot up on arm64.
> > 
> > The forth patch adds EXPORT_TRACEPOINT() to the __tracepoint_check section as  
> 
> fourth (or are you coding in forth?)

oops

-- Steve

> 
> > well. There was several locations that adds tracepoints in the kernel proper
> > that are only used in modules. It was getting quite complex trying to move
> > things around that I just decided to make any tracepoint in a
> > EXPORT_TRACEPOINT "used". I'm using the analogy of static and global
> > functions. An unused static function gets a warning but an unused global one
> > does not.
> > 
> > The last patch updates the trace_ftrace_test_filter boot up self test. That
> > selftest creates a trace event to run a bunch of filter tests on it without
> > actually calling the tracepoint. To quiet the warning, the selftest tracepoint
> > is called within a if (!trace_<event>_enabled()) section, where it will not be
> > optimized out, nor will it be called.
> > 
> > This is v2 from: https://lore.kernel.org/linux-trace-kernel/20250529130138.544ffec4@gandalf.local.home/
> > which was simply the first patch. This version adds the other patches.
> > 
> > Steven Rostedt (5):
> >       tracepoints: Add verifier that makes sure all defined tracepoints are used
> >       tracing: sorttable: Add a tracepoint verification check at build time
> >       tracing: sorttable: Find unused tracepoints for arm64 that uses reloc for address
> >       tracepoint: Do not warn for unused event that is exported
> >       tracing: Call trace_ftrace_test_filter() for the event
> > 
> > ----
> >  include/asm-generic/vmlinux.lds.h  |   1 +
> >  include/linux/tracepoint.h         |  13 ++
> >  kernel/trace/Kconfig               |  31 +++
> >  kernel/trace/trace_events_filter.c |   4 +
> >  kernel/tracepoint.c                |  26 +++
> >  scripts/Makefile                   |   4 +
> >  scripts/sorttable.c                | 444 ++++++++++++++++++++++++++++++-------
> >  7 files changed, 437 insertions(+), 86 deletions(-)
> >   
> 
> thanks.


