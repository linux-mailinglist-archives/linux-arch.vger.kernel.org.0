Return-Path: <linux-arch+bounces-2684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE1285FD8F
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 17:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 963E7288626
	for <lists+linux-arch@lfdr.de>; Thu, 22 Feb 2024 16:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0117B151CDB;
	Thu, 22 Feb 2024 16:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbcaEV4x"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F7B1509B0;
	Thu, 22 Feb 2024 16:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708617892; cv=none; b=LYZSGX3Fy0xz85wrU0JjhvahYVtVifg2aGjyUKWAHmNPSpS4/ODMiFq7sQHoG1qVTGpxHDFeEOoyEazSxieSUBQ6apCRCUVKqCKrPPpH900JMJD5xh50k8o/yol5d9yXHLl8NIUisUDQW0OQCMjatOnsXMMYj0xLioRPq6Dt5/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708617892; c=relaxed/simple;
	bh=kfgfojZFPU3tCAlgUAWcIxM6unFQOtSqLwwPyZzShLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQ32iSNSIemlPcSQVCzpB6B9rM0lBTk+/d4og/6mW/drr561kSKr4e0XsfEsmIgXu8w3DZA9A+ZhmRU6yEtwuqM+i/j6upS974KPpK0z9jcXjXridgXEIImRNe145865O+ZAeFB7Pgcv+WVNgMz5BuzvpB97+wx6niBnUw5MWU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbcaEV4x; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e4ca46ab04so663774b3a.3;
        Thu, 22 Feb 2024 08:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708617891; x=1709222691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bdfDrM8AydyfRmAcnIS01uw6lIUccnV5rn6fUcYpTJU=;
        b=GbcaEV4xmfu/03RXyxf+ZrWyQ5JE51+ZxqKQP389NxbxgrQ6txFAd3GftvsutOzqyo
         FCE4qoQRYrwZ2MwOInFrCP48qSCVRFqvr4fs41+7ea3gLVb8L/uM7KKllrHQYlx6Mkjw
         V9HC+HqDymNdlbXCN1oAuWkHKFlrfsZX1PebZpw20FaiGLE31EYw0YxefnUSpe5yXimp
         /Om3CN3KXmx+gC17djpsVjOhkcJOT1DdU6hqtf2vwALTGHpS6HPqnY3TLm328Tk5I0hC
         x4zhaPorKExu/u62LjCvIRB0SyO+I+rA/n7FD8KogkSzXR415mO001ug1R2C63GlkeEu
         ZddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708617891; x=1709222691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdfDrM8AydyfRmAcnIS01uw6lIUccnV5rn6fUcYpTJU=;
        b=lS9Xo7ywHBxzStu0l2EFWsHQZAK1wE0zr76si/Hm7pRvlrkBIQQ2VbzeObDGGPrg8e
         XQsl0DVODOdB35QrAdh0QLX1Rjb3W9cyUsbsNbDOHY76lGjkeIeX04GBXBgbgPS0Yb5m
         +IhNwMgvHbjLDoKeta/Vjaf+lHrcYHX5DTYSoTetFLz4CAPnLicCImTHk2qCVpngmlK5
         20IHgtEv4J9LYN3JjJR6slkRQ571n8ImU1U9MGL1QNVhDcyIqOo/5sTYfpGlr3RFmQc2
         MmHt8wBK/qe25DUP1I/NR41rZz5JSoiwsR+qehHIt0nEFO1NVFYhqjm6AHRgXQHxynfG
         ZJFg==
X-Forwarded-Encrypted: i=1; AJvYcCV20vTlS7Sxxa6JyEYZ6NmqZSYSYNZR/BX0d9ArcA5EKUSxalmZ2Uyq8mZwmHgJEWhuZLZu7Sz0J88YTN3y2YKiwDs0MmKpfF6mB2alxYml+WEXNcUohHnSkmaYeufXwelYJgjeCKRckeys+Jee1V1MEnu5VyXAV/3G7x6wmPY/tegT2uTeqg==
X-Gm-Message-State: AOJu0YxW0ZXvQSalza9HNMfHJOduRpcpHd5D73/iUf1e+oelzotwxszK
	OwqfYMGxdF25P6Xch9sGLTxfaoP3TJIw/YKzH6eXYR5dGndTTqca
X-Google-Smtp-Source: AGHT+IHXoxbfwD/zd856SEmQSTnNcwBkCbrImdPiWYJZX8CPzNpKX7kYzmcNnZx8CrImuZnC+mvQWg==
X-Received: by 2002:a05:6a20:d80e:b0:19c:a16c:8ab4 with SMTP id iv14-20020a056a20d80e00b0019ca16c8ab4mr31308400pzb.47.1708617890722;
        Thu, 22 Feb 2024 08:04:50 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t9-20020a62d149000000b006e46712fc80sm8064056pfl.137.2024.02.22.08.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 08:04:50 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Feb 2024 08:04:49 -0800
From: Guenter Roeck <linux@roeck-us.net>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	Helge Deller <deller@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/4] parisc: checksum: Optimize from32to16
Message-ID: <e00be589-4e9e-48ec-8a25-ad7460f304fa@roeck-us.net>
References: <20240221-parisc_use_generic_checksum-v1-0-ad34d895fd1b@rivosinc.com>
 <20240221-parisc_use_generic_checksum-v1-4-ad34d895fd1b@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240221-parisc_use_generic_checksum-v1-4-ad34d895fd1b@rivosinc.com>

On Wed, Feb 21, 2024 at 06:37:14PM -0800, Charlie Jenkins wrote:
> Replace the shifting and masking of x with a rotation. This generates
> better assembly.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/parisc/lib/checksum.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/parisc/lib/checksum.c b/arch/parisc/lib/checksum.c
> index eaa660491e24..1ae8cc730d13 100644
> --- a/arch/parisc/lib/checksum.c
> +++ b/arch/parisc/lib/checksum.c
> @@ -27,11 +27,8 @@
>  
>  static inline unsigned short from32to16(unsigned int x)
>  {
> -	/* 32 bits --> 16 bits + carry */
> -	x = (x & 0xffff) + (x >> 16);
> -	/* 16 bits + carry --> 16 bits including carry */
> -	x = (x & 0xffff) + (x >> 16);
> -	return (unsigned short)x;
> +	x += ror32(x, 16);
> +	return (unsigned short)(x >> 16);
>  }
>  
>  unsigned int do_csum(const unsigned char *buff, int len)
> 
> -- 
> 2.34.1
> 

