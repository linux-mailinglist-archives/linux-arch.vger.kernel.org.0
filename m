Return-Path: <linux-arch+bounces-13933-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E603EBBEC16
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 18:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 002054EFED4
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 16:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EAA2D5925;
	Mon,  6 Oct 2025 16:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="eWH/M37G"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010047.outbound.protection.outlook.com [52.103.7.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC3823ABBF;
	Mon,  6 Oct 2025 16:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769734; cv=fail; b=BThCfAhQm3G3d8BWeM1DT+rVvPFVrTIpc4DjZjLVXZ+CvdghbNMTyoJHV3VcKVjPsMiM+vwmclfJgLAPQR+4QVdCF/pcAGsr0JRX560Qgo4V4i+Tf+xHCjgWh6pqJt2PvHt9dBBtdZ1szGbb+aybcDzYOGf/o05gjIXxxgGSLhQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769734; c=relaxed/simple;
	bh=TseFazrgoif5ePHyvxFbr6XeSiPtsUlVpyqPZ/znNn0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZwSxNPXXocNW4MqIt2kDnYu5bP4KBCndtxDzHLAdOWKkr7Sf850eSRsAaFXTPiVsoEz6IvBiDvAxh/DxXHU+nP+mrXTI0DcQugz9npiM1CgVVKtJT/9FlpR/y/0SDPjstLXk5c5iY8OD4LhY+PGqfI67zAPrE3ouEnfSavzN7os=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=eWH/M37G; arc=fail smtp.client-ip=52.103.7.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UafTNVqa5hrW+4MHyVPXGZa6kXpX0zG7g0+mD2HiC+d5tWue3rXhi3EIhJ8gmKnJCqaHhx1qGrCYIMr1wJA/RlrZ2Kl6JkrJfP4mlDCZoS0YklTgFeZ1ZY7sPtuaiYwAQF7HbkaIz6+YKEKMP7LM8uTXTa6bm5I50plBMOkO3M2gLCfFEy7cZgzNR1/VkZmQ/374EdzBTxJuE0KP81kPnSJi22uaASmBDKgAxPQfEP7LHbraZ8biiRklRa08avrVcuMdCLttZ7Lrp0daHAEqcMXw5kYimmcPATc3tVH68w0CCphHpAS0y/QVWGtQPwRiJgfmD0H8G3s6gMY7Xbp86Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I03O0i7rJJUcdVzbGs23yYSu/+04aADJq9RhlcibDkk=;
 b=rO8Caz5u18+CNMAs/u61r0O58FQSuaAdV4HfQB2dsPDwVKaw52OF/Zy815y7aAQ3epzuW6zlkDwc++ym9t1qKezGsI3tS8hFzjH1ufGyCFJI4/lm2gYK0mVqcejiHcLAroifErQyBpvV+0TULiXHQ8qkbkZGwm97qTO0pClIVQjkXE4iXe711rrHx9DrTuVguNJ5ovou2cQQKtEVSTIpZ2wk/Ojm6cCHSMCoLLiuEiDBuVSUUHJCSBEcpGeUYzKFtw7HdQEPpx+0LFuGzg9BsgiVWkAvFW1mRBvVAmEaoijO3Q1SpleNS44lmJcimaf/kudBVEmVQDQarpoit0XFOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I03O0i7rJJUcdVzbGs23yYSu/+04aADJq9RhlcibDkk=;
 b=eWH/M37GWcqHBRtd0ui+FwbB6JRDqX1dYHNZto7TDJQsTALqwN7nvRZeRby7bPk8888z/AXct1PUpg/2L68zlVmUU4IRc/j390gM59/wUwLWXqPwfcyci1cGkJFLFG3008/5ah/d3QHc56lTTjfFYtyUYByzwQMneXbU6nJtg9lGkVBaSmGs1Eu0Ak0dlfeGAUhwTlbUzSSp6a1HyTyBqrBXxIkWpyt6CrJNUnjrE95o9IAs3REXV8bpjCDuj6sX9qbzbE2K/a/Za9uW5Rkku24Kd9yMsJQF3aZIUXc0jvFbK8bZP2mif4o2BI+4vg5Y+m299dhG9qaMlhGL9oTPSQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6675.namprd02.prod.outlook.com (2603:10b6:a03:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Mon, 6 Oct
 2025 16:55:26 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:55:20 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v6 05/17] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Topic: [PATCH hyperv-next v6 05/17] arch/x86: mshyperv: Trap on access
 for some synthetic MSRs
Thread-Index: AQHcNLUKXsQZqTwRRUGFDTKBIL8ZX7S1Vpyg
Date: Mon, 6 Oct 2025 16:55:20 +0000
Message-ID:
 <SN6PR02MB41571BD37714C5F0AB770CB5D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
 <20251003222710.6257-6-romank@linux.microsoft.com>
In-Reply-To: <20251003222710.6257-6-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6675:EE_
x-ms-office365-filtering-correlation-id: d5d97447-05dd-4250-b56a-08de04f922a1
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|41001999006|19110799012|461199028|31061999003|13091999003|40105399003|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UDzCpqxLu11t0sLULWjL0iARWjRAXwbSldLSpTHafGUhGFxTEGprVbScJ1mH?=
 =?us-ascii?Q?UqwX3DgzRHI/8NCjAhPBQ8HFDgOlGIX2Hz2mGwGHktQ2oyj6kqv/88CuT1LY?=
 =?us-ascii?Q?PlMSFfsYo49y6YIz32lXd1gncBZ9nkVdUkb5K3xbke2QZg+4WUda9y4tAD+Y?=
 =?us-ascii?Q?l3Jg5iSYF6JMlvaNl9+aw3VEK9NaD1np9faI6AmGxatT+KsswlB1cMlCmRbU?=
 =?us-ascii?Q?/b5rrPbpS2mhgiBtvGEw27P/7XKbFBxKWLU6OdyC9AATsu6JSJWWWxfVsPa0?=
 =?us-ascii?Q?/twN5WJ+hrpkVUc4NrVKvkDggpzM82bFtAQhyztOWna08bYSj5duwTljKDGg?=
 =?us-ascii?Q?CytY8NYDYpfKtqDgt87j0GCeU/zxf8zNDRdu0IJ8XxBKYUwu+OnItkfsQ/CK?=
 =?us-ascii?Q?r9XNil0nZE2+JlVv8Tg7DpqkCzMTMzH5ebJRFc0KJ+C1n4+H+9yqFd2ZPYMY?=
 =?us-ascii?Q?kMuFvhm8vI78gBOHKdK2hok6fDF5iHhI7VxOW9/AApXExFrUWtaTCKgI3kO0?=
 =?us-ascii?Q?wkL/CEQYKjVVh6t6a6eUZzqeaKlVzA4sut2MAbOeGJscT+BAYI2RmGYC2r1M?=
 =?us-ascii?Q?QbfFlPGiR3mVPC5ACQ3LJivnOS132F6k0TbwvM3AqeISk90GXmkn4dN2Kfwd?=
 =?us-ascii?Q?R5H2ESwjZ2Sp3wqGI7fyN5NdU3gConXjEsQLCc05ByTEaKGEibMvTa+jxOe1?=
 =?us-ascii?Q?PcKKNdrMDxZrfn7C86b7A/c9IeQEPqu9CfTh40USVespL5r6KM+AR5To0Cc4?=
 =?us-ascii?Q?CSKtjegOzG4SlRe/+nGN2/DY3mXxS0goNYQfv/0L0CzcNgPXNLSSRxyz05qp?=
 =?us-ascii?Q?DpvCQxjUjNqWYvCIzkMoa6gpBc6H/svw4oOZ8HuY4sWwUxlJ/m2b+HsY0hf7?=
 =?us-ascii?Q?mUKHgxKFbALgDlHfNVYNAlD1tPk7I7eCQDIW+EhtPdsY+N57UubKWlzdF5vo?=
 =?us-ascii?Q?9f/bWgKL25jaMVSitFbwb5FWDFkIPoLbsa++y6tW88Y9gtGaTyuOLofpYtwn?=
 =?us-ascii?Q?V4T8LMBPUDC71jtcveMrUtLOjEBB5ArhyD/MAsIm3uMzcyRO6hx/MbsbBwlc?=
 =?us-ascii?Q?ARvSPP0942GgKp72bR5dt8U+d9AbR8jko1/OcfSeh8xbe3mxKUDN0npLg5CY?=
 =?us-ascii?Q?roy7mR3OCcIb4Xela39h4FnMwdTrSoaHGzHnRDPQMakKE2pPzmFoeuAuQ040?=
 =?us-ascii?Q?S1DfG4IQV76Qrkbg/ijfMh5eE73uDlWjXu/mcw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5jNEh6d7MFrAm5AWdML21OunmBGEhwzykhW6zpRwgLLPYS9knfxIPfRKyT5e?=
 =?us-ascii?Q?mH6L5qTbDwhEmR5aOsr+5toh8ZN+IYlTrqkm77joqkok2N7FVMSj+GpVBoFZ?=
 =?us-ascii?Q?3LGZM6i5PjWLw/5BMRyRA1AI/Uayd8vABTkPR5NSH35kxiL3MJdoNNDMIEA9?=
 =?us-ascii?Q?WwEU5UxwChPky85fFNq/AbgdUSP9GWJbvND0n0V2afdtSbGUvP4GsztdFgSt?=
 =?us-ascii?Q?AN4vpG1dpcmY3UJFz24R+pZKWXYa4ySW1A7hPW3k0/z71sbucLUOqcqclDjs?=
 =?us-ascii?Q?0Os0o2vHNdgFhwQTwrW2p/kRQ7YtWa2BvtLHn9as8F939iSo+H/KgFYP6Nbu?=
 =?us-ascii?Q?GZ3zRu4q4MGDyPpMr97PuJmSUOs/vGB3TN45UlMt8LjOeyigQ+Tup28V6vSn?=
 =?us-ascii?Q?VMw5vDT2lDlxzWSumLGad9JQ8sT4yXh05eHzu6156VJVC5WTFKoUqytyeVAX?=
 =?us-ascii?Q?ySP5+IommoY3lgfmBdAMxR/Mo6+NWvFwMQDuoeuCiox6+OxSnt7Za3Tlhq+U?=
 =?us-ascii?Q?JcYqKXzxO0u+jFPK+cqjHn6ZvmFB6ZTYLBUHQUOL2dHOqvJvcr3EYfugb4c9?=
 =?us-ascii?Q?loqRGKZBj32eBYZnw+XTq3ZAIqWTYf3kFMA9AS6wc/rb28UZMd/bMnpL3Kf4?=
 =?us-ascii?Q?5eF3Ws4quUKr+X6f751FgELAA5B+gdfxVi/8k9iUTCwjt90Ytx3IvZZ9RO5d?=
 =?us-ascii?Q?v21J3H+8aoUsRtvWjoU7vhF8qC3U9xLz4br6GaGM0BLJ0MZph0k6vbSj5oXQ?=
 =?us-ascii?Q?lYGhzGm5PsFGDV4KTcWfKOXpIZVziadpW9jT73zJiZ91d4Gh4hiNRz07rYSa?=
 =?us-ascii?Q?6xS4bdVL6QKvpHEdHFYM6sVXpk/DitT9YrS5g5DJ0zHSAo2av1dwHUYH8Pd7?=
 =?us-ascii?Q?ocEAeZtSr3J34Oa4L8o19HeEE5ZsUbEDr/qvLNbixcknrVjUsORFyQaWMpBg?=
 =?us-ascii?Q?0xW6w2Qwuw01TigV0WYj2XqtYSmYbDr8RgfkCoWmT4HqJ/RASC9MAgmDjKmk?=
 =?us-ascii?Q?2WL7psE3h5PgXs3LPOAUJT3d1xEakD/CKZy2TVncGC6mvU5Y6vX986lsxY/z?=
 =?us-ascii?Q?jv48ydQWqVmhUhZS5c/LLZ5b/Xgs6hPUC1g5fmO0XDaORlQTVNSpK5W47Aq/?=
 =?us-ascii?Q?fbc7shjC5UB//MkdicVbZr98BvNnlkkrb4LWKZfL6ldwCayBg8C0cme+mS0v?=
 =?us-ascii?Q?7Fv1Hx4zIRlrC6Idas6w7/h7eo5fg5Oc3dJEkGrTTjbVNhVoTWEfic8p7s4?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d97447-05dd-4250-b56a-08de04f922a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 16:55:20.6993
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6675

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, October 3, 202=
5 3:27 PM
>=20
> hv_set_non_nested_msr() has special handling for SINT MSRs
> when a paravisor is present. In addition to updating the MSR on the
> host, the mirror MSR in the paravisor is updated, including with the
> proxy bit. But with Confidential VMBus, the proxy bit must not be
> used, so add a special case to skip it.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> Reviewed-by: Alok Tiwari <alok.a.tiwari@oracle.com>
> Reviewed-by: Tianyu Lan <tiala@microsoft.com>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++----
>  drivers/hv/hv_common.c         |  5 +++++
>  include/asm-generic/mshyperv.h |  1 +
>  3 files changed, 31 insertions(+), 4 deletions(-)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index af5a3bbbca9f..b410b930938a 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -28,6 +28,7 @@
>  #include <asm/apic.h>
>  #include <asm/timer.h>
>  #include <asm/reboot.h>
> +#include <asm/msr.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/msr.h>
> @@ -38,6 +39,12 @@
>  bool hv_nested;
>  struct ms_hyperv_info ms_hyperv;
>=20
> +/*
> + * When running with the paravisor, controls proxying the synthetic inte=
rrupts
> + * from the host
> + */
> +static bool hv_para_sint_proxy;

This needs to move down a few lines and be under the #if IS_ENABLED(CONFIG_=
HYPERV)
in order to eliminate the "unused variable" warning reported by the kernel =
test robot.

> +
>  /* Used in modules via hv_do_hypercall(): see arch/x86/include/asm/mshyp=
erv.h */
>  bool hyperv_paravisor_present __ro_after_init;
>  EXPORT_SYMBOL_GPL(hyperv_paravisor_present);
> @@ -79,17 +86,31 @@ EXPORT_SYMBOL_GPL(hv_get_non_nested_msr);
>  void hv_set_non_nested_msr(unsigned int reg, u64 value)
>  {
>  	if (hv_is_synic_msr(reg) && ms_hyperv.paravisor_present) {
> +		/* The hypervisor will get the intercept. */
>  		hv_ivm_msr_write(reg, value);
>=20
> -		/* Write proxy bit via wrmsl instruction */
> -		if (hv_is_sint_msr(reg))
> -			wrmsrq(reg, value | 1 << 20);
> +		/* Using wrmsrq so the following goes to the paravisor. */
> +		if (hv_is_sint_msr(reg)) {
> +			union hv_synic_sint sint =3D { .as_uint64 =3D value };
> +
> +			sint.proxy =3D hv_para_sint_proxy;
> +			native_wrmsrq(reg, sint.as_uint64);
> +		}
>  	} else {
> -		wrmsrq(reg, value);
> +		native_wrmsrq(reg, value);
>  	}
>  }
>  EXPORT_SYMBOL_GPL(hv_set_non_nested_msr);
>=20
> +/*
> + * Enable or disable proxying synthetic interrupts
> + * to the paravisor.
> + */
> +void hv_para_set_sint_proxy(bool enable)
> +{
> +	hv_para_sint_proxy =3D enable;
> +}
> +
>  /*
>   * Get the SynIC register value from the paravisor.
>   */
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 8756ca834546..1a5c7a358971 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -716,6 +716,11 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1,=
 u64
> param2)
>  }
>  EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
>=20
> +void __weak hv_para_set_sint_proxy(bool enable)
> +{
> +}
> +EXPORT_SYMBOL_GPL(hv_para_set_sint_proxy);
> +
>  u64 __weak hv_para_get_synic_register(unsigned int reg)
>  {
>  	return ~0ULL;
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index c010059f1518..3955ba6d60b8 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -298,6 +298,7 @@ bool hv_is_isolation_supported(void);
>  bool hv_isolation_type_snp(void);
>  u64 hv_ghcb_hypercall(u64 control, void *input, void *output, u32 input_=
size);
>  u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
> +void hv_para_set_sint_proxy(bool enable);
>  u64 hv_para_get_synic_register(unsigned int reg);
>  void hv_para_set_synic_register(unsigned int reg, u64 val);
>  void hyperv_cleanup(void);
> --
> 2.43.0
>=20


