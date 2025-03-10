Return-Path: <linux-arch+bounces-10657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 86786A5A674
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:51:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 16FB7189199B
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177491E503C;
	Mon, 10 Mar 2025 21:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TT+lO1Qk"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834601DE4E9;
	Mon, 10 Mar 2025 21:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741643477; cv=none; b=OakSiyAwEeel+xjMFD1p/CZtZmBmkncq8qT3FjWBS91lYMF3jxsyEJopzdskQYKx8Dk5aq8zmZXjeqeeDdsXBNeUX6UYcohRHG6Fmk+xW+d+xK6WqStJeBl1px4okLVO3uQNzNk7PMpeQxXlJJT9g/V5lEuD1JNLxUOLJ8I/bac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741643477; c=relaxed/simple;
	bh=hXCrW9pe+dUqg8wNg0kcSMi2VRWhmX6+kqEVPaFJuYA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=URrpO7x+iRv6Jgvo1+m/RqrYa70yGFxy4Ke9gX2MhH3vYYE3ELJGtiA9WFkoPdGoPe4V66IW9YNhZ6FdJYxSE10mNMgoMqAv+mf/xbcg3ctYUDYsGh/W19nskh+WWyL2jrm1PwMPZl56P7MrhzWO3YQBgS8T80IPvd2J1LaUEaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TT+lO1Qk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.137.184.60] (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98773205492D;
	Mon, 10 Mar 2025 14:51:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98773205492D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1741643475;
	bh=CxBan6eozJpDLKwZggyW95t2iKrqkZanUVsz1ehRWhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TT+lO1Qkb57TcjEIhxY4F+l2wYJmYHzFaj7ayZ9g7xvAQsdDrmYcQK9Ej2gn0RaSs
	 xhnnqQMavD31GklMUF3oaiAJoINYrEA7cZYEESQf87FouU3UCvSVlls+bERu+2cXrO
	 2OmBWEwso8ixhFEUfoeG8ZgkHC0vwFQ9cME0HxIs=
Message-ID: <2eb4e538-d131-4adf-b61a-998d56128183@linux.microsoft.com>
Date: Mon, 10 Mar 2025 14:51:14 -0700
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v5 07/11] dt-bindings: microsoft,vmbus: Add
 interrupts and DMA coherence
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
 catalin.marinas@arm.com, conor+dt@kernel.org, dave.hansen@linux.intel.com,
 decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
 joey.gouly@arm.com, krzk+dt@kernel.org, kw@linux.com, kys@microsoft.com,
 lenb@kernel.org, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
 mark.rutland@arm.com, maz@kernel.org, mingo@redhat.com,
 oliver.upton@linux.dev, rafael@kernel.org, robh@kernel.org,
 ssengar@linux.microsoft.com, sudeep.holla@arm.com, suzuki.poulose@arm.com,
 tglx@linutronix.de, wei.liu@kernel.org, will@kernel.org,
 yuzenghui@huawei.com, devicetree@vger.kernel.org, kvmarm@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org,
 apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
 sunilmut@microsoft.com
References: <20250307220304.247725-1-romank@linux.microsoft.com>
 <20250307220304.247725-8-romank@linux.microsoft.com>
 <20250310-demonic-ferret-of-judgment-5dbdbf@krzk-bin>
 <c7f9d861-f617-4064-8c98-2ace06e9c25e@linux.microsoft.com>
 <09d4966a-5804-40a4-9c5f-356a954a7704@kernel.org>
 <ba6b906d-04a2-423d-a527-9ef7ab1dccf2@linux.microsoft.com>
 <ff3739bb-a223-401e-9b70-a5201839b72c@kernel.org>
Content-Language: en-US
From: Roman Kisel <romank@linux.microsoft.com>
In-Reply-To: <ff3739bb-a223-401e-9b70-a5201839b72c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/2025 2:17 PM, Krzysztof Kozlowski wrote:
> On 10/03/2025 19:07, Roman Kisel wrote:
>>
>> It is modeled as a bus in the kernel:
>> https://www.kernel.org/doc/html/latest/virt/hyperv/vmbus.html
>>
>>> Please upstream bindings for the bus devices and extend the example here
>>> with these devices.
>>
>> The set of synthetic devices that reside on the bus isn't fixed, and
>> they don't require description neither in ACPI nor in DT as
>> the devices negotiate their MMIO regions through the hyperv driver.
>>
>> Perhaps, it is not as much bus as expected by the YAML files.
> 
> OK, then this is not really a bus from the bindings point of view. It is
> a device schema which should end with additionalProperties: false.
> 
> If you have report about that pinctrl-0, it means you have undocumented
> properties in your DTS. Maybe that's the dma-coherence you mentioned in
> the commit msg.
> 

Much appreciated! I started reviewing the learning materials you
mentioned, and I think I already see where my understanding went
sideways: I perceived the example as the central part of the bindings
whereas it seems to be just what the name suggests: an example. Yet,
the example shall conform to the *schema* iiuc, and that is what the
tooling validates.

Hopefully, I am starting to be getting what this is all about :)
Thanks for your help again!

I've worked out what makes (more) sense (to me at least):

 From 475fb74b49dc4987ca8b9117186941d848f0aacd Mon Sep 17 00:00:00 2001
From: Roman Kisel <romank@linux.microsoft.com>
Date: Mon, 10 Mar 2025 14:39:41 -0700
Subject: [PATCH] dt-bindings: microsoft,vmbus: Add interrupt and DMA
   coherence properties

To boot in the VTL mode, VMBus on arm64 needs interrupt description
which the binding documentation lacks. The transactions on the bus are
DMA coherent which is not mentioned as well.

Add the interrupt property and the DMA coherence property to the VMBus
binding. Update the example to match that. Fix typos.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
  .../bindings/bus/microsoft,vmbus.yaml           | 17 +++++++++++++++--
  1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml 
b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
index a8d40c766dcd..b175ad01f219 100644
--- a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -10,8 +10,8 @@ maintainers:
    - Saurabh Sengar <ssengar@linux.microsoft.com>

  description:
-  VMBus is a software bus that implement the protocols for communication
-  between the root or host OS and guest OSs (virtual machines).
+  VMBus is a software bus that implements the protocols for communication
+  between the root or host OS and guest OS'es (virtual machines).

  properties:
    compatible:
@@ -25,9 +25,17 @@ properties:
    '#size-cells':
      const: 1

+  dma-coherent: true
+
+  interrupts:
+    maxItems: 1
+    description: |
+      This interrupt signals a message from the host.
+
  required:
    - compatible
    - ranges
+  - interrupts
    - '#address-cells'
    - '#size-cells'

@@ -35,6 +43,8 @@ additionalProperties: false

  examples:
    - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
      soc {
          #address-cells = <2>;
          #size-cells = <1>;
@@ -49,6 +59,9 @@ examples:
                  #address-cells = <2>;
                  #size-cells = <1>;
                  ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+                dma-coherent;
+                interrupt-parent = <&gic>;
+                interrupts = <GIC_PPI 2 IRQ_TYPE_EDGE_RISING>;
              };
          };
      };
-- 
2.43.0


> 
> Best regards,
> Krzysztof

-- 
Thank you,
Roman


