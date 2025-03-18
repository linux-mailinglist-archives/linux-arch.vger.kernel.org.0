Return-Path: <linux-arch+bounces-10935-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCBBA67DF5
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 21:23:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B86F19C3EF2
	for <lists+linux-arch@lfdr.de>; Tue, 18 Mar 2025 20:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3111F0999;
	Tue, 18 Mar 2025 20:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="reo7Cfop"
X-Original-To: linux-arch@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazolkn19010015.outbound.protection.outlook.com [52.103.11.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466871DC9B4;
	Tue, 18 Mar 2025 20:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.11.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742329405; cv=fail; b=LzJf6LjL/hZ12NnUFLYZ7Uci0RlKJSrXoMK5xi+nlLs2RdM5p4OWQAKsvdFVLwPsUs2cPnicgXbfwONaO5VGeGpJ6RGHw2FgCdgwLwmbD1+x75Qtzk+nBCtEStwmTs3P8G3fkZBpRs5s8LoyOTxYtyMrhec9t57iS2cEZ1Rg0QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742329405; c=relaxed/simple;
	bh=dl1pymMAa6aIrvCBIP/F1bo2g1vIX9avNqOp3F0BOxo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHQug9Q5W0xYdCPOpd/DADZyq51pXMZca9gmvbcpH912fxgIzlPQRcLLNWUpD0IG599un5RxfvzLFrlcODSJGsGt6wtAXp0A1Rgokx4wSQxx+Am/lAN/a/huaKAtmKwNJKnujXxBGVVq5vm6hIib2AKEx6Jd2IOnGcYnGcOPMYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=reo7Cfop; arc=fail smtp.client-ip=52.103.11.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JeqNe5wA7uctBr1KPxoNfLIpLF1mwmI2A0gZoqgQaY2aWPpok2OUYrIQZIS5Xw4gc/wQo13cyHIYGnZ5sOCCWL9z4epE9nSy9LOQoYrZ+o9cWWXyETJWRUhd6UQKlEUfJdLwTWTj1sHZoaI3/RPBlEAo8ZTclgjwRG/Eu9eB5M55A3n2lW61vFYUJvjGmQ+TOjBFa7knL8lMuCnrT+0iLq/SqeVoyiMCSAsaapKchXc3Jw5r30uEX+SvxaKYl/wi9BsoqQljvtmSMq6sCN5gdo0KvViosGOiLH+z+5t2o90RtnJ9iFhBhD8PlvbcujdYm21+7nUkmtzzJX0s+kWxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jr3OaZ4LSp5pwntgspKPjNuXu3VN+TIfYWbMqx1m69o=;
 b=JxO5SEXS6gf3EkxTgDkRTFzv8STBln6LQRbmFNaNxtlEEztE6LDpqCk3x/XEltag/hJTQjQoCLCzNoP7F0SpyFAQjZX1XBK7CQSTv8lj2QOl081jYp3d+pM4deCxkmuEz+/iZjvcWfV4VSG87VsIB2KlvFNhexLinnT3Ex44kRSlTPIzEELwb+KBUiD68KyvhgkI3wd2elkE5Qy4PaDecgolNWoiMKdawm1YJznWqEwYWiYepLyA6nbF6rPmEVLrH1UTmYnQadNPMh6UUntJ2UPeARhoVxzCj1T37SmLjMxwfL8e90tgpUSzHsCtFGL77KbKFrc/Jkguuy2TI/RYMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jr3OaZ4LSp5pwntgspKPjNuXu3VN+TIfYWbMqx1m69o=;
 b=reo7CfoptGRw5r1xcpPqLpJ6rDJ08YsSnD+JNQaLwCpPcjMVnP3EAIhm8wGmS6+4IvB0uCzlUhuMOo6WORCF3Vak2rWBFpvxR2/k1xGv+YLAOy6xtAVJSKhC+njCwiGDK4xBXL9rLvSotuIfApOJ9mDFW9GmKziwaSKKQrDSEGzfNJvF9ZHpeR5sKE0jTZDpX7ML9b3ti/aVm3xO1iCPfih2TledD6W0VegNPhfErvgyb525wH4xB5HaOix/mjIWl0q1tvLV6Z4e/XFkIxe4vCiIYvVwQGcQV27JCr9ISkm2ueZVWMaSQi5921A0lJsuGW/KtgtCS+lJqogLdmq7Hg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MW6PR02MB9693.namprd02.prod.outlook.com (2603:10b6:303:23f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:23:19 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 20:23:19 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Wei Liu <wei.liu@kernel.org>
CC: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "ltykernel@gmail.com" <ltykernel@gmail.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"eahariha@linux.microsoft.com" <eahariha@linux.microsoft.com>,
	"jeff.johnson@oss.qualcomm.com" <jeff.johnson@oss.qualcomm.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
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
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Topic: [PATCH v6 10/10] Drivers: hv: Introduce mshv_root module to
 expose /dev/mshv to VMMs
Thread-Index: AQHblRdnpUjohn3xT068AvEhHN692rN5UJDAgAAF7gCAAAXbAA==
Date: Tue, 18 Mar 2025 20:23:19 +0000
Message-ID:
 <SN6PR02MB41578462FA9CE129979F604DD4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1741980536-3865-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1741980536-3865-11-git-send-email-nunodasneves@linux.microsoft.com>
 <SN6PR02MB4157261B9C4AA8CF89A30317D4DE2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <Z9nQxOD1N2HZIyaF@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
In-Reply-To:
 <Z9nQxOD1N2HZIyaF@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MW6PR02MB9693:EE_
x-ms-office365-filtering-correlation-id: de8ff147-e532-4268-dfda-08dd665ab914
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|8060799006|19110799003|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qzSVFQST3EWhBucvhFo30Yj/gS5JAzSxsk4tSWST0x7ApcwCn7+rgw5IQ6Q/?=
 =?us-ascii?Q?uSN/JYtwapLPqoTHqhmpFcbfobRhoG4A4kn862JlDTJrAmIw5sB+32NAQY7E?=
 =?us-ascii?Q?EFe/tKSMy+E3cngWF4wie25coo9a6h1o+0rEoOLbaf9xkNct/DmpXm5eOFk2?=
 =?us-ascii?Q?XJvKUnZbJzXdgpJuXeJtyDCeX5qcqBPPVA+yPAMDljFydQKXhROF6wRj9+P1?=
 =?us-ascii?Q?iIJr6keTtAlf9jrju3aGEH/aYsiHR+FTnuIcHInIb6xBgBoQnnxnFSjES+v+?=
 =?us-ascii?Q?uTyBZOh+hjr84Szti61b7AmAq8AQA3U2hZyu48NyojVVJDLgPaZjSLVnMZAS?=
 =?us-ascii?Q?jzsgVICDThDqiuRoJoKTrVnkaiQNeuf3KN/jUpBUByD77nTUSXeacVJXRWBt?=
 =?us-ascii?Q?m8pxE5aNGQJ2gSweNr/o3U28BboD/X2XuuDNJ0TmoJYYqGSx+U3QsYg2HfvS?=
 =?us-ascii?Q?WzshOksEcqdw5nvMjTfzbWevlyAGBmtwrwbFJlS1TqnjwEdP7Zx3axtKJuhm?=
 =?us-ascii?Q?AuPqom1NlpEI1A9SMOr5iEy7yCHYI7fq9lIm/C83NEEtiO1LarNqGiiBCb3d?=
 =?us-ascii?Q?osJORvRpm2dBXmhnR9OY10cOk4pgZFB/ldHz88fPBJ5H+0hM7elXeZ0ockL/?=
 =?us-ascii?Q?ipWAwywsGhuIbzY2SrSQfrMunujuGOXGHLmZoO5qM+4ZjL31hCp2DjGzmf6g?=
 =?us-ascii?Q?hlIYdm9G9ihhanpByakZPOUjWbhP6setK/yY8X8ctPcy/HqeiFw+woMD8IFC?=
 =?us-ascii?Q?ssicB73dX7VT5iR6cM0XEN9w0xqT3+2uGUu1kNinP4QgwYPMQ5kZgSYl9uAm?=
 =?us-ascii?Q?x+6vWO2b6xc2IRwrmCrWwnYvige2qBQ/7YpKlM1GCUuFceIzmmcAb22TbKJe?=
 =?us-ascii?Q?7OgzLOhT+I9Xj9ztSCc1Ytjoz4gFuq/NaZvrO+ExPjveueK6OsNB3DBB3+IV?=
 =?us-ascii?Q?8yIEVtZExx2iwUol4cGkwbQm9BogIqyPlnJ53nJ4aMQaxcpjAq7QmZS1/dZV?=
 =?us-ascii?Q?dTq3q3ETDFjoNBTJj4qx58m/4KeWabgYcXcz0s7ikyx90XOgdDiRMFFeq+qy?=
 =?us-ascii?Q?sux2gQjX3iRF4gStzAwT1S4hnrR5Lw=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?mQmXI4EglrgI9Xe7ZeCLPQaD7vYMLYnMcbACg2wn8wBfH6FOKRhNfDQ5sq6K?=
 =?us-ascii?Q?0iAsCx83ndZ72JNgaSK53+ktJ6ATqbAUQ6InkxP0nWp+pJq8sSU0kH83VrbB?=
 =?us-ascii?Q?dk9+eN+Dtn3XZScKdI/BjymxELX0zOXg2YoKSXFvu6dxPSTZDcBSrNvDBqdy?=
 =?us-ascii?Q?hmnnnyuL2fHZDdJX2UqaQbIY2yFA1cDiJ/w9WcWJbOyw0uxP9wLUiiOxXY9h?=
 =?us-ascii?Q?pDDECx4M9QDT7BpWQhQfVG/TbII934Prhi987EnD897DGjfvgNfBIt9R2sjZ?=
 =?us-ascii?Q?eP204zUWkzmOEGI2Gi9pLmsfAy5Lqx0HBLV2m6Kuou25ysfRb7HVB4U3Dhm0?=
 =?us-ascii?Q?oSzGLjRUc6+tajTsEW9P8fGww/h/EjdpE4gS4RcoOpc5qp9t0iOQp+zLnayQ?=
 =?us-ascii?Q?CVxAqkY6vPCRED+6TBLmFtnHS26HX7/dgbqdCf6H8RAl4ZFhIKOI4AAuGl8t?=
 =?us-ascii?Q?b5vzbKPNO+I8u/mhB0MjuH+E5eaAo3ipXHxIFAZeB4MUdJIZ/d+u0QCn30Nh?=
 =?us-ascii?Q?yyYJ3/aKcWKiTFNb4dcm4nDm/6yg9lhSBFEsknMzP7lWM+QcPNRx7mL4OWe6?=
 =?us-ascii?Q?EpDC3Eom1hXHXhEnE0XKIwPB1lUdizDtStyI0dPiBkq4PvkZrR21UruCRZO8?=
 =?us-ascii?Q?e38qnrTPXtP461+CzsV96CQgKc6qfQBhRySdoQ6TSFKzNZOPddwV2vz+omjz?=
 =?us-ascii?Q?c1ul2U7eqWXney0icl2ZWG5NHVHqwdD9MfvjUOvZ/gedWSF9VnTt0eQxIi9P?=
 =?us-ascii?Q?Hjkn6SZnwosFf9D5ld82yjNLXk3+DBbRng40RRS7Vj1teJn98eSoaJrU6Wl7?=
 =?us-ascii?Q?4Blu9jKdG8egzoPYhcQ4VGixzYg0Afvwc/makntkFwuNWnq3TgNEftiJYZ/U?=
 =?us-ascii?Q?+53ZCtYBmMysB9IaIvLLQVpVqEBgv/8KquoqQf1X0fiFoafVw/mycIafSj3x?=
 =?us-ascii?Q?69JeJlpySp5ctukTI2uG9SiS39rmKR0NYQ7eoGB5+nD+K5o3GCauFlVS/nCV?=
 =?us-ascii?Q?9Ii0pMicQlwdnDmUk3IILEaz/ROsWSZeXo7SeftFwqmy2FZThe7BpvWJmDzL?=
 =?us-ascii?Q?otZHQoEoX0hf3WJmAeQwt6eA1dOuTT6Br2EBrFP3IpbFE/wULKCRBEnXN24c?=
 =?us-ascii?Q?BoVnpiYv+IJ858D6Ay2s9Ax97W7oEGUjgrj7a8Ws2OJcGoftWvIU7EjW5R8u?=
 =?us-ascii?Q?0bnclDe1gcAgDZYkUVTWltnMbomxUiMyTUZAxy3XVQDxCoLUlcYJMgoBgpw?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: de8ff147-e532-4268-dfda-08dd665ab914
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2025 20:23:19.4696
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR02MB9693

From: Wei Liu <wei.liu@kernel.org> Sent: Tuesday, March 18, 2025 1:00 PM
>=20
> On Tue, Mar 18, 2025 at 07:54:49PM +0000, Michael Kelley wrote:
> > From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, M=
arch 14,
> 2025 12:29 PM
> > >
> > > Provide a set of IOCTLs for creating and managing child partitions wh=
en
> > > running as root partition on Hyper-V. The new driver is enabled via
> > > CONFIG_MSHV_ROOT.
> > >
> >
> > [snip]
> >
> > > +
> > > +int
> > > +hv_call_clear_virtual_interrupt(u64 partition_id)
> > > +{
> > > +	unsigned long flags;
> >
> > This local variable is now unused and will generate a compile warning.
>=20
> FWIW I noticed the same thing too and fixed them all while I committed
> the patch.
>=20

Ah, good. That just leaves the uninitialized "ret" in hv_call_map_stat_page=
().

Michael

