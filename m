Return-Path: <linux-arch+bounces-10532-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BFEA54401
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 08:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CAB73A806A
	for <lists+linux-arch@lfdr.de>; Thu,  6 Mar 2025 07:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4691DD0E7;
	Thu,  6 Mar 2025 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T2rmMxw2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eAPe2AEJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C74199935;
	Thu,  6 Mar 2025 07:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741247641; cv=fail; b=qJKC2ty9qbwQmFeSAx/o2+RHXp1OK17zgtOHQKSwWHSoexr7n7QEaX+DJrXIRJU9vX3B3p/2f2RN6aayooGyaRQ1GZam6kEwPjh0NDZawjvlL4EpmPkd3IaZXTuws+vYTqOWKE2VvND7LBBArG89sB0hUME/JXmpYGw55CD83pw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741247641; c=relaxed/simple;
	bh=i8rDDO/bEif2AGmfSle/UokQaesglOwlJ8MKYXxauSw=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=REBKB5wADtXFMrZsVnaeT6OVhm5VYmJcMZqcLrDADt8FMN+lCj2Q1/lupY8eVvnfdDtlCWek9Ixdd81ZhX5HijMRMSNkRZ7yYQzOgmu1VCUssGRSm9Ext/hXWMJ+h2iA96LgZ9uP1xAogdiopFTbQoUksYPf/hDnXBUwyPqrwY4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=T2rmMxw2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eAPe2AEJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5261uYha012400;
	Thu, 6 Mar 2025 07:53:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=mAG1q8rDEx52oWFrWv
	YjGoK93be7bfLpO9BR8baJPOQ=; b=T2rmMxw23qClwD3FnmjmsM54aFm6jQJ6dL
	9V84eth/BEz1l8JpktaaqqkyFBoRkmbEnODipe50/E6xlENIwXG5nmUH0i+bjsKK
	NCJMtQfFylILDhjw6xWN/K/FaHawaU53bPxlZXxGJjEfqVMibnNtKP0z07iGEmSg
	hXiLq10onEjWc9/0ocR3n0iVTrQsa12uvSke2xKVNoP/RMYWDIgzRYJLZG3srqzA
	4ybeQ3VZCGGFUDwKwHkh8wlVyyjB9N2TDSeV7z9ijSVI1u+da1tJEO48GD/fVael
	HjUtePhWNlCAPZV4n989zep11buIEbMY+Ge3bRaSgGStBoYVEgdg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453ub79kc5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 07:53:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5266Tm7C022735;
	Thu, 6 Mar 2025 07:53:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rwxnggn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 07:53:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JWXo6PBe4c5MQm13fyueZilz7crMaJgz7pmxqXll5vk+PfY5ph7s/KpZumiOujxHMzItNj/gfCjY/tL0gihnd8tHTHHUJE/TAUomnkNs0EgZQdPm7xRnioonsc3FTKPzEaphhg5S7c6NvufBztWiG5kp/codLE2yNExTdx/ZkTdqXr5jU1SsMVlep0AanRTBokXwABr1kHJ/TwIZdDtmOVr7PRZPHF7PL97/dVtzUWd2IUbDkd4I2xm4Y8AfgpmuHRJ7Wu4/ItmZoX2kn5sLv4ty3bx3NT0yNLN+8dbKEyIPuHvvMs1YP2P09PLG8RWQ3C2sfV8YxI4CPzGfI5v6gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mAG1q8rDEx52oWFrWvYjGoK93be7bfLpO9BR8baJPOQ=;
 b=d8OiWOp5X8cGIHakgG1udwYieJ9bBUmwYsK1vBEUCeIbvLeO7Fvgaq5fC4AKKOkHqBzQAKGjNfFtIhQ+Rs8/R5aba6HtyN6WAZ2xj+K56UEs079pRgz8CCVc5JJqMH8SaTUIwZQpLEBzqynJy4w49SIsukOX284/aXPkaiPKUvFYG2w3kH1FxIg/ICvGoM2RKf6isYsVZBZwk3yoD9S1AN4rcWziC4Pbdg9dISkE2lMktV7v6PpNa0lbPx0ghNDZmh1T0ruRVi/EmAOM819U9MXAh8w56Gx+bCIME2cCxTzkGLS04nU7J+kdQDi4NVAwbJYni6q3XJ5/8GKEdfDBiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mAG1q8rDEx52oWFrWvYjGoK93be7bfLpO9BR8baJPOQ=;
 b=eAPe2AEJPd2wmzZN7DQflMh9RjSJGRj967lDMkzRwMlAr70/OxJyfFqmRRJrXtCsH2IdfiUx10pvEkdPrkTQqEwtT3bQDQfQbovHYRFQWVylNAD8skPBgKE7H7u4MmXf8YiG/ZYDSTgKHDGqykcKD2D8TA/nJ6d9/lCDp3ICUuw=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by BN0PR10MB5208.namprd10.prod.outlook.com (2603:10b6:408:125::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.16; Thu, 6 Mar
 2025 07:53:21 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%2]) with mapi id 15.20.8466.028; Thu, 6 Mar 2025
 07:53:21 +0000
References: <20250203214911.898276-1-ankur.a.arora@oracle.com>
 <20250203214911.898276-2-ankur.a.arora@oracle.com>
 <Z8dRalfxYcJIcLGj@arm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arnd@arndb.de, will@kernel.org, peterz@infradead.org,
        mark.rutland@arm.com, harisokn@amazon.com, cl@gentwo.org,
        memxor@gmail.com, zhenglifeng1@huawei.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: Re: [PATCH 1/4] asm-generic: barrier: Add
 smp_cond_load_relaxed_timewait()
In-reply-to: <Z8dRalfxYcJIcLGj@arm.com>
Date: Wed, 05 Mar 2025 23:53:19 -0800
Message-ID: <87pliusihc.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0133.namprd04.prod.outlook.com
 (2603:10b6:303:84::18) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|BN0PR10MB5208:EE_
X-MS-Office365-Filtering-Correlation-Id: 64d1536d-4fa6-4e5c-e00c-08dd5c83f6e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LoG+5JPGJq1PFCOJUjNSwP3O8jW8p4F6seZUkTtY89ZqhHknuKF37NdwntcD?=
 =?us-ascii?Q?T7PZ4Jsh/PHN845/Wrclzfmut8KiLOTc5VKGlZsXRN5gCQdntDAgVvwHAMsC?=
 =?us-ascii?Q?k7qhzKRglkfOUJwnwI7lFpe8y24UfIiBh1jjkb01goXFTOMScy1U/mwXHJdJ?=
 =?us-ascii?Q?yzQCb64lxCibojfHEgRRiDjqykvbihv2swtUHR3S1SQJmfRZ3HyBomxYq04/?=
 =?us-ascii?Q?HWbu04n3S/oVi0OLhI/s0QRCJDcC5fA6GTrAVPLleXmE1Yx9B6zqEXTsPPRK?=
 =?us-ascii?Q?I/Edi1yh8XEIbV6fvhWwQC98933VsyHlB+c8sxDdwWEilvDsnUpy1rUSMrcH?=
 =?us-ascii?Q?8nEBkPROkiZ8F1NbqyseF5n9D5H1RsfXNb7Sy8333yczAFJPHxOPNQTxkL7Z?=
 =?us-ascii?Q?uXmtXNT35v7bJ0YPyK+Ohv8Z/D8mZ6zFWJFLxN7gBLwVXCPn4Wni23MaEqgc?=
 =?us-ascii?Q?l4q7ftI4gBZdK8cF2ZqInkDR1t4WAV6A9yBl+8L69UrIO3CwIlqEiX9VkRyk?=
 =?us-ascii?Q?QybrMGnJtnR84vEO+CuPa4gcAoDR+bbkDakkaXNes9lzee59k6Jfsz0zuLdU?=
 =?us-ascii?Q?fpwzolQC3mbxNiYdusQkKS/WV2EnBiO33CiUHiYnuF66dgleOz2YhhODjKUg?=
 =?us-ascii?Q?0GkQHvMN1DTQXNobcMqBQnCZ5dy62uL59SN276JXLB60sH1Kqc/Wi+4rSjwG?=
 =?us-ascii?Q?bz3QQlRnsnExPSYptkLVXhV8bD4xaqlGITsJUiIW64B/9Mm4g4fzgmA85+iG?=
 =?us-ascii?Q?InsNsUbZa5cEz6JVF5PbuQqAmr4H8+5NZgKFKlGNCGGoZXBZojdCIfDZ3bSW?=
 =?us-ascii?Q?kdFcXn+DrRZqPnDzp364lrG7/BPcmHGbELAk3G+m+yZBT8APEBBAi3JspEkJ?=
 =?us-ascii?Q?S+JX6kGY46hmjTYVYzAxqGH/3HzfyAsf813R3nGWpoOAJb4JWhPJtXbkBNIV?=
 =?us-ascii?Q?fFTeuBdn03a5ltPDvQ+7Lw2K6DSbwMIRj3d/Ky8kPH47M32XByy0j3fPWA/j?=
 =?us-ascii?Q?To7XV3kVPlDsXaKrHrSTNA6faOXTT4h5LC3c4K5v6p3BcI5e5WwL/3nNOLdH?=
 =?us-ascii?Q?hZ7dQgcaSgZv3DaC+XIzkM2ctadsQhvsVdKztj6H5Rb33w/KVb3tviogbdX8?=
 =?us-ascii?Q?3wzF7QaihBBk5yG8QrMKUIRXW1iKM1wxKz0EsUwytUrExvJ9RJLPKR69fwR+?=
 =?us-ascii?Q?jVXDmfh0U9rzG4aBxjhMg2yqV+A7iQRctoxn53eShvGzy2ulSwnY/6XGGIPf?=
 =?us-ascii?Q?zt9jywS5wZoqKHS14y2X82qixwq9UuRFF2GGjmYJEC0aCrA+l6kA/0Rq6jlL?=
 =?us-ascii?Q?t42YLznrCTeeswcONPdof3hkT3Xi4VZK0PS1dH/HkRUwRc1C6Ipw33JpeKqA?=
 =?us-ascii?Q?XEylTIYsEbaoU0fsgeegfr+aGJ5N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ej813ROkVAVVCjOL92JHiLb00TiHPXukIN4dbmnT2o+0p7U8eBy1sfvoPShH?=
 =?us-ascii?Q?wDEMaT4NCe2f//rMUBFFLX7rX/xZWs18XpUwm1HkxJE4lgpXl0la+y/i45eW?=
 =?us-ascii?Q?Q9BBMGh3wwj8VliQwUDrFZCDMl1lHws30X4eYLSVG5dEquiq9zRv/sFNYrQ2?=
 =?us-ascii?Q?u5TODpeRvjESu2PcFXEQshjEjW9wfsiwADrTpztJOsGox7GAS/fdS4sL0gVR?=
 =?us-ascii?Q?NBd3XjjoPDf3hMjHNajJp/d5n9KI8kOQyuWr3qBi8yfVujWMLVUppGiMrN+l?=
 =?us-ascii?Q?n9u6zztVVZnOlW1BqHvtMDjR4liP4goFXgsLmjCsHWPntbQEUHgCnv7F3XPT?=
 =?us-ascii?Q?fVkZJ7vTUjTUtVGe1LYj2T2hG7pvkyO0bnTS7JEc01BQG+oFa1iMl/vZ7VqP?=
 =?us-ascii?Q?k9ccCKpUXhqAKKs/RQsIjGHkjH8MdZOiMsaeDnKc0eJ3H8CUZRubK5MF4RiE?=
 =?us-ascii?Q?Xj1GQefEgJjWFktfy0MZyh/6BnJBU0lPYUDio+EyhtjX/3nzCcNCTzfmWTi9?=
 =?us-ascii?Q?leyzGg4b3vUr/isZUZYY1YAK5veNzMEkV0CTJ0bK82iYv0s1D9meIYnGfWvl?=
 =?us-ascii?Q?YZHFenF7vrY4AE3Q/vlpGYu1xFN2jQEnaZGowQUxKX2wvd+AAAhNMyqS/Ayk?=
 =?us-ascii?Q?j/hPYy9qsjnl8lmwaUFlzAb3I3CMnDxFqq0njm5af8bzR9cCSc4UEbx/Cr6P?=
 =?us-ascii?Q?ctHMd3iwVm8ZotqkYiLx0NFMcCzqFayGvAonClzQ/egXH3zrSF4fHP7cPl65?=
 =?us-ascii?Q?M6cABT4PGFXaobLqvepicG7rg9+z9fltEpW99NK28wu4b9UtKqJbZnQjEMQ7?=
 =?us-ascii?Q?oa+xBYesZkuIdl0N8dGisnqNH1jInnaBTdvDnXgV3L8uCrHVbju0QRkHZ4Y2?=
 =?us-ascii?Q?Zxm+JstGb+4dZiv7ev44D3BDiV1C2eO7SKIjSRwHzfRLGgvL6jIaTk8hg6qb?=
 =?us-ascii?Q?AnPkntBW36h6TTRm3D9lmNxF8izKExCyqzAkab+yhuB5jfzzh3XtW7bphwb8?=
 =?us-ascii?Q?lvYLgcjYdV1lCZW4btA5e80RKn+Ur7DUnxsW79Eo0Z4VI3uP0wrcvcVaUNkX?=
 =?us-ascii?Q?7EJFoE5ltxnecFbrqRuN8sknzvUr9NB0nZMyaPwsclzVKsBQ9use+COpGHkf?=
 =?us-ascii?Q?WU/XmdgKKVgL+mc4RLlT2e3DQ1fc4zm/1bBb0Js0i6dgXIb15pOo914FIrLn?=
 =?us-ascii?Q?bZ7tO1s2Z8wvoq6M78aQgGNWF5WARNLPWiwvc5McA2FK/A4KkSf4sARVYvRV?=
 =?us-ascii?Q?qPjwt6WUsdm2nvUcePZVVsEQZW6cCOqP7bLRo5Liaq6jyHQnRooqnUCR4aNm?=
 =?us-ascii?Q?Ucypw+UwMC4+khXQtZIvasNGaVG8/sr9+a8u0JKkxiuaKoUCNidKtfetWxnz?=
 =?us-ascii?Q?AG0zBEvC9sXlH4ETu4cePgeZkA58rdDrysxL5R8avnrz9MQ0R684oH1pd43E?=
 =?us-ascii?Q?5Y7pDJFjMyXMB8bHfxClepM2Vuto+yKb6BPX8EDlptQt+A+KATuk91XOJIGt?=
 =?us-ascii?Q?iP+g+oAlnsw0USm1BUPO7WfSM4nkm1FrSFEsg+GwQ1v3FpFcLGYEz/zsPwFV?=
 =?us-ascii?Q?wHKrt4i8tzPWpqUQM2aQmIf/e9nM39nTzfy4bquafXs54yXRdJ6/Mo1jiXG7?=
 =?us-ascii?Q?UA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	q0jtyjxTbxmIj/JJwve8pjvnKPvTmgB+94h/J6Yy0XotxplQb3LMhb1+jsbFQ+FgRnEYC54QvuqWgePKKaUW0y4iTEzF5KlIKrUUjyTC664FZ8bJfMJvwCBL2emzinDwhRyr8JuwLyEnHN5i85EkcHiiy1mRks8JSpqXVplvGkmGqGd2ON5FPdyWwwcHDskJmjS8NFdOKD96VvcTip0IbU+5EcYLeMTrTienTFRXaRK1EQl32GrQOl0wxr1SX9eaBHypO38Ez5k2NhI7tzQ1uFZd8Hod9P0g7BfgqO0cgK6yTkzyG6Sv9qkPDuSShT6XA0R9F4WM3ad6C+gC2ZdG/GzdAe5uYcLj5WrrLYv6O/mY+jObFZAzvBur+2/dirK85dAUH5Aele85kiVsSOZMXfWXVOWjCQ97DZA3qSuoRvCRT7hNxdQ+kPv23izWt+XjzdhiJicgBH8zpSY3HE7Dd/I0+hSoB0Vz1nNEG1pO7FGOy+tELPMuPQeZMcSN4TKQcatrrtXJs3xdUecMLWqDNMKB6B+sw1SqIQro/5W3fjFQnGphn80badQGNcP1buPXF5xXuVw75GcSpc9fuwbGhmYfaHeKJfgNDAqY81NuW50=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64d1536d-4fa6-4e5c-e00c-08dd5c83f6e2
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 07:53:21.1244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLzpZqk9LzqPk60y+wtX8KmjlGWfU6ApB540bDNKgdKU1zBRaBegnYlK6q6r8LVqgdECX0Kj1uMqr+HVAOp+0YfICa2Bi4BPJDdeXewnYOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5208
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_03,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 bulkscore=0 adultscore=0 suspectscore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503060058
X-Proofpoint-GUID: GaJItfa_b-kC-6LrCSEWY2McAultt2Ic
X-Proofpoint-ORIG-GUID: GaJItfa_b-kC-6LrCSEWY2McAultt2Ic


Catalin Marinas <catalin.marinas@arm.com> writes:

> On Mon, Feb 03, 2025 at 01:49:08PM -0800, Ankur Arora wrote:
>> Add smp_cond_load_relaxed_timewait(), a timed variant of
>> smp_cond_load_relaxed(). This is useful for cases where we want to
>> wait on a conditional variable but don't want to wait indefinitely.
>
> Bikeshedding: why not "timeout" rather than "timewait"?

Well my reasons, such as they are, also involved a fair amount of bikeshedding:

 - timewait and spinwait have same length names which just minimized all
   the indentation issues.
 - timeout seems to suggest a timing mechanism of some kind.

>> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
>> index d4f581c1e21d..31de8ed2a05e 100644
>> --- a/include/asm-generic/barrier.h
>> +++ b/include/asm-generic/barrier.h
>> @@ -273,6 +273,54 @@ do {									\
>>  })
>>  #endif
>>
>> +#ifndef smp_cond_time_check_count
>> +/*
>> + * Limit how often smp_cond_load_relaxed_timewait() evaluates time_expr_ns.
>> + * This helps reduce the number of instructions executed while spin-waiting.
>> + */
>> +#define smp_cond_time_check_count	200
>> +#endif
>
> While this was indeed added to the poll_idle() loop, it feels completely
> random in a generic implementation. It's highly dependent on the
> time_expr_ns passed.

I agree about this feeling quite out of place. For one thing, this is
exposed unnecessarily to the arch code.

> Can the caller not move the loop in time_expr_ns
> before invoking this macro?

You mean add a loop count conditional of some kind in the time_cond_expr?

Might need to change the direction of some of the checks, but let me
play with that. (The one below won't work.)

Even if we could do that though, it seems that how often the time-check
is done should be an internal detail of the interface. Seems ugly to expose
this to the caller:

    flags = smp_cond_load_relaxed_timewait(&current_thread_info()->flags,
                                           (VAL & _TIF_NEED_RESCHED),
                                           (count++ % POLL_IDLE_RELAX_COUNT) ||
                                           (local_clock_noinstr() >= time_limit)));

(Anyway more on this below.)

>> +
>> +/**
>> + * smp_cond_load_relaxed_timewait() - (Spin) wait for cond with no ordering
>> + * guarantees until a timeout expires.
>> + * @ptr: pointer to the variable to wait on
>> + * @cond: boolean expression to wait for
>> + * @time_expr_ns: evaluates to the current time
>> + * @time_limit_ns: compared against time_expr_ns
>> + *
>> + * Equivalent to using READ_ONCE() on the condition variable.
>> + *
>> + * Note that the time check in time_expr_ns can be synchronous or
>> + * asynchronous.
>> + * In the generic version the check is synchronous but kept coarse
>> + * to minimize instructions executed while spin-waiting.
>> + */
>
> Not sure exactly what synchronous vs asynchronous here mean. I see the
> latter more like an interrupt. I guess what you have in mind is the WFE
> wakeup events on arm64, though they don't interrupt the instruction
> flow. I'd not bother specifying this at all.

Yeah, with fresh eyes this feels quite unnecessary.

 In the generic version the time check is done in the loop but kept coarse
 to minimize instructions executed while spin-waiting. Architecture code
 might implement this without spin-waiting.

>> +#ifndef __smp_cond_load_relaxed_spinwait
>> +#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_expr_ns,	\
>> +					 time_limit_ns) ({		\
>> +	typeof(ptr) __PTR = (ptr);					\
>> +	__unqual_scalar_typeof(*ptr) VAL;				\
>> +	unsigned int __count = 0;					\
>> +	for (;;) {							\
>> +		VAL = READ_ONCE(*__PTR);				\
>> +		if (cond_expr)						\
>> +			break;						\
>> +		cpu_relax();						\
>> +		if (__count++ < smp_cond_time_check_count)		\
>> +			continue;					\
>> +		if ((time_expr_ns) >= (time_limit_ns))			\
>> +			break;						\
>> +		__count = 0;						\
>> +	}								\
>> +	(typeof(*ptr))VAL;						\
>> +})
>> +#endif
>> +
>> +#ifndef smp_cond_load_relaxed_timewait
>> +#define smp_cond_load_relaxed_timewait  __smp_cond_load_relaxed_spinwait
>> +#endif
>
> What I don't particularly like about this interface is (1) no idea of
> what time granularity it offers, how much it can slip past the deadline,
> even though there's some nanoseconds implied and

So, one problem with that is that the time granularity probably varies
wildly with the implementation and some don't have a clear idea
of the granularity at all:

- generic version (x86): does not have a well defined granularity. The
  assumption is that calling cpu_relax() is "fast" but at least for how
  it is used via poll_idle(), each iteration is at least around 2k-4k
  cycles. (Also depends on the particular CPU model.)

- arm64 WFE version: well defined, potentially query-able granularity
  (say 100us)

- a future arm64 WFET version: similar to the WFE version with a
  smaller granularity.

- generic code: arm64 fallback: granularity not well defined. For
  implementations that implement YIELD as NOP, it's probably
  extremely fast and hot.

> (2) time_expr_ns leaves
> the caller to figure out why time function to use for tracking the time.
> Well, I can be ok with (2) if we make it a bit more generic.

> The way it is written, I guess the type of the time expression and limit
> no longer matters as long as you can compare them. The naming implies
> nanoseconds but we don't have such precision, especially with the WFE
> implementation for arm64. We could add a slack range argument like the
> delta_ns for some of the hrtimer API and let the arch code decide
> whether to honour it.

Yeah and as you say, none of the code actually cares for the unit so
that _ns stuff is unnecessary.

> What about we drop the time_limit_ns and build it into the time_expr_ns
> as a 'time_cond' argument? The latter would return the result of some
> comparison and the loop bails out if true.

Yeah the interface can't actually do anything with the time_expr_ns and
time_limit_ns anyway so just using a combined time_cond seems like a good
idea.

But more below.

> An additional argument would
> be the minimum granularity for checking the time_cond and the arch code
> may decide to fall back to busy loops if the granularity is larger than
> what the caller required.

As you mention mention, there are two problems with the time-check:
constraints on how much it can overflow and how much tardiness we can
bring to bear on the actual evaluation of the presumed expensive
time-check (the smp_cond_time_check_count).

Both of these are conceptually related but the first one only really
applies to WFE like implementations, and the second only to spinning
implementations.

I think some kind of a granularity parameter might help with both of
these.

Taking a step back, we have the following time related parameters:

  1. time_expr
  2. time_limit

Or (1) and (2) combined via time_cond.

And, these are some different ways to put constraints on the time-check:

  3. time_slack: int, representing some kind of percentage/order etc limiting
     value for the overflow. This needs a visible value for (2).

  4. time_check_coarse: bool, representing coarse or fine.
  5. time_granularity: int, specifying the granularity (say
     1/10/100/1000 us) the caller wants.

     This allows the caller to dynamically choose a particular value
     based on (2). poll_idle(), for instance, would evaluate
     cpuidle_poll_time() to decide what value to use.

IMO (3), and (5) both have too much precision that neither of the known
users seem to need:
 - poll_idle(): the only thing waiting for it on the other side of an
   expired timeout is that it goes to a deeper idle state. So, it should
   be fine to be a bit late.

 - resilient spinlock timeout: current timeout value is 0.25s
   (RES_DEF_TIMEOUT [1]) which is pretty large.

So, instead it might be enough for the users to just specify what kind
of timeout or time-check they want (specifying coarse/fine via (4)) and
let the interface use that to handle its overflow and the tardiness
constraints.

With that the generic version could be:

#define __smp_cond_load_relaxed_spinwait(ptr, cond_expr, time_cond,     \
                                         time_check_coarse) ({          \
        typeof(ptr) __PTR = (ptr);                                      \
        __unqual_scalar_typeof(*ptr) VAL;                               \
        unsigned int __count = 0;                                       \
        unsigned int __time_check_count = 200;                          \
                                                                        \
        if (!time_check_coarse)                                         \
                __time_check_count /= 4;                                \
                                                                        \
        for (;;) {                                                      \
                VAL = READ_ONCE(*__PTR);                                \
                if (cond_expr)                                          \
                        break;                                          \
                cpu_relax();                                            \
                if (__count++ < __time_check_count)                     \
                        continue;                                       \
                if (time_cond)                                          \
                        break;                                          \
                __count = 0;                                            \
        }                                                               \
        (typeof(*ptr))VAL;                                              \
})

(The constant is still arbitrary, but it seems to fit in the broad
coarse/fine outlines.)

And the arm64 version:

#define smp_cond_load_relaxed_timewait(ptr, cond_expr,                  \
                                       time_cond, time_check_coarse)    \
({                                                                      \
        __unqual_scalar_typeof(*ptr) _val;                              \
        bool __wfe = arch_timer_evtstrm_available();                    \
                                                                        \
        if (time_check_coarse && __wfe)                                 \
                _val = __smp_cond_load_relaxed_timewait(ptr, cond_expr, \
                                                        time_cond);     \
        else                                                            \
                _val = __smp_cond_load_relaxed_spinwait(ptr, cond_expr, \
                                                        time_cond,      \
                                                        time_check_coarse); \
        (typeof(*ptr))_val;                                             \
})


What do you think?

Oh and thanks for the very helpful review!

[1] https://lore.kernel.org/lkml/20250303152305.3195648-8-memxor@gmail.com/

--
ankur

