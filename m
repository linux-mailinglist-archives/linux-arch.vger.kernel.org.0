Return-Path: <linux-arch+bounces-9517-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 549049FD594
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 16:24:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F200F1884083
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 15:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE1A1F7552;
	Fri, 27 Dec 2024 15:23:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6550B182D7;
	Fri, 27 Dec 2024 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735313033; cv=none; b=ugPUFT/i7JWOtwa168JxLPzCO732cdalOn5vOPrN2N1fnufpIDwYq0cYvdh1LXtdysiTWbo2EkNMYMb3xR0fh9+mFxfEQIgtslRcK5nChM2XTRgFHr1ZNOhMZUu9TdBeqega/D4ydAvgIS1EsbT0KsG2fYaiIP+9MLm7gjGv+Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735313033; c=relaxed/simple;
	bh=IAtM7/b36Bjno/BQz9rrm5qOYVS5Jn4YZJ7+NTav/0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kiX3clbRI/a3qQCDfWkxol/xdNFGm9QUCBfnANCDHOFZ0Ph4VHA1CnWdkVLZ3SMVTas7IKOeLIlJJtKpCfPCl94lO0iSetN2mrY66vurvXKilZLfamdB+wkL01m2LiAU30zTDKcPqBLJsNq06Z9BP9E/WRp5QhdVRoXzFVXKBTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B970DC4CED0;
	Fri, 27 Dec 2024 15:23:51 +0000 (UTC)
Date: Fri, 27 Dec 2024 10:24:52 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 20/20] bpf: Use ftrace_get_symaddr() for
 kprobe_multi probes
Message-ID: <20241227102452.14a1c2d9@gandalf.local.home>
In-Reply-To: <20241226212453.7b0aa119@batman.local.home>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<173519012541.391279.12203132904339088937.stgit@devnote2>
	<20241226212339.2f871f94@batman.local.home>
	<20241226212453.7b0aa119@batman.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Dec 2024 21:24:53 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> > On my 32bit build, I hit a new warning;
> >=20
> > kernel/trace/bpf_trace.c:1073:22: warning: =E2=80=98ftrace_get_entry_ip=
=E2=80=99 defined but not used [-Wunused-function]
> >  1073 | static unsigned long ftrace_get_entry_ip(unsigned long fentry_i=
p)
> >       |                      ^~~~~~~~~~~~~~~~~~~
> >=20
> > Config attached. =20
>=20
>=20
> Since this is the last patch of the series, just send a new patch for thi=
s one.
> I'll continue testing the rest of the patches.

The tests passed without this patch so I applied them to my for-next branch.

If you fix this, you just need to send this patch only.

Thanks,

-- Steve

