Return-Path: <linux-arch+bounces-4950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA10A90BAA5
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 21:15:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89BBB1C21EE9
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 19:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D39418735E;
	Mon, 17 Jun 2024 19:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HANXyEhB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D12CF4E2;
	Mon, 17 Jun 2024 19:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718651721; cv=none; b=nOFEykaLR32XHhIsTPSpeti4x1pSgUi6Dl2fYXWEG70+9MxN+I37ayCmqtdoCyeovyUaqsyRvM+tiMEJ+D6O+2yD3RJHSn+62j63TjlUKa/k+9gpYDeFT4aUYoFvpTrzz1EVw4WU48YwQy64LByKoqJuBi8hUZumRAB/s5AbGNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718651721; c=relaxed/simple;
	bh=nsufkampkQL2B/KAL+B3WIShcveSuYLyusXyX+/OFns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RffSTQOBRSHzSr3kDdWL/C2dnPSH570Zc6yHv/xeKghqfvE/s6jH23VKH6yGlD7DIzZqygheVNbA68uOAtqAZqbbxQVN1kffdDHdsdf8UDq6xOQtEB8/wPhFPHggPXWusKslN1pf/SXURKzAzC/J2zQX1FL+Rkknf0i7f+koSW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HANXyEhB; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57cce3bc8c6so2771519a12.3;
        Mon, 17 Jun 2024 12:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718651718; x=1719256518; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RTI1O6QA7ca9OdFzDxJ8jDm0hCKKz6E+AKsMSF5c9gg=;
        b=HANXyEhB51G9lWZwRDA1TOvJNnGv/ofkV+kDmuSt/rKrULJ6xyRh2HBWyjyqHEQASJ
         +j7agjw4Kva8YAgjMVVUSMq6z+QlPRLneyycPJz0BjrIccphF3ydLvKSrEDa6f0aD/4y
         JV0BVMsa9E12gzG93ygjZTWzxGCxeOligbNCtOGOaKeEA6hXIhS3HMwLr03TheiWv7NZ
         FOAh09l9mNZ/zDXe2go2ChA07t4phg7nyZRkTHz/7UdHHyI/Kk4xz4+mQY867Mgcjxx6
         t3mxgEhNP4/HK5JHevm1CAseJKqIKADOUneXl6l+krvaFjvBFDfaTZTPMH8NX66CBc3s
         0f0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718651718; x=1719256518;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RTI1O6QA7ca9OdFzDxJ8jDm0hCKKz6E+AKsMSF5c9gg=;
        b=hWb6mdp7gFx/3r5K2QEq/32nA2uOmpLT3UIJljCRaYUHehZDMSigXAj+DX0eXYaHNb
         rJNOWD2DGsbcN+yjKdnGhgJWHXO2XQPavgD2jTyidZpW/2EHk40h9T6hfQuiysBXYBSv
         zKJgDvvuAgYFunpTpVIkb6vVvFnY/EfF/ztYYCxURodBPi0raS9Bv/uFEFvghUTBaTbg
         HUOIMUmwlXoqR2zFjYuOm3IrJ7jZjyJGiz5TGQ5RkthN+exgYweZ1zoRiAj1zeGzTGkb
         oGAuncXmY1iTb13lOfxfbyXFLIT7HW3pKueEmIta2RXNdkTKfqy4XhIYVqCL6eWNPOOe
         l5aA==
X-Forwarded-Encrypted: i=1; AJvYcCWgzo9l7x071P6jenBNY0DCnB4K1SSENdBQkUqPbXJYpsyWrkJABFnDCxfuQ93OP7SgZbb63ReQ/JWy5uStVdU74EmZXXWKOJQ/rpiNQb1XokJctAMJdOHzlIIWA7C8yqY8cc36lWneIlqmvBU61PPpQKNhz8wD7GJaZJf+CDx9/Nr2EGhrIeANrCEwlwxOda6hYJwAayjpTpU9z4wRAH+K8/ENDTL+SyMV8YUg9IIW8PwZDYMBWnCyFnLQNhkZ/rEifvawAjpOZVs8qXI/BPaER6CZ6I/dD/0fBtzr9dzd+yA4vgXwOPay3V5bDdZ3rVpgP1gBq1pJy5chAciQKiAG3ZH062A5zt3gk6/YRt5+DFSz6hdwwD1nDyg9axp1pIO0YGDElcC/fqQ6wktkbAFXd5hIEP/7RjBbZKOfGjPnWymqD8rCRjq2cOzxh5WtFXCpwLuV2y24GC1yydE7KsD6Ftbd7uB8ZKtEd8ke8UyeVI8ioJDSzMMOyQaEOtYIiCTIVvRIZQ==
X-Gm-Message-State: AOJu0YycgqRiOaGC3XEhLbbGkw9FaW8+UbsV7HoeYegOKY/XZfgp5Sjp
	eHRNZ3KyX+uDD6ur2G4cSvKuzLrNxMGMipc4Co0JKB8h/LTUDgda
X-Google-Smtp-Source: AGHT+IHBSjL7hP+WPtAP2SKF5/rsbIqC60y9fVUpbG/XrFpirHjiCxXr5Vsl09CmHgTmroNfpH7Tcw==
X-Received: by 2002:a50:9b45:0:b0:57c:9cd3:4f96 with SMTP id 4fb4d7f45d1cf-57cbd908fcdmr6110311a12.40.1718651717456;
        Mon, 17 Jun 2024 12:15:17 -0700 (PDT)
Received: from [192.168.42.137] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57ce0457d82sm2034856a12.39.2024.06.17.12.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 12:15:16 -0700 (PDT)
Message-ID: <ff109ca0-3056-45fd-b1ae-5482e1affeb0@gmail.com>
Date: Mon, 17 Jun 2024 20:15:17 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 02/14] net: page_pool: create hooks for
 custom page providers
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: David Ahern <dsahern@kernel.org>, David Wei <dw@davidwei.uk>,
 Mina Almasry <almasrymina@google.com>, Christoph Hellwig
 <hch@infradead.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Steffen Klassert
 <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>
References: <5aee4bba-ca65-443c-bd78-e5599b814a13@gmail.com>
 <CAHS8izNmT_NzgCu1pY1RKgJh+kP2rCL_90Gqau2Pkd3-48Q1_w@mail.gmail.com>
 <eb237e6e-3626-4435-8af5-11ed3931b0ac@gmail.com>
 <be2d140f-db0f-4d15-967c-972ea6586b5c@kernel.org>
 <20240607145247.GG791043@ziepe.ca>
 <45803740-442c-4298-b47e-2d87ae5a6012@davidwei.uk>
 <54975459-7a5a-46ff-a9ae-dc16ceffbab4@gmail.com>
 <20240610121625.GI791043@ziepe.ca>
 <59443d14-1f1d-42bb-8be3-73e6e4a0b683@kernel.org>
 <00c67cf0-2bf3-4eaf-b200-ffe00d91593b@gmail.com>
 <20240610221500.GN791043@ziepe.ca>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240610221500.GN791043@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/10/24 23:15, Jason Gunthorpe wrote:
> On Mon, Jun 10, 2024 at 08:20:08PM +0100, Pavel Begunkov wrote:
>> On 6/10/24 16:16, David Ahern wrote:
> 
>>>> There is no reason you shouldn't be able to use your fast io_uring
>>>> completion and lifecycle flow with DMABUF backed memory. Those are not
>>>> widly different things and there is good reason they should work
>>>> together.
>>
>> Let's not mix up devmem TCP and dmabuf specifically, as I see it
>> your question was concerning the latter: "... DMABUF memory registered
>> through Mina's mechanism". io_uring's zcrx can trivially get dmabuf
>> support in future, as mentioned it's mostly the setup side. ABI,
>> buffer workflow and some details is a separate issue, and I don't
>> see how further integration aside from what we're already sharing
>> is beneficial, on opposite it'll complicate things.
> 
> Again, I am talking about composability here, duplicating the DMABUF
> stuff into io_uring is not composable, it is just duplicating things.

Ok, then registering, say, a dmabuf via devmem TCP and then using it
in io_uring. Let's say we make devmem TCP API to be able to register
a dmabuf without using it, from where io_uring can take ownership
over it and use in the flow. And I strongly believe the same memory
region/dmabuf should never be used by both at the same time and hence
lifetime of any such memory should be exclusively bound to io_uring.

That leaves the user api, where to add memory you need to create
a netlink socket and pass everything through it, which is an extra
step, and then letting know io_uring that it can use the memory, not
forgetting to eject it from netlink. That's not a good api as far as
it goes with io_uring.

I don't think slight duplicating of registration is a problem when
the upside is much cleaner API. Internals, however, can be easily
shared. We can even say that the net stack should provide helpers
like init_page_pool_from_dmabuf_fd() and now allow poking into
related bits aside from it (initialising net_iov / etc.).

> It does not match the view that there should be two distinct layers
> here, one that provides the pages and one that manages the
> lifecycle. As HCH pushes for pages either come from the allocator and
> get to use the struct folio or the come from a dmabuf and they
> don't. That is it, the only two choices.
> 
> The iouring stuff is trying to confuse the source of the pages with
> the lifecycle - which is surely convenient, but is why Christoph is
> opposing it.

-- 
Pavel Begunkov

