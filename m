Return-Path: <linux-arch+bounces-7-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED47E31BA
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B031B20B1E
	for <lists+linux-arch@lfdr.de>; Mon,  6 Nov 2023 23:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C31E2FE26;
	Mon,  6 Nov 2023 23:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t4YpVpBK"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 989A1DF6B
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 23:55:55 +0000 (UTC)
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF2DD7E
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 15:55:53 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id 71dfb90a1353d-49dd647a477so1954438e0c.3
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 15:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699314952; x=1699919752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hfYHFzoJ/SNtiqEXs9KmoOT951/cEwpd7yo/Kqsjms=;
        b=t4YpVpBK33bGquzqZztD96bfBBe70/YDYL7KzBIIf01t8PN/pmQLnovJpNoaj3hnpG
         +TElTFZ9uxV1yU0mjbua07o7/z53TTSH5Oj9j8GuV4TDZY1KoiPC15hSCNL3h7wUSGko
         Z22qO40AF/1y0c2zqSvxxYTjAL/PAXEN+jlu6zWhI8Ol+o5kAr0vtSikeaTcXvaGJH59
         oHuqVQ0D3w7pkDieI9x3Ms4MxmUjX0ZFf0FuKKo9gWSb7ODvWJLMTisvdSCoSFbbbd7g
         O3JxnBaNQDE4ATPWXcSkW2gbcSYOTTunqqU3m+aPP5ZweKRVbm3mGYf3lv/qWfcO8SNq
         Csyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699314952; x=1699919752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4hfYHFzoJ/SNtiqEXs9KmoOT951/cEwpd7yo/Kqsjms=;
        b=WXfiw5AXZ/g0ldj2oKYHJLsbG4QhacuYE8mp+evDNqFrhc2qYuciIe+TfII1P2nhUt
         tCDZqohEXYQ5t44mhlnCpNCOoIDBzXJX3NuPnxcUTTqoUsfXxVuI+USgtl/wSrt2Hxeu
         /P+J2GipVuODNVf1IoPFPCvK1E5lH34OtnLA8jNl9Rs7cUI1Ejd5u2D4Oz8DH1vuWzFK
         W1FnAD/x6HG8YcxSYgh6YIBjl8U9Y/Q9XHpKS+wQlDV6zgVnUyN3jtYXv8R9XB+nDAXp
         Layu/kOTiT47NEkrZpqrkMuO9NiqT2o28GARFhIqgzwS/ThwcBC8+qSTo8CyytiPryJQ
         fEsA==
X-Gm-Message-State: AOJu0YzQo3CxFhfwAifdrFI2B+F7hhASoMXTT26pfQO0/DW1ztoVI+tR
	mveFNpMiRLAP/SUry3dbH//QuOTMtd8Z3r6+JcFsoRjH6+G60GOEVwr6DjJk
X-Google-Smtp-Source: AGHT+IFm8u2DR/KSvgpH2bUsInZCXlnL6bHtUyQF8peCcdCjqMUYRuUPrwgBw2DLsgSxqbYES2CiqD0BwRddZmwHvas=
X-Received: by 2002:a1f:26c4:0:b0:49e:1eca:f849 with SMTP id
 m187-20020a1f26c4000000b0049e1ecaf849mr27587440vkm.13.1699314951931; Mon, 06
 Nov 2023 15:55:51 -0800 (PST)
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
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
In-Reply-To: <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
From: Stanislav Fomichev <sdf@google.com>
Date: Mon, 6 Nov 2023 15:55:37 -0800
Message-ID: <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Mina Almasry <almasrymina@google.com>
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

On Mon, Nov 6, 2023 at 3:27=E2=80=AFPM Mina Almasry <almasrymina@google.com=
> wrote:
>
> On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On 11/06, Mina Almasry wrote:
> > > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@google=
.com> wrote:
> > > >
> > > > On 11/06, Mina Almasry wrote:
> > > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@kern=
el.org> wrote:
> > > > > >
> > > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > > On 11/05, Mina Almasry wrote:
> > > > > > >> For device memory TCP, we expect the skb headers to be avail=
able in host
> > > > > > >> memory for access, and we expect the skb frags to be in devi=
ce memory
> > > > > > >> and unaccessible to the host. We expect there to be no mixin=
g and
> > > > > > >> matching of device memory frags (unaccessible) with host mem=
ory frags
> > > > > > >> (accessible) in the same skb.
> > > > > > >>
> > > > > > >> Add a skb->devmem flag which indicates whether the frags in =
this skb
> > > > > > >> are device memory frags or not.
> > > > > > >>
> > > > > > >> __skb_fill_page_desc() now checks frags added to skbs for pa=
ge_pool_iovs,
> > > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > > >>
> > > > > > >> Add checks through the network stack to avoid accessing the =
frags of
> > > > > > >> devmem skbs and avoid coalescing devmem skbs with non devmem=
 skbs.
> > > > > > >>
> > > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > >>
> > > > > > >> ---
> > > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > > >>  include/net/tcp.h      |  5 +--
> > > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > > >>  net/core/gro.c         |  5 ++-
> > > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++++++++=
+++++------
> > > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > > >>
> > > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
> > > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > > >> --- a/include/linux/skbuff.h
> > > > > > >> +++ b/include/linux/skbuff.h
> > > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > > > > > >>   *  @csum_level: indicates the number of consecutive checks=
ums found in
> > > > > > >>   *          the packet minus one that have been verified as
> > > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > > >> + *  @devmem: indicates that all the fragments in this skb a=
re backed by
> > > > > > >> + *          device memory.
> > > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > > >>   *  @decrypted: Decrypted SKB
> > > > > > >>   *  @slow_gro: state present at GRO time, slower prepare st=
ep required
> > > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > > >>      __u8                    csum_not_inet:1;
> > > > > > >>  #endif
> > > > > > >> -
> > > > > > >> +    __u8                    devmem:1;
> > > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRESS)
> > > > > > >>      __u16                   tc_index;       /* traffic cont=
rol index */
> > > > > > >>  #endif
> > > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgrad=
e_managed(struct sk_buff *skb)
> > > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > > >>  }
> > > > > > >>
> > > > > > >> +/* Return true if frags in this skb are not readable by the=
 host. */
> > > > > > >> +static inline bool skb_frags_not_readable(const struct sk_b=
uff *skb)
> > > > > > >> +{
> > > > > > >> +    return skb->devmem;
> > > > > > >
> > > > > > > bikeshedding: should we also rename 'devmem' sk_buff flag to =
'not_readable'?
> > > > > > > It better communicates the fact that the stack shouldn't dere=
ference the
> > > > > > > frags (because it has 'devmem' fragments or for some other po=
tential
> > > > > > > future reason).
> > > > > >
> > > > > > +1.
> > > > > >
> > > > > > Also, the flag on the skb is an optimization - a high level sig=
nal that
> > > > > > one or more frags is in unreadable memory. There is no requirem=
ent that
> > > > > > all of the frags are in the same memory type.
> > > >
> > > > David: maybe there should be such a requirement (that they all are
> > > > unreadable)? Might be easier to support initially; we can relax lat=
er
> > > > on.
> > > >
> > >
> > > Currently devmem =3D=3D not_readable, and the restriction is that all=
 the
> > > frags in the same skb must be either all readable or all unreadable
> > > (all devmem or all non-devmem).
> > >
> > > > > The flag indicates that the skb contains all devmem dma-buf memor=
y
> > > > > specifically, not generic 'not_readable' frags as the comment say=
s:
> > > > >
> > > > > + *     @devmem: indicates that all the fragments in this skb are=
 backed by
> > > > > + *             device memory.
> > > > >
> > > > > The reason it's not a generic 'not_readable' flag is because hand=
ing
> > > > > off a generic not_readable skb to the userspace is semantically n=
ot
> > > > > what we're doing. recvmsg() is augmented in this patch series to
> > > > > return a devmem skb to the user via a cmsg_devmem struct which re=
fers
> > > > > specifically to the memory in the dma-buf. recvmsg() in this patc=
h
> > > > > series is not augmented to give any 'not_readable' skb to the
> > > > > userspace.
> > > > >
> > > > > IMHO skb->devmem + an skb_frags_not_readable() as implemented is
> > > > > correct. If a new type of unreadable skbs are introduced to the s=
tack,
> > > > > I imagine the stack would implement:
> > > > >
> > > > > 1. new header flag: skb->newmem
> > > > > 2.
> > > > >
> > > > > static inline bool skb_frags_not_readable(const struct skb_buff *=
skb)
> > > > > {
> > > > >     return skb->devmem || skb->newmem;
> > > > > }
> > > > >
> > > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in this =
patch
> > > > > series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.
> > > >
> > > > You copy it to the userspace in a special way because your frags
> > > > are page_is_page_pool_iov(). I agree with David, the skb bit is
> > > > just and optimization.
> > > >
> > > > For most of the core stack, it doesn't matter why your skb is not
> > > > readable. For a few places where it matters (recvmsg?), you can
> > > > double-check your frags (all or some) with page_is_page_pool_iov.
> > > >
> > >
> > > I see, we can do that then. I.e. make the header flag 'not_readable'
> > > and check the frags to decide to delegate to tcp_recvmsg_devmem() or
> > > something else. We can even assume not_readable =3D=3D devmem because
> > > currently devmem is the only type of unreadable frag currently.
> > >
> > > > Unrelated: we probably need socket to dmabuf association as well (v=
ia
> > > > netlink or something).
> > >
> > > Not sure this is possible. The dma-buf is bound to the rx-queue, and
> > > any packets that land on that rx-queue are bound to that dma-buf,
> > > regardless of which socket that packet belongs to. So the association
> > > IMO must be rx-queue to dma-buf, not socket to dma-buf.
> >
> > But there is still always 1 dmabuf to 1 socket association (on rx), rig=
ht?
> > Because otherwise, there is no way currently to tell, at recvmsg, which
> > dmabuf the received token belongs to.
> >
>
> Yes, but this 1 dma-buf to 1 socket association happens because the
> user binds the dma-buf to an rx-queue and configures flow steering of
> the socket to that rx-queue.

It's still fixed and won't change during the socket lifetime, right?
And the socket has to know this association; otherwise those tokens
are useless since they don't carry anything to identify the dmabuf.

I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
it somehow implies that I have an option of passing or not passing it
for an individual system call.
If we know that we're going to use dmabuf with the socket, maybe we
should move this flag to the socket() syscall?

fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);

?

> > So why not have a separate control channel action to say: this socket f=
d
> > is supposed to receive into this dmabuf fd?
> > This action would put
> > the socket into permanent 'MSG_SOCK_DEVMEM' mode. Maybe you can also
> > put some checks at the lower level to to enforce this dmabuf
> > association. (to avoid any potential issues with flow steering)
> >
>
> setsockopt(SO_DEVMEM_ASSERT_DMA_BUF, dmabuf_fd)? Sounds interesting,
> but maybe a bit of a weird API to me. Because the API can't enforce
> the socket to receive packets on a dma-buf (rx-queue binding + flow
> steering does that), but the API can assert that incoming packets are
> received on said dma-buf. I guess it would check packets before they
> are acked and would drop packets that landed on the wrong queue.
>
> I'm a bit unsure about defensively programming features (and uapi no
> less) to 'avoid any potential issues with flow steering'. Flow
> steering is supposed to work.
>
> Also if we wanted to defensively program something to avoid flow
> steering issues, then I'd suggest adding to cmsg_devmem the dma-buf fd
> that the data is on, not this setsockopt() that asserts. IMO it's a
> weird API for the userspace to ask the kernel to assert some condition
> (at least I haven't seen it before or commonly).
>
> But again, in general, I'm a bit unsure about defensively designing
> uapi around a feature like flow steering that's supposed to work.

