Return-Path: <linux-arch+bounces-11292-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC703A7CAAC
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 19:15:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A323F3B7DD7
	for <lists+linux-arch@lfdr.de>; Sat,  5 Apr 2025 17:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188B217C220;
	Sat,  5 Apr 2025 17:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hIzf27S0"
X-Original-To: linux-arch@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C44182BC;
	Sat,  5 Apr 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743873335; cv=none; b=XvtYM+iLkmyUr1MjKLdpt7IaEWZbGIy1XhLBPGCWi4HjMKBp3vyJZtAQeMjM8qCzrUq8mlBpgdylr5BBPXw6fEenHN1a7HZ3kJX9q2uxvLgze17YkAj6uHHNJkCfRnW++dkfQePmSxFgU9Jk4FX2/ah89B53yS6gHtUjNSJeqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743873335; c=relaxed/simple;
	bh=b1IqaERcyii5vqNUAnyn0nLI0QHoRvGF/a+UIVRdmCo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=MHFW0U/KK0E9VGR3s1FoR24y80NB03TEtMnnKttC7JbBamVW7ColbyKwIk1GcyhiWFhNNH+oqisTQtfgKMbHG7VbplbEJpYkBhyW+gC3tBI+FUl47jpwz7Um4UusZKNpvfSwNSP/3/j8G/70hIVZC/GrHyqbwHJTC0cUSLDBnh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hIzf27S0; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5e5e63162a0so4918220a12.3;
        Sat, 05 Apr 2025 10:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743873331; x=1744478131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=isSd+kZScL6eZdRBnkO9dSwf+mmMPraP1IggRwVj8UY=;
        b=hIzf27S04y/xdCwoMfTBtEcZj30d1PYLEbWWnwuRx8YneFNAAS89zadBShpadwQVWU
         xIEzgz3JrRnrCOx0q4DrHBvuSr3p0Nhk6KFyK0U4MVhu3SitlM8x1klCTkatmFzav42k
         ub60I/v4aLok+iAD8Y4LklmABJCPmIcX55+qd4idBkwgq6hKgRiVIF4TAqDsm7ZTiIv9
         0GhZkzcjpOZCrPYenbm5Ca5GJYPRCxMcgKz36QoumRIHnkQmoqfcNCjBZXnwNQonIJkG
         VZTiJdOWRS8rFS7ugbxJAnoWQVZGOK7UzyldjMeOx+eOk6A0qXR0I1F9FrT6dA3s7Nea
         01BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743873331; x=1744478131;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=isSd+kZScL6eZdRBnkO9dSwf+mmMPraP1IggRwVj8UY=;
        b=wAysnZ4FInMughsCmJSfKG3zAmI1dBIOWRddCEyC5TD9Led4PBO0oGCHrMRhDSNW2k
         BDxvGBfx0VoG8e28/dCkF0l0FmkS5IEnED5r3u2B4MXBrV41Q4GUceSYzXU+F8NUKou5
         rL2hg/fjfc9/9rtnL6Om4oL+JG9MMHZIkWIJSLtshze26UNr69TVpvEgnH6IWNTLh2Nb
         K+OBKxu8oK6F1HbLiCOhcZoBnZfyJLfEW6KR37dj/5PLg8bY5+n7SwkiZMMw3Egcyt+S
         ZaQ9qJKPYA9twUDJdNRZBddpgWIL1QRVyJ2H/djXhMlUUbFJfcUsw+G5ALSTmJbqATOe
         NZ+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVzZyOyP4fLt2S/PYZC0asH5iB84wllQKUox8iA/QZJe3iRtl9cUwQSB6WiOCwZWjHy36iuoVdSXr0kYw==@vger.kernel.org, AJvYcCW8iGDJk43L3KsST5+RDBCsZmpzaaIWyLnRz+Twwq89TlNqAOLVBNURqadcRaOqKumTU328hlnBS7Ng0lPH@vger.kernel.org, AJvYcCWwkFHkWMzQcEvOgCeKq+5cHteaG9SfwRGB0TPp0JVeYWofiwg+81DDNQ7n9kEactTtyr0IwdwhmZoQ@vger.kernel.org, AJvYcCXfIkUUnY543LHOXr1HOJWK9X9P4Wj5bnX4P7xXHUTAjwIfKAsBdB3NMESv+UP9hXh1orY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyH9qGb2JLwjIrYKDSNwpX9HkABt9Sm/z3gsKgdxwZiUXLFqVib
	TaPg6wvPLfji9dWDPGaYRAkXVdCRRL7laGGwj/VlUXuyotjgnU7CJ4PxbzC8
X-Gm-Gg: ASbGncu+5Vs2nG/eWCPMjUzQmUfNXM9VTXw0d6qfxCujqmG0mawcrdoNX2T2U1ktwbf
	p/RIrUxpnS85SpnVJgU00th+ixDa3PZ2d/FD4Hs+NQYc989cn4rvQy3U2kuPYoZDZIHzBht8U1b
	h6fihwwrfok7vy+hyF/X5yKEnLZ8LEFvWsEbkrDOouYnfL4Tzu8Bbbd3hQxsYuRPJnrNiAOHCqg
	8nFNcBIMmombD846cgNtpCBKlrhRQYU+Z9sfAIUNhCAAqbNCMC9L8oL71uZp8kL5KfCuCgz974C
	x8xGEqScToSmXlSFuvNXkpUIkWN8xMaXwNYbCW6h0/xWHMVLmhDcaaiK/DT1+kgOnqbSgsndqv1
	x+BoIbN2N8BWIs4SooQlMyzxqHQ==
X-Google-Smtp-Source: AGHT+IEYMEj6vVipafSJra5qktqhabiYJ6Afca6i+XiA9t0i2eFoS2ovVKnUzZgGlq8Rm6N1mlmmsg==
X-Received: by 2002:a05:6402:358b:b0:5ec:cba6:7d82 with SMTP id 4fb4d7f45d1cf-5f0b3b5ff1cmr7092924a12.3.1743873331349;
        Sat, 05 Apr 2025 10:15:31 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4? ([2001:b07:5d29:f42d:f4b6:62bc:3e10:c9d4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f088085e3esm3913147a12.58.2025.04.05.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Apr 2025 10:15:31 -0700 (PDT)
Message-ID: <33e608d18c12fda45c922bc06ae9a49c2b3d777a.camel@gmail.com>
Subject: Re: [RFC PATCH v2 16/22] coco/tsm: Add tsm-guest module
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
Date: Sat, 05 Apr 2025 19:15:28 +0200
In-Reply-To: <20250218111017.491719-17-aik@amd.com>
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
> diff --git a/drivers/virt/coco/guest/tsm-guest.c
> b/drivers/virt/coco/guest/tsm-guest.c
> new file mode 100644
> index 000000000000..d3be089308e0
> --- /dev/null
> +++ b/drivers/virt/coco/guest/tsm-guest.c
> @@ -0,0 +1,291 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/module.h>
> +#include <linux/tsm.h>
> +
> +#define DRIVER_VERSION	"0.1"
> +#define DRIVER_AUTHOR	"aik@amd.com"
> +#define DRIVER_DESC	"TSM guest library"
> +
> +struct tsm_guest_subsys {
> +	struct tsm_subsys base;
> +	struct tsm_vm_ops *ops;
> +	void *private_data;
> +	struct notifier_block notifier;
> +};
> +
> +static int tsm_tdi_measurements_locked(struct tsm_dev *tdev)
> +{
> +	struct tsm_guest_subsys *gsubsys =3D (struct tsm_guest_subsys
> *) tdev->tsm;
> +	struct tsm_tdi_status tstmp =3D { 0 };
> +	struct tsm_tdi *tdi =3D tsm_tdi_get(tdev->physdev);
> +
> +	if (!tdi)
> +		return -EFAULT;
> +
> +	return gsubsys->ops->tdi_status(tdi, gsubsys->private_data,
> &tstmp);

Missing call to tsm_tdi_put().

