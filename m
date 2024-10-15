Return-Path: <linux-arch+bounces-8192-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8438099FC72
	for <lists+linux-arch@lfdr.de>; Wed, 16 Oct 2024 01:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E376FB26430
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 23:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A3F1E6311;
	Tue, 15 Oct 2024 23:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUY2J+zT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147DB1DD880;
	Tue, 15 Oct 2024 23:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729034747; cv=none; b=B9gjVCAnHP3SVL2+zfV6jKHjwpA5N6Nz5IVXYFs6A7PiNaE3mCYvNHjzC+jHDgJgbugOh4bSzKpgmzbE6JTYNCI6iQh5+gDRNuYtl6c1G5DM458xPVah/ajzC4F5HL30bnOTPKQfi3+895y+qFsfWhtbIxrCGBoZlADsD7QdiUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729034747; c=relaxed/simple;
	bh=jjCW4xAfQsZhSMNoelCTZkCqxoymOYhjGbyXkEbogLg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=UpRT8rnTZNVJOx+ghv7Ju2b3DfkHVLd5zaSTp5lrQTa47I66IpLmMylvpEUNWripXjDj6lYYMYWc3graLBlqJdy5eXEMmKRHPORFXz912lmZoN7rYAnQWACPBh6fHVFRL1jY22pKkQrD8nBnltzwGCbbJ1mtyZTgAwOQ/8+IQ/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUY2J+zT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7992FC4CECF;
	Tue, 15 Oct 2024 23:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729034746;
	bh=jjCW4xAfQsZhSMNoelCTZkCqxoymOYhjGbyXkEbogLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AUY2J+zTtrPJzLiWRKXn/3cWoVbQtGhrABR52n24aRbhiPgS/uZedIRUzU5YV6Rog
	 mMn13+aBguHS9u5C2h8Q9x3b0Zmy5lb9j2NjP4NBVvubNGKotl9FX/loPDfo3gVlWk
	 LZvSWfJ1ZuMjuQbcWklKYMRUItDBf9qZSxJXLd1bY12NRSCDNnvS1G4Eb3/+9JDvxO
	 oSIRHYtaB6fJB1bcIrIOEiDw0TcIfIIJQuv5MMixHA5ySdY6tQ8AjPzJyIvwqiPB8Q
	 DyHwCRlKmVsIT8i380bN2t4lX2/EqekxCiFmUK7EoBbDRpzbvglZe7cLT6Uf83h7CH
	 3m1t7c6p5/G+w==
Date: Wed, 16 Oct 2024 08:25:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Florent Revest
 <revest@chromium.org>, linux-trace-kernel@vger.kernel.org, LKML
 <linux-kernel@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, Mark Rutland
 <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v16 01/18] tracing: Use arch_ftrace_regs() for
 ftrace_regs_*() macros
Message-Id: <20241016082541.6d5d278d425e05b8295c0193@kernel.org>
In-Reply-To: <20241015172757.3221a96f@gandalf.local.home>
References: <172895571278.107311.14000164546881236558.stgit@devnote2>
	<172895572290.107311.16057631001860177198.stgit@devnote2>
	<20241015172757.3221a96f@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 17:27:57 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> 
> FYI, for anything to do with function hooks (fentry), the subject should be
> "ftrace:" not "tracing:".

Ah, yes.

> 
> Tracing has to do with the tracing infrastructure, whereas ftrace is the
> function hook infrastructure.
> 
> I just accepted the first two patches of this series and made the changes
> to the subjects.

OK, thanks!

> 
> If a change is for function graph infrastructure specifically, you can use
> "fgraph:" instead.

Just to confirm, is "function_graph:" for function graph tracer itself?

Thank you,

> 
> -- Steve
> 
> 
> On Tue, 15 Oct 2024 10:28:43 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Since the arch_ftrace_get_regs(fregs) is only valid when the
> > FL_SAVE_REGS is set, we need to use `&arch_ftrace_regs()->regs` for
> > ftrace_regs_*() APIs because those APIs are for ftrace_regs, not
> > complete pt_regs.
> > 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>

