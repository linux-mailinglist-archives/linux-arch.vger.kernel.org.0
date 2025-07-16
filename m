Return-Path: <linux-arch+bounces-12820-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C15B07B69
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D35F01C26919
	for <lists+linux-arch@lfdr.de>; Wed, 16 Jul 2025 16:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B6A2F5475;
	Wed, 16 Jul 2025 16:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OQRTSVUb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YoEIlM4/"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87001A5B9E;
	Wed, 16 Jul 2025 16:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752684208; cv=fail; b=kDOIf39/wkpGV4L2ER6tjHOtqoe9kM8kq4N8lzfSmB/4ym+7waAV/h7U2NDGm1NIycyFS/qqosra21IXwe2oHBH5V4Wy1j30vcJD14ednYUHlFtGMl3s3PilxFIN9zmZOVk5OzMzOKFOAMVQoRIDUVFjnvv5wz04Ihn1Alf4zx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752684208; c=relaxed/simple;
	bh=fFOsJFG3M6rTx4z2MjB2TqfmNMbHgtdBkI985GT3BHY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qSh6jFCwNdHeTyk1mGBkAVVUejNl8CC3UZO+LNujwbqrjDk1HpESUX9UooCFa4c4I+XltKiHqaPesUGeoyTKiO2l4PQtRreLsfP7HkNak02SefZrpRwcj0sa9PkH60NLqh8YBotjwLR6Y8bKZR+A3Y5ZJuGVNgCLtBhp1oQR5CY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OQRTSVUb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YoEIlM4/; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56GFqv4A028281;
	Wed, 16 Jul 2025 16:42:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Bk3xu5AskxRpIjIBxP+GyeqFVPRdlzy4iups0dg1OsY=; b=
	OQRTSVUb5aEXDdkxtMIpwtL/L/gpp1iCirI900c0xKAuJX40cLqGIRuWaa/4cT0a
	ydJN6EdppZ0B5aTImyxPGSA8iwBlb1caBNwliA0X2nOksJn5jLrHjIE069tKDLGf
	0ho8u60+vvZ55EuDQ/tjFdnH+3kcKwbNZ26mw6KNPcr/EoRVeaAFjsxmBBIpbG6/
	8gtrGP2mNvSkaorHHABoFrDymVVJHx2V8B//By4pRA2WV0+E6h+bTpGuMnFYkPgJ
	gaiq5ROAAxXaBLgHxUgisGS1ZHPWOe+/vz3deOsx8ELiQClGoX6R23dtIP9Vbsbn
	Yfr7nc+RtWm3ooO6O/PHlA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjf9u7y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 16:42:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56GF6hXq011697;
	Wed, 16 Jul 2025 16:42:56 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2085.outbound.protection.outlook.com [40.107.236.85])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5bkfnr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Jul 2025 16:42:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R3UbByUlcZVD271i4+xHO2nr2CfmRbbIl9T6x6GjMCYHfZC26nGzGP8AQpVZujxerwhJQWwZVvcPfW77jQxiBlJ7UGs11FxAhTMFqlh4NB0yck1Bg8oGBBzSGdoRERO3g+NEFvu+9e5JaW/8MPmpZH+sUMDkdhWTMPdV0j5w0Bn+J0jl/rDMJHv91iHJPQOKAZ7hnm2dur5E4aHbsK/j7RHAFgeuchqOjh24a8nZeMcA/FuqeiCeSy7eca7ryjw9n+yJg0GXmVsw5WfhNK2duzn8JnCeEYsbY14uzHxMwgj23FS2VcC4xZAQbb9BmrrqQKps7H+oYIabwDPmu4RlJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk3xu5AskxRpIjIBxP+GyeqFVPRdlzy4iups0dg1OsY=;
 b=KEIZYcw10yO+ZIygNkLJUoCFQh0oGhaIy2WZWuu2evjCtd0yBIPWdUEEHTdaOqakrbsMDDhtvjJYg0Y4A4PhhOl7L4deS/WzhIicoi/mA3BRwC242ZEQtyt61oste85wXmUIRhFIUgVSuVPMBLAct8PNgA/cn3ChIqTauuLT2V6+5e4H5KtVFp4mbsbjYKInr6cmWDYAXejiYg2szaJN5/p9Rk1PpqRGSTjdXu3pPLKOLZaVBDzZieWzw+p6gW1nCimmq2VooDJNs7WUnqJFyE/Zd49GU9c2E0OXtukIL4NjQJPkbu0yOIXhl+xJtXTvzI7oCuSnTBkHxoTbOc9nDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk3xu5AskxRpIjIBxP+GyeqFVPRdlzy4iups0dg1OsY=;
 b=YoEIlM4/2fzceP2SfvnlVij16A5XvFWgeEqarsDG+YAatFOYuQvzC8E1jpfEXYVt+d6nBx7jPOlz+FuobCMkH83ZXpEQY74DnMNHGcByYDgKFVQk87Y6a/s9wvp9qr9H8O1kbHTUE0+4VTrRyvflrfvGKkQn6skkNhtlKeQvWFY=
Received: from MW6PR10MB7660.namprd10.prod.outlook.com (2603:10b6:303:24b::12)
 by SJ5PPFC2FD05DC0.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7c8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Wed, 16 Jul
 2025 16:42:53 +0000
Received: from MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15]) by MW6PR10MB7660.namprd10.prod.outlook.com
 ([fe80::41fa:92d3:28b9:2a15%7]) with mapi id 15.20.8901.028; Wed, 16 Jul 2025
 16:42:53 +0000
Message-ID: <bc3fc8e9-2841-450c-8c61-f3575715939b@oracle.com>
Date: Wed, 16 Jul 2025 09:42:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] sparc64: remove hugetlb_free_pgd_range()
To: David Hildenbrand <david@redhat.com>, davem@davemloft.net,
        andreas@gaisler.com, arnd@arndb.de, muchun.song@linux.dev,
        osalvador@suse.de, akpm@linux-foundation.org,
        lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com
Cc: linux-mm@kvack.org, sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexghiti@rivosinc.com,
        agordeev@linux.ibm.com, anshuman.khandual@arm.com,
        christophe.leroy@csgroup.eu, ryan.roberts@arm.com, will@kernel.org
References: <20250716012611.10369-1-anthony.yznaga@oracle.com>
 <20250716012611.10369-2-anthony.yznaga@oracle.com>
 <13d1fe66-9f34-47d3-b174-516ffb706aa1@redhat.com>
Content-Language: en-US
From: Anthony Yznaga <anthony.yznaga@oracle.com>
In-Reply-To: <13d1fe66-9f34-47d3-b174-516ffb706aa1@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7P220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::27) To MW6PR10MB7660.namprd10.prod.outlook.com
 (2603:10b6:303:24b::12)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7660:EE_|SJ5PPFC2FD05DC0:EE_
X-MS-Office365-Filtering-Correlation-Id: 7397dd8a-6866-48b4-696f-08ddc487cf6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cjlidG5xM2ZQdVREM2lweGdjNUptUVMrUFU0d3FlVFp5TVBUMHh6RHFBSW45?=
 =?utf-8?B?b3VsYkJTWnI2b09NMDg2b2IvL28wT2lsSUd6a1ROemVzdUlpTU42WFRiYTg2?=
 =?utf-8?B?dEVtQVFCYTlGWkg5U2RNUWZKMnI0RU9FNDVBSmpDWFpkaXlGcitJMURpUVhq?=
 =?utf-8?B?WTBnZ3Y5cnYxY3FaVG1oSDNnRklJdHQ0cVpybExWUlREcjRBVllnUXhKRExU?=
 =?utf-8?B?ODNNcDNHQTZMVnN1QkpDVStVUmVJSVk5Y1JrVHZNUitZWUlkSVJpVjNYYmZK?=
 =?utf-8?B?UzdUeFZpNUtQcGhOLzlCZFdwQ0ZNN0lzQ2g4Rm81YXp1d2lYUmY0Z0dCaFd6?=
 =?utf-8?B?UVhVUlg4dzE3eExjVVJ5VVd3OHBiWWdLdWtRRks5RXlIbnN4OUtvNkIrU3NE?=
 =?utf-8?B?V0VqN3BwS0RNTkg5UDFuT2NkeG96TlJzTHFYKzVLSDZQN1hWR3RqaS96ZUFo?=
 =?utf-8?B?U2FsWSt6MnJYVmRBWHQxaEx3Tkc3M1llMUFaYjQwbXRWcU1nSkF6TS9vUGVU?=
 =?utf-8?B?aU9xUUhxTTBDSG9MZnJaRGVENWRuZkswUE1wYjNXVWdkNk9OTGQ3UnZ0QnZS?=
 =?utf-8?B?SVN0OE00SHI1UDdQQjJjOHlGVGFHeHl4dmhZeUJ0R2xzYkxMMzI2Q1UyV3Q2?=
 =?utf-8?B?UmpabFMyTzdaUTJGRWxzWDNKaGFsTFdoYW14RHlzbVRkVjIvN1FrL3FJSG9C?=
 =?utf-8?B?QURjOWltYmhXZENWRDNOT1RnZ0NtdlVGTXdXNDQ5QU1Eb05Udzgwem9CaXFk?=
 =?utf-8?B?ZnNOQzBoUmk0Wk5UNlhVaG9FRXViTjdrTHlqOW9NM2NJTVNRRGJBaU13bjhQ?=
 =?utf-8?B?Qm1US2h6a3hsNzBzbGVYYlFQSUo1WlQwMkRoUjRqay9ud2F1V1c5RFVleHhB?=
 =?utf-8?B?dUpzMHEzNDl5MTNOWWZGZkFCL0ptVVh5c3Iwb0JlYW1YVThWc1JiWmE3b0k5?=
 =?utf-8?B?ak5FVXpCODZlYjl4MVdJSGNJZVNUaTlmdDg4Tm9FcnY4aWtUZlpGU2ZCcUlK?=
 =?utf-8?B?aUVxZ1NYSUJ6Zjg2elluQjlHN0t4L2N1TlhMOUd2TDFqbVVBY0tzdnV3cVZJ?=
 =?utf-8?B?TjBVUEZjTUxOTitBdHVPdGc3Y2xVNlhTUzl2dFZqaG9pM25wTWtrUkU3N1JB?=
 =?utf-8?B?R0E5S2lUVmpkMnlRYklJblN6RTYzT0psb0lPczZmOUN2VllGbHVRYWR3eFp1?=
 =?utf-8?B?UGdvbUZyeEN1QjFpTzdoVk5WSlFRNkYyVjR5Q01pc01XQUhyRGRXaE9XNUZq?=
 =?utf-8?B?NkNLcXVGSHNQYXozdUNoNUI1UmVVT3JDdHB6bHo2TUhRQklYcFVEd2pOYXov?=
 =?utf-8?B?TXpvTTNlL1d3RTNWSUtNMHJoSXdXUWE2bUlLWWNwRk1lS0VwaC9kYk9FNjR1?=
 =?utf-8?B?ZFFnaGdXYUN1RTR4RHFqOUJyUXZoOFlhME5qZS9HaHhRczl1YVVxQkVYRERj?=
 =?utf-8?B?LzFQMVhYbjVrS0NzMGFDYnNkQklHT0JqaUd2ZkZQd3NvN1JWWjIzYlRSQ0xO?=
 =?utf-8?B?RTh6Vjdza3BLUEZaTllvY3NuWjVwdXlVUlp4V3BhWW5rdVMxdTU2QmFPdlV5?=
 =?utf-8?B?eGdHSkRpWDBOWTFreE1BVlRpenRyT2wxN3RZUzRLck9Zb1FwTUU4MlJrZTVD?=
 =?utf-8?B?VlVYQ0EycXEydHZwd2pPclIxcGo4OFhLYTkrdThKa3RZaEYyK2VFME5lcERL?=
 =?utf-8?B?cVY2b01XUlJ1ejcrVFhDVGJZN1VGOHV6KysrR3I4dk9HZjFROTRabUY3NWtu?=
 =?utf-8?B?SndFc1ZQWEUrcmJvNmltektmM2UxelM4MXpHb0twbm1xSytsNEVIR3hhN1hy?=
 =?utf-8?B?THhzVWdBTzF4R2R2SnFCakNBeVJtREo3cVdwV2VwTXZXNFI2Z25KVk1IRXY4?=
 =?utf-8?B?eG1zcVVHN2F0YnQ5R1RHSVdJMlRkdHhGRmJuWGpwcFRHTGdib0lxWGlSWTAv?=
 =?utf-8?B?NHBWUEl3c25DVmY5OGpIcklHY1lQczZIQWhET3lGRGFuMnAzZDVwR3VaSmdI?=
 =?utf-8?B?NyszQWhydnlRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7660.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VXl6MDkwdlpaYTA2SFpMMjhmK1g4a3J2eUQ3cHZxT0FldXVhOXR5cGtseU1Z?=
 =?utf-8?B?RnhwK3dPWFRiZXpzMXNlRWhhU1VCc0g4aEljNEpDUUVQcFBIb2R2dk9IZ1cy?=
 =?utf-8?B?bmdRMUY5UjBMMm1rU0NDMjB4QkpaU0IzY09qaFJqeDNCNEM0WEE0QlRZZElw?=
 =?utf-8?B?WmQrclRydW9pTzQzQlk0N2tZS1p2ZFE0N3hEaklVTGVwdTVjQ0w3SWtRT0k0?=
 =?utf-8?B?MEZLTy8vRC9tbEIzZC9lSHdTOTNwdSs4Z2M5QVdqQSthbmhWdGkvemNlOTFp?=
 =?utf-8?B?NDlqVXZobWNWempsancycjVOTmFMQk8xaTh0dlZVU2RDVjAwUGQyYW5JUVN5?=
 =?utf-8?B?eHQxbldZUDhjdFZ0aDl1Qkl6Mk5HZWxsc0R2L21mVWtoaDFUdEY3ZktTak9S?=
 =?utf-8?B?YmQvcUhWM0J2Y3NFY1MxRDBkZWpadm1qZjYxY3dMbVhTYmVUWU1YcHFYR21y?=
 =?utf-8?B?c2pjNFVFOEI0TWRReGtlaE1pckR6NzV5ZGhwTnM2TFNpQnlwdmRDMUt1R09j?=
 =?utf-8?B?R3BaV2RLWjd0SGxnWThaZGZYbzZkY1ovOWNrWVVXM0dZWmRBZTJ4TWpSUEI5?=
 =?utf-8?B?bHV6ZGcyZWVOTFBsTjJ0NHcxdWVKak1SQVhMYm1ZdjZLWklPYWsyVXcrSjRi?=
 =?utf-8?B?bWZGclRiOW45NklpYUw5amxZNVV2dmxOeVhDTzEwQm5GVDhQZnZVWjZjcjJ6?=
 =?utf-8?B?OGFITnNDLzZEZXpzNXJJYTRSR25vSzYzUWZYTVF4SzBXL0E2MTBkM0treDRa?=
 =?utf-8?B?SDVjOWo0dVBBY0FkQmdBRDdsYmJ2ak9qWXlrS2dxdkVrNENRTFdVTVBXMlRZ?=
 =?utf-8?B?RlVMQXlEUzZ1S0J6bVhuWFU3emhkMCtXY3dLcjh6TUMrUzV6bGJZTDlPMndN?=
 =?utf-8?B?NFIxalAxMndJVW1oa01YRDlNVGRsb1VsQ0JXQStLT3BGa1ZvZ2R2ZEFIemN6?=
 =?utf-8?B?RzNkeW5rTzM3TE5VRy96YUY2YkdPSEV4U1ZwbGdRZjhGa1pzQUVHMEZyTkM5?=
 =?utf-8?B?UXRPK3F1cnJYTUw5d2x1b3pYODNVVThhNTIzLy92QjVkM3daQmlPSnJZNktZ?=
 =?utf-8?B?Q2xvSndsa1JXa3hIdUw2KzFNTHJkcU15ZGJZWnEvRUIvRngwWnluTlROSVBv?=
 =?utf-8?B?L3NzOHNJajUyS1ZsR0Y5ZXdVSW1hOXRpYUpFV0lVYWNtdVRDTTFidGNyRWcy?=
 =?utf-8?B?ZXA4Wjc5dHQ2V0draklmMnVKV3dkaXpucXJIdGQ1MUpXRnJza25SVG16dlJI?=
 =?utf-8?B?SFNsYnZlckdyb2RLNXhtTVpTUjV1VmUrcjVORlFYZWQ1TUxUdlBiYUVtMDJa?=
 =?utf-8?B?RDdjejRKSXBmc3FLOUhTcUtMRWxrUGkrdjdNQ1ltTll6Z21YSWs4NDl6S3pT?=
 =?utf-8?B?S3hrbDZiWjF3NUIxdEQ3aHY2RlZhVjEwK3g4WWFFODMySFpydTBFVXJFWGlO?=
 =?utf-8?B?OEJIN2dxMEZwTnAwVVQ5aU0vNVhlN0E1cE9Da0l2Y0Vya24vSXg0UEhuMTBw?=
 =?utf-8?B?Y3RUTkpGT2Z0ZkEyMXg2alBKRU5LUnFqWHJNdHVRTzA0TkRIbkVXTnd2UnY0?=
 =?utf-8?B?WWw2eXFBOUtiSFRiSDkzVTFMZGdpb3c2ZDVTejRnRFdLMEJUZGo4SkJqUklz?=
 =?utf-8?B?YkxKOGJFcUhORzI3MmIvK1A5bVJ5QVVzTzRYWnNkWHFWMytTUjJyZUtBSFpz?=
 =?utf-8?B?bS82d0Z6UUVieVBQcUR3emlQSTYyUFdzYk1ET2VaVzRUV1VIcmxWbk1Kdk50?=
 =?utf-8?B?RVJ1RW8yUkhhdVMrWHU1amgySjRGUW9SSnVCUTR6WDB3dzJpOE5BemtkdEVW?=
 =?utf-8?B?QUlSaTlnL0pXM0ZHMHl5Y0M4UkU0eTc3WTdkUlpmZUh6VHN5Zy93alJrMTll?=
 =?utf-8?B?dDFsLytqcWJIelpMM0U5eUpaN2dCMm1PMVVHZnprakhpM0FtSUJ0TEVaekxG?=
 =?utf-8?B?cUtKa08wWk1CSUNzNXZYd3I0KzNwbE44R2RQdnNSTDY3bDFhNHNUeW1TSmZT?=
 =?utf-8?B?ZTBPbWsyVkF0THZXZG9PVG50YkdyR0RjdWNNVHliZnIwV2xzTVlnMnI1N3o2?=
 =?utf-8?B?Q0FBc2dqY09KWlRBblBGZWk1dnk2R3BKdmQ3ckcyR2xKSGJpdlgveWNPR0hv?=
 =?utf-8?B?dnVJWUY3MmorUEJmK0tHM0EvdVVpR2wvWVNPUy9MdzUvZmlrd2V5bzYxYnBK?=
 =?utf-8?B?VGc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8jkkABcd5cN4Ma6S/daNzfUTjXHurDxq6o1gicSjn0GxvLK0a51BLA0SMBILUwcIl/xQ5LtpTh71Y58C7NYzPlmWylciUbyxi27bVG08f2nkOvQWVxN68B4+76NRtx7tIZ01Lhse1Gwc5i7kgnh4XY1Mx5+p800CONLhBj31Rg/YLlA/3REIFFRmNRoPr+GkJzgK61tUj1+9zhF83umDcpaSxokWoL1rdU0bo/fIn+KSSunsPh9F5+l6RDBt7gPYT1zQKfSiqpPfHDjfAdNRWY9XuMF0mZMPjWaqbOey+fBM2VYqIJ2ZLOEydJ2I6s8NmBaxvI4xTEFWnDJsGKVg2AMzi3AhcpBWBtHmKJt435ZNyUexFhfOKGJ1MwIUu2c+hgOvgQL3gwp3FmGa9XoMAbV+cLbhkQBPeGhRvueA2IwPZrziIQr12OoiLlsVYtY5WmmETeEHG/H5DE7fYc4LWESIP/ZzKuiDr6rV3PM+Wg5a+0Cd0ph58VsjaOx+ENJflk924VJQENgCi3AO2hzO7klBpleZ5vv4xwLm0ofTnOTMUgYiGRcUP+u8m20Ym6kor8cq5Q4g+kP4mUIuUkOFiIt7CrQJYqhb9zNMjI/KTJw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7397dd8a-6866-48b4-696f-08ddc487cf6c
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7660.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 16:42:53.8114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XbWw3d/eDWH3XwgqfojcLAWS/pk68PW2ZYzEpsbxqYtuXalwgNu9EZdjbh8uWJyFLvVZsL5KMXQmJw/yCgl+BtbNKKQxbKPl583GZDcK/K8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFC2FD05DC0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-16_02,2025-07-16_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507160150
X-Proofpoint-GUID: fE54Wytfa2wxZfdurqpKBKbEXZqmd5UE
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=6877d691 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=8L12U35sHoCaTwOUg3wA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12062
X-Proofpoint-ORIG-GUID: fE54Wytfa2wxZfdurqpKBKbEXZqmd5UE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE2MDE1MSBTYWx0ZWRfX2mG+gdx7WRnh XgkPpjMOrkw60CY6Mg+COXfsnxv+E5JMFRSO/f7I2gBEssgWPAyXvrchwRI+u42E3E9lapgU8Ak fhDdSlQ/qEEdYx2LVk042XXggTI/FzVV+OWdXGHOJo4UyoJ+Mt94jdZugOgCg2rg2TwIPUTU/xd
 2IaRy34aeqqMcDFtJ6XS+83TXR323VSRIv27yjowCjT/JIyFL93Sj+d8grqoXugHuxsd2zDMRaT BoI161fETnimrNiyYZZQnX4/zgWYu31UzszehzRqHadJJ0lLTKmEUN+1xjwyyULsciAvi1Cfl4N LJ50onDpRaHz72X/yehl2Y5qr/fjmUoFY5V5ivVfJh5De0IoKoktsuMR7mPby/DU2lpbCvPm5Mt
 TtwZQ7z2hR0FeTc29J4RRKtAPmD4DZ3cQM3C9tzs0vqcvTZxVebQXb9mjySu8gNUJN3hEru2



On 7/16/25 1:20 AM, David Hildenbrand wrote:
> On 16.07.25 03:26, Anthony Yznaga wrote:
>> The sparc implementation of hugetlb_free_pgd_range() is identical
>> to free_pgd_range() with the exception of checking for and skipping
>> possible leaf entries at the PUD and PMD levels.
> 
> And the pgd loop was optimized out, because probably not applicable.
> 
>> These checks are
>> unnecessary because any huge pages have been freed and their PTEs
>> cleared by the time page tables needed to map them are freed.
> 
> Do we know why that handling was added in the first place, and why it no 
> longer applies?

The PMD handling was added by 7bc3777ca19c (sparc64: Trim page tables 
for 8M hugepages). The only clue is that the commit message has the 
sentence, "Also, when freeing page table for 8M hugepage backed region, 
make sure we don't try to access non-existent PTE level." I'd guess that 
it was something left over from development that snuck in. The patch is 
changing from storing 1024 PTEs at the PTE level for an 8M hugetlb page 
to storing a single PMD entry.

> 
> These is_hugetlb_pmd/is_hugetlb_pud are rather weird on the code path.
> 
> Looks like a very nice cleanup.
> 


