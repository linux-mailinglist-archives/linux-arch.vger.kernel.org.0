Return-Path: <linux-arch+bounces-13700-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2CFAB8BA37
	for <lists+linux-arch@lfdr.de>; Sat, 20 Sep 2025 01:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A364AA01A4B
	for <lists+linux-arch@lfdr.de>; Fri, 19 Sep 2025 23:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64568262FD0;
	Fri, 19 Sep 2025 23:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DrIQ7ZdP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LrUWM6LO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8571D1B87C0;
	Fri, 19 Sep 2025 23:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758325350; cv=fail; b=BlPOGKThxB/XayVT/pfgcfK+GXv30APpFBTh4A7zlSliO/9BPOFZBj2G5hVg7IlCjIhXyXcFDLQvxvKUM/AMUKBJrOSOf6fGW74kbwcYJCAC+HDBPU/s8N4/PKjAV04w9SHktfRyDhRMecQHwEFijqAcouf1vsbAU8XHsfCBxsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758325350; c=relaxed/simple;
	bh=qQfEvB4GJnkA/w+SSp8+kOIl0CKGwFjy9nh+s/3mwkY=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=jCoF+IG1tekW11wSMYtsYUtgsKHfdqH5jUPzkYyW6Al7yeD4lHhKVahbIfmbmyDPDq/+EELx0Tct60p3qcHIPcYiXQt83o2ZWwuESdU/21KofWB8+mmBx43hehlw5jp5OMKrLyJSns3oIj2rPJE5l7IHoWDMtfkDpzZ3QQPvyb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DrIQ7ZdP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LrUWM6LO; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JNKHEa015423;
	Fri, 19 Sep 2025 23:42:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=koLMm1dt1EJvDSYi8Y
	ilXl7TntX5vxiYeo3ooz3ySdM=; b=DrIQ7ZdPnp0/Ae35PyvlJ8eMgrrVqdK4yH
	MKiPLkUAMdONRRRypm0p1f1te4TGuiZUKCXsdINqV2EoYv7y+nltm1Wpp2N24kD+
	B+e6OsnBb9VijHfHpVFbtU/PdCQhhRPWLzqZqVCmViSQIeNRQjvCbgp/ToE8NvVO
	Wxt4E0hVd/mHn5UafGze9+Xnid0LgQWCntBZcDZT+rsorLv552dXmojiKJY9nOJF
	d06i9PZuRrw4HDoXalZsAMRQ/5kSqVErk9rnMBaqoSQJVWusWL3UiUbkdCvVzfco
	5VH3eDYKmRmWXrltNkZFWHXD5qdCpCapKcG6UXj43Ve/I+3XZ8MA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fx96e37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 23:42:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58JKxZaZ001582;
	Fri, 19 Sep 2025 23:42:02 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2h8fgj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 23:42:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWMixb7TubIiPsZG3JLgHkH2JWf6b3+I1KkZPYVc/TsE52R+OYHW6gOJqqZq/MYZeSqDa7KsU59qqK/JE5hdZM3oqJNJYcQsqmiCsL5+JR+X2ySFAZc6EAYFDYHplZZJT48US0Vs5G1Een9bCst1ObAmAbbosHyNeQj0AyEIXIfu9Mwzm97w1EyANUP1lOVTaNhQ7zPd0HoVmMHba5xjWPhIvVjEMLPLhYqjxKSzYhoOeoQVanRH1+SYNgpTCsTq1sv/Ehfp4XYyXhCRQoNhhZTVK/w+QV/ZbWBdy2HbNMEw73ZbhkYRzd8rY9TcNdwY18YIdWZtN1XH9tJkftV0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=koLMm1dt1EJvDSYi8YilXl7TntX5vxiYeo3ooz3ySdM=;
 b=brI2SReGThI7acDKmTZ3qCIgtRQct07xEE4IUSAC/Tk/ySWaNij1bzdoBYhHnc6HBm0Gu5rlWPpOEvp+8aPObxiBUiTOE7u6Rl/Heg688EIkn6qgXxgN0gHNHw90f6iQEZGoxZd0cS6a7VzVt3hqnox7SGQLhb/Jc8Mz+/A17+yNnSdzVlSsRAAJVR9eElR824umbtlObaUPQCIs8pP/Dsxo3PLc+79fVhvHRhxXg2amqN8TSuyW8pb09KOKT6xxeTPlrbAxsLNXOmNHbAi2xQ+9L7xGkLLCpSj52emOFJXERz/GYGAtVMJqHukMo8GSISO6o2Nix7iclViTn2l9Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=koLMm1dt1EJvDSYi8YilXl7TntX5vxiYeo3ooz3ySdM=;
 b=LrUWM6LOJaTx5eUMNgsJtcfsdVdlaEiwAwB6BgwbUTRKbvvFAvxqQz+YK41SZlDFCv8M1WkB18FzE9ZVMQBO7lZpYp593k6MWWgmedoECXabYXtaUIaymXtZ6jDV2pVWWg/jRYq2qCEKQsG99JPDympwlc9CU2VxIDfOYokhYk0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH3PPF077CE0592.namprd10.prod.outlook.com (2603:10b6:518:1::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 19 Sep
 2025 23:41:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9115.020; Fri, 19 Sep 2025
 23:41:57 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-2-ankur.a.arora@oracle.com>
 <aMxgsh3AVO5_CCqf@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v5 1/5] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <aMxgsh3AVO5_CCqf@willie-the-truck>
Date: Fri, 19 Sep 2025 16:41:56 -0700
Message-ID: <87qzw2f1rv.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0029.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::34) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH3PPF077CE0592:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c508a63-a445-4ec3-ab0a-08ddf7d61f49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WVvktJs1oQo1iPlX4zzC+LabRZ3ex16vCrvmEFiRoFhTaMZypqhyEnXyvhO3?=
 =?us-ascii?Q?yd3DYRXggWqu5Ve6I+qRdKzBNJTFdACym7V4/dwCS+lbgt49Hcj/r1qmyoQM?=
 =?us-ascii?Q?kpp+QMsKaqglePbGGvTOnZAnkM43GjsRrS5n1BDMc0pK547Ab0CNmM9FwevC?=
 =?us-ascii?Q?Z5+D+H93+YTB6xoJuWoUNUCnSfg0gH4DOOVwQoeK3pIG1kFmas51RRD9g3Qt?=
 =?us-ascii?Q?aLVeDBfreGoWNHvlTeN4KXh5/HjfZU6wgBIESgK2gBb5WzYjWrWm20Q/e4jo?=
 =?us-ascii?Q?5r8UJ2aqytzNyItL899/Ml6c7WV3nkQvqQztoGmpzeda+Ca6w2uixzGnMvAp?=
 =?us-ascii?Q?LqvOPAoI8uTNalcHDhoWM/l0CNmUJSxDlQpKYPwTxsEuj4nXQ0i/AbfErCma?=
 =?us-ascii?Q?nUgNq/mN92odGSxmMmf81TY5HKK18UgupCfNjtt9jBGqcSjfv+wu5R9IaBek?=
 =?us-ascii?Q?f0KXWaUIGRU4owVT3I60395goudVSKn+Dh+Dk0eKa8tOXOzs2AGsii3sbYQW?=
 =?us-ascii?Q?2zKDvjOfHGGBMkTdMSZsK3lHOyILI/5uzpDFyWoQlbYGkbLLlJTdXQqce0bg?=
 =?us-ascii?Q?JjH9duTLNlICHPJ4CkOGRAb+pYFCISvC2v3bobtPtk81QzWm5maSVJQVmwaU?=
 =?us-ascii?Q?98YNgRf41UEwT0+VvUKrCNFWJJVHeKcjMBgxDiyO75oSllxs6qjEspyghINx?=
 =?us-ascii?Q?d4YWJjS53ZpD17ws9EgQt42NEYdONlzueT9Pa7JOlCh6/4dPQPZTSdWqHRGq?=
 =?us-ascii?Q?ovOtSTQiVCULfmaVp6CKvLgrJprtHwNsBptNFAP5bpq2tj7/lYfAyga3TEMP?=
 =?us-ascii?Q?66H7rtx0HV/BfwAMMDxx54jsWz5k50ZNU46GQWnFD7dgTU8qhEcrxAGkgFpH?=
 =?us-ascii?Q?1gMQaD76ZrWvnIMvyxVTjjEVeCiAmUkcqF0hwzb3jSuFImHq13k8btQRffaF?=
 =?us-ascii?Q?MYOUe6ORpMTRz3NYnzBao1MQI66CcsejbQYBYwWbM5uzs2GjvW8YckUca8KU?=
 =?us-ascii?Q?skIcB432+8Kky6+u2BSuevMwx36inZcWGXXUlJcSL7Q3x5iKCM0Tb4g11hl6?=
 =?us-ascii?Q?2Rnw4MtAgdKFMHJkHm8k6pQ1pf5UFK3aVMm1qln+HJ6B0kEi0Ox3OS3sVr+3?=
 =?us-ascii?Q?092pHJAVEOqCTSJZA7s24IuWkfS30HF+Hgov9eI41VHeRRDKfgd3yzEa9ka2?=
 =?us-ascii?Q?ac/LyLBfVvHtGtzi9YLeTTbwXDL4GRQNsuoI0e4Qbsc8L8BIDy10pvPdWwA/?=
 =?us-ascii?Q?pjSmkNV3rur8jhb9eNRyoQs7UWNkcXBVIwt3R0nLarVBje0PZk2ZvzpKi0El?=
 =?us-ascii?Q?UfHrLpsYbVBYFFSks58ZPF8KPGVMCLKiI/aSVd9ogdRwHNgTSCpcVm4Meknp?=
 =?us-ascii?Q?n1FHdripBtgUqYtRAGeBQf5PqxetbU7VBcyyzip5UJGaPx2cCiQ/ksaclSUW?=
 =?us-ascii?Q?p2U2/n44NrQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jj4Q/e8l0MInm2+591I9qKz55ZBFnsWLKIzUO2cb5jIhY9s0lRRAyNKwCZuN?=
 =?us-ascii?Q?59qoUzqnHVlKNyCKndc+xI36lf5K40VwyhuxXnDUfMK4/2maT4DX74vCVMue?=
 =?us-ascii?Q?iZgdXjurC/iQJx9B/1FmrFeI6GrxwhTZb8FGwS9/KB0cIiHWhS6h9qmo7Bpc?=
 =?us-ascii?Q?doc+Qy3Gj8G80LiduE4mHM/fdy/u1LFaqpQ7SGye+bfjJthES3biStCO3K3y?=
 =?us-ascii?Q?XgW7p7Oqy1EbiT6nTFt6lA0ztlXiEeqirZNjs6o4dMCh+aI8cb9yoTFhZ8hs?=
 =?us-ascii?Q?X2tk9PI1gH4Q24ZuiaMYDIMzp99U6nIavheUUyeYdMuXAWzxv3vu9WomRlMl?=
 =?us-ascii?Q?rhg5v7x9xMmEy/LUDBjMoSqaeQp7/G8RHXJL0t3sQu+Zr/+LFXW025HTaQzt?=
 =?us-ascii?Q?7OKH4Iws/O/ZLWN+8XsHszdMKzYJXjrSxwZeo7N8xg7savTtc3X1bV52SNha?=
 =?us-ascii?Q?xVCkwDLKyewgPyYYxCGrwWA6scEZRhwglGHVOvE4FI2Ev3b5srDwS3HYebjN?=
 =?us-ascii?Q?q5rsoAJhy4lE1bCLM8oYbjZA8qP5Gh0XkV61J7S7SmeBLh8rOn+ll114ilxX?=
 =?us-ascii?Q?vID8o6nfJEVDtV5rAiMKMO4BCoIHWDRe5f51/soYxeoSQ/azLuX/V39DOzwU?=
 =?us-ascii?Q?UAi828BFSCy3VtW2xodGpGtEBFmwSyFVL2NOw/rp+/FavRYnopL5rnB8bA3V?=
 =?us-ascii?Q?cI4yYGn8gIphoJiLD4qT8JCgu36rtnm60IkuCmhs8agxUpRk1zc3ZXYHrqVw?=
 =?us-ascii?Q?QKXxSlkniD0F2YXr4y4kuQJ9e4UgtqQoDqRCBYWtIwRKkohM+09sc99lMGTX?=
 =?us-ascii?Q?RF257hjqpazq6JHSRoruKnCdBoJOV9Gft4xGUNfnpUULYHWJ+ktkFEp62rhh?=
 =?us-ascii?Q?c1G5nfLXrbWJl0Im4HOQxtPHl61RRKJWml7ZLC/ZM3JQfCxKde7XK8i+iCWi?=
 =?us-ascii?Q?by3sswRJKTLLlussSvvtuvZdUXKxodBz5uQeY8q7y8Zp3QpXlrdfkauv3HML?=
 =?us-ascii?Q?AI6n4EdiHTmCqBZ+5sXM8CyN1B4sJ3eb6d8Ih5f/AOrax5AbhRONjC+qAYeQ?=
 =?us-ascii?Q?XVvw7JWqSUK3eD/rGd6oDn2AbhHFRhimb0lpMZcZ/XFd/iJWsU2vNIAN2YWC?=
 =?us-ascii?Q?leeEPqgZPV/C6ZImW0B38xiMLPcwtLrcc6DFQh3Gs3azTREBztwXEO6Y/4dX?=
 =?us-ascii?Q?njbJXeCziXR7hXb5Y4DFr6AEsnEd1Y389w686zzkwvbg0nMFuPi4mz5myAif?=
 =?us-ascii?Q?y+YUxhzdnnMfqXsxR6IEnQhFVbbfozpEIQFMbPPJLMSFA0iJlgfg9SGGnVO0?=
 =?us-ascii?Q?Qn+cIib3SzbSXAZ0IhUhXUx1rWhtaM58AUf4ot7GWHwjXHxveFB4K6+R/88Q?=
 =?us-ascii?Q?lC3qnRzRiM2uzmbmtljAm2kVC16Bgshgy8+wpyW6ZefawzuwQu8G2mN8Fr2q?=
 =?us-ascii?Q?VH4MvDw++zu6/unhPOduEvDa3WAo+it1J0YaADzBvXibGDAlB7HkFkS/vEpn?=
 =?us-ascii?Q?gPa6+K1bAftqWl/AEJJ/Syu5zjT7FE3TVYxesmi2NGMdbwtyo9MdNkiiQ0He?=
 =?us-ascii?Q?zuQIRZLGQfRAlKnytTG/ZSjrSUnmE4FaB8K6ZSSDEy42r4h5dRUww2PIxsuU?=
 =?us-ascii?Q?BA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KZn73bqN0r9MiQegNumEf6Nx5wDdv2JHc5iny0h56k0ARkNURn189bYFQX8wPEZAdQGea8WyQtkVVm8E6OXStFtkJPzV5Oedx3mja0ZLQS2Eb3ktiRLazcykiXMz9Hg9VpR134Pnq6hsMTIBhyDWEup1B8RRoxRDLLh2lIZ8jZT1tzffC0puc37DduiHHH9c5vc6MdNZoBs2ZBuiSfqP7lNbdRFb9kIwGiVbQzCwIus5cNQpeGxrYqU/MhNTdwbX84SWICXLFIg4tdw+Ru8Sjpute89Jkd4yrJxWVyRy+MUqLEWSKSnDxKae11af9VZUUI71oQkpDQThxptGtgBbpoB1YOd/61EwephgaD0gByKxl2mAO/lFLcz+4YP1aqXdwAQbonsVpyboq6MRosSGgDqFUcOJHVZRQ1nbsqL5HjlvNUtzFQsITXSanP70XkRYM4S+zoA6jJi9lz5pILXTe+zyYc9T/nfIK/OT5NTIjmZV9UrDxtsEKLLab6VKym4XCIUvVeb+64kKKWH/P5hJzvvr1HJVsZgWhLEQr5/JYPoKBJ8Yk4KkSHaLZ8mf1AyUjDIXzVfVAxWLej2NZOBrnfstHN6pvLnqmPrztKeyF7U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c508a63-a445-4ec3-ab0a-08ddf7d61f49
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 23:41:57.7634
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dcD83BC1l5WByfsHxOyR8ABq61N6aSqqQMYixCV1Sq+slPe1yqTnOIhOIWoD21e2bA3J6iOwh0k3BtmQSSY6YwqlEBvMkI92wL0u/LkVfzg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF077CE0592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-19_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509190222
X-Proofpoint-ORIG-GUID: FKGzDLcfR7qxN5Nchlf8Cb76pl3v-fii
X-Proofpoint-GUID: FKGzDLcfR7qxN5Nchlf8Cb76pl3v-fii
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfXyJF46uQnDmIR
 udzahmKI762pOY9cX/IXF1MPirclqkuGiDlw38JDD9TU6S8blFTNhjOLGJALes3WCzdITM9FPM9
 lot8qb4a5BTDRleDo2BmUv92aOCJ4NCojtm0ABW7iWJXVFwovN4neJo6rhaclfv98JgSJH2FlJY
 j+2HXo6zWNi68hqvIV4lXPb4u7XOFJtrO2fLNyCtrMvPh/0XNTGZa7xBf++luXzZGJlKDM8idev
 nsuptYL3b6vCoucLy/JhY9uT0LZ5VFWlLPYCp6EqmaT+VT4zgH6Dt7hBGvyQsQTHD222q5n+i8F
 HrKgVBdLPVzIroiqS3lXIlz96bDj1mgN/NCk64EOasSJhqJfE6mz8t7Z9X/94bfJr47sS2X/Itn
 2VSQwEdd
X-Authority-Analysis: v=2.4 cv=N/QpF39B c=1 sm=1 tr=0 ts=68cdea4b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8
 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=N0mHfQjzrwZJlJiCkAYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22


Will Deacon <will@kernel.org> writes:

> On Wed, Sep 10, 2025 at 08:46:51PM -0700, Ankur Arora wrote:
>> Add smp_cond_load_relaxed_timeout(), which extends
>> smp_cond_load_relaxed() to allow waiting for a duration.
>>
>> The additional parameter allows for the timeout check.
>>
>> The waiting is done via the usual cpu_relax() spin-wait around the
>> condition variable with periodic evaluation of the time-check.
>>
>> The number of times we spin is defined by SMP_TIMEOUT_SPIN_COUNT
>> (chosen to be 200 by default) which, assuming each cpu_relax()
>> iteration takes around 20-30 cycles (measured on a variety of x86
>> platforms), amounts to around 4000-6000 cycles.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Peter Zijlstra <peterz@infradead.org>
>> Cc: linux-arch@vger.kernel.org
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Reviewed-by: Haris Okanovic <harisokn@amazon.com>
>> Tested-by: Haris Okanovic <harisokn@amazon.com>
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  include/asm-generic/barrier.h | 35 +++++++++++++++++++++++++++++++++++
>>  1 file changed, 35 insertions(+)
>>
>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..8483e139954f 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,41 @@ do {									\
>>  })
>>  #endif
>>
>> +#ifndef SMP_TIMEOUT_SPIN_COUNT
>> +#define SMP_TIMEOUT_SPIN_COUNT		200
>> +#endif
>> +
>> +/**
>> + * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on
>> + * @cond: boolean expression to wait for
>> + * @time_check_expr: expression to decide when to bail out
>> + *
>> + * Equivalent to using READ_ONCE() on the condition variable.
>> + */
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	u32 __n = 0, __spin = SMP_TIMEOUT_SPIN_COUNT;			\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (++__n < __spin)					\
>> +			continue;					\
>> +		if (time_check_expr)					\
>> +			break;						\
>
> There's a funny discrepancy here when compared to the arm64 version in
> the next patch. Here, if we time out, then the value returned is
> potentially quite stale because it was read before the last cpu_relax().
> In the arm64 patch, the timeout check is before the cmpwait/cpu_relax(),
> which I think is better.

So, that's a good point. But, the return value being stale also seems to
be incorrect.

> Regardless, I think having the same behaviour for the two implementations
> would be a good idea.

Yeah agreed.

As you outlined in the other mail, how about something like this:

#ifndef smp_cond_load_relaxed_timeout
#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
({									\
	typeof(ptr) __PTR = (ptr);					\
	__unqual_scalar_typeof(*ptr) VAL;				\
	u32 __n = 0, __poll = SMP_TIMEOUT_POLL_COUNT;			\
									\
	for (;;) {							\
		VAL = READ_ONCE(*__PTR);				\
		if (cond_expr)						\
			break;						\
		cpu_poll_relax();					\
		if (++__n < __poll)					\
			continue;					\
		if (time_check_expr) {					\
			VAL = READ_ONCE(*__PTR);			\
			break;						\
		}							\
		__n = 0;						\
	}								\
	(typeof(*ptr))VAL;						\
})
#endif

A bit uglier but if the cpu_poll_relax() was a successful WFE then the
value might be ~100us out of date.

Another option might be to just set some state in the time check and
bail out due to a "if (cond_expr || __timed_out)", but I don't want
to add more instructions in the spin path.

--
ankur

