Return-Path: <linux-arch+bounces-9981-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE25EA26611
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 22:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D93E188596A
	for <lists+linux-arch@lfdr.de>; Mon,  3 Feb 2025 21:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F9721146C;
	Mon,  3 Feb 2025 21:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Q6dWTm99";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oq8TvaAZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAFB211283;
	Mon,  3 Feb 2025 21:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738619385; cv=fail; b=Y7cxUostKkljwMCBup/IgAG/ob3v0DMkF4bhZ9d77ZPNeCJ+r7hEL7KmJtkaXWpdqjLj9BNZxwt5vS1k3zf6ov2vNJfe8mX2JUmvvDd6zFd7jaLsCw0H5HkUIQHTAKFizen0Yd5jSBHDcvB1Mt/OwZqqRyscSaBIZMR18psKkz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738619385; c=relaxed/simple;
	bh=g59dGAMw35w/jv3Of2uN0IR+JdFHIg+lSNk3QUcileQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=E7+GmRXI+ZBsuCosETwqYCdYd3aDhFp+hdy7yPcBrv86SvHDFvBs0QVnRNWdNs+mrrTYj1nGRnqHvxSxAo7HR9gfG0mxtYQr0unrODerN1zV5UKP+e52EdhbF3OHLjNMMa4KKnki0Nkq5j9EDwzmRjRCdwcjHTyOwVmSGYOKIJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Q6dWTm99; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oq8TvaAZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513JMtHA001047;
	Mon, 3 Feb 2025 21:49:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Y2i0UFtOm8h8GVwyJybfRKu5genIQj3zDzS5If8eYcE=; b=
	Q6dWTm99796JurSr6TL+oxA/jTsEBYfM4BzEgdi0k7xXu9N5Q5ioJTRHOoogjkLY
	HM+jk+0LL9HTQhnah+7iFcdaqSPpmY24oOSqYk6znj0lKxJCZr09QWvu06djqUCt
	HnazvbyxA8fkrjpKltf3pFyV5LNKHcXasec23Mf3/f8Sejl29cTlJwyRZkgpb3ZO
	+tZmmLQFWbyLSgweXA3VFtzUtYz/TLzcMfwX3oi2+TCpsVfHkxyUD21lwjpJ45Wq
	3ZCSwdOk62OldaWdxtWRqfZL57ZQKr01L3bmAUm1VXPEXLAYkAQTCCBeLrP5gVWE
	q9IkBwne0UVORukNXwPCHw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hhjtumu1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 513JlCRS029079;
	Mon, 3 Feb 2025 21:49:26 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p27131-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Feb 2025 21:49:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H62RyAECqAINgClBxFMFWRN/z/ge1hu/f/gKMwAy3eZZIFm3I1ceCLhWrF90oA+kOnDXVrct/yKDu/m0pIJIedq/rHkvDbhFlCz5ZdGEiSGe6ksaS9OYxn9AipxL64Pr4a2m+gqraxLfIIhZqwbs8NnJb8upwDmiVganv3qzSQmALaoz+jzpTBEHyej3jym3KwcBs1GkUimhlVTem84aNOMtZzx0YPB242Zrx7fXfvYkpFvFT3pi0pHJwmlgJiBkKcXxdZVn5tLGGdKksxjj5ABZnrPYK8iCSVWHkj5/7xW3/4pclEt9cE0TvrTAEOLg8ttgEHQkJOBbNMnb79UGuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y2i0UFtOm8h8GVwyJybfRKu5genIQj3zDzS5If8eYcE=;
 b=YThBnri1nYjmmNxRENmjnhoIFW7ff9LqAyAZN1n3OSQarzBMS+nv3QB9IMqoT2B21oCFaUPw/XUDslwy+ScrSc5Ugjk/7QkUtqYM3xGH7ARGiuYNL00SO4Ba3xXOKLwxDV9HkG1vEFI4bKVbM+Qd/7CcAOTMpTqR88Rg9OENNqeysjgHGu0o0qClsml/+kzbgtSRQXQe10oDNROjInXi3zwns5CFi2YEf335Etuq83ImwYLCxBhYXymTraL6ugm9eQJ2n4WTtGhctmBbZ+g3aPWqVYiAGUahjC2fJcHDNI4eILxcL3Afgts4XjbtTOEC0PLq7juV/F4AJlfTa1sxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y2i0UFtOm8h8GVwyJybfRKu5genIQj3zDzS5If8eYcE=;
 b=Oq8TvaAZC8Ay9/TtYiwhfDW/r+CkSAt0VNWNp8Jem9hq7N+M3r7XpzK1CI875Eig4oAdEuurGj/KHAavJHAIa85Kz4T+KooAlZdlCmA2qVYoDSHYXWByRzd50wVFM95SbCe/FnfxpWkf9T3xTkgTOnlYGr3AV89l3KiZaBJsKZw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6854.namprd10.prod.outlook.com (2603:10b6:208:425::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.23; Mon, 3 Feb
 2025 21:49:24 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8398.020; Mon, 3 Feb 2025
 21:49:24 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH 4/4] arm64: barrier: Add smp_cond_load_acquire_timewait()
Date: Mon,  3 Feb 2025 13:49:11 -0800
Message-Id: <20250203214911.898276-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250203214911.898276-1-ankur.a.arora@oracle.com>
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR02CA0021.namprd02.prod.outlook.com
 (2603:10b6:303:16d::31) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6854:EE_
X-MS-Office365-Filtering-Correlation-Id: 7799147e-1bc4-4615-fe36-08dd449c9f90
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PXCxF+i0+HHqAwZxw1ZxAK9Bo0YvVsnat64FCrYWCsNsIgi2VG/WQq6/Z20O?=
 =?us-ascii?Q?D8/S20R0iDM635vna9/pFTfrdi7L0xXIjUgOYNYv9a+//sP1Vs2fRIgSRfIL?=
 =?us-ascii?Q?AW8VwrHkESZQtVa1O4hek0yqhnBTu+Y5c5Sq0QLPimbexL+pjCObyt3GGEJc?=
 =?us-ascii?Q?pz5Lj3m1nxytUqaJR+DV3FeS/98Jd+vbJbpukM2iRAsDpEYusMDJZLSUy7At?=
 =?us-ascii?Q?9/cPQgTNO8ulAHXV9nDfZrtt3DYuHi1RHNulLu5mdwM0iwTsSMdCArRLmwdX?=
 =?us-ascii?Q?5jQmUIK00bPcbvyz/Zm6P4EbgVLiePWZ29S80bjziCQ+UUkiZbV4bqSnnH40?=
 =?us-ascii?Q?GKPmfP/baBcySE+3wsrzPxYBwn7QwNLyFAMEe5BFSY2seJBNs9vnPCzfyAB9?=
 =?us-ascii?Q?bV6IrpQkaOGVgb/GEJniS7claHFnqDs9nrYSyHBM6HvUJ79d6uX0b9u4nB9H?=
 =?us-ascii?Q?EgLEC3bBgNlQqwe6UScgzxLS+qgD0ttF6hTAqO80LsP08mPmgv8gRpCn7D3I?=
 =?us-ascii?Q?JQiX9xHeMykgTDM4sV6v9Jo9MW4l6GTfkC7S2ZrcsbTEdWQHqRvE1FvB4EvU?=
 =?us-ascii?Q?z82oOgV8mqqf74Y3kL+cx6Nz+FAooDGq9vPU2q4Lj2QUx2e+goiZhtsaydgW?=
 =?us-ascii?Q?Rg5PJkBR18wGUacd1zhfZH30X3yJ1yLWWThn6PLrNBhdvsmg1Y/7ghPi+qdO?=
 =?us-ascii?Q?JfBwHBK6kYTQaVC3h6jlTXX56p/AM+Qnkx0XRe5zv1ODNW2sSEYjZYy/yOvl?=
 =?us-ascii?Q?GJCe1RqWziopbzSQqLK95xe1I8qcu97/Tn37f0Pl96RoeCksXAO7bx2hB4p5?=
 =?us-ascii?Q?UQnLqWRZnZtsSPtAO9tAnzLL0BlJmvnIuEFbRdcMHyAaQzBMPEYe+pPhLdgR?=
 =?us-ascii?Q?2IcOIbinS02YVNx4XEhAzv/obokUuxmQCL0ldXt2UK1jR8Q8QqkgeZkZXku7?=
 =?us-ascii?Q?EYzQMv3ci8xBE/4GAv4znrCJvHXJtmwT8GRlh8S73tB3+1wh/wOuj5bfKNm+?=
 =?us-ascii?Q?VbZWXtzgE8UUnB7TeQenLjN6N3EGwEk9Z06rYHa0EGrTSxM4T2l04doDcoTk?=
 =?us-ascii?Q?KLFzRA/LwDdykL8dw3xqPzVglN9I+txpOTwWtUt320tCk0kEPTB5HpXnTAnu?=
 =?us-ascii?Q?bpcovb0hBBva/5FjCFqY+lfKBQSPv9jaTt6UoO8MSdLexbc32YBKDKfR2YS1?=
 =?us-ascii?Q?Fs1pkSh+8a88JqQJVuEUeFMi7JcQoSP4mvWeSs7f/crrtdI0oF/Uiv+MZRoA?=
 =?us-ascii?Q?4jpybt7m75WhW5+HSpkOkn++lxNcA543AubVW6XrGTXhJORuUEdDfTIqn0or?=
 =?us-ascii?Q?1ilHJdanXWLqHxSNFc9hDo29R6Ja40+2Ve/L7/07/bjRV3HSvXPWpbmdK4Hb?=
 =?us-ascii?Q?d0HZHCP9C3FeRbPXlJFal9ohftST?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oEz5ijhQcIOV3BCEwrxpcTN/CrWj1tD3gSCK3ui6WMiZyxvHQXMexTNTSr7K?=
 =?us-ascii?Q?sC5Nxz5NS+0f5cykgLp9dZbIQPeIR3bmZXlrcScIDQO1NXIRTLvSnOXX2GMS?=
 =?us-ascii?Q?i3tJ5rLQ/h+QcA9FULgSrOB5SxU4QM28QrrjLCrXQ8ZsPP7FzEk7TkUM+Hif?=
 =?us-ascii?Q?PwzapKvvwRJTLIwGXhqEf0/nPRblKOBB2HHkeOoLkfjawlCSP7Dxqar0QSpu?=
 =?us-ascii?Q?VUdVPCyvsLMUdV3OKrSiPhGofCi3RUF0+5q2Q1a/jiyRJNlbbkID9j+MySde?=
 =?us-ascii?Q?YC1RurfD195o6G3BGywBe33YBG094/4tybXGf3akdYXnqh6DqGvlWQH8A13I?=
 =?us-ascii?Q?Kmz/x/OVNedj6EoL+39jFqP5+jD78Hnlon13mv2BBElK3xkjE5r4e/QdvbbU?=
 =?us-ascii?Q?UXWxzAByxT57kb3U7nDYSwWDtyjiCwgDwvfDZ6XW55pI+zzV+jvQlYZh/xva?=
 =?us-ascii?Q?AxGT0E2mok4akmExY9vGX0xzTVSCKe8cB4eRu8ZjMNYjPNrX8iSwOVO8vjfI?=
 =?us-ascii?Q?43pdvuvv6DwihE4wxnaF+bZb4mORrwTgj5QEzTY09/0ENJZNkAPGoeZTZQzc?=
 =?us-ascii?Q?9y+aumAl13ZTw4a6GGChQtAYT3DA/tH6U6TyAt8vJTsyragbTuyPU2WCpELp?=
 =?us-ascii?Q?StwdavjV+e66uCGmJOdSV7NSHQpfG7+6ZQu7l6onfkI1A96NblyzJpSMkA9C?=
 =?us-ascii?Q?cLub+js/tVVvQTfuUjdEoisusKOb7zKZGU1OB9IwMHwn2Z06mAR7pxVNh1gV?=
 =?us-ascii?Q?NBMgYdTQD0C2CbY8DytdAMfDOZ7xJlUl+Co1wMCg5g+prIGt3GwE3XzANDev?=
 =?us-ascii?Q?M+RwUFhBhYjmJ5nxrm8StFC27P+oJKvkY4TNs/0FvQ3JeEytVZe8/p16qsBG?=
 =?us-ascii?Q?/ptnstPb13ebxgBYrKyg6vaJ2jJkyphzD5dGwAslEnHWKfST7M/dNrjn3/28?=
 =?us-ascii?Q?8PJBTwKX4hwRfYjOMJN/MteGdwagkMSwmHQ//wr7WP2+9ZeLHGJW2f5QtIl6?=
 =?us-ascii?Q?ub8606Aya8rmTb/3ieesPcnBnWCZ8SVMOgGxthUB77sp7jDJFEsPuY727BwE?=
 =?us-ascii?Q?HwAPBTzdIy3GtNSoa1OMcXIvGTRPEunQaT0AoCD6Bgd9rFu6HH7tjnWjTuD3?=
 =?us-ascii?Q?KY1M/df95Xm3BGg4DYu6YtKwr5hj7zRVO+7ITLycnDfjuA7J0bEWxSYu3no9?=
 =?us-ascii?Q?ZQ2k7QDU16Y4yrFiJaZ0rggMFRIoBgyo4J6YadbhClJs0RhAKf1/i/+cXxbJ?=
 =?us-ascii?Q?ewvlt4umNPJs/5AoYGJJBJfMNyPIU4Pyb5kX6C+TdLLxUWGArIWDA5uzrWjx?=
 =?us-ascii?Q?NbjDa5mYjtCs+uGC9BDXapJRkzru5d0Nac0V6QStYN0HtDrS/Skurt6tMyPZ?=
 =?us-ascii?Q?VvfnAdgdftOV2WybmzYjkTEBZVKYyK1FQiBK8Yp7+URLbRj2XK8rPbEfr1OK?=
 =?us-ascii?Q?XTLZiWKYZBJ4sNDHObLT5xQ7S03Mhc3R1gY+eYBubl50RaICnXMW91dNn/mT?=
 =?us-ascii?Q?Y+vcRdaMXxCiqh/yIbbiXkoyWJ9xJE0QjqexhBGYCuEqJqI46FcKZS61/Q5R?=
 =?us-ascii?Q?LKB02S/tOmqqL7aHqrMzZ8wX4bmHw07yS6W/X26pFhb3m1GDD3qlC0Fzemxj?=
 =?us-ascii?Q?nQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lifen2R5PDmmQ+p07tI7YPnmmaP7Z0QR+q5T7yFh23387tbXPkjqbwAQtSNVkomIiXqS5wy2klh6myNO339Q9QkcgOrExmC7Zj7z5yWX+uDrFGmpGrh5WB9b4cqo0ogZdu4IKOy6OK0PPbUyt2rEDwlZiQTgRGW4Jkag2+u4fz2rcRCg/5FgdRgSOEn4a4rpPLlm8GymvL7DPTeWaeAwt1uITz5o/Db/BHkoRccCrsqvSIP+z0iofhvvrxgELIM6T+b1qU25OLf6NQqFOzO3fo/C4uPDCH02SdDUtwLWFZXuKv/YdjXqbVaKL99uNS9ReEswsR9Q5iBs7GyzUYFziW02IUZFGxQqD5QVYxsyoNfWLcbKOH79O80jNId+2YLtBUfd4QCyxckj0CW19o/2mgkeywLtoqLod1crS/Yi8d85O2OSRQBAH74oOjLqmDprZcx45REQgcrsmiRrUqKsSNzcSUVpuGVsQLQW3P816wqEyjMcdtdbHFM5K0UjP1b9/eb+0H8J2OKGvlz3B45xhCmDuOVJTyDK44IkQXRmpyrxHlddJBNgFkaXjaUjMygjRaWmD8czpcsT7RogxSg6MnXPbIvRb6zYDMZPg/0hN18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7799147e-1bc4-4615-fe36-08dd449c9f90
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2025 21:49:24.0606
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVQsUxNj0ehuZCTwo5ZcJJXGQSGaUJ/ZyzISYNe1s21AWJRHg8FB9OO9ywBdlUk2rKdSRvADtHrJU7CmjsEM+4rYuqMISbBkULBBEz8n42c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6854
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_09,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502030158
X-Proofpoint-GUID: QdacrseF6w2tloYXDR-VjdGOJRI2ZTnZ
X-Proofpoint-ORIG-GUID: QdacrseF6w2tloYXDR-VjdGOJRI2ZTnZ

Add smp_cond_load_acquire_timewait(). This is substantially similar
to smp_cond_load_acquire() where we use a load-acquire in the loop
and avoid an smp_rmb() later.

To handle the unlikely case of the event-stream being unavailable,
keep the implementation simple by falling back to the generic
__smp_cond_load_relaxed_spinwait() with an smp_rmb() to follow
(via smp_acquire__after_ctrl_dep().)

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 36 ++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 25721275a5a2..22d9291aee8d 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -232,6 +232,22 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
+					 time_expr_ns, time_limit_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = smp_load_acquire(__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+		if ((time_expr_ns) >= (time_limit_ns))			\
+			break;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
 /*
  * For the unlikely case that the event-stream is unavailable,
  * ward off the possibility of waiting forever by falling back
@@ -254,6 +270,26 @@ do {									\
 	(typeof(*ptr))_val;						\
 })
 
+#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
+				      time_expr_ns, time_limit_ns)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	int __wfe = arch_timer_evtstrm_available();			\
+									\
+	if (likely(__wfe)) {						\
+		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+	} else {							\
+		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
+							time_expr_ns,	\
+							time_limit_ns);	\
+		smp_acquire__after_ctrl_dep();				\
+	}								\
+	(typeof(*ptr))_val;						\
+})
+
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


