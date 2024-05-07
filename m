Return-Path: <linux-arch+bounces-4242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 854688BE9B1
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 18:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB0C287100
	for <lists+linux-arch@lfdr.de>; Tue,  7 May 2024 16:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 658B916D4FB;
	Tue,  7 May 2024 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="e3y3Zlvm"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9654BD7
	for <linux-arch@vger.kernel.org>; Tue,  7 May 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715100523; cv=none; b=Cyu2y/qz87Bh4AxUmX2odvXhRVFwYJbvt/9JnB3VuA15F0xQpYVOWlct5z1DJeKWGbG6miaBUD7bxWH4mNU8zhlSHXP/IfnI/4BemTxLdRuLmRnfPtXT1r7j2YQsGpYTOeyt14ph/R7345MwVQzVD4NQFyNf/3THn/fh9HrDsls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715100523; c=relaxed/simple;
	bh=gOXMXsqBJM5en+QCPBiSpytwuPa/Zj3rDSRIG7JgC/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NmMwlxcjC04BSunbeRCaPrd1br2lRPT/+Z9UoiLXB/igpvVQcP3Ks3O4nfAdwhCb6VOjHT/GCiHNRRYf3AfdhAbjSXy8PmY/GUTGC/yW2/MxI4Y1lrM6aHGx45UjK9gFxAkkOy1kPsoU6+Rcg3CVBhtQUdo4c8DC5GAKKfN0dH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=e3y3Zlvm; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6969388c36fso16297176d6.1
        for <linux-arch@vger.kernel.org>; Tue, 07 May 2024 09:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715100519; x=1715705319; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gOXMXsqBJM5en+QCPBiSpytwuPa/Zj3rDSRIG7JgC/c=;
        b=e3y3ZlvmpvWAJj7MTUW+26f0kgYSEswWY2ZN3nivNYBmlA4n3ch9d45Gc3Oyv+C+S9
         BCaAkAGTtb76Jwu38vME2UXHr+ljXzQaRpFtKEhNQ2JBZFQzim7ihRWc6wqOnrhzHXxz
         mejoSuB+uND2x9uWknUYq6MIkoS5cC0HaLxqPuq01u8jDAu9sNVFW+ZONnJ+rLeSIvWs
         XFA2l9ig93va4x0k/Uk/mYGg1Y/O4nts8ZeX6SJCzE5psD8h9bXsMgiXHWBN6DErt3vr
         FxVGNMhorRM+5zrjm8bKwGgcjp/p0ByBxITLHYf5wBnS7TKbGmjEnDGe5BNjZXQwhFRC
         mEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715100519; x=1715705319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gOXMXsqBJM5en+QCPBiSpytwuPa/Zj3rDSRIG7JgC/c=;
        b=LwwfKB2VXKb6RU4R+Ab5kl32pdthhHCWGukE/0Pc7St4/LJRPUZM3+s5FB4tIizaCx
         ZfkSt90rvoT2yaVlEXwrlaDklqljehi1b2RA40Do6QYz9vdyjL1/J+gJ0RbuVzXHdCyb
         kYNnbjuCfONnO6wvJ/aDv+K9wra492LIuglkmM3U2yO255sh6GUsGFdc0s8HdOUgvdPs
         YgoGFHer1p4zkT75jBD71dvkuvBGC8mZBctbZ47i9+IR8g5osjM5sGswnVatkSN0uqtX
         S6Rer8X+p/gQHOkANSyrm8ew8goOxrb78bjwSBEWkRtdhdRApjVox+IjpHfbqMUr4BxS
         +87Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjiQOMKcse65wFP1GJwYLTME04px14R7Z4SIO+T7DQqa9ZutanrM+EtJ/U+oDxsN+xVI07KT9oqsAmrBDcSAw5GiiDVlNtTnziDA==
X-Gm-Message-State: AOJu0YyRz413+odKtv3AXl7u4i39XVE1O9DMIOSPmRLe4CxNyPZRtb3q
	LdbWTPpM08I9bVOk2Ovt/IEekdoUryg6gPPqTGSRPynYi6PPPGBc2KTnmJymfLQ=
X-Google-Smtp-Source: AGHT+IFbsxT2Pt8ByXGyT7LtxaJucQY1rIIZhIGZ18mB5aP258L/BIC9x6k5KbmoTctVF3TG4pq55g==
X-Received: by 2002:a05:6214:d6f:b0:6a0:d701:3e2f with SMTP id 6a1803df08f44-6a1514e62bdmr3983216d6.56.1715100519594;
        Tue, 07 May 2024 09:48:39 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id m17-20020ad44a11000000b006a0d7154d13sm4802415qvz.78.2024.05.07.09.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 09:48:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4Nza-0001bb-8V;
	Tue, 07 May 2024 13:48:38 -0300
Date: Tue, 7 May 2024 13:48:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mina Almasry <almasrymina@google.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Pavel Begunkov <asml.silence@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Richard Henderson <richard.henderson@linaro.org>,
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Matt Turner <mattst88@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	David Ahern <dsahern@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Amritha Nambiar <amritha.nambiar@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Florian Westphal <fw@strlen.de>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Jens Axboe <axboe@kernel.dk>,
	Arseniy Krasnov <avkrasnov@salutedevices.com>,
	Aleksander Lobakin <aleksander.lobakin@intel.com>,
	Michael Lass <bevan@bi-co.net>, Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Richard Gobert <richardbgobert@gmail.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>, David Wei <dw@davidwei.uk>,
	Shailend Chand <shailend@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>
Subject: Re: [RFC PATCH net-next v8 02/14] net: page_pool: create hooks for
 custom page providers
Message-ID: <20240507164838.GG4718@ziepe.ca>
References: <20240403002053.2376017-1-almasrymina@google.com>
 <20240403002053.2376017-3-almasrymina@google.com>
 <ZjH1QaSSQ98mw158@infradead.org>
 <CAHS8izM0=xc2UhUxhnF_BixuFs5VaDV9W1jbso1K+Rg=35NzeA@mail.gmail.com>
 <ZjjHUh1eINPg1wkn@infradead.org>
 <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca>
 <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>

On Tue, May 07, 2024 at 09:42:05AM -0700, Mina Almasry wrote:

> 1. Align with devmem TCP to use udmabuf for your io_uring memory. I
> think in the past you said it's a uapi you don't link but in the face
> of this pushback you may want to reconsider.

dmabuf does not force a uapi, you can acquire your pages however you
want and wrap them up in a dmabuf. No uapi at all.

The point is that dmabuf already provides ops that do basically what
is needed here. We don't need ops calling ops just because dmabuf's
ops are not understsood or not perfect. Fixup dmabuf.

If io_uring wants to take its existing memory pre-registration it can
wrap that in a dmbauf, and somehow pass it to the netstack. Userspace
doesn't need to know a dmabuf is being used in the background.

Jason

