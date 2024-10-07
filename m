Return-Path: <linux-arch+bounces-7787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF837993796
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 21:47:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F38811C2260D
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 19:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6E01DC046;
	Mon,  7 Oct 2024 19:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rq3+tAg5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="E2iWvNU7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26C1313698F;
	Mon,  7 Oct 2024 19:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728330454; cv=fail; b=C8rssj/4HFgt33UIwNBGdFa4fAyfyRJn/vjGcCKBXgcizx49cE10cbJH6NDePol44jBU/MbArlpLZ/hBkwszuET+dYd7immORuFJZqNMxoEgzgjkVlMsfME9HBFyhpq/MykgDUyvh7AsAVKePTucmJ+VpLJdQw7wUeGH/o1vJIM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728330454; c=relaxed/simple;
	bh=rf8ajkfspBt8sD/yJXrwFawe3/6rl7UVabk3tY1vJ0U=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U0M36AlGhrePGM3W7p6SsuhEYVJBm7wLtLBZp/wMAh84sRo+jNud0TDphVoVLvTGxUnfj2P9bFLNI45IcWDZxFn54V/f+d9O6YLzZ468w6EbhekzWcx/KSyZqRwp2lAlTw04/wma15Cojcph8N8s4NPFyHwX4lDijRAjnweD4FI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rq3+tAg5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=E2iWvNU7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497JfdxO032630;
	Mon, 7 Oct 2024 19:46:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=SIRDZP3izk3vXTqmYDfkmIShmUGJnD4Baw3hxUHnpQg=; b=
	Rq3+tAg5T9qxYEBIUsTZ9cKC59o3eAOdj60PKav7uFOJgcKNbXnF78+HV0XW6DnI
	7Bv5Nddxn3VypjewLFRrLz3EGcTEExvTRiUvdB0guYTFcTglTDi9AurbTDcBIJgy
	LKBWrsRHSonSaLiMIBckTI+6WtnxReVJNvOJFA7nr6dnmwdQCDBXsQfuOreHJSY9
	p8m4MmDs7O2a3nRXj3z94bWdQuyWa9xuv3lCQBFyWZ6ULzQ7rENFvwGRDqTrcHYY
	DEVf7PnqMpAvSdtgdhf3AFGXhFhuEHbr3EU2SjPodOuI+YIHIQgBazEXHDZQYTa4
	yz+m37Q5sUKnJPEU6oV20w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42306ec7p7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 19:46:59 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497IpehE001207;
	Mon, 7 Oct 2024 19:46:58 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw69339-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 19:46:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WaIC/LCL0+NwR/PxsiodfOeXtnBjhyi+ABdzqnpydO4J3PPCWU9hh6q6ufN5ZtOlgvu8oratxXYmuqbAVlKQVjew6n04O/ZfegSR/4QQjHw7f+y6zAhYkqTKYsy2+79wHujGGNb36OTfVwxG6a5MjYbheR39Ythv0P2y+qz5vZFU5Qq0pjBU6fNUUA+LqeC/lkd3XWyJYA+ZPOk8o6rA0lmGoS3mujDxLSxorX0x4PB14DdgjRrH8D7Pw8TKtOn2WwfHoynsifQ0bGSPtPIIyhGA2rW8iZ5WjTuTLZ+JaU0Um+AgEWLWQ4wSvr5RB7xD+FcACCOf4tjUaQPIWEtXfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SIRDZP3izk3vXTqmYDfkmIShmUGJnD4Baw3hxUHnpQg=;
 b=GEjS0QcCJuBJVgW3fNngVXOxGmatYA1ZppOzuolXu8KaEkdy3NCiZ2gvCGPjtHUHKRTLmimlbp0B9+9x6Ouoc34qBmHyXSu7TXOzgLqT/ihLa77MBEJuvKYa1UF11vXt0w+KoMXaZIaOBH7nAuyUCjsO14uSLswEDGcyAshweGbY5TdUF6wnyI/II2OzKUZulzw2g/1XD1yURtA55f2DGp5s81FtUiV6Xf02MQmfHrCA/PlOeYB1B9ZRJScR06Iqs6PBovAH9mijq6pCJZnRSOAquV/aD771MgdjnuhI9EIy1Hba2x1Mj9WEheC0txt5aRdoMMxOXTnwGetJcPvr7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SIRDZP3izk3vXTqmYDfkmIShmUGJnD4Baw3hxUHnpQg=;
 b=E2iWvNU74DymUHGo40VV1R+ZVY74/490ok85jJOmFHjFKVr884s4ZY+hfkv/g8CywAXo5gigoE/WkqW7LpsYRUzPEK2SnWvLILsyo7xR2ScioKtmjNptMnxHJmrtfR5LXDcpcpMII/mUMF0ci5bemEmDtF3E5e2pB0xMf+i9TNY=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by BN0PR10MB5077.namprd10.prod.outlook.com (2603:10b6:408:12e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 19:46:55 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 19:46:55 +0000
Message-ID: <843ee8cf-bd9a-45c4-b136-79a11a4396de@oracle.com>
Date: Mon, 7 Oct 2024 12:46:52 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/10] Add support for shared PTEs across processes
To: David Hildenbrand <david@redhat.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, khalid@kernel.org, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <nst3wauaphvvnkseuatqknxfhtu5ewf7zqmoskim5kt52wf2mi@sasls2f6r22i>
 <d56b1326-74e3-4782-a5c7-0451f08cf10b@oracle.com>
 <d080442f-be33-474b-9c4a-bdb57d14cd2c@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <d080442f-be33-474b-9c4a-bdb57d14cd2c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::12) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|BN0PR10MB5077:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a6ef270-fc1e-41bb-9122-08dce708cc6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?em9RSVdsa01pblZrZVB3Mno4QjVLM3lkNlZYdVRHcUJVZ3JEMUxhTU80emRr?=
 =?utf-8?B?QU4xb25hR1k2M3c5QXo2TCt1TXVad21hbmF5cFJtQzNRcnF0V3pGNnlaU0lQ?=
 =?utf-8?B?WmxJQ3ptaC9PZ2g2Y0VUN3RpTktxZGJzVTI4bURGK0t2Q2txWm1uQTM5Q1ZD?=
 =?utf-8?B?d0pyRWRUdWhEb0lTdTdacW9PZUsvMFF0RjFqM2dHQXlhSXdUTGpXK0FUNEhp?=
 =?utf-8?B?dVM1NEt6eFpTNFNaeUd3QWRCL3NsVmdYYmE5UHE4eDNnR0FlNGlIVGlTYmUw?=
 =?utf-8?B?WVUyTlFKajM4OTJtZ1BFRVpqWGtCeVdPb1E2bkZqenAva1VySy9oaHo0d3hC?=
 =?utf-8?B?cGRGRUdaMTNiWjJnc28xV2VCRGVNTGFDSGkrbDhMSkJEdEhnRTBXSkw0WVJU?=
 =?utf-8?B?VGgvTzdhTUlodENTTTd5MWxkWjdLTXN0aXBoKzg2ZjRZNjcwL3BEbmhzSWhs?=
 =?utf-8?B?em5FMllYUHZZWVBDYjhtaGtIb3FPTnU5VEs4VnBUdy9zUlJjeHlOczZNcit2?=
 =?utf-8?B?YkdUL1BWeUdIUkVnTE01anZLNTlod3J5Znp1b243SEFvWjZWNUVMMGlKVHBN?=
 =?utf-8?B?OFc1TVZwWkRFN3FKSG1vTzNnMGtmajZnZCtCY1JrNXVQNEYxdkNoSWMwZytK?=
 =?utf-8?B?Y29WTENpOS96MGl3ckpoRWx6dEdGais0UTVLMWtjT2xrT1RHNHVxbmVMK0Va?=
 =?utf-8?B?OVdKNUR3a1V5a2VWZCtuNHhkb05UcWxxUzlGNEdKMkxteW9VeVVkN2tQYTVz?=
 =?utf-8?B?NFBidUxsQUVwQnJETXhXMnNFMWw1dFBpTThBNkZIdHRRZHNLb3NCemN1RXda?=
 =?utf-8?B?VXlwOUM3K21ZSHNtWlVmSjJGUjBibTNIai9CUTh0REorSVhzaFdHZWJDY0Fj?=
 =?utf-8?B?alZtTk1rVy80bDdFTFhxSkloWFpSNzlXc1gvU0l2UmtyWXdaUFdkcnNDUkw1?=
 =?utf-8?B?bkYzWjVMNlhnL2VNYjhPcUxkS1RNank2Uys5VWdSazIwTkpjemtzNk1KTXAx?=
 =?utf-8?B?VDJzZ2RnMmU5TW9QNTNnSXRzTWZqbFE1bHFOdk5aOWkyWi92L25UNnQ4dklK?=
 =?utf-8?B?elcvaTV3ZzNkY3UwSEg3Zmw3Vzh5QUNpeklzWXZMKzM3UlUxaEVoSlY0c0NC?=
 =?utf-8?B?WXBKWTFsQTZZRkVFdGFNRDhWU3AvUjJLdHBNd3JZbFNvcUVpQTRPNlVLdWRa?=
 =?utf-8?B?UGUwRUsxVjNwSGtNMkV6UDFDb05QQ04zZ3NiZXpEYlVwSnFVNG1IN0NGdzAv?=
 =?utf-8?B?bENZckhXMitxZWo1RWVFM25vTy9aYmd2MHh0RytISjNzVnRKYkRHeCt2TDdu?=
 =?utf-8?B?YjUvN1hWMXVqQ29KaHE5U3RRanRiSWRiQlYrMzd1dHdUN2FBWlVoTmlaRXdK?=
 =?utf-8?B?ZXdxdmNiN05DMkFOMHdQV01IM21OVFFMby9xQmtPVE9iTWVBaUlRQjdNQ1J6?=
 =?utf-8?B?VkRmWmtoWmd2cmJTeEVzRllWTDV6dmM1ejBSOVU4NE5hdVlDOHovRk1ad1By?=
 =?utf-8?B?QzlXQ0ltWFRVckVKSk5vcUg4ZlBpNzZnZlhucUVTclhDZ3B1cy91dSszVlRT?=
 =?utf-8?B?Y3VEQTdyQWVxcElVcGs0WTV4NUg5V2tVbzhzUnRnRjh6c2FrTWpQZmhaYmdZ?=
 =?utf-8?B?MEMyWlF1K3dHaFIrVjRnN3M5SnZuSDUzRWpmTWI1d2FPNlVTSWRTOVBtSnox?=
 =?utf-8?B?cExtVk1ueDdtTngzenlMRVc0SkcrckZqd3hwODRiUURkOURpWkhaQTFnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RG5iTWZvUk1veFVXYXN0MzdDTFcwbWl6YmdGL2VqTFNaNXhSSWVhZHUyVGFG?=
 =?utf-8?B?d2N3NFNkUnpTQ2M5eEhpcTlOc2RxVzljZEp3eVNqbW5CYzlEVnI4TXFiVzZ0?=
 =?utf-8?B?R0NiTXl2eEQxK1Q0UHRoYWd4WXhLVVBPMXJ5SXhqdnFhR2FEOFJPU0diK3pi?=
 =?utf-8?B?eUU0cXBZRUVFTlZMSU5HRWRqcWNFQlJrTU9xdEQyMzhuRHZJVnVEWEc4VGxy?=
 =?utf-8?B?Um14VGdGdEh1NWsrU1ZEQ1JXbWY2SzN4MlJXUHdTMzVjcGN1Qnp6Rk1iRTdm?=
 =?utf-8?B?SStpOXRYRGxPQlpkNVgzcHJlOVFTY285aFlIQS9XN1E0SDJBakpKQzBKVkFw?=
 =?utf-8?B?bXplSXRNcWt0WU1NdHBBRFBjWHZsNTlGdXljSGNCa1cwQ3Zra0NuRnNjamtS?=
 =?utf-8?B?M1ZRQURLTVRWUXo2OE04Ym1JMUQ5Z29PL3d2dmw3MGhSdjZESWsvMlpVazk1?=
 =?utf-8?B?cHRYS3lUUVY1L0lPbW5xeFVwdVpNRnhRUkptMGt2SnBZQTNZKy9mU3pINFVi?=
 =?utf-8?B?OWpYZVVLeTE0dWFRRFlRSk9naXVrYWVZNTJCZG00TG94Tkg5a2JUTm1lL2ZZ?=
 =?utf-8?B?OVdkRUgzNCt5bXo5Uk01L3lJNFlNWHVaS2ZDQTB0MDZ4a1NiSXFocUxrSFAw?=
 =?utf-8?B?ek9wenZ6UmZlb2syeXlkMkIyQk9YOU0zbFBza0tmejNxYzNVMkxCdG9aTm1Z?=
 =?utf-8?B?Z210cEFFSHpTcGR6M1hLRUVjTWRZbmFRMjNKWDVERVZTNDd2TmRXWTZVZzl5?=
 =?utf-8?B?WmlKUnVmamI5aTlXNGV0TGdzZVVxc3JocExWdDBDUEZCL1ZBZVNoR29MTTh3?=
 =?utf-8?B?ZUYyeFJBZmRJbi9jNXo1eEpLcWQ1VDNmN1F3UlROdkN1cWJHM2ZnL3RhK2Uv?=
 =?utf-8?B?MGlGL1RhSUhXbCs5Z3djSWpjTXRWMXRoU210aG1ucENmTFZpdzBoaEx1NkRv?=
 =?utf-8?B?MmF1cmtZN1ZiWDRnYTlHMmhlcDEvdVBvNWJlS3diLzU0RFdEZkdWcGFTUGk0?=
 =?utf-8?B?b3haM1U3SlVkbk9Nc25pdFBadEZiQ3JXcEh2OGZkeTlvc2tpMmVEaWhZdUpJ?=
 =?utf-8?B?a3FSUWJHd3lDaTZHenJqeG5tYXlJcmd1dnF0WHlxOEdyMWh1NWw1WThwa3J2?=
 =?utf-8?B?ZDJTenVXaXdaK0NpaGNiMEdQa0s3L3pMKzRGNTJaMXd5NG5UZE5KMGZaTjcx?=
 =?utf-8?B?dS9wUG1YSnJOUDZlM0tGNUpJbWIxazlrcDZVQnNUeWphc1dHTVVDODlMNnZW?=
 =?utf-8?B?TnBnekhWM2NzK2EzOVRoQUgxWjBpRURKYWFpS0lhL3MrNVkvN1FXNm5JRmFR?=
 =?utf-8?B?cytHU2x6Y2VpejhYdG9WMGd5eGRBRXE1WEZ2RnVTR0hLNlVydFVWeTFDZXRt?=
 =?utf-8?B?S3lWSkVPYXJiWVlRd1FmcjB5eWhnY2hOWktuTXczSFRBbkFZS3VqT1MrSEZr?=
 =?utf-8?B?bXZpTVhXUlo5V1R1dEo3YjAwdEZva2RoeU1BOTNFbmxwN2FjSjJvTTJZQ0pp?=
 =?utf-8?B?RUdyRktSTmRCUzcyRmYyZlRsdkRVbGZiNXFXZHRVQlRvTDVyL0JVd2Jwb1JT?=
 =?utf-8?B?Z0QwQUFjNHlVbks1MVdtcHc1ZVBCb2dITG14QVZjU0RKeC9XR1RCOUk2emZs?=
 =?utf-8?B?TS8xSUxhR2NaQU9mMlVUOHNTOWpwUEhqT3RPVzhqS0F2N2ZGWE1rcER6NS9v?=
 =?utf-8?B?cDQzaHJDUGZ6cFhJN3NURUhBSWVpVDhTc2FMZGkwNEVrL3pmYzlwaXZ3dFNO?=
 =?utf-8?B?MVBEWE9aaVRTdFU0TXdUL3dqdUg0YkkrcVgvQVZ3WGo2UStDZDRubFRMRmRF?=
 =?utf-8?B?dkwrTWx1WnNLR1NsRmpJOGlENFVnUURyOFdHam1zcWJVWGM0cEQ4TGVzU0Jk?=
 =?utf-8?B?d0dOOVNtTVpmR09WMmJkbXl0dmxlNW5hT2tTcjZCb3M0d1Q1VllFTzZIZ29l?=
 =?utf-8?B?RjhjbjVRN0NXMGRORXUxcG5vcnNzT1Y1OXcxYlVkYXFKeGcvNDFyY0lyamhK?=
 =?utf-8?B?VGlpRGZGQ1F1K0orYklXTjR6dEdmZzg4eFhzRjFjWWtUSlVLL01lSHNWc1cx?=
 =?utf-8?B?UERja0NQZkNWQTg5L05WazZvb2VON1BLMFZhWHNFaS9IT0Z5UHZ3c3loa3B4?=
 =?utf-8?B?V3FRSXFZZDlGQkFoZ1pEYXNxamF0b3VSVHR6eklDNUh4Zm9PR0VVUE1aV2ZF?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4Ppq+N+UWxgRa3+61hbNeEJaAhVL/Dh50Xqg6obKOLuyMEflocQIthy/C7ck7020LP/fUuzfr2fZy/c7LH3P1mOIXGnDnltUrNxYfcbmHcfnjGvL4CN0mYI/pNq2+GEuorsUJ00kZf+xHmnaAoLuLcEmFLBrvV7pWCw8eSm/3zYMQhg/uolKgcva18RQaiGDn3QaN/yng8mkstR32+Uf3S//d6YVPN5Oo6yV0V4fjW1n3QWg+0N4d/RpM+4az34NT/JjHM/MLsiiAQmllernRorwiGYzg9eVYvIL27bUL/lsdfQCKY/nEsUvchkRKabIp4i6iEK4b8hHX6mfOsyK5ZcbjWOr2rYIfQazukJKQ2XrGGTjNgtzkdynTVNf39dmQD3kloSfkygRF+JyGf4Z3ykxJ6HZKYSsGlAhCl8eqxmHyvxT9IWRZ4PntNG+eHZbSPw4N9hJzAf86cOK/ZBePYOVYaeqo6FsRyuyOTlcbj6pVjzQamlr9zSuhsy/DG3SUM37H6Si/jwFf4yMxtZdJ0UAtcN3LZVAA8unJ/rtLAMLH2AU6atEe0pe7+w+0YrWdcPsU47zIiKrtJu5e0dP/N+vYhzfGyySnMwzTVX9wD4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a6ef270-fc1e-41bb-9122-08dce708cc6b
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 19:46:55.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HXCWQknt/q78zXNsSX83GGBWptIqIFHy9gqohM5F6VRxPLRhX0KKkUPPEuaeYNWQL1gVMC1q7csgb1sQBa2gBf+lX/84a/KflEUsUQeq//U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5077
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_12,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=991 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410070136
X-Proofpoint-GUID: uqgO3ruKJctyx0Ovo1zXrhz_meIcGAYJ
X-Proofpoint-ORIG-GUID: uqgO3ruKJctyx0Ovo1zXrhz_meIcGAYJ


On 10/7/24 12:41 PM, David Hildenbrand wrote:
> On 07.10.24 21:23, Anthony Yznaga wrote:
>>
>> On 10/7/24 2:01 AM, Kirill A. Shutemov wrote:
>>> On Tue, Sep 03, 2024 at 04:22:31PM -0700, Anthony Yznaga wrote:
>>>> This patch series implements a mechanism that allows userspace
>>>> processes to opt into sharing PTEs. It adds a new in-memory
>>>> filesystem - msharefs. A file created on msharefs represents a
>>>> shared region where all processes mapping that region will map
>>>> objects within it with shared PTEs. When the file is created,
>>>> a new host mm struct is created to hold the shared page tables
>>>> and vmas for objects later mapped into the shared region. This
>>>> host mm struct is associated with the file and not with a task.
>>> Taskless mm_struct can be problematic. Like, we don't have access to 
>>> it's
>>> counters because it is not represented in /proc. For instance, 
>>> there's no
>>> way to check its smaps.
>>
>> Definitely needs exposure in /proc. One of the things I'm looking into
>> is the feasibility of showing the mappings in maps/smaps/etc..
>>
>>
>>>
>>> Also, I *think* it is immune to oom-killer because oom-killer looks 
>>> for a
>>> victim task, not mm.
>>> I hope it is not an intended feature :P
>>
>> oom-killer would have to kill all sharers of an mshare region before the
>> mshare region itself could be freed, but I'm not sure that oom-killer
>> would be the one to free the region. An mshare region is essentially a
>> shared memory object not unlike a tmpfs or hugetlb file. I think some
>> higher level intelligence would have to be involved to release it if
>> appropriate when under oom conditions.
>
>
> I thought we discussed that at LSF/MM last year and the conclusion was 
> that a process is needed (OOM kill, cgroup handling, ...), and it must 
> remain running. Once it stops running, we can force-unmap all pages etc.
>
> Did you look at the summary/(recording if available) of that, or am I 
> remembering things wrongly or was there actually such a discussion?

You're likely right. I'll review the discussion.


Anthony


>
> I know, it's problematic that this feature switched owners, ...

