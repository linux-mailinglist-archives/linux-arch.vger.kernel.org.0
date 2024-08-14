Return-Path: <linux-arch+bounces-6195-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E963951DDB
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 160AD28651F
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 14:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEFB1B4C2F;
	Wed, 14 Aug 2024 14:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uj7JpQog"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A501B3F1E
	for <linux-arch@vger.kernel.org>; Wed, 14 Aug 2024 14:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723647368; cv=none; b=slVy8+3QrHvCQ3aHujefVZKScl2IuGH3J1CK31G0z9rjWNtAK2/zFJD90W1F5fUocHa7I9N0hLMo3wkz1DCSm+//JKUK25tAlB8s8ac0GErVdUMFRlMuIwSqvwPpTFOqIDkwDAnHsxqzdSlsVxYICHOXoNSbNSF9qQ+OPf6OovE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723647368; c=relaxed/simple;
	bh=tR8RzbqOolXZg8cJLIUMhkkkWhqNewrEo1ZX+xr0SVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Am7m84Kdq5v9iMAVZIArFgNl6ruqy4Gnfd7jJSjJ6BbnqwZUBekEnIN+ztPFgvUED2kLH1ZjTRu9c/oCeeudOnBIFqBKpoDMKWUJR+AIaVEl4pvlwZPdXLQ2JSr/L5+fbeMNiExb1PR47cvOFxTcY3SbWKbR3hbyoENqpf6/Crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uj7JpQog; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-70942ebcc29so4615985a34.0
        for <linux-arch@vger.kernel.org>; Wed, 14 Aug 2024 07:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723647364; x=1724252164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApWhKzlunlw9OulyCe3WVtwOx7m9YQFR6kgphgn0hHM=;
        b=uj7JpQogyJ0OQXhKYv2IbMfZ2YTiwSo4zcuyjtQWF/0GzdtRQiJ2jkQt0EcM4+ZzsA
         fOQYD6iJqbLNmdRHjB4Y/7zVuo4yVmMKrl5FeRa04/B1LmN52h+XtGQAHHb7Va+kX1uk
         C08ZlVAOH7Ejq3lMv3H+gaEckIUJCWDsLaVw/06PKt3VcmrpR6nHFn/TZVnLrp8sqneL
         u6hJqiTvBpVMQHRHqUusyh+gObrIjtKyoRszz8hGgbKbMhrfR7OIC6hyD52dEF164ogr
         ziCyGX5wCAAKkZa/R57UJBIiYTn8lyoWqaLM4CoObQ7UQB6FdZco57zYzVaVhT+/pQdQ
         wKQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723647364; x=1724252164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApWhKzlunlw9OulyCe3WVtwOx7m9YQFR6kgphgn0hHM=;
        b=onMGBY6IaEepRDsXRW+cg4Wqs17gZtpxqdWLAOfjBwp67CH4kGqCA2ejgPhNTqL6/c
         Q72K/amXjh8U8F/7SVJnefdw3dSd3tCeRnxo/tJA3iaKQ036TKFzCZ1mGu9E8T62OHji
         MzZwzoVvqTWZl/rKYSpfAxIOSpV66RbdB115OghNLT9bV1+vpvmEeEuJLzgvfnkOvSNz
         yTJK0WsFMYO+LWHq1J2IDqCs9buQWCGyFutUaEtq4VZOGhKuiqJ80WSfbKcus42JV5R5
         IG7ad5qD2+zRtl8/dT20cBZRp2oWfgCxNLAeJHEkk2IAQBp2aehj+vHELQE5n0sk90Jn
         V/xg==
X-Forwarded-Encrypted: i=1; AJvYcCW8kZKqqG2OnSw8QZpEH8hzpcaB1bTdOhALABwLJtRPJILEKb0Ua6HBM0oGK1SWKnjr8HEJhrLIpwZnVmUDd9DIdQWVRmrE+whYgQ==
X-Gm-Message-State: AOJu0YzNMvuKrqUGLtf7cwf2g2owXB/3fAfJr6w0P3LtxFwDASCc9PGH
	I64Ir8jcdW9B0kAT8ZoaVRc6/AmJ0HaoTaxIaHgtx55pU06Yvywq4x3Ng1AxHLbB6FRLjJJLBf0
	F0VFVEHjKFL/c9Mj9ZiNV9TqzsIHmQsVIlBMx
X-Google-Smtp-Source: AGHT+IH9ZAeOvcFpU0wz9rOmS3Zjvy3bWAzT1a2IrWWyXOegJsZPD7qSytaVr6toGHZ8oDdMhi5a1Ic9JEJSRxy3OYE=
X-Received: by 2002:a05:6359:4c83:b0:1ac:f5dc:5163 with SMTP id
 e5c5f4694b2df-1b1aad5b0a8mr340642555d.29.1723647364192; Wed, 14 Aug 2024
 07:56:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-7-almasrymina@google.com> <de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com>
In-Reply-To: <de7daf80-a2e4-4451-b666-2a67ccc3649e@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 14 Aug 2024 10:55:49 -0400
Message-ID: <CAHS8izPMC+XhXKbJOQ3ymizyKuARSOv_cO_xO+q1EG4zoy6Gig@mail.gmail.com>
Subject: Re: [PATCH net-next v19 06/13] memory-provider: dmabuf devmem memory provider
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 10:11=E2=80=AFAM Pavel Begunkov <asml.silence@gmail=
.com> wrote:
...
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 301f4250ca82..2f2a7f4dee4c 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -17,6 +17,7 @@
> >   #include <linux/genalloc.h>
> >   #include <linux/dma-buf.h>
> >   #include <net/devmem.h>
> > +#include <net/mp_dmabuf_devmem.h>
> >   #include <net/netdev_queues.h>
> >
> >   #include "page_pool_priv.h"
> > @@ -153,6 +154,10 @@ int net_devmem_bind_dmabuf_to_queue(struct net_dev=
ice *dev, u32 rxq_idx,
> >       if (err)
> >               goto err_xa_erase;
> >
> > +     err =3D page_pool_check_memory_provider(dev, rxq, binding);
>
> Frankly, I pretty much don't like it.
>
> 1. We do it after reconfiguring the queue just to fail and reconfigure
> it again.
>

I don't see an issue with that? Or is it just me?

> 2. It should be a part of the common path like netdev_rx_queue_restart(),
> not specific to devmem TCP.
>
> These two can be fixed by moving the check into
> netdev_rx_queue_restart() just after ->ndo_queue_mem_alloc, assuming
> that the callback where we init page pools.
>

The only reason is that the page_pool_check_memory_provider() needs to
know the memory provider to check for. Separating them keep
netdev_rx_queue_restart() usable for other future use cases that don't
expect a memory provider to be bound, but you are correct in that this
can be easily resolved by passing the binding to
netdev_rx_queue_restart() and doing the
page_pool_check_memory_providers() check inside of that function.

> 3. That implicit check gives me bad feeling, instead of just getting
> direct feedback from the driver, either it's a flag or an error
> returned, we have to try to figure what exactly the driver did, with
> a high chance this inference will fail us at some point.
>

This is where I get a bit confused. Jakub did mention that it is
desirable for core to verify that the driver did the right thing,
instead of trusting that a driver did the right thing without
verifying. Relying on a flag from the driver opens the door for the
driver to say "I support this" but actually not create the mp
page_pool. In my mind the explicit check is superior to getting
feedback from the driver.

Additionally this approach lets us detect support in core using 10
lines of code or so, rather than ask every driver that wants to
support mp to add boilerplate code to declare support (and run into
subtle bugs when this boilerplate is missing). There are minor pros
and cons to each approach; I don't see a showstopping reason to go
with one over the other.

> And page_pool_check_memory_provider() is not that straightforward,
> it doesn't walk through pools of a queue.

Right, we don't save the pp of a queue, only a netdev. The outer loop
checks all the pps of the netdev to find one with the correct binding,
and the inner loop checks that this binding is attached to the correct
queue.

> Not looking too deep,
> but it seems like the nested loop can be moved out with the same
> effect, so it first looks for a pool in the device and the follows
> with the bound_rxqs. And seems the bound_rxqs check would always turn
> true, you set the binding into the map in
> net_devmem_bind_dmabuf_to_queue() before the restart and it'll be there
> after restart for page_pool_check_memory_provider(). Maybe I missed
> something, but it's not super clear.
>
> 4. And the last thing Jakub mentioned is that we need to be prepared
> to expose a flag to the userspace for whether a queue supports
> netiov. Not really doable in a sane manner with such implicit
> post configuration checks.
>

I don't see a very strong reason to expose the flag to the userspace
now. userspace can try to bind dmabuf and get an EOPNOTSUPP if the
operation is not supported, right? In the future if passing the flag
to userspace becomes needed for some usecase, we do need feedback from
the driver, and it would be trivial to add similarly to what you
suggested.

> And that brings us back to the first approach I mentioned, where
> we have a flag in the queue structure, drivers set it, and
> netdev_rx_queue_restart() checks it before any callback. That's
> where the thread with Jakub stopped, and it reads like at least
> he's not against the idea.

Hmm, the netdev_rx_queue array is created in core, not by the driver,
does the driver set this flag during initialization? We could run into
subtle bugs with races if a code path checks for support after core
has allocated the netdev_rx_queue array but before the driver has had
a chance to declare support, right? Maybe a minor issue. Instead we
could add an ndo to the queue API that lets the driver tell us that it
could support binding on a given rx queue, and check that in
net_devmem_bind_dmabuf_to_queue() right before we do the bind?

But this is only if declaring support to userspace becomes needed for
some use case. At the moment I'm under the impression that verifying
in core that the driver did the right thing is preferred, and I'd like
to minimize the boilerplate the driver needs to implement if possible.

Additionally this series is big and blocks multiple interesting follow
up work; maybe going forward with an approach that works - and can
easily be iterated on later if we run into issues - could be wise. I
do not see an issue with adding a driver signal in the future (if
needed) and deprecating the core check (if needed), right?

--
Thanks,
Mina

