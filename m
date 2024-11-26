Return-Path: <linux-arch+bounces-9162-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25D639D918A
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 06:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D017F28884C
	for <lists+linux-arch@lfdr.de>; Tue, 26 Nov 2024 05:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72D6015575F;
	Tue, 26 Nov 2024 05:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="feC9fWYW"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11olkn2061.outbound.protection.outlook.com [40.92.18.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B237539A;
	Tue, 26 Nov 2024 05:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.18.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732600687; cv=fail; b=D9OGlUpYt1UIi1iWwVC7KDCaMSzZ3n9XckJOktZCllJXdZivZQHJxElIPUhOlI/+AkpilY8wGF1U8B0fRMykvzHvdIpV5Z0HoEOsadtEZf+RvjdA/suXuthXp5zIdVn/AnmH8RVr8CMTOONrxH04pTRMJ6/38jtCmA1EPPSIti8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732600687; c=relaxed/simple;
	bh=vEJQD7gnRK0X6oMIojf0rEZryTWP7uC2vA40v45Qroo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MH0MQK5K/mwmzpCcb3GaesLukiTnCu8SlZHNzRNTbTHpSLM16+ORON1mgNb5NxqguAUMXPmgBah4TEzVSuX45sAEX1TnlmpWwn8JftI15iBNm8rj02O/dr2rE2M/+b7p1QFw8t8lLNCYJrGMRNTBjAB2sggXqwASY69eQhn9n2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=feC9fWYW; arc=fail smtp.client-ip=40.92.18.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0vaj0UdhIvbzRTIWjBXRaOS/rSbVeY1DjYXoKhSMLeC9oMFOaWpVHZEVNTXGGEnb7tJb0tZnkBpjlwezKU6B0BDpSWx2/Odhn8AAgyc74oRjnVe9TQVwNS5gzxo5jDAIP5rH6n+D/eWA1fL/fuk+KY3wTMBw9REuThcOnQMFiFWtr9G4YD7nm52ifYCuFXZ2wNBYkNPFwDHRvH2qsSXdTZJ2XDhWwwP7kGgIIuMA1AJPLcfCbhv3cSwffFK9bUlyesw1uN0ODYY0UTKsXksvLUu1O6F9rKHL6pfmw0b20KssvrdxY5gaPM2p+moWd4eBtMho3BOFivYXS7ALL0uIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vEJQD7gnRK0X6oMIojf0rEZryTWP7uC2vA40v45Qroo=;
 b=rq+naTg6+fHS7b+Y6xkYkxmit9rp6MbsV3Exz+XivdqRfEB14FHIhCpXtI7iVOxbOwGwAYmJNtWS81/bau71M7Q2FmpIO9nhG1lp1BX0aTqAhF7+UKFgYhGM/ncqOAd+5Ni1y1fSMZXMBjpMLnF/ANoBGHScbBpG48RV+l1vkYNJY+xTiCMu+Wwd0b7yOG6tbM2mlRFtmP3e+2n91JcQWJk0E3HrsHkfbENaZERuro736mpRsAa3tVmTl1pVTlyJyDG0bZ+O2Xg5W8GEitKEJ1O800E5aQHyCqLtD6XCniUDtv/87OpjoFf7iPndLEzZcXjmeayPpW7acWdPHbqtxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vEJQD7gnRK0X6oMIojf0rEZryTWP7uC2vA40v45Qroo=;
 b=feC9fWYWkseCXCM5P3yM5fSJ2mDP2vL3PPNMOj7gxCwSlDaNG7y66oSLWfUaorc9eLLaUHSjcpzChraBcrJ8azcxlGhgAuPxBlafNXL2xe6R3Tdrxp8AxTXQrv9/zkY/ciqRjBzj05ShTF9ILg4Sig5erG0fag9Cn7BEtBJlcY/Uj987dG+FC+T6LLvcuc9/OfpTCVzAbhwpIEUez75EmeajmDymeay02V4Td1mydJIF101owiSQA3TIZUnyHGjpaor9TFE+IINtwP/hJ7OAbKd4x2RUEXowf/d+dtdGvpvRXaVsYFzxGEnczbGT62/XBjIkpxd49Iqh2Y5wOZUDMg==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by PH7PR02MB10038.namprd02.prod.outlook.com (2603:10b6:510:2ec::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Tue, 26 Nov
 2024 05:57:56 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%7]) with mapi id 15.20.8182.018; Tue, 26 Nov 2024
 05:57:56 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "catalin.marinas@arm.com"
	<catalin.marinas@arm.com>, "will@kernel.org" <will@kernel.org>,
	"luto@kernel.org" <luto@kernel.org>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"seanjc@google.com" <seanjc@google.com>, "pbonzini@redhat.com"
	<pbonzini@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>,
	"daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "joro@8bytes.org"
	<joro@8bytes.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"arnd@arndb.de" <arnd@arndb.de>, "sgarzare@redhat.com" <sgarzare@redhat.com>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"skinsburskii@linux.microsoft.com" <skinsburskii@linux.microsoft.com>,
	"mukeshrathor@microsoft.com" <mukeshrathor@microsoft.com>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "ssengar@linux.microsoft.com"
	<ssengar@linux.microsoft.com>, "apais@linux.microsoft.com"
	<apais@linux.microsoft.com>, "eahariha@linux.microsoft.com"
	<eahariha@linux.microsoft.com>, "horms@kernel.org" <horms@kernel.org>
Subject: RE: [PATCH v3 3/5] hyperv: Add new Hyper-V headers in include/hyperv
Thread-Topic: [PATCH v3 3/5] hyperv: Add new Hyper-V headers in include/hyperv
Thread-Index: AQHbP5E7/ROxYXFz4E+K2Z49rTwvKbLJELyw
Date: Tue, 26 Nov 2024 05:57:56 +0000
Message-ID:
 <SN6PR02MB415765AAE0196AD2147DFAECD42F2@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1732577084-2122-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1732577084-2122-4-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1732577084-2122-4-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|PH7PR02MB10038:EE_
x-ms-office365-filtering-correlation-id: f582bbbd-5b5e-4c8a-bf0c-08dd0ddf461d
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|19110799003|8060799006|461199028|15080799006|3412199025|440099028|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mfeu8OCbSE1Y1cQyBAF6Vx29Ycq8+7+5BzQo/JK4JqA9556D3E0HNea0YvE1?=
 =?us-ascii?Q?nBLE1xzyC8YC2lSXtO7d5cTKPniWqMkc5RsB5eGVUgyNYuEBXqHBCxn1PZqg?=
 =?us-ascii?Q?kGuPXb0OpMMmuUdD/zYKnQmYeMYo4wFwKeK7zVoBmNECakCclE3QHIlAbVqM?=
 =?us-ascii?Q?wLF5FVktnJ2Mk+L52jP0ZvZ1tf0QFYeFk1nYlkIOV3EybzyJgBSu/R3u1Zg6?=
 =?us-ascii?Q?kFXcqZfl6cVWySBOuvHrp+vS6r7o+iUzFDsN8E4N5j/Bnckhu/iLTHEwTPm8?=
 =?us-ascii?Q?hKdiJQf1Xar2iWE2pCd4ueDJ2uYlypw1opEChLIVw70sC27eGJXGyyqeUQDt?=
 =?us-ascii?Q?v/Pn62ERWd0/mMeZGKpsSpeBJgCR/I5ksUKDA1wb7ef3zQSa5Bvp1XtEj7Ek?=
 =?us-ascii?Q?HXBJXN0Ak1NmzXDRhvxzZSRT8lZ9fXYm9ISc3zh72qNQJKkgjLnuviVwTyG3?=
 =?us-ascii?Q?JMEvTXWAzRthLRCB96jfZfQjfS275DgqwF1rncvSikhFNBj0aaDQVk1vYahh?=
 =?us-ascii?Q?6D51oPouCwbg6ahQz52ARgA0POmy+wb+23OBk8HG4doQjL8rUmolmDvjxhbV?=
 =?us-ascii?Q?qMNRC0EcSP2X1Vz4F2Bcf+rk7M5jNv/JJmd4LpFJTgwZmOeuyHGpHoKjYrFP?=
 =?us-ascii?Q?6XLvUK3ZOYdPfU0J2t5oonG8ppEx+a4ogxWdxxOSrvFKeRd9nAgpmr3FVpbL?=
 =?us-ascii?Q?8UAmgAkQ/BT+O2YPuKzkhugpy3MOBym14V872FoT4MBA9eJtOIGLdWrDWupX?=
 =?us-ascii?Q?UW1YnmIzYCA+XvDyNUxklDSRhH/V14lDcs/pBewnjoaQ/jNPsrMxUGLordYS?=
 =?us-ascii?Q?FxYrEGxFjbgAb8lA6HnHBqcFuzoXoSUhnvnW4sfmXDE3SPPCBfIOZgu09Fln?=
 =?us-ascii?Q?JONOoBcAYYQ86A76CJoFC2D7CKNvBm7dwApwJBWECzgIR87dCXWuxruMIqAV?=
 =?us-ascii?Q?/LaVEDPz1QQbceQ1X7kk1o9xWMHrRpENFtGlU8v9qnvZsFrzvwjyMLCmcDih?=
 =?us-ascii?Q?Es+/74j/5U54LivMxHgNbtvV5g=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BCSpfi8G3HJXusTIn/mJcx9aMp3NURESwks5sBIub2TdzIwfX18mU9n5c6pG?=
 =?us-ascii?Q?ynNwXNYzAXiBQuQht9xAQcWC89aw9p6T4wBSa0Mt4kQ5/rhvqE6OXZGIDAnu?=
 =?us-ascii?Q?2TNF24sXlpp8zgbeVaCGdchHZEyvCHyi9toH0jr779Yxp2MAu44234fTL354?=
 =?us-ascii?Q?hxxJCG3zXxugpsk+JHZLthq1b83O8wKJzXrjSceUcU6oVj0bhlJ+vT8ZaY41?=
 =?us-ascii?Q?0HAvAmaUU2Tqg01QZl3Kpw46d1P170UhZMEuTNhISzeAfNJJT1LZoHioOdPZ?=
 =?us-ascii?Q?gAMp9zsCE786al9t+b/OKaUtqg/y4aUlHrIWYCZYa0T0qF6vkY/YJeKbHix+?=
 =?us-ascii?Q?iIgN80iO+P5YluaZu2vGe+5t6EBMv3znmMJK7K1mC8LR99Hfuy8AiSl9XMmu?=
 =?us-ascii?Q?jA5UAnaE5waOQbwyKt8PNjYlaDorrtqW0dW+Sx8aVXeFzBzDA07Y5ukwMzPV?=
 =?us-ascii?Q?HpOPavqRD37ItTpUrXFePSVCXwM6/JVO4WwrOVwfXqZQNwvflQsEAm7AqeUw?=
 =?us-ascii?Q?A5Rkyr+LT1E7kv29ukIexGvh1uTZDG1V6om+VIcGV0WVjjFokUJnKWPuNKvV?=
 =?us-ascii?Q?oPolq1n2nT1vh04zaEuNbZjnZddquyRlg+AECXiUS9UDi1pJRJAgPmRAB3+K?=
 =?us-ascii?Q?R0gwM0aDtN2JTWHqR4pbuDPF8pjHsB24IYnTUayxwDIb3b3e+YEm6KZCv1A5?=
 =?us-ascii?Q?cQPNYFeYF9Xg4p5aMXBCE5pp4IXdK34BRTPXKiEPOBODR2WEJxzcaN0B6X8q?=
 =?us-ascii?Q?1PP3K7ugx67i+n8alPLX+e2vHIFcXtkExyA2NKNmjcIBVh3yNl/ucgVSL+s1?=
 =?us-ascii?Q?OOLq1f538rUrAaAQRy+EpShTJ6CCUhij+w9f0YrSaGNi+Abz/7wFwUZFg3iV?=
 =?us-ascii?Q?M48mRlwiRIYdrpYyA8LX2yDXc2S6pyeXhcmO76aguPHyIM40VPKhjCeujH+c?=
 =?us-ascii?Q?VJGrhmQtR1kbDP2+BUNUYMF222PE3Ze3gixWFHUGYX0ifZPcRHVbnEBqBNyl?=
 =?us-ascii?Q?nndeI5eBgy2fMLOiqFwBVNY7kDsG7OdkQ6FaHc//C/pU2m+StRHMJvrPj5MA?=
 =?us-ascii?Q?GOqcXpji5Lycpe0gA2H6qPEyXlc6e1xKTacx8UbJ9Bh+iV9vY5AtkN6X3vX8?=
 =?us-ascii?Q?ZMOQYcbCFIV1bvCjOoQfv5M+VPjKo/zl3wcNWl3I+sK5iNstAeDyHg/kCYQ3?=
 =?us-ascii?Q?FU+6mvFNgZdsE7TLw83yRZ2+N+s0V7nA63ptz2olbUpPwGsuVplrwldy/PQ?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f582bbbd-5b5e-4c8a-bf0c-08dd0ddf461d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2024 05:57:56.1365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR02MB10038

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Monday, Novem=
ber 25, 2024 3:25 PM
>=20
> These headers contain definitions for regular Hyper-V guests (as in
> hyperv-tlfs.h), as well as interfaces for more privileged guests like
> the root partition (aka Dom0).
>=20
> These files are derived from headers exported from Hyper-V, rather than
> being derived from the TLFS document. (Although, to preserve
> compatibility with existing Linux code, some definitions are copied
> directly from hyperv-tlfs.h too).
>=20
> The new files follow a naming convention according to their original
> use:
> - hdk "host development kit"
> - gdk "guest development kit"
> With postfix "_mini" implying userspace-only headers, and "_ext" for
> extended hypercalls.
>=20
> The use of multiple files and their original names is primarily to
> keep the provenance of exactly where they came from in Hyper-V
> code, which is helpful for manual maintenance and extension
> of these definitions. Microsoft maintainers importing new definitions
> should take care to put them in the right file. However, Linux kernel
> code that uses any of the definitions need not be aware of the multiple
> files or assign any meaning to the new names. Linux kernel code should
> always just include hvhdk.h
>=20
> Note the new headers contain both arm64 and x86_64 definitions. Some are
> guarded by #ifdefs, and some are instead prefixed with the architecture,
> e.g. hv_x64_*. These conventions are kept from Hyper-V code as another
> tactic to simplify the process of importing and maintaining the
> definitions, rather than splitting them up into their own files in
> arch/x86/ and arch/arm64/.
>=20
> These headers are a step toward importing headers directly from Hyper-V
> in the future, similar to Xen public files in include/xen/interface/.
>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

