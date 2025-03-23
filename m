Return-Path: <linux-arch+bounces-11047-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88200A6CEEE
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 12:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A7357A6533
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 11:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F442040BA;
	Sun, 23 Mar 2025 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUg/qc3e"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6288D1D95B4;
	Sun, 23 Mar 2025 11:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742729762; cv=none; b=M/MxJY/epr6b//wzONZdUc1jm/kdrY+hTxiINOFaTqTmBctg8LTuWO7j4pFGpGPJVpi9Gez2ySadYX0xMTMnt9e8gWUvyZCYoWvjKpSNsDOI6uVJidTtRvxNMIMxNg1PsxIRWgBPyGKqKnUgl8PwhDKwfV/IAbhNqQL1Suw6HM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742729762; c=relaxed/simple;
	bh=vxqD9fQ0riCAby3fUhv76PYUNSKXaRoQ4ZVMDVN1oec=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=Fz/9E+PGyHddJQnAFSFNbmwJwI5H5Tm+gJewJ5OTXfGDG69VAvz9CEADLSY+rD+C1iReKFx2AHLXLD1LSJXLQh4i7QUv5vetH5W3151JcWx6WZtckQ7V6Klh7Lvi7jl7/cr+B6SfcZCXdTR22nrBop1LKXUEdsZn/zx+nLm6h9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bUg/qc3e; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac29af3382dso580881666b.2;
        Sun, 23 Mar 2025 04:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742729758; x=1743334558; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ulYi+eY/hFy7Rpw8ZWtw9DJBvuhlwhkseKvZOaTPlmo=;
        b=bUg/qc3eiFvzcMMgWig91fpQdtBHbvkmZRaTcIn1M6lkMWYChKXlkYdpKs82Guq/o9
         lFzy6sKUg2DG+9alRCvxibDYHCcZHVdz6+H/gsARrfqf7R8fpMLW8oWIfh4B2+uzGpS0
         LAHStrem3WFQkQ88Q6NJ0RORQlAqwkhSJBP5OR7oY08JElJJ3aYJjg0urvJPRgrepLTp
         vnlABZJ5QOpdHTEtdKwkTRqFAzFhFJba9Q70F8sh3JQRDET8wuOpxOqeJvDrLWpsUZeK
         qN0+vBoM1bI0fSceUrgaPnDuYRy8pmKlYmKcVV5mmrk18YPONGrDYAiTr7IRrLwDCsYF
         W2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742729758; x=1743334558;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ulYi+eY/hFy7Rpw8ZWtw9DJBvuhlwhkseKvZOaTPlmo=;
        b=vYjWqramYJy5LE6lFhiZiMD868xGFuA5LDS8s8/SZPnLPHjeTZ6mauYMgDbMV9RERF
         S4ByY27Q6bH4m3SCJcFah/pE5k/u9B0oB4kW0i4FslE5K6m8AzNM94aF3Yv6iN8Y0mLt
         FNA/wNQlV1i4Q2+hAJ4AXAs5cdwSUHy/yV2HdnQrnA2PGRQzt58+rY5K3o0KCtQLlhc4
         F3BfX5seLiTLY7+iOy+2RPar+OrZ909jvGSdJkwgFK6lkEriB/gzGIBKINmnFXdN2a4r
         OaCAKambHLhUSyn8707NvX/0WFfiUJV6V0Pjh10x/AgiVrEjWK3MTbOyfiVWUM8aH7A+
         199g==
X-Forwarded-Encrypted: i=1; AJvYcCUCL0mFynLSYM9+EfHZuCAfVqifrdYWBvR0NlbS3jp9+bsfJBQOgtoW3+F/34LX2/8o+ks=@vger.kernel.org, AJvYcCUqq5h84kZJTYVpbWKY2EIN1XiSCDhUj/35VS1zIXARXyuo8ERchWWSdm881IO159Z397KOENLcNd7Afg==@vger.kernel.org, AJvYcCXVCywQlGb381tciDA6iXHJaIiK7miCx66vcAMgKFc24of8y424bjeHOSSzz4Uc/Iy91AMRRRMKBVyFghR4@vger.kernel.org, AJvYcCXyxnMAmMvQ2WR6VXxFmg4EUoGjYGiqOeUCbNtC5xQtF4U2YZegR4rZakCQ0KuA7NZba9Zf1GgbCshS@vger.kernel.org
X-Gm-Message-State: AOJu0YxyXOuZIQr7HpDstx/diEomcl7pYZ1viAp11e4gDR4vpuowlU7p
	cFHyGkV0daNM7SEGXKxcHI2hxHJ9FNk2Y1+MB2w9aFL4XI2+fLHv
X-Gm-Gg: ASbGncuA1AKGQzg3md6EyLo9/i5/DBuGMh7kxQe+2rzfDvnYoQDZZUbVeQRjTHWFfx/
	H++wCYsT1cfMhsbMPylW4Z952NekN2Jq2e9pwunPWUJ8thitKAt0yjxcyolItWkTSMMXIIFNAPz
	oMbJSYW6CeXvnHaZ2YJL2fcpCdPsTKC7RRJFeYviiQb7w7gE+cUuYZA1nlEB6Kxi6F1W339QGMf
	9an6nFrWBYDwNK06TwCLS4SolXA5AWQ/029OejlLPRv78Z50ghwAeBPJOJ4+cpzkrSgKQhQ8DdA
	u3Wwqa7M3MrBszOdVFpgx+u4PFSmtwlA3hKG7XeNB6YIBfT/4lBFHgMAHXa3dYKOFxckf3oDPs9
	uqkCdMml31+FSQEgu8DYSNx1PpA==
X-Google-Smtp-Source: AGHT+IEzF59fM+1sXKTJnQXrcFoM0BGGjWdJktjtNJk+BRvhUOw/UEJ7hRrjg6HizFkpkJVBQreUZw==
X-Received: by 2002:a17:907:ec0d:b0:ac3:d9db:14bc with SMTP id a640c23a62f3a-ac3f1dfcc58mr968370866b.0.1742729758185;
        Sun, 23 Mar 2025 04:35:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:400c:7196:fafe:b8ec? ([2001:b07:5d29:f42d:400c:7196:fafe:b8ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4800esm493940666b.164.2025.03.23.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Mar 2025 04:35:57 -0700 (PDT)
Message-ID: <545cc6485e2c4043d222cb762833fd9bc33feb1a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 09/22] crypto/ccp: Implement SEV TIO firmware
 interface
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
Date: Sun, 23 Mar 2025 12:35:55 +0100
In-Reply-To: <20250218111017.491719-10-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On 2025-02-18 at 11:09, Alexey Kardashevskiy wrote:
> diff --git a/drivers/crypto/ccp/sev-dev-tio.c
> b/drivers/crypto/ccp/sev-dev-tio.c
> new file mode 100644
> index 000000000000..bd55ad6c5fb3
> --- /dev/null
> +++ b/drivers/crypto/ccp/sev-dev-tio.c
> @@ -0,0 +1,1664 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +// Interface to PSP for CCP/SEV-TIO/SNP-VM
> +
> +#include <linux/pci.h>
> +#include <linux/tsm.h>
> +#include <linux/psp.h>
> +#include <linux/file.h>
> +#include <linux/vmalloc.h>
> +
> +#include <asm/sev-common.h>
> +#include <asm/sev.h>
> +#include <asm/page.h>
> +
> +#include "psp-dev.h"
> +#include "sev-dev.h"
> +#include "sev-dev-tio.h"
> +
> +static void *__prep_data_pg(struct tsm_dev_tio *dev_data, size_t
> len)
> +{
> +	void *r =3D dev_data->data_pg;
> +
> +	if (snp_reclaim_pages(virt_to_phys(r), 1, false))
> +		return NULL;
> +
> +	memset(r, 0, len);
> +
> +	if (rmp_make_private(page_to_pfn(virt_to_page(r)), 0,
> PG_LEVEL_4K, 0, true))

We have virt_to_pfn().

> +static struct sla_addr_t sla_alloc(size_t len, bool firmware_state)
> +{
> +	unsigned long i, npages =3D PAGE_ALIGN(len) >> PAGE_SHIFT;
> +	struct sla_addr_t *scatter =3D NULL;
> +	struct sla_addr_t ret =3D SLA_NULL;
> +	struct sla_buffer_hdr *buf;
> +	struct page *pg;
> +
> +	if (npages =3D=3D 0)
> +		return ret;
> +
> +	if (WARN_ON_ONCE(npages > ((PAGE_SIZE / sizeof(struct
> sla_addr_t)) + 1)))

This should be (npages + 1 > (...)), because we need to fit `npages`
SLAs plus the final SLA_EOL.

> +/* Expands a buffer, only firmware owned buffers allowed for now */
> +static int sla_expand(struct sla_addr_t *sla, size_t *len)
> +{
> +	struct sla_buffer_hdr *oldbuf =3D sla_buffer_map(*sla),
> *newbuf;
> +	struct sla_addr_t oldsla =3D *sla, newsla;
> +	size_t oldlen =3D *len, newlen;
> +
> +	if (!oldbuf)
> +		return -EFAULT;
> +
> +	newlen =3D oldbuf->capacity_sz;
> +	if (oldbuf->capacity_sz =3D=3D oldlen) {
> +		/* This buffer does not require expansion, must be
> another buffer */
> +		sla_buffer_unmap(oldsla, oldbuf);
> +		return 1;
> +	}
> +
> +	pr_notice("Expanding BUFFER from %ld to %ld bytes\n",
> oldlen, newlen);
> +
> +	newsla =3D sla_alloc(newlen, true);
> +	if (IS_SLA_NULL(newsla))
> +		return -ENOMEM;
> +
> +	newbuf =3D sla_buffer_map(newsla);
> +	if (!newbuf) {
> +		sla_free(newsla, newlen, true);
> +		return -EFAULT;
> +	}
> +
> +	memcpy(newbuf, oldbuf, oldlen);
> +
> +	sla_buffer_unmap(newsla, newbuf);
> +	sla_free(oldsla, oldlen, true);
> +	*sla =3D newsla;
> +	*len =3D newlen;
> +
> +	return 0;

Return values are inconsistent with how this function is used in
sev_tio_do_cmd(): a zero value should indicate that expansion is not
required.

