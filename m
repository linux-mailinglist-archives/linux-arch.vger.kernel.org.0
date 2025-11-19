Return-Path: <linux-arch+bounces-14955-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A48EFC7060F
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 18:15:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id A1BD92F698
	for <lists+linux-arch@lfdr.de>; Wed, 19 Nov 2025 17:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD893570DE;
	Wed, 19 Nov 2025 17:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oijeQUC+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xhtMWFTU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C278630BB8E;
	Wed, 19 Nov 2025 17:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763572514; cv=fail; b=d3eVQq/NM9TX3MyvmfHLOxI4nnDaj8M9bVLgR8H4Yzj8O2gOgGo6uurWkduDraepFOyrzxK576lLzqUIWkxT+wmlwBJem3/94l36IQnODDN2i4idDTRYlcnHo74tJOmpm3OxF9YXQxY5R36UsWF5Gecd+TYgSUtggKFaetFw/YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763572514; c=relaxed/simple;
	bh=OHgU+yFaxAMSIjrn2kMgx0Ht9GcyFqy9M4MdzpW5p64=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FMUYqd5HWheVOzjUu2ksdhKaugk1vb/cLSJ4C3mKoyIS5mKGlct8GeSqma1Zy9ll4rJYmuTaIAmALiXMroatUznw0sB98diaJFN0xYEH75aTkIJzsYnMpmowfmaYQAQ9a8ErDtQEUFOUN/3DvB5PBMziPBLRYEUhxY+3VIR6hu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oijeQUC+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xhtMWFTU; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJH1Jdn016724;
	Wed, 19 Nov 2025 17:14:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OHgU+yFaxAMSIjrn2k
	Mgx0Ht9GcyFqy9M4MdzpW5p64=; b=oijeQUC+eMzn4r3GslYtIYmnEY6Bvh1xr+
	Kku59Uae90l20tDORBeMtDgDj7IeL0zEVQvQb2nHzrcjH8Z4le65IGWHf1m4Q+wF
	dhkEp1lO3e7PMAesBVq2U84s1REJipGqqeQ9/RYC/yeZtJMx2YXevGyEH7lr1hMN
	ANE+iagVCOp1P0Ul1oj1btY2UglbcIvnFGskjyWX+5b/wd4xejORwY7UBLXtmX32
	Y3NCZ8pyo5glJHT0hivcG/9Pgycd+meil0F4lnsV+/bb5uTq9EC9y3CWSl8/yTF5
	UrGR/xHTUTLm/uSorqXZnpU4rWMz+ftUiCGXxI1nW8c4WoIbOq9Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1fd7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 17:14:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJH9md0002564;
	Wed, 19 Nov 2025 17:14:42 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011064.outbound.protection.outlook.com [52.101.62.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyavxbv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 17:14:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WeQURnK0mwAkz3cdpqE57reQz7D2wAZq3dDHNeIKHTL8TMOHGHzVpUdIfwsKRp0Yphh4jykSEX07kjOyIaTPDewrSwDbc9VIMesRksqxi+qJQ+77aa/QbHIXHskQmIUHYd9WZVeYSCYVF0TkXDxubCTfzLy/EcgQdL4vo8T2K+nAh6vOxhN/wHOCmCxYe2sF4fD0IGm4wPW1tA9NC6Cx7SYXLeXQZbsBGDveKpNwz+eyYGQAoL1/GG1e8HxypzU2UU/ntG1r9nj0ZMMF2JR6FYLLnYY421BHvyn4Kthg12NHwdGKe3jdmMAzZrdZN1kHIq3fMqgACAnHyyvcWnIBHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OHgU+yFaxAMSIjrn2kMgx0Ht9GcyFqy9M4MdzpW5p64=;
 b=IXg5zfJP6HWQ3rcRdrKcBC8O+FnyVXIphvLfYDs078/iPlIN6+vsFI3mm/+Cf2TBKhzwF+eOv+VW/tr0ggH2PLYk2mKA4jp34Q29sjjVky6rw1VgwgE7gXcfNR+Mosgsx+PGCF+HcjfyWmWrrJaHmQ3qmkaWK9uu5ShQPpKk7DCQ1v/YknVYtDI35Z+zaR8bFWmHwRky0aZ6pX4cIuyG2BuR5CM5NTYeN52rPT2A7c5UlaqBDcJ1ShZiP/34vojOl3h/oOtg1YekNvTFPwjNBQY1NKAQ4NZxh1Yv2O4tB1ptC38R+M7BcDgAZlLNT1DFFcbsfYS9/K78wySbvROD+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OHgU+yFaxAMSIjrn2kMgx0Ht9GcyFqy9M4MdzpW5p64=;
 b=xhtMWFTUpgSi/pIr/X3jATg4RMAPDhAZhnxXO9HwHCWt/iGVrGlC04PtUWlmGfVXMn1PnVGRtzzMx/4sJurdu8bfYOK3eWoRLVdGkBNgMVwJX2WfSLRhHggnqRzPiJ+5oCIruU3RosmJbfkNh++dFZCAZz2/0yJYX5O90KQUNE8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CO1PR10MB4530.namprd10.prod.outlook.com (2603:10b6:303:90::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 17:14:39 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 17:14:39 +0000
Date: Wed, 19 Nov 2025 17:14:36 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Eugen Hristev <eugen.hristev@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, andersson@kernel.org,
        pmladek@suse.com, rdunlap@infradead.org, corbet@lwn.net,
        david@redhat.com, mhocko@suse.com, tudor.ambarus@linaro.org,
        mukesh.ojha@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, jonechou@google.com,
        rostedt@goodmis.org, linux-doc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-arch@vger.kernel.org, tony.luck@intel.com, kees@kernel.org
Subject: Re: [PATCH 00/26] Introduce meminspect
Message-ID: <dc9a8462-8384-4e9a-94e1-778fc763fa9a@lucifer.local>
References: <20251119154427.1033475-1-eugen.hristev@linaro.org>
 <6c9b0aa2-820c-4153-ad64-cd2a45f7cf32@lucifer.local>
 <19171859-94ac-4f41-b100-70a1497e62e6@linaro.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19171859-94ac-4f41-b100-70a1497e62e6@linaro.org>
X-ClientProxiedBy: LO4P123CA0384.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::11) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CO1PR10MB4530:EE_
X-MS-Office365-Filtering-Correlation-Id: dae8b7a5-c73c-481b-55dc-08de278f1f32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?13+BLWryx0nYQcDhZo8N1tHjdwWYbshCFRKf/5C945PjOvPaVeAJw4SWRt9o?=
 =?us-ascii?Q?uTM7F9ylQsLr3NeBduYkufns/oQsVu8DN6wJfgU5tz9uicjHQOm5Uz2iJlzp?=
 =?us-ascii?Q?pNkUVel92PxYbWd/9yi+TReWF2+nS7/5lE4GuFCuNVbxl1OjASOPtULPRL3X?=
 =?us-ascii?Q?SmhrsiyDIHlvgANv/X8CZKzAXmMvEkYas4hKUkGIMsPCuP5pBMnaU2OdcOA8?=
 =?us-ascii?Q?22lv9sybCIxHli5+cILuJhzcIHlj9BPlWNtcoJQyjPK7bIfBzao2wVvL8Dx/?=
 =?us-ascii?Q?MZkb3bJZ179GKnjBDO0htpGGIniqgXcrVivNDwMmHfxqWn81AVEBcRUkMhft?=
 =?us-ascii?Q?QjD1Otc42D4CeoPy7w26w6xj8BDlRsZJ/iebxuCmrCgMTsrDIOd7A7UkLNyE?=
 =?us-ascii?Q?lzyKfv256aiXP/+6h7P0ErGUCfCYh6f5WMPEo1sQMxRfGZfTfE4Ccsin3frf?=
 =?us-ascii?Q?BAvIbLZ8FFDNkcIydgZWQkRKCZ0xtR6ySAfWw96H6YrTstYTiU418BLhq4ck?=
 =?us-ascii?Q?lT5U+NPfKq1mVgqFzF77W2FDASWCkr3d9htN8+T+1Z71DFw2w1vUrP2Jv32G?=
 =?us-ascii?Q?lXJVigniAi8Mvah75E/eblmO+w9SF7ZRi9+TC86zQlt0YwYG6WKBDznF9cid?=
 =?us-ascii?Q?9fzhrJG+stxq2btwNzEdB+1tHjoAbQTKOTXV0+GcPXg/spIZKRHJCqGlF3M8?=
 =?us-ascii?Q?yehoiWK5XdSpRjml02UExQzORXbJFxzszpF2MahCWCDRtebyUNaMadBrxySV?=
 =?us-ascii?Q?ifpjc8sbYtNVA989BuiarprjJiF4c7Kqxy7StRs+Wh4lw621KA87X0Z4tGHw?=
 =?us-ascii?Q?yoCVDHA9Cpbiqt09TQyOq2+45rg+5O/jEjDlz9JFkCwvI+S+ACpLvFVjRQ+o?=
 =?us-ascii?Q?7jcT9ENuTYibqjtVu/l1G4DZGDkt/Mxg3n9lar4pRGUr9xMmyGTdpzOt16/I?=
 =?us-ascii?Q?wG71qyffms1NiDQ41wA6MmtGS+vY9HSR5sEUHi+ajdm7hW9fGKHFah0FA0bc?=
 =?us-ascii?Q?CKmL+f3DY/UDKwLItPp9y9KRzF2LWii3/qd6mN/71gkw6M8YjEkC4ZansGR8?=
 =?us-ascii?Q?GQKa5tvqqBWTGVaY+XA54hTy2om/4YeUHp2asyLHyNdBUF6huOUk7ymHuau+?=
 =?us-ascii?Q?6JO7V8aUHgnIMJbtYyJecVOEg+ReUTl+eZNlPlbpEYOcoo8Gx1qGVieV/fN6?=
 =?us-ascii?Q?AjiKFfkZ3emFkDao7p86TdD692oyIUg3CSbpZR3udI3da41/qFpZL+mavT92?=
 =?us-ascii?Q?9arN4JYvQlkhyqi/m2O8dIC/kQYIriWsHWQ7/CxVZ7rko/sgJCIPpWfpdBqN?=
 =?us-ascii?Q?GVaHmAxWkq9ukXuLcfrTU8j/cAbpbS/JAe0ZNxQ+3HMlCy18z9ISHhiq4eFr?=
 =?us-ascii?Q?CGosqZlFak05tkRuhTkHYRoRZeErHVLUN0HzsqzQTcQEqJbNls3uvvRxEzhT?=
 =?us-ascii?Q?Vpm/GheTfk72ymLSLBHeZB71P6dYLo13?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6iY72JSRuvxho+V4s4A0lSrm7mi2dj49GDEZGoH+Zhn5UvDYwz1/sqQYWzvl?=
 =?us-ascii?Q?TqAofM55+HCe5XGnDPr6J89LXE6cKeB/90Ut6kc/xpic/rghHBRJJ1FO4o/0?=
 =?us-ascii?Q?R37gjmaWMGD/kEQga4V9Rc1XVFfrerkZ0PyXoDJ9gvufq90+j12waFz69WKB?=
 =?us-ascii?Q?ILxoEk6dVnNilC2qeFdaNDvN0CHwxAhY50tNFRwJ7L/YDAdSc7spLsG6CV+9?=
 =?us-ascii?Q?LGlB0Ek8YcQ41iR4xBFwHZ+8qwk3P0NlEPSWGBiHcTB6RHPdtn1+4Ujh6IkI?=
 =?us-ascii?Q?XlecNVLpu6rxJciq8K+vxXMBYyjJgxY1oNRiVpPxr8bTl8aFhJWWDe7tds8m?=
 =?us-ascii?Q?zetIUygFHfcXI4LMbsDuFvdir3NySjjZlDfMVAnZP65b7dTfbdk2PmXZoZE6?=
 =?us-ascii?Q?veOKVe7yEVN/z0qm4Fugf+nV1vyoFMRjGgCVbVcDeCFW81RyKiQWH/rTNqDN?=
 =?us-ascii?Q?Sph8ceU7Z8Kdv5X3UWl+rDqF9n4XWeh2LNhiAl1Bk8f1NajicdCkmkeiHU41?=
 =?us-ascii?Q?ZwBJ60zICyqzV/mCTZ4w7evvB3BibO6LatwmQmP5p4J8uPoPc3igRcp4OxNC?=
 =?us-ascii?Q?So35sFFxfYaZibdkCnnmfMUE9LF0AaXF+jEf7ojoBrqKPk1pgWC+HmYNqsA4?=
 =?us-ascii?Q?ij/ly1WoTcotO9qgAGQ3zi6sZXUDQXv2uU02yZwaGar1HYZhO3jtaDeSphE0?=
 =?us-ascii?Q?K3KKQsctojw7HNnameyQbPJhdwVpqmdjSeCmccw+EuxG+VIa+tb9pZI/ypck?=
 =?us-ascii?Q?NeKxmOu7mnOlhRPElcwxi6ADUSXmGRRFdgLxuKATti7eAPXDcALfNj/QnyoH?=
 =?us-ascii?Q?eyFpN2GIkjIqEl04fkDpXdo9Ni8tDf6eXFxKA8rnNTEytAgAbzs4FhVCqWnX?=
 =?us-ascii?Q?xxkJiOU3St6emTT+LbfDhztVzWRYFr3wof19t2n/IJfIRMvtFUK/bCsyCT4k?=
 =?us-ascii?Q?4vGwFtlievb1040KlmC6vXMLhuKdvPniRQ0+5SbyAUSXgvkhNcihJz3vAYz2?=
 =?us-ascii?Q?ATAwopC+T7YI1nyzehIg6o4UrdgnC4IKN7Y42MqkTC6yeulG/7tyNdW6orDv?=
 =?us-ascii?Q?v3OM6nqGFKgjylhsM8gWWQCac9dVYwTGKKkzO1axWMpNIqiTKDNDOvNCpavG?=
 =?us-ascii?Q?uRJv/LGtqCLfzmF2jQJpOGTwH6kb2rN6TswOp+WNYM4IAwF/pn6ZYla5AeWN?=
 =?us-ascii?Q?PZ2K4ZgQrqkplsD/OHKboKpVTIX/Vv2AlCzjtZbDPFqHsfl4ZY7M1+Kkya65?=
 =?us-ascii?Q?WbfSnd0qt6Jj/HEIBjnG2TEkn18Tag6lw7HFLYv8qxUwcZosrVkcTuY88lf1?=
 =?us-ascii?Q?adsZRmWk5DpvjxxXSpWgHyo/iFU1fUECSEcjyzwVqOGZHvXF6dEkBGqm89y3?=
 =?us-ascii?Q?9PFXBWyArOoEbz64Oj/5uuchjvQ/EQ/YU5mQo1pUKSFS/HPm5uOUbmEsh90c?=
 =?us-ascii?Q?baWuxgmxChgUhztLbQAQYtr6RUPxMLrPEtJcr1/I+mLIj+C4rlYT9qdGTFng?=
 =?us-ascii?Q?T+YfSZmHjTJS/STCIM81nfWIeozH76FypV9D4D/VZb3y+Bhmqr+jco/qHy1F?=
 =?us-ascii?Q?vISp6CZ+JJhINPwoFSqF+HKPaj+CeathqQEwRgJWskDvWPLerPIOYWjHYOiU?=
 =?us-ascii?Q?4Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9cEMGn/URQ+X24sX2Db8v7WiMYLw9GtqDMYV932ZQ7Fx4yXkzBkWIFSgoKho9SKB9sm5HeYuK3Ha72n6JEZtELggWSFglDbXbSuEDznGg3fTBbUcWHhwjYS4klNDlb3crTxjzam8lCRf5K+graK2LHi3zwmleTrnMG6Me44YoaFTxjk2bTYeh/Kjv6GRvguctnKagTkPVhPo1CCkwMr+TVVL3/YfnNnN8rhvmABxNiyQ0yRdudaWjDNTw6N6owlm4k5a66hANGyagPG4RUMhzI5BQE+CKKn6PsJyjEI/4b+3mbWebwxYi7LCDqgF9BbBtteVMPlbZxA9a6moEcLch1dxp9bwOQVoO7ZKkg29GrdMKptJy7CzYG9pF/c7gFgABZ/LiWzVoT7YP7GA/0MS75HD2CV1N3khtoCvZ3m0O3W2xcWCxUpqits9575YCUqFkO2lfDUGMWt1Dl+Sm0MHyONTj4Smokg+8M3v5vbqEQryumRObGCunGH+ahJ4UErBqQgUFhiFZJhXLEtinXACDgCSkH1KnM5WtIipxjs8tk/W9J0iCRP0tFvA1F5QGuH53MXzuNaeXl3hdma7c9PcmJUZUW0cxsLgkxP/7I7tRc0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dae8b7a5-c73c-481b-55dc-08de278f1f32
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 17:14:39.1337
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IO1GB68Ezl+NF32WLLhNuuEbJ0whiGGJYNEcGgdujWOVAr130ijMGncugbzjxFyZKqovqJXLCVQF959+3b0fwEZ0OgvhN/r60RktnncztLY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4530
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_05,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=625
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511190136
X-Proofpoint-GUID: KbiGKOG_sZUhF1nMKgeV_EvOCQOOklT-
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691dfb03 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=DFHqZP8h-1iw00YpLt4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX7I/+qZYCkywD
 /NoZX9hLBXl5RGvQGnHz7qOAz/e3+c9RN+5wWpyg0fi3nD1UyKXq/AioxOPCLT+Qan4Tp/FPN1p
 nOPfOoBxAePGErymRPrFMkiu0MayoopLjawRpqDmEjbHhkUpt+W1nCtz+zuNB2tnqcAETUqdYRn
 0kfN+wJqXfddKA5lReFvMFCP+/tcJPVfSq1359LSGKXqVBBTy2kCYqu5CNAjYFqp/evcWskcKjP
 MRPVUEp4zGp0Z4fyVZFitr2OYvRBUkiIZ/hFlhxQLpneotGX/H4IttTydOv4Rl58tjaqGhnomhi
 WuH8ck+rpJvPtw55QXqtNl4gA8Dm5wilP/TlgcDqtgnm+t6b+v/47IhgEyRjrIIuYBC5hyGLans
 2gCsTg9VW8WqKMxgH6q+hIR0kpMAUQ==
X-Proofpoint-ORIG-GUID: KbiGKOG_sZUhF1nMKgeV_EvOCQOOklT-

On Wed, Nov 19, 2025 at 07:11:23PM +0200, Eugen Hristev wrote:
>
>
> On 11/19/25 18:30, Lorenzo Stoakes wrote:
> > Hi Eugen,
> >
> > You've not run scripts/get_maintainer.pl so this is missing a ton of maintainers
> > that you're required to send this to. This is not a great start for a huge 26
> > patch series that seems to want to make very significant changes.
> >
> > Please try to follow proper kernel procedure.
>
> Hi Lorenzo,
>
> I included the relevant mailing lists, but indeed I have not cc-ed every
> individual maintainer. Do you think it would be appropriate to resend it
> as-is to everyone cc-ed (PATCH RESEND) or just do that for the next
> revision ?

Yeah probably fine to do on respin :)

But obviously let's not land this without at least 1 respin/resend.

Thanks, Lorenzo

