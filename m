Return-Path: <linux-arch+bounces-10933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 27F93A67D95
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 21:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4243E168BBB
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 20:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD141F3BBF;
	Tue, 18 Mar 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W8CMW4Sb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415B21C6FEF;
	Tue, 18 Mar 2025 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328006; cv=none; b=M5ZTT5Mu8PLXmqH3mXM9dG9BhZcfCVxEszae39DcT/kUQGjmsmnDEUROug5jlU47IgGD1H5xfy3ZPV+3pqnU2SRodBKT4tbEf3ry05orPif4jTNO9a12+ZLti5ybGs5+/pqPNr3Pj2YrKvX/feAEbN7PiGvFD48uBkbFw10eBNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328006; c=relaxed/simple;
	bh=Y/2xEtmkfsoeIb+pWq/yApZzp3YJlOna3PHwfKPj15s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qH2J49jPdNgfaZy+wYdp4lSGV7ALFp2Cu5G7Z4Ak4sNZKmtGm2xjQIB6A3FSSnA2XJKjC58ACvihdFe0tilVm2H079N4708BlN4Wp0yYIg8gx7nlUEoiFa7bkbRsVdkttSYahM2T/7gdUrVD9HwiUlGAobqwtxVOFRypTeJCjnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W8CMW4Sb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7696AC4CEDD;
	Tue, 18 Mar 2025 20:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742328006;
	bh=Y/2xEtmkfsoeIb+pWq/yApZzp3YJlOna3PHwfKPj15s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=W8CMW4SbhoLJ1qJQydd+E40Hvg1k1ouVSNCTmG19aZJjqSJ457xlJPtsj195oejkp
	 b2u70JnOPpwZ0gOYWDHsHB9Vd9rJelnV0o/7VU7K/dhSXUkicJFDUA+AOHwh+VvdyP
	 wv6yShDX6SRAnW1eKQZv2WqK6AasnrMgTTsgr9/OVrnV4KR9LmaoVOn2irAt1QTPxY
	 IVvINHhbWOgoYE7PQq2cFg/HjClFkkXhcdhxgHNHKET/ii6WVl//o8z4kY9joodW6q
	 DA/b7wUTLoszGxhZ2/499D69PbgDduxHxbFmQok9ccnfAoNJY9YNGYDWx/Vg07Kb/W
	 VkpLZg0pI8LOw==
Date: Tue, 18 Mar 2025 20:00:04 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"ltykernel@gmail.com" <ltykernel@gmail.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"jeff.johnson@oss.qualcomm.com" <jeff.johnson@oss.qualcomm.com>,
	"kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>,
	"bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"prapal@linux.microsoft.com" <prapal@linux.microsoft.com>,
	"anrayabh@linux.microsoft.com" <anrayabh@linux.microsoft.com>,
	"rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>,
	"corbet@lwn.net" <corbet@lwn.net>
Subject: Re: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Message-ID: <Z9nQxOD1N2HZIyaF@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157261B9C4AA8CF89A30317D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157261B9C4AA8CF89A30317D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>

On Tue, Mar 18, 2025 at 07:54:49PM +0000, Michael Kelley wrote:
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March 14, 2025 12:29 PM
> >
> > Provide a set of IOCTLs for creating and managing child partitions when
> > running as root partition on Hyper-V. The new driver is enabled via
> > CONFIG_MSHV_ROOT.
> > 
> 
> [snip]
>  
> > +
> > +int
> > +hv_call_clear_virtual_interrupt(u64 partition_id)
> > +{
> > +	unsigned long flags;
> 
> This local variable is now unused and will generate a compile warning.

FWIW I noticed the same thing too and fixed them all while I committed
the patch.

Thanks,
Wei.

