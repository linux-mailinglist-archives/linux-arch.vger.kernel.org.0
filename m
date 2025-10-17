Return-Path: <linux-arch+bounces-14180-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D91BE69E6
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 39F4A35A954
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D591230F921;
	Fri, 17 Oct 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oQjm+NTP";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YjeJSO6s"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7F730C37E;
	Fri, 17 Oct 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681800; cv=fail; b=b8V62iMyjZrVo2LIvUkwfTdFWOArne18bM1LjcU3Cs7R5F2UbGVbUKprOKttqPrs22/mWw1sldGW0x7GLBlryHGuLjHdd49Zhtjtse/kjh0sBT42T/Nvwk0WEC2wJfAHTUB64CNAB80Wo9BxCpB5QGvebi5Q2rCraRMy9PYugdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681800; c=relaxed/simple;
	bh=j2Xw/i9vkTOLP3GnCkIuGxui5rJdDWwAR/E6zMDTBl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=g7V0as98W4B+Oi2tyAShjRqyRbIWUlwEwusIAVvUrevZf3QSM/gsir3P2REzzFHn4+thUfyDYCZNYc8pNQzWKnE+nineUAqwrHeXaT8bgQ+5nbbLt4/1YNpRNiJslo7+yTgFpugC5IinddCRtCR0qCj4FcN9ffczrRNX71N5CcE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oQjm+NTP; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YjeJSO6s; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLuGaZ019991;
	Fri, 17 Oct 2025 06:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=; b=
	oQjm+NTP7gM8nXsbUYxl2AqbKUTP/NkVi0BnH8DJSjjZekHeIYhZkQRcZYuIRRD5
	O+3OSe9q14hngnpzuPwk1i+oigtwOTcUU9v7/x0IHYEpU0PD5xHDeY/yDCswcZ+/
	XFT+aQv09BaA9lYyPj+OcnISOIYLYm72W/BYCtYQs3JCwGLoMVLe2ylv22zsOcMq
	erbq5GlKqIDsZ2XkyZOUde72cYN124MtcZWUSx7oRfFMBXcoT5hlNlhQvDfJ8GS/
	FbmqKyv61VxoOpKPPSNa/0I7rL1yoLXJQZRtJkbBF3orBXrFzIl00sbKXDypDnlD
	n1ZYQ2zB2OE9HwlIg8kTSA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qeut288q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H3rVPR000914;
	Fri, 17 Oct 2025 06:16:13 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcnsqt-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZJ623jCE757oV/GAA3Z0DTzXBgEAksVXfXYuhLAsT/FOc3QSjxhrYT2ZBEpYqhqGw6e33JiTZbSDSFpqq3wvP244YF5Gjv3N5h6jmhOx8kMrjGrciFEtsyExSCC+ax/oECoC6DymPikGsjO6R0Fi3uthahydtmWg+FPxMziFGPCZiV6pLSxM664r5rUX1mt9UHZP7lMpk4lIvjl3RG5Snlb0CrBMJebx4KshRcrZGOrCrt7jITEFaskb73ap6yzLqrRYyPKd59351MHFpeAfYzg33KVTyUSpERbl0ovaKlejPi0d3yvWhoQsk69St/tnyw1a14SIuOAvHZwTcVy7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=Ra2hyNrGDDL45D+Uef8pt4wmkM2SMdAI9KYZ1LCPK9OYwZhM3FkIwG+Q762Tk4qMvOmlVoGFlIA+Arv7xuZDujr2y1gdTxmAAvdinV+tD9mWR8jEKAsgivcri4HtbKya7+6czYLMrU+5Sfwkwro9WvkwFCWpir4Sc5P0nQxbh6Fl6CRw8Af7q0FbsCflzeIawzmlOOQoBlu+YDFWB98clbMNkSTblg+bbCVRo7elHvgvU6k/rNKWxoearMXIxnV/Add9N4RQdzBm9sfRBPYYZ30nzsOH1f/82NrZ2Ax4AOAeDI+k/qAKKAcCA8ggSr1h5QuAmZEgTSeprSuINbDbPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r16tOsyj6BTMr4au4rkdgukeuxLiw7RoiysechXGIkE=;
 b=YjeJSO6sjOLc/pAPQRCRsqdArI/P9uDh7U8263piJjtNwRRj7FvzhZYY6mFvqtsxRHIKAOjaZBLPwisWiRk7nAdOzIppA6NVb31yx1iBDoRnJDq/Zs4VvYy4L2lNrfREOiW2OcOumn6IiYi6nOEIE+oPX2NQX6SceLlv9Qev0SA=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:10 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:09 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 1/7] asm-generic: barrier: Add smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 23:16:00 -0700
Message-Id: <20251017061606.455701-2-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0071.namprd03.prod.outlook.com
 (2603:10b6:303:b6::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: a9edd921-154a-4bfe-e315-08de0d44aa00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fF2jrlQQiQh/mqDEgy4URD+bfU2vVUbakZKsVAb7hIQWwJ2DcFoor89yrsOR?=
 =?us-ascii?Q?b1VAUNholtDPxzfBNNxvninq0hMyON1Qrgau8SbeQbFPgPmCRVLg+JMHEh2b?=
 =?us-ascii?Q?XO0B+l0OIP33KAxbnxQJihakKYSqtwsa7+6YZaaVJO9wNmfVHaWT/YBDgQlr?=
 =?us-ascii?Q?C1ix+VdXXXl817ccl1I29B8eQNNDC7Tau0i4NJcCMYyruyJCmhttr23VWIQ9?=
 =?us-ascii?Q?GydyIwni868ZGfYT9hY08y/QjWV7EtlG0Oz3YfhQ5z6hVnbZD+f3SpSlBAw+?=
 =?us-ascii?Q?9CefgRpzNadWWdApwnw29B9AZJkDKI7XCdArUFHQawzfaynbce5I7y7Qb299?=
 =?us-ascii?Q?OQ4KQY+0mk7Z9IXwCTvNrvNjAEjS/XDd1WDpf5rCm+JhSIBOZx4JcEij59G3?=
 =?us-ascii?Q?vs0b6gnkF2S2Gdf94UZWadqYz5aSowhCE+IQWSscncf19IcBno+YJlBwODVw?=
 =?us-ascii?Q?kwuWnBJY0jJwuU7LHUeeVMxZEkIsbTL4Eybxp5qrpzlGxYA5kjumH45Xce9i?=
 =?us-ascii?Q?MVYL4sdODia0Hi8OwRtcgtu8y4h2zTFFAkoDDuMCsNN8wh+cxh6UdZGeobIh?=
 =?us-ascii?Q?V33dUBC19/3T75eHaL0DT9zCVOUCrsXce/JrCKXFizyh0/Y4nBdTNx62LsmZ?=
 =?us-ascii?Q?2ze+Os/JlBdtVFG8BgxuygrHMQn1ldv6iJ/HHL9w53a4a4kyzVMeePTYYDSC?=
 =?us-ascii?Q?FE+mvyPjyADCpRLQ2PY5TAyOxvSj/OCXvOq/DXvrSTgEP78NMwe4PQy0AsXM?=
 =?us-ascii?Q?g0qOdqn4m4bkQGu1HngoOLj7Z5YrvnKTG+nqrSwEsaIZ4n+vYZL12smXp6+j?=
 =?us-ascii?Q?mVamLICIUUNesURKPM7dhL+NDN7Lc47z08p3jJ+z0MpPawr+XO7V1dsYG7PZ?=
 =?us-ascii?Q?vmvhbWxdVgv1ZaNPwoansRGnRFo66pcSFQ9+22gyXfU9DQ45539VBKBN678c?=
 =?us-ascii?Q?4KphQl/JfRLPMMhfnUrvHdFd0xjUoqqaB5nWOirwMOTjz+1NCGP1IB6FeSBx?=
 =?us-ascii?Q?3c8FNMM/uNBSdS8A1ag7y5O9Fqk/dsDb8fju4bLA5aNFLb2A/t29eGbwjNzd?=
 =?us-ascii?Q?T86pKwYJ2x2hCAYfDJAPTvNOraUK1To+mYSmw9f8De0NyZv9DVxmKe1Tqp4k?=
 =?us-ascii?Q?F8cbOufrDOjT3OVBkcRl/D8s+EH6HDM8bsT1DroDDlBGKjWt3Osxtf16nrVC?=
 =?us-ascii?Q?r3O9SX1qHj4+xq0QJia0fq6p3SzM6nzzITJrmtgim2IsBGNkrhpSRxDUcXcL?=
 =?us-ascii?Q?yMRUJv995ui78563N3BYJHpwaexbdombKJ7Z1iqKkgpiXh53z/Hg96/VMWAs?=
 =?us-ascii?Q?nOdkJxL4l6pMjn0ovGPyHgl7xn+ULjx7zJo70PpV8jBF7xi1BkqwA7mY1bs0?=
 =?us-ascii?Q?K3tjrlHHvBDjGv41Pt7uOG2VaVTYENG77ZnYqM4CIVkAgjdgivJ8YeAIBe/n?=
 =?us-ascii?Q?t3W0LfPMonGew8Tzy6bs/+bC9f5AtmCh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iidoCH53xWQjqkjovjF4m74M/oyvgEAe2VFYgVviVtDvhHaWx0w1jlIdt55v?=
 =?us-ascii?Q?/gF0lqy/Mezb8xBMyZuLVlEDadTS7EuBKGlDgHbvIXtujbt5KgXrt1qT3a9o?=
 =?us-ascii?Q?gaFKyoOmGFH7NcKlWaK6ZLuD5xX43O9wroU3s5o+Sdu10yx/xIvYVGs9MvDH?=
 =?us-ascii?Q?ot2XMZRhBW/b4mC8d2hMJ74YABmzMtm2S1RGw7NnmKigsZSemgQv3C4IK8+h?=
 =?us-ascii?Q?GP58PzGMAwV++HPCmY1rwSTt1v2GVhIJ4C1cPYWZ+RhQiHlHnLQoe8bgB9h6?=
 =?us-ascii?Q?kICk4Lm3dt7nLssVDGYoPiz88LvsgUKQdFargtgrjsX2XLnYmHnuj+AZpHZb?=
 =?us-ascii?Q?UCZ7StDiL5wOVehPqkJwDsj3qEXKFvX5PCSQ6yxdJsz2efE2onT+4kRP4sz/?=
 =?us-ascii?Q?h2Gd/5DchkEQ4y/3ZA8wJjomjbE6hwSU/dU9ptzbOj9dKcX0wfaKjKJGsGuj?=
 =?us-ascii?Q?BpSlo3pjrOdN8+tAF8B0qqim79Fd6QmtT2sY/Pxspc5ey+Dyj5JAIB6m45O2?=
 =?us-ascii?Q?Ny6koezkI2ceB0Tryoi6EK9k6ya96/cLKw+mTPQGncYX/vyynyGItkYUJpu0?=
 =?us-ascii?Q?xnWKwuKR78WQgI6XXGlAitOv8NSzziej4+dKqjMtn7GVW/lzBxNiSO9PKEj+?=
 =?us-ascii?Q?uYn6nPK3/CWze+laSn6cySwVfGBMZF19YM6CFNh0r4GWzDwaGpjN6CjkiFBX?=
 =?us-ascii?Q?h2SxUJFZl/jPZOXml3eHb/lCgFqV78SjPDr/DZPdVwbtg6A3gJf91nJ/fnMq?=
 =?us-ascii?Q?4na3FRawVfXljylOhW9D6sqrM3dODs0gdNWNQmY7VGUrourt3TBgUqtjGPHB?=
 =?us-ascii?Q?Xdn2zaGC9sDJ+yCQAZfseWrkws0mFzTisbJnYqrq1JeAINftaejhPg9WfL/S?=
 =?us-ascii?Q?Rn+dLVZMM7/9bRZURFZU4iD++Jw7pIfQLDOnf9UaiknIim7S6u5fMGxe+VD5?=
 =?us-ascii?Q?sqXa3SscTRXlCbUejhxl2ZGb989yMSU80LAlwVvo4OVoqk0YVBWIPruHtzNL?=
 =?us-ascii?Q?zhobzMEchZHwBOQHTTdQnqKbnz8b27k5Sp98V/aEC7LI3SyJ/KH/7rU1kVT0?=
 =?us-ascii?Q?OrAUpYhAmdFlPnnoXKRy209DG08ybKRtKjM0u9wt2IHfqHq4aq+MCMlOwy3m?=
 =?us-ascii?Q?/8AaZkIDVycDOUngDebQaBfehQ3sujQ9Por/arB/Lf4P8I7Nrr8LBiIujGzv?=
 =?us-ascii?Q?3mFfoopXTd8XmBO+HR3uuVE16SCwDnqpKnaWtEPD5Bv2yf+QPnEdQj9FRMtR?=
 =?us-ascii?Q?DQtOarSaXcyohfvgmgFGKWx8WwlHBrxlWl/NUo6rxa6RmZRLjwOtt+Ac1/MH?=
 =?us-ascii?Q?lfit8mpn+Lwo1fglOXdQvnY4RdK9FVsP9Mk3/oQpwcTe78aI8z1YB9qGu8qg?=
 =?us-ascii?Q?iR65SSaQImHqWtr7ElE1OYpUAD9i890Wh790GaLzxV2M6zaNO1XuMiQDQW4K?=
 =?us-ascii?Q?VMm1IppT1ljLHrLKaqYqqCxqzfZqxR8NkuJkQ1/xlP/ln7RpViBtx0K7SfCx?=
 =?us-ascii?Q?iWXB+6sSwQyNtfMDUxEeJSyezeewcFnwWfF6LxHpK2Jc9JrN/ZzZfCuN/Tfx?=
 =?us-ascii?Q?7coAd4Ts/R/YxSdnI4UzfFgElY82DjWOth+dZys4Jh7yHDutvS6mrk2a8riZ?=
 =?us-ascii?Q?8A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ELrSfN0Do3x5bIyfqI+wWghCujhBuHyPVZv+ZXu1c2bSp9fWPyxybMqr3zQp1FfCgUrmm5Q6QOYZpVnKD/kK/xkeKw40MafZH7RySYryKg8yMX36S98EL9gvCgeIue3cTKzWUQ7s8GinHhGIMGKbah0qL+lV4x+B/C+V8wXJjq0G77fsuo+dFwegzpTjaK2Bl/KlNJeVGB6ZgKB00UrvgiwrOX4MfwURxY6m/XSnsJEs7SzookKjmvswtBePvPturTQCq5cgMIScekQlHaxJTt5If9y7o4pejJzZX3EamGpV8pRjceoPa2LarBtpSKLa//rd9c8z1i+tJ8rd2EXtrK0Arw0GQWnalYr3ftbCi9isUmMxieKg6jT8mRzmjUnQWo0q6G9+GIt/KTURfzrJJtelzl8cw/5tyZLeo94XyIX3ORLXyDv6G0jNe5gybUnOqtW18S+jpAF/h7/+q+c62SWFWwAUYu6Fdd06JGzP86UhXTW8BVc9kg0gw9erYrVqVjv5IK1jcQVeiXL4UG6YgqB/rACv9jGUEGqGKnJ6F8EdtE9q5gEr+qH9Z10bQoP831fFr3j4N35lQ8tdRsIfBMSwJ4YacZnFkEbrRREUf4k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9edd921-154a-4bfe-e315-08de0d44aa00
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:09.5502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v2xlhXNEw+qCcAt0BDCeZdfWQTSNioUdL/qCM118ALgdFkEXYN/ToeHBhH5p5eVX7GysQvAw2/wH4ERamaNcn233Fch3//nkshjbbLjMJ5Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170045
X-Proofpoint-ORIG-GUID: 87NYcqJfBr1yXWvTuZIhTAh3kDkx3tlB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfX6anJm0fgMnPg
 bRziX6z3IETqzprr3dFMeuIoOcOQsxeA2kuMCs36898+S6abxWW049TmCn5zr1iTQ8bwZCKRIav
 wEDouLH+9lP10XgL3jQCclXJGox3pYMLaIJHF1/b+DNNJjBD8PeSpWIcYoj+/LJ4uy2NGtz0zZR
 J6hGMqo5Fr0sTXIagIeMq9XEASDWIg7bEvEiM0e2xttyOl3dne9OMASZuLxFI5kM7UwXT2ZuWU3
 +kULxYEdpZGIVPfGi0F0FUGDxZ5/qfmtAInprmrnwOJoLEpVF8jB0sK6NlFRWhDuMgo+Zxacbiy
 1Xo4XO3YhFPp3SSeDo2I9koHNSELRv90XFYyvP7hhZTUVnVHBGWObR6SwzkTnatTCEDYKmmVNpH
 K2HIovPQzAHnuuRnpmudnCmFLnDoTg==
X-Authority-Analysis: v=2.4 cv=E7TAZKdl c=1 sm=1 tr=0 ts=68f1df2e cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8
 a=JfrnYn6hAAAA:8 a=vggBfdFIAAAA:8 a=yPCof4ZbAAAA:8 a=tAfxz9XjlOImCDDYAN4A:9
 a=a-qgeE7W1pNrGK8U0ZQC:22 a=1CNFftbPRP8L7MoqJWF3:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: 87NYcqJfBr1yXWvTuZIhTAh3kDkx3tlB

Add smp_cond_load_relaxed_timeout(), which extends
smp_cond_load_relaxed() to allow waiting for a duration.

The waiting loop uses cpu_poll_relax() to wait on the condition
variable with a periodic evaluation of a time-check.

cpu_poll_relax() unless overridden by the arch code, amounts to
a cpu_relax().

The number of times we spin is defined by SMP_TIMEOUT_POLL_COUNT
(chosen to be 200 by default) which, assuming each cpu_poll_relax()
iteration takes around 20-30 cycles (measured on a variety of x86
platforms), for a total of ~4000-6000 cycles.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: linux-arch@vger.kernel.org
Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
Reviewed-by: Haris Okanovic <harisokn@amazon.com>
Tested-by: Haris Okanovic <harisokn@amazon.com>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 include/asm-generic/barrier.h | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
index d4f581c1e21d..0063b46ec065 100644
--- a/include/asm-generic/barrier.h
+++ b/include/asm-generic/barrier.h
@@ -273,6 +273,47 @@ do {									\
 })
 #endif
 
+#ifndef SMP_TIMEOUT_POLL_COUNT
+#define SMP_TIMEOUT_POLL_COUNT		200
+#endif
+
+#ifndef cpu_poll_relax
+#define cpu_poll_relax(ptr, val)	cpu_relax()
+#endif
+
+/**
+ * smp_cond_load_relaxed_timeout() - (Spin) wait for cond with no ordering
+ * guarantees until a timeout expires.
+ * @ptr: pointer to the variable to wait on
+ * @cond: boolean expression to wait for
+ * @time_check_expr: expression to decide when to bail out
+ *
+ * Equivalent to using READ_ONCE() on the condition variable.
+ */
+#ifndef smp_cond_load_relaxed_timeout
+#define smp_cond_load_relaxed_timeout(ptr, cond_expr, time_check_expr)	\
+({									\
+	typeof(ptr) __PTR = (ptr);					\
+	__unqual_scalar_typeof(*ptr) VAL;				\
+	u32 __n = 0, __spin = SMP_TIMEOUT_POLL_COUNT;			\
+									\
+	for (;;) {							\
+		VAL = READ_ONCE(*__PTR);				\
+		if (cond_expr)						\
+			break;						\
+		cpu_poll_relax(__PTR, VAL);				\
+		if (++__n < __spin)					\
+			continue;					\
+		if (time_check_expr) {					\
+			VAL = READ_ONCE(*__PTR);			\
+			break;						\
+		}							\
+		__n = 0;						\
+	}								\
+	(typeof(*ptr))VAL;						\
+})
+#endif
+
 /*
  * pmem_wmb() ensures that all stores for which the modification
  * are written to persistent storage by preceding instructions have
-- 
2.43.5


