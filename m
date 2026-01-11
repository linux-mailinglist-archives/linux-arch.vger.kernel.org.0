Return-Path: <linux-arch+bounces-15745-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5741DD0F845
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 18:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16807300119D
	for <lists+linux-arch@lfdr.de>; Sun, 11 Jan 2026 17:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1A5E34C13D;
	Sun, 11 Jan 2026 17:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="UUfxnj8x"
X-Original-To: linux-arch@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazolkn19012052.outbound.protection.outlook.com [52.103.20.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC3121ABBB;
	Sun, 11 Jan 2026 17:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.20.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768152989; cv=fail; b=NwW1nz949chJwZ4p42vLWMNqtrg1KfiK2AoAPa1/xeNno6WGciim74bIDcbImBgyWdgR+qpShSTCKDpgCkzrOvhX90QFTKKt8X7hbz7oyL6PTobU0UD4GvQgMisHkTERE918XdQcvqI1KNLVu2Cw7JsTsEFCv5gNqtDuFEBHfmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768152989; c=relaxed/simple;
	bh=E7K8Kedddi9BDtAATTivQ02LzKFeIAh/LHb4o3YxR9E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fPiDPWwPG9BV/shS3+8KYuG6gpQ1Inyf56oyOxVrMYN24VkPY6Sb097xXBg1VcyeL3W6/+sPiqOEM/8ZNDLGx440HRPTbEwZoKdF+SVt2mEZ3BG2WtqR2kMoDYhpnEyW2P9EjhiR2g8qilkkmxA99+C2c+WUQOfcdz7mlYOB/PQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=UUfxnj8x; arc=fail smtp.client-ip=52.103.20.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jmWxey49N/QwWkRGnOC6vj+H9hOi46chTw/0ayh7T/NoCQpjhvJV+B0grkBiU+riOrjX4oUsgcyd5aFjba+e8QosEvO3N8XqNKMx1DYXht3hZALV3XEMh0aYc4aoDeksDtcuvtbGU9/VNkztws+dcM+TS0E4axLySKPQt0VSGDOyKQct53reW/LIrCqIQBhNyMWRzoSu+nXxE3Pl7+vc9MYGeQ/qP1TYXNi4j6tnJStMITq+Kajeb3sL2+i5nprMrAPE/buyYCDzfMjJnL7+ZghA5Vg7R5X0Z9bcMBpc2rFi74NW1StHS1aWnBSUl5DBEc1c8PWplUD5CeQm69O1ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rSvB5mP0NlQfOGkMDYnhgRUojx6rp4WNqxYBGWk9S+A=;
 b=FY2T0IS10LLJjKlS7FZCVWjlIwahgVwDZcAPjpwWd8+7tXiQ/64UFa8Is6M7PLZg5IWwovRGEbXS+FMXFU3tqDUIf/IhDeYD/hIpqSCmWqCuZmmjflAh741k1BzHIjL1Aih8m1GRQlxhxqeKRITm5GcnETB03mlisDh2+u8IWkoJnBQVPUca0mt5jIeqUVJIYq4ZTUFlb0kwaVG2StyxgIaoJaGxBG5LXkSvaCG821KOaQYvCc+ypwunLAe4e3pSqbsU8O/O4cXfxpmqAs3mPxRdhq5RHn3rWYqKGFOKnE1LDieK92cEt1vmv8ylp3+vqu6ej1qdznrdMVtgs93VAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rSvB5mP0NlQfOGkMDYnhgRUojx6rp4WNqxYBGWk9S+A=;
 b=UUfxnj8x8O4359h4b4s6yG+42LV4j7YVQk20DPFN0jskCxjS3U59M0yLNWP0MqY+Ty5dCs3ReNRDUvoiFEGtr8uFeXPh6l3e+m8Nd+bxUSTYEJyokph6zuovbo2eWTMRlbYchvgoPftAs+DgYKTCA37yMl5bZPzAJcWvQVZVg5Q8k8L7zAXseVDe5ir2ymGDhABaiR0z5rBTFym7+Chquydn5ELrAr3R15c5Xv2wak7uHEDl7H0a3bLuOvhLoWYoQEXwLB3pXKx0m3OpsbxK7RNt6j5rzbXhDcAfBqeDa4A4538F+83HPTgoyd2VkI6VsJ7QRgrz3D1DxlMKf75rzQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH3PR02MB10247.namprd02.prod.outlook.com (2603:10b6:610:1c2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Sun, 11 Jan
 2026 17:36:25 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.005; Sun, 11 Jan 2026
 17:36:25 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
CC: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kwilczynski@kernel.org"
	<kwilczynski@kernel.org>, "mani@kernel.org" <mani@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"jacob.pan@linux.microsoft.com" <jacob.pan@linux.microsoft.com>,
	"nunodasneves@linux.microsoft.com" <nunodasneves@linux.microsoft.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"peterz@infradead.org" <peterz@infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 1/5] PCI: hv: Create and export hv_build_logical_dev_id()
Thread-Topic: [RFC v1 1/5] PCI: hv: Create and export
 hv_build_logical_dev_id()
Thread-Index: AQHcaMpPt/satBkNIUW6NoagzPaHTbVImcPwgAHDjQCAAlbvMA==
Date: Sun, 11 Jan 2026 17:36:25 +0000
Message-ID:
 <SN6PR02MB4157098A14BE63FCA8C0A70ED480A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
 <20251209051128.76913-2-zhangyu1@linux.microsoft.com>
 <SN6PR02MB41570FC0D7EA1364FB48CD1ED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <162c901f-69a7-420a-9148-a469d5a8ca4f@linux.microsoft.com>
In-Reply-To: <162c901f-69a7-420a-9148-a469d5a8ca4f@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH3PR02MB10247:EE_
x-ms-office365-filtering-correlation-id: 760c5592-859d-4ff2-1f9a-08de5137f1e3
x-microsoft-antispam:
 BCL:0;ARA:14566002|8022599003|19110799012|8060799015|8062599012|15080799012|41001999006|13091999003|461199028|31061999003|56899033|3412199025|440099028|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SJJfkhDr2YvgTkcy4G1IShPiMtLliuTf88RC7XJDG6YTa4i5m9ZUZUDPPV28?=
 =?us-ascii?Q?U7Nepg3TE7OaFGvH3euS8+ekJ4alK3l5I5LOulgzufVoIYZEaoonC0Wzrbb9?=
 =?us-ascii?Q?/eAY15UXd5SASG9/X6cu6pSGLNiUjyanv1EueGzfyEbUKzPMkmX7mJwLY0nq?=
 =?us-ascii?Q?MxqTIX43WM6kK8KxAojfcJPaJOr0p4Sm4zAHo4R1CNLZ2eWApXXkxj03sQ9B?=
 =?us-ascii?Q?dbmjj701h0+60brLi7/JSPmPnalJhzwh7S+BlSQqEx8RAf0cBXOGOn+qYo/m?=
 =?us-ascii?Q?G0UX/pNZWkv2tGLFHyOzUmanzHw7S4sY440f9sq5QCyNiyGZTAK61ldiL+9c?=
 =?us-ascii?Q?oiGvcZ+mTgmOHr5/KKICyOKefSnSXC0QExs0YcUmo7U51b7e8CIEwKqz/irZ?=
 =?us-ascii?Q?TYq9PciWq6zgD/cYLY61aJG6yItxPrlYw8Q57rSCMgRuwj2HFsK1/0nEeH6O?=
 =?us-ascii?Q?z0pa9TJvFlnImnsBmlWLYqMzLphg8W/UMQgIPScDfHUDW/WF88i/+jUTi47L?=
 =?us-ascii?Q?NycPYOY2TbGXA6dOrGjR/5B0ELun9Idoi9Ita10iPZ36EP5MhMRJRVPrOmBN?=
 =?us-ascii?Q?oapQZZCw73u2Ga3g5yhcdobFMSJkgoVQkHm5irCrYH4snz7UfbDTxpyakaye?=
 =?us-ascii?Q?9IyMxiZdUBEu4IkwJVeqJJrO+MsAPFEDQTsSbsLDAxyxrqIzG5aFbr8+Qi6L?=
 =?us-ascii?Q?tpy4WJ6e8/8qRC+r0Gb7al2oICmaaUjmc1866bKMMihMWM0ZFbrmwZX5AUeS?=
 =?us-ascii?Q?6/fO/+KQrd958rIWQl17/4d07/BYwiBLbfg9SbtlTnDEsYGgX+JLL3kYv/Q0?=
 =?us-ascii?Q?fcxLevh9OYInLf1Es0ts6OVR2sQ+6akTq9z0JC48VKYa0c8w5tWXlO4eSfO4?=
 =?us-ascii?Q?vZxSJ78QDLOXczjacflDnMyx+Utu0lp9eiUDgEInS7VJvYhN+NBTUXMCaKLs?=
 =?us-ascii?Q?4ookfk9A1YJQVDQqPjRimKHrDmBVHS6dIUYbl8fAraZNBOvsJ5MbJuvP7UcC?=
 =?us-ascii?Q?MCXPzjSjei2qzfxyd2vJskRkTc27gXcKac4k7hANKEFoCL5/Y42TB3ZcLeMt?=
 =?us-ascii?Q?dUt7iEo0KTFi875OtmX25TH5mqfO3yBvGUNsDhy+pUZe6uTx29mghKDmNApK?=
 =?us-ascii?Q?dl/CgnjN1Itk0rcBUZ6bxr20DWvOJmWXhEC6N23xYvc+lCMXefMhaJpYyGxV?=
 =?us-ascii?Q?3Ri35reuIVuRDh78b8r3zE6f4Jm7GrPr25OrPrmS3gYkdi0mBkHRXcMepes?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RlJDVmFMlARkY1B9AB+UIrFnxIacGdEx9tI4vwOrWQTvbqtE+KuWHeLkcG+8?=
 =?us-ascii?Q?9Z0oDQkckPf+VstH+bUnOzTtkPEJLSGkgcvqcG1HoUV/xQck0BRbTc8yI/23?=
 =?us-ascii?Q?mJlUD1jrQkzfzlKLCdqHrj+qsiGWi50d1MJFRnri8Y6aFL5/JCDPuydVxTB+?=
 =?us-ascii?Q?rx4Gj7NmCyhqRdoSNPbdblxAN880rVByJiCZTeJsFi5rJGFX1pmpEc41EMsk?=
 =?us-ascii?Q?rAN2uRr0WMARVUIRq2NdupKRD73zPnBp8ITBj/w3CYGlvOlxcVnsXPIiT/18?=
 =?us-ascii?Q?WQphivUF9OJ4ksS4+AVYJuRcbUHmmwOrQq9pytuorlU5Jwls/i5xTw87XXe9?=
 =?us-ascii?Q?LTRfcnzcfKM7XYVeH9YrHxYsc2qrbx1MQKU3zTiCoySpfuvOCfa1HqMyT7zL?=
 =?us-ascii?Q?+ljxkMpI9Hodfrd7CKALbsIul7fxn5eppVgP7x5MVkkpMDzmq2eV2MeHnZHf?=
 =?us-ascii?Q?vASM0oDYAwoWkb9iJY0QRPGZwlCCmhpcmftyskhzl18JUpGfG/seR+ZjQM9W?=
 =?us-ascii?Q?RAuzd+danUQHCjMLQk35V064CiiLbddGk2YM9f7+Pz8WRZgsuUe8KvpSNEO0?=
 =?us-ascii?Q?0NV0eAm5WSvVb2Os9bp0uBmi87KIx09qsoOmROhA0QpzJ8D3LGK48C7/tuh7?=
 =?us-ascii?Q?d/ptM8IJ9kTmGK/3DhNzWDxDS48o9Hgk02V3duji2cWsn/z6n5gy8exbbFEG?=
 =?us-ascii?Q?y2kU8Mo87enSL+NUcrf7uRHiD/mWFvT8DtXTdu3aUJu6C1tljqRjWzJRLmYh?=
 =?us-ascii?Q?v9ru+G92d6SRAIHnLYkezyUSI1N1CJCotI2155H4312M4U5QXP45Cf+zy0Lk?=
 =?us-ascii?Q?+Sepiuyp3ouRKADRT25LbAZyj6j3zMmP1tFhTVUDw+gcBJ07I6oYNP9k91M3?=
 =?us-ascii?Q?rxWGKop4emWjGa06lBTpxPWPEaVO+p6p2838oq+C988bqy2cnDwEiTAv7PSd?=
 =?us-ascii?Q?tua7Wt+yHl8w9ZNY5TFbYaBxSKa0wEhLcaE7On6UZU+RwwrspUSGmK3GwrOl?=
 =?us-ascii?Q?Yt6WmLQpGbImwmgQxw4BreUYNJxgBDtpGsH+9z23pzJXmXvoIHk2jFM0qjSL?=
 =?us-ascii?Q?tvQaz6DTayqhBuXU2a6u18+xt+Ur8zjTrI3RjeBbprYJhhl8CO5FPOINpmEN?=
 =?us-ascii?Q?jPh23zgrSGHpX4gBKeGkVMjUartGl90fGTTiPMb08rSFgj2BgIUcuzLq5l4m?=
 =?us-ascii?Q?JhV6GA4vI3twZ2WyomdAF6NyxO9ZA6f6ZjTXTj+Rz0h0gaItE4eDKCrceqgv?=
 =?us-ascii?Q?/Y48aM3IXH67duj+NM39EBWmBO4MAjM3AQt0je2cpTZnOKS0Z3bnH1DkPsPk?=
 =?us-ascii?Q?mpGOumtXce5un8x9EVVoQry0PnRADILszSHYpBoN4v19hMMf/2DKH1LDTou4?=
 =?us-ascii?Q?oL0iTNg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 760c5592-859d-4ff2-1f9a-08de5137f1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2026 17:36:25.6172
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB10247

From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com> Sent: Friday,=
 January 9, 2026 10:41 AM
>=20
> On 1/8/2026 10:46 AM, Michael Kelley wrote:
> > From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8,=
 2025 9:11 PM
> >>
> >> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> >>
> >> Hyper-V uses a logical device ID to identify a PCI endpoint device for
> >> child partitions. This ID will also be required for future hypercalls
> >> used by the Hyper-V IOMMU driver.
> >>
> >> Refactor the logic for building this logical device ID into a standalo=
ne
> >> helper function and export the interface for wider use.
> >>
> >> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> >> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> >> ---
> >>  drivers/pci/controller/pci-hyperv.c | 28 ++++++++++++++++++++--------
> >>  include/asm-generic/mshyperv.h      |  2 ++
> >>  2 files changed, 22 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/control=
ler/pci-hyperv.c
> >> index 146b43981b27..4b82e06b5d93 100644
> >> --- a/drivers/pci/controller/pci-hyperv.c
> >> +++ b/drivers/pci/controller/pci-hyperv.c
> >> @@ -598,15 +598,31 @@ static unsigned int hv_msi_get_int_vector(struct=
 irq_data *data)
> >>
> >>  #define hv_msi_prepare		pci_msi_prepare
> >>
> >> +/**
> >> + * Build a "Device Logical ID" out of this PCI bus's instance GUID an=
d the
> >> + * function number of the device.
> >> + */
> >> +u64 hv_build_logical_dev_id(struct pci_dev *pdev)
> >> +{
> >> +	struct pci_bus *pbus =3D pdev->bus;
> >> +	struct hv_pcibus_device *hbus =3D container_of(pbus->sysdata,
> >> +						struct hv_pcibus_device, sysdata);
> >> +
> >> +	return (u64)((hbus->hdev->dev_instance.b[5] << 24) |
> >> +		     (hbus->hdev->dev_instance.b[4] << 16) |
> >> +		     (hbus->hdev->dev_instance.b[7] << 8)  |
> >> +		     (hbus->hdev->dev_instance.b[6] & 0xf8) |
> >> +		     PCI_FUNC(pdev->devfn));
> >> +}
> >> +EXPORT_SYMBOL_GPL(hv_build_logical_dev_id);
> >
> > This change is fine for hv_irq_retarget_interrupt(), it doesn't help fo=
r the
> > new IOMMU driver because pci-hyperv.c can (and often is) built as a mod=
ule.
> > The new Hyper-V IOMMU driver in this patch series is built-in, and so i=
t can't
> > use this symbol in that case -- you'll get a link error on vmlinux when=
 building
> > the kernel. Requiring pci-hyperv.c to *not* be built as a module would =
also
> > require that the VMBus driver not be built as a module, so I don't thin=
k that's
> > the right solution.
> >
> > This is a messy problem. The new IOMMU driver needs to start with a gen=
eric
> > "struct device" for the PCI device, and somehow find the corresponding =
VMBus
> > PCI pass-thru device from which it can get the VMBus instance ID. I'm t=
hinking
> > about ways to do this that don't depend on code and data structures tha=
t are
> > private to the pci-hyperv.c driver, and will follow-up if I have a good=
 suggestion.
>=20
> Thank you, Michael. FWIW, I did try to pull out the device ID components =
out of
> pci-hyperv into include/linux/hyperv.h and/or a new include/linux/pci-hyp=
erv.h
> but it was just too messy as you say.

Yes, the current approach for getting the device ID wanders through struct
hv_pcibus_device (which is private to the pci-hyperv driver), and through
struct hv_device (which is a VMBus data structure). That makes the linkage
between the PV IOMMU driver and the pci-hyperv and VMBus drivers rather
substantial, which is not good.

But here's an idea for an alternate approach. The PV IOMMU driver doesn't
have to generate the logical device ID on-the-fly by going to the dev_insta=
nce
field of struct hv_device. Instead, the pci-hyperv driver can generate the =
logical
device ID in hv_pci_probe(), and put it somewhere that's easy for the IOMMU
driver to access. The logical device ID doesn't change while Linux is runni=
ng, so
stashing another copy somewhere isn't a problem.

So have the Hyper-V PV IOMMU driver provide an EXPORTed function to accept
a PCI domain ID and the related logical device ID. The PV IOMMU driver is
responsible for storing this data in a form that it can later search. hv_pc=
i_probe()
calls this new function when it instantiates a new PCI pass-thru device. Th=
en when
the IOMMU driver needs to attach a new device, it can get the PCI domain ID
from the struct pci_dev (or struct pci_bus), search for the related logical=
 device
ID in its own data structure, and use it. The pci-hyperv driver has a depen=
dency
on the IOMMU driver, but that's a dependency in the desired direction. The
PCI domain ID and logical device ID are just integers, so no data structure=
s are
shared.

Note that the pci-hyperv must inform the PV IOMMU driver of the logical
device ID *before* create_root_hv_pci_bus() calls pci_scan_root_bus_bridge(=
).
The latter function eventually invokes hv_iommu_attach_dev(), which will
need the logical device ID. See example stack trace. [1]

I don't think the pci-hyperv driver even needs to tell the IOMMU driver to
remove the information if a PCI pass-thru device is unbound or removed, as
the logical device ID will be the same if the device ever comes back. At wo=
rst,
the IOMMU driver can simply replace an existing logical device ID if a new =
one
is provided for the same PCI domain ID.

An include file must provide a stub for the new function if
CONFIG_HYPERV_PVIOMMU is not defined, so that the pci-hyperv driver still
builds and works.

I haven't coded this up, but it seems like it should be pretty clean.

Michael

[1] Example stack trace, starting with vmbus_add_channel_work() as a
result of Hyper-V offering the PCI pass-thru device to the guest.
hv_pci_probe() runs, and ends up in the generic Linux code for adding
a PCI device, which in turn sets up the IOMMU.

[    1.731786]  hv_iommu_attach_dev+0xf0/0x1d0
[    1.731788]  __iommu_attach_device+0x21/0xb0
[    1.731790]  __iommu_device_set_domain+0x65/0xd0
[    1.731792]  __iommu_group_set_domain_internal+0x61/0x120
[    1.731795]  iommu_setup_default_domain+0x3a4/0x530
[    1.731796]  __iommu_probe_device.part.0+0x15d/0x1d0
[    1.731798]  iommu_probe_device+0x81/0xb0
[    1.731799]  iommu_bus_notifier+0x2c/0x80
[    1.731800]  notifier_call_chain+0x66/0xe0
[    1.731802]  blocking_notifier_call_chain+0x47/0x70
[    1.731804]  bus_notify+0x3b/0x50
[    1.731805]  device_add+0x631/0x850
[    1.731807]  pci_device_add+0x2db/0x670
[    1.731809]  pci_scan_single_device+0xc3/0x100
[    1.731810]  pci_scan_slot+0x97/0x230
[    1.731812]  pci_scan_child_bus_extend+0x3b/0x2f0
[    1.731814]  pci_scan_root_bus_bridge+0xc0/0xf0
[    1.731816]  hv_pci_probe+0x398/0x5f0
[    1.731817]  vmbus_probe+0x42/0xa0
[    1.731819]  really_probe+0xe5/0x3e0
[    1.731822]  __driver_probe_device+0x7e/0x170
[    1.731823]  driver_probe_device+0x23/0xa0
[    1.731824]  __device_attach_driver+0x92/0x130
[    1.731826]  bus_for_each_drv+0x8c/0xe0
[    1.731828]  __device_attach+0xc0/0x200
[    1.731830]  device_initial_probe+0x4c/0x50
[    1.731831]  bus_probe_device+0x32/0x90
[    1.731832]  device_add+0x65b/0x850
[    1.731836]  device_register+0x1f/0x30
[    1.731837]  vmbus_device_register+0x87/0x130
[    1.731840]  vmbus_add_channel_work+0x139/0x1a0
[    1.731841]  process_one_work+0x19f/0x3f0
[    1.731843]  worker_thread+0x188/0x2f0
[    1.731845]  kthread+0x119/0x230
[    1.731852]  ret_from_fork+0x1b4/0x1e0
[    1.731854]  ret_from_fork_asm+0x1a/0x30

>=20
> > I was wondering if this "logical device id" is actually parsed by the h=
ypervisor,
> > or whether it is just a unique ID that is opaque to the hypervisor. Fro=
m the
> > usage in the hypercalls in pci-hyperv.c and this new IOMMU driver, it a=
ppears
> > to be the former. Evidently the hypervisor is taking this logical devic=
e ID and
> > and matching against bytes 4 thru 7 of the instance GUIDs of PCI pass-t=
hru
> > devices offered to the guest, so as to identify a particular PCI pass-t=
hru device.
> > If that's the case, then Linux doesn't have the option of choosing some=
 other
> > unique ID that is easier to generate and access.
>=20
> Yes, the device ID is actually used by the hypervisor to find the corresp=
onding PCI
> pass-thru device and the physical IOMMUs the device is behind and execute=
 the
> requested operation for those IOMMUs.
>=20
> > There's a uniqueness issue with this kind of logical device ID that has=
 been
> > around for years, but I had never thought about before. In hv_pci_probe=
()
> > instance GUID bytes 4 and 5 are used to generate the PCI domain number =
for
> > the "fake" PCI bus that the PCI pass-thru device resides on. The issue =
is the
> > lack of guaranteed uniqueness of bytes 4 and 5, so there's code to deal=
 with
> > a collision. (The full GUID is unique, but not necessarily some subset =
of the
> > GUID.) It seems like the same kind of uniqueness issue could occur here=
. Does
> > the Hyper-V host provide any guarantees about the uniqueness of bytes 4=
 thru
> > 7 as a unit, and if not, what happens if there is a collision? Again, t=
his
> > uniqueness issue has existed for years, so it's not new to this patch s=
et, but
> > with new uses of the logical device ID, it seems relevant to consider.
>=20
> Thank you for bringing that up, I was aware of the uniqueness workaround =
but, like you,
> I had not considered that the workaround could prevent matching the devic=
e ID with the
> record the hypervisor has of the PCI pass-thru device assigned to us. I w=
ill work with
> the hypervisor folks to resolve this before this patch series is posted f=
or merge.
>=20
> Thanks,
> Easwar (he/him)

