Return-Path: <linux-arch+bounces-15753-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D0BD14830
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 18:49:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE9CC304C024
	for <lists+linux-arch@lfdr.de>; Mon, 12 Jan 2026 17:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A5537E313;
	Mon, 12 Jan 2026 17:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzVBxrs2"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB13793B0
	for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768239754; cv=none; b=qZH9iKlvvpDqKcQXmB1D0VUgO2Nce13wRl7yeyGpL89Ec+X5mh1K+Pk8FTUB9n/5xW2qOVSDbZLKu5hGD4lvKD9+kwhsNKiQ2JjRnAA1jTdggGJASmXlKqK36Ht4Gc3p3VVpHRAjhMaH4kX5l7/JirlYjS4mhjRp+UymNNkux5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768239754; c=relaxed/simple;
	bh=Cm7DK/cmuZO7++kHeCLRWnZOxLDXNvaTWg7bEhi74NI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WjvYHc0DNcsOKo0Q00huWkARNHikPahyaR/zvQB1BuJ4hafiRnohS5LAO9Mol7/verR4i0NgC7Fvyzi4pAQsVkr014ROvSgju3DC3qyaf569f0H6S+mlGhARIxHC1Lhst4C1XPcC6Rbde0nzkQVJWzHpbMnZl3Bzv81iATKMHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzVBxrs2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-78f89501423so59614857b3.1
        for <linux-arch@vger.kernel.org>; Mon, 12 Jan 2026 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768239751; x=1768844551; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ltt64Hk4oANQtgxeZStZ3sa7MW9lOhxGi3Zr0GXzXhU=;
        b=dzVBxrs2dfsEmmqvxQOWGrYcwmrvipmRSxNmQr6yTgmiRmJaD151RvoHJaCIwCiEBI
         ILMKkZhUt5w8cNfcrbXychHY7AIt1lLrwECFf2L+sEdrSnLtB1lDWiVPzBzNHE+0sW7g
         Imadmb6MVdVgKiB1q7iCu7hFlUFi/4+32KU26TZcj1NBbATL+4dMddA1Ib5uo6Lp7Ykw
         JaWwhsT0EFzU5LEbOpGk/ONaCO/E8k/wBoW23TtJPYmSmEfPkUzWNP+jbYXstz8pN1v8
         +SsnnvticStr4pRkrd5Seq5Lx8W5eyFoFy/dY7x8tHLaLiiRwN3wP60rWqSJDvr29cnn
         XElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768239751; x=1768844551;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ltt64Hk4oANQtgxeZStZ3sa7MW9lOhxGi3Zr0GXzXhU=;
        b=U0IU0FTlSwPvthzfuqbMKtQfirwgsak4am2wI4/yfO7Tv71o9YexvxXOB805Fl7tin
         Q0zSVi7vpY78gYg+DOdRLjIBsKMeBnKI/8pE54smNafWpKntuJlQQ34qCXxhd1VAZNxh
         kDiu9N/1IwD67bn1YqOlvqCbZ3N2ccqKZ6QoF1AxKc1r+cVSzRfuk4uH4eJxWlAgosFP
         KO7GmqI8dmI+hVewH8HfqCdCsRW3bAGKrLyzKrSeWKYAoyNFZxwxF2u3trWEnBais70r
         4hh6hjHV2JKzIn1obazfx9U7Ny2WQXmGZYU44xkBM4M9JBpV/ImgXIz3Pnqz5pelHycx
         IW1w==
X-Forwarded-Encrypted: i=1; AJvYcCUV4QpTDC/g1Qc5IY1hNEWWiG1jY/qxZ+Dba0c+WMJad92GYHtIrO0acaQgLdzXni+luxdsl1PIyU6X@vger.kernel.org
X-Gm-Message-State: AOJu0YxN1bfQo7ZPITAleY/h9R7gAxxksstziifOdWBTqf97PBtX+dMv
	6vr6gCYlwgLAleGIpJzhDIpNsfpVqPszKBqLqyQRxrgxjn4Iu/SbwoSg
X-Gm-Gg: AY/fxX6Aqd0mKsQW2DP8K3JK7QGJJZZjVDTh062xhGnS+HoTk1/VoLO2E8qOqYe9gaj
	/J2FOKUYaBeCOVYM66rMBATXbTGtLUIXB3aKXFJCx8duPAeXeVRRLa68ZSI7yW5TZgINrHQlsOM
	eugOnsni3NXshVHaCtndn+buJHw8Iu/wXd1rnY+QRv8ZwVMLSitX1vl/+PiBO45ktFDRMV/2f8T
	Vzus+XDSEP9oGxPSo6goU/lxwR8vaCDDbL+yHLuaBgGv/8l5XyVGd3yaql8IbTOkITys6iHDPbL
	KvUslzBOikj6lC8SV1HyA5++5bAkj39vjVSGUMWlPIiNtw+3RLbpaqEcv4kEAYs5Oz/mt7MUDAY
	kb0vdDv2p+zASqZcWDYu9F6fWnW19q+Fe5yyHmf+uG05XXrOGxgNRiPfkM2MMbWR8qtnGs87j35
	zT88XrWWPPMgO31PpckYGWFESox5ZX9cj6rw==
X-Google-Smtp-Source: AGHT+IGePTbS8MBZGLV/vEFuuKhqk1pnCCg3qiB1B2HbrGQM5xdLs8V4Lp93OzgI35Vj+hBrcCD+xQ==
X-Received: by 2002:a53:e142:0:b0:644:5317:4bd1 with SMTP id 956f58d0204a3-648f61ff387mr135871d50.9.1768239751187;
        Mon, 12 Jan 2026 09:42:31 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c52b3sm8237287d50.25.2026.01.12.09.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 09:42:30 -0800 (PST)
Date: Mon, 12 Jan 2026 09:42:29 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 3/5] net: devmem: implement autorelease token
 management
Message-ID: <aWUyhV0xKSlhPlGu@devvm11784.nha0.facebook.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
 <CAHS8izO2B28570suitsL4HhakOC0FaCapD0w7K_U4SWMsvDmsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izO2B28570suitsL4HhakOC0FaCapD0w7K_U4SWMsvDmsg@mail.gmail.com>

On Sun, Jan 11, 2026 at 11:27:14AM -0800, Mina Almasry wrote:
> On Sun, Jan 11, 2026 at 11:12 AM Mina Almasry <almasrymina@google.com> wrote:
> >
> > On Fri, Jan 9, 2026 at 6:19 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > >
> > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > >
> > > Add support for autorelease toggling of tokens using a static branch to
> > > control system-wide behavior. This allows applications to choose between
> > > two memory management modes:
> > >
> > > 1. Autorelease on: Leaked tokens are automatically released when the
> > >    socket closes.
> > >
> > > 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
> > >
> > > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> > > attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
> > > binding is disallowed and is rejected by netlink. The system will be
> > > "locked" into the mode that the first binding is set to. It can only be
> > > changed again once there are zero bindings on the system.
> > >
> > > Disabling autorelease offers ~13% improvement in CPU utilization.
> > >
> > > Static branching is used to limit the system to one mode or the other.
> > >
> > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > ---
> > > Changes in v9:
> > > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=n
> > > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> > >   stubbed out when NET_DEVMEM=n
> > > - only dec rx binding count for rx bindings in free (v8 did not exclude
> > >   TX bindings)
> > >
> > > Changes in v8:
> > > - Only reset static key when bindings go to zero, defaulting back to
> > >   disabled (Stan).
> > > - Fix bad usage of xarray spinlock for sleepy static branch switching,
> > >   use mutex instead.
> > > - Access pp_ref_count via niov->desc instead of niov directly.
> > > - Move reset of static key to __net_devmem_dmabuf_binding_free() so that
> > >   the static key can not be changed while there are outstanding tokens
> > >   (free is only called when reference count reaches zero).
> > > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
> > >   even after xa_erase(), so static key changes must wait until all
> > >   RX bindings are finally freed (not just when xarray is empty). A
> > >   counter is a simple way to track this.
> > > - socket takes reference on the binding, to avoid use-after-free on
> > >   sk_devmem_info.binding in the case that user releases all tokens,
> > >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > > - removed some comments that were unnecessary
> > >
> > > Changes in v7:
> > > - implement autorelease with static branch (Stan)
> > > - use netlink instead of sockopt (Stan)
> > > - merge uAPI and implementation patches into one patch (seemed less
> > >   confusing)
> > >
> > > Changes in v6:
> > > - remove sk_devmem_info.autorelease, using binding->autorelease instead
> > > - move binding->autorelease check to outside of
> > >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > > - remove overly defensive net_is_devmem_iov() (Mina)
> > > - add comment about multiple urefs mapping to a single netmem ref (Mina)
> > > - remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
> > > - use niov without casting back and forth with netmem (Mina)
> > > - move the autorelease flag from per-binding to per-socket (Mina)
> > > - remove the batching logic in sock_devmem_dontneed_manual_release()
> > >   (Mina)
> > > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > > - remove single-binding restriction for autorelease mode (Mina)
> > > - unbind always checks for leaked urefs
> > >
> > > Changes in v5:
> > > - remove unused variables
> > > - introduce autorelease flag, preparing for future patch toggle new
> > >   behavior
> > >
> > > Changes in v3:
> > > - make urefs per-binding instead of per-socket, reducing memory
> > >   footprint
> > > - fallback to cleaning up references in dmabuf unbind if socket leaked
> > >   tokens
> > > - drop ethtool patch
> > >
> > > Changes in v2:
> > > - always use GFP_ZERO for binding->vec (Mina)
> > > - remove WARN for changed binding (Mina)
> > > - remove extraneous binding ref get (Mina)
> > > - remove WARNs on invalid user input (Mina)
> > > - pre-assign niovs in binding->vec for RX case (Mina)
> > > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > > - fix length of alloc for urefs
> > > ---
> > >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> > >  include/net/netmem.h                    |   1 +
> > >  include/net/sock.h                      |   7 ++-
> > >  include/uapi/linux/netdev.h             |   1 +
> > >  net/core/devmem.c                       | 104 ++++++++++++++++++++++++++++----
> > >  net/core/devmem.h                       |  27 ++++++++-
> > >  net/core/netdev-genl-gen.c              |   5 +-
> > >  net/core/netdev-genl.c                  |  10 ++-
> > >  net/core/sock.c                         |  57 +++++++++++++++--
> > >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++-----
> > >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> > >  net/ipv4/tcp_minisocks.c                |   3 +-
> > >  tools/include/uapi/linux/netdev.h       |   1 +
> > >  13 files changed, 269 insertions(+), 46 deletions(-)
> > >
> > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > index 596c306ce52b..7cbe9e7b9ee5 100644
> > > --- a/Documentation/netlink/specs/netdev.yaml
> > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > @@ -562,6 +562,17 @@ attribute-sets:
> > >          type: u32
> > >          checks:
> > >            min: 1
> > > +      -
> > > +        name: autorelease
> > > +        doc: |
> > > +          Token autorelease mode. If true (1), leaked tokens are automatically
> > > +          released when the socket closes. If false (0), leaked tokens are only
> > > +          released when the dmabuf is unbound. Once a binding is created with a
> > > +          specific mode, all subsequent bindings system-wide must use the same
> > > +          mode.
> > > +
> > > +          Optional. Defaults to false if not specified.
> > > +        type: u8
> > >
> > >  operations:
> > >    list:
> > > @@ -769,6 +780,7 @@ operations:
> > >              - ifindex
> > >              - fd
> > >              - queues
> > > +            - autorelease
> > >          reply:
> > >            attributes:
> > >              - id
> > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > index 9e10f4ac50c3..80d2263ba4ed 100644
> > > --- a/include/net/netmem.h
> > > +++ b/include/net/netmem.h
> > > @@ -112,6 +112,7 @@ struct net_iov {
> > >         };
> > >         struct net_iov_area *owner;
> > >         enum net_iov_type type;
> > > +       atomic_t uref;
> > >  };
> > >
> > >  struct net_iov_area {
> > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > > --- a/include/net/sock.h
> > > +++ b/include/net/sock.h
> > > @@ -352,7 +352,7 @@ struct sk_filter;
> > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > >    *    @sk_scm_unused: unused flags for scm_recv()
> > >    *    @ns_tracker: tracker for netns reference
> > > -  *    @sk_user_frags: xarray of pages the user is holding a reference on.
> > > +  *    @sk_devmem_info: the devmem binding information for the socket
> > >    *    @sk_owner: reference to the real owner of the socket that calls
> > >    *               sock_lock_init_class_and_name().
> > >    */
> > > @@ -584,7 +584,10 @@ struct sock {
> > >         struct numa_drop_counters *sk_drop_counters;
> > >         struct rcu_head         sk_rcu;
> > >         netns_tracker           ns_tracker;
> > > -       struct xarray           sk_user_frags;
> > > +       struct {
> > > +               struct xarray                           frags;
> > > +               struct net_devmem_dmabuf_binding        *binding;
> > > +       } sk_devmem_info;
> > >
> > >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> > >         struct module           *sk_owner;
> > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > > index e0b579a1df4f..1e5c209cb998 100644
> > > --- a/include/uapi/linux/netdev.h
> > > +++ b/include/uapi/linux/netdev.h
> > > @@ -207,6 +207,7 @@ enum {
> > >         NETDEV_A_DMABUF_QUEUES,
> > >         NETDEV_A_DMABUF_FD,
> > >         NETDEV_A_DMABUF_ID,
> > > +       NETDEV_A_DMABUF_AUTORELEASE,
> > >
> > >         __NETDEV_A_DMABUF_MAX,
> > >         NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > index 05a9a9e7abb9..05c16df657c7 100644
> > > --- a/net/core/devmem.c
> > > +++ b/net/core/devmem.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/genalloc.h>
> > >  #include <linux/mm.h>
> > >  #include <linux/netdevice.h>
> > > +#include <linux/skbuff_ref.h>
> > >  #include <linux/types.h>
> > >  #include <net/netdev_queues.h>
> > >  #include <net/netdev_rx_queue.h>
> > > @@ -28,6 +29,19 @@
> > >
> > >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> > >
> > > +/* If the user unbinds before releasing all tokens, the static key must not
> > > + * change until all tokens have been released (to avoid calling the wrong
> > > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key changes
> > > + * and binding alloc/free atomic with regards to each other, using the
> > > + * devmem_ar_lock. This works because binding free does not occur until all of
> > > + * the outstanding token's references on the binding are dropped.
> > > + */
> > > +static DEFINE_MUTEX(devmem_ar_lock);
> > > +
> > > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > > +static int net_devmem_dmabuf_rx_bindings_count;
> > > +
> > >  static const struct memory_provider_ops dmabuf_devmem_ops;
> > >
> > >  bool net_is_devmem_iov(struct net_iov *niov)
> > > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> > >
> > >         size_t size, avail;
> > >
> > > +       if (binding->direction == DMA_FROM_DEVICE) {
> > > +               mutex_lock(&devmem_ar_lock);
> > > +               net_devmem_dmabuf_rx_bindings_count--;
> > > +               if (net_devmem_dmabuf_rx_bindings_count == 0)
> > > +                       static_branch_disable(&tcp_devmem_ar_key);
> > > +               mutex_unlock(&devmem_ar_lock);
> > > +       }
> > > +
> >
> > I find this loging with devmem_ar_lock and
> > net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
> > can do another simplification here? Can we have it such that the first
> > binding sets the system in autorelease on or autorelease off mode, and
> > all future bindings maintain this state? We already don't support
> > autorelease on/off mix.
> >
> >
> > >         gen_pool_for_each_chunk(binding->chunk_pool,
> > >                                 net_devmem_dmabuf_free_chunk_owner, NULL);
> > >
> > > @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
> > >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> > >  }
> > >
> > > +static void
> > > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
> > > +{
> > > +       int i;
> > > +
> > > +       for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > > +               struct net_iov *niov;
> > > +               netmem_ref netmem;
> > > +
> > > +               niov = binding->vec[i];
> > > +               netmem = net_iov_to_netmem(niov);
> > > +
> > > +               /* Multiple urefs map to only a single netmem ref. */
> > > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > > +       }
> > > +}
> > > +
> > >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> > >  {
> > >         struct netdev_rx_queue *rxq;
> > > @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> > >                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> > >         }
> > >
> > > +       net_devmem_dmabuf_binding_put_urefs(binding);
> >
> > Sigh, I think what you're trying to do here is very complicated. You
> > need to think about this scenario:
> >
> > 1. user binds dmabuf and opens a autorelease=off socket.
> > 2. Data arrives on these sockets, and sits in the receive queues,
> > recvmsg has not been called yet by the user.
> > 3. User unbinds the dma-buff, netmems are still in the receive queues.
> > 4. User calls recvmsg on one of these sockets, which obtains a uref on
> > the netmems in the receive queues.
> > 5. user closes the socket.
> >
> > With autorelease=on, this works, because the binding remains alive
> > until step 5 (even though it's unbound from the queue,
> > ..._binding_free has not been called yet) and step 5 cleans up all
> > references, even if the binding is unbound but alive, and
> >
> > calling net_devmem_dmabuf_binding_put_urefs here is weird.
> > Autorelease=off implies the user must clean their urefs themselves,
> > but we have this here in the unbind path, and it doesn't even
> > guarantee that the urefs are free at this point because it may race
> > with a recvmsg.
> >
> > Should we delete this uref cleanup here, and enforce that
> > autorelease=off means that the user cleans up the references (the
> > kernel never cleans them up on unbind or socket close)? The dontneed
> > path needs to work whether the binding is active or unbound.
> >
> 
> I also now think this scenario could happen, something like:
> 
> 1. User binds with autorelease=off and open socket.
> 2. Data arrives on the socket.
> 3. User unbinds the dmabuf
> 4. User calls recieves data
> 
> Then the user never dontneeds the data received in step 4. AFAICT this
> means that the binding will never be freed. This is kinda why my
> feeling was that the autorelease property should a property of the
> sockets, and each autorelease=off socket should hold a reference on
> the binding to ensure it doesn't go away while the socket is open,
> then when all the sockets are closed, they drop the references to the
> binding, and the binding is freed and the dmabuf is unmapped
> regardless on whether the memory has been dontfreed or not, because
> the sockets are closed.

Ah damn, yeah that is a binding leak. I think the core issue for
autorelease=off is that recvmsg() takes a binding reference for every
token, but there is no mechanism to release those when the socket
closes. Instead, it should take only one reference on the binding (the
first time it sees it in recvmsg), and then if binding != NULL on close
it should release it.

AFAICT, I think this change would need to apply to both the socket-based
and the dmabuf-based implementations?

Best,
Bobby

