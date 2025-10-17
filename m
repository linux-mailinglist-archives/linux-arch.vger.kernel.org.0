Return-Path: <linux-arch+bounces-14174-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBFBE61DF
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 04:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9DC474E21A8
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 02:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B452223A564;
	Fri, 17 Oct 2025 02:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NtZZEqhS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="voJt2OjZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B362417D1;
	Fri, 17 Oct 2025 02:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760668649; cv=fail; b=VwEO8PVhLd1QvSlmqqkg6r2+a8k2LSIW6mmrTpNqfOoYqj3YGtzy7J3WQJKmfgn0Z/UbPc4JuiQA0rhAZ9d8JAFGY8UQt0gR9/5jIKH0Ph5iIcaU2tPmPzwzB6lyh0OBfZRgIx1Ggmpmlqq/M2/1TwBVcnW2CoJC8hhRBzBTiGI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760668649; c=relaxed/simple;
	bh=36LgahVZM8NUOiNStAoIzGGzGQaTmNKEHLM82hzMtY0=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=XVQVbIypZELkhWEYk5aFYqqG+esgdcuFf9th6nRhS/VAkkvBu/LzAw7b0EXoN6Zqt6wqr4FFPOhqDf3PQaAbvUXm2F8QoDJ8qfGOfJmvloeMlutZaECn9dWf1LAPwFt0GV7EHFx5ytwcN9k1Arwtal5m4fyjVTq99lSm4v740/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NtZZEqhS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=voJt2OjZ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLu6hT019454;
	Fri, 17 Oct 2025 02:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=bMgvGj4y7HOTawLNcO
	omCqjaGnJ5WcDta8pIqpw9Uko=; b=NtZZEqhSp8py+PrPJkvIKoZmhhvE9OmNyI
	SaSLaQVQdh3jMm+tMqZPdWjtgvBzVDN3tK9z/CI6HXNQez3X6VZt/6Jk9C5W9sTZ
	nC4MlLvHzFPa8Dj7LCYB/5QxUpliqKQQm8AvynyzCDSvpzM5xb0F3KizU6A0xIde
	uQEsnuw5qgSCyPthgwGvi0hgGMKQT0B06fQOCbsTFyA1bDS5w/9LJNmzcifXkT2l
	zpWrSWZGws/sPPWA+gVo8FNtL19f1OxLux7jzWIdeo/WOOx6clHnd6W0NU8ESsd/
	owkFCrmReBLt711eSFOASPwPMqYjIkHyMOsdfAGyPaN4m1wd8ecw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut2287-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 02:36:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H0UTif000680;
	Fri, 17 Oct 2025 02:36:57 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012047.outbound.protection.outlook.com [40.107.200.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcg83u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 02:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eqmu21mGlXv3Krh+FTTURBCQdP7fl+trPIpHQLgRPSv9e1M6/Vwc41N4mKXS1ddAsHRzR8JLeDLSYDqQTwkV4dFXtxlQJN16Xq39aFiXuJBKwJ0tuWhCaUqJot3Lo68s/wPwWv0dUVKJ5hVX6HYKpE88v5cZyvOrnwKQ0+uO8xUYosPfI6sXP/h0WOvVRuDhBVsWluVRCNKKTsP2MJGcOem95XKH9bE5XL8CTaiNUFSUv88YzlIthpkhsPqRxqAsr1vhLKWWlewVzQCc3Y+LD4wuOHG5KUDbJkrgwIzsG1c30Kzp9cwcnU7Qfoxqai1smoSSgcTS2B/5Z+l9zgOIKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bMgvGj4y7HOTawLNcOomCqjaGnJ5WcDta8pIqpw9Uko=;
 b=dsXRmVNPuZrqvWjTwdPe3Sey3IsbSNoQYS8NXvkRcJjFUPJahkZAZ16RUh4gQNjTD4yokoU1AgDfdYsftlC5Z/IuqWHj2fXOR74Jf1tBKSx0WemoRpSy6oWaMbmdZjsd0Lsz3AeIBLLziJqhor82eFrk1DYKhk+ddMG17T1RfeAdNL6UZhXYDacAmfLeFSmiKV8atqA/doRpJAuhQsoiodIg81GjGGBX5CxMTcNB7ufUztULowPXN51Ojo66WWV33ux9HA60e854kLttBv9DLEKvnObRtcoARi0kK8IH9ub52l7ZKH4XVgUIN5G7xw9ZEO0wyxsRU/PS3kUY1IeTSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bMgvGj4y7HOTawLNcOomCqjaGnJ5WcDta8pIqpw9Uko=;
 b=voJt2OjZQ1lsWWAchUtGxSVWLqBknrqAWQfV4C/DBRVDWfS6aDAWDaxODXXnsD9rHgb/4FLBmKJZy2BvwuVlx1INmyZstZHHQHa22ZHe0s6ziSYVl2Bj7xOxKqvaUfWM3MkCdXq2xGRKVc5yoJFfR873rP39tP+ETK8JXuuwVec=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA3PR10MB8321.namprd10.prod.outlook.com (2603:10b6:208:575::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.10; Fri, 17 Oct
 2025 02:36:53 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 02:36:53 +0000
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v6 0/7] barrier: Add smp_cond_load_*_timeout()
In-reply-to: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Date: Thu, 16 Oct 2025 19:36:51 -0700
Message-ID: <875xcew8xo.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0183.namprd03.prod.outlook.com
 (2603:10b6:303:b8::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA3PR10MB8321:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ebb7cc7-3791-475e-fd3c-08de0d2607f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rThWLbYPMK+QqJ3EPo7BrMgQmtk6VGYv1wZWUUO4yz/QQzkHZSmGNDiIbCTa?=
 =?us-ascii?Q?LUAIiqhOMlc3z9xHxJHNxnfQzily00y1SKsRdbKL6opf6fieyCRHCY0KUOlN?=
 =?us-ascii?Q?glLtyj76AkczOf+8AeijZhX4+hu8xD9ZFRrCmoASI9rjpeShWTdLFujLpt4u?=
 =?us-ascii?Q?4bdYIM1ClX1nYltOPF4b4MHfMKMRHwSxf3+c0Yrr9uuqjKlR7ifPJd7wP1kR?=
 =?us-ascii?Q?26L2lK/uMyUlu41TpkwxANaquJ5PPeCA0PVt7KlbmAeEuviII267DG2QU30g?=
 =?us-ascii?Q?D5eEb9LQ2CBUk46WKdzWbluIl5Fw6sPrDxeAvviPtTvJv6Y1PIQaL7fiw8qc?=
 =?us-ascii?Q?7imaUcHJdPBGllBuO2qj3JKQkUD+5wMfQF3/tRNEuoc6CFXTqKKsXh2Emply?=
 =?us-ascii?Q?A5YLacfnnLCMJTnZ4t/AU+QLpcyZCBpOzAoAIT/ODuqiYZiTriezJ9Uqziqq?=
 =?us-ascii?Q?7+66E6hrR7v06bImNJ7isKDS3nsXH461EtQWu34LNAP5cbFByn2WtMbffK3p?=
 =?us-ascii?Q?T6TRlt/PuE8XXp+BVgpQ7687Pdjv4vWW0Fkwq9tMUWgTgZzewu8wI952BJWU?=
 =?us-ascii?Q?+QqYNkTE8U3Lt5ascKHs3pglCgHmXD4MUNyM3V0qd1pU76FTCypo3o7NP+RB?=
 =?us-ascii?Q?gDuSpA8X8jJsPGKVVZFlv60pLOL8w4GA1yzM9uWAq/dyIZlhktYU/FhpYxcN?=
 =?us-ascii?Q?M24yY8Ljcq8/78/ak624Hz8c/fOn4xgERtDxU8ErmZK2rmYysntfbEULtMwk?=
 =?us-ascii?Q?A5t+wzbK8bDDdngWrKRzTIk8C+3FocRpvFV+F7CGrIU/J7ui3ckbehwtxzey?=
 =?us-ascii?Q?mfw3ecdVMPK0m52HU3lyGtcftg7WRh+eqSuyXdwsPPYfTIcHs1PbU4HLVFCA?=
 =?us-ascii?Q?imRggDwNVIqHTLeDlsOg4509dRPMEZhIrx6xfbxeFcQ6HRY1J3uKHz5MnOop?=
 =?us-ascii?Q?HvyE+yco7KDMA/DMmjFFR5jS4xCrSMOLLnvW0lqJ98yLepcxxMjaMkgsWmFY?=
 =?us-ascii?Q?gwNz8e1ld6d6/jCwTr54eFBeqaSv6HaXIzELtQrAebvxHEwEgbzoKAe/Vwqz?=
 =?us-ascii?Q?TZQZUpRPaPIvTNYCDjQN84Hwx9DNH0wR878QnKUgTckM7+qUVsxjA1jv+15Q?=
 =?us-ascii?Q?OtNEhHtngyyZEZF6f/KqKEc28cIf/0ZKbHhgQ+CWRh+WL0pnm6Yqq8aoNr0K?=
 =?us-ascii?Q?3Ayq49OHvFCR9aBxqgG0QaHKui5Frf5eRmtqVbPTJA0j28Bs+JoG9XdBuojS?=
 =?us-ascii?Q?2dbxgZGY+9SiMUWzvdpJG0fdcN7A7613lXryYMj4iU9rSN7Hg9BU8DvajGAD?=
 =?us-ascii?Q?MXDemslwIHBAW/AkQpcSg7G3bCMPr+B7M6kebMuBPe33MS4rnGRzXc7xQAxI?=
 =?us-ascii?Q?oxXnZQCIINTrhp7euzItU+SlHTUJU1XrjZ2Pwlru3KbC/ELHsQlnpYtLlrSX?=
 =?us-ascii?Q?1fAh1zzhuXE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Ngub8GN8dsS8IJwn0f0EmCKBrhmaGhEJnLHzQQy0YIjZeRGzVvFiwYni3Mrj?=
 =?us-ascii?Q?/bIH9o8yh4z9Gny2xGif63J6jfZoYAOUZOSwCHr2CaciF/LR3Gq6b2X7/6G5?=
 =?us-ascii?Q?2qRIwRQgwcNr7g+yYIMWDRWnAwvramiradgPvlfv/6Zhn8BsFwI1NDbgoQR8?=
 =?us-ascii?Q?lR1NfRgUPiNEOah9/G+2mChgbmRLNCXmT0EEKiKeY2GshkKk3QWeIeQB98Hd?=
 =?us-ascii?Q?pOgXTiVPKtDiXfPpUMNVUKRXHVwi5m4kQBIJm/rLvjDFRub879WmggUBJpbo?=
 =?us-ascii?Q?fb5RFZH8yLP4S/TBpA2gwyiwjmaxddP2n4uTZH7mLO7zmkkENIa47LhBX8Kv?=
 =?us-ascii?Q?sm+wVKn36I5FyGaiWEQdXg/JD8fC7JKZg7yvnMXua3elfPzSCXw/7zXcnq2U?=
 =?us-ascii?Q?bZOlFPTjILfuIgdC6bbI8rYlSZhyMWsUdJiEE772B/Q05lxLFFC4FFeE/lbG?=
 =?us-ascii?Q?8KQG79bU9HOPXW0OdtJ+2kfnE7QCljgCszbzp/JmUvULzAN3on3YgxzBlp5d?=
 =?us-ascii?Q?hAhb8BB3KVTjLZhlfC1m4tMQvuObSrBO70idRhMyZ8NTzDA4DtcUVUuPhWxY?=
 =?us-ascii?Q?4vMTIDTyaf8PSIdR8/tQoI4Y1k4BjxW16BxmIvlDGHmw7zzLgWOnIyBhCA5v?=
 =?us-ascii?Q?FeXpdVn7IoRThStq4ZWlr2vmQ44VTO15vdDorCaN6rklY92DKlpV9djyGnJQ?=
 =?us-ascii?Q?MgbklBCi7T7wRShAmIDuUAeVyN/4evQKcYIMYsbY81nlNaIXbS3vz28bwHd4?=
 =?us-ascii?Q?0n4/BezDI41ZLlrjFkVIK4s/2Q48Mi7yUOUERsqFWOxsN96dz8pQ32E5rTvM?=
 =?us-ascii?Q?4HMPiYjcexrSabg9s/wtYk5Q0AWYIKUu20J9qkQ49WkNXIHlz+bmYvetUgOJ?=
 =?us-ascii?Q?W2wHoIgGbTA6dO2ZHRelEiYABbMm1iSp/0poNEiRU7HBl/domgIguU+hC9OQ?=
 =?us-ascii?Q?/via7hmR4ar5/M0sC+ypmAz33ndK8pNL9XOlfMNLN04NK8+uy9MhduJOe/xE?=
 =?us-ascii?Q?nIW1gJ4+hXKJ90ARu14hdGQucD1NHdr8jTJQrXWsQpo3YyETgnI9BdesT0R/?=
 =?us-ascii?Q?QdDCJoCngaIK0/v/ZouOejrI5nZpLKR7SVpEoUpLTxGVN77XBqDEiaFIFjyH?=
 =?us-ascii?Q?exQyXdGnwtG/wasWBemT+i0NGTnOId7Sr4GGchTSnFrZMQdKjGlecJHGT4RD?=
 =?us-ascii?Q?OeV9OJkSkgiFv1yREWZp8vrhzPhIbe3GcH00mkl+hNTRCW/X7ugxsR/94nUx?=
 =?us-ascii?Q?624otQVm7XpyhqM+YU2ub3q0c8RJSklKst9kCTQWscHP3w7DvsFiZ1nsWMjY?=
 =?us-ascii?Q?LU6rkeKzhhyD5eWfAxOvx2pj8I8MFcDGFXnOyLd/qQhswHH+rWcSY/jLS9hC?=
 =?us-ascii?Q?tMvMADnLOX5emD1+Ae1rwXaxGGqKyOVgPCSkKc/NTB2zP+wYAC3Gv2jlMrfm?=
 =?us-ascii?Q?wONbsX8xb5qhJVmTLkqj+/V2I0yAMV6ute2Z/V04iz48/AqtwDi5Y1zsvHv+?=
 =?us-ascii?Q?6IPwlV1J3fplxx41dH8XmX3StB6wlgd1TcqUZMvtBuwOIv9FrfE/Xg/DVqLJ?=
 =?us-ascii?Q?rGnhoJWWAsddCc/iTTeHEtoSLh8I+80IkSQfVa5pLbIdZCXw9cZSv++AtvSJ?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TQwvG93onYwnc0Tbpvp7qtPBCRYBK2GjQy4eeAdd8fiQrmqkOYehndUlvYyypXajx0Kb7uhvxKal/uW7k9hW+mNT6bSCEQRF5d0z/rliUP+iMPTdumVVpDytk6eLoY9w0SyUhvsxd0NjM1cDG3ybSjzPzazkT7rarTmPKk1i3qasJccL4dw9Vm6yqmGE2JKiUdb4AAMiitTP/Ha/CK4ZkK4f25OZoHO98RAIMbIqxe/3OddTkavmnFaw40rIOu1SXpqg6b+mESwjUOSIDxN1d8iTG/HbynM3ALJe3y8UNA9mjuGpqiAMSx+YrgKJbQrGen8frY2zGHjdiDY5iZ2CmVHHWtIm6l/JVHcdU7e2tCc65AaTPn6Yty1RNtuSbQrcu0tcRNrn4RwhBnzUsorX8Gub9qygMg/A3G72b+cewcPGlN5Rl7V4fFFEJyfBfX7dyScHArVnMTu3lRJuiBtjsynziJZFkPAD03+quJ2YNFWKzV8EpMU/bf0FvADVTKs+f2fTOMBblu8+dKoKYEF7olAJDiZQOXz+aF3AR5VSX21pNlqtRTqMm2RXOLgojRH+ussOf4Aw9OTDJV8xbUltTGQKYKEfqNDoDBTnfo5rlKs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ebb7cc7-3791-475e-fd3c-08de0d2607f4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 02:36:52.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B6ho/vgOMdyybPAbxEooYyAP7T5w9uCHE+UzXAY/i8ZHmQNbLs4Gri/dg+yREAMSTmP14+Q8u5VhJj6Lk+/O+aDpDH5a5XnVSx8G2G+tCm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR10MB8321
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_01,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170018
X-Proofpoint-ORIG-GUID: acdbPge0GeStm6RocbYAPvdot3zweqzM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX612Ik/9Yn+px
 5btyVrgu606sWeYquB34WtzzD0GIkmo4iBvY2uBC+oeP8U2Ded5W5Q0AIrBOL9Mw8umeRmWnWyw
 tw0r1kFSJYcyVI8RJAPJ+0GBn2napFauhIRqFZsfB9HQ77TTmhDDVvqYtJM293t8KqVtLMeUfWz
 roUDWcU1MoYj96DIo5OvBHaG0zAUv6Pj1Q6KZMUvwwpGyKNFKIbky1zdDPFBgBEdhPEXH1u3Oxg
 IYXhMewDUYY74jT/BYzBbZ+G+YzUxXCgYF+7qa50GGU4L9/dWT4myHvPViSkgHmWSeTel4MzJK6
 1R4L76LV/99T/eEThoSBH7SEHPUuPUObyMbQdzWQ6GnB62lfPexP7h3N7XMbOWraX9aJPVD1RO6
 EnSSRnLYern3yKIXNpfLbqg8t3UUNQ==
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f1abca cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=vggBfdFIAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=KKAkSRfTAAAA:8
 a=pGLkceISAAAA:8 a=sHJ4RUXsV9R5nvD9vYIA:9 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 a=cvBusfyB2V15izCimMoJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: acdbPge0GeStm6RocbYAPvdot3zweqzM


An "AI" review bot flagged a couple of errors in the series: missing
param (patch 5), and a possible race in the poll_idle() (patch 7).

Let me quickly resend with those fixed.

Thanks
Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timeout(), and smp_cond_load_acquire_timeout().
>
> As the name suggests, the new interfaces are meant for contexts where
> you want to wait on a condition variable for a finite duration.  This is
> easy enough to do with a loop around cpu_relax(). However, some
> architectures (ex. arm64) also allow waiting on a cacheline. So, these
> interfaces handle a mixture of spin/wait with a smp_cond_load() thrown
> in.
>
> The interfaces are:
>    smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)
>    smp_cond_load_acquire_timeout(ptr, cond_expr, time_check_expr)
>
> The added parameter, time_check_expr, determines the bail out condition.
>
> Also add the ancillary interfaces atomic_cond_read_*_timeout() and,
> atomic64_cond_read_*_timeout(), both of which are wrappers around
> smp_cond_load_*_timeout().
>
> Update poll_idle() and resilient queued spinlocks to use these
> interfaces.
>
> Changelog:
>
>   v5 [1]:
>    - use cpu_poll_relax() instead of cpu_relax().
>    - instead of defining an arm64 specific
>      smp_cond_load_relaxed_timeout(), just define the appropriate
>      cpu_poll_relax().
>    - re-read the target pointer when we exit due to the time-check.
>    - s/SMP_TIMEOUT_SPIN_COUNT/SMP_TIMEOUT_POLL_COUNT/
>    (Suggested by Will Deacon)
>
>    - add atomic_cond_read_*_timeout() and atomic64_cond_read_*_timeout()
>      interfaces.
>    - rqspinlock: use atomic_cond_read_acquire_timeout().
>    - cpuidle: use smp_cond_load_relaxed_tiemout() for polling.
>    (Suggested by Catalin Marinas)
>
>    - rqspinlock: define SMP_TIMEOUT_POLL_COUNT to be 16k for non arm64
>
>   v4 [2]:
>     - naming change 's/timewait/timeout/'
>     - resilient spinlocks: get rid of res_smp_cond_load_acquire_waiting()
>       and fixup use of RES_CHECK_TIMEOUT().
>     (Both suggested by Catalin Marinas)
>
>   v3 [3]:
>     - further interface simplifications (suggested by Catalin Marinas)
>
>   v2 [4]:
>     - simplified the interface (suggested by Catalin Marinas)
>        - get rid of wait_policy, and a multitude of constants
>        - adds a slack parameter
>       This helped remove a fair amount of duplicated code duplication and in hindsight
>       unnecessary constants.
>
>   v1 [5]:
>      - add wait_policy (coarse and fine)
>      - derive spin-count etc at runtime instead of using arbitrary
>        constants.
>
> Haris Okanovic tested v4 of this series with poll_idle()/haltpoll patches. [6]
>
> Any comments appreciated!
>
> Thanks!
> Ankur
>
>  [1] https://lore.kernel.org/lkml/20250911034655.3916002-1-ankur.a.arora@oracle.com/
>  [2] https://lore.kernel.org/lkml/20250829080735.3598416-1-ankur.a.arora@oracle.com/
>  [3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
>  [4] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
>  [5] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
>  [6] https://lore.kernel.org/lkml/2cecbf7fb23ee83a4ce027e1be3f46f97efd585c.camel@amazon.com/
>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: linux-arch@vger.kernel.org
>
> Ankur Arora (7):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: barrier: Add smp_cond_load_relaxed_timeout()
>   arm64: rqspinlock: Remove private copy of
>     smp_cond_load_acquire_timewait
>   asm-generic: barrier: Add smp_cond_load_acquire_timeout()
>   atomic: add atomic_cond_read_*_timeout()
>   rqspinlock: use smp_cond_load_acquire_timeout()
>   cpuidle/poll_state: poll via smp_cond_load_relaxed_timeout()
>
>  arch/arm64/include/asm/barrier.h    | 13 +++++
>  arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
>  drivers/cpuidle/poll_state.c        | 31 +++--------
>  include/asm-generic/barrier.h       | 63 +++++++++++++++++++++
>  include/linux/atomic.h              |  8 +++
>  kernel/bpf/rqspinlock.c             | 29 ++++------
>  6 files changed, 105 insertions(+), 124 deletions(-)


--
ankur

