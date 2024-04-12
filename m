Return-Path: <linux-arch+bounces-3646-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42AE58A3758
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 22:54:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A250CB2269C
	for <lists+linux-arch@lfdr.de>; Fri, 12 Apr 2024 20:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E13C446BD;
	Fri, 12 Apr 2024 20:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4inyeoqy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K69eqoT0"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74142D600;
	Fri, 12 Apr 2024 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712955276; cv=none; b=i3mu0EksJ9RDoNl0p74af+JozoHKLZfvgtaoyxMzDTUXHLnJgmZvK3HYYR6xMqSAdS7T/RvqRfOYL8Pai6VX+W3+GmDAs/ARG7Ifq5uk6CAh1PrbbRsiKh6CenSQGbFL++OcZRI2AYdGPUPE5QA4FdVBoPZcXkgwcs8T263ucPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712955276; c=relaxed/simple;
	bh=hhUyIpqpk6o2zo0WNmlEhV8GXEcdBzbXTRRrprL9qy0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WBY1svULg53sZhdO4Deyaek3K3rzoumBlLCLeeab9iT9l0EFB1RCkxitau8n1WwKmQsgCc0VJ0j4cYI2amh/UbHqNWhHs/HLbVI6W6Qxs+JIH/3FEpkD+sfxE+r9xuRtJoee0iivXvFyp/ZvxcrqrYlul36N16+dmC4ltbVRygA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4inyeoqy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K69eqoT0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1712955272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYNr9CZirRSWZqeBDz7mLZZYuH7MefaeEp2ihefL/4=;
	b=4inyeoqySqn696oIZQlb9IXUMxLGpByf7AJE7/CY3qCd+WjjkE8MjR2OKow6V0vZ7qLzwJ
	UZ+Z3xAvJ8LxU9A0fRQW+JlkXq2hlaYRtlDal7asbeGA5LeiC4jZHhVc3QdIauZLLAHox7
	/ViUdvsemMuvP5+RZYBl195exp6cIwTO0yekVxDM2JA8pBkPnrXcsmZQW5PN1xZKTB7yW0
	8Z4F95k9a4JoZWM5tsSVxImLVs6Wfk7WB5bkG/a9aiqCT3OYfswjoZnFG3EhOfp441eAxY
	lpWYte7RtW1FJk/uUAJeUX/o2WmjQZw9mI/NcIEqhOPgLNtycMHUFDMUkZ+eyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1712955272;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zFYNr9CZirRSWZqeBDz7mLZZYuH7MefaeEp2ihefL/4=;
	b=K69eqoT0yTN1N7e3SvOMWhl0A8acYvwWN5ZnRp0dVlstFtDzCgqLvKs7ylRIQnh26GWFqf
	iUuHNO8hLeSYkoAw==
To: "Russell King (Oracle)" <linux@armlinux.org.uk>, "Rafael J. Wysocki"
 <rafael@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 kvmarm@lists.linux.dev, x86@kernel.org, Miguel Luis
 <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>, Salil Mehta
 <salil.mehta@huawei.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, linuxarm@huawei.com, justin.he@arm.com,
 jianyong.wu@arm.com
Subject: Re: [PATCH v5 03/18] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
In-Reply-To: <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
References: <20240412143719.11398-1-Jonathan.Cameron@huawei.com>
 <20240412143719.11398-4-Jonathan.Cameron@huawei.com>
 <CAJZ5v0gNvy2e=hOGQQ2kLpnrDr8=QGBax-E5odEJ=7BA8qW-9A@mail.gmail.com>
 <ZhmWkE+fCEG/WFoi@shell.armlinux.org.uk>
Date: Fri, 12 Apr 2024 22:54:32 +0200
Message-ID: <87bk6ez4hj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 12 2024 at 21:16, Russell King (Oracle) wrote:
> On Fri, Apr 12, 2024 at 08:30:40PM +0200, Rafael J. Wysocki wrote:
>> Say acpi_map_cpu) / acpi_unmap_cpu() are turned into arch calls.
>> What's the difference then?  The locking, which should be fine if I'm
>> not mistaken and need_hotplug_init that needs to be set if this code
>> runs after the processor driver has loaded AFAICS.
>
> It is over this that I walked away from progressing this code, because
> I don't think it's quite as simple as you make it out to be.
>
> Yes, acpi_map_cpu() and acpi_unmap_cpu() are already arch implemented
> functions, so Arm64 can easily provide stubs for these that do nothing.
> That never caused me any concern.
>
> What does cause me great concern though are the finer details. For
> example, above you seem to drop the evaluation of _STA for the
> "make_present" case - I've no idea whether that is something that
> should be deleted or not (if it is something that can be deleted,
> then why not delete it now?)
>
> As for the cpu locking, I couldn't find anything in arch_register_cpu()
> that depends on the cpu_maps_update stuff nor needs the cpus_write_lock
> being taken - so I've no idea why the "make_present" case takes these
> locks.

Anything which updates a CPU mask, e.g. cpu_present_mask, after early
boot must hold the appropriate write locks. Otherwise it would be
possible to online a CPU which just got marked present, but the
registration has not completed yet.

> Finally, the "pr->flags.need_hotplug_init = 1" thing... it's not
> obvious that this is required - remember that with Arm64's "enabled"
> toggling, the "processor" is a slice of the system and doesn't
> actually go away - it's just "not enabled" for use.
>
> Again, as "processors" in Arm64 are slices of the system, they have
> to be fully described in ACPI before the OS boots, and they will be
> marked as being "present", which means they will be enumerated, and
> the driver will be probed. Any processor that is not to be used will
> not have its enabled bit set. It is my understanding that every
> processor will result in the ACPI processor driver being bound to it
> whether its enabled or not.
>
> The difference between real hotplug and Arm64 hotplug is that real
> hotplug makes stuff not-present (and thus unenumerable). Arm64 hotplug
> makes stuff not-enabled which is still enumerable.

Define "real hotplug" :)

Real physical hotplug does not really exist. That's at least true for
x86, where the physical hotplug support was chased for a while, but
never ended up in production.

Though virtualization happily jumped on it to hot add/remove CPUs
to/from a guest.

There are limitations to this and we learned it the hard way on X86. At
the end we came up with the following restrictions:

    1) All possible CPUs have to be advertised at boot time via firmware
       (ACPI/DT/whatever) independent of them being present at boot time
       or not.

       That guarantees proper sizing and ensures that associations
       between hardware entities and software representations and the
       resulting topology are stable for the lifetime of a system.

       It is really required to know the full topology of the system at
       boot time especially with hybrid CPUs where some of the cores
       have hyperthreading and the others do not.


    2) Hot add can only mark an already registered (possible) CPU
       present. Adding non-registered CPUs after boot is not possible.

       The CPU must have been registered in #1 already to ensure that
       the system topology does not suddenly change in an incompatible
       way at run-time.

The same restriction would apply to real physical hotplug. I don't think
that's any different for ARM64 or any other architecture.

Hope that helps.

Thanks,

        tglx


