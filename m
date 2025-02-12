Return-Path: <linux-arch+bounces-10130-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F25A31F40
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 07:42:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C64EF188C4B6
	for <lists+linux-arch@lfdr.de>; Wed, 12 Feb 2025 06:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5134D1FCFF2;
	Wed, 12 Feb 2025 06:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XJHzF+Vz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA9C1FCF4F;
	Wed, 12 Feb 2025 06:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739342553; cv=none; b=iJHvuDMCmGDcl4vcZ3WrO8nFlt98tl9tbplneCIPKUzmAoFVCjY+bAb8rXy9BZq+7bFk7TDjCm1wxqcXmZiUG3xY1HU6VRqkrMBhx7YnVjZ4rRU1aDxyY1586/OzUodOEEe3Ukhr//f2lMUp51kQqpnVcXsep4nuLTDiqJSBPdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739342553; c=relaxed/simple;
	bh=gcWrlH4VJdCzAwzQ0TQ13bD5T421NNpIotpvRoe8/0s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzRzV1neg+FOsd473NZmFZGj0Nf+ROKeoX+h6mODC3B+nFNwe4jIXiBYJBX5IneGttI1CstFh0qk4fUbanLOOz1K87Tq7eJfPSpQDOnPc4sdnLFQPFEy6PUjGF5xUkBj5+SEFqlEBpNV7k8nj5lcK9ZwDRvP/uyK20blkyWli0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJHzF+Vz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EF6C4CEDF;
	Wed, 12 Feb 2025 06:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739342552;
	bh=gcWrlH4VJdCzAwzQ0TQ13bD5T421NNpIotpvRoe8/0s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XJHzF+VzfFWlp4P1JPrUMCQkbJ5KBGLBnHIArBL2rm8chHQT3+YCoPK4OJRy5r7E3
	 sAEvp7f7Om4wRIuJbEio3qwxlaK3G6jul9C+7mhkn+/CcOPn94KJGKuYMJNv4kBrB9
	 iyu0wu+S5Pof3d5E6GJVuoEPQE0wwdWUJY3opqtFifXLHL3cOus7Plu+nJbBT25k6Z
	 MLozZWZUL+9x2+p6l1ZevMJfiIYKEVfvQADJL7cew3LCDAreCs1eXEpQof9x5Sqj/D
	 D/2n2MOO/76zGJrkaqFhCTWkj5d65Lh9hCqXduyTu+7RL200etCIuJx6zTQ6XwCouc
	 GTngHdXyvPRoQ==
Date: Wed, 12 Feb 2025 07:42:28 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, 
	catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com, 
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com, krzk+dt@kernel.org, 
	kw@linux.com, kys@microsoft.com, lpieralisi@kernel.org, 
	manivannan.sadhasivam@linaro.org, mingo@redhat.com, robh@kernel.org, ssengar@linux.microsoft.com, 
	tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, devicetree@vger.kernel.org, 
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	x86@kernel.org, benhill@microsoft.com, bperkins@microsoft.com, 
	sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v4 4/6] dt-bindings: microsoft,vmbus: Add GIC
 and DMA coherence to the example
Message-ID: <20250212-rough-terrier-of-serendipity-68a0db@krzk-bin>
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-5-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250212014321.1108840-5-romank@linux.microsoft.com>

On Tue, Feb 11, 2025 at 05:43:19PM -0800, Roman Kisel wrote:
> The existing example lacks the GIC interrupt controller property
> making it not possible to boot on ARM64, and it lacks the DMA

GIC controller is not relevant to this binding.

> coherence property making the kernel do more work on maintaining
> CPU caches on ARM64 although the VMBus trancations are cache-coherent.
> 
> Add the GIC node, specify DMA coherence, and define interrupt-parent
> and interrupts properties in the example to provide a complete reference
> for platforms utilizing GIC-based interrupts, and add the DMA coherence
> property to not do extra work on the architectures where DMA defaults to
> non cache-coherent.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  .../devicetree/bindings/bus/microsoft,vmbus.yaml      | 11 +++++++++++
>  1 file changed, 11 insertions(+)

Last time I said: not tested by automation.
Now: I see automation build failures, although I do not see anything
incorrect in the code, so that's a bit surprising. Please confirm that
binding was tested on latest dtschema.

> 
> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> index a8d40c766dcd..5ec69226ab85 100644
> --- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> @@ -44,11 +44,22 @@ examples:
>              #size-cells = <1>;
>              ranges;
>  
> +            gic: intc@fe200000 {
> +              compatible = "arm,gic-v3";
> +              reg = <0x0 0xfe200000 0x0 0x10000>,   /* GIC Dist */
> +                    <0x0 0xfe280000 0x0 0x200000>;  /* GICR */
> +              interrupt-controller;
> +              #interrupt-cells = <3>;
> +            }

I fail to see how this is relevant here. This is example only of vmbus.
Look how other bindings are done. Drop the example.


> +
>              vmbus@ff0000000 {
>                  compatible = "microsoft,vmbus";
>                  #address-cells = <2>;
>                  #size-cells = <1>;
>                  ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
> +                dma-coherent;
> +                interrupt-parent = <&gic>;
> +                interrupts = <1 2 1>;

Use proper defines for known constants.

Best regards,
Krzysztof


