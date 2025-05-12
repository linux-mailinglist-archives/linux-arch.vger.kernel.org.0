Return-Path: <linux-arch+bounces-11892-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF00AB33F9
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 11:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6D2516B7A0
	for <lists+linux-arch@lfdr.de>; Mon, 12 May 2025 09:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2F925E45B;
	Mon, 12 May 2025 09:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f1dwzUd6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I1ydP+Po"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B0125D53A;
	Mon, 12 May 2025 09:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043440; cv=fail; b=Lqpo4yaqz7qqy33T1qKiUN6VfD1OpUBXAx2263fOW7QrUNYW6YTETyhuVUo0+e2AjjDOFvruTkcyx9G8KU7SGTF+Qzj668IBRFU1b9j8k5EvIIwQzi96dPBSjuMZbSX8RIcrjk7H9OSCU6YStlvDa8wqsMUqoeXATgnhxgYiG0c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043440; c=relaxed/simple;
	bh=12dd136m55AJnRfkkAKq6sJ1XQ0svG6VY04hNojSmpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YyQaPPLzfJtUxStjVIiQC6NZUT3Iaza8Uv/9Nfk0tsPIJvoB3PnbeEyzuJXtaAGaZ41OcOFvw9IlJoLEHv/JEreKcWPCSGwMgCUD/fynwJWSMnJ9MfeTVZC5DHpaGfV1it1PgKNosAyyx2cHEbIAuKjKMi99Z37EdUU+yZE0eG4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f1dwzUd6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I1ydP+Po; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54C7g0sW006674;
	Mon, 12 May 2025 09:50:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=GsjW0y7Zi9jkrbpRnT9lN5egQzkonS6NvDyS/31crk4=; b=
	f1dwzUd6pLgfG3eDqTyiUvNqIzOLqCJt3xr8NXFsbgw5MmdFSwBB1gkhnyZhQh8c
	X6yUrJV9Mmj9PcW9m7wCe33SJrt+4VFpnejXLFelMNPCXIg8fUX6Y1KHrqLclsR0
	Z/vYuwIwEmNaXzBbL0ULPVETQ7uvTnhrxDehwx7ZBmMNN20zSRTXtD3LF4gEYNSG
	DwRHApsLTlShvfgX78oKXzwSr0mnXEA3wefDSBOlXRQs1wGqr+54MwqXNbpe5M2b
	toaiqwEdRSiZNGRMcxAKfKvT+lSbib6BMWErjuS6Gxk6chmQucicDuF68UGBwlwp
	Z4+rBy8BQUzD4C+fC7AYZg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j16625g8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:50:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54C8hNQq002646;
	Mon, 12 May 2025 09:50:11 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013078.outbound.protection.outlook.com [40.93.1.78])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46hw8dp0vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 May 2025 09:50:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJMJnnMkNbnlUbinDnPKlt85G/sHKE3jdA9gBNQ+cV2jVEuYaHoalmS4lMvJgmBjgeqQ6OedVe3xn70gaTW4QtZXz/UA6bFxb7QdDGvodmWQ4ESOznHgFLFEat++ctCUDc2m48T3QHg0aFmCf1C0cKGJ/+yikn74zf2WjuJ1SDCXjy9UuIEN44ran/34JvXTjZ7CQo5tIGT+uu92zrZ+59w/FGFkdJidkCW1BCnac27oL3fksmc1fiqaVCTD/u+Yu0Mpgg2rigMPa1+W72i2lgFe0DAP3Bs7WbAbLh8ltyCZZHkgKOzDq1b20oT29sh5odwIYg3NnBg/kinkH0pq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsjW0y7Zi9jkrbpRnT9lN5egQzkonS6NvDyS/31crk4=;
 b=uy2oxAayqdbkRypYNUZfldW9HeSMZUpBzUXap/WcWQ7ZDE2W64WkKJR+UuouREK38q6gVDaD4Ky8/gMeoxPSLXBcQy4Qv2Pm4w0cBvcxxOY4Ml+f2o9Q3u6vFgl4WXW1c2QXLbi4TvvM1PZBZ03CZxie0FphheNh1L63Yv2j7eL+RMwwyIA6FkWHNPRFfThJvlnDrGQ2saOuarW2KKwKCuHPgk59XNpXMZMEf8x6IRVss0he+fs/XeuoA5RbIp0u06qrccD3WrPLdWyBjrS2dJO+MJE4Md8Or0Prn4nzc+CG8ub/P23bJeOn0lj29SIzj6hPTH7A9kT9P9dwkkoxZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GsjW0y7Zi9jkrbpRnT9lN5egQzkonS6NvDyS/31crk4=;
 b=I1ydP+PofqytDSxjJ1tEUzXJ8pSF9UYaLMzdYpEpaWZoCpUi41ulFkv82GEp5EQKWOshDX6NlAaE0HvRXnV00lg2ob/7V4ew3RNTXBm3dwEAkH46WgoFyeiRbEmMnZxX85M6VIYZsU9aoOilLxu8keXi2Ggpt1UjCsOaoDafIW8=
Received: from BLAPR10MB5315.namprd10.prod.outlook.com (2603:10b6:208:324::8)
 by CYYPR10MB7567.namprd10.prod.outlook.com (2603:10b6:930:be::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Mon, 12 May
 2025 09:50:08 +0000
Received: from BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa]) by BLAPR10MB5315.namprd10.prod.outlook.com
 ([fe80::7056:2e10:874:f3aa%5]) with mapi id 15.20.8699.024; Mon, 12 May 2025
 09:50:08 +0000
Message-ID: <d93bebbf-2e0d-4de4-a258-c32159dd1541@oracle.com>
Date: Mon, 12 May 2025 15:19:54 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v2 2/4] drivers: hyperv: VMBus protocol
 version 6.0
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        catalin.marinas@arm.com, corbet@lwn.net, dave.hansen@linux.intel.com,
        decui@microsoft.com, haiyangz@microsoft.com, hpa@zytor.com,
        kys@microsoft.com, mingo@redhat.com, tglx@linutronix.de,
        wei.liu@kernel.org, will@kernel.org, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250511230758.160674-1-romank@linux.microsoft.com>
 <20250511230758.160674-3-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250511230758.160674-3-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCP286CA0051.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::14) To BLAPR10MB5315.namprd10.prod.outlook.com
 (2603:10b6:208:324::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5315:EE_|CYYPR10MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: 2828728b-e278-4993-a055-08dd913a6107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk12OTltV3FzZ24wUTZjOTJXb1l1c01raVErdzdSNkFRb3R4ekkwWXFuMWdY?=
 =?utf-8?B?dGhvNUxOMzdMd1BXNkZWMmFudHlEeGJ2elZrU1V4S2U4ZjJaZFRNb0hUWWdY?=
 =?utf-8?B?NVV2QTcrdURXaUV6NUJmUTEwaEMwOU5RNVR5OEU1U0lYT0NkMy9mbFdNb0Mx?=
 =?utf-8?B?bUM1UUJuZ1RadjYrUUJPS3BwZk9xOTFUSlZJY2orbFJRZDhjOTViSGM0c1M0?=
 =?utf-8?B?Wk1VeTRiUWg4T0ZZSmZPQlRlcVJZY3NJSjJ6VnI0RlN1RnVCZlNvc0xPc1hs?=
 =?utf-8?B?LzdHcktrTjVOSjVhaWl3ZnVpckJwZHVPcHVOanBoOVVNUTlkOHFFSFRHR0Fl?=
 =?utf-8?B?VUZiUnYrc3JQWWxJbVdhVFE5SGRsaGt4V3ltRXRHWHFSSXZrSVZnS1VyYS9t?=
 =?utf-8?B?cVpOMld4NmpJMFdXTlJqbEhaMHduZDRmS2t5L0N1VURINjRxU1NXV0lRVDk3?=
 =?utf-8?B?Mjd2Nk1UMkxFdmNpSVZsem4xVFFTTWZnMUJ2aW9lZFFIZzBsdkhPUm9hY0lk?=
 =?utf-8?B?QXZtcTVTZjdscldXUkoybVlZQ1Z1ZW1ZTzNUYWIrUlpjRFBoZmg1U0dIemty?=
 =?utf-8?B?WGE4b1R6T25oUW1LKy9IV3dKQ3dqQ2pKTTVhK2hzdS9LcXkvbmc0ZWlwRy9L?=
 =?utf-8?B?Y2pYMHllakV5ejFNSXVoMUd5aENiWThIb3lFWVJHWFBkalREV0lseE1Rdita?=
 =?utf-8?B?WVJhMFN0OVRaUjBGZ2gzbk56U3FaNUhPUUI4S2VxL210RVlEL21OVzlDRjQr?=
 =?utf-8?B?NjJWVDhiNEdsMExXS0g5VnA0SlZCL0NITGd2SW9Pb3E1cDAxdG8xVm1HKzdw?=
 =?utf-8?B?TUxtQU0vTlozV2NBRktMLzBIZW1DWEYwUUs2STlaUlNaTS9LR0s4QkxTU3Va?=
 =?utf-8?B?cndPSWt2ZW8yVlhhdGIyMUthTWJzV0JaYytVa1lwKzMxUFB5NlJUeXZJV3hm?=
 =?utf-8?B?QThGTVFVMG01K2sydzgreDA2VElyWnNLZnFTdGJoWXBSY1pHeUIrS2RJRUhv?=
 =?utf-8?B?Nk1MMTByd0JVZ2w2eHRGcHlneWRibm1wby9GRjFZS2lHUjlQODFQd1dWeG5C?=
 =?utf-8?B?ZWY1cll3OFpKRjgwVFY2MFpncnM2WHAveVZMN3VzVHFVaHJma1FUdmF6WjNr?=
 =?utf-8?B?MzJ3NHY4QkhpR3BWOWxXK1M1WStpNWtZWFBKaFVFWXhQL09hWVBvYmhDN3o3?=
 =?utf-8?B?OXE4dFBQNnRwTGpZeDVobEFYWUVNNDB1WTFad3dHRDJyTFc5ZUpiWFo4YXc0?=
 =?utf-8?B?bnVLSGlmMnlOaGRUNzVBKzV0Um1IN3kyamE5NUtMQXJtY3VJRW9hN3dNQTdk?=
 =?utf-8?B?UFVHUGNMLzRQUVZXbW5kK083WWc5L2dCdFFiVzRUZGlmejRhaWV6cjhlREZ6?=
 =?utf-8?B?OVFmT2c3UG5rRkVKTW9mWDk0UHlXUUt1VzB6MGF2K2ZmeFMrQ3RhaWhTak9n?=
 =?utf-8?B?aDdvemdreVBYUDFES2t1YnpRSzhBaHVVc3JLcVN1YmJjSUdycC9tWGwzcW8x?=
 =?utf-8?B?d0RCdzJvMSszTTBna0U0bGg2WHozSWFTaEg5S1RiT3FRUFFHa3hLUXplM2lF?=
 =?utf-8?B?OEJsMWNzcGFZL3dQZGpyU2RxSlBUZk94T2lrWjZML2xieXNkakxjSlF5SSs1?=
 =?utf-8?B?aytMYkUzenN4a0QyM1c0YXFhRFRxRTByYVM0eWVQWG5samhnZ1o2bWF1YXlT?=
 =?utf-8?B?aFJ1SnkrU2JYeE5mOCtUaDhzU0U5dmxUb2tYUi9MUkh4b2dNV1dDQSt2czBv?=
 =?utf-8?B?SThzNTRIWFdaK25qUi92dTdhcW5DWklpdFowdzE2N3Q1RDNBSFdHazdqU1A3?=
 =?utf-8?B?V2c3WFEvQVgyYVZVUHdjZngzTFhxRlEya2NHd2Z2TGowRDBXcThtbmxxbC9D?=
 =?utf-8?B?OHRTRURhT1N4ZHY0Um1pd0RCdGYzMlJnTjdZbFFHZmlLYk5qZE91a3l2Q3pZ?=
 =?utf-8?B?Tm5ZWmZyRFZkTDM1aGFQWG9PL0NoQVhlem5aU2dpckoxZ0RwWTBuaGVHSE1P?=
 =?utf-8?B?b21kSFduRHF3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5315.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVo4SXVlNC9BZmczUjF0L0lYT2Z0Vkp4c0lXeWxLM3ptcGtGVVJ0WGw2SERK?=
 =?utf-8?B?cW1JeFJuZDdML0xUUlBSbWZEZStRM0tTN2lTbVhtOVorcDBDREtqczU1SGs1?=
 =?utf-8?B?NHJsNW0xZENoZ0tFMWdWYmgxQkQ3YWV2eDV0S0Ixc01GZTBpc1VucTg5ellh?=
 =?utf-8?B?eXFuMFFzSENEbTEyU0pJa0RyRnJaLzd2dTc5QTlmR1l0VGt1azZVallyQ3VJ?=
 =?utf-8?B?clZYcjdhb251NVdGbXZuTFBvU1RHc2ZiR1BuMDF0RFo4M0pyYWtOOUZzdERS?=
 =?utf-8?B?UEwzRFB0OHJDQmV1R3dpY3RKY3RYR1BSQU9wRTdzbVR6Mk40cWpSYXJmYnlo?=
 =?utf-8?B?VDd4RFZPZGg2RVg2ZnhOU2M2ZjIrZWdXSk5wRHZOMmdRUHRYbHdtYWRyWUdn?=
 =?utf-8?B?REcwYXBxMjBQTnhMa05wK1pVb2IremFxQ1FnbFFwNEptM09hb0UxSERxSXpj?=
 =?utf-8?B?clFxSWs3T0FzWDFqMHdNR1hHNWJIR1dpWlBXeVhsb0NRM1VNckU0VEE5Tlgr?=
 =?utf-8?B?VC83RmdrQWxZdWRLN3pJMHVPa21mMEordzdwWkJWQ3ZSOVhONCtHcHlPYmd6?=
 =?utf-8?B?NStYNDY1NU1ZU0Z2b0grQmNWYzI0MlVYQ0YvdGVBZ0hxUGk0SEU0T3ZxM1pw?=
 =?utf-8?B?d2U2VWtaRkJsbWRCVCtYNm56aUdJTnh2bjY4OENCNkJpOUZ0SGx4TGtWWk05?=
 =?utf-8?B?NWZ3anRFWkIvY1ZsbFpQSFg3RUtFVnlia01wVWl5ZkpXOVpodmVpZUZscW16?=
 =?utf-8?B?WFpSUUZjYU93aG80ZDNUU2pJdXJKa3hNaGJSVVhZUDR0RUN1dGtkUXhXbjh5?=
 =?utf-8?B?VWNlOTl5QWZGaE1ubXVFaFRKUEE5RTlGMUttcUNiZzYrM1pnRmc5SkpqRGZL?=
 =?utf-8?B?Wjgxc0ZwNDBoY3lzYWQxTVhhb004QitHbUhqQitGdE1NOFo5Z2lFK3U1QW91?=
 =?utf-8?B?N0JNdG9YN2R0WUQvZ3JaL0tqZTZlVllieTBieTJQTEFtcFJmL1pGYW51dkR5?=
 =?utf-8?B?azIwdTYxTzR2bndrRWphVVdQMmppTzhvUFp6NkhLRkdXL2xWU2xNdklvZW02?=
 =?utf-8?B?bnZlVThGVnFQS2FJWHZjdnVxZTBlNFpzVGthaWwzbTEyU2VUODRQRTdqeDRs?=
 =?utf-8?B?amNnYWRZZVVkcWEwNWpjcW9ucTJsekVBWkpzRU9rczZXVTcrZUVZV1FwZlFo?=
 =?utf-8?B?ckpjOEdUN3RNcElwaVFRN2xLemM4TjFhN3g4aE9idFlDQ3ZUYllZUENRTldX?=
 =?utf-8?B?SWFWTUc2SXdOcjNOc2N3NU5wUUVRVExoZzg3SDExeFEvUkp2QThtOVpHeCti?=
 =?utf-8?B?ai9DT0Q5eTlYOWo1bUEvNGxSUTZBUW5Ya0NtUTVWNnVUb0FNLzNENTVvanZP?=
 =?utf-8?B?akhnRzFvRGRhdDBSOUw3eXU3eFBIR0pzclg3RW9pejdlRzhQc2hUa1RVaEZ3?=
 =?utf-8?B?dWMzWERhaVpCazhROS9ya2lKQkZjSVBQZmtiN21XcnVyaGdTem9SeDliWHNj?=
 =?utf-8?B?a05tYmV6ck5zUVdZSDMxRC9Eb2U2bzNQQTEzQ2NHcVdNM3BnbHVacUswdWFH?=
 =?utf-8?B?OFQzSU5DTkNzZ2d5N1J6N0FGVnU4elRiRm8wc2hPcWhBaVNsZ2ZIbFp5OXpR?=
 =?utf-8?B?cDdVZ0FlUzNVcVdCbERKNkN5d0pDeFpLNlNNY2VnRXowc3lEblN3ZWM2SHA3?=
 =?utf-8?B?OXd3blROT3JaTzJuY3o0MW9xbjZiZiszZFpRaVBUbS8ySGNON2lXY1YyQ3c2?=
 =?utf-8?B?Rlk0UDB0dVQ2VDNpb1FxZGIyQStJT2gyTXJ0SEtBOXB4bk5VMWNCUDdNOHA4?=
 =?utf-8?B?YktkMVI3cXNKZy9ncko0NGtKR0F0TlprWmZFeHlsN0NHWG1MUWFvakxISVRF?=
 =?utf-8?B?YUo2Yy82K1N6c002c1ZHQitrNmhGQTlmVFUvaElTUG12VXlGYmpFWWtjcGk2?=
 =?utf-8?B?WTViNWdGakVZbDlISmxSWmFQTCt3NU5td05oaXhIQ1RwYWg2WTNlbENKVmQ1?=
 =?utf-8?B?OUx5SGJLN1lGV0RIbmROUytXYU5EelE3ZXA1TVdkcjhSUWwwVDFFRzY2dVJ3?=
 =?utf-8?B?bHIxWUNjT2l5L1pFZTJxb3lqUDhwa2xQU1VUeFlhbFRTUDBhdlYrWmd4YWJj?=
 =?utf-8?B?aDFWS1lwZUlRbk1wa2szL0VWdnFrVjc1QjBwRDNhcWZjQmdjV2ZTQWhEUHpL?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BRTsQljnFQFmPMpSf+ievImlUtqzGtE8Hyh84VX37ZDrOvgMYcF16FEQTexpKOuv74gphjLkk0Qr6iJGCrzIvgYTkjAYqOIqYt81E07JKnhwm3Ze6oxUVc/fMpJacHWFHm4Y6a7c0AXUdmTpiPvW5ou9j94JK0511KSTH0hvAqi2pEhpcFn37FLU1b1DwfgNMxTlp1OucvXMImaXFNlggEJliJEg6qhJeJNpKHONFui1LTT3076uAFwKsDsR0MyteoroQ+xRS7tdD47jl1wkjmsgZYkJ+R/JXzYjqY/cvf4Z/a8Xa9WM0vVzZ/Qt9B8XBqO2FA5zOo37T5xCbB0C0AkNYYLp0cq1bsxmV59YVWjgzbO74elRnHPgpnEV5o2vluKKMZU/CVC65o2AMdIZ/6wkiqZ3ne6g4b1U9S5NKLnK+R5HwMkYcqJ4PphM0STfKKr9l+gzsr8z82VFRjMDJFZjD+TsG4wtuYLLB8KWA1zwjyWX5w69wi+OCSKQg6Q1H4KM5vVPFPVIb8MYLbYJCbwyxvAA2HVye4+GznZkskQhedIDrDfAyYdPWO9XohgGefdM1O3tasNyKBstt1S3LzIIP2/1CoWZuA+wk/JpIT0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2828728b-e278-4993-a055-08dd913a6107
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5315.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 09:50:08.2811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DlbYe3aUgenejDLlsYxEdZtvm0eKXb/YIrNrRK197iPlMORTVQVbRmNNjTiWYh7VymwFXkSNESxJPhJgUwIWTbxcYw88ujXVIcXbw42Zc9U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7567
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-12_03,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505120102
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEyMDEwMiBTYWx0ZWRfX2DraSPL1kLR9 08ccXxuwfUPAZjcqmH6cHdpd7bVNXgITyOGIOOvEuLC2FDeDtRRepgttECZFHwxtFXDdNJnR4A0 oKrWwesjPivPMkMd7WSKvWToKBNyE//5p52imQ1CZ3olSrcP22jO/Sa3O2Ra4aY4MAVutgiRhlB
 2Znu/nKBaStHdSOiVWLjMsCQ142++PvGH/HsNA12G0RMBPEZt//UnGFraoeftIMMkEDWH+aErZ9 OXMjaqFk6E92CZR5hCNL5uG4HUoCmsdGmRkHWlCkDhrsHmFf+HUhVMKEzUY4xBerfj365tjrglj sKU1SIdFRdjIvP/KPYtm6cRxudc1QaaHF35sR4EgUNPrOc3VCl95GsQ4jcrQfJq2V+2kFbDp7mX
 l1Mpq0tvhMUgLQ02NME1T7+yRsiAoVzVwApphUP1Iiz4/Y+AS9Zv2O9GJlMj40S9vcFBgURG
X-Authority-Analysis: v=2.4 cv=VMDdn8PX c=1 sm=1 tr=0 ts=6821c454 b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yMhMjlubAAAA:8 a=Nh1n-laePfJC8WIratMA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13185
X-Proofpoint-ORIG-GUID: tGRyU5xid-SlgANjP0n5cOFFis5uIX5c
X-Proofpoint-GUID: tGRyU5xid-SlgANjP0n5cOFFis5uIX5c



On 12-05-2025 04:37, Roman Kisel wrote:
> The confidential VMBus is supported starting from the protocol
> version 6.0 onwards.
> 
> Update the relevant definitions, provide a function that returns
> whether VMBus is condifential or not.

typo condifential -> confidential

> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>   drivers/hv/vmbus_drv.c         | 12 ++++++
>   include/asm-generic/mshyperv.h |  1 +
>   include/linux/hyperv.h         | 71 +++++++++++++++++++++++++---------
>   3 files changed, 65 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 1d5c9dcf712e..e431978fa408 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -56,6 +56,18 @@ static long __percpu *vmbus_evt;
>   int vmbus_irq;
>   int vmbus_interrupt;
>   
> +/*
> + * If the Confidential VMBus is used, the data on the "wire" is not
> + * visible to either the host or the hypervisor.
> + */
> +static bool is_confidential;
> +
> +bool vmbus_is_confidential(void)
> +{
> +	return is_confidential;
> +}
> +EXPORT_SYMBOL_GPL(vmbus_is_confidential);
> +
>   /*
>    * The panic notifier below is responsible solely for unloading the
>    * vmbus connection, which is necessary in a panic event.
> diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
> index 6c51a25ed7b5..96e0723d0720 100644
> --- a/include/asm-generic/mshyperv.h
> +++ b/include/asm-generic/mshyperv.h
> @@ -377,6 +377,7 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
>   	return -EOPNOTSUPP;
>   }
>   #endif /* CONFIG_MSHV_ROOT */
> +bool vmbus_is_confidential(void);
>   
>   #if IS_ENABLED(CONFIG_HYPERV_VTL_MODE)
>   u8 __init get_vtl(void);
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 1f310fbbc4f9..3cf48f29e6b4 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -265,16 +265,19 @@ static inline u32 hv_get_avail_to_write_percent(
>    * Linux kernel.
>    */
>   
> -#define VERSION_WS2008  ((0 << 16) | (13))
> -#define VERSION_WIN7    ((1 << 16) | (1))
> -#define VERSION_WIN8    ((2 << 16) | (4))
> -#define VERSION_WIN8_1    ((3 << 16) | (0))
> -#define VERSION_WIN10 ((4 << 16) | (0))
> -#define VERSION_WIN10_V4_1 ((4 << 16) | (1))
> -#define VERSION_WIN10_V5 ((5 << 16) | (0))
> -#define VERSION_WIN10_V5_1 ((5 << 16) | (1))
> -#define VERSION_WIN10_V5_2 ((5 << 16) | (2))
> -#define VERSION_WIN10_V5_3 ((5 << 16) | (3))
> +#define VMBUS_MAKE_VERSION(MAJ, MIN)	((((u32)MAJ) << 16) | (MIN))
> +#define VERSION_WS2008					VMBUS_MAKE_VERSION(0, 13)
> +#define VERSION_WIN7					VMBUS_MAKE_VERSION(1, 1)
> +#define VERSION_WIN8					VMBUS_MAKE_VERSION(2, 4)
> +#define VERSION_WIN8_1					VMBUS_MAKE_VERSION(3, 0)
> +#define VERSION_WIN10					VMBUS_MAKE_VERSION(4, 0)
> +#define VERSION_WIN10_V4_1				VMBUS_MAKE_VERSION(4, 1)
> +#define VERSION_WIN10_V5				VMBUS_MAKE_VERSION(5, 0)
> +#define VERSION_WIN10_V5_1				VMBUS_MAKE_VERSION(5, 1)
> +#define VERSION_WIN10_V5_2				VMBUS_MAKE_VERSION(5, 2)
> +#define VERSION_WIN10_V5_3				VMBUS_MAKE_VERSION(5, 3)
> +#define VERSION_WIN_IRON				VERSION_WIN10_V5_3
> +#define VERSION_WIN_COPPER				VMBUS_MAKE_VERSION(6, 0)
>   
>   /* Make maximum size of pipe payload of 16K */
>   #define MAX_PIPE_DATA_PAYLOAD		(sizeof(u8) * 16384)
> @@ -335,14 +338,22 @@ struct vmbus_channel_offer {
>   } __packed;
>   
>   /* Server Flags */
> -#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE	1
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_TRANSFER_PAGES	2
> -#define VMBUS_CHANNEL_SERVER_SUPPORTS_GPADLS		4
> -#define VMBUS_CHANNEL_NAMED_PIPE_MODE			0x10
> -#define VMBUS_CHANNEL_LOOPBACK_OFFER			0x100
> -#define VMBUS_CHANNEL_PARENT_OFFER			0x200
> -#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x400
> -#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER		0x2000
> +#define VMBUS_CHANNEL_ENUMERATE_DEVICE_INTERFACE		0x0001
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and must
> + * use encrypted memory for the channel ring buffer.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_RING_BUFFER			0x0002
> +/*
> + * This flag indicates that the channel is offered by the paravisor, and must
> + * use encrypted memory for GPA direct packets and additional GPADLs.
> + */
> +#define VMBUS_CHANNEL_CONFIDENTIAL_EXTERNAL_MEMORY		0x0004
> +#define VMBUS_CHANNEL_NAMED_PIPE_MODE					0x0010
> +#define VMBUS_CHANNEL_LOOPBACK_OFFER					0x0100
> +#define VMBUS_CHANNEL_PARENT_OFFER						0x0200
> +#define VMBUS_CHANNEL_REQUEST_MONITORED_NOTIFICATION	0x0400
> +#define VMBUS_CHANNEL_TLNPI_PROVIDER_OFFER				0x2000
>   
>   struct vmpacket_descriptor {
>   	u16 type;
> @@ -621,6 +632,12 @@ struct vmbus_channel_relid_released {
>   	u32 child_relid;
>   } __packed;
>   
> +/*
> + * Used by the paravisor only, means that the encrypted ring buffers and
> + * the encrypted external memory are supported

Clearly convey the purpose of the flag, similar to the previous one
For example ->"Indicates support for encrypted ring buffers and external 
memory, used exclusively by the paravisor."

> + */
> +#define VMBUS_FEATURE_FLAG_CONFIDENTIAL_CHANNELS	0x10
> +
>   struct vmbus_channel_initiate_contact {
>   	struct vmbus_channel_message_header header;
>   	u32 vmbus_version_requested;
> @@ -630,7 +647,8 @@ struct vmbus_channel_initiate_contact {
>   		struct {
>   			u8	msg_sint;
>   			u8	msg_vtl;
> -			u8	reserved[6];
> +			u8	reserved[2];
> +			u32 feature_flags; /* VMBus version 6.0 */
>   		};
>   	};
>   	u64 monitor_page1;
> @@ -1002,6 +1020,11 @@ struct vmbus_channel {
>   
>   	/* The max size of a packet on this channel */
>   	u32 max_pkt_size;
> +
> +	/* The ring buffer is encrypted */
> +	bool confidential_ring_buffer;
> +	/* The external memory is encrypted */
> +	bool confidential_external_memory;
>   };
>   

Thanks,
Alok


