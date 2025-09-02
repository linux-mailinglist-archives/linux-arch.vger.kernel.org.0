Return-Path: <linux-arch+bounces-13360-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 651F9B40F72
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 23:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2044B5E4C56
	for <lists+linux-arch@lfdr.de>; Tue,  2 Sep 2025 21:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8627918E377;
	Tue,  2 Sep 2025 21:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eR0roJTM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="OBZXGJE1"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC5C26E6E3;
	Tue,  2 Sep 2025 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756848723; cv=fail; b=TdUFRFG7rForzzWK1sPoA/2fT/JiFIGXGSyhd7skN8J8U1DOgYrVUGcBCfig+jx0P/zq+/01iJzg61h7lzQs6JJrxJbQMQjXymS1BiLIvNBDX8nP2ZbcmxNq4IIJDryroD26+m/9ejaQnZka3Paz7aDfuNf1H7stwiHNZC1Xgu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756848723; c=relaxed/simple;
	bh=s95/360XeErgj6U0OlXSQ2DKHctcet2J+wmcdtSfM+s=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=tmsYdDgWfV/wWI7UehOf6PM5703PMKvuU1McZxWnhhqpuMclbs1n2AWfhQK9Nl11FGn+d82+K8wmTtEgBw5cnLw0dqqw0Y8sImZpEQ8AQlvzxaMtbNrygeRQCzp6lxW7N4TI3UMVurcYP4Nde53WdvEhRNOy9lSJF1+fiUhCiz4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eR0roJTM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=OBZXGJE1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Ki2H3014938;
	Tue, 2 Sep 2025 21:31:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=jfBhXX274lM87yRzYr
	nBsQWSdwlJDZ/Dow+bMGv2jkQ=; b=eR0roJTMy8T1iSAWkSz+CX++Lj9ETcQnQA
	bbMiRzE9rRkKr87q6XMe89OePbspDTUwsu77jeaE1NtGdfK9mRupKD0wP8bqnBbo
	aCAdsNyDO9Mc3e5x20ldimqtDjWcFOHuKFZ2cMEkmJ96by8EDF5g3Se6PGET4j+i
	DY+OYdW6WgSR5XWWnVIOk8KfxlDa+wcIMBare4Xw5oYHFSxTJD2/W/p8Y3AE5Sff
	NMPWrBTDtXZIVLCbuoOysjqB1ml76TXgN+zfblQQyImJlboLOPgCDWD6xK5l8ZdB
	MmMMeQbbOW4X2Nm49eoeHYvku1iH12PhwR+bhOBN1y+Gadv3/uhA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4mfub-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:31:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582L0uoV032694;
	Tue, 2 Sep 2025 21:31:40 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2079.outbound.protection.outlook.com [40.107.95.79])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrfx75p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 21:31:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHBQG4EKTHJscCs3nqkoQ39UUbHId/2cacAeuaDCj4lvKqPYh2n9byFEtEZGrA1fOO5XG+j+vd+8QZYK9svhORS5kkiBLKqTAWSWHf1tFsSpAw764lqahVKqAkCjHpJAA8rvkKk3AIzxVoYoFGAOk5X4KZZuI4AGDykGgS74QrDKAowYQwNO5Qbo9l9XaoCfg5lUQ+QqTO+54jU+xVX6T75VmEvpTmoHfIdXOr0egWBGH6WXQkhiDADqA+yA4tpltd4HMjKejw4cpGH6Rw/kYx7iL5HUzTq6xi7XhlRiIotOqp0oW4Yzc8gpqyQmhcw9ckooGYgbZuB+ncqqXlIHBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jfBhXX274lM87yRzYrnBsQWSdwlJDZ/Dow+bMGv2jkQ=;
 b=erw3XZgQs2U/navPmSNR5+bgo4yaV0yDW1uErJ9ITqOGD16caSH5RnmNQy+oPc4k1SnzgRQCg8GCo+Ha7oumuXn+xFWIteooR0SZQlglHKe6QeagopGqCpgWoyn9mmF4t2NOfq6SERUKExOkvz0NCvZSd6UZ2dSzmz3aHNrd2CFlvC3GGtpXAHxmtTbfzWwiYEbj5VRkVrjPrUeK/IjUI7/724NVjDxj+3wpYiknZMV/UKZKWXnLNetLkEd3D2JT2RSsJ7UolgCMxFX6Ny4F1LxWXP0J2KdbjPoH9912MAX6wHQJ7qvch6vG5kIqEZbNqsGO/ueBqB9sM9Gjghyu+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jfBhXX274lM87yRzYrnBsQWSdwlJDZ/Dow+bMGv2jkQ=;
 b=OBZXGJE1tQ8aYJEUkvDcJL0BZfSO+d9PU3+KCpT+zwSVLiNkslRZENoJBHP8a+shbupWJiACPPpd+fsG0znWragUcbRgESjXe0qQIqwEMDKx8Z+0oWu4gl8gWVd2bOMIW4nMOtNohuIqM3W2GEcydCBCoXpzLQi6yxbwXB4CKa8=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MN6PR10MB7468.namprd10.prod.outlook.com (2603:10b6:208:47b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 21:31:37 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9052.013; Tue, 2 Sep 2025
 21:31:36 +0000
References: <20250829080735.3598416-1-ankur.a.arora@oracle.com>
 <20250829080735.3598416-6-ankur.a.arora@oracle.com>
 <aLWDcJiZWD7g8-4S@arm.com>
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
Subject: Re: [PATCH v4 5/5] rqspinlock: use smp_cond_load_acquire_timewait()
In-reply-to: <aLWDcJiZWD7g8-4S@arm.com>
Message-ID: <87o6rsr16w.fsf@oracle.com>
Date: Tue, 02 Sep 2025 14:31:35 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0258.namprd03.prod.outlook.com
 (2603:10b6:303:b4::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MN6PR10MB7468:EE_
X-MS-Office365-Filtering-Correlation-Id: 416919a3-fc68-4958-32cd-08ddea681879
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hS/+a9QzmFzRmeUY+En99l5Ije5LDwKe0pHkDEz/rUeb8AsRSKIYvafXhdka?=
 =?us-ascii?Q?d01JWOjzVnooRfeJxge5Qg523kBnYJkS4lgjGflAKMNmkNOhpIZtPAzCjPhb?=
 =?us-ascii?Q?UcUPOJDwBy22x8tOvTMvkaOWeo7heAxuXcYww9P9tQAoIlovuBeasG7wY2QA?=
 =?us-ascii?Q?nNY7dDmWWm6eL4hjNZqrqBUwk1mNtkPpAQlqYL6GEPNLC0Nu7GiHg6WF2Gsv?=
 =?us-ascii?Q?+9XGMcbe8XUEp93LJKYcioF8qKNPg7TFxH35ZZ1ZrptNN5ygj5WigevySTFo?=
 =?us-ascii?Q?BTIUzTw2ZOkX8a0atjzRxB/SD7zrlvv/R2xwlAu09W8+6cE7TqJxKvPIxGB9?=
 =?us-ascii?Q?0i/cHkB45qPBhPS82prLHhRwA2xh5AD+JxmUQiFDi3Hbid8pfHveWDsQVLP0?=
 =?us-ascii?Q?CCV4fCW0CjXdrD/emF8YTyDTjyO08dkJ2Iq9GnV/iM0gfFCATb8ZOMdzL6mi?=
 =?us-ascii?Q?jTZmWHwd3q7Sq6zCZNwJrBIICJegQ1H5Q4OO5+YCoLx5A5e4l5pDwSolLkJK?=
 =?us-ascii?Q?6pDjnYrDJGdDmR/HMZ2/MO5GCmQXMnBWWm/hksB1shZMVPGgScCgZcgSpb9z?=
 =?us-ascii?Q?DvPYub0P9VCeb2fzFHIocEjzG+CuHosxUIS1B8sniZTz8FG4GEPvPna6atnI?=
 =?us-ascii?Q?Jx0JHnbVI8/mXx0bFpzraGxcOKe134LlMIMwTSBNiZy9I1QhvJRLKSRjLIA1?=
 =?us-ascii?Q?HwFFaUuKAPXYQxAn5jcKZkKF369c4qxZ2CoQEIL66KsV9D1BOnlm/B5xGUzd?=
 =?us-ascii?Q?bvts2W4lgpTbTRIx+xaKSsmXqbStdnKZBq32lkTij25hV3R/ExHkri/H86o6?=
 =?us-ascii?Q?xJpGOVwZJGZCM4myoNsMj19pVKsCA2JqCQbLZpv8wzJUm/vWbg1GWiTZvP5g?=
 =?us-ascii?Q?MkjkZVPmDfhkADHFPHUsDUswW29OqrJwhdqjCob3YaDfja0eJwEDlDBxiZEk?=
 =?us-ascii?Q?IvqUtbXEayP2vKkAAUp6uQzp/tteWhwaNRXmEPDXeL411t7kTQFcU7QSGkB0?=
 =?us-ascii?Q?s6m+M1ylPZKdClCxKkHiG24ITZHOLc4FLvV5dbuS3l7xKj3J9uuixp1AsMz+?=
 =?us-ascii?Q?fDqRjgiZXYwOqJVwm/8G3ZIriAqWK+FvDHTG/TYiPm4grs12dsuJ8kkvFi90?=
 =?us-ascii?Q?Yz8Xx2DJgb0tTwNWfLQCHVqkSJVaGAeEikDfrnsrENbTII6m/OCogNgLtic1?=
 =?us-ascii?Q?fqFqAcl5Z64AL5UGpnhcI/dFxdye/Sjs+h3URbBXIy3OXNMhhYs6Lpg8sS+m?=
 =?us-ascii?Q?opDO/k3bS46jkhplyvGeNhtx2cUbEPF6MM/d7PX6rvQur2WNfOs3YtZhsFIT?=
 =?us-ascii?Q?7W6DT+7KAaEDv3D5I1SW1/1H54d7PYDMHnLB3N7nwvon9xZgziox39M97M85?=
 =?us-ascii?Q?S298s4EJSqZfhIbi4gsiuQrOfFj0vnu2B5AmUWR38XMfjNnlJgGorA6f1X2c?=
 =?us-ascii?Q?xfWz1EYCSiw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4F6DlyTO/7q7szgcTZ1kwfhFTDeqtJlm5ZE5rZbdC8s9mqWdaV/sFr++ZVKw?=
 =?us-ascii?Q?RsyDs+vPLGsIfNEI79SfE/5np8BcIo8FEqjyo7M06dcfRJ1g0Adh9Fh1Zg23?=
 =?us-ascii?Q?iXTrGdl8IEraQUIAFHGajw8oQpVQ0AUnDGKOu7rfDbHThzq7fEkdjm8Y9AGg?=
 =?us-ascii?Q?VXPf/jdZ+Iio3CHKNSUIR5YpXA8OZJ7wT09onU82qiyt+Er5jy7DPzaBVQZz?=
 =?us-ascii?Q?f/eb2jyxASyQN8tAJ/prKg6AsHmqljGjMg0Z3e/XTVGQKH0/dBdVls9+mXXt?=
 =?us-ascii?Q?EOEy/Jy9ZitRlCGF3AA950iTPd62U+b+93H1i2fMEhqXwm63s6Lab8PpbWBB?=
 =?us-ascii?Q?Moy1chNuk4nwH+D6gXDaj45svgaxewbxkTNx61n8omDx26FVu6nk/2KnnH2T?=
 =?us-ascii?Q?oNKsXFFKRKnc+donHQ2LobhVq9MGPItXHxrrCwQlv44MOOZyNVxT0MNYOwNg?=
 =?us-ascii?Q?yTCm/gpLR7NGedpIFN/FvAiLIwiAn9zYUWQacIYzYNtGEuqCeHy1b+lTYPxh?=
 =?us-ascii?Q?s+Gbxz78Re/HVK6qcug6IeCQikkpTW1rYgz1lAFlVSM9uw98nSW6WU0CCPnu?=
 =?us-ascii?Q?7yVqUDMLARkOFxvHhgYgiIhTCGpq18GTan6pGJiS/ocUyws/VoXXn0rtaGjC?=
 =?us-ascii?Q?xMVKo+3j790FH1Q+vofEe777aFSUo0IFxGh5mYgmLw6AOVIdm0+0y1nFvZxD?=
 =?us-ascii?Q?YyIGPbiW4ukwuN02t4tOYyg+dnc6vjMrjLQLcCz9On3dWlFz5dy1gOsDlUgu?=
 =?us-ascii?Q?wL4I99UAbBAByKhqkM9BebhtsUajAumJBwbK0ivdMTjWYuedKrnEpPjYJF11?=
 =?us-ascii?Q?5MChdt/nE3C9ekj7uCEHdapGMDVYZb2ENjAdYGPv9dNdbpdGhvczA2YtMR32?=
 =?us-ascii?Q?jwuZUsA1MFRVZhG3GsPEOv7TIORCxFUcFOD6nvPwvRu3GYIkU6RRhUBJhAAL?=
 =?us-ascii?Q?bs+xCAmCNmmfESa2BQtINRmcky7orLmmmLBeV+SGlnWnseRZXUzwIumelm90?=
 =?us-ascii?Q?DgmD/V74+4UVzzROH9qYq/ieJyl4s4g1OlnPw6FspOBkrH8v6E4Sue5wVKv0?=
 =?us-ascii?Q?xddP69OEcrMLeYMkPERBmuu+8dw54q/PWFnWWO7dHsan+QIkqipF1lshXxf/?=
 =?us-ascii?Q?KNDaJPjuGe5mFtf+x8LTauGlViR8hTWSInMbk60oCnZiFT7pKnEI8nL0lzHF?=
 =?us-ascii?Q?U+l7lRSSrxsE9IJyC8egqfSQscQB2TjiMqWGW922Cx49fqSTYuApAspVYAyZ?=
 =?us-ascii?Q?TjI1nll4Ev53EAGt0h+g8zzeyHjpPpGhTD6DOBLvjnvChuOf9cG0nIFNRx+D?=
 =?us-ascii?Q?ywGwcCGbwO3OII+LwQhhe6oWc9m4Q5TRTHxCkw9RS904gr/+7c6prkDkpfBE?=
 =?us-ascii?Q?A4kQsntI05nwGn6HDhI4eaBsj9IHzMo+n7Kxu2yERoWeyzrf2x3NBAb64mk5?=
 =?us-ascii?Q?uGacosPtZhjhLHHpBwhdjA5VSFu4At4CfmOoMrcuC5NQfy/Yx5VQ8xVZoFKS?=
 =?us-ascii?Q?ZR5HUHD7XTrX+sv+FI2QBd/2p5VHxUFeh1BMnB9tIUywrLWjyK+EPvxIE4g/?=
 =?us-ascii?Q?rCE/3jD+Y0cky6zEZka5XVSq6S+8CdFdken/sWzmGFW7eI4a6kKC4xcHc6cs?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bGFqq9AZ11VAuDetXtla1G3rp9pTLxoxJSLPOZiRO5NlXOxy23rVrcuTxFTEy3yosTtWO2QcWz/+R7LezEtIvvyCyBF4qMGB22WITJ0TOhdgWLd+swiPQYl70g28zyrwJem6qyso7Vav4MX54k3ZJmLZN9cEFU9sIXTgQddTiSgV8wHhgLMONecXaV7bnoqkOnS2kbiQLNMLosY3iAHZNa0MatDgiyZ5vXXZBL41PAiYPO+eIkJV5iYJGC+VaL6WCSRVVAOnaD93lZxq1ExvY9y7v4n0+GRnwFWcN8ufHnKHRQPzIMwco8FPg9JiEOYxwtH7ZlaaWuxY7XBgdiSF2J4uNcXkPpq8T07Uzo3zlzJQaV4lH5OFYlb/mmJEtVWPBINbQlOpMNgGIClc3IXXwcAmO17pg+PehJrz/DlcVy/Y88TgmjVgoa6gMh1zR6hQ0uqMULbYWYhDDz/VNFa7zbziWWdIxFAfB/3w82B3exDn+Ns7x2Sn/DZxLVagMbddYaw5L/qB991NfEK2k+Pf5HtUc0sNt1efdAxRBqxsejh+0kddJBB27SLF8QkNRkYkz67wSnpzZZ0ACuwQk2oaEWKl+W5rA3FBXnzYuYtlWO8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 416919a3-fc68-4958-32cd-08ddea681879
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 21:31:36.6162
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvE6cYXUeU5WRw05CXUQ/wZkrzgluZIlVLFuiUksf6C6QCOVVN2/eDl+4Ttrdu7kQI/jQ2BfoHtVWU3OpabWcE0bJE/EJ/P/BxgoLNNakyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB7468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_08,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020213
X-Proofpoint-ORIG-GUID: xmfTgNtfIdmWx4MvvLWrelAJyNAQXjJP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfXyhKsr6VuFIDs
 /ctmvp1YgGqZfEGLwz4BM3Tzo0oEa4RQrnBW4KLpVz0pRjcd3pK6PSwnO7fP4x6fJP+iWHpL0VF
 G/wQoTEi5rLyQcbGTnEWEuxUTwaQgaxzzrZADPYQgCQ8UPRc7y2eBDtQ7s+llelFn6im+dTSj1+
 rf8Twzy1Vfq6l1txkz0BKOYS2OxuXWnlP5u8p38vzWtwzK4TyZLcj16Fn+RFdBFOgQwJe4lv2oK
 XstWv1jB+xNTDWaeTx4GwCpiC7i8is9cNUd6QLoW3FWzRWoHPer9ty0YU1wgrQeWyuj1khx4R08
 ShI+J7FwmQ3fh+Btijwy5jNjplACc3krSsPhfYk0BCxz05/x+ObZmB0UyM29UmFwSFMRDgR9Mrc
 7F1VIEu7/ufnOdeAz+9rgp6cb0RMsw==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b7623d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=yJojWOMRYYMA:10
 a=GoEa3M9JfhUA:10 a=7CQSdrXTAAAA:8 a=lxOBaja_tXAgPqxXYpYA:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:12069
X-Proofpoint-GUID: xmfTgNtfIdmWx4MvvLWrelAJyNAQXjJP


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Fri, Aug 29, 2025 at 01:07:35AM -0700, Ankur Arora wrote:
>> diff --git a/arch/arm64/include/asm/rqspinlock.h b/arch/arm64/include/asm/rqspinlock.h
>> index a385603436e9..ce8feadeb9a9 100644
>> --- a/arch/arm64/include/asm/rqspinlock.h
>> +++ b/arch/arm64/include/asm/rqspinlock.h
>> @@ -3,6 +3,9 @@
>>  #define _ASM_RQSPINLOCK_H
>>
>>  #include <asm/barrier.h>
>> +
>> +#define res_smp_cond_load_acquire_waiting() arch_timer_evtstrm_available()
>
> More on this below, I don't think we should define it.
>
>> diff --git a/kernel/bpf/rqspinlock.c b/kernel/bpf/rqspinlock.c
>> index 5ab354d55d82..8de1395422e8 100644
>> --- a/kernel/bpf/rqspinlock.c
>> +++ b/kernel/bpf/rqspinlock.c
>> @@ -82,6 +82,7 @@ struct rqspinlock_timeout {
>>  	u64 duration;
>>  	u64 cur;
>>  	u16 spin;
>> +	u8  wait;
>>  };
>>
>>  #define RES_TIMEOUT_VAL	2
>> @@ -241,26 +242,20 @@ static noinline int check_timeout(rqspinlock_t *lock, u32 mask,
>>  }
>>
>>  /*
>> - * Do not amortize with spins when res_smp_cond_load_acquire is defined,
>> - * as the macro does internal amortization for us.
>> + * Only amortize with spins when we don't have a waiting implementation.
>>   */
>> -#ifndef res_smp_cond_load_acquire
>>  #define RES_CHECK_TIMEOUT(ts, ret, mask)                              \
>>  	({                                                            \
>> -		if (!(ts).spin++)                                     \
>> +		if ((ts).wait || !(ts).spin++)		      \
>>  			(ret) = check_timeout((lock), (mask), &(ts)); \
>>  		(ret);                                                \
>>  	})
>> -#else
>> -#define RES_CHECK_TIMEOUT(ts, ret, mask)			      \
>> -	({ (ret) = check_timeout((lock), (mask), &(ts)); })
>> -#endif
>
> IIUC, RES_CHECK_TIMEOUT in the current res_smp_cond_load_acquire() usage
> doesn't amortise the spins, as the comment suggests, but rather the
> calls to check_timeout(). This is fine, it matches the behaviour of
> smp_cond_load_relaxed_timewait() you introduced in the first patch. The
> only difference is the number of spins - 200 (matching poll_idle) vs 64K
> above. Does 200 work for the above?

Works for me. I had added this because there seemed to be vast gulf between
64K and 200. Happy to drop this.

>>  /*
>>   * Initialize the 'spin' member.
>>   * Set spin member to 0 to trigger AA/ABBA checks immediately.
>>   */
>> -#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; })
>> +#define RES_INIT_TIMEOUT(ts) ({ (ts).spin = 0; (ts).wait = res_smp_cond_load_acquire_waiting(); })
>
> First of all, I don't really like the smp_cond_load_acquire_waiting(),
> that's an implementation detail of smp_cond_load_*_timewait() that
> shouldn't leak outside. But more importantly, RES_CHECK_TIMEOUT() is
> also used outside the smp_cond_load_acquire_timewait() condition. The
> (ts).wait check only makes sense when used together with the WFE
> waiting.
>
> I would leave RES_CHECK_TIMEOUT() as is for the stand-alone cases and
> just use check_timeout() in the smp_cond_load_acquire_timewait()
> scenarios. I would also drop the res_smp_cond_load_acquire() macro since
> you now defined smp_cond_load_acquire_timewait() generically and can be
> used directly.

Sounds good.

--
ankur

