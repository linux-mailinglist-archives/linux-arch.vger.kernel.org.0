Return-Path: <linux-arch+bounces-7359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23F797D4D1
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2024 13:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 133F0B22A4F
	for <lists+linux-arch@lfdr.de>; Fri, 20 Sep 2024 11:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE53A14375C;
	Fri, 20 Sep 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJqKzdaz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9A414290;
	Fri, 20 Sep 2024 11:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726831627; cv=none; b=Pui/SaGF8/f7mIF3UlRnLnjTWZl4AvIKACIBgS9YAGiE7cKIdZwnb4eWAFjOYCloOxskrdvGmWHXDMshu/69TxvNgbs0yxILRfy7snFrLXQ/MF4M6loRx10D6h3+RmrvXYE0fdKqoB/YEFbnQ5mFpk0a2nPJd1IDNwLIY3/duc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726831627; c=relaxed/simple;
	bh=Pu+Q8DHoL0edU64i2MkdXyKqaILGDIGkO3K4u29/lmU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=RcOkBGudeUIUKDJeQ0l69x97PbDM9lvcl5U5Edb7wiORRG/+GoyfpIMDA3n56CKO0VwsXy/nqbbRVs/j2PnwfYzpn720R5rzNr1sdjVdi+SXiNQEwGXTRVcwkj65FL05HY6Tf/UyOVo2pJ3Jyx2I06KUjL7zCP6P5IwoWQ9sYss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJqKzdaz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080DEC4CECD;
	Fri, 20 Sep 2024 11:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726831627;
	bh=Pu+Q8DHoL0edU64i2MkdXyKqaILGDIGkO3K4u29/lmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WJqKzdazK7zg+v5FDyOGY2q3YtjXBOFVBu17Znyx05tRwPBc0gqDcBDTDEfauIqo6
	 eBCo+JwEz+wJ29r+DSDnnAuAbFlWFPXgrcaq53+Cl02Y30859U4ilkXHo/WjMg2nyI
	 9OFI/7uFrOiLYSzXQPKYrIOMH5CZiaWHrNIUNJmQTvv1/bh7wBCFbyzmZZqN/4M+bP
	 BsSohYwc/ABAlGbct8KuUvNIrqkD6x7eNi7VZyfbx2I3xl+cnvQ6yypYHuMmsWVMuU
	 jf4HAlLyu8VdWIUPwQ2KBqr0m5eoZix3hMGxtoFCeWPHzUkXhpUuADFUtsu0YL3BqH
	 Mdu4cT68WZ9KQ==
Date: Fri, 20 Sep 2024 13:26:59 +0200
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v15 00/19] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240920132659.48d4563d4ab4ff32ba64d65a@kernel.org>
In-Reply-To: <CAEf4BzZAPjZEZR9m66hPr6srzJwuu=B8zu6cNhxe-7__5+LpHw@mail.gmail.com>
References: <172639136989.366111.11359590127009702129.stgit@devnote2>
	<CAEf4BzZAPjZEZR9m66hPr6srzJwuu=B8zu6cNhxe-7__5+LpHw@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Wed, 18 Sep 2024 23:22:41 +0200
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> On Sun, Sep 15, 2024 at 11:09 AM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > Hi,
> >
> > Here is the 15th version of the series to re-implement the fprobe on
> > function-graph tracer. The previous version is;
> >
> > https://lore.kernel.org/all/172615368656.133222.2336770908714920670.stgit@devnote2/
> >
> > This version rebased on Steve's calltime change[1] instead of the last
> > patch in the previous series, and adds a bpf patch to add get_entry_ip()
> > for arm64. Note that [1] is not included in this series, so please use
> > the git branch[2].
> >
> 
> With LPC and Kernel Recipes back-to-back I won't have time to look
> through the code, but I did manage to run some benchmarks tonight, and
> they look pretty good now, thanks! Seems like the kprobe regression is
> gone, and kretprobes are a bit faster. So, nice work, thanks!
> 
> BEFORE
> ======
> kprobe         :   25.052 ± 0.032M/s
> kprobe-multi   :   28.102 ± 0.167M/s
> kretprobe      :   10.724 ± 0.008M/s
> kretprobe-multi:   11.337 ± 0.054M/s
> 
> AFTER
> =====
> kprobe         :   25.206 ± 0.026M/s
> kprobe-multi   :   30.167 ± 0.148M/s
> kretprobe      :   10.714 ± 0.016M/s
> kretprobe-multi:   13.436 ± 0.328M/s

Thanks for reevaluate the series!
This results look nice.

Thank you,

> 
> > [1] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
> > [2] https://git.kernel.org/pub/scm/linux/kernel/git/mhiramat/linux.git/log/?h=topic/fprobe-on-fgraph
> >
> 
> [...]


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

