Return-Path: <linux-arch+bounces-3926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5FA8B1005
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 18:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12D971F26AE1
	for <lists+linux-arch@lfdr.de>; Wed, 24 Apr 2024 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B92316D9A1;
	Wed, 24 Apr 2024 16:36:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8607C1598EA;
	Wed, 24 Apr 2024 16:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713976560; cv=none; b=ctnFOeO3ye3UBeRVo9MAZbWIYoDs4IXRGaKbBhPRAJOBCL8OXGAwNoWtt0Hptm0wk3rc4jOagqc91zSVXV2O3A1+/9XKaPHLfpSL6McIpToE6PysjoKSM4nzh2wulCcddUtobIX4W3Q90KGJTad/YewtOs9rGNFAee1TSBEml10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713976560; c=relaxed/simple;
	bh=UlhmmvF4qokJRQpaGwr/z557sqx6SfWJMcb3qZplI3s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PMfWDBL6/CgVxjUKo9rT3yJbC34h557pA1aSL2UonKixnZOLv4qE7vpCBdw7wAdWSbUwbuY3HfFjjOv187pqmvMev9qMLwhbeq2gBRO3ISDSof/TLkV05+qFvXJlQ37TMYbzbbgRudw7wfKp3lCMidV+kiYxlaPxpW5aC2cS7b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VPl0q61vXz6K5kn;
	Thu, 25 Apr 2024 00:33:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8886E1406AE;
	Thu, 25 Apr 2024 00:35:54 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 17:35:54 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Wed, 24 Apr 2024 17:35:54 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Marc Zyngier <maz@kernel.org>, Jonathan Cameron
	<jonathan.cameron@huawei.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, "linux-pm@vger.kernel.org"
	<linux-pm@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Linuxarm
	<linuxarm@huawei.com>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: RE: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's disabled
 but 'online capable' CPUs
Thread-Topic: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's disabled
 but 'online capable' CPUs
Thread-Index: AQHakZivrv7wCN4TwkObtNOE7FjxL7F0DvwAgAGo+ICAAaE4AIAALFkAgAAgu/A=
Date: Wed, 24 Apr 2024 16:35:54 +0000
Message-ID: <e149e79446be4ed99178eedda3e8a674@huawei.com>
References: <20240418135412.14730-1-Jonathan.Cameron@huawei.com>
	<20240418135412.14730-12-Jonathan.Cameron@huawei.com>
	<20240422114020.0000294f@Huawei.com>	<87plugthim.wl-maz@kernel.org>
	<20240424135438.00001ffc@huawei.com> <86il06rd19.wl-maz@kernel.org>
In-Reply-To: <86il06rd19.wl-maz@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

>  From: Marc Zyngier <maz@kernel.org>
>  Sent: Wednesday, April 24, 2024 4:33 PM
>  To: Jonathan Cameron <jonathan.cameron@huawei.com>
>  Cc: Thomas Gleixner <tglx@linutronix.de>; Peter Zijlstra
>  <peterz@infradead.org>; linux-pm@vger.kernel.org;
>  loongarch@lists.linux.dev; linux-acpi@vger.kernel.org; linux-
>  arch@vger.kernel.org; linux-kernel@vger.kernel.org; linux-arm-
>  kernel@lists.infradead.org; kvmarm@lists.linux.dev; x86@kernel.org;
>  Russell King <linux@armlinux.org.uk>; Rafael J . Wysocki
>  <rafael@kernel.org>; Miguel Luis <miguel.luis@oracle.com>; James Morse
>  <james.morse@arm.com>; Salil Mehta <salil.mehta@huawei.com>; Jean-
>  Philippe Brucker <jean-philippe@linaro.org>; Catalin Marinas
>  <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>; Linuxarm
>  <linuxarm@huawei.com>; Ingo Molnar <mingo@redhat.com>; Borislav
>  Petkov <bp@alien8.de>; Dave Hansen <dave.hansen@linux.intel.com>;
>  justin.he@arm.com; jianyong.wu@arm.com
>  Subject: Re: [PATCH v7 11/16] irqchip/gic-v3: Add support for ACPI's
>  disabled but 'online capable' CPUs
> =20
>  On Wed, 24 Apr 2024 13:54:38 +0100,
>  Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
>  >
>  > On Tue, 23 Apr 2024 13:01:21 +0100
>  > Marc Zyngier <maz@kernel.org> wrote:
>  >
>  > > On Mon, 22 Apr 2024 11:40:20 +0100,
>  > > Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
>  > > >
>  > > > On Thu, 18 Apr 2024 14:54:07 +0100 Jonathan Cameron
>  > > > <Jonathan.Cameron@huawei.com> wrote:
> =20
>  [...]
> =20
>  > > >
>  > > > > +	/*
>  > > > > +	 * Capable but disabled CPUs can be brought online later.  Wha=
t about
>  > > > > +	 * the redistributor? ACPI doesn't want to say!
>  > > > > +	 * Virtual hotplug systems can use the MADT's "always-on"  GIC=
R entries.
>  > > > > +	 * Otherwise, prevent such CPUs from being brought online.
>  > > > > +	 */
>  > > > > +	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
>  > > > > +		pr_warn_once("CPU %u's redistributor is  inaccessible: this C=
PU can't be brought online\n", cpu);
>  > > > > +		set_cpu_present(cpu, false);
>  > > > > +		set_cpu_possible(cpu, false);

(a digression) shouldn't we be clearing the enabled mask as well?

                                          set_cpu_enabled(cpu, false);


Best regards
Salil

