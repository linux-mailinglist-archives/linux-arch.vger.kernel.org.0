Return-Path: <linux-arch+bounces-14-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6557E322B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5CC1D280DA2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F081E;
	Tue,  7 Nov 2023 00:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uHFKiCz7"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF7C7FD
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 00:20:24 +0000 (UTC)
Received: from mail-ua1-x932.google.com (mail-ua1-x932.google.com [IPv6:2607:f8b0:4864:20::932])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA6D183
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 16:20:21 -0800 (PST)
Received: by mail-ua1-x932.google.com with SMTP id a1e0cc1a2514c-7bac330d396so1832639241.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 16:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699316421; x=1699921221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qQGehx1oJiFQdPw0iQpiQ9xkuTdpKQQBCV1Vk/IFjuE=;
        b=uHFKiCz7qleJSSMLrF9N6ZwPfQPrkt2/wgrYIeu7hqzgw7F9Sj6/Sw+tLrEI3XaiVr
         5MBf3UXl8zVZoCCt4Ne6hbfpJ9N1pWCAmfW7arKOHyl0xrtRS8d0X5c+8BlZEGbbcPEU
         RjF88hVWM6scVkwwA68jpZOiIURAObaN/kf1VRGabm4wh/gfFYS4qWaMzXgEQ2hI7VHa
         tQG11hsGFgtNhDXGyF1qTIfHtkVmNqOeg1c6ZP/hbIzfxM8g/8eaPscQWhrF60ONh1Dc
         v/9KeoNjLfrwqjlFg4HOybz1BwlQKVXqLrPXB9SCBmD773XGRQFV0c1JV1xL7OLJ04JP
         76yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699316421; x=1699921221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qQGehx1oJiFQdPw0iQpiQ9xkuTdpKQQBCV1Vk/IFjuE=;
        b=IA9c+McRnudBcw20J0m1SKfEyKx1El1NwDnNX0lYop1S8QWC/XiHrtzLp87gQIlQsj
         MfHLxkPls+Bc0JVdQdXZ5g6JlAmc86KVJHp4HIliTyRn0MzhciaXDq7Vs26DSDSOxZRS
         T+6JXSa22VnFQ5qrkbZPkuSWmF5jN0wGNvzhY/hZX2q0XpyDNI8AdSPp5AmV6vBAq05f
         MLVpvkNpOdsh7ZDAlU9B4Lldjit+uQXFjLVfhFnBKmR+sic5qAnMhg6z85x9ryhVlhv4
         VkoGEJT2QsRFlssKYxzFrevZW7cCE9jtWVUxkDWf9tXLS92Ye1neqAuZ0lidg9vMV7b/
         ONmg==
X-Gm-Message-State: AOJu0YxT4YQmPmA1yNO6Co6pfFwzWRcu349vrdep8DRs249/XqEIAIN7
	oLEyzgq80wj+yXpXyZXABjGmunnC8LbpdvlwkXWEzQ==
X-Google-Smtp-Source: AGHT+IE+E0Axa1F+VOQqY91UWnsA76COK/fPc8yXYOLoKeF9mfVO+YVUlg+5NVGTg4ufTE6uioEQuyPJLNycQxJkqiw=
X-Received: by 2002:a05:6102:4712:b0:457:6022:206a with SMTP id
 ei18-20020a056102471200b004576022206amr27780625vsb.1.1699316420836; Mon, 06
 Nov 2023 16:20:20 -0800 (PST)
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
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com> <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
In-Reply-To: <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 6 Nov 2023 16:20:07 -0800
Message-ID: <CAHS8izNxKHhW5uCqmfau6n3c18=hE3RXzA+ng5LEGiKj12nGcg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Stanislav Fomichev <sdf@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, Shuah Khan <shuah@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Shakeel Butt <shakeelb@google.com>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 6, 2023 at 4:08=E2=80=AFPM Willem de Bruijn
<willemdebruijn.kernel@gmail.com> wrote:
>
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

Technically, no.

The user is free to modify or delete flow steering rules outside of
the lifetime of the socket. Technically it's possible for the user to
reconfigure flow steering while the socket is simultaneously
receiving, and the result will be packets switching
 from devmem to non-devmem. For a reasonably correctly configured
application the application would probably want to steer 1 flow to 1
dma-buf and never change it, but this is not something we enforce, but
rather the user orchestrates. In theory someone can find a use case
for configuring and unconfigure flow steering during a connection.

> > And the socket has to know this association; otherwise those tokens
> > are useless since they don't carry anything to identify the dmabuf.
> >
> > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > it somehow implies that I have an option of passing or not passing it
> > for an individual system call.

You do have the option of passing it or not passing it per system
call. The MSG_SOCK_DEVMEM says the application is willing to receive
devmem cmsgs - that's all. The application doesn't get to decide
whether it's actually going to receive a devmem cmsg or not, because
that's dictated by the type of skb that is present in the receive
queue, and not up to the application. I should explain this in the
commit message...

> > If we know that we're going to use dmabuf with the socket, maybe we
> > should move this flag to the socket() syscall?
> >
> > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> >
> > ?
>
> I think it should then be a setsockopt called before any data is
> exchanged, with no change of modifying mode later. We generally use
> setsockopts for the mode of a socket. This use of the protocol field
> in socket() for setting a mode would be novel. Also, it might miss
> passively opened connections, or be overly restrictive: one approach
> for all accepted child sockets.

We can definitely move SOCK_DEVMEM to a setsockopt(). Seems more than
reasonable.

--=20
Thanks,
Mina

