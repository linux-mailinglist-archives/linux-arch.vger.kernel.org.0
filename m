Return-Path: <linux-arch+bounces-13746-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79F1B9902B
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 10:59:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A01B170F21
	for <lists+linux-arch@lfdr.de>; Wed, 24 Sep 2025 08:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABFA2D0C68;
	Wed, 24 Sep 2025 08:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wuVmNxdo"
X-Original-To: linux-arch@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010041.outbound.protection.outlook.com [52.101.46.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134932557A;
	Wed, 24 Sep 2025 08:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758704380; cv=fail; b=mIvegV+DsxRMhHNVYal4KhwTDFGKmfNSh3tgHujUGkU1YZtfCBlFwgRhdzH2TOUqlYGDaNV8sD9M9Aiqjp5ZhM9nEVrzB+7/AgpNL8AJHl0OAPLU9GQGNWBXuxBz7cFKlCF63NziSuJV7BsqTtnJ5m1JWvGA5hvK/I59x1sXZDU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758704380; c=relaxed/simple;
	bh=sxzTpURxCJzedh8/w9kDSbK4q3jHL3iy6gKelpt6/Ak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JpGwFKgjW9O2Wofj3cg/7fKugnUs7YwRXGwhBPoNmZ8i90MkskhdCb6H33fHxInqmImaOloVNPjQiA3Ax/083Vc6YVhKM90YXYxK7Z8riYYTYGWH2BNk4OaYQO9YJEBFBTM4fBJg5LpsKNPVroXVkIvQu13DGpDBBTyOJlvVw2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wuVmNxdo; arc=fail smtp.client-ip=52.101.46.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zAxGqNplE673BT2/ll9nCPYLoqRG+jaRYBHRyctr7p35qsBSvvO796PS9hNBJ3H6solfoznKuXB60+iNmkXyUbUUibw/cfoy6IT2icWoTGc4dCSkO94MSs7ZiFY21qGcLWhXnk4Inxm6gNOwxeXwS7OcFuFMYa64PirHrMJ7EttE3v0yozK8UHZtLQk992Lyd2hfvYFa1ZJvKnzobF9B5Ackv2iPHiKSiZBgjkvNkZSXskU4jKwmrCKVEU8wWT25u4EJnAMMPAnsK9d8/occr/oKuBMn3Z+FtjCUxlX8s5A8HgTDqV2FiBuacceccIJhjRSa9JsHwYHIkrrrIBTU3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxzTpURxCJzedh8/w9kDSbK4q3jHL3iy6gKelpt6/Ak=;
 b=iDFTtCSyO8XCbYiKVB21EnrFtIkJnksRoaCSEOFvAyGdg6upvmWaNVHblUf52w0ADtewa8o/196QkajRJCus3HQtj+hv8zaIhu/MqtVI6/CPwJO0XTexU1zgqB1hZEm+JJiwD9yQTS/oiv8JkRsHYFXbxcippMafoCh6qVboy2z6RXtOIZ9BFt/ZXERHbOacCsOVgXUprwJemO3f5585dRbazUMBz0985es5OiVv5TVIYoIqWCJziJGybZMUEfFjseYTVodgdL9ZlVRMK43OdPmr8rSehLlXpbIdawGd+CW+NoXWUnV7KOYatieLBxsN6lMAQunCOSp5kNlWQQLK1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxzTpURxCJzedh8/w9kDSbK4q3jHL3iy6gKelpt6/Ak=;
 b=wuVmNxdoTmKR5CzmJimjNbEVP3aPyaOK2mBCfY8HNswM5ofrmOzghjn9CvO01K3MAejaCkanHKpmpamQjHiWFHNrMraL0rkDE7FrlAH0yWv68LFG5PPmMkzqgVjZL3m7ejZL9Y56D2uDKmZjgk09xJssZ22b+JsXiXISxsiXSpY=
Received: from DM4PR12MB6109.namprd12.prod.outlook.com (2603:10b6:8:ae::11) by
 CH3PR12MB8332.namprd12.prod.outlook.com (2603:10b6:610:131::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Wed, 24 Sep
 2025 08:59:34 +0000
Received: from DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1]) by DM4PR12MB6109.namprd12.prod.outlook.com
 ([fe80::680c:3105:babe:b7e1%4]) with mapi id 15.20.9160.008; Wed, 24 Sep 2025
 08:59:34 +0000
From: "Guntupalli, Manikanta" <manikanta.guntupalli@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, "git (AMD-Xilinx)" <git@amd.com>, "Simek,
 Michal" <michal.simek@amd.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Frank Li <Frank.Li@nxp.com>, Rob Herring
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, =?utf-8?B?UHJ6ZW15c8WCYXcgR2Fq?= <pgaj@cadence.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"tommaso.merciai.xr@bp.renesas.com" <tommaso.merciai.xr@bp.renesas.com>,
	"quic_msavaliy@quicinc.com" <quic_msavaliy@quicinc.com>, "S-k, Shyam-sundar"
	<Shyam-sundar.S-k@amd.com>, Sakari Ailus <sakari.ailus@linux.intel.com>,
	"'billy_tsai@aspeedtech.com'" <billy_tsai@aspeedtech.com>, Kees Cook
	<kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Jarkko
 Nikula <jarkko.nikula@linux.intel.com>, Jorge Marques
	<jorge.marques@analog.com>, "linux-i3c@lists.infradead.org"
	<linux-i3c@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Linux-Arch <linux-arch@vger.kernel.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
CC: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>, "Goud, Srinivas"
	<srinivas.goud@amd.com>, "Datta, Shubhrajyoti" <shubhrajyoti.datta@amd.com>,
	"manion05gk@gmail.com" <manion05gk@gmail.com>
Subject: RE: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Thread-Topic: [PATCH V7 2/4] asm-generic/io.h: Add big-endian MMIO accessors
Thread-Index: AQHcLKFYs7kre3e43EuQ9LsQHTc3m7ShGSCAgADudtA=
Date: Wed, 24 Sep 2025 08:59:33 +0000
Message-ID:
 <DM4PR12MB610982CB7D66D9DEF758188E8C1CA@DM4PR12MB6109.namprd12.prod.outlook.com>
References: <20250923154551.2112388-1-manikanta.guntupalli@amd.com>
 <20250923154551.2112388-3-manikanta.guntupalli@amd.com>
 <cde37e36-4763-48ca-a038-4a19eb1ef914@app.fastmail.com>
In-Reply-To: <cde37e36-4763-48ca-a038-4a19eb1ef914@app.fastmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Enabled=True;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_SetDate=2025-09-24T08:52:31.0000000Z;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Name=Open
 Source;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_ContentBits=3;MSIP_Label_f265efc6-e181-49d6-80f4-fae95cf838a0_Method=Privileged
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB6109:EE_|CH3PR12MB8332:EE_
x-ms-office365-filtering-correlation-id: 5f7f2ae2-75af-4dc1-96fd-08ddfb48ae74
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|921020|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?bnc0ZU11bVBPbzljOThibGJvZXNkVHh1dVRhblo1bGNsaUZtRXdJY2hHeWZF?=
 =?utf-8?B?Q0RVVk54bm1udURjMU5Mb0hRYXBySHRtMzNZQ3NselVPUFV0dyt1TDVtQVN1?=
 =?utf-8?B?NGFhTzgxaS96NlN2bmFpWmloeFNmMTluVmVSbVBtcmM1bzcyeVBPVFZkSWFE?=
 =?utf-8?B?emkwUWNlQzFRUWxrSUw0YTFVb3ZlTHJCd0xIVzJGZHgrQkN6bFhPTXhwZlBO?=
 =?utf-8?B?K0FKNnNuNGQvaXhhYTFpY090YzFJZkpOcFdmT0RWakpmQkVMZmFsRUh4aTlv?=
 =?utf-8?B?TGIrN1RQRHR6WC95TmJJMFlzeEJrMmtqOEJxRitxVVNBVXZRaXRNNXQ0VXl0?=
 =?utf-8?B?VldMbHkwcUc5R2FSd3lrUkxFMHVCendVd1lyUFkzTTlFWUhQUEtVM2FBWEth?=
 =?utf-8?B?VFFZRWVzMm1oUjlCNllaSHdWa2FDcy85UGJxdXl2S2hWeWU0U3kzdW4rdTlY?=
 =?utf-8?B?WXF3aTF0SUZ4VHA4am1HSWYvczJvMlVZSjExSXRidzBKZ3NRNkNqbGpUOXNm?=
 =?utf-8?B?emY4Uy9KRFdsMFlhREdCQlF5RDdBdGRhUkQ2V1VFbE5UdCtzRUJKZWFEdnNO?=
 =?utf-8?B?Z1lZc05qQjBEUFhWSE5HdnJ2aFdycDVEZDlhTlFSdXB1cnJ2N1BBdHg3bEIz?=
 =?utf-8?B?UlM4K0tXVlFpaUhETFI4azViN1NhbWx2elptSzIyWW1uN3cyU0lzRHJ1Z2ov?=
 =?utf-8?B?Z09sZ3EwaWpFakFIVDJmMFc3YWtFcHRCcVpTbXdpYS9zS2UxZWQyTHUzRDE2?=
 =?utf-8?B?WEp1cXVsbXBhT2Y5eC9uOVZBR3lIWjhlenlMaUlOSDlKZnhhOXJsUUNuY2U0?=
 =?utf-8?B?cllxQVFOdzJtcFJrQWQvNXRqQWpoOG4vajFpYjRmVGJwUExLLzI5T2pOZlQz?=
 =?utf-8?B?QjcvdFN3Mi8wTERiUVJhbkJMY2ZKTmFXTnRmMGFIM0Y0L2N2bFFxQWFZQ2dV?=
 =?utf-8?B?QjFpM28wUCsvSnlKbkpIOTFYdjlnYjFBS3BqSXM0SEduSWZPVmx0ZnZEcjNW?=
 =?utf-8?B?Z1FBRmJBUDl1bkhkRlphM3E3LzN6ajN5UDBzRHpVMU5NdGJ3dCtsQkRYT0RU?=
 =?utf-8?B?anFJTkdQMVFTcEpTbDcxRDFnRzJKUUxjSFdXbU94OVU3WFBqWkdKK1pzd1Mx?=
 =?utf-8?B?TTlnbnlFUEw5RVkwaE5nNG14SGZodDVMbThncEp0S09uVE56cEhEb2Fxdmt6?=
 =?utf-8?B?UFZTa0NONjNJOHFNcmtRbnZRU3pYTHB3RXd5SzBja2g3MVV6VFBVMW1HSnpy?=
 =?utf-8?B?c1hielU5aDc5M2RoVHNHaS9uT1BiOXlmUHRIMUlONytBb3U4MjZJZkM0TU1n?=
 =?utf-8?B?SFErVml6YnVTNUxDNVVwelFUWkdnYTJqR0RJNFA5bGs5Ny9wWXFuWjRNVjZQ?=
 =?utf-8?B?Yi9abkV5ajIyek5TNERhd3lxUmZ6TlRHODJnWExvR1BYdE9oRFZpQmRLMjZw?=
 =?utf-8?B?NURIMmxJUGIzVTYrZWhLczRvRWMzSHl2bmJwZ2xmMnNIUUZXcnU0YXFRMS9G?=
 =?utf-8?B?RXduaXJ5VmRaSGFzZldCaTRTUWRJUzFwM3cwOVRTdjIzbDd4QTF2VDFTTWl1?=
 =?utf-8?B?OVVzSXBzT3Y0dHlOVHJORGpFQ3JiWGR0ZTREZW9zdGM0QkNpRHJJaEtBMElk?=
 =?utf-8?B?a243OXViUGEvYmRDeHVPWkpjRHdyUzhJVUh0ZlU0Ry9GRjlXWm40ZTRjdU1y?=
 =?utf-8?B?NlI1c0ZZRTg4TFlKRU5JZ1RpVnRmTWhxSzVHRXBoeVg4U2VpQVM5WDJhSllR?=
 =?utf-8?B?Zm56TlczVnUrTi9FbXRGUis1S3k4NVk4cS9DS1N6Q2RHdVJuM3Z3MFAwcyti?=
 =?utf-8?B?K2hWLzNmUkI4VXhlUXlEeURnNGowUUJTOElpTVBHV1R1a2U0c1E0SEVOaldP?=
 =?utf-8?B?NmhBaE51NkxTS0Y5eHE2OGgrTTlZN2tlS215bk5wOFhWL2J3TUpXWHBYR1k0?=
 =?utf-8?B?KzU1bHhJb0xESFFZQ2IyK29VOXN6UUdPa2JndndDdElZN3I0QWFISEVCc094?=
 =?utf-8?B?WG9BZUV3TThBK1d1am9NUEVNSkdpWWNNT291OEtGTmRVM0Ywd3ZlaEE5SVRI?=
 =?utf-8?Q?eJs8JM?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB6109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(921020)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T1VFQXVGSXgxa2ZuWHV1MUxjYTZENEIwajM0SERTSlBnSTIvYndnT3ltMUVT?=
 =?utf-8?B?bHZ6VldLNkFFTkpLRk40aHI5eVVRWjh4ZkQ3b0RHQkx6R20xVmhhUzJxQncw?=
 =?utf-8?B?NmVuVzdERXVsaU1QeCtlTjBtWXlOSU1CNGV5OFV2ZldiVjNENW5zZ1VrWkdQ?=
 =?utf-8?B?VUpwTVhTSlNGMVJIdWllcmtDbUNMUFhUeE05eXJBVFlZc0ozSUNtZU9nemgy?=
 =?utf-8?B?K1hEVTlDVHUvSVZWMTVKL05FOVNDeFMwdmt2VFhOV0h1YXJRUXduclEyUDZC?=
 =?utf-8?B?enVZVldmNDBrdEp2OHFDWDFMaUNUb0xnV3lMd2RGY2ViOWVVNVlJay95RUZM?=
 =?utf-8?B?QjFBZkFDVFRDMVBDVklLazJUVGI4eEhrUW1Xbm40cWtkNkl2ZzFJNERDSVJl?=
 =?utf-8?B?Vk80Vk9KN1FLZm5XWE1qMVBCMWJubVBUZTIvdWZKQUdDOU9rTXlrSnEzZFRs?=
 =?utf-8?B?c2ZpVno2UzdRK1RiSXpJV2kvMUNiaDZHZnA1MTNPb3lyN2lVWEU0ZjhrcFpJ?=
 =?utf-8?B?eGlaaDdpMjZjNFV4K3ZlelFPY0tzQldDQTFiK1hUbkk2T2Z0OEhqb2ZnTkMr?=
 =?utf-8?B?OW1rR2RBR05PUzJmWkZhQ3VPcVpzZmJ1b0dMYWFFbTlJZWgwMndMTkg2VGdn?=
 =?utf-8?B?UmtnUExreHRyMGwyazkxdkhrZkNlbW5FUS92WHN3eFp4ZFo2T2FkUDZGQXZR?=
 =?utf-8?B?bXAzZ3p6RXBsSzhmYVIweGIvRFJRVDUvZFhjM0VFcHJOTWdERlRGa1B0ZE82?=
 =?utf-8?B?bUh6eTJmZXh6SzVIOVR2V3Y2MUVrUEc5clBpbkkzdVk5eVVUdnFhdmxQQ3Vh?=
 =?utf-8?B?WlFHNEJNTEI5NTc0UGRlZ21ES3lkaU52ZjQrVk5ZUi9mR09Ybks5cDJxQTV0?=
 =?utf-8?B?a0NJRHJKdWFxU0VPZGpmWFQ4VHM3bzFnY0dwVmE1SUxSRzhaUG1jQlRKVnFD?=
 =?utf-8?B?eVBnd0VMZ0o1Q3czV05aWU9LZklnZU1uWFNQeGFmN1F2djZPeXJMblV1Tm83?=
 =?utf-8?B?YjZjWnNWVzRHK1RUNUloZDVpTFFqaG1sMWxxY2FLc1Z5WHRoRWRJaXhzZFZP?=
 =?utf-8?B?a2lnVFRob2VTc3dGcW55a2lmY3paTEZJN0p2NWVwV0p2ZXgyZkFmdlFOeE1N?=
 =?utf-8?B?ZWhpV1IzazIwa1daRi8zMUNFTWlMMUgyVWNNN2ZNRlpwNjRTRVV0UzdrK2lz?=
 =?utf-8?B?eUI1Ums4VlREYk9XZGVmekJnRlhpM3Z4ZzYvTkF3YXp6MUhScitmVjNodzJG?=
 =?utf-8?B?ajdFNGlzbFpWbUVROTNydTV2ZXVuSlR2d2I5eWpVTDB4UGlDRVAvdnh4bGpq?=
 =?utf-8?B?UXllcjlhRXpmNTNXWkUxVloyVGVISnRSeXlsV3dYc3BnNGlQbnZkbjNHaFc1?=
 =?utf-8?B?Uys4UGcwWUd2c0tPTlhiNEIyYmZxa293Z0R6clB1WDF6d0ZoUVdIaitBeTQ1?=
 =?utf-8?B?V0NNZW1qa0oyZDl5ZnpFMjhFV0c0WU9PNFhtK21mUUc1YVRMdmlYZUVmUGxW?=
 =?utf-8?B?TW1Ha0JZTTJrMml2TCtsOEFrcEVkV1JzZ2syc3p3QkFGT29tcmUyOVZWYWY5?=
 =?utf-8?B?OU9XR3lHK3htVFkwZTVzRmF0VnVpK1pTUWE4RXJPNEQ3ZGpLT21aRHRCbFRM?=
 =?utf-8?B?bzJya21nQkFPa3BZT0FxZFU4ZkRidlNvK1JHajZSV280aTY5UTZTeDdDRzlS?=
 =?utf-8?B?KzV5V2xCa2FPd01ubyt3MzMrd2Y3VWVlcG5mbGF3TDZZZi9BT04yTmkyK24x?=
 =?utf-8?B?cVlLV1RsTUtCTEp2ZUFiSHEwNTU0Q21mNDB4S3Fua2Vja2NvVVVWcExaaHlL?=
 =?utf-8?B?LzY4V1laNEV5VTUvd0RNcDhBYUowcVhGTCtFQkxSM3FRSUNFclNaYnNNUU9k?=
 =?utf-8?B?V2hTNW9lU0pxS1ZNc0w5SjBKN2xGWkVMZHkwVTdYRi95M0ZtRTZZVzc2aFEz?=
 =?utf-8?B?eHV0RTk2MlFkZDROWGdMOHJocWZnZ0ZnTFRROVpBWE5PK2tSQ3FQUjZ6Qnc5?=
 =?utf-8?B?Y3BxOS80QjZWbUxXMW5ja0FsSXZZMElVZ0JoMWpobklCMG9SYlBTNCtqekNj?=
 =?utf-8?B?a0syaHJlZnJET2VpbGN3Y210REx3UXQvYjZwNXVjS1FKSis0VHQ5Vk4weW9y?=
 =?utf-8?Q?wtq4=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB6109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f7f2ae2-75af-4dc1-96fd-08ddfb48ae74
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Sep 2025 08:59:33.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PMfLFTA5xSPUXe255nz8UcOU6Gfnj45wri2rbSpVul8XesDmUocO4fhHGyKX0QYhj8mOWWP1hXQqV05ZRkOFOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8332

W1B1YmxpY10NCg0KSGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
QXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1i
ZXIgMjQsIDIwMjUgMTI6MDggQU0NCj4gVG86IEd1bnR1cGFsbGksIE1hbmlrYW50YSA8bWFuaWth
bnRhLmd1bnR1cGFsbGlAYW1kLmNvbT47IGdpdCAoQU1ELVhpbGlueCkNCj4gPGdpdEBhbWQuY29t
PjsgU2ltZWssIE1pY2hhbCA8bWljaGFsLnNpbWVrQGFtZC5jb20+OyBBbGV4YW5kcmUgQmVsbG9u
aQ0KPiA8YWxleGFuZHJlLmJlbGxvbmlAYm9vdGxpbi5jb20+OyBGcmFuayBMaSA8RnJhbmsuTGlA
bnhwLmNvbT47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5vcmc+OyBrcnprK2R0QGtlcm5l
bC5vcmc7IENvbm9yIERvb2xleSA8Y29ub3IrZHRAa2VybmVsLm9yZz47DQo+IFByemVteXPFgmF3
IEdhaiA8cGdhakBjYWRlbmNlLmNvbT47IFdvbGZyYW0gU2FuZyA8d3NhK3JlbmVzYXNAc2FuZy0N
Cj4gZW5naW5lZXJpbmcuY29tPjsgdG9tbWFzby5tZXJjaWFpLnhyQGJwLnJlbmVzYXMuY29tOw0K
PiBxdWljX21zYXZhbGl5QHF1aWNpbmMuY29tOyBTLWssIFNoeWFtLXN1bmRhciA8U2h5YW0tc3Vu
ZGFyLlMta0BhbWQuY29tPjsNCj4gU2FrYXJpIEFpbHVzIDxzYWthcmkuYWlsdXNAbGludXguaW50
ZWwuY29tPjsgJ2JpbGx5X3RzYWlAYXNwZWVkdGVjaC5jb20nDQo+IDxiaWxseV90c2FpQGFzcGVl
ZHRlY2guY29tPjsgS2VlcyBDb29rIDxrZWVzQGtlcm5lbC5vcmc+OyBHdXN0YXZvIEEuIFIuIFNp
bHZhDQo+IDxndXN0YXZvYXJzQGtlcm5lbC5vcmc+OyBKYXJra28gTmlrdWxhIDxqYXJra28ubmlr
dWxhQGxpbnV4LmludGVsLmNvbT47IEpvcmdlDQo+IE1hcnF1ZXMgPGpvcmdlLm1hcnF1ZXNAYW5h
bG9nLmNvbT47IGxpbnV4LWkzY0BsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTGludXgtQXJjaCA8
bGludXgtDQo+IGFyY2hAdmdlci5rZXJuZWwub3JnPjsgbGludXgtaGFyZGVuaW5nQHZnZXIua2Vy
bmVsLm9yZw0KPiBDYzogUGFuZGV5LCBSYWRoZXkgU2h5YW0gPHJhZGhleS5zaHlhbS5wYW5kZXlA
YW1kLmNvbT47IEdvdWQsIFNyaW5pdmFzDQo+IDxzcmluaXZhcy5nb3VkQGFtZC5jb20+OyBEYXR0
YSwgU2h1YmhyYWp5b3RpIDxzaHViaHJhanlvdGkuZGF0dGFAYW1kLmNvbT47DQo+IG1hbmlvbjA1
Z2tAZ21haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggVjcgMi80XSBhc20tZ2VuZXJpYy9p
by5oOiBBZGQgYmlnLWVuZGlhbiBNTUlPIGFjY2Vzc29ycw0KPg0KPiBPbiBUdWUsIFNlcCAyMywg
MjAyNSwgYXQgMTc6NDUsIE1hbmlrYW50YSBHdW50dXBhbGxpIHdyb3RlOg0KPiA+IEFkZCBNTUlP
IGFjY2Vzc29ycyB0byBzdXBwb3J0IGJpZy1lbmRpYW4gbWVtb3J5IG9wZXJhdGlvbnMuIFRoZXNl
DQo+ID4gaGVscGVycyBpbmNsdWRlIHtyZWFkLCB3cml0ZX17dywgbCwgcX1fYmUoKSBhbmQge3Jl
YWQsIHdyaXRlfXN7dywgbCwNCj4gPiBxfV9iZSgpLCB3aGljaCBhbGxvd3MgdG8gYWNjZXNzIGJp
Zy1lbmRpYW4gbWVtb3J5IHJlZ2lvbnMgd2hpbGUNCj4gPiByZXR1cm5pbmcgdGhlIHJlc3VsdHMg
aW4gdGhlIENQVeKAmXMgbmF0aXZlIGVuZGlhbm5lc3MuDQo+ID4NCj4gPiBUaGlzIHByb3ZpZGVz
IGEgY29uc2lzdGVudCBpbnRlcmZhY2UgdG8gaW50ZXJhY3Qgd2l0aCBoYXJkd2FyZSB1c2luZw0K
PiA+IGJpZy1lbmRpYW4gcmVnaXN0ZXIgbGF5b3V0cy4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IE1hbmlrYW50YSBHdW50dXBhbGxpIDxtYW5pa2FudGEuZ3VudHVwYWxsaUBhbWQuY29tPg0KPg0K
PiBJIGZlZWwgbGlrZSB3ZSBhbHJlYWR5IGhhdmUgdG9vIG1hbnkgYWNjZXNzb3IgZnVuY3Rpb25z
IGxpa2UgdGhlc2UsIHdoYXQncyB3cm9uZyB3aXRoDQo+IGp1c3QgdXNpbmcgaW97cmVhZCx3cml0
ZX17OCwxNiwzMiw2NH1iZSgpIGluIHlvdXIgZHJpdmVyPw0KPg0KPiBPbiBtb3N0IGFyY2hpdGVj
dHVyZXMgKGluY2x1ZGluZyBhcm0sIHJpc2N2LCBwb3dlcnBjIGFuZCBtaWNyb2JsYXplLCBidXQg
bm90IHg4NiksDQo+IHRoZSBpb3JlYWQvd3JpdGUgaGVscGVycyBhcmUgaWRlbnRpY2FsIHRvIHRo
ZSByZWFkbC93cml0ZWwgc3R5bGUgaGVscGVycywgdGhlIG9ubHkNCj4gZGlmZmVyZW5jZSBiZWlu
ZyB0aGF0IG9uIHg4NiB0aGV5IGFkZCBhbiBleHRyYSBpbmRpcmVjdGlvbiBmb3IgdGhlIHBvcnQg
SS9PIGNoZWNrLg0KPg0KPiBBdCB0aGUgbW9tZW50LCB0aGVyZSBhcmUgb25seSBzaXggZHJpdmVy
cyB0aGF0IHVzZSB0aGUNCj4gaW97cmVhZCx3cml0ZX17OCwxNiwzMiw2NH1iZSgpIHN0eWxlIGhl
bHBlcnMuIFRoZXkgYXJlIGFsbCBwb3dlcnBjIHNwZWNpZmljIGFuZCBjYW4NCj4gcHJvYmFibHkg
YmUgY2hhbmdlZCB0byBpb3tyZWFkLHdyaXRlfWJlLg0KDQpUaGUgZXhpc3RpbmcgaGVscGVycyBp
b3tyZWFkLHdyaXRlfXs4LDE2LDMyLDY0fWJlKCkgaW50ZXJuYWxseSByZWx5IG9uIHtyZWFkLHdy
aXRlfXtiLHcsbCxxfSgpLg0KDQpGcm9tIGJvdGggZGVzY3JpcHRpb24gYW5kIGltcGxlbWVudGF0
aW9uLCB7cmVhZCx3cml0ZX17Yix3LGwscX0oKSBhY2Nlc3MgbGl0dGxlLWVuZGlhbiBtZW1vcnkg
YW5kIHJldHVybiB0aGUgcmVzdWx0IGluIG5hdGl2ZSBlbmRpYW5uZXNzOg0KDQovKg0KICoge3Jl
YWQsd3JpdGV9e2IsdyxsLHF9KCkgYWNjZXNzIGxpdHRsZSBlbmRpYW4gbWVtb3J5DQogKiBhbmQg
cmV0dXJuIHJlc3VsdCBpbiBuYXRpdmUgZW5kaWFubmVzcy4NCiAqLw0Kc3RhdGljIGlubGluZSB1
MzIgcmVhZGwoY29uc3Qgdm9sYXRpbGUgdm9pZCBfX2lvbWVtICphZGRyKQ0Kew0KICAgICAgICB1
MzIgdmFsOw0KDQogICAgICAgIGxvZ19yZWFkX21taW8oMzIsIGFkZHIsIF9USElTX0lQXywgX1JF
VF9JUF8pOw0KICAgICAgICBfX2lvX2JyKCk7DQogICAgICAgIHZhbCA9IF9fbGUzMl90b19jcHUo
KF9fbGUzMiBfX2ZvcmNlKV9fcmF3X3JlYWRsKGFkZHIpKTsNCiAgICAgICAgX19pb19hcih2YWwp
Ow0KICAgICAgICBsb2dfcG9zdF9yZWFkX21taW8odmFsLCAzMiwgYWRkciwgX1RISVNfSVBfLCBf
UkVUX0lQXyk7DQogICAgICAgIHJldHVybiB2YWw7DQp9DQoNClRoZSBpb3tyZWFkLHdyaXRlfSpi
ZSgpIGhlbHBlcnMgdGhlbiBwZXJmb3JtIGEgYnl0ZSBzd2FwLCBlLmcuOg0KDQpzdGF0aWMgaW5s
aW5lIHUzMiBpb3JlYWQzMmJlKGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikNCnsN
CiAgICAgICAgcmV0dXJuIHN3YWIzMihyZWFkbChhZGRyKSk7DQp9DQoNClRoaXMgd29ya3Mgb24g
bGl0dGxlLWVuZGlhbiBDUFVzLCBidXQgb24gYmlnLWVuZGlhbiBDUFVzIHRoZSB7cmVhZCx3cml0
ZX17Yix3LGwscX0oKSBoZWxwZXJzIGFscmVhZHkgcmV0dXJuIGRhdGEgaW4gYmlnLWVuZGlhbiBm
b3JtYXQuIFRoZSBleHRyYSBieXRlIHN3YXAgaW4gaW97cmVhZCx3cml0ZX0qYmUoKSB0aGVyZWZv
cmUgY29ycnVwdHMgdGhlIGRhdGEsIHByb2R1Y2luZyBsaXR0bGUtZW5kaWFuIHZhbHVlcyB3aGVu
IGJpZy1lbmRpYW4gaXMgZXhwZWN0ZWQuDQoNClRoZSBuZXdseSBpbnRyb2R1Y2VkIHtyZWFkLHdy
aXRlfXt3LGwscX1fYmUoKSBoZWxwZXJzIGRpcmVjdGx5IGFjY2VzcyBiaWctZW5kaWFuIElPIG1l
bW9yeSBhbmQgcmV0dXJuIHJlc3VsdHMgaW4gbmF0aXZlIGVuZGlhbm5lc3MsIGF2b2lkaW5nIHRo
aXMgbWlzbWF0Y2guDQoNCg0KVGhhbmtzLA0KTWFuaWthbnRhLg0K

