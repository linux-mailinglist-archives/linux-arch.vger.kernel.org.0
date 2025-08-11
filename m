Return-Path: <linux-arch+bounces-13122-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E19DB21728
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 23:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46287460CD1
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 21:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D629BDA9;
	Mon, 11 Aug 2025 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="D/Sn9i2I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y9IFkwR1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DC92417F8;
	Mon, 11 Aug 2025 21:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754947001; cv=fail; b=jzpPtqUVvXIhvMKMLgBtVgQEZa7Wlc2/gAH8ZPCqoa9BXvFSjBgdsrGQwi0s2B3SCvQ/yh8nvZLz+wNJSQ/RADR1mGz9x9OuZzJOn06tSk5+HpwXXs87/+Vso/MWf3aWDxAGC6o+N8dqHo/YjrPzeBoxau4RdjtQGE74+ZOOYXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754947001; c=relaxed/simple;
	bh=ZTsebGwsUj4jxZdsBKKvN51OvGgkinD/UecMXyMhxtA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=o64UpzPViLJTWtkCRa5x9RCTKj0UAyIEIk9c2rOiO5TFG27O580ZGY5sRSvC4qupbmqzdN1ZfQRbupIfMv2bQGaB8ohJtK5i2265/LHj+w7X1E3WqsNY1ZanoFntSNvpnPi8smOGVjnhCeozcitQSONAteP+E8SX+nQ66XzhEuc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=D/Sn9i2I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y9IFkwR1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKu6c4003879;
	Mon, 11 Aug 2025 21:16:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2aghFscrIvehgJNuq8
	lcF0ws618XAcOO4siGxGr0RLQ=; b=D/Sn9i2I5QRdPbNbtFM3VjEQCT6+Zi7yzV
	vQlXioRsEtZ5pDLU21rPWegucyXvrIYw/9bRWmkMEgClJ1h0LBCfVKEfio0WgDJ1
	OEfUGlFlvYidrpH5uQK0DCeQpIp+QzUmUBrp+m+FTJ8Da3gtyEfBclk0d2FEnC0+
	UxA1kkxggvEdteVFE1TkAOrK3aHKLDD+yDj0IkIAgqa6bDJgiXe3p+T2ZhkK1IMG
	vFa/6MF9OTkjPTQkB62O4VrWv8i4L4DyCwnq3qROa4jP3pcJvWZNEbzq0qkAdoHf
	cBiBVKEGHi1ybyCRCip/R2occR9pmsVJCbRoXQyG35DD8sewYAYw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dx7dkea6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 21:16:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKklcx038582;
	Mon, 11 Aug 2025 21:16:02 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsfpp2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 21:16:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+BO6v259q2VTCx3gAQjK52AtdWI+u/O07fwfwSv2sKUEpKDHRIfWOtVzslkTL+CtVC6V66Ash6BKBGnMGyfHEHOXo8nbQl0PC118F+A6Hi1Vc/c1ygzt/E+eMw/Ad+c97coUXPUI9c5ZzFqcxTiKEjqE4pwZ9Y8EAHbLUGJnky7+Fgc8MSeRoMCjVEc6aaoIZNaRXF7WjOWTXP/f7Of3TH1wPVFsfJp9fd1nrcdBeAyptd+dvakqNW22O+Z+S5IyNn8qZ9rW7pocUfOxdoCzeXysXvv1n/YekmjTqCAwjJz+TLC1DPX3LCpI71ug1gRWhGae7DgKFBATW7YhdhE/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2aghFscrIvehgJNuq8lcF0ws618XAcOO4siGxGr0RLQ=;
 b=UyLWudadnAv4SXstcjbIqC460yH5rmBFljnsUKi1m4ifX/vUhGgGno6/eyKFtFTGrWyBDIaZvh1SO1fHA1lTSdmPezbhWZtkBsIEoDOPnU6dvJS58DGallhij1cBpS9Zl++LwUZU1EfUqYQmd5c2rqeNBYGJOhJe/QAEp76V3lglXZ+iGLeobhOsFs9g9yKGuSMxLpgUF0iFCTeTpG8oM48T0Rzyfef9h4tlBwExtCPaWNfjaAzI9KBaoAYyxiWHNynXCBOZGZCimsfrxtICuFCs653yQ7w4tfj1CbT3wHpDR5wEkZVfYwUdCI9xr+2ibMVJGgTANLYBMvwAlCGtSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2aghFscrIvehgJNuq8lcF0ws618XAcOO4siGxGr0RLQ=;
 b=Y9IFkwR1tXQJaC3N/mjZnjuA5CRM9A2DEK0hVvhP/DdPtPh8VfoZRxiC1W5JZXWDV0Q/7TlphcJjczzStLAaSmY7kq8J2o72ncJTiW2tbUFL63NudwOzkPKYC6xFYn4A5/3v5SptbapspCaEPtj36M5pL9HnyJCMaJ0GVe8HKOQ=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN4PR10MB5573.namprd10.prod.outlook.com (2603:10b6:806:204::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 21:15:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 21:15:58 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-2-ankur.a.arora@oracle.com>
 <aJXWyxzkA3x61fKA@arm.com>
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
        konrad.wilk@oracle.com, rafael@kernel.org, daniel.lezcano@linaro.org
Subject: Re: [PATCH v3 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <aJXWyxzkA3x61fKA@arm.com>
Date: Mon, 11 Aug 2025 14:15:56 -0700
Message-ID: <877bz98sqb.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P223CA0015.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN4PR10MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 75e93d0e-45d9-43bc-3829-08ddd91c43e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bn5cc0B7UWoJZYJdIaTsAqhenV3rogfXZHJtU9fBeBmHUVQXw+z7murf7DKk?=
 =?us-ascii?Q?E78D2R9NByanM10bArOYsh9buGvnIsCLtUJRa3Ckv9Duh9pocDiOS4UTlWHt?=
 =?us-ascii?Q?HORnXwFWgY3lLs5TtP+2aJcMMGVCqn1Ek6gNJTIaaN1n1Rccx3rtY0R5bVlt?=
 =?us-ascii?Q?lx49HSfP2Rf7lDH3uEkOVgKwTdrSU0xM5ot1sC4/RRnh6tOj25GYHyi2NtU5?=
 =?us-ascii?Q?Vr1es/ngYOoG/RCXAs+1hXCZcUJfVCkqZfS+CDkLhUroEbP6IV3d1tCONd+U?=
 =?us-ascii?Q?x5sGAwRGOuJDmnX8MuuuJNgpcYhGOmsz44842nrU80js4kEWrYwigDifRbnZ?=
 =?us-ascii?Q?+bMqd3Krb9kalCU9LTR45u97fzwIteqmjGu7KI8hnJC9Pwt7REpK6M8LyLsO?=
 =?us-ascii?Q?tp30sLT+pZtnT0JGd9ybeEaQO/2l+hS9rq7fYj7oQvM4Cb2RWtl9iYP5lGWX?=
 =?us-ascii?Q?iYTHqepupobg+Hy9vRTl0ozOBhf6+ImeDddWZjIA3kmhUmhsYwUiXhmnXOYg?=
 =?us-ascii?Q?MBUvjjqBR+PmK2yIUCJfpKt7VMBcBfGXuIJope6OBx59yb19JvUtk91Qj89+?=
 =?us-ascii?Q?RM1/NRtVJf2vkwiNqEq2nqdjspeO3i+rFCuwShjEDLqJCF4WmurCEUK3U2nl?=
 =?us-ascii?Q?l3UZS6HT7LhXqbao+W7A552o99mhQQhNLPW1y0EBmPf9FFtn2fXTwjhgl8Ak?=
 =?us-ascii?Q?Zp6IgHHk7u/MYst7b4HuoXMpaNJ6uU47R9Jw2tV+v90jfzgUMVnuMgJNh6NZ?=
 =?us-ascii?Q?ApkBY2TQmcvrghs3OhDhgv7pRjjUNoLfcmoUA9i9aOKXSSKl3igW59tHL6yG?=
 =?us-ascii?Q?iFdtTMmg0q6JfKavm90EEkeFYyAd7A3w40qbAsH/ogW1Jyx6SO1ZJY81zkiW?=
 =?us-ascii?Q?fPzOk1LsboWrnx+00BbWKRRxryhClI88JbUsE0mWUFcTg/BDftdRuzvDZkBe?=
 =?us-ascii?Q?tMrMI+GlZ/AyRrDLfQOL1hyQxHiBEy2jsz7rDmZImhLnyMZuo1+t1yieWBIm?=
 =?us-ascii?Q?IHz4CwAhEeHmb1AhdQ3Xqr99imE5+BebizIZfzxgJcp4KXD9g4Sog85gw3Em?=
 =?us-ascii?Q?5EoIV15ImP8Mevod1ADJBBrlJWyt2Z543rB1Tgng2zr6yumgcZ3aFJxlwSK0?=
 =?us-ascii?Q?5HFU0vjzzpd7LSSNgkNEy34sWgOxQIUIpR+haPE0dq1UQfMIeqbIA/PT1U6L?=
 =?us-ascii?Q?BEZfvSlbkh27EByF7MUMaSPBl4klGpax8MpkUXYzQHOhezGcOY9b6ndPAN+f?=
 =?us-ascii?Q?nhOcF/iJTBsmM+nvhbYzITCQRHrj5JN7Oz95ODF9BDVht2+hiiikaLKmdmOI?=
 =?us-ascii?Q?TbGG6RUFQsh3pdJJj7ZzRq7Em79X0j2vynqj0iprCsWBNf5QjUAQa702dPqt?=
 =?us-ascii?Q?Ob6xzO4Alnra5qy/BknulXD0byUNdAmAHH7k8VZkxcReRemfQbzxTYVQ+RMy?=
 =?us-ascii?Q?fdu6Ftt0VGw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?w/Z3c3nKKoSwITEHNOvv9GsPhxKH30i0937R5z211W9tRfdyt+6lk1V1Dowp?=
 =?us-ascii?Q?D+AJzqpHItKcZou9M82R0rmKCjwHxnybYWPFlljENL8ft7RfIoVufMzVWSJC?=
 =?us-ascii?Q?B7+padDZClK7ge5so/fxC45aI55HwZMM9mpIvjW0hktJRI+EeSswhCSWukAA?=
 =?us-ascii?Q?mRrE0KFHcb709KwM1Tggk0HZFXDnHZ/8bW94LMD3O0hCzxtFB6Ceb0Tmyp/h?=
 =?us-ascii?Q?MNwqTl1ykSwHnJBvh+r7ROXHuwtcCxk/I8HVclr0R83GaZp978aVKb9zDCiP?=
 =?us-ascii?Q?Pb7JyTUofdWuiU5uWv4WQTA87aup8c90L46fb2jsex8IL27eiCXNBxZgfG8Y?=
 =?us-ascii?Q?50dtruqXLmclW/gwdKetYPe4uWFY+d4uUisVALOj06AzgtqDSBxP28NNJfSO?=
 =?us-ascii?Q?+0X+NhMmXoI/G9o0SQSPMnwFH87FMLUpfdd8nnEbAIjM8kNNrAHpthrjAW3O?=
 =?us-ascii?Q?bGX1WfNtW8BqA9bXtWiZjInKOGMVVaszBb81xJft9YwgW50Ub8O9sZI9bXZn?=
 =?us-ascii?Q?DRJNFhbifFPv9x5Vne9M76glsHR7U4DjOs9s3STdeP5Uz9c7M51bzo5FZdls?=
 =?us-ascii?Q?FqAgDH3CGEeYCO5StmqRH45wPo8HtdFDgDIMFHPyLRR3EvtNcs5gfGPVl++N?=
 =?us-ascii?Q?g1rVv+xHo9gTCE61CzFMhxJrEsTtot9ZsYbKrLAAbfUtjyXUP2pCCzou06y8?=
 =?us-ascii?Q?PjHNIPgNIyWE0vfHHpFaoFiZctCgf8r5vMrJE+Zjoeb8MzfPQh5GeSK5PBzt?=
 =?us-ascii?Q?6P5vrT2FBYlAhQEkVAZhg0gslcGqfwKs/ZY1W0V3m3qRbwpgXKtyvY3OG5u9?=
 =?us-ascii?Q?gbnmy1CzDL0WHEnAi+XKFRkUjPLJqmn3SRwc2bodJ+RJT/GC3nZ8GD8WZeRX?=
 =?us-ascii?Q?Heocu2XKI0AA+StAOl2EpXH4nqldh9/cYT9ShFX5ZjOTExr8eeoVcbSLD6oT?=
 =?us-ascii?Q?AusWN0zoKemP0qwfB8QtG+Yx4UlBfHLRFr9pmg9zo48b1UmpfyIuIgPR7EDy?=
 =?us-ascii?Q?IpvdQsxZny8AqRdRjS8ot9equ8paGN0iagwqBzayXRWsY8sORzvBbAJLVqJj?=
 =?us-ascii?Q?8VDPZJChtEBb3UWVupf8u/TN30xx4RjJ1pYuu7v4vdzw7Gy25uqZppvMIEsF?=
 =?us-ascii?Q?7cR31gCVBFLvQ6CHKf+cSn30h6itxRunKsS+DRB5BMRECsivm3BcYfy5w/fu?=
 =?us-ascii?Q?y6sO9ck7BLc1gFmn2SilECvojM91sFhCZ0TQjhYEstHuYBy18lzxdqDrCxI3?=
 =?us-ascii?Q?DzJ1UqLmFm5Wjz/ZTKbXjb6l78nHIx6iaP6eSK3YqzRW6ffCl7+b0CJ5hrJR?=
 =?us-ascii?Q?haUVP2TFxqlT8u3EWRcmVupK+1BrkwLmk2f/31qzVpxJ74F4k9NBxCoS7eQv?=
 =?us-ascii?Q?F2Efq1MEDybVJH40bQ1kUGvELAObLzPDyay1/LlW3OYkkBTMTFUnHHjpQqpY?=
 =?us-ascii?Q?JOzJnS8eJ3Loq/0vdfDVSrA1GVDNu/piyou5xNH+25zFmReEht31ujvaW55K?=
 =?us-ascii?Q?YDvpLb7SaIjc+vzBzQ/o3XPMIwSVtzbMD+Rk4PLN9FTwpzc7EhvX6hvg4+ye?=
 =?us-ascii?Q?uNwlkbZYd3+jJzZ1el7DAzeiBOJMdpvon4YpEI7h8dra697yN2J9FjqRMmWx?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Wsup9jikVXGUWXZja461HjekgQ1MKQsh9QoMMU1zwj5BTOc6Mcf+n7J96zwVx/h1NEf3kseet+hP4s7Y4X2+SVJCiBTsIsNl77jTRLvfLZzPdfwdtmB1h8yn8wDlvckBzTg1FQsvYcNpy4qcJPNhXj4DFzlq9yiEHisPPPKbv0Yfc0bk2Fj+43Dh3WednjlfOadJ6OqLALajtXcscHj51Bc8inFhyNQFQqAZbzKWN6d9BzHZ4Z3rdKeSR+WfXRLGSLbHr6cb33ZneI7zbG4fL0sqPzeMuVX9nNv5h9ReesglSJs48wRvcIL7EsCOIQkngb2ZGG7c3uMr2cBMdY7ZU05Yzt6FlVFVPEz1COf4gFwDJXVB1PrJNSsRlroodFwQ0xiXr+DW/1o1gkUYSRnHlbwt4JdPehIN4u2wQlSXWNwYbFAJawctA0O/j2gyLta1cE4uWp2/KKL58TCypThMQPxG5gejmw2kIq3tT7uilqpu8b2kIBaq/cmNgstexESU0//C3XInZUk2Gima0z4rm/T3AYPeFePInzwbzDCyF+6hR662fbFczVg3sust54beYPtToTqGLKIQtai6s6yhTElcB32BanYPk3bgybEWS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75e93d0e-45d9-43bc-3829-08ddd91c43e4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 21:15:58.0579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7lMdrXMe4UGAL+VDU10va52yEGwNJCwJRXnHBuh9/DU5qhDh4d49xkS23/BU/fpydEBrp7E4Fmq7v56krdXOFe8hv0TmxyHx4lxbTexUMwY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_04,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110148
X-Proofpoint-ORIG-GUID: 6NF_QEQZFm-FxiWrZ10KEiKvvGh6Ud8b
X-Authority-Analysis: v=2.4 cv=WecMa1hX c=1 sm=1 tr=0 ts=689a5d93 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=F7pr0ZEwmyNLea-96LMA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12070
X-Proofpoint-GUID: 6NF_QEQZFm-FxiWrZ10KEiKvvGh6Ud8b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE0OSBTYWx0ZWRfXwu0xBAnUDWts
 C9rJvGkllgCK2hFrPO81NwkjOzFwRxNYy8rufjwLqcJQ9VSMTyHc3hs9hOAmO0/FN/6p9TIqjTd
 JICHzlep7U+AjIMJCnw+9YUrqp9hNcV18nOvnXaAUISMc8dNDGuAz/WCD6Tty4FqeexAA8S4WEn
 9JRmQt6c4YfblERvWqd7TnlQBVwN1y+UTihd0fL7Az5LueZQ3V/1Vs299sPouUVsqq12QqqxZgJ
 hZkcIkU1BGyi5EgjDDGc+zt4E6PePUPZ0Fjk0ULy4tRKRQKn13AZ1w0S2Hk/bcQOqAHKYUw/irA
 457YQ1a3G4gJyRVaDc0fxxfnw86WtPWO/wMcVv1wuOcokDg3eHPaZg+D9/tCvjyn4Oqb08jdEXR
 hMgbHZ8UgmK1ic5brSwZloD/NGSy4pkEjdf2Iw/7VxAO9Em2OYW+eVzOCCdTRMeiExcp++vG


[ Added Rafael, Daniel. ]

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Thu, Jun 26, 2025 at 09:48:01PM -0700, Ankur Arora wrote:
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..d33c2701c9ee 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,101 @@ do {									\
>>  })
>>  #endif
>>
>> +#ifndef SMP_TIMEWAIT_SPIN_BASE
>> +#define SMP_TIMEWAIT_SPIN_BASE		16
>> +#endif
>> +
>> +/*
>> + * Policy handler that adjusts the number of times we spin or
>> + * wait for cacheline to change before evaluating the time-expr.
>> + *
>> + * The generic version only supports spinning.
>> + */
>> +static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
>> +				       u32 *spin, bool *wait, u64 slack)
>> +{
>> +	if (now >= end)
>> +		return 0;
>> +
>> +	*spin = SMP_TIMEWAIT_SPIN_BASE;
>> +	*wait = false;
>> +	return now;
>> +}
>> +
>> +#ifndef __smp_cond_policy
>> +#define __smp_cond_policy ___smp_cond_spinwait
>> +#endif
>> +
>> +/*
>> + * Non-spin primitive that allows waiting for stores to an address,
>> + * with support for a timeout. This works in conjunction with an
>> + * architecturally defined policy.
>> + */
>> +#ifndef __smp_timewait_store
>> +#define __smp_timewait_store(ptr, val)	do { } while (0)
>> +#endif
>> +
>> +#ifndef __smp_cond_load_relaxed_timewait
>> +#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,	\
>> +					 time_expr, time_end,		\
>> +					 slack) ({			\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;			\
>> +	u64 __prev = 0, __end = (time_end);				\
>> +	u64 __slack = slack;						\
>> +	bool __wait = false;						\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (++__n < __spin)					\
>> +			continue;					\
>> +		if (!(__prev = policy((time_expr), __prev, __end,	\
>> +					  &__spin, &__wait, __slack)))	\
>> +			break;						\
>> +		if (__wait)						\
>> +			__smp_timewait_store(__PTR, VAL);		\
>> +		__n = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +#endif
>
> TBH, this still looks over-engineered to me, especially with the second
> patch trying to reduce the spin loops based on the remaining time. Does
> any of the current users of this interface need it to get more precise?

No, neither of rqspinlock nor poll_idle() really care about precision.
And, the slack even in this series is only useful for the waiting
implementation.

> Also I feel the spinning added to poll_idle() is more of an architecture
> choice as some CPUs could not cope with local_clock() being called too
> frequently.

Just on the frequency point -- I think it might be a more general
problem that just on specific architectures.

Architectures with GENERIC_SCHED_CLOCK could use a multitude of
clocksources and from a quick look some of them do iomem reads.
(AFAICT GENERIC_SCHED_CLOCK could also be selected by the clocksource
itself, so an architecture header might not need to be an arch choice
at  all.)

Even for something like x86 which doesn't use GENERIC_SCHED_CLOCK,
we might be using tsc or jiffies or paravirt-clock all of which would
have very different performance characteristics. Or, just using a
clock more expensive than local_clock(); rqspinlock uses
ktime_get_mono_fast_ns().

So, I feel we do need a generic rate limiter.

> The above generic implementation takes a spin into
> consideration even if an arch implementation doesn't need it (e.g. WFET
> or WFE). Yes, the arch policy could set a spin of 0 but it feels overly
> complicated for the generic implementation.

Agree with the last point. My thought was that it might be okay to always
optimistically spin a little, just because WFE*/MWAITX etc might (?)
have a entry/exit cost even when the wakeup is immediate.

Though the code is wrong in that it always waits right after evaluating
the policy. I should have done something like this instead:

+#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, policy,       \
+                                        time_expr, time_end,           \
+                                        slack) ({                      \
+       typeof(ptr) __PTR = (ptr);                                      \
+       __unqual_scalar_typeof(*ptr) VAL;                               \
+       u32 __n = 0, __spin = SMP_TIMEWAIT_SPIN_BASE;                   \
+       u64 __prev = 0, __end = (time_end);                             \
+       u64 __slack = slack;                                            \
+       bool __wait = false;                                            \
+                                                                       \
+       for (;;) {                                                      \
+               VAL = READ_ONCE(*__PTR);                                \
+               if (cond_expr)                                          \
+                       break;                                          \
+               cpu_relax();                                            \
+               if (++__n < __spin)                                     \
+                       continue;                                       \
+               if (__wait)                                             \
+                       __smp_timewait_store(__PTR, VAL);               \
+               if (!(__prev = policy((time_expr), __prev, __end,       \
+                                         &__spin, &__wait, __slack)))  \
+                       break;                                          \
+               __n = 0;                                                \
+       }                                                               \
+       (typeof(*ptr))VAL;                                              \
+})


> Can we instead have the generic implementation without any spinning?
> Just polling a variable with cpu_relax() like
> smp_cond_load_acquire/relaxed() with the additional check for time. We
> redefine it in the arch code.
>
>> +#define __check_time_types(type, a, b)			\
>> +		(__same_type(typeof(a), type) &&	\
>> +		 __same_type(typeof(b), type))
>> +
>> +/**
>> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on
>> + * @cond: boolean expression to wait for
>> + * @time_expr: monotonic expression that evaluates to the current time
>> + * @time_end: end time, compared against time_expr
>> + * @slack: how much timer overshoot can the caller tolerate?
>> + * Useful for when we go into wait states. A value of 0 indicates a high
>> + * tolerance.
>> + *
>> + * Note that all times (time_expr, time_end, and slack) are in microseconds,
>> + * with no mandated precision.
>> + *
>> + * Equivalent to using READ_ONCE() on the condition variable.
>> + */
>> +#define smp_cond_load_relaxed_timewait(ptr, cond_expr, time_expr,	\
>> +				       time_end, slack) ({		\
>> +	__unqual_scalar_typeof(*ptr) _val;				\
>> +	BUILD_BUG_ON_MSG(!__check_time_types(u64, time_expr, time_end),	\
>> +			 "incompatible time units");			\
>> +	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
>> +						__smp_cond_policy,	\
>> +						time_expr, time_end,	\
>> +						slack);			\
>> +	(typeof(*ptr))_val;						\
>> +})
>
> Looking at the current user of the acquire variant - rqspinlock, it does
> not even bother with a time_expr but rather added the time condition to
> cond_expr. I don't think it has any "slack" requirements, only that
> there's no deadlock eventually.

So, that code only uses smp_cond_load_*_timewait() on arm64. Everywhere
else it just uses smp_cond_load_acquire() and because it jams both
of these interfaces together, it doesn't really use time_expr.

But, it needs more extensive rework so all platforms can use
__smp_cond_load_acquire_timewait with the deadlock check folded
inside its own policy handler.

Anyway let me detail that in my reply to your other mail.

> About poll_idle(), are there any slack requirement or we get away
> without?

I don't believe there are any slack requirements. Definitely not for
rqspinlock (given that it has a large timeout) and I believe also
not for poll_idle() since a timeout delay only leads to a slightly
delayed deeper sleep.

Question for Rafael, Daniel: With smp_cond_load_relaxed_timewait(), when
used in waiting mode instead of via the usual cpu_relax() spin, we
could overshoot by an architecturally defined granularity.
On arm64, that could be ~100us in the worst case. Do we have hard
requirements about timer overshoot in poll_idle()?

> I think we have two ways forward (well, at least):
>
> 1. Clearly define what time_end is and we won't need a time_expr at all.
>    This may work for poll_idle(), not sure about rqspinlock. The
>    advantage is that we can drop the 'slack' argument since none of the
>    current users seem to need it. The downside is that we need to know
>    exactly what this time_end is to convert it to timer cycles for a
>    WFET implementation on arm64.
>
> 2. Drop time_end and only leave time_expr as a bool (we don't care
>    whether it uses ns, jiffies or whatever underneath, it's just a
>    bool). In this case, we could use a 'slack' argument mostly to make a
>    decision on whether we use WFET, WFE or just polling with
>    cpu_relax(). For WFET, the wait time would be based on the slack
>    value rather than some absolute end time which we won't have.
>
> I'd go with (2), it looks simpler. Maybe even drop the 'slack' argument
> for the time being until we have a clear user. The fallback on arm64
> would be from wfe (if event streaming available), wfet with the same
> period as the event stream (in the absence of a slack argument) or
> cpu_relax().

So I like the approach with (2) quite a bit. It'll simplify the time
handling quite nicely. And, I think it is also good to drop slack
unless there's a use for it.

There's just one problem, which is that a notion of time-remaining
still seems quite important to me. Without it, it's difficult to know
how often to do the time-check etc. I could use an arbitrary
parameter, say evaluate time_expr once every N cpu_relax() loops etc
but that seems worse than the current approach.

So, how about replacing the bool time_expr, with a time_remaining_expr
(s32) which evaluates to a fixed time unit (ns).

This also gives the WFET a clear end time (though it would still need
to be converted to timer cycles) but the WFE path could stay simple
by allowing an overshoot instead of falling back to polling.

--
ankur

