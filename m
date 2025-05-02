Return-Path: <linux-arch+bounces-11784-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 642F0AA6D13
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA0377A5CF1
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B874D23C4EB;
	Fri,  2 May 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mbutWGZA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="d8HWsNoL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A75235044;
	Fri,  2 May 2025 08:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175982; cv=fail; b=tlqRIqyHU3UU380OxvN7JJcaBBt8GY80Uwe+u+R7OZIzRV5tU7Txv79HQxXu0iEHhe133Je58ppmGkob99ss94jdcvO6IChH0Zfu3PuUP8Waqg39FmK1miRiyojqdEKluF1HGNYsrmtklQVHyE2x+1y3Hb5qeKdAwOsv+lXdG3Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175982; c=relaxed/simple;
	bh=OcAZ7KEXYpRTaczow2kWQSgSJwTJ3e7igy1K9yPKh6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=odxHgpe/Ry7XNYjC+HdN7Yd/NGw9wyGzwtFPrGr6JDmqNzfOXwSLHYnhdW/vADDsKCe+giy3EUr742bq8HqjKW7b89bH+epWLjPg3uwnVgjk7UM6lda4ydR95xFFTkP6UiiM1lznMiT5QEJX/WAJD5W9PUT9kYeCDHx16EzCE+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mbutWGZA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=d8HWsNoL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425WmZD016319;
	Fri, 2 May 2025 08:52:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=pXB7sIO03dLVOlVL2RZP+4UmenH0jCjQrABQO6Jrv7A=; b=
	mbutWGZAL12+Gl5B4gep8UYdntcSN1TxXHTlDrRQVs9b31ppMszN+zArLLZGWcdJ
	AGDyCI4JCrssN7XbCDutTFj94wxUJ0k7Mf/TEOOttcBS1iMRv67/7PYgipQOsuM7
	4rMLrhsNubd2/9IF/VA5u+RUnryM4/lZ/wCa3Py2+8pwk6Jtki5zCjy0TE9AWk01
	eUvp57JHViGgoh84hhFbr/rC8MSTDUJY6AfaABZ9oHiARJ66eeXME/CDdwUnrcgX
	7aB7YRusKBClDfVHGUEuIWyQXSHgRg1lOoxxfiVkE/K7EVGOQuqIByjdgI1VRSsm
	2j8u5Ur+AVIYj70l0x6Gyw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmvp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5427bAcm035257;
	Fri, 2 May 2025 08:52:37 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdb232-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPXnN6YP3Bi9FG+VTidzsR1asSPw1iLzTclIEiG2iaGrBr1lmTfrPWywmdlgbV9KEccLA3M8gOjcJOH/j798tOtxxSOCuo6V5uMw6O5cORiuam8AFvGg69gDtrLHos0ESYeEKZijYyz4HFjubBYbXHNjbjo/r7rE08LIZSS6nMAS6mcZLAg54FXVpcEYZGl6dWyEzOp76G5JFB2JKaUII1ix8s/ty6cuef8V717P8z2q4n1j8B7zIXKZnrxkcrwADE0LSxivDfdK+3jpNlBZhYW8Bd08li9vfGlRSONtGTAXWlB57ISuLPRDdfVyrQwEYon3FLow6TrZa8eDT9K9DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pXB7sIO03dLVOlVL2RZP+4UmenH0jCjQrABQO6Jrv7A=;
 b=TB6OJE2rd1d9wwFLoO+Zg/cROG4jSgiA4wua27VHpSnq4JiSQtMtPch1cGX64+QKkOuqzVn7JiYuCqTOYJ9B/afG6IwTtebRLILcbf9feMSQBvRD6caon/0unUY4tTq8vSCw9+Gd2qwAPPI61aX5o0poGImFgzmK+HddMCXoHq0b/sUJvhZiErCgnpYBISI7LxgMvnRqxxKQ1VNLUc88gdCRTt2CSpVqSb5+Qoxpjg+keXUmeJiL/etQPjTNvk3EqKp2iCKR/XJQqg61S+aeKv88uIgKxYW0U7c7DT0dLdTMcjQjVBUyyhZ0QbnJ75niYkiV40eGWGItAcGL6NUVEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pXB7sIO03dLVOlVL2RZP+4UmenH0jCjQrABQO6Jrv7A=;
 b=d8HWsNoL7XFahfpZp/+D41eTLmE8xWmVcf1+Mwf6rtDUlPyYOtKd/ob6YiFMLghPNuHd6uwAkmcH6Ck9UYQD6B7BAnK3zRIeP1+HwF2e6k6tkWOptIVySJGSrq76e0h1d67j/ZWVClXu52DVjIEtlgYjAgPje+a/ZKlKDYizNOM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.23; Fri, 2 May
 2025 08:52:34 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:34 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 5/7] arm64: barrier: add fine wait for smp_cond_load_relaxed_timewait()
Date: Fri,  2 May 2025 01:52:21 -0700
Message-Id: <20250502085223.1316925-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:303:2b::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a6f60eb-1c31-4774-1f7e-08dd8956ae77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qvW9kTXzFby5zNGI3i7JKWKScT8t1SK4dEqMrfFonCwnGYUce/wVLArqCF1C?=
 =?us-ascii?Q?UqGxBqoU3d6FRhaQiO1nqegpSbJiplvbized4CKKubo1gVcX6yFxI4JkprvE?=
 =?us-ascii?Q?Y3C55i8IN1qe/pnOGB6yLTyPnriRzXW4fg0NezsfswKBa8nyDUBD5X9wLq54?=
 =?us-ascii?Q?cMy+54/+eqQky7N4RN2iYgruKmxKHmzNWDXTT3B4nR+dOaZO03Mw8cxPbJuz?=
 =?us-ascii?Q?FUeX+4tNSZfA1Kyns4FpRPN3xc+W/EB1gSV+0QTrO8qhg0yr26EMmT9Dy7Yn?=
 =?us-ascii?Q?LP6oKNKdIYRAgLwcYJRHjduXYXX++09CvvoJ+sEOOazrJF7MNK/csPSTX8MX?=
 =?us-ascii?Q?O6Urn1sbrIyr3spIovSSXvGSVIjfeLpP5gxWWzlOeOVMyWeluj0a7ARlYKmP?=
 =?us-ascii?Q?7ITgpwfSp3RWBJi9i9Aswtk2eQMI/yMcmcEvpt9Q8+XBdYRZlqpNA+fw8Ni3?=
 =?us-ascii?Q?upyedKrCk0bQ54uDrdAm+dlzHANv7uvUgGSsWSMQZnduD8FXw5vO9jGnK40U?=
 =?us-ascii?Q?aG4S+2KlMm6WMUfvbKPiSZpdGkk+FeRSEf9VR9E54apCRvipZ5/SMsZtfapt?=
 =?us-ascii?Q?ozZWzcLyTbrt1D7wV8HgFYmYzoG6dBsLXvqTgwGtIZye+XnhDkknrLtCMM3u?=
 =?us-ascii?Q?eY0Au2WgJd4wV3HVSit5TW5QMlUk00iZLJx81DqqLpQnpESjvZ2/gQ0jkOr6?=
 =?us-ascii?Q?fYDSwhM8t29IiROWNBIV3ebUCFQ/Q034RTz1yF214fc/FWvHbwHCNqafGd4Q?=
 =?us-ascii?Q?P13nBfwp/9ryoTKJdch0tk5SZcktnkMK2tU0dMX6Mx0eFpziZLccc3C7fk4r?=
 =?us-ascii?Q?ntxxWF720Zh3k+n+hYwSS3GT0hfihHq44ZoxKM7JGzjYTYa/CCPRqL4jSK/L?=
 =?us-ascii?Q?Ay04s92quEUc4W3uv13mnBvwMDfgGUkGZdbmQDucQ3+cE2EWDOaoIGIbmA0G?=
 =?us-ascii?Q?mZwoprdJYXDO7jmxdwPiGC3ZWPd1pDPCmJgZOyKRqB1MmFNdPkCtgTNqUmMB?=
 =?us-ascii?Q?XaMtthIHEhJVARi2YQ84LirIDTYgsDIMKCu7Yd7wSHs9ApMmhTFgAdgP5QaG?=
 =?us-ascii?Q?kDm4mpl/2xyP6KgVXtUUE3l6Y9/4ztXIJd95MHo+YAPUXkTVnX1zxnpcbqqR?=
 =?us-ascii?Q?Ju23bg+dJ1zXBVpn14+i+VfBjAvvT5wYB5XTsP4yZEIDxJqLzWtg8A/CWRI4?=
 =?us-ascii?Q?hC+fXgt3L+wqde8/8Tr0gyxodhM+06OJOhsIyJ4yj19fbNo8PPNR3bSGuPPe?=
 =?us-ascii?Q?PcunDxkyrC7LHrLmsUlwQUjdxH30IzT988Bp0n0Saq22h24zGTMldIldSHXk?=
 =?us-ascii?Q?TKSD0OXCQVndneero1tseIUOgXGxVFx2NW+HsgvkiUYfNQdwWrLk9hFlRm0/?=
 =?us-ascii?Q?CpXninxPnMb/U7KXyl6X68w789W7p27aJxdY8uRRrQ7uXnFEclWKgICbpY3b?=
 =?us-ascii?Q?MDiw2C1BPU8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KfRWVQ/zRrROENIuHdeg0jI6oChL+Z1if9rz8Vrz8kNdp6vEaBbHWJQRBfCz?=
 =?us-ascii?Q?j6wreMP4DkBWLUCeFzZ3kUum6wUDWYXUHUs52DgbpBA4tZT3iFIl5/MbXD35?=
 =?us-ascii?Q?zyyuspHXMOFzudgI2+Gv2MzFiiLlX57Uh2WfPG6wpW9e+4vZ4GXsNCfyU2AB?=
 =?us-ascii?Q?svfGkmBKECpvTCuKLHF2TL+9q2CXtTpVOjKzr4nsC292TNOp4kUgFu9RG8OZ?=
 =?us-ascii?Q?LyiwYymEuazdFomlQJ/+rYwVLc3sbxMKIwHiXpqGuVJmxyt0Ea9InIj3cdWh?=
 =?us-ascii?Q?eFHzMHrKJrDIFfOMInS1t3+Vm1WPstoQfdlHWmy3PVCacgOjMnxcFWxukHxd?=
 =?us-ascii?Q?goxDlEiIR9WgSOZC7ElInPhDD2O0sUFM5jcO0JzQw6LQh8uJv1IUFkg1N8+M?=
 =?us-ascii?Q?nS8gyTFGyEA4hp+Gwuyu0g340VJSOO3uNJ8h+CMmzgLsGnvPK3Wh2vpr2ru7?=
 =?us-ascii?Q?VokFIru6GQT+pR5piJ/BTWrJn/2tgC8fw6qtT918I1mKnoyR2CiWrSTTSnvs?=
 =?us-ascii?Q?hW2rX22fA/+dc5PomDTE6gdWnPnBACIv0o8m43LSQ4vzdwYYjmXcfv0p3SFI?=
 =?us-ascii?Q?9JS86n5RMp76roR32ZtyH/ePGuCBWzWJkpwvqQasKJp0dzm9oz8v7XbnggXL?=
 =?us-ascii?Q?YBl/oRosiEEEnb7OLrTjgTb/uZBn8njIFnz5QHHwrzeu2Yv2M7H0Z9kX8z0k?=
 =?us-ascii?Q?D2KHJjlJCogoWSSvZKAZdRFw7HsHfz+XR6HZZBAzHJ7i/gIEYTn7qoIeWm9s?=
 =?us-ascii?Q?5XRh+v49PRUOwp8wShgT6E/F3yi+oJ7JOkqaH9BWuYoSOIvKk2aBescbhpsT?=
 =?us-ascii?Q?QRSgeOFIZsVf7XNfW7hdfcGROtqfejHRcI8jpmwtlgV77YO17Ueare8TQDXa?=
 =?us-ascii?Q?3eLIfHAsIAenZOMyMdLnBkkjkeMxrNp9gzjjt5n3PBMmt5QGmIfVcORYHX53?=
 =?us-ascii?Q?YR0uLJyw791h35AR0rf8BzT+JhW0ISweR/vy6A0+grYuxWpotC5YiUQwDqq5?=
 =?us-ascii?Q?iCeQF9GGLdU3rtLbzHF1GcjZ3sCEFOClxHItkSpo9aZFNleRTIsKcm6xBlbG?=
 =?us-ascii?Q?wUV3cjS3Yp1iA/yvIP/P6IZWzrfN/f6LvzuHYgdktClF+A3/CKcB/Jw7kNtP?=
 =?us-ascii?Q?siXBUeBoJjgnjrq7hq4EqD8gOY0ilzmbVzNg2pO5NyAInOB8FmUSZ5IOh2ON?=
 =?us-ascii?Q?e87hQQosVH93WZeG8xJb3lFSYpkaDDgCR8MJnVjRwCEN0ax44pWRgpGTKjn8?=
 =?us-ascii?Q?7eJVATamKw+IE8Si2mHbCPnZzuYivAQAjCUpiRtBM3UbWpQTHm2JFgRT7EUw?=
 =?us-ascii?Q?FXA6M3LhteD+3QkCwbLsudszPORBmGfZhIQ4UYzBCEvdBoas3Z9NL8tEYfhg?=
 =?us-ascii?Q?k/tdxzme8jH6mKj9l23nkDJjkDSGvA4yqagDMunUlKZegSf/P77uFq2irEdG?=
 =?us-ascii?Q?Wtlvw2z99DGOMw5Hu6EgrPhpZuibs8ioCvoyRX7PBr9SWciddDTab2H5F5Ou?=
 =?us-ascii?Q?ZZecPEgoUzzsH6g17KIt6sIeP/m0e20+W4qCOjFL45GL90xXArWwAlOW5xvI?=
 =?us-ascii?Q?nG2E/dN+iF2CXaWoysTmYSkI+2QSDaAk64HYoTatdtzULFnhaiyJClHbx5+1?=
 =?us-ascii?Q?rg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RQu4MCFmdxhUnQWZR+mjFvUEg+84rdpC/UOHIiLyxqW0idDoQHl1uNvJSOXBjpmXc1zfSx0/lrE615JnFK6DBCFYXEygQMr+UNVBMxwkqlOZeRzSh5dTfOcj6IkhtAA7wpKW8JPBxTwQGYK1w2X10H1sVBzUjLqSTdlp7oxhj1Umz3q9GyKAIdHxkC6F+zEOaWqwonvt5xJimL29OW5eJWb433SC6Ua6p3rfwMtfgi3sOfAtw46iSBL5S355GRmNXXthYNdu9/Ec66pmfWE2OLfbI3Em3la3t8KgLYnrYsw7ZCQ9HDJzXGTwX56P4b2FHV+OIL9VDLngtXEws7nAtiwGnEJFTVVxgeLz2Uhxba6ihKm1CP/V2FRu2P9ThfO0D4+i3l9jEEMYRwdpXE6/wAKtwLH8ovC3jmA/t3P8ya6vY5P+oQPsikE4qLYaQdsQAHhEnOWsnjGLo/EgSwXanoj/wNXHhppgAABJtO/TdulqPy9I3Ek9+9DrD8cmDWWiItf3A2XiTnCy2Ydh5Yzn1RErMfdIihLiR6iu7lWAXsa49pkcLJoXn1H+QWshcX++PDuFZl9fpsR8TMm8Xndh4e3oN3XTYt3UsQhPMY4zMRQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6f60eb-1c31-4774-1f7e-08dd8956ae77
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:34.5281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ccbYe06MqnryQt+VUuM67MoR+flzHJheNfDcraUYIwhHmcg3gVGUB0Bw8D93T4XVvZSZ67CfA1TL08U0WL4KzMx/S3M6v5EbXduchzrxFGw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Proofpoint-ORIG-GUID: fiOqs_De0sLt9-7pSv5Upe4rEcfOBQfJ
X-Proofpoint-GUID: fiOqs_De0sLt9-7pSv5Upe4rEcfOBQfJ
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=681487d6 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=JDykIXjqGXbGdN20eRwA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:14638
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfXy2gLF3lvz3wO a5M1woAdwt2LG88ljPUbO03FFTok/IEgUG8vY/wzRVjjwGWi9WV3MRZr9wPX1g+K1WpSYaZtvGr 7q9mUwf/ICqLvfzdNXHFHIANZvEVYPsSP+jHxdW0JpEU0v9c942K2edtXWibcFt4oGgOHaREM53
 sBpvQ2CswV8qgu3MYBWTMLDb+G7Z7pPxblVizgc2M9meQUa74OUouGDWHq1kqZCEALP/Wv7/PBM Qfn3YI8ETBCYDNal+mvDYCfna76zDPFv5br68QZtKOvveASb/lWu7vthZa3V02/p1qh5SPwYypz Qm/7XCKommNE0/ueZdB0KXLQcMJgK01pXCY+h90x0jjpHkfUjD8DkHS0hzkmgxkWCYW5dT8r6Fe
 xT6973kC7P+nLfTE9U/AuzNnFu48yIBDlwm0Z9cpWWzwNmrZ7Su+NixusJInVMDVl5+5N9ZZ

Define __smp_cond_timewait_fine for callers which need fine grained
timeout.

To do this, use a narrowing timeout slack, equal to the remaining
duration. This allows us to optimistically wait in WFE until
the remaining duration drops below ARCH_TIMER_EVT_STREAM_PERIOD_US/2.
Once we reach that point, we go into the spin-wait state.

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index f4a184a96933..e4abb8f5dd97 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -247,6 +247,9 @@ static inline u64 ___cond_timewait(u64 now, u64 prev, u64 end,
 	if (now >= end)
 		return 0;
 
+	if (slack == 0)
+		slack = max(remaining, SMP_TIMEWAIT_CHECK_US);
+
 	/*
 	 * Use WFE if there's enough slack to get an event-stream wakeup even
 	 * if we don't come out of the WFE due to natural causes.
@@ -273,6 +276,16 @@ static inline u64 ___cond_timewait(u64 now, u64 prev, u64 end,
 	return now;
 }
 
+/*
+ * Fine wait_policy: minimize the timeout delay while balancing against the
+ * time spent in the WFE wait state.
+ *
+ * The worst case timeout delay is ARCH_TIMER_EVT_STREAM_PERIOD_US/2, which
+ * would also be the worst case spin period.
+ */
+#define __smp_cond_timewait_fine(now, prev, end, spin, wait)		\
+	__smp_cond_timewait(now, prev, end, spin, wait,			\
+			    0)
 /*
  * Coarse wait_policy: minimizes the duration spent spinning at the cost of
  * potentially spending the available slack in a WFE wait state.
-- 
2.43.5


