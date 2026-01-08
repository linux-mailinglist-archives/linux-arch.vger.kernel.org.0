Return-Path: <linux-arch+bounces-15704-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DC25CD013AD
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 07:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 518253001FEE
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 06:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B70145B3F;
	Thu,  8 Jan 2026 06:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Le59AOzc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9AB14A91
	for <linux-arch@vger.kernel.org>; Thu,  8 Jan 2026 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767853082; cv=none; b=EiYTvgf36o63FWQUA+uDPEgH8fCJl0/szi7circDFNeC0Qho13GuwDF4cufKxR4YaKeG9Jt4lmhaGvxURdG8gmeulYnyflzEpxdv6FHd4vdiBoBLKBtO5sufXUHIZYQduVSc4aIBOcTGN7Pgxjt9rugyFdkYJMV5FbllEsDL7w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767853082; c=relaxed/simple;
	bh=maWf8E4/nR6r4iZkfiudPX2lmDBux7LpubjWVpgYQew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTa1aIp9i4HU/x6zHNoYVIX9lIaQ23yaiFWL8meGyl5vcDM/pb5qE551eJJd8IUzE9SybWHoJEZII6CAokCZN8STOBFwrQYZn/muLI2doo7b86LSKXN3lJmJGV3Rny9bbcxcG5jIhikK2eLGQomKlNGIdjeYbZ9qPbCv18KjAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Le59AOzc; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-11f42e971d6so4501053c88.0
        for <linux-arch@vger.kernel.org>; Wed, 07 Jan 2026 22:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767853080; x=1768457880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=Le59AOzcsyPThfqvpFMTiuio5a9ix+A5gqBJ7m/m3g6oHuHbUH5WiZMUPunGd4ca0Q
         p1FNqHDvUdvyFrZIJ0BS2lXqLQfKrPguUkCowXqeHg18swxnP6+mp42FSdtZ9BiW8vtq
         HWXC12Wd+BgY633HtbXpDx3+Z0AqfNJSNo4NeCKOfN2JsGlMzJufBGRlf1nysywPgjE3
         H4DCdPLNAfMQViIgyITo0qHK80yuiiWMEHxMrmsvxJwlOIDqbdMH8dBcpSzq2ozk4x94
         /i5s+eSCKkUeljWozshLywhLnSOkbRUDjj3h509xqJ3HHDpl6LP32joVFvbe9oM1zLGZ
         0ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767853080; x=1768457880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZuFRSJyxVGvc7rvYjVUrIZJ8+nTlCmoSPS+Ihaf2wKk=;
        b=gEJ2WLjMZKGec7q/gAC0CXnelSjAnVNBgEB84jArD++RgYcYP9zdHs4bGMeknlrn0U
         wDZ8US/1S/8M35LSV33b5GBiivo8VTFGCbn/IUsZUufNLrK/JC7gqR/jiDaOdtRSlAPb
         PCS45dO6PAR4DETZtx4nCvh9fJspQGyDJHDptAbdpTKS4JZidudurTL7/3LIGoFTbkkF
         RoIM0fJrrRN9fJqOj/6lHm6WbbRpHq7TRVAfV4qQnng3UCw2m96RJwb+BL8p2luIkNZE
         CNrB7Lek+KKCD2DBOgnmRJwo9zLgn4/Ov8+o1poHqDFKFgIBVgImbR9lSxJS+sz9uzKV
         v2/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUdfahfyhhHk1A8GPTHl7R2xBxFSsrLq+rkFRtcS9oRMgLX13LF3bInWNseBLTpF6qQWLDDQ27AuLL@vger.kernel.org
X-Gm-Message-State: AOJu0YwbwF4Ip9D6L/DYUoGr6RpmbP4V3SgdVyVFFdCSiIbLc2nJDgAK
	oOimZr8554yS3CP1ojimNRt9vZYnMj6D8ISdlYDXKXJ5PtlqdnDItMGU1b3jKA==
X-Gm-Gg: AY/fxX6My4p4SmQ1vwHvb36D5Im3965lXo4pXhMWIyrRncXmbuzdiDItw7HzEehcFb1
	+PpwzBrXulKP+ktlHw4q5nekWK2ZK2e4vPwKym7rlv5DcdH3A+L1cS2vwgpxw8Da6b0d0RlYzkt
	5TxUwn89RzcJ1cMyu4qi7TcfqVauETPd+KaqnqQ117vzqJKXZrjIcks3VD2tU1ScXhYbDy99y/l
	nP8/HzNg9YNmk2I9quBzYhu74PJenigXmdggt2d9iE4vtHm05bFSDAc9gT7DAElWntXOLMgsNld
	GY605fiARif+JAywXL8xjF1b3UFqp53QzsqCrfd96L6Gf0b+E6m7dGwIvyWmudeelWGAWMC69g5
	Yzpu9mJUiRfw+3Zy57VQ9TSckiZGCd8OMVlamjOwXUZ6mc1NcXg97YwJmRDPblwaHXOu4Wn2Ol0
	v4fzi8kJBAW1FivYqedB77xKdbvHBLws8F4IE=
X-Google-Smtp-Source: AGHT+IHr+qha1eOTfp4wLQhnqwmJ68KneYOC7GXQfwKel51U3gavmvexU6VxrRyZtU0m6yrWXG1P3w==
X-Received: by 2002:a53:e239:0:b0:63f:ba88:e8e9 with SMTP id 956f58d0204a3-64716bd5e88mr3638566d50.43.1767847054268;
        Wed, 07 Jan 2026 20:37:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6a4d00sm25981107b3.41.2026.01.07.20.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 20:37:33 -0800 (PST)
Date: Wed, 7 Jan 2026 20:37:32 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
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
	Stanislav Fomichev <sdf@fomichev.me>, asml.silence@gmail.com,
	matttbe@kernel.org, skhawaja@google.com,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v8 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
 <20260107193013.0984ab97@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260107193013.0984ab97@kernel.org>

On Wed, Jan 07, 2026 at 07:30:13PM -0800, Jakub Kicinski wrote:
> On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote:
> > This series improves the CPU cost of RX token management by adding an
> > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > binding to avoid the xarray allocator and instead use a per-binding niov
> > array and a uref field in niov.
> 
> net/ipv4/tcp.c:2600:41: error: implicit declaration of function ‘net_devmem_dmabuf_binding_get’; did you mean ‘net_devmem_dmabuf_binding_put’? [-Wimplicit-function-declaration]
>  2600 |                                         net_devmem_dmabuf_binding_get(binding);
>       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>       |                                         net_devmem_dmabuf_binding_put
> -- 
> pw-bot: cr

I see that net_devmem_dmabuf_binding_get() is lacking a
stub for CONFIG_NET_DEVMEM=n ...

Just curious how pw works... is this a randconfig catch? I ask because
all of the build targets pass for this series (build_allmodconfig_warn,
build_clang, etc.. locally and on patchwork.kernel.org), and if there is
a config that pw uses that I'm missing in my local checks I'd like to
add it.

Best,
Bobby

