Return-Path: <linux-arch+bounces-12565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0603AAF9672
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 17:13:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26E36585ADA
	for <lists+linux-arch@lfdr.de>; Fri,  4 Jul 2025 15:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787C51D90DF;
	Fri,  4 Jul 2025 15:12:11 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A83A328EA53;
	Fri,  4 Jul 2025 15:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751641931; cv=none; b=Eo428cLUu1PwfJionA88wfVmLSWo24BofRyMHpQS77gTDtFwEk3gc2G6sIKVkyDN5ANOcJ7ZEh4BSeFtoZdctYy7kq9KlvzBgNyuGDowEFMpS0NtaIu7/G47kiJh2yP9xcrrD9/Yypt5wokZAX8YeyAZi1zHTTF83FaVdhFD+bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751641931; c=relaxed/simple;
	bh=d83IaNS6NoPxQCwpTGjtGRS33HFh5HvOOsfwdC2cPl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fhr9fZSQfnKW13kWePR7f61ynNqXyUSC5N4nn6OqAh1IvJFG2wgfLHvstW0p99jBgPN/kHRkQ1W3j7m67ybWr5mZRtzb01dfjRDQ6tzGKMmcG3dqz29xEhVcIOnbHBoY/gg2QKUyj3tET+kAzuan81bJn5zA6i+kuJS0zIIbVls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id AC924C0137;
	Fri,  4 Jul 2025 15:12:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 999541C;
	Fri,  4 Jul 2025 15:12:04 +0000 (UTC)
Date: Fri, 4 Jul 2025 11:12:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
Message-ID: <20250704111248.511cc248@gandalf.local.home>
In-Reply-To: <CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
References: <20250703115222.2d7c8cd5@batman.local.home>
	<CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
	<20250703152643.0a4a45fe@gandalf.local.home>
	<CAHk-=wgdM_A1iWs6=y__nDcVq9pZRynd1mO8F9XnAeZuHumHtA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: kdpyha7h8q9zijedorfgx1j95xpy5fby
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 999541C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18IykUGAOzqgK7BvVmLX83iO7Znbr1dums=
X-HE-Tag: 1751641924-873251
X-HE-Meta: U2FsdGVkX1+Oo+MnSHPV5U5wj6rbj4q78/eL7FDvpQmOnnhjDO7oIFk5bZD4iaOeRZ4zsDUvGxjTzbkiYXQuRPaxXUAkRomnqEgiKbwb5aEEsrOKhnq77xjpBn2ad435krdBkGg6hrTee2hYTCrnm7dnT6EiSgwGUbfyJj2WUx9Q8H4IohtAiHqPMUsHmvt6okfkFKmRZTh6KKCsUwThN34EH0jF5wyb3s/unWKo7sCRj+6BT4y6la2UfeeDxGH1KzRCY6QBGi2OzgpsHdG3kQUwWr14x47aZ8LoI24Y0Qw/CDFT4WSFph+08mycpZnSirzosaBYVQGb4L1PyYmt1QZ5hU+t23l+exY3k1tPjSowuYTPRqd5Bm11FWt35lWF

On Thu, 3 Jul 2025 13:58:17 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So the reason I dislike the HAVE_xyz pattern is exactly that there
> _isn't_ a pattern. When there are fifteen different patterns, it's not
> a pattern at all.
> 
> That said, maybe it's better to have one place that has that "if
> FUNCTION_TRACER, even if I despise the nonsensical "helper
> indirection" just because of the random naming.

At least with HAVE_FTRACE_* there is a pattern. The HAVE_* may not be
consistent across other parts of the kernel, but it has been with ftrace.

As I have stated, ftrace is very tightly coupled with the architectures due
to the assembly written trampolines. And having a simple way for the
architectures to denote what it supports and what it does not makes the
generic code much simpler to implement.

-- Steve

