Return-Path: <linux-arch+bounces-12972-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C226B13D92
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 16:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A3AB3A3DCA
	for <lists+linux-arch@lfdr.de>; Mon, 28 Jul 2025 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9861226D4FC;
	Mon, 28 Jul 2025 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="B6axVmAc"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012063.outbound.protection.outlook.com [52.103.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26AA1F948;
	Mon, 28 Jul 2025 14:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753713917; cv=fail; b=DLCXcweJPn1pNzGW/mlV56bN2YgtLHqXJEdknDubgqLNuoZFl5QLDdJMm4oto4TeiQkQQJmoWVKBNgdjkZOzfMm5m9/904Jy5TMwXgdoJCwsyyF6gUp40CvJnvxRTCvQs8IovrUh4gWBvwGtNqtJS2O0On/x+osPhzMZWLI3qBM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753713917; c=relaxed/simple;
	bh=8DYvVZeAbQ/lvHoyWML7WX+BOugONuNv5IaZwhCesHM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CWgZDvUhR5yca6HY444JZdkjhVMTz4H7g/jy3nP/TzwQ/+YOaNNMKm/ZQRpUzWeqt43T5bwY5keUg5iNJvpIQU0rsk0QlDr2sBmJztjTdTSvEysrtM0GpSFq+edD+fm3dN+sL9X4+yR5lL/hr4x0++/x/sjJLXP8C9vXAdrd8Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=B6axVmAc; arc=fail smtp.client-ip=52.103.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HK8ZeLE5wAoXO/ppqVFw6tkwBXiMg3aR7k+ftLesQGlGaJ0AXw/uFtB1VmIapM2ORXoujKNf3CuDZVs29mJDgAtCbFpsWxYn4vgJlFHl4WIGmIFGkDyQ4OXhbLGSMBEHUIuNcFtDAXTd8zU8d6FRk5+Ss18w6zrO3q2xG5kfCywrcilCGdrah6taS89jbQMKF5emIJVEJYutqoybRV23FHtwLtSZUYIH6jbxGEScbNTYumevM+/tw25PSI4351a9EBp4ZDrVZBFAud8ridceM2eNOXYSnAWKVI8FtcR3iQH7HXceGczuocMjm0q2IJy1rRNJRSI2a61EMPDSzaFI8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVG3VK8mXXoHsI+lGpAWZVj7GX2ZM4t8TPZ+5g/UydY=;
 b=S0/dkuaPs4A8uYFTR84YGcJ9ttBg80LPcVaD1zyVaL9H3PuB0R5GUcVfSWWN0gEQqrmmaIJlJ7TQF/eip8vVUXXwR0BYXOIxW8ItmQ7DeMC9UbXmgolv8HTwoWBEheH4ih97EPNZX/VMQ65pg+NYZpZ1C+UI5+xoSjcaLChfUGqUwxmtDMA3zFSJc9WS9dC44nMaFv7dbed54eCZXkFyug8k5OPdDGzfIar7KX9xPhFNOqqxtWca0vXGA+n5LLayMXJyOiDQj0AqIkPwYu0kyn2Qocy0rl/isRlI4WkS8jxXUEKIrNWc6iOEa6DrRX/k/8Z+H7tFaAhA9IxlEjts7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVG3VK8mXXoHsI+lGpAWZVj7GX2ZM4t8TPZ+5g/UydY=;
 b=B6axVmAcdJ1A5P4uC1Q2qw2oZgsZWP01nY1QfJiT3DOwcftU0chPppFWbmKaaQMO7XzG8d1gyy3Ap4Rnc8nc48aFpG1x8n4cqWerv0ERcMzovB1LbvHAVVoli7elgUZJbAyXrI/MPlFLvA/fYTyC2D1+AQLjthH+u2TN/NGyxI1q3Gc4VqZW1WtgFCfORrtnkc9boSutiDjOHn2NRVQEm7jkthE0n2rY3Oc50wIuIh3Z9hWfpiUflp4XOjdk9L40dzpqU2Y6WiAqqYrLGxzBkB2EV37UNApwMhuYirGPIiTB3J3uVn9OyRRQHAq28RNUDoqrOH8fR75GPIFB+9wCDg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7783.namprd02.prod.outlook.com (2603:10b6:510:59::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.27; Mon, 28 Jul
 2025 14:45:13 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8964.023; Mon, 28 Jul 2025
 14:45:13 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Tianyu Lan <ltykernel@gmail.com>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com"
	<mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org"
	<x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>, "arnd@arndb.de"
	<arnd@arndb.de>, "Neeraj.Upadhyay@amd.com" <Neeraj.Upadhyay@amd.com>
CC: Tianyu Lan <tiala@microsoft.com>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [RFC PATCH V4 3/4] x86/hyperv: Don't use auto-eoi when Secure
 AVIC is available
Thread-Topic: [RFC PATCH V4 3/4] x86/hyperv: Don't use auto-eoi when Secure
 AVIC is available
Thread-Index: AQHb/jNS+Mo+9F1eC0eGDtlzmsYPobRHn2fQ
Date: Mon, 28 Jul 2025 14:45:13 +0000
Message-ID:
 <SN6PR02MB41574347579EFC1370154D9CD45AA@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250726134250.4414-1-ltykernel@gmail.com>
 <20250726134250.4414-4-ltykernel@gmail.com>
In-Reply-To: <20250726134250.4414-4-ltykernel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7783:EE_
x-ms-office365-filtering-correlation-id: 6973ba78-6cb6-402b-3d7a-08ddcde55c27
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|8062599012|19110799012|8060799015|461199028|440099028|40105399003|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?X7rn5hdISiLb1zqsfNK76ghkNZaxTFYLbrNR4k4P2tk/j7stg3bPp+PZWr9Q?=
 =?us-ascii?Q?eUXHKTZbzSRlxuPwtCr6kCrJYKPuSg35aKYhoKZJZ4NNeD7OZ1Rc4qdFuxvG?=
 =?us-ascii?Q?wQ9TkEh44ObcpKlrd8vFYPIPlXAYa6gvEsEbEMIwUxBiDbzSVKKEoRNUIeLu?=
 =?us-ascii?Q?lZ+gAOgpzqX1hj2ZkDPokCBzNHoISLn1+fjLotPgQXsu6FrLE9aF2q28tGad?=
 =?us-ascii?Q?fc7iAI/Ieth8ZsnnT82XXrI2mcc7spT5UJ1P6/fkhJjREyH6URNrjUDbz4il?=
 =?us-ascii?Q?wp5TzmGatZibuUI6iaQsa7s0qoXfmjM1jI7WjRkVaomFX6hPGPjhvub05B1A?=
 =?us-ascii?Q?JJnZKkcV9sDWhzUYvIMJxm71YqL5xTecvuQrj8HcWK0F48jdO20ZSG2TkW6J?=
 =?us-ascii?Q?dMIFUF7jQ+cFkvIm+rca+cCnftxDn5AxX3k+X0jNd06nHDPabphqol/fTCII?=
 =?us-ascii?Q?XvxjvrrSDvikcS8qAjKjhSyMIcnRm7JulI4hghjVE9IpAWoTr1IwJOoM/h+0?=
 =?us-ascii?Q?sIcrAyYdFpId55JaN3EhoApyfmQIIjb6vGP5NeMc6yNT6nIy+SsMDx/FdHGS?=
 =?us-ascii?Q?lPfPBk2J/0K/O/c34b47REIwlQdNff7TSp02qICVoporROsVkIBIPe5yLOqA?=
 =?us-ascii?Q?HVCIwUqR19HQTSrs7dqo9ppfK6lqQbxIygrhDdhCxlaYVEhNEoNgTJT4jd9t?=
 =?us-ascii?Q?5jBZJ19iOFyetuLmau6+/Q8M7jOkVchI2349IPPE/Lr/D7lLhaYJ4roFomp8?=
 =?us-ascii?Q?pOTfDX9Gw3+CNvQWjEFZX8Gc159y50QLcBZgcS06JARXmKxpvf0isIACzPNj?=
 =?us-ascii?Q?qDTv3i1CLQdKRL7kek2dS1P3rTDM9KJzhOXp7H5+9olcfnYxwO6OG11CjlDV?=
 =?us-ascii?Q?fsZy50h4KVgc5KE9yaJP3a1mnPXHfsOBXRaM9YL1tKPlnghoxXKKmfMLG1ru?=
 =?us-ascii?Q?4axm/5hbNg+R0ZoqxEBDcMLjweXoSeYXsXl4MqP5sJUJHj7X8oMGNGYDLC33?=
 =?us-ascii?Q?6utscM9R0A3VPzxLym86jh4sBvT02xsJLcD0GRDinq16qaL8Z2akgB0ulTP/?=
 =?us-ascii?Q?3+njEBUbWG806s/AncvWtHl4aCFdis7+vTRshJfwRApkfH2zz4M=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?FOt9mw3823zMoRkcMB7eGN2ILxwP1Chg31NK52fdsxozk0u2c9h7kl18xzx4?=
 =?us-ascii?Q?qKvh5rJlfeiF4NTLsp02c2JOXElQN1f/gVbFzuV8EAY7aTs381WdK3JrlzNr?=
 =?us-ascii?Q?sAy0oH0saDMCAwhHhZwiBkDpREY/zYYfOQv7K6Zpe1pLrw3b7DI1VtO5mhBS?=
 =?us-ascii?Q?YF4mddr9aSPDA5p9Gmz56i0T8wRxzZn+KeGrsTnAeVE+Jf1LDEBJYWUpsYdM?=
 =?us-ascii?Q?/ESDnVYHBdI2D9YGYKYx0c0E1PJWTNO1zfp6gQqS1KWpGO6jfXPdCBmrwZby?=
 =?us-ascii?Q?xKqfQtKzDOCgmirUNjJK1yCatSAbasbVBJE7dd0mvz1rG7FlxbvKimaiAwdp?=
 =?us-ascii?Q?1yedjMXoKNp/wHWe0pyeMOCZhwcvOEPulSNqz/A54VbcmLSEbt9JRweY++wt?=
 =?us-ascii?Q?OJrHPxg0LH8c0mhOkIcy5LIulOmuP8iukiOnoH/ywAwSWafE1sJGJog4bhli?=
 =?us-ascii?Q?gQ0cmnlTcjawlXXoPTbuSvJ4f3ujkisVkIqyBG6tDggidYKZ6p8t1s6rPqDs?=
 =?us-ascii?Q?FkyWacbikM0fsqkrDlgJze+jQLFB9iUYhI4P89dlnHtnxcDmV6BpISnlS4/A?=
 =?us-ascii?Q?sPC0byiN/69HI8fF//PT6vdFD7vSF9atAzPqtJ547rlJ+fAciumqMw3lNtOm?=
 =?us-ascii?Q?uH838BAvgho2i0T59Yojc7JJ3RVV0NEnGi8YMiYjoGKiqub20ilfKudrycMY?=
 =?us-ascii?Q?Q876LbapoLfX4wx+NlK+ggcVaT0m19/KaHJioYgSHLa2qyItYZLz+tLgKLx2?=
 =?us-ascii?Q?rWwFaSjYP1fTjpq0P+m6XceQRCX0P4M4DksR4Wdi5VEdXywmrOAYzkXTsZbp?=
 =?us-ascii?Q?IfXTCqj1HuVF9KLP/7x7Hg8CVu9rue9qGQRwNKVANXJdOBsPyCPDiAhpgVFq?=
 =?us-ascii?Q?7iolv0GzvMLrYZGID/1TBz1GgceBIa+XHADMhQvDswnXSMP+80klTMbJM+fe?=
 =?us-ascii?Q?ypxRTl0zqJcok2NiYJFunXBSGvmgpjWxjZjn+y0FV/2FsGZvlvQm8EAyJAoF?=
 =?us-ascii?Q?fgJa27L0Ut9uZJPM1c700+UwnFJyCIzU6HcDsEb/mbGuov2IKi3Y7I0aksdc?=
 =?us-ascii?Q?Q2rVms3K28J3r/ye6P3m8v0mViqzymKzNvIC62Fs8QtyPb4WDhQqa2o+rmoA?=
 =?us-ascii?Q?qCk6dCB1wCQBhQfRxKflzB5D11mxJD4YOgV+M8BX/Z9EGmkK5s/A9ACimWLV?=
 =?us-ascii?Q?y8+6pbzGMwA9M+D5uxXVKj7qNZI5LOcHj/z4s2+vA6c4NH6c2hOUpXNG1qw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6973ba78-6cb6-402b-3d7a-08ddcde55c27
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2025 14:45:13.3415
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7783

From: Tianyu Lan <ltykernel@gmail.com> Sent: Saturday, July 26, 2025 6:43 A=
M
>=20
> Hyper-V doesn't support auto-eoi with Secure AVIC.
> So set the HV_DEPRECATING_AEOI_RECOMMENDED flag
> to force writing the EOI register after handling
> an interrupt.
>=20
> Signed-off-by: Tianyu Lan <tiala@microsoft.com>
> ---
> Change since RFC V3:
>        - Update title prefix from "x86/Hyper-V" to "x86/hyperv"
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index c78f860419d6..8f029650f16c 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -463,6 +463,8 @@ static void __init ms_hyperv_init_platform(void)
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
>=20
>  	hv_identify_partition_type();
> +	if (cc_platform_has(CC_ATTR_SNP_SECURE_AVIC))
> +		ms_hyperv.hints |=3D HV_DEPRECATING_AEOI_RECOMMENDED;
>=20
>  	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
>  		hv_nested =3D true;
> --
> 2.25.1
>=20

Reviewed-by: Michael Kelley <mhklinux@outlook.com>


