Return-Path: <linux-arch+bounces-6206-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D8C952064
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 18:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1906282835
	for <lists+linux-arch@lfdr.de>; Wed, 14 Aug 2024 16:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F701BA876;
	Wed, 14 Aug 2024 16:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="jvAbEPbp"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2084.outbound.protection.outlook.com [40.107.20.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A4B1B9B51;
	Wed, 14 Aug 2024 16:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723654216; cv=fail; b=HPSOyoTu+vnCswO+/guYzeQKSFIzur/1/2tFO1VxF2mcP2p7ybGf0bM07OBz7pRGjZHvBqjVCgEG70IrfmYMjowW8LSqu+4yzpj59WtTC2yfqj6YiyBhhHzVMK7OTBWqG7vEGsmvzPm1FXeOJlWA1J7BJeJEjn9Hq3Q2C14AhNA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723654216; c=relaxed/simple;
	bh=ZCP2jvbYAX+J3lPPwh9FZJyOtCxppGKwx/eAKDgAyX4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PSm2DdzVg3HktSHBryvRE3n/xto54QvbqEJYHMe1DggVZ8CyFjmE454wA3K+E6IpTbI92p3WOZ+eKmbEynSVKkbpkY+QjsLXv9YCMfp1norBNMjSMZBL79OlzHGTbtUYeGgNbgHs6JkWgIlLqGxJCciPqtxTkFg1DhPqRvvQdWY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=jvAbEPbp; arc=fail smtp.client-ip=40.107.20.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BgVs+nt8fRsDpUQ6/lYM9znDIzkQAuiY3P50EYtTDKrJZUECBrqcvtmwDAM3CQUM1kzoOkBujp+C0KRBKnEinnX8Z9GuVIvdjaugWX6u1TnqrSw4NBlJL+CQbRshg0Xnh13Vxt6Q7nMjNvpUxLA1hc8xHtTp2TCqVLoTMDmSgfuzYW9BWMPuDM+gWIhpZp4IYFR1UznQ/lzspQvnfMzrNgPPXdYDMGOIzvLu9rxwvIz0nsMQjuaMi7nE0MjqB13TXMWSpn1ZY2z8XsNoGZPwqVN8yIYHE4ckCIyL1+EEMEpdtQduRtD6T9v6ooprFSFIn2F+9nanm0V49xHAEMLe6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCP2jvbYAX+J3lPPwh9FZJyOtCxppGKwx/eAKDgAyX4=;
 b=k3jai9iH4fJvctWo19x4NS6TdQabgShqtdMxieyfEM4paG+J1Nq5j03m5Hk016XB0KFUYmvbRzu7uba3uFuobWzbOBfdyhog8tOZyDrkgceDxJ6WmexEt3q5rn44w9YhVFGYIjcZcIYpC4gkcS3UkSSaM1jmn2G77B4iCcTfP7sivswgojo5xuB9DhzSfBvQcD32Rw4mXuyQC71qE60NZ0rsoobVb9ugs+tUKktqrt92JCuLPQ+4P/li3s9cN31Sh4cqOKl/vdQeb/zXtkHH9LWnbgCE5Fvi2dOQwmSXp+kAZHtN1BPRhtbwd086Qi/fkMkU0uDJbmo1zwLoIz/NeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCP2jvbYAX+J3lPPwh9FZJyOtCxppGKwx/eAKDgAyX4=;
 b=jvAbEPbpnnrJIFqRLelwcVawjnrKWbPLMpgOHS6gCfl+r5sBDg2LNKDNVuhDXpMpgG0NLIcjgdDulzlY2aVBakCngAPg+d/tfA/2z3izhsZmbbizVme+2rLcHbp+DWOjAT+sN6haWBfuDDTKINnsdIPBOS4NX+2oIA1k6rD7IwdiF4cKOa8vlRBPAl8wfekHG80+F5WGAwuPQFhHnQm6tkI5P0G38KCnYnQSwtGRqsosjM2YZknwrEk6/9WGiz7PKEIotoA+bHFuZ5pjMkDO0HINeW1yHmvsSLXiNsWaygTMb+9MDaCOG0+8HheAgfbBOCwMfje/6W7RpaoODyNL+g==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by DU2PR07MB8318.eurprd07.prod.outlook.com (2603:10a6:10:27b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.16; Wed, 14 Aug
 2024 16:50:11 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%5]) with mapi id 15.20.7875.016; Wed, 14 Aug 2024
 16:50:10 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: "alexs@kernel.org" <alexs@kernel.org>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, Nick Piggin
	<npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, Russell King
	<linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Brian
 Cain <bcain@quicinc.com>, WANG Xuerui <kernel@xen0n.name>, Geert Uytterhoeven
	<geert@linux-m68k.org>, Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson
	<stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>, Naveen N Rao <naveen@kernel.org>, Paul
 Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, "H .
 Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Bibo Mao
	<maobibo@loongson.cn>, Baolin Wang <baolin.wang@linux.alibaba.com>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "linux-hexagon@vger.kernel.org"
	<linux-hexagon@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, "linux-openrisc@vger.kernel.org"
	<linux-openrisc@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-riscv@lists.infradead.org"
	<linux-riscv@lists.infradead.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Qi Zheng
	<zhengqi.arch@bytedance.com>, Vishal Moola <vishal.moola@gmail.com>, "Aneesh
 Kumar K . V" <aneesh.kumar@linux.ibm.com>, Kemeng Shi
	<shikemeng@huaweicloud.com>, Lance Yang <ioworker0@gmail.com>, Peter Xu
	<peterx@redhat.com>, Barry Song <baohua@kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>
CC: Guo Ren <guoren@kernel.org>, LEROY Christophe
	<christophe.leroy2@cs-soprasteria.com>, Palmer Dabbelt <palmer@dabbelt.com>,
	Mike Rapoport <rppt@kernel.org>, Oscar Salvador <osalvador@suse.de>,
	Alexandre Ghiti <alexghiti@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>, Anup Patel <anup@brainfault.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Breno Leitao <leitao@debian.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>, Gerald Schaefer
	<gerald.schaefer@linux.ibm.com>, Hugh Dickins <hughd@google.com>, David
 Hildenbrand <david@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>, Matthew
 Wilcox <willy@infradead.org>
Subject: Re: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
Thread-Topic: [RFC PATCH 00/18] use struct ptdesc to replace pgtable_t
Thread-Index: AQHa4ku0FVdeW/1b1EaeJYCv81u9BbInD3OA
Date: Wed, 14 Aug 2024 16:50:10 +0000
Message-ID: <392b267e-cf98-4aa0-bb6e-90f6861d097d@cs-soprasteria.com>
References: <20240730064712.3714387-1-alexs@kernel.org>
In-Reply-To: <20240730064712.3714387-1-alexs@kernel.org>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|DU2PR07MB8318:EE_
x-ms-office365-filtering-correlation-id: 6c9aa079-cb75-4e78-bf09-08dcbc812920
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020|38070700018;
x-microsoft-antispam-message-info:
 5ASkG/5v7AtrFNiHTjWgA+jrTeKVpIEfcddTnj/bh8EMCcXQWcnYcEXGP0EmA9vTTRPLXY6N+UeG3nEu/25Q3FGkCGeVx8at7Qdp0jpiGURj9Z+WTQQIRg2JtlluvWCtLWZWwysQb8LNUrgzpGoxytBxmDWpfMPUFHAJHLfFBV3QPHk8J129HXZwJAaN1XDLyBxq7UJKwyQHuTbsrhH9f9X9GZbzOG+ZkRc3iCjPl3HvS54QRq/Wd++W2cxlGJVrDki/rgedD3qX3YhH/WmnyquOvywnyapyluRnGMAtcOJZMOa0JBbmifVudb8OR3UmlA2/u+K0TirRdmSbfgQA81Zwf4v0WSI6fqxwzXpW9W0RiYQqYH3MgvpFwRcMP55MpkD6ImjBMdtrPn+Ze/BoDYcWAnVXJDnJ7TEQRtYe2EoYGXxOxrNX3S44kjUHOrzQ+3N4UE+9EkzGxKjKzVsz7NsEueS2qD72TEABQXDMj8rvmdUamOsyCxbgJC0U+TfJeTu8lhKVQRHJu4h5J0h0q1y8M9bu8XmJymM/aRrsJdo7tqWKsXjVnnWzB6BIDbeabcNDIrtWrfJ+Gx5ZwzvMir6PHr+t6cpRimmwwv8c2EayVv3XKbqOjN6DthCkJhGWs0i3AN3701ZAWq0NiobIOH/8IKCbUzBESNcnAD4NFar5mpJ/kjdrd+DkENIIY5wrfXEt/amSoH2x40xPnMqJfszGTqMsvHOxxhGCLd1LIew=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RWJvRW5JaWlrZ0NFQTBJbzFOV2paYU1IOGVseFJET3FmMTJRMW40aWNDWG9s?=
 =?utf-8?B?ZWoxWGkwcEo2REdqR1B6NmJId2xCb1ZucUFpR3NGV0NNWllYVWs5ZXlSNGFJ?=
 =?utf-8?B?R0dBYzJHNU4xdkpsa0piUlllRTNscDFxYm92QW9jNGh6Wk91VTB6K09ZVXJy?=
 =?utf-8?B?eGlLWm1UdUFWYTU3QXJSc21OOVpRcTdXSnNDdFM4a3lPUkwyZVRHVS9kS2VE?=
 =?utf-8?B?NVFQVEhJYmlZOUtBb3dDelpaWW5Od3NQMXRQZ253azFwUFpmRXVTQ1lnZEZF?=
 =?utf-8?B?TFl2djlaby9uTm0rdy84aDBZdkFrMGU1RTlQL0lvdks5TWkrRGE4MkNHVVVz?=
 =?utf-8?B?a3RKWDZhS3AyQjhVUnJSSytnOGdIZGcvMnFTZWNFL25YdFNEWTVTeDBTeElD?=
 =?utf-8?B?NFFMeWUzZjJuREVISGZnMFZVTklFczFWaHdzTk56ZE9sUmdDRkUxLzhjTlY3?=
 =?utf-8?B?ZjFydUx3Unh5OHdTbXI2emZQcGN0KzVSN2FtSkRPcmhwTzRwV0dKam5TM25X?=
 =?utf-8?B?d1ZnREpkczV2eE41VVMrejJHSGhZUkxYSEg4TGJNa3BZcHdwWlNLaXZIWnNs?=
 =?utf-8?B?SkxuNUtNMDVGNVdVeTB5TU9xRG5aZWNlOVdKQ2N3NTlNQUI2V1I2Slp4Y0lK?=
 =?utf-8?B?MmZhcWpBKzVKTmR5R3FMSVFrMGRQNU9qeHI2ampYTlRTeDZuOXpURVA2RUFV?=
 =?utf-8?B?WFhWSEJOVThBZGNONzgvckg3b1hwbXdEMGVpSmN6clJVZXBxQlkrdHREbTds?=
 =?utf-8?B?YmNBazhQNmxta0dmZGs1OERzd2k3OVZQSkJIL2dsVWtnbEVvU3Z6R2hmOTNX?=
 =?utf-8?B?SGtuai9hUmN5VzhGZnBkdkJmMmlyc3Qyc0Jjc01VOVhDNVg1MUlRTlVHQjRk?=
 =?utf-8?B?NUFHaXBzazFkTWk1eTBBcWZCTmVSVHhJTzRkZTFvdmQ1Zk1VeS9YWEp6RmNB?=
 =?utf-8?B?cC95TXFSdEd6OFRlSEZwOGFUTzNvMFplSjVaMU5WTFpGVE9mTUpmSVZoRWxU?=
 =?utf-8?B?eWx1VXdNTy9QbmRPc1NpeFcwRVVvb3dyVFJUeFhhNTJyUVFxejF5dWxVY1o4?=
 =?utf-8?B?L2JkeEZUZ1dCc281Yjg0T2JJUnQyRkdWTSt6a3M2OGhIeUtYdnArVCtDbU93?=
 =?utf-8?B?amJoT3pNdUViSmNsU08zZkdxMXI5MUVHdkNPd2tNREY3Rnl2QXNVMVNuUE1D?=
 =?utf-8?B?WExNMEJCMmMveVAyOCswYVA0VVpTcWtMRXZ6Z2E3T2c4VUt0K1l0RllYK3lF?=
 =?utf-8?B?ekh5RUhDckpPWklUSmFVRktCdS9ST0p2SThrWDVCSHU0UGFOZlpJZW9EZjhD?=
 =?utf-8?B?ckVVRzBFTlZiMVFTODZRNTZYMGo1ZVpOMUZkcE1tZnIzZTU3RjdIajJ4dllF?=
 =?utf-8?B?QTUycWZsdzJLdE85RjNmbkZwQTlCOXBudWVNMFRoVm92Y2hHUVM1eHh5STBF?=
 =?utf-8?B?VFVDWi93a001YVI4R1dNZnpJZWp4aU4rUUVDUUdqTzV6SS81TXlEWkdwN1Ft?=
 =?utf-8?B?OGtFanpienhVTkRMNDdsajcrNmRxOEJwYU40VllVSU9PdkYyYmtJVnM5eVVW?=
 =?utf-8?B?SkRXTy9Ka2pjVkFkTmhiY2dHR0xBcVZ3NGpmY2M4bHFxcE0vck0zd2ZTVFpJ?=
 =?utf-8?B?aE5OQ05LUmdvT3Rla1NLNEt0ZDh4U29XdkVmWmlWVlVQOC9jSTFoaWNRQlQx?=
 =?utf-8?B?ZG5GR3RNaEhiL2dMcmhqQTZ2cDVoNU5pY3FIOURsUXcyOXpyb0ExeTgzbEx6?=
 =?utf-8?B?b3QyWXFwL3JNeVUwMDZ6MDRudVk1bDMwUzVhL2NmdHBSSWtBSEJ6M1RVUkRH?=
 =?utf-8?B?MHZCY05pbmpvT1kwc0ZpR0Y5MUsrajJscHRLUzlkamRGNUYxU2RmOGZaR214?=
 =?utf-8?B?eUhPUG5GaG1SYmV0YW96L2I5UXJublBHRzU2ZmdGblJ3RTE4V2NTbTU3dE41?=
 =?utf-8?B?MGx1UVE5aktJSjZQVmdxS01GM2VJU0NqREg2T2s4QThYdTJwbnJoQ0pkQW95?=
 =?utf-8?B?R3BUa3hOdzBhTWd4NzZCaU5abTdvWXVJNWVlbU5aOVpYeGF0YlZ0L1pqbTB5?=
 =?utf-8?B?WDVrYWRHSkJXazZJcU5RT2NESUo2Ris1SUNvSnVmR1dVQVRJTlZoTlNKY3ZU?=
 =?utf-8?B?aHVCM2MyVzZ0R2xaRzlnWDYvODk0R293b1RWNWV0Q05tcjA0bGFndTRvSHl6?=
 =?utf-8?B?Nmc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21CFA0362DD44E4AAE838A83FFC63DAE@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: cs-soprasteria.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c9aa079-cb75-4e78-bf09-08dcbc812920
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 16:50:10.6317
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dkanLTP2P4slAWRIl3lUQUNlnKF9m4n5sL3OF2/esldW8Vx52LL0j8wI+gWGe1UP2wu0ghZhnwiqFDqroOXfzY3JPPDUFyLayRxLIja7zp1tm3kZyR3aIJPNYdbdNQ1o
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR07MB8318
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 93.17.236.2
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: DU2PR07MB8318.eurprd07.prod.outlook.com

SGksDQoNCkxlIDMwLzA3LzIwMjQgw6AgMDg6NDYsIGFsZXhzQGtlcm5lbC5vcmcgYSDDqWNyaXTC
oDoNCj4gRnJvbTogQWxleCBTaGkgPGFsZXhzQGtlcm5lbC5vcmc+DQo+IA0KPiBXZSBoYXZlIHN0
cnVjdCBwdGRlc2MgZm9yIHBhZ2UgdGFibGUgZGVzY3JpcHRvciBhIHllYXIgYWdvLCBidXQgaXQN
Cj4gaGFzIG5vIG11Y2ggdXNhZ2VzIGluIGtlcm5lbCwgd2hpbGUgcGd0YWJsZV90IGlzIHVzZWQg
d2lkZWx5Lg0KPiANCj4gVGhlIHBndGFibGVfdCBpcyB0eXBlZGVmZWQgYXMgJ3B0ZV90IConIGlu
IHNwYXJjLCBzMzkwLCBwb3dlcnBjIGFuZCBtNjhrDQo+IGV4Y2VwdCBTVU4zLCBvdGhlcnMgYXJj
aHMgYXJlIGFsbCBzYW1lIGFzICdzdHJ1Y3QgcGFnZSAqJy4NCj4gDQo+IFRoZXNlIGJsb2NrcyB0
aGUgY29uY2VwdGlvbiBhbmQgY29kZSB1cGRhdGUgZm9yIHBhZ2UgdGFibGUgZGVzY3JpcHRvciB0
bw0KPiBzdHJ1Y3QgcHRkZXNjLg0KPiANCj4gU28sIHRoZSBzaW1wbGUgaWRlYSB0byBwdXNoIHRo
ZSBwdGRlc2MgY29uY2VwdGlvbiBmb3J3YXJkIGlzIHRvIHVwZGF0ZQ0KPiBhbGwgcGd0YWJsZV90
IGJ5IHB0ZGVzYyBvciBwdGVfdCBwb2ludGVyLiBCdXQgdGhpcyBuZWVkcyB3aWRlbHkNCj4ga25v
d2xlZGdlcyBmb3IgbW9zdCBhbGwgb2YgZGlmZmVyZW50IGFyY2hzLiBDb21tb24gY29kZSBjaGFu
Z2UgaXMgZWFzeQ0KPiBmb3IgaW5jbHVkZS8gYW5kIG1tLyBkaXJlY3RvcnksIGJ1dCBpdCdzIGhh
cmQgaW4gYWxsIGFyY2hzLg0KPiANCj4gVGhhbmtzIGZvciBpbnRlbCBMS1AgZnJhbWV3b3JrLCBJ
IGZpeGVkIG1vc3QgYWxsIG9mIGJ1aWxkIGlzc3VlcyBleGNlcHQNCj4gYSBidWcgb24gcG93ZXJw
YyB3aGljaCByZXBvcnRzIGEgInN0cnVjdCBwdGRlc2MgKiIgaW5jb21wYXRpYmxlIHdpdGgNCj4g
c3RydWN0IHB0ZGVzYyAqJyBwb2ludGVyIGlzc3VlLi4uDQoNCkNhbiB5b3UgdGVsbCBtb3JlIGFi
b3V0IHRoYXQgcHJvYmxlbSBvbiBwb3dlcnBjID8gV2hpY2ggZGVmY29uZmlnIGZvciANCmluc3Rh
bmNlID8NCg0KPiANCj4gQW5vdGhlciB0cm91YmxlIGlzIHBtZF9wZ3RhYmxlKCkgY29udmVyc2lv
biBpbiB0aGUgbGFzdCBwYXRjaC4NCj4gTWF5YmUgc29tZSBvZiBhcmNoIG5lZWQgZGVmaW5lIHRo
ZWlyc2VsZiBvd24gcG1kX3B0ZGVzYygpPw0KPiANCj4gVGhpcyBwYXRjaHNldCBpcyBpbW1hdHVy
ZSwgZXZlbiBleGNlcHQgYWJvdmUgMiBpc3N1ZXMsIEkganVzdCB0ZXN0ZWQNCj4gdmlydXRhbCBt
YWNoaW5lIGJvb3RpbmcgYW5kIGtzZWxmdGVzdCBtbSBvbiB4ODYgYW5kIGFybTY0Lg0KPiANCj4g
QW55d2F5IGFueSBpbnB1dCBhcmUgYXBwcmVjaWF0ZWQhDQoNCkNhbiB5b3UgdGVsbCBvbiB3aGlj
aCB0cmVlIHlvdSBiYXNlZCB0aGlzIHNlcmllcyA/IExhc3QgcGF0Y2ggZG9lc24ndCANCmFwcGx5
IG9uIDYuMTEtcmMxOg0KDQpBcHBseWluZzogbW0vcGd0YWJsZTogcGFzcyBwdGRlc2MgaW4gcHRl
X2ZyZWVfZGVmZXINCmVycm9yOiBzaGExIGluZm9ybWF0aW9uIGlzIGxhY2tpbmcgb3IgdXNlbGVz
cyAobW0va2h1Z2VwYWdlZC5jKS4NCmVycm9yOiBjb3VsZCBub3QgYnVpbGQgZmFrZSBhbmNlc3Rv
cg0KUGF0Y2ggZmFpbGVkIGF0IDAwMTkgbW0vcGd0YWJsZTogcGFzcyBwdGRlc2MgaW4gcHRlX2Zy
ZWVfZGVmZXINCg0KRm9sbG93aW5nIGh1bmsgaXMgdGhlIHByb2JsZW06DQoNCmRpZmYgYS9tbS9r
aHVnZXBhZ2VkLmMgYi9tbS9raHVnZXBhZ2VkLmMJKHJlamVjdGVkIGh1bmtzKQ0KQEAgLTE3Nzcs
NyArMTc3Nyw3IEBAIHN0YXRpYyB2b2lkIHJldHJhY3RfcGFnZV90YWJsZXMoc3RydWN0IA0KYWRk
cmVzc19zcGFjZSAqbWFwcGluZywgcGdvZmZfdCBwZ29mZikNCiAgCQlpZiAocmV0cmFjdGVkKSB7
DQogIAkJCW1tX2RlY19ucl9wdGVzKG1tKTsNCiAgCQkJcGFnZV90YWJsZV9jaGVja19wdGVfY2xl
YXJfcmFuZ2UobW0sIGFkZHIsIHBndF9wbWQpOw0KLQkJCXB0ZV9mcmVlX2RlZmVyKG1tLCBwbWRf
cGd0YWJsZShwZ3RfcG1kKSk7DQorCQkJcHRlX2ZyZWVfZGVmZXIobW0sIHBtZF9wdGRlc2MoJnBn
dF9wbWQpKTsNCiAgCQl9DQogIAl9DQogIAlpX21tYXBfdW5sb2NrX3JlYWQobWFwcGluZyk7DQoN
Cg0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBUaGFua3MNCj4gQWxleA0KPiANCj4gQWxleCBTaGkgKDE4
KToNCj4gICAgbW0vcGd0YWJsZTogdXNlIHB0ZGVzYyBpbiBwdGVfZnJlZV9ub3cvcHRlX2ZyZWVf
ZGVmZXINCj4gICAgbW0vcGd0YWJsZTogY29udmVydCBwdGRlc2MucG1kX2h1Z2VfcHRlIHRvIHB0
ZGVzYyBwb2ludGVyDQo+ICAgIGZzL2RheDogdXNlIHB0ZGVzYyBpbiBkYXhfcG1kX2xvYWRfaG9s
ZQ0KPiAgICBtbS90aHA6IHVzZSBwdGRlc2MgcG9pbnRlciBpbiBfX2RvX2h1Z2VfcG1kX2Fub255
bW91c19wYWdlDQo+ICAgIG1tL3RocDogdXNlIHB0ZGVzYyBpbiBkb19odWdlX3BtZF9hbm9ueW1v
dXNfcGFnZQ0KPiAgICBtbS90aHA6IGNvbnZlcnQgaW5zZXJ0X3Bmbl9wbWQgYW5kIGl0cyBjYWxs
ZXIgdG8gdXNlIHB0ZGVzYw0KPiAgICBtbS90aHA6IHVzZSBwdGRlc2MgaW4gY29weV9odWdlX3Bt
ZA0KPiAgICBtbS9tZW1vcnk6IHVzZSBwdGRlc2MgaW4gX19wdGVfYWxsb2MNCj4gICAgbW0vcGd0
YWJsZTogZnVsbHkgdXNlIHB0ZGVzYyBpbiBwdGVfYWxsb2Nfb25lIHNlcmllcyBmdW5jdGlvbnMN
Cj4gICAgbW0vcGd0YWJsZTogcGFzcyBwdGRlc2MgdG8gcHRlX2ZyZWUoKQ0KPiAgICBtbS9wZ3Rh
YmxlOiBpbnRyb2R1Y2UgcHRkZXNjX3BmbiBhbmQgdXNlIHB0ZGVzYyBpbiBmcmVlX3B0ZV9yYW5n
ZSgpDQo+ICAgIG1tL3RocDogcGFzcyBwdGRlc2MgdG8gc2V0X2h1Z2VfemVyb19mb2xpbyBmdW5j
dGlvbg0KPiAgICBtbS9wZ3RhYmxlOiByZXR1cm4gcHRkZXNjIHBvaW50ZXIgaW4gcGd0YWJsZV90
cmFuc19odWdlX3dpdGhkcmF3DQo+ICAgIG1tL3BndGFibGU6IHVzZSBwdGRlc2MgaW4gcGd0YWJs
ZV90cmFuc19odWdlX2RlcG9zaXQNCj4gICAgbW0vcGd0YWJsZTogcGFzcyBwdGRlc2MgdG8gcG1k
X3BvcHVsYXRlDQo+ICAgIG1tL3BndGFibGU6IHBhc3MgcHRkZXNjIHRvIHBtZF9pbnN0YWxsDQo+
ICAgIG1tOiBjb252ZXJ0IHZtZi5wcmVhbGxvY19wdGUgdG8gc3RydWN0IHB0ZGVzYyBwb2ludGVy
DQo+ICAgIG1tL3BndGFibGU6IHBhc3MgcHRkZXNjIGluIHB0ZV9mcmVlX2RlZmVyDQo+IA0KPiAg
IGFyY2gvYWxwaGEvaW5jbHVkZS9hc20vcGdhbGxvYy5oICAgICAgICAgICAgICB8ICAgNCArLQ0K
PiAgIGFyY2gvYXJjL2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgICAgICB8ICAgNCAr
LQ0KPiAgIGFyY2gvYXJtL2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgICAgICB8ICAx
MyArLS0NCj4gICBhcmNoL2FybS9pbmNsdWRlL2FzbS90bGIuaCAgICAgICAgICAgICAgICAgICAg
fCAgIDQgKy0NCj4gICBhcmNoL2FybS9tbS9wZ2QuYyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgfCAgIDIgKy0NCj4gICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAg
ICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL2FybTY0L2luY2x1ZGUvYXNtL3RsYi5oICAgICAgICAg
ICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL2Nza3kvaW5jbHVkZS9hc20vcGdhbGxvYy5oICAg
ICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL2hleGFnb24vaW5jbHVkZS9hc20vcGdhbGxv
Yy5oICAgICAgICAgICAgfCAgIDggKy0NCj4gICBhcmNoL2xvb25nYXJjaC9pbmNsdWRlL2FzbS9w
Z2FsbG9jLmggICAgICAgICAgfCAgIDggKy0NCj4gICBhcmNoL202OGsvaW5jbHVkZS9hc20vbW90
b3JvbGFfcGdhbGxvYy5oICAgICAgfCAgMTIgKy0NCj4gICBhcmNoL202OGsvaW5jbHVkZS9hc20v
c3VuM19wZ2FsbG9jLmggICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL21pY3JvYmxhemUvaW5j
bHVkZS9hc20vcGdhbGxvYy5oICAgICAgICAgfCAgIDIgKy0NCj4gICBhcmNoL21pcHMvaW5jbHVk
ZS9hc20vcGdhbGxvYy5oICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL25pb3MyL2lu
Y2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL29wZW5y
aXNjL2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgfCAgIDggKy0NCj4gICBhcmNoL3Bh
cmlzYy9pbmNsdWRlL2FzbS9wZ2FsbG9jLmggICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBhcmNo
L3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzMyL3BnYWxsb2MuaCAgfCAgIDQgKy0NCj4gICBh
cmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2hhc2gtNGsuaCAgfCAgIDQgKy0NCj4g
ICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L2hhc2gtNjRrLmggfCAgIDQgKy0N
Cj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BnYWxsb2MuaCAgfCAgIDQg
Ky0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3BndGFibGUuaCAgfCAg
IDggKy0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vYm9vazNzLzY0L3JhZGl4LmggICAg
fCAgIDQgKy0NCj4gICBhcmNoL3Bvd2VycGMvaW5jbHVkZS9hc20vcGdhbGxvYy5oICAgICAgICAg
ICAgfCAgIDggKy0NCj4gICBhcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvaGFzaF9wZ3RhYmxlLmMg
ICAgICAgfCAgMTAgKy0NCj4gICBhcmNoL3Bvd2VycGMvbW0vYm9vazNzNjQvcmFkaXhfcGd0YWJs
ZS5jICAgICAgfCAgMTAgKy0NCj4gICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAg
ICAgICAgICAgICAgfCAgIDggKy0NCj4gICBhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGdhbGxvYy5o
ICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGd0YWJs
ZS5oICAgICAgICAgICAgICAgfCAgIDQgKy0NCj4gICBhcmNoL3MzOTAvbW0vcGdhbGxvYy5jICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gICBhcmNoL3MzOTAvbW0vcGd0YWJsZS5j
ICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTQgKy0tDQo+ICAgYXJjaC9zaC9pbmNsdWRlL2Fz
bS9wZ2FsbG9jLmggICAgICAgICAgICAgICAgIHwgICA0ICstDQo+ICAgYXJjaC9zcGFyYy9pbmNs
dWRlL2FzbS9wZ2FsbG9jXzMyLmggICAgICAgICAgIHwgICA2ICstDQo+ICAgYXJjaC9zcGFyYy9p
bmNsdWRlL2FzbS9wZ2FsbG9jXzY0LmggICAgICAgICAgIHwgICAyICstDQo+ICAgYXJjaC9zcGFy
Yy9pbmNsdWRlL2FzbS9wZ3RhYmxlXzY0LmggICAgICAgICAgIHwgICA0ICstDQo+ICAgYXJjaC9z
cGFyYy9tbS9pbml0XzY0LmMgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICAgYXJj
aC9zcGFyYy9tbS9zcm1tdS5jICAgICAgICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICAg
YXJjaC9zcGFyYy9tbS90bGIuYyAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDE0ICstLQ0K
PiAgIGFyY2gveDg2L2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgICAgICB8ICAxMCAr
LQ0KPiAgIGFyY2gveDg2L21tL3BndGFibGUuYyAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
OCArLQ0KPiAgIGFyY2gveHRlbnNhL2luY2x1ZGUvYXNtL3BnYWxsb2MuaCAgICAgICAgICAgICB8
ICAxMiArLQ0KPiAgIGZzL2RheC5jICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICB8ICAxNCArLS0NCj4gICBpbmNsdWRlL2FzbS1nZW5lcmljL3BnYWxsb2MuaCAgICAgICAgICAg
ICAgICAgfCAgMTAgKy0NCj4gICBpbmNsdWRlL2xpbnV4L21tLmggICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCAgMTYgKystDQo+ICAgaW5jbHVkZS9saW51eC9tbV90eXBlcy5oICAgICAgICAg
ICAgICAgICAgICAgIHwgICA0ICstDQo+ICAgaW5jbHVkZS9saW51eC9wZ3RhYmxlLmggICAgICAg
ICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICAgbW0vZGVidWdfdm1fcGd0YWJsZS5jICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgICA2ICstDQo+ICAgbW0vaHVnZV9tZW1vcnkuYyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgMTAzICsrKysrKysrKy0tLS0tLS0tLQ0KPiAgIG1tL2lu
dGVybmFsLmggICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMiArLQ0KPiAgIG1t
L2todWdlcGFnZWQuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxNCArLS0NCj4g
ICBtbS9tZW1vcnkuYyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgMTUgKy0t
DQo+ICAgbW0vbXJlbWFwLmMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAy
ICstDQo+ICAgbW0vcGd0YWJsZS1nZW5lcmljLmMgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
IDM3ICsrKy0tLS0NCj4gICA1MyBmaWxlcyBjaGFuZ2VkLCAyNDAgaW5zZXJ0aW9ucygrKSwgMjM2
IGRlbGV0aW9ucygtKQ0KPiANCg==

