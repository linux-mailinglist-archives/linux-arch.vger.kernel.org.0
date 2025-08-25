Return-Path: <linux-arch+bounces-13266-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA83FB34E33
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 23:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8933188FF60
	for <lists+linux-arch@lfdr.de>; Mon, 25 Aug 2025 21:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C183E283FDF;
	Mon, 25 Aug 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKEPMbMY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AF2279788;
	Mon, 25 Aug 2025 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756157980; cv=none; b=WU8JIMIa6cLk7/JC7yEpBLIBTAJOl8kw3enouXEOpeKcX2ZAeCTr7mRMC4LxMDsYtIcS/SIs3tmAHIwhMxBIqaPDKfc8jhE5mNqFskk0VR/PBQx5e9rYnmNzGMcX+pqtZ+OYg2awgI5+mskPuaUGDAIvoKvj5CL1jylkFyQ+ENs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756157980; c=relaxed/simple;
	bh=MG9Bb4UQgWVhZx2kRB/WCAjDANPHuaCZ8826xwcu2wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2cnkywprrLkfaQuJ9OdVq0RvvMtD0W1RJjqgXsS43JcCHsDzOA7i6kpz2zfdZ+8fHfPb+uiXQOa/NSJxEd63gGIn/Fk8ZA1shXFt8T060YK2njYEhF6LvUu6TxYwbHztGdV3EiSkwaDEhBVuAtm5YNvwOJImrBoDheyUvWVM7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKEPMbMY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FB8C4CEED;
	Mon, 25 Aug 2025 21:39:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756157980;
	bh=MG9Bb4UQgWVhZx2kRB/WCAjDANPHuaCZ8826xwcu2wc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKEPMbMY0aD1CAukK6E1AlUbdUp/OCG5fwf3b8TXhBOTYhFulm4weurYgreTly3o/
	 mLS5EKPUWsd1OqrIywwkG+FSRvPYtvTVzNbZQrDoY1kbDo4ogYXJL//x4Kjuqeokid
	 cq1NWo2wdOac2pUOSFfw5ZIBqzQsB28JCGUZL1KrefnK5gqgcrWk0sGKfxwmuU91DD
	 v2XLL5hNUSXChS9XhjYGTSomJIrrXokoi4THTThGgPlJ7ghCB6Flcl+dPhFIMFPyn1
	 nh6E3Xs3T6tNDwwHVrs7zIL04s9QcxMznfScu5h0OSYYB80MuUMzoBNRSlyYDOBLNA
	 56N5NIxOPnnMg==
Date: Mon, 25 Aug 2025 21:39:38 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 0/7] hyperv: Introduce new way to manage hypercall args
Message-ID: <aKzYGkmYywp-3PsP@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250415180728.1789-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415180728.1789-1-mhklinux@outlook.com>

On Tue, Apr 15, 2025 at 11:07:21AM -0700, mhkelley58@gmail.com wrote:
[...]
> 
> This patch set is built against linux-next20250411.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/tlfs
> 
> Michael Kelley (7):
>   Drivers: hv: Introduce hv_hvcall_*() functions for hypercall arguments
>   x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 1
>   x86/hyperv: Use hv_hvcall_*() to set up hypercall arguments -- part 2
>   Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments
>   PCI: hv: Use hv_hvcall_*() to set up hypercall arguments
>   Drivers: hv: Use hv_hvcall_*() to set up hypercall arguments for mshv
>     code
>   Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

I applied this series before but then there is a new discussion ongoing,
so I've dropped it from my tree for now until the discussion settles.

Wei

