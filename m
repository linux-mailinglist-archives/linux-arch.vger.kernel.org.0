Return-Path: <linux-arch+bounces-198-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4BC7E9615
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 05:21:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B3B1C2031B
	for <lists+linux-arch@lfdr.de>; Mon, 13 Nov 2023 04:21:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ED66F9E8;
	Mon, 13 Nov 2023 04:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qaj4AD4N"
X-Original-To: linux-arch@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD30C8DB
	for <linux-arch@vger.kernel.org>; Mon, 13 Nov 2023 04:21:09 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FFD1172B
	for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1699849267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jFv0/+ZJ8QcMT7pXMYPj0XHvwSazMYJli5PQ5trCgZ4=;
	b=Qaj4AD4NWKE02XqzY43tk91B/sswBOd2Iaa7CDvvK9RX7AJq6iKzrFnwVIBmoCyKqZLQz+
	iQAbrTX7p+hqX6eL5R3MIcF9l/AKF2VilS19989CxMIBVXslNvJ17EDHqxOwWenmcIaLJ7
	ONvZksy4WMM+D70tOPh9kCnWn9VobPU=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-D6ogsnu9OcSXleIO9xwnrw-1; Sun, 12 Nov 2023 23:21:04 -0500
X-MC-Unique: D6ogsnu9OcSXleIO9xwnrw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-da0cb98f66cso4820182276.2
        for <linux-arch@vger.kernel.org>; Sun, 12 Nov 2023 20:21:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699849264; x=1700454064;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFv0/+ZJ8QcMT7pXMYPj0XHvwSazMYJli5PQ5trCgZ4=;
        b=e7nxGdw8ii73naGlpj9Ua3Z8SONn+N043w8XELUJHEMr4ecMMMtFqNNd+y+BfjSJ2B
         3sivtQfu4HR4vm2CHAKnD0gt41oe3925xq8TAq7stUTGqaBfvNhGm/I6FfkCmN62Wp8P
         mZNLpBkAZSBE+BYroGz0KPnfeXxyDj1qRPepqtbtqzMo9iQPDMhkrSe9i3ZdgjrrEHps
         Uaipn67XYTYcKYtPZ9I75F/9NOibhkPwNx9GtC9Q2MBy+nEBrmP/sUfYBz3KmM41LQfp
         gQS6Tjvmbe5KSr1fiGRDsw5jNkBI6yN/k8Wdyjk0fU/5N4ky/4yoZdmINClPaHlnqR0c
         rUlg==
X-Gm-Message-State: AOJu0YywwkNZ7eYbGYLK8x3o+jmVv4//DRAwkUFUffH4hleDClRrbIec
	T1AYXWIYBuu1i7fw030aLU4lhmbo0/+Qo0Ca9sP6zqDj74PhkMKyAhxNQkfZ59ObiyO5YSGgLDw
	ZPKDtMbHtLet4ePmaDD5Gyg==
X-Received: by 2002:a05:6902:1547:b0:d43:a84f:a6aa with SMTP id r7-20020a056902154700b00d43a84fa6aamr5454590ybu.39.1699849264123;
        Sun, 12 Nov 2023 20:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuE/Omh7ETDkhtAEC+3zelpWf91MkxxlfVCO0FA1pnNxNCnMWL4q2N7gIaAN7fVOCOVWdIYg==
X-Received: by 2002:a05:6902:1547:b0:d43:a84f:a6aa with SMTP id r7-20020a056902154700b00d43a84fa6aamr5454579ybu.39.1699849263873;
        Sun, 12 Nov 2023 20:21:03 -0800 (PST)
Received: from ?IPV6:2001:8003:e5b0:9f00:b890:3e54:96bb:2a15? ([2001:8003:e5b0:9f00:b890:3e54:96bb:2a15])
        by smtp.gmail.com with ESMTPSA id fm6-20020a056a002f8600b006c4db182074sm3111661pfb.196.2023.11.12.20.20.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Nov 2023 20:21:03 -0800 (PST)
Message-ID: <227771fa-1f22-4b9d-81f5-709f4f0c68c9@redhat.com>
Date: Mon, 13 Nov 2023 14:20:55 +1000
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 18/22] LoongArch: Switch over to GENERIC_CPU_DEVICES
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
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JMB-00CTyJ-08@rmk-PC.armlinux.org.uk>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <E1r0JMB-00CTyJ-08@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/7/23 20:30, Russell King (Oracle) wrote:
> From: James Morse <james.morse@arm.com>
> 
> Now that GENERIC_CPU_DEVICES calls arch_register_cpu(), which can be
> overridden by the arch code, switch over to this to allow common code
> to choose when the register_cpu() call is made.
> 
> This allows topology_init() to be removed.
> 
> This is an intermediate step to the logic being moved to drivers/acpi,
> where GENERIC_CPU_DEVICES will do the work when booting with acpi=off.
> 
> This is a subtle change. Originally:
> - on boot, topology_init() would have marked present CPUs that
>    io_master() is true for as hotplug-incapable.
> - if a CPU is hotplugged that is an io_master(), it can later be
>    hot-unplugged.
> 
> The new behaviour is that any CPU that io_master() is true for will
> now always be marked as hotplug-incapable, thus even if it was
> hotplugged, it can no longer be hot-unplugged.
> 
> This patch also has the effect of moving the registration of CPUs from
> subsys to driver core initialisation, prior to any initcalls running.
> 
> Signed-off-by: James Morse <james.morse@arm.com>
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> Changes since RFC v2:
>   * Explain the change in behaviour in the patch description
>     (highlighted by Jonathan Cameron - thanks.) Add note about
>     initialisation order change.
> ---
>   arch/loongarch/Kconfig           |  1 +
>   arch/loongarch/kernel/topology.c | 29 ++---------------------------
>   2 files changed, 3 insertions(+), 27 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


