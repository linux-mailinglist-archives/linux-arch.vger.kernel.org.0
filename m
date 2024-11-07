Return-Path: <linux-arch+bounces-8900-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82339C0E81
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:11:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB91A1C20B51
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88CA1218D89;
	Thu,  7 Nov 2024 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kwBb4JhA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GR1K+NBa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E90218584;
	Thu,  7 Nov 2024 19:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006565; cv=fail; b=itANnSaj8InbV+cFoz59kej6PeLR+pUSkGpvIaoTE3dkmvOyRmvfgGzd8sUPiL6LS7jGn/zD3676jr0Xipu9ZMX5BYO7cvi+ZWI0wjftczpCOYxY1UMgEvDRBgkX93DLYLTPBBU9ahQIdTCevmuLI0p6Ui6x5WQ8mR78FeG31Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006565; c=relaxed/simple;
	bh=fIkKve3d4s+tARoLQIvmf1GpLWbBKq2gD7ZxonS0CvU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iP2qsJ6cdg3XaEc/deL4ZkkYa/VwWI4SZx4LhMIuwHbUiCB34v50jhN3MTy1VfXP5MZFYqtDI8DpOaZnqbpsgCP5W0sW0HcA6PflypO+kgfcwuFerB4crToVwz0dmuVmnqqwfzKgoZQAUKLuDFmPkvscoGinR+A1kmtCStAuJUA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kwBb4JhA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GR1K+NBa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBfNe030873;
	Thu, 7 Nov 2024 19:08:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OsL8KmZV0GZqBzyYAkuNNp3MGpfw0D7lahQORSbuV9E=; b=
	kwBb4JhA8GvsC1H+/U3RBBE6mfigdBt8L0XlPfiClTNf2Qm1j8w9RyjM63xj1wRh
	d6IRmSVp5JPXxiAdATaded9E1GIN1o0SYxVRbq/XCD+IRgTk/0+Ki95qIHRlwXrl
	GIeQ/XzBOu/fDvHbsz3xLNeMOoiq9xuV8xTlCET0twotUXEI7HoxdE+LOUL0JTgO
	Qcwkg3DNrc7uDVTW0/Gw51WSSZHyExAyMP+3naKaT6Snikz0c6frB3egjxHLwXvK
	gdHsf8cdubvgOp0rT9nsdL/Nn3qPEjt80VEETTZHX+rcCP9DyxfhGZVlCxrslmy3
	vZ9bbYCZ2Nk1FgyBDvyS8A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nb0ckd8p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:55 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7IeIrq008595;
	Thu, 7 Nov 2024 19:08:55 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahaer6a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mrR8MBaYID4DHRAxpIkdHtygrLcxjyPc/Zltc7O9XiGRsGp9e9NEyx+4zBTz3LQeBRzdn7u/EGP1/512lRQFR9d22pDy4pK/GH0hiwtn2cwVtMqdKdqTlR8+OQDdh/bqjjyoPh3PO/HbvqzBmCzUVFBJubqoM6Doa/QX0hJUk1rUjexF00SfQWUOwtIE1JY24HJL3Na6TVVfgaYK3dbf1GR0eEUNmBYYjwFBa/JlZuHXeBg377IqqJ+wAoK/CUHVuqlA+QuxpVp9E0JmiPvvNIOC3hZiJ0wXavRXGpR0mEXziwR7On5J2Nx4oJ1KNI31YTJDlhX6tuMM8lPsB+I8Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OsL8KmZV0GZqBzyYAkuNNp3MGpfw0D7lahQORSbuV9E=;
 b=qgu8cuHQfECiZrUDGxcy+U+Lkd4m2V6Y6CapChwPHyi3dfsF17+XmIt+3WErsolG37mMZ+DCTl8ukA3RGQm2VTq9sy37HmWSQyZ9YPaRXCmzavmbfSdzzNNc5mOfui0+b77cNk7OJIziV0EzxCQsBadC8u6qF1d7CwpyfoGkP+rE6JBwbX+L4uYJkYC9lRZK4B7yHJTFgUy75ATQqUbwUX2UllY8BxprKtt3kJKKdSp6By7eh8/ibztpireWblJKo6Srmc0auaxSMq0Vs7hX0sphLRhj95KNjQNSOtkpv+zMvBPOxom0CRAXVkyWjltE66zwrSjW9P7gq2bcEMZEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OsL8KmZV0GZqBzyYAkuNNp3MGpfw0D7lahQORSbuV9E=;
 b=GR1K+NBauDmKgSycHvWOQ7h1ncvsw6u0a5ku8Ut7imPlxjxtaAuSb8X+Cx7M56SNElIYmnOIny6Rn0ZbFeIcbv/JzZ1vNipA5/njS/9CwRKiFXnuAmkNqTvfiApID8VGWQbCbz5HNLTdyKqxNBb3S34o9YvqvoD5jvJpm9KZB1s=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:47 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:47 +0000
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
Subject: [PATCH v9 09/15] cpuidle-haltpoll: define arch_haltpoll_want()
Date: Thu,  7 Nov 2024 11:08:12 -0800
Message-Id: <20241107190818.522639-10-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0119.namprd04.prod.outlook.com
 (2603:10b6:303:83::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d18dd9-c2b4-40fa-46ef-08dcff5f9b5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9weBdsu/RSPJPCIw79WjHRb0Nd/RJJ2uG1qMjljYoQ8WDv0a8uEQ+KicJb2V?=
 =?us-ascii?Q?bpXxhuy+nYhlUSYvzf5t7j2T1vOwFHP3Sjn9xkzY2kNNyW+eYNdYgK8Ojncs?=
 =?us-ascii?Q?dTLwnp25uPHb+BFLtHvrCF8vRRoFPuZUvKmUgxcVXbWojI/fBsXHNSGehY5i?=
 =?us-ascii?Q?iz1o/GO9E6FqIzhPfU46QR/20wJm0svOSihA0U9QNn5IHgNQzb0Mvl7qGDFt?=
 =?us-ascii?Q?qXfFNjQjNIEvGZqc2jv/p1+tPvlplX26Oa12jqVBAEv/+bRUJ+lOwzq4hWwb?=
 =?us-ascii?Q?UgJumYzsU83/uDng5UDr+B6LHpEEh2lVy6jlkxp+uDvvrBTkNuJREQdGWRTn?=
 =?us-ascii?Q?CB0Nk69VWwECOgElX0GUisf74lPkd3PA02g22ectVAh/lW0xjL+V/J55Ccjw?=
 =?us-ascii?Q?Wc81PpLicgToGxuqhk0jOEZqzH1os59mW+6QP/9YR+ZugTVAXmhAgQayI5z9?=
 =?us-ascii?Q?qjSRt8yg4fantO4MgmAVmB2szU8cRmWm85dVY6LtzKb+tBAkj2ZRgAKqX1mX?=
 =?us-ascii?Q?sMKl5h1nejika0kCEJodGsdarN0CJKucPSxXiN6qetTEq4bdsRAXPSm8h4ZR?=
 =?us-ascii?Q?QK3IC69NIY+eG9OF/yygucHaHD+LgFc2JGT4scdg8hwWA1icV3E50dj0MIkE?=
 =?us-ascii?Q?C5h6sPFgbLDxKm0SGDFfVu+qTJx1IQHe6/5TY4/TY4jbTBkgDgrFq1ZhSjnK?=
 =?us-ascii?Q?fd2FuHM5utM9UA4/F4wsUXaoO6VR0MhUH0/zcGGNEJDgvWZW8Sbin/C+txeL?=
 =?us-ascii?Q?EdFDS07+b7OUG2bs3p8bhaHEJKSRbrPbYk6HzES51JGXQ6z3joR0UEnySmla?=
 =?us-ascii?Q?iTMy09Xjwh3YZYwfSl7qnV7libdC9gHnT+QO/TMiF8FIGlGlQSCwraxzEEWD?=
 =?us-ascii?Q?jb7JuXp4Z2xNzxlPY/LeEyJCvMOZ1v1+rkBMY5LvIPOPpw5RSDLTIryj1Gf6?=
 =?us-ascii?Q?vDYsxg+Bu6eosj+oDqdxuJNF1DMJ6yeBNaXXVJN7QpeVxnAz2KLMG9iftYbw?=
 =?us-ascii?Q?NJ7wt+Rybf1We7CHQM0EoSnQefNEjWkRYXKm12aZLQ+M+Kf+wHjMY8btmIv/?=
 =?us-ascii?Q?FjqGJN+5eZvZOGZr6fetPGhs5Ioe0Y/yK4W8Y2QNrU5E58VhhefTVa1pEPiL?=
 =?us-ascii?Q?77I7NBfrw53zAfX8Y3i/wGSFN8zwSg8MFfyNEhDui8T8BGScZ5GnV0S5tzGP?=
 =?us-ascii?Q?LeHRuaTjhJpl/RV3h+dcGhqVhCqpD/XSRG6L4TRvo7XwbnmtVkjrWUt9H1E3?=
 =?us-ascii?Q?vZiVqBUzubU+F+du3UyV7FzkqoKWmZNJjYapBP5wwQVPJrD/PYG/03UOvd9z?=
 =?us-ascii?Q?EStkyOHKe32Lguyy/OZ99Vvy?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EkpEPTkH4eotBmxx0YGb/vWvzQdNITKPA74meeUZmdgQ8YJfxteBoU9QbG/5?=
 =?us-ascii?Q?FJse/Eifq3tEozNoRjpPhWwvolwgbeFNDB7wzawjH45r8AVsbpoNIauJtGFs?=
 =?us-ascii?Q?KDZAEdSOHdVP9S5Ovg2pZDxWz+v/12XdbSjv8lL2j0FVMzKHJpLAZoockkrn?=
 =?us-ascii?Q?GmwFXL3CVbAjJ2Bs9gL8oeFfW8M+sw+kI+yzrAkDfVlIL4NDwBeZH6OfyWV7?=
 =?us-ascii?Q?Dp6sbrtttbUPXyOhW4O6DXnhJcnvYLUPwvJQtDx/rqHM7rUDAHeTiJXVsR/M?=
 =?us-ascii?Q?gSXxuVTYrLTyUT5i2JPby+wDTUHUHOEKj9Je5BFxZeVGkxG4hg/7POFLu97q?=
 =?us-ascii?Q?7eYvf4oz4nWvBpApMcGo4IySyn8V6BJkuLIO7xwS6sQcZH88/LxQTXBH4gNw?=
 =?us-ascii?Q?dzxqVFBG1VN+5H1+eYWWSIMFuNLi6psutQLmj5uAzZbrMATFcnAZJGJ3oi7B?=
 =?us-ascii?Q?A9H67RhjW4fPdFXFF8AuvZM0xlIPC5rALoXfxWVtZ5YMFo7abtLWJnlHE4xP?=
 =?us-ascii?Q?cI8E0/Wn/cjN36E8T6e7sQfsE8712C+tb4ClQqjqmdUb46WxyxbVh0GbxNvB?=
 =?us-ascii?Q?sMzxS0pWj/Z13cPj/F3vyvblwobmRr7LPyOwSWuuWLwGEcmsMcc9BlSuTNOk?=
 =?us-ascii?Q?oybyn8YAbYucP9tBayGIGHALGMBWmD5oKG6Dn2r9Qd7Py2ppsToEkRNV7NEJ?=
 =?us-ascii?Q?bOwHbvnLh6qDmbRaizn1JE7yHdWKr10J2DGZW4Z71HhhZ/d9g9ejzRJx0qBO?=
 =?us-ascii?Q?U6N+UIH9ATq76uZ5pVxPN30Fl2UafxihfmKooTcMbRgqJQMrBj9TWKL87K0a?=
 =?us-ascii?Q?lF9kQXOkBNpOxxMyqBZqhXNg80sQRHMAn5W0vv5U+EI52VC4bkW0OljaMSBA?=
 =?us-ascii?Q?rSgvkYlVvyGTGwQwbmkwm+zL4yD+YugJItSNHlphoZEC1hcLzhj6g/TEsmRu?=
 =?us-ascii?Q?rS/1D5k2E+z0IG4cPAIUwvykV9QaQH3XTSOSf2IXevqrXmKmYeyFDW0XX9Sz?=
 =?us-ascii?Q?KVG8J5vKXasX3law36wDj8ZTIx1Ln+vehTtpsXkjMB32gM/nX9V9+mBXJpt8?=
 =?us-ascii?Q?kHMj50UyP/IXSyuEQinu/iCybsC/zXSZxYZdspCRcXUIVjWNgjpCuNT8If7t?=
 =?us-ascii?Q?s7pDCTMlfkZ/o5IwsJkQFQq97T+gPG+rD/taacztA7OAt3U8aJHTjUZxwval?=
 =?us-ascii?Q?7k7MSDBDPubPVYzEOjUUSgaFmAUJtPAShAEEdrSaseh9dE2Z8V8RTM/Ck+zZ?=
 =?us-ascii?Q?uCyMMNZO0G09/oQCJbvslMzLnnDNMAs66dawZOoElVEY/Kyezc6wA0B5af4S?=
 =?us-ascii?Q?J2AC2PEDm19jPIVk4yFPe3/yXPAO/Qf1Ku6bwzS+giBoMciSFTifWMrnMdI+?=
 =?us-ascii?Q?DcTGlM6QkoXgGYJVfdOPeq7j+vJVLuTIlcttAiItE1ANi6gXHo72SyCprOxp?=
 =?us-ascii?Q?aTZOEoBD1iYujAMtmyQBHtVwGm40IBDZHN5LbgtZy3cq2RMUkl8r+UyVyXVr?=
 =?us-ascii?Q?+AXi/7U3AmRPrpBZIEQAxGqnOqWLz9tbIPGFc3NEAVhkyeOVOlApMatY5L4o?=
 =?us-ascii?Q?1Q9IXuPZ9QHbrxcpouWJ3UT47iMhVmqyVMbsJiAsUpc0cDs/rQPiUrEi+P0n?=
 =?us-ascii?Q?Og=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3GolPLKazFF67xNstX2YP0o76YxxVlBbB4DA1iUBMtrrnhsgnWPCJdDHzN2ilvv2IGnZVqxZJlFqZ99FgaQu2FwfrMl6QWsE/TVol8pLOFiBwUYdm3FwMXERPzIKYAiE6Ffgk7e5eZQQ2fGOzqqVrV8yiva//xTArp3EKAkHwJhM5ZATwKIzjVNPCn30e50mwwDRppcCSvmHqu1xpBOWTZQzXoqppDXf8Fy97cQE3WJRfZK3SZEapMeKMGjqAMgx8z0E8mN6PLmDkGpbhb+OVfg+WlBF8h/3tUb5HJ1IxdTmhazYyHO+zM/cXmWx9//oQZ5jZ10Ql+JgqH9FB29eomElil26LLRZ6H1zJLm6r78J0TaOzVlrARgSiFhGfPUY95MAP4HSjmop+CHKFHfU9ww2V85M0Syw2TLPtda9wee76uf019bIzcq/F1i9hkYOU4MWTL0ewGpRKQTCJPO8L4nKheUlfaly1Pivoqk8bHgLYWM2ekyj79GJpZL0B7btGuCpKflVDv6uozrjqpiA17oUpdD5Pfu+ZBl29mXYgjyM05OR9KXwvVIMwXpnXQhKMs/Afo1Vh71MKDuh0dhke8zKEQ5XwZFEoymOj1XhRlw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d18dd9-c2b4-40fa-46ef-08dcff5f9b5f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:47.5216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dFu/g1zm900r5+s9LZa4/ixwEbWSYB86dhlHoZkmD1i6RUaNJ5fjM+PGUHpkIr/6r88Jv+6MSRwjrBpkiozPoP3+5E1A3IzGCCQu61ebHeA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411070150
X-Proofpoint-ORIG-GUID: rB57-W3UuIomLuCMMt7BWnRyBUZpOG0i
X-Proofpoint-GUID: rB57-W3UuIomLuCMMt7BWnRyBUZpOG0i

From: Joao Martins <joao.m.martins@oracle.com>

While initializing haltpoll we check if KVM supports the
realtime hint and if idle is overridden at boot.

Both of these checks are x86 specific. So, in pursuit of
making cpuidle-haltpoll architecture independent, move these
checks out of common code.

Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/x86/include/asm/cpuidle_haltpoll.h |  1 +
 arch/x86/kernel/kvm.c                   | 13 +++++++++++++
 drivers/cpuidle/cpuidle-haltpoll.c      | 12 +-----------
 include/linux/cpuidle_haltpoll.h        |  5 +++++
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/cpuidle_haltpoll.h b/arch/x86/include/asm/cpuidle_haltpoll.h
index c8b39c6716ff..8a0a12769c2e 100644
--- a/arch/x86/include/asm/cpuidle_haltpoll.h
+++ b/arch/x86/include/asm/cpuidle_haltpoll.h
@@ -4,5 +4,6 @@
 
 void arch_haltpoll_enable(unsigned int cpu);
 void arch_haltpoll_disable(unsigned int cpu);
+bool arch_haltpoll_want(bool force);
 
 #endif
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 21e9e4845354..6d717819eb4e 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -1155,4 +1155,17 @@ void arch_haltpoll_disable(unsigned int cpu)
 	smp_call_function_single(cpu, kvm_enable_host_haltpoll, NULL, 1);
 }
 EXPORT_SYMBOL_GPL(arch_haltpoll_disable);
+
+bool arch_haltpoll_want(bool force)
+{
+	/* Do not load haltpoll if idle= is passed */
+	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
+		return false;
+
+	if (!kvm_para_available())
+		return false;
+
+	return kvm_para_has_hint(KVM_HINTS_REALTIME) || force;
+}
+EXPORT_SYMBOL_GPL(arch_haltpoll_want);
 #endif
diff --git a/drivers/cpuidle/cpuidle-haltpoll.c b/drivers/cpuidle/cpuidle-haltpoll.c
index bcd03e893a0a..e532aa2bf608 100644
--- a/drivers/cpuidle/cpuidle-haltpoll.c
+++ b/drivers/cpuidle/cpuidle-haltpoll.c
@@ -15,7 +15,6 @@
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <linux/sched/idle.h>
-#include <linux/kvm_para.h>
 #include <linux/cpuidle_haltpoll.h>
 
 static bool force __read_mostly;
@@ -93,21 +92,12 @@ static void haltpoll_uninit(void)
 	haltpoll_cpuidle_devices = NULL;
 }
 
-static bool haltpoll_want(void)
-{
-	return kvm_para_has_hint(KVM_HINTS_REALTIME) || force;
-}
-
 static int __init haltpoll_init(void)
 {
 	int ret;
 	struct cpuidle_driver *drv = &haltpoll_driver;
 
-	/* Do not load haltpoll if idle= is passed */
-	if (boot_option_idle_override != IDLE_NO_OVERRIDE)
-		return -ENODEV;
-
-	if (!kvm_para_available() || !haltpoll_want())
+	if (!arch_haltpoll_want(force))
 		return -ENODEV;
 
 	cpuidle_poll_state_init(drv);
diff --git a/include/linux/cpuidle_haltpoll.h b/include/linux/cpuidle_haltpoll.h
index d50c1e0411a2..68eb7a757120 100644
--- a/include/linux/cpuidle_haltpoll.h
+++ b/include/linux/cpuidle_haltpoll.h
@@ -12,5 +12,10 @@ static inline void arch_haltpoll_enable(unsigned int cpu)
 static inline void arch_haltpoll_disable(unsigned int cpu)
 {
 }
+
+static inline bool arch_haltpoll_want(bool force)
+{
+	return false;
+}
 #endif
 #endif
-- 
2.43.5


