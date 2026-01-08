Return-Path: <linux-arch+bounces-15710-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51477D05B33
	for <lists+linux-arch@lfdr.de>; Thu, 08 Jan 2026 19:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E84A304A982
	for <lists+linux-arch@lfdr.de>; Thu,  8 Jan 2026 18:45:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CD632573B;
	Thu,  8 Jan 2026 18:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kJQ40SsF"
X-Original-To: linux-arch@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazolkn19010016.outbound.protection.outlook.com [52.103.7.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F8724BBF4;
	Thu,  8 Jan 2026 18:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.7.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767897957; cv=fail; b=qxTtJEgIPvWeIfe1U3VLniii1bjZEpoDDeECqqkeaz0xXCHKyCWQY9RD7vVHzL11hvvXpUqHZpgRLumBs0+75rFktZ91O6oZp8QPDFiJ9n8BUgN6ORIvpoG4Swy9kBcOeNUXtLg5Ss0yNNn03ZNYMhK248GicWBlNW2gWQ0NGO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767897957; c=relaxed/simple;
	bh=7nGQPW2fB+RgO4I+3rAyR59LddHgXSgsBlaBErV1Lbs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DjZJsm70mblIwvFREm/PFEKu+Xvm9ny39UckjoUcWip1BeRO5CjC8C6ThUkchccePx+KZLls2wjNuDD9v1OLfp500qkfn0k3VwXPRPOXt3+gh3ovVCrYWtX8n17Q/q/c+U6lmcTvjBTRtmMOkG+9kKe2MBgPPQ+ufvZdfOuvPpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kJQ40SsF; arc=fail smtp.client-ip=52.103.7.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I27sWUCvQGUV8xG7ejN9Y3XSrW0M5DiONiEnOaSB+oZWv5uIMpEMg9KPp9NSNu9KwnoqOjDj0UfA8ooVnbyeaZXy/rG0ZseYdalNE0RyDZhCnY7WtIAb7zKocaNiXEdslGjhPUBKaHxvnBdSm5sdcl26T47NUd48NZtwfzYRkne2Cv162UEP4VqspAV1ERBrRuJoAv8BSLmjbLadgmGckspGZC7gvi/2LNLn/9C0rKYN3RuaO/zJ1EI+XBvTU9E04Ury/sB3IPA0e+CXoT8SDGaxubyIuC7gocFC9I8UiOoI7PCLIpPoR1iaSHkn8yK8kxcNw/oRmFoax13ZKyHBDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8r9XBwTPsn7e4/fM5TWl/ww+TcI9RjxOTnLj9+XEWr8=;
 b=fW01DXMon5o8CFnEPEMXkbBTa8KpBb0VTGyoEeT2d+folTgmMFXpohhKDy5tAoBKFuRdxv0Wpj9dxVShx0vGaNo5rkhrOsepGacgRKXi4kvsi73CCdp+E+XICbe7tTIG7O6oHSSa8F1xGmZKt5vIe9L+y8XjaiC3k9CaHyIA3VtPLrn3/k8UTDlxMtO8FPXEa5KDUkUs3STvj5wJLmIColB/8NdNEdoK+kPBP3A2bI63equyvZfBhCPMgT2WCbjWTWyGalbyCtjjT0aFGr8Gpvl+RcoH1080HThG4nXuqX58yG8o9OALmCvFs6jyDEET9o0Kis7jlwzWzeBDqv594g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8r9XBwTPsn7e4/fM5TWl/ww+TcI9RjxOTnLj9+XEWr8=;
 b=kJQ40SsFGwqKHXU6ezjTJ1vLU8CJLNw+3/ZfweyKLQgLKgZnXC8Zi3owwQgzRfa47iQfqte5acpC11IlbHV5CK8eP34EJtsUKXvC5eWw9GmKoVQpm1Muz/3HBeLKVmr0N2D7zuIwHgJ5nfJZuFFCyl2Y4ZLWOmRcBZlkf5GmxM6qlV/TEECf6fnMsjZQVzmPx8/Z+hM5+FGKDGFb3xiZ8+/BR0YrEJKZGJDqasHVY6A5hC/8iMZYI0aEHreLJ4fmrl3r4LwIgBVXd5YLI4XAqiRkGYjfuUaUL9WnKOs0oYHa5hWJ0e9YfqXEfKw1WH5fnv2fykK7npQkK4BuKhdWmQ==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7542.namprd02.prod.outlook.com (2603:10b6:510:51::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Thu, 8 Jan
 2026 18:45:53 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::900:1ccf:2b1e:52b6%6]) with mapi id 15.20.9499.002; Thu, 8 Jan 2026
 18:45:53 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
	"mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>,
	"easwar.hariharan@linux.microsoft.com"
	<easwar.hariharan@linux.microsoft.com>, "jacob.pan@linux.microsoft.com"
	<jacob.pan@linux.microsoft.com>, "nunodasneves@linux.microsoft.com"
	<nunodasneves@linux.microsoft.com>, "mrathor@linux.microsoft.com"
	<mrathor@linux.microsoft.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: RE: [RFC v1 0/5] Hyper-V: Add para-virtualized IOMMU support for
 Linux guests
Thread-Topic: [RFC v1 0/5] Hyper-V: Add para-virtualized IOMMU support for
 Linux guests
Thread-Index: AQHcaMpM6NcidOtZBUuxclgz03j4c7VIpRMg
Date: Thu, 8 Jan 2026 18:45:52 +0000
Message-ID:
 <SN6PR02MB4157342641D173ABE9B4F1FED485A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
In-Reply-To: <20251209051128.76913-1-zhangyu1@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7542:EE_
x-ms-office365-filtering-correlation-id: c18320db-9e14-424e-80fd-08de4ee62681
x-ms-exchange-slblob-mailprops:
 7J/vb0KDx3hVaBXFi3Zmt48msziUWKBFdQhCaZMY4gmEtktQDIbDrvPeyZ9jc5DyaW6eZCg2JHeiNeN9FU+HdNelMaTxb/iYTPB3oiKcGNqYJWJ1JxUeshe9+5t8oKd5A6vXUE9gdwTr1d69VDG06THfeUcGKd76cGtTc2ptcwNPfWh4fcI1fNxynIRUdso0rwqLr7aA3Fd22qsYjEy5MGHjFC22Y9g8zB+cO5H4lfvJa5WCAE3gmxY35Gby7Qu2nedAUlW68mrQ9+/RpcdTpqEga+0Dgkf5oDhLEf8AUeEwq99DfEHe3a2oRF3IN2nMRLtskCd/puDnfVk/pN+dI27u4OpiaKK5uvBRBOz29uRSs+sXW5EXeP2uUO2lEAgBjg2DTakfbKr+fHSKB5xtaqAqKSuwGSDzSI2aRhlGuYVhnAynfe/Yqhm6LB0N+p2kP+OL/xah0UtnI6HWG8P6Kl3IGa0FiPRrSoXhGFoKGN94YJs5iSt8PJFa1fdt9HunB2Y9tDOVMe7Q4zxAfGlxpx6z63EMcfR1zitAiww4M2Egqqo9a5OUi2XzNV0fV4/zTiPq/qRn4omrqxcO23CICeoaa3yegEJ2oq1Mf29loT5rKIqF4+O19Md7JPMmyKl8w2tBX6/ej2O/IggD2+cIlTI+FdjEUrZ7rKOycWvKykKHGnnA3yo74l8lFc7fhlYqN4duHn+MAno4FIXwlan+NGrAmQrf28Ho4tSTaBinvSzlqCY5WIUpjyuvxkSGBcS8hYOt46CDfPUnqR6zlna3y9eNwffuXMKNwcMRtegHppM=
x-microsoft-antispam:
 BCL:0;ARA:14566002|13091999003|19110799012|8060799015|8062599012|461199028|51005399006|15080799012|31061999003|3412199025|10035399007|440099028|40105399003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?G3OtoRKyqXo3KlDVPSdwrk2PRbu/nbMfqNOUhiTI5IHS9JczHKRaFkC+sTSS?=
 =?us-ascii?Q?xAAMkKznOwjc589yxWmetfVM03VsHZlqW2YGcN9h5L1gE2TSK+B9UXM7oMfg?=
 =?us-ascii?Q?RseYU25lE8no+x37fRqcz5OgXjctL4qziq3Sn1ZRLgh6zug1RVYph4bam0Eq?=
 =?us-ascii?Q?42pcexHqwSh2FDBFsFZRlCbjUnUvL3Pv7g9pb+pHdYMFiv/6FQlo7FcnTy1M?=
 =?us-ascii?Q?Z8/vhidStXDebINvwr84WqZRuNUX7tLgACRqiEsHGpq1DtojcdeCNgvNBD2W?=
 =?us-ascii?Q?ISiS5JTDU1j2RVCLSvWmTrEGb6S+lWjkiNvpk7FUVJDLQWxj7O+Q9hIIeAQA?=
 =?us-ascii?Q?En/2YW7QK8oAR5qDQOWffrXCxLkiBhNfhYHuwcprL3y1zWLb/hGsql61KrxO?=
 =?us-ascii?Q?DIXeVjNB1rbowqk9VqPc5ZMCDdYZUdltxNw00GhCWcSClTRm39rWkdg1p4kq?=
 =?us-ascii?Q?kFdBxI955OrGbtIfSSvC1WqVzZMjjRPm3Nl+hK/aYD40Wcr0yh1a4yTShrQU?=
 =?us-ascii?Q?59fXCPXNfhfV14c/p+DSF8wcpEHC2RvLhHJ4Y9MmCa0WGEAGfGZDS9uwL1Zy?=
 =?us-ascii?Q?4Bk9/6inBExsoOYA/yRU+KN7brE2zZDAAwLROcJQuP/kpEnKo8f1w+qG3jtD?=
 =?us-ascii?Q?DOQ9a+GuqLJ2kdaMzvX1t4iNHk3Q3gv7s9O9WNgMEe3MbNKJ0bJnQz3lMSjs?=
 =?us-ascii?Q?FjoBmND3psityAfDzL/GvT1bDYVvZnZayWD5C39DM9YqGXlZEvtQ/xyEa3rL?=
 =?us-ascii?Q?p59VKqvAUhVp51d22y+AJvFJEVCdNWB9s1EVmkpsDY+2KEtEU0Ds2yn5BNhI?=
 =?us-ascii?Q?6bMRWErKs+L9d5IZjnsKUnStMQQuXlmT9DgGAyAv3YDpG/wTvtFMAiWO6vsX?=
 =?us-ascii?Q?+J2W0SLalFg7QpofLh7+MvbgoILxEYwfDaPt22VAJmdw3Q7+rCJr1bm0rBi7?=
 =?us-ascii?Q?qR3G/izQo5RmGUPg0EQb4z7QxZRFJDtG5LzZgWMkFwlTj4xlLo4+mh+ttXHB?=
 =?us-ascii?Q?EfRmqxC0Q6PdS+qBQSTEAIc77Hk0Je34yFjOl3wjQvILE3HL5/y6jYH8nf6Q?=
 =?us-ascii?Q?QiQNIlYQG/bPzeWrnmKCtJMQGDZ1N6mY1aR+iPVcEeJ0uuThUhUuz26OJoQK?=
 =?us-ascii?Q?SxTH5OIzvC3UeSQLrnSYne6NF5XLBQ4mqcM/Ne8OQzjXJyuOF2pAerusF4V9?=
 =?us-ascii?Q?QLdDrn4H1oEYrfADopH6n34rNTmXPq6XQY2ZFfe9LhrZ2f2EBEHmIe100IA?=
 =?us-ascii?Q?=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?DWlJFWbDKty1CMEuHe28ml3WHsWADRLm0FciJAn1xDGfjhIKH1jfauqXAEjf?=
 =?us-ascii?Q?9OhEaT7p4EOnRQL57ZRJXq2oHeyP6fj/XL0bfZ/KdPaxBBPLtZwCM49Gz6Xg?=
 =?us-ascii?Q?QZxO58+dHQ1tLd0ouQSELbMaM2lsEcCFiIhmI82to4VXpM2R31shnLTvGhKV?=
 =?us-ascii?Q?SGsrOB/RacDDWMT3j4DsELZ7ulOWKp/1lM/0ypDOxsYzkYHu3ST5nScxcL85?=
 =?us-ascii?Q?pXMjDX+F/J2Rfmb7eKQRmcr7PfttHbW1+fLpIbunFxREjHhOjiCtlUv1da84?=
 =?us-ascii?Q?MKBKzhW1ExDipJBjRrVQZIZ1Z0A8QAYcx/DwFvOKBkPOstwdMiYO7x4V9vfs?=
 =?us-ascii?Q?d2eGKWTpHsah0cwQFUKM4a7zMYNvl5IPLRLXmeg5bBEw0mJU1dQeWxVybAW+?=
 =?us-ascii?Q?Rb8Br7J3RXDygy/x2jFf1skot36ZfQX5pmLgO6czN945GTpkKiHqxi/Bl8ZV?=
 =?us-ascii?Q?CBgwauKe6JfWpuYt384beeNiTuQq/yAhsASm7vT99KOspMp3flZidvE/5hMB?=
 =?us-ascii?Q?QiWvMF+pRmaFPsbfX0+5r1X90lo9SIfhpOXjJSM/SZtxRISsIwmDpK1kixQC?=
 =?us-ascii?Q?IiG9nJj+mnvu3+jX5qUYqfHxhgNcly9K64V983a9Qs1zlS1DIlU0IdfaNxnB?=
 =?us-ascii?Q?tiQTCtdsfNG5vq9KW4v4NuSHLNKW6LvqUyke7snekvAWci32ECCZNERGeMoG?=
 =?us-ascii?Q?o5MvDF+klMqW/EoFyEYUETIHH4hoz9MfeFKfBoBZptW3PnODVwnhQkTe+aDY?=
 =?us-ascii?Q?g37Q9VH7zLwE0/D/2Te50nV21aHzIpqqbUpff0zqtepZJALP658ho1EAheiR?=
 =?us-ascii?Q?xXqqJmPFu/ns13gFgK31hw6RLKnYlRpqrhUqr6MAsTnz0KcLkVPtbiauT5mZ?=
 =?us-ascii?Q?n0dARhK7Ow6UrtbYIw8KFB1D7Hsv7+UodHcHBAGj95OY953sAHbWs+RjBuQN?=
 =?us-ascii?Q?KfLYWGdjHWGR0oyZaeJonZurhZz8vD54LdsEoFmhjDuMmT5daGbULiTflRNn?=
 =?us-ascii?Q?Ke0WWY8EirS1YF7bjxUWtRFe/OfJbY5vSWsPCc0+eafIpN7+fjdgDb1DnvA0?=
 =?us-ascii?Q?gpYlxEq98pVxVLSZodXYpB5/HFNbwqRXvoFt+xEv685MiBzJUXZgqNd1Tt77?=
 =?us-ascii?Q?JorcMeFvT5fSnpQcOvZn5oa27tRba4FBmYeYC+uvOsfyIAWPkEm3yKuZfxyo?=
 =?us-ascii?Q?Ur5emkVtKfWLspaEyuAzGjJhSr9p4Awd+8F8M0YwMCObNRtCi1XbfYKx63W4?=
 =?us-ascii?Q?w1H7g3m+c7NSCi18QA564j5ea9b9bXdF12X5AmJ9QalaC+WGBAXPX3Tvf2v8?=
 =?us-ascii?Q?IApvH1NQBklzix3UQ776H4idcZdrEnpyKh5m5gEOhYuk+6HTnKh28huDVelI?=
 =?us-ascii?Q?YtMi4O8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c18320db-9e14-424e-80fd-08de4ee62681
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2026 18:45:52.8020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7542

From: Yu Zhang <zhangyu1@linux.microsoft.com> Sent: Monday, December 8, 202=
5 9:11 PM
>=20
> This patch series introduces a para-virtualized IOMMU driver for
> Linux guests running on Microsoft Hyper-V. The primary objective
> is to enable hardware-assisted DMA isolation and scalable device

Is there any particular meaning for the qualifier "scalable" vs. just
"device assignment"? I just want to understand what you are getting
at.

> assignment for Hyper-V child partitions, bypassing the performance
> overhead and complexity associated with emulated IOMMU hardware.
>=20
> The driver implements the following core functionality:
> *   Hypercall-based Enumeration
>     Unlike traditional ACPI-based discovery (e.g., DMAR/IVRS),
>     this driver enumerates the Hyper-V IOMMU capabilities directly
>     via hypercalls. This approach allows the guest to discover
>     IOMMU presence and features without requiring specific virtual
>     firmware extensions or modifications.
>=20
> *   Domain Management
>     The driver manages IOMMU domains through a new set of Hyper-V
>     hypercall interfaces, handling domain allocation, attachment,
>     and detachment for endpoint devices.
>=20
> *   IOTLB Invalidation
>     IOTLB invalidation requests are marshaled and issued to the
>     hypervisor through the same hypercall mechanism.
>=20
> *   Nested Translation Support
>     This implementation leverages guest-managed stage-1 I/O page
>     tables nested with host stage-2 translations. It is built
>     upon the consolidated IOMMU page table framework designed by
>     Jason Gunthorpe [1]. This design eliminates the need for complex
>     emulation during map operations and ensures scalability across
>     different architectures.
>=20
> Implementation Notes:
> *   Architecture Independence
>     While the current implementation only supports x86 platforms (Intel
>     VT-d and AMD IOMMU), the driver design aims to be as architecture-
>     agnostic as possible. To achieve this, initialization occurs via
>     `device_initcall` rather than `x86_init.iommu.iommu_init`, and shutdo=
wn
>     is handled via `syscore_ops` instead of `x86_platform.iommu_shutdown`=
.
>=20
> *   MSI Region Handling
>     In this RFC, the hardware MSI region is hard-coded to the standard
>     x86 interrupt range (0xfee00000 - 0xfeefffff). Future updates may
>     allow this configuration to be queried via hypercalls if new hardware
>     platforms are to be supported.
>=20
> *   Reserved Regions (RMRR)
>     There is currently no requirement to support assigned devices with
>     ACPI RMRR limitations. Consequently, this patch series does not speci=
fy
>     or query reserved memory regions.
>=20
> Testing:
> This series has been validated using dmatest with Intel DSA devices
> assigned to the child partition. The tests confirmed successful DMA
> transactions under the para-virtualized IOMMU.
>=20
> Future Work:
> *   Page-selective IOTLB Invalidation
>     The current implementation relies on full-domain flushes. Support
>     for page-selective invalidation is planned for a future series.
>=20
> *   Advanced Features
>     Support for vSVA and virtual PRI will be addressed in subsequent
>     updates.
>=20
> *   Root Partition Co-existence
>     Ensure compatibility with the distinct para-virtualized IOMMU driver
>     used by Hyper-V's Linux root partition, in which the DMA remapping
>     is not achieved by stage-1 IO page tables and another set of iommu
>     ops is provided.
>=20
> [1] https://github.com/jgunthorpe/linux/tree/iommu_pt_all=20
>=20
> Easwar Hariharan (2):
>   PCI: hv: Create and export hv_build_logical_dev_id()
>   iommu: Move Hyper-V IOMMU driver to its own subdirectory
>=20
> Wei Liu (1):
>   hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU
>=20
> Yu Zhang (2):
>   hyperv: allow hypercall output pages to be allocated for child
>     partitions
>   iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
>=20
>  drivers/hv/hv_common.c                        |  21 +-
>  drivers/iommu/Kconfig                         |  10 +-
>  drivers/iommu/Makefile                        |   2 +-
>  drivers/iommu/hyperv/Kconfig                  |  24 +
>  drivers/iommu/hyperv/Makefile                 |   3 +
>  drivers/iommu/hyperv/iommu.c                  | 608 ++++++++++++++++++
>  drivers/iommu/hyperv/iommu.h                  |  53 ++
>  .../irq_remapping.c}                          |   2 +-
>  drivers/pci/controller/pci-hyperv.c           |  28 +-
>  include/asm-generic/mshyperv.h                |   2 +
>  include/hyperv/hvgdk_mini.h                   |   8 +
>  include/hyperv/hvhdk_mini.h                   | 123 ++++
>  12 files changed, 850 insertions(+), 34 deletions(-)
>  create mode 100644 drivers/iommu/hyperv/Kconfig
>  create mode 100644 drivers/iommu/hyperv/Makefile
>  create mode 100644 drivers/iommu/hyperv/iommu.c
>  create mode 100644 drivers/iommu/hyperv/iommu.h
>  rename drivers/iommu/{hyperv-iommu.c =3D> hyperv/irq_remapping.c} (99%)
>=20
> --
> 2.49.0


