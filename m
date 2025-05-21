Return-Path: <linux-arch+bounces-12054-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DAEABF8B7
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 17:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221AB1628BA
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 15:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD941EE010;
	Wed, 21 May 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZrpPLZ5X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eb1Y9ZDz"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D801DB548;
	Wed, 21 May 2025 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747839660; cv=fail; b=dhwI/m0jO4OzKaiMiy8oU8y08UXkPEy41bHeKUxVFEwq/R1Jn1W8jmfIr8WOD/GWm0X0iIgRvAtTKHmmDVWRwn2Z+hpF5fKEW5VQRIeqeD519xJYFybC0vVOSczfB/l66Oh+UEqy9DR2pYykdZvFm6T3N4Qw7Gclf6ajbkyO8LU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747839660; c=relaxed/simple;
	bh=yq3HwgCUCGrJ2PBYqb0avnvZuSmpLOKYeZVnqXtODqk=;
	h=Message-ID:Date:To:Cc:References:Subject:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Mz8Rfot13O448bVMzQYSWic82FS8RDMtnoR9ayaRH7BbpDpFEwa45jGTwIFzrgQDBWvHCZiTpY5L85PA6ihl6TcfUgpKKuo++lRTApN+0C8jwNjqTXnxvznF20j0LczU3k/UYJ07lfP8rWHLfqch9wRXGCaZntFuaI9XvlG4uNo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZrpPLZ5X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eb1Y9ZDz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LEv9Ds025379;
	Wed, 21 May 2025 15:00:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=05p63RToOUuyJDcBC8+OyjejWVf7Ri+Gh7n1l/5Y3ik=; b=
	ZrpPLZ5X5DKmoaPVbohZxoLIXZA9n8yZpCKExb2u6SnIiVxKg3rObZjpqHdHfijG
	e4/dUl3VvmkZdABPR9w7kfdfGDXcvezudl++wbenSjSJuy9qVv+GKNtI8RNgqlKW
	Dzpg5bD6waaW1AyYdHKR7OTzZT9O/JL4hfXM2NX0R9/6sGmXy7chSv/luqcgCG6F
	hKCT5F5kgejQV5ChcAFwvUWR8pjmM5L5yczP3VjgI19OlxHegTH5l3D4S+4tY4GP
	BZ06fkEZOUzMeYGbPRULr1P+v+0+7hxyhidt6bIq7geHSbgSsVtk6NcxrM/lCOjv
	K6O99B8EkaulgmI/TyXJjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sh1sr0af-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:00:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LDO7FH011317;
	Wed, 21 May 2025 15:00:29 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11011046.outbound.protection.outlook.com [40.93.194.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rwen7rbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 15:00:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N2Nsd5uqUTi/IKgWqAFRdYX0IswTVwga1rXrLEXyfqoY1tz/pn5VcsoUDeaA3fDSi0aLcl2cHOCuVLjJdoPUz2Szlbqdqk2H2tmwF+Rdf9mArVym6KaM69TxIMU/VSzvEUQe5/pUKe2LuzSTk7MuypRtItTa+60A7MDUz0BgN6e3ABI4W4NRXfy2jNr4Cp9eFRbNHyHlIr2YBdzcraRWPQ9o+ASPZcVjdZky428ccKeUUsX5eTqskCD8/iwdjCmTnOnzJtHjvfrWnR28K1Rvuz3WD2DBHZBbNdf3GTg/NmnaAd2g/5K0wHT9Uq2HgsCogp+YcJxbPdikJpuDyf3DFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05p63RToOUuyJDcBC8+OyjejWVf7Ri+Gh7n1l/5Y3ik=;
 b=jbE7fOIRwiSqEyrqFTUVxGc2INykUeOMp59A+pq6iivRQK93sMNA9aR+XHE0rkmSj+BjgnirfccMoT9zWLCWV9wH7FNSN/KuK41oAu5dBBPEbkxoJ8R1PUzJbG00OOCB8kO4ZyzdKBk8jrtkhOT6z7KB9Z2qhrYZw6VzDHfcRqrxrVbv2fbVGxb2X20ZUgah9J7U40YAeVIeUL9Wm7fnZxBpupurm/7Cr/MlVc/7AjXubhO2uhJCwvl0AeK2wMoi34Kpb/uRl4yySTZlWjdEpsP8jjjg4WJAbs1u/1gCde+cBRqZmo11ypNjm23x0xSFABZEF5E0PAZd7ZDgG5LzRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05p63RToOUuyJDcBC8+OyjejWVf7Ri+Gh7n1l/5Y3ik=;
 b=eb1Y9ZDzNa45qx7V//vwL2bnJzn9pa1DRw3bvEn8JhJRJ8bYoTYzjxtgob+n5miHI/omTIDs7OEM9rHOFPZUM7qre/52Kxst2w04qgpOyIIc+CZMXUZk/+iXjiqeoEfUmZ7Pz8rzLdrAzX2y9Xz4rfDzKMXqBQU59OORYJD4Aw0=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DM6PR10MB4281.namprd10.prod.outlook.com (2603:10b6:5:216::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 15:00:25 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%4]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 15:00:25 +0000
Message-ID: <ace72324-6395-4e9b-8406-7d99d57018dd@oracle.com>
Date: Wed, 21 May 2025 16:00:19 +0100
User-Agent: Mozilla Thunderbird
To: tony.ambardar@gmail.com
Cc: alan.maguire@oracle.com, andrii@kernel.org, arnd@arndb.de, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
        haoluo@google.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        lmb@isovalent.com, martin.lau@linux.dev, mykolal@fb.com,
        sdf@fomichev.me, shuah@kernel.org, song@kernel.org,
        yonghong.song@linux.dev
References: <aC0OpCZCEziDXhwh@kodidev-ubuntu>
Subject: vmlinux BTF as a module (was Re: [PATCH bpf-next v4 0/3] Allow mmap
 of /sys/kernel/btf/vmlinux)
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <aC0OpCZCEziDXhwh@kodidev-ubuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DM6PR10MB4281:EE_
X-MS-Office365-Filtering-Correlation-Id: 37b4e2a9-bbaf-4a9d-b69d-08dd987837a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OWFnbXlHTmk1eXNyM3BIbFE0eXkwZksrQ0gvZTZjUnhSd0ZRTTN6cTNOb1FX?=
 =?utf-8?B?YldZdzYzS0NNUTdLcXR1a2ZkUkZQRGhuaDE3VDg0Zlc2RmRBVllYbnM5bmw1?=
 =?utf-8?B?Z1M5cGRxeTh6SXJtZW8raHI5ZitaYTl3OFRpVEJXbnNldnBIaEIxdlVnVk9h?=
 =?utf-8?B?RCtlZ3lBQmNLaUg5UC9qMU9nY3hmN0duT0NEM3RkRVNvTnhlU05RclBPZ1kv?=
 =?utf-8?B?cjFmcXVvQ0VVbjZqTXlqd2U1MklmZmh4OGxnQUFma0JpUlh3UitnOFVzZk1t?=
 =?utf-8?B?c0FjbnpjRjI5ZUdkQmVSVFg2cjU5WkZYTFBRWnEzeFp3Z0tyV05QcHpjUDF1?=
 =?utf-8?B?NW54ZjBmUFhLWmJLL2xhMVk0Z3MwbDVKaFVtNDRqRkZVei9lWXpRcktPeFdX?=
 =?utf-8?B?VVJFR3pWY09scDRVUEhtaWhCd3lKRnNKR0RpamFMdk44ZFRpbGxRVm5GUlJ1?=
 =?utf-8?B?c1pQRWkybE9qQW9vY0xvZTRiRmdlRXBhVkk2UU9ZelpPWi9LVlBFMTFmd3M2?=
 =?utf-8?B?OGFBN2JwbmNCNURVcDNlMFVtUjNKYnNIVGRtb3o5aVNLU1dpUGprdkhJWHI5?=
 =?utf-8?B?bzVPbmR4ZDloWVRtYVYrSjUxeUJOUzZmZmRzT245NVJpYnJRZTF6dUVNOVkv?=
 =?utf-8?B?UE5PM0JlN3VqWFpGcjFxUDJLUmt6VWJRWUF0bm1jNnRCRUI3ZDdKTU1RdmFF?=
 =?utf-8?B?UTR3OTRWVVhXS0g2U2FGSUpLdUlCN1ErbFdvaEEzMEdzeStlQXg4TnZrZFQz?=
 =?utf-8?B?SnphN1FUYTZQMGJOZ1JkeGw5c0tKc1owTTIzNXEza3RrK0tWVnRwRWZUVmNj?=
 =?utf-8?B?cHhsY0U1WTZEelZUdmFUTnNrSm41Nk5PYmxZZlQvUUdSajkrQVJLQWpYWDRx?=
 =?utf-8?B?YkNFa3BETjFEK3dzZnpHd0lvQmxJUEp1ZVRDM25VUzBOeUh5QThSYkl6b3VV?=
 =?utf-8?B?WFJBdk9uNXZLNjBVQm5yb3lTWCtBa3J6emxzY2hlZmJHbjJNZ2xlS0kvZnJL?=
 =?utf-8?B?QVEwWllxYjdTeFZCMVl6NUpZZWNTeTBNeUFFejFpVkJxR05lY2svb2wzaG0z?=
 =?utf-8?B?b3pVZ0xzeGozSTI2SDJEbFRCZzlMQXBDdmNCU2FsdnFwQkp3NEV4VFpYVHVx?=
 =?utf-8?B?VmtIMWpYdUtiaDY0ZDRXbUczNUc5dlFnOVdaY0tid29BdkJQeXFGSEFTeXlI?=
 =?utf-8?B?blA2ZzZxN0J3TzNzU2d2ZVZleFpQS3UvZHB5TXloRkdHdW9MZ2pjRkhSZGp5?=
 =?utf-8?B?R0pBVGNnRWRSNllhdDlOZXRscWxmNmE1dS8xSG8zT2w3Zm12WUVtaFg0dkdw?=
 =?utf-8?B?SDFrdHZpNUQ4czdYNXRoZ2ZZS29IMTI0RzZkKzByTS9PMFlIQU1sTElRU2lm?=
 =?utf-8?B?Q2UyWHVXOUd4bGdOQ0hpVDFrZjVkN3FPcTA5cGlubEhCMFNpVDkrN1pVNU9Q?=
 =?utf-8?B?ZkhUZ0xYSHRBN09tSUQxK1BqajQ0NCt1cGo4Mmk1U013anZHWEJFRDNFM1lQ?=
 =?utf-8?B?NnlQTW9ab1ZvYmRVZXhDWWNPNnpQSlROcGNtRzV0dEdsS0YrQ2xlUDJFMjdx?=
 =?utf-8?B?SGc5aG51eVpUR0VxMkNRY1lVZXVYNFQ3eG9mK3N2N0lZT3VGWDFNNDNXMnQr?=
 =?utf-8?B?cDlUY0dOR1ZkeVBIOU9XbWE5dFF6SDJPQnBXUFJiSWdUTTQwOG1RMGlCdkpk?=
 =?utf-8?B?ZjMwZU84Z0ZTaE9tcW51Sk4rNGVsRGZLdlpUOWljOGNxVVFIeHNteG91TXNh?=
 =?utf-8?B?RXUzMHhuZ3UzU0ZqMDZMdGxiL0t3c0lCa1hDV3hSM1RkOXRZQ1orOSt3RDFO?=
 =?utf-8?B?bDArOEkrUFlGODhNVUhpWng2UkV0N2Z5MEF4cHU4M1JGYS9FTHptMi9iSXg0?=
 =?utf-8?B?a282SUxPQllmbkl1dkJCNUN6UkNacTA3N1lRc1NsOXE0VFlyb0YwUzgydllN?=
 =?utf-8?Q?jh2uDDgsudk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmMyWFRpai82c2p1bGJGSVZZYzJnVllNOE9LRXFVSnNKTnRCeDRXcWZkUk9t?=
 =?utf-8?B?ejFJNjZ1MDZZY0FzZzBOd01iRmNaUFdtRVdWcDJzVzg5Nkp4WDJnUFZNNUQ2?=
 =?utf-8?B?Yks0RjNCZmtlcGJiRURqR0NjNTZwYzVTS1l1OXpsVEljQTNBUzlKU1loaWNN?=
 =?utf-8?B?U2IvNk9qbzVHNUY2bldlM0tBN0U1WFdQWmhIMVhaVnJQNUwyNnBNTzVhUU5X?=
 =?utf-8?B?ck9ILy9heXg2ZEFCYkdwOEd3WUhBcGQvRTRkL1YrVUFBcmxpUTBjL0lLSHNE?=
 =?utf-8?B?SHdOWkVFNGFQZkEyKzVQalIvQnBmNlY5NFB3TEtmWE1FRXZpQUl5NFllck1s?=
 =?utf-8?B?bGdpRFlNZ0NoTnNXR2FjM3dRaldUVkF5cXNrenQ5Vll1YW02NVJqSTRzY1ZR?=
 =?utf-8?B?Si94U2lkZ3daTGdtc0RoSzVlL3RIcjh2UzBzZ0hnV1R4WVJXK2NYRUVlQW9t?=
 =?utf-8?B?RW5TQXpKMnBjTm91eWVselhURUNTWFlHdG12aDM3OHdCS29VaTgxTUkvN0J1?=
 =?utf-8?B?SThoOWxSeGtRU0dBUTlYNzJlUldSbW9KYVBybHROUU4vcDU1WmdtTEZiOUk3?=
 =?utf-8?B?bjQrUkZ3R0EyMDE2ZkFCQTdOYnpERVdpY0JSOEZpbjdiZUxyU01HalIyVytw?=
 =?utf-8?B?bWpqMzVKNENIZkFGUEhkalpzY0g3QmhLK0xwY2ZLYXQxNEdHbWhGYUg1azZ0?=
 =?utf-8?B?ZGYyWG5UVmJJMHBId3lvSmltTUNNbjlpaFExVzhsRHpKeXVKSWZ2YzcxN1J1?=
 =?utf-8?B?djM1bVM2SHIreDg5MDVvdEVJQ05WQTBFZVZScTM3UmdvUGppaW04dTIwZDdw?=
 =?utf-8?B?d3JBRFFOYzRPQWF3M2xyTmxtemYySVdoMmJhTmcxbGNBQ1dpQ010SUI4L3hM?=
 =?utf-8?B?amVmWXJsMlR3cmU2UW03OTdRWC9aeUFVbFJhMEh1YW1UaG5NSnB6Zk5LSnZJ?=
 =?utf-8?B?QnVzUDhwUEdoeWlGYmZtWkJ4QlJZbkFFczI4V2VIRkd4cUlFaG80RlBZQjAz?=
 =?utf-8?B?R05sUXoyT2F6RURYUWpsMlBCUmZocExhNUcxcExJWWtqTGYwbjZOQnRocGx0?=
 =?utf-8?B?ZzluYjdNd0s0Q0xTUDZ6MjE4aFVjVHBQbDZ0L2lzRU02SDRKamZxTEJwbjcx?=
 =?utf-8?B?M3RrVUZzV0RBYnpsR1dGZ3RlSDlkYVVCQy9PY2Y4MDVGaGZKNk5wQ2o3M0pL?=
 =?utf-8?B?M3oyb2MxZUtwRTRRYVIrSU4yVDZXZnFGajVPYm5vbzhkRXpCOEVKQWQrRUV0?=
 =?utf-8?B?L3YxY3dZaGtPRnN5VWU5RXZjVjY1VE4zTWNYMHhaVzFxVUdvcXhGa0xBeXNG?=
 =?utf-8?B?WjhQN2ZZSitaQjRBQ0NIU010eDNQeVNzTmhISGFuU2x0Mm9RUzNkNlR4bzYy?=
 =?utf-8?B?enQzdlZzVnZFZW5adGhWMUlUYXE1T2FPYnh6eWJ1Q1JLYjVLUWtqN0lIWko1?=
 =?utf-8?B?WjcyenFQTy9JTlRZZ2ZKb3ZnTHIzZGE2NFQ0N3BJLzQwbDVHeDVHbmF4dkVQ?=
 =?utf-8?B?Tml2SWJsWkxMVkl2QndDaGtJRXNjMnJRckcwZnF1a0xGQzNSWjI0MklReXpN?=
 =?utf-8?B?VmowcFBmcVNqbVdMQ0F3VGVJbWtKOWhVMTZ6RWMwNnQweTR6QXZMd0JKWHQ3?=
 =?utf-8?B?Zm81VHBxZmE2TXl4Yko3R0hyQ3ZKZHE2cjFmWTNvdDB5ME1oUFo5emthejNk?=
 =?utf-8?B?Yi94UDZEcnpERmNuNXg3TGJhOFE1YitxYnZsMXFic1EvSXBUa01yUEsySExa?=
 =?utf-8?B?bG1RTGtyU2lZMVlMSmFyTS9lOVNQWGtuWTMxT0xwUUd6VVdDU01xNDdYeEcy?=
 =?utf-8?B?UEN1VWVHYTRPVE0waHA4eHdpdDA1WVlZYjdGa3FIM1R2aFFIOWVXR2dpMHlp?=
 =?utf-8?B?dlBzNmhOWHJQUEdWeTZQbUZlMkg2d1RMbkFRamo3S3pmendyeHl2U0NONXBp?=
 =?utf-8?B?d2xLNzRFYTNtZlpKOCswamdiaFJSeThZMTNGU3JxMWdFVmpWaFVNZXoxM29P?=
 =?utf-8?B?WG5SWjNSVitQcitLV2tFNXRXeGtneDFqNGxFU1pQckpRWDM3R1kzazBnSElS?=
 =?utf-8?B?L0U0aTZqU3JsblgzcnVtN0RVcjZaU3lLWlBiTlZFOUVLQjBUN3l0UmkxaWQx?=
 =?utf-8?B?ZHh1OXNxUmRUOU0vWmdDYXJpY01oQjFqaEx0bDlUcGEzRkx3UWJoYkJJVGhN?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QKox3ydyDZNl4HWDhZKhRIyhrGOIPdgCFGAGwYCkSRig5vPOoAQ/ygfWJZbcb01hNUImsizSihibMJtm2O1cWKTzhhEr1Rjd9552a3hI5fCmHBugwocfsPaguQn0nbGwyz5G6g/geh7mmeYotz1XR8BeFpoLyhguZc57VjWZEs7sIr2D+0hAyJbrHR922c4ALWXbPbT56B4OwIbYeQNzVLqjbQR8TU31OIDb9LbZf0zTkC9NNkqEMPGlCjpvqBboDaMs78GKg5zBkVbPShbyH5IdBjHO3IwuLqXFUqvhxHdUx8yLCE6PfEYxT05BlUAfvTy5mnilUzHy4SqZKpF/SRXXUVBp8q98sgM1pHoIyTlDgXDHO4z7wcG267klZi3i3RzHV+YswwkYQiw2CHmo/BPe735aLS5CbKQqZmtsg/3INZj4sDGUNauats31V7q5a+2Fad/RMiKM0NLJRcOx1Moh3/awwgQThKnaKHWTkF9E+tJAgXY057+cNKFrO3tz+U+wpXa4brOh96kOyq5TAXOzotUTrv+fe+rdfNPI4HPp/Z/IM5Yq3f4DwnWISey9LO6REoTEgBcv2l2HaGwYKXKWIjnTl4utbssLCYEIA7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37b4e2a9-bbaf-4a9d-b69d-08dd987837a5
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 15:00:25.7631
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rmy8butnViCilQUAxu52Av7xn6NnRilzrIwWdaK+kauXaYEvSquOeeBUYwsyZsL6Fvj55TNoT8QWgEPQ76W3/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_04,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=838 spamscore=0
 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210146
X-Authority-Analysis: v=2.4 cv=cYHSrmDM c=1 sm=1 tr=0 ts=682dea8d b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=MQ8o0d4i2MpUEuQBFeUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14714
X-Proofpoint-GUID: NmSkuRNg5xqFPge9RJG4RAZ8ctlI9Z4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE0NiBTYWx0ZWRfX9FG6i6vGwwPC WYOJX1wh+SE6qtzjLKSie2VvJla62I57ZUUynqsprJMhS1exq/BrCRUpKUizKyVsW6xneaARcgi vqRgKVT81wf45fiRdo3KqII6g4OtVxMC0YHY5mWirSxwGRFsw+0GI6k+haWb4GTM0JA9JktBAnk
 hp2Wz48qgjOIt40fDGOtMfVKPJpMi4tXjN1Lc2l2POgv68oSEv83VIDpXtAdLF0KkVcYTIyv1gg 3i85ZnMoEqVyCi7gBUpJOjUxEsQGW3IYJM2UjfD1Fhs/Q3jWAgrUN+ZkBaluwFHl1cFQlMhsXQ7 LfmYgJglUZYNKg/2pXoMqUWD1qvx5lsE9Dv9NxlCYL6OGTzSwPSV1a77Dz6qA7kHTJ56jmuoPUr
 fa8OVG6nrA0QW5MQYT93LbIDaUxu0ozyVUljQV7tWgCUvw4oZuRbhirmQ4QqjBjDj4Uhb5Id
X-Proofpoint-ORIG-GUID: NmSkuRNg5xqFPge9RJG4RAZ8ctlI9Z4M

> Hi Alan,
> 
> Thanks for taking a look at this. I've been following your related effort
> to allow /sys/kernel/btf/vmlinux as a module in support of small systems
> with kernel-size constraints, and wondered how this series might affect
> that work? Such support would be well-received in the embedded space when
> it happens, so am keen to understand.
> 
> Thanks,
> Tony

hi Tony

I had something nearly working a few months back but there are a bunch
of complications that made it a bit trickier than I'd first anticipated.
One challenge for example is that we want /sys/kernel/btf to behave just
as it would if vmlinux BTF was not a module. My original hope was to
just have the vmlinux BTF module forceload early, but the request module
approach won't work since the vmlinux_btf.ko module would have to be
part of the initrd image. A question for you on this - I presume that's
what you want to avoid, right? So I'm assuming that we need to extract
the .BTF section out of the vmlinu[xz] binary and out of initrd into a
later-loading vmlinux_btf.ko module for small-footprint systems. Is that
correct?

The reason I ask is having a later-loading vmlinux_btf.ko is a bit of a
pain since we need to walk the set of kernel modules and load their BTF,
relocate it and do kfunc registration. If we can simplify things via a
shared module dependency on vmlinux_btf.ko that would be great, but I'd
like to better understand the constraints from the small system
perspective first. Thanks!

Alan

