Return-Path: <linux-arch+bounces-810-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ED580AB74
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 18:57:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DD9A2817DA
	for <lists+linux-arch@lfdr.de>; Fri,  8 Dec 2023 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E31C41C86;
	Fri,  8 Dec 2023 17:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IrhW+No2"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4392539AF3;
	Fri,  8 Dec 2023 17:57:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D37FC433C8;
	Fri,  8 Dec 2023 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702058269;
	bh=MZC8OXd/xhYpQFY9QXSMpIHOKQcKILf1nuFEeLx1Z1k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IrhW+No2LIvscdmhlUWqrjJiqbzeddYeZMlOvgrxLv9Pp/gv65XNGK+d/kQvyt9F8
	 eWeHCO3AAqSqLgKmc7Ik62hbdVifPyu/Z9BpeaTSYwEumWm4CM5RdsEVq3wTqAc8Yt
	 0Mtxfy6ckCdT2CkRx53DyJYDR5tIlMzrGiRqLFkqVd6vRp5p0uaNNgnc/icx60AhME
	 T4jAdjX/YdISDa0zROBRF880qcvvvYg4KCcH3HTEvBilmN+djnGudGA6yjwLQu61zC
	 QQA9Js/3CQoJWElJJO/mXVHwonG1Z2FbVz8Cwm/aqWQC4pxhlM1WCn1Hu4n/x0J3l+
	 Hql17ZKbnZbkA==
Message-ID: <3fea9ae9-e9e6-4ba5-812b-2775a6ed9e6a@kernel.org>
Date: Fri, 8 Dec 2023 10:57:47 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v1 00/16] Device Memory TCP
Content-Language: en-US
To: Mina Almasry <almasrymina@google.com>,
 Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
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
 Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20231208005250.2910004-1-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/7/23 5:52 PM, Mina Almasry wrote:
> Major changes in v1:
> --------------
> 
> 1. Implemented MVP queue API ndos to remove the userspace-visible
>    driver reset.
> 
> 2. Fixed issues in the napi_pp_put_page() devmem frag unref path.
> 
> 3. Removed RFC tag.
> 
> Many smaller addressed comments across all the patches (patches have
> individual change log).
> 
> Full tree including the rest of the GVE driver changes:
> https://github.com/mina/linux/commits/tcpdevmem-v1
> 

Still a lot of DEVMEM references (e.g., socket API). Any reason not to
move those to DMABUF?


