Return-Path: <linux-arch+bounces-11042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6E94A6C9FA
	for <lists+linux-arch@lfdr.de>; Sat, 22 Mar 2025 12:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F6DB1890442
	for <lists+linux-arch@lfdr.de>; Sat, 22 Mar 2025 11:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9B220CCDA;
	Sat, 22 Mar 2025 11:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSPi173G"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D451F237C;
	Sat, 22 Mar 2025 11:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742644219; cv=none; b=OmPfjLO7edpQ7SWVBCmP/MOzVqU39sFwyE4Vcp3pIqjpDXy7J1lQHKPOHVD///9To1G2Ex7G4PUQyUFFRrm26mHSHx3x9MUl70ogL1Dg4GZjpWYtkx5+4B03puyHcvRhbu38sMlnjhibZaaRfp13q0ShE+w10R7pZ4DDIKrs2hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742644219; c=relaxed/simple;
	bh=dlb2c5+73X9T17Ga2GDXTcwT6vGIJCUSgIzW59AQZWg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=rNu/UdTsJ1c5pdO2yRzhP45iGJGLb6WzIYPtw0M5oFFy3wcgFisFPOYlutfZE/oHwYCEnXBiXmd48mCJKFbC0lKX6u1dQxSe6SoWFLvWzDAFHwwzMrTb4gu5ewn9ETXTXhvFoOBukzapP4an6O01Jq2dt12/zbui0So78zMC6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSPi173G; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ac2902f7c2aso483215066b.1;
        Sat, 22 Mar 2025 04:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742644216; x=1743249016; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JeCMKd6FN5Dtrxtkveh1+h24l/CzYAUf5GBYjF0Tj9I=;
        b=JSPi173Gy9EisqpIuqxLAdt39Xzhxyi86yrBYhtu3gQ9Bsl+F68pXBXzEdYSsTnd7l
         WSQNuJW6GLAFDTN8LRqAbhofx8u//QbbbI/KThok4rxMwo1e1YokPhXhb47TFqx+W+qF
         jUF0gbKlsrw915WMfmz5dgZExnnXV2qsvlQH9dXDnfbLzjnxGyCpBt79eg/YSd6c+YaQ
         nCegTCjWUDdI93OBACZ4LxfmfKgjPoPse7KZ30a+BdninHvI/iV8C5ALMX0R7r/DoqFn
         icdZxEK7irobWx9TB+2bsZMg/53brsOdo2GOJb+iU0WqDHnFQqm+Xr4krAM5mIxYAyom
         V62A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742644216; x=1743249016;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=JeCMKd6FN5Dtrxtkveh1+h24l/CzYAUf5GBYjF0Tj9I=;
        b=U+UgbvZ9dVbLTg4Q6gCTbe2jZE6v1HP4ev+gGg+GKVZpaANIIHT5mA4U/23AoAdzjN
         3via79vm48Z1VCsTn1Qr970LKV6eJhoNOOSTxrypWaBEFpI/XIizdxADnZVi37BmHrhS
         oPzRf9zGUPEgd+uDtg0UY7/8ocQuYKOee1eyEP4cKaWAZ6MHxO3faZRvDWsBthMfaWG1
         oMNBlJ8NeXiWyG5Y0klEnRTbko53wf3yrh7Fh1ZaZKrcxky2PwVN4w4VXxTefyArLDVs
         uVpirV00M6/NVeyQFwJ4qp4mUjep+c3i2Aa483QLzR5VC4JKFJpDoaswDKDRiNfaOnJb
         YCdQ==
X-Forwarded-Encrypted: i=1; AJvYcCUthLpHEKjq9kGU3PlowSene2JsY2dAIeE7jaSCeCcruLo2ZyoFRFWnw2ApPUuDrdKzffyfKfN9TxXXwA==@vger.kernel.org, AJvYcCWCjhZU/rhMFSTkM1ClSNdEq3LrM2GOg+iyHBAJAdEReusXE8lRpgXBU42k+KjXWTxdA2sbgekBmGpy@vger.kernel.org, AJvYcCWuMU6e8Wl5rrm48hXee7iaxWOSa7I/8vO904BnrPFFpjFm4u8u52fOONNxJm2pAqkC0Xs=@vger.kernel.org, AJvYcCWzcfwm8d5a4o+dPUMM9boHmg442qy6VzNcnHQfRJK+eS0KAabpY9rJfU1BH0xLpdhb7XbST5ZLWtNs3MBc@vger.kernel.org
X-Gm-Message-State: AOJu0YyUfzkeoghv+3UP9DpHrvrIisU0YENgnHrOzHrrhmNA7iItopuR
	1sVX5KsILBs6NyPOflZkZ7oAu/1FNzBumSMmVvW76tXyyiYJpANv
X-Gm-Gg: ASbGncu++nUuEKwWdvUvOKgVDG3MxX27HCZ3beBkDgHk6RSvnCAph1m2SF9cSLfwsCb
	DJYe0xPO9JDgOcpD6n/n4axqI659vDcI5w6oMs662oyX3DN+TAXG9932U4yOQT1tF9Eq9YPAo1p
	yyRnd9aNYm7CB+1ItIzC0kwMJgofD+Ej8eKjlfWmaLTYES8kEk7+c6Ho322cze0Q6irPFThekWq
	HjQhVILrpfY5Pyxici++gLSOlPjaQqreQovGxWi3aqRS/Ggh4pM5HNAlbIUdGERsuPQkeLzHyE3
	TIWSYvlsYCf9Vsna5aPR+v/L8kXZVEq9I1P1B2DtjysetYzjO6gn0CBafbpkDCAE1cb1lojTERL
	MijCTeV/tCSN8m7wcwXeHXUo=
X-Google-Smtp-Source: AGHT+IEphkVCVCfxAVXmQkZdk1aaFCEcND/QMO8xPKoiUSmAYimS0LjW+bLOcrDDhpSGnYro5fRwfQ==
X-Received: by 2002:a17:907:ec81:b0:ac4:2b0:216f with SMTP id a640c23a62f3a-ac402b024c3mr372266766b.43.1742644215830;
        Sat, 22 Mar 2025 04:50:15 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:82af:f891:3144:66d? ([2001:b07:5d29:f42d:82af:f891:3144:66d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd4798dsm326399066b.161.2025.03.22.04.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Mar 2025 04:50:15 -0700 (PDT)
Message-ID: <7177c7ae24b9f7ebbfc001166e09beadb81305ae.camel@gmail.com>
Subject: Re: [RFC PATCH v2 05/22] crypto: ccp: Enable SEV-TIO feature in the
 PSP when supported
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
Date: Sat, 22 Mar 2025 12:50:12 +0100
In-Reply-To: <20250218111017.491719-6-aik@amd.com>
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
> @@ -601,6 +603,25 @@ struct sev_data_snp_addr {
>  	u64 address;				/* In/Out */
>  } __packed;
> =20
> +/**
> + * struct sev_data_snp_feature_info - SEV_CMD_SNP_FEATURE_INFO
> command params
> + *
> + * @len: length of this struct
> + * @ecx_in: subfunction index of CPUID Fn8000_0024
> + * @feature_info_paddr: physical address of a page with
> sev_snp_feature_info
> + */
> +#define SNP_FEATURE_FN8000_0024_EBX_X00_SEVTIO	1

According to the SNP firmware ABI spec, support for SEV TIO commands is
indicated by bit 1 (bit 0 is for SEV legacy commands).

> +static int snp_get_feature_info(struct sev_device *sev, u32 ecx,
> struct sev_snp_feature_info *fi)
> +{
> +	struct sev_user_data_snp_status status =3D { 0 };
> +	int psp_ret =3D 0, ret;
> +
> +	ret =3D snp_platform_status_locked(sev, &status, &psp_ret);
> +	if (ret)
> +		return ret;
> +	if (ret !=3D SEV_RET_SUCCESS)

s/ret/psp_ret/

> +		return -EFAULT;
> +	if (!status.feature_info)
> +		return -ENOENT;
> +
> +	ret =3D snp_feature_info_locked(sev, ecx, fi, &psp_ret);
> +	if (ret)
> +		return ret;
> +	if (ret !=3D SEV_RET_SUCCESS)

Same here

