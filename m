Return-Path: <linux-arch+bounces-4565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A00358D2291
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 19:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 578DA28858A
	for <lists+linux-arch@lfdr.de>; Tue, 28 May 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DEC38F87;
	Tue, 28 May 2024 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F4p6t/tW"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77EE2E822
	for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716917817; cv=none; b=sGuqa9alVvb4wLgGsOfm4ENgmIcPEjXk4Ru2g8Za1ZjLNulVIr0PopWT//F+GQIRbqnOiz950HUjqMXGgiBp9JCjU3lgli4jdunVTohOHQwgqomsBRkFecuFnDmY+y2p+IBDP47nrxCgEXGghOvIvkRvgYoWtbYKjqx7gj8Z6fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716917817; c=relaxed/simple;
	bh=5jqpjWDjCYeF0iZMmfNh1F02B5hbFSGCHFwvks87kGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FglDXgoMx3y3R6J5vUduslz/HcYI2eLe1rY675fEQSfGQrbXy9O/qlzHeNFl/RQv1Vm1GL62d2V9AfM7JZbK2VNvlW6sTQkWX16vOETBCUb9Dm8ikKp43JhKqkDIOqNg2SCelmpEEHTLNA3t8KPl+iGm2DwrFP+e7D5fOYXWuTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F4p6t/tW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a6265d47c61so121249166b.0
        for <linux-arch@vger.kernel.org>; Tue, 28 May 2024 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716917813; x=1717522613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1nTYMe9Sz2kd146CNINlSxaoddIUqGPBCQrAMYzjnQ=;
        b=F4p6t/tWtjSOVYylJbwcLVV6UTyM4sNrgf29x/I2qiaXmlzGuSs/libx4uluVN+nqU
         Q1wu6ZyJ+t/J5G4TTactfmH72bg+9gQMI6XUV/JPUvIcgZPTSklK6xODqYbVvKUruZsd
         qGcZJqKk9SLen5tkhgx7pjnVQN79mjH/J3XY5cJYmSYfwEdHgeAgZgJLCWfItyd1aUlo
         m8SST44+ucTlAuYiprzs7++Q4aRuTHjVObQuxYwumcTSK42endimDnDiRHgNYuUyIKni
         X0y60pnKnN3oBLyeEGWlqJk5sfZxG3gqEzLBOt9HDhyBsgJwOczZkJZdgWzCHvs7ja5e
         tsGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716917813; x=1717522613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1nTYMe9Sz2kd146CNINlSxaoddIUqGPBCQrAMYzjnQ=;
        b=JR/7+gJdiye9sC6uTzkYtSWpPjui+MVFe8xXkEd2FxRXzyVa/SIvRM2zAr5CiO5gqR
         GYwnzuID58r9EnQLiTEsCRMku8yG/0u7/EbZBAErv+9HbNW7ot1Ba45ERphJHCT+2zAe
         G3BAGnIbhMhaZluliaeH9iugQ3SZqq1Tvi+7qnCFWbICZtvQROrzqjvNOhaTzmJk9HP5
         ZnsNt7yr6U6rvlug0dohz+Ks58U3A1PjcOnQ9ZthsQ2fvGkaAKVi9Tmd/AOwoCVDUYL0
         ASSl+6qAMmZRaWafqZwjx3vanY7bqLdy3IFVp+O8q1mn1uUeTpbzXz+/ShHWKa2NKuq9
         j6Ew==
X-Forwarded-Encrypted: i=1; AJvYcCW9ijg6bC+xH1CBATqVTB3VeU/JCuvGEzoeWU5T7puwPLiEVC/5mT8tiTJodBhXnczJiWHjikJf2sIo1s489lET+lHLW7jr9GwySA==
X-Gm-Message-State: AOJu0YyDTFuFgfLDyex6mU5Dv0w/YK2hiGnGYOcCRcwlUe5nv+EsD7Z6
	83CYGR7wK8J/692jJbN5ZjsT2ofPi1t+Yf79IHzSOQRVLk199niqC4Byxzxee2rRbDSAyzxHeyL
	Kwv7Z5l9uq7Obk1AIShgI/RepbXNp3W9R8gko
X-Google-Smtp-Source: AGHT+IFf32eXkuapluEvlBEyoJKJxifsmiVKQ0AvF4ow+8ygeGf1col+Xo1abUwIXzRnUJhSc+Yk6CUkl0RPaD3UYic=
X-Received: by 2002:a17:906:3c1a:b0:a63:42b6:1976 with SMTP id
 a640c23a62f3a-a6342b619f5mr156681366b.68.1716917812713; Tue, 28 May 2024
 10:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240510232128.1105145-1-almasrymina@google.com>
 <20240510232128.1105145-12-almasrymina@google.com> <9097e78d-0e7d-43bd-bafd-e53a4872a4d1@davidwei.uk>
In-Reply-To: <9097e78d-0e7d-43bd-bafd-e53a4872a4d1@davidwei.uk>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 28 May 2024 10:36:40 -0700
Message-ID: <CAHS8izOe-uYjm0ttQgHOFpvp_Tj4_oRHV6d1Y1sWJAZJdCdCBA@mail.gmail.com>
Subject: Re: [PATCH net-next v9 11/14] tcp: RX path for devmem TCP
To: David Wei <dw@davidwei.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, Donald Hunter <donald.hunter@gmail.com>, 
	Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Jonathan Corbet <corbet@lwn.net>, Richard Henderson <richard.henderson@linaro.org>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Shailend Chand <shailend@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:02=E2=80=AFPM David Wei <dw@davidwei.uk> wrote:
>
> On 2024-05-10 16:21, Mina Almasry wrote:
> > +/* On error, returns the -errno. On success, returns number of bytes s=
ent to the
> > + * user. May not consume all of @remaining_len.
> > + */
> > +static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *s=
kb,
> > +                           unsigned int offset, struct msghdr *msg,
> > +                           int remaining_len)
> > +{
> > +     struct dmabuf_cmsg dmabuf_cmsg =3D { 0 };
> > +     struct tcp_xa_pool tcp_xa_pool;
> > +     unsigned int start;
> > +     int i, copy, n;
> > +     int sent =3D 0;
> > +     int err =3D 0;
> > +
> > +     tcp_xa_pool.max =3D 0;
> > +     tcp_xa_pool.idx =3D 0;
> > +     do {
> > +             start =3D skb_headlen(skb);
> > +
> > +             if (skb_frags_readable(skb)) {
> > +                     err =3D -ENODEV;
> > +                     goto out;
> > +             }
> > +
> > +             /* Copy header. */
> > +             copy =3D start - offset;
> > +             if (copy > 0) {
> > +                     copy =3D min(copy, remaining_len);
> > +
> > +                     n =3D copy_to_iter(skb->data + offset, copy,
> > +                                      &msg->msg_iter);
> > +                     if (n !=3D copy) {
> > +                             err =3D -EFAULT;
> > +                             goto out;
> > +                     }
> > +
> > +                     offset +=3D copy;
> > +                     remaining_len -=3D copy;
> > +
> > +                     /* First a dmabuf_cmsg for # bytes copied to user
> > +                      * buffer.
> > +                      */
> > +                     memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
> > +                     dmabuf_cmsg.frag_size =3D copy;
> > +                     err =3D put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEA=
R,
> > +                                    sizeof(dmabuf_cmsg), &dmabuf_cmsg)=
;
> > +                     if (err || msg->msg_flags & MSG_CTRUNC) {
> > +                             msg->msg_flags &=3D ~MSG_CTRUNC;
> > +                             if (!err)
> > +                                     err =3D -ETOOSMALL;
> > +                             goto out;
> > +                     }
> > +
> > +                     sent +=3D copy;
> > +
> > +                     if (remaining_len =3D=3D 0)
> > +                             goto out;
> > +             }
> > +
> > +             /* after that, send information of dmabuf pages through a
> > +              * sequence of cmsg
> > +              */
> > +             for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> > +                     skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> > +                     struct net_iov *niov;
> > +                     u64 frag_offset;
> > +                     int end;
> > +
> > +                     /* !skb_frags_readable() should indicate that ALL=
 the
> > +                      * frags in this skb are dmabuf net_iovs. We're c=
hecking
> > +                      * for that flag above, but also check individual=
 frags
> > +                      * here. If the tcp stack is not setting
> > +                      * skb_frags_readable() correctly, we still don't=
 want
> > +                      * to crash here.
> > +                      */
> > +                     if (!skb_frag_net_iov(frag)) {
> > +                             net_err_ratelimited("Found non-dmabuf skb=
 with net_iov");
> > +                             err =3D -ENODEV;
> > +                             goto out;
> > +                     }
> > +
> > +                     niov =3D skb_frag_net_iov(frag);
>
> Sorry if we've already discussed this.
>
> We have this additional hunk:
>
> + if (niov->pp->mp_ops !=3D &dmabuf_devmem_ops) {
> +       err =3D -ENODEV;
> +       goto out;
> + }
>
> In case one of our skbs end up here, skb_frag_is_net_iov() and
> !skb_frags_readable(). Does this even matter? And if so then is there a
> better way to distinguish between our two types of net_iovs?

Thanks for bringing this up, yes, maybe we do need a way to
distinguish, but it's not 100% critical, no? It's mostly for debug
checking?

I would say add a helper, like net_iov_is_dmabuf() or net_iov_is_io_uring()=
.

Checking for niov->pp->mp_ops seems a bit hacky to me, and may be
outright broken. IIRC niov's can be disconnected from the page_pool
via page_pool_clear_pp_info(), and niov->pp may be null. Abstractly
speaking the niov type maybe should be a property of the niov itself,
and not the pp the niov is attached to.

It is not immediately obvious to me what the best thing to do here is,
maybe it's best to add a flag to niov or to use niov->pp_magic for
this.

I would humbly ask that your follow up patchset takes care of this
bit, if possible. I think mine is doing quite a bit of heavy lifting
as is (and I think may be close to ready?), when it comes to concerns
of devmem + io_uring coexisting if you're able to take care, awesome,
if not, I can look into squashing some fix.

--=20
Thanks,
Mina

