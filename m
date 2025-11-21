Return-Path: <linux-arch+bounces-15021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 00605C7B298
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 19:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCAE734BCD8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 17:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C7F34EEF6;
	Fri, 21 Nov 2025 17:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPZB22Ig"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769453128CB
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763747912; cv=none; b=jxHaLiumK6v56WY4UsTru3KFidJSLtSRp4/5MOO5UjwJTS0K+orTDrpahAnPaf2RtyLp2P+WkEPO4j1DlOSo4CMq644csUyp8+k5+zHx4ETAwtVh5lnEA0jAYOlmJqgNBYQ1gvte5sg+mCjliWkrtyNufm1JsS2SSXzswCvkRLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763747912; c=relaxed/simple;
	bh=jcychTIOgsj9PiSzpZOeK13KKMIRzWnTDs2r/eSb5Gg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqgggQXIAqhjZDsVYmQzImdU2czS4jZv9DajgekYRejad4eEtmLWl+drYtTmg8LxzXhnDM4ZHFm02sOqKMyasUZ14M6iLBa5LACPowLZuz8CTFahtvULLWxmKkY4Agc8yKCISi7fCu7NdX52AYcJ9jIKWjDNXy9fZ2EHXVKlAZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPZB22Ig; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-6420c0cf4abso2119459d50.1
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 09:58:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763747908; x=1764352708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Fxmx2K5QemyW9VFkBBRJoc8Q0bzKrj6dbV60qZm/emY=;
        b=jPZB22IghxkrVV1h5GViRxVBL6gEhzFeta8FG9Ksp6l6PlPpDneLufoM8dtBA3jbgt
         HzoW567bcvx1PWHiKel3sIl18iR8G8CPdY1mAc06pHsN6eY3STY6keLZOyuU2GN+usOI
         JcleU7t6UzQlBOOX70OD6uFj6VS2sAcSp8JISj8ZetXMatWW3GyZyeXYLU+CZUgEQLyE
         uLiB8WV9ktKgGMJSQo0noOfdt+1fdrc9UWLCdPP2F2jgKUD7QqJbyO5tra6h+Wh/tLce
         IHEViM0jWpgM4Sfp2UZwd6Rog/IsqcurDwvMJJIzETEY5uk0hrD2n56XfXk+E9YjMRlB
         s6Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763747908; x=1764352708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Fxmx2K5QemyW9VFkBBRJoc8Q0bzKrj6dbV60qZm/emY=;
        b=rMV+WSCkANAEAC9CnVF6Gg042SI/R954suo408JDXPi0ML+E6+5cD153f0hR51nF7U
         7el3yLPDazGyKw5IkCrHdg0GSix7VeayGdjI+gYZPUc0KyBvNB2bz8sxHVbf+KFnnvtd
         cqp8IejBj2xFFnhCEU5Lo23FtEVThZtNbbOCfqdxR6Ak2zH5y6ce6nTVBNv0zDuhaWnG
         1RPwCr1eJierMqoW3Hi4oEF4KU3nsBmuuqsvgOgC2nGz2OYdIngd97ykyYGhz9gP1AZ1
         HKPgfARz2e6P/irLgs5E4/loEVTM+FcauVFRju0J6Siv8BZGNRo26hRZ6RZFL/IFChjn
         B8Lw==
X-Forwarded-Encrypted: i=1; AJvYcCXoXiHzACJa0axN35AcJiV7LFDelibwlN6bxZqog1MIuziHUgS7YhXIsTW+PtbhRKRhmnC/UNhYl8KE@vger.kernel.org
X-Gm-Message-State: AOJu0YwGto7zfnQt+KlmD5MNtj+WwVOT9fzogJOmy3QBot6iVZm8fsEg
	DeLTGqJn/bLSopxIjnbzbmCSe1Cbb9MQ2Yjtf1EuiXJhJ2T8fRAwvPSB
X-Gm-Gg: ASbGncsvCVum8UaEUOcWSEu1CP0DYXSBlmxuRHuGYzKKkQPvEL69/Yh9swjiCeHQskn
	tmiAJ59Dm3tqV6dyCOmyr7aSxY1yThwlgWm9n4VIkhQIn1usnmvKbYS+zzH+pc/0u4WhugSF0Mc
	FpgQFCuKym868psJdcxE1v1V4Bb9/zhPHNjNRjAMiPmSSGVof9ZkgMFQ0eGbLnzrMfOe69t1nqe
	s/rnvcJErLWvsvvjavPDLoXB1J+CP/1OBvL/sc6a+TT2uRabgfEqFHmpBm7w8XacyEBW84atc8/
	2am70+dvelX/CkPRs/2cs7lg450L4/dZcPJijLWTeG1VZlLayIql10ylS50s2i1Nbr+zUYyZb/e
	RXfO6zNR8gQgqgLO3otM+3xyoeHxymH7kyBUd3YUivSo7/k1vtya1U9XQ/E/ojEYGWANMJ1eSnH
	hMJnJzED1IX/oXLQDPpsekEiDq4meipSt5N+mnhezXot3g4dY=
X-Google-Smtp-Source: AGHT+IGRk8rSAlGf4/9tw4DICK6xdl/0RAwBsdFmxxXyvXzuL4O6b/YdwSN1BI63M2Of7LIlE3O6iA==
X-Received: by 2002:a53:e1ef:0:b0:63f:bf9d:e530 with SMTP id 956f58d0204a3-64302aafe33mr1647897d50.29.1763747908072;
        Fri, 21 Nov 2025 09:58:28 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:43::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-642f7048d7esm1906650d50.4.2025.11.21.09.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 09:58:27 -0800 (PST)
Date: Fri, 21 Nov 2025 09:58:26 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
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
	Mina Almasry <almasrymina@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 3/5] net: devmem: implement autorelease token
 managementy
Message-ID: <aSCoQirZHzkMzrxz@devvm11784.nha0.facebook.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
 <aSCV1ihk4pZoBDeI@mini-arch>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aSCV1ihk4pZoBDeI@mini-arch>

On Fri, Nov 21, 2025 at 08:39:50AM -0800, Stanislav Fomichev wrote:
> On 11/19, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Add support for autorelease toggling of tokens using a static branch to
> > control system-wide behavior. This allows applications to choose between
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
> > - add comment about multiple urefs mapping to a single netmem ref (Mina)
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
> >  include/net/sock.h                      |   7 +-
> >  include/uapi/linux/netdev.h             |   1 +
> >  net/core/devmem.c                       | 109 +++++++++++++++++++++++++++-----
> >  net/core/devmem.h                       |  11 +++-
> >  net/core/netdev-genl-gen.c              |   5 +-
> >  net/core/netdev-genl.c                  |  13 +++-
> >  net/core/sock.c                         |  57 +++++++++++++++--
> >  net/ipv4/tcp.c                          |  78 ++++++++++++++++++-----
> >  net/ipv4/tcp_ipv4.c                     |  13 +++-
> >  net/ipv4/tcp_minisocks.c                |   3 +-
> >  tools/include/uapi/linux/netdev.h       |   1 +
> >  13 files changed, 262 insertions(+), 49 deletions(-)
> > 
> > diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> > index 82bf5cb2617d..913fccca4c4e 100644
> > --- a/Documentation/netlink/specs/netdev.yaml
> > +++ b/Documentation/netlink/specs/netdev.yaml
> > @@ -562,6 +562,17 @@ attribute-sets:
> >          type: u32
> >          checks:
> >            min: 1
> > +      -
> > +        name: autorelease
> > +        doc: |
> > +          Token autorelease mode. If true (1), leaked tokens are automatically
> > +          released when the socket closes. If false (0), leaked tokens are only
> > +          released when the dmabuf is unbound. Once a binding is created with a
> > +          specific mode, all subsequent bindings system-wide must use the same
> > +          mode.
> > +
> > +          Optional. Defaults to false if not specified.
> > +        type: u8
> >  
> >  operations:
> >    list:
> > @@ -767,6 +778,7 @@ operations:
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
> >  	};
> >  	struct net_iov_area *owner;
> >  	enum net_iov_type type;
> > +	atomic_t uref;
> >  };
> >  
> >  struct net_iov_area {
> > diff --git a/include/net/sock.h b/include/net/sock.h
> > index a5f36ea9d46f..797b21148945 100644
> > --- a/include/net/sock.h
> > +++ b/include/net/sock.h
> > @@ -350,7 +350,7 @@ struct sk_filter;
> >    *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
> >    *	@sk_scm_unused: unused flags for scm_recv()
> >    *	@ns_tracker: tracker for netns reference
> > -  *	@sk_user_frags: xarray of pages the user is holding a reference on.
> > +  *	@sk_devmem_info: the devmem binding information for the socket
> >    *	@sk_owner: reference to the real owner of the socket that calls
> >    *		   sock_lock_init_class_and_name().
> >    */
> > @@ -579,7 +579,10 @@ struct sock {
> >  	struct numa_drop_counters *sk_drop_counters;
> >  	struct rcu_head		sk_rcu;
> >  	netns_tracker		ns_tracker;
> > -	struct xarray		sk_user_frags;
> > +	struct {
> > +		struct xarray				frags;
> > +		struct net_devmem_dmabuf_binding	*binding;
> > +	} sk_devmem_info;
> >  
> >  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
> >  	struct module		*sk_owner;
> > diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> > index 048c8de1a130..dff0be8223a4 100644
> > --- a/include/uapi/linux/netdev.h
> > +++ b/include/uapi/linux/netdev.h
> > @@ -206,6 +206,7 @@ enum {
> >  	NETDEV_A_DMABUF_QUEUES,
> >  	NETDEV_A_DMABUF_FD,
> >  	NETDEV_A_DMABUF_ID,
> > +	NETDEV_A_DMABUF_AUTORELEASE,
> >  
> >  	__NETDEV_A_DMABUF_MAX,
> >  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 4dee2666dd07..bba21c6cb195 100644
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
> > @@ -28,6 +29,17 @@
> >  
> >  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
> >  
> > +/* Static key to lock down autorelease to a single mode on a system.  When
> > + * enabled: autorelease mode (leaked tokens released on socket close).  When
> > + * disabled: manual mode (leaked tokens released on dmabuf unbind).  Once the
> > + * first binding is created, the mode is locked system-wide and can not be
> > + * changed until the system has zero bindings again.
> > + *
> > + * Protected by xa_lock of net_devmem_dmabuf_bindings.
> > + */
> > +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> > +EXPORT_SYMBOL(tcp_devmem_ar_key);
> > +
> >  static const struct memory_provider_ops dmabuf_devmem_ops;
> >  
> >  bool net_is_devmem_iov(struct net_iov *niov)
> > @@ -116,6 +128,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
> >  	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
> >  }
> >  
> > +static void
> > +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
> > +{
> > +	int i;
> > +
> > +	for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> > +		struct net_iov *niov;
> > +		netmem_ref netmem;
> > +
> > +		niov = binding->vec[i];
> > +		netmem = net_iov_to_netmem(niov);
> > +
> > +		/* Multiple urefs map to only a single netmem ref. */
> > +		if (atomic_xchg(&niov->uref, 0) > 0)
> > +			WARN_ON_ONCE(!napi_pp_put_page(netmem));
> > +	}
> > +}
> > +
> >  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> >  {
> >  	struct netdev_rx_queue *rxq;
> > @@ -143,6 +173,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
> >  		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
> >  	}
> >  
> > +	/* Clean up any lingering urefs from sockets that had autorelease
> > +	 * disabled.
> > +	 */
> > +	net_devmem_dmabuf_binding_put_urefs(binding);
> >  	net_devmem_dmabuf_binding_put(binding);
> >  }
> >  
> > @@ -179,8 +213,10 @@ struct net_devmem_dmabuf_binding *
> >  net_devmem_bind_dmabuf(struct net_device *dev,
> >  		       struct device *dma_dev,
> >  		       enum dma_data_direction direction,
> > -		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
> > -		       struct netlink_ext_ack *extack)
> > +		       unsigned int dmabuf_fd,
> > +		       struct netdev_nl_sock *priv,
> > +		       struct netlink_ext_ack *extack,
> > +		       bool autorelease)
> >  {
> >  	struct net_devmem_dmabuf_binding *binding;
> >  	static u32 id_alloc_next;
> > @@ -231,14 +267,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >  		goto err_detach;
> >  	}
> >  
> > -	if (direction == DMA_TO_DEVICE) {
> > -		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > -					      sizeof(struct net_iov *),
> > -					      GFP_KERNEL);
> > -		if (!binding->vec) {
> > -			err = -ENOMEM;
> > -			goto err_unmap;
> > -		}
> > +	/* Used by TX and also by RX when socket has autorelease disabled */
> > +	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> > +				      sizeof(struct net_iov *),
> > +				      GFP_KERNEL | __GFP_ZERO);
> > +	if (!binding->vec) {
> > +		err = -ENOMEM;
> > +		goto err_unmap;
> >  	}
> >  
> >  	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> > @@ -292,25 +327,67 @@ net_devmem_bind_dmabuf(struct net_device *dev,
> >  			niov = &owner->area.niovs[i];
> >  			niov->type = NET_IOV_DMABUF;
> >  			niov->owner = &owner->area;
> > +			atomic_set(&niov->uref, 0);
> >  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
> >  						      net_devmem_get_dma_addr(niov));
> > -			if (direction == DMA_TO_DEVICE)
> > -				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> > +			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> >  		}
> >  
> >  		virtual += len;
> >  	}
> >  
> > -	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> > -			      binding, xa_limit_32b, &id_alloc_next,
> > -			      GFP_KERNEL);
> > +	/* Enforce system-wide autorelease mode consistency for RX bindings.
> > +	 * TX bindings don't use autorelease (always false) since tokens aren't
> > +	 * leaked in TX path. Only RX bindings must all have the same
> > +	 * autorelease mode, never mixed.
> > +	 *
> > +	 * We use the xarray's lock to atomically check xa_empty() and toggle
> > +	 * the static key, avoiding the race where two new bindings may try to
> > +	 * set the static key to different states.
> > +	 */
> > +	xa_lock(&net_devmem_dmabuf_bindings);
> > +
> > +	if (direction == DMA_FROM_DEVICE) {
> > +		if (!xa_empty(&net_devmem_dmabuf_bindings)) {
> > +			bool mode;
> > +
> > +			mode = static_key_enabled(&tcp_devmem_ar_key);
> > +
> > +			/* When bindings exist, enforce that the mode does not
> > +			 * change.
> > +			 */
> > +			if (mode != autorelease) {
> > +				NL_SET_ERR_MSG_FMT(extack,
> > +						   "System already configured with autorelease=%d",
> > +						   mode);
> > +				err = -EINVAL;
> > +				goto err_unlock_xa;
> > +			}
> > +		} else {
> > +			/* First binding sets the mode for all subsequent
> > +			 * bindings.
> > +			 */
> > +			if (autorelease)
> > +				static_branch_enable(&tcp_devmem_ar_key);
> 
> [..]
> 
> > +			else
> > +				static_branch_disable(&tcp_devmem_ar_key);
> 
> nit: don't think this is needed? DEFINE_STATIC_KEY_FALSE should already
> have it disabled by default iiuc.
> 
> I was also expecting to see something in net_devmem_unbind_dmabuf to undo
> this static_branch_enable(tcp_devmem_ar_key) and bring the system
> back into the default state, but I can't find it. Am I missing
> something?

So the way I've written it here is that the branch state always updates
according to the mode of the first binding, so we can just ignore the
branch state when unbind reaches zero bindings (it will update the next
time we see a first binding anyway).

... but I think your mental model is a bit simpler and probably fewer
lines, and we can move to it for the next rev if Mina is okay with the
overall approach.

In that, we enforce that when no bindings are alive the branch is
disabled, and only updates when the first binding mode is autorelease=1,
the autorelease=0 case is a no-op when binding. Unbind restores to
disabled when it sees no more bindings.

> 
> The rest looks good to me, thanks! Let's see if Mina sees any problems
> with this approach. IMO, it's a bit easier to reason about two separate
> code paths now.


Thanks!

Best,
Bobby

