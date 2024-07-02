Return-Path: <linux-arch+bounces-5229-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AAD89924722
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 20:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0ABCDB21225
	for <lists+linux-arch@lfdr.de>; Tue,  2 Jul 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5072816631A;
	Tue,  2 Jul 2024 18:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OId6xSvb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556611BE864
	for <linux-arch@vger.kernel.org>; Tue,  2 Jul 2024 18:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719944111; cv=none; b=oo8OLfd6xwGcVB6ERrZIOi75ITYszntEWxNAW4HmhbeITWeyUmqC/leADEM0di6Nl5ayBYPsxiCLZEHf0Stri6LH9qebjd08Ei95p14uBVliRyJtc2/x90SGSOLvZCoIGoOAGMpF9uqWIAmacRcVf4ybIVS/ZkR+RYMTROfQ2h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719944111; c=relaxed/simple;
	bh=0CMjZNAv1nBlCPOqB5DYQ1PD8oGveRJ0LZf9zKKTpi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iweEl0n5THdC0ao1oJOVFaq2WeRi6X1coGnJts8WGDaO52dJ8rcLfcvSKX2w26BGnwvc4fhIFR6pGQSt/yaIfQCEi/pxICNQhxKZBLB1vRWDoVfw7VQCf0cB87Dk/Sduo7tCoPJPauWUEA+h0H0/Zk/RUdmDp6ZQlmSqX5nHUhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OId6xSvb; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6b5d6ba7c90so4804376d6.1
        for <linux-arch@vger.kernel.org>; Tue, 02 Jul 2024 11:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719944108; x=1720548908; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jfhmwJ2ZaitPnbChce0yHI1r7AowuVw/8E/XjQzADk=;
        b=OId6xSvbiTDYJSJaSbC2v23KBA2j3vhMYwcnrnwrrQTl+w4PNtJbVmtlIDJzQs8bD/
         +YhisCsjMkO06aSHPkRv+ntZmvGwNxCg7d+K5/tPDnBSYy9CZ0AwBmVOB7UTgHoH3Kns
         pZ1kgMl8RYFenVTQFIiMZUrugonxeJmmHXfd/iZRsv0XhVhqd4EX2RHEYVGaFqd7rzHv
         mnwjftoL0GtZn5x3JKsl4DSC7OZjKMDKqScnpylJr+j+tVDEf8Ooa1k57KhcF+IvL+d7
         kAtITI7ekJHdUIsNkK9WL2K90fUdFMpnJ3bCkYA792EsYO3k765cUnwqr5odbYKrD05n
         bcVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719944108; x=1720548908;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jfhmwJ2ZaitPnbChce0yHI1r7AowuVw/8E/XjQzADk=;
        b=v3gTYCa4luob3PEloKwLn0Imi/PZjOgqQzZvBUe3mrqaSt5BxzSzCgbultd5SE8YLI
         2R/A4FtUPYeuDxRFL563SpJde74BH+Ii/T97WU4M5/hcggWIdkdTSvXPLCKnG5ioApo8
         OzOjUGmdCZYxg+gJKcguPo0X4WpQAFotPymIhFGwYtE/0Kkey+8+7G9UXOvK18OHZywl
         /P9kpsl4UppTuMQoZoj50g/CsCfKc8gCPrJmJyrrYEtzPkKJklcGvAZJDa/vDoPSbd2l
         ZDjWHNm4CtTtPLECQ//I+Bx8okSC8k6YfM91j6zjCH9pbN2MclKOP9vOMDTsv+VxAbBF
         zUmg==
X-Forwarded-Encrypted: i=1; AJvYcCU/jq/xVeNmrzlDbxuvKWxZMsKMy36+Wt/kEsQc0qLKn+PkxKdjsR+zc5ZsbQ8lz3IlwKRSRu5BfE48MWhwJJY6+mTa+QH8vLRYQQ==
X-Gm-Message-State: AOJu0YzMeiLogZ6gdN4ViykbXvj/R1J02d95JjXmt6lic8fKycbY2CEp
	GNMd0K6B+FoOHTMg6Jv3ag+sD7XtpWuEkMhA70qDFcn4Q0j+2+1kVpaowPHndJWK57pZojuIFWS
	CfM52vN+bz89N+1X7guIsvBgYSypWPdjmK7Wx
X-Google-Smtp-Source: AGHT+IFmyhMURbw09NuTqgYr3jOM6q8xc9WTxYBf4c7zqxp++C39G8nCnNJajyD2MlYoocDGcyD9JLOGWT3xUoIcMjk=
X-Received: by 2002:a05:6214:1d2f:b0:6b5:a4f6:514 with SMTP id
 6a1803df08f44-6b5b70caff8mr117075946d6.35.1719944108107; Tue, 02 Jul 2024
 11:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240628003253.1694510-1-almasrymina@google.com>
 <20240628003253.1694510-11-almasrymina@google.com> <35691b55-436c-4c52-b241-f0c5326227cb@app.fastmail.com>
In-Reply-To: <35691b55-436c-4c52-b241-f0c5326227cb@app.fastmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 2 Jul 2024 11:14:53 -0700
Message-ID: <CAHS8izN+wiY8rNDhK7XdF-9L=PdHGMSj7uHKkyCDsW8_6M76SQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 10/14] tcp: RX path for devmem TCP
To: Arnd Bergmann <arnd@arndb.de>
Cc: Netdev <netdev@vger.kernel.org>, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Linux-Arch <linux-arch@vger.kernel.org>, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, shuah <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 2, 2024 at 8:25=E2=80=AFAM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Jun 28, 2024, at 02:32, Mina Almasry wrote:
> > --- a/arch/alpha/include/uapi/asm/socket.h
> > +++ b/arch/alpha/include/uapi/asm/socket.h
> > @@ -140,6 +140,11 @@
> >  #define SO_PASSPIDFD         76
> >  #define SO_PEERPIDFD         77
> >
> > +#define SO_DEVMEM_LINEAR     78
> > +#define SCM_DEVMEM_LINEAR    SO_DEVMEM_LINEAR
> > +#define SO_DEVMEM_DMABUF     79
> > +#define SCM_DEVMEM_DMABUF    SO_DEVMEM_DMABUF
>
> Something is still wrong with the number assignment:
>
> > --- a/arch/mips/include/uapi/asm/socket.h
> > +++ b/arch/mips/include/uapi/asm/socket.h
> > @@ -151,6 +151,11 @@
> >  #define SO_PASSPIDFD         76
> >  #define SO_PEERPIDFD         77
> >
> > +#define SO_DEVMEM_LINEAR     78
> > +#define SCM_DEVMEM_LINEAR    SO_DEVMEM_LINEAR
> > +#define SO_DEVMEM_DMABUF     79
> > +#define SCM_DEVMEM_DMABUF    SO_DEVMEM_DMABUF
> > +
> >  #if !defined(__KERNEL__)
> >
> >  #if __BITS_PER_LONG =3D=3D 64
>
> so alpha and mips use the same numbering system as
> the generic version for existing numbers
>
> > diff --git a/arch/parisc/include/uapi/asm/socket.h
> > b/arch/parisc/include/uapi/asm/socket.h
> > index be264c2b1a117..2b817efd45444 100644
> > --- a/arch/parisc/include/uapi/asm/socket.h
> > +++ b/arch/parisc/include/uapi/asm/socket.h
> > @@ -132,6 +132,11 @@
> >  #define SO_PASSPIDFD         0x404A
> >  #define SO_PEERPIDFD         0x404B
> >
> > +#define SO_DEVMEM_LINEAR     78
> > +#define SCM_DEVMEM_LINEAR    SO_DEVMEM_LINEAR
> > +#define SO_DEVMEM_DMABUF     79
> > +#define SCM_DEVMEM_DMABUF    SO_DEVMEM_DMABUF
>
> parisc uses a different number, but you start using the
> generic version here. This is probably fine but needs
> a comment.
>
> > index 8ce8a39a1e5f0..25a2f5255f523 100644
> > --- a/include/uapi/asm-generic/socket.h
> > +++ b/include/uapi/asm-generic/socket.h
> > @@ -135,6 +135,11 @@
> >  #define SO_PASSPIDFD         76
> >  #define SO_PEERPIDFD         77
> >
> > +#define SO_DEVMEM_LINEAR     98
> > +#define SCM_DEVMEM_LINEAR    SO_DEVMEM_LINEAR
> > +#define SO_DEVMEM_DMABUF     99
> > +#define SCM_DEVMEM_DMABUF    SO_DEVMEM_DMABUF
>
> These on the other hand look like a typo: did you
> mean number 78 and 79 instead of 98 and 99?
>

Ooops, I think this is a typo or error indeed. I will fix.

> Alternatively, you could continue with number 87,
> which is the next unused number on sparc, and have
> the same numbers on all architectures?
>

I don't know enough about the tradeoffs of either approach to be
honest, so I'll do what you prefer. I think I'll just fix the ones in
asm-generic/socket.h since that is what we aligned on from previous
iterations I believe, unless you tell me to do differently.

--=20
Thanks,
Mina

