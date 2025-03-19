Return-Path: <linux-arch+bounces-10950-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E57A68307
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3BB425158
	for <lists+linux-arch@lfdr.de>; Wed, 19 Mar 2025 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D681C20D517;
	Wed, 19 Mar 2025 02:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="pm8u9wcr"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010013.outbound.protection.outlook.com [52.103.11.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5841E20DD5E;
	Wed, 19 Mar 2025 02:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742350225; cv=fail; b=c8/OMY3E/aM4vR8iczHQy5bGKpVKed6qQA4lnE1y931mobAjxibnhf7ur/+5fJ6rC9ADR0f1wswocH3me/B+5gLI4lWM8yE3Fxfp+upTamyUhpattK61YV2QoQ/Zva1LnfFiHYuq30TJKWis/dFoVpdgQEu8kCb3/55XqPl8sq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742350225; c=relaxed/simple;
	bh=nVicEK5rm4a3zcsmP9TgTDDlDk/71V84yMV4oeuduNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgZsjvFbJ6o7QHWIJFRDn9Gzg6U98Es0gGQDQzI2INjuZ4yT82ojisGKHudYCtLKCgFl9DnPgaBc2m4OHqEiLgvo7AcpUcbChJpZFGJrczo5ViLloq5Gljt8r/89zMyma2tSMSENYSkgHFAHjefpICDtAyQ0GAKbHxdNZcmeDHQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=pm8u9wcr; arc=fail smtp.client-ip=52.103.11.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7MItFQhbCw2LmPe0ysxLZ+y2zOd1DZatTsEw/4KOQNl09VrO0z0qW1gjlElz7/A9S3qUeeanAvdE2ptRlqAJmwxo2qHuLKrzFfuPSg9yUcKNA4jLDix8tCumic87xt/8vbIDqA45h8+GJ9KaFJxO9miQ9a4UvJCZNwl+qyygPECVbNAQ/6GVOMJPBN9PeyMKPXwCa04j43PenWWMi3TgsDpfKhyrT2oP4ysWDjECFcFSzd2+EuS9bW05XTnzscBm87asppAX8Q7SEUQEZRPSw6ymtPwFzodqJmSD9xRpKa5zTrWX6uOjQIoMebm0HPcxFowXNQy7L2p0KW7RwCN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gcCIaNjFwNRVC328FWu27fDs+D1+IXEoCJoZWi6IvRs=;
 b=mk8qu9tJELtexHgFs6VTSgtcBpKJo/ZA/GQxaMtJ0xVwDbWveZcx+H39umhFqWe1wrTOt4EgygRdZ6xZyTpX2vfgqYAXgv81eVbjZ7m093O6kuLJr+6tyh1m0E9o1QOmD8f8X357yptag9NhbyPixAOBQWhD564/FgwNceM2X8lOZjQ4CTEKENNg57NDuxvF3S504YgJFElQGEJWcjAmfs8YV/SLunuQb+n9OjA1e2Qt6pT1Uco1QFlTSyE2lYU/hDEAsxNI1gXETur5ZEqnmPcouZQDAdXCk3E0YJVCfzzCC40ZhefQoTtebCHCj/ZGocR1jMhQI07UBE/RaE/2Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gcCIaNjFwNRVC328FWu27fDs+D1+IXEoCJoZWi6IvRs=;
 b=pm8u9wcrViT5M2VhFRN2ao3cq5PpcWVyrFsaFzd5c/47NSyEbNMtXy7LrMhv69XERmj9CU52QHwHKVtjtXN0KPKn87WVOJEEOSvPq04sK9Vpn1lM0nON3bKsUBlZWFYhntRUI5tUTvxDdkUTVY1PGSjDYAYll24j+adW7+GnFavurtEsg7jVrpclS7E3eGoVMPZJQQtd8BVdXc3XHY4wosyih9tZE+w6TpDUQjXR4o7J4TKxRaaUdzSmwU4De7VWbWOyvhmgBe5NaVAgFAmyntnE3Ye730RMJajMwgYjXYq0MseKrfcYway5PY2QIS5e87GV6x6SNvfl2U8o3efUTQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MWHPR02MB10569.namprd02.prod.outlook.com (2603:10b6:303:283::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 02:10:17 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Wed, 19 Mar 2025
 02:10:17 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v5 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHbiKNt140GtdgK20KtRyAXlJwH1rNxYTIggAha0QCAAAvV4A==
Date: Wed, 19 Mar 2025 02:10:17 +0000
Message-ID:
 <SN6PR02MB41574DE5535222985147134CD4D92@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157BE8AF5A1CDD39CF31124D4DF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <afd87eba-742f-4b67-9171-fd8486416b7b@linux.microsoft.com>
In-Reply-To: <afd87eba-742f-4b67-9171-fd8486416b7b@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MWHPR02MB10569:EE_
x-ms-office365-filtering-correlation-id: 7a5e9182-74e8-4824-6a4a-08dd668b318a
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799006|8062599003|19110799003|8060799006|12121999004|102099032|3412199025|440099028|18061999006|12091999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?A4piivUI5Czl0HOczDoTuH27vgB+VmBz3l7IN1hA4aceiQTbyRF/i8+6TKOu?=
 =?us-ascii?Q?J7ltuWWaVYCsf7QdtoiTmg3ZheovAlqwrRuPLVQPAuXmdjZu2uCF+lusYB+m?=
 =?us-ascii?Q?ARXO3RXANXWm7L7FpkX8m8U/Ig2FpF5X0z87A1wkePJonVrEU5IA5Qd9kJMj?=
 =?us-ascii?Q?VfTo27qLuNpQX3vg2K3Xw7HeukIBBLqaBojc4FL8MLXzzY8qo5cFNxKB45OQ?=
 =?us-ascii?Q?LDs36fc1ll6jT0KLhCono7DFySZb8Fv53Vk9w62i33xSkqLtXP6oD3a5SyWs?=
 =?us-ascii?Q?HhU3IVYzInpJQn1kKesOFiPi6UNDGc6x7LHAat0UAXKYe6pg1xcrx5njza/w?=
 =?us-ascii?Q?zsLYVyYfG479coE0ixHB87O4uhMPrzoLGBSBbxUTNHpFPMhE3Qwu8zTHLbDr?=
 =?us-ascii?Q?IG9T93Q2mjw6c9M5/T3DBnxa6m7hguVkLqaYJYCUyReiJEKa6w2pwsnjE0Ol?=
 =?us-ascii?Q?5X/qSUztqeZUKtf5YMKMce5WUylz82n0loiV8rwdt+eIoMfDFgBmo96QhZ8Q?=
 =?us-ascii?Q?7NRKbUVhHaz3/elB2zSRo8OxwwQv81KkmenSAp0i9BGXZXwVFyFXlDEiSYUO?=
 =?us-ascii?Q?s0TQ+ncLpKJ3vpwdtxGjNozm+PgVQHqNi58Z5lRRbjeLmOsRUcu3UBz6AL7j?=
 =?us-ascii?Q?QRc3TFhNP4DrUByOX2r5dPHp/rbVJVbkjuWECqx2bD0DzimofzyULNDaTs6g?=
 =?us-ascii?Q?Egqqn8hZZ2BaitCUSdQhZb9DURJ5za4JjD1uuwKT3O7rqkYgfu2mmyBXN1n4?=
 =?us-ascii?Q?7W6IcyRM9TqnMCItffw3gf8qXriidrl+wOZkvU7dWpWHIC5yXTtG0DOEAaHj?=
 =?us-ascii?Q?gGzx/MOZqUkOZijD7K0ul72SwrrEltaMtZcxGkN2+MMCl13269P/rLLsnbHn?=
 =?us-ascii?Q?c5FOvAHkknuy7FhiXznuLycHs7Lp3a01OJvupQ0ZakDeSdtYcpIE0Tk8BTtK?=
 =?us-ascii?Q?ciJboz+Mm5Ds1SKM+QZVMmQTjpp8UYIoE5VDI0wXqHKmcpN7m0CT9Qk9Mzny?=
 =?us-ascii?Q?4HFasoS+/rWmTEyqiXbWGZIjc3MALBbd69DpNRE48FtAIXRVmyrOAjkofG7z?=
 =?us-ascii?Q?ZdmGA0O5f2jWgyRfrSKbLT6rhC6a8n9MtJrv5yHQRlTFJDywuyewqI9uPFSJ?=
 =?us-ascii?Q?YfLXy7JYDhumanIYUw0d5CfhQ/Xn79AhIwj8v+Ih/kFOTPgOYfblStnxL8kV?=
 =?us-ascii?Q?SyL6Tl5xu/4tkFJ5K2YqW+rj/lhQhgHIYAzcFw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X9ULpXite+LR43bJjLba9ddSH80MGYh23FklTHvNfqmObUTxDxymdsp01diP?=
 =?us-ascii?Q?lKXv7HErB68jRkMhyHeJI4EilUgTBpgtLuYF1gVLkqv1j414uEf07bVOP5wn?=
 =?us-ascii?Q?Rsm/yHlNa4OI1Amyb0QG3LuBYQF+2Mw4IuA5ZqgvdHTR6Hb3NszMCTw951HY?=
 =?us-ascii?Q?BVKGUu45FJ3W4qcMghPQK2ihWbChElXhq1Zp++9ZNPuWLd3iPUYnSpSvm56h?=
 =?us-ascii?Q?4JAdAYESiV9vP4JyYgOOdcM6SVnP7hnfVixHb4HPMJ0E8H/1CxlDlKkolyOW?=
 =?us-ascii?Q?N3Uapm0j5ekpoO6WyLjL0RYgxagn0o3JXRazn5Mkq7SmUT5S2rLn/uQd8ryh?=
 =?us-ascii?Q?f0tVFCDeJwBDXIg9+eVthkUUYzsVFf4x64SplmTYB9UT6TMUAccVSd8M0BzO?=
 =?us-ascii?Q?Gjb+AvB5e6TppFtua8cJXDXJfpkDOX/20NMXSPl8Ej7tFKVKVu4rMmOhYBYo?=
 =?us-ascii?Q?o8BEOT/bgV/w3G8jpaLCCvYgREIJIw/HJBQ8CyQGvrrRag0+Gr4JisWQwbzi?=
 =?us-ascii?Q?QnOCJFqNZYznZ+z4fw50T60K5JQNymkPx7pi7ywPHH3UXcjamz7tczCDWXjA?=
 =?us-ascii?Q?rKSd6fvAzjchryPKuAtfjoUjXDSOPAclcc8XWOCd6FAbThPxa4Uhtbt773x6?=
 =?us-ascii?Q?WiSo24uVhlHMJYogH5Y9xUIptEHEPyOc0y+s04NwTxqO3v5DN9R7FRPmEvaQ?=
 =?us-ascii?Q?Bnpf8sUsWT3Bkh5LAuRX2POxyiU1980Ticua09fmF2lqCNl9w2YZA6D/e5J9?=
 =?us-ascii?Q?fkVVNddAIgAPLHry7669BQ75swiSF+LKBXTbHoB1qxIFjfirrugHhjbARje3?=
 =?us-ascii?Q?21K8NbcV9Us/Tz/IDzJWEaaiOefCbApUSO6mxorVSXhFViLbsikOlEyCMq+l?=
 =?us-ascii?Q?4qeNliK+LILC85F36zUwhGKZA8FTesdNYGYBepbJYv7uS/gh+Mx9YsBs6ZRo?=
 =?us-ascii?Q?wTiQdOwq0lHw3+lF33R+1bXCiTMPdDIyZaRwX1j+UXX2EmYiEgDwWktuMxlr?=
 =?us-ascii?Q?wfhdEmyUyEpBlH83bzXC5r5tsnOX/yJJ+vFcJHc99pUpYQs3rmp0THHUHDF8?=
 =?us-ascii?Q?Fh1YnCL+BO2aISCoBMWfjInZmT1g//YducwQGNseISgZ00lCL08f5lOlqDLb?=
 =?us-ascii?Q?ehMjbW7vEYbGvQKn6PwaUiaA7fkf4EwnJ7c9sJIqYwWWPbkc9qLTvu4jgC8x?=
 =?us-ascii?Q?aOz9vkAOKXk0I9SbXqKKO59AZwggF+nZCbvGTFYhhswgUtxOJ9zEF130TKI?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a5e9182-74e8-4824-6a4a-08dd668b318a
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2025 02:10:17.3670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB10569

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Tuesday, Marc=
h 18, 2025 5:34 PM
>=20
> On 3/17/2025 4:51 PM, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday=
,
> February 26, 2025 3:08 PM
> <snip>
> >> +
> >> +/* TODO move this to another file when debugfs code is added */
> >> +enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */
> >> +#if defined(CONFIG_X86)
> >> +	VpRootDispatchThreadBlocked			=3D 201,
> >> +#elif defined(CONFIG_ARM64)
> >> +	VpRootDispatchThreadBlocked			=3D 94,
> >> +#endif
> >> +	VpStatsMaxCounter
> >> +};
> >
> > Where do these "magic" numbers come from?  Are they matching something
> > in the Hyper-V host?
> >
> They are part of the hypervisor ABI and really belong in hvhdk.h. These e=
nums
> have many members which we use in another part of the code but which are =
omitted
> here.
>=20
> For this patchset I put them here to avoid putting PascalCase definitions=
 in the
> global namespace. I was undecided if we want to keep them like this (mayb=
e keeping
> them out of hvhdk.h), or change them to linux style in a followup.

OK.  I don't object to them staying like this pending a future decision.

> <snip>
> >> +
> >> +	switch (args.type) {
> >> +	case MSHV_VP_STATE_LAPIC:
> >> +		state_data.type =3D HV_GET_SET_VP_STATE_LAPIC_STATE;
> >> +		data_sz =3D HV_HYP_PAGE_SIZE;
> >> +		break;
> >> +	case MSHV_VP_STATE_XSAVE:
> >
> > Just FYI, you can put a semicolon after the colon on the above line, wh=
ich
> > adds a null statement, and then the C compiler will accept the definiti=
on
> > of local variable data_sz_64 without needing the odd-looking braces.
> >
> > I learn something new every day! :-)
> >
> I didn't know that! But actually I prefer the braces because they clearly
> denote a new block scope for that case.

That's fine.

> >> +	{
> >> +		u64 data_sz_64;
> >> +
> >> +		ret =3D hv_call_get_partition_property(vp->vp_partition->pt_id,
> >> +						     HV_PARTITION_PROPERTY_XSAVE_STATES,
> >> +						     &state_data.xsave.states.as_uint64);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		ret =3D hv_call_get_partition_property(vp->vp_partition->pt_id,
> >> +						     HV_PARTITION_PROPERTY_MAX_XSAVE_DATA_SIZE,
> >> +						     &data_sz_64);
> >> +		if (ret)
> >> +			return ret;
> >> +
> >> +		data_sz =3D (u32)data_sz_64;
> >> +		state_data.xsave.flags =3D 0;
> >> +		/* Always request legacy states */
> >> +		state_data.xsave.states.legacy_x87 =3D 1;
> >> +		state_data.xsave.states.legacy_sse =3D 1;
> >> +		state_data.type =3D HV_GET_SET_VP_STATE_XSAVE;
> >> +		break;
> >> +	}
> >> +	case MSHV_VP_STATE_SIMP:
> >> +		state_data.type =3D HV_GET_SET_VP_STATE_SIM_PAGE;
> >> +		data_sz =3D HV_HYP_PAGE_SIZE;
> >> +		break;
> >> +	case MSHV_VP_STATE_SIEFP:
> >> +		state_data.type =3D HV_GET_SET_VP_STATE_SIEF_PAGE;
> >> +		data_sz =3D HV_HYP_PAGE_SIZE;
> >> +		break;
> >> +	case MSHV_VP_STATE_SYNTHETIC_TIMERS:
> >> +		state_data.type =3D HV_GET_SET_VP_STATE_SYNTHETIC_TIMERS;
> >> +		data_sz =3D sizeof(vp_state.synthetic_timers_state);
> >> +		break;
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	if (copy_to_user(&user_args->buf_sz, &data_sz, sizeof(user_args->buf=
_sz)))
> >> +		return -EFAULT;
> >> +
> >> +	if (data_sz > args.buf_sz)
> >> +		return -EINVAL;
> >> +
> >> +	/* If the data is transmitted via pfns, delegate to helper */
> >> +	if (state_data.type & HV_GET_SET_VP_STATE_TYPE_PFN) {
> >> +		unsigned long user_pfn =3D PFN_DOWN(args.buf_ptr);
> >> +		size_t page_count =3D PFN_DOWN(args.buf_sz);
> >> +
> >> +		return mshv_vp_ioctl_get_set_state_pfn(vp, state_data, user_pfn,
> >> +						       page_count, is_set);
> >> +	}
> >> +
> >> +	/* Paranoia check - this shouldn't happen! */
> >> +	if (data_sz > sizeof(vp_state)) {
> >> +		vp_err(vp, "Invalid vp state data size!\n");
> >> +		return -EINVAL;
> >> +	}
> >
> > I don't understand the above check.  sizeof(vp_state) is relatively sma=
ll since
> > it is effectively sizeof(hv_synthetic_timers_state), which is 200 bytes=
 if I've
> > done the arithmetic correctly. But data_sz could be a full page (4096 b=
ytes)
> > for the LAPIC, SIMP, and SIEFP cases, and the check would cause an erro=
r to
> > be returned.
> >
> data_sz > sizeof(vp_state) is true if and only if the HV_GET_SET_VP_STATE=
_TYPE_PFN
> bit is set in state_data.type. This check ensures that invariant holds.
>=20
> See just above where we delegate to mshv_vp_ioctl_get_set_state_pfn() in =
that case.

OK. Got it now. =20

>=20
> >> +
> >> +	if (is_set) {
> >> +		if (copy_from_user(&vp_state, (__user void *)args.buf_ptr, data_sz)=
)
> >> +			return -EFAULT;
> >> +
> >> +		return hv_call_set_vp_state(vp->vp_index,
> >> +					    vp->vp_partition->pt_id,
> >> +					    state_data, 0, NULL,
> >> +					    sizeof(vp_state), (u8 *)&vp_state);
> >
> > This is one of the cases where data from user space gets passed directl=
y to
> > the hypercall. So user space is responsible for ensuring that reserved =
fields
> > are zero'ed and for otherwise ensuring a proper hypercall input. I just
> > wonder if user space really does this correctly.
> >
> The interfaces that are 'passthrough' like this remove quite a bit of
> complexity from the kernel code and delegates it to userspace and the hyp=
ervisor.
>=20
> It is on userspace to ensure the parameters are valid, and it's on the
> hypervisor to check the fields and error if they are used improperly.
>=20
> Note the hypervisor still needs to check everything regardless of if it c=
omes
> from the kernel or directly from userspace.
>=20
> >> +
> >> +static vm_fault_t mshv_vp_fault(struct vm_fault *vmf)
> >> +{
> >> +	struct mshv_vp *vp =3D vmf->vma->vm_file->private_data;
> >> +
> >> +	switch (vmf->vma->vm_pgoff) {
> >> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
> >> +		vmf->page =3D virt_to_page(vp->vp_register_page);
> >> +		break;
> >> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
> >> +		vmf->page =3D virt_to_page(vp->vp_intercept_msg_page);
> >> +		break;
> >> +	case MSHV_VP_MMAP_OFFSET_GHCB:
> >> +		if (is_ghcb_mapping_available())
> >> +			vmf->page =3D virt_to_page(vp->vp_ghcb_page);
> >> +		break;
> >
> > If there's no GHCB mapping available, execution just continues with
> > vmf->page not set. Won't the later get_page() call fail? Perhaps this
> > should fail if there's no GHCB mapping available. Or maybe there's
> > more about how this works that I'm ignorant of. :-)
> >
> Hmm, maybe this check should just be removed. If we got here it means
> the vmf->vma->vm_pgoff was already set in mmap(), so the page should be
> valid in that case.
>=20
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	get_page(vmf->page);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int mshv_vp_mmap(struct file *file, struct vm_area_struct *vma=
)
> >> +{
> >> +	struct mshv_vp *vp =3D file->private_data;
> >> +
> >> +	switch (vma->vm_pgoff) {
> >> +	case MSHV_VP_MMAP_OFFSET_REGISTERS:
> >> +		if (!vp->vp_register_page)
> >> +			return -ENODEV;
> >> +		break;
> >> +	case MSHV_VP_MMAP_OFFSET_INTERCEPT_MESSAGE:
> >> +		if (!vp->vp_intercept_msg_page)
> >> +			return -ENODEV;
> >> +		break;
> >> +	case MSHV_VP_MMAP_OFFSET_GHCB:
> >> +		if (is_ghcb_mapping_available() && !vp->vp_ghcb_page)
> >> +			return -ENODEV;
> >> +		break;
> >
> > Again, if no GHCB mapping is available, should this return success?
> >
> I think this should just check the vp->vp_ghcb_page is not NULL, like
> the other cases. is_ghcb_mapping_available() is already checked to
> decide whether to map the page in the first place. I'll change it.
>=20
> >> +	default:
> >> +		return -EINVAL;
> >> +	}
> >> +
> >> +	vma->vm_ops =3D &mshv_vp_vm_ops;
> >> +	return 0;
> >> +}
> <snip>
> >> +
> >> +	input_vtl.as_uint8 =3D 0;
> >
> > I see eight occurrences in this source code file where the above statem=
ent
> > occurs and there is no further modification. Perhaps declare a static
> > variable that is initialized properly, and use it as the input paramete=
r to the
> > various functions.  A second static variable could have the use_target_=
vtl =3D 1
> > setting that is needed in three places.
> >
> I was a bit doubtful, but I tried this and it removes quite a few lines w=
ithout
> much tradeoff in readability. Thanks!
>=20
> >> +	ret =3D hv_call_map_vp_state_page(partition->pt_id, args.vp_index,
> >> +					HV_VP_STATE_PAGE_INTERCEPT_MESSAGE,
> >> +					input_vtl,
> >> +					&intercept_message_page);
> <snip>
>> +static int mshv_init_async_handler(struct mshv_partition *partition)
> >> +{
> >> +	if (completion_done(&partition->async_hypercall)) {
> >> +		pt_err(partition,
> >> +		       "Cannot issue another async hypercall, while another one in =
progress!\n");
> >
> > Two uses of word "another" in the error message is redundant.  Perhaps
> >
> > 	"Cannot issue async hypercall while another one is in progress!"
> >
> Thanks, I'll change it.
>=20
> <snip>
>> +
> >> +	/* Reject overlapping regions */
> >> +	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
> >> +	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_page=
s - 1) ||
> >> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr) |=
|
> >> +	    mshv_partition_region_by_uaddr(partition, mem->userspace_addr + =
mem- size - 1))
> >> +		return -EEXIST;
> >
> > Having to fully walk the partition region list four times for the above=
 checks
> > isn't the most efficient approach, but I'm guessing that creating a reg=
ion isn't
> > really a hot path so it doesn't matter. And I don't know how long the r=
egion list
> > typically is.
> >
> Indeed, it seems wasteful at first but the list is usually only a few ent=
ries long,
> and regions are rarely added or removed (usually just at boot).

OK, not a problem then.

>=20
> <snip>
>> +/* Called for unmapping both the guest ram and the mmio space */
> >> +static long
> >> +mshv_unmap_user_memory(struct mshv_partition *partition,
> >> +		       struct mshv_user_mem_region mem)
> >> +{
> >> +	struct mshv_mem_region *region;
> >> +	u32 unmap_flags =3D 0;
> >> +
> >> +	if (!(mem.flags & BIT(MSHV_SET_MEM_BIT_UNMAP)))
> >> +		return -EINVAL;
> >> +
> >> +	if (hlist_empty(&partition->pt_mem_regions))
> >> +		return -EINVAL;
> >
> > Isn't the above check redundant, given the lookup by gfn that is
> > done immediately below?
> >
> Yes, I'll remove it.
>=20
> >> +
> >> +	region =3D mshv_partition_region_by_gfn(partition, mem.guest_pfn);
> >> +	if (!region)
> >> +		return -EINVAL;
> <snip>
>> +	case MSHV_GPAP_ACCESS_TYPE_ACCESSED:
> >> +		hv_type_mask =3D 1;
> >> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> >> +			hv_flags.clear_accessed =3D 1;
> >> +			/* not accessed implies not dirty */
> >> +			hv_flags.clear_dirty =3D 1;
> >> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> >
> > Avoid C++ style comments.
> >
> Ack
>=20
> >> +			hv_flags.set_accessed =3D 1;
> >> +		}
> >> +		break;
> >> +	case MSHV_GPAP_ACCESS_TYPE_DIRTY:
> >> +		hv_type_mask =3D 2;
> >> +		if (args.access_op =3D=3D MSHV_GPAP_ACCESS_OP_CLEAR) {
> >> +			hv_flags.clear_dirty =3D 1;
> >> +		} else { // MSHV_GPAP_ACCESS_OP_SET
> >
> > Same here.
> >
> Ack
>=20
> >> +			hv_flags.set_dirty =3D 1;
> >> +			/* dirty implies accessed */
> >> +			hv_flags.set_accessed =3D 1;
> >> +		}
> >> +		break;
> >> +	}
> >> +
> >> +	states =3D vzalloc(states_buf_sz);
> >> +	if (!states)
> >> +		return -ENOMEM;
> >> +
> >> +	ret =3D hv_call_get_gpa_access_states(partition->pt_id, args.page_co=
unt,
> >> +					    args.gpap_base, hv_flags, &written,
> >> +					    states);
> >> +	if (ret)
> >> +		goto free_return;
> >> +
> >> +	/*
> >> +	 * Overwrite states buffer with bitmap - the bits in hv_type_mask
> >> +	 * correspond to bitfields in hv_gpa_page_access_state
> >> +	 */
> >> +	for (i =3D 0; i < written; ++i)
> >> +		assign_bit(i, (ulong *)states,
> >
> > Why the cast to ulong *?  I think this argument to assign_bit() is void=
 *, in
> > which case the cast wouldn't be needed.
> >
> It looks like assign_bit() and friends resolve to a set of functions whic=
h do
> take an unsigned long pointer, e.g.:
>=20
> __set_bit() -> generic___set_bit(unsigned long nr, volatile unsigned long=
 *addr)
> set_bit() -> arch_set_bit(unsigned int nr, volatile unsigned long *p)
> etc...
>=20
> So a cast is necessary.

Indeed, you are right.  Seems like set_bit() and friends should take a void=
 *.
But that's a different kettle of fish.

>=20
> > Also, assign_bit() does atomic bit operations. Doing such in a loop lik=
e
> > here will really hammer the hardware memory bus with atomic
> > read-modify-write cycles. Use __assign_bit() instead, which does
> > non-atomic operations. You don't need atomic here as no other
> > threads are modifying the bit array.
> >
> I didn't realize it was atomic. I'll change it to __assign_bit().
>=20
> >> +			   states[i].as_uint8 & hv_type_mask);
> >
> > OK, so the starting contents of "states" is an array of bytes. The endi=
ng
> > contents is an array of bits. This works because every bit in the endin=
g
> > bit array is set to either 0 or 1. Overlap occurs on the first iteratio=
n
> > where the code reads the 0th byte, and writes the 0th bit, which is par=
t of
> > the 0th byte. The second iteration reads the 1st byte, and writes the 1=
st bit,
> > which doesn't overlap, and there's no overlap from then on.
> >
> > Suppose "written" is not a multiple of 8. The last byte of "states" as =
an
> > array of bits will have some bits that have not been set to either 0 or=
 1 and
> > might be leftover garbage from when "states" was an array of bytes. Tha=
t
> > garbage will get copied to user space. Is that OK? Even if user space k=
nows
> > enough to ignore those bits, it seems a little dubious to be copying ev=
en
> > a few bits of garbage to user space.
> >
> > Some comments might help here.
> >
> This is a good point. The expectation is indeed that userspace knows whic=
h
> bits are valid from the returned "written" value, but I agree it's a bit
> odd to have some garbage bits in the last byte. How does this look (to be
> inserted here directly after the loop):
>=20
> +       /* zero the unused bits in the last byte of the returned bitmap *=
/
> +       if (written > 0) {
> +               u8 last_bits_mask;
> +               int last_byte_idx;
> +               int bits_rem =3D written % 8;
> +
> +               /* bits_rem =3D=3D 0 when all bits in the last byte were =
assigned */
> +               if (bits_rem > 0) {
> +                       /* written > 0 ensures last_byte_idx >=3D 0 */
> +                       last_byte_idx =3D ((written + 7) / 8) - 1;
> +                       /* bits_rem > 0 ensures this masks 1 to 7 bits */
> +                       last_bits_mask =3D (1 << bits_rem) - 1;
> +                       states[last_byte_idx].as_uint8 &=3D last_bits_mas=
k;
> +               }
> +       }

A simpler approach is to "continue" the previous loop.  And if "written"
is zero, this additional loop won't do anything either:=20

	for (i =3D written; i < ALIGN(written, 8); ++i)
		__clear_bit(i, (ulong *)states);

>=20
> The remaining bytes could be memset() to zero but I think it's fine to le=
ave
> them.

I agree.  The remaining bytes aren't written back to user space anyway
since the copy_to_user() uses bitmap_buf_sz.

>=20
> >> +
> >> +	args.page_count =3D written;
> >> +
> >> +	if (copy_to_user(user_args, &args, sizeof(args))) {
> >> +		ret =3D -EFAULT;
> >> +		goto free_return;
> >> +	}
> >> +	if (copy_to_user((void __user *)args.bitmap_ptr, states, bitmap_buf_=
sz))
> >> +		ret =3D -EFAULT;
> >> +
> >> +free_return:
> >> +	vfree(states);
> >> +	return ret;
> >> +}
> <snip>
> >> +static void
> >> +handle_bitset_message(const struct hv_vp_signal_bitset_scheduler_mess=
age *msg)
> >> +{
> >> +	int bank_idx, vps_signaled =3D 0, bank_mask_size;
> >> +	struct mshv_partition *partition;
> >> +	const struct hv_vpset *vpset;
> >> +	const u64 *bank_contents;
> >> +	u64 partition_id =3D msg->partition_id;
> >> +
> >> +	if (msg->vp_bitset.bitset.format !=3D HV_GENERIC_SET_SPARSE_4K) {
> >> +		pr_debug("scheduler message format is not HV_GENERIC_SET_SPARSE_4K"=
);
> >> +		return;
> >> +	}
> >> +
> >> +	if (msg->vp_count =3D=3D 0) {
> >> +		pr_debug("scheduler message with no VP specified");
> >> +		return;
> >> +	}
> >> +
> >> +	rcu_read_lock();
> >> +
> >> +	partition =3D mshv_partition_find(partition_id);
> >> +	if (unlikely(!partition)) {
> >> +		pr_debug("failed to find partition %llu\n", partition_id);
> >> +		goto unlock_out;
> >> +	}
> >> +
> >> +	vpset =3D &msg->vp_bitset.bitset;
> >> +
> >> +	bank_idx =3D -1;
> >> +	bank_contents =3D vpset->bank_contents;
> >> +	bank_mask_size =3D sizeof(vpset->valid_bank_mask) * BITS_PER_BYTE;
> >> +
> >> +	while (true) {
> >> +		int vp_bank_idx =3D -1;
> >> +		int vp_bank_size =3D sizeof(*bank_contents) * BITS_PER_BYTE;
> >> +		int vp_index;
> >> +
> >> +		bank_idx =3D find_next_bit((unsigned long *)&vpset->valid_bank_mask=
,
> >> +					 bank_mask_size, bank_idx + 1);
> >> +		if (bank_idx =3D=3D bank_mask_size)
> >> +			break;
> >> +
> >> +		while (true) {
> >> +			struct mshv_vp *vp;
> >> +
> >> +			vp_bank_idx =3D find_next_bit((unsigned long *)bank_contents,
> >> +						    vp_bank_size, vp_bank_idx + 1);
> >> +			if (vp_bank_idx =3D=3D vp_bank_size)
> >> +				break;
> >> +
> >> +			vp_index =3D (bank_idx << HV_GENERIC_SET_SHIFT) + vp_bank_idx;
> >
> > This would be clearer if just multiplied by bank_mask_size instead of s=
hifting.
> > Since the compiler knows the constant value of bank_mask_size, it shoul=
d generate
> > the same code as the shift.
> >
> I agree, but it should be multiplied by vp_bank_size as that's the size o=
f a bank
> in bits, as opposed bank_mask_size which is the size of the valid banks m=
ask in bits.

Yep, you are right.

>=20
> (They're both the same value though, 64).
>=20
> <snip>>> +
> >> +/*
> >> + * Map various VP state pages to userspace.
> >> + * Multiply the offset by PAGE_SIZE before being passed as the 'offse=
t'
> >> + * argument to mmap().
> >> + * e.g.
> >> + * void *reg_page =3D mmap(NULL, PAGE_SIZE, PROT_READ|PROT_WRITE,
> >> + *                       MAP_SHARED, vp_fd,
> >> + *                       MSHV_VP_MMAP_OFFSET_REGISTERS * PAGE_SIZE);
> >> + */
> >
> > This is interesting.  I would not have thought PAGE_SIZE is available
> > in the UAPI.  You must use something like the getpagesize() call. I kno=
w
> > the root partition can only run with a 4K page size, but the symbol
> > "PAGE_SIZE" is probably kernel code only.
> >
> PAGE_SIZE here is meant to imply using whatever the system page size is,
> but I think it's probably better to be explicit in the example. I will
> change it to sysconf(_SC_PAGE_SIZE) as that seems to be the recommended w=
ay.
>=20
> While at it I realized there were some more references to PAGE_SIZE and
> HV_HYP_PAGE_SIZE in this file, but neither are defined in uapi.
> I'm going to add a new #define MSHV_HV_PAGE_SIZE which matches the
> hypervisor native page size of 0x1000 for these cases.

OK.

>=20
> This mmap() call is the only time where the system page size is needed
> instead of the Hyper-V page size.
>=20

Michael

