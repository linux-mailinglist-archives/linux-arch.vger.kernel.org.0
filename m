Return-Path: <linux-arch+bounces-15741-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84181D0D01C
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 06:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41513302BAB0
	for <lists+linux-arch@lfdr.de>; Sat, 10 Jan 2026 05:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06EFD33ADBA;
	Sat, 10 Jan 2026 05:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GqdhVuZw"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188F02E3AF1;
	Sat, 10 Jan 2026 05:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768023568; cv=none; b=rIo6UnUvvTj/vU+JyPpozVz1ULIuNDS+4YOoDsv6FwcwHXGB4Cx/QOdHrQecs7kyuz2KiLHtER0paLPnspShBnV6loDPNGtGlQRI29EwD72tbVt+IjMfOqv9HYSUPzeA+6tfZPDi2adMFgJ+HiA1oPTNCJx9W4CZKHRebOSzdLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768023568; c=relaxed/simple;
	bh=2BHcjtIMLvlJmmOCTiTVp0+PLNbzIbX2st/yYOaJOqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j40N+1eQth095R77ytRFZRT8k9WL+gDGfVMyZOWPQDWz7NXGIfY4xVjsfpGc1ER6ZPPlRXoqtBhuAle8t4o84eR5ZKuQV+vHTxwUgs/qJLSiL7yY71QPDE6P0l+OB/YQ3ACw21FE/sI2DF+4m8nl8L/sEzpzugt9j+QK2uAnc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GqdhVuZw; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from localhost (unknown [167.220.232.230])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1EBA8201AC7F;
	Fri,  9 Jan 2026 21:39:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1EBA8201AC7F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1768023560;
	bh=KWtDmLvDpKCPNcDWUK2m8f4j92ZR5hgvsVRpqpbilTs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GqdhVuZwQQMoWIQy6Oyte9YIXPRt1Uy36KcoGZ6oXhIoc9+Vqhl+BIaxLVigIn6fB
	 5YJ84aon8u5Ml2qYEaD7kM7pazyNBaZ8a/7tN7S5HfkH/Hh1HY9z+cMAanl+V2rHeL
	 tfaC/wVaXBT/RgGnh9NMDjm0LkmPbsHImQwudGAo=
Date: Sat, 10 Jan 2026 13:39:18 +0800
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>, 
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>, 
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>, 
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>, 
	"arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org" <joro@8bytes.org>, 
	"will@kernel.org" <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>, 
	"easwar.hariharan@linux.microsoft.com" <easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>, 
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>, 
	"peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [RFC v1 0/5] Hyper-V: Add para-virtualized IOMMU support for
 Linux guests
Message-ID: <engj6x3koovijgbh6vvmki3xbd4dtetejenlcgu4bqg7bwi762@h2ovu62se4ee>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <SN6PR02MB4157342641D173ABE9B4F1FED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157342641D173ABE9B4F1FED485A@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jan 08, 2026 at 06:45:52PM +0000, Michael Kelley wrote:
> From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 2025 9:11 PM
> > 
> > This patch series introduces a para-virtualized IOMMU driver for
> > Linux guests running on Microsoft Hyper-V. The primary objective
> > is to enable hardware-assisted DMA isolation and scalable device
> 
> Is there any particular meaning for the qualifier "scalable" vs. just
> "device assignment"? I just want to understand what you are getting
> at.
> 

Sorry for the ambiguity.
I intended to highlight two primary use cases for pvIOMMU:
- to enable in-kernel DMA protection within the guest.
- to allow device assignment to guest user space (e.g., via VFIO).

I avoided using the phrase "device assignment" alone, because people may be
confused if the main purpose of introducing pvIOMMU is for device assignment
to a L1 guest(which actually does not depend on any virtual IOMMU) or to a
L2 nested guest(altough I guess w/ pvIOMMU, it should work but we've never
tested that case and are not aware any such requirement).

And you are right, simply adding "scalable" didn't help clarify this.
I will rephrase the commit message. Thanks!

B.R.
Yu

