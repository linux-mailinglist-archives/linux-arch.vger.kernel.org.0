Return-Path: <linux-arch+bounces-9289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF1B9E712F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 15:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40A2D28293F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 14:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7EB1F8F13;
	Fri,  6 Dec 2024 14:52:42 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73FD1494B2;
	Fri,  6 Dec 2024 14:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733496761; cv=none; b=rtU1QeMFEpl2T6t2+28IdFsUY0rj2RB3g3fCT4Dzmgg2v02f+kiraZOJCwfWcy4g76diz1LwgZcDJReiYhcnj5iujxMKAuMz9SDVOB99gfgwXCFDmKL3p1XgpYxCqM8V1G/G6FBXKgEMiCdD3OwdUfJ7AXZsqCpnMajTT0JODvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733496761; c=relaxed/simple;
	bh=39debVxraw4col5TpQ4SJ8o+PdSVsJ/wJtW1eHmC3Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=isiV6LyAyWuBxCMKp0lMcJjlzjoMAK1/dZUjUGGph5l1MHztUQ3KBNIuIGeBP0y9cfLPd+nIiRQH5QDBtftMFIXom6l4intFJ33uH+bJyZcS0BpnR0GwAZylj1FUJKwjuwlTvbZ21HPsozH25FbHW53UGDuXJNpedf0AF+pKGYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287ACC4CED1;
	Fri,  6 Dec 2024 14:52:40 +0000 (UTC)
Date: Fri, 6 Dec 2024 09:52:47 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <20241206095247.798c6917@gandalf.local.home>
In-Reply-To: <20241206093556.9026-B-hca@linux.ibm.com>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
	<20241206093556.9026-B-hca@linux.ibm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 10:35:56 +0100
Heiko Carstens <hca@linux.ibm.com> wrote:

> On Fri, Dec 06, 2024 at 09:08:56AM +0900, Masami Hiramatsu (Google) wrote:
> > Hi,
> > 
> > Here is the 20th version of the series to re-implement the fprobe on
> > function-graph tracer. The previous version is;
> > 
> > https://lore.kernel.org/all/173125372214.172790.6929368952404083802.stgit@devnote2/
> > 
> > This version is rebased on v6.13-rc1 and fixes to make CONFIG_FPROBE
> > "n" by default, so that it does not enable function graph tracer by
> > default.  
> 
> Is there a reason why you didn't add the ACKs I provided for s390
> related patches for v19 of this series?

Probably just missed it.

Masami,

One thing I usually do when I rebase to a new series is to take my older
patch series from Patchwork and reapply them. Because patchwork will pick
up any acks, reviewed-bys or tested-bys. I then only drop the tags if the
patch needs significant changes.

You can also use b4 to do the same.

-- Steve

