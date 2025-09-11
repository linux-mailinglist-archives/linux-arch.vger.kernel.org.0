Return-Path: <linux-arch+bounces-13511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1461B53E68
	for <lists+linux-arch@lfdr.de>; Fri, 12 Sep 2025 00:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC6AE5C0091
	for <lists+linux-arch@lfdr.de>; Thu, 11 Sep 2025 22:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E200E32ED35;
	Thu, 11 Sep 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HE+P2jur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q5Tv18o9"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D1321019C;
	Thu, 11 Sep 2025 22:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757628051; cv=fail; b=EXze9UMVy9yfzArM7DevokgOS+CppK4EJB7foeGY4ySxRZxRtqC3M2PfitmLGxOBfDeU2WRfvKGhnM+jCID8fyF+EnIA+4n7mg9sGJ+PgS1VvPvUZVDObC1YoWjzJwa1UutnDISnnFMOrT9RpsC7O7jcHRD+D8yCkEiDJ+6XXVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757628051; c=relaxed/simple;
	bh=43n1HkMDOaHNrXzg2XVundLRDvXbXrmpParQHUtiPC4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=TniIu85m78w2Xuc9T/yzvGdJVbHQKsVrIEYubxNS3U8RcRodUdKombd/v0aB/CVumjkAs756fnjBUJaq6J4uh7uZHzR6FMnPBEvKaPe6PO+ZuZhFeKNmiAIW7/joNBbOEMo8xjFNc+dbFaFQo2rlYNREjFqeHidmqfM/poUnC3E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HE+P2jur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q5Tv18o9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BLDi5p027596;
	Thu, 11 Sep 2025 21:58:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=uYQqu+dfT2SapAu43T
	XeZU0lcJCPld+6lHdMraOJjEI=; b=HE+P2jurzJpuM8SN6q5oiyzXReNspLvvg3
	bRmJSmJVsmiE/GhmAToe8JDzUIabCwVuCiXielgssHsu8T5Qshsl5Dg+0tgteSXs
	jokkON3L5OaOUt3qyg7ZlvRUdkd0l+mI4qQu+9qmMukMHzg4G0vzxhyxSgBS8tCj
	RyDZhgPI0iadqxBIdqldegjNgfQD0jdwhbJNu6v2E6KCkmswNWzjiTmJQRdiRNP7
	IJV6j8Lug/ucbKpR+CktxaJ6t+gF74+Yb4YEjM3PtOUqs1sm0HPfFsYX41/dkSVR
	vWFb79mXM1xli23Ga91ZELVKuIni5cY8XDPbyIJmvEqqxtgUzDpQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4921d1qa4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:58:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BKL3PD002987;
	Thu, 11 Sep 2025 21:58:01 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdkk1v6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 21:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qfL6j4VjtebzyMTmXjnCeM3HEhsfzhhyVUPL7MdJtF08KdwngbDsUTaCAOSzDl/4uBPsBOctG5o4CnhIAwY3irEvY4C4vLG9YclkfwPMfVO6TXWf0pPYbSFvTRaajwGUTytBEt3DZIyBpfT304WLsQxdKhvLL6bU0wCg80vXKSdI5Jp2AhOhj6BhWg25GxTJq45LUVZfldS6JqgRlvhBMnnycQKrQbFulYAtexLi5bffd1j4P8RiLUg0D/ACzIvqMpXygKV+NAczv2/H5PbiLr9G27c2AssCISZoTFZ7bKde+QokitbV+nIPjkU/ronQfNYAvTkfg1idqWlaVY/P0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYQqu+dfT2SapAu43TXeZU0lcJCPld+6lHdMraOJjEI=;
 b=q+Lrx1+6AX1oeTX+J4hadbxOq+PdI18h0jhbqV30yoQR7uu5LVkedNWm2kgRifvXqC3T7Sysfna4JuISTYiMHb8FK9itLRgbVhtQeOKqCa4mfSr9rhjITdybddt9ZMMcsLR1QXy4jh1xcrpk7ZsSvf5qgRb6LTpT9HeLjUAsN8zLAH07/lsRN16EKWlbx0sP14rFa/7kNtQYo4vfofo+23kdmE4b6rlR499HansAn70Twwonsoyau3b+kkRauhdHeJLjIpMo2b1RAOWZN5hBL6fp1tMpeMp27errjpw7Kv3dznL4pzDbqqI9a9v5eI8BMoLjdGnDwBbf7ehTglrKlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYQqu+dfT2SapAu43TXeZU0lcJCPld+6lHdMraOJjEI=;
 b=q5Tv18o94yMaDVPmFa00K8c8kOoYbV7GtwZMmOj8CCQzq2MjWV4NUjwAfkoTkM0BsnfaM7XGBXGJjzDuTT2uVkylyIDRiy7ptDfI//611iEvXgfdwmdQ6qZKtZdJZiimq7Kz1Cx5yViHC4o7hiZ9hgt8XYmaHfZMhmkn7t9Z0d8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB8176.namprd10.prod.outlook.com (2603:10b6:8:201::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 21:57:58 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Thu, 11 Sep 2025
 21:57:58 +0000
References: <20250911034655.3916002-1-ankur.a.arora@oracle.com>
 <20250911034655.3916002-6-ankur.a.arora@oracle.com>
 <aMLdZyjYqFY1xxFD@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        bpf@vger.kernel.org, arnd@arndb.de, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: Re: [PATCH v5 5/5] rqspinlock: Use smp_cond_load_acquire_timeout()
In-reply-to: <aMLdZyjYqFY1xxFD@arm.com>
Date: Thu, 11 Sep 2025 14:57:57 -0700
Message-ID: <87plbwk5y2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0147.namprd03.prod.outlook.com
 (2603:10b6:303:8c::32) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a81c85-76e8-4e8f-5f10-08ddf17e44fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?O3h/c/b080jOA28Ku3QxhIGPavNMQBVdZyzOUFoNrI4G3z5OVS84MwKMaK1G?=
 =?us-ascii?Q?3/DfPNEy1sCaINmQqaGCEOliJgqB0jJpRY/CFO/yWPMxtHtOMPrnsnn3KGe5?=
 =?us-ascii?Q?ICexgBOrtHUB2LkYKGynCWStqhYM92NIn0lvwiA+lVvtk4PaeeADWv/5moK5?=
 =?us-ascii?Q?z101hnDpZr+hFhUCXh72kz3XotZDdPtaNo17Ltr4P1G3KoMCw72z37U5jHMu?=
 =?us-ascii?Q?Qb7/3V4vUIGt7pZgRokIIysz1FMD4JCD6oq6vBTm1xAW/FFIXHYVjQs5tsEh?=
 =?us-ascii?Q?x+jKDIk0MZcfQFNmi2JJ23GH7X4ocTs51ugS9MF3mRGez5ubxBxYuNPwToex?=
 =?us-ascii?Q?PrDLwtZS8fAvJbCqfqjq3wsj926aCKdYJeTYNxzcnk39hBgVPP6LquMtjrul?=
 =?us-ascii?Q?Td3HdVacZ9AojPXKl4BPBF9zbVdSshYgJmT/s8Nsby0rNIKrz0bmKKb/Hvaz?=
 =?us-ascii?Q?1ljxynj3gY9ozx+n8PALJN+4TZOFo86F/pA7DuV5LoMTCEBJE2XQV9Pwrlme?=
 =?us-ascii?Q?cyoMww94ijqhBY8yTnnCF5DqA9XoVOsOnsebV13oCFebMSzd55nu1go4WL1l?=
 =?us-ascii?Q?h1XWnWX6MvCPhk+GCmDopzI5UmeU271fgs/Gl7cJ/b2rGkNYRkAoAmaijwEu?=
 =?us-ascii?Q?hzYNbBS4psTj3tW4c4EaHRPYI9KPdjqjeSwQwxqI5EM2KvF07t9T1RNzrJh+?=
 =?us-ascii?Q?9MgPOUkPtehzIrGuHAII1gq9iImIfdGb4BVwWL4Achgg5Z7+Fl2pQndDqeJb?=
 =?us-ascii?Q?/SLUmmOVP907ya9dKrQTYZeUmBd96IBX3fPBuIu/FnbMIhRz6HbF20tPBzp8?=
 =?us-ascii?Q?7zv4JUI11op/J3hFcYeq+2xdvEBBIw8IQt97EFZ6HtNSTWsx/VFUYDuoUCvs?=
 =?us-ascii?Q?7aiqJYpFr2htzkdjVyd+K/Fiwv5o9E22eUDuLWZfSvkZM0YdQvIBuLWRPKck?=
 =?us-ascii?Q?G8lXfpMvkEob0x7OfHi6SwIG+4t7kqcvU7ySq4421GJQS218a26grM4/sKvm?=
 =?us-ascii?Q?kQbYgkwtKMxdXnnT0KdCaFLbwztCvOwPKVYlNTuigc1jN9nKMSSztlfpdr7A?=
 =?us-ascii?Q?DF1m8766PxIKbeme4UU2Z57Cr95HY7lWHyAWdcUijJCyvKyfMkRpSlqzhY3q?=
 =?us-ascii?Q?7cccIwrEeUlj8rmn/eJ8RJlmR79sXHE2GibLIIbN3NuGE6r82ydCtErMav3l?=
 =?us-ascii?Q?Sv8e/TqM3tqdp8ziEleuqIYGMAr9DGMYXHijWPuy+uRTrlO2GjmLjIi4WxYK?=
 =?us-ascii?Q?w26pJCdTnPupkJNjA9WvGLaII5NKx71pRJx9FyhU+LOW5g9PnYYgGXBaxuQz?=
 =?us-ascii?Q?HSYVUfZ8IM43CpJrK4pxqcr/JRBVLmRWlxZNVo/vKpzQlZf5cSNzy1Kh5Nwp?=
 =?us-ascii?Q?7/6UeC7Jg+aWWsEsxBzaCTjS915wzCDxquL9G2BVA2B5Yqo++Ig/8EU3D3Jt?=
 =?us-ascii?Q?rv+UZNsbO5w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vnaNSGskBcsla0aES0YfJ/xqnIdc1kU2D2LmrOVBSNy70cmUr3QZwCqTXUf6?=
 =?us-ascii?Q?lk/DGE2stGCu/QyYaPH1qGo6sAJVuxNgoNUq9RFhV/oMpLQseavILTJ6ihKR?=
 =?us-ascii?Q?OrHzHI/CDBUkyT+6YSGd4tbwufZHpdCJEJusLufs148xk7O3JltnzwMKplyx?=
 =?us-ascii?Q?fYm7KB2LRCdS5lq9yfImL/d6Nt5J4kfnHZbYXuOfBcod6rx5sKK5LnODCf22?=
 =?us-ascii?Q?d5x5ydmXPIPYVb5vBL6zCK7O6dAfXw8oEzxIfDrTy07ymAbuBhMraAShIE7J?=
 =?us-ascii?Q?Osl2To+74kxa5ERi3SKabTLboJcuZbkmsX+43EuK62TXXxUmz/e+RYxPA8EY?=
 =?us-ascii?Q?wH7bTdOYqHsZT/O7HCR4xVcEM+qFXRm3qcAEW098LGe71Ojo+MK/P3DAS6nT?=
 =?us-ascii?Q?3NlEUsPKVRw+pZGxvfAYJf0ONnwuvRqqPNXwfT1r2PHawuwjiDf8ioXSrMpb?=
 =?us-ascii?Q?k/XJ4raQ8ZN22sli4BjAeG8WmfW6pTch+m/Kp6mFgsWlqOsGg9jJAOrWyq4z?=
 =?us-ascii?Q?B3Kgn3nrvxVcm2v1tEYCgS2Pnxz9KUJYff0Jkc5Vj0WOd+tGnpxsCpMPgz5F?=
 =?us-ascii?Q?Dq3xdzqXmZHHAfdLOjNACP8wwjgY5UJKbIUBNQfhLigH1faVqjQc6ztVvmRs?=
 =?us-ascii?Q?ZcO7cOzFidik3tZ4VqHLCRLPgay6/9p8rA/xXyBRI2uCBPyUk942VRJYA7f1?=
 =?us-ascii?Q?cyJqs39PViByCcQrSAITGDvOf9/UTHFCx4L22If/zXgxVWn7MpuFSi68cqym?=
 =?us-ascii?Q?0m9gpCRrgwVS+iF79zGZf3kiTEX9FR+ExfR4ej6IaXfQMDEb5vY3PtR4++2L?=
 =?us-ascii?Q?V/K3zcyanXiz1KxyF7M7hFMT69w83jGVE46WYc8TM22ks6wlxswRKI4RHc7X?=
 =?us-ascii?Q?wpeyU8gQREWt8y5+TOsDFIQJaNVRUhBhJTq3aL3HIm9p29o9wJ4xQIWQaahe?=
 =?us-ascii?Q?sahtrW7vJeaFIJS8rcNcIXKa9vgeh7Hndlm7JxVWbzqCf7+j5Ycfb1IR4IAG?=
 =?us-ascii?Q?wXoningpNp0LY0nbx6OF2MDeD5+HQHvCIYCEUY6SdOuJmFK2qizDaAoLFzNJ?=
 =?us-ascii?Q?A/nKaXqW7guqqZn08ISIniKhqt9SHHndLebJXizrdpICxdbCE6Fj3fYl4Qt9?=
 =?us-ascii?Q?zU0qnUQnC6Q4f0DQuCO334reLDoL/gkyVs4pIs+0LEyYmIq8vkxVO3iz5XCH?=
 =?us-ascii?Q?ASpZAsJjfTKRqD5MPt6cVqC5AXFl/J1B5/VQQsJaYtX3SZKJMTJStQLZfCUd?=
 =?us-ascii?Q?pRy5eMYq0m/sfHixQHObDdRaZZky9RWBsSBKtc8P3PupCXa6tsNujL7HfO27?=
 =?us-ascii?Q?Kn2hH5/r8fEgcmXZ60ibsVWvMbpPw7S1fN7D4D4NSSSPKe3lzyapNOKQfYwl?=
 =?us-ascii?Q?d5Al5t+tdXa3dYLdrUfFRLKvYTGG4Xwry4RJ78GmMeTdrPm8PdnwEPuEAXlB?=
 =?us-ascii?Q?cQtWSjS0MViukMJXGbhn1Y/fWSftqq6mditMjrhhb0YbxNMH9px/p5bmQmBC?=
 =?us-ascii?Q?mDxxasiZSFhXFA9vJgM3fqFHgbJQP0OfU0FOIzTZnNYxX0sXYsnMl97hTJWF?=
 =?us-ascii?Q?KTsiiC7WeEjUWml6KGNWBB0u6OQa5O5/fpB1YHgmZmnRgnYJWrFM0DkkP9x7?=
 =?us-ascii?Q?lw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FXY29qxasokFxOXgcHdUVTokgC90B9GFAzyl9hCzzHreBlFMGOqG5FnhN22HxiwfrQVkXBhuxpK+SjXx9d3VRNVD0y07GBf1kVnTU96xffMzvYce2eHkOgYVbPH9rjSBnVejjpy75tG/GqJTl+OM4gNXb1C/wyrGU0LjJxKgWS0PcTDvmd8Jz8trc1+1VkDpca7id16iZWq2gMSB+XKaEgFFmhCAr68g5RfXDZea6w47QEufSsbjlqSLTR6phCfFhRvXsfLN810EUetWR1VehvQtAS12GcLdY5LMJCRKQvVD2R7sHfg1hcYHfcLPxOfLB1aP+stEY0rMRnVx47fhX8AjdTDsbG8gfBvjJVyyJr3N9VArUs3av3TTjrvO4Lq42pAh1l2HGcGKywHZGV9XRQ5ecru9x/o3/1jCubQUOj1K3YRJHD1IaPkrl911USLdHczL0JqESNJTdW76C+xLTpOd58LHqu/uN9YmCEwY+45siJatos/qOV6NVy/eW4WxbF17myMx8n3+ZG+jV5HO4f5fRsJ4C5D0cRR9jycpd1O0Ui/K+9xjYN3qjHO7mPc4HKyzG2o0SEyxAN3MmWIt5MOWL5rYdX8pIa91v8GlzOI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a81c85-76e8-4e8f-5f10-08ddf17e44fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 21:57:58.3646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2SzkFBIAtBMFEebwhq8HA+OtHLfeYnP7PaRJ9+/v3f+zHxLzt++ibU8oY2zC/Qz/4+QeZdtmREfqflc7lhtxuBhvehQFzHLYMoAlyKj/aB0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8176
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110196
X-Proofpoint-ORIG-GUID: s9izAkaO5DE-lKunm0fPFa7r-OJ43AcM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1MCBTYWx0ZWRfX0kLHFx9R6WEd
 DQRIJRtTqkG3Czey3DgsZ9r5ffPmM5uvucTT00JIUeuWLDZtDeID169256/3V52MfwiJVqLoW6V
 saSdNGl62UWHfeqd3b7J7QrMoyLm+yVCUATFbmAv0ezUQO1Lre351JHejtM36JnfoQ2rSIK7BAx
 E0ogkbfYF5EHzE7DxjD66J0XCktRlnwqt/mbhGGEzGdqhX2Qy4kRE1eEZSgx7upWbv/HhPXDGQ3
 0k9EX6syEkpi8utWXIAgkAMHJcmP+gEVwvXyOpvoU80pYD7X4acwOokIsgGo/c2NhUGRPLZnZiJ
 3fq5emxE8Vf9mBEGrvYQZLI/ImD9eq26v/opsDHrX+0iCqGE7FSra8Cch7UKuibTB0RK19FgSs6
 fmj+2Mkbe5W6dT4vuzYR0dgeDMx1Ow==
X-Authority-Analysis: v=2.4 cv=d6P1yQjE c=1 sm=1 tr=0 ts=68c345ea b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=Q1bMdrKeroLeaqufUqEA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12084
X-Proofpoint-GUID: s9izAkaO5DE-lKunm0fPFa7r-OJ43AcM


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Wed, Sep 10, 2025 at 08:46:55PM -0700, Ankur Arora wrote:
>> Switch out the conditional load inerfaces used by rqspinlock
>> to smp_cond_read_acquire_timeout().
>> This interface handles the timeout check explicitly and does any
>> necessary amortization, so use check_timeout() directly.
>
> It's worth mentioning that the default smp_cond_load_acquire_timeout()
> implementation (without hardware support) only spins 200 times instead
> of 16K times in the rqspinlock code. That's probably fine but it would
> be good to have confirmation from Kumar or Alexei.

As Kumar mentions, I'll redefine the count locally in rqspinlock.c to 16k.

>> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
>> index 5ab354d55d82..4d2c12d131ae 100644
>> --- a/kernel/bpf/rqspinlock.c
>> +++ b/kernel/bpf/rqspinlock.c
> [...]
>> @@ -313,11 +307,8 @@ EXPORT_SYMBOL_GPL(resilient_tas_spin_lock);
>>   */
>>  static DEFINE_PER_CPU_ALIGNED(struct qnode, rqnodes[_Q_MAX_NODES]);
>>
>> -#ifndef res_smp_cond_load_acquire
>> -#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire(v, c)
>> -#endif
>> -
>> -#define res_atomic_cond_read_acquire(v, c) res_smp_cond_load_acquire(&(v)->counter, (c))
>> +#define res_atomic_cond_read_acquire_timeout(v, c, t)		\
>> +	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
>
> BTW, we have atomic_cond_read_acquire() which accesses the 'counter' of
> an atomic_t. You might as well add an atomic_cond_read_acquire_timeout()
> in atomic.h than open-code the atomic_t internals here.

Good point. That also keeps it close to the locking/qspinlock.c
use of atomic_cond_read_acquire().

Will add atomic_cond_read_acquire_timeout() (and other variants that
we define in include/linux/atomic.h).

> Otherwise the patch looks fine to me, much simpler than the previous
> attempt.
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks!

--
ankur

