Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1DA17E3033
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbjKFW4I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 17:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233145AbjKFW4H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 17:56:07 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E526510D;
        Mon,  6 Nov 2023 14:56:02 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id a1e0cc1a2514c-7bae0c07007so805773241.1;
        Mon, 06 Nov 2023 14:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699311362; x=1699916162; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/wEW+J+MMgAFeh8Mzz47HGE59Py4EtdOuMSKU4I6zWM=;
        b=Y9OqlAdVdfCWM1s4oJdvDwokwM/6M6NpqsO7qIVwY6hn09+wKqlqBlj3lxsB8g8lGD
         GiERG4iah8VsJwiBQm15HLrHqn/Tby73UreqQeYN8fRGwXG0/Vzhcfq/iA2qXEu4w3CF
         1VqmDoVZubSrUHtaBx9o05L/g/v2z85yvRT9jmtepvMvEov2em1J8b/39pEAXX3SZKu6
         ZMsl4SfULVO4IZY6FiaXuELWr0+nI0F3T3lq6Lh/dZwMAhzKCHzG+1Vy/N4JKU4ryqXU
         7ZoQaz1M7WVKj0iGdJHpx2UW6KY3vr3dLFoMRhGRpmUQ65Hu1gdFzY/RtPgJof/xagwo
         yNSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699311362; x=1699916162;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/wEW+J+MMgAFeh8Mzz47HGE59Py4EtdOuMSKU4I6zWM=;
        b=dxA4mDKTXXYMfvOsPeGbPIlC5+ZU5/fAK9I/U8lmxfSd57TRkszd1GYT4mG9GeDMxC
         N9s+5+XA27JgD+411arAoCdSt/c0iwUK16ryT85n7kT/suFxWOlDToXXKu4JEusFuJqE
         etYb9qFUiv21DyWVAYezZK50OPlJyLzhCaP03ex6K6UrA9qmmUlntJj5rk3n2Xwf5zme
         JJRE8q05tvbEv6u5cOHkJkwE8hw8nm4tpVbdrST1JPk6W5qYsg0gt5r7uZZ0fYitmo+w
         6CIx+6wq5UgvMJiHIsjemG494tnuzwLaGbEzTeaX2bB2DgpzI7VktAPeSw75je4xHXqF
         IzSw==
X-Gm-Message-State: AOJu0YwLS+1qhQcgzcyhyxd6+1JTR4j+Oa/rKfrpQytARemjGJuWa7OU
        0hye8q0/OwrAZ5JF83qgOzX7FqJIZgBvrykHtTM=
X-Google-Smtp-Source: AGHT+IGJLbY16cPvyvbTXphGTN+7ucINqF5flr9mxxCiuhAJxLJ/TQnck4EFEyL23m987XVAKWsGDAUf4sPH+q33ho4=
X-Received: by 2002:a67:b042:0:b0:452:94a4:9c59 with SMTP id
 q2-20020a67b042000000b0045294a49c59mr19989020vsh.10.1699311361745; Mon, 06
 Nov 2023 14:56:01 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
 <CAF=yD-+MFpO5Hdqn+Q9X54SBpgcBeJvKTRD53X2oM4s8uVqnAQ@mail.gmail.com> <ZUlp8XutSAScKs_0@google.com>
In-Reply-To: <ZUlp8XutSAScKs_0@google.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Mon, 6 Nov 2023 14:55:24 -0800
Message-ID: <CAF=yD-JZ88j+44MYgX-=oYJngz4Z0zw6Y0V3nHXisZJtNu7q6A@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To:     Stanislav Fomichev <sdf@google.com>
Cc:     Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 6, 2023 at 2:34=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 11/06, Willem de Bruijn wrote:
> > > > IMHO, we need a better UAPI to receive the tokens and give them bac=
k to
> > > > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> > > > but look dated and hacky :-(
> > > >
> > > > We should either do some kind of user/kernel shared memory queue to
> > > > receive/return the tokens (similar to what Jonathan was doing in hi=
s
> > > > proposal?)
> > >
> > > I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> > > familiar but I wanted to respond :-) But is the suggestion here to
> > > build a new kernel-user communication channel primitive for the
> > > purpose of passing the information in the devmem cmsg? IMHO that seem=
s
> > > like an overkill. Why add 100-200 lines of code to the kernel to add
> > > something that can already be done with existing primitives? I don't
> > > see anything concretely wrong with cmsg & setsockopt approach, and if
> > > we switch to something I'd prefer to switch to an existing primitive
> > > for simplicity?
> > >
> > > The only other existing primitive to pass data outside of the linear
> > > buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> > > preferred? Any other suggestions or existing primitives I'm not aware
> > > of?
> > >
> > > > or bite the bullet and switch to io_uring.
> > > >
> > >
> > > IMO io_uring & socket support are orthogonal, and one doesn't preclud=
e
> > > the other. As you know we like to use sockets and I believe there are
> > > issues with io_uring adoption at Google that I'm not familiar with
> > > (and could be wrong). I'm interested in exploring io_uring support as
> > > a follow up but I think David Wei will be interested in io_uring
> > > support as well anyway.
> >
> > I also disagree that we need to replace a standard socket interface
> > with something "faster", in quotes.
> >
> > This interface is not the bottleneck to the target workload.
> >
> > Replacing the synchronous sockets interface with something more
> > performant for workloads where it is, is an orthogonal challenge.
> > However we do that, I think that traditional sockets should continue
> > to be supported.
> >
> > The feature may already even work with io_uring, as both recvmsg with
> > cmsg and setsockopt have io_uring support now.
>
> I'm not really concerned with faster. I would prefer something cleaner :-=
)
>
> Or maybe we should just have it documented. With some kind of path
> towards beautiful world where we can create dynamic queues..

I suppose we just disagree on the elegance of the API.

The concise notification API returns tokens as a range for
compression, encoding as two 32-bit unsigned integers start + length.
It allows for even further batching by returning multiple such ranges
in a single call.

This is analogous to the MSG_ZEROCOPY notification mechanism from
kernel to user.

The synchronous socket syscall interface can be replaced by something
asynchronous like io_uring. This already works today? Whatever
asynchronous ring-based API would be selected, io_uring or otherwise,
I think the concise notification encoding would remain as is.

Since this is an operation on a socket, I find a setsockopt the
fitting interface.
