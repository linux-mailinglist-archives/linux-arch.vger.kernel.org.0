Return-Path: <linux-arch+bounces-60-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE667E496C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 20:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FBDEB20FC4
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC43136B03;
	Tue,  7 Nov 2023 19:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a5TJirnG"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D30C328BE
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 19:53:38 +0000 (UTC)
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E0B8D7C
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 11:53:37 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7b6cd2afaf2so2720472241.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 11:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699386816; x=1699991616; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tnuTqDfsVwYZum4mgCN3P8a9mRjXV0bf7p3FmGowjyI=;
        b=a5TJirnGDnG5vS2j1RCuf6MxnsaEHGicNgGIKWYcB3F8RYwOQsSocoB+ks/0cTDSgx
         pzh+qIOA+n9uAw0FHi0H/NmSmzeMQCvKVLRYWsIZbQv/9dYbQAsgvPjTh+x1qV1hIqhg
         +XCxxBCpHvwI0n5/oqKnyuGSxaSVuj2eEBUtciWoxYx5cQZnrkNnhDKtP/Iwp6ZcNj5w
         gKdzr3iabJumXACkbamfbA2nTi7SUE+v7LyRVHt4DStEYWy0Wi5nnXTQaZn/Y6oC4A5/
         pQT5IiM3eB7wAEwEpJXGHGmB2JUJ75AwhN+Gu1JTwHpCWQoUQIkIrR+hvAKye3Or8lxj
         BeSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699386816; x=1699991616;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tnuTqDfsVwYZum4mgCN3P8a9mRjXV0bf7p3FmGowjyI=;
        b=Vnhzdlr8PidXRufPAyCBDpVEbOxJmPLZJ891L9KhxmuY/CM9GPwXOcmQ9Zf9bsaS0/
         KetTHK76n/Np/Whb3ZZUurFc5ar++F/jl8AURQaldx/79a33FdkjPJsFIv81QpNxgLEW
         nyfWrEZXMEi6LuiR8GNQMyNYOoBvmBq3j9+dJp3TatKcBvldahgl7S3p+KUtUg8hvENT
         r8eqNp0IOQEX77TQvzo2LSZn+WllJpLij3oZFB50g+MQscwlm5wp47cx86UOgnmNjudV
         S7wTz0UcLOaHIVKrsou9zEo4SgUH/2UkCjJJECZiMTc4kdrc78lGfkkT0rDyawqD+cr5
         NvEg==
X-Gm-Message-State: AOJu0Yw6Au1AlkKQotd/mcqIxn8ySvORY4VVwiT1PGvul0ie0PTRnzpX
	sbM36Wc/L3X6oqFGfJilPURzLhAWziGDkhdc5ZD0NNRYqs4g2FB+MoQ=
X-Google-Smtp-Source: AGHT+IFRfpykRqgBWNCOXyp4/VIT9n7OcqngEslUuXORQ+jDqZ50qQ8GNzo4lC3gCBtUGRfNYYENwfnNi6aElAPXvi8=
X-Received: by 2002:a05:6102:475a:b0:45d:86d0:27 with SMTP id
 ej26-20020a056102475a00b0045d86d00027mr11736495vsb.33.1699386816008; Tue, 07
 Nov 2023 11:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com> <ZUmNk98LyO_Ntcy7@google.com>
In-Reply-To: <ZUmNk98LyO_Ntcy7@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Tue, 7 Nov 2023 11:53:22 -0800
Message-ID: <CAHS8izNTDsHTahkd17zQVQnjzniZAk-dKNs-Mq0E4shdrXOJbg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Stanislav Fomichev <sdf@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 5:06=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
[..]
> > > > And the socket has to know this association; otherwise those tokens
> > > > are useless since they don't carry anything to identify the dmabuf.
> > > >
> > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is tha=
t
> > > > it somehow implies that I have an option of passing or not passing =
it
> > > > for an individual system call.
> >
> > You do have the option of passing it or not passing it per system
> > call. The MSG_SOCK_DEVMEM says the application is willing to receive
> > devmem cmsgs - that's all. The application doesn't get to decide
> > whether it's actually going to receive a devmem cmsg or not, because
> > that's dictated by the type of skb that is present in the receive
> > queue, and not up to the application. I should explain this in the
> > commit message...
>
> What would be the case of passing it or not passing it? Some fallback to
> the host memory after flow steering update? Yeah, would be useful to
> document those constrains. I'd lean on starting stricter and relaxing
> those conditions if we find the use-cases.
>

MSG_SOCK_DEVMEM (or its replacement SOCK_DEVMEM or SO_SOCK_DEVMEM),
just says that the application is able to receive devmem cmsgs and
will parse them. The use case for not setting that flag is existing
applications that are not aware of devmem cmsgs. I don't want those
applications to think they're receiving data in the linear buffer only
to find out that the data is in devmem and they ignored the devmem
cmsg.

So, what happens:

- MSG_SOCK_DEVMEM provided and next skb in the queue is devmem:
application receives cmsgs.
- MSG_SOCK_DEVMEM provided and next skb in the queue is non-devmem:
application receives in the linear buffer.
- MSG_SOCK_DEVMEM not provided and net skb is devmem: application
receives EFAULT.
- MSG_SOCK_DEVMEM not provided and next skb is non-devmem: application
receives in the linear buffer.

My bad on not including some docs about this. The next version should
have the commit message beefed up to explain all this, or a docs
patch.


--=20
Thanks,
Mina

