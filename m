Return-Path: <linux-arch+bounces-12937-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02458B1148C
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0715AA7D3D
	for <lists+linux-arch@lfdr.de>; Thu, 24 Jul 2025 23:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED48F23BCF7;
	Thu, 24 Jul 2025 23:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="jJWDjBMO"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2075.outbound.protection.outlook.com [40.92.23.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394985D8F0;
	Thu, 24 Jul 2025 23:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400008; cv=fail; b=MczDyXHwnPlvfqFdkinQW/UVPC69PYpKjDICCTkoC9YLNrkXOGne0ux0/A6Ujk0U4g/0POqabx4IaJ6DVhh706tw2/0yIH80UsiSrS2wlELg2EGLBfGuiJ9XcDKKadKK+3mPluZ3DPjoELkLKPcDDsxeYtE4a/bye7GdmkRqy6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400008; c=relaxed/simple;
	bh=9woOiVfu6NxooeQkjLWY6vnbnPSsiUFPU9LkhOCzJiY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=l+wPMhosVABsHOdsIgwTxtZAAxG7oMotstKYigDJHd0JUwSNUtYbWw9tRxZblquTQVfPxPjVbmw1UCClenZaA0aMESPKhdmh6JHVlLJ5ruoWBXnk6W2OXCKGgv6m7WhdzL9Jef70CgzMSAmqUCaS2stUSHmv5mvDeiFcOqJJnVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=jJWDjBMO; arc=fail smtp.client-ip=40.92.23.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r2//dr5dor9ogKKKmsbhUoYRpULHTw59GAQcUDNsJO7Epp9WMHAiv0SA8PD1oICJrB2+QEk+J5533m34kuDKW7FVU+9t4Y8PbLmwmTESPKqN5mmCwsjxciVlFa0B+b8WMH1fl/uBBWKUXieM+o4oDTj8LvyLCx24MdCJTCh+LyQql237ZvrbkvNnYwiVMxlj7+g4NrCbU/guzyCUYe0dWHIEfmX4Ntqm+CJbby/lepFEm+DtRMtnPK5Xn8b5GGRALtP87XkE7btYLXzREJNWDt7zNEujtIlDScPjZ2Fem43nZIcqiWstroI7BaEAqZXDcHcSpFR0Wuhmwwo3MGDC+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/VpZse+a2IcMob0+ZwoBS6JnkHaqSwQ5UOjDE1l8x4=;
 b=rTjDAzheyg4dGUJeiTrFIvQmC3jUchf90n9J2ddmgrorpQaH9EragaSb2dkNqukEqXUEELeNOpKRH2fuKpI4FVYsdQQ7VuN9MI+qXDoPRnz8kJ2K9B2SN8UDfaqjFYp+Qmdiv3OIooQAx0uWd7jWFXG+kReAgs6LVvpR7MqmKWN0IQYacZKVPmW4n0xVUjs+RCl3fnHl0SsGyXSfBN6EPelQEoXPtFPugBWTHMrLDc+RTQSWqTBOoFzYhwsKDIxKef6emWoidFPcD4KcwUlBS1wyM+A/mza0OmuWVXYTxFknM0nfumJ9urcuVxXXi5Y22WRv5nA8nTC1ReRD4Ot7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/VpZse+a2IcMob0+ZwoBS6JnkHaqSwQ5UOjDE1l8x4=;
 b=jJWDjBMOVvmGdgx+dD4jJDU2RQW+I51oQsogdQTmlXZQs7izihCwQi4Le9fz//DhIZUsLw2uAfa7guUVy7dVDd0aTtHSVj7H727nIWUkaEx5ku/8zfTKvyiGuP2s8QWtjL8vJgQOZEtyfxdy55BnY19a6cQ7Hv3OhoQ8ZrKuNtGT2NGUrDRmn7o2bJNBWFRsYsj1XglKxmKedImZaM/RCF3qYPaveZPx2kNtjxMRLFG3TIV4VB+wJaZ7w+YiQqV782NJbeuSqXCnfjYSXlOJ3UuFD+A/B2lPdLe9zc1l4Qi5NivquJOBVCEFZXRXE58+CCJ5cHXqtZwDF3ofJ4kP0Q==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA0PR02MB7482.namprd02.prod.outlook.com (2603:10b6:806:ef::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 24 Jul
 2025 23:33:24 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8943.029; Thu, 24 Jul 2025
 23:33:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>,
	"kvijayab@amd.com" <kvijayab@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH V3 1/4] x86/Hyper-V: Not use hv apic driver when
 Secure AVIC is available
Thread-Topic: [RFC PATCH V3 1/4] x86/Hyper-V: Not use hv apic driver when
 Secure AVIC is available
Thread-Index: AQHb/ASBKDFdv3dbpUKug9RFAq4H3LRB2efA
Date: Thu, 24 Jul 2025 23:33:23 +0000
Message-ID:
 <SN6PR02MB41570FB8F17994FC7DB369E5D45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250723190308.5945-1-ltykernel@gmail.com>
 <20250723190308.5945-2-ltykernel@gmail.com>
In-Reply-To: <20250723190308.5945-2-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA0PR02MB7482:EE_
x-ms-office365-filtering-correlation-id: ff2e8ca0-05c9-48b2-a979-08ddcb0a7b8f
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599012|41001999006|461199028|8060799015|15080799012|19110799012|40105399003|51005399003|3412199025|4302099013|440099028|10035399007|102099032|1602099012;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6jvKLppZwQlD+sTBFPi5aoabkYwFfmVVrT80KEOh1IVbsWK5WQoeL61WbmDE?=
 =?us-ascii?Q?YuEeveeAgX+gP4lPx59bbGn9utzBq/ok6+wD3+J46hOtXwQHFE0l9qjs6XSN?=
 =?us-ascii?Q?UsORH+D+1LQtXBp87Hjp6KbSaIItnMDATkLtAIjT45CJ1FLcrFRD7R/Z4tKH?=
 =?us-ascii?Q?Cim+L199ZApqnOinBP/IB+F/d+2koLn+QeeOrgj3mG5M2G7IYcY0epz6FkIO?=
 =?us-ascii?Q?vpNQ2OIpBfXZUG/sZ85xukolw7zoJ9Inb3+HIslGKdJqLQgSvWpxjeFX4j0j?=
 =?us-ascii?Q?XG6QUpTqepuaAjMBqHWnXk3bH1PvqSJrPj8rrTeDZ6gG9Lnme75yz5FGulUk?=
 =?us-ascii?Q?yllFf4aa+bYcRJwpiNk9j/47tny3wgEBSdToMZDcssQM/Fc2YFYpWODS66KI?=
 =?us-ascii?Q?bxz2FOJ5g1IPXCoe8R9lvCgdb1rMZu+w1Z/C3F8HgZ3USHg5Srvj+FdPvtRd?=
 =?us-ascii?Q?otTzm/phrKJhidkhus3pn2vd9DzknEgnNB83cLjSA1ptWakl3nweDrFLChEy?=
 =?us-ascii?Q?5KqafV4axu7rmMsFu+N80ILw6zmJhkA1IOFH3Re5GF1jdlpP3WCWACja5DiF?=
 =?us-ascii?Q?e7LhalMwVgk2DyYlG876cC44lwfAO6w4rQEYvUv0pwgLr8ZSBRV5G4PQDnn4?=
 =?us-ascii?Q?FnYJuvwV6S7LdkaDNFyIBY3bwtEWRsx1/N7cP/HVkeXzIttoNh6MTGzYDtjr?=
 =?us-ascii?Q?n3kx2/Sh4tIMelJvS0qXfvyj8pcMwjARuolbk3wzVcjCd0x3Qlpin0JcP6Tv?=
 =?us-ascii?Q?yuTxLwoPXmqvkjeIFO67hxvMREoZoRinyuHk53ZK81YltWhmijYDGfEZOBCx?=
 =?us-ascii?Q?l8o6OBHst7tKqwwVx66eKVhxf/KmMgM1VdjYMS2i4NskcmJ5tN25DPHJFQz2?=
 =?us-ascii?Q?jtq/yKjQjRVoHRDuOOMKZR8RMqkfaMBZ4ElizLAlSYVswAWZ47ClijGZic6p?=
 =?us-ascii?Q?H0B3dReJNCvoxLciuix9XUnkZ36x5RzeBUYwwWNwlBl3XyyZWvkPrPEed0Wq?=
 =?us-ascii?Q?ZdlQZBUAZCAZJKn+TPyWqR9EIqacK2SZhRz6fg+Aem3IJ/6vQY0XdkOTerJa?=
 =?us-ascii?Q?zKyW+gNASZ6TvvZ7IxjR3IhkmSXVzquKk6q3NiTxkyQFuiZbN7tnmI52wLXN?=
 =?us-ascii?Q?64XnesYgQ6HeXJUhl2e4DY1jXRuq1lbof5hDGKBEeYg4n05b8VmPCaRw3dGX?=
 =?us-ascii?Q?kpE+FP7F+KGKIzAUb11LuE80Ca2SlRPG9kLNKvx0+vfXvNiYpDbdjwCM0Yqo?=
 =?us-ascii?Q?oAc9JR+BZBVxgoFDtRuu?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/WN8zNIuLjn/7zdNySeGgFkn0MN6PbiRs7HHYe+iHMygrEecvF9AvF3oAnWf?=
 =?us-ascii?Q?PVN4ieZHWRwYbRXMvPt94FPcHbRoLokZTYyAcu+3LjdmeGu9pGpcNyGBlmyf?=
 =?us-ascii?Q?xaWD2+sOTueJk9QAUHpFi1nC+wURwxArQ/YV2VG+VdXYwkixtUVQjiemsCsc?=
 =?us-ascii?Q?1wUkYKfEn4TN+THxqJgfaRNLXSBuwJVRMrc2BLzOXafBT5hmuhlbOO+ZFhVd?=
 =?us-ascii?Q?cpgYfKU0VI9towI+uVQywzlHpRY186ZN2PWSDYlhH7U/vBc2E6kIC0LOYx/P?=
 =?us-ascii?Q?/O94iMO7lFSLTJApAeJereroAlVAyK6i0G8kpFrXiPYeq3wRAcNK23AKGrgC?=
 =?us-ascii?Q?4sZFztqD1YkrKv2QVw5jOnyxJkoBoaOHsyVCE/Qy0781/QLnux1EvVEt67mC?=
 =?us-ascii?Q?GO7yg46YHvRoGuWkCbz5NnqXKXa0F4FWPk3C/QaDa+7TD5i4pCplPkG4V+Ii?=
 =?us-ascii?Q?NcQ1kv/Jz1LENt0w0IReM1MHde1i9UPKNDUoXmrVXBVPvf1o8lGq2WJbdi7+?=
 =?us-ascii?Q?4lwJ1A0cM97vD+tYKecIRej65Ol1TcA1j8XXB4dMwUcPBPUFrSQ71tqnvS0E?=
 =?us-ascii?Q?mmRodGNekcVcUBPsfSA0DkNvH2RWgzFLCE9WSWA1ntmaQuczTIUqFkyvGQC6?=
 =?us-ascii?Q?0mOrwuwKQmBnZc5r8piE1UXQsSl3Ao5odSBixVzl+wrutWEvJLjeM6Q1FUJG?=
 =?us-ascii?Q?MEsFEi94gW/PbRszslXqykoYm1Qzey6zHEmDpQQ2NJChdI1kA+JVLwtYofiM?=
 =?us-ascii?Q?nZIK8FMXHYFYqBfAH2q3ZN06dByAsMCy8sn7/Y+12lMBcbn/QKQUBrZHlbXO?=
 =?us-ascii?Q?0zOApuRu+XQceI06bczUzEMs+7onYtau011xQ2RItWVZeP0TqfcDfrlcUTlj?=
 =?us-ascii?Q?/WO+zuMmvrPOTrEeMcXVyt+9GfBt9BXBKRyNT9zMWL81tL0UihxXotyHk6de?=
 =?us-ascii?Q?mB89eEpb47FrM4choW+q4leYylTJ5OJRFkUShz8y2r2FdjQ3zGiY5+IIvP2m?=
 =?us-ascii?Q?gzJSCMdAvHF31DyrwOpSB93g4mlcvH9/668dFtsUHrnbO+iPGzZVWYGZfYHl?=
 =?us-ascii?Q?yq/K+mXvKQ54MQnDa3wZzSZGWUWU6vmaGjKJ1MkRqj8d0CZ3sWX9apsODS8L?=
 =?us-ascii?Q?fh0tF21qbmwkw9kTyBsPQhaCYN4ET3mD2/wqD9PMdGfCDV21nIlgZNzeDWRj?=
 =?us-ascii?Q?uEmqlCztDMIc+I22SgU05yUCu5tQ88vw16TTWmZg96sJyrIyTN5cu1FMY9Y?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff2e8ca0-05c9-48b2-a979-08ddcb0a7b8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2025 23:33:23.9114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7482

From: Tianyu Lan <ltykernel@gmail.com> Sent: Wednesday, July 23, 2025 12:03=
 PM
>=20
> When Secure AVIC is available, AMD x2apic Secure
> AVIC driver should be selected and return directly
> in the hv_apic_init().

For the "RFC Patch v2" version of this patch, I had provided some comments
on the wording for the patch "Subject:" and for the commit message. [1] It
doesn't look like those comments were picked up. The comments
improve the use of English without changing any substantive information,
so I think they should be adopted.

[1] https://lore.kernel.org/linux-hyperv/CAMvTesAscN2MyqJXpcbwcXWC-6-en6U_c=
03M+2=3DzcMF0bLv4iw@mail.gmail.com/T/#m893e8cac0314e73ee4626d736c623e640b46=
ef5d

>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/hyperv/hv_apic.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
> index bfde0a3498b9..1c48396e5389 100644
> --- a/arch/x86/hyperv/hv_apic.c
> +++ b/arch/x86/hyperv/hv_apic.c
> @@ -293,6 +293,9 @@ static void hv_send_ipi_self(int vector)
>=20
>  void __init hv_apic_init(void)
>  {
> +       if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +               return;

This new code is indented with spaces instead of tabs. checkpatch.pl should
flag that.

> +
>  	if (ms_hyperv.hints & HV_X64_CLUSTER_IPI_RECOMMENDED) {
>  		pr_info("Hyper-V: Using IPI hypercalls\n");
>  		/*
> --
> 2.25.1
>=20


