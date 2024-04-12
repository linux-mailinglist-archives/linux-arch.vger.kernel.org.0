Return-Path: <linux-arch+bounces-3648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374E8A38DF
	for <lists+linux-arch@lfdr.de>; Sat, 13 Apr 2024 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6FA628568F
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 23:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99F7152516;
	Fri, 12 Apr 2024 23:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tW6ap+zQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C6bVqxHC"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BB9225D7;
	Fri, 12 Apr 2024 23:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712964233; cv=none; b=HEuBLnCz5ho+C6Nr9p6HLdP9LFqDxEOyf+WomaDzzGinXeQ0G1RC+HTu6cDrLjC5GU2WXebPr/b7GtrIQN/zzBRUS1FuujgVM46aoNItevlgPg5+esm3EH8F9MqffPNUiD1CwEfn03wrwn+UC3Bf+cHlZBBMIAzd8Xzm2ST/w/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712964233; c=relaxed/simple;
	bh=CbK4jt4ZdUloJNuVh6KOM2ueno3wxztt8Qa5vgstwIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PwLx5P2uiQode9/rlPdVsm0S0/NihuwcKmScsrOnS6auK+GM+v2gT+8x+LzhNyWqQQyOxiJShttW9an50wNFXW5IPv2LesEi2zdeBr7A0WZhAYkkaKbhBUMByTIenVN3yFGwx7cI6ClQYsz20jaSSOhBEPnj60nPi4LtrRuQYtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tW6ap+zQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C6bVqxHC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712964230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5xu2FVtNRnOIqknb2Ux4D1eBvHtL7IvYUAUi+UDnWI=;
	b=tW6ap+zQjCfPb0Iu5NRfFG9LND9NrDkPfEJWzzMV7FCLTiO/67DEBwqkhnToa6FAcP2EMM
	6MUD2W5m6nuwV2lpFNG3h+9zzeXDVM+p+g58Cp/G+e4GRZcfa5YXlQCXsvhowZhIeayP0F
	mX0bfZnV7zatQ27FSiwCVDCNzdKFDc9OqpMidB2qf2Cpn4vHrQKR1CDd5Jo0Vu7BskZTIr
	zk34+SsJ8yxAruaTIUuw2IA0vIdHj/NMRshMO3Ypq0Afb5kNOeHECSYmsLQEyGEwXiqLV8
	1HqLCmjoZ7R9k59MXcM+5pSKlvvx5MjGxECT/fcNGhgdh8TjLYqmzvmpqlulZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712964230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=T5xu2FVtNRnOIqknb2Ux4D1eBvHtL7IvYUAUi+UDnWI=;
	b=C6bVqxHCPN+wfRrnH1w7K16dZrgwWFLb9vxFt3+t2PJptgUt5gh64ablXIU/tU1hN5ia0j
	DVRgHQA0LBs0mhCA==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, linux-pm@vger.kernel.org,
 loongarch@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
 x86@kernel.org, Miguel Luis <miguel.luis@oracle.com>, James Morse
 <james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linuxarm@huawei.com, justin.he@arm.com, jianyong.wu@arm.com
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
In-Reply-To: <ZhmtO6zBExkQGZLk@shell.armlinux.org.uk>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk> <87bk6ez4hj.ffs@tglx>
 <ZhmtO6zBExkQGZLk@shell.armlinux.org.uk>
Date: Sat, 13 Apr 2024 01:23:48 +0200
Message-ID: <878r1iyxkr.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Russell!

On Fri, Apr 12 2024 at 22:52, Russell King (Oracle) wrote:
> On Fri, Apr 12, 2024 at 10:54:32PM +0200, Thomas Gleixner wrote:
>> > As for the cpu locking, I couldn't find anything in arch_register_cpu()
>> > that depends on the cpu_maps_update stuff nor needs the cpus_write_lock
>> > being taken - so I've no idea why the "make_present" case takes these
>> > locks.
>> 
>> Anything which updates a CPU mask, e.g. cpu_present_mask, after early
>> boot must hold the appropriate write locks. Otherwise it would be
>> possible to online a CPU which just got marked present, but the
>> registration has not completed yet.
>
> Yes. As far as I've been able to determine, arch_register_cpu()
> doesn't manipulate any of the CPU masks. All it seems to be doing
> is initialising the struct cpu, registering the embedded struct
> device, and setting up the sysfs links to its NUMA node.
>
> There is nothing obvious in there which manipulates any CPU masks, and
> this is rather my fundamental point when I said "I couldn't find
> anything in arch_register_cpu() that depends on ...".
>
> If there is something, then comments in the code would be a useful aid
> because it's highly non-obvious where such a manipulation is located,
> and hence why the locks are necessary.

acpi_processor_hotadd_init()
...
         acpi_map_cpu(pr->handle, pr->phys_id, pr->acpi_id, &pr->id);

That ends up in fiddling with cpu_present_mask.

I grant you that arch_register_cpu() is not, but it might rely on the
external locking too. I could not be bothered to figure that out.

>> Define "real hotplug" :)
>> 
>> Real physical hotplug does not really exist. That's at least true for
>> x86, where the physical hotplug support was chased for a while, but
>> never ended up in production.
>> 
>> Though virtualization happily jumped on it to hot add/remove CPUs
>> to/from a guest.
>> 
>> There are limitations to this and we learned it the hard way on X86. At
>> the end we came up with the following restrictions:
>> 
>>     1) All possible CPUs have to be advertised at boot time via firmware
>>        (ACPI/DT/whatever) independent of them being present at boot time
>>        or not.
>> 
>>        That guarantees proper sizing and ensures that associations
>>        between hardware entities and software representations and the
>>        resulting topology are stable for the lifetime of a system.
>> 
>>        It is really required to know the full topology of the system at
>>        boot time especially with hybrid CPUs where some of the cores
>>        have hyperthreading and the others do not.
>> 
>> 
>>     2) Hot add can only mark an already registered (possible) CPU
>>        present. Adding non-registered CPUs after boot is not possible.
>> 
>>        The CPU must have been registered in #1 already to ensure that
>>        the system topology does not suddenly change in an incompatible
>>        way at run-time.
>> 
>> The same restriction would apply to real physical hotplug. I don't think
>> that's any different for ARM64 or any other architecture.
>
> This makes me wonder whether the Arm64 has been barking up the wrong
> tree then, and whether the whole "present" vs "enabled" thing comes
> from a misunderstanding as far as a CPU goes.
>
> However, there is a big difference between the two. On x86, a processor
> is just a processor. On Arm64, a "processor" is a slice of the system
> (includes the interrupt controller, PMUs etc) and we must enumerate
> those even when the processor itself is not enabled. This is the whole
> reason there's a difference between "present" and "enabled" and why
> there's a difference between x86 cpu hotplug and arm64 cpu hotplug.
> The processor never actually goes away in arm64, it's just prevented
> from being used.

It's the same on X86 at least in the physical world.

Thanks,

        tglx


