Return-Path: <linux-arch+bounces-99-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7090E7E68D2
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 11:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23AB0280F7F
	for <lists+linux-arch@lfdr.de>; Thu,  9 Nov 2023 10:52:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E8D2F0;
	Thu,  9 Nov 2023 10:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G0xYx9PP"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62904D304
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 10:52:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4385270C
	for <linux-arch@vger.kernel.org>; Thu,  9 Nov 2023 02:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699527148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/fEMZu04vJmPyEDeZ4tFFxfgW3Qd9nS2eGWSB2Vs73s=;
	b=G0xYx9PPvsoDZewWJuKU2w7VCAuGTavF5gnq7xz81+vhaMrHHl6O0OMhdwfO8cZCpyZMFv
	e683uQ7mnKb46udyYGvazzy1Hll8RO7yC/GW9eI0qqHn3ltg33fYwO4WG7N9ghnMsAKTEd
	8ZC8fj5CalW9nPv/KVv1NjDgN5MgBH0=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-BoZ7VsjDOziOHHxageeKcg-1; Thu, 09 Nov 2023 05:52:26 -0500
X-MC-Unique: BoZ7VsjDOziOHHxageeKcg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-66cfa898cfeso1039156d6.0
        for <linux-arch@vger.kernel.org>; Thu, 09 Nov 2023 02:52:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699527126; x=1700131926;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/fEMZu04vJmPyEDeZ4tFFxfgW3Qd9nS2eGWSB2Vs73s=;
        b=HjnMtsyIXXtFRQL0W0+WH0PdQCJ9rgH0aTMAOOfVWMQ/KRftZEyswi4PkQXV1YGyLo
         v1EDOmUMnpT1jbK+guGquCrY3HrAbmyK3BqKtkJQqR+4sjaw8ur1Mu0IAT7yl61h9lLP
         Oe7z/lQvY25T+YqQAQ/A3cuUlhkN5jQY56Z1vzG2T+2s3Dmt6V4kuDtD4erd5q78fxB2
         3xzbRAIoUeuJ0btw1fHL0AEyPY5qd13S7c9DUuLIN2U15MQwhGC2XTcIEsB67wRLbqy4
         enaE7B0ajsvrcv2fKJnf+P4CwRFg/tkiaMZuP+OiS/XnG67Ug3+JZ2qVjyPnIuwZPnka
         FjuA==
X-Gm-Message-State: AOJu0YwostFBG2MpXBB62pBMrFjHkqMSPLYzl8Io84OIDCqYWWq2Unwl
	kb3dqeGy0SjZoP8Jv57GsM7vnCKDUJL7U3MNbUhLKIxffmWS2rcsknHpwsyy+gFECOwSBuuzY0c
	X/V4pxVfxbzqkYLDmQ7YXqA==
X-Received: by 2002:a05:6214:4a:b0:670:d117:1f9e with SMTP id c10-20020a056214004a00b00670d1171f9emr4487352qvr.2.1699527126641;
        Thu, 09 Nov 2023 02:52:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAk/DQxSd74d4wUNFAZnKsQQezg47K5p4R/fP0LVcZMKk5oMlW4rqzws8VL1bQTjgTMKPmVQ==
X-Received: by 2002:a05:6214:4a:b0:670:d117:1f9e with SMTP id c10-20020a056214004a00b00670d1171f9emr4487333qvr.2.1699527126264;
        Thu, 09 Nov 2023 02:52:06 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-228-197.dyn.eolo.it. [146.241.228.197])
        by smtp.gmail.com with ESMTPSA id l8-20020a056214104800b0065d89f4d537sm1952390qvr.45.2023.11.09.02.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:52:05 -0800 (PST)
Message-ID: <e584ca804a2e98bcf6e8e5ea2d4206f9f579e0ce.camel@redhat.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From: Paolo Abeni <pabeni@redhat.com>
To: Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Arnd Bergmann <arnd@arndb.de>, David Ahern <dsahern@kernel.org>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>,  Shuah Khan <shuah@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>, Christian =?ISO-8859-1?Q?K=F6nig?=
 <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, Jeroen de
 Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>,
 Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Date: Thu, 09 Nov 2023 11:52:01 +0100
In-Reply-To: <20231106024413.2801438-11-almasrymina@google.com>
References: <20231106024413.2801438-1-almasrymina@google.com>
	 <20231106024413.2801438-11-almasrymina@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2023-11-05 at 18:44 -0800, Mina Almasry wrote:
[...]
> +/* On error, returns the -errno. On success, returns number of bytes sen=
t to the
> + * user. May not consume all of @remaining_len.
> + */
> +static int tcp_recvmsg_devmem(const struct sock *sk, const struct sk_buf=
f *skb,
> +			      unsigned int offset, struct msghdr *msg,
> +			      int remaining_len)
> +{
> +	struct cmsg_devmem cmsg_devmem =3D { 0 };
> +	unsigned int start;
> +	int i, copy, n;
> +	int sent =3D 0;
> +	int err =3D 0;
> +
> +	do {
> +		start =3D skb_headlen(skb);
> +
> +		if (!skb_frags_not_readable(skb)) {

As 'skb_frags_not_readable()' is intended to be a possibly wider scope
test then skb->devmem, should the above test explicitly skb->devmem?

> +			err =3D -ENODEV;
> +			goto out;
> +		}
> +
> +		/* Copy header. */
> +		copy =3D start - offset;
> +		if (copy > 0) {
> +			copy =3D min(copy, remaining_len);
> +
> +			n =3D copy_to_iter(skb->data + offset, copy,
> +					 &msg->msg_iter);
> +			if (n !=3D copy) {
> +				err =3D -EFAULT;
> +				goto out;
> +			}
> +
> +			offset +=3D copy;
> +			remaining_len -=3D copy;
> +
> +			/* First a cmsg_devmem for # bytes copied to user
> +			 * buffer.
> +			 */
> +			memset(&cmsg_devmem, 0, sizeof(cmsg_devmem));
> +			cmsg_devmem.frag_size =3D copy;
> +			err =3D put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_HEADER,
> +				       sizeof(cmsg_devmem), &cmsg_devmem);
> +			if (err || msg->msg_flags & MSG_CTRUNC) {
> +				msg->msg_flags &=3D ~MSG_CTRUNC;
> +				if (!err)
> +					err =3D -ETOOSMALL;
> +				goto out;
> +			}
> +
> +			sent +=3D copy;
> +
> +			if (remaining_len =3D=3D 0)
> +				goto out;
> +		}
> +
> +		/* after that, send information of devmem pages through a
> +		 * sequence of cmsg
> +		 */
> +		for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +			const skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> +			struct page_pool_iov *ppiov;
> +			u64 frag_offset;
> +			u32 user_token;
> +			int end;
> +
> +			/* skb_frags_not_readable() should indicate that ALL the
> +			 * frags in this skb are unreadable page_pool_iovs.
> +			 * We're checking for that flag above, but also check
> +			 * individual pages here. If the tcp stack is not
> +			 * setting skb->devmem correctly, we still don't want to
> +			 * crash here when accessing pgmap or priv below.
> +			 */
> +			if (!skb_frag_page_pool_iov(frag)) {
> +				net_err_ratelimited("Found non-devmem skb with page_pool_iov");
> +				err =3D -ENODEV;
> +				goto out;
> +			}
> +
> +			ppiov =3D skb_frag_page_pool_iov(frag);
> +			end =3D start + skb_frag_size(frag);
> +			copy =3D end - offset;
> +
> +			if (copy > 0) {
> +				copy =3D min(copy, remaining_len);
> +
> +				frag_offset =3D page_pool_iov_virtual_addr(ppiov) +
> +					      skb_frag_off(frag) + offset -
> +					      start;
> +				cmsg_devmem.frag_offset =3D frag_offset;
> +				cmsg_devmem.frag_size =3D copy;
> +				err =3D xa_alloc((struct xarray *)&sk->sk_user_pages,
> +					       &user_token, frag->bv_page,
> +					       xa_limit_31b, GFP_KERNEL);
> +				if (err)
> +					goto out;
> +
> +				cmsg_devmem.frag_token =3D user_token;
> +
> +				offset +=3D copy;
> +				remaining_len -=3D copy;
> +
> +				err =3D put_cmsg(msg, SOL_SOCKET,
> +					       SO_DEVMEM_OFFSET,
> +					       sizeof(cmsg_devmem),
> +					       &cmsg_devmem);
> +				if (err || msg->msg_flags & MSG_CTRUNC) {
> +					msg->msg_flags &=3D ~MSG_CTRUNC;
> +					xa_erase((struct xarray *)&sk->sk_user_pages,
> +						 user_token);
> +					if (!err)
> +						err =3D -ETOOSMALL;
> +					goto out;
> +				}
> +
> +				page_pool_iov_get_many(ppiov, 1);
> +
> +				sent +=3D copy;
> +
> +				if (remaining_len =3D=3D 0)
> +					goto out;
> +			}
> +			start =3D end;
> +		}
> +
> +		if (!remaining_len)
> +			goto out;
> +
> +		/* if remaining_len is not satisfied yet, we need to go to the
> +		 * next frag in the frag_list to satisfy remaining_len.
> +		 */
> +		skb =3D skb_shinfo(skb)->frag_list ?: skb->next;

I think at this point the 'skb' is still on the sk receive queue. The
above will possibly walk the queue.

Later on, only the current queue tail could be possibly consumed by
tcp_recvmsg_locked(). This feel confusing to me?!? Why don't limit the
loop only the 'current' skb and it's frags?

> +
> +		offset =3D offset - start;
> +	} while (skb);
> +
> +	if (remaining_len) {
> +		err =3D -EFAULT;
> +		goto out;
> +	}
> +
> +out:
> +	if (!sent)
> +		sent =3D err;
> +
> +	return sent;
> +}
> +
>  /*
>   *	This routine copies from a sock struct into the user buffer.
>   *
> @@ -2314,6 +2463,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>  			      int *cmsg_flags)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
> +	int last_copied_devmem =3D -1; /* uninitialized */
>  	int copied =3D 0;
>  	u32 peek_seq;
>  	u32 *seq;
> @@ -2491,15 +2641,44 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
>  		}
> =20
>  		if (!(flags & MSG_TRUNC)) {
> -			err =3D skb_copy_datagram_msg(skb, offset, msg, used);
> -			if (err) {
> -				/* Exception. Bailout! */
> -				if (!copied)
> -					copied =3D -EFAULT;
> +			if (last_copied_devmem !=3D -1 &&
> +			    last_copied_devmem !=3D skb->devmem)
>  				break;
> +
> +			if (!skb->devmem) {
> +				err =3D skb_copy_datagram_msg(skb, offset, msg,
> +							    used);
> +				if (err) {
> +					/* Exception. Bailout! */
> +					if (!copied)
> +						copied =3D -EFAULT;
> +					break;
> +				}
> +			} else {
> +				if (!(flags & MSG_SOCK_DEVMEM)) {
> +					/* skb->devmem skbs can only be received
> +					 * with the MSG_SOCK_DEVMEM flag.
> +					 */
> +					if (!copied)
> +						copied =3D -EFAULT;
> +
> +					break;
> +				}
> +
> +				err =3D tcp_recvmsg_devmem(sk, skb, offset, msg,
> +							 used);
> +				if (err <=3D 0) {
> +					if (!copied)
> +						copied =3D -EFAULT;
> +
> +					break;
> +				}
> +				used =3D err;

Minor nit: I personally would find the above more readable, placing
this whole chunk in a single helper (e.g. the current
tcp_recvmsg_devmem(), renamed to something more appropriate).

Cheers,

Paolo


