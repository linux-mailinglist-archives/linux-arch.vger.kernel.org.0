Return-Path: <linux-arch+bounces-14167-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0210BE4B7D
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 18:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A10504017FE
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E1F3570BB;
	Thu, 16 Oct 2025 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Af0ff8fR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oYmcflt7"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4430D3570A9;
	Thu, 16 Oct 2025 16:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633850; cv=fail; b=qr5j9No04g+CtabKPlvtuP2K3fcg9mCnuGFoMCj0rkS81I+fZPhNOmecqDWGTt9GUud7UmDMyHrkCZgq3MT6GST159GwiPjub2jBeNIJ4o2pJT559eOJ+lP5MtmwCdlhZdDOMcYKMT2/NnZhNLgmJi9Qb0NkAQLRCUijFeik7DY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633850; c=relaxed/simple;
	bh=j2Xw/i9vkTOLP3GnCkIuGxui5rJdDWwAR/E6zMDTBl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=T86GxoydYk3kz44xcbu9JkbwtEQmxKocT/Qfsu7mMm43/QKZMriGxangPnHreO5wTO8vHugK0An6HwwScYkkmYNB9NnvQhP4CrtceUDrQXZF6IQvv5elvpv8NRZey6fAC8IbjYgoQjIDAZHYYOUSdc3hUhrKwpyDzaMssJYOiiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Af0ff8fR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oYmcflt7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVIQ2018260;
	Thu, 16 Oct 2025 16:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=; b=
	Af0ff8fRmYDt/SQCYXEioSnnuybgbTs2Sf56CT/9KAKcX2Do3i9yn71+rHedQFPE
	RR90+2eNr+aGTcNJ+zhMpP/ylX5tZ0Oi5X8LapvkQalVK3I6w2am0PVYM94TFOT9
	1XcJIoW+6be1bSRtNz+rsaT75Wui1BJAJZxKzdGuC1L+2dRczfN3iNUroJjSNwGy
	fWHpE4JwDp597FiCUm/a2XKxt8jzvt5gqAby9E8S/SU9b9DsH13MN7qzrzerzJdt
	5zyrc9OZKeG4FeMVafUl7pAc+nxs6hSZn6v+z7CW7svhxQd5ltFSjQce/c8jus/V
	UX2TOz1u2GeogIlPO+OTwQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtysdtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFOZ7A018050;
	Thu, 16 Oct 2025 16:56:52 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012017.outbound.protection.outlook.com [52.101.48.17])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbqgw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:56:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHsQXSY8BuCyVwsSiow177cACaZBBOohSZmJktr0ys2XAFL5N3Ivml7kddAApcKGDpPVOjP9ajqc9K8/nE0avbIZF5iumc7/mg8Od4CNorNi2W/8dWgWTLyIbxdxtoNoFkm5ssaoxOrrLfxldYkHULUl38CA3UCdeN9vNWnrc5xBfreljmZwc6FiMyVQ5TmvERKOFS93GrjxLQdQL6HfA4rELTcvW5PkxEr9pUtCtqW3DYo4TNC9JkZwPsilgEcyySZlg50hNUM5IaqS6bWU7miAhSwrzeKJD52wDrfNfFVoEzQ4DzPy+znqupLK69Ft6gPqLQmTBMW97PdwJ8uyEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=OPqXAvCtiSF0ZuKJJnE+4zl5KouLMcK7xIqhmoWq6KENk1bMNOpmzjLUWRJsfl/XmMdxvJHHdlA/naLY8+Q5a5tV1uhTfCDojPLlFkqxKx+F6yz7OObI+11Cl6/wBaoOwAqC4G6H0VHqJ/LlyW59Z5e1aqTtTqq+mMDTU9uXoxF7wq0DvZGptTU+LPijOk4bgq1y8hue1ANxk9y4lqaF1Kq6G2I36cpCdGunqGmLhFHUWwEXOMXQgIuAPDj4rQfhwU7CZhcJ4Xk8MLbAKdCUiB3zNaDvVZZOP/whFiZzoAodNUYQapstIvDKSyL0qLY9KEI6YLI0WuHWYZV+A5H35g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=oYmcflt7zG4Ek8E7MEE261nC7ypepv+8KOBBfISxGOyU/TCLetwBkE+kK9HJK4LdKQXTEVuHrjiriZlYI2RaU+NEazbbujG2VNIh15WWJ/ErbW6Hml5ZgULplu4SvrBYGoJb0BmxyTz9JwYBAJ1dFTndPp5kqZIRiLr/FDP5Dpg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:56:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:48 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 1/7] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 09:56:40 -0700
Message-Id: <20251016165646.430267-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0263.namprd03.prod.outlook.com
 (2603:10b6:303:b4::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 556cc416-d623-4610-0aae-08de0cd4ff26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xTZ0kqvQPXVuBXFhCdviTFgzjq8yMBHZhrX/5LAEDHK/K6dnWdNx6mdtRcdJ?=
 =?us-ascii?Q?KtImrTrQuBpH1whUh4QtClVjsOqCKeIv4JiVE1rUFqEK+5UxBnkydPTnX4zU?=
 =?us-ascii?Q?OTt0cAuKb2HwFDuA/F2LmB50hxek/NdPrgGcn4WoqesSWfpKP05Vm40EisIC?=
 =?us-ascii?Q?9T7aYGVJ5SrI+9RrHiAOm/1hTp0Alh42dHLIS2juvzW+dYzpbpi+yCcCigm/?=
 =?us-ascii?Q?ck0D9M2an7tthHliH/nq4jZVwEPjg31b2SweNoemqAcQ9fpf2yePpqyCsmqX?=
 =?us-ascii?Q?q6Qq3GRP/gF4fLSX1YclA12YhTnSWD0WjDZFZcDIWtbX5Tn6v+dVSmiqoU3m?=
 =?us-ascii?Q?N+qZsJr4JGQrWYMKyeXooLyVyxRW9Q6yAKtvgAErcfvgUUuDGo6vHd82eVUL?=
 =?us-ascii?Q?mrq8CDRU7EgaqQTvxJTR2s/+H1OeFCisXnEIA5ib+fa0VEWwLrO9ug8PeKIK?=
 =?us-ascii?Q?y15cT/6Ip2Qp2pty+UCQAxAoc0xFKW1pRujZvnEM26bh02ncnAwOiJRm62Uy?=
 =?us-ascii?Q?REJBk+ygycPkIIXcahLp9WH+FFqpLkTRtvyJ8w+oGIzLEKNLioXARnOzoIck?=
 =?us-ascii?Q?h//I76OywP7047snpZBdM9Lw74EHnZ1blOyPgs/+JQye1m/c6yYP/fcU3NtV?=
 =?us-ascii?Q?73HQYdc1H5l+wA40AlKCjYRyGGctZ3qMFoSjroV2R1OBEUNezsErqjYmecH+?=
 =?us-ascii?Q?8CgLmK/YkpYeZkbL2ZQRr11lh57Lckl3kbSNt4cYxsy5IWF1Zc9fQRkD6MqA?=
 =?us-ascii?Q?2EsuLOr+fM3jGJK3uAD80qcHnZlWxHwrnlqK9fIs+PDTPNpH3Ef0aScLiNlf?=
 =?us-ascii?Q?Z5YKNiR56/JbTnda3zw72yPIwn9uK3CE38kN0tGdl599Uno1Y45Mx97yDeQO?=
 =?us-ascii?Q?HdrFGr4i0GdtmSCrzVj+4shmDpLDIDb38QiCiVM2bJmwpP1vVI/b7nh1BKQY?=
 =?us-ascii?Q?9BNV8+eWCH6gHREUZRAxZ72VVb9nRdbQVVNX2ZOA4WSd9VoeUnKqPt+NsR6+?=
 =?us-ascii?Q?j6q6eRTW0HdGQGcsKiW/vZGX5ebJOpT4tZagr4Bje+JFMZkFsVyRNr4/PiVx?=
 =?us-ascii?Q?dDKkUhQfuT5WRVob3yYe815S2cbzrR7N6pMaQzxAAHd7AxwhjnV0SzDyYngZ?=
 =?us-ascii?Q?e/Ipt8w6QyYb3scholq0km9hm+VynyoQFFZbznHG2NDxHYK2JUvoE33aIrah?=
 =?us-ascii?Q?PWm9eSTN8u2O5iOknOgww9bsiZBoWBXnc4UEhqUyrTRudCdqAGRetvioTMYn?=
 =?us-ascii?Q?/F2dDsKQcndCvFOg71+f4Ct5JToQXEzURXyVcy/9XCUHxsvr0boo6hMSmgEW?=
 =?us-ascii?Q?K+kiJl8ISzqyY7vmOceH4qr84WwpLIVGDHwAPzLqAg7CxCJ071kGI4PUsfq1?=
 =?us-ascii?Q?hncXU+CNCtrTz1Ka630DLW1UrFqvGhw2P+0lxgTvrWBi7gzA9ChLqLdQ8MQd?=
 =?us-ascii?Q?SlOuGPfZTIqNTNPSr/q5XKO5YkDDhggW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cOKvMtBkzUpdJWqD6jMSOXNmjeOuSsuZuB1PqlTEunJp7ZXzTthfnojSbfm0?=
 =?us-ascii?Q?7MlCfYIDYFiiXG3gmI+gZogW25GspHlEQtbxhFDEePo6UEW/6SuK30zHkVsg?=
 =?us-ascii?Q?sfGyUAeR9H/Ki50KKiZ2inSu5LVNO3SmFpHtqpRhl9f2Iipq5VeAwwrsFtN5?=
 =?us-ascii?Q?KRgcbwLrUN7Ep4Eq7khyCsoIMFe/NhUYGZFCn41mxssQC8mateq2Zf+S2tve?=
 =?us-ascii?Q?qfZwhbw/3YZaOJ2bCJDlPqacYt1CQ9NlZdAngNLSXrkwmbG70BypbfVbpYS0?=
 =?us-ascii?Q?NN5Yu5CVIRQIAiguYTx59kjcTqFlfzn/JsveJRgLSwgy2qicMpkvylJrnnXU?=
 =?us-ascii?Q?9AQ7OmTWgm/pLxULgtgrEr0RBtM8wpoVbJ6rJJVG+WbUNrd+UShBR3YvBpC8?=
 =?us-ascii?Q?/wULXuBLHJlC7xnbrSB8IuQ3e3qUwIduiUm40433mFoCOYle64+Bsz/6+ALh?=
 =?us-ascii?Q?F5Sb4V+x65WU7g1AOSCpNVqcrVZzHx3ZKoT3gVph1vuY2jmE8x3MTdK1do2C?=
 =?us-ascii?Q?QHEyBpxf+8Z6ddxoHODQSOHpws5x1GYntW3gVLtIgrenljnYsLCz0T8rBJOR?=
 =?us-ascii?Q?HPHe4BdVuBhXQhqqJn346Fwl44O+0ICw31kEw0lz4E9EHdSWpcVU3K+26IFF?=
 =?us-ascii?Q?yZ0um9lL+1W5HmhFr6fMfOey+uSS0NU95PTz6BhFZ7fsuPMSdHOIuS5EUgHU?=
 =?us-ascii?Q?KSH+YCweH6km7WQfV7HzMJkna98ZSTGxXALiq5zAMwHJxGKciYOiARUI0apR?=
 =?us-ascii?Q?Wt8KWUAnuj5IIlJTAXs8d5n+Jb0eveZco6gIztriJ1LhGbpr5KFxBAsbWtYv?=
 =?us-ascii?Q?EdVoJ6nbua5rc25DMalto9/EEPaNmp1os0fT91A+8B93wWeu0ss9UKyPjhtv?=
 =?us-ascii?Q?eOkYfzG6tOxR7U5fgdaizztXq6H0jEdNrA1CR38bJcKDX8NNTC8pVYAiVCKK?=
 =?us-ascii?Q?dByUqqjrR6GgH/IiSaYg58hulpMaUdtCV5Ou7crMZA6FFJRACPugmZhcImej?=
 =?us-ascii?Q?hGQApq3zY6moOIjElD9h/WdagIFDVQW6wWdUriv7H0NYXEuYlncO34oORv8E?=
 =?us-ascii?Q?opwBV1aphvhDsu3bmW3GaBpt20Gm0+C5P4FEIXAIn/satfizw2Dn14li5sJg?=
 =?us-ascii?Q?5R6ES8YS0tyQ5Ck/L+2aUn+fXCm3q0axN8fVlVTB37QfbhJGCbA1dwiUdv5J?=
 =?us-ascii?Q?H46/4O4asck8JWEMqQv9XqPSftvfhmzrzm9LeqK0Ma2hzT5hbv6xdLKCskhi?=
 =?us-ascii?Q?0kk2Cv+2jE9rqFlIfq9odpi07Fw2s+GAlhIXhoV3e8UfH0dmyoWuHosupwTW?=
 =?us-ascii?Q?OC790lfpdLxuC61YEb2dR28YPFk5rnbqnjDbmOPJ0N+oeWJVXOLOY8BDtJCr?=
 =?us-ascii?Q?HeyfuGmfbNDZ4LZatvylLstIYIjKSyBZV9PAN63E9W6hgOYgxcBk3zuKvDdr?=
 =?us-ascii?Q?F/fK/ujQKN2Qra9GFy6GlgViuQPMK+SlZT3avRaM5ZRMwus61XPiskZ0rFCR?=
 =?us-ascii?Q?qHNTXiXqv4QquutuPAD9FDf8Z5HusA7CReG+6Arv6EsmgtEJ80k55+utmW2m?=
 =?us-ascii?Q?tUYWQYa5TEI9HZCpGe1gj8u+tDG4jtw+ivtZmynhO3uLCvuCDkHMRDLw4vZg?=
 =?us-ascii?Q?Qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7e5VDJTrgLVpd50A6E5c7/5tcufcrr2ivCeI+OzEr3bMbnkyr4Vl+2XpSM0j3prU7RS9rcBT+/ATDzZLBPBcslWnSwwOYVZqmGJM06t95NG3Nu/98EKgSjrTBJfNbdBVbvaNzuRSDkt24y5c+9RsrSoZqI7pZ+1d6vsqsg/pgQYnH3V7JZODZeRxNwKBvqJySNTFI5z9r+MZtrPOYc+iHMZWdvXPcV0Vh90UfHzCVvuumwWmjEzY0Cih5cnyZYxHvDf0VMmjQf8agBwzXulocOZnLKfplbS1h7nTHTgLi7EWtPHnnSA1VHc2JyoDrS3Shz02h/u3+0VCKhCcbkkBT2D7Ms9ITrSCZU9LzXmjBfC+eBDCT6gqO4vQ3yzincpS2NczrnSSBi+TmlDEF4q5A0Vyob7Y4CvPpnZIEj9Jm118mGGq7Af5o3bFtgws53ReuH8IhwPYBBH2T5stG3pdROAMdDoK9cqjXlGRk4/aL877vbZ6Z4Yo8+e921zX9dNoqKmqEJ90vhVFBV/e4KhY50FjI8LwG4v2Lj4zgtn3OiIWHwslbvvSqdszgSW1R7yIbkxd8NKLVvWb2RtNezMm+mPBMHqc6HjUsfRGdNElYgE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 556cc416-d623-4610-0aae-08de0cd4ff26
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:48.7746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2XCbhA1QrfllBnFMVkaA63FtkhZSBHoi6WdAdpr+bTcBiUR86AL3y+ARwa9jrbRQ/YILYihL8nPKkGhaq398n8CnxNWVOodogf2StO1JZUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510160122
X-Proofpoint-GUID: CyAV0UZIfWvtAikr6AbVo2mrVy5-2UoC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX0wcjrs9yzhz6
 vzmSk/Yiyc1C1/i6Z9PEni1mBHOEmBzSHkdmvtf/xZi5AjSOzLTf9VvhQNP38sgYr6WJ8Do7iao
 vRu0IlNrfX2urQxxlWZwT4sTd/VpED1zVxDhp7kLjmMoJTt1KdToB7clEMRT+0LgxUslX+uQ4bd
 yLF2t7G38GyXs377qxCcbcuUQX0Fnvr8oUs6zmuCS66pp9LmbUQSgwLIum99LqcZ0RF92+IolbG
 cFUZ6ItrqDJf2G2kMseRC+la/Utoz4nkErKiXOcqY0etjBvZDWwuTi1JpUrN1DVQLTgBiJ0ujcu
 sZltc2Xr4zOioLwCmlxXRzNfB/bv4CiVdoVCT9fVEUjEyegnJHKsGnW/7GyxvpgE3Fnzc3bZhak
 jQou5adW63vziwM1Uu2xIQMbdL9zWg==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f123d5 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=tAfxz9XjlOImCDDYAN4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: CyAV0UZIfWvtAikr6AbVo2mrVy5-2UoC

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The waiting loop uses cpu_poll_relax() to wait on the condition
variable with a periodic evaluation of a time-check.

cpu_poll_relax() unless overridden by the arch code, amounts to
a cpu_relax().

The number of times we spin is defined by SMP_TIMEOUT_POLL_COUNT
(chosen to be 200 by default) which, assuming each cpu_poll_relax()
iteration takes around 20-30 cycles (measured on a variety of x86
platforms), for a total of ~4000-6000 cycles.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..0063b46ec065 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,47 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_check_expr: expression to decide when to bail out
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL);				\
+		if (++__n < __spin)					\
+			continue;					\
+		if (time_check_expr) {					\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


