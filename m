Return-Path: <linux-arch+bounces-15012-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79100C7AE35
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232473A26F9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Nov 2025 16:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37C32E9EDD;
	Fri, 21 Nov 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQ3s+1Os"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDBF2DFA31
	for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 16:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743196; cv=none; b=TqlxvF34dtW2awDSXQbEgvwtBrV3wq4bF/jw0uJAlVB/nTDZJQAaYdeokrmzJCd7jUzhPVPBse4uS1HQIQKW+hHiKV8kWg8vj5gEkR8vsmOE/2bN2RBhc9tZqs5KY6+6M+XfUOCd5yMFR8GDzoFvu83fhN8YlrsaXffKnDs5SnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743196; c=relaxed/simple;
	bh=E/CkR0oPTDHIWZ5P4xoi6YTbqQhmlnXi2pCmKe+Q+a0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/CWgnmuqzVi0SVtZkAjp/GxHwDeRgxebkkm5Ir+6gc8lChwYh8hwX381IcwNYE8XbanSP0tVHFAGGcekcVpQauTuqfoFdr3V1iJBO2BTe29WR1dIAebRIRTtNWu9zhBc3DoyVYBOcllG3+0zQlkHOLVTBKyPwJjtCphqhn1AR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQ3s+1Os; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7bf0ad0cb87so2027783b3a.2
        for <linux-arch@vger.kernel.org>; Fri, 21 Nov 2025 08:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743191; x=1764347991; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pnU5nBLsGzkufGoSn+ALwS2raCEiqjnUS+ssSgvuwMQ=;
        b=dQ3s+1OsvIRGacJWJpez7eLYnVpcdfSiW2nlIgH2cO0tBxQbL1QLzot210zoT/5zBd
         oWkZTZd/ww0HJKQ3REvpY3zt/7lOnb4DBfNEqA1fh1HFDt5kfgvuYvTyer1mpMg29k/Z
         skOuV1WPONa3rJreSztD3Hiavsy7Ub2iQJYd0Hiyi2mU92UeoLmGwKQHN9M5iu8lOMgm
         XUxoFtH4/WrE9w3ccXUsugPQQlh8JiGQWidNDyvh+ph6Q/pj5QHXYwn7pLLciWc52G+V
         oSxDo3Ut++dtZX8FUoiGhe3FXnx174vJVXUTDdx9vFXJBLwSpuuDjLyrzXs4mloTcR4d
         toNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743191; x=1764347991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pnU5nBLsGzkufGoSn+ALwS2raCEiqjnUS+ssSgvuwMQ=;
        b=S2SOWTCUj8tbwhKaIvuV8a1UUuhyfLOkt6ojFFaivn9W2nTk1CLMHKa8vq2tn0ht2R
         AkeawrgCG0LVpl7xGQ5jpoH51zxjVB+xaqiqmJwZHhpy9rgwCd7003mazAnNztyrLY9R
         4oGSN9ph2IL7EJC9Ileh3rNIedUrcPcuZOkGZdSTpW9+6Il1Le7Ia1qOFg5XK9/1tU1I
         83Skz7PE+rbjY5qAKJvmBuekGreFjBiP/fZBgUsdtaZjXxjWr4fpk6vrV6RTtnil+tz0
         oRv6N9H607/lL+nNeCb/huilFDrDTSSg3MsEo0iB1H60hCospM7sVKwqiCbGwcQ3Fkd6
         f/Cg==
X-Forwarded-Encrypted: i=1; AJvYcCX1nBJNfl/WGjTfPNBkrxgrSZuLjWkHmYMgKswv9WywbPBQ4z8qnQtvGtR7P1bGx+u78o5FWUeU7Dwa@vger.kernel.org
X-Gm-Message-State: AOJu0YzesdZFvRUyY/Z3V2Dq596YmNPmkwbGFYatT62DKOwpm+gXjvdF
	x2gEVDdUxj3OYyKbqU2qIGqSxlO1SIQxqXs5d+fv/1ZvKBQi/awrd1mnTNMI
X-Gm-Gg: ASbGncslIU0ti1h4ugbh8u/wVCGRmcLO7+vBdmukS7Zwdt857xkdTBzCu7xCN9IJUY8
	Zo53Sk/65UJjloJlZolGazmA4XfA/V7pojmpVzfrKaUZvKsSchMbXsx+5aGpFnCcNLUtKLTrrNo
	rLOad06rMk/fnP9g9fHC3X2H49fy+nkydIsGaUhKEoLOmuaNZ2LuvBzguZ4fotgwcXvpcp4QjSY
	scqJYQfNw7oJyLuvKWatZiJA9kIe0zTv6eumHqFK3WnP/4vhuv+zzNhU5ZRSltuXCzQb/7cWyiM
	bF2zWBrSRRan8oUsu4zbXQTefb4LCwgh/jt7CWAxIrf7+BUIVwkpWpL2tQnK/yYRaNj6m+JgwHa
	DdEKq7ufsLuyqxa+dcfB3X8c9CwJTHWgHZltGr8hrlCADKc5pQrNKtBL3gFXtrknUYqBq2EJOqP
	0OZfsnMUmj//zVKUN+OlbMwQa4o4WAiMVvawVHLG9Wat3tMH7cqNnqYD16XeIyIhnj9ZGu4Ow7c
	0I5cUg5zSdCChYmBEhJUmEzq0FZfXlnL9gSGMZ/pnxl/1XskGnR4BRiSBAYpwEPsVo=
X-Google-Smtp-Source: AGHT+IHU699+6Ifh8NEUmXAuAuQveBogk1SKpW7FpMeKTg89oLc0cuGqav8T2kpfNI/vdUKBRyQJNQ==
X-Received: by 2002:a05:6a20:3c8e:b0:35e:6c3:c8d6 with SMTP id adf61e73a8af0-36150f2d90dmr3644667637.41.1763743191113;
        Fri, 21 Nov 2025 08:39:51 -0800 (PST)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bd76129de4dsm5987736a12.36.2025.11.21.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:39:50 -0800 (PST)
Date: Fri, 21 Nov 2025 08:39:50 -0800
From: Stanislav Fomichev <stfomichev@gmail.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
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
 management
Message-ID: <aSCV1ihk4pZoBDeI@mini-arch>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>

On 11/19, Bobby Eshleman wrote:
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
>  include/net/sock.h                      |   7 +-
>  include/uapi/linux/netdev.h             |   1 +
>  net/core/devmem.c                       | 109 +++++++++++++++++++++++++++-----
>  net/core/devmem.h                       |  11 +++-
>  net/core/netdev-genl-gen.c              |   5 +-
>  net/core/netdev-genl.c                  |  13 +++-
>  net/core/sock.c                         |  57 +++++++++++++++--
>  net/ipv4/tcp.c                          |  78 ++++++++++++++++++-----
>  net/ipv4/tcp_ipv4.c                     |  13 +++-
>  net/ipv4/tcp_minisocks.c                |   3 +-
>  tools/include/uapi/linux/netdev.h       |   1 +
>  13 files changed, 262 insertions(+), 49 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/netdev.yaml b/Documentation/netlink/specs/netdev.yaml
> index 82bf5cb2617d..913fccca4c4e 100644
> --- a/Documentation/netlink/specs/netdev.yaml
> +++ b/Documentation/netlink/specs/netdev.yaml
> @@ -562,6 +562,17 @@ attribute-sets:
>          type: u32
>          checks:
>            min: 1
> +      -
> +        name: autorelease
> +        doc: |
> +          Token autorelease mode. If true (1), leaked tokens are automatically
> +          released when the socket closes. If false (0), leaked tokens are only
> +          released when the dmabuf is unbound. Once a binding is created with a
> +          specific mode, all subsequent bindings system-wide must use the same
> +          mode.
> +
> +          Optional. Defaults to false if not specified.
> +        type: u8
>  
>  operations:
>    list:
> @@ -767,6 +778,7 @@ operations:
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
>  	};
>  	struct net_iov_area *owner;
>  	enum net_iov_type type;
> +	atomic_t uref;
>  };
>  
>  struct net_iov_area {
> diff --git a/include/net/sock.h b/include/net/sock.h
> index a5f36ea9d46f..797b21148945 100644
> --- a/include/net/sock.h
> +++ b/include/net/sock.h
> @@ -350,7 +350,7 @@ struct sk_filter;
>    *	@sk_scm_rights: flagged by SO_PASSRIGHTS to recv SCM_RIGHTS
>    *	@sk_scm_unused: unused flags for scm_recv()
>    *	@ns_tracker: tracker for netns reference
> -  *	@sk_user_frags: xarray of pages the user is holding a reference on.
> +  *	@sk_devmem_info: the devmem binding information for the socket
>    *	@sk_owner: reference to the real owner of the socket that calls
>    *		   sock_lock_init_class_and_name().
>    */
> @@ -579,7 +579,10 @@ struct sock {
>  	struct numa_drop_counters *sk_drop_counters;
>  	struct rcu_head		sk_rcu;
>  	netns_tracker		ns_tracker;
> -	struct xarray		sk_user_frags;
> +	struct {
> +		struct xarray				frags;
> +		struct net_devmem_dmabuf_binding	*binding;
> +	} sk_devmem_info;
>  
>  #if IS_ENABLED(CONFIG_PROVE_LOCKING) && IS_ENABLED(CONFIG_MODULES)
>  	struct module		*sk_owner;
> diff --git a/include/uapi/linux/netdev.h b/include/uapi/linux/netdev.h
> index 048c8de1a130..dff0be8223a4 100644
> --- a/include/uapi/linux/netdev.h
> +++ b/include/uapi/linux/netdev.h
> @@ -206,6 +206,7 @@ enum {
>  	NETDEV_A_DMABUF_QUEUES,
>  	NETDEV_A_DMABUF_FD,
>  	NETDEV_A_DMABUF_ID,
> +	NETDEV_A_DMABUF_AUTORELEASE,
>  
>  	__NETDEV_A_DMABUF_MAX,
>  	NETDEV_A_DMABUF_MAX = (__NETDEV_A_DMABUF_MAX - 1)
> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 4dee2666dd07..bba21c6cb195 100644
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
> @@ -28,6 +29,17 @@
>  
>  static DEFINE_XARRAY_FLAGS(net_devmem_dmabuf_bindings, XA_FLAGS_ALLOC1);
>  
> +/* Static key to lock down autorelease to a single mode on a system.  When
> + * enabled: autorelease mode (leaked tokens released on socket close).  When
> + * disabled: manual mode (leaked tokens released on dmabuf unbind).  Once the
> + * first binding is created, the mode is locked system-wide and can not be
> + * changed until the system has zero bindings again.
> + *
> + * Protected by xa_lock of net_devmem_dmabuf_bindings.
> + */
> +DEFINE_STATIC_KEY_FALSE(tcp_devmem_ar_key);
> +EXPORT_SYMBOL(tcp_devmem_ar_key);
> +
>  static const struct memory_provider_ops dmabuf_devmem_ops;
>  
>  bool net_is_devmem_iov(struct net_iov *niov)
> @@ -116,6 +128,24 @@ void net_devmem_free_dmabuf(struct net_iov *niov)
>  	gen_pool_free(binding->chunk_pool, dma_addr, PAGE_SIZE);
>  }
>  
> +static void
> +net_devmem_dmabuf_binding_put_urefs(struct net_devmem_dmabuf_binding *binding)
> +{
> +	int i;
> +
> +	for (i = 0; i < binding->dmabuf->size / PAGE_SIZE; i++) {
> +		struct net_iov *niov;
> +		netmem_ref netmem;
> +
> +		niov = binding->vec[i];
> +		netmem = net_iov_to_netmem(niov);
> +
> +		/* Multiple urefs map to only a single netmem ref. */
> +		if (atomic_xchg(&niov->uref, 0) > 0)
> +			WARN_ON_ONCE(!napi_pp_put_page(netmem));
> +	}
> +}
> +
>  void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  {
>  	struct netdev_rx_queue *rxq;
> @@ -143,6 +173,10 @@ void net_devmem_unbind_dmabuf(struct net_devmem_dmabuf_binding *binding)
>  		__net_mp_close_rxq(binding->dev, rxq_idx, &mp_params);
>  	}
>  
> +	/* Clean up any lingering urefs from sockets that had autorelease
> +	 * disabled.
> +	 */
> +	net_devmem_dmabuf_binding_put_urefs(binding);
>  	net_devmem_dmabuf_binding_put(binding);
>  }
>  
> @@ -179,8 +213,10 @@ struct net_devmem_dmabuf_binding *
>  net_devmem_bind_dmabuf(struct net_device *dev,
>  		       struct device *dma_dev,
>  		       enum dma_data_direction direction,
> -		       unsigned int dmabuf_fd, struct netdev_nl_sock *priv,
> -		       struct netlink_ext_ack *extack)
> +		       unsigned int dmabuf_fd,
> +		       struct netdev_nl_sock *priv,
> +		       struct netlink_ext_ack *extack,
> +		       bool autorelease)
>  {
>  	struct net_devmem_dmabuf_binding *binding;
>  	static u32 id_alloc_next;
> @@ -231,14 +267,13 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  		goto err_detach;
>  	}
>  
> -	if (direction == DMA_TO_DEVICE) {
> -		binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> -					      sizeof(struct net_iov *),
> -					      GFP_KERNEL);
> -		if (!binding->vec) {
> -			err = -ENOMEM;
> -			goto err_unmap;
> -		}
> +	/* Used by TX and also by RX when socket has autorelease disabled */
> +	binding->vec = kvmalloc_array(dmabuf->size / PAGE_SIZE,
> +				      sizeof(struct net_iov *),
> +				      GFP_KERNEL | __GFP_ZERO);
> +	if (!binding->vec) {
> +		err = -ENOMEM;
> +		goto err_unmap;
>  	}
>  
>  	/* For simplicity we expect to make PAGE_SIZE allocations, but the
> @@ -292,25 +327,67 @@ net_devmem_bind_dmabuf(struct net_device *dev,
>  			niov = &owner->area.niovs[i];
>  			niov->type = NET_IOV_DMABUF;
>  			niov->owner = &owner->area;
> +			atomic_set(&niov->uref, 0);
>  			page_pool_set_dma_addr_netmem(net_iov_to_netmem(niov),
>  						      net_devmem_get_dma_addr(niov));
> -			if (direction == DMA_TO_DEVICE)
> -				binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
> +			binding->vec[owner->area.base_virtual / PAGE_SIZE + i] = niov;
>  		}
>  
>  		virtual += len;
>  	}
>  
> -	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> -			      binding, xa_limit_32b, &id_alloc_next,
> -			      GFP_KERNEL);
> +	/* Enforce system-wide autorelease mode consistency for RX bindings.
> +	 * TX bindings don't use autorelease (always false) since tokens aren't
> +	 * leaked in TX path. Only RX bindings must all have the same
> +	 * autorelease mode, never mixed.
> +	 *
> +	 * We use the xarray's lock to atomically check xa_empty() and toggle
> +	 * the static key, avoiding the race where two new bindings may try to
> +	 * set the static key to different states.
> +	 */
> +	xa_lock(&net_devmem_dmabuf_bindings);
> +
> +	if (direction == DMA_FROM_DEVICE) {
> +		if (!xa_empty(&net_devmem_dmabuf_bindings)) {
> +			bool mode;
> +
> +			mode = static_key_enabled(&tcp_devmem_ar_key);
> +
> +			/* When bindings exist, enforce that the mode does not
> +			 * change.
> +			 */
> +			if (mode != autorelease) {
> +				NL_SET_ERR_MSG_FMT(extack,
> +						   "System already configured with autorelease=%d",
> +						   mode);
> +				err = -EINVAL;
> +				goto err_unlock_xa;
> +			}
> +		} else {
> +			/* First binding sets the mode for all subsequent
> +			 * bindings.
> +			 */
> +			if (autorelease)
> +				static_branch_enable(&tcp_devmem_ar_key);

[..]

> +			else
> +				static_branch_disable(&tcp_devmem_ar_key);

nit: don't think this is needed? DEFINE_STATIC_KEY_FALSE should already
have it disabled by default iiuc.

I was also expecting to see something in net_devmem_unbind_dmabuf to undo
this static_branch_enable(tcp_devmem_ar_key) and bring the system
back into the default state, but I can't find it. Am I missing
something?

The rest looks good to me, thanks! Let's see if Mina sees any problems
with this approach. IMO, it's a bit easier to reason about two separate
code paths now.

