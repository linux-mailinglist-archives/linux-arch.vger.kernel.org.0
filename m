Return-Path: <linux-arch+bounces-6678-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA6D9615A2
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 19:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D28E1F23F88
	for <lists+linux-arch@lfdr.de>; Tue, 27 Aug 2024 17:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053351CCEF3;
	Tue, 27 Aug 2024 17:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b="DPllcDrH"
X-Original-To: linux-arch@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04781C57B3;
	Tue, 27 Aug 2024 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724780340; cv=fail; b=sTY1/9/4bPP3o1V7GF1HbWmOZ46YKPPHFmvbP09aO/UBhV3fCVj+Ah0ybi7ONwnW5yh8ABetcBW9kKNzoSItaEG2prItBanitLJnKaDki8xMhq1kjpM/8dlvvPI6RnMKSvyqWoIpS+oavUZRwU8wDF3tFbz+NSXpIbqXEu6MqKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724780340; c=relaxed/simple;
	bh=0MGkpeEdz8DziYqz1Vo7/lkRGGd9j+tvGbKCtLJtxUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=h2XZTOdYZO8iahRBoa0zdJ6+s6WvJnxQdP3ekttrtkI9T91YFzSkBEqE25jWIiKlaG45aymLpBg9mNnIu06XovI2UduCmAhlsP+eTLsp9IsoKZlK9q8cBCXLO5hTZyuFm0kc74vCmmdI4T63LzzaZC3YKj8+B1+dcv5N/m4wnMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com; spf=pass smtp.mailfrom=cs-soprasteria.com; dkim=pass (2048-bit key) header.d=cs-soprasteria.com header.i=@cs-soprasteria.com header.b=DPllcDrH; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cs-soprasteria.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cs-soprasteria.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzUGRcrZklsfpLK5tonWL5rwYvW842znIg8gywOK8gYADS3t7WRDimGbaKZN5ewzlIZs0WgD1KD+FdeqFTO/2/PtxZyzCJZSAVbu6qCdWnQ9iawXo+uR6YXabhiaHi+vzI4tkp56fRyz4LdpmVpNbykuwSQswMiwzxKXPR5ed4eEVQYaceIFdX1/Kw/tB+WvPUwEDWLf57mu+vsst+U0uTf2BI8zgcWnTBkVLIPVFRdoWwpZirhWrAa+yblAnKvyTUmsyzLPFF2DsGuRWpOLp/oGYSalHakgkkQX6BNzCXFVoDxWZeUAUT6gF45yP9Ka8N7v7bVIhq5W0FJ+DcWzRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0MGkpeEdz8DziYqz1Vo7/lkRGGd9j+tvGbKCtLJtxUY=;
 b=g84/Nwo1VyHiZH0tA4m5VOU2f3HaTu0rLUrnN4wjYB0ynStEAKsMXAhzLqMt5E/VKFtTDeFtxB+k3fA/BhruIpfkk0joEtyu1VvFCdoxqEplljQCxgp0310bAoQXNJ53EMpPYrLt4xo1b1CErBj/ZQhv2mLzwegM1yvW21X02lECQ+w7e8MDamtc6RT5kT/nQdp7FthvdXF7g44uUqgVuiIhsrkf7DGLNSK2t0P7HnxiFQZmsJQM5koQofi3EAm0QdpKuEFQtarU0Z+u1VRxDpcGEiQk+UnJDdci9fXsv4/dnOxg3rwid+yYdeL1TUbIV1BFdyxrlqXsjhxDaplaVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cs-soprasteria.com; dmarc=pass action=none
 header.from=cs-soprasteria.com; dkim=pass header.d=cs-soprasteria.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cs-soprasteria.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0MGkpeEdz8DziYqz1Vo7/lkRGGd9j+tvGbKCtLJtxUY=;
 b=DPllcDrHmYnajuijCvZuQy+j4IJ68Hon4AksJfcHaIL9IlgsAw+UI0cHa+hIzaxAXXp1C3eTH3iQdEfy7sA0SUMNZw5hN/yxqjqib4+ukAZ36mnIZ2XxW1O1oDQoMMo5HPUstEP12xAS1ojK66NpQ40sSFVvba/HuFwzAxX/ag5elaJaemPCiZqFB2M2JOD26iC1HdruTMIg+ByLgTEkYxvgiX0RfgAV0yysQH9cw2AsduZR0SPXxeeNBHqZSM0c6+A499Kdg3ADkl8aZQjy9637kJQYViUae7L9XkhtuU9ZBX0GKGMyBR6OBHWEjxn1Kz81T/f92ZI1Ruc3HE6uYA==
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com (2603:10a6:208:f3::19)
 by AS5PR07MB9746.eurprd07.prod.outlook.com (2603:10a6:20b:673::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 17:38:55 +0000
Received: from AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2]) by AM0PR07MB4962.eurprd07.prod.outlook.com
 ([fe80::6724:2919:9cbb:2bb2%4]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 17:38:54 +0000
From: LEROY Christophe <christophe.leroy2@cs-soprasteria.com>
To: Vincenzo Frascino <vincenzo.frascino@arm.com>, LEROY Christophe
	<christophe.leroy2@cs-soprasteria.com>, Arnd Bergmann <arnd@arndb.de>, "Jason
 A . Donenfeld" <Jason@zx2c4.com>
CC: Theodore Ts'o <tytso@mit.edu>, Andy Lutomirski <luto@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	"x86@kernel.org" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Linux-Arch
	<linux-arch@vger.kernel.org>
Subject: Re: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
Thread-Topic: [PATCH] random: vDSO: Redefine PAGE_SIZE and PAGE_MASK
Thread-Index: AQHa+FrbziKvfehcY0mAspZaxoQH97I6yOKAgAAWAICAAGYw9oAAGjEA
Date: Tue, 27 Aug 2024 17:38:54 +0000
Message-ID: <85efc7c5-40c8-4c89-b65f-dd13536fb8c7@cs-soprasteria.com>
References:
 <b8f8fb6d1d10386c74f2d8826b737a74c60b76b2.1724743492.git.christophe.leroy@csgroup.eu>
 <defab86b7fb897c88a05a33b62ccf38467dda884.1724747058.git.christophe.leroy@csgroup.eu>
 <Zs2RCfMgfNu_2vos@zx2c4.com>
 <cb66b582-ba63-4a5a-9df8-b07288f1f66d@app.fastmail.com>
 <0f9255f1-5860-408c-8eaa-ccb4dd3747fa@csgroup.eu>
 <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
In-Reply-To: <17437f43-9d1f-4263-888e-573a355cb0b5@arm.com>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cs-soprasteria.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM0PR07MB4962:EE_|AS5PR07MB9746:EE_
x-ms-office365-filtering-correlation-id: c9f57336-495b-440b-bbb8-08dcc6bf1f51
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?NnVIVmFLTG1ENEwvN0tRak9WWVBlbU1LMTJDb3ZPR01ZWTFYUUVSek5GOVFo?=
 =?utf-8?B?Q0ZUWlFIdnJPZWhvaHQ4TTMwYUhvRW4zVmROcEFFa3VtQWFBSXNoTlpJR3hw?=
 =?utf-8?B?M1pIZ2owWmRrZXErRXROY2hkL0FORHdMcEh2Z2xOeTBJc0xabFZ1OWxKbHU5?=
 =?utf-8?B?YVhjazdwUFhMK0JZNWZzNFlySk8zTlZZOHlKTllIc1h1bWhMRFdWQ1RtcjBi?=
 =?utf-8?B?a2JRRkhLb0NJdEJhSGRSQThtc3BCbElLNVJEVGdmWmpiWEY0dUp6ZVpDRDQ2?=
 =?utf-8?B?MWRGRnRyNDU0UHd3Qng5UHhmdTl5Q3BlbnhKUkdZUTNHZmpTd0M1UnJYZ285?=
 =?utf-8?B?SkZoVDNiaWRzelZ6NnNMZlhyaWRQNVNleHVIQzRUM3BYOWZkcjRYRHFSZDh6?=
 =?utf-8?B?WU5QOEdrczRwcUMyTXl5aGRiWjlxeGN6REZjaUZpcmZhVTBaNktQSmpDWGZa?=
 =?utf-8?B?OS9EbHJjQlpHTE9pdW15WXBtRUdISGFpcEtJWWYzT3lmZ3BkcXVEUUFrSUp3?=
 =?utf-8?B?VThxUE9CWXhWaG4rZkxjQnpNbmNBTzErTXFnSzN5bGgzZEh4ZWRLLzN2eTVs?=
 =?utf-8?B?b2ZhdlcrWWNRZTZPd09RaGE3QXNFMVZTbmYrMHNta3ZlOU4xOU91UmZQbm4v?=
 =?utf-8?B?bHV0UUdyb3prQ1ZsOXdtN2ZGVCtVdW4xYlg0bC82ZVl5SUt0bzRNZklyVUtK?=
 =?utf-8?B?bDFLS2p2cHBBeFBXZUpnZ2EwN00rTXZIaVFBVHgxbDVBcFNEOHdGeHNuWFlJ?=
 =?utf-8?B?cGtDbkRHRHhkYXkrQThWRm4xaERaQmZ5L3JlclY3Y1pFMUowWGNYdmtJSlNv?=
 =?utf-8?B?akZjQWNZOVhZbW04RDNEcGIxb3pOT0o3L3lwQm1HOG5YeUFtdDdzSHcrUTMw?=
 =?utf-8?B?a0tWcWtLT2RXSmZMUVJ0bFlnVG02TEJiQ3loWmtsdzFJTkROUTFJYUVZUFQ4?=
 =?utf-8?B?Z1BYS1ZnVzNrOE9PZ0VwQ0IyakY5U3d0OVZFT3NsTC9oU01uMC9qZE1qbkpP?=
 =?utf-8?B?RTVibTNJQWQvZHkxYVQ4emR2bXdQV3hHclFPcGVSVG9pRHFTYUFjWkE2ZHFX?=
 =?utf-8?B?RXpTYUNPbjcrUXpJdHlCa0xxSHRUcFZlV1NFUVM0QW1PSHNLMWQrb29FWlRw?=
 =?utf-8?B?SWtXRjFBWmU1MXNHWnBIVlVENjZFVEtYRlB5VUpFY3h3RTZJeDJHSmliZCtO?=
 =?utf-8?B?VTRoZ25iZjlzeXlHRzlneFoyeWY4QUJyL05rWUhiQ21SZE9XZE5JV0xUaUVn?=
 =?utf-8?B?QjZHcXpYWlJnR1VLemVXSnhxaVdIMkwyMVRZT3JDVHZudFU4T2psSjBtaTNC?=
 =?utf-8?B?bHFsVCtHSUU3QjcyQ21tLzUwQ0JKTVg5RU80YkMxWXZwVjFWSGxhMVg1Smkw?=
 =?utf-8?B?YmVoVGxZUlhsaU5lSVorTzVjc3R1SE1IcG9HSUtxUHlDZ2NLTUlsM2FFRitv?=
 =?utf-8?B?YU9ncDVQTUg1cEJjbjVqRnRsY2p4RkF0WkxIRVJIWkU3S1RyaWFCYXE4MGFH?=
 =?utf-8?B?T1ZjUVZ5Qkppc0lieXZRV3dBam53QVUyUHFIUGpNV2xTY2lnaERiU3VvdEdZ?=
 =?utf-8?B?bkU3czJsK25iSDVEL1U2ODJ0NTJSSDNaMUE3S1dYbGxoNTFRbUVXcWx2eDRL?=
 =?utf-8?B?MHVqRGpHYnI4SVZvbHJvWUlCS3JseUNaMXJkTWkwMUZsZS9NY0ZGY0hmRDdw?=
 =?utf-8?B?UXhnSS9BNndOdjdnR0xJWFJFeXE4bkZjRFhicWFRVGFXakRiQWpwZXlaZkM5?=
 =?utf-8?B?QlduZDBPejFKckY0ekNUbWlzUlg2ajBWZGhrL3J1MW5ESVVUV1FzTFFTTmFv?=
 =?utf-8?B?YkNFMkg5UGhwWE5OTEo4K1loN3o0N2crV3RJcm91TjZPUThrU202NG82TjlF?=
 =?utf-8?B?N3psOHpnRisyRm0vSC9oR1d2NjRBbzllMTIwRCtlSytUR3c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR07MB4962.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cEJkMSthU2xJNnJPV1hzZGVhcnNJeThMbzlzWDNMVXBTb0c4NUNxTzNRVkxt?=
 =?utf-8?B?SE85cUVSNDE0WnNXbW9wdjZDUnpSSFRXMDFHN0JBc2FTcTB3ekNQYzNZSStE?=
 =?utf-8?B?eEprNUFGMWs2aTJ4NUtRbVYvU2dNNC9zdm1MREFLTW5peFRJRFFER1FWdW5u?=
 =?utf-8?B?OHZBWDV0cy82ZXQ4MGJDR1k5dXN6eVptem5pczd5eGsxMEpTdFAwclJTdFM3?=
 =?utf-8?B?VUt5Q0JCc0tTb09FODdOaEVlaFp3dzJjN09jTDM0eXV4RUZzNHByWUYzSHps?=
 =?utf-8?B?TE5YK1BkV3FhMVlrREIrS3FzYjRENFZBZUhmTUtSYnhGWEJqUHZuUm45RjF2?=
 =?utf-8?B?cHhCMC8ySURheFBQV3F3TEw2YVJ1YXBpTWp1anpNZHg5REY2SVpEOHV6cVE1?=
 =?utf-8?B?OVNPTnBzWm1JekFXVFNweGROZnJKOVd1V0xONlB4OHNNK3I4S0FILzkyRDZO?=
 =?utf-8?B?bTE0VWYyc3RIRUhVY1I2SmhSWnVZck9Wd2tOSEpWaHBhMTlHOEpiY1FQNmVi?=
 =?utf-8?B?VGdnQkxlbmMyMmRDQ2FjdnVrOGJLNWRZK3ZDWkNJOXlpU0lGVDBiaE81Uldq?=
 =?utf-8?B?WElIdVhoY0lGWEJzeS9sSzFMa1p5ZnJweE9UR2dVTnFTZmFpUkNiYU1rVzhj?=
 =?utf-8?B?RVNPVXU1V2wzTk5BQkIzSHJuc1p0QVQwRTlzNXZwMjVBY2gyYUhFcDRZL2ty?=
 =?utf-8?B?R1hsNjU4aHI3QzFuOUJWWnBDWFdkdXpTazZSZjNoaXdicFlGR3F6YXdoZXRt?=
 =?utf-8?B?bHNCVjNjazBzUXVnSE1pSHpIWEFIc2xhRkdJZ0hEL1J1WHdKWi85NENmcmxL?=
 =?utf-8?B?NlJZYUJGMWQzNFoxVmlRMnFiZUJjUUQvVkcwcE5vczI5enVHVFcwTEFOWjIv?=
 =?utf-8?B?cGZiYkNaN1pyMjFjU1J2STlUcDVLZ2ZFcmJLK0RJMHBaTUhhYXh5eXdyVVhk?=
 =?utf-8?B?SEFSekMvbXhPY1lkays3THA2OWRqMzJxNlRVUTZ4RkZTSG81Q3AwaHA5MHdp?=
 =?utf-8?B?L3pnSmxYTHh6YkRlUGFOSGh5UE9sK1EwRC80WXVwdW15TzVjeHp3N1ZiSnEx?=
 =?utf-8?B?N3ZsRlNsSEl4WFowczdGYVNFNDErZzBhV20vRlZlZU9zQlk3TC9DVkROSU9J?=
 =?utf-8?B?Unp6cWJ4dmVNZzlTbW4vZ2tRcWdGR1NJL0FwRG9uSjlLcS9UZ3hoMDBvVnly?=
 =?utf-8?B?eU5uaCtnWFdqejJBSDNpdXA5R3BscVdQeEYzNXZMcW1iQmlSU0IzMkpnZnJ6?=
 =?utf-8?B?NXNIcnB1M2lMZEhVWTl3RldwMkN5UkpYeU1zSTA1S0NEMlI0elVMMm9iUlFu?=
 =?utf-8?B?RVNVdnorYWJoOVpTbDE3VE56NjJrc3RCRXRFYXhTSVZORzA3RVdoSVp3elMy?=
 =?utf-8?B?eENOSXhwTUplaWlQZjhFcDA4bTJscGowNXJRTHNNZk01ZVpGV1dleDNtajQ2?=
 =?utf-8?B?Wm1kOVB3Q2RKZkVhRkRmYjJHWktTNWFEckZTS1NXMWdWcG5NY09iSzI4aVZS?=
 =?utf-8?B?TnE3L3VBeWs3SVNXTnh2OTVkcHBlWVlDeHkvdE1LdDl2ZWZOVnZFYUM2Z1NP?=
 =?utf-8?B?NzhTajFTMkxWZW1kZThyZWprTGNzWGc2eVNja3RsUG1PRkUybXphZHc4T3Ex?=
 =?utf-8?B?OXIyVHpnQlBXZ1ZCdGl1WEkvSEtYVXVSMXVLaVJ3NmhNTUNvUk9kSVZZcUxr?=
 =?utf-8?B?TXhNT3NCVVBlMkFoNzRCZXd0dHFIRHdmaUlOS29LZUR2T3VHT2FjOWx3Zk5N?=
 =?utf-8?B?Y01RQVdWSittbUlMakkvaENGQWV3QVJPZExIajAwVDlOSVdKUkc0cUgrSlRq?=
 =?utf-8?B?Y0wwVDBqaDc4NXlCZEpaT2J4V2xaWUlucGc3Q0wxbDByRlpDazRQcXR0d1ls?=
 =?utf-8?B?TGFrVi9LcVZqQVd1VUYrOTB2a3RQeGZSUFBQMVRvRVBOMWNkVy9RdHlLV1A5?=
 =?utf-8?B?SFllOEdsRUR3eDhqSGVGNE5Fd1pDOGhlVjhDUmhBRStHWXdsSitkR1d4eG4r?=
 =?utf-8?B?TUlOcHBjdzl6OWUyYkQrNWt3M21aOURlV2JWalFINWlLQ0RpMU9WYzRKcThx?=
 =?utf-8?B?Q2U2ck1OR3B0U3dMSkVTKzhMaHhHY2c5Y3R1NTRCdDR4NzRpbjdDT0hDOEQx?=
 =?utf-8?B?QnJOUHZtbXRZelhZOFlmc00xWTdOQWtqL2Ezc2FEM2IwdktOcGV5OS9GWUw2?=
 =?utf-8?B?a1lHU3ppdVV3RDBHcVQwSXV3M3lMdnMxT0dvVTFqZ25DK2dsVG1aSWhKTDNt?=
 =?utf-8?Q?kPf/0nGEWEPMhQBBZ281rz4GsRf0VLGmJBwFxRRwZo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2966B3EB6FE4A48BC896E788ED0C3C1@eurprd07.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c9f57336-495b-440b-bbb8-08dcc6bf1f51
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2024 17:38:54.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8b87af7d-8647-4dc7-8df4-5f69a2011bb5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bGBZyNPtpmU743KqZUKuMvWQ06cnzL034eedAUxUoYyVJr4FEbJ/1osf9j+nPAUqwly3zsDblcvgr4Iy9LAM77EgV+/iDwpYPX6kN2JsIyT/mC/UDEnWbtKZkkXIGwss
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR07MB9746
X-MS-Exchange-CrossPremises-AuthAs: Internal
X-MS-Exchange-CrossPremises-AuthMechanism: 04
X-MS-Exchange-CrossPremises-AuthSource: AM0PR07MB4962.eurprd07.prod.outlook.com
X-MS-Exchange-CrossPremises-TransportTrafficType: Email
X-MS-Exchange-CrossPremises-SCL: 1
X-MS-Exchange-CrossPremises-messagesource: StoreDriver
X-MS-Exchange-CrossPremises-BCC:
X-MS-Exchange-CrossPremises-originalclientipaddress: 2a01:e0a:511:aad0:9f10:86ad:5cd0:9703
X-MS-Exchange-CrossPremises-transporttraffictype: Email
X-MS-Exchange-CrossPremises-antispam-scancontext: DIR:Originating;SFV:NSPM;SKIP:0;
X-MS-Exchange-CrossPremises-processed-by-journaling: Journal Agent
X-OrganizationHeadersPreserved: AS5PR07MB9746.eurprd07.prod.outlook.com

SGkgVmljZW56bywNCg0KTGUgMjcvMDgvMjAyNCDDoCAxODowNSwgVmluY2Vuem8gRnJhc2Npbm8g
YSDDqWNyaXTCoDoNCj4gSGkgQ2hyaXN0b3BoZSwNCj4gDQo+IE9uIDI3LzA4LzIwMjQgMTE6NDks
IENocmlzdG9waGUgTGVyb3kgd3JvdGU6DQo+IA0KPiAuLi4NCj4gDQo+IA0KPiANCj4gSSBhZ3Jl
ZSB3aXRoIEFybmQgaGVyZS4gdWFwaS9saW51eC9tbWFuLmggY2FuIGNhdXNlIHVzIHByb2JsZW1z
IGluIHRoZSBsb25nIHJ1bi4NCj4gDQo+IEkgYW0gYXR0YWNoaW5nIGEgcGF0Y2ggdG8gcHJvdmlk
ZSBteSB2aWV3IG9uIGhvdyB0byBtaW5pbWl6ZSB0aGUgaGVhZGVycw0KPiBpbmNsdWRlZCBhbmQg
dXNlIG9ubHkgdGhlIHZkc28vIG5hbWVzcGFjZS4gUGxlYXNlLCBiZWZvcmUgdXNpbmcgdGhlIGNv
ZGUsDQo+IGNvbnNpZGVyIHRoYXQgSSBjb25kdWN0ZWQgdmVyeSBsaW1pdGVkIHRlc3RpbmcuDQo+
IA0KPiBOb3RlOiBJdCBzaG91bGQgYXBwbHkgY2xlYW4gb24gSmFzb24ncyB0cmVlLg0KPiANCj4g
TGV0IG1lIGtub3cgeW91ciB0aG91Z2h0cy4NCj4gDQoNCllvdXIgcGF0Y2ggbG9va3MgbmljZSwg
bWF5YmUgYSBiaXQgdG9vIG11Y2guIEZvciBpbnN0YW5jZSBnZXRyYW5kb20uYyANCmNhbiBpbmNs
dWRlIGRpcmVjdGx5IGFzbS92ZHNvL3BhZ2UuaCBpbnN0ZWFkIG9mIGNyZWF0aW5nIHZkc28vcGFn
ZS5oDQoNCk9yIGNyZWF0ZSBhIHZkc28vcGFnZS5oIHRoYXQgb25seSB1c2UgQ09ORklHX1BBR0Vf
U0hJRlQgYW5kIGRvZXNuJ3QgDQppbmNsdWRlIGFueXRoaW5nIGZyb20gYXJjaGl0ZWN0dXJlcy4N
Cg0KV2Ugc2hvdWxkIGFsc28ga2VlcCBQUk9UX1JFQUQgYW5kIFBST1RfV1JJVEUgaW4gZ2V0cmFu
ZG9tLmMgLCB0aGF0J3MgDQpiZXR0ZXIgZm9yIHJlYWRhYmlsaXR5LiBTYW1lIGZvciBNQVBfRFJP
UFBBQkxFIHwgTUFQX0FOT05ZTU9VUy4gSSBjYW4ndCANCnNlZSB0aGUgYmVuZWZpdCBvZiBoaWRp
bmcgdGhlbSBpbiBhIGhlYWRlci4NCg0KSSBjYW4ndCBzZWUgd2hpY2ggaGVhZGVyIHByb3ZpZGVz
IHlvdSB3aXRoIG1pbl90KCkgb3IgQVJSQVlfU0laRSgpLg0KDQpJIHRoaW5rIHlvdSBzaG91bGQg
YWxzbyB3b3JrIG9uIHJlbW92aW5nIGhlYWRlcnMgaW5jbHVkZWQgYnkgDQphcmNoL3g4Ni9pbmNs
dWRlL2FzbS92ZHNvL2dldHRpbWVvZmRheS5oIHdoaWNoIGlzIGluY2x1ZGVkIGJ5IA0KaW5jbHVk
ZS92ZHNvL2RhdGFwYWdlLmggOg0KDQogICAjaW5jbHVkZSA8dWFwaS9saW51eC90aW1lLmg+DQog
ICAjaW5jbHVkZSA8YXNtL3ZndG9kLmg+DQogICAjaW5jbHVkZSA8YXNtL3Z2YXIuaD4NCiAgICNp
bmNsdWRlIDxhc20vdW5pc3RkLmg+DQogICAjaW5jbHVkZSA8YXNtL21zci5oPg0KICAgI2luY2x1
ZGUgPGFzbS9wdmNsb2NrLmg+DQogICAjaW5jbHVkZSA8Y2xvY2tzb3VyY2UvaHlwZXJ2X3RpbWVy
Lmg+DQoNCkFzIGEgY29tcGFyaXNvbiwgdGhlIG9uZSBmcm9tIHBvd2VycGMgb25seSBpbmNsdWRl
cyB0aGUgZm9sbG93aW5nIG9uZSBzbyANCml0IHB1bGxzIGEgbG90IGxlc3Mgbm9uLXZkc28gaGVh
ZGVyczoNCg0KICAgI2luY2x1ZGUgPGFzbS92ZHNvL3RpbWViYXNlLmg+DQogICAjaW5jbHVkZSA8
YXNtL2JhcnJpZXIuaD4NCiAgICNpbmNsdWRlIDxhc20vdW5pc3RkLmg+DQogICAjaW5jbHVkZSA8
dWFwaS9saW51eC90aW1lLmg+DQoNCkNocmlzdG9waGUNCg==

