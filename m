Return-Path: <linux-arch+bounces-13021-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E2818B194D9
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 21:08:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58E5F7A9C6D
	for <lists+linux-arch@lfdr.de>; Sun,  3 Aug 2025 19:07:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA4F1D5ADE;
	Sun,  3 Aug 2025 19:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TBDez3Ry";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rjPqK1V9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BCD14A4DB;
	Sun,  3 Aug 2025 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754248127; cv=fail; b=tDQQ8RhmSUtt10ZUoulFc986JsCMrjzmPzbwgDmsODPNtf8BaqD8TDDGBsgy5sW/eHnGqpH3oO6P9Sat0zlc0coSr1/f8PFpLnX4WthJMU7SNxbOI1Qq+a51tdljMWDFsRw/WSuU8C0ccGtvOuWNhxtGPgx14EYPf6bMlwjKx/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754248127; c=relaxed/simple;
	bh=T4gEZlTd6NnbtzMqDQcEK4go1TATlo98oNOnaO/Ey7U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CIqVoF5PH5ZGtxNDbR9Vt2IEWj3Sq4wx3Vbh5BQu2PT9ggt4qWBdA/R/MgL62yKgefhmZ0JmdM03w6SZeA82LqOQ0ZHhpK6QnUB6ICFo7vYgD7o69prW2c5H12qggHYDv7fu/aFS74croHfE8+FtcQ9suzD5SLp11tQijkXgvMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TBDez3Ry; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rjPqK1V9; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 573J1U5A017777;
	Sun, 3 Aug 2025 19:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=89xDBxaVn7/uN55LEzWcAyW3vzqjMWsZyc8VUId2LfM=; b=
	TBDez3Ry7gALwefcuQP+cdGCM3KavO69+rAjGdznZDmjNmRYRbDdlDBgyP6bn9Se
	fl0hDobUD45FmgYAQQhyLBTFXT61i5DGI87uWv8Aeg0WWo9W3SqQe/Fh/EwAUDMh
	UAhw/oN3VNi3V0i1mkqigvri4iAplNwfM8m4Q6pYy4jgP3/z3J2ZeOZnmwJga/nQ
	dAvR/Dun0psR8LNxukrd8Ul1jz3bkeFq6uu2+CIMEfFl5v2okQoGWbxDpuSYdgX5
	EOSjrk2cSWl+dabpYL0MYZ8aog/yyy/LB+obseRlS4woVwTJBSIljV7JmEjmc1g1
	7JGF00jGf6T1e1OW0jJpHg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 489a9vsfbe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 19:08:14 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 573HRLcA013435;
	Sun, 3 Aug 2025 19:08:13 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2071.outbound.protection.outlook.com [40.107.95.71])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48a7mqnsyu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 03 Aug 2025 19:08:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eszn1Y506fBkHnaRcixlOcYfFkvczcB3l4CZh/3CcA3AZcbMrFcY6p2daUqFADW0KtmlAMfPIylM39z2JDLckn3wO491yn9w5CQDSKh+7acaUwRqMt5dtP6W5/Abw5E0KnwGnK94DVpuwx9c4k54FezzSXQ41Pe2mivXua8XlaaLLwrwuuF2OOkO8k9XX7dgjIbnBLUk36BDGwcqHp3lESBDimwpKWO4WnfIMLRFnZ0Tl3rMqfPkjIh/4F/Ke6WoJIxG32leIA79h97fU+2yiiAHIn3sUWRxhe+ngeydhqhT3ryVB15osbUPAlzr1AVhZaNlsw8ACNeAcz99DHAbCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89xDBxaVn7/uN55LEzWcAyW3vzqjMWsZyc8VUId2LfM=;
 b=bzgiRahYPeg4WZssFd3EC4GdcQcjE2XkRkE4FiPNW/tv9Vq2LHjZhH7Qg82KTg1IO16ltD1zOC8qFhrMjvJgZF4KuOlEWst3V4QyR8B4MsnI//AEVS/MK+I8z4XuusIfI8jnTp9yiyuRSEdm0Wwd1tDz5eBNuqWPbIVsbooQYcolhAAxnmY36J590GfM+KTbIbftYeICM9Wuqvv6AGoEln80p3awPRtFry+DG1lJDIFptGO3Chfy/RXZy5ptOb4PL+7jr3vwk9lf0ZV3b476JOYz1okuV8MrbThy5w6MXltTvayIlHUozC1CxIkmzmyzHCmvLT9p1y3FfSukRFijPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89xDBxaVn7/uN55LEzWcAyW3vzqjMWsZyc8VUId2LfM=;
 b=rjPqK1V9EQv9cJKFt7FMnz4FUj+NXKvKusLeJspIyGoOss62fwcR0CJhhHK8E3efuvT6LEeSjMA9fy1g9mXhlzSbKZEmvxnSxWvzGblMdPNmJSC9m09cHbnclWPSC4B/U/72dqETCkpOUoOJQwMTiSaAKkmhfEfnKY/9kYfGzb4=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by LV8PR10MB7989.namprd10.prod.outlook.com (2603:10b6:408:203::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.18; Sun, 3 Aug
 2025 19:08:11 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8989.017; Sun, 3 Aug 2025
 19:08:10 +0000
Message-ID: <83931f05-a613-4972-be76-80bc695915e4@oracle.com>
Date: Sun, 3 Aug 2025 12:08:09 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 25/36] sparc64: Implement the new page table range API
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-arch@vger.kernel.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org,
        Andreas Larsson <andreas@gaisler.com>, Rod Schnell <rods@mw-radio.com>,
        Sam James <sam@gentoo.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-26-willy@infradead.org>
 <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <ce6337237169f179c75fe4a1ba1ce98843577360.camel@physik.fu-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR01CA0029.prod.exchangelabs.com (2603:10b6:a02:80::42)
 To MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|LV8PR10MB7989:EE_
X-MS-Office365-Filtering-Correlation-Id: bf629809-80b0-4b99-86f4-08ddd2c11697
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cUFiMlFua3RWQzBkNzdudUVWMkprT3NjQ1djN2lnSHloSDlMdFNqYml3TkU5?=
 =?utf-8?B?dktlM1F3bm5Na1R0SlZRTVBzNEtPaUwydDRLN25rZEJScVNZYmdQdStORmxn?=
 =?utf-8?B?VzNSaW9YTGtza3h2RFdGQjJVNm5lOEkvVDFRUkM5VU50NU9SZ1lCZUE2bVRF?=
 =?utf-8?B?Njg2Zm1GOFlDUGcvMm9PQ05Bb1JPNnd4SDVPV3hyYXVSOEYweG85YlJLNEto?=
 =?utf-8?B?cDFvTytxN3crODcwdVczMHJwQzFlOTREY3NmZyt0dzhmMjczL1lxdC90OEV4?=
 =?utf-8?B?QzNJRXNWckJyaEtGL1l3Y1VxZzY3WlIzMGR0R0Rlb1h0R3BxcWt3RHp6TENp?=
 =?utf-8?B?d0h2anZPUEdZVW9XMDFodGw2cEY0Mmw3NURnTTFMb3JqMUp4ZWtPVW1tS2Np?=
 =?utf-8?B?YkQvSjV1RWNMcHhNcEV5S0M1VUl0ZzFud3JxY1hwMmlNSi9EMjNCK2dWb2hO?=
 =?utf-8?B?enlOd0pTeGk3bXBKemprdmd1M3FNazkvc2Zwd21FZUIzQjNZVlhIdjUyWW5p?=
 =?utf-8?B?ZFQvbkVWYWIrRXRwWXVvRFA1ZGtWaHMwREc4UVJpTXUvay9UVis0eERmSmZp?=
 =?utf-8?B?T1h4TWZHVkxKS3A4R21aQWQ5SVFYZ0pLYUZHcU9Yd1ZLYmpqNjZ6NXJ5K0I5?=
 =?utf-8?B?Ynd5bUJVOVRoY3BTUUtLZTVKMTJRaHpsZzgvcjdzRUZlZXNlQnJrZVY5ZGpt?=
 =?utf-8?B?VE1aWDBtdU1Yamk0M0k1bWRvMzRid1BnbS96RDdzYVVpUHBmWmpVVmtzb2hF?=
 =?utf-8?B?UlpKQmhPNUUvOG9MUVZaeEVBU1FkME5xd2Z4ekhFL2VyeG40UHF1Rk55UW8y?=
 =?utf-8?B?WWk4NlFadUZDZU5wTmROU1VMVVk3R29ndVQ1cDg1Ym0ybmRZQXlvREF6Z2xC?=
 =?utf-8?B?dW9vYjJrK01FelJLQjRlK05tV2haUXpCYnJtdFdReUtkOFJiMTZRWStpZmUx?=
 =?utf-8?B?N3pmRFdLTlBBd3dzY0ZxU3Z5Z04zQi91aThMS0pQcGhJUGlLV0s3RzlwQnVh?=
 =?utf-8?B?VDFxekVpL1VTcGJtTm1OQVVSR3NFU2Vzcmw3cDNhcEJiN2NLMVl0ekJtV2pK?=
 =?utf-8?B?K0xWQk1ybE0razFNK3hxMkVhdkY0Z1RObnJha1V2czZmcXk4bEI3ZFNpMGhn?=
 =?utf-8?B?WExHcVJha0lMOWhyeXBnckZQTEh4MVRqeC9jMUhZRzdPVEVZaE1QMVhhUmt4?=
 =?utf-8?B?VGVlb2hIdzk1VTFqNW02aDNaWDRXclNHaVdjUzFwSkp0RlczaU1ZaERWOG1X?=
 =?utf-8?B?RytMRGVZTFBnVUpWUDJvSnluOVR4cUlycE1oS3NRdWllQmFkODFXZmxjZHEr?=
 =?utf-8?B?a21EZXJHQUZOTGZwYzlrWHlsdjNCR0MxZFVpeXd4c3ZaSUt2OHoydWs5b0Mr?=
 =?utf-8?B?UHh2VjNYblRZMmFCZG42dDZsdWJoRVYxdGFxT3F1MkV1Sng1ZHYrQlFtMnlM?=
 =?utf-8?B?WCszT3lxV2ZxZFhiU0M5cDhTSTBic3p5L25OWlJnb2xJRnlVOEdZZDFOa3J1?=
 =?utf-8?B?RVM1bEZZVFJ0SkZjZkYrVmVBaUZtNThTcE8yV09FZ3B5c2MzZ0l0c0pIOWla?=
 =?utf-8?B?Q05aTGZTR1gzSCt0T0NJaWJ3MGlKZlMvL0NwWWRiT0F0aVBiakxqY1ZJSEdK?=
 =?utf-8?B?bnV3KzhkNEY2MFRkZTMvL0wvZVpKa1JqRVpZMDdkeGo4TC9HV3RQajVhU0Nv?=
 =?utf-8?B?RTZGeExZdjFSRWNXTEFsbXg2aGpsNnR4bVd6SkdDMDRRNENQUzNVUXFhdU5B?=
 =?utf-8?B?ckV0eDQ0a0ZzbGsvUndOUEhrY3dRUGk5UjhiL2E5ajFJQVVOZWRYK2xISXUz?=
 =?utf-8?B?RUVjSW4zb3BkTmdObTg0RFR5Z2Y0Z2d6bmdBc1gvaTN6bC9EaUU1dEw2WUJJ?=
 =?utf-8?B?NkpUcG9vNmZGUVkrY3l5blM3RlJCYWUrUjVibGpvRlBFb1RZRWtWeDYzOHhB?=
 =?utf-8?Q?DYO6VlV09Sw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dm5NcGN2bGMvNUZsemZidngyRHJtR0w1cUNKNXg2dVNPaUU4VVdOLy8ySFIr?=
 =?utf-8?B?TENEMnNUbkx2ekU2VnYrT28vMjRVaHJDanVaMEkxb0o3R2t4TzdZZzFvTUYx?=
 =?utf-8?B?QVkyKzlOOUt1aWdDSmg0c1IrK1ZpWkhYaVZFcElZZzV5Z2lyMkVLakhNMkZv?=
 =?utf-8?B?NDhrclhxNXptOFFrQjIwTGRqNzc3Nno4d0RUQjRaRmpSNk96WGFrTzdxd2hi?=
 =?utf-8?B?ZnJpZlc0YURxOXowd1ZYQ0lNdTVoSng1NFcxR1RkV1lKL3FZQ3RLcWtOcE05?=
 =?utf-8?B?N3ZIZ01qdWFLY3JBeU9sTXUxVXZYcVhERit6WDhRUTdsKytUQkhaK3ZRK1Vt?=
 =?utf-8?B?N2FqWVhlYmI1U0tlVXE0RXE5cmRFcmVVT25xQ0sycS9NSGIwdDZjM1ZHUU5D?=
 =?utf-8?B?T1JWcGl4Tzc1emljM2VrZ25nZzUzWkZiWHpNMVpUNXlmbFBua3FWenpmbnor?=
 =?utf-8?B?Y1RZZlQ0VFlCZGZCeDJ1Y2c0cVpyVThBZTRpQVgyS24zNXpLcThnaTdhakRa?=
 =?utf-8?B?Sjk5K0tNSVg3ZWI3Wm5NTHhoTFpLOXhiWjJSeUVjM1JTSmx2d1lOdDVDNjll?=
 =?utf-8?B?UFJtUlRRYVN3RVpjdnE1NWtHUmhaTjhjdXRlL1ZGdENRN3J3WFZ6Qnc0eVla?=
 =?utf-8?B?UHVkSFI1RnJwZVJ5MU5Ca0xvQzZFNndiY1Z2TU5NZyswZmRUck44dm1qTmxx?=
 =?utf-8?B?cHUzbjU5a3JlZlNYOGJKbHFMVXRIcmxWQ2x0a0NGRzlPWUFVTytEK1g5Mjlm?=
 =?utf-8?B?Tk1qRkRwbk5CQ0xxQm85NEN0dzM4SUU0VkdxUGlxelBHbytjc2lRUjUzMTYy?=
 =?utf-8?B?ZVcwQUptWGw0YXpCUlBtRndaY0swYWFubHV5ajVqcTBPMkNSNGFBNHM1dUJJ?=
 =?utf-8?B?T1ZwM2liTTRXc3FSK2thRmgvQVQyVStRd3N6UzBJYWtzYjRHbDRyeDM2bnla?=
 =?utf-8?B?YnE4dVVCZ1ZkSEgzTXJ2c0JJV1NIMThNTko0bld0Y09BRzZ0SUpLcmhmWVQ2?=
 =?utf-8?B?RStRUlFMWEc0NXhzN0xKT2gwYjRCRnBSUGp4RkR5dlpLUHZObUlwNE9lSlZm?=
 =?utf-8?B?QklmY3IvZ1IxUStMc2l4bzcvR0NKNzFXdkZ4ZFZ0QzR5Wk9zRjg0NXlxS016?=
 =?utf-8?B?WnluakNmUnJvd1QvVS83VmRVa3RNU2Fpekwvb05SZFNWYzNqaXdaUDlqVE04?=
 =?utf-8?B?ZnpLamRqaHpmZlAwTWxkQXBNalVnbmFLcFJaK1JzRlo1Rm1iVy9UTTgrNkdm?=
 =?utf-8?B?OGtxakJFTWwwVUkwOURrSk1LNlJLU0hBTG0wL1A0eVFIUjk4dnBhSjN2MU5X?=
 =?utf-8?B?VnFiWWNRcEo3Vmg1UkpSN0RjNkl5S1lkd0p5Wk8rZDRJTlBFQ1Via2h2NndS?=
 =?utf-8?B?dVY3dUREaHRUNmVEUm56MkkyRkdFbm5ybWh6ODIrU3V0Z0dIajhmZDl6ZUNY?=
 =?utf-8?B?WndHVGczdXErYlkwTlNNdk9BMGZZNFBoTjhxQXA1N3ZJN2V5TUdWcG9GbVV0?=
 =?utf-8?B?Nk11dncrY0daYy93N0ZPOVFsNC9QV3MxSUFHblNGNnpGRjYyWVJEZ2c4K1dz?=
 =?utf-8?B?TTZkWmZDV1hLOERuUTlaLy83a0ZTSkpsc3ZJenFWZkw5b3FIVXo4RU9XN2Qx?=
 =?utf-8?B?STZmemJBRzE3OEQrb3lRdG1Idm1mbmo1Vlk4bSt3b1pNMitaZ0U5em5iMXBQ?=
 =?utf-8?B?MGh2U29RdVBnSm9qRkJzZzZKYXhOUFhkcWM5RXAwbEc1eFVoVVZMay82Wngx?=
 =?utf-8?B?VlV5MDZjNE53TStnTSs4Ry9GbVdJYmlqYUNWWGZqenJEMEgyN1NXalpDalRW?=
 =?utf-8?B?RmV6K1E4RlI3UnZCTGc3cndVM1p2SnV1dTlMamFEeU91NkVBZUgvZEF6REUy?=
 =?utf-8?B?R0paRU0wY1dHQWJhTG0xL2pta1ZkeVZvTFhQY3MxbXEwNDNUMTBxSllOckd1?=
 =?utf-8?B?VHQzOUU1MlM2bGxKc0RLQkpHNEYvc1ZwdFo2U0tZYlFXcERDWFVYK2syZjZF?=
 =?utf-8?B?Q3Q4ZWZXMFg5NGRudFNQdDhReWdCU2NxT0R3VUtmalA4VlhVNzM5M0RtTU4v?=
 =?utf-8?B?alZHNmszaDNVL3VPbDFWM3pkMXZ0RUhnUmg4NnBLMlZGYWhORG1GZU02SGUv?=
 =?utf-8?B?eTNpa1EycHFERnk0N2N1clA4REU5NEYydThvbkowRXYxdnpQV1A0eGw0UTFG?=
 =?utf-8?B?dHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	l99nIWFkNxYxj9ZB2GFqzuXuTjm9Q4T68tkBPX4TI+YZ80q/1x8gOoWp2l6PmJUIoskaiaSsLApp4ijJEU4Ma8rLDwmW6MY3nOXd1riNBmUYjT9UvNIDbWs18Gt80vVsiRroUZDIddvEyk/Xumhdu5mf1tpaHcWhZC/17L8VqbS0SaafbXKRC5cAvA+a/fpJsGu0rOFartFsAwQYJJwh6TA6924AJ2k2HbgrDPBomrKVI2LIOSb5C3+TfUrF5z7Jzle8zvZy8uGMMLG9CkE6aBvG+kkMPQlIThzZ1wcFfehrZDg3b/inR8XJEPDZxM/kTwlWMqYj9vmS8YY7+uHdrOfJq2f2HFfVgCWSnBcfpGh15prAT0kwNKSUHBctKxv9GEJDbq671TYYeFuwWrVuHx3Ye1/mi1qpKizYgsjTHIDShmBpqSf/K6U/XaVKpelX/h9pbrFo0FFvx+vGnG9BykDdhkKz2KpFY18MLFahdEK6jJQlnsG7PTW7DNLkfoo+V4TaGOpCynvXq3NsOd2u1qR6fY2PrIGbJvCGAGRoy57GVn5ML+rYAzWGBDrBryr/u14gL1LHGg3GYz2/1VoHH8x7tFiQrk+Pu1Z0qfr6AVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf629809-80b0-4b99-86f4-08ddd2c11697
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2025 19:08:10.8151
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKGZyvIq2zQfemMR1jsXQ8FeBoA5dNE2aKonyM/cS1sg5oL/8D8vGmM69+Tze95FY5Me/rNnXBGdkrNr4g11RYcgRofh8DeAERfjq2Fx4MM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7989
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-03_05,2025-08-01_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 adultscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2508030130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAzMDEzMCBTYWx0ZWRfX6zEfzrxe3CoZ
 ITdstSurA5suT9D3N+1rnuF/+sqI3IMewstOkFr2VgZumddo5MaAWgXzy0w4FafZvz2wOWyT5YB
 oOZIrfQJn/XEaRbb6OTDqzzEaM+p90338KNL/UgNagwCl0C+TKHbUnoiIWn9acdvjEOSavyqtpp
 86lqKkNXcAQvwn7OOMpP07kst4WWXLQvRNdcKrY+njFu9XsRxxApap+10SwOr3EqbHyluaErFEV
 oBhvRH1NG3wcysHxrb2kFBOTD1o0RdkLOEgRSSwD3jrSDJrGamJRW9g8lK+ditofJKh0F99dXKD
 HANpvI7LmzSyzHs4pDY0RAQRcLQuYT/YH1iN+Z9gD5WXFH3voLruWrIsGxOJxuSz1em3DgiPQHz
 nVjWH7px1uE8bWO12xHLOihNGSvqJDp77AEnWdqUOsoXMHMFQ9pO5WMGcjRO1R/vwEyZBbFK
X-Authority-Analysis: v=2.4 cv=SIhCVPvH c=1 sm=1 tr=0 ts=688fb39e b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=JfrnYn6hAAAA:8 a=J1Y8HTJGAAAA:8
 a=VwQbUJbxAAAA:8 a=_6tRXDilHjbdGHO03RoA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22 a=y1Q9-5lHfBjTkpIzbSAN:22 cc=ntf awl=host:13596
X-Proofpoint-GUID: t6CFumGAf-WetTE9JzHgYhFapN5IAPXV
X-Proofpoint-ORIG-GUID: t6CFumGAf-WetTE9JzHgYhFapN5IAPXV

Hi Adrian,

On 8/3/25 5:05 AM, John Paul Adrian Glaubitz wrote:
> Hi Matthew,
> 
> On Wed, 2023-03-15 at 05:14 +0000, Matthew Wilcox (Oracle) wrote:
>> Add set_ptes(), update_mmu_cache_range(), flush_dcache_folio() and
>> flush_icache_pages().  Convert the PG_dcache_dirty flag from being
>> per-page to per-folio.
>>
>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: sparclinux@vger.kernel.org
>> ---
>>   arch/sparc/include/asm/cacheflush_64.h | 18 ++++--
>>   arch/sparc/include/asm/pgtable_64.h    | 24 ++++++--
>>   arch/sparc/kernel/smp_64.c             | 56 +++++++++++-------
>>   arch/sparc/mm/init_64.c                | 78 +++++++++++++++-----------
>>   arch/sparc/mm/tlb.c                    |  5 +-
>>   5 files changed, 116 insertions(+), 65 deletions(-)
>>
>> diff --git a/arch/sparc/include/asm/cacheflush_64.h b/arch/sparc/include/asm/cacheflush_64.h
>> index b9341836597e..a9a719f04d06 100644
>> --- a/arch/sparc/include/asm/cacheflush_64.h
>> +++ b/arch/sparc/include/asm/cacheflush_64.h
>> @@ -35,20 +35,26 @@ void flush_icache_range(unsigned long start, unsigned long end);
>>   void __flush_icache_page(unsigned long);
>>   
>>   void __flush_dcache_page(void *addr, int flush_icache);
>> -void flush_dcache_page_impl(struct page *page);
>> +void flush_dcache_folio_impl(struct folio *folio);
>>   #ifdef CONFIG_SMP
>> -void smp_flush_dcache_page_impl(struct page *page, int cpu);
>> -void flush_dcache_page_all(struct mm_struct *mm, struct page *page);
>> +void smp_flush_dcache_folio_impl(struct folio *folio, int cpu);
>> +void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio);
>>   #else
>> -#define smp_flush_dcache_page_impl(page,cpu) flush_dcache_page_impl(page)
>> -#define flush_dcache_page_all(mm,page) flush_dcache_page_impl(page)
>> +#define smp_flush_dcache_folio_impl(folio, cpu) flush_dcache_folio_impl(folio)
>> +#define flush_dcache_folio_all(mm, folio) flush_dcache_folio_impl(folio)
>>   #endif
>>   
>>   void __flush_dcache_range(unsigned long start, unsigned long end);
>>   #define ARCH_IMPLEMENTS_FLUSH_DCACHE_PAGE 1
>> -void flush_dcache_page(struct page *page);
>> +void flush_dcache_folio(struct folio *folio);
>> +#define flush_dcache_folio flush_dcache_folio
>> +static inline void flush_dcache_page(struct page *page)
>> +{
>> +	flush_dcache_folio(page_folio(page));
>> +}
>>   
>>   #define flush_icache_page(vma, pg)	do { } while(0)
>> +#define flush_icache_pages(vma, pg, nr)	do { } while(0)
>>   
>>   void flush_ptrace_access(struct vm_area_struct *, struct page *,
>>   			 unsigned long uaddr, void *kaddr,
>> diff --git a/arch/sparc/include/asm/pgtable_64.h b/arch/sparc/include/asm/pgtable_64.h
>> index 2dc8d4641734..49c37000e1b1 100644
>> --- a/arch/sparc/include/asm/pgtable_64.h
>> +++ b/arch/sparc/include/asm/pgtable_64.h
>> @@ -911,8 +911,19 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   	maybe_tlb_batch_add(mm, addr, ptep, orig, fullmm, PAGE_SHIFT);
>>   }
>>   
>> -#define set_pte_at(mm,addr,ptep,pte)	\
>> -	__set_pte_at((mm), (addr), (ptep), (pte), 0)
>> +static inline void set_ptes(struct mm_struct *mm, unsigned long addr,
>> +		pte_t *ptep, pte_t pte, unsigned int nr)
>> +{
>> +	for (;;) {
>> +		__set_pte_at(mm, addr, ptep, pte, 0);
>> +		if (--nr == 0)
>> +			break;
>> +		ptep++;
>> +		pte_val(pte) += PAGE_SIZE;
>> +		addr += PAGE_SIZE;
>> +	}
>> +}
>> +#define set_ptes set_ptes
>>   
>>   #define pte_clear(mm,addr,ptep)		\
>>   	set_pte_at((mm), (addr), (ptep), __pte(0UL))
>> @@ -931,8 +942,8 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   									\
>>   		if (pfn_valid(this_pfn) &&				\
>>   		    (((old_addr) ^ (new_addr)) & (1 << 13)))		\
>> -			flush_dcache_page_all(current->mm,		\
>> -					      pfn_to_page(this_pfn));	\
>> +			flush_dcache_folio_all(current->mm,		\
>> +				page_folio(pfn_to_page(this_pfn)));	\
>>   	}								\
>>   	newpte;								\
>>   })
>> @@ -947,7 +958,10 @@ struct seq_file;
>>   void mmu_info(struct seq_file *);
>>   
>>   struct vm_area_struct;
>> -void update_mmu_cache(struct vm_area_struct *, unsigned long, pte_t *);
>> +void update_mmu_cache_range(struct vm_area_struct *, unsigned long addr,
>> +		pte_t *ptep, unsigned int nr);
>> +#define update_mmu_cache(vma, addr, ptep) \
>> +	update_mmu_cache_range(vma, addr, ptep, 1)
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   void update_mmu_cache_pmd(struct vm_area_struct *vma, unsigned long addr,
>>   			  pmd_t *pmd);
>> diff --git a/arch/sparc/kernel/smp_64.c b/arch/sparc/kernel/smp_64.c
>> index a55295d1b924..90ef8677ac89 100644
>> --- a/arch/sparc/kernel/smp_64.c
>> +++ b/arch/sparc/kernel/smp_64.c
>> @@ -921,20 +921,26 @@ extern unsigned long xcall_flush_dcache_page_cheetah;
>>   #endif
>>   extern unsigned long xcall_flush_dcache_page_spitfire;
>>   
>> -static inline void __local_flush_dcache_page(struct page *page)
>> +static inline void __local_flush_dcache_folio(struct folio *folio)
>>   {
>> +	unsigned int i, nr = folio_nr_pages(folio);
>> +
>>   #ifdef DCACHE_ALIASING_POSSIBLE
>> -	__flush_dcache_page(page_address(page),
>> +	for (i = 0; i < nr; i++)
>> +		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
>>   			    ((tlb_type == spitfire) &&
>> -			     page_mapping_file(page) != NULL));
>> +			     folio_flush_mapping(folio) != NULL));
>>   #else
>> -	if (page_mapping_file(page) != NULL &&
>> -	    tlb_type == spitfire)
>> -		__flush_icache_page(__pa(page_address(page)));
>> +	if (folio_flush_mapping(folio) != NULL &&
>> +	    tlb_type == spitfire) {
>> +		unsigned long pfn = folio_pfn(folio)
>> +		for (i = 0; i < nr; i++)
>> +			__flush_icache_page((pfn + i) * PAGE_SIZE);
>> +	}
>>   #endif
>>   }
>>   
>> -void smp_flush_dcache_page_impl(struct page *page, int cpu)
>> +void smp_flush_dcache_folio_impl(struct folio *folio, int cpu)
>>   {
>>   	int this_cpu;
>>   
>> @@ -948,14 +954,14 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
>>   	this_cpu = get_cpu();
>>   
>>   	if (cpu == this_cpu) {
>> -		__local_flush_dcache_page(page);
>> +		__local_flush_dcache_folio(folio);
>>   	} else if (cpu_online(cpu)) {
>> -		void *pg_addr = page_address(page);
>> +		void *pg_addr = folio_address(folio);
>>   		u64 data0 = 0;
>>   
>>   		if (tlb_type == spitfire) {
>>   			data0 = ((u64)&xcall_flush_dcache_page_spitfire);
>> -			if (page_mapping_file(page) != NULL)
>> +			if (folio_flush_mapping(folio) != NULL)
>>   				data0 |= ((u64)1 << 32);
>>   		} else if (tlb_type == cheetah || tlb_type == cheetah_plus) {
>>   #ifdef DCACHE_ALIASING_POSSIBLE
>> @@ -963,18 +969,23 @@ void smp_flush_dcache_page_impl(struct page *page, int cpu)
>>   #endif
>>   		}
>>   		if (data0) {
>> -			xcall_deliver(data0, __pa(pg_addr),
>> -				      (u64) pg_addr, cpumask_of(cpu));
>> +			unsigned int i, nr = folio_nr_pages(folio);
>> +
>> +			for (i = 0; i < nr; i++) {
>> +				xcall_deliver(data0, __pa(pg_addr),
>> +					      (u64) pg_addr, cpumask_of(cpu));
>>   #ifdef CONFIG_DEBUG_DCFLUSH
>> -			atomic_inc(&dcpage_flushes_xcall);
>> +				atomic_inc(&dcpage_flushes_xcall);
>>   #endif
>> +				pg_addr += PAGE_SIZE;
>> +			}
>>   		}
>>   	}
>>   
>>   	put_cpu();
>>   }
>>   
>> -void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>> +void flush_dcache_folio_all(struct mm_struct *mm, struct folio *folio)
>>   {
>>   	void *pg_addr;
>>   	u64 data0;
>> @@ -988,10 +999,10 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>>   	atomic_inc(&dcpage_flushes);
>>   #endif
>>   	data0 = 0;
>> -	pg_addr = page_address(page);
>> +	pg_addr = folio_address(folio);
>>   	if (tlb_type == spitfire) {
>>   		data0 = ((u64)&xcall_flush_dcache_page_spitfire);
>> -		if (page_mapping_file(page) != NULL)
>> +		if (folio_flush_mapping(folio) != NULL)
>>   			data0 |= ((u64)1 << 32);
>>   	} else if (tlb_type == cheetah || tlb_type == cheetah_plus) {
>>   #ifdef DCACHE_ALIASING_POSSIBLE
>> @@ -999,13 +1010,18 @@ void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
>>   #endif
>>   	}
>>   	if (data0) {
>> -		xcall_deliver(data0, __pa(pg_addr),
>> -			      (u64) pg_addr, cpu_online_mask);
>> +		unsigned int i, nr = folio_nr_pages(folio);
>> +
>> +		for (i = 0; i < nr; i++) {
>> +			xcall_deliver(data0, __pa(pg_addr),
>> +				      (u64) pg_addr, cpu_online_mask);
>>   #ifdef CONFIG_DEBUG_DCFLUSH
>> -		atomic_inc(&dcpage_flushes_xcall);
>> +			atomic_inc(&dcpage_flushes_xcall);
>>   #endif
>> +			pg_addr += PAGE_SIZE;
>> +		}
>>   	}
>> -	__local_flush_dcache_page(page);
>> +	__local_flush_dcache_folio(folio);
>>   
>>   	preempt_enable();
>>   }
>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>> index 04f9db0c3111..ab9aacbaf43c 100644
>> --- a/arch/sparc/mm/init_64.c
>> +++ b/arch/sparc/mm/init_64.c
>> @@ -195,21 +195,26 @@ atomic_t dcpage_flushes_xcall = ATOMIC_INIT(0);
>>   #endif
>>   #endif
>>   
>> -inline void flush_dcache_page_impl(struct page *page)
>> +inline void flush_dcache_folio_impl(struct folio *folio)
>>   {
>> +	unsigned int i, nr = folio_nr_pages(folio);
>> +
>>   	BUG_ON(tlb_type == hypervisor);
>>   #ifdef CONFIG_DEBUG_DCFLUSH
>>   	atomic_inc(&dcpage_flushes);
>>   #endif
>>   
>>   #ifdef DCACHE_ALIASING_POSSIBLE
>> -	__flush_dcache_page(page_address(page),
>> -			    ((tlb_type == spitfire) &&
>> -			     page_mapping_file(page) != NULL));
>> +	for (i = 0; i < nr; i++)
>> +		__flush_dcache_page(folio_address(folio) + i * PAGE_SIZE,
>> +				    ((tlb_type == spitfire) &&
>> +				     folio_flush_mapping(folio) != NULL));
>>   #else
>> -	if (page_mapping_file(page) != NULL &&
>> -	    tlb_type == spitfire)
>> -		__flush_icache_page(__pa(page_address(page)));
>> +	if (folio_flush_mapping(folio) != NULL &&
>> +	    tlb_type == spitfire) {
>> +		for (i = 0; i < nr; i++)
>> +			__flush_icache_page((pfn + i) * PAGE_SIZE);
>> +	}
>>   #endif
>>   }
>>   
>> @@ -218,10 +223,10 @@ inline void flush_dcache_page_impl(struct page *page)
>>   #define PG_dcache_cpu_mask	\
>>   	((1UL<<ilog2(roundup_pow_of_two(NR_CPUS)))-1UL)
>>   
>> -#define dcache_dirty_cpu(page) \
>> -	(((page)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
>> +#define dcache_dirty_cpu(folio) \
>> +	(((folio)->flags >> PG_dcache_cpu_shift) & PG_dcache_cpu_mask)
>>   
>> -static inline void set_dcache_dirty(struct page *page, int this_cpu)
>> +static inline void set_dcache_dirty(struct folio *folio, int this_cpu)
>>   {
>>   	unsigned long mask = this_cpu;
>>   	unsigned long non_cpu_bits;
>> @@ -238,11 +243,11 @@ static inline void set_dcache_dirty(struct page *page, int this_cpu)
>>   			     "bne,pn	%%xcc, 1b\n\t"
>>   			     " nop"
>>   			     : /* no outputs */
>> -			     : "r" (mask), "r" (non_cpu_bits), "r" (&page->flags)
>> +			     : "r" (mask), "r" (non_cpu_bits), "r" (&folio->flags)
>>   			     : "g1", "g7");
>>   }
>>   
>> -static inline void clear_dcache_dirty_cpu(struct page *page, unsigned long cpu)
>> +static inline void clear_dcache_dirty_cpu(struct folio *folio, unsigned long cpu)
>>   {
>>   	unsigned long mask = (1UL << PG_dcache_dirty);
>>   
>> @@ -260,7 +265,7 @@ static inline void clear_dcache_dirty_cpu(struct page *page, unsigned long cpu)
>>   			     " nop\n"
>>   			     "2:"
>>   			     : /* no outputs */
>> -			     : "r" (cpu), "r" (mask), "r" (&page->flags),
>> +			     : "r" (cpu), "r" (mask), "r" (&folio->flags),
>>   			       "i" (PG_dcache_cpu_mask),
>>   			       "i" (PG_dcache_cpu_shift)
>>   			     : "g1", "g7");
>> @@ -284,9 +289,10 @@ static void flush_dcache(unsigned long pfn)
>>   
>>   	page = pfn_to_page(pfn);
>>   	if (page) {
>> +		struct folio *folio = page_folio(page);
>>   		unsigned long pg_flags;
>>   
>> -		pg_flags = page->flags;
>> +		pg_flags = folio->flags;
>>   		if (pg_flags & (1UL << PG_dcache_dirty)) {
>>   			int cpu = ((pg_flags >> PG_dcache_cpu_shift) &
>>   				   PG_dcache_cpu_mask);
>> @@ -296,11 +302,11 @@ static void flush_dcache(unsigned long pfn)
>>   			 * in the SMP case.
>>   			 */
>>   			if (cpu == this_cpu)
>> -				flush_dcache_page_impl(page);
>> +				flush_dcache_folio_impl(folio);
>>   			else
>> -				smp_flush_dcache_page_impl(page, cpu);
>> +				smp_flush_dcache_folio_impl(folio, cpu);
>>   
>> -			clear_dcache_dirty_cpu(page, cpu);
>> +			clear_dcache_dirty_cpu(folio, cpu);
>>   
>>   			put_cpu();
>>   		}
>> @@ -388,12 +394,14 @@ bool __init arch_hugetlb_valid_size(unsigned long size)
>>   }
>>   #endif	/* CONFIG_HUGETLB_PAGE */
>>   
>> -void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *ptep)
>> +void update_mmu_cache_range(struct vm_area_struct *vma, unsigned long address,
>> +		pte_t *ptep, unsigned int nr)
>>   {
>>   	struct mm_struct *mm;
>>   	unsigned long flags;
>>   	bool is_huge_tsb;
>>   	pte_t pte = *ptep;
>> +	unsigned int i;
>>   
>>   	if (tlb_type != hypervisor) {
>>   		unsigned long pfn = pte_pfn(pte);
>> @@ -440,15 +448,21 @@ void update_mmu_cache(struct vm_area_struct *vma, unsigned long address, pte_t *
>>   		}
>>   	}
>>   #endif
>> -	if (!is_huge_tsb)
>> -		__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
>> -					address, pte_val(pte));
>> +	if (!is_huge_tsb) {
>> +		for (i = 0; i < nr; i++) {
>> +			__update_mmu_tsb_insert(mm, MM_TSB_BASE, PAGE_SHIFT,
>> +						address, pte_val(pte));
>> +			address += PAGE_SIZE;
>> +			pte_val(pte) += PAGE_SIZE;
>> +		}
>> +	}
>>   
>>   	spin_unlock_irqrestore(&mm->context.lock, flags);
>>   }
>>   
>> -void flush_dcache_page(struct page *page)
>> +void flush_dcache_folio(struct folio *folio)
>>   {
>> +	unsigned long pfn = folio_pfn(folio);
>>   	struct address_space *mapping;
>>   	int this_cpu;
>>   
>> @@ -459,35 +473,35 @@ void flush_dcache_page(struct page *page)
>>   	 * is merely the zero page.  The 'bigcore' testcase in GDB
>>   	 * causes this case to run millions of times.
>>   	 */
>> -	if (page == ZERO_PAGE(0))
>> +	if (is_zero_pfn(pfn))
>>   		return;
>>   
>>   	this_cpu = get_cpu();
>>   
>> -	mapping = page_mapping_file(page);
>> +	mapping = folio_flush_mapping(folio);
>>   	if (mapping && !mapping_mapped(mapping)) {
>> -		int dirty = test_bit(PG_dcache_dirty, &page->flags);
>> +		bool dirty = test_bit(PG_dcache_dirty, &folio->flags);
>>   		if (dirty) {
>> -			int dirty_cpu = dcache_dirty_cpu(page);
>> +			int dirty_cpu = dcache_dirty_cpu(folio);
>>   
>>   			if (dirty_cpu == this_cpu)
>>   				goto out;
>> -			smp_flush_dcache_page_impl(page, dirty_cpu);
>> +			smp_flush_dcache_folio_impl(folio, dirty_cpu);
>>   		}
>> -		set_dcache_dirty(page, this_cpu);
>> +		set_dcache_dirty(folio, this_cpu);
>>   	} else {
>>   		/* We could delay the flush for the !page_mapping
>>   		 * case too.  But that case is for exec env/arg
>>   		 * pages and those are %99 certainly going to get
>>   		 * faulted into the tlb (and thus flushed) anyways.
>>   		 */
>> -		flush_dcache_page_impl(page);
>> +		flush_dcache_folio_impl(folio);
>>   	}
>>   
>>   out:
>>   	put_cpu();
>>   }
>> -EXPORT_SYMBOL(flush_dcache_page);
>> +EXPORT_SYMBOL(flush_dcache_folio);
>>   
>>   void __kprobes flush_icache_range(unsigned long start, unsigned long end)
>>   {
>> @@ -2280,10 +2294,10 @@ void __init paging_init(void)
>>   	setup_page_offset();
>>   
>>   	/* These build time checkes make sure that the dcache_dirty_cpu()
>> -	 * page->flags usage will work.
>> +	 * folio->flags usage will work.
>>   	 *
>>   	 * When a page gets marked as dcache-dirty, we store the
>> -	 * cpu number starting at bit 32 in the page->flags.  Also,
>> +	 * cpu number starting at bit 32 in the folio->flags.  Also,
>>   	 * functions like clear_dcache_dirty_cpu use the cpu mask
>>   	 * in 13-bit signed-immediate instruction fields.
>>   	 */
>> diff --git a/arch/sparc/mm/tlb.c b/arch/sparc/mm/tlb.c
>> index 9a725547578e..3fa6a070912d 100644
>> --- a/arch/sparc/mm/tlb.c
>> +++ b/arch/sparc/mm/tlb.c
>> @@ -118,6 +118,7 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
>>   		unsigned long paddr, pfn = pte_pfn(orig);
>>   		struct address_space *mapping;
>>   		struct page *page;
>> +		struct folio *folio;
>>   
>>   		if (!pfn_valid(pfn))
>>   			goto no_cache_flush;
>> @@ -127,13 +128,13 @@ void tlb_batch_add(struct mm_struct *mm, unsigned long vaddr,
>>   			goto no_cache_flush;
>>   
>>   		/* A real file page? */
>> -		mapping = page_mapping_file(page);
>> +		mapping = folio_flush_mapping(folio);
>>   		if (!mapping)
>>   			goto no_cache_flush;
>>   
>>   		paddr = (unsigned long) page_address(page);
>>   		if ((paddr ^ vaddr) & (1 << 13))
>> -			flush_dcache_page_all(mm, page);
>> +			flush_dcache_folio_all(mm, folio);
>>   	}
>>   
>>   no_cache_flush:
> 
> This change broke the kernel on sun4u SPARC systems. This has been observed on a Sun Netra 240.
> 
> During boot, the kernel crashes with:
> 
> [   25.855163] Unable to handle kernel NULL pointer dereference
> [   25.929588] tsk->{mm,active_mm}->context = 0000000000000001
> [   26.002772] tsk->{mm,active_mm}->pgd = fff00000001bc000
> [   26.071405]               \|/ ____ \|/
> [   26.071405]               "@'/ .. \`@"
> [   26.071405]               /_| \__/ |_\
> [   26.071405]                  \__U_/
> [   26.264705] modprobe(33): Oops [#1]
> [   26.310445] CPU: 0 PID: 33 Comm: modprobe Not tainted 6.5.0-rc4+ #16
> [   26.393937] TSTATE: 0000004411001601 TPC: 0000000000452a28 TNPC: 0000000000452a2c Y: 00000008    Not tainted
> [   26.523184] TPC: <tlb_batch_add+0x108/0x1a0>
> [   26.579221] g0: ace36c1f2cee4067 g1: 0000000000000028 g2: 00000000000a010c g3: 000c000000000000
> [   26.693607] g4: fff0000001947000 g5: 0000000000000000 g6: fff0000001948000 g7: fff000023fe33f00
> [   26.807978] o0: fff000000738fff8 o1: 000007feffffe000 o2: fff000000194b788 o3: 0000000000e3c038
> [   26.922356] o4: ffffffffffffffff o5: 0000000000e3c038 sp: fff000000194aee1 ret_pc: 000000000065d194
> [   27.041302] RPC: <__pte_offset_map_lock+0x14/0x60>
> [   27.104203] l0: fff000000194b860 l1: 0000000000000001 l2: 0000000000000000 l3: fff000000194b850
> [   27.218583] l4: 0000000000002000 l5: 00000000001010f8 l6: 0000000000000002 l7: 0000000000000040
> [   27.332959] i0: fff000000194e400 i1: 000007feffffe000 i2: 000c000004857588 i3: 80000002026d3fb2
> [   27.447334] i4: 0000000000000000 i5: 000000000000000d i6: fff000000194af91 i7: 0000000000659110
> [   27.561709] I7: <change_protection+0x910/0xe00>
> [   27.621178] Call Trace:
> [   27.653202] [<0000000000659110>] change_protection+0x910/0xe00
> [   27.729838] [<00000000006596f4>] mprotect_fixup+0xf4/0x2c0
> [   27.801892] [<00000000006c754c>] setup_arg_pages+0x12c/0x2c0
> [   27.876237] [<0000000000737d80>] load_elf_binary+0x360/0x1380
> [   27.951722] [<00000000006c8564>] bprm_execve+0x1e4/0x560
> [   28.021493] [<00000000006c8e8c>] kernel_execve+0x14c/0x200
> [   28.093548] [<000000000047f6e8>] call_usermodehelper_exec_async+0xa8/0x140
> [   28.183906] [<0000000000405fc8>] ret_from_fork+0x1c/0x2c
> [   28.253672] [<0000000000000000>] 0x0
> [   28.300568] Disabling lock debugging due to kernel taint
> [   28.370336] Caller[0000000000659110]: change_protection+0x910/0xe00
> [   28.452686] Caller[00000000006596f4]: mprotect_fixup+0xf4/0x2c0
> [   28.530461] Caller[00000000006c754c]: setup_arg_pages+0x12c/0x2c0
> [   28.610524] Caller[0000000000737d80]: load_elf_binary+0x360/0x1380
> [   28.691730] Caller[00000000006c8564]: bprm_execve+0x1e4/0x560
> [   28.767218] Caller[00000000006c8e8c]: kernel_execve+0x14c/0x200
> [   28.844993] Caller[000000000047f6e8]: call_usermodehelper_exec_async+0xa8/0x140
> [   28.941071] Caller[0000000000405fc8]: ret_from_fork+0x1c/0x2c
> [   29.016554] Caller[0000000000000000]: 0x0
> [   29.069167] Instruction DUMP:
> [   29.069169]  80886001
> [   29.108052]  126fffc8
> [   29.138932]  01000000
> [   29.169815] <c2582000>
> [   29.200697]  83307013
> [   29.231578]  80886001
> [   29.262458]  02680007
> [   29.293338]  01000000
> [   29.324223]  c2582000
> [   29.355102]
> 
> This crash is not observed on sun4v systems.
> 
> Any idea what could be the fix?

There was a follow-on fix that addressed a bug with this patch:

f4b4f3ec1a31 sparc64: add missing initialization of folio in tlb_batch_add()

Anthony

> 
> Adrian
> 


