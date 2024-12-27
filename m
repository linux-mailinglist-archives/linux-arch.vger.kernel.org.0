Return-Path: <linux-arch+bounces-9516-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E25839FCFA5
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 03:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B37163B50
	for <lists+linux-arch@lfdr.de>; Fri, 27 Dec 2024 02:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FCAC35947;
	Fri, 27 Dec 2024 02:24:57 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124943224;
	Fri, 27 Dec 2024 02:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735266297; cv=none; b=fPD2AQuiZzvHRplMZxNeGqrHAwUgJ2LzppFGfagd2t+1KQNIsjiofv/Dh9lQgwqozQryiAjGeriVbDr7Dg4rXIcC3QVsN3qXdRlEfCOd02hriLkB/uVN//fWnQ5jLP5CjydrM+fbZuud2tvt+Tz7I9b2wAfcjsLxiz+8+X1KGx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735266297; c=relaxed/simple;
	bh=8E0CutWQo5dwCGm3rZZrX5kwET5lzDDvVAscvRjFxpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbq3RFSPBnHbWA2SZeEoYHYHKOrKuqx2GGPgqjHXYo+oYlDTnlnErMV6Wp4jYQsJG6w+OjuXFY1VQpcRFolEviuwOQd7OD3Rm/i0rfIBfMha1zylkIFLuE0atSi1NqRK5iR2AO+XGo9X/OgAn+V6pJ530f6bNy+sHfK8zZoswFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18DC0C4CED1;
	Fri, 27 Dec 2024 02:24:54 +0000 (UTC)
Date: Thu, 26 Dec 2024 21:24:53 -0500
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
Message-ID: <20241226212453.7b0aa119@batman.local.home>
In-Reply-To: <20241226212339.2f871f94@batman.local.home>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<173519012541.391279.12203132904339088937.stgit@devnote2>
	<20241226212339.2f871f94@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 26 Dec 2024 21:23:39 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Dec 2024 14:15:25 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
>=20
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >=20
> > Add ftrace_get_entry_ip() which is only for ftrace based probes, and use
> > it for kprobe multi probes because they are based on fprobe which uses
> > ftrace instead of kprobes.
> >=20
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org> =20
>=20
> On my 32bit build, I hit a new warning;
>=20
> kernel/trace/bpf_trace.c:1073:22: warning: =E2=80=98ftrace_get_entry_ip=
=E2=80=99 defined but not used [-Wunused-function]
>  1073 | static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
>       |                      ^~~~~~~~~~~~~~~~~~~
>=20
> Config attached.


Since this is the last patch of the series, just send a new patch for this =
one.
I'll continue testing the rest of the patches.

-- Steve


