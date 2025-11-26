Return-Path: <linux-arch+bounces-15084-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD07C8932C
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 11:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6DC03B1FBE
	for <lists+linux-arch@lfdr.de>; Wed, 26 Nov 2025 10:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B7612FFDE0;
	Wed, 26 Nov 2025 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZNWcYAL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FB31096F;
	Wed, 26 Nov 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764151897; cv=none; b=OvKpZ2XaHwGYkba0GqYDFgIJfBgps3QuRCv6aapo0IE/GY4e3vJaK3V1ukEAIQ1adOix1AGcoSIub9TmWs1i/vnNcftg7jjjBjX8RlkldkXpR/amwoaNUzdOJY7FwHC1ItDSFiyMjxB7hWSMvLAWJRBlqDqY1Qw8ld1lcBOMaV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764151897; c=relaxed/simple;
	bh=kdG/ZRqhPgBjoMhG3fiqvya54/gxQE7eHn54iqnwW6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UNS2zK34WLuYhNDbchgsWw24BwShM3FRIqbgu5eZv99RQQUMREdRErT6FOpXrKtbsQVslticRq+ha4bz3y2ScXhO+8qIdrs7dYjW61o/KMRCIEleWzrNRFesIuAyw3x1wFqYuNkrKm9ou0UyAvO60cAK2kBLbNtoUE9KYkYs3F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZNWcYAL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D8FC116D0;
	Wed, 26 Nov 2025 10:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764151896;
	bh=kdG/ZRqhPgBjoMhG3fiqvya54/gxQE7eHn54iqnwW6o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oZNWcYALKbLE8wIN2Apm5e446XWKO36td7TLExKiVzT9j3PnN73vV3lnUwGhJdwf1
	 0QQMgAl5Nc3Jp7iciP4CuK3gn5YjVNgNOZmMrF1bH3L8cOWy9+hRAgFLqXzXQvNwSM
	 Gpo43KQzvclMTVZbZYrqH+TQOX9S9IWerUHRrmrs16akGQyiBewUm3CeVaSQviJWaI
	 USptLH/XbL9t26k0AWZdGrB4o3mq1qZB4Yu8PIqU5uQSFzk2agscdNmee0iL+VoABf
	 Ef6LVGAR01WW+k9TJljX3e6Cdw8AP8789dq6tG+O3gLJiznjgF6gCwXZX0pe12ONCj
	 wbMS+UEV4TB8A==
Date: Wed, 26 Nov 2025 10:11:30 +0000
From: Simon Horman <horms@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
Message-ID: <aSbSUre5TNChO4Ah@horms.kernel.org>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
 <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-3-1abc8467354c@meta.com>

On Wed, Nov 19, 2025 at 07:37:10PM -0800, Bobby Eshleman wrote:

...

> @@ -292,25 +327,67 @@ net_devmem_bind_dmabuf(struct net_device *dev,

...

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
> +			else
> +				static_branch_disable(&tcp_devmem_ar_key);

Hi Bobby,

This code runs inside xa_lock, which is a spinlock.

But static_branch_enable() and static_branch_disable()
may sleep due to some combination of taking a mutex
and cpu_read_lock.

Flagged by Claude Code with https://github.com/masoncl/review-prompts/

> +		}
> +	}
> +
> +	err = __xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> +				binding, xa_limit_32b, &id_alloc_next,
> +				GFP_KERNEL);
>  	if (err < 0)
> -		goto err_free_chunks;
> +		goto err_unlock_xa;
> +
> +	xa_unlock(&net_devmem_dmabuf_bindings);
>  
>  	list_add(&binding->list, &priv->bindings);
>  
>  	return binding;
>  
> +err_unlock_xa:
> +	xa_unlock(&net_devmem_dmabuf_bindings);

...

