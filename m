Return-Path: <linux-arch+bounces-13793-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B5CEBA4571
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 17:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE373AD04E
	for <lists+linux-arch@lfdr.de>; Fri, 26 Sep 2025 15:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623DA1E7C2E;
	Fri, 26 Sep 2025 15:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="llzN2Und"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E416C1C860C;
	Fri, 26 Sep 2025 15:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758899098; cv=none; b=uC6YaJ99oCem+YYdyPpflIZpOAEdOSPiCjCsX+lkEn+fMkDPaVAZBxCSGS9QFEoatD5oNTD+8S5HxSL3BHkTqyX0r94UxVmqUoFImS3qIObhr1Yl++D7G7FU9fNlnUm67GjbIEeUlNk5unQtLJf31CW0RQESQLs+QFLHiV+ihO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758899098; c=relaxed/simple;
	bh=adgKoD25UwO3BVkcZN++mU84uAZhuLglJ3gQ5oR6eSg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gNkuOGksQ1OMel+PUiGiV5EU4nvLb/lUXLyk8UzIeSBvbKDbXCixMskf1g517SG1BzfLGLJ0NsA1NZ+dSBLYxZG6Vlv6g3POMDCfC+5HGzqA/nH5rxlXqg/gm8QaIalmMrOP0ajE05wwh4i5SfyxmstYLD4E/UkK9YFzuCqffSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=fail (0-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=llzN2Und reason="key not found in DNS"; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4cYDQZ2G7Qz1Fb3j;
	Fri, 26 Sep 2025 17:04:54 +0200 (CEST)
Received: from [10.10.15.8] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4cYDQY70v1z1DDrf;
	Fri, 26 Sep 2025 17:04:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=simplycom2; t=1758899094;
	bh=rU8ov8sFMyZxgHehD/buYSK3M1bh3F/bSB3drDYYTLo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=llzN2Und7yBsNxPq/rD4KAxyxwGtKIEwg1m2bUu6lysQHPw+i92EeEQ1+BLoE8wVG
	 6Cx4g74eCt6vVx21NhNrK0vnMyIRNNox6drJGpbgEeS5w30nNHUnnCr4pFl3rwgjVs
	 mqGa0jEU1JPNvcjH61NHzCmB/p0EEX6To4gqNl9IKgaQrhmJRaj+z24g811ex5Btj8
	 Sya92TVfSkXcHBaXGXthQ3K8R0pyYKncZvi0xAdYTYY4JKmzzDGegA/S29/3jfYj3d
	 PqTy4houz4rbAmOT4lyjpp3Y3WVXUZnS8OrkbGEjkjRmF3ZD9BBFea/dVKU1yS11ME
	 UbyZwT4aCEZQw==
Message-ID: <c98a2d4d-fe8d-4bff-a682-167fa7326d9e@gaisler.com>
Date: Fri, 26 Sep 2025 17:04:53 +0200
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 34/41] sparc: Replace __ASSEMBLY__ with __ASSEMBLER__ in
 non-uapi headers
To: Thomas Huth <thuth@redhat.com>, linux-kernel@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-35-thuth@redhat.com>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250314071013.1575167-35-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025-03-14 08:10, Thomas Huth wrote:
> While the GCC and Clang compilers already define __ASSEMBLER__
> automatically when compiling assembly code, __ASSEMBLY__ is a
> macro that only gets defined by the Makefiles in the kernel.
> This can be very confusing when switching between userspace
> and kernelspace coding, or when dealing with uapi headers that
> rather should use __ASSEMBLER__ instead. So let's standardize on
> the __ASSEMBLER__ macro that is provided by the compilers now.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andreas Larsson <andreas@gaisler.com>
> Cc: sparclinux@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Andreas Larsson <andreas@gaisler.com>

Picking this up to my for-next.

Thanks,
Andreas


