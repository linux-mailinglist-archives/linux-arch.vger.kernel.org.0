Return-Path: <linux-arch+bounces-8541-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CADEB9AFF29
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 11:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06C341C216ED
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 09:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF9F21D4171;
	Fri, 25 Oct 2024 09:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LKIvcOli"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99421BCA0C;
	Fri, 25 Oct 2024 09:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850303; cv=none; b=H9XRGgDj/dpMqHnHzaQ9hDnmzwCkXUlr0TKKPngWrJphSHz21ZqWpSqbzq0WJpu41Eo7MSK5m94N4x7LyRrZaijIvhTg11dJd2sviVk8ACXSRhE7gnHgQ0p4ePzYYvazlaxlEqZ0f8hJEnVB8i91LGnFYDolJxtfHymxf36sAIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850303; c=relaxed/simple;
	bh=m8kySb3Ln3L0rkCO67Dz3c9CR2j8I3dbStdCUIbsTbs=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucWO8LdOJTMzucIQlbgX73RY812OBxv7b+DJh+50L1paIMlS2Hb658L6wuZzwhDJ4Ixb0maYB+Uer+h1CDp1uhjwL/a+jub3P90+c0DkaeAUBj3z4qP087njT5FhX+ZaD+5GfXNYPtH5GobDD+oivYyoKkSO+1m/9A8epZtat+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LKIvcOli; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-539e4b7409fso1958551e87.0;
        Fri, 25 Oct 2024 02:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729850300; x=1730455100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i5pjU6XgMUY2DW3lmDrsl6sxn45lVjUs8uVDSTfykzw=;
        b=LKIvcOliuZpVmu5xnsG+fvCuayO2jIoqrt+fNZwHUWyKqaoy65MdllWO/GVE2VL8C9
         rb5I2UHEh7TqeUHNhKX0vO1XUAZEOPWKB4E41gMIJUIOKNCddUqT/hqqcUPnAzn/LO60
         2jAtEqRaRmRfP+etbTQltfHZk/u2KNN4RZfW0VfaIvyceTnOzEtmHqREOwMa4kQ9eq7m
         buJPXyWXG0b2nheRzLN+d8zk3aNRVg/GwIQqk+ZWBcLpSkwYzRnM0/JUDjNHCV/dTxQj
         nd//Fv2mvLgjJees2xMb+1M/A0WMEkzKa760o4ptdmIODBFZ3sB+s0rLw/cUcJPBfkPM
         2A1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729850300; x=1730455100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5pjU6XgMUY2DW3lmDrsl6sxn45lVjUs8uVDSTfykzw=;
        b=SOrde25PjdKKQ8GJOuy/mGWjqzvK41VZiXvOluGYuXor3SlAv66dENf5xqX1tV9uaK
         Id14kfcSPGkS3U9Rc1FBNCjHYLoPH45aVLSDB6984wiEDVkxPMOluIKhVcsiTOen3to5
         wUEDZLjQPFbpbAmQr5GjfAUZ6JcZx91LZKaawfPNten6MuOq9YPS67v9SAy/0uOgnKgu
         Tyv9cz7gXGjGppEwoJlhZkZFJVPGiwDVouQ6tdioGWpDcWT3IfeoKm00SPhZoZmo92TI
         72ZvflfSdH1/8EvLH+IVcAMGEhWe31+bAR4rjAphzRhBEEfxJd8CydEVPV0R+EkOeFFJ
         4ejw==
X-Forwarded-Encrypted: i=1; AJvYcCUw6VAzkpRVdUieV8s89IfvgnA1eHKic1wcCRTiJgTyH4eQUOtw1SAXEWIBxbIP3I80EpNj9EzblKX1BQ==@vger.kernel.org, AJvYcCXN0thx98iOyq+UrkhV2w2gPvSyKy9VOF7z2fY0InRlp5Npe0Lz97VsoWLu62OETMUCZMUyjYt74Na0D6Mo@vger.kernel.org, AJvYcCXPFHS3/p9HIX3tK05j4F65UE7fFjF8v+sgy1g5MGCGBy1JljADfz0fEPt4FHxmMkYMfAIIbcFi8EM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLbGoT/MgTNdilwCIzD2NVBQChK8/WVScg0k0lMpay46ybEvuR
	T35ANwqK7ougJdQM3dAPa2iAmeH19GokZS9djovoIj4bHFeIHQjJ
X-Google-Smtp-Source: AGHT+IGpDxS5G3/tgaKmgGoZuR4E+jQQ4DDYVIEthmTHaAuJDOjnX6dvesznCnpBiD5YPHb/6KyA4Q==
X-Received: by 2002:a05:6512:3352:b0:533:415e:cd9a with SMTP id 2adb3069b0e04-53b2374cff5mr1325350e87.23.1729850299479;
        Fri, 25 Oct 2024 02:58:19 -0700 (PDT)
Received: from pc636 (host-90-233-221-2.mobileonline.telia.com. [90.233.221.2])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a513sm119530e87.33.2024.10.25.02.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 02:58:18 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Fri, 25 Oct 2024 11:58:15 +0200
To: Peter Zijlstra <peterz@infradead.org>
Cc: tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@redhat.com,
	dvhart@infradead.org, dave@stgolabs.net, andrealmeid@igalia.com,
	Andrew Morton <akpm@linux-foundation.org>, urezki@gmail.com,
	hch@infradead.org, lstoakes@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, linux-api@vger.kernel.org,
	linux-mm@kvack.org, linux-arch@vger.kernel.org,
	malteskarupke@web.de, cl@linux.com, llong@redhat.com,
	Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 1/6] mm: Add vmalloc_huge_node()
Message-ID: <Zxtrt7f8rFwIknbB@pc636>
References: <20241025090347.244183920@infradead.org>
 <20241025093944.372391936@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025093944.372391936@infradead.org>

On Fri, Oct 25, 2024 at 11:03:48AM +0200, Peter Zijlstra wrote:
> To enable node specific hash-tables.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/vmalloc.h |    3 +++
>  mm/vmalloc.c            |    7 +++++++
>  2 files changed, 10 insertions(+)
> 
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -177,6 +177,9 @@ void *__vmalloc_node_noprof(unsigned lon
>  void *vmalloc_huge_noprof(unsigned long size, gfp_t gfp_mask) __alloc_size(1);
>  #define vmalloc_huge(...)	alloc_hooks(vmalloc_huge_noprof(__VA_ARGS__))
>  
> +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node) __alloc_size(1);
> +#define vmalloc_huge_node(...)	alloc_hooks(vmalloc_huge_node_noprof(__VA_ARGS__))
> +
>  extern void *__vmalloc_array_noprof(size_t n, size_t size, gfp_t flags) __alloc_size(1, 2);
>  #define __vmalloc_array(...)	alloc_hooks(__vmalloc_array_noprof(__VA_ARGS__))
>  
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3948,6 +3948,13 @@ void *vmalloc_huge_noprof(unsigned long
>  }
>  EXPORT_SYMBOL_GPL(vmalloc_huge_noprof);
>  
> +void *vmalloc_huge_node_noprof(unsigned long size, gfp_t gfp_mask, int node)
> +{
> +	return __vmalloc_node_range(size, 1, VMALLOC_START, VMALLOC_END,
> +				    gfp_mask, PAGE_KERNEL, VM_ALLOW_HUGE_VMAP,
> +				    node, __builtin_return_address(0));
> +}
> +
>  /**
>   * vzalloc - allocate virtually contiguous memory with zero fill
>   * @size:    allocation size
> 
> 
Reviewed-by: Uladzislau Rezki (Sony) <urezki@gmail.com>

--
Uladzislau Rezki

