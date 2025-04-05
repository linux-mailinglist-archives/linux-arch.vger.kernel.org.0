Return-Path: <linux-arch+bounces-11293-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DAB53A7CB32
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 20:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 694D01682BC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 18:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A8A1A2396;
	Sat,  5 Apr 2025 18:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lcz8Hts1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBFF13B7A3;
	Sat,  5 Apr 2025 18:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743877193; cv=none; b=FioF5VsDluUDeymd63SFpl6O79wxT8iug0CXAIhaR/sSW+zzpEj3mjCHIZ92Ll4TpVbBcjpUSHBd/z+QP2aubXiAmWfVvogemORP3+nQTJaz8Ncw5NrjDmqxvU02XmqFNLToX7GwJIe1qA7SoiLQ2Y+Ivj8ah6UUDtAR/wn39FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743877193; c=relaxed/simple;
	bh=UuKpmCc29izBRMeN6jegH6OMMWvy55AsNWWT5DJwIi4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=B04w/h5EKjR2kSzOgI6SPyWMSoFDAZb4sKBiqMQPugNDOvuiAiIzZbI3NBxOoq1UvC6cIetmb2l/GUVzXfKxti8+3jvKNGmO/tdmsMNLiaMH/6r+ODLRCSZU1pawQUGu/wCpljbeddyjpVxFMjRdxpY3yjZh46lpi5jgGGI7Iao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lcz8Hts1; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5e5e8274a74so4985207a12.1;
        Sat, 05 Apr 2025 11:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743877189; x=1744481989; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JzDPIcjxpueJWPt8ubJyJmHV+G2m+1GMdqn6UOzKG/Q=;
        b=Lcz8Hts1D3VXAZrwJ6Mcql8kdtpe8YqDwOfvXWrhHGGrJJuVPovK18z8sMr6+oLxG2
         2VAoLAcpKSjU+ml6awi1ZYIcUxdTX+2WbS/bHvSwJxny5Wj+p7/U44BhmTDVbn8Nq8xo
         Ks9AehO069Ch5ghr4UBp8Z3GISKyGW2/BMOSCW+IQvejfk8fW+q2LDtMP531ovg/TQzt
         9J8iUCz7KWrH8ffHBAL0Qv0TK7scPmNTsFXSKUHeAlSGcB1UH0mz4euoSNHZS5RKrkk7
         T46XthobGgPqLzdbXCHu0zuu99WGlyZVBC94RQYDBvprteYwVf4vQuYdmZM7huLTA1Ty
         h6Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743877189; x=1744481989;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JzDPIcjxpueJWPt8ubJyJmHV+G2m+1GMdqn6UOzKG/Q=;
        b=ORCQCWeKtThrO8YvU9E8HFYft3/vEWg6iGUECjuVecNU5KtlwgFZtz1H/qaVGlwTy4
         HG25ax9MCmJ2GvvV5IU0O+yeiwv5vPFJWwGfzO3+CsKlzMyTG9hOtmRIbpL8tSpldxsg
         wxfMEY05NctrLQjzaN53jfXsXPX11xvuaMxTbqS6RmU0v1HRJBlvi6sa7ALKSb8ETFno
         t5EFP8pUVVgfthplPXWh4yRp9jRlViLgA21mcigAaH78XX+Kg/yGa+squVhpHwlY3OfC
         Tnse9bwZCUQ1KuzrajnLn+qGgXX1/Ez9YN7afSEsEUh1U9GuT3GTQMMOzylZzaqeWaIa
         I0vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVorgDpegevhbGXH6zh/Vq4dBgZLjpl8UEhTCb/W3l94KllTjlya36snrcrhZxUM4RLCKc=@vger.kernel.org, AJvYcCW3bwHRARCbH4G/Y6sLGYBCpfaHRGqj1337SFNjQ/svM20WU2LFdhfMrNmwgphrbPqvYu3DXkLcd3r0@vger.kernel.org, AJvYcCXIhSfcixVsJGbllkYRyAZNA2LxdWeDMX+z30OQvdRl1+zqC11KHC1w/hU8UqTbUPMohfQAcv0Vyqkobg==@vger.kernel.org, AJvYcCXrupm0XRKVFQLP2mRuObvat2/dc9jjQ0A73YwnroMef/YyJlf6acJJyiWqEWcInNdlgWZabLX6l5nftgP6@vger.kernel.org
X-Gm-Message-State: AOJu0YzGC2dTusYCgfHBavBR95v2by0hbXFAWxVtu/a6iw1aKHxZuz9m
	/hShSTfb6BPo1pV2Po7mb0Npj88+Xvfd4w+FVE7hUOfnNu3sclWM
X-Gm-Gg: ASbGnctDG9knLqqGF974/wY4tYZWUgoFtytavt8dlST5TZYuryDRvUWpXAKS5aPOkP/
	PN4rvik8oMirR49NsH+apD2Zit/N0R7+MBn+D60esUhXUfp2sc68G6qILF7/G4ilGVCLzkTXXst
	7bN30acY+hLgudod5U1e2w9dmAKJ0ABZkH5VV3ZQDOZ9qzTqiWBdNeiyKJKt8lh4noaynUEImMx
	/SiWJxXRptjagrnkTBeCYc9HGMqYmXer0KYKWSSw4P2vHiLWCZjXLrTrXRSr9dDmebwuDvQKvkX
	SOWsV6ZB2RMLtXY4uuVn17aau0B1rXbk0HEPc55iofjVOC/Gs9Nu/QUdcLjgIHD08Mqrt6ObTr8
	o07jXNimcI3KFqg7Kf4aUleFH9A==
X-Google-Smtp-Source: AGHT+IHjWd15bJFnLvYIPJuTi7FnhI2p3c/aAJQJSPYd5K7f8WVJvfxyJpynzpZjmDExmCZGqw22yQ==
X-Received: by 2002:a05:6402:2350:b0:5de:dfde:c8b1 with SMTP id 4fb4d7f45d1cf-5f0b3b62b55mr5957465a12.4.1743877189229;
        Sat, 05 Apr 2025 11:19:49 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4? ([2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088084eddsm4160377a12.62.2025.04.05.11.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 11:19:48 -0700 (PDT)
Message-ID: <3f450f215435d39b5376a83c42fd1da186d774c3.camel@gmail.com>
Subject: Re: [RFC PATCH v2 17/22] resource: Mark encrypted MMIO resource on
 validation
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Sat, 05 Apr 2025 20:19:46 +0200
In-Reply-To: <20250218111017.491719-18-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-18 at 11:10, Alexey Kardashevskiy wrote:
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 5385349f0b8a..f2e0b9f02373 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -55,6 +55,7 @@ struct resource {
>  #define IORESOURCE_MEM_64	0x00100000
>  #define IORESOURCE_WINDOW	0x00200000	/* forwarded by
> bridge */
>  #define IORESOURCE_MUXED	0x00400000	/* Resource is
> software muxed */
> +#define IORESOURCE_VALIDATED	0x00800000	/* TDISP validated
> */

You may want to remove the reference to TDISP, as this flag could be
reused for non-PCI devices in the future.

> @@ -1085,6 +1092,47 @@ int adjust_resource(struct resource *res,
> resource_size_t start,
>  }
>  EXPORT_SYMBOL(adjust_resource);
> =20
> +int encrypt_resource(struct resource *res, unsigned int flags)
> +{
> +	struct resource *p;
> +	int result =3D 0;
> +
> +	if (!res)
> +		return -EINVAL;
> +
> +	write_lock(&resource_lock);
> +
> +	for_each_resource(&iomem_resource, p, false) {

I don't think this function should walk the iomem_resource list, it can
simply modify res->flags, which is consistent with what is done by the
other *_resource() functions that take a pointer to a resource that is
expected to be in the list.
Also, the name of this function is unrelated to the name of the
affected flag, you may want to make these names more consistent.

