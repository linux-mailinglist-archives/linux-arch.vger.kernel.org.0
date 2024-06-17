Return-Path: <linux-arch+bounces-4946-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3425790B688
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 18:36:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83F9D281A91
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jun 2024 16:36:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5FD15F3EA;
	Mon, 17 Jun 2024 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kFJd7FBL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B45015D5CA;
	Mon, 17 Jun 2024 16:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718642188; cv=none; b=fLLApEuCTC3UiB3v2mCYw53LGdwqFFnEBDulR6y43dE99b8BUVGtxFPQj1La5Eq6LU2LyXFOMbYG7WpXWfcTKDcs5lP1YR/WbZTxX1rocp0cfaiOFNLDuGorJLIu/ebCMe5INUi8xDYJe2vQKAMENWt5yg+QpwswX2FtRRsPRoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718642188; c=relaxed/simple;
	bh=xiRRxg/KZQBTdrB1E+lOHTQF1uDvnOoFY+wqe+bREkA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwNEYRG9a7XATzoOn/0+GP5WGhKVqqY3WTH9eqLhxFQ9cJmmXbAJrBBz0k87owkGtTHMh9ArIJ03z7UiXiGMJaaMiDe+rPRpVxszHcgKiWct9Bb1hPKjMAP928/CyMnXOQTFG3e4kY9QOBodMYLSHFrCOwYQEXRZbwNQUQDH524=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFJd7FBL; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso528564366b.0;
        Mon, 17 Jun 2024 09:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718642184; x=1719246984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=53J7WI/sxMq7DMs+aYMSjnkpgSP1OKUPbBpcZiQTHx4=;
        b=kFJd7FBLCGOapx4/PAhavNBKnY47QfuhgUAOd/DZ2nllXci/kN4WXd9vHmE87giPc5
         nHsm1IjS2c8S9EDMQ5VaKl3CfRO1v52JP7pTtmRQPP/RNvpXJv4PWeKoqrZXqGMTPu2a
         rfPHduhqHKtAJN36Nf/OpHUkUK6L8R4PzR4NmwLKqIm8I3N9LBwYhctcbdpBNVwExxzu
         i4xxPc/PQ3hHw/lFYEZtM5+b7wKsM10tagF4to2cLbLEP3I8O/6HB3MSr12ecd4FxCL3
         3EmzHNcMlhzaltWJwONT7YKWIJ4yV1m7ugAY9/glyc5KAThqg0gatakiOC3IhKROV1/g
         UW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718642184; x=1719246984;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=53J7WI/sxMq7DMs+aYMSjnkpgSP1OKUPbBpcZiQTHx4=;
        b=m3777DKXhjqtdOQV3Jf3wnsejv7h1SGDK66ZkkasKy8GqDt6F8hgczQKo3JINOENh6
         QTKyjRO2tT9CNfDCMQRnU/ov5iCVmdLvQD3reUryha6Dywly8BWmytULfem3mU7NZNyU
         y5L/ophC2tL9KzbcL8AyRJ1alNmveJDUrAgMSuSMvjsIV7eIFKLep8eVSu69BO6MRPqn
         LmTiZ2J+FSKJuW/TVcJx54YKdhi2xfYvt32abDO2Xum8moN/ec4xaD9kTligFPnQ5FDh
         M+toCC4300lgM+Crc1CAQpkpgeTCmLAcFkMvgJxcz60eEzEoRk2MuTsEdd5AnEhKfmaJ
         QzQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVfJv/cL9SwEWuqwnSYPUGWEPxD/tk2UNC++7YHDWO9QOSqjcvEsVbS/ofV7mQ/YTJ6kRnyYhaU0zu8QqwTHBl4wAQr/gATWcvYtNWH4tVADlHCroAWGmoSvAtj2Mhng1V0xA8aBxAp5Y0W6mxBzlPWbdFqTCyv3DPxb6tl13gYU7Gvtvd9WnmE5dHkauVfikeG0uV+7xaQquj9oivWfuN43Eo48+FinGxY0qlS44pOZ1lho88fQhgmXFJaritO6mHE0zQDXaxIi89H8mlqaqkabExaNJFNeAwDehC4EM/qiGil+9GmRFfaTM3IWyghVhY3hJWDJJvu+pYOo4ndIAmRLoU9g1CrceU/ETURL1969dsDhWag3sQ0CtWBsJdWi1XLlnPcLAKSlxBqC2hIiEQ+3dVRDRLl4I0A0+6Rh2rgM+yRyfXOyC/aFKekBTqiaGHB5g7VUtibko9CfkyxFP1wbs1EOrvZhlo+MYRCt3WI79NNbj5RXmeRMoo5hwbGJklrPj8Uie6dIkwMeRTDMawwCZ8uQt48gbnfFwqASL8UKeSmOAhsDGw3
X-Gm-Message-State: AOJu0Ywt8D2/V4AncS641NXxtWZvtfLMzkd2RZw5tgTq+5u0oHrlVE0G
	pD73uDBL2CBYePp2CU5dSoOxE0mCmUfuavAULMcfaeyz336r6Eok
X-Google-Smtp-Source: AGHT+IEgIhSMoPO6IwzcFhQmUpnLu6gYo3keWNhjJiuidTn6zLGnPgWojVWeQQr2lo9qk89rXkkVsg==
X-Received: by 2002:a17:906:4341:b0:a6f:5c91:7be3 with SMTP id a640c23a62f3a-a6f60dc1fa8mr632023166b.56.1718642184123;
        Mon, 17 Jun 2024 09:36:24 -0700 (PDT)
Received: from [192.168.42.188] ([163.114.131.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f6a64a3efsm391222566b.173.2024.06.17.09.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jun 2024 09:36:23 -0700 (PDT)
Message-ID: <20a6a727-d9f2-495c-bf75-72c27740dd82@gmail.com>
Date: Mon, 17 Jun 2024 17:36:24 +0100
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v12 10/13] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner
 <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Andreas Larsson <andreas@gaisler.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Jesper Dangaard Brouer
 <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
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
 David Ahern <dsahern@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>,
 Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>,
 Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>,
 Shailend Chand <shailend@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>,
 Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst
 <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-11-almasrymina@google.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <20240613013557.1169171-11-almasrymina@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/13/24 02:35, Mina Almasry wrote:
> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
> 
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
> 
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
> 
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
> 
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.

One small concern is that if the pool gets destroyed (i.e.
page_pool_destroy) before sockets holding netiov, page pool will
semi-busily poll until the sockets die or such and will spam with
pr_warn(). E.g. when a user drops the nl but leaks data sockets
and continues with its userspace business. You can probably do
it in a loop and create dozens of such pending
page_pool_release_retry().


> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
...
> +static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> +			      unsigned int max_frags)
> +{
> +	int err, k;
> +
> +	if (p->idx < p->max)
> +		return 0;
> +
> +	xa_lock_bh(&sk->sk_user_frags);
> +
> +	tcp_xa_pool_commit_locked(sk, p);
> +
> +	for (k = 0; k < max_frags; k++) {
> +		err = __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> +				 XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL);
> +		if (err)
> +			break;
> +	}
> +
> +	xa_unlock_bh(&sk->sk_user_frags);
> +
> +	p->max = k;
> +	p->idx = 0;
> +	return k ? 0 : err;
> +}

Personally, I'd prefer this optimisation to be in a separate patch,
especially since there is some degree of hackiness to it.


> +
> +/* On error, returns the -errno. On success, returns number of bytes sent to the
> + * user. May not consume all of @remaining_len.
> + */
> +static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb,
> +			      unsigned int offset, struct msghdr *msg,
> +			      int remaining_len)
> +{
> +	struct dmabuf_cmsg dmabuf_cmsg = { 0 };
> +	struct tcp_xa_pool tcp_xa_pool;
> +	unsigned int start;
> +	int i, copy, n;
> +	int sent = 0;
> +	int err = 0;
> +
> +	tcp_xa_pool.max = 0;
> +	tcp_xa_pool.idx = 0;
> +	do {
> +		start = skb_headlen(skb);
> +
> +		if (skb_frags_readable(skb)) {
> +			err = -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Copy header. */
> +		copy = start - offset;
> +		if (copy > 0) {
> +			copy = min(copy, remaining_len);
> +
> +			n = copy_to_iter(skb->data + offset, copy,
> +					 &msg->msg_iter);
> +			if (n != copy) {
> +				err = -EFAULT;
> +				goto out;
> +			}
> +
> +			offset += copy;
> +			remaining_len -= copy;
> +
> +			/* First a dmabuf_cmsg for # bytes copied to user
> +			 * buffer.
> +			 */
> +			memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
> +			dmabuf_cmsg.frag_size = copy;
> +			err = put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEAR,
> +				       sizeof(dmabuf_cmsg), &dmabuf_cmsg);
> +			if (err || msg->msg_flags & MSG_CTRUNC) {
> +				msg->msg_flags &= ~MSG_CTRUNC;
> +				if (!err)
> +					err = -ETOOSMALL;
> +				goto out;
> +			}
> +
> +			sent += copy;
> +
> +			if (remaining_len == 0)
> +				goto out;
> +		}
> +
> +		/* after that, send information of dmabuf pages through a
> +		 * sequence of cmsg
> +		 */
> +		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +			skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
> +			struct net_iov *niov;
> +			u64 frag_offset;
> +			int end;
> +
> +			/* !skb_frags_readable() should indicate that ALL the
> +			 * frags in this skb are dmabuf net_iovs. We're checking
> +			 * for that flag above, but also check individual frags
> +			 * here. If the tcp stack is not setting
> +			 * skb_frags_readable() correctly, we still don't want
> +			 * to crash here.
> +			 */
> +			if (!skb_frag_net_iov(frag)) {
> +				net_err_ratelimited("Found non-dmabuf skb with net_iov");
> +				err = -ENODEV;
> +				goto out;
> +			}
> +
> +			niov = skb_frag_net_iov(frag);
> +			end = start + skb_frag_size(frag);
> +			copy = end - offset;
> +
> +			if (copy > 0) {
> +				copy = min(copy, remaining_len);
> +
> +				frag_offset = net_iov_virtual_addr(niov) +
> +					      skb_frag_off(frag) + offset -
> +					      start;
> +				dmabuf_cmsg.frag_offset = frag_offset;
> +				dmabuf_cmsg.frag_size = copy;
> +				err = tcp_xa_pool_refill(sk, &tcp_xa_pool,
> +							 skb_shinfo(skb)->nr_frags - i);
> +				if (err)
> +					goto out;
> +
> +				/* Will perform the exchange later */
> +				dmabuf_cmsg.frag_token = tcp_xa_pool.tokens[tcp_xa_pool.idx];
> +				dmabuf_cmsg.dmabuf_id = net_iov_binding_id(niov);
> +
> +				offset += copy;
> +				remaining_len -= copy;
> +
> +				err = put_cmsg(msg, SOL_SOCKET,
> +					       SO_DEVMEM_DMABUF,
> +					       sizeof(dmabuf_cmsg),
> +					       &dmabuf_cmsg);
> +				if (err || msg->msg_flags & MSG_CTRUNC) {
> +					msg->msg_flags &= ~MSG_CTRUNC;
> +					if (!err)
> +						err = -ETOOSMALL;
> +					goto out;
> +				}
> +
> +				atomic_long_inc(&niov->pp_ref_count);
> +				tcp_xa_pool.netmems[tcp_xa_pool.idx++] = skb_frag_netmem(frag);
> +
> +				sent += copy;
> +
> +				if (remaining_len == 0)
> +					goto out;
> +			}
> +			start = end;
> +		}
> +
> +		tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +		if (!remaining_len)
> +			goto out;
> +
> +		/* if remaining_len is not satisfied yet, we need to go to the
> +		 * next frag in the frag_list to satisfy remaining_len.
> +		 */
> +		skb = skb_shinfo(skb)->frag_list ?: skb->next;
> +
> +		offset = offset - start;

It's an offset into the current skb, isn't it? Wouldn't
offset = 0; be less confusing?

> +	} while (skb);
> +
> +	if (remaining_len) {
> +		err = -EFAULT;
> +		goto out;
> +	}

Having data left is not a fault, and to get here you
need to get an skb with no data left, which shouldn't
happen. Seems like everything you need is covered by
the "!sent" check below.


> +
> +out:
> +	tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +	if (!sent)
> +		sent = err;
> +
> +	return sent;
> +}
> +
...
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index de0c8f43448ab..57e48b75ac02a 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -79,6 +79,7 @@
>   #include <linux/seq_file.h>
>   #include <linux/inetdevice.h>
>   #include <linux/btf_ids.h>
> +#include <linux/skbuff_ref.h>
>   
>   #include <crypto/hash.h>
>   #include <linux/scatterlist.h>
> @@ -2503,6 +2504,15 @@ static void tcp_md5sig_info_free_rcu(struct rcu_head *head)
>   void tcp_v4_destroy_sock(struct sock *sk)
>   {
>   	struct tcp_sock *tp = tcp_sk(sk);
> +	__maybe_unused unsigned long index;
> +	__maybe_unused void *netmem;

How about adding a function to get rid of __maybe_unused?.

static void sock_release_devmem_frags() {
#ifdef PP
	unsigned index;
	...
#endif PP
}

Also, even though you wire it up for TCP, since ->sk_user_frags
is in struct sock I'd expect the release to be somewhere in the
generic sock path like __sk_destruct(), and same for init.
Perhpas, it's better to leave it for later.

> +
> +#ifdef CONFIG_PAGE_POOL
> +	xa_for_each(&sk->sk_user_frags, index, netmem)
> +		WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem));
> +#endif
> +
> +	xa_destroy(&sk->sk_user_frags);
>   
>   	trace_tcp_destroy_sock(sk);
>   
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index bc67f6b9efae4..5d563312efe14 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -624,6 +624,8 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
>   
>   	__TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>   
> +	xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> +
>   	return newsk;
>   }
>   EXPORT_SYMBOL(tcp_create_openreq_child);

-- 
Pavel Begunkov

