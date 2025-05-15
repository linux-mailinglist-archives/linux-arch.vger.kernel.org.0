Return-Path: <linux-arch+bounces-11936-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CE62AB7F4D
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 09:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEE18C2BF4
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 07:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ED827A461;
	Thu, 15 May 2025 07:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YMhrp8br";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UZJBUfEz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F8210FD;
	Thu, 15 May 2025 07:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747295554; cv=fail; b=MuCuIOE1vVnITfYUCuBWwUxCAmSLEaBinuY052srVUoLA9jqoMVIizlCByjbo0Gjr2dNVuYxAVCq+yhRel4Ky5srP1ooF8USnjaXwNMCg8ywpynoXlWKScOcEhbFjd/2iZVDc4lz84+wjS2Tb5q/mMtXpuy7UZ/Nq5xv8Ui5vVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747295554; c=relaxed/simple;
	bh=AMw3HEpGWTcalEWK5rJFQNMm93GmWTvQCrQIdgpOqs0=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=opu8HNv9AbKj6rk/0ECtGc2JhOxs5Qy5bQBqNrehDJ5W9VpyPG+ju2yKsGecRRccKQFKS1k4rRHTA91LupUag8u5vaCGO+T6Mz14BLei2utp/Oiw1CzLcTvXdkex7cxHeMLbu67jBJk3xmgGBNRKwe+8VOKU/vqaOKKf//7GzKQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YMhrp8br; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UZJBUfEz; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54F7Bm2k000903;
	Thu, 15 May 2025 07:51:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=QTZtzj7oY0YpShXOLzNMb7l5HZTHF4an+SSjmcyZlRU=; b=
	YMhrp8brPLGyJNzWz4UClaVRFq+g+uWCc0FRQJOATY6sLqh5WqjObmroXuzCesV/
	5+UYtksrTWb6biTt/TaiTuBznIOr76Y6m5jv97XxhAu3MLSB45NKj2+U7QvJ/W0W
	h4rIRowPh+45sadto8BJ2AK4Dgsh9k6bBDnPmhnj/g8nMhseaq2Z1JOQFdWRqpnN
	b6BqEP/WBc04wRfghZICJgRrrUOAiD/esq0vCn8idz0WGz99fKdRDS7GD6MECSuu
	Qhm0YZGE69jhF2IieML6N6WGrk9ui7ddEdq9hATWmU8G9QM/I7a57Auor6WR+WLT
	UUvavykMCiWzI/IQONI7Mw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbchuc5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 07:51:56 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54F5r5dH004460;
	Thu, 15 May 2025 07:51:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazlp17013079.outbound.protection.outlook.com [40.93.6.79])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46mrmds0d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 May 2025 07:51:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W1jv1FHBKhc935lEvUOGd9bHe+NNqNhTJBRuzkBJF2wI+pRpEEFH/2C+rbkEd2yuFLCvQ18iBaALDhlZE5miKpB6/H0C8ERUSkQvOb0CVNpsOATnZEqHbVCkf+iBz8hqp6eYxl6z3ry+B+Vn+WwSMVmdPnGgZLp4L5u6lyGwzKt1bG4i7wp7yiMD5AG57hM4a2X/U9YOSssL4fiJjXpX3R7uRFMwmgBMlaeb7gY7V7NsLBl4gyqURgo51kAS3rY8HlFVI4GmuNhEjMO5sYwxLaVn/5Jr73ZPosr968OyFucVprMJ6h9qDWpF2peGEHb+vfRftppcaCVV4tUOXjpASA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTZtzj7oY0YpShXOLzNMb7l5HZTHF4an+SSjmcyZlRU=;
 b=Lr26DClYvycjwY+J/uO6nL6lmjTSAUpUcz68SpaIkMcjv6V1heV3ivhmEdv7YuqGGOy2WmDe8T/99D8MZWTZhnQ9aO5ZQLZTOaO39qXLsGIc8A351ydVwq1lSos6tAi4t3DDIMLDTEBBXB9geHqMZlTEJjrfShQyJtCJXZzZXztVWxR2QtYEiDrzVC93JgJKXWommtodxYppzc8DSYHcGNGhI8ezzigFDIEtvQMEL0ElB5WCllhRhpA/5O9JKP90AeRSPiPQNGrO1yzhi1wCOfzSLcqSFCq0Tky3rPhWRfS1BluKCkD5iZE/zih7uHmskWic/4LeucTcHPQfMcZiqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTZtzj7oY0YpShXOLzNMb7l5HZTHF4an+SSjmcyZlRU=;
 b=UZJBUfEzdBn0+vO2Net4lhaNuBGSnqU2mF2k8vbnh9MVVwmKx7mgypyaBms7qrEhSbXiSKQZOgCJSjEzx8Z7mIs/UZPiJCZ/wpSE1XGyOHoiKaB7mxLUhXHuczxpTjASqldFNNvmRUVZo3gCV9PTMeMFcA5ne1uuvo3khdaAmYE=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by MN2PR10MB4317.namprd10.prod.outlook.com (2603:10b6:208:199::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.31; Thu, 15 May
 2025 07:51:53 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8699.022; Thu, 15 May 2025
 07:51:52 +0000
Message-ID: <fb6121db-9872-4e33-bc7b-82b026b0097a@oracle.com>
Date: Thu, 15 May 2025 08:51:45 +0100
User-Agent: Mozilla Thunderbird
To: lmb@isovalent.com
Cc: andrii@kernel.org, arnd@arndb.de, ast@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com,
        john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, martin.lau@linux.dev, mykolal@fb.com,
        sdf@fomichev.me, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
References: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
Subject: Re: [PATCH bpf-next v4 0/3] Allow mmap of /sys/kernel/btf/vmlinux
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250510-vmlinux-mmap-v4-0-69e424b2a672@isovalent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0549.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|MN2PR10MB4317:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bf2f2c-db40-4331-7bef-08dd93855b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zk1pWlRMOEROYkxDTnB2YnkxeVhTd25qY1RCMzBkcG16QnVDbkcxVzkwaFg5?=
 =?utf-8?B?RDlNZWFXK2FiYm5zTUVVa3ptMWE0MjB6VDl3QmlwK281ZTVOemRJT29POENJ?=
 =?utf-8?B?OWVVNU9xUmpUaUhPaVNiLzhXSWFSdXlmNnFDUlB5YmVKakRJZDNkdHRONmxk?=
 =?utf-8?B?dFV3ZkxUanZ3SkJHQkRvUm12UE1mOEgxMHBBR015Y1ZIT2xQREJlRTM2dWx3?=
 =?utf-8?B?VU5rNy9hV2VLU1BFYXRUK0p5WWdqS3cvdFlZa2FLZnZUT1dZeXAvWUo5MUhu?=
 =?utf-8?B?T1lnSndoWDBsbGpFN2s4cUNhb3I2Q3IwcENUWnpkL1Z1WjlNQlhWZFlUUEQy?=
 =?utf-8?B?elJjVzVFeG1pL2hKU1EyVVp6bmdlakRxeGlZaVk0RENTZDBNanpwOTM3SXlS?=
 =?utf-8?B?Q1dIaGNrRDNtdjVIdEFYd1VycXBWV0pXUjFmL2lhSGJPN1o1Z01pS2ZOQkEx?=
 =?utf-8?B?M0VCT3VNcmF6YVE0QjVWRkdCcFA4SDd3dDFlOHRwTTVSeXg5SUVKdk55dWdD?=
 =?utf-8?B?YWZFS0J6VW5pM0tSZndoZ2xLUjEyZTU0VGJEREMvY0tzZVhCMXJXZ1JxT3ZL?=
 =?utf-8?B?RXAydWw0WnM1bWRmdjUzVXM3a2VMQjQzMEkrcGwzUnVEaEdieHJxZThvVW1U?=
 =?utf-8?B?ZGNoRXI1blhKZlJ6N00xK09Xd0JDSWRZSGNlN0VxZVV2YTdPRG5YUytoQW9v?=
 =?utf-8?B?NDZaUnpIVkZYd1N1cWFzK2lxZXNoOUo0Q0x1aU85bEl4bGJJM1lVYi8rRE83?=
 =?utf-8?B?TkNQays4Y1VidGxKUXVnZXdUZVBJcTFTeVpqZlNkUTdBdngySVNlcHBrVGtV?=
 =?utf-8?B?eFo0TWVORWovRHJTSWJBOUdqYTFhNWdRK2dqc3hZNWg4Q1Vwd3BIOWoraStX?=
 =?utf-8?B?VWREUW1jRSt0N3dvc1FtSGZIRGhVeEQvMmMwN0x1TG5jTTBHejJNdTZESDNR?=
 =?utf-8?B?MkppRld4NmNSWkQ4Um54RE8vQ3JxSFpPd1ZCNmhhVkZpRmwyYm9mL3JtUWRF?=
 =?utf-8?B?Yng1aTkwdnUvNm5CbkovdHRLYks4cmFuSlhJV0UycUpsQ0JGbVlsVG1yelY4?=
 =?utf-8?B?UDRqMHcrbDY0eGhxeGNkS3pkOHozL1lEZFFaS1FKVHFkZFRaTTVpT2tvSlhV?=
 =?utf-8?B?NnN5aVlLVEZXVzFDVm5rMmdpQ2lKMzZYaGpmbUdYQWVVMGZ3SE56VXc5WWxV?=
 =?utf-8?B?cEtWZVVzT3lKd1FwVEZRcGpLOU95OUZkN1NzRDZBOEpHdWpGT0RYZE9EWVJI?=
 =?utf-8?B?MTUzcmprMnB3bzg0Zk9jLzlhQWlmaHFUalJTTG90RTJ6WEhFckQyRDBtRll4?=
 =?utf-8?B?M3VkQzNONEFsUmhtdFlKekZZRit6Qk4ydkxyOWNDc2l2OWZDVkU0WE5la29Z?=
 =?utf-8?B?Y3doMG1pcDdwSVJVZ3BTZ211QkNhU2NyeU9ObFBaeGlWaFRlSi9IOEErVjBk?=
 =?utf-8?B?K1YzYlJDRlFGNzhac241bkg0a1Z1NDlXWWtSMUk2bU9jZys4OHk4WXlud05V?=
 =?utf-8?B?bXlPZlJkWHFUNWZCcmlvVXk2eHdpVkJDOXc0eTlqYllJVlNFNEMrWWlTTXZM?=
 =?utf-8?B?Y05uQmEzNm1aWEM5QnhpWkRUZUJGZTBkSy9XRUVlV0lpNG1iVm83a2NnZW9C?=
 =?utf-8?B?Z3RBVy93Z2hZNjJ5SER0SUhOamszNWNLZFdtS05QdHNZdzZwQk1NYm1taEpp?=
 =?utf-8?B?bFpQUkZ1aEVmdXpibngrUGtYMzRoc1ZVS2JUV29TQTRGVXI5MEZYNTlxZFl6?=
 =?utf-8?B?YU9jeWdobTVzbXdEcC9SVVIzT2tXOU5WSXlHaUw4YUNGYTNPTWNuL0tiaWlm?=
 =?utf-8?B?WHdqdEdjMERqNTd3MEFjeHhmVWdheHdhSDJZdzFzSjdZMEZNNEUyTGV1cERw?=
 =?utf-8?B?NStsSStQTWJWUTJuZUVXT0JBRE5wTDhDZkRnbkpiUFRNOWlpZU4vU0Rqdko1?=
 =?utf-8?Q?VpTGvMv6VIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzJxYmZZYTZFdktPb3dTWjNnREQrNjIzOWdYWTBtc0NXR3ZBbHdpejZxeGJZ?=
 =?utf-8?B?UkszMjFaTkxJM2k2YUo5aGxHYVlkdTBYcW9FMVRZR05PZWNwNUo5L3lYUzNt?=
 =?utf-8?B?NzA0bGs1b0xnQVdpUlNzTHZITkhZWGQ0VE5ZQmp1dlR0ZjhIbTErZ2I0V0t6?=
 =?utf-8?B?SVZONlgrdURNYXpYbXpIaXhuVkNKdHcxUDIyeGx5Uzc5KzRBSVZxN1luVzB2?=
 =?utf-8?B?TUFJZ3RjZ3RidE1IYmdabXl3RFpTRmZlQVRGU1hQRnZSWXcvWjdvbktYT2pS?=
 =?utf-8?B?QUdxZXJTQ29BVk45aWNmQ1hkR0NxVDRobDdYT2lGVzZCOENydERodlBJZkFm?=
 =?utf-8?B?YU1PUjZRWnNDUHVPVzVENFZTd1FtTGJKMFg0emdmdlM5TWhoK053eEwwMkRo?=
 =?utf-8?B?QnBhbGY0Tm1TajdCaGN6U01PYjNiaEJEWThtWER4MnJ2VXN2TjRnVWhNcmZ4?=
 =?utf-8?B?bW85bjZOUlpXUnpZQlNmd2Q1b014RHFhTzVKUTBSUGphWVB0K29JTEt5VHdT?=
 =?utf-8?B?TVVmV1hlTHN4cVp2SmVOTFVZMklMcjZOa3RGZHhJRHF4OXR6Yndub1Y4R0ow?=
 =?utf-8?B?ODAwSnhkVE05TGsrV2lDNkJsemtDYy9NNlBZd0pkVlNPZVd6ZmxzNnRiNlZB?=
 =?utf-8?B?RE01b3lKb0RqSElPanNSQ3NNMjJSNU9qb0ZsakhUWldGeWtua1QrZlZIYlM1?=
 =?utf-8?B?K2VyekNHUFhHS1RIWEs2UlVLQ1lWOEZjc1A0bDcwcncxU1ZNbm1MQ0NHb010?=
 =?utf-8?B?a3BPZDZnNm4zLzdmZGdsNXQxaHpEclBaUTBIZkNzM0E0aWdvOFFRTzVXMkJD?=
 =?utf-8?B?WFNIbkVteWZsNkczYy9XWWR2OUd1bU1xZGxjbWVzN0xvVjlBdkFONU9xaWJJ?=
 =?utf-8?B?ckFrQmJsOTQ5SmIxSjVFTjRBTFVUNkVobnlmQmJ5UUpvYVB1ZUxsWk1WVE5E?=
 =?utf-8?B?Z210TGNzUWJDbnlneE13ZytnVlhNYWVSL3NXdjB5SnlhNU1VZXBZcEdmTXEx?=
 =?utf-8?B?UjQ5cXZaTGU0YmVsZzA5UHQybFpzQjhFaDY5QTdkemlML1lBMVZWKzZXbm54?=
 =?utf-8?B?Z2EzZFZyWDBubHFEajhKU2w2KzJNVk5BT3E1N0hEN2NLUk9acExWTCtZKzBD?=
 =?utf-8?B?WStrM01WNVFkWUppY1lETHBESEwwa2s4YzU3REFDV2NTY1JGdHVvN2s0OGwx?=
 =?utf-8?B?d1hmd3JUcTU5cEtzWUswWnVCcUlkdFI2SGxFZzVWWXpoQ2NPQmFnTW1YWEND?=
 =?utf-8?B?SmlmMTltc0l1dEtHYXpvSUltYlMvTFNRcWM3b3FzSXZyeVp6emJGR0JDN05N?=
 =?utf-8?B?NWZZR0RjcW1MRGhyaDIybkZBTEhLcWhsY1hoS2s5aFNsbDZqTVRpY3o4bzlH?=
 =?utf-8?B?RnRiT3gzTlpyMDFoMU4wYzE5S3BYNDF6dmJOdGF2QnhRc0FZSXlnQlJQbjZo?=
 =?utf-8?B?UWV0TzQzaEk3dkZvS2hpRnlRQVlYakZMU1hINU1IemdtSk5MUk9QSmMycmtK?=
 =?utf-8?B?NjlWZm1aREFoSHVBRXVFbHVjSnVlYTlaQ2lOTVpubUZFeG1LcDl5OWY4STdV?=
 =?utf-8?B?VG5pNC9XVW52Qk01S2Zya2ZSRmFueWZ2QW1IVDgyNlFxSi8vNlFIbG1NdFUz?=
 =?utf-8?B?Mm9Wd2plNXF5WEx0TEpEQWw4UkZ4UkNXZmJUNVJzcFVPRXVHOEdGZ2s1eHBC?=
 =?utf-8?B?eFJUdE40bThubVhwOGZ0cHRmNElGeGFtNGxlQVlUVWp3cXZmQ01KTGYxeTIw?=
 =?utf-8?B?OXloSmtzWWR2Y3lNcVJpdnJMcWVhazFIMUdRWTEyQ0tqelYzWU5VUFBmU2hK?=
 =?utf-8?B?U1RGU0pYSndZeTJiRWdyRDZ5OUMrMGoyamNrVkpiLzBBMU5wemliVkVLR3dp?=
 =?utf-8?B?Mit6dm9hL01oTjZNd0xZb3ZZMkF3UlVlOUtVRm1aanZ0cldqdWc3eUI1M3V2?=
 =?utf-8?B?eWxkSVVMeXNkUERyZFJVWVllbWN3M1MyMUlzR2VtZWxXMmdjdnl3UnNPTENh?=
 =?utf-8?B?cGtaS1dWcHJGeFRicG5taU1WL3JBVkNoZGpwbFdEaXFjNkR0RG84Ry9FSXBB?=
 =?utf-8?B?S2sySm5EcnJQc0ErcWxjeXlTVkM0bmFEVVFmdWpHblVDdjV4YXpYenZKbEZB?=
 =?utf-8?B?blF0RTZJTDJCdTJId1dnS0M2OGF6VTlhSXpNcFlwb1Q3TmYyK2V3VE9YT3N0?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qeYErCV/QbYN8lFm+tNTwqXljrOWLvNZM1P3LsGuEfo0Fgv8PVPDC8yFJj+r0uivNf2ffK9ze+o2R8PEp4t4rYtX1pCOFdRL+uQTddV1dde0BoEVoE/XundTgOeJKMoBSCxypsPz4+pQbox7izoulSTlaUOG5K5mmYhoFOKgXdm0mcWYaEzFvM3S/aDY/XHqx0JuEWKv/5ANiWOhMa/2Z1oxh1VhEGU0mC+diOnmD+H1qzgVPjnnBs6q23uWIgO8twBWFCyx4dgPmt9604PVPDId28Wjhl3kS9gGZTPZBlj6pz3VM9vJBeTIuGLio4d5iJtLI4FiMSuMsNopwoCQuA7er6j5M6kP5PXFAhx5bBjUQO5m9Pv28+i86yi2FKCeltCVtOPiXyiGq7cUcdZTRA6vgol4bCVXGOGzjSX5Ljp8BYq6kX7kkPgicHIlocIn2GYifsJCbUnygyUWUJEvGty6pSD44Q56vlb37Y3bG+LoO2jqKgsWFzyR/HGKLIw8KihuW34AnfayIVt7DZdz1T7GVmpJ479Yd7sD5AjmHxwLQ/WtSUP0BmUKKtFycJ2F1aN2oZIide31D97zOf+eyN3FldFIaSCW+PHDKj3IK+g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bf2f2c-db40-4331-7bef-08dd93855b25
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2025 07:51:52.7925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sE9dvtLh1xNZSS4nI6lUSyjshEEnKIMXnXvZ44fTEygmDnI7V0mF8XgjTKeg+J+IJX+kvsjfIq0GngAnfmr/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4317
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_03,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505150075
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDA3NiBTYWx0ZWRfX8ZjRPnYgKLhM lCqFOhI0DJqAZVkv1JrobZ+KzldnRiCPe4WZu2ZpHsB36W8JEibU7RsGRcjI3tTdDWLMn0/rrrr j95dxyZ76GkBEmKr5NmMM//KByS5gc3vF4oURnU3Bv5n/BSJY7nZdZTxgBOV5YX0u7nTh344eON
 nNTqonMXLYw3iuQjJBVm1vpBZYMKWhByC2SOi4zsmB35mHsdvbDGHxLjQdOH+Ms0R7+JX+WHH6q u5K77AN72OKka1Aj9ym5yX4suCMVK6w00Aq6D5hNKFGi1p5i+xIKTocQyq059Yyyf/hvTy7uh5i TQONsqOiEawLLIYiAFHvBzV6NNBfZJTxQ7axGMZTTYXhsisxdPpZpc2kxJt4v1mC+22YNiqaVBq
 qOjt+3o5nhZDoAlprzTiq4ke4sOMLd1eA68bfdSZOCWqG9s2klj2CKpTByHj4z4tz8g0w/Ob
X-Authority-Analysis: v=2.4 cv=EtTSrTcA c=1 sm=1 tr=0 ts=68259d1c cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=p8Hr7QA-AAAA:8 a=yPCof4ZbAAAA:8 a=mSLxrYAxeKi43PKIcNEA:9 a=QEXdDO2ut3YA:10 a=0lgtpPvCYYIA:10 a=Nk6gH44JAh1yPMgKJKsv:22
X-Proofpoint-ORIG-GUID: QzFvJ-suyEWyqB4Fv3TKHGHa6TJ5CRW_
X-Proofpoint-GUID: QzFvJ-suyEWyqB4Fv3TKHGHa6TJ5CRW_

> I'd like to cut down the memory usage of parsing vmlinux BTF in ebpf-go.
> With some upcoming changes the library is sitting at 5MiB for a parse.
> Most of that memory is simply copying the BTF blob into user space.
> By allowing vmlinux BTF to be mmapped read-only into user space I can
> cut memory usage by about 75%.
> 
> Signed-off-by: Lorenz Bauer <lmb@isovalent.com>

For the series,

Tested-by: Alan Maguire <alan.maguire@oracle.com>

Tested with 4k and 64k page size on aarch64; all worked perfectly. Thanks!

