Return-Path: <linux-arch+bounces-16-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D310E7E326D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 02:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41400B20A8D
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27E117C2;
	Tue,  7 Nov 2023 00:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0jjAwiPy"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5F915AA
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 00:59:55 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B3E7129
	for <linux-arch@vger.kernel.org>; Mon,  6 Nov 2023 16:59:51 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9ab7badadeso6506320276.1
        for <linux-arch@vger.kernel.org>; Mon, 06 Nov 2023 16:59:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699318791; x=1699923591; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RZq0cHGbwdf8rCqfne97OVdbRaVIcE6Mnc7us/EVmVk=;
        b=0jjAwiPyWy0XCqTfLUFK8aKNcEv8b+zDJKefYDw5pPmy1wLP2GtRqZlNEyaDlzD7i1
         i4pVAMOW3n+QFG5OZ84DdST2xwJpkP1De4PXpR5XwAaaKWoZbFH7aFYrRZu+5hK4yvPc
         51LrlTC+y8lRouvrJTHR0fuAYqQiFSM/BbQQ3E6q3Yq3LWFKFbtteG27whne1a9rm6El
         EP9dqb1VOE33ppfchxbu/X1Ob+fdZSVsr9xfzhrXHuBQThF2QJunLLI/vrGQrKOs5Rah
         8UNGEqh2zCvTEuysjJjsuztI9v1FuAJeQxK1eA2qxVPUdntMsoLVGEs6YVwTwI+iOmVi
         Q7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699318791; x=1699923591;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RZq0cHGbwdf8rCqfne97OVdbRaVIcE6Mnc7us/EVmVk=;
        b=a5OrJn0/FMS5olveRSmjdriBFPmemaGbJcEE9rjdSoY7K+EL9ujSE7++OXEff+Rfgf
         4vkHjVIc2EdPSN8aeWxN2TCbGQbgAnWq62EJ0sng4YIL59XYLEG1+5MfkCtNv7A6Ut8O
         t1IRrr3vWENZxYcR1uvQLtszyA1pm745BT1bjytwqaIE+6io4iA9jUHzx0h3O4+jObLD
         ybgogokmZ/Slmt4HJbiQ7cz3u2oZA83khIeZ5a4ItY5f98bK/C96oq1RTmJ5x6FpLR+Y
         ADHJBqrrisa35AA0F6UgD4v5YJA/2/NYGR3SHR+lZcS1aFcKGS8SM/72FZ2EBsYHzHkj
         EvhA==
X-Gm-Message-State: AOJu0YwCwPoT3fhQz0SPAFiiWjAC7gqC/MUQloejb3i8EOwnjo53fUIm
	sPntcwRAPGbnnGpiNIdna27InEc=
X-Google-Smtp-Source: AGHT+IHuen4u0ItSSrCJw8SOFK44gqEr5RTLeMcW7sFtezbGV+wdpAVS+dKsyIjzjG0vGnh0CeV67fw=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:add5:0:b0:d9a:4f4c:961b with SMTP id
 d21-20020a25add5000000b00d9a4f4c961bmr566975ybe.1.1699318790828; Mon, 06 Nov
 2023 16:59:50 -0800 (PST)
Date: Mon, 6 Nov 2023 16:59:49 -0800
In-Reply-To: <ZUmBf7E8ZoTQwThL@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com> <ZUmBf7E8ZoTQwThL@google.com>
Message-ID: <ZUmMBZpLPQkRS9bg@google.com>
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

On 11/06, Stanislav Fomichev wrote:
> On 11/06, Willem de Bruijn wrote:
> > On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On Mon, Nov 6, 2023 at 3:27=E2=80=AFPM Mina Almasry <almasrymina@goog=
le.com> wrote:
> > > >
> > > > On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@goog=
le.com> wrote:
> > > > >
> > > > > On 11/06, Mina Almasry wrote:
> > > > > > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@=
google.com> wrote:
> > > > > > >
> > > > > > > On 11/06, Mina Almasry wrote:
> > > > > > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsaher=
n@kernel.org> wrote:
> > > > > > > > >
> > > > > > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > > > > > On 11/05, Mina Almasry wrote:
> > > > > > > > > >> For device memory TCP, we expect the skb headers to be=
 available in host
> > > > > > > > > >> memory for access, and we expect the skb frags to be i=
n device memory
> > > > > > > > > >> and unaccessible to the host. We expect there to be no=
 mixing and
> > > > > > > > > >> matching of device memory frags (unaccessible) with ho=
st memory frags
> > > > > > > > > >> (accessible) in the same skb.
> > > > > > > > > >>
> > > > > > > > > >> Add a skb->devmem flag which indicates whether the fra=
gs in this skb
> > > > > > > > > >> are device memory frags or not.
> > > > > > > > > >>
> > > > > > > > > >> __skb_fill_page_desc() now checks frags added to skbs =
for page_pool_iovs,
> > > > > > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > > > > > >>
> > > > > > > > > >> Add checks through the network stack to avoid accessin=
g the frags of
> > > > > > > > > >> devmem skbs and avoid coalescing devmem skbs with non =
devmem skbs.
> > > > > > > > > >>
> > > > > > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > > > > >>
> > > > > > > > > >> ---
> > > > > > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > > > > > >>  include/net/tcp.h      |  5 +--
> > > > > > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > > > > > >>  net/core/gro.c         |  5 ++-
> > > > > > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++=
+++++++++++------
> > > > > > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > > > > > >>
> > > > > > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/sk=
buff.h
> > > > > > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > > > > > >> --- a/include/linux/skbuff.h
> > > > > > > > > >> +++ b/include/linux/skbuff.h
> > > > > > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_dat=
a_t;
> > > > > > > > > >>   *  @csum_level: indicates the number of consecutive =
checksums found in
> > > > > > > > > >>   *          the packet minus one that have been verif=
ied as
> > > > > > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > > > > > >> + *  @devmem: indicates that all the fragments in this=
 skb are backed by
> > > > > > > > > >> + *          device memory.
> > > > > > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > > > > > >>   *  @decrypted: Decrypted SKB
> > > > > > > > > >>   *  @slow_gro: state present at GRO time, slower prep=
are step required
> > > > > > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > > > > > >>      __u8                    csum_not_inet:1;
> > > > > > > > > >>  #endif
> > > > > > > > > >> -
> > > > > > > > > >> +    __u8                    devmem:1;
> > > > > > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_X=
GRESS)
> > > > > > > > > >>      __u16                   tc_index;       /* traffi=
c control index */
> > > > > > > > > >>  #endif
> > > > > > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_do=
wngrade_managed(struct sk_buff *skb)
> > > > > > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > > > > > >>  }
> > > > > > > > > >>
> > > > > > > > > >> +/* Return true if frags in this skb are not readable =
by the host. */
> > > > > > > > > >> +static inline bool skb_frags_not_readable(const struc=
t sk_buff *skb)
> > > > > > > > > >> +{
> > > > > > > > > >> +    return skb->devmem;
> > > > > > > > > >
> > > > > > > > > > bikeshedding: should we also rename 'devmem' sk_buff fl=
ag to 'not_readable'?
> > > > > > > > > > It better communicates the fact that the stack shouldn'=
t dereference the
> > > > > > > > > > frags (because it has 'devmem' fragments or for some ot=
her potential
> > > > > > > > > > future reason).
> > > > > > > > >
> > > > > > > > > +1.
> > > > > > > > >
> > > > > > > > > Also, the flag on the skb is an optimization - a high lev=
el signal that
> > > > > > > > > one or more frags is in unreadable memory. There is no re=
quirement that
> > > > > > > > > all of the frags are in the same memory type.
> > > > > > >
> > > > > > > David: maybe there should be such a requirement (that they al=
l are
> > > > > > > unreadable)? Might be easier to support initially; we can rel=
ax later
> > > > > > > on.
> > > > > > >
> > > > > >
> > > > > > Currently devmem =3D=3D not_readable, and the restriction is th=
at all the
> > > > > > frags in the same skb must be either all readable or all unread=
able
> > > > > > (all devmem or all non-devmem).
> > > > > >
> > > > > > > > The flag indicates that the skb contains all devmem dma-buf=
 memory
> > > > > > > > specifically, not generic 'not_readable' frags as the comme=
nt says:
> > > > > > > >
> > > > > > > > + *     @devmem: indicates that all the fragments in this s=
kb are backed by
> > > > > > > > + *             device memory.
> > > > > > > >
> > > > > > > > The reason it's not a generic 'not_readable' flag is becaus=
e handing
> > > > > > > > off a generic not_readable skb to the userspace is semantic=
ally not
> > > > > > > > what we're doing. recvmsg() is augmented in this patch seri=
es to
> > > > > > > > return a devmem skb to the user via a cmsg_devmem struct wh=
ich refers
> > > > > > > > specifically to the memory in the dma-buf. recvmsg() in thi=
s patch
> > > > > > > > series is not augmented to give any 'not_readable' skb to t=
he
> > > > > > > > userspace.
> > > > > > > >
> > > > > > > > IMHO skb->devmem + an skb_frags_not_readable() as implement=
ed is
> > > > > > > > correct. If a new type of unreadable skbs are introduced to=
 the stack,
> > > > > > > > I imagine the stack would implement:
> > > > > > > >
> > > > > > > > 1. new header flag: skb->newmem
> > > > > > > > 2.
> > > > > > > >
> > > > > > > > static inline bool skb_frags_not_readable(const struct skb_=
buff *skb)
> > > > > > > > {
> > > > > > > >     return skb->devmem || skb->newmem;
> > > > > > > > }
> > > > > > > >
> > > > > > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in=
 this patch
> > > > > > > > series, but tcp_recvmsg_newmem() would handle skb->newmem s=
kbs.
> > > > > > >
> > > > > > > You copy it to the userspace in a special way because your fr=
ags
> > > > > > > are page_is_page_pool_iov(). I agree with David, the skb bit =
is
> > > > > > > just and optimization.
> > > > > > >
> > > > > > > For most of the core stack, it doesn't matter why your skb is=
 not
> > > > > > > readable. For a few places where it matters (recvmsg?), you c=
an
> > > > > > > double-check your frags (all or some) with page_is_page_pool_=
iov.
> > > > > > >
> > > > > >
> > > > > > I see, we can do that then. I.e. make the header flag 'not_read=
able'
> > > > > > and check the frags to decide to delegate to tcp_recvmsg_devmem=
() or
> > > > > > something else. We can even assume not_readable =3D=3D devmem b=
ecause
> > > > > > currently devmem is the only type of unreadable frag currently.
> > > > > >
> > > > > > > Unrelated: we probably need socket to dmabuf association as w=
ell (via
> > > > > > > netlink or something).
> > > > > >
> > > > > > Not sure this is possible. The dma-buf is bound to the rx-queue=
, and
> > > > > > any packets that land on that rx-queue are bound to that dma-bu=
f,
> > > > > > regardless of which socket that packet belongs to. So the assoc=
iation
> > > > > > IMO must be rx-queue to dma-buf, not socket to dma-buf.
> > > > >
> > > > > But there is still always 1 dmabuf to 1 socket association (on rx=
), right?
> > > > > Because otherwise, there is no way currently to tell, at recvmsg,=
 which
> > > > > dmabuf the received token belongs to.
> > > > >
> > > >
> > > > Yes, but this 1 dma-buf to 1 socket association happens because the
> > > > user binds the dma-buf to an rx-queue and configures flow steering =
of
> > > > the socket to that rx-queue.
> > >
> > > It's still fixed and won't change during the socket lifetime, right?
> > > And the socket has to know this association; otherwise those tokens
> > > are useless since they don't carry anything to identify the dmabuf.
> > >
> > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > > it somehow implies that I have an option of passing or not passing it
> > > for an individual system call.
> > > If we know that we're going to use dmabuf with the socket, maybe we
> > > should move this flag to the socket() syscall?
> > >
> > > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > >
> > > ?
> >=20
> > I think it should then be a setsockopt called before any data is
> > exchanged, with no change of modifying mode later. We generally use
> > setsockopts for the mode of a socket. This use of the protocol field
> > in socket() for setting a mode would be novel. Also, it might miss
> > passively opened connections, or be overly restrictive: one approach
> > for all accepted child sockets.
>=20
> I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? There
> are plenty of bits we can grab. But setsockopt works as well!

To follow up: if we have this flag on a socket, not on a per-message
basis, can we also use recvmsg for the recycling part maybe?

while (true) {
	memset(msg, 0, ...);

	/* receive the tokens */
	ret =3D recvmsg(fd, &msg, 0);

	/* recycle the tokens from the above recvmsg() */
	ret =3D recvmsg(fd, &msg, MSG_RECYCLE);
}

recvmsg + MSG_RECYCLE can parse the same format that regular recvmsg
exports (SO_DEVMEM_OFFSET) and we can also add extra cmsg option
to recycle a range.

Will this be more straightforward than a setsockopt(SO_DEVMEM_DONTNEED)?
Or is it more confusing?

