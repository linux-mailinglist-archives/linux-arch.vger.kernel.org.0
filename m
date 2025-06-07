Return-Path: <linux-arch+bounces-12258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1087EAD0B4B
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 07:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461A53B0BF6
	for <lists+linux-arch@lfdr.de>; Sat,  7 Jun 2025 05:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 957FF2580EC;
	Sat,  7 Jun 2025 05:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YrgiEkfP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AF3EC4;
	Sat,  7 Jun 2025 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749275551; cv=none; b=eN0Ux5pwwv1rkndOo2ot0JP7LQR8xwBmpHYuKth7glIsXf/lOwNub0Ve121C0pgOKTs65cDQSBxXcgfjbAbV4ivzs6T0ZLdNfrDnbMM3jG6HC8F8ZA11nVDHZF/7+NSZdAGhnDWdx2AYrx+Qw/eCQMz2flmpwfV2S406k2Xk0vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749275551; c=relaxed/simple;
	bh=BffRPMZS0paUH38IS1RnszD9kUJrM2Awzb4ZIxPKgJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRdi5FqaKB5miMeM+v1Y4wh9My020ro/3PbhYUmnVUdM9D5nGw8ZjTlI+LiyrMl/Ov6tn6w2ryB9uxJQvo8Who/yTsj4O/wuwiPoZWYgV+eNm2G0tRrewe4Us0xN5Fee4w58P3XC8kgsqqTBubp/dRQnYKz6vgPeLaO3RRe6KjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YrgiEkfP; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so22438355e9.1;
        Fri, 06 Jun 2025 22:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749275548; x=1749880348; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=RQYvJdp5wMu8CmB5J4isx6Lt367NUPdd0MkYltQHtPM=;
        b=YrgiEkfPJGwdB1lnivV7RYrHlmySoUEpDX7Srp5nOcNHJ5GG10ACwLE3kUaAm0Bn5K
         9l+gKrC6h3cQrOCT0mfjpmqSniNEfteMIU5WBnt/GuvfqW320GgLiUYZRCOEjJbyivg3
         veUtYEBJNcoZu3sXrP9MFyh67kFR/J66L6JaJkBYex/4mjb9llJ+oEz081OP2CgvBFDO
         purcLEH8KYnscEIN+E6DVn7dJSP4Q4KC7Lc20mpvO9k7j0wvgQpxHKt8QfPyeuwpjOTB
         45eXd+k5goAym6REGO1b1XCLXrjwCv49bogB4n98Yzuhy/CvKNd8nEPl/mFpXw+fM6or
         9XMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749275548; x=1749880348;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RQYvJdp5wMu8CmB5J4isx6Lt367NUPdd0MkYltQHtPM=;
        b=DEVhiB1d1IWzuZTSTgaaL9cppSv+DJcNM/5lmJA7wRPkCefvONJvnHPfG8rVAocG3w
         cJBvclUKHw2dA+H8JJyNnwgIX1WXu3AuGilHO+LeMA8/Ojn0kc8jIojwhXwmTPPlqpLs
         p/gb9KdnRXDCqLFfMhCd6kn7tHzTTW1PBLwEvQ3QZe1QZkTM0SUhe1ZgdnaizKQLCbRD
         OL66LxzrQaxOtEhKPElHE9n9PGzs6lUc5GerpnJWyAdF3G6Uw8PCjGS/dKIb0CYfPFMI
         H5dk0UZ9CQXc5pJQWcUAys+QREfFMkZzml2/p91X3D29rCVHPl9mHK2lg4Bq0ATSNGLo
         x7/g==
X-Forwarded-Encrypted: i=1; AJvYcCU1JZQUEQmpS1BWmLf8kH9zx/DDZCu8c6SYvNOG/cQuCSVtGCX1sd+p9D69bfka3dy62bIizF+6O3+8@vger.kernel.org, AJvYcCUfVPYyCZjLPcsTdIlsV7t17Dv077hBlxIQ+bSLYzS2rF9BFMCWLaBb0JPVsho0ALixr6kvhzeb4gF8yNb2pAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yydm+jbWpyxYyQBGsxwoxPRo8DKP/qgxol1ISuqXsq+kRbj4OoY
	1r9dSH+PzePzaCUvRy3hRAwBf+GL/sKvkz8M3p4ctqu6Ojt7y9z5dsSv
X-Gm-Gg: ASbGnctd4c2PsETyF70LicgG3OfjUBXMHQSV8BLj4vgc0rP1CMA+0v1Yurm9OJrZ/rq
	CJOBHh1ssjL9D/dwO4b/qCR8f1qVvQFo/ROkrg6uOxkdzSIvSdTYgA2R0KvH6mGySQwIz741GUA
	gOGoGJJ/WrqgvNU0CRqzPyDWeJ77QeVZ3s/Au9a8nE2gLDupmRZTMu72lm3Brfaxs7dO5Jvzv1/
	C8kSOLi6UrgXHjJBMMjYDklNgY4vTqTT29pvzkiG1vmLFyoTzA4jis9/DkcIogRtuKhw8fDu49z
	kFQ6U6LPgTszs83CS80wxomRbpL64khm2sBPgcc04zZMhXPpDTlEpNhCmu3Fh2TwePfs6VgoIYG
	otBx8Ztk2uMo+FIyV+XAMGOjrtg==
X-Google-Smtp-Source: AGHT+IE8TyIJYiSlKIxjtQWt3VI2y2JysdK8gWE006ylw4OtOZzyOqEU8PbjdtlsBzu5U/vb/wWXyg==
X-Received: by 2002:a05:600c:1e1c:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-452fbbf6c36mr33907375e9.23.1749275547529;
        Fri, 06 Jun 2025 22:52:27 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a5323ad0c4sm3767041f8f.30.2025.06.06.22.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Jun 2025 22:52:25 -0700 (PDT)
Date: Sat, 7 Jun 2025 06:52:24 +0100
From: Stafford Horne <shorne@gmail.com>
To: Thomas Huth <thuth@redhat.com>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	linux-arch@vger.kernel.org, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	linux-openrisc@vger.kernel.org
Subject: Re: [PATCH 22/41] openrisc: Replace __ASSEMBLY__ with __ASSEMBLER__
 in uapi headers
Message-ID: <aEPTmFCT18dxnONh@antec>
References: <20250314071013.1575167-1-thuth@redhat.com>
 <20250314071013.1575167-23-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314071013.1575167-23-thuth@redhat.com>

On Fri, Mar 14, 2025 at 08:09:53AM +0100, Thomas Huth wrote:
> __ASSEMBLY__ is only defined by the Makefile of the kernel, so
> this is not really useful for uapi headers (unless the userspace
> Makefile defines it, too). Let's switch to __ASSEMBLER__ which
> gets set automatically by the compiler when compiling assembly
> code.
> 
> This is a completely mechanical patch (done with a simple "sed -i"
> statement).

Thanks Thomas,

This makes sense to me, I see the other discussions now and it look's
like there is still some discussions going on.  For now I have added
this to the OpenRISC queue, but I don't think it will get in until 6.16.

That should give a bit more time for the discussion and more time to
test for me.

-Stafford

> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: linux-openrisc@vger.kernel.org
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  arch/openrisc/include/uapi/asm/ptrace.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/openrisc/include/uapi/asm/ptrace.h b/arch/openrisc/include/uapi/asm/ptrace.h
> index a77cc9915ca8f..1f12a60d5a06c 100644
> --- a/arch/openrisc/include/uapi/asm/ptrace.h
> +++ b/arch/openrisc/include/uapi/asm/ptrace.h
> @@ -20,7 +20,7 @@
>  #ifndef _UAPI__ASM_OPENRISC_PTRACE_H
>  #define _UAPI__ASM_OPENRISC_PTRACE_H
>  
> -#ifndef __ASSEMBLY__
> +#ifndef __ASSEMBLER__
>  /*
>   * This is the layout of the regset returned by the GETREGSET ptrace call
>   */
> -- 
> 2.48.1
> 

