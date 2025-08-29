Return-Path: <linux-arch+bounces-13323-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E5FB3B583
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 10:08:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4F9563305
	for <lists+linux-arch@lfdr.de>; Fri, 29 Aug 2025 08:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B496329B8E2;
	Fri, 29 Aug 2025 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MXfSBwgC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EpI5EiKa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CCA28641D;
	Fri, 29 Aug 2025 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756454893; cv=fail; b=LiLmsC25pWqQFPaRvh29PZePYxzAslJ4tseRA6c9cDXgyKjL2TJitwCdXdYUgOL4FztPI5t/dhmh+qZpUWD11PhMHG1QOYK/ugpVw5B7HqdtO82ztJ1MjyHWMttFUDX55gRcwpOwzS/Y9v75kC8dh3exvwBVY0KLvGe8WalpMaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756454893; c=relaxed/simple;
	bh=Qca8bLDto/LiKSn2Gr/z9ul8ebiQlkYw/enBsR/x8PE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=RQaoc6BqxdCF9jpAjGSDDl9W7o1US0hbXGmZvg1I5cZa+muRddvGAjgmwJyCDqCUnNA62csOOMxKLPWWiNWe8TLtSVvQVoZDjTQmPto8O4X5Yq+MMh1TvFPyVCezS4Kz4R/cc/a/AS7T8eIFb9wtNh1SRQnUaljlW23oCzSs18s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MXfSBwgC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EpI5EiKa; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57T8469E010921;
	Fri, 29 Aug 2025 08:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=jUUeL8xZot8t62Ir
	CpCR+xgk8fwyNOoDmynp7YDBkOw=; b=MXfSBwgC6UE6Zw8cS0Ubk6Cn6jdtTgvu
	kH6ySf5Rpwyp9eKEo2OaTzj8KAmxdGyY+FRn+5PZlwtOu2/IDgSZrSuh7hS9CEGE
	/7RSNNQDqcYOORZTSn2/coKkURkFqOAhYGnYkLHoSoQ+6eWatrLWJrUTpv3t3z3W
	6vvZj0GgWsm+NO15w1kVMfL1vtFveXRlT96uW3LPIiSFHldfieDezuEpRNjkafwg
	m0BjNksrvrdZx4lrmFlCMfS7TqeiPn0NiWdDlifsLleMocX6tURmxMFlCfwdq3oo
	g15sAuo3LPf+4fFZdYWZ0faLD+5sSqwUbLZcnM75lICKNYprH2BouA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jat1v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57T6ItmL005002;
	Fri, 29 Aug 2025 08:07:43 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2087.outbound.protection.outlook.com [40.107.102.87])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8d48ec-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 08:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a37Fz86JpDM1O+3lMDJDfr3XN6Uj5SHndjnFTO9bVZBYCFCoCLnRf9w3Og9qzj4tSF+TEZIMFFZEoRRbeLDvIaY8NXINGDpvbuN1Bzi6jDoDSntxdwC8rki8oXkXXaMSbIrEM8fp85obBQO4eobrEW9elGsOtM+jN+SkGqNDHewyZ6De0fYdBsOf1Gb9vjOrjQom2ymLOA4B4dpTmELLrBRbwDuEFXSQn663rYKidFCzTVBg1vS2mv/RFdE35L0FwWKHvVBw67i3HqfgOP7c80OCr5fZoYpHv6wNmSQc4YYJn9QeE/K9oahgddbTNxbdaFgJYNOB/YTp7moyufzYgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jUUeL8xZot8t62IrCpCR+xgk8fwyNOoDmynp7YDBkOw=;
 b=o2ISacjdACigktFxefYsnSIoH++O6oEk0HcTSWa8L8CeqpEReKKl5NSw8CFfTZmKpXYiXYwG4ZhzsCzNp/SvAP5x+GrsVRh9DvbPZCEx8xtHBgSulOmpSTTZxXsIN5z0xLl5Sfapxc+TV3cnP9NDgSX1EHMtjGuL0lk//Wp9OT5jMllaVtrNkMsDW+c65sI8v9lAm9P+MFexeVBOwWB51MXRne99XFLxgHZ208VMnZnU5/sIF+oEd2czfqZRDTmjoyb2mMfJj+zw67uTDGNYajyEVBCBBE9GhAf4thkw1ikRYpfdUB0L6Bgzf7Ch36M7Ny7QJ394WOk8ZYmEHk+JRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jUUeL8xZot8t62IrCpCR+xgk8fwyNOoDmynp7YDBkOw=;
 b=EpI5EiKaQXCLkWtnETY66ESuT/xLTKNkt/RQDlz4jHeZDwlhzYbvPFkP7ltSYOfKWV1kUzCVi3/ZM4X2gCEELNAZUW6Bf294lelqU3b0raL4PexW/qy+2vQsKwCqCRYm8x2agzmUAvNJ9MgL3zYtsd778+vmt31Md9H744nor2I=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN0PR10MB6008.namprd10.prod.outlook.com (2603:10b6:208:3c8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Fri, 29 Aug
 2025 08:07:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Fri, 29 Aug 2025
 08:07:37 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v4 0/5] barrier: Add smp_cond_load_*_timewait()
Date: Fri, 29 Aug 2025 01:07:30 -0700
Message-Id: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0142.namprd04.prod.outlook.com
 (2603:10b6:303:84::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN0PR10MB6008:EE_
X-MS-Office365-Filtering-Correlation-Id: ef6158cc-efb9-476b-03b9-08dde6d31d8b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5lYOLuAVp0e29zR3BuygXMlePed/YlvrKU5k180PhQZJwcYPLJG9pDZn/cGX?=
 =?us-ascii?Q?YoDiuMP+LdvYpnrjAerYHab4Xo5Z1GY3vnKmZ89Fclb6IdMRn3RXXDGBPAQu?=
 =?us-ascii?Q?ksddK4BnaZ4DXUv8WtM63Pg/Qw9CqyPQ1QBnOnT7EkFK81q25YXf88Hhm/a8?=
 =?us-ascii?Q?a1cAA5joEXOV/n1E/JU8SkvOch7kqp+rPvs2fZxFMiIIKH2DUZdnPuHrY7K7?=
 =?us-ascii?Q?LvQc/2Hdqs+9opr4tT3Kb0qkTT5y8jGIG1RcycfAOtyTm19f40lP6cjP7i7F?=
 =?us-ascii?Q?jRTWNmwZiYnXSQlvq/UG+xM1s9WLhHB4BxtuOc/oRbd0X2Ypk+yvHVh1a5Al?=
 =?us-ascii?Q?TwIPbmEEJctKjUAbTU8vWwdZ0qRV44CsPcj5vmutvhaQEih8cAVwcSMdAofZ?=
 =?us-ascii?Q?c1NBLGq2Lovyap2AMIvslIk7eTn4W5bds4k5TFaorkb+QwqmrFNIN8NhuWQm?=
 =?us-ascii?Q?XreX74E+qcSrBhnRCqD6j7GA04Gp1CABgreX3JEmQGg/ApCytZd3zMd2pcI1?=
 =?us-ascii?Q?XDb9LngPCAPWtKYT1Tepi/W7Z5UbvwOlKuPxk72tmT7E82qOaDuou2J8j2pj?=
 =?us-ascii?Q?ZRwPQDLAEEVT5n/3f+gpJARsPXUMz4cqI0fefy4OQMFUK8jsMlORjClcbAbE?=
 =?us-ascii?Q?WJLV5u3syDBWM0+VVI/oXxLylLnbX6Iljtj1ktfbQW6NsSWyqxztUyaVBjSE?=
 =?us-ascii?Q?Sp+5boKJg59ksyZxCXOq5jiwts5FoTeRkVTN/CGgdOz96Nz5kQ4uudJPmaOX?=
 =?us-ascii?Q?i/IYWlnBGjCiUwCKUfRgWScgtCxC+qW60kKjs/ZVuBaYCUun8Un4uTRpayXd?=
 =?us-ascii?Q?aW6CaBgcX5SmV1zV0DfC80GpFImu7OVoag7cxvnW21nL4R5Goe/u7JRUw4yA?=
 =?us-ascii?Q?kgYuShjtBVtY8CBSnHDGdf/9c+M8DYK45s8QQkl6n5A4QRz0ZiihkO8XJLg4?=
 =?us-ascii?Q?DZm+8H41gnE6TButstwKvz6AxhTEC0J7ps3/hnbYg7nMDBrrKChwY0JHjTuA?=
 =?us-ascii?Q?x68dSYfXA1BGvm3bTAd0zViKJa07pnldV4QzbcwMc7bvTP+lr8h0admDBK0D?=
 =?us-ascii?Q?opSrR6RKis53LiEtVRSV6EdY6syE5H7zh+xNJBxxFOoYWW9JVKhlDvNgvTFr?=
 =?us-ascii?Q?NfLszHNPlGV3AdXRYB63qB4Q6UAy2Kf7M+Y6lci3/pe2WyxYlEWXbKvMZWio?=
 =?us-ascii?Q?jJScutIqvCZgZx20s6bLvo6ikuEs00ADsbDuV6OhorxgEmhRAqIL5dXPXRgN?=
 =?us-ascii?Q?8CEFOBw+QgRt7n/pCJuvPTQf1Ia8JxJN4denDzZtEaroFQsTl4tOFQ/ShhZ/?=
 =?us-ascii?Q?dvOd4cMy9S1gnBKQa9/nFrI5lu0Qil4ypCBAIa/vE8FPk+RxJcl8aDrv3JK2?=
 =?us-ascii?Q?naTKW2FwCTjLxzbk5ZhdohmayXU8VQ7OgngjFOOs8vJ9ScHudgFodJca8z7s?=
 =?us-ascii?Q?lWV5RAhpaqg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GYncutD7hTe8remS9Rpxwmw0aUtcSf6iTZnknxyoNcYSzBD6tMa2UhrAl1rV?=
 =?us-ascii?Q?tqpkMS74GG4pY+sFVCrVBeNKVFc4h7cAeiWiMIzvJKf93DMOQE8dC91hNjat?=
 =?us-ascii?Q?AiuvIFafxDtw7fvAYtMzdy4awq/Xg6bNxl8Z090Db/N0q9Clgr8mhU3kfyW1?=
 =?us-ascii?Q?1dDNbF9NS1plNw0mwV8NmpB/eGU3d1lV9F7JKIxlUlOdA9iN68JQ8oM9h/yt?=
 =?us-ascii?Q?Gx+2dRawUvq9kIm8iXYJ9C6TvIkFbNbCIOO4vhHWeyNzHRF7qusb4XU+m/12?=
 =?us-ascii?Q?ZEMCgfnxecOmksS8ZILGG1oiLpRxyObW6XTVCToLROqvySkO4S8XcIYfKPL/?=
 =?us-ascii?Q?ZHuTTurk4x5RX5MX+ed/c5VutYPzIn+KDmeRZun9LxtY6TNRoztzYqztsZiW?=
 =?us-ascii?Q?77cVpJMjl2o7awYyOz5m0HOh+B46AlLKdq6PJpsm332yqoaD1aRuViZezKhM?=
 =?us-ascii?Q?8mMcstDuwFg3Rd6ucc3b73zSLBk2Vs5oR5+LyLOjIop3XxTpeHtfk0QFelFj?=
 =?us-ascii?Q?4eCeewFldVx4jaf+HhzHRK/Xe8VCBh3xtlPs05ulnCwuDy6y/5leBFutrPr0?=
 =?us-ascii?Q?rNaTBBHhyU1uO1MTPR+hvCoaRuPRsMnl9NgmSOnwEYQp1Swiu4wQihWN4lwe?=
 =?us-ascii?Q?Ws0ai+aAPn3eZMqDnds4UvNDJ0l5uY8N4aonjZZQVg9FnPTShG2iaBAvIPQs?=
 =?us-ascii?Q?g5Tmdfux24GDXhui7LNCzKSLOoNyK/KQ/esvx4Av7AzLcW5Xy0DwaxbRtVbc?=
 =?us-ascii?Q?w9oxAUc1KDF474p2UNqTPuO3xE+GMpe2fAdBeNK8RCicRolPhlLKFLoVWE1V?=
 =?us-ascii?Q?WCFN3awybVpHXs6H33QwJpkq3eFFrXWLLz0wLUlaE/ae9IbNANXO+2/AvMhS?=
 =?us-ascii?Q?pNgifMy13YKzYX6a5OAmfUYCuN69AnN5Llyt4dYujxslEoa9HvDr9WjcTN//?=
 =?us-ascii?Q?JE5Wl0MsDnr7PHor/BXpUsFltgXSPN+hRnIPgtT//fQT13I156bsvttusuZm?=
 =?us-ascii?Q?vQ6B+FWLf35g0zK9nzymaz7UwczfiwH3DE+GenVbDj6/wvUhSsSIaLhTMTGg?=
 =?us-ascii?Q?xG0VgP88IdQX+Er5ibhvKdowS48pUKta4Px8qZeTnKIpEy8SVuXGRQuJEKH+?=
 =?us-ascii?Q?Hhzx0Wnbo4eoDLkmZRcJlcL/q4wLLlxtEfam23zEKh9VzvUnSDv0BqWLlrmS?=
 =?us-ascii?Q?QtlcWNs9AI3sza64gvwiFzgTWgqLmc7xPOtWoWmHEWP5n8L9C9NvfJUTGMMO?=
 =?us-ascii?Q?Uy8Hi7aPM6WSQpKXecnHGwZ3u6xVDxC0cKP6bHbx37xJzOmY1oxw1IcLLFMW?=
 =?us-ascii?Q?O79iWgvdivBtiL5fWgDTEg6MLMhshY7DedvZe4QBdizqItsJkmjl4KKPxI4C?=
 =?us-ascii?Q?n2Hj2A54UKl0qJkyeiEcnY2PPGFRrdpOOmxnGrLOORIpxSr8DvM044XVGBvQ?=
 =?us-ascii?Q?74UFjhVRme53wmB0agXdIJ0U/okpXoGLyurfai1Nlr7/UOd9Hytu+l9mhH+Z?=
 =?us-ascii?Q?NVEwpFA+OzSSJM1Y77Z9BAX0zn5dkgLt25vLUwt/axRWDvj1sLgKkgjYfqIh?=
 =?us-ascii?Q?mmLSfjTOKr/r8fCiGlQFDJopVLNMR6vuNLCmQf4XALNi0RQJfCJ2XBtQBYZT?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tE9EmrIiLjtLsE+dVV+oeNujd9jOChpfwYRcDUaL5n943pruUuMJujHPwvfgK6v9Mh12UE3hEHkJqIJpQclFT/1DvkWziRWiUX5tSBglFsgL3FUOH6LpwcbuMoz9pdvUMIW21I8OaeohcCLbQlrWE3+V/o7GwYbv8Pn7S6NjeeVBX2ruBRqhr1s9TdKDv6MegxcxAJ/eEmVPGranVyka/fs7E0CulKdV7AJWrP8lcWWGIbTmv9V4e4KPJJO5JrpErtMWbKT6sB9NsLxcKT5OgUi06DS96v7PkVjFYRAGT3iOp2vl3Hqn9akMFpNiTbzUWWn8/UgoFoiU11fjpbZcUKwyYBY8aF5Bv64+gHNyafEGzeLLD3imR31pKM0O3bH5b67JiOF2i0wr3uWK/ufy5q2tLPeMBgtGmHHVvvs2/7wLpxA+dNXiV1cZTeX9kzt5el7MB5x0w4HBgr0goL+kLporv8p7gUcnnoSwB38+9LVr55DD1vEwvtW/mcLOl23dQl3o1dcjM/JnuixziMil5nMH5+jh9+IbJdQ4mUeDqdzM4V+TxWJqFe8TC396//yFQSqWg3eRQ3aDbI2mRn/bw6k5atJ3U8mMb6Be+M8dK8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef6158cc-efb9-476b-03b9-08dde6d31d8b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 08:07:36.9755
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uNXoAR/Zj/T6FHm4GsC6iEh2xBNpfflUHiH/BbBlbo0QALgBGFCLCx3Z8O7iBE7s13OmfPkl7b5nQGb4sOEBcX7HpTF3gcxdqyVZj2OirZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR10MB6008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_02,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX9YKo/z/TrVrt
 BhFtrVTj3hiGX4R/W9F4OzXA/51md5WxKGiWS5ddGXSCMk30oKeRiMXYv0dcBkFC0by6gQcn6QF
 UAHtJ69E6wKuyKnPjRmujtCJOd1Z+QcCX0FkHsom1ZBUHrlmo5TnKK/Bo23AGoGqWz41Jdxg39q
 s74nokT6gb8g2JkEJ67jBi04mU5jOaIUmGY1x+qjgZIfKMjuNtMKnJc3Js2QERUn4YlaiE8aG2D
 p1ZrjhHp77GhXFMqvBXPbnTQoCGBxw8NTciu9i5JnK5TmSy4i3/937vkWtueM/Y5gQ3DoJqS1sl
 YigNerzupdhq80puI5iy/PpzBeuVQIimNwqVYtNZpCitG1GWNbtJ/NnPpYzqOa7EsvkXGAOlGW+
 a7/5K+LpgalEGoMujYpdCWaK7mnNkg==
X-Proofpoint-GUID: 9n7fG4WwKCQO3klmUczAEhoU6B_Yo10f
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b15fd1 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=vggBfdFIAAAA:8
 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=sixQ6WRDSDE1znmn3xAA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: 9n7fG4WwKCQO3klmUczAEhoU6B_Yo10f

Hi,

This series adds waited variants of the smp_cond_load() primitives:
smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().

Why?: as the name suggests, the new interfaces are meant for contexts
where you want to wait on a condition variable for a finite duration.
This is easy enough to do with a loop around cpu_relax(). However,
some architectures (ex. arm64) also allow waiting on a cacheline. So,
these interfaces handle a mixture of spin/wait with a smp_cond_load()
thrown in.

There are two known users for these interfaces:

 - poll_idle() [1]
 - resilient queued spinlocks [2]

The interfaces are:
   smp_cond_load_relaxed_timewait(ptr, cond_expr, time_check_expr)
   smp_cond_load_acquire_spinwait(ptr, cond_expr, time_check_expr)

The added parameter, time_check_expr, determines the bail out condition.

Changelog:
  v3 [3]:
    - further interface simplifications (suggested by Catalin Marinas)

  v2 [4]:
    - simplified the interface (suggested by Catalin Marinas)
       - get rid of wait_policy, and a multitude of constants
       - adds a slack parameter
      This helped remove a fair amount of duplicated code duplication and in hindsight
      unnecessary constants.

  v1 [5]:
     - add wait_policy (coarse and fine)
     - derive spin-count etc at runtime instead of using arbitrary
       constants.

Haris Okanovic had tested an earlier version of this series with 
poll_idle()/haltpoll patches. [6]

Any comments appreciated!

Thanks!
Ankur

[1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
[2] Uses the smp_cond_load_acquire_timewait() from v1
    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/include/asm/rqspinlock.h
[3] https://lore.kernel.org/lkml/20250627044805.945491-1-ankur.a.arora@oracle.com/
[4] https://lore.kernel.org/lkml/20250502085223.1316925-1-ankur.a.arora@oracle.com/
[5] https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com/
[6] https://lore.kernel.org/lkml/f2f5d09e79539754ced085ed89865787fa668695.camel@amazon.com

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org

Ankur Arora (5):
  asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
  arm64: barrier: Add smp_cond_load_relaxed_timewait()
  arm64: rqspinlock: Remove private copy of
    smp_cond_load_acquire_timewait
  asm-generic: barrier: Add smp_cond_load_acquire_timewait()
  rqspinlock: use smp_cond_load_acquire_timewait()

 arch/arm64/include/asm/barrier.h    | 22 ++++++++
 arch/arm64/include/asm/rqspinlock.h | 84 +----------------------------
 include/asm-generic/barrier.h       | 57 ++++++++++++++++++++
 include/asm-generic/rqspinlock.h    |  4 ++
 kernel/bpf/rqspinlock.c             | 25 ++++-----
 5 files changed, 93 insertions(+), 99 deletions(-)

-- 
2.31.1


