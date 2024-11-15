Return-Path: <linux-arch+bounces-9112-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D71E9CFA6D
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 23:53:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 016E2B3E4C5
	for <lists+linux-arch@lfdr.de>; Fri, 15 Nov 2024 22:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71799202F8D;
	Fri, 15 Nov 2024 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="duRMFPaJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11olkn2055.outbound.protection.outlook.com [40.92.19.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD651FF05F;
	Fri, 15 Nov 2024 21:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.19.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731707660; cv=fail; b=XelTVaFodj2zj75lwrXcp3iQqOmB6KP47QZpZniUcRhI2OdYUeE6IXODpffjOsZ3v5WPIvqxdSpjcmXswV281cf//fx2N2UXVBsR6jMdsskmD4eJPE2xsDESnZrqcyfoMPf8n0i6fr5/1Je202KWs04g/Tn/ZCXHMbyJ3ZqYFEk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731707660; c=relaxed/simple;
	bh=OfAyidTgmnbKRVkYGEaFjQIIgjNw/dUA8oq/F4nKTVU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PXLDLBs/KLbpIZ3xk/U6/dR/c87KaNGAdju4P1yMPmWnOJx7WhEVZ8W773X92DqjhNeNY1/jab9jG3YnHUauxWZKVAhX2zkGWhNaBVHN7JvDhM112rrhb7CCGjZ1znU61ymOQGJKFY5fWhHFHsNwHxr8GhLIQXknSrv1d8ByAys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=duRMFPaJ; arc=fail smtp.client-ip=40.92.19.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJ0urfyn4LoGFKpM8nEm0ge4aNMWtQg8Hz2AeVJUhOGWgLXWvcH4cbDSuE31qifp62t4clv4E8YId5c7zIfNoviDKzgC5VVQ8KKPoeTKQOYk0/zag5U8wHhd5eB54nLlk59bjkzkI7gj0FFmfC6bc9zPYVuhzxUw/EuNzNXg2KSv+3s1guh60k/pwiDDzZmNlBxWzb74SY/rPdbnF7txXPWYqg+29T4Nf1tf/iSrO+tKUqFZmJZLuvov/DoRmIMa4UCdcVAj/Cro2fy8S4EA01ZdZN0Eu9jzUfCEQ1NiM0+E2fJpmZnZMYX5s87P3P44WKkih0D27Kj5jNqyoFHvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OfAyidTgmnbKRVkYGEaFjQIIgjNw/dUA8oq/F4nKTVU=;
 b=Gha1ESba3xrdhCTPm+Ieil4AYReZpaOrXSKmhNi0KAdCjDCalN6Imo8iyYkF6v3hmoZ3Um8o8stM60jV+MeXGGobtepvblMy/jJlMg9HRcWpXu6wHpe2cHNjIVXo9ZfpwLcHuSkFEVpb9WHxRzS/MAOzn3749h4CnE2yEM7YHYPtLC1NHSA8DM078ppJiuypj/IJIxnhWXKOfz63PYp0+3Q6SAPHtjctGGuEEmPuVN07MbqsOCTfOu5prYxfSOVGxIPcPmZ8seLA5/e2EVUscqEiAx8e0veXJTGeXdjl3w9hmGZPmrLgW8/GXwN8HW281YMyoivz02UyUqv0oxPk2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OfAyidTgmnbKRVkYGEaFjQIIgjNw/dUA8oq/F4nKTVU=;
 b=duRMFPaJ7DcJuhefavE5+iJpkmzg9ygKeX5C2OxTYemt69QxsCygyeBFci7jI+kdD+2qYpTeR6jU7R+hF2QS0YJB59S11z6Zfd1ZSDAWUMPJuKWfJjpDg8DAg0UHxMUNj2f7fLgmDf0qJw/eOLOJhqKqneg6rV8953Si8cW8K2pfZwZvjoHS10qGknnKuXazpkj2+S96rIn/6zL+jh1K2n4sGSpIg495zuyJT5fbQeAcw/cl5O6fEJxoR5kV0RwydKWRCZeD/AKnzk/TPtoaeedC60U4YA0NE4yqpYH4881yMTkqQvJWaKAkEzc0KjGJbooMPAQsAhB2eTyaMtdp3g==
Received: from SN6PR02MB4157.namprd02.prod.outlook.com (2603:10b6:805:33::23)
 by SN4PR0201MB8839.namprd02.prod.outlook.com (2603:10b6:806:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Fri, 15 Nov
 2024 21:54:15 +0000
Received: from SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df]) by SN6PR02MB4157.namprd02.prod.outlook.com
 ([fe80::cedd:1e64:8f61:b9df%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 21:54:14 +0000
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
Thread-Index: AQHbMWTxGjBzpDHZ/kaAtNrAPYWf6LKvtKFggAkvZwCAAAobgA==
Date: Fri, 15 Nov 2024 21:54:14 +0000
Message-ID:
 <SN6PR02MB4157DE83D677F2E463774393D4242@SN6PR02MB4157.namprd02.prod.outlook.com>
References:
 <1731018746-25914-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1731018746-25914-5-git-send-email-nunodasneves@linux.microsoft.com>
 <BN7PR02MB4148513F8ABA50392E11C616D4582@BN7PR02MB4148.namprd02.prod.outlook.com>
 <e832dd94-04f3-413a-a1a9-870849b4bc53@linux.microsoft.com>
In-Reply-To: <e832dd94-04f3-413a-a1a9-870849b4bc53@linux.microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR02MB4157:EE_|SN4PR0201MB8839:EE_
x-ms-office365-filtering-correlation-id: d7ee0d92-ccb2-4ea9-d988-08dd05c00bdc
x-microsoft-antispam:
 BCL:0;ARA:14566002|8062599003|15080799006|8060799006|461199028|19110799003|102099032|3412199025|440099028;
x-microsoft-antispam-message-info:
 =?utf-8?B?b2Y1bEdGSUtrNnpxTUE2Qm1OMS9oMXV1WkdjSWlCeXVMU2M1SVVIa0ZNV0pE?=
 =?utf-8?B?YjRZTzhoTTVPUGp1bGJWVUJrcDBMN3NUcU5UdktZYWVPaWV6UlpTczRzT1Rh?=
 =?utf-8?B?cjk3djZqZVZLMkwvWC9PVklwdUNKNk9BRUwrblJVOEg1eURmL2FaUlp5djFL?=
 =?utf-8?B?dHE5WDdzdVU0YnRHRWNpbVl5Q01HNWZxRmthdjlNc3VWanFEV2dkR0VYVmFE?=
 =?utf-8?B?enl5RUVEaXBYSjJoS2V6TWpvK2VEYmYzVlg4cmtpdDI4N2p4ZERsWitwYnhH?=
 =?utf-8?B?TUcrUG5NZ2ptbGdyLzd0ekljQkl6VjNGS0t1RGwyOHpHazFSZ0VWTWh5OVlk?=
 =?utf-8?B?YXVSTVY2bHhLbjl2Z2ZFcUthcXE1aHVwWmlaU3prWWM2ZHREc2tKTzdrV1RY?=
 =?utf-8?B?NnRJTFlEMlBteTV5MllYZElWRThnQ1NTdHVkTC82ZmxXdTA2aTk3NUFwSmNY?=
 =?utf-8?B?L2JNdzg0UXRVcEtJZjFsY0NYSXpnS2IvU1NDY2hvNzEza1pIZEp2bWxUUnJu?=
 =?utf-8?B?dG9qMDNWdVdrRFF4YjVTbkE3UU1OdytzK01yWk84cTdhK2RpR3RFWnhFSUpX?=
 =?utf-8?B?YjlzUk9TUFBHNklHd3Y4b0tMdHMrVlFqUUczUy9ubWQxcmJic1BmQzZIN3lE?=
 =?utf-8?B?RE1mSDdWN0FhN3BVSDZFc0dZejVDVWI4djNRR25wZ0RXMlpkSytVTGFRUThs?=
 =?utf-8?B?QUxrcjlyZGFVL0dJanV3NHlTTXFhMnFxUmlyU2VnS0xYRTg5ODJ5M3VJbzdM?=
 =?utf-8?B?V2tLdFhiQlZSeGtWcWdLbzU2anRVNmFNNWZMVGRjL1J3bWxtNUlaZWtEZHpN?=
 =?utf-8?B?bWVXL3pxbFMrTzRCZ05NSjhkaGJqcUU2NmtNQ1kweU1iRzc4cUlJK3Zhc0ww?=
 =?utf-8?B?R0xOVXd2b1M2eElFd0xaMFkyRmJsaXFrNVRNTHUvY1RaeDh4TjI0VmJrTlNT?=
 =?utf-8?B?UTMxbmQ0ZHdzR1BaWDY4VlkwcXVYdldkcnUvTGplTHFXRVBhN1h5RXFORndz?=
 =?utf-8?B?dG1ZZTZJcm41WDVjd25ZZUQrT0lFMkhmZGpDR3d0T3BsL2QvUTlRL3JIdWVu?=
 =?utf-8?B?MGZrT1dsTTJ2TXgrbVQweTFHY3JHcEJUTzFSMUd5c2JxWXRBaWxJYW1rQjlX?=
 =?utf-8?B?TTNCOE5jdWgzMHErVHZoeG15L2Rwb253TzROeHZ5bUdMNnk3Qm1Zekx5UVMr?=
 =?utf-8?B?czFsaUpJVktvbXBHWW9wNk1PUTdBZm1zc0Q2N0drQUN3TXdpZDg3RnJXTnRz?=
 =?utf-8?B?ZXFjblU2bE84Z3I5YzU4OTBiOUZsVUtYZEdsZVVJaGxMQnRCcGJaTkk1ZlhV?=
 =?utf-8?Q?G3eNHu8u1cue+vMbP7WT9AJUFG+CDXz5iU?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dmpxd0JOL1NqOXhNY0lPQlNwVG1QMWcrZUUwZVVFM210YTdGMlh2WG03cEpF?=
 =?utf-8?B?cmlIMHBIWVdjODQxaEZ4QkpvcGVMc0JvTWJDTWlBZTdGM3E4OXkrWFVhdGdB?=
 =?utf-8?B?SnF6ZTQzeUZwZU02b2dMb2dieFZ6UlpueW8za3U5SjY2MUlDb29ET1ZpcjM0?=
 =?utf-8?B?Y1RWTHp3MVZud3dFT3E1cmQ5Y2xKdUpxc3hsbzZPSlRDdmo4NjZOeWN4Z0N0?=
 =?utf-8?B?ZTlMMlhxcFJFOWFnQWlnOFJEZllkV2V5d0hqRHFCRW5MeGJ1K0hzMlpLRFha?=
 =?utf-8?B?RTNaQnR1SG5ISW83VEtDVEhBdG9oanhHa1lWbXh2ZEtTVEplbEtlYVNlb2p2?=
 =?utf-8?B?ZkhYZkdNSlUzVUFML3VOOUJrNUdESExZajlaejhCZFV6WHNGbkM1NHBSbUts?=
 =?utf-8?B?U0NyWStSa3VlL0xWT3lFZ0xyd2RWalF6eXlLVDVUOTBoUFV0L3BDV05PZHVt?=
 =?utf-8?B?TE1DVTBmQUtiZXRuM3lBSm9hN0JEMFd4ZW5KZFo5YzVuWUZSeVR5RmM3RnBx?=
 =?utf-8?B?OWVXajNQQ0E4UmV0QUdpOXE5SFRNcGlCQUowY2F2MjZvRkJpU2tiUnhzWm50?=
 =?utf-8?B?dFNYekIzYkVrY1hJbXcwYzN3bXNMUmFIcUo2ZHhiYzV6OXpSQnBJckdIUUVQ?=
 =?utf-8?B?UHBXZmFMV0tueGdWdE5WVzNaY0MzejVUN1gxSzZIRml1M0J5WXQxb2E4bi8x?=
 =?utf-8?B?RGxpY2FjMXRnNk9XUE81a2U2ZVo0ODFPcnFnUUN0T0YwREJMelBGdElqRUhG?=
 =?utf-8?B?U1NCSzJLVWFjM29CeW9jMklaWktaZ0xPd0ozYkVQQ3JQL2ROaWFIZ2w5Z0VR?=
 =?utf-8?B?Q2ROdG9oNjc5NzB0dmZ5blduZjUyeXpiQzNKdithYTVKU3lKQWNhc2NJS2RM?=
 =?utf-8?B?eWNMa1dHKzVvZnlWMmJrR2Y2MHZ2eE5LVmhnSGVHc0dsYTNab2xwNlRLYzc1?=
 =?utf-8?B?c2htbmx1QUFpc2UxWVlXNFVhUno0ZnppRzNERjJvbzlERDBKeVU3cXowNU9B?=
 =?utf-8?B?VHNXZW8zblNSZ2l1NnJKdW83WjlRTEI0YWIxdkZCRVBwQzR4eFJrUGdRazJS?=
 =?utf-8?B?VVVKUzU1aHFMYXNGZC9JY0drbGZTNU9nNWd6WEFqVFBkM09mdGhsbXI0emRN?=
 =?utf-8?B?djBya21oWEp4enJ1RFczNmpPc00yOGo1M1BYNHVlR1laemZhNlZVTkZXN3Ft?=
 =?utf-8?B?SkJ2UnN1Tm14aEgzUGhHcnUvVTdRRmhFbFp0UkRvWnBVN2hKZ2Z5emRjYis2?=
 =?utf-8?B?Q2lSdDFoTysrencyOEh0bEc4WXhWdm0wNUxvR1lPRUZvTmRhbHhoMjJieDN2?=
 =?utf-8?B?L2ZQU1krYzNrNXRaRTI5UmswckFYakd5YUcvQXhnQUpGM0hyV1huaktIVlZB?=
 =?utf-8?B?cDEwZ2pheERqcHk4RldzT2xYZzhTZDlhaVJvUDlyRHplTzN1N1dQeFN0Skl6?=
 =?utf-8?B?MXlJdUdHc0VnZ3M2Mi9HcFoyWVk2NENyenZxNHdHUkdZL2tUV1lJaFpsK0pl?=
 =?utf-8?B?aDdHYmxKU25sSU1WbVVEa1VXWGs5WTA1RUhTTkY2MW5VUk05MG5IMExyV0RH?=
 =?utf-8?B?MERTUlBzSzhLdkRnZG5zUnJqc2NERXc5Y3JlRHpzL25mMVJ3M3NjQ293UUZT?=
 =?utf-8?Q?CsYUzqXgu45J8CdG2HN4ly+YrAfXqjVJAkuIFCkaU+P8=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4157.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d7ee0d92-ccb2-4ea9-d988-08dd05c00bdc
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 21:54:14.7246
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB8839

RnJvbTogTnVubyBEYXMgTmV2ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBT
ZW50OiBGcmlkYXksIE5vdmVtYmVyIDE1LCAyMDI0IDE6MTUgUE0NCj4gDQo+IE9uIDExLzEwLzIw
MjQgODoxMyBQTSwgTWljaGFlbCBLZWxsZXkgd3JvdGU6DQo+ID4gRnJvbTogTnVubyBEYXMgTmV2
ZXMgPG51bm9kYXNuZXZlc0BsaW51eC5taWNyb3NvZnQuY29tPiBTZW50OiBUaHVyc2RheSwgTm92
ZW1iZXIgNywgMjAyNCAyOjMyIFBNDQo+ID4+DQo+ID4+IFN3aXRjaCB0byB1c2luZyBodmhkay5o
IGV2ZXJ5d2hlcmUgaW4gdGhlIGtlcm5lbC4gVGhpcyBoZWFkZXIgaW5jbHVkZXMNCj4gPj4gYWxs
IHRoZSBuZXcgSHlwZXItViBoZWFkZXJzIGluIGluY2x1ZGUvaHlwZXJ2LCB3aGljaCBmb3JtIGEg
c3VwZXJzZXQgb2YNCj4gPj4gdGhlIGRlZmluaXRpb25zIGZvdW5kIGluIGh5cGVydi10bGZzLmgu
DQo+ID4+DQo+ID4+IFRoaXMgbWFrZXMgaXQgZWFzaWVyIHRvIGFkZCBuZXcgSHlwZXItViBpbnRl
cmZhY2VzIHdpdGhvdXQgYmVpbmcNCj4gPj4gcmVzdHJpY3RlZCB0byB0aG9zZSBpbiB0aGUgVExG
UyBkb2MgKHJlZmxlY3RlZCBpbiBoeXBlcnYtdGxmcy5oKS4NCj4gPj4NCj4gPj4gVG8gYmUgbW9y
ZSBjb25zaXN0ZW50IHdpdGggdGhlIG9yaWdpbmFsIEh5cGVyLVYgY29kZSwgdGhlIG5hbWVzIG9m
IHNvbWUNCj4gPj4gZGVmaW5pdGlvbnMgYXJlIGNoYW5nZWQgc2xpZ2h0bHkuIFVwZGF0ZSB0aG9z
ZSB3aGVyZSBuZWVkZWQuDQo+ID4+DQo+ID4+IGh5cGVydi10bGZzLmggaXMgbm8gbG9uZ2VyIGlu
Y2x1ZGVkIGFueXdoZXJlIC0gaHZoZGsuaCBjYW4gc2VydmUNCj4gPj4gdGhlIHNhbWUgcm9sZSwg
YnV0IHdpdGggYW4gZWFzaWVyIHBhdGggZm9yIGFkZGluZyBuZXcgZGVmaW5pdGlvbnMuDQo+ID4N
Cj4gPiBJcyBoeXBlcnYtdGxmcy5oIGFuZCBmcmllbmRzIGJlaW5nIGRlbGV0ZWQ/IElmIG5vdCwg
dGhlIHJpc2sgaXMgdGhhdA0KPiA+IHNvbWVvbmUgYWRkcyBhIG5ldyAjaW5jbHVkZSBvZiBpdCB3
aXRob3V0IHJlYWxpemluZyB0aGF0IGl0IGhhcyBiZWVuDQo+ID4gc3VwZXJzZWRlZCBieSBodmhk
ay5oLg0KPiA+DQo+IA0KPiBJIHdhcyBoZXNpdGFudCB0byBkZWxldGUgaXQgYmVjYXVzZSBJIHRo
b3VnaHQgc29tZW9uZSBtYXkgc3RpbGwgaGF2ZQ0KPiBhIHVzZSBmb3IgYSBoZWFkZXIgZmlsZSB0
aGF0IChtb3N0bHkpIHJlZmxlY3RzIHRoZSBUTEZTIGRvY3VtZW50IGFuZA0KPiBub3RoaW5nIG1v
cmUuDQo+IA0KPiBCdXQgaW4gcHJhY3RpY2FsIHRlcm1zLCB0aGlzIHBhdGNoc2V0IG1ha2VzIGl0
IG11Y2ggbW9yZSBkaWZmaWN1bHQgdG8NCj4gdXNlIGJlY2F1c2UgYWxsIHRoZSBoZWxwZXIgY29k
ZSAoaS5lLiBtc2h5cGVydi5oKSBub3cgdXNlcyBodmhkay5oLg0KPiBTbywgbWF5YmUgdGhlcmUg
aXMgbm8gcG9pbnQga2VlcGluZyBpdC4NCj4gDQo+ID4gTm90ZSBhbHNvIHRoYXQgdGhpcyBwYXRj
aCBkb2VzIG5vdCBhcHBseSBjbGVhbmx5IHRvIDYuMTIgcmMncywgb3IgdG8NCj4gPiBjdXJyZW50
IGxpbnV4LW5leHQgdHJlZXMuIFRoZXJlJ3MgYW4gdW5yZWxhdGVkICNpbmNsdWRlIGFkZGVkIHRv
DQo+ID4gYXJjaC94ODYvaW5jbHVkZS9hc20va3ZtX2hvc3QuaCB0aGF0IGNhdXNlcyBhIG1lcmdl
IGZhaWx1cmUNCj4gPiBpbiB0aGF0IGZpbGUuDQo+ID4NCj4gDQo+IEkndmUgYmVlbiBkZXZlbG9w
aW5nIHRoaXMgc2VyaWVzIGJhc2VkIG9uIGh5cGVydi1uZXh0LiBTaG91bGQgSSBiZQ0KPiBiYXNp
bmcgaXQgb24gbGludXgtbmV4dD8NCj4gDQoNClllcywgYmFzZSBpdCBvbiBsaW51eC1uZXh0LiBo
eXBlcnYtbmV4dCB3YXMgbGFzdCBzeW5jJ2VkIHdpdGgNCnVwc3RyZWFtIGF0IDYuMTEtcmM0IGJh
Y2sgaW4gbWlkLUF1Z3VzdCwgc28gaXQncyBwcmV0dHkgZmFyDQpvdXQtb2YtZGF0ZS4gV2VpIHdp
bGwgbmVlZCB0byBzeW5jIGl0IGJlZm9yZSBwaWNraW5nIHVwIGFueQ0KbmV3IHBhdGNoZXMuDQoN
Ck1pY2hhZWwNCg==

