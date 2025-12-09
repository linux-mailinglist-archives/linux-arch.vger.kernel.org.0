Return-Path: <linux-arch+bounces-15316-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D05CB0F7E
	for <lists+linux-arch@lfdr.de>; Tue, 09 Dec 2025 20:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C369730D171D
	for <lists+linux-arch@lfdr.de>; Tue,  9 Dec 2025 19:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95AF3081AE;
	Tue,  9 Dec 2025 19:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYS/YKwB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7B307AE3
	for <linux-arch@vger.kernel.org>; Tue,  9 Dec 2025 19:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765309956; cv=none; b=aKbTElF1oBEp/QwMS9Pnxc0+CRr5RirRsRX6/mj+Tq63TcLvnEjXSP6pVaFrWgv4CsM3adlO5eMeOeJfYyDqwop2KWCgWr/eJUIYMqcIT3/CIxPy++2s4+biRDanHeUg+2NsmUGa/zUQb3OhirKugzdPpuv/QXf+BisnL4ADa2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765309956; c=relaxed/simple;
	bh=XHL/L/FSKYOnQq3SetiqQKZ3ve52BsUb+UjL14KbL8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3mqlUjLooXQ9FONMJIhZhdUFHVcOnAbPg5GQmDS3/SW5ResAHh2j31Zbjt7Ty2qSG0FXBCVtOHDV6IKr0oQ6MBf5MdvRd496WTipxFbxg2qzZLXNWq377oiok3NUewX8Z+k+R/9Tt4NwN41ZZJg86opZlo3wnRkcnr5zzruBO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYS/YKwB; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-6433f99eb15so5424133d50.3
        for <linux-arch@vger.kernel.org>; Tue, 09 Dec 2025 11:52:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765309953; x=1765914753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+S3XRmIfY6Nu+N2ZLCSjBdZjpwngwmUECGmLCvjDHC4=;
        b=JYS/YKwBT9uINGJs0YtoEei+BcWgPlR28O3aqTc7ELWu4ak8jt96qj9N1A6rFEx97y
         UoKYSu15kAi67xNZxzfPs0wRq0bWRh92qZx9kk+Jgy9tw31yGR3fmzJqAjwg4A4MOX7P
         9bL7jbxmonzsi+LHrD7vqtHI1W98N7C8byFw44IVvhL3FBZdJoGQW/pzSoMHW+eGOB9f
         X+g9AEgJDlsgG1Nz1WhPlCaPKHJTvHM68ooA71V4Gw6wC/FqskNUvUrASYlSq6ek7QQQ
         zROMwFssQ7rk32CJwEQmETzhC6q1KpDga/wfeAkXudp4GV0SMqOZ2uQZvhD9Fb7CDd7N
         sydA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765309953; x=1765914753;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+S3XRmIfY6Nu+N2ZLCSjBdZjpwngwmUECGmLCvjDHC4=;
        b=TPeZ/BEKPT5A1xGrnM4Xw1a3Qo/lJMqiIBY9FwWs4OLq4Hs4mlX2b4EXN2Xq25xl61
         5FJ9Q8Ju8YnIEyFkrCBrgx9YXaE3kcTkQw4dBSP3p7kuyJerwa1V1JqO9sBHeaZ2k+fV
         M0u2uuDzKFBwwr4vGhp16jC54fj8hKttZBqyoJTDifBQgq2OwejwjLSe9YoKcuiILcMt
         vumU4IlxM+ssiclXUPhgEwuC9f3qG/RZwcJoZjBEPPpq+Bm3gCUoa9LeJy/8gGkb0nrR
         ATN7sXQ7xZCgi8G0UYT6GS3cgCAJKFUk9TDG08Yfnt9DiLZvNbviQmsYcElr7y8/ysPL
         UK7A==
X-Forwarded-Encrypted: i=1; AJvYcCUjDhl+LeiPeKjAm4rbF5AbH1CZX4rw8sbrQOIsPOcgjzRBV85Bdinb7GumHBcXwePwaYHirtLLxlCr@vger.kernel.org
X-Gm-Message-State: AOJu0Yzv1q0jKeZaV2z98k/acoZFnGlLuevQFMAAIpNLyVqk4aKLvTYV
	dVcdf97iIbwAKs6dhZnNQrjcsdMdISNTFWh1kvyoRwEB0CBE4MxihYlf
X-Gm-Gg: AY/fxX6eyuyaP3wpS6sZZGEojuoHReCA/+zB5qHHhFBRvRJpiwao5uZ0lJIR9FAXMtW
	8rriQjBSLBErT5o5kqhj/8u+BKpYQSUFKCRpZFJkg0WDmXORP3yebxhDKWGL2DnXo9puKCdOFle
	CWbmqhCpUvOCsX9OoK0B+9A7n2Dife1n2kLMZHzghrvRXVKpk/XdzUuwTyiMvu+Krki0kzFjYQA
	oqCLD/ESUajraomsJT8F1rhYwEiAKWmiW2wFDUtwXgTfFl1eFeGEcaYyc8Y6/yF54a6RFHAZ15g
	j8x1MYlhc+KECDbJFRgswTg2BcpObfh3x3+f56CZSWa/628oumncBsiHS3V4ZRC1UI1YldMfiQ7
	bIPd7lHiL7Vijl22FrTCl3GPZ3bJtn5xYG/6neMh54OLI1pyVRJe4wh1VeT0i9UoYMHRvBt9ZK2
	cLClVogQ8ESFNmntQf3droeXy3Krg/fOJzzHwJ3GA1Yd1NktI=
X-Google-Smtp-Source: AGHT+IGVa6r0iFDuAtcL6wIkP8nbDpeCfCQK9vF2pnYiCLEjTySXlHVWrlq2gK/PVPin4gJW60wg5g==
X-Received: by 2002:a05:690e:2543:b0:640:d255:2d6f with SMTP id 956f58d0204a3-6446e93f952mr78609d50.34.1765309953244;
        Tue, 09 Dec 2025 11:52:33 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:54::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-78c1b4ae638sm63277367b3.4.2025.12.09.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Dec 2025 11:52:32 -0800 (PST)
Date: Tue, 9 Dec 2025 11:52:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
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
	Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Stanislav Fomichev <sdf@fomichev.me>,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v7 0/5] net: devmem: improve cpu cost of RX
 token management
Message-ID: <aTh9/waV23uRZc9E@devvm11784.nha0.facebook.com>
References: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119-scratch-bobbyeshleman-devmem-tcp-token-upstream-v7-0-1abc8467354c@meta.com>

On Wed, Nov 19, 2025 at 07:37:07PM -0800, Bobby Eshleman wrote:
> This series improves the CPU cost of RX token management by adding an
> attribute to NETDEV_CMD_BIND_RX that configures sockets using the
> binding to avoid the xarray allocator and instead use a per-binding niov
> array and a uref field in niov.
> 
> Improvement is ~13% cpu util per RX user thread.
>     
> Using kperf, the following results were observed:
> 
> Before:
> 	Average RX worker idle %: 13.13, flows 4, test runs 11
> After:
> 	Average RX worker idle %: 26.32, flows 4, test runs 11
> 
> Two other approaches were tested, but with no improvement. Namely, 1)
> using a hashmap for tokens and 2) keeping an xarray of atomic counters
> but using RCU so that the hotpath could be mostly lockless. Neither of
> these approaches proved better than the simple array in terms of CPU.
> 
> The attribute NETDEV_A_DMABUF_AUTORELEASE is added to toggle the
> optimization. It is an optional attribute and defaults to 0 (i.e.,
> optimization on).
> 

[...]
> 
> Changes in v7:
> - use netlink instead of sockopt (Stan)
> - restrict system to only one mode, dmabuf bindings can not co-exist
>   with different modes (Stan)
> - use static branching to enforce single system-wide mode (Stan)
> - Link to v6: https://lore.kernel.org/r/20251104-scratch-bobbyeshleman-devmem-tcp-token-upstream-v6-0-ea98cf4d40b3@meta.com
> 

Mina, I was wondering if you had any feedback on this approach?

Best,
Bobby

