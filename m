Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 203F47E2F54
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 22:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbjKFV73 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 6 Nov 2023 16:59:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbjKFV72 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 6 Nov 2023 16:59:28 -0500
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD822D6E
        for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 13:59:25 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5af9b0850fdso67726547b3.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 13:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699307965; x=1699912765; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/OS6vf+Ea9868pF6WUQklf5sQIzoehkuuw8I4isih8k=;
        b=q7R2hLqxOeg4d7cR/V7l+C+qm4LG+cKcoow+QhOKmbUtlZ3ozB4Xye6ImEXIk6zwLF
         VhH2lh3IWYMGCDdRDhiWcDDOTcfkWZMq2blzvEe7OGhekWhwRRJk7etqc6VcSsDqBRSv
         tRdG+WNxQVVltV/n0oUR7IbJeg73zTXau5j6WBMRZ/bMjCnEf2fzLX5C99NZWaNYNVMf
         NGrFbwTt3rQy7+CLlOG55FBhSwcAnsNAgqA/QrYKSKHoG28qAymPQD3dEDCEspj9TMZN
         AaZMryVYl7TP9KS+j37s+iAnAPwSYu5obB2QLxvTIX5IiTdU2YlXbMb4WvxXQbtBM7Ph
         9nbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699307965; x=1699912765;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/OS6vf+Ea9868pF6WUQklf5sQIzoehkuuw8I4isih8k=;
        b=n0/fK9rcBdag/DiIznw7CyosLDAra0Vnu3xYLY9gLLoBtm8KFZykhq/+hI0CXjIW8j
         UD/S1EkjxzR5rta8gdQhxYvGL9MTi4xfl1MYT15+Mfndmv7/x0Dcu4JzSY6TsuDMP+wl
         G+IL4lR7EBmgzXoFo0+OYpxYrkc9yXuSnPdVwnfTVCDf8FV7hvwL6j/ISlD7F6KLY5tI
         Qud6Q/iAm9OnR/9LvJ4hXLbSRHIivqNpBbhiDGqVsVrCnB/ZxcWKOlj11HPS97qFC8CZ
         OdjjUJoKvM2D7PyfPs+DeKDXkbQadzRUkKlfXBZ9hGsAjyqAS+rZ3RgKpN2HUsKZcGyL
         rJdg==
X-Gm-Message-State: AOJu0Yz1dQxHuhLcK8v1CP6hJQjjdYYtrthehhS0NKaTxGH7SXsrsU0S
        D2lguQkQJq5RYRc5wc0aypvIGr0=
X-Google-Smtp-Source: AGHT+IGhUjiE9VDzMcTJJtqWXGx2vUkjJsBTjExgy9CurrNMa/qX+ungYvsZXoeu861drzM7daa6/X0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:9182:0:b0:5af:a9ab:e131 with SMTP id
 i124-20020a819182000000b005afa9abe131mr230853ywg.1.1699307964987; Mon, 06 Nov
 2023 13:59:24 -0800 (PST)
Date:   Mon, 6 Nov 2023 13:59:23 -0800
In-Reply-To: <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
Mime-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
Message-ID: <ZUlhu4hlTaqR3CTh@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From:   Stanislav Fomichev <sdf@google.com>
To:     Mina Almasry <almasrymina@google.com>
Cc:     David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org,
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 11/06, Mina Almasry wrote:
> On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kernel.org> =
wrote:
> >
> > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > On 11/05, Mina Almasry wrote:
> > >> For device memory TCP, we expect the skb headers to be available in =
host
> > >> memory for access, and we expect the skb frags to be in device memor=
y
> > >> and unaccessible to the host. We expect there to be no mixing and
> > >> matching of device memory frags (unaccessible) with host memory frag=
s
> > >> (accessible) in the same skb.
> > >>
> > >> Add a skb->devmem flag which indicates whether the frags in this skb
> > >> are device memory frags or not.
> > >>
> > >> __skb_fill_page_desc() now checks frags added to skbs for page_pool_=
iovs,
> > >> and marks the skb as skb->devmem accordingly.
> > >>
> > >> Add checks through the network stack to avoid accessing the frags of
> > >> devmem skbs and avoid coalescing devmem skbs with non devmem skbs.
> > >>
> > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > >>
> > >> ---
> > >>  include/linux/skbuff.h | 14 +++++++-
> > >>  include/net/tcp.h      |  5 +--
> > >>  net/core/datagram.c    |  6 ++++
> > >>  net/core/gro.c         |  5 ++-
> > >>  net/core/skbuff.c      | 77 ++++++++++++++++++++++++++++++++++++---=
---
> > >>  net/ipv4/tcp.c         |  6 ++++
> > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > >>  net/ipv4/tcp_output.c  |  5 ++-
> > >>  net/packet/af_packet.c |  4 +--
> > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > >>
> > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > >> index 1fae276c1353..8fb468ff8115 100644
> > >> --- a/include/linux/skbuff.h
> > >> +++ b/include/linux/skbuff.h
> > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > >>   *  @csum_level: indicates the number of consecutive checksums foun=
d in
> > >>   *          the packet minus one that have been verified as
> > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > >> + *  @devmem: indicates that all the fragments in this skb are backe=
d by
> > >> + *          device memory.
> > >>   *  @dst_pending_confirm: need to confirm neighbour
> > >>   *  @decrypted: Decrypted SKB
> > >>   *  @slow_gro: state present at GRO time, slower prepare step requi=
red
> > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > >>      __u8                    csum_not_inet:1;
> > >>  #endif
> > >> -
> > >> +    __u8                    devmem:1;
> > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> > >>      __u16                   tc_index;       /* traffic control inde=
x */
> > >>  #endif
> > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_manage=
d(struct sk_buff *skb)
> > >>              __skb_zcopy_downgrade_managed(skb);
> > >>  }
> > >>
> > >> +/* Return true if frags in this skb are not readable by the host. *=
/
> > >> +static inline bool skb_frags_not_readable(const struct sk_buff *skb=
)
> > >> +{
> > >> +    return skb->devmem;
> > >
> > > bikeshedding: should we also rename 'devmem' sk_buff flag to 'not_rea=
dable'?
> > > It better communicates the fact that the stack shouldn't dereference =
the
> > > frags (because it has 'devmem' fragments or for some other potential
> > > future reason).
> >
> > +1.
> >
> > Also, the flag on the skb is an optimization - a high level signal that
> > one or more frags is in unreadable memory. There is no requirement that
> > all of the frags are in the same memory type.

David: maybe there should be such a requirement (that they all are
unreadable)? Might be easier to support initially; we can relax later
on.

> The flag indicates that the skb contains all devmem dma-buf memory
> specifically, not generic 'not_readable' frags as the comment says:
>=20
> + *     @devmem: indicates that all the fragments in this skb are backed =
by
> + *             device memory.
>=20
> The reason it's not a generic 'not_readable' flag is because handing
> off a generic not_readable skb to the userspace is semantically not
> what we're doing. recvmsg() is augmented in this patch series to
> return a devmem skb to the user via a cmsg_devmem struct which refers
> specifically to the memory in the dma-buf. recvmsg() in this patch
> series is not augmented to give any 'not_readable' skb to the
> userspace.
>=20
> IMHO skb->devmem + an skb_frags_not_readable() as implemented is
> correct. If a new type of unreadable skbs are introduced to the stack,
> I imagine the stack would implement:
>=20
> 1. new header flag: skb->newmem
> 2.
>=20
> static inline bool skb_frags_not_readable(const struct skb_buff *skb)
> {
>     return skb->devmem || skb->newmem;
> }
>=20
> 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in this patch
> series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.

You copy it to the userspace in a special way because your frags
are page_is_page_pool_iov(). I agree with David, the skb bit is
just and optimization.

For most of the core stack, it doesn't matter why your skb is not
readable. For a few places where it matters (recvmsg?), you can
double-check your frags (all or some) with page_is_page_pool_iov.

Unrelated: we probably need socket to dmabuf association as well (via
netlink or something).
We are fundamentally receiving into and sending from a dmabuf (devmem =3D=
=3D
dmabuf).
And once you have this association, recvmsg shouldn't need any new
special flags.
