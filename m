Return-Path: <linux-arch+bounces-7789-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B0C993AA4
	for <lists+linux-arch@lfdr.de>; Tue,  8 Oct 2024 01:05:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 439791C22C9A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 23:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6630517D896;
	Mon,  7 Oct 2024 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d+B5Y/AC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OSuZsdh7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2CF13D8B1;
	Mon,  7 Oct 2024 23:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728342307; cv=fail; b=lyg0dleFtgS576vx6DZ+Hn+wWNf4TUeAHWEvV9fe4tDQAAEjC+h6G4/ycXMHCr2+DAw0ysjhLmLi0UUTcA2TfFDkJfsz/HVpRTHAaAaja0O8kzCax7j6nxTb3VsyMwu/+zwCL4GCC0LB5i2dbEZhzD46X/0X8kMfesUSzxksIR0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728342307; c=relaxed/simple;
	bh=uNIUq6nHUjllsbb/QCsDEOPZn+fjZF5eWIA24JQP/HY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HqpH5/hpyKGwBFeeFvigqk6/7UCmExYjILKEX3p4k7/2f3ajxVePnpzXyqfrcyUEsTG7R9ntE3hYJPW9dKcOMJIT4M40lpSLNbyhW6GkgE7q5zLlzHMLdPhmRIYGySz8sJKQcDV1OSKvK5zBc8Mv8So+AoeyxDbn5XOvyj+OY5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d+B5Y/AC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OSuZsdh7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 497LQSSu015743;
	Mon, 7 Oct 2024 23:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=UyajKQPXrc38BHD1+hR5+EagBSAjePbylHvCdfgAcLY=; b=
	d+B5Y/ACuMRk9u+x/errOk5COOESg+X+VTCzi1ASpilwxVn6g6zpQOBZq5b986Df
	14VabK6Hr91HE9vnjVC48dDkC6tyLbIWA6sCAjEFXc2FslPLfBYDf2s59Jfye3T6
	xt9eyQTbV9CO0k3bmXRsvYd1eUNiRUKfOOLcndXBmusG3hC3aRcj/OGGhsf6fEku
	5CfjKkYdP1+FIW/bZPqrmKHgfg0mDLE5YU0S7D5GYcwnwhvl0zYv8GwS4zMeOND0
	lxC4oTCR88JdaTpLF7KveVeLWltDD2TC68OTNHhki1axbD9vblZXQ3S1zziwZ9p1
	6n/QyIdETyvl/wUEU/4Jtg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42308dmjeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 23:04:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 497KcMpn011420;
	Mon, 7 Oct 2024 23:04:18 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw6dnka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 07 Oct 2024 23:04:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LcF/BDR0EnMGz/6Po/SKtmdWjZ0sqTxI98lGDVZqWdWHAYoSX7u1iOJIj/ieHWeM53Dzc4kHDzOMpETz8U4v11NKdGomdw9g7obZF7M0LtfgFkEoLZbYYT0rbby8YErqXFB6qwVHEi6mIzCadIkCmhud1JJhiGxw1aDoAbmfFN2n0N4l7LOF+JjCEL0NAoYpEfhGOUevUPbkq3jGspX+I/iRxq4XrgKWd7UR6RkLjqknxK2vBcjfEA48uYVq2239x7P+aO2NmBahwX19sjDMarNs/mBsUE17+Y0iL0NJ8WGOyzdVjr4bq9kACR2QO9pqNby6WgqzuqJzblva3mZSaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UyajKQPXrc38BHD1+hR5+EagBSAjePbylHvCdfgAcLY=;
 b=UhLsJShNC1YbAlDm/XtjL5WVZOEcMOXz9bLpDr7ZM0reTAHLO3ItPfCDlIPH8hoAnzmVUcHt/zwQPIUTR4VGbWPYJ4Hu35Lg1RT1w+KxlkL75Yu0nZNp20TNEQ5OFzrMU0CHRKws2o3T0I1twFXJN60h3vVmotGsCCadm8AFqX1hP1LWYaHflDQlTtwES4M3VG+Ce0TW6E+v+eUe267LX+CO0jsn1uu5qc9/++7+GCtirqgG9tfJILyNjfCWnMr+PuVWQ960bYA7fGb83OwAIkcthpdorCLsJF0JWcvga++x5u0Y6RT4qxQMT21fZnJMZr2IdwokY++uvaAABNi+pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UyajKQPXrc38BHD1+hR5+EagBSAjePbylHvCdfgAcLY=;
 b=OSuZsdh7/iSCmyOW5YEyKUoI14xZuT9wGQIsXchx0W6yl6eEqFUq7qqZ8Isc/iOsb6gtz1/bZWfVNX9EAFS0POu74OVO3Gsi1EGsXHjNiRRhNYTyW3BGJist6t041PmVJFIrzyvg/dau46NyRVNQjw/I7dJJZvgj9V3bC/CE5Ic=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by DM3PR10MB7948.namprd10.prod.outlook.com (2603:10b6:8:1af::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Mon, 7 Oct
 2024 23:03:50 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8026.020; Mon, 7 Oct 2024
 23:03:49 +0000
Message-ID: <4ce254ec-8b7c-4a83-8a7f-af6a8963cd09@oracle.com>
Date: Mon, 7 Oct 2024 16:03:33 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/10] mm/mshare: Add vm flag for shared PTEs
To: David Hildenbrand <david@redhat.com>,
        James Houghton <jthoughton@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, markhemm@googlemail.com,
        viro@zeniv.linux.org.uk, khalid@kernel.org, andreyknvl@gmail.com,
        dave.hansen@intel.com, luto@kernel.org, brauner@kernel.org,
        arnd@arndb.de, ebiederm@xmission.com, catalin.marinas@arm.com,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, mhiramat@kernel.org, rostedt@goodmis.org,
        vasily.averin@linux.dev, xhao@linux.alibaba.com, pcc@google.com,
        neilb@suse.de, maz@kernel.org
References: <20240903232241.43995-1-anthony.yznaga@oracle.com>
 <20240903232241.43995-7-anthony.yznaga@oracle.com>
 <CADrL8HV51t44EBKFwXoT-A48miq2TT7w1yjSUFo6uc5WDN=z9A@mail.gmail.com>
 <04c4314e-7958-47bd-8281-23c3e35fc10e@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <04c4314e-7958-47bd-8281-23c3e35fc10e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0433.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a9::6) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|DM3PR10MB7948:EE_
X-MS-Office365-Filtering-Correlation-Id: cd0106b2-7813-449a-adba-08dce7244e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXNVbjNLM3ZWTHMyNU9oaFZjQlkxdkpRQUxRMDFRVGxyOVFmR1d4bVY4UlFl?=
 =?utf-8?B?Qm92dTlaQlFFdjN2UmdaeGxESzUzaXN3UXpBdC9aK1VlWTlBQytyYzFEeXhT?=
 =?utf-8?B?L2FsMExwVjJqQnJ4NG5Fc0lPZy9xcE8wNUFxRW9UYk4xKzh4Y0VoTWc3K0sx?=
 =?utf-8?B?bmFJbGxSY3ZuZ2RNN3lCeE02bHZSRkVsWThJOGEyNGlWeVJTa2prc0E0NEdR?=
 =?utf-8?B?cFU3VFRka2xhNjA5WmNFSmdFM2RIMzU3K21FRTVTem5GR1I5RS9JQUl4MkVL?=
 =?utf-8?B?cnh6alIyZkMyUU15YVFpUVdvRFk1NUlGdFBEUkxMZjVvUnkvejE0TjBEV2RC?=
 =?utf-8?B?OEdieng3NGluSmJhN0thQUpDbnZybWNTSjlGcGx4SGtKeW9xZ28ySTZuSTYw?=
 =?utf-8?B?MVREQXhEc2d2NE81bllqWUJKRVFvK1MyUUk5cGxmUmhleWEreENQY1JyMjJw?=
 =?utf-8?B?L1AxTVE3VmY3V25NL2cvYlVPbWczV3pSTTF4T29GeVRnNWZEMXFraTcrK1VV?=
 =?utf-8?B?d1lCN3RRZXlCVWNKbk5PcitxTkh1YmgrWVljbDYvSlhybk9ZblJzVDhockY2?=
 =?utf-8?B?R3o5V25qZXZHOGRjTEVhYm9WMzRCanlSV1NiVElIalhsV2wwVEoxdUVVUFNv?=
 =?utf-8?B?ZVA2cXd0K2d0TFY2MGo2T3o0MTM1b2pTNmdLRGh2TjYybkdRVzZDQzNHZExJ?=
 =?utf-8?B?ajc0eFQ5OHpMOEtOT2dBc3YrMTcrWWNIOXpZRkZhcUJ2OHZ6T2RIN1NPZVB0?=
 =?utf-8?B?UUpyS0lBU1dFWVF0b2NreWViWGhQU2lubkdxd2cvYVhMbnJ5TzBlNHlCNjNR?=
 =?utf-8?B?OFFsUzlMZ2x4ZnlxMnpOYnVGWE95dzNiYjRzbFZuRG1oYkE3YnFhN2tKRUZq?=
 =?utf-8?B?aGZsbjBPVkt6TGFhdVZLR3laczRxNWNwS09tSXByYWg2djlZM2dtdTlSVC9w?=
 =?utf-8?B?R20wcmxaRXJVK0VXeTRBUEpQcFIyMCtJa2N3MlZUZFlpeU9ZSFBrT2crTUVv?=
 =?utf-8?B?cnord2xMaGwzM28zZGhZTG9GbmtJUmhucTN6OTVROUR2WHMwQjFGRmVpbitZ?=
 =?utf-8?B?a2JhVWNtdTl3OHpac3ZjZENZTGd5OFFjc2NIOTFXenM4NytGc25pS3c2NFVP?=
 =?utf-8?B?c3MwRHBCTVZPRDNUcGZOZHllTFpRMGJxTGlNRUlEdFlFaXAwNU45OCtwTklM?=
 =?utf-8?B?dW5JNnZESHd6bUxzU1pXWnV2YzkvS2h1bjJFUE90Qy9ZSE5RMW52T2hQNHFR?=
 =?utf-8?B?Z0tZSWxjS1NnS2V5ZVZPM2xmZnJEMVZnNEZ0dzM1VWw0dlJ0YVp3bmNZWlp6?=
 =?utf-8?B?Tm9vRnNkWnl6MlV2WmRqUEtFWXFQN1c4L212NVZCV3F1eVZmK2lwVzVWamkv?=
 =?utf-8?B?Ui9OWS9Ta2tpbGxBNk5PY2d3L0o4c1UvVFdBTC9WM0pGbFJlaTUyUVNzNFpt?=
 =?utf-8?B?TnFwYXV3TGZpZGtQL1A0Zm1xallEVXgxazdha2lWUnkvbWhlSjh5RmVNdU5J?=
 =?utf-8?B?TUNVYjd2MnZsWVZzUXEyVCtjTHY5VmlmVzlnUWNOYTFDTzVOMVdaRStuaVdW?=
 =?utf-8?B?YkFPY3FPc0dYMUR5aEo1bjlQaXZkVmhNdzdvdmMxK1RTTW01VWNvNGVyMzN5?=
 =?utf-8?B?bm9PNzlxTldXRzNjeU9BMWExNmxEcko1REFEeUlLU2RaV3Ftb1YwNWtKYW11?=
 =?utf-8?B?cW9kSWdsSlZrNk1za2Eva21CRU0yZmFkWUpCb3BOOEFXZTl5WU5nUVNnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MUhLQmRsbWJkeU1UWWtCVysvelVYeVhoZkh2UmZVeUJ1aGt4YnRDaUcvT0Zl?=
 =?utf-8?B?djh5NFJ6SlNESnZpeXlNQ3U2TGg4eXd2dy9ydHMzTUd6Mm9wZ0dmZDBOS0pn?=
 =?utf-8?B?bS9KN21DU0t4bWQrUlVpd25lQi9WL05xaHhWcTBBcUhKNUMvMTlKRlo3VWta?=
 =?utf-8?B?QUhVYWQ0cVR1VzR4aE9kMzVyZzJlVms1UndxMDZVdlRUbnB4VWZMR0oyWklX?=
 =?utf-8?B?K3BIQnY5ZEVUbm9ITHR1OURSUTRnOTI1alFXZjZQUXFjdVNUVUJCK3lVenhH?=
 =?utf-8?B?U1hmb1FnMGxGMlc5QkVEUXJJTXVLeTU0dC9NNkJVcnVMeG5pdXQxK21XLzR2?=
 =?utf-8?B?MFpsOGJza05oVVA5TlA2MGpNTVFncGM1WUs0RWs1QnhhRGNTSmZyY21QTStD?=
 =?utf-8?B?dlE2VW14M2NRakovdGRTOWJlY2hWNjdKZmsrTG9tbzh2cGdHLzZKczl0cVNR?=
 =?utf-8?B?NEZjYXVET0p6QzZnMERxcHBUMzczcE9JTVFNYjUxY0NWM0tJTVkrMVlHc29a?=
 =?utf-8?B?ZGtkeWlVMmh5K0hDbWhRdVN6RlkzVlRWRCtMVkNOaEpVNjIyYXNPWjFNV2Ro?=
 =?utf-8?B?a2ZCbTljNkh4T0dVRHVwVTNpWTdSYXZjVTcwMll5dHFUMEw1TTFMbWVIUEE3?=
 =?utf-8?B?UWVscWYrT0ZPeENpWHdMWmU0N09oRkxXTmZIakVYV0pLY3hRTk5pcE9rVmVC?=
 =?utf-8?B?dVlRc1l3SE1zWkxKeXVUVkp5dXdyOXFEaFZoWm1SM0Q3aDRQZGVaMGdKN2Zv?=
 =?utf-8?B?eDlSZWRQWEYzcENCYXRGbGd4VkpnTWVMQ2pQY2RwcFl0QmxsaS9keGN0RWtz?=
 =?utf-8?B?eUJLemIzQ01ZaDBYM0NwWkkvUE1LRjBoL1FSR0N4MDJzeGJCVEZTTWMwQnQ5?=
 =?utf-8?B?OEJ5YmpyY0tzNEhnZnowLzZHMVR6Mk9FNVkxeHhiSkZrZjBtY0tQd3ZSQXpK?=
 =?utf-8?B?WEJLRGhuTy9INGFIWFBjbVJ2OFMweUVaSms0TGtDUXVtMCtsOFNpc3AyM2sr?=
 =?utf-8?B?WTdzbVpZY1N3Tk5rTUE3bnVNUWFIdklsNkRiZ0ZxNytGZmJCYURJZ3NOS2Fs?=
 =?utf-8?B?ekZzQm9NZzlubXNHeDVMNDJXTDhmVGo1cnhaSjBMMTJWV08xcXVKVkJIcy9H?=
 =?utf-8?B?eVNNa1hSTzZpR2t0ckV3YUxFZm13RXI5aXhqR296K21TcnJJRWRIcVJhL2U0?=
 =?utf-8?B?Y1JoUE5FS2RhaVhTbXFwSTBHcU9DaTFWTFdQUncyTytJTUtBUlU3OVdBQ0k0?=
 =?utf-8?B?NjJCZXI3RHZBUzFsajZ0RWEyLzlRZmNBWDE3M0dkSkN4bStLd3VGMkQ0alYz?=
 =?utf-8?B?UFJUZkUra0VDZWhxRDBRd20wSVF2Ym1MYWRiWHo2MzZrUllwcm5ScGFzOEor?=
 =?utf-8?B?eHJqRmwrQ2R5YklqemlXN2x2RnpoK1VKbUpuc1o0Qnd0UFNwa0xTdE1TVkc5?=
 =?utf-8?B?L1ZBRHFsOU5pKzhLQWpyWk9kMTc1Rkw2S0RLWmxRMkFMcHFlSC85R0hLWEhQ?=
 =?utf-8?B?blZSTnlmeTMvUXpnZEgwZ0tEcHpEanBHalF3eVJ1Ti85Z0o1Sy95ckFJRnQ2?=
 =?utf-8?B?Ujc0QlpHWWlCeGFWNVRjWGlHNEhKNDVwMzBQQnI0Q29uSzJXVytiWEprYjNj?=
 =?utf-8?B?eGt1UWRMSDVkNDVjN3UwRGhBem8xTUF3VE5EaGVWUmVndW1ZYWFUYTBHdVEv?=
 =?utf-8?B?WTl3Nll5T3pUd0RhbHNJZUxyWUw3VGlzK0c1U2RYekx2bVZrSy93dG1ReC94?=
 =?utf-8?B?MVFNYXREdXkwRzFRVytEcWl0VnlaazZqVVJXanBQajZhOTBzVUEzUjBnVVlY?=
 =?utf-8?B?cndqc0pFUE1Md2Q5bWhLU1Z0NUJPRWJjMm5HdkRaMjJFUDhHYXU0emF3Y1RV?=
 =?utf-8?B?S004TW1wSEF3YkluVGlnOHh3L3ZzZ0tEcWR3T2FGNGY0V2lLNk5qUWZBOGc3?=
 =?utf-8?B?eStvUkRDMk9RR09XaEhaOGpOM0NQVC9ucmFwcFhPWk1Baml4VlpsUmNyYkdD?=
 =?utf-8?B?UnBuVW13bG5CSlZBd0JoK29IN3ZPVE1JbG0zVlBxemEwMEJlRXc3RUhqcEpl?=
 =?utf-8?B?UzJaTS9wNkd0aE1oeVBERkZEQy9zRFA2VEt5M1RIOEpvbkxxeHJ2eFB1cXhh?=
 =?utf-8?B?K3JXb0VCQ1FkYVlCb24zeTgzRHNHV0oxM00zYmVPQWlvTnNUNkVvRENDUUVL?=
 =?utf-8?B?WHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fjmyxBHgiIo2wy+tRRvUHN7CVACzxiXFkFEJnW+u2LfHAwDnc3xtAi1V+FyHt6kE9anwl8tiBXpLqOnN9X5Kqg1uSFndlY76CGUjVJRLleiXSXz/dhiPXc3CE+xxUXN1cQ26YwaI1E2/WvOfDDQxccTLtQYDwZhBa/w3chLZamBSqWZjp/lTGpr/e2cbufaYDOrmlM0BhiCzYmtM9mYT46d+5VgbPLbWS/6ZJqM3oiNQq+oPzYPqtcy1pZ4dwJ+cXMhHyv5GPdrHWKlFZ43ZvL952hc8Oa9QwDe7DhwK7EIBxhbMPXFnqs7jyO5pHv0TiFFlkoBGj+dqh0w8rIe6QNJ/bxV+MSHBrCgkDeOrkWct3DcC9mmvKtq6C5dB2z2gFyXNWTmCyeLRSERhz9ClMtMoJZfm62Ri+xYM0w67BhSOz0w2DGQtZlJV9jpsmdo7A0QFv0mhWG2plk9aS7EgQ7F6BxrsBtbrNWypMD+a7ZupjxQLuqfLRvofH4plXASVwvifAOZSh/Ss/zgiPB0p2dakldPycCdYediTsluHok0Oa8CmCJsb6620OA60RBjIgU/L49qHZhT+fGabKI7Rbx3jo5zuhZUTIxYcSoJJczU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0106b2-7813-449a-adba-08dce7244e24
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2024 23:03:49.8722
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KhYrmcSG6+EsawqvyaGVFFOEBuP8JFIkWIgHPXMpLSN8CJ4+lzrn/9vOZC2qUwBq80ydQeH1bwkj1szw6sz8zVdhaPZNuQbdPEB9bdK/HWo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR10MB7948
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-07_14,2024-10-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0 mlxscore=0
 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410070159
X-Proofpoint-ORIG-GUID: oygoW40B9YorCFHfyE0kUvube0jR8cHg
X-Proofpoint-GUID: oygoW40B9YorCFHfyE0kUvube0jR8cHg


On 10/7/24 3:24 AM, David Hildenbrand wrote:
> On 04.09.24 01:40, James Houghton wrote:
>> On Tue, Sep 3, 2024 at 4:23 PM Anthony Yznaga 
>> <anthony.yznaga@oracle.com> wrote:
>>>
>>> From: Khalid Aziz <khalid@kernel.org>
>>>
>>> Add a bit to vm_flags to indicate a vma shares PTEs with others. Add
>>> a function to determine if a vma shares PTEs by checking this flag.
>>> This is to be used to find the shared page table entries on page fault
>>> for vmas sharing PTEs.
>>>
>>> Signed-off-by: Khalid Aziz <khalid@kernel.org>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> Signed-off-by: Anthony Yznaga <anthony.yznaga@oracle.com>
>>> ---
>>>   include/linux/mm.h             | 7 +++++++
>>>   include/trace/events/mmflags.h | 3 +++
>>>   mm/internal.h                  | 5 +++++
>>>   3 files changed, 15 insertions(+)
>>>
>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>> index 6549d0979b28..3aa0b3322284 100644
>>> --- a/include/linux/mm.h
>>> +++ b/include/linux/mm.h
>>> @@ -413,6 +413,13 @@ extern unsigned int kobjsize(const void *objp);
>>>   #define VM_DROPPABLE           VM_NONE
>>>   #endif
>>>
>>> +#ifdef CONFIG_64BIT
>>> +#define VM_SHARED_PT_BIT       41
>>> +#define VM_SHARED_PT           BIT(VM_SHARED_PT_BIT)
>>> +#else
>>> +#define VM_SHARED_PT           VM_NONE
>>> +#endif
>>> +
>>>   #ifdef CONFIG_64BIT
>>>   /* VM is sealed, in vm_flags */
>>>   #define VM_SEALED      _BITUL(63)
>>> diff --git a/include/trace/events/mmflags.h 
>>> b/include/trace/events/mmflags.h
>>> index b63d211bd141..e1ae1e60d086 100644
>>> --- a/include/trace/events/mmflags.h
>>> +++ b/include/trace/events/mmflags.h
>>> @@ -167,8 +167,10 @@ IF_HAVE_PG_ARCH_X(arch_3)
>>>
>>>   #ifdef CONFIG_64BIT
>>>   # define IF_HAVE_VM_DROPPABLE(flag, name) {flag, name},
>>> +# define IF_HAVE_VM_SHARED_PT(flag, name) {flag, name},
>>>   #else
>>>   # define IF_HAVE_VM_DROPPABLE(flag, name)
>>> +# define IF_HAVE_VM_SHARED_PT(flag, name)
>>>   #endif
>>>
>>>   #define __def_vmaflag_names \
>>> @@ -204,6 +206,7 @@ IF_HAVE_VM_SOFTDIRTY(VM_SOFTDIRTY, 
>>> "softdirty"     )               \
>>>          {VM_HUGEPAGE,                   "hugepage" },              \
>>>          {VM_NOHUGEPAGE,                 "nohugepage" },              \
>>>   IF_HAVE_VM_DROPPABLE(VM_DROPPABLE,     "droppable" )               \
>>> +IF_HAVE_VM_SHARED_PT(VM_SHARED_PT,     "sharedpt" )               \
>>>          {VM_MERGEABLE,                  "mergeable" }               \
>>>
>>>   #define show_vma_flags(flags) \
>>> diff --git a/mm/internal.h b/mm/internal.h
>>> index b4d86436565b..8005d5956b6e 100644
>>> --- a/mm/internal.h
>>> +++ b/mm/internal.h
>>> @@ -1578,4 +1578,9 @@ void unlink_file_vma_batch_init(struct 
>>> unlink_vma_file_batch *);
>>>   void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, 
>>> struct vm_area_struct *);
>>>   void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
>>>
>>
>> Hi Anthony,
>>
>> I'm really excited to see this series on the mailing list again! :) I
>> won't have time to review this series in too much detail, but I hope
>> something like it gets merged eventually.
>>
>>> +static inline bool vma_is_shared(const struct vm_area_struct *vma)
>>> +{
>>> +       return VM_SHARED_PT && (vma->vm_flags & VM_SHARED_PT);
>>> +}
>>
>> Tiny comment - I find vma_is_shared() to be a bit of a confusing name,
>> especially given how vma_is_shared_maywrite() is defined. (Sorry if
>> this has already been discussed before.)
>>
>> How about vma_is_shared_pt()?
>
> vma_is_mshare() ? ;)

vma_is_vmas()? :-D


>
> The whole "shared PT / shared PTE" is a bit misleading IMHO and a bit 
> too dominant in the series. Yes, we're sharing PTEs/page tables, but 
> the main point is that a single mshare VMA might cover multiple 
> different VMAs (in a different process).
>
> I would describe mshare VMAs as being something that shares page 
> tables with another MM, BUT, also that the VMA is a container and what 
> exactly the *actual* VMAs in there are (including holes), only the 
> owner knows.
>
> E.g., is_vm_hugetlb_page() might be *false* for an mshare VMA, but 
> there might be hugetlb folios mapped into the page tables, described 
> by a is_vm_hugetlb_page() VMA in the owner MM.
>
> So again, it's not just "sharing page tables".

Understood. I'm okay with something like vma_is_mshare() or some other 
shorthand for a "container" VMA. And I recognize that I need to identify 
which code paths need to be enlightened to container VMAs and which 
should expect to be operating on a real VMA or don't care.


Anthony


