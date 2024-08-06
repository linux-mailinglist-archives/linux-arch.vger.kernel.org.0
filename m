Return-Path: <linux-arch+bounces-6035-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D61039489CE
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 09:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 828BA1F22271
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2024 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F6E166F2B;
	Tue,  6 Aug 2024 07:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="aLC7wrbu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6801C165F08;
	Tue,  6 Aug 2024 07:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722928289; cv=none; b=QFgLB4SHdvVNqSR1aoWk7ap+uoF1BBb+WVECraaqvmJqzn49rfLwfkJj6Y4zW8WcRHl0ydZHk+Wq6aWLKMV37z0iT35J3hT2Z6w87o+PvyzJ+EQ0+3tAcNG3Irg5xFdxr2xDpVsuHOiEtv12jl87vARzVrZINHJsf09xbQeG1bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722928289; c=relaxed/simple;
	bh=7HePuyoWPygVPxh4qKr24Yod2wxAsQz31TbzWEQpLRQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bCPHua2SW85CCcYg73datwMjbM2HOssSC0l2FUnJzHmw6Q6J92DxDxL8aAX1fPVQLB4wMheE+eVeEIrpshAhF0vzpcoHz9PwAmf+px6K3lYlLnnho3Z53SnQZB5tfXCdRuZe/HvMIQ38j3sF6KfLD+Vmrv5L/SmuvXjwtXoPWCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=aLC7wrbu; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1722928283; x=1723533083; i=markus.elfring@web.de;
	bh=7HePuyoWPygVPxh4qKr24Yod2wxAsQz31TbzWEQpLRQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=aLC7wrbugvHbc7JitVGK+UbcVshwtENRbS63MrtuGO+FdCGD2lnXqmw9CP9GnaeC
	 TFfrydT8yJue9bUo/wS8AtmAk6nut6jcbgQIBqgITOjiRRLa3VB1qGG0JiIl4CYsR
	 CkEQXMkLNvcXuDaYsPfRyyJZTDNY6Srf0tSU0Q3anf3BEVehnreZ+oVlvm7JJAl5g
	 4nC0KYEBxKRytoI1WgG+epHzc7IVXjXLUweerikYV6Bjs16L/pZuhHC0tOthxGXfY
	 SkQboLneSY9dYwF4taCPUoAcJcTqxWmK357OMq33GxwfPee2lBJx6wmYhg27NInOU
	 L1ATh6GHpOYXVQoftw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.90.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MbTL1-1s3oIK0Nk9-00mINb; Tue, 06
 Aug 2024 09:04:09 +0200
Message-ID: <9aad36fe-cd4c-4ce5-b4d8-6c8619d10c46@web.de>
Date: Tue, 6 Aug 2024 09:03:33 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v17 03/14] netdev: support binding dma-buf to
 netdevice
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, Willem de Bruijn <willemb@google.com>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 LKML <linux-kernel@vger.kernel.org>, Andreas Larsson <andreas@gaisler.com>,
 Arnd Bergmann <arnd@arndb.de>, Bagas Sanjaya <bagasdotme@gmail.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Christoph Hellwig <hch@infradead.org>, David Ahern <dsahern@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, David Wei <dw@davidwei.uk>,
 Donald Hunter <donald.hunter@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Helge Deller <deller@gmx.de>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Jakub Kicinski
 <kuba@kernel.org>,
 "James E. J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jeroen de Borst <jeroendb@google.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Matt Turner <mattst88@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Praveen Kaligineedi <pkaligineedi@google.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Shailend Chand <shailend@google.com>, Shakeel Butt <shakeel.butt@linux.dev>,
 Shuah Khan <shuah@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Steven Rostedt <rostedt@goodmis.org>, Sumit Semwal
 <sumit.semwal@linaro.org>, Taehee Yoo <ap420073@gmail.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Yunsheng Lin <linyunsheng@huawei.com>
References: <20240730022623.98909-4-almasrymina@google.com>
 <5d3c74da-7d44-4b88-8961-60f21f84f0ac@web.de>
 <CAHS8izPxfCv1VMFBK1FahGTjVmUSSfrabgY5y6V+XtaszoHQ4w@mail.gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CAHS8izPxfCv1VMFBK1FahGTjVmUSSfrabgY5y6V+XtaszoHQ4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ud03T+VJ0WQWkNGa/SuDGe/nuF0sGbh6xFVs6sj7mBpoHZmEK9m
 /g8pgN0ga+9LIF+xkm8yuxipRI1qpxk9O/iv4my6GHrRWDZdHWWggRKyAqliCerii6f6rsb
 4m+YAthbpuAnnWrnfbwf6MXbKNd/W6OA+m2MMbRtZr+OncP4jJnp6T9Z97ykCCWrjKOacd6
 hZrRGnLMzDmwJNYA5qgFQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zPsCc1lrsyU=;Y7DEz/vBBmk+SeE6JgoellZvOuX
 kcZRuFvCRXoAHvpu4L73XmcVhTOHNgehO96ILvjt1EA+Yfwm+WDObNm8eksbv1ELbJYKHqYuz
 C40nciD9oSUI3qebeUWhWAWNw7O1ZrFCxPEqgZbaIkIgGvz/ZvU+Edr2+r3atRNSYhdojMJGs
 qWNCXPBNGKklLG5YXjAmVynAryjZPyB4DRUWZuWuUZbVGnrzr/dfLX/m4iZiFVpuknIlxfLaS
 xWcqEOkcpgXpzyLmDKyCj2LOpicZIF8SfFwd5XFuIKa3K66sjfL+BkUlwpxAv7IpIijQA5uFB
 NMsuhO3BGbozyiyAPZ7SxPzrj+NoB+HSLSdffc9wC8m9fIO9zlY+RDpLSBXtfaqoSFdlE8Az+
 LQ4ucimoajT41/N7wv7fvsZri+AdA955Db3MF3Dd+TUWIr4dx5BdvpTc9KN8qH8s4Z3U6YKrq
 A6ohigBF8yZiYbPlA7HiLOZaWbX3o6tzjjX0bezEBmpfmnPEa63AfPvVSwsUGK8N2420+lMCV
 g1jPz/Et77QWGhKdme4mxWFmIYMlkhE4IVdnOfRmy2yYk28FC16LtnfwsXRLH+TzXHEznXqv+
 1OteD/9c2ul0sK2Y4eVn7vXLx2oN9+dzooNND404WbnJfqoRnLeEAdhrRHOc6IBP8m3r252jT
 e9hstn4baSSLD5NLSETphdL/3gwE897NmkuQvEGSR36s5Wk5yJSaRRiWtAHAZFN9pzMnJzQRn
 MySFB0ZEJi/ForUpyXH7UsRV8W2zYGkuWK9oriuaNLDHkUvpbnFnBefK38oMRYALjMqQRa8IU
 qJ0sxMyEwM1fCeDOojdWCPwQ==

>> =E2=80=A6
>>> +++ b/include/net/devmem.h
>>> @@ -0,0 +1,115 @@
>> =E2=80=A6
>>> +#ifndef _NET_DEVMEM_H
>>> +#define _NET_DEVMEM_H
>> =E2=80=A6
>>
>> I suggest to omit leading underscores from such identifiers.
>> https://wiki.sei.cmu.edu/confluence/display/c/DCL37-C.+Do+not+declare+o=
r+define+a+reserved+identifier
>>
>
> I was gonna apply this change, but I ack'd existing files and I find
> that all of them include leading underscores, including some very
> recently added files like net/core/page_pool_priv.h.
>
> I would prefer to stick to existing conventions if that's OK, unless
> there is widespread agreement to the contrary.

Under which circumstances would you become interested to reduce developmen=
t risks
also according to undefined behaviour?
https://wiki.sei.cmu.edu/confluence/display/c/CC.+Undefined+Behavior#CC.Un=
definedBehavior-ub_106

Regards,
Markus

