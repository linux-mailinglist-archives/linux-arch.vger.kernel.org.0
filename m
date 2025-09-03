Return-Path: <linux-arch+bounces-13369-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B89EB428BD
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 20:35:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A7EC7B65D4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Sep 2025 18:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E833629B8;
	Wed,  3 Sep 2025 18:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Oz1WnOt2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WTH0fcO5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3A01B0439;
	Wed,  3 Sep 2025 18:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756924530; cv=fail; b=gYZCP1vl4ToiU/FZMNXCCGiRO+YskMDK8dl8NjstuWRKG8W1td7h3cdjBM40E+leJJs0zgc+K7SjcSYcwwbnXz0uJCL3BZlLAwfmPZpydn5P7wuajV6Skx0JLcTyGYim5mbrLDCfZ8OnToj6Q8sWlP5ubNtLj5hswABouNET/3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756924530; c=relaxed/simple;
	bh=39scSP9OhWqmw0JYkyEEhZuv0arqBmGRdb6txmEbtQE=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=c2irz1txKVedISEyYB8ASF14zbWi3lb59tLy7QhUO9PKhSeovEW500wCmI0M1i9MGRzdPMKxEuayZ9ZWMapNfx6fLg7nldaxPKdE1BeKd123FeUEM2PMkVLCNEsmtAhNx4FD+crO1+6FwKV8F9OQl+9NpIsJEwmO5GNFP0M/dl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Oz1WnOt2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WTH0fcO5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 583IMW9Q000417;
	Wed, 3 Sep 2025 18:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=XwG4yCUxhwRpSTDU47
	mw+zqSu3Tn9PejGORkXKdfN/s=; b=Oz1WnOt2ZbW+adL/ZtIKxNF6Yu6z+/yji9
	SyYJNI/BBiBBB+pDvKFCulPbpCDi64h/+odtDsc7gtQxs3Xz40LJPsONrQz3OUtm
	N/YPAsfUP2PUW7ouWhxfDB7OkXnbmJaUsyn4A3mmGaeoWnbgogUqZJ1sqTWIzPsg
	PHtx3cZijHbVAraRC1qrDea944Ped0zhTR3Yy8Wwa899TviIaL8m5BJpIWhQDl+i
	AeHWU4WobHgCG9ZBmZAujHECwDBufaWKVM1Iz7Bw2nXDDPPhuX28QC8rol0dLBav
	3sK2ob7UTd0PK53S5tb8UAdw7/iTjFs6yHj/MM6nOYi8hOnNak9Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48xtw700t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:35:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 583H7rx1015807;
	Wed, 3 Sep 2025 18:35:03 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48v01pxgak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Sep 2025 18:35:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jb18neFpZ1Rt4pmNIKU29c3wO/s6jVBGxht1sF2QgN2uVThNeAaR/3ZrFDuaIAMguA8putMScgNyZ6KqHaFe6FtdvvccYDkYdfkmV0wqUfi6MjgVMRAvbxOFtDIl53Q1/iCbdiicxDkSJkYu5+j2B8bbmVSc51DZSF1yNKfQikky+L3C5J5SrYmcNd20sIu6288ofqv4HYwQtAWzx4Z4xleWLV5imm+sWN+ruKyNKhJ5iGcgJ/XWq38+ypQGcfMkbdNGEkwodu3377j1HBjW++plcqHyD3im7pazqsaNEM6bz9iudfPWS0+r2nLqJ+sHEGApKPV8+8bCG77MuA8S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwG4yCUxhwRpSTDU47mw+zqSu3Tn9PejGORkXKdfN/s=;
 b=Oxhsajn1lkXgVBX+o42CU8hCUZSE3pZErk1SGEH8Ju2UwoA1+5ubZmaGfDG7LnYAR3qbg1ZUqzRgsV/9LhO2EAI5ClinTUkiyAbxZQFApxm69J0++y1HnXPypiuASFSs61jDBbhe3Elx3hN5k2/60C3Vwx0ZTG/w1wd2oSEEQKj6WAbkiJlgOcxQh9zCc5HNmpqtZXWFIS44U46VjtnLLjtSWNu2UiCp8MkqTjMGCsM+sI4YyGffrMm/2gXA8DiKKE7CFrz9l42ck5KoeW9VEyB3T3N6NhTkVVZa5aIbsDQtK+5iNHVWIYgsH2R7MzORKl1IDv4HvPu0dKJTELTHFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwG4yCUxhwRpSTDU47mw+zqSu3Tn9PejGORkXKdfN/s=;
 b=WTH0fcO5vgDFjnIjk6Y7HuHWzPB15D+gaJlhSxdR4u3Fd3gjTbNXaHBegg860q6JCTWCC48szr5G6Mp71ldtb2C0N2ahkbZvdr7BpFRxF/u93/FxCAL1/msbO92l23KuoJ1Lsdk1tJCn2oIbFBbCsBHO6oSafF3Ns8oQj5ZbAgo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SA3PR10MB7000.namprd10.prod.outlook.com (2603:10b6:806:316::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.17; Wed, 3 Sep
 2025 18:35:00 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Wed, 3 Sep 2025
 18:34:59 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <aLWITwwDg06F1eXu@arm.com> <87tt1kpj4z.fsf@oracle.com>
 <aLgJ9iqQhq-LT9S0@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
In-reply-to: <aLgJ9iqQhq-LT9S0@arm.com>
Message-ID: <87o6rro04v.fsf@oracle.com>
Date: Wed, 03 Sep 2025 11:34:56 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0388.namprd04.prod.outlook.com
 (2603:10b6:303:81::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SA3PR10MB7000:EE_
X-MS-Office365-Filtering-Correlation-Id: 89b789a1-b30d-47c9-240c-08ddeb1895b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCHr9MSUG8Cgwo94SZAPYFGn6WnImY/YgHeiAVv/safdZWIakKZwLkSJ0Sl8?=
 =?us-ascii?Q?aTZuDIpoNEVZ51LPVxVS2Qa+07uZrVIeyhBYf7UblGYfTmbQLcfLqqvOF34o?=
 =?us-ascii?Q?LiW/FRzD6b9xAihrBycavX0gEU4wqwLhX4FzjIvzL3RXqPf0LZe9DMuZuszu?=
 =?us-ascii?Q?3wrJDcN87zEKtsoYxVy5/+IFgi7cpmVRM6CqxfBRAtXt86O2zyBX+41RI/xg?=
 =?us-ascii?Q?PaJt9G1GzTKGc3Tzu5uj5GTNaO36J3o5t5RKvA4j4BAxJixs+o0OD9tWUoVD?=
 =?us-ascii?Q?T1XWiA/ecNZLn5R7mCAhg9ZXHXSer3K2McJaOq/0GGBrK85952nE/ZutDej0?=
 =?us-ascii?Q?hYnQB2KAAe9mRN3yhgP+njAndGnwpeo9QF7A0GjP7DlcmR4Kp6s21A8RubMg?=
 =?us-ascii?Q?+OXLZiN2W7Gp/S6adzsNoOsHL/LuvVWIWC6y2+Y7VVD0sfHhsVjhwPJZzk/Z?=
 =?us-ascii?Q?ODvBSdtNUTHW1H/vMPkELEcXSZ+fvk8pI0D13WY2tjc0dw5a2oAsMd81J8C1?=
 =?us-ascii?Q?mvEdRT8iJ21go+d5C/ZEALf6KPA+bekZT2g4VLRpeDt3bWWsR7Nw7/F2ylgf?=
 =?us-ascii?Q?lz6oeccMBqVvliBGRUxALP+vMW2Gs0hgjYSrVfKwiG2PmcKdZhiJziBU5A4L?=
 =?us-ascii?Q?3qvRZS/S4MtptRrSr+2YAZvZjpOBCLKlqU9//Bsai1UCrlDnBVUgaNVZc70w?=
 =?us-ascii?Q?6TyrHitUKrqT2kuOO1b6alP4MYyWZCgDVN7wvvpaCuQxY4oqlnv32orOPqfI?=
 =?us-ascii?Q?LZppqKagWtk4+QysCZFWq34QKNRhqE+VavKkb1jxdPuy71z9e2a0UBMt1Y4d?=
 =?us-ascii?Q?eP+D+vuhxOTS38/Inbdtjl7eXr8B/tN5oue8vlABlNpjnx7b76jbH6pCFTpx?=
 =?us-ascii?Q?CFKF7jhqJ7U1ieHY5p94YDodrCGGdC435KbylljuCVqPS6pA4UeyWLAcWSKG?=
 =?us-ascii?Q?lGUTHNwrxztAFW5GK0uJss6rCwG6MlBkJl/tRvgVa3NBo3rCjKADI0vbs0t1?=
 =?us-ascii?Q?ay0S8D6NVn08G5Qp8xYX4SNi85EHMVn8uR/uJv7jpOjMELJjXKjBoX6zYP8K?=
 =?us-ascii?Q?A0md9L5cc3WhkFO+iB09IBHZubcNbD5gAS2aYgGV3QcuBaijRBbe3G58ZWz0?=
 =?us-ascii?Q?0CWgtJEP6t8MSqLw58MQSTIhoeiGNSW+8TLo0EANhmIiXaz+QIrprtGqU6Zd?=
 =?us-ascii?Q?yeARhxyUH4VT5ur7HaKVeKO0XfYwE2yOLfU8FbhjW1pyKLplo9PO2YSHCqSp?=
 =?us-ascii?Q?Fhk91aTGQMG07fD2HU0KWB/jx3FILPtMEPtKufrB+uJfB/OzOoG/D7nzPbjC?=
 =?us-ascii?Q?yGVBSH5iJjqGt7yoi9NihAK6voRFyNtHBn7dEAKF8Qt8EhGvarTtOuMFYYoH?=
 =?us-ascii?Q?OB2fmRMvHkVFyqvLD8RMpvv42D0JXfYlRNSeqpdz/BJIEVDiqOFxZ2Jn6J5M?=
 =?us-ascii?Q?BG1YGCH/fh8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?px2NBQKBEmBxGNGzT8FhGvGSqSmqpxJ93Uyed0TJz7vFv0si+CqJr1DxeK01?=
 =?us-ascii?Q?Z5LHtsj+S8PuIiOL+X/d8H+tRCUjeXzeGxvWUjy6NkQGn5UGzI3j2gnBaGRh?=
 =?us-ascii?Q?tlCHjTJ8gLs1x6VUyOIopGmaFimc4/P4zRsglbYPRodsdD1GNh/zjrU4OjbB?=
 =?us-ascii?Q?cBu+/OzIS3SbBfGKbbQby3UJiOEXWpBKpLhKQJ4bmTtmoRNCBiP3KEYMQA/1?=
 =?us-ascii?Q?+176vZ6gmwlamt1Zknh61wcok+Bl8ezjX4+Pa/aTwK/UXH0t27TL6iYohmbl?=
 =?us-ascii?Q?ObEm8qSA08emrGyithsnbh4afAjHPcl9frz5uQTuFhnxN4HbXTwja0yDZaNL?=
 =?us-ascii?Q?RA/cBnizjKSJ4cFMJlmWuNMom2ScaNk3kmJgF+R/CMnCCSDGTMe2BcoW2v9M?=
 =?us-ascii?Q?053OZRRY3qZrCLtQeky82bUiWiN0yGAqqRT8toeAx3l3A0bojY20/RK77/vf?=
 =?us-ascii?Q?vDjg+suDEK+z7Q2hWdjte7BvK6FzU3WqEqGoUvmDwdDn6HKzZ5MgvMBQ6euE?=
 =?us-ascii?Q?XaG5a7WcbE5f0w/J6tlUgay7yjYzCDsHiGtnlwsaaIM3IOf1w+Mh+itFe856?=
 =?us-ascii?Q?gsZySuAFx+8uzRrCtAU67901facRdyc7poSy/bEqJI+TZSuxKWpXk9xt9934?=
 =?us-ascii?Q?F5Nph1nET3DwDnhX+pt+7YI68i/2OO8/FCdulPLyp0FLUsbIgISzjma8Uhru?=
 =?us-ascii?Q?Mdho/ynPHGMFpyjkeZWtdOGyMY5Sg+8wZw6sVPxW7yD7SYG1cM6AjrVRE27+?=
 =?us-ascii?Q?QD614IyEMR4/RkEn6J3KQRd7qN4xNUhmBbjxFJ+jkuZRUw5YkhQP+/NeM8ho?=
 =?us-ascii?Q?13VH7eu1eoV4bm/GN4tHV/bYVQYrxXHFW9W/JRUm/hyU8tZMnuCtSg7hD8nG?=
 =?us-ascii?Q?iHAf5bCF/QVNnJgqmAb/KXJNfX0PV51sM62KBgj5Hl2txXTUslCKPnm2pZFN?=
 =?us-ascii?Q?oD9UGJ8XLDfO/DJp/FLDeAAP+OItZtfvI534kjs6BhZmNSeVnVJlJIoSG4gs?=
 =?us-ascii?Q?OyVg/DngDrqnxTFVgDy59SQddAzHntLJCjHxdbVlO/8VU5gr+S109S+bBl4T?=
 =?us-ascii?Q?R6aKJw7LcsAGedbxe729cR8urCf5MeP3BR5RxoyB2XmfUILtJgM85yPmJXEJ?=
 =?us-ascii?Q?N+5lB7MZLuAk0fbUUWtHShWEBqtQ0iO65Lu+tX5T5xi99umBo6lEVIp8tKE1?=
 =?us-ascii?Q?Mj6WvO59I7t7hSor1ma3IEedRRyV0hsUyiZQhM4VZ5tFgwOfb9oq5Y+AK4vw?=
 =?us-ascii?Q?BCUex9zFBV4Enwllu/79DIfXHZUHHMH1WgpQW617DRMnGKNNt+SzCoDtmuQC?=
 =?us-ascii?Q?CTaYmoU2LAIiMVS3L+K1KcVOUm76qw8SDhsF4Tt5poFMYe8WIIjXcAzqKAv5?=
 =?us-ascii?Q?QE4WoHOjeU9Tg+UUUyt6IofhD8dCd80P7Q22k7auyhihtupVNjUktCnILTm7?=
 =?us-ascii?Q?3hhkTPye956tbyKDPl3kIdd3/XP0zari8ARIm1Ltgr3vHLfAYIqAJ4VNvlqD?=
 =?us-ascii?Q?qjlthomCcR8npQbPBHBwhFEklNIYusA63Oho5YSbPw/P0Iyxtb6gd8HyKMSI?=
 =?us-ascii?Q?XR9DBdrmy3xUgo/OySvtBf+8Fy4Fye/jNPMDTlgvpefmYfPyrP8kJnXshZbG?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	X0P3R16M9ZWQA37JACxbr/HEMUm/2OQ21cCsmSm5lu1M2SEtswbo4QuEgZLvZFsBzyXHxyL9h3uNqtA4Lj8OXGUqfhhQNJwh74EqbsBZOFC0zvEHpsBUUjqmzqVQPT6jhi3NbKFsgsp8rM8SKwiLQ6IkeUH33EgNdeVGklzCBhtLZA3R95FMP+V9BuRkf6WNIq0jCU1IxdsVtUNPmHDsC7mhl7zrXykRboznIPAbaWDuPdmmziqAgPSPmD5w4Rav3H2AMEc+UWzvAzVqC2DfSMSBBpVtr+hYsPMZFa+K+vCtDKk02wdnuFRxt9zrDvnBIiwrS4LpvnfDnLkhFmt47Yw3wLGGr+GuyEGVyptTByVsWptYHoKF1WDYcc+bU9/UiVIwMr1CyRaqDK2Trd+nqwgwFRRGgnUFI9EVRS/qRwciLW1MwJZ6nWB7mZdvKB9bN7DxPtOQRbq2yEoThSU31DW1V/2ysYHhbyvlR00N66HwuNTZ05a7Jc0uHQxufEduNdH9h7RtM81imt5oPyJLjxhM30UUI07ndwECNrpCa82ZMdjbbOXaxBs40c52dGA9m6VaoaywBkXC6DXZ1Tw7qUQ/jlVrKT4OwGQEWvEPhHQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89b789a1-b30d-47c9-240c-08ddeb1895b5
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2025 18:34:59.7186
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJMNvk5IOkXrtvCss8XjCFLAVLiq/vzZBeAcguYKzxnyuFzLdleg6jrfL3L++WrIDuj36c0l+VVbIz9TupmFnjcx5snjBtSOkm+RAJmz4PM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR10MB7000
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-03_09,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509030186
X-Authority-Analysis: v=2.4 cv=LfI86ifi c=1 sm=1 tr=0 ts=68b88a57 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=tt-1WniTR4Gn8uNbmBIA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAzMDE4MyBTYWx0ZWRfXzaAe8HdTWGcc
 l27CK7fUH5ysdM7GZTxhPUG2JYCC64Ne4nJfovh1/mSibO8vnQ8K8aPfDu3tdJyD8RW70Cc/L25
 mDdoQL3MGdKcz2UHmxEmBGlCLpcy96LKox+TdKTHgcNflg0/TeKSgHu1RlfKic8NGuvtNmmDUWP
 5/spTJ2NCpzJhMiDs0Y3bBoq+GbPlfQ45D8oZZuyyWTzzIxZ3ilAryD9WNnq90+unu15uPx7qPF
 qnokAnpPOKVTPKykR814s2ngF2t39S24oMzf0rro36ddAR6hYamT13CsCu/NnpofPXYTOsaDTbj
 Fro9zENCmUjsd8UfIkIipkudqdAGoZaYn3oJJ7C2AFj+oxHI/yAhc8bf0WzBST0ijvpmOChPEU8
 oOzlomTw
X-Proofpoint-GUID: _c4qjtwyQw2kcgcvBsocr0g94NcAFrUl
X-Proofpoint-ORIG-GUID: _c4qjtwyQw2kcgcvBsocr0g94NcAFrUl


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Tue, Sep 02, 2025 at 03:46:52PM -0700, Ankur Arora wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > Can you have a go at poll_idle() to see how it would look like using
>> > this API? It doesn't necessarily mean we have to merge them all at once
>> > but it gives us a better idea of the suitability of the interface.
>>
>> So, I've been testing with some version of the following:
>>
>> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
>> index 9b6d90a72601..361879396d0c 100644
>> --- a/drivers/cpuidle/poll_state.c
>> +++ b/drivers/cpuidle/poll_state.c
>> @@ -8,35 +8,25 @@
>>  #include <linux/sched/clock.h>
>>  #include <linux/sched/idle.h>
>>
>> -#define POLL_IDLE_RELAX_COUNT	200
>> -
>>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>>  			       struct cpuidle_driver *drv, int index)
>>  {
>> -	u64 time_start;
>> -
>> -	time_start = local_clock_noinstr();
>> +	unsigned long flags;
>>
>>  	dev->poll_time_limit = false;
>>
>>  	raw_local_irq_enable();
>>  	if (!current_set_polling_and_test()) {
>> -		unsigned int loop_count = 0;
>> -		u64 limit;
>> +		u64 limit, time_end;
>>
>>  		limit = cpuidle_poll_time(drv, dev);
>> +		time_end = local_clock_noinstr() + limit;
>>
>> -		while (!need_resched()) {
>> -			cpu_relax();
>> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
>> -				continue;
>> +		flags = smp_cond_load_relaxed_timewait(&current_thread_info()->flags,
>> +						       VAL & _TIF_NEED_RESCHED,
>> +						       (local_clock_noinstr() >= time_end));
>
> It makes sense to have the non-strict comparison, though it changes the
> original behaviour slightly. Just mention it in the commit log.
>
>>
>> -			loop_count = 0;
>> -			if (local_clock_noinstr() - time_start > limit) {
>> -				dev->poll_time_limit = true;
>> -				break;
>> -			}
>> -		}
>> +		dev->poll_time_limit = (local_clock_noinstr() >= time_end);
>
> Could we do this instead and avoid another clock read:
>
> 		dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
>
> In the original code, it made sense since it had to check the clock
> anyway and break the loop.
>
> When you repost, please include the rqspinlock and poll_idle changes as
> well to show how the interface is used.

Sure.

--
ankur

