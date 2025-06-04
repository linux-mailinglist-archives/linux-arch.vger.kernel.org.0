Return-Path: <linux-arch+bounces-12211-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D9BACDEE7
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 15:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 984573A70CD
	for <lists+linux-arch@lfdr.de>; Wed,  4 Jun 2025 13:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D21828FAA7;
	Wed,  4 Jun 2025 13:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sU5LoTKE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G+VFtrHZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757CC28FA90;
	Wed,  4 Jun 2025 13:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749043293; cv=fail; b=GfKL20bJ4125XJJV+InPkOJBd+QGDOWbJAbvQAwx9iXGHloXdYT/FrKdS7XT7FXJcm5BzxKQt8+lWrzEH6U+ebQPpa88gYAHdQRAcfQwQIfDuzKnzgyG8DfhrbnhU++5Xabc5uOf1IE82pX1rw37zFiQpLd9d7QAz8jNdOHR4pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749043293; c=relaxed/simple;
	bh=KkmSFiCTgenWevT8VxkpVlwEtwV3eCQXfFr4f7DM2hU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oD7lY9f6DkxZMfdzwaJJJQejMrDqgnGXyXtCxuUiWDg1WtCj+PiDznOMHhd7dyfKhRiyE94NSqp+qwN3JGsv3LcrCWgyXA9YBtgghrWgtnVpBWws+QnMkfeqmht99GrvoEczh6Ea8U+h/nopZW+YDufWqXCnGqzdxQ7mVgb/HZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sU5LoTKE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G+VFtrHZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5549MddY025560;
	Wed, 4 Jun 2025 13:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=KkmSFiCTgenWevT8VxkpVlwEtwV3eCQXfFr4f7DM2hU=; b=
	sU5LoTKEw9PN9UAlfNSQ15AmCpylys3MuCnlJwo6uJ4ML/IHQ0Tnde9R6FCSScjK
	NA1syQrE8BR8comFOr4rBJRK1aKG9+WbLx4ps08j3y2QU3ZJRQMA+nJ/AM85h0TJ
	HcZ5Adw0UVnKH6zzDhI1Ga2DGg5+qv4m2kilSVKgwWS0tpmv/UFk7ZEzv51y3V3O
	yWJXCNrG/+0O3sQRpb+pATzljewBb66+OoG6ZuoHmFbwa5Xpr6qJkbtpA2gViLml
	Ggr04xaj2fr1v2sf3gg1fjj2pgYuZHN2qQfsOKJYGV4uHtKgRJpPh3JL6C7nugYm
	LZR20rSXqzDL8SG+hkBgZg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471gahc264-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:21:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 554Bh7Fi030694;
	Wed, 4 Jun 2025 13:21:05 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr7arhhf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 04 Jun 2025 13:21:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KW12k67BAgGpAx6BvomfZHIbPfRoBpp3yfXCiBrqFt8o49ZakomgfAfGQjk0lSGgwWwSuHymizZXjB8zfILXCU9fqRhx/nGI2wq6v8TqwImJNyNfCOrON8dD5TOy5lQxtFFc1eopsZAmOAmGbhHE3uY089BFLILMV7pAy9/7/vS280S4+rppd/qhJgE2nrztZs1v2CduHDmIbUMjDjNpfOaCtI1X281qeRG0noJUlb+h9d1vyss7gO2x/g45AR+ZgR1aE5w6csChJLTd6qZD/jkkXDp9OIi3eZu966fater0JIZ2ka0SI6wjix0dad4kTDQZmi9/m9LRBjcs0QVFxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KkmSFiCTgenWevT8VxkpVlwEtwV3eCQXfFr4f7DM2hU=;
 b=yI0IueQHIrIHFHEpQzV+qkx4UzGVpmVa33l5/5uaqV6ta+23Z8zxEwycJRtbj194BbXJLpLpuLIAwBs2SRu+Uep9qQjaAKjkidNzt0SSVbk9iMTXcoE6as30IbX77v+b9R8rjLX2ySdoMoh29rtr0fEvQXA7lT0L6owwGup5Px5G2OhBFvfA1dT/szoaReXuc2xfTxwzASvIRl6GwqGqBskJXhg69HbwfIzX1l9BB9pAr4wbCazPQYNLmJ0SIkYFEL131s5zTjGNr/fHIM99gD/em7eBKIC283GWwVuu1iOblUn48OHKiR2f1HBpcGjCrP7hVgIew8epsFQztbTCiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KkmSFiCTgenWevT8VxkpVlwEtwV3eCQXfFr4f7DM2hU=;
 b=G+VFtrHZlhb5c9xJH0rWBY2uZjQQ8TQs8akQl17v1jtfOChb04yvAPgQrjfWkfc2H9GBqI7K7jfPwsXwvOjeCZO7/PWAGDi3ZPcsKL2auwTVUKoHMB4y5mF/xQ9y5wfj7xCc3cix1tz8MjyfSCSZga9TibKjUnbrv74LlSDpt6U=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by PH7PR10MB7012.namprd10.prod.outlook.com (2603:10b6:510:272::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.40; Wed, 4 Jun
 2025 13:21:02 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8792.034; Wed, 4 Jun 2025
 13:21:02 +0000
Message-ID: <615e0c5d-b516-49cd-907b-5b14dbeefb1c@oracle.com>
Date: Wed, 4 Jun 2025 18:50:50 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH hyperv-next v3 01/15] Documentation: hyperv: Confidential
 VMBus
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de, bp@alien8.de,
        corbet@lwn.net, dave.hansen@linux.intel.com, decui@microsoft.com,
        haiyangz@microsoft.com, hpa@zytor.com, kys@microsoft.com,
        mingo@redhat.com, mhklinux@outlook.com, tglx@linutronix.de,
        wei.liu@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc: apais@microsoft.com, benhill@microsoft.com, bperkins@microsoft.com,
        sunilmut@microsoft.com
References: <20250604004341.7194-1-romank@linux.microsoft.com>
 <20250604004341.7194-2-romank@linux.microsoft.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250604004341.7194-2-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2P153CA0008.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::19) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|PH7PR10MB7012:EE_
X-MS-Office365-Filtering-Correlation-Id: 5294aee6-cebc-4496-8e37-08dda36aa72a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGptUTQ4VElCMkZLQlJDWU5wUjJuQkdKbEVOYWZoS0dtSjhoaFZDOW1UeVFP?=
 =?utf-8?B?TU9EZ1BsallTcnlTUVAyNW1vWis2Y1hCamwwRS9QYldSTnV4aHBaWDhFYnhE?=
 =?utf-8?B?SnBUekdvS0RWKy82aTBzZ0NMVzNuZmRGanA2aEdyUU15YWZVSVVQR0h1S1FH?=
 =?utf-8?B?dmlPbFE5S1BOazVURGppWVNuZ0tsUmJXSnRpVlgvYmUxK2NRQTJlOHNzMjlU?=
 =?utf-8?B?MUdHakdOMExnRWdtdE1nYm1aVCszOTFobThTeENYcm1lYnVNcXZJTHNITUZz?=
 =?utf-8?B?Q1RHazBnNjBTcTRXMVBaQ0pOQ0hReHYwckhjN2gyZ1ZTTFZCb3I3Q1dqNWtX?=
 =?utf-8?B?SytwcTlYTWYzVWxRZGl3UFdkV3I5Yi9DNkRvWGRzaUhyTEp2Z01mSmNJUVJG?=
 =?utf-8?B?dkZRVHI4b0Vlbzg4RDlLZVJFVUFnL2dFaC8yM2xtN1VUcm9WbWc4WmNidGps?=
 =?utf-8?B?WVIrL2J6MThxb1p6Nk1FWUZQRWtEM3F5NTY2Vi8zZ0NZUHh2aUx0UStLS1Z6?=
 =?utf-8?B?cE5SS2pLWEp3NlNQQU9KNE02RlJqSXk2ZnNRdWNydDY3WTkweVlDcDBDdWdi?=
 =?utf-8?B?RGJ5WDBCNzIwU1pSdXZHeFhSQ282SndienVQaGZ0Z0hYQmV4eUVHVzYwMkVl?=
 =?utf-8?B?U3Fod0dmKzJOVFZjYmxKWDEvdEI4bUJEV1VaZEk3WlE4OFBxTVgydnZMT0lK?=
 =?utf-8?B?TTZXd1FMZFIzTkdFcnplVGdXc0J2MW03ZG5XUEZ0NE1jNi82Sm9EWnZjWXFP?=
 =?utf-8?B?bDRBWGJXbUIxQkgybll3N3B4STNPanJiVENVRUpjNW0yNG1vVktQeHVLc2VP?=
 =?utf-8?B?cktSbzVCcC82SVByRGx0T25QNHJnZUh5OXkwdEJHUmVodUpHQXBmeGt3VGpS?=
 =?utf-8?B?VktvaThrb3Y0MFdwVXJuTmNBT3dpYmFKZmFyY2Q0N3ZKOXRFcktEYkVWc0g3?=
 =?utf-8?B?Sk9tT2ZKaWFhWU5CVVc4VjZZZ2g4YmNNelljMWlqWnFJaklnSWZNTXlXUUFQ?=
 =?utf-8?B?cjNHdVl6YzdETlJ4TWRJS0xnN3lNMnl6VnIzbXl6c1BtYWk4Y1YvdERZWFcv?=
 =?utf-8?B?OFh0bUpzRHhDOS9IbE9rdE5TdDY4MGpuZ1drak91Q2YzL3RXbkp4a2lyN1Ji?=
 =?utf-8?B?c2tUN3A4TG5aTGZ2SytoRlI4Sm1LSEJobFBFSEN4MzB6Rlp0M3lhVzZzQzlH?=
 =?utf-8?B?RXdMbHRjNi9UbEhSWGcrQ0NWQUQ0WFFzc1RhRHdReTNvNXVSVXVhNDRLeFhx?=
 =?utf-8?B?NmI0YlJyOGJFS3V5b3NrZnJ1ZTJCOVh4VVp0K3F4cURxM056NW9VWkFqc1JS?=
 =?utf-8?B?ZFoyYm5EaCtjRGhWbjVyYUVUSG5WMG1KZzZHeThNN1VUOTlTZzFURjZCc2U0?=
 =?utf-8?B?aWdNeEo0RUwxbGNJdW1XTFNLeTZCdlhTRjRFYXNVZ2RCcnZkbWVuYnJBQk1B?=
 =?utf-8?B?dUZoYS8wdmJBZUVIRkFsWGNUSEp3WC9Qc0lOSFZsYWpaWXc0aHNwTzVjY3My?=
 =?utf-8?B?anFRdCtBVnRlRGd4RVhkaTl1M0doZGlVcWtjRDFiZzM2RmpXMHdhbTloSUFS?=
 =?utf-8?B?ay9PVjIyUU9Jb2RTTUVoRDcxZUZjeWdCVDhpOGpYRjZKZTFudG5YQmVYSFZm?=
 =?utf-8?B?OGVWYVZEOXhUemdSVjk2Y1NsSTZHeEFONnVGbE1NL20yb0Y0VTB0SkNEeEla?=
 =?utf-8?B?bnRUS29jZTVQdWx6c0Y5M251RU1mdTZwRG8rWjhLMkpFTGRaK0t5MEFHRDJy?=
 =?utf-8?B?OFNWWkh2a24rZGNEdENQR0lxNE5SSlFlS0s4dFZBeEY2RlRNdk12UFh0OTBJ?=
 =?utf-8?B?UW5KVGI5U3NpRGpTUjhoV1VwTE56YXJySlJxNVRIRWxUajdrSWJEZHQxMHI3?=
 =?utf-8?B?RXg3OGZ3cHhyNFkzeVZpSlJ6MWVZbldUaHA0b003Z3JEZ21IS0NLeUU4MHY2?=
 =?utf-8?B?TkswRm9tWGFmTWZSSnNBa0Ztdi9ta3pDVyt6SUF2OGwwb1JPTkx3YTRQdVdL?=
 =?utf-8?B?d3FnNVVjOGJnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXFoelF4ZmRYOHNOWmJSek0rRFlTakNFeVNEOWRIT1QvVGN6cE1ZUlE2bFNp?=
 =?utf-8?B?cTZoTjhtV0Z5UmZQeGJpNWpuR1BXZ2M0RFVMS3Z6dXJhVlF3WDJqSlE0TTJ5?=
 =?utf-8?B?QkdjMkNXU0F1ajR2TXhoWkQxSVJLNEJLcitWWlFkbkZBUHJCM3N6Rnp3cXN6?=
 =?utf-8?B?MTdLWVZBaG95eForZmxXYnpWOVNKMko4VkZxK1pFU3d4TnlncWcyQWhRUnRq?=
 =?utf-8?B?VnhEdVlRbVROQ3BOdUhqVWs2SFVhYjN1U3RrTjdiblhEOWdKQjVFUmRyTFBT?=
 =?utf-8?B?dWhidHIyWkV4WkZqQ0dDbzFHbDhjMDhHOG5aMTIxL250WnZyWWE5eDhiczRG?=
 =?utf-8?B?NDliUlVBOVdtV1pxQWloWkhDbUdKZlFDWEhLdENRcWtoL3piUlU1MlNaZk5U?=
 =?utf-8?B?WWZVQzlnSXJ3eFNFYXUrKzZpMjBkS2pJeWZNTzZsc2ZmOVJCdlZCVnZ6U1l4?=
 =?utf-8?B?MTVyblBRRnM0d1VsS3RWMy9HdFo3TDRtajh5SVVZN0JVOCtKTncyL25mRXd4?=
 =?utf-8?B?dHJ5VVlBME9GRGhCRkl0K1Y2NGJEY2hkL3BGOEduVzNUeGdhK2Mwb2VTWTFp?=
 =?utf-8?B?eCtjb0V2ZE11UjFsOUlHY3VoZjd3RlNBRU44UW9UN2kwbVNJR0hOVTI0TVgw?=
 =?utf-8?B?bmVpSHlNWVBhY0xpbjkySkpKYU1MQUZveWgwS2RJUkJYZUo5dk5VbUtCNndJ?=
 =?utf-8?B?eTBLeGRMc1hJaERlbDM1K2J2ZWZ6VmJ4UExFTVNyMlVsNExsSXNXSER5SEtG?=
 =?utf-8?B?SHVXNkMzTVRERVZmTGY4eDZkQ05Yc3RBYURZRytvbXRLWndxQ2lJS1d5NWJT?=
 =?utf-8?B?YjZqYmJ0N1dXclM3UlN5dnM0eE1mdGw2bGZYdXJpRXZ5RlF6THBzTkUzTk1T?=
 =?utf-8?B?eFM4OEFkV2VDa2NyU2dRRGtVbkR0aDFuSEJHL2lZZFNIcVRHMndNL2R0eFMz?=
 =?utf-8?B?UVhrWUxOSHh3UHdQcFQ2MGNqaXF5TXA5UWI4M20yMktNM1BldnBwV2tJZi9K?=
 =?utf-8?B?a0Z1K0NnNlZBWnNobVJaVSsyL3l0anRpWlVyT0w2SUJuZmFDcFNFSFNQVUJx?=
 =?utf-8?B?WElIdnNzVVA4SkN1R2lKb1RwNk5EYm5MZGE4cGJMa3NUd3F5NXpBZWZsUi9m?=
 =?utf-8?B?LzBUV0cyMFFLZ0lXYVNlR3YrTmp0V3hodnduUityenVpOS91dWh1MFhIRDFw?=
 =?utf-8?B?OXl0ZGdSRG1uZXVpZ2d3c3ZqdktsTEZiaVB0eW9GZkRIMzRydGhmRCtMbEky?=
 =?utf-8?B?ckFCSGhwajUwTjZQM3BPUzY4VnlvdXk5NkFITDlBelFnTW1EckRvWnlXSGRR?=
 =?utf-8?B?OENHa1NKUWJYS1IzUWw4a0dNN2xxU3hDZUFDU2IzZFdKVTFPY1BLYW5sQldp?=
 =?utf-8?B?dGFnUE5CZXlCeVVVSE1jdE9qWnU5SEZJb2pFK3J0R3RaMkhUcUpJUERKQkpq?=
 =?utf-8?B?eUcrblFoZnBRZUFhV3dCdmRvdUsxcGVhYWJxcjE1cmFJYS9PUWpGSW1ja1My?=
 =?utf-8?B?MlNLYlNXTmk0OEhuQTZmT2lPbjBkbFNMdXdKY21BeXBKYlhPWVdOdjhQR2RY?=
 =?utf-8?B?MWQvMWVLdjNJb0VoeFRpQzVIL21YaEY1RkhiTk1nZ0JyUnF5Sjl5RFFHODBw?=
 =?utf-8?B?TlNXZWVUZks4eENBaFcvbi9hQ1NVbHpsSUpJZGVRUHlmY0puU0NhY2pIdWpJ?=
 =?utf-8?B?Szh6Q09kR1Jhcm1MUlFoS0cvcnNLSVJsS0xTUFdRT0cyTXA1cWVkb1hnVnkr?=
 =?utf-8?B?WFo5UFQxMjFwYVZQbVdCY2hPRldHalpFVEtmSjhsSkhXNEF4eVRrQi8zYUVN?=
 =?utf-8?B?ODF5U3NOd1JldWpvOW1RSm9BUDNndjROVnhZcE15Mk8zSis1WHBnaVBMcXl0?=
 =?utf-8?B?eXo4aWhSQ1d2eDh0WStxaThtbnd2aHVYV2d6UkpzclpJQ2xGRG01bWdlNkFi?=
 =?utf-8?B?d2g5OFY3QXBlVHNzRkJzZ09LUW45NGJ2Y2lsNHlOU0VrK3FyaGxWZVZCWlFh?=
 =?utf-8?B?TTFnQkVnbndRSmxwL0d2QTJjVE81eVdpZHczbDBFMnY0WVlPYXY2ODlodVdp?=
 =?utf-8?B?b21xbkkrUmZqTmRhTzRvRi9xVlZxclpDYjRTZHZldE5SR1RhcUdSZU15RUNY?=
 =?utf-8?B?SjBSTUVRRGFyNnR4d3M4TjRSNTR3TXVNdDRGZkJZQ0dHOEl3VFF6aVFVTDBX?=
 =?utf-8?B?V2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EGKLkahqzm9saxhDRdPMX9l5AGp/6PL+hti9GcZrEEJ9Vri8px7rU71YfZKOwdtBf7VLQX8KZklVXjHA4TZ76H9EXnfFNV41P3Dcwtb1L7i0TWokVrRhYwRrmRwVmA5pI1mxi2MGJ9knjbJ+ERit5gjNST+To8QrgnhqMyQN1FKYcOW3zhotZCy5/tuyVs1Jjb5vmKt0K5SH6jmBAMayuRft0JuLCGEWrkHDbvPyWFK6aJOksZ9BxrXs2/JYdOff1heeeRnAiRUBvJEwsCd3cKPkn+ojQAQFlzf7p1gJSxkAYtXUNaQ5iqpNtdpkWDMjwhY4JPAa5t3bic2IBDu4iTCoG4BlnwqDzxjf3ab11aZPhl/QrVWrRrFJYZGULqApx1tRC//AnYlkm6nV2te46bcLjva0hJEktRRLhAcHa9R9LXyUsFx1JmTR6MOxPN4E1k712y83+fUsknM7ceF/kYk0wQSLBMmvS62HZKpRJPq1xYeydpb4uVUL5v03lIeN/DMXfbJCqTzm5quJi7vfx11hMzFAEm2R1Eygvu5UD5mGKXKOTI7DgWG7he4kyxjxMcEINVOsQhe/v9QL6jOzi+xaq5vSYo2Vea1p7O2VNuU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5294aee6-cebc-4496-8e37-08dda36aa72a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2025 13:21:02.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oPd47JerjbHRW9HndBfvQKQBsiGc2Hl6AFIv36LxgkDRAYvunddhdaetYzsqhJIThgGHasL7HK9RArDKLW4q6/m5S5o0oY51Fnfy8W31cg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7012
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-04_03,2025-06-03_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 phishscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506040101
X-Authority-Analysis: v=2.4 cv=aqqyCTZV c=1 sm=1 tr=0 ts=68404842 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=qq2Dt-ZFRj5JlzehINwA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: T0SYQjVTo2m6lTFtEUETnqSQKJj_oOw-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA0MDEwMSBTYWx0ZWRfX8kUEwu1Dwu3I OMyCOoK6+elXW6p3epPmb8yWF0D1K/IfvqxUdbvzLcIQ7C51wqsyC0kbfZg6NrnykT4PhkD3SBB CRj4pkJcC4oBojK+d/3Y5pPv7+0sx+x+k3nCifsnagBXm7WeIpQThGHYI6EyLjCCP2ZFWRo217C
 Jx33zH2PUMd8ylj+sTgH3/ph5VBYOJYBomxF6UeVgzZaKmuMyXC57gNQotaMWiVV4QLLpB3Mk8W TnAiaNIIOifkQFTalt0PxUH859lxUACJ7+YPodIBxqZ7x1YbbSRbTi7Tom06VGJpZ9TSa6K7E08 8wymSBSltXRm2fWbfktm21xHUb1zOM0WSP9hJo9ArfoURHbmjxWZZ/muV07GHRJs14hzblgSZaO
 upyFOx9C/F59ayqo3pVwDlGdMNg6z1PrytDVzzPncr40knDpgtDBcWM6JIJbZM6VRzNXduJI
X-Proofpoint-ORIG-GUID: T0SYQjVTo2m6lTFtEUETnqSQKJj_oOw-



On 04-06-2025 06:13, Roman Kisel wrote:
> +Confidential VMBus is an extension of Confidential Computing (CoCo) VMs
> +(a.k.a. "Isolated" VMs in Hyper-V terminology). Without Confidential VMBus,
> +guest VMBus device drivers (the "VSC"s in VMBus terminology) communicate
> +with VMBus servers (the VSPs) running on the Hyper-V host. The
> +communication must be through memory that has been decrypted so the
> +host can access it. With Confidential VMBus, one or more of the VSPs reside
> +in the trusted paravisor layer in the guest VM. Since the paravisor layer also
> +operates in encrypted memory, the memory used for communication with
> +such VSPs does not need to be decrypted and thereby exposed to the
> +Hyper-V host. The paravisor is responsible for communicating securely
> +with the Hyper-V host as necessary. In some cases (e.g. time synchonization,

Typo synchonization -> synchronization

> +key-value pairs exchange) the unencrypted data doesn't need to be communicated
> +with the host at all, and a conventional VMBus connection suffices.



Thanks,
Alok

