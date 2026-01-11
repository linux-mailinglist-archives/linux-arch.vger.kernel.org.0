Return-Path: <linux-arch+bounces-15746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 595CCD0F9E4
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 20:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB8833062CDE
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 19:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E714352C40;
	Sun, 11 Jan 2026 19:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2sRLOXpV"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F453352C47
	for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 19:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768158757; cv=pass; b=gEwWQLt23FeAn/1iMFllslIaGE/RR9Z82Q0UXygMF+/3rjGkeZqWEbLqaEFSmqgPGApOM7Nn3kMGvcDAvjXcB6ByEB/jrBr3oqnwXXiG7fSPF2zkwsVgZxSjcLkmU4CDGzDXzhq/ygYP7TSiyA/nQXp6MZYeQrsto22JqIVQTMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768158757; c=relaxed/simple;
	bh=ePDzDH6TeyDi7KCsR7THoGSph38OKS8BM1Eb+Kw40u4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lvXfV1ewmSGySLx+wKQCELs4clt+jhG6enrz3MOePBuy7qKk6WrZN2wqcEhaBiMN+Xq3t+nSOD3XXeOblw7pAjYC0PAoraRR72A7qHlFazKR81a+Dn3rM1GcWZSo6MwS/kF2mhlz1Cqh3IMA6dVtB5qR0q3tBvxQEIdHkcwoxGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2sRLOXpV; arc=pass smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59b30269328so4744e87.0
        for <linux-arch@vger.kernel.org>; Sun, 11 Jan 2026 11:12:34 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768158752; cv=none;
        d=google.com; s=arc-20240605;
        b=bjCH28s+buV5Zaunx+Ro/9wVqtGYblS0l2Guh+KcpRD7ZZDJsu5KWXGm+bEUCrD1R4
         YjaZkr7NncaBl9fq+bWK0bpAnt307YHeZ6YdJ4xKBlD8OKL9kLXZtNwmvx9kzCjXGJNT
         fFgYm9zxIrInKS9NWNnuAeT1lbxBGqOs8Y+V/gSX7VA92mwYicUbR+FdFbKyQGvniwfl
         HkcXRZx+HAMDm1xWW45TaWThpkqsGgaS2Lh0XlBQCos+jf1jhFvjE13DhDXV+YvkHcIV
         ZtFvH/0Q10KRIH3YLL0m+3OorMVdOLvAKl9DWdkNOtJbDYRIGsjUTAA8c1DTg5Aguhmx
         1PsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TfQN1grJBvxtzGoPkiKTxgMgVBhaK52DyOvfzBiFPrE=;
        fh=ipKofUsznx/gxM6gANlBn37dVnVU1nvBMMp32mu3OGw=;
        b=J9SoArgsjxrExRSICh4lib1k9FX7gmU3h+yuU8l1PSOfwFxKRsj7z1Y4PAZVTRxuYH
         25qAsAjZS7y9VI+XInKV439YJ9dZH/zkh/bPtvM+w1ytkmNa1WGmswHnw9nzTcW1fih0
         8KK7AekZQXNnzJotb0Ze84SbsiZ2GPkidIBjGrTL7GM8700n6CqEH3gLTYhJeVK49eq+
         3QZHDgSQHGXSvjITDLjmMKLoLghOfwjyTpeNkPPaQSNPChv5Dxi1mO/XxyxO/9S9u5YG
         rlYgScTltQuWDXrk2RNLOno1ANY4+uhRQuJR9DvNW9P+wkyTCjhEmv5n5eSnXQCmVbVm
         WIJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768158752; x=1768763552; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfQN1grJBvxtzGoPkiKTxgMgVBhaK52DyOvfzBiFPrE=;
        b=2sRLOXpV4rIEFYHXgCdFZk6UxMKmMbBy730pIYtFVNEKN5/XWTgxntUkzIPLNn3Gmy
         wjzD9cMpt/DxeNcXW8UhC3YAppheMGFYYi920ZmJ00VhLJJmJOfaOwI4BiNBk2mlbFvr
         USFZ3cs14I1nzFPl91iCF06BWlHD/IORrs6e4XnKGSuY4ldoYNuI+W8J3xuV53Dt0mYJ
         Bw0pOSPm50qvPEy8btg8zVkhizpCoBK6YU7ccYv38a3FbGOq6Hp8dqfQZYuXyaQNlyeA
         L0ZLav39hiIsAOfVS+8OAh2HTmAlddEUwxA9vf+gYo7Y+d9TKxok8ld0PsxZJS84SArt
         R+oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768158752; x=1768763552;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TfQN1grJBvxtzGoPkiKTxgMgVBhaK52DyOvfzBiFPrE=;
        b=mJRL5Sth1LNDzjcc0gVnMgOS1pEHj4iFI8IhouLOth81dWwMS8jhlT2eTAHXnDu6jY
         LwxXaXMHkT177X6EhwEuX84jcw7DFxNg88d+QJNklb117WtLHh+/nnWo8+8+OIJZnxJ7
         4arj+cMHTgDGwNHsQpxhwmBL+E3LFhTtJJS4YwmLBVB9CVrpRZuw6UvF4DKIa4zP9jRV
         0Ks6RBRI1W0iGDHssgsnHEWo1a8Gp5w10HqUx6EgS9/1j2qMv74jBgd6g/ymAJxvmAHY
         V3YdZ1+W6zRa3wdF1I0+mAErez9mIs7a3IOTTvWi85+f9UJrGR7UypfPC7iYU+bmI/ZB
         6FuA==
X-Forwarded-Encrypted: i=1; AJvYcCUW+elwxyRIc85RFL5Q+dcmtwZF6f28DNmOksBWtPYrplKKXNl2jnnDuV8CMHeMXmIxH6YPfeRMNjU4@vger.kernel.org
X-Gm-Message-State: AOJu0YxPJ3KV0zGbYSP3WzU1XJaOsbxhibkptS7XLvwXn24/BPviZns9
	QijVxlaEuqg36pZGZ7i5GIrhr7dPwp3vA3kMmzF++EiQuO1IWxtcaxIChLrgzOuQPVyhhZLykTP
	OsaCMFIOX9YHey+hTqOQLwIaVoT+/ZFkKDZVoLw2B
X-Gm-Gg: AY/fxX4KFI9IVkgtQsMjl8WzmXDrC2iGxpeBCv7fFxo9juOJtVMyUQZ7r6GVbnl9KAa
	WCJbA/Sz1PYfxeUoCRlOwBjU6uHGo2bDtqdfitSHWC/10bs1geB8h2udwci0gXVyiGbdmsCBnxy
	NwjBdX2KBpHoVbmCssYJF0yovYDQfdtV9HoV65bAXeaHQQSv4NBA8m7Sn0FCc3VT836fkYEkzjX
	7raxJu5ffzRfKLUvicpbn8M1a5ZsFBI+r6WUPuuEHBqaQfMFEoEDM36X6rm/fB1foOldwT6yljf
	QYAaYA==
X-Received: by 2002:ac2:5a1a:0:b0:596:9b1c:95da with SMTP id
 2adb3069b0e04-59b87d64594mr64617e87.17.1768158751978; Sun, 11 Jan 2026
 11:12:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-0-8042930d00d7@meta.com>
 <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Jan 2026 11:12:19 -0800
X-Gm-Features: AZwV_QjK3HIWm7Q180O8z8X2xzbydCS355tgfCF9shAHzqjPfYTAaFKExnZ6hjY
Message-ID: <CAHS8izO=kddnYW_Z7s=zgbV5vJyc1A0Aqbx4pnkAz=dtbstWNw@mail.gmail.com>
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

On Fri, Jan 9, 2026 at 6:19=E2=80=AFPM Bobby Eshleman <bobbyeshleman@gmail.=
com> wrote:
>
> From: Bobby Eshleman <bobbyeshleman@meta.com>
>
> Add support for autorelease toggling of tokens using a static branch to
> control system-wide behavior. This allows applications to choose between
> two memory management modes:
>
> 1. Autorelease on: Leaked tokens are automatically released when the
>    socket closes.
>
> 2. Autorelease off: Leaked tokens are released during dmabuf unbind.
>
> The autorelease mode is requested via the NETDEV_A_DMABUF_AUTORELEASE
> attribute of the NETDEV_CMD_BIND_RX message. Having separate modes per
> binding is disallowed and is rejected by netlink. The system will be
> "locked" into the mode that the first binding is set to. It can only be
> changed again once there are zero bindings on the system.
>
> Disabling autorelease offers ~13% improvement in CPU utilization.
>
> Static branching is used to limit the system to one mode or the other.
>
> Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> ---
> Changes in v9:
> - Add missing stub for net_devmem_dmabuf_binding_get() when NET_DEVMEM=3D=
n
> - Add wrapper around tcp_devmem_ar_key accesses so that it may be
>   stubbed out when NET_DEVMEM=3Dn
> - only dec rx binding count for rx bindings in free (v8 did not exclude
>   TX bindings)
>
> Changes in v8:
> - Only reset static key when bindings go to zero, defaulting back to
>   disabled (Stan).
> - Fix bad usage of xarray spinlock for sleepy static branch switching,
>   use mutex instead.
> - Access pp_ref_count via niov->desc instead of niov directly.
> - Move reset of static key to __net_devmem_dmabuf_binding_free() so that
>   the static key can not be changed while there are outstanding tokens
>   (free is only called when reference count reaches zero).
> - Add net_devmem_dmabuf_rx_bindings_count because tokens may be active
>   even after xa_erase(), so static key changes must wait until all
>   RX bindings are finally freed (not just when xarray is empty). A
>   counter is a simple way to track this.
> - socket takes reference on the binding, to avoid use-after-free on
>   sk_devmem_info.binding in the case that user releases all tokens,
>   unbinds, then issues SO_DEVMEM_DONTNEED again (with bad token).
> - removed some comments that were unnecessary
>
> Changes in v7:
> - implement autorelease with static branch (Stan)
> - use netlink instead of sockopt (Stan)
> - merge uAPI and implementation patches into one patch (seemed less
>   confusing)
>
> Changes in v6:
> - remove sk_devmem_info.autorelease, using binding->autorelease instead
> - move binding->autorelease check to outside of
>   net_devmem_dmabuf_binding_put_urefs() (Mina)
> - remove overly defensive net_is_devmem_iov() (Mina)
> - add comment about multiple urefs mapping to a single netmem ref (Mina)
> - remove overly defense netmem NULL and netmem_is_net_iov checks (Mina)
> - use niov without casting back and forth with netmem (Mina)
> - move the autorelease flag from per-binding to per-socket (Mina)
> - remove the batching logic in sock_devmem_dontneed_manual_release()
>   (Mina)
> - move autorelease check inside tcp_xa_pool_commit() (Mina)
> - remove single-binding restriction for autorelease mode (Mina)
> - unbind always checks for leaked urefs
>
> Changes in v5:
> - remove unused variables
> - introduce autorelease flag, preparing for future patch toggle new
>   behavior
>
> Changes in v3:
> - make urefs per-binding instead of per-socket, reducing memory
>   footprint
> - fallback to cleaning up references in dmabuf unbind if socket leaked
>   tokens
> - drop ethtool patch
>
> Changes in v2:
> - always use GFP_ZERO for binding->vec (Mina)
> - remove WARN for changed binding (Mina)
> - remove extraneous binding ref get (Mina)
> - remove WARNs on invalid user input (Mina)
> - pre-assign niovs in binding->vec for RX case (Mina)
> - use atomic_set(, 0) to initialize sk_user_frags.urefs
> - fix length of alloc for urefs
> ---
>  Documentation/netlink/specs/netdev.yaml |  12 ++++
>  include/net/netmem.h                    |   1 +
>  include/net/sock.h                      |   7 ++-
>  include/uapi/linux/netdev.h             |   1 +
>  net/core/devmem.c                       | 104 ++++++++++++++++++++++++++=
++----
>  net/core/devmem.h                       |  27 ++++++++-
>  net/core/netdev-genl-gen.c              |   5 +-
>  net/core/netdev-genl.c                  |  10 ++-
>  net/core/sock.c                         |  57 +++++++++++++++--
>  net/ipv4/tcp.c                          |  76 ++++++++++++++++++-----
>  net/ipv4/tcp_ipv4.c                     |  11 +++-
>  net/ipv4/tcp_minisocks.c                |   3 +-
>  tools/include/uapi/linux/netdev.h       |   1 +
>  13 files changed, 269 insertions(+), 46 deletions(-)
>
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netl=
ink/specs/netdev.yaml
> index 596c306ce52b..7cbe9e7b9ee5 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -562,6 +562,17 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: autorelease
> +        doc: |
> +          Token autorelease mode. If true (1), leaked tokens are automat=
ically
> +          released when the socket closes. If false (0), leaked tokens a=
re only
> +          released when the dmabuf is unbound. Once a binding is created=
 with a
> +          specific mode, all subsequent bindings system-wide must use th=
e same
> +          mode.
> +
> +          Optional. Defaults to false if not specified.
> +        type: u8
>
>  operations:
>    list:
> @@ -769,6 +780,7 @@ operations:
>              - ifindex
>              - fd
>              - queues
> +            - autorelease
>          reply:
>            attributes:
>              - id
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 9e10f4ac50c3..80d2263ba4ed 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -112,6 +112,7 @@ struct net_iov {
>         };
>         struct net_iov_area *owner;
>         enum net_iov_type type;
> +       atomic_t uref;
>  };
>
>  struct net_iov_area {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index aafe8bdb2c0f..9d3d5bde15e9 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -352,7 +352,7 @@ struct sk_filter;
>    *    @sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
>    *    @sk_scm_unused: unused flags for scm_recv()
>    *    @ns_tracker: tracker for netns reference
> -  *    @sk_user_frags: xarray of pages the user is holding a reference o=
n.
> +  *    @sk_devmem_info: the devmem binding information for the socket
>    *    @sk_owner: reference to the real owner of the socket that calls
>    *               sock_lock_init_class_and_name().
>    */
> @@ -584,7 +584,10 @@ struct sock {
>         struct numa_drop_counters *sk_drop_counters;
>         struct rcu_head         sk_rcu;
>         netns_tracker           ns_tracker;
> -       struct xarray           sk_user_frags;
> +       struct {
> +               struct xarray                           frags;
> +               struct net_devmem_dmabuf_binding        *binding;
> +       } sk_devmem_info;
>
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>         struct module           *sk_owner;
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index e0b579a1df4f..1e5c209cb998 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -207,6 +207,7 @@ enum {
>         NETDEV_A_DMABUF_QUEUES,
>         NETDEV_A_DMABUF_FD,
>         NETDEV_A_DMABUF_ID,
> +       NETDEV_A_DMABUF_AUTORELEASE,
>
>         __NETDEV_A_DMABUF_MAX,
>         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 05a9a9e7abb9..05c16df657c7 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c
> @@ -11,6 +11,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/mm.h>
>  #include <linux/netdevice.h>
> +#include <linux/skbuff_ref.h>
>  #include <linux/types.h>
>  #include <net/netdev_queues.h>
>  #include <net/netdev_rx_queue.h>
> @@ -28,6 +29,19 @@
>
>  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
>
> +/* If the user unbinds before releasing all tokens, the static key must =
not
> + * change until all tokens have been released (to avoid calling the wron=
g
> + * SO_DEVMEM_DONTNEED handler). We prevent this by making static key cha=
nges
> + * and binding alloc/free atomic with regards to each other, using the
> + * devmem_ar_lock. This works because binding free does not occur until =
all of
> + * the outstanding token's references on the binding are dropped.
> + */
> +static DEFINE_MUTEX(devmem_ar_lock);
> +
> +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> +EXPORT_SYMBOL(tcp_devmem_ar_key);
> +static int net_devmem_dmabuf_rx_bindings_count;
> +
>  static const struct memory_provider_ops dmabuf_devmem_ops;
>
>  bool net_is_devmem_iov(struct net_iov *niov)
> @@ -60,6 +74,14 @@ void __net_devmem_dmabuf_binding_free(struct work_stru=
ct *wq)
>
>         size_t size, avail;
>
> +       if (binding->direction =3D=3D DMA_FROM_DEVICE) {
> +               mutex_lock(&devmem_ar_lock);
> +               net_devmem_dmabuf_rx_bindings_count--;
> +               if (net_devmem_dmabuf_rx_bindings_count =3D=3D 0)
> +                       static_branch_disable(&tcp_devmem_ar_key);
> +               mutex_unlock(&devmem_ar_lock);
> +       }
> +

I find this loging with devmem_ar_lock and
net_devmem_dmabuf_rx_bindigs_count a bit complicated. I wonder if we
can do another simplification here? Can we have it such that the first
binding sets the system in autorelease on or autorelease off mode, and
all future bindings maintain this state? We already don't support
autorelease on/off mix.


>         gen_pool_for_each_chunk(binding->chunk_pool,
>                                 net_devmem_dmabuf_free_chunk_owner, NULL)=
;
>
> @@ -116,6 +138,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>         gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>
> +static void
> +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *bi=
nding)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> +               struct net_iov *niov;
> +               netmem_ref netmem;
> +
> +               niov =3D binding->vec[i];
> +               netmem =3D net_iov_to_netmem(niov);
> +
> +               /* Multiple urefs map to only a single netmem ref. */
> +               if (atomic_xchg(&niov->uref, 0) > 0)
> +                       WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +       }
> +}
> +
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
>         struct netdev_rx_queue *rxq;
> @@ -143,6 +183,7 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabu=
f_binding *binding)
>                 __net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
>         }
>
> +       net_devmem_dmabuf_binding_put_urefs(binding);

Sigh, I think what you're trying to do here is very complicated. You
need to think about this scenario:

1. user binds dmabuf and opens a autorelease=3Doff socket.
2. Data arrives on these sockets, and sits in the receive queues,
recvmsg has not been called yet by the user.
3. User unbinds the dma-buff, netmems are still in the receive queues.
4. User calls recvmsg on one of these sockets, which obtains a uref on
the netmems in the receive queues.
5. user closes the socket.

With autorelease=3Don, this works, because the binding remains alive
until step 5 (even though it's unbound from the queue,
..._binding_free has not been called yet) and step 5 cleans up all
references, even if the binding is unbound but alive, and

calling net_devmem_dmabuf_binding_put_urefs here is weird.
Autorelease=3Doff implies the user must clean their urefs themselves,
but we have this here in the unbind path, and it doesn't even
guarantee that the urefs are free at this point because it may race
with a recvmsg.

Should we delete this uref cleanup here, and enforce that
autorelease=3Doff means that the user cleans up the references (the
kernel never cleans them up on unbind or socket close)? The dontneed
path needs to work whether the binding is active or unbound.

>         net_devmem_dmabuf_binding_put(binding);
>  }
>
> @@ -179,8 +220,10 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev,
>                        struct device *dma_dev,
>                        enum dma_data_direction direction,
> -                      unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> -                      struct netlink_ext_ack *extack)
> +                      unsigned int dmabuf_fd,
> +                      struct netdev_nl_sock *priv,
> +                      struct netlink_ext_ack *extack,
> +                      bool autorelease)
>  {
>         struct net_devmem_dmabuf_binding *binding;
>         static u32 id_alloc_next;
> @@ -231,14 +274,12 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                 goto err_detach;
>         }
>
> -       if (direction =3D=3D DMA_TO_DEVICE) {
> -               binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> -                                             sizeof(struct net_iov *),
> -                                             GFP_KERNEL);
> -               if (!binding->vec) {
> -                       err =3D -ENOMEM;
> -                       goto err_unmap;
> -               }
> +       binding->vec =3D kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +                                     sizeof(struct net_iov *),
> +                                     GFP_KERNEL | __GFP_ZERO);
> +       if (!binding->vec) {
> +               err =3D -ENOMEM;
> +               goto err_unmap;
>         }
>
>         /* For simplicity we expect to make PAGE_SIZE allocations, but th=
e
> @@ -292,25 +333,62 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                         niov =3D &owner->area.niovs[i];
>                         niov->type =3D NET_IOV_DMABUF;
>                         niov->owner =3D &owner->area;
> +                       atomic_set(&niov->uref, 0);
>                         page_pool_set_dma_addr_netmem(net_iov_to_netmem(n=
iov),
>                                                       net_devmem_get_dma_=
addr(niov));
> -                       if (direction =3D=3D DMA_TO_DEVICE)
> -                               binding->vec[owner->area.base_virtual / P=
AGE_SIZE + i] =3D niov;
> +                       binding->vec[owner->area.base_virtual / PAGE_SIZE=
 + i] =3D niov;
>                 }
>
>                 virtual +=3D len;
>         }
>
> +       mutex_lock(&devmem_ar_lock);
> +
> +       if (direction =3D=3D DMA_FROM_DEVICE) {
> +               if (net_devmem_dmabuf_rx_bindings_count > 0) {
> +                       bool mode;
> +
> +                       mode =3D static_key_enabled(&tcp_devmem_ar_key);
> +
> +                       /* When bindings exist, enforce that the mode doe=
s not
> +                        * change.
> +                        */
> +                       if (mode !=3D autorelease) {
> +                               NL_SET_ERR_MSG_FMT(extack,
> +                                                  "System already config=
ured with autorelease=3D%d",
> +                                                  mode);
> +                               err =3D -EINVAL;
> +                               goto err_unlock_mutex;
> +                       }
> +               } else if (autorelease) {
> +                       /* First binding with autorelease enabled sets th=
e
> +                        * mode.  If autorelease is false, the key is alr=
eady
> +                        * disabled by default so no action is needed.
> +                        */
> +                       static_branch_enable(&tcp_devmem_ar_key);
> +               }
> +
> +               net_devmem_dmabuf_rx_bindings_count++;
> +       }
> +
>         err =3D xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id=
,
>                               binding, xa_limit_32b, &id_alloc_next,
>                               GFP_KERNEL);
>         if (err < 0)
> -               goto err_free_chunks;
> +               goto err_dec_binding_count;
> +
> +       mutex_unlock(&devmem_ar_lock);
>
>         list_add(&binding->list, &priv->bindings);
>
>         return binding;
>
> +err_dec_binding_count:
> +       if (direction =3D=3D DMA_FROM_DEVICE)
> +               net_devmem_dmabuf_rx_bindings_count--;
> +
> +err_unlock_mutex:
> +       mutex_unlock(&devmem_ar_lock);
>  err_free_chunks:
>         gen_pool_for_each_chunk(binding->chunk_pool,
>                                 net_devmem_dmabuf_free_chunk_owner, NULL)=
;
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 1ea6228e4f40..8c586f30e371 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -12,9 +12,13 @@
>
>  #include <net/netmem.h>
>  #include <net/netdev_netlink.h>
> +#include <linux/jump_label.h>
>
>  struct netlink_ext_ack;
>
> +/* static key for TCP devmem autorelease */
> +extern struct static_key_false tcp_devmem_ar_key;
> +
>  struct net_devmem_dmabuf_binding {
>         struct dma_buf *dmabuf;
>         struct dma_buf_attachment *attachment;
> @@ -61,7 +65,7 @@ struct net_devmem_dmabuf_binding {
>
>         /* Array of net_iov pointers for this binding, sorted by virtual
>          * address. This array is convenient to map the virtual addresses=
 to
> -        * net_iovs in the TX path.
> +        * net_iovs.
>          */
>         struct net_iov **vec;
>
> @@ -88,7 +92,7 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                        struct device *dma_dev,
>                        enum dma_data_direction direction,
>                        unsigned int dmabuf_fd, struct netdev_nl_sock *pri=
v,
> -                      struct netlink_ext_ack *extack);
> +                      struct netlink_ext_ack *extack, bool autorelease);
>  struct net_devmem_dmabuf_binding *net_devmem_lookup_dmabuf(u32 id);
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)=
;
>  int net_devmem_bind_dmabuf_to_queue(struct net_device *dev, u32 rxq_idx,
> @@ -138,6 +142,11 @@ net_devmem_dmabuf_binding_put(struct net_devmem_dmab=
uf_binding *binding)
>         schedule_work(&binding->unbind_w);
>  }
>
> +static inline bool net_devmem_autorelease_enabled(void)
> +{
> +       return static_branch_unlikely(&tcp_devmem_ar_key);
> +}
> +
>  void net_devmem_get_net_iov(struct net_iov *niov);
>  void net_devmem_put_net_iov(struct net_iov *niov);
>
> @@ -155,6 +164,12 @@ net_devmem_get_niov_at(struct net_devmem_dmabuf_bind=
ing *binding, size_t addr,
>  #else
>  struct net_devmem_dmabuf_binding;
>
> +static inline bool
> +net_devmem_dmabuf_binding_get(struct net_devmem_dmabuf_binding *binding)
> +{
> +       return false;
> +}
> +
>  static inline void
>  net_devmem_dmabuf_binding_put(struct net_devmem_dmabuf_binding *binding)
>  {
> @@ -174,7 +189,8 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>                        enum dma_data_direction direction,
>                        unsigned int dmabuf_fd,
>                        struct netdev_nl_sock *priv,
> -                      struct netlink_ext_ack *extack)
> +                      struct netlink_ext_ack *extack,
> +                      bool autorelease)
>  {
>         return ERR_PTR(-EOPNOTSUPP);
>  }
> @@ -241,6 +257,11 @@ net_devmem_iov_binding(const struct net_iov *niov)
>  {
>         return NULL;
>  }
> +
> +static inline bool net_devmem_autorelease_enabled(void)
> +{
> +       return false;
> +}
>  #endif
>
>  #endif /* _NET_DEVMEM_H */
> diff --git a/net/core/netdev-genl-gen.c b/net/core/netdev-genl-gen.c
> index ba673e81716f..01b7765e11ec 100644
> --- a/net/core/netdev-genl-gen.c
> +++ b/net/core/netdev-genl-gen.c
> @@ -86,10 +86,11 @@ static const struct nla_policy netdev_qstats_get_nl_p=
olicy[NETDEV_A_QSTATS_SCOPE
>  };
>
>  /* NETDEV_CMD_BIND_RX - do */
> -static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_=
FD + 1] =3D {
> +static const struct nla_policy netdev_bind_rx_nl_policy[NETDEV_A_DMABUF_=
AUTORELEASE + 1] =3D {
>         [NETDEV_A_DMABUF_IFINDEX] =3D NLA_POLICY_MIN(NLA_U32, 1),
>         [NETDEV_A_DMABUF_FD] =3D { .type =3D NLA_U32, },
>         [NETDEV_A_DMABUF_QUEUES] =3D NLA_POLICY_NESTED(netdev_queue_id_nl=
_policy),
> +       [NETDEV_A_DMABUF_AUTORELEASE] =3D { .type =3D NLA_U8, },
>  };
>
>  /* NETDEV_CMD_NAPI_SET - do */
> @@ -188,7 +189,7 @@ static const struct genl_split_ops netdev_nl_ops[] =
=3D {
>                 .cmd            =3D NETDEV_CMD_BIND_RX,
>                 .doit           =3D netdev_nl_bind_rx_doit,
>                 .policy         =3D netdev_bind_rx_nl_policy,
> -               .maxattr        =3D NETDEV_A_DMABUF_FD,
> +               .maxattr        =3D NETDEV_A_DMABUF_AUTORELEASE,
>                 .flags          =3D GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
>         },
>         {
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index 470fabbeacd9..c742bb34865e 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -939,6 +939,7 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, struc=
t genl_info *info)
>         struct netdev_nl_sock *priv;
>         struct net_device *netdev;
>         unsigned long *rxq_bitmap;
> +       bool autorelease =3D false;
>         struct device *dma_dev;
>         struct sk_buff *rsp;
>         int err =3D 0;
> @@ -952,6 +953,10 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, stru=
ct genl_info *info)
>         ifindex =3D nla_get_u32(info->attrs[NETDEV_A_DEV_IFINDEX]);
>         dmabuf_fd =3D nla_get_u32(info->attrs[NETDEV_A_DMABUF_FD]);
>
> +       if (info->attrs[NETDEV_A_DMABUF_AUTORELEASE])
> +               autorelease =3D
> +                       !!nla_get_u8(info->attrs[NETDEV_A_DMABUF_AUTORELE=
ASE]);
> +
>         priv =3D genl_sk_priv_get(&netdev_nl_family, NETLINK_CB(skb).sk);
>         if (IS_ERR(priv))
>                 return PTR_ERR(priv);
> @@ -1002,7 +1007,8 @@ int netdev_nl_bind_rx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>         }
>
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_FROM_DEVI=
CE,
> -                                        dmabuf_fd, priv, info->extack);
> +                                        dmabuf_fd, priv, info->extack,
> +                                        autorelease);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_rxq_bitmap;
> @@ -1097,7 +1103,7 @@ int netdev_nl_bind_tx_doit(struct sk_buff *skb, str=
uct genl_info *info)
>
>         dma_dev =3D netdev_queue_get_dma_dev(netdev, 0);
>         binding =3D net_devmem_bind_dmabuf(netdev, dma_dev, DMA_TO_DEVICE=
,
> -                                        dmabuf_fd, priv, info->extack);
> +                                        dmabuf_fd, priv, info->extack, f=
alse);
>         if (IS_ERR(binding)) {
>                 err =3D PTR_ERR(binding);
>                 goto err_unlock_netdev;
> diff --git a/net/core/sock.c b/net/core/sock.c
> index f6526f43aa6e..6355c2ccfb8a 100644
> --- a/net/core/sock.c
> +++ b/net/core/sock.c
> @@ -87,6 +87,7 @@
>
>  #include <linux/unaligned.h>
>  #include <linux/capability.h>
> +#include <linux/dma-buf.h>
>  #include <linux/errno.h>
>  #include <linux/errqueue.h>
>  #include <linux/types.h>
> @@ -151,6 +152,7 @@
>  #include <uapi/linux/pidfd.h>
>
>  #include "dev.h"
> +#include "devmem.h"
>
>  static DEFINE_MUTEX(proto_list_mutex);
>  static LIST_HEAD(proto_list);
> @@ -1081,6 +1083,44 @@ static int sock_reserve_memory(struct sock *sk, in=
t bytes)
>  #define MAX_DONTNEED_TOKENS 128
>  #define MAX_DONTNEED_FRAGS 1024
>
> +static noinline_for_stack int
> +sock_devmem_dontneed_manual_release(struct sock *sk,
> +                                   struct dmabuf_token *tokens,
> +                                   unsigned int num_tokens)
> +{
> +       struct net_iov *niov;
> +       unsigned int i, j;
> +       netmem_ref netmem;
> +       unsigned int token;
> +       int num_frags =3D 0;
> +       int ret =3D 0;
> +
> +       if (!sk->sk_devmem_info.binding)
> +               return -EINVAL;
> +
> +       for (i =3D 0; i < num_tokens; i++) {
> +               for (j =3D 0; j < tokens[i].token_count; j++) {
> +                       size_t size =3D sk->sk_devmem_info.binding->dmabu=
f->size;
> +
> +                       token =3D tokens[i].token_start + j;
> +                       if (token >=3D size / PAGE_SIZE)
> +                               break;
> +
> +                       if (++num_frags > MAX_DONTNEED_FRAGS)
> +                               return ret;
> +
> +                       niov =3D sk->sk_devmem_info.binding->vec[token];
> +                       if (atomic_dec_and_test(&niov->uref)) {
> +                               netmem =3D net_iov_to_netmem(niov);
> +                               WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +                       }
> +                       ret++;
> +               }
> +       }
> +
> +       return ret;
> +}
> +
>  static noinline_for_stack int
>  sock_devmem_dontneed_autorelease(struct sock *sk, struct dmabuf_token *t=
okens,
>                                  unsigned int num_tokens)
> @@ -1089,32 +1129,33 @@ sock_devmem_dontneed_autorelease(struct sock *sk,=
 struct dmabuf_token *tokens,
>         int ret =3D 0, num_frags =3D 0;
>         netmem_ref netmems[16];
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>         for (i =3D 0; i < num_tokens; i++) {
>                 for (j =3D 0; j < tokens[i].token_count; j++) {
>                         if (++num_frags > MAX_DONTNEED_FRAGS)
>                                 goto frag_limit_reached;
>
>                         netmem_ref netmem =3D (__force netmem_ref)__xa_er=
ase(
> -                               &sk->sk_user_frags, tokens[i].token_start=
 + j);
> +                               &sk->sk_devmem_info.frags,
> +                               tokens[i].token_start + j);
>
>                         if (!netmem || WARN_ON_ONCE(!netmem_is_net_iov(ne=
tmem)))
>                                 continue;
>
>                         netmems[netmem_num++] =3D netmem;
>                         if (netmem_num =3D=3D ARRAY_SIZE(netmems)) {
> -                               xa_unlock_bh(&sk->sk_user_frags);
> +                               xa_unlock_bh(&sk->sk_devmem_info.frags);
>                                 for (k =3D 0; k < netmem_num; k++)
>                                         WARN_ON_ONCE(!napi_pp_put_page(ne=
tmems[k]));
>                                 netmem_num =3D 0;
> -                               xa_lock_bh(&sk->sk_user_frags);
> +                               xa_lock_bh(&sk->sk_devmem_info.frags);
>                         }
>                         ret++;
>                 }
>         }
>
>  frag_limit_reached:
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>         for (k =3D 0; k < netmem_num; k++)
>                 WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
>
> @@ -1145,7 +1186,11 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t op=
tval, unsigned int optlen)
>                 return -EFAULT;
>         }
>
> -       ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_tokens);
> +       if (net_devmem_autorelease_enabled())
> +               ret =3D sock_devmem_dontneed_autorelease(sk, tokens, num_=
tokens);
> +       else
> +               ret =3D sock_devmem_dontneed_manual_release(sk, tokens,
> +                                                         num_tokens);
>
>         kvfree(tokens);
>         return ret;
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index d5319ebe2452..a8a4af552909 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -260,6 +260,7 @@
>  #include <linux/memblock.h>
>  #include <linux/highmem.h>
>  #include <linux/cache.h>
> +#include <linux/dma-buf.h>
>  #include <linux/err.h>
>  #include <linux/time.h>
>  #include <linux/slab.h>
> @@ -492,7 +493,8 @@ void tcp_init_sock(struct sock *sk)
>
>         set_bit(SOCK_SUPPORT_ZC, &sk->sk_socket->flags);
>         sk_sockets_allocated_inc(sk);
> -       xa_init_flags(&sk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&sk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       sk->sk_devmem_info.binding =3D NULL;
>  }
>  EXPORT_IPV6_MOD(tcp_init_sock);
>
> @@ -2424,11 +2426,12 @@ static void tcp_xa_pool_commit_locked(struct sock=
 *sk, struct tcp_xa_pool *p)
>
>         /* Commit part that has been copied to user space. */
>         for (i =3D 0; i < p->idx; i++)
> -               __xa_cmpxchg(&sk->sk_user_frags, p->tokens[i], XA_ZERO_EN=
TRY,
> -                            (__force void *)p->netmems[i], GFP_KERNEL);
> +               __xa_cmpxchg(&sk->sk_devmem_info.frags, p->tokens[i],
> +                            XA_ZERO_ENTRY, (__force void *)p->netmems[i]=
,
> +                            GFP_KERNEL);
>         /* Rollback what has been pre-allocated and is no longer needed. =
*/
>         for (; i < p->max; i++)
> -               __xa_erase(&sk->sk_user_frags, p->tokens[i]);
> +               __xa_erase(&sk->sk_devmem_info.frags, p->tokens[i]);
>
>         p->max =3D 0;
>         p->idx =3D 0;
> @@ -2436,14 +2439,18 @@ static void tcp_xa_pool_commit_locked(struct sock=
 *sk, struct tcp_xa_pool *p)
>
>  static void tcp_xa_pool_commit(struct sock *sk, struct tcp_xa_pool *p)
>  {
> +       /* Skip xarray operations if autorelease is disabled (manual mode=
) */
> +       if (!net_devmem_autorelease_enabled())
> +               return;
> +
>         if (!p->max)
>                 return;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>  }
>
>  static int tcp_xa_pool_refill(struct sock *sk, struct tcp_xa_pool *p,
> @@ -2454,24 +2461,41 @@ static int tcp_xa_pool_refill(struct sock *sk, st=
ruct tcp_xa_pool *p,
>         if (p->idx < p->max)
>                 return 0;
>
> -       xa_lock_bh(&sk->sk_user_frags);
> +       xa_lock_bh(&sk->sk_devmem_info.frags);
>
>         tcp_xa_pool_commit_locked(sk, p);
>
>         for (k =3D 0; k < max_frags; k++) {
> -               err =3D __xa_alloc(&sk->sk_user_frags, &p->tokens[k],
> +               err =3D __xa_alloc(&sk->sk_devmem_info.frags, &p->tokens[=
k],
>                                  XA_ZERO_ENTRY, xa_limit_31b, GFP_KERNEL)=
;
>                 if (err)
>                         break;
>         }
>
> -       xa_unlock_bh(&sk->sk_user_frags);
> +       xa_unlock_bh(&sk->sk_devmem_info.frags);
>
>         p->max =3D k;
>         p->idx =3D 0;
>         return k ? 0 : err;
>  }
>
> +static void tcp_xa_pool_inc_pp_ref_count(struct tcp_xa_pool *tcp_xa_pool=
,
> +                                        skb_frag_t *frag)
> +{
> +       struct net_iov *niov;
> +
> +       niov =3D skb_frag_net_iov(frag);
> +
> +       if (net_devmem_autorelease_enabled()) {
> +               atomic_long_inc(&niov->desc.pp_ref_count);
> +               tcp_xa_pool->netmems[tcp_xa_pool->idx++] =3D
> +                       skb_frag_netmem(frag);
> +       } else {
> +               if (atomic_inc_return(&niov->uref) =3D=3D 1)
> +                       atomic_long_inc(&niov->desc.pp_ref_count);
> +       }
> +}
> +
>  /* On error, returns the -errno. On success, returns number of bytes sen=
t to the
>   * user. May not consume all of @remaining_len.
>   */
> @@ -2533,6 +2557,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                  * sequence of cmsg
>                  */
>                 for (i =3D 0; i < skb_shinfo(skb)->nr_frags; i++) {
> +                       struct net_devmem_dmabuf_binding *binding =3D NUL=
L;
>                         skb_frag_t *frag =3D &skb_shinfo(skb)->frags[i];
>                         struct net_iov *niov;
>                         u64 frag_offset;
> @@ -2568,13 +2593,35 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, co=
nst struct sk_buff *skb,
>                                               start;
>                                 dmabuf_cmsg.frag_offset =3D frag_offset;
>                                 dmabuf_cmsg.frag_size =3D copy;
> -                               err =3D tcp_xa_pool_refill(sk, &tcp_xa_po=
ol,
> -                                                        skb_shinfo(skb)-=
>nr_frags - i);
> -                               if (err)
> +
> +                               binding =3D net_devmem_iov_binding(niov);
> +
> +                               if (!sk->sk_devmem_info.binding) {
> +                                       net_devmem_dmabuf_binding_get(bin=
ding);
> +                                       sk->sk_devmem_info.binding =3D bi=
nding;
> +                               }
> +
> +                               if (sk->sk_devmem_info.binding !=3D bindi=
ng) {
> +                                       err =3D -EFAULT;
>                                         goto out;
> +                               }
> +
> +                               if (net_devmem_autorelease_enabled()) {
> +                                       err =3D tcp_xa_pool_refill(sk,
> +                                                                &tcp_xa_=
pool,
> +                                                                skb_shin=
fo(skb)->nr_frags - i);
> +                                       if (err)
> +                                               goto out;
> +
> +                                       dmabuf_cmsg.frag_token =3D
> +                                               tcp_xa_pool.tokens[tcp_xa=
_pool.idx];
> +                               } else {
> +                                       dmabuf_cmsg.frag_token =3D
> +                                               net_iov_virtual_addr(niov=
) >> PAGE_SHIFT;
> +                               }
> +
>
>                                 /* Will perform the exchange later */
> -                               dmabuf_cmsg.frag_token =3D tcp_xa_pool.to=
kens[tcp_xa_pool.idx];
>                                 dmabuf_cmsg.dmabuf_id =3D net_devmem_iov_=
binding_id(niov);
>
>                                 offset +=3D copy;
> @@ -2587,8 +2634,7 @@ static int tcp_recvmsg_dmabuf(struct sock *sk, cons=
t struct sk_buff *skb,
>                                 if (err)
>                                         goto out;
>
> -                               atomic_long_inc(&niov->desc.pp_ref_count)=
;
> -                               tcp_xa_pool.netmems[tcp_xa_pool.idx++] =
=3D skb_frag_netmem(frag);
> +                               tcp_xa_pool_inc_pp_ref_count(&tcp_xa_pool=
, frag);
>
>                                 sent +=3D copy;
>
> diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> index f8a9596e8f4d..7b1b5a17002f 100644
> --- a/net/ipv4/tcp_ipv4.c
> +++ b/net/ipv4/tcp_ipv4.c
> @@ -89,6 +89,9 @@
>
>  #include <crypto/md5.h>
>
> +#include <linux/dma-buf.h>
> +#include "../core/devmem.h"
> +
>  #include <trace/events/tcp.h>
>
>  #ifdef CONFIG_TCP_MD5SIG
> @@ -2492,7 +2495,7 @@ static void tcp_release_user_frags(struct sock *sk)
>         unsigned long index;
>         void *netmem;
>
> -       xa_for_each(&sk->sk_user_frags, index, netmem)
> +       xa_for_each(&sk->sk_devmem_info.frags, index, netmem)
>                 WARN_ON_ONCE(!napi_pp_put_page((__force netmem_ref)netmem=
));
>  #endif
>  }
> @@ -2503,7 +2506,11 @@ void tcp_v4_destroy_sock(struct sock *sk)
>
>         tcp_release_user_frags(sk);
>
> -       xa_destroy(&sk->sk_user_frags);
> +       xa_destroy(&sk->sk_devmem_info.frags);
> +       if (sk->sk_devmem_info.binding) {
> +               net_devmem_dmabuf_binding_put(sk->sk_devmem_info.binding)=
;

I don't understand the refcounting relationsship between the binding
and the socket when autorelease=3Doff. It seems you're grabbing a
reference on the binding on every recvmsg(), but only dropping the
reference on the binding once here, so the binding is never freed.

> +               sk->sk_devmem_info.binding =3D NULL;
> +       }
>
>         trace_tcp_destroy_sock(sk);
>
> diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
> index bd5462154f97..2aec977f5c12 100644
> --- a/net/ipv4/tcp_minisocks.c
> +++ b/net/ipv4/tcp_minisocks.c
> @@ -662,7 +662,8 @@ struct sock *tcp_create_openreq_child(const struct so=
ck *sk,
>
>         __TCP_INC_STATS(sock_net(sk), TCP_MIB_PASSIVEOPENS);
>
> -       xa_init_flags(&newsk->sk_user_frags, XA_FLAGS_ALLOC1);
> +       xa_init_flags(&newsk->sk_devmem_info.frags, XA_FLAGS_ALLOC1);
> +       newsk->sk_devmem_info.binding =3D NULL;
>
>         return newsk;
>  }
> diff --git a/tools/include/uapi/linux/netdev.h b/tools/include/uapi/linux=
/netdev.h
> index e0b579a1df4f..1e5c209cb998 100644
> --- a/tools/include/uapi/linux/netdev.h
> +++ b/tools/include/uapi/linux/netdev.h
> @@ -207,6 +207,7 @@ enum {
>         NETDEV_A_DMABUF_QUEUES,
>         NETDEV_A_DMABUF_FD,
>         NETDEV_A_DMABUF_ID,
> +       NETDEV_A_DMABUF_AUTORELEASE,
>
>         __NETDEV_A_DMABUF_MAX,
>         NETDEV_A_DMABUF_MAX =3D (__NETDEV_A_DMABUF_MAX - 1)
>
> --
> 2.47.3
>


--=20
Thanks,
Mina

