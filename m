Return-Path: <linux-arch+bounces-7308-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C95B2979368
	for <lists+linux-arch@lfdr.de>; Sat, 14 Sep 2024 23:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F16C1F22145
	for <lists+linux-arch@lfdr.de>; Sat, 14 Sep 2024 21:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BDA13A888;
	Sat, 14 Sep 2024 21:53:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92281129A78;
	Sat, 14 Sep 2024 21:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726350814; cv=none; b=M1+kn88YT7MAvqV8gr97draISwcmEC31lalvNlWoahLKym0j/t8Uoo5EZzgZcK6i/E4RjyRrfIlAqkqlrak7fgEwV2Vyho1yvKQeFAbEdw8vqXq/FHcjqbRYsdZjSgg9GwySI0y496mbcwYIXliH2iRhEv5Ggs/SvEbC9mTc6DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726350814; c=relaxed/simple;
	bh=KcvOUuH7U/6mCdw/qFZw6N/Cn5GUTv466T+YcGHTvZw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sUu6byQhwwZXjE6VncZMaK2yasnNywmzzLTG8heEHWSsOF/hwnUCNy5DvaKRANujLlATsg4mXpCkI1RRJ+2I5eQejEGwXnH5zOTIXAnEJVuBrvxYFfm9/jig53DQTWduvHa0IYcPPkyHKFAlOKaUsMUuEjj8uLD4Bv+2PTp1OFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCEE5C4CEC0;
	Sat, 14 Sep 2024 21:53:28 +0000 (UTC)
Date: Sat, 14 Sep 2024 17:53:23 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Sven Schnelle <svens@linux.ibm.com>, Alexei
 Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, Arnaldo
 Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>,
 linux-arch@vger.kernel.org
Subject: Re: [PATCH v14 19/19] fgraph: Skip recording calltime/rettime if it
 is not nneeded
Message-ID: <20240914175323.16206416@rorschach.local.home>
In-Reply-To: <172615389864.133222.14452329708227900626.stgit@devnote2>
References: <172615368656.133222.2336770908714920670.stgit@devnote2>
	<172615389864.133222.14452329708227900626.stgit@devnote2>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Sep 2024 00:11:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>=20
> Skip recording calltime and rettime if the fgraph_ops does not need it.
> This is a kind of performance optimization for fprobe. Since the fprobe
> user does not use these entries, recording timestamp in fgraph is just
> a overhead (e.g. eBPF, ftrace). So introduce the skip_timestamp flag,
> and all fgraph_ops sets this flag, skip recording calltime and rettime.
>=20
> Here is the performance results measured by
>  tools/testing/selftests/bpf/benchs/run_bench_trigger.sh
>=20
> Without this:
> kprobe-multi   :    5.700 =C2=B1 0.065M/s
> kretprobe-multi:    4.239 =C2=B1 0.006M/s
>=20
> With skip-timestamp:
> kprobe-multi   :    6.265 =C2=B1 0.033M/s	+9.91%
> kretprobe-multi:    4.758 =C2=B1 0.009M/s	+12.24%
>=20
> Suggested-by: Jiri Olsa <olsajiri@gmail.com>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Can you try this series instead:

 https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/

I rather get rid of the calltime completely from the generic logic, and
that series does just that.

That series only replaces this patch and can be applied before this
series (or after).

-- Steve

