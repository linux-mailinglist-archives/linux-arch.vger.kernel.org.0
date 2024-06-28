Return-Path: <linux-arch+bounces-5194-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F069991BC47
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 12:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A67AA284AF3
	for <lists+linux-arch@lfdr.de>; Fri, 28 Jun 2024 10:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5419D155335;
	Fri, 28 Jun 2024 10:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NF0XEaJw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837101103;
	Fri, 28 Jun 2024 10:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719569436; cv=none; b=PqDxy7K5mAAjmMVF4z5i3rOB/g0ZxH4d4tV/JA0gkBrcsZhtjyABvRzAVL2UT3Hdm+JR0BAQ+J52Bh3TQXRHy/vLpzNM4mDFv1I0jqQE4Dbo26Y/FVZoYqbywxmu41FI977NyDUJr8ymWg+8HVUNsclThSa/3in5p3tTxBV8d8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719569436; c=relaxed/simple;
	bh=K94KMvBSXhAu/31lsvMQcNpt1QEBEngszk5FchDEdAc=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=YCrAZxJUUqHs6vpJTUz2hkkoHCr85KYHn3Syw8cRJnSIs77iKDh9ZZO2FIk8ZVlAQMhrC7j7ziyhiffU1+o98X1q0AZKBPcorODTgHWRqbBMqkY+8HlL2cwdjZHfkHrVyVdk73IKK4OCPWCehbqzI4kvZXNNrlD2nZUSLaHRr84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NF0XEaJw; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-52cdb0d8107so497269e87.1;
        Fri, 28 Jun 2024 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719569433; x=1720174233; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JoVOae80H1zl51jGISvif7zbZc8/4VB5Y/Zsc6sy8rw=;
        b=NF0XEaJwdNBW2CijSK+FTHzcdgGW5jiu15I0WTIo4DMWAb1LDlVL65PWuStIn8u79a
         Vg6BGYT9IRcKDIE/StfqWPehO7HpxAoSS4+rW8NkpqwuWcDUb8msZLCDfzjJt8kP82KT
         8lF6LbT1ku47IDcuLuWxRAEu89Jy0uFEnQKvxcKy9sv5Iu/AZl+k1ZE0e6cXt0WkCGNd
         ytj7E0zTQAVGs7VksqVwv1jVeH950/BmhXvaWbrteuFRuv6pOavaD/GXvAAQ6zBuDhtB
         KAAhCuoFpO/IwXF1FFf9InOovznqu2KJrvkQjGIsn1uCGFHI5fXoENtgNeY8NSPk8P5p
         yY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719569433; x=1720174233;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JoVOae80H1zl51jGISvif7zbZc8/4VB5Y/Zsc6sy8rw=;
        b=T3N4PKN3y3wv/fHBdMzq9V8wDPSQYBjnQhXfyM8jVy/swXmXpDmzAj7zfyklLAsYgo
         ZN9geXv06upcsepjYtwpVk0BlBV9zXte2yYyM09JyczuimR7MN999XuVXGoihdxNSo6T
         Y5HMlEWuQB2GJBcnnici5q368w5TVf5rkgpLeAlpmFjpkhcR2nw0j9k80uhPcjto2Lhj
         vBRI3d6yVo6t8ZDubmXnlRDUCA9XVeULUQ9+WvA5U7jYIUi1MgAJ2GYCq86qAhFHXfPs
         LsksqVxeHvDmgr+xNzIuvKudbPAHxnOUIcraJgny5PlPYzexYp7JojtcrgJB6MSdv6p2
         gMjA==
X-Forwarded-Encrypted: i=1; AJvYcCUpZkMAU5Qy8anWhV9QYpekgAu/Oagv+PFboR5RiELyZJcu9RAlrj1WAQZsW+EHxc8fGElYSqJ+kK4Pr3mbs+bEai5TTH0aqpdokC+qmfRvA3DVg6jP9nPEGAJXp8ZiH5pij40OUAASD7UmRzIn5uLdz1csjJedSkMal6UUUwvIa2NtftP/URAT/74wr9nNO+jQ3HZKFEGoypPfTadWs1vSxFjTOAwBe0d6DRMWjT8BO3+3Cczj3DfVpeh5XqqrEed4sezPz8A2kgpHB/W1IAe9D+ATpVQGipYll38K/cVewL8UlHoqIjmlsk9VXd7vHmnN0MshF9vu5PadDRsbpJI3BNd6l/0aYTRAQwhn94DLpFQ308YvgaBzB+c7vilAWRJBBHxCFMtJUErmFG0Fh/wwb4+n4Z3mHEuVoj9LAFSmxohDVa4RFylZrYIl35/Ot9fE7JX3avT5RhNOe6snTii9yMQLzZNv4qwFHK4oNw==
X-Gm-Message-State: AOJu0YyhVZ2+evcwbtHVjqXEvxtDfrES3nj8s7xQzyWaKI+bQu6rOUYI
	CxuQE61ET/AdRe2IqvbXg618tn7uQkc0kZ97awCTiBBMWQSVmrHq
X-Google-Smtp-Source: AGHT+IFKCvR38XvVqm5Um9a+klNoommoEfbRwaz/Xc5lSqRtlPbKvQJbMiSu5WsIA9vNHRnXI96lzA==
X-Received: by 2002:a19:f012:0:b0:52c:8024:1db with SMTP id 2adb3069b0e04-52cdf82671amr9494131e87.63.1719569432448;
        Fri, 28 Jun 2024 03:10:32 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:49ff:2a2d:712c:9944])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256af5b66csm27439095e9.18.2024.06.28.03.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 03:10:31 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-alpha@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  bpf@vger.kernel.org,
  linux-kselftest@vger.kernel.org,  linux-media@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan
 Corbet <corbet@lwn.net>,  Richard Henderson
 <richard.henderson@linaro.org>,  Ivan Kokshaysky
 <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,  Thomas
 Bogendoerfer <tsbogend@alpha.franken.de>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
  Andreas Larsson <andreas@gaisler.com>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
  Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Arnd Bergmann <arnd@arndb.de>,  Alexei
 Starovoitov <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Andrii Nakryiko <andrii@kernel.org>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,  Song Liu
 <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  John
 Fastabend <john.fastabend@gmail.com>,  KP Singh <kpsingh@kernel.org>,
  Stanislav Fomichev <sdf@fomichev.me>,  Hao Luo <haoluo@google.com>,  Jiri
 Olsa <jolsa@kernel.org>,  Steffen Klassert <steffen.klassert@secunet.com>,
  Herbert Xu <herbert@gondor.apana.org.au>,  David Ahern
 <dsahern@kernel.org>,  Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
  Shuah Khan <shuah@kernel.org>,  Sumit Semwal <sumit.semwal@linaro.org>,
  =?utf-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,  Bagas
 Sanjaya
 <bagasdotme@gmail.com>,  Christoph Hellwig <hch@infradead.org>,  Nikolay
 Aleksandrov <razor@blackwall.org>,  Pavel Begunkov
 <asml.silence@gmail.com>,  David Wei <dw@davidwei.uk>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Yunsheng Lin <linyunsheng@huawei.com>,  Shailend Chand
 <shailend@google.com>,  Harshitha Ramamurthy <hramamurthy@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Jeroen de Borst
 <jeroendb@google.com>,  Praveen Kaligineedi <pkaligineedi@google.com>,
  Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v15 02/14] net: netdev netlink api to bind
 dma-buf to a net device
In-Reply-To: <20240628003253.1694510-3-almasrymina@google.com> (Mina Almasry's
	message of "Fri, 28 Jun 2024 00:32:39 +0000")
Date: Fri, 28 Jun 2024 11:04:27 +0100
Message-ID: <m27ce9cris.fsf@gmail.com>
References: <20240628003253.1694510-1-almasrymina@google.com>
	<20240628003253.1694510-3-almasrymina@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:
> +  -
> +    name: bind-dmabuf
> +    attributes:
> +      -
> +        name: ifindex
> +        doc: netdev ifindex to bind the dma-buf to.

Minor nit:

The series uses a mix of dmabuf and dma-buf but the doc additions
(devmem.rst) consistently uses dmabuf. I think it would be helpful to be
consistent here and say 'devmem dmabuf' in the docstring to highlight
whos dmabuf it is and keep the generated netdev docs in alignment.

> +        type: u32
> +        checks:
> +          min: 1
> +      -
> +        name: queues
> +        doc: receive queues to bind the dma-buf to.

And here.

> +        type: nest
> +        nested-attributes: queue-dmabuf
> +        multi-attr: true
> +      -
> +        name: dmabuf-fd
> +        doc: dmabuf file descriptor to bind.
> +        type: u32
> +      -
> +        name: dmabuf-id
> +        doc: id of the dmabuf binding
> +        type: u32
> +        checks:
> +          min: 1
> +
>  
>    -
>      name: qstats
> @@ -579,6 +618,20 @@ operations:
>            attributes:
>              - ifindex
>          reply: *queue-get-op
> +    -
> +      name: bind-rx
> +      doc: Bind dmabuf to netdev

And here.

> +      attribute-set: bind-dmabuf
> +      flags: [ admin-perm ]
> +      do:
> +        request:
> +          attributes:
> +            - ifindex
> +            - dmabuf-fd
> +            - queues
> +        reply:
> +          attributes:
> +            - dmabuf-id

