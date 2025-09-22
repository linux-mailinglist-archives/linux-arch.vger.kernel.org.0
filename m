Return-Path: <linux-arch+bounces-13713-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D5B9188D
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 15:57:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E0327AE397
	for <lists+linux-arch@lfdr.de>; Mon, 22 Sep 2025 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C130E0E2;
	Mon, 22 Sep 2025 13:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="fegiFJNF"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020075.outbound.protection.outlook.com [52.101.191.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F1F192B66;
	Mon, 22 Sep 2025 13:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758549459; cv=fail; b=p0LSN/lHbpvaio9X4oINn/EwI+2oCZfe6+cFYUcm9CapCW/S03fd6ue408s8KxB1KyFU7BZGAHpIu7iu2eq3DcEUPM/9xZSCcedPHawUL0qP2hsBUIVqnzkSfqvE1LrXw2cJ4lkQx8yKSldLNXQ8TaAKU6qVIbandtrVAFV/oz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758549459; c=relaxed/simple;
	bh=Nscl+rVHgPdKN2qt4KSio0c1M6605C/Bixtt94YYjgE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=OydbbF2RZ6WF58jqOOXxPpNMM1yB2g3uta8h04dCNQY/YF7nlQDpv29qGP+uWKZIj4d7+GuB1nSrOEUVU69d83568e04XpbWjEgTHe3V3yu3s0HyK1GknxD+3Pqjsm2tDJQuySIJDDeHlBTj/legoZEHzz2yBhm/wYSCmqrNuTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=fegiFJNF; arc=fail smtp.client-ip=52.101.191.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RlDBCIw/KolXD4expexfHJPCGV4ucwjbqc5wvBweJ9+Jj3kWGjaayRtIRPQHRnLEyQPLy/Cd6DiIP90UZ6+uAIGUuFSeu+QBy/q1e8Oz1eu6ucg+io0DsRrAmFd/Sx8cKYDAKrSjN3MsuHljQ4c0IB0SBe09WHiOi9xZU/JBd7dvud4svwxf2waWGgxdSEqyEwMoVJZzKolro7jyGSWZ6oc4+Uom2OU0jSH+5xyGRE6DSh+rcTa9RLMGiw12We44HbLKMf5v+mNLB2OBzFkBTBLsrwSmHhx60yz/oyGNWG8zwISZ5/sVONdW3P4H9Kkv0ScXqt1ItACY+8FgifZhFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=njTsTaKJyxhMItmYuqzFgXI+Z2kRhYzRF/iO7yzGQwQ=;
 b=IaY1S0pW199upNibSf9Ad3FV3z3Mw9cDM9RJ5D1vHkY4AKaRqQYqB4US8SW1XWEoPwN/iutFXcypUqXzkQcCh68HMsuR92uvOZ4IJBtw5U3cG/72Hy2Bh/rvqLpsZGXI4f/2EPwa9tSk2cnXhkE4vbafwlWCO34wyYYwJsTXNBy2Mw+7UJB1AlgxnqgPMvsyVthDdbkhgO9g1wzuoBNMtb4ZLXWIRbE2NuquI8Tdwr5dSDNniECnJ4Ki/SnYGr6D1ukYsxxKnxTBZA3fw8Vz+GuUM4/IrwBHZvhzPlX7xzzLLiPdNd19ewXBJlBoSjKH4JmjWkuIBHhKLdc0soYn7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=njTsTaKJyxhMItmYuqzFgXI+Z2kRhYzRF/iO7yzGQwQ=;
 b=fegiFJNFcnBt5vROQVBysiUVxjbTNnPGr18jrlwIC0ZIGTvKqt+na+tyzd8V0GaqLntVE4VcnXQekBQuiTF7zdgog1bXIL/fq40IEbRCUJDhHZR9nKvNjllDQWjTG5uZAtSQq29flGTFOaTsXNiJpx0WqBhAteH3sm0/8M1fMePps9b+ZXcz7hc9Tvpv5f/kcCIqSEvQ1KfHg8VJFMKTA1s+bk3Y1e8K6PLBO+r32AR6GU/q7U7mhrRI4stXlL6NT+mzRQmeAQbxbtbx79YkC7yUhVRIGxXtjYK+nMsjIfvuERQw+5Gi4Aa6Z4oOoTWJ9hPFTGOBCfB9N+npopo/eA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YQBPR0101MB6427.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:4a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Mon, 22 Sep
 2025 13:57:31 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%5]) with mapi id 15.20.9137.012; Mon, 22 Sep 2025
 13:57:31 +0000
Message-ID: <fd5abd03-0198-44cb-8cfd-b0d2cf44a35d@efficios.com>
Date: Mon, 22 Sep 2025 09:57:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 02/12] rseq: Add fields and constants for time slice
 extension
To: K Prateek Nayak <kprateek.nayak@amd.com>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
References: <20250908225709.144709889@linutronix.de>
 <20250908225752.679815003@linutronix.de>
 <736A5840-3372-453F-8F78-5861AFA0F140@oracle.com>
 <228e2fb7-e141-462c-8796-3cf78aa01902@amd.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <228e2fb7-e141-462c-8796-3cf78aa01902@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0299.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::14) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YQBPR0101MB6427:EE_
X-MS-Office365-Filtering-Correlation-Id: 380ad98c-41c0-4fd4-c825-08ddf9dff97f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDRLanZjeDdUdkw2bW83a3pvSGNWdDNqSHZKZ1hHN25VbWJaeE0vNG9XZ1oz?=
 =?utf-8?B?QjI1OEdyaWtIOXc1UXlQYlBBeVlRdWZXS0YrQWMxbUUwTVZ1NDRUTEpGclA2?=
 =?utf-8?B?NGJvVHQ0NEtpNG9GWU5nUTRrK2diZkJCMTRZZWJFcGJSSnVKM2dTclZrWTE0?=
 =?utf-8?B?QnBidkk0dTNiUXRNRTBhcmtOYlQwM2NLYnBpMlBZS0NrbDBOM0dpL001QnI5?=
 =?utf-8?B?Yy9ObWV1SFVNbWFzd3ZHY0FzWVphUzRaMmFKZVJiTUl5M241Z1RqdTZmTzlN?=
 =?utf-8?B?VzZCYkh2OUhHRXlaQnZNaHpCT29SaWdTMEZpNHNDUHRLU2xYVHg2eWp2cWo0?=
 =?utf-8?B?ZHZrRzVObEgzT05xWHpDWHRMVDJOSURxNU1uWlMzckRhdXZWZTA0SGR4TGd4?=
 =?utf-8?B?SmpmdzJSbWNNcUFQd3J2cTJQS3prd3pMcmRvQ3BwNEduWjRqOGRueUFydUdv?=
 =?utf-8?B?aTNLZysrYVZoUVRVUzNGM2xvb2dMU25IdTBRbjhpTkg2QWNkVE0zR1htVmxw?=
 =?utf-8?B?NEZaQWU1MWMycE1GdmVXMmdlVFByUlFoTWM0c1pkbExheG1tRlBtSkt5QlVn?=
 =?utf-8?B?NFovUk5aUzJ5bEVNZzlnRWRNaXh4K0hzWFRJUWZWVjRxazBjNHRLSzUxcDEw?=
 =?utf-8?B?UzlIaENNVFdrRm1tVWd5clZCRnYzMVg4Q3VNUTBCUmRaSWM2TG56WkFocTJv?=
 =?utf-8?B?WmNIOCtQU1o1OS9obiszUFIvcWJVMi94K0NoVzJwb2xiRk9VZWtzNHdjZnhP?=
 =?utf-8?B?bXdxd1c2aURJZG9SOEhVR01jUy83ejUwZjV3YVdsMzNYR1FseVJsY2xIdHBh?=
 =?utf-8?B?ZjJseEFuRGlFcVMrQ0lva3lKNTIrRHVHN1piVWlYRTh6RURpdjdxUnVOY0d5?=
 =?utf-8?B?QW1xK3NYcXJWcHRyd1BQZXMxWGFhSHh4TWdYZUFxd3dHdzcvcy9mTjR6TjdU?=
 =?utf-8?B?U00zaEkwOXZjckIyUDZrMlg0bERLeFdsckczV29McWd5RVErRFRFQTdHaVNx?=
 =?utf-8?B?dHFCL21hbXdnRnAyYWhZNllTTCs0QXdSSG91V0tnbEVKd3cyMXQ3NFdUL1kr?=
 =?utf-8?B?bEIwZWJ4ZmQ3RU5qT2RVRERwVmRoM0Nkc2tZZ3lhN284ekpXNDZCemZUTnlt?=
 =?utf-8?B?dTNNUUVTVFdFeXBrV28yaXo3NjBRRUI4OWx3U3ZvQ1FnYm8vRXlnN1N5bllX?=
 =?utf-8?B?Vm5SY1BucytjZG01Rkt3ZU51UHBmQzdEdWRuTU1JWjlKb1dZZ0dRdDhUUUN6?=
 =?utf-8?B?YjJiWGxxZHQ0anpNRDRycFBEMmovUnJ3N2UzUjl3cElMWDZrQ3czb3RCQ2J6?=
 =?utf-8?B?c0VINDNvd1NaTE54TFoxdnlWN3pkS3I2KzRIY3ZYWEVHOFFNVkhEeWZVS29I?=
 =?utf-8?B?cWJpR3BZU0xacEJaQjlYOTZWRHBLVzBzdXF3U0toSUpxaGdMTFZML3h4Nlhx?=
 =?utf-8?B?ZlJxV0tjeWRLNmljZVdkamxJZjcyMi9uZmJWOHVyMDhWK0lVZ1lIclNXUktH?=
 =?utf-8?B?UGRqSEpHelhRbTJMZkEyMGdzOEhkWU9DQklxaEJHemlwemM5OFBZMTJmQWE4?=
 =?utf-8?B?azNkeXNmR3NIV1RmblNOV2tYZ05kZVdvSG1OTDRFSHlXaDRXWFM3R2QvZmY2?=
 =?utf-8?B?aWRDY1FvRkZSakt3SlVSZk83amRnKzlEczRGRHB5UXArdjlLek5IdnVUN1Y0?=
 =?utf-8?B?N2J5TUV4S083QmZ4SGlteHNaNmpmTXFrQ3Fmekx0RDg4enFtOUNUTC9tVURF?=
 =?utf-8?B?cHdOdDRnWVVaM0pmdUM5RWdtKzE5bGJwSUllbEcvMFJLRlZLNkN2eU1FdzA5?=
 =?utf-8?Q?MLv29EXXQ8gbuHSBBKK7AaOk10WX4kp6OT1Pc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M09IY0NsZG1BaDdmTTd4TmhIRFhrWTczT0duRnFsTldaUjBVY1dIcklzTjFo?=
 =?utf-8?B?R0NXNjdQYW5XQ1k0a2pXQ3M4V282akZLRDIwT0pLRDQ4RnJWUHFhUXdPTmF1?=
 =?utf-8?B?YUVMc2t0aEtiQlB4T0tycEpka1QvdGhPWHpLemVmV3RreFdFbHlpSXlZcGFO?=
 =?utf-8?B?N0lGNFBySTVSRXcvRVNwcmtsWDZEWGNrSCs0UERrcFF4c1c2R0Q3RnppOGRo?=
 =?utf-8?B?bE5YUFNrdkpGRkhsQW1ENUJJSGFWc1pDMlN6T0ZkdEQyczRhZDM3ay8xS21Z?=
 =?utf-8?B?Rk1RL2VnY0pjSmlnZEFhY0VEVU9WUjZVc3RDKzZwbVIvVFVHQmVteklwSzB1?=
 =?utf-8?B?ZVg4QkVXa3ZYU2FQWFhUMUZLS28xMVdqMlFrSmRiOHpnMm81MnkxcjhRZ1ht?=
 =?utf-8?B?Z1RCU1FKVVdxQmp2bTdRMi9IaDBNTGlqK2FsOXhyYk9TeEIzU1hCVkF3V2FY?=
 =?utf-8?B?YmJER3VRNnRhZ2lVanRtejhCOFdKa1lMTm4veGhIS1A0eFBEK3Zwbnk4Tkpl?=
 =?utf-8?B?dWNURXBmcTRCeDBwR3VRVm1KTUtIK1JRQmhUejhmZTRoWjU1VmFmY0ptVUJs?=
 =?utf-8?B?Wll5MWQzTTYyYXNRekphWGUzTms1eFk5ajRmdDFPY2k4VVFGWGRNS0VVRGJD?=
 =?utf-8?B?U3NEbjBhbVFYbVkxTnkzdDd6TDVON1g1QkVVK201T2hMNUo3bDM0ZmVEOU1R?=
 =?utf-8?B?ekg2VmZNNFlDcEJic2N6ZzcxeExBUDliYWxrVlRCOXB6UWx5Y2UwbHM0SEd6?=
 =?utf-8?B?NEpyVUlhOEdTNGpoS3luK3ZibmJaeFlCQkZJeENLZG1DTGorTGMrbGZibnVR?=
 =?utf-8?B?QkVRM3FqVERtSzcyWGlNS2tTVnNBQ1FtSHBneGZuSURYdUFwRFQ4d1ZvV2wr?=
 =?utf-8?B?c0ZuVW81U2l1TS9TV2s4TmlKV0l0ZlkvOERMRStnQWpJUmxuVW1ERGdWV3Vm?=
 =?utf-8?B?S090OGtQdXRKOFJlanNmQXk4L0VkRDNGblFLTTlWVUwyaHBNK0NpSGF2Wjlm?=
 =?utf-8?B?ZUl1eU5CUlYyWkRRYTdzdGRFUVI3YzBqQkRrQ09oY3BBOWdNbVh2enVpU0NX?=
 =?utf-8?B?ZFpkOHRQYXErVzVWUUhlQk1YcmNXMVM3MGRiSjR0Skd2U3JYdFZjdkpDUEk4?=
 =?utf-8?B?QXlEWDBqR3J6eHNhdXc2WWlqY056SVFyNkhuYTRBZXhUYW1ZVkdWL1I3Tmhk?=
 =?utf-8?B?cEJKczBiUDcvSmFuNzE5ZVExVk5lbE1wUmF2U0FVQU13ZXlSdlFzVWRLZU82?=
 =?utf-8?B?Mlg0UzNXR3h3WExiNElEWE1FUXo5enpOQWJZdWpCZWRCQmowNm1JcFJtS3Rk?=
 =?utf-8?B?ZjU4V3lUL1FGNlZNNnhNc0JzdUF1anZhelJGcEtYNTdqRzhCOHJaMWhKZjlk?=
 =?utf-8?B?bFdGZHhoMTRrVEs0ekk4ZWlJUW5tVXBTSm1BdnpjaHpGU3NBejZKSDZBU1lz?=
 =?utf-8?B?a3IycFBQZEl3emdtUFEwUVNncUVHN2tFbHlPVUhTb25WUVk1Q2svWkZMWVo5?=
 =?utf-8?B?N2ZzM1I4Z2wxa3ZNRlFuMTd0c0ZFVXZVc0IvRW9Idkd1cUw0M1dYRUZuT05Y?=
 =?utf-8?B?V2JVZ3dCbTg2RWFQTG5MYVhHNGRydDBKLzRaekE2OWFBbHE5MHczTkZrMUg3?=
 =?utf-8?B?WXEvMS9DRVZrK2JLRlBIb1ZLbnRGSGV1UmtBbC9GUE1qNDg5aWJwMzJKOG5H?=
 =?utf-8?B?RWowaHdBaXNRYzdHMnZtbThVMDVqWldGYk5DQmNEaTVLOVFLbUJBMklzN1Ux?=
 =?utf-8?B?NDJSZmFmRnAyNDhYN1pkNUVqWkplNmpMWXNGOHQxWXdCN0grTHAwb2JaR0Nh?=
 =?utf-8?B?TWhVZFAxc0lCbzJnakhhR1JmZHorUGhhazduMjd5SE9mblFLcDdSdjc4OEZq?=
 =?utf-8?B?akI4ek1PcGFTOU5XcE92YTlKVmpibjM5VHBvSUxzeTlxM3pQOWx6NVFMK3R3?=
 =?utf-8?B?NFQ5akFWSjRSQjgxK0hYLzh6N1lhNlRMKzRMbzV1ejlWM1d5TnlhaEp3SmJy?=
 =?utf-8?B?Rnp5ekNMUXIweGFtZ2l6MldZQmppY241aE5lYmFyQ3lPSHRESDRwOGpzZ3ZK?=
 =?utf-8?B?R1E5SVUrdkluVUc5WWY2ZXlwZ1BqQlBiQ1RoSUtKK1o0VkFKcCtOR2N3S21E?=
 =?utf-8?B?ZTV6blQrZlBXL0NVZDVtZU5seUpWdk0wcFViQW5kL3dKN1R2VllZS0FoTUNr?=
 =?utf-8?Q?LqY+GWRuJ9OiPBr89nq8fj8=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 380ad98c-41c0-4fd4-c825-08ddf9dff97f
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 13:57:31.6746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FcLOf1jqi4x2B1BkToaQHt7x7ejWgLqM0rje97fejrtM0YCHF0YDW55oSMTJoDnvDDbmjfj6+KWmlKA/4EIV45lNOFODzO08tY9IfOvM26Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB6427

On 2025-09-22 01:57, K Prateek Nayak wrote:
> Hello Prakash,
> 
> On 9/22/2025 10:58 AM, Prakash Sangappa wrote:
>> With use of a new structure member for slice control, could there be discrepancy
>> with rseq structure size(older version) registered by libc?  In that case the application
>> may  not be able to use slice extension feature unless Libc’s use of rseq is disabled.
> 
> In this case, wouldn't GLIBC's rseq registration fail if presumed
> __rseq_size is smaller than the "struct rseq" size?

The registered rseq size cannot be smaller than 32 bytes, else
registration is refused by the system call (-EINVAL).

The new slice extension fields would fit within those 32 bytes,
so it should always work.

Thanks,

Mathieu



-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

