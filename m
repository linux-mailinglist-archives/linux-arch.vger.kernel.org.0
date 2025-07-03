Return-Path: <linux-arch+bounces-12559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B9DAF813E
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 21:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E35434A64F4
	for <lists+linux-arch@lfdr.de>; Thu,  3 Jul 2025 19:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F982F2C53;
	Thu,  3 Jul 2025 19:26:08 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC741DC07D;
	Thu,  3 Jul 2025 19:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751570768; cv=none; b=ny9QxY2ln4HD1lc7hZiVSs8pii7GT7tMUAqmkwr/ZfY/1QS4szKQ4yblr7ruIkpgRitTgJKVO67U+mzT5SXLDCRdXSiZaFZROa2W5nM2Hg/CgENQ/8MFcSFj3IYuZ/6OczZ08mhZgp30TGA34HDjiahFnzbm2ysxt0fKxDN2dbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751570768; c=relaxed/simple;
	bh=j3BqMHZzwhNrJybEJPOvx4Oxy3URGDNRO2/SGiYf7PE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WFKvxktCfFtCf6qR+lGzcMAqOnKzQlOocFQ6TcocI5zj8hmpq6GPBgW+JwZzZaGIcBkP+WMnD8crYckN+IYNEMo9dzDegqCLj5Y3+qP+CgUXvFBu5DaPLabXTIRRZ7zoKlfk2tFNUtXPPvBh5sGONXwOkYqlgGIkwjH4IPKveoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 2662958825;
	Thu,  3 Jul 2025 19:26:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id E36621C;
	Thu,  3 Jul 2025 19:26:00 +0000 (UTC)
Date: Thu, 3 Jul 2025 15:26:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Mark Rutland <mark.rutland@arm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 ChenMiao <chenmiao.ku@gmail.com>, linux-arch@vger.kernel.org
Subject: Re: [RFC][PATCH] ftrace: Make DYNAMIC_FTRACE always enabled for
 architectures that support it
Message-ID: <20250703152643.0a4a45fe@gandalf.local.home>
In-Reply-To: <CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
References: <20250703115222.2d7c8cd5@batman.local.home>
	<CAHk-=wjXjq7wJM-xnTCcGCxg2viUcN6JfHBETpvD94HX7HTHFQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hr1euapfnnep8njxgwp5joy1wbjhyhno
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: E36621C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/iH5gEHhRKD9+CeGdSUOEbWin5kTTRHAI=
X-HE-Tag: 1751570760-527583
X-HE-Meta: U2FsdGVkX1/wUa0BLats7GHDVovY69eeN5z2hsQb2/BfFQD07+39fN3mmgkI+xoYFKxcNCFIEMGvLDqRXQgb3cva0oCqn1Z/kugIPS9D2Vg/BrCBo73LqotS1/u/cVlS+ElNjbI9cX4htjRVx4abjKYM1+pAbc152sleXtjP3W1a11zirSET+Y7+4zH2FktLCNfgOPYW06zC50G/wKXg4mbu74fN3KYfp6RABbly9IDWeuXA4vXLm/Y8+QJiUUOB8ajbMTtAEX70n0Dea9MPB0RVvcl7yCf9FclZp9AQUHu6YKB94iqbcxBmvbPLwBqQgz5Djv6kaGtTnmmF5DFn6J5bTZ7tv9L1mKEpsD43hqIty9daciwsM82Y29J64VGB

On Thu, 3 Jul 2025 09:57:37 -0700
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> IOW, I think that if we do this, we should just get rid of the
> "HAVE_DYNAMIC_FTRACE{_XYZ}" config variables entirely, and just make
> architectures say
> 
>         select DYNAMIC_FTRACE if FUNCTION_TRACER
> 
> because the "HAVE_xyz" config variables seem to add no actual value,
> only confusion.
> 
> Or am I missing some reason for still having that extra config
> variable indirection?

I always thought the "HAVE_" configs was a way for architectures to state
that it supports something but doesn't necessarily enable it. Whereas the
not "HAVE_" configs are user selectable.

If I go and make all the architectures have:

	select DYNAMIC_FTRACE if FUNCTION_TRACER

it seems to be duplicating the work, where all the architectures need to
know the dependencies. To me, that belongs in the generic configs.

The FUNCTION_TRACER config is user selectable, and DYNMIC_FTRACE gets set
when the arch supports dynamic ftrace and the user enables function tracing.

Now, I probably could go and try to clean up some of the HAVE_FTRACE_*
configs. Ftrace has a lot of code that is tightly coupled to architecture
specific code because it relies on trampolines written in assembly.
Throughout the years, I added new features and optimizations that required
architecture fixes. As a lot of the architectures support ftrace but I have
no idea how to update them, I implemented the change in x86 and added a
HAVE_FTRACE_* config so that other architectures could have time to update
to the new feature too and the old way still works.

I should look to see what hasn't been ported to every architecture that
supports ftrace and remove the configs that are now universal.

-- Steve

