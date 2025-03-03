Return-Path: <linux-arch+bounces-10511-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 497CFA4CD7D
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCAA43ACEF2
	for <lists+linux-arch@lfdr.de>; Mon,  3 Mar 2025 21:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071C21F03C9;
	Mon,  3 Mar 2025 21:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jFyaJJqH";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="B4L1CxrE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276051EEA36;
	Mon,  3 Mar 2025 21:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741037317; cv=fail; b=d+cL3OhibqhEGkNmjye41UeheAxyO6jQa1JeeVLbSf/9sk8ZPP0yxcQ6EweHzVi67gY3U0Sq0z20JehQ81ambBfdyfth734Paa8g2/qlTKNxFYgsQxsBcpfWenvb0Ra8xvVeYG2/NHXjV2AYxkpel2M5s96fo0Vg9K37yoxlgYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741037317; c=relaxed/simple;
	bh=4o+QnvKxK58OIB/19bjgSK6mwYEJDqhMsR144nQqr9Y=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=IQ+yVy5rcEkTze5G6xCm6qTFmKFta/wBoOSVfxWKJC7ClMAFsVurwQgZvNT+DaS55+hOoMmpyJjO9xGs8UsCQB6p9gqRd8zPa6xfJb+ICAjCvpQncoeZzDyrouqMG7j5V8LxPyDP4b1Nk2L+ftELuaJYwutSteUF59Z2IFcpRLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jFyaJJqH; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=B4L1CxrE; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 523JfhcM004793;
	Mon, 3 Mar 2025 21:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mmRmQOAPvgpFfiw2PH
	HK1kih7jn8aK6dMWC4oD2DZwE=; b=jFyaJJqHrvZZlyKo+4YRt476WhSZK8WCmi
	8jEZwFyeOX826VHojqluX00yiIXR33dNuhy7d6se5ateD4YitISqa/g/o1xdEvBm
	XY+UuBR+fzpk/eE4vrH9M8C43oEPZ0lAUwX3vO8xa27EQHbEt5Mxv3rES4uhtQkP
	TIDGNVappkmYGX19d/PRckt+EnAbkwZzImkQEXGyCufVjAMYqVttTqEnO7z+Cvyf
	UK9l2BtPS+6yYGB1Op8ZQHmL0R4zNfl5IoithrRnA8T+H8/56sUsp64RibyCPsfm
	oKUGnvHWfjAfBY94z2e5x9rM6JE3JxCFggaQ/5HOoTJf6VTGTXuQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u86knev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:28:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523LHciR039146;
	Mon, 3 Mar 2025 21:28:10 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp8swpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 21:28:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOw7dvhZLaefbOqNgtOPq17ThEENzc9XJY6z/oHPAGhKhmzOlaZ4NiwgKYcWiDCV49yOC0cu/G9xLF1BCKmtNrFdnzOrzDDjaN6tDstkdG+FozvdqKYkn0y3YUrK9wPIL5YoMi3/8lKdR5lnsfUA2nmeSB7kGKLyycDiQhdZdzTLAzCriHTN2vg4qFJe5s61an3mU3I1jkQ1pQwmmKZRdQUxmOBC1zT6aB9JD3XULhTehWv9x3dbBx5wpc4RxQd29NDhrYgOXw1o8sT4NcurpVr08y9qwoPJejBj31qKWTv/HWl2vINmKepuinbdLhCj2I59eaCyoSS/FHPB5bg99Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmRmQOAPvgpFfiw2PHHK1kih7jn8aK6dMWC4oD2DZwE=;
 b=wzf3JRv5PdqUKqqD94d64EI+se3JLLeBe+nDz+iK0SCdSI/G5y2D1UFJVpMefLpz6qcvKAc+eJjWev2Gtungh+vD9PI0zuTSIz9VV0IJvi7oXS0ZORe8j5pOlceE1Voja5tLLnnT8pBR8NHwfG9tDrWvDH2FWvoa7GsfZURSgT9VL0Xhke4mMjZJtFgQhaYI8T2IRI7pmlW3vLpX/rzzQgLzHflJy3V3Bf+B7tMKr2TW/KBCF/Judr9qeTr+Gjy+qmmh4o4ToFosKLMQrzqfphTdNU7YA+nBPMweSpuLSoxT0ka7nWSipvyRy1mf7gt4zjZ78LpI0ecbRs81TRMCoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmRmQOAPvgpFfiw2PHHK1kih7jn8aK6dMWC4oD2DZwE=;
 b=B4L1CxrE2mktMeFE48Ba6MGxisQcX+JtxjrBfsJ5CaIod3DYMMWTfM3evr1sflkpihIPpqI1CynruMiMwQ/De802yiUwmqK0/RfQEGT6tbW5NsXAFftvk0jMz0ktRHEzeKPab0zwlL3lf1RyGPmR+oZxRVZWgILrb4IVv7tjTWE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by IA1PR10MB6900.namprd10.prod.outlook.com (2603:10b6:208:420::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 21:28:07 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.028; Mon, 3 Mar 2025
 21:28:07 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Ankur Arora <ankur.a.arora@oracle.com>
Cc: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, arnd@arndb.de,
        catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 0/4] barrier: Introduce smp_cond_load_*_timeout()
In-reply-to: <20250203214911.898276-1-ankur.a.arora@oracle.com>
Date: Mon, 03 Mar 2025 13:28:06 -0800
Message-ID: <877c55249l.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4P222CA0018.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::23) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|IA1PR10MB6900:EE_
X-MS-Office365-Filtering-Correlation-Id: ced481e2-0e8d-4886-0a40-08dd5a9a4a4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XIaDIjF3u5QznSw9tuph+BZN+sH1NYOBQ2/e/CTkcxle20NMHIXcH+a6YTJQ?=
 =?us-ascii?Q?i59kVCcizyC/YYIcmzSIkyYHJCMWk1MlO9/sZPZOw2pEUwNUBYGXDlhIBRoO?=
 =?us-ascii?Q?DSA6q6aEiie/zgzqorcN8BYE+4Zs/irah0cbNp10oeugbcV1/0JUOWO+42xt?=
 =?us-ascii?Q?CqW8Rzn9MI3Da3o3jFAV1RDLhYyexKlGFGr4Z+2pvlutE+CMPURGLSr6Kmj/?=
 =?us-ascii?Q?NqczIaiksNK8pKbdakmfRQJjqCIYiW0Hta6dea3I4hrBN7NbXJ4WJf8YpWt8?=
 =?us-ascii?Q?i7ugWKCS1MPmt4vrT55fbW6byUynqTW0kKfOKTbp6oKdm2YMxOG1n7tuol7i?=
 =?us-ascii?Q?wEA5w/kpPT+gCkJ9pCkdgL5/85k/mOtZ/9Xl5ATdDWeK1j/GFTk/oIBj+K5+?=
 =?us-ascii?Q?lpsvpqhPGYAjgW0IzKyfmevjyd3umC+E/8nZLsasCz39HD0QJkVdOKPwWOdK?=
 =?us-ascii?Q?D/mUMglWycPsOKUQoleQB0mCKAESmfsgRO7faMngo3TcbFcxizk6lIZ8EUpE?=
 =?us-ascii?Q?mK40gTSVK6C49ul9yrKkFn6SNO7cPnpEd0PqEKgEzqYKGUv4CVyxv9h4nRjh?=
 =?us-ascii?Q?/tBOqyvDfK3DQKcnPA11A68reDZFchAmafcV76BZjlbdzxK96hPOShu7ZBNj?=
 =?us-ascii?Q?yxl3/q89WxQyKA+iNRUrrUIcstCoRrniT8dj5t5CU6a/hS9qEMFiCoo8WC6Z?=
 =?us-ascii?Q?U3396qlY24/hH2Jx45yk5rREruW5cfkbkU6sPfpRIGg0MdKBTQuBU9xR976Y?=
 =?us-ascii?Q?QvgyyfuIajghsQuAg1z7Ozjfxic5JuoXn44eUAPZyQ753FRF7vc7w7slHDr2?=
 =?us-ascii?Q?nGt71C9W2IhkgZrGzhVJ6F4fY69YQvy6VdfH5NYihu8huzV2DHyFm9bnsHhs?=
 =?us-ascii?Q?cC8IR4eDv2xT8izmByZHB+FMsUJtXOaU/R/rnY8XqJ5Yw6YnaX22PSULNw0A?=
 =?us-ascii?Q?MAZoFg5u7fiGEopK5OO4ScWMDesAEmoyIGV+rk9i+7PjNSKtZryQmrIM9UPz?=
 =?us-ascii?Q?Y6Uz9u3LLx8+OdUkAr3jrFzbxsPkVGTFXm3bD14DtWQrLe5DCJKkj1p+lL6R?=
 =?us-ascii?Q?9+ZEoUqsMccPJdqIs7HDQIhoibWQpjhjese21YIEIL8ldC80F3Oh5li1E+VO?=
 =?us-ascii?Q?iAr3d5h6Tk6xNbS/HQhnJysj6vCawcK0WawA2oAXy5E1CEleSfE0nKxiOd3f?=
 =?us-ascii?Q?r/ljud1X0qJbk3RjTbUbxVuIWZG8Oms/5jxGeDwIS65msVV8TRZD3mOfK8rr?=
 =?us-ascii?Q?uY4mwuuTPbayWVhHCVxwXm+LZflng1pWBOLyHnBmz57hMsJ+faz6ADAZABxu?=
 =?us-ascii?Q?q2JSr5LqQOK89t7sNxMCZvOAbLMCHxFjm59wKktzlIBFXIqpOlAAcov5QnTl?=
 =?us-ascii?Q?ycPX7q805JSMHJudfgsTGDJf+MvtNPPH+3U6Yhr/tqw2I2S7cg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eAK9u2XVZd7PykNslYKkX//KN+D5/y40H+cNCcTkJ54u0jQ4U3RDhkFuO2+c?=
 =?us-ascii?Q?lkETkyJvPFNFmf2ZbauTQ4oNOYuq4NsHxOB+wqL8zSP7OU8kYmvGquUDTJSV?=
 =?us-ascii?Q?ky76udgGslNFo5GWod01QTRvjjLsdV0L2PsTLiKqvSlTPPdBRnvRbgTYnZ+v?=
 =?us-ascii?Q?X9yqtgiDYtXjrc25y3ptFgoBoV2nNB2XaJONqEtpO+y8SeMngrZrhJcwwYnU?=
 =?us-ascii?Q?wJ+OgDTL82+WLJcJgvM585aO8PFtP55RS1U6yUuTPqytDF4w4t0aaJJefbj6?=
 =?us-ascii?Q?FwjoklEfuvNZZeJjgFogfUkA31qi5g+PUMXTm7gn9E362hgE8cS0BgPSwVEm?=
 =?us-ascii?Q?5wxzbHaK0Q3hih+ux/56W9dY1H0Ov5Q5J+auAbkpNtPZSOQsw+JFgSrJYuWI?=
 =?us-ascii?Q?q0qS5rdMXtxS7atmf6dfwjJNL3v2ydg4XRcRjlGzgaBrKuRKmckHGdoVDhi7?=
 =?us-ascii?Q?sJjYltWl1igSgB3g2oI3mRpi5ur017v4xZzqsdJUGuFcM0zrSGI/AKU+jaLc?=
 =?us-ascii?Q?N6e/h+CoYabKQysqICF59RCNT/SDlgXxvXW22QA9LuYyAUMqsEQQR2bgbE72?=
 =?us-ascii?Q?Vsh8elhDV8/9YeyFQFeCVBEPbPTfnz2xVugur3viOOh0KyIQ4F+3SscMjv2Q?=
 =?us-ascii?Q?7x80UfOSwhd6oEqHoUkb20Vacm+pz+40oCZdK9LmgHwkk8ZW3dNJHhbwx+uH?=
 =?us-ascii?Q?8rTLZcEAwDCArrD35BuVg5fqY9bDmQThLhvC9ehaN3iXU8psOYr6ycGLn8E6?=
 =?us-ascii?Q?9MQKjJ6/ipDm+umArkDeu6jWP/lITqGZPcnc/gNgAQUGHMaGMzmTUEGenQbV?=
 =?us-ascii?Q?mMoMERtBARu4I/8rwBxXaEN6X8OojGoWtQ4OD8adgpBMphc949yWBqcnGeb4?=
 =?us-ascii?Q?xwyI6ddCTl2CH4hlDhKrPd7+icIe3xdNOjqs9uEh+R7QPX+JhakJbFFL4/rM?=
 =?us-ascii?Q?n7rGowfm9ucDzrgW8Hxkz9Rj+w3Art44dXTZA9BI4hx07IVu1ivWBY05tPrG?=
 =?us-ascii?Q?Ml7BQ63XkjSFx7qRzyvhClgu+6aqCQW7hwidveADi1tBGDDfk5rPoJbTRW7y?=
 =?us-ascii?Q?swLh8T3y6e4PWwh0IkckEekN2mrjo8VY0KOPWkTSxn38qxj7c3pJfaeM8nQR?=
 =?us-ascii?Q?5N/yzxfdkCj+yjwd6GeQMMA11bNcVt8+4T+885VFONtrfgSoW8Cs21qWpuyK?=
 =?us-ascii?Q?FEN0JY2AtsChM5fE/T1DD5Axr3wI6lowruxoEXcVnHLcZZYWMuJs+mLQAkUw?=
 =?us-ascii?Q?RmBTnbgjkdeFRdxAm72E41k6YrZBDM8NkqVkYakPEebspAcl1Ihc+yQh6t4G?=
 =?us-ascii?Q?8Df6hEfROIqO0gZ8uzCrBY5/0JCDjdlrhkTRvMeaIaLznknGZlkU+i/dZFxZ?=
 =?us-ascii?Q?rY5iAigIBdPmMrhhwZAK4UfrE1Qqr2URgXeSwwciSsx6AUU1oItYskSlldDg?=
 =?us-ascii?Q?qJ7dpsVw0TtsFjk2BIcL9xIqTi8q34D0cJS9fQO9x6tCrtrMO9oMWMx0Covi?=
 =?us-ascii?Q?LbhM811RIMB1Rlwikj38bGz9BKXL/nS8LuFpGicA7NkQbTaorU9nMDOOaqTa?=
 =?us-ascii?Q?gzqfcpzwI1fM9M30wbNLi/Yqp0DH65ydIPqNh6Bs+cmZfkDjKgSWJR1dTEqz?=
 =?us-ascii?Q?/w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vV/7b6di2e9s2eeGv1c1kfCj7c5kPi9yLVErdsFKp/a17nTOVtfZCA+hAzM72ZWpPE2gB6acPX7RTHRPv1cMrmV67RSp7P1AWqU90O4njHg5kuRd/kyjjZGhlwQqnANGcY+ADPS/ch8L88MMyivY7GTYmDtB3JHN7GuPP9fgqbW18wK0wTh9C7y9OthV7I1wn6dNWvWbTMEPbOZiu6TRXSyNmaKGMRaMb9U1WKTLQIisVu4a+lC1flACzvgaBUmNuZg10oMVn1je9PRr4V11viMgBTNlAzdPethgpzsVt9PFnb0lV7NbFiLGPw5P4PKtHB67buyGUKiTyJabxNDNXXjThf5/rPzXIgDEi8L++tRbKkIJLfEKDQCaAdAZEuULRdbFyDS521XG0nnCM4dkH/cqcLOUgrEFVLZf/fHjlUyj+/6jS5Le1ccreDpC9UOuBbHlI5Dtxtx0g0ZzAJNpsJV9jixtGAbfXGsSXUlxaSjBjJsJ1Vwbb5xGlyWw6fVl6j07Vyyr6+aK+JFS2whAJbWhXfF/Cx/Evx6z1EIRjb0LK94In2aFvrO304VgzdnZKmuuGMkXEwyeP0jIUvQ9cw6INJxV5ZI8eKzlnvIQMI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ced481e2-0e8d-4886-0a40-08dd5a9a4a4d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 21:28:07.7421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8IhxxfZNYe0lpsIX/wECiUgrzZuzsrqIyVNIo4pvDdhbd0R0X/mAOe6p1Ptt75SfXW2eSN49YFtvhHvjAaafb9aoQwpEIU41uaQVStGgNo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_10,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=996 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030165
X-Proofpoint-ORIG-GUID: tPnMn2IIRAyqFSxWfQlo4JywvMAB6Bq4
X-Proofpoint-GUID: tPnMn2IIRAyqFSxWfQlo4JywvMAB6Bq4


Hi folks,

Gentle ping for reviews.

Next versions of users of this series:

Resilient Queued Spin Lock:
  https://lore.kernel.org/lkml/20250303152305.3195648-1-memxor@gmail.com/

poll_idle():
  https://lore.kernel.org/lkml/20250218213337.377987-1-ankur.a.arora@oracle.com/


Thanks
Ankur

Ankur Arora <ankur.a.arora@oracle.com> writes:

> Hi,
>
> This series adds waited variants of the smp_cond_load() primitives:
> smp_cond_load_relaxed_timewait(), and smp_cond_load_acquire_timewait().
>
> There are two known users for these interfaces:
>
>  - poll_idle() [1]
>  - resilient queued spinlocks [2]
>
> For both of these cases we want to wait on a condition but also want
> to terminate the wait at some point.
>
> Now, in theory, that can be worked around by making the time check a
> part of the conditional expression provided to smp_cond_load_*():
>
>    smp_cond_load_relaxed(&cvar, !VAL || time_check());
>
> That approach, however, runs into two problems:
>
>   - smp_cond_load_*() only allow waiting on a condition: this might
>     be okay when we are synchronously spin-waiting on the condition,
>     but not on architectures where are actually waiting for a store
>     to a cacheline.
>
>   - this semantic problem becomes a real problem on arm64 if the
>     event-stream is disabled. That means that there will be no
>     asynchronous event (the event-stream) that periodically wakes
>     the waiter, which might lead to an interminable wait if VAL is
>     never written to.
>
> This series extends the smp_cond_load_*() interfaces by adding two
> arguments: a time-check expression and its associated time limit.
> This is sufficient to allow for both a synchronously waited
> implementation (like the generic cpu_relax() based loop), or one
> where the CPU waits for a store to a cacheline with an out-of-band
> timer.
>
> Any comments appreciated!
>
>
> Ankur
>
> [1] https://lore.kernel.org/lkml/20241107190818.522639-3-ankur.a.arora@oracle.com/
> [2] https://lore.kernel.org/lkml/20250107140004.2732830-9-memxor@gmail.com/
>
> --
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> Cc: linux-arch@vger.kernel.org
>
> Ankur Arora (4):
>   asm-generic: barrier: Add smp_cond_load_relaxed_timewait()
>   asm-generic: barrier: Add smp_cond_load_acquire_timewait()
>   arm64: barrier: Add smp_cond_load_relaxed_timewait()
>   arm64: barrier: Add smp_cond_load_acquire_timewait()
>
>  arch/arm64/include/asm/barrier.h | 74 ++++++++++++++++++++++++++++++++
>  include/asm-generic/barrier.h    | 71 ++++++++++++++++++++++++++++++
>  2 files changed, 145 insertions(+)

