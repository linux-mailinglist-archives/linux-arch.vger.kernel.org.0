Return-Path: <linux-arch+bounces-7647-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 639C998E7BC
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 02:25:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DA2D1C21448
	for <lists+linux-arch@lfdr.de>; Thu,  3 Oct 2024 00:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A7A8BFF;
	Thu,  3 Oct 2024 00:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W2jt7HQH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xK9KLh9M"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F598BF0;
	Thu,  3 Oct 2024 00:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727915130; cv=fail; b=s70WjG8gVKBupz4UIEW0Q+L/bJedelSZ4dzV5T88OWsjtFAuH27I/ngmahFTf4UtYqLdA8lLCTT+Y5ypp4MrlrJHy5D/AJHa7L0IzK4qGO1RLzyl4aJ2lnTqyOahvWwSK7YAZtSjIn5So+3K04rNnUipwrjuJ0hHOWghQ85Q21I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727915130; c=relaxed/simple;
	bh=DnrIvjSeLT+EGoKF4rTNw68ZIPDefQ6ne4tLkPDqbdg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oeIb+JhfzIrJ0LY1eoHztNMoKzUGKUhd5BMkQIPWcI99CthmIZhqSfT7OeY2yigTm9Cg7+kgcgJwsSJQzPc0aemu08+CHu03Ax5rnY+S9Ah0ycpU4ZuGEqKeCmBYEmjpo7345VrAs9E91eCvs5CweEOqv8VP4kp8DyN5YiyBu9g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W2jt7HQH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xK9KLh9M; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492MffYF003047;
	Thu, 3 Oct 2024 00:24:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=bjvFcMmWLQf63v/flqbLuL9e4Y4aAaIZKGCruYXK86M=; b=
	W2jt7HQHYQmFD969KMzBolgG0n8BeyZbAckyZ1vurX4JEjWGoE9lmvm5ULnj8dwH
	M5sI4ymXdqvYyQy62yHDNqYx2et/Y3Ax+a1G3gkcho+ERf4N6DJhEB42nqjNLIl5
	AOZN9YsD9rcdjPc0T29XDbclq84vXvyQX+0hpBZrUgLwnF/sLNyC/ZHIid1SWQm4
	lXJUY6qkVr/1Od+chcw/1PIVs4IsB02TjOZ1riGBExF8RQxkWKD9nhSPryZlzNn7
	80uzagRtn1mpQFXtcXccvaJ1bxvLCR7AugE4yfa1DeUG4UlaQzJjyZ8Jjlu+dPpa
	AhGCdUSxJPYq+7jsPY2SHg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8d1juvt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 00:24:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49300Y8S040624;
	Thu, 3 Oct 2024 00:24:48 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889h290-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 00:24:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YaiL1qA0sZ3z6yCqEnghGXpeTAWUImcUKRBwis3eXmMiIXQbsPu1rkNvM9PnObO5P39OAhpmCu6q0ZpjkjtJ7k21mlI2sha6ssZbnLwKlx3h4ig4rPrYVe4UPVKEG65v3ChmdRvUQ+lltwX3sCpWWNYp1DdmBLNMi6tDbvtajjf5rsL8/yjPHug16H3Tt5KLu5RG/HPOJwvRaij+lbndb4VJuJ3WxUsO4WuYGVlpDkzRzg0m5BD1472J2sV5RTTTCMVC6LEVOKbqfsX9lfLBXmtTD78UTEROD+em1gw7AF7844A8aF0fy9wHKBWlvAZdQm69nmdIrhDnMXIKTk3MJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bjvFcMmWLQf63v/flqbLuL9e4Y4aAaIZKGCruYXK86M=;
 b=kd+5ApGbZ1Wy7CDM0SYdsRBMuR1JgPM77mTVs0juTp9DoLCnXEKMrNsdHu+XEXhae8GB21Hou6Q163OHg0ZyalSkYctJPJoy6VXX6FZjKu3zbxQurvzcaEws8DtI1OXigBURUsKbBsYp1yVlUDWrCxJip+vb9yDbO9FV+K8prPCY/Ltkbf6v2mtA/vpYjv8Pb9n3RzvuQ01ipQnHlnTlPWY/v6F2l5Vae4PNWc9i5ihY3D+EBTK+GNWaojEeltjHG1egSK1EZybT5OhN69A01ezOgoZDUcs6BaJlxEU8OY1ul40cNsbxeFzd8T5PxYu2gOSUU2Y3kNDDFl46pnfaKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bjvFcMmWLQf63v/flqbLuL9e4Y4aAaIZKGCruYXK86M=;
 b=xK9KLh9MIpmpgP5dOzidg7yUequtCN25KnzDekzd3Odjm2JauVDTkgzxVpfcnsbILzJlElvg2NOl8pCYz0wcP64lJ50VC4PmWeTZdGhdWSHBaAUldZBAct0gCeTl14G2iMBjYBLv1I7/eY43Ml9f3ByXpzaNhXgI1qswpnTxj1g=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SA1PR10MB7738.namprd10.prod.outlook.com (2603:10b6:806:3ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 00:24:45 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 00:24:44 +0000
Message-ID: <9ede93dc-01cb-4497-a67b-cb03e864e369@oracle.com>
Date: Wed, 2 Oct 2024 17:24:36 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        david@redhat.com, khalid@kernel.org
Cc: andreyknvl@gmail.com, luto@kernel.org, brauner@kernel.org, arnd@arndb.de,
        ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org, David Rientjes <rientjes@google.com>
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
 <2dffaf2e-8a27-44bb-8d54-ef4cc0b08dc5@oracle.com>
 <accf2b4b-2a54-4261-b67e-010cb74082ae@intel.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <accf2b4b-2a54-4261-b67e-010cb74082ae@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN8PR12CA0020.namprd12.prod.outlook.com
 (2603:10b6:408:60::33) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SA1PR10MB7738:EE_
X-MS-Office365-Filtering-Correlation-Id: ee785ee2-c99b-4c8e-a58a-08dce341c787
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RDQyOVJGbDBwUWdiTnlrb0E4VHhxeXFEN1pKYThyczZGaW9yK0dxOXNqR1hH?=
 =?utf-8?B?VmVIZGQvVmxWVERxQnBkdTRtdjNWQ21MbThiK2R3cjVUdmJhUzc3Y3Q2dDFS?=
 =?utf-8?B?THJCcDhPbE1zaVNzNXlYaWNzZDNRdjVsL2NQSHRKdXVxYVo1aGpMQmY1UTBj?=
 =?utf-8?B?UVNWTzVJcGI5d29XWDVwUmV2eXg4a3kvOWZFVGxtK0V3dXNwRHVhUWpzKytv?=
 =?utf-8?B?cnBuRzJ2VW0vUjJKVy9PK1RDd3M2SmxNUGMvbDRWUDVFQmp4VHpxaVpRbVh0?=
 =?utf-8?B?N3FUTlgzOG54U1JCQXBoNGlreEk1TWRpU0VtdCt2MVZhdk8xMkZUTGVWcm1x?=
 =?utf-8?B?QXhhUVYySnZnVFEwNEppSnJqdUFxWjQyaWsvRzUwb2VMb3VCWXFFSUQxeVRv?=
 =?utf-8?B?RnpibG8veGNuQWtMKzVGa2FOZDZmZWRqVnRnZmFjYnV6N1BXVGE2NzBNSU5Z?=
 =?utf-8?B?VmFsUVlKZElHQzljNm1kTWsvTFhpeEczZUpuazZnWWFTTTRRMDUrd2YxV0lz?=
 =?utf-8?B?MGljZnZYamdGQkpEYnpvbURXMW1WczRGc21Fb0picWh1enBXNUQ4YlF1dU9T?=
 =?utf-8?B?VVQ3aWlJaU9XTDZSUXNmbk1JSklGMHlLL2tYZkhMMUNhdHMySVZkbFp0eS9Z?=
 =?utf-8?B?ai9teFNhenBDR1E4cHJZc05HYXp2QldCcWl4bi9oZkRwR1pCZldZbC82RVhC?=
 =?utf-8?B?K1NNT2lMd2sxV3BsczRUSzZHRlIrVm94S1pmOHpyaXZmallvOStQTUkxelNO?=
 =?utf-8?B?MnZGamd0S2hCNnA0a2daMG1mN3ZQYTQ2SnBsdE1IeFg3ZENDeFNKZEVrVVZJ?=
 =?utf-8?B?N3RwWmpScm1UbWQ3ZTY2d3BycElsb21HV052Y21CU2NZYk1Bcy9xT3ZYNkxU?=
 =?utf-8?B?UGhqL01rdU9LRUxDdVQwVVo4dXgzUkxBL0N2ZWlhY1ZBcWF6Y2dWczAzc1ZT?=
 =?utf-8?B?K29VdXJKQ3ZkaUt3RkZrRFVlVVpGT0RYZU93M2FkYnRINENNWDlKV2IydzE5?=
 =?utf-8?B?emdzR2RxTW9jc05QV1IxQ1g4bzhEUUxKSWhHdVBSWjZtckJoYTZETklNTmNC?=
 =?utf-8?B?enhhNCtzMCtMMWRuZ0lPeDVtcjdIZk5sbGRYRG5PUlNaMjh6cmlGU1ZBN1Zx?=
 =?utf-8?B?cFhvV0h3RGExT1ppb0lDL2EvbjdBVEc0ZUQ0dS92aTRYN3NSWC9QdmR4NUxz?=
 =?utf-8?B?TzBCaTlJeXpENjV2aDB3NW5pMVNocllwUm41YmRKbzI5dTRJOS9xVDlxb3BT?=
 =?utf-8?B?QkkrVVI2M2NWd0M5bm42SFZabTFTMzJxOVdlc2E1UHNlaFVhbE93N3FkWFNo?=
 =?utf-8?B?NDVudkVvcDhiOXB0YmxPZXVwU3lsMDVvclFUYzdnTXUrNGk2MWo3YnJtTHRm?=
 =?utf-8?B?OFZSZnhMcG1xbXZieDB5aGFqdlpQV01GRXQ2em1CNmtlUzBCVEt5ZThZdkI4?=
 =?utf-8?B?Q0pVVUYyQmVzZjM5WVJEMVkySkhkc0F1WVZkdHRycDl1N1I1OXZzanZVU2RZ?=
 =?utf-8?B?VmVGQ1ZZMVh6WW1TVHBhN1NaL0dSb2hERWdGOHk4N2VMeHh3QUQ4V0NwaTNl?=
 =?utf-8?B?aS9rR0tjcXIyQTRCNEd5OFBGNXlYb2M1d3FrZTYxcDhVU0JWb2VraTg5TkdT?=
 =?utf-8?B?cE9HWnpWVlNwNU91c2toa3VvYVFDN3V3SXQ3aG1LdFhyQjRBaHRxWmx5OTZG?=
 =?utf-8?B?Tkd6ZXlsQ21YY1M0MnZCbFhjWjJUbXZYQ1o2cWVqcGkvaEFXT2phLy9nPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVgzMlNiNFYvdlpydThvOVV0SlRJanhoZGZoQlFPem1TUUltZm8zM0w0anFT?=
 =?utf-8?B?SWxoZGVjZXpaLzUzWXFqMkVJTHRsMXgvK3IyYlM3VWwveEdNdGgwWjhmUHRJ?=
 =?utf-8?B?L0F6NEpKdDdRU1U0aWlQSFZLK3JSYTFuUlU5REp3RWYwR1h0YTBGbC9lalU4?=
 =?utf-8?B?VDVKQ1VZV1hFeDBjNXJ1U1JpRFRzdXo5dnUvQjVYNHF0MEZXTW5oZklZQmM3?=
 =?utf-8?B?U1BmU0xNK3FIVG03dHRoa0RHa0pjYWhTTHkyUHZjMzZJNmdvT0R5a1NjdUhR?=
 =?utf-8?B?dlh0QjdneGFOalAvVmNxcHNuY28rUUdpVzNZNG51K0d6aTBFV1lsOEpRc01V?=
 =?utf-8?B?djNRNTlRaHdENGR1OERLK1ByTnFjcmpDeUFNVjlrN0dVT2pKM1h6ZmhMOVFW?=
 =?utf-8?B?bXhHMkRJQXIrbzFQd2pPVHE0WHU3dUJZNHNUckY0NTBYbk5YOERhVE43TWlV?=
 =?utf-8?B?NmFtbFV6YXBlWEMrSnJpcng1cVdhK0pRRE53ZWFzeUJVS05BeXRoN1dPMmdz?=
 =?utf-8?B?b24zdTErRjhSSm9nVHVvTUtDQ3NtMjJBWlRDT0ttcnczRGtrSFpPT1FsUFJj?=
 =?utf-8?B?RlV5MmxTUVJYbWhFMkVaemFGTzUxMS9YMHYxc0o5RXVRSWI5cXJPN2Y1Mk94?=
 =?utf-8?B?bFNCZXlMbjkxb2p4RWNQVGk4d0hpaWpjV2VMSnFSS3FCc2NjS1dNRmd4MlI0?=
 =?utf-8?B?eHpaT1lNQVJ1STVnZmFDMjRuN1ZBNSswaE9RRGxZWWFseENtd25EOXlTc1hw?=
 =?utf-8?B?Q3A1amI4VEZqYlBMakVHdU9WTmNQZE94QTY5T1NpdXN4S2FVbU1WenYrcHNn?=
 =?utf-8?B?WkFNcVJsNk4rbmNzRGdVTVhJTHVDbWhNMjREck9ZdGs5d252eVkzbUtWeGJM?=
 =?utf-8?B?SGZmRWpYY1JkTjZ6OXV4bVRpRjM5dXJ6MGdMK29BTE9hQmtXaHNQNjkrM1dG?=
 =?utf-8?B?aHFlRVJMUUV3SFBzNGtleUc4Q2VydnFQaTEyR1ZmZ2FJMnRGQmtjT0o2VTNC?=
 =?utf-8?B?VEhreWhtalBlaDNzaEVmZ1IzdlJDS3VIRm94YmlVYTVZb1FYbkRkdldlNVNC?=
 =?utf-8?B?OTVXK0FYMEJYTFJlUm8wWC9Nb2tOYWJudHdMZmZaWHB5QWR0cXZRTjZCSlgw?=
 =?utf-8?B?T05TZW1zVldvU09WOGIyWkNVT211UjlqWitST0s3aGx4N3BxK0ovTjQ2VjRh?=
 =?utf-8?B?Z2pNV3I5RGpuYjJrODVSVkVRbks5anRILytNTjVEU0NqRUp5NDNTZVhWcXVJ?=
 =?utf-8?B?OFFrYjVlT29NbjJYdEZsOGhacDRLR21kSWhtQmFPYnJnTWpqdkw2WGwrV2cv?=
 =?utf-8?B?UC9oTHF6dHB1T2hZbDhVQTJJUHlBWFFaUFluM1o3cXJjazF2VHVvUENDT0ti?=
 =?utf-8?B?NFZuVEFlM3orM2YxYnFwb1hsNFcxUHBlT3I3dksyOUlWU1oxWThxM3BVU2Zr?=
 =?utf-8?B?WG14OFNxRnNRdGswM3JlanF2MkQ5Z2hvT2RWY0xjRGllZ25BSUlLanMya0Iz?=
 =?utf-8?B?aUU4R1VwVFRWY05wU3BkZmdqR3c5RG85N2FudEh3TC9XMnZ4dmVQWjVFZXpk?=
 =?utf-8?B?SWlZY053UWVKL2UrV1lvVVp5akVldDdpdzZ1bk9hMWlVZmxJUUUrbjhBU1JW?=
 =?utf-8?B?QnlIYUE4Y1VEVGRwWlZiWFI4dXY5ZjFjYzNKU2hRUktnNlhjejRjdVZ0MnpG?=
 =?utf-8?B?REJCMjdCRXluLzZId3krYXJtRVowRm9ReGZWcVR6ZmlRZjFPVlM5NHE3RktN?=
 =?utf-8?B?YkJjbmc0WUU0WXN6aXZNclFPK3ViR3ZFa05JRW4xRmQ0UmJpNUZvSTB3RVpv?=
 =?utf-8?B?ZzRaTXFINlZBMlJtanhGSnN5ZlQ1bGRsK1lCcGdRQk10eXNkdEVuNVprd21I?=
 =?utf-8?B?L1hNQmE2SVRVdlcvbmdyL2pVUWVIaEttU2JGbjZaUW1IOE5RTWlNMG4xWnd0?=
 =?utf-8?B?UmRhT1Uzb1NFV2JVT2JHWHdiRDNtcXBWM2pFMEVndlNVSWRrNTlPdDduV1Q0?=
 =?utf-8?B?MGlOZWp1dnR4emVjcytQVTZKQTJyWEE5WDZGVGc0R2NIV1J2dzdBM3RyWFVW?=
 =?utf-8?B?WlZYaXBrRG83aiszSDB3V053VWRpenRIY1R5WCtPR05mZmZodUtlR3lIMnJE?=
 =?utf-8?B?YlNTRnJJUFpSN0Z4TXp6Z2ZwTkM4OGlQejQ1blhlWUdSREZxTUw0OXp6Y05j?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DXZb5pFoaeM067zc+0yoKZT1mMMzNeBVqbZQvnR1PWKbwuHCNsA8IuR/I23SJIug+Bj7FYCAiOVi1Cw5RxcFjZK3XJA/iJIOxwfWln4dLvQT5gUIBJj51ZjnJ7oE2hTwG8B47p2VMTh73eAZSsJW7cnuVkOAKxegWfybTFvweO/dIroDdiu38WESFbyu10mC22I9ZSs2ON3D7rAJMcjwVKo3EqUxR/ww5wYkmVlSzXTEkA6P4DBcCQpdJvYCnQupCJbAVm0eyxH6bitHTJrQWsYIGlS0gntE5dA0PYKj2gVfwWndvVuK7SIYD8+PveyN3yv4ZgfbPI9qbxbMWS+K9GRAlSBMQWwG6Lg19UEOM2nuDOy9d4UXMiJrNDSVJLynxh6jpZxJOFeioRoiTuzoBDV0fJrD4ZBFN013GUQJFVHMUTvOZOMnMRmW2VUQugktGIDKAL3qrAcWpA5jx5Cx0MWxfcDeyzOUeWaitvNQr67RVDx0SiXdnoDcOAtnFMJ9mY6x5hyaKBY4PxUmefXzJTcNS+1AjczBFJljQhrBCL7uumBN7e34MMnS4quiezesq1HXcf9B9Uv8O5IFBPZf604CzFePY2n1Cl2nue3xh4I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee785ee2-c99b-4c8e-a58a-08dce341c787
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 00:24:44.1205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6oDDhcRjf9YjXz7Xyf0HY0TmzOGYM/JHnmtXTu4vJwfbEWSuFY5s2s5ANN+NGO+37kQMvEGtsgj3h0x/Cg2/d4IIQTBE88hr5Ncx+x6coU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7738
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410030001
X-Proofpoint-ORIG-GUID: ZAU3xIdmxijHnbHw0FosRf9vzw2WOfLP
X-Proofpoint-GUID: ZAU3xIdmxijHnbHw0FosRf9vzw2WOfLP


On 10/2/24 4:11 PM, Dave Hansen wrote:
> About TLB flushing...
>
> The quick and dirty thing to do is just flush_tlb_all() after you remove
> the PTE from the host mm.  That will surely work everywhere and it's as
> dirt simple as you get.  Honestly, it might even be cheaper than the
> alternative.

I think this a good place to start from. My concern is that unnecessary 
flushes will potentially impact unrelated loads. Performance testing as 
things progress can help determine if a more involved approach is needed.

>
> Also, I don't think PCIDs actually complicate the problem at all.  We
> basically do remote mm TLB flushes using two mechanisms:
>
> 	1. If the mm is loaded, use INVLPG and friends to zap the TLB
> 	2. Bump mm->context.tlb_gen so that the next time it _gets_
> 	   loaded, the TLB is flushed.
>
> flush_tlb_func() really only cares about #1 since if the mm isn't
> loaded, it'll get flushed anyway at the next context switch.
>
> The alternatives I can think of:
>
> Make flush_tlb_mm_range(host_mm) work somehow.  You'd need to somehow
> keep mm_cpumask(host_mm) up to date and also make do something to
> flush_tlb_func() to tell it that 'loaded_mm' isn't relevant and it
> should flush regardless.
>
> The other way is to use the msharefs's inode ->i_mmap to find all the
> VMAs mapping the file, and find all *their* mm's:
>
> 	for each vma in inode->i_mmap
> 		mm = vma->vm_mm
> 		flush_tlb_mm_range(<vma range here>)
>
> But that might be even worse than flush_tlb_all() because it might end
> up sending more than one IPI per CPU.
>
> You can fix _that_ by keeping a single cpumask that you build up:
>
> 	mask = 0
> 	for each vma in inode->i_mmap
> 		mm = vma->vm_mm
> 		mask |= mm_cpumask(mm)
>
> 	flush_tlb_multi(mask, info);
>
> Unfortunately, 'info->mm' needs to be more than one mm, so you probably
> still need a new flush_tlb_func() flush type to tell it to ignore
> 'info->mm' and flush anyway.

What about something like arch_tlbbatch_flush() which sets info->mm to 
NULL and uses a batch cpumask? That seems perfect though there would be 
a bit more work needed to ensure things work on other architectures. 
flush_tlb_all() it is then, for now. :-)

>
> After all that, I kinda like flush_tlb_all(). ;)

