Return-Path: <linux-arch+bounces-13244-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B5ECB2F754
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 13:59:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC3257ABA3A
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 11:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE112E0929;
	Thu, 21 Aug 2025 11:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pYbJIJ7G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Z8qGd3ld"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43892E8B6F;
	Thu, 21 Aug 2025 11:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755777526; cv=fail; b=eVT3jh85mcNdGoiSGqS9vdkoxH/GwPkzyAFYz/WEbEjjcLWIsHc2Q+aM5czFWzXGZ5a9s7XbIHQgoR/xDrKw/s106o+OQnQmLKP6ZvS7jljGye0kNkKRBBfYnKEalJ/MNnbH0L8kTnFORzH1Ys1Uz6nStYtDwHwzrOK27ze/KjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755777526; c=relaxed/simple;
	bh=MeQrSI+uniSoWOmSnJ+4e3CsK7ls2TZfUUbU3Q4QlhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CZz391qIzjmLNVuKfPkjEXNTQDyTtX5awaRbWmNJdi6pDUdfBAW76r/lpB4Wfj0GdAoDKlORHaZdwSJIpdj8ZZ1FQdYw4X5Wtyfd0dA8tOVx5L0JIshjNcesuMqNWyAg+o7OUioaNLZqqRK2y2ScFepqQEk9b+0d3uvJJSlbDPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pYbJIJ7G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Z8qGd3ld; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LB2fcO020240;
	Thu, 21 Aug 2025 11:57:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=SQDLI0cu3trnk66tUIUVgepUKObs9voMB/i2F28ufxI=; b=
	pYbJIJ7GFXYsu47LcAK1p1laEz1l17CVTtRASUwY4wgFGy9vIfb5svT8rAzKk9Yk
	H3Rwa1V/IzItX+Qh9/nF3k7nBw1USKkN18x7qD3sgefBw6gWAkvGsgsnfxmtHgUd
	oxK0w81yLSdeMaOuZzdEFHKLL7/XjBpBFAap9lgXrXZHo8b7+mS5FV7jzJwlcEOo
	8dJbKvG3nfMEcg/BWtXz2+ZY+ReKoixq9r5nYAFXwCLjSY16aqzb45IObKW3oWIo
	SICETmSI4Zwomhp8eJiN6b07VH9gx9XLI91KszNW3A4NZu0hqSA5yIs33BlGSdfl
	rv5RTmBKk0pxGguywQ5TsA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsbb6p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:57:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57L9fbjB025356;
	Thu, 21 Aug 2025 11:57:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my42h54t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 11:57:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxWehmHIkpwu1bC/S2qLLjLr4JC3MHa50o6lwFAT7hK1vFEKrlKIRaK8sgp3LHDAMNucktHIvbout13DZ7JlQ0GRCw30U3GUJ5opGuJYzWTPY9cFpJYE8hy+1QAGLJAxkQA0TOlmr8QCjlbYgdzu4joF5Zza5jh4sK0DovWrqR4pdCwVj2KYvvEylTdiHPDsQGe6pj4AY/kvUnYobVEienBoCIPxZYIymYdFuENv0sS4Gi2t6i/Vav+8zfkPth6np4OLWieEx4a6MVWNyGS+7BnJVh5EJ7Ef+bI/S3ckRSEa8JkJtsXFW2lKKdVSugopEsCiEg2BTnkXIREjZgT3ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQDLI0cu3trnk66tUIUVgepUKObs9voMB/i2F28ufxI=;
 b=pKMi+ibPQL9yveLO1bBtbirXTEz+yB7gxQsWZ8gGsztLlreH0KAkZo5GV2kZaL0OyF0k/F2frwA2SO1Fy9+Z2LSwFi4tTdSkKpGEQX8Suv7ThJ6ISLxjTTmhIzccXYlgS7pjlKD92VtmwixGE9qQLWzGYYyIHAQCeMHzO1basuCGDEg/PIL5lwcEdM3pF1oYxi1LimSGJU/HoC/AF/9wDdI77MNkOWqfnu91jC3NExcqFN1OTrW0ek4tamyttGHfrxuEaYIX3n8OAWUN0AOCYAMaPVo2bBkuOKchGiPIyBZHbUDDDdCIyMWJqIm+rnNNMpsjRFhn813c5wMQOjMJng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQDLI0cu3trnk66tUIUVgepUKObs9voMB/i2F28ufxI=;
 b=Z8qGd3lduWMJ/PDUAskCYoB7rOE4Fy4ZCer3TMt0aGnEg8BS0qtqzNf7iJBrPzozP1pDdSSrQzaY9Niq6ycjP2ZKiWQdpwuDp+UHR4zTAvSyK/P/BoxvSZv9LA9bCPGgH/bMy6xfmtjxBqB5IQyO/fmSx/XdoUSmXJrc8U4ZIYw=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB6373.namprd10.prod.outlook.com (2603:10b6:a03:47d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Thu, 21 Aug
 2025 11:57:39 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 11:57:39 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: harry.yoo@oracle.com
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn,
        mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
        peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
        ryabinin.a.a@gmail.com, ryan.roberts@arm.com, stable@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, thuth@redhat.com, tj@kernel.org,
        urezki@gmail.com, vbabka@suse.cz, vincenzo.frascino@arm.com,
        x86@kernel.org, zhengqi.arch@bytedance.com
Subject: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
Date: Thu, 21 Aug 2025 20:57:31 +0900
Message-ID: <20250821115731.137284-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821093542.37844-1-harry.yoo@oracle.com>
References: <20250821093542.37844-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0106.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::21) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: e9bcf4bd-deb7-49f6-1810-08dde0a9ed48
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xWqmFLWWnhB6FACPA89t/yYp9gvns5NIUoV15vZy0JclRjOs46d1rM/DsVCd?=
 =?us-ascii?Q?eI5BAIOd0k7DoiYATMFXc4eWTzIRhj09eWjgNu2CQcgNwH/UFp+SwvFGDtlY?=
 =?us-ascii?Q?ZoUAtltwC8HoKDQbC6aMO1R2ELstiH5l9yZFQAetfUxEFwdhVzTrnJgb77dU?=
 =?us-ascii?Q?aXS5HYLCRji7n2VRcgAgXObD7RqZRzBFpJt5J/9vPtWEYY/D9jswwboKg6Ig?=
 =?us-ascii?Q?aPVm7HC+O5PuVxOj4rnJ0zuLE0jCD8xtR58t1JphmrGJKS7/yM5OGJ50dK1g?=
 =?us-ascii?Q?xXZXqa1vEM7hU67SJv9rc/X292VQwbi2evK3AVCwnuq/Co+Oi0PTB+ViN5+d?=
 =?us-ascii?Q?7PY6uvzLkLUm9LUQ94WMLHYURP2pKKoDpOJphWMjToX5bVVaqn1WALOo6Srm?=
 =?us-ascii?Q?1MFN3v8Su35deohcVaWpfHkRW/BgECAfQGFHfKhuFsx+fDX72TfqEGKvZLls?=
 =?us-ascii?Q?iB1KR8doWHDcrHf+u841V7e1y8b+EfRNpAs3q9v5quBQPBMLbv/30qMKIWA2?=
 =?us-ascii?Q?XpOuSA3ZmgB9m/Ne+Xc1WQFw/55YtHQb8VcQOGnwSyauAB4L6INckT9/li08?=
 =?us-ascii?Q?5OhJJJuAzQdylB6lNu3dtIblwnURvgzZ0pcd6Vlt9IJitV+kT8XUR/JICMxa?=
 =?us-ascii?Q?8MkW5Nf1aeUGROS0r02HvVGhBjjgKU3CIcyJcfkhIhuZ/3PvtEv2Xin89KaH?=
 =?us-ascii?Q?ToSBYDr3FtbVIjQJJmyztm8reHAhFyhKO+llbaAvvNAo1Vli9P+03ZSCw/47?=
 =?us-ascii?Q?MJQi04k3vlFWu6mZ2eiNaimGqDxOk8BLd/QFunC6fArgHbqYMw2h+fQbY9sU?=
 =?us-ascii?Q?RZaMu3lQPHJ10ADwOHS7uTySpyo8MA7xdaws3glzDB4v7QucqMo5bRrf6DhM?=
 =?us-ascii?Q?ekWs1bj0ul4IyxZlct3wVKhi/liWRFRv/j9KGRuQU4l6LPo1DyjRn0syFk/1?=
 =?us-ascii?Q?5NrLohHF6Ksq3H60Fc7ATXWqQk1igW4ggrLx7QbDi49mAO/uNv1ebp9R491v?=
 =?us-ascii?Q?ppcXEv8RQlU4M0sy9CuEpDcNY/3AA3lPriZvwLLwAE0/kRHfEYWn4Bqefjc6?=
 =?us-ascii?Q?vkaKLLrxBy4l43QMm875dQq9seMmos1Po4GPNzbkt/mvAwfRk5SXXKjM5ooc?=
 =?us-ascii?Q?0X8A20smXPZ6BOC1jiLlfQo7q4RtJaza/6k7/k/XRPRrKTVqDMLr+M6h8Cca?=
 =?us-ascii?Q?vGEEaETosq8WZhyVAjaP9aLpua2EaNuGeJUG83/fs0qdxzuyAWSnOXzHH6Q+?=
 =?us-ascii?Q?a2qCsW6K+2miJ1C2Yn77fU5OvM3wlsjYvlN3Q1TLdHYTeafkOpKHL+lW6bMy?=
 =?us-ascii?Q?dp/C2v/w8ZHmZZNnVHjD8nTRkfVoLaFEoqTQ6PPuDBqNmm46DXQFjdmdbYBj?=
 =?us-ascii?Q?E69lrrSnnOQcsWcomTVh6aV/3N6zRtvZVWe0soO9fWUUJsZX6zz2gB0P3Dus?=
 =?us-ascii?Q?LP88+4nq7x8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9YuDzxYQd6pnGciCKbnlhWPqDc63Tc10lRILcXmJd86zUxywp17heW2CW3E2?=
 =?us-ascii?Q?VjC0DNTvxq+/Cpa2ch254RqsNYi/6fwIp5eI5/OrvKSiGW3DBT6Su/rmcx1C?=
 =?us-ascii?Q?thVpNhS4wJyb3vsMYW4dgjCZWfTsmkkfYV2OaK1W1tfAvmd4rGNK6JvOUVk+?=
 =?us-ascii?Q?u81qD3AKkDXIpSwTUBg+RS+1Uc9SiI5a6fhiGf5BmgIgoYCgU852FxAPiqAa?=
 =?us-ascii?Q?jHJDsLKyiLV7/n5Jo9EuVBRewdTgOYIhRmIKOMoGsr1j+0NE82dAr0x70dDe?=
 =?us-ascii?Q?XJ8Xto9pcgH6fulnOVs3s3YIBV+L3J6edzJI3FpB5FYhzNMU9tQpmB+tnaJ9?=
 =?us-ascii?Q?83Prk1L7uC7/ls4mK0FofzabxLK/7E6ZrdZPqksrXZeYt9rww4OKBW3cqmo4?=
 =?us-ascii?Q?0kBsni2oqszjFrTqMYtCJWf7Po+m9nHPnCwmhbs+BgSW8UmVuuGeNcSNMmlV?=
 =?us-ascii?Q?+axjF6GzquadtBySwBclZls/kzU5GvaZWe9bQVaW+R0ra2xthlwE/CSi28rh?=
 =?us-ascii?Q?v8eYds2sbRQE1J+FUt7Ir+P01f2lRa22vIx5b778J7/WR0G8q1rBbjkLW6HS?=
 =?us-ascii?Q?VVMkv+XvjG28nlD4dpOoRNVhMUiW0mx0XoU7DNS4g/QT5OtlhSLyvQTj2Ku5?=
 =?us-ascii?Q?ES08G+r2xI6Er89stOhFuN/Qm8w3XMSIhsDQZXvTrOqoMyYS1gzPTa5k1BmR?=
 =?us-ascii?Q?wy2UWo1ZIwUcPJ/LEo2QAv1Tum7xOpXSHMRI381+At9Ezn/zJ/wy0dCIST5q?=
 =?us-ascii?Q?0yP7/Y73vkxR1+oHHptv0ZuqFFZNTGEznqFM7t49YbN6gPzDUFUkgzAVRurS?=
 =?us-ascii?Q?dhog0hqvz4x2CJ+jVP39W0rQbTMm5LgmC+mWXRQ9KOEl5WARvb1wiaTZY6yy?=
 =?us-ascii?Q?4Zb4j0bP6KD8iSVe1tqwLwM7kd99ViXTnjyS0nr+TO1ObznHBrRNJPDKzQcN?=
 =?us-ascii?Q?3yF6FewitytLV+0n6YCt5NnveQnoYzKrL1fFZMKDsl/YyYBO2XKMOlhRP1Hs?=
 =?us-ascii?Q?xQ+B9rx123R81/hK9LxnSq4kmQdKmlkMCzAz2oM7bQSyXiane7Jqxa08bQFi?=
 =?us-ascii?Q?/5D+U0hsTOlznxJI2VWEvhpU6Tc2J++tvM+TrK3V2/YWLuv193w+lFUj6IzU?=
 =?us-ascii?Q?fSzNdtyjOcRVktZC6mXHwdmXaKA+22Sb+R3wq6ZBf0sQW56zjGF+GI/gAKhr?=
 =?us-ascii?Q?lxP4LfO6q1i5lPE5Zy6utiGRx+76ngRTMc3G+ZSiw8W+1egXzaavEhpoV0Mz?=
 =?us-ascii?Q?2N+LDo2dH/1eVIv0temG2gMkBJd1Z6I3L5hWjRKrOuQsvgdZkbcu8NT65HB+?=
 =?us-ascii?Q?sAS3KMhAwzsHFelAHGQDl/Y1jKreF6tRWdqa0DD24KeEFcDRVGpyU+nKVIDD?=
 =?us-ascii?Q?msi4Uj6Uxa5/4BM5HzvACbNkmXrB9kCPD8xxFPodyRuec5NuknCHhXYJG+je?=
 =?us-ascii?Q?Jbw//5xRprwIfqjkHFmX02gBFGZ73EwHLTRVacmnmahL/DY2D0AVCNanZ55T?=
 =?us-ascii?Q?1myRhTo4nJl/PskEVvcOrd/tkQFLHusUM1fACR/Y/pPSV+tN2imsUrhBUYC2?=
 =?us-ascii?Q?bcS/6AXKsMCTZx92QTeebszJbcAhxbhwbcul6AZm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0fZynid7zxAYs+3XVoGvLZHsz5bc+0Qf/gD0mAUmzn41gwzMWjX6DIg2WvXXIf9fW6Abyhvajh2sKzueLWlkaEeUItvmku4nkoEEfmaU3rMW51uQCIKEyIVLzKS5Fl8ztWbXMJUGe/zHKaVvF+QnIcGYD3KsrKFM/CvBE0vGEWg2pWTEtTeNYHyTKVU9KTtvmyfwfs8Wq+Bwbrdhcjs6yA7JbZy6mN45aoyWehYBAbVhbiF2xVfEsAfPb8KXtmiVyjqZcyChIdOickUYIbY0Nu3/aCpDNNw6RuoFALZeFqsKzMWrY+LZYVIE89yq7ZiUnst3iqxb1r7GGphldpsoH2hkEwNQBwPLViPrTOUmtcyNPoDXlyI3BAwRHjTzfskdPZ9jDYAGGS0RS+X4Tg7envSmau0Y6bo3IgBhiKsVuV46INQDF6aJG6ajylz8vWT8im1VdPIwSz2DKKteRqKSodUwouxQxI+BZxrS9DX4zuCcwg8YUe4QfGcN4RHrFvih4obRKafm7uqyC+m5zGGLe/wCukVGguSgkbcDj7b8LIG/etaWxCPGOVWG4j9HchuIXv5+1gWXd9BL2hzWSdGkK8SWJ62WoeBqxU2hpzxdT2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9bcf4bd-deb7-49f6-1810-08dde0a9ed48
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 11:57:39.4777
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ib398fnlsE4jVNJ7VFcEVyF61n7DEiihsbdZKnHYTPbDBYZlQ8z70cBOZeEZW9uqhcSTWbJlmzs3MCH8js9+Aw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6373
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210095
X-Proofpoint-GUID: T42QvEyuJshudZ7rbglYKphUBLE6Je9N
X-Proofpoint-ORIG-GUID: T42QvEyuJshudZ7rbglYKphUBLE6Je9N
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX3Z4dCp7jfM/w
 ptwxtUOOvIKBC981XbdNIIyU6jqyJQkr5ziLBiYQAigtVRZ3Wi5BxGVPWVNKyethAm7Lu0HmZqd
 Jp3exh8ml1/innvm39d/q+crpxGdYW77B+56M5NtSt4RbW8bHdEa97ldF+G+aIcEp+oq/TwSGq+
 NIGDgESkc8RzQ2ZJIc6WMKNk79YSawTBAefCIjmtbuQzGLDyY3Mo+x3otZSH8YFgoevHgtR6i4g
 gAgb5+Kxx4ZzlOjmJRBsfN7OPHGuWTwHQzH3i2On+/wX8ccc9FbPuh22ro5OFW40/8YOrxgR7Dy
 Rd06JwkPY5+YdSfIfTQ8Ban+Au3xK0mOgtNVtbyFR40ES2G0+D/Ls+GdkZOdi3twfzyYBvf2bS9
 4PmG0HsN+I733QdbMP9y++1tNvhw5EQJ2U6OfHmFnQR976Z88M0=
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a709bd b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=qG1Prv0osz8Essy9glYA:9 cc=ntf
 awl=host:12070

KASAN unconditionally references kasan_early_shadow_{p4d,pud}.
However, these global variables may not exist depending on the number of
page table levels. For example, if CONFIG_PGTABLE_LEVELS=3, both
variables do not exist. Although KASAN may refernce non-existent
variables, it didn't break builds because calls to {pgd,p4d}_populate()
are optimized away at compile time.

However, {pgd,p4d}_populate_kernel() is defined as a function regardless
of the number of page table levels, so the compiler may not optimize
them away. In this case, the following linker error occurs:

ld.lld: error: undefined symbol: kasan_early_shadow_p4d
>>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> did you mean: kasan_early_shadow_pmd
>>> defined in: vmlinux.a(mm/kasan/init.o)

ld.lld: error: undefined symbol: kasan_early_shadow_pud
>>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
>>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
>>> referenced by init.c:200 (/home/hyeyoo/mm-new/mm/kasan/init.c:200)
>>>               mm/kasan/init.o:(zero_p4d_populate) in archive vmlinux.a
>>> referenced 1 more times

Therefore, to allow calls to {pgd,p4d}_populate_kernel() to be optimized
out at compile time, define {pgd,p4d}_populate_kernel() as macros.
This way, when pgd_populate() or p4d_populate() are simply empty macros,
the corresponding *_populate_kernel() functions can also be optimized
away.

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

v1 -> v2: added comment per Lorenzo's comment.

 include/linux/pgalloc.h | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
index 290ab864320f..9174fa59bbc5 100644
--- a/include/linux/pgalloc.h
+++ b/include/linux/pgalloc.h
@@ -5,20 +5,25 @@
 #include <linux/pgtable.h>
 #include <asm/pgalloc.h>
 
-static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
-				       p4d_t *p4d)
-{
-	pgd_populate(&init_mm, pgd, p4d);
-	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
-		arch_sync_kernel_mappings(addr, addr);
-}
+/*
+ * {pgd,p4d}_populate_kernel() are defined as macros to allow
+ * compile-time optimization based on the configured page table levels.
+ * Without this, linking may fail because callers (e.g., KASAN) may rely
+ * on calls to these functions being optimized away when passing symbols
+ * that exist only for certain page table levels.
+ */
+#define pgd_populate_kernel(addr, pgd, p4d)				\
+	do {								\
+		pgd_populate(&init_mm, pgd, p4d);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
 
-static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
-				       pud_t *pud)
-{
-	p4d_populate(&init_mm, p4d, pud);
-	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
-		arch_sync_kernel_mappings(addr, addr);
-}
+#define p4d_populate_kernel(addr, p4d, pud)				\
+	do {								\
+		p4d_populate(&init_mm, p4d, pud);			\
+		if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+			arch_sync_kernel_mappings(addr, addr);		\
+	} while (0)
 
 #endif /* _LINUX_PGALLOC_H */
-- 
2.43.0


