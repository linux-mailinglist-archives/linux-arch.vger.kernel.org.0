Return-Path: <linux-arch+bounces-11422-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD67A9217B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 17:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7306F4643EF
	for <lists+linux-arch@lfdr.de>; Thu, 17 Apr 2025 15:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13D9253B45;
	Thu, 17 Apr 2025 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dI28o+tH"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2020.outbound.protection.outlook.com [40.92.40.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B4525393D;
	Thu, 17 Apr 2025 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744903671; cv=fail; b=dv/7D7sDkyaZEMcdw0Tg98t1B23iN57ajPMefTPJ3e+m0/AW8unwARcfRYW8KwRLtB68PguhYOaN224p9BXX/Cx+EzrrmimDgTzUf6T00OypPthZjz6UStJRsfmRdWDZnhYzW8dOLc1UXoYVJPcUrK0bFboNl2YKjTBwf+KumNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744903671; c=relaxed/simple;
	bh=RXFk/uMT9wb4FEt944LI6aI/F4c/Q2/QQLovq/i4V4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dThnRpDV3JtrRxLwmYjsY1fJLSMl16Rt3/A2Nt2+IuXbZQLEqFRAZ6jB6hxD5bhfvbdvb1Ev7iiJ+uKhKfpdgvDARJhq3ZpbRkDP2rEZTx5HPeK0NePqlnFc0H5+D4cotwA0JTgDDCF4YlPdghtvUYKxXWPTvphl2wC6V8Akp+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dI28o+tH; arc=fail smtp.client-ip=40.92.40.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r/HKIGLn7vS0dKS4BrPFhJsbCtruP7N3rV0VwejrDd5Ru1NObGI+oVh/inwwol+0+1bbl2N9Xo/O/GP2jSPOg2L2m30Vw2davghxZvG1ol1NOTfg/fUQ4eJKiWQ2OxaCNdfCauLiSc6q5myFPvQDTkAeaZVJydVU3nSYps4oLuUTL5EhiAzV2spBFBfCoU7oIhC0vD4zCSWyMcdknafuMUMFrUnvuIwDtBzblZ4afRPeoa5P77ebt6wwH0N6Awcr6RfS1FOTtZoVDlqUm/0lStwToUE2r9NH3eiYmxdVV8CMuyYfetRW0Ex0NhXrgKCXN3zi/pOVGU5yIwBGP1YE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oxMOnbwRCh2T1ll8QnewFVqCjSgwR8Mfmw8Ia9ogiFg=;
 b=tvmWBnm+HP2nw2dNvmjlA6+adP0TnpU7bAr1iSxVDbFZnJVbDnP4ZIxkXr7VuCqFiby9mOsFb50qu2N5M474EF4clzsm2pSWgff7NKTmlMEZlyy1HWZI9Jm8n2UKKPrvt7necO05ldUUaaKBmZtAuRnGrkk3P5jeTcq3FomQOBXCLSqWkyPM6wWjoTONA+SSF1xT9pdhG6VbM45a5dD7JYgg154beFPxvvztdrzOaOijlIZzO6RFnZM+MO0kjwYxg1C6ZJ4AxG8SSr+brClTjkgXm+miOrU1C2OB9ap5V3QlD3YSynLdWklHZHUkzN968qa9D1NzSKnblIOjlnuwgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oxMOnbwRCh2T1ll8QnewFVqCjSgwR8Mfmw8Ia9ogiFg=;
 b=dI28o+tHcEWc0j8AuNLgEKlNDhml5TZSfmIzmOJCHEtcvRux1RFJeobgA5ObJ3OFmZrDj/E+ukETvt0lQ/gtsqf8IN0AvtA3RsJQGg7+TiAHpiPiUDlrDIpntPSsRIOZKoLTjlUslpd1Hytq+ZRT09f4P6qAJpPRyKgG3fjtAz6Nlp8YVEyjvF6As8bFMDbXgF+UnIw1zm1K9ZvpqbhF99I0SVx1649jZM92MgXTuDYQtJQaYQMmaFHm36GDSPlT91jRp5WyZhL/N4Nu9xyyoq3EVf9yrFEtRIN2GSdYAlV/wN6c0NwPAHLAI5VOJ3FVvVoDe97/Vs4Bl40LV/udgA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by CH0PR02MB8209.namprd02.prod.outlook.com (2603:10b6:610:f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.35; Thu, 17 Apr
 2025 15:27:47 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%5]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 15:27:46 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "bp@alien8.de" <bp@alien8.de>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"joey.gouly@arm.com" <joey.gouly@arm.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "kw@linux.com" <kw@linux.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "lenb@kernel.org" <lenb@kernel.org>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"mark.rutland@arm.com" <mark.rutland@arm.com>, "maz@kernel.org"
	<maz@kernel.org>, "mingo@redhat.com" <mingo@redhat.com>,
	"oliver.upton@linux.dev" <oliver.upton@linux.dev>, "rafael@kernel.org"
	<rafael@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"sudeep.holla@arm.com" <sudeep.holla@arm.com>, "suzuki.poulose@arm.com"
	<suzuki.poulose@arm.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "will@kernel.org"
	<will@kernel.org>, "yuzenghui@huawei.com" <yuzenghui@huawei.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kvmarm@lists.linux.dev" <kvmarm@lists.linux.dev>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>
CC: "apais@microsoft.com" <apais@microsoft.com>, "benhill@microsoft.com"
	<benhill@microsoft.com>, "bperkins@microsoft.com" <bperkins@microsoft.com>,
	"sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v8 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Topic: [PATCH hyperv-next v8 02/11] arm64: hyperv: Use SMCCC to detect
 hypervisor presence
Thread-Index: AQHbrY992QgEV9XRO0SPB3XqpfxE4rOn9Rpw
Date: Thu, 17 Apr 2025 15:27:46 +0000
Message-ID:
 <SN6PR02MB41576A5C3C0F5911A308E804D4BC2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250414224713.1866095-1-romank@linux.microsoft.com>
 <20250414224713.1866095-3-romank@linux.microsoft.com>
In-Reply-To: <20250414224713.1866095-3-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|CH0PR02MB8209:EE_
x-ms-office365-filtering-correlation-id: ff7c090a-2e93-443c-22f1-08dd7dc46805
x-ms-exchange-slblob-mailprops:
 AZnQBsB9XmpI8tRyoOXaSUmOkLVCBKasj7DtSkVvvvmzzScxvz5+d+katGSkjZGcT94LN2/O40oBcWB3GqLjJk6puo0NUxnz9PLsQRIDK6aFvtKe50nFESrcs+n+A/QTRsmGwYiPIhxDq9cKH7FfbbKiHU3NK4fKcvyicxSoyOJ9ItSkvB8Wb8b3X2rpLXfSYNqoA9bQtQ78rUGjPXqGwJUFGdUAJNGS5nrqQMu+0wPdnQYU9tnahOdsetU78SwQoDCefuIhYrdlart1eZLT/nuo5G0tdsNYEdzt9lGHHb8KEXCmJ4bJooyWQdcuYxnS6NaVn8OjhAlpEX7lyDJlYTBDB54LQDPEEgMvaECjpLZRLFWlxkr5J11Oz3tDj4455/vfvM2tmotkG1HiW3drY00GQ5JQ2JNf8YxNmwWNzrb5CaQgH5POEcBmWYMIwUehX18u6N6LFjSg7Tdj3Zr1XyxMMxd1aFrKflYChhUFPXaOpqu+2+wMk+AfSrpVBu4fljwkNxl0yLNKS6Wo239z9gxBvW1R29k8JitQ17LJsQ3vIj+UVdu+1iqmImZiXLMEhsfLQQaM9ppAqhScWwP5QYjtpvMBYcqUXgoSQzhjcPfgT3rwFXw9k0YRjiVk82FXZhipx06DdnQRajiy7Mph8Kt58tJieB0YXAPjbT7lm7I7C6rHBIzQKQ+2M6zr3mWn3pECjg/f6EhJFIEasS0dDp5nHj96pGZTK2OyLsNF+p4NWSjJ1F/V5381G4dIdUOl8oBp6e9vabw=
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|461199028|8060799006|19110799003|15080799006|3412199025|440099028|41001999003|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?sPULcZmSzmzO0HmZ8Ob2fs9CpkDYlHb1zfnYz6AIj6qzXiyfP+hLqh1xIeP5?=
 =?us-ascii?Q?i6YPQ/w3HVrJ5JcmnX+90qdV4VdKr/dl4lwynG0x5ID6c2psdURN+SuZ1odP?=
 =?us-ascii?Q?N4K82yN8ut6/8QFwIEFJ3dYgqu9RR9E4bs9ZQpLW091fkMB1JnYaGvF8O6bO?=
 =?us-ascii?Q?TIRiZZtGrnHHMXXLP9xHKXAZBa7t2yvdbW+zo+m5fxMG+MDyRqOqqzxbxl4T?=
 =?us-ascii?Q?EPVW13W5aI83Mejum8BoqL9Dn/BVOzF5eHgHehm1BbdIgX9tsYiZsz6XFAV2?=
 =?us-ascii?Q?XR4m0ROAlDX12tF1MH7cdrNcpTq9RhcDqMspg0OkHSb6S7OxBaSkfIFpSU9X?=
 =?us-ascii?Q?b6UQKRxg8sScBldKUXgNhjKMKiXy7Lv285C0DrK8W49hq0l+zuqAE0TL53qg?=
 =?us-ascii?Q?ZN4GdgehgP65XTU/a7Z2LiqRHLty29xnnu+7yc3JHN+w1p1XD+kxKpF+LNb6?=
 =?us-ascii?Q?HIgAXtEWFauaHkkCiILZ3xNNphrwqOZMVVFjWWqwY7w82rmxZfPLhTt7ktkK?=
 =?us-ascii?Q?gtUGSafwuyHzwbkOamk+t36nW3Te+MMeSDydwCrCvSHfuZ223ujcxb7RRWVb?=
 =?us-ascii?Q?Rp2/ZPlwvWObyAnEpI/ARYTtiyu7fhmdBuqAFUiqtjRZ3JVf+YTk/EwAN8ET?=
 =?us-ascii?Q?JUJX1kyr31EJbpBpfKi2JHxQwWAUOXrV0hbpCw0FgUhT4xWhme+IlIvnUlhM?=
 =?us-ascii?Q?1Hw3FcsElwPzMtuQ/24W2bvfaWRQ1raDXY/S7ctq7N/Lhkf+3E3dpIykRrRa?=
 =?us-ascii?Q?kbsMNyRUf9ohMd+8gWgQ/mD5VAzlt8e7aO+Wp9GjXREmxOWSZaah3FXgb8Zg?=
 =?us-ascii?Q?D4Wi6ZkZ7jpk216OZL9DMKvOLB1a6ULfObr8/lYRVtXsFrNgR5bCY7QSZgy4?=
 =?us-ascii?Q?cCKnROsg/VAMp+wkbXbanfMHa4MS0snxDXqHtbcFi4YwpexMF2urxhNvNK8t?=
 =?us-ascii?Q?kcq28lV3DyYlTcHZRzXGnWxSGpfdt6cBEcUS1ioTCQPG9LGVSk8yDY4h4JGH?=
 =?us-ascii?Q?qkVXlg9IohiCZa3fUCrqFpJULq423hMvZSbcdJNxcnghwd4VImUUHZsWDSVO?=
 =?us-ascii?Q?9tRZ3u4Q4df54VQGfC5wnSejo1JLgnv21V84rXGeC6mdjWW5LKw=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?D0m824fIYiOAIJZWFoURKfxO9a9JdUNByGMUlQeJv5AFIbjoNxlVGjBOgUSZ?=
 =?us-ascii?Q?exF0VjfxDmLqomPRRNmyFtU2iLYiS8UC41IlRq7BXSu9NGkNyE/r220zZBbf?=
 =?us-ascii?Q?ex7lec9ugr2oCLE6UDFEWsIsUxPotbQ3EOaGgOFdZNxIRlvu6sEJxInnwl25?=
 =?us-ascii?Q?aTFIB7hus9lY6nH+Sp/g/3Gm/bNinpAPX5AH6yEsZRk/mHxQwYq9ePPCWDyz?=
 =?us-ascii?Q?ok4JkXyyPNI5dg8ibGZyT4w8DWaDmjTmUiqHfna9WyTkAtqZEt7S+qtMFw8u?=
 =?us-ascii?Q?+Fqgkw9O7PGSNN2KB4dzYdMejE7Nf1S94HMgJMD+nHFvi3khdvoLJwvKsmlS?=
 =?us-ascii?Q?SHDYDY8igZaO2YqGczLhRA2GgBGfW5E4aAEX6ktrYosNfq+QIV8uOXOjF+XM?=
 =?us-ascii?Q?3omAuuc1K4rg0Lxt9dE7r6wwT5p5dQGyWFYPi2NrRUaat0emZqYytmqTCdTK?=
 =?us-ascii?Q?Nvs2oNDrKBj4Tat8ilQbVkl+Mga6acjmPKViqOurYK3bAX/J1bUv+sGYW51F?=
 =?us-ascii?Q?x6oZ1UlmM5PJ+fTeD1EVl+bC7qBS3pCQ0otb3J1wPq9cI7AOnGT1ezPycG5w?=
 =?us-ascii?Q?85gH+Lwnnjiyv2vJ0F8qgb65KnQl5xTI1AnWeTBI5ahDW5OE4B5HSKHFGU38?=
 =?us-ascii?Q?mROqX5jOR4kpb3rq55i9aIdv0ylQ9MkMGaY+sf5UmhpS7pBDsLSE7THcVDzB?=
 =?us-ascii?Q?e9L7TYQdgpkXwHr+IKbXwZGUP1vgYnHtKDn5sXqFZqv4dO104gaFjsf9F/Af?=
 =?us-ascii?Q?JJzqEyd7+73xZ9VeDlUZMRmdDOjU9sM1Sl59jvkDksObHyCqXmmQOoZclSt+?=
 =?us-ascii?Q?G5aDZifW0iyxCGAttn0R91ElSudZC4ux/7ygG3ux6g3/RxKW3vXRpcn0BcQG?=
 =?us-ascii?Q?p8ZTq86FWHBzn4FBuZclzZkxlSuvLI1PwLoH/jJcMxvCckMV9u/NlOTwKf5B?=
 =?us-ascii?Q?f6qgaj4ojAxYCl4F3cWq23+dsOssFRtjbmO26QRrkMuHL2PLk4C56ZdZsaV+?=
 =?us-ascii?Q?ixaFShrhSlygEEPOfe18yYaogc6W1aJX83GhYem0a05WORqNhN+9o4Giijfr?=
 =?us-ascii?Q?abELc8OerpBHcVLbLQEPF29ZM+AfTXLeq0HUvWMsp1PckflKZ6hQugcyQx6N?=
 =?us-ascii?Q?HboXYccMS8UOKT7aVasCxfnLjZfU2pnyyLXJDtjpkNWxyhxj+x7XCafDRiqC?=
 =?us-ascii?Q?mrcZiC4PByUJNvK7h1yKXHEYrBrKI4FaR/FfujBXO4phYM+Bm9Zzky8fpSs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7c090a-2e93-443c-22f1-08dd7dc46805
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Apr 2025 15:27:46.8273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8209

From: Roman Kisel <romank@linux.microsoft.com> Sent: Monday, April 14, 2025=
 3:47 PM
>=20
> The arm64 Hyper-V startup path relies on ACPI to detect
> running under a Hyper-V compatible hypervisor. That
> doesn't work on non-ACPI systems.
>=20
> Hoist the ACPI detection logic into a separate function. Then
> use the vendor-specific hypervisor service call (implemented
> recently in Hyper-V) via SMCCC in the non-ACPI case.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/mshyperv.c | 50 ++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index 4e27cc29c79e..21458b6338aa 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -28,6 +28,48 @@ int hv_get_hypervisor_version(union
> hv_hypervisor_version_info *info)
>  }
>  EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
>=20
> +#ifdef CONFIG_ACPI
> +
> +static bool __init hyperv_detect_via_acpi(void)
> +{
> +	if (acpi_disabled)
> +		return false;
> +	/*
> +	 * Hypervisor ID is only available in ACPI v6+, and the
> +	 * structure layout was extended in v6 to accommodate that
> +	 * new field.
> +	 *
> +	 * At the very minimum, this check makes sure not to read
> +	 * past the FADT structure.
> +	 *
> +	 * It is also needed to catch running in some unknown
> +	 * non-Hyper-V environment that has ACPI 5.x or less.
> +	 * In such a case, it can't be Hyper-V.
> +	 */
> +	if (acpi_gbl_FADT.header.revision < 6)
> +		return false;
> +	return strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8) =3D=
=3D 0;
> +}
> +
> +#else
> +
> +static bool __init hyperv_detect_via_acpi(void)
> +{
> +	return false;
> +}
> +
> +#endif
> +
> +static bool __init hyperv_detect_via_smccc(void)
> +{
> +	uuid_t hyperv_uuid =3D UUID_INIT(
> +		0x58ba324d, 0x6447, 0x24cd,
> +		0x75, 0x6c, 0xef, 0x8e,
> +		0x24, 0x70, 0x59, 0x16);

I had previously given my Reviewed-by: on v5 of this patch. But
looking at it again, it would be nice if this UUID were defined in
include/linux/arm-smccc.h alongside the definition of
ARM_SMCCC_VENDOR_HYP_UID_KVM. The UUID values are
are independent of each other, but it's a bit asymmetric to have
the KVM UUID defined centrally while the Hyper-V UUID is
buried in Hyper-V specific code. But I'm OK with the current code
if there's nothing else to respin for.

> +
> +	return arm_smccc_hypervisor_has_uuid(&hyperv_uuid);
> +}
> +
>  static int __init hyperv_init(void)
>  {
>  	struct hv_get_vp_registers_output	result;
> @@ -36,13 +78,11 @@ static int __init hyperv_init(void)
>=20
>  	/*
>  	 * Allow for a kernel built with CONFIG_HYPERV to be running in
> -	 * a non-Hyper-V environment, including on DT instead of ACPI.
> +	 * a non-Hyper-V environment.
> +	 *
>  	 * In such cases, do nothing and return success.
>  	 */
> -	if (acpi_disabled)
> -		return 0;
> -
> -	if (strncmp((char *)&acpi_gbl_FADT.hypervisor_id, "MsHyperV", 8))
> +	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
>  		return 0;
>=20
>  	/* Setup the guest ID */
> --
> 2.43.0
>=20

My UUID comment notwithstanding,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>



