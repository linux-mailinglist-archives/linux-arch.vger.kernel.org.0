Return-Path: <linux-arch+bounces-7781-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0600993555
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 19:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2E82842E5
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 17:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9661DDA13;
	Mon,  7 Oct 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QipP3SSd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zX9Blc4T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C52A2AF00;
	Mon,  7 Oct 2024 17:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728323248; cv=fail; b=Fy3aF//YXFgVkEtpV4cHsEaR/sQuqRo3EC0AmIaCPwsnm8kk+rnpSrxaM2p3BblhAADAYxWbu9ZS8o4kfEfUcdeJ+/4i4tFPq1aK/iUnWtT1Fq0QxTE2HdiawtUX/Bk2J1aWV7ut+pRWLtYjBdhyH7HYxts6rrtRdQLloHErTf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728323248; c=relaxed/simple;
	bh=R41npPnYfWOdzNQPpTuuq1KNQcXzmxGS/o7wCwGRAEM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lvb1DrjxSRMzwK+hSfA2EMOvh7huKJYh8g7aDXdVflg89V2gPtDUo/JuIJm8dTXFCSLf3q04KL2vXyojJqxSU12w6B2+qZWR/Z0INWo8xba7OLYGhxwBDCbDUtZU5RqPEbxWQUYdGdZyP/qPbRvpQ72HDxEldk7PxaGDq55+j2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QipP3SSd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zX9Blc4T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497FMeUu011694;
	Mon, 7 Oct 2024 17:46:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=aCYa5WN/Drs49F0WXujFF2Hvr4XIOt8K3kwwl1u2Z50=; b=
	QipP3SSdbPD/ILcr2bLOvJah1J9ECuCgiB9NoyLYnZsSE+nsT1vjpg01zN3XHaRN
	AtezG2QrWieOzpshfetyrO07zU+r8KwtSRK6JmE6g20mteS7nRpuZsiRnzYn4kpJ
	1M38yAyCU9y6qEDbRDcFUJ0m74rGtIX5z1lAo/2es440P07fhrW4ofh7/mEL8oqu
	zeNCyBaUeUjdFQmuHffXk4dfQJmBU4mkp0/Zj+PiKRmSrhRKjp3mTcv5HNYqh8qj
	70dtfMNZGfb2nSPbRD86PmC+n5IST8q37ndYfBqVCJPSu2oCJO8qi++WjeLlF+jH
	MvnJ3YCerbjK3MqVJjW9lw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pbwg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:46:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497HdPoL012400;
	Mon, 7 Oct 2024 17:46:52 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw63jdf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 17:46:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+QPFD4aFiLe5E9YAWqhuPN65CKovQYED506gtmPtDSVQqYtFbhTwu/Boop7XyEA0dbD9qsi6hrs01YIajKuu6lc3hpHVrSMWnhQm7wFP99VSKH+UJhfxb+F1GyMGYnp53+kDJVTZTYQMnwF+3V+RfZv86PtTN+13guLtvMPCm0sLdQGo0rySjGtqQGA0ru+AKRClHRJZQcr9e5EnwwiARlhAYlzn60fFdJ3XbH866YEg2eB3Dk+6kiCYcZ792fuZs5nVaFLwBmfWCm17IMTMioZGIo6JI0zNMW3u5EVeADl23MzAqo2rN99u9CJQ8Fbcs2OUdrMnPvi+KqqmUG4iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aCYa5WN/Drs49F0WXujFF2Hvr4XIOt8K3kwwl1u2Z50=;
 b=t7ovmLyQCoENycHqxWn6Ap4eu5j6BAqhs7tGvTjoC+zg9/gSVZoj9yXlBse1H9GOqg5NpAlBmNZgDxdnE5uFOzUatBY6zhgK0sh/+H82M3RSWj1owkNqgpBhJih6MRQilsKYjdw7DJ/9UJpDN0yXLywsNYND32R1kwbg+77KNd/d1jpcqx3PIbZqrm51liLkH5IBU7Ix1E9znjDC+7V+sUduhtHDnDJrHkjQnfISUg4Ii9M9o74ckM+PmzoLCGUVz+CfnKhZ3VsCtUXzBnXRjps8pySo7q4GiYeA8yFGf/X9LcC6QfWrBT0qow+sVd/eqalVpnrf/feQMFcdLiIPog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aCYa5WN/Drs49F0WXujFF2Hvr4XIOt8K3kwwl1u2Z50=;
 b=zX9Blc4TiH2WlbSs6XK0SzJAdjAigbnKrnZ6mBPNX4bSFf9amBS7ou14pjDjq7uIWtyWkY073DzNNn0ktQOlCo5JMnj5VW+tgRRTu+bC7Hr9RXkMe8Uld2ay09XFbHaCT44BXW0ypkNvcNNsGGl7bPAisGB9oLnBSpJc82Whs0Q=
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com (2603:10b6:a03:542::22)
 by LV3PR10MB7964.namprd10.prod.outlook.com (2603:10b6:408:215::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 17:46:49 +0000
Received: from SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb]) by SJ2PR10MB7653.namprd10.prod.outlook.com
 ([fe80::47d7:5812:ea42:38bb%5]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 17:46:49 +0000
Message-ID: <c9a7444b-4b3b-4203-9d1d-8b6ded9ac1a9@oracle.com>
Date: Mon, 7 Oct 2024 10:46:41 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/10] mm: create __do_mmap() to take an mm_struct
 * arg
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, david@redhat.com, khalid@kernel.org,
        andreyknvl@gmail.com, dave.hansen@intel.com, luto@kernel.org,
        brauner@kernel.org, arnd@arndb.de, ebiederm@xmission.com,
        catalin.marinas@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, mhiramat@kernel.org,
        rostedt@goodmis.org, vasily.averin@linux.dev, xhao@linux.alibaba.com,
        pcc@google.com, neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-10-anthony.yznaga@oracle.com>
 <sgrdkcwjzoazuqqutzmzlsjo5outzsp5gh7zsn6ur5qvhaslgw@b74envmtrahz>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <sgrdkcwjzoazuqqutzmzlsjo5outzsp5gh7zsn6ur5qvhaslgw@b74envmtrahz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN1PR12CA0021.namprd12.prod.outlook.com
 (2603:10b6:408:e1::26) To SJ2PR10MB7653.namprd10.prod.outlook.com
 (2603:10b6:a03:542::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR10MB7653:EE_|LV3PR10MB7964:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ba7728e-4c8c-4991-026d-08dce6f80500
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZHo3elByaUdqNGFJdDk4SnZVMFFxTldoS1d1eWMzSWZwRXpxNG95ajlpR2wy?=
 =?utf-8?B?OWtWU3dtRDdIV3cyL0FxVUltRHZZUG13MlZkckJEQUhqR2FZUzh4TWtLMVpy?=
 =?utf-8?B?TFV0UmtFZWQrOSs4ZnRYNytMbE50R3BZRGtTK3hwU0JmWHErK25PZnBuSE5M?=
 =?utf-8?B?VnFPVVE1K0pYNUVhMUhCWlEydmtjZHI2VU5QKzl0VnFHWHByL1k4Skp1SlZ5?=
 =?utf-8?B?L2hIU2M4U3Y4R1Nla3o2Y1pneHovSnhXSndmY1VUUUthOG5CVzdTZVE5ZEZX?=
 =?utf-8?B?THkxcnFJbG9kNFcybERhYUFoSklaTjkvUUcyeEZCSDFLS2ZrdjJBM3htME5G?=
 =?utf-8?B?bjkzN01EaFlOVklTYkI1dXVBcStKZyt5ZlhhRXZSSVpXNEV0MTlyNjZsaHBG?=
 =?utf-8?B?ZUdDb1hSZUVwKzVUTS9QUnJOUkZseUY2WlEzODdxTjdzRy9rbEE3Q3kweVNX?=
 =?utf-8?B?N3dnbjBFOEpkZnRJNGpIOHV6M1VJeERmMGJBM0hvb2NDWm9obWN0cEp1bFJV?=
 =?utf-8?B?VHF4N0NTd0t6RWNEb3c2UHJOS2NDZXlDejVQWS9jQ2dtcSswNU54TUtlNFdR?=
 =?utf-8?B?VThQb3NGWFA3djNyaUo5NG82YnU2MHJRZTZwdER6QU1wWUVTMWhGcnlPbmVY?=
 =?utf-8?B?MzdaN2FZc3EyOE11Um9rRHZSMUlSdGk5aTNNMjZSSjNaMXYvTkpuSWhXaGhi?=
 =?utf-8?B?YVJkSGloYUpOWlZDNFBGQ2w3Tjl3a3BSOHd1OHhZbEttY2ZZNi8rQkZsMDRL?=
 =?utf-8?B?cGxONDVzbTNIdFpTT2pjb0puZmNxMGtGUjJ1YVE3cUNnWFVlZjZWNlBEbWZW?=
 =?utf-8?B?YW5SbjlSaVlxT1Y2YlVrT3dGWWZHV0xJKzMwOHJKR2QxS3ZUQXRIRFBCbk5Z?=
 =?utf-8?B?YkpNZVhqSUIyamdPbTY5VjVMb3h1dHZoNVQvL3VwZ1Z5bUphNlRsUlZHQ2Jn?=
 =?utf-8?B?NzBrUFh6aUd2MjdHTlZkMVE3bGRrclJFNXI4VklOcDVRdEQ0Zlg3N1BJYmVQ?=
 =?utf-8?B?L3Q2VUEzd05GTUExakphTUtPWElDVGcyNHZ0WVUxaXdzbm4yZVRwdjl0N0R6?=
 =?utf-8?B?N3J5WmJFTUNZeVhGeVBLQ2gvZHpqOEpScEhsM3JQaThWSkhJelVaTlV6Q255?=
 =?utf-8?B?eHlLK2dWK21jMVlTYk1tQmNzenRnTjNGWmh5U2Ivd0k1WFNFZTBGVVpPcWlq?=
 =?utf-8?B?cHFqSDlZWlQ5RVU4WEl1M1FPRE14UEdzd2ptM1U2b3R0Ymt5VUtqSENmUTFq?=
 =?utf-8?B?QlNZc1BtWDJYQ01GRXpGdi9XTE82dFhlK3hvK0E4UnJ4eFRKYjVSSnZLd2Vq?=
 =?utf-8?B?Mzl3ZUlxZklZbFprRjlUa0s5ZDhWRVJmVVRQalhXTEhWWXQyWWEvVWVCUVZi?=
 =?utf-8?B?cUJNdWRXZU43V05DSkFrTFUvL2FzM3Jkd2VCbXd6WFhqb1VwbEdzS3VtQjgv?=
 =?utf-8?B?KytxMnZwSTN6TzhleHh6Y1pYQ0tBTTNaQjh3eFN0UkswN0QyNkN1ekpJZ1ls?=
 =?utf-8?B?bVV2QWtZaTZBM3E2WDljUVdmNDR4UTJNcU8xZ2wyUW5qL0R4YkJjWnVxKzls?=
 =?utf-8?B?N1EzS3Mrb2hPV25taDJad3ZpRjk1Q0xyd2NPamZieVZCTk02M2JhT1NzWG1X?=
 =?utf-8?B?MHo0eVZETmR6Sk0xMmNtS3p3OXArSGR1TWMrd0NiN1U5VXp0ejB2c2ZJYWlm?=
 =?utf-8?B?a1U5U2tWcFJCUHdHM3c1Rk5wSEdrdlQzMTdrNnhyYVlLaFNVdFNuYjZ3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR10MB7653.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VVc2czlFZERybnh2YUVOR1V0ZkRRQ3AzRXhkUkRRVnBTVHFMNXhlbFlHVEFI?=
 =?utf-8?B?eUUwekUwNGJjZXkvaE1zTjRDQVpQWWY4VUZMa0NCRktlUFlCek1qN2tmekxK?=
 =?utf-8?B?WmpqdVpGdkV1eE1Rc1I5ZE9XQmNUVFRKUkI3TlBGMk5GMHIzNCtkTk1QWFNT?=
 =?utf-8?B?ZGxrWFZmMmFRUEROZWhReWZxa3ZwcnVEcDNrTUYxZXRuRnp5aDhzYUhTdjd1?=
 =?utf-8?B?OUFON1ZVQzA0OEJDOThZc29LS0dEcEFRK1FlclptV2ZKcWQzeTFrMUJ5RGI2?=
 =?utf-8?B?U3hhQ0VqUlZWWm1uY3UxTVhzT3hZdG5XQjUvbFM5d1JqdGtjRXFWWlIzY3ND?=
 =?utf-8?B?YkpNdjA0WUczUy84MlA0bHJLS1BhbGVCdjhjbG5tdU9hcFMvaWNqSEY1TG9L?=
 =?utf-8?B?ajJRMFc4d2paTHdESkpuK0VmbGEwNjNOM2hDekNFYXUvcUFDTEY1MGZsZFZN?=
 =?utf-8?B?Y205QzllUm1IQmJPTVFUbVRvQWhkQnpvNWNrY2M5NEtDOW1zOVppQWR0NXNo?=
 =?utf-8?B?dlF4bldZU3JKN05aYTEzUHE3elo0TU03MEVzNGxqd1BPanVKNHFOTnRVWXVq?=
 =?utf-8?B?Zng2cEdkUHVrZUloQ3ZHV3A2WFlOVW1ueTFjaVAwYXNPTEs1Ym9JUXhEcGgr?=
 =?utf-8?B?OTB1VkNZVkNOVHBWc1ZTVDVFVTdkclk3ell2d2toVFNza3g5Z0FLc0RUSGsz?=
 =?utf-8?B?Rk9SNlBGQ3BxUWdIbExnRjRWdGhYd2xCN3pNeHJrcmM0OTJSZXh0NkhDOEJn?=
 =?utf-8?B?MW9IWFEySzhScXB1Y3ZoVVRVNkljUUpvdjdhWXFSSnc0TTgxWkhGMlVudjE3?=
 =?utf-8?B?MkllaEM1SGhOa0xKem4vdVJOMnpPRFRSRGQwekV3RXg2RUx0aVNJeDV6NTBu?=
 =?utf-8?B?SjdCSWhHcGNPbDJHMHJRSjVGQmpaN3NlZCs4ZTZBZ2pmdVN5TEVQejRUby9N?=
 =?utf-8?B?VWFiQ3lucDJqdENJNERmUkh3Y2JYMS9jdmEzWGFTUUIwbG1IMDV2bWxpOWdI?=
 =?utf-8?B?YVlRblFPbDlqcklLNlYxVTVCb0FvSmxPM0tuRUpsSWpxNERnWVNFWVY5a1Ew?=
 =?utf-8?B?NFgzT0E2UzlUSXdWdDE3K1BNQUtzUlhOc0EzVDRxUW1QRWNoQWdwZGdQclVF?=
 =?utf-8?B?ZlgxZnEzMEVBUXhwdmErTkRhODd4WW80T25haW1ncjdiOEE0bmZTL0RHZFNX?=
 =?utf-8?B?T1JEeTROalFYUVh6QWtsRnBGOVJocTZPbENZQ2RYTUNZeG1wcGUvLzF2R3Vx?=
 =?utf-8?B?WTdOWWFFMXZkRmZPK25GWW1PSkcwVWpkWUY1Wmh5WUt1VkJWSjQ2RWNJUmtX?=
 =?utf-8?B?NXRYMSttaW5iS3V5UmR6YzF5Sk93bFBpQVMwWHJtakJ4b1pQbi8wZmNEK3A4?=
 =?utf-8?B?VFpPeXRleEd6aS9xcU8vUDVYbFZzN1h4ZEtCYTd4R2Fqd2d3MExFbTlLN2p6?=
 =?utf-8?B?SzczbmtTZ0g3aHNYMG8yV01mSHYvckk4MDdqaitlWkJwQmFuc3lOWWNWdWdQ?=
 =?utf-8?B?NUh6N3ZFVytxV3gxQWhySTZCNkNEYmJtOWJzWW83YktHYkFBTGN0UWMwcm04?=
 =?utf-8?B?Q1ZLWlM3THp1enhIV0hFcFVzK2RuZzhaaGdmaTJLOUtZWWQzeWFzTmtxbnBS?=
 =?utf-8?B?dW11MWFrbUtqcG9MMXpRUUNFZjVXenR4eVc3VS9BaDNVK1E3SHZyQVp2YS9X?=
 =?utf-8?B?TjBDN1ZnMVFhV1dSYzVDM1VIVXExajN5QXFyelVRemxSUythZ0dmUmV4bkRw?=
 =?utf-8?B?eUEzSGVnNmdhZVhoS2diWXAzWk8wU2JobVRvYTFBNDVSbUZDUFRyRGRVU3V6?=
 =?utf-8?B?aW02blJkWTRlQVY5S0tRVkZ0bHdhei9SeUcvdTM5ZnhXMkNzSkoyV3VGUzVi?=
 =?utf-8?B?V0dTMzcyVUZlMlRONGtNNEl0MXh3dUNRUzRxbE8zR3VVazl4ei83ZjQ2elBr?=
 =?utf-8?B?YUtBWnhJL25CbDRSdEtkQjhwVXgrS2RmajlCNVMzYkhXanBZbTBDRHg0cnVZ?=
 =?utf-8?B?d2JuOGh5T3h6Z2FLbXRoSnA2dFBQdjRRSlVmLzdrQXpBUkVvNEZWS3lJT1VO?=
 =?utf-8?B?US94aFEyLy9wVUwxSUlyTGc2ekN3dWVIZC9SckpBOEx3NkJYU0xYcllTZEZ3?=
 =?utf-8?B?SUxsSDNpZThTYjEyT3J4eTVYUVpSUHJvZndFaTErV3VmQkhoNnFLbzNYV3ZG?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OmIJlp9NOveKfo5FGevENuKWp749pofumHlOX4okKH9sWyF2ybbfZvxE9+0uXX4v/vJ/T7kt/RWXfb49Dc0hhqiY60/Qx41tSJlkyqkFzjkrtVHX0sXIOUqKCApwKcN6YAGRtSTdBoL7gaWEANM6TNZW2Ac6XcV7nxd9KV9V5PfmqFb7tZPLLqTZfXK3zEPh3rIU2zjy8E9cIPU+jyofdFiE7vOg87yt9wsuAFVeszqlGQn70CPbKnZ4JROAw33pBXre0JR2pzcZjByveSp053y6v3qGb3SWu6f9MfTXtsh8Op2L+/Z7UhLbZJWAyvm1vY2aYK7nDFGFJAP/aEdu9rkrxpHykK9t9SqIKkxuMrkOPuzG/xquJJzLshedcOwh7m+Ua1AuBD6Fx4VllpeDRD9ixy8yqNcHqiNSqelZRQrUhNtSpJu8N/zPMSySRcxTMlsuiRDYMLgRV6AxAEZU4kI1L9igWxT/8A4uZ9D4PTwYY36dOPB71kw6+BkfBmx2WdXZLDsoWwCCiVojI43MCPLRtiH+fzBPGmn0Q6jWeQPpsbLjNa1WNqvdh2z8PC0Jad2+BlhtTq+3wv77GNR24IDDfCvtGgRQl9oAaa195eE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ba7728e-4c8c-4991-026d-08dce6f80500
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR10MB7653.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 17:46:49.1739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ln0com3bw95jwITg/DXLs4pzA0lB9qUyQpfKUrfF+meT3UofmTRKF+SjhJGjAc2vEKatlGNFVIsf7qDglWSQK2v1n5xfOPnB+t8Zsr1dwGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_10,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070123
X-Proofpoint-ORIG-GUID: J2-9mrASXeNoFrQ8Uqk4qWoxHxVgDPkj
X-Proofpoint-GUID: J2-9mrASXeNoFrQ8Uqk4qWoxHxVgDPkj


On 10/7/24 1:44 AM, Kirill A. Shutemov wrote:
> On Tue, Sep 03, 2024 at 04:22:40PM -0700, Anthony Yznaga wrote:
>> In preparation for mapping objects into an mshare region, create
>> __do_mmap() to allow mapping into a specified mm. There are no
>> functional changes otherwise.
>>
>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>> ---
>>   include/linux/mm.h | 18 +++++++++++++++++-
>>   mm/mmap.c          | 12 +++++-------
>>   2 files changed, 22 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 3aa0b3322284..a9afbda73cb0 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3409,11 +3409,27 @@ get_unmapped_area(struct file *file, unsigned long addr, unsigned long len,
>>   
>>   extern unsigned long mmap_region(struct file *file, unsigned long addr,
>>   	unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>> -	struct list_head *uf);
>> +	struct list_head *uf, struct mm_struct *mm);
>> +#ifdef CONFIG_MMU
>> +extern unsigned long __do_mmap(struct file *file, unsigned long addr,
>> +	unsigned long len, unsigned long prot, unsigned long flags,
>> +	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
>> +	struct list_head *uf, struct mm_struct *mm);
>> +static inline unsigned long do_mmap(struct file *file, unsigned long addr,
>> +	unsigned long len, unsigned long prot, unsigned long flags,
>> +	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
>> +	struct list_head *uf)
>> +{
>> +	return __do_mmap(file, addr, len, prot, flags, vm_flags, pgoff,
>> +			 populate, uf, current->mm);
>> +}
>> +#else
>>   extern unsigned long do_mmap(struct file *file, unsigned long addr,
>>   	unsigned long len, unsigned long prot, unsigned long flags,
>>   	vm_flags_t vm_flags, unsigned long pgoff, unsigned long *populate,
>>   	struct list_head *uf);
>> +#endif
>> +
>>   extern int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>>   			 unsigned long start, size_t len, struct list_head *uf,
>>   			 bool unlock);
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index d0dfc85b209b..4112f18e7302 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -1250,15 +1250,14 @@ static inline bool file_mmap_ok(struct file *file, struct inode *inode,
>>   }
>>   
>>   /*
>> - * The caller must write-lock current->mm->mmap_lock.
>> + * The caller must write-lock mm->mmap_lock.
>>    */
>> -unsigned long do_mmap(struct file *file, unsigned long addr,
>> +unsigned long __do_mmap(struct file *file, unsigned long addr,
>>   			unsigned long len, unsigned long prot,
>>   			unsigned long flags, vm_flags_t vm_flags,
>>   			unsigned long pgoff, unsigned long *populate,
>> -			struct list_head *uf)
>> +			struct list_head *uf, struct mm_struct *mm)
> Argument list getting too long. At some point we need to have a struct to
> pass them around.

I'll look into doing that.


Anthony

>
>>   {
>> -	struct mm_struct *mm = current->mm;
>>   	int pkey = 0;
>>   
>>   	*populate = 0;
>> @@ -1465,7 +1464,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
>>   			vm_flags |= VM_NORESERVE;
>>   	}
>>   
>> -	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf);
>> +	addr = mmap_region(file, addr, len, vm_flags, pgoff, uf, mm);
>>   	if (!IS_ERR_VALUE(addr) &&
>>   	    ((vm_flags & VM_LOCKED) ||
>>   	     (flags & (MAP_POPULATE | MAP_NONBLOCK)) == MAP_POPULATE))
>> @@ -2848,9 +2847,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
>>   
>>   unsigned long mmap_region(struct file *file, unsigned long addr,
>>   		unsigned long len, vm_flags_t vm_flags, unsigned long pgoff,
>> -		struct list_head *uf)
>> +		struct list_head *uf, struct mm_struct *mm)
>>   {
>> -	struct mm_struct *mm = current->mm;
>>   	struct vm_area_struct *vma = NULL;
>>   	struct vm_area_struct *next, *prev, *merge;
>>   	pgoff_t pglen = len >> PAGE_SHIFT;
>> -- 
>> 2.43.5
>>

