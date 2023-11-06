Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C397E2CD1
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 20:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231773AbjKFT3v (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 14:29:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbjKFT3v (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 14:29:51 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39869C6
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 11:29:48 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id ada2fe7eead31-45d9b477f7bso1389221137.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 11:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699298987; x=1699903787; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7Si+k3SGcxGf6sJGMI/kj5eJZ6V+SjfPyFVm8vGoBA=;
        b=LqlReyfqOi5hTdMQbb+YXa8+g7KEHgzvrOt4dBaC2f3Fn1pp1kl+nekse8KlFM49ll
         k1tuf0NyoOUYtWmrTR/FzHfuh9VczuBtD4kwQ1iPmv4fzL4mguF1IZCyYtvZem/8ddqQ
         Vp7G1IGaHYgyO4r1YsHBD9G/4lN++Lcdrk907s0ZKDP0GdV4EgmL6mtDEx9g+Q6KZtKn
         cIcjMsIBNHNOhO3WChRAcKEWGKwbu0zQQHrgrmtiu+h1ugFZ8MsydbCgufcarunRAtQL
         O4WVSSFCdSmKRZ1XOdS2X+FDURpiHUl9/AYVD5GnqLQFqX2zWDQdnZUPySVTzzd8RQu5
         nVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699298987; x=1699903787;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7Si+k3SGcxGf6sJGMI/kj5eJZ6V+SjfPyFVm8vGoBA=;
        b=rUeAZDsIlwzLfyN9aSenFHlZt6AltyzicGSS8mXKnWTRRz0LBAfrf184OevBdIN4lo
         sH8q4mHW5c1c6wQqFjCw6bdMJfyhiTjaoSaTsCBqYk0EEP/cfvoLsGIKNvrSJiDnmRWz
         UpDtdmg9slNlHcVkMcDtGgaoJYyMi6fmeBu1uVgAwG2Xnscmr2Pyrye/pNC4xtPA4zDh
         4UMT/Ent1GXzdsqysE5SdTIWP9edln5dXzxHqjzEqvW0hEC/I/7xvHS6FIZNA1f7p6LJ
         3q9rqY48jPXMT4hqrvgCvZesKRR0tywnzdWpCYrnKbUjREjpHtto58dBhOti8jYVQwj8
         xiKA==
X-Gm-Message-State: AOJu0YzgrOWQiAWaZWYrSOu+S+cyYQTDwKRnPIpINIuSQ9VENvptrwdW
        rVOXTU2FdlZbhoCQQSJFgiQlGbTLjPVNPphZVqmCaw==
X-Google-Smtp-Source: AGHT+IG22F7RZ7INsRT61We/dhQuubrTDUtrXNKt9IRXUitWz7JbG7ca/qoY3u3vM4us0jqLVC7nFfmA8VO3BFOqiRY=
X-Received: by 2002:a67:a247:0:b0:45d:9083:f877 with SMTP id
 t7-20020a67a247000000b0045d9083f877mr7751422vsh.5.1699298986878; Mon, 06 Nov
 2023 11:29:46 -0800 (PST)
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
In-Reply-To: <ZUk0FGuJ28s1d9OX@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Mon, 6 Nov 2023 11:29:33 -0800
Message-ID: <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
To:     Stanislav Fomichev <sdf@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Ahern <dsahern@kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
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
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Nov 6, 2023 at 10:44=E2=80=AFAM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 11/05, Mina Almasry wrote:
> > In tcp_recvmsg_locked(), detect if the skb being received by the user
> > is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVME=
M
> > flag - pass it to tcp_recvmsg_devmem() for custom handling.
> >
> > tcp_recvmsg_devmem() copies any data in the skb header to the linear
> > buffer, and returns a cmsg to the user indicating the number of bytes
> > returned in the linear buffer.
> >
> > tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> > and returns to the user a cmsg_devmem indicating the location of the
> > data in the dmabuf device memory. cmsg_devmem contains this information=
:
> >
> > 1. the offset into the dmabuf where the payload starts. 'frag_offset'.
> > 2. the size of the frag. 'frag_size'.
> > 3. an opaque token 'frag_token' to return to the kernel when the buffer
> > is to be released.
> >
> > The pages awaiting freeing are stored in the newly added
> > sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> > This reference is dropped once the userspace indicates that it is
> > done reading this page.  All pages are released when the socket is
> > destroyed.
> >
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > Signed-off-by: Mina Almasry <almasrymina@google.com>
> >
> > ---
> >
> > RFC v3:
> > - Fixed issue with put_cmsg() failing silently.
> >
> > ---
> >  include/linux/socket.h            |   1 +
> >  include/net/page_pool/helpers.h   |   9 ++
> >  include/net/sock.h                |   2 +
> >  include/uapi/asm-generic/socket.h |   5 +
> >  include/uapi/linux/uio.h          |   6 +
> >  net/ipv4/tcp.c                    | 189 +++++++++++++++++++++++++++++-
> >  net/ipv4/tcp_ipv4.c               |   7 ++
> >  7 files changed, 214 insertions(+), 5 deletions(-)
> >
> > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > index cfcb7e2c3813..fe2b9e2081bb 100644
> > --- a/include/linux/socket.h
> > +++ b/include/linux/socket.h
> > @@ -326,6 +326,7 @@ struct ucred {
> >                                         * plain text and require encryp=
tion
> >                                         */
> >
> > +#define MSG_SOCK_DEVMEM 0x2000000    /* Receive devmem skbs as cmsg */
>
> Sharing the feedback that I've been providing internally on the public li=
st:
>

There may have been a miscommunication. I don't recall hearing this
specific feedback from you, at least in the last few months. Sorry if
it seemed like I'm ignoring feedback :)

> IMHO, we need a better UAPI to receive the tokens and give them back to
> the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> but look dated and hacky :-(
>
> We should either do some kind of user/kernel shared memory queue to
> receive/return the tokens (similar to what Jonathan was doing in his
> proposal?)

I'll take a look at Jonathan's proposal, sorry, I'm not immediately
familiar but I wanted to respond :-) But is the suggestion here to
build a new kernel-user communication channel primitive for the
purpose of passing the information in the devmem cmsg? IMHO that seems
like an overkill. Why add 100-200 lines of code to the kernel to add
something that can already be done with existing primitives? I don't
see anything concretely wrong with cmsg & setsockopt approach, and if
we switch to something I'd prefer to switch to an existing primitive
for simplicity?

The only other existing primitive to pass data outside of the linear
buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
preferred? Any other suggestions or existing primitives I'm not aware
of?

> or bite the bullet and switch to io_uring.
>

IMO io_uring & socket support are orthogonal, and one doesn't preclude
the other. As you know we like to use sockets and I believe there are
issues with io_uring adoption at Google that I'm not familiar with
(and could be wrong). I'm interested in exploring io_uring support as
a follow up but I think David Wei will be interested in io_uring
support as well anyway.

> I was also suggesting to do it via netlink initially, but it's probably
> a bit slow for these purpose, idk.

Yeah, I hear netlink is reserved for control paths and is
inappropriate for data path, but I'll let folks correct me if wrong.

--=20
Thanks,
Mina
