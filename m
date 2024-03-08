Return-Path: <linux-arch+bounces-2897-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B66E875C44
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 03:09:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EA4C1C214C8
	for <lists+linux-arch@lfdr.de>; Fri,  8 Mar 2024 02:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46F9724B34;
	Fri,  8 Mar 2024 02:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Vz8QSX83"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E925A22F02
	for <linux-arch@vger.kernel.org>; Fri,  8 Mar 2024 02:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709863723; cv=none; b=XXJUBGbXustVOJ75h/4BxS2h3UHloHwNAFee8qyLzG2bTq2tjZYfrUrHGjhhtNXkzDtkX4KmeHIHJ1qFNU5tcZfiz89VOr29ATSRucoGNcWrln7XZK26KeEg42nbNaeWvP4R/gisJ2VWhH9JPucEHILdjFQCWNr2SFnWs8d2N8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709863723; c=relaxed/simple;
	bh=2oAucL9FmKXjOeeokVf3zjH8TEdrD9innbGK83JfkzI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DK/mXB35D+zjai31WZJIW6UGVwlacv8pf7McHTyMuJz3QKKgur9WgUXU0EHoAPGvAlrvVLgs6PshEWMRf7wzeR0E6tUrpITWkXeKYNVr02Yc0PQpsN9KH45FSKESDs/1CwyvxMTVjGwuokHpANeV1eB0wj6lIBbGL6l4+IF/B8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Vz8QSX83; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a449c5411e1so208059866b.1
        for <linux-arch@vger.kernel.org>; Thu, 07 Mar 2024 18:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709863717; x=1710468517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M5QPfVVlznHCy9800rrfO6KR+EEw66k04MBVvznezAw=;
        b=Vz8QSX83467DPy9/uYGiv6OK9FB4nRsUecP/Zaadz0/VC432HtZhHH1FcQH3zTYFYY
         7HjBEsKjWP8C0mg2eKq4cmIuEljNRPYJhn2LT6DQvErrBeYQsOCzdZaBO+DBgHF5hTXb
         lkqQ/7YrnMPjWk+t44qevtx5QGPq+o+D5ea7IS4ZfGhJ1RQcfuhwCs8yDY54JrC9qXrq
         S1LJ1E7W5e1ltSo6rm+C4uBPWNj3v2cqCFQiMuYEvc+3Iz81BN3MJIHW16//ytI7YNrM
         ooLn48otvXdUIyX/O4w6xN4Fu1wkPj9+2ZvrMTBW7Vt8aOVXpvzkXcYN+ycpiqX2CEGY
         xZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709863717; x=1710468517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M5QPfVVlznHCy9800rrfO6KR+EEw66k04MBVvznezAw=;
        b=v4mI/seqSL5kHYSfS2Iy8rqhqakpZwsQclXrArecWmOfED3Eh+1wU9heLhQDrQJgZD
         Y/IBcWkl3vGDee95ve8dVvL0IdRy4WumOddnNQqwkwFA0c7EXbE5gcgqJ3WvS2JibJE3
         wektILo4BKbiCkSzUt5IFqgV9MVcxCDBdw+5ISgEEWR8GTrpAmdwLe8SRb52ffENL7xU
         WWIFTBqBo5vuHGp2YSvsT192fWndbjOhoH9pQUSOAyCOxu2CtHPpxMn7KPfmWWdZhvHq
         9xYPcxQHZjIE53/iHnkwz5xRMoEdYElYAFjnuZRSuRAO25hVW2JqrroT+JMKTYSJJBzS
         fbvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRM0nKIAI5b593KUZTMjIljYCisVo8PtrK9VUcAfkFb5Q9jkN6E0Bdc2VJYtVPmfnqcVA5bb4U8vMxbKcPgxud0xzWAbNbh7TqgA==
X-Gm-Message-State: AOJu0Yzn1xanwuaDPhm6KbQorwwzJHdfErInFz4Piyikg6JqEHcVvvF4
	yyIHV9rHrWoZqzFf0/VP/ndhuyOAN5E+9szXMaCpdIzDNDQAFxB9LUwE8sSXzsz94EcU0wB5WdQ
	am5tOi0Xx6Sif9bdmEFfL0MGj+F1ozWYFXfgi
X-Google-Smtp-Source: AGHT+IEumbOv6N2RdvxqNHnmUGQyPJoik+UnzOHCm5V6zf8kG5cWaKe9qZLk7VBIdBkDMUerOetVJNL7YjESeOQCAoM=
X-Received: by 2002:a17:906:b055:b0:a45:ba06:e501 with SMTP id
 bj21-20020a170906b05500b00a45ba06e501mr4646563ejb.57.1709863716984; Thu, 07
 Mar 2024 18:08:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305020153.2787423-1-almasrymina@google.com>
 <20240305020153.2787423-2-almasrymina@google.com> <20240307173039.00e6fbb7@kernel.org>
In-Reply-To: <20240307173039.00e6fbb7@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 7 Mar 2024 18:08:24 -0800
Message-ID: <CAHS8izPyxn2LsOsxL98WAHse21tq3i9MCp_Xn8AA8sx5iettNQ@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v6 01/15] queue_api: define queue api
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 7, 2024 at 5:30=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Mon,  4 Mar 2024 18:01:36 -0800 Mina Almasry wrote:
> > + * void *(*ndo_queue_mem_alloc)(struct net_device *dev, int idx);
> > + *   Allocate memory for an RX queue. The memory returned in the form =
of
> > + *   a void * can be passed to ndo_queue_mem_free() for freeing or to
> > + *   ndo_queue_start to create an RX queue with this memory.
> > + *
> > + * void      (*ndo_queue_mem_free)(struct net_device *dev, void *);
> > + *   Free memory from an RX queue.
> > + *
> > + * int (*ndo_queue_start)(struct net_device *dev, int idx, void *);
> > + *   Start an RX queue at the specified index.
> > + *
> > + * int (*ndo_queue_stop)(struct net_device *dev, int idx, void **);
> > + *   Stop the RX queue at the specified index.
> >   */
> >  struct net_device_ops {
> >       int                     (*ndo_init)(struct net_device *dev);
> > @@ -1679,6 +1693,16 @@ struct net_device_ops {
> >       int                     (*ndo_hwtstamp_set)(struct net_device *de=
v,
> >                                                   struct kernel_hwtstam=
p_config *kernel_config,
> >                                                   struct netlink_ext_ac=
k *extack);
> > +     void *                  (*ndo_queue_mem_alloc)(struct net_device =
*dev,
> > +                                                    int idx);
> > +     void                    (*ndo_queue_mem_free)(struct net_device *=
dev,
> > +                                                   void *queue_mem);
> > +     int                     (*ndo_queue_start)(struct net_device *dev=
,
> > +                                                int idx,
> > +                                                void *queue_mem);
> > +     int                     (*ndo_queue_stop)(struct net_device *dev,
> > +                                               int idx,
> > +                                               void **out_queue_mem);
>
> The queue configuration object was quite an integral part of the design,
> I'm slightly worried that it's not here :)

That was a bit of a simplification I'm making since we just want to
restart the queue. I thought it was OK to define some minimal version
here and extend it later with configuration? Because in this context
all we really need is to restart the queue, yes?

If extending with some configuration is a must please let me know what
configuration struct you're envisioning. Were you envisioning a stub?
Or some real configuration struct that we just don't use at the
moment? Or one that we use for this use case somehow?

> Also we may want to rename
> the about-to-be-merged ops from netdev_stat_ops and netdev_queue_ops,
> and add these there?
>
> https://lore.kernel.org/all/20240306195509.1502746-2-kuba@kernel.org/
>

Yeah, that sounds reasonable! Thanks! We could also keep the
netdev_stat_ops and add new netdev_queue_ops alongside them if you
prefer.

> Very excited to hear that you made progress on this and ported GVE over!

Actually, we're still discussing but it looks like my GVE queue API
implementation I proposed earlier may be a no-go. Likely someone from
the GVE team will follow up here with this piece, probably in a
separate series.

For now I'm carrying my POC for the GVE implementation out of tree
with the rest of the driver changes:

https://github.com/mina/linux/commit/501b734c80186545281e9edb1bf313f5a2d8cb=
ee

--=20
Thanks,
Mina

