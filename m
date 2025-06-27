Return-Path: <linux-arch+bounces-12480-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C12AEAE20
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 06:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD612188FA77
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jun 2025 04:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EBCF1F1311;
	Fri, 27 Jun 2025 04:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KZ880NYE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="qxjbecM5"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666871EE7B9;
	Fri, 27 Jun 2025 04:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750999762; cv=fail; b=KwGEqvHasHNROxLoptjPDJruZm9p/JLA/u24RthVblmawgcbnA5HfGz4E5VArIOhaau5TXsXrH4Ul3hJE8hQtrjnCb6ssD+wmOatQFwdKCgs9xYAoLayewPKue4HDZUaxVeCXdkZuYGH1QR/RFUo+jM/pxPlpbpwLlAZVklf3Sg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750999762; c=relaxed/simple;
	bh=EXTSBoxTovHgeH+GspZVZ8UrLEtJzQN2HawCO/baHfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lW/OiPumaaPCmmxGPOeHLooOnuEmQfouGEZ2/8QyPgln2DztpO4JFbTdB9YOgDMmrBiW7xJN5Pq17vsQ/sk1PUIgd79gxi0sQQzq4O2Hs1h2zqdcDlMirMSqbhNSBimS6pbRFWEPXdCoyuPWc1njqI+DwbihNIpBkgvHBRcjCDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KZ880NYE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=qxjbecM5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55R44QuK013196;
	Fri, 27 Jun 2025 04:48:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=TWUqxXSdo+tue9QnA7O8nAot6JEIB39cNd7N+f8UknM=; b=
	KZ880NYEnNAR6xAmXg/hTTSaT/KdgzrsVJXzkEQ71/oGnmlTD3MJYggXDgkZdHFU
	ckxTh2kuE/csYqMZhqVxzYB/4mj22FgA11qzzFsKfGroZb9P18/xV3rAIoyvHU67
	npJEQCkELMcmtgKUT9G1+S/kftOYbbMWx3xeC8xPK2vLZJ4PV8Od7qj2L4yKqmfi
	b/scC3eRgEqq/JRzgN3bHABDJm8miETTyYsqC9LwNpzmECBw152kFEyW7K5RFPET
	Av0mdSnPGCSX+WGFL4XFQbKzPrOfJN8N0xRn6cD3OKwvqXeQxK4WDvY7mc9F4Bbi
	gYS05/FkPsYhMrbaxxFa1A==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47egt5t3fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:24 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55R3tESg002527;
	Fri, 27 Jun 2025 04:48:23 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2064.outbound.protection.outlook.com [40.107.237.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47h0gvt5dm-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 04:48:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xcngi4ZanHw5KKd00kRo/0oqU4BjdUBwtlrnlY4rQKdOGqcP8DiSiGVqnk2K61GieB73DpuCe3TFNv1jivAhgCLMmNLIGRB43A3uE8yNYlesqxs8cGVSLWS6P7y7jVXusr5ct1eS1ASqUfJngGIt1/azdQi2Worvtz8eDk9zfqjL4934CZCwV0vDz7ByBQgpdypdd0qXRN71/yBR5884hx2Zsm5wyQhm4JvTsxD775RqoU30JsUQQzNN1Lu8Aqvykse97CSALBUSV8kvoZVeC6PW14OTrsK9fEp3VjcWb67jbDphlNPk8lcBoijH1DPnP3cTGG5uZ5p3nD1sWbicgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TWUqxXSdo+tue9QnA7O8nAot6JEIB39cNd7N+f8UknM=;
 b=uZ4uWywg/9AkDUVm2x/dZWVZCN4PSuGlt720y91q108VagKvUkayII0okXG6SScDb+hrmTOg/uWDJDjUCyN8O3KW5vb78Wcz8rPW1mWZdh6E0O8ARTw0PAIyf70m+a4VlhXYacmzp8E2QXmGNrXJVupVQLY4j5NrYM3GqIPRvvzEs7nYPqAluP4MTzewknU4DDPhiUY5UiugrMwDZODssjZH5xkW8u6JvZLlpQwDxnBunFehQCehWoh7p9lq81rGssHVX1oTQ9U5NoV9jAUrFVhPsL3uHlkhOF8giUOQqFzrEw8HnzgCEigt7ZaNr3ciFBplf0LhCPaz3YZIwDeRhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TWUqxXSdo+tue9QnA7O8nAot6JEIB39cNd7N+f8UknM=;
 b=qxjbecM5B3mKE/slyQKd1DXewBdp/3BEIDN7AeCVlqMkV99+jVP2XQF/mcW+2JBpk6x4T+fG+jISR70tq9MpPep37JACvuatjvDDtsSxZJdhHW1GDYSzi5TrWn8fPFT4VsRC0vfffDC6P41vDRnru8gs0RT9FCWim7kANxCpnIY=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH7PR10MB6335.namprd10.prod.outlook.com (2603:10b6:510:1b2::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.23; Fri, 27 Jun
 2025 04:48:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Fri, 27 Jun 2025
 04:48:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v3 4/5] arm64: barrier: Support waiting in smp_cond_load_relaxed_timewait()
Date: Thu, 26 Jun 2025 21:48:04 -0700
Message-Id: <20250627044805.945491-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250627044805.945491-1-ankur.a.arora@oracle.com>
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0345.namprd03.prod.outlook.com
 (2603:10b6:303:dc::20) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH7PR10MB6335:EE_
X-MS-Office365-Filtering-Correlation-Id: f9691659-f029-4bad-6670-08ddb535d45a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?umEu6HRzJUmeBF5yHtLLj/Qp7DD+E48RbACf+oUPR78sfY90wDYKMLaiWPJ0?=
 =?us-ascii?Q?r/IRnsmUxdXuSSaRMt51MGCH+2TS6zSkk96nlBT8yDhCF95xqNlg0jQ0K+SU?=
 =?us-ascii?Q?7KJq1aLNCjWEE1d3nt+DfZfao6wOe4F4CVUL+b+iDOhsJgoKr3S80QXaGflu?=
 =?us-ascii?Q?Gwh0+cVlFbF5uTUUBxDJCxveohwLD8aWyEGYvutmasN1zQTJHjENLYftiXvs?=
 =?us-ascii?Q?cRyD9WWFbHmJqik7HZTDef7SIS8S+jnyxwJ95XSMGwtRhqHWLMhOUPFzPI0X?=
 =?us-ascii?Q?SyRl24P6l9JsUfnmKP4sC/idEMj0cP/vURV3rEqCuhPdFWipSK0og+7PSLxN?=
 =?us-ascii?Q?MWQZGDq3KIjl3SrDwbsgb8/2Z0iKoH2jtO/CDObxUdvRgGYdhEgLldIsOnEo?=
 =?us-ascii?Q?ORCuzDEUsEDNJaTjrGAmIKs5Xh4THg/wmLjAQog+38pXF71IXrlrZ2PrMyxR?=
 =?us-ascii?Q?KNtXz0lCoRbidZfb27LjDEAsIj2bPTeDWHKGgBeb7li5uqcYhN5edB2Fr/JS?=
 =?us-ascii?Q?8bRa6RSscnJ7W184zHfIftYOje6lwhFcwZfqGCMKv4NtTwuNTf64dCdacngh?=
 =?us-ascii?Q?oAwzJjHPAMJb0Thn+07ZMJ1EeBwqzIvjKYPKr67QqhAyOUXfj6p6G+w/yYkG?=
 =?us-ascii?Q?px9Bc0Byu4l15A5bG3XBUqpZYsZqsHr73Zcx7r9IIbV0SucBFQEWB8Jhx8LL?=
 =?us-ascii?Q?O13lxFM3/y/CHezzbcepAHS8LVWmUIX66hob3BJ/Rlu8Lt4GIZy3nYrrkCby?=
 =?us-ascii?Q?l9t8Rk/SqwBp0uBM8cxFq1o2Myph/4F2I0A3ZJtMk6VnTCv1jBqZPKAwWbVz?=
 =?us-ascii?Q?1g+Sw83mQekAHl7Mmu3kdi+XSglaKyvo0IwCZ/LT2yH4dvpqyxmPp0w/A8cA?=
 =?us-ascii?Q?zLN5bEvWavKFwe/9L7lI3e4vqQVYufVwsCRHHoG3dNPEjNW2Q5/aOkA7nRbh?=
 =?us-ascii?Q?ht4NErswGzDTP//AYxOd0aJsVcn+EWAmwqPNIUbwfRBqFee6+iQ7x0aO8DiG?=
 =?us-ascii?Q?XZOOQV24g3tP5WDqg1NTxIVaj3QSlBACwy3BVt2LM1L+7ZcqE8V+M+/CxpoF?=
 =?us-ascii?Q?AtxzX802/xl+auw6YaDlzepBNa8j7KqX5Jeg3uIhkhybubItC3nAPljUaBKU?=
 =?us-ascii?Q?KlPVBrtrSTFm3z+L7topVbbb0kIsF/r0HBf8Isj6+UaGmHIjhO34d5TnOjCU?=
 =?us-ascii?Q?QgPCmDgqpqBRhAycF0FtAvvF/bgPIFg/jluDVhM7X9v1+d93EVbJg8Qqy2Cd?=
 =?us-ascii?Q?T2R2QuGnheX0AQtnwbyFxVqjALvhM1MdPglgThHawdYo0kl2jPhxKZOXKYcI?=
 =?us-ascii?Q?LV6WclUz0QZ5meoC5/Rr4DMR4cgjdpvfzt8MsN5CfKKzF2TIUZjY5TQFVqNR?=
 =?us-ascii?Q?AAUvHDoSjyzVn5r2dvyBsqCO3lM5RNrx1O2sGHguhzfCiBYWD7ObQKWejeuc?=
 =?us-ascii?Q?l9cu4WdjnkU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?S5MuGHk8EaIAEn6N3kRbriY3LGb3zfkNl87V6gFFlugVPYcLzvl+EvWR3QCo?=
 =?us-ascii?Q?9ofvPSilNenps+7uquNY2W3UsjSakxqN+sx+sinPgIpht/gPhrPKqtQlTDgt?=
 =?us-ascii?Q?076gx1pFReXPtgDpMmDaQGmukLQnojTWHwF7uwVlhDzVHAQpc/uqLPvZzkzV?=
 =?us-ascii?Q?elQq0T9ThrQu7JpCg90X+D02goFUiyMUdrWy+ILB8/xb1gFsKB+o8Z5KR8i8?=
 =?us-ascii?Q?a6eWwHPvEvxUqvgBos3uSGAE+p/c7rnVIxn3uwWgqCGuJhPFzeA5ri5um7KU?=
 =?us-ascii?Q?SsfyuLRr31Pr036YOnPsX1ZMLElp8O9i9pTU7uwHCgUOwXWK2h8DS/LFIeyv?=
 =?us-ascii?Q?mEQeWVXAju25oCkWLOvCFwhjgsu/acKBpLSg3/EBSsY+EcfP/bmVoY2I4lOG?=
 =?us-ascii?Q?KtpgE4Z39njUybPcxdK/S0YqZTXmzt5SW0OLPeHUKbWpfeaBEaPgWTYuHC/A?=
 =?us-ascii?Q?+yiE8GDak26lu9NqgwHXWfqiWgydXU4BJg/+u90GPiRpW9qwua7QSDPH3st+?=
 =?us-ascii?Q?RIFuL+Y/3h6LDbXv2AYYt8xaD8bxlnNBdVyTeaZERhhKMv9R94XMsiFI+fiM?=
 =?us-ascii?Q?0gxzQUGANRItnZdYyDrB7bYrfMFlzdr0e3g/J9VcO5Y0cU1JGDx+yxMWTVO0?=
 =?us-ascii?Q?ohBVyKsCKoKwP4MFLOQW0AQaNZNETgwOfP9Go3KUVHb+p75/1rR8JTSrX7iH?=
 =?us-ascii?Q?Cyv2ec1JG51dlc9Zf9r13BVMmAZidl2Dh9j3GNxvDrLqZSg9n4zwkC5+FMwf?=
 =?us-ascii?Q?Rk18Hb6ncJO7U/rC/nTadRfj1daZorgmGDvLk2fj9neZ0fsV39mphei2VaAz?=
 =?us-ascii?Q?tJQ4+FKMhC64gmwb8nKL4AwSbH26iCRQf69AWlhdex16VmMjVsQnzYztRmYf?=
 =?us-ascii?Q?IHQrpZRIHpcQozBVSTj3yK6/dOrrE+AaJCb8OkxwC3VDZiylXZz19pG8pFqe?=
 =?us-ascii?Q?H1gNhVEJwvdpnqEk0sl9IEvIQgfiXeLqrm+ONeIce8H2uxdHyFIbcbrAEeu7?=
 =?us-ascii?Q?AyJnnBqlFKe91x03tBVh+0cXFeAjVzyQ40Wzv0NzYtRJm8/fRRYDKMLEploh?=
 =?us-ascii?Q?CoZoTeFxeKuhccStzVDuZyZKau+OocYyetiHYR2iaAYzBzsOwhhe/m16v48n?=
 =?us-ascii?Q?+YUCDLAultpm6XkdSPOhS7i0MteWSXzSDhNfawxLMZTaEMM+ru6tXNpQ5XTM?=
 =?us-ascii?Q?DP7Sx/PzhTSuGe02yY8xarFN/X5si1i9sGjgnhvru8UAS7NoJqgsDChiclWJ?=
 =?us-ascii?Q?YvaF3C76SVuSIE8hl718uxH/JAAh4Hh9FE7Z1qMEY76N9R8tp/S5z+vplPCz?=
 =?us-ascii?Q?jvEr/2cxyH+achQYMsmIEiJgvFz4oquNu/p/UEwyEEhtaU8bTa4nc603wl98?=
 =?us-ascii?Q?Ticy3FXh7URtC21iwmNBeAkGCI2fKrm+KcM9bmvMcLbiaGNklrzydvQdRdR7?=
 =?us-ascii?Q?LopXS8/hpVXoLV5Vjacp+I+qQdalHcii8SuED8T6IXDKAm0LsEQtINfSpd9Q?=
 =?us-ascii?Q?Hxa3a6CWi+KD6QEw37ibfSlbhUBJbC2RY17IC7PqpDVQ3lVhv6wPTYXlxrhc?=
 =?us-ascii?Q?rRI3qzjfA2KNljjnIs9s7A0v36ZsDBbxwPgkW2H1FHghI+U1mVQbx7hv4eOH?=
 =?us-ascii?Q?mw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DWeXMokc73d0Pzyq9qQeygRfigTXs/VKOKzEKe0LHJT09D2p2Zkow5o0oaz07snw2qQQyjosJEXuymkp2tiB/Avv+BoZgbR6aJI2/XNYbZr24aAKsCKpIxli3tXUsgo5xUGWpIwOF10ldAfSV4I+zoXIFOYIsIY4OZsx9zs8a9YvgGUF+N2pC3z2lCj+XLz/WyHAdvyIw7ivRUTZburljgSKvyioGCSAzSsIxLN8z+YK2HEIVcDhTo+gQS06HQxnN985FQ9rb8mzhT2v4FR2wg4kJdyEFY/iY+CCVEDgbKsJ8ptF8RI5RvNkklNfvss585gkl7X2PjLkR2Qc9ZZwpjTecYlNUk87coah8QrAAZIIKaKBBYFDmlrumdz24OFDoHPiwEEd4aQh0akBVDaD/mPChSpFxbgTwc/rlbYl9uoxUfev0Oz1Tp/bCim9FIC9AE2WuifQqh5WQdlwP51p8jUb9sMXukDo0dZv4rosfq4XDeQFpCTbx1LHLn0ORVgP2InGTKgpwKADnp2BE/XY0i98q0bRYq6Pw2/xweWEGDdkSIeaucnYeweHkaleSSB/6bTrehqw12PxndluhjqoHFp4CilV2XuyRMdH1Ep+hSY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9691659-f029-4bad-6670-08ddb535d45a
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 04:48:15.9362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jCIRadkjTbQsrhruwn/jvGo+uvR5yz4ka0ojFlVUZ77w3DxV92z0/QFRD1bgpyIqv3VjDSx9cjWZHA6rZT9TMC2WV+9ymZckc5aumN5d+1A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6335
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_01,2025-06-26_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 mlxscore=0 malwarescore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506270036
X-Proofpoint-GUID: 8S9qpXIyPymiaM9tNY-cQTjK7saQYtu6
X-Authority-Analysis: v=2.4 cv=PMYP+eqC c=1 sm=1 tr=0 ts=685e2298 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=PuvxfXWCAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=OlGO_YRW4t7pIV2n7igA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=uAr15Ul7AJ1q7o2wzYQp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDAzNiBTYWx0ZWRfXwAufbPlJrQ/x S/0FPh98QvSlYecBxV20ezKGaHMB1unGTI4MrEDYOPXnRahwcbfxzvAaVSM9+gyicsi0/sgQJKm k2S49BLdZevMCPQjPleh1yqpFlihkFu53u7YgGUiIMLN6g9xdgOXVf6vtcQ3Mu9y18eGWUBZ2Qp
 2DPKNMuIoRxJzvDvYxFmp3BadYBTJoFGUTv0d+3gAyDdQX8AnK/SZaY/FxYr2k8fW/AIJdQnLZF BfA5G+kFNbX4uvs74SMfE5DjOpVceha73i2Dskk7Mv+CTsmEWT6q8gf6h0W73FHQLdnWLCb9nxb db+MPTGITjPntHdCgxlnUfATwOkR/X2MHKl/TIm454Cu/7zWDXZ+xU04EioK4NjgVGLCSMm7q8V
 oIQQvonnW3oYEaRsDP+WqIMOUNW0cRIW7Uqhe0vvTS43ZxKgEu3ojVCkd80nWT/ZHjno93fg
X-Proofpoint-ORIG-GUID: 8S9qpXIyPymiaM9tNY-cQTjK7saQYtu6

Define __smp_timewait_store() to support waiting for a condition
variable via __cmpwait_relaxed().

Used from smp_cond_load_{relaxed,acquire}_timewait().

Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Christoph Lameter (Ampere) <cl@gentwo.org>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/barrier.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
index 1ca947d5c939..7c56e2621c7d 100644
--- a/arch/arm64/include/asm/barrier.h
+++ b/arch/arm64/include/asm/barrier.h
@@ -216,6 +216,12 @@ do {									\
 	(typeof(*ptr))VAL;						\
 })
 
+/*
+ * Support waiting in smp_cond_load_{relaxed,acquire}_timewait().
+ */
+#define __smp_timewait_store(ptr, val)					\
+		__cmpwait_relaxed(ptr, val)
+
 #include <asm-generic/barrier.h>
 
 #endif	/* __ASSEMBLY__ */
-- 
2.43.5


