Return-Path: <linux-arch+bounces-12375-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F111ADF25C
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D293A7A68EB
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7E6280CD1;
	Wed, 18 Jun 2025 16:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="ueN6mvQ6"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10olkn2067.outbound.protection.outlook.com [40.92.41.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B72EBDF6;
	Wed, 18 Jun 2025 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.41.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263547; cv=fail; b=cJNwBCbEqslMMWm42HFkgETmE7QnpPFnFmUIHnA1onv1dM4tCbgMMLNokbn1KgVAv0ZtdH+lSswSTlVh6yQbG33Tp19bebv3nzuoZ5VDFcCuw8dsBz8y8Sz0j5r/HuXjBq9jl6sQhtYY17WFMp7opoZ9+VF9h3qutbpbzIEpm1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263547; c=relaxed/simple;
	bh=t+jRVzPgQLAY5RS8C4OW+GGezQSZWb7DOPtmIcm+26U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=a+aLly3+6vfP4nBIppk/05hCgnfluPx6GqovFCyAj1c6ZeaA1irPKjh/6NIsHWWoAruL5Btp0FwqdDIHRTPO1j8gur8SVNDLx064Du0sLSOMptBII+WxUUl+sawnddZ3V9AlMnTet+2Ukxk9k0bc94ftPueXortfaW395n2gECk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=ueN6mvQ6; arc=fail smtp.client-ip=40.92.41.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ljFp75K0OnO6LPnppMsbeFW88rFAoKWhYpQLClmtVBfSNuXTZZheE/7tsgxEsYN7e+P0102iIY4XtKjEijAdt7BB/c72Wb8p5jsxX9OSLItlMua3cXdwgmga1FAna94cr1+zGdYMqPhkcgvzN3LM2yo7+3aACS3cwDdlvssvT3Y40QA6l4ONEDkO/i164qo/Z8viSB6RaTZs83amIrbvVcaA53KKHVvTYjNEKcSBFlhhl35IYzhiY7SPj/H4E+nHzvRFTz647nh+p2TqCytlXbPu32TWEJMZpeZQpdBeNQqrW74+1lt/RVM9rat7sNNfVngh6U8cK6PJD+GxX8Hz7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKVs6N+o7he4iObtnXwIhOOWx8zFsi40nr/et+IcagQ=;
 b=lwSDAJFfKAzuCHuj8cJ/6k2jc8uE12XjV9dFqgscc/pmQPAlAougX6lA9zawLL1MQ7dV6QLD6TcTpggUnwMeahH9Xni8SLPIvo8TA20uj308XLHgBUWSY9M6aPMsS6DNLwXHjQUarlEz8cRDzkffb/nCXslhbpEgr9/WezAof98yi3s4+FEGA6918jIanso2tKIYMu7UXFYUHquqe6mrBm/t3eHxeRbTmvV7FLhxzsUgBrKLb5bfEe2XVexWrUINlnoMkCf94lw76z4p3Bqg13NA7B4GQeXML1n2xjtsxqDzu4VZjpuahhBiDwIGyr7YjTcuEag270YsD0Fg6SM91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKVs6N+o7he4iObtnXwIhOOWx8zFsi40nr/et+IcagQ=;
 b=ueN6mvQ6RL4UkNtGYQGxQxdxngdTnBNjmYaZ+h9+9ZBtyaWPCMScFWGfxS1Kgnh5RtpVktAe8MwJsFREaDY9QUUMXd1wknK8MsnVdpf79hJ35JTamrtu8/0RPdV9Ix/4LdKY2Ht0SR1K4ybuFieBnrQGl/33bdvod6FE9oP4kghNlGkuLXROudYGWyOE0Av9PDu/irKTrjxhIeFN2XynyhOTrM+DHRtpW+NYYTmy1szYvKCG34tShLJocunpQQ27dPu1omWaxIgGLDfBVd2kV4R2g2tSaNpByTeUrel/PE3qsPbAqcVP6Lqd7yO+svTYCbK9p6VTevr+bLe+sFAgTQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:18:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:18:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "alok.a.tiwari@oracle.com"
	<alok.a.tiwari@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>, "bp@alien8.de"
	<bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mingo@redhat.com"
	<mingo@redhat.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v3 09/15] Drivers: hv: Use memunmap() to check
 if the address is in IO map
Thread-Topic: [PATCH hyperv-next v3 09/15] Drivers: hv: Use memunmap() to
 check if the address is in IO map
Thread-Index: AQHb1Om8m5lQgBPLRU+srNRr3JzWmbQB5dBA
Date: Wed, 18 Jun 2025 16:18:53 +0000
Message-ID:
 <SN6PR02MB415741A2341E3AA1E32C3AE1D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-10-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-10-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 004c651f-6146-40ad-b176-08ddae83d19a
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyLtlCs+NimovH+2L5LUdRJpae61BimkSDHRQkewZ4Y7E9EiNg4cTXHwYYlZY1SErvBbAllUiuWy6bL7h3OnBliUm6zu8vLrz88nSnDRyRmQVSSz3iMPUqw0RKEvF5PjMJofs5mjalsMK8BhfO9BKRXBOBuKQfe26yCEO61Jisdv3KAgPg83dUHHncUIeM4CSsBCHqucuzxiRtiyftmtk7Jtm9Pnlr2d/slSHW1pw5ZhR/14KLTGf98tgTYOoMU8/wT98lUHrTlNZk3SRtu9xP8o9YeeeJXMpFml/ky1cIRbwlWiMwQ0j5MmQkOOS7ZrzqAe4T1uktuVADQbE9wh/kPJ9BFvMW5dsAaOlvPB1k5vTtIKrnl2N5cdAN5qhJsVPlatfXXkyfSZsJdZ/ybv9HTA9SXOKOBkooGB6QCzwK4dnI+qM9nOXjN5RbM5B4KDQdjGkAk9GtyFVHzG4qk5X4VeOmldFMazLRiXDeD87u52EDRrOYZNBLvlasypQhzg4klLSdNzIfclPY88/k4aELtfZkdN4u+/WWcMO0bd6CeoXYIYNLbtrkdJ+Oa81WUVdKWcp70DWLR+Y6cvcG7dxNTzG8e9t74doMReedLzE69WsCSDhuaQFtfFYGglf2PLXeR0Z+Ct4XZhqFw+b+ewitYCK0Tsunvhc7DWVumMtW25j6Zpw8Y8SLV05ufY4iLZYDDQjuQho+6f5XsvP1wC6nzet2OjaIIYeA=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|13041999003|3412199025|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?EsOfBmX/X1UwIMEKVxqHe8CnfO7tI6JAOoF//52iGaAr1uYvrDCpD9sT1Qlo?=
 =?us-ascii?Q?7YKO90AwagLK7yxFrdWzpRI+w6pK2PctCcFVPv2opOAHihGOsgrFCRkrCgaE?=
 =?us-ascii?Q?OcW+6PUAbzgn6fdd99nkkrtq235oZ1K39SD73hmOuBZuSIv31HhUrsjLMo+0?=
 =?us-ascii?Q?2QZCLm1S4kzkopnWriHdEhOsodM9Hq1BrTqsMEWB9hBMIyMYsHyj61Kv7tq9?=
 =?us-ascii?Q?vikRYVWjJsjga+mkXPZ252dVMI6I5wzWbX3t1w9otzG9UoRCxE83q3CLRyJv?=
 =?us-ascii?Q?oW7bQ/u7Ap71yh75tU7xPbETMLCMA3eQEh4tB644bOZPWdbcAubtR+UcksSm?=
 =?us-ascii?Q?WtPWAj2OnmdvUiqd/+/t51XZiT+IAMGZmrS+1uEfBZGgoX7MSVG+naer2idC?=
 =?us-ascii?Q?V9kIpMCQ0O8RQrmI8yE8KvpcU198OZVn1HGkDNupeFatoAL7Fl2K3CdRp7A3?=
 =?us-ascii?Q?3Wwcob7/2JmGOsnAKcGOrOMxbt+lwpGJ0TdWV2Fo1uik6uPx8PlUvcyPTknE?=
 =?us-ascii?Q?0xBfhGo7ciINvGj/g6uXgH+3uie+O4sKBp0+9KjmYJ4RsKGNdlnJQXGuFfZj?=
 =?us-ascii?Q?utZtYGz7wlBRKH8onqO2dGL1QuAkl2OYi5WiTdCYszYE0dGOCZKr/HG1RR0R?=
 =?us-ascii?Q?lU59WHgUefMEI/7ehQSKTPeUQDAD6lbS7ePt+79rqoYZbjy5RicdPpWtPJzh?=
 =?us-ascii?Q?+R3TYtRHbSdtp/6/LRZU1oTTa4TkMBrwUVlWyplWQi6JNxhoPSIvFVvD9908?=
 =?us-ascii?Q?d+M31SfSdnrFFUxEgZK844Q7wSTiom1y0v35CfsHXxnaYzjcl8baP6Qh6DxX?=
 =?us-ascii?Q?d+0CDKTaj0uGmFJu2G6q479VxPLhatKeDwwKr5afCk7YnjxVpairsTH8JpoI?=
 =?us-ascii?Q?ZV4Ps/Ub/7WIcNAMa/AX2JU6PR4wpd+eLWrHqZO2ZpdpvkH5mMMcp4ryi43m?=
 =?us-ascii?Q?ZH4b5fnHZ7YbK8gSvW4DySdGFTvD4Tk9GwlT0BTHvxMyD03wlAtKvZLyghKc?=
 =?us-ascii?Q?O+v3tPfFf22CibwHVrEJQsgluK5U6EVLR9TEVYNsFyH3cTNPnt8q7N2YI3e2?=
 =?us-ascii?Q?SA7tJ7e8J6aXY9xtmtCGNTtq392H1sfcYyK40OGC2u8CHNklWdsB9crtFqMQ?=
 =?us-ascii?Q?GWIA1M58W263jee7G2aHaU22m1DnsB9rJw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?VdZA3AnZXH4/J7/4V/1M8o2JpNuP0jq4njg79Tt6oN5zJWjW7TZczmg3kcKq?=
 =?us-ascii?Q?2lZs7ud2myJqKIg1Q4qIwuw7m2OXzpnf0iWGXbbHni3C6yCwgdaPi7Ug/y5d?=
 =?us-ascii?Q?DyjcEWpa2bKQnC1pzhiTCyj7pr/QFlTtEAPbQj8QPJVsT/bo8HmZDQzVqVc0?=
 =?us-ascii?Q?jAyCVqgZRm2mIGvWpRtFT5qkVBsn7wD3iyi4/pTFyeKKlS/wRsMSnFNPU3dV?=
 =?us-ascii?Q?Y2z5jIej+1jSijqzi6rw9n/EmkK8Fbb0t5fxEjoxu25ovyp2Oe3CIpPMOkB7?=
 =?us-ascii?Q?pN6p1/Vq0B/dpvU42PrLp57o6DPnfRYzrqJ7LHowUxPqQp4mWucEtGMm6dk7?=
 =?us-ascii?Q?YF2lwImvxHwp2xut5MIZNANvRY1AIQYZha0w7gE6V8QPfmOZjMIDVoT7Mqv0?=
 =?us-ascii?Q?r/+TGhG6UzfSnEcK12UPvFcdU5aEJvPWfbnVJwJWfbKsO6H7tyQwvg84DoWe?=
 =?us-ascii?Q?B/nIQ6tZYVXZYCswp6HYBQPsmk0soO+0MzXkVPh4Z0/RRZH4SjKcf/uEHh+N?=
 =?us-ascii?Q?VAkggBV8+MVbgyD/WMx4jlDqjc/qk5RSnIlOhEEniuLl/Ryaq+edA6lWSHpZ?=
 =?us-ascii?Q?Y1GncBdC6K6NJFS59uUP9gK+bCrRIthgTQ1n/cnFkggkzUNMAUBy3LkQxPVE?=
 =?us-ascii?Q?tHtTTNGmYxoFJlW223Y0lzgJKvmkZ5hZsG57HFYYNzpxfNi6EDJ8U2mB4ZAu?=
 =?us-ascii?Q?l4t2k/jJa+QFnj8pl6GxijjKK2ERzhNDdTEKxIOrNyHQPwhlUVHHHQ+PSxbw?=
 =?us-ascii?Q?tvEM+p1pPGAWjbNsHUoyQJVRMUY3VecUCvV9LDKEbeNdkRopXQU7Ug/YvrFS?=
 =?us-ascii?Q?5Bmpi5LUKacKZxdF4l8BFAudkKpplrbh9IWlM5azzsLAMUjaGER65FQk0WMT?=
 =?us-ascii?Q?RpoE98Su2oRH5/1iXPpk6OO1pDZEj9XFlEsUjMQ2ztJSybwZ7lVT0oARt5Cc?=
 =?us-ascii?Q?7wCieb4WNTHsmozTOnuwwQ20Etv0rYBKc2fWa7KL5l5ZvGqO1WqothmB22He?=
 =?us-ascii?Q?KgX1QxXz2fIDE8lErZEfxpoL4aR9WaxpzzKbn13YmScHpXc5sbZOliSy+yRO?=
 =?us-ascii?Q?T4GSI1B/zjop4mnQS+POW7IOvIowRTCkzMQcFa7/TmoIv7t+OSyrs0v/6rkY?=
 =?us-ascii?Q?PYo9U/RUkNygj2fukwBvcMIy+NQOGASpExj/eplS8pI7yU/FDMYgRpBMwQq/?=
 =?us-ascii?Q?4/nJ8u1cLgLNByS3JgU3rPPiAXX86kAcT++2K4lbUjyZ5SVHm5xiJf+HIls?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 004c651f-6146-40ad-b176-08ddae83d19a
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:18:53.6499
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> It might happen that some hyp SynIC pages aren't IO mapped.
>=20
> Use memunmap() that checks for that and only then calls iounmap()

I'm concerned by the lack of symmetry in using io_remap_cache()
to do the mapping, and then memunmap() to remove it. The issue
is presumably that hyp_synic_[message/event]_page might be NULL?
Or is there some other case? But I'm thinking it would be better to=20
explicitly test for NULL and only call iounmap() if non-NULL. Then there's
no dependence on the implementation of memumap().

Not doing the explicit test for NULL actually caused the problem in
the first place. When the paravisor and root partition code was
introduced, iounmap() did a test and just returned, so everything
worked. Then commit 50c6dbdfd16e was added in the 6.12 kernel,
and iounmap() started generating a WARN if NULL is passed in.

Michael

>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/hv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 6a4857def82d..9a66656d89e0 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -358,7 +358,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	 */
>  	simp.simp_enabled =3D 0;
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->hyp_synic_message_page);
> +		memunmap(hv_cpu->hyp_synic_message_page);
>  		hv_cpu->hyp_synic_message_page =3D NULL;
>  	} else {
>  		simp.base_simp_gpa =3D 0;
> @@ -370,7 +370,7 @@ void hv_synic_disable_regs(unsigned int cpu)
>  	siefp.siefp_enabled =3D 0;
>=20
>  	if (ms_hyperv.paravisor_present || hv_root_partition()) {
> -		iounmap(hv_cpu->hyp_synic_event_page);
> +		memunmap(hv_cpu->hyp_synic_event_page);
>  		hv_cpu->hyp_synic_event_page =3D NULL;
>  	} else {
>  		siefp.base_siefp_gpa =3D 0;
> --
> 2.43.0


