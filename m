Return-Path: <linux-arch+bounces-6282-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45758955837
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 15:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67C891C20D3C
	for <lists+linux-arch@lfdr.de>; Sat, 17 Aug 2024 13:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F71315099D;
	Sat, 17 Aug 2024 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nGI381Y3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98A41474BC;
	Sat, 17 Aug 2024 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723903102; cv=none; b=qvzTL5K6Lzrb94Pa7uUwIFoFYWtzfuwk8G9BGRNU8vjzJdkW8oYck5F0WbHx5JhQQ2BitsdgiGqAoYyMv7OsM+MqRfYF3jYROLEsF/+DvGlcQzIfLPWllG9syLDjEhQ5bcGR0CQAEK6Wesm2V+EtuF9IiNLaKtgeIQ73vV95sEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723903102; c=relaxed/simple;
	bh=H5cONukBrXdn63nJQQg5Kig+bV6RohEW+NYcuDNt1K8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lenY7PVtzND6+22HlgQ0uaQ55aF5sUlRTzMSsEgLtDx/kNouTfkxVpzFF6lAfCcNiuMLrf84fQrHWOaA8bGO+L/oF+sLpLi7etkcgkiBDXY7FD4UDi14X0Da9Y8yzBQEltArdAL8CtojJS403OW3oTSoU0rl+GgcoN3KYJoGYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nGI381Y3; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ef2d96164aso35096531fa.3;
        Sat, 17 Aug 2024 06:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723903098; x=1724507898; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9TIBszC0lTg0a5cdvWq0x+E0HKul2PwBkMOHzpxJ40=;
        b=nGI381Y35J5R6U46ux99VVh+xZYQ+Hohk8Wwfs9tZgHIdKCCmBYjaLEvODCUCpTax8
         9ikHh8Fe80y8K9ixcQiqq3YQWz9P9E+dv08n/m34vDISP9l0MBK1SBU6ZRonGNqy+jAF
         Dz20s+H5KIJUkmIgljnENw7H1kipu4Z3GTXZfa/KgvtfQXw/SHH8ynJGI+Rlh7KC1Yoo
         f0Da3pOkK4IGISljIna2L6KvuN1eJbyBjJJmvtR4CUgjEH2CP4Yan9LNOtnPg3HopLUZ
         SS6YFq8LE2JgRvk1iEqyM2Jc/TmbtNahp2sDOyuYj6RPj1c3xISiXHYPod0JgJg6LyN3
         8klw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723903098; x=1724507898;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K9TIBszC0lTg0a5cdvWq0x+E0HKul2PwBkMOHzpxJ40=;
        b=AyE1lde6BguRZvRRsoPJRbfAeOtIEp7wSiSRWkhMIHngFQ+Sj47srcdDrb3jQKh30w
         wl8WGPQCntiLOfBnovkN2W9KWVa2ZMJa6pssZMVPStCkH31z1vBLIlZIBhgvOFmHTf23
         MYIZMsOfp/WGIus68yMy65LVNi3gvpPIYZ5Mt1BvLffU4T+r363xpBAStHBfdJ0P10vS
         iWeByQuuEBMDTReyFfEK5DX+jHD/bnBJV27Szajqzb0BElhY2qtsLokhYsfoa+ih4Wch
         ieOm2dL2sFUWeh5Azu5X9xOu2QSk6ZEQirNmweh9EJbs6DyJnobEIXASpKpSVG+zei5K
         EkdA==
X-Forwarded-Encrypted: i=1; AJvYcCWsTsnc7dp93XCpZZAhl9I+qr/UPw7jpvbCw480HHbmkOycyrQTqSKzqkNZ1WPIQ6pWegpyZaaH6AIwN/Fy6p4aKCaqqJQyIlf8dEQUWIVNsAu79O7nYaK41Vusi75zzJoP6Kk6My8kiGlNZ+xMKCcPGAKtWgMK6v72umckRpdEYx3jNSQeP+wOASwoHADHOVMQ1fRnsqUSFryENYBHcjlPin9L5XO4woTIrqbOgTyhuL5UHWZcVjyE7/GcsSnj/rv0rXPV3qquRGXLu3C/V3hDuMwl6/C+YUNW2ZiVoPlNc7ueZ/r+HHKRRIsiJyUnjFn4It5ujZcG4sJ27obDCta5imKeMp6gpY6EpmL++pthHFwNIHm+fwURMVCjXXWOcZlSddZ4rAuKnIdqS9UOpRWxLMD+/ozx9SzDtgBxjBcs6GFwlEBleW9ukehpZs3WTOSrDVQUYDUbcmN2y0eKNFYGJqzwo+xEjfC5PeFFnA==
X-Gm-Message-State: AOJu0YyQGqdIm/inO3krltQtcjczjht9Gcr+HCjUi1ZZyfjnS/d93lx+
	D+M/7zw68sqdk6lgC3njYoJaNkHfARN2E0Ls51BXCDyEW+6aDXRd6Ikq854wmQDBUT7yXsMIcto
	uJ8ptTXPMeAjR9dyRarBBnyPS9bw=
X-Google-Smtp-Source: AGHT+IGRqAI4xbQi7G5rNn6wjqK70/AWIwz2X3RJm/UJK9kycUAJz2BP4MuZfRHRppsCskJFGYPWnok88joZfAGwlcY=
X-Received: by 2002:a2e:743:0:b0:2f3:ac52:416b with SMTP id
 38308e7fff4ca-2f3be5de448mr37160891fa.35.1723903097184; Sat, 17 Aug 2024
 06:58:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240813211317.3381180-10-almasrymina@google.com>
In-Reply-To: <20240813211317.3381180-10-almasrymina@google.com>
From: Taehee Yoo <ap420073@gmail.com>
Date: Sat, 17 Aug 2024 22:58:05 +0900
Message-ID: <CAMArcTW=mg2gF_e6spPWOCuQdDAWSuKTCdCNPWGqcU1ciq30EQ@mail.gmail.com>
Subject: Re: [PATCH net-next v19 09/13] tcp: RX path for devmem TCP
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-alpha@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	bpf@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, 
	Richard Henderson <richard.henderson@linaro.org>, Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
	Matt Turner <mattst88@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Helge Deller <deller@gmx.de>, 
	Andreas Larsson <andreas@gaisler.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Ilias Apalodimas <ilias.apalodimas@linaro.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Arnd Bergmann <arnd@arndb.de>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Bagas Sanjaya <bagasdotme@gmail.com>, Christoph Hellwig <hch@infradead.org>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Pavel Begunkov <asml.silence@gmail.com>, David Wei <dw@davidwei.uk>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Shailend Chand <shailend@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Jeroen de Borst <jeroendb@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Willem de Bruijn <willemb@google.com>, 
	Kaiyuan Zhang <kaiyuanz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 6:13=E2=80=AFAM Mina Almasry <almasrymina@google.co=
m> wrote:
>

Hi Mina,

> In tcp_recvmsg_locked(), detect if the skb being received by the user
> is a devmem skb. In this case - if the user provided the MSG_SOCK_DEVMEM
> flag - pass it to tcp_recvmsg_devmem() for custom handling.
>
> tcp_recvmsg_devmem() copies any data in the skb header to the linear
> buffer, and returns a cmsg to the user indicating the number of bytes
> returned in the linear buffer.
>
> tcp_recvmsg_devmem() then loops over the unaccessible devmem skb frags,
> and returns to the user a cmsg_devmem indicating the location of the
> data in the dmabuf device memory. cmsg_devmem contains this information:
>
> 1. the offset into the dmabuf where the payload starts. 'frag_offset'.

I have been testing this patch and I found a bug.
While testing it with the ncdevmem cmd, it fails to validate buffers
after some period.
This is because tcp_recvmsg_dmabuf() can't handle skb properly when
the parameter offset !=3D 0.
The tcp_recvmsg_dmabuf() already has the code that handles skb if
offset is not 0 but it doesn't work for a specific case.

> 2. the size of the frag. 'frag_size'.
> 3. an opaque token 'frag_token' to return to the kernel when the buffer
> is to be released.
>
> The pages awaiting freeing are stored in the newly added
> sk->sk_user_frags, and each page passed to userspace is get_page()'d.
> This reference is dropped once the userspace indicates that it is
> done reading this page.  All pages are released when the socket is
> destroyed.
>
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Kaiyuan Zhang <kaiyuanz@google.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
>
> ---
>
> v16:
> - Fix number assignement (Arnd).
>
> v13:
> - Refactored user frags cleanup into a common function to avoid
>   __maybe_unused. (Pavel)
> - change to offset =3D 0 for some improved clarity.
>
> v11:
> - Refactor to common function te remove conditional lock sparse warning
>   (Paolo)
>
> v7:
> - Updated the SO_DEVMEM_* uapi to use the next available entries (Arnd).
> - Updated dmabuf_cmsg struct to be __u64 padded (Arnd).
> - Squashed fix from Eric to initialize sk_user_frags for passive
>   sockets (Eric).
>
> v6
> - skb->dmabuf -> skb->readable (Pavel)
> - Fixed asm definitions of SO_DEVMEM_LINEAR/SO_DEVMEM_DMABUF not found
>   on some archs.
> - Squashed in locking optimizations from edumazet@google.com. With this
>   change we lock the xarray once per per tcp_recvmsg_dmabuf() rather
>   than once per frag in xa_alloc().
>
> Changes in v1:
> - Added dmabuf_id to dmabuf_cmsg (David/Stan).
> - Devmem -> dmabuf (David).
> - Change tcp_recvmsg_dmabuf() check to skb->dmabuf (Paolo).
> - Use __skb_frag_ref() & napi_pp_put_page() for refcounting (Yunsheng).
>
> RFC v3:
> - Fixed issue with put_cmsg() failing silently.
>
> ---
>  arch/alpha/include/uapi/asm/socket.h  |   5 +
>  arch/mips/include/uapi/asm/socket.h   |   5 +
>  arch/parisc/include/uapi/asm/socket.h |   5 +
>  arch/sparc/include/uapi/asm/socket.h  |   5 +
>  include/linux/socket.h                |   1 +
>  include/net/netmem.h                  |  13 ++
>  include/net/sock.h                    |   2 +
>  include/uapi/asm-generic/socket.h     |   5 +
>  include/uapi/linux/uio.h              |  13 ++
>  net/ipv4/tcp.c                        | 255 +++++++++++++++++++++++++-
>  net/ipv4/tcp_ipv4.c                   |  16 ++
>  net/ipv4/tcp_minisocks.c              |   2 +
>  12 files changed, 322 insertions(+), 5 deletions(-)
>
> diff --git a/arch/alpha/include/uapi/asm/socket.h b/arch/alpha/include/ua=
pi/asm/socket.h
> index e94f621903fe..ef4656a41058 100644
> --- a/arch/alpha/include/uapi/asm/socket.h
> +++ b/arch/alpha/include/uapi/asm/socket.h
> @@ -140,6 +140,11 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/mips/include/uapi/asm/socket.h b/arch/mips/include/uapi=
/asm/socket.h
> index 60ebaed28a4c..414807d55e33 100644
> --- a/arch/mips/include/uapi/asm/socket.h
> +++ b/arch/mips/include/uapi/asm/socket.h
> @@ -151,6 +151,11 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/parisc/include/uapi/asm/socket.h b/arch/parisc/include/=
uapi/asm/socket.h
> index be264c2b1a11..2b817efd4544 100644
> --- a/arch/parisc/include/uapi/asm/socket.h
> +++ b/arch/parisc/include/uapi/asm/socket.h
> @@ -132,6 +132,11 @@
>  #define SO_PASSPIDFD           0x404A
>  #define SO_PEERPIDFD           0x404B
>
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64
> diff --git a/arch/sparc/include/uapi/asm/socket.h b/arch/sparc/include/ua=
pi/asm/socket.h
> index 682da3714686..00248fc68977 100644
> --- a/arch/sparc/include/uapi/asm/socket.h
> +++ b/arch/sparc/include/uapi/asm/socket.h
> @@ -133,6 +133,11 @@
>  #define SO_PASSPIDFD             0x0055
>  #define SO_PEERPIDFD             0x0056
>
> +#define SO_DEVMEM_LINEAR         0x0057
> +#define SCM_DEVMEM_LINEAR        SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF         0x0058
> +#define SCM_DEVMEM_DMABUF        SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
>
>
> diff --git a/include/linux/socket.h b/include/linux/socket.h
> index df9cdb8bbfb8..d18cc47e89bd 100644
> --- a/include/linux/socket.h
> +++ b/include/linux/socket.h
> @@ -327,6 +327,7 @@ struct ucred {
>                                           * plain text and require encryp=
tion
>                                           */
>
> +#define MSG_SOCK_DEVMEM 0x2000000      /* Receive devmem skbs as cmsg */
>  #define MSG_ZEROCOPY   0x4000000       /* Use user data in kernel path *=
/
>  #define MSG_SPLICE_PAGES 0x8000000     /* Splice the pages from the iter=
ator in sendmsg() */
>  #define MSG_FASTOPEN   0x20000000      /* Send data in TCP SYN */
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 284f84a312c2..84043fbdd797 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -65,6 +65,19 @@ static inline unsigned int net_iov_idx(const struct ne=
t_iov *niov)
>         return niov - net_iov_owner(niov)->niovs;
>  }
>
> +static inline unsigned long net_iov_virtual_addr(const struct net_iov *n=
iov)
> +{
> +       struct dmabuf_genpool_chunk_owner *owner =3D net_iov_owner(niov);
> +
> +       return owner->base_virtual +
> +              ((unsigned long)net_iov_idx(niov) << PAGE_SHIFT);
> +}
> +
> +static inline u32 net_iov_binding_id(const struct net_iov *niov)
> +{
> +       return net_iov_owner(niov)->binding->id;
> +}
> +
>  static inline struct net_devmem_dmabuf_binding *
>  net_iov_binding(const struct net_iov *niov)
>  {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index cce23ac4d514..f8ec869be238 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -337,6 +337,7 @@ struct sk_filter;
>    *    @sk_txtime_report_errors: set report errors mode for SO_TXTIME
>    *    @sk_txtime_unused: unused txtime flags
>    *    @ns_tracker: tracker for netns reference
> +  *    @sk_user_frags: xarray of pages the user is holding a reference o=
n.
>    */
>  struct sock {
>         /*
> @@ -542,6 +543,7 @@ struct sock {
>  #endif
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> +       struct xarray           sk_user_frags;
>  };
>
>  struct sock_bh_locked {
> diff --git a/include/uapi/asm-generic/socket.h b/include/uapi/asm-generic=
/socket.h
> index 8ce8a39a1e5f..e993edc9c0ee 100644
> --- a/include/uapi/asm-generic/socket.h
> +++ b/include/uapi/asm-generic/socket.h
> @@ -135,6 +135,11 @@
>  #define SO_PASSPIDFD           76
>  #define SO_PEERPIDFD           77
>
> +#define SO_DEVMEM_LINEAR       78
> +#define SCM_DEVMEM_LINEAR      SO_DEVMEM_LINEAR
> +#define SO_DEVMEM_DMABUF       79
> +#define SCM_DEVMEM_DMABUF      SO_DEVMEM_DMABUF
> +
>  #if !defined(__KERNEL__)
>
>  #if __BITS_PER_LONG =3D=3D 64 || (defined(__x86_64__) && defined(__ILP32=
__))
> diff --git a/include/uapi/linux/uio.h b/include/uapi/linux/uio.h
> index 059b1a9147f4..3a22ddae376a 100644
> --- a/include/uapi/linux/uio.h
> +++ b/include/uapi/linux/uio.h
> @@ -20,6 +20,19 @@ struct iovec
>         __kernel_size_t iov_len; /* Must be size_t (1003.1g) */
>  };
>
> +struct dmabuf_cmsg {
> +       __u64 frag_offset;      /* offset into the dmabuf where the frag =
starts.
> +                                */
> +       __u32 frag_size;        /* size of the frag. */
> +       __u32 frag_token;       /* token representing this frag for
> +                                * DEVMEM_DONTNEED.
> +                                */
> +       __u32  dmabuf_id;       /* dmabuf id this frag belongs to. */
> +       __u32 flags;            /* Currently unused. Reserved for future
> +                                * uses.
> +                                */
> +};
> +
>  /*
>   *     UIO_MAXIOV shall be at least 16 1003.1g (5.4.1.1)
>   */
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 30e0aa38ba9b..40e7335dae6e 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -471,6 +471,7 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> +       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
>  }
>  EXPORT_SYMBOL(tcp_init_sock);
>
> @@ -2323,6 +2324,220 @@ static int tcp_inq_hint(struct sock *sk)
>         return inq;
>  }
>
> +/* batch __xa_alloc() calls and reduce xa_lock()/xa_unlock() overhead. *=
/
> +struct tcp_xa_pool {
> +       u8              max; /* max <=3D MAX_SKB_FRAGS */
> +       u8              idx; /* idx <=3D max */
> +       __u32           tokens[MAX_SKB_FRAGS];
> +       netmem_ref      netmems[MAX_SKB_FRAGS];
> +};
> +
> +static void tcp_xa_pool_commit_locked(struct sock *sk, struct tcp_xa_poo=
l *p)
> +{
> +       int i;
> +
> +       /* Commit part that has been copied to user space. */
> +       for (i =3D 0; i < p->idx; i++)
> +               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_EN=
TRY,
> +                            (__force void *)p->netmems[i], GFP_KERNEL);
> +       /* Rollback what has been pre-allocated and is no longer needed. =
*/
> +       for (; i < p->max; i++)
> +               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> +
> +       p->max =3D 0;
> +       p->idx =3D 0;
> +}
> +
> +static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
> +{
> +       if (!p->max)
> +               return;
> +
> +       xa_lock_bh(&sk->sk_user_frags);
> +
> +       tcp_xa_pool_commit_locked(sk, p);
> +
> +       xa_unlock_bh(&sk->sk_user_frags);
> +}
> +
> +static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> +                             unsigned int max_frags)
> +{
> +       int err, k;
> +
> +       if (p->idx < p->max)
> +               return 0;
> +
> +       xa_lock_bh(&sk->sk_user_frags);
> +
> +       tcp_xa_pool_commit_locked(sk, p);
> +
> +       for (k =3D 0; k < max_frags; k++) {
> +               err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> +                                XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
> +               if (err)
> +                       break;
> +       }
> +
> +       xa_unlock_bh(&sk->sk_user_frags);
> +
> +       p->max =3D k;
> +       p->idx =3D 0;
> +       return k ? 0 : err;
> +}
> +
> +/* On error, returns the -errno. On success, returns number of bytes sen=
t to the
> + * user. May not consume all of @remaining_len.
> + */
> +static int tcp_recvmsg_dmabuf(struct sock *sk, const struct sk_buff *skb=
,
> +                             unsigned int offset, struct msghdr *msg,
> +                             int remaining_len)
> +{
> +       struct dmabuf_cmsg dmabuf_cmsg =3D { 0 };
> +       struct tcp_xa_pool tcp_xa_pool;
> +       unsigned int start;
> +       int i, copy, n;
> +       int sent =3D 0;
> +       int err =3D 0;
> +
> +       tcp_xa_pool.max =3D 0;
> +       tcp_xa_pool.idx =3D 0;
> +       do {
> +               start =3D skb_headlen(skb);
> +
> +               if (skb_frags_readable(skb)) {
> +                       err =3D -ENODEV;
> +                       goto out;
> +               }
> +
> +               /* Copy header. */
> +               copy =3D start - offset;
> +               if (copy > 0) {
> +                       copy =3D min(copy, remaining_len);
> +
> +                       n =3D copy_to_iter(skb->data + offset, copy,
> +                                        &msg->msg_iter);
> +                       if (n !=3D copy) {
> +                               err =3D -EFAULT;
> +                               goto out;
> +                       }
> +
> +                       offset +=3D copy;
> +                       remaining_len -=3D copy;
> +
> +                       /* First a dmabuf_cmsg for # bytes copied to user
> +                        * buffer.
> +                        */
> +                       memset(&dmabuf_cmsg, 0, sizeof(dmabuf_cmsg));
> +                       dmabuf_cmsg.frag_size =3D copy;
> +                       err =3D put_cmsg(msg, SOL_SOCKET, SO_DEVMEM_LINEA=
R,
> +                                      sizeof(dmabuf_cmsg), &dmabuf_cmsg)=
;
> +                       if (err || msg->msg_flags & MSG_CTRUNC) {
> +                               msg->msg_flags &=3D ~MSG_CTRUNC;
> +                               if (!err)
> +                                       err =3D -ETOOSMALL;
> +                               goto out;
> +                       }
> +
> +                       sent +=3D copy;
> +
> +                       if (remaining_len =3D=3D 0)
> +                               goto out;
> +               }
> +
> +               /* after that, send information of dmabuf pages through a
> +                * sequence of cmsg
> +                */
> +               for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +                       skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
> +                       struct net_iov *niov;
> +                       u64 frag_offset;
> +                       int end;
> +
> +                       /* !skb_frags_readable() should indicate that ALL=
 the
> +                        * frags in this skb are dmabuf net_iovs. We're c=
hecking
> +                        * for that flag above, but also check individual=
 frags
> +                        * here. If the tcp stack is not setting
> +                        * skb_frags_readable() correctly, we still don't=
 want
> +                        * to crash here.
> +                        */
> +                       if (!skb_frag_net_iov(frag)) {
> +                               net_err_ratelimited("Found non-dmabuf skb=
 with net_iov");
> +                               err =3D -ENODEV;
> +                               goto out;
> +                       }
> +
> +                       niov =3D skb_frag_net_iov(frag);
> +                       end =3D start + skb_frag_size(frag);
> +                       copy =3D end - offset;
> +
> +                       if (copy > 0) {
> +                               copy =3D min(copy, remaining_len);
> +
> +                               frag_offset =3D net_iov_virtual_addr(niov=
) +
> +                                             skb_frag_off(frag) + offset=
 -
> +                                             start;
> +                               dmabuf_cmsg.frag_offset =3D frag_offset;
> +                               dmabuf_cmsg.frag_size =3D copy;
> +                               err =3D tcp_xa_pool_refill(sk, &tcp_xa_po=
ol,
> +                                                        skb_shinfo(skb)-=
>nr_frags - i);
> +                               if (err)
> +                                       goto out;
> +
> +                               /* Will perform the exchange later */
> +                               dmabuf_cmsg.frag_token =3D tcp_xa_pool.to=
kens[tcp_xa_pool.idx];
> +                               dmabuf_cmsg.dmabuf_id =3D net_iov_binding=
_id(niov);
> +
> +                               offset +=3D copy;
> +                               remaining_len -=3D copy;
> +
> +                               err =3D put_cmsg(msg, SOL_SOCKET,
> +                                              SO_DEVMEM_DMABUF,
> +                                              sizeof(dmabuf_cmsg),
> +                                              &dmabuf_cmsg);
> +                               if (err || msg->msg_flags & MSG_CTRUNC) {
> +                                       msg->msg_flags &=3D ~MSG_CTRUNC;
> +                                       if (!err)
> +                                               err =3D -ETOOSMALL;
> +                                       goto out;
> +                               }
> +
> +                               atomic_long_inc(&niov->pp_ref_count);
> +                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
=3D skb_frag_netmem(frag);
> +
> +                               sent +=3D copy;
> +
> +                               if (remaining_len =3D=3D 0)
> +                                       goto out;
> +                       }
> +                       start =3D end;
> +               }
> +
> +               tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +               if (!remaining_len)
> +                       goto out;
> +
> +               /* if remaining_len is not satisfied yet, we need to go t=
o the
> +                * next frag in the frag_list to satisfy remaining_len.
> +                */
> +               skb =3D skb_shinfo(skb)->frag_list ?: skb->next;
> +
> +               offset =3D 0;

If the offset is 5000 and only 4500 bytes are skipped at this point,
the offset should be 500, not 0.
We need to add a condition to set the offset correctly.

> +       } while (skb);
> +
> +       if (remaining_len) {
> +               err =3D -EFAULT;
> +               goto out;
> +       }
> +
> +out:
> +       tcp_xa_pool_commit(sk, &tcp_xa_pool);
> +       if (!sent)
> +               sent =3D err;
> +
> +       return sent;
> +}
> +
>  /*
>   *     This routine copies from a sock struct into the user buffer.
>   *
> @@ -2336,6 +2551,7 @@ static int tcp_recvmsg_locked(struct sock *sk, stru=
ct msghdr *msg, size_t len,
>                               int *cmsg_flags)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
> +       int last_copied_dmabuf =3D -1; /* uninitialized */
>         int copied =3D 0;
>         u32 peek_seq;
>         u32 *seq;
> @@ -2515,15 +2731,44 @@ static int tcp_recvmsg_locked(struct sock *sk, st=
ruct msghdr *msg, size_t len,
>                 }
>
>                 if (!(flags & MSG_TRUNC)) {
> -                       err =3D skb_copy_datagram_msg(skb, offset, msg, u=
sed);
> -                       if (err) {
> -                               /* Exception. Bailout! */
> -                               if (!copied)
> -                                       copied =3D -EFAULT;
> +                       if (last_copied_dmabuf !=3D -1 &&
> +                           last_copied_dmabuf !=3D !skb_frags_readable(s=
kb))
>                                 break;
> +
> +                       if (skb_frags_readable(skb)) {
> +                               err =3D skb_copy_datagram_msg(skb, offset=
, msg,
> +                                                           used);
> +                               if (err) {
> +                                       /* Exception. Bailout! */
> +                                       if (!copied)
> +                                               copied =3D -EFAULT;
> +                                       break;
> +                               }
> +                       } else {
> +                               if (!(flags & MSG_SOCK_DEVMEM)) {
> +                                       /* dmabuf skbs can only be receiv=
ed
> +                                        * with the MSG_SOCK_DEVMEM flag.
> +                                        */
> +                                       if (!copied)
> +                                               copied =3D -EFAULT;
> +
> +                                       break;
> +                               }
> +
> +                               err =3D tcp_recvmsg_dmabuf(sk, skb, offse=
t, msg,
> +                                                        used);
> +                               if (err <=3D 0) {
> +                                       if (!copied)
> +                                               copied =3D -EFAULT;
> +
> +                                       break;
> +                               }
> +                               used =3D err;
>                         }
>                 }
>
> +               last_copied_dmabuf =3D !skb_frags_readable(skb);
> +
>                 WRITE_ONCE(*seq, *seq + used);
>                 copied +=3D used;
>                 len -=3D used;
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index fd17f25ff288..f3b2ae0823c4 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -79,6 +79,7 @@
>  #include <linux/seq_file.h>
>  #include <linux/inetdevice.h>
>  #include <linux/btf_ids.h>
> +#include <linux/skbuff_ref.h>
>
>  #include <crypto/hash.h>
>  #include <linux/scatterlist.h>
> @@ -2507,10 +2508,25 @@ static void tcp_md5sig_info_free_rcu(struct rcu_h=
ead *head)
>  }
>  #endif
>
> +static void tcp_release_user_frags(struct sock *sk)
> +{
> +#ifdef CONFIG_PAGE_POOL
> +       unsigned long index;
> +       void *netmem;
> +
> +       xa_for_each(&sk->sk_user_frags, index, netmem)
> +               WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem=
));
> +#endif
> +}
> +
>  void tcp_v4_destroy_sock(struct sock *sk)
>  {
>         struct tcp_sock *tp =3D tcp_sk(sk);
>
> +       tcp_release_user_frags(sk);
> +
> +       xa_destroy(&sk->sk_user_frags);
> +
>         trace_tcp_destroy_sock(sk);
>
>         tcp_clear_xmit_timers(sk);
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index a19a9dbd3409..9ab87a41255d 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -625,6 +625,8 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
>         __TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>
> +       xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> +
>         return newsk;
>  }
>  EXPORT_SYMBOL(tcp_create_openreq_child);
> --
> 2.46.0.76.ge559c4bf1a-goog
>

I have been testing with modified code like below, it has been working
correctly for 24+ hours.
This modification is only for simple testing.
So, could you please look into this problem?

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 40e7335dae6e..b9df6ac28477 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2396,9 +2396,11 @@ static int tcp_recvmsg_dmabuf(struct sock *sk,
const struct sk_buff *skb,
       struct dmabuf_cmsg dmabuf_cmsg =3D { 0 };
       struct tcp_xa_pool tcp_xa_pool;
       unsigned int start;
+       int skip =3D offset;
       int i, copy, n;
       int sent =3D 0;
       int err =3D 0;
+       int end =3D 0;

       tcp_xa_pool.max =3D 0;
       tcp_xa_pool.idx =3D 0;
@@ -2452,7 +2454,6 @@ static int tcp_recvmsg_dmabuf(struct sock *sk,
const struct sk_buff *skb,
                       skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
                       struct net_iov *niov;
                       u64 frag_offset;
-                       int end;

                       /* !skb_frags_readable() should indicate that ALL th=
e
                        * frags in this skb are dmabuf net_iovs. We're chec=
king
@@ -2522,7 +2523,14 @@ static int tcp_recvmsg_dmabuf(struct sock *sk,
const struct sk_buff *skb,
                */
               skb =3D skb_shinfo(skb)->frag_list ?: skb->next;

-               offset =3D 0;
+               if (skip > 0) {
+                       skip -=3D end;
+                       offset =3D skip;
+               }
+               if (skip <=3D 0) {
+                       offset =3D 0;
+                       skip =3D 0;
+               }
       } while (skb);

       if (remaining_len) {

Thanks a lot!
Taehee Yoo

