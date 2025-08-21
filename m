Return-Path: <linux-arch+bounces-13242-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C13BB2F58B
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 12:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 386301CC5B43
	for <lists+linux-arch@lfdr.de>; Thu, 21 Aug 2025 10:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6723054E7;
	Thu, 21 Aug 2025 10:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DVGitcY2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pkIx3piU"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03892DC331;
	Thu, 21 Aug 2025 10:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773013; cv=fail; b=XAYDDMImJKNI+g8pJr5uBAN1ZuTVA9zH48F20HRm/2weqt8H1DCwVWXp6d5yEaCa2QGo9R2wlmzCq5lC3cOgj/fVGvdg4vGikjMOTV3EgrR7QCGY4tybjwUwsRcAJwwch5NZo3Gdhj/K55RVtmI4Dn03Vmtucy6/peHFFt6sqH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773013; c=relaxed/simple;
	bh=3346qz031nNHv4gW/5f38efcoooQnp6TzeAbASOd2kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Z8KDT1BjEapfHoxhw+9LqgnBkgBdnbj4gywDupFSxCgdkgL1gKcaaXfoRc3+7SwMhb4sotnmqZZjU6wvOqGeuXGNUTvgW4AkftzatVhfTX5D59xYZpIesrjQqfjVMYiSG/1OW+A0dSKP/y6EobQ7Yl7+goHcED7cpfg+RvsYx2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DVGitcY2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pkIx3piU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LADwBv020936;
	Thu, 21 Aug 2025 10:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=lvIWjN0Ptv5b3e1rsw
	oQ1CELNFbB5rggsoxca/YjaH4=; b=DVGitcY24X/PM2WDJ2o57hhU2PFuFo7vbt
	MfkV49qQ51CYTn0MViXgbtNl4NlbpATwXbFspColvBPae4vKAJlYbQOqwUj91ymK
	+mjvzwN/yn/xGEyd4BFaVQKJFZXoqeWSwCXV4cYgRhPOUfWIJNYrcs3JDfzW1Os9
	Kw8NxV6CrUnrBiU3qltb1aZieLjgGGCd+75qkYkPQtN++Mcj9Pt9C2VFQulNwVEv
	0K+6t+iCUqhYjZHLnaihoicKfJNFkD0ouBOgcXaL0wXuTRd/9Mw8Da657iL4676H
	ZIBGUSawVYvaT1FEpJ8lcoA3XVwFhgiMdqjKe8vzWMvhQublYVNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsu63d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:42:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LA5cdM039607;
	Thu, 21 Aug 2025 10:42:28 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48my3rx34a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 10:42:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUlll/xmi+rNB/EciAadeTQ5Jo6RsqwJoBerWGOdhSzIxWoyGpcCt6AmiCgIsAJmnFAcERaOS1p/kgga8p3eho3tfitZIrHL9Xo6v/xrf/BQhLR9aWFf0uJAJgZ0Y6c1WL+k+LCSCYSFg+gWz56YVOVEr3+Ez39f7ldVZXN88xKDUuzm6SElMY0kW608lvxxNjGFdEHGo2395Md9JKGV2N9NqXHnG9kG6HlLgdoHDGRbn9vCg/qrTuXZ6DnDEueBW2Hfy/FJb5bqUVIG/ngF6Ui7hZqsWCu//07WLQSKw3ozhqoZoYQwJPTacxpk9YK0kRLdR8CwfN9hxo6S2mBJrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvIWjN0Ptv5b3e1rswoQ1CELNFbB5rggsoxca/YjaH4=;
 b=R6tE+sG/EeGN8NNSqLmEIVeb/kleUvgboPVufm3HSP5TAQ0Tgih5U32cGt70ytt9IaGakLLYFzbWW9u1dC2ZX70tboWTDN/gInQiy/dIK1wz5CzB1Li374teccPU79LakNqpUR/WmG2FevoZg5Cht+dXq17mfJ3YtzD6N2YC8Bs1FbmweyqtMRVI0s7uznL6xYEfHWTPPqlqcqrE9rxWMp+UU3hMk32VS1mmcENcBpow58FYxTVg2N+gR5K4m2pEVG/gjbWbSL5YS0NhFjwfFtSi9xbFoGyyjfGfDBUmOMqT89gy+VXs8MHeq1gB4lZYAIhoCDvIXcLwOaF0FfUKlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvIWjN0Ptv5b3e1rswoQ1CELNFbB5rggsoxca/YjaH4=;
 b=pkIx3piU1vyPj+Km0LI6rnfvLv4WILGYlNw63x3oG0CS4jmWnclV2fY5aTAWSR6i0iGnZCYuwi02UQ7f5aMCH9hfWzUdrW79L8hQ2mm40Gw5sV6BR+lPDA59aZoFXwDI/Wt8OLSxYZDrIpOqImcQViStkiiKYBJoR5Zd7x7w45k=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7574.namprd10.prod.outlook.com (2603:10b6:610:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 10:42:25 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.024; Thu, 21 Aug 2025
 10:42:23 +0000
Date: Thu, 21 Aug 2025 19:42:06 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, luto@kernel.org,
        maobibo@loongson.cn, mhocko@suse.com, mingo@redhat.com,
        osalvador@suse.de, peterx@redhat.com, peterz@infradead.org,
        rppt@kernel.org, ryabinin.a.a@gmail.com, ryan.roberts@arm.com,
        stable@vger.kernel.org, surenb@google.com, tglx@linutronix.de,
        thuth@redhat.com, tj@kernel.org, urezki@gmail.com, vbabka@suse.cz,
        vincenzo.frascino@arm.com, x86@kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <aKb3_jilvwq_gOkf@hyeyoo>
References: <20250818020206.4517-3-harry.yoo@oracle.com>
 <20250821093542.37844-1-harry.yoo@oracle.com>
 <60f006dd-3bdc-4418-b996-e1d31ec0eded@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60f006dd-3bdc-4418-b996-e1d31ec0eded@lucifer.local>
X-ClientProxiedBy: SEWP216CA0069.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b05e9be-4a44-49a0-d6df-08dde09f69cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HR+IZdOJ7J3mxz1Im9s6HrBJR7sgxd8CEbyXrVlQwYfoZh0lUa0OoNlhsZ0v?=
 =?us-ascii?Q?zLf77bZ6vJkL1OF/JOcdGmz5HKeflJqvyL0eSKkXNRQYzFePdqNX4/Q1XhZH?=
 =?us-ascii?Q?kMren7dlwNqOiaR+AuJMAULmKj0P+ICrVvtHewR2v2SheVLlUqQ9uwpYkip+?=
 =?us-ascii?Q?McoXgi1um9V68YZb3wqoh0vGo69/3cNZrndwbrx7YYOM78l0Nfh4xEh4CSPw?=
 =?us-ascii?Q?aEJR+e20Z/R5+NvE2NOg29L5hq4c+H56FhEAu1xlfKuco91W5YXhNRLaRgR/?=
 =?us-ascii?Q?rVi5M67OdTR8zOQvLKaTl53w5zilfgsJvFPi6MyWXvKRUBGXQxjXwi6C4Ozp?=
 =?us-ascii?Q?DkYlxS+VvtxJ9+k6I7/3OmV1LNtSFOoVUkK+gfqSllgOutpXv9PUC6V6lO1S?=
 =?us-ascii?Q?vR2cJwlSoYdllbQCCigGYcbKDe5w5ykqpl3eQPZuSIfN6LiNcaXnXt3UCb3u?=
 =?us-ascii?Q?EI3qhXvoZfJNi6eb0DL5STRJCuPKqWCvhzlDCB575+/DGp14iVvZAAeTdaai?=
 =?us-ascii?Q?hT09SiuhdLr6reL54ob9KW5/wVtx+e8qNthmVQoEqOuySbCXkrxcus5q+kVh?=
 =?us-ascii?Q?DXymLITsFTJlxLuZmqhjYgZ1t30NkZfhBNUJxlPWu3GiC12uuPX0hgOiy2Yc?=
 =?us-ascii?Q?fkf+IRIZSfwZGoUrt6dJYRgFT668iow/6hGuR4lXMgOrzeRtLc3PdB736SdC?=
 =?us-ascii?Q?1Fqq4SYVHQWCrUJm94KUk9oKC5Z4XeNyC0zrMpE8cih9CDRqKLHh2+WkCRPs?=
 =?us-ascii?Q?EOHvlGUgmExf+c1W486py7518/5+TCnecQbLGihmXNKfjSoM1aHfMFX7CzIA?=
 =?us-ascii?Q?Ltsjx1ldxJwZEeFnCX0l6uhYGzQZjWohUAQJx0bugkfvD68a/8ZNADHA8kSk?=
 =?us-ascii?Q?UxPxCqBDvzw3W3rosl+q+VX3oKbc8UnpmTZWDVFeNd1yAYdlGuEgIq7QJHyM?=
 =?us-ascii?Q?NFAEXTI4A7rME1k7CoMyhChIRIliMMnCUoRvXxpmiypGAzT7zs5b3QNUoLjA?=
 =?us-ascii?Q?BBQqfLwrqWqQ598XHrxFsCG7tnH/0PNTKiz0ZakCCd52ePpWbGEi3441nYUE?=
 =?us-ascii?Q?tYGFl9UxRPLhKMRyl2QZ+wj5bECyhhjDzOyauBH3vJ+LE0pdOtvjQZNv0Jl8?=
 =?us-ascii?Q?0xpIGqLA6L8ZQWZdV6I81eiCgXMeGMWSGbjCRDZ+faKk4qZENyfccy8mKYmK?=
 =?us-ascii?Q?ZcsuBgX5utMtub409vsPVdshQbHjNMmsra+Me3utAz+b7ImfgeGFCANzLmWn?=
 =?us-ascii?Q?osVBYyyDymE1Uw3rBExtZyR7z7A7VjiYZzbL+xhLkfGQsrD4xMm3BHJl5LKr?=
 =?us-ascii?Q?vTug+pHw766/XTezGtvQb0bTx6ktCPs+dO2wrszJ77GZb++FEmzu5BNqHaU/?=
 =?us-ascii?Q?k9TwL5MufwQ6JuGxTpXQj1ZmQ5GVrk01wntLRT9WFGiQ2jygUZJshK+r19mh?=
 =?us-ascii?Q?gBYm+ikGl5o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0kv+bMVCnTjO39JIiqydJEgJCxW0nh2e/z8uqjgLTFwoa9LMP5FaKOmoZ/8t?=
 =?us-ascii?Q?osxxPqD7N2fCxKYyzE9BHLpIPWStpPt7hkEptDT2BVV5o1NNp4aLOFj6YCcC?=
 =?us-ascii?Q?5pwl+fFgagReAF1GdxUsgJNP5HIH63LGLaW60XlK4jfgjK4z9OCHNTyltOWI?=
 =?us-ascii?Q?to/xuFrxA7hIYtsHjEozekBe+rVkxHBFPOcJ/66Bz59V413RxpDWgLdiSCoN?=
 =?us-ascii?Q?Xzb846Ro6DxqFpQ4eYqufTjcf9HjcMy0vxrBnYvmCAKAdWwZFOpQvg3i64GL?=
 =?us-ascii?Q?hD/P+TnDqLioFkUztGGFREHZAD/rSXPJSqVMHeI0wbqxTiDs13LikH/aakEs?=
 =?us-ascii?Q?1Nap8y49bRtaz2TRzDO3rgsoPmy0zi1Udgp3Vlw1J4QPrfSbN9/fmXxSKw3/?=
 =?us-ascii?Q?Ihr4+lXWgxcYfP5JFw/VWiHW8Quch/ep3MCPsZGUsynWbwwmH21B9JNk1m0B?=
 =?us-ascii?Q?/092eyyhXWguqsXf3u6aHJKxxi5GGnzjhu4twp9hcsxS3w3AEzN7DZYa5/eQ?=
 =?us-ascii?Q?o6wrUcB2mrstvMvNhn+QQ7397ip69lDmMS0lonEGD71tnhftj3cGDJNB4thS?=
 =?us-ascii?Q?w50cDUX0je43UTNTRWf0B7dLrO8/4ujQ9V+uNRkRU4vw9ENGZVxJamgm3TlJ?=
 =?us-ascii?Q?Sen1QP5AB7QuRAlwX+vfdpQs2fSZO2Xh2XsqLFHH35WLOE6xdhWeiDGabJgm?=
 =?us-ascii?Q?pSwU2p2rw2sPWP5torCMAECff53v3ada7OSn/I/Iw/JhFUMRzS+zVRlMPjEt?=
 =?us-ascii?Q?1g9gTuCBsv2Qw52gNcFvytpnCSOCbRhJYXueN9W5Q3pth6wqLT68qRWcekzj?=
 =?us-ascii?Q?nfgzAX/jBuhYJOGzNCDzR6H89lgFmAo7UnbNI+L6LqWFjQPZUGRSkGfREXAO?=
 =?us-ascii?Q?UY8ZY+3/UaReko7/YpqrrjzEV+1l640E2/DSY+W5+4IpHmTXRtPiYBOJHIUy?=
 =?us-ascii?Q?/wIWk73vmQneNkvvg9o5KbrzhPX6+Qx1gle8Uf1eij/hwrOUcSzoiwbiPv05?=
 =?us-ascii?Q?mcZiqEC68Ac28n0/Xl28GLF6qxDdg41yljgI9YY2gA5ko8X5zSsbgiUagHcp?=
 =?us-ascii?Q?FrNrcumyHhAcU28sOSR/vRJQCXjrT/HGJZn8io79eANI9KMEIAhfeFV4XFu+?=
 =?us-ascii?Q?kzLon1pNWw0VIB9IWEMsA5UOGqJHUCK2LMlzTjbOGVb48cLyh/vFWmiGI1AS?=
 =?us-ascii?Q?2OC12ay0N/hRhZb+YepEB4M6M+pICxsCl59fULPjXi5+FOLf7mhrmsIcaiyn?=
 =?us-ascii?Q?aiDZ1ckBPdGeTG7grMPrP6ZWJTs9hX7jbLNYdwSqFxfXO3dvi3YqkeUVNeKt?=
 =?us-ascii?Q?wVtWo/nTQMpXDWCc90Clddxl68kHWCoh5FPrZNyc2vvsIZFADhk8dM0X24u4?=
 =?us-ascii?Q?KIAq0xSLNhdffmfuV11eJeXhV55o8MlIL6P2+2Rjjs6Y8QEoAGuhYuZNaMrh?=
 =?us-ascii?Q?Ro0HmrsfbL0dvNbBk+P8RWFrENfGdJUfrCJcQbuOkGRc2cTHero0ZAbPkf8J?=
 =?us-ascii?Q?6i8Uu+BDSF7YW1TT6K7pq6WxUkX217v4dJHmcRu4U+nS+khtKK/W1EjHTryk?=
 =?us-ascii?Q?BkhugXWrxoDyGSZi58T4UeZjgzoHSy/SM99ApWk8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hDNif40pybmsvFe27bURy4XPmk3XuvAVmAjbX+D3nS/3Lc7pKnGFKA6Tm5w+Ktc2ob+9AAQ7bO0KDw15mfbIgl2DD+pXz0Gx2K9utUMWPsWOgLpPTj8v6KzFgxV32k+94XvkM2oiIGwulOVLDvpwJP28+2FhfO78oX/5AF43mz07gjffkWT/Oko2NK9rLGiS6y+CsgYD6FjbOySUNty2Aummll3/+ZO7fp1/G3tbqKIHzMEMlbUr95TALsZpVlzx7hJkS9X3QAKQqtKQ1GtX+efDH4q9JeWpDbDWTY8D3krANh5HkIblsFySitIiuSjXUs4dIHmHmcj8RbMc1B3Xy4jbv48Y587bauoAk1RDSJpm+aOLDi8RBsx9ebyeyJIY7uyCd0JNwlH0bNL2ef9tnjFYaiTWXEeoJexJxixgQAS0bOihaS/J6WiPmxaq8ujN9moWmgyabKgBZ1YJQ+YSS6jHnU2A5eXGNw4Qh9dfKfsBZPctOkJHHVDm7QMKEH1BBYYt5v1RkyiX77i3Exsm/1gtzTev5JWlzUgG6dyMPXbcmtVZf5Q6NG5tRh6R+smsal6/1NOqX5rqlXTD97Rnz0Cv3+/fbMCey1UBl8izIZw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b05e9be-4a44-49a0-d6df-08dde09f69cb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 10:42:23.7267
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5dEDPfuGqHJzyx52LFsfGmtNd6neeGNBsJKXKDPlq3ynSuc4BQiouSaX8k/Sfw4vSJIudQEVIM5iDaUoZGmdag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_02,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210084
X-Proofpoint-GUID: iWGwkDwdj3xc4GwNCWw21O66fUSRH1cR
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a6f815 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=MrTRq-uRYnMupzUw9LkA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: iWGwkDwdj3xc4GwNCWw21O66fUSRH1cR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX3CIlOTkJke+K
 sgR8KlH1yDYnCbctSzn+PWVW3vVspZKOC53nuu0vTKkanFVQGIHlItqHLyizt4ZijZ6X9dsh5E2
 zALQEsHQ2BIe0rHignzkrbXmxHk9bqL1hX8cuM2HT1C39eYpnu5QqGwaeiQzWKjuLIsQb1t8udm
 rjqV5G5CLvJ7XXuaOSo4iEB/UNlSGJapgbC9br6LGirL96nx4O8eYuCacdXNKV2jmISAntU5zCs
 oE57DFAB8//E30y4iy0q0QdnxwgTungld/kMLGjJgdH4UsrFkgd7UvvQBhMCvcSUwihilFSn6Y4
 bGIzqg1opmZPbYv5aaZZChyYPpaWIz21yuIzAKRwK5kGsr7dauFyxFkpQRiend5EIpVghZjKg78
 LxUshqq5Lue9d1sB7brdZDQjGy+Mrg==

On Thu, Aug 21, 2025 at 11:10:39AM +0100, Lorenzo Stoakes wrote:
> On Thu, Aug 21, 2025 at 06:35:42PM +0900, Harry Yoo wrote:
> > KASAN unconditionally references kasan_early_shadow_{p4d,pud}.
> > However, these global variables may not exist depending on the number of
> > page table levels. For example, if CONFIG_PGTABLE_LEVELS=3, both
> > variables do not exist. Although KASAN may refernce non-existent
> > variables, it didn't break builds because calls to {pgd,p4d}_populate()
> > are optimized away at compile time.
> >
> > However, {pgd,p4d}_populate_kernel() is defined as a function regardless
> > of the number of page table levels, so the compiler may not optimize
> > them away. In this case, the following linker error occurs:
> >
> > ld.lld: error: undefined symbol: kasan_early_shadow_p4d
> > >>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
> > >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> > >>> referenced by init.c:260 (/home/hyeyoo/mm-new/mm/kasan/init.c:260)
> > >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> > >>> did you mean: kasan_early_shadow_pmd
> > >>> defined in: vmlinux.a(mm/kasan/init.o)
> >
> > ld.lld: error: undefined symbol: kasan_early_shadow_pud
> > >>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
> > >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> > >>> referenced by init.c:263 (/home/hyeyoo/mm-new/mm/kasan/init.c:263)
> > >>>               mm/kasan/init.o:(kasan_populate_early_shadow) in archive vmlinux.a
> > >>> referenced by init.c:200 (/home/hyeyoo/mm-new/mm/kasan/init.c:200)
> > >>>               mm/kasan/init.o:(zero_p4d_populate) in archive vmlinux.a
> > >>> referenced 1 more times
> >
> > Therefore, to allow calls to {pgd,p4d}_populate_kernel() to be optimized
> > out at compile time, define {pgd,p4d}_populate_kernel() as macros.
> > This way, when pgd_populate() or p4d_populate() are simply empty macros,
> > the corresponding *_populate_kernel() functions can also be optimized
> > away.
> >
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> 
> This looks good, other than the nit below re: a comment, I think when we
> are doing this kind of thing it's necessary to spell out plainly why
> exactly we're doing it because it's not obvious at first glance.

Good point, will do:

/*
 * {pgd,p4d}_populate_kernel() are defined as macros to allow
 * compile-time optimization based on the configured page table levels.
 * Without this, linking may fail because callers (e.g., KASAN) may rely
 * on calls to these functions being optimized away when passing symbols
 * that exist only for certain page table levels.
 */ 

> Anyway have checked locally and all good and LGTM code-wise so aside from
> above:
> 
> Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Thanks!

-- 
Cheers,
Harry / Hyeonggon

