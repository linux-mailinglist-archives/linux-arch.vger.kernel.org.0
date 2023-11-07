Return-Path: <linux-arch+bounces-58-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C929A7E47AB
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 18:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5285E1F20FFB
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588BA34CF8;
	Tue,  7 Nov 2023 17:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJLap1Jl"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E3134CF0;
	Tue,  7 Nov 2023 17:57:46 +0000 (UTC)
Received: from mail-vk1-xa2e.google.com (mail-vk1-xa2e.google.com [IPv6:2607:f8b0:4864:20::a2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD8B8F;
	Tue,  7 Nov 2023 09:57:46 -0800 (PST)
Received: by mail-vk1-xa2e.google.com with SMTP id 71dfb90a1353d-4ac28bd2857so1437810e0c.0;
        Tue, 07 Nov 2023 09:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699379865; x=1699984665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hJLDwdQtbcEqJ84ISikkXffkpcerKJjjAJ499O5Rsqw=;
        b=iJLap1Jleii9QkdwkWkfBKVIKNPliRN4W7g5IiN6qOQ1JKgaX278NIaCtKRsK1k9Gc
         oyKwkOWxLZIQeaLU8ZjkDWxzux4C9wGIAtwLp86cFdPMXjboQCtg2nnclzrFpUGjWP16
         TNwgF8hGB0/F7C1OYnjsGVUpLnmf7L8h+Hf6wUMqWzXLv/rmU3XOXYP+kc9Ot2ql4GET
         E++HfprLZUr+SIREXYuh7BguPhDEI5CilI/2B6XWJtuHY4LPMORl0rf53leAaiXvIQPq
         Apb1uOt3HsM8BLqs33G5E3rb4yjXJR2ACqo5qph9rHz80quEa7ULQ7bnoCvafJIXXaxQ
         eLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379865; x=1699984665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hJLDwdQtbcEqJ84ISikkXffkpcerKJjjAJ499O5Rsqw=;
        b=CtxVvc/o5UUJGltZkaErbsJEa2uB5ki9T6R8UREO1c8LJ2At4y+A/c3jUTMUoWMplP
         HTrO8yzs9yeZu0r62N+timuvQeemPrRg9+WyAmp0iMyPKuDXah/TM15Lct8mJfZLpza8
         JroF/iVU5w6HjsJNcXf6wXf1xN/OSte/PpT/JUyOxFQgLEH5GKnIBw5spXWme0zNZrOB
         oYR7ptwuaiBrNYUuZq7m800yfhyOJ9WL27/VAl5A4I8Mee9FjFIiTvmFUlSf4O4Tjy+x
         H6H59yA0l9wVYC6i1rSW/25FAD3vkZ5Fpp+w/z8Ys2UQwdFohM32ZIZvMF+gnONzkjV3
         +jBw==
X-Gm-Message-State: AOJu0Yykwe0AeAb8FT1LR0U8cysnzNgDwKCMJFpU2RqpsxGYXR2M7Ppk
	oUtL/2UaIv7zZ2XzS0PLEl0ZHYe2XeoiD8b8n4A=
X-Google-Smtp-Source: AGHT+IEUh8TF0w5pIJdw8wms472waN0tELOc2hNEvcgAdbJGm0MURuEbq3Ua/fpPGyeHKcA/jLHf8qOC3gAJBGbwUL4=
X-Received: by 2002:a1f:4c07:0:b0:4ac:593b:e9f4 with SMTP id
 z7-20020a1f4c07000000b004ac593be9f4mr4919291vka.9.1699379865018; Tue, 07 Nov
 2023 09:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <ZUmBf7E8ZoTQwThL@google.com> <ZUmMBZpLPQkRS9bg@google.com>
 <CAF=yD-+tZ7xaU0rKWBuVbfdVWptj88Z=Xf4Mqx+zaC-gZ1U1mw@mail.gmail.com> <ZUp3j2TLNKhPYwch@google.com>
In-Reply-To: <ZUp3j2TLNKhPYwch@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 7 Nov 2023 12:57:08 -0500
Message-ID: <CAF=yD-Ltd0REhOS78q_t8bSEpefQsZuJV_Aq7zxXmFDh+BmJhg@mail.gmail.com>
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

On Tue, Nov 7, 2023 at 12:44=E2=80=AFPM Stanislav Fomichev <sdf@google.com>=
 wrote:
>
> On 11/06, Willem de Bruijn wrote:
> > > > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is=
 that
> > > > > > it somehow implies that I have an option of passing or not pass=
ing it
> > > > > > for an individual system call.
> > > > > > If we know that we're going to use dmabuf with the socket, mayb=
e we
> > > > > > should move this flag to the socket() syscall?
> > > > > >
> > > > > > fd =3D socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > > > > >
> > > > > > ?
> > > > >
> > > > > I think it should then be a setsockopt called before any data is
> > > > > exchanged, with no change of modifying mode later. We generally u=
se
> > > > > setsockopts for the mode of a socket. This use of the protocol fi=
eld
> > > > > in socket() for setting a mode would be novel. Also, it might mis=
s
> > > > > passively opened connections, or be overly restrictive: one appro=
ach
> > > > > for all accepted child sockets.
> > > >
> > > > I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? Th=
ere
> > > > are plenty of bits we can grab. But setsockopt works as well!
> > >
> > > To follow up: if we have this flag on a socket, not on a per-message
> > > basis, can we also use recvmsg for the recycling part maybe?
> > >
> > > while (true) {
> > >         memset(msg, 0, ...);
> > >
> > >         /* receive the tokens */
> > >         ret =3D recvmsg(fd, &msg, 0);
> > >
> > >         /* recycle the tokens from the above recvmsg() */
> > >         ret =3D recvmsg(fd, &msg, MSG_RECYCLE);
> > > }
> > >
> > > recvmsg + MSG_RECYCLE can parse the same format that regular recvmsg
> > > exports (SO_DEVMEM_OFFSET) and we can also add extra cmsg option
> > > to recycle a range.
> > >
> > > Will this be more straightforward than a setsockopt(SO_DEVMEM_DONTNEE=
D)?
> > > Or is it more confusing?
> >
> > It would have to be sendmsg, as recvmsg is a copy_to_user operation.
> >
> >
> > I am not aware of any precedent in multiplexing the data stream and a
> > control operation stream in this manner. It would also require adding
> > a branch in the sendmsg hot path.
>
> Is it too much plumbing to copy_from_user msg_control deep in recvmsg
> stack where we need it? Mixing in sendmsg is indeed ugly :-(

I tried exactly the inverse of that when originally adding
MSG_ZEROCOPY: to allow piggy-backing zerocopy completion notifications
on sendmsg calls by writing to sendmsg msg_control on return to user.
It required significant code churn, which the performance gains did
not warrant. Doing so also breaks the simple rule that recv is for
reading and send is for writing.

> Regarding hot patch: aren't we already doing copy_to_user for the tokens =
in
> this hot path, so having one extra condition shouldn't hurt too much?

We're doing that in the optional cmsg handling of recvmsg, which is
already a slow path (compared to the data read() itself).

> > The memory is associated with the socket, freed when the socket is
> > closed as well as on SO_DEVMEM_DONTNEED. Fundamentally it is a socket
> > state operation, for which setsockopt is the socket interface.
> >
> > Is your request purely a dislike, or is there some technical concern
> > with BPF and setsockopt?
>
> It's mostly because I've been bitten too much by custom socket options th=
at
> are not really on/off/update-value operations:
>
> 29ebbba7d461 - bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
> 00e74ae08638 - bpf: Don't EFAULT for getsockopt with optval=3DNULL
> 9cacf81f8161 - bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
> d8fe449a9c51 - bpf: Don't return EINVAL from {get,set}sockopt when optlen=
 > PAGE_SIZE
>
> I do agree that this particular case of SO_DEVMEM_DONTNEED seems ok, but
> things tend to evolve and change.

I see. I'm a bit concerned if we start limiting what we can do in
sockets because of dependencies that BPF processing places on them.
The use case for BPF [gs]etsockopt is limited to specific control mode
calls. Would it make sense to just exclude calls like
SO_DEVMEM_DONTNEED from this interpositioning?

At a high level what we really want is a high rate metadata path from
user to kernel. And there are no perfect solutions. From kernel to
user we use the socket error queue for this. That was never intended
for high event rate itself, dealing with ICMP errors and the like
before timestamps and zerocopy notifications were added.

If I squint hard enough I can see some prior art in mixing data and
high rate state changes within the same channel in NIC descriptor
queues, where some devices do this, e.g.,  { "insert encryption key",
"send packet" }. But fundamentally I think we should keep the socket
queues for data only.

