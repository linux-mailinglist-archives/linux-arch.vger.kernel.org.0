Return-Path: <linux-arch+bounces-14359-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F578C11552
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 21:12:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E3E1C503600
	for <lists+linux-arch@lfdr.de>; Mon, 27 Oct 2025 20:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C7320A32;
	Mon, 27 Oct 2025 20:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="sKxx6e4D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tFPZ3Ffe"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740E2E03EE;
	Mon, 27 Oct 2025 20:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595630; cv=fail; b=Fw/KzonE59XLCa76W+c3kkFYGvNUaWN6V/jFKCVtjFnzdJ3F2CBvLfe9bPL3UKI6fSCnp0QW2OY+x6KqDXm8vf8Q656bXVOUPmaXBAbnuf5cbnCMrCRSZgUJeJKwaakCr+kVh3pFByZlYNzowmBRx5UynqX/nUEsnXdjdjcR7kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595630; c=relaxed/simple;
	bh=jztjqRnxsfo1Om5+nXe+Zqveq+WZRVaK8j7Z0LIWwyU=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sWbeeSHQhFwY8/kmV5mAw4eV2/Td7yDIfDtZLhJ6gLbngPD32fDo0FCj0bMwgES4hEwjmWmv2HQYhRjtznMUko9iArjBqNN87A+/PV8SX37hq8lEdW7A8n64sXXZHyQXDo5pfJbxniCxeXXthSgBYanVoq4bFVuM0jfjdKKECvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=sKxx6e4D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tFPZ3Ffe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJDYli019607;
	Mon, 27 Oct 2025 20:06:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=j4zEJSKhVt8+lSN9rV
	LYEW2jE8s7MkKlQMJJZnmcJ64=; b=sKxx6e4DicO1MIfbJBo0VglFKdxjtOPcdI
	vewQUhgzqJR+OarNpCNx7YtUoP/tD6kj+Rp7/q1nZLcFK0NXBQJ8JLfSJMy834DY
	Y7iKQ5cRd4AZYxsdZlmgtouwdiJydRs56rwZfZ/hChU6l552D7oLkmeB5fhEH5CQ
	HZh4MTl6GJBBQkYTB/gx9k4Ij932yNKgtAxvwWg8MturxX+M3Ykn9Fy5ayGBpx1+
	kJqma+6flYbmeaDhUSg0jsQnUTmaCYH+089eUjCOuBixWeCRiooFCJMzGdAfHh5b
	+n89BRPIwsu4AWvB2eWwX0Hm6rMSsDJYyHFKCA6SCpbMiXZzCy/g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a23gvhua2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 20:06:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59RJVPNj009120;
	Mon, 27 Oct 2025 20:06:42 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n0egq9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 20:06:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YlyHSElmSkePXMQcXJz1mQDXsfe673wFrvV78MTgaKminL09RLcdRpWZUbHehP0K3cLqb0ukA5jiFfIPTaE4MzQzkQKVZ3aIhFk3LnugpLs57ZLUmsNEY5H4clloo/JM0fsGJWS5kNrVc7QocPOwrl/b81V1et1HsbyeC6Jr+CeB1lvWxkEDFD3boO+Grm6bn8XwTX/Tkb+p4zclzskRMRP+ciCkCVjsydarqvklvnK1ZzUyohAScaxHW7/PiqwSxBqQm38Ek7ByUOUqhECKI2diNH6L+mm4NmsBq8Z6iLAhSjCiSRBGHFVGIC5E51lU207sq1uzvuhghXY1WftTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j4zEJSKhVt8+lSN9rVLYEW2jE8s7MkKlQMJJZnmcJ64=;
 b=mmdgqjvgAI35pRgz2X4xyuG/gNwtGncztlV1m3ybsviRClQYsiDfC9yILLkKDU+nrzBRr5ONrDTbuK9lE8PR80KvP3aIjVuVbCIAQGBc1JZCI3RZ4VjAytqA+m0MMrA834HEV5a1tT/O4ncJG3c0ATbrLFgq8SjLWxLPU7WBviumBDeHyRfwUDmPiEcVobKuSVGnDL7sIR/MJMP04Y3QQ1nkLqYeTqdpeMHHHO4XkR3StlWCTcrSoBQEVdKH7NUGPy4DlYZhjJ2/oqW5i52KCOrORqmyKPdzcmn3rcDtlqiV5rTzw5K3TO/FOT/ECRdqKH3j7C0PLwTI461Cd9bM5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j4zEJSKhVt8+lSN9rVLYEW2jE8s7MkKlQMJJZnmcJ64=;
 b=tFPZ3FfeTh57RDnr1AEKwPQItBIM96UjRiK3syEURwrHlvW5TqsfIaYJ4NMsX19SwOzQajOKHxWFqwEG2rhwH4NDAM70v9hnLAvTb2uTLemQnNKZMml9qdDNMX+Ad4l3MHRCMkQ+HsECBmzUrws6x9YlIn44AW6PERTkYXryd8A=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ2PR10MB7559.namprd10.prod.outlook.com (2603:10b6:a03:546::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 20:06:32 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 20:06:27 +0000
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
 <20251017061606.455701-8-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v7 7/7] cpuidle/poll_state: Poll via
 smp_cond_load_relaxed_timeout()
In-reply-to: <20251017061606.455701-8-ankur.a.arora@oracle.com>
Date: Mon, 27 Oct 2025 13:06:25 -0700
Message-ID: <874irkun26.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0203.namprd04.prod.outlook.com
 (2603:10b6:303:86::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ2PR10MB7559:EE_
X-MS-Office365-Filtering-Correlation-Id: d7993256-f75f-41ed-c638-08de15944fbb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0CLsjy1MiOIFt7AISDZOMqiZn8izSbdeo0R9kWuSsIam1h8UMhQUZChOQMns?=
 =?us-ascii?Q?VXHiakyYPdwUirxJ0bUj8yMPneLPx3wKUKoLGRbpViYF/4mtPilUey9xDsEY?=
 =?us-ascii?Q?H9IQpaia5axwhKUKGQslP6ouSDqVFSgjTOJnn7JFMVMG/MpqQj6azW3rqQdo?=
 =?us-ascii?Q?hsf0Af0dWQnW0qh4PCZXib/8JcUTj4veugNE4zALQl2mUbu1MEpvusHC1unS?=
 =?us-ascii?Q?CaKevqBQPtiN1AxpBnmjjWMKZRyz57f/v3uyZi3cRzCbKySu/UgD8IhHBt4B?=
 =?us-ascii?Q?P6E8DPvXNakEqltcHaTASFAQSHciHtKpLCLaE44hd9/QhjiZ73hEa88GyNww?=
 =?us-ascii?Q?NaLxb1yV8E1POywRbHq/HZU+9mzmmCBqVtpWjIp6EV8eE8iSKkFpUHHt0aV0?=
 =?us-ascii?Q?LeuQu14IYRZIRQ5cKrLN/uq7RdF7wzHN7yoZT7SNZ0zfSNemfySjU2FE+7aH?=
 =?us-ascii?Q?rrx9XMV+nZK+GZ5i5A8Vcdt1xChDpyy+mX3WPYuhJJiZ13hWDK9Nrq3lxtIu?=
 =?us-ascii?Q?KNdqtPPVB7LW63M2eK23gYc6l8gyJLiIsZY7qTn8e6AsdO3i+iz6ujmOpBDN?=
 =?us-ascii?Q?2vTGLuR/j1qi+eqh9FrFnLFvR4+KB+MGAKkmp6QFnj4metQ6H2yVm5Rmj4WM?=
 =?us-ascii?Q?0gHb3cHaUV+U9HsY7a+IxjpIRz1qh/aZ7vmIztXKzZnsocZdma6WnLzCruSH?=
 =?us-ascii?Q?L5r39ZoaQhRH085QSgt9PL+zRzbkZrUp7sWe5cvNmCKvBbMcj1Jnnd3Ojfmo?=
 =?us-ascii?Q?9JIJ6fEagFM9HNcaA6Wr3hYVE7rneEV8D6ioHrUfcVfau8kc7tnT9rkiFIy4?=
 =?us-ascii?Q?MtR9HXJ3xm1Q1A1AmelLHGKIms7ZG0tK88YdtQzrj96l+6TrN2SBJg9+192h?=
 =?us-ascii?Q?aP6RkHQcl5WH2PL6jFx1EHERr3/Js5M/iacPi1Q62Y32xR4neEo1Z9oXRf0b?=
 =?us-ascii?Q?hMD3fz5idDUFEogzltCdFSEAL7Xt/AXuUG2M4PZp4vzE75OSHGiuz7W/eFqe?=
 =?us-ascii?Q?30x4PHeupWkjOsHFmkz4sTtbR+TIXXRfznef4CCEICxs2mIu77Mbb7rRY8Ji?=
 =?us-ascii?Q?RL/bPYfHuoQhwhxQ7qD/VdHfq9c48E/RZANo/NAPsFHIAvZwRn2l7DVWDCMk?=
 =?us-ascii?Q?EGyNWmUjvkndBKsBqjzXjhCbk9pa3/9sHAr66Zc2KOHXMnJkDy5AF8DQUdzq?=
 =?us-ascii?Q?NXyJm8ipUY0K50xjofBLk1VodlR83aV5P+KuM4p8enSTwGIHE5wLWUzTI4fl?=
 =?us-ascii?Q?TfXnnleZ+MO5rqCUmXE68CeBYS9AIvjkCsvdQPAWfKE/KH1xkSwnKPvjcG+m?=
 =?us-ascii?Q?WXlcEe+AZodZRzI4SliNAA5mR8YZMC8PYfJlH7pAkOTWynZRBYBOxkOa0ams?=
 =?us-ascii?Q?jx1X4RXYlJFVmKrtBOruh+sOfyMD5YsyW0nHK03DsPEAU/4wIKuFxpJQ54vV?=
 =?us-ascii?Q?lgoukZ0StZeOIXm1UP8rlZcl4MsHQxdP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rFEN9YiwkVPxNgxfCrpa6mhWk2hX8O9KU64t63aUZRRqcVhh3DsYICH5hS2l?=
 =?us-ascii?Q?/7nW6PbB2uzicqvz1Sqmb0/KxKuk5CLvy5yrLAZ8t9Y5tejbP5nhH8hfwo7h?=
 =?us-ascii?Q?0n3UKHrqT0u73iFnjVVGkegeRBmmE1N5ZF5wG3G/7rc3X1lYPIfErDYjaDAt?=
 =?us-ascii?Q?8r9F7KVKBVnZvoj6SBJ1QfgebdEMyqUbyrTsqgUErev5SnjGaXhyOFs2VyI5?=
 =?us-ascii?Q?cUwL9D3B7f4Khj2wOXICWQ+oEgpqVCFa2UnDzFqaSFFG+iHGHPHj50gx1CnA?=
 =?us-ascii?Q?7oL6AgxOL/0z7fnHw5ZdkF4KfHRVwNq/6Vu6yn+zQNdxshhDe/ggTeTYzRL9?=
 =?us-ascii?Q?Sxxb4CBlEXOOxYJ+5B1+wUbbd4zNSaF/RgBOgWrb2pC6GBmxw0m+Z5AWQLvd?=
 =?us-ascii?Q?TtiCOCBR9El7UBeJJkzhER0qKpgiOGqyRrziqXO7AMZytmQFAnNZKxwJtffO?=
 =?us-ascii?Q?Xa/fcEUt2+bnJkuwf9pvpnZW5G3JzGxfyyKs95SuEsEt9DMsLnoKhbwz8eLp?=
 =?us-ascii?Q?SyK5OAbf1i+Vt1blJvV+Icklp+mwcps2pdVZl0oksJlqLqIO77tm/f1qKVzG?=
 =?us-ascii?Q?ihJLecDtV6M9H+hh7N70RNQEnUDYfQ35r4Jt6GtnQuJCW533hJbBRDQu0V2g?=
 =?us-ascii?Q?F24Ele/IFl3XF3Ggw8ux+IHGSwlBUuljxSV/UXuc5bbfdBcobM3pofJVOm/9?=
 =?us-ascii?Q?HwxWkdWl/IWvBtZk5vhVo3PggGA8gDkaHNSh0fJtdQYge9/wYfbmZ7APl0Ew?=
 =?us-ascii?Q?N6DxXMZlWtO2TfdVPXMfWCUvcugfUOcel2SFaU6zKUlBtvgtY7L4dencnClI?=
 =?us-ascii?Q?Dq65n8DY3+x6DVjGfaa6p49tKLKZt2tl7pVWxQhK/e6NKA/0ODYyFmC23qpk?=
 =?us-ascii?Q?P6OcPmiwiGeqoTfXDDOE8FIfZQtt2Ej/kQ3K1QNbiWCJluSGbXnrpIoowegu?=
 =?us-ascii?Q?ntQfVEud70fA+3YjdzBX782+vp+JrQnlTBvljjs4yOcQvRj54auLwxxN0uRw?=
 =?us-ascii?Q?QrO30AaUssgBaWfKRnm91yF8vqA1/XAg/K7rdCXG/OWWM68+iOyFhS+QlJpr?=
 =?us-ascii?Q?3iDaq9Yv2jQt7J8WASRs0SIPa+q7STFuWFDVCilDDdPCZ7AUKyXhrkrJmE5M?=
 =?us-ascii?Q?H3hcWd5/bNUtuVjHS4ij4Ik2d00Gy6z34AfrZ64m74HwzsV5+ItqB79I3HxV?=
 =?us-ascii?Q?APCIhpk1qhQUjSzpx/cNeTVbDD/GQVcKcJ/KJDhtlUWSM90iDih0PeFzmdYk?=
 =?us-ascii?Q?XveifJjTOiIxN1bEZ+YagU6hPvqFHvpf9L+KpsyXV7aNlkQ/O0WHcpfTKbvf?=
 =?us-ascii?Q?GP2Xqp9uepH5GLN60D7mrJcYsdYAei8Lx5q7O5CAB1nrf+9ktA7FrGps6cLy?=
 =?us-ascii?Q?uVX+cdD7JAlqxp6w/8DRiwjF3Em/mpezI73ETvjS7VgM/S5Jz5HFCuye1IAj?=
 =?us-ascii?Q?cRXvxnbcf3OBNgSmHfSz5kTth/0CxKAa2XmcIUAo1SuJ8oFaSmVSjYUO2eu9?=
 =?us-ascii?Q?HdJYn0NMxm9LqZYVUczC7oxAXdc7+U9oeP1mtCeaL5rBD7cpEVy8n9SMwF+s?=
 =?us-ascii?Q?vshql0tUKKOdZE0/PWmedR75MFLblqDncgY0/OvMFw1QUPd6a1N0/YLUFAdm?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VyzJyzxHko/Mpuay9xP358LAf8QsaqVPjbzTDpd5F3hTBFz7LjhVeuQCCUw4p4X4FHE8eEP1wUV2Blzkz+66ols3NefgddY623pUMkKx9iJDPxZnzTNpECQ8Ra2sZTEx2zPx+a0LXcCa+drNjT2fs3a89jbwCW2KOr8GDfS6nt3TD1Pzzzr6sjcodfBih4oKd7Uj4oIXEzLkoWCFRQ5JI8WpuO2lW9k2EVHMS9L/ah2LeqIp6/RiXq28igEgjFza84g5zFLPWcv7TDf7/oKSS8M7+feaFHJUVEOfbk0oYO2IJ7H3BQXK27ghXdguNALYitNY6ehmQSHGDbVEnHQFyGA8ec7kGm2vXabttOAJfbZT7hA1cx/D27znuo+osR37y61GsJx1WcePDHoBgwgjxZGFcvlSHEislvn1omkynFLuGnJI/G8jy0FEpE6DlEq7vXasiZK9MMLAZcmT6dUckO3CBe4pOzChNOVgGD1BtxUe20ocWPRpI/8romE6GZXroX0x4m6oN5b2n0DYsBTm897AMq6PBv1hIFHJ2XMtUb/cw99nSAeBMTTm4820ZlX1Jn+DiBv3tjfzh2yL2Yh6o1w/O24zmLLGLZ29Xip7ZKY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7993256-f75f-41ed-c638-08de15944fbb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 20:06:27.2577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CegJFrMrTlhRcnaB8zC/lzDIRnKZ+QtM5TcaqZ1x2vutKoyy8Geafz8lYAsQMbQjFGDYjKlUclrPQEwQA7dl7pXHSZRpy8aKaG7BSlApr8o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7559
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_08,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510270184
X-Proofpoint-GUID: h0rSINvCS3S2XSNPDTtLE-tzR_llSHGF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1OCBTYWx0ZWRfX5BCHeFcghzVF
 DM1GENi3EdGEPrXRvEsm4ZN9+Oo7kU2c2m/gPHib2AYV1EjevC/tRUF7uEUso/VnvFbcPxxajMi
 NdnsHxbBsn1OyfAk9kt6wpYjtYOW9E9o7qN4Pk33G/NNXH03d6HW3+HrJDj4gpxmEX/qbsBtViA
 5CUvYjjWRc6dKs7t8u7YB0k6QaBXL03KAmHXg+N7RUIwASn691W5vNmvVBCOfDNKISiRV9om9f9
 XcpQBEenoSUIjy9j/5QhXWqQL2pZYiZCIcY8q6iLiCCQrbyR/FDEwDWGAtLJa6oa7m8ofLGtt4t
 NRuuOQNIWb0zOU5ybSMCKMc0b6vsG4WiobUZ0BWskXZ1IMjZKhkPZC4CDmw+/1QunmiBxw9s0J4
 Oiku3QW5w15nt6cEBSAuOrKL1pnTSefEP7k5DNcoBxPa5WpQgXs=
X-Authority-Analysis: v=2.4 cv=HsN72kTS c=1 sm=1 tr=0 ts=68ffd0d2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=M0mftKjuTMfAVIN8SqEA:9 a=cvBusfyB2V15izCimMoJ:22 cc=ntf
 awl=host:12091
X-Proofpoint-ORIG-GUID: h0rSINvCS3S2XSNPDTtLE-tzR_llSHGF


Hi Rafael, Daniel,

Could you take a look at the proposed smp_cond_load_relaxed_timeout()
interface and how it's used here and see if that looks fine to you?


Thanks
Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> The inner loop in poll_idle() polls over the thread_info flags,
> waiting to see if the thread has TIF_NEED_RESCHED set. The loop
> exits once the condition is met, or if the poll time limit has
> been exceeded.
>
> To minimize the number of instructions executed in each iteration,
> the time check is done only intermittently (once every
> POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
> executes cpu_relax() which on certain platforms provides a hint to
> the pipeline that the loop busy-waits, allowing the processor to
> reduce power consumption.
>
> This is close to what smp_cond_load_relaxed_timeout() provides. So,
> restructure the loop and fold the loop condition and the timeout check
> in smp_cond_load_relaxed_timeout().
>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
> ---
>  drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..dc7f4b424fec 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -8,35 +8,22 @@
>  #include <linux/sched/clock.h>
>  #include <linux/sched/idle.h>
>
> -#define POLL_IDLE_RELAX_COUNT	200
> -
>  static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  			       struct cpuidle_driver *drv, int index)
>  {
> -	u64 time_start;
> -
> -	time_start = local_clock_noinstr();
> +	u64 time_end;
> +	u32 flags = 0;
>
>  	dev->poll_time_limit = false;
>
> +	time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
> +
>  	raw_local_irq_enable();
>  	if (!current_set_polling_and_test()) {
> -		unsigned int loop_count = 0;
> -		u64 limit;
> -
> -		limit = cpuidle_poll_time(drv, dev);
> -
> -		while (!need_resched()) {
> -			cpu_relax();
> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -				continue;
> -
> -			loop_count = 0;
> -			if (local_clock_noinstr() - time_start > limit) {
> -				dev->poll_time_limit = true;
> -				break;
> -			}
> -		}
> +		flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
> +						      (VAL & _TIF_NEED_RESCHED),
> +						      (local_clock_noinstr() >= time_end));
> +		dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
>  	}
>  	raw_local_irq_disable();


--
ankur

