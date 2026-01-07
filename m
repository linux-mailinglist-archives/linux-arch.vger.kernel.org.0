Return-Path: <linux-arch+bounces-15684-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 067DECFD04D
	for <lists+linux-arch@lfdr.de>; Wed, 07 Jan 2026 10:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BBDFE30DBBD9
	for <lists+linux-arch@lfdr.de>; Wed,  7 Jan 2026 09:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400AD325495;
	Wed,  7 Jan 2026 09:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rx+aki4G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZEZy5/gY"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91387324B3C;
	Wed,  7 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767779033; cv=fail; b=gH0Dh8CepYSZ/olcFuPUVv+x1dUDDZnio/SUbafTZ/3ntrOR+kRGyBW3m5wVaHC2WVLLiYKpIGoMT4aYqLz4TgcnY7npDlka/8c+fY6KS/n5FM8MJOP4SGT9Cnd/jiO2VTA69zC16Cc35mNLJ6VuKeF8Bkhq8src9OdL33FXpC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767779033; c=relaxed/simple;
	bh=GVYJaKa8FA/H5bNFQl6G53Eh2uVrrkZJ8rrx+BhYKUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gqcqd/ex3cq6ICke8cqLctlCNvQIXPG/CIf6oUIWt9Vtqj9qBw90sDwp0tYLCAQP/CN1bs0XqmMVwXeU/FAnRu8zmlJ9wbV/sAOR3dCVAsIoE4pwjjSh16QOttLxzetqu+ZUfiTOE+baufwuWbcyg5FywYPs+sklO5hBl56IuDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Rx+aki4G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZEZy5/gY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6079bNw81670870;
	Wed, 7 Jan 2026 09:43:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=; b=
	Rx+aki4G7eliwMv+KFF/kkEOszrNlV95hxCrjCOz1eZDxq2G7zH/7JYkI55aBeDR
	iXJqz37TtYmOwlbTmPi207LH/XtmSLRuvrCgskGKTuM+5N91tVQgEsGKrB3XAREI
	8W7zoSMG+Hom6nvghevnj0ZNiHMDzS9hTI3jtZubfna1aB1K5C3x/DTduo1tH1bE
	Ku5yLqKqeVdGvq0IPnb3BOCScTPN/p40Qg7l7DrIlhiRTKiKQNB8FsE9z6jxhizj
	2k6pmmbUXHBkZ+qKfl/joyHD8QWcwIiudRi8hhesgZnGYa70hZIlOMJ+Ywtd67w0
	woxiZnZLTaZBCLW+A3mx1A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bhn0k0098-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:43:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6078qwfo030813;
	Wed, 7 Jan 2026 09:40:33 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011046.outbound.protection.outlook.com [52.101.52.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjdp51u-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Jan 2026 09:40:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n71DZuLY9xSSuMJ7HPLtY/8cSrlqRn07Od/G73mMqZuTBQFvftukd9ijKy1XlvWO+F4jg5ectJZyV6j0niL0adNQGxzclolLaTfAU7DUS+5qxGylid6EFe1L03kbIj7jyXVHrX9G/3B+UZNq6XPK6LMVOyQBmVD91dwFfd/owJ3ExT7WOUWqv3NOLDVpMxmwOk9Xz29Y11CmmrSHRuI5H4TaaojQzbZ5x5mUH54DfwzkQ/E6Wx2ct6tUyHkH7CHr1OvV6EkHX6NypYVOxaghLRsTt0fLyrINicgBskSBAaucjlTHcVF4wStaiBlSJl6FhL0y5ekHqUxijpReLEwJxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=;
 b=CcCQqikxxATirnNjL5P0FLUjm6rLN7wuwQlbI+GT4fIpKADtOjcBBtzYulycwwzzJSswkIXYoMJe6G0fmgjtgfneFO3hVqQs/RloUgOvUJavnzpy1j4FLCg7s0bk2wxZ+3PYUouoK5yaMKrbUIMimJimcr4xYcKiwVqJMJVIMMf9FU+HAjgnnR28hV77a13oU0EmwldHYq7CXA7dPQtoK7B28NdThWg2++9fpWA0bAa1Sjrt1k5cXPIlgYRmv1YNM+l7gvYmQHuPs3FK0scgdZr0OpWHnDjqVhmxHozRIL1vhc+QO+xEZfxzZsGVWlkP6QDu1FcsGoQodTN+7VVrhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZDOOgrz7ktZu/6cZriGaS0Nz9og5GU1FCaRBXpCldw=;
 b=ZEZy5/gYCVnogvSrGMfiYbJwXJ0L5zf5qLHkWaC0sljuaCHQdbqvb8ncZ9wgY5l3ER6sYvRzwzjknaUOsDsX9+BRGklEVDCGSnNBh9alO/xK/oBEKe083l0IOMAY9sddOFtLs8gY6Doc3Gct5ZZmuZl+gsANM/kZXCEX5ki+EG8=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by DS0PR10MB7479.namprd10.prod.outlook.com
 (2603:10b6:8:164::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 09:40:29 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 09:40:28 +0000
From: John Garry <john.g.garry@oracle.com>
To: chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com,
        tsbogend@alpha.franken.de, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        luto@kernel.org, peterz@infradead.org, arnd@arndb.de, x86@kernel.org
Cc: loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-arch@vger.kernel.org,
        vulab@iscas.ac.cn, gregkh@linuxfoundation.org, rafael@kernel.org,
        dakr@kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 4/4] x86/cpu/topology: Make cpumask_of_node() robust against NUMA_NO_NODE
Date: Wed,  7 Jan 2026 09:40:07 +0000
Message-ID: <20260107094007.966496-5-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20260107094007.966496-1-john.g.garry@oracle.com>
References: <20260107094007.966496-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7PR10CA0011.namprd10.prod.outlook.com
 (2603:10b6:510:23d::12) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|DS0PR10MB7479:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd74641-a157-4533-c142-08de4dd0cae3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q8tFl9iNX0v7DjAg8cgfuNvpKTZe58/+tgiIP6wyf7rIDmFWr0IbI0hKKzPZ?=
 =?us-ascii?Q?wKdXMcLoP2kzWqkdMyQO6VTjbC88sdHYD8Wb7lYl0JURIvznbbVz9Zs6Jaab?=
 =?us-ascii?Q?zG02Jc0eRijJDMbaPisGyIgOgPhxQK6MHhJ1JkPsS9oKsLxQ46ny/4P12ZGB?=
 =?us-ascii?Q?bVOp/83iBuPa3FDUt5FjnDpM1dULX/E4GxpGq/1fWRjMpGPZ+WjRUyzdSJIT?=
 =?us-ascii?Q?diCZs37u3GJBwdyL474OjE+IqXykkB2Wb0vG9RT0CSvTQ+VtuaCQEa//63ED?=
 =?us-ascii?Q?elN7MpmuHwfIvb8YSpH6AZb46sQ5drcsCMHM9gWEE2SnIAQnP2Lbk4aBUHkB?=
 =?us-ascii?Q?xtzQgfm1ore7ftMQAdSAwCEMt78YavohwJPgjisOsd1XtOQn6UeZIm2cbxQv?=
 =?us-ascii?Q?+nNsAP0KgVWBQRQtwlDaOY/UsykBbTpYg04u1Bpooowu8nbi/Vc6N7Bs0jBt?=
 =?us-ascii?Q?MLh2j956WqvP2xSNCGmVep26QLb1v0WlyE40pkz+m9Eqb33oGYOr34xRZA6M?=
 =?us-ascii?Q?1ilKAVgt9dbUz3n5T6ATWVdumHJ8oVPik7MKpAquc89d09nN8kIxvz61DpAm?=
 =?us-ascii?Q?fd+e6yIEGmn1RceBrWL7bCMWXqd6iMyu6cI7UW3CpSRiaWRJLDBpm1GWrSWF?=
 =?us-ascii?Q?xI+VXj3UV0qPWhh19y8JxMHRvy66LiIAjCG1AjWFbLvHM6YzbL+wST3Qker8?=
 =?us-ascii?Q?6D1gkgZWYfnJayo7R9Wh/pUrH13fXJYaMLJ1N6joWPvYrnkhJUsMrwL7Q0+I?=
 =?us-ascii?Q?zzkxMSW5uFSvpdJ0cKfxDwNNimZSI+SP3NPHqCjTi7w9yP4ZIh/XpwfLjtPk?=
 =?us-ascii?Q?5TsNWQ+AOZrsJ7E7IrDxK9DF7Ist+nRTVNOTzNOfRt6r7hq2pTyOk5GD/Anz?=
 =?us-ascii?Q?CcqtsnUZseNA87hH93avkwkUAl9cubcJu6wrIdkbB/rOU+FGiU/ZzwgxRn9W?=
 =?us-ascii?Q?ovwlB2ezNz3prk4mvfEqEUrZp70gkJ86frhi4VfPX4WM8M4v/I9rXsJCW1d2?=
 =?us-ascii?Q?m+FT74sO2Gqm27/O9K7mPBePURByTOHSaSXGFvbeDPa5F+/wSog/NBHnWwkv?=
 =?us-ascii?Q?cMsMRfAXPpDsq71oPtVFl8pzrPnFoW7w7MPZeTVPvrLuxOHxkElE2Z+bsm77?=
 =?us-ascii?Q?ImghC4yjvBNp2tf3y6LYKeEiKEj0yoAN6V2t9xkmL9iI40emfvctVuF5uO6M?=
 =?us-ascii?Q?UJfflYWb6a+ZAFBQWA9ESTO+dJ6V8dO+i3+fVtQnmM3dVsQAV33+TdcG8Bhx?=
 =?us-ascii?Q?btAZrMsXO3KTfF7yJY9POUOJu0aG7V5XLmL7n90R7Wg41OyJcTZIaRUgUBq5?=
 =?us-ascii?Q?Qck2zbgI5YtelwuBYASPWfoJOMnZv13KqXkWxbEhjt1ykCrQCSE/WZciLye0?=
 =?us-ascii?Q?CUZqKwmZaz/5Th9lnW4+Gnd9u+FnItGGllLB7p4LKt2P3XGCgLUvZzRV1fwB?=
 =?us-ascii?Q?+nGuQ+VKYxBAhlT+XA4csixnfGvN1I0d2aKPrn8OkMRGD7NBmCxlzjHJA48m?=
 =?us-ascii?Q?oiHhDoOZYha81q0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HjuFHrserS+7fj+new+/7QJEz2CF0uCj1r642yNjKweLUeR8vONiANndXxyX?=
 =?us-ascii?Q?eVWvsLKud2ZhSxphjgob7w/nHHn1FSmUDvrMW33AeE542GUyotaQ/J7/CmVG?=
 =?us-ascii?Q?9MYMAE28bG/KvC2quwvcVe38+VRNhsgc6FwXqveeLPY/EgkZCJ5r02ntKDcH?=
 =?us-ascii?Q?Y19CwaXv/RWsxaR8gYhvbs/xD8seyrE3SJ36drUJigMT34Ft2+RzEYJgEr0j?=
 =?us-ascii?Q?T49ur8npBdXol5J73a2ktUzMtCBHgCnHHUkjWkgUEV3WliAlvKVPf3b8Sv2w?=
 =?us-ascii?Q?GTg/QFE3nz93e529Aj5rEkZyBxmfrMqzZq8jx/OeWspiTRO0p+7EFemgrKn8?=
 =?us-ascii?Q?9GM0YxXHGv2Otb0O1KV+IgXxQA2zns6ZnxvpnakSZvjlwUAwPzkJ5BzgvFXV?=
 =?us-ascii?Q?xFmLLsEOBPTwU+GgkOq5PmmbCaNtlNssBk6j8QpCB5hQ41HpCoh5Ti8oc7UQ?=
 =?us-ascii?Q?DCWPEphzhxkIo8qI2W1fIjA63nfbV5Zx9KfNHB+zNcJY7LyQ1KAe+y9/6l1m?=
 =?us-ascii?Q?R/zRNtSqB7t9WGFQNh5MFrlGIggrpR7rdDVc1DKW1jcRjkb3BBrGNSDKslPx?=
 =?us-ascii?Q?rAQw7Bzd60rlq8hxtXkDGPqWCy/RiymS1UPWIwF2SleKtufpSVKqBTYhDWPG?=
 =?us-ascii?Q?J5gMdlg1bviFVTdxpZjdF9IKJJahq7y53fCXG1OPvDxAkfyw8vVGBjKOTG7c?=
 =?us-ascii?Q?0M5YDyBSmGNOrpN4aVQjqbxhfS4H1ttIqV3RlnwFhPonrszc/Krvio7o5XnS?=
 =?us-ascii?Q?x+aoQIKm9oAO87p+AJKMfHltpf0Agg5/ZU/8h4YG8Hx1tanhAChXRcidno6z?=
 =?us-ascii?Q?MANkFxQ5o1G+nTwBUqBIR5tk7CjcriuZDJlQIe/iwEAMBLkVOSOEWjjUpiyn?=
 =?us-ascii?Q?RKLF7PEhD7/fa/q8aILDTBYelBh68Fjkd03c+wsa6ApOMMhGsw+1a3duK+4E?=
 =?us-ascii?Q?YMi87lCRhrpFX9Z5KdEDSyyGGLcwZwA0RG4ibpkjv9HBl46HOCI3bkd8nIZ6?=
 =?us-ascii?Q?d+4RQ3rxgZu+8EiSRjnXKhkOH7FUFC+Yyi5zK3uUWuZ4QgQMOoqIQv8ZvMOH?=
 =?us-ascii?Q?bUDOiW6OUdjj7MGz529LuhQXd2ryAnk1qwstnobRV8wAhXI/zZNmpTedkaP1?=
 =?us-ascii?Q?ThtElwcOOozxQsZoUq51qauvStlnZ4ZhmRUXQkh0+DzbfFs9WNaLyXFuHaHS?=
 =?us-ascii?Q?1mvwIzz7gems4sDL5Jc83Ns0zYk8l/AGeRWTQxPYxCtO6ceCgUqAiPIHAEpQ?=
 =?us-ascii?Q?pvjbjBRqcXXcFhBtN1iVSDWyN4FZhml07Beocfacor0EGD7wMSbSPREyQ6Yw?=
 =?us-ascii?Q?PUWtfwhWs48TUqc3uDjUQgAKugVVaf2q7lXQuJqpbpD8JXcOax8YKaImZsPW?=
 =?us-ascii?Q?zOhpUkwDKQzOhbTCRTcIHvgIKZrN+M+Rs+NL5a74+m8Y6b8mdJNRFgGw1P8B?=
 =?us-ascii?Q?8dstUOZ0pahxAQjntxIzbZmTlQSYXsbTUZAEHArihnI1diq0pmC1GAz4exXx?=
 =?us-ascii?Q?Pr95PEwrGLExIiHBVI1DLWiJqEU6Rdd8X3bW1hy3ZRumXnyrrdS6CYog6xqq?=
 =?us-ascii?Q?70OGcZoNFdpM/JbyhInEoCQ/SmwOiN/5b5tb6e+ts6cupDe5cB2AGqygJge3?=
 =?us-ascii?Q?H7KHZaKU//fnZbjfgce8p15m4ANjOXdDih64My1db4oH3J+nwttJy+/Gqh1L?=
 =?us-ascii?Q?5JX/KBIpEVspLo3Nbv2vWvmHHQSJjdu/6QTQJuGTVJD6+VsmA+cJsS/MhP08?=
 =?us-ascii?Q?yA4Bdf8wAA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TRT5IfhSIw77CzoL8Zwz2JnCmfZYv1rxlYZzbUNrOSe7N/bTLNlE3OVLTiTZEz2KOLg/gS5/j6jQzvjt/ebmwPDH16kOByEYd8Km9j+an0Uu5uAgxQJlwqUCa9eZMO6mlij7SqzlPHa9rPH/PNoEkDP98aFxyuMsG/2qi/V+HEfpI+ocEVO/Z1eCaUPS4SmiX5Pw5pWYGkAtioAiy9ENSfR8rFZier7x+rbqzmRZzUWxJak8/vazVYvqJIRs3etMpLT97Dis83gVXa/m3eBxu9dk353cTYpWWGpfMcxub7iYJyieCT7WvxusdyfxoihJDJEhuLSlOlNM+MXDMdfEL4x3pshpjtd9sPnAVvQfGN4qvdMeURZBCaRqfmr4sBpHceNFpogQr+aAMxanNM67EWI5VhctY6d4YgJ5f7fgO1c+I/MSEPQOtjNEF3fA3xsjylpwBoqEFjeYZeaCp5EoL1QCl3rV2bVnNjPykr72jhe9Qj4hJ+I3bohXAqytD2AVTzaDxlMSoPRlGbHOytMI6RDPD8v9z6xeBOITesi9nd0XcIscyfEk1BH1TuyKmcVFptUUC+DdVqqp5hBc6h58ukTptfj+32GwAR6FRjghrrE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd74641-a157-4533-c142-08de4dd0cae3
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 09:40:28.7191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nz46TDKHf8OghqeKC1E4fZH+Zt5zyKCL9MQAU/HDuL7+abVR7PGYMOGFHFG8LkJ2uwO4AXkZUS8jhY3nnRAMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7479
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-06_03,2026-01-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601070077
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA3MDA3NyBTYWx0ZWRfXwbgoO7q5USce
 Vm5dzT54GgBfr9Jnblx1R7HpbO4+QtV7d1JFTapZn3FTiwNvwDsO4bDwS9N1hb4wscP3iRP5oSy
 ySJaCthZ0RZijJok6zcnE+30cTMrnoIEfcPvM3sQeNTH1O6I0H5MoKZ3UIkBmDFDyzjoiBO4DSE
 1oykzyOyxse2K8o1iCKjqEmoCVWIe+gQhljnnHjpqJhkqmcO7Z8Cvop9eNGCy4jrYArT4WTx7Zm
 YaMZuIzVDI4g6kOX50ZZVopFX2S0MF2HXF3oRbikas+0tWUi5RZZhBjoqoD3AVnTbcqa1O2Pj0b
 jOkBkI9FfxugoSUaZvRuPjTnpepyaLAg1r4lRSIfoes4H8lKboQgoqhUXsNokrS8pmQGjBnDpxX
 r8NYDShZm/HxqDd+uXbXNkaTPRvxYSJh92J4LbgtzUSjmKV93k/NGVkmteRO8bOmD+8OR915qc0
 fK9Rjxs6RlsUhgiHIW+uApz3jwyWNI3PFVHcBDSY=
X-Proofpoint-ORIG-GUID: -DE_NjZjDKy-Eo1rKPB4uqW-ewU3ERJR
X-Authority-Analysis: v=2.4 cv=IqcTsb/g c=1 sm=1 tr=0 ts=695e2abf b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=-ifFEn60uaXn-cCPb6gA:9 cc=ntf awl=host:13654
X-Proofpoint-GUID: -DE_NjZjDKy-Eo1rKPB4uqW-ewU3ERJR

The arch definitions of cpumask_of_node() cannot handle NUMA_NO_NODE -
which is a valid index - so add checks for this.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 arch/x86/include/asm/topology.h | 2 ++
 arch/x86/mm/numa.c              | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fadf0cf520c5..b51f2e771a582 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -69,6 +69,8 @@ extern const struct cpumask *cpumask_of_node(int node);
 /* Returns a pointer to the cpumask of CPUs on Node 'node'. */
 static inline const struct cpumask *cpumask_of_node(int node)
 {
+	if (node == NUMA_NO_NODE)
+		return cpu_all_mask;
 	return node_to_cpumask_map[node];
 }
 #endif
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 7a97327140df8..0be94f4682232 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -408,6 +408,8 @@ void numa_remove_cpu(unsigned int cpu)
  */
 const struct cpumask *cpumask_of_node(int node)
 {
+	if (node == NUMA_NO_NODE)
+		return cpu_all_mask;
 	if ((unsigned)node >= nr_node_ids) {
 		printk(KERN_WARNING
 			"cpumask_of_node(%d): (unsigned)node >= nr_node_ids(%u)\n",
-- 
2.43.5


