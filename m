Return-Path: <linux-arch+bounces-9314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFCAF9E8B8D
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 07:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 038F31885D6C
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2024 06:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F8D41C2DA2;
	Mon,  9 Dec 2024 06:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n7DyDlww"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FCB14E2CF;
	Mon,  9 Dec 2024 06:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733726185; cv=none; b=tme4Z6uxbggMrQgDrpnkpu3Wh736vDSX0ZjZXp3+10Ue4mITkfZEz5hP8Ba3k6yFsOOwQof4VzQL02HdiFk/AwfNpxWmSxpQamNliBFWvRUaVV1xzyr5S2UpsvnwV2aqdT9cNszhJbP26o5Ci6wgq1xTHWKKvN4P6F9fEThYFBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733726185; c=relaxed/simple;
	bh=DgtaHPJQKdaLwwTG+7hCBSPnG+BYqh2b1JN3OIxNq34=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=SoBisfQO7c8hkYEAgw/cwLlyja+AfgWfvQwWQpH5mV6LPfoS+h22oOToAZ+m0X9Tgx3hGmrrteMGyraOKqZWsYhdYnYuqXljLoIF7+0Y3J/Gyz8Odp7/4h41FM1DF17mCGJI1QANtdjBLK3wSswX4PXTDhftz9zzbOwwfdzCbWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n7DyDlww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B01D3C4CED1;
	Mon,  9 Dec 2024 06:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733726184;
	bh=DgtaHPJQKdaLwwTG+7hCBSPnG+BYqh2b1JN3OIxNq34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=n7DyDlwwaHxO6CVJPdsWtlP6a4BUw7JEbzbWQNU0tmjMuMUVkzKtWnMtj7Fx4bTHK
	 wi67RsBH1Tt9I7jO1Cf1AFgeOjOFLg/SLo2hyljF/xTa8eZoOZM78KYTeoUndzwRhC
	 gNm9QP/8704G0MnbCUAGpTLwJlMZLEYkAQunLuNM/TVmnq3ie9H78depXhV0X660/w
	 61sMfbaWU/oueU0hqVXie/zarq5zn4EgHei27D/t3ZUJZA6xcqU+L0MfIYlEeahTbu
	 rRb+hRweRmNR4BkF1qa2NzC6mlwniVnTJwZvYw+KMm0E7Qwqgf8KfOTP20L8fZo9/I
	 qXwyLCEbCwVUA==
Date: Mon, 9 Dec 2024 15:36:18 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Heiko Carstens <hca@linux.ibm.com>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Alexei Starovoitov
 <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Alan Maguire
 <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v20 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20241209153618.87e9a6084898575ac06d81c0@kernel.org>
In-Reply-To: <20241206095247.798c6917@gandalf.local.home>
References: <173344373580.50709.5332611753907139634.stgit@devnote2>
	<20241206093556.9026-B-hca@linux.ibm.com>
	<20241206095247.798c6917@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 6 Dec 2024 09:52:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 6 Dec 2024 10:35:56 +0100
> Heiko Carstens <hca@linux.ibm.com> wrote:
> 
> > On Fri, Dec 06, 2024 at 09:08:56AM +0900, Masami Hiramatsu (Google) wrote:
> > > Hi,
> > > 
> > > Here is the 20th version of the series to re-implement the fprobe on
> > > function-graph tracer. The previous version is;
> > > 
> > > https://lore.kernel.org/all/173125372214.172790.6929368952404083802.stgit@devnote2/
> > > 
> > > This version is rebased on v6.13-rc1 and fixes to make CONFIG_FPROBE
> > > "n" by default, so that it does not enable function graph tracer by
> > > default.  
> > 
> > Is there a reason why you didn't add the ACKs I provided for s390
> > related patches for v19 of this series?
> 
> Probably just missed it.
> 
> Masami,
> 
> One thing I usually do when I rebase to a new series is to take my older
> patch series from Patchwork and reapply them. Because patchwork will pick
> up any acks, reviewed-bys or tested-bys. I then only drop the tags if the
> patch needs significant changes.

Oops, sorry, I missed those tags on v19. Let me fix that.

Thanks.

> 
> You can also use b4 to do the same.
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

