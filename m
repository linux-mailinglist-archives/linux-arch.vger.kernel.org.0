Return-Path: <linux-arch+bounces-14169-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 736C8BE4BAE
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 19:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 648493A3B29
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 17:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8121E393DDC;
	Thu, 16 Oct 2025 16:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SxM1EQ2u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y1EpjIHb"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B0F393DD1;
	Thu, 16 Oct 2025 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633868; cv=fail; b=ADQUR887X74wkAwvaSH9DsQV+si5iMN90cxgu0HqCJ/HLHGib3B5v4RuGAmm/J5ReCBUFdtoJC8P2bhbwVe9aVYUooFLGnVOHvIHdPpBPRKh6lyFb7lQvQfiCzLGS1AHe0/ql5xHWag7IyeQ319oWlVpCDowQ557sCAtDhwcy3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633868; c=relaxed/simple;
	bh=NHGqtB5fThT9GSjjnnyNOfeFKaO6abTooYBJy7DWtt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YftPNQTZhTqefi/2RPjypIo7JNHiYJYZuXdjdfdeubK5/NfVTj3am9KFIcfP8oH+THfDw7wB7zjn6R1s5xXatHUdKJdjKYZo5qMCtSgJ4lAEiZk9x+K+c1oYZ32RaoosfZ2+v0qbo3zYbaFyZPE7zBsdCYB6uFQz1h7zYCTkafc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SxM1EQ2u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y1EpjIHb; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVNvX000859;
	Thu, 16 Oct 2025 16:56:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iwex9Qp/MeW5hapXex1x/g9ryFh9VKZwHeSuZ8wBoos=; b=
	SxM1EQ2utDHG4FthuPRFz6h5WKyb1CuDKUVlhnFzPLT5q3Kg7+S26U7bToz3/HM8
	KaxgmkbAi6ovT0bTWMtA6Ss9+wO7K1tyRnZMd8B5GcywOSuIB2UBo2Th+1NayVa2
	V9Lmm3HJ+RfMpsqhX8fyTf8h/fEDSorV3mG9iWoh6Ws2ojNou2OBVAhL+2Jp6eBX
	2lYbTlEELoqE/WZDvHZXVs7DpTBWIQuF6RyVtnAeSu5RXv+3vG0eL/wA12Y2Zo6P
	oFrBUHdkeYbL5tPtOdi5hKWxsgnppAMKr7nt4CDODQOQN4S3W7G9IikaOZ6l+sKZ
	BybOn8hUx4WvN61544rixw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qfss1b7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFLCcP025917;
	Thu, 16 Oct 2025 16:56:54 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdphygdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bsqMD7f38Z5FNsZoa+i1zAn6HmhlyhNT/zcKRgDxTojbmHbsAul1PNCxb/Os9WsZSwiu7MPdicVwLlWN0jivZo41j5iSsmTDAL03wZN8kASdpiUJHDFHZNAMy+KxyS581bTFmsfyw7p3EkIGQUtgAOTpkxBpCOJf0BBg+VCGQ6fZtiytKDa/898Rc9METKvM9ycHFOsKqRkva+atTajeumfSlU6Q6jj0m6C2tRu7ZPKSb1fqqCr3+EjUX8w/mdnoXhpcLSbNWS8+pRJo9/gEfQpPTIwQLnuXTmwRNsdLki/QiXzZUv46nmlQKtkfspZtSnAMmtwqNoMNBUh60LuXsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iwex9Qp/MeW5hapXex1x/g9ryFh9VKZwHeSuZ8wBoos=;
 b=fGsn0ZsEYJGOQ8H06V/0EGOVFcm+kryHIEFqL7i7P596PdsYMlfVCQGA19Q2tAmlZUOkm41SE9pxSr31g8+kwU/7/i5ahZ0c6Jg9mLrvboKndP2wKFiF8nzzlbqe0Y7olpdlqik8bdBbrgL9FXT1aXEjPRgCvI/ev/L2H2M/p8B7McJhW+riT48FueDWq4IkXknRhUKQ9b0Av35i7+x2wSTv02q2pqPsZNo9vDatNzj5Yhv/6CWiTv9enrWunv9lw0ocODZiaBn3CXuSpN7RsMUkF6WycZxXQWy+fYTNK5PxnbbWtyYQ58wPSHaCF3Q6GuIrYG9IvU0HcIdAjjYvZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwex9Qp/MeW5hapXex1x/g9ryFh9VKZwHeSuZ8wBoos=;
 b=y1EpjIHbsSdixw+9ScZ28lyB1J9Quao6B84LYYUezQoLOk/SFBKTQ/kj6QUiTPpBMv+D9jyXZyWgBjY5CrLd4L9wTMY2yNFxlfWEZ66bo7gqyk0e7DHnqp/NSYLKYN8soY15L1yGM3RLvBhY/pOXwyPDvR5lyPpi4FwuR+onSYs=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:56:50 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:50 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 2/7] arm64: barrier: support smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 09:56:41 -0700
Message-Id: <20251016165646.430267-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0270.namprd03.prod.outlook.com
 (2603:10b6:303:b4::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: f585d1e6-3fd4-4909-17f7-08de0cd50000
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UCSx1xkYa7lWbTj4OOjDxkIRHcXBZVsOwIWM2jgRROyINBcb+yGyxUxJprQa?=
 =?us-ascii?Q?U5k++TPBM0rIn9pa7giri926gJzBT6Jb7dhfVuDCaeO7ZVMRMKObAr/mxqgr?=
 =?us-ascii?Q?C1vhZFV13JHw3yIsv7fhla+EwSSQrIa7Va+5ghYsjfmi8AU1khYN5V4YkQQo?=
 =?us-ascii?Q?sunNWcAyiaf0uqJDvfYKaltD5liByepCmYuiIMuPX4gKj26AQsHoW5dwMRaw?=
 =?us-ascii?Q?eodV8OwsqeJwvhyJ36pqgaKD6suRxNZdPPb9aGpa4516/f5kTZo6iHnkv5uW?=
 =?us-ascii?Q?JIk8wmlmyWJjpnX3eZwpxRfJYrUJH7O1SDUn47WLJHz0gAjmFcJSean7EuhL?=
 =?us-ascii?Q?XCHvxXxXws2F2uinJBzrYFXzeNJAusSmZAHjG/UrEGu5E79usxboDc+3Llq6?=
 =?us-ascii?Q?fsGtEb7XpYI/K4hj9UmFkVCRNzxKC9DQQwBEJRk1tvz0qSmAoQC4bzWYSxi3?=
 =?us-ascii?Q?NOpXi+D3/t6KgJEotYbjy8DiYb0GfOYyfCotc2+3reRSnckQXRBbh68rQRHE?=
 =?us-ascii?Q?sFHpqucNet3zj1X4Y2nzxEE+cUUPy3AGaooHUZZi3sRqI2X5f5rA4DXhqNcj?=
 =?us-ascii?Q?nKfHGZBaF5c6aEZDFHMNNYvwkOTOeP5IYG4Hbmm2ta0TBiokgJwBnMTjC9KH?=
 =?us-ascii?Q?bqwzlQmJ+WE5zSQp1JV6fSN1uDULZGHj7wIPGfpJJxQKijeA0uYDzdvlmAP6?=
 =?us-ascii?Q?uU9o+xml0JAAo466n9gCyNBNudqpJVGvRVTU0S8c2FThlTCGQaRIwdpMdAoo?=
 =?us-ascii?Q?etLA+1lRTBqe9xyFp3eD8vzlnu0AfTRCXS4rP9tXhMyynyt3QBOnWpRcqaaM?=
 =?us-ascii?Q?DhggNjoqsyXlUffdwtinytkhjmVLlvrxB9UK7eUh1CzlGs2FMNz3PAuovh3+?=
 =?us-ascii?Q?QnfMy6q5/FXx5LcRGzwJpnE7suT23YQh1Gy9DK30tcV41I+/t2gwd70q3+pV?=
 =?us-ascii?Q?IbYRrTQIOo+AiwIFrAWXnTTOtSAM4vbY2IkqICkoVZLHrDCSd/3Bfr/RRz5O?=
 =?us-ascii?Q?f7SxRtgqHd94V45rrvMDYggjhbvOpvlZHNivBaCz7n6Z2m9ApHdjoZq9Tshu?=
 =?us-ascii?Q?4Zp6EKgQKeszxgTnHZ2ghnvsKbGzePG2pAL2aI/2UqGATetCIV3ER3ysof1t?=
 =?us-ascii?Q?zzE25TVYGt5cf/7xB7lXXnAti+fVvZNWy53vM5Ee8K7P9gXuoKOuoOVsc/CI?=
 =?us-ascii?Q?lGPS4t34dLgLqB2zOQMho9w5wtTpuDmQ3Hnl+4EVT48d5fRceFUzgm3LbXqb?=
 =?us-ascii?Q?ijR+91863We5mkHheL68xjTD/z6Wv3Dt3tGmaXeFhX6NJoIOGQWV8scNT6ey?=
 =?us-ascii?Q?xR1YQKrGeJUxwKNiP+Ck1uCdBF9fqPqJT7x3yp3n+t8233v3tS3e4oqgqr4u?=
 =?us-ascii?Q?MvaxlTtIH39eA1JM+cTsnJ4C39dijSbR+jjjwk1RaVA2vm8VHl2IdM2mHIM/?=
 =?us-ascii?Q?sTn5cFN/by0czCeSdfScicKACnDBcAIY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CsGYAe2cPVPpWmoJ9tOIojNUQ63anYcJctRJpQO4VQA6/5SHpKaX80KZqPL8?=
 =?us-ascii?Q?jMIz9pJBjh7b1/sGdWumO/QLyV61xET0+OuhEDPeaPKS4+oDmb2nZ1A4ueKe?=
 =?us-ascii?Q?jQ8iVlFMpL2RDjToPGm7YD8gYTF4+9oDCouux455x2P8ozqKcXRtERDjLKzx?=
 =?us-ascii?Q?L64s0s0hAsUClE+nTfAWkrUKiqB87t/EYLAuA2li3RsThRKgWtmi24sTNH3w?=
 =?us-ascii?Q?CyRW1nCRa4Y0hFo/XT5aZxrJl/djpIUm5qtcUJQAqcvolkqTSZGhxdbgYJkv?=
 =?us-ascii?Q?NlPFtB7spcbf77J9sFUGI4S35XKEVcHkFXgxY/pJA42U9kgpk1aDpATYYOGr?=
 =?us-ascii?Q?6bfFw/4oB8Qq+0lq780x00tf1drUL/6SMV0pxLTGakoemQXUm8Xd+ePx2DLt?=
 =?us-ascii?Q?XkwgCdLICazJe3vlXjKPEMiszqiSqW8oTqrW+1q8VKZliacOnsOr9XtIGvo/?=
 =?us-ascii?Q?kEQlFILSmx4cGO/TZ6kbCgAq/SWVKkYJPZcDmE4YIOdSeGGBHFbTAGN9Fl6d?=
 =?us-ascii?Q?u7Nbi/ikqq7JnJOHb6+fvrVPyNbh+eDyQpuYlZedFcFhEKlCDuGXkIHka9E/?=
 =?us-ascii?Q?vBmZTwNa8HHv0q6VDyi3pNkVgSIval+J1U6K6aAeJgc+O6GqwOZNZrO/7MhE?=
 =?us-ascii?Q?/dP9I18vc1K08WuXQIkYIYKIWbWyawBbQ4WvuVSJ/36Wja+I7oixbQA32kI2?=
 =?us-ascii?Q?axyM76ovdYqTSOJwKkpTqPpy+oexm19fZbppGw/WyIqFr8c9gsG+M4hhW0bn?=
 =?us-ascii?Q?lS00IrZbxzsFFodjAKBSi6U1GDiGC40k/JxYaTJmM+UHzqYwDUrMV/FZUF4V?=
 =?us-ascii?Q?aB9pQ3ittVKEakeSEG8OvTDduKzMkFmgrSEE8wA5ZjUEyXIxVPez5s1DCjcG?=
 =?us-ascii?Q?XWuBr0FmuUhOVg18WhwApQCVsgbCP2d1nf/VRfdx5Jp70cRNneKXFyRghpcy?=
 =?us-ascii?Q?wBDh04XFhM5PSQz/uQe9Z1HeqyTKsxUYaK0WrnODb5YkvvSnOkJztJ/IMuat?=
 =?us-ascii?Q?A5+zeXvJiVjU0N2B+a/k7Jmg8A2j5OupVv1K4kMZcR+ZbXLtV2KZwxrUN9EX?=
 =?us-ascii?Q?AN5RdMAY9ZUlLxZaphqV7vu0Hg4BlpoBi2Xka8PLCz2R9PGgCfylWAcbtxHI?=
 =?us-ascii?Q?pfVEDSJfwe2ychgtVTwyrjyyKc9CEawzfI8AevR6NgdyZIouzkMut00N7zrp?=
 =?us-ascii?Q?wWQv2hhrpyBTMAXX/ymbTGlUckZybaofRH/z+iYfsp+si08dJHUXbx7gmGaE?=
 =?us-ascii?Q?G2vTfLmWFlXqIAgYL7/6kKJY/h9BImd6trKQ8tq1NX+VSlMrP4xU0tvoiUf7?=
 =?us-ascii?Q?DeJgCkLSPcnthL3mkOwlm3HlOiforhRXGNT8ypzK8Dd8VVOjbriFB/osT5aN?=
 =?us-ascii?Q?qOe2+Rgv0AbwCEMDm9cNsliI9pKWI5D1YByVp7uab9oTgRM8d1tGz8ZH2aSJ?=
 =?us-ascii?Q?s857SN0ZFip4WKZuU6OGq4g5EeZ3dSPb7W+Hh6T9aX8/7IAoj4n1UTLiuPQ6?=
 =?us-ascii?Q?dDG4Zb7AUtHmu+Drvf7CQD0RIWbKR7CwHJCg5xsupVNpC0w7L90lMILJ2gcR?=
 =?us-ascii?Q?UugtJALQcDDeYn7S9xTe5ZdH9Nj21DRSWgWtReqmdTD0FYzfEo+tJ4+/+S5A?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+qT/p9n6pj+W9MJg5ny2nN1DcGNn8jXFyVtm9ucTjhzx1L8MUNCUcr9S1nA3woJKEAvxd2db/8dQuXAG15DxJH6u2HILhkrbGx3uAkB7/aDIg4Vvds7KvFd6O3TFyTvkgh8LzyOaZS1XIkp8j1KQKC4wJk9a3NRob3M1EvaMnRO1INqS8hryIaueC0m1DTLSJFTWCee/iaRK7k654qpVxr5nyBGuXelcjJ4bnQs1bXUEnpChc/Vx5B6qhmYd5rmfF9dNM59Iu8FW5bfQDFTzeg6XzgWhwoU3dWUk1nu67J6t9xHsyl9e0Vf5jAmcSIpRZfbezy0ypnbsQIpp3Xta4f/3LBFUQwADx1l5faGQF4C8quDPxEYuCa6v5cfOO2FrYLrxs+DaDSTyGNijr5AeiYC2DQCIVDZo+P6yKWR8EAF9587fdjrDZy8QZZgvHeOdZN/G3HOrqxtawFNkqtL9xkQisRZAPU9kUxCEfP31GEoJZtcI2sID/+AcbS/t6us8/ItXQH5ucvHSQGtPWnIQBhdDTVjXXZC81X7PoiRXY4TCwEuS51FScKXP8n2A8kjgNinwQBH1k2qqFkR3l9rjD8p1/x8Dtk3TsM9VYMFbjO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f585d1e6-3fd4-4909-17f7-08de0cd50000
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:50.1897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cceo77bivD0mCSr0eoMu7nKMyjmWzZYnIyrzwu125Jb7Kq6YNNOYUAmhRRdFKFd5/xFLOI6bxAK9ipz/+zIadCF+sJOBFd7tpWZjX6ntV1I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160122
X-Proofpoint-GUID: -5rKKh9srGrhxOEc3WzGVmTLsD4T_H76
X-Authority-Analysis: v=2.4 cv=APfYzRIR c=1 sm=1 tr=0 ts=68f123d7 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=Z1HUBbmx4UX_vy3hcwUA:9
 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAyMSBTYWx0ZWRfXz/xAu3MJVdhd
 ob8FxwSfOmbZmiDLEoBElLFdBjUR7ItbfE7Hjj50r9fg3ieczzfbg4967oE4dNNBwcnHU6TVgNq
 ZTM7elihm/zkoNbRWkUtHDuIGYO/q7Pw6KqUM1UnTIeaBHaqQB2vb6x10z8yI0ZTA4Y4p1rx7T8
 RSZ5vBvEw+5OmDTd4gR++a1lXZ8VT8toLC3+268d8l+m11WSHU4/2rgrerWOJR3DMQ9n0D/YzWz
 YSHkFK1UBdD59Pgo6d4wWYkUmJCuwYWVcp0qDTyiUkmB74XBCghRyCMjiZiInv6BVQoeY/gcwdG
 iY0s/sUVQ9eQ7JYUQ/yjQhZvbI1PApg4SFBhnfhRQGaHZP49Wp/MNYOaic8i3lH8WGhvfqMRxxv
 pfV/Qqa9FtuHx1eBX9vSrXkt+9YdnhJNaTDXnEAW1RN3E5fgwLk=
X-Proofpoint-ORIG-GUID: -5rKKh9srGrhxOEc3WzGVmTLsD4T_H76

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). Limit this to when the event-stream is enabled,
to ensure that we wake from WFE periodically and don't block forever
if there are no stores to the cacheline.

In the unlikely event that the event-stream is unavailable, fallback
to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check for each
iteration in smp_cond_load_relaxed_timeout().

Cc: linux-arm-kernel@lists.infradead.org
Cc: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f5801b0ba9e9..4d346cb33a99 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -219,6 +219,19 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+#define cpu_poll_relax(ptr, val)					\
+do {									\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


