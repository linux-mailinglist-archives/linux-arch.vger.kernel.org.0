Return-Path: <linux-arch+bounces-11787-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC8CAA6D21
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:56:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 892781B6887C
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80F8C246769;
	Fri,  2 May 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LIvSvDgo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCsxIdQn"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD97B246761;
	Fri,  2 May 2025 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175992; cv=fail; b=LpcKFit0YTOyB5Od209EKFJmzcdCBHBN+V/wCj2mwy+T3TeQReVvEHiC+vGAXcFzxHo3vUz+AsidarvmIewvZhsWsXFBLM4WE1BoloGUPITxJGpIFGxii/Mk0KOdNEZ+thyP+e+Ggpq/cQmcaS3veiPrJlnw7rrw/+AksUIMs4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175992; c=relaxed/simple;
	bh=zGzAMc42YWASMTsCOd49pQSs5HlBWP8gUREyMhAYcFk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pf49ih0g32b0T/uJeEFDKnna8fNIED148MOCBg7wmPtV/dGBDO5MQER3BcmysEI3wXWGEoV5xmS7u4GMd9MXm6rp7UN574f15B7nimm9+4CvxjdK0dFwZMFlLXTbuoAN88awvIvEziQiXQrNrLqdN1fwJ3x1S1jM25U29C8yGTI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LIvSvDgo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCsxIdQn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WmZF016319;
	Fri, 2 May 2025 08:52:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kjV+gS3m7eoczEnI/8jb1lE8q7YmUGN7FwkZeS6fbpQ=; b=
	LIvSvDgovbu3g5eirg3gCMOzfaidZbySg3yzvRNNjhRA4h0bKeOczQYXz9n8T7Mr
	Hwj8b4qfft+fC0+9gyldbL7YCWn7PaBFxK37jzhE1hRalv6mBzzVLxyvbuorfxpQ
	yBgoFVdIGvPqJLq6G1m2obtXcKXTEBGRQxDZFAqQDjbrjuNy1pd/pfLvfLPq0+o3
	Op92C1J7t4hIwRJfxLZdLvFMoABMruPUa1Y4Lt7gubTdFj4zGd2qFAEJxRA/qC2w
	TZV08Vw3zDwf6X5wjwP7T6IuUzZR5CXUMm7khSkrpsQHYr7kzF1N81BttxcBdU9C
	G01rW22jpgoZ5A7eRDnNfA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmvpc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427CY6F023705;
	Fri, 2 May 2025 08:52:41 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxkt8tw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PW8xcwvm+3pcX8WZOn8clnmNyXSp9TcrH8sEBdmZM+PorMeEXOtx3+IicelG8hfaCNASsZKIzmLcfyzvv/QLKds4Oe7pBGkHLW8nAPH4WdFVyIDlqXzZKLr4d5L4/OUbZo/KsN0P3SAAjJ2DI25IHqlWiprdefGIAdd0pZkQjJfUhou7x3ji0QcRm/hueRfzDeEmcncfUMHvjPctOZS65Wv77IzfybLx3Vw8Br05ekQeAsNmQyhDvLOD2UdzHruvZ4TCkLvdftJh7SOswTk3k6mll19OPWHvB2A/9YbiZulgqTCH9CgJ1oEF3fvt1QzoeLIWFZA1P3iWEE+AKaij4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kjV+gS3m7eoczEnI/8jb1lE8q7YmUGN7FwkZeS6fbpQ=;
 b=HSolbNBXW2It1ZQzmp7iFChV9pQTcnbbHBX2SNUaZeTHBtU4DUk0GUzKvRm5DfSgt7HFNR3kidLi0oMWpfIFY4p1KvxxV/Op1chZK/zSlWgJ6dU6F4CLADgEEeArho2ctWq7MLqIpHzswSm+zKG5ZXssAvZmV+744heACS9B2P4MtfNWstXw+U5eAdj2Lws3tp25oF6YF+/12o/xAk6hBXsxKoFZ2pdthEOShG+V82HKQb2oFlx/xjsD8ignnRFV99HbDtuSxDZpPd4QeR8CaEaJvFEenlqZxPLEjFgok+5KrsFnj/emp5mRH4I8e17KEhI6Mm7ufv1k2oo4DPbxiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kjV+gS3m7eoczEnI/8jb1lE8q7YmUGN7FwkZeS6fbpQ=;
 b=YCsxIdQn88HREjaxGSm1VA1rKhqi34COZ8Vwb6vfLW+01a567zPhzprYg49TRzfkQjgp2HRM1nATFmHdrr/qbMI6jQfSprQwTXyGPpZvJqBwJwWFktmxInXzPliZqgIq0qLJ7JHCDGkWuUC4HRLMM0kxzSg/1FFh2Tsk5k4x/Fg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:52:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:38 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 6/7] asm-generic: barrier: add smp_cond_load_acquire_timewait()
Date: Fri,  2 May 2025 01:52:22 -0700
Message-Id: <20250502085223.1316925-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: a9a30625-3217-41a6-b1ce-08dd8956b107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sJu6TblGJPT3HX8wntO8xPr7VzTB4Ykx3HMCRSmsJ2Kh+s/NrsjxZCwVkibF?=
 =?us-ascii?Q?nOPI1A/lWHgVh53aLBwjWZoq5PAGEqKNK57gqdv487GGK3mIZoaANv22VJzq?=
 =?us-ascii?Q?WGrFzbBQ6uRWbVFNLIeFJcieDGsZyoDC4m5R9LZEbmylwWoMFnkMugfBl9i/?=
 =?us-ascii?Q?sEPM+TV1LR7op9iYE42HrB0KNJ6f1AwOrupjLMJAdBDJaw9WqKAL7zD2AKjL?=
 =?us-ascii?Q?7kPfkRtNl1V3giEzzUJQLFWNbmsX6lsp+vU+/EFU5HYk4uhR7OJB1olzhiL5?=
 =?us-ascii?Q?q2wbrtqCG06RR42TvyOywiqKZQhFbGcYmgegjWdlINIHiToEt07HY+SsOS11?=
 =?us-ascii?Q?srEgyddAr3e9GqtPCuSTDnz9p6gQ/EM7wHVY1ZpHvvap84b0E+YkJ9Iw3p90?=
 =?us-ascii?Q?LBqeHZf3tsjP+kVJaff09rCbsWibBpAwhvFlbVBtiORsLgdpXRPi6xIJeLED?=
 =?us-ascii?Q?+vKaGyoCItuKzC7LU2AQJPM5RQ29/ihlnYw0PYHFjai60tF8I04m4DPgnrnu?=
 =?us-ascii?Q?JTyk2oFGkhWdMXEfQyebxZEGIu0V31Fcm1HzMIk7cbi18ZcUzcdSiwcfKQDF?=
 =?us-ascii?Q?J6wpVsLe7oGZXLohF59/RNm7Iyc1AMZcx2uSdam7Y8TJaIk3TkI/Lm3EYEMj?=
 =?us-ascii?Q?yoIKcG21BheTdlPsT8h9WxWNcNmrwMHy486ZiNJ4osfZsu+aqREgGlcNBQvc?=
 =?us-ascii?Q?64LxsKDUFoZRklMNnWMIuHS9Yo9V7/ujFFxPEn6YqL6f4oCON8D2hQHXRRUq?=
 =?us-ascii?Q?6tEYVpE+peo3sNkXJC1Wn6MtJdBPS2QKmG4KkJB2aJ79TKurwqSMJGoSOKtk?=
 =?us-ascii?Q?wKai4t30YNxCqVBEPwrJnJb7KB2gC92QJ/wfgZJCmTuW3dAAIqMU6nIFWzzs?=
 =?us-ascii?Q?HQ2gRdqUJzJTV2aY63tAhW6ylZvo/gWGZMz+Pa+KmwnoJBbBWQOFiUzZXzMN?=
 =?us-ascii?Q?bFYvfg4OY3PqQsbBygUJTB8B5YcASVcs8foAeA29EQ0hC8vE1negNYV1fnwf?=
 =?us-ascii?Q?NJJchyQCfQScMFO2Ah+H6CSz4mo4PW3Y1WDAHPVr1SvhNJEbtJNwxR1i3zxy?=
 =?us-ascii?Q?s2u9UW1wEO1tQ/J7PIHjsCReqnHuzCxSWrue+qOaO4+L5I5it91nPsqxtvYn?=
 =?us-ascii?Q?6iQS/2lhfwdXCktDXqSPkFZLYneSmwSAg9+igcbV3geFvgD0EML1eoLII10i?=
 =?us-ascii?Q?MNE7R3P7wquI8B3hZaolM7Dx8iatq0ttd0ySujJ9L4ZJKfgR28hhmdbZJhRg?=
 =?us-ascii?Q?P7rD0Pcrrk864es2epqYu/9XHiXUxQiRDf3oH5F1wnUERk/Cd68jUJGIOq4r?=
 =?us-ascii?Q?o4FYEfuX2vKSrC6hjariBLmfobm6e0g2rhxBaPF6jpy+BYZa4yoFshbCz+cM?=
 =?us-ascii?Q?7IR/bMeI/AkoEkwEtN78d7kvFOSJLSecfHqpPyUJehYJR7qpkA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uyQrV3je2+D8ylibI/bF4rYVmPNqtHQ4VJZwH469ccR/lVW3cgbrgpRfG5Vk?=
 =?us-ascii?Q?hZkbF/GXlJZXWEFox0XvE6V6kYM5jPEshfxCgCGTlHZWLbyIslCBTQ/mYfE4?=
 =?us-ascii?Q?DQjkQA++7k9wwZ7kBRjYWHKzWi26vcN0MR84v4yITWf4Oz+er8hUXbxQB3UZ?=
 =?us-ascii?Q?kEEldXf+98KTGx6M58L15HJrtMZIY5twZLnhhZdxAeXn0ITRaFamU4J7O4lz?=
 =?us-ascii?Q?paoafIBmBxTz2fPbjvajMvkqDWsQYIQdD6yZVAzCNeV738R/iER4YJ0OhpMh?=
 =?us-ascii?Q?8eR5FezEYav8tlfapvI309wqNIrnGUFtMDUTnQcy8YiewZARxL/IjPMB4wxv?=
 =?us-ascii?Q?GevpeMqSU6HX2Hjx6mdQqdiPCfSo4dnzsnxpkQ0ErGpUPqnQhglqdpBsEW+u?=
 =?us-ascii?Q?P79D++ZHDwwMsrJCd4IxjnYFkyb3hL7F26jCnCJx06Y+Vyf2mN/mpFcUTrRx?=
 =?us-ascii?Q?9T5jtjhGFbEzta4sUVTZHtxIDAXHqbr6+sCpKDMf5QecG7EUubNgsTqj2hsn?=
 =?us-ascii?Q?MZ9xiYYxzkWGD0+eS5RqjIsU5DOGZFTmjTaxyNoDrSo5KebLx1+oWCuQwBG+?=
 =?us-ascii?Q?xaZh8We8GXc8NWeA+DrT3yYlR/pjJKURT7FIeBHI/vjWwzpXfNWGl8G78OV5?=
 =?us-ascii?Q?/nCVqVi8sRYYAmTpwMK/8A4FAa3ZMTPDBOQ8+tGaTi8XPQPbwenX9OONpPlA?=
 =?us-ascii?Q?UWjywk7EOtXj1wmXWACwjqYsOikH3qo/QCSd7nXVw+VyWvxyRHHzEV44NcWY?=
 =?us-ascii?Q?HNeTJrpJmWnVcKkAq9Gl0RTnWpwLrmE7+K7YGIsr/6rb0b8BjLfnnqQEkIW3?=
 =?us-ascii?Q?5YR7SzV5O7a2Z7f49SMme+RwE7pCEiz1BbXQdf0pJQilcUuLCh3PApMtA0cP?=
 =?us-ascii?Q?YSUH+kyQ3kg+PyFkLtakerv4SAQ5PlX0cX9C5R3peKTO/yOdC1XuO61oXrlZ?=
 =?us-ascii?Q?JQejZW+bvHNOywosU1WU2mXpsDGSXW4Uhh3sa6qTNF0DVHs6Fyk5peZA2IS/?=
 =?us-ascii?Q?1J1R9qJFF2VZGVgRYk5pvMmhGTx2shrte9YQLBIZCWgLixZ0Ubwv1Dnhiuto?=
 =?us-ascii?Q?V9tD2qyjk92H7wd3MvSSTb1LSnYK6H2Ci0IZmOwV9MnC7au5fUJY0iX9B8MS?=
 =?us-ascii?Q?X/+zy+WrMYHfi6/Y4lb1Zq+lJlMqRMJFgaKrWVw+whr4RsBq47yK66dtIsJv?=
 =?us-ascii?Q?SsTe1RKICindZN4FQPz14gbS7N4s2uTmcC9fsm/jQB8T1tKe8ltHcxqpsgMu?=
 =?us-ascii?Q?CjZGUmrYWNeYfLAfxIosR9GlNs5HI5jHw47tdAtEMA2eWoIlznt6/Y2L/U/K?=
 =?us-ascii?Q?Cucy1hTPW5xbIVbhbUE4NmxYH0W7ERppKDn/iMlSKYtXNH08fSv3ac27nxR+?=
 =?us-ascii?Q?aF8nfhtrL7WqrCzgVNq6k3SMUac9ItyE01CyN30LmIjWI0jDdi/nZylUIoAr?=
 =?us-ascii?Q?h4h81/To9BiDcp8lxQHGa7l01Al9PjZW7QaztFeIoMubXPdnPE25VYJMspa+?=
 =?us-ascii?Q?BbzvgfTqFpXQyWJaV0k/Ji5HFIRx+GHkp35MkrGe/KQ2kQtbqzsltZWHhPQl?=
 =?us-ascii?Q?k3NY6CTjlZELlCNOg69o1d4ZjW3M9aCKATG2m+RdgbBy0GtGsn2bxBWXGGS+?=
 =?us-ascii?Q?Yg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5sXsweaspIN0F+Lw6kENNhz3hSBJxDERGI9wvD1ajUcJ4iU31nEarGzL9/GokNEPznl7eRuaywV/mjagOsHCXRK939OYqE9vjB4FA5+UGYpjC68b9Vc/iTrOEvK/aOpo3zMBrdsT6s8wQLPyB/TIffV+Jgp0Z1lye2sJ0AeTTT8suRuO2Q5P1Z8mVBlfsnVSgXrcLmFgXuSFw+TYJPUCscdPSXnXy/+UCW6XFclz349+JT90t/viYG6es3h/PFFs+ywNtE0G0l5iWNEZO/i3MVg1eP89Bbzik/Vf/YG/Dcl+UeVP4Vn24YtcgbItK13Deji5XX7Ud65eVypZNpa3YqLIcDxYTW/xaaGD6BcNjqXb5/T/RDflQ0V+iMLdD0jJRFzgvM0bTTw//zUTUaH4QO2xllhnCWHBlpHyvHh8c8JU2GuzF6Vzv+vrlTQ+H4X7VldcB9eU87fV8coAuooupXIyJKyx22DhwTjqSpTD4UM+CmHzO8surfOCqJAvdy7PhNhOWBaq9pGdHn+15hguaVrSYYneRNQHxh2KcXTpPvJXwzH7wa5pyf7OKNXEfOusZBVQykkYqJTuhzUwjvxPw2Oyy4dBdX1BQHL8peMe3Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9a30625-3217-41a6-b1ce-08dd8956b107
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:38.7787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPAoZgAS9zz05KfHBXs8B5QqjyEv9UAhRHNIS7+1d+z00AWqP9kUVqPl+f4OUz6hh9D2LTXQ+XzIa8y49y5Br4/0POCGOFhJ5TZTCeiINME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 spamscore=0 adultscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Proofpoint-ORIG-GUID: cI3vMV_GS2yctwcVs7hyZVo0GJ0-UGlM
X-Proofpoint-GUID: cI3vMV_GS2yctwcVs7hyZVo0GJ0-UGlM
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=681487db b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=090cnQ_1IivCp55ikjUA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:13130
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX0gviVRIDjUqr wEZWEMvqbvPVb1PkF+yLjr4A7tEpkjM1Myl+g+NZvfob1djFYrK3GUiZWoU/jArChWWpXZk59/T 7Xt83Pv9Ks7rATKOnv2cyGKfuB1RFNuXG865kRvB92FR1kUFHJZf29FymdziNmq6tK9TvdKQZ0k
 kTqE13t+MagIngKBTx8mDqUr8RjDDGdU+yBXkzwUn6nCpqazDS2YV3r1nVj741pMaUwoiNHTLtB L0KzKnGNZmfnBjorPODGjRUnd80UzJ4nPlhH0Irii8o0geajfPFHZsDzn5OAMcbUKMkTsm0iiOJ iGtEa0PPPKwKwzy3NJa45Ya1qnN8lkW3QfoHm2YC7l0nZU7eyQoXfJbMXyMn6FjLEQWjZYEQYlp
 I/r29Fq8mO2kGo6ndbbywtKxHHG/mHBlLINzdotL+YToDpJk0LBw4DwooJYWxtTEbtOJqthJ

Add the acquire variant of smp_cond_load_relaxed_timewait(). This
reuses the relaxed variant, with the additional LOAD->LOAD
ordering via smp_acquire__after_ctrl_dep().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index 76124683be4b..2d52dc5b82fe 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -397,6 +397,32 @@ static inline u64 ___cond_spinwait(u64 now, u64 prev, u64 end,
 	(typeof(*ptr))_val;						\
 })
 
+/**
+ * smp_cond_load_acquire_timewait() - (Spin) wait for cond with ACQUIRE ordering
+ * until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @wait_policy: policy handler that adjusts how much we spin before evaluating
+ *  the timeout, and if we drop into a wait for cacheline to change (depending
+ *  on architecture support.)
+ * @time_expr: monotonic expression that evaluates to the current time
+ * @time_end: compared against time_expr
+ *
+ * Equivalent to using smp_cond_load_acquire() on the condition variable with
+ * a timeout.
+ */
+#ifndef smp_cond_load_acquire_timewait
+#define smp_cond_load_acquire_timewait(ptr, cond_expr, wait_policy,	\
+				       time_expr, time_end) ({		\
+	__unqual_scalar_typeof(*ptr) _val;				\
+	_val = smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					      wait_policy, time_expr,	\
+					      time_end);		\
+	/* Depends on the control dependency of the wait above. */	\
+	smp_acquire__after_ctrl_dep();					\
+	(typeof(*ptr))_val;						\
+})
+#endif
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


