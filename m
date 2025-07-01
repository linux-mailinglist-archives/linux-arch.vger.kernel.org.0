Return-Path: <linux-arch+bounces-12524-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF52AEEE09
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 07:56:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39ABE3A6230
	for <lists+linux-arch@lfdr.de>; Tue,  1 Jul 2025 05:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7AC21C18E;
	Tue,  1 Jul 2025 05:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2IrUn5V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YqMnEJNN"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E34033EC;
	Tue,  1 Jul 2025 05:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751349389; cv=fail; b=Gnxtvmh0dBEWTigYGUtE+n01TJOoaWZI7tYxQyyOfYvmbwVzkuKI/7WHuIfPClfQ8PlCAtwhBbpRN2/8wLEyKCMEFKSsfqyk3HM120I9dRO/m3kIzgG7xEtT0L0DA2McOXjmtUH7hWZfcBmQW+HU69HM4uXu6ceiIp92ATGIpOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751349389; c=relaxed/simple;
	bh=BofRDd4EZFzJpaBMoS8JB0xZ7/YptDAhyF65cmw1lWo=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=sz6YL3cXEnWueAJ2LQeC7+mO/kU0hr2JfEqMpl9WMLDj600Dn1+EAT6ZvP3L1HR4gvSVl7X07T+aqBpZI23Aot6tUi3Jb6nEPk1xEjIs/uSsJZ2zjaDCcdsv73vtDkMyPTyLbSTX7CfvP73u+V68xTJNrOnlcpq0ur1QFjk/66Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2IrUn5V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YqMnEJNN; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611MvJn008524;
	Tue, 1 Jul 2025 05:55:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Rn25lDiSkf+7yCsY34
	lpw0FZilCKIwMC0vinjDVSWcE=; b=T2IrUn5VuVc/UnOJgDHgekmsMOjRimwGgd
	jefQz02V8k0QQBUPIHHeQnXbqnhwk9+CsfhspdxFhIE041RAOnSsDIXJF9DbrwFJ
	ZQKATWV9mLJJltDp8FfImMaw0wADJr5xPraNF7CnqT0HgWwU+QCJyIK+SqRL6vGu
	rxuyBA6euP+i/HKrywmpdwGE7SyGtzNZqj4NQlVB8SCo0gGW+UA5bn86ycVK6vTI
	Bf9BhZLn1ggxLhRNVkd50cX3DujQECb1JKXVDgro+3/TnY6G1MaYlmRvAlA7mgUa
	cc+9T3Y93ljTOH1/ogok1MLkToEaUifehxUAujSNZ1iW495NN2Og==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47j766byd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 05:55:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5614l1s4009039;
	Tue, 1 Jul 2025 05:55:54 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2048.outbound.protection.outlook.com [40.107.93.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9af6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 05:55:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJTYp9+o3k/NNi2jNQ+nl01tgacAbceJj1Z+cEVEw8sMCi05o0y4hD+adsTswLCj71ELra02CR7ZzZt03Xr8R/sXx8anZTLQc2rZ9vrnPpW5e0qCVJr67HubvK+8RCD2CzAyFqJBmH5jr/V78nl+CijbW3SQnARIBkt2dSsocpTQCaeVlbl2mjlt+uCMEFXvK/zhKDx3bjLtu/Zl7rluNX4Ixe/WHJOG0w7DiGLk0sK/7y2cjQx/QnNfB6CSP3jpx817Cc0GIZHZvL8F4ut/a8uaOl08i+CaWnzNmizKrxDtXbW1CtkAGZbdk1bDnUdyVrOEviOxha8Ikh0warmmMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rn25lDiSkf+7yCsY34lpw0FZilCKIwMC0vinjDVSWcE=;
 b=k0q3SGTQgvBwNHmwDzH6foT7h8kCE6NZS8LaIC1ZDHm6OQQZu5fxsxUD2t8cE4lePvGA9qcueN6Gtxp4pf1v2vb87xhPv43VfatISmVMSHrWt3oHEK8XtAA22aCqeLdK6ejccoWiQOxXEEzIxwBSFUEbhIQzQ8OBZAnp00MExnJxihlVkpUn+eEa1ux/wXXeOV+1VQOk5hpCxknrnei8FztnJ3kLihAd6dXyBNcKlRHoXBvfNg75u/dd/mMDY38RChce1ngtX0xPjaYcEde39YMhl+/eKxuHaQKF4rkohODq/jlc99u3H/3iDOFkA0SBsh47IeLN8iHrrNqLGIWNLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rn25lDiSkf+7yCsY34lpw0FZilCKIwMC0vinjDVSWcE=;
 b=YqMnEJNNSOhNGbzyVhkMQtUP75TEyfa9+Ie0+VEFXR5D1S/563O4QGwoZp33lhsEZfCGy3o/7YRuH4oXPFO9/JVOJQoleT7qEjmkkYxJsP3zVPa6BRBqF+yUf5zkyGqsmNJFUUqW6BcRofXuh5J96/GzKxvL8pa/HHvIxD7uFZg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6895.namprd10.prod.outlook.com (2603:10b6:8:131::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Tue, 1 Jul
 2025 05:55:51 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.8880.015; Tue, 1 Jul 2025
 05:55:51 +0000
References: <20250627044805.945491-1-ankur.a.arora@oracle.com>
 <20250627044805.945491-6-ankur.a.arora@oracle.com>
 <e2e8788d-86b4-092a-37f5-286b776cc061@gentwo.org>
 <87h5zxrlce.fsf@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: "Christoph Lameter (Ampere)" <cl@gentwo.org>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, catalin.marinas@arm.com,
        will@kernel.org, peterz@infradead.org, akpm@linux-foundation.org,
        mark.rutland@arm.com, harisokn@amazon.com, ast@kernel.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v3 5/5] arm64: barrier: Handle waiting in
 smp_cond_load_relaxed_timewait()
In-reply-to: <87h5zxrlce.fsf@oracle.com>
Date: Mon, 30 Jun 2025 22:55:48 -0700
Message-ID: <87tt3wqwt7.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0232.namprd04.prod.outlook.com
 (2603:10b6:303:87::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6895:EE_
X-MS-Office365-Filtering-Correlation-Id: aec66667-fd8f-4a73-9e20-08ddb863ee7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0AfXNxjPKAPp6DRKpoVAcOPoC2qWfW29VBgcTaANlUcf/K9IAM03lclc53MJ?=
 =?us-ascii?Q?LFfeL57Dffisu8JFfMAyKVDNo6KjcxIFQCtSVMZFmiJIyNJBOS67Ld3iEjz7?=
 =?us-ascii?Q?6sC1pfgS/TmCU2V38lO+sRMl3sk86UO5wXsXMf326e1OEkBP55KXs31RNYxa?=
 =?us-ascii?Q?WYShh/3CN4tC9+NNoTc7fWkr4ww+rmtHIHLlMCmDc5FrSrlrTc88O8GufHRd?=
 =?us-ascii?Q?ww07EVaU1mZsv4nRM838sg+PVoWOlmrPLPNJ/c/VTPoUe9aiBsh/nCEVinDe?=
 =?us-ascii?Q?PKI5HTtUdB9y8nZ7mBNUFj4fbytxZ/5OstenL+zd9UQQ8s6Eo3vgf1Pdpm2q?=
 =?us-ascii?Q?CeNv2VGFWu4SOgjrRm7hXgcsGBc4PiJnELgYrI9KDD2aEsRfoNc1MIKBju3t?=
 =?us-ascii?Q?rb0MpAc1WxuIcdPJjJTewJ+GkxtUWuSMBfp4LgoWAPGhxQatYIFMjvl6slBB?=
 =?us-ascii?Q?0pFu1lHRpJy8OMqdwZ7/szZNxJZNbOFQxClGsenEGKwAYchoqPDyVf3JXstM?=
 =?us-ascii?Q?pZxQiTmijIpTYeeV90LquOyRU6hYdBQ0JlPeL1GQi7cuilKF2jIva2TSXt/1?=
 =?us-ascii?Q?vT4YfZdWdb2Gu38mbxhs0/h9PbZveKMviLRoobLDW1jodYoPUKiLaNFGY0zL?=
 =?us-ascii?Q?D90H/qMd1WgsftzpULHBMSK1VHlYuj/QfoxwNpxme3JDDqikKfWylnevMw5Q?=
 =?us-ascii?Q?Ljs+0IUDNPA95rEoxtHYIHr+YpHjuBqOqWDlCKRq6F5wA3xpzEc3FK5SZG68?=
 =?us-ascii?Q?qXm1zxJYVClQb4faYMNgpz6+NhdUnSBjgCS7YxTYJlfLNW2a55QGv4VsIBAq?=
 =?us-ascii?Q?voy8F6LcDcRnmOnAJ4t3J+KfzVbJHBIN9AnahOZU40vxY0BU66RSynW5pNv7?=
 =?us-ascii?Q?Bmmq1JV9t89OP4XLU7jVzYv8/BSNdviyUqXbpXjbnlvYz6KEdoZ4WT5B5rRb?=
 =?us-ascii?Q?F1qJ2CJxLZpNeQxtWgIfozXpijPu8272TxJZsqDA5jSwhjzYX8jh2tVgwC3w?=
 =?us-ascii?Q?XJvFQEky7HFou6lJMy0Gvlz/3IU+UItsFj8hMRoWXAEsPJdMRMZtMVrYOb7u?=
 =?us-ascii?Q?g5yVKEqnS3TOLEJXBCY3BOQfB9a0MeIeGBQpjSS1zwMhdYScGTvCNYzlnqLB?=
 =?us-ascii?Q?ZjmtTaW9n0olB8QVg7c3q+lmi/xbZdgPF5DmxjMz5fmNtJG1Fir/sLyTbm2C?=
 =?us-ascii?Q?57IOF8z0405s25YrSStkVqYhRDWtr1ifPdjsK46wsq02TEOIdWboTe4fDP1W?=
 =?us-ascii?Q?6QLCXQieg+Bw5fP2xxj0eclaGg3ggYOXBuPGyBFoDZ7f1oClyyXlp3soLVMz?=
 =?us-ascii?Q?uw3ae0bkluWcZkF3dgf5j5mqsQaAIvKoNeB+Ta1QLt/TbKOwqsLQ55uFmz82?=
 =?us-ascii?Q?fRNGFQaeFClS3+hol5jxBiXEt6uCtUPzFxyOTRe9EjoXs5QFCQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Hl2jypWP4Zw2zmVcyU1JtspzNIc9u8KmzHb9+OFPAhlc1NviNaLSaUAu8vBU?=
 =?us-ascii?Q?5SLWiDcET96KWpsUAqUDCT5Mq+M/j4N7Yujz0PiJ2Zzj7r/rX92b6Kr5of2X?=
 =?us-ascii?Q?odkGy+DFy2ELWgKlq9qtTFbpiKnp0gSrURdWwMD/Rj9KKnuMro3areBBHumD?=
 =?us-ascii?Q?2Th+9T+V3TFk7AP5h1HvynvCN302nCSOkWKzQfFOP3FCnFEvoO26n3R53oRz?=
 =?us-ascii?Q?bT+MD1gAtUKW/Tl18vPlD5aMX2Z44ZvEaDkCRv7seKP65vMEigWYfK/jj53+?=
 =?us-ascii?Q?rHvfwyoj68hkLiuBVOgXeiyR+/XnswLa6ghCducJQF03yD+YpD84uwhnXL/j?=
 =?us-ascii?Q?MChJuyGZwZ7Ub6yCqjZHPAhrhNHI8i/nGoRw/+7hHsQQ75KbuWwvSA2BkyKV?=
 =?us-ascii?Q?PGHa93J+Ofk5yfRE8HLzOlqNccxbzqdowVkNlWOvgE5WLRC0SPc4o3aKhyEw?=
 =?us-ascii?Q?6WUCFP9+4UpYxBZcszW5tMsr3gkieQ0jHZWUMnSM80ueYpVu3MnZ82WBPvZl?=
 =?us-ascii?Q?+n5oda5i6tEJs/BSMsqQJE8YcbUGwSAmjLa7RPTCSRqwkkPvjxxwCbjoYGvv?=
 =?us-ascii?Q?mU0NjwPVVhnQSSiAxLjIVHdGj0HHvOzOgU3xxuGb3TVBGBMePmDBuT94R4sE?=
 =?us-ascii?Q?arqpMWG54W3y0CLLMlDuWz6MAklaPIh6Py4hzEtQaP02L8uw9zXwwbQjrZj7?=
 =?us-ascii?Q?UzlLHgTJ+nvYJeSCgU0tJhnW54jfhQpmpKiHFm2WDx8iMGyeoZ6Wup3hMb1b?=
 =?us-ascii?Q?KzVnGfgpOzw0xzoB6jYxPFFgwm2sTftjtsgyT31RoWqtDLZnC/90lvjC9OrS?=
 =?us-ascii?Q?A2YFL576u+EBorU5aaCNz70XmpNlWnKONUMQSNP6J0WECssuw5vZy35NTDR/?=
 =?us-ascii?Q?vsorbEbc6jOdl/0GcTfRzffQV7DO18RzCYq0tfE1/968bMME41MXD+JyQyhC?=
 =?us-ascii?Q?lkfaGlOKNbti3fxeLhKzYZt/MQqXpt8pGeMSk0eSZkP/nJ9ymmfLOvSn01p3?=
 =?us-ascii?Q?nSt103ALkChlR6yAa58PAjI2PBFma8Ajf0MTjo9xlHHNFmf8hRqpBZp9fGDZ?=
 =?us-ascii?Q?NfF3oo1CaxJgDEekUpEHEPbPf0qJkbAyYzjfYTFGA/TgSxiFWzjJQbxlqPo/?=
 =?us-ascii?Q?Z5X1Pb3/TnG7rRX4w4rASIKeXSsoJIVTRYADRJXjjnw/bR6cRMYbiLVLlR7F?=
 =?us-ascii?Q?oYtOUOj4hqs2VzAgv3hqXdzRgO56i887LyuzFsNG/2wyAPSlGrtqDI8lCoKL?=
 =?us-ascii?Q?J2nPJMo3hscRUdZAF4uDcGp6gMGQxTzBFbaWRkBImu4xuIwKGNwLMPaFZZKS?=
 =?us-ascii?Q?2WWi5+sbBTDqtvA6Fv8wulVbr1zj4x/IiuPkMvyA4Y3/BxG+lf8MX3Rfnuc6?=
 =?us-ascii?Q?7Efc8IYfFjL5deSqjD95PVZk8DRyfX9P32msnvb2TutyVZ+LEGzuPmpMB9XE?=
 =?us-ascii?Q?o9A6cC3PELbWMOsfaSOAyO0Ql+rDi7YznW3EQmAFrBwsl2pLHnlLVBnrbnbi?=
 =?us-ascii?Q?EL79rIatJv8PVWCkTxM8ikfLUdoSXHZI2+fEhiN8uLGUXtdQrZozeQOU9JtK?=
 =?us-ascii?Q?Ladx0Luab3h5zQalFphAKxIc6Y90rJzP2b5y0YDlbPpn7sCWSrjw9GGozxf+?=
 =?us-ascii?Q?lA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QgT2L3y5sGqus4bVv76HQeiVwjm1YwjINbUnCztqyOQ68VtFqN9IVe6s5eiwIwM0RkA3z62qbZrFZ11AwITxnprnjxLFQ8PJspbtLvAHyocOH12iwV31AkqbHPphXUmyt/O9bWIMvbV+5RzXY+SwEgnBBI4ifS/TwbJl7mbBqV+A0ndKyJrMp2dL/zk54XRxT7ZbJWAovDsuS6cPnKrv8EgPWRT4GK/jVoW0FYOqkoPMnip6yZ4OXe3/sDLtdF16++str3U2ZXpE0HkomrL3E/6N94wH2o8Tq15WvS8eaxe3f4k6Fa7Jm6foFnTjjy/zQ0OfjoNiso7xLxHQwcgsoaY7YKSx7pJItnUVenlHjxtcvqFlUb/hyld6Q5NV3ep+gQfCEVyaPHY0TgLhiigDeOhFtfA+yyVU4Xn58bT2WuIZDlK4aITECsoebZ9WA9SatX0J6bUFbDYNAWzMiFAHsxoOIo7CWQjKeX7B438eplH2N2k0ZwlBA9YM2i6pIAR0A4wmAnWPRUAoRBQ8TW+d/mff3x5QmRSha8VbwFLSkhIWN9VilInhJXQOKcwGdpGAJEhyiGvb7GkPwiIugM1DRLmXllwLX4taFJ0zR0mAyTs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec66667-fd8f-4a73-9e20-08ddb863ee7e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 05:55:51.7249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R3kwWCMOW3/D4lOYChJSj687n4GVrvNqDlNzx8VADIzvWH8w8PuId1n9efD6n4yr9iBGfohti/V9v4eX5XhkK0J99xmPZxUOyEBjNPjYdto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6895
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010030
X-Proofpoint-GUID: aSmALB7z10WAAjOdI-eSGyUxLnRH64Gt
X-Proofpoint-ORIG-GUID: aSmALB7z10WAAjOdI-eSGyUxLnRH64Gt
X-Authority-Analysis: v=2.4 cv=b82y4sGx c=1 sm=1 tr=0 ts=6863786a b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=PuvxfXWCAAAA:8 a=V1Nn0BbxjA9t2MWJghwA:9 a=uAr15Ul7AJ1q7o2wzYQp:22 cc=ntf awl=host:14723
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDAzMCBTYWx0ZWRfX4KvMgOgVU8ka KFZANvxZMq4NAKsyDNiHjmKn+VOW2+fssto3foOOe9qLIifOTx+dYfvySSzgWS3sZTvRdjYckCO eOaYPv3FZkXSalA51aXnaQr4rM9hpukXjwAlLmYjMU+fAdJjFnGyGj01Tj3lI4SpNvDq2dgRfpW
 AKPllx8rKcDIDh2HQyVsIXja9HVgpbfXqGSuF7Hg0muH7ighcoVqcnfCSV/U0rtgghpcJlq6QUl KXO0qGmmqZ5gMMuo3UqMG0E4w3oFODEPFVFY3NA1Xb7055m0nil6mD51EGdP+kBa0V2MYAJIjqt 3g0lzga3QpUDTYWL5U+BwFcY2FUxAUz/4KKzJd1AFq6xJCpj6vgU8ybdMv5mFi74D7I8LRG7wKe
 BmccQtFtvWiRFtSixOPzhNtrWEJZ99BGO0m7fHfjGcX3J0LnvuwOmJuiGe3KaCsY6PpwZi3r


Ankur Arora <ankur.a.arora@oracle.com> writes:

> Christoph Lameter (Ampere) <cl@gentwo.org> writes:
>
>> On Thu, 26 Jun 2025, Ankur Arora wrote:
>>
>>> @@ -222,6 +223,53 @@ do {									\
>>>  #define __smp_timewait_store(ptr, val)					\
>>>  		__cmpwait_relaxed(ptr, val)
>>>
>>> +/*
>>> + * Redefine ARCH_TIMER_EVT_STREAM_PERIOD_US locally to avoid include hell.
>>> + */
>>> +#define __ARCH_TIMER_EVT_STREAM_PERIOD_US 100UL
>>> +extern bool arch_timer_evtstrm_available(void);
>>> +
>>> +static inline u64 ___smp_cond_spinwait(u64 now, u64 prev, u64 end,
>>> +				       u32 *spin, bool *wait, u64 slack);
>>> +/*
>>> + * To minimize time spent spinning, we want to allow a large overshoot.
>>> + * So, choose a default slack value of the event-stream period.
>>> + */
>>> +#define SMP_TIMEWAIT_DEFAULT_US __ARCH_TIMER_EVT_STREAM_PERIOD_US
>>> +
>>> +static inline u64 ___smp_cond_timewait(u64 now, u64 prev, u64 end,
>>> +				       u32 *spin, bool *wait, u64 slack)
>>> +{
>>> +	bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);
>>> +	bool wfe, ev = arch_timer_evtstrm_available();
>>
>> An unitialized and initialized variable on the same line. Maybe separate
>> that. Looks confusing and unusual to me.
>
> Yeah, that makes sense. Will fix.
>
>>> +	u64 evt_period = __ARCH_TIMER_EVT_STREAM_PERIOD_US;
>>> +	u64 remaining = end - now;
>>> +
>>> +	if (now >= end)
>>> +		return 0;
>>> +	/*
>>> +	 * Use WFE if there's enough slack to get an event-stream wakeup even
>>> +	 * if we don't come out of the WFE due to natural causes.
>>> +	 */
>>> +	wfe = ev && ((remaining + slack) > evt_period);
>>
>> The line above does not matter for the wfet case and the calculation is
>> ignored. We hope that in the future wfet will be the default case.
>
> My assumption was that the compiler would only evaluate the evt_period
> comparison if the wfet check evaluates false and it does need to check
> if wfe is true or not.
>
> But let me look at the generated code.

So, I was too optimistic. The compiler doesn't do this optimization at
all. I'm guessing that's because of at least two reasons:

The wfet case is unlikely:

   bool wfet = alternative_has_cap_unlikely(ARM64_HAS_WFXT);

And, I'm testing for:

   if (wfe || wfet)

This last check should have been "if (wfet || wfe)"" since the first
clause is pretty much free.

But even with that fixed, I don't think the compiler will do the right thing.

I could condition the computation on arch_timer_evtstrm_available(), but I
would prefer to keep this code straightforward since it will only be
evaluated infrequently.

But, let me see what I can do.

--
ankur

