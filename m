Return-Path: <linux-arch+bounces-8896-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B3E9C0E74
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CD61F21DE8
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DBD21833C;
	Thu,  7 Nov 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k4X12CpD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PZBpaYqj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FB1217F4D;
	Thu,  7 Nov 2024 19:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006563; cv=fail; b=d2A6U/55Rzo7SCD3mzeS359SOinwf7PAvqifif9oosBRz0VsbCgwge4apqgvH1yLQpwmf1Yo+rznD9eDYPDNnj/ZtKygAhob6m/O5D48VMRH7sE/zM9JzoqtOBPTAZeZoBeCS70DmZtiRQDzWDkyAd6ItKstz1S2i23cvqCUqnk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006563; c=relaxed/simple;
	bh=v3GaWP172XiLqd+rXefIhasC9+l2FDu3nt3uIc2bu4I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRzdyuzsuQJzxk3A2IvC7CbM43dK9BUMnbKIx2sGd5kqv31Xm72jt56bbzGs2xF0g464ZWM2wsVz6luzoPM+izD+hVDymsjDdBd+rFrrBUpk6Q/PyzlX1/InMU2zJfFOjFDsuYsFCS1SBFanJFoCQ//isnZEVXEIswd/5gxJS88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k4X12CpD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PZBpaYqj; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBgIf004757;
	Thu, 7 Nov 2024 19:08:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=z6wAIv17lLsyWur2fP5H/w7PeJyNJoRHHA9dyx1YnpM=; b=
	k4X12CpDpTZasbBn9MvgwceXLIz3Nlh6eyUr8gV7rjiVKpMi8jiuTVPr+qZ1y85C
	XoJ9OnFs2baNIcf0NAZdg/jS0RwrdYmBCmuZzudldrimecXbsy6IMyYxz45EwvK5
	UWucS9KNvbJPVWSKl9FpN0IpjcXdtUIj7Cj0ZbPLtFxCexB2OSichUyfWiGjegnY
	yIPZEIF/UDxa8JN1HF4L/a4TF6J/8DLShocq6RV4nBNQnAvpwydqVOgGO+9ti2ay
	ggRGfsa3bir7HGqmxWKia9BVEI1eT9jXXY1A1UVDsEWf8pB3Aul6LHv8uxhump0D
	9E/IDfpEPj1WqJlmzDTzfQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nap03d83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IMK31036797;
	Thu, 7 Nov 2024 19:08:46 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahakgst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AwMJ8smE67iUD+wDipq49H+nrGxzpi6+HTo6Ho4K/FOCY86OMAXknNOB/rxwsWWd66n8NIOxqyr80vCnsrAZ80sEu3ZObswEaVLboBl4zAlau6mUtzPG06mtVZEWUzT1z5djhv1N1NSVtrfPScrIhAh8DT5XXAlvFrBzZOPgPIWFY6xM7SkqwptO3zf36NGsmG6QENuJWiL5fhpqThaww65akBaOhu1b3vkPEKd7RzOAL0pdEECYY94Yhiy/TPuH8FLLyemUgUNBf+Cn47KCB4SPauIW/NRjBu9BdPPF1TMugbZmABwnhtBlhMLm/gmXIuF+4H3xDVNSAt8XiOarSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z6wAIv17lLsyWur2fP5H/w7PeJyNJoRHHA9dyx1YnpM=;
 b=T8Fy4cSgGHYvjhTjOSQa12z19CtIA3OIicfeyoiW1lOIgRpb2YziNT+z3iBnAYJfLSqgFqFUb9SEVYAtSVGUjOtYREN0ts/5i8iryxR2HkZhBIQ8t/ATUD3Ngajzmx16WqDOqwRtNqJuyu6v92T04dZjOyNH0rEYsx0QKm7NXXlXFdeMDrCkwjz+x+6jHvnsx8YIf2DTqIn2KcWVGSg+xYKJdwht9gMD4qt2X7yqLuk+F3hTWbXsAziv6WNl7dIfFEL2WZKkkfJgmU2AkfviYmWlNEPwp67mR+g20ZkyzApjsdYiwljrNYVvy8a90nxl4AYqgSpXeEYMza+p4yxtGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z6wAIv17lLsyWur2fP5H/w7PeJyNJoRHHA9dyx1YnpM=;
 b=PZBpaYqjdI5CjpM3Qi1oxmsN5xEByknIEHdVpU2NxTjMDj8GpOe3oLcN3xGB4ri7+rBudtlHdmtSpqQvsKRF2SHSzxIbSkCVM3AyZyzsftQLNeJD5MlGhGo1PpC4z8N1v2rhvztqZhwQeBuMtQ7wH+RpNZ7wCZYpvZc2e/Cl8x8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:38 +0000
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
Subject: [PATCH v9 06/15] arm64: define TIF_POLLING_NRFLAG
Date: Thu,  7 Nov 2024 11:08:09 -0800
Message-Id: <20241107190818.522639-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0153.namprd03.prod.outlook.com
 (2603:10b6:303:8d::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 274aaae1-98de-4447-113e-08dcff5f9615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8BqH3T+VmMDVBdI1v6k75XDnTSQY6SgOF2NprQJ8iJTKRHDtz/xZXKIGz3eI?=
 =?us-ascii?Q?xw1mYM4xgdkdLifoh56vheO6YQD6vroVHRRDhXZBZKawPySUdyubhETqJMkf?=
 =?us-ascii?Q?J0qaII+6yqRBPyi2DTGdFt7UyfA+4vRcr0+tTO+fbibJYC//Jtuh+8Y7Pdpl?=
 =?us-ascii?Q?cFUEFVVdKjQhlyd4NyT5+srjQRpFQULevTC6R/t3wlrCAEQWrngu6cRNRkCi?=
 =?us-ascii?Q?E3bPBfJO43Irx4Lmkuxj4uY0WtHoT3aqizVguPFo7E3dvLFmEPfyMrZeWv86?=
 =?us-ascii?Q?NE8byovUsi14beZS+jgSD7+iokctc5TPQxpXXYnlK30WbtFPBeg6yX8NCtYU?=
 =?us-ascii?Q?CsW4fcL9Nyus5RaBccZ7gc/p5hdfrSbK+7u7VznoQmj6vFZdGVSOcpu8NlX+?=
 =?us-ascii?Q?q7yE5NayEw41q19rpMJmrtmNr3RH0v9tkjEH4YFYogzw4iO+pxoHQQEoIIeM?=
 =?us-ascii?Q?oDLcdMQWHE+ZC5WxSKtECmjPn8xO8GCJUkOumA52gMYoKCaKgFj+H/Nbb9FK?=
 =?us-ascii?Q?VqlhsVGDBBv4luqlr8Pmowfl0B8jvZfXyu0eoTcesENIdQ0Z8/N2mT1sUZ9Q?=
 =?us-ascii?Q?MY8p4UTMugt43ym1zRsqGCNvNQJly/imNsMwv01Zl01Y8MR0L0YO0w0L8kkE?=
 =?us-ascii?Q?ulb7TYS3kUPzPA+dosV1TRMSKWSBjJef6iauorlr+8xAQOTBvU1qB5LWKMOA?=
 =?us-ascii?Q?qtxZDJ6Xo0nAi0s2zHMkCyAxL8M2nyKqNuaCdVocw4D4vPdCNcLfZ6T0O2AN?=
 =?us-ascii?Q?xxtII4jtvXxMiYF5fPjNWlSp0P16jTVm+VpjnV0L13nQvcsYCUrA26NFgDRN?=
 =?us-ascii?Q?xJiQKbzmxkx/Y6DuFu9s+9M34rmkPz2RzeTSwlfMCSxkqJ77wWpSnNTm9t/y?=
 =?us-ascii?Q?0gDRkOM58ZQFzOyBGIibWn4KbxxbQPeCHhemIZlc0no8p2jG4WNxBXf6UyZs?=
 =?us-ascii?Q?CvAxrSp+Adu+9PcilUOCorP1wZ4yCiqPa+UhxtTq9dPNvGuV/DDRj2knzkCN?=
 =?us-ascii?Q?iqklrGfhGF5Wi3E5VPmOsG9L5GnoDwPCy5gXAfOgekemHqO1vCzHQRLRlsyU?=
 =?us-ascii?Q?xYBYPzQcE24UlGLNEXwBs57Mk9xPMbPdnyHTW3zoXdBv+JB3Mu8baEC+r5nf?=
 =?us-ascii?Q?Oq+xabv4ulL0O43idwU+aOW6EwBjwQqAyiKyAyDLCWj8yjjWz4snQJ4m8Bod?=
 =?us-ascii?Q?j8QXisYuCazgCDsL1ph0NJZlxc00ZTGzKkHriSvjOL/F6rNtUI2PlUxnXyxv?=
 =?us-ascii?Q?qh7F+aPXJrYqehcrsU90jLeXTlSu36LyyCuNn1cjsN7qdqmDAqtCwevV+L9r?=
 =?us-ascii?Q?c1O+ddLqzwKXexlRKkgiuVtC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vPR3I6XZHWIkEvOjzqM2rif9QDju851I2/3BNcINuvWieCh3cV9//xGTJd4i?=
 =?us-ascii?Q?b3YY9vOmYTw4YwWL8/Kv3WYUwAvjDWBsNIM5CqfDF0oG+gX20fYAoAeYS30j?=
 =?us-ascii?Q?4jpQhgbXPz/iLzFX/xmBnSSajddV8SAKnjdGfqW3R+Kh0W48EZu6lsKrdEGq?=
 =?us-ascii?Q?Ww2Ajx1wXyvtYjsikYzLkm0S1ZBBnvzelzzTA7/R/V9S6EO8oeLPUBQgb6oN?=
 =?us-ascii?Q?kbdXuoyn/0xv7eKpCe70mWmcxw5+bN6du5eVLVfKgSTOIFn8zLEqINXPnntz?=
 =?us-ascii?Q?6mFEyclsRWtNrE2GGvxE0bP3XoYjgVu1LzK3Ml4Hb2DlBL+zwcUs7UwrE7Mq?=
 =?us-ascii?Q?LNeFOSW/xm5vxsyLnzXqAF3EdkMVWwZ/cACazGBzYKhhTwXKHWMgsooC2zIm?=
 =?us-ascii?Q?xk6/Le3IPq+bbpGu1M/ufUSOd6cS/hoUIgMESRuFnnWOjizC3+W4KHvqsgO3?=
 =?us-ascii?Q?G5dOwNxYo6c7TRyHLgC1js2QA2MI6sDsZf0y4LAnzhiQIqNmvyxbArBrZZgx?=
 =?us-ascii?Q?KMJU3oN6kL/qKRBX9kJtJ8VlC7kUWTr5Xm2StJ2UFJrjt7nOUB2V0KVhYDdA?=
 =?us-ascii?Q?di4g5HlVjiicAoS4CRWnUKcMp3MALLcZnWr7kjaNYwSc1tiL9uGARUulDWnk?=
 =?us-ascii?Q?kvtN3b//8FcOkyASIu7HC79/lWpF5myXQYS0epwUfxYAyfXclDKGUudH3Dml?=
 =?us-ascii?Q?MLJ8v7ZfJSIwvxSMcGJxXeOqX6N96YAp7EZ/fPzAbbgrExe1rppZMGtxqa/z?=
 =?us-ascii?Q?gbqbfVJJdw3c1UYSBEwT5X7fF6e6GFDSlAkLj3jUyM5FafYQfj+Vld15Y8Cw?=
 =?us-ascii?Q?l32Rvs5tLRNlI2HDBKh314d+JkQrAhaQwJ3/qGQSsFmzoDiM1y4MLD70FW3I?=
 =?us-ascii?Q?5jHQU4ijEk6TGXPIGH7/9J29g6Mu0GkioDw2E2jzkaI9KHW3uWoYTeMBmaIW?=
 =?us-ascii?Q?WzfBr2j6lx840BHRDb8sQNaa2ell2oUUSqtRNjaY0a4SgFBL+DLEJo91OYIM?=
 =?us-ascii?Q?LdyneQ5zG37khXn7UX2nXzMfyLd6ayQ3ZdgYb7Ri3rHgpjnMZdPkDZ6jeYUu?=
 =?us-ascii?Q?O/an/w2TkgFVLAZqtmTv34cG8wWbl5AciEiW1l5I668nYOZyIMGYTsWG+gfW?=
 =?us-ascii?Q?7kM0JFt3U53YhYi8jdUe9eN6TKDWQFqLEjSDXbX+tzfXn1npP7vUlLIO3JeQ?=
 =?us-ascii?Q?+714ZYflc0sgW8+DZTgdake7qkeI6lGsbzJ3o6gB7UeSDiE7ddUHkcm5FJ7M?=
 =?us-ascii?Q?yyXGb/koC2p764miQoQDtajRM+TdsAVliSFK0F3Dj2SjwE82TDhgEa6IGDM+?=
 =?us-ascii?Q?MG40vweQEdNSS0RR5EQiEHDVM3miPbE9J2eWSIgFyNPwA3hZwDS7kh6Z1iHn?=
 =?us-ascii?Q?cSowv3Bj9Azmntv3xpwZ/Iqg9TVTbX+m39DR5sNaBN9Zl7t7IGZ96HY0OhfI?=
 =?us-ascii?Q?0HaaVXzXX6uywoCfkfM5PLyVKrwmBpDoEp3mIabXUU/jYQNuRNCko1Vt7ckV?=
 =?us-ascii?Q?3TXkNYvge8TgCs/kVAi8sWnc7q/fhk0cq9gtaB1/JzjXPu9ypAuh9fAS/Tbf?=
 =?us-ascii?Q?m+QS6mLiJyLMXymKLfigY3WlxjwIgKuSA9XBJbigOx6lfqyMTb7jkikSF540?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	xLmdFhwze+aEM6btMhrCKcJK6wHOF+eRci+gX3lB9BDNcKPzKYKjOyKSf+31wpg5hjePzZn0T0JI2+8TN+G8Ddlnraa/4UeP4T6u9OFUh7LxIExYj231oqrz1hGAZsF8dsasUn2o04w41/8DN4Dc+QTnpG0CId3EpWyuGqeIT7cvXNcEnYomTP1oubbpDCG3sKosbbhw00TFDLjRMeO71DGVtocb+w4g6+pDHDgVKsnLvcqD2mLfzvxCSwnGO/SsoKU+X1uSBiNObrUIGBnYAEqbdkNNySgpZg42UiwRK6xpPy5zcVGUCZoxIhxUVQYAzxfhP3VYUQqJtkgZ8Q9VX3bg/RcybzN30sUzD5ge+A/Q5PZcqR6dgQcBlOJHHv/w/yt40j53l0SDHVnwcmQp6LzBxuu/ygvZffqxZaqjoUEYksycWA995/z5b7vHILoBYsilu/9q6rEgcGVpPMx4eTpjF0KiVDkYU+2Btu+N2OLrXEPIXqpUmWXcOwhZhp5KBHAfO1YFRPVCrOh9ibrcjNmmyq5dG/9MFW0Ms7tRIW3Rjk5HO7pXhE6LrWHLjLV3WFpfHUG+p1rudHUvYHhmKa7pphjhANxp0eZSSu6qroY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 274aaae1-98de-4447-113e-08dcff5f9615
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:38.6715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ghJrKFmvtR4+H1jRqX2ccPJ9WK7Wrb2evQWM68OXNohvins7Dy8Emo7hJfatEZWWi7acIQFF9M8aDBoiqnvmpTWfp4Fj9bJrxeMe/ti6X2o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 mlxscore=0
 malwarescore=0 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: fpVnkxKb2ohbrqN5l2HpxxZtXsrLB_wX
X-Proofpoint-GUID: fpVnkxKb2ohbrqN5l2HpxxZtXsrLB_wX

From: Joao Martins <joao.m.martins@oracle.com>

Commit 842514849a61 ("arm64: Remove TIF_POLLING_NRFLAG") had removed
TIF_POLLING_NRFLAG because arm64 only supported non-polled idling via
cpu_do_idle().

To add support for polling via cpuidle-haltpoll, we want to use the
standard poll_idle() interface, which sets TIF_POLLING_NRFLAG while
polling.

Reuse the same bit to define TIF_POLLING_NRFLAG.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Reviewed-by: Christoph Lameter <cl@linux.com>
Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/thread_info.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index 1114c1c3300a..5326cd583b01 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -69,6 +69,7 @@ void arch_setup_new_exec(void);
 #define TIF_SYSCALL_TRACEPOINT	10	/* syscall tracepoint for ftrace */
 #define TIF_SECCOMP		11	/* syscall secure computing */
 #define TIF_SYSCALL_EMU		12	/* syscall emulation active */
+#define TIF_POLLING_NRFLAG	16	/* set while polling in poll_idle() */
 #define TIF_MEMDIE		18	/* is terminating due to OOM killer */
 #define TIF_FREEZE		19
 #define TIF_RESTORE_SIGMASK	20
@@ -92,6 +93,7 @@ void arch_setup_new_exec(void);
 #define _TIF_SYSCALL_TRACEPOINT	(1 << TIF_SYSCALL_TRACEPOINT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
+#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_32BIT		(1 << TIF_32BIT)
-- 
2.43.5


