Return-Path: <linux-arch+bounces-4754-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A50900CA2
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 21:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5548287793
	for <lists+linux-arch@lfdr.de>; Fri,  7 Jun 2024 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CF8914E2FF;
	Fri,  7 Jun 2024 19:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NETPHZm7"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B36A50263;
	Fri,  7 Jun 2024 19:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717790104; cv=none; b=Mwy1BrKI1wFJxNIhgUva1QeKg0cvK63dRE1sMCIoYhOTfvh6Ydxe0cB8TuCNdGUELHZYjb5roq2/k+tib0TFCw8an5t0gcBaRMpVC1HV/E6o70KdloZFP27rkfzsw8c4IMkWxDw8VB8Sk+xdhyUCMiQGuTLAaMF8kErgd/k3Yp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717790104; c=relaxed/simple;
	bh=56EznWOcTzBf8BvoIJw9+sktcRe3Ewf5qCLugsw5GDA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=hjiKMAlETdMDWbiCMCZosjrapapaHLxFM3bzoHD9wl5tPJByONarCWmMnuSovLcC6VeYPIDQPfX+F/uWEDYMGLNvnUe8wjAE+8vSRmn2qOcW3FiUlM/Kv34rq+MtK8TFdFU5Tc5mqP6qqQjIK0WxkWp9lbRK6s/rH1JkkXADJZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NETPHZm7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE48C2BBFC;
	Fri,  7 Jun 2024 19:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717790103;
	bh=56EznWOcTzBf8BvoIJw9+sktcRe3Ewf5qCLugsw5GDA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NETPHZm70yDZDAggk+X9Y3lyR50VhHmwYq0to80tbj6yxNOpIQtkd/HHO1NbSP6uh
	 rjj4rMBcouFf0euj7SIJmVVsN1vkkwOK65I1H5LioiVegBnwB8f8DCFfq1k9p/JsZ7
	 sqDvYXm/pCudZ/PYZ5iCXtvIAqizPCH5/UbydNtg2vt+4cENuRic6LlQXZE28yh6dQ
	 kGJsGP4YTKEto/95SvGbzqTslRwI41vR2816UsZecDWu76fzAWZrCJY37KaHALQlIe
	 fAPX0mtRSMhKGP8NoeZRfkq7E+8biGHyRKX8NCzNuKct/7zpFBT8DWPttOKY7pUnIO
	 sK6P8eb4Zxdzw==
Date: Fri, 7 Jun 2024 14:55:01 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, arnd@arndb.de,
	bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
	dave.hansen@linux.intel.com, decui@microsoft.com,
	haiyangz@microsoft.com, hpa@zytor.com, kw@linux.com,
	kys@microsoft.com, lenb@kernel.org, lpieralisi@kernel.org,
	mingo@redhat.com, mhklinux@outlook.com, rafael@kernel.org,
	robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
	will@kernel.org, linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, x86@kernel.org, ssengar@microsoft.com,
	sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v2 6/6] drivers/pci/hyperv/arm64: vPCI MSI IRQ domain
 from DT
Message-ID: <20240607195501.GA858122@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515181238.GA2129352@bhelgaas>

On Wed, May 15, 2024 at 01:12:38PM -0500, Bjorn Helgaas wrote:
> On Wed, May 15, 2024 at 09:34:09AM -0700, Roman Kisel wrote:
> > 
> > 
> > On 5/15/2024 2:48 AM, Saurabh Singh Sengar wrote:
> > > On Tue, May 14, 2024 at 03:43:53PM -0700, Roman Kisel wrote:
> > > > The hyperv-pci driver uses ACPI for MSI IRQ domain configuration
> > > > on arm64 thereby it won't be able to do that in the VTL mode where
> > > > only DeviceTree can be used.
> > > > 
> > > > Update the hyperv-pci driver to discover interrupt configuration
> > > > via DeviceTree.
> > > 
> > > Subject prefix should be "PCI: hv:"

I forgot to also suggest that the subject line begin with a verb,
e.g., "Get vPCI MSI IRQ domain from DT" or similar, again so it reads
consistently with previous commits.

Oh, I see patch 5/6, "Get the irq number from DeviceTree" is also very
similar.  It would be nice if they matched, e.g., both used "IRQ" and
"DT".

Bjorn

