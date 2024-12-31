Return-Path: <linux-arch+bounces-9549-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D99E9FF062
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 16:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B0F73A2F6C
	for <lists+linux-arch@lfdr.de>; Tue, 31 Dec 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D661A238D;
	Tue, 31 Dec 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gOkH4oyP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1724B1A08B1;
	Tue, 31 Dec 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660097; cv=none; b=m5YA9LlolGFmt3lqgVbNiKZDCqrjPjxvWLdRltD1yzvL0GFe8w7KpHc7QW48/yOBSwF1HcB3zSmpeIDlu7Oc/3hYMx/lVxA6Gm4rNpZ6k81jBUtamYw3HhdDfS1N90Q8BCsJnp5KytnWm3JMsYn2Hwv5wDhXetM37io/ZWFlj8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660097; c=relaxed/simple;
	bh=r7tf2xE0jrAAyvYeMWSfyNsjAJXOkaB/xJW3hNeRhRU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MAFl8XWQAznr7tGMRvXYXOB2C22krA8cnb127D7pQtx4WUUxWob6pihbODmQTPt2KvbQETEZQZXiKpdeNhCZFhXTzB4qY4/eXIrkiwRzvWLYrY82cQI8a5cgC7BDyGH+qgpQFrMjbF4bf1ONtlfW1LOZ+KY4t8973ZupnDUSetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gOkH4oyP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD423C4CED2;
	Tue, 31 Dec 2024 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735660096;
	bh=r7tf2xE0jrAAyvYeMWSfyNsjAJXOkaB/xJW3hNeRhRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gOkH4oyPmdA8sxYEPZek8TjUUApOsoqGuOTog4bxkEGx6NNJsMSTO2qjxNJN3j90h
	 YYrITjQMV0vO0NAAT1qMMs/oJBp8yQDTbM5+CFPBUt/C+qlOV4e7VodZnY0kMcuXwf
	 bjz+OuWEFvEy6Qp9/s2t9cWLnzPKmERrH3T7jOjURtb4IPu3Y/56WF4GIg8+Xs6CRE
	 +mkQ7G0w2jKUCfzq0Ndh2TF9gfGh9AV2algHD/KmGN958jOeYzqK+BZeJcKNYy4XDn
	 MPAmq5tjtvzenb3Rjw894IB/yuVcW3fALTMgeL4GxxCGMVPxWFvTUCp9ULn7HSMq24
	 olcSVf1vfQCBg==
Date: Wed, 1 Jan 2025 00:48:11 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 20/20] bpf: Use ftrace_get_symaddr() for
 kprobe_multi probes
Message-Id: <20250101004811.b72e32be7e9649e690738dec@kernel.org>
In-Reply-To: <20241227102452.14a1c2d9@gandalf.local.home>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
	<173519012541.391279.12203132904339088937.stgit@devnote2>
	<20241226212339.2f871f94@batman.local.home>
	<20241226212453.7b0aa119@batman.local.home>
	<20241227102452.14a1c2d9@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Fri, 27 Dec 2024 10:24:52 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 26 Dec 2024 21:24:53 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > On my 32bit build, I hit a new warning;
> > > 
> > > kernel/trace/bpf_trace.c:1073:22: warning: ‘ftrace_get_entry_ip’ defined but not used [-Wunused-function]
> > >  1073 | static unsigned long ftrace_get_entry_ip(unsigned long fentry_ip)
> > >       |                      ^~~~~~~~~~~~~~~~~~~
> > > 
> > > Config attached.  
> > 
> > 
> > Since this is the last patch of the series, just send a new patch for this one.
> > I'll continue testing the rest of the patches.
> 
> The tests passed without this patch so I applied them to my for-next branch.

Thanks!

> 
> If you fix this, you just need to send this patch only.


OK, let me fix this issue. 

> 
> Thanks,
> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

