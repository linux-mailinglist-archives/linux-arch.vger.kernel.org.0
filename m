Return-Path: <linux-arch+bounces-8270-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D11909A4344
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:08:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4C5286711
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD19200CB8;
	Fri, 18 Oct 2024 16:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hqNHMX/e";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="npgRGePt"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B448E4207A;
	Fri, 18 Oct 2024 16:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729267695; cv=fail; b=BtSTIMLaiC6y2W7u6oavkmy4gshqQUTjEmCf9LUUDgSwqUJq7YU+AGc/rD9Jw5WwJRunT9ccdOJVeWGvnmEw9dkeJNfKjYs75Sw/qPp9GSASgUK3URg+7BcB9hnelt3JrmRTbELCDN4bEaMCe6oZcercQToX8lXxnz3DuTCTij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729267695; c=relaxed/simple;
	bh=xOdsj49tnW5r96rkFgqy6fAJBTDMnGO1x5zjqT7PyCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=vA9/tZq0fVh3EexSOi5kd9dwmKTnxFy1FxZv7QxYxTGoBgBMxY4Yt73peDDyFqGUhLoeC34AHON9vycXcf5Ed/hNGAINYO/c76YWo/fOkIZXCEgIXilkX5qiAcTvifXk7X4qcoFQZS+v4rPy/zGjx7Vu379k5LGxyiysn4JI8Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hqNHMX/e; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=npgRGePt; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBe7N005751;
	Fri, 18 Oct 2024 16:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=AKfP1QkHHmFqoghsvk6cgU/uCMrAs9e1OyQutoadcmY=; b=
	hqNHMX/eGYtAnW1qjCye8/tbX9x0f/IKXoG6ufSXPRfXqNkgEeL47yB9m01r0TQ2
	HDAui7j2rMN4UjcpxXdfk2uM0n8bcc6FXo85a5ZC/tyXPlV5dWUIJZKu+E3X/GIZ
	UMhvL3T61yd2iHt/ryFjnORWrBhzEbEd/Nefv/1rLzSkRlvYCqvnx/tDPELJaJsq
	bPrLY7wnf+p9/Y/Ki2M7JFspvoIrXeNTJ228RUq8T8vD+oooqhOJxHn5yYX1kfJE
	Q1AbsAI7UNk/onOYEbL1AC6TPODkMo/rBJFa2JE5/Uhh5TDR8jY/ZAgzyYmmMESX
	yCCW6eEFRNMLoSXQnzyfYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427gq7s70m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:07:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEkPnn013985;
	Fri, 18 Oct 2024 16:07:27 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjbrjhp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:07:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EilinLGLV32GbUuMH2pPzzRnkICyPLKnHxksCE/QgWUtR8XyBmy5AsDOZkKVsam6UI7BpL1UBl4d8xAOakZuL50XzXvZxp5XQyQHv0qbPEaDxNYa2YkWn0LlHOrOEwNW7NGqDvkMy99dbfBeDBdDnOehhaTyy/Gkw9LiNQk5TUCvqkUatdqtqbrZPCyrqQWnMXhqpkrOxKj0Re5NK0HMr4JBy+2JFKrfuWy+lTXvj8mHYbc59h9o/iTqFiBvU7PQC1PWOSCg+sxn6d7e3lk1keqMXgV/34LHF0jAfhJItS5vNUNlk8UuQTbeVr7SW/Y3E7Bpf50uCANteKYKex3VCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKfP1QkHHmFqoghsvk6cgU/uCMrAs9e1OyQutoadcmY=;
 b=UuLDyev/TgFPDh/wN1yB0Y7uDdDh5m1FnRRsjPNb+EuRSNFAzGh75sodJ8jSVNYsslQh7oolMxmpHlfXiCOas8/4mkfjw11ropPwe8Tk0XvyS89WrC/jUsByN4TWzh9sloHfNDGxyu08rEh0mCXwCCzo6vCwv7/Pph+ETKt6n7yUmhxUrrKwUxAm0ce7HYPSuuzBPowFbpPq6f3wL40R7SQS+aismjcZl5GlnMZJki98MphgerK9gjMR6DhgRfAuHFvE8iOdpvOoqr+M3G411BBUDYKtuqLzzxp4weIR3NqPVR1UGAIq0tM6JVK8QQ/Je/mbC7YiDLCtDRjN9f2M2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKfP1QkHHmFqoghsvk6cgU/uCMrAs9e1OyQutoadcmY=;
 b=npgRGePtjXhGCTTYmOQm4XLsZT8sg5TnveTRsaPoAVsBJ5ANvrDrV4MdJx32HS+p3Ff73Rb2cc7yk6CKaVm07BepwC3TZwslAEepGVCSbWwzVliaHq3e9cGChlZLhaEorpx7BZv+mAYQKDPg+EnITYd6BxEFoKUBt4AaJlRQfIU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BN0PR10MB5015.namprd10.prod.outlook.com (2603:10b6:408:126::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.24; Fri, 18 Oct
 2024 16:07:23 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:07:23 +0000
Date: Fri, 18 Oct 2024 17:07:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
Message-ID: <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
 <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
 <dfbf9ccb-6834-4181-a382-35c9c9af8064@lucifer.local>
 <22d386cd-e62f-43f9-905e-2d0881781abe@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <22d386cd-e62f-43f9-905e-2d0881781abe@linuxfoundation.org>
X-ClientProxiedBy: LO2P123CA0039.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600::27)
 To SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BN0PR10MB5015:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6204d2-b997-4916-f5f2-08dcef8ef39d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1xNldLOW1MbmprK3BpNXZqMG9VUEthSDMzMU4zcE8vb1hHOFYyK1FEbUNY?=
 =?utf-8?B?d1pVUjFZMFZkNGM2eXUyUjZ4QmdVVTR5dEZwTEZZaERBZ1ZkSHZ5SlFHdGpF?=
 =?utf-8?B?NzlpWEZUL01TQ05VaWRYaEs2QXZSZzRIRVFBZEduaU91NEFVdkI1WkpjMHJp?=
 =?utf-8?B?YXhVOEtWODdRZVpMZllpeW9WV3RoR0RKaExMMWJ6eW5xeUlPMDMzMjlxWFpr?=
 =?utf-8?B?ZUtPU1JzRDdIRFVORzY0VWtndzc4TCtRd2hEZCtzTEZHVVFzMkVHSEJlcmM5?=
 =?utf-8?B?UHlUZnk4OXprVVBjbDZRck1wNjlINUUzR2poR1lEUUZOeHh1M21KSkk2Y0Nz?=
 =?utf-8?B?STVJVW9HQXVhWXpHT1RKOTE1Uk9UTHVBRzhyc3pISVNhWERGbUg4WGRsN1N2?=
 =?utf-8?B?NnBzNEpCZExXUXdlbGNrQVhPb0N5bDhabUNVbGxVRHFUR0d0WUZjeUhYZjZj?=
 =?utf-8?B?dm1PMGpNWk9ucTR3WVp3cVdiTjFHSWl6OUs2OGh2RGRpVTVUb3Q2b3U0M1hL?=
 =?utf-8?B?NWFqamxyUElzT20vZ3paOXRoeE1BWmpoVS8wdlIwaUZGcW95S2RwZHhSYkN3?=
 =?utf-8?B?SkFpR0NFU0E1TkJyMFBqYTlSeUhWK2hDNGg0akpEVnkxQXpXZjNqTlRKVkxu?=
 =?utf-8?B?ZEVyVDBLMXlIM1BBM3VVTWYzeENRbkxiVkNBZkNGMDVoT09qU3hQNmFlZ2lt?=
 =?utf-8?B?RUMwOHlWQ2haT2dxKzZPNUFlOGY3Zlo1TFhoemxwQ2NUaUxyUERKN3Ywd3Rj?=
 =?utf-8?B?WklBTUlNU1RPZ3IvU2Z5akttdUJPcVQ0NmFYWHcxWkNJSkZvbEw5b1V1bmVw?=
 =?utf-8?B?U3JnbUtvSFdIWXdqVUptK3h2YUh4MVpCQTNpWmlXUUpaZWFoOXhtc0dweHR2?=
 =?utf-8?B?TkZJWFhsUXJ3c2s1N0gvMzl5ZnJOVzdGRWtnb2lYa0tFU2xIT3I5SWg5bXVz?=
 =?utf-8?B?WW9tcVZ6bkM0V1NOeTA4MVhEUTFzbTdEWDUrQXhkdDViVm5ueDlOdTRFR0RT?=
 =?utf-8?B?VTBRUUw0cmlFNmw5SXBUQW80dlN6dS8yMG1lUENrOUNXZko3QTI0cC9PZDJI?=
 =?utf-8?B?L25WNEZHTlpEL2tvbVByRFlTNVdHSnBMUUE4WUc4TXJUSldvajNJcSsvQ2Ju?=
 =?utf-8?B?cXcxK2w3QXRTN09oTjJXV2NtZEc2bGxtVGR5K29SMHpHdmgzTHpMS3dPbVh2?=
 =?utf-8?B?OTJDc1llQ01HZjQzbU0zMllsRE9nSkVQSVhITGNqdTJ5cEVlQVM1bnMvb0lU?=
 =?utf-8?B?SHowcHVOWThISVRwUXVEZjk3VURjMS9JYmU2cXd3L3ZRQnFKRUtJUEJsVmRy?=
 =?utf-8?B?d3BaaExmbXp1MWprNHkzeFJ4Y1BRMlc0N0JPZXNXSk1DSC9YMGNkRUVxeFZB?=
 =?utf-8?B?UFZ0bkcrTmUxQ2FJNTEyMmYyS2ZhMFgzMmFiaEdRaUh0em9aVE1zQlBRRjhE?=
 =?utf-8?B?K1FEcTNhNXFTaCs1MjNsRmg0N0FWVFNpRmMyMFMrM041VEFQWkR0ODkvdFBz?=
 =?utf-8?B?dUN3RE1ZSE9Ka2hXTHpzTTV6QWlKZTFCQ0tEVXRzWGozNjM0TkIyQ2gwb2k2?=
 =?utf-8?B?VmJXQTlML3JmQ2RaQnJyVDBsNWVGbVllTHluWDByRGpKbGlxV0l2YVJZV2tl?=
 =?utf-8?B?WmRHOXZXWkYxQ2dlajhZeVRPejAxK1lKeE5qVXlaejg3NElNcngxNW1Hbk1Z?=
 =?utf-8?B?a0cwbnJGWFNZYWZZaWYxMFZBb21qbXdiZlFPdkFieTAyUjBmK1Nqd1VsU0tk?=
 =?utf-8?Q?AZ9ylXWj8TUe9f6D1TWOZxVR6AC2Cc2rTILnZUf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFZyYlo5V3JGNnRicDd2NHNlL1E4WUxKU2QvTXZqZEd1cDRPSWkwNThpNTdF?=
 =?utf-8?B?bnAwRGJ3ck05UU5HWm12VTZYMFVkdTl4eHJRWmJUSzBaZmpGQXdRVWc0U3Jl?=
 =?utf-8?B?RGVMSlFUSWlxd0ZaSG1zQjJ2bUZFY1hxZklNeGk5ZW5TS2lsY1VDemJjSHNR?=
 =?utf-8?B?QmR6TU9LMXdKSnZQNnBYQ3FoeUNVVmNUMFVBYzV1cTd5MWRDYmFIcDQyZ0ZD?=
 =?utf-8?B?SnJJaDI1QzZGRVRSVUptWWJlakdJWWY1bjZQZ1FDZzhRSVVvNThXN0RYcEhv?=
 =?utf-8?B?aE8xRzBBN0RjRHp5ajdxbVZMRjJ1K2ZUa3lPM2s3SGRhY1RGOUpENUxLNkhE?=
 =?utf-8?B?aE5xUnRZMFlaUUtvcGRQUE4ybURWUHNiemZDalN0TjFvQlZOT2JpTlgwSEV6?=
 =?utf-8?B?d2lDLzAxSTd0bWpCMTdJQ05TWXczZ0drRXIwZi9iQ3FmVDh2UCtkVEZLMVoy?=
 =?utf-8?B?TFhPWFY5SEx6STNtbU1YTXJWSFRqVytzRUdwSXVlOUhTc3VrN1dwRlNPVW52?=
 =?utf-8?B?RmZvMWZsZFlIQ3pVbEl2Vk5wNFVuNFpJRFRGaUw5YTd2bDFrb2JDamRFN0dL?=
 =?utf-8?B?OFNxT09hVnNnbEZabkxEQ2M0SEphSVlXLzVBTUsrQnJUSU9CTHZsUnhjOVJP?=
 =?utf-8?B?ODh0aUFuZ0orem5sb3lZM0ZTTUdFTEhFQmE0bXoybWREUFdmdm4rSVhMQmZF?=
 =?utf-8?B?MlB3bUhFT3UycEtSUDdTZXhLL0FwOXV2ZmVIM0hzdXJ1VHk2OUc2T3JkT0pZ?=
 =?utf-8?B?Q0d6bUN6VTl3Q1VwQmVHOEExRTA1bFhnRjRlTVY5ZGRuSEdvb2NtN1gwdG80?=
 =?utf-8?B?ZG8yTGRKUEhXdklCOUJDS3VRNC9xQmM1aGg3VFIrNGRnNlp1NTAxMWJoaDc0?=
 =?utf-8?B?N0hnbzdSNmlFN2FXNkM2Snd2SlFpQ0NzMTBvQ0xJMGNnODNVUHloSFJHTFlh?=
 =?utf-8?B?QlFVbW1zUmtrZXBYcVVybmRRcnIyOW91QXZQSzBDNFhrWUllb3g2dUJESnAr?=
 =?utf-8?B?dWpRaEpIME9sWk9aeHI4S0daNEljRlJvUGFIZmVsUmNqM0I0amxWM2JZQldP?=
 =?utf-8?B?eXpqMFVNSHJXTmxaaU9DSmhQZnpLN1d0VlFUMzV1SitqT0dJRVN6YS9pMnY4?=
 =?utf-8?B?ZGZwWFBTZVNBa2VhYWFGcEhReTZuRmtoYVlGNm1IdGxCOFV5VzY4d3lNREpr?=
 =?utf-8?B?WEZoT0s5RmZnVGZVckdmdjVjb0l5aTdaNTBTUlluV0l3SmFjMWhaMk1xUUNy?=
 =?utf-8?B?NGJkbG9jR0M0a1F0YlBiaTNBQkF2TU5qUmlMTFRQTmNEU28rTHVjUHZJTVNG?=
 =?utf-8?B?cjZObTNBTlpLdno4RHFjWk8rbDI0aGNrend4N081dVVsbGduNytLY1dLVUty?=
 =?utf-8?B?QkQ5dGxpTUE0WDd1a2FmS2tYWUlScDdtS1YxWWFqamFCUys4VzVzUGlvQU9t?=
 =?utf-8?B?TUFmMHlLbi9ISmpXUitwSC90azBBM2JYMjgzYWRWcmozbG15ZVpDVmNBbXlm?=
 =?utf-8?B?RGRLMUFaTlRYOVVpZ25RN2J3bEcrTXQzNVJlZTg0MHQ0SUhtRktDNU1KMWxI?=
 =?utf-8?B?UWJhY3J5WWZ5TnZSVkUzV2laTkJheGFLZ1R5NlpSdzVqWW93bmsyREJMQW9K?=
 =?utf-8?B?OUpMdU9NYnYvcmFiMEdDaTZVZHk3TG9UUEM4R1dkUnVUcTNJNHk2b1lBQnMz?=
 =?utf-8?B?RDZwaUY0d3RKSERpZStxOGNIRDJ6S3ladm5MbndYNzFVWUdTWGcxZmJzdWY0?=
 =?utf-8?B?YWFkWVZnZjZjeDd3cmdrbFBPck8xYnhlZzNWdldyUWY2SnJKenBoTVNBRE9U?=
 =?utf-8?B?TE9zMjJhQlJzeDJIelhWVysycndEYjROeUZBRkxlaWRNZnB2TXY1TTR1OStn?=
 =?utf-8?B?SnN6cnRnL2ZxbHNjR29iSGF4OXRhQjdDZWlYR2R2NFVQNUk0WU10c09pa0dt?=
 =?utf-8?B?TmxubExnZ2tMS3g5MDVNblVtQWw5QVBFQVphYTRkZ0lHZ3RMNVdmNUZabXVU?=
 =?utf-8?B?U3QvZllyU0p6QTFzTHpSTzFFQ3lRU3p2eDRoUWFnZlBtUXJzVG9ZcnpyRmM0?=
 =?utf-8?B?cEpmMW9QN0ErV1QwUjZKOUpjSUlZY09VOFlQaFBZTUYrditmZy9Vc2M1Mzkw?=
 =?utf-8?B?RXhobVl6Mi9haDBwTVF2NGs5MS9JbVhQa1V0aHlMUWhSMURmbWJUR09wQkxo?=
 =?utf-8?B?VFlYemNUSTVZN1Nvam5qYTRDbzhKMHdHd1pNS2V5cGVkaEMwTm9yVTkrMzFk?=
 =?utf-8?B?bTF3aDBpMndWNlVFQitDeEgrSlp3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	AcGVj4MZoAiAMK0c+pHbVOmeFaApIOnGElDwieRGfN3FpyspdZ0IFfD38hSeudQfXtHps41a7dsu+TVSFlXGUjVdJSXrkbSbuS7ZkRzQuZrHh/Gfg6c7fHeTBiesTtxA5pTt+N0ikXM1s8ypxLdud8uO/gm/XmzCxx9e6nUG2bt+evYdFx2nyR4XvlSuSIPr5zSseQ5r+rUBg+MgWKbtEU82FFMObvKNEoY+50oExTQ7rwyXm2MdbHIoWFzTbc9SehCCU9305Xk3M4sMaCk+APi+6R00aKwH5rkJmhBrYlC2JoeBOyU0/HfeLLNV43RpmvywzSM3/iUeKi2dAsNLHXqk+Q7J0Uy3iOhML7+XnwIcnE9jfKTbN9WyMcDMuf+uLOCzjo0Q0NVHmE8UyVwEyfsVCgIj2eiHCiokiyAQoQdye1jBNsFo94bxxXirJWqX3U9PDCzm8uVdHgtEZQWOgAXyd2IGU2f6QZjUZqZPTCUSs/fFyhttj+M6NzfjjlgcjxpDQFuQjhD6jmo7ViXIhllrUCAaLj6aAS29JiQ7viYYRt1OgvvTfne75Bh0LX7SdgnVQJReY7w3ldjHCfEAt2Q5w8AlR5Dt15xhpfxuDj4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6204d2-b997-4916-f5f2-08dcef8ef39d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:07:23.3853
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1jtPHRvm/Jhy7072BSuLnesX0TLgQo3qwebvf7qo8AgEaoz78NufuAtVmxJCRw8aT+4fjpLZt/lmWjwO26sSVOKUrr5CewhW8qRCeC7tG5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5015
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410180103
X-Proofpoint-ORIG-GUID: edHW5Wqmq40zSq42uwHrYtc8wUSeknSB
X-Proofpoint-GUID: edHW5Wqmq40zSq42uwHrYtc8wUSeknSB

On Fri, Oct 18, 2024 at 09:32:17AM -0600, Shuah Khan wrote:
> On 10/18/24 01:12, Lorenzo Stoakes wrote:
> > On Thu, Oct 17, 2024 at 03:24:49PM -0600, Shuah Khan wrote:
> > > On 10/17/24 14:42, Lorenzo Stoakes wrote:
> > > > Utilise the kselftest harmness to implement tests for the guard page
> > >
> > > Splleing NIT - harmness -> harness
> > >
> > > > implementation.
> > > >
> > > > We start by implement basic tests asserting that guard pages can be
> > >
> > > implmenting? By the way checkpatch will catch spelling stuuf.
> > > Please see comments about warnings below.
> >
> > Thanks. The majority of the checkpatch warnings are invalid so I missed
> > this. Will fix on respin.
> >
> > >
> > > > established (poisoned), cleared (remedied) and that touching poisoned pages
> > > > result in SIGSEGV. We also assert that, in remedying a range, non-poison
> > > > pages remain intact.
> > > >
> > > > We then examine different operations on regions containing poison markers
> > > > behave to ensure correct behaviour:
> > > >
> > > > * Operations over multiple VMAs operate as expected.
> > > > * Invoking MADV_GUARD_POISION / MADV_GUARD_REMEDY via process_madvise() in
> > > >     batches works correctly.
> > > > * Ensuring that munmap() correctly tears down poison markers.
> > > > * Using mprotect() to adjust protection bits does not in any way override
> > > >     or cause issues with poison markers.
> > > > * Ensuring that splitting and merging VMAs around poison markers causes no
> > > >     issue - i.e. that a marker which 'belongs' to one VMA can function just
> > > >     as well 'belonging' to another.
> > > > * Ensuring that madvise(..., MADV_DONTNEED) does not remove poison markers.
> > > > * Ensuring that mlock()'ing a range containing poison markers does not
> > > >     cause issues.
> > > > * Ensuring that mremap() can move a poisoned range and retain poison
> > > >     markers.
> > > > * Ensuring that mremap() can expand a poisoned range and retain poison
> > > >     markers (perhaps moving the range).
> > > > * Ensuring that mremap() can shrink a poisoned range and retain poison
> > > >     markers.
> > > > * Ensuring that forking a process correctly retains poison markers.
> > > > * Ensuring that forking a VMA with VM_WIPEONFORK set behaves sanely.
> > > > * Ensuring that lazyfree simply clears poison markers.
> > > > * Ensuring that userfaultfd can co-exist with guard pages.
> > > > * Ensuring that madvise(..., MADV_POPULATE_READ) and
> > > >     madvise(..., MADV_POPULATE_WRITE) error out when encountering
> > > >     poison markers.
> > > > * Ensuring that madvise(..., MADV_COLD) and madvise(..., MADV_PAGEOUT) do
> > > >     not remove poison markers.
> > >
> > > Good summary of test. Does the test require root access?
> > > If so does it check and skip appropriately?
> >
> > Thanks and some do, in those cases we skip.
> >
> > >
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    tools/testing/selftests/mm/.gitignore    |    1 +
> > > >    tools/testing/selftests/mm/Makefile      |    1 +
> > > >    tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
> > > >    3 files changed, 1170 insertions(+)
> > > >    create mode 100644 tools/testing/selftests/mm/guard-pages.c
> > > >
> > > > diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> > > > index 689bbd520296..8f01f4da1c0d 100644
> > > > --- a/tools/testing/selftests/mm/.gitignore
> > > > +++ b/tools/testing/selftests/mm/.gitignore
> > > > @@ -54,3 +54,4 @@ droppable
> > > >    hugetlb_dio
> > > >    pkey_sighandler_tests_32
> > > >    pkey_sighandler_tests_64
> > > > +guard-pages
> > > > diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> > > > index 02e1204971b0..15c734d6cfec 100644
> > > > --- a/tools/testing/selftests/mm/Makefile
> > > > +++ b/tools/testing/selftests/mm/Makefile
> > > > @@ -79,6 +79,7 @@ TEST_GEN_FILES += hugetlb_fault_after_madv
> > > >    TEST_GEN_FILES += hugetlb_madv_vs_map
> > > >    TEST_GEN_FILES += hugetlb_dio
> > > >    TEST_GEN_FILES += droppable
> > > > +TEST_GEN_FILES += guard-pages
> > > >    ifneq ($(ARCH),arm64)
> > > >    TEST_GEN_FILES += soft-dirty
> > > > diff --git a/tools/testing/selftests/mm/guard-pages.c b/tools/testing/selftests/mm/guard-pages.c
> > > > new file mode 100644
> > > > index 000000000000..2ab0ff3ba5a0
> > > > --- /dev/null
> > > > +++ b/tools/testing/selftests/mm/guard-pages.c
> > > > @@ -0,0 +1,1168 @@
> > > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > > +
> > > > +#define _GNU_SOURCE
> > > > +#include "../kselftest_harness.h"
> > > > +#include <assert.h>
> > > > +#include <fcntl.h>
> > > > +#include <setjmp.h>
> > > > +#include <errno.h>
> > > > +#include <linux/userfaultfd.h>
> > > > +#include <signal.h>
> > > > +#include <stdbool.h>
> > > > +#include <stdio.h>
> > > > +#include <stdlib.h>
> > > > +#include <string.h>
> > > > +#include <sys/ioctl.h>
> > > > +#include <sys/mman.h>
> > > > +#include <sys/syscall.h>
> > > > +#include <sys/uio.h>
> > > > +#include <unistd.h>
> > > > +
> > > > +/* These may not yet be available in the uAPI so define if not. */
> > > > +
> > > > +#ifndef MADV_GUARD_POISON
> > > > +#define MADV_GUARD_POISON	102
> > > > +#endif
> > > > +
> > > > +#ifndef MADV_GUARD_UNPOISON
> > > > +#define MADV_GUARD_UNPOISON	103
> > > > +#endif
> > > > +
> > > > +volatile bool signal_jump_set;
> > >
> > > Can you add a comment about why volatile is needed.
> >
> > I'm not sure it's really necessary, it's completely standard to do this
> > with signal handling and is one of the exceptions to the 'volatile
> > considered harmful' rule.
> >
> > > By the way did you happen to run checkpatck on this. There are
> > > several instances where single statement blocks with braces {}
> > >
> > > I noticed a few and ran checkpatch on your patch. There are
> > > 45 warnings regarding codeing style.
> > >
> > > Please run checkpatch and clean them up so we can avoid followup
> > > checkpatch cleanup patches.
> >
> > No sorry I won't, checkpatch isn't infallible and series trying to 'clean
> > up' things that aren't issues will be a waste of everybody's time.
> >
>
> Sorry - this violates the coding styles and makes it hard to read.
>
> See process/coding-style.rst:
>
> Do not unnecessarily use braces where a single statement will do.
>
> .. code-block:: c
>
>         if (condition)
>                 action();
>
> and
>
> .. code-block:: c
>
>         if (condition)
>                 do_this();
>         else
>                 do_that();
>
> This does not apply if only one branch of a conditional statement is a single
> statement; in the latter case use braces in both branches:
>
> .. code-block:: c
>
>         if (condition) {
>                 do_this();
>                 do_that();
>         } else {
>                 otherwise();
>         }
>
> Also, use braces when a loop contains more than a single simple statement:
>
> .. code-block:: c
>
>         while (condition) {
>                 if (test)
>                         do_something();
>         }
>
> thanks,
> -- Shuah

Shuah, quoting coding standards to an experienced kernel developer
(maintainer now) is maybe not the best way to engage here + it may have
been more productive for you to first engage on why it is I'm deviating
here.

Firstly, as I said, the code _does not compile_ if I do not use braces in
many cases. This is probably an issue with the macros, but it is out of
scope for this series for me to fix that.

'Fixing' these cases results in:

  CC       guard-pages
guard-pages.c: In function ‘guard_pages_split_merge’:
guard-pages.c:566:17: error: ‘else’ without a previous ‘if’
  566 |                 else
      |                 ^~~~
guard-pages.c: In function ‘guard_pages_dontneed’:
guard-pages.c:666:17: error: ‘else’ without a previous ‘if’
  666 |                 else
      |                 ^~~~
guard-pages.c: In function ‘guard_pages_fork’:
guard-pages.c:957:17: error: ‘else’ without a previous ‘if’
  957 |                 else
      |                 ^~~~
guard-pages.c: In function ‘guard_pages_fork_wipeonfork’:
guard-pages.c:1010:17: error: ‘else’ without a previous ‘if’
 1010 |                 else
      |                 ^~~~

In other cases I am simply not a fan of single line loops where there is a
lot of compound stuff going on:

	for (i = 0; i < 10; i++) {
		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));
	}

vs.

	for (i = 0; i < 10; i++)
		ASSERT_FALSE(try_read_write_buf(&ptr1[i * page_size]));

When there are very many loops like this. This is kind of a test-specific
thing, you'd maybe put more effort into splitting this up + have less
repetition in non-test code.

I'm not going to die on the hill of single-line-for-loops though, so if you
insist I'll change those.

However I simply _cannot_ change the if/else blocks that cause compilation
errors.

This is what I mean about checkpatch being fallible. It's also fallible in
other cases, like variable declarations via macro (understandably).

Expecting checkpatch to give zero warnings is simply unattainable,
unfortunately.

As you seem adamant about strict adherence to checkpatch, and I always try
to be accommodating where I can be, I suggest I fix everything _except
where it breaks the compilation_ does that work for you?

Thanks.

