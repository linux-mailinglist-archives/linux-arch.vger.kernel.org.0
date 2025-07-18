Return-Path: <linux-arch+bounces-12856-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FCFB0A931
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 19:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD12A7BAAEF
	for <lists+linux-arch@lfdr.de>; Fri, 18 Jul 2025 17:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7588D2E6D2F;
	Fri, 18 Jul 2025 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="dlPAbo+y"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02olkn2042.outbound.protection.outlook.com [40.92.15.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8C12E6D00;
	Fri, 18 Jul 2025 17:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.15.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752858799; cv=fail; b=fD8c0qV1K+7R69CVUPeMzj8apmkRruisH9IrtRfhGD3pDBxV7JlQfc/TFkIcA+UDmxx54qLb6SDReSQK77EIV6628+ohOVaP0G1gMmfwqJKjORiJfNgtoTgM51ioeip6WG6WBawRclphrNd7QV7+ADMWmSqViqOmQ5NJzVzbulA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752858799; c=relaxed/simple;
	bh=ZQqqN60gPdFgaXYQDYpsWi6VsDFBZ68AKxIBcrz25E8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LENzkpQbTKr9mCGhqQ2otgE855gua2UOnXP2ZVzV1dklGeo1Bn75V+KqlownQJD7V8f7KM0ZVTC2/AqxVHcy62sxpVd79YicioYJ5KBG6Wym2CERdkdKJi8Nc894Mb2gx9zc0pN+xh+Mq4V1YyyTC/tHRZSUOiQsli+dEGJ3c7M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=dlPAbo+y; arc=fail smtp.client-ip=40.92.15.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kuqqFGxRkvxEfIw74Dynp2w5W3//NdNs+pc1W7ULBw4ch50UQqc51yGiqmemSeSYlxMpBhC8NeRO5iSscknFtphNmNwe0soJH0qq62TTP3Vqhywn1hjjx5WwM/obk+hz4xKqRlV22/76BQe5YxqyQz9uwZT55UPaa6RhMGlLOMpn4xAjwrES81HHeEYGtzsD1CQSMKYouk1H22darTdYOHtIFJvOt9yO/DVodLdBZ5PjvhkIrIWJxasBVKUHt4pMlcFkEeaxR/UW3syr3vI2PoO92kmla65Tj/H0C5LlpdqAttSBoZkwnS3EsnvDFwVsH5nCsphTc6gtNfKSUgVMeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Zxy7Cf00/7zzbagB1+RdBaj3c8BeqAZNcUFoPiHyl0=;
 b=uMTOaJWRsHWkieqAAwP+AeFxAm1n+hJSgRY+RaZKP4vtgTvTzEV38l3VPVrb8zYRulJgrqTeYxcLktvuj1lxhwEe7hsTTHi4+YrIgAKMfJcJyOAbNl4e4InNh3+qlKOJmhxqo9m2T30fjklbKU6yDhYp0tGPwhKUyQtFnGj7mtH4y8MyqnaW7jhwKlzdFUBScZ1sK5f4ToAA5RtZ39yG5W+qQYPzYkRWRzoHSjFkkzqIWR7HIDtVIrk2osuv3qX1NQAlfMH8XRuwB7AJaCI/fK5+RirB77pdxBi+be/43SewV63BI5HbHj1vtCOnV4wbtCOcZrPfMSuTC3BsUDeVlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Zxy7Cf00/7zzbagB1+RdBaj3c8BeqAZNcUFoPiHyl0=;
 b=dlPAbo+yShjTkvWQb4dw3dSOD5oO/SMTA3fQD/hl+F0sjvfIGOjblVslvNA/7ZtvGup2Z0Bucb6A+4ZsRL3beb+sd07elck6y3244K3hIYgGQLhWk7xvPykPevEGj0PqX0BNJXRx2oqQlKVrX6HSuGnvy+5dTzcNIkNanJO/mRkbZmL6SANmi6yB5vu5ShSdlKMLTAZdLTKCzMzcr8O9duwczof7fVQimtlnoa3gmvX3QXg6JPCUxo6WmhSisMx5LpfgjqEDzhH/auLBhuwHfIXIf7vWw5PwemptunrB3nRHeG7tYNiSDJaaswPKbsc3uGkJKwNMzfd4bswhgfqKHw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by LV8PR02MB10142.namprd02.prod.outlook.com (2603:10b6:408:192::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.35; Fri, 18 Jul
 2025 17:13:12 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8901.018; Fri, 18 Jul 2025
 17:13:12 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"hpa@zytor.com" <hpa@zytor.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "mani@kernel.org"
	<mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>, "x86@kernel.org"
	<x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
Thread-Topic: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall
 args
Thread-Index: AQHb96BLaxI7ZKQtcEykvxaiGfmaJ7Q4FA6AgAAJxBA=
Date: Fri, 18 Jul 2025 17:13:12 +0000
Message-ID:
 <SN6PR02MB41570625E2F061C5E494C7F4D450A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250718045545.517620-1-mhklinux@outlook.com>
 <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
In-Reply-To: <c5d4d351-a7ff-4762-8bb3-61554d4f9731@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|LV8PR02MB10142:EE_
x-ms-office365-filtering-correlation-id: dae3ad94-e50a-4559-181b-08ddc61e6082
x-ms-exchange-slblob-mailprops:
 dx7TrgQSB6f6/VgI1NdrdDvPWUoa1m1sjww2TyT81bO+9CTBk1xv/mhfqIF3bWme08TtkPlqsIAarEAtnxlhrjeTzqdzCsD3lxFyotM9Elfvfg018GRLQHElZAh67307E6+MaSVOpwjEXeR/0jgx7uHNObbTm6LrMTlOd2S8Ao4MdVXI66BweB1Df3z5z/M7FhQoCbIyBrITQEOhTbkcOQat6Ma9Md1wQKySQcOf9ZwhFmWkIVY8438TDGPq9VGerR9MpsG2l3FSUVO+yhHv6jB18KxTL3q29eenFngB/56HrvLcWJkPsCYwwSnH7yK3hqV1FJASrHxSoqjkb16WlvW4+Jaq7DdQaUWK/G1Ta2fOb1GswS2SLNAhJ4jM7bxVQ7chDPFrArKKG6Xy3CmgfAWUMmsoBBJ1yKr/Uock8lE4FalkcAoHcxOTtD2BCoMeqMIzyzEgn2EA1jClzE+uXbD91MOb8OYyDz67pGBotzCQXp1Q6Hn3fbuUZ88JjLGC65BKj1SBzP64TeHg517dWscVz2LJ8dRuK8lzqgXU4vFeUGRYEuCcvBj+WiBMOXeMj4asCZWhlolPJfcLLIkivUkapmZQyJ2fKa6YXWW8UxU+ZH7/Z3EZqfoTkK+q6BFMc8PuNLVrX28PiW3BML6N2guuOdU/8wF0EWjjKzzUfKKnRi/HIl6JDPyNFO88xdhQP1LH9UI1p5fRZy2aYeXOpudL3sdv3gXKFwC9gxcCWBrjkwQaGUDCCvdq7r6iGX3/q0LPr7OHdjY=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|15080799012|3412199025|40105399003|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FUxy3CP4lLJ9L1NwXA3icpqyQaU/ISIMefP/Cpzi4ngkhXUs1CEeWnGzMsYp?=
 =?us-ascii?Q?HFnPJDECoYiqpZT5YMQspJx4tszrc9B1V/33Giz8XVFOYvnEHR/K6cQEm5zl?=
 =?us-ascii?Q?tckSxHaETgO4W/6y0Wd/GJHPtZvCZqJvb+mxPMFARbhyPhgOB7p7Od/L5jrB?=
 =?us-ascii?Q?iZRaCwfUdd2MFZqGGYt8Hho4DpUg4/cBJNI2JxlkY/v9eayIboRuqL/6iHGz?=
 =?us-ascii?Q?drDU9VhbAl2V0arXbBWUbXsVLLEjj3MpiFfkKDE98wKYUtG1+Z+ygYIxszaz?=
 =?us-ascii?Q?TZDYnDoXwrqiT1wiSvnLJ2LuETo1ZdS7SzNMr3QOs1IbOWc4sLXoCickgCNE?=
 =?us-ascii?Q?5RtDu6/MmiWhLgnJUBhH2TmNj6JXr3HZOsYLM7Tcs/omIQg/6G8mjxHFIxOo?=
 =?us-ascii?Q?BAuREXiwobAXDvzcixtV1YSrARrAilo1otIzTK+MDK5Xt4cAFInXfDr/bIh8?=
 =?us-ascii?Q?77XudFKVCZV8DazdmiIytO1YW2HYN4U1hjdYeC/jJ6V90FsqD0LXt5gr8LoQ?=
 =?us-ascii?Q?DygbsLfWe92jpRKkG2LS1j6vX50zax+wPQG0/56juHo8ihKk5oupLq8PMQiC?=
 =?us-ascii?Q?1jDLYhUvLsYUUBU+s13N0iXUGiBVXnivh6O+gBTKbETLmDbhMuZryvmHSqYR?=
 =?us-ascii?Q?+lS2S2L9Zst3n6bzD4CCAOWwzkC96FfnlY5BaHPLRtdbX5wV9T9fxqZXqiY/?=
 =?us-ascii?Q?7VnWaDW/rHJ9fETsyPpriRLt9Tql+dH0DSEDhcToi2yxr9NBo9C5lKvgQzrQ?=
 =?us-ascii?Q?TvJb1Cgl74tdkeExu4/+uLNhAR5V8aqQKVsjxewxeLwTxjvWqF39o1J6a1vK?=
 =?us-ascii?Q?HZ+fm3zkuK9w5KhM1xM+XAif0YCJmRP4Kjz0VuaVuCiC3+//4wkTsHfm8j+n?=
 =?us-ascii?Q?/hFZ6Q0y2ryuf6wiXMUirksqy9TfkpedcrnbC703CIp9Z6E88QuSI4KwxPCq?=
 =?us-ascii?Q?5KRsiNH8W1GIvf5bwCojSf85XaqRsI1XiWmwhoZuUPq8oBW/X+9IYfttJaEU?=
 =?us-ascii?Q?yX8ojtkMHsjmcqIp9Eo9pNutCA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Iun4SkT8wxi459S4lSsTNjaoZOXc8ie0BLFBJewV41Gban6yPu+fAqUhSQKe?=
 =?us-ascii?Q?1MP1Q7HriGZr5NoPOyw5fJi3xtDUP96z8D8/8TKETjzFdn6Mce03JSpedfCd?=
 =?us-ascii?Q?Z2orIvdCzj6UTtSWU5Ml6d12208vy1ZMgZ81NmsdzeUPGvWNL3RS19RfRjCc?=
 =?us-ascii?Q?NO93DiIYcX2vxyIG6BzghfraQFdNRghhBNEKExeikUpD4DByrrVAU+Hj7Ob4?=
 =?us-ascii?Q?OI8A9/wsBxrXxcrsmJQ1rrEfsfZhakmeCYKqVQ0lwqIIC1jO8O+VFTD65c6r?=
 =?us-ascii?Q?z0Tbl3smpONfyCPqzu0V/mP1vJ4lHEjNP5hxgCPGQIXgD/cpRHIpBQ4OZ9Dp?=
 =?us-ascii?Q?yzxqTN7BUEXdhbcCTsW2kVpX+x1x1S++GrihVTWbg7a/sxKAhlSbhgZelf2E?=
 =?us-ascii?Q?q9xBj0eKuzAmSrTnK/tN8eEI9t9O/dCBQr2Ia8bhWWnaHPFN2/cLbC45g1PX?=
 =?us-ascii?Q?MQJDRGvc1LKf+AYbTufgX25r6Os6oRYY4+Q9JPW7BAf2wJS59V9Xe9sHsCKu?=
 =?us-ascii?Q?dBxCsClbJUIFLj5bAmyAVEk6d3BN7r6jH6KG1PqmHP5qVR4/kcYbGDmkKgDW?=
 =?us-ascii?Q?TLfoVRM3AyFzjqjZhKxrOE0RGUugsEXQ7QuSeXFBNK151xuJ87M5/H843mIY?=
 =?us-ascii?Q?+RZqSIwHzckwasckIMNaZhWmxuMyBFt17SfBVnwS/NxP/gI4ykq12/Aft0ye?=
 =?us-ascii?Q?QPCeLtsVvaBLyrUCraH8bD2Y6NZdc1AwQaDj8qIQ3CK4i03JmK/J+WY342tg?=
 =?us-ascii?Q?B9buT2hKv5KPCHU1hBbZAFDoIci1Ps474Moj8B/cs0BIJfC8m8Tp1gz+8poN?=
 =?us-ascii?Q?nvwIauDr7fSWDvbcAOrsIAIwUAcN4RNUlqftzYDiCcjzhMiHdKbQEWHcfQxs?=
 =?us-ascii?Q?Am8JeO0eAbZZ6R8AcvcRvKwMmoU7s8JIgXP/UeAlhrKlBU3DlD3cpxd7b+oT?=
 =?us-ascii?Q?V3RnxfVJegjFW09qcLrriXITXDPqDNii8oTh9BNos3XBac4MS5ihWlRpRoFN?=
 =?us-ascii?Q?3WEH0b4lHHSkUURjWR83TxL7nwGH1LUGfI+x3TQf0zMLh4iEfTKRrr67xhv3?=
 =?us-ascii?Q?z0bNqFFKPBaF2TO6/SNFy/HA7Ab7bkA48RPhka4A3KaviTnQni0Tr/VUINwP?=
 =?us-ascii?Q?flj1wfRbXhGgtQTWJuKO5m8t/RorjtQi3LH02qCh3mRa+bdoKmHat80BTlVx?=
 =?us-ascii?Q?9cg7jV6WevKAyKVnuVxsRvVP5W2hmGb/kkq1MFYZ4roVnmfU+79VHruH1RA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: dae3ad94-e50a-4559-181b-08ddc61e6082
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jul 2025 17:13:12.6862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR02MB10142

From: Easwar Hariharan <eahariha@linux.microsoft.com> Sent: Friday, July 18=
, 2025 9:33 AM
>=20
> On 7/17/2025 9:55 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >

[snip]

> >
> > The new code compiles and runs successfully on x86 and arm64. However,
> > basic smoke tests cover only a limited number of hypercall call sites
> > that have been modified. I don't have the hardware or Hyper-V
> > configurations needed to test running in the Hyper-V root partition
> > or running in a VTL other than VTL 0. The related hypercall call sites
> > still need to be tested to make sure I didn't break anything. Hopefully
> > someone with the necessary configurations and Hyper-V versions can
> > help with that testing.

Easwar --=20

Thanks for reviewing.

Any chance you (or someone else) could do a quick smoke test of this
patch set when running in the Hyper-V root partition, and separately,
when running in VTL2?  Some hypercall call sites are modified that
don't get called in normal VTL0 execution. It just needs a quick
verification that nothing is obviously broken for the root partition and
VTL2 cases.

Michael

> >
> > This patch set is built against linux-next20250716.
> >

[snip]
>=20
> Thank you for spinning this version!
>=20
> For the series,
>=20
> Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>

