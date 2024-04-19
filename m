Return-Path: <linux-arch+bounces-3827-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F7E8AB2AA
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 17:59:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF7F5283486
	for <lists+linux-arch@lfdr.de>; Fri, 19 Apr 2024 15:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C74130A6B;
	Fri, 19 Apr 2024 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="H16ckgMz"
X-Original-To: linux-arch@vger.kernel.org
Received: from PR0P264CU014.outbound.protection.outlook.com (mail-francecentralazon11022019.outbound.protection.outlook.com [52.101.167.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A65C12F386;
	Fri, 19 Apr 2024 15:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713542385; cv=fail; b=h7opJVnG0zOKv13lzY1TRtUohhUqbCuvnvFwBzYtIB6+zBkK6061WKSYgHzU1S3GTf9biIgg2cfW+8+QXH9dkR578nNXtloBlg5Q/Ja+FuzP9MSNMZmPxJKDd0A8EnLxHRMQVaEJ2KyDejQlxZPzvRGoliuCr+Jy+aSlo7QMICw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713542385; c=relaxed/simple;
	bh=jDmt6WaOjydqXje7mR//Y4RBqNYoBYN5pPdscgLBmnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QQmzCJRG1Q30ondQLEbpdHRHBWZU2BOuyA7Tvgg+CZjq3c53VIfqhaZFl+WXSKn5QblZVn86iHlcy6RDPuI3e3jCChkQCSAsCBwL0F5HOOGJTKXGTrL2w+bJok6RDEyQwEtu5yBizDzVl43E+fcCQq8sl4jPJw7kqR6ZLFu4UKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=H16ckgMz; arc=fail smtp.client-ip=52.101.167.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCpLj+zZVjSUHXDWG6XCp7Ftr+PSTZ86fmz6SYw00e3/IqIFNZHFXPUGpAifOGcESsaWk2/Q7ljsMF6JSqKDv8NZFfMkGDUHfyaCYPPLrl++umQlIWQthc+9Ke+6TGGazIJCsCj2sTRpkUKRPAr9qR2kOcBMU4iNoPf4rO11op1hFYjQg0USnZfS2HWC+VUDyjgJhLEVTwxITeHqBSOpKKIBRy44nI96XnB/1tGrq6vfcK7ZP3PLSy/DpwR0f69PcCuM03N4UytHzmrsxZoYDywtf/Qp18Op1foTsp/RMaJs3+wtghQ3TCSTj9PloZk2OgP+eWaoQh4ftyZdiAcq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jDmt6WaOjydqXje7mR//Y4RBqNYoBYN5pPdscgLBmnw=;
 b=OZhVVNuDCWXmij0Lb2RjL2LKK0/p+c4K9pwl/cTi48t2hFKEXjidxStLZpE4ubuSE3cTZDUYFLqmfrqVSBVC+xfwGJfnVPONCw+i/NQhZ8S6TxDqe+KmM8q0xVPhs7e1qFlR3bcV6Zif8wuJBjtwDELGj/emk1++ZYnyb1Ko+epmnHzBVlPU7BLqR7bqhcwjixtJkqKQyghiISVG2BxAU147lcPrTyRazyNzy+M6aJeOKhlblFp5uREO44zoOR3ZmiORkRfID68dEc+g6lR1IecK6ZiYrDd9y2w2hg0iZB6DjHdhueNzy+PT60EKyWS5/SEAiHfj5swSsLI4aFjxpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDmt6WaOjydqXje7mR//Y4RBqNYoBYN5pPdscgLBmnw=;
 b=H16ckgMzuhNQmiExI3p/8WqitL4hJZVVSRyiELBuIslEApyx2Br3gMb3EgfZu+QhI7LIAG6uWm/gMYD04ErERzrTvSnRCfqqm9SYrUSpQV7zevUS0JDH2+dEqMqOxDM0WCkpctv8nyQ9PSe2+M0aRqBSO6Uwj39+l+2t+R6BxHFcRyHnwdcVGiYLbt7O53zpLeQa2J/p36kG68hgEeTs1i9HdHu6sECE+ptjYrKxCrSOCCuyZOZi8kqW/7EhS4f0OwjYzSgFAfUmUIXGH/ZncpzXe1+4hFLIpmIYdfqb+q0faRidR6MQsYeCNtUI6an5rWJpeQvi7iABjdA2NA7fIQ==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2306.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:33::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 15:59:40 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::1f75:cb9f:416:4dbb%7]) with mapi id 15.20.7472.037; Fri, 19 Apr 2024
 15:59:40 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu
	<masami.hiramatsu@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre
 Ghiti <alexghiti@rivosinc.com>, Andrew Morton <akpm@linux-foundation.org>,
	=?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, "David S. Miller" <davem@davemloft.net>, Dinh
 Nguyen <dinguyen@kernel.org>, Donald Dutile <ddutile@redhat.com>, Eric
 Chanudet <echanude@redhat.com>, Heiko Carstens <hca@linux.ibm.com>, Helge
 Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, Kent Overstreet
	<kent.overstreet@linux.dev>, Luis Chamberlain <mcgrof@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Michael Ellerman <mpe@ellerman.id.au>, Nadav
 Amit <nadav.amit@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>, Puranjay
 Mohan <puranjay12@gmail.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Russell King <linux@armlinux.org.uk>, Song Liu <song@kernel.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Will
 Deacon <will@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mips@vger.kernel.org"
	<linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"loongarch@lists.linux.dev" <loongarch@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org"
	<x86@kernel.org>
Subject: Re: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Thread-Topic: [PATCH v4 14/15] kprobes: remove dependency on CONFIG_MODULES
Thread-Index: AQHajCnm1aS8Kk9vD0aN6hruH/CtDrFtAKKAgALJT4CAAALlgA==
Date: Fri, 19 Apr 2024 15:59:40 +0000
Message-ID: <321def3e-8bf1-4920-92dd-037b20f1272d@csgroup.eu>
References: <20240411160051.2093261-1-rppt@kernel.org>
 <20240411160051.2093261-15-rppt@kernel.org>
 <20240418061615.5fad23b954bf317c029acc4d@gmail.com>
 <ZiKSffcTiP2c6fbs@kernel.org>
In-Reply-To: <ZiKSffcTiP2c6fbs@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB2306:EE_
x-ms-office365-filtering-correlation-id: 33aa31c6-e808-4d25-810c-08dc6089b875
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 =?utf-8?B?cldJUTZ2WnhwOEFJLzFxSUVLQmxOb0cvanl4cHl6YVZVMEltdS9UM1MyOFpy?=
 =?utf-8?B?K0tWVndoejVoWkJJLzJ1MWJSY0xUTm1pMlpySHpIMDdZQjhjVXRuU1dNZWRy?=
 =?utf-8?B?R1Nhb09aVjZqYnhYZ2pXR0dmYkV0L3dqeTJlbHhGUHY2dytlb0l5ZkJNanVZ?=
 =?utf-8?B?WjI4MzZ3V05BU2JzQkJkcWVwSW9hUlhFa3h3VkQ5eTFBSGhEcHk2ck9yYU91?=
 =?utf-8?B?bzRmTTM5a0NiVzVMRVNSWklPaThpOU9Fc052d2owbjNZZVRLV28xbG5hc1dF?=
 =?utf-8?B?am9tRXR4Mm5QRGhmUkQ4ZjdEVS9tVmh4NXBHcWk2OXVKNXdPUlcrZkZvSjNx?=
 =?utf-8?B?UEsvMndxSXZxaXMrM2NGMUluTHdjQ0tNdm56ZlpzektRczVKcmFpVUpOTFRn?=
 =?utf-8?B?dTd3WXVHaDl5UGdwOTNCSTdKS2p5T3FHQlYwa0pxaUhNV1lnc3BHZEFtS01I?=
 =?utf-8?B?aTlUWlhSRkVxanRsdlo0UkhYT2FZcytnZjNEWk5IQzdCNEdnbnQ5REZiOFRB?=
 =?utf-8?B?S3pDWThFVXR2L3VVNjVPMUEzMnVXTkkveE1Uck1UdGRIWEJXZW9ya3JLcW5k?=
 =?utf-8?B?WmVTUFViQjZhMzhzbGhRRkgwYS91YVZXdTI2eW9BTW03OC9nMUhoT1pEcVNN?=
 =?utf-8?B?RVllc3k1eTJXR1B4dDR3SnZpZXl2SUQ1ZkVhTjNQUEJ1NTQxUkd0MUNneVZF?=
 =?utf-8?B?STdKZWdqZGNFc05Oditjbk9id0E2eDNmV0E4eGloSS9Db2J1L0d6NkNMUVRY?=
 =?utf-8?B?amhmejllWXVZZW5RN3VtL3VpSm5naS9OZ2ZUQ0VPV1NieFRxcG8wYm1jQ2l0?=
 =?utf-8?B?eU1YbGlFMlpldktrcEFjZzVzYzFYcFFJR3IzSkNUUG1jaTZPRzhUeDIrdEVs?=
 =?utf-8?B?OWI1S2lrNUNkeGdGcDNGbjRzdkx2akdBekpXVCtJTDM4RXVSbm05Q2llZjNN?=
 =?utf-8?B?QzVNaElMNW5XdVFuNnIrQzVIWlVNTWFNZWZWMlVCMGI4UmRRRXVWeGYvYUZB?=
 =?utf-8?B?dUF4L2lnUnpYYjRqYm11aTFVcS9SL1hFM0JGczhnbVhiRnZ4cE9HYUtid1l2?=
 =?utf-8?B?emtpM2hiNWNJZW5HUmJ5cE5NdytnNzQvTFlKa1dHYkRhSzRGNWFURGVKOFVW?=
 =?utf-8?B?S3hQQkVsQTg0S0JJT2dYaXVPL01rVmVaREM0bWtyZ3hXMDd6eXE4YmExcTBU?=
 =?utf-8?B?MWE0anlPRkludFd0NDQ5WEh6RWgxN3d6Y3BTVVpqcHI3QWZ1c2Y5VHFmd3BF?=
 =?utf-8?B?NmNqSG9maFJDWlNFSlM0NDlKQ3BIUEE1TWk4STNwcXp2a0o2dFovOU15cU5r?=
 =?utf-8?B?NndlWjAvN09SZnpaM2s3ZkRnL2RZeW1IZ2pvcWt4T2laWVdLMm1aa0RVcXEv?=
 =?utf-8?B?OUZ6RFFrRGZ1MkYvRDMrNk02ODJLMVF3MTFHL2IvdStHU1NLTS9TMEFBWEtp?=
 =?utf-8?B?NXE0cXJXSGl0NXBjdEVNanVDZ3N6OXFvUkpiV0YvUGx1djlOM2MwNDF0aGsz?=
 =?utf-8?B?Q0VQbzlvcEx3aWx6Rk81TFR4bmZ4TEcxT3Q2dmdyYTRkNGNkVmhEb0REYld6?=
 =?utf-8?B?end6U1hXRW9zU2Y2UXhVNy95OS9pMFlEbGJHSkxYdU1LNXQ4VFZDMXJpTEVO?=
 =?utf-8?B?Q1Y2TGdBeG0vc3ZTYUxBZ3huSGdxMmQvaTVCUjRlSmpKV2MrRTU0V1dLNUln?=
 =?utf-8?B?bWhrYTlvV1lrVFVTSkZjb3E2djl1K1BhbFdpVWorWVZCSVJTZlNGdmttNFVP?=
 =?utf-8?B?VElmek9hRXRSRUk4K0U4Wmo0SXkzcGd4VkFXMW5VTnRFcnJpdHdrZ3BpTDds?=
 =?utf-8?B?LzVyUCttMGV3a2RwZmRSQT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?TjJ1OStCbjZtbnhzRzdOL0ZabmJ2czVsRm4xR2pSVStyQTZUUGVaZ0FDcnZJ?=
 =?utf-8?B?MGlwaHUyajMxbGRTcFVEWmQwL0s0OVVldUlMdmIybnFiVnpRaHVaeUVqVGhj?=
 =?utf-8?B?amUxNFB2VmhPdUhFbDhOcFpvQjRkcVBGWWx1KzZXbFBNTWdGd1N6M1ljYWdS?=
 =?utf-8?B?bWowR0V6Q3c4cEY0WFBrL0xZNmpxVmphcS9kc0FtWmRXOVBUUitYeVdFa0xH?=
 =?utf-8?B?MlpVL2lldjYyUE9Lbm5OV1pPak5VTGJGOUtIa1Q5Q2xoMnZLdHBQNXZoMjEr?=
 =?utf-8?B?dkk2ZjZ1bk1HaDBzWWVDeXN0MDZiTXFzR2pqZ1ZvcUpSeWVoNndTeGNmQUJt?=
 =?utf-8?B?WWFENDdiM1JCQzdnTDNTZnE1N212Q2hKS2Z4V0lxWVhVYmFYcEJEMEpKRjZ5?=
 =?utf-8?B?R2RiMUhVVjlCeTRKMm96S1ZpU3JMS0hMbUJvbml3am9Gd1JRQ0pZUlpIRkVY?=
 =?utf-8?B?VlJvM0NSVTAyMDZJYk9TN050QmxDbmFGUGRlTFd3RGVhVzh4bHFVQnUyRVJs?=
 =?utf-8?B?NDEweUJkQ0pMV0FzK25uU05wVXl0YmRyaEZqOHhSekNMZzI5Lzg3S0MzS1Zi?=
 =?utf-8?B?K0RwRllkNGJZWVkydU1FQnk0VDBLV0IzWFZkSzdjbmR3cnZGR2dBN1NVSkh0?=
 =?utf-8?B?OFJpWEtaaVdEQXIwSWRmNlJ1bWhMdU9rbU9zenBOekl1K3l5L1orQklsS2Vm?=
 =?utf-8?B?cWxmMU43VTlXYUo1ZTdQTzlyUzI1SEhHUmZicVpteWRvaHo4dlBwSk84NWp2?=
 =?utf-8?B?Q1pHTXNHeXp6bDJvbFB4aGFEVGp3R3dPbVpCZ2ZsdEV6R2N0R0VZTFdRU3Uz?=
 =?utf-8?B?SWUwR0RoV0J0UXBsMkdYYU00b1VWSEhRRHNjaUtweC9zSHVJMkNyeEh1SnY4?=
 =?utf-8?B?VHlxOXBnUzRNUUtmTEEyR284K3lQaTNYVThxVk5rSEllaGpIWWdQblU1YnV6?=
 =?utf-8?B?MlQwVmNraWFFclJpdTUwWmpobm0yQnI5ajFTUVJlRGxtckZCa2NLdTVlaW83?=
 =?utf-8?B?MHVFNEk2NHdBMEFiVHdHMGt2ZXVEZm5rR2dNUWpJdzQ5MGdxMS9JdmtpcHAw?=
 =?utf-8?B?QUJIdlBwSGI0aGpNT1JGcE5RVmM3QXlNMTRaSnF2Q0dqTlFPSUJaTGg2YVVj?=
 =?utf-8?B?cGNNYmlKS29Hb1kwc1JlMmswbHJmV1g2SnNpaWtWR05uYjI1NTJ5Mm9kY1dQ?=
 =?utf-8?B?dDVDM0dYUVFNV2pUUnBQTHpqNCtSSktpdE5GcmtNZnN2NjM3VzZPSGZqSTRQ?=
 =?utf-8?B?MjE1MExDR0s1UFB5cHlqZzd2VWthSnB6WEw5TXZkSG9CT3NxcDZaQklRZmtq?=
 =?utf-8?B?dG5zdDRqeklZUVI4Y1VwQ2NZSjEzRVYzUlc0L2cvRzJxemR2dWM5RFhFcTIv?=
 =?utf-8?B?cVNRbUhqOUhoTkhWaURoaWllbTJJSlM0STNCeTUzL29JaFdtaUpMa2pmYmJT?=
 =?utf-8?B?OVAzWFNtMkU0WG1yV1FkcUV6SlN2N0huS0kxUVRtc0tjYnZlR28rOGxaL0RO?=
 =?utf-8?B?azlrNHJDSE95VUIvbjdDdUYyQXlKZGQ0NUpFcGFsZS9tb1R0ZHk2TzlQc29n?=
 =?utf-8?B?UDZlNCtobnhRbHlOajl6NlFJT3U0NjV0aE1aSTRONEJBOFpQa25USktjRDZE?=
 =?utf-8?B?VVdjSUxhWXlRUEMvaVdZWFR3NWVtQ3E4cHo3TUsvMzhGQlhiNlFGU2RPWUFk?=
 =?utf-8?B?cFpwOURmSnlyNm9iZXdQdFJmUFYxblZ3Zk1aeDNkL3lJZnA5Yk5MNTNXSFM5?=
 =?utf-8?B?YVZXNURKVjZhR2FQSU5CeEFZN1AwMVJxeldORE9RTGVvUno4NnVwelpTZW1M?=
 =?utf-8?B?RHI5cm1VbVdyY0VaMjhxTk9Vb2p3cGZtZzlvaXozZVZFOWVPdkVFdlArNnUy?=
 =?utf-8?B?OUc4WnA4QU1jQXhvSnVrVERFanc2YTZLMjVCcHEvMm1PeUp6Q2k0TlJPZzNJ?=
 =?utf-8?B?ajhzNkVGM1NFZDhvNlFCUEs1S2JJZmI5UHQ4dVNZNGRJbVRMNWlCdnh6MEhp?=
 =?utf-8?B?eXl1RWFZclJQWG40VW9TSE1LVitRUlhtN0pNeXk3clpYdi9kaVNYU1NXc3JL?=
 =?utf-8?B?dm5mbVJkS3FWWTkrWDZmcUp2dVlwb1h2TVhGMVE2ZnFZL2pLUEROWHlTQ2lx?=
 =?utf-8?B?VzcyUGRkWGZ4SWV3RXdEWmZ1bzJSYWdRdmVlWjhvSDluOHIydWxKNVJPMWNN?=
 =?utf-8?B?VjNLSHFGVXlZVUtQd3FBWHlBUG9PdTgzazZ6aS9majVRTEdYQms5VEJIUVRN?=
 =?utf-8?B?cWRQRHZTWGVmWVkrS0pzZG9qS1RnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEA80A5C8729BB4DBE09A879DFC1D278@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 33aa31c6-e808-4d25-810c-08dc6089b875
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2024 15:59:40.0721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l8BmDgyprer7fbf6oxOdrj3TgU1+p+JwqascyFoIdyTySwO7zLPY0UySwlZ83y9zAfQLBor4EwlDHLjgdazkJFcIzaJLLZpZ1HocYWNjvM0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2306

DQoNCkxlIDE5LzA0LzIwMjQgw6AgMTc6NDksIE1pa2UgUmFwb3BvcnQgYSDDqWNyaXTCoDoNCj4g
SGkgTWFzYW1pLA0KPiANCj4gT24gVGh1LCBBcHIgMTgsIDIwMjQgYXQgMDY6MTY6MTVBTSArMDkw
MCwgTWFzYW1pIEhpcmFtYXRzdSB3cm90ZToNCj4+IEhpIE1pa2UsDQo+Pg0KPj4gT24gVGh1LCAx
MSBBcHIgMjAyNCAxOTowMDo1MCArMDMwMA0KPj4gTWlrZSBSYXBvcG9ydCA8cnBwdEBrZXJuZWwu
b3JnPiB3cm90ZToNCj4+DQo+Pj4gRnJvbTogIk1pa2UgUmFwb3BvcnQgKElCTSkiIDxycHB0QGtl
cm5lbC5vcmc+DQo+Pj4NCj4+PiBrcHJvYmVzIGRlcGVuZGVkIG9uIENPTkZJR19NT0RVTEVTIGJl
Y2F1c2UgaXQgaGFzIHRvIGFsbG9jYXRlIG1lbW9yeSBmb3INCj4+PiBjb2RlLg0KPj4+DQo+Pj4g
U2luY2UgY29kZSBhbGxvY2F0aW9ucyBhcmUgbm93IGltcGxlbWVudGVkIHdpdGggZXhlY21lbSwg
a3Byb2JlcyBjYW4gYmUNCj4+PiBlbmFibGVkIGluIG5vbi1tb2R1bGFyIGtlcm5lbHMuDQo+Pj4N
Cj4+PiBBZGQgI2lmZGVmIENPTkZJR19NT0RVTEUgZ3VhcmRzIGZvciB0aGUgY29kZSBkZWFsaW5n
IHdpdGgga3Byb2JlcyBpbnNpZGUNCj4+PiBtb2R1bGVzLCBtYWtlIENPTkZJR19LUFJPQkVTIHNl
bGVjdCBDT05GSUdfRVhFQ01FTSBhbmQgZHJvcCB0aGUNCj4+PiBkZXBlbmRlbmN5IG9mIENPTkZJ
R19LUFJPQkVTIG9uIENPTkZJR19NT0RVTEVTLg0KPj4NCj4+IFRoYW5rcyBmb3IgdGhpcyB3b3Jr
LCBidXQgdGhpcyBjb25mbGljdHMgd2l0aCB0aGUgbGF0ZXN0IGZpeCBpbiB2Ni45LXJjNC4NCj4+
IEFsc28sIGNhbiB5b3UgdXNlIElTX0VOQUJMRUQoQ09ORklHX01PRFVMRVMpIGluc3RlYWQgb2Yg
I2lmZGVmcyBpbg0KPj4gZnVuY3Rpb24gYm9keT8gV2UgaGF2ZSBlbm91Z2ggZHVtbXkgZnVuY3Rp
b25zIGZvciB0aGF0LCBzbyBpdCBzaG91bGQNCj4+IG5vdCBtYWtlIGEgcHJvYmxlbS4NCj4gDQo+
IFRoZSBjb2RlIGluIGNoZWNrX2twcm9iZV9hZGRyZXNzX3NhZmUoKSB0aGF0IGdldHMgdGhlIG1v
ZHVsZSBhbmQgY2hlY2tzIGZvcg0KPiBfX2luaXQgZnVuY3Rpb25zIGRvZXMgbm90IGNvbXBpbGUg
d2l0aCBJU19FTkFCTEVEKENPTkZJR19NT0RVTEVTKS4NCj4gSSBjYW4gcHVsbCBpdCBvdXQgdG8g
YSBoZWxwZXIgb3IgbGVhdmUgI2lmZGVmIGluIHRoZSBmdW5jdGlvbiBib2R5LA0KPiB3aGljaGV2
ZXIgeW91IHByZWZlci4NCg0KQXMgZmFyIGFzIEkgY2FuIHNlZSwgdGhlIG9ubHkgcHJvYmxlbSBp
cyBNT0RVTEVfU1RBVEVfQ09NSU5HLg0KQ2FuIHdlIG1vdmUgJ2VudW0gbW9kdWxlX3N0YXRlJyBv
dXQgb2YgI2lmZGVmIENPTkZJR19NT0RVTEVTIGluIG1vZHVsZS5oICA/DQoNCg0KPiAgIA0KPj4g
LS0gDQo+PiBNYXNhbWkgSGlyYW1hdHN1DQo+IA0K

