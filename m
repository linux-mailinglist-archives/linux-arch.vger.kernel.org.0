Return-Path: <linux-arch+bounces-8901-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D299C0E8A
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:12:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79781F2561F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:12:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFFD321A4DA;
	Thu,  7 Nov 2024 19:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Se3WNmQi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RCNqlWt3"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600221A4A6;
	Thu,  7 Nov 2024 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006571; cv=fail; b=fCfAndn+bnkQe/KOvNEgpxyAiO6Cfopct0tQ90N2+WlqglFZfskQoS6dNtqeTh0VUzkMmxQKt4POsODWn+4T6Y0a7JC+ONC6gzbb+txf20I/ty9w2Q4LtYPbmpcDuXBw5nFHs3DR/KyhDz7P945VZfwjWwyPDlglrFYxuLlueJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006571; c=relaxed/simple;
	bh=0gtg5I8UrdEFmGzwwzLhTkyuFNRE9cj+/5Nj0z2oeWc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HAefGlgYeDW48QtSldqVzh6m9rrac+gBmHgUJR4RwsnQIqe14Ia6nUVz09kNMq2GkS2+2SMu4Ioilzf8MhGc117xzVJ0haiVerP0nLpmGURbiBbt9ePhAs50SdLhMgz9plPgwYeEsHgC7UHvsCFoyZw6gLrs0d7R8aZ7omz3CE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Se3WNmQi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RCNqlWt3; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBdqJ002594;
	Thu, 7 Nov 2024 19:08:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=X/9z53ljMQ/NRHaqaOXAe6l0c0K+wzupeQNkRnwToPA=; b=
	Se3WNmQiSwdq00UpLaauJk6b7UpHJa0rxQaHC/6Zsv7xmVenIOYRqNISMyQ/lwkz
	Lq4t6Fm5xA84PMSzNIeR62lyqyKrT++o089E3H/MyalJHaH2W+nSXmH22p07agvC
	hJG9Pjt435zNUH2vhFFMPk02H+iMqo48CGM8dLZ/jlTHAUFQEgUL0MEWIcXM1lCL
	flixrt2s0RNccOuauhm4MEyCJM+euRRIPgHWSn51FOqx+YJzrUNX56AA42+SdQvn
	Bk5fsSwP1IdbQ0na1WOQNbTziYWrtJ+X/gtSbKdFWdEqVnxUqQT0wiNHCB2eyoLN
	Uh8nTKCnTHuJqET5aiJP7w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmtbbcc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HuoFP031413;
	Thu, 7 Nov 2024 19:08:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42naha6cn5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zGfDRcmkq/U9/f+HaHkJqrXCUu4B5X/sRVLTJVzStN6WmDxGbGQcDDI673GEVE+MB3mJx2SMyQBgkA8uBSfDvauEMvexKIffBfS+75n02znAesLZ84iuhRMSr3nJmGbElj+YT2OVH6DE9qh1xmpQqdpCnaks5nlurgN3KMqSKfSFTpOoJ1ofOAEwepHSBLqrjxDLhG4J+hyKj4TcLd/ltgDIMhUPmR7CPXbXGUgiAG/lVLhRZTVy6YXblbk/oZTNZ/bYDh9jYAvZs/CyjnCjyeyAy38pQwperY/s6tmSig6AcAWhZqO1jnijNUWKzs+GOmXX/Pnevkia9xp1VbMubg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X/9z53ljMQ/NRHaqaOXAe6l0c0K+wzupeQNkRnwToPA=;
 b=OhvZ91JFuZAiJHf75tyYgZ7BbZg8HMQcjNulSaG9iR7HOMsFky9EJU2Rxtk6sFsKgiLzMwgxsLkk7+7N4487fZjs+M1a8Bs4liz08ubJm2WBANL+Q2h1XZNu7iTJWNmP549kMG4VIIKKsLU82DPUACizlSSMI8eopGCaP+QZyEVBc+3WPjAUJn9CF5zavM/fu2YyruVeGWj27uaqQ3cyP7+H0x7ldphZwsNYi5tFmfL8148CIy6xSU/NsEsLx5TAFL+YbqwOkYBMtHDiQPWa3ZiwXXwZwaIVXixPS3dTiyRpof0a66PhpdepIetqEgRaCFC+eidpdqzrMlXvnYG62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X/9z53ljMQ/NRHaqaOXAe6l0c0K+wzupeQNkRnwToPA=;
 b=RCNqlWt3ruoMgxjj1nPT2YtKy6Rb6xpa8rpCTHG98BCzQ2/rKOcKHAgSNoXmwVt/HGO6Q8euTaYTqsSGnMbKEHPlHXMSTP22vZB0AZN623zJR4j97vb0IJARKRghiO3TGkIsx+0Qk8dvKQwuOFsVdftuZa9DemSy+1YxrtIowRk=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7736.namprd10.prod.outlook.com (2603:10b6:a03:574::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Thu, 7 Nov
 2024 19:08:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:51 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-pm@vger.kernel.org, kvm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Cc: catalin.marinas@arm.com, will@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        vkuznets@redhat.com, rafael@kernel.org, daniel.lezcano@linaro.org,
        peterz@infradead.org, arnd@arndb.de, lenb@kernel.org,
        mark.rutland@arm.com, harisokn@amazon.com, mtosatti@redhat.com,
        sudeep.holla@arm.com, cl@gentwo.org, maz@kernel.org,
        misono.tomohiro@fujitsu.com, maobibo@loongson.cn,
        zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v9 11/15] cpuidle-haltpoll: condition on ARCH_CPUIDLE_HALTPOLL
Date: Thu,  7 Nov 2024 11:08:14 -0800
Message-Id: <20241107190818.522639-12-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: ea711910-06d4-4d83-1896-08dcff5f9da9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?U5oVryzgRGpXD7NQaxH+pmLNxrpe/HjcY7SYT/t75Is1Vab4PWZWVc8YOhXQ?=
 =?us-ascii?Q?NJjB7UO4zjA/HvOzHW5wJ6m8DJgxSuS+u00/9YZdVwjUc2YvxNLgoF0D5KZ3?=
 =?us-ascii?Q?AI7pa8V1tiZnRm9ndurmlvc4Xlp1RO/dqwayxXXEjTvrgx3ZsD5KLNM+IsPz?=
 =?us-ascii?Q?u9gJFpkqXpNMwAmlAMxXJZu/Koc22AsXDheUI1TZ7DCoQQMNGjovn3LL/HCL?=
 =?us-ascii?Q?Ky6SRKDJj1jtldeqJMl7Xal4sZhyJNqdyOUs3Y2LhXmiO1rmPTD7i52jmGsz?=
 =?us-ascii?Q?WJtJSLYutykfG+Mt+Jn0WI8IfQLg2lr6CUfVRscZm8nWPBSNoMDzAshhEf3U?=
 =?us-ascii?Q?usMLaJ5Gy4piy8te7X96Tf+RlXC/XYBircIqgqygqC/bAYDHJlo2w8ptiXbB?=
 =?us-ascii?Q?OD5BjdY9oNJFcsVsn8KigLg3olQLK/ZwgNXta5IQrzrgAXQ7uiKN5NaIf7eg?=
 =?us-ascii?Q?7aka1LvJmfaeOMIwvixUVwdPG4lI46HV0fa6I9PcnQhZPdp7I2JAgQJnfWQy?=
 =?us-ascii?Q?L4WlcWiDhk5XuZ6Fz2S17rhQ+XsKrL5MN02OhCgGEBEFStID9v9NCjseg46q?=
 =?us-ascii?Q?GJ7KpQWQdbJxC1LrakzMJEElMdwuV7Ic6m4m9cgT3uVSXLchnNlrHpN9etcq?=
 =?us-ascii?Q?CoEbhqlOmA/RVb0vEtDwtebi5kKVlM8lGsc5lR9JbwiliYEtwO9U/SoU5DES?=
 =?us-ascii?Q?XWhybur+STbGZD5m/wcyR93kKrxDTZXS2lxecTqeS3pewvpQ3rrQ/0k5ChKW?=
 =?us-ascii?Q?wiUkSGldWyEwN7ZN7/cjiFjHbHkr9JcaOwjm9Jiif5rqg8s73GfiV7HLN1rX?=
 =?us-ascii?Q?uuzqY4lMKX4vessAe/BfLmeRLy0jtvTBNa86jQbSpMphVKEipDuB46pelXZZ?=
 =?us-ascii?Q?KzrG7BQ2OFyel/Yi/mqP1ennsw+mbTkSJrXgnpNUk6kYuhf5+ZabTuOcb60j?=
 =?us-ascii?Q?UMxuhvbJIQNF21FGfOmbwFGkSF03sNHzRqu8zVs7zc0SzT3oQmytxMANeNvL?=
 =?us-ascii?Q?Plr0BhRfVm/eCDrgi87k9+OtjvbOlmI3GvwemvNrrmWl4TGkz+U8eJ5hWeIS?=
 =?us-ascii?Q?g1w/Fq+iBu2hw3UPWhEpwVBZPuopraGGaEoxdhEYQehGO0y+BnYhTJxfBeIZ?=
 =?us-ascii?Q?GdytWXLzr3nVSUp66D2nASjxVfkZ8wqrrp/WH6AqM/IUyC2GmNOpYJP+3WN4?=
 =?us-ascii?Q?nFFll8rjPskLk1XHfLITJ5YeS+9qlJHMbXdmoQlHyHwoi8qBwnyyQDEdI/KK?=
 =?us-ascii?Q?aLfu4MAWCZFwdy4UPcVGAtUUvm54QnFm5HJLhwm97FDKmzehf1UJb/9TiW4b?=
 =?us-ascii?Q?Atvkcvf7ul0msTET4CtFlz0T?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nqJPCNMIWhzXuLalSeotGWwJJIqMpZTppIUXmsN8d9araHuNs0c2OINslx+q?=
 =?us-ascii?Q?qqALwncaXb4U2pj86KxMWxixaer0esmglkuFYX4at+IWliU9Ho6xHq9FH2tl?=
 =?us-ascii?Q?9DQaywpE6RQe7+fbnMemoJZj5yWNr/Gy/u+7lebfM0T8SuIGnkrEVlVjp9XE?=
 =?us-ascii?Q?I9WWABGyRFCCHKk4cndP3EPo5qKFlAH76gJ15lcOvz8d5Dg5hA2SzN2uhxp1?=
 =?us-ascii?Q?Cqm7D/9MWJ2dJ0gd+j6k2pOShxo6Z4cphyGpQIUnveuhodjgBEn+HczNLx1W?=
 =?us-ascii?Q?gNdDVWTc5ZXHL7RLOgmpi/SQ1EzPikYHNb/7oe75/2mUDV8PS0aVmZ8s3RCr?=
 =?us-ascii?Q?SMHyTY0PHIH8CfkRUvxyFdKR2nJN09FYknjE5g91GpczFLifXiin8uN5DGUX?=
 =?us-ascii?Q?smO8P0dqt62P/iZm98jMZw9378IEP2JyGWCGBUyfp2JjvOys4MXNirvLNzhC?=
 =?us-ascii?Q?MrOcD+cnowXVjrhE06Hs/XEcT8KhV81LPYcSelUieFKTPvW0Y61GBfF4w7A/?=
 =?us-ascii?Q?6wxq9BldExnCoL/Tia8IemvKZuh0hIV6b6s7lsyxIs0/kF/wxeAKs+xqxV29?=
 =?us-ascii?Q?ujJPuIZRbOtadsdE8BAUC3gG8h7HSD+fGfuvg1UlDDmjD7iG0AJDqaBNQyqV?=
 =?us-ascii?Q?Y+atW2T3LRf0f+EVo2fIQtXezcsTTW1KYzxs+M7lKORTXqUmeRPIO3az5hrf?=
 =?us-ascii?Q?hDHzTJa4AP9ZaTm1M93YSFDDkIGzjpcvWtp5ZC30TvautzwslQ7fRQT7KOMi?=
 =?us-ascii?Q?FIdSXE+Cx7K4TRU/48O66pT5FWRvRcW1PAy0Wgc2zzKC7wHT2O13cxHcDmVK?=
 =?us-ascii?Q?e8xabFDL+kArwttrh93XlfvKBHygJNIg3teg/Oltwc1WWNlnQLiven5/GLSj?=
 =?us-ascii?Q?Rqm/L2pKkAY7Sc/sKLEuyzO/DUnrcocTbJxqoq5Nqyc3+P3wmbq9ajOb7gDb?=
 =?us-ascii?Q?grGQa9ViI0kQjBiFjpG74fHQr93LT8ukfoYZ4XIdD2RpbDWJewXu8VEO7QWe?=
 =?us-ascii?Q?f5VVix9LL0eF/HFSI7CwlJx6sDnXS2Qq8SosV5YG/t/z1X1dCITKJ379ikuv?=
 =?us-ascii?Q?A1s7INm2iE1gvEtB/X5dgHXRZYXztaCCDSHgMA5sZxQccCTFpP02L9Zdu+6J?=
 =?us-ascii?Q?VxJhebu1wGt0lDSVyFmz4cdsH1vtJz8q4exbzn/gDoRiINHhZ3YK4n9xWAB3?=
 =?us-ascii?Q?wYnnOxhEgUd94tHhLv1cjNrc3jqqwTncEjvHrw6PIVNrHQdwt9Osx+Oh3HfZ?=
 =?us-ascii?Q?kAjeXI5AwuOr33FNEUpanlhjJBjAhERE8wJ6qGBLBG5uGKvahMExwIDVjzQ2?=
 =?us-ascii?Q?P3JzZCW0d+t/tgMa5j7MHIAtV03XhqRUVOdkwZIXhVghik2cI9PjmUGOD+RR?=
 =?us-ascii?Q?2kayhv2hwmv+NnPBXaDGQ4wP2EYVeLFHFrrYZy1/0DPLu/qgOPdlpvS7KiiX?=
 =?us-ascii?Q?0f7SgzRAY/xLKq9EgAdrvPGcjj3cjjvmsVjsqBAOVGFaPMW9tbzD4w5psB8i?=
 =?us-ascii?Q?yT2Bz03xKrxXB86rJHoUxAxUB+CaS+RDBzwd4np24PXeqg/knHC/Kmn8KSYV?=
 =?us-ascii?Q?711/bp2cShbS2Xs48OCc8CZuOh18ccQ4XkPk/j06/a7MUQiqQj4rV1Ia8Iy1?=
 =?us-ascii?Q?tw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	EbCIZDdHc+XzpkGVTjoWRvvuQ1mNY5H8Y+059JSz52vTmfPmpmdRYSbLY1jO7hYJ6rbyfyYaOFWKgpp2tpPQjVU7OLXqKlTX3d9KtuTGfum6XxUFiO70WHb3Id6oVod5DKL6WWdzwaqCxs1/+5244tZxuy1wptu4qAO/+sQS8Etbg5HP5pKRnrzbDY9fAjvO9lsGCr6oKA/K1hLLj8q7kdoxkxjKjkE+1a3Zg6RlO/kOiWd2G6fXlltlS5ipDqMZldg7l2LCqHZm65CeK0g7h0iF+f4Ht/vBVGulMEPZ5vouqRoc2kcg5fSI3K9GL/KHCoss3HhyeXvzUyKXRrcWGgADfcqp1TPWN562AyLWR+qEJmKazK1k/KplTq6+/wC2BXYBTbq20yEtWbPJuDGXF9Q2W27dXHwReT3+4RHTpkM0dPmm4RUQw3NW+Yf7FK7nA69AQM9FFNBU/Kem+4n/YiaT8ogt5Pp8AUjq/GmdWHUzGZ4ghjw8NDC0/F0ImXmcnwccCNDOCsuusHr+FeuJshKSNlNFeq+Q2dyefhRtrkNkACQ1Zdhpq6dzPCv6e/qmPM8UISnrlHl1gkMxucf9iO0+TgLkWXnB2ZgyFkjZaYc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea711910-06d4-4d83-1896-08dcff5f9da9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:51.3401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y2jzo8vWNJ1CfWyp+bHGp3Z+zKtt97RpuHoJf3wY3O48mSUBteLIYAoVmjih3hOxDbcipaA/40EoQO0yH/VQifBgiYEMwtdGnvDdJ6Qo9Sw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7736
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-GUID: VnjQweMphPRtdwNHdupaFgJrYu645lEl
X-Proofpoint-ORIG-GUID: VnjQweMphPRtdwNHdupaFgJrYu645lEl

The cpuidle-haltpoll driver and its namesake governor are selected
under KVM_GUEST on X86. KVM_GUEST in-turn selects ARCH_CPUIDLE_HALTPOLL
and defines the requisite arch_haltpoll_{enable,disable}() functions.

So remove the explicit dependence of HALTPOLL_CPUIDLE on KVM_GUEST,
and instead use ARCH_CPUIDLE_HALTPOLL as proxy for architectural
support for haltpoll.

Also change "halt poll" to "haltpoll" in one of the summary clauses,
since the second form is used everywhere else.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/Kconfig        | 1 +
 drivers/cpuidle/Kconfig | 5 ++---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index df75df8467d1..fd0ff83a84f0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -844,6 +844,7 @@ config KVM_GUEST
 
 config ARCH_CPUIDLE_HALTPOLL
 	def_bool n
+	depends on KVM_GUEST
 	prompt "Disable host haltpoll when loading haltpoll driver"
 	help
 	  If virtualized under KVM, disable host haltpoll.
diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
index 75f6e176bbc8..c1bebadf22bc 100644
--- a/drivers/cpuidle/Kconfig
+++ b/drivers/cpuidle/Kconfig
@@ -35,7 +35,6 @@ config CPU_IDLE_GOV_TEO
 
 config CPU_IDLE_GOV_HALTPOLL
 	bool "Haltpoll governor (for virtualized systems)"
-	depends on KVM_GUEST
 	help
 	  This governor implements haltpoll idle state selection, to be
 	  used in conjunction with the haltpoll cpuidle driver, allowing
@@ -72,8 +71,8 @@ source "drivers/cpuidle/Kconfig.riscv"
 endmenu
 
 config HALTPOLL_CPUIDLE
-	tristate "Halt poll cpuidle driver"
-	depends on X86 && KVM_GUEST && ARCH_HAS_OPTIMIZED_POLL
+	tristate "Haltpoll cpuidle driver"
+	depends on ARCH_CPUIDLE_HALTPOLL && ARCH_HAS_OPTIMIZED_POLL
 	select CPU_IDLE_GOV_HALTPOLL
 	default y
 	help
-- 
2.43.5


