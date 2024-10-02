Return-Path: <linux-arch+bounces-7630-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4132B98E37B
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 21:32:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91A4DB21EDE
	for <lists+linux-arch@lfdr.de>; Wed,  2 Oct 2024 19:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFEA19146E;
	Wed,  2 Oct 2024 19:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eamwPqdr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Hyjzeo0r"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68935176FB0;
	Wed,  2 Oct 2024 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727897518; cv=fail; b=Q5e1w6R/RzYhnc8NT6YIsGTGVkKdVcJDrK0bebGSvW8zcIsNvlh2MSUi+KBgW2Tt28FrMD+WB08+duJOQcevRc3b/A0Szzuie95FEQ2l7RSZ0jFv0P4PzsuzYF7sYyVc+OUNT8HvSq0FiOX+/xxubeUZjnXi5LR2GFUbt5HF5iM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727897518; c=relaxed/simple;
	bh=VveqvYoc9rID7qv5udtoobcPqDUyxG/aVmCFzl0shuE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ep4tMhtceDLyE9xIETp2VrtDtaiqxTmMi+3Ez8E1nTT5x9rGny+phMb6pPK3I0DJEUJ1roy57QC/E5lKK3RzuWghs02hW4v7ce49Rk0J6Q727abqn/2mAjPBrJpGt2RhrieO3gHVS3Jb67vQK+Mhw++RXZkOYV6T5AOSmNB9bMU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eamwPqdr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Hyjzeo0r; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492J0Zvp022514;
	Wed, 2 Oct 2024 19:30:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=0lYnz5pnC2IqkjfTcE/7nmgn+wrEeeoI33UW2FOFSyA=; b=
	eamwPqdrscbCnprqWudq8p4YJT2/I36psX694V1g/MAWwpMZW68k+vlORQ7sN/kN
	vUocLma0frzBCjnL274Usp0i1JsKUAOqdPXVueBc9q4+pLEdZpzcQt7s4frpH3FO
	ZXTw6AZ2baMlPLsr3wnbMraJUoJUeQ7jzDtU1Nl5eEndDSb5UIm3AvwaA5RSC3dT
	Ypy7xmMTJlVENC8d2m159dkClouWJOjypzZJSLPcJJp3ckapyQQTpo5pZHivAKfx
	k6E5TF41tHNhEWUQkqV9tzOUfYRy5mZDNgWHZYlQ12cy/1lgFjkgUKEniUbgAoYO
	Va5GRHQaSZmy1B0i1FBlXg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x87dagd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 19:30:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492J6iAW028402;
	Wed, 2 Oct 2024 19:30:34 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2040.outbound.protection.outlook.com [104.47.74.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889gymv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 19:30:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C3EAzi7ksEYba1wUzrwGVVSVFpjra3varI7kPU+Zprzh6kQe9CwrSc+z34W0Sj/QYsfKFl1uRc/6bTW8BAQCCRg0vit4GI8GJAepCDrfqVVI3LaDzRJPn4HVLFfbjzaTM2jtbfxwXv6evjd/HDYxmBe9hWlSD9hae9rL8Ng2qQxCI+2grPChBK6CsSgMRstCgGCYMC2IRxtEC0WWmJ34u0Pqg1EFfQG2GJ2CO3WHNhmQowEJhGTtopoPpr3q6ADX+1RBEGXTLAVuktTS+7tVOz6oP1E+1skyi4VrJhWhpO6UO3Ng3mh+cAAQqex+tFhJApFjaNunOseVahlKrz7YpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0lYnz5pnC2IqkjfTcE/7nmgn+wrEeeoI33UW2FOFSyA=;
 b=tQvbA7r/SuoCK5vz3HYunLe8vL3/+jEW8JZeiar1me1uojRR312QQeGOt2xpFSWsCuiuYebhb4CeXHsCqpm7lEBcnrUzdtZFxQJWbPejmNNykOcnSwtjr56+016s323UjTGaHakkRiDi0aAY8jx6PmO0RLEoXZCvt1JDcgTQZOYuQlLjGtbuNT25MTtuK9EQmsQD2eHzXxocB4C0w4mTfteQ8FlTJR65x/EJqz2++9EnCDnPhLHzqI262EKH7JLmXZOm1vFVF5878IfpNR6yIm9y+v7ceodOszzIPW5yNrGrLowo7YLCErbCtJ4DaQ1rfIJMB29vtLXVR7ypjrIZNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0lYnz5pnC2IqkjfTcE/7nmgn+wrEeeoI33UW2FOFSyA=;
 b=Hyjzeo0r0kUsE6ac4WSQNR++ezYbbz4vyaOuPyp0hLrIVZowfPzxmIa6RE5bYaO6OBcAIwWYfOg0fpfMwBSXmAB5bFXKRIkTZ9RI3/Zn5o6nIWhxzuBQ4B3HxiCWi8vA13h2lhN8WGe4CDC8cKlqwjgA2K5AbnocQKkRYvm0JTw=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DS0PR10MB6773.namprd10.prod.outlook.com (2603:10b6:8:13d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.10; Wed, 2 Oct
 2024 19:30:30 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 19:30:30 +0000
Message-ID: <2dffaf2e-8a27-44bb-8d54-ef4cc0b08dc5@oracle.com>
Date: Wed, 2 Oct 2024 12:30:22 -0700
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
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <9927f9a3-efba-4053-8384-cc69c7949ea6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR04CA0087.namprd04.prod.outlook.com
 (2603:10b6:408:ea::32) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DS0PR10MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: 593ac830-0a15-4fa6-fa6b-08dce318ad1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE9HQmU1c2NxTUtvaWNndTdqMVpkK1lHUDRzQTVEcVB5V3o1dkNCRGpEblVD?=
 =?utf-8?B?czBLanJKbE1YSE9neStscURaUGNjTWtyQjBmTHo1MzBza2o1UjJ4Wlk2eFNk?=
 =?utf-8?B?eGhSQXMwbGN1NGpPTlVTaG4yYzdpRVFvUGl4bUNoYlREWDM4ZCs5VENJTUpt?=
 =?utf-8?B?UndQNllERjVCeWRZenJrd1dhdTU5VGlKOWE5c2ZqQTRYSFM5c25jUm5mYytm?=
 =?utf-8?B?RCtyVjdmejkrYUppTWRLMHVjdWVaMzJSM1RZc29JakJ5RGpYdXl4aVFJVHVa?=
 =?utf-8?B?WmVMVmd2TmhSSXVSMWJDWGxuZkoyekVmVzk2L0JiSUs3K2pQY0V6R215d2ly?=
 =?utf-8?B?WVFkcjErTGkvcGkwMlo3Y1NnSTFMeFliY0VCS2hzSzlkUHZIUGtmcmlCdjd6?=
 =?utf-8?B?cTBCRHRsekJZelVHdjJScXJTUnByZFdyd3hKWWl5WUFkUlRsS0F5U1lIK01O?=
 =?utf-8?B?WEdoaUJVUThGazZ2b1FSbitoeFJ1ejVMNytoKzdVS1Y2a0pDa21ualZkendn?=
 =?utf-8?B?b3Fhd1ZmUVIzZWM4VXJSVnRqRml0UEI2THo5dGZmVUd0anFuVjVJUmVKUFVv?=
 =?utf-8?B?cTJWdk5EYVhHMjgyQkpEKzJSaFJ4YytpZm10MUhHd0xxaEhvcEk2SkpmeVpL?=
 =?utf-8?B?YzVLbEhxZEFzQ056Yk5GVTVqVUQwckJrRlhNOG1pRlVRZDZOTTh2ZDFZRTdM?=
 =?utf-8?B?dEM4c2ZHejM3OWNpbHJHUlh5REZwbHVLSEdid2hXdzJPRzl5b1F6THZ3bmpy?=
 =?utf-8?B?ZW12cllNME5yYkp0QWFHK1pSL2JIcjJicWpvNHNhRjMzQ2lWVFVubWV2a09G?=
 =?utf-8?B?WW8wSW1mTnQvaGlZSGNMU2JNWlVpWDhNTGZJNUZMbERnQnFRZzErMCt2d2xJ?=
 =?utf-8?B?OUd6bWtWKzIzOWhhSzNtOU1CWDBNazJmTVdNcEFYNXVrK3VaYU1IZXlvSDJr?=
 =?utf-8?B?aFFJcXU3d25Gb2dhVjJScUZyZjhzNkxmcUQycENGeFRqQzkvMkthSFdKd1h0?=
 =?utf-8?B?L2xMWENnaXBid2JNZnJOV04rUWVSZnVPN0luWWhkem9VZENlVjNtTFlNN3Q1?=
 =?utf-8?B?QlZUZ0pyTnJJZ01tRHh0NGgrMlZkR3plSWxLYWVnRWd0Z0MwL1NmMTRGQk1H?=
 =?utf-8?B?UkFlTEFWejRpQkhwQlRRd3crUmQvUVdydWdRcGlRLzBsTmlkb1ZpOWdQVW5p?=
 =?utf-8?B?ZEI0dWtJSVk3QUgrS2c5QUwrOVNLb2pNc09CZXBGQXhLYnJjLzNQelIyOE94?=
 =?utf-8?B?SzVLQXNOSjNEODFTOHpUNWZqbzdnWXBETjlVdjZzdGVnVjRqRkZWQ2JFeUtJ?=
 =?utf-8?B?Y2FBc3lqb3d0Q3hNa2VoRzdmSzhJOGZqT29rd0N4ZVZLd2pHNHAxb1FwbGxS?=
 =?utf-8?B?dHhKQTdtU0dlMDF0K0VPME8vTXlzTUtSSnNkcDhYVThySVExVUFlUWlaMmJ5?=
 =?utf-8?B?MUJ0RzFra3BhaHRWaHBwK01YbERCRWRrcS9HbjREL0E0UFJhbjl1bStCL0d2?=
 =?utf-8?B?aWZ6NDBJK2gwK3dWS3Vnd0JrVmh1KzVORWNVVFRDNW1obDdadHJnaTNMV2lT?=
 =?utf-8?B?WkU0Ym5YbHl3ekZESXliWWp4OEx3cUJzeFVhR0c2eWZtOU9lZ3c2eVROVXhG?=
 =?utf-8?B?MWJaNERtKzJFYlh4Y3RXY1BvZWliUWpNOGdqSlNPdFpvdVlrNzBCaitmcFJX?=
 =?utf-8?B?djlHOWpXaXlxajRnR3NmcHNFVitUeHJWMVBQcXJsTUJnTkxXbkNadEh3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dW1Ja2ZxQjQwZ1M2VlJ1aWRKUzY2KzZIZXRiZG53K0VENzNncWxFWTIxR3VU?=
 =?utf-8?B?bEZzeThUSTVmQnl0dGV5VC9wK1Vya0RMSkRTK3lUR094YW5TVWNIOWJuTjRS?=
 =?utf-8?B?eGZxSDN4M1QzS3NqcENnenQxWXhxQU10ZGRiUFlJUGpxMURRQ3RpNGFHaXVI?=
 =?utf-8?B?MU5CeFVIUWZJMW0xRWhsSTNOTXZSWlZTa1B4TDdIbTdkV1AyM2ZqMll2eFV5?=
 =?utf-8?B?Q1U1MzBIZWlPTXpxd0ZQWklmaFpzTHE0RkZVeU8yL0N1aVF5QW0vcCtCWVZp?=
 =?utf-8?B?a0RMQlFkdXRsWDZxd1hOdFhBMDBXazUwVVdOQnZQRlpvalNZZGNZZWFTZnM4?=
 =?utf-8?B?cmtKL1ZLRm5wUTJmZi9GaDJvN2hHbDc5eG54NWlQaDJmZVVXeGs0c3pXbHUx?=
 =?utf-8?B?STBUQllET2Q4RmFQRUlEeVpEQ1grK0VOZWgzYU9BOEQ1YWJjMkl2cldWSVNq?=
 =?utf-8?B?aEpWcDFHT1RPeUtsejF1RmhKR0VabjRCV08va2JpOUFTZUh6elp0d0Y0dHR6?=
 =?utf-8?B?S2xLOUtxdUZwRnFMUG1HTW9mc01XNnF6Y2NEYmV4aDdHOVczelV2R1BWWnp6?=
 =?utf-8?B?NFBVREovUUpqMUxaZ3BqVFJoUUpKZEZpeHA5VngyK2pDZnZydWJPVGxveWp5?=
 =?utf-8?B?TUlJTU44b0h2bGtZY2ZNOXZxL3RLWHZnNU91WHkrRXNQKzN3UWtWOWRFNGQx?=
 =?utf-8?B?RXNhbXpaSjNyTTQ4ZFBWREw5STg3WlVTTnhETWRpWHkyNjBCNWJOcklqNWV6?=
 =?utf-8?B?UHpGU0Z1TTRaWDFoN3Zxd0NkUk80aFFHaEVQSGJLcTBXVXBuRmo3S1JmandH?=
 =?utf-8?B?L1A2eUh3alFQOEFzaE8rV0ZQOXRuRW0xYkVwVFk4Lzh1R3ZZKzg4bmEzckNm?=
 =?utf-8?B?TFRpZG0rVlpSZGhaSXRyOGZRWEM1U2E2NlFrclYyc2lxNkhKSnVESE9HeVJ6?=
 =?utf-8?B?STVBeVRXZzAraktZMGhBdjBnUjdkTUViWk5mazZOMmwvWGpob3c5WHVmNWJQ?=
 =?utf-8?B?VVJobU9zR3pTTmI1bFZSamxISUxiMGhqdndGY05vQUFqeVNES0RtODBMeVhK?=
 =?utf-8?B?VGkrOTNmdTdjZ2xTd0FpMHYvTGZPd2M3alAybERsZCtyZ2MxL21oVytlV25R?=
 =?utf-8?B?SnhNcmlHYVYxRFJmQWkzTFg5MURNeHpqVnkvWDVyZEZKNnYvbXpkZmZuTlNs?=
 =?utf-8?B?eTM2d29rMGtscEowTkFOWUNQT0ZkOFJJL0NIQkpoZnd0WHRFZGs4Z0tLVUZp?=
 =?utf-8?B?N0FwbjFRZFRkbVRLM2pmSjdJWWtqK0lKU0RtemRtNGRzaW9Jc042UFZUOUl1?=
 =?utf-8?B?aHo5U0ovYTJMbGlVMkUwdmFvSDNoUFdvaWtxSTk1M05RdWtuSG41aW56eEwr?=
 =?utf-8?B?NkpLNE5WTjc3REJMMEkreHc2WDBlRSt6UnpiNEYzcHVUYnFRL1I4OVpyRUZw?=
 =?utf-8?B?Q2xiamJvUjBCbHF2SURaSmVZcTFkd3d0M2tBYWM1TDF0c04ybzM2Z21ZUXc0?=
 =?utf-8?B?R3paQkxLL2JLOEZ0VHhReXA4NWxwZnloaGJKUzYrNlJCNjY2eThoalFDN1Ri?=
 =?utf-8?B?L1NicXVESEdtdmw3TzJYN0kvbmlZeGFrTkg2L2ZpZ0VoeGFubnhzODhYcXpi?=
 =?utf-8?B?dnl2bjF6NndTME5IeFdOcXoxS2crcGthTmNaVDdNQ1BTMjRuWXgyb3V1eWd5?=
 =?utf-8?B?d2RmZ0pJRGVVK3ZHcjF4NFlWUTF3STJtZXR4QmcxNk5Jbmh3bVJid0RzbWdT?=
 =?utf-8?B?NGZrR0thd2hMb1M2ak00cmVxTitkTjkvUDZ3K3VTV3BjcHZpTEMvQUxMVjIx?=
 =?utf-8?B?dzA1cGc5Z0NubEtxV2djdzA0dzN2NzljSzd4azkxcGx0QWxOSkdMeXdtRE9N?=
 =?utf-8?B?Z2NXZFJ5WFZsSlA4eGtmRU9mMndmYjh0aXNhclVwY0dzcm11VmZMc1VpT05u?=
 =?utf-8?B?V0huNWNzNDZ6Mk4yL1RXYkhSVG1GRGZWZ0lDSGlobWQ5VnM4U28vbGVlRjRX?=
 =?utf-8?B?UDViRHVJd1dEN2JsNnpZYVdYUG9YcTBJY3lFSnJQYWVQbXFkYno5T1hjTUp0?=
 =?utf-8?B?cjFtOUNWWUhUMGs0cEZISE5Zb1h4UTArNC9CVktsZUFDYTdidHV5V2pPUk1o?=
 =?utf-8?B?em10KzBaVC9BdHo1UUtJRFNLMGovZmpCSXIybyt3bVdQYmptZEoyVERIL0J0?=
 =?utf-8?B?WUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bc585/6pMPk6uGDAL/0P0N/XsU/4iES8Z5uxaui8bAKayRqxwf0tMVbbKEwkM+xZZ3x/Bi8gSbuntf+PUsnFuTS8tufgQBuezm6qBi1/XU1BmLdZlzs0pMQbgFuwTQo40Vok2+aai+i6KPRff3frCIQXjvqfwfVXPuC8igFh1pS8tFsCtGHMIpXknkgQzsOk/FbjMRNRz/+6uoZdf8AtFsV4qxJbfm8JnnRJ1Sl0Ru6VfOEcDFO+9xt5o5f0Z6iJjwK/kHf42sdKXZE5Ejl+7M7w+gq5vd84Xc/PlDLGRt1bx1KarbdN2MD91Jtxbv7TvOQxOxDgEoBHsuGfkFzynd4xdUVUIgJPgz9LRv749CKzCDP/uVzM2qA4Mpzs87KHu9PvIdLmWAHg9wMHeoHwa1Niu2P44qEXxKlaHYDEhovtRDe3QLLRG93Wvv0Lg2m6nMXoHcsxmqhNIOXJTdeautL/w61Xk/IRN/11rC4iXe1WcrMLN5hq82dMFLXx69Ct+Cgew+EWGOOo2lgbQvG+5kYuty+tGGjx3G6joRJtWCEO4Fnolh/yHFi8KikIq2Wx/Zr5q78WxpoZfc6d0ypNjepLwLg7A/6cQcErrYuIeyo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 593ac830-0a15-4fa6-fa6b-08dce318ad1e
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 19:30:30.4958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JwH94R6nYpmmIMTFWT8BGEMiJvvYqj5Q17WPhscMkYGx7bi8c0FHMF9In1dawPXGSYd+U+E6F8qfm4KKBYOGgsSv+SR1/6/xhyos2nRytoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6773
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_19,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020141
X-Proofpoint-GUID: y6NRZak3CVXb5uAjoSyLvLSrcLD6S33K
X-Proofpoint-ORIG-GUID: y6NRZak3CVXb5uAjoSyLvLSrcLD6S33K


On 10/2/24 10:35 AM, Dave Hansen wrote:
> We were just chatting about this on David Rientjes's MM alignment call.
> I thought I'd try to give a little brain
>
> Let's start by thinking about KVM and secondary MMUs.  KVM has a primary
> mm: the QEMU (or whatever) process mm.  The virtualization (EPT/NPT)
> tables get entries that effectively mirror the primary mm page tables
> and constitute a secondary MMU.  If the primary page tables change,
> mmu_notifiers ensure that the changes get reflected into the
> virtualization tables and also that the virtualization paging structure
> caches are flushed.
>
> msharefs is doing something very similar.  But, in the msharefs case,
> the secondary MMUs are actually normal CPU MMUs.  The page tables are
> normal old page tables and the caches are the normal old TLB.  That's
> what makes it so confusing: we have lots of infrastructure for dealing
> with that "stuff" (CPU page tables and TLB), but msharefs has
> short-circuited the infrastructure and it doesn't work any more.
>
> Basically, I think it makes a lot of sense to check what KVM (or another
> mmu_notifier user) is doing and make sure that msharefs is following its
> lead.  For instance, KVM _should_ have the exact same "page free"
> flushing issue where it gets the MMU notifier call but the page may
> still be in the secondary MMU.  I _think_ KVM fixes it with an extra
> page refcount that it takes when it first walks the primary page tables.
>
> But the short of it is that the msharefs host mm represents a "secondary
> MMU".  I don't think it is really that special of an MMU other than the
> fact that it has an mm_struct.


Thanks, Dave. This is helpful. I'll look at what other mmu notifier 
users are doing. This does align with the comments in mmu_notifier.h 
regarding invalidate_range_start/end.


Anthony



