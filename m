Return-Path: <linux-arch+bounces-4030-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E29438B43C8
	for <lists+linux-arch@lfdr.de>; Sat, 27 Apr 2024 04:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD340B22910
	for <lists+linux-arch@lfdr.de>; Sat, 27 Apr 2024 02:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 781DE3B79F;
	Sat, 27 Apr 2024 02:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRu4S3Xu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C726383BF
	for <linux-arch@vger.kernel.org>; Sat, 27 Apr 2024 02:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714183885; cv=none; b=MPZONz0iuZn0RQUi6L0zMbG7ebDDxPa9Q6gAK4tGVmMKqwOwH6ujH/CLe/XBytQnPRNV7lQ2drdhUpebFzfQjxrVamrGIfLe6lviZbBADncPTmMSjVwiWDY5SpWwpLQC0TJJ9ybn42Zy3508X4th2J37EceNWxbPkfNgnlw6vFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714183885; c=relaxed/simple;
	bh=3TH1qKN/8kDOE9KfhYRZV82BLgZZskB3YkO2+4vu+tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dvpFEJh17V7Yqn7wJu2//AI8SS7c/ln1Ao7yoeF69QTSnOkA2DSf/ihFguedLEAWbqJb8wcOH9YBXg+R3HxE7QaWW1YrfP2mHW+3o6fZzn3l8XwMjj+e9Ofh9Ei/imxbR02XFlqWY7rBSmILMKFn8pWqBs+due2K/cj/IV//tFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRu4S3Xu; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a58e2740cd7so59043366b.1
        for <linux-arch@vger.kernel.org>; Fri, 26 Apr 2024 19:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714183880; x=1714788680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VCqXmA+0tJPmuPol3Ypy0jPmfZ3hkXnnk0DE4uLAUwU=;
        b=mRu4S3XuUIqgZ4Zuu0XgismEQ5/XUBilPfFw+Xm1y6jIuBkNYDGqtJpVPfr3+pUbZf
         sAyOLb5LdfBvQbmhLVih+PhEODGod32DbRItT4xo6P4xZydC8tce2YXd8+WGUheKnvMl
         0gsDcMKy6EBMpWyVbsMo1ZYgFLSjchUULUluFbRjoQMZtHnCgGtdyMdP/eTFH75BbT8K
         FVX5+bOMpdzkiS5xZzDrCWaSldC5RZPNVAUarByQRaAUL3UsGpPK9BwIUf856PWynKMz
         yJGJKrx4/S1+RH9spj8VX4cHz3UyMAPh/HkI2nBx0BpnQc3OmMiXbW/kS0kmdQqOktCD
         Fhzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714183880; x=1714788680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VCqXmA+0tJPmuPol3Ypy0jPmfZ3hkXnnk0DE4uLAUwU=;
        b=wPox0v9UwteHzYSaUVXyp/vGtOOttA0usns70BEUdPmJlwjMX0GFcnmXAW6fJF5jjn
         MVSi0yw5aU5/bSY7XH1eB/5qgkdYrWOJsa05bcDhsft+uUyJogbsXa3tFoMLfnJsuake
         q0X9iOvhN7hQjZWm0zTAyIhN+W9y4fwhInFgEzM72NRCdv1cpkdpUgHw+2/iV82pbCdl
         EpY4q49WY0iBtecEbQ/fZekLWKr+wh5b+T6vQFfBPGTjmyb4OH47+jnrblseIpp1T9pM
         quUmsd9Ug2YtpQYJLw3Ir9TLkWYrvf1u+E25kOJ4SezUSuWiTWmFh79yGcb7fG7sCMw3
         q5tg==
X-Forwarded-Encrypted: i=1; AJvYcCXr+uYmUpf42MrY5Mn5qkXVxE1dw2yWq1RLj17jixf59y44aIuRZI2Wt+ZLCagMGCaTOZpnm/EqdCEY6AAASsCjveSKvv9adbnJsA==
X-Gm-Message-State: AOJu0YyeD2pdJhoeAzq2KQ4qSjtYHmnSM2u+kDuhl8DDD2892A2MRJxe
	L3RjcYMLwyDvcLN0pc4XfhH2EJB/hG67WijPr8bjQ3qJ/z4ofOvZuWDXhqRdPJZl3zDvZH3f1NC
	1fLgS1BxTOe7UcS4adhUQ460hmXQRPUoR8bpM
X-Google-Smtp-Source: AGHT+IGYpMq0S7NMYmgbheltdqICqswpFYbRt1nWr9f34ViEhM+DD9iOxk080j42Jd8vuPQgs8NIkJRSPoJ58AydrBw=
X-Received: by 2002:a17:907:a49:b0:a58:c550:a102 with SMTP id
 be9-20020a1709070a4900b00a58c550a102mr4510853ejc.29.1714183880204; Fri, 26
 Apr 2024 19:11:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-8-almasrymina@google.com> <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
In-Reply-To: <8357256a-f0e9-4640-8fec-23341fc607db@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 26 Apr 2024 19:11:07 -0700
Message-ID: <CAHS8izPeYryoLdCAQdGQU-wn7YVdtuofVKNvRFjFjhqTDsT7zA@mail.gmail.com>
Subject: Re: [RFC PATCH net-next v8 07/14] page_pool: devmem support
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
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
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Amritha Nambiar <amritha.nambiar@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Christian Brauner <brauner@kernel.org>, Simon Horman <horms@kernel.org>, 
	David Howells <dhowells@redhat.com>, Florian Westphal <fw@strlen.de>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Aleksander Lobakin <aleksander.lobakin@intel.com>, Michael Lass <bevan@bi-co.net>, 
	Jiri Pirko <jiri@resnulli.us>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Richard Gobert <richardbgobert@gmail.com>, 
	Sridhar Samudrala <sridhar.samudrala@intel.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Johannes Berg <johannes.berg@intel.com>, Abel Wu <wuyun.abel@bytedance.com>, 
	Breno Leitao <leitao@debian.org>, Pavel Begunkov <asml.silence@gmail.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, linux-mm@kvack.org, 
	Matthew Wilcox <willy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 26, 2024 at 5:18=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-04-02 5:20 pm, Mina Almasry wrote:
> > @@ -69,20 +106,26 @@ net_iov_binding(const struct net_iov *niov)
> >   */
> >  typedef unsigned long __bitwise netmem_ref;
> >
> > +static inline bool netmem_is_net_iov(const netmem_ref netmem)
> > +{
> > +#if defined(CONFIG_PAGE_POOL) && defined(CONFIG_DMA_SHARED_BUFFER)
>
> I am guessing you added this to try and speed up the fast path? It's
> overly restrictive for us since we do not need dmabuf necessarily. I
> spent a bit too much time wondering why things aren't working only to
> find this :(

My apologies, I'll try to put the changelog somewhere prominent, or
notify you when I do something that I think breaks you.

Yes, this is a by-product of a discussion with regards to the
page_pool benchmark regressions due to adding devmem. There is some
background on why this was added and the impact on the
bench_page_pool_simple tests in the cover letter.

For you, I imagine you want to change this to something like:

#if defined(CONFIG_PAGE_POOL)
#if defined(CONFIG_DMA_SHARED_BUFFER) || defined(CONFIG_IOURING)

or something like that, right? Not sure if this is something I should
do here or if something more appropriate to be in the patches you
apply on top.

I additionally think you may also need to run the
page_pool_benchmark_simple tests like I do in the cover letter to see
if you're affecting those.

--
Thanks,
Mina

