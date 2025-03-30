Return-Path: <linux-arch+bounces-11193-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7B5A75CD9
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 23:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76D3168E8A
	for <lists+linux-arch@lfdr.de>; Sun, 30 Mar 2025 21:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B08A1E102D;
	Sun, 30 Mar 2025 21:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="kA0WqBxt"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012049.outbound.protection.outlook.com [52.103.2.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696C91E00B4;
	Sun, 30 Mar 2025 21:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743371637; cv=fail; b=RamxxQp4tIxLS81W+I5VVY9MGBEE8aOUJKrvz9c8Rt/cD5zHPbZwMVAYaL2hmnGQdIGWxAtG4hIpY+64lAe+nFIW0+mXpgOhovlUVG0/rqFKYs1JJzTVOHGSCbtVwr67peUiGLBZHImwEulB6zMMkUYJKibq7RTAYSFTvss3KQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743371637; c=relaxed/simple;
	bh=aspQuQ+aJhvXpMtp6IjRMxm3wcLzUbzASxFhWZ+tF00=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FRQ/APQrvdDTO53j03Yc82aznhcp4hgcIXfoefOmTUbOY63nrFqeTsrncZeTzJwz20sv1342fjyhQ0jZ0Kl8UmrekCKwy+PiOVVoRi1e7yyNPZJ17zTCZlBz+FUZFA3ObyDm29x3Ogj/iVyp2DKFuYlKK4DQ7JBt2KBmUxJOrO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=kA0WqBxt; arc=fail smtp.client-ip=52.103.2.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NX0B6e0Y/iPHUZZHhOZAXt4/K3a+p89TvCcNzZyXa42wq7R95jN5XRLDYmL53vKFt2GtNZ7vnJf6MCJzi6ix/MpAXI4fa/5rB5FJntCi58SutrCom49l+1jlvmPyoiGN/krCV8Zn+hIKQEHKcsPTuYdRydw50ufcpJlpJDy460MFKdGijFFmex8/gp43L13wY825BYGWeYvXbMFsUtzWbEBITY7PHZXPzVf3Msy4YCgltu90LoxEZ6T4TqmmyRkABcSm/5qVZhZqCK3EkVWt27tIUH1ec06RkCrON5/dlr4TQIWSVhpTgKnNsNNncVwTbm0d4GXG1deBbShIvzP+1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGoIa4emq0wt1gdEE7rHOPaRVTngesHmF5MoQVx1adk=;
 b=ftZiDvJxFYW0oDsjQooqefkaWhDBeRplqUD0AANZK5iHq14g/+6t8Z09twfgyKbuaGVFBVGwkI26IzQpgfon5pF/Rjabppa7Z6mFqSj8fa2TDR4cQbRrQk+S3a+775+8/msOxWUrxhmSehV7+cGXeimicx52Nw6DJp7Ke7/sM+M2A4b+jt/LBaTsqYCaE0pEtA5tx7CB3sgKje5jylihw5LBmakLGowbVopO0aDmzl4XpWDE0p4uR3Rr3ccDQdJ7O1X6Fnh72UyRDi7agi6V8ztAfGChhnziD7GBo7cMOzWuksND/xD++IhBf4zyKbJdUVFkewpSw95QjHoDuqXiQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGoIa4emq0wt1gdEE7rHOPaRVTngesHmF5MoQVx1adk=;
 b=kA0WqBxtFbYA1lQfRSxvBdCEWWrywR14c5gmifpRB9AiIaVw1P3nX8QoxRNyHnQv0Iyy6imFo2QSZdInl81a49pqZZXUuon3dLhRCR+QuiIKoDc302ZiBz53WYlaiyROgwQ9X4owXE21pl2l/SsAOWKKTggFHO0KSJ9cqnnNVgztSs9ydxBM4RNrCcB9wFxOF0uQgkHDnhA9PC3WdJH72rsiOASN32xjur3d9rzgvlzZkSHCSuN0g2eD+PJytvQww7Z1TAEdqEb3HXxia8u0f8jMP77wcdaPAFPKlFrPAfKeIv6lrU2qR/dKqZbrqp8h9TPYQttVXJDDxR/YuMmfDg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH0PR02MB7527.namprd02.prod.outlook.com (2603:10b6:510:4e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Sun, 30 Mar
 2025 21:53:52 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%4]) with mapi id 15.20.8534.043; Sun, 30 Mar 2025
 21:53:52 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, "kys@microsoft.com"
	<kys@microsoft.com>, "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>, "decui@microsoft.com"
	<decui@microsoft.com>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "manivannan.sadhasivam@linaro.org"
	<manivannan.sadhasivam@linaro.org>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "arnd@arndb.de" <arnd@arndb.de>
CC: "x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
Subject: RE: [PATCH v2 4/6] Drivers: hv: Use hv_hvcall_*() to set up hypercall
 arguments
Thread-Topic: [PATCH v2 4/6] Drivers: hv: Use hv_hvcall_*() to set up
 hypercall arguments
Thread-Index: AQHbk+AV21q88EUTeE6kvPDNj7sy5bN+ExQAgAYmPaA=
Date: Sun, 30 Mar 2025 21:53:52 +0000
Message-ID:
 <SN6PR02MB4157007B9432826CAF0E42A8D4A22@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250313061911.2491-1-mhklinux@outlook.com>
 <20250313061911.2491-5-mhklinux@outlook.com>
 <bae5bb62-d480-46fd-837c-9267c0a30fae@linux.microsoft.com>
In-Reply-To: <bae5bb62-d480-46fd-837c-9267c0a30fae@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH0PR02MB7527:EE_
x-ms-office365-filtering-correlation-id: d3825a9b-8a9f-484f-ecc9-08dd6fd55c37
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|12121999004|461199028|19110799003|8062599003|8060799006|102099032|56899033|3412199025|440099028|12091999003|30101999003|41001999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jVTuxOjziXj8/hltyF7kL/TdUGIIKHMpakRotfsAQcAj5WP2hcxYSHedBfrQ?=
 =?us-ascii?Q?uo2Ff5bu23aXBahYGr89hDBNUdOzA2/QMU8W0cTt8H5KGzEUaMmEWlfWLuJa?=
 =?us-ascii?Q?nQp00zBjBogBuMCqKpMLJKk2VTWicALiLhUlEqeFk8VywucrihdKzPpY8FrJ?=
 =?us-ascii?Q?eLNTvpKwczloYrK5TleaGnJdCsNGyFEnRhX4mlfxo8gbTNxHd+N2Orx36LqX?=
 =?us-ascii?Q?SMBiNC5jSUgwNR8UPH9I5jMeFRaLd58cgRBbZSAZOzzsePouSOcfHuN4lWT6?=
 =?us-ascii?Q?u6JnZO814jivNZm82ZcNdX+dONDLyMFzM/z49DFQ0njdECMQKa1ivfufCh6d?=
 =?us-ascii?Q?0wlVtBVYhjnFnwRrka3CSNdIIlGYqsho3A4mgLDGBvtO3Xe8qz+dEe+HnDkz?=
 =?us-ascii?Q?N5i2nBbLvKpp7wS4PHnOscl5kWReAO8SuaTZ7BmHdDNFOSlT2TuYNTCy7Rwo?=
 =?us-ascii?Q?svdDDsZ7Wib7AOM26mJR36K2pIcBOHB+kU64stusoyOuu2hMWMWBMsPgF5Jc?=
 =?us-ascii?Q?N/9E8zK03TeFoGbiRgUrK9YjAIydKK/pW+30++C0gTzKot32hjwBhdD+mn5W?=
 =?us-ascii?Q?AOebsy2/wMvO1Ig+AYEL0GK9aePdCOtyHMJJcH9053rwqLM0T5x7B8kSwcsX?=
 =?us-ascii?Q?2WMwDhmhV8sdDNVTxPxbYuROGweDMWSXCzMOBnN0AmMJjGAV8LMtAk2IHBkd?=
 =?us-ascii?Q?WP7325+t3mxkmlEFs3r4k3EvHaKVBi67jrTSLsppV0iV+y8Myk6KxY0r9vsk?=
 =?us-ascii?Q?Ub2W8g9Ks0VnoK3THYXHA4qSOrOy60+RjAUAOjbrJLr4GOB/K3TWYH+eUm9b?=
 =?us-ascii?Q?LXGaewleQXHk7y3NlMiUyOipf4Fde1ujHi90eu+HSevYJRvvrocQyzNfpDq4?=
 =?us-ascii?Q?DqbKPnLnYu1+FJwxJLOsG53/esfc3dMVJTME+Xjg9ob0ygVpubBZYJwMlBlk?=
 =?us-ascii?Q?+h+FFs+DJOA0rOVo/FSi0WWFI8v5EJ+GZc5eAqqKwnmnBzZKe4JFsu6ypVuA?=
 =?us-ascii?Q?n4LdoUACa5TGs8dfDLP3+HcBShNmwX3IdC3m8Je6SJHEW1dP2E0yLxmzFHnX?=
 =?us-ascii?Q?j7Jk8G26JnqQrfhF4m4plHb7hFsALMKa/x+fme+8j2e0nYTQvzkTnjhU7Ov3?=
 =?us-ascii?Q?kMqFB80ZeuZn1aLNxwVWkCtDoE0YPUfFkkvZ27igfRAaKkGxSIS13Z1C+BNt?=
 =?us-ascii?Q?5erPZSlTn1tNTxl1Atu3Kj4dKEX6s45fNo352Q=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0HR1vulC3xb/jH0mizz04MOiNgz5VUMUNeMFnsm17GHHYs+/P2FL7ySdU9WR?=
 =?us-ascii?Q?TzZOayo0azSJ6mafH4XySQZutM8IStvoUVYamGvy6nTX0IrWoYEjZ/0uxxIr?=
 =?us-ascii?Q?D1bpZbXrayZDY2kKOFyKSUZUSynaizURfne+b59qbv8ZSH80gpeeIsuAIskq?=
 =?us-ascii?Q?autTGPGD2WinEeb6zHBGU7tEL4Tr1fe6BMmoGfbaMhjWAD9Hwx/phDNf32Km?=
 =?us-ascii?Q?zRbc9R2FsC7e91xzMsXUynhHYkdmvBbztBcDzcsDOYwgWcGY+tBQv66RjrwM?=
 =?us-ascii?Q?7aZXyr112fn3Wt9hZWwQcVONUDDwrq3dOEo37/XRZTKh94w++ZdhG/xdtrA4?=
 =?us-ascii?Q?iHphu65Er0cbx0hbDLnBW/hGt5hhIW/fg9QZvjQMC9UXXLT/E0AtmX0bubag?=
 =?us-ascii?Q?5tfyqGPb6QwGLfU04S851dLIRDy+Nk6nd5fFOEMVm/EAPYaiQZZVmO/sj522?=
 =?us-ascii?Q?DBR3r9v2IfMHZiVGpClsFMc7UVNk4vDEEwixYn7ocJrelbUoFSPnqQcvWavH?=
 =?us-ascii?Q?noI0ohJjEy3kXTYGwSHWhHPXfOA1jTIocCc79+DPuT4ZK0oZsjSFLDCC04bn?=
 =?us-ascii?Q?4lf4P8xqJJPZBt0sGStbySZZNmquUfZhWAqG+HQF+wZPxNzdrkD3BSgwO+Wa?=
 =?us-ascii?Q?M0p3SJxcoJCxBALnV+lZk13X0MFyI/vhsupP4H8DH/KIPs0kk3ndcm5AFnME?=
 =?us-ascii?Q?m2zEZSYABrn0aG9Aq1JAnv08E4bJU19IAF9FwxAkKZJ0k3/7i3KTn/3uLWL4?=
 =?us-ascii?Q?XLppjgHJQMIueLlJfHjPm5p8JWp/mi3ic5ZbmGpGPJ/LQQmy/vKlO/wIkXfa?=
 =?us-ascii?Q?VHlzPDQAyRxXYXitVisAi1diSso2yGo2jfG0jCIR2jowiFG+Tv2aCbPPbSI7?=
 =?us-ascii?Q?n9Rt+GbJEFk/LtilWEbw8NtSU8uQxWDqyQgJwcOO7Zgl8ZjxS+jSvX+JZFiU?=
 =?us-ascii?Q?5/LZmr+aavqb0NufdosS1mTJvNOmTUjrAr8ykzE38hhXvfw1RiOT742BdvW5?=
 =?us-ascii?Q?44Nhpq6sLj3QJn8RSejyUDE7AZrwzOLjsJHfvAZtv2OMVqN4Tu7zOWkhq8Se?=
 =?us-ascii?Q?wB9SJcuNYDrrhE0GFFzcIxt2cILpEobR4NM6wdSvJWOXPgS1CcQAjAjqcFdh?=
 =?us-ascii?Q?FM6l5si09+192nctVXeZooPYy87llNFuAcptXROZbs+ntQ8Wn+RFcVaICxhj?=
 =?us-ascii?Q?innYWhnOtOv+yJ1XGs/0eysMDzF63H+ujBWHlFxoFz/iSvWnE5eiqpH+Z7U?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d3825a9b-8a9f-484f-ecc9-08dd6fd55c37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2025 21:53:52.2289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7527

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Friday, March=
 21, 2025 1:11 PM
>=20
> On 3/12/2025 11:19 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> >
> > Update hypercall call sites to use the new hv_hvcall_*() functions
> > to set up hypercall arguments. Since these functions zero the
> > fixed portion of input memory, remove now redundant zero'ing of
> > input fields.
> >
> > hv_post_message() requires additional updates. The payload area is
> > treated as an array to avoid wasting cycles on zero'ing it and
> > then overwriting with memcpy(). To allow treatment as an array,
> > the corresponding payload[] field is updated to have zero size.
> >
> I'd prefer to leave the payload field as a fixed-sized array.
> Changing it to a flexible array makes it look like that input is
> for a variable-sized or rep hypercall, and it makes the surrounding
> code in hv_post_message() more complex and inscrutable as a result.
>=20
> I suggest leaving hv_post_message() alone, except for changing
> hyperv_pcpu_input_arg -> hyperv_pcpu_arg, and perhaps a comment
> explaining why hv_hvcall_input() isn't used there.
>=20
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> >  drivers/hv/hv.c           | 9 ++++++---
> >  drivers/hv/hv_balloon.c   | 4 ++--
> >  drivers/hv/hv_common.c    | 2 +-
> >  drivers/hv/hv_proc.c      | 8 ++++----
> >  drivers/hv/hyperv_vmbus.h | 2 +-
> >  5 files changed, 14 insertions(+), 11 deletions(-)
> >
> > diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> > index a38f84548bc2..e2dcbc816fc5 100644
> > --- a/drivers/hv/hv.c
> > +++ b/drivers/hv/hv.c
> > @@ -66,7 +66,8 @@ int hv_post_message(union hv_connection_id connection=
_id,
> >  	if (hv_isolation_type_tdx() && ms_hyperv.paravisor_present)
> >  		aligned_msg =3D this_cpu_ptr(hv_context.cpu_context)->post_msg_page;
> >  	else
> > -		aligned_msg =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +		hv_hvcall_in_array(&aligned_msg, sizeof(*aligned_msg),
> > +				   sizeof(aligned_msg->payload[0]));
> >
> >  	aligned_msg->connectionid =3D connection_id;
> >  	aligned_msg->reserved =3D 0;
> > @@ -80,8 +81,10 @@ int hv_post_message(union hv_connection_id connectio=
n_id,
> >  						  virt_to_phys(aligned_msg), 0);
> >  		else if (hv_isolation_type_snp())
> >  			status =3D hv_ghcb_hypercall(HVCALL_POST_MESSAGE,
> > -						   aligned_msg, NULL,
> > -						   sizeof(*aligned_msg));
> > +						   aligned_msg,
> > +						   NULL,
> > +						   struct_size(aligned_msg, payload,
> > +						   HV_MESSAGE_PAYLOAD_QWORD_COUNT));
>=20
> See my comment above, I'd prefer to leave this function mostly
> alone to maintain readability.

Let me try again to introduce hv_hvcall_*() without changing struct
hv_input_post_message. If that struct isn't changed, then the
hv_ghcb_hypercall() arguments don't have to change.

I'd like to reach a point where hyperv_input_arg isn't referenced in any
open coding -- it should be referenced only internally in the hv_call_*()
functions and where it is allocated and deallocated. The arguments to
hv_hvcall_in_array() will be a slightly more complicated to prevent zero'in=
g
the entire payload area, but I don't think readability alone is justificati=
on
for open-coding the use of hyperv_input_arg.

Other reviewers -- please chime in on whether the "no open coding" goal
should be kept. I can drop that goal if that's the way folks prefer.

>=20
> >  		else
> >  			status =3D HV_STATUS_INVALID_PARAMETER;
> >  	} else {
> > diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> > index fec2f18679e3..2def8b8794ee 100644
> > --- a/drivers/hv/hv_balloon.c
> > +++ b/drivers/hv/hv_balloon.c
> > @@ -1582,14 +1582,14 @@ static int hv_free_page_report(struct page_repo=
rting_dev_info *pr_dev_info,
> >  	WARN_ON_ONCE(nents > HV_MEMORY_HINT_MAX_GPA_PAGE_RANGES);
> >  	WARN_ON_ONCE(sgl->length < (HV_HYP_PAGE_SIZE << page_reporting_order)=
);
> >  	local_irq_save(flags);
> > -	hint =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +
> > +	hv_hvcall_in_array(&hint, sizeof(*hint), sizeof(hint->ranges[0]));
>=20
> We should ensure the returned batch size is large enough for
> "nents".

OK, right.  That test would replace the WARN_ON_ONCE() based on nents.

>=20
> >  	if (!hint) {
> >  		local_irq_restore(flags);
> >  		return -ENOSPC;
> >  	}
> >
> >  	hint->heat_type =3D HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
> > -	hint->reserved =3D 0;
> >  	for_each_sg(sgl, sg, nents, i) {
> >  		union hv_gpa_page_range *range;
> >
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 9804adb4cc56..a6b1cdfbc8d4 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -293,7 +293,7 @@ void __init hv_get_partition_id(void)
> >  	u64 status, pt_id;
> >
> >  	local_irq_save(flags);
> > -	output =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	hv_hvcall_inout(NULL, 0, &output, sizeof(*output));
> >  	status =3D hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, &output);
> >  	pt_id =3D output->partition_id;
> >  	local_irq_restore(flags);
> > diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> > index 2fae18e4f7d2..5c580ee1c23f 100644
> > --- a/drivers/hv/hv_proc.c
> > +++ b/drivers/hv/hv_proc.c
> > @@ -73,7 +73,8 @@ int hv_call_deposit_pages(int node, u64 partition_id,=
 u32 num_pages)
> >
> >  	local_irq_save(flags);
> >
> > -	input_page =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +	hv_hvcall_in_array(&input_page, sizeof(*input_page),
> > +			   sizeof(input_page->gpa_page_list[0]));
>=20
> We should ensure the returned batch size is large enough.

OK.

>=20
> >
> >  	input_page->partition_id =3D partition_id;
> >
> > @@ -124,9 +125,8 @@ int hv_call_add_logical_proc(int node, u32 lp_index=
, u32 apic_id)
> >  	do {
> >  		local_irq_save(flags);
> >
> > -		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> >  		/* We don't do anything with the output right now */
> > -		output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> > +		hv_hvcall_inout(&input, sizeof(*input), &output, sizeof(*output));
> >
> >  		input->lp_index =3D lp_index;
> >  		input->apic_id =3D apic_id;
> > @@ -167,7 +167,7 @@ int hv_call_create_vp(int node, u64 partition_id, u=
32 vp_index, u32 flags)
> >  	do {
> >  		local_irq_save(irq_flags);
> >
> > -		input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> > +		hv_hvcall_in(&input, sizeof(*input));
> >
> >  		input->partition_id =3D partition_id;
> >  		input->vp_index =3D vp_index;
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index 29780f3a7478..44b5e8330d9d 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -101,7 +101,7 @@ struct hv_input_post_message {
> >  	u32 reserved;
> >  	u32 message_type;
> >  	u32 payload_size;
> > -	u64 payload[HV_MESSAGE_PAYLOAD_QWORD_COUNT];
> > +	u64 payload[];
>=20
> See my comment above, I'd prefer to keep this how it is.
>=20
> >  };
> >
> >
>=20
> Thanks
> Nuno


