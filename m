Return-Path: <linux-arch+bounces-8273-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA10F9A43B1
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 18:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D0521F24AE7
	for <lists+linux-arch@lfdr.de>; Fri, 18 Oct 2024 16:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFC51201273;
	Fri, 18 Oct 2024 16:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="H+hVYuUi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aevYmz1p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC851D2B0E;
	Fri, 18 Oct 2024 16:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729268627; cv=fail; b=U/TLPe21kAE0216dMZ5XA1Bzpug9r5WvIV5I88p6+AMq6UjSQjyx+K0tT0+/IW/pfOfGdSUktrWWj2terPp27vwNhQFN13e0GYU+rDAigmIRJNU7jVJh5ENge0JfahGUH7nscWd6MMy3i+YgHfy/zKedy0vD0EzDi63cLHf1Mxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729268627; c=relaxed/simple;
	bh=k5YHULhSLFKQAD4P54ao/6kJCEIHdmY3C4QSP1Wefds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=bqTYDSTMBfn8yeh+phcwAAdMMNbmiK23UJlGWY4kOQAut4cZ4UnrAUYI7Qs9H1lQ0UklVsf9ZuIsq0EmotbGaKpYpBfCu6QPNoBy/Oz9yx9q2FAJCgJU7tyq/LK1bP7ooPx2I/U8ly0PfRX5LW4Er1oGY8Eg2GlYuPx+pT2bqTY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=H+hVYuUi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aevYmz1p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49IEBc5V017019;
	Fri, 18 Oct 2024 16:23:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=yW9pexR5uleCXDs098JRKXkO+Z28DmM3Y3TzeDrtRlc=; b=
	H+hVYuUi0zZrfc3ROG13k+SwdsXD2wMUjydiIc/cHrWYVvV5KikUUbT6HpunUMi1
	A6IOshVnMua+fYGsqxSkFhJJLSiSQkNkKoL2DaFRdjTPy3HnnmC+dZFmRA4c3tq7
	eo+7O2QPvs1dQ/1WxBxvU8EHZABXnQ88QB9VhFgewRXvnLJRqpEAMEXKOoi0c25P
	V36E2zzG9c5xZ/lit81VnyxA/yrce4USmu0JUethFkJIYTLYixvH2MtleERgNRdS
	ybCk/QYoW1tS2i8xRaTGo5y9UumSSsLlX4BALS9doPcUxHIg3xBaDjmyBgatQqp/
	Cl1L2oFQ4ZhvDyCoLHJmSw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427hnth72y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:23:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49IG34HT027269;
	Fri, 18 Oct 2024 16:23:01 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 427fjjdhxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 16:23:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Htp/jnZ8IUwUsdMoWeIiJKJohyxESGB+4yWhhXhOxAwZhU0lxaKK74Pewxca+ehayVVbUFlHtdt0DsvxEF+4i35BYqGMPTTzurOU8MBJLy/xwqcuDFJjMOLZ6xwG/w+w880G8kaz+NWSPHCl8PiJATnaP1ECBaCPcHf2o7UUdCrfE3gDsiDkHXqGbAeI2Q72O5i4aNza//7RsNtBj75eMbykaxkoDsSDgNdGTmkQeMiw8m4jZOHQS0iHtT2lUoq4m+wRWGhPio1OL/7eHj0U6C1dV5fjwRb/sErMgFToalakmpopjz0c1UhdJdbSrSh4Hl9oIsRhogmg+niuuQLdnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yW9pexR5uleCXDs098JRKXkO+Z28DmM3Y3TzeDrtRlc=;
 b=hVcG6viX6zGrrAiUwKN5lOnmRxCT4BoCEhfkIdatnzLeur02h469ieEe4VCkgIgJ+9wN1C5dbAF7n0OfkRFShDKQgMXP9BTV/pwApX98bgAyHOWPnOFk4GmOzHVYdpkAZjlfTzVqD4FES5Bu5Hv51of4LHrB2sI2U+7Uin6bbBmczPEKOc8Ar8mWR2QmLQ3r6+8FFb4ApnjNCnID422AM7Sc4Fb4HusHLHYONiCnucUwgtGvMrwmzsUTHYVFGKqwR5C5+GPYIH0PGz3PIKzUK81fr14OIx/LZJepXGQulAFGCqM09HhoPGxDr4pKLRtmTl7bcfA+7dMZaZrNf+TM/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yW9pexR5uleCXDs098JRKXkO+Z28DmM3Y3TzeDrtRlc=;
 b=aevYmz1pq+SZS+duy6+f7Dk42wfUHGi/hkhQr6Vge/lrLLy+8URjhKwudC7v/8G2h3XSw9vtk3FbRzpm9ZAfZQqIV67kz7VZ+Esufa+yhdPaxjrzGbn1woeHwCA7R0gLUhO/ftwbXRdkYE6xvdnDicLazHittJcjBri+rnXPjqw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5129.namprd10.prod.outlook.com (2603:10b6:610:d8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.21; Fri, 18 Oct
 2024 16:22:58 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 16:22:56 +0000
Date: Fri, 18 Oct 2024 17:22:52 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 4/4] selftests/mm: add self tests for guard page feature
Message-ID: <23a4f83b-2b1a-458f-8027-3ff83b9ac29f@lucifer.local>
References: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
 <8b1add3c511effb62d68183cae8a954d8339286c.1729196871.git.lorenzo.stoakes@oracle.com>
 <1d0bbc60-fda7-4c14-bf02-948bdbf8f029@linuxfoundation.org>
 <dfbf9ccb-6834-4181-a382-35c9c9af8064@lucifer.local>
 <22d386cd-e62f-43f9-905e-2d0881781abe@linuxfoundation.org>
 <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bbfc635-8d42-4c3d-8808-cb060cd9f658@lucifer.local>
X-ClientProxiedBy: LO6P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c38502f-5282-489c-8473-08dcef911fee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OGxxK080ODBTUWlxTXNpT08vYTBMS3N1K3VYK1cvQkJ1WnBlSlJNYjZJejdF?=
 =?utf-8?B?R3VJYmM5RW1rU3NYcVV4NTZRdUVRNzBWQTByYm5CMDIrSzdNb09Eb1pBWnov?=
 =?utf-8?B?Rjh2a3ptckFtN3k2U2lQQzhSaEtKaG5odU5rRUFySmk0ZG41ZCtzYnhEaUs1?=
 =?utf-8?B?ZTF0Wjg5d2FtN0xWMkZNZ0xTK0p4UHV1MG9IY3MxWkptSnY5NkcwdXZjdlFQ?=
 =?utf-8?B?VGJPaXhGbzl1QTlFMlEwM21SRStYeU9LMUoybUJwNGNEZ2o5cWg3V2xyQXVr?=
 =?utf-8?B?alVUMk5hQUo2WmMyeFFCSTByQkdMU1MwOEtOSVBNYk1jU3JFQzMybXhmYkQ0?=
 =?utf-8?B?NWM5dGdZY2NBc20xSEp0RzY4Q3Y4TDBLM245ZUFTMDBrZ3JBRnd6RlQ5Ni9l?=
 =?utf-8?B?dkZheS9TSDY5cmlqYTBqYzlYREVQMmZZdzBkRWQwL1lNOHB6ay9RMlA1NjVF?=
 =?utf-8?B?NTBTL2xtMnVuZDc0VHpRN1dSeU1hdWRHRFpmWno3eHQxeXRlK2hzQzlaT0tS?=
 =?utf-8?B?OXhwWUxFckNKeml4U3VIUFZ3bytTZmF0aTBUNk9JekJWcTVKQ0FQLzdqYlpp?=
 =?utf-8?B?WnNkYVJhVUZXTnlGdUNiWmpIM1BWSHpGZzQxQTdYNnFBZ1RMaGFQdjJ4WnJE?=
 =?utf-8?B?Y3R5V0RSUkg1cmoyOWE4QkhlbldON3RUbnZVTkR1aXo3V3RqakFqaEtmZ2ZV?=
 =?utf-8?B?OTJGTzNZS0w5TFpicGt0bzFRNUVrQktBVnhWZ1JYMFozVzFwVThHNkpWeUxw?=
 =?utf-8?B?VFFiNnlDY0FLMW9hUmRqbjZxUi9ZRnBkZ2JwRTJqN1VIK0IwTmJQQ09JemFv?=
 =?utf-8?B?WWt0eDBYbUtoV1hMYTdlbWVWQ1RjdjJQNnN6RkFQUzlWOXVkTEVqNXB0clZP?=
 =?utf-8?B?SVZQZEVRSGN3NU45TnEwbURDczVDcW11YS9wcmw2VkhDWmc1VFJHN2k1d3VQ?=
 =?utf-8?B?WThmWHJWb3hvY25XT1FIcnk1aHAxdkk5S1AvNTZQMXYrWGEzWitmUkNaaGhM?=
 =?utf-8?B?MVVJOVp5RmFSUzhIREg0TTk5SGdjV2JNc2lWdVNMQzdoRzBEVlBjbkNtRGE0?=
 =?utf-8?B?T283Z1ZPa3NsUnF4V1hRTkNKTjRKejVwR3ZNa1NHWkdQSlJWZFZuK3BlSXlY?=
 =?utf-8?B?SHRuZk1CODNkYkxPZGlEWkRaVTluNmxLYmFEeU0zSzNDZzJpR1p5N0Qzbndn?=
 =?utf-8?B?bnBTbUNNb3F5S2xkb1E3YXJESE8rVCtxb3FTQnFnRkhUZUhSYm5sSjA4c0RZ?=
 =?utf-8?B?TnMvSGdkRnVJNkxmMWxQM1RvcHBjWVNEUjR2b0pZT2VXckF6MFh4MzFWL2JH?=
 =?utf-8?B?ZCsrbHd5VmJPeDhIeEdZS0t2ZE9BQjRQNUF2Yk9VbnpTSUJnUUFTZW5JNkFn?=
 =?utf-8?B?Yk5PWkxRd0o5c3ZtN3FEQkdadEt4V1RWRkZjS3F4Z2hBUThmZHlkY0lEdXpL?=
 =?utf-8?B?cjhGTWxNZHZIRzZ4L3hLT1A1dkhreVJib0pZV2k1L2JoWXJEQWhkVFhhQlBC?=
 =?utf-8?B?Ukwxc3drR1VjNUNwYkROYXp2SHRmcGJvMCs1ejJScC9VSUptbSszdW4wMGVB?=
 =?utf-8?B?NGpTWFYxd2JTREtKT2dnU2h4NC9FMHlBSlZabzczMEFhZ3JhbEVaOUk3a2Jz?=
 =?utf-8?B?ZU5ONmcyTFUwU3RtVnFvY1c4cDJFdllXUytJdFg0T3pkcVphcHRDZ0J2UGln?=
 =?utf-8?B?d3pjbjVSQmRwOCszYnlyanRpa0d3OEtZUnYwSkx4aHNNbkg2M2ltSTNvSU1E?=
 =?utf-8?Q?57tzZrC1YiZOqEPVKEoSHuYU3gR7KSNkAD6u8hY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmVUODBMUENZemh2Rm9wYXJ0YVQxKzFCQURaMmJNbUIwUFp2Q1hjUVB3T2cw?=
 =?utf-8?B?MXpuUEtxU3gzRlkxS25FaFpLTW1FaS9ua0VadXc1WC95ODdVdXBiUEE3L0tl?=
 =?utf-8?B?SStUYWtINEQ0L0ptWXIwN0UyK3B5Ykp3VDBtUmlCbk50NFhoaTZPS29LTXVB?=
 =?utf-8?B?Rld0cEdRQWJndk1LQzM1cnRycGNHbEhQbmZZQ2lmM2Y5M0I0dE4wcUVUUFAz?=
 =?utf-8?B?emFlR0w2VzRybzZmT2tyN0pZaWJjM1pHUGZkbU1WaWpjK1RrT0drdTdOQUtE?=
 =?utf-8?B?dVordXlOZHh5Q2tIbjdCeVE0cnBybFNhM0pYMExBTmpMNTgrRFFPeFpHR1JM?=
 =?utf-8?B?azdwUEQwMEZ3TC9qeU5KRVRQbVdEdGpQZ3NwRndiaStNQlh5aW5hOEVUKzBD?=
 =?utf-8?B?eEcxUWxNVnY4MVo2dXhKQnJKZFozU2NXMmxLZVFWSWN6WU5yMWZRM2ljUU5v?=
 =?utf-8?B?QmdJMnh2S0FwcGErSXM3cEV2WUZUVGdLR3k0VGQva2tFUWFuNjlQZWpMNStx?=
 =?utf-8?B?aEI3RS96UGtYem1VUWxlME9pdDhyV1l3ZG9wSE9DWko3YmdJY3R5L3lPdTBa?=
 =?utf-8?B?bUpTTVYvVGZpSjg5VXdzMUExV1FVSkx4QWJHL243OExkbkNUOGJlYks1b3RW?=
 =?utf-8?B?d2ZYVUNMWjA0UkRVb3RYUitjVU51dmtnakFGKzE0N0R3VENPeHlkTDBEMnhl?=
 =?utf-8?B?MDlqSTBnZzdEMVpMUFY4QXkxWGoyNUV6MXVJbkhDNUpSbWpKeUZUNjZoc2cz?=
 =?utf-8?B?UDlNSnhISzFyVjlwQ00wWGh4MzdkU1FlWUlOaDhtbmxYQWtmeC81STBseTZG?=
 =?utf-8?B?cnFJSS82ZExpYXRNYlZJc1ZhU2lranBmbFRiQUZ4K1FOUzgvTlNmaFFBSVFU?=
 =?utf-8?B?dnc5M2dubnYvWGFERG94WlM0d2JubzlDeEhCRGE3aFdXWFBKOHlQbFVieHMz?=
 =?utf-8?B?dWs0WmxmTllZd1ppNExwZVY5azQ5dWF5cllyL2VkT3VabVhDN2JFSXdoYXha?=
 =?utf-8?B?Ty9sbHBxbVRZby9Belp5L3g4d25ZWUh1LytteGpoZ2toS1BIcUdoNmZlY2RR?=
 =?utf-8?B?bEp3Rzk3NXBza2RjTXIybzlycFIrdU5MVFNBMnJ4VzFVRVI5MUtXNlNPM1FK?=
 =?utf-8?B?b3FFOWdCaVozMVFxRWo5cTkxV3NFQnlSc3JCZjVVa3BoL2dqMThhN3g3Zm5j?=
 =?utf-8?B?a0VRcmxFdjlhdEkwQW5HT3NJUStabjhRZFA0MWt5YnZHRjhRSGxSVHlVYWti?=
 =?utf-8?B?enRIUnpKeSszWExjRVRvaElnaGRIRGt6UW1KejVjdVJKNEs5VmdhNXY2TThx?=
 =?utf-8?B?MFV2bGtaY2dacU9Id3k0YjhyZ1QrMHdIR3pUSHl2UkRHblRTM0hqek1HL1ZZ?=
 =?utf-8?B?eFlRYzVtUHl1YW8veDgvU3BHMXF5QjNMWTdmSDhBd2dNWDZxMEpFRFZRTlRL?=
 =?utf-8?B?b21hb0VmcFdrZENIcWlKNmw2NXphMDkrNERPQkVSazlnSmRzRWR2Y2JyZjRI?=
 =?utf-8?B?dVBZSGt1RHBlMmNuNjNFcEtTSm05YVVxV1RUOTkvWU5wTDBWVTMvNkZ3Kyt1?=
 =?utf-8?B?RVJzNDVJZXdHK1M5b3BJNmdBUWJOMjRyZ1BTRVF3bVpydzc4OGtjRzFqZXNz?=
 =?utf-8?B?cExQVTdVbmlJeFFuOWhQOTNLV2RQZmUwUnlqNW1qWXhXNTZwRUNKYXNQd3hx?=
 =?utf-8?B?aVJoaWNwRkhNdXF0YWc2M21kOVh4OEtyR2E4OWRUTmlWNEVDbjdQWjZSRUt6?=
 =?utf-8?B?OTU5V203TnI0ZFIzeEM3ZlVuS0JnRDkyYk4wQUJBOGRjZzAzcHFibEIzMTY4?=
 =?utf-8?B?QVFOQ1FOcnlTUlhGUDRCR2FaM0RlSjM3Z0hLWUR1RHFIVG5ZaUJ3S25WYUhC?=
 =?utf-8?B?TzROYXRXdS83OVdiaDJUc0Z5ZzhaQUlCcHFBSklxUGx2cVNrd0tISVBtNVB6?=
 =?utf-8?B?emRYOWxWMThBUHVrWHVrSHJUSWgzaUdrUFo1Y1pyMk9OSXEzdmRINlR4M0Zm?=
 =?utf-8?B?OXplTG1zNFpPQW1yZmVjR2ZyQ0ZaaVJTMlVoUEEzb2VxdEpzWlV0cFlOc0ZM?=
 =?utf-8?B?NU53a3BUek5RejV5T0ZhU1Arb3EzVzV4SU5rbUZzck80SlVuZGtTckVBMnk5?=
 =?utf-8?B?ZmZCWUxqekZ2dkRobmxaU1l0elRkZ0ZhYlE1SkZxa0s5Y2xvd1pFWHVhMWZC?=
 =?utf-8?B?cjZIbXNEWXBNZ2sxQTltSkErQjZzcWVwbTlhcWgraVJzV0xuNmVqcFNELzg0?=
 =?utf-8?B?K0dZMlgrbVpXRmY2MEhXOEM5OS9RPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eXj3o7TL1WxG9etyUaLlLse63Jgb0VUjjr48jJaWkF8+hIaICgDW2J0f5Rpa4QDRvxDj46rpLi1KLKrX7Bol0FLFF2IAFg8g32wjkeesXRa2brxFc0qeVEesjRM9uPGLZIW7XEmZnVvCDpwBsW9I0wXjXXIM9SPIOLPaQlRqx4pnech6eScbjIlTJubw4XfzzZKvl/yi7Md3NtIBE8bwxTB6xYVP/gFGxUCdkrZ/pQAXzg7gJOKxHlNA5UytmfJZUDEAMta7agNVo5TnEFHkfdcPafmAcB2lqUPcbPg4ApzCil2mrgwz0NnRZUIJ6GDOWtJCbp+93jobBGKASWSwrVm/yHH2VYQwLzhoidapbNLv3P01qrBQLEbXiqQagpSeYIdWGhwCU+u8H2hAts7GyhtiFZiClQ6MLVQFZ9vhVbOmiTU1InihpDkRPHxYsIbSWoBZ7/GK5pIYSChUfu+Rlj47xTqsPDufG+wQCo5XiPeOQEvBxLf4jQF+qEQrpWHrs+C4LO/mCL4nQM5kwro9Uzh5eFKktz9w1vZpqwK/ppQR9E26gy2x217tXhkq6nC/DqRKyR3Qlw/wOu9i6pFfJZ8oF3S7cILaEVf8Tw3nMCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c38502f-5282-489c-8473-08dcef911fee
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 16:22:56.6012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wENMr6IltZpbMyTbIjomTkHVfARPnR3MrHCQSPPAalXBGoxGWeIRSngZFSCp6hcZzN+jLsNJ+sIIrRQFSQCNOqVTK2t6x4JaiP8O85Mffvo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5129
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-18_11,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=459 adultscore=0
 spamscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410180104
X-Proofpoint-ORIG-GUID: lpYCrIYWcJx7g5O905ZCu3uyQvnjUmum
X-Proofpoint-GUID: lpYCrIYWcJx7g5O905ZCu3uyQvnjUmum

On Fri, Oct 18, 2024 at 05:07:20PM +0100, Lorenzo Stoakes wrote:
[snip]
> Firstly, as I said, the code _does not compile_ if I do not use braces in
> many cases. This is probably an issue with the macros, but it is out of
> scope for this series for me to fix that.
>
> 'Fixing' these cases results in:
>
>   CC       guard-pages
> guard-pages.c: In function ‘guard_pages_split_merge’:
> guard-pages.c:566:17: error: ‘else’ without a previous ‘if’
>   566 |                 else
>       |                 ^~~~
> guard-pages.c: In function ‘guard_pages_dontneed’:
> guard-pages.c:666:17: error: ‘else’ without a previous ‘if’
>   666 |                 else
>       |                 ^~~~
> guard-pages.c: In function ‘guard_pages_fork’:
> guard-pages.c:957:17: error: ‘else’ without a previous ‘if’
>   957 |                 else
>       |                 ^~~~
> guard-pages.c: In function ‘guard_pages_fork_wipeonfork’:
> guard-pages.c:1010:17: error: ‘else’ without a previous ‘if’
>  1010 |                 else
>       |                 ^~~~

[snip]

An added note - the fact this happens makes the macros suspect everywhere,
and I am concerned single-lining them might break or cause failures not to
propagate perhaps, which led to me _never_ single-lining them I believe and
accounts for a bunch of the warnings.

I can go through and manually test each one to make sure before I
single-line them if necessary.

