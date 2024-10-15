Return-Path: <linux-arch+bounces-8190-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD4399F90B
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67D31283CF0
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 21:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 886B91FBF59;
	Tue, 15 Oct 2024 21:27:39 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 679CC1FAEE9;
	Tue, 15 Oct 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729027659; cv=none; b=Pw0J5pVYFNxIZzcG7fxbHDSJCx2zWe47zSQeZXpJZwTdoH4zxgdymDBRwIaB/rIXCdEpm6fQH6FdgMmQQy08uuorukjOCIJ/kMNatpGBQL6Ce9WGIiervXKfJpgdBLbSk+0GylQqWtzeshs/cJ+Or3+z4XBokAxdMeGNvvqq62g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729027659; c=relaxed/simple;
	bh=rup4GFrxsOHklgK+IsExgW8KlfWT5TJ8md+p4KNZZ4I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncZyPAf9Mr7pd1Jrx+uX+xFqLmTjow4XshueKP8ZXR8lv19bWh9ipgKk5I+J5bra12f5sbuo1lZb57sGECBpdw9Mo0OpVejGAD7IrYERb5ZeqgcEf3P9oPkJUNTR+z6JATQ9iPdewJ9Qc0ghjPzuxl/210JwLzuN6MNLeouBs+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2618C4CEC6;
	Tue, 15 Oct 2024 21:27:37 +0000 (UTC)
Date: Tue, 15 Oct 2024 17:27:57 -0400
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
Message-ID: <20241015172757.3221a96f@gandalf.local.home>
In-Reply-To: <172895572290.107311.16057631001860177198.stgit@devnote2>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895572290.107311.16057631001860177198.stgit@devnote2>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


FYI, for anything to do with function hooks (fentry), the subject should be
"ftrace:" not "tracing:".

Tracing has to do with the tracing infrastructure, whereas ftrace is the
function hook infrastructure.

I just accepted the first two patches of this series and made the changes
to the subjects.

If a change is for function graph infrastructure specifically, you can use
"fgraph:" instead.

-- Steve


On Tue, 15 Oct 2024 10:28:43 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Since the arch_ftrace_get_regs(fregs) is only valid when the
> FL_SAVE_REGS is set, we need to use `&arch_ftrace_regs()->regs` for
> ftrace_regs_*() APIs because those APIs are for ftrace_regs, not
> complete pt_regs.
> 

