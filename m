Return-Path: <linux-arch+bounces-2683-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F3B85FD8C
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 17:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAC06287B19
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 16:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C6C150990;
	Thu, 22 Feb 2024 16:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJWb9XpA"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F03FC1E;
	Thu, 22 Feb 2024 16:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617880; cv=none; b=q1k2YiMcfOMjq3gyYIfuB83KuPHsdIl/U3eIXtYmoWYaLWMBO2gfzwVvTAc8u6gJKZdeHsOW0Hv0UuWczQ5/8ACU5eokQTjDTmQ0BilyPbPQyZbHOjp2a/ypGPsdgjWtdWG/8UrasdAvRNLbKlBPa3sPdpXIm516TtrKUbqM/H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617880; c=relaxed/simple;
	bh=ZVx1qmxkur7UaIIHYcAUnzkg5jJchz8D5RcHyd4B9L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Adp6OyZKqCvC729WcTdiP7TB+E++AkwxkWaO2IKhLebQuXsC9mI01KnukVifiRqdCFzpR3FJQeJh6KkFRKNlRr4DcU4NWxwYkPjbYLn4vPKnwFH4JUvSlztdHZk+95d96XLdHQWisqrRRvMsW179CeI2FeG1z9X6w79UE8uSgcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJWb9XpA; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-5d8ddbac4fbso6642121a12.0;
        Thu, 22 Feb 2024 08:04:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617877; x=1709222677; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RvwPOwO7kqE6CHssC6QwZQmh+BGrju3fLpuyeIMI9Q8=;
        b=HJWb9XpAjXFtA+liypbns/CJ7yFvRyahU/+BqTiGEO+AgiX7lntH+JCAQ9fkiozo1Z
         lqYy4Tttd8rEjTU4apaFehM1uDSL8ZRfp9ELaeyjfyVjeHJIGlOhqz/xWsugl7bGBtZS
         wl4yuDdlgJK+yIlxXcMcgtAU/kil1ahYoCEa9HviNPX/Aa6fY1rptgUETwz0eEkIKcy+
         f79zUirM79abJ2L/puUUBXT9BWVc0dI9u/fTG3b5dp2NkclMC0vINVcsPjDAvgqPDTNY
         xHj+Pyag8nsPzxaecNny3JSnDtntdorN8IaCzptOUArhlkY5Zm0nRgilcM1d4Qzne8Ue
         OYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617877; x=1709222677;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RvwPOwO7kqE6CHssC6QwZQmh+BGrju3fLpuyeIMI9Q8=;
        b=iutnhyqb+SiOmwlrKEalR19C3W6GK2/AQ5jQErrHh6rA0Z8OmaSDGRbkXlLqHYg6Vt
         wbeKI0r/pcOYrKCLB2aAUSRh/n3oe7h6XS48NtpE+qBpJnY3auZcrZZ9YEmiBl9COAX6
         T2/TXhLm0Z4MzYH6lMb0c6Mf2vOLDnu/lUkUyWirEzHGS/wVMH9ImhXIIuo4i86Yv/bw
         ABFmrxiNmn2gI9Xh3LdifDUNMNNgqmwBMArdeexIvQenzuHGceVQKIjJqEwwJ2/SlW11
         IIeb2InMj5I9nhoDHIP3+PeC7OBXdC7WwEt7qa6dlpoXJLJ/AjR9SYR/nBxQWWOZVmOP
         oaMg==
X-Forwarded-Encrypted: i=1; AJvYcCXXjIXYxggYX8Rx6dSFYOaEYlN6JgKd5Vw3iqznH6Md9qtrGjOW6q7ALN0iSonNL0PAKwlnkLX9CCEF5V4/iZBpPdgzKBzkxW00J04BXdpuxGNBdAMteuejYTYE6M0Mhsrd9ERKJECOJgyXxKvbk0ucndsCvFQ8eMhiyumvktnYNsYv5hdA9g==
X-Gm-Message-State: AOJu0YzYJJJN5/LCbUc3FAIO+BOc4EIIaoK54g62B36skAuZvt3eRf7T
	EwBn2Xfsaac3SbQAHD8Pz9XYyeBnKcplDYMJLfXCizlEK29FE66e
X-Google-Smtp-Source: AGHT+IFVIeAzfLUetGDsE6f3CvAc2dJbXKCrq7BnvWVfAq8Fg1rQX2qFP36rITin/K5CziY/TYJFDQ==
X-Received: by 2002:a05:6a20:e68b:b0:1a0:c209:9932 with SMTP id mz11-20020a056a20e68b00b001a0c2099932mr5783254pzb.16.1708617877120;
        Thu, 22 Feb 2024 08:04:37 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id k5-20020a635605000000b005dc85821c80sm10476757pgb.12.2024.02.22.08.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:04:36 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Feb 2024 08:04:35 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 3/4] parisc: checksum: Remove folding from csum_partial
Message-ID: <f5d028f8-a961-4a1f-bba9-a495d92de103@roeck-us.net>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
 <20240221-parisc_use_generic_checksum-v1-3-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-3-ad34d895fd1b@rivosinc.com>

On Wed, Feb 21, 2024 at 06:37:13PM -0800, Charlie Jenkins wrote:
> The parisc implementation of csum_partial previously folded the result
> into 16 bits instead of returning all 32 bits and letting consumers like
> ip_compute_csum do the folding. Since ip_compute_csum no longer depends
> on this requirement, remove the folding so that the parisc
> implementation operates the same as other architectures.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/parisc/lib/checksum.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
> index 05f5ca4b2f96..eaa660491e24 100644
> --- a/arch/parisc/lib/checksum.c
> +++ b/arch/parisc/lib/checksum.c
> @@ -95,14 +95,11 @@ unsigned int do_csum(const unsigned char *buff, int len)
>  /*
>   * computes a partial checksum, e.g. for TCP/UDP fragments
>   */
> -/*
> - * why bother folding?
> - */
>  __wsum csum_partial(const void *buff, int len, __wsum sum)
>  {
>  	unsigned int result = do_csum(buff, len);
>  	addc(result, sum);
> -	return (__force __wsum)from32to16(result);
> +	return (__force __wsum)result;
>  }
>  
>  EXPORT_SYMBOL(csum_partial);
> 
> -- 
> 2.34.1
> 

