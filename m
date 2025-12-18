Return-Path: <linux-arch+bounces-15504-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE22CCDCED
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 23:30:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24CDE300F310
	for <lists+linux-arch@lfdr.de>; Thu, 18 Dec 2025 22:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 718A227F16C;
	Thu, 18 Dec 2025 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Y2NCEUuI"
X-Original-To: linux-arch@vger.kernel.org
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021117.outbound.protection.outlook.com [40.107.192.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC33B286891;
	Thu, 18 Dec 2025 22:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.117
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766097018; cv=fail; b=cinKnNOle6ATNCtLrai8QYCvoDAOx+tpxH0J45aJq5acnODx3xUhCem5xouR9ravbn1l11Z/mwFIHG0mCmub7eJQ5AZJNABeb1lHbuG2yydkQew0TDjmxv+ldUoCphtmFdK7j7OScYHgqqCLQPYmGJna9fisy/xDNCzvIRp1Z/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766097018; c=relaxed/simple;
	bh=RkE5aNYmHhYZ7vxYD+HiUcPbLxqlRoIKOwR9StvE7Lk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GqGM3E6gVWKsJvU25KWPCKjdJtInYrW817bUEjpJk7/GaG/XTEW7Eh3QGptzgs6G43zupBcJzb6a5EgZFOjCAxb40xRAnOuY/tz4uT8X7naiPPjR5dOYLolSNdYar61RsppvdhoJtLR7/iZ4pVeCz/9bt7OL4RjSdJ7b/aHydR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Y2NCEUuI; arc=fail smtp.client-ip=40.107.192.117
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W4TQuvG9vhmA0e5iuR2OdY8JM2OSfx7oZP4/5Ke+CM/ZzKf/JbajmdJ1/OJL7Wy2D+LGAHPnQOhg11kA0CA27trDA1yeR/x/iVi05eJzk5QqsD6fSa1aHbKkzLoqmBxozO18AIhS1xhn+PPebU1eicqCHgq3xIX0zlwpXwA9Bs9VboxDZTDon4v9cjKnMAKg9aCmwG4dyIIehGO9zV66004TFpBzFFFFaXAl3pnp4htoTprw8zLzPy8H2lzvbHoWhzBK0wfvClg2GDBxl7QtvVnIQ/hVkCMIX5YD0GGAkvcn4HZq/ckzppoOx9y6UGYwE1ihQzXU7H/TCZ/8IrhUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2BslkVwYoAfQMd7tR19Vf7J+q4nSA6hzJidEG+5ewOw=;
 b=YXFZP4antQRLQvF5CFJJLddBItTCE9mTkfe2O3Zz59Z3fSvcEPDAdOZsjMK4HXQ/MJsGZutCB1RH2L937R+5xHV21XUHIdvXFDda/hdB0YMGgj2TXpiGVnYjE2Ejc33IaAn8wDhu+C9cZDIBLkPZdE50fT67IPmaWKE8VldxdKuuZzgKgW0fSrQAOKo5Xo0+KujzufKQqxlvVePTCC6GS0hqfugpHroBj9FjImWHLtLK+LpURWJ2u2DQcjT9k9VzZ/KnQFwtvHndZLxJddVFRnJlQzi4Bb6emXShGIEPsgzPkp8TmJPiPMG3P4TbTXaFBvvXtlAgLFfdY7+RcuptwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2BslkVwYoAfQMd7tR19Vf7J+q4nSA6hzJidEG+5ewOw=;
 b=Y2NCEUuIs2RQpRe0xRIbVdcTiEy6uCNavxBtF24ubEYe+Xxnnma/RPDwHmNtb05fECZaGx4N4jxPH31AQJCFxYd9ECQeaFnF2qk3kBobdLg6rtsjkyAz1su2hYfnet4rWyG1YeIvVheSJm0ViF+r8C4bc1vyZscT1VJqQVaDzHxS8wcDjnjow0r+CcQgdpt1bCmhi96jgTGbZsAC1p9xQuN68wP70QGR8BavjI3ACZwmFs0d5jGafKpESApi0GpXClqkQOg17nHxLJ+Fs+PEbixvx5+A6ROrMUQb7eIoE4+ndNuCOp2R82ejFUpJ2iyBhHTDBwwraTSVo+rCVtE2oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11480.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:161::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.8; Thu, 18 Dec
 2025 22:30:13 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::6004:a862:d45d:90c1%5]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 22:30:13 +0000
Message-ID: <02abc601-8822-4e79-8c4a-194b56004b63@efficios.com>
Date: Thu, 18 Dec 2025 17:30:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [patch V6 06/11] rseq: Implement syscall entry work for time
 slice extensions
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng
 <boqun.feng@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Prakash Sangappa <prakash.sangappa@oracle.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>, Peter Zijlstra <peterz@infradead.org>,
 Ron Geva <rongevarg@gmail.com>, Waiman Long <longman@redhat.com>
References: <20251215155615.870031952@linutronix.de>
 <20251215155709.005777059@linutronix.de>
 <6a0344be-e105-4f09-bf41-02940e730293@efficios.com> <87ms3fbf1b.ffs@tglx>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <87ms3fbf1b.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0138.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::8) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11480:EE_
X-MS-Office365-Filtering-Correlation-Id: a52e4d5d-f179-4692-00a3-08de3e85031a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cktEbE9pd3N4SkJtTExOTmN2TG5KRnNUdTkyRnRqME11OFRBVjVIdlNLTk9W?=
 =?utf-8?B?c1NKZDNXNWpBVWNXczFDUlNJWTNhTzhoZHY0SDFXZDdRSGR0MngzNmhYM0tw?=
 =?utf-8?B?cEtObW5QaXlUTE9vSTRMQzRzQm85bGswbXArTTRDTU53bXJZaWdTMkN2YW5l?=
 =?utf-8?B?ZWREUWQ4WFl3NXhQSXdnM1lZbCtGZDFESjVzVjc5MkRKNmx0UXF2ZkF1d084?=
 =?utf-8?B?M2oyZDdBc0x6cGxnaEk5MzZCU0cybzc0MXZzTW5vaVpjM0thdGdtS2NRU2hM?=
 =?utf-8?B?eUEzVzVoZTVoSkYvbnFnc0pKYXRwbjV3NXlTOEx2NzBTbEpaSmNTWThieXF0?=
 =?utf-8?B?blBVdkdMamZ0RTYvWVVSbnF5TWpQMkdvd3N6dUlLTEtJMk9TWjRpbUhMTm04?=
 =?utf-8?B?RUV3cCt1THpFelBYaGVOWjBNamJUYVFsU1lvTzFQTnVTNk9pVUZaaUQ0Rkov?=
 =?utf-8?B?UGJMejFZbUhwQ2w0bS9oNFR2QldnbXM0aUNMYXpFSjFWMzlXSFlXNVBMUXB0?=
 =?utf-8?B?bUk5NmlCKzNGeEc0VjhkNHF6VEdhTHVER0xhdExoTzNSaDU5ajFtTkorbi9F?=
 =?utf-8?B?cXAvTEZPeUJEcTYrY2p6RTB6NmJGaUpGWWlkcDlobUZoVzNESVNaWFBJTFN0?=
 =?utf-8?B?b2U5cXFzb0kxUS9YY3RtQXRKc1JjNm5kYmhFSWFLTkNUSURLUXEyVEsxS0hY?=
 =?utf-8?B?WGJkMG5SQW5aZzQrVllCMU1rMGYyRTdHYzlrREx5RUNSbDIyZ0swcWJUaVZs?=
 =?utf-8?B?THVhTFdRWDFML2xobDh3TnZ1dHczeEZhVUp1VmFSMzdybE8rZ1hvT3ZNTGpU?=
 =?utf-8?B?YzQ4RG9VSzY4VmpnY0YrbTl1WHVpR21BN3lqK2dnYm1KblRNVS9NNDQ5bUFZ?=
 =?utf-8?B?TlREUXlNRHpYa01mZVVJYUZpWmJlUWszcnRrSWVJb0ZDQWl3K0x0SkxZeTZ1?=
 =?utf-8?B?R0hVcGpSUG0wSjhDcXhXWHhlaWM5V29laWRwZ2wzZ05KbGZST2JqejFXTGJs?=
 =?utf-8?B?dWtGODgzTjFmMjlDSk1UcFpwREJuclF6REw0SndqQmc1dFVnd0VXVGllVHBX?=
 =?utf-8?B?eEFFaFkxcFBkaDExQ3JrMDZDYm5CanpETllkMk40V1g3UmVhVzVmeFloMy9T?=
 =?utf-8?B?cjd3eVlsbzRtYjl5bGE1R3pUVXpVZS9OanJvR0crZjMrcFdhTjcySGorZERl?=
 =?utf-8?B?UXgyZVREb2sxVUgvK29XSmNpZTNqOERXQ2MvazRWZWlNdS9GN3c2c2xPdlF1?=
 =?utf-8?B?QWc2bXBFa3RZZ2Y2NDRKMVA4U1ROQUpObUo3RHdhWWxBMVhKSnR0QkdsZXlu?=
 =?utf-8?B?YVphRjNMbk9xcVZFSnhJWDQzSXhGSW5UV1RtNTloQzduUWUvK0o3akhuaGFZ?=
 =?utf-8?B?eFlHTlJVRGMybDNVdGVJY1QyT2FtTm1DKzN2SVNXWlYrODNLNThOajIwZWh5?=
 =?utf-8?B?WVYwQUdCN3hISVJZTTBkUnZ0M3N5WGtHQiswSVR0NlpzTEpicVpBSHVHU3V1?=
 =?utf-8?B?ZnFCSm8wekZkUmxudXJ6MHRLdThVUTJ2UXlEdlRud0dIMWxlSFpsaFdhVlh2?=
 =?utf-8?B?endBUnpyampwU1RsdWZXR1ZuVFVTYU4yclByME9WV284TXJuTFpOM0o3T3la?=
 =?utf-8?B?dzBQOWRpQzhrQU9qTWNGdkExSUo2bFd3WGszSG5FUDIyNW9ycEg4aTk0RjFG?=
 =?utf-8?B?dk1yR0xURUVPcUlEek4xS0d5SyswcEhUUVBOQ1VsTm1vb0RYMEd0cXRIbS9S?=
 =?utf-8?B?Y3pBR1ZqSVJPa0RkR0wwaUxJMnRUTDNhSkxWMFhLd0lHUlRuajQ3MFowZkor?=
 =?utf-8?B?M09kaW53M3pJblB5RytmWnZnaHFRZ1FPMWdkdnArTzZKbE1Vbml1Z005RUNG?=
 =?utf-8?B?eUo4cG5VdDJLNmdLYXFVMFo3RFFnODR1VU1rM05CMVlHSXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dDY4aUlXQXdlemlVQmc1QmRrMHNvS0hvUmtLREpLaXI0R1BpVWJOQmNGZUZY?=
 =?utf-8?B?YlM1NEZ0MktsL0p2QkVSeGFZSVVCb3pJN0VuM3dML1FOVzVRK1F5bUd2ZEk1?=
 =?utf-8?B?eEx6dSs0Q1hQbGxiOVZXS2RtNjRPQ244VkE3UUZNNE1MRlhWZ0FjVndGOTF1?=
 =?utf-8?B?eCs5UDVVWGoremg0MmhMS0hraFNkYzhqMGk3STRqVE9pOE1keFRRcVMvLytX?=
 =?utf-8?B?U1hlUFlreGVHY0J1L3hBMk56TFM3bGdUblNFK1p0eHFOaG1ySzJwdFE4aE00?=
 =?utf-8?B?dElMRnN1RjBQamRQZUd6MVJ4VTVZQkorU2tZcGc4ME5XcVRpZ3Y2bTV0dWtO?=
 =?utf-8?B?cFNIWDlxcERHT0xFdytpK1h1Nkg1aTM3MGpjZHh1bWhwcXZEUjBVOWE4endw?=
 =?utf-8?B?cnRqcWtQOFJJVnVOak03R0s1YWJxQk9HK1BIcGt1ZkNwQzMvRGNCVGhoZHhn?=
 =?utf-8?B?VWlmUFdFZEJxMTFYNWdYTitsK2hNaTE3L0p3TEhGTXFXckJURy8wVGRmQ1Rt?=
 =?utf-8?B?WmFyeW5jdkpzbk1hdW1EZ3N0U3dDeU5HZXZnYTUxT0J2VXBEZVlkU294SVI3?=
 =?utf-8?B?MWNtYWhqZnVEaytvVVY3ZUpHeWJIdzRPaFpKS1N1NjNGTVl2UmJySXZGM2J1?=
 =?utf-8?B?cysxZUtPU3JnVFI4di9wSURvU29maHp2cEFNbSsvRUF4d2FCZzZIYlJOb1A1?=
 =?utf-8?B?U1lhaXA2MlRlSG10ZllYMzZSL09hMlBvSnpsSzlYQy90ejRsNnJRMlVWNmxM?=
 =?utf-8?B?dVFyQXhtMTV0Vm5CRkdzT1dlbTdMSUd2MHdkaFZRZDRDL21vcldnT0daU0ZD?=
 =?utf-8?B?MzBrc3o4WDYvZkMyUXFMeHJ0YXRrcjFxZnFnVTM0MWVIUDFQa1RDRG0rMDVC?=
 =?utf-8?B?bDBEOXVTQWNMc2FWSU50aVR2Y2ltaHFhVXl2ZkxhRzdOdFN4THVmUlVLOENl?=
 =?utf-8?B?NHNpamhwdEhPYTRFOUtsTkt1TUtyVy9IZExCY3ZsY1h5RkwvZUdLQUtOL2pj?=
 =?utf-8?B?VldJdU93b3I3T0FCRWhnNFdmc2FNdFQrTEVWTndkbnRFekdSdXFmaTF2WVBF?=
 =?utf-8?B?MkpFdGtJNUJqNTRzdFlwb090QlhuNlg1WGVhZGsrb1d4eStsMUtuNitMVWFD?=
 =?utf-8?B?WWtGTER2SnFNckZxOFZtWFdYQy9lRU1nTWJWNWo4SUFySVJMMFRkQTFVNGtN?=
 =?utf-8?B?QW85STJwMHVkcGhkeDBCUVZmeko2dlgzeGdFM3htRzNLRnBzYmFOOG5zbGUw?=
 =?utf-8?B?MVQxTkt4U21rRW1yMGZINjNNS2cvYlNCeFVvZE9lNFVZWDN4M2xEVXlRNWtC?=
 =?utf-8?B?bzVpeUZZYXNlZlFnMEk1NUl6cWhDS29OU1JMUU1LbUw2cDhCTit3dC92ZGZM?=
 =?utf-8?B?QllBQVZkcStJam15UmJkUDBpdnNDaVhRd3JCZ1hkcTYwWjFwNmNXczg5T1Fh?=
 =?utf-8?B?eXdla3N3VDBDVVhnY0EyL1djWTQ0UzZpbU5yZzlqQjJ5ZmFhUmgvWHhMdUhr?=
 =?utf-8?B?eFhueW8vUzBsMWdwNU5QS3duMHlXZ0JndnBVRmdiUFJGUWpzNUpTZ1BiaVRn?=
 =?utf-8?B?Q1Jyb0l3WUh3RnlVU1FrZWZ5UkkzejVybWRpUlhKOWdEY09qOXdGUG9OL0w2?=
 =?utf-8?B?M3l5VVVwbHg1T2lzeDBMQTR4aGRpdWh6Tld5aTFJeVNMLzJUVC8rWkVqSi9s?=
 =?utf-8?B?SCs3TEEwNU9sS0VBYXN4Y0xZdWk3Y1RtdlFIRlFIYWNDTG94emVGVTZmZEsy?=
 =?utf-8?B?T1UwSm96VjREMmQyRTZFUzg2MW0wTUhzTjZRdDV1aWFDenlEY1doUlkvRWxK?=
 =?utf-8?B?L3ZaTFM1UEtYRVZyOGhiM0FuaHpsVFNRcEdRYlVKdWlXWDZGS3kvdTJHTGJF?=
 =?utf-8?B?TUd0M0g3ckJsd1VobWVDRU5oRUJMcGZSWjRCeGErdGJ1dTRCRytta0kzeW40?=
 =?utf-8?B?WGlWY2MrbTBGNmNxNkdrTVFzOFB0WWptMmdqNERQYjVWY3pXMFJVWDZIekFO?=
 =?utf-8?B?WDhla0dUTTJZQm1Cdy9FQlR2aHhEOTY3TFhqdktTSmVObWgzV3REeVRNbGQz?=
 =?utf-8?B?ZE0xbWJYalAxVTY4WUQ1bHFoLytoM01DTFFsaStXR1laWGJHL0pKakFXR2lu?=
 =?utf-8?B?M2ZuY2xnblZkVDRjV0p6OVhjNGlVUk4wVk1SNjhoaFlybVpHZTRVc2IvOUpJ?=
 =?utf-8?Q?yzmWw7wNX/Ps5TL3fzWk/Ys=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52e4d5d-f179-4692-00a3-08de3e85031a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Dec 2025 22:30:13.7886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZW0Lxb+GpViHQyu39a7g0tX4Dhso3CuI8ff/ZZrRvff6HRQ2a3BRXci+Y4YY7A8tnkrwYkWljiYjBRYkUNEjKTo/vyDFwttX5M17EBh/YR4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11480

On 2025-12-18 17:28, Thomas Gleixner wrote:
> Nope. There is also the debug path which will catch offenders which
> fiddle with the state.
I missed that one. Makes sense, thanks!

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

