Return-Path: <linux-arch+bounces-13181-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 341ECB296CE
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 04:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20E233A88BC
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4077424676A;
	Mon, 18 Aug 2025 02:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a628YIOx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LMCfsPP9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763FF245031;
	Mon, 18 Aug 2025 02:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483268; cv=fail; b=TTRdEkLvxm07UxeP49suGunlXsEkjKhooQA/J8/J23bIH8/wisgbfelF+J8wITfYKzbtHU/DVNH1A3HhKlExqroWBmPesOj4prlkOOL5lvUOalYXjAFM058WRggq+vsOuYcSoQ+zCf3GiJKiSrpaNSpbW4kHrhzTrLAFpl4RvqU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483268; c=relaxed/simple;
	bh=8tEiKj7erKTZT4E9GMZ0SHnS0FsKf/l6zkaNJpT2k5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J7aGPgLiM0xY3exY4sTUu34UZyOpEmv8c8eXW5BeG6cAZJdHs4WUOW4OLvWz9JHcY81thcF+YOb3iAHZot4J3onx+pXHjzh9PA7zoa9Rb+/5VWLCbgfRIWFvhuTCkSMoCceZIP5PwHfPo6cQQqA6R0GVzaPKmPyCEgEszWV9qN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a628YIOx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LMCfsPP9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HMcH4j023425;
	Mon, 18 Aug 2025 02:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=AALHXy8+ZIvViZx9gVr8W9wQkENv91Mv0fp3NGjmn08=; b=
	a628YIOxNCAIZqt5zhgQ4cC87zk/jgBoMoiYTCEqWcrecpCPUws84l2iXqaZGmPG
	IVL1KUkKAtOg1N8maDQUp7eUZkIREDKwsAwZUsR4k8FEJ3XyLNQE/ysA0hIfZuar
	cHW3b3GIDxBQ4mQ5D7qFEaAId9NwhdyAbZwz3bhwXzIS/EVi8Hc/XpYddfraxGnZ
	6W10eQlYnPpw1Z0ckuzMsSYqemr7q8ICt58s+1Xr5Ihc/AYnQlrBW+QNf17Blme1
	c9cGcoiusadsnqezRHeiqEW3GlRGOS/cBTbRhZz4Mq0ngTNE14lSJLaVKNADfPvB
	fqOXxMstfZImAjIrLIywoQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jjhwswtk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:12:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0UoqW036815;
	Mon, 18 Aug 2025 02:12:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge83jhd-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:12:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sKrO4kSW6of7lTQ2ssRbjVYlwm5bHiRSXa+1eGyNpBXBMb4tZHEhQQELCyh420+qxTj9jUZd2qAXfZQr3eTPnL8ps/41n/3GuIEn+RS+G9vBVlcg7hMHBSBnBHfdIYXAcx3+Zragmb/hLM57rs59npv3eaae7643VC+G9jmCKSy0VCmnSRYJRFrKCD9CxxX3yJs9k/jd5NaNWEbfsxZg6B9SIjzEOYEhrq1obsioskK0B5Yvo1pds7D4QS+wNGWCDkgpFrXXjuU3SEgVopQ1z2c3QsPQ2EKB/yxx9cRJOd66qIh8fPOACW7JTzUhE/POkmfOpQQTGZ1UhHo/a25ENA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AALHXy8+ZIvViZx9gVr8W9wQkENv91Mv0fp3NGjmn08=;
 b=f8AXNAUSxqENzxVUd4t3pV1ZYfLGsm7/sxm7QOGznPWL4f5liP4/iVWEcyRAk99MZdANl4lWP3xNr5iVONLjbRiuQt4KMaMBH0WDpq3nyoPiOp14JcQngEJlOzffOZjKn5hCv7mExu/noEnhwAYvvlaga84VnEPYUE35e0IThyycya14Mix+7qZhXohaEuUwBR0qMo4L4FsIh51OykOC81tJ5zVV5gwxu31qrtljP1L4TjjO2SRuIYjO/1Bgs5MdUTP8YR99azvoX/Gs/83XjRTf95NGSDCMsQkRTTf8t9IgD4WmSnvGxLE88IdL822rPXv36RDYy15WhTerYAlC/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AALHXy8+ZIvViZx9gVr8W9wQkENv91Mv0fp3NGjmn08=;
 b=LMCfsPP9ECQzB8t5A6wpsqXjB0mOtsqistUOobZXwnlzTJ0xddQR/Pc9TF9hWnpwYwiy2CuMqXZjeIFIBaFVAKxtN+sVU3GKoALse34WG39trV8bctLH3FN2k5H0dKZZlfNRbYtE63X9Ms1q21mjfaQrviwn/lvUYtaZBl5xDPc=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 18 Aug
 2025 02:12:46 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 02:12:46 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH V5 mm-hotfixes 1/3] mm: move page table sync declarations to linux/pgtable.h
Date: Mon, 18 Aug 2025 11:02:04 +0900
Message-ID: <20250818020206.4517-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818020206.4517-1-harry.yoo@oracle.com>
References: <20250818020206.4517-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0152.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c1::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 08de7369-9b22-4f01-bdda-08ddddfcb76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?608b685IJCrlptf+/MjITeKXhE750nEKOMNIkqH3ibvmry1h8d5QC3n57d3s?=
 =?us-ascii?Q?IMJtmGe+1BegnobJxY67z+rvxONd6U8JQhIXM8zCXz/zL+s83trjyny95iEC?=
 =?us-ascii?Q?X6dw8gzcDvhb2vYhukVRx9lHeJP8RP1AftZvrZtR/B6D0q7WdiIfkJCBWP9H?=
 =?us-ascii?Q?FnhtfdZCaLGxBT3Q+8l1bE5POkZt9oprPOJSI/0tDL0SMJWnULY7QQpRt+nZ?=
 =?us-ascii?Q?Fjm2XrpfaOWc0D5IdjLmG9K4YThtP/Ug67MW2g+3zZD6BoZXvn2oJwFCHXF2?=
 =?us-ascii?Q?FEC3d9AiZ3IeBmcX2VjP/gDxYjVsikmEr/ul2LVBpag6lGTf+RWhnbLvwVGe?=
 =?us-ascii?Q?LIIpdtUlLx+/dMKbY3ROZnS9qbx9lkpai7ytCmfCnnNqhaw4DdmtYzSfCR4E?=
 =?us-ascii?Q?plbZZXbA0XGQZhAiImtIJJLsoZzml9FXSIXztVbw/pGgUWxb0CtaH2mUNS0y?=
 =?us-ascii?Q?NhWsqDWtyNnVVr0YAYGltm8hdAvZ0sjv7uhy/QR63XyS95BvL7hM20JVl9oV?=
 =?us-ascii?Q?FeH8b3lkQS0rMpe31DFbGtaPEG0+BaB3gO5qxfJxeUw69VQInia6Z/S9AHQm?=
 =?us-ascii?Q?TlN2ogeI9T7jknTsNGoW6Xp6/GZRpWGUawr6uJz/QmeeRDwk7NP82WyOERLf?=
 =?us-ascii?Q?tp9rzB0vLB17oo6op39wrE1ZZsglNW+HE5TDdQGrRKAy09JulzFLpPsXlwC7?=
 =?us-ascii?Q?KflpOeoPZNYX4OYBQaonjgLZo7tmFW5PVZjKRb20wG1wlum7BznrADMJxtaL?=
 =?us-ascii?Q?D2oU3v0r6oyMvgLRVQG1RE0/qEot4muDMbVrzES4VktiQcAdNvebYQ0cVQAl?=
 =?us-ascii?Q?ugPTpVzWDrvbuPrC1Ngu9UjogXGqQcKqORJqT4MQhQIa8oscq55V8l/UhjEN?=
 =?us-ascii?Q?32M7kVt0NqAMSxhNPQzWwF7DvwJ17ZaA3y56FeXVyT4ZALUGu8HjyagkXav1?=
 =?us-ascii?Q?ftyCkvRrw0S3P6Mhf5oBufBpTuVBIh7i4G9QXrrbE8o4n45nVEwoDrJ8IOYm?=
 =?us-ascii?Q?rtMl5eYrprBewalCiq3x6rYIozpxHMer9ucvasOFHOA15d7pQnmbSB7aOVOq?=
 =?us-ascii?Q?vwcT1s4YhGCs3EmkmbKIkDXHNuDsZDLbH7cJ5+fh3O8rgrjOLQwjWfIL4tgw?=
 =?us-ascii?Q?H5LVXM53SXegbHz8rO5fF62as9iizxfkJuAFfH8w8cGawUtMWKXiozGP1WEG?=
 =?us-ascii?Q?7Lxx7M9QtKEuJ34l/1Y22HLswj9fFET1AxotPlCyzdODhksMhwSx5fbHgQrv?=
 =?us-ascii?Q?xXUfOvybllToS6/gp/rd1i6xV9w3GZqpgJa/YEVCZBxIaDXP9vC3dbFsxdU6?=
 =?us-ascii?Q?SiQZNUOQ3SIBbm6hIgf+pVa+c522eGMQmU2U+INBJ5FIKcFXAaGEbR0JNkQd?=
 =?us-ascii?Q?br39quPZPBX1xtdKtkC16t/9xdLA3ONec+ykSx7TtHL8vnTHjYOOo/XTZ0p4?=
 =?us-ascii?Q?keESi3kE+5k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Olvat/FGZzibFt/cZ/0UNo+udbgrB4H2r8vBCC1NS+b7EAkdYaluwoemrcym?=
 =?us-ascii?Q?lUytw0V9ZJ2qkchkTCgls1IotBC/HJ5K6aqD2wpO8CU2kg/a1xzpr14L/PiO?=
 =?us-ascii?Q?tX6ElGC2EirZBgGWPh5G8bFlw4t+RcE9mLqr+c5Eusi2jDVyhKC41LKxVRHs?=
 =?us-ascii?Q?aEe4mL6ns/jzPxk4nHc9VDvfboId4mkf8kUzIAG+5nltRlGOzsJrvv0NAUZj?=
 =?us-ascii?Q?KNmqdmfh+wH00prTreO/C7DhrB9nMm0kRhXiNSi/WS2Lm05qv1GDHHP/zX2u?=
 =?us-ascii?Q?aQ8whgRY0IAsmN8uXK9aSl26p7jyV6uOPE+pZ2WXQ6Y//rO5nsBnR8/rncSu?=
 =?us-ascii?Q?ElafLAi58gstPV7eI5LsCuefV+aDro+8Dvylx797/dS97Kq2qCiMkpv5qoRn?=
 =?us-ascii?Q?Nfl54EOHpUWVIA/CeE9HId7/2DmIRPr96dTdTmcN726tG7IHxb0KZ9JM5GTG?=
 =?us-ascii?Q?lxpbVwkDJ1WSKy3bW0IxGef6KEdjYSrcc9YxAQHxbd1mL+oTDyv9QFJu8Ho1?=
 =?us-ascii?Q?5MN3KGxdbHjYkJ/eJyjSXkcyA+FpWEdTvJJNh74eSmkdwOdMI3Pi9s4WlW2i?=
 =?us-ascii?Q?/mS3kFugkwWL0rrRPy4TjJPYye1WJBf0QFGWrcLjXV9SvZYsjdSlMymb0CaV?=
 =?us-ascii?Q?czjr2JrXZ8En1/WTxNwFi9tMnykVNICk8jELgBVLN6h+NLo8epoB85QUg/ey?=
 =?us-ascii?Q?X1e6D8A15SUYNEXXdk+V6TuAiJEbKudd7JXmXj/6roOrFB51OOHure7Lyjj6?=
 =?us-ascii?Q?6hN+fNyx1a6l6oOQ6DQJ6DlR8PkPmE/gcQbouDvs1sFe/AnP2lWNZ2Nb7y88?=
 =?us-ascii?Q?J854QHNpOiLHgE3j14m/CQkutgVhHpp9SSPYvZ69RrSIynFEXKTMLNBatgoZ?=
 =?us-ascii?Q?XGzBr9GavZe5bSwqhL0+E5xDIPpjRdV48cmujdgASbCLrgmykYavQhLjrhXm?=
 =?us-ascii?Q?s00+6PvgB7MfoIsqk3ORX+WMGuhVNX8dOROVu7wOCkezrRNjA2XkxVWvoFzY?=
 =?us-ascii?Q?J9xAem+2F5Qg/HAFOejEJ62Hq3C7hTacFRbZzpsidyPRJKwNeeH0TfF+SsjZ?=
 =?us-ascii?Q?3aYmQg7Dck2CXkbJNZUdtc/O+I2q176f0OcNx8qx/EC8R3vCvjUy1vpGsHDp?=
 =?us-ascii?Q?tN55qsDUJk1gDgG6i1utQ83tXtyqBCJvf968Y/BojMpthMKWCVBjEa14wiBa?=
 =?us-ascii?Q?h4KlcXbPS9MXyaf1DxU7Hio+yO75zyaUEUBOyUGUeuGF2YEEfZeGJTHkS53h?=
 =?us-ascii?Q?mhZDIwgzxJ0s06Cwsr0LpGwGsoJAhgSJNkQoWIF9UPZgRVuKoG/xsqWzwJp9?=
 =?us-ascii?Q?D5AW3cnahkjNbO3CDQqdRoMA2tW4qs+u3MiRBgCXAX4bqPUWuuF9eXpRMHeA?=
 =?us-ascii?Q?nmWJRFuUcQUHOOWvwUAstJKM6b1ztmvbHFHAxem3jEOJhHpkzp/rH1B+mXO8?=
 =?us-ascii?Q?Jw6wO4az1vVLWW6r3+LsXSoHhZ/qjK9Ybg/IfiLcHsKSq4eD2hgXxxJeP3XE?=
 =?us-ascii?Q?YxOBy/W/s3vzx23w61og4hjKEAT5jwsvA0J5diPP1im4yoTuTGKjf41vLp+m?=
 =?us-ascii?Q?VeLyubHVrRTTaWS9HGSOs0gIfny+R56zy/Cdc30h?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Ukha+xjmHBkmGITPZnTa2g2BXitB8cgiWrFgXyZMbGG4acOG89M6M3RDO4AL40gx6J9i5ofWT/eSiWMeVKNj27e3GKmEMAQwNhP4Cv/4ETs14hKe7SRLCvsFq/HjHDdkfXfZJc6VoS31QGJEc4ivDnb9LeFrjJ+WFfPo6VoTNrkHnIKdGtQAQtVPQxNamKR6DfthN1KLw3Cvt5QiOpxHgt9HFu28Hcz+kKn+A4qcxeNGIAVOUD7Uz/0PEFSTC3uJTI6wCHxgGNT4Vo10R589QQ8uqktJsWdWVdInc2gJJDiKsVdTxL2kB85FFr+u0CXiHDggOi4q9k7g9kX7hlXnY5Z9bNXl9e7VbwP/4rkDAqi0iqFYm5mIddvBv4fxiHrWCgZ1udwPlCZNehKiEpz2AYkDDjrfh8K+vEYXGCSk4AQjA8B0VJd/ePvatIZx/Ex7owh7h/hKjH27OTP4PA4188/5Gms2y373dP4Xg1hGj2WoAVQXHr1RiDEN44x+JPhj5w2uF7iemPXME4LNcCSEmjhHgKXWiQmonacF5zfCSrGonETKyKiBrHhc+8cNfiQIkzQq3GHRGS4Jw4nFewX7M2DddqKHPi/AN+6Sw1CTxY8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08de7369-9b22-4f01-bdda-08ddddfcb76a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:12:43.8846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nd0C2lnR1ODNPxDuYtuvSqceONicLhkHOZGORLGWQmukKnszjWIQVydlpP7m2jGo47lNljufYfwI+CS5NMCS4w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180019
X-Proofpoint-GUID: SGzPW1tRiacLOGpkoH8C6aKobadynxno
X-Proofpoint-ORIG-GUID: SGzPW1tRiacLOGpkoH8C6aKobadynxno
X-Authority-Analysis: v=2.4 cv=G4wcE8k5 c=1 sm=1 tr=0 ts=68a28c23 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=uplis4tbhEJsONv_2NwA:9 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAxOSBTYWx0ZWRfX8oBk0LBgrWM0
 +cA1mH4lbLHGv6VJmSwfhTWD056LtdeGgaBCEEbS7SWhto/iCGVLthKjwB63T7ZMuqejEfCiBT6
 nXL2bwbC+ocnXaOb+kyHsx7FVL7Ap55XQHhnSHTsRlp+h0fMrX9LXIm5uQ3c4W0u9IpyrehSUHg
 gz+QwW/TmLk+SnNQzAKftvwkqJjW3ODCOJQmJXNmNTD54JNy0vRi0YhPHu47Cmq49Nwqf+w4/Yt
 2bae34WCVw2hRfyQsG79S1dZmF2X0dQczjQsRFeJvV636+U6P1KHFy3o1eFaBsOcoKKy3xIOE8u
 2LcFybzssxN6PkEO2/V5WbaPOtoIuK8iNYOuiR7IHIcnlTeLiRnD2qoTuUpS2NFZEzoeJR47TSL
 O7/ze8uTyxjxGPgIMkEyEXJVv4fnu+0683OdffWNNGKceJQBvZLJ4GlsmCMxiFK/wK4x2JDs

Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
linux/pgtable.h so that they can be used outside of vmalloc and ioremap.

Cc: <stable@vger.kernel.org>
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgtable.h | 16 ++++++++++++++++
 include/linux/vmalloc.h | 16 ----------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 4c035637eeb7..ba699df6ef69 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1467,6 +1467,22 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
 }
 #endif
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..2759dac6be44 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
 
-/*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
-- 
2.43.0


