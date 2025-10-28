Return-Path: <linux-arch+bounces-14366-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8954C12F55
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 06:34:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 391D8401FB6
	for <lists+linux-arch@lfdr.de>; Tue, 28 Oct 2025 05:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5587C2BD582;
	Tue, 28 Oct 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DtsA4B/y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c2shlTLx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC229B789;
	Tue, 28 Oct 2025 05:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761629543; cv=fail; b=Xj8eS9d7sYDKTxHDPrEH7N4HIztBVgYFzwkaOleRumvIxZRFbgRSDNPOJBvTn/NScu8yAaNJFFrWauVW5HiBjTDzV2DiKXQz/RIPXCPe5tPuG/JXjcQcOghfBz/Zz0iRZxJoctBkEyn9bzWUxV6sNNvo44x1PdOwvhPYFfAzykI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761629543; c=relaxed/simple;
	bh=BeoSOVBsnVe0OtSm/G3GKUi1WIHCex7vo8V5WseY7s8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WlIPZ7odaPNiJfMxdW/cM330t0UKXMHoBOmGrMxZHzNyF6rkvwKlPQaQgjB8tuH8cmkMEMqS48Ma2oxBQ4Ffwp6ha3RvtrE+YBkCgnOTHh+WKTpKvg2++LKMcrFiqJeShdBvsCnaOpM3raEivPvNvvAFI1g9sT3+5OMqoXA+pbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DtsA4B/y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c2shlTLx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5NMfK025771;
	Tue, 28 Oct 2025 05:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=; b=
	DtsA4B/ypDFl/GrmzHfrWkfNpemq4CkqJXy/76PpRLBGPRLVG6FdOcPVs2h72LTx
	0U5iQG40/cobUcgIff6jknwR7pR9sH3ggJq1Hyb3QSK97cCMl5Ukff1G6BuLdNrh
	xo6/RjvkySq5k7CCdPHu6Orol67gyVikpvY5SbxOne5hpDFKR1zQlORvVPBVxdXA
	OP2gvj7lnLhSmJoBCy5CJbUDte9+3IIlJyofqrE5DP64fiH+X0isw7//1v3Ikf4U
	HAmjI3f38jBET62J26SFMbDbiOQWsB1f4B0Y3NKv8erE+AZ7y+80YtqatBs+JKEd
	B5nkPWoOZ39ByU4So1YyVw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a232utn6b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59S5Uirm035767;
	Tue, 28 Oct 2025 05:31:55 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013040.outbound.protection.outlook.com [40.93.201.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a19pf3qta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Oct 2025 05:31:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PBF96hIoSkp6HzcBP7X5h4J7649mTguOwklwOknjpfFRqjRQhddygFy+Yf6PefU2lVIdfAp/dzVywFsiph7Qr5CjETDFFlOEAsXrNBqSDNqjwlThP5DG0pDWNoWPHM2VgtzNo74EPJheiQ6NObj90z1gS+dyog6h+lzq3DpHE+kH/3UxUhCK1kc4xZlP78xrNFr4tqhHYI/yyy5xEsI20jsBDlVG52poa6DDCHSoxkU5a0S8F5xEImXN4rm2OiAnOkAM9DoEow7rgegLz3f4nN0083hOtDfge59e7MtenMi+O/Tu6n/IfRaK6CWnqWHEJtj7HqrsjPmDvtN3e6SsYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=;
 b=cUVhdPRzCfhPFLDPgv8OTbOmNwkT7QJmBZ4+VLY6hNhFRtScgsby3s7g3QO0z18ludAGe3CmwbRt1zGW0gOUYKQxZ5WSyktlSI/p0oWi8DEdqX9ly00c4SJYhV9ilIwBR0v+i7rBAZSg1YyzU2VyAMtXKSJvso4AUA/dQJ//ITTf6ecwFtXSE7mGpjJ8NxW8qrethGJu9sZ/mAd/A4aSsuq973JOmsu1kVmWmWViNZD+J9BzzmWTGUhAlSweE5d7s7PWRWA8WfQCfzJkCBAb6oZ3DB4YD4wlITbBC3/4cFzR7tjXdJf5caNA5VF3TRRJQbRJGAufHsrp95MQNlnWgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zRHgCNRVC6W147VAE4cYpr/hFajmIf9qXA0xF80NeXQ=;
 b=c2shlTLxZdbckprVNE3pqCwgOOn738uKYi2as3YLnSS6RL/kEZjlbt0WnD88EnNGOpsNdGGjqecboGU/3YAAgNATD/AXVQHhaQSToD8DgwyYKth23M5V2zgG5QO++q/elXM2wp6mQchii7lZJGe0lDKrbVZ01Zu/6x7c97Nh6rM=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7152.namprd10.prod.outlook.com (2603:10b6:8:f1::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.18; Tue, 28 Oct 2025 05:31:52 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Tue, 28 Oct 2025
 05:31:52 +0000
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
Subject: [RESEND PATCH v7 5/7] atomic: Add atomic_cond_read_*_timeout()
Date: Mon, 27 Oct 2025 22:31:34 -0700
Message-Id: <20251028053136.692462-6-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251028053136.692462-1-ankur.a.arora@oracle.com>
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0088.namprd03.prod.outlook.com
 (2603:10b6:303:b6::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 553fe0b5-5275-4141-06fd-08de15e34cd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PFwXadsnsvyimCskCSwwz9FjLTvT3tQWFEd6h1UphFyaOgIbtn6dkQo+6kwh?=
 =?us-ascii?Q?Jr9PxGqsofkYVIrHPUXV4divG9FccL+0a2f1xvEtVXzg70NFyoet7k9A99fT?=
 =?us-ascii?Q?WkplMcBmd5Wj1HZL0tF41E+776b/g4njSZUxFBV/Xdku0FYmz+5nTORim6UP?=
 =?us-ascii?Q?/6r7iFomMdhnaQajs6G0bRJs1pc8QMNfM8XSu5WxQdsS/uSXZigqXcTLJRVL?=
 =?us-ascii?Q?z5C56Tn/VCNaxZCqA8A94p+96FUxfb+dP1ucoGab3crHESP8Mg5lIM9bHCHU?=
 =?us-ascii?Q?scR9tk4WL+K4ZeGQBnuFkaHQ+sNLU5hkdDSadUu0kuf8iPAywRexVWR79ir0?=
 =?us-ascii?Q?huosuGaQasD0CNQTerbxXcKZFXnenmGjpa2cGulDa53zsS0Sl4C3TD4k3hgX?=
 =?us-ascii?Q?I5z45qhE0j6cN2vB0svxLbVfQnNlKZqmPYAfmWcPD5+rcOiQvRlMGFgfKnZH?=
 =?us-ascii?Q?y4OWfhHNGLqSXRd1LH1kPneEKhig7eghFqtY90hqtdnl4kFQrsMzYQHJmavk?=
 =?us-ascii?Q?0JUlWytTRwJ/qbv4c4GgW/nH34/OEjRIPYp2REz5m0NfRUQ/GTqFq6ADkubK?=
 =?us-ascii?Q?2QOd3smPdkA+8HaEiE/GANMOUuuo4GH3kJMgRGXFRm/QtafPNqznPktH7AyS?=
 =?us-ascii?Q?KcrfgaafzPxbuXcPDeacayPC7/GJpCBSqvq0d1gTEzOCJF+H5aUzKwM4ANZp?=
 =?us-ascii?Q?hkhmJODcmUJIIiFY7XBbw75zecScP3hXtXHjEgi0jAbQvEzfyozpq8VSrSGC?=
 =?us-ascii?Q?cTOB3quc+PbWR+TQVGbj/90okfzNzaciWM7BkAnELjcCy9iRteu+sg4rDvjW?=
 =?us-ascii?Q?Ws44ZpA04lV7wyUovbqzWHKIRJNseYUZvWovyR9plz2urYCu7DKJkPn/RLhQ?=
 =?us-ascii?Q?4sGy0xyt1WA7r35FwJbHRfemZFERs7EU3vYU6ici9krcbpSXIJJaLyeqwJ/a?=
 =?us-ascii?Q?SjQcX1iok7mnhI6h1FalVS2PMvZWkn3vml/gAjNft3yAqytBI9OIF2qTf4Ja?=
 =?us-ascii?Q?WC83/2AVohAW3SiXmF3heH03u8K6QVHZeiTrSBrK0qp5yd3R4yAXqi9q59o1?=
 =?us-ascii?Q?fgH1YlGEPgNRN6+g/CHojIHTJLypefKeHLBoa6eQg0lvi+5ZT7FGYj/cen/z?=
 =?us-ascii?Q?JKZwagDZo93f7Xrh4nafRwRkXfd9qd4Caen9Upm32Gz0p1Wj2Wu8A06NDpZz?=
 =?us-ascii?Q?5Lhb8CQPtjmaP4O8Q5o+/424LStDZPHxrxoQ16ZOxvg/oweWSMa+JSY9uHVu?=
 =?us-ascii?Q?pPc1Jm5ehs5VOXWIGbCBcMH2zidnflAv+9RODaL1PQ/eWAFTmk3nWxrG6ECP?=
 =?us-ascii?Q?vrreyW/TbAizsQVLeJkE89m0t52X4lSdAeflwKt5DTcjSctmDY8Y82L2DgQl?=
 =?us-ascii?Q?klzByW5QIP01wBOMvBEyLru232NAXjeN4y9pyw5aeP4wI5SPAidHc7XZTyqi?=
 =?us-ascii?Q?3z9cTjLOaUUFh/GFzUi/x0GNnv+VXJeN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8RMvAqrsc6mOnZ80XrehryaPIzK6A6uHj6b2sT4iOdck3KqynMur2dZ9EBHn?=
 =?us-ascii?Q?59sLssRVZUGGX+jx4rnfJ2UefTKpsNZZO83p7SUWMcUOr5GZy/ewi/sHFpz2?=
 =?us-ascii?Q?dhJfzVSXiSdmNc0eTPIpFymlv1u4ySKrAGCz6WbYceI91AjN1fTYeN1cllLG?=
 =?us-ascii?Q?p7k4KV26KV9om/C/xA8RSe9yrPo+fAZiYhF6dcp92JDhL9owJSUwSWo2t3wh?=
 =?us-ascii?Q?HD/vy+GI91aBkxLX8n2NBGiUpxXVpaGenOa+7IApO1GDnVIap9YkTPVGjr2G?=
 =?us-ascii?Q?RfHgtTwNyyOuKEtGi+cQgiY+5H+ETkKbV19/0qk7yf8pDx9hQ/8BzGO+Nv8z?=
 =?us-ascii?Q?hOOgePVaopLDFuyUD+7mf34Ge41OowPxftHlTNbVt9f15iwnTzg0S/DP24kY?=
 =?us-ascii?Q?4Zw+HEJGc58ak/uc6aqw1NisYmh9KqYy7e0u4HZMJfu8mbsPhc10zM3h6egU?=
 =?us-ascii?Q?Nl8giNNFoM+N997roSnMfdBSrH/XCON9T1YaB4IDAOxKQ6D0+z4/SgwsvrNq?=
 =?us-ascii?Q?ppnq7bzJByN0eaS9H1judT4sb4QsMUgQyBjnT4rt9IOsXjzMs2HTCsLU2KfL?=
 =?us-ascii?Q?p4AMKWDXuNDOrB3Sl8kNPTTQ+sBpIvKmaa/yQf0LH+wm92ZyfpBjw4Ar3rMc?=
 =?us-ascii?Q?G485Z5ZXB2ck8BJ98t6MDRxrrWFxn6qtoHK6BgLDQ1SSVuFmD7y+pr+2unzp?=
 =?us-ascii?Q?UKr9BaR4rjMwkM49Co72NuaI0nx2Ob2kShxE5EyF+eJ0BnccfTD116mvShXM?=
 =?us-ascii?Q?PV0lBifbT/HPpgvor0LYeKMc4bZqZjLdlkVBBsum3IKfSkU3EI9fLEe6sPz+?=
 =?us-ascii?Q?MonCfL0dcOikccqtmuLUI/QmhB3kRMX/GsZGImWWONK3A2lVzMA8PaERr8Iz?=
 =?us-ascii?Q?/ONsx5ri24bIDSK8uSZwEsC0WT7EDroaieryb8xQ50YnDlTb4+vZV1giBYVQ?=
 =?us-ascii?Q?EsjLb9CJsqOKXJrQBF15P791TrNepyIFFO1/q9QJNOQbwPpZpEPvJWepMdol?=
 =?us-ascii?Q?5OGIQJ5kiyqkfrxpEjjzhGxYfEz5bYH7z0QKPEMyuXwoY8ogwK8YYSJfXGT8?=
 =?us-ascii?Q?pDcyRdlX6G0haq1iTICXyGbHkXgYgp8fSMadQwzi1yuHD4XF3Tf/PpgWR/Mu?=
 =?us-ascii?Q?sZz/p3yBoSl3w2aZkVSmzDEuhS/rzD8GshSYlpCly+y1WxZQi8Ixi4fGJY8b?=
 =?us-ascii?Q?bxehPkJLDxN19uWgWqXXEX/HgFeCTw9KjU6ie6S6ZwjgNkddhX4M89zFrYRB?=
 =?us-ascii?Q?D+Mv7fzQbSG+G9Hsg8McORoQLnRs0J1DbjPo7Tl1qlWcZCh+UwxaFuVg7QnC?=
 =?us-ascii?Q?pQrpy2uIT2NPW7PTqFjyyn8fP/6921igHHKd9gAgV/LyB5YgnaenoL3Rh5G2?=
 =?us-ascii?Q?e7bo8KiDyOevc9RFaIp6hNx/LmYbtVIg7BezPnUAEWj7BEXx0nuYC6mYt9uE?=
 =?us-ascii?Q?3cj3NaCrzfLkOtOoq2+HTw/hQt/CIeif3urDqJVbPs4KDBKRgblfe2qf4OPs?=
 =?us-ascii?Q?I53tMf25L1OpfSyPfDgw8BhDwRSpl2O8Hnamf5vwfbQ7C6KK0j30eOxS00su?=
 =?us-ascii?Q?i2B4n/XYY/UNzki1w3Vm+O96OIHnh/VoYlbZtK7ETTQlYSXhPr2UxKrZM0Sr?=
 =?us-ascii?Q?vg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3oEvVZ6unBRBMfKbqQpmMg69zwkjusm/wHSTsixmTWgGtuakKlpCILNBRq/Yw/asnK1F02sASGopdb8SwhEXoHW/URX0c85bvzvQhaiYX+uN79NYnwYfOYlIBh6kfcdGWbk2B3i7+8hnO1566YUfJou2qu0XS3JybwUYjdIjifzP9QoinLndPx46rKVOMm4BcIAPAiPahOQL2SL2LWoiQpaSmdROJLxvjduqDubE/lfeHl4aHfBD35ureblayn+/Rcs5boCnX2hkSYbgdG7F+cVavKpYbyv3X9F3YmCbmhOjgWhSBnUgQmyo0QA/mbzrgLgMWT9F+E43XpoI7+C3GAU6o/CugvQzzVt31Roq9xCmNDOv4OxybU0kccRY/OUm9N4ZQMThUxwIpeMaFsIHpUufBB40TnRANLxMWclIlfeKzUx7GljF8Ka2ZgrGGvGnfWXzrTLY2++q1N3ftqe7rsYqfkhBbsqJJTNfgwAvB6ZIwLAaL8IttLucs8i/mO8RsOo3M1+Qd7sh4dEWEEKlvwfVPuS/5Wjl0z5fbcI2+ebla5+bMTwjFK6H8JS59w8aZRWUOEg3C6GULiTFQURuNq7VHBnCYQQz+GNvo/HVFjY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 553fe0b5-5275-4141-06fd-08de15e34cd2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2025 05:31:52.6960
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TIgGVHjGvJ1uuuTpsPJqUi4FaykGNmaCVhl8Ja0NsmFWb7AcFEehPiWOzqh72iFz7Swcwz+Czn1yABet9mwRdYkueJ3VO5YEnm8xm9SDDgY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7152
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-28_02,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 phishscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510280046
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI3MDA1MiBTYWx0ZWRfX/wbvhuOo+AfK
 gYgpgZLmaoFv3WaRuL+81FGgAIkX68JQgMK23Nuj+ztb4vZn4vMzBMN+k+tGLZfLVeBfr+DgZGv
 0ZwMq+9KGiHYMrRc2G1fwu9KQ20gMHxVNg8QXWWZqJyjLe9IVXQ2c8kwN6EriI7dANWKj96Pyx/
 hFWZ+3uFLFo9bwOVCYoA1tyYUb/8WF+doYgorARQ7soPDTyjQeRJ53Y5Jy0TaZWF2wOxB+gTKrl
 mUvsfk2bhIgChuiWe5ejXDahaFmJPcxa9ajVZKLvQ2ux8oF5DV0nOYthguh+CB5Je97yRKY1gTL
 D5yVMUQiu1lML8NhuLgf1s7TDx69XEvzDqA0BLpoPcIcwfyor2q9FUDa2QzVUzbhnHaSDMcOu0F
 SJMVof2lB0yZpojMBIndyqizqe8RYLKpn0LEcIt0UQhTdKiMhLA=
X-Proofpoint-GUID: Z5A77PZfaGd42DyZ3N3pMIe65-8gTC1z
X-Proofpoint-ORIG-GUID: Z5A77PZfaGd42DyZ3N3pMIe65-8gTC1z
X-Authority-Analysis: v=2.4 cv=abVsXBot c=1 sm=1 tr=0 ts=6900554d b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1qaWZlc5I0uanKkomNYA:9
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12124

Add atomic load wrappers, atomic_cond_read_*_timeout() and
atomic64_cond_read_*_timeout() for the cond-load timeout interfaces.

Cc: Will Deacon <will@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/linux/atomic.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/atomic.h b/include/linux/atomic.h
index 8dd57c3a99e9..49f8100ad8af 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.43.5


