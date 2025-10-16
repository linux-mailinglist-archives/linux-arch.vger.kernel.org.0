Return-Path: <linux-arch+bounces-14165-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D74DBBE4B62
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 18:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CF5819C4A16
	for <lists+linux-arch@lfdr.de>; Thu, 16 Oct 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1D534F46E;
	Thu, 16 Oct 2025 16:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mfUXKOH9";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="h3bmeA7s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A074534165E;
	Thu, 16 Oct 2025 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633844; cv=fail; b=o+sHsXg3hyM43Dw36xIZGGrnRN1zyytbrW9qeyS+Muwd9Gm0ErKO3rJ/bY0tT6oYrYN8ALOjV9XqFEwJcnZSrOhJBJIB+8aH4rj9/9VFhmJt8Hoh8WZs3j3VbSNzrF4g+eS/2w8m3pJei129WacRXlKnyrGGc6kTkNHvRw/NLuc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633844; c=relaxed/simple;
	bh=FK52YMMCVxwCs9Y4sdCTYteB79+tTa69hZfF0rFFTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bGtccc6fzhvpXAwNKbedfpfAiuPYJ6/kvUsZyFwamFOkgyftK97bWFHbIa8k7JDB7TK7grc9Dsoe3w1vXWm+zXxT1b3zHCRTM2/OkmeWcxKsSOKG9rclV0+Sqt5UKbSXZsvETX3ijCa/YVe5oGAfzr/A5rjzAC79SazIT6FKQNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mfUXKOH9; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=h3bmeA7s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GEVL2o019879;
	Thu, 16 Oct 2025 16:57:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=; b=
	mfUXKOH9A01KCDhQIRP1POGu8dIE7+3HViX8HvAL+wFo86Vhzxi2gVAQa1Z5WXeK
	ZgDKvI11Q+4zqa2RrVYkB7B+mMSgtRgMHST3ghbm/x4lDTZGLyN0l/olwRu8Syye
	kwSgFEStn5gudKy3JfiJbp3IsK9EAHmE/90S53C4Z+Nlo5kGjaH11MGwETAUjwng
	2epoOCqY8qN4MiTIlsi3H/uCioVUIT6mr4F6RLYiGkQpKAvXClYvmoytiQwJRhLt
	OrodpG00iZV8rkZJmONev3jm8HcGRgtev2Wc8+hrz5YLQhDGNbVHpeu/ygmo88IF
	ts/R2n6uVIpDSQnzfuuJKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut19vn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59GFLvnb024780;
	Thu, 16 Oct 2025 16:57:00 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011003.outbound.protection.outlook.com [40.93.194.3])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpbxq5q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 16:57:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghmj1iIq5YfuaqtAFoibPXEiC2QpEUhC/ilcL70J5JvntYA0wk4sz2QGXoipg9tVLgy88D/NJs8Ih6VYuirCmfPR98iEJBgq+d7J17BGLqK4NegPaCTLz7PC4E18eUy92aAwDt4KbtI/XVnyRPlr5a+FcOwUz/qYizDwx9u9ZypbJ1JVf6sU9gT3IfY234F8MftwHrjVYVQzQLjuP+JB4xTIlL5uAPuU+bC6mJJ2fPzXb+j2nQaxr4AfG0icsEnyXnSDCYrR6EiF6DMMGZfDI+3W3hGwqwTjwBFjcVXV3xC8mHsN0LAZYdyAmyEcOTXvDPgWCgsVS/3UfgkyMj2YhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=tWSqWwNY465hjiVsmoXKNUjCvGk5qGJkieq37tzTP0QMM35XFEOWUd4P1ZHA1WdrXa+MP6hbMeeCR6TqSAAOBy8hIC5U1teLVO2hh0H+wQ345MtU7wgBABtafzcrYDo6zODNCUL9Aa1RRQvCSxx3FGFLOKJkbk1/DNJu1Xvvb7fHrmDCsp3uRd0lLa4dCbfSLNUtO9ERF5b4Pjq2R+aXT4CExyIAg/QGZqnhJAsmEyoTc2bvz9Ljj898hFP8zrhsNeMeTcM1kRdwAk6J54gYEEJfh3nvfQ+lpLnI35kDzg5sEEzZCFJXo7g/c7IFLGhNO1S0VSNETNgg13mJM63LHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=h3bmeA7scK1N4AQ1WmThAkOX8bqobIL84FMbe+4Zn0ZwBj3B24lmpQCARlSAzHcXGR0kR5ULK2qpt71ayDj/xjbSeh2fuq1/NcwPu6jYG9i3jRMRff2GqWyPqICYuOTVuje2BRLRzm+DRHT3DK/7wjCjQ4PF7iDFb9WYrsHp+E0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6898.namprd10.prod.outlook.com (2603:10b6:208:422::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Thu, 16 Oct
 2025 16:56:54 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Thu, 16 Oct 2025
 16:56:54 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v6 3/7] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait
Date: Thu, 16 Oct 2025 09:56:42 -0700
Message-Id: <20251016165646.430267-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251016165646.430267-1-ankur.a.arora@oracle.com>
References: <20251016165646.430267-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:303:8f::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6898:EE_
X-MS-Office365-Filtering-Correlation-Id: 00941b02-68ce-4dc3-35f5-08de0cd50291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZKE4MBTqqFjUHKguvuXISeCiUtsHwajt+HiVhnr1oAPjOz4k4jGOiftlaKo?=
 =?us-ascii?Q?oU0+n8PQfc0xbgTzGJyhVHBWgy0zBog0p5s1G0waFY9wdp0QulrMEa8+XkSE?=
 =?us-ascii?Q?dpaRo244rdGQL1KdCIta/n61A3GoOA9SjFjsql7o+gTFNiKOje0f04Rqm9r7?=
 =?us-ascii?Q?b1mf0xRlkAhxPRQNVPWywgcVOCt2rWgxxoQk4GbXf4F4p1Xx7QgM86dU3g3g?=
 =?us-ascii?Q?ixoCt3Fz3u9AvxyFQJqMNn2AnxTqKSkCI9oeyr9och/hClI/c4C4vmxfiXwr?=
 =?us-ascii?Q?ypIkh0Ak8M8squyi+9M/CLQHvge2CkPbr2s3n6PP4QaFLD1idA/eAy5SSDMt?=
 =?us-ascii?Q?SWj4OVSOM6ghBfVija2k0oFxD2i2vQpgnYSsO+aPwPZGJ6mcSSEakKySIguk?=
 =?us-ascii?Q?LeIOqCznxnHFT3jficSXmerVE0AN8xFWkFccrbBE86m1/72xlOqDUn2mw6px?=
 =?us-ascii?Q?3dUuCmP/FsV5MqK7da2fmFKhXEgfKy04vb5tLiWgHJtkhgiIX1q+Dd4C+zlT?=
 =?us-ascii?Q?+22ffKLgRzLRoP3PeDJT2BYCay6UR3Zaf8b2JH8vVToiV4PMbtLw0fL1f2B/?=
 =?us-ascii?Q?TmBJiu1c5OBxpuQVPNpBGHl+GgYdVD+ivqRLt8gJuKBNP0r4ILCXg7oOnr2d?=
 =?us-ascii?Q?8m+LoW0uLMZD5dXcNB9+7Un+bkLQYQcYfPpE74i3pkpoFU9zoE8EA5emNY12?=
 =?us-ascii?Q?kQcU9LiysLE2kb2HQSd3vN3fxgfqe+fkUXmLemmRvgxu0Gv7fHvh6STKqLc1?=
 =?us-ascii?Q?R33bT/hNreYV1hA6fFXQGCV9y7SbgE09OdPDF/acTnHh4C7szexiKu6u+3S4?=
 =?us-ascii?Q?FeUaKRvO/s8gJHzLz8+R8kUjsIP3+QV0QCn5v/v59W7pw6LUmYWLnGvoa6Iu?=
 =?us-ascii?Q?+a45tdQTVeD0Nd7sp6QpWe3Wwp4z4o6XbNbGII6I6drmjzWEnEjKjEDcGwSh?=
 =?us-ascii?Q?4/0N8SJ7ENjUuHpWYCCXaKW0WseDocXaL3wvE8Z44+xIkEsAQd1NRWdNpINL?=
 =?us-ascii?Q?2GpA8vt/y4UXIrfqeCP4cTC+Q32m6Euloco74+wDJp2rsjJql16ywL/HBSWd?=
 =?us-ascii?Q?/s57CYaz6DyaJuDpuzQXmOZ/Mr6f55kWLGgybnk2JmfalNaFLmUVdtb6SZ9b?=
 =?us-ascii?Q?+wb2kYX2vQuSdoAkqvl6yHSOVLuqEXVZ2b9rZR+0EKP+apNlhsWBYk2lXV9M?=
 =?us-ascii?Q?YLhzDb9IDvlQoOB5o3wJknUAmuey0dAtH2vpB5YgBKD3OZHYLfRtqfGTdJt+?=
 =?us-ascii?Q?kZxE+nvAuKzPcrLPTOzKwu22z/sI8ALO/Ji/hWoQl7t/shnL/dQvoTc/8J9z?=
 =?us-ascii?Q?rrOTLJUe9jZiml3+8AaNUiJTbM9lC4vsLwI834s5AEDQ/zZGyXORqQ97JOnZ?=
 =?us-ascii?Q?Z+YCT6YrX66Swd5cR9c8zzzJwoPqf16Msgft8/UFsAfFzhPEtqYp0PVWPDez?=
 =?us-ascii?Q?uzCOT5j/qMLlMvTRwiSk09RNXWla8urR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j3wEuvIXg79UDEUUG0CHr/VrELPmC0vPL4nmsC9FPJ/SKbU5YuUTrGUexWZ+?=
 =?us-ascii?Q?Ux+2LepjV2+arog2RgSVOwyjByybcWVD4QPHwK1BkmgEAyKWwjy/AvfeCfGy?=
 =?us-ascii?Q?IlIHEdHWAjW/OAIgZ4CoiFgdC9AG/ig/zNWCQ9Wn140EPTRXJES1I4Hp4aqN?=
 =?us-ascii?Q?anGuwNvdhZC2866A+8KKfTWQQMjG89RENvR7IoKPA7/+4yQGbo+dfYxvDxju?=
 =?us-ascii?Q?q9Eveypgor/DQJCvADwVhz1AaP3NRDpRCXuwJbuWs1VYmnh6Th8IG8a2EuXd?=
 =?us-ascii?Q?ygl7YL9DB2XDQ3A/qxCzpmJbiipwcrkrxbC8HV8R+BhMqh8+WPhjDl02mYdA?=
 =?us-ascii?Q?Gc1nU4UdzwvSvNtDpIhLFkmmxMsPMky6UC25ducMZrHxBmKc4j0ITTdZz4JP?=
 =?us-ascii?Q?6B9sO9MWMq+CjPG/DGFmij88OUk9ofUAR67/XBeMHX/1JirEtS4QIMZJgyHH?=
 =?us-ascii?Q?8Aa0uh2mtMGZCMqeZLEeqgJL+IRPUX9G1zjwP4l/PJ164SvdHMztycZ2wPvN?=
 =?us-ascii?Q?++/dMptXW1lzQM/M/q7XMqE3Vq5ecaSWWfN8iBGCHGF/i8BDFVyyL09IIvEe?=
 =?us-ascii?Q?9fCIvUX8m1BrSDc+tSet2ceAQuU+CwRrjddfFXe+f+1jWPNJGccPhFTzD0++?=
 =?us-ascii?Q?G7amgv+CiagpzWFQwoXCKbGg3b01NWeBnlc0ZYeweRKNhFH0M646HEBEo5hf?=
 =?us-ascii?Q?5RGyQ9pG3g0BpLoQPaUPjoLtPGDofqIuogWIGsRuuGK48039ZdosPYBfDIrF?=
 =?us-ascii?Q?spRy4xcWQi7ygKH/lwEIF+fwq6rThCYMCuGT4mc33xxAHZkxFJdTnkcudXwC?=
 =?us-ascii?Q?1FyPas+sZYu61N8t8qYCYC357hbD0D3QEMIMnmHF8T7sYusfV2S1xxo1hNYw?=
 =?us-ascii?Q?n/tELWRYK7xjbOILqF/YOoPKEb1F7JmRuxxYSqyb+7RJyfT3hnPLb6yl0Cer?=
 =?us-ascii?Q?whSWMHL+xjRCAOrZGlH8VWUtUpkVVx2jllDsGBkWnulb+WDIZiTqBhZSeWhE?=
 =?us-ascii?Q?yZZMX0qKVODV9IYq2LitrMYpupflFxuK7E4JHm6GCLqgXNvQTsx36omvJ/RX?=
 =?us-ascii?Q?IYHTjlvzO7oFE3Gnrdy6OL7dJlvonL0c/Uo+O+0Qbj0o7YGMGJnDxKhXrnVW?=
 =?us-ascii?Q?mL5NWmaV4PG6PB8RWRU77xb3ESRai8qzzoYlWf+iwRwRWvVU41Qvqy3Ywslg?=
 =?us-ascii?Q?2WNVqd7Oguqqg4jegGV9tvWWWdBrazU2a+qYljQLDyJmj+Uww4A1bB7+pk+O?=
 =?us-ascii?Q?YONyOts+k9hHUiP1RazjPIZ3zjxaMZHWVVdinWwfrmuTYP6JK24TVMydgrYm?=
 =?us-ascii?Q?HY/bNF/4RAPThzWzrVN6pWpSy0nox4IdrO8BcS/1GhWA3bhZeQqK09cq1SF6?=
 =?us-ascii?Q?qpLf06Lqx7oarV9rb+xcauwfOXgfrwJM0mFuQjbLZYtBlSz06HAF1HkMQiy8?=
 =?us-ascii?Q?h99ICWjJW0kg0RaraijU/lsh5IKYWo227QyKS0j1s1nJ6SLm6sxUqhREUftr?=
 =?us-ascii?Q?ZXHvc7baxrsDsEGGGgNYZsOJPuaLLH9xrd2NIi5ftVMFHT/DZTVVWjj6ByLQ?=
 =?us-ascii?Q?wiUk3vd1aLZ7AhQKci2UPUFUkPkt4eKVp+3APa9Y+nq7H7mYFNf91bOr+wVk?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TPLWWRW41M+5tbAqAoQPTsSlk6VCy0EmdGMTs1ybdH3tQCtYa6hKF9RMatOeX9hGdJ++CL51kbTyvlilUQ/MoJl0jbcV5kQqQMfahU4rtQooY125Va9GLsT0KgprHuBYcpHtDSSgmWaQAZKuVf8Nz8gtVeQsMLd6kLRudbsELXQX77uC9aNnnaspe81VWi1ab1CMJABZfMWDAWQasAe6Z36+e3X8Dgrymk8OOaWvfRu7+3f4tkBA/sH5zYt+vlkrRz1rBsmIXTUYU71uL0SOdVuIH3ULEt/2tK9XV8bCjJZ0p378Ej8mi2qVSb60MUNnbv7fmAaqKqfV5k1+zj7IZGz8l/NDxXbIzUv8Bfpe/NaW4wKUKcGj0wRmnL2ldBgT/bhvrTELJBUsKYp9sYMxA65IhibnQTS32v7g+UZeMx9FG4V+IaRv4xgE/Fq+V4au3kiZSVsxhkWRpU/BhhBli/FskfXHd+BOyoODA5TwdsYudG+Z70KpdGbrjB/I+MdkWA57Xhqf0Z1GRQQrC5L0dbyelHUQVcX5+pr2EB8Ivu2oF2oZWe1vlaGaP4JlFYoSvXLOlkIm3LoST+nZw4Z88qZAbgp9EvQ+TI8EgKYeoRI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00941b02-68ce-4dc3-35f5-08de0cd50291
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2025 16:56:54.5229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TMPfwgOgEt3FVrXggpSzP6HMYpABaMSk/NxBcwd67eF8KsZ1u1cDtf1ieMyfkFnL328AK0c1KKQWfGmIwQ4PHAcDKnBaQJfATZST6xr0dig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6898
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-16_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510160122
X-Proofpoint-ORIG-GUID: aCYN5B9MLtkD0D2mFwh_39PWXgmhU1dK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX/qouiMxph4nu
 LjryHlx4mKaKc09SZXQBLDRl134CgD9dkOWUWI/HVpBOndOSMBpFfIRri2Qe2ey3gak8anrVDoT
 TQbPZJPTdxanPEjDUt/Q0GQfPsvEuHDqUKGXoE3GoQdsWIyuVfscY3nm14vWXJ1AWr6U7B89vK/
 IwVRHlEehdqCe5OnxhLBESXdfXOpLIq0i1u26bbBtoLqJBOBzCx+PNeDlRbhpQoY/54vJgy0usL
 Rb/cd4DXGFjwdFHvRhBDm3BaDk+vnXNRo8VJW88ZQT0VEkNodW/0LFqvKu4UjkJ+ojIJNsdpDBc
 0MhfbaIrrnAVD3Xv5uPvidFe3rkueOKzAn4zaW7c/DO0AyqPKjLiy0bvJpYSKmgLBm+Zhduc/Kg
 wk6e0hhw+YT5syYCnMlHUrmkbYsfWw==
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f123dd b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-GUID: aCYN5B9MLtkD0D2mFwh_39PWXgmhU1dK

In preparation for defining smp_cond_load_acquire_timeout(), remove
the private copy. Lacking this, the rqspinlock code falls back to using
smp_cond_load_acquire().

Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 arch/arm64/include/asm/rqspinlock.h | 85 -----------------------------
 1 file changed, 85 deletions(-)

diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
index 9ea0a74e5892..a385603436e9 100644
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -3,91 +3,6 @@
 #define _ASM_RQSPINLOCK_H
 
 #include <asm/barrier.h>
-
-/*
- * Hardcode res_smp_cond_load_acquire implementations for arm64 to a custom
- * version based on [0]. In rqspinlock code, our conditional expression involves
- * checking the value _and_ additionally a timeout. However, on arm64, the
- * WFE-based implementation may never spin again if no stores occur to the
- * locked byte in the lock word. As such, we may be stuck forever if
- * event-stream based unblocking is not available on the platform for WFE spin
- * loops (arch_timer_evtstrm_available).
- *
- * Once support for smp_cond_load_acquire_timewait [0] lands, we can drop this
- * copy-paste.
- *
- * While we rely on the implementation to amortize the cost of sampling
- * cond_expr for us, it will not happen when event stream support is
- * unavailable, time_expr check is amortized. This is not the common case, and
- * it would be difficult to fit our logic in the time_expr_ns >= time_limit_ns
- * comparison, hence just let it be. In case of event-stream, the loop is woken
- * up at microsecond granularity.
- *
- * [0]: https://lore.kernel.org/lkml/20250203214911.898276-1-ankur.a.arora@oracle.com
- */
-
-#ifndef smp_cond_load_acquire_timewait
-
-#define smp_cond_time_check_count	200
-
-#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
-					 time_limit_ns) ({		\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	unsigned int __count = 0;					\
-	for (;;) {							\
-		VAL = READ_ONCE(*__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		cpu_relax();						\
-		if (__count++ < smp_cond_time_check_count)		\
-			continue;					\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-		__count = 0;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define __smp_cond_load_acquire_timewait(ptr, cond_expr,		\
-					 time_expr_ns, time_limit_ns)	\
-({									\
-	typeof(ptr) __PTR = (ptr);					\
-	__unqual_scalar_typeof(*ptr) VAL;				\
-	for (;;) {							\
-		VAL = smp_load_acquire(__PTR);				\
-		if (cond_expr)						\
-			break;						\
-		__cmpwait_relaxed(__PTR, VAL);				\
-		if ((time_expr_ns) >= (time_limit_ns))			\
-			break;						\
-	}								\
-	(typeof(*ptr))VAL;						\
-})
-
-#define smp_cond_load_acquire_timewait(ptr, cond_expr,			\
-				      time_expr_ns, time_limit_ns)	\
-({									\
-	__unqual_scalar_typeof(*ptr) _val;				\
-	int __wfe = arch_timer_evtstrm_available();			\
-									\
-	if (likely(__wfe)) {						\
-		_val = __smp_cond_load_acquire_timewait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-	} else {							\
-		_val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr,	\
-							time_expr_ns,	\
-							time_limit_ns);	\
-		smp_acquire__after_ctrl_dep();				\
-	}								\
-	(typeof(*ptr))_val;						\
-})
-
-#endif
-
-#define res_smp_cond_load_acquire(v, c) smp_cond_load_acquire_timewait(v, c, 0, 1)
-
 #include <asm-generic/rqspinlock.h>
 
 #endif /* _ASM_RQSPINLOCK_H */
-- 
2.43.5


