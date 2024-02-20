Return-Path: <linux-arch+bounces-2523-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F1285C639
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 21:59:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA8FC1F23A55
	for <lists+linux-arch@lfdr.de>; Tue, 20 Feb 2024 20:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA54F151CCC;
	Tue, 20 Feb 2024 20:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xor8CRcT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vVXMvjvM"
X-Original-To: linux-arch@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22EC314C585;
	Tue, 20 Feb 2024 20:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708462755; cv=none; b=EoVoF+eF2o9QdjJAklOVs2RLC03RJxKYNyGKkdj3Mi/4yrP5/fmVvxrRq54PbKxz6qlGqUF6EecSNvMvkw2bnFCcCVjjsB0GTfI3qJPexKumuDTv0Bu0aBv5wVSJnQ3IrXqjvXkxW4gIJnrWRoIdRGc/44CzYYsnRfvUBu8JT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708462755; c=relaxed/simple;
	bh=CSn0rR47mTrgEc8Sk301bbhncZGvmRgYv2wKD0Szc6Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SVseV3QdP2MaeM8IKaQSYx5rOvVRL661EuOaMngRknO2P9nQEDTYZMIrmTsEtEBxPot2EsI/mghOqNjctIc3rFh6Z5atshVbtGf3yCZmOFGiiu4fJ8iKpETj2ouwd3FnFtV/WksYBWP74V4uNIdGRs34GwTIxAJC+I3WDDsYSgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xor8CRcT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vVXMvjvM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708462752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u21hqSyJPPttI5Wdupn9KsZ7LFUwPOf3FZzwjE066uA=;
	b=Xor8CRcTwPTSqaxO4FKKslN2jk/ojHSNTHculGtpBB1jNcLDtzMdKPK63WYFU5RZ57HQnI
	1uUoRztjwmqAbJqm/zBXBUrDkRbHGYGSJrioW6qIirJEtOtpKudjOyABlOQf3CoTreafDe
	Ip6of8Jvp7Fnd4kqiY/lPPzvzRbjCqzEwA3ZSvyF2wWyf8xRuXexUeeA973E1shLXl40u5
	1Jryfkg+L42BhQshHC3pwvG/4XzuBLzJ4paCnYcWRjdAPk85/SkILxv9Y4Q4bGPMSRHj4d
	bNrxxtCnn5zexBkWu36nHZdJgSY5c3eXo9pVdGY+tbnLeTXm1yDR9PlOYu4SHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708462752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u21hqSyJPPttI5Wdupn9KsZ7LFUwPOf3FZzwjE066uA=;
	b=vVXMvjvMnysVR+MWyo88LUHR5L6hT2UjdH5RZFhI+vY6FsaskvDlA/wloCfWkR9QnRegP1
	fGX+SdVpvh9+a8DA==
To: "Rafael J. Wysocki" <rafael@kernel.org>, Russell King
 <rmk+kernel@armlinux.org.uk>
Cc: linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
 linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev, x86@kernel.org,
 acpica-devel@lists.linuxfoundation.org, linux-csky@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, jianyong.wu@arm.com,
 justin.he@arm.com, James Morse <james.morse@arm.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH RFC v4 02/15] ACPI: processor: Register all CPUs from
 acpi_processor_get_info()
In-Reply-To: <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
 <E1rVDmU-0027YP-Jz@rmk-PC.armlinux.org.uk>
 <CAJZ5v0iiJpUWq5GMSnKFWQTzn_bdwoQz9m=hDaXNg4Lj_ePF4g@mail.gmail.com>
Date: Tue, 20 Feb 2024 21:59:11 +0100
Message-ID: <87h6i2hmxs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15 2024 at 20:22, Rafael J. Wysocki wrote:
> On Wed, Jan 31, 2024 at 5:50=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
>> diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
>> index 47de0f140ba6..13d052bf13f4 100644
>> --- a/drivers/base/cpu.c
>> +++ b/drivers/base/cpu.c
>> @@ -553,7 +553,11 @@ static void __init cpu_dev_register_generic(void)
>>  {
>>         int i, ret;
>>
>> -       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES))
>> +       /*
>> +        * When ACPI is enabled, CPUs are registered via
>> +        * acpi_processor_get_info().
>> +        */
>> +       if (!IS_ENABLED(CONFIG_GENERIC_CPU_DEVICES) || !acpi_disabled)
>>                 return;
>
> Honestly, this looks like a quick hack to me and it absolutely
> requires an ACK from the x86 maintainers to go anywhere.

That should work, but yes I agree it's all but pretty.

