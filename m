Return-Path: <linux-arch+bounces-11800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEC0AA76A5
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 18:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9239F1896B28
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 16:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC4F25D1F4;
	Fri,  2 May 2025 16:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qqvspjkj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F03C25CC4E;
	Fri,  2 May 2025 16:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746201840; cv=none; b=PKReUZ9/JtJwgmFW2g6c+wmPAl53QeTiCm11lyhdrYqQimAjOuLohXHust137/Urj3LLnRKDpd3lxmm5NZOY9pOkfHpgKuU8TumVbhhLUEFwP8MBO8jLHguN6qIpkcwtx069EHrStfbhcufKVMZ3UQNAYmUZu8liD3c2bl1J1VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746201840; c=relaxed/simple;
	bh=/Ir9RUZPJNowHtDjB8+O6p57Zsy6wW7vA4h0CW+yCQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tbthRLVGZ6NT7xBlGSMDSLAd9QU8VbSuCDV8PA+oEz1M2S5nRx90ll/QWf+AvDfwZBgoJ1rQsn3Rp0T54phLmvVw7ORnuk7kewDHZzZDFY1tRUEbATbzf/ERrccj051MlaSh7zeAo0J0h4mQfvCnnZXDb8MRdr8NUQQM4389Iuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qqvspjkj; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b1fb650bdf7so343703a12.1;
        Fri, 02 May 2025 09:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746201838; x=1746806638; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gDaKrXtDcJswvbEwS8wGTnCooDFXgZ8JEIYZCAsVSDU=;
        b=QqvspjkjRyYHX2YqBuxryHcDEDm3dL3foUPyF5iuuzrISkgrqeGxnMUglBDbZVIrQY
         rh0v1PfjcVYIr3ngW+defvj8nKdDnHFiT08sPC48It0b/wdwLbnLHKpBqANwDzdnI2qy
         7E5ZJda+h6kg2LJgLcF3u4JL5OOBqRtv3TiTkl4tRRITYECMANFhLXCV7dOudsOE+H93
         VktwmPKvvgY6yYoapCVxTbT3pl9jLpZjAytqyj6M4G0m+lLtIBVFwNIm+wUoLHpodU3Z
         ygD/0E/qfwkL26UbFii7fbMY+YdFcYDFEg84MNpH2jeL/PE4GXgc+Jk5XW66H14yEVIh
         kmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746201838; x=1746806638;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDaKrXtDcJswvbEwS8wGTnCooDFXgZ8JEIYZCAsVSDU=;
        b=lhCy25+ULzYs+4XzisMl6Hr66Jd6XBYb/M6UOT3jeNnwaxNM7XomU4Lnj+QXAICT0K
         FawMy2ejusCmAxLeC75vFVdC2wvkpEC4x6NT8M8hnUgHxjyR5JxxgeP4yIq1wYoEhF+M
         QuUgRl7zcNgOhr8O5a2c+4z/MOywC3DPdf2/LNPHLGpVXZULqaAr4WL0qEsZ2FSj15Rx
         oIJ2wRMjTUVTLkKPdPQXMYhfWcp8237RHqvXHfgePMA0Ub3WOVD4G61zcUitEVR1+Fu5
         +b39ivIbXsivbTS0BPZd04MtwHoARdPdeKfI7xcX8Ue61bPMZLadOqxnN2oRwklkxL/S
         z2xg==
X-Forwarded-Encrypted: i=1; AJvYcCUgLx+dlSMqpMG70qIidKHYxx/qeZbWUkamE5kmhWzkysd63Mx+pscV2mGRL4p3dQuv1oVana3AiCKg@vger.kernel.org, AJvYcCVv7gAOjY1qGu78v/1WnOcPFeLF/fk5VWxrWGjdGgZJ1vjgq3fqG5VIUOwfl8Pw+iyG7SoKhjWX2ZaOc7+f@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0f3AeBCtE0x2/fWnLwiNUFUhQynWhFJDUMktVGgYKAJuwcyz4
	uMQCVZDSU2Zr31O5fMGyW2Qx/JfM0rFUG9J4UvbZz8NxjcL1KM3+
X-Gm-Gg: ASbGncuwsFc8eGHRLOnnReBaRrzNDxwazx37IeRknILDPzwdd98NzC4/e2erRfIvQD1
	A8nTo+6gD2YZI/LjUWv09zjthhbk9m+8mAIGLU6AGMEv2KsK1yqzDXI7/PClIx3kAxzS0mbSdxp
	88mveY674qYbLSOf2FWCA5rSxEIj/FlJS21ELqc9RFfK09/ZHdXrZ+UCcsQmqPCgb9eCewDPWM0
	EpAIubLcUxg4gpAOrmO6tt6+fAOXC6WvdmrUtWJrpMXBTAegK7f9pL36bHncpUCK3NiAtTt4qr1
	JvKdgdCdUuq7OvM/3sL0+BYQTq9XGFDhjKHz/TT9
X-Google-Smtp-Source: AGHT+IHjbc82WPFLFYJqUcclQhm+5J20tGWB4R4jo77r5H5Zl7NTJpo1SEIdn4FVH/XUTu4IGCJZHw==
X-Received: by 2002:a17:90b:3c4e:b0:2ff:796b:4d05 with SMTP id 98e67ed59e1d1-30a4e5ae12amr5825968a91.11.1746201838224;
        Fri, 02 May 2025 09:03:58 -0700 (PDT)
Received: from localhost ([216.228.127.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3471ef7asm5916080a91.9.2025.05.02.09.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 09:03:57 -0700 (PDT)
Date: Fri, 2 May 2025 12:03:55 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Ian Rogers <irogers@google.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Arnd Bergmann <arnd@arndb.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jakub Kicinski <kuba@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
	Leo Yan <leo.yan@arm.com>
Subject: Re: [PATCH v2 2/5] bitmap: Silence a clang -Wshorten-64-to-32 warning
Message-ID: <aBTs6yvKlCYYgU2O@yury>
References: <20250430171534.132774-1-irogers@google.com>
 <20250430171534.132774-3-irogers@google.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250430171534.132774-3-irogers@google.com>

Hi Ian,

On Wed, Apr 30, 2025 at 10:15:31AM -0700, Ian Rogers wrote:
> The clang warning -Wshorten-64-to-32 can be useful to catch
> inadvertent truncation. In some instances this truncation can lead to
> changing the sign of a result, for example, truncation to return an
> int to fit a sort routine. Silence the warning by making the implicit
> truncation explicit. This isn't to say the code is currently incorrect
> but without silencing the warning it is hard to spot the erroneous
> cases.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>
> ---
>  include/linux/bitmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 595217b7a6e7..4395e0a618f4 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -442,7 +442,7 @@ static __always_inline
>  unsigned int bitmap_weight(const unsigned long *src, unsigned int nbits)
>  {
>  	if (small_const_nbits(nbits))
> -		return hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));
> +		return (int)hweight_long(*src & BITMAP_LAST_WORD_MASK(nbits));

This should return unsigned int, I guess?

Also, most of the functions you touch here have their copies in tools.
Can you please keep them synchronized?

Thanks,
Yury

>  	return __bitmap_weight(src, nbits);
>  }
>  
> -- 
> 2.49.0.906.g1f30a19c02-goog

