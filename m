Return-Path: <linux-arch+bounces-7993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0229991E4
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 21:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A61BB2835A0
	for <lists+linux-arch@lfdr.de>; Thu, 10 Oct 2024 19:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325571CF5F1;
	Thu, 10 Oct 2024 19:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rO6X22gY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 787801CF5FF
	for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 19:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728587157; cv=none; b=MPfEN9x90x1JSTyuontOsPh3h321/7/jj+FselqCiTwm6B69xy4XxsPDjly8bicYkrUkHxa+xnwPjdu8Q8iAjX87kjyCst/Dn1Gti1ALMMw6jXxG4/UGePj1EEBiaw1mrsxsOrE5vnjEqS8QS+k2VQjJM/0yjyXtnKU5ukabGpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728587157; c=relaxed/simple;
	bh=5HPzgAdFormJXXqK8h/l25xPeBcHWohJ3hWfo3eavJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2k7KNJcDPp2lEC3xLTKqVy3vxFY2AxUAYbZ9IOMnqmQ89UCWV4rzwchAN6+CPKy8lkA5VlhHF84GkmQAHhAxOHVYZQ/RjUT/IlG1ZV9/ZP5tKeEPW5Gn7Y1AHjGQB+MDNBo36S8HgeTFaSkNMISDN21SRAUurcJPMYnr783YfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rO6X22gY; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4603d3e0547so50671cf.0
        for <linux-arch@vger.kernel.org>; Thu, 10 Oct 2024 12:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728587153; x=1729191953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SQIULv3PuhYrubi1b4Lzr/jGOZjc/yeQb9Fnkxqp1k=;
        b=rO6X22gYTxAMr2wmMn8kkKQwEpbmuQB9QIm95VKvMJwjIIzb4XpPgtJLXU2ZLU9EgH
         w4j+iglDLGhietiKkyeCmokb7UJjWOdftKSN4IT4cA03gdHcGSPpbVN6e9p/n/PvTRip
         V50jXZGYJJFmbygq0FtHXxbE6jQCjfkOknbnBvccVZc3FF9fqqKJAH436ndS2GxA5ckv
         kmqLddiMuOqeaAhhn7zmaWuHpKTilOVkxs10iamn607JDG0XCg3xVBsZ93yUvfKsOpR2
         dulNVEokzfjKFkEG/6qOrh09E6wwGymvpUPEDzLCusfWL6bdziWKD1qvdkq9rBb11/Qt
         nt/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728587153; x=1729191953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SQIULv3PuhYrubi1b4Lzr/jGOZjc/yeQb9Fnkxqp1k=;
        b=futAaeTM5MNDaRSpsuj0vZsccY3DAtozRlmvHl8Hk9xohhNY56STyAAWRYDPe9Jrci
         ITGR//zfnLloaubLoc/R7BqQCezd/sCgoGTiDcVM7SYrdv2MPvJzXiFuJ/BUkEzJBVGD
         H3skJWAyeA4ouaKbAAMG5HFbl5EhpDAGihUOSlR5GXNGF5WcTLHBAXsxFukL/4fD236j
         zTTAORdFwB8CQItqE920w35NeUzyEAJHjQ5axtuVxytoi2nSwSaJ4/mWVP6P95jzUpWj
         +uApjEf+u8AVC17WkehRyRJMqDhnKtUTe2DLDISOjwNMxokgVrJrW2D3jSAcfFFs9Ncz
         Yetg==
X-Forwarded-Encrypted: i=1; AJvYcCWK3Giz0bYWJg9Ci/jlfbbF27Eo9ZcYo/G4KTgeruuG/Vbf4Dd0NygdnEquZG8krFnyMXNiSBqY9Z3y@vger.kernel.org
X-Gm-Message-State: AOJu0YzonO/LHAX/+o+sjU6lbiYqP/T9kmaALpqV3X7Vwm4F3VV9Hp1c
	/rIQS0AvLJYO7bREKhi1RgnTIpQkdwozm7aR3mFQRNmN7uXWY1a11Xp5rMQG6+aQs5UsYKGoEX7
	HccoEXPswKo7eJkvND3liMWaDVKC0zL09iOUH
X-Google-Smtp-Source: AGHT+IFXW31rsZ9kFmf+FJMtckOgDblc8qAc7+JIkHyyX3UPQEOm0e8exkrBalRYLEuVTVB8uGfh8R0/wFj2yt5Uk7U=
X-Received: by 2002:a05:622a:4f8c:b0:45f:5cd:a617 with SMTP id
 d75a77b69052e-4604b127c4cmr368761cf.9.1728587152864; Thu, 10 Oct 2024
 12:05:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com>
 <20240909054318.1809580-11-almasrymina@google.com> <Zwe3lWTN36IUaIdd@ly-workstation>
In-Reply-To: <Zwe3lWTN36IUaIdd@ly-workstation>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 10 Oct 2024 12:05:38 -0700
Message-ID: <CAHS8izPuEUA20BDXvwq2vW-24ez36YFJFMQok-oBDbgk6bajSA@mail.gmail.com>
Subject: Re: [PATCH net-next v25 10/13] net: add SO_DEVMEM_DONTNEED setsockopt
 to release RX frags
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:17=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> Hi Mina Almasry,
>
> Greetings!
>
> I used Syzkaller and found that there is BUG: soft lockup inqt in linux-n=
ext tree next-20241008
>
> After bisection and the first bad commit is:
> "
> 678f6e28b5f6 net: add SO_DEVMEM_DONTNEED setsockopt to release RX frags
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/tree/main/241009_103423_do_so=
ck_setsockopt/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/refs/heads/main/241009_10=
3423_do_sock_setsockopt/bzImage_8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/241009_103423_do_so=
ck_setsockopt/8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b_dmesg.log
>
> "
> [   48.825073]  ? __lock_acquire+0x1b0f/0x5c90
> [   48.825419]  ? __pfx___lock_acquire+0x10/0x10
> [   48.825774]  sock_setsockopt+0x68/0x90
> [   48.826117]  do_sock_setsockopt+0x3fb/0x480
> [   48.826455]  ? __pfx_do_sock_setsockopt+0x10/0x10
> [   48.826829]  ? lock_release+0x441/0x870
> [   48.827140]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   48.827558]  ? fdget+0x188/0x230
> [   48.827846]  __sys_setsockopt+0x131/0x200
> [   48.828184]  ? __pfx___sys_setsockopt+0x10/0x10
> [   48.828551]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [   48.829042]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [   48.829425]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [   48.829817]  __x64_sys_setsockopt+0xc6/0x160
> [   48.830160]  ? syscall_trace_enter+0x14a/0x230
> [   48.830520]  x64_sys_call+0x6cf/0x20d0
> [   48.830825]  do_syscall_64+0x6d/0x140
> [   48.831124]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   48.831517] RIP: 0033:0x7f26cdc3ee5d
> [   48.831804] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   48.833180] RSP: 002b:00007fff33f36278 EFLAGS: 00000213 ORIG_RAX: 0000=
000000000036
> [   48.833756] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26c=
dc3ee5d
> [   48.834294] RDX: 0000000000000050 RSI: 0000000000000001 RDI: 000000000=
0000003
> [   48.834830] RBP: 00007fff33f36290 R08: 0000000000000010 R09: 00007fff3=
3f36290
> [   48.835368] R10: 0000000020000080 R11: 0000000000000213 R12: 00007fff3=
3f363e8
> [   48.835906] R13: 000000000040178f R14: 0000000000403e08 R15: 00007f26c=
de51000
> [   48.836466]  </TASK>
> [   48.836648] Kernel panic - not syncing: softlockup: hung tasks
> [   48.837096] CPU: 1 UID: 0 PID: 729 Comm: repro Tainted: G             =
L     6.12.0-rc2-8cf0b93919e1 #1
> [   48.837796] Tainted: [L]=3DSOFTLOCKUP
> [   48.838071] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   48.838916] Call Trace:
> [   48.839113]  <IRQ>
> [   48.839282]  dump_stack_lvl+0x42/0x150
> [   48.839584]  dump_stack+0x19/0x20
> [   48.839846]  panic+0x703/0x790
> [   48.840100]  ? __pfx_panic+0x10/0x10
> [   48.840394]  ? watchdog_timer_fn+0x599/0x6b0
> [   48.840727]  ? watchdog_timer_fn+0x58c/0x6b0
> [   48.841065]  watchdog_timer_fn+0x5aa/0x6b0
> [   48.841382]  ? __pfx_watchdog_timer_fn+0x10/0x10
> [   48.841743]  __hrtimer_run_queues+0x5d6/0xc30
> [   48.842091]  ? __pfx___hrtimer_run_queues+0x10/0x10
> [   48.842473]  hrtimer_interrupt+0x324/0x7a0
> [   48.842802]  __sysvec_apic_timer_interrupt+0x10b/0x410
> [   48.843198]  ? debug_smp_processor_id+0x20/0x30
> [   48.843551]  sysvec_apic_timer_interrupt+0xaf/0xd0
> [   48.843922]  </IRQ>
> [   48.844101]  <TASK>
> [   48.844275]  asm_sysvec_apic_timer_interrupt+0x1f/0x30
> [   48.844711] RIP: 0010:__sanitizer_cov_trace_pc+0x45/0x70
> [   48.845130] Code: a9 00 01 ff 00 74 1d f6 c4 01 74 43 a9 00 00 0f 00 7=
5 3c a9 00 00 f0 00 75 35 8b 82 04 1e 00 00 85 c0 74 2b 8b 82 e0 1d 00 00 <=
83> f8 02 75 20 48 8b 8a e8 1d 00 00 8b 92 e4 1d 00 00 48 8b 01 48
> [   48.846480] RSP: 0018:ffff8880239cf790 EFLAGS: 00000246
> [   48.846876] RAX: 0000000000000000 RBX: ffff8880239cf900 RCX: ffffffff8=
581c19f
> [   48.847407] RDX: ffff88801a818000 RSI: ffffffff8581c1d5 RDI: 000000000=
0000007
> [   48.847933] RBP: ffff8880239cf790 R08: 0000000000000001 R09: ffffed100=
4739f23
> [   48.848472] R10: 0000000077cc006e R11: 0000000000000001 R12: 000000000=
0000000
> [   48.849002] R13: 0000000077cc006e R14: ffff8880239cf918 R15: 000000000=
0000000
> [   48.849536]  ? xas_start+0x11f/0x730
> [   48.849818]  ? xas_start+0x155/0x730
> [   48.850101]  xas_start+0x155/0x730
> [   48.850372]  xas_load+0x2f/0x520
> [   48.850629]  ? irqentry_exit+0x3e/0xa0
> [   48.850922]  ? sysvec_apic_timer_interrupt+0x6a/0xd0
> [   48.851304]  xas_store+0x1165/0x1ad0
> [   48.851588]  ? __this_cpu_preempt_check+0x21/0x30
> [   48.851950]  ? irqentry_exit+0x3e/0xa0
> [   48.852254]  __xa_erase+0xc6/0x180
> [   48.852524]  ? __pfx___xa_erase+0x10/0x10
> [   48.852842]  ? __xa_erase+0xf1/0x180
> [   48.853123]  ? sock_devmem_dontneed+0x42c/0x6d0
> [   48.853480]  sock_devmem_dontneed+0x3a8/0x6d0
> [   48.853829]  ? __pfx_sock_devmem_dontneed+0x10/0x10
> [   48.854205]  ? trace_lock_acquire+0x139/0x1b0
> [   48.854548]  ? lock_acquire+0x80/0xb0
> [   48.854833]  ? __might_fault+0xf1/0x1b0
> [   48.855133]  ? __might_fault+0xf1/0x1b0
> [   48.855437]  ? __sanitizer_cov_trace_const_cmp8+0x1c/0x30
> [   48.855849]  sk_setsockopt+0x480/0x3c60
> [   48.856158]  ? __pfx_sk_setsockopt+0x10/0x10
> [   48.856491]  ? __kasan_check_read+0x15/0x20
> [   48.856814]  ? __lock_acquire+0x1b0f/0x5c90
> [   48.857144]  ? __pfx___lock_acquire+0x10/0x10
> [   48.857488]  sock_setsockopt+0x68/0x90
> [   48.857785]  do_sock_setsockopt+0x3fb/0x480
> [   48.858110]  ? __pfx_do_sock_setsockopt+0x10/0x10
> [   48.858474]  ? lock_release+0x441/0x870
> [   48.858776]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   48.859184]  ? fdget+0x188/0x230
> [   48.859448]  __sys_setsockopt+0x131/0x200
> [   48.859764]  ? __pfx___sys_setsockopt+0x10/0x10
> [   48.860123]  ? seqcount_lockdep_reader_access.constprop.0+0xc0/0xd0
> [   48.860598]  ? __sanitizer_cov_trace_cmp4+0x1a/0x20
> [   48.860982]  ? ktime_get_coarse_real_ts64+0xbf/0xf0
> [   48.861370]  __x64_sys_setsockopt+0xc6/0x160
> [   48.861710]  ? syscall_trace_enter+0x14a/0x230
> [   48.862057]  x64_sys_call+0x6cf/0x20d0
> [   48.862350]  do_syscall_64+0x6d/0x140
> [   48.862639]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   48.863023] RIP: 0033:0x7f26cdc3ee5d
> [   48.863301] Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 4=
8 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <=
48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 93 af 1b 00 f7 d8 64 89 01 48
> [   48.864659] RSP: 002b:00007fff33f36278 EFLAGS: 00000213 ORIG_RAX: 0000=
000000000036
> [   48.865223] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f26c=
dc3ee5d
> "
>
> I hope you find it useful.

Thank you for the report. I think I see the issue and I commented on
the fix in the code below.

Only issue is that this is unlucky timing for me. I have a flight
tomorrow for a vacation where I think I may have internet access and
may not. I will try to follow up here, but in case I can't, what's the
urgency for this issue? Can this wait 2 weeks when I get back?

> > +     if (optlen % sizeof(struct dmabuf_token) ||
> > +         optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
> > +             return -EINVAL;
> > +
> > +     tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
> > +     if (!tokens)
> > +             return -ENOMEM;
> > +

There is an unrelated bug here. The first argument for kvmalloc_array
is the number of elements, I think, not the number of bytes. So this
should be:

num_tokens =3D optlen / sizeof(struct dmabuf_token);
tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
if (!tokens)
   return -ENOMEM;

> > +
> > +     if (copy_from_sockptr(tokens, optval, optlen)) {
> > +             kvfree(tokens);
> > +             return -EFAULT;
> > +     }
> > +
> > +     xa_lock_bh(&sk->sk_user_frags);
> > +     for (i =3D 0; i < num_tokens; i++) {
> > +             for (j =3D 0; j < tokens[i].token_count; j++) {

The bug should be here. tokens[i].token_count is a u32 provided by the
user. The user can specify U32_MAX here, which will make the loop
below spin for a very long time with the lock held, which should be
the cause of the soft lockup.

We should add a check that token_count is < MAX_DONTNEED_TOKENS or
something like that, above this line.

Please let me know of urgency. If this can't wait I'll try very hard
to repro the issue/fix while I'm out. Untested fix I'm going to try
out:

diff --git a/net/core/sock.c b/net/core/sock.c
index 083d438d8b6f..cb3d8b19de14 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1071,11 +1071,11 @@ sock_devmem_dontneed(struct sock *sk,
sockptr_t optval, unsigned int optlen)
            optlen > sizeof(*tokens) * MAX_DONTNEED_TOKENS)
                return -EINVAL;

-       tokens =3D kvmalloc_array(optlen, sizeof(*tokens), GFP_KERNEL);
+       num_tokens =3D optlen / sizeof(struct dmabuf_token);
+       tokens =3D kvmalloc_array(num_tokens, sizeof(*tokens), GFP_KERNEL);
        if (!tokens)
                return -ENOMEM;

-       num_tokens =3D optlen / sizeof(struct dmabuf_token);
        if (copy_from_sockptr(tokens, optval, optlen)) {
                kvfree(tokens);
                return -EFAULT;
@@ -1083,6 +1083,10 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t
optval, unsigned int optlen)

        xa_lock_bh(&sk->sk_user_frags);
        for (i =3D 0; i < num_tokens; i++) {
+
+               if (tokens[i].token_count > MAX_DONTNEED_TOKENS)
+                       continue;
+
                for (j =3D 0; j < tokens[i].token_count; j++) {
                        netmem_ref netmem =3D (__force netmem_ref)__xa_eras=
e(
                                &sk->sk_user_frags, tokens[i].token_start +=
 j);

--=20
Thanks,
Mina

