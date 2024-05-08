Return-Path: <linux-arch+bounces-4266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A68BFFE3
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 16:25:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBCB21346
	for <lists+linux-arch@lfdr.de>; Wed,  8 May 2024 14:25:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E68A85653;
	Wed,  8 May 2024 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PkSz5ZIr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CF785632
	for <linux-arch@vger.kernel.org>; Wed,  8 May 2024 14:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715178335; cv=none; b=EI4gQ9cnMcz5Q3gj/4x80FeApEFsRgVAkfUlFDstnJ0qSV+wMaCBlu4+R+VVHGSGABF2SxSBxbgInOuUMmX0ucIrfK5EJ/dceYX6ODxVOML8eRDXp1Nk7rFkbaSa/Xi9KUc6Fnj92k0a1dAl2DocBTBVMFor7veMqDlks+fracc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715178335; c=relaxed/simple;
	bh=4BjthKjlyBrv7qlqiwaK/PtT8pzCfUhJT3JhHavFgDI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wuly9rerEquYBnImyv1wmkRtFyD5GpbA5NXzqlIuwASg71JSXTmAxUQXv8H/Riw6HzY8JIWs8obIJtv6V3exgMKAqn5PakSzXd4G5lDkEEWPsFBJLfW+7rsB0U5KagqULoWFD3BVuxVNtfPBMAPfd/dUryEDAtekais7PD/5wm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PkSz5ZIr; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b203c9933dso2366190eaf.3
        for <linux-arch@vger.kernel.org>; Wed, 08 May 2024 07:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1715178332; x=1715783132; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AgrD1WoYkdj8wg28imEY2ANZlllvJHBViF8cNCfVJ94=;
        b=PkSz5ZIrJA+JdKLTG1OfJOpsC3pIK9p0Yyyccg0hoyFx4nX+QslSRwMwI4DVdChRJP
         izW8bkDiT9CPlsFn6NWC8ObqLmJqHdv9dPY0oT30ErifiuP39AlKPuvD7Yf+BkCaa7Sb
         Te00sjo5KeKCTCzDG2Db1vLaDVs3d6arHQrZ1bw9QDP+92DwkxA9EYsv7pLYZJCoOqPF
         uZtQ58ltzdg1IK0HMjEk0b7ojsbJFvvU8qgxGk4eLmdxoYaDj295d2YoNoZssCzplhTt
         gIWCjBnmhmKaQvlqOK/z5YS7LMtFLbkb/MYrvH7dBUqJkFBFDaeqoCDz0sPa37MSs4wn
         v6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715178332; x=1715783132;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AgrD1WoYkdj8wg28imEY2ANZlllvJHBViF8cNCfVJ94=;
        b=Iz8IrSRG/JrVWfvmORbcE6y90G+n2za4+JyzhnF/5P/Dius7jxIYMouEsu4vyoTIVI
         PoIOrC5ySpWq2XLI2el/cBQizV7Kw7yqmxBMu99N9FAJozYhfL/uVU3HS9IEaKNLe0tA
         Znl6c/7gcvNtX0bgZFh67AgPNM1FJxS/ihs3nSxJ0+p9VGGajx36TGvzS2f7uOkPJcBd
         Hgo2eozkOklHWmWAE0NP0iJ7Hf4y0FlrvMkSdz9rPkWFY4UZiXw6/dU/mNBrVTZMJjFc
         sWhnVD6tYHkB/hC0yX0gvyvNYQuTNHTbhA698YnJYbgvKq6Dg8x4wZ4BiTsyI2ZxGBF0
         GE0A==
X-Forwarded-Encrypted: i=1; AJvYcCXuNCOKLKMOsPQdnYOVLJSNijqpdNhWQKqlBvBSlnWr2gyUUT0eWEzmKASo4+dy3R+1RU3vvs0pBQZ0fSQbAQnGl4HLeD+Ev8waBw==
X-Gm-Message-State: AOJu0YwBk8qmgqCdsbC5F4fWuPIZ5nCfYPLVoTUy8DirnXh9DQ7sit4J
	ihwjXv2fOe2iay/7VqZyHzMvsxwdtZ/N2ajJ20W6g2aqma/53hmBmbO6Ej+UtD0=
X-Google-Smtp-Source: AGHT+IHjV+YjcifEHKw5oQYkCNsBVkCIuACEQyUL/WL5v5GcAhnL6ouYxG09iM1YvQ+6Pe3rmrQdgA==
X-Received: by 2002:a4a:8c24:0:b0:5aa:538a:ed60 with SMTP id 006d021491bc7-5b24d28fdb4mr2495842eaf.3.1715178331994;
        Wed, 08 May 2024 07:25:31 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id o18-20020ac86992000000b0043d4245dd4csm4389539qtq.84.2024.05.08.07.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 07:25:31 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1s4iEc-0016QI-DE;
	Wed, 08 May 2024 11:25:30 -0300
Date: Wed, 8 May 2024 11:25:30 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Christoph Hellwig <hch@infradead.org>, netdev@vger.kernel.org,
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
Message-ID: <20240508142530.GR4718@ziepe.ca>
References: <20b1c2d9-0b37-414c-b348-89684c0c0998@gmail.com>
 <20240507161857.GA4718@ziepe.ca>
 <ZjpVfPqGNfE5N4bl@infradead.org>
 <CAHS8izPH+sRLSiZ7vbrNtRdHrFEf8XQ61XAyHuxRSL9Jjy8YbQ@mail.gmail.com>
 <20240507164838.GG4718@ziepe.ca>
 <0d5da361-cc7b-46e9-a635-9a7a4c208444@gmail.com>
 <20240507175644.GJ4718@ziepe.ca>
 <6a50d01a-b5b9-4699-9d58-94e5f8f81c13@gmail.com>
 <20240507233247.GK4718@ziepe.ca>
 <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54830914-1ec9-4312-96ad-423ac0aeb233@gmail.com>

On Wed, May 08, 2024 at 12:30:07PM +0100, Pavel Begunkov wrote:

> > I'm not going to pretend to know about page pool details, but dmabuf
> > is the way to get the bulk of pages into a pool within the net stack's
> > allocator and keep that bulk properly refcounted while.> An object like
> > dmabuf is needed for the general case because there are
> > not going to be per-page references or otherwise available.
> 
> They are already pinned, memory is owned by the provider, io_uring
> in this case, and it should not be freed circumventing io_uring,
> and at this stage calling release_pages() is not such a hassle,
> especially comparing to introducing an additional object.

Something needs to co-ordinate when the net stack's allocator is done
with the bulk of pages and when io_uring and do the final
put_user_page() to free it. DMABUF is not an unreasonable choice for
this.

> > topic to me, and honestly hacking into the allocator free function
> > seems a bit weird..
> 
> Do you also think that DMA_BUF_IOCTL_SYNC is a weird hack, because
> it "delays free" by pinning the dmabuf object and letting the user
> read memory instead of copying it? I can find many examples

It seems to me the flow you want is for the driver to allocate a page,
put it on a rx ring, process it through the netstack, and deliver it
to io_uring. io_uring would then sit on the allocation until userspace
it done and return it back to the netstack allocator.

Hooking the free of the netstack allocator and then defering it seems
like a weird and indirect way to get there. Why can't io_uring just be
the entity that does the final free and not mess with the logic
allocator?

Jason

