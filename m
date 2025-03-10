Return-Path: <linux-arch+bounces-10604-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF49A58FA1
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 10:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 054803AC8DB
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 09:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8F52253E6;
	Mon, 10 Mar 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moRUW5ZQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F82253A7;
	Mon, 10 Mar 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741598929; cv=none; b=jT9sAHGBtI88I7itggDIKZ6dh/DqlW21K/ebQk1hQKQ+SwSripX9ia6xOgpXgkJNq9FH0qR/zfn1/2ikNdLhumkQt1E9NrOnZGxv76V4RoVlR8PLMvfFVam8yZUpRlsLj7u/6pm/tk/RUa4uo12jKRC1yMBeqZ8kOI0Sdl8sg+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741598929; c=relaxed/simple;
	bh=5mwoTd08jCfdUhN4DoQ/o5bTO+/4KPbpIou7ZLK5CwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzRqZHjxEwhj8LswIctDdtLWV4r6ogvy2p60FQ08raHR6xqCCSpi2RDJbu6nOMrSBBxufMCO6MhhbzJ9Cr8iU5qn3yAhB3K+/Ddzjl76JU96TqmV9kSBG0RtJXWro40nuc9a1esClJaV7BJ8NO83pGEtnBJiblgmcfK6EJ37jPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moRUW5ZQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3263C4CEE5;
	Mon, 10 Mar 2025 09:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741598928;
	bh=5mwoTd08jCfdUhN4DoQ/o5bTO+/4KPbpIou7ZLK5CwE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=moRUW5ZQ40mb3/aIpiaUN9HkU77pvem3k8eDxlSM/9lZUaUKukj4CqhZvUe9L77zC
	 MN+2vbTMTU3+BLE/2ld0UBhKQS5/ba81SV2HVw+ZA3Yz3md1rj9n1oi/rIFpS0ceFQ
	 /omVZU4PqA9TWL9LfJuqg6P7RCJQ6/BrSt2q3h2CoPNyi/He613YCzZB27Pff6NEjc
	 YXtecGZz5NtbHWv7fAKwgV9RUZ+ou62yHAHyS6MQV1nL5vhT4TzAPYYIv5ECh/jAne
	 /yZ6tNsiGfzxvB4H1/ph9rTQtybZmAJtNlXrF3KTZChZqotBBafZrkqj9bmZ4otaFP
	 DxO9pUqVWT11A==
Date: Mon, 10 Mar 2025 10:28:44 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Roman Kisel <romank@linux.microsoft.com>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, 
	catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com, 
	decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com, joey.gouly@arm.com, 
	krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, lenb@kernel.org, 
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, mark.rutland@arm.com, 
	maz@kernel.org, mingo@redhat.com, oliver.upton@linux.dev, rafael@kernel.org, 
	robh@kernel.org, ssengar@linux.microsoft.com, sudeep.holla@arm.com, 
	suzuki.poulose@arm.com, tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org, 
	yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	x86@kernel.org, apais@microsoft.com, benhill@microsoft.com, 
	bperkins@microsoft.com, sunilmut@microsoft.com
Subject: Re: [PATCH hyperv-next v5 07/11] dt-bindings: microsoft,vmbus: Add
 interrupts and DMA coherence
Message-ID: <20250310-demonic-ferret-of-judgment-5dbdbf@krzk-bin>
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-8-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250307220304.247725-8-romank@linux.microsoft.com>

On Fri, Mar 07, 2025 at 02:02:59PM -0800, Roman Kisel wrote:
> To boot on ARM64, VMBus requires configuring interrupts. Missing
> DMA coherence property is sub-optimal as the VMBus transations are
> cache-coherent.
> 
> Add interrupts to be able to boot on ARM64. Add DMA coherence to
> avoid doing extra work on maintaining caches on ARM64.

How do you add it?

> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  .../devicetree/bindings/bus/microsoft,vmbus.yaml          | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> index a8d40c766dcd..3ab7d0116626 100644
> --- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> +++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
> @@ -28,13 +28,16 @@ properties:
>  required:
>    - compatible
>    - ranges
> +  - interrupts
>    - '#address-cells'
>    - '#size-cells'
>  
> -additionalProperties: false
> +additionalProperties: true

This is neither explained in commit msg nor correct.

Drop the change. You cannot have device bindings ending with 'true'
here - see talks, example-bindings, writing-schema and whatever resource
is there.

Best regards,
Krzysztof


