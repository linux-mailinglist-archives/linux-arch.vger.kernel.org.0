Return-Path: <linux-arch+bounces-15749-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA43D0FA4C
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 20:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48B03305CD18
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3F3352F91;
	Sun, 11 Jan 2026 19:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6+qp8mJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F357B1EBFF7
	for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 19:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768159652; cv=pass; b=AOZGCOa92GAGZLjeCFX0MNoBc4g0eNntedzfW6RVAsLgqAqppL6jM1XNWBMA6XXPXK2SDuMlbpWDbRlihRwPk5t1VJTc+Ql50CaSBuxnHpBii6Q/6M4vi2ZjZ1Q2/XqBQNmkWMA9Dlv18/3R0te1SBCKJSPso3NPzPAa2vg/HfQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768159652; c=relaxed/simple;
	bh=trIcNgbjsX0LRKhiXUA5tHOekVjww2tWbsjetCOpEWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDYT0A3R1tVH3AU4g6EkT14u5rbuM21SdoN4S8jHE1rutbGyzkHt70rQEG0y1bSX9ZNZiDOKYmSjRwuCl33/HG2sP9X23JyBiQrSUJudBqMNFR8bua4UCKmKCFIUyshsnq0JCoFLM+9nW0XX+EwCXsSbQAlJWfy4FQx3zyX+4ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6+qp8mJ; arc=pass smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-59b30269328so4772e87.0
        for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 11:27:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768159647; cv=none;
        d=google.com; s=arc-20240605;
        b=iAgXzsbf8qviqYn0c3pECIsxzWCZ9uRb4NpuuvneBox876BGc7qsQHY6SwIv+dlyAA
         ekr0Puj7uFMBGdPxYBa0JTbrpDwcNM9iJdG8HxQ4CqAbn1ZQc2OefSQX2Vj5hEobiMrc
         I4XgRgcYebzbXh0ftAIIavFomMVbOkgq2w1/RE20ZWvk+Jvu01yZ6ZCl8WvdqcpHo355
         QdmIurku8lRGIWj8MZFt3RWjsDmF26Do39k8OlMJcvPFsRxR6vjx9l5wLSR6YynJ0nOP
         p8HIK92Vy8kyZJkfdBidaNjt1desK2tfbn2lOU6XMtMoJ+lENF95xRS27MSuI82uQblb
         Yrzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s4ptBgqPSArUdUCIusZb+llS4YHrY3jR0PnSWqP4tMg=;
        fh=PBIep1dSbfr/Z1OqwIWG7o2v275HgD9wvZrbNQ2VQMI=;
        b=OqNsZrvLi+EeRgTOMO6c8RX4gGhhZoFLLKiiN1VJAUZtpm6oj6miC3hEqmTrfH4s2g
         Tzc+2we1cg7rMsqEvJWjIx1fuZGKwJgzo8tmk55yznMOM++arDogwn5NxvXIGYYrH4dc
         en0fZZ7DLzoX60yoVUE3+9gL5sj/kAUnEXFXfh0Zp5ukeisFkoGCPdSh9r0TYEsUVcFC
         kOYDmq4bKJwJg+LhD+OSAb3zIlJb3AuFUZJkeB/f8MQp0+of0M5igVhw9NLCx4tBzsx6
         2m2ISn7gL9uWH7ZvK+xfxSKuHXefY7DfdL2QXLYB3Oh+t/EbpNRJ6XepfSVQ6gnzXE1L
         u4Ig==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768159647; x=1768764447; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4ptBgqPSArUdUCIusZb+llS4YHrY3jR0PnSWqP4tMg=;
        b=k6+qp8mJfhpg5KZQClBPX5PKRzjdckmyGPgHHjBCTK15EladD2qsJg448FUslNh25c
         Nh9MoPS9Z2PZOGtZG1E4D7vpDQLRB3lumsDmK6e0/OLqhUdt7hGgjmW3FfkoF5kgv1PP
         kqEF85dUyB8RzNRBnNejrI1V3AayCuk/VQx8PxVQPu1ddwtRcPZVqMLNpSY5r67z5ZZ7
         AmLxYmXaMtiKAkVOvccRYuX/B1dmUvg8sqk1YAuFUDMp525JBd9Otw0kimzt0EENqe9L
         huWMG2sFYMCLDZZ4kWFF21P1P0AWmgOXpM8e4WP6J4RL1jY3LjV3SLA7ZO/sOS/zC26R
         U3+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768159647; x=1768764447;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s4ptBgqPSArUdUCIusZb+llS4YHrY3jR0PnSWqP4tMg=;
        b=wRN4CCes7UKRX9NKA+BYNTDWkBu+hHLlMRofVMbW8wecZwMkME7LxXf7R5djLFkXMi
         2ZG8+NI5A+eaw6Ato1bb/wX6GIwP+VvVB3vsMqFJ2wDt4qlAM1NeqH0i4gfDfitudFW3
         I8/LzbIm8i5H7aH83JopPDdXw96p/I6oePn/C2w3PlIhagvz+bTqHtn5E5Luj8IDHn+d
         i7BhjxlNIYzeUIkW1OHu4aIllCKD6OS29CyvUAETkADNUyWyplyDK2AVy7dEntA9vtmZ
         m2x8XqhCi+tIv0RMavzdZVpiPNNgW2o+m1lUMZtqAI5F6W4WtuhriEogy5T6kxwGVDwB
         3E1w==
X-Forwarded-Encrypted: i=1; AJvYcCUETWq0tUfZ9eAftaOXEy179oHkrKWv8gEKia8wMo7x3TpGyBueQrp0mfra6naCO3N2OsaMQOGz6bP8@vger.kernel.org
X-Gm-Message-State: AOJu0YwzLNL/OZMgcYaj8cMe/CeX4szGcB7aR3xgd3GaZZZ8RdM2/0Mc
	3bX+Z9+6qkpfZm6K5AC7qvsfXSCWLD6EXjCbpnFeGgJ9CXDsBAjv75nM6V/KR+6M2DJ06X+Q5ma
	lBjHQB3HacUzex6HEzj3kgzhY4pQesV5P1OBNnpm5
X-Gm-Gg: AY/fxX5J0aTmyVaep9hb9n5etfQ1OvnVRW9nZXMGBuuYE33T8Qve5+F4gUYgcb7qtJM
	vwiCwuxrhqhQBlCC9WNSbRsWaJrpBrj60OAjbH4DPI3pJS4nIs8o5gI6BPpwfxTp5MGTlS3zRqq
	WT3u9D0uyV0ZPcWeot0IgPsnz8tebpUCIQ10DwYCJTQQYXqQWNkYVqlVgnP+7BBhTLAg55+vGuk
	Q3GxMkTfFvEC7IPpiOUhM1R+rncpjnwc5S6iYsLa115P/+Qcg2u9i//KGPrqT6nAihD1VY=
X-Received: by 2002:a05:6512:b8e:b0:59b:6cc8:9143 with SMTP id
 2adb3069b0e04-59b87d5d654mr77501e87.3.1768159646731; Sun, 11 Jan 2026
 11:27:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
 <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
In-Reply-To: <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:27:14 -0800
X-Gm-Features: AZwV_QidbTI-hh8TK5wMG_TqKLrCMtTUeRmRworBahw7dJ7MRpBl3TFju5ejV40
Message-ID: <CAHS8izO2B28570suitsL4HhakOC0FaCapD0w7K_U4SWMsvDmsg@mail.gmail.com>
Subject: Re: [PATCH net-next v9 3/5] net: devmem: implement autorelease token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, 
	Neal Cardwell <ncardwell@google.com>, David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	asml.silence@gmail.com, matttbe@kernel.org, skhawaja@google.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 11:12=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmai=
l.com> wrote:
> >
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> >
> > Add support for autorelease toggling of tokens using a static branch to
> > control system-wide behavior. This allows applications to choose betwee=
n
> > two memory management modes:
> >
> > 1. Autorelease on: Leaked tokens are automatically released when the
> >    socket closes.
> >
> > 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
> >
> > The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> > attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
> > binding is disallowed and is rejected by netlink. The system will be
> > "locked" into the mode that the first binding is set to. It can only be
> > changed again once there are zero bindings on the system.
> >
> > Disabling autorelease offers ~13% improvement in CPU utilization.
> >
> > Static branching is used to limit the system to one mode or the other.
> >
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Changes in v9:
> > - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=
=3Dn
> > - Add wrapper around tcp_devmem_ar_key accesses so that it may be
> >   stubbed out when NET_DEVMEM=3Dn
> > - only dec rx binding count for rx bindings in free (v8 did not exclude
> >   TX bindings)
> >
> > Changes in v8:
> > - Only reset static key when bindings go to zero, defaulting back to
> >   disabled (Stan).
> > - Fix bad usage of xarray spinlock for sleepy static branch switching,
> >   use mutex instead.
> > - Access pp_ref_count via niov->desc instead of niov directly.
> > - Move reset of static key to __net_devmem_dmabuf_binding_free() so tha=
t
> >   the static key can not be changed while there are outstanding tokens
> >   (free is only called when reference count reaches zero).
> > - Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
> >   even after xa_erase(), so static key changes must wait until all
> >   RX bindings are finally freed (not just when xarray is empty). A
> >   counter is a simple way to track this.
> > - socket takes reference on the binding, to avoid use-after-free on
> >   sk_devmem_info.binding in the case that user releases all tokens,
> >   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> > - removed some comments that were unnecessary
> >
> > Changes in v7:
> > - implement autorelease with static branch (Stan)
> > - use netlink instead of sockopt (Stan)
> > - merge uAPI and implementation patches into one patch (seemed less
> >   confusing)
> >
> > Changes in v6:
> > - remove sk_devmem_info.autorelease, using binding->autorelease instead
> > - move binding->autorelease check to outside of
> >   net_devmem_dmabuf_binding_put_urefs() (Mina)
> > - remove overly defensive net_is_devmem_iov() (Mina)
> > - add comment about multiple urefs mapping to a single netmem ref (Mina=
)
> > - remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
> > - use niov without casting back and forth with netmem (Mina)
> > - move the autorelease flag from per-binding to per-socket (Mina)
> > - remove the batching logic in sock_devmem_dontneed_manual_release()
> >   (Mina)
> > - move autorelease check inside tcp_xa_pool_commit() (Mina)
> > - remove single-binding restriction for autorelease mode (Mina)
> > - unbind always checks for leaked urefs
> >
> > Changes in v5:
> > - remove unused variables
> > - introduce autorelease flag, preparing for future patch toggle new
> >   behavior
> >
> > Changes in v3:
> > - make urefs per-binding instead of per-socket, reducing memory
> >   footprint
> > - fallback to cleaning up references in dmabuf unbind if socket leaked
> >   tokens
> > - drop ethtool patch
> >
> > Changes in v2:
> > - always use GFP_ZERO for binding->vec (Mina)
> > - remove WARN for changed binding (Mina)
> > - remove extraneous binding ref get (Mina)
> > - remove WARNs on invalid user input (Mina)
> > - pre-assign niovs in binding->vec for RX case (Mina)
> > - use atomic_set(, 0) to initialize sk_user_frags.urefs
> > - fix length of alloc for urefs
> > ---
> >  Documentation/netlink/specs/netdev.yaml |  12 ++++
> >  include/net/netmem.h                    |   1 +
> >  include/net/sock.h                      |   7 ++-
> >  include/uapi/linux/netdev.h             |   1 +
> >  net/core/devmem.c                       | 104 ++++++++++++++++++++++++=
++++----
> >  net/core/devmem.h                       |  27 ++++++++-
> >  net/core/netdev-genl-gen.c              |   5 +-
> >  net/core/netdev-genl.c                  |  10 ++-
> >  net/core/sock.c                         |  57 +++++++++++++++--
> >  net/ipv4/tcp.c                          |  76 ++++++++++++++++++-----
> >  net/ipv4/tcp_ipv4.c                     |  11 +++-
> >  net/ipv4/tcp_minisocks.c                |   3 +-
> >  tools/include/uapi/linux/netdev.h       |   1 +
> >  13 files changed, 269 insertions(+), 46 deletions(-)
> >
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/ne=
tlink/specs/netdev.yaml
> > index 596c306ce52b..7cbe9e7b9ee5 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -562,6 +562,17 @@ attribute-sets:
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: autorelease
> > +        doc: |
> > +          Token autorelease mode. If true (1), leaked tokens are autom=
atically
> > +          released when the socket closes. If false (0), leaked tokens=
 are only
> > +          released when the dmabuf is unbound. Once a binding is creat=
ed with a
> > +          specific mode, all subsequent bindings system-wide must use =
the same
> > +          mode.
> > +
> > +          Optional. Defaults to false if not specified.
> > +        type: u8
> >
> >  operations:
> >    list:
> > @@ -769,6 +780,7 @@ operations:
> >              - ifindex
> >              - fd
> >              - queues
> > +            - autorelease
> >          reply:
> >            attributes:
> >              - id
> > diff --git a/include/net/netmem.h b/include/net/netmem.h
> > index 9e10f4ac50c3..80d2263ba4ed 100644
> > --- a/include/net/netmem.h
> > +++ b/include/net/netmem.h
> > @@ -112,6 +112,7 @@ struct net_iov {
> >         };
> >         struct net_iov_area *owner;
> >         enum net_iov_type type;
> > +       atomic_t uref;
> >  };
> >
> >  struct net_iov_area {
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index aafe8bdb2c0f..9d3d5bde15e9 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -352,7 +352,7 @@ struct sk_filter;
> >    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> >    *    @sk_scm_unused: unused flags for scm_recv()
> >    *    @ns_tracker: tracker for netns reference
> > -  *    @sk_user_frags: xarray of pages the user is holding a reference=
 on.
> > +  *    @sk_devmem_info: the devmem binding information for the socket
> >    *    @sk_owner: reference to the real owner of the socket that calls
> >    *               sock_lock_init_class_and_name().
> >    */
> > @@ -584,7 +584,10 @@ struct sock {
> >         struct numa_drop_counters *sk_drop_counters;
> >         struct rcu_head         sk_rcu;
> >         netns_tracker           ns_tracker;
> > -       struct xarray           sk_user_frags;
> > +       struct {
> > +               struct xarray                           frags;
> > +               struct net_devmem_dmabuf_binding        *binding;
> > +       } sk_devmem_info;
> >
> >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> >         struct module           *sk_owner;
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index e0b579a1df4f..1e5c209cb998 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -207,6 +207,7 @@ enum {
> >         NETDEV_A_DMABUF_QUEUES,
> >         NETDEV_A_DMABUF_FD,
> >         NETDEV_A_DMABUF_ID,
> > +       NETDEV_A_DMABUF_AUTORELEASE,
> >
> >         __NETDEV_A_DMABUF_MAX,
> >         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 05a9a9e7abb9..05c16df657c7 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -11,6 +11,7 @@
> >  #include <linux/genalloc.h>
> >  #include <linux/mm.h>
> >  #include <linux/netdevice.h>
> > +#include <linux/skbuff_ref.h>
> >  #include <linux/types.h>
> >  #include <net/netdev_queues.h>
> >  #include <net/netdev_rx_queue.h>
> > @@ -28,6 +29,19 @@
> >
> >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1=
);
> >
> > +/* If the user unbinds before releasing all tokens, the static key mus=
t not
> > + * change until all tokens have been released (to avoid calling the wr=
ong
> > + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key c=
hanges
> > + * and binding alloc/free atomic with regards to each other, using the
> > + * devmem_ar_lock. This works because binding free does not occur unti=
l all of
> > + * the outstanding token's references on the binding are dropped.
> > + */
> > +static DEFINE_MUTEX(devmem_ar_lock);
> > +
> > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > +static int net_devmem_dmabuf_rx_bindings_count;
> > +
> >  static const struct memory_provider_ops dmabuf_devmem_ops;
> >
> >  bool net_is_devmem_iov(struct net_iov *niov)
> > @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_st=
ruct *wq)
> >
> >         size_t size, avail;
> >
> > +       if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> > +               mutex_lock(&devmem_ar_lock);
> > +               net_devmem_dmabuf_rx_bindings_count--;
> > +               if (net_devmem_dmabuf_rx_bindings_count =3D=3D 0)
> > +                       static_branch_disable(&tcp_devmem_ar_key);
> > +               mutex_unlock(&devmem_ar_lock);
> > +       }
> > +
>
> I find this loging with devmem_ar_lock and
> net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
> can do another simplification here? Can we have it such that the first
> binding sets the system in autorelease on or autorelease off mode, and
> all future bindings maintain this state? We already don't support
> autorelease on/off mix.
>
>
> >         gen_pool_for_each_chunk(binding->chunk_pool,
> >                                 net_devmem_dmabuf_free_chunk_owner, NUL=
L);
> >
> > @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
> >         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> >  }
> >
> > +static void
> > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *=
binding)
> > +{
> > +       int i;
> > +
> > +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > +               struct net_iov *niov;
> > +               netmem_ref netmem;
> > +
> > +               niov =3D binding->vec[i];
> > +               netmem =3D net_iov_to_netmem(niov);
> > +
> > +               /* Multiple urefs map to only a single netmem ref. */
> > +               if (atomic_xchg(&niov->uref, 0) > 0)
> > +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > +       }
> > +}
> > +
> >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *bindin=
g)
> >  {
> >         struct netdev_rx_queue *rxq;
> > @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dma=
buf_binding *binding)
> >                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> >         }
> >
> > +       net_devmem_dmabuf_binding_put_urefs(binding);
>
> Sigh, I think what you're trying to do here is very complicated. You
> need to think about this scenario:
>
> 1. user binds dmabuf and opens a autorelease=3Doff socket.
> 2. Data arrives on these sockets, and sits in the receive queues,
> recvmsg has not been called yet by the user.
> 3. User unbinds the dma-buff, netmems are still in the receive queues.
> 4. User calls recvmsg on one of these sockets, which obtains a uref on
> the netmems in the receive queues.
> 5. user closes the socket.
>
> With autorelease=3Don, this works, because the binding remains alive
> until step 5 (even though it's unbound from the queue,
> ..._binding_free has not been called yet) and step 5 cleans up all
> references, even if the binding is unbound but alive, and
>
> calling net_devmem_dmabuf_binding_put_urefs here is weird.
> Autorelease=3Doff implies the user must clean their urefs themselves,
> but we have this here in the unbind path, and it doesn't even
> guarantee that the urefs are free at this point because it may race
> with a recvmsg.
>
> Should we delete this uref cleanup here, and enforce that
> autorelease=3Doff means that the user cleans up the references (the
> kernel never cleans them up on unbind or socket close)? The dontneed
> path needs to work whether the binding is active or unbound.
>

I also now think this scenario could happen, something like:

1. User binds with autorelease=3Doff and open socket.
2. Data arrives on the socket.
3. User unbinds the dmabuf
4. User calls recieves data

Then the user never dontneeds the data received in step 4. AFAICT this
means that the binding will never be freed. This is kinda why my
feeling was that the autorelease property should a property of the
sockets, and each autorelease=3Doff socket should hold a reference on
the binding to ensure it doesn't go away while the socket is open,
then when all the sockets are closed, they drop the references to the
binding, and the binding is freed and the dmabuf is unmapped
regardless on whether the memory has been dontfreed or not, because
the sockets are closed.

--=20
Thanks,
Mina

