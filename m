Return-Path: <linux-arch+bounces-3763-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B858A86E7
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4DD1F226A4
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 15:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D797F146A84;
	Wed, 17 Apr 2024 15:03:59 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B901465AF;
	Wed, 17 Apr 2024 15:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713366239; cv=none; b=hvVh/8I0WGvvBUYiegT3GSC0M15xm3oisVQt0hCkSuUEZbAmLcMGyaM9x28HvQCGqzofnWHOYAGY7Pa93E+4WYkQjN+11a5r3kfmrO007e68OBe6Yf8ixAQcvr1Nmsw/PyFf9LmmaMUtjT3lGxpdBu0257xTe40unbRssIvvyhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713366239; c=relaxed/simple;
	bh=pt7o95x34rcwc39W27zAEKxVJVWFD/jgEs0kzsvtBRM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VgaTG9EL6j8iE2wMCLRzvqVtyZcY8lklE6FJlKTnXX5RUelRzB8JiJpkp22UsKgSAmwbhdZu+xsQhC+oHmt9Iwq7Unr+oZcMiEW1Vpu+gGO5R9icPUG8oKKDYHr0hs9fWsgcyG8zZEpKi0yIRM/c0WzeOTaX5ppV2ezbf38A0l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKPJH6PZbz6JBJf;
	Wed, 17 Apr 2024 23:01:51 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 071AD140B54;
	Wed, 17 Apr 2024 23:03:52 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 16:03:51 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 16:03:51 +0100
From: Salil Mehta <salil.mehta@huawei.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>, Thomas Gleixner
	<tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "kvmarm@lists.linux.dev"
	<kvmarm@lists.linux.dev>, "x86@kernel.org" <x86@kernel.org>, Russell King
	<linux@armlinux.org.uk>, "Rafael J . Wysocki" <rafael@kernel.org>, "Miguel
 Luis" <miguel.luis@oracle.com>, James Morse <james.morse@arm.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Linuxarm <linuxarm@huawei.com>,
	"justin.he@arm.com" <justin.he@arm.com>, "jianyong.wu@arm.com"
	<jianyong.wu@arm.com>
Subject: RE: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Topic: [PATCH v6 06/16] ACPI: processor: Register deferred CPUs from
 acpi_processor_get_info()
Thread-Index: AQHakMpDOTAceXbil06hMEPbVPFoS7Fsjtaw
Date: Wed, 17 Apr 2024 15:03:51 +0000
Message-ID: <22ace9b108ee488eb017f5b3e8facb8d@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-7-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240417131909.7925-7-Jonathan.Cameron@huawei.com>
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

>  From: Jonathan Cameron <jonathan.cameron@huawei.com>
>  Sent: Wednesday, April 17, 2024 2:19 PM
> =20
>  From: James Morse <james.morse@arm.com>
> =20
>  The arm64 specific arch_register_cpu() call may defer CPU registration u=
ntil
>  the ACPI interpreter is available and the _STA method can be evaluated.
> =20
>  If this occurs, then a second attempt is made in acpi_processor_get_info=
().
>  Note that the arm64 specific call has not yet been added so for now this=
 will
>  be called for the original hotplug case.
> =20
>  For architectures that do not defer until the ACPI Processor driver load=
s
>  (e.g. x86), for initially present CPUs there will already be a CPU devic=
e. If
>  present do not try to register again.
> =20
>  Systems can still be booted with 'acpi=3Doff', or not include an ACPI
>  description at all as in these cases arch_register_cpu() will not have
>  deferred registration when first called.
> =20
>  This moves the CPU register logic back to a subsys_initcall(), while the
>  memory nodes will have been registered earlier.
>  Note this is where the call was prior to the cleanup series so there sho=
uld be
>  no side effects of moving it back again for this specific case.
> =20
>  [PATCH 00/21] Initial cleanups for vCPU HP.
>  https://lore.kernel.org/all/ZVyz%2FVe5pPu8AWoA@shell.armlinux.org.uk/
> =20
>  e.g. 5b95f94c3b9f ("x86/topology: Switch over to GENERIC_CPU_DEVICES")
> =20
>  Signed-off-by: James Morse <james.morse@arm.com>
>  Reviewed-by: Gavin Shan <gshan@redhat.com>
>  Tested-by: Miguel Luis <miguel.luis@oracle.com>
>  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  Tested-by: Jianyong Wu <jianyong.wu@arm.com>
>  Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>  Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>  Signed-off-by: Joanthan Cameron <Jonathan.Cameron@huawei.com>
>  ---
>  v6: Squash the two paths for conventional CPU Hotplug and arm64
>      vCPU HP.
>  v5: Update commit message to make it clear this is moving the
>      init back to where it was until very recently.
> =20
>      No longer change the condition in the earlier registration point
>      as that will be handled by the arm64 registration routine
>      deferring until called again here.
>  ---
>   drivers/acpi/acpi_processor.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
> =20
>  diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor=
.c
>  index 7ecb13775d7f..0cac77961020 100644
>  --- a/drivers/acpi/acpi_processor.c
>  +++ b/drivers/acpi/acpi_processor.c
>  @@ -356,8 +356,18 @@ static int acpi_processor_get_info(struct
>  acpi_device *device)
>   	 *
>   	 *  NOTE: Even if the processor has a cpuid, it may not be present
>   	 *  because cpuid <-> apicid mapping is persistent now.
>  +	 *
>  +	 *  Note this allows 3 flows, it is up to the arch_register_cpu()
>  +	 *  call to reject any that are not supported on a given architecture.
>  +	 *  A) CPU becomes present.
>  +	 *  B) Previously invalid logical CPU ID (Same as becoming present)
>  +	 *  C) CPU already present and now being enabled (and wasn't
>  registered
>  +	 *     early on an arch that doesn't defer to here)
>   	 */
>  -	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
>  +	if ((!invalid_logical_cpuid(pr->id) && cpu_present(pr->id) &&
>  +	     !get_cpu_device(pr->id)) ||
>  +	    invalid_logical_cpuid(pr->id) ||
>  +	    !cpu_present(pr->id)) {


Logic is clear but it is ugly. We should turn them into macro or inline.


Thanks
Salil.

