Return-Path: <linux-arch+bounces-13076-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B93AB1C31A
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 11:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B4F73B2E46
	for <lists+linux-arch@lfdr.de>; Wed,  6 Aug 2025 09:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829192566F2;
	Wed,  6 Aug 2025 09:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kOFF+3mC"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DEE26F44D;
	Wed,  6 Aug 2025 09:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754472090; cv=none; b=clvvwOly2xmYeknwNHMPcpDNoFwqU4er30cP4O5ifVvWoYArZLZGtNBh/A4CMLtFJRFB/z1bvU+E0NGBE59mpG3+nSJBWL4WRbOiborZGpcwWSE3/cidCNITcv+uIWGPpyEWPIFI7vSpKJ5z8Slpqc82/I2fj3hRUlulu/MwaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754472090; c=relaxed/simple;
	bh=uzqI93gBo/oOKMPbZq2Vl7FCC2T5XX1SAzCyum/KKE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZfwffT4Twq43TAGXT9jSJxZNbOzsm9i1bFxzlJ1nXL5SYfudvoPUnRqzcmkvXRgrQwyh0JNvpsOorf1Xql2uwkfNSXnDotGkI6H8lYjoxqrRfnWmIrxItg4wLcB/aJWylPF0irmGdLC4nJW2YuK562jnbCfcM+Q+QnoTQQOC3Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kOFF+3mC; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7426c44e014so5839505b3a.3;
        Wed, 06 Aug 2025 02:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754472088; x=1755076888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yY4YwA/qFjuotXlPIX+a7dTmxzeDOSaFsdvMOaOiE9k=;
        b=kOFF+3mCASOXrr0LYeoNJ2plKnTYxcHbxYDzL+T1V3L7L1ELLymBbILILeGZTUDgca
         UvoY3jNL7KyoacGjfh7qreNomLaUQy3587kcG8/9gsSdHWnWbZlGg5tuZXOf2VXKXebC
         BriJA+cJ0OfjditgNMwVBtkEjwkPwBHy4HCiJlhS0pCp/rickNHpiM/5dRpPlpsYOeou
         5H1NZD+jS5drSsfGlqJowNC5OdsFdtBXGPmjmVMCELkSTVEcg7/Byehhhl0THIPiSPlo
         y4Cl7MRIfbDxIyF2AOBL2MM/2dZuogyGwSSv+9eCjlE2TFydq7/gO0fJJSS6+OfGFa1y
         g0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754472088; x=1755076888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yY4YwA/qFjuotXlPIX+a7dTmxzeDOSaFsdvMOaOiE9k=;
        b=tFgA6uVLRcKZY0tScRDTVlRYrS9Vpn8hFo2nlDHaJ33dQYhFud3JI1/5QXWXNc8qM8
         MTb6qrMABMuAw+bTBPLqT/QbAtPuAqmDox8oRiXpHPyrLuzWG9KpRp23Ct6oSvRmyIio
         0BjrEx4MK/zMjfgMe1drYJ5YiNXumS/1j33cWFCJClk+iBI+uBaAdS+twR74qUDSoKxB
         FFm7VInA44HOgJ+MGkELslNDqMQTzn24Y97t7iA0o1UaidLktHkwjEFMm7Y6nZjGK3/Y
         iUQhSBPeP6uRcUiqpHttUdfPINP7p+gfPqGX5kQldKn48y6FfE+xz8m1G7ejD/U3malL
         qIbA==
X-Forwarded-Encrypted: i=1; AJvYcCUit5QmtyohpFzz7dir3SqLXAaA9Z67KKkj7H6UM/DE1KSwpEsOuawmQgXEf7q8EdaEZZ23pGzI2GINrzBb@vger.kernel.org, AJvYcCVGJqy1VTMSidTUwaW4CTZ7daijxJY80/uvkZWtHix1/EoNMNzFuDTVMPKSwRY9UeAKqWapSgZZY3OryVQh@vger.kernel.org, AJvYcCWkZS8KMwZDRJp4UIA5jcCdsI9UxzYJK8UgBWPRgRFdhTFgwaQJ5hZOLAM9gE/qWyYi6veR6n8bN6BI@vger.kernel.org
X-Gm-Message-State: AOJu0YxvJrYs5vX0qPNGO1fJ5xJVK1QnaRtsaYHjag7Bn0alv3ELQfHb
	d1Cd57xvylS6Mv9JW569B8yW6GguCJf7VCAu1AMIO6dI8Hl0I30OE/Hu2OiMZxQReS+9ieCL2OE
	etwO58F8mfETAT7el8idvImrM9cJFszM=
X-Gm-Gg: ASbGnctObggwOi3bBAzF5OHW+6OqHKAKs7y5r7nyxH9I7PV0uzDmYfz27ntN/Pf+nKE
	0ZRvxI+WBaBsJOw/KUy+OH41fJN1ebPxMDfJ8599BNShZ8S8VKQXF7DQ/kBCa3/LDwM6pwh9qUS
	ufz/uI9/bXPTFgEdrxof8pBMs4YhApPWD3UhOftjQis2waAbi55bXq1+iDX6uSl8gUoYOrg7Oua
	eIh
X-Google-Smtp-Source: AGHT+IGN/gOBcogpSJRsc2A7JS5JQSe9wrOEMm8cDNGCz+Hjlek29HqRf5I5tyltthewUZrrLIpiZmfetr5PH6MNQPs=
X-Received: by 2002:a17:903:4b4c:b0:23f:ade1:2227 with SMTP id
 d9443c01a7336-2429ee83783mr33649535ad.12.1754472088204; Wed, 06 Aug 2025
 02:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250804180525.32658-1-ltykernel@gmail.com> <83ae59ce-99f9-45b2-b6f8-4b4859b191c2@linux.microsoft.com>
In-Reply-To: <83ae59ce-99f9-45b2-b6f8-4b4859b191c2@linux.microsoft.com>
From: Tianyu Lan <ltykernel@gmail.com>
Date: Wed, 6 Aug 2025 17:20:52 +0800
X-Gm-Features: Ac12FXxdiw3qsSWG9m8EP3b0XHdtj8yHeKwFZNiqM5dMZuZRUa04qamH4rQNt9U
Message-ID: <CAMvTesB2gr04ASSmLOCueNrL5a-WY_G9-yVfz5=Ha+2zzM20PA@mail.gmail.com>
Subject: Re: [RFC PATCH V5 0/4] x86/Hyper-V: Add AMD Secure AVIC for Hyper-V platform
To: Naman Jain <namjain@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org, 
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, arnd@arndb.de, 
	Neeraj.Upadhyay@amd.com, kvijayab@amd.com, Tianyu Lan <tiala@microsoft.com>, 
	linux-arch@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 6, 2025 at 1:42=E2=80=AFPM Naman Jain <namjain@linux.microsoft.=
com> wrote:
>
>
>
> On 8/4/2025 11:35 PM, Tianyu Lan wrote:
> > From: Tianyu Lan <tiala@microsoft.com>
> >
> > Secure AVIC is a new hardware feature in the AMD64
> > architecture to allow SEV-SNP guests to prevent the
> > hypervisor from generating unexpected interrupts to
> > a vCPU or otherwise violate architectural assumptions
> > around APIC behavior.
> >
> > Each vCPU has a guest-allocated APIC backing page of
> > size 4K, which maintains APIC state for that vCPU.
> > APIC backing page's ALLOWED_IRR field indicates the
> > interrupt vectors which the guest allows the hypervisor
> > to send.
> >
> > This patchset is to enable the feature for Hyper-V
> > platform. Patch "Drivers: hv: Allow vmbus message
> > synic interrupt injected from Hyper-V" is to expose
> > new fucntion hv_enable_coco_interrupt() and device
> > driver and arch code may update AVIC backing page
> > ALLOWED_IRR field to allow Hyper-V inject associated
> > vector.
> >
> > This patchset is based on the AMD patchset "AMD: Add
> > Secure AVIC Guest Support"
> >
>
>
> NIT:
> Generally RFC tag is meant to be used for the patches which are probably
> not ready for merging, and is mostly intended for having a discussion
> around your changes. Since this is now reviewed by multiple people and
> have gone through multiple versions already, if you feel this can be
> merged, you can remove RFC tags in next version, if you are planning to
> send it.
>
Hi Naman:
     Thanks for your review and suggestion. This patchset is based on
the AMD Secure AVIC
driver patchset.which is still with RFC tag. I will remove the RFC tag
of this patchset after AMD
patchset merged.
.
...
Thanks
Tianyu Lan

