Return-Path: <linux-arch+bounces-15657-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id EB41BCF2E87
	for <lists+linux-arch@lfdr.de>; Mon, 05 Jan 2026 11:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 710DC30049F8
	for <lists+linux-arch@lfdr.de>; Mon,  5 Jan 2026 10:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 268522F261C;
	Mon,  5 Jan 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NtDcVA/8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fnFFemmL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A672F361F;
	Mon,  5 Jan 2026 10:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767607650; cv=fail; b=VXSFXmLB8GSHSy5BdFi3RCIK7tJVTOSZJfIH22rfL68GBM2rzSAkQoJ/9PNzk9FhcGGtx/7HS/sMPUvBXFRBBEsQDXhUrxY88yknKDw+gc8NZfYCM3HPqCYEUDOFYbtkO1ydp62VlO4CU+kUgoqDwuMhLMKBagbwOJpeWJb6hN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767607650; c=relaxed/simple;
	bh=8r+S9TLqLxXkFJUWa1CDnrD7xRtYmC5PbuIJSNkG9SE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LRi0cyaa1BkprJNsZO2lOb1Yy8CtZ518CMgOzu8vQbedSUmSfji+fgPHQFTezMAepcJB4uvNOMpzzMLuYFL6DY6eaIDftGfjS6x4SrJM195b5+5B/d1frWKK0iZSUdYB4iQP0RDy/X59Fq/gL2NGDqoodmF5PqKbY13aoPHKU5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NtDcVA/8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fnFFemmL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604Ng7xg160295;
	Mon, 5 Jan 2026 10:06:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BzNIgLnuXhvV7lox3wg0v30JrwpYxr5nzaLVOhgkMIk=; b=
	NtDcVA/85lzZQDYqIWk2sL497sMUk64uRc3iwSsuqcOqrSMHH3Jw+Q4TXKQiZ67D
	CFZ0alRd9OP7IcPe8TeWe5eQEWnNrGPFLWY8J1JM990kJMUDxiWkLaQT0yr0v8oa
	NaQWrh0F91MU1funhEDlG9rhXELTzx1O7R1uST4kSOPXIcGhkRUI3zP+eYsMiAAp
	X8qHrh7W/Z0Gmbw+g3uPPdtBsRjDoQbhoMnAxG/i5az8pnMRFkV+pCkoxIkJRJXA
	apFupeQo7K71oJnAJyx33iBA0RHRpI5GhWZVr0bWOs6qCreFSChYShuunxnWhzx+
	tIQyYKNX8LNh2OE5M+ndHQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev5qhfu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6057aivk033967;
	Mon, 5 Jan 2026 10:06:38 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011007.outbound.protection.outlook.com [40.93.194.7])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj775m9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:06:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=apORYf5udSrrfA8qJtmcEx4xR5AgroWUmrZ7XgtdunZ+nVp1uAKYR1NeDZLTOXG2xCSC9kWG3wZ7bwOZLABuGSJFToQHtHWQTjmVY7tvYkogCl+1zKr+bJZ41s7O9LdMji88pzw03m/0CAaWfXmryl2i9eydk97RiP1Whn2DfqD25ZDTVOUmIsiiO8CYqIEJzx7C6+prmpkVbzlfHr0BoyZ0MkIBxnxy9RcYl5rt8PT0Pzxmys28bppPPLqOV89XKn+cLbDLuV0aXt/+3/5F00FvPfRmwEenG0yaok5eRj3vXA0SKQRJwuywFDTFJqvDLKw9ISSoFN6sme/nrx9vrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzNIgLnuXhvV7lox3wg0v30JrwpYxr5nzaLVOhgkMIk=;
 b=wjNfmVsxMHLN8+kK2M/m3Btrs2V3wxSWqqz1rZecPKiY7oikHRXYUCmH7DRgc6j2GhSKUYpgCgSgv8mFZR5ZMaBjPm+NJlN3KNSK5RDshfv2XJD9vkTZtyhGeYDITZw2UmuE4g2RXIN2tca8PgwUyNSg+X6MH8zl14tfdHUWfcaFly/9cUM+G+uvVJR2DS+py2yIKdjh3myQbZCj4gL/V/RuIlZDzHv87k2HRKnZrqaddWbFW+vabnFW0R2h4I4cRaTN6a0eDNtjiQcqlQkZTJt6NJI8uFmrhupNRz573pO0uQ3nM6dcH+jqBicWk3nSByKFVrYVXu0mgJC3CaBkEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzNIgLnuXhvV7lox3wg0v30JrwpYxr5nzaLVOhgkMIk=;
 b=fnFFemmL6lDVJRH3syuaKRx7lZx+PaTR74k5wcAPvs7weuf43XEAMUGisf+Nr7/EZj4NwURThrr1JuuAZR/KhGNJeP1dPUxzB+QMaadGeqTDko7A4XgQVpBM3kY8weTdSBkjEpABg/w57aila8fZpRENrR1JsOxCOVo7m27mYUg=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH4PR10MB8076.namprd10.prod.outlook.com
 (2603:10b6:610:247::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:06:35 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:06:35 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH 2/4] LoongArch: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Mon,  5 Jan 2026 10:05:45 +0000
Message-ID: <20260105100547.287332-3-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260105100547.287332-1-john.g.garry@oracle.com>
References: <20260105100547.287332-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0028.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:326::17) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH4PR10MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: a279df5a-4dfd-4010-35d8-08de4c421baf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9DVYdoDizPw8HIAxKGY6CuK0RApc5pFN+WxTQcJ2ixU3IZ3AhCrVhvi10Gl9?=
 =?us-ascii?Q?eLbGa1+XsnYlYd+TkHNgLq0NgA7TaZDyfWDectikr58OiGbfAoy1XQUKVQL8?=
 =?us-ascii?Q?JdP0eAgRxxRgyBb9Cyz4bD8Hg9sJ04hsgXH9ZTptyIjn/EHXDcBjYFTIPoC2?=
 =?us-ascii?Q?m2u90C45v8K+nsBw7l1ah9hT95zowA+MSR4WfedMQKiYF3xmgCFFcsjusxRN?=
 =?us-ascii?Q?TQMUpBm6hzVCKq5Ad/07JeiX7dibXTRWXVJzXP7NsbPaJ+I54lOWMXNABqM6?=
 =?us-ascii?Q?9QES4ZqtjztaxeI4KlDgm6vqr+GM4XTT1RQsTIaTbygCksiD58Bg8ny4VW5q?=
 =?us-ascii?Q?9x0l3ouNzvPZkeaIsksBYTOArjB/aMj8WMLjICmXctk17NLDKfYICOm0O7bh?=
 =?us-ascii?Q?HgolXKgANEk4Hvkn0c+cmDZYyE9I6CAYeZqdhkrZnttKLSJze//9bOQ7JKi2?=
 =?us-ascii?Q?X62d/F9QFkUwFBUcPLjY26wRcO0Z2Bo7YVvGMLj6daRZjXj9gpTy2zEsd/rA?=
 =?us-ascii?Q?/MaX4bgAG/pRzMv6oc8rDLto0kXqpP0N53e/Ie/Zj0rHUVc3y+iwZKVnMdXB?=
 =?us-ascii?Q?qxDWiH+VOw011qxsApBGOwfmAE4JHDPrQWVefnQaYeYf0j1nqXc2RAftr4YA?=
 =?us-ascii?Q?LpwWdHt8cUG8yDD0/87Dy0EVA9wCa2SV0ZmFlwP4pHAyn7Q0656mSrA+N3xb?=
 =?us-ascii?Q?bStK+JCeC8yfHMkUbJ9PKYtnTeTZ2BL3sq80kkughppE/cokiC7jdD88wRcN?=
 =?us-ascii?Q?IpW/SeyNn9ReE30sTne+tWcnnG2NqA+IgZoTtP+XB7pqVVEpVipJi0OtnHkP?=
 =?us-ascii?Q?ZNShtOJKC9C2sorwmxSeukapbF+6/KljnWyesq6I5G4D4pdGENYCclH6Edsu?=
 =?us-ascii?Q?SZaxJzZfBfy40mrthH6C1ZCBi4ST6PDK+IK5o7hLebFe928NliEooenPL+q3?=
 =?us-ascii?Q?cuj9GMoi3sV7vXF9Im5M5geiFhOcXNVVXyt97x8T/jxQ4FQPJO/YPa6Xt9lM?=
 =?us-ascii?Q?augPc5DSjvAx7U/j2Hjo1WdmL8HdfuFy3K5eL8hau8BvtCGsicSRbgkrKCGv?=
 =?us-ascii?Q?v7RPMM+p+KZmDRc91RhpWMo25EL4DAo4pud5uaotSHn7EzxwFqk1KvhdvCyW?=
 =?us-ascii?Q?FlSTEn7HmZeTBgo8s8I/pEzSgnxosa+/nPnUrg2IrLn5/EodYVvFhjf4wub8?=
 =?us-ascii?Q?hQDf824dyEtxtA6ReKhOCx8cee/oqGDRd0c7Xcx+8r44hKRcIr1oQBc21kIO?=
 =?us-ascii?Q?Wbq2wezR41drQoI+USinyokuabNLHTqEHceMEqsXCsaAZvC9IQyHp8ChpeCe?=
 =?us-ascii?Q?mPb93YnQxrKfFimZ0ob4uG6P+fohWPQmQbPLeZd4hoO5TvLjJlTwWfkCskRg?=
 =?us-ascii?Q?gF4DUcDyAffZNrHbxmrfmY//WxfsCz/ZEN1imqX5o/qvtqaH1rhFqsEJpDVf?=
 =?us-ascii?Q?DHWhWPdssIZrLzHm2OdIe5MRsDw0cUEfBo2isbFkBhB9M59ZRg1w02bcH/PS?=
 =?us-ascii?Q?KaBFyXzDhD1o6Jg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gba+uDUStKxwMB2z4qB5bDZUJnUyCogeuBCFlImfMQQTyAEKkH48fHehPelX?=
 =?us-ascii?Q?vCfU1Hu3KGA4Af1ma1GHqjnMDHoW2q47MNDW75bEb7DG9XBF/t51in4deoNQ?=
 =?us-ascii?Q?KVPQLuVgtLW8f6vFzOP1Z2h/w7Q6MTjvFqVuPfGKpzNwPqkVsMihoFIQtKHK?=
 =?us-ascii?Q?xbkQNyDeahc8cMg9c4tXi0mh10E7xObXSPJTZqdAIsZZo7qiLy7rVnHzEtqv?=
 =?us-ascii?Q?hKCE5ij4OXMqlLnINXWLrNwwxixwWwEcvJFjO2AdrpAIBcIhWo4Bep+gEACl?=
 =?us-ascii?Q?4G5cmut/LkrIhSRITvv7FZTxMQVLPDfi0dUW8u4VhD2EU66hdaPYXr9ZpyU9?=
 =?us-ascii?Q?eSuZ5Cr1PJQ9Qe1g9/+7qKeaFocAw1wbU0xjmZufORZ4/Q5nY8fQfEVDxAqq?=
 =?us-ascii?Q?57AfQemjvJH04Kl/NF0T7g8g9gruhQiIR/l+R+edl/I5SetpAnMjHj87OB2X?=
 =?us-ascii?Q?plkDD9m3F0T4GHbbsz0qVc0fN8jfyFyAvmp3bzuEwzV86KVZhJOc55LuAq4G?=
 =?us-ascii?Q?WW/fDGSTHS/QFe5NMlKWrto7VV2peOBrwVMMvdPo3hrP0wldkpGW9XviIJG2?=
 =?us-ascii?Q?+ahhMnZo4kowfkn1q3u+0x14VDkiePGDbRY5MTjCWbBA2NvTiIdIiaRFv98y?=
 =?us-ascii?Q?kMOy2wL24bcGzuLeAupt36wcCpeYda0Awp4LDe3CIfE3b5AMisydx3uO1jus?=
 =?us-ascii?Q?8o7OauU/yKQB7rtTdxKHOZ3Hb/0Yuq3R3CQ7rjOFuUte32faeZ/L/tffXrnT?=
 =?us-ascii?Q?euEfA9jss8QGVneDVzpkgy+kPI28+gg4pPIuzZ+hWAGnA83t2o1ZNnDprvZ5?=
 =?us-ascii?Q?9kQ61W/QIXRk3oLJkiV5d1X/8DR8TbyRSKYEpZMxygHM+EodZeTiOlG6toA0?=
 =?us-ascii?Q?ydsaxZ0PnBwMOEuYIWcnJ8tp23e+9cNlvvT67k0sk4Hjj2nYjdHEefH8A8iP?=
 =?us-ascii?Q?6IUQsFCRJ1cD6NgTC8ZMMOcetM9XZeqf+pBd9Vs7dNopg7Ab08QPT1neRVkF?=
 =?us-ascii?Q?igk1yN0rTeN7xlnyUAfulwIup7WLHx4556ECPTHvtu0Z2UbEjmv/9xRU4HyX?=
 =?us-ascii?Q?6IvqGRI8T+1SyReL1pVgU8rzu2hTe6RiAuN5tLwPW/gAI1nEJuV5VWJG0WOy?=
 =?us-ascii?Q?6G8svpfEBBbGrv7jvnvD4oJNv76NcFdt9Ua+lYecvsCgyzO05tULWsb9+e1x?=
 =?us-ascii?Q?WUq3OM9jGqYng7ug3BiheNQ0X2O531pwa+wnj33BpTHoqBoNPmSyiHXSTGaL?=
 =?us-ascii?Q?4kqlugofjGG3wnPXLIYic+lCPUxgzfDRiFGB+KJM5Z5iuobbJRkN7Lhs4uZH?=
 =?us-ascii?Q?lLUZe+GaKsRT+CIOfAqsI7/JU5U3juD5C6swBt4HUkvzdAKcWoqs8rirCQ7/?=
 =?us-ascii?Q?iyefMAlGv2gt1ijozy67wS/f9zUk7JF+V7jPcpRVX6Q4Ea9A2InlU/IRo2V1?=
 =?us-ascii?Q?Ufhj3zivW2XVWoxUqoY1rQEV3TKlbxUbwduEPrcE0KzEL3y7jeCHZloIjs0m?=
 =?us-ascii?Q?wUhgtUf7jD8FqDVCEUoZs5R5bzv+q1z588Nc1E063Jmy+5zQsYv7+777sWvK?=
 =?us-ascii?Q?Brw8Xf9+DQyIg/EI5Shizg3INXhJuiw6PmJ7ojQlOWazGSZauLIOu7Xi0XvY?=
 =?us-ascii?Q?iVnbbKa8nq7cCKWOA9YNWaogJGOdN/42DiukxToOHvPugJmuUN6+TVjAzJVK?=
 =?us-ascii?Q?nR/7bQnMRdhd1EHVWt0g52unfA03QZRIw09BYJrmQn+5nXc0Eh40cKN/J1YQ?=
 =?us-ascii?Q?WgBWGJNyew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pO3ISPWSWlrjc94bZSFAIJJZcavB+ajE69W+7hsnhMEHokLw/Cox6Rdk9y0/mzf8/B1h8le/rwgT1lnz8zObHUDgwmFv5sKeQJfShm2RlDK5OZGhJEBtOjTKljXELkqTbfJQauSy/JDlxUDeKoxUF59/eGxO5y9bJ18rgQcDCyk6R0MdaKgz4fmPlQHZrGip4qSj+cuGGki7E3I5EnwD+B7/sOVcSC3BZEE7UPgbZ5MvZpQ3xGTSfiu0s6ISYlqOjEPdtZonf8fChOxboC9Ul2NSh+I0ba8My4AqJArql6+vk9y3WOYEgsvb1/vFmktx7w78fPhqGHDXo5rYMCSenklf7VGxOSKVRcSywL54xgB/WJd7qrgB9hgBz0YjQvclZ8YsJt8ewwIws8pXdQR8tamCl6K8xVT3iS+wn/K5lWVhYNRBQLwZVfGWtK/KpOXQ2/J6EkOD5KVii8UPnqyb/ZgT8dFmITu1B/Aenggz+N92JjgmSFFfiq0/CdhXv4ok7loHzqrYCZh9HQFVhVy+/oZ2McPuVyriCCYCcLEKwWnDbllj0W5OhPLkl9V6hBavw84A/DoUuq6bbpd1EW/p1275zq2ZXSULFJMGZwSmc8s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a279df5a-4dfd-4010-35d8-08de4c421baf
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:06:35.0686
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2a34nx8uD5iY6zCjrOaIBAMT++WKR+MvgSrfLVceh/xkID+viJvVXS/T4BU/VJGZHVobkyAhqL/lg+xiK8Oq3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8076
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050089
X-Proofpoint-GUID: x1gurBoJ91S2KdsMMFf-ox3RMT5GvuM2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA4OSBTYWx0ZWRfX5zYk/XUGTQmj
 N4ZyX7p2lz3MduQJ2EkQvu44xceaUsuVQEwO1yDIJ589dNiZnJK+aEdXQWJkIVQTUewS9d46OaF
 qTK6pOiRE3EtCZP9BPyWFg7lqsJPKlJCFo0It9+X9TXa0KfCf1zTiQfLUzpoOEoGf9tOw/JbNIu
 4mqP+H8DRWZyOSXW2NrY0E5DqgM3w3ORCwmiKsCpQOA7497hL4qChj08Pp61F8hL+LzHocc5p4S
 BsWzla8QQrLuc3xcXnW3PqtVSS3gE76AT7AFo5JJ9TWOsWy0B2dcXgZ+9tzg3wDjnv9+WKF97+A
 ap6H/7JE53uoQAWWMmG5k+XkKQQxtOZTYR3Iidm1uzJ/VLvWG6pIXhGXiZ/QpKCK8j2GBdPdHRf
 JTK+UEOrVUhfp2wVXxy5M3luDsnFZfuttgvbrpj5OO4QeqjojV2FNmkFu50VMSu2KG7GdPfiam/
 5/gKE5Ut2YSZo/876AQ==
X-Proofpoint-ORIG-GUID: x1gurBoJ91S2KdsMMFf-ox3RMT5GvuM2
X-Authority-Analysis: v=2.4 cv=cePfb3DM c=1 sm=1 tr=0 ts=695b8d2f b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=03khOLM81ZsWC1gh8zQA:9

The arch definition of cpumask_of_node() cannot handle NUMA_NO_NODE - which
is a valid index - so add a check for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/loongarch/include/asm/topology.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/include/asm/topology.h b/arch/loongarch/include/asm/topology.h
index f06e7ff25bb7c..9857e4c20023c 100644
--- a/arch/loongarch/include/asm/topology.h
+++ b/arch/loongarch/include/asm/topology.h
@@ -12,7 +12,9 @@
 
 extern cpumask_t cpus_on_node[];
 
-#define cpumask_of_node(node)  (&cpus_on_node[node])
+#define cpumask_of_node(node)  ((node) == NUMA_NO_NODE ?	\
+				cpu_all_mask :			\
+				&cpus_on_node[node])
 
 struct pci_bus;
 extern int pcibus_to_node(struct pci_bus *);
-- 
2.43.5


