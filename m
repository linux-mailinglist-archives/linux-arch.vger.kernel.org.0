Return-Path: <linux-arch+bounces-13695-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD34AB8AD8A
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 20:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31CE1CC2BA9
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 18:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C460122A4CC;
	Fri, 19 Sep 2025 18:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="Kl+MjNrG"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178A81D8DE1;
	Fri, 19 Sep 2025 18:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758304985; cv=none; b=UkBbckB3J5yrDUFWTn/wSnSbSFH2T1qN6XnGvXVT9ND0fnY5DUeIHEDZgavwhXY4YJLuHu3raRLccKeOi5On6uCO12JCau0aBuvbHYY9QJMCDG5TLAMj/eXwDHnqsPD6xRXUtO13D4LdfVBFk4mbh9rOSWEZw14Y0rQw4wHvRvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758304985; c=relaxed/simple;
	bh=+M3YXAc8iuQGInikX2SVYKYzf4K3oVYABMLZHre691U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n6g0ke7LrWvbXAuxgRVsDLCfDEsydODcBlfye/nk8dxa1WmIMFPEGychzp9sGUHCaeoE9NU/yiPP5BpJzg+C+DseJ7y1X9Ygh6qLBqA+Z4omtjxr66cWMqfH/poFeWUV4REEV3aOzEIaUSjkBYxY3/U+cq3PxRclr3Pw4XxvAno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=Kl+MjNrG reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cT0jH68drz1DDBW;
	Fri, 19 Sep 2025 20:02:59 +0200 (CEST)
Received: from [10.10.15.9] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cT0jH3tNtz1DDgW;
	Fri, 19 Sep 2025 20:02:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758304979;
	bh=kouYXPYOu6GD0uVTtzJid86OlE54IuD7gbrWg7tbESI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Kl+MjNrGuD+K8TXaU2aFDiuczNMoCmDU3pjdjpNGTRz5R4/OZHqkoz40GWlJ0weWZ
	 lVQZCFOmqQ7jP5vVgR1KVl9DxL5S3P62v+QcCujrkGXTgqa46vSoDUmsmswfUxhKft
	 4cjS6mx3DMfeXRIVJ3N4z5nrOKbO9tSm1fK0FXSAB1NQ17cPPh2KyYrxjG3wV1dSlK
	 6ILUybAh6QyM7tJr7erD09t7786J0q8Q7MjgWpComUw2nVURAxBDomgy0Zv3uHeqCN
	 NYeUx+pixxsAxqcfQbu1eHSs65rtyPGa5rXBP3eNnEiONa7t2qEA7l+wIYUFyGV+7H
	 ZlTWpNkWWSyrA==
Message-ID: <fbb1a96c-d913-4bdf-b40c-c8981601bbf9@gaisler.com>
Date: Fri, 19 Sep 2025 20:02:58 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fix prototypes of reads[bwl]() on sparc64
To: Al Viro <viro@zeniv.linux.org.uk>, sparclinux@vger.kernel.org
Cc: linux-arch@vger.kernel.org
References: <20250810034208.GJ222315@ZenIV>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250810034208.GJ222315@ZenIV>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-08-10 05:42, Al Viro wrote:
> Conventions for readsl() are the same as for readl() - any __iomem
> pointer is acceptable, both const and volatile ones being OK.  Same
> for readsb() and readsw().
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
> diff --git a/arch/sparc/include/asm/io_64.h b/arch/sparc/include/asm/io_64.h
> index c9528e4719cd..d8ed296624af 100644
> --- a/arch/sparc/include/asm/io_64.h
> +++ b/arch/sparc/include/asm/io_64.h
> @@ -250,19 +250,19 @@ void insl(unsigned long, void *, unsigned long);
>  #define insw insw
>  #define insl insl
>  
> -static inline void readsb(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsb(const volatile void __iomem *port, void *buf, unsigned long count)
>  {
>  	insb((unsigned long __force)port, buf, count);
>  }
>  #define readsb readsb
>  
> -static inline void readsw(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsw(const volatile void __iomem *port, void *buf, unsigned long count)
>  {
>  	insw((unsigned long __force)port, buf, count);
>  }
>  #define readsw readsw
>  
> -static inline void readsl(void __iomem *port, void *buf, unsigned long count)
> +static inline void readsl(const volatile void __iomem *port, void *buf, unsigned long count)
>  {
>  	insl((unsigned long __force)port, buf, count);
>  }

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


