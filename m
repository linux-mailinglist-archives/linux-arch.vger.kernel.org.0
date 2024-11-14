Return-Path: <linux-arch+bounces-9100-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FA09C9330
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 21:26:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40B591F22F4A
	for <lists+linux-arch@lfdr.de>; Thu, 14 Nov 2024 20:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182861AB503;
	Thu, 14 Nov 2024 20:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnUMRqjl"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC1B198A0E;
	Thu, 14 Nov 2024 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731615956; cv=none; b=VbPnKMzg73BIT0682WWzL/RqiG6PAHj9od7L7QSKUsYjsvQSthmgkjN/7LivbjkNIoeEPy5V3wkapCbcAE7knR5YOtA8fqEdm20DHwZ4xnF8sIcIUji33TAOmDXocqDy0er8F0xYyzaAGpuHpIAzpEs9w14TjefCKSiJ5vNVEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731615956; c=relaxed/simple;
	bh=s9+DOv2AjlxLBve8BLWtmOlA90MbZgj1yWjSHsv5y0Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/OZN/fIuONhaF69sS5VCqdAdDQdf5QC7x3y8qOYobgNU3AvQio4Fr/3X9R1hl4GT+xLgpoy6gJ05INFkNeUA1lYoBU2lHBaimAvBljxTJxtnAZdunNFJclinp4EEO0zlC6CYgImEDLg9tctLLKCSh8lI/2zTppv01iAHzVbltc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnUMRqjl; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2fb5111747cso10525751fa.2;
        Thu, 14 Nov 2024 12:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731615952; x=1732220752; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I/1SqCDSlERm/dM81G1InJgqAP4pfbcNYeB1lcKaPOY=;
        b=KnUMRqjlp2A+nStO3yXcLu+oU7H/mlPoZ8fPEHzKjAFIU3Nv+NULGCpimDqO0hlSw8
         imkDvrbOapRiwZzQFJBpfuv5nVN1LT/EYdy9lspX9/CgYf/fcgNAliyOmMghQT31Ij8x
         YSVVgk9/DavKzxIoJ11qxbhnmkMRtB/wGw+/Xfb3gCzQJUR9Z06pyno4V13duNX4xXPi
         v3/RHFMxLUM78180UkJmd0KccXUACwGIFPmAt5VoH6lE+oF1awB5EAbxlxtjo7EbLWVO
         DG3YK6xaA7IYg0c2LWgqLeet4uOR+I2cG+LKavKr/fM+VPyDZxjOsc1vWOmXJpNdaqtV
         TcLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731615952; x=1732220752;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I/1SqCDSlERm/dM81G1InJgqAP4pfbcNYeB1lcKaPOY=;
        b=rVo9LBZPQGUXZA292BJpLAI5aQOYenhVOAxyGb52N8/YNCuBGZ6ann+UBffmYVqA2A
         U/ttEX61ukBHZ60dVbw4nuU2Q6pSWAMTeezdDJvxM6u8+GtMVZ/JYPSSVILYiLSMJL/8
         bFpvLk0gKQ76alU3sa/zZRoFqtFhNLsnlKRbvlKUcL/7WZ57Vuusxpx4NpV/mNySJjP0
         mREU1TAyscXxmmDKjRjHOFU4vSCZ59JW9sFCaq0kridf7yh+YIn7rJVcPgDquouADffp
         FabsfxRHJmAhlxrIPOgvWHRLpGlfUy8PKBjKA5cwLD/z7mSpL5Fq+3V49yTE1mbS0t/H
         ZPEg==
X-Forwarded-Encrypted: i=1; AJvYcCUkFKiHD++E1f+ByepjukVZs21z6QykUy3EG7+xGc80iLy1hUiJ9cXkDi1bl1PzpLuTwcJUvrY+HAi+ZKsA@vger.kernel.org, AJvYcCXQCHMbHDEiz1xlMtibqht3nsKzjrPpyihvca77KgJTdLIvhIMaIaHOvDdFJfdX/PsNSV3d9EzxC4in@vger.kernel.org
X-Gm-Message-State: AOJu0YzeEVadf9gHidbECzc3iVKfLviFTo2z90Hqlod26ZOGFmK9KTgf
	knYvCvN69mk3/YPH1lXmtHb4nTaSoI7dPoH4yTTXU06SKo1nq4GfCj/H/6AHVMDGZeZN/CSurUb
	yahn7lVYC0b/76+FwhffR4Y0n0AI=
X-Google-Smtp-Source: AGHT+IEC7pGtVCBnwD9Pmf6WBeFocaB36f7h4OFa6oSTdO9vrJqzdqO25X0vd4M5p43hqMl/b3Hpjbv1qFYMhwhwTpM=
X-Received: by 2002:a2e:a9a4:0:b0:2ff:566e:b583 with SMTP id
 38308e7fff4ca-2ff60665fb5mr2479901fa.11.1731615952392; Thu, 14 Nov 2024
 12:25:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113120327.5239-6-suravee.suthikulpanit@amd.com>
 <cac1ccd3-4b81-4374-a49d-9afad755b19c@app.fastmail.com> <20241113132031.GF35230@nvidia.com>
 <CAFULd4a1PHREX6ws9Gyu=TaaZvdgLfh6peoE5Tt010uGyY9Hgw@mail.gmail.com>
 <20241113140914.GI35230@nvidia.com> <CAFULd4aGDM5ySO-PeOH0+_U89mnqYqQ7v+U0ZsMode3bxs_X7w@mail.gmail.com>
 <20241113142807.GJ35230@nvidia.com> <CAFULd4aFvGj=kz5Si9WpAr33KFtJDO5+sdNO=NBB+boS=E-E_Q@mail.gmail.com>
 <20241113163451.GK35230@nvidia.com> <CAFULd4bvDhfSprPEyirvX9VmKK_fpxaVNRO02oqT_KQAdLFhfg@mail.gmail.com>
 <20241114162918.GS35230@nvidia.com>
In-Reply-To: <20241114162918.GS35230@nvidia.com>
From: Uros Bizjak <ubizjak@gmail.com>
Date: Thu, 14 Nov 2024 21:25:40 +0100
Message-ID: <CAFULd4Zi-ua=G-JR2JytwkDtghJSaV-Q_dAPFswkKiUB0rX5oA@mail.gmail.com>
Subject: Re: [PATCH v10 05/10] iommu/amd: Introduce helper function to update
 256-bit DTE
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev, 
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>, vasant.hegde@amd.com, 
	Linux-Arch <linux-arch@vger.kernel.org>, Kevin Tian <kevin.tian@intel.com>, jon.grimm@amd.com, 
	santosh.shukla@amd.com, pandoh@google.com, kumaranand@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 14, 2024 at 5:29=E2=80=AFPM Jason Gunthorpe <jgg@nvidia.com> wr=
ote:
>
> On Wed, Nov 13, 2024 at 08:50:08PM +0100, Uros Bizjak wrote:
>
> > Then write_dte_upper128() would look like:
> >
> > static void write_dte_upper128(struct dev_table_entry *ptr, struct
> > dev_table_entry *new)
> > {
> >     struct dev_table_entry old =3D {}; <--- do we need to initialize st=
ruct here?
> >
> >     old.data128[1] =3D ptr->data128[1];
> >
> >     /*
> >      * Preserve DTE_DATA2_INTR_MASK. This needs to be
> >      * done here since it requires to be inside
> >      * spin_lock(&dev_data->dte_lock) context.
> >      */
> >     new->data[2] &=3D ~DTE_DATA2_INTR_MASK;
> >     new->data[2] |=3D old.data[2] & DTE_DATA2_INTR_MASK;
> >
> >     iommu_atomic128_set(&ptr->data128[1], new->data128[1]);
> > }
> >
> > and in a similar way implement write_dte_lower128().
>
> That makes sense to me, but also we have drifted really far from the
> purpose of this series and missed this merge window because of this :\
>
> Let's conclude something please

The most important fact here is that data won't change (I was not
aware of that), and that we would like to exercise only the 128bit
atomic write property of the cmpxchg16b. So, we actually don't need a
"lockless" approach, where we would need __READ_ONCE() and cmpxchg
loop. The atomic write can be a simple arch_cmpxchg128(ptr, *ptr,
new), and because *ptr won't change between preload and compare, the
xchg will always succeed.

Uros.

