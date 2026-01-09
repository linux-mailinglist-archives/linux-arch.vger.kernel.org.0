Return-Path: <linux-arch+bounces-15731-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F585D0C004
	for <lists+linux-arch@lfdr.de>; Fri, 09 Jan 2026 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 244303011466
	for <lists+linux-arch@lfdr.de>; Fri,  9 Jan 2026 19:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A592DEA95;
	Fri,  9 Jan 2026 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XKfq0m2+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FkhTj/RL"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16010218845;
	Fri,  9 Jan 2026 19:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985547; cv=fail; b=ev1UXEGRlOkHFTyfPhZur5eThUQrQwgHQs+nSeVTqtVP8rBRU6jXLyaWm4qrgqNH0MY0wybha/dpyTJjsyDF2lFNrHDphHnhy+Rb941qbqdi9vp9y1BinAlKLGu+eVWgYMhNtLzfuRGZ+Tv6dI7SOhuyQfzCFXMoLBxuBriF/rE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985547; c=relaxed/simple;
	bh=w2SQysiOjKYPNNyAIoBkSKgUFgYrTgutFkDjjSsSFXA=;
	h=References:From:To:Cc:Subject:Message-ID:In-reply-to:Date:
	 Content-Type:MIME-Version; b=SzlKGfsvt2ALMJo/zQe4L4+UMbsqVpYB5qzlfQSJYptMlj9bjdHdOY1fpWv6d+WrO0wqVj+XQvqm4YVW0yk/phWqUVnQ9jBQ/qf8ZX8qheteVki4/OPJdbwbt0uh/58yCZbq8D8MSiE1vGqLFf+WfiWFuV6NtAQc3iR4iE4SJ/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XKfq0m2+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FkhTj/RL; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609HiurI4077980;
	Fri, 9 Jan 2026 19:05:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Xblc/y5fWvuRumeap8
	NBacd3Yu1Ws/OleACQgyHF1vk=; b=XKfq0m2+W/Hm/wYqyRuseEG8xW+bP5iLFM
	r7e8h0UR/p7PpGS6bGFdiZjc5HsBWD6fy+5WwLn4ynLauBOLt2q7QVnXLkSawLEQ
	QbJSPeI/YrtJaVUGjQdefCQu+SXnTM/Vvo6iFuQVMqYXv70pLu/PaGUFZDLiJ6IH
	ytFnj3fCPR8tA+hjHB0e2heL6q3dNcDxhvOCZn9lmIEalfTPCMI6CIWjwAqanrka
	jj3Art1feQZpz8WIAfBZ4j+zbIAusly5Rps0BWR6q2asQ4TsSXHlDG+D6ay4Tzbv
	2bTfevLX9/S7qd4NwZpyBeLEhd3F6W2OUe4dfhOM6/s9tgXoo3Jg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bk6ba83nm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 19:05:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 609HoXTC020392;
	Fri, 9 Jan 2026 19:05:11 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpr025-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 19:05:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mRiY3kCHuTMLTQMm3aaSHIC3BnZ+5KT2ZMaejKm+ffjmpxImHutVgejJ+Ka+OEwX528t/KKbwWh5mRp980jlciLfwt9Sw9A/n6hYnzfBcCFc5BsSUS1/M+uZsXhb/gI7ehav4AX4PkL7kPGGB7b7wf2uHMR6cNKPzK76ZIxwYu5yX3jyvI935yiLUOvYqm4ftYEud1t/CTtl+vYD/RLQcRuIcxxl6iFR3Y6ODbft5HwpFkUXw5qoJOW2fmjUgh+sFim62bkKFpptJ0dc9/P9WV5C2rPrHk3Ilh7QK7wzVi9SsE+jrnS9exUVDKsms/vhWdT6LO1nPObzoOddYQAKDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xblc/y5fWvuRumeap8NBacd3Yu1Ws/OleACQgyHF1vk=;
 b=yH9506wzFx/1l3c+2CWUVhuHS4+AscCk/xvMkuvh0GsAxkIXxjzHDdRvB0pb2rAnk8/h4hZUGchMawR9NoPAWKK3aCTRIZoMbFiZCJocqnnxoea1hxarEDA8PENG6iCMiPDkQIpZmYx3mMXS+S7ev675ezNllTQcE1xOl906Pg+qMMvyIak3HTXoNo+p1Q6jgPjUCNW5QAKg6TX0CzoWWyRvxzm5IVDNppa2mFTiM2UA0KOMcsq9zMlE/V0pADN4TzajUXwbGcWxGMu1cA98IaoxDknpcYWd6iBPlWuAQ6NkuXQMq8uF/kv7+603m7S2xsyYjwMrsMSUEWzANOYLFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xblc/y5fWvuRumeap8NBacd3Yu1Ws/OleACQgyHF1vk=;
 b=FkhTj/RLFYNWZCNpisiSaFvH7F/B4H5mqLReEcxRBqN1uWmaFys5lKNuS+0GTrgiOsq+xnWixjWAPcoGyIm1WCeWtP21LUJv0jwgYkVW80rDDlWgRECICc3ltk+z66zilUT3l1ToeyPeHrNiCscMc2bgwsXFu+RHQATkFP5KkM4=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by CH3PR10MB6904.namprd10.prod.outlook.com (2603:10b6:610:145::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.4; Fri, 9 Jan
 2026 19:05:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9499.003; Fri, 9 Jan 2026
 19:05:07 +0000
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
 <20251215044919.460086-5-ankur.a.arora@oracle.com>
 <aWEOALG07jHC_oHC@willie-the-truck>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Will Deacon <will@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, bpf@vger.kernel.org, arnd@arndb.de,
        catalin.marinas@arm.com, peterz@infradead.org,
        akpm@linux-foundation.org, mark.rutland@arm.com, harisokn@amazon.com,
        cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH v8 04/12] arm64: support WFET in smp_cond_relaxed_timeout()
Message-ID: <87wm1qmx90.fsf@oracle.com>
In-reply-to: <aWEOALG07jHC_oHC@willie-the-truck>
Date: Fri, 09 Jan 2026 11:05:06 -0800
Content-Type: text/plain
X-ClientProxiedBy: MW4P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|CH3PR10MB6904:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e937850-2963-494b-d64f-08de4fb200e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3oKAug0BEsp4pPWDuK9xijjVGFB/DH6GzvywOyslwzs5kDr9HGLLEDQvbbOo?=
 =?us-ascii?Q?r53jaPB7G24aIzKAzESoEfTw97fkXYkkVYAAmCsxjfx65pITJ2NlzqNbzITp?=
 =?us-ascii?Q?eZlwQSIoYFMGsiBdI9thwHQhKLUbTsqe5z0k6ZCFldkdqXzZlyLYl+pbiQY9?=
 =?us-ascii?Q?PIV1NXYmnXkXUYLM2S7e7/iX2yN7wqKuQ2hzgLcpcCH+fA0I0hFYsKapZR69?=
 =?us-ascii?Q?T/zVX817m8Jto7dQ5SuWok9gGAk5hOCEKCYURNaD8wkstCo9imMP4falKfPO?=
 =?us-ascii?Q?z3MgHZbwSTXFRpdb4a5DTfZYZmUTBSLUE6BaMkFsbtsC7crge2LqOj2CVSaE?=
 =?us-ascii?Q?Arw1nhu5ZigE6ch0Lp/m6QricYoLayh0mC9jZ+RGjxVCwi1K75s+sOXrN31a?=
 =?us-ascii?Q?vmLF0SMctMC7ZeKuBqObmyI4hBtbMcwns8M6CPYf0JevT0HWYJoC8BFtF02+?=
 =?us-ascii?Q?3z+vfDk95ZGNLamFinaF0PLezT7tvbXkUp6Wx4xblAHXXnFOvavlhA00XMkn?=
 =?us-ascii?Q?ceKvP+sX0UY41K13kxMXKWMe4EoJWcaiT2AWw6Js/9xjGkIeEP14B7V2RSgZ?=
 =?us-ascii?Q?xtxQ3KiY+5MmlcWh1s7PIqaxiN2JniqUr4QA2yrEzkOkoFbo6whvAYVcuytk?=
 =?us-ascii?Q?RFn7MSp8GhRe9uORwQ1tsII8oq+M/wA8N6VWvwl/Hsrq1tKOZIxlNOqLkTlP?=
 =?us-ascii?Q?Os7qsHAK8K5k0fgdcAVpDchZZ0QRcHYFuV9Pjr1UlBtolxQGKb4UT7v4NcgH?=
 =?us-ascii?Q?McSLKkah05YiFEeWeILUXO6gO1G64EeD9RXCfQeN9dogwxVPUqOSRrvx9yzD?=
 =?us-ascii?Q?L2Qf1WMA0Bde4KFNHeosQWqdIpfycvwPM9kjPjZtJSpKzGp05BIR/HdlYNNN?=
 =?us-ascii?Q?ZM3mcRMeEjgP8bGwez0BRta/K65I9/LpEMNbfwRpfwTw4/K7PCiWyhdxBMJv?=
 =?us-ascii?Q?og5o60eynml+zFLiaOfonV9koLYYHCHVhSUeJuU3LoDr+Dwbmh0zIUHOrIIm?=
 =?us-ascii?Q?BNh+A1CIdM7FT6Xrounebf11OcoacG83aMXoo6y8ysMr4KaYj1PTwim4tk9A?=
 =?us-ascii?Q?3irsQCFnVvnX+ZYtVc8NB/y2O80i6gY1vpQNrzJ6TRyw2fEkf2gr4G0Isvst?=
 =?us-ascii?Q?mKwFu6/y/CVkfY4usXZoXDca+o4T7yRyMYx4JQVrmNNWlDNK9aQDiYyg8uqo?=
 =?us-ascii?Q?o0LvqNAMyvcOdxCMU5edk0AZzDbGi0fCg4js3YlFwv5b9z2KK5fkkhOPLyTx?=
 =?us-ascii?Q?vwMh++JszPRHwOLLnPV5EDfUr8Yn26fDxwozWhExqtMDFHbNBWl0zRg0vY9t?=
 =?us-ascii?Q?EvZPbvI4u7BTY5t1ticZ5IpVGsEcEVYwqpD2ChTe8PpEzo0zyluTF4wX1Q7O?=
 =?us-ascii?Q?smfg4Udnaiv4EKzEtIlq8Q2Lzj1HjYJVgbW9YCntN1cPRtHaLXBn5ZCEUZud?=
 =?us-ascii?Q?koEPicxdy8qMsHFzj7m5hEXvLAEyxh+U?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mM85uttixM4OYHf/eJJV5Nj0ULujtFOV0PEToQ8SKJ9Mdz00AFe32yl72vX?=
 =?us-ascii?Q?b9TuIeTOjIu0LxkNNP+Buustn+Tw5zxZCc557r4o0ocT/QIBhUMHlNF9Qwf4?=
 =?us-ascii?Q?Gwdj6dQiwnhtnM1XwX9FCz6eVLZ0coYssKMs/SBlwtd/w8AyiOCqYoYhlsUi?=
 =?us-ascii?Q?bxGj53DiOCKJk7qHg96FjqUQPx6A9NRazOA78rvrTKXYRPRzkuC+anXQm/j9?=
 =?us-ascii?Q?m1tybDZ9v9g6Kyh4asc9AAnZc+ARl34v1roFyxU/NNheqSZQ8TWAtQMsE0aS?=
 =?us-ascii?Q?HoFt+P7JWwjEM/5mxPnCL2HvuREbFVtK4gcbuU7CWt3pZLI8SuFK6+RWGc9X?=
 =?us-ascii?Q?LIlPv6sWWzgfQiRwEIPKclXivJQtzxUL2oYpEJ8ldlVDgAeSE/Kt7mKnw6sm?=
 =?us-ascii?Q?SZamwOe/06mY8n8l2dkCekHl5KIsFnzJkNQsWajzjVdv05BRrmMu73rBKuyV?=
 =?us-ascii?Q?ztPNSQfg0071iQ2aOySEzWXPxg50hu0HIWQxPaurX8AqdZFDajYtJKEglWPh?=
 =?us-ascii?Q?a91sYtduqwyO3477/zBIEDRgNwgV6usOhdrlXpu4hKCucs8i7bLw0vW4dezo?=
 =?us-ascii?Q?+wHiyafSHAJyLzTKlk92kfBw179tumi8cd3pFnYPb5FbTcZXQXgRKdgvm7xc?=
 =?us-ascii?Q?KHtibjdFBv5bD4vzedG8vJG0ng2eTRORGGA8Pa9YNrWYDG3y0iMtw+D7j3Mo?=
 =?us-ascii?Q?/pa9DuO9HYy0nsMwWwva1adJDMmSUlpEExfvQ7k1FjAxgEgmhUT2WfstVdai?=
 =?us-ascii?Q?uLLGxelXj3NSaFtSyd2G3V5Ef9cagDxHftFQ99LiOhYez5M5t/HFly0rNHXk?=
 =?us-ascii?Q?BMhUCL5qoW4Dfs25Oc81if1qhZ+GDI5WnudV/fbcfcFUyyiixgEe1nm27o3r?=
 =?us-ascii?Q?dXC54qMAM8ZxrUhVGAyiE2SUM/XBlfb9pV034E44I2z1RoU01+Thu0Br3CIk?=
 =?us-ascii?Q?1akEFzkdaODRNXmjGBAncAQKPM2Y/GRRhj/xXHE++dra/04bI7/JDXLLlJc5?=
 =?us-ascii?Q?A3j5jVDrw2DZcv5VT/f3HDNC7cgM7BdSPTAwcAeTqZIHVQ1qa6PbXu6g12U6?=
 =?us-ascii?Q?SOHjXEp7JP5If7lDhtH0MMiZ6JRw9WUFsQSnFk7TBCp0tKNVqsgOb/RxBp1Y?=
 =?us-ascii?Q?UBvQ98gjac99wfzZrE2ndUdUiVX6zLxEHl09X1NqpjBcDu7hBA672ff8gr8x?=
 =?us-ascii?Q?1WY4gHQu9ycRdSTHjUz/K9whR9Lm8wNuhU/O/dXp7T4TE+gX3Nf2ryPaTAbg?=
 =?us-ascii?Q?ee5Wx8TVC0czMdme6utdLaM4S9AMI1b0I0bM7mKOt7ZrxSa5A+paV4uMsBKE?=
 =?us-ascii?Q?YmsuSlmmclK8kQo68qhEa+6tfWPROv3ImMjCnVQp5earYd5cZYs0U+ztliBz?=
 =?us-ascii?Q?ljPukW0pnQ0/5s3dMs79VgxUV/6XRnVXatHJ/O2m3ARmVaNOCJh2XASBbmg4?=
 =?us-ascii?Q?NS9D6IxbFbkZXj2KwQC1RN3s+/Hy8+Clor44RAcvlTMiwL6fAv+nS4s2zz/e?=
 =?us-ascii?Q?vNBNL0oT5HHjshKkOJe27icfNCRHqZcJ7/qGbENgOMNgdy4FrArTSCD0Z1xT?=
 =?us-ascii?Q?thTfvLgIXmFT3xcojYGDiNA1FXydVS/Znd1nQ7bXj38CWAu8Y1FRNyKeP/K8?=
 =?us-ascii?Q?+3+si07zQd89aPFNn4kKdO47pYwyGN8X+m9XOi5N2hukMJ6X16BZ98mJL/wk?=
 =?us-ascii?Q?A4BHuaaK8HlccBOXSNKNDPhCJIwiDyVNo6f7F7tYov7KC42159JEFH5xE9Pd?=
 =?us-ascii?Q?VZzxOS9+pWW3WML7yBoIhgLus4nnd04=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SyW5ED/b6lmCUshMBj48Ehu2q75soyRbSUJ5h30Bvst+6xJM9lNNypeorGNbLAJsWN+XvzqgGySDA9WJroZL4eCgchBF5gXyiPHVI0IqusHS8Zyftskr0vJUtnTCi3LZlw03O44uychXyXSam0Zy97i31af+3AVZnk+j+lpLVjmIif7cy7VCbNLDPIypdnxIXmzpkc3QE/X695z/fenJ45xxxn+qkoSy337WWeMTi6m97hKArKkPmRMSpshHHhplFo42OVkJAdW67maQl+5Qc2ovXgqBFf1hRVb5+BiWx4eWQ2bhGFzcuzGTW0Gvjft9phgGUIvYo85ew71CcklXP+sDqmXvNmkzGwliqxUHU9JLgKFpI3+s5eG8wp+3LEMsRRRkktsS2MLLdpFl3yoC6lpR98EwWagugrIpK5pXZ54O/KGU1ct2N4sNpUoodPL+ui2aT8nO2mM7lorBRNdUGViqtYkNx+O7H2R6dS/nf8gxkC4L1OkuM0+2ikI62rk2Kw433ji7mrtoxlSRrjQDa5UQsuACbUDovYnaQBhh2WLgU3949eDZpmL258JQC/63Io5plWAX838L3gPpx/40suTw83CByw7Ap4ONAYWyeUI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e937850-2963-494b-d64f-08de4fb200e0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 19:05:07.1899
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OLbVjyd7p60EZZ5esKQBU7ZgSY9yWPEO6xAZ3H5ryk0Bz3hsyCmRniKkYrF/JKWDLfzvZBIh/y6yLwIyyLyEcspGdo6MnrrCOV4g3ybv14A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6904
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_05,2026-01-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=953 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601090148
X-Authority-Analysis: v=2.4 cv=XPE9iAhE c=1 sm=1 tr=0 ts=69615167 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=yPCof4ZbAAAA:8 a=z388TXXlWfd64qZiGGYA:9
 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=1CNFftbPRP8L7MoqJWF3:22 cc=ntf awl=host:12109
X-Proofpoint-GUID: 9pzV36wKPEBY8kAl_pT8x1JZ8QYlxDZA
X-Proofpoint-ORIG-GUID: 9pzV36wKPEBY8kAl_pT8x1JZ8QYlxDZA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDE0NyBTYWx0ZWRfX53acPTU5AXkb
 mn64rFhB22iBDwog+jmadgnQ61wElQgS2FNkzttbMdN6VcF1Bi4arerwYXXYjuuMl3argvcXmEw
 zuSJssjIH6/qpjpfrXGOK87imV5ChkRuX7AJ25uyFAbBZlcCNtv4S/QOPHwtiODagTDbm3fJ3gC
 Hkjlszz1wn88PsVNyxNvnFZ7vhDnWfVixjTnCKC4OnI6dT6zkp4Fah+MvCnm4JnJn0NeWfjFy8N
 jdovWcMoGgCaqn8tUHluTMCfFgBNAVk8htRIU6KXY1n8BUO8H7u4TNLk4BOywWl/cub0qqahc/5
 rtFrRnJUFoCBJoiqJ0oQhUpyjmyuol3CYvlQ+J97ir6IinCsvhSNjv5Q7LY1k2ke4u+wKImwnE4
 rAwFUoatxZYOqImNC2ZGymEE3l3Zt+6vlgW7bJgbbdRrkHBmfllliKOtLjx1Ya8A/HDtYebGi4F
 rV5cXHaBExQm2CyxKBiqL+A8EdRAJ53PBrQu9I5M=


Will Deacon <will@kernel.org> writes:

> On Sun, Dec 14, 2025 at 08:49:11PM -0800, Ankur Arora wrote:
>> Extend __cmpwait_relaxed() to __cmpwait_relaxed_timeout() which takes
>> an additional timeout value in ns.
>>
>> Lacking WFET, or with zero or negative value of timeout we fallback
>> to WFE.
>>
>> Cc: Arnd Bergmann <arnd@arndb.de>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: linux-arm-kernel@lists.infradead.org
>> Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
>> ---
>>  arch/arm64/include/asm/barrier.h |  8 ++--
>>  arch/arm64/include/asm/cmpxchg.h | 72 ++++++++++++++++++++++----------
>>  2 files changed, 55 insertions(+), 25 deletions(-)
>
> Sorry, just spotted something else on this...
>
>> diff --git a/arch/arm64/include/asm/barrier.h b/arch/arm64/include/asm/barrier.h
>> index 6190e178db51..fbd71cd4ef4e 100644
>> --- a/arch/arm64/include/asm/barrier.h
>> +++ b/arch/arm64/include/asm/barrier.h
>> @@ -224,8 +224,8 @@ do {									\
>>  extern bool arch_timer_evtstrm_available(void);
>>
>>  /*
>> - * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()
>> - * for the ptr value to change.
>> + * In the common case, cpu_poll_relax() sits waiting in __cmpwait_relaxed()/
>> + * __cmpwait_relaxed_timeout() for the ptr value to change.
>>   *
>>   * Since this period is reasonably long, choose SMP_TIMEOUT_POLL_COUNT
>>   * to be 1, so smp_cond_load_{relaxed,acquire}_timeout() does a
>> @@ -234,7 +234,9 @@ extern bool arch_timer_evtstrm_available(void);
>>  #define SMP_TIMEOUT_POLL_COUNT	1
>>
>>  #define cpu_poll_relax(ptr, val, timeout_ns) do {			\
>> -	if (arch_timer_evtstrm_available())				\
>> +	if (alternative_has_cap_unlikely(ARM64_HAS_WFXT))		\
>> +		__cmpwait_relaxed_timeout(ptr, val, timeout_ns);	\
>> +	else if (arch_timer_evtstrm_available())			\
>>  		__cmpwait_relaxed(ptr, val);				\
>
> Don't you want to make sure that we have the event stream available for
> __cmpwait_relaxed_timeout() too? Otherwise, a large timeout is going to
> cause problems.

Would that help though? If called from smp_cond_load_relaxed_timeout()
then we would wake up and just call __cmpwait_relaxed_timeout() again.

Or did you mean other future users of __cmpwait_relaxed_timeout()?

Also I remember the event stream coming up earlier and there the intent
was to disable it if WFET was available: https://lore.kernel.org/lkml/aJ3d2uoKtDop_gQO@arm.com/.

--
ankur

