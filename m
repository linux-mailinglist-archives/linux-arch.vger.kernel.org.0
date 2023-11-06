Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F20DD7E2ED1
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 22:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjKFVSH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 16:18:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233121AbjKFVSF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 16:18:05 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A5710C0
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 13:18:01 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id d9443c01a7336-1cc23f2226bso33363725ad.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 13:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699305480; x=1699910280; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q+e/wl/IpkV0o6PDo9Tkqa7B1djQqq2R6AetcJyqBsw=;
        b=guQnzDNrQ0IEnDzO5hmG0IkO9uQpBsE3dQM3ouRmgcIUj8ovtjwTeObif9ZB0Nh1IL
         Ogw6bASCzlrDbxFB1Ig73mKR0hWGudoulglTPgsFRJei6ZPUavDy4CLE+hiAQ2wiPiVN
         JnVSSX6b0kXkG45BERqEsZABipd1zMRyVExPL5PbHvNDYjMHAKcAGZMk0PXvKxLwHz6D
         o2WL1O+bGCtEfRVE6g71WCK1G9uV763h8zt62FZGAOOnSjhBTeAFTbXE8POz71PKERm6
         IWsFEuPkzt4SAFAUIRJ2XlWdw05sk/Sqf7JtUTQINTH/G/eTA8goRYsvdbBmmRirOhKz
         7CLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699305480; x=1699910280;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Q+e/wl/IpkV0o6PDo9Tkqa7B1djQqq2R6AetcJyqBsw=;
        b=Pt8qL1KdOYfisdGCI0EWrmTxIQcCNWhVdkkWTGmzbVMoytHmdE53ZCLvL2A1H4wYhR
         0leeof2R9xdmxrYgLe2bb93ME+bCBMOqtHy3zUbAVs0KuhQGNEJvA1O5V0CjLHr5xqZ6
         49TyKtwOvdb+e64RZT6qtNoCnzi76K9ob0aUjqjBY9Avx7P+ZvpZGeM+rnQgcLxTL7yo
         3aFnRe/XOsmODg2UFmsFXj1dmZcBjTVOu3DrCt+XcIR7WNnXtClQFP52R5a3wkjyMJd+
         mCKGhofgFqOIpcOvxD0QPp8qO5R0TKwx4Fu50KzZnkrATauW5q3JhNA7Rg6+zJk1S1Yb
         BZRg==
X-Gm-Message-State: AOJu0YzEICZ5CxUmU1xOcfXItWbuxCsAwJQtwX5yw4vUX3Pz7pi34/xb
        fbY4NmGNg1jupfomq259b7uh3hc=
X-Google-Smtp-Source: AGHT+IFyUJONzj4do13pt+qQjhpP+paqIv/cmkYUyDep9IE9Z/JO/7Oa2cHBSiwtEe3VWLUwCJQwRDY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f809:b0:1cc:2a6f:ab91 with SMTP id
 ix9-20020a170902f80900b001cc2a6fab91mr467862plb.0.1699305480560; Mon, 06 Nov
 2023 13:18:00 -0800 (PST)
Date:   Mon, 6 Nov 2023 13:17:59 -0800
In-Reply-To: <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-11-almasrymina@google.com> <ZUk0FGuJ28s1d9OX@google.com>
 <CAHS8izNFv7r6vqYR_TYqcCuDO61F+nnNMhsSu=DrYWSr3sVgrA@mail.gmail.com>
Message-ID: <ZUlYB99GK1Q8is-I@google.com>
Subject: Re: [RFC PATCH v3 10/12] tcp: RX path for devmem TCP
From:   Stanislav Fomichev <sdf@google.com>
To:     Mina Almasry <almasrymina@google.com>
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
        "Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>,
        Shakeel Butt <shakeelb@google.com>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/06, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 10:44=E2=80=AFAM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On 11/05, Mina Almasry wrote:
> > > In tcp_recvmsg_locked(), detect if the skb being received by the user
> > > is a devmem skb. In this case - if the user provided the MSG_SOCK_DEV=
MEM
> > > flag - pass it to tcp_recvmsg_devmem() for custom handling.
> > >
> > > tcp_recvmsg_devmem() copies any data in the skb header to the linear
> > > buffer, and returns a cmsg to the user indicating the number of bytes
> > > returned in the linear buffer.
> > >
> > > tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frag=
s,
> > > and returns to the user a cmsg_devmem indicating the location of the
> > > data in the dmabuf device memory. cmsg_devmem contains this informati=
on:
> > >
> > > 1. the offset into the dmabuf where the payload starts. 'frag_offset'=
.
> > > 2. the size of the frag. 'frag_size'.
> > > 3. an opaque token 'frag_token' to return to the kernel when the buff=
er
> > > is to be released.
> > >
> > > The pages awaiting freeing are stored in the newly added
> > > sk->sk_user_pages, and each page passed to userspace is get_page()'d.
> > > This reference is dropped once the userspace indicates that it is
> > > done reading this page.  All pages are released when the socket is
> > > destroyed.
> > >
> > > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >
> > > ---
> > >
> > > RFC v3:
> > > - Fixed issue with put_cmsg() failing silently.
> > >
> > > ---
> > >  include/linux/socket.h            |   1 +
> > >  include/net/page_pool/helpers.h   |   9 ++
> > >  include/net/sock.h                |   2 +
> > >  include/uapi/asm-generic/socket.h |   5 +
> > >  include/uapi/linux/uio.h          |   6 +
> > >  net/ipv4/tcp.c                    | 189 ++++++++++++++++++++++++++++=
+-
> > >  net/ipv4/tcp_ipv4.c               |   7 ++
> > >  7 files changed, 214 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/include/linux/socket.h b/include/linux/socket.h
> > > index cfcb7e2c3813..fe2b9e2081bb 100644
> > > --- a/include/linux/socket.h
> > > +++ b/include/linux/socket.h
> > > @@ -326,6 +326,7 @@ struct ucred {
> > >                                         * plain text and require encr=
yption
> > >                                         */
> > >
> > > +#define MSG_SOCK_DEVMEM 0x2000000    /* Receive devmem skbs as cmsg =
*/
> >
> > Sharing the feedback that I've been providing internally on the public =
list:
> >
>=20
> There may have been a miscommunication. I don't recall hearing this
> specific feedback from you, at least in the last few months. Sorry if
> it seemed like I'm ignoring feedback :)

No worries, there was a thread long time ago about this whole token
interface and whether it should support out-of-order refills, etc.

> > IMHO, we need a better UAPI to receive the tokens and give them back to
> > the kernel. CMSG + setsockopt(SO_DEVMEM_DONTNEED) get the job done,
> > but look dated and hacky :-(
> >
> > We should either do some kind of user/kernel shared memory queue to
> > receive/return the tokens (similar to what Jonathan was doing in his
> > proposal?)
>=20
> I'll take a look at Jonathan's proposal, sorry, I'm not immediately
> familiar but I wanted to respond :-) But is the suggestion here to
> build a new kernel-user communication channel primitive for the
> purpose of passing the information in the devmem cmsg? IMHO that seems
> like an overkill. Why add 100-200 lines of code to the kernel to add
> something that can already be done with existing primitives? I don't
> see anything concretely wrong with cmsg & setsockopt approach, and if
> we switch to something I'd prefer to switch to an existing primitive
> for simplicity?
>=20
> The only other existing primitive to pass data outside of the linear
> buffer is the MSG_ERRQUEUE that is used for zerocopy. Is that
> preferred? Any other suggestions or existing primitives I'm not aware
> of?

I guess I'm just wondering whether other people have any suggestions
here. Not sure Jonathan's way was better, but we fundamentally
have two queues between the kernel and the userspace:
- userspace receiving tokens (recvmsg + magical flag)
- userspace refilling tokens (setsockopt + magical flag)

So having some kind of shared memory producer-consumer queue feels natural.
And using 'classic' socket api here feels like a stretch, idk.

But maybe I'm overthinking and overcomplicating :-)

> > or bite the bullet and switch to io_uring.
> >
>=20
> IMO io_uring & socket support are orthogonal, and one doesn't preclude
> the other. As you know we like to use sockets and I believe there are
> issues with io_uring adoption at Google that I'm not familiar with
> (and could be wrong). I'm interested in exploring io_uring support as
> a follow up but I think David Wei will be interested in io_uring
> support as well anyway.

Ack, might be one more reason on our side to adopt iouring :-p

> > I was also suggesting to do it via netlink initially, but it's probably
> > a bit slow for these purpose, idk.
>=20
> Yeah, I hear netlink is reserved for control paths and is
> inappropriate for data path, but I'll let folks correct me if wrong.
>=20
> --=20
> Thanks,
> Mina
