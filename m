Return-Path: <linux-arch+bounces-9942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C807CA211C5
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 19:45:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2922B164E73
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jan 2025 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E27041DC98A;
	Tue, 28 Jan 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="hoK6bwWN"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2109.outbound.protection.outlook.com [40.92.45.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083EFBA27;
	Tue, 28 Jan 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738089917; cv=fail; b=hH3TRfyuOljlRO7z9TnHdS405QLZrQz6gVQxvvRwdG4t6f/V1oGmh4Ps8YEwcDB+Vq/qJYTH4brvZXP4dzoZkVx+pZCZuQActTOGTe/vQiBulEURLrhmf9sKPQ9AN92DkMFPU7K/4wjRWr95RgIkl7RehU/52oAjbCcYfvDJ/88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738089917; c=relaxed/simple;
	bh=+gmM0oEHY2xPvZM7eaHne3qO+yhSdIPpKbdUJq1oPlk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YN+/AXn7gOrjzIbmEzC9coluRLCDc5+AAf1nXNbnX0LxheQD/znhI963lfzw3sRCqFBvY2co0hV/QI9NPTPnaFFY1ioVY4Y6ss10mvG0snq2uKXUwxkXU2txQbmwBKpOC9ZJoClR6KWT/qWm4LGEv3vjW87K9xHNMIKcEDpVvxM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=hoK6bwWN; arc=fail smtp.client-ip=40.92.45.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AAhkYqInfcbjQq38W7LPuYDnykyyrllleatQpN8qHrV5qrx8/wHmnb/2s6xhe7zc20ksMtcMSj7QeMQAEvda1+gIalgM06srQYnCDsqkxF4p+iwLHajQGEHSCo0QhZyrQJYBOJ/QuMO9OcyDP3do5u2bRbPOUT4yr/lo/g+8/ujvmOxx4JVhEl+JOFysO5V3sf+NTIE35BDBm1fNykx9mAd+wevGgjme6jyJfJqGGzZOtWh7t7E5g9F9W8InM2ZiSefGMEwAYuu3D8KFNN38w5/tWeg1bR/Lp/ykU7NbU5earsDJYLUmbKqv6IYSKa361oGud1lA+sFQ3oilzqNeTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RmLMsFRoiP5uJ0FjyD4H6NDoP5sKjdEtvEQEWzac4E=;
 b=BQXlq6D+n964IlXjuGyNv9nUHNVgQto4ylh2mSKPYjiG/CYtTjUjmwpe9gM1fXGPMb8d8O5QdxF/HkOd5qjf7DT/p56fsGI78UIWvTVbsCFu8AhmjEXWozWLPVlL0+OEhLc4Rr7cHTSPMdYEpk1fnBA7/tCXE7Dw1Ub4HbNPCFozzLR4dmDw/rq9YZUTpVS+ZucEfch/gV33qKGWdtzHZcQd6Q9PeoBanOuH2edKwEnvDwFRr9qRCWqPuj4sd1ysw9N5rSmSWNiqaLWWH0Uc5s/7IBf9uUSQ+jqVh0al4xTC8jMwzc8WkAr/wpVtQFdS7HTcyzbJgz4xxA2DZbPvfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RmLMsFRoiP5uJ0FjyD4H6NDoP5sKjdEtvEQEWzac4E=;
 b=hoK6bwWN5GDg9HfVkG8TaidFZkLIpbi81+6UNxrO0mzb58HsW50Qdcs2QzbPTlbpTIpefb0DGQda/yj5fnnH26LFTOPLbCUWb8UQJoSw0RhnPOZZlRx3L2V8hVpozT6ysLvPIxVrplQT15uptIj8ADZa5hZewDM3k0ZM87c1CtbL7lvp1tK2PmDYvZQE9D7sD0OpcrwiBOP2bqWutAA7qPQNgnlQEolnfM3sTX4J6in1tOaR16L8BMAcsqixoSEEQQNpA7lLGu+i5SQcom90jkMTHBaMrIXJlrK5n/EzFxw9yGukpl5VemzNqFx4tXdjde7DQxvxo/LAUt9enAG0jQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB9759.namprd02.prod.outlook.com (2603:10b6:806:37c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.18; Tue, 28 Jan
 2025 18:45:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8377.009; Tue, 28 Jan 2025
 18:45:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "wei.liu@kernel.org" <wei.liu@kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "jinankjain@linux.microsoft.com"
	<jinankjain@linux.microsoft.com>, "muminulrussell@gmail.com"
	<muminulrussell@gmail.com>, "skinsburskii@linux.microsoft.com"
	<skinsburskii@linux.microsoft.com>, "mukeshrathor@microsoft.com"
	<mukeshrathor@microsoft.com>
Subject: RE: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Topic: [PATCH v2 1/2] hyperv: Move hv_current_partition_id to
 arch-generic code
Thread-Index: AQHbbTjJcgmEzzZeVk2NkuIdCcR+SrMsgY8A
Date: Tue, 28 Jan 2025 18:45:11 +0000
Message-ID:
 <SN6PR02MB4157042605A22E40767DDC94D4EF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1737596851-29555-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1737596851-29555-2-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1737596851-29555-2-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB9759:EE_
x-ms-office365-filtering-correlation-id: 3e9f472a-949c-4f86-98bb-08dd3fcbe50f
x-microsoft-antispam:
 BCL:0;ARA:14566002|19110799003|461199028|15080799006|8060799006|8062599003|102099032|1602099012|10035399004|440099028|3412199025|4302099013|41001999003|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Zuy5ERhBRWTwE9Y12sisAqqAmDCEKKs5UIo3EPsguEyGjXjWNRtsiLrApo1Z?=
 =?us-ascii?Q?KZYtZ+J92XfCs3QRhKqfWnEnC4SGIJglYABUvSKc13bPQGFXfIWGNwrpPBVW?=
 =?us-ascii?Q?rdbKT0RQ234sFcpOuh2MTsihFBhxmwz0II1O7xccWwu7nKvsi5ppkYUyi/ft?=
 =?us-ascii?Q?HNgLneKNRltil7TCz6RbBXfKVeQF1U/2HL4O18z8g+/w/9/8b86fZFy7F5xC?=
 =?us-ascii?Q?TJjue4wj1d5CNrOthB0YzW1cdymlc5QpDJO+li37+4A3yALWlLgqF7psoOvo?=
 =?us-ascii?Q?A6L+uAkLMFvOEyINxP/fFlSSul5TG1GcmS4qUUwf3jOAORxuMWSlx21SLwXm?=
 =?us-ascii?Q?T4Zv3nY2sRDZvF3eE92drfcc4NTmpPMEXbwuqfHWQBUX1lMXU6lmtR2fHXay?=
 =?us-ascii?Q?ArnS2k63B9m81G+0OPFgDBkJXX8sUhpqkxsxlTul/57+Xf+5/JFbg7yIAwV7?=
 =?us-ascii?Q?N4CTvFeD+qoU5Fs+y6rLynwyPSE9F5OkpfIDwc8jOoDUyrABfrZChDpVNDG4?=
 =?us-ascii?Q?HG7HMqG+1KZZP9t8ZAlXD9BoCDNEtaP4+1v5qWF9aCe05tmodm8U2W5z3Az9?=
 =?us-ascii?Q?rfAOdgJDLGaUPXMswq2vvJwejYeorYJt9At6B2JXq93B6U9S/sMwVmEO9IC/?=
 =?us-ascii?Q?aNLxDFXRahMzPysjup4pkX4SJYwE5lZ2VlUsk4fS7rsc3URcwyKQb03DNfm0?=
 =?us-ascii?Q?/+KtLoVzMU6vBMT9d92qX0wKGSs8PEMqH8ET8pSeVEDZMTJ/dGM/pm37HuB4?=
 =?us-ascii?Q?VlYUoyGn6UP9wn3QsFjFkvsNDiHhmkziLAx7HiMfbD5ZMzGW3H41t8caDqEB?=
 =?us-ascii?Q?C72bw/OxRkl0uAUUkAxGgLux9NkWD6G81oQ5h75UJ5oTgczEPXpkRHtkA3g3?=
 =?us-ascii?Q?TF430UnqDsQ/YHme7rw/8dhJ/Az8LekmnwEqmNG9dABpu3WHH7VXlI1gIhm/?=
 =?us-ascii?Q?XkE3HFDNQOk/BLRpgC9rxb0FpcEOolM8nugGCmEDTWV1DY2fVCeN+AuLRUOO?=
 =?us-ascii?Q?iTb+41Wqw7j6ClTR9ny7xRXF5Rxj7Ou0oYCUdiUzihwfvzvyqRcs6+YyksYV?=
 =?us-ascii?Q?H3TuXnd3u1WYpfcoaQdu0rsnH8/1pn/XbkmljpmwYBGpkrIvz6V6ex3WWqhP?=
 =?us-ascii?Q?jxa1x4ZBl/hGPvqqXOXW5DpiEHGV8O46K1c4dtyL3eOuuC2HigFHDombG27k?=
 =?us-ascii?Q?cEGkMFcMYBHGFXn3K1eLS3kAI6tixRNSlDW5Fsw0pEcin/3JX0XqUXThnHh3?=
 =?us-ascii?Q?tw8ZsFxdp+mtQMPrvkhr+0Y8d0mWOVs6PL+LzQxELw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?etPXkyDhaDGbkg5P6uHkuZOxAQ3EesmHhRaj4AI3E27LRZAEBtx4/Ai7I6Bs?=
 =?us-ascii?Q?PDpyICohMTwMvZpYXBxjWmDe5exrfGQ7ZOJU8kfLwfddOt95sGAzejGe5cQP?=
 =?us-ascii?Q?IBPKYbpNQV5nc3fOrXwY2f7vN2P/u2XCwfxrIEJQ9bimw3FvQ9kKwvPpiQQC?=
 =?us-ascii?Q?2G/LFKWsHFeAXPqKeykF9bqbmKnxFH67LIE8DaW44mqO1Z9rETD/8G1t7EZG?=
 =?us-ascii?Q?7H9MggvhrzQwMN6o4/lKW113sArJh2D5/7xwc5siTxpZcop4PgFBvOCniDli?=
 =?us-ascii?Q?GsdzLfKanWoXjfoFOI87HrM3WrDn99fHjyX05fq5RDPE9qCJ/KqPYcxa3NMC?=
 =?us-ascii?Q?7sHSHeONRRXxKuzzOD1CUjVS3/6W+F9IG9xlCzbeZNokTsCCjRFwg//AWuQJ?=
 =?us-ascii?Q?ReEP0/Cit52HjX1GaSucjU7hZrPRS5xQ0B4Beham1u0oJVl6n1CXsadtAqdD?=
 =?us-ascii?Q?Cv4flWXoHowei1D6MudW9NhQ/M4JMUvmTq3rVQ40L3rUOZGOVwswXtZ3zIR8?=
 =?us-ascii?Q?COFkJxXJ6fbDkypgPEOe027+g+gFBflWwswIp35vlTP5/F7wuRjFkouXApyq?=
 =?us-ascii?Q?nqjkGbjhQs/GFRVMuLBcHA9konEz+//FpX4aA+w3dA7RLCsjCpek1HW+N3OY?=
 =?us-ascii?Q?WDaV7nJ1JQYE8BK5m1l6kpURCB6I5gYF/b5419ofgnL88AAreySBFZKXzZPh?=
 =?us-ascii?Q?nz72Rt+xYkdRU4BnWIvj4MGNyNljx2pswjUgFfg1CMrCTJMMSxu1x3XnHPUB?=
 =?us-ascii?Q?u3wcYBoVPpemYXfBCujRGEbSUWgRUl35Y0Ey41VaftqtGrYtYGDmkDpUXbjP?=
 =?us-ascii?Q?++g1yZsuxLIjOQtAV0gB5S8nDDx2YZOX1tXQWDgGhY2Zr/CEVAetuj0Qjk49?=
 =?us-ascii?Q?pF/+TjGJmZEQ59ttD93BauvEITcAs2vr5Ttc8rM8UPyx7cqAaKXKoDPgpXU/?=
 =?us-ascii?Q?itzyshCd38K6e9oUqbJl6hzGfO6z21pVw0gKQH3v5QfQzKp6mxPHzymcPTK8?=
 =?us-ascii?Q?KXm6U1qwZhV9iTrWvvV9sRSqXoyWNoR+t7/sn+VXk8Rx5USQUZ/NQr4petAR?=
 =?us-ascii?Q?aLLw41VFTSep6HfFhwc0RQuxhqrb+HPmdbcjsaymNwa4AbPN+c/4YlFbpME7?=
 =?us-ascii?Q?m5cAJk/E/R/w5gv+2OH/NQ7ToaCGfDb1l1uQYjJJgfucOadiNGgmRAjI8sHx?=
 =?us-ascii?Q?lruwEL72kAaHw+Dx9T3YscJvF3X+JKz3ktjA3o1Syl11FeD2z3Not5limM8?=
 =?us-ascii?Q?=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e9f472a-949c-4f86-98bb-08dd3fcbe50f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 18:45:11.0299
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9759

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, Ja=
nuary 22, 2025 5:48 PM
>=20
> Move hv_current_partition_id and hv_get_partition_id() to hv_common.c.
> These aren't specific to x86_64 and will be needed by common code.
>=20
> Set hv_current_partition_id to HV_PARTITION_ID_SELF by default.
>=20
> Use a stack variable for the output of the hypercall. This allows moving
> the call of hv_get_partition_id() to hv_common_init() before the percpu
> pages are initialized.
>=20
> Remove the BUG()s. Failing to get the id need not crash the machine.
>=20
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c       | 26 --------------------------
>  arch/x86/include/asm/mshyperv.h |  2 --
>  drivers/hv/hv_common.c          | 23 +++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  1 +
>  4 files changed, 24 insertions(+), 28 deletions(-)
>=20
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 173005e6a95d..6b9f6f9f704d 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -34,9 +34,6 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <linux/highmem.h>
>=20
> -u64 hv_current_partition_id =3D ~0ull;
> -EXPORT_SYMBOL_GPL(hv_current_partition_id);
> -
>  void *hv_hypercall_pg;
>  EXPORT_SYMBOL_GPL(hv_hypercall_pg);
>=20
> @@ -393,24 +390,6 @@ static void __init hv_stimer_setup_percpu_clockev(vo=
id)
>  		old_setup_percpu_clockev();
>  }
>=20
> -static void __init hv_get_partition_id(void)
> -{
> -	struct hv_get_partition_id *output_page;
> -	u64 status;
> -	unsigned long flags;
> -
> -	local_irq_save(flags);
> -	output_page =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> -	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
> -	if (!hv_result_success(status)) {
> -		/* No point in proceeding if this failed */
> -		pr_err("Failed to get partition ID: %lld\n", status);
> -		BUG();
> -	}
> -	hv_current_partition_id =3D output_page->partition_id;
> -	local_irq_restore(flags);
> -}
> -
>  #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>  static u8 __init get_vtl(void)
>  {
> @@ -605,11 +584,6 @@ void __init hyperv_init(void)
>=20
>  	register_syscore_ops(&hv_syscore_ops);
>=20
> -	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
> -		hv_get_partition_id();
> -
> -	BUG_ON(hv_root_partition && hv_current_partition_id =3D=3D ~0ull);
> -
>  #ifdef CONFIG_PCI_MSI
>  	/*
>  	 * If we're running as root, we want to create our own PCI MSI domain.
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f91ab1e75f9f..8d3ada3e8d0d 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -43,8 +43,6 @@ extern bool hyperv_paravisor_present;
>=20
>  extern void *hv_hypercall_pg;
>=20
> -extern u64 hv_current_partition_id;
> -
>  extern union hv_ghcb * __percpu *hv_ghcb_pg;
>=20
>  bool hv_isolation_type_snp(void);
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index af5d1dc451f6..1da19b64ef16 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -31,6 +31,9 @@
>  #include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
> +u64 hv_current_partition_id =3D HV_PARTITION_ID_SELF;
> +EXPORT_SYMBOL_GPL(hv_current_partition_id);
> +
>  /*
>   * hv_root_partition, ms_hyperv and hv_nested are defined here with othe=
r
>   * Hyper-V specific globals so they are shared across all architectures =
and are
> @@ -283,6 +286,23 @@ static inline bool hv_output_page_exists(void)
>  	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
>  }
>=20
> +static void __init hv_get_partition_id(void)
> +{
> +	/*
> +	 * Note in this case the output can be on the stack because it is just
> +	 * a single u64 and hence won't cross a page boundary.
> +	 */
> +	struct hv_get_partition_id output;

It's unfortunate that the structure name "hv_get_partition_id" is also
the name of this function. Could the structure name be changed to
follow the pattern of having "output" in the name, like other hypercall
parameters? It's not a blocker if it can't be changed. I was just surprised
to search for "hv_get_partition_id" and find both uses.

Also, see the comment at the beginning of hv_query_ext_cap() regarding
using a local stack variable as hypercall input or output. The comment
originated here [1]. At that time, I didn't investigate Sunil's assertion a=
ny
further, and I'm still unsure whether it is really true. But perhaps for
consistency and safety we should follow what it says.

[1] https://lore.kernel.org/linux-hyperv/SN4PR2101MB0880DB0606A5A0B72AD244B=
4C06A9@SN4PR2101MB0880.namprd21.prod.outlook.com/

> +	u64 status;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> +	if (!hv_result_success(status)) {
> +		pr_err("Hyper-V: failed to get partition ID: %#lx\n", status);
> +		return;
> +	}
> +	hv_current_partition_id =3D output.partition_id;
> +}
> +
>  int __init hv_common_init(void)
>  {
>  	int i;
> @@ -298,6 +318,9 @@ int __init hv_common_init(void)
>  	if (hv_is_isolation_supported())
>  		sysctl_record_panic_msg =3D 0;
>=20
> +	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
> +		hv_get_partition_id();

I don't see how this works. On the x86 side, hv_common_init()
is called before the guest ID is set and the hypercall page is setup.
So the hypercall in hv_get_partition_id() should fail.

Michael

> +
>  	/*
>  	 * Hyper-V expects to get crash register data or kmsg when
>  	 * crash enlightment is available and system crashes. Set
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index a7bbe504e4f3..98100466e0b2 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -58,6 +58,7 @@ struct ms_hyperv_info {
>  };
>  extern struct ms_hyperv_info ms_hyperv;
>  extern bool hv_nested;
> +extern u64 hv_current_partition_id;
>=20
>  extern void * __percpu *hyperv_pcpu_input_arg;
>  extern void * __percpu *hyperv_pcpu_output_arg;
> --
> 2.34.1


