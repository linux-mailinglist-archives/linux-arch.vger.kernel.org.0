Return-Path: <linux-arch+bounces-8968-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93B7B9C376B
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 05:15:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5454528207A
	for <lists+linux-arch@lfdr.de>; Mon, 11 Nov 2024 04:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD28C155303;
	Mon, 11 Nov 2024 04:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AGZxOp49"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012062.outbound.protection.outlook.com [52.103.2.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA6E14D2B9;
	Mon, 11 Nov 2024 04:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731298432; cv=fail; b=rKZeGXj7UoQ3fOGTA+pe90ysjFQ3yFiOFmtshyOlz6ZGjtBVhoB7R2nEevwzsEMdMLduHaPnVrI8j8alfUkdXjwKIBUoTyd4stN1XKQFb6BBumMEHgQsBD9ZQdomwfu3H3/9Om4yWYcXXnNkyD5drfWbi/3jMvrGYa8/aSJsJpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731298432; c=relaxed/simple;
	bh=oPYeVTTQYES6leUSbTbpxv5AX1kmIr4sBpd2dvGX21E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeM1x1yCoHfhlyaW91I4Io2CnAsHjgWBxyv/UiKN7vaSHNR+YuKdZglrf5f26lu/CPVELrwEN7BDqvJLYvMuU/XtXq/umqM2/WBwjpXnxMt98sTD8OfB6an2Zl9XUlzrsC9XZ201zQJLiOt1GdQFMIF+9NV9T9YmvYsUrWaypKk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AGZxOp49; arc=fail smtp.client-ip=52.103.2.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WM71XJdtQdwwlaCRm1ok1VFfj8Q11X38OlCdpvOYNTkUYhquZL7q73Dub1XhbrIHjzd4SodLjxOP90Hd8/vgefLAFCTQSUHAoyoTafCIO8waf6vuPOF+jNEyc7vOD8bBplNaPoEhlmDfK1uNJVQQen3KsX3qFTiE9pStaOdRdffri1Dsb15Eu0AcbIpfXID5DtHmeea6wQ0PwHJDeNAy9uyXkYHCOpOzdoYnuzRHQV9w/OE6V8IBZbH3f3Wtz9RbYbxR7oOY5c5jteHe6Juyj2wH/7wQ1D7tFD9rwYmgjxJ3AvkXDy+07VD9tbIK6c6iVM0igJweCxS8quIsz0ecZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8lHU+BYrgfnUDDcMQ9EBOkZu2BIO0ilQgkXGnY1OAI=;
 b=p0nnjUKW889AshIPKm1fAQmABoo++iHY0DtAnnOw0AA5xSn6u5RFJAPyqlfuXA5FY6ZcuO0NUpPFhsLfGYQ1s34FiOD5zRHazOLiiUmFdoeJuNhmOi3nqcUJERuZC/ihHjm+lZCyEZyuZ0tOGCFoU4Q3H2AoyWfwFRJijpSaIrtLyr6o272WA4ock8L/oKylz0xJYNlL9dxm5z0td902C/aaJYfIGGN9YdTn+hj8jBtZOisHXx4aa1ZqhqPSelO9q9YyxHQgFST3dWuVDVPV46mnosSkkH46LXBZcNPA6lDPpKc941Pr7zjX/NIEwS9ijwqIWgeslXJBlWWPDMmakA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8lHU+BYrgfnUDDcMQ9EBOkZu2BIO0ilQgkXGnY1OAI=;
 b=AGZxOp493jaqocZIQk3LnTPN8gZNNtlCOf6mj9HdvhVBlIXoAubPzQX7tzjCQQSGq8EzFktQZLnqVLwFeA3NCXdnlk3/9DRqkmfQL2FXY6bIQuZhpoyC30ADMWHT6NrBwfKJilnhygTTZKPpKMjcTXWrh+FdQfeu5VtarM1jd9ZnZpXf13v113mCRyulnCyo9yC3vS17PbvcBM416wt9AHsJTNm9Mdw+aRR666bVy5Ggi8usl/H4BmD0PAV/IJklLUVDa0rZIGj+mMrXh7U8I82tQnEhnlJ5yIVRC91zE+1nbdG9zx+lL5PlGvwYb1kz0hh3bmFRCFQQOPj+slrw4w==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by DM4PR02MB8958.namprd02.prod.outlook.com (2603:10b6:8:bf::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8137.20; Mon, 11 Nov 2024 04:13:47 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%5]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 04:13:47 +0000
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
	<apais@linux.microsoft.com>
Subject: RE: [PATCH v2 4/4] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
Thread-Topic: [PATCH v2 4/4] hyperv: Switch from hyperv-tlfs.h to
 hyperv/hvhdk.h
Thread-Index: AQHbMWTxGjBzpDHZ/kaAtNrAPYWf6LKvtKFg
Date: Mon, 11 Nov 2024 04:13:47 +0000
Message-ID:
 <BN7PR02MB4148513F8ABA50392E11C616D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
In-Reply-To:
 <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|DM4PR02MB8958:EE_
x-ms-office365-filtering-correlation-id: 63675e99-47a5-45b7-727d-08dd02073d98
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|461199028|8062599003|15080799006|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?go16PYxg6orV5DyMLt58XJ5xQIjOgeqSwrPFl55IUUzB0WiTkNNCN7xZ69r/?=
 =?us-ascii?Q?bpvDqU6lL7HJjvZwSaMqmMCnLUHTSKtpToNOY/ptY62dsYqmZ6UMo4BC2vJI?=
 =?us-ascii?Q?7SKuNs7TS13mMi/RvIZbofX+AV6yJbfyREkLopSk58vQ1LAwbG2ElA5ErV6S?=
 =?us-ascii?Q?4OZAXZzP5p2SoSP0kZTrNJx9KCkZZfIUBjUOwO46ytiEZPBBb2yJB0Om9dbw?=
 =?us-ascii?Q?5YzgXEPWSn5nXqi0lBkTMpCIIUpLL69ke3cJGaNB7SJfZjIHUU2x57vIsK6z?=
 =?us-ascii?Q?bWd/4wboWCNlbmLmUxNu3EY4GW2Guc7vVWqfZJTdjls0fZKbtp6Q1SO2urEl?=
 =?us-ascii?Q?XeM4rFd4pL3uWpcVWMIfWoUpTtQhgdHGd18sakOCSsymdjkuOelWLReIPrRj?=
 =?us-ascii?Q?GHO03nlQgQwQjTpbtCtDclzZSq4zpXtLitIGJvcFyVl1OI/01eno1QEu5lyG?=
 =?us-ascii?Q?DtyQBWjrkFfeTYwmaP+eC3/Pi3qSAe8I9KhmzbhLZdScYYQ1v+mtrk44bg6j?=
 =?us-ascii?Q?hbH2v6kghpOdH/5qMEFKtCXm7mrcdKSqiZ6Ca4MzWG2L3XNbUGBYZB2uz2+h?=
 =?us-ascii?Q?+O1O1U8cy1gQSbMgbT4gx6KtSvdcotqCL5Fm0SOKtSsqkedsqlDpLlSU0W3+?=
 =?us-ascii?Q?8Id6lKwHu++BBL3hVWCjkw59fvpSXVi6HEVwrrc5x70Mar1BBzOxF+//QGSJ?=
 =?us-ascii?Q?i6hu9X6qVQ1vz3CUke8JmnStKJ2wY6WndiDPyXUf21QjiWCqYCbvNC3lU3TH?=
 =?us-ascii?Q?/HplpyjJlFR7tiOr5PqmcB7WED9/YdFneA1v8faVBpTlO3Ax3SL3wbOepnbG?=
 =?us-ascii?Q?xOAuT606cJU7WZkiWlMfkDDaBLtQQrrK/xFHAAU+Rv0rxtKyLf2XhQLRzd0j?=
 =?us-ascii?Q?MUJQszOR6XnDnVBhuJXCaLwAP7Kc+R4Ie8A6NSs2wbLIcbeaf2E0ck0wwIhL?=
 =?us-ascii?Q?ttSYs3LcOnMsVzdxi2SmmFU4Xs3r5QvmZ6+SpKrPyiYxvGRyF+KXXdPhVq7c?=
 =?us-ascii?Q?m37E8AP6fDvZkHVNs8lIlbnc6A=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?NCB7yF9XWfUoqu9aL9MJE25ob6dR2G6cyVKRytr+KnuUXZfr2lpB0zbgGMvX?=
 =?us-ascii?Q?l33tytLH80Dm7bI/adc0kS/xdQLfDx2aSrj8bxoMOqk0nJjXpiIC0h9+9x9K?=
 =?us-ascii?Q?6gyOxMznbAIjfy/RlzghjUaLmCCT367rZXAQ9cuAq/HiRqbd3fq4l8ku6S9H?=
 =?us-ascii?Q?/oxlVCmTGBNR5F0yvzrue2st46iO8k+922x+rRNw+8BfdX1FrilObTdpqdNL?=
 =?us-ascii?Q?tukosrYAyfL7ellJDaZP22bKxurNvz8Ma/9CYeSMiG+AnA5uO30pszXefMWM?=
 =?us-ascii?Q?7ZHZ+Kr2kuGUjYPYds8QUaVexZgJtKmvCneEVNxT3UBIjA+2VjeHHNVm7Vcp?=
 =?us-ascii?Q?+N50mDf2OVVYSAJHXl4lt23mr3bnAK5tsfN2fyVCMf4/Po4KhlNrRfXyjemF?=
 =?us-ascii?Q?l1OX3e+7S90hoRWdCvmzChLATEwHYYgJfma8M4xVmsQROyjGWXf6W8hFFC7I?=
 =?us-ascii?Q?gYEzB78AI4aZzqdET04fRJ2lUnhGdnDDwHsHZcxxvtVBeSNZAem8eR7qHvXd?=
 =?us-ascii?Q?4NTYIKEXtmij+sJeLbSigMTH7cUo0pl+fXKaNk2Lv9HNYC24tWlaLUMFHisJ?=
 =?us-ascii?Q?Th1t7Q+K8KSL5+0SltUFEHvMfXvxgPM/gsAyTNfKLik0xlGkmPPUShjVKkDc?=
 =?us-ascii?Q?t9I0ZqJwsJvCoyD2Wvb6V7v23vaVIv9qoSb2mNM8askIh5MCPYSPQAxhY96O?=
 =?us-ascii?Q?+S9jg0BEjsHqVIbEZT/yMADeX9YWEi4HI+T1azMyRYT0KEFpnvaGV8SD6IQa?=
 =?us-ascii?Q?5HZG3ogUPCrV1V3/GdQeqVEt7AD+YA2nGOTVll9pCL/Y+Ij2zwc0Nw2EviT6?=
 =?us-ascii?Q?FEiOEWAseSUKnwD7dy0dxOixc9rPD8F5/f8VQTFzw8d+AgB9OvGOURbzteFW?=
 =?us-ascii?Q?lz0QTOEhzKHHpq3v+X/fxPjVobfaY6bItvGwhYw0mM+NN32HtLSCCTFJxJI5?=
 =?us-ascii?Q?iRjc956kORCM9z/lQdgbZ5KuLYCW74j8ZToWpUYqkyEtAeb1ZnsbWDuIt3D+?=
 =?us-ascii?Q?e2QHqiMWoPMXd6uyYFb/sBBE3niKXNql/sgajLSqqBtjYXaAGHjtfaXnEAa/?=
 =?us-ascii?Q?uyeWbDpECxwDnxnip3UsPoipV2FQOFnIcdqVdzItgM9RAw8EbKWdUrNLzuv/?=
 =?us-ascii?Q?EJGHjG55PmVWL079UnmEUgci1+MwJE5hr5FE4cLx/jDpvH+jJKBk5EKtscaB?=
 =?us-ascii?Q?9NxRyZTF2Kjz8WDLXZwtoxDuPIFeCOP5XcVayIYkRPjH9GOmkuXK7PsDBdc?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN7PR02MB4148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 63675e99-47a5-45b7-727d-08dd02073d98
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 04:13:47.7573
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR02MB8958

From: Nuno Das Neves <nunodasneves@linux.microsoft.com> Sent: Thursday, Nov=
ember 7, 2024 2:32 PM
>=20
> Switch to using hvhdk.h everywhere in the kernel. This header includes
> all the new Hyper-V headers in include/hyperv, which form a superset of
> the definitions found in hyperv-tlfs.h.
>=20
> This makes it easier to add new Hyper-V interfaces without being
> restricted to those in the TLFS doc (reflected in hyperv-tlfs.h).
>=20
> To be more consistent with the original Hyper-V code, the names of some
> definitions are changed slightly. Update those where needed.
>=20
> hyperv-tlfs.h is no longer included anywhere - hvhdk.h can serve
> the same role, but with an easier path for adding new definitions.

Is hyperv-tlfs.h and friends being deleted? If not, the risk is that
someone adds a new #include of it without realizing that it has been
superseded by hvhdk.h.

Note also that this patch does not apply cleanly to 6.12 rc's, or to
current linux-next trees. There's an unrelated #include added to
arch/x86/include/asm/kvm_host.h that causes a merge failure
in that file.

Michael

>=20
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---
>  arch/arm64/hyperv/hv_core.c        |  2 +-
>  arch/arm64/hyperv/mshyperv.c       |  4 ++--
>  arch/arm64/include/asm/mshyperv.h  |  2 +-
>  arch/x86/hyperv/hv_init.c          | 20 ++++++++++----------
>  arch/x86/hyperv/hv_proc.c          |  2 +-
>  arch/x86/hyperv/nested.c           |  2 +-
>  arch/x86/include/asm/kvm_host.h    |  2 +-
>  arch/x86/include/asm/mshyperv.h    |  2 +-
>  arch/x86/include/asm/svm.h         |  2 +-
>  arch/x86/kernel/cpu/mshyperv.c     |  2 +-
>  arch/x86/kvm/vmx/hyperv_evmcs.h    |  2 +-
>  arch/x86/kvm/vmx/vmx_onhyperv.h    |  2 +-
>  drivers/clocksource/hyperv_timer.c |  2 +-
>  drivers/hv/hv_balloon.c            |  4 ++--
>  drivers/hv/hv_common.c             |  2 +-
>  drivers/hv/hv_kvp.c                |  2 +-
>  drivers/hv/hv_snapshot.c           |  2 +-
>  drivers/hv/hyperv_vmbus.h          |  2 +-
>  include/asm-generic/mshyperv.h     |  2 +-
>  include/clocksource/hyperv_timer.h |  2 +-
>  include/linux/hyperv.h             |  2 +-
>  net/vmw_vsock/hyperv_transport.c   |  2 +-
>  22 files changed, 33 insertions(+), 33 deletions(-)
>=20
> diff --git a/arch/arm64/hyperv/hv_core.c b/arch/arm64/hyperv/hv_core.c
> index 7a746a5a6b42..69004f619c57 100644
> --- a/arch/arm64/hyperv/hv_core.c
> +++ b/arch/arm64/hyperv/hv_core.c
> @@ -14,7 +14,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/module.h>
>  #include <asm-generic/bug.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
> index b1a4de4eee29..fc49949b7df6 100644
> --- a/arch/arm64/hyperv/mshyperv.c
> +++ b/arch/arm64/hyperv/mshyperv.c
> @@ -49,12 +49,12 @@ static int __init hyperv_init(void)
>  	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
>=20
>  	/* Get the features and hints from Hyper-V */
> -	hv_get_vpreg_128(HV_REGISTER_FEATURES, &result);
> +	hv_get_vpreg_128(HV_REGISTER_PRIVILEGES_AND_FEATURES_INFO, &result);
>  	ms_hyperv.features =3D result.as32.a;
>  	ms_hyperv.priv_high =3D result.as32.b;
>  	ms_hyperv.misc_features =3D result.as32.c;
>=20
> -	hv_get_vpreg_128(HV_REGISTER_ENLIGHTENMENTS, &result);
> +	hv_get_vpreg_128(HV_REGISTER_FEATURES_INFO, &result);
>  	ms_hyperv.hints =3D result.as32.a;
>=20
>  	pr_info("Hyper-V: privilege flags low 0x%x, high 0x%x, hints 0x%x, misc
> 0x%x\n",
> diff --git a/arch/arm64/include/asm/mshyperv.h
> b/arch/arm64/include/asm/mshyperv.h
> index a975e1a689dd..7595fb35fae6 100644
> --- a/arch/arm64/include/asm/mshyperv.h
> +++ b/arch/arm64/include/asm/mshyperv.h
> @@ -20,7 +20,7 @@
>=20
>  #include <linux/types.h>
>  #include <linux/arm-smccc.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  /*
>   * Declare calls to get and set Hyper-V VP register values on ARM64, whi=
ch
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index 1a6354b3e582..3f9aef157c88 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -19,7 +19,7 @@
>  #include <asm/sev.h>
>  #include <asm/ibt.h>
>  #include <asm/hypervisor.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>  #include <asm/idtentry.h>
>  #include <asm/set_memory.h>
> @@ -416,24 +416,24 @@ static void __init hv_get_partition_id(void)
>  static u8 __init get_vtl(void)
>  {
>  	u64 control =3D HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
> -	struct hv_get_vp_registers_input *input;
> -	struct hv_get_vp_registers_output *output;
> +	struct hv_input_get_vp_registers *input;
> +	struct hv_register_assoc *output;
>  	unsigned long flags;
>  	u64 ret;
>=20
>  	local_irq_save(flags);
>  	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> -	output =3D (struct hv_get_vp_registers_output *)input;
> +	output =3D (struct hv_register_assoc *)input;
>=20
> -	memset(input, 0, struct_size(input, element, 1));
> -	input->header.partitionid =3D HV_PARTITION_ID_SELF;
> -	input->header.vpindex =3D HV_VP_INDEX_SELF;
> -	input->header.inputvtl =3D 0;
> -	input->element[0].name0 =3D HV_X64_REGISTER_VSM_VP_STATUS;
> +	memset(input, 0, struct_size(input, names, 1));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	input->vp_index =3D HV_VP_INDEX_SELF;
> +	input->input_vtl.as_uint8 =3D 0;
> +	input->names[0] =3D HV_X64_REGISTER_VSM_VP_STATUS;
>=20
>  	ret =3D hv_do_hypercall(control, input, output);
>  	if (hv_result_success(ret)) {
> -		ret =3D output->as64.low & HV_X64_VTL_MASK;
> +		ret =3D output->value.reg8 & HV_X64_VTL_MASK;
>  	} else {
>  		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
>  		BUG();
> diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
> index b74c06c04ff1..ac4c834d4435 100644
> --- a/arch/x86/hyperv/hv_proc.c
> +++ b/arch/x86/hyperv/hv_proc.c
> @@ -176,7 +176,7 @@ int hv_call_create_vp(int node, u64 partition_id, u32=
 vp_index,
> u32 flags)
>  		input->partition_id =3D partition_id;
>  		input->vp_index =3D vp_index;
>  		input->flags =3D flags;
> -		input->subnode_type =3D HvSubnodeAny;
> +		input->subnode_type =3D HV_SUBNODE_ANY;
>  		input->proximity_domain_info =3D hv_numa_node_to_pxm_info(node);
>  		status =3D hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
>  		local_irq_restore(irq_flags);
> diff --git a/arch/x86/hyperv/nested.c b/arch/x86/hyperv/nested.c
> index 9dc259fa322e..1083dc8646f9 100644
> --- a/arch/x86/hyperv/nested.c
> +++ b/arch/x86/hyperv/nested.c
> @@ -11,7 +11,7 @@
>=20
>=20
>  #include <linux/types.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>  #include <asm/tlbflush.h>
>=20
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_h=
ost.h
> index 3627eab994a3..38cd609f37c7 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -34,7 +34,7 @@
>  #include <asm/asm.h>
>  #include <asm/kvm_page_track.h>
>  #include <asm/kvm_vcpu_regs.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #define __KVM_HAVE_ARCH_VCPU_DEBUGFS
>=20
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index 47ca48062547..f0564e599b7f 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -6,9 +6,9 @@
>  #include <linux/nmi.h>
>  #include <linux/msi.h>
>  #include <linux/io.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <asm/nospec-branch.h>
>  #include <asm/paravirt.h>
> +#include <hyperv/hvhdk.h>
>=20
>  /*
>   * Hyper-V always provides a single IO-APIC at this MMIO address.
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index f0dea3750ca9..913af68ad660 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -5,7 +5,7 @@
>  #include <uapi/asm/svm.h>
>  #include <uapi/asm/kvm.h>
>=20
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  /*
>   * 32-bit intercept words in the VMCB Control Area, starting
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyper=
v.c
> index e0fd57a8ba84..be0d1f4491d9 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -20,7 +20,7 @@
>  #include <linux/random.h>
>  #include <asm/processor.h>
>  #include <asm/hypervisor.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>  #include <asm/desc.h>
>  #include <asm/idtentry.h>
> diff --git a/arch/x86/kvm/vmx/hyperv_evmcs.h b/arch/x86/kvm/vmx/hyperv_ev=
mcs.h
> index a543fccfc574..6536290f4274 100644
> --- a/arch/x86/kvm/vmx/hyperv_evmcs.h
> +++ b/arch/x86/kvm/vmx/hyperv_evmcs.h
> @@ -6,7 +6,7 @@
>  #ifndef __KVM_X86_VMX_HYPERV_EVMCS_H
>  #define __KVM_X86_VMX_HYPERV_EVMCS_H
>=20
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #include "capabilities.h"
>  #include "vmcs12.h"
> diff --git a/arch/x86/kvm/vmx/vmx_onhyperv.h
> b/arch/x86/kvm/vmx/vmx_onhyperv.h
> index eb48153bfd73..2b94ff301712 100644
> --- a/arch/x86/kvm/vmx/vmx_onhyperv.h
> +++ b/arch/x86/kvm/vmx/vmx_onhyperv.h
> @@ -3,7 +3,7 @@
>  #ifndef __ARCH_X86_KVM_VMX_ONHYPERV_H__
>  #define __ARCH_X86_KVM_VMX_ONHYPERV_H__
>=20
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
>  #include <linux/jump_label.h>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyp=
erv_timer.c
> index b2a080647e41..c1cc96a168c7 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -23,7 +23,7 @@
>  #include <linux/acpi.h>
>  #include <linux/hyperv.h>
>  #include <clocksource/hyperv_timer.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
>  static struct clock_event_device __percpu *hv_clock_event;
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index c38dcdfcb914..d792df113962 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -28,7 +28,7 @@
>  #include <linux/sizes.h>
>=20
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #include <asm/mshyperv.h>
>=20
> @@ -1585,7 +1585,7 @@ static int hv_free_page_report(struct
> page_reporting_dev_info *pr_dev_info,
>  		return -ENOSPC;
>  	}
>=20
> -	hint->type =3D HV_EXT_MEMORY_HEAT_HINT_TYPE_COLD_DISCARD;
> +	hint->heat_type =3D HV_EXTMEM_HEAT_HINT_COLD_DISCARD;
>  	hint->reserved =3D 0;
>  	for_each_sg(sgl, sg, nents, i) {
>  		union hv_gpa_page_range *range;
> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 9c452bfbd571..9ea05cbbf50d 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -28,7 +28,7 @@
>  #include <linux/slab.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/set_memory.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>  #include <asm/mshyperv.h>
>=20
>  /*
> diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
> index d35b60c06114..bfb7a518b4ed 100644
> --- a/drivers/hv/hv_kvp.c
> +++ b/drivers/hv/hv_kvp.c
> @@ -27,7 +27,7 @@
>  #include <linux/connector.h>
>  #include <linux/workqueue.h>
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #include "hyperv_vmbus.h"
>  #include "hv_utils_transport.h"
> diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
> index 0d2184be1691..097ebd58f14e 100644
> --- a/drivers/hv/hv_snapshot.c
> +++ b/drivers/hv/hv_snapshot.c
> @@ -12,7 +12,7 @@
>  #include <linux/connector.h>
>  #include <linux/workqueue.h>
>  #include <linux/hyperv.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #include "hyperv_vmbus.h"
>  #include "hv_utils_transport.h"
> diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
> index 76ac5185a01a..2bea654858e3 100644
> --- a/drivers/hv/hyperv_vmbus.h
> +++ b/drivers/hv/hyperv_vmbus.h
> @@ -15,10 +15,10 @@
>  #include <linux/list.h>
>  #include <linux/bitops.h>
>  #include <asm/sync_bitops.h>
> -#include <asm/hyperv-tlfs.h>
>  #include <linux/atomic.h>
>  #include <linux/hyperv.h>
>  #include <linux/interrupt.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #include "hv_trace.h"
>=20
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyper=
v.h
> index 8fe7aaab2599..138e416a0f9c 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -25,7 +25,7 @@
>  #include <linux/cpumask.h>
>  #include <linux/nmi.h>
>  #include <asm/ptrace.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #define VTPM_BASE_ADDRESS 0xfed40000
>=20
> diff --git a/include/clocksource/hyperv_timer.h b/include/clocksource/hyp=
erv_timer.h
> index 6cdc873ac907..a4c81a60f53d 100644
> --- a/include/clocksource/hyperv_timer.h
> +++ b/include/clocksource/hyperv_timer.h
> @@ -15,7 +15,7 @@
>=20
>  #include <linux/clocksource.h>
>  #include <linux/math64.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #define HV_MAX_MAX_DELTA_TICKS 0xffffffff
>  #define HV_MIN_DELTA_TICKS 1
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index d0893ec488ae..ed65b20defea 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -24,7 +24,7 @@
>  #include <linux/mod_devicetable.h>
>  #include <linux/interrupt.h>
>  #include <linux/reciprocal_div.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  #define MAX_PAGE_BUFFER_COUNT				32
>  #define MAX_MULTIPAGE_BUFFER_COUNT			32 /* 128K */
> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_tran=
sport.c
> index e2157e387217..152b6ed8877d 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -13,7 +13,7 @@
>  #include <linux/hyperv.h>
>  #include <net/sock.h>
>  #include <net/af_vsock.h>
> -#include <asm/hyperv-tlfs.h>
> +#include <hyperv/hvhdk.h>
>=20
>  /* Older (VMBUS version 'VERSION_WIN10' or before) Windows hosts have so=
me
>   * stricter requirements on the hv_sock ring buffer size of six 4K pages=
.
> --
> 2.34.1


