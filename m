Return-Path: <linux-arch+bounces-9783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E21EA110BA
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 20:04:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 824B37A2ED1
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 19:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF0E1FBC98;
	Tue, 14 Jan 2025 19:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRvrKmYX"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44811B85FA;
	Tue, 14 Jan 2025 19:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736881489; cv=none; b=NCRYX7nwvIWTNMotZaV6UrAnpImx8SHX4+YmLmoJXJghGENr/dpfV4DmJnWs26QlknQzEGPboMwZv1ahksk0wpWAwaMwqhwNmHVKenGu3JsxrUHxQC/AxK/1DPSc7FemBLgyq9/r6Xb8oaA6/EinddxCrJLCKT3lRP9on7G8rNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736881489; c=relaxed/simple;
	bh=OqGK6Z8tSyIVe/r/lJjFfsY83wr55JwqJyKsp3yVWF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HJXNYkYwk55Z5bpG95ssKcuJRM5vXx0s1QK8CBu0K6WokSqA1hD3TPby+10xErfbg9flePH3xJCFDNUM9mfmrh9mfevJm6w27nmp83crX7D+IvVFZuHZjWryzcWlSERRlE4Sky1xc3Thoda3Em3iclWqip9WmQ8kVdc/Pep5WVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRvrKmYX; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2eec9b3a1bbso7829974a91.3;
        Tue, 14 Jan 2025 11:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736881487; x=1737486287; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UEe097M6IZ1c6/MJ6EbTxRLtSdho/vi92Dh1E1/kKsQ=;
        b=DRvrKmYXTsJgj2bNz07kKPEsWwkgYx3DLmd36Yjt6Krhdris/IjxQgJgsDsReCpWQZ
         nvhP0RMjmrInIAHf3653GeHuRAkrbnCU4er8GNCaV3jGtfLgl2m6L48JfYLVzaZsnDWL
         HbhJnuPg3w/uCYAB4UUeoyY2tNAp4MxEL5DhTSHR4GY0/i3wxubkrjxBPQ5oKEg/EztP
         Xw1KxhiOHdRR3mXo5RQ4mBqb49CtFye1AHMXXg0GwYT0/Mg+x5WCFzP3BOmveIIgVsY7
         ZJBZlQYuRi1gr/+5C/D/ZWCIao1kXibVCnBaeqw0jnafBk7gpSFVqPLoc8oHjJ78VyVu
         Scxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736881487; x=1737486287;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UEe097M6IZ1c6/MJ6EbTxRLtSdho/vi92Dh1E1/kKsQ=;
        b=RU0n0a+GAbZeiXNXgt/K4ZSb3ENLg1Q1xcMbF40BG/MbWQn3yzBTSvP8GFoqCLwwPC
         wN4tbZyUV9fb9nAeTDc1oN/57MxV6/siB/kKQ1nfeRucYIPeSBrWklVuhKR0SyrxVXTx
         5EPr4THKbWqYHdtUYYnIPUWBbEX2MkeoCxwD7+EX3/Ik0PpDBhE7SvMnK4MkqrjwmFnI
         cZ4VetAtmlTnDhiqJRN80H5dPLUJuodETjXPWxr6V0fa+RZElwTVo/VXR1GtSxOrK3sB
         0jzhP4664l3z/pRszEvtgzDh6NcUAo6H7GQApn14nDzLwB/pBy4Xo5cWYv1vKTbhGqfb
         lkXQ==
X-Forwarded-Encrypted: i=1; AJvYcCU2o3pkTSEisO4BSO4C9UNPGmN/PF1F64W/Ir3oEyQtb+KXMfc84uG6ElY/Pw6EnN2x9y7G5hPDsSha1bO/yhsdNbj1@vger.kernel.org, AJvYcCU8kEEeVKNNmcJms1atLk0LxnNla3Hi8zVfnpgbLs7ki6kPDrSpZ8DsD35w42Zr10tEG5Y=@vger.kernel.org, AJvYcCV6KE88UFx6VhjobCDwi0Co23emtd4RDrcVGE7QASVfZVXVWXrxzzdYVO1nSYgT1eWxvvSsHzjL5gyETg==@vger.kernel.org, AJvYcCWasxaJAeAwkyqfG8bRxLvtl0Dy3GcQPiy/9zBRLa0Fna5Ft4iqwF7EMRCp9OS9KFhnWhDAIjkaABYsikqi@vger.kernel.org
X-Gm-Message-State: AOJu0YyNS5nwx4B12biXNfozwy6j7/wJb6gk2OcR1qVeMZoZBLvNLxMc
	nBeO9/U6/2wdAM3dSDAQzF6SRHkVH3y5t/UsVpejRUZMnLPCThviVkC0nsbHjDwYqbF7Uee63vx
	namVAPrAMiglj78Z9E//VhC7xJSE=
X-Gm-Gg: ASbGncsUWg0QYkAKXKxY+5jL30C4jk8bCRNPYnbc68YRzT3tQ+ofEUzKX4VcKL5sN17
	pnlEB9XSAsHTYCCG24gA9AFtFYzR/yXYN0gV2
X-Google-Smtp-Source: AGHT+IGPhIcGO+TQXrPWOO1ZPVU0z+5sWXrqDm55mqIBD3SrGU5BTvsIyI5REMrOuVa7A4fXcTnsa5fozQnQr150wfg=
X-Received: by 2002:a17:90b:540e:b0:2ee:a76a:830 with SMTP id
 98e67ed59e1d1-2f548f1b2bfmr40980565a91.24.1736881486958; Tue, 14 Jan 2025
 11:04:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
 <Z3aSuql3fnXMVMoM@krava> <CAEf4BzZqpHcqRJscQtAJJ7tLMpdq4_Dr_j7APj=X2g-pnkELVg@mail.gmail.com>
 <Z4Z-yC_mBTa6Ws70@krava>
In-Reply-To: <Z4Z-yC_mBTa6Ws70@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 14 Jan 2025 11:04:35 -0800
X-Gm-Features: AbW1kva_e4D6M60XyDxQhwRiED82CFE6DG9gGIZh1M2JAQrmjpyscMamojYYM6U
Message-ID: <CAEf4BzbuQxEWfTNRq9163Gi=SMDi3wCpfp+NEMVtz_BRYJxOdg@mail.gmail.com>
Subject: Re: [PATCH v22 00/20] tracing: fprobe: function_graph: Multi-function
 graph and fprobe on fgraph
To: Jiri Olsa <olsajiri@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Florent Revest <revest@chromium.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Alan Maguire <alan.maguire@oracle.com>, 
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 7:12=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Fri, Jan 10, 2025 at 04:04:37PM -0800, Andrii Nakryiko wrote:
> > On Thu, Jan 2, 2025 at 5:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> w=
rote:
> > >
> > > On Thu, Dec 26, 2024 at 02:11:16PM +0900, Masami Hiramatsu (Google) w=
rote:
> > > > Hi,
> > > >
> > > > Here is the 22nd version of the series to re-implement the fprobe o=
n
> > > > function-graph tracer. The previous version is;
> > > >
> > > > https://lore.kernel.org/all/173379652547.973433.2311391879173461183=
.stgit@devnote2/
> > > >
> > > > This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-3=
2 and
> > > > [5/20] for build error.
> > >
> > >
> > > hi,
> > > I ran the bench and I'm seeing native_sched_clock being used
> > > again kretprobe_multi bench:
> > >
> > >      5.85%  bench            [kernel.kallsyms]                       =
                 [k] native_sched_clock
> > >             |
> > >             ---native_sched_clock
> > >                sched_clock
> > >                |
> > >                 --5.83%--trace_clock_local
> > >                           ftrace_return_to_handler
> > >                           return_to_handler
> > >                           syscall
> > >                           bpf_prog_test_run_opts
> >
> > completely unrelated, Jiri, but we should stop using
> > bpf_prog_test_run_opts() for benchmarking. It goes through FD
> > refcounting, which is unnecessary tiny overhead, but more importantly
> > it causes cache line bouncing between multiple CPUs (when doing
> > multi-threaded benchmarks), which skews and limits results.
>
> so you mean to switch directly to attaching/hitting kernel functions
> or perhaps better have kernel module for that?
>

yes, cheap syscall (getpgid or something). Not a kernel module, that's
logistical hassle.

> jirka
>
> >
> > >                           trigger_producer_batch
> > >                           start_thread
> > >                           __GI___clone3
> > >
> > > I recall we tried to fix that before with [1] change, but that replac=
ed
> > > later with [2] changes
> > >
> > > When I remove the trace_clock_local call in __ftrace_return_to_handle=
r
> > > than the kretprobe-multi gets much faster (see last block below), so =
it
> > > seems worth to make it optional
> > >
> > > there's some decrease in kprobe_multi benchmark compared to base numb=
ers,
> > > which I'm not sure yet why, but other than that it seems ok
> > >
> > > base:
> > >         kprobe         :   12.873 =C2=B1 0.011M/s
> > >         kprobe-multi   :   13.088 =C2=B1 0.052M/s
> > >         kretprobe      :    6.339 =C2=B1 0.003M/s
> > >         kretprobe-multi:    7.240 =C2=B1 0.002M/s
> > >
> > > fprobe_on_fgraph:
> > >         kprobe         :   12.816 =C2=B1 0.002M/s
> > >         kprobe-multi   :   12.126 =C2=B1 0.004M/s
> > >         kretprobe      :    6.305 =C2=B1 0.018M/s
> > >         kretprobe-multi:    7.740 =C2=B1 0.003M/s
> > >
> > > removed native_sched_clock call:
> > >         kprobe         :   12.850 =C2=B1 0.006M/s
> > >         kprobe-multi   :   12.115 =C2=B1 0.006M/s
> > >         kretprobe      :    6.270 =C2=B1 0.017M/s
> > >         kretprobe-multi:    9.190 =C2=B1 0.005M/s
> > >
> > >
> > > happy new year ;-) thanks,
> > >
> > > jirka
> > >
> > >
> > > [1] https://lore.kernel.org/bpf/172615389864.133222.14452329708227900=
626.stgit@devnote2/
> > > [2] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
> > >
> >
> > [...]

