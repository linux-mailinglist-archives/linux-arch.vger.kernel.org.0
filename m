Return-Path: <linux-arch+bounces-5053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D853915736
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 21:33:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D517A282AA3
	for <lists+linux-arch@lfdr.de>; Mon, 24 Jun 2024 19:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735621A00EF;
	Mon, 24 Jun 2024 19:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="r8MrBfGg"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04olkn2046.outbound.protection.outlook.com [40.92.47.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A51A019EED7;
	Mon, 24 Jun 2024 19:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.47.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719257574; cv=fail; b=ivdzc9crSZMHperPCtCbg55Tr0rm5KjD2//suZhySTrsF6k80/nqJu/Uk8CA1qbcRPMjC5lhVNn/lq1OAaW2xcMp8zRcxEWZmeWb1OX900lMtWkqXGpIiqsSOVnt0wsZNvVS79S27bZ5TsjHTMI7TP/MA6ikWIa8FOI8vRdkblE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719257574; c=relaxed/simple;
	bh=cR3laERIgibcbJbx43s8xlPPYfGc2CMJuCzV7jX0hF0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tyE5frEfmamDZyURJw0YCYkiu9c8AqmcZh8tOQUBm+PrZgihzi6IQF8sHlgM20/Z0o6OL9gATYFTJZndc3UWch3BT0x6qNjpuU0DT4wHx4/jOJh6yDesNfZ5LmZtz2ra6+DulS8Mwvfm2V3sP7EglbE24AkZ/KnKOOMYb7CuKzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=r8MrBfGg; arc=fail smtp.client-ip=40.92.47.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4j3SfQPdtToZVk1MsIFkVFwjYXuIQc4VcdSLLNGL3OgxsFUvBoI2WJoj70bpYnP16n6Bf1CB2zi75Axgob0clNHS59KdJuVhWkM4ONq227p8JZhQb707eabK+HV/acrasz1e1SXcL2Ufeo2zIv0MZZHZ3iSmPeeDyJw3wy2oz0IKXCQpOKuSoz+1s4tCaBSxb75quSNjcHjrfbT9oEYsBYAzbd2ejuNzcSt4k0OgqahaRqk0EKKZTkC8hAIkf3dCIeqQD9diltZLJKUu7KYqpT9Lzt13qal40IOqVzi4rWlgBlSCqbn7uvcwCHGFPsDu8FUy/j+4VTVAJ7AVmulnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=343wCpY7Ml8F0JyXXzq0gZjxl2SkDmHg4lssT07wzWg=;
 b=cpk10wUV7Cs796nT+ZE5WIeznegBjgV8/ioLMYxW7GOerTCt9QpI1FkFezbX5kPv645qCFv95BaADU5ArFa9PM0EtzYfT9+vECxD3sPGMZ9pZpCMWXmTY69Q8gq1auMO5Haxe4g9n3Dd+fFEcVfyTAm+DvEYExBL65K14qgTA9lMsDvZKIDzAlNXVDpwcw4OrpgguYfdQgsbFJ4RZe1OmhkLoHZSEWktvgFKHILjrMz+g9HcNMldAq2yaXHwOJ0QaiG5MKCZtTc+wy/2V9DrzwPQGdreVg4/jeQmNYLDQmsYlXbTygEW0kgbF0g1kqE0NtqKguRPD/gX0S55oa0mLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=343wCpY7Ml8F0JyXXzq0gZjxl2SkDmHg4lssT07wzWg=;
 b=r8MrBfGgmmCXg2JRMpeJNc30IKggzPHqbGTIPr85XJ+JWh+QyPui2V0suN2bKqw1SbYWldAffrNDEwCMOVN2YPVAk4T5+a6SR80smclFGN9J1iFyNuO4u1KJjFtug6srh1SsJOHWAUtDh1lSNNQrLaJZiCeSUnt89UzLb2ZrMttQIpo8Az9qW76/+mFyUlpcvS0iOLqU/tX0KhVoOU+D4kCu9kFy9sr5JASkJH+qMOfvfc458MixbEreCxfC6R0fGHz9KYF9HHXAk4dnKuTb5E+xBla9N21Uy+lLTZkvYbx0BkOrXdti9LloELL4KiuCD51d2LOSBq6Wsrr3q0u19A==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BN0PR02MB8176.namprd02.prod.outlook.com (2603:10b6:408:16e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.29; Mon, 24 Jun
 2024 19:32:48 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%2]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 19:32:48 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Boqun Feng <boqun.feng@gmail.com>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "James.Bottomley@hansenpartnership.com"
	<James.Bottomley@hansenpartnership.com>, "martin.petersen@oracle.com"
	<martin.petersen@oracle.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>, "maz@kernel.org"
	<maz@kernel.org>, "den@valinux.co.jp" <den@valinux.co.jp>,
	"jgowans@amazon.com" <jgowans@amazon.com>, "dawei.li@shingroup.cn"
	<dawei.li@shingroup.cn>
Subject: RE: [RFC 11/12] Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish
 when offlining CPUs
Thread-Topic: [RFC 11/12] Drivers: hv: vmbus: Wait for MODIFYCHANNEL to finish
 when offlining CPUs
Thread-Index: AQHatj4U79XXOj/nbky7uomRh5JwSrHXUtwAgAAY3UA=
Date: Mon, 24 Jun 2024 19:32:48 +0000
Message-ID:
 <SN6PR02MB4157B5E2E26514A07CEFFE80D4D42@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240604050940.859909-1-mhklinux@outlook.com>
 <20240604050940.859909-12-mhklinux@outlook.com>
 <ZnmzBi2y1eq269QA@boqun-archlinux>
In-Reply-To: <ZnmzBi2y1eq269QA@boqun-archlinux>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-tmn: [yLImR05CBFf4f1MjudD52CcCdcdJXsVL]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BN0PR02MB8176:EE_
x-ms-office365-filtering-correlation-id: ac8c9d8f-54be-4247-6f37-08dc94846e04
x-microsoft-antispam:
 BCL:0;ARA:14566002|461199025|3412199022|440099025|102099029;
x-microsoft-antispam-message-info:
 ytubMJjebuBFXNn7HMa4wrDP4Y22VaKDilJCwyoc4T21bXNoqshEnxz5whOD0Q4ipZIAdymSG6GOb9ocHPHfLoZ+oVP+1NBKWN+pisyVs/i5aZxaq90foO5LiWt5RrjGviz7mo8xIC3eaDPqpt/cEF2Xyw5zWACbHkaQtr5U/A9hAeuy06+/KA2gtKit/d/0uQseezsaOj/Rb7RLNgdT5+JpXDfN0yxkz32mZoggmJwoQfZTMcEXzbFSojHyJvy70vmP9AmegK6SNufIMqCOWCea90k2IkW1lrDy+i5ycx83/eQaKt96sr1pPKVu0tk6rLxJdVEUEA1Na4vGHgXbC+67xJ6lwJ04VZ2sqLAX/MZHwKsBYo/bgTpd47EibVjsw2v8aFqzgOXtiprq0OoCTaMGMSclN31tW9BlVBJM7EeRIyYuUgTmjnJO/RbLKlVh0qyPjIGDWGhLk6C5eUzo9ox+a8Z1XuoGnfVsbRuanXv69oFUeAO4ruErHqzEWyZvsc8vlar1K6EMLInWCsuDRCwadFIbUitISH3a0DQ9uuog8TS6L37Yo5pxS8nDuy6M
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?vHCgtmKgE/istcyFDoe2c6mOQ8/skFkI0OgKv5StuQyTXjKN63dfDjcC/HdN?=
 =?us-ascii?Q?GnBToFu7Y7MA5J0nUAV0qFXTP/RM2KNBvH5a0I544Zv2JpnQUwcl1Xsv1qi/?=
 =?us-ascii?Q?yG+W3B/9cEreP6dZ35qu6dFaihUwo4k9ouHear1l0FijiL4nCXbQLcPpSzNz?=
 =?us-ascii?Q?cmd3z/ToCHmv1GtmDRwVppHkBFYp3VJO+RYSLq/trxZz9tPcHqs/bJq/OYZM?=
 =?us-ascii?Q?ORdHRr+MRklcSBZObWSOUcCNN4wFyeADsXXsEJrYNCc+cT3TbvG7v8EKE0vt?=
 =?us-ascii?Q?glfZKKlCmOCfBWdvhqc8jUegLOzCtUoIQze6pE4mdREOeJgUic3klRcIpVjY?=
 =?us-ascii?Q?QecfvyIu3HkYJ2wyUNFXbry0BlFt7OSBErL2yF4QCpN2PrWc1IlzrZ25LYmx?=
 =?us-ascii?Q?TLVvFCCiri54eysHJhFSVazej86n7nYNqo127it+NyFiIUDAKXRTiRr8MHEg?=
 =?us-ascii?Q?Z2zfBrqFjwVFfFf9H/KkfoSEbY+uxyu+xdHby+2n9Ps+wUlShd45o3ZdVUsY?=
 =?us-ascii?Q?6nMs+LQ1GOcFqrkIc6J1t/encx2qi3CaeKEwjvoTiatrEufwjR01qYKMmJkv?=
 =?us-ascii?Q?8gQc//L1qTNGHlNncGHrN/+y0DPheEFr0fcsLi7qc8FjsyAWHg4t2SDHHsJE?=
 =?us-ascii?Q?d26c6kqXntuiC5VRacs2Z08/pGNXX579Fn9zYNJ9PQpHqUZD/hFQHf2hBFOm?=
 =?us-ascii?Q?0qNvekGb0qyTH3b2kWDLn9hUvdZWOdNB4ocSPrOdkeOHE83ADl62q41dV9S8?=
 =?us-ascii?Q?P0cVwdclnajSuVBx0233kGUrwHAcbcpViS0m/kVIJ+vvIeURv8bT3uXhY/kt?=
 =?us-ascii?Q?qtrkCc7vSJHNvGO8j6vXuS/dohH0B40SfUNGWTeXb/ynEB6hsKo5HqED37ba?=
 =?us-ascii?Q?kqoHWOhKW+zwiS05QqxE1eMoX4N+Eh3KJ1nzoLSCLMUoDAN2qA1VQljeDLST?=
 =?us-ascii?Q?3uR+iwf4HDdEAVI5JIdvOgUwrVutT5UaxwALhwgIUvgQgA+32jglwbzKGjOM?=
 =?us-ascii?Q?FeD9eK92jd00X9tf95JNB7vb8qA6X9sh1reJ9i66zHC8PS0bhUcG9FuP7LRR?=
 =?us-ascii?Q?1/1QC29LkEEjASD/yl2+vHnuBg5rRRtEenQ1WakCPW70amGDyn0UG4/WtmN4?=
 =?us-ascii?Q?tnj4cW7b9DdX75OOigL2knaBy9Ij2m1iKnF77s1KEbant3ow2gnqjvn9tsqf?=
 =?us-ascii?Q?dpqulzGalCB668w6+bLIutP2qtVNiNQ7UxVXh/h14woYl0TSHfz2HB8+SrQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ac8c9d8f-54be-4247-6f37-08dc94846e04
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2024 19:32:48.1859
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR02MB8176

From: Boqun Feng <boqun.feng@gmail.com> Sent: Monday, June 24, 2024 10:55 A=
M
>=20
> Hi Michael,
>=20
> On Mon, Jun 03, 2024 at 10:09:39PM -0700, mhkelley58@gmail.com wrote:
> [...]
> > diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> > index bf35bb40c55e..571b2955b38e 100644
> > --- a/drivers/hv/hyperv_vmbus.h
> > +++ b/drivers/hv/hyperv_vmbus.h
> > @@ -264,6 +264,14 @@ struct vmbus_connection {
> >  	struct irq_domain *vmbus_irq_domain;
> >  	struct irq_chip	vmbus_irq_chip;
> >
> > +	/*
> > +	 * VM-wide counts of MODIFYCHANNEL messages sent and completed.
> > +	 * Used when taking a CPU offline to make sure the relevant
> > +	 * MODIFYCHANNEL messages have been completed.
> > +	 */
> > +	u64 modchan_sent;
> > +	u64 modchan_completed;
> > +
>=20
> Looks to me, we can just use atomic64_t here: modifying channels is far
> from hotpath, so the cost of atomic increment is not a big issue, and we
> avoid possible data races now and in the future.
>=20
> Thoughts?

At one point in the development, I did have these as atomic64_t.
And I agree that the usage is pretty infrequent, so the atomic costs
aren't an issue. But both fields are already safe. modchan_sent
is covered by vmbus_connection.set_affinity_lock as held in
vmbus_irq_set_affinity(). And modchan_completed is OK because
it is only ever incremented by code running on VMBUS_CONNECT_CPU,
per the comment in vmbus_onmodifychannel_response().

Converting to atomic64_t wouldn't hurt anything, and arguably
would provide additional robustness, but it just didn't seem
necessary.

Michael

