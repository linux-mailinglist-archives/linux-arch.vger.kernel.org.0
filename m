Return-Path: <linux-arch+bounces-8449-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4BC9AC123
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 10:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91BC21C21587
	for <lists+linux-arch@lfdr.de>; Wed, 23 Oct 2024 08:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B2B15747D;
	Wed, 23 Oct 2024 08:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="biEXbJyQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="z3hl7Nte"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B81514FB;
	Wed, 23 Oct 2024 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729671160; cv=fail; b=pu3YlpK64aKL6Lh+OBIgKwbb7J5282aSvK4pFnJ13OuJAc8i0leQ16D9nBiR/yphpmMM3AF/bPg+SI5ylI0RaelS2MAbWNeVkV3mnyROREN3TkY+y3LYTjWDbw8ONrVgenDDWMHhuwj/yN0xaXEykGelvAiy1iOr/62ZmYeLuBY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729671160; c=relaxed/simple;
	bh=5//FkYTP+9pygLrDaXukC5tzqt7uHcAoNFugk32mpBI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ShzmeAN8CzzXOySWjWJkThqUH7N1XQsktBwELT+cYi3EbFKKsaowhXl8OV9y2vaFEqQNP3KIlzZ4vERPXkVcWiqZ924NedqdjqaVShvoWY4IqOcVBsRqD3NtO5obNBa72z10CMEiZqiCP7cg5N7IT62dRqsPvafGTFRmf9Vzr4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=biEXbJyQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=z3hl7Nte; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49N7tkU7015775;
	Wed, 23 Oct 2024 08:11:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=rQKPPuMSL0Tvpl5rZl
	I9zvzpPdw3yr7WrU4sZZtXyPI=; b=biEXbJyQmVY46imve86a94F2Bxc1fgjzdv
	X4q1HBcZ3553ATovQZI5omA9ufrdAnvUARBtmgqkP2rNNP+Z5I8DsmK+20SgLqOg
	L+LosjvqWBRWeX8lWb+FDztceRj8Lnfj7oYm6baH8PG+829pk/bw6H4tsVVuEEbY
	a1JsL5I75q3tPQlUscxdmw3dYNo0/SU+J2yMbE+WYPcj7zkjMQz3dF9T6P+KDmzY
	wdguucLdzBvLcsNSv4AtVVORe619mdoYCmh6ARd4ZlUcac/u+a+8u5u7Fi6PAQM4
	GNmxJmAmn1YcsnNbAyRnuq0NsSzsPy+YNR6PaLO+SN7lI8mjc5ag==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uqgbd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:11:53 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49N6lAbp025445;
	Wed, 23 Oct 2024 08:11:52 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emh971d3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Oct 2024 08:11:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KUFA5gPiGHnh3AvQBDiD4Ai/h1ZamZt1Ms8Qe7t3Liu3XFIWgueZoIpCgoHjop4x5aH24MaAsNimyzBQBXLvgXW6LpDEr5ndZU8DK/RSpBtVA9bx3aNkEqstl01vfx1ZWeMDepxR5EmdRGhA/MoatzG/TCpl8nHzXSBqKuagtkMKK6wYMTjXRsQBCzNqZu7XCsZP4RY7FxXbrsHB/09+kHeLBJO+rmcK76KQX4AReMXvj7YgS0MNWyrnDoIT98MFFtXzbGKrLk8L1n7cvZ7nlShru4IKrO0NLYn5HEqzpx0qqhNxFQuucmRIOeKSYpnXfSuVY64uD885Lr7hru3Bmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rQKPPuMSL0Tvpl5rZlI9zvzpPdw3yr7WrU4sZZtXyPI=;
 b=qdHeIQdWg0A7FT1exOOwCbJAGJmBA0h/M0gt9KNLisgtwBS4ZvFQWGX49u+97L7oQXE8Wdzo3giO3zO3LmnCRKZk7lzhslYd9G9aljDt/U8RUb71xE+4q2OH3Ln7gEDTmBNPVOq5Ph0uYPX/sElPq9FDzfTA66WI4x59oRckdVKKULr32hVULD8JyqLwKwtnf07t5Bo/sCwkQRezIpIgG/1Hdam8AAJcLKaYrsB4JsjtjOABiwaLVsY+HEw5jWE93qSAzsM7F4Vx34GNTBf7uj0Dp1/TKtVaonmolEpPKfSdbeixFcHtmflqSmM9M1ey6vTEaWFEuwOtV/u/tFN0Cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rQKPPuMSL0Tvpl5rZlI9zvzpPdw3yr7WrU4sZZtXyPI=;
 b=z3hl7NteoZkafM+VJet0t30hx5eccIbwHISmDLqkETPO8B7Lls/3IkBarAxM+eGYYHVX/IFv6ueYTPi1MtqcPWirdz8gJ9w64fYWnx71PW0M4nbt63w/sTZ0GiIEUKiMsBl44xv2Rw74MUblZ64ZtjgVYmeZwP5Ozma1a3naiQk=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4701.namprd10.prod.outlook.com (2603:10b6:a03:2dc::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.17; Wed, 23 Oct
 2024 08:11:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Wed, 23 Oct 2024
 08:11:49 +0000
Date: Wed, 23 Oct 2024 09:11:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Dmitry Vyukov <dvyukov@google.com>, fw@deneb.enyo.de,
        James.Bottomley@hansenpartnership.com, Liam.Howlett@oracle.com,
        akpm@linux-foundation.org, arnd@arndb.de, brauner@kernel.org,
        chris@zankel.net, deller@gmx.de, hch@infradead.org,
        ink@jurassic.park.msu.ru, jannh@google.com, jcmvbkbc@gmail.com,
        jeffxu@chromium.org, jhubbard@nvidia.com, linux-alpha@vger.kernel.org,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-mm@kvack.org,
        linux-parisc@vger.kernel.org, mattst88@gmail.com,
        muchun.song@linux.dev, paulmck@kernel.org,
        richard.henderson@linaro.org, shuah@kernel.org,
        sidhartha.kumar@oracle.com, surenb@google.com,
        tsbogend@alpha.franken.de, vbabka@suse.cz, willy@infradead.org,
        elver@google.com, Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2 0/5] implement lightweight guard pages
Message-ID: <5a3d3bc8-60db-46d0-b689-9aeabcdb8eab@lucifer.local>
References: <87a5eysmj1.fsf@mid.deneb.enyo.de>
 <20241023062417.3862170-1-dvyukov@google.com>
 <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8471d7b1-576b-41a6-91fb-1c9baae8c540@redhat.com>
X-ClientProxiedBy: LO4P123CA0604.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:314::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4701:EE_
X-MS-Office365-Filtering-Correlation-Id: 00b1cb1f-47f5-4991-d49a-08dcf33a57f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?HSJC5nuPS9KRVfkxAwlQ4aJkR9dkxeFmt4sYp18V/L6nZI9aba6t6qRL89zI?=
 =?us-ascii?Q?hVvVfwDN6sOSVOMEe0EQBfKqY7PVqCl1VI8QGm2tvuLKk4q7lR42XYM3OZmI?=
 =?us-ascii?Q?pv1ue+cG9MDatbYtIyAaNFq58TVQuZARZR4mWXJ4XA7qE74AMi5ANCGhbo9X?=
 =?us-ascii?Q?prMdeqeEdYFJ+7XeJ7+LB1TEkjaYjKMZxOhlKbo1HGKM7AD/goLhQpH08o9Z?=
 =?us-ascii?Q?Pj7gLv9uZREDNgC1ur8Qv9iYulTHZMWJAFRJTOqIzIkOuMZgvE0yiKnJpZ46?=
 =?us-ascii?Q?WQ/b/pdUuU+txzOQSa0MKjE3BqOZvzBO3Erpb/1pafps1VaBXqAAbUUPW91z?=
 =?us-ascii?Q?HUjpo7QPltHUMCSjPHP9WQvqA0b6Xgm4R7UhCICwQPav0IOUC1MXn0GK/dzs?=
 =?us-ascii?Q?FcAz7Ucq4f2XtuBCexv/svFIkoWuvlxAKB6fbsZ7R+20es6Q072xyXY1WBUl?=
 =?us-ascii?Q?kDWC0KjkhNDvDpizvAQ6yAO6QUww0o34Sap0OST4tKRbWNcul+b0s4M6SLNH?=
 =?us-ascii?Q?vUmDQNxB6PPpRNrdgiD0c5B9Q8EiwKwZImR5sRTQyaMPvd9pza+weurcHDxp?=
 =?us-ascii?Q?zc3umocgHxlMEibP6XiFOAGfHd5SswACRtf38BU4c3skrPrktuem/SN2zul5?=
 =?us-ascii?Q?vzBRFlIbhFb4C11/eK78gKlxkE/9ei17Lie8/Gxlaa0hcRtxr5fmVsg7GJ1C?=
 =?us-ascii?Q?P4KeXW1ymth7xaAm0mI+sodnSWiThFj8LFOcbCFPx7ewhUWeUkm+ihy3Mwf1?=
 =?us-ascii?Q?n5RaGEWGRajhnjbjYmdlmMNCy0Bz7FhxQkfkkqMGrUfpRhGRJvND46pk1HYC?=
 =?us-ascii?Q?JB0XomSwOohEdR/3Lhpcqq4COSyC7TXppuFQVN+QAGfGc89nSLfnkaW7Z9tj?=
 =?us-ascii?Q?oJls3YdDxzMXWdc75raf0Q6Gyz97FXMqQ1yDDfP8LmCS0w4/f3nnuFa/X+vV?=
 =?us-ascii?Q?NcClPEHxkdpbkn+E60hh4VuAoIjsZjfFyDPk52A7pBLs1N+QZ3MYb8I836Ww?=
 =?us-ascii?Q?4Ug61PnC4SeCajlsztcJkQRN1rPavKXpp5M9MJdwbfoFj51cEcVUJTOUQt1w?=
 =?us-ascii?Q?llooytlHaeWh+ro91aUS/Keukf0SjkQwCdn4whMpbZ2pyNKCWi9AtizSJVzW?=
 =?us-ascii?Q?ZHLdbV5FfmlvkTOkEwQpgzljw/OO+r3xb0oDSG1SoJPnawtfyYDJurw13gSp?=
 =?us-ascii?Q?2r/BhrpGazOutUKdA6h+nPYnXwnbr/Zio/yrRwvLJ/UNAkJA6WPp3ok97OvV?=
 =?us-ascii?Q?NBU9Fst8TlMqrbPWshcoT/RRwUAoMnXPDTC3lvj0JnDZiyyqInFirpYH7doy?=
 =?us-ascii?Q?a5BmCGsUayHQNWWn1CpYJjwl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7T9qitm2+4KTxURkTaHwcczIuwBDP4WQGxs3oHdiTYXMzfKv0FHy0uhSor/1?=
 =?us-ascii?Q?IqG1cAsJ6Ti6LQyc9XcWEJHbuC1LRNEAqRGKlRIkTYLa3R813+sxJStu7Jsx?=
 =?us-ascii?Q?OJ6tBDn958UhVyRa5kySXCXXpyV7K2W3tnstNRcU3UioYCf4extPQizDY2SW?=
 =?us-ascii?Q?MAD1AQPe7dWKxkmNrkxk2SDQ66gbwZJxa8wspWgdxmT7agb2wkrUXuC5jjhi?=
 =?us-ascii?Q?zV2svkz2fT0thcdFoY9cza/VjdwtcC2f71Swzx698OcSDkBgA4g1LbRDFhIu?=
 =?us-ascii?Q?Jzu+uRu3dZ9qPegbw8iv9zv3D8oZTKOCOKzAGifMfyu0ioiCwFR2mFVs73so?=
 =?us-ascii?Q?SDTQjkwd3pv6v058xGdN3Yv9PiuD6THd2c6AtFZXnzkudmKGzg5fdEHvTkDn?=
 =?us-ascii?Q?1fPxDwWsZHyFfldUI43mnokIZeWsalczyvLWueDG2Xi3fknklc1WNtPwNOo+?=
 =?us-ascii?Q?xyRYcDjYa9OxUfqQlr4EISJNF3dFy7Pa4RgUrOvK8NjLI9c70Qld+gCOfXgc?=
 =?us-ascii?Q?sV6ZldILilijBiQ2Njmn/uftO0qCOarHxgHD11a4vikT1rsKEHSrpqOi3YEI?=
 =?us-ascii?Q?ind3p4ZSWuSJZR3oo7W7BYyxHf33fIr/Q+P9wEXJEHU0+XGR71LQixfPjNjp?=
 =?us-ascii?Q?jp95T52CzEZVdSdtBBrn+jRdjumBuzALAPXdmRBpWPh+czDqCtaDRHXE1W9S?=
 =?us-ascii?Q?1F+5fqyE53zm5N//AIG9wfie0uL2Drcls5bH/ZFsXpzGVJIAbaMZWM3aPLvI?=
 =?us-ascii?Q?4iJQD8QmuvFgT8zuyRJT68zvsS5ceL96MZPcTARXyq1lZZxq0y73fv1rSSHu?=
 =?us-ascii?Q?Hu+ei7EGyId3jqfSmNhGZL56Ytin2KCQ8pwlxWF2+aau5wdobcUwn2tSWI/S?=
 =?us-ascii?Q?6ENSD1RTK/yrl72NLwuxsdkTf7ic2ow/jPviSBCgbuqSlAo/OiZ6GlMSpV7j?=
 =?us-ascii?Q?cSxpld5HNxVmU3oo62wZn+YxmhJm3y84JCI/jV16YGS8UuBQCrG9g5NhE2Bq?=
 =?us-ascii?Q?mQt1ES4zMoX17HfqDbMmHttnvc6LeGsTV9UnDKn2b4h+uBioIGx+inylWAO1?=
 =?us-ascii?Q?cHTCysjtrUEJIp0gGc1nCCehCkbFrfSQFXMo1QGRfRaleGSlHHyewjSS7Dyp?=
 =?us-ascii?Q?/qvkz7OXzsfwZOc1w3Cc0X4kwDF1XHU2Gr9EkT6cXufE4Q8XvEydgg1khHH2?=
 =?us-ascii?Q?JiT2zVFbZIzLwllCAshciG81HLf8AZ7JPxyYF6wreSHocNvQ+UpAoC9xYpG5?=
 =?us-ascii?Q?iKQCc9Ddmchgrz8BppFycq+pJvEfob6beeSU9UAnyFwxrFsIzjHHl/D2OwGF?=
 =?us-ascii?Q?2Q98NnokMqNHuImKUlvpmj81575QkcpfAjPlYuO8xM9jPktTsZPdsfblCPsh?=
 =?us-ascii?Q?v+uAkakLvcMJPK/60K27s10om3pJef1z48L2GDoGxUUAjntYTWzVA/O4PuH1?=
 =?us-ascii?Q?LDtR+bmgK+Izonm7hW52ttJ8W4i31PtBrgQlxFZ9l/LZBgabQGVo3l/4qF/J?=
 =?us-ascii?Q?izbnlwq04LgOHOSG+JpYGDZF33Bp6kQmswTfceHY3iuYCCqFoL/AoT1fZ7uN?=
 =?us-ascii?Q?q2+PdZKMW0gO1J6UdLT7MKLC78dreOQyn0UxVQypYqklFWw6o5tZj4IQ89L/?=
 =?us-ascii?Q?/w1O+fSINw3F1GsVitOd/swAVVhHLXoq9XEIOJMHtES5Pj2U/uFMpmLsg/WF?=
 =?us-ascii?Q?lVinGA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QUVYm+dKym6f1II7cpSnrb1Wkbi+0N8AXrfUiDsjePn1HifnnVo4LTDtjd0L+OjxRLeqHORaTjTapupIS/VaqoHshZHhpReMS8nopNJhW99+WBRR1STfZPPK4k++K3JAj85rWF1F7CPLbhSN9/OMFn1Eu+sbr2t2qgc2gjDPApFpIeCvdIGWXS2eOdDsZwucdLZh/lSW6HmNS2G0kbNBtm+bOi61obcntw1ZZ0R7zWYB83zH0Qo+E594hnbPr+DPRxEqY1c9jRfEKPDyCfKMG3opUSm2k9B1b5ekT2zPiPxKKNniTaZR+YfBS+fD4rdyhDqFnIbpReubHLXrvksQWNYCOP23QwOAquWycuWrCoQ9tRv3aWePRpvS7WnwOh2Nxu46FkDKu6z5c8d8wI3lU7/ivWOmmtoQZkGy05WtURXU8eVGsmPm29KVVagasV2kGhYYlRErBAQiPdnPBRniq2Mb8P3Z60OSjn4iOoLhXvwphnHeOIoIi6PifTadgtjIeZHEtAXd3Jq17zofRvNYmbdWWrGwuTtgcu1PTwrLm2nlTdEg4Hb6i/I1zONpv1pcHBltI6jHESgN/PIB/lfHLAKkVwaORHEo4gu7EhkaaBA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00b1cb1f-47f5-4991-d49a-08dcf33a57f4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2024 08:11:49.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vTBttN2zhWAcdO7qbpkBGesTsoA+mpstoMJTNoZiHLT5P3ZiHGV7ZDw0muUTIpr+J3f/1yZ/AeL1fwekz40gj81Pb7HUTS5VyeeCjx3Ikyk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4701
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-23_07,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=788 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410230049
X-Proofpoint-GUID: pnkWycZxdVS_MgkUz8N6pQhGm1QeLDF6
X-Proofpoint-ORIG-GUID: pnkWycZxdVS_MgkUz8N6pQhGm1QeLDF6

+cc Linus as reference a commit of his below...

On Wed, Oct 23, 2024 at 09:19:03AM +0200, David Hildenbrand wrote:
> On 23.10.24 08:24, Dmitry Vyukov wrote:
> > Hi Florian, Lorenzo,
> >
> > This looks great!

Thanks!

> >
> > What I am VERY interested in is if poisoned pages cause SIGSEGV even when
> > the access happens in the kernel. Namely, the syscall still returns EFAULT,
> > but also SIGSEGV is queued on return to user-space.

Yeah we don't in any way.

I think adding something like this would be a bit of its own project.

The fault andler for this is in handle_pte_marker() in mm/memory.c, where
we do the following:

	/* Hitting a guard page is always a fatal condition. */
	if (marker & PTE_MARKER_GUARD)
		return VM_FAULT_SIGSEGV;

So basically we pass this back to whoever invoked the fault. For uaccess we
end up in arch-specific code that eventually checks exception tables
etc. and for x86-64 that's kernelmode_fixup_or_oops().

There used to be a sig_on_uaccess_err in the x86-specific thread_struct
that let you propagate it but Linus pulled it out in commit 02b670c1f88e
("x86/mm: Remove broken vsyscall emulation code from the page fault code")
where it was presumably used for vsyscall.

Of course we could just get something much higher up the stack to send the
signal, but we'd need to be careful we weren't breaking anything doing
it...

I address GUP below.

> >
> > Catching bad accesses in system calls is currently the weak spot for
> > all user-space bug detection tools (GWP-ASan, libefence, libefency, etc).
> > It's almost possible with userfaultfd, but catching faults in the kernel
> > requires admin capability, so not really an option for generic bug
> > detection tools (+inconvinience of userfaultfd setup/handler).
> > Intercepting all EFAULT from syscalls is not generally possible
> > (w/o ptrace, usually not an option as well), and EFAULT does not always
> > mean a bug.
> >
> > Triggering SIGSEGV even in syscalls would be not just a performance
> > optimization, but a new useful capability that would allow it to catch
> > more bugs.
>
> Right, we discussed that offline also as a possible extension to the
> userfaultfd SIGBUS mode.
>
> I did not look into that yet, but I was wonder if there could be cases where
> a different process could trigger that SIGSEGV, and how to (and if to)
> handle that.
>
> For example, ptrace (access_remote_vm()) -> GUP likely can trigger that. I
> think with userfaultfd() we will currently return -EFAULT, because we call
> get_user_page_vma_remote() that is not prepared for dropping the mmap lock.
> Possibly that is the right thing to do, but not sure :)
>
> These "remote" faults set FOLL_REMOTE -> FAULT_FLAG_REMOTE, so we might be
> able to distinguish them and perform different handling.

So all GUP will return -EFAULT when hitting guard pages unless we change
something.

In GUP we handle this in faultin_page():

	if (ret & VM_FAULT_ERROR) {
		int err = vm_fault_to_errno(ret, flags);

		if (err)
			return err;
		BUG();
	}

And vm_fault_to_errno() is:

static inline int vm_fault_to_errno(vm_fault_t vm_fault, int foll_flags)
{
	if (vm_fault & VM_FAULT_OOM)
		return -ENOMEM;
	if (vm_fault & (VM_FAULT_HWPOISON | VM_FAULT_HWPOISON_LARGE))
		return (foll_flags & FOLL_HWPOISON) ? -EHWPOISON : -EFAULT;
	if (vm_fault & (VM_FAULT_SIGBUS | VM_FAULT_SIGSEGV))
		return -EFAULT;
	return 0;
}

Again, I think if we wanted special handling here we'd need to probably
propagate that fault from higher up, but yes we'd need to for one
definitely not do so if it's remote but I worry about other cases.

>
> --
> Cheers,
>
> David / dhildenb
>

Overall while I sympathise with this, it feels dangerous and a pretty major
change, because there'll be something somewhere that will break because it
expects faults to be swallowed that we no longer do swallow.

So I'd say it'd be something we should defer, but of course it's a highly
user-facing change so how easy that would be I don't know.

But I definitely don't think a 'introduce the ability to do cheap PROT_NONE
guards' series is the place to also fundmentally change how user access
page faults are handled within the kernel :)

