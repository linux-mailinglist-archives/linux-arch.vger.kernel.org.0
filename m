Return-Path: <linux-arch+bounces-14185-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B276BE6A07
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:20:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C40E24FD5F9
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A511315D44;
	Fri, 17 Oct 2025 06:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VxwUGGxS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hUfahTsU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7E93148C1;
	Fri, 17 Oct 2025 06:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681812; cv=fail; b=lORZZZbLujlHFdT3AD8cVXU5awIRS5BC0wBNwaf1wv2FrQr1Q1nTTw+3au/fOsH8AejpY0OKnx++/L0hY6uKOtY8o/UxlepYFxsPEGkp1urJnKG6YmkZjpqAqEWHyHONN4v7tGs1Z+mEbwn/fJRrbpXEgj4vM0Wzx/ohaZiabSA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681812; c=relaxed/simple;
	bh=ngpmXEiLejrv5ekrMvYDd3mCMVLFH/KYPKW13IkBZiU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mARMTQGn7jy0zJz45O5sxM+W2dNy9Ts3aJ7FnhVMWVyS1BP2O9JTbZy7xO0IwK3yrsa4by1dLT5e8110cDcKFCTJ/0FYwagv0ZlbNEyzzZxMfPmupqjALGpIG/tIJCOgOzS7VpdxlNWOtc3oiaS+5tiRr3TNNTYXWRveDRfibkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VxwUGGxS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hUfahTsU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLuB0q032275;
	Fri, 17 Oct 2025 06:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=; b=
	VxwUGGxSxkGNDSXOlfr/RV5GcJBNHjGbXZRwClUVFcCXqAmplPdoUtDuflAS1z/R
	mn8RnLrALLS7WZyrjw4vrr5EJmQrQ+iG6BanZBqrOShlDpTNIzWg9DJDxjrTsqQ4
	MG49P1YrWUsJwM5RdipDxNA4N8UYzTSN5hxRlcFR6o3VzBPae4CzHs9fecoENThC
	Hxn+EZdslnDhhVXoAPxDFipR8XcahCxcmjg4JA0HfKBr3qfHnrrrTKykyKndY22X
	I1nXeEu0NLfL4bO7mNh4aEKeFTCCBce9FEk1cwIRwwL7+ikcEFS1yc7FRad1G9MR
	jtIFX4w1g3+e6ZFMxHQoQg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49ra1qhdda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H40hrM013633;
	Fri, 17 Oct 2025 06:16:28 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcdpde-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQnz7pxML4fB5bJaoShChBp7wAesI2m1J1KTd4z8iA38O2aQ4zVF7GzOTZ2JO1io6tWckg/vdld0UsLoaIivcrssgLaniVqocXdkPReILwtcdFcpPdF/Ra52doTaEMJmMckoFXsX1dn3xMF9FkRylOrQ/KyEs31yYqYUaOdA34QYgebpm0rNLm6/JByasyct5a9h7Ir9QZoW/qfY5sUoFknn43fa9jYQ/jtlPJEcxKXzLFvJojp4TLPJ+kxKuSLJfb12xAPdgtbz1PDx/OJ6/gqg2xmhP8QYmPIAUqfblq4FfS/fzLs9FXZZT1M3xg8RPSwVbCiZuk5Kl2vFoyKUug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=;
 b=TLk4RxP4kdQV9mvd4ijEALbHPQtEmQYOvX5LmCncZR54IXUyUIhW2EH7Nc1bb9L4IU+6pSfdnw2a4aSrVe9RfsElTitTWoNWsSlyaqA6Hu4eMeG/XHOEYsD51cwa2I5AQ8xBVvQT6rwDdYI+7FVWA27cp68ANkg+WQr3uMCow9MPOxmoWZpQwD5ojzObz5y0humVtHmfMrym7cXIhT9Bk+jEOGR+1XPSmxj1tevxjo3nL71JKHx4kmVXlnDf6W2pWUUEK1mnmBun076bDGvl7uQZ9yXxcaqcvZlstpyEyABDimmFbk9u+A+kVl7PVPqanSErfOjrIlQ2D1Cr6C2RtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivxqDrkgqhCU4LA/iz0wcEtr9wA5lm/mRfN/GYhaPIg=;
 b=hUfahTsUUz8v1nVXPoH0eyR3x4bfdf3sM3JojAgjql895jc4sftUE/o1zAs7fW7P4CoRvKbsZIcoy/xaIJTYJ9ymutQ8j620db3TpizUX++T6gRvl1tlOnUQnKBjXKKpOJamEG6CQfb8fdB65Gu+DcydZZBbIzHfwAzIIlT4PIo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:22 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:22 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 6/7] rqspinlock: Use smp_cond_load_acquire_timeout()
Date: Thu, 16 Oct 2025 23:16:05 -0700
Message-Id: <20251017061606.455701-7-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0342.namprd03.prod.outlook.com
 (2603:10b6:303:dc::17) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 6014c007-f76b-4917-fedf-08de0d44b182
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PgnWvxzxZhFFZGF9FtkAjQULmk555ha17z0yrpBWucKSnroTF263jwHVxR5R?=
 =?us-ascii?Q?t3gB6MoFZRoYLxn7pn792YwFWUPvbHnvlA3KMIK0IAKcAgJ6spKaBtxmMp/x?=
 =?us-ascii?Q?oQtvHrT1VFdhwiIQceZvFqMgZIZuYtLiuUUa1K6eFvxuDT2EQOo1pNWL9ww3?=
 =?us-ascii?Q?6AMA4I1fA6Ec9Wn6C/fmrZ/Gl0hNgTsGGgtb15kusWkMyX7mpTgtM+zDVS/2?=
 =?us-ascii?Q?+WkW/8KnOODLFLj07pHrCktmtWczusHa/RQRs2KGLsNKN7ObXQzfI2BMj4q7?=
 =?us-ascii?Q?E98a31EvTrFCoqX03E8N6eQ2wzB6MlmI/P1vZgTCo8wHfQ88rd/pY9/0v0gc?=
 =?us-ascii?Q?2rAb481WeHvZku1LppiuG9i87PWarn1YUmhnj4AdBHHzZ41qt6aFnxwI7enP?=
 =?us-ascii?Q?m7akDOfTv2IwIHARc8aqRMvN7gok/blzdGDDu43x3voIwh2/8DITT5jJzxIJ?=
 =?us-ascii?Q?yeOW68WTUBC3oWxGDl0tH0h9iVVZI4fi9btMLmAg22sAg4+wejCnEY4t1gBY?=
 =?us-ascii?Q?qD16Cu44ujgulmKgUTabLIGXXwoBVbNW57JVx2CSFi9x2uJLQKheyZD9EEDG?=
 =?us-ascii?Q?XpU3d7UsO9ellr432ivEATv/3Vheh4tckAnjvp1qil+gXwCBq/ETsmD8olAk?=
 =?us-ascii?Q?Lhx3b+UDwNQyN25JLIZuq7C9k/SveOAF/P4V8pYX+Ar56glaIKcGY4caBDPG?=
 =?us-ascii?Q?w+UBTRcmMgn5JzPoS38Y5oEo10Et774v5wg0DFwu2DJQRfb3v+dHUIGUkcdM?=
 =?us-ascii?Q?f68XLrfSzpA6vrnR1rSCZsciOSJzObs00nraamncsB2tYNnTR0i6Y4hlNTSq?=
 =?us-ascii?Q?BNsc+hDil42ZH92WR5Yg69yuUgh2w2ooH4J83fmLkESUdnh64ozgIq4gQ63u?=
 =?us-ascii?Q?3ub/HqpmqRVu6wCnHsOPwvhGti18NLYVifaPQ4AkUfzShHw87TAiX2zggn0P?=
 =?us-ascii?Q?MdR7HSisD+RkA2m/tENt5lxBauw9ptlQzDiSYspS/5IGL/KjgMvrs3/MngXx?=
 =?us-ascii?Q?XZ+x1wdv28jDTN9Lb/1Echi2/ku0tdGm0LNK7VrTuXaIX//j+YMntRPkpOrp?=
 =?us-ascii?Q?z8yB5fm6QrU6FztRh4jOn+R9+lC8wlNSTVW9VqwrIUlK94SxE2stkuxgHOLJ?=
 =?us-ascii?Q?UxRW92pAaLe24uPiH2fU94zRzAI/jL0aHoDz8wKSITbx0T+GVGv8dTDO1SCq?=
 =?us-ascii?Q?oo1pdnIeN454tjIc9AuVUHgcHYhFdRYy5P7uGTKWYDJ0Y7Ihbhhxmtl5hzGl?=
 =?us-ascii?Q?aaJn27UIOiUdfVcO2Ixm7w1/955FIPSikw99DQT0Gh9lTYlqyacGfwQicNcM?=
 =?us-ascii?Q?m5rx4UFZnIvzUhqnkYmwB3QT+GTrAxIawvfWzm2k/L7OkAGAi6yFRbvjJWSY?=
 =?us-ascii?Q?2SAgPpqce5vat3hKpaGvd1yfJ/32+f5O12ZTn8xeHlXWb94UfVipg821M+ca?=
 =?us-ascii?Q?kEss/oEqJUaLkDyW9IRQUlyO4mt+3DMN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sMc+ML0Z+Bc/KM+8C5k2VEveeRWuQfyPhXSUwPCeywAkVvk+FNbQUuOD8Xfj?=
 =?us-ascii?Q?s33zksSbFrng7unFqNl5f+DpYWK8iYGL6eyf1ZGF1ApGdhymsJtHfUNXxJ17?=
 =?us-ascii?Q?d7xDmjwnLaJYsCwW3yDaAI+aHnVhVq/a1Ut2LMaqzZz+yH9vkp2QFSsCnHGS?=
 =?us-ascii?Q?DYqZV6v0XLcAB64HYueAlIFhArUztWrxgdYUIcYXqxm4lsXUGfmCR8hO2o6G?=
 =?us-ascii?Q?8dJXqWqAMX7EQbnXFSnd96/7to3U/R/KJ/uogQG9mEcIhV2aTc+YO5brZeSP?=
 =?us-ascii?Q?WbgZGFcUB+B07FrGg9ZZ/vzzOelAAuTppzaTxkkWKLlpa7DWCvD7MsynX8hz?=
 =?us-ascii?Q?XRO5o5alOky3UK1M6npMs2uoDgc5zumMbsGH1ykt+Pnr5jc1wKYYOyQF7Bul?=
 =?us-ascii?Q?Pu6c3V1Pz/LYXwHErWri9oxqiaEb6OUbC2KlXfMnwlP6LJ9uGLRRpm9sZiY1?=
 =?us-ascii?Q?5GhHWoZCZXMrrPwumtXG1rC2AbkqQQ1L1KBjMLK8mrhTvsihhw14lVieJZNd?=
 =?us-ascii?Q?MNr32A9V8CLWy+fQcOYUYlDKlzomRcc1i43RI5FAQUHmFn2UhNCmhQjatt/N?=
 =?us-ascii?Q?V1nkKyd+4hBecWWyCoPoIeh9PxnwtZeQ4iUpeDYr6suBwFSXj0BiM2P0sGsa?=
 =?us-ascii?Q?nxC+6XLTeWzaG42saKU18GyBnrpbPPS3ceH+j5DVc94v6kz86Nug6kZVYPEp?=
 =?us-ascii?Q?p0GGAoTsSoQA0ADbgFgxj584zLKeAEhMeCLwbxsT97/5WWr2mtNrefwJssh9?=
 =?us-ascii?Q?st0OpUWxr6Tk7W0FCgaeMt4i/Jh+zDfg7szlc5Yzw17BoaaXEuZap8HzcLoA?=
 =?us-ascii?Q?1A+a0x6jnYp2pTFjAwwh40kH5kqCVDT8vkJFoVhCS9IFyITA5LPiFKBnsOnC?=
 =?us-ascii?Q?4VjuVmgo7Q4emZ1/Fr5vkuazv2WrLf13Vuq4C1xeBaUVqOCWQT42rcmyR04s?=
 =?us-ascii?Q?7e187b5D2ondxk3+5XoiN7SRVSu3bDe9frnwWzVZ/BdNYgkrt+ldPeGZJHty?=
 =?us-ascii?Q?3ZJZ5WHbNk5qMQLJkH2Wvfp67DIEaGr9uZ+Hxss0YWv974vuHyHDzKRbGn5A?=
 =?us-ascii?Q?3nHgqrD67EoxTF+MhQ+krM5xI6wkVkSmRsNvkRoF7Vv5e7tOI6H0ZKIpfFpr?=
 =?us-ascii?Q?uE9K1KyOeBgaSDHxW+n1hETXOlFfdsSDMgyOyVzGwjC4pNnRmBEKMJqo1O3j?=
 =?us-ascii?Q?CFjdkQwA0390Dsu30am/DiyrsMZUVEF1qR40TxJmrU7ag8rnxf1/q6Oq+fot?=
 =?us-ascii?Q?TMSjXOn76R0/dNvtDb/Zgre7W85QHwcXsc1Bs8fRggWo5BvbhN2Ame8xAhLS?=
 =?us-ascii?Q?UQd482DaYiB8XeSLVBHE3EBeW2H7P69+YhkC09mnwUnYhWHkJcmNyTf4VMQj?=
 =?us-ascii?Q?g0wu9W+/WGJhM9OfIbUFLQl5OjFFHld/TXc0+Ujtky971uEFaOvtlHQg87MM?=
 =?us-ascii?Q?z6PUAWwYRvdj0OSeXucVcTlQJDy54UrX6iAHbOwBQcSn93DbLpe6r35UUlwZ?=
 =?us-ascii?Q?/WVe5llATmADTU3TYP+oncQOFmOGicEdAXir5N2sMAZSOE4PqZk816ol1MCC?=
 =?us-ascii?Q?5eHztm4EztAcKHF4Qzd7X2NDLkPep5SHkw7KC8lX4vcGWVQIHQsZ3cED5Llp?=
 =?us-ascii?Q?Rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5MS2T1DDq+mYQ0wpFTTqUW/Y8Jqc/VsIsyb/pEwSgH5Ow5N1M2/EiRmHuKVv4R48ZqR3z6vB2Qu1uz+pbJDKta7hsS3Sx0nMPgb2EKr0gx+cLlxUJ5k/SKE7lXmxyIdvQbeZPzQ3DieXrEC61kX7gxwYV0XmlT6Zi4mzwlRu4KJtgC6ZxGfcBF+sSx2FNZ7UPfW+hTt150Wa0sasj9fSbyqtxw6oQg6B3SBl6jLD3hY7Wzl3xMD284RhUisGi5r2yJHJU8ZJbVnCbAF6RZnDu5Ar/GAYBVQ3TEtO7PX9nejgNtwnVu+7dIp/Awq5Zh3c1/iApxLhzNxviO6+UcRo5UaqYwt4OI9aHT0rkXmhE02BHZXRHcqjCho2YvYQE+peA34a27r2Zw1Wqk35UgnaJGudrN/LidQ73ICzwgN8mYZbkdx/uOO6AEhLyZVC5gD9wzmpolGqYXfYGJq54rshnX0xbETX9gF408KwN2Cs6E67fPbCT9gwMUPZGgKK1nSnLobuQFBpz9shrJ7uBozmLNJGNKqrlZtg/9x9PmYKJRCucIg5Xn0fLp7FE9ByUQCDKJst/Woxz/LiIHddrkOapiqKOFpVDIcFBp90aoSVWaQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6014c007-f76b-4917-fedf-08de0d44b182
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:22.1353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qQga/G2+ave6pW5xqB5wyW6JvSpspk7WVY1MpHQYp4pmRzzm1I+ezNpoCDpsPX8GctVTjQ7hbWLqQRbos3qp6tQXuvFRlmvK446UEqHsW7I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDEyMDA1MSBTYWx0ZWRfX/04/MvHTb5HC
 NoQ1kS+biu2jhdJvyj029bMOv/a06G9xvEl7YQ/cAbeYxMP1P1jz64MXiC2/Yz9JmbJKL3rnwub
 uec5u4KFshfYn9Ofyf5hdgTqVsj4IShVupz727Z7en4GUkpGj1Vihwi7Bp4Xac3b09IU/cACvuE
 ZeBQRKs6vBMgQfxYC69bUB2V0f/r0mVISSbPHHCkRY4y3BVALEyW7NjS9nzwz1lZub+/RSpODYA
 8mu8mqVNUicYBUKcyn3qHlI5szlmzWTKGQyy4QVRMJgPqR2h+rpcXd0Cl6Y/pv+Jgu5t/0U0wHp
 LPNMb+PrP+vzQOujb6et3zOfVUFXZ1SINVWFeO2YWUBzDotFt4BImEv6uVWKJvhJ9VIOshxxHxd
 wnR5+Jt9dSRt0ktBJOmOj/OvmxytGDG2h2SFedruEWqjX71tT7c=
X-Proofpoint-GUID: BKwmRaNkCkaoD1HX_vt5FrESR5fumBj6
X-Proofpoint-ORIG-GUID: BKwmRaNkCkaoD1HX_vt5FrESR5fumBj6
X-Authority-Analysis: v=2.4 cv=GL0F0+NK c=1 sm=1 tr=0 ts=68f1df3d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=Hj5KyUW9Q7wOCK9_zGoA:9 cc=ntf awl=host:13624

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


