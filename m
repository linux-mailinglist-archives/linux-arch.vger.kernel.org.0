Return-Path: <linux-arch+bounces-7183-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E67B973C5E
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 17:39:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F11841F2548A
	for <lists+linux-arch@lfdr.de>; Tue, 10 Sep 2024 15:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6712D19F464;
	Tue, 10 Sep 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GrXvSgil"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918B719D09E
	for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 15:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725982740; cv=none; b=ULRHX6Ex+wSM9A5U2+b2wx9v1etiwAF2SnZD6J+0Xx0C43WWOAmLKXv5WgzYyZi5BLIxfu6PUQn9ehJWiWWBLRfGlpOjceQ7UM1NlXNdI8JwTC4dFkxMMnzWSJ7TUoV/rYQUa0NMyD7H+Jr3TXKWzLbD7nw1u1B1h2RXM9ocb2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725982740; c=relaxed/simple;
	bh=oCjdkvGBXYk951UuNZ8GUxFDU3TLEafF/eKU6VJhJjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XNAYtorGbCuPKxGrPy1N1qwJ9KwrWm47GYwApsZmRBXbLiFKBtJFetSzJlKLdyAYqasZ6+uzGCwYUgGJjohPv7xS47u15GyT1g7PVC1gV47vbPLF63SyaqRk/ltTHMHlMo6C6XMlx27nI4JxqLcB0R93GT9SBOASTOyy9MqEKAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GrXvSgil; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4582fa01090so300341cf.0
        for <linux-arch@vger.kernel.org>; Tue, 10 Sep 2024 08:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725982736; x=1726587536; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gszVQrHTml2s4rQX/N3KISfWtIKCjIZkEmtrFN+rLM=;
        b=GrXvSgilpWPDTzYZ9WABiQnJcvcxeBR4bm9wsuD4lVoyCFmn4tA8tyIqlbn3NDhtnn
         Fb+3yNQxZ9V5xDPLtYREJm0lw4h7K0Rb6SyRAXHhMNvDEZP2U1aSz2X28F6hzxZbfqHv
         icxm2c7yOJTBZ72I32Oc7hKkV6kVfNgUmgjNa94lEo1R0sGHmyrsGpCQdgbWdcirjeAB
         Psog1zEKxDmlyl1nf/Qmx7p5/lT15i6QKlnbX6Yk0Y4u1y0vmH5c60tEwsY3GV/f5e16
         AV+0L13zNQiReNL+oSFisUKmIYwvYFa4DTs73zRv2+f3St49KEhoPnaEMo1FVb0vovyC
         nAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725982736; x=1726587536;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gszVQrHTml2s4rQX/N3KISfWtIKCjIZkEmtrFN+rLM=;
        b=IzEWdC8Ns2yA+rkhWT5EeTv+3+4SRZbHzzewXpHvH73gSDUyjuyyZWoHuW49Itjo8e
         QqPKqTtlXQrYWN8YQKf3QLVQ8G7+WkfTZJMYhiZjC5+05XgUQVNo9hbrgfMFVqJRXKMP
         pZWyc+ZU5tD+asM9HZNv+0toSw70n2RaVc9t5keXJdvBqt2q+vwzwbCfXrrPuaWoTDgN
         BviaBlCP9+UuB5s/O9PNUmHZ/6bFJ+4VE9cC9var6sRIYgaLbvfevjg0GqYmwUweK77u
         2zJ13XHKqjCUnYfl1DtaZjXxoAtALLeKBehRQp5uVaEz61fqqj5ahzvhfOMVoJaYoGVU
         QMYg==
X-Forwarded-Encrypted: i=1; AJvYcCXslKPDl3y/zPUWiHYxJD4L63lef0bbV7rm9DsS8NyjhP+HBPp+w+K8CQYK6vm1sJvuYEiVuz/sYao6@vger.kernel.org
X-Gm-Message-State: AOJu0YyDd61Vss1KA2zaGdcfuGjJIQamvo/WkjXQUCz9/S3X+kpx1fJQ
	cyoA5UVAjEN1BT7h5b0H/Sgcusg05MDvE2aRkC968FNnNWu1rDGDVvB2OaXdFSRsXpxYXiWivHF
	d4VShDUSA/3aeaXd9Qyx0a2ip07JyGI35X5l8
X-Google-Smtp-Source: AGHT+IEK6weRhBb+6I+yqObyHVaZqmcs2wOCh/JwTg5EmvszzOI8s/itZSBxrrNFolb48wNjfmGjViIMiDzaN91ZR8I=
X-Received: by 2002:a05:622a:13ca:b0:447:e0e1:2a7b with SMTP id
 d75a77b69052e-4583f0063b0mr2792721cf.23.1725982736186; Tue, 10 Sep 2024
 08:38:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909054318.1809580-1-almasrymina@google.com> <20240910080237.2372cfa6@kernel.org>
In-Reply-To: <20240910080237.2372cfa6@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 10 Sep 2024 08:38:42 -0700
Message-ID: <CAHS8izP4EO3t=7-n2Ok5pgKe+JjJV+T3EH1PaTW=YU234kEpGw@mail.gmail.com>
Subject: Re: [PATCH net-next v25 00/13] Device Memory TCP
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
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
	Nikolay Aleksandrov <razor@blackwall.org>, Taehee Yoo <ap420073@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 8:02=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon,  9 Sep 2024 05:43:05 +0000 Mina Almasry wrote:
> > Device memory TCP (devmem TCP) is a proposal for transferring data to a=
nd/or
> > from device memory efficiently, without bouncing the data to a host mem=
ory
> > buffer.
>
> Mina, if you'd like to see this in v6.12 -- please fix the nits and
> repost ASAP.

Running my presubmits now and will repost in the next 2 hours or so.

--
Thanks,
Mina

