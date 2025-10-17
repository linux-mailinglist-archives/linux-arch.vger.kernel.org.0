Return-Path: <linux-arch+bounces-14181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC36BE6ACD
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1990F7423B4
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0700630FF31;
	Fri, 17 Oct 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N8frmyGi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qvC+hVHU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7A4F23EABC;
	Fri, 17 Oct 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681801; cv=fail; b=q1epGN4N+n1VoSYjgsh+IBj8z0unAafLatqu+0w8qnmdHrcCMOpDk2IVM4TgrluBcz+fRAGL05Ytx4FJBXZi/z7jrABHj+T11/ZkJmijGUenm5IaReAH8faKRVNP0wgbeR1XEquh8XurMSLTSIm4rpXn6cgBYvWMVjOgGLllfIg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681801; c=relaxed/simple;
	bh=lSclMQDNw8SJ1T7EpwqWtuzO/rCo+XXKppr+9alSu68=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=fGnivo8S/O4JuTiTWqICJBiBMCRg5WeLISTzAk7/JUIJ9usB/3Y2pL5/QV8ACotkyubcwtGdKyez7hgg7CmxrCU9uVRbZFBnqT2v0IMFaTZUQFQn+huDpZy+cL0n0VHdY7ZgBPTUxSkrx2IW5G40V/7GQU3ElRa3nOCivRBcEXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N8frmyGi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qvC+hVHU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLu5Om001361;
	Fri, 17 Oct 2025 06:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=7j+iIKp0pSFiYa9a
	a98CKox/LAZfJP3W1UNFFtJxsCw=; b=N8frmyGihx/UliKVBKxKe3x9mSZtr7hW
	X0/uJw8I/1vGu0QDogPEqyvmWvsVo71ODHPxgXjM7qxArPvcXKJjFCAgs8OrngAt
	QvU7N6VdHqUUcOugak3NWpIRf7N6tfVIGtruurU6yhS2AO7MmJ15JjGesL/jkG4Z
	XhELAH7OtFnR7zNBVH0mD4QTa1TNTR1J/IpTLQJi3CXaVSG/2uY8n0LoLygSCRTp
	HObTEV6rDkJYGt7fJLvFZAYxXi7Py+xaBWH6YFbj+unE+f7R8sMqAJ0+JAm2Yw/7
	2xQ2Lc0CQDf+G/1ZB+cp+3p6GdrSKJATYQo+AkISh9NedE6UgKzkNQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss29w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H3rVPP000914;
	Fri, 17 Oct 2025 06:16:12 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcnsqt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RsfS322yCtXj9EfmGhjVdKf0xZr8bQMo0j4pbgOzZ7dPQCcb0iJ4yT3pdUUzePzakfuz6vsJKFvYHgN2Q+sRW0y9boCUpECSemPBRCeCH3Ar+ooZwyiQRCEPlf4ECzetfowZTtkq/NNCkqd5Q/+6dTWkFVRqIWz3U6qCYdSnfVCHvKOdf4z0HJLamp3ys2GVW+pWI/LLp0/bMbXagLS/uYTCfwsQkFRNBlrQL8Pv7YljCK5JrmQ934l5piu6FT/EDnWz0c50zbk3lFAVdBx8Mck7mYySSiJXpSulttg7oDGfZGNmvjN+c1NSXgcwFjEJ40s7EYBaAet2lEYRs82AAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7j+iIKp0pSFiYa9aa98CKox/LAZfJP3W1UNFFtJxsCw=;
 b=unbrW+afy0Wh0tU6Ce8TMZMvCDRrxeRHBKDqVEVMSx8a2QG7ruTqlOOW3m5i1oNjRywGnTMI5/av2+9y6oSGjKWonSnfcESqKkDLziH3/SVvLoqjR6VSOtBTJwfgSdmMyWifQLZW9xTBTDIcWnpCLKxhJF9kM+UjqoS8i1JJgZ8pqHZUTcfoRrEv1cctrerRQ3a+nWnqesJ4ejIaheQPCN0XSkwfajyhmO86JKSClVo6eKXKw3Reg7/55v5DCrk2pfg7/eV4CWhyFT7V+AEKu8EcZRZsQue7TYz3eMHgh/P0rtGq3SSGigtaamgLyKTrV6dKfmLtW48vLm9eY/TT2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7j+iIKp0pSFiYa9aa98CKox/LAZfJP3W1UNFFtJxsCw=;
 b=qvC+hVHUSPpzFQS9O2YbC36vTgR3xeU0LvAT562m3VhC4AxpoMJX85be+MfoVarU5fP6NWiizVadpNP82TyWlNJCVjbk0LBYNTAWPEvIyTeW+WFZtZlHnDKOXmWN7bMGoTVQXW1RKQIP8IFLIDtZiy4Uq96OnIxdPqEGGPjfOJw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:08 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:08 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 0/7] barrier: Add smp_cond_load_*_timeout()
Date: Thu, 16 Oct 2025 23:15:59 -0700
Message-Id: <20251017061606.455701-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0090.namprd03.prod.outlook.com
 (2603:10b6:303:b6::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d658607-ef98-459b-5dfc-08de0d44a917
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y9GvRORzAQKdIfCnRs19KQsFGQdjcd7txtNwNGsYuG76eE9rkxhTzYsDMrXd?=
 =?us-ascii?Q?tow3tlYaqekMJdp/k2wllJKcPicgfSdHK2TvhN9f4XSyGJNsTPCVtMXLWB96?=
 =?us-ascii?Q?S3wKCUCr/jNrEnXh53lrxOfi35ECA/kQtg8qZxcV1rNwZWuKNmGbJOybL6J9?=
 =?us-ascii?Q?NVV9eBYb8OaLusDW/dpCGdN9pABDrset/khJ4jv1Zeu7iD0gUn42C5mcqTnd?=
 =?us-ascii?Q?y3fbwHVFlbGAkAVdSwDRtIiRKRJX+MiwW5FD/ZN7/O5QrXQvzLQZHhibMhnl?=
 =?us-ascii?Q?ci8n6/NUK2h/pJfwRyP6iZr9CSnuaKN3zGC9qw4N0tAHueATW34e+rrBhP93?=
 =?us-ascii?Q?azuk63qUlwQNVJHzYRf/EJLLQaGSFyzxFMrfHjGUIYVpKIJf9NAQI2cIpZ2I?=
 =?us-ascii?Q?uWPFHEqLaXsd/bv9bWJVsejmWYFDXe8ITaoP63oA1q4fqrBMyLTHZKlJLKMu?=
 =?us-ascii?Q?eQVUvt7SphGoYbPSFi9f1tW+QywgB2An1NjgbamSrEdk//sldoF6Dg6BOEqT?=
 =?us-ascii?Q?WdCJ/OXiEUR/qKTPXPS7rmM42kPveE1D2Q+6pCKIIaH+/e41LgAH9DbseUPw?=
 =?us-ascii?Q?L4jhM5H9BIelbIIL1G43SgAYtK4Oj/iJ4EDJceveG/0FSdJprXTnQIW74MKS?=
 =?us-ascii?Q?a7DtqQuSPwW0lXCm7izQJtVPNL/j2DId5XtKveYH9Ld/F8rMJigIljROG+Ju?=
 =?us-ascii?Q?kPLr8Gc+83rKzWV0/WlXQQ8b41YM+8tuHHCTVQML9ZJ1CvahUwcLcR+WifHp?=
 =?us-ascii?Q?uxjARRv22uUNfEwtgBdv8oagmgB0CyRiDj4fOnI2+GiKq3r4jxHH/qh3s3+h?=
 =?us-ascii?Q?DuI5rA0QnZAqC0HXH73WhBDUCCylR60fmsoUVMFexRuOIDYaXS3vupC6QlIk?=
 =?us-ascii?Q?nPHRrL9WpPprds6yAPDd2fFTyklY9xD6xokr4j/9YgxPzyYFFY9bEWjgsUlg?=
 =?us-ascii?Q?a342dAsEvW01OGfaqYVfPFo3B0hzTvEDiVhrecqCn9JzvAaPKA4NckvaND96?=
 =?us-ascii?Q?zL4GH1rP34dTJ8rfMPNnexiJjFbjf/5gBgTvWqmUUGOSLz4ShmcrNnDtc2zQ?=
 =?us-ascii?Q?bGcQu0mYs78rmMG1oXi51/TrCKuh2GmrqBEHYcH8aT2v+5leFERSzHBbrZ0y?=
 =?us-ascii?Q?ft+Iu+LENUcSQ1iBHoQpwRcw0LRGqPcJvIdrjJo3H4Pxg7B/BnV5iN8azdoT?=
 =?us-ascii?Q?wFKOZc13dkd1MXnvkVDToKbSGD5IlMwCDBBGJ5hFYaFr761ft8dRSP/ZGm5V?=
 =?us-ascii?Q?2hgA7Sun5Ntjsw5eNUDBbDZYCmOs/u4drMVoyW4yIiqKp8XqbcjWCQSbfl6c?=
 =?us-ascii?Q?6Sdn++TW6AFxpCIbJn+jKmb2gQz4+MVv6Z66gb4+yZ3JeWu9U6BO96/3NSfn?=
 =?us-ascii?Q?whCAR+O0oHUw9a5W5Xp5OSdgPaYpyNP6VDHRM+YtyRs9OpQxrZTerqDSUnyA?=
 =?us-ascii?Q?vQNKEDtSlVw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aBJhHmboglDmfe+DTF0bEeUHLd5oDGSLvPIkSYIUZCWoygGZQxIcIakiB6Ge?=
 =?us-ascii?Q?+P+2gwULT3gdQSgqMKbcTxdDXNqQ5OzHklAGjdu1bSLSsJUQ6jlCfHy0ErJB?=
 =?us-ascii?Q?3cw+xhvX78zW/fodRQ4B8uEoHjNTlZjSvn34uh73l82u6W9WdChUGtOPrmBQ?=
 =?us-ascii?Q?LvbZ8133QTzNCJPyyCRiX3SJA3N7aEk48RZhCgKT4/lteqNLi4Gw0sdhZCmj?=
 =?us-ascii?Q?q9wJd+doW616cH9QsA6+QV4L6r4E9liOI8wn8LABm68NOnpQmamy86KrA76n?=
 =?us-ascii?Q?5AAel0NFslVnT2qrdqwwv7kgoo6SMi94VXiaxg5I5NR67SgHarmf1nbQDBbz?=
 =?us-ascii?Q?G4CiON2bPpt3p/XKuF8EkvHdz57kZlbb97CUbm9traRuuQkuldbbFNVuk7Nd?=
 =?us-ascii?Q?npu9JAb8OBOZtPRKHEjSOQDRCNx5TNli8s4sfDjABqi+UhQjs3j8jKd+gX+X?=
 =?us-ascii?Q?HD/UFnaOh/oZU/jIZZQXh2fCFnitj4Ylu24qlro2prEwj6EhmW77lUlVcaz/?=
 =?us-ascii?Q?CiWlyfvdr4j21cvu/m9HRd/3dsYwg1nCBGj5fsrSTPzA0dNykMfjYbsCQSUN?=
 =?us-ascii?Q?6jggRSj0dRaK1YX6WNicDPzWFJfuXbeJWb19Zgaf3pYY2W8okeuB4VsgCxMb?=
 =?us-ascii?Q?CwQCVhYxO6hn95X2v2IA1dQIZrk2SU361Qq+VA3QSdELVq8bGbTjNUMRnBs9?=
 =?us-ascii?Q?nVryy/iJfPUx3/s/q2MxG7HtQ3tGypgXby3pdPEVIkPkMdemzuYJbGdpB1qL?=
 =?us-ascii?Q?es0li5RQnqb1AiSq9tINLDkD97kZFtSwNmllA49TPG4TsDZW4uRdcfhU0P7w?=
 =?us-ascii?Q?whdUzbSaBTdnHXpnIiha6sQMqiNWosNOUcNj/UY5/0Qvqf7OEzb5GMoueixu?=
 =?us-ascii?Q?2cJ+11jt55K/R0v3UeOaDOYOviBJNP8/JkeuDj8fumUU7Y9jbwznO3kW4Ey/?=
 =?us-ascii?Q?4TvUVXDKEIegn2TbuVxLej8afHWChnpRYkflEdOKboYBlG5tUORUAzpuh7k0?=
 =?us-ascii?Q?7ZpZjpqju/IideuOcVqbNm1vQBnSLplew9NXSC5Na7afM+yoJ1w616HbxZ5N?=
 =?us-ascii?Q?DJee8E6kdSkOzifgEgvV+e8k+5EZE3Zeoy+8SFlUL3RvZg8LElNT0MMsaYHL?=
 =?us-ascii?Q?waAUSmhDFaDQVq6VSPrdqoxGpYmjvJPdj4SBRyXDbvYt93LMbxrKNUFYGE6d?=
 =?us-ascii?Q?iwcPAO4I6ARub7XFBs7cSCNXK7pM1PP/T+ozkl2/Zh08iDNMS2d1c49zNmvs?=
 =?us-ascii?Q?sbo4wwSVfBbktaCkMWCz1AaGq/mG7cMSPI2a/Se/e+QgNCfof8MRwOFydFGC?=
 =?us-ascii?Q?n3etTfTOQes9pLE0xQ4wMgMPILsy8lQjf+oIWDYvzaNGkjMY8SA7H4lFRk1m?=
 =?us-ascii?Q?Tj5qnrdlmT70OjG+YhMeuMHAnso4s/SOiEU5UzgFzDzC4xcZzkosEAEF76GF?=
 =?us-ascii?Q?eq7Xrg+T76/hifg6qsUlZualL3I/yQqwVGbNd3EZO08AXGKgXbZe1nH9qIEL?=
 =?us-ascii?Q?aKRZO41tYyGiJjCyKYpF3gXwGKroU+k21yiYi5u5gSwYxqv7q0GboQssGJUK?=
 =?us-ascii?Q?niX1idS4oNJoWWZ7/ZlzjGXNNE7Dh+s2zDSQJc9gBmYtDMDU+VwXItIrOV3J?=
 =?us-ascii?Q?dA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	muITpvAYm373R5zCLJNVBt5+jQYoZZUM1uxhV1C3/FHbFvFScOnheYRApc5eR3ZV0P5k+LEugOCgjEKcSTUqbmdY62qQwRblW32+YZIJm7jC9YTCzhnRZ4SkBjskCaXELyGrWmwLwHnWiLaFRAU7s8PZls1plVGeZUK9Kheyr6tpL5oHJTF6a8rWLJJqqTAK4vmsxWZ1b0i7FtR3z4htB5B8JLQ4L5GaFNq/b7i167b0ebg3NohrsskZdRJO27vszMami4BOszl6f10FYznPRxDagqxKx5IU7bkaEHtP1juJEheCQSO6NSRvYoXm5RRVHnIV8iSd6ZTgReXv/0wCeaEBttqPgUi2ADQwFfalI+H5rydjRGL1TVT+YFPfPJYrdSpZBN4nq0HwfvJVET1g1ofnUSsVaf247tVBiBW/cW4oe6GGoh59SjWVGYuKXxugIipJJWkR7KN7g41Y4SMlBbmbUEDpnldrjIm+0Quun51t9UxWWb+XZGgKwcf3duSDTmNSOx+1ns+wa95vEMim0l0VjpwZtdcHLPdHhwev6ntDjGoSuFdQ8ZlvIeOpzB4BWzffAqgft409ibVRUVB2yPvZS8qiwRpkZqIKSUtZCi4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d658607-ef98-459b-5dfc-08de0d44a917
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:08.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nHZnDGVnirk4O4Im5oZrLC9Ox3SUaLdiqx4KR1Lz5qxn0IdeAt8Wg6sgz2GW/CTctJji2SYukEgVq0ufUXti66iumt2gPrKjf3wm/2GRN+s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-GUID: ExPBRJiKF3TGlCfuUBSKrRcL67BMCkEq
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f1df2d cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=QXDmnoQuuVSgSO7tUmQA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfX00CZSTy70ino
 BxPXmghQPZx4cQ8YrGJiPG6B7Pn8cia7syW+tRUGEv9z34M69qP+TOlN/jLD1FAkpz+mzEUUQ5P
 lZhdLEZtLOr5s1WQtGdzoE+dr1Dqd5/Vbv1NcRJ48D7EX/h3jaJ3hD0z1kQaweB7hV5N6C8owna
 sFOvZoKmbM0wWcV0eHg9uX2dua2Ag+CuzRue1485zzsiti/DsnnCc8QQ8ZcxT6ChgTsMFpwePff
 Qgplevi8YPASXI46UxWWyLdo6BdYNQ5SX21YmO7VMyJpgwbxK8kFnoZqc8Sve0z+RwxNIPzLczG
 G5YXA7a0cEF92SY3w2BVTVp4/dkBGMN9KgnXHrthqSonJjLpoYANZxwI1wbtS0eSytTBs9XpBei
 ysMKRuStYmtO5o7ViTpzrZpTQZ+7IA==
X-Proofpoint-ORIG-GUID: ExPBRJiKF3TGlCfuUBSKrRcL67BMCkEq

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().

As the name suggests, the new interfaces are meant for contexts where
you want to wait on a condition variable for a finite duration.  This is
easy enough to do with a loop around cpu_relax(). However, some
architectures (ex. arm64) also allow waiting on a cacheline. So, these
interfaces handle a mixture of spin/wait with a smp_cond_load() thrown
in.

The interfaces are:
   smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
   smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)

The added parameter, time_check_expr, determines the bail out condition.

Also add the ancillary interfaces atomic_cond_read_*_timeout(), and
atomic64_cond_read_*_timeout(), both of which are wrappers around
smp_cond_load_*_timeout().

Update poll_idle() and resilient queued spinlocks to use these
interfaces.

Changelog:

  v6 [1]:
   - fixup missing timeout parameters in atomic64_cond_read_*_timeout()
   - remove a race between setting of TIF_NEED_RESCHED and the 
   - dev->poll_time_limit was being set even if we hadn't spent any
     time waiting. (Comparing against local_clock() would be fine, but
     I'm using a cheaper check against _TIF_NEED_RESCHED.)
   (Both from meta-CI bot)

  v5 [2]:
   - use cpu_poll_relax() instead of cpu_relax().
   - instead of defining an arm64 specific
     smp_cond_load_relaxed_timeout(), just define the appropriate
     cpu_poll_relax().
   - re-read the target pointer when we exit due to the time-check.
   - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
   (Suggested by Will Deacon)

   - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
     interfaces.
   - rqspinlock: use atomic_cond_read_acquire_timeout().
   - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
   (Suggested by Catalin Marinas)

   - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64

  v4 [3]:
    - naming change 's/timewait/timeout/'
    - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
      and fixup use of RES_CHECK_TIMEOUT().
    (Both suggested by Catalin Marinas)

  v3 [4]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [5]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in hindsight
      unnecessary constants.

  v1 [6]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [7]

Any comments appreciated!

Thanks!
Ankur

 [1] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/ 
 [2] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/ 
 [3] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
 [4] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
 [5] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
 [6] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
 [7] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
 
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (7):
  asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
  arm64: barrier: Support smp_cond_load_relaxed_timeout()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait()
  asm-generic: barrier: Add smp_cond_load_acquire_timeout()
  atomic: Add atomic_cond_read_*_timeout()
  rqspinlock: Use smp_cond_load_acquire_timeout()
  cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()

 arch/arm64/include/asm/barrier.h    | 13 +++++
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 drivers/cpuidle/poll_state.c        | 29 +++-------
 include/asm-generic/barrier.h       | 63 +++++++++++++++++++++
 include/linux/atomic.h              | 10 ++++
 kernel/bpf/rqspinlock.c             | 31 +++++------
 6 files changed, 108 insertions(+), 123 deletions(-)

-- 
2.43.5


