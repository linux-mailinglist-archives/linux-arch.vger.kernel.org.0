Return-Path: <linux-arch+bounces-11783-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90675AA6D12
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 10:54:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966D5982A63
	for <lists+linux-arch@lfdr.de>; Fri,  2 May 2025 08:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9450623C4E2;
	Fri,  2 May 2025 08:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NjTr/Duj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bYAo4hYH"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C7622CBFD;
	Fri,  2 May 2025 08:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175982; cv=fail; b=UkAL+3NL6IOHMdBupTf626C1+Lhgx7Kbk1wAoTdRfKdLBEHWHkO/22W6fNEWdL1xYFgCnQqLa4S0XV9UCi/sxeKeU5Q9LPV/RsND6BBopcmmiH5oLXtTNpgsgfxnk3ub13DJCcULvfv9pVYeRfzyEmsCK2Vlv1VI6NEVDuckQZk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175982; c=relaxed/simple;
	bh=G3wmbQYT4A9mysxqESJUfURIXRSS26hi+ST4+SIpFv0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r6npwhV0dfZu4kk8xumxxZ3HT/nGiOnc+rQjbp2OqhwjUexpdKtZ4OPo8YkAQy0fbvhopYaFYUPLSKUvhlxE4wxjBCyGaifgwHdOy6qh1wPnpEmuCGX219YkpODYBVcxjxu154WbmM2CitTZxhOEXyIMik5SA9R5/CirWtf0ybg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NjTr/Duj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bYAo4hYH; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5425Wmfa016338;
	Fri, 2 May 2025 08:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OW95qXAEp2kQRvuK0BAR5LcJn8sgwCnFprJecTCjhtg=; b=
	NjTr/DujvuhdTjvFp2AN5PWGiwDUBCqpSCn2JixH4ifukkw4N0iwyX0GKJ+r1seV
	PCcvycn3fyRMcevubzifbHhT6LyFpJLNiDEdIf960LP2mvtPMQKR4sT7JSIlThpZ
	5KbiEyh+kbEkbus1Q7FsDzwx3z3hgHcww5mhWSQc/iIVxk1YYncZ4Q94P+rrNcW2
	QNSMc8YbZCUzsU7lK4xjt8mHT2WiAAqlYTD2SlgrtQgHCo/DIOLfKgoxHLN5ArST
	yutXJnw6lpbjrTWJu260fW71ZqrLZJZuQ6EYhlz0EhWWqUlRUGiorT/lifjc/UWt
	iXTse3WCTHI/RrSfIplBBw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46b6usmvp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5426aZSG033464;
	Fri, 2 May 2025 08:52:28 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azlp17010018.outbound.protection.outlook.com [40.93.12.18])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 468nxdj4pu-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 02 May 2025 08:52:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIYZMLOjxF7x+WsRgiSQQFqfYbTYBrG57D0BgZ5NlVK2smMXXIQc4pmDw5pEP/UeLKmmpsJJNOpViSqvYI+mP4IQGwN+w3z7u4A5T8vrLR7f4CA50oCrrh7Ah9pf+QNOxXC51+noII9tuqaXLQJ0IaXDRkF5VvGzGSeOLVFn1zlP+TWa5YxWzKOVBjGOXBhW+fSp6K/4IOoo/+x/KngxKaXz7MuCXiQY1YpevaeHgkoDh3FO+V0cId+oi58KtGWtpEhGLU27dmEArIvwG2U9fIpbCUiAI58rvChyxqESGI10XIwxfBomiyg3aywhnQz2ei4XpFneu7Ul+BH3km+fDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OW95qXAEp2kQRvuK0BAR5LcJn8sgwCnFprJecTCjhtg=;
 b=g8tI45gWGs7xaSmZFG+LOxKoIHqMiEAQsr2TJGTkS/vhQGaCt7MOc9GQ+dJ7WACurZaqqZ0rS1fYXo7unqRiG+oXlvAdTLe/gcX5TJolbxR97QkGXlKCnFmHf/fOhNzi8ANGhKNiSd7yh+0aENwAwxTU3hA/cIwQq5HTGS66yAT2S+gp/c4ThT1ZeCXoZLN+6XRwDmSLH6wb3MQxYbk7AJgdh8awL/eGtjniaxd7gj5wG6bveNjneiWDlayy+8Jetk+QIPW9z6WIGE1gE+7ORsTeZG7jbML/kLnKJVOzYy+zQDcv24ju8Zl8k1WA/YbSF9wVa3St1yfKylp7Zpky2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OW95qXAEp2kQRvuK0BAR5LcJn8sgwCnFprJecTCjhtg=;
 b=bYAo4hYH/XjorARjKLdaX/0c0uq023qgMSo/DxQOPn5fpRlvv//OLEzwP/24jyl/9nz9zD3718AfYbqn8iIHenQGuAWN9oilfbRHNh2KFVmXD5p9sX/95zuO4daIWJrHaewVTyB5B60NeMrRhe2hKO3noVVdG7Ajf+RM90WMMX4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB7167.namprd10.prod.outlook.com (2603:10b6:208:3f1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.22; Fri, 2 May
 2025 08:52:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%6]) with mapi id 15.20.8678.028; Fri, 2 May 2025
 08:52:25 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, memxor@gmail.com,
        zhenglifeng1@huawei.com, xueshuai@linux.alibaba.com,
        joao.m.martins@oracle.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com
Subject: [PATCH v2 1/7] asm-generic: barrier: add smp_cond_load_relaxed_timewait()
Date: Fri,  2 May 2025 01:52:17 -0700
Message-Id: <20250502085223.1316925-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
References: <20250502085223.1316925-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0003.namprd03.prod.outlook.com
 (2603:10b6:303:8f::8) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB7167:EE_
X-MS-Office365-Filtering-Correlation-Id: fc596c54-c373-4a1e-06b4-08dd8956a928
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oJzDwm6O0tvAVdi/FKI0ajLbYs4opSBhsqqtVFNWrJ9g4afjFZVkpJDngNm8?=
 =?us-ascii?Q?I//zNW1PQG4VCMqaWABaTypfnilRV4wAjCPeF7jMQAQ/SRw3Zma8xtFpizoZ?=
 =?us-ascii?Q?rrruVmvKF3TiY0NmS9kp3o7fQRcb3ifwQv1L6iQfntpZ/li3z6Uk2Ojg3FM8?=
 =?us-ascii?Q?1/sCoN2Cb0pMQpJ/+WfGN8JBQeyKxb49aGFgT1aqBiPeCW2o5cGM31umWcmR?=
 =?us-ascii?Q?lrq5C0/oLulX1s0f0LWbTnrkCLAPYnKsqKTM9osyn02LGX2tFMIdQd+Foegc?=
 =?us-ascii?Q?pA9sDpWH+o+AoFr8ClqZtkify3r9s0e9yN2Gv0EtaEW1+iSzfyPgKuo5Brm0?=
 =?us-ascii?Q?wu7rYvH2cQo2IWIeMXlYckk6pECWCti57BeejvEKlKx4Nvoly750yvEozyJ3?=
 =?us-ascii?Q?FyyyBnGrIUvBVyf5wGbL8W3xVtdWr7qkTnvvuTygFtIKK/qpbewx8gDbETh1?=
 =?us-ascii?Q?TDRRr9dRfxmg1KnOQnDGyY/lAaxdo75MuBDtyhU9Pa7037p5arEXKOzo0uNM?=
 =?us-ascii?Q?5vvHYmRjmovmCwOBRhqj/oeACGIunMKiBNzlynqvcbXTzJ0GZ410jhMBwNgu?=
 =?us-ascii?Q?ikTnqt3RsJbaW/Jm922wiw4YXio/+esTqPyzkIzKhjaO8gTwH71G1nuJ9d3O?=
 =?us-ascii?Q?OUw90efjaTEcw6M6kfKzjUAWH4EYUIFRIGHfgCICf5Yu/nIZPF8mTBIRvxDt?=
 =?us-ascii?Q?y4FVbojd5HmWgp6gwze2FzRUOnXZ5Nsxcclj4CLnv2X0/KiYaD2HUdGPyRiB?=
 =?us-ascii?Q?9QjW/aAa7YAHNlvdvW7Vw8hUsYy6WZzeIrNgVMRcUZIvvs0KIFfLAyxAJic1?=
 =?us-ascii?Q?zdxP+fMclshjCQh7o9Esx9zBWjmzq+n9KzYXOTUrkrzwjc7VqVVkbGm2OBvx?=
 =?us-ascii?Q?1nr1a4BzMrW0u3s3YAYPf1HJclE+8tp0rjdGlwXTCFPjbwqtPQTWAfuk1qmi?=
 =?us-ascii?Q?UGG0bxEGWV8npnWZXWqr+t90D9dvFGZj4zvh+xax1/IDye05B9Hk3Z/BsKig?=
 =?us-ascii?Q?fMwBcC7Q13E5wn15/AMpP4FFacGSEs3WH5bcWBm8wMXW8FWuq6kDqrN3tBYH?=
 =?us-ascii?Q?35hTzwwV+rfhHv4OmIsoUQnf26XFY192oPBwajkuBY9YXoYDG+A/efC6qXQo?=
 =?us-ascii?Q?JvNDaS39+HUpCb//XkZrXD4fKTwd9Wy6rTHfasUcP+kV50x4tOgCaf26MrzD?=
 =?us-ascii?Q?WXCMnGfNR4rZi+/U/ksET9rR2Fq1RKQ6nrlrv8XN/CqFhoWg419A5YJWyw6B?=
 =?us-ascii?Q?W2P6hovpMeHjWAtZT0Cc0sOkyDbHWThkRidYWGmMANKFU1JcpfTQI3ZhUmyC?=
 =?us-ascii?Q?B5jDLF2+/Zi5q2Mld0iOFj+OtypKSxGefqBNYyCLgFoNuCGsMYvdJbNGDu6d?=
 =?us-ascii?Q?dbplioZcawb7QuAK8pO5pKKVJw0Vj71SI5D51uDKmH4SwcN1OPrGalHvQdoC?=
 =?us-ascii?Q?wqdxjnw+i3Q=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ykqVs3vgYati1x5d++ko5uGmBxWBn+oq5Cn3HJmkoFE2kxrkmxyZgzhqj88J?=
 =?us-ascii?Q?LqAZ5S+H9hrdonadWWEEFVHPvH7dmX+p90fsEW2EYwFmguvTNjsuReHPQgZr?=
 =?us-ascii?Q?iLnR9VwB1zADQiz3eF0FIbkbxY3ov83PnmoUczvkHsh3KAgK3WDy6mOizHJl?=
 =?us-ascii?Q?AiWEafMBSFNpMB2BCmCXr2FOcLiL0B6EXLu1l0eOxwHzA9LnqLkT7fZRbEjL?=
 =?us-ascii?Q?mQRKqJP2IsxZnOdUj4v6Qc2zj7qMOgVRQKcG3J/x7SJhITdb0sxAui/IWBjD?=
 =?us-ascii?Q?dXJq3mlRjlNHBdHEKng7WH6MxMPncuyUfUw9dVE9eBM3YVspYcZYYk9u3KDr?=
 =?us-ascii?Q?sqWVWgEpPMfFOZtuGuHJGYsvRsshqe1h/rXDYeVFZQkHgyDnnzp4ZYCNMUL6?=
 =?us-ascii?Q?qmc7rpyzeyECGrpWDcr9DDImsakg3L5X47L68kUelU8uxjBvnLcyZmek20p3?=
 =?us-ascii?Q?yhlW8mrR8XwS/KOHXvBWnJeO3JvpZBSgN1RCjKRTSwUF1M2xWQ8mvv7C/AQV?=
 =?us-ascii?Q?K+tP8842TKlNIP63H5XfEFX7MUpfPvPvZTKslxujITIxriSZHa1yndMJ1nws?=
 =?us-ascii?Q?hpwrYtZUtX33J9N3/cu8UHwkW8bsEmKRxaHeqgSrT+kzYuHw3dqOkFZsmh4V?=
 =?us-ascii?Q?fSqRWWPwtbniE8j4SJPC5c2owpq8S+YybYjIzEduhLVY8iVKvCSygHTVV2EB?=
 =?us-ascii?Q?wz8ytl0EAq9xaPOF7535TGPloTKAjti5oUI6Q7yKftv9Qf+X/2VSZJfyQluL?=
 =?us-ascii?Q?p7WtnUScK3YJlBcPuw+13Dp7OaLD6S6s6ySVcUJmKWTelwl0p90rmqK9Dsw/?=
 =?us-ascii?Q?mvpEZaMPtYITdtKDpSoDwynOf4M6xjiT8RM1DpLB25OFPEz4hSapC44s1CIl?=
 =?us-ascii?Q?C7vSe/VkBhsKT3l+qzvFHFvpdC1y1ZYv2Ts6/gWUHFtHv0bSwbfFa9YbaIHH?=
 =?us-ascii?Q?4avzUte3b3lYUyd6SOHYdQkqTjpeKtY93+tAE2f3pTHtVkHBMmB574xWkpzR?=
 =?us-ascii?Q?AymBlN4sKrghjOp0OUVV3oOGkzoPMzgE7t8/kIqWR/l6QThWmErietiqkKrc?=
 =?us-ascii?Q?P3gp+BFZ6XDEI/aH8ryyU4FgYiUMm+RO0QW6JiLW8MQGqDt2xLCBRNcy24Pu?=
 =?us-ascii?Q?HRuWh0oSwSNpU8xOC8vWPCFyyidG6rjMdr+Px1XNqNXn6sTPn9FGzEQfSjy1?=
 =?us-ascii?Q?4eU52PehuiUD8Yh6bbMjiwi5Vf9Cv4s1DXGJrIWlsReSwFBmXHwqaObnf7lA?=
 =?us-ascii?Q?B2lFXNh/2ykUaTiEJGPJS333OL4KZplEnlhNgorhpOO1qsdxEnLUoS+B4eUx?=
 =?us-ascii?Q?PS7t/sntyYm/mzdiKevdzfyVewHGIuRVaogFWMx+emQWcV942ywG5XN4oryS?=
 =?us-ascii?Q?FwU+BaHpH7Bq7gIpXDuy+IO/PxH9aXzEOGSdalry+pf2vyKhAMWN5lhaQ6Mv?=
 =?us-ascii?Q?W2A5AMAj1a7fWDm8+nai/01rYjg/LyAKm1CX7H/0a4onEjZnMdQHRh6PBp3v?=
 =?us-ascii?Q?4Fdr6f3jvPSbSM7FfHkpuMpMqiDDkOHPU9g5zBdP62AbYrAJN9towTFIqDnN?=
 =?us-ascii?Q?IENTm2XI5S1UIQlccEXxcyH0z2aT78R1KftkOMf44YuHa9E4T43OV5GF3lhX?=
 =?us-ascii?Q?aQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9pSOSYZPHpgTrtALasUCSaCm4pZsJSNLcjFAN2ledHBv3e206+5zPSgg+riKLgrAFhMqoPDm7DbbKew6BN65WmgKXfDT1E0Q/XGiugLBTBhpbRST7vOeeHCWA1AUkzB+4FUuaAHbqphu6WUnsKUVQfe4XcK5PLnKtot9JRwDxtEYLzBHjCXVSoAN3PrfumPBYYV0zDBJ0lc2tgdyVpICrRlE2Na8CO1cl2JPLmPzZyDmMSgORT90nEDlozG0NX4PV8nhgR2aJYzh4OwlbKJfYx9nEmqKmhmsaXK14eS3dWyT8a19zJ03zy9ANfh/xnyffoExeAZ7z1N7nkhSZAuOIKbwl+59YscVUEfJwUwxyEeYEoECwM/xs4lusJstdrFB5g8Pyi3hxfQkZuspA2AUGFhhbecRalFVbwCZZxdYY5iAzYOjOy6oxlLlsVLserdYxMVaeWWx9kbq0c5ME8WX4UiG48qkP0GMjxG0eY+6G75FBv7nXuWlaswboeumOqOhD9e1PzBoEaZEuLM2jmQtftwU6kk6FYMb0xefQuaEYfXY3WSmxP/d/+V64LrEBtHjWJJ+9dg+itm7kjGYux2o8Bkqxs6QLY/YT/JOsdyZpI8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc596c54-c373-4a1e-06b4-08dd8956a928
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 08:52:25.5596
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXS0uHhOJoEMzwhTnz6KRA0nrZn4P55raOILe2OhduF4wYi72FMEoGgOwrFj0Y5vsguV0ExvEVSEAg9qDLNp3Vy8KQ4tYm2f3wfakR7FTCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-01_06,2025-04-30_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2505020068
X-Proofpoint-ORIG-GUID: RESEHvGh1btDMjgktzW0R-VE2XVKBmfV
X-Proofpoint-GUID: RESEHvGh1btDMjgktzW0R-VE2XVKBmfV
X-Authority-Analysis: v=2.4 cv=Hd0UTjE8 c=1 sm=1 tr=0 ts=681487cd cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10
 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=JfrnYn6hAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=9k9S6fgFhvPwn2OUN1sA:9 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTAyMDA2OSBTYWx0ZWRfX6ZZ7EZBJCzd1 dO+VyedqJoy4c6Z1LySPEnpPBbNW6E1/NuFO9Sv7WUKzTY1gci6Bs9lsT6nkAsqa7JYo0g/fwX2 cD9ProYeXpKq+PzEOoio3k3DpgVWNqkCRlnr2ZZrxFLrjGAYizNDKCrxAh2WBgRKHvs65TASiod
 5AL+YbnwVJ9OUVFWgY1c4faZ4V4GNDxZI9Jg4K8a2YB6xdzIJN7yRgkJaiMJGq6fj/K6acnsH+h vu+AL0x80A+1VqXjHQQTw/oUod7fvlNPMgA/nE4/hCBU638QjCGiFYqXK0eJ3nDwAqW3u+BFDGm kdLCk9wZLgFlUyaiKYyTGbghjKFqXncu4bAEhjegt5j+051+N3PNhx3JfiGls7MGwLP3TOSqNpw
 7PjfMYQ69RYVMsacR1PS9hiqJH3uTmTlQejTLnaMxTUzmMPeE0BbGulp9Z8y5hM7De6Nc008

Add smp_cond_load_relaxed_timewait(), which extends the non-timeout
variant for cases where we don't want to wait indefinitely.

The interface adds parameters to allow timeout checks and a policy
that decides how exactly to wait for the condition to change.

The waiting is done via the usual cpu_relax() spin-wait around the
conditional variable with periodic evaluation of the time-check
expression, and optionally by architectural primitives that allow
for cheaper mechanisms such as waiting on stores to a memory address
with an out-of-band timeout mechanism.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: linux-arch@vger.kernel.org
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 58 +++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..a7be98e906f4 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,64 @@ do {									\
 })
 #endif
 
+/*
+ * Non-spin primitive that allows waiting for stores to an address,
+ * with support for a timeout. This works in conjunction with an
+ * architecturally defined wait_policy.
+ */
+#ifndef __smp_timewait_store
+#define __smp_timewait_store(ptr, val) do { } while (0)
+#endif
+
+#ifndef __smp_cond_load_relaxed_timewait
+#define __smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
+					 time_expr, time_end) ({	\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = 0;					\
+	u64 __prev = 0, __end = (time_end);				\
+	bool __wait = false;						\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_relax();						\
+		if (++__n < __spin)					\
+			continue;					\
+		if (!(__prev = wait_policy((time_expr), __prev, __end,	\
+					  &__spin, &__wait)))		\
+			break;						\
+		if (__wait)						\
+			__smp_timewait_store(__PTR, VAL);		\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
+/**
+ * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @wait_policy: policy handler that adjusts the number of times we spin or
+ *  wait for cacheline to change (depends on architecture, not supported in
+ *  generic code.) before evaluating the time-expr.
+ * @time_expr: monotonic expression that evaluates to the current time
+ * @time_end: compared against time_expr
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#define smp_cond_load_relaxed_timewait(ptr, cond_expr, wait_policy,	\
+					 time_expr, time_end) ({	\
+	__unqual_scalar_typeof(*ptr) _val;;				\
+	_val = __smp_cond_load_relaxed_timewait(ptr, cond_expr,		\
+					      wait_policy, time_expr,	\
+					      time_end);		\
+	(typeof(*ptr))_val;						\
+})
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


