Return-Path: <linux-arch+bounces-13687-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A03B876B8
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 01:52:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9719B566742
	for <lists+linux-arch@lfdr.de>; Thu, 18 Sep 2025 23:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C329258ED5;
	Thu, 18 Sep 2025 23:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="Xl87RtGp"
X-Original-To: linux-arch@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azolkn19010031.outbound.protection.outlook.com [52.103.23.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD7134BA5A;
	Thu, 18 Sep 2025 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.23.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758239566; cv=fail; b=mM+WALgOK95pM4inE1BU2bBI8NSuIh+xC6IkJZRS8VxG6TULnDRsDVuVYjdiwyYIbpdnH3KKdXWAyewj5+aN6GVg/z4qDn7lbro2ye3yFHh1h0H/ApoqdefYLkSH73063jgmDhzfBDSs7l9/uNug0njltz4eoXqtKMmyoqr6uq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758239566; c=relaxed/simple;
	bh=LWhBX8zHcS44H6WF9XgQDWaQfUH3nowAAk8GL2RYVBU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Hwu0342I1TUIe2ptbJyKYVkb/get+3o+DqjlVQTj47JV9GFyQz8BBCiHZC5AduIN0hGfsfiTjj6iHTX0jQ5duXi5rzS7oNwJMW+oTO+Rq4N7sPdiUXrTncvu7XOnjYeDYEG+CxRYQxPyYDN4+gtZIypPwvnoY39jbMmV9m8Q5XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=Xl87RtGp; arc=fail smtp.client-ip=52.103.23.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCpW3E09MowX9+TKwIqI0KSwUO5VUrFR8z1MDGjEczf59GQmfEKPCfdANNGYJu2v3as0gzto4sjvSAHFFtR1C5eCh+ySod9R8PmE+RGEDbOA2sjgzZ66GUQFptC501Y4mbnsPmwyVWzGizN0xQ5DdKVWNPAdZ2It8+mMdd1M6odBIAKdDY7prF/X7ZKQVC/aWNhf+dIGiW9RObBHcoywjj/Fkxf8ouxYBI1kn6E/pSLuXh0w/kTLUXx/TfvX8oguhXaH+nsR1sRho6ONhj69q2oolOLR0nJat9ucpJ77UgrOngBjPDjqFbTLzcjQjDr8r3madMVw71+V3lSlSaoNCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z7pH69+td5B/N84tufakfpMomUYBm11PWY/kJTWW7jw=;
 b=HYl8Zpij+4gcHNiVfG4Hb1S1zC0rL9yjh5p/XY1WuxzsLMecwcqxS+Kow9V7kA9btgCoYGj8IXPLxka6KHJMatWRWR8EFNRtqeFomKt92ZNOavPU0GBk3YF7wyl4N//3TPifor8CvLzNXDJjw+dMux+Vg0zVfmf6EDpz4GKEdpuThHANmrEWS0pRCHT179Ed4+EXf5205rUob/XtD2R2peodNAs7lrMLLxq5XWy2XqiyeSCD1GYtmjr8ZTKfbHAphD1BbHaNGNgqMe+fN0QgGme22MOUSY/omnXxwF6V0IuJY/l6OEe1bYyhj1sIt+YdRplcrcvgNGfCD6mHSWx+hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7pH69+td5B/N84tufakfpMomUYBm11PWY/kJTWW7jw=;
 b=Xl87RtGppGSV56L4sw1ZCjIG6j7EP9HjphS6k/N6kJCgbmgdI1eVG5aFiJentIAduBYoPIN5ZF09eX8jClg7tej7sCKIXklLty/BPmfIwu7q6PJpFfwnowmAn/9svL6qA+VQYvvi+7BOF5QGzYC5HLyfhDrOPUDuSbmlWUY3IjAINlaIkyYULm1qLdpeCdIHyi12rZNGzX/mQwSkLSnch8PVyfQcqfshO4HSRKvKzNjJKJgMaxSDyEPqqXFoEnaJEISZj/MqfqwhqLOCqpdeATHasfkn0DpADGttUY2gLC9idqE+lpj+xjj+YJEP52iZVQn3d8fqnMwZEvsVKDQHaw==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by MN2PR02MB6733.namprd02.prod.outlook.com (2603:10b6:208:1de::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 23:52:35 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 23:52:35 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Mukesh R <mrathor@linux.microsoft.com>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "kys@microsoft.com" <kys@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>, "tglx@linutronix.de"
	<tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de"
	<bp@alien8.de>, "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: RE: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Thread-Topic: [PATCH v1 4/6] x86/hyperv: Add trampoline asm code to transition
 from hypervisor
Thread-Index: AQHcIed7U5ohN25fCEyUdB67GAYSdLSSxdoggAOYsICAArXSsA==
Date: Thu, 18 Sep 2025 23:52:35 +0000
Message-ID:
 <SN6PR02MB4157CAE4FA74E482A96471B1D416A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20250910001009.2651481-1-mrathor@linux.microsoft.com>
 <20250910001009.2651481-5-mrathor@linux.microsoft.com>
 <SN6PR02MB41570D14679ED23C930878CCD415A@SN6PR02MB4157.namprd02.prod.outlook.com>
 <79f5d0ac-0b3e-70fc-2cbe-8a2352642746@linux.microsoft.com>
In-Reply-To: <79f5d0ac-0b3e-70fc-2cbe-8a2352642746@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|MN2PR02MB6733:EE_
x-ms-office365-filtering-correlation-id: 28e95ab0-1694-463d-f7cb-08ddf70e70f7
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799012|461199028|31061999003|41001999006|8060799015|8062599012|19110799012|13091999003|56899033|1602099012|440099028|3412199025|40105399003|4302099013|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?T2tIChkZqQ6uGZ6QrUaePjMOW4maWLkhBmCJCeTBeDxgm0hdfFl1D0/Kv364?=
 =?us-ascii?Q?hFFAuQ5NH8ohp3r6VbCUENR/+TnXaITjSlErvqT3RtW/z++LeCLqQryhi+tZ?=
 =?us-ascii?Q?uJFj2LFWZoRvYVmfsqqj1CcUpKhuKm39JglIHvxE85MpaC9ncO0hTdDmAEPY?=
 =?us-ascii?Q?MZ3crfi0xILbNos1URlvQAvI2gxVW1C8EA4xSMC0oyywI/6rr47U+wiyYwHz?=
 =?us-ascii?Q?QWaD6xQHg4vojeA1ZSB+FlIS/3RkTQnNuQNK6M5+/ApG4V7huZywL32lB87U?=
 =?us-ascii?Q?p3B7dRsJRGvxOQU2x3mLErO3thyGq/vs46aDPPTDNn78pyty/+6lotAEOD/f?=
 =?us-ascii?Q?7/gbEFwSSz48twfPLC5ZxncWpx0l+thozbjUzDVAvdeR9xfpCz9ieONZFqJ+?=
 =?us-ascii?Q?xEFcbxI1nbI1VuaDtOm3a9NUkpEa5M4w8QX/P360U/GR+qOXgs/VFRqqPWeS?=
 =?us-ascii?Q?sDnmNH/5y4ai/G2HDGP9AxdrdeG+cJlFiRGBGs0h6JIUbMTJb9HgYDzK0nJx?=
 =?us-ascii?Q?qEWzUtNiO2VtodYCoo+XhJC67s1PrrvtAkSwKedUxDmcrmipvejmrbAp9U9+?=
 =?us-ascii?Q?/Wi9wgAfAGDKBkhIG81eaSCZoixPXeVSkSCQANlxy65qhguHRwEufo7RsUH0?=
 =?us-ascii?Q?M3HeWkMptuKSOgZiR/1F4usQaa0VEYs1Ai8VppqP/4ngcOOkhZzlofNAT4yC?=
 =?us-ascii?Q?28vh/l6VgrifPAjOfS663fxsUfdmHQF+kGYSbidp+s86dZWdN7ehZFkLqzYL?=
 =?us-ascii?Q?BGwBqqkg2TxfA9BzL0AiBFhMUJj2/aH/Z5ZjAh44iLvDoAaZ6fqP3lENyWwc?=
 =?us-ascii?Q?hYedVlHtmT4ry6cnySGysE8JPJ4139WmSBQOly7SxNykgWRV4cj9+WNdNXoJ?=
 =?us-ascii?Q?XTe1zbxZTV/81OMjG1Ekx+QmOhW9ZKSSz15xZ8NOqVgHns6p0/6xEi76JHY4?=
 =?us-ascii?Q?T2SvTQ5kTl/iShnP675xtGDVLEqZvJp8I5U/EZo0M7Grkeb2jZGDa1pRfYTZ?=
 =?us-ascii?Q?lYQZak0ZCtuTQ+TMv9IE2afBlcPdfU/mKm4NRoEVWcTzAmF3rzZRSAlI4JN/?=
 =?us-ascii?Q?MY0TkWhDRBDNIY1NbZItUbSLyYi2WSmlLHsrW3edTDjRZTns/xkG81eybj9Z?=
 =?us-ascii?Q?Tl0/guyyOY07KgKvebiHTiLpIGod0ffNr24tyu44pF0ZDBz8MlTOA7imiwvI?=
 =?us-ascii?Q?9E+zFpxmhj3kqdeWndI2fRO0jyjwdqun/lEos/4JY4mCQSoa9HYVzMwuAqDD?=
 =?us-ascii?Q?rbs/fuGzpuZd8RN33HNPQz5qfW+XZebSISkDWSFS9DUVSpbxGqd+wBLi0jTQ?=
 =?us-ascii?Q?rDGp0N89wwNOnALF7FK8lYPN?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0GDzwszZWjtKSm4o/4S/ODBhfhUJca3T/9VMUSd05D9vsR/q6oRHt5o7kE/M?=
 =?us-ascii?Q?frqUFcKchIDHOL0BpR07t6wlAP1RdtoorbKHShHNVIe7c7f8lO6Ee6vsvHjs?=
 =?us-ascii?Q?BV5M/BQST9ttfk7j+j93f3+rgk5/WZ2z/R4uC7Zrft4GoA5sZOP1WfJvPGvE?=
 =?us-ascii?Q?lZu52rJ/R4xrGANWzVOObsPAjN1JdsPr0VulYEa/IzFoOcR7PBLACVUWDOGm?=
 =?us-ascii?Q?ZrkdSgZzg4ZiVvVtr90O88Hyl4QGq0KtbqdPpiD3b1c1BppkrshHkJlRlqz3?=
 =?us-ascii?Q?4bNGcVhTB6a8QpObhzLYnpIf/Ektzp1/VR94ZqWnvHbZ2KDOVD/zEOp82HW9?=
 =?us-ascii?Q?HAGNXpM5BZH3M6vkk//lwHNvqvUidFE/otRXSvt/lc1bTL7h9bQCiIaa96ZV?=
 =?us-ascii?Q?jNRTDz9DnmOMBLH5d1fFmKYctNI2UX7STzEUC+9ww+UFzN0GOZAQxzZs8h1l?=
 =?us-ascii?Q?hADTkOAOyT6KyrFZRV4YY9iQ/3DdLU6BOWJa9VqVk9L1iSrqoP2oZ5boEWV1?=
 =?us-ascii?Q?EDd1YbUe9x3e4kTcEdx59675J3M7DkW/LBgGgnW8SczuFQXJ99jvOeMDHf3J?=
 =?us-ascii?Q?8APWCblBVvrzj0K6JHK4Kutcx0Xqsad5iwgUis52cCmQps6xaJm8S3zFk6jf?=
 =?us-ascii?Q?Yat69f/X4k9cQItgXgoNasRSeDywJkmpK0fJT0IRzxaDASH9Tu6Nwk+83OWO?=
 =?us-ascii?Q?EjeRpPkk6dwtZviqgHWRRkMwgaVlMB8czkC5C3wJIsNz1jcXphv2JRP/2JCA?=
 =?us-ascii?Q?4avgPpgyBqAAOXjyCiv4rWlkVZNxN42l3jJx26/D/DuPBP/60+81a87sizuX?=
 =?us-ascii?Q?2H0dvS3auk3vs2pjtoadGqvcmexPOh0AaZcSMkhde/D3/KXWmt0lgfh+2K6/?=
 =?us-ascii?Q?WoTXu4+ZERyPlvyS5lsgEfGZQDRopCSP9GdZnk1018LmZBq1+K1+JoL4SrCC?=
 =?us-ascii?Q?oOjckkYEPwMgFszlLOYfVwKvwl6yt5uWlF30huReVD2i2bs6xU1v5nf9pVsI?=
 =?us-ascii?Q?p6m7NuSDGGdOIXXy8xO2SgnRzvIxAgqhI8Ae3cu4V9NOgGdlaepfhmqX4cL9?=
 =?us-ascii?Q?P3V4xc/jGlwKKCCN8tgVGXMTxlWEQqZaooRMTDsn6OjUm5mNkMpguvYR3QBe?=
 =?us-ascii?Q?L77/d2n7nVszMbZNvCID2LdKI1q4YKMPiz1lJ7H1Q/mRldWH+RDLm6EPp7uP?=
 =?us-ascii?Q?x6u2PSnIHdf44lRsHpv1O9tqCkCV/TyONjm2OSC58O7vhPlsKBje3LFx/bs?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 28e95ab0-1694-463d-f7cb-08ddf70e70f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2025 23:52:35.2936
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6733

From: Mukesh R <mrathor@linux.microsoft.com> Sent: Tuesday, September 16, 2=
025 2:31 PM
>=20
> On 9/15/25 10:55, Michael Kelley wrote:
> > From: Mukesh Rathor <mrathor@linux.microsoft.com> Sent: Tuesday, Septem=
ber 9, 2025 5:10 PM
> >>
> >> Introduce a small asm stub to transition from the hypervisor to linux
> >
> > I'd argue for capitalizing "Linux" here and in other places in commit
> > text and code comments throughout this patch set.
>=20
> I'd argue against it. A quick grep indicates it is a common practice,
> and in the code world goes easy on the eyes :).

I'll offer a final comment on this topic, and then let it be. There's
a history of Greg K-H, Marc Zyngier, Boris Petkov, Sean Christopherson,
and other maintainers giving comments to use the capitalized form
of "Linux", "MSR", "RAM", etc. See:

https://lore.kernel.org/lkml/Y+4WHGNdWTZ5Hc6Y@kroah.com/
https://lore.kernel.org/lkml/86o7u0dqzj.wl-maz@kernel.org/
https://lore.kernel.org/lkml/408e68d0-1ae1-6d56-d008-61de14214326@linaro.or=
g/
https://lore.kernel.org/lkml/20250819215304.GMaKTyQBWi6YzqZ0bW@fat_crate.lo=
cal/
https://lore.kernel.org/lkml/Y0CAHch5UR2Lp0tU@google.com/
https://lore.kernel.org/lkml/20240126214336.GA453589@bhelgaas/
https://lore.kernel.org/lkml/20161117155543.vg3domfqm3bhp4f7@pd.tnic/

>=20
> >> upon devirtualization.
> >
> > In this patch and subsequent patches, you've used the phrase "upon
> > devirtualization", which seems a little vague to me. Does this mean
> > "when devirtualization is complete" or perhaps "when the hypervisor
> > completes devirtualization"? Since there's no spec on any of this,
> > being as precise as possible will help future readers.
>=20
> since control comes back to linux at the callback here, i fail to
> understand what is vague about it. when hyp completes devirt,
> devirt is complete.

To me, the word "upon" is less precise than just "after".  In temporal
contexts, "upon" might mean "at the same time as" or it might mean
"immediately after". I wrote this comment as I was trying to figure out
how the entire devirtualization process works. Eventually it became clear
and the ambiguity was resolved, but initially I was uncertain. See some
broader thoughts in my reply on Patch 5 of the series.

>=20
> >>
> >> At a high level, during panic of either the hypervisor or the dom0 (ak=
a
> >> root), the nmi handler asks hypervisor to devirtualize.
> >
> > Suggest:
> >
> > At a high level, during panic of either the hypervisor or Linux running
> > in dom0 (a.k.a. the root partition), the Linux NMI handler asks the
> > hypervisor to devirtualize.
> >
> >> As part of that,
> >> the arguments include an entry point to return back to linux. This asm
> >> stub implements that entry point.
> >>
> >> The stub is entered in protected mode, uses temporary gdt and page tab=
le
> >> to enable long mode and get to kernel entry point which then restores =
full
> >> kernel context to resume execution to kexec.
> >>
> >> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> >> ---
> >>  arch/x86/hyperv/hv_trampoline.S | 105 +++++++++++++++++++++++++++++++=
+
> >>  1 file changed, 105 insertions(+)
> >>  create mode 100644 arch/x86/hyperv/hv_trampoline.S
> >>
> >> diff --git a/arch/x86/hyperv/hv_trampoline.S b/arch/x86/hyperv/hv_tram=
poline.S
> >> new file mode 100644
> >> index 000000000000..27a755401a42
> >> --- /dev/null
> >> +++ b/arch/x86/hyperv/hv_trampoline.S
> >> @@ -0,0 +1,105 @@
> >> +/* SPDX-License-Identifier: GPL-2.0-only */
> >> +/*
> >> + * X86 specific Hyper-V kdump/crash related code.
> >
> > Add a qualification that this is for root partition only, and not for
> > general guests?
>=20
> i don't think it is needed, it would be odd for guests to collect hyp
> core. besides makefile/kconfig shows this is root vm only
>=20
> >> + *
> >> + * Copyright (C) 2025, Microsoft, Inc.
> >> + *
> >> + */
> >> +#include <linux/linkage.h>
> >> +#include <asm/alternative.h>
> >> +#include <asm/msr.h>
> >> +#include <asm/processor-flags.h>
> >> +#include <asm/nospec-branch.h>
> >> +
> >> +/*
> >> + * void noreturn hv_crash_asm32(arg1)
> >> + *    arg1 =3D=3D edi =3D=3D 32bit PA of struct hv_crash_trdata
> >
> > I think this is "struct hv_crash_tramp_data".
>=20
> correct
>=20
> >> + *
> >> + * The hypervisor jumps here upon devirtualization in protected mode.=
 This
> >> + * code gets copied to a page in the low 4G ie, 32bit space so it can=
 run
> >> + * in the protected mode. Hence we cannot use any compile/link time o=
ffsets or
> >> + * addresses. It restores long mode via temporary gdt and page tables=
 and
> >> + * eventually jumps to kernel code entry at HV_CRASHDATA_OFFS_C_entry=
.
> >> + *
> >> + * PreCondition (ie, Hypervisor call back ABI):
> >> + *  o CR0 is set to 0x0021: PE(prot mode) and NE are set, paging is d=
isabled
> >> + *  o CR4 is set to 0x0
> >> + *  o IA32_EFER is set to 0x901 (SCE and NXE are set)
> >> + *  o EDI is set to the Arg passed to HVCALL_DISABLE_HYP_EX.
> >> + *  o CS, DS, ES, FS, GS are all initialized with a base of 0 and lim=
it 0xFFFF
> >> + *  o IDTR, TR and GDTR are initialized with a base of 0 and limit of=
 0xFFFF
> >> + *  o LDTR is initialized as invalid (limit of 0)
> >> + *  o MSR PAT is power on default.
> >> + *  o Other state/registers are cleared. All TLBs flushed.
> >
> > Clarification about "Other state/registers are cleared":  What about
> > processor features that Linux may have enabled or disabled during its
> > initial boot? Are those still in the states Linux set? Or are they rese=
t to
> > power-on defaults? For example, if Linux enabled x2apic, is x2apic
> > still enabled when the stub is entered?
>=20
> correct, if linux set x2apic, x2apic would still be enabled.
>=20
> >> + *
> >> + * See Intel SDM 10.8.5
> >
> > Hmmm. I downloaded the latest combined SDM, and section 10.8.5
> > in Volume 3A is about Microcode Update Resources, which doesn't
> > seem applicable here. Other volumes don't have a section 10.8.5.
>=20
> google ai found it right away upon searching: intel sdm 10.8.5 ia-32e

Unfortunately, Intel doesn't necessarily maintain the section numbering
across revisions of the SDM. This web page:

https://www.intel.com/content/www/us/en/developer/articles/technical/intel-=
sdm.html

has a link to download the "Combined Volume Set", and currently provides
the version dated June 2025. The section "Initializing IA-32e Mode" is
numbered 11.8.5. The December 2024 version has the same 11.8.5
numbering. Are you finding an older version?

Presumably the section title is less likely to change unless Intel does a
major rewrite. So something like this would be more durable:

* See Intel SDM Volume 3A section "Initializing IA-32e Mode" (numbered
11.8.5 in the June 2025 version)

>=20
> >> + */
> >> +
> >> +#define HV_CRASHDATA_OFFS_TRAMPCR3    0x0    /*	 0 */
> >> +#define HV_CRASHDATA_OFFS_KERNCR3     0x8    /*	 8 */
> >> +#define HV_CRASHDATA_OFFS_GDTRLIMIT  0x12    /* 18 */
> >> +#define HV_CRASHDATA_OFFS_CS_JMPTGT  0x28    /* 40 */
> >> +#define HV_CRASHDATA_OFFS_C_entry    0x30    /* 48 */
> >
> > It seems like these offsets should go in a #include file along
> > with the definition of struct hv_crash_tramp_data. Then the
> > BUILD_BUG_ON() calls in hv_crash_setup_trampdata() could
> > check against these symbolic names instead of hardcoding
> > numbers that must match these.
>=20
> yeah, that works too and was the first cut. but given the small
> number of these, and that they are not used/needed anywhere else,
> and that they will almost never change, creating another tiny header
> in a non-driver directory didn't seem worth it.. but i could go
> either way.
>=20
> >> +#define HV_CRASHDATA_TRAMPOLINE_CS    0x8
> >
> > This #define isn't used anywhere.
>=20
> removed
>=20
> >> +
> >> +	.text
> >> +	.code32
> >> +
> >> +SYM_CODE_START(hv_crash_asm32)
> >> +	UNWIND_HINT_UNDEFINED
> >> +	ANNOTATE_NOENDBR
> >
> > No ENDBR here, presumably because this function is entered via other
> > than an indirect CALL or JMP instruction. Right?
> >
> >> +	movl	$X86_CR4_PAE, %ecx
> >> +	movl	%ecx, %cr4
> >> +
> >> +	movl %edi, %ebx
> >> +	add $HV_CRASHDATA_OFFS_TRAMPCR3, %ebx
> >> +	movl %cs:(%ebx), %eax
> >> +	movl %eax, %cr3
> >> +
> >> +	# Setup EFER for long mode now.
> >> +	movl	$MSR_EFER, %ecx
> >> +	rdmsr
> >> +	btsl	$_EFER_LME, %eax
> >> +	wrmsr
> >> +
> >> +	# Turn paging on using the temp 32bit trampoline page table.
> >> +	movl %cr0, %eax
> >> +	orl $(X86_CR0_PG), %eax
> >> +	movl %eax, %cr0
> >> +
> >> +	/* since kernel cr3 could be above 4G, we need to be in the long mod=
e
> >> +	 * before we can load 64bits of the kernel cr3. We use a temp gdt fo=
r
> >> +	 * that with CS.L=3D1 and CS.D=3D0 */
> >> +	mov %edi, %eax
> >> +	add $HV_CRASHDATA_OFFS_GDTRLIMIT, %eax
> >> +	lgdtl %cs:(%eax)
> >> +
> >> +	/* not done yet, restore CS now to switch to CS.L=3D1 */
> >> +	mov %edi, %eax
> >> +	add $HV_CRASHDATA_OFFS_CS_JMPTGT, %eax
> >> +	ljmp %cs:*(%eax)
> >> +SYM_CODE_END(hv_crash_asm32)
> >> +
> >> +	/* we now run in full 64bit IA32-e long mode, CS.L=3D1 and CS.D=3D0 =
*/
> >> +	.code64
> >> +	.balign 8
> >> +SYM_CODE_START(hv_crash_asm64)
> >> +	UNWIND_HINT_UNDEFINED
> >> +	ANNOTATE_NOENDBR
> >
> > But this *is* entered via an indirect JMP, right? So back to my
> > earlier question about the state of processor feature enablement.
> > If Linux enabled IBT, is it still enabled after devirtualization and
> > the hypervisor invokes this entry point? Linux guests on Hyper-V
> > have historically not enabled IBT, but patches that enable it are
> > now in linux-next, and will go into the 6.18 kernel. So maybe
> > this needs an ENDBR64.
>=20
> IBT would be disabled in the transition here.... so doesn't really
> matter. ENDBR ok too..

So does Hyper-V explicitly disable IBT before making the callback?
Or is the IBT disabling somehow a processor side effect of going back
to protected mode? I don't see anything in the SDM about the latter.
Not having a Hyper-V spec for all this is frustrating ...

Doing the ENDBR64 here might be safer in the long run in case
we ever do end up here with IBT enabled.

>=20
> >> +SYM_INNER_LABEL(hv_crash_asm64_lbl, SYM_L_GLOBAL)
> >> +	/* restore kernel page tables so we can jump to kernel code */
> >> +	mov %edi, %eax
> >> +	add $HV_CRASHDATA_OFFS_KERNCR3, %eax
> >> +	movq %cs:(%eax), %rbx
> >> +	movq %rbx, %cr3
> >> +
> >> +	mov %edi, %eax
> >> +	add $HV_CRASHDATA_OFFS_C_entry, %eax
> >> +	movq %cs:(%eax), %rbx
> >> +	ANNOTATE_RETPOLINE_SAFE
> >> +	jmp *%rbx
> >> +
> >> +	int $3
> >> +
> >> +SYM_INNER_LABEL(hv_crash_asm_end, SYM_L_GLOBAL)
> >> +SYM_CODE_END(hv_crash_asm64)
> >> --
> >> 2.36.1.vfs.0.0
> >>
> >


