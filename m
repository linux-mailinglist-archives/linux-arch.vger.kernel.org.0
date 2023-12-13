Return-Path: <linux-arch+bounces-956-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13757810813
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 03:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04262B20F66
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 02:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3FE0ECE;
	Wed, 13 Dec 2023 02:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DyCeS9Gm"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61FAB1C01;
	Wed, 13 Dec 2023 02:19:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD23C433C8;
	Wed, 13 Dec 2023 02:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702433950;
	bh=DQPF3GcanIRKcaZKx1G5ZSV6kAy0I6t5QN8G9OuMZdM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DyCeS9GmtbFGFSsFn5YSGcJgY03zFug1iziwTrwVmg/ZlNI8m4c58IveouykxEdqa
	 EMnEhzuZ63StLiesj5cSjbJf4TmG4ZBa1yJ7JCzsdawYg44TMs0dyNRoLJ1GELn1tz
	 mZ0ttW2DALNof274ibmywvx6VjyQmwZ21hJje2+EzxdBAhAbf2HCJYKHiiZ+1qP7MN
	 awBRzsmBQJpRFMscNENawsc7TC/PSZAjpMEzMokycEPjSXZZ9oUEEmo+Oekfpv6dsz
	 Lulob+ZQQMb5SPxcQHqSMtRg1Oa5btnY+jl5DG0GR/t04qzTQhWGqHRNhfn4l51+iE
	 FdNU7DP2aIKOg==
Message-ID: <cd464bae-af47-42f1-ac9f-9620137ede89@kernel.org>
Date: Tue, 12 Dec 2023 18:19:09 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 08/16] memory-provider: dmabuf devmem memory
 provider
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 Jeroen de Borst <jeroendb@google.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeelb@google.com>, Willem de Bruijn <willemb@google.com>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Christoph Hellwig <hch@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-9-almasrymina@google.com>
 <20231212122535.GA3029808@nvidia.com>
 <CAHS8izMVMx0fpT=dWsnD7piqs1g7Fam8Xf5dK3iOFNxeOQD9vQ@mail.gmail.com>
 <20231212143942.GF3014157@nvidia.com>
 <CAHS8izNHtemjjkMf43grCHP1RZ=2UFiMtgea0M6+PaAgC=DDMQ@mail.gmail.com>
 <20231212150834.GI3014157@nvidia.com>
 <CAHS8izMdKYyjE9bdcFDWWPWECwVZL7XQjtjOFoTq5_bEEJvN6w@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CAHS8izMdKYyjE9bdcFDWWPWECwVZL7XQjtjOFoTq5_bEEJvN6w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/23 6:09 PM, Mina Almasry wrote:
> OK, I imagine this is not that hard to implement - it's really whether
> the change is acceptable to reviewers.
> 
> I figure I can start by implementing a no-op abstraction to page*:
> 
> typedef struct page netmem_t
> 
> and replace the page* in the following places with netmem_t*:
> 
> 1. page_pool API (not internals)
> 2. drivers using the page_pool.
> 3. skb_frag_t.
> 

accessors to skb_frag_t field are now consolidated to
include/linux/skbuff.h (the one IB driver was fixed in Sept by
4ececeb83986), so changing skb_frag_t from bio_vec to something like:

typedef struct skb_frag {
	void *addr;
	unsigned int length;
	unsigned int offset;
};

is trivial. From there, addr can default to `struct page *`. If LSB is
set, strip it and return `struct page_pool_iov *` or `struct buffer_pool *`

