Return-Path: <linux-arch+bounces-5346-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 771B492CFA4
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 12:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23CEB1F256E2
	for <lists+linux-arch@lfdr.de>; Wed, 10 Jul 2024 10:48:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E2201990D7;
	Wed, 10 Jul 2024 10:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlBuPgO9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2CC198E9C;
	Wed, 10 Jul 2024 10:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720607841; cv=none; b=Hv0HxayG7aFN4ZTjhLyD65pBBQ2KCtiTRzi33FH2Z6UfPANrnNz8rXcHOSDX1tPraBAzq11oUOuyqWpl6Bn2ETUzYjYp5h17tbmskVH47H8skaW2xlfHNVApz+Dmt4wltV9G8PSRtDMO25kt+KxX65gBpPEFItn4i8XMo7yVvQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720607841; c=relaxed/simple;
	bh=vldLU5ousstfmDh5bnJGfW4ITCUolQrrvfqTIfAcNhk=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-Version:Content-Type; b=DguMVwVHLBvyAzKVzOgLvUPmkuu0NWP+GC4I4NNbUN/a1wDJnX13pZwNnMWr5Ia6CsXY5vLSTh2O3xn+sydmqxVMtL9jKd902xJvgFttwfBSP/AHnKY2QoEARi4M1xnFgkUox1VAJwa6yaOpoo0wYrp+eqyZ9jgoiU8EFWLC6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KlBuPgO9; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-367a464e200so3285421f8f.2;
        Wed, 10 Jul 2024 03:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720607839; x=1721212639; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vldLU5ousstfmDh5bnJGfW4ITCUolQrrvfqTIfAcNhk=;
        b=KlBuPgO9Ni7hnunhFgMgIA5zfzNEFeChtT6L92zZsk7NVi+a6DXH00NltdsV+1JGOF
         +wAfiLNBKARiC0gp98zW5QQDz95rPNscpaAt3Ipiqmwbr2fkU81JfkQfGP2BkcNfnYeU
         Nas2o6m4bm6zPKP6tN576VMfVIJuw6nm4wAx+jMsLlBnFiH5D/XaDIxA/MFZ/8n/4T2F
         xpoen2BuFzDjXmPUoH1b+P80wDBbDmvacCfY/Hi7iKHAbQH5ihK+DnAVzePfymUVBIbc
         ZMaijunVuxG5cdCeypcchBzA/FfNxJyygx9oVpy3YIsglSKNlkqaY/s9AWLvn8sYXElF
         HN+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720607839; x=1721212639;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vldLU5ousstfmDh5bnJGfW4ITCUolQrrvfqTIfAcNhk=;
        b=GFWGgB5rUZhPpPqKNjcrShUl6dkusNTKfT4NxyeH1BaXyZ5KGfH/l3V6hWI3pW3xPL
         uENsQQRkh4+D841Tq+0y8w4ovQZHfDWjD8KizgFtoInGrDN5mXTCZPidq9ZlmYdWhRZj
         /8tM6mAu25g/qSFYSjuDFEWtjsn5Hs8AMNw4H8UitnqmdvOBqUdzYOsMtAaDLMYc5VqA
         KuTQ551JTUaOX/21byPMWJUdNBrvtHLPiWlK/b4QZKJMxWXFqLKDZn4M13n6KnHFYm4J
         Xu0o8PLprI/GjpN/FHFUTjv35ZuRS8rKQVcGh3/P9o7hZgxlQU8vIx+gOxDeW4HxfwXC
         A7aA==
X-Forwarded-Encrypted: i=1; AJvYcCV9s9+3NHl1H6i6sTDQswpWtmEGhfyloLCMsEa3vcdubtI6OsuCRM+GXD1GGwqyRghYrpcfBwyDq157YoF3nvise9L1ULkQq5/vuy32Ne7lamUIk+vV7LESX7UFIKBSfeJJuErUWIWM7kukr8yCOAdmdTOJUQGkpZzfFC86sEQWsYhWZSA3k/0J7IK7/jIvMuB8GwlZT5BNVfEeydoUsFyITUVn34KbInZ7kKZxmJ9oeIVKT6B9V6PJvEBLwIuwWY3yxAkd1YIjeBUc7WaroSxDYgGXAaIJqcwboE5mW379ni0EOdvG1BiC+Wg5wZ291Z0tU7B55KLO5uSUc/LFjGEbWqjp7akx9Q0v4rbl1l9dqZAlrRf27U8cOKU/a4jC+5N4QQr6xqSPHV1tflYpCLPlbffSMyYIYxoze3wpmHMrskLB778fmQPefwJIGIxKpqkaCrVYE+vX5Opk4ByHne8rx1/FIcPi7em575stxA==
X-Gm-Message-State: AOJu0YzMd7Gs6UtSeFhGnZjYj4qXsihrnPKo4fpw94lolZiRv9Anvbih
	O8eMTpXtPqE5t7Hh03t6bwHzDmUINeLbZbIquG4NnbB2AM9/IEJw
X-Google-Smtp-Source: AGHT+IHfVxi0Lmy20qi3zZkkAs93779qbLSUYFgab3guGNLSJuv1zXb2yWVvs5PzjNax6/VrOLGUkw==
X-Received: by 2002:a05:6000:e90:b0:367:9748:ee7f with SMTP id ffacd0b85a97d-367cead931emr3298090f8f.65.1720607838413;
        Wed, 10 Jul 2024 03:37:18 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:d1a7:2644:c75e:c5ee])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-367cdfab6d3sm4896005f8f.112.2024.07.10.03.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jul 2024 03:37:17 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-doc@vger.kernel.org,  linux-alpha@vger.kernel.org,
  linux-mips@vger.kernel.org,  linux-parisc@vger.kernel.org,
  sparclinux@vger.kernel.org,  linux-trace-kernel@vger.kernel.org,
  linux-arch@vger.kernel.org,  linux-kselftest@vger.kernel.org,
  bpf@vger.kernel.org,  linux-media@vger.kernel.org,
  dri-devel@lists.freedesktop.org,  Jakub Kicinski <kuba@kernel.org>,
  "David S. Miller" <davem@davemloft.net>,  Eric Dumazet
 <edumazet@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Jonathan Corbet
 <corbet@lwn.net>,  Richard Henderson <richard.henderson@linaro.org>,  Ivan
 Kokshaysky <ink@jurassic.park.msu.ru>,  Matt Turner <mattst88@gmail.com>,
  Thomas Bogendoerfer <tsbogend@alpha.franken.de>,  "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>,  Helge Deller <deller@gmx.de>,
  Andreas Larsson <andreas@gaisler.com>,  Jesper Dangaard Brouer
 <hawk@kernel.org>,  Ilias Apalodimas <ilias.apalodimas@linaro.org>,
  Steven Rostedt <rostedt@goodmis.org>,  Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,  Arnd Bergmann <arnd@arndb.de>,  Steffen
 Klassert <steffen.klassert@secunet.com>,  Herbert Xu
 <herbert@gondor.apana.org.au>,  David Ahern <dsahern@kernel.org>,  Willem
 de Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan
 <shuah@kernel.org>,  Sumit Semwal <sumit.semwal@linaro.org>,  =?utf-8?Q?C?=
 =?utf-8?Q?hristian_K=C3=B6nig?= <christian.koenig@amd.com>,  Bagas Sanjaya
 <bagasdotme@gmail.com>,
  Christoph Hellwig <hch@infradead.org>,  Nikolay Aleksandrov
 <razor@blackwall.org>,  Taehee Yoo <ap420073@gmail.com>,  Pavel Begunkov
 <asml.silence@gmail.com>,  David Wei <dw@davidwei.uk>,  Jason Gunthorpe
 <jgg@ziepe.ca>,  Yunsheng Lin <linyunsheng@huawei.com>,  Shailend Chand
 <shailend@google.com>,  Harshitha Ramamurthy <hramamurthy@google.com>,
  Shakeel Butt <shakeel.butt@linux.dev>,  Jeroen de Borst
 <jeroendb@google.com>,  Praveen Kaligineedi <pkaligineedi@google.com>,
  Stanislav Fomichev <sdf@google.com>
Subject: Re: [PATCH net-next v16 02/13] net: netdev netlink api to bind
 dma-buf to a net device
In-Reply-To: <20240710001749.1388631-3-almasrymina@google.com> (Mina Almasry's
	message of "Wed, 10 Jul 2024 00:17:35 +0000")
Date: Wed, 10 Jul 2024 11:30:12 +0100
Message-ID: <m25xtd1qvf.fsf@gmail.com>
References: <20240710001749.1388631-1-almasrymina@google.com>
	<20240710001749.1388631-3-almasrymina@google.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mina Almasry <almasrymina@google.com> writes:

> API takes the dma-buf fd as input, and binds it to the netdevice. The
> user can specify the rx queues to bind the dma-buf to.
>
> Suggested-by: Stanislav Fomichev <sdf@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

