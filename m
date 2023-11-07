Return-Path: <linux-arch+bounces-55-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE6C7E475C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 18:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE161F213E7
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 17:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A6934CEC;
	Tue,  7 Nov 2023 17:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dqrtkMuV"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4A634CE8
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 17:44:51 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A93CDD6E
	for <linux-arch@vger.kernel.org>; Tue,  7 Nov 2023 09:44:50 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5afa77f9a33so81270557b3.0
        for <linux-arch@vger.kernel.org>; Tue, 07 Nov 2023 09:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699379090; x=1699983890; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UdTuJbMPNA9mg1FxCGi+kg3boA7o2BN4MhcyDntGV5Q=;
        b=dqrtkMuV+h/+WtwXjaGpqWOTwD7hMJaIaSGZxyaegAT3JpSV/d17PodC9eUV9eEJ2A
         3Rx7qL1JRhq1w23vdXeLGd+DXsHM9w0SSpeipNwjkoScuI99grfrMFrEghrY8KCracYM
         g/c1BNS888rgJEHdZke5reex6PRUpgn1qGXFLyi1jb6x23QUteC/g1LWF9mZRGS1+Pvh
         QqB7Sb/UH3kVn2cNxoyhBCYGToIUrjAz6WClbM0KulAjc7SvA85vfNKwRw1K+Qm6wUU2
         VWfqcPdkGYHMIEwkTWLLFfNw2ppl6XRtVnBFgvACb7K2jyM8QE2OtiQi/jCtgRFlhIOZ
         k7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699379090; x=1699983890;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UdTuJbMPNA9mg1FxCGi+kg3boA7o2BN4MhcyDntGV5Q=;
        b=o32N9xlHfDueZBzTSO9iV2pL8tLIFh+ltcRtRJ091HC0DVNpoVm0z5iAGspPP0EAff
         ylYuEXmG5XYuqQ+G8Fx0a+kP6jf1J8cuoMgYwRcHtseE+KfxpgzzpNQ74FDBz1SiKnnx
         q9UPuSRsxdoNPelXZNS9d2gto/FVRY2JfO/PcoDxHUtLIFn+RcFPN5//zLMHit2/Yvfb
         vUEfL4o+acQoEJq+7f9+HzjH5X/PcG2H9+HLSMrTwI3dqi7Sw9DYAEAKNT5Jjxo4Oi/p
         15BbtyGbk6rPqrXM+/z/5i7WgOzbCcczMk4coh3AucnGUiqxc3bENIAGKZlsn678vIzw
         WWBA==
X-Gm-Message-State: AOJu0YxUORYKaKcQmfxdHC+pfMfuUMgvgC4Wcx8aDMLkVsBP9rPGSEfd
	Zt/WNMGMPxiz6r/2VmXrPQiJP8U=
X-Google-Smtp-Source: AGHT+IEdiK1WEoh2+6U+bQH9Li0JSDfO/xDBtSZs6coo4v7ue+AtpEROBdggpJnmwjryu7dXhenhMCA=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8689:0:b0:d9a:3bee:255c with SMTP id
 z9-20020a258689000000b00d9a3bee255cmr578349ybk.7.1699379089844; Tue, 07 Nov
 2023 09:44:49 -0800 (PST)
Date: Tue, 7 Nov 2023 09:44:47 -0800
In-Reply-To: <CAF=yD-+tZ7xaU0rKWBuVbfdVWptj88Z=Xf4Mqx+zaC-gZ1U1mw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <ZUmBf7E8ZoTQwThL@google.com> <ZUmMBZpLPQkRS9bg@google.com> <CAF=yD-+tZ7xaU0rKWBuVbfdVWptj88Z=Xf4Mqx+zaC-gZ1U1mw@mail.gmail.com>
Message-ID: <ZUp3j2TLNKhPYwch@google.com>
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

On 11/06, Willem de Bruijn wrote:
> > > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > > > > it somehow implies that I have an option of passing or not passing it
> > > > > for an individual system call.
> > > > > If we know that we're going to use dmabuf with the socket, maybe we
> > > > > should move this flag to the socket() syscall?
> > > > >
> > > > > fd = socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > > > >
> > > > > ?
> > > >
> > > > I think it should then be a setsockopt called before any data is
> > > > exchanged, with no change of modifying mode later. We generally use
> > > > setsockopts for the mode of a socket. This use of the protocol field
> > > > in socket() for setting a mode would be novel. Also, it might miss
> > > > passively opened connections, or be overly restrictive: one approach
> > > > for all accepted child sockets.
> > >
> > > I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? There
> > > are plenty of bits we can grab. But setsockopt works as well!
> >
> > To follow up: if we have this flag on a socket, not on a per-message
> > basis, can we also use recvmsg for the recycling part maybe?
> >
> > while (true) {
> >         memset(msg, 0, ...);
> >
> >         /* receive the tokens */
> >         ret = recvmsg(fd, &msg, 0);
> >
> >         /* recycle the tokens from the above recvmsg() */
> >         ret = recvmsg(fd, &msg, MSG_RECYCLE);
> > }
> >
> > recvmsg + MSG_RECYCLE can parse the same format that regular recvmsg
> > exports (SO_DEVMEM_OFFSET) and we can also add extra cmsg option
> > to recycle a range.
> >
> > Will this be more straightforward than a setsockopt(SO_DEVMEM_DONTNEED)?
> > Or is it more confusing?
> 
> It would have to be sendmsg, as recvmsg is a copy_to_user operation.
>
>
> I am not aware of any precedent in multiplexing the data stream and a
> control operation stream in this manner. It would also require adding
> a branch in the sendmsg hot path.

Is it too much plumbing to copy_from_user msg_control deep in recvmsg
stack where we need it? Mixing in sendmsg is indeed ugly :-(

Regarding hot patch: aren't we already doing copy_to_user for the tokens in
this hot path, so having one extra condition shouldn't hurt too much?

> The memory is associated with the socket, freed when the socket is
> closed as well as on SO_DEVMEM_DONTNEED. Fundamentally it is a socket
> state operation, for which setsockopt is the socket interface.
> 
> Is your request purely a dislike, or is there some technical concern
> with BPF and setsockopt?

It's mostly because I've been bitten too much by custom socket options that
are not really on/off/update-value operations:

29ebbba7d461 - bpf: Don't EFAULT for {g,s}setsockopt with wrong optlen
00e74ae08638 - bpf: Don't EFAULT for getsockopt with optval=NULL
9cacf81f8161 - bpf: Remove extra lock_sock for TCP_ZEROCOPY_RECEIVE
d8fe449a9c51 - bpf: Don't return EINVAL from {get,set}sockopt when optlen > PAGE_SIZE

I do agree that this particular case of SO_DEVMEM_DONTNEED seems ok, but
things tend to evolve and change.

