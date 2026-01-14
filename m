Return-Path: <linux-arch+bounces-15796-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE39D213D1
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 21:57:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04C953005FC9
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jan 2026 20:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609A7357A2D;
	Wed, 14 Jan 2026 20:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1ElCAoy"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1A7357735
	for <linux-arch@vger.kernel.org>; Wed, 14 Jan 2026 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424089; cv=none; b=gkgX3ttRnkrv/pt12qqT1PeXZKjNcXeOXFfU+FZgUSvGkcHwi4+Jk5Ryu59SYEtVUP++aj1eTYqDII3IO7GENgretzcqQec/5E+P8lTey3zJePEWMeFCWp9zz9ovPdESSKkyedfBDOws8MEhF2qTzudKZej9ObT3UenF3oOrR1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424089; c=relaxed/simple;
	bh=ipqdIeIu4lifeSarLJh3Vbs2xl4o6xWuaUlVdiFqPlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY+kLqhYYklUZh+VkGAVnzGZm34LzRVNzQArRJT1lNcMGCG5iJ3iZiDcjBUk5UUhzEzSgDqlWxKp4PuyLULM7Ww82o0c3gTU/gDp4jV+n3LS3e2Qzy3wPrHHKdfrAHNu1/PDKG4zPQavGgjEvS4T8QLDd44TkT/0wSw2BG0g5Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1ElCAoy; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2b053ec7d90so350402eec.0
        for <linux-arch@vger.kernel.org>; Wed, 14 Jan 2026 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768424087; x=1769028887; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QAROxTfJm04J/646sr7jYZWFCaySPyYKwP5zjNwCp4U=;
        b=R1ElCAoyt7nruFEYI02cI/qiFULerT7kggecKomzCsRah1wWlqV+8SBLaT0cTexDDZ
         0ikSzudPQTwEBRXwaR/DN9EsXf+xQLPGAj5rgKCO6g5Vwz+xb71bx4lTzGpBmuYZiCJM
         veM6o2NbiizLI7DAH0B5EqYhvz78mDKDHqqd9/qWeiRvbpu2iDevjSC2uQmxIMHjWJpR
         pvJfRTRSoC1G7NIkpqM7yIXBpKbQS5mHSDRuxAQ02i0ZBJAhP8aHXSgFU4TN0sjE7/0N
         ZaRUY4rFq6YmsJXWm9AL+Exmbya9DBuLcm16UUV7PvMMQvINifri9aXRLpMXi2/7j59A
         2Psw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768424087; x=1769028887;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QAROxTfJm04J/646sr7jYZWFCaySPyYKwP5zjNwCp4U=;
        b=v8yjYZ1MuUZlWd/1tcvBRRm4rntCVXOj4EcGNJKc0aCGKphEdB98iKq8Vz6/0Z+YSx
         esqpD62u3/9fNykDz2m+FockUXdddgDRnue3/tPKUpmb2CwGRA9wO+Q2zL2/LEnv7lcX
         +Jx5KhRwhjInxxZm5zNyFEFYDC4tzn9GURR/15K/DONG4eGtIVDjsixTbvxCQ1WUEOf/
         eVPKfWOMd/qDG6/8POWS9XDLlCLjZNohXReMPCs2uB/GMBbkKJudM7I1S6d+76bWI/uY
         hIngNd3wI5PWoNLSaJ/OleT7u8/EIbRHh1C1ZpT4ktiEvtvpRnT56dpzMw0V7yjsoR0J
         yzTw==
X-Forwarded-Encrypted: i=1; AJvYcCWKI1PDQhOgdwqilGqxWQUHm+eY6yn4ypmrPHrOaVBsTUSI000FHB0LlJAP/43/5PeFORbSUBA+hOYF@vger.kernel.org
X-Gm-Message-State: AOJu0YzqzY1UueGE2KOZc6zXT9q7sazUBp4sl4Lpf2U5wXwIZ9kCgd3g
	omsptbJTZMDWvqVob4M2Ewta0iAyqLidP3j/x8+FPJXDcaamSvJnFN0=
X-Gm-Gg: AY/fxX7Rrm81Xuie7Vbjkeh+cy6Kf9zDc8YYJBTv9wul+OpcANcBj7nw3R2vvgf8Un6
	qzvUwZDONqmETW1FlvYFV0KvTdKdpaAa1b3STk/p7zhgVvfLaQmVEuXrl67ZG6/CGlpQ5fksLbL
	u4/hIhC2RteCHWwwkboqxLpYvbuBBnJhaw35xlGWScnQj7AT19RTxGnBBVIucImhcjAvHdsCGhL
	BLz9VWEqQ5KIvHZ0VzYGJPusMenfSWg4/rfRBvrhILKQVQTB3mZpT2i5ShLMSqoOWlUyr4iSXnG
	Hix8cfHpvOdjsNToCQbWZFyw1Z8swPfgMfW/WphZyNEPKHiM2wPe3vDsbCRhdqL9zYU1qIpabML
	EAc7XRaY8qIuPs/pAyqqI/0z+Q0JH4oHtrdCj1Gad8LACLdKYhMALJAHd8TZTldBvXjEN43FjcX
	GaGtNJxdVeZzSYs+98IY3QRcAyCQZnJA8Bwua3L9MiHB7CP7tovzwIO0vE20Go81Rfti3QVVKT8
	7FA0/D1MliCitVg
X-Received: by 2002:a05:7301:4449:b0:2ae:50d5:bc0f with SMTP id 5a478bee46e88-2b487089d75mr5049015eec.26.1768424086155;
        Wed, 14 Jan 2026 12:54:46 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b17078cddasm20103160eec.22.2026.01.14.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 12:54:45 -0800 (PST)
Date: Wed, 14 Jan 2026 12:54:44 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
Message-ID: <aWgClEgZa5ZGe3hU@mini-arch>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
 <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWUgNd6nOzZY3JCJ@devvm11784.nha0.facebook.com>

On 01/12, Bobby Eshleman wrote:
> On Sun, Jan 11, 2026 at 11:12:19AM -0800, Mina Almasry wrote:
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
> 
> I think that would greatly simplify things. We would still need a lock
> to make the static branch change and first release mode setting atomic WRT
> each other, but the other parts (like the one above) can be
> removed.

I'm not against this, but I wonder how we can test both modes on NIPA?
If we lock the mode, we can only test one mode until the kernel
reboots... I wonder whether with your proposed refcnt changes (in the
other thread) we can keep existing mode (where we don't need a reboot).

