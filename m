Return-Path: <linux-arch+bounces-5015-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FB2912E83
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 22:32:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B2EE1F21F24
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2024 20:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF717BB26;
	Fri, 21 Jun 2024 20:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a1aBUw0V"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7488917BB15
	for <linux-arch@vger.kernel.org>; Fri, 21 Jun 2024 20:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719001907; cv=none; b=iXCwNOpfnULYzaAmZF7LjtEU1JwCuAgcUsP2cmiqYxT5uhCitO9MpKRj0/+VaSzhdg1UNPca1J600YRHk/W7kLdBCwGfFwlc42/oiLqfTz2IDz10aY9/Ms6IxiIKRDo4kp7wX7Eg8FQ/YdXiNXCfqnZGzD2W20XNvfpTwQdsxZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719001907; c=relaxed/simple;
	bh=J/WeQifhAeBIIgjlkHp6YVizjCJ078ih4ojm5iVrUNI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgl5UnAawW7MGqFdas8QcskLcIcnP64FzrmTjIoqYUkZ0Tymr87S1vfcyBIMoFqZAVYzM2PtTtB9IX7NHD5Q54pSaHo1Z3P3LK0Gk/znvvkxsKs6cVAvOgHkI+RpWm3M/1kwiHj/jtkPKM0Sjex1BtOqyO6NSoFb+tMlle8kIRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a1aBUw0V; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a6fd513f18bso105762866b.3
        for <linux-arch@vger.kernel.org>; Fri, 21 Jun 2024 13:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719001904; x=1719606704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnCN0NXOSNtwy42IdVdysfTTD5ti/ff9XMDOhhfiLx4=;
        b=a1aBUw0VkzZ3oSHlCqDR+ATOXDYi+sX+izSgTyOwlIGSfvtoki8ooXg63v6L0Z3SBf
         KiyzZ1pJvQ1WWzksNTFwyyeoqTssrN8S10fKlK5s9S/d//Xvdx2XwzEhza32lsyerNAI
         rrRvIQQqKXdtV/r5lndW2K+6e9aaYnNAPI/MpYaRwcXuVF5DzUOzTrBFgxEDNxedSwyv
         BDdLcthc9hfrnKRIXR37CCa55VW1UJHSxCushckLKFvJozqRZelHSsccnM0cLejLlUU3
         IKIynf0IwbAzXqvQqepVmjQ/q13kNtP0V4e9VpvIE+GxavHiACiAIZqmCNhoB7dnJzlU
         DDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719001904; x=1719606704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CnCN0NXOSNtwy42IdVdysfTTD5ti/ff9XMDOhhfiLx4=;
        b=SOYdBeP3836w0f9qzXsrN2NTC0t9FuDyjzkrgYz9J0F3pCa3keKZamkRnvP+tWpXHr
         oZ+I0XT+Y6sq74ViI8mxgzFc2N76EsLpK+h64unBgGHKlIdAIsMvEFT0bWz8sHoW2+jB
         paij6EkqhC4PLRTKpnXM87OFtajm1ZHQz5LEL/cHP1xtE7XlsP7BLJVGDj8Hvue35l3T
         XKQs1fTQSuhkPEFAT9NgZ4EePmJKyGexj3RFA4tc/Na4o30+35ISa4qJCczLzMDdqCq5
         fn8FmO/uAGRkwKGr9+z3A4D7aBQEa2SpwbRqTN0IehjYd98NX/tZT/AiTzFQ8tTNTUnE
         5A6w==
X-Forwarded-Encrypted: i=1; AJvYcCVxc2pKfO4Pqon3KvD0e2/ixuP9SCsMH3RSbFv9yJu+/8zLgaZauSSK18TZgMuKFyJ5lDUzPxlRsiP+Y/KcjvoyXXMuZdJL2YbakA==
X-Gm-Message-State: AOJu0YxKbsnI9H4CbcjVhPnwX4yc/qnFCTgqfDRgbZASk3mnUa92T8Xf
	TGzHDBTgCaKxCrAx2ipxwilg62co0oGDqaARlRzWqE6e7lHd0Vo0i2b/VkhxwguHItluVpB4/0f
	/OS5T4n/KM9tjrpeavSyMUaD2al2lfSjXh7w4
X-Google-Smtp-Source: AGHT+IH800HqMIWMw3Gfm64r6WN21nh+bezjnNGagk7G9R1DzDSpY7p4WYQEQWPwKzYCAyy4hb9MTRJUxXOTUM+VMbg=
X-Received: by 2002:a17:906:f349:b0:a6f:49eb:31a5 with SMTP id
 a640c23a62f3a-a6fab7d0b64mr465681666b.77.1719001903259; Fri, 21 Jun 2024
 13:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613013557.1169171-1-almasrymina@google.com>
 <20240613013557.1169171-11-almasrymina@google.com> <20a6a727-d9f2-495c-bf75-72c27740dd82@gmail.com>
In-Reply-To: <20a6a727-d9f2-495c-bf75-72c27740dd82@gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 21 Jun 2024 13:31:29 -0700
Message-ID: <CAHS8izMce36FwLhFB0znHQYmxpe5hmTSXtZA7+b5VsmSJUfhRw@mail.gmail.com>
Subject: Re: [PATCH net-next v12 10/13] tcp: RX path for devmem TCP
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Sergey Shtylyov <s.shtylyov@omp.ru>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 9:36=E2=80=AFAM Pavel Begunkov <asml.silence@gmail.=
com> wrote:
>
> On 6/13/24 02:35, Mina Almasry wrote:
> >
> > The pages awaiting freeing are stored in the newly added
> > sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> > This reference is dropped once the userspace indicates that it is
> > done reading this page.  All pages are released when the socket is
> > destroyed.
>
> One small concern is that if the pool gets destroyed (i.e.
> page_pool_destroy) before sockets holding netiov, page pool will
> semi-busily poll until the sockets die or such and will spam with
> pr_warn(). E.g. when a user drops the nl but leaks data sockets
> and continues with its userspace business. You can probably do
> it in a loop and create dozens of such pending
> page_pool_release_retry().
>

Yes, true, but this is not really an issue with netiovs per se, it's a
quirk with the page_pool in general. If a non-devmem page_pool is
destroyed while there are pages waiting in the receive queues to be
recvmsg'd, the behavior you described happens anyway AFAIU.

Jakub did some work to improve this. IIRC he disabled the regular
warning and he reparents the orphan page_pools so they appear in the
stats of his netlink API.

Since this is behavior already applying to pages, I did not seek to
improve it as I add devmem support, I just retain it. We could improve
it in a separate patchset, but I do not see this behavior as a
critical issue really, especially since the alarming pr_warn has been
removed.

> > +static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> > +                           unsigned int max_frags)
> > +{
> > +     int err, k;
> > +
> > +     if (p->idx < p->max)
> > +             return 0;
> > +
> > +     xa_lock_bh(&sk->sk_user_frags);
> > +
> > +     tcp_xa_pool_commit_locked(sk, p);
> > +
> > +     for (k =3D 0; k < max_frags; k++) {
> > +             err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> > +                              XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
> > +             if (err)
> > +                     break;
> > +     }
> > +
> > +     xa_unlock_bh(&sk->sk_user_frags);
> > +
> > +     p->max =3D k;
> > +     p->idx =3D 0;
> > +     return k ? 0 : err;
> > +}
>
> Personally, I'd prefer this optimisation to be in a separate patch,
> especially since there is some degree of hackiness to it.
>
>

To be honest this optimization is very necessary from my POV. We ran
into real production problems due to the excessive locking when we use
regular xa_alloc(), and Eric implemented this optimization to resolve
that. I simply squashed the optimization for this upstream series.

If absolutely necessary I can refactor it into a separate patch or
carry the optimization locally, but this seems like a problem everyone
looking to use devmem TCP will re-discover, so probably worth just
having here?

> > +             /* if remaining_len is not satisfied yet, we need to go t=
o the
> > +              * next frag in the frag_list to satisfy remaining_len.
> > +              */
> > +             skb =3D skb_shinfo(skb)->frag_list ?: skb->next;
> > +
> > +             offset =3D offset - start;
>
> It's an offset into the current skb, isn't it? Wouldn't
> offset =3D 0; be less confusing?
>

Seems so, AFAICT. Let me try to apply this and see if it trips up any tests=
.

> > +     } while (skb);
> > +
> > +     if (remaining_len) {
> > +             err =3D -EFAULT;
> > +             goto out;
> > +     }
>
> Having data left is not a fault,

I think it is. The caller of tcp_recvmsg_dmabuf() expects all of
remaining_len to be used up, otherwise it messes up with the math in
the caller. __skb_datagram_iter(), which is the equivalent to this one
for pages, regards having left over data as a fault and also returns
-EFAULT, AFAICT.

> and to get here you
> need to get an skb with no data left, which shouldn't
> happen. Seems like everything you need is covered by
> the "!sent" check below.
>

I think we can get here if we run out of skbs with data, no?

> > @@ -2503,6 +2504,15 @@ static void tcp_md5sig_info_free_rcu(struct rcu_=
head *head)
> >   void tcp_v4_destroy_sock(struct sock *sk)
> >   {
> >       struct tcp_sock *tp =3D tcp_sk(sk);
> > +     __maybe_unused unsigned long index;
> > +     __maybe_unused void *netmem;
>
> How about adding a function to get rid of __maybe_unused?.
>
> static void sock_release_devmem_frags() {
> #ifdef PP
>         unsigned index;
>         ...
> #endif PP
> }
>

Will do.

> Also, even though you wire it up for TCP, since ->sk_user_frags
> is in struct sock I'd expect the release to be somewhere in the
> generic sock path like __sk_destruct(), and same for init.
> Perhpas, it's better to leave it for later.
>


--=20
Thanks,
Mina

