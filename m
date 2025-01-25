Return-Path: <linux-arch+bounces-9906-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE6A1C519
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 21:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BE1011656A1
	for <lists+linux-arch@lfdr.de>; Sat, 25 Jan 2025 20:06:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B184136672;
	Sat, 25 Jan 2025 20:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yf6LhSnq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cEtSmRsT"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D187082A;
	Sat, 25 Jan 2025 20:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737835614; cv=fail; b=ddCkmxny7iVXWMkFJAUtxTTGjhe6ZRMVThtZgc/W8usKx5Qn1SlL8u/b0XpXU1G4icUYHs3m2ksp4WBbsjMk5dqifXeQ5ntYON5B7Y3sz/bg56sRGvtzZyZI9KbxjOE/5fsu8PeStDjLrG4cXPwXEXjH0Jn/EyJvIDGwp/CY02g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737835614; c=relaxed/simple;
	bh=0kZKe6V0fF8VCmhBdzZTH8KkL3JfCwWtsfMJXTzzMrU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uIr/NbTDNV+L0Dj02QQpDq5DLORjp64LWcjSBmZ6sa7gmj7W/OwV1Ev849Kvkf6rwUdh5J+1Yb2rz0bsqeOhNk78XmrSMywK7F8pBE/lGhh4kHUKDO3Gls6rHfpSGwlUJ2UfYoV9mQ+EFW4TOtCK+XNvANK84bGzhsr7eldqjVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Yf6LhSnq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cEtSmRsT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50PFhNuP010983;
	Sat, 25 Jan 2025 20:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6vcwq2liI7wys661RWiJ0XecRUSSAOOR4KhOcu1iPhg=; b=
	Yf6LhSnqvQT8X5tnH3qo6NwZDgmQEXipxNwEkDaowwDiyh4JMrE6B7MP7TcxYwwp
	t5LmWpvwjzE4LvxxX1Bq7K0hbjHF1FKVjXaBq9sbHlsIV1sTIU2D+MEMwxRH3O5v
	h9+XY8uaaoHik1GseJ+DUtD0XMG7aBA7i7ZgCqjcvJ1v4DwMhTAB9eHs3HXLGUs7
	BnDkoWZkLxXYlNmdMJSgHlIDWGkE7r8eMz4Rpk9OthUK+a5aK9C3J+dZ6ilmjhBt
	uRYBNSkFvHKo+TBYa5lJqMgipAsgWvxmKdiNqZB+12BMcJfoRACTXVIeoiqJeZjr
	RBAJKnOvgXYT6NpZuoswlg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44crgt0f3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 20:05:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50PIKMrB035248;
	Sat, 25 Jan 2025 20:05:56 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdbpq43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jan 2025 20:05:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIKIRlHhF0LDTiPTjhnid2PE1vyI7iG4RiTbqzXzKmsdrhnf18JV+fZFdNOdJViwfw/CRPCkMGrId5MDlAruL+cqe1XRBov7p4lqpgptMAitFFtCYp0FEDq1pvNohqa7ZTkzZpRpfd1qciQQTtiAri9mKh7/WZ/T59zf0sQvtNDisceX7PrBt2ZkhL/y8OgiyMxHR2bknOYJymdHeYy97c/GFrlW9qWPnmFlykkIDNnAFR0U4vRP5a0zB045pyFmCGPDumXBL/pz7scMuHw81LM78l3w33sxnYtVNfPn5+lBVmOWpoYfc6Xat/OVLfD9nX/WGvakv4Lwbk6W3lCBwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vcwq2liI7wys661RWiJ0XecRUSSAOOR4KhOcu1iPhg=;
 b=v2yfIK/bM0J9ZgxR+rApygUDypQS8oh3JCw5UMvtH9Sgr/qFPbtzxgxdONREeh+8JhCEtpj5Dxt3ZVPNOBVFMeg7P2Mb7hlv1t1MVj3Xr+ntK+ZiRwxSCgxT+nJdfMGIKnquDQuv4z+AEjTztgBAFUsvYGgyZSrbZndWB5lQiN2sqJqcB0UEpHDc/SZ7EVR7OEZq6IAKh+R1gT2rv8BITVSGxqLgDKiIe7HmLgA5xK8Mma5Rn/WaywWclhkbKeUKNBTtCOqFIFzeDYxFrqBzTccvWK76Wy3HHnHgw1VqHrS5KMmD4rpxEcDA7FLSD4uzZULlMrKWT6PWcKqnWQ8YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vcwq2liI7wys661RWiJ0XecRUSSAOOR4KhOcu1iPhg=;
 b=cEtSmRsT6qQL+dlkQc8x8pzZde3qg3Uerxl5j4LpVE/cZvptAKCGNl2V1lqB+nSBLd/8XhpVTZztLVmYW0rxUGYJv+YrwjzzJB4F+7rNbD1NU3SbmnTRdbivjcHr88AR5rr+3Km+Ms6R3sQ6l+4GNCWiYudGxkWQJcpi7xDc6so=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by CYYPR10MB7571.namprd10.prod.outlook.com (2603:10b6:930:cb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Sat, 25 Jan
 2025 20:05:53 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%5]) with mapi id 15.20.8377.009; Sat, 25 Jan 2025
 20:05:52 +0000
Message-ID: <f515279e-235e-4396-9c91-cbf67083001f@oracle.com>
Date: Sat, 25 Jan 2025 12:05:47 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] mm: Add msharefs filesystem
To: Randy Dunlap <rdunlap@infradead.org>, akpm@linux-foundation.org,
        willy@infradead.org, markhemm@googlemail.com, viro@zeniv.linux.org.uk,
        david@redhat.com, khalid@kernel.org
Cc: jthoughton@google.com, corbet@lwn.net, dave.hansen@intel.com,
        kirill@shutemov.name, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        mingo@redhat.com, peterz@infradead.org, liam.howlett@oracle.com,
        lorenzo.stoakes@oracle.com, vbabka@suse.cz, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeel.butt@linux.dev, muchun.song@linux.dev, tglx@linutronix.de,
        cgroups@vger.kernel.org, x86@kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20250124235454.84587-1-anthony.yznaga@oracle.com>
 <20250124235454.84587-2-anthony.yznaga@oracle.com>
 <879e64a0-f097-4bde-ae31-25a1adc30d5f@infradead.org>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <879e64a0-f097-4bde-ae31-25a1adc30d5f@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0099.namprd03.prod.outlook.com
 (2603:10b6:a03:333::14) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|CYYPR10MB7571:EE_
X-MS-Office365-Filtering-Correlation-Id: dc1e9789-962e-4994-0a8b-08dd3d7bab52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VVdqUmlFbDcybHJCVU9mb3BvSEJhU0lmd0V4dGhlM04wanNJMkkvVHU0Q3pT?=
 =?utf-8?B?L0x5TEg0S1lKcFBWNktheDJKQ3dVU0lYYTRqb0hkOTg5ZDZJa1l2aUdIaHdV?=
 =?utf-8?B?elAySUZJVWFDVGhiWlZFeHdDckgyQ1NocmEzT0Q2Y0hHL2IxTW52ZHlUUkhN?=
 =?utf-8?B?ZktwdTN1b2lLU1VJWHEyTDI5WEl6K2g5UEx1L0o2NHNWcTVVUlZwWEJIRldR?=
 =?utf-8?B?TU0vT1h3MXJKMllyQXM3SHdFQ1FWb2xCOENVeXJHVHE1K25Ibmoxd0cyU0VK?=
 =?utf-8?B?d3FyQVVTMFlkUXlNa0VQaEY5S3lkKzM5aXp2cmRRZDZOM0d5OUxiRjJnVnU5?=
 =?utf-8?B?VlY3OXRXaWMxdFd6a3Y3aTFtR0UwY21LQi90aHRBQ01lYzFsT3pRRXpNNzJt?=
 =?utf-8?B?R2prVHFsYnMxWURTSW0veHdRMUtCaStTdThhVndKdkt4V1BabHdJWEQ4SlJs?=
 =?utf-8?B?ZnJ6cTd1L3AzaWdaL1VweWlyNGZST1BPN3NTSFdPbWV5ZHRkS0NhbURyMUdw?=
 =?utf-8?B?QXJKcUFtSFpzcGloajBDbjJPamJPYU15ZUxuN0xhdGNzU3NTMFZUUG5Db0R2?=
 =?utf-8?B?TEdFRzZZQ2lHTm1ZQUIyMWhyYmZwbThsc1RDbkZ6YkU1ZzBNQXhBcGR1Zi82?=
 =?utf-8?B?RVhCbUZwcFYySWdwV0J3ZnhHRGQyeWp3VnBSMm9iY0pEWWdpa0NVZW96bUEr?=
 =?utf-8?B?RllFaEZKRXVnMjhWckpieWhRckg3a0ljTWNYamk2dzJ6a01LTHJ0dHpRRjM2?=
 =?utf-8?B?UWlRdjdqSmhJV3JTaE5IdkxSODkyN1QzQnNHMExaNWhEZWZkcG9Lckx3VUxL?=
 =?utf-8?B?N0F3M1JPb2YxS1hVZ2VVTTNEQmZBSlpKb1o5YUlSaFhmR1dxTDVWMitYcmJT?=
 =?utf-8?B?c01EYkpCeWxJT2ZUWk9BR2VoemFUSTY2bHFXOVRuaEI2VEpOaStZSHVYY0dh?=
 =?utf-8?B?SDdQWFNSdmNvL2dtV3ZyZWdxenkxM0kxTmJPUFkxbDhxeGdLQ3RUd3MxSUFG?=
 =?utf-8?B?ZXQrTGxnZkRQUU5nTlRPU2ZYTENJaXU5b1Zxb1lEamV0cXFKS2wvcGFkSUFP?=
 =?utf-8?B?eXhydHJFQXhmbjdMdWEwL1RLY3pVT1NlUStPSzFTK3pDOUlLdmVSWG5qVTJY?=
 =?utf-8?B?OEhmQTRlZ0dvc0M2dStneFgvZ2p4bXJNMDcvK3VmbmIvN1JiclpUT2s2RVJY?=
 =?utf-8?B?Z3JZbUJJRnJoUWNYR3pMTmhwdXZjaHpab1g3T0xHampOUzRXclJrWW9ackFl?=
 =?utf-8?B?eWNTbS95Rklha1l4MWFtVGZUZFlBckFJSEFPb29ySktNcVVFZWY2N2hzTWRT?=
 =?utf-8?B?K05oa1l2VXh1dG16Q0tUYXl3WCtUcG80d29sTVk2WGxseU1NaXRIejNBaWht?=
 =?utf-8?B?WUtmekh4a2daWWF0L29xVzc4cEVYZjIyTFFCazVDd3BPQ0xGNnA0Y29hSndv?=
 =?utf-8?B?OTJIRWdQU0pEOFhNcittSGJXNEsyczIrcEF1VXllVU81R0ZsM0JDR0xZSWF5?=
 =?utf-8?B?OFhzSC9Sa1BBdzFkekZzS3U4aTg4ZnRhc09kVWh2d3lJWGZPTzBGcDJvZXd1?=
 =?utf-8?B?UHEzbmtmeEhCVW03NkVYR29ESFRWakZJRFcwSC9qeG5DMVRDMHpiTlVNVWk4?=
 =?utf-8?B?N243UGwrR2ZmWFFMZ0F1cGdlNWJsdm5tSTYzZkc3TkJlYU02UDRJcC8wRzJz?=
 =?utf-8?B?bSt4RFFpS0ZXdklBczlMZk9nSG4yWGEvZFlKaWtCUGhtQ1ZPcm1KbnhWSjdI?=
 =?utf-8?B?algvWXZwdFkwSlNXM3MvODB0cnBKV3MxbUhRaTh4OW9EUGhOS0t6QWlLZ3Yr?=
 =?utf-8?B?dlhLcldCdHhZTERldFE4bkJyMkFkMGI0SjhzSUdIbVp0dWZDdEpNZnc1aFU5?=
 =?utf-8?Q?/WACBgJDfsv50?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MnZSZmIra1BjYit4K1FRRzc5ZEtjRDNhZmFFbnI1V0paaFB2VDlFUnF2UlYy?=
 =?utf-8?B?QTB5MXg2NHl2VGhaSml1ZStOcmRuZXFBNzNDTGF6V2R0cmo2ZGVSa2t6VjlQ?=
 =?utf-8?B?TGYrcFBoalZtRzZRQXQydmNFRTlySEF4RHFIK3JSdWpMcWtpWnpSN2t4N01r?=
 =?utf-8?B?cFkyajAzc09UTm9KdVVuYm95Z2p4MG1BbnlPa3JIZWQzVDdHNm5FODR6YzBB?=
 =?utf-8?B?eUNWZFR3TmFGeWxybXdrL2NoSXZ5Uy90UW44aFg4cXRrdy9uNm54bDRGREw1?=
 =?utf-8?B?NWZ4V3N0azhpeXZ4RWtjTWtUSkRqNXZJaU94d1BmNzdqbFoyR0Nyclg4aGsy?=
 =?utf-8?B?TlZZVDBDTFQrbFhXRjF1enhXZHJxZDFyTU9LSi92SGZxV0ZRdDJkeXNtMFlB?=
 =?utf-8?B?RXBsVFlVSjM2d2I4U0oyMnd3WVVlTHFIUUhIY3p4OENRN2N6WlJlS3hvNmNQ?=
 =?utf-8?B?WVZjODBqclNjOVZSWlZuVGhJVkJkNHV1SVJVRWFicEx6akF6OXY2bUNic0pu?=
 =?utf-8?B?YXlqK1FQYkVZZDl5RnNRaU1VM3RsYzU4TzIwNjNWYjJPQk1mZGtZNGhsU3V2?=
 =?utf-8?B?b2VGV2RldkJzZnIvOGN0Nm1XSXlyS21kMEMrUVdMcmdlMm9GRWlxZ0JxbXZj?=
 =?utf-8?B?ajNZTWFHVHkrWE5YSWFiSEJySyt0WW03UnVVbTIxK05KVXdFYXdFMTF3RFNM?=
 =?utf-8?B?YW90ZkQ5K0ZHdHlQRjVzRkpkYlp2b1h3c1pyYjZhd001KzV3N1NYOVgxUzBs?=
 =?utf-8?B?UFBKZzdmcSs5T1RvdGp4Ukl2T2RUKzRyVlVWd28rWHhpTWY2YVcyM1NyUnVW?=
 =?utf-8?B?Q2tPT01VZFovUytrOXlteU1CODhSdGlRQjJKY3hjQkFDVm9zRENVdUY1Y1Zj?=
 =?utf-8?B?OS83V2s2Qk53cm5sTXJMWmNzYVl5MTM4VkZjdkNVeDBsNEc1UEVjRTRMcm1Z?=
 =?utf-8?B?bHB5WTBxa2xRWDZCVG1wQTF6c1NlL1ZSMG9ramNXNDVSVXlubDdvNi8zUFh5?=
 =?utf-8?B?cExrMlpqQm1JRnNWWlgvMVNLbWQ5RTlyNzd5bXRuOWdHUTVVNHBKQzY3Mk5h?=
 =?utf-8?B?Y2NtNnFRMWN2Vk4xd3ZncC9iNk4wTWFxWEYwcUxFVjdFZWRvSmIxYWppKytl?=
 =?utf-8?B?Z1UxOGtJVFBCcVpqZ1UzQkUvRjVhbUY4ZE1rWldzdVNkTkFFSmJUR010UW5Y?=
 =?utf-8?B?T2E2N2xtNUFPUFZsTzB5M1NvZkozYkpycUxrTGFGa1FOa1VsZHhXc2tqcmVj?=
 =?utf-8?B?VDVnN2tvSjBUUW5oTTBZc1JRZDEySzZUbTd1Wlk2SmU2K2R5N2lldEZrMEVM?=
 =?utf-8?B?L1daZVJEUEFQaTBQekVpeGZ1MGtTK1ZmMTd0ZDF4UmhaeHAvMmowcHlJc3di?=
 =?utf-8?B?cUZjdkxFalpRT0NScnl5OUR2K0lsdGlYK2EvNGcrUk95WlVROUlFZFFCRG1N?=
 =?utf-8?B?WWtuRStIZzhKVG43eWlKSlAzR3BGRzVKUTdlK09VYnlWdTZvd0wwa3VrWUpL?=
 =?utf-8?B?QVc2VFJqTlNuaUJmUno3UEQzMFY5emh2NHVnK0dLM09kc3JldFZnNzNHRGdv?=
 =?utf-8?B?WlVYaGFaYlhsUmlvQjMwNDM2allWMjNLZ1JZRmhHVjBWKzVzeFdzT3BKYlZ2?=
 =?utf-8?B?L1AyRkUydFJEaGxLTXlraVBGK0pGVVR5eVpVNEYzLzZCYnhCZDBKNEFGcmVk?=
 =?utf-8?B?T0Y4T1U5bk82MnA5K3ljQnJneEh4RTFoZmhvZGJvVE8yL3lOZ0Riekw1SU11?=
 =?utf-8?B?OHkrOGpVSTBjb2M1dnBlME9aL21uMWsrUEJWb0dpTEVjeXlLRnY2U25MRzRL?=
 =?utf-8?B?aVExWE55Tk1WZXBMUnNuK3JSR3J3NExFZ2RjR2R1ZkQzUVdrQml4T3Q4TitK?=
 =?utf-8?B?UzRQVng0OU9OQU5JOEVLYlBsU0JEWkcrNkZ2RzcvbUdSM0JmMUJ5ek1LMHRQ?=
 =?utf-8?B?VXg1MXBOL2xaYWp5MzF3VU5VSWRJaTlHMWVBa2dvS215N28rSUlQbllrV3Jm?=
 =?utf-8?B?V2NFSitkS1lRN0JWVUxlWmpxajFXWU1tS1EzWHVSK2NzUlJTNzZ4Sk15cDN3?=
 =?utf-8?B?eElKeFRzOENScmtXWllkMkZ0K0o1aVVGWmlWaDZoUDhtYU5wOVZraktXMDJK?=
 =?utf-8?B?bVJqQ2dETUZRSDJtanhPUE1tNWxXK3prZ2VXN2x1Y0NiSGdqY2VzcFB5aWVl?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EYQfeQ/ofRfh1hwLcpfY+B05wGWJsDOwhu+eACMe3wef6vu9qM+U4/rt68g+YqUrY3r3dlsE+GoqlpgD/PtkfCew/qYdDJYVWgWIbuz4IZfDHiOb7+Fhee8Xc4ojvH6X6Jr9KEMTQgXfXQEwiEzxgXXNirjCxLK5OB7LcMCIaa467cWZj7RQ/yy+ba5npzhPN9Wg/jWTU0THQmtPnXtxvBdklMfHO6kN1vDZlsJyewygVRspOh9HuM+w4dxfpiL7yWhAjtuTTlKTyLdjnukC6ChZAFUdoCoLTc+LJ7qywJLiiY9Zbfu912oYt/KC8CbeLPRSoD5eherjX83L66/WUmvPiXRVrefb6Zvs81xwzvsf7/RwVOhzohFURRsnxet+hO3KT4mZdTv7adcq20r+c13nGF2NylpYwLK8+zTsG3MekuedWqdKprozsmab9XjW1PiaJAIUeCcHSvUh42KF7VHZdDExLmmm5OCbVlblEtve29d4PWSmk7HIBcp+w3Y6BdsuL3kVIR5s561Iv/jnlec/bPvvCrS4f5KG4CL7AoyLR2uFYJJCQwkIEorKsheSxnaCdpI9zFfmxwc6EN7yIIxyqpReSUuxgkQomI9mxmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc1e9789-962e-4994-0a8b-08dd3d7bab52
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2025 20:05:52.3462
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mPoLIZt/SFnBnGHecbrl2TctjFuliz77cQUcrNiLMVg9dUAPj4SXllna8rhBV5L5ex92KbFzg3mzegLkvJgut7k8nLs8j3vf6zqs/b1eP1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7571
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-25_09,2025-01-23_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501250150
X-Proofpoint-GUID: bbZvwu06swGrJfa-iqxzPtbxxQ373o8t
X-Proofpoint-ORIG-GUID: bbZvwu06swGrJfa-iqxzPtbxxQ373o8t


On 1/24/25 7:13 PM, Randy Dunlap wrote:
> Just nits:
>
>
> On 1/24/25 3:54 PM, Anthony Yznaga wrote:
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 1b501db06417..ba3dbe31f86a 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1358,6 +1358,15 @@ config PT_RECLAIM
>>   
>>   	  Note: now only empty user PTE page table pages will be reclaimed.
>>   
>> +config MSHARE
>> +	bool "Mshare"
>> +	depends on MMU
>> +	help
>> +	  Enable msharefs: A ram-based filesystem that allows multiple
> 	                     RAM-based
>
>> +	  processes to share page table entries for shared pages. A file
>> +	  created on msharefs represents a shared region where all processes
>> +	  mapping that region will map objects within it with shared PTEs.
>> +	  Ioctls are used to configure and map objects into the shared region
> End the sentence above with a period.


Thanks, Randy. Appreciate the comments.


Anthony


>
>>   
>>   source "mm/damon/Kconfig"

