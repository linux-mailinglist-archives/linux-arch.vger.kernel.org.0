Return-Path: <linux-arch+bounces-3771-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF70F8A89B0
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 19:03:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B72E2867A3
	for <lists+linux-arch@lfdr.de>; Wed, 17 Apr 2024 17:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66327174EF0;
	Wed, 17 Apr 2024 17:01:24 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB24173346;
	Wed, 17 Apr 2024 17:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373284; cv=none; b=jn1gK0UUuqwTn4AZ06X3qVDGhxrPexhlE85akKQgoZrBSmz0cRutqN5miKixuX8srp/CCFg+UBm/nVQXkuuYww6H+Bh1NvPL3P8nTJUKs5XycxUZvCg7WwTjxyzGX+sNw9peSUsHDvvkhY1mbgklvzOpnmHP3U4xJG+6VKTSM1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373284; c=relaxed/simple;
	bh=O6we+RqXsiVWX/TzqcQDz134Wp7eWf6sc519p/DTcpM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E7heZEuNVp4LGVigoInmwwXRQhnvyJ+dKNooKyuwuTIEyeOcapXOscFTInOHVHdY0nDUBPJAly1agFPnof+MFQYeKuWm01a806Kko3b+YeqANrhPZVs+HvXc1CSmlopC2xtup4bGuaxbX7ns516IO1HHb41+5BERX2WeZ4RspBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VKRrM5KdMz67cSV;
	Thu, 18 Apr 2024 00:56:19 +0800 (CST)
Received: from lhrpeml100002.china.huawei.com (unknown [7.191.160.241])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DDB3140B38;
	Thu, 18 Apr 2024 01:01:17 +0800 (CST)
Received: from lhrpeml500001.china.huawei.com (7.191.163.213) by
 lhrpeml100002.china.huawei.com (7.191.160.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 18:01:17 +0100
Received: from lhrpeml500001.china.huawei.com ([7.191.163.213]) by
 lhrpeml500001.china.huawei.com ([7.191.163.213]) with mapi id 15.01.2507.035;
 Wed, 17 Apr 2024 18:01:17 +0100
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
Subject: RE: [PATCH v6 16/16] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
Thread-Topic: [PATCH v6 16/16] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
Thread-Index: AQHakMr6k1YHIExkQkWYAEBNLS9P4bFsr2qw
Date: Wed, 17 Apr 2024 17:01:17 +0000
Message-ID: <8b821e5521664c58bc1990230ed757c5@huawei.com>
References: <20240417131909.7925-1-Jonathan.Cameron@huawei.com>
 <20240417131909.7925-17-Jonathan.Cameron@huawei.com>
In-Reply-To: <20240417131909.7925-17-Jonathan.Cameron@huawei.com>
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
>  The 'offline' file in sysfs shows all offline CPUs, including those that=
 aren't
>  present. User-space is expected to remove not-present CPUs from this lis=
t
>  to learn which CPUs could be brought online.
> =20
>  CPUs can be present but not-enabled. These CPUs can't be brought online
>  until the firmware policy changes, which comes with an ACPI notification
>  that will register the CPUs.
> =20
>  With only the offline and present files, user-space is unable to determi=
ne
>  which CPUs it can try to bring online. Add a new CPU mask that shows thi=
s
>  based on all the registered CPUs.
> =20
>  Signed-off-by: James Morse <james.morse@arm.com>
>  Tested-by: Miguel Luis <miguel.luis@oracle.com>
>  Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
>  Tested-by: Jianyong Wu <jianyong.wu@arm.com>
>  Acked-by: Thomas Gleixner <tglx@linutronix.de>
>  Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>  Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> =20
>  ---
>  v5: No change
>  ---
>   .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
>   drivers/base/cpu.c                            | 10 ++++++++
>   include/linux/cpumask.h                       | 25 +++++++++++++++++++
>   kernel/cpu.c                                  |  3 +++
>   4 files changed, 44 insertions(+)
> =20

[...]


>  diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c index
>  b9d0d14e5960..4713b86d20f2 100644
>  --- a/drivers/base/cpu.c
>  +++ b/drivers/base/cpu.c
>  @@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)  {
>   	int logical_cpu =3D cpu->dev.id;
> =20
>  +	set_cpu_enabled(logical_cpu, false);


sorry, It is being done here in context to (un)register)cpu().


>   	unregister_cpu_under_node(logical_cpu,
>  cpu_to_node(logical_cpu));
> =20
>   	device_unregister(&cpu->dev);
>  @@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *de=
v,
>  }  static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
> =20
>  +static ssize_t print_cpus_enabled(struct device *dev,
>  +				  struct device_attribute *attr, char *buf) {
>  +	return sysfs_emit(buf, "%*pbl\n",
>  cpumask_pr_args(cpu_enabled_mask));
>  +}
>  +static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
>  +
>   static ssize_t print_cpus_isolated(struct device *dev,
>   				  struct device_attribute *attr, char *buf)  {
>  @@ -413,6 +421,7 @@ int register_cpu(struct cpu *cpu, int num)
>   	register_cpu_under_node(num, cpu_to_node(num));
>   	dev_pm_qos_expose_latency_limit(&cpu->dev,
> =20
>  	PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
>  +	set_cpu_enabled(num, true);


and here.

Thanks
Salil.



