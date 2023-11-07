Return-Path: <linux-arch+bounces-59-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 936DA7E4803
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 19:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03301B20C3B
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 18:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 743423588D;
	Tue,  7 Nov 2023 18:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aPll66bW"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7B230CEF
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 18:14:28 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F027129
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 10:14:28 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d9ab79816a9so7157799276.3
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 10:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699380867; x=1699985667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HeHeN/xiCMz8DEWBM6X0ByYPySZA5Zqi9Xr6EDBkSs=;
        b=aPll66bWlARwkRPRwtl9t0tL+XQORS/aSFcO3RAkPU4vzASryDOwL81gKljBMo9dBg
         IY1SV4CtO1hVUfPV8ZbWr06dweCWaAmg6OSQx8E3/Zp/bPOCjEXGZKZUpsA+agmOEtgs
         BdJT2C7NT2byWGnugH/vyfvagYoL1uV/vkbTSJd1l9vUVBYEyzMt9Epiukd6GOSvvTYT
         TaNhydc7MUXdh8IInp71NWrEdcE4HSLuwTKa7WZQg01uL8NWJWzl73VNrlAogM+Kvx4w
         yY5haY2tdluVkBeMCl4iYQbLWfK6mxe2wuh4N1Mi02wvNDXShxl6qlH+fAfGks3Encrc
         Vi9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699380867; x=1699985667;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8HeHeN/xiCMz8DEWBM6X0ByYPySZA5Zqi9Xr6EDBkSs=;
        b=bkRBG2LDfhq/ciUpLmlgkeySXGV5JK86153UUHBfGYV5rIknT18nvXAnKZzmHb1Fdx
         HpkvAMZC77YBKFt5p+vPdpFrgdinlRcq/miTbAeyiPeeO0ni3N1m808rzKUscUkPKaBl
         f2B5lP5wviJk7OTks/OQJrUS9qxX6EqZed+8xJBEoB8lWiGNlyOBLwFS2CGtRfQn99y6
         bb6bZ95rZG3QcND4cY4JoAJ7IZy2MAjdbxQC0UXotpCxQ0hoMCcAIPMQzbUsXpuChvin
         b2YJNu4vVvZgvMBvUb9Vr5TmiOsRBV2pVn8gF/WuoccHEFZvFHu2J7qSLmUdVtDuxshU
         IYeA==
X-Gm-Message-State: AOJu0YwtBWGypTHD4rHMdOUQXmQjMPYnf4GMosq/JxY7t8YE6vK0frkq
	cTrXXiiPeDcZ769SrnnpONn97AA=
X-Google-Smtp-Source: AGHT+IEFH3S1Xddt5/l1kHplzp6Kf3Zu4Jc1nx0T2cx1iq2FT0uS/xoaqN5IyidpJIJBKzD/qi9XQZ0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:494:0:b0:d13:856b:c10a with SMTP id
 142-20020a250494000000b00d13856bc10amr597853ybe.3.1699380867206; Tue, 07 Nov
 2023 10:14:27 -0800 (PST)
Date: Tue, 7 Nov 2023 10:14:25 -0800
In-Reply-To: <CAF=yD-Ltd0REhOS78q_t8bSEpefQsZuJV_Aq7zxXmFDh+BmJhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <ZUmBf7E8ZoTQwThL@google.com> <ZUmMBZpLPQkRS9bg@google.com>
 <CAF=yD-+tZ7xaU0rKWBuVbfdVWptj88Z=Xf4Mqx+zaC-gZ1U1mw@mail.gmail.com>
 <ZUp3j2TLNKhPYwch@google.com> <CAF=yD-Ltd0REhOS78q_t8bSEpefQsZuJV_Aq7zxXmFDh+BmJhg@mail.gmail.com>
Message-ID: <ZUp-gYT7OMb9wun3@google.com>
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

On 11/07, Willem de Bruijn wrote:
> On Tue, Nov 7, 2023 at 12:44=E2=80=AFPM Stanislav Fomichev <sdf@google.co=
m> wrote:
> >
> > On 11/06, Willem de Bruijn wrote:
> > > > > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg =
is that
> > > > > > > it somehow implies that I have an option of passing or not pa=
ssing it
> > > > > > > for an individual system call.
> > > > > > > If we know that we're going to use dmabuf with the socket, ma=
ybe we
> > > > > > > should move this flag to the socket() syscall?
> > > > > > >
> > > > > > > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > > > > > >
> > > > > > > ?
> > > > > >
> > > > > > I think it should then be a setsockopt called before any data i=
s
> > > > > > exchanged, with no change of modifying mode later. We generally=
 use
> > > > > > setsockopts for the mode of a socket. This use of the protocol =
field
> > > > > > in socket() for setting a mode would be novel. Also, it might m=
iss
> > > > > > passively opened connections, or be overly restrictive: one app=
roach
> > > > > > for all accepted child sockets.
> > > > >
> > > > > I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? =
There
> > > > > are plenty of bits we can grab. But setsockopt works as well!
> > > >
> > > > To follow up: if we have this flag on a socket, not on a per-messag=
e
> > > > basis, can we also use recvmsg for the recycling part maybe?
> > > >
> > > > while (true) {
> > > >         memset(msg, 0, ...);
> > > >
> > > >         /* receive the tokens */
> > > >         ret =3D recvmsg(fd, &msg, 0);
> > > >
> > > >         /* recycle the tokens from the above recvmsg() */
> > > >         ret =3D recvmsg(fd, &msg, MSG_RECYCLE);
> > > > }
> > > >
> > > > recvmsg + MSG_RECYCLE can parse the same format that regular recvms=
g
> > > > exports (SO_DEVMEM_OFFSET) and we can also add extra cmsg option
> > > > to recycle a range.
> > > >
> > > > Will this be more straightforward than a setsockopt(SO_DEVMEM_DONTN=
EED)?
> > > > Or is it more confusing?
> > >
> > > It would have to be sendmsg, as recvmsg is a copy_to_user operation.
> > >
> > >
> > > I am not aware of any precedent in multiplexing the data stream and a
> > > control operation stream in this manner. It would also require adding
> > > a branch in the sendmsg hot path.
> >
> > Is it too much plumbing to copy_from_user msg_control deep in recvmsg
> > stack where we need it? Mixing in sendmsg is indeed ugly :-(
>=20
> I tried exactly the inverse of that when originally adding
> MSG_ZEROCOPY: to allow piggy-backing zerocopy completion notifications
> on sendmsg calls by writing to sendmsg msg_control on return to user.
> It required significant code churn, which the performance gains did
> not warrant. Doing so also breaks the simple rule that recv is for
> reading and send is for writing.

We're breaking so many rules here, so not sure we should be super
constrained :-D

> > Regarding hot patch: aren't we already doing copy_to_user for the token=
s in
> > this hot path, so having one extra condition shouldn't hurt too much?
>=20
> We're doing that in the optional cmsg handling of recvmsg, which is
> already a slow path (compared to the data read() itself).
>=20
> > > The memory is associated with the socket, freed when the socket is
> > > closed as well as on SO_DEVMEM_DONTNEED. Fundamentally it is a socket
> > > state operation, for which setsockopt is the socket interface.
> > >
> > > Is your request purely a dislike, or is there some technical concern
> > > with BPF and setsockopt?
> >
> > It's mostly because I've been bitten too much by custom socket options =
that
> > are not really on/off/update-value operations:
> >
> > 29ebbba7d461 - bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
> > 00e74ae08638 - bpf: Don't EFAULT for getsockopt with optval=3DNULL
> > 9cacf81f8161 - bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> > d8fe449a9c51 - bpf: Don't return EINVAL from {get,set}sockopt when optl=
en > PAGE_SIZE
> >
> > I do agree that this particular case of SO_DEVMEM_DONTNEED seems ok, bu=
t
> > things tend to evolve and change.
>=20
> I see. I'm a bit concerned if we start limiting what we can do in
> sockets because of dependencies that BPF processing places on them.
> The use case for BPF [gs]etsockopt is limited to specific control mode
> calls. Would it make sense to just exclude calls like
> SO_DEVMEM_DONTNEED from this interpositioning?

Yup, that's why I'm asking. We already have ->bpf_bypass_getsockopt()
to special-case tcp zerocopy. We might add another bpf_bypass_setsockopt
to special case SO_DEVMEM_DONTNEED. That's why I'm trying to see if
there is a better alternative.

> At a high level what we really want is a high rate metadata path from
> user to kernel. And there are no perfect solutions. From kernel to
> user we use the socket error queue for this. That was never intended
> for high event rate itself, dealing with ICMP errors and the like
> before timestamps and zerocopy notifications were added.
>
> If I squint hard enough I can see some prior art in mixing data and
> high rate state changes within the same channel in NIC descriptor
> queues, where some devices do this, e.g.,  { "insert encryption key",
> "send packet" }. But fundamentally I think we should keep the socket
> queues for data only.

+1, we keep taking an easy route with using sockopt for this :-(

Anyway, let's see if any better suggestions pop up. Worst case - we stick
with a socket option and will add a bypass on the bpf side.

