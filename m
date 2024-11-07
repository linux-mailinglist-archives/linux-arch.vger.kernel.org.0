Return-Path: <linux-arch+bounces-8899-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF219C0E7F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 20:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DFB5B2177F
	for <lists+linux-arch@lfdr.de>; Thu,  7 Nov 2024 19:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BFA9218940;
	Thu,  7 Nov 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EFDl42AA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FRfcz6Rw"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834E5218322;
	Thu,  7 Nov 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731006564; cv=fail; b=onsHGRd/28nsU3NTYELPaM5M3oENjYk34MApNzWmWBt0HJe7rJinyvGa0MdTSW32rjMh2QSe6jafwbl2MBSMVRAnnIsD/zvjpmAoMY9BJL1XZwbOGzI+b/sHTnSNLfePY4mZgFYfxl4CtigMDwcKwiDNIUk7lL89wyawl+Dw2Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731006564; c=relaxed/simple;
	bh=JYn5wVW8/k2YULpQUQWZW2RCzfJBbpHpkZ6dIdagIZI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=m3W7hQq5hw1xijKyp2GRDBHyKbMMKfNci8Sj9cKx0sRImXeYUaQcEcASNB4m5mlMm+M2YLREiVP/vR+Wgj7Bwq7sWSOw6jtUYJ/v3jL5moUAUOqI6YfNy1XXiv9U/4fyVwxTbtx+BaCp35cuhigU3g6KGeL80MuZGAzwtr1KTBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EFDl42AA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FRfcz6Rw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7HBd6s002605;
	Thu, 7 Nov 2024 19:08:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=QVSV206N3GHQLIOxxufrNmI2FZJL2ktslxGjHp7FL+M=; b=
	EFDl42AA8IEjLuJqGFYM1drzrCOKXvxNhmRAaNbH61BsZZUmU4p6kiON623vSN5m
	eUCIKKCeXsU9TsPWIt8xQf1OgkzafzNcIn4Hk+49e5bWF2vw9PmOPR3DoxdC0MxL
	ZGfRsOAp9a68a7mMpgAgVNijs0ER7GQRMIduYUzVWcb2Btt84xZE0R3WujU84uQC
	VIf8Mbw41CxJkDrUHT2oAQzQwce0XHplxSxwM56scvZsUAZ1O9MVZyDt/2wDu9Ig
	RyiE7bs0h0viKkOmObKllKdtQ89Fht/Gxg0tgfrMF4sjSDqi0YxuYf5LuqAONCv8
	YjzO4+VOoTx/luTGwRbBDA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ncmtbbbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A7InMAG036151;
	Thu, 7 Nov 2024 19:08:41 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42nahgsus5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 07 Nov 2024 19:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=seHSIipGPEQhS0/xIvBxEDaPTFGeTjMVFFukR7UAMzxT8djuIEpTKaabusYyfV35PRwcw+HnbZHxW7tO9KAezLdyzpo72D/+/UELQC8t0VC+mDdFTSmHfdxf4kziJ3lIY+cIgrZU+XEnuekAtjwYHX8tDz3qasS49qvr6pxrcDeFRqAchjl89H5jg7LsgtSZLuQytEQLjrl8iQRWEx5rW7FXnjNFhKHTk7jrRoJ5XNv+VCSZpscrEapY3QqafU95JHLzFHy1gsdTbzpHuPWpnV5fzY/zgt0pEOhipTnMZJ03VKW51EeUn+xQ0/ieK244p0t44WqO+XZMUs0xMzER0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVSV206N3GHQLIOxxufrNmI2FZJL2ktslxGjHp7FL+M=;
 b=CkEsD1aNb5G6NeTy7/768rpPkXRGpbK4+c7EFjCFStC5IdU9+Iwkq1Bvn8CR4GPLJP108C21JaQnczJJExsGDrh3IhEAs6Z+RR51xYPc8zQ5c0R4Wu+hwzjgFCpFgdZAjwATX1TDCRvYTTkeyCcU2f+2zZP4ES2eRyvI83VMXrYCrevsZucxEQKTJo6eeZpRd1WSJCfO+V+oUtUp6apfWi/LtsDPHGQJBaWyEWlM9wjbhxVxaT3sO9vgLJ5BkRl3WB+O1joVmEjnIvjU0jvWBQo1zSYqFXvvr9urbybIBZ9jOMfJZhfb3D2KDg++L+qi7jh0q2l7WSxu+f7jhL3vhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QVSV206N3GHQLIOxxufrNmI2FZJL2ktslxGjHp7FL+M=;
 b=FRfcz6RwAismBljLE0g0KttETzFHAQHEPzfQW7e8EcGY2BXXLVLGrfEWAkrPcrqiDFHYTgqFZE4s60xbha0ZYrr9t2FRxjGxXDlZzdAywwQ3kM9nqgisZxYpbHQtuKIq/uRAkvKsWiqP6giLXyrAx96Hh/cggU9pL7mqP7SH1So=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CY8PR10MB7148.namprd10.prod.outlook.com (2603:10b6:930:71::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Thu, 7 Nov
 2024 19:08:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.019; Thu, 7 Nov 2024
 19:08:33 +0000
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
Subject: [PATCH v9 05/15] arm64: barrier: add support for smp_cond_relaxed_timeout()
Date: Thu,  7 Nov 2024 11:08:08 -0800
Message-Id: <20241107190818.522639-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241107190818.522639-1-ankur.a.arora@oracle.com>
References: <20241107190818.522639-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0093.namprd04.prod.outlook.com
 (2603:10b6:303:83::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CY8PR10MB7148:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d913a48-1157-4b18-8cda-08dcff5f9312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y6eHZHFZnflEs5voIF/jAN+045gU/c+X/ZcZqtYiflo7ekrFdlPhAGSnXamQ?=
 =?us-ascii?Q?wUY4DR+pEgI7SnzLNDkR8Abi8jG3qFyxyApsD63bpd9s4kRdkAMXepPyTWsT?=
 =?us-ascii?Q?ILbcwcxHBTdkuyIiq9QEO83Rf+yReOL9ykmA9E3XUw6568o7Xw0RXfJ/phdC?=
 =?us-ascii?Q?kfkTuV4QYD6iJ6UCqAWN7paRmJ9gNq5lJQuubT5Stiy4zhI3b3qr0WHoLahQ?=
 =?us-ascii?Q?gja+zr24GJhhHBXX94Ol3ifn2BKxCSoQQfxQrAVU33z3ZJ9DpUB3JNw9xz4S?=
 =?us-ascii?Q?+afzPgvi5scTSqwPWT9IsRs0+aJq98W8hPK/pzJEBg1U4r6hjoROVz8tiOx1?=
 =?us-ascii?Q?lU0p5MZkc9e/fbXui26mJ9fv/Qb/LIau6heqLOENrqrIfilWAz09m6G471rT?=
 =?us-ascii?Q?d12ubwUj3Y66vr2XlJ1xBCa5RT2u4o3JZnnGyo4rLy4xZlccmrr6U3UwRto1?=
 =?us-ascii?Q?gLTeBE/T+7RR6NpH9JydJnwYNflOgkO8r2i9rRtGOLYWQiIvUJp5d5LJwbuj?=
 =?us-ascii?Q?3rFfddhUq8mLy8bKFazaPLxuW9jjjHU7wd8ocOinOC+wfGylhfMvchfP5F9R?=
 =?us-ascii?Q?uhiOw41vxycNWn67WRZ3Oh62F5/LDUWXFQEXUpN2JtRW/Z5sAU7xOxbNOWcU?=
 =?us-ascii?Q?9OQPkFOLc7GkoRghE4MsafnBNgqKQyrTLUaMxwvCddtMrnJkWqlCYMEHx6zE?=
 =?us-ascii?Q?W7WWYSrizrh/enQ1DQvtaOrf2/Na6WyP1YvMOHV8knbo6Z/VUSSyUl1pu5jY?=
 =?us-ascii?Q?6vaLzWCjckl6X1jRTaUh+f7QfA21NXXxz8JhgHUKpIKskeFRIdxNlx2akySX?=
 =?us-ascii?Q?g552tc3/c9QmDaTJTw4aCRvmB8KBgPw+dKVc+UUBn0VCG9B0btUOQTv/x7VC?=
 =?us-ascii?Q?ZhqK9F9nrdbGpB2ZzpZ2LxWfTOAeKQkhDHAG8gsAuyPKN6XmkWYvBj/Se5st?=
 =?us-ascii?Q?klcOrvflCbGcZwcah+G76gZOVSOwjAZjZ3aOI65iqBffGfG0AiXvBn5tf6V/?=
 =?us-ascii?Q?m/aeyxd3t56fI+2Q63zk1DfunlsAJv9q8SLxFo9RW+qPwuJf1DVkRfyF6Ixx?=
 =?us-ascii?Q?EVphvZJ1SplbbDdhSQbftzrF4BZY0jf8t9mA4ldcls/CmEIAcx0INYIxYaV7?=
 =?us-ascii?Q?CFNWQyUYu0c6a2g+h00AdqK55NnNpYW7mZ5NYYkJ2h9uhG8aCd50plWgQeVo?=
 =?us-ascii?Q?4mbX1/S1g0Nql7p7OjcO0ehYVobzoNGGCauxRYXh1FP596MirNuJTpi/vnpH?=
 =?us-ascii?Q?tCyJZAXhIMwDVnvDPs5iwBLAPdSPd5uTSDKTVgPhy6BYVvwS8+nM654R3U2Q?=
 =?us-ascii?Q?pbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7W98LfaNJCkCUYu5vCJaKEUyTYtdgFs5M0o6NHd5ZghjYE8srNmIbdof9dMn?=
 =?us-ascii?Q?mxY93rGIv+JFRNAuQbItT+ZMDpDuHSvvHP4rKTfXepXZ7ZiHZczFGYVoaB+3?=
 =?us-ascii?Q?SYlYVHMMpnI3WQQ6+s33fxYUMxlqMkwYPdMdWMYhreFOoNZad9P6xOvFXVQu?=
 =?us-ascii?Q?OfqFOy6LKdDEYqHA/ccjx0mBcA4UAeuN8nqCgHK8T/6hwcsHIMJRt9TkUZuH?=
 =?us-ascii?Q?QupQ5r54Q8y8IIcEtxfasHYB5jyMWMYkbCureTAfKx7auaByMfn1Nn5ssw8Z?=
 =?us-ascii?Q?KIFb3tN90qOTlOd+Xbj1BUEBn7zhHSsh3PtFUpvdJGbl97MLol3FC898dsOO?=
 =?us-ascii?Q?Wmz/PlxXiQT22hjsFlWQQGsAYOEnDFQtT9uhC5Oh7+XOPBypNG3QHTNPhMaT?=
 =?us-ascii?Q?qjAgSI1h2YDouwFt8W1N5mTxjkVTVn0A6XrycJdDP7gX1u0X0LLIRdO6tziN?=
 =?us-ascii?Q?TM25vJUDxi/hW801iUmKLOiTkKjU0SOuGWyGEBV1u4R/ML8N5iHX7tnmwrE3?=
 =?us-ascii?Q?frfz/rCbUf5XLHgnRn0CZLw/hBT+yojbgmEnyEOlFnx15Flxlk7buTJXKELf?=
 =?us-ascii?Q?C+sJfxZzch/8+YRj/PC6a7NUQ6WBZ9u52C1DOpdKb4DVAW9tAsGcpDDw6qf0?=
 =?us-ascii?Q?ZlkbP8K0t0fHs76zYcgfGvFK+3ZK88el76v8PrDrFSY/zZ5rJdgtSiEXt7P9?=
 =?us-ascii?Q?YyTGnHHBgUNBBJx/Op+mvh3ioXVyLPPO3PN5FZVJrjqSdGLT0b96oHwieSZV?=
 =?us-ascii?Q?T/ceTC2vjtoQ8SREOw6RoQ0TjziBgqPKzq7sXDGe9opRQnAW7LOCBeGsi607?=
 =?us-ascii?Q?Kjnw8Fe3PtKgtEMnDmiDPpTAcgr61VPgENIwvg6Xmi2gwIYi+9YJHz96wVtf?=
 =?us-ascii?Q?RxL73DaXinYAp3m3Go7ehY+ZnKL1xAWua6yOb2IExqjyTD6iiliBDhIkfwe1?=
 =?us-ascii?Q?aq8Z5/Bwo7K0oDpS4QwsxipqN06swYpta+yd4lLW+HVv1hoDt9XUDkBQzzz3?=
 =?us-ascii?Q?JgkdFR6ringlfGwga6BYhJZc3awfQC1KFmr32Ut1vZ/qvPgYuHdqR5OHuo1M?=
 =?us-ascii?Q?KPWiSnPyXOQK44NeiBiqbpFze8HKv6fnrfDPFx6RtmmyOr4kwARdglauphCD?=
 =?us-ascii?Q?wXev9EVer6V1FOboi2jxq7IhZuhRmsyaZQ+mWk0AN3bMay4olddL7jyD+EW0?=
 =?us-ascii?Q?jCjU4SawPi7yUAZxXbHrNv+qEOOyLDtpHkY7MrOWy0mOmzNqmOdUtQbgSrQO?=
 =?us-ascii?Q?LC/8pFzZMcQBXI+vyLd5JNZEm4HfJhH/zsbWJHtef06zHXX3azXr2mGVRLwb?=
 =?us-ascii?Q?q/G2/yGGSeeisg28EOwA/4r5lEC6YdxZ6W0PuzLiwqW+/BAAKuOaMJG58mIs?=
 =?us-ascii?Q?se0OTf5pZnH9/NMNAecdFR6BBQrG4mvFkcUwjPSVqilUXooSYCWmkIA2YV0Z?=
 =?us-ascii?Q?2CitS9lyVcycbSqse9qvs/+TSa1aDyosD2VdH0vngqEnRcCUdFbQjIo5N3n+?=
 =?us-ascii?Q?LlORWhsTum8Qi0t8RF/my6vRGqxHd+RoUI5B+I6Jl9JSaGzg+dl0TsvDeVHJ?=
 =?us-ascii?Q?jMH9p2ItXNd166ZHOzEiEwHHwnnyC1DPOyE4+ztGXCN7PRS0pP+MCKw9XkUg?=
 =?us-ascii?Q?QQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5mkCUPC9hoz2Z6uz3fW5rn8QW7hOCXmOqHvP4P6S7DCacNHsQbjYk4xh1QiPhH2/0cgOkYCr5hNWKPpPTXFSozVvkKfnz7FwRQMgWf6pcT6a+xMwF5wL115/HxO1cbDN+Yctm/rpFBF2WgbAJ5ZE7515Xmf8kUpxQXuNmKmSKZw2Xoh9ZtwBEDiWZjpZ5o0JQh/CmISNzvzMrsBeCPjOpjrx/S5G86W18OBvRq73rLCz4M0KFrgeOfLPpPjVoVeI3hBwLeBy9Oc4ySs+XeHGtVbqerqEV+FSxw3P78nRksMC3Lz9WCwZRgYMs9Ou3RQ23m4jhLNYFkj+iucLTRHaBO9QADl2YS9GIBJAOikAhRMcMfkpyI+QHQZAAjf4inyDCECJv3365Q2OazqCQ26Y7EJRaqRyQtO5r2cWseSxRWZPrTTWuY6vfBxnnCyYUIj029xW8MPfQQ02ljW7NSP1J7tNU9LUSvrzNb6Ibyj217j1bXW0xwKjxW9S2yQScnGoLd50RXTnnSXsY0GifGKxEfuMItuhTNZ2TjZLl4g/3ylG3/7UBWfyG9QiOW/j751+dnSP6wUXqY5FKnnaVZEjsSa+Ji5qEhXXzd+lr1miyo8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d913a48-1157-4b18-8cda-08dcff5f9312
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2024 19:08:33.7386
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YNe/rJaMsvCPSKTYLsm4zVnH8jovxrVFYCnphYZLll9JsE4NW00GBkYT92YhYtzjN3vDg//q+BcKhHa0Od8AmA6ntvT/F4sUQJuODg4nLR8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB7148
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-07_08,2024-11-07_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411070150
X-Proofpoint-GUID: -IyB3pGUmSkPCHRc5sUAyhKL3GwhKnnk
X-Proofpoint-ORIG-GUID: -IyB3pGUmSkPCHRc5sUAyhKL3GwhKnnk

Support a waited variant of polling on a conditional variable
via smp_cond_relaxed_timeout().

This uses the __cmpwait_relaxed() primitive to do the actual
waiting, when the wait can be guaranteed to not block forever
(in case there are no stores to the waited for cacheline.)
For this we depend on the availability of the event-stream.

For cases when the event-stream is unavailable, we fallback to
a spin-waited implementation which is identical to the generic
variant.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 54 ++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d5c939..ab2515ecd6ca 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -216,6 +216,60 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+#define __smp_cond_load_timeout_spin(ptr, cond_expr,			\
+				     time_expr_ns, time_limit_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	unsigned int __count = 0;					\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (__count++ < smp_cond_time_check_count)		\
+			continue;					\
+		if ((time_expr_ns) >= time_limit_ns)			\
+			break;						\
+		__count = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define __smp_cond_load_timeout_wait(ptr, cond_expr,			\
+				     time_expr_ns, time_limit_ns)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		__cmpwait_relaxed(__PTR, VAL);				\
+		if ((time_expr_ns) >= time_limit_ns)			\
+			break;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr,			\
+				      time_expr_ns, time_limit_ns)	\
+({									\
+	__unqual_scalar_typeof(*ptr) _val;				\
+									\
+	int __wfe = arch_timer_evtstrm_available();			\
+	if (likely(__wfe))						\
+		_val = __smp_cond_load_timeout_wait(ptr, cond_expr,	\
+						   time_expr_ns,	\
+						   time_limit_ns);	\
+	else								\
+		_val = __smp_cond_load_timeout_spin(ptr, cond_expr,	\
+						   time_expr_ns,	\
+						   time_limit_ns);	\
+	(typeof(*ptr))_val;						\
+})
+
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


