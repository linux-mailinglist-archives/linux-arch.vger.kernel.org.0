Return-Path: <linux-arch+bounces-10537-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68824A5546F
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 19:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 162D317BD42
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 18:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CD625D541;
	Thu,  6 Mar 2025 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="GzeA/g1N"
X-Original-To: linux-arch@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazolkn19011029.outbound.protection.outlook.com [52.103.14.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46A917799F;
	Thu,  6 Mar 2025 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.14.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741284558; cv=fail; b=AGRDnPcNeG0lmYq2V+NIvshRa5aQqyYDP/S9H/wD8+du53KAGR2mBTQwDDjovK7aa/1a5s4IlodOO3rE0rptV6IFeABZRWhKQafO4nmw4LCPE9yoQDfBbZMZQzxwnWq/FKAY78Dfh/J+p67BlYyUq5VLDYm6OGoqbMk9J7s9Q0E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741284558; c=relaxed/simple;
	bh=jT63kX9RS5DVT1U3sdxy8GovlJz0RPT22wXTjyq4uWQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0jE0t9MORRuXGqtNxoShjVPP4KnaGC+miyf95Xu55Ko+Dzim3HBVk6UwhNzQTxFrS6HZSJqtgOPgoQ5tK8y3LtcByjflALwag7LxPWPjrPvCDNdBvSNdsnDhsOUzt7kFjW/4tm1D+Qthox+NnSas7hPSWWfI94oN6RmJwFysyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=GzeA/g1N; arc=fail smtp.client-ip=52.103.14.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHdNrbxo6NWhZ5Uhz+yEi56SA5lwL/jea6gDg75jqfsP6hLfq39bxfOK/l3HXvQ11Wm6psYL0o1yYEGlFAi49Os0pwQ1ylU1NqCQHJLdXZekaEaQTtggtb3e8JEFMKjC0vidolkUVdQXQRs/nnH2u4KmTahzIin/wmV75fLO5oJ0VkxNPl7PYMvTUjWtofjpoiZhgvPHL3upqXMRT6jLsneKsX0fBtn3ajCDv/+msqOuh+4+GgwR7r3DMEU/1qmiEm60ALG3BQr3H0GTZn5TDnyjnfAhGdU1RAffHTu8c4xstwag30cqrMzXp9frQXM9zSwGbJS5BNEdIdLPaveEXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nA5tjKdt26omMaaVaYhFvvU1G2Zc3CunBlT5Uls6vXk=;
 b=ISOwYaS4x64bJfhNquKgU0xnjiVb0a0NI0h0CjZBXyrfvZNdJCdz1cvbL4oOeVsblplpP9j6qGrjpkXE6H/rH/Pp7C2MOk3q3RjntzhBlmebkHvcLXj++fThw6jzlI6AZODvgii+7Bj9NJ+K9J9WWpbFwymP7uKiz2A8gvqYaBdgx4W5RgP/Uucf555e+RhBi0XJtTB9xhz4MGFej6+sQsrCwE+Uqjo3HN2qJpUhJqt17572wMWYFZY7Ac+wSkvooojEhvxaOlegxZHNNjsOHDKufMDxRcV4Y1H2jzS1afq1XoslbFnEQzyDhrAs9mTS5u4G5tw4mSjd78fTKqi3Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nA5tjKdt26omMaaVaYhFvvU1G2Zc3CunBlT5Uls6vXk=;
 b=GzeA/g1NOqG+xNrgKr12AcoskVBnPJrKiPsxYuvaTOFtQFyPb+anWfw03xKyo0zH2YEt0xb46NB9zKTTimZq2Veb9Rc18qWhQCk2oxkjdD2roTIF2Ujkqf4rFN/Ee8vRruibrXmVEtWqHw5yewh9zC5tpdY5wz1fqUxSOufOqk2vz0w674hffkgXCWyxSE2SsmHqDtNI5m0A+na7tEmRrpgQGD3rw3tkQvDb+2q2So39qKELjS4IuF4bE2iBJa/1fcrmtJiNjOjuhXXRhgwIC3cwuu3NadzkuMNH3/Xgv964xy4pRT6P5WX//4nM9OC6LhfQPhraLNLq3+eDjZl6pw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7127.namprd02.prod.outlook.com (2603:10b6:510:1b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.19; Thu, 6 Mar
 2025 18:09:11 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8511.017; Thu, 6 Mar 2025
 18:09:11 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Michael Kelley <mhklinux@outlook.com>, Nuno Das Neves
	<nunodasneves@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
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
Subject: RE: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Topic: [PATCH v5 01/10] hyperv: Convert Hyper-V status codes to strings
Thread-Index: AQHbiKNs/uCEZOh33UCUZSZ5oZ+szbNma5PQgAAGYrA=
Date: Thu, 6 Mar 2025 18:09:11 +0000
Message-ID:
 <SN6PR02MB4157629A6197A8A6C992BB75D4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-2-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB41577560030C55503D1BAFDCD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To:
 <SN6PR02MB41577560030C55503D1BAFDCD4CA2@SN6PR02MB4157.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7127:EE_
x-ms-office365-filtering-correlation-id: a44c7b4d-670a-463c-fa53-08dd5cd9feee
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|12121999004|19110799003|461199028|8062599003|8060799006|13041999003|3412199025|440099028|102099032|41001999003|12091999003|1710799026;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?WzKCo1NYh2eDir5PEF3NBwXnBihAEqWXfMVnAm5jGdWhUEmB+bHgftRQQ6eJ?=
 =?us-ascii?Q?lskD7Ktd8I3HnQtKUg8fv1wBXV973UR1f415sRfwoS+CitqiUTP3QK4D9yvh?=
 =?us-ascii?Q?X3lVmUv9ove5yi+djhCTh4oPQ7j53wyimFvy3St7UmCOiz6LWhIxZC1xApjq?=
 =?us-ascii?Q?w9ZOaZ/7mLrjOe0jPyEMQ0FGgcIqOeoybY85persVDjUxBHu3ZX/Cd3saTvj?=
 =?us-ascii?Q?CA8LE6NGKg1eUeDJnjU/fzpEniNaL681M/TI7vedsEcCLQAmsJlkDdC3spx8?=
 =?us-ascii?Q?LrwM1Ewv1IwhwWZwgFdKYuo3rJm65KgekgCw5oQlp5a/gz+Rs/mWYxcQO+dO?=
 =?us-ascii?Q?+rmBEomXe7qtQxBsm8t68nCuM2R5BeXvHzSNhx/BitJqlFx08/bQ1Mbw3/rN?=
 =?us-ascii?Q?rC5mMr5IWyzdegpgY7fbGnO0RCwN9OSRkxCN00lNA2ZOfNDpaYOKxRIWH/cC?=
 =?us-ascii?Q?jxgdeB+Bt3KZnJXyO6rjJiavNlhtZyaPgiqN/lfqUiBeVG7o1lUlnVaSETMv?=
 =?us-ascii?Q?8Qa9b7cZ+gdJ0BoLUVbSzi7qSRpKjQ+q+bWp2+Vdv7qrC4n1PjIbg2mGrxDO?=
 =?us-ascii?Q?kLvmR8oqEDeck39feav1EAUHvN8jhlBHxFZsSYJFfcgGj0iVoLIYpBWDzyIV?=
 =?us-ascii?Q?23ViaNNgoTa//Rwg1HbHnUIktMHfKq/S7kqSlf12oJAmpT44Kpbl8QCMAh8M?=
 =?us-ascii?Q?AYTjx+KN+vmYPcc4+jkAXuoHxmxO6Tsl6ohRYkKogCK9jlyPO1qy09X8kzmf?=
 =?us-ascii?Q?XOIx7mmKNCoP5YCziC+nptUrj0pWKE30/qz+Ber2vQb7bWx0L8IYMlj425sF?=
 =?us-ascii?Q?5bAlp4ZzUPpeiH8bNUbthGBTvO1SF/dpWfTQngpM02hFtivsSIR1E6lt4wGQ?=
 =?us-ascii?Q?0mKSe4dXH4ohPB+Vxij87BcHPl0qsLqmNa+JHHJREixMhDRn8yIjQ5s767DA?=
 =?us-ascii?Q?9YrQ1XTjH2qmJh5HoVMx4x/PvGRdbsQqXscPEPe1yGIe1fOSkjv93hVB2HiK?=
 =?us-ascii?Q?CCJIpMybRgUR4rGoT3IBKiKTURHQrlCCYriW6aHFmUCvJ7CnUTXC6cJsjquA?=
 =?us-ascii?Q?UitgkZG4Bg2FQlbLSevN3Bpi5JAO22DZgsIxbRK19zApgVXhgzBygizIEnyK?=
 =?us-ascii?Q?vdJIazHYC9L8S6Fm5CWZFsByOigFyQv3oZzpzqk+0JobZqsVTBJaGJ9vnUjR?=
 =?us-ascii?Q?qmwL3U7Dg59f+kVbFW0X0i/fObJDaqJrKyDhOw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4DsHk5D2Up16GtNMcaZa7QJOhge3xdogAmwaZVxNHXVAwORYUG7k2ZUR8xfe?=
 =?us-ascii?Q?Yp1vsr8vuc+Xu9HV38m8NlvxCP4ov4MA50Rn+y/Aoz72mpsOnlWS6gCSpaWI?=
 =?us-ascii?Q?z2DeN2NARiHsBvtxUI12LwHl5Ki2m0pSJKyK2q4xJgw3GBdTKqFo0VVcZdxV?=
 =?us-ascii?Q?QTRvfZZJ7c491yXPfMSQOwo47Pv7ILsPI6o6mbrqyzRb56bglwGAILPjechf?=
 =?us-ascii?Q?S6YMOCxQZ43O8mIhPj1KozPRjp/4zBVnICuzZZ1WXbEbEH2LxhZn4uhoOuHz?=
 =?us-ascii?Q?K90bWeO5G42ztYpWHF357yFF4TTPIZOdJvGkpy4m0vXWF0K5SzNHJBTbMg8b?=
 =?us-ascii?Q?0ZlEvL6cdvFUpaZSQpQ7On/tQV1bgn5ejCgZVgfHdp/v4ly9MHT/astIPwyZ?=
 =?us-ascii?Q?YIwFiDyP88rAGlEyETZnvVaRrV3AXpcgiJBW7u5H10/i71PxIcZ8saX+AlO9?=
 =?us-ascii?Q?E4jqEpt80VxrBLq4zIhbeRojLNpLNOpb4JiheECGE/jaPkZWBxyTQVHce6HR?=
 =?us-ascii?Q?efxLsmFSWqNp9UHEat27J/07+aDfjRXQYsRvQQXnEkW8QCXOE/nn+RNfyumq?=
 =?us-ascii?Q?CUdI8uBKHr6K3FTJTXGIbjOU8aUKtGGiXjVrIKp5JrpYC6FbLHBh5pU71piS?=
 =?us-ascii?Q?QHemqrUwgaCVLuuO45lY/3ulPgsxFt/nwH+McYVJmFh9rDfM+SfKkQyB61b3?=
 =?us-ascii?Q?NdumZaPF/LHyVDlTuE1dt/1DK0y0yrbvJd13+VI6TPJnP2zxHwispsRqX6bV?=
 =?us-ascii?Q?ocWdXveHND9P/0+/FlAm6RujWDf7whTeagQbZAR9HqkB/g5ytWQq6MdyRsK1?=
 =?us-ascii?Q?A4K4wtgFKNlQNJxHGXdagXyPdBU4H6pQggkXvfgPerSk4+tjQ1iC6Alvnnon?=
 =?us-ascii?Q?LJRb+0iEuntCGjc5z+g6JVt+ZpROmGtQVWhjIog4Y39DsFn0WF+D0D/0Qeru?=
 =?us-ascii?Q?8v+7NuGQx4oRSd//LGW3ygQiiT2SJc+yOapgOUS7NxiSWrEUs+4XDp2crUWS?=
 =?us-ascii?Q?cJaeGE2myi1ckJHRPQ2ULhO0brWbcCIBlPnKXMG7pHMi3EXNDKWEvAQABVyH?=
 =?us-ascii?Q?GB+MozAKMkqlocED1YpB+v36HPVVhxxRJD5Plm60JfzEyGxiU90CprrMBbwT?=
 =?us-ascii?Q?mdN5lrziZhk2dtpeuHx89YZd979zPVS3pMcRn79jsCSAQan69fUKIFjlURB5?=
 =?us-ascii?Q?rm38iLMRGnAwmDlougQBKUcTH3myvOqu5p5zEkgIo6seXQdy3Rd/2RGT64s?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: a44c7b4d-670a-463c-fa53-08dd5cd9feee
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2025 18:09:11.0949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7127

From: Michael Kelley <mhklinux@outlook.com> Sent: Thursday, March 6, 2025 9=
:58 AM

>=20
> From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Wednesday, =
February
> 26, 2025 3:08 PM
> >
> > Introduce hv_result_to_string() for this purpose. This allows
> > hypercall failures to be debugged more easily with dmesg.
> >
> > Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> > ---
> >  drivers/hv/hv_common.c         | 65 ++++++++++++++++++++++++++++++++++
> >  drivers/hv/hv_proc.c           | 13 ++++---
> >  include/asm-generic/mshyperv.h |  1 +
> >  3 files changed, 74 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 9804adb4cc56..ce20818688fe 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -740,3 +740,68 @@ void hv_identify_partition_type(void)
> >  			pr_crit("Hyper-V: CONFIG_MSHV_ROOT not enabled!\n");
> >  	}
> >  }
> > +
> > +const char *hv_result_to_string(u64 hv_status)
> > +{
> > +	switch (hv_result(hv_status)) {
> > +	case HV_STATUS_SUCCESS:
> > +		return "HV_STATUS_SUCCESS";
> > +	case HV_STATUS_INVALID_HYPERCALL_CODE:
> > +		return "HV_STATUS_INVALID_HYPERCALL_CODE";
> > +	case HV_STATUS_INVALID_HYPERCALL_INPUT:
> > +		return "HV_STATUS_INVALID_HYPERCALL_INPUT";
> > +	case HV_STATUS_INVALID_ALIGNMENT:
> > +		return "HV_STATUS_INVALID_ALIGNMENT";
> > +	case HV_STATUS_INVALID_PARAMETER:
> > +		return "HV_STATUS_INVALID_PARAMETER";
> > +	case HV_STATUS_ACCESS_DENIED:
> > +		return "HV_STATUS_ACCESS_DENIED";
> > +	case HV_STATUS_INVALID_PARTITION_STATE:
> > +		return "HV_STATUS_INVALID_PARTITION_STATE";
> > +	case HV_STATUS_OPERATION_DENIED:
> > +		return "HV_STATUS_OPERATION_DENIED";
> > +	case HV_STATUS_UNKNOWN_PROPERTY:
> > +		return "HV_STATUS_UNKNOWN_PROPERTY";
> > +	case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
> > +		return "HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE";
> > +	case HV_STATUS_INSUFFICIENT_MEMORY:
> > +		return "HV_STATUS_INSUFFICIENT_MEMORY";
> > +	case HV_STATUS_INVALID_PARTITION_ID:
> > +		return "HV_STATUS_INVALID_PARTITION_ID";
> > +	case HV_STATUS_INVALID_VP_INDEX:
> > +		return "HV_STATUS_INVALID_VP_INDEX";
> > +	case HV_STATUS_NOT_FOUND:
> > +		return "HV_STATUS_NOT_FOUND";
> > +	case HV_STATUS_INVALID_PORT_ID:
> > +		return "HV_STATUS_INVALID_PORT_ID";
> > +	case HV_STATUS_INVALID_CONNECTION_ID:
> > +		return "HV_STATUS_INVALID_CONNECTION_ID";
> > +	case HV_STATUS_INSUFFICIENT_BUFFERS:
> > +		return "HV_STATUS_INSUFFICIENT_BUFFERS";
> > +	case HV_STATUS_NOT_ACKNOWLEDGED:
> > +		return "HV_STATUS_NOT_ACKNOWLEDGED";
> > +	case HV_STATUS_INVALID_VP_STATE:
> > +		return "HV_STATUS_INVALID_VP_STATE";
> > +	case HV_STATUS_NO_RESOURCES:
> > +		return "HV_STATUS_NO_RESOURCES";
> > +	case HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED:
> > +		return "HV_STATUS_PROCESSOR_FEATURE_NOT_SUPPORTED";
> > +	case HV_STATUS_INVALID_LP_INDEX:
> > +		return "HV_STATUS_INVALID_LP_INDEX";
> > +	case HV_STATUS_INVALID_REGISTER_VALUE:
> > +		return "HV_STATUS_INVALID_REGISTER_VALUE";
> > +	case HV_STATUS_OPERATION_FAILED:
> > +		return "HV_STATUS_OPERATION_FAILED";
> > +	case HV_STATUS_TIME_OUT:
> > +		return "HV_STATUS_TIME_OUT";
> > +	case HV_STATUS_CALL_PENDING:
> > +		return "HV_STATUS_CALL_PENDING";
> > +	case HV_STATUS_VTL_ALREADY_ENABLED:
> > +		return "HV_STATUS_VTL_ALREADY_ENABLED";
> > +	default:
> > +		return "Unknown";
> > +	};
> > +	return "Unknown";
> > +}
> > +EXPORT_SYMBOL_GPL(hv_result_to_string);
> > +
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 2fae18e4f7d2..8fc30f509fa7 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -87,7 +87,8 @@ int hv_call_deposit_pages(int node, u64 partition_id,=
 u32
> > num_pages)
> >  				     page_count, 0, input_page, NULL);
> >  	local_irq_restore(flags);
> >  	if (!hv_result_success(status)) {
> > -		pr_err("Failed to deposit pages: %lld\n", status);
> > +		pr_err("%s: Failed to deposit pages: %s\n", __func__,
> > +		       hv_result_to_string(status));
> >  		ret =3D hv_result_to_errno(status);
> >  		goto err_free_allocations;
> >  	}
> > @@ -137,8 +138,9 @@ int hv_call_add_logical_proc(int node, u32 lp_index=
, u32 apic_id)
> >
> >  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >  			if (!hv_result_success(status)) {
> > -				pr_err("%s: cpu %u apic ID %u, %lld\n", __func__,
> > -				       lp_index, apic_id, status);
> > +				pr_err("%s: cpu %u apic ID %u, %s\n",
> > +				       __func__, lp_index, apic_id,
> > +				       hv_result_to_string(status));
> >  				ret =3D hv_result_to_errno(status);
> >  			}
> >  			break;
> > @@ -179,8 +181,9 @@ int hv_call_create_vp(int node, u64 partition_id, u=
32 vp_index,
> > u32 flags)
> >
> >  		if (hv_result(status) !=3D HV_STATUS_INSUFFICIENT_MEMORY) {
> >  			if (!hv_result_success(status)) {
> > -				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
> > -				       vp_index, flags, status);
> > +				pr_err("%s: vcpu %u, lp %u, %s\n",
> > +				       __func__, vp_index, flags,
> > +				       hv_result_to_string(status));
> >  				ret =3D hv_result_to_errno(status);
> >  			}
> >  			break;
> > diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyp=
erv.h
> > index b13b0cda4ac8..dc4729dba9ef 100644
> > --- a/include/asm-generic/mshyperv.h
> > +++ b/include/asm-generic/mshyperv.h
> > @@ -298,6 +298,7 @@ static inline int cpumask_to_vpset_skip(struct hv_v=
pset *vpset,
> >  	return __cpumask_to_vpset(vpset, cpus, func);
> >  }
> >
> > +const char *hv_result_to_string(u64 hv_status);
> >  int hv_result_to_errno(u64 status);
> >  void hyperv_report_panic(struct pt_regs *regs, long err, bool in_die);
> >  bool hv_is_hyperv_initialized(void);
> > --
> > 2.34.1
>=20
> I've read through the other comments on this patch. I definitely vote
> for outputting both the hex code along with a string translation, which
> could be empty if the hex code is unrecognized by the translation code.
>=20
> I can see providing something like hv_hvcall_err() as Nuno proposed, sinc=
e
> that standardizes the text output. But I wonder if it would be too limiti=
ng.
> For example, in the changes above, both hv_call_add_logical_proc() and
> hv_call_create_vp() output additional debugging values, which we probably
> don't want to give up.
>=20
> Lastly, from an implementation standpoint, rather than using a big
> switch statement, build a static array of entries that each have the
> hex code and string equivalent. Then hv_result_to_string() loops through
> the array looking for a match. This won't be any slower than the big swit=
ch
> statement. I've seen other places in the kernel where string names are
> output, and looking up the strings in a static array is the typical appro=
ach.
> You'll have to work through the details and see if avoids being too clums=
y,
> but I think it will be OK.
>=20

Better yet, also include the translated errno in each static array entry.
Then hv_result_to_errno() can do the same kind of lookup instead of
having its own switch statement. I did a quick look to see if the two
functions might be combined to do only a single lookup, but that looks
somewhat clumsy unless someone else spots a better way to handle it.
The cost of doing two lookups doesn't really matter in an error case.

FWIW, hv_result_to_errno() and the new hv_result_to_string() are both
slightly misnamed. The input argument is a full 64-bit hv_status, not the
smaller 16-bit result field. hv_status_to_errno() and hv_status_to_string()
would be more precise.

Michael

