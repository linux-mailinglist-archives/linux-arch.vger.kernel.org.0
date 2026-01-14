Return-Path: <linux-arch+bounces-15797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C7793D21541
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 22:26:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56A14304BD20
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 21:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A12436166E;
	Wed, 14 Jan 2026 21:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJf1KJWH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D43361658
	for <linux-arch@vger.kernel.org>; Wed, 14 Jan 2026 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425923; cv=none; b=fNgmcJjan1t8OeyenLeMkJc8iGIIG9ubzHyNFxy7JMC52fzCJbjktelbhmN4BoNA+7MWoNeJAwK8xp0f5zLSc/Jp4WScA0xYJ8yIVEBsz7FNWrUJqe75M6Es7vSWt1+A+J9KR1VuD15MeWSQqRzq8kLllcMLeqArdhyPBIOhY10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425923; c=relaxed/simple;
	bh=1JT9Pvj4xaM45CDFhMUUqDDWmTDUshaELrCrlYzrJgU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gme3YAaf2mgbDmYbLwJN5SToSVR576mq6MPsMijRtLqLdDItPv9OTgvgZLl6dyyIQpby5XCrIXXXFJ4gaDyW9K6fKdPX128czv01s5sWKHqfzDgZnU19oWwKMfM2r91sMdA+u2RbWx07NbU2dFXvV+YCtHfgnMFme8IyUkOeOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJf1KJWH; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7904a401d5cso2842567b3.3
        for <linux-arch@vger.kernel.org>; Wed, 14 Jan 2026 13:25:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768425916; x=1769030716; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=e5fPit1gjOxTaUu2qURahAgpoXGqB1jqP2enG8WTx/k=;
        b=lJf1KJWHtFhO0gogoxAS5kkwzrLWwcdAh+hZEiaNNXc7kFAFuHuAhl1lf7rBPL8Qk6
         6u6tXvws7+XNkp3wayX+msRBc/ShocT9ICj3tVQE435HBpWeRVKyHc28PHEyXHMKbw8z
         q6fBv2PUbP3SHATJ9WL+fYW2E89dBQ2v5tI/uNLYlmRm75MOfUkqRzyv/9f4dBpEkasa
         U4XhqPv6GgFKazyPn/8fBzlq4RwVxsszRgQUv/MqYi/RA4DLlFCLcmL2ofKkdC58r+ys
         e8tpolofESkjX0352X3GmHd5FB3KsHYz1SI9c9Jum3XkS+OSCrJsoNSveqgj9JciaALV
         gwdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768425916; x=1769030716;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e5fPit1gjOxTaUu2qURahAgpoXGqB1jqP2enG8WTx/k=;
        b=DtzNX8/IZLfVxjDwPHXHDUrLUEjf07gOYcADgOzI/WBC+mZ4be6XzNF/kj1fptiqLU
         WWOLf5+58nNDcXbGdgOJi1qWL6lDDVD+Cv5DRybjueSP4w7UohYjGbS4LvuUra1EecGN
         wybXVpJR5ZzQAAUTy7dC3KiHvKY9VLD5fKdohXt3GivqrAsqN3P8zDLeL+2Go4IRfLgT
         yR5GMccsQPzxkUAUWy3LEltLiCzn96LVkwqkukw4ylvwsL489Vq3eMjumm+bJaez89Xh
         uDPpuf9ER+bphmEs4w83Xj3weUAQpu3YwszWZQRO/GquMKzYtuZNQ1Lllm5Ruh2Eo+Zj
         IUKA==
X-Forwarded-Encrypted: i=1; AJvYcCUolHRmik7pXe4EN9C/65fztXQE2z90OJSwAs2GBVMlDF/CGpkLx1WIBdMJvO8BVyRSorK0cgHqbBvB@vger.kernel.org
X-Gm-Message-State: AOJu0YzQevnjzIzUwBvgKTe1/enf99Ox7erzY8ruXEf9bDolHSMXf3fz
	9Svppmspgaii4tAe61FcO6ZFlb9LfAknSsYrEDnvm4iDOdNd8c7Tg0zJ
X-Gm-Gg: AY/fxX4latyaG2cnf/K78i3Iw4jJXQaY6XFqhlXsz4SaLwLDdjMro+yne+KMdhBiq11
	EAl8Sy4A+Dpc+OwnjkypB3pD8p4AA3FTYfbRWRhM/f6rpsLudVGX0GuSdfstxeqzjOLmC2xKHVF
	+deqrCcuRceXFwNSW43uZWdcI8V+3EUpV14Ran0ac2C4xaSuMPqbAvk8AJHLgbbo/W/cH8fUAeh
	ZwK76x+U7ApSsexuNQVge45fZyVD8gb9lKgOpSBm6SxASGH7HYk1TSpzzGB44ghF1j47BukheHJ
	NXloGITVENV0tXyY3xAY2OdjRuJ3ONdiqjDvEz5Kxl7Opz+uK29UNaxxpbF2sn2RbY1ksIk8xZg
	G5zx08SupwOiARcBLYbN51Nuc+Av9gRB+Y03NlIUqPGMEB+J7vRiTnCHCzWWZD/relbsLzYdmV5
	XYPYhixym/s3Iqyo8g+IxRVJZ00SOvs6AVcwQ=
X-Received: by 2002:a05:690e:1914:b0:646:6f6f:65e with SMTP id 956f58d0204a3-64903b11bcemr2950674d50.24.1768425915955;
        Wed, 14 Jan 2026 13:25:15 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:71::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d80be64sm10953567d50.6.2026.01.14.13.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 13:25:15 -0800 (PST)
Date: Wed, 14 Jan 2026 13:25:10 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Mina Almasry <almasrymina@google.com>,
	"David S. Miller" <davem@davemloft.net>,
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
Message-ID: <aWgJtufzt+DjpEMZ@devvm11784.nha0.facebook.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
 <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
 <aWgClEgZa5ZGe3hU@mini-arch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWgClEgZa5ZGe3hU@mini-arch>

On Wed, Jan 14, 2026 at 12:54:44PM -0800, Stanislav Fomichev wrote:
> On 01/12, Bobby Eshleman wrote:
> > On Sun, Jan 11, 2026 at 11:12:19AM -0800, Mina Almasry wrote:
> > > On Fri, Jan 9, 2026 at 6:19 PM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> > > >
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > Add support for autorelease toggling of tokens using a static branch to
> > > > control system-wide behavior. This allows applications to choose between
> > > > two memory management modes:
> > > >
> > > > 1. Autorelease on: Leaked tokens are automatically released when the
> > > >    socket closes.
> > > >
> > > > 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
> > > >
> > > > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> > > > attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
> > > > binding is disallowed and is rejected by netlink. The system will be
> > > > "locked" into the mode that the first binding is set to. It can only be
> > > > changed again once there are zero bindings on the system.
> > > >
> > > > Disabling autorelease offers ~13% improvement in CPU utilization.
> > > >
> > > > Static branching is used to limit the system to one mode or the other.
> > > >
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > > > ---
> > > > Changes in v9:
> > > > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=n
> > > > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> > > >   stubbed out when NET_DEVMEM=n
> > > > - only dec rx binding count for rx bindings in free (v8 did not exclude
> > > >   TX bindings)
> > > >
> > > > Changes in v8:
> > > > - Only reset static key when bindings go to zero, defaulting back to
> > > >   disabled (Stan).
> > > > - Fix bad usage of xarray spinlock for sleepy static branch switching,
> > > >   use mutex instead.
> > > > - Access pp_ref_count via niov->desc instead of niov directly.
> > > > - Move reset of static key to __net_devmem_dmabuf_binding_free() so that
> > > >   the static key can not be changed while there are outstanding tokens
> > > >   (free is only called when reference count reaches zero).
> > > > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
> > > >   even after xa_erase(), so static key changes must wait until all
> > > >   RX bindings are finally freed (not just when xarray is empty). A
> > > >   counter is a simple way to track this.
> > > > - socket takes reference on the binding, to avoid use-after-free on
> > > >   sk_devmem_info.binding in the case that user releases all tokens,
> > > >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > > > - removed some comments that were unnecessary
> > > >
> > > > Changes in v7:
> > > > - implement autorelease with static branch (Stan)
> > > > - use netlink instead of sockopt (Stan)
> > > > - merge uAPI and implementation patches into one patch (seemed less
> > > >   confusing)
> > > >
> > > > Changes in v6:
> > > > - remove sk_devmem_info.autorelease, using binding->autorelease instead
> > > > - move binding->autorelease check to outside of
> > > >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > > > - remove overly defensive net_is_devmem_iov() (Mina)
> > > > - add comment about multiple urefs mapping to a single netmem ref (Mina)
> > > > - remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
> > > > - use niov without casting back and forth with netmem (Mina)
> > > > - move the autorelease flag from per-binding to per-socket (Mina)
> > > > - remove the batching logic in sock_devmem_dontneed_manual_release()
> > > >   (Mina)
> > > > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > > > - remove single-binding restriction for autorelease mode (Mina)
> > > > - unbind always checks for leaked urefs
> > > >
> > > > Changes in v5:
> > > > - remove unused variables
> > > > - introduce autorelease flag, preparing for future patch toggle new
> > > >   behavior
> > > >
> > > > Changes in v3:
> > > > - make urefs per-binding instead of per-socket, reducing memory
> > > >   footprint
> > > > - fallback to cleaning up references in dmabuf unbind if socket leaked
> > > >   tokens
> > > > - drop ethtool patch
> > > >
> > > > Changes in v2:
> > > > - always use GFP_ZERO for binding->vec (Mina)
> > > > - remove WARN for changed binding (Mina)
> > > > - remove extraneous binding ref get (Mina)
> > > > - remove WARNs on invalid user input (Mina)
> > > > - pre-assign niovs in binding->vec for RX case (Mina)
> > > > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > > > - fix length of alloc for urefs
> > > > ---
> > > >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> > > >  include/net/netmem.h                    |   1 +
> > > >  include/net/sock.h                      |   7 ++-
> > > >  include/uapi/linux/netdev.h             |   1 +
> > > >  net/core/devmem.c                       | 104 ++++++++++++++++++++++++++++----
> > > >  net/core/devmem.h                       |  27 ++++++++-
> > > >  net/core/netdev-genl-gen.c              |   5 +-
> > > >  net/core/netdev-genl.c                  |  10 ++-
> > > >  net/core/sock.c                         |  57 +++++++++++++++--
> > > >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++-----
> > > >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> > > >  net/ipv4/tcp_minisocks.c                |   3 +-
> > > >  tools/include/uapi/linux/netdev.h       |   1 +
> > > >  13 files changed, 269 insertions(+), 46 deletions(-)
> > > >
> > > > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > > > index 596c306ce52b..7cbe9e7b9ee5 100644
> > > > --- a/Documentation/netlink/specs/netdev.yaml
> > > > +++ b/Documentation/netlink/specs/netdev.yaml
> > > > @@ -562,6 +562,17 @@ attribute-sets:
> > > >          type: u32
> > > >          checks:
> > > >            min: 1
> > > > +      -
> > > > +        name: autorelease
> > > > +        doc: |
> > > > +          Token autorelease mode. If true (1), leaked tokens are automatically
> > > > +          released when the socket closes. If false (0), leaked tokens are only
> > > > +          released when the dmabuf is unbound. Once a binding is created with a
> > > > +          specific mode, all subsequent bindings system-wide must use the same
> > > > +          mode.
> > > > +
> > > > +          Optional. Defaults to false if not specified.
> > > > +        type: u8
> > > >
> > > >  operations:
> > > >    list:
> > > > @@ -769,6 +780,7 @@ operations:
> > > >              - ifindex
> > > >              - fd
> > > >              - queues
> > > > +            - autorelease
> > > >          reply:
> > > >            attributes:
> > > >              - id
> > > > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > > > index 9e10f4ac50c3..80d2263ba4ed 100644
> > > > --- a/include/net/netmem.h
> > > > +++ b/include/net/netmem.h
> > > > @@ -112,6 +112,7 @@ struct net_iov {
> > > >         };
> > > >         struct net_iov_area *owner;
> > > >         enum net_iov_type type;
> > > > +       atomic_t uref;
> > > >  };
> > > >
> > > >  struct net_iov_area {
> > > > diff --git a/include/net/sock.h b/include/net/sock.h
> > > > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > > > --- a/include/net/sock.h
> > > > +++ b/include/net/sock.h
> > > > @@ -352,7 +352,7 @@ struct sk_filter;
> > > >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> > > >    *    @sk_scm_unused: unused flags for scm_recv()
> > > >    *    @ns_tracker: tracker for netns reference
> > > > -  *    @sk_user_frags: xarray of pages the user is holding a reference on.
> > > > +  *    @sk_devmem_info: the devmem binding information for the socket
> > > >    *    @sk_owner: reference to the real owner of the socket that calls
> > > >    *               sock_lock_init_class_and_name().
> > > >    */
> > > > @@ -584,7 +584,10 @@ struct sock {
> > > >         struct numa_drop_counters *sk_drop_counters;
> > > >         struct rcu_head         sk_rcu;
> > > >         netns_tracker           ns_tracker;
> > > > -       struct xarray           sk_user_frags;
> > > > +       struct {
> > > > +               struct xarray                           frags;
> > > > +               struct net_devmem_dmabuf_binding        *binding;
> > > > +       } sk_devmem_info;
> > > >
> > > >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> > > >         struct module           *sk_owner;
> > > > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > > > index e0b579a1df4f..1e5c209cb998 100644
> > > > --- a/include/uapi/linux/netdev.h
> > > > +++ b/include/uapi/linux/netdev.h
> > > > @@ -207,6 +207,7 @@ enum {
> > > >         NETDEV_A_DMABUF_QUEUES,
> > > >         NETDEV_A_DMABUF_FD,
> > > >         NETDEV_A_DMABUF_ID,
> > > > +       NETDEV_A_DMABUF_AUTORELEASE,
> > > >
> > > >         __NETDEV_A_DMABUF_MAX,
> > > >         NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> > > > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > > > index 05a9a9e7abb9..05c16df657c7 100644
> > > > --- a/net/core/devmem.c
> > > > +++ b/net/core/devmem.c
> > > > @@ -11,6 +11,7 @@
> > > >  #include <linux/genalloc.h>
> > > >  #include <linux/mm.h>
> > > >  #include <linux/netdevice.h>
> > > > +#include <linux/skbuff_ref.h>
> > > >  #include <linux/types.h>
> > > >  #include <net/netdev_queues.h>
> > > >  #include <net/netdev_rx_queue.h>
> > > > @@ -28,6 +29,19 @@
> > > >
> > > >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> > > >
> > > > +/* If the user unbinds before releasing all tokens, the static key must not
> > > > + * change until all tokens have been released (to avoid calling the wrong
> > > > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key changes
> > > > + * and binding alloc/free atomic with regards to each other, using the
> > > > + * devmem_ar_lock. This works because binding free does not occur until all of
> > > > + * the outstanding token's references on the binding are dropped.
> > > > + */
> > > > +static DEFINE_MUTEX(devmem_ar_lock);
> > > > +
> > > > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > > > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > > > +static int net_devmem_dmabuf_rx_bindings_count;
> > > > +
> > > >  static const struct memory_provider_ops dmabuf_devmem_ops;
> > > >
> > > >  bool net_is_devmem_iov(struct net_iov *niov)
> > > > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_struct *wq)
> > > >
> > > >         size_t size, avail;
> > > >
> > > > +       if (binding->direction == DMA_FROM_DEVICE) {
> > > > +               mutex_lock(&devmem_ar_lock);
> > > > +               net_devmem_dmabuf_rx_bindings_count--;
> > > > +               if (net_devmem_dmabuf_rx_bindings_count == 0)
> > > > +                       static_branch_disable(&tcp_devmem_ar_key);
> > > > +               mutex_unlock(&devmem_ar_lock);
> > > > +       }
> > > > +
> > > 
> > > I find this loging with devmem_ar_lock and
> > > net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
> > > can do another simplification here? Can we have it such that the first
> > > binding sets the system in autorelease on or autorelease off mode, and
> > > all future bindings maintain this state? We already don't support
> > > autorelease on/off mix.
> > 
> > I think that would greatly simplify things. We would still need a lock
> > to make the static branch change and first release mode setting atomic WRT
> > each other, but the other parts (like the one above) can be
> > removed.
> 
> I'm not against this, but I wonder how we can test both modes on NIPA?
> If we lock the mode, we can only test one mode until the kernel
> reboots... I wonder whether with your proposed refcnt changes (in the
> other thread) we can keep existing mode (where we don't need a reboot).

Right, with the refcnt changes in the other thread we can keep the
existing. I couldn't find any solid precedent for switching some
per-boot settings in selftests, shy of bpf's spinning up a new VM. Most
tests just skip if they need the other mode, which isn't what we want
here.

Best,
Bobby

