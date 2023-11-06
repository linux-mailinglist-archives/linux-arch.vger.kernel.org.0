Return-Path: <linux-arch+bounces-1-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BC97E3161
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38B61280F12
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0832F506;
	Mon,  6 Nov 2023 23:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UFRTSsVA"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931252EB0A
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:27:59 +0000 (UTC)
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3D510F0
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 15:27:54 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3b2ea7cc821so3261552b6e.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 15:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699313273; x=1699918073; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oyBgh+zEqvzqf0dBlal8b/uizmWNW97SzNAlzA3P/rc=;
        b=UFRTSsVAyYiaVbAINwh+/3wkFktr6RU2IJ1X7RIgHR/BNCK0lcZASdQOVK7tlQnzwg
         cuRbcwTGKK4IRRPvvRkP6ehcaY9xTGEZb8xatSO3f196uRkxbT/mDNkKiiJ3pLwBIaFE
         YDRCf56uJPbuSFCLjJA+IZX91h9f3bWdGorCuwq7isVDyiCggo7BFrgz3tG93c2pvyiZ
         baUniTye6YI+6Ht6oeBOWSvZcJebII2XWrV3lUmI6bI5pT6MiXTRWeGb1SWwFhJFq+4H
         7ml00SLW+XQ58TjfyYCDJgkWiJg8QFOVcSH56b4AoLSs+xR/rfNh1ta1LC81ql9/My43
         cxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699313273; x=1699918073;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oyBgh+zEqvzqf0dBlal8b/uizmWNW97SzNAlzA3P/rc=;
        b=if+7BUfNtO10/AG1cxLz+LP2TUNoi3pPIoTFQp4SJnzpo0uRz2Iip2JQKvxArcMm5O
         USQIY7IN8XtW+D2Oj3h+yYBPDCiGUAkEyPn+6aYbRk612eM/Dl1ghJtlsaeomINCShv4
         ma27pI6z0iGFOnDomwclPcrKtSeiIirBzcr5j6fSC1FYXg5BE0NngCQJUL7/CBx+5E1H
         /+Uo08A+ATggIkBI7lI5v1kxfadZGPWr2Na4lPPVMZ1lbP+ZSQgFLrnnN7zaa6uEKvqU
         fiSE8KoNw4CK7Mbb+IJ0GEmkOQ1kyVTq6s4UQXGT3Z8YLmziGsBLJWz9/g2ZFz6zN4Fo
         9ypw==
X-Gm-Message-State: AOJu0Yy9NIyUlisKK06Fp4tfKUj0u1NySfdm0dLv5iiI3tlY61Lc5YdO
	0T7QFs2+CRxwoMdpqab6+oakQGkE0/yJFJCQL1KpZDakHTZOcFqfN9GE7A==
X-Google-Smtp-Source: AGHT+IG59kPBd3u1YDLzyUJBeB7FlEZKtBj0ageMZxiI9VbXckY1biWa86oVt9rMTTU8zWrU/TgHQTYgQyBEzAjUIkY=
X-Received: by 2002:a05:6808:150d:b0:3b5:75d5:696d with SMTP id
 u13-20020a056808150d00b003b575d5696dmr20309651oiw.44.1699313273312; Mon, 06
 Nov 2023 15:27:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231106024413.2801438-1-almasrymina@google.com>
 <20231106024413.2801438-10-almasrymina@google.com> <ZUk03DhWxV-bOFJL@google.com>
 <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org> <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com>
In-Reply-To: <ZUlvzm24SA3YjirV@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 15:27:40 -0800
Message-ID: <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Stanislav Fomichev <sdf@google.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On 11/06, Mina Almasry wrote:
> > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On 11/06, Mina Almasry wrote:
> > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kernel=
.org> wrote:
> > > > >
> > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > On 11/05, Mina Almasry wrote:
> > > > > >> For device memory TCP, we expect the skb headers to be availab=
le in host
> > > > > >> memory for access, and we expect the skb frags to be in device=
 memory
> > > > > >> and unaccessible to the host. We expect there to be no mixing =
and
> > > > > >> matching of device memory frags (unaccessible) with host memor=
y frags
> > > > > >> (accessible) in the same skb.
> > > > > >>
> > > > > >> Add a skb->devmem flag which indicates whether the frags in th=
is skb
> > > > > >> are device memory frags or not.
> > > > > >>
> > > > > >> __skb_fill_page_desc() now checks frags added to skbs for page=
_pool_iovs,
> > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > >>
> > > > > >> Add checks through the network stack to avoid accessing the fr=
ags of
> > > > > >> devmem skbs and avoid coalescing devmem skbs with non devmem s=
kbs.
> > > > > >>
> > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > >>
> > > > > >> ---
> > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > >>  include/net/tcp.h      |  5 +--
> > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > >>  net/core/gro.c         |  5 ++-
> > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++++++++++=
+++------
> > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > >>
> > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > >> --- a/include/linux/skbuff.h
> > > > > >> +++ b/include/linux/skbuff.h
> > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > > > > >>   *  @csum_level: indicates the number of consecutive checksum=
s found in
> > > > > >>   *          the packet minus one that have been verified as
> > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > >> + *  @devmem: indicates that all the fragments in this skb are=
 backed by
> > > > > >> + *          device memory.
> > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > >>   *  @decrypted: Decrypted SKB
> > > > > >>   *  @slow_gro: state present at GRO time, slower prepare step=
 required
> > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > >>      __u8                    csum_not_inet:1;
> > > > > >>  #endif
> > > > > >> -
> > > > > >> +    __u8                    devmem:1;
> > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> > > > > >>      __u16                   tc_index;       /* traffic contro=
l index */
> > > > > >>  #endif
> > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrade_=
managed(struct sk_buff *skb)
> > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > >>  }
> > > > > >>
> > > > > >> +/* Return true if frags in this skb are not readable by the h=
ost. */
> > > > > >> +static inline bool skb_frags_not_readable(const struct sk_buf=
f *skb)
> > > > > >> +{
> > > > > >> +    return skb->devmem;
> > > > > >
> > > > > > bikeshedding: should we also rename 'devmem' sk_buff flag to 'n=
ot_readable'?
> > > > > > It better communicates the fact that the stack shouldn't derefe=
rence the
> > > > > > frags (because it has 'devmem' fragments or for some other pote=
ntial
> > > > > > future reason).
> > > > >
> > > > > +1.
> > > > >
> > > > > Also, the flag on the skb is an optimization - a high level signa=
l that
> > > > > one or more frags is in unreadable memory. There is no requiremen=
t that
> > > > > all of the frags are in the same memory type.
> > >
> > > David: maybe there should be such a requirement (that they all are
> > > unreadable)? Might be easier to support initially; we can relax later
> > > on.
> > >
> >
> > Currently devmem =3D=3D not_readable, and the restriction is that all t=
he
> > frags in the same skb must be either all readable or all unreadable
> > (all devmem or all non-devmem).
> >
> > > > The flag indicates that the skb contains all devmem dma-buf memory
> > > > specifically, not generic 'not_readable' frags as the comment says:
> > > >
> > > > + *     @devmem: indicates that all the fragments in this skb are b=
acked by
> > > > + *             device memory.
> > > >
> > > > The reason it's not a generic 'not_readable' flag is because handin=
g
> > > > off a generic not_readable skb to the userspace is semantically not
> > > > what we're doing. recvmsg() is augmented in this patch series to
> > > > return a devmem skb to the user via a cmsg_devmem struct which refe=
rs
> > > > specifically to the memory in the dma-buf. recvmsg() in this patch
> > > > series is not augmented to give any 'not_readable' skb to the
> > > > userspace.
> > > >
> > > > IMHO skb->devmem + an skb_frags_not_readable() as implemented is
> > > > correct. If a new type of unreadable skbs are introduced to the sta=
ck,
> > > > I imagine the stack would implement:
> > > >
> > > > 1. new header flag: skb->newmem
> > > > 2.
> > > >
> > > > static inline bool skb_frags_not_readable(const struct skb_buff *sk=
b)
> > > > {
> > > >     return skb->devmem || skb->newmem;
> > > > }
> > > >
> > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in this pa=
tch
> > > > series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.
> > >
> > > You copy it to the userspace in a special way because your frags
> > > are page_is_page_pool_iov(). I agree with David, the skb bit is
> > > just and optimization.
> > >
> > > For most of the core stack, it doesn't matter why your skb is not
> > > readable. For a few places where it matters (recvmsg?), you can
> > > double-check your frags (all or some) with page_is_page_pool_iov.
> > >
> >
> > I see, we can do that then. I.e. make the header flag 'not_readable'
> > and check the frags to decide to delegate to tcp_recvmsg_devmem() or
> > something else. We can even assume not_readable =3D=3D devmem because
> > currently devmem is the only type of unreadable frag currently.
> >
> > > Unrelated: we probably need socket to dmabuf association as well (via
> > > netlink or something).
> >
> > Not sure this is possible. The dma-buf is bound to the rx-queue, and
> > any packets that land on that rx-queue are bound to that dma-buf,
> > regardless of which socket that packet belongs to. So the association
> > IMO must be rx-queue to dma-buf, not socket to dma-buf.
>
> But there is still always 1 dmabuf to 1 socket association (on rx), right=
?
> Because otherwise, there is no way currently to tell, at recvmsg, which
> dmabuf the received token belongs to.
>

Yes, but this 1 dma-buf to 1 socket association happens because the
user binds the dma-buf to an rx-queue and configures flow steering of
the socket to that rx-queue.

> So why not have a separate control channel action to say: this socket fd
> is supposed to receive into this dmabuf fd?
> This action would put
> the socket into permanent 'MSG_SOCK_DEVMEM' mode. Maybe you can also
> put some checks at the lower level to to enforce this dmabuf
> association. (to avoid any potential issues with flow steering)
>

setsockopt(SO_DEVMEM_ASSERT_DMA_BUF, dmabuf_fd)? Sounds interesting,
but maybe a bit of a weird API to me. Because the API can't enforce
the socket to receive packets on a dma-buf (rx-queue binding + flow
steering does that), but the API can assert that incoming packets are
received on said dma-buf. I guess it would check packets before they
are acked and would drop packets that landed on the wrong queue.

I'm a bit unsure about defensively programming features (and uapi no
less) to 'avoid any potential issues with flow steering'. Flow
steering is supposed to work.

Also if we wanted to defensively program something to avoid flow
steering issues, then I'd suggest adding to cmsg_devmem the dma-buf fd
that the data is on, not this setsockopt() that asserts. IMO it's a
weird API for the userspace to ask the kernel to assert some condition
(at least I haven't seen it before or commonly).

But again, in general, I'm a bit unsure about defensively designing
uapi around a feature like flow steering that's supposed to work.

> We'll still have dmabuf to rx-queue association because of various reason=
s..

--
Thanks,
Mina

