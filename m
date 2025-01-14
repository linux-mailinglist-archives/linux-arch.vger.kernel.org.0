Return-Path: <linux-arch+bounces-9746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F66FA10A72
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 16:12:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A584F3A4501
	for <lists+linux-arch@lfdr.de>; Tue, 14 Jan 2025 15:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0502B18EFCC;
	Tue, 14 Jan 2025 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XmNHmbHD"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B86156861;
	Tue, 14 Jan 2025 15:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736867534; cv=none; b=FA4UYaKgYT4S9qDJ/qGWav7cBmIgDrBrQDGr862EuaSqRfZt3cwb4RfNfiOnSKPFp6d18+WQFyR4OOVJKJcUSLO7b4DXTpbRf1LuxvBmzKYCRrLOffNNI22ZoTKqst6B5SdFMH0fasjXPL/W7Ncipuf6uCjhakMx8evX9kit46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736867534; c=relaxed/simple;
	bh=aQSovnBzkHcuz6WM1TbLZmxPJoyUFcvs5ttR0CXBFIY=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZOToU+Y3/L+CrRwSZM/DT0fBAyixN4khahIAdWEDDgaXclIwew3JkPQjigMxl3zgL1+1szyk7qCwU7zI+Y/3fwPpXTQ8VJ2oam55EgR1QSj8+JBqKZuNvr2tXzGj4CIeruHBtZsbACgO40vZhYK/c+0ur8YPlnvX2NdqL5PU8iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XmNHmbHD; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5d9837f201aso9688504a12.0;
        Tue, 14 Jan 2025 07:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736867531; x=1737472331; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/HZZc+UEq0CGN1sRadnQj4s5cYW3b7K0MPBM2aTCRvM=;
        b=XmNHmbHDCTbmVXnZGenyjmbc9M/Ph0Oj/6Fk3ji45aUJW7NyCRPwJ9HG5M4Uy/QKZO
         HsXg1mCiXXexvMhEXpCTLHvCUroPa8diiybjhr/cscJnFaStxwRJN+AYo71hoCepBiLu
         CpIRuHJjOQqVWx+U37XMnWsGutNyfuFtvnzLl6vIOB/LsYiwU/QzKocQCzypoLd+jO2f
         tB4joiCNci2IYKasIdednmD07v6YTOcnem4VA7Lr3ojHoZSnszKYTQSs8mGuKjYdLaCG
         E4mYGyJ2FTMJ99Kgp9UupQNuv1cjA/KdiqFkFJqmccH7kSftcvMlyG0WBngXpe/cI7gk
         JrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736867531; x=1737472331;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/HZZc+UEq0CGN1sRadnQj4s5cYW3b7K0MPBM2aTCRvM=;
        b=GNnSOjZUlgPOi0vnmu1pzXct+nyJq6WjmOFWBP5+vDjs/YGw5a8U1pM4Zs5a7RcK+G
         LK1EHbhZ1C0MMsq6kk2EuIyxUCTH8QoiE/QRXBMcOYHb3nrsyMm119b5zVDCpZlGkThP
         vm29hwc2gDIXAEH7kkTrwg6gZqST1SyKc4wIi2dInPXQnMjL4R8hm3ZI5KvuRH6FD3Pv
         TfGUcwVdZiFnsBb7D1h9jjBgV6snfzf9HCWN/0zOaBnmwTxOen5FhrF5pHHX0BIWU0BW
         ViqHbbioFs9i4u+LAbDS3Te+FHPoHy3n7s3dsVkE8NKpHprcgCcD6otCnvUfAZiR6VnE
         7faw==
X-Forwarded-Encrypted: i=1; AJvYcCURme6O5MxgSsXGozgk74OU2cWiHU3XYPIFZmWYn2S7WHPsATDsiztl1tSzVCnGrN2PUprAMxiIZlF1qgJWFm6ZrXId@vger.kernel.org, AJvYcCVK/gb462B9yqdGBvluP3SlC+C1OSDYL69GzjXmVWEu8MOXFMKE9HSTUT7qYnx1GcFzmkrA/HKkvnUQrYuC@vger.kernel.org, AJvYcCVX2d7OfMpoqOI7yB1Cqb+KgTjC160xF/FrSnrnBn7UpwhaT4PQtpc5h4FLC6vU2RgmuWw=@vger.kernel.org, AJvYcCWm68LYiqTvRhsumW/e+D6x14NNpWC2X0U3mTPxxOH59H22mI6m3qCRuoUxvOIhP1frR15PlSwRRXCXTg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYaurzjiE1q+VMj2RChnosqKNzaHgQ3nngyXn/SrXZ1MNBS/5a
	7QAWYwWNv1KrQp7qUTvYsWQnfYWIVRgYG/I3C/iE8IIDLI1ArrNx
X-Gm-Gg: ASbGnculcpW0BasaA97CXM21AW6pwUNj67qd0sMRpOdwVMUtWPDKWEKekKSPoHG6e0n
	j2aYEqcEtqQydIhV8WxkdaBCtV22st02BzjMZpXNnKxuXoBB3EOduXD6EdZrcPJEYh5IAmVqqEW
	PtTMvr2Xxgt2ERwbUddcQuF++7sVTiLG3BwOMTQSUOq6DFs2CPS/geOlRSOOv+LUb1YB4ik7/e0
	as6OFiYjoi1Tcw79+iZIbylRC2k+VzlnDAuae6IuUM=
X-Google-Smtp-Source: AGHT+IG/0yT3Wl8pMP0ffaB+beFLGUhnbi+/MuQ3opaHndPsnUahqVvRgymIA+k6+73HsX0bkC74RQ==
X-Received: by 2002:a17:907:c1d:b0:aaf:137:b5fa with SMTP id a640c23a62f3a-ab2c3db0396mr1622731666b.26.1736867531297;
        Tue, 14 Jan 2025 07:12:11 -0800 (PST)
Received: from krava ([213.175.46.84])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab3261f1bb1sm204442366b.104.2025.01.14.07.12.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 07:12:10 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 14 Jan 2025 16:12:08 +0100
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Florent Revest <revest@chromium.org>,
	linux-trace-kernel@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	Mark Rutland <mark.rutland@arm.com>, linux-arch@vger.kernel.org
Subject: Re: [PATCH v22 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-ID: <Z4Z-yC_mBTa6Ws70@krava>
References: <173518987627.391279.3307342580035322889.stgit@devnote2>
 <Z3aSuql3fnXMVMoM@krava>
 <CAEf4BzZqpHcqRJscQtAJJ7tLMpdq4_Dr_j7APj=X2g-pnkELVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzZqpHcqRJscQtAJJ7tLMpdq4_Dr_j7APj=X2g-pnkELVg@mail.gmail.com>

On Fri, Jan 10, 2025 at 04:04:37PM -0800, Andrii Nakryiko wrote:
> On Thu, Jan 2, 2025 at 5:21 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> >
> > On Thu, Dec 26, 2024 at 02:11:16PM +0900, Masami Hiramatsu (Google) wrote:
> > > Hi,
> > >
> > > Here is the 22nd version of the series to re-implement the fprobe on
> > > function-graph tracer. The previous version is;
> > >
> > > https://lore.kernel.org/all/173379652547.973433.2311391879173461183.stgit@devnote2/
> > >
> > > This version is rebased on v6.13-rc4 with fixes on [3/20] for x86-32 and
> > > [5/20] for build error.
> >
> >
> > hi,
> > I ran the bench and I'm seeing native_sched_clock being used
> > again kretprobe_multi bench:
> >
> >      5.85%  bench            [kernel.kallsyms]                                        [k] native_sched_clock
> >             |
> >             ---native_sched_clock
> >                sched_clock
> >                |
> >                 --5.83%--trace_clock_local
> >                           ftrace_return_to_handler
> >                           return_to_handler
> >                           syscall
> >                           bpf_prog_test_run_opts
> 
> completely unrelated, Jiri, but we should stop using
> bpf_prog_test_run_opts() for benchmarking. It goes through FD
> refcounting, which is unnecessary tiny overhead, but more importantly
> it causes cache line bouncing between multiple CPUs (when doing
> multi-threaded benchmarks), which skews and limits results.

so you mean to switch directly to attaching/hitting kernel functions
or perhaps better have kernel module for that?

jirka

> 
> >                           trigger_producer_batch
> >                           start_thread
> >                           __GI___clone3
> >
> > I recall we tried to fix that before with [1] change, but that replaced
> > later with [2] changes
> >
> > When I remove the trace_clock_local call in __ftrace_return_to_handler
> > than the kretprobe-multi gets much faster (see last block below), so it
> > seems worth to make it optional
> >
> > there's some decrease in kprobe_multi benchmark compared to base numbers,
> > which I'm not sure yet why, but other than that it seems ok
> >
> > base:
> >         kprobe         :   12.873 ± 0.011M/s
> >         kprobe-multi   :   13.088 ± 0.052M/s
> >         kretprobe      :    6.339 ± 0.003M/s
> >         kretprobe-multi:    7.240 ± 0.002M/s
> >
> > fprobe_on_fgraph:
> >         kprobe         :   12.816 ± 0.002M/s
> >         kprobe-multi   :   12.126 ± 0.004M/s
> >         kretprobe      :    6.305 ± 0.018M/s
> >         kretprobe-multi:    7.740 ± 0.003M/s
> >
> > removed native_sched_clock call:
> >         kprobe         :   12.850 ± 0.006M/s
> >         kprobe-multi   :   12.115 ± 0.006M/s
> >         kretprobe      :    6.270 ± 0.017M/s
> >         kretprobe-multi:    9.190 ± 0.005M/s
> >
> >
> > happy new year ;-) thanks,
> >
> > jirka
> >
> >
> > [1] https://lore.kernel.org/bpf/172615389864.133222.14452329708227900626.stgit@devnote2/
> > [2] https://lore.kernel.org/all/20240914214805.779822616@goodmis.org/
> >
> 
> [...]

