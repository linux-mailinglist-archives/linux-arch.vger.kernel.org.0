Return-Path: <linux-arch+bounces-977-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDDD811081
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 12:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A48FD2816CE
	for <lists+linux-arch@lfdr.de>; Wed, 13 Dec 2023 11:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A02575C;
	Wed, 13 Dec 2023 11:49:04 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88659AF;
	Wed, 13 Dec 2023 03:48:59 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4SqtyY5ySQz29g0y;
	Wed, 13 Dec 2023 19:47:49 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (unknown [7.185.36.74])
	by mail.maildlp.com (Postfix) with ESMTPS id 5ECA31400DA;
	Wed, 13 Dec 2023 19:48:57 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 19:48:57 +0800
Subject: Re: [net-next v1 09/16] page_pool: device memory support
To: Mina Almasry <almasrymina@google.com>
CC: Shailend Chand <shailend@google.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<bpf@vger.kernel.org>, <linux-media@vger.kernel.org>,
	<dri-devel@lists.freedesktop.org>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Jeroen de Borst
	<jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas
	<ilias.apalodimas@linaro.org>, Arnd Bergmann <arnd@arndb.de>, David Ahern
	<dsahern@kernel.org>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, Harshitha
 Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeelb@google.com>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <20231208005250.2910004-10-almasrymina@google.com>
 <32211cbf-3a4e-8a86-6214-4304ddb18a98@huawei.com>
 <CAHS8izOQcuLPwvDff96fuNB7r6EU9OWt3ShueQp=u7wat3L5LA@mail.gmail.com>
 <92e30bd9-6df4-b72f-7bcd-f4fe5670eba2@huawei.com>
 <CAHS8izPEFsqw50qgM+sPot6XVvOExpd+DrwrmPSR3zsWGLysRw@mail.gmail.com>
 <CAHS8izN6Cbjy0FCYhJyNsP396XfgJ_nTFXWuHb5QWNct=PifAg@mail.gmail.com>
 <59e07233-24cb-7fb2-1aee-e1cf7eb72fa9@huawei.com>
 <CAHS8izMdpo0D7GYzMkOtg1ueCODAVNxtwSP_qPseSYXNMhPGCw@mail.gmail.com>
 <2cdf173c-95e4-2141-56f7-0761705cd737@huawei.com>
 <CAHS8izOTdqqbS6ajAo+c646UwXkK-aB8ET9uJRS6Auszfi0nfA@mail.gmail.com>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <17adf1c0-e4ad-4baf-4d01-32d6544cc13e@huawei.com>
Date: Wed, 13 Dec 2023 19:48:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAHS8izOTdqqbS6ajAo+c646UwXkK-aB8ET9uJRS6Auszfi0nfA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)

On 2023/12/12 22:28, Mina Almasry wrote:

...

>>
>> the page_ref_*() API may be avoided using the below patch:
>> https://patchwork.kernel.org/project/netdevbpf/patch/20231113130041.58124-7-linyunsheng@huawei.com/
>>
> 
> Even after the patch above, you're still calling page_ref_count() in
> the page_pool to check for recycling, so after that patch you're still
> using page->_refcount.

Yes, we still need page_ref_count(), which seems be a similar problem
like the one for page_is_pfmemalloc(), can we deal with it like most
of other fields?

> 
>> But I am not sure how to do that for tx part if devmem for tx is not
>> intergating into page_pool, that is why I suggest having a tx implementation
>> for the next version, so that we can have a whole picture of devmem.
>>
> 
> I strongly prefer to keep the TX implementation in a separate series.
> This series is complicated to implement and review as it is, and is
> hitting the 15 patch limit anyway.

I am not sure how complicated the TX implementation for devmem will be
for the latest version, but from the RFCv1, it seems it is simple enough
to keep it in one patchset.

Anyway, it would be good to sort out the basic idea what is the tx API
for devmem when designing/implementing the rx API for devmem.

> 

