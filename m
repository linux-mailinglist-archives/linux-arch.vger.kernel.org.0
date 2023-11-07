Return-Path: <linux-arch+bounces-11-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8BC7E3203
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 01:08:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEE5C1C20A1F
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 00:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03CA7F9;
	Tue,  7 Nov 2023 00:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GUdwcuub"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F08480E;
	Tue,  7 Nov 2023 00:08:04 +0000 (UTC)
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED79E134;
	Mon,  6 Nov 2023 16:08:01 -0800 (PST)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7bac330d396so1829110241.1;
        Mon, 06 Nov 2023 16:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699315681; x=1699920481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMgLiPx32/MTfxuwbgzERtFe/YaKVNm8c3X3ms3/1PE=;
        b=GUdwcuubQeqA1wX3B1BKlUN/+TCBVqbnouBuoHm/cb3q9nf7iK44O49vjHJ54Cf98B
         v/i9vRwYsKxQ7SCwpRemBpCuIQybJG+8pl3DxmPImo0+iD+hZvsy7EK0ThIlTLb3eRqk
         SUfq5OVh9HtCrkPiWx7M+06br+trM2fv6yk+BHWhaHQf8p2jAk2kTR2O1w2LxzTlqIOK
         roBnO1Kg6J1F8irGUkwyNOCXWm9Vg38L154zlTKFUXEd70WjPsSmPtKHmwKeH5bCzqTA
         HJIbGeh7Sx78JBO2rdGkYJYOmkxFImng4EaaYMErJYO1HEgZ+2XgJqyone4Vf4pc4mHx
         zhIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699315681; x=1699920481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dMgLiPx32/MTfxuwbgzERtFe/YaKVNm8c3X3ms3/1PE=;
        b=X1RoIAa/EZQ2LQ2J7sWFoI/ntaB27ls5HgQTPEl48u/mpF28xpLwSAs2zVNK82aVTP
         +w56GywUUVi8TacEVTgJ0HwJWYrVF/YsDvWy/6DrahEia2pXR0NKMMDk55WLEbF3kdL4
         uPbvMuGmSyKA6Bbodg691hnIT1LJpfK853p4PkvqXedJE66hONDkApS3vamq69kueJL1
         ubSkJ9TXv6YEAamGVdgnCXaDJJvF5UOe1G+nWpgWwc7SkHuBmqQHWOMS24Fptgm7WTzB
         ngJmICX9adUJcxhWWEtTqltzxZySJyiNmAsbD94HuMFZvB/0R1s0nzX13106TpW5I8zd
         VBfA==
X-Gm-Message-State: AOJu0YxHhjXXckYyyuWErjc+HCB63wR33HSNLXwAdJPYcx+pZwDNfgjA
	dglV9r74wtabqTNcy1Fus7zoNmK/F0GYGKvW94o=
X-Google-Smtp-Source: AGHT+IHH0naUlMlkHryf8Cm/tc+cRL6aLUmgXGaNQ1gzh/QqvXA/kqhc+AXrzuHp3abzthzJsDu7FFam4MhVmahCUz0=
X-Received: by 2002:a67:e1d0:0:b0:45d:974a:7f4f with SMTP id
 p16-20020a67e1d0000000b0045d974a7f4fmr8293787vsl.2.1699315680898; Mon, 06 Nov
 2023 16:08:00 -0800 (PST)
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
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
In-Reply-To: <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 6 Nov 2023 16:07:23 -0800
Message-ID: <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
Subject: Re: [RFC PATCH v3 09/12] net: add support for skbs with unreadable frags
To: Stanislav Fomichev <sdf@google.com>
Cc: Mina Almasry <almasrymina@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
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

On Mon, Nov 6, 2023 at 3:55=E2=80=AFPM Stanislav Fomichev <sdf@google.com> =
wrote:
>
> On Mon, Nov 6, 2023 at 3:27=E2=80=AFPM Mina Almasry <almasrymina@google.c=
om> wrote:
> >
> > On Mon, Nov 6, 2023 at 2:59=E2=80=AFPM Stanislav Fomichev <sdf@google.c=
om> wrote:
> > >
> > > On 11/06, Mina Almasry wrote:
> > > > On Mon, Nov 6, 2023 at 1:59=E2=80=AFPM Stanislav Fomichev <sdf@goog=
le.com> wrote:
> > > > >
> > > > > On 11/06, Mina Almasry wrote:
> > > > > > On Mon, Nov 6, 2023 at 11:34=E2=80=AFAM David Ahern <dsahern@ke=
rnel.org> wrote:
> > > > > > >
> > > > > > > On 11/6/23 11:47 AM, Stanislav Fomichev wrote:
> > > > > > > > On 11/05, Mina Almasry wrote:
> > > > > > > >> For device memory TCP, we expect the skb headers to be ava=
ilable in host
> > > > > > > >> memory for access, and we expect the skb frags to be in de=
vice memory
> > > > > > > >> and unaccessible to the host. We expect there to be no mix=
ing and
> > > > > > > >> matching of device memory frags (unaccessible) with host m=
emory frags
> > > > > > > >> (accessible) in the same skb.
> > > > > > > >>
> > > > > > > >> Add a skb->devmem flag which indicates whether the frags i=
n this skb
> > > > > > > >> are device memory frags or not.
> > > > > > > >>
> > > > > > > >> __skb_fill_page_desc() now checks frags added to skbs for =
page_pool_iovs,
> > > > > > > >> and marks the skb as skb->devmem accordingly.
> > > > > > > >>
> > > > > > > >> Add checks through the network stack to avoid accessing th=
e frags of
> > > > > > > >> devmem skbs and avoid coalescing devmem skbs with non devm=
em skbs.
> > > > > > > >>
> > > > > > > >> Signed-off-by: Willem de Bruijn <willemb@google.com>
> > > > > > > >> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> > > > > > > >> Signed-off-by: Mina Almasry <almasrymina@google.com>
> > > > > > > >>
> > > > > > > >> ---
> > > > > > > >>  include/linux/skbuff.h | 14 +++++++-
> > > > > > > >>  include/net/tcp.h      |  5 +--
> > > > > > > >>  net/core/datagram.c    |  6 ++++
> > > > > > > >>  net/core/gro.c         |  5 ++-
> > > > > > > >>  net/core/skbuff.c      | 77 +++++++++++++++++++++++++++++=
+++++++------
> > > > > > > >>  net/ipv4/tcp.c         |  6 ++++
> > > > > > > >>  net/ipv4/tcp_input.c   | 13 +++++--
> > > > > > > >>  net/ipv4/tcp_output.c  |  5 ++-
> > > > > > > >>  net/packet/af_packet.c |  4 +--
> > > > > > > >>  9 files changed, 115 insertions(+), 20 deletions(-)
> > > > > > > >>
> > > > > > > >> diff --git a/include/linux/skbuff.h b/include/linux/skbuff=
.h
> > > > > > > >> index 1fae276c1353..8fb468ff8115 100644
> > > > > > > >> --- a/include/linux/skbuff.h
> > > > > > > >> +++ b/include/linux/skbuff.h
> > > > > > > >> @@ -805,6 +805,8 @@ typedef unsigned char *sk_buff_data_t;
> > > > > > > >>   *  @csum_level: indicates the number of consecutive chec=
ksums found in
> > > > > > > >>   *          the packet minus one that have been verified =
as
> > > > > > > >>   *          CHECKSUM_UNNECESSARY (max 3)
> > > > > > > >> + *  @devmem: indicates that all the fragments in this skb=
 are backed by
> > > > > > > >> + *          device memory.
> > > > > > > >>   *  @dst_pending_confirm: need to confirm neighbour
> > > > > > > >>   *  @decrypted: Decrypted SKB
> > > > > > > >>   *  @slow_gro: state present at GRO time, slower prepare =
step required
> > > > > > > >> @@ -991,7 +993,7 @@ struct sk_buff {
> > > > > > > >>  #if IS_ENABLED(CONFIG_IP_SCTP)
> > > > > > > >>      __u8                    csum_not_inet:1;
> > > > > > > >>  #endif
> > > > > > > >> -
> > > > > > > >> +    __u8                    devmem:1;
> > > > > > > >>  #if defined(CONFIG_NET_SCHED) || defined(CONFIG_NET_XGRES=
S)
> > > > > > > >>      __u16                   tc_index;       /* traffic co=
ntrol index */
> > > > > > > >>  #endif
> > > > > > > >> @@ -1766,6 +1768,12 @@ static inline void skb_zcopy_downgr=
ade_managed(struct sk_buff *skb)
> > > > > > > >>              __skb_zcopy_downgrade_managed(skb);
> > > > > > > >>  }
> > > > > > > >>
> > > > > > > >> +/* Return true if frags in this skb are not readable by t=
he host. */
> > > > > > > >> +static inline bool skb_frags_not_readable(const struct sk=
_buff *skb)
> > > > > > > >> +{
> > > > > > > >> +    return skb->devmem;
> > > > > > > >
> > > > > > > > bikeshedding: should we also rename 'devmem' sk_buff flag t=
o 'not_readable'?
> > > > > > > > It better communicates the fact that the stack shouldn't de=
reference the
> > > > > > > > frags (because it has 'devmem' fragments or for some other =
potential
> > > > > > > > future reason).
> > > > > > >
> > > > > > > +1.
> > > > > > >
> > > > > > > Also, the flag on the skb is an optimization - a high level s=
ignal that
> > > > > > > one or more frags is in unreadable memory. There is no requir=
ement that
> > > > > > > all of the frags are in the same memory type.
> > > > >
> > > > > David: maybe there should be such a requirement (that they all ar=
e
> > > > > unreadable)? Might be easier to support initially; we can relax l=
ater
> > > > > on.
> > > > >
> > > >
> > > > Currently devmem =3D=3D not_readable, and the restriction is that a=
ll the
> > > > frags in the same skb must be either all readable or all unreadable
> > > > (all devmem or all non-devmem).
> > > >
> > > > > > The flag indicates that the skb contains all devmem dma-buf mem=
ory
> > > > > > specifically, not generic 'not_readable' frags as the comment s=
ays:
> > > > > >
> > > > > > + *     @devmem: indicates that all the fragments in this skb a=
re backed by
> > > > > > + *             device memory.
> > > > > >
> > > > > > The reason it's not a generic 'not_readable' flag is because ha=
nding
> > > > > > off a generic not_readable skb to the userspace is semantically=
 not
> > > > > > what we're doing. recvmsg() is augmented in this patch series t=
o
> > > > > > return a devmem skb to the user via a cmsg_devmem struct which =
refers
> > > > > > specifically to the memory in the dma-buf. recvmsg() in this pa=
tch
> > > > > > series is not augmented to give any 'not_readable' skb to the
> > > > > > userspace.
> > > > > >
> > > > > > IMHO skb->devmem + an skb_frags_not_readable() as implemented i=
s
> > > > > > correct. If a new type of unreadable skbs are introduced to the=
 stack,
> > > > > > I imagine the stack would implement:
> > > > > >
> > > > > > 1. new header flag: skb->newmem
> > > > > > 2.
> > > > > >
> > > > > > static inline bool skb_frags_not_readable(const struct skb_buff=
 *skb)
> > > > > > {
> > > > > >     return skb->devmem || skb->newmem;
> > > > > > }
> > > > > >
> > > > > > 3. tcp_recvmsg_devmem() would handle skb->devmem skbs is in thi=
s patch
> > > > > > series, but tcp_recvmsg_newmem() would handle skb->newmem skbs.
> > > > >
> > > > > You copy it to the userspace in a special way because your frags
> > > > > are page_is_page_pool_iov(). I agree with David, the skb bit is
> > > > > just and optimization.
> > > > >
> > > > > For most of the core stack, it doesn't matter why your skb is not
> > > > > readable. For a few places where it matters (recvmsg?), you can
> > > > > double-check your frags (all or some) with page_is_page_pool_iov.
> > > > >
> > > >
> > > > I see, we can do that then. I.e. make the header flag 'not_readable=
'
> > > > and check the frags to decide to delegate to tcp_recvmsg_devmem() o=
r
> > > > something else. We can even assume not_readable =3D=3D devmem becau=
se
> > > > currently devmem is the only type of unreadable frag currently.
> > > >
> > > > > Unrelated: we probably need socket to dmabuf association as well =
(via
> > > > > netlink or something).
> > > >
> > > > Not sure this is possible. The dma-buf is bound to the rx-queue, an=
d
> > > > any packets that land on that rx-queue are bound to that dma-buf,
> > > > regardless of which socket that packet belongs to. So the associati=
on
> > > > IMO must be rx-queue to dma-buf, not socket to dma-buf.
> > >
> > > But there is still always 1 dmabuf to 1 socket association (on rx), r=
ight?
> > > Because otherwise, there is no way currently to tell, at recvmsg, whi=
ch
> > > dmabuf the received token belongs to.
> > >
> >
> > Yes, but this 1 dma-buf to 1 socket association happens because the
> > user binds the dma-buf to an rx-queue and configures flow steering of
> > the socket to that rx-queue.
>
> It's still fixed and won't change during the socket lifetime, right?
> And the socket has to know this association; otherwise those tokens
> are useless since they don't carry anything to identify the dmabuf.
>
> I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> it somehow implies that I have an option of passing or not passing it
> for an individual system call.
> If we know that we're going to use dmabuf with the socket, maybe we
> should move this flag to the socket() syscall?
>
> fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
>
> ?

I think it should then be a setsockopt called before any data is
exchanged, with no change of modifying mode later. We generally use
setsockopts for the mode of a socket. This use of the protocol field
in socket() for setting a mode would be novel. Also, it might miss
passively opened connections, or be overly restrictive: one approach
for all accepted child sockets.

