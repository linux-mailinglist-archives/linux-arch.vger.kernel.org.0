Return-Path: <linux-arch+bounces-13519-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 70CB5B556E3
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 21:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A27D1D6403E
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 19:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B44311C20;
	Fri, 12 Sep 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="R7TYLoIg"
X-Original-To: linux-arch@vger.kernel.org
Received: from YQZPR01CU011.outbound.protection.outlook.com (mail-canadaeastazon11020086.outbound.protection.outlook.com [52.101.191.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499072C21E7;
	Fri, 12 Sep 2025 19:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.191.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757705193; cv=fail; b=Zi31ItJWjs75unVLRQIE4SjS6hYGmUPdUmmENF+7cijlOdQM8WIVgbNG598WbrdX6ReDJX7nhmrrlgdsW8BgDeybOTAatydpe9x93nKcnEH4afTjt/vN4Cj3KeYGuFarcCPYprr4OCj5qbbp0vpSoENptDpTbGsFg0y/cm/lBgk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757705193; c=relaxed/simple;
	bh=qMG7Tf9xAL0puGhB1CSqrHh9q4ufCRPmkccFyfuFU2Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NqepSe/sZPk7hb+vvjLnma6eCe/4hOY8ViI6mkdN1wKSEBQLGhxcf9EJgYz7ro1Ou+tJLtjnexRCdUcSE5UzSQfDnz0XGRc3XHDlbxPXYFab4Vbyu/cavzQQ5lPAgu7oOsOqDX0sfSxtkCe0yzNNrf5A1OMigtFPPnHCt8H8FcA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=R7TYLoIg; arc=fail smtp.client-ip=52.101.191.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+vNmO/BzKU/hjbOfcWxrk3spA2PnPalYWvXHFyxCIUMhHKp4WvMVOksxKhT14cA0roG1JULeY4fuaW0tAdPFwozgztGTszN0+/keKAg7DNwzhme6p+rPJHG1kOiLvasywi4q46SaNTL2rsLOUeFTl+8bV1Ldvu/s6UL1+kDZHswuq8iqOgj491UIWMG0p0CK6aoCcpJNDMXoux389+bs0vbIdmYOYt5lxHKqh2zR3C0ezw3s9otdv3V0XFTSKBgWjyq9PEb7aLEl1Q5Rz2yVoK1A0L2OfF3uGRf8a1S2BMZ0VqntBBkJd3JlSmdEwlGZtC1WF6HUdrmUSAHrkTrjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=//jAj85F9+TM7j4sBNol0ENBn1EkVIqIPxn9FxZ34z4=;
 b=mThiLa62F3Zb1MRefSXXV8DPwJLU0bxv09Oh/QQ5Mff6622kMFZRwSc40TcDH7TRWbGtMtLbPVL1P2g+vNvckZGVJuYFEWquWjc+c6S1XukjqYsxxNKfJ9JjeJ4bwgNBqczx6TsdYX27jcfbqAJmIcSrslWjIAo6KHhaVR3GTerpWub51hDrtw7i6iEN45NJaxNQuPY2AgmZcWPlcz2WBPiyyERclZNyLKrvaM2apTvqwUMRI4vhQXubuYzWU+Os04oK/TIbmNOSQTxRoFrGm5LRMM3OkLGMPZHiV346LNKmggt3zk72ZODCK1l8rALgwn2laHGuq2XvAKZXuxB0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=//jAj85F9+TM7j4sBNol0ENBn1EkVIqIPxn9FxZ34z4=;
 b=R7TYLoIgHaGsvpngnQzUmFbVVuX+NKE7ACngE0/2iltWAcdKY9kjKUkSfmzP3RdonglqiIH77U0iiwhfUKhYo/mDcvn7MK2VZDFqndyKCYxQ2SnyiR9wwGmCSwg2nVfJLGuzybBOo3qDzbElE3m0YMvY3ZJFASE8L/atGQd+pVDQViM3nArqEUgi0atU3/BJhqrAexCmlt/609Q475A93BoFkpFNwGdub8Lwgftq9YKBS0mBlqrbwOigrfKpEBjyr4bVxzS1URo9akoFlaHSI6U9ezJjbrB8ATYGG9yGtBYEkpCaq6L/m7troHmOy1OgJqZmSc1/hqQCHDdBcpn6fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:a0::18)
 by YQBPR01MB10479.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:82::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.18; Fri, 12 Sep
 2025 19:26:24 +0000
Received: from YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31]) by YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::5ebf:cd84:eeab:fe31%4]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 19:26:24 +0000
Message-ID: <a65dfd2c-b435-4d83-89d0-abc8002db7c7@efficios.com>
Date: Fri, 12 Sep 2025 15:26:22 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 00/12] rseq: Implement time slice extension mechanism
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zilstra <peterz@infradead.org>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Florian Weimer <fweimer@redhat.com>, "carlos@redhat.com"
 <carlos@redhat.com>, libc-coord@lists.openwall.com
References: <20250908225709.144709889@linutronix.de>
 <159c984d-37fc-4b63-acf3-d0409c9b57cd@efficios.com> <87plbwrbef.ffs@tglx>
 <3d16490f-e4d3-4e91-af17-62018e789da9@efficios.com> <87a52zr5sv.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87a52zr5sv.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0121.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::24) To YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:a0::18)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT3PR01MB9171:EE_|YQBPR01MB10479:EE_
X-MS-Office365-Filtering-Correlation-Id: 9cb62314-24cb-4fa3-5543-08ddf23242ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWNwOFA1NlNIb2F3a2RnWGl1Sm9TLzdlSmJIY0doNmpqa0c2Kzg0L1BYL1ly?=
 =?utf-8?B?OFVxNXNvM3daY1RqcDAwSW1HbEVPOWpTcWUwL1QxOUV2TFVQYWFmT2JCTjVl?=
 =?utf-8?B?b2lMSWtWWm9GcWFmdml0YnFXT2pFdHhuRStYbFNUaFJlV3RxTjhHMjZ2WnN6?=
 =?utf-8?B?QzIvVXR0Ykc3MHpsV1lqV1AwZmM3YnJOREc3OHpWM3F4M2NrNy9aaTc2WTZK?=
 =?utf-8?B?U2dRSnQ2amx0R2NZaGdUUEgydmp2WXM0WUhtMFh3NkpBVjYrZjZyTUR3dk8z?=
 =?utf-8?B?S3h1bGdNaGIrbk1tbVAydENZT3Z3ZWFpRzUxK2pPd2xHSER4dkdRc0xlNTJF?=
 =?utf-8?B?Ukw1ZmhoYzlwWGE1OUlkMTZmSStrTWdpaEpnU2JiRkdFb2xYZHdPS0NtYW5Q?=
 =?utf-8?B?OWQwb3g4MTY0TkxGamdIM3I0d251bllMRzJYRml5Nk8wclJHdHB4U3JDT1E0?=
 =?utf-8?B?eDFONytZa1NwamtjNG1Cd3FPY2YvYWlEd3NzelBJemp6aHIrN0JpV3FtWGJF?=
 =?utf-8?B?cE5UN1hXUE42eGVtZUZnMVNEeXdlcFNobENldEZ6OGh4WlJjb0NrZXcrc3dN?=
 =?utf-8?B?SXEyeTJkdzRBcFlLcFdJYWJVRDZwVW1QOGwvYU9mUVQ5RVJIU3JWV0lBSEhs?=
 =?utf-8?B?U1J2VllCUXZudTlFYXVMdjRGWi84UjZtZmoyZXU3ckNYa3Ayb2ErRGhFYWNG?=
 =?utf-8?B?Sm1Kb1E3emw5bTFIbXJycjlJVEtlaEk4UHRJZWtnTVFHdVl1YUc0V1hhaSt0?=
 =?utf-8?B?elQzK1JUakV2Mkg4aWJXd2NhMVZveDZiK2NsU0liSWUwTU8rY0U2eTE3MFpZ?=
 =?utf-8?B?VmJkalluRHh3UDdXOHhzVkU1eHF3NmxUMFI2NHBwclRLTDdlSm5iZnZxeG5y?=
 =?utf-8?B?RUVoTjJ4SGlIbHE1akJCZ1U0R3BRWjVtSEFZL3VUek1hS3hCY015YlRnbG9S?=
 =?utf-8?B?YWpOZi9DVWFRbThWVkRiQ1cxYXNNTG11RktLWUxJRGx1TWJuUmE0YVNsa3Jr?=
 =?utf-8?B?WHdpYW1ZMkpzN0ROUXNHaUlvOXVVY0g1Y25aR1hnYk5IbmJqeVFKdGxTVkgv?=
 =?utf-8?B?V0x1ekx3dWRHcm1lZ01ZT2RqSGFQSDRLREg3RDIvY3FiQTFwTHFSdlBaSjVP?=
 =?utf-8?B?UCtnTDN0b0orVzc4aWc3Q2szaE1UVXlwNkpGMW5qNlpuaHh4bzZrWTVGVjl4?=
 =?utf-8?B?a2I5T1daS2g0SFhvVTd0eWlHaHFYNjQ1Z1EyS3dRRzA2Mm5tOEdDS1EwenhQ?=
 =?utf-8?B?U2kwcEpxUnV4OEdZaDB1RzFwRXFhVEM3OEdSTy9nZDQ1czY0cUcyREFDaUhZ?=
 =?utf-8?B?QWJDcXdIOVNLV2Faemh6elhFS0dCT3k4M3JFSDlSR0tpU3hlaTh3c2xFWDY1?=
 =?utf-8?B?RXdMZ0d4N1pBbm9LRHEvblNsdUFyQ3JFNXNFSlAxZStqZ2hXS3lnQmc2RU5i?=
 =?utf-8?B?eUJhNzlCMkRUNSt6REZQQldjbmNnN0NnU3lRVkVucTZNRDhxLzNEb1BLazhD?=
 =?utf-8?B?UCszVHVUbjBSTHBvUUVpYS9ZTkdXc3BHTkJJWFo4QVJlWWJuMXNkYU5FckNj?=
 =?utf-8?B?eTJvVjBoVFdXYkZJUTRTWjJ6bGpianRraUJDN215Y2VXczB3VXQ0TUJoVjly?=
 =?utf-8?B?MXpFUE1vZHEwb3FlMkM1WU44Y2RGYUdJb0JUbUx5Ukw3TEtSdFh3OVloTGJh?=
 =?utf-8?B?ckV3Q1hMWDMvSGdSYkhlM2E4TXVFaGZ5Y1FDWis5UWVuRE1DTXlHOEh1SUlB?=
 =?utf-8?B?aDhRMUl0Ylg3aGFhNjd2d01FeWJ1d1dvNy9LcDNSUXZ5cGpFN3k2Z04wd091?=
 =?utf-8?Q?/Mb1NehRkwFY4r+fBCcV/VO1NhNU9SoWEIjWM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGovdFpmMlZvZG1sbTBGcjFjNlBaUUhjQ1NaTFpEUTc3OURSeHlCRTMvVXZP?=
 =?utf-8?B?bXlOYzEvbm5EZ3FVM2c3SXA0NWR2TVZQMzRHTzNCNGo2NDg5NFFkWmJjOUp2?=
 =?utf-8?B?QW1Da1RyU0xiQmxhb1NWd2JIQ01mSjlHZEhXazYzdFFTZVNlc25OMEhxSCt5?=
 =?utf-8?B?Yjh4TUZPMlB0UVVSd2F6S3o3NTUwZS9uOENvNEcyTFZQT0pyUE5Cd3NXeFph?=
 =?utf-8?B?elVqRkdJVTd2d3htazhRWEFXYUovNk8yNjN4aWo3OWhtcVE3VC9HRFlnR2ti?=
 =?utf-8?B?Qk9xTENSdXVJMU50YmZ4M29sZU9PTkJQWkNWblFKUGF0SFo5VEJlOVZmdjdW?=
 =?utf-8?B?QWthMXhiL0VpcFJIb01hL295WTZFQUFuc3hEZldwdzN4OHdsUlhOQVd1UmtL?=
 =?utf-8?B?Zml6bUo4V2E2RHNTOXZHS001dXRWR0NHTWtRNnF6RCszajlXVzlIeTdUSjBM?=
 =?utf-8?B?SU1NdVloY1JNWCtnVW1SYkhZbTRUeW1qaWJYaEF2NS8wTkVVNEVwVGZSSytD?=
 =?utf-8?B?NjFhZkpGU09DNWhqK1VjMktDZVBGNFdjV3FWU003WlpHNWVSTlN5OWRCenoz?=
 =?utf-8?B?T0E4T21FbUlHQTFGelpleGM2bk95ZXJVMnFFUlREVVA3cjROYnNWUUFlcWJj?=
 =?utf-8?B?ZDVPS3llbVVmWjlKVGZHcEJHaS9CeEQ3U0VjMGVFaGZwbHg0Yk9yTmFIOEpR?=
 =?utf-8?B?WjlmM0taNnA0dDhpRG1jc3pmV29mTnBGRFVkRTc3VzMrNEdQZTg2bUYya3pi?=
 =?utf-8?B?V3ljY1ZGWkRnS2czR0pkSnZIQ2wrc2xFWHVydDhETWlRa1FQcHA2WmVicDEw?=
 =?utf-8?B?Y0tRM3JLSEJXaGcrVE9KbmdGK2xwTnFvS3NkV3hFblNkQUc4N1haQVR0MkNQ?=
 =?utf-8?B?ZmE5U1llMFdzeGk2QnpIVm1DbVVOMm9vWXRQMjBQVzJNVStlb3hQdThESFdz?=
 =?utf-8?B?L0Z4TnVFWFBXVSs3ZkRLTXQzSWQ3SHBsSE40VWNRMlZhQjRwazltY1QwTlNp?=
 =?utf-8?B?cjEwYitkV1ZoYzYybVp2K0x3VENmb09YaHpGTVI3ZXNWMXZxMlRlaXJkMWlR?=
 =?utf-8?B?a3hscmdRc2hycVhrdjhRMlEwN21aUDZ3YjhlZ1E1TzBpWU5LR2krSDc4SnI2?=
 =?utf-8?B?VWJYbGp0eHlOYkR6SXNIa05LQzl6aGszazVtZTJGRFFmOXBMRk9McHk0WEdj?=
 =?utf-8?B?ZDI4SDZpYXRvZ1pjbjdtQWtZVHpsWHJDM0FvN0Q4bkxVSWp6Um1mOThIK3NR?=
 =?utf-8?B?NWJyL3pOcGJidWNtYkM5RUwvZ25Hc2FrSk1JV1diRzkvaEJZT3dmdE52Nnp0?=
 =?utf-8?B?dG9NU3QxdzFaRUlCdHNxaVNpenJQVGpoZ3NPRVBCSEZtbEJsUEJWWGxMSG5G?=
 =?utf-8?B?OTB6bURid0YrNnBUVkxVL1N5YW1nbHltZ08xakkzck1KZk1KcnI1RytHL2Fa?=
 =?utf-8?B?YkZwUFdOVllQZDdLTmJBNnBCMG9Yd3NRLzJDT2hubWM3T1JJajUwRXVXY0Rq?=
 =?utf-8?B?SzVNdGlLYjh1SElYVjhLSkM4cHo4L2lMQWVyWHVMeGlkRkJHMTlXd2ZlRWE3?=
 =?utf-8?B?aGJjY1BFaE5hWjg2VWJPVk1mbDEyQXV0ZmF4QkVxK0o5WWZSd25hYm5FcnFM?=
 =?utf-8?B?QVp1M1lweGVXZVg1NnlBb2FNVVNoM05FWE5rVTRGQ0pXWHBjTTJtbXduQWFC?=
 =?utf-8?B?QkxwaVNDenRZM09UNnJHR0dRT3RlTEVOdmlRYmwrMFErV2pJYktGd1kxdEs5?=
 =?utf-8?B?UUxNKzRraHgyZVBtY0N4Q3hTcVF1aGtKSnNCb3I0NFFNQ1lNdFg4ZEhiSk1P?=
 =?utf-8?B?emxLeDgwTTJpUWZERjNEWm5VcGppa053Mk9Mcno2MC9vUExTajRnT1gxVUM5?=
 =?utf-8?B?NlE1WnNISW9DOVZNQWpBVis0S0xBcnNxK01oTC9BOU9EdnN1Sys0SzU1UTcy?=
 =?utf-8?B?Y0RWL25icnNNVlJXSEVqU0lrd29zbXJkNjVFcGNLbDhISVhKTVdVWk0xVEtR?=
 =?utf-8?B?QjFOSjg5SGFYN3RqdDFqcXIxemhwZkVoRWVDczZ0QktCUUNWQ0VCWHIrTlIv?=
 =?utf-8?B?RnYwWHF4VHBoVGhjT2M4M2hsSUs5dmFwS0JDdzFRN3gyTU9xdjFkcHZZTk1t?=
 =?utf-8?B?S3lkOTRpWmoyR004M09tVXcxNm5lY3NCenpYWDNkNjdkak94WVVUV0FPTCtJ?=
 =?utf-8?Q?jk+cSMvg0w6bDUNZGh4OaiM=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9cb62314-24cb-4fa3-5543-08ddf23242ca
X-MS-Exchange-CrossTenant-AuthSource: YT3PR01MB9171.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 19:26:24.1814
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oT23yMQKYPdvip/oEpqXpAGfD8V3XnpmTIWWue09dTRixZU7qfINVThiLEqAW1Ay6uha1NUJBSKm6+cL5AVrd9gK+OQV3ori4wPkn6/NPWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR01MB10479

[ For those just CC'd on this thread, the discussion is about time slice
   extension for userspace critical sections. We are specifically
   discussing the kernel ABI we plan to expose to userspace. ]

On 2025-09-12 12:31, Thomas Gleixner wrote:
> On Fri, Sep 12 2025 at 08:33, Mathieu Desnoyers wrote:
>> On 2025-09-11 16:18, Thomas Gleixner wrote:
>>> It receives SIGSEGV because that means that it did not follow the rules
>>> and stuck an arbitrary syscall into the critical section.
>>
>> Not following the rules could also be done by just looping for a long
>> time in userspace within or after the critical section, in which case
>> the timer should catch it.
> 
> It's pretty much impossible to tell for the kernel without more
> overhead, whether that's actually a violation of the rules or not.
> 
> The operation after the grant can be interrupted (without resulting in
> scheduling), which is out of control of the task which got the extension
> granted.
> 
> The timer is there to ensure that there is an upper bound to the grant
> independent of the actual reason.

If the worse side-effect of this feature is that the slice extension
is not granted when users misbehave, IMHO this would increase the
likelihood of adoption compared to failure modes that end up killing the
offending processes.

> 
> Going through a different syscall is an obvious deviation from the rule.

AFAIU, the grant is cleared when a signal handler is delivered, which
makes it OK for signals to issue system calls even if they are nested
on top of a granted extension critical section.

> 
> As far I understood the earlier discussions, scheduler folks want to
> enforce that because of PREEMPT_NONE semantics, where a randomly chosen
> syscall might not result in an immediate reschedule because the work,
> which needs to be done takes arbitrary time to complete.
> 
> Though that's arguably not much different from
> 
>         syscall()
>                  -> tick -> NEED_RESCHED
>          do_tons_of_work();
>         exit_to_user()
>            schedule();
> 
> except that in the slice extension case, the latency increases by the
> slice extension time.
> 
> If we allow arbitrary syscalls to terminate the grant, then we need to
> stick an immediate schedule() into the syscall entry work function. We'd
> still need the separate yield() syscall to provide a side effect free
> way of termination.
> 
> I have no strong opinions either way. Peter?

If it happens to not be too bothersome to allow arbitrary system calls
to act as implicit rseq_slice_yield() rather than result in a
segmentation fault, I think it would make this feature more widely
adopted.

Another scenario I have in mind is a userspace critical section that
would typically benefit from slice extension, but seldomly requires
to issue a system call. In C and higher level languages, that could be
very much outside of the user control, such as accessing a
global-dynamic TLS variable located within a global-dynamic shared
object, which can trigger memory allocation under the hood on first
access.

Handling syscall within granted extension by killing the process
will likely reserve this feature to the niche use-cases.

> 
>>>> rseq->slice_request = true;  /* WRITE_ONCE() */
>>>> barrier();
>>>> critical_section();
>>>> barrier();
>>>> rseq->slice_request = false; /* WRITE_ONCE() */
>>>> if (rseq->slice_grant)       /* READ_ONCE() */
>>>>      rseq_slice_yield();
>>>
>>> That should work as it's strictly CPU local. Good point, now that you
>>> said it it's obvious :)
>>>
>>> Let me rework it accordingly.
>>
>> I have two questions wrt ABI here:
>>
>> 1) Do we expect the slice requests to be done from C and higher level
>>      languages or only from assembly ?
> 
> It doesn't matter as long as the ordering is guaranteed.

OK, so I understand that you intend to target higher level languages
as well, which makes my second point (nesting) relevant.

> 
>> 2) Slice requests are a good fit for locking. Locking typically
>>      has nesting ability.
>>
>>      We should consider making the slice request ABI a 8-bit
>>      or 16-bit nesting counter to allow nesting of its users.
> 
> Making request a counter requires to keep request set when the
> extension is granted. So the states would be:
> 
>       request    granted
>       0          0               Neutral
>       >0         0               Requested
>       >=0        1               Granted

Yes.

> 
> That should work.
> 
> Though I'm not really convinced that unconditionally embeddeding it into
> random locking primitives is the right thing to do.

Me neither. I wonder what would be a good approach to integrate this
with locking APIs. Here are a few ideas, some worse than others:

- Extend pthread_mutexattr_t to set whether the mutex should be
   slice-extended. Downside: if a mutex has some long and some
   short critical sections, it's really a one-size fits all decision
   for all critical sections for that mutex.

- Extend the pthread_mutex_lock/trylock with new APIs to allow
   specifying whether slice-extension is needed for the upcoming critical
   section.

- Just let the pthread_mutex_lock caller explicitly request the
   slice extension *after* grabbing the lock. Downside: this opens
   a window of a few instructions where preemption can happen
   and slice extension would have been useful. Should we care ?

> 
> The extension makes only sense, when the actual critical section is
> small and likely to complete within the extension time, which is usually
> only true for highly optimized code and not for general usage, where the
> lock held section is arbitrary long and might even result in syscalls
> even if the critical section itself does not have an obvious explicit
> syscall embedded:
> 
>       lock(a)
>          lock(b) <- Contention results in syscall

Nested locking is another scenario where _typically_ we'd want the
slice extension for the outer lock if it is expected to be a short
critical section, and sometimes hit futex while the extension is granted
and clear the grant if this happens without killing the process.

> 
> Same applies for library functions within a critical section.

Yes.

> 
> That then immediately conflicts with the yield mechanism rules, because
> the extension could have been granted _before_ the syscall happens, so
> we'd have remove that restriction too.

Yes.

> 
> That said, we can make the ABI a counter and split the slice control
> word into two u16. So the decision function would be:
> 
>       get_usr(ctrl);
>       if (!ctrl.request)
>       	return;
>       ....
>       ctrl.granted = 1;
>       put_usr(ctrl);
> 
> Along with documentation why this should only be used nested when you
> know what you are doing.

Yes.

This would turn the end of critical section into a
decrement-and-test-for-zero. It's only when the request counter
decrements back to zero that userspace should handle the granted
flag and yield.

> 
>> 3) Slice requests are also a good fit for rseq critical sections.
>>      Of course someone could explicitly increment/decrement the
>>      slice request counter before/after the rseq critical sections, but
>>      I think we could do better there and integrate this directly within
>>      the struct rseq_cs as a new critical section flag. Basically, a
>>      critical section with this new RSEQ_CS_SLICE_REQUEST flag (or
>>      better name) set within its descriptor flags would behave as if
>>      the slice request counter is non-zero when preempted without
>>      requiring any extra instruction on the fast path. The only
>>      added overhead would be a check of the rseq->slice_grant flag
>>      when exiting the critical section to conditionally issue
>>      rseq_slice_yield().
> 
> Plus checking first whether rseq->slice.request is actually zero,
> i.e. whether the rseq critical section was the outermost one. If not,
> you cannot invoke the yield even if granted is true, right?

Right.

> 
> But mixing state spaces is not really a good idea at all. Let's not go
> there.

I agree, let's keep this (3) for later if there is a strong use-case
justifying the complexity.

What is important for right now though is to figure out the behavior
with respect to an ongoing rseq critical section when a time slice
extension is granted: is the rseq critical section aborted or does
it keep going on return to userspace ?

> 
> Also you'd make checking of rseq_cs unconditional, which means extra
> work in the grant decision function as it would then have to do:
> 
>           if (!usr->slice.ctrl.request) {
>              if (!usr->rseq_cs)
>                 return;
>              if (!valid_ptr(usr->rseq_cs))
>                 goto die;
>              if (!within(regs->ip, usr->rseq_cs.start_ip, usr->rseq_cs.offset))
>                 return;
>              if (!(use->rseq_cs.flags & REQUEST))
>                 return;
>           }
> 
> IOW, we'd copy half of the rseq cs handling into that code.
> 
> Can we please keep it independent and simple?

Of course.

So in summary, here is my current understanding:

- It would be good to support nested slice-extension requests,

- It would be preferable to allow arbitrary system calls to
   cancel an ongoing slice-extension grant rather than kill the
   process if we want the slice-extension feature to be useful
   outside of niche use-cases.

Thoughts ?

Thanks,

Mathieu


> 
> Thanks,
> 
>          tglx


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

