Return-Path: <linux-arch+bounces-12330-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC83DAD7F47
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 02:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 518D43AD354
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jun 2025 00:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6EE8748F;
	Fri, 13 Jun 2025 00:01:58 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCBC310E9;
	Fri, 13 Jun 2025 00:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749772918; cv=none; b=mSx/FNr6ixppdtZoL6wLIb7zHNBSSMqJiDzD66cJp8WAdpz7qzRX+7gTuzVQ/xGiJr92KFG8cf0cDQDNbblrPTrHhAHB9JOqYs55DEMoylYj+CsuHDq/QtVODcJ2EPLH2qNDG3qcTN0jMiO4MEPi4Ggi9v5EVOWlZ81xvl3xuDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749772918; c=relaxed/simple;
	bh=ktLPqBfb0Q9UxATLFPtgXeKEniYTjDCEq9jWqEe1HU0=;
	h=Message-ID:Date:From:To:Cc:Subject; b=UnZ1+0i8PHVxXx7JW41cmpxIuyBcx7BoaXdkJeBZmhYPXUrzOpxwdruWuFmmVGbkv4/4/RrTzYvfT/b7arppNjvkPhPAFRhEjIwjvFR/yzJ9m2OWCpA51o1SQBj83pYGCVlYMeRjznxEtjlF+wapuPwblp3qANP6dRvx5MCPPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf05.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 9650C16043F;
	Fri, 13 Jun 2025 00:01:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: nevets@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id 7E7F120015;
	Fri, 13 Jun 2025 00:01:52 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98.2)
	(envelope-from <rostedt@goodmis.org>)
	id 1uPrtI-00000001wlB-2Tte;
	Thu, 12 Jun 2025 20:03:28 -0400
Message-ID: <20250612235827.011358765@goodmis.org>
User-Agent: quilt/0.68
Date: Thu, 12 Jun 2025 19:58:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org,
 llvm@lists.linux.dev
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Masahiro Yamada <masahiroy@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 0/5] tracepoints: Add warnings for unused tracepoints and trace events 
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 7E7F120015
X-Stat-Signature: 1hjfmzb9uz4og3i9x4ep86qwjn79b7f4
X-Session-Marker: 6E657665747340676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/pAn2UOPxaz5xG82OV8z0NLZQWSBC58Po=
X-HE-Tag: 1749772912-383725
X-HE-Meta: U2FsdGVkX1/usBTNqgaNMTPmWO+XHlewon1Trn7MTqxnsGgYTr2MChhFRJWDvGAt7yumw4WJZYMccY04asDKq/4yik+/hNkVN6P2QstIr8JBmPbLs5ixxAeyfxZ19ISBA/hY7C38fCCl1HChV1xWaA0l0Er7IyBDS8H9L65iXhMxJjnXo5wa5SPQV68QOn/vtvWi4giPLdaclkIGuW8t8f9eAijA7THt5MrH6VWGQQlIwMT0LToYgmEALVBHx550wuNovbDA8XEhf2MyQzSi67h64jfurBR7Pr90svjpPaAqSCXTg6VLYVviDLu9kuH0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>


Every trace event can take up to 5K of memory in text and meta data regardless
if they are used or not. Trace events should not be created if they are not
used.  Currently there's over a hundred events in the kernel that are defined
but unused, either because their callers were removed without removing the
trace event with it, or a config hides the trace event caller but not the
trace event itself. And in some cases, trace events were simply added but were
never called for whatever reason. The number of unused trace events continues
to grow.

This patch series aims to fix this.

The first patch creates a new section called __tracepoint_check, where all
callers of a tracepoint creates a variable that is placed in this section with
a pointer to the tracepoint they use. Then on boot up, it iterates this
section and will modify the tracepoint's "func" field to a value of 1 (all
tracepoints "func" fields are initialized to NULL and is only set when they
are registered). This takes place before any tracepoint can be registered.

Then each tracepoint is iterated on and if any tracepoint does not have its
"func" field set to 1 a warning is triggerd and every tracepoint that doesn't
have that field set is printed. The "func" field is then reset back to NULL.

The second patch modifies scripts/sorttable.c to read the __tracepoint_check
section. It sorts it, and then reads the __tracepoint_ptr section that has all
compiled in tracepoints. It makes sure that every tracepoint is found in the
check section and if not, it prints a warning message about it. This lists the
missing tracepoints at build time.

The third patch updates sorttable to work for arm64 when compiled with gcc. As
gcc's arm64 build doesn't put addresses in their section but saves them off in
the RELA sections. This mostly takes the work done that was needed to do the
mcount sorting at boot up on arm64.

The forth patch adds EXPORT_TRACEPOINT() to the __tracepoint_check section as
well. There was several locations that adds tracepoints in the kernel proper
that are only used in modules. It was getting quite complex trying to move
things around that I just decided to make any tracepoint in a
EXPORT_TRACEPOINT "used". I'm using the analogy of static and global
functions. An unused static function gets a warning but an unused global one
does not.

The last patch updates the trace_ftrace_test_filter boot up self test. That
selftest creates a trace event to run a bunch of filter tests on it without
actually calling the tracepoint. To quiet the warning, the selftest tracepoint
is called within a if (!trace_<event>_enabled()) section, where it will not be
optimized out, nor will it be called.

This is v2 from: https://lore.kernel.org/linux-trace-kernel/20250529130138.544ffec4@gandalf.local.home/
which was simply the first patch. This version adds the other patches.

Steven Rostedt (5):
      tracepoints: Add verifier that makes sure all defined tracepoints are used
      tracing: sorttable: Add a tracepoint verification check at build time
      tracing: sorttable: Find unused tracepoints for arm64 that uses reloc for address
      tracepoint: Do not warn for unused event that is exported
      tracing: Call trace_ftrace_test_filter() for the event

----
 include/asm-generic/vmlinux.lds.h  |   1 +
 include/linux/tracepoint.h         |  13 ++
 kernel/trace/Kconfig               |  31 +++
 kernel/trace/trace_events_filter.c |   4 +
 kernel/tracepoint.c                |  26 +++
 scripts/Makefile                   |   4 +
 scripts/sorttable.c                | 444 ++++++++++++++++++++++++++++++-------
 7 files changed, 437 insertions(+), 86 deletions(-)

