Return-Path: <linux-arch+bounces-8193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A2399FC76
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83805B2479D
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8031D63F8;
	Tue, 15 Oct 2024 23:28:30 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BFE21E3BC;
	Tue, 15 Oct 2024 23:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034910; cv=none; b=TCNHUx+o9x5bd0UKoD4GpFPu2Ei0uVHAN4TpRQXN19UqFXdWbvLCWQi/sqRAj3FzbP/P4SdIE5g6w5Su/pFVt9CzFQqasDuret/vgIgIYeTLbahaKtJr/l00zdOkKqat44VYDyqRZhJrCtr5jm+m0dy5UCguPpDNxxlXvf96zs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034910; c=relaxed/simple;
	bh=9Uiel1O9l6EkgVLHo/E2fPX2az2q519lDM3Nbo4wtAo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxUQ4We3P4N6tRHV95lJxVNDDxL5++tchEGSPvSWW4bfRbyN3Z+pJo4B77LsBMm+iYFxFLc3V/uhtfIdaHw6eUkgG9TqeXcaR+Ki8mSzUsXlyN1efKSfxioTcWnt/xEveYVpKe2g1bOlFceYOnjm1PGhYCutrsv/Nr20vQNJpbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20DDFC4CEC6;
	Tue, 15 Oct 2024 23:28:26 +0000 (UTC)
Date: Tue, 15 Oct 2024 19:28:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v16 01/18] tracing: Use arch_ftrace_regs() for
 ftrace_regs_*() macros
Message-ID: <20241015192824.6090a847@rorschach>
In-Reply-To: <20241016082541.6d5d278d425e05b8295c0193@kernel.org>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895572290.107311.16057631001860177198.stgit@devnote2>
	<20241015172757.3221a96f@gandalf.local.home>
	<20241016082541.6d5d278d425e05b8295c0193@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Oct 2024 08:25:41 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > 
> > If a change is for function graph infrastructure specifically, you can use
> > "fgraph:" instead.  
> 
> Just to confirm, is "function_graph:" for function graph tracer itself?

If it is for the function graph tracer, I would use "function_graph:"
if it's for the function graph infrastructure, I would use "fgraph:"

Thanks,

-- Steve

