Return-Path: <linux-arch+bounces-10893-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 659C0A636D4
	for <lists+linux-arch@lfdr.de>; Sun, 16 Mar 2025 18:37:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE72A7A630F
	for <lists+linux-arch@lfdr.de>; Sun, 16 Mar 2025 17:36:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F0751DAC81;
	Sun, 16 Mar 2025 17:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5JfoeYj"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6F11AA1D9;
	Sun, 16 Mar 2025 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742146618; cv=none; b=oUf4uxszi6xTsMr93KgZTt+MmEnAgfWTrFNGMOTftoyn3OW/OT6qyPEMTGFpkEk6aBNUgPwSI7vATGvv2fTwCb7xovUF1qrlPhHkCwC41p4UQ3zOt0zD3+SP9HoDgxlDJj8qXvWhsGDvT2PdFPZ1sTfvsPY3jf5XIXSLJp0ifsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742146618; c=relaxed/simple;
	bh=SykknbCWIe+4iAlW2oyUTP1j/isvxfybnvUnqUuCmXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lREwdNauZxto3qzOfqPctA/g9IaUZntthP1PHirouTNeOAmP6gTORY+PZkAQOq/fqrrL5VZJ+BZ5pZMwjhMqYhRRwkSAVQZYUCOukjHxoRcZzPCJCSgRqbsU7FRH1c7Db9j74TO6LFfDOamZt10NsfV5SJP/eZGARb1daVduMOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5JfoeYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754B0C4CEDD;
	Sun, 16 Mar 2025 17:36:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742146617;
	bh=SykknbCWIe+4iAlW2oyUTP1j/isvxfybnvUnqUuCmXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5JfoeYjXVe72cOJuVO+ZB67RBdb/EnWyoZtxffEL9ivnl+kBKYj2cgGoxJCG0TRb
	 tZ4xQo1xjYoDIgSiNWmDhxXRAp4PelD2A8D2XXTKnpbRfh9BauM4FPwhYbvrmM9Rls
	 2sbNaBgDqAf/U4QtCVq20wW9YbRcpT48TALGHWRW/c5muHrjvxmxYonLSX7f5Db5FT
	 sN1Ggo+/TRsMPZiQH41KpcbQEkRYHDExUCImkK/ok19rHkZ+zi0kagauLhx4CAdTny
	 Fmn+g8PWEAy1stUZSOeuHdqAwRc9IjUAWwpiO4WI0WWR86yJ50Z3UMjQe7R01UExSQ
	 wG6u3d7Egwvlw==
Date: Sun, 16 Mar 2025 18:36:53 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, 
	catalin.marinas@arm.com, conor+dt@kernel.org, dan.carpenter@linaro.org, 
	dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com, 
	joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, 
	lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev, 
	rafael@kernel.org, robh@kernel.org, ssengar@linux.microsoft.com, 
	sudeep.holla@arm.com, suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org, 
	will@kernel.org, yuzenghui@huawei.com, devicetree@vger.kernel.org, 
	kvmarm@lists.linux.dev, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, x86@kernel.org, apais@microsoft.com, benhill@microsoft.com, 
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v6 07/11] dt-bindings: microsoft,vmbus: Add
 interrupt and DMA coherence properties
Message-ID: <20250316-versed-trogon-of-serendipity-bf7ea7@krzk-bin>
References: <20250315001931.631210-1-romank@linux.microsoft.com>
 <20250315001931.631210-8-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250315001931.631210-8-romank@linux.microsoft.com>

On Fri, Mar 14, 2025 at 05:19:27PM -0700, Roman Kisel wrote:
>  
> +  dma-coherent: true
> +
> +  interrupts:

> +    maxItems: 1
> +    description: |
> +      This interrupt is used to report a message from the host.

These could be just two lines:

items:
  - description: Interrupt used to report a message from the host.

(and note that just like we do not use "This" in commit msg, there is
really no benefit of using it in hardware descruption for simple
statements)

Regardless:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


