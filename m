Return-Path: <linux-arch+bounces-19-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F17D7E32E2
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 03:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D4E1C20866
	for <lists+linux-arch@lfdr.de>; Tue,  7 Nov 2023 02:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B267F1C15;
	Tue,  7 Nov 2023 02:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZeUXNkUk"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562181873;
	Tue,  7 Nov 2023 02:24:07 +0000 (UTC)
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 168A810A;
	Mon,  6 Nov 2023 18:24:06 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id a1e0cc1a2514c-7bae8dd095cso1090513241.3;
        Mon, 06 Nov 2023 18:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699323845; x=1699928645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Q8/hIJ+hXi3TTC8/M5hN/3Tp+g8W2vvsh36FqMl8LBI=;
        b=ZeUXNkUkEAD86r01uHPG6TgNxX6+5wueRdXmJsrqE9RANKgKnva9FnungImtWF4auG
         OejF+mbKp1zpxbdXEZZz9GXorHl1Ib41JaoeT9R1pMDf+f3Ze9eFkL9zX75+TzW/0GIm
         uoIzO4zGmS/bzdFJwYzf3+CyzDrfmSRj2FFt2X5Re8ddL0t50Y4DF98aA8THpgozwCyo
         uZTgvowxp5PADFubpAOQ2LcSv8Ojpyo1XYzJmuGTEmSh2eomPW8cwtIQ4GOGXguDV/aO
         Y1kEH7U3wjPT6gpMV/8hlwCcd1U/CnMeWJ36GS1lmIQpgb8IVHIHcTEiSDOwQ+kjh6ET
         vWZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699323845; x=1699928645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q8/hIJ+hXi3TTC8/M5hN/3Tp+g8W2vvsh36FqMl8LBI=;
        b=HgeICBFKKUMeM9f0/biMIYhUIgtEM7lkUKYkawgeJADtGxEB7MOPgAWOifisn8XoN6
         TUPCymDgzbzaOTEw1Alj/K51TAcU5U3RImAZ7/MQgvAq9OqqZB402t+c+n0nXf33Dhyt
         0x7oeCb+YeE7aJxG12BmEb7jVGOsBz9cl3enbSyx60OJOzZ+40NV6PpufKBkczPlN7Po
         csLF+niFpdrbO0eaXsigJy5e6sisS/zWPNLsv0FfldSetYTNkkzBz8koB6bIIAh2QSUu
         sgS/PgF22JngvvVVz6ZsUij+fqcVz/CSnnkxZu6jeqU/ixMHVNnpNdDPSarz3iODTVrC
         CD3Q==
X-Gm-Message-State: AOJu0YyT8z6i13WYIRc4m9AEC0/FOmKfEspSZHE/GfNCThP0aNbMe3GF
	xackt9R8ZcBsYFRpQzVEjPa96ygTz4nTh9vXvI/tQl3lWsM=
X-Google-Smtp-Source: AGHT+IFMLt/VUG6TU/4hOSl6RqKh7SB0dwBaFHv9+9I37C28wvAczM3wwtVldLZdBo8d+kzaH5f944U0PquGa1Yz4yU=
X-Received: by 2002:a67:e10a:0:b0:45e:9611:7b71 with SMTP id
 d10-20020a67e10a000000b0045e96117b71mr6126361vsl.27.1699323845025; Mon, 06
 Nov 2023 18:24:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUk03DhWxV-bOFJL@google.com> <19129763-6f74-4b04-8a5f-441255b76d34@kernel.org>
 <CAHS8izMrnVUfbbS=OcJ6JT9SZRRfZ2MC7UnggthpZT=zf2BGLA@mail.gmail.com>
 <ZUlhu4hlTaqR3CTh@google.com> <CAHS8izMaAhoae5ChnzO4gny1cYYnqV1cB8MC2cAF3eoyt+Sf4A@mail.gmail.com>
 <ZUlvzm24SA3YjirV@google.com> <CAHS8izMQ5Um_ScY0VgAjaEaT-hRh4tFoTgc6Xr9Tj5rEj0fijA@mail.gmail.com>
 <CAKH8qBsbh8qYxNHZ6111RQFFpNWbWZtg0LDXkn15xcsbAq4R6w@mail.gmail.com>
 <CAF=yD-+BuKXoVL8UF+No1s0TsHSzBTz7UrB1Djt_BrM74uLLcg@mail.gmail.com>
 <ZUmBf7E8ZoTQwThL@google.com> <ZUmMBZpLPQkRS9bg@google.com>
In-Reply-To: <ZUmMBZpLPQkRS9bg@google.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 6 Nov 2023 20:23:28 -0600
Message-ID: <CAF=yD-+tZ7xaU0rKWBuVbfdVWptj88Z=Xf4Mqx+zaC-gZ1U1mw@mail.gmail.com>
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

> > > > I think my other issue with MSG_SOCK_DEVMEM being on recvmsg is that
> > > > it somehow implies that I have an option of passing or not passing it
> > > > for an individual system call.
> > > > If we know that we're going to use dmabuf with the socket, maybe we
> > > > should move this flag to the socket() syscall?
> > > >
> > > > fd = socket(AF_INET6, SOCK_STREAM, SOCK_DEVMEM);
> > > >
> > > > ?
> > >
> > > I think it should then be a setsockopt called before any data is
> > > exchanged, with no change of modifying mode later. We generally use
> > > setsockopts for the mode of a socket. This use of the protocol field
> > > in socket() for setting a mode would be novel. Also, it might miss
> > > passively opened connections, or be overly restrictive: one approach
> > > for all accepted child sockets.
> >
> > I was thinking this is similar to SOCK_CLOEXEC or SOCK_NONBLOCK? There
> > are plenty of bits we can grab. But setsockopt works as well!
>
> To follow up: if we have this flag on a socket, not on a per-message
> basis, can we also use recvmsg for the recycling part maybe?
>
> while (true) {
>         memset(msg, 0, ...);
>
>         /* receive the tokens */
>         ret = recvmsg(fd, &msg, 0);
>
>         /* recycle the tokens from the above recvmsg() */
>         ret = recvmsg(fd, &msg, MSG_RECYCLE);
> }
>
> recvmsg + MSG_RECYCLE can parse the same format that regular recvmsg
> exports (SO_DEVMEM_OFFSET) and we can also add extra cmsg option
> to recycle a range.
>
> Will this be more straightforward than a setsockopt(SO_DEVMEM_DONTNEED)?
> Or is it more confusing?

It would have to be sendmsg, as recvmsg is a copy_to_user operation.

I am not aware of any precedent in multiplexing the data stream and a
control operation stream in this manner. It would also require adding
a branch in the sendmsg hot path.

The memory is associated with the socket, freed when the socket is
closed as well as on SO_DEVMEM_DONTNEED. Fundamentally it is a socket
state operation, for which setsockopt is the socket interface.

Is your request purely a dislike, or is there some technical concern
with BPF and setsockopt?

