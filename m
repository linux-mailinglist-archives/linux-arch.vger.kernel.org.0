Return-Path: <linux-arch+bounces-3199-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4FE88CE0B
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 21:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A286DB219EA
	for <lists+linux-arch@lfdr.de>; Tue, 26 Mar 2024 20:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8160513D506;
	Tue, 26 Mar 2024 20:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KPvLO7qA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD3A13D28F
	for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 20:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484097; cv=none; b=spfhtDEmZV7Wjc8nFa+4UXy7h8PkV5zyhgVssiN1fnZ0YpEvwSeL1xp4RuAMILjMxSZPDGLtt/yneNl07NPtiNdQMcTlSYfWeXEyQGMu41u5iMZq4GPAXKULbK51CMDYHvHfSjAtjAId2tz9yO519ifyO821Ub5/YG4AbKoZrjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484097; c=relaxed/simple;
	bh=6jKpOWJ+LWFlZC4DPjtJM6QnKsaH5cXRpUTLZjP2Byk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jk5sbgt7jXowXDITc7QvIprpigqfv4o4E323/4hmx+dUqxKvXv8+iSOLOHjW9yxwyvI7XKviTksAfo+Rs8FOFQEalDDdTTQMUVqDFU1mUGjD1DcCTxpNEA2QpoEde6lAhDq+6RDOt1A1xi12BSg+AG4CNJR4qiwRr5LlxoPeCXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KPvLO7qA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so7420950a12.2
        for <linux-arch@vger.kernel.org>; Tue, 26 Mar 2024 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711484093; x=1712088893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jKpOWJ+LWFlZC4DPjtJM6QnKsaH5cXRpUTLZjP2Byk=;
        b=KPvLO7qAkCiHfLM+7yYD85XG5SeVblySb+Qyp5kGaAjTA/hczmDKSHgcVEPlfaUlGr
         IMmaSRtqEP4EjGQdyLe0fIEy9yBSIXzWsYF76hwt339EjpdwJlc6+it4Bke1Cz158+wK
         JvahVWgtv+0XsyS/8WtGkD57oDyuWnLXOxkCQBFeVRxIDY58YBosEToyALwz5grXmRUM
         DagkNt9M3oVW1iS5Q+0NBO7V9VuGzfw/4IEU7WFUJhMAuG9s910IAyvv6jkVM49kKGzP
         aDV+E70H6fI9HFQoiVX93VpTbD1PryU9FIvU2TvI+ioykPDls2+kiOH16gPBBnSBRN+V
         ancA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711484093; x=1712088893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jKpOWJ+LWFlZC4DPjtJM6QnKsaH5cXRpUTLZjP2Byk=;
        b=ebDJmvTPeyBaSOlaKSrz6s2nDqjhpcx9mmOViDTXZw/O1da/vdUE8yicD++JLyjVGx
         KQWcjzU2VeIJtmQMjbkRupmbRpJXSRDNL5Tmyi/nBY0Otd1sNhMIKnpWe0DM+/cyAXii
         FD8QmEYpzwdcuDSWhbLa5RNgja1FwQI8psAdaopUoKuI55yNaTbVPtXIA/YeTCZc9s54
         gsC2lPlD9Pw3xMheQGaruw4XFW9PL7uidEzKhdEESKoFkN63q5ii7JwFbQaL+iYCXjX1
         ZMsPvEDr0J82acVRIToU/B9FTINhLWJCvbb3De4iVgiRQAkOwCYIv/zQdzYTifmN3VC6
         UOSQ==
X-Forwarded-Encrypted: i=1; AJvYcCVJum9b7gZ4pqQIHb/JTMcKDNFVmh/PzlwE3bU5sz45ZbAgbWjJoEU3YdsE8oFeA6PUv9lal4P43pE9CE3xsPnyZpKdN5mUqTIs6Q==
X-Gm-Message-State: AOJu0Ywn8YXZwyHTEiy3SZVrb9LsyGSje0UV9QTLKC6vWjF3Gg+HXiol
	bgXzb6S0RPahxEspqQ9P2SjrglEPwVIi5S4BtPEQSYL5yEzeoyz5cehnfkwuLGRR9UznLkgMKH2
	RRNLBTiyLvixwe/DebRS3SM9Un93Sx9I+/ucJ
X-Google-Smtp-Source: AGHT+IHNbZvU94ocsPuARsH8Mie4+EyFLOQLiJ99ddFMOV+2ee5fWO0HjR082QS+izq6JTEydRhhd/UQfdi1W0fksuE=
X-Received: by 2002:a17:907:76f2:b0:a47:32b3:18c5 with SMTP id
 kg18-20020a17090776f200b00a4732b318c5mr521341ejc.68.1711484092750; Tue, 26
 Mar 2024 13:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <6208950d-6453-e797-7fc3-1dcf15b49dbe@huawei.com> <CAHS8izMwTRyqUS0iRtErfAqDVsXRia5Ajx9PRK3vcfo8utJoUA@mail.gmail.com>
 <CAHS8izPR+SioMKNv3=2ajK=GGOE26BTaxOMykHJfjttqYjx1wQ@mail.gmail.com> <ca9ab650-3f77-509c-7a29-6d7dd775b6d1@huawei.com>
In-Reply-To: <ca9ab650-3f77-509c-7a29-6d7dd775b6d1@huawei.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 26 Mar 2024 13:14:39 -0700
Message-ID: <CAHS8izPPiyNQNKSGfZ22DU3ta2vmq6pZOJPPGqxD_5hNpuJU+Q@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 00/15] Device Memory TCP
To: Yunsheng Lin <linyunsheng@huawei.com>, shakeel.butt@linux.dev
Cc: YiFei Zhu <zhuyifei@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 26, 2024 at 5:47=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.co=
m> wrote:
>
> On 2024/3/26 8:28, Mina Almasry wrote:
> > On Tue, Mar 5, 2024 at 11:38=E2=80=AFAM Mina Almasry <almasrymina@googl=
e.com> wrote:
> >>
> >> On Tue, Mar 5, 2024 at 4:54=E2=80=AFAM Yunsheng Lin <linyunsheng@huawe=
i.com> wrote:
> >>>
> >>> On 2024/3/5 10:01, Mina Almasry wrote:
> >>>
> >>> ...
> >>>
> >>>>
> >>>> Perf - page-pool benchmark:
> >>>> ---------------------------
> >>>>
> >>>> bench_page_pool_simple.ko tests with and without these changes:
> >>>> https://pastebin.com/raw/ncHDwAbn
> >>>>
> >>>> AFAIK the number that really matters in the perf tests is the
> >>>> 'tasklet_page_pool01_fast_path Per elem'. This one measures at about=
 8
> >>>> cycles without the changes but there is some 1 cycle noise in some
> >>>> results.
> >>>>
> >>>> With the patches this regresses to 9 cycles with the changes but the=
re
> >>>> is 1 cycle noise occasionally running this test repeatedly.
> >>>>
> >>>> Lastly I tried disable the static_branch_unlikely() in
> >>>> netmem_is_net_iov() check. To my surprise disabling the
> >>>> static_branch_unlikely() check reduces the fast path back to 8 cycle=
s,
> >>>> but the 1 cycle noise remains.
> >>>>
> >>>
> >>> The last sentence seems to be suggesting the above 1 ns regresses is =
caused
> >>> by the static_branch_unlikely() checking?
> >>
> >> Note it's not a 1ns regression, it's looks like maybe a 1 cycle
> >> regression (slightly less than 1ns if I'm reading the output of the
> >> test correctly):
> >>
> >> # clean net-next
> >> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 8 cycles(tsc)
> >> 2.993 ns (step:0)
> >>
> >> # with patches
> >> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 9 cycles(tsc)
> >> 3.679 ns (step:0)
> >>
> >> # with patches and with diff that disables static branching:
> >> time_bench: Type:tasklet_page_pool01_fast_path Per elem: 8 cycles(tsc)
> >> 3.248 ns (step:0)
> >>
> >> I do see noise in the test results between run and run, and any
> >> regression (if any) is slightly obfuscated by the noise, so it's a bit
> >> hard to make confident statements. So far it looks like a ~0.25ns
> >> regression without static branch and about ~0.65ns with static branch.
> >>
> >> Honestly when I saw all 3 results were within some noise I did not
> >> investigate more, but if this looks concerning to you I can dig
> >> further. I likely need to gather a few test runs to filter out the
> >> noise and maybe investigate the assembly my compiler is generating to
> >> maybe narrow down what changes there.
> >>
> >
> > I did some more investigation here to gather more data to filter out
> > the noise, and recorded the summary here:
> >
> > https://pastebin.com/raw/v5dYRg8L
> >
> > Long story short, the page_pool benchmark results are consistent with
> > some outlier noise results that I'm discounting here. Currently
> > page_pool fast path is at 8 cycles
> >
> > [ 2115.724510] time_bench: Type:tasklet_page_pool01_fast_path Per
> > elem: 8 cycles(tsc) 3.187 ns (step:0) - (measurement period
> > time:0.031870585 sec time_interval:31870585) - (invoke count:10000000
> > tsc_interval:86043192)
> >
> > and with this patch series it degrades to 10 cycles, or about a 0.7ns
> > degradation or so:
>
> Even if the absolute value for the overhead is small, we seems have a
> degradation of about 20% for tasklet_page_pool01_fast_path testcase,
> which seems scary.
>
> I am assuming that every page is recyclable for tasklet_page_pool01_fast_=
path
> testcase, and that code path matters for page_pool, it would be good to
> remove any additional checking for that code path.
>

We can remove the usage of static_branch_unlikely in the net_iov
check, which reduces the overhead to 1 cycle (8->9), only 12.5%
overhead. The addition of the static_branch_unlikely is not improving
the performance of devmem TCP anyway. From previous discussions with
Jesper he deemed a 1 cycle degradation acceptable, but he hasn't
commented in a while, he may have changed his mind but so far no
complaints.

We can additionally only add the check only if
CONFIG_SHARED_DMA_BUFFER is enabled. I've tested that and the fast
path goes back to 8 cycles (0 overhead). If CONFIG_SHARED_DMA_BUFFER
is not enabled then netmem can't be dmabuf anyway, so no reason to
check.

> And we already have pool->has_init_callback checking when we have to use
> a new page, it may make sense to refactor that to share the same checking
> for provider to avoid the overhead as much as possible.
>
> Also, I am not sure if it really matter that much, as with the introducin=
g
> of netmem_is_net_iov() checking spreading in the networking, the overhead
> might add up for other case too.


--=20
Thanks,
Mina

