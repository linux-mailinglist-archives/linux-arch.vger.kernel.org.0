Return-Path: <linux-arch+bounces-10528-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89EA50647
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 18:24:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7136171168
	for <lists+linux-arch@lfdr.de>; Wed,  5 Mar 2025 17:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D501A4F09;
	Wed,  5 Mar 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rqkMtVXf"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 648C3567D;
	Wed,  5 Mar 2025 17:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741195462; cv=none; b=jtDYypJGsTrceahhwB/uZBbQHt6xZmH3AIoYnXh4OVHOdWK/Q91g9f/GLfQVZBbofhCtNCIsxQgpOJQkBfApnZXQr0YNjWVbAO6BtWcFOLGlXT7fE8sPOwWqBaF/GrsOmpkxsFZm7Iztft/l80TECDdQwpPdFJcA+SO/ZMVhncE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741195462; c=relaxed/simple;
	bh=d8g7Fnqwhipc5xBxy3Gqewe8IbTpMj/xPZKsLrJx1u8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=faMxXcNgPykqIpsVHdtBUPxHWDcVQcZK9M2aLOPLDGPEXx64IBwkt6yAnuqUZVgXj/sS/o3g3MoKqE/bLopyO6knwejDwvOrsFDdFBkR8id5BeXusM8vvWiYxnzsUedP8+88gjEI2Hsf6h0BEC2O8Z4HUZWo0UXYDn1Wd/oIbB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rqkMtVXf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C0A1C4CED1;
	Wed,  5 Mar 2025 17:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741195461;
	bh=d8g7Fnqwhipc5xBxy3Gqewe8IbTpMj/xPZKsLrJx1u8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rqkMtVXf5DKj/P1imw/sGyIR+tYbgd5TkAwWMwRC9+QbFwSBP1RVLsHIqPsSNwPnL
	 a5M7O5jaMCdfZY+VzNdFP/oolMCJd686Lh2dEy2TqcSw12c0NoB3Ogyp7NgArw8J7x
	 FWFE8O1zvlCUnA0+dA2V0ku56UfHtT3J1ul4G3clD1A1kTSOEGSr3WY7yaNA46UkDS
	 2XIaMDOXfMtfvctw3c2AQf1V04N/HmuuqzfxYHSE27H9QjtHhBhR6GO9QSjI3hP7lG
	 wZVol58EcKzB7lAtHsTK1sGghLo+rwZFIfxvTiNo7o084VjuId4Fvpy1m2B0u5lno5
	 S9pR2ndK6cmCQ==
Date: Wed, 5 Mar 2025 17:24:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/7] PCI: hv: Use hv_hvcall_*() to set up hypercall
 arguments
Message-ID: <Z8iIxJxpjf-vDvYA@liuwe-devbox-debian-v2>
References: <20250226200612.2062-7-mhklinux@outlook.com>
 <20250227202951.GA615709@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227202951.GA615709@bhelgaas>

On Thu, Feb 27, 2025 at 02:29:51PM -0600, Bjorn Helgaas wrote:
> On Wed, Feb 26, 2025 at 12:06:11PM -0800, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > Update hypercall call sites to use the new hv_hvcall_*() functions
> > to set up hypercall arguments. Since these functions zero the
> > fixed portion of input memory, remove now redundant calls to memset().
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Since most of this series touches arch/x86/hyperv/ and drivers/hv/, I
> assume this will be merged via some non-PCI tree.

Yes, I will pick this up after the whole series is reviewed and acked.

Thanks,
Wei.

