Return-Path: <linux-arch+bounces-13931-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E37BBEBF2
	for <lists+linux-arch@lfdr.de>; Mon, 06 Oct 2025 18:55:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5720818959EF
	for <lists+linux-arch@lfdr.de>; Mon,  6 Oct 2025 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DC12367AC;
	Mon,  6 Oct 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VI7BDUEk"
X-Original-To: linux-arch@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazolkn19012053.outbound.protection.outlook.com [52.103.2.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA591D7E42;
	Mon,  6 Oct 2025 16:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.2.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759769707; cv=fail; b=mskLLs6JR8iMhta2tdPThRDKqT1wf0+RtYhmuD1dvbhMFuaK6Oe6Z5ZuPXlJr415NkdPD5hETSWDrUCMW9nxRo2SIEpdiOWohSQ5Y53Yof8A5pQQ0ubPVEcYNzNELUamKCX1pTKWOeZWcVI1cm0BttL+uCZ5v5v1ZJOqRiVSQfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759769707; c=relaxed/simple;
	bh=m+MJc3ba6F+JEYz68ToAf/53mKC+HnT+MF01iUDv2gM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oE1ipCqxuhHCYc/4qLvbQQMCw3rQi1C0tV+QDGs4IEdCxwp5w9hHY/WaZDj1y/qfIR70JeFeBN0HiZ9nkiZU+a+85fVSyB1eaosfk+PqwQlsWUZW3WyOyojobiFM7PCZA0K/Sw96wWAFIdnhCAEamj60N+pN7it4/ULtI77cmCg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VI7BDUEk; arc=fail smtp.client-ip=52.103.2.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QavEIBMennHP3Ga2EQw58d7cbku0kU7j+2vWukXyxTpMLeEzXNwk9OUuA0y0M67isCmaKrTZHdmBDnqNMDzlGXuQkk9eQqJQ0R1q2i4KEjgr0OPR2TYJZhihKmM5FgtFWA7oYLttPyP7hvH/JStDfuvAUE9uwBsiZisy7LeSyc+FRLRkH1uKLbBPpngMKPPtfF/uGz4jBx2F25eLyHzwmNgT69QWCi3BB6P52gBEOVBpmN1NVM6k7HZXh4BwugWn5OC2BvNsH17VpEi3cJ0y3M/LnD1Z+a43g/sOoUGGbaoLIhQe0okXgiD4VdxzuNTa27KSWul+EfdOYPpmiUxuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SI4FFrCnPil08O3cbkoUzwCCvSGrMjMOzA6hIvSGSPo=;
 b=Vr3oHPNfSLIXlvQDzi+HsVUQoXAPt9+AMszzJaHpigEMHyzJmD9yVyH27k1deZdbH4l5oORyZj5geLZ32Kn6iOnQQuTj+wm0EK8E8iqIYk6ihuaud3KUlhnvaKsBF3TQUcR7S/pIx+7gBOFPKFH8JT480I+ucnKi7yQDQA2kprOEMCGwccQuSdEHbsZkuqmzzZpj0mBNe8IOD+HY+rMV4eDrL0ctFqvaTUkYqzFZmmYKXMkPsuPMgWOz0AOMH/nd5YbQzd4yAZVpo56eBQ5xiGGhezqRQzBOo1diJUFf1dKVH8YwxoniCF9ZjMCmiMH08OldkftNohfxrguMTj+b1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SI4FFrCnPil08O3cbkoUzwCCvSGrMjMOzA6hIvSGSPo=;
 b=VI7BDUEkJvYp9/KL8qoNl0r0JjHA8qJwVOeme3ceSmM0G1PiXjvYBrDeZTKYLY0PsZ8H7OasmgBV5xRIEAKI1Xwk6WA7EP4E1e/IqgFgwq+72oDazzxBBAkuZWnju6eJ7junAm27QwSL4xn5vsanNm63rAJPDIOYwc39BKq2SdmQFYgPS59eaC4zlGIrRl7YLW62GGVadaeE2HLmlHpgCGvlZsmKSDvN+tKwEzPXNeCXLIdJA2/n9uPLdMiA7TrYPxaNWwireW1+vI2RDP4i9EIDbuW14xm0CARnR1w3WpRCCE4vgiUKzdDJGdPUB/g42diE8aznZgojZJm6wjEkLA==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by BY5PR02MB6675.namprd02.prod.outlook.com (2603:10b6:a03:203::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.17; Mon, 6 Oct
 2025 16:55:01 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%3]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 16:55:01 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Roman Kisel <romank@linux.microsoft.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"bp@alien8.de" <bp@alien8.de>, "corbet@lwn.net" <corbet@lwn.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"decui@microsoft.com" <decui@microsoft.com>, "haiyangz@microsoft.com"
	<haiyangz@microsoft.com>, "hpa@zytor.com" <hpa@zytor.com>,
	"kys@microsoft.com" <kys@microsoft.com>, "mikelley@microsoft.com"
	<mikelley@microsoft.com>, "mingo@redhat.com" <mingo@redhat.com>,
	"tglx@linutronix.de" <tglx@linutronix.de>, "Tianyu.Lan@microsoft.com"
	<Tianyu.Lan@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-hyperv@vger.kernel.org"
	<linux-hyperv@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>
CC: "benhill@microsoft.com" <benhill@microsoft.com>, "bperkins@microsoft.com"
	<bperkins@microsoft.com>, "sunilmut@microsoft.com" <sunilmut@microsoft.com>
Subject: RE: [PATCH hyperv-next v6 00/17] Confidential VMBus
Thread-Topic: [PATCH hyperv-next v6 00/17] Confidential VMBus
Thread-Index: AQHcNLT9CbsIQg/BzECFUV8Pqz4C2LS0dVDA
Date: Mon, 6 Oct 2025 16:55:00 +0000
Message-ID:
 <SN6PR02MB415707D796045E8BD30396D8D4E3A@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20251003222710.6257-1-romank@linux.microsoft.com>
In-Reply-To: <20251003222710.6257-1-romank@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|BY5PR02MB6675:EE_
x-ms-office365-filtering-correlation-id: 51e32cee-1936-4bf4-be0d-08de04f916cd
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799015|8062599012|15080799012|19110799012|12121999013|461199028|31061999003|13091999003|56899033|1602099012|40105399003|3412199025|440099028|4302099013|51005399003|10035399007|102099032|12091999003;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6PvTbzvbATApkH73Kqv1+7AjynKh8z7LZ2KiDvFuCbsv2E0HiN3gHS/U4Pzi?=
 =?us-ascii?Q?WlKa6LiWZ2ehmziIIu6sq/7M7Ffbj1QThe2dlUuJO5f6Ns/5cacDt+g5bFlr?=
 =?us-ascii?Q?vDwriCqyHi5EZwwX1L2iWk6i1sfDGdIvLRAUHPg3hNCmP3nrauMRWaYBpmKC?=
 =?us-ascii?Q?tP6MWYGe6CkjPUCCtCMKNnfAxVoM89ZDnwMV0gXAf0LI846EGuYg/YY8gwQg?=
 =?us-ascii?Q?bNlk1Fq+yQIPUcOiIFhr6xKqq0nJ85X257t0jJrzJCom0wzKIodI6gdRzyTy?=
 =?us-ascii?Q?DCqYTObF1J4Arm9hAgFpL7Bum/xII1lEYv/oMV98EC7BzxH5VbWsAuQnVWFH?=
 =?us-ascii?Q?Fsop5hdj61xxZUIn17Zno/FHZGNZBm9zMBwG92TTWTKrvrEeJnAEi8EJiHKR?=
 =?us-ascii?Q?ftBJHIa8pXASkBk2kFIV2RV218opRb+5l+LtXxY9mZDlJIouVxHKEwZE1Gjq?=
 =?us-ascii?Q?Z0c69X56Iz92ezipjwqG+uDSNoVv8Qw9FEkmn39CD9b8/lm2RRugH27UTlY5?=
 =?us-ascii?Q?2CyXqes86Cz32So7g4H3Ang9je7VImDm/hvNBeg4d1+YIIfHT5WyZyYOI8b0?=
 =?us-ascii?Q?LfdPUgfkSlTR712Obl6qEkWcgLi6SaWqpira1bbGNrvO76l4s2v6JhXh6Jzq?=
 =?us-ascii?Q?2p8eWUG7q1GJA/DzRG/I6ZGegTlJScVrespxmoos5tHMbGcPzlbduaPDR1SX?=
 =?us-ascii?Q?69YcD4PkIpMN9rpkLmWrrxyHPM7mgom2dLf0gHkyyydm0SOKdCjPX1Ro9s52?=
 =?us-ascii?Q?vxplKYxPvGLGGS0yGjutozCnlZrmfIK3GdWlsBeJyKDx8LTywPAlf3FPpPZ2?=
 =?us-ascii?Q?rwWNA7mbqmvnC3qo3sJ3nq9Ux8PotLdO5JVy4pFaCFjOTxvy0Up+71La/+A3?=
 =?us-ascii?Q?SB6tgaSF4RPxKZ0TYX0R+gwUNp7OnDpiVtURl7QkbD2SUwsYQh0+Qet2Rb7M?=
 =?us-ascii?Q?nlYfWMrgFOhwLfoiNw5hO9ljMGKseHWMaOxr1HuU0vj7knXNN+F4Obct/VOY?=
 =?us-ascii?Q?ZqAzFDwdoA8Ub6F2ryHFrB5OlTQwLZRFNuJ7BGD2FNQtWJpCi3Hh+fDRrpCw?=
 =?us-ascii?Q?EvhNoD+bO9YCe7JCijknWsOphx5Ak4Gi1yTXsvOOycFtTw0kfQJWXSKLwRws?=
 =?us-ascii?Q?+yEQu8QSyZJh5K9pugBvLcsWKc6fhu5lsAJvDzGjSeC7lcLhukbYXGdwd7bL?=
 =?us-ascii?Q?7RMXV9SWnOzoUnistoD48MNWKtBAyvnE4k2kTT6oQd2JRe+YYGbHGjQkgHwL?=
 =?us-ascii?Q?b42uu8Gx7hjyDjpHfE5o2Aun0O79WMLKw20L1VTo4FGLtCqAoCNIOX7403LE?=
 =?us-ascii?Q?hKep29sz5f2EMncBlcM+yQcb49tX/Pz+DFnJNG6k5ZObA6foWfAeQqE5Vcug?=
 =?us-ascii?Q?LS5czec=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?AU4WQ7B3KJxoU69YvtsyeFjts8ETuXRjH1TH3bAD59X/4S4K7IxWFD52zT+Q?=
 =?us-ascii?Q?dRD328gqfgAfmkoUSKZZi4efEuj98XfTga7iIgITnn2V1D4FvyIQc6r7M1HX?=
 =?us-ascii?Q?7ChibjFCaX999LVKGNk+Jyr/f5RX0tkazzy1dlxlrSwq70Nt+BOG/7duDVVo?=
 =?us-ascii?Q?L68elPxV3Ed2B06/EvfUTyxwi22dtzB7fDupLy0szlyHJMucY6j/z9hqnvL6?=
 =?us-ascii?Q?c5DVBi48H4QsXRlqztIP0+GyOujn4SIkqKjjKYEfLV0mv2z3txw1/seYvSVj?=
 =?us-ascii?Q?C+qBlYfmjutbLwlPg950vOdS2eduT8LrSmVFFuaDXbhneFfTFjNK0tDKOSEm?=
 =?us-ascii?Q?v/SQWTmCMMfXaqjHKDUAU5/U57WCiY5JS9n07QviXBU56mte2XEK2HiOF95T?=
 =?us-ascii?Q?XaImfeRM58TQNttFEsCOnzznJrqtbiqDPzQFK2+4nboSMcl4hAyU4bQG4p44?=
 =?us-ascii?Q?ZfCyXU/2K2aV1VL9YZaP6CHfCXHAEU1AU5RXeAjl4bT1+ssbDfHLTpkz+qUh?=
 =?us-ascii?Q?iWAriveD7B00u/6xcaq6gCVATw7uWMQorutbEuQbsLY0T+vvbaR9VNjMVRsY?=
 =?us-ascii?Q?kghUpcaXuW7Q+A2O1VgmIEgHQAHNeOL04epDAnV2j1P2gLKfTU97U+1bOAlz?=
 =?us-ascii?Q?zrinkaj41t2yhgiXbPfmD9kdGLyDY0OD4N2rvveoFaoBywSBeCDPr4wjwaqj?=
 =?us-ascii?Q?OMyT3otplVQaULp2geL3L1Tq30gd2BdqMmhZGmvqcCjyKxH275/6/AVJR75x?=
 =?us-ascii?Q?2kcmdStr5xjnVY7O3KYT5KcVd/TIu9CKQALCDnk3id0AcBG2vnKE9oAqepu7?=
 =?us-ascii?Q?2rKxSl236ZAXhbaMhP/2F0D2ZMLFaT5T8TDJZ+3/i8nma+FZb/ZCD8XCTu6X?=
 =?us-ascii?Q?iCtbhX3Y2lUyaBpvotwVU4b9lKwvZD4RyALrD9YKaxgSffdbmt5QE9CSR66M?=
 =?us-ascii?Q?qBqt0VcOA4LiiHWjtPaLl7Gges/ta7ed6itq+O0iU0cmRUrmmpieSyFC574O?=
 =?us-ascii?Q?nwiNfH3E5/SuILf7visJSdqxtaUYX14BpJyA87kcatauRMydO+vax+6fhplN?=
 =?us-ascii?Q?tZT7Nc4NkiTWpZ1tftKuUdP7VA2Qdar3C6JSRXqdN46Wa4SjkryO3hUgG31X?=
 =?us-ascii?Q?znuxpxolsrH8YMSl2MpZPhEtljJmtW/Ne3jPp2l/HjERQTnfN0mANsb2+HRY?=
 =?us-ascii?Q?dXw9dFuepDT9rvxk+HXIh63yn99MPrE+n6lSJxXtJx0oYLhCo4jF7QAjJVA?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 51e32cee-1936-4bf4-be0d-08de04f916cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2025 16:55:00.8900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6675

From: Roman Kisel <romank@linux.microsoft.com> Sent: Friday, October 3, 202=
5 3:27 PM
>=20
> Greetings everyone,
>=20
> We've got to the 6th version of the patch series, and the full changelog
> is at the end of the cover letter. I addressed feedback from
> Michael and Wei on the previous version of the patch series.
>=20
> Since v5, the fallback mechanism for establishing the VMBus connection
> is no longer used as the availability of the Confidential VMBus is
> now indicated by a bit in the Virtualization Stack (VS) CPUID leaf.
> The v6 patch series breaks that out into a separate patch seizing
> the opportunity to refactor the code that uses the same leaf.
>=20
> That is obviously an x86_64 specific technique. On ARM64, the
> Confidential VMBus is expected to be required once support for ARM CCA is
> implemented. Despite that change, the functions for getting and setting
> registers via paravisor remain fallible.=20

This statement seems to contradict your description of the v6
changes further down in this cover letter:

     - Gave another thought to the fallible routines for getting and settin=
g
       SynIC registers via paravisor introduced in the patch series, and af=
ter
       Michael's feedback decided to make them infallible

Patches 4 and 12 of this series also implement "infallible".

> That provides a clearer root cause
> for failures instead of printing messages about unchecked MSR accesses.
> That might seem as not needed with the paravisors run in Azure (OpenHCL
> and the TrustedLauch aka HCL paravisor). However, if someone decides to
> implement their own or tweak the exisiting one, this will help with debug=
ging.
>=20
> TLDR; is that these patches are for the Hyper-V guests, and the patches
> allow to keep data flowing from physical devices into the guests encrypte=
d
> at the CPU level so that neither the root/host partition nor the hypervis=
or
> can access the data being processed (they only "see" the encrypted/garble=
d
> data) unless the guest decides to share it. The changes are backward comp=
atible
> with older systems, and their full potential is realized on hardware that
> supports memory encryption.
>=20
> These features also require running a paravisor, such as
> OpenHCL (https://github.com/microsoft/openvmm) used in Azure. Another
> implementation of the functionality available in this patch set is
> available in the Hyper-V UEFI: https://github.com/microsoft/mu_msvm.
>=20
> A more detailed description of the patches follows.
>=20
> The guests running on Hyper-V can be confidential where the memory and th=
e
> register content are encrypted, provided that the hardware supports that
> (currently support for AMD SEV-SNP and Intel TDX is implemented) and the =
guest
> is capable of using these features. The confidential guests cannot be
> introspected by the host nor the hypervisor without the guest sharing the
> memory contents upon doing which the memory is decrypted.
>=20
> In the confidential guests, neither the host nor the hypervisor need to b=
e
> trusted, and the guests processing sensitive data can take advantage of t=
hat.
>=20
> Not trusting the host and the hypervisor (removing them from the Trusted
> Computing Base aka TCB) necessitates that the method of communication
> between the host and the guest be changed. Here is the data flow for a
> conventional and the confidential VMBus connections (`C` stands for the
> client or VSC, `S` for the server or VSP, the `DEVICE` is a physical one,
> might be with multiple virtual functions):
>=20
> 1. Without the paravisor the devices are connected to the host, and the
> host provides the device emulation or translation to the guest:
>=20
>   +---- GUEST ----+       +----- DEVICE ----+        +----- HOST -----+
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   |               |       |                 =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                |
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   |               |       |                 |        |                |
>   +----- C -------+       +-----------------+        +------- S ------+
>          ||                                                   ||
>          ||                                                   ||
>   +------||------------------ VMBus --------------------------||------+
>   |                     Interrupts, MMIO                              |
>   +-------------------------------------------------------------------+
>=20
> 2. With the paravisor, the devices are connected to the paravisor, and
> the paravisor provides the device emulation or translation to the guest.
> The guest doesn't communicate with the host directly, and the guest
> communicates with the paravisor via the VMBus. The host is not trusted
> in this model, and the paravisor is trusted:
>=20
>   +---- GUEST --------------- VTL0 ------+               +-- DEVICE --+
>   |                                      |               |            |
>   | +- PARAVISOR --------- VTL2 -----+   |               |            |
>   | |     +-- VMBus Relay ------+    =3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D            |
>   | |     |   Interrupts, MMIO  |    |   |               |            |
>   | |     +-------- S ----------+    |   |               +------------+
>   | |               ||               |   |
>   | +---------+     ||               |   |
>   | |  Linux  |     ||    OpenHCL    |   |
>   | |  kernel |     ||               |   |
>   | +---- C --+-----||---------------+   |
>   |       ||        ||                   |
>   +-------++------- C -------------------+               +------------+
>           ||                                             |    HOST    |
>           ||                                             +---- S -----+
>   +-------||----------------- VMBus ---------------------------||-----+
>   |                     Interrupts, MMIO                              |
>   +-------------------------------------------------------------------+
>=20
> Note that in the second case the guest doesn't need to share the memory
> with the host as it communicates only with the paravisor within their
> partition boundary. That is precisely the raison d'etre and the value
> proposition of this patch series: equip the confidential guest to use
> private (encrypted) memory and rely on the paravisor when this is
> available to be more secure.
>=20
> An implementation of the VMBus relay that offers the Confidential VMBus
> channels is available in the OpenVMM project as a part of the OpenHCL
> paravisor. Please refer to
>=20
>   * https://openvmm.dev/guide/, and
>   * https://github.com/microsoft/openvmm=20
>=20
> for more information about the OpenHCL paravisor. A VMBus client
> that can work with the Confidential VMBus is available in the
> open-source Hyper-V UEFI: https://github.com/microsoft/mu_msvm.
>=20
> I'd like to thank the following people for their help with this
> patch series:
>=20
> * Dexuan for help with validation and the fruitful discussions,
> * Easwar for reviewing the refactoring of the page allocating and
>   freeing in `hv.c`,
> * John and Sven for the design,
> * Mike for helping to avoid pitfalls when dealing with the GFP flags,
> * Sven for blazing the trail and implementing the design in few
>   codebases.
>=20
> I made sure to validate the patch series on
>=20
>     {TrustedLaunch(x86_64), OpenHCL} x
>     {SNP(x86_64), TDX(x86_64), No hardware isolation, No paravisor} x
>     {VMBus 5.0, VMBus 6.0} x
>     {arm64, x86_64}.
>=20
> [V6]
>     - Rebased onto the latest hyperv-next tree.
>=20
>     - Gave another thought to the fallible routines for getting and setti=
ng
>       SynIC registers via paravisor introduced in the patch series, and a=
fter
>       Michael's feedback decided to make them infallible as now we have t=
he
>       CPUID bit to indicate the availability of the Confidential VMBus. T=
hat
>       simplifies the code and makes it clearer and more robust - a reflec=
tion
>       of the improvements in the design throught the patch series iterati=
ons.
>     - Removed the sentence discussing the fallback mechanism in the Docum=
entation
>       as it is no longer relevant.
>       **Thank you, Michael!**
>=20
>     - Avoided using the macro'es for (un)masking the proxy bit thanks to
>       `union hv_synic_sint`.
>       **Thank you, Wei!**
>=20
> [V5] https://lore.kernel.org/linux-hyperv/20250828010557.123869-1-romank@=
linux.microsoft.com/=20
>     - Rebased onto the latest hyperv-next tree.
>=20
>     - Fixed build issues with the configs provided by the kernel robot.
>       **Thank you, kernel robot!**
>=20
>     - Fixed the potential NULL deref in a failure path.
>       **Thank you, Michael!**
>=20
>     - Removed the added blurb from the vmbus_drv.c with taxonomy of Hyper=
-V VMs
>       that was providing reasons for the trade-offs in the fallback code.=
 That
>       code is no longer needed.
>=20
> [V4] https://lore.kernel.org/linux-hyperv/20250714221545.5615-1-romank@li=
nux.microsoft.com/=20
>     - Rebased the patch series on top of the latest hyperv-next branch,
>       applying changes as needed.
>=20
>     - Fixed typos and clarifications all around the patch series.
>     - Added clarifications in the patch 7 for `ms_hyperv.paravisor_presen=
t && !vmbus_is_confidential()`
>       and using hypercalls vs SNP or TDX specific protocols.
>       **Thank you, Alok!**
>=20
>     - Trim the Documentation changes to 80 columns.
>       **Thank you, Randy!**
>=20
>     - Make sure adhere to the RST format, actually built the PDF docs
>       and made sure the layout was correct.
>     **Thank you, Jon!**
>=20
>     - Better section order in Documentation.
>     - Fixed the commit descriptions where suggested.
>     - Moved EOI/EOM signaling for the confidential VMBus to the specializ=
ed function.
>     - Removed the unused `cpu` parameters.
>     - Clarified comments in the `hv_per_cpu_context` struct
>     - Explicitly test for NULL and only call `iounmap()` if non-NULL inst=
ead of
>       using `munmap()`.
>     - Don't deallocate SynIC pages in the CPU online and offline paths.
>     - Made sure the post page needs to be allocated for the future.
>     - Added comments to describe trade-offs.
>     **Thank you, Michael!**
>=20
> [V3] https://lore.kernel.org/linux-hyperv/20250604004341.7194-1-romank@li=
nux.microsoft.com/=20
>     - The patch series is rebased on top of the latest hyperv-next branch=
.
>     - Reworked the "wiring" diagram in the cover letter, added links to t=
he
>       OpenVMM project and the OpenHCL paravisor.
>=20
>     - More precise wording in the comments and clearer code.
>     **Thank you, Alok!**
>=20
>     - Reworked the documentation patch.
>     - Split the patchset into much more granular patches.
>     - Various fixes and improvements throughout the patch series.
>     **Thank you, Michael!**
>=20
> [V2] https://lore.kernel.org/linux-hyperv/20250511230758.160674-1-romank@=
linux.microsoft.com/=20
>     - The patch series is rebased on top of the latest hyperv-next branch=
.
>=20
>     - Better wording in the commit messages and the Documentation.
>     **Thank you, Alok and Wei!**
>=20
>     - Removed the patches 5 and 6 concerning turning bounce buffering off=
 from
>       the previous version of the patch series as they were found to be
>       architecturally unsound. The value proposition of the patch series =
is not
>       diminished by this removal: these patches were an optimization and =
only for
>       the storage (for the simplicity sake) but not for the network. Thes=
e changes
>       might be proposed in the future again after revolving the issues.
>     ** Thanks you, Christoph, Dexuan, Dan, Michael, James, Robin! **
>=20
> [V1] https://lore.kernel.org/linux-hyperv/20250409000835.285105-1-romank@=
linux.microsoft.com/=20
>=20
> Roman Kisel (17):
>   Documentation: hyperv: Confidential VMBus
>   Drivers: hv: VMBus protocol version 6.0
>   arch/x86: mshyperv: Discover Confidential VMBus availability
>   arch: hyperv: Get/set SynIC synth.registers via paravisor
>   arch/x86: mshyperv: Trap on access for some synthetic MSRs
>   Drivers: hv: Rename fields for SynIC message and event pages
>   Drivers: hv: Allocate the paravisor SynIC pages when required
>   Drivers: hv: Post messages through the confidential VMBus if available
>   Drivers: hv: remove stale comment
>   Drivers: hv: Check message and event pages for non-NULL before
>     iounmap()
>   Drivers: hv: Rename the SynIC enable and disable routines
>   Drivers: hv: Functions for setting up and tearing down the paravisor
>     SynIC
>   Drivers: hv: Allocate encrypted buffers when requested
>   Drivers: hv: Free msginfo when the buffer fails to decrypt
>   Drivers: hv: Support confidential VMBus channels
>   Drivers: hv: Set the default VMBus version to 6.0
>   Drivers: hv: Support establishing the confidential VMBus connection
>=20
>  Documentation/virt/hyperv/coco.rst | 139 ++++++++++-
>  arch/x86/kernel/cpu/mshyperv.c     |  77 ++++--
>  drivers/hv/channel.c               |  73 ++++--
>  drivers/hv/channel_mgmt.c          |  27 ++-
>  drivers/hv/connection.c            |   6 +-
>  drivers/hv/hv.c                    | 372 +++++++++++++++++++----------
>  drivers/hv/hv_common.c             |  16 ++
>  drivers/hv/hyperv_vmbus.h          |  75 +++++-
>  drivers/hv/mshv_root.h             |   2 +-
>  drivers/hv/mshv_synic.c            |   6 +-
>  drivers/hv/ring_buffer.c           |   5 +-
>  drivers/hv/vmbus_drv.c             | 186 ++++++++++-----
>  include/asm-generic/mshyperv.h     |  45 +---
>  include/hyperv/hvgdk_mini.h        |   1 +
>  include/linux/hyperv.h             |  69 ++++--
>  15 files changed, 793 insertions(+), 306 deletions(-)
>=20

Nice! The net lines of code added is now 487, vs. 591
lines added in v5 of this series.

Modulo the contradiction above in this cover letter, the two typos in
the documentation in Patch 1, and the simple fix for the error reported
by the kernel test robot for Patch 5, I'm happy with this entire series.
For the series,

Reviewed-by: Michael Kelley <mhklinux@outlook.com>

