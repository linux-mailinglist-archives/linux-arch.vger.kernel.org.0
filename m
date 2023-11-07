Return-Path: <linux-arch+bounces-12-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0167E3215
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:15:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAD57B20A7E
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299A4814;
	Tue,  7 Nov 2023 00:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WE79hAX8"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3797FD
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 00:15:00 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373A6134
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 16:14:58 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-da0c4ab85e2so2979184276.2
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 16:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699316097; x=1699920897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NJOStCOVHOX8afjyhZUr3wHzG9caGrOyErBNJl+fQsE=;
        b=WE79hAX87+nIxWPR1D1J0tdDpfokHaZko4+1kE0GZHSqYby78LJistdanP8UHFH/n5
         OVVy0gLSVQu0dHTAUNrVF5H0Q0+0uanIljNl/Rt0WAyC4MOA+2OiHJWrRJxfOpcbKHfw
         cl2QwP+wG0qJ0phaK/aES5F3VOQKaySU8YxY546daZyIPBpNn8fC0FNGyABgV0pjp4DX
         ia+KfV7jds3McoDhe6qy3VyY6cW9VaQqPJ02QK2+SdP3BXL/vUNta1tTNG1g8mvBbiSX
         wsbrkN0v89rRFCXwHKDtLefwrEaDMKN8ViZ2JIvguPGFGQJNZg8vXhCOyTEAsKdoWn8t
         zhdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699316097; x=1699920897;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJOStCOVHOX8afjyhZUr3wHzG9caGrOyErBNJl+fQsE=;
        b=cAvgEk0lb7lm1KqqrbcLRY7OvAXwUybB4d3YZwNcnqB9KjgY5tqacUGkeJ1eGWROVT
         DXA7Tm8wV62SU1obEZkEWnLdUWLtxHxF5YWFPT/sZae6GazoFEAMl6vtdDi+V2OTkAsh
         o0SE+gEXt5l08HlrhgWp31buoNR71YdGKq/vPGk1+P0eRLt/j5ScMm8BpZd+tE2G0a5V
         4zE47vFjcApN2E8L1DDBjEQBCC0YsucNPgPb5uuJXpj0XEoRcGtnDkyrvLOIopdwnjq3
         dJL8kxh3q/gdgZ7NvyaDzjIMkbMq9OhXoc7Hj1qpIulqUUM3DpZ+kJ9QpkhctiuOp0Yi
         +TPw==
X-Gm-Message-State: AOJu0Yy2P5UYmm1j6ihGM5nKhbh20zHV1yiOA/G7QMACsJkCWgPCRLzu
	JzZ4xxRag9a46OL+BStPIkW3eNw=
X-Google-Smtp-Source: AGHT+IHee5oEAGC8m+DVisVJTqhCxMx4WoxETbeYezr61DtzdGwZMzI7W/00cgynnvTwgZdWg/F4Ggw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:d785:0:b0:da0:5af7:d51a with SMTP id
 o127-20020a25d785000000b00da05af7d51amr642776ybg.0.1699316097113; Mon, 06 Nov
 2023 16:14:57 -0800 (PST)
Date: Mon, 6 Nov 2023 16:14:55 -0800
In-Reply-To: <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231106024413.2801438-10-almasrymina@google.com>
 <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com> <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
Message-ID: <ZUmBf7E8ZoTQwThL@google.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
From: Stanislav Fomichev <sdf@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Shakeel Butt <shakeelb@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Willem de Bruijn <willemb@google.com>, Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/06, Willem de Bruijn wrote:
> On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM Stanislav Fomichev <sdf@google.com=
> wrote:
> >
> > On Mon, Nov 6, 2023 at 3:27=E2=80=AFPM Mina Almasry <almasrymina@google=
.com> wrote:
> > >
> > > On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@google=
.com> wrote:
> > > >
> > > > On 11/06, Mina Almasry wrote:
> > > > > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@go=
ogle.com> wrote:
> > > > > >
> > > > > > On 11/06, Mina Almasry wrote:
> > > > > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@=
kernel.org> wrote:
> > > > > > > >
> > > > > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > > > > On 11/05, Mina Almasry wrote:
> > > > > > > > >> For device memory TCP, we expect the skb headers to be a=
vailable in host
> > > > > > > > >> memory for access, and we expect the skb frags to be in =
device memory
> > > > > > > > >> and unaccessible to the host. We expect there to be no m=
ixing and
> > > > > > > > >> matching of device memory frags (unaccessible) with host=
 memory frags
> > > > > > > > >> (accessible) in the same skb.
> > > > > > > > >>
> > > > > > > > >> Add a skb->devmem flag which indicates whether the frags=
 in this skb
> > > > > > > > >> are device memory frags or not.
> > > > > > > > >>
> > > > > > > > >> __skb_fill_page_desc() now checks frags added to skbs fo=
r page_pool_iovs,
> > > > > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > > > > >>
> > > > > > > > >> Add checks through the network stack to avoid accessing =
the frags of
> > > > > > > > >> devmem skbs and avoid coalescing devmem skbs with non de=
vmem skbs.
> > > > > > > > >>
> > > > > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > > > >>
> > > > > > > > >> ---
> > > > > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > > > > >>  include/net/tcp.h      |  5 +--
> > > > > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > > > > >>  net/core/gro.c         |  5 ++-
> > > > > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++++=
+++++++++------
> > > > > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > > > > >>
> > > > > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbu=
ff.h
> > > > > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > > > > >> --- a/include/linux/skbuff.h
> > > > > > > > >> +++ b/include/linux/skbuff.h
> > > > > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_=
t;
> > > > > > > > >>   *  @csum_level: indicates the number of consecutive ch=
ecksums found in
> > > > > > > > >>   *          the packet minus one that have been verifie=
d as
> > > > > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > > > > >> + *  @devmem: indicates that all the fragments in this s=
kb are backed by
> > > > > > > > >> + *          device memory.
> > > > > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > > > > >>   *  @decrypted: Decrypted SKB
> > > > > > > > >>   *  @slow_gro: state present at GRO time, slower prepar=
e step required
> > > > > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > > > > >>      __u8                    csum_not_inet:1;
> > > > > > > > >>  #endif
> > > > > > > > >> -
> > > > > > > > >> +    __u8                    devmem:1;
> > > > > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGR=
ESS)
> > > > > > > > >>      __u16                   tc_index;       /* traffic =
control index */
> > > > > > > > >>  #endif
> > > > > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_down=
grade_managed(struct sk_buff *skb)
> > > > > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > > > > >>  }
> > > > > > > > >>
> > > > > > > > >> +/* Return true if frags in this skb are not readable by=
 the host. */
> > > > > > > > >> +static inline bool skb_frags_not_readable(const struct =
sk_buff *skb)
> > > > > > > > >> +{
> > > > > > > > >> +    return skb->devmem;
> > > > > > > > >
> > > > > > > > > bikeshedding: should we also rename 'devmem' sk_buff flag=
 to 'not_readable'?
> > > > > > > > > It better communicates the fact that the stack shouldn't =
dereference the
> > > > > > > > > frags (because it has 'devmem' fragments or for some othe=
r potential
> > > > > > > > > future reason).
> > > > > > > >
> > > > > > > > +1.
> > > > > > > >
> > > > > > > > Also, the flag on the skb is an optimization - a high level=
 signal that
> > > > > > > > one or more frags is in unreadable memory. There is no requ=
irement that
> > > > > > > > all of the frags are in the same memory type.
> > > > > >
> > > > > > David: maybe there should be such a requirement (that they all =
are
> > > > > > unreadable)? Might be easier to support initially; we can relax=
 later
> > > > > > on.
> > > > > >
> > > > >
> > > > > Currently devmem =3D=3D not_readable, and the restriction is that=
 all the
> > > > > frags in the same skb must be either all readable or all unreadab=
le
> > > > > (all devmem or all non-devmem).
> > > > >
> > > > > > > The flag indicates that the skb contains all devmem dma-buf m=
emory
> > > > > > > specifically, not generic 'not_readable' frags as the comment=
 says:
> > > > > > >
> > > > > > > + *     @devmem: indicates that all the fragments in this skb=
 are backed by
> > > > > > > + *             device memory.
> > > > > > >
> > > > > > > The reason it's not a generic 'not_readable' flag is because =
handing
> > > > > > > off a generic not_readable skb to the userspace is semantical=
ly not
> > > > > > > what we're doing. recvmsg() is augmented in this patch series=
 to
> > > > > > > return a devmem skb to the user via a cmsg_devmem struct whic=
h refers
> > > > > > > specifically to the memory in the dma-buf. recvmsg() in this =
patch
> > > > > > > series is not augmented to give any 'not_readable' skb to the
> > > > > > > userspace.
> > > > > > >
> > > > > > > IMHO skb->devmem + an skb_frags_not_readable() as implemented=
 is
> > > > > > > correct. If a new type of unreadable skbs are introduced to t=
he stack,
> > > > > > > I imagine the stack would implement:
> > > > > > >
> > > > > > > 1. new header flag: skb->newmem
> > > > > > > 2.
> > > > > > >
> > > > > > > static inline bool skb_frags_not_readable(const struct skb_bu=
ff *skb)
> > > > > > > {
> > > > > > >     return skb->devmem || skb->newmem;
> > > > > > > }
> > > > > > >
> > > > > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in t=
his patch
> > > > > > > series, but tcp_recvmsg_newmem() would handle skb->newmem skb=
s.
> > > > > >
> > > > > > You copy it to the userspace in a special way because your frag=
s
> > > > > > are page_is_page_pool_iov(). I agree with David, the skb bit is
> > > > > > just and optimization.
> > > > > >
> > > > > > For most of the core stack, it doesn't matter why your skb is n=
ot
> > > > > > readable. For a few places where it matters (recvmsg?), you can
> > > > > > double-check your frags (all or some) with page_is_page_pool_io=
v.
> > > > > >
> > > > >
> > > > > I see, we can do that then. I.e. make the header flag 'not_readab=
le'
> > > > > and check the frags to decide to delegate to tcp_recvmsg_devmem()=
 or
> > > > > something else. We can even assume not_readable =3D=3D devmem bec=
ause
> > > > > currently devmem is the only type of unreadable frag currently.
> > > > >
> > > > > > Unrelated: we probably need socket to dmabuf association as wel=
l (via
> > > > > > netlink or something).
> > > > >
> > > > > Not sure this is possible. The dma-buf is bound to the rx-queue, =
and
> > > > > any packets that land on that rx-queue are bound to that dma-buf,
> > > > > regardless of which socket that packet belongs to. So the associa=
tion
> > > > > IMO must be rx-queue to dma-buf, not socket to dma-buf.
> > > >
> > > > But there is still always 1 dmabuf to 1 socket association (on rx),=
 right?
> > > > Because otherwise, there is no way currently to tell, at recvmsg, w=
hich
> > > > dmabuf the received token belongs to.
> > > >
> > >
> > > Yes, but this 1 dma-buf to 1 socket association happens because the
> > > user binds the dma-buf to an rx-queue and configures flow steering of
> > > the socket to that rx-queue.
> >
> > It's still fixed and won't change during the socket lifetime, right?
> > And the socket has to know this association; otherwise those tokens
> > are useless since they don't carry anything to identify the dmabuf.
> >
> > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > it somehow implies that I have an option of passing or not passing it
> > for an individual system call.
> > If we know that we're going to use dmabuf with the socket, maybe we
> > should move this flag to the socket() syscall?
> >
> > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> >
> > ?
>=20
> I think it should then be a setsockopt called before any data is
> exchanged, with no change of modifying mode later. We generally use
> setsockopts for the mode of a socket. This use of the protocol field
> in socket() for setting a mode would be novel. Also, it might miss
> passively opened connections, or be overly restrictive: one approach
> for all accepted child sockets.

I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? There
are plenty of bits we can grab. But setsockopt works as well!

