Return-Path: <linux-arch+bounces-10660-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBBEA5A70D
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 23:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA30188276E
	for <lists+linux-arch@lfdr.de>; Mon, 10 Mar 2025 22:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 201091F4C88;
	Mon, 10 Mar 2025 22:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="AVGEdSHd"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12olkn2010.outbound.protection.outlook.com [40.92.23.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD291F4CAF;
	Mon, 10 Mar 2025 22:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.23.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741645410; cv=fail; b=PsbOvzVNosyE5knhwulKs5dGDWd4VjTxGu/N4V2H/N6SFI7OCdaVDBbaeM9VezJf6oceFxI8gTH5bU4xZcEkYnZnxoWKFiXnGzJdlX95fWJ1zSVoU2TTW5QJCXLERYWqaCQmwEZy/0mTtvrUrdD6q77PA2yj1Q1gMCoOmWYYK4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741645410; c=relaxed/simple;
	bh=bKmhkiR26mUOvnvNVaBLQV73UCwQ9q1wVZtxxiC4z+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HLx9/DUgxg+D99huoTp1jcCDrxMlVPPLoCeA8vhPh7l9N4kjcipsPELvG2R3lJo6xbpVzmYRIkW/fXTomwbLZvMpSj/IUoOfa4bkOgnpraEx+hTUCiJ170lVQ+xdyT9GayyCqjxpMcmHseMarTpdVbhU5BzHK37fvDbWfalPSW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=AVGEdSHd; arc=fail smtp.client-ip=40.92.23.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=msDeAJ/qqUpH5aHfPsIig6eHhnQnL2GIyo/yXpBXfa0EfQ5R6iDlEWdhp13xqVRpU7+6mDcnlkx5Irw5Qdq/YDW0jLVE6YxfR47jYllrlsl5XZKgaKTSDj6NdN3k2o094iX3H1aRZ6MK9E6Gve8c1TJEAaCBK8RTAGwpy26ot9p9sZeABniugSYVV9py9Z/nQe4Fsg0JaV4SuRcV4O07Dv/ejvy7ZvasnSsnDEvi+ShDCOm2MbwUg39weG37l6TYpA+bZWp9RPLnPNSzbMs1v0S4Pr+BtxGBOT6DsbKc17JWHgtoMLxwRqxtZAl/Lgc7WUdQlmCFUv7LsJo179uKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bKmhkiR26mUOvnvNVaBLQV73UCwQ9q1wVZtxxiC4z+M=;
 b=uNSz2IHws3/p6dltyQgGQ+i6ad53Zp31rPcXZjBVLqDSlOZGhB9D84R64mc9qCnBXIFFQCVkZ1zJ0ZfMxww6Zz8ejmVfdvLl4iBgJKWM1oF7d4Tp+t00d8F6Ybf2iBHln//D/PbKNSg2eUA2WqzwKIMO8McCu4KsMzodwUR8QWev0W7KRCpRwg+VUaM7ArzZstPD4rxYIicJ5uxmzP73SkHKHOv8tjFz6d11KVGiPbXQF+LB7slxobBvTP7TnXHrPZYyHtS4v4mUXAD53BaM91Gt/WFkTz4sryfzhrXfU5AfZ/sqUQKdAPRQLDw9sB4jGkexY+8ud2hZVI/QvWdr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bKmhkiR26mUOvnvNVaBLQV73UCwQ9q1wVZtxxiC4z+M=;
 b=AVGEdSHduuMDeE0+Ths3dY1GUQohC6L+wgOlYi6OyVVJyUyeZZcqMSBwikcUDwBKrSd8+5NJWeHC+Gz8hOr+Aen5FY+6X7sZRIP3IlLXKJbsn7EIeeyH6Fb3vnkVVzkyT5GvaIR0kZQt7NfmF8SU5o+b82I5IXrdfrtAN2mjn2m5B4hf1CLm1vR5m7vxHR4ZYrM5CLYzHT8GL9YnuYL5RdQ7mR93EL4ct5x93UnueT+xUaO7YT6DWT2R93XAfxjKRSNzIgy0xQ/eQxbJRYYLXbdd8Yul6SE0Yz+EP4PXWI8leCo7ptglYw3fs00LQ0wktJGsx9ErKsA2X/7LfkFyDA==
Received: from BN7PR02MB4148.namprd02.prod.outlook.com (2603:10b6:406:f6::17)
 by BY1PR02MB10530.namprd02.prod.outlook.com (2603:10b6:a03:5ab::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:23:24 +0000
Received: from BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911]) by BN7PR02MB4148.namprd02.prod.outlook.com
 ([fe80::1c3a:f677:7a85:4911%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 22:23:24 +0000
From: Michael Kelley <mhklinux@outlook.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>, Stanislav Kinsburskii
	<skinsburskii@linux.microsoft.com>
CC: "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"x86@kernel.org" <x86@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, "linux-acpi@vger.kernel.org"
	<linux-acpi@vger.kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>, "wei.liu@kernel.org"
	<wei.liu@kernel.org>, "decui@microsoft.com" <decui@microsoft.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>, "will@kernel.org"
	<will@kernel.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "hpa@zytor.com"
	<hpa@zytor.com>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
	"joro@8bytes.org" <joro@8bytes.org>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "arnd@arndb.de" <arnd@arndb.de>,
	"jinankjain@linux.microsoft.com" <jinankjain@linux.microsoft.com>,
	"muminulrussell@gmail.com" <muminulrussell@gmail.com>,
	"mrathor@linux.microsoft.com" <mrathor@linux.microsoft.com>,
	"ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
	"apais@linux.microsoft.com" <apais@linux.microsoft.com>,
	"Tianyu.Lan@microsoft.com" <Tianyu.Lan@microsoft.com>,
	"stanislav.kinsburskiy@gmail.com" <stanislav.kinsburskiy@gmail.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "prapal@linux.microsoft.com"
	<prapal@linux.microsoft.com>, "muislam@microsoft.com"
	<muislam@microsoft.com>, "anrayabh@linux.microsoft.com"
	<anrayabh@linux.microsoft.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"lenb@kernel.org" <lenb@kernel.org>, "corbet@lwn.net" <corbet@lwn.net>
Subject: RE: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Topic: [PATCH v5 08/10] x86: hyperv: Add mshv_handler irq handler and
 setup function
Thread-Index: AQHbiKNt6Dmf5ml0nkycDSKgcIRUw7NaPxqAgAM0E4CACohmkIAE/vuAgAAJGEA=
Date: Mon, 10 Mar 2025 22:23:24 +0000
Message-ID:
 <BN7PR02MB41484D4FC07F44033068A5A2D4D62@BN7PR02MB4148.namprd02.prod.outlook.com>
References:
 <1740611284-27506-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1740611284-27506-9-git-send-email-nunodasneves@linux.microsoft.com>
 <Z7-nDUe41XHyZ8RJ@skinsburskii.>
 <7de9b06d-9a32-48b5-beda-2e19b36ae9c9@linux.microsoft.com>
 <SN6PR02MB41573673D5F786E6C47FC08ED4D52@SN6PR02MB4157.namprd02.prod.outlook.com>
 <71a95f7d-d38b-4f4f-b384-9ad4095bd272@linux.microsoft.com>
In-Reply-To: <71a95f7d-d38b-4f4f-b384-9ad4095bd272@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN7PR02MB4148:EE_|BY1PR02MB10530:EE_
x-ms-office365-filtering-correlation-id: bf4d2510-9d72-4ab6-2174-08dd60222c10
x-microsoft-antispam:
 BCL:0;ARA:14566002|8060799006|19110799003|15080799006|461199028|8062599003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?aUFiMkJtbHF3ODhOT1R3ZVBoaHFXSW9lWEp5TC9LSlloU1MxazdIbjNidkdu?=
 =?utf-8?B?Z3JacE9aeFd2eVZleDZJT2pHRFpScTBOMmlHVU0ycTlxd0NBNmFuUVBsTnBo?=
 =?utf-8?B?bzdFbnZmTEtnUXBFbUpMcHY5RCtvUGRUQ3gya0I5NW1FNXJYKzFiSXVQRkJi?=
 =?utf-8?B?SVlVTlExR3VBQ1BDRTlBSkNKNVQ5Sjh2VFlINHM3SFlHNm5MYUNEbU00Mzdy?=
 =?utf-8?B?bVZ4OFd4NkZDNEdFY0YzYmxhVXlhZFlRR3pYSGcrMVg0Qk1WbHBVQ3BSME1V?=
 =?utf-8?B?Z21kWjVRVExQcHFJSUh3RFdFYU1Fdks2VlZvb1oxUzBCWVMwaE9jS29RZVlr?=
 =?utf-8?B?dDVPeDlBaXUrUVg2RnFXV2ZMSXFVR1lzTGtmZ2ZaNUVhR0l2TXBqT2pSUFBL?=
 =?utf-8?B?Wmk1b2pDaXQ4bGJZK0NHMWYwZ1hleHBnR242b2EzMVY3emxFR1ZIdkZuSmpX?=
 =?utf-8?B?Z25LTkI2SDV4UGhwcHF6cHZEV1JMVnNSV0ZIVVBreHljUjBqYWhRb0tQN3lw?=
 =?utf-8?B?VU9ic3E5M21GUERUOVFCbkM5SWhDTjJ0VEZQZkVJNFdFeExMVi9KRmFqSTFl?=
 =?utf-8?B?eTNXaUxCSlUxVGZMVjBFem1NS1VPTnRzYmR2b3p4L3ZUeU9hMC9VeTlGQWRP?=
 =?utf-8?B?TnR3dEdEczc5V3MxTjliNHROSEZubzRYV2ZHblpSRGcyWThKREdWcHhEcE05?=
 =?utf-8?B?R0hvSHNhdzhaeGtJZWYzaDR5UWYvR29uWmp2QUhyZkV1NExtZGFGSFhoaGF6?=
 =?utf-8?B?cGdDMHFvR09xcFJsbmpLdzEzMmhCRVBkTzliV3IxSkRuSkozb2JPRjdPTTNt?=
 =?utf-8?B?SloxVVU3aEtKbXREMGNQL3ZXQnVzMHZOMnFtTzY2SEtrTHRqMkJoN1F5aFlC?=
 =?utf-8?B?cXA4REhDUGt1N0hlVytON0VKdC9Ob1FyYXYyanc1bmkwTUF1ZUJSbGRwSzFT?=
 =?utf-8?B?QmFxMm92Y1lmOVVES3ZyQlcvRUtVbi8xbys5Y25mQkgzSzNBbEo2aS81NHIv?=
 =?utf-8?B?NU1FcFh1ZlM3WDFDUjEvQ2lFZG9kOW5PcEllNkljNFpQTFBsOHMxVFlKaHlU?=
 =?utf-8?B?MUFOUEd0dTdHR0I5bm83S1RaV2cyaEtDeGg1U0l3VUVqVSt3NDZFazBVM0k5?=
 =?utf-8?B?ZGJZSDFpMUhJS2ZMMTFwSWtuYTZ4S2hqOGFOYnhQbllZcUdkd0ZSZ01uKzNh?=
 =?utf-8?B?eEdEN00rbnQ4NVpyVmpmU3RIOThBQ2xTZ3V6QnU5L1F3QlNsbGxTcE0xdU9k?=
 =?utf-8?B?eStEeWRNY3g4Z0NrbVNSVGVQRGw5aklBbE1ZUTRTL2phVkFSWUVscS9VNFYw?=
 =?utf-8?B?cmFJRFRteXg5ZVo5cE5ackZGWThXd05wTytoMlZVaitYSXVoRXdsUDFBbFFz?=
 =?utf-8?Q?Soz6mX5wWqzmDvBBYEOpolMdETX9Orkc=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MmlGMjBybUJnRzJhTW0ySnhDWmNpK3orOUZsTmU0RExsazkyOVBwNDVHMWJk?=
 =?utf-8?B?S1Fsa0VRRVFvaW9UMnFjbG5CSXp3a2hYcndjanNZN21QYkZiUGhHUnVhb3dq?=
 =?utf-8?B?SlFISnlmdDJDUWtkOG5uQ1hFQzZPdkl2eEkwazlVRzZxL1lNN2Q4V1VaMy9y?=
 =?utf-8?B?YmR5bVNkQTFJTnBCc3dOYjhOQyt3eHdoRVZaMW0yaS9mbjhwWWovUmtGc3Z5?=
 =?utf-8?B?UVRIMWJPRFlMRER2bWlocVg5eTBSRlhEektrQXdwcStUeVA1SG1kbndaNUxa?=
 =?utf-8?B?U213V3B6QmEwdlA2L2NvS2ZLVW50UElRNzgvNWpJZEpEaC9pRnRGTVFlVE5m?=
 =?utf-8?B?WlNBYlZESy8rZnlBMTl0MzBkLzF6RW1BSXRhK2dVV0Q3enJIK1QyNTcveUY0?=
 =?utf-8?B?bHdvWExhMDhVVTlteno1VTd0YnZMRTRQSmsxZG9FWVRqVkd0WkMyNGZWcUpF?=
 =?utf-8?B?cFFaVlNLZjBWQjhaRUIzRTV5UzZJdldBWUhEYTFWREJhc1N3eGd1Nm5vTTdz?=
 =?utf-8?B?VU5PUUIvRTdxYW9jcUFLMUZLbDhqUTJMQVNRWXBMYUdBUGVzZEc0bHNJenB5?=
 =?utf-8?B?S0FyekFORjVWeUlZRm1uc05YYm03Q1hYaFRKSG5jZVVqUU0zd1ZZNHJ2SGN3?=
 =?utf-8?B?R2d6cUpKYlhQSU1LM1REK3JjMDdWVEtIeFoxd3EzM2I3cXNTRTdvbDlqZExJ?=
 =?utf-8?B?U3B5aXpiQWVWaE14WjIxdUs1a0NOc1dEc2NqQy93aUVaRkM2ZFBFajVKeGxI?=
 =?utf-8?B?QzE2dVpZSVpWTUlvcmVBblRwOExLWDhWYkJqUFJKa0tuYzJ0L0hmVXd1WnJu?=
 =?utf-8?B?WWVIT1gvOVlBcFhmOWp2amJFRjhxaVV0MGNPOUFFYnVVc3dPSHNQd2oxSWg2?=
 =?utf-8?B?ejZXVUJSZnVpcklxM1FRL3VmNVRDZjFRQVhEcHMyb2VjQTlrWGtIbGFRS2k3?=
 =?utf-8?B?dGVlZTdCaFcydnVjQStpVUlzR1htaUVRMVFUQVNVOHFTUmlKa0lnNTdrWmhp?=
 =?utf-8?B?OFppM3ZjMzlrTkwyOGdRa0FvczFRaitCUTA4bmxuR05wYnNpdDJRSHpBc3Az?=
 =?utf-8?B?V3U5WmdIbmU0aVV3NVluZGkyYkdTVmw1VnBuVHdJVGF1WnFQWkc0YXNzYUZP?=
 =?utf-8?B?dU9zNUJtZG5YbUlBcDNPeWxlZnNITndWRjlmVDdqYnBvSE9KbHZTSC9nQ1lm?=
 =?utf-8?B?QnBPWTNaSGVTVTI1Ylh1VTVuMWpEV0syb3g5bUF3M2lMZ254bmJvMHp5ZFhX?=
 =?utf-8?B?Y0JSMThzcVhZeHVQRTZUMXFzMUYveGVOZDlzWHYrb2hocG5rTEVTT2hNN1pi?=
 =?utf-8?B?bDdCakNwczJXOHh4d3ZwVldCVTVldnBXU1BRSVdUNzFZdXpDTmQvLzQxTEkx?=
 =?utf-8?B?VEtELy8vRXFYSUdUVnp1Q1ZrRmJkN05Qd3dnVTgrRitQZUczR29JOC9zeXU2?=
 =?utf-8?B?alhJT3Iwd3JGeS9KTDNFd2RvZzF0alQremVDRXptSWp2S0VSaGVNWWRTaE9x?=
 =?utf-8?B?aHhCeEhNaSsrMVhRUUYydTZibTVwSUM2cWt5dXY2TjFpWDVoTDZxOFppaEtn?=
 =?utf-8?B?bThRMXJpZHl4OXpYemtWYUFxL3VTaXNKaDl6ZGkwVjd4K1NQUml2YXdmSjcv?=
 =?utf-8?Q?il/qF5DmUEZGq/M1uCaDPi6ExOsHTruQrg/JioW0PF0E=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bf4d2510-9d72-4ab6-2174-08dd60222c10
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2025 22:23:24.0814
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR02MB10530

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBNb25kYXksIE1hcmNoIDEwLCAyMDI1IDI6NDcgUE0NCj4gDQo+IE9uIDMvNy8yMDI1IDk6
MzggQU0sIE1pY2hhZWwgS2VsbGV5IHdyb3RlOg0KPiA+IEZyb206IE51bm8gRGFzIE5ldmVzIDxu
dW5vZGFzbmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4gU2VudDogRnJpZGF5LCBGZWJydWFyeSAy
OCwNCj4gMjAyNSA0OjM4IFBNDQo+ID4+DQo+ID4+IE9uIDIvMjYvMjAyNSAzOjQzIFBNLCBTdGFu
aXNsYXYgS2luc2J1cnNraWkgd3JvdGU6DQo+ID4+PiBPbiBXZWQsIEZlYiAyNiwgMjAyNSBhdCAw
MzowODowMlBNIC0wODAwLCBOdW5vIERhcyBOZXZlcyB3cm90ZToNCj4gPj4+PiBUaGlzIHdpbGwg
aGFuZGxlIFNZTklDIGludGVycnVwdHMgc3VjaCBhcyBpbnRlcmNlcHRzLCBkb29yYmVsbHMsIGFu
ZA0KPiA+Pj4+IHNjaGVkdWxpbmcgbWVzc2FnZXMgaW50ZW5kZWQgZm9yIHRoZSBtc2h2IGRyaXZl
ci4NCj4gPj4+Pg0KPiA+Pj4+IFNpZ25lZC1vZmYtYnk6IE51bm8gRGFzIE5ldmVzIDxudW5vZGFz
bmV2ZXNAbGludXgubWljcm9zb2Z0LmNvbT4NCj4gPj4+PiBSZXZpZXdlZC1ieTogV2VpIExpdSA8
d2VpLmxpdUBrZXJuZWwub3JnPg0KPiA+Pj4+IFJldmlld2VkLWJ5OiBUaWFueXUgTGFuIDx0aWFs
YUBtaWNyb3NvZnQuY29tPg0KPiA+Pj4+IC0tLQ0KPiA+Pj4+ICBhcmNoL3g4Ni9rZXJuZWwvY3B1
L21zaHlwZXJ2LmMgfCA5ICsrKysrKysrKw0KPiA+Pj4+ICBkcml2ZXJzL2h2L2h2X2NvbW1vbi5j
ICAgICAgICAgfCA1ICsrKysrDQo+ID4+Pj4gIGluY2x1ZGUvYXNtLWdlbmVyaWMvbXNoeXBlcnYu
aCB8IDEgKw0KPiA+Pj4+ICAzIGZpbGVzIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPj4+
Pg0KPiA+Pj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMgYi9h
cmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMNCj4gPj4+PiBpbmRleCAwMTE2ZDBlOTZlZjku
LjYxNmU5YTVkNzdiNCAxMDA2NDQNCj4gPj4+PiAtLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L21z
aHlwZXJ2LmMNCj4gPj4+PiArKysgYi9hcmNoL3g4Ni9rZXJuZWwvY3B1L21zaHlwZXJ2LmMNCj4g
Pj4+PiBAQCAtMTA3LDYgKzEwNyw3IEBAIHZvaWQgaHZfc2V0X21zcih1bnNpZ25lZCBpbnQgcmVn
LCB1NjQgdmFsdWUpDQo+ID4+Pj4gIH0NCj4gPj4+PiAgRVhQT1JUX1NZTUJPTF9HUEwoaHZfc2V0
X21zcik7DQo+ID4+Pj4NCj4gPj4+PiArc3RhdGljIHZvaWQgKCptc2h2X2hhbmRsZXIpKHZvaWQp
Ow0KPiA+Pj4+ICBzdGF0aWMgdm9pZCAoKnZtYnVzX2hhbmRsZXIpKHZvaWQpOw0KPiA+Pj4+ICBz
dGF0aWMgdm9pZCAoKmh2X3N0aW1lcjBfaGFuZGxlcikodm9pZCk7DQo+ID4+Pj4gIHN0YXRpYyB2
b2lkICgqaHZfa2V4ZWNfaGFuZGxlcikodm9pZCk7DQo+ID4+Pj4gQEAgLTExNyw2ICsxMTgsOSBA
QCBERUZJTkVfSURURU5UUllfU1lTVkVDKHN5c3ZlY19oeXBlcnZfY2FsbGJhY2spDQo+ID4+Pj4g
IAlzdHJ1Y3QgcHRfcmVncyAqb2xkX3JlZ3MgPSBzZXRfaXJxX3JlZ3MocmVncyk7DQo+ID4+Pj4N
Cj4gPj4+PiAgCWluY19pcnFfc3RhdChpcnFfaHZfY2FsbGJhY2tfY291bnQpOw0KPiA+Pj4+ICsJ
aWYgKG1zaHZfaGFuZGxlcikNCj4gPj4+PiArCQltc2h2X2hhbmRsZXIoKTsNCj4gPj4+DQo+ID4+
PiBDYW4gbXNodl9oYW5kbGVyIGJlIGRlZmluZWQgYXMgYSB3ZWFrIHN5bWJvbCBkb2luZyBub3Ro
aW5nIGluc3RlYWQNCj4gPj4+IG9mIGRlZmluaW5nIGl0IGEgbnVsbCBwb2ludGVyPw0KPiA+Pj4g
VGhpcyBzaG91bGQgYWxsb3cgdG8gc2ltcGxpZnkgdGhpcyBjb2RlIGFuZCBnZXQgcmlkIG9mDQo+
ID4+PiBodl9zZXR1cF9tc2h2X2hhbmRsZXIsIHdoaWNoIGxvb2tzIHJlZHVuZGFudC4NCj4gPj4+
DQo+ID4+IEludGVyZXN0aW5nLCBJIHRlc3RlZCB0aGlzIGFuZCBpdCBkb2VzIHNlZW1zIHRvIHdv
cmshIEl0IHNlZW1zIGxpa2UNCj4gPj4gYSBnb29kIGNoYW5nZSwgdGhhbmtzLg0KPiA+DQo+ID4g
SnVzdCBiZSBhIGJpdCBjYXJlZnVsLiBXaGVuIENPTkZJR19IWVBFUlY9biwgbXNoeXBlcnYuYyBz
dGlsbCBnZXRzDQo+ID4gYnVpbHQgZXZlbiB0aHJvdWdoIG5vbmUgb2YgdGhlIG90aGVyIEh5cGVy
LVYgcmVsYXRlZCBmaWxlcyBkby4gIFRoZXJlDQo+ID4gYXJlICNpZmRlZiBDT05GSUdfSFlQRVJW
IGluIG1zaHlwZXJ2LmMgdG8gZWxpbWluYXRlIHJlZmVyZW5jZXMgdG8NCj4gPiBIeXBlci1WIGZp
bGVzIHRoYXQgd291bGRuJ3QgYmUgYnVpbHQuIEknZCBzdWdnZXN0IGRvaW5nIGEgdGVzdCBidWls
ZCB3aXRoDQo+ID4gdGhhdCBjb25maWd1cmF0aW9uIHRvIG1ha2Ugc3VyZSBpdCdzIGFsbCBjbGVh
bi4NCj4gPg0KPiBUaGFua3MgTWljaGFlbCAtIEkgZG9uJ3QgdGhpbmsgaXQgd291bGQgYmUgYW4g
aXNzdWUgc2luY2UgdGhlIF9fd2VhayB2ZXJzaW9uDQo+IHdvdWxkIGJlIGRlZmluZWQgaW4gbXNo
eXBlcnYuYyBpdHNlbGYsIHJlcGxhY2luZyB0aGUgZnVuY3Rpb24gcG9pbnRlci4NCg0KWWVzLCBz
b3VuZHMgcmlnaHQgdG8gbWUuDQoNCj4gDQo+IEhvd2V2ZXIsIEkgd2VudCBhbmQgdGVzdGVkIHRo
aXMgX193ZWFrIHZlcnNpb24gYWdhaW4gd2l0aCBDT05GSUdfTVNIVl9ST09UPW0NCj4gYW5kIGl0
IGRvZXMgbm90IGFjdHVhbGx5IHdvcmsuIEV2ZXJ5dGhpbmcgc2VlbXMgb2sgYXQgZmlyc3QgKGl0
IGNvbXBpbGVzLA0KPiBjYW4gaW5zZXJ0IHRoZSBtb2R1bGUpLCBidXQgdXBvbiBzdGFydGluZyBh
IGd1ZXN0LCB0aGUgaW50ZXJydXB0cyBkb24ndCBnZXQNCj4gZGVsaXZlcmVkIHRvIHRoZSByb290
IChvciByYXRoZXIsIHRoZXkgZG9uJ3QgZ2V0IGhhbmRsZWQgYnkgbXNodl9oYW5kZXIoKSkuDQo+
IA0KPiBUaGlzIHNlZW1zIHRvIG1hdGNoIHdpdGggd2hhdCB0aGUgbGQgZG9jcyBzYXkgLSBUaGVy
ZSdzIGFuIG9wdGlvbg0KPiBMRF9EWU5BTUlDX0xJTksgdG8gYWxsb3cgX193ZWFrIHN5bWJvbHMg
dG8gYmUgb3ZlcnJpZGRlbiBieSB0aGUgZHluYW1pYw0KPiBsaW5rZXIsIGJ1dCB0aGlzIGlzIG5v
dCBlbmFibGVkIGluIHRoZSBrZXJuZWwuDQo+IA0KDQpZZWFoLCBJIHJlY2FsbCBsZWFybmluZyB0
aGUgaGFyZCB3YXkgdGhhdCBhIHN5bWJvbCBkZWZpbmVkIGluIGEgbW9kdWxlIGRvZXNuJ3QNCm92
ZXJyaWRlIGEgX193ZWFrIHN5bWJvbCBpbiB0aGUga2VybmVsIGltYWdlLiBBdCB0aGUgdGltZSwg
SSBnYXZlIHVwIGFuZCB0b29rDQphIGRpZmZlcmVudCBwYXRoLCBhbmQgZGlkbid0IGdldCBhcyBm
YXIgYXMgbG9va2luZyBhdCAnbGQnIG9wdGlvbnMgbGlrZSB5b3UgZGlkLiA6LSkNCg0KTWljaGFl
bA0K

