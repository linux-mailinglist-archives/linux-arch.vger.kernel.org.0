Return-Path: <linux-arch+bounces-8125-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2669F99DA59
	for <lists+linux-arch@lfdr.de>; Tue, 15 Oct 2024 01:53:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D57BB21AE9
	for <lists+linux-arch@lfdr.de>; Mon, 14 Oct 2024 23:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9A91D5AA8;
	Mon, 14 Oct 2024 23:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F337vosV"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2053.outbound.protection.outlook.com [40.107.237.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F4C231C94;
	Mon, 14 Oct 2024 23:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949997; cv=fail; b=kTz7/7GIWICiT2i2TVA560gBVe7vgXhGJcKl7rvRTHm2eymJKuoGkt+jnRSfdhNHQYj2eG0gjzqBmqkKp7tzU+wJfIcSf7A644wXpEssEMYDFpdEQEzDYzGaN9gk2cZR9UUYtG9o7jyUoDgor7jq1ndWnyHeYH55S/c2+BlNQMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949997; c=relaxed/simple;
	bh=r40H+R6Xpjg3uwFld4S2mhK6KEC3dnbuHQcnbznOrZQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i2fbj8G74B8ZNpwt5tcGzQ30q/CDZ7KTaCd/kOPstSykL6x12+kYuJ/FV71fDD/fsl6Iayz2Vx3JYqxQ6sAGhM2g/tZEJYoq54l5F+aRx2TduuFhFtVFLN0le9H9GLHeAh31rku9Z8hC8mY/FX4nd6D9sY21pDBgotWyWa075pU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F337vosV; arc=fail smtp.client-ip=40.107.237.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJtyKlQ/OMW8Pmx6o3CMBLcnkgkQtdeTSbvde3EATeQOflGv2u50cWy9NriRBY5zgAwbK6xy7nJ2+6dd1xY4/URj2qBhnVObST59g5CLm2x/qCx53icSsIodecp4kyW0twXnzRbyPUXX6xqu8ec6UCBJSHHCZXsQS/yuxxS1pIuFq7jsC0D4eY29+COhaAoxjUWzDCc+ZF2ciRA6kx4IIsKyPW91Wr+QdQNu2U46A2l9G6b+dYPFuKq76uzevjp8KDf+u+Sm0rG9pSIRYj0jy0lkj3oegvBac/SBLTp9XsrrPAevLO8BpCquz1c/cvrjFR/vc8tCao+7LtpdjiQvBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntwlIwJwBvuhMVvyHmutxpxPdn5E0wtM6X1zLbcf2Ms=;
 b=w9LyR7hUBks1LgvXxcC85pXtVOC1NJWLHrA40dWHR8zbvuxxs9zOUydCz0Dsj30lkbpNpwye+CwRJvNYfwEGTgNyVANhUOvfFA6hyhEL0VmNUXX3qYv1gVFOE3qXL3hH+rjcLqGvbDHmPx0VWqt15/HOH/6tZjk7HSujJmZ+a452BexgLiWl4zKB1ffl2UHFY86XihlrshPDlMLcVIRvL5DRHB210tWAEqYz3/RP3WizIbW1PW/+NghChMLwr0dsANeFXJur8Rz5GUMrXppHSiRm3TQgvNYa937J+Ds1FcYNGGQ5f/kvRiSEsVNvHHQtry1qKLEepxj4rYmRdriExg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntwlIwJwBvuhMVvyHmutxpxPdn5E0wtM6X1zLbcf2Ms=;
 b=F337vosVVzrVQFXNhSd3O1vGfcbfIpDIk1yDVaBvBx1qjWq+CO1T/bw98enGftvywom1UNZzKQCuUCA7BGbXQvSj8KxJ9i3Po1NMxT8qjT+JI2DtTxvHSktIF9BwcGTRSTtWn/70QQSip6d8hl8sD/RlvLpdpy8Fkgt8XxekX/kHSXRgFG/rEcwOFKVrC4QQlNHKVACHpQiMPDUOE0zoR8ryDxFocNxP/+0XVZWprbee9a/uMDv97PoqnnPot9gMx72kOkBj4j6lOc0HAH3s5AyZukGyv1goWY26Q5uUsrJKZQZ85GZLjIDeHJFLjISg7e+k1G+u+ud1J0N42ZhF3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16)
 by CYXPR12MB9385.namprd12.prod.outlook.com (2603:10b6:930:e2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.27; Mon, 14 Oct
 2024 23:53:11 +0000
Received: from SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0]) by SJ0PR12MB5469.namprd12.prod.outlook.com
 ([fe80::ff21:d180:55f2:d0c0%6]) with mapi id 15.20.8048.020; Mon, 14 Oct 2024
 23:53:11 +0000
Message-ID: <cd848c5f-50cd-4834-a6dc-dff16c586e49@nvidia.com>
Date: Mon, 14 Oct 2024 16:53:10 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] alloc_tag: config to store page allocation tag
 refs in page flags
To: Yosry Ahmed <yosryahmed@google.com>,
 Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, kent.overstreet@linux.dev, corbet@lwn.net,
 arnd@arndb.de, mcgrof@kernel.org, rppt@kernel.org, paulmck@kernel.org,
 thuth@redhat.com, tglx@linutronix.de, bp@alien8.de,
 xiongwei.song@windriver.com, ardb@kernel.org, david@redhat.com,
 vbabka@suse.cz, mhocko@suse.com, hannes@cmpxchg.org,
 roman.gushchin@linux.dev, dave@stgolabs.net, willy@infradead.org,
 liam.howlett@oracle.com, pasha.tatashin@soleen.com, souravpanda@google.com,
 keescook@chromium.org, dennis@kernel.org, yuzhao@google.com,
 vvvvvv@google.com, rostedt@goodmis.org, iamjoonsoo.kim@lge.com,
 rientjes@google.com, minchan@google.com, kaleshsingh@google.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, kernel-team@android.com
References: <20241014203646.1952505-1-surenb@google.com>
 <20241014203646.1952505-6-surenb@google.com>
 <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <CAJD7tkY0zzwX1BCbayKSXSxwKEGiEJzzKggP8dJccdajsr_bKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::11) To SJ0PR12MB5469.namprd12.prod.outlook.com
 (2603:10b6:a03:37f::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5469:EE_|CYXPR12MB9385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a1fc4a2-c4b5-4670-28db-08dcecab5c7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c1BWeWlUWHpWUG93b0F6cVd2akpha3BnRi9xaWpXdkFqTlR3NTR6MDVDRWd0?=
 =?utf-8?B?TW5tbVJPUzBsQUI2LzBFVUFTdWRwUklMNUdwajRzVVlRVmJkeDJrVGF2K2Nu?=
 =?utf-8?B?TGxmN0hod3FVN1VMeWo2L09vY2VhRVE5Z2JROUU0R3lFbVVOSEs5dzRuZjI1?=
 =?utf-8?B?azg0Qk1Ka0Y1cm1zZjMyT1JPVUdXSXg1YUVvdXh2UFlOMldLMGpMZ0Q3Ykly?=
 =?utf-8?B?aEE0TGFuSjEwamIxNnhtVGVGaEtuSnpoVDBWaEJrOXVRZEFVd3pwR0hzVzFM?=
 =?utf-8?B?QWxZZlVPS05UWmM1K2NvL05vb05ad1Bra3FWWGxKTDhya2RydDVYU3VCVEdq?=
 =?utf-8?B?YVY1a0pyY1ZnYTQ0NnBicTZDVDcyN1BwdWQvUE1zVVJGYlpwM1Bzb0gxa3cw?=
 =?utf-8?B?cDN2Wk9WekhsWklkWDluMDZ2TkhhQ0tRaDBwSUc2ZEYwOWo3cFhoU0x4MmZ5?=
 =?utf-8?B?ME96dHF0U2JKdWtBNTlFQy9PR3hQeW1wTGlXK1BYVm1WVE95ZzcyaUlrWmwz?=
 =?utf-8?B?T0tFaVZqYm9EY04rbXBlRE5QaENSdzRKTldQY1doZzVLSFlCejdhU3M1SS9K?=
 =?utf-8?B?TlFmU01DVTZlTnpTTmNwUFlQaTRKcTB3WnI5alR4L1lJL2dlejh6RkkzTGM1?=
 =?utf-8?B?R3pVcEEwVHJjM05PdHZMd0ZQOFlKMkpRbWFkeHVnZkNya0dvNUlacEZYTFhT?=
 =?utf-8?B?QmFualNNa2ROSXB1RUFySXd0V2owS1c1bUxQeHB6OFk0dFpiOXhVSGVWdE13?=
 =?utf-8?B?My9UTTh4Y3ZHc0lsL2F2R3VDSzdGb2tMZ2IzR0RYNEVIUHJ5eGlYZjJUbDMx?=
 =?utf-8?B?dk9QT09jWGQ0R2llREs1cm9VV1hHRWo5ZUMvRkUyYWFOT05nRGVzSVhuY3d3?=
 =?utf-8?B?Z3dIb05jNndxcnVRL1BOT0d4Nkxad2dtdGNQc1AxOWlDZW85dGFwQmJpdGRs?=
 =?utf-8?B?bk00WjJ2eWpTMmFtb1lYWUIyY1Z3ZkYvOUpua3pwZUNSM1A0cVJjbHJUMUVP?=
 =?utf-8?B?WWFlM1U4QWg5RWwwM3RsMmlvenBxVU5HcW4vUkdhZWJ5SGxRdTg5ZjhIcm1t?=
 =?utf-8?B?M3VZV0ZYd1VzV3BDZWlvS0I4SlhuQTEwbnI1TEFnb3ZsNnlxOTh0RUFEcm9y?=
 =?utf-8?B?cXorcWVPUkI5ZGdzQ09rbkxCenlnbXlrdFZVcUV6dVJjOWwyTVdGb2NjaEJz?=
 =?utf-8?B?bFJ3cTBkL2RtQlk1SjVPY3E0eGJYOStjZEo5UTJQM3RtakxxZDE5cVRUQUtJ?=
 =?utf-8?B?WG1xdkU4U1UzQW5XcVAvRWZjZUdvMzRUQlhJZ0tzUXBPSmVDUFpQWDJ6OHM0?=
 =?utf-8?B?dFhGdzdJU1UwS3Y2VUJDcEMwQTQvSVN6di9kNkl1SVUvTWd4bWV2c0hXUERl?=
 =?utf-8?B?V091aHZrV2ZaTlhya0JZUHlENFdYdXpXUm51TUY2MG1JUDlhRjA5VzhGOW51?=
 =?utf-8?B?RjVTUFZuZUhQekphMlFOa04yZ1lIeUZlWXcyRGdvT3JHVjdmSERtVGZ1ZDA4?=
 =?utf-8?B?OUpIdWJPVll5L2pyWUJrbnJJSnZmMnFPWm1RdFgrU3QycWpVMGw0OVJvaHRm?=
 =?utf-8?B?bFFHdWR4MlE1bHI2VGkzRXZMd2F5N041Tk5MZjNrY2prMVg5WldQMmQzb2sv?=
 =?utf-8?B?R05ZTzBaUXZPdWQ4b2RMZkxUMjhqQkNGeDhYMnBSalpjT3R0YVpIbFRuYi9w?=
 =?utf-8?B?NVlub0VPNSs4SVNGUXNSd0dhaEc0bUU0VTRFMmNvTDU3b3drd1JCWjR3PT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB5469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QS9kb3N2VEJOaUMxeEhFVHE5ajdBQy8rYnJrSmhKM3VTaEY4cG9tUUw0TVpn?=
 =?utf-8?B?N2w2enVmQVhGRHMyYkloMzh3Y2FsTXVOeFFiQ01ET1luamtUQ2Nxdzk0ZWRO?=
 =?utf-8?B?bkZlbEZOSWtHWVE4RWQxUk82K1FtWEZCUWpZSW0xbnhVcnVlazFmQ1VZeU9B?=
 =?utf-8?B?LzROQ0pvdDFuL0xvWGMxdWFZT1NiV09Bc2J5MFdVSWxLN2p0MnhabEtkaEFM?=
 =?utf-8?B?NDUrSjdXTE93aEUyUm8zZ0NXajJ0MitNdHphQW9ObkRFL0hDL3NHTXZuUUpn?=
 =?utf-8?B?V3B1RWliUVFiVkZUVUdJNDVqMDRjWTI3K1pENXlKNWc3amxWM1dUTUVpVEJX?=
 =?utf-8?B?eVNTSlFkMFo5QjI5d25nVjBvS0x1RlByOFc1eXlYWHhPN0w1YWJnREtyeGNB?=
 =?utf-8?B?dXB4S2VHKzB3WEt3ZkZCRmRPSkE1QUpRcXR0RlhaWlVQNzhENzg0ZFh1SWZh?=
 =?utf-8?B?VnpUeURiU09wR3lSODNLVDBPWU4xMWFrOXRDbmxRa0tCTm4xUWgwdElXMFVw?=
 =?utf-8?B?cWVwM2ZMY1FzTDVBUFdiUWRKcFRUZ0lSNTQ5RGpCOWltTnRaZUgwckh5Tkpp?=
 =?utf-8?B?RnZDWnJzV25iWXJleHNYTUhSSm9EcDdjdE5QUnoxMU11Zm5hZVd5bTNPYm1Q?=
 =?utf-8?B?RUQ2R0tKQjdXRUVxdWtWOHJGV1UvdzdWVGhtUElQaTVWN00wbUNDWW9pREdC?=
 =?utf-8?B?TEVPaU9Fbk40TFhFR1BCd2MzQUxRVnYvZERyMHUyVEc1NFh3a0cveGQ1bUFT?=
 =?utf-8?B?RFdKYVJqeFg0ZEYveDR6SkxrZ1owbWM5UCsrNzVNOUYvTEpwb2JNYlVHVHM5?=
 =?utf-8?B?TVZiZlBTc0xKR0ZXbWFkVlQvQUltVmwrOG53K1RyMXNZRUZBc2pCZ251Tm5x?=
 =?utf-8?B?bGNPZjZqRVV6UWgrYUlGdlZ0bnZ3ZmhScGtYa1pqeXphV0U3ZCt2WkFkZmlS?=
 =?utf-8?B?RFdGRkZGQ1F3WGFhK25uMXZjRE9MVWgzRXVnZ3lpMkFJWWw3M0lpZ0dRNDZB?=
 =?utf-8?B?VlNtWllOMjcrc3MybnhrUWN6NE9QSzhTVEpQWTRxTkI1dXhLZTZidHkvL2Qw?=
 =?utf-8?B?RnZXWUZyVHEzakNva05mK0t1NUFKYlVhOFVOR2F5OXNjVVNpTjNOME56eXY4?=
 =?utf-8?B?Q1Avb2pyS01EejJZN09mMDdtb3RLc0x3ZkZWWXJZL3oxTGpPM0ZIaE5sWjNa?=
 =?utf-8?B?UUhUS2ovVlZDYkZRYTRDYW5vT0hLd0J1ak5JWlZZTFlxL1lZY1RWdzhZWTVh?=
 =?utf-8?B?eVhLNDFJUVM2Z0dBeU5sWDg2OG1LelBaNDdWYy80ckFpL2FIZFV5d1VDRFB1?=
 =?utf-8?B?MkhMbmRYU3ZKWHQ1blVweDcrRUFzbjhUc0pJSzQvU1FzcDJMeXduWlpzRG1D?=
 =?utf-8?B?QTg2V2Zpczk5c0dSOG5nMkFvS0o3MEpabFhrem5rS204N09wUmc1aFhBdStJ?=
 =?utf-8?B?Y3hwcTVsYm04V0RVcHY4VXZkcFM1c1hFN1c4VlU1aVk3bUNiVXNOK0lKci9R?=
 =?utf-8?B?bUNmSitjN1JVSGJFZEE4M014cTlGRHNWQnNwanVGUHFNWmxEOE1WS0tnUHhx?=
 =?utf-8?B?aDRGZk4zcnVUYVU3L0liNk8wd05LRXcxMjRiR3FtNnpaRktmV3FEaUQrWWZJ?=
 =?utf-8?B?VHliK0lqbnBYZ2FrQzdQMVFhT0dLai9ZNjRmMUYvRWNReEk4aFRUdSt0RWpC?=
 =?utf-8?B?bitib3RSeVRONTlhWVhGYkJ4Q2FRS3hNVkpGcis0MURDUUEvY3Q0TEN1V0xR?=
 =?utf-8?B?OVlDVzJJRDhncVZIUk5kZFhHQ0FFZnpTU2FIV0VMRUNJdGp6dWw0U0hua0xN?=
 =?utf-8?B?aUhlSFRRVEhiLzNTWks3OERhZTJlMktUUEw4MHdRZ2NBWmlMeDFJWTM4dVhZ?=
 =?utf-8?B?NWZnS1l5TW5jamlNcG5TMzlPY1lnOUlZTlJ6SHNWSk9QY0RGQ2pkN0Z6Tndi?=
 =?utf-8?B?czNxTGxjVkIrVWRhWWNPSWNZRkIvTDRnRVM5VnNPanlCT2FZZnlLZFY3K1d6?=
 =?utf-8?B?R2RzYzRkVXBxdnM2Sm9laXUwSUIzamlVbGsvbEJxWnYyNVlKMHJUS3JaM2JK?=
 =?utf-8?B?akd2MTZKblBtOEpaMFdOQUpLdXpnSmVqV0VCU3BKUlE0Z1QxcjdSeXJDdHVJ?=
 =?utf-8?Q?ZhzOXjuxyXYqWBdlW483B47Pl?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1fc4a2-c4b5-4670-28db-08dcecab5c7b
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2024 23:53:11.6129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZmNJ45jj3xLN0YeD/jgqPGgUywPYW1YdlI/tfYMCXdzDPqE0+2/vq4ICh1zhKbUTiLLpUlV0WLOkbccwRxbASA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9385

On 10/14/24 4:48 PM, Yosry Ahmed wrote:
> On Mon, Oct 14, 2024 at 1:37 PM Suren Baghdasaryan <surenb@google.com> wrote:
>>
>> Add CONFIG_PGALLOC_TAG_USE_PAGEFLAGS to store allocation tag
>> references directly in the page flags. This eliminates memory
>> overhead caused by page_ext and results in better performance
>> for page allocations.
>> If the number of available page flag bits is insufficient to
>> address all kernel allocations, profiling falls back to using
>> page extensions with an appropriate warning to disable this
>> config.
>> If dynamically loaded modules add enough tags that they can't
>> be addressed anymore with available page flag bits, memory
>> profiling gets disabled and a warning is issued.
> 
> Just curious, why do we need a config option? If there are enough bits
> in page flags, why not use them automatically or fallback to page_ext
> otherwise?

Or better yet, *always* fall back to page_ext, thus leaving the
scarce and valuable page flags available for other features?

Sorry Suren, to keep coming back to this suggestion, I know
I'm driving you crazy here! But I just keep thinking it through
and failing to see why this feature deserves to consume so
many page flags.

thanks,
-- 
John Hubbard

> 
> Is the reason that dynamically loadable modules, where the user may
> know in advance that the page flags won't be enough with the modules
> loaded?



