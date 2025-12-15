Return-Path: <linux-arch+bounces-15399-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E789CBC820
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36F393029B88
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6731ED61;
	Mon, 15 Dec 2025 04:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UD8Y29Oy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YZhbjE9D"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0C93126A4;
	Mon, 15 Dec 2025 04:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774284; cv=fail; b=sF9+vFF3x6L5WJEhoLsUpoJjllCjXO7DgVvDPRj7m22YEYCRc6gX5BdSIFl1ZctW6jLDWMLOUGrdoVSolI0bcgC5DKANJGoAAfjMA8GOuQCgFMD9CQROSdn/WOWEuKVHrbZBhRtgKDn+z7GrZmoRdPv70tSP3+Iypav80mlu8xk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774284; c=relaxed/simple;
	bh=3AgLDID3FLGINSCYQDRnkoClQ2UMtuUPYCwozlsY6y8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e4JD/dZ9V1sC/AA9wJHXMhLAg5N5oP0nCI1abPw4Na8ZLpLhEMVWTVE5+nthPiRtXKW4mwZHGGM4R5zb1BViXy/yXgZ3WPPRaE46hobBHkVelDJ4+Yc0YrED8HcXxdIsqQ3UJ2y8AaNV68EoimJij4Azsi2nEv6kpLCtdp2RtMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UD8Y29Oy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YZhbjE9D; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF2lR1B1157217;
	Mon, 15 Dec 2025 04:49:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n4J5CHbkafKD6WlD1OTvX/XsE9RVBgaz5qrsYFBOOv8=; b=
	UD8Y29OyBsvQH0NepoDoh3iW1iNhYlc/WU0tcHImS5azE0kv2lGe9ua0RXSUC4sh
	SXhjniGtxFT95dVir+HxQDD4/1AGWvV9ILMJGRiYHDuOlPLa8X8Hmwps4/U8+iPO
	u6wLQhvAPL9q6pX8vF8aIMFul0tQn/32z8Hux6KiaM+/1G2vFtvv3REsF6sRehct
	4PBMlm2RKh+xlhJgH/vpSLTKGMb7LrsxSVbalBZjrPq2dRs8fJwU4Sl69TDGUSSV
	aZ2ybY8CDKU16hixXg2wvs0s/vlRwoOFpPBJIf8yq7nM3gy5KhvDfFq6VFq3IRIZ
	X3DiWrQPil0SbgwzMNGuZQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja1b5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF1gU9N025249;
	Mon, 15 Dec 2025 04:49:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011028.outbound.protection.outlook.com [40.107.208.28])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rda6-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UVHRg2Weh4AHdV+NHx8xCjQ8SX9JMQnu2vwpi5HkIdFcDhrzZ7HbA5rIlUbr6q3DcKoqJ1/7r0VzoMwuF39sDiJTZfy1GnXjiMfd/ryS9uXr61tqxsLMdU110Fw8rl+uUnPK8mMgwDb1WXCj7C90E9Inv4lCw3OL0JKSwbVUbxU+uKtlHh3LQrDN4lzYl7LNTDSnW6/6aVgoVsQ0PARNGG0C2dteebmSre33GEkLS7lYRdCtTNGn8j4D5Ie8Tspe9C9nyCYcnQj9iwgyuLpHpdyv9U+X/YAC0bbHDzLkYtskTfAmM3e2huMdC+5FudE6WzDR3e3ujZ8Y5aCwjsTPqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n4J5CHbkafKD6WlD1OTvX/XsE9RVBgaz5qrsYFBOOv8=;
 b=d1xhOiHyAvOC8GE6JEwWFP4A4PKjFEWlLEDbvZWmwg2drLunONt9eCgEglghApg9cDu4iZFXENKYpAt7FOWBYuXdMhX0AgFuME2Duz5m1RaHYWu0KdaZG1Xu8M9hT5rMXbA+G8DxlH5Hcs9eDhEYORKayDJeNxuBQrap1XK+pdmFH1sZwR4ahr6wGL3AdSJqWLMm5b2xeCRg+kolzZwHgp7BCjghrn02P00z7RP+umdf+viM7O2PsAvLmFulrw2kaAn8HtmzwEO4vKbOdJUHmn0A9dRuwJyG2DqNf7hNgihtzz8vVnSbRpEaAuMQdGZRdkPALEcG1Rvmuoh47yRcmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n4J5CHbkafKD6WlD1OTvX/XsE9RVBgaz5qrsYFBOOv8=;
 b=YZhbjE9DTnn9Bu6bVqd3OTIKmQUMTBp3OEiukXkHqiu3IYrWECKpy3ftFzPodVcTpPsgzRuzwbxhylxJ5H3Ohv9ae/z7QB/ikDwzJ71Nh4hV0POTlI/f7gaD83I74RNDlSEcoDB8KLKvBvxCowLEmdQMESQGfpR9iRWe1D80s1M=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:23 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:23 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>
Subject: [PATCH v8 02/12] arm64: barrier: Support smp_cond_load_relaxed_timeout()
Date: Sun, 14 Dec 2025 20:49:09 -0800
Message-Id: <20251215044919.460086-3-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0194.namprd03.prod.outlook.com
 (2603:10b6:303:b8::19) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 692469a1-2817-4f80-cf1e-08de3b95514a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V56pxNwROYfKRmFwUwJFagzoMlhZpUI9NieLrMSGVCCIRiMIV+S76OlaE5fk?=
 =?us-ascii?Q?ab8QGOS0FImaWSnqTMilOAukObWQaUdoaMuzUA2BswhekVm+A30nXAWDTqIT?=
 =?us-ascii?Q?/9y5AlDySBKsgp8n4gsaM9GGKG40su7+H4h6gljFq5WUilD4mdcvgIwentRB?=
 =?us-ascii?Q?u6tjvGMspo9Zbt1MndRzX+tJeHsjPRvuAuUBfJnqJ0eN4XfOo4WkNaKcthQ3?=
 =?us-ascii?Q?n1/UblP/fPe0czE4dNaZvIDLROZb7XphNOXXtZKwEX0VYSlVgiqvk9yuu8KH?=
 =?us-ascii?Q?El5u2BvyHYicQpxU0r6baYdK0zPLUjFXUk4LKyAmKPmeii8fG/g+hmr55GBI?=
 =?us-ascii?Q?FjRl+ZFLbFscBa6Jj4RCT0YBtLcsMr1GDLzknQbQ8B/O1xKJWX8a9n7CvX84?=
 =?us-ascii?Q?HX/NBHOR1S+xpX+o6+fzRthz8a+VpEm/WWwI2/hMvpNNOvWNaNEoH+jGUsfx?=
 =?us-ascii?Q?KGFDzsUgJdSBlntrkGh1D9bXya1CO7qcNwFe5JVgWTXUM4hPAGKjWC8DUgtF?=
 =?us-ascii?Q?TK+mo0hWo4X5FnT/0nGJYDiV1zWv1ACL1Ebpn2VY1tjAshftcYe4S8NHImuk?=
 =?us-ascii?Q?49DG6QJKsmcQdskIJmiAo4UXOxcTpyDmSY5D3+W1uYQ/8wsqoDu0yGs1rxwb?=
 =?us-ascii?Q?uOZsvq+ANOjP3Hc0RO53/I32dNAKhg5pJaEBa45auS1s7lFQmtsm1eXPAsBI?=
 =?us-ascii?Q?B+7gc1p6Ow+Q5+q+cJAzYt+IbIuQl1zR0wmM1xRMMUczB90P4MK8jwjXA2Ue?=
 =?us-ascii?Q?bl2fYik5w8aa+wcI4sM+v6goSeSCITLBsMhne02Lg5Og7imT0qkLuednQpFM?=
 =?us-ascii?Q?Lejqj5wsGQYt/z5xGpf42ibjCW8aGCAq/5ykCkVun/0is2qwcvAvR4hSLV0/?=
 =?us-ascii?Q?17Zx6S3vs1uMe7I6gaaXm4uJ0f0zacEB2MTGwqA5osVTG5YhDGh5xV6sSScc?=
 =?us-ascii?Q?kQAgtoGFXJzpl2fIKY9tQ6TJkJ0A/HQOj5RPbDMg1sR29GvTt9oHlStpavRh?=
 =?us-ascii?Q?rAXEGt8kptu9B5A1UcqCZbOnVMgOoM7TBEwaCHSGY7W634wL/gzwMObl9b1+?=
 =?us-ascii?Q?3F5kh6u++OYEOvmYjL6NqbaKRWepYdt4gcZiXkwneNuunxnKIYNUnMS61GqE?=
 =?us-ascii?Q?RV7oHNgCjnszwhmVXJ9Nk/M206cKGwfl7MF9KiaebovMWzoQWgVtaPT3ybnp?=
 =?us-ascii?Q?EPUX0hciXbY+cFiJylrkoPnc00McueS0td0frd+zXCqj67O4e79AryrKWfz4?=
 =?us-ascii?Q?mlhlXYpjLTJfTSuSLf7uuVMI+50l7FEqPlG07STXmyPK68PbU9d5bMFYoOBx?=
 =?us-ascii?Q?utFwKXdc/+sbStqcvce10C/kBDHZlwZpxQ61SS64nyuv27kaErERbiXujO3+?=
 =?us-ascii?Q?xOdZdIB6fPLQFu312d0O4EnYf+3zCFk63W9qsx9LUuQa3byhlAW9MvnhIgnN?=
 =?us-ascii?Q?XeyQ87/FXrFqxIwr8aKYNsrjolRG9ey+?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5nThyz0EESnR+5iv+dNJLzoRpqOOfdjkLd9jzzvIWrRJ3qQk9dpPdfIOJdkL?=
 =?us-ascii?Q?Jk6wqd9+3TMz1Xy+nrLH6R+rk4sVjkxUDlABlOFEqn3Xjy9E5HEhjwKY22wT?=
 =?us-ascii?Q?WQSSvwNyDy/MBv9g9OXkN8AD4DGBMHU+7XLuxYUrRluUtrmvB2hQVv3d0G+d?=
 =?us-ascii?Q?RRb7WwFk4qK2W8mvxDKl/4T/Y6kYq37LadExnoIYvcc6Ne2H5/rYIvBdEvWb?=
 =?us-ascii?Q?MajaueZipVENOwer0j8eTiJ6mQmVIwBosFUPv2yqLYHFRi0438gwj2sxpe2l?=
 =?us-ascii?Q?jHRruEIrKXZLquYBzSud+ftQ+oOMRsgPBfrRkcCPYMzb6G0sINZ29SKygAN3?=
 =?us-ascii?Q?O0Nz6bqJY1Mh1glpIyRyOs45rvHis4X2vD7AevYmMOF885z8j4+FqdzKEGTk?=
 =?us-ascii?Q?t8dFpJmmVQf2SplHHt6E1aYfWan6Qg+4kAQ2+XA2Hwx/W4CP4IyMWYLWfkoh?=
 =?us-ascii?Q?QS44NGzXcq5l2UKjnuSdfDwm0X+HLlCtdTuG5MwgCGfAviQ+NQOfSN6OWZ+F?=
 =?us-ascii?Q?c7R/XGfeFx/UWOzRAigeo5G9C/x3iA0jJAPzd6daNtv1FznD5zc9uG1L7huI?=
 =?us-ascii?Q?gSyMr0Klc0r6LUQoJsjuRbLkAMbPd15w6Ue1G5/icf0IVCNUQbBskyEUpfvJ?=
 =?us-ascii?Q?sUQUXnej75OKjU+Ct/DRujcEostBFGHmJn0zWjCJDFWye/+uR4l0Fh66kE0h?=
 =?us-ascii?Q?q0FgdH15U2ZRKLnx/nLA+Sfc2WZvCbpztYjdXIYhpyUUfur+Qd2WjJVdHNBD?=
 =?us-ascii?Q?HFuEFjhl0pf3WGyVhd68SpDSXQGuKWufgVxgZsb0bOVcFBVgV9Ic0QeQVrQM?=
 =?us-ascii?Q?wQEbu+0ssPTjEFnEAxhYyEOGC81OzT/xoQOyesg+TGPkFc99R2h+z2BOekXu?=
 =?us-ascii?Q?lJX6ThacwMNVoTHy/viv5teeKj+vbCA5jmsXh1Sz+pOU6LYhCNma8RoXIM5o?=
 =?us-ascii?Q?Ieca823zha6GXQ/NoFRmIQfb1osMQD/vWEUQGUGQCpaJELhAXlEQCQeSdS/9?=
 =?us-ascii?Q?atSWsvuLg5PLhaJ1fkCc/JsyjFh7wKIqgvo1PHVkLx4VrT3t1oxZNg+wU7VT?=
 =?us-ascii?Q?BA1m9X2RFG2o5FiXpGr6dUdVdKufLoHzWdw2AJxdyGoPozMj2/SQQoWEhx61?=
 =?us-ascii?Q?uCDbgsWiuJIzN/85rp0qezvMKT0YoyDfzE398sPqVtv8ds1WYZENt6tHZYBm?=
 =?us-ascii?Q?zgMakUGptT6AumQob9+lO3MGaM008YOjAJqdJBwbBZU9GEkjA6pw5ogwAN/n?=
 =?us-ascii?Q?5TDk/G8RiZOnssfXR4okcJpas+xF/S6U+uhmD1K2/wvFt2LLyensIfOvTSB2?=
 =?us-ascii?Q?LD7X+stCweXzAQaeK7yNdMwYMWgpAa8przq5IEu0d9Iqf12XgjILYk2SFdDq?=
 =?us-ascii?Q?xJiH5W6Yo32L2aOWV6ft7as4xBxfUMzDvy0RWmOcLAEFm8Jeg7ym9bYRKDsw?=
 =?us-ascii?Q?0CTokx4vHria35qVbBZ6dDTTU1HNgV3sRNTDZVYdnbxl2WbZ8guedTLpQl6O?=
 =?us-ascii?Q?5j1Pju89ypiAoqSebqtiySfEGAMusPHA9MBtT0TnyCLg+HomDpFPRMR33BMD?=
 =?us-ascii?Q?5KWEEIATVp+drXipvfJwZ7k8CJPYEGmK3+X2QsRRC05l5MHKQxgjWDXGQyJo?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JIaHHhfUyAdPQpamxIidE34YLHNHlJtaqgJuCe8bGZGKXDrdQX5nvfRFw1NeuX/C5Od4GbMBZnhRhoBKb2YldIv1cfvCTGC3QbyyQOVDSTB94iy4Z2ebzeBO8lxONOJGGybYk4U8VIAQQJC9gHv/UWpsoIJEojivkG+oinVyILqDBXwvPMPv4pcxg4XT+jgsqOXmoEMqdSAM6Jsc0tV31kp4ptFzNDXtUQ5et0GJdXIMvWXbsi0Y/DbDQjIBToRcQAsfkBuXOojQNpt0lt7NwarcKo+JLjK486G7U56w7gCu5RgB9WssoJvUeLdbphh/hCtkmn7JswKU3kWNlvE+8sLKq2X0ICtPx2ueWCdEGDvIh7JmzAIIP6mtXNnmFwtbpeprBjuX5z+56PtM0jh94OMyqIxQuprzf1x/zoZxTxuTGJ6V5SpGPoPXnMEwFdxwW/PT33Wq85m9/z7B58rQzMseVl7nmeBGwoHyt8eGuyhGN9cQl7pNd03FQCxxTJJNpAwD+JWxLN/w4TBvYbyikmG1dAsqm2PFweoPFOn7rUYxS91p9HSKuFqlWNUIxO5S+MO+E2yXJqRG/3MgFVh+B6Zx/2+6GCqOZxC7ZvIfkbY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 692469a1-2817-4f80-cf1e-08de3b95514a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:23.4568
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dIEg35Zfas2HLb/Cmc4IAby/VG2T0f+bIkaJDhVSGbVdhp8k9cTCVl3JR2wl3PH/A/xKWJ9SQ5yWI4P17nHwNTBy129xjGATvRw7/veaFbM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=834 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=693f9356 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=C9KTRrY6tsI4kfzUhbwA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfXzNpQhCfsWRUr
 WtjjWOrgaQhcRwxg92ZwRIvfxoEq+eXgc3yu95jMN1IYQ8BX7iCPUhhKovHENUfQUk1GOH/7XXj
 qQSrE9edZ16EalH0kLlFLJQGYvixKHlC+9JphPELZVMTAXzltGX6CLM9qMkM5xml99wOtBMwF0x
 9hAlH9ix2YLMsokL96WAOBhHfWhS52V7OD53CgiuHf9muwGP/qd2H76zLqXbn/lpKjqJAfUe3lc
 NihAYVyu6E0cnnyg41YPIcVIpEGVoUFR7+W49nKFfJhIav13mdzmriabZvRUFJ/uWVz3K8mAjem
 e+UG+qGQTUPGC0HnT4NPAUjWQ6CBwv7/rMzoXfOxUpwlN6MnLVuJ/J+vPO1op/MXTa3flGnHKdg
 UCH1eqkUFyQREawxufYI0IhJ+0wVYg==
X-Proofpoint-ORIG-GUID: BufA6kXQ9VeEzNJclsScW2Qe7R5iuXGw
X-Proofpoint-GUID: BufA6kXQ9VeEzNJclsScW2Qe7R5iuXGw

Support waiting in smp_cond_load_relaxed_timeout() via
__cmpwait_relaxed(). To ensure that we wake from waiting in
WFE periodically and don't block forever if there are no stores
to ptr, this path is only used when the event-stream is enabled.

Note that when using __cmpwait_relaxed() we ignore the timeout
value, allowing an overshoot by upto the event-stream period.
And, in the unlikely event that the event-stream is unavailable,
fallback to spin-waiting.

Also set SMP_TIMEOUT_POLL_COUNT to 1 so we do the time-check in
each iteration of smp_cond_load_relaxed_timeout().

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---

Notes:
   - cpu_poll_relax() now takes an additional parameter.

   - added a comment detailing why we define SMP_TIMEOUT_POLL_COUNT=1 and
     how it ties up with smp_cond_load_relaxed_timeout().

   - explicitly include <asm/vdso/processor.h> for cpu_relax().

 arch/arm64/include/asm/barrier.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 9495c4441a46..6190e178db51 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -12,6 +12,7 @@
 #include <linux/kasan-checks.h>
 
 #include <asm/alternative-macros.h>
+#include <asm/vdso/processor.h>
 
 #define __nops(n)	".rept	" #n "\nnop\n.endr\n"
 #define nops(n)		asm volatile(__nops(n))
@@ -219,6 +220,26 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/* Re-declared here to avoid include dependency. */
+extern bool arch_timer_evtstrm_available(void);
+
+/*
+ * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
+ * for the ptr value to change.
+ *
+ * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
+ * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
+ * time-check in each iteration.
+ */
+#define SMP_TIMEOUT_POLL_COUNT	1
+
+#define cpu_poll_relax(ptr, val, timeout_ns) do {			\
+	if (arch_timer_evtstrm_available())				\
+		__cmpwait_relaxed(ptr, val);				\
+	else								\
+		cpu_relax();						\
+} while (0)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLER__ */
-- 
2.31.1


