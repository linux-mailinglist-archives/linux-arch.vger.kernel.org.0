Return-Path: <linux-arch+bounces-15403-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B65ACBC81D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 05:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1F2FF300AB0D
	for <lists+linux-arch@lfdr.de>; Mon, 15 Dec 2025 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FCC72ED151;
	Mon, 15 Dec 2025 04:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ODJ9GB+P";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="emZISzka"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B9D256C9E;
	Mon, 15 Dec 2025 04:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765774316; cv=fail; b=i0cMt9rwjwuoeRNcp2PCIqG1Fqd5R3lcu5v/fXQJI79HTqhDPGUNV4ogt407oji4nT657y4EMvilkxJB7+dn++rDpX48G2TTdwxcZEp6IPDskkUIZ+cslAsTQnxPkD/868SrD8XENhnkCPNfV7qt/iFPPRD/eWvmTsQhPunYQA8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765774316; c=relaxed/simple;
	bh=xtrvmLkHd0kQRw7q9RGIgpM6sEaKzyWy1n7Y559rj54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=p5m8oerdrQXejlXbLJVo5fVTDerjRDNXjEjvqEWj6f7NfT+4ExK3ghs9RSGYTslDjP0iS6+lzbhpeh3fZFy06iLOQeiAbEbUskpxDfhgeLi5zY9u/lEdm4BN8fkXIPCiEk8yc2mg61g+QgEywUNFmRI1UO47Zg1xvN/xspt8Fcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ODJ9GB+P; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=emZISzka; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BF0Z30A950480;
	Mon, 15 Dec 2025 04:49:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=1+n1R9ifYekrBIFbOP1eBPzj4WfHaadZ8WLDJxJ949E=; b=
	ODJ9GB+PDfhbrwsUadiIfgpGf0J05m9CEuQQ1oplXQdi7MgklQXiioRRuZHXtVmn
	qrTvPaawPKUdTJ5LxwfNDOLfwzCidaTJp7qpXTw+WJ0jCb3oRJtV/ofq/8U8VJBW
	5ck0zcUK1aRinEWqwifr8R8juUaxY/oAPurmduEdhrhNue7nExpRW/1Mk+uNIlEI
	uwYEIllEiInF1ZCQX1NquA2ONPRBEMS+liSIe3Agl5Hn0taik3myCwFxzgl0CXys
	r+n0H0Db2LdDFuVtpys+6P9c6ZrzLU9rnb9kc00I2gokVG0rQtzQjeHd09jltMz+
	Z8hSoe3KlkebOshJCvUKKw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b0xja1b63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BF3De05025232;
	Mon, 15 Dec 2025 04:49:38 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010050.outbound.protection.outlook.com [52.101.193.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b0xk8rdf5-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Dec 2025 04:49:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WPXPsBVJDhnl7oD7ESwHVPYGTuHzRUzcHXpFQ5Xh0wYwAk0ZbzkG4Y9FZxHkg5Pf4yJMMkedA+MB+7Rw68gs9ZzKKWNbcy96nZc4Gn4F4YcHK5esSrCB48nJjsMxS1QWVmBKBsfJPridIhZGjDxUbee86J0NTidv6X7uW2Jc4qBX2T2dG8Ca5deoqcM/d2tMEPTKeIHBQZwnj8P4zHyFtK5PsMtjDyb7uIe2weIXBfy7kauD6N9YVgdBbWxRywqtzDrg3jBTMNvr5+c2VgSgoXvY1Fe+hSc2mRMejW5TIGt6pUqsY1iq9UntJ8QiQwgd20jl1uTCxhxpNqaOP0lFUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1+n1R9ifYekrBIFbOP1eBPzj4WfHaadZ8WLDJxJ949E=;
 b=wfLM96MRkrmlV96VP3qrWTxWlXFGCrb5RHAYHPbwW5mMKz2Hb1WOGNHmlGwq6qo51rfMuEhMrXb/k6gXSOGGWUJAM6ehD5zYyK9fUkxJb/lC0Mb6n4FskK3w8ktJmbegeOVsi6gW8enWrgfZaz9DCTxho65X9xT24xyxaPtS+vw/1cPrfYwlVW+YPICDzZz2yeuIzs3eJ4njJEUYLjrA/GYenjF3kyISFI5B6dlzLmYrGauy8kzDxt+/Go0csyDXt3NDmff4zvPDLFaizG9/wLO4otbwZ1fcE1aSP6IMmcP1NNbX6k6c+2R5AN48P/NNvio/j2OVrzLKqismYqEh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1+n1R9ifYekrBIFbOP1eBPzj4WfHaadZ8WLDJxJ949E=;
 b=emZISzkaND9tyB60c0KwhMLGY1KcKaHWQyW6gdkwzIBKXjYMkANE+Dyv6pwCF1bhd9p267/uuqvGIzELpxncnhy/S6kgDFyEAruuk/nuoqylCAYN4h8oW2lU/VPwTD21YSyvEChzQT3s8/PeLPG+c0MxB3Rr94+g/keLbEAKUok=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.13; Mon, 15 Dec
 2025 04:49:35 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9412.011; Mon, 15 Dec 2025
 04:49:35 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v8 07/12] atomic: Add atomic_cond_read_*_timeout()
Date: Sun, 14 Dec 2025 20:49:14 -0800
Message-Id: <20251215044919.460086-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251215044919.460086-1-ankur.a.arora@oracle.com>
References: <20251215044919.460086-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0051.namprd03.prod.outlook.com
 (2603:10b6:303:8e::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e33757-a596-494a-f281-08de3b95588e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eYyDY15t1r0+ya4ikQGpt4RhGM4G+HDu6Cjmxwtnf2GSx+ev+EqUQMcYmCRg?=
 =?us-ascii?Q?6BXXAq35zjG4PJSykCFW+XqFnIYbhPpEA9Z0BVhMwopJbCHsrhQRrNnvtxuG?=
 =?us-ascii?Q?4Db8gonIgOCdkjpyCKgOIns2qsXMG4pAa6ENl2/VjUt09rZzmtM027ZaXpAX?=
 =?us-ascii?Q?xrZSIeLRK3NjJMudQ/atKnPyhBS9Nv/jeATIl9elA8UAJ5FAOFZ/yMbKHfi1?=
 =?us-ascii?Q?GGVEof3FBcdeWApedCuFL5CfeUtEpOf8id/9wbeiHl1bYsBQraTBdj/97zC4?=
 =?us-ascii?Q?cdLKipJeFPR6KtX0u71gyI8GIZ5ybKr+7ZOVK7T4+8RTjVmp8rTxFanlSnHm?=
 =?us-ascii?Q?NoTsfuOcTAvcp9QMpAnXNmjcJyvwHA6+D/QSjfMbQq9HXTpVSkBxybijMh7A?=
 =?us-ascii?Q?RoyiV01r63b4BHHlwEJPsJCy0erQfWyi6qqjHuwpaWEx+HfvBiFHud8j+uuk?=
 =?us-ascii?Q?ynEpJQTIJJdOcaSSAElxbnqkVqSjZbrVT9NRltyq5U8MzRkRN63p5bpz5Len?=
 =?us-ascii?Q?HRnMBtwOLLaOEpabzYC5nOVGkjOROkDFUjvNoQVrwNGwarRawsE+tlf/urUw?=
 =?us-ascii?Q?jYtzzKQhWDhOjL9y72fcxQXh0RNE80xHFN+e9PYj1BSpiYdueurG5Wola4+f?=
 =?us-ascii?Q?6a4YisCY43jTnWB3+05faffmPuu2mNSrXwqZWQAenCV3TepwhLRzLXLF3x7n?=
 =?us-ascii?Q?1cbEqf3He1SkghYSDnhIZi8VXv5uT+noHVyBjToPU/RDyxgFLzCBS7LB7BpX?=
 =?us-ascii?Q?AyXEMTsPcWa0iWX6Ff38Gqzo6VPdhzLwef9uKn016nq6K9QFsX8/QxZcZy05?=
 =?us-ascii?Q?RO0pjQrzNpMfa5LStLKC6BOIwCVnVmpID2O7ts5fUuqPYFV8G5uB40keCuBh?=
 =?us-ascii?Q?g0Alcoc+xYw7Qaqvmk3qsSnr/VwlXNe0N8o+8+KIU5WM75Db7ldpwmX/tjuE?=
 =?us-ascii?Q?38OuU9SIZAiXbRbw/Oi9jWPbH4429TqVniGCIDLmcEvgA2qn3QT3C2TfY6TZ?=
 =?us-ascii?Q?auPmo9UYOA7uDhnvU/tQwvWEENoUXZXUgQ1KwzI62IiDoUDadsjIdNJAAznN?=
 =?us-ascii?Q?zYNQPA2aGATPKnka5Lm68C5p2v+R/Xv2FoXIrHZp0EKE951gv3SGxb3OCQDH?=
 =?us-ascii?Q?3N7F1x+NpowV5JSLLDJvkj+NbuFJWMw+iG+HPqQ8PqiGwHpdChS5gNk7nqtF?=
 =?us-ascii?Q?alg2UvyRgDWnrbaICkAnOTGyqVdlrABI6yfL3JQgdt6ZiegQskSKv8fmehiy?=
 =?us-ascii?Q?m9mKWPysZBURtk8aYhB/6HXLe55ezNxndvxhB3SEcH2IaojAjw4IMFLu4Ekz?=
 =?us-ascii?Q?OYYpunNPilO9a3IoANgGPCT9TSJ+d4bFozdRoPxxhxhM7DmKwGKbPrMzb+8E?=
 =?us-ascii?Q?wiqNG8UheBIwqryxxIt8m/ozi77B0X9v8nc+16Q+s+aET/GQT+1RtqmVRISN?=
 =?us-ascii?Q?WHQllFKvFAJiL25Q9PAD2SgoK3SVDqpt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?j+swBvg05R9M/8FKrww4eTkEVdgFvpXT47UxlPoPem6IbnH8PLqsud/wbcJk?=
 =?us-ascii?Q?BlTv/OTPi1J2XOKJOsTDX2ZIBqbeddaVe+h0q+12m748Wq6LklMkgig9GBUP?=
 =?us-ascii?Q?8WGuDPzBuKyS5UmN1xR+sV6aSOYGRl+HrZWRK+boTYQaB18AJwdm5WKyrQ8V?=
 =?us-ascii?Q?yNOBeSxC9Rh1fxdYRG/eBBKiRFe6ELRp8H4I1zx0SjxPtFWpOkXdxP/XvpP1?=
 =?us-ascii?Q?eWnkyVu9+u70PZtdnvl3zIVXxowtjmmTzTPfXlqq8V5QVTLHROCSJdE+ANX3?=
 =?us-ascii?Q?GDUiOfloWVJub8l7jyaH5OvVU/z5svVKo4S3HLKAc3Y0bLFW9HUvg1uLiNft?=
 =?us-ascii?Q?LmNVkLzGZcdBk5i2uo+BatPiNLKIjL0TLl1sw4y+6T/L4mxKuFyf3T7ZjgS+?=
 =?us-ascii?Q?cFbgKCtq+c7jRX8Sy7ATPFepmi/PurmVD86GVS3rj9aOUq6YOfGhfYjtERYJ?=
 =?us-ascii?Q?2AFTgdSNlWxtNlTUbFykSSJ+Bwm77udoJCpVNRSpo9oKgOZTrA8xCn28TSLx?=
 =?us-ascii?Q?oFe0F77FN7JsKlSKs9mBkyjsPS1lnRg4ddvpVrJblABqcXMBJLa8NDw0fqnD?=
 =?us-ascii?Q?tGvmUsuFO+YG9lGBr6pWQqPTTdwdM8mHClsOq72b0dxu5MF3IlR9+mzvqN8f?=
 =?us-ascii?Q?EIR5GPHFse5sZcVx+0jM2qexyY2cKidDRq7anynl8Vi0WlSixXTRd3lNYBXq?=
 =?us-ascii?Q?cRvSxmihoSGPmoz8g9Q2cuu8iGYiphGLWmS7JMQ1goORrIIJTgghRncWigp1?=
 =?us-ascii?Q?eZREddwengBrbaxIUDxEnOaujY77/+xQcapKo9cEMEic4YtDFikmo1fKt328?=
 =?us-ascii?Q?nAqW4ZhcDkcLX5qBX4bExb7j2VDlcfgMHour6NDSSzuFV/EDZTL9lJFmqyNk?=
 =?us-ascii?Q?t76a/2JnM8WILVBFP6k/vCikKoqRV6vjLTnEaC6k40UGrISCYiFEENYs8aTr?=
 =?us-ascii?Q?psOiX/hDEQx3u93L7gRPvZhx2BVZUrKGEHtmb2lLMTuMBpPIKkQij7bwWT0X?=
 =?us-ascii?Q?lEKfSCIN7AWZHsobWMJp2lx8yOd3JMu6XachwdE2VwvmTzbnx1rP6a6vJOwq?=
 =?us-ascii?Q?4jB6Nm27VtiYonPXDhkq+XllWvcqHDvH4zSjOBD7KZvmgvQr2dEr208ggxnH?=
 =?us-ascii?Q?YqeihI3mW/bDi0MVN7SAHBmnRsAyV5DRO3oms+tq1rouGIaQMgio/AZ+iGNG?=
 =?us-ascii?Q?WZ43+ut/Tm9SgOZCyq+PZ0bzLdhDiDOOgN1Gl9o5S/KchDibEWDwiLHo+tP2?=
 =?us-ascii?Q?raWieVlNx7Dqxo2XTgZWkiR+SiJ/r6rU+fDKon4QiqN3jiGlPwcp6UdGIjNT?=
 =?us-ascii?Q?Ou4o+QHr6Q8LQ2Pjej68aAfBFrhtphma3untU6cShRDPRFPOQDUmX27hpAop?=
 =?us-ascii?Q?zHGhqy6mXPdVI2uev7wSmbDVgrgKLPOrrUj2va+izM/v8VPQO78oS6DBz8Fa?=
 =?us-ascii?Q?bEIiX5jhgMRoOfWKq7hp+hIRNOjNlJGjREwaCbbh75ZRGhy+6puHNrNP7Wwo?=
 =?us-ascii?Q?lNpmhX5jLdXPytxvSbNBesr/c+qNQPQkIuM1/1s6apUj4AtjdeVzMT7ARBBB?=
 =?us-ascii?Q?f8lIagqpptvYX87f5Retoc/tH0ym31T3wIch/lgvt/T/SxXhkfgaeIcNE4df?=
 =?us-ascii?Q?Mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+twcn2i8e9voMEACKIxwX25V4XLmXba+Ou5ylScgBTX0HNJa13VO8hZ4jQhKR+qfGXdQ6QdN9/P9HAqfQkFN2XJm9sVT5Oxz1QB/6+QUYbtJJaURE5Fm3+LeAoXPgRjlKb8y1pQ5p5gHgdg5Vx88u70Umykn7rcu4n/l4hjWxe7O3n6/MI8TXfoFcOrCoBNR88K9CO6L86fwRbhqpqcCfsk8xIRAOZMCYZxxHL6wN/2YJ/TEhPEATAVsOFar8p2QK3SxpM16L0UvlRPzBtvo91oNmtzG69ghy29jrpdPv9F/DiIqZmmJlITxwPRZrzIxnitvjMFgbd2WZ2oAxEiMjaDSP6Phx4+L/ks9EYAejzApLMr7Mrqzlq+Bl+CzIb8VMQ6NO32sMX7a4TMGg3eBr1GJnAivhuCR70bhuDiOPimcjpDi5AYLcj8fZuOzZD28PMekv1f2u8aRigmW2jo/W9lHeB/b+OxKsg8Z4y4i3WX+7TPu0UilqOXzGVZCj+J2aKta5LkzMGRmgo6/MPAmKnFW4A8zhzeh3+3kaHmNulcm+Z4e29deMuU8VGd17DtoumIDwilN6KQOMoZWTWtJVtG3tD4X/5/Sw1/YNOzJ7JQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e33757-a596-494a-f281-08de3b95588e
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2025 04:49:35.6334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3onUFf2+0tQff+BzLaEMeuq3S137kRxeCF346MWwb+mDeYHC7myUpxou0E8oHzwjvxrnLzELwVzD2TdebbiQ3n/rbw7CN07juvenRNhDn8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-14_07,2025-12-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 mlxscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512150041
X-Authority-Analysis: v=2.4 cv=TbWbdBQh c=1 sm=1 tr=0 ts=693f9363 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=JfrnYn6hAAAA:8
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=1qaWZlc5I0uanKkomNYA:9
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE1MDA0MSBTYWx0ZWRfX3mNq8tp7gr7X
 VApXvAi66iLUDehQh4DfKCvNxKT63oFCo01K8k0o816IZZCNyrRFihZtSHSTx21y/yMTjDu1qZK
 dGxcvXWEk0cn46CUr+pj48A26/0PM2R8EOUeOj33DKPq1QLVmzOsR4c6XMST4tmX6xx0eIvVCuG
 snOSOMXl27jRRAt9JiWUk/0fZi2mRraXDWkMw3fBIYvKRyqxtsCcRGV/JQ9BxgC67W7T9UMyR9K
 iDzfaWuXmTWpX4Z3BmYOip0hKBtp9TqPxEnTb6jt15X3bZiZgHQT1ul4ixs5Zp3irJq518GowAx
 29bIzK94VQlJDOTCxcCMjh2HiDV3vs7OqOZCoUTLzlyOxoiWgLItuDjQq025nS7Y0ElT5Ih9f4h
 Xt9o7zaz7O2+RqPsp08N8v1PhMloCg==
X-Proofpoint-ORIG-GUID: xg47lN3Z1akIQYXWvZhqUcRYU1bohjL5
X-Proofpoint-GUID: xg47lN3Z1akIQYXWvZhqUcRYU1bohjL5

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
index 8dd57c3a99e9..5bcb86e07784 100644
--- a/include/linux/atomic.h
+++ b/include/linux/atomic.h
@@ -31,6 +31,16 @@
 #define atomic64_cond_read_acquire(v, c) smp_cond_load_acquire(&(v)->counter, (c))
 #define atomic64_cond_read_relaxed(v, c) smp_cond_load_relaxed(&(v)->counter, (c))
 
+#define atomic_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
+#define atomic64_cond_read_acquire_timeout(v, c, e, t) \
+	smp_cond_load_acquire_timeout(&(v)->counter, (c), (e), (t))
+#define atomic64_cond_read_relaxed_timeout(v, c, e, t) \
+	smp_cond_load_relaxed_timeout(&(v)->counter, (c), (e), (t))
+
 /*
  * The idea here is to build acquire/release variants by adding explicit
  * barriers on top of the relaxed variant. In the case where the relaxed
-- 
2.31.1


