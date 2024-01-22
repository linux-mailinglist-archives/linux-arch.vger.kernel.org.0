Return-Path: <linux-arch+bounces-1427-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9E3836FE8
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 19:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111391F2AB01
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jan 2024 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5F851C23;
	Mon, 22 Jan 2024 18:00:20 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8814851023;
	Mon, 22 Jan 2024 18:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705946420; cv=none; b=COhhDyP3I0brm5h6VOn3XOFfDk7henD/Vkk9Rh2HVGKouaNvo2hl9PKnE0CzQU6hvnsFQ0ox9O8eI51UGWS8yaIrbRdyKta/xHGpyO0sB7bvsRApiwizSk6FXMDGHSsAUMuFbK+f35fHaU6bki18IAXlPUqW1ZGh0c9hSTnBgkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705946420; c=relaxed/simple;
	bh=1QPBYp1cuVlPzvmIrkvDtRmi9tk3BbCt5QfOkc4KoTA=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oNYcKz0LIXIuDfoVseADQ+wbhY/PxzZL+hDYsVttKEi4SsPnzZaEvgJeVY86/PdCMllRsfJ7z+6xvqJFvlpntca6QpEyLQvycsXODO/hMhE8btP6tezSbS1hs/wPOfifpYHKKmWXlqhUbH54CNAbwQOnuWcay96BUo5/yZ1Kumw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TJdGS60Srz67ZCr;
	Tue, 23 Jan 2024 01:57:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id DA1F61400F4;
	Tue, 23 Jan 2024 02:00:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 22 Jan
 2024 18:00:14 +0000
Date: Mon, 22 Jan 2024 18:00:13 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: Russell King <rmk+kernel@armlinux.org.uk>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<kvmarm@lists.linux.dev>, <x86@kernel.org>,
	<acpica-devel@lists.linuxfoundation.org>, <linux-csky@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-ia64@vger.kernel.org>,
	<linux-parisc@vger.kernel.org>, Salil Mehta <salil.mehta@huawei.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, <jianyong.wu@arm.com>,
	<justin.he@arm.com>, James Morse <james.morse@arm.com>
Subject: Re: [PATCH RFC v3 05/21] ACPI: Rename ACPI_HOTPLUG_CPU to include
 'present'
Message-ID: <20240122180013.000016d5@Huawei.com>
In-Reply-To: <CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
References: <ZXmn46ptis59F0CO@shell.armlinux.org.uk>
	<E1rDOgD-00Dvk2-3h@rmk-PC.armlinux.org.uk>
	<CAJZ5v0g9nfLrEf9u4Ksw6BOWJQ9iv8Z-O8RsLU6jR5zk0ahxRw@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Dec 2023 21:35:16 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Dec 13, 2023 at 1:49=E2=80=AFPM Russell King <rmk+kernel@armlinux=
.org.uk> wrote:
> >
> > From: James Morse <james.morse@arm.com>
> >
> > The code behind ACPI_HOTPLUG_CPU allows a not-present CPU to become
> > present. =20
>=20
> Right.
>=20
> > This isn't the only use of HOTPLUG_CPU. On arm64 and riscv
> > CPUs can be taken offline as a power saving measure. =20
>=20
> But still there is the case in which a non-present CPU can become
> present, isn't it there?

Not yet defined by the architectures (and I'm assuming it probably never wi=
ll be).

The original proposal we took to ARM was to do exactly that - they pushed
back hard on the basis there was no architecturally safe way to implement i=
t.
Too much of the ARM arch has to exist from the start of time.

https://lore.kernel.org/linux-arm-kernel/cbaa6d68-6143-e010-5f3c-ec62f879ad=
95@arm.com/
is one of the relevant threads of the kernel side of that discussion.

Not to put specific words into the ARM architects mouths, but the
short description is that there is currently no demand for working
out how to make physical CPU hotplug possible, as such they will not
provide an architecturally compliant way to do it for virtual CPU hotplug a=
nd
another means is needed (which is why this series doesn't use the present b=
it
for that purpose and we have the Online capable bit in MADT/GICC)

It was a 'fun' dance of several years to get to that clarification.
As another fun fact, the same is defined for x86, but I don't think
anyone has used it yet (GICC for ARM has an online capable bit in the flags=
 to
enable this, which was remarkably similar to the online capable bit in the
flags of the Local APIC entries as added fairly recently).

>=20
> > On arm64 an offline CPU may be disabled by firmware, preventing it from
> > being brought back online, but it remains present throughout.
> >
> > Adding code to prevent user-space trying to online these disabled CPUs
> > needs some additional terminology.
> >
> > Rename the Kconfig symbol CONFIG_ACPI_HOTPLUG_PRESENT_CPU to reflect
> > that it makes possible CPUs present. =20
>=20
> Honestly, I don't think that this change is necessary or even useful.

Whilst it's an attempt to avoid future confusion, the rename is
not something I really care about so my advice to Russell is drop
it unless you are attached to it!

Jonathan


>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel


