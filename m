Return-Path: <linux-arch+bounces-10142-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF77A34FEB
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 21:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0E2F7A10FC
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2025 20:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD2432661A7;
	Thu, 13 Feb 2025 20:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XeTAcxIr"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EC91FFC59;
	Thu, 13 Feb 2025 20:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479819; cv=none; b=OcY7C5uzb0MUvdiOEZnPWJwQOPBVeOpEWw47JCHhVMZN+BHo8SEJxHMi5gvZDV6sdXlPKWUD9ZeY/xBV8W190sdOZifI6ZoVGrkwW/ilVAI6ijN0U+R970W/RANR00ily/zNyVwBGHIbjtt+191UwbtuJ/89lfxVom/lluxzpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479819; c=relaxed/simple;
	bh=U90uAXy+tD0A67ngT98YeZk8dh7Nxm1Nq0igEW7awIg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=aftLjXNQB3KtSCk7CCTZOa91Y8L3h3cjghIKX5ql/a46yBSL4o5XqSZKdSP2omKi/gZhpZ2KOVVjytHKoqesihXdbN6jF8nmWm6oHHtHxQjGjaIbqnSXoB5283GOzd9x2TlngCetS8k71n0ZxdT/QAa7mCJGyXO/2dfRnTWf7hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XeTAcxIr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 83E82203F3E5;
	Thu, 13 Feb 2025 12:50:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 83E82203F3E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1739479817;
	bh=XzQPYU9YfHy6ub9VigT3rtdUgbT32pzX4StInrVw1E4=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=XeTAcxIrprlHTTTPMf8HhI8CE7pfNVAgM8QgQEmhFcRGXQvzr/nQBmciYK3jhEmJX
	 tydKjmyGSzh+NZdxKyYLSaHG4PGn5nB5buGjbO5npIVqSIGOlOpl5UP27xsVYpBKIQ
	 C2q46+OmyyevQ+L1KlcwRiLGpbRqE44dKts5w7gc=
Message-ID: <a10abb83-1bb2-4e62-b537-8b8948b055ea@linux.microsoft.com>
Date: Thu, 13 Feb 2025 12:50:17 -0800
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v4 4/6] dt-bindings: microsoft,vmbus: Add GIC
 and DMA coherence to the example
From: Roman Kisel <romank@linux.microsoft.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com, lpieralisi@kernel.org,
 manivannan.sadhasivam@linaro.org, mingo@redhat.com, robh@kernel.org,
 ssengar@linux.microsoft.com, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, devicetree@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 benhill@microsoft.com, bperkins@microsoft.com, sunilmut@microsoft.com
References: <20250212014321.1108840-1-romank@linux.microsoft.com>
 <20250212014321.1108840-5-romank@linux.microsoft.com>
 <20250212-rough-terrier-of-serendipity-68a0db@krzk-bin>
 <bb863c8f-a92c-42d0-abc4-ff0b92f701c2@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <bb863c8f-a92c-42d0-abc4-ff0b92f701c2@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/12/2025 3:57 PM, Roman Kisel wrote:
> 

[...]

Thank you for your guidance!! The below passes tests and addresses the
feedback you have provided. If no further comments from you, I'll
send the file in this form in the next version of the patch series (also
fixing the commit title and description).


# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
%YAML 1.2
---
$id: http://devicetree.org/schemas/bus/microsoft,vmbus.yaml#
$schema: http://devicetree.org/meta-schemas/core.yaml#

title: Microsoft Hyper-V VMBus

maintainers:
   - Saurabh Sengar <ssengar@linux.microsoft.com>

description:
   VMBus is a software bus that implement the protocols for communication
   between the root or host OS and guest OSs (virtual machines).

properties:
   compatible:
     const: microsoft,vmbus

   ranges: true

   '#address-cells':
     const: 2

   '#size-cells':
     const: 1

required:
   - compatible
   - ranges
   - interrupts
   - '#address-cells'
   - '#size-cells'

additionalProperties: true

examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     soc {
         #address-cells = <2>;
         #size-cells = <1>;
         bus {
             compatible = "simple-bus";
             #address-cells = <2>;
             #size-cells = <1>;
             ranges;

             vmbus@ff0000000 {
                 compatible = "microsoft,vmbus";
                 #address-cells = <2>;
                 #size-cells = <1>;
                 ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
                 dma-coherent;
                 interrupt-parent = <&gic>;
                 interrupts = <GIC_PPI 2 IRQ_TYPE_EDGE_RISING>;
             };
         };
     };


>> Best regards,
>> Krzysztof
> 

-- 
Thank you,
Roman


