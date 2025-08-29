Return-Path: <linux-arch+bounces-13325-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD9C7B3B58C
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3853188D991
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 08:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74682C1597;
	Fri, 29 Aug 2025 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="CiRaqbRM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="u4e99xt+"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126342C11C2;
	Fri, 29 Aug 2025 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454898; cv=fail; b=ua1fXrXwzawoB17G2DNw0/bj0UJ34e39ctcKYSljdU88BQnXmj2g6rW/l3kWbTovN+19lYxogKB3OnPWVwcQB1BzRWSGGVkQyvLkpRqW3HOoApjtRHJ/gIso0YemCZDfmgL9Ysax/EY1r996QmKKdxrcZ/AXUWZ1XpooFJFTDsk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454898; c=relaxed/simple;
	bh=aeZh+93f0Ti1YfoaHb85RUSzq6SCNqBka7uKTwXbGvI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQZe8ZhqN9iCha8g5jphTG9yT3T2FKod9ftA9YioMW77PRMMSzZOf8oh8lp0FIM9uMk667xD0FKqGQKE+6hjTCf+e0mdN0M1OMNlfUCIQcC3+YYiaaDNHhblzyWBXerEHSE6qtuQ5N8p0V9XFqsIR9HXKmG3FluKR/6boGq9Z3Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=CiRaqbRM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=u4e99xt+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T84A6D020546;
	Fri, 29 Aug 2025 08:07:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1YZzq0T70Q0JCakVZFpXKs5q1o7B10ojh7vzt/WaCik=; b=
	CiRaqbRMj0cZ+sivSkPGHLrdiQy87EdGOTXb44r2BO0iapb9iD/UZLra8ujI9NPD
	4MWNSX3gkCdDPpjoAyHr8qbsYtAyf9SLYHKZlSORXnuz9aJXds4faCnDIJjc47cu
	R98LL+iE8R83d/dFwAmNRZKIVYo7CW/Qcg4a/yVsewTUQQA5TyIpmh+NsGaAquyj
	pwYnw3pdkoQ/4kZ9RCDLczvyG+9eHL2L90SQ6eI24//USH8STQAucmc5Q7GVWC7h
	ZryQO54fR6zk+VI0azeUtoOM05uXI0CouVtuItdh3Pc35cZDgt6ADkgQ0jbLdJbZ
	0V51L7L/1CNHzejEIBNXBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q6792169-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T7j8LO014642;
	Fri, 29 Aug 2025 08:07:53 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43cv9d3-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MnE4tznhhWaHkAfACdy/P3mieCrBhQBvY42uDA/HZ2CAgWDWySC416rZZ976+vn+6ZA5+RDkf8ZdGyuRvlC2J6Wy3VlTDuKmITmkJoNCYKV1ieuKtM2WcrY6jtto9eDYvM4FmE44IY/Pk9iC9JpDcIyKSrnIuHi3BWBfSGh1fQyM95VlTYBoOCCpemc6FFu4Hb+lZlua0Xxmf3HFfZQBakytjg16DqFcRM9dDAzIXNF4oW7sZN9rblRC12A334w2Z+QUqKFihm1PfFSBj5f+G9Q7x6luuwbcYZIcIJrJ+lDpR94QddbXKCTCfxpgfHWFTSYiyzCQ8uda5xLzj5FA0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YZzq0T70Q0JCakVZFpXKs5q1o7B10ojh7vzt/WaCik=;
 b=pG/5B8PVaKHGticuTYHkBS6b9MfIsdxCJ7Vfilxg5VyC7Cdno4EKIbZ5V9bjEAjW7zgbor7NBwYvjq+Txz131Byx0OBEidfiwEhPQSOrdXX7lTXPG9Wt1b1g8Mrt6WerKNgwZFQct4zx3KEdSRAokZqal5d6EQ7qYPyvUFTdjWFpdtE6fVtYdxVwZNKnbeqBMorKVEPqN0qRB6SAxqqFs2oFOjzmjC9sE2kYPuKfKKnxWUlVQZFXx7kyLgM+/iJOQ5NW6EHV1OBfPVVjE03j9tPtiYEwE2Ja+qLTsuP9cDWpdlc0QC6Aaao3JrfSavwQtepnjLJOl027WuYAQg8f6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YZzq0T70Q0JCakVZFpXKs5q1o7B10ojh7vzt/WaCik=;
 b=u4e99xt+TftFDTi4e7tFe+Cbdr/puOsriRelNvpRaKHlr1XgX/RiTKMjsvLYDvxaQl4Noab57ug1/gvNI7wrjhazHKnUvh9mV+F+WLRWOcCggsxrjza3+kf+MQKWMD5qPeHodEkLMkkNxXNEkvP4nvJ/9Sf9VGwgNZDXaos9LvQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:07:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 08:07:48 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 5/5] rqspinlock: use smp_cond_load_acquire_timewait()
Date: Fri, 29 Aug 2025 01:07:35 -0700
Message-Id: <20250829080735.3598416-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0164.namprd03.prod.outlook.com
 (2603:10b6:303:8d::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: 258883de-af4b-4199-0371-08dde6d324b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QcztW1ZOZNrX57R1v7eGnPv8lYtasrVXhOetMNpevCrxeipnsZ2O7av1yVP2?=
 =?us-ascii?Q?8Rr71kxLyuuC1nongQlEzz41AxZ4yOOyJYPyu84ugBjpm99AGdy3F2fJHU6U?=
 =?us-ascii?Q?ueA8Q2DpDQzJTZ5V8M26L3p69QYHOQuvTMzBxdSl/PMBzb5C8yOvzqt1bdN4?=
 =?us-ascii?Q?k4u2S357U7URfr0qNFohzlac7LWtvu+aRK3BdN5gukf+sq/Xlx/cWnknXz56?=
 =?us-ascii?Q?S3rPGm2v6KsdrXoR6PFkZO9vDk8gJW305r6I+gn7GE0H6UElYfKZyYrvNwit?=
 =?us-ascii?Q?tHIs+2ViWGaTpnEpwbInFupc0vEdQXyECMXPoCLdeVpjYrbKjgIH6FTKxmou?=
 =?us-ascii?Q?DQlOaSbledKyJQmaEkfnydkH4yLFMftzkip8Wueo2KvcPeR6OCfNku2QJVfq?=
 =?us-ascii?Q?0r+dKbKuZf3sK6ls9fNXUAJucmdMEIle73aHbbc3mttdCV+eMgpsnfzyMPpb?=
 =?us-ascii?Q?NLc/M99bfC3eGErMg/sRG5NXZSlI4n/d63jNqjQssMBYUODBkJgYIlDzNezS?=
 =?us-ascii?Q?4LH/D0oMPj23Rkj5VLs9/l4RzVLcrk8j6O9Af+Rtmjwqtt5GHMrD4TeuRMX4?=
 =?us-ascii?Q?IPA0LBFPAbFyyxxmpiFaj1rr1Ypqvo3fF9zx8SmjBX6lDBR1WrU/0rnWnoXB?=
 =?us-ascii?Q?6QqeXpwpd/OpVhEj38aAC9e+cVGQbXOlzFpy3slCfJTGtbntEf7U5Qa2hAc8?=
 =?us-ascii?Q?Sj8Rxh9z7QMn1kVkq7RLpXYD7vzMAWqpCGXAxC00OuulwynGnTVIMq83ttwY?=
 =?us-ascii?Q?sSqT60Mp+DDNKL5U8l4JlDDZ3/3kPAK+CnQ45cmbnpBPa1zew9BejSOOr3+O?=
 =?us-ascii?Q?YUVKK69Ft/ZxWt5IUhplq6MNTvNkvTz1rb7gIQPWegqt0FWNrTv0gxBLefFR?=
 =?us-ascii?Q?o0GIDKT2ibT7H1zsyAQP5nStHHip+w/1J49nYNunopYbu/UxyizOxAqdWmj4?=
 =?us-ascii?Q?0ThFYo5se4FzzsTBJTUUsDArj6QjvqHzM+/FLs4S3nG7K44i14RO0i4B+tEj?=
 =?us-ascii?Q?n4VH75kusbX774uYM7/NxkVSL+TCSKwBX3pXLdS0x6qTcGFYOx82A5WHlU8g?=
 =?us-ascii?Q?y2XQzdxMThbhfmxJOgh+W+Eh002xwVrm8l6VoR8kqVRADj90fTNsfEg8yyqV?=
 =?us-ascii?Q?UD7e4dTqVuZxw2AzVse2RIv2ZT04zaRglyD/gnTMDzepmPK0j/x9Xeyto6vY?=
 =?us-ascii?Q?2agWbBje1hJOxS4jSa0ZwijeACb1WFaFIvRT0VEOQQrm+DRQPcH93gyjD8Up?=
 =?us-ascii?Q?cy/GI+8u49v5eGHzTg0/vcZHMzOVaEaSicjwweesVHO6CPR7QVtSCfSxO5SL?=
 =?us-ascii?Q?qjuvlP6ni7RVYpaRyHuqUOnhAzC7CCpfQvTSJSGMliHsWqpxERt5icszRjIE?=
 =?us-ascii?Q?S3jojB+2hNoA2M+jyyOfgxxgE70INqIGwBIrfjl9ixRf4F8NCTBGpiM/15Hp?=
 =?us-ascii?Q?yK60/WRJAuo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GwUrBvGNJUdbEkr/GEt5EZjmr0Njl9XcFTNst9/kWCrFe8nVo9U/1/xYVUay?=
 =?us-ascii?Q?BcUTER9RsZHxOUwpVTcybQWAYfCWOVBcTA99KjdMUNKckC4q9i9vrndOvmCB?=
 =?us-ascii?Q?WVkXtQ0tGHLNHIEfuTcgowIGLHUX0xs5ucrqsfahY7jfAA/gNT1pU/uR4rPm?=
 =?us-ascii?Q?FK61GLiMtpUTB946MeYM3MVG/QIjAagja/VfxN7XYsSBRxOJiRphxZ3ToxOh?=
 =?us-ascii?Q?11sZLDMRWRA+J/SkmOvzN+tk6P6i0pcCkdcLiM9jOlamJroIVAWy8kOiRE1k?=
 =?us-ascii?Q?mWxF3ugvKxlu4/R5+T+fUOl6b/MSKwI7l65n01/LQ7gDVOMXvE5WVuoL2x36?=
 =?us-ascii?Q?Z+AV+ZZfKOXPS00J2Tdo14Z3Db9ibTWIwsgsazGu3wriIyE/pLN7Us66jN/S?=
 =?us-ascii?Q?RIXef2RA5Qtn11qqeSohLzCy1/34UPox515nd/hWUMSiyzBQQNfVfot9oJME?=
 =?us-ascii?Q?zUJMUNnl5wsl5RuQRZ2bQRUmMOFgI6NCBnO7iBplYZ4rigT6RLZuUSRdwTeS?=
 =?us-ascii?Q?CTCsIOCWJCRVuY+HA5hCeqPz1Dof3oau6iaNhs+VCbPcD8y87lZmxZbcna8y?=
 =?us-ascii?Q?hsOPPsWHXYYnNim1QP7QmM/zyTuZcN3nSp7+xSO7WpETaFQ3pEV+B3Kx8N4E?=
 =?us-ascii?Q?Ae4nSMuQF7YoZsmkwxaEq2+GgHZP+vppUuHmKiq7b+fskxNltaFgQNOjwpAd?=
 =?us-ascii?Q?845ZXk2eGKKBc/dpvQxf5E+/PM14ma0+45lGfFZOXHTONO0CrQNCuqC3zIcU?=
 =?us-ascii?Q?wjpKRYrGR5SldETyAUBT3aGPiQBgoRCuqy/yepV8d9hSxuf8lI2aEooM4izo?=
 =?us-ascii?Q?92zSNruTmW3waZnpV7UybQVbq+T8nbvPr8LsQnmweYVZ6mVKso1vcDApXO7x?=
 =?us-ascii?Q?chLPst6eydO5r/74gVwyqdFIJZU0kmsq8DEm4kFUBLToUt3mTNxauQGMLyyv?=
 =?us-ascii?Q?aez06cvUDsuHZolV+aspq4wTfGwN/KvXPW3ewwE5+UCfdXAMaaHhi5ED22Bw?=
 =?us-ascii?Q?tjW0qCBxpCMvkaBYBIE/FjH6F0fJh7SH3ZmH/7UwBNllkTEDzx5mws+5O3Ns?=
 =?us-ascii?Q?U3Hfv8Ypn54dgbRNYkds/VmKW9XWFItQD/Z3XDAZX7R0y42cxUxiHqWFG7FT?=
 =?us-ascii?Q?whKa80qXZ4jz+0LjUCbhlv6TEL2i1HS8TFK5LtI4aOpSbHFvPXOrq1jml3sz?=
 =?us-ascii?Q?wLV7Gv+feMpp/n+O2RA6A/Zdvl2kjUq5GUniZIsiW5AY6onXI2q6Cec7CMeU?=
 =?us-ascii?Q?srYTmbOyOg1lGkisWFlKYUeL5kXveGz5cnXXfzk2eB+JFcvdkBY8FuBTHZfV?=
 =?us-ascii?Q?XyrN+GOTCVtMU7v1ayhJSYPO9QhTw64HjG7SGTy8O0WrZZMVp2fuWwI32y5Y?=
 =?us-ascii?Q?ipKpTjeplbOXNlLtentTY76IWgyeMk+pY6jLGgAeOqXoEP9/p8HcMtVndko5?=
 =?us-ascii?Q?yeN/GFu/oWRcWlYk4wY5Fnd/UaYcyjdZBSTX8o7xQxMmPd9DsBD/fBBwnYrg?=
 =?us-ascii?Q?sUZ5sCwKgFMKfxGhuPPAgDdF8rNnyJRNrQKf/WoZLVxNI/OqecsFgxlOgDLx?=
 =?us-ascii?Q?bgUff8QSbC6yn0qgDr04QFDG/X3+T1ANjo15QQKYgoKxeJ7NqxySgWMfdArt?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	yXCmaWTzqNnYNAipmghF1ZxycOredDRLTy8AV6Y4KwZWnkwFxCsrpIOir+biihKrWw8r845wgMdAMwwuo9wWUA206l8rDdgCQLLcRox4uXYIYEBlTPKuLg/jTAV/3D07BCe3b7yyL8odew3aGuWZCibWRtyptzMwAXdgIaJLQoUbKj6jJ1PLaqQMaZEN0oL7A2oSziKYwi1whsC006gdBvCw5jklHzTXK+XMObnIPMnvIUc0LWeYp/7Felz6/CcyaZu5K/S7Z6NQoterh6X3ARNdJ70KgnE+Etf698lA6OpT3LLlUVCAArfmQb8VpzI1GxlgI7m7Uu0b0qCDcB/qXLlYlHIrYyE+DJ73YJFOXf4Ophnw0HjqTYIRnOOqsmEJlIzNc5Uy/nNSS/W/vLN91lXxnmulJ1ZIHF7Le8UfiS+taf+0R4JY7JpcOQxyRkUmxSAWybf54vDH89mPfuR8fSwNTJEfKDhylbYuaOa5Dviz1QOTKBDLBsjlaMb0Wjo2vz8+ZpQinmdTO6zPHxYKhM3QLqYyhHTp+MVio18fuA6osS+AUrPSXLd+6LOXu7AZ1Lnq9OHWO+mP2O1IX/O5DiWVgjoyKvZaaKr3pdNCODU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 258883de-af4b-4199-0371-08dde6d324b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:07:48.6561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yXB+zd5Z3O1EwxTwLMmcFYwZpjYTAMJ5GsNCANJJq/gk3mtwZCyyOG7ngxL5SfXyMZYGyaUbwWDXfEy54Sz10OLkDe2iK/SQ4u1QSmc36bM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508290066
X-Proofpoint-GUID: Qtd_DNLNdjQS-2vVJa6AxcKVu8cFt8He
X-Proofpoint-ORIG-GUID: Qtd_DNLNdjQS-2vVJa6AxcKVu8cFt8He
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68b15fda b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=QE5vJokERNvXUz0tDGsA:9 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfXzxPFH+FWp9d3
 zH8B8nWwC2GzP+wqES2YCxH0ip4hLKqRPJpxfZPKyxlCe2abQNGaBmbFBnl6eKTp8ZYymPo0S44
 xTGJkgorbq8oyUjkCRsLlxLdhtJYVXVcdPyR70JlnrTGQ5zDzwJsbOQs0RowLM0MF/qRojjG9MW
 V7MWakKhifXxYDdn7ArEFki3h9LZuLATdXq873bHo1tZioSz9vS4wqWl72vtxcaV3NKsFsaf1pv
 t0rf40/5mINiJp+VzhyWDv3dpT5V3l1wf64Q2OAcLCk+li3E8e3u3Y5twINNOxVTBupMPUMu+fu
 7tEYQyMjK99Vx2i3WzZesHMdT7DMSW0vc5/AtiR8Guz4JGuyJgCTxxcJrBrJvTcBO6oqzusSraj
 K1vBCfKlpARfuuj428V9VUoBpQdK7g==

Use smp_cond_load_acquire_timewait() to define
res_atomic_cond_read_acquire() and res_smp_cond_load_acquire_timewait().

The timeout check for both is done via RES_CHECK_TIMEOUT(). Define
res_smp_cond_load_acquire_waiting() to allow it to amortize the
check for spin-wait implementations.

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h |  3 +++
 include/asm-generic/rqspinlock.h    |  4 ++++
 kernel/bpf/rqspinlock.c             | 25 +++++++++----------------
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index a385603436e9..ce8feadeb9a9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,6 +3,9 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
+
+#define res_smp_cond_load_acquire_waiting() arch_timer_evtstrm_available()
+
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
diff --git a/include/asm-generic/rqspinlock.h b/include/asm-generic/rqspinlock.h
index 6d4244d643df..4b49c0ddf89a 100644
--- a/include/asm-generic/rqspinlock.h
+++ b/include/asm-generic/rqspinlock.h
@@ -247,4 +247,8 @@ static __always_inline void res_spin_unlock(rqspinlock_t *lock)
 
 #define raw_res_spin_unlock_irqrestore(lock, flags) ({ raw_res_spin_unlock(lock); local_irq_restore(flags); })
 
+#ifndef res_smp_cond_load_acquire_waiting
+#define res_smp_cond_load_acquire_waiting()	0
+#endif
+
 #endif /* __ASM_GENERIC_RQSPINLOCK_H */
diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index 5ab354d55d82..8de1395422e8 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -82,6 +82,7 @@ struct rqspinlock_timeout {
 	u64 duration;
 	u64 cur;
 	u16 spin;
+	u8  wait;
 };
 
 #define RES_TIMEOUT_VAL	2
@@ -241,26 +242,20 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Only amortize with spins when we don't have a waiting implementation.
  */
-#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
-		if (!(ts).spin++)                                     \
+		if ((ts).wait || !(ts).spin++)		      \
 			(ret) = check_timeout((lock), (mask), &(ts)); \
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
  * Set spin member to 0 to trigger AA/ABBA checks immediately.
  */
-#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; })
+#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; (ts).wait = res_smp_cond_load_acquire_waiting(); })
 
 /*
  * We only need to reset 'timeout_end', 'spin' will just wrap around as necessary.
@@ -313,11 +308,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
+#define res_atomic_cond_read_acquire(v, c, t)		smp_cond_load_acquire_timewait(&(v)->counter, (c), (t))
+#define res_smp_cond_load_acquire_timewait(v, c, t)	smp_cond_load_acquire_timewait(v, (c), (t))
 
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
@@ -418,7 +410,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		res_smp_cond_load_acquire_timewait(&lock->locked, !VAL,
+						   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
 	}
 
 	if (ret) {
@@ -572,7 +565,7 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
+	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
 					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
 
 waitq_timeout:
-- 
2.31.1


