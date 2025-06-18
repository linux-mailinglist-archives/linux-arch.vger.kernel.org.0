Return-Path: <linux-arch+bounces-12379-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5EDADF27B
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 18:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BAB671BC3CC8
	for <lists+linux-arch@lfdr.de>; Wed, 18 Jun 2025 16:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DC32F236A;
	Wed, 18 Jun 2025 16:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Cn8VpsKM"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10olkn2045.outbound.protection.outlook.com [40.92.40.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297FB2F19BD;
	Wed, 18 Jun 2025 16:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.40.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750263577; cv=fail; b=t5Eb6PjX9uXs2128R01CmpLmQtR1sXMUE25TKTRO3wRhLlyp12rLi/mpJDH1afWZFoKAJCCMoLvsBSp0lekDbDsAWmL3Fmcsq1mV4uOmHJm+hroVLde0OyEMKupu2CvSYAbjFeAEAbgbkwCHSDwtnAFt1qMETFFbZ+4Zv/YfiP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750263577; c=relaxed/simple;
	bh=1+pOc1gpNYeRajvM7GmwAtDSL1rIudQEwSWloUJcBD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ALxyRPcD1rbaLI9x8o98EpRhWPDocTOIPqO2NsyouhJNHgpSZbY5zo1MXaOf8DPxo1zQFLSEMVqNm3QSZsTXJChq9HBChDdiJLwWXPjwW+BI88u5zHaMsrV0e0IEq1ustGsHDS/xptppWpj9yVFRaFYktlV+WLXb9keB1eCHtZs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Cn8VpsKM; arc=fail smtp.client-ip=40.92.40.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GJzay6wdt8x5qQ5VEpVe9dqnGVomHmX0x61ji7ROyBWdsMRJquhZg0A5iSYdltu7Jfvk/dzAvsFnl9lFVQdsqQTf5ghJHeF6ywYZqw0/mnmVfKbdc+90pB1foBxqI8CYTjLCF9I9/G+TqqlR7Ptp+uoWrAiAas1z+ZI+k49bjAwZyXS4YAL1Blund7CiduWVe3LQ9enTEGBT8KeFKj6vPOYuUY8beHsjeBn9s0vLUbaALpYbF8LKw451Ty9UcorQyHkNMIKvZ4zE5UsDzk3gaTfecGwJoNqsTidsgHyWWQFGceEg5xXF7pnIxAFvIecilf7h5g4ju0qfbCEHlvxC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oUFg2bbHOiNKmZxOcc1zxw3IIfpdFQmqKpY6wsP6RWA=;
 b=erhcZd2nj8C90KHROXdBkZz4hV9jQ0mSyARPsAT/zLoiRF+EP4ubAXGfeILkrK4V/j2ZGxQ4VmVjHRTqIurPpNrPekwF/SUzKbVmffAa53GQzqBhyyJ+efNS9ex+vzLZUULGzRpYApKrxiUfK7yUS7RLlD/RZ38rLzX/toKsZZIrg96iBU5n7TrmiV92yXnBa5EeDMRc+ucSLCTsmxwWoj+HsoVLpsqPVZo5wZ/RlwOt5MtcF7y9Z/IZKbpUVIr6U6jrXl0izV6hg9t+OQLX9BKm9mwvvimObE7vTrCppHStnZiV+PabpmTXFw8tqDd1ACGYBWnFfyrnSZ8xQ51Whw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oUFg2bbHOiNKmZxOcc1zxw3IIfpdFQmqKpY6wsP6RWA=;
 b=Cn8VpsKMOuAgGr0XYaGn45WGyHv5xYVdwE+FswmFWJjhjHYnm59A8Eu1kdapZ5X4H2HQPDsXptKPHNQ54+gQjzyS8A414npfelou3inxWgu4y4Zu+vz6yVJvOblJYa2rg14DGJcRX181tK33B6Aws4ggb4ffYAlHLIaixJt+f0bE7s0ehet99IBqVL2F4wIX9wg5qII0RlMf53JilKVnGZIzBdPlluoelNbHqdCJLxZw/NCfha113xycu8QUZWtsLhMNHP0W3gaW74r6E4+y3QH3X6gIECTZxtWKuK0JAE6sEkKP33Rlrqd2APXJABUFU3dvSbINHuIA21zxfjWWCw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SA1PR02MB8462.namprd02.prod.outlook.com (2603:10b6:806:1f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Wed, 18 Jun
 2025 16:19:32 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8835.027; Wed, 18 Jun 2025
 16:19:32 +0000
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
Subject: RE: [PATCH hyperv-next v3 13/15] Drivers: hv: Support confidential
 VMBus channels
Thread-Topic: [PATCH hyperv-next v3 13/15] Drivers: hv: Support confidential
 VMBus channels
Thread-Index: AQHb1Om9mlpZjzDg30Gbl3KESiV2jLQGxH4A
Date: Wed, 18 Jun 2025 16:19:32 +0000
Message-ID:
 <SN6PR02MB4157BC99328C8B043749FC90D472A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-14-romank@linux.microsoft.com>
In-Reply-To: <20250604004341.7194-14-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SA1PR02MB8462:EE_
x-ms-office365-filtering-correlation-id: 89137fcc-0cc7-471a-b52a-08ddae83e8a7
x-ms-exchange-slblob-mailprops:
 EgT5Wr3QDKyLtlCs+NimovH+2L5LUdRJarrShVGqDJIZnS8bCfXcJybBg3Bn1fHwg66R3Gh/KrSwQG543e6fWxQBzVulfNmDm9CZlIOUjEeyWVv4U13owRjuETvdWU3sQFezF50yOUnheY+6btzXWG5UxtQ8CaswxUmu8HqOkrgUuxlO7bb/egtun6/1MUU4nbDx6kLLLCr9Zm+Zu9N2tQtD0XZeYqc8gBcBGbLizr7JOAaEIKHOwZaAV3Sx8nUgd7oGFpYvtm/KW/kFuj0JN/x7hD9Quyo5f/T/Vv+OCI1zXlChjC2glzeHZ4YPOvXQf2H7RIZhSawYg+mErltV52PwbJPzfdcm6FZD7ONGQnIYiKzMIisitKsJELHMqTuTmkhPlQdH7eixIx6Aghs4DUVtZtInAs8dSJz/71RKPw7Iow/7RpxtY8lgpHNauGD4ueFQTRvb8dJWLwCush5HPO2lkExx9zCZgiJPYngjKPP6cj1+GywPU+vreOiotMPL8g/bczq3yAbfQrME1F0dMpSbJkr49wM+fUzVfN4TWOhsno4BiRggoZ+m/XMeKWklGIgA/hVEbgr7GluqCaIb8jdApgTIrp+l2mJgApVEPwR/92XjRVZlw9gkxTjHZPEXY0uxO+FEufWFuzbl4MYWR+tg7f9+GUQ3YFww/h0YwWpqbPyAXZC+/rlYxCsY5T2eJCPaOaLM4yPej76EJ+0j9g8Ef71CLPn2hG07gZ8OYd0=
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199028|19110799006|8062599006|15080799009|8060799009|41001999006|3412199025|440099028|40105399003|12091999003|102099032|56899033;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NKhkm51fjouJxORa9ZtzZ3kX7EbjuovxSrD9SwuPdaRb5eMIR7GD7qy73UUX?=
 =?us-ascii?Q?FDj7vQjQgRQBSgeKxB7n93j4DqI2/VhxFInvTzLeJOttFmfN9IWbTvePQG5i?=
 =?us-ascii?Q?hzO9Do4qm1ZGfv1du877epXpw59lGt6FjJcTaQjYYJBaDEVUom/nIWQgH0Qs?=
 =?us-ascii?Q?u+axKHIgmzQ8i6kFdz6vzY64wQwTj2xNPzkXNS4U75q1y9NDh36rZ+9YN8YM?=
 =?us-ascii?Q?8L3aGsckgtYYhBpdj2oG7mNNAGB1zuLrOgJ96b35clUKIrDRIsValpTN2Elo?=
 =?us-ascii?Q?AyXvnUQXhWmhJolBuaiPBIum+0BUZtqHEQcR4peE88C7GWznqNzbjGMnQvsr?=
 =?us-ascii?Q?X2mPii3qr0GemTQA2FO/sdGl6Whw6lhScxaM2smoy/5S02vN9/EGcb0+EV20?=
 =?us-ascii?Q?AjAkZe1/PuU+BTxOavQdCcBU05SiSaGHCgrxQJn/5BXB+bj7IT9RBto2E/nj?=
 =?us-ascii?Q?6+e4vmzankZAmvhqpjmyBbfU4T5tiDr/GPjA9WlCwfTHV9P09f1o6tlcnyVl?=
 =?us-ascii?Q?+YQ75iw0hPvABftv5ur6MkeFst3ydKm3ria4aX/COksigDAH8lq17Yoe90wP?=
 =?us-ascii?Q?MbhZXP0kp86QkPFgalITeHhAb9jsJ/G72HAwRBoUUJrRF+AlIqQXf6LFN3sT?=
 =?us-ascii?Q?CirjDzyMwUG/X7aLl8gPWiE0kzUbRbF0JF/+NhHZ8wuDF7NX9q+W8IBWW5d4?=
 =?us-ascii?Q?okhByZuV2/87d3lUw4uJg4qH1oym8nNdR42IfcYSYJN5hMZ76914DBnOL31t?=
 =?us-ascii?Q?IawUlmRn2L3dl6bdG2ntomvJ7e95ZOuAe/rGheYUmJUTDPxYzzgjUzuMAmcN?=
 =?us-ascii?Q?pCCfTfpWalR+4t5x39lkme6++XUMlGQdqAOaFv1KUvgRkcJFi9TPcYqltE0J?=
 =?us-ascii?Q?CHuW5N7xro4zY66UwBWTbdu7WzG7n22liEdvGS+qVA6sudjAaLmtkJJ5vmfe?=
 =?us-ascii?Q?bQF9fDPywnbI63bk/W0ElHbn1QMSYcyYvlUEYUavr0H1slxFcViTzUKg/lvI?=
 =?us-ascii?Q?7jiZCQhtIs7jGvUg5aIx2lUAs6vGvTUYq9kaXKsc5YROCQZxWasBCIGUHhlt?=
 =?us-ascii?Q?Ij69XSJunERi4UJcoPwaogZkmg3srE6DKRdAkoQp+y01gCGOKP+AOs3xpeYu?=
 =?us-ascii?Q?aglVbkFObN+8AYw+WXTBjV3sPisPaOnl7pc2EMor7dCecscUj0/NUFQ=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zwlo0jclsnLNcZ8Oxg1oIjq4xgaH1TK0Nr0hrbVhGHJAeb/m2EIwG6hAXdWV?=
 =?us-ascii?Q?2GP38yjobDcxMsa+RCnK63qWDAzgy8Bi5UpMV5bskwD5sA8advBfCgpi4RbM?=
 =?us-ascii?Q?/FWQnp23EbBuigByLubNWrjbmXtZbPIOBIkUb3u/T1YGLhp/gqvNvRN+IOak?=
 =?us-ascii?Q?g4f/dG9ovo5Ro/WDIxn/PkMQw4woqegj5M27jM4Qm/6Wdd+1n4sUlw8vfms4?=
 =?us-ascii?Q?0VYKeZQ1zLJ2xRUEgLYCg7bzYQxYeJD5h3mr6Y4+efs41ns27GhdrYsv8wXl?=
 =?us-ascii?Q?DqyBswkhwhv2cgvV3xzFwtBPE2iv+dY1k/a7Fwvh8MluOBkKWDjOrMBh3P4d?=
 =?us-ascii?Q?Q/6i1GNRY45iCIcIj3I3A+9mhTFra02DMZW5RrBjQkyqqRe7AvW8ILr1aABa?=
 =?us-ascii?Q?zjXmugFYCkWSkArqlo26VqYmEI7XB3WY2z1t/6MGgrRBES7QH/CuTwT15pNa?=
 =?us-ascii?Q?lQ2ymOFEMQdOczBjjKott/qihD+siKi0ilKhvgTvPIqrVhHIfoB7+DzM/yJu?=
 =?us-ascii?Q?vAFuqlLfQcPpXtk7/WLeVOBFnSBNl/1j8p85sdwFhSRZTCDaCR5eEOfLujGE?=
 =?us-ascii?Q?TavF/CUZEOEQPiKjFrVVJPHVmyeSnWeDAMp25QaSIbI+SJxOTPpC4UoqtukX?=
 =?us-ascii?Q?Bjk0pFf2fHU2c+QNWpTeFwwz0KvPgImZ7g9qigCj6+qGZ+DK8odW7f/8yYwr?=
 =?us-ascii?Q?jfUPTPDOskJT/fhjhUldXkBY5YtlXlgvyrdiF2Elf9y5vw3l2bBVHtvX3nBY?=
 =?us-ascii?Q?2teDmEP9dHR9dNLqnV5KmIAjV2V4i+QIY3Dfw5N8EVEUQJIszNWnfWgPd6+U?=
 =?us-ascii?Q?h4IiRVouzTKRillpwbzr7saPqA2kDHz8oDwCVrbhN97zUgdU7xL2FJC+dT3f?=
 =?us-ascii?Q?uSEsYUseajmHZYL4QomWINJ2yuTnLDgnnyUArZN5Zoar9V4OjQSjfw0956UT?=
 =?us-ascii?Q?X9GMF0kObG0lztN38yxRBpMBb00X30+vGDarU/RxdbLz0yeO9t5/kOM+/9xZ?=
 =?us-ascii?Q?vr50L4ugRWlzsiiPK1FrTNH19SQIz+cukySWDc+bToylelMj6vIryhmKm6uj?=
 =?us-ascii?Q?tlHPjxfqYlrV/GXPJxywDtJbfxypSpoGak4yh57bzi6C/0GYhftDGqa3gaVI?=
 =?us-ascii?Q?MktGXMdPDBSbJdzFJ94vGhvXmX4inxtHZjB2V/238sT8pnhTzafWaRlK2mT5?=
 =?us-ascii?Q?7w+CucQ5QPOc5PewFrmSAVq1igSj8hW8bO5X6d+RV1yb5+xavlFFzn7pAHY?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 89137fcc-0cc7-471a-b52a-08ddae83e8a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Jun 2025 16:19:32.3371
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8462

From: Roman Kisel <romank@linux.microsoft.com> Sent: Tuesday, June 3, 2025 =
5:44 PM
>=20
> To run a confidential VMBus channels, one has to initialize the

How about:

To make use of Confidential VMBus channels, initialize the

> co_ring_buffers and co_external_memory fields of the channel
> structure.
>=20
> Advertise support upon negoatiating the version and compute

s/negoatiating/negotiating/

> values for those fields and initialize them.
>=20
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/channel_mgmt.c | 19 +++++++++++++++++++
>  drivers/hv/connection.c   |  3 +++
>  2 files changed, 22 insertions(+)
>=20
> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index ca2fe10c110a..33bc29e826bd 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -1021,6 +1021,7 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  	struct vmbus_channel_offer_channel *offer;
>  	struct vmbus_channel *oldchannel, *newchannel;
>  	size_t offer_sz;
> +	bool co_ring_buffer, co_external_memory;
>=20
>  	offer =3D (struct vmbus_channel_offer_channel *)hdr;
>=20
> @@ -1033,6 +1034,22 @@ static void vmbus_onoffer(struct vmbus_channel_mes=
sage_header *hdr)
>  		return;
>  	}
>=20
> +	co_ring_buffer =3D is_co_ring_buffer(offer);
> +	if (co_ring_buffer) {
> +		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential=
()) {
> +			atomic_dec(&vmbus_connection.offer_in_progress);
> +			return;
> +		}
> +	}
> +
> +	co_external_memory =3D is_co_external_memory(offer);
> +	if (is_co_external_memory(offer)) {

Use the local variable co_external_memory instead of the function, like wit=
h co_ring_buffer?
Consistency .... :-)


> +		if (vmbus_proto_version < VERSION_WIN10_V6_0 || !vmbus_is_confidential=
()) {
> +			atomic_dec(&vmbus_connection.offer_in_progress);
> +			return;
> +		}

The test for valid vmbus_proto_version and VMBus being confidential is dupl=
icated. You
could do:

	if (co_ring_buffer || co_external_memory)

and have just one copy of the tests. Also I'd suggest adding an error messa=
ge like
with the "vmbus_is_valid_offer()" test at the start of vmbus_onoffer(). Tha=
t way
incoming offers aren't silently ignored. Something is wrong on the paraviso=
r or
host side if the tests fail.

Also, since the combination where co_external_memory =3D true and
co_ring_buffer =3D false is not allowed, perhaps a check for that invalid
combination should be made here as well.

> +	}
> +
>  	oldchannel =3D find_primary_channel_by_offer(offer);
>=20
>  	if (oldchannel !=3D NULL) {
> @@ -1111,6 +1128,8 @@ static void vmbus_onoffer(struct vmbus_channel_mess=
age_header *hdr)
>  		pr_err("Unable to allocate channel object\n");
>  		return;
>  	}
> +	newchannel->co_ring_buffer =3D co_ring_buffer;
> +	newchannel->co_external_memory =3D co_external_memory;
>=20
>  	vmbus_setup_channel_state(newchannel, offer);
>=20
> diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
> index be490c598785..eeb472019d69 100644
> --- a/drivers/hv/connection.c
> +++ b/drivers/hv/connection.c
> @@ -105,6 +105,9 @@ int vmbus_negotiate_version(struct vmbus_channel_msgi=
nfo *msginfo, u32 version)
>  		vmbus_connection.msg_conn_id =3D VMBUS_MESSAGE_CONNECTION_ID;
>  	}
>=20
> +	if (vmbus_is_confidential() && version >=3D VERSION_WIN10_V6_0)
> +		msg->feature_flags =3D VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS;
> +
>  	/*
>  	 * shared_gpa_boundary is zero in non-SNP VMs, so it's safe to always
>  	 * bitwise OR it
> --
> 2.43.0


