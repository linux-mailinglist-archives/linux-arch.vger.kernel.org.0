Return-Path: <linux-arch+bounces-178-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18ED57E9372
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 01:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A706B1C2037A
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 00:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B481A23A1;
	Mon, 13 Nov 2023 00:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULED0Udk"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CDEA1FAE
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 00:04:18 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CAE41FEA
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 16:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699833856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1WVqrzwlUh2mFk7/OXOeRxfOSDsmH8Tq2hZjVjJnnk=;
	b=ULED0UdkevXxnpA529ii6wMpCVsfN8KO7P6nj/NfqSRyTgrRXPxf1+HFa8aVupeZHx/uG8
	/HG1+S69vheKq+lRm84cXzO1vrkc3/XHKZxib1McgCTLqMesKaBEIXAaHDru4j7tjaYiUB
	g2lIIjgzwY/J18hOz6z/GadyCIqFTYk=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-wDzv9_B1N76d7EabQ0yNhA-1; Sun, 12 Nov 2023 19:04:14 -0500
X-MC-Unique: wDzv9_B1N76d7EabQ0yNhA-1
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-5c17cff57f9so982168a12.0
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 16:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699833854; x=1700438654;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M1WVqrzwlUh2mFk7/OXOeRxfOSDsmH8Tq2hZjVjJnnk=;
        b=fNhdEjPf96rBLitDJShpO8qYG8DBW4owdi/p0EXlwUMEiBKMcxwf51Rx9UkEO93S8E
         r1YmG65/UTuDNjH7vmKkLoOQa2aXyAfFvkmRZLojG74ynB4KW1oKZJRnTE9i2bMLZlcR
         utPmi2tiRyRN9zDtHNOS768U4vRfhlRkIhSjGS7dNbR8H/JI+lUqsiSW1pyy1P2rU0VG
         Cza1nu8Y0QauEk+hm/hjFYDQ3aigdrOEXc2e4i5wwtRm4JUTj6zRqlP3HWSea9o/w+oU
         wYyQkH8XKBM8O2C2hdumbVxL5bu4CBVtSfG3SWgkM0IXOKLkrBn4rWKcxlT5DZ5FdXYQ
         X2+Q==
X-Gm-Message-State: AOJu0YzC7+pKQTgW+1Dfhk98WIv8LcHYqoxIYmf4dagOFLv62i3duGak
	vlJwXZ+TGLTS/B6Np9xNoQWr+wdUaPf1ZttQ2IR+cr9cpxPindypuwTAu137oMxX1CBvlUAlUNm
	aRj0K1K/uouAFMmF8vZ0QrA==
X-Received: by 2002:a05:6a20:4b17:b0:180:eef7:b3bf with SMTP id fp23-20020a056a204b1700b00180eef7b3bfmr2894320pzb.52.1699833853853;
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFVhoHB7vfaN82g5SuEmn8wzwgzjtloVlrEIKNxLO/QhN9bWo7fbjYF4amHORPXU4K9sObvCw==
X-Received: by 2002:a05:6a20:4b17:b0:180:eef7:b3bf with SMTP id fp23-20020a056a204b1700b00180eef7b3bfmr2894294pzb.52.1699833853518;
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id jj3-20020a170903048300b001cc29ffcd96sm3038705plb.192.2023.11.12.16.04.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 16:04:13 -0800 (PST)
Message-ID: <cf5a08b3-c8f0-438e-a7ba-c34d684dac42@redhat.com>
Date: Mon, 13 Nov 2023 10:04:06 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 01/22] arch_topology: Make
 register_cpu_capacity_sysctl() tolerant to late CPUs
Content-Language: en-US
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 linux-csky@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKl-00CTwT-Hx@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JKl-00CTwT-Hx@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:29, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> register_cpu_capacity_sysctl() adds a property to sysfs that describes
> the CPUs capacity. This is done from a subsys_initcall() that assumes
> all possible CPUs are registered.
> 
> With CPU hotplug, possible CPUs aren't registered until they become
> present, (or for arm64 enabled). This leads to messages during boot:
> | register_cpu_capacity_sysctl: too early to get CPU1 device!
> and once these CPUs are added to the system, the file is missing.
> 
> Move this to a cpuhp callback, so that the file is created once
> CPUs are brought online. This covers CPUs that are added late by
> mechanisms like hotplug.
> One observable difference is the file is now missing for offline CPUs.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
> If the offline CPUs thing is a problem for the tools that consume
> this value, we'd need to move cpu_capacity to be part of cpu.c's
> common_cpu_attr_groups.
> ---
>   drivers/base/arch_topology.c | 38 ++++++++++++++++++++++++------------
>   1 file changed, 26 insertions(+), 12 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


