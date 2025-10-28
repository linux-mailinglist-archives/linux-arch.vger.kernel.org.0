Return-Path: <linux-arch+bounces-14363-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 330AFC12F46
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05FB53BECB4
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE8F29BDA5;
	Tue, 28 Oct 2025 05:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LkxWzRzp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmprqgsO"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA4629B224;
	Tue, 28 Oct 2025 05:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629542; cv=fail; b=EXfu8gQJ7sSoAYIIx8qoVjzSx14opwIiPO5/vTPytiOIg18POP1j81sq4anAwur6WcGXCqW/JI02tS+yYDxP/kuXK+spw9viDL1AY2oz13LFlKbzsxbuiCAoNSCjzSqzxD+GIoEIBgLr0Un4wJPRvgBdmMH9j9zYK3KZNdrrmtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629542; c=relaxed/simple;
	bh=FK52YMMCVxwCs9Y4sdCTYteB79+tTa69hZfF0rFFTjo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zs6d/WPUHduCBLUMDVrIT++Srg12InKD2BQpHq2JAr7/nUkkvuU/eweZVAGtVuEkqHFSkj7z7LfZ+qjXZFWkukYTnweQfI5uakO789Zx78eV5m3poVmo/GQkMJ/aK9Rh+iF+pIACfM7e/Ug8nUNBOgPhEydfL1W8a5usnE3LF74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LkxWzRzp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmprqgsO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NHFu022572;
	Tue, 28 Oct 2025 05:31:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=; b=
	LkxWzRzpyrxnEGc9rJeki2uo3+wK0QIfMKNNvdv182V3b0NpM2aQeVL2k3Hm0Kxf
	vaEZaJ68cD9FQ1ygXluTAdqBT7sEWoac/wWTAIhsQUMoS9JJ++uyAUInT+g5q6Zk
	H0BGONvm3v0kmHJ5ToBECgYJEPljxESZlJ+nKFJfv6L1+GM6yhSA9tEoyecxtKn+
	yjZ60aGQSdZyIM5EXitelfkzioceS7AUiW2KJiCR4MliQdIPdEY48lxWt7g5ekq+
	t0O5nfTSpF9KpS2UPsSQLrU+JE2oScojT6wj12xgiSy1GML9VxLr5VKl4+JBrAmN
	kNtr+lbXAsrceo8C59qnxQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a0n4yn8e8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S4vGIF014964;
	Tue, 28 Oct 2025 05:31:51 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012034.outbound.protection.outlook.com [52.101.53.34])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a0n07qcjc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BQl5IxGrlJC4+xhc+7Noxnz0/52fO+SYm9PDmUeqCcCVnpkQXbmKTj86lEQeRdzaN8Zm9CaazEFZDcxbD7wb43i05hjYuoxbE9y4tkmS6MSM2oioKBk2M0TtfNPqqlv4hoFGakjiLkmhrWL0SMZE7GRf8RVXlBHkKE/JoxWLMcqPiUw/JJGmS9yCrVLCRHh8exDtgcV8VifnBLFP80/zX3Oh9j3J6DLMu6clCYddPTNUyVIxgGKuc15qf/2BrELdy+HS75xR0xB2oyKsdDDuE4Mfi7P7Rbg4mtRdTi71pkFBO75TZ9OEsYYnfW9iVlZqTQGQqXP8tctflXLZ7SA6sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=xZ5Pt/8M4JH6xxCL7npDzjdwSSyiPcHGVbi4lDdEA3MNjae3x0KspaFjOo8SoXIehIDrhxwoia9PAET1F21558fSL0BVU2SeTcTrL0YD8I/WrD0mzbSuokYG0I5lJq/HuGwnPL4wsaoU/CBva5Ilnf22IntnJ242fNyTKpWIej6T4AR+nl2TsWHduhVXpiQTV51NTaHgNfVBM9Dsln9pnzJb7RmW6E6GaUKhX2MIh46ziU7b3DQ5ichIOCCLDBxUgplQT0pKNU8kXPFLzq5qVmsE4GcF3mrAaoeZNsbAk+1jDJVNHewwc128GL34ZzERPwZz9n7j1859+BAxc8XnHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3ABf7IwHbPRyeRjMmNlquK3uSB3dxS3CMG569NdO6o=;
 b=zmprqgsOlXl9+o31rhjCKBRYJj5BUNrZYLCfbz1wlBmZgGagrLdtFmW0JaRv4gA3XgeeTSOJIADl7akDS+U9QVdfp2vQFuETTqEogzt7ZGTZNonwy2Q626MIpY9qgjp+1j418CkjYkqkNGMTTqL/Ht6wZ3ePw2G8Ys8KfBTNd5c=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:48 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:48 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [RESEND PATCH v7 3/7] arm64: rqspinlock: Remove private copy of smp_cond_load_acquire_timewait()
Date: Mon, 27 Oct 2025 22:31:32 -0700
Message-Id: <20251028053136.692462-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0369.namprd04.prod.outlook.com
 (2603:10b6:303:81::14) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ff5c13-8ddc-4a47-74ec-08de15e34a6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XfOlGOw/zD5CTG2pi8sgvmq6XS3u+20fcIMbQUHWDKzM7wAAfEtrCD9fIf3N?=
 =?us-ascii?Q?5M2ZdGvXwqwzgfZx4zyWhKH4MhL+V/LpchOMwHLOfioF3om2geXtoggYW0sU?=
 =?us-ascii?Q?T/GqY2EwwZORGLnv2YWHYMMrrz7L01s3jKiTVwRr7gWfwKwVvTfy0pZ2RM+X?=
 =?us-ascii?Q?njU+2b3Wdo10g8/Ay3WHXQJvrxL8aUFjmMT1ue2iYjZi7TP2j9QOo8N2E9EU?=
 =?us-ascii?Q?NvOh5p5IVd58m3yH+aigogf2e57aSTE1P8JrP69K40NY4XG+ql6Ur/2oss14?=
 =?us-ascii?Q?eG80O++q5bYEhZMG66v6xSRFhFr4YlR+VGHNxBXSZ66pI0Qlh/KI+S87H3b8?=
 =?us-ascii?Q?yJpEA8chUzECd9zZXD4SgLMLs2yeUExVGYD9vdVc04d8aIkzJ4+ZUSFBLii9?=
 =?us-ascii?Q?DT4W3r6TAymJOMwqxFpuvniFGQg7/Z5ngoWN+f8oSAd6VnJwwEbf/pIjhha7?=
 =?us-ascii?Q?xHoCpOYbWzUFAkpIv7Bu6ldcmbl7UXRGDx2jmHugwYbElblzWz20NG9U90Dc?=
 =?us-ascii?Q?c6p3xCVzfUhhqltAXh8qaspEzvP7nNXhE/ig6pfr8b2KRR1jnv1aP3K+1HhS?=
 =?us-ascii?Q?V5Ye8oj8PK75KIZRhPybLIGDugVA2/Q7Z+4F4wSTo/JDgwnjrpBRTnGtfnN2?=
 =?us-ascii?Q?BC3Cw3VXmEAmXB0T7qN3X+VJ7vb2vENsS6Wkq8C+nwHjEG4fEAJhKAoG7UoX?=
 =?us-ascii?Q?PLo8VddRIO8BzgobLFfg5xuqcfyAZ35klZSHaClVm+VripDLGuGQAumk8fZX?=
 =?us-ascii?Q?cFHPPz/Sczg6Rq+BqYklUg0AxHpP4FsVAcygTt/WyZNl16eg8QoW73JjJvo7?=
 =?us-ascii?Q?g0eMBV+hCLuE0dvXjIMV9a3vSEIihViO4qhAR8v2ErGtBq7yq6PxxKa+4chI?=
 =?us-ascii?Q?NfCP9UohvBlv96pwm2qkMwi+k8bGu9dKxC7Xf35hkMgq/7yGQPxzPYdEwC0O?=
 =?us-ascii?Q?ww6obiA1ARm6Jcuy0WDSad4MtBnwZvBtd9UuK+HqpH7F86rhXmyjIg6XNIje?=
 =?us-ascii?Q?Hwo2O3u1rrTi1wlL+i2UXe+gXQeXyh1ljO8M3iH1wVz5ALEit7Tph6a/ITr2?=
 =?us-ascii?Q?SnLTUKeGhV7wFqQtbWvLfAajmzhdB1zbek7SGfzjyAUMoNyGXYeGDZL/4waa?=
 =?us-ascii?Q?JHANi2suONScbfX2pEvfaypYeLbdQqZYNqxM9OzSS4ieBdL293cu/zBQJhFs?=
 =?us-ascii?Q?uhPv75W5mpT7ObdB+o9A7E/R0jLQnf3mYSe9Wu5i3Xsa6WG/8o41lTINfP20?=
 =?us-ascii?Q?41R6ATCwZ8dEsgf2JK6IwjyurQS49NsluDZ18w3Kl4bLnFG8OpzGSjyrZyR4?=
 =?us-ascii?Q?X+5NEkh3Mu9ClqTL6+uZK/GKcmmELm67LrwM+oeIuaxLpo8gY2CUkd8qEnH9?=
 =?us-ascii?Q?kjuDpbg9cZ87wQ4c7GcYHW/WS4WN/kw43PlKv7+G+98h75ogwF8bC0xE4SmH?=
 =?us-ascii?Q?AfiIxgsYGIXVXuzPSZ18KO/3qHAZLBIY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0GCT2yI341X5XyOeXvc25zeB24gG4pHSEFuhdIG7SOgH80Zm4Qxoai6K2bnt?=
 =?us-ascii?Q?bpwuDqIkoSH2xNCj+X7fm7bWHzPto1L7fe/5D4eI5k0WpvZKxztBR0m6Xvxs?=
 =?us-ascii?Q?PL46CxEITQLorRmW2kVC5vhqm3Lq1uNWBzpiS6UQiCj0AxECer6TgAz8l/9I?=
 =?us-ascii?Q?9y5RPyYsQpnaBerasQzco/Rkkb6rAqQuL7t4iBj1W3djEtYMqJXVPI6ziQa1?=
 =?us-ascii?Q?mZWaOtIffC9Mv34yXGjk1uJwu52bdJa44IEO9kMKxuv8KkHuluqIxEDa4f3X?=
 =?us-ascii?Q?yIoEKa2xj490HiHaAaGletmrzfEDCjkse1cbcVr8SekgtKm1hAJRjfVEMaFN?=
 =?us-ascii?Q?0y1Om3iLQqK6uHJ3FBGiyOcWjjTiHP1n6iEbmRMpLXBsoDdoGkO9izUjkToh?=
 =?us-ascii?Q?mzefn1lrdyAlCBZ0YwSSq+AmpPJgxatEGz1su07VMU8EydWt0+WhhdFdEXXu?=
 =?us-ascii?Q?t8A/RnrWGTjZ1wGM5fyhS2I6w+2btrzS91GpvpWzsh7t+al/MFDTcjqfIegi?=
 =?us-ascii?Q?AF+Mga05YdUP3C7gNFXYZXbd8DrF2jO904YNofG4hrn8CE+gAfTVOjH/usZL?=
 =?us-ascii?Q?1ySCFGTxmeSThrHg4vtlGqgqzPSGxt82k6b7aywM44TAMj+1Nvklfs2pOZ5h?=
 =?us-ascii?Q?dYk3NNvnUSYOhRGTzRmQYmdh3D2nrS342//9uxCBQ4WGf7/eZbCrl041vVCj?=
 =?us-ascii?Q?ElwvEmEnbq31MdYA0uFjTFLOlI93f0hsfpGWPMklN6hrPwwjivWl6RDOfu9y?=
 =?us-ascii?Q?HcDYj7Iz3SvD8kRREv2quIQ3/2BC24gAmeG0fT59G4CeoUrmmWm6bFbn9k0G?=
 =?us-ascii?Q?uEW5DOJaoq5u7/xM74kNBus8FGjxVFTUO9Rw+sfUwT03Mpc8W5oeE7+vwawK?=
 =?us-ascii?Q?FM96wWHPwn5ls88HJN1uvL0avPbyiUGlu5fWqivUznRe6+oOSfTvoF2kvfoI?=
 =?us-ascii?Q?2VLDUh2/1uDvir1WochbZMcuSRX98kx1o9eBHUiTroVIq9hiDBTumXhNOhM+?=
 =?us-ascii?Q?VHyOTeI0uYQk7uo4Rv6YinNRqyQs162Dkza0tBbQmDS20fcP3mhHOoQefXRM?=
 =?us-ascii?Q?wGfqdswkBYQGVXATeT8LnUhIRbhB/8nSufA/emdz5b81tTBzNYQzNkflG3Q1?=
 =?us-ascii?Q?tqY5cLNQyT525tbu5NvTmJCR67o+RyfiRzYLZWzhkVrDpIr8gv9tQtBRyh8k?=
 =?us-ascii?Q?hsuNlWmrtcU6Hj0AD1+hMevnSuc1DE+T6TR+nyyYqvsTnR+V+u6fSmNDYTi5?=
 =?us-ascii?Q?AbAe0YEbCkFvwXiq4pp1ZAONJqX6lqtORj/v/bAyfd8PNsIWfxtRdRKduNXZ?=
 =?us-ascii?Q?3B7Sqk7Pt5J3Hd1mKs1eY9K3wy53pKP412nKJpSDg8TGfkDUoEQCp+hOzLrK?=
 =?us-ascii?Q?6bBkBztOhDva9rGvRczD/wDGk5ohEl93lVz1kmcvreglCmYkYY8vFBLgQj0h?=
 =?us-ascii?Q?s8pRazRK0bJ7pkKD1sGBekPhJgLc22czVdGaZMcup5Q+0+Wie9RUnPFID5Hj?=
 =?us-ascii?Q?SOLK1/w94Pjwlh5LxbB3OYcgaVsHxkFtgikmujXuRznBzRNWRER6irSlxq/M?=
 =?us-ascii?Q?0L4CeZrKX6EulTriJs6qtee2nkhdr0osTHBCMV2PGdCsTTuFTtXhm2UIE/15?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	fs18DO4q2ft5WdSN7Ze8nH0BbLbA/sDg/xK1qf1x+hSVF1tqRKR+Zn6yc1Karl15D9JT0hImmQMLqjx3J7HllpyOPqIs6aL3NpcdHK9NMQjanvkMDPFQ+CVqaV0uuOB1DN5CRzVR12KPCB/hzTmW8p56MhxXMyYz7jnacTh65TWKR9+MPxpJ6nPXEhjodrwQ3xgIj9p5mN5Vu/GGzdJCT0us5MMYBZkUuPZeWUZ/2erHvZE0rOdKOkcY1i5xQoIJh7HlQaogK3nYAMzMP0aHeHkjVd5N743DMiHfKU1HOIBfVgCBB7cexgvqemOrD9v0yKv1MQXhSmhXrhRHPrCJwnEqxUfYR2epOc7zEC+BzBR4IVvqOTk58SD4ZtNPsfOHKC5+M5Z57sRvpl5Jps5G/93zZrsAtGssJuq3ZnKTFDhPu/JNPwwcvX8lHLr3FH2lQSYj3Ri6My8g/RojOyXgy6HJ97pAJFJs3flyF51GZcORBnUSWDnvGgknzmH0izgHEiNC3xZ36LdworHyNmYx3Onhuwga3Co46QAd/e/QRyXXSPll3W1PVnrShOx7BxNEF/WR/R3ONWOD4Rzoc7J8AmO8zi8TEq+UhlqryoV0x7s=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ff5c13-8ddc-4a47-74ec-08de15e34a6b
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:48.5655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4tDAB1hNuD9KfrhpJOwdt+OfxH6ItZ21PfHmuVlzliq2dfOCUWFuHw5jfaXD/ZLUoZa7enYeuiivH652dwxMPY0/3Cs4JpSH3530YaRIO0E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMyBTYWx0ZWRfX4KFJlQq80o0x
 5BmRzX69fS3+0ewmwia5thAaCIpq0nj90GRPEcwCfBTMy0QdyaV6puBgsdsSRTyGisS552TkynT
 6YfnTJuKeyc1lmXwSk3GWcwO36kdXaESxafpQaW8alMbfmdgTT1+zXDYvAT4QlQZLwv/vAvxY/U
 3g5KrCkTB8CQQZdCIzwIl9KUzw7LiV7S2Qa1PWwOqnW4jtqCRiIWeaCnFc+aQUu8bMO2/xPq4Ir
 +my6gSPmqWkq+feOrolFgyjW90p3r9Kee+iU4thYy68Z89ekQpT4WbjTNb0XWbmgzdShAl6MkdD
 T6Sj/+YChAaGLiBzywIcCC63LE6IXLh9AiFnrX9DleoJpn6RL5VS9Zq0/lLMBkH0GMzzrXUFd/c
 1sb5hkcnj2aw1+3WqfqPehw6q1qyfcAAoLj7klpytwKzNNcbsAg=
X-Authority-Analysis: v=2.4 cv=Z9vh3XRA c=1 sm=1 tr=0 ts=69005548 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=7CQSdrXTAAAA:8 a=vggBfdFIAAAA:8 a=pMBjG9WjWPNDpSeUJj0A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: SaV0ALtU6e9mPgZcm3fv4j9kBieWlkau
X-Proofpoint-GUID: SaV0ALtU6e9mPgZcm3fv4j9kBieWlkau

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


