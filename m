Return-Path: <linux-arch+bounces-15756-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFFFD1693F
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 05:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 860B33015023
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jan 2026 04:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D04934F24A;
	Tue, 13 Jan 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1TDpylX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B621773F;
	Tue, 13 Jan 2026 04:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276868; cv=none; b=XDkboXnRW+DezBtP7Y6N5Ydv9qD05fSv89eS36kKsN3o2TgC0Rh5IZ+WI17ELsrMmHHGPmWJiPmrUwYnBmSl40sTfLzuSwVF2BxYhzTf7n+dVJXg14X20uDpLy0KHxsgaRKxzK0e7NPO93uDLAjUu5aV3mSMU/TV5tyWe+/otis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276868; c=relaxed/simple;
	bh=zeKl7hyNxZwIHJcgtp1F5TMvGZu6CxehegF23qeqIqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D38ebNNG2a6Gw9lxPtEOV7ojePx6wuTFWJIfDIEoKPEV5yEnqGD5tNbPx8MXEjvTtJ9DKF9soXVgNz7jRRfqn/4kvRPWwdNKTtGv8R9Y69WXHyiibvSPziZjgQSufNQNzMyXr4WKWc8w6G5jqNNNi7g4dBAJmmNeCGZj2uBai3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1TDpylX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65DEC116C6;
	Tue, 13 Jan 2026 04:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768276867;
	bh=zeKl7hyNxZwIHJcgtp1F5TMvGZu6CxehegF23qeqIqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i1TDpylXu6DyoRUGdArfaYVao79IWJYNZvr3gvJxT608pHMK2CLlDLAgtY7k2P7yw
	 q6bhzQGINdxS/gTQ9Ze/g30RcCmh9/xyHzcuyzRJLSOphbYRtwHjgK7pM0BO8OwGCP
	 Gby9KdMrotoUWeeMilkOPBfe4oBqiXlf7nloc4lYG23eQkbCDS8enrdkq5gJzzZ0Nd
	 rSRwLwQyBPe7x3kplpHpPhIyhsUr3Xd3BH1lHQVhqUz7zJWTLZVnvqaqJ9CYcf43wm
	 ugeEaazyF+qjhgkQkqCud0N08zeuSmaMTd7EJKyJKnoThNWKiBaH41HhXqJNoqz39G
	 g3PvVi4qpCJUg==
From: Jakub Kicinski <kuba@kernel.org>
To: bobbyeshleman@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	horms@kernel.org,
	linux-arch@vger.kernel.org,
	pabeni@redhat.com,
	willemb@google.com,
	davem@davemloft.net,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	matttbe@kernel.org,
	linux-kernel@vger.kernel.org,
	asml.silence@gmail.com,
	arnd@arndb.de,
	netdev@vger.kernel.org,
	almasrymina@google.com,
	linux-kselftest@vger.kernel.org,
	skhawaja@google.com,
	bobbyeshleman@meta.com,
	ncardwell@google.com,
	andrew+netdev@lunn.ch,
	kuniyu@google.com,
	edumazet@google.com,
	sdf@fomichev.me,
	corbet@lwn.net,
	dsahern@kernel.org,
	shuah@kernel.org
Subject: Re: [net-next,v9,3/5] net: devmem: implement autorelease token management
Date: Mon, 12 Jan 2026 20:00:27 -0800
Message-ID: <20260113040027.409308-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
References: <20260109-scratch-bobbyeshleman-devmem-tcp-token-upstream-v9-3-8042930d00d7@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least pausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: devmem: implement autorelease token management

This commit adds autorelease mode toggling for devmem tokens using a
static branch. The system is locked into the mode set by the first
binding and can only change when all bindings are released.

> diff --git a/net/core/devmem.c b/net/core/devmem.c
> index 05a9a9e7abb9..05c16df657c7 100644
> --- a/net/core/devmem.c
> +++ b/net/core/devmem.c

[ ... ]

> @@ -292,25 +333,62 @@ net_devmem_bind_dmabuf(struct net_device *dev,

[ ... ]

> +	mutex_lock(&devmem_ar_lock);
> +
> +	if (direction == DMA_FROM_DEVICE) {
> +		if (net_devmem_dmabuf_rx_bindings_count > 0) {
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
> +				goto err_unlock_mutex;
> +			}
> +		} else if (autorelease) {
> +			/* First binding with autorelease enabled sets the
> +			 * mode.  If autorelease is false, the key is already
> +			 * disabled by default so no action is needed.
> +			 */
> +			static_branch_enable(&tcp_devmem_ar_key);
> +		}
> +
> +		net_devmem_dmabuf_rx_bindings_count++;
> +	}
> +
> +	err = xa_alloc_cyclic(&net_devmem_dmabuf_bindings, &binding->id,
> +			      binding, xa_limit_32b, &id_alloc_next,
> +			      GFP_KERNEL);
> +	if (err < 0)
> +		goto err_dec_binding_count;
> +
> +	mutex_unlock(&devmem_ar_lock);
> +
> +	list_add(&binding->list, &priv->bindings);
> +
> +	return binding;
> +
> +err_dec_binding_count:
> +	if (direction == DMA_FROM_DEVICE)
> +		net_devmem_dmabuf_rx_bindings_count--;
                ^^^

If xa_alloc_cyclic() fails after the first binding with autorelease=true,
the static branch tcp_devmem_ar_key remains enabled even though
net_devmem_dmabuf_rx_bindings_count is decremented back to zero. Should
the error path also call static_branch_disable() when the count returns
to zero, similar to what __net_devmem_dmabuf_binding_free() does?

This appears to leave the system in an inconsistent state where a
subsequent binding with autorelease=false would succeed (since count is
zero) but the static branch is still enabled from the failed attempt.
The SO_DEVMEM_DONTNEED handler would then call the wrong function
(autorelease path instead of manual release path).

> +
> +err_unlock_mutex:
> +	mutex_unlock(&devmem_ar_lock);

[ ... ]
-- 
pw-bot: cr

