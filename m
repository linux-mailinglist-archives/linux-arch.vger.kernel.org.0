Return-Path: <linux-arch+bounces-9710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8A1A09EEC
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jan 2025 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EB0C16A7B7
	for <lists+linux-arch@lfdr.de>; Sat, 11 Jan 2025 00:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8535381E;
	Sat, 11 Jan 2025 00:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4tXzvj6"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22937E1;
	Sat, 11 Jan 2025 00:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736553891; cv=none; b=mn7MXvGQ57aFtdjAT/nXza8x8qpkexm47Yool6C02Lj9g5TWORac0vX9NmsmcD9Q9vv390NijXz1bLXGhWcJprgfjxkZci/D1Yn7MwI/0laMQgKj2zW5me3gZWU6DwUFrXKF9tbjle08kYHBxIGBL8b5bmEVYFa+45Z7mYFnwxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736553891; c=relaxed/simple;
	bh=fNTiO6xtYnhwGjrGNuGearQkYI23E3n7BR4rb/cgQHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AxRKIuNr+dkYbsmk8ZSDlh98v9GZFPPoarmJeP7SL9b8fwaQmWp7flJPmUw99hRVFjWOdMsrIZMY8tfbwjAI6/fYdlF4NWPZNZkkXbSw0rwbRCh8vFd+6vummxDGIHQnV3p2MdOyijy/LKjP9otQNW1t7WktP3KqXXEHfKycjJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z4tXzvj6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216401de828so43291355ad.3;
        Fri, 10 Jan 2025 16:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736553889; x=1737158689; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bonLyJ6JIPuL1eNiTcmjAFwP6bs35ylN1Gx9bLqcU8=;
        b=Z4tXzvj6AD2Ow/4oqKGUB/JSKkPT13Qu8fIfctFhsN3MD6rC+Qs9oonfmZ4O0sa9hl
         yJMz23LlcIu9U3jf6HH7b9Ib8QZzaXgrQgCFNFzy8OOonxNx+/L7/W5TTBo4FQUBvqwp
         JngYbtyqmZ5RsUAun34IzfN02kOrke00RX/7TQ9aEc2lXS2NPyPqsfzAxw19rNd4fu0H
         2ujMrfVCQ8WnKsMZhA1ZSG2pWk5J34yeTfa/7jjeD7zNdVQBTmUEhEweCkSfhPj8tXxk
         +tK6vMt57ZysHqligVgSM88lRM/o2tIMNGBemoL/w3oky4W7sPXKzidw467si/VwcB+/
         Kvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736553889; x=1737158689;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bonLyJ6JIPuL1eNiTcmjAFwP6bs35ylN1Gx9bLqcU8=;
        b=be2grNorUSuxzUIMANG4Qzqyna3Y4lMxlDHQ69ISb86rUQXiMft58ZTocxS8NARVX0
         0CAoOue5oCC1c91QFLSXDHoDNbXqd0vGC8ZzgDn2qRfoLOdnfSmjL7TSztMGUpe6Eeb6
         DK1d6nt3S4lcUet+nfi3CBbsISw/Dd0362Oqjg63vHjw2HKkeGypAlOgvhPhEnvaoMIk
         zvvohp2v649z+nBQ77ilJjID1u2UKOTbBBy9stH+V6PYOTnWanfJUTDeGnKtJuWcqQaq
         ampsRC5jd/r6iGOzjhLIPX7BvqK8iRMdIgR8U8x9SqNVC3HCrELf9Rrv1A7xbb0AMxrJ
         FCWA==
X-Forwarded-Encrypted: i=1; AJvYcCV8m1SEG8SlOtFIFLyeIWv/ims0EC9ez3X8ZK2yBjUhYpdjoWx8t/awfhyaLvp54ubjNwaX6zQ5Dqx2mfKEsDgd52EG@vger.kernel.org, AJvYcCVte7q4JrWeFUJm0MW0iSDIePi3rE9C454SAIyG32C50fQcZRkzUv+hxHcRqn5EcJbaOpSAaHK3bF3weQ==@vger.kernel.org, AJvYcCW1cyYuNY7CHQzP5Uz7pN9fuyhsZJw2GkbvG0lE81UR/8m5NN3nIE7ZTwUuqyYIF6kgeNk=@vger.kernel.org, AJvYcCWD4Hc76uB85Ws/xf8EihIlK0oxZElD09ctw2Ypc1CbzGzlWt0YFte1HlvEYE2xe9tDKRipUGUwsljz821V@vger.kernel.org
X-Gm-Message-State: AOJu0YwaZYYRs2Dj3lMW1PFCJU0XWNx+ygb41U+9N6ScuYLORTqyIqS3
	Kl0YY/dTkoHTDLRvKl5LaiLYcCLBPE5xJMtKT3n+FeJ20ev3J57I0VTc+jlmvO3XEVEdmuIi7xG
	5haC4KE7si+soovdkFYzjqa8mpKd8aw==
X-Gm-Gg: ASbGncvQL+EliylcE/TRYZlSd4VBOvViWN+kiu79wF6FaruU5/XIzrxv36v3ZGfc32o
	fN1BghLHvSTk5Ic1uoDTWIzcu2Dq8UJLpFizVPZAWYPdtNi4p/ckNow==
X-Google-Smtp-Source: AGHT+IF1oRHwTKWMsbpUib7jhYExZc2DppCPYm5PHYUUG6o7mQAMKIEpvqV+cQiYUjHBw9b1chSAyQJDhliRJb9a9QU=
X-Received: by 2002:a17:90a:d2d0:b0:2ee:7a4f:9265 with SMTP id
 98e67ed59e1d1-2f548eae0a0mr19541970a91.15.1736553889146; Fri, 10 Jan 2025
 16:04:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <173518987627.391279.3307342580035322889.stgit@devnote2> <Z3aSuql3fnXMVMoM@krava>
In-Reply-To: <Z3aSuql3fnXMVMoM@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 10 Jan 2025 16:04:37 -0800
X-Gm-Features: AbW1kvbk13EDJ-iFrT--c0slWpM7buA85uke6D54ktlz8WUQNmX1fE9KZ2bEfIY
Message-ID: <CAEf4BzZqpHcqRJscQtAJJ7tLMpdq4_Dr_j7APj=X2g-pnkELVg@mail.gmail.com>
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

On Thu, Jan 2, 2025 at 5:21=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrote=
:
>
> On Thu, Dec 26, 2024 at 02:11:16PM +0900, Masami Hiramatsu (Google) wrote=
:
> > Hi,
> >
> > Here is the 22nd version of the series to re-implement the fprobe on
> > function-graph tracer. The previous version is;
> >
> > https://lore.kernel.org/all/173379652547.973433.2311391879173461183.stg=
it@devnote2/
> >
> > This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-32 an=
d
> > [5/20] for build error.
>
>
> hi,
> I ran the bench and I'm seeing native_sched_clock being used
> again kretprobe_multi bench:
>
>      5.85%  bench            [kernel.kallsyms]                           =
             [k] native_sched_clock
>             |
>             ---native_sched_clock
>                sched_clock
>                |
>                 --5.83%--trace_clock_local
>                           ftrace_return_to_handler
>                           return_to_handler
>                           syscall
>                           bpf_prog_test_run_opts

completely unrelated, Jiri, but we should stop using
bpf_prog_test_run_opts() for benchmarking. It goes through FD
refcounting, which is unnecessary tiny overhead, but more importantly
it causes cache line bouncing between multiple CPUs (when doing
multi-threaded benchmarks), which skews and limits results.

>                           trigger_producer_batch
>                           start_thread
>                           __GI___clone3
>
> I recall we tried to fix that before with [1] change, but that replaced
> later with [2] changes
>
> When I remove the trace_clock_local call in __ftrace_return_to_handler
> than the kretprobe-multi gets much faster (see last block below), so it
> seems worth to make it optional
>
> there's some decrease in kprobe_multi benchmark compared to base numbers,
> which I'm not sure yet why, but other than that it seems ok
>
> base:
>         kprobe         :   12.873 =C2=B1 0.011M/s
>         kprobe-multi   :   13.088 =C2=B1 0.052M/s
>         kretprobe      :    6.339 =C2=B1 0.003M/s
>         kretprobe-multi:    7.240 =C2=B1 0.002M/s
>
> fprobe_on_fgraph:
>         kprobe         :   12.816 =C2=B1 0.002M/s
>         kprobe-multi   :   12.126 =C2=B1 0.004M/s
>         kretprobe      :    6.305 =C2=B1 0.018M/s
>         kretprobe-multi:    7.740 =C2=B1 0.003M/s
>
> removed native_sched_clock call:
>         kprobe         :   12.850 =C2=B1 0.006M/s
>         kprobe-multi   :   12.115 =C2=B1 0.006M/s
>         kretprobe      :    6.270 =C2=B1 0.017M/s
>         kretprobe-multi:    9.190 =C2=B1 0.005M/s
>
>
> happy new year ;-) thanks,
>
> jirka
>
>
> [1] https://lore.kernel.org/bpf/172615389864.133222.14452329708227900626.=
stgit@devnote2/
> [2] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
>

[...]

