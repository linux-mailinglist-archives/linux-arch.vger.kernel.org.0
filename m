Return-Path: <linux-arch+bounces-14389-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B117CC18274
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 04:17:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B703A1C2562C
	for <lists+linux-arch@lfdr.de>; Wed, 29 Oct 2025 03:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C61B323F42D;
	Wed, 29 Oct 2025 03:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FbhJZW0/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w6v8lJgg"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4CE822A7E4;
	Wed, 29 Oct 2025 03:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761707869; cv=fail; b=nDgSOcKK5aErMtk6V4YVIyoRUTfOBwmvVEbJvmcPNKQxEsajWakDcxchzfW7HBBgC5LhwA0gIfz99vKFOigPj5YRdgnFzCHYokn+/Hi6KJevwYB22GvYsVkHAxhl7wWIN9e+wBbDsGy75NzSuSKL02EjtOyiIX4ybKPNacTTL5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761707869; c=relaxed/simple;
	bh=dMv2XhvBgJZcJfzGTA4ZFXPy2ZpVhDQAQubGaGX4FZE=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=jokHJdcVcpQdzO5Ol7Q0GYY/RHzY8peqi5mVXj/KhSrnKNLIS5MvWdXY3zeOIiCwG5j3nOmANyzFT7XGvryXMqPxwiXP9O8TnjhXafewN41c821MzzVUgu+aWqMpciNt6+2sLKrMn327XtTNoDpx6yNjM5ogccwMMxmJpKh0zN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FbhJZW0/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w6v8lJgg; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59SMuSI2012651;
	Wed, 29 Oct 2025 03:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=2Wu6B43Du6JfoSip4f
	ZZNyGMSOw7FOmhUua1I526ZRQ=; b=FbhJZW0/cBSPxp0CAcd94JTEGpEy5sDsYg
	98wrkbJp/7IZwmQg6J5qG250OVZWJecO7zVgPOFCHN98Gd9BfmVgtD6DR3XGEeAe
	Bn6iLUJnmX0RaKS0EY2Jl+/qspHjiPvDy9DQ3KVbPgnjueErlGrTrnbBBrpBz5KL
	DlTGRazkfH9XtRjSvwbUeYH3HOjRju7BJfTuyZ0yIA2NA4lxSTRderL+7CB5sEMW
	Pc9388Y/DrONkI0BubBF6ECWoY/xlsfbSct5/h3EVwQDXTF/IZfBok/c2EidbASE
	K4wOQ/wDdUhO+Y6S1oYYO/ruNpqeSvJJjViOYZX4clwlJI7qY/Jg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a33vxgn4r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 03:17:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59T0XbSW011184;
	Wed, 29 Oct 2025 03:17:19 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33vwmnr5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Oct 2025 03:17:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xagASib+RzqlbuLHQQs/d9jZQ2aodASIVwKx3bhUfKIDBkD9Tji2+HQoQe7wiQtKEK28gw4bmu/wqxd5fhD9ZRT/Td4lgCuHk+hJf0v5Fem4/b01rsZyJBQ06LTZFF9HWYajms94bMVAaun/Wxc1jR/585gwUq7wEDVvmQDB6YgoIARRaI61Etj30smrL59tovUjOt4DU2gi6ljzqW4oL1vJOO1ixhmkrJV7Xh8oI5A9fon4JoOAkx8Mn+Q7ccyyy1Xg065tZ3Om13JItk7Nm3ESEv/Ql3UNDfgd6Wms3IAjPjgj3vNldxE6cLBg+tSdBGi7Xgrnsu8ZCwlmrW2y3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Wu6B43Du6JfoSip4fZZNyGMSOw7FOmhUua1I526ZRQ=;
 b=sVuv4iIx0o4rntqCIFpUeh6fv7pQApH0DA01PE7pP3EOkg2yeCF9Zft9ahmQGDheB0wbaowvHrPtiyWuqa45tvD6AbtAr+YHk4KOL29LPYSZPQBL3DLqlbjW+qwLWNBRiD+EW7F1JHnggoq1/ZXcdHnH+iUkBndMVqrvFbREqpYobHWySf3IWViW9xPNV8px/IN8S4zgX/M8QRiMPODSRSXxC5OrbmFVimho3F6fNGAiElPHHiqhpCV98J/Z8EIMKelzv2kS6XofyKcJf69n2h3o2MYvLVV45h4jEfLfeBBGsuG4S1ftVzW3UWI/FwZaPKVRS91afOomtXsQ0MYitQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Wu6B43Du6JfoSip4fZZNyGMSOw7FOmhUua1I526ZRQ=;
 b=w6v8lJggYdh6YKGvI+EssM2zuHskPq9QHbGkYG9CS38RcsVCpwbPzB+6aeJVkDIw1Qmbz7vf1y/mvziOXfobia2pL5eL7vSKCy3iUHtoioy6X9grh5tcFWZ6S4xHaR7tQSFyWDb2LviwvyezRvc+6Q3I5B7yOQGH9SbD6qKlnkE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB7174.namprd10.prod.outlook.com (2603:10b6:8:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Wed, 29 Oct
 2025 03:17:16 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9275.011; Wed, 29 Oct 2025
 03:17:16 +0000
References: <20251028053136.692462-1-ankur.a.arora@oracle.com>
 <20251028053136.692462-2-ankur.a.arora@oracle.com>
 <4c87bbf8-00a3-4666-b844-916edd678305@app.fastmail.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will
 Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Haris Okanovic <harisokn@amazon.com>,
        "Christoph Lameter (Ampere)"
 <cl@gentwo.org>,
        Alexei Starovoitov <ast@kernel.org>,
        "Rafael J . Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Kumar
 Kartikeya Dwivedi <memxor@gmail.com>, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, Joao Martins <joao.m.martins@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk
 <konrad.wilk@oracle.com>
Subject: Re: [RESEND PATCH v7 1/7] asm-generic: barrier: Add
 smp_cond_load_relaxed_timeout()
In-reply-to: <4c87bbf8-00a3-4666-b844-916edd678305@app.fastmail.com>
Date: Tue, 28 Oct 2025 20:17:14 -0700
Message-ID: <874irimm6d.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 63dbf6cc-5d09-4bc7-7c6a-08de1699a93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qXoqzosi6H9fDHtbETQ6sDuXm/tljNWIH1fN19ahNVqw48TmDAul4RxXsvnU?=
 =?us-ascii?Q?I9BwOgVlwk/1CEifxleKOZ5gFq2ETWZBI+M8LNxdrWChi0lm0oxMQJPpEW+K?=
 =?us-ascii?Q?ezqYhSXL9Yyjtzc9Kq9UnrQjiAiKQfEd2WO0DKrwp1z9CDBA5odbaQctqxJ3?=
 =?us-ascii?Q?/IgmSK4KTqVF12rcIYzuQSodMMImTzPgWIZf6TBF1x5ZoJl3eWtyPdjRdNjK?=
 =?us-ascii?Q?f5+vp1hz3Ivr5z61okYqMm0hcfYYe0eBFQTa8vPOERBhykyh6ytS80HTY6L+?=
 =?us-ascii?Q?iAIaWN8uO4XFMK4pVBhrpMLrL+bpihUjssmdypfVmfOpEuYWgW9NWoQRFeyY?=
 =?us-ascii?Q?xPKxbd9iHZbAHtQysiEfgH2f7AnifFz2l1tp5Gx5BVrU6hSw1Kxpqzb7DbDt?=
 =?us-ascii?Q?YrAL3Kotu8rmNjfb3gl88CUsjbMwD6sd3XsklPVzZbkTmdWOC3uHREZtD9Aa?=
 =?us-ascii?Q?QAtfEgAq4ueDxaAlQ6mN9ooLvgkzukCeWAb2mQobp7lmf5RUxQ9GyKLS329W?=
 =?us-ascii?Q?DwiQB1EeGU+kPzFjYJ3g1exfL4WAjELw6IQaZn0k5D0Jr0wouei5CvHTiG2F?=
 =?us-ascii?Q?mgsXINMn0I2DvvtKrmXP54YCzLzqSkuDPsaNITUt2+LsmMb3FF+bU4VZE2NT?=
 =?us-ascii?Q?woe1yMlpUrtk6w2WRq6CRtZh1GOoGWI1iqviHSgjP7GvrCOhrFdbDPgNq1Dp?=
 =?us-ascii?Q?i2jQIXhQUzM0fUuXILfomZIjo8yuH1yNBRcn1noawWWRseIlL04AXy0JyVHw?=
 =?us-ascii?Q?pEKerUXFnl1N5lA4L9u2ay+QFTSqCAgWWPIwUjWrvGXXXFUruE1hdmBM86jO?=
 =?us-ascii?Q?E5x/GMbgPaeyszsiYML2T8zhtTH/5EXIFRvLMmkSf8o5ON3fbdh+qo9wpEkw?=
 =?us-ascii?Q?vG7v9UMutduIoIy1lqKSZZEjTF9oHonOeCwjm8WltqV2rWeuGPV3136oUjoG?=
 =?us-ascii?Q?g36n+cVmMHFe2AfU9FQ8kn6rlAIf5P+mJ0TdqKzLr3uDc+zaJ/+x6OxH4CGY?=
 =?us-ascii?Q?JzFeYqrRiry6Fzk8yPwOrsFxHznuwUTL/miiIknp0F9L+d7fPEp3kV13zc4U?=
 =?us-ascii?Q?NSJsO5gmON4q1Z1djjJ7WcapmR2iTK+EE/ogCzqRK0VdAucjGBO5Pnr+wb4o?=
 =?us-ascii?Q?X+WbR2nI0uShIwSyR8TVKoje7rC4Gv/+mZ4gAUuZEaA0Z+Y4Cvtj7g7qU9KT?=
 =?us-ascii?Q?KGrBbAEOJlYkWbiq7dyYyPF/QG7E5tD1ewWnt/r4f65lrzcYtP2Ubdfjb4SU?=
 =?us-ascii?Q?UoFdD7gOqfq5wMdT8c6a/kCKV3fkOcRh2HYEenPofNl0C9RRivJL1aH+xRw1?=
 =?us-ascii?Q?0tbAEBP8YS1ikRlmowJsu3i+47eFUDQ792ax5nzpWN8bUO7Zu5oR7Ib2d+vH?=
 =?us-ascii?Q?JacNBeGahwuf1lb6Blrk9bVMD1Yv46UMwg6TIk+wPnwUAhILPdRvOeQ2QmG8?=
 =?us-ascii?Q?P6G9j/OOp/S50+4KvAj8hYkECmtaJMQs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jUnmkoM6Fvi7FvX5udFJTEf8G7NzIMVh/Vwlwr4MVlD0EIn2nlHiixjftZ2W?=
 =?us-ascii?Q?6kcFo0Fc5JsvqFEy7Z8QdqgvIQssaLfkQctv/9/6RcQKku2PSDvyJ187XTY9?=
 =?us-ascii?Q?X+IdVHOVBR7yinI4VnY3jVomwuP6JfG+MZ0Ok64/9lidoUIVKIFaYl1/ylxJ?=
 =?us-ascii?Q?6LfyO1bYeZwWsHXSw2kKSoqy8P710GaFga4HjLBRaxliMI6eh/zE516xwn6f?=
 =?us-ascii?Q?wi5ynNkNxUO3pbTq+W043Q0pgAAO+YUJ1vrqDJG0nmlpDeRRMNzyE1GheDSV?=
 =?us-ascii?Q?XYWl9WRtY2yvqmuX03Bd0Z01lefi0xJ1bMoa+maOoICR9RxwI62S5CmpXrzr?=
 =?us-ascii?Q?IyBm6pB3ZYZ1VEK8fgrxu8WL796asTz81z0b8HRpzzJm3bKx65a/tz0F1l1n?=
 =?us-ascii?Q?vhXH6Gn+kamct2k8kBCjBMRMQ8BF7LmplxmOVyPZM/447fkKKvO3agR+nW9F?=
 =?us-ascii?Q?uoW1U3zUEqMJXaL/+R8y7afaLIQDv0bZ1Xe+/jsg7g1Gelp6Pi+zEG59frjz?=
 =?us-ascii?Q?c6gZCe7dVck2okPtq9oxKzHgWQwqeCo1QF9zqImkTNDGj51RECAPhp3VcFoN?=
 =?us-ascii?Q?TJxXpiIcAfM4GDGncSYJhQke1yXzy41BwTMJoyok9fCVHOFs8cxjP6ale3bU?=
 =?us-ascii?Q?b3CSNb0KvFju+2NdRfXHs9tNMnoH2LyY+0N4RzN9Lca/h7YFwqGXlell1aV8?=
 =?us-ascii?Q?+XtVRq+eAgBKBepKPYgDMEJA/t/8VRCVfkUuHBNYkumJEJIvw9CxnjujkA7m?=
 =?us-ascii?Q?QGmB55cIf2XCsK8cfdbT+DofeyiwdCT+1aQ9Yy8nwjuHqm7oHEWDl3SDHn3A?=
 =?us-ascii?Q?oxETwlcenSylSVBW9qJmvyqCX87P5x63eq2BAH9HNaLeQZRmkuPkT50NSnGo?=
 =?us-ascii?Q?N+d7sBIKBUSBF586gPuiZm5wAESAgXGGAzeJEwUx8wWnJkXl8ScghKrpqUcm?=
 =?us-ascii?Q?fWFqBsX+FTlTNxFYFC4/tPvHmC++qLU4M0DEYMXWxtU7vBywp7suAVvWG/ve?=
 =?us-ascii?Q?U60b5q/8TG3fM6IJ4xVxqYw1dxyT3Z12WJZpDp22ZbCWILhBf/kk/NX2ZdMG?=
 =?us-ascii?Q?0MGfyk/7D2k2H0JFBjCOeAIS1iqnhiGFh1b6DXVOV8Qdxzng0+xdpmWrP/8U?=
 =?us-ascii?Q?8lX+DeO4Uxkp/a5KC5WzeeZcGfcdl+16dnm5yoAJzqAhbUr1unFOwMsdEcyF?=
 =?us-ascii?Q?NUE0oeQIH7+k8xvIkjgL3QokwX0h5UBwSEtkgdJfRBjEKmrWZl0uoJ7xIHpO?=
 =?us-ascii?Q?F0X1IJl/l5NGZXP4+eE+uChs0IStgupmpuarcZ1lj9AHrz8hdyg5UiNYb99g?=
 =?us-ascii?Q?dEW0rPPJec5vxlZD4/amgLb0RzpOt4tHp96OAmqJ19f4RP0toAu181qgBSMC?=
 =?us-ascii?Q?WNvAPYmFMzDfykHjHaLLNfg6Pkiyl+PCHLJRSQ4NTiO8x4gwNi3jkoXCacDw?=
 =?us-ascii?Q?wWFyyCy2jAQqkkhPfLqvR8p9Jq6UIp9wZgyCzaIj0CM+JIkrYdCjeEojhRis?=
 =?us-ascii?Q?YUhul9N9Lm3CxsbY7YZ+nUryLTJXvodUOAJSboic9HFAufQcjZaRCnEesb0N?=
 =?us-ascii?Q?L8mDGprGunJ2+RP4d5lcFq4Ohvro8tr+gxKxvjtY5uwhkFwnzVr5RvfK95wS?=
 =?us-ascii?Q?eA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zWi1E2pvnDJfshY2pr/5iPwFce8QzRygJwiQTsdFLs4P1hSNAa10OMxqPxGfRaEwa9qerrTKw6GyNvLcj+EA/t/afPBIPsB0/RwHLqSTIefYNPpds66pUADYUYSOpp76GGhOjruKVDifuLMc+llM8kzfGIV9yjV6gntqe0ukKSsYKKUAlsJv+Un0CLX2+1fTdI6eLsH4S3keFJIeJ1ZpzpqtU+GApqHdvGIGfepx/+OuyqyqlUGjV1zZ1FYLeGZJn4WL/yJ+Qhpkz3bNkjDUuKnHs6+tDMM9225vjxX1XyhLq1SpizCVUakw7Eib5kXsdwROBNKjP4opraeKjXAqHl5Q5nRM/PCl5Lu2dlzYXB/lv0DCxnrI8PV5trHUcw0niGStYqXLKlfx4d2qR7F9p4IdmnuBxaH6XcTD1+DmMCnjQagaFilgAocE9pcURkMK69bhirb8AGd721MQXG6W5Qn7Q/oPbugq02k1adyJuwa0YRmXyrhUMHWecAZNWADx/sR09+QZg+nJENLm3qMO1GfjB9oHq2/asIFkP+iy1uNL9xqr2YXDQk8TllyOCVjmPDHQICZYqYm4NSOysHW9IIfQZaWhwwueE4XS2R/hP/o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63dbf6cc-5d09-4bc7-7c6a-08de1699a93f
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 03:17:16.2468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5N2hlQeZC2Wp1phQBLZARYxIE04ac9F7eIAM2uTY0fjpYCQEtNYGPqc6+LOrwmSviXb4ze6TPTCJKI0Jlf3greMwwCkcY8zOLH0sTqLfRg8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7174
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-29_01,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 mlxscore=0 adultscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510290024
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI4MDE2MiBTYWx0ZWRfXyCf2ZRU48JQJ
 bITZiaBeGIom9PrNZY9/mvTn8dRvOATmR+f7T8L6WjhSN/hVKuYufJt5WcIntSPJkBndaRXd0Oj
 kW2s2x1BbgE+ina4Kow5CskLmXHD1mt0PQ20zyMu2eqWFRz8NAuuIaS4AOj60bDU/l/S1x96WYK
 WWAqUShU+msBiBHq/Ke45XTUJz1EZ4HppctP6aOdvxnQAE/htHyGPbZxU1MiVcObWe3yr34UVxU
 dvv6o75kehJgyqd4/Perm2Gc4QgN7Nmq1KSj1etDon5O7dQhuv+CGyaknC38DpUBH10iiUQgK/q
 4A2rJuIby4mhCgcDxtvt0lHTW7B7iX+ulNkJnZAzOrkd9zsL6f+Hu9UKRgy1BjoIhZG1I4enMDa
 iOw4o7kBIKE8XzAA3NL7baWAdZWZYg==
X-Authority-Analysis: v=2.4 cv=M/9A6iws c=1 sm=1 tr=0 ts=69018740 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=QyXUC8HyAAAA:8
 a=KjHn2qu_H1SnvT49jisA:9
X-Proofpoint-ORIG-GUID: eAXMfhab9tXvuWWiIBc0IJ-Plboa9Sjp
X-Proofpoint-GUID: eAXMfhab9tXvuWWiIBc0IJ-Plboa9Sjp


Arnd Bergmann <arnd@arndb.de> writes:

> On Tue, Oct 28, 2025, at 06:31, Ankur Arora wrote:
>
>> + */
>> +#ifndef smp_cond_load_relaxed_timeout
>> +#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
>> +({									\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
>> +									\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_poll_relax(__PTR, VAL);				\
>> +		if (++__n < __spin)					\
>> +			continue;					\
>> +		if (time_check_expr) {					\
>> +			VAL = READ_ONCE(*__PTR);			\
>> +			break;						\
>> +		}							\
>> +		__n = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +#endif
>
> I'm trying to think of ideas for how this would done on arm64
> with FEAT_FWXT in a way that doesn't hurt other architectures.
>
> The best idea I've come up with is to change that inner loop
> to combine the cpu_poll_relax() with the timecheck and then
> define the 'time_check_expr' so it has to return an approximate
> (ceiling) number of nanoseconds of remaining time or zero if
> expired.

Agree that it's a pretty good idea :). I came up with something pretty
similar. Though that had taken a bunch of iterations.

> The FEAT_WFXT version would then look something like
>
> static inline void __cmpwait_u64_timeout(volatile u64 *ptr, unsigned long val, __u64 ns)
> {
>    unsigned long tmp;
>    asm volatile ("sev; wfe; ldxr; eor; cbnz; wfet; 1:"
>         : "=&r" (tmp), "+Q" (*ptr)
>         : "r" (val), "r" (ns));
> }
> #define cpu_poll_relax_timeout_wfet(__PTR, VAL, TIMECHECK) \
> ({                                                    \
>        u64 __t = TIMECHECK;
>        if (__t)
>             __cmpwait_u64_timeout(__PTR, VAL, __t);
> })
>
> while the 'wfe' version would continue to do the timecheck after the
> wait.

I think this is a good way to do it if we need the precision
at some point in the future.

> I have two lesser concerns with the generic definition here:
>
> - having both a timeout and a spin counter in the same loop
>   feels redundant and error-prone, as the behavior in practice
>   would likely depend a lot on the platform. What is the reason
>   for keeping the counter if we already have a fixed timeout
>   condition?

The main reason was that the time check is expensive in power terms.
Which is fine for platforms with a WFE like primitive but others
want to do the time check only infrequently. That's why poll_idle()
introduced a rate limit on polling (which the generic definition
reused here.)

    commit 4dc2375c1a4e88ed2701f6961e0e4f9a7696ad3c
    Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Date:   Tue Mar 27 23:58:45 2018 +0200

    cpuidle: poll_state: Avoid invoking local_clock() too often

    Rik reports that he sees an increase in CPU use in one benchmark
    due to commit 612f1a22f067 "cpuidle: poll_state: Add time limit to
    poll_idle()" that caused poll_idle() to call local_clock() in every
    iteration of the loop.  Utilization increase generally means more
    non-idle time with respect to total CPU time (on the average) which
    implies reduced CPU frequency.

    Doug reports that limiting the rate of local_clock() invocations
    in there causes much less power to be drawn during a CPU-intensive
    parallel workload (with idle states 1 and 2 disabled to enforce more
    state 0 residency).

    These two reports together suggest that executing local_clock() on
    multiple CPUs in parallel at a high rate may cause chips to get hot
    and trigger thermal/power limits on them to kick in, so reduce the
    rate of local_clock() invocations in poll_idle() to avoid that issue.

> - I generally dislike the type-agnostic macros like this one,
>   it adds a lot of extra complexity here that I feel can be
>   completely avoided if we make explicitly 32-bit and 64-bit
>   wide versions of these macros. We probably won't be able
>   to resolve this as part of your series, but ideally I'd like
>   have explicitly-typed versions of cmpxchg(), smp_load_acquire()
>   and all the related ones, the same way we do for atomic_*()
>   and atomic64_*().

Ah. And the caller uses say smp_load_acquire_long() or whatever, and
that resolves to whatever makes sense for the arch.

The __unqual_scalar_typeof() does look pretty ugly when looking at the
preprocesed version but other than that smp_cond_load() etc look
pretty straight forward. Just for my curiousity could you elaborate on
the complexity?

--
ankur

