Return-Path: <linux-arch+bounces-15709-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ABF3FD05472
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 18:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13BD233B87F1
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 17:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BC296BB8;
	Thu,  8 Jan 2026 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksxPnNx8"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D4288C2F
	for <linux-arch@vger.kernel.org>; Thu,  8 Jan 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892013; cv=none; b=nJ7Y7bJaZlToRVqraWSrAAvqMBIK9BxlkOoTpvdOKDM/x9ecXWI8kn0avnLR4z/gjrfJYa1fv/iek2OPGV1Avb15ch3wu4YWTqjJZD8GNRmBrA7Q8giEvDfdmxe8dQQD9G8nnRuXOCGJ0WMgjazprREJLpGPFGsfWw+FpDA8w7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892013; c=relaxed/simple;
	bh=8MyYr+bj1OlCAmDWQAgiMxA/gIzJLt2qgYTntOWG2J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fe/r+V7FTLQ9ZVhxNrxAvOytHYlqQggBi+f4I25Bt3+khmOXuHu0D7fQ1DjDHJGoiJ7qg6McWOfhpcRVLKNLxnbfMC3YByCVRThB0r3hXNwNd3O6zWZfh6VUTNTT1lHzmxXuvZIsCu+FHreq5u1P6JNdI0dB8cE3ApZtG/Ukgjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ksxPnNx8; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-78fc0f33998so35500957b3.0
        for <linux-arch@vger.kernel.org>; Thu, 08 Jan 2026 09:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767892010; x=1768496810; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p6Wvz759GUewXYsc4miB5/+NI5xDR6MKrs+hh+WMf9o=;
        b=ksxPnNx85zgOwrFUmOzzv5mAtG2stN+B5abvL3OBEObYK4oSi7LFtTyb8rg58ApaWm
         JLoWOcC124klwGkya7LWtkr66Vxw2ockrrbty+aEekQhz3OfrrnZlDAoA+XvjIdcZGcd
         /9Dze+hDJ1c7Mo79HZwvPMW3CRZBtiwu8kteX2bJgaQ1Kdva688DwNrsMHlnPW8bmcu8
         9tidfQjaTQ2CdPNuREU8EGwFNLarng85MeVhSh+8ziL4GXaSq8C9jMpKS5bF2Q0gNF/R
         wcnsmEyo2yGTjeZRBTJYM5iIiSWPGNsN/6Ozl9mErKG7SWc8fhFkLLs+/kBKoD0T4RwV
         CSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767892010; x=1768496810;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p6Wvz759GUewXYsc4miB5/+NI5xDR6MKrs+hh+WMf9o=;
        b=sN4vuZCkrxSq/4OybtkdE6Y5jspgFVNBjcOrDFDVZmExJC+WqB5245rHdeNgRS1ye5
         g3iZ6YFWVMZuVrwGnchKqiigr6on/UCyCo9/kX3ERtkeKsjege3c6fNU45+/a9/ycHy7
         dvFR5fFWL/NsOaj+jZlAmApkpnJdgepkQaGzIBLdNVADrmGt67OjRLciG+Y7wd0LXcfd
         o+pJ0GeUkp2DEaNHeZcWpDkReGiqM2CewUZhOr6AMHR0UcWPq09g0yV2Ktx+RPrsKhpX
         Dt/SOkZdyG70YUkSW6mdm2NWPO6iWVOlHEf0MeYQiu4k4sInkxmu4hbwon43CxtGpdN1
         ixqg==
X-Forwarded-Encrypted: i=1; AJvYcCUtsnAVHp2vEKwU1XOUauw82jfKLvXFudGmYvkZ6mzYM6kJ0kGH3iaD3pWmL4JgA2Ir/DM6qpwfu/k0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4I5Vg5MbJDMnQrmMfRzLH51L83kH9Vte5kvHW8Kt6n+Ez/VU1
	l9nVCBPr/6VR0l/LuhDM24LCdC0wGQhOqT8AioeyiftYn65nlpo7Y4C4
X-Gm-Gg: AY/fxX7uVfxgNztc3dhWHl72TidyoqkTsHFNh168BPp0TSLsp6fArefshBBTTWKBXgy
	Si/YlVsiT8vWmpHPfwB9rdtfiQCnzsyivLAudhoona86t8Tj3vnbyUlv2MQBJOHA9O4R3brgvAD
	IZ2CNVatBdfw2G4fKnvaM6tYHiTGTrX4d2mZg4+LmPeLZV77nzvF6T60VcN44PRJeBf8LNlg2j4
	IinRrAck+RVNkvgIkZ7Tss9iigVYezYNuEMIADZRyom7JRn/Z0HjyBG8P+kuHdOU/N23GnpqEAi
	hXzRKZ4YxlhUxyi17G3RENwbUWwH5qg321bfM/CLpxPoGYkKQ+HcyCLzx3UUjhODka60YR5FKyP
	RBFcHeTzIG7XiVXIEPzKzbJbqLY4075b07mZD5gcoZqFU8JvzhtJhu920eIZ/wGGgDCc8kAeL8h
	DGl8p7mptb+nDJMHKHnMZ6IorPWb1arPdDZm0=
X-Google-Smtp-Source: AGHT+IG8IzgVV5p7db5tFvYhYnkmV4jr6FxdY8lS8LrHwrO87kVabF1WZz63vCE2N4XM2BF2d2+c7w==
X-Received: by 2002:a05:690c:6188:b0:78e:1aa5:e98a with SMTP id 00721157ae682-790b57ff8ebmr143870847b3.37.1767892010150;
        Thu, 08 Jan 2026 09:06:50 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4c::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790aa6dbb2esm31227117b3.50.2026.01.08.09.06.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Jan 2026 09:06:49 -0800 (PST)
Date: Thu, 8 Jan 2026 09:06:48 -0800
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
Message-ID: <aV/kKIMMr7FFOFnS@devvm11784.nha0.facebook.com>
References: <20260107-scratch-bobbyeshleman-devmem-tcp-token-upstream-v8-0-92c968631496@meta.com>
 <20260107193013.0984ab97@kernel.org>
 <aV80jCHD9PGaOr87@devvm11784.nha0.facebook.com>
 <20260108064200.7faf9735@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260108064200.7faf9735@kernel.org>

On Thu, Jan 08, 2026 at 06:42:00AM -0800, Jakub Kicinski wrote:
> On Wed, 7 Jan 2026 20:37:32 -0800 Bobby Eshleman wrote:
> > On Wed, Jan 07, 2026 at 07:30:13PM -0800, Jakub Kicinski wrote:
> > > On Wed, 07 Jan 2026 16:57:34 -0800 Bobby Eshleman wrote:  
> > > > This series improves the CPU cost of RX token management by adding an
> > > > attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> > > > binding to avoid the xarray allocator and instead use a per-binding niov
> > > > array and a uref field in niov.  
> > > 
> > > net/ipv4/tcp.c:2600:41: error: implicit declaration of function ‘net_devmem_dmabuf_binding_get’; did you mean ‘net_devmem_dmabuf_binding_put’? [-Wimplicit-function-declaration]
> > >  2600 |                                         net_devmem_dmabuf_binding_get(binding);
> > >       |                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > >       |                                         net_devmem_dmabuf_binding_put
> > 
> > I see that net_devmem_dmabuf_binding_get() is lacking a
> > stub for CONFIG_NET_DEVMEM=n ...
> > 
> > Just curious how pw works... is this a randconfig catch? I ask because
> > all of the build targets pass for this series (build_allmodconfig_warn,
> > build_clang, etc.. locally and on patchwork.kernel.org), and if there is
> > a config that pw uses that I'm missing in my local checks I'd like to
> > add it.
> 
> kunit hit it on our end

Got it, thank you

