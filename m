Return-Path: <linux-arch+bounces-14364-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1027CC12F4F
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11E7400BED
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:32:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C7EC29DB6E;
	Tue, 28 Oct 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="emafOy1/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="s9AicwbO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588E929B8DC;
	Tue, 28 Oct 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629543; cv=fail; b=N8L4eF3LibJ+G14k/deddnbtXXBXjF0apfufZ6o3S3BagxetZhuAoB4eM6/+hG9WDbP4ufCij1HyAYFvENnEiC61eGOaLqPmVe+sJkkofh6vBoebFSM64sPrfX1pnzVXmhK/RmMHf9F2xYUd23sKF1+KInleSlJA9YDBipq+pI4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629543; c=relaxed/simple;
	bh=ngpmXEiLejrv5ekrMvYDd3mCMVLFH/KYPKW13IkBZiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=diVgNjLacyn3uAF1WJJfQvW+GY/ZvYg8CQdvYiMtl042Mbrzw3Eug2ETUUnn3yevId+3gHzgI1fPNmOmZLJWhlJMi50xzLVYGpJbEeNlLu/uRp+D5mpyxhuKb+ip1FVrpBP2SZXFYQLwZYR83FiGYS7D6b6KIBWoVRfy7/HLfEM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=emafOy1/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=s9AicwbO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NORL017119;
	Tue, 28 Oct 2025 05:32:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=; b=
	emafOy1/v0g4opIOcG1SxOAwcW4bJaL/BOQR3PYObuXXdGiEetR2bvIZY+qmtpAf
	BRiTvviPM/5xB+sk/5NeWCvMp3ISLQWekvqC6ojr5RLlNztmHWDp3FZE0km6jMKv
	qLI+FMm9wTnXmCw0oznxh6ptIsLHKHLHia4jluhI601dUdxrjYgREJi5kHMz+R7A
	7P2OMZYdS2yrMWeSLO7ytZQLihlO5AL8XeMOBUBNltaBNW3hzgE4aAB4TmDhNcvW
	1OlKubOYcF8dhAklB1tOSL4LTg7yExoxRt7twiJWSDINpWvbc3hLgho5Lfkd1FjJ
	btUsnpeKdUXuB1S4vCgI1w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0q3s54kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S35tfO008965;
	Tue, 28 Oct 2025 05:32:01 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0exsh3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:32:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv4s/ebBo7xQh91Iaeu0+ktuQ1SA+rJY0VsYH4ScV2+i5ro01bT/uzwOzag+rifEimGhGoU2VCkqkZmwS7U27LjbB6bKwT0kTzU6ftfaugJeiQFr5NNNMSUzaRRuG1gdAMWQOoJP8ZEchqJbGejJNmqFSRoekstVjzXIJw9FdH91x7T7reiXydW0ryuiaBAEBXPVbztFGPLCOEddfHzbFIDnV5IfHbro23B0eGAIldStnH6Rltzixb3mVQVCiiKUHeyhfiNLvI+2Kckaono/RWd0DXjhcbcbMLUYJN6GwgBOg2Y522EAnbVDvPiKFhE3si1LDxjrbqihVMuT4TYtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=;
 b=P4goan+7bb/3cD4juMCU2pVAQb8lHhG7LKQtasuAUAHa5d8+OGCZDEmTQnQtR1advqdDxfbhleN+Z8BrangjOptyyozzeyYfX28PLwRYWwFozFHuwZv405fbvMhaToVEWtUt0aeiy0ePdUrDtUv9VgWzLdWGBLvLoCtwjt6XI4XGRTxtPicnl8sl4aKCTh2gmgWQ8PDu5m5bHso8w/tnpzyB8h4L3RQVFixcnDNDCDE8RPj7dtfkQun3mDnNmRZiAy4ZqU2QgBTeZrg+NA1k9HsgnuPqj2+gZ+Cm8QLufZJM2arHdc2yFvfrOculAxQT4LL5J9hAa7F7L/mCqzVZpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=;
 b=s9AicwbOTDnM+rl+B1XjHtuhGobKjrArmfMStmGJHNZebVrl+F3s42lqt7HGVnthP/nfyDvu9jmkgYCdsNf+hxv3FsrjNt4LsPlg2DTEs8qUWdaIFOXzQOnI5McDlzcmrHoSbeql2MYgPu0JcFAiIAPkk0h/7KJGwJL0LL96bmY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:58 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 6/7] rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Mon, 27 Oct 2025 22:31:35 -0700
Message-Id: <20251028053136.692462-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0027.namprd03.prod.outlook.com
 (2603:10b6:303:8f::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 78b91976-b744-471a-8ef6-08de15e35008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?swaBFRBym/5CRe1f51RekzbKdJoaqK/m+I//iQXqE27k5SC2AwJrk7IAlytj?=
 =?us-ascii?Q?qSNqJ6TYDFiUQY40+8V/XHAuBvg8TN4b74lVuXkeV0JF4Vqvn66sraSB3pR7?=
 =?us-ascii?Q?LYvcJh5sfB6xRNiQ1T66XoFIwEWbsoNJSeboWTc+Fk2xGMvDmy8NaxW+e32r?=
 =?us-ascii?Q?0Ow0oVOQ90XxfEgBf2JTB0ObCOF4TN5t4VoZpmh93tm9d+sOK3oZURNZ/p+u?=
 =?us-ascii?Q?KoK9k1IaiRpTtLTkrqyPovblY1TcRkF5SGcqVTTg/CSchgCEcb0gqf853scI?=
 =?us-ascii?Q?osDTvxsp28LZF2ueRv7RLe+/F0VcwFqqa+Efjaglh2fyz1w3b58Ai9psfpLe?=
 =?us-ascii?Q?opDQLU/+78a9Su4FC660hcvWwTJ92KwTLidxbbLLCPJqUZxqOzzwyfdUnq25?=
 =?us-ascii?Q?h2W8aR/q+IZYXX7lIGHD8RYv6z1LglLYabhZdYMCxlxr05FHWuwWBgp0OZ9R?=
 =?us-ascii?Q?+ubOEeRZ/Ky5ELNyVLS85vQC3RTKQhmTncFAnSKgDAJ/1KLo881baQMjxfV1?=
 =?us-ascii?Q?kkWFPEcQAtpGdCHCXwaODi6vdZmyCbzBomCPs7/heCaFuRdb/MqK5oxkJO0I?=
 =?us-ascii?Q?uaQ02APjIPQFp/Muy6Sg1TGb3SL/XzBV6k7OU96uuU5rq4gvFxuriUNKhN1s?=
 =?us-ascii?Q?HjRcT/TF9kwBLJQGWJMbyjNzdkoJ3/DbI4xKSnDcEhUboEYRMEGhO8nTeP0p?=
 =?us-ascii?Q?uvfyrJJ4BcAxF1JuHLAuFMt6vOdzxJl2pR5lFNsqNu3Bbn/kEqwuz7glcJXS?=
 =?us-ascii?Q?cxzcQwSLBWokPQv/A6O6UZ80iHPTgVczE3yvRrxEqmNcrh7ZPqIok9Pr+jC3?=
 =?us-ascii?Q?J+b3SmZXCdVHW38QjX8Ft1wIp3nKwZ81shlmntPdT9nxJLXnEkZ8AQXwmrYs?=
 =?us-ascii?Q?LyP/Mh8qJ2Otm2W6bo1VVUiu91m5SdAharmVcOE1qs90dtlN3BE08Wmoq+ra?=
 =?us-ascii?Q?uY+SWoMFBUoNciKKlZ7OU6vKSmpObZAGX1nNDLEYpNDT9VAjxPinJ8cllpbu?=
 =?us-ascii?Q?0O7hO8irWVW7Q1ppscZMCDPHnV+Saw0YDP/IuzOYVVsv9tJDNKVLwPqYGOVj?=
 =?us-ascii?Q?qHpqiGhTNAw3F19s4OS4vUn+VgpxZ1SPRv2Uh2WJvUNAjjbIos93RHAl5hof?=
 =?us-ascii?Q?n+Vf6081DD+X1h5O9LEtACDC0KAiJLSXxOrfoCRqpgVPHLkXZiX2QsKorQiN?=
 =?us-ascii?Q?sY+J8PpZbaXq9RG8mv8N+sq8IccmRZV1rSz/1TWBj3xEdiuqiZxVDlnaZiC9?=
 =?us-ascii?Q?AtS5mJw3GRalz0KNl9zxyOW9FkUjBdfWZp7+YKh7pomdW7D2I1AodOV101fL?=
 =?us-ascii?Q?/Ng3t+WMFvLL2SNsFkCGRyaCoXJVFb6M77IaxbIBD+1bx6A58edqjwn2Askg?=
 =?us-ascii?Q?t50x/2ZgrrR+DNyNTxiCZTw2qL/hsTzZRTXrWJ6ghiAvPigUzQI53zbQxld1?=
 =?us-ascii?Q?0lbNmUf7D81nmf2oADqJo5k2cQsiaJHn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vX+FNR7170h+KK6Y8xtIi2EDU8UA2FMFnvE9kqoEfxbHhDc9AVO9JNU15Mnz?=
 =?us-ascii?Q?iQA6nWDkiw/l6zQ0GgzebX/Ek0pyuxDSjsuuWELIwopglpMJtqGksw9ANvpV?=
 =?us-ascii?Q?B6d45rj54kqcx6yksaEvHWy5qahsZomUuDLQWMDeYtSosQkO202x5+xlJYdD?=
 =?us-ascii?Q?OAWv026BZ/y2E0AvWNOBPVk1tbeR3xtPb6t5AfMalmdM8u1Ercw7RydmBA4E?=
 =?us-ascii?Q?DRXkcS+sAY5HvJJZnE49BYowD8TDaYheLaK1f5Zl5DAAX5XqaWkr05OumwAU?=
 =?us-ascii?Q?qBH6xLyPnI6USqIOW2lVEGACBTLonXitazdLaSUnrSkUONtjCtuRFyoo2aml?=
 =?us-ascii?Q?FgbXSdIe72dcrV1V7cPkUi0ratLdzMyqD61z1JvXGWRePS3z6fzuXHzwUb19?=
 =?us-ascii?Q?bkRKQm/cKbl1e8pkpc7uOAjyhELMcPrJEpou0nC0fGY4SvoEoEXG4fnLI2IR?=
 =?us-ascii?Q?OdgEG9YFUSzSGgBAIW3Bgu9KHBkijLTVICn9g9qccPEgfQk7mg+UXbkgoIWt?=
 =?us-ascii?Q?I8cGxsTYuh6UeVfc4KRN9LTsDA+x7nfu9Rwep/+FcHCPgE0SzJf9W2aOpgNV?=
 =?us-ascii?Q?WShq36PeA39WBf0cM3q5k7OKhl7fDjg+a98b9q50MMj6ePZbbf5oUkNt1iWm?=
 =?us-ascii?Q?vqp1kfFOLdjOIHWIarEM1CtYivq9nV/2xjy2fF4UowrRLLtnR4wi1wqt433o?=
 =?us-ascii?Q?P0M2vn4ZEnMdHMQn3zrFZJhVeFk0nm9l0w6ujpsrHEcm9Mkx8cAvuc8qUDuF?=
 =?us-ascii?Q?FTKrFmh75j/4lZ6YYVbfU4uAYd325P92fHjgKtE1UGr1V1v2t7OQpVXxilxd?=
 =?us-ascii?Q?uiF9zNVGL3+YJuGghecXiMYZiOAS24ISj7VGlSBDML6vLIsRXzm+SIEFis9i?=
 =?us-ascii?Q?BwQMj8vAZwhKeZPhrrF/3NKg5fM2IZ5UYAu+tNr2fxIpVXS9N/o696+m/mu2?=
 =?us-ascii?Q?NpOIEMOMKDHTsihT3A6rTH4UyoFYuhpQRy85R7iYY93aUvVZfbQ9XkJ64v9F?=
 =?us-ascii?Q?ZnstdkYagDLxQrFd76TmTjFJWHWerIjeszpu6TZG1Bxd2magKJ8EcRZ2tpIy?=
 =?us-ascii?Q?jVCzx5wBSGzFd9M2Tx3P9Bi93TqWnuZ0WmHfu7gD5BjgtW33kijexK4vwh59?=
 =?us-ascii?Q?DENbUdxWNs3FYtqRs0+GSuj+DfVded7xKZJpmiHWKDM2iVQUSF39/cRIHhjs?=
 =?us-ascii?Q?iXZAngGOTbTws4GFLiSacO2zz2UKEZns0Zx7OHvA1MFMp5pda3/yPwWLaWCD?=
 =?us-ascii?Q?N57mPsFEj3aBXMK6+wiFInJ6ZwdBdDRxpXj4FepoRqvOOdoJgVAGDX8LUQtl?=
 =?us-ascii?Q?GQgzQ7Li9rq/dlD0WV8KEo0o/3iodO3dmYTGMUCUVT35Avkrr91XjkNdqXnQ?=
 =?us-ascii?Q?T13qo6nhZ+qKtHlSeGw+N9gN1bV0eXiBYxWlvqZwqYqV/uwIAa7wH/ZyyCTS?=
 =?us-ascii?Q?DityFAqi52EDXvx4cfrh4owBSm4Ith/cM7RoxgPILe5Bf5xv8LbVb4jkshVu?=
 =?us-ascii?Q?Wb0CUhVC/CqSEG64ZqiKguc2cxjLburV2wQ4sJOj77smI4BS4KzYZKF0lFAL?=
 =?us-ascii?Q?CuvsmoVMmJgTZL+LoeVRnXy1ViUg4AZboGxnsXd9i2dC0khp95UEfSWrxsQk?=
 =?us-ascii?Q?ow=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D3yJhflO1ZYzQzm7vbi6e6Dy4A82M1QOcuu8nnP3DNX/metejMhfJwUdNmNBfbvfr/BsH+v3o5ABnaC/xE8ivAi9zvLWo30BfbG8Ko5zdF7dmhTG3xM79Km01NjSUWzkQpmRbX91ULXljj1ohi9sU8sPrHyss4yBep4e+oB3WYetcEDd7gNRTrQRCgUOvcgb1yoPxu13SZwAUieUjSUX85b/Wp+ie53JKCorNlGudlGrEIiTK7UU4kF0XskN7cZrfBUaS5ZeaVqMC+u0lKCFF5mFVOwzy2kjwdyAk50nA59acwl8iL8xiyonnaS0r4XIeE3EuQLbwLHKlkQUrQqwBilPXSj5YYCDdAup5CdIXt1QQQn+CuzwEcmyjGqCA17aWIojUMcF8hf+qgE48kcmZMrFYZLqxwISkJmiDAQl0McpNbp6P6y+sYsaDq1rCWRyousIJkU6kE+pEWy3OljClVWjxtwvk4F21gxpZoCn4BKz0pyAUTUaezRXQLue12jbhY2or6vhTY1rM98js0D9FW2u+Cklz8cZS9xMKObv0b/0vLMPtlR5c9t/KlNdX7EhpIeLX2O1OVKLX/F7yRyg7NR0DAWW5DpvuVBreLfVUHw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78b91976-b744-471a-8ef6-08de15e35008
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:58.0530
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4hmSYWlIf8NpJLSolwhNPEFrwNS52s7MCywbarmusb7f0Y4bBMPK325Xv8f1/xciSwXJ7UxOTTBY2IrKz89htPV543vEdaTLv6614X5g11U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510280046
X-Proofpoint-ORIG-GUID: MyoDjknLfqYyRNt02li_p4ijSBSZ-dHL
X-Proofpoint-GUID: MyoDjknLfqYyRNt02li_p4ijSBSZ-dHL
X-Authority-Analysis: v=2.4 cv=Q57fIo2a c=1 sm=1 tr=0 ts=69005552 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Hj5KyUW9Q7wOCK9_zGoA:9 cc=ntf awl=host:12123
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAzMSBTYWx0ZWRfX+tSm9UIZex85
 JtOVdQIGqY4Og8OCePZezU1ZP4Aklhp2xmhSebxjij84Zdau4mzvPoqbCR7ZF6eY1Z2mEiJpxHj
 WL+JA120WPacOmYVBRqsMARUe9tJUCAlNH35fYpK9tqepJdEMyH4nWi/Pewb9q92ih5AjIdRzY7
 JzwqEEhyPWEHVnth425CF6sSDGbAwdQrWCtd4T5CIVQ6wb5Ewwg/IIHklEAGSsgVzlOm4+VNNR4
 ltOl81xT5b2xG1MdwNspuk/zJlvVMwMzRCqHP+jOsOfhMJTD5JOjtcoPJstrkHJfvd8gGYBhIPx
 vaBlG40S18LByizDmQ/XyWMYvf7YpGgQcdl42OCN2G0LHQb6OInx8DLDADJe/7+3JkSP+O36e8z
 GMg2/92AeozADfvu3HCXxSPcQC8R+FhOaGUFpy3Yka5Pi+UYGjQ=

Switch out the conditional load interfaces used by rqspinlock
to atomic_cond_read_acquire_timeout(), and
smp_cond_read_acquire_timeout().

Both these handle the timeout and amortize as needed, so use
check_timeout() directly.

Also, when using spin-wait implementations, redefine SMP_TIMEOUT_POLL_COUNT
to be 16k to be similar to the spin-count used in RES_CHECK_TIMEOUT().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/bpf/rqspinlock.c | 31 ++++++++++++++-----------------
 1 file changed, 14 insertions(+), 17 deletions(-)

diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
index a00561b1d3e5..f35f078a158d 100644
--- a/kernel/bpf/rqspinlock.c
+++ b/kernel/bpf/rqspinlock.c
@@ -241,20 +241,14 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
 }
 
 /*
- * Do not amortize with spins when res_smp_cond_load_acquire is defined,
- * as the macro does internal amortization for us.
+ * Amortize timeout check for busy-wait loops.
  */
-#ifndef res_smp_cond_load_acquire
 #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
 	({                                                            \
 		if (!(ts).spin++)                                     \
 			(ret) = check_timeout((lock), (mask), &(ts)); \
 		(ret);                                                \
 	})
-#else
-#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
-	({ (ret) = check_timeout((lock), (mask), &(ts)); })
-#endif
 
 /*
  * Initialize the 'spin' member.
@@ -268,6 +262,16 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
  */
 #define RES_RESET_TIMEOUT(ts, _duration) ({ (ts).timeout_end = 0; (ts).duration = _duration; })
 
+/*
+ * Limit how often check_timeout() is invoked while spin-waiting in
+ * smp_cond_load_acquire_timeout() or atomic_cond_read_acquire_timeout().
+ * (ARM64, typically uses a waited implementation so we exclude that.)
+ */
+#ifndef CONFIG_ARM64
+#undef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT	(16*1024)
+#endif
+
 /*
  * Provide a test-and-set fallback for cases when queued spin lock support is
  * absent from the architecture.
@@ -313,12 +316,6 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
  */
 static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
 
-#ifndef res_smp_cond_load_acquire
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
-#endif
-
-#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
-
 /**
  * resilient_queued_spin_lock_slowpath - acquire the queued spinlock
  * @lock: Pointer to queued spinlock structure
@@ -418,7 +415,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 */
 	if (val & _Q_LOCKED_MASK) {
 		RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT);
-		res_smp_cond_load_acquire(&lock->locked, !VAL || RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_MASK));
+		smp_cond_load_acquire_timeout(&lock->locked, !VAL,
+					      (ret = check_timeout(lock, _Q_LOCKED_MASK, &ts)));
 	}
 
 	if (ret) {
@@ -572,9 +570,8 @@ int __lockfunc resilient_queued_spin_lock_slowpath(rqspinlock_t *lock, u32 val)
 	 * us.
 	 */
 	RES_RESET_TIMEOUT(ts, RES_DEF_TIMEOUT * 2);
-	val = res_atomic_cond_read_acquire(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK) ||
-					   RES_CHECK_TIMEOUT(ts, ret, _Q_LOCKED_PENDING_MASK));
-
+	val = atomic_cond_read_acquire_timeout(&lock->val, !(VAL & _Q_LOCKED_PENDING_MASK),
+					       (ret = check_timeout(lock, _Q_LOCKED_PENDING_MASK, &ts)));
 waitq_timeout:
 	if (ret) {
 		/*
-- 
2.43.5


