Return-Path: <linux-arch+bounces-2547-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A77685D0C8
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 07:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50C182863F4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Feb 2024 06:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394233A1C2;
	Wed, 21 Feb 2024 06:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="XqqDLxQb"
X-Original-To: linux-arch@vger.kernel.org
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-pr2fra01on2100.outbound.protection.outlook.com [40.107.12.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126C62C18E;
	Wed, 21 Feb 2024 06:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.12.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498749; cv=fail; b=nI0xRf+odTnxKKwgVjCU2j8ytPHZRCnYSxpMgvGubjw1914HJErbi55fVWI6N+hFVrMHFql2LedsWlCrlh22Ji9d2ZfRLNqqcMhPIsTX0ejr6bbszUT9AqBG9MgCCBVHRWi6MIylYmjMLVPuCQhPym1xHszQXjyRG4vxDUreclY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498749; c=relaxed/simple;
	bh=NZh/o3+ui/KR67Kpif2Y2cLLTahL2J4AlYhkq5tZjXc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=la+AZ24cEY0pt/fzBmdI4NWXaZiNvmQQbz2ezIJwsUFOJCJB867IktktLKrA0ez7gTMW5DYqEIiCYW1cy9SHpDYZ9aAclLfGh0yaA3zjdv7Cq6IU8J+6CvuObxUnNKVFXgV8Og6lv0JqZgNaWzMPY6zZwh4hHp3SAud+qsiIKVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=XqqDLxQb; arc=fail smtp.client-ip=40.107.12.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MJx0i13yAqn5iCLJmw6SWsXcY7mJLsoZXcrK1h2d4IFevdtzZK0YLtCRcyQOeaHF6z0sS8l8oDCDcY2jna3YGT9scmXFPWrqvpdkRa0QhZsF/zS0FPg9wm0RPR8F3roPsJoGUlzIpLbaxg7nX6WmAq6lQ695ivbKOESAKGzIMEtZwTZW3Fl66XI1QnnkB9PWCNXFRgNQnQzczR0YkdScSiMH39gCKKQ3B74SLnU31keabzYctT4KzKQclqKOd0SOGwCdtZvoomZTWc7GNBbolbhcwqIXhN8DhdN0UCWgU/odKIfuJAmx0g+JUfizZ1EefM8G+8jzhk7CpOfKekdn5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NZh/o3+ui/KR67Kpif2Y2cLLTahL2J4AlYhkq5tZjXc=;
 b=cdodFNTXoKq9agxRrB1db/LuVYOw/4jLR2NhEc+X69Tna52XRp9cFJWGCVYAoMwAicd6JXMpmc6+/8cQaTHkWbWtwvHLRz/1YK7hVenXwD6/mhLMsJbKKK1qEEYW3aOW+hmUlvC9LEZqnxvzs/U0bAEqS5WiV/tRP9jbgWsNOF+znqdKU4iyrzdhGbsyt3SYS+njPhPXh1EIYTcgt0GzfnxHRz3fIyYuXTPV+48s3y4k/ZGfi62UFt1H/OrJSrujHR809Plk2Txpqh5cnN9Er0lqTd3puJJKQByRqg9aPTMd/UyPSYwRvK97r87RHqy5WkrpaqEmT7uDEaqeg1Vqzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NZh/o3+ui/KR67Kpif2Y2cLLTahL2J4AlYhkq5tZjXc=;
 b=XqqDLxQbPPDGU9iySwYdBu5zzZ3ag4Nq3ExyvJK/8TZVwQuB4jHaB4i5QefbFAKJ0QhPSebcm1WVQsPG2HCAyPExc9PDQOPb6GwsLkhOBURTWGR+yysf48WNmk6GkxhgVh11Nlp6EGvmWyuJoDPHJhlUKFuNGkUMcdyqyG0F07eZVLg7c52aaPi/yjzLLKPH93//9iSW7GUQ4DEgivgAUQNFEsDLT5YmDNqcFuwyHtNZ2UBxaofSgfe5WGKgGHpVm003xVyRjSGWS75ZM+7BXeXxNBe7Ke4yMS6xcO7YMJ/c4HSVlPQGiyxuYNmdFD2mjaWJXzYOS88wBAWji23RWA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB3076.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 06:59:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::64a9:9a73:652c:1589%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 06:59:01 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Maxwell Bland <mbland@motorola.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
CC: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>, "andrii@kernel.org"
	<andrii@kernel.org>, "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
	"aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>, "ardb@kernel.org"
	<ardb@kernel.org>, "arnd@arndb.de" <arnd@arndb.de>, "ast@kernel.org"
	<ast@kernel.org>, "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, "brauner@kernel.org"
	<brauner@kernel.org>, "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"cl@linux.com" <cl@linux.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
	"david@redhat.com" <david@redhat.com>, "dennis@kernel.org"
	<dennis@kernel.org>, "dvyukov@google.com" <dvyukov@google.com>,
	"glider@google.com" <glider@google.com>, "gor@linux.ibm.com"
	<gor@linux.ibm.com>, "guoren@kernel.org" <guoren@kernel.org>,
	"haoluo@google.com" <haoluo@google.com>, "hca@linux.ibm.com"
	<hca@linux.ibm.com>, "hch@infradead.org" <hch@infradead.org>,
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jolsa@kernel.org"
	<jolsa@kernel.org>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>, "kpsingh@kernel.org" <kpsingh@kernel.org>,
	"linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>, "linux-efi@vger.kernel.org"
	<linux-efi@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"lstoakes@gmail.com" <lstoakes@gmail.com>, "mark.rutland@arm.com"
	<mark.rutland@arm.com>, "martin.lau@linux.dev" <martin.lau@linux.dev>,
	"meted@linux.ibm.com" <meted@linux.ibm.com>, "michael.christie@oracle.com"
	<michael.christie@oracle.com>, "mjguzik@gmail.com" <mjguzik@gmail.com>,
	"mpe@ellerman.id.au" <mpe@ellerman.id.au>, "mst@redhat.com" <mst@redhat.com>,
	"muchun.song@linux.dev" <muchun.song@linux.dev>, "naveen.n.rao@linux.ibm.com"
	<naveen.n.rao@linux.ibm.com>, "npiggin@gmail.com" <npiggin@gmail.com>,
	"palmer@dabbelt.com" <palmer@dabbelt.com>, "paul.walmsley@sifive.com"
	<paul.walmsley@sifive.com>, "quic_nprakash@quicinc.com"
	<quic_nprakash@quicinc.com>, "quic_pkondeti@quicinc.com"
	<quic_pkondeti@quicinc.com>, "rick.p.edgecombe@intel.com"
	<rick.p.edgecombe@intel.com>, "ryabinin.a.a@gmail.com"
	<ryabinin.a.a@gmail.com>, "ryan.roberts@arm.com" <ryan.roberts@arm.com>,
	"samitolvanen@google.com" <samitolvanen@google.com>, "sdf@google.com"
	<sdf@google.com>, "song@kernel.org" <song@kernel.org>, "surenb@google.com"
	<surenb@google.com>, "svens@linux.ibm.com" <svens@linux.ibm.com>,
	"tj@kernel.org" <tj@kernel.org>, "urezki@gmail.com" <urezki@gmail.com>,
	"vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>, "will@kernel.org"
	<will@kernel.org>, "wuqiang.matt@bytedance.com" <wuqiang.matt@bytedance.com>,
	"yonghong.song@linux.dev" <yonghong.song@linux.dev>, "zlim.lnx@gmail.com"
	<zlim.lnx@gmail.com>, "awheeler@motorola.com" <awheeler@motorola.com>
Subject: Re: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Thread-Topic: [PATCH 1/4] mm/vmalloc: allow arch-specific vmalloc_node
 overrides
Thread-Index: AQHaZDwS6FkPILIvP0qdTgNTWVgWnbEUXmwA
Date: Wed, 21 Feb 2024 06:59:01 +0000
Message-ID: <4026e0f4-f0f3-4386-b9e9-62834c823fc9@csgroup.eu>
References: <20240220203256.31153-1-mbland@motorola.com>
 <20240220203256.31153-2-mbland@motorola.com>
In-Reply-To: <20240220203256.31153-2-mbland@motorola.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|MR1P264MB3076:EE_
x-ms-office365-filtering-correlation-id: 66b64f21-cb34-4ac9-9ec7-08dc32aa958b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 GLvBbtbz2pjCp3+xnGU/zvlOULtfi+T/ZwmErPr1nE2wu1XKC2j21vhlgVDNOsHroNo109P3sDLcuPxl8BCeE2Py9CL1Aso4S39shb8hq9TxzuEKtscjMnXZwBkro3xEnGSGH9qYZ9q7+FGVmfQsN4InNBXWNPhsmuRtmotj7UbzqxWEnn1BZZLKC8kEH2W8ljDy89efnWIU5ysnDg7AYZmtI73iob31O1Z3CvkzV0QKgRqedLZIdwape2L71IZU/wkuH4qaqDGItJWpUZ6AQx4R3O9MmACJukh7Ns23CKheeJpJEzUuE/p9u95MrhCT4zJnerhP4aVF0Bb0EGSP24v5I36VNP/pJq9awR2e8rkJkGdiuc7manrH0/qqkhKqnpbhJgBsNj08L38WVhKD6WwcEc5ZsKe+YNUYI9EJS98xgmu6UIcuChC5oQ0XlfkQ0LrXCJ3RQsUESV7tbszkKQ+6rP/hHjB3XM9FLhyhzZ+vlMYaAU3x/uC0/A4ITHNDTZHa+nSRa8eYinRwIW9ehXYytOjFqoo+P27gMnmi9zJxVNrypkCT3s12EZw99U2HyEXUsk2q5eP1+u70Cf9bga2goBZo46leMQXKxcnVAqwni9kdfHzS7N/UMn7d7xoK
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MW5iUXE1eGF2SGFiVzFtcFlEc2ZyUGtsS1NsenZvL0tybjl5dndPVCtzSzc1?=
 =?utf-8?B?a0k1MmE3VGN3WHhXRXdTaGdHZ29DemhraWpqb0F3K3JrZGgzNDlSWmNmbFdI?=
 =?utf-8?B?WmNrV0tmSVlqeUppbnJtd2hoVU9xaXB6Y0JtSG1ac0tERUtrY2hhVEVROTVm?=
 =?utf-8?B?R2hxdko3WWUrVHZPZUg3NHdWbVE2R1I5dEI4cE5HZUdrdFJzbzR4V2pSVWR6?=
 =?utf-8?B?K0JmZGhEMGRLNDA5cmQzSkdPZFpEMUwrc3dUbHJ3d0tTZDZjQW9sUlZhcmJp?=
 =?utf-8?B?cnVLYVdiMkVMaHkxM2IzTEdNTTF5Y2RYWUlnQzcyTGdWa29Mbm9qd0tjSmJa?=
 =?utf-8?B?Vmd1V1V6dlRJVFdPYUJwazhiaEVmZG9KTTRHNmI3U0VobmxWSExwaENjNUha?=
 =?utf-8?B?TFVLa1dscFNtaTh1cUl6YUc4QThFbjZ5SnJkRXVxRjFtT0FHM25kYzRDYitU?=
 =?utf-8?B?RGo5R3MrS1g0RXQ1Q0o5dGVPNDJSVVU2cXppWmo5Wjl4dTNxb29JTFFDQXNB?=
 =?utf-8?B?UFNmUHBOSUJUZ2l2Z0hMZEZkRUE3Kys5bDFlTkhOaVpPdklJWFZEeCtTR3ZT?=
 =?utf-8?B?eDhxaXduRVgrM2QveDQ1QjB2bjVPVnBwTEVsWjNGZkZnWmt2ZFRSNHhkQkha?=
 =?utf-8?B?UEt6SW84bWV2aDhRelJ2bE04TmhQUllzV2h3WXJVZlhERU5OeGc1VzhVTDVI?=
 =?utf-8?B?TFFoZEcvLzFiMlM3N3kwSW5QY1craUhnWFJ5eEZPRVRWSXpITjRZVXJJNWdX?=
 =?utf-8?B?SU81dGFQbmxWSFFwTEgwcC9KblRRTmNCMkJlWEttdXRnNjIrUHNaeFA2dUdH?=
 =?utf-8?B?eFJCbkRkQWZZeEd4RVMxMkZCSmsxZGdjQkRIcWVpSDR1MnF0WnBWS0NxbGJj?=
 =?utf-8?B?Mm5KQXZGVTJxT0NGcW9nMlFoSENSS0Vjb2EySGdtNEorVll0TzRkOUZCMzV2?=
 =?utf-8?B?ZUVKVVJpRkJNa1BYallTZzlUQXkwOUlGU3BHc3Y3OXdwMUowZ3p2NE9USUh5?=
 =?utf-8?B?d0duSyt2eGRlS3RHUnBlUk9XKzhkb0UxdWorakcraWFONlJXZ0Y4YnM4ZWhu?=
 =?utf-8?B?SlE3UmZZUWl2THFzcVh1cVVCdTAyODNPRms2ZWx2VzM1M3JaSjJWdGp3RHRH?=
 =?utf-8?B?UjhzelJITVdwRGkyb2VnbEN0bXQ0TklPSWcreUtvblNCYVhreFl5WUxYS1ZS?=
 =?utf-8?B?UStUYVMra24zcjFyS0ZvOW1zeVNsOXBCYkUrRmpVNjd6VHY3UVR1L1U0OFZO?=
 =?utf-8?B?dEc5YitPNUxZR3NMaUF2K2t1U2hGVElPVlNtWTlLak9BMjBiYkoxVDJicTNX?=
 =?utf-8?B?MzNGNXhwd2FDWWlmSkZMZUM5Lys3em9HWURXK3Z4ZmtuV0ZxM3cyeHBQcXJw?=
 =?utf-8?B?YlFUZGlwQVZnS1NJeVRkL09yTkFBbW1EeGQxS3MxYlFCeTRQaFVBUnJaOExE?=
 =?utf-8?B?UHhsOGNrdzBnaUZqN0N1TlVHWFUrQmhVT0dYQU5pRm03N3ZLVkRHei82M0E2?=
 =?utf-8?B?ZnE5TnpaWmZ6T1pWd1pRWkI0VmxBZ05uV3N5V2tCQ2hNb2lvS3hwdU0vUE1F?=
 =?utf-8?B?Y1RKa21WYTBhbUFhQ0ErUFF4SmNDTFRhMVhHSWxpLzBVU2ZZNk9IZjVOcU9a?=
 =?utf-8?B?Q0tOekRTempxYlJEa3phSm9PZEZsL1NmUDg4QjhvdXRQQ09sSmtMTkRBMVpE?=
 =?utf-8?B?NE12b0hNdWdISnBwa2xYWGJLbHc1Q1luWnJkMStBK3pmQ3Z1c09LMExxKzdT?=
 =?utf-8?B?amplVG04OGNZWDlCOEMrOFEwdWNDNFNPSlRLYkh2amZ4dDRDbzBhRzNmTVl2?=
 =?utf-8?B?Z24ydVFhQW4rVjEzTXNLV1NzcWtCNnJDY3hBcEJBQnV5c1lDSHdyL1FRZDR6?=
 =?utf-8?B?aWxDSExiWWNBRlBxWWNreW1yaWM2dll6MWlLS2lod3BWUFFEWDVSQUFSSS9r?=
 =?utf-8?B?T2thTHhPQmVtdXNxYXlzd3kvUUlMcmZqcUg5TG5sNlJSU1c1MWhUcjczUGRO?=
 =?utf-8?B?bGJmWDJMM1RCSlZnWHJJSlppQUdQbUVkSEk4QlB0VDNWcEVjUFZId0VkWXBu?=
 =?utf-8?B?cGdnRnArOEVXclBHckI5MUJrN29GbUZKR3RHNVNDT25rYW0vR0IrQWwyTGk3?=
 =?utf-8?Q?sTE+ogap5VBSh3fRT6zlURyEk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58C10DCF67DC9D429B875C322586089B@FRAP264.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 66b64f21-cb34-4ac9-9ec7-08dc32aa958b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2024 06:59:01.4379
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qYjoTbkPqVMyOC3HrSZ9P/dFzqn2QIEsWmID8i7rlxiy3zp/ayfZx+ZkwC8bMZdqIjxyYO1t6xJ/lhBQI3VXUa+HL9JmkSVIZfn3ghAP1VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3076

DQoNCkxlIDIwLzAyLzIwMjQgw6AgMjE6MzIsIE1heHdlbGwgQmxhbmQgYSDDqWNyaXTCoDoNCj4g
W1ZvdXMgbmUgcmVjZXZleiBwYXMgc291dmVudCBkZSBjb3VycmllcnMgZGUgbWJsYW5kQG1vdG9y
b2xhLmNvbS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6
Ly9ha2EubXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IFByZXNlbnQg
bm9uLXVuaWZvcm0gdXNlIG9mIF9fdm1hbGxvY19ub2RlIGFuZCBfX3ZtYWxsb2Nfbm9kZV9yYW5n
ZSBtYWtlcw0KPiBlbmZvcmNpbmcgYXBwcm9wcmlhdGUgY29kZSBhbmQgZGF0YSBzZXBlcmF0aW9u
IHVudGVuYWJsZSBvbiBjZXJ0YWluDQo+IG1pY3JvYXJjaGl0ZWN0dXJlcywgYXMgVk1BTExPQ19T
VEFSVCBhbmQgVk1BTExPQ19FTkQgYXJlIG1vbm9saXRoaWMNCj4gd2hpbGUgdGhlIHVzZSBvZiB0
aGUgdm1hbGxvYyBpbnRlcmZhY2UgaXMgbm9uLW1vbm9saXRoaWM6IGluIHBhcnRpY3VsYXIsDQo+
IGFwcHJvcHJpYXRlIHJhbmRvbW5lc3MgaW4gQVNMUiBtYWtlcyBpdCBzdWNoIHRoYXQgY29kZSBy
ZWdpb25zIG11c3QgZmFsbA0KPiBpbiBzb21lIHJlZ2lvbiBiZXR3ZWVuIFZNQUxMT0NfU1RBUlQg
YW5kIFZNQUxMT0NfZW5kLCBidXQgdGhpcw0KPiBuZWNlc3NpdGF0ZXMgdGhhdCBjb2RlIHBhZ2Vz
IGFyZSBpbnRlcm1pbmdsZWQgd2l0aCBkYXRhIHBhZ2VzLCBtZWFuaW5nDQo+IGNvZGUtc3BlY2lm
aWMgcHJvdGVjdGlvbnMsIHN1Y2ggYXMgYXJtNjQncyBQWE5UYWJsZSwgY2Fubm90IGJlDQo+IHBl
cmZvcm1hbnRseSBydW50aW1lIGVuZm9yY2VkLg0KPiANCj4gVGhlIHNvbHV0aW9uIHRvIHRoaXMg
cHJvYmxlbSBhbGxvd3MgYXJjaGl0ZWN0dXJlcyB0byBvdmVycmlkZSB0aGUNCj4gdm1hbGxvYyB3
cmFwcGVyIGZ1bmN0aW9ucyBieSBlbmZvcmNpbmcgdGhhdCB0aGUgcmVzdCBvZiB0aGUga2VybmVs
IGRvZXMNCj4gbm90IHJlaW1wbGVtZW50IF9fdm1hbGxvY19ub2RlIGJ5IHVzaW5nIF9fdm1hbGxv
Y19ub2RlX3JhbmdlIHdpdGggdGhlDQo+IHNhbWUgcGFyYW1ldGVycyBhcyBfX3ZtYWxsb2Nfbm9k
ZSBvciBwcm92aWRlcyBhIF9fd2VhayB0YWcgdG8gdGhvc2UNCj4gZnVuY3Rpb25zIHVzaW5nIF9f
dm1hbGxvY19ub2RlX3JhbmdlIHdpdGggcGFyYW1ldGVycyByZXBlYXRpbmcgdGhvc2Ugb2YNCj4g
X192bWFsbG9jX25vZGUuDQo+IA0KPiBUd28gYmVuZWZpdHMgb2YgdGhpcyBhcHByb2FjaCBhcmUg
KDEpIGdyZWF0ZXIgZmxleGliaWxpdHkgdG8gZWFjaA0KPiBhcmNoaXRlY3R1cmUgZm9yIGhhbmRs
aW5nIG9mIHZpcnR1YWwgbWVtb3J5IHdoaWxlIG5vdCBjb21wcm9taXNpbmcgdGhlDQo+IGtlcm5l
bCdzIHZtYWxsb2MgbG9naWMgYW5kICgyKSBtb3JlIHVuaWZvcm0gdXNlIG9mIHRoZSBfX3ZtYWxs
b2Nfbm9kZQ0KPiBpbnRlcmZhY2UsIHJlc2VydmluZyB0aGUgbW9yZSBzcGVjaWFsaXplZCBfX3Zt
YWxsb2Nfbm9kZV9yYW5nZSBmb3IgbW9yZQ0KPiBzcGVjaWFsaXplZCBjYXNlcywgc3VjaCBhcyBr
YXNhbidzIHNoYWRvdyBtZW1vcnkuDQoNCkknbSBub3Qgc3VyZSBJIHVuZGVyc3RhbmQgdGhlIG1l
c3NhZ2UuIFdoYXQgSSB1bmRlcnN0YW5kIGlzIHRoYXQgeW91IA0KYWxsb3cgYXJjaGl0ZWN0dXJl
cyB0byBvdmVycmlkZSB2bWFsbG9jX25vZGUoKS4NCg0KSW4gdGhlIGNvZGUgeW91IGFkZCBfX3dl
YWsgZm9yIHRoYXQuIEJ1dCB5b3UgYWxzbyBhZGQgdGhlIGZsYWdzIHRvIHRoZSANCnBhcmFtZXRl
cnMgYW5kIEkgY2FuJ3QgdW5kZXJzdGFuZCB3aHkgd2hlbiByZWFkaW5nIHRoZSBhYm92ZSBkZXNj
cmlwdGlvbi4NCg0KQ2hyaXN0b3BoZQ0K

