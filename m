Return-Path: <linux-arch+bounces-13105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D35B1FEAB
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 07:36:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283463B5BAA
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 05:36:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A557277037;
	Mon, 11 Aug 2025 05:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j2/MTV7C";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IJB5v3LP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EEFB26B0AE;
	Mon, 11 Aug 2025 05:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754890553; cv=fail; b=eQG1jxyczw+oz4oajhiFO7DwIBWZw31/LFEsfpmZjyjBA8iIgMHAEWZH4Zv3Ae5A4OHNRWxaUhk6ofzHq1TPok98WJk0MLyUnRBjGfRYkT7TEL5hyesbgGBoLiX12VcEU22oAkyDo2kIOTEKwBzXhxBhy+Yie5J4PGykCJg6+O4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754890553; c=relaxed/simple;
	bh=oAQpLBDlu0fKpyV7v5trvoSNHeQ78nES3gfxnw9IbPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jbWIulLySKzp7Yj9cMeKA2rH6Z0O+jyPKOErD97AxiHZQ+QO8pQCDjVjrOXTHKpxlVbyWxxCTrUjcw8RRRU1tc2xWuETqtWuXufqVNsKCuBOX/Yj1tmIZ4RRY5k8Z1WDYOLgJ4DEeS6Tf8zsSk+CC03XpBInkFcY3oEJrPcS4DA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j2/MTV7C; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IJB5v3LP; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B3NhrW012388;
	Mon, 11 Aug 2025 05:34:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=iVBg8lAf83GGbH1+fgxNiwr5wo4Z/cNcOXBGZmFcKhQ=; b=
	j2/MTV7CWOuqfhYc57k49M+Wy4Swhzf75ukF8tl1jDZU+j4m61SQ2kxovh64YZ0N
	jCuWpuEMaPKN2T57AfOobdUrqxUh5+xYuvymi7i/fma0I3DBvNrE++EdxlsQk+kR
	9oPlebkp7BTLCLctKlU107l6f3ua8RbOLuaBIAzQHl4E8pDuGTtvtW4r7yHr2o2t
	CyKaRmMZP0vIFQYO5PVPlw/+mJGvOk5VcnRbzlEHrpFLuR4hswWRa2USbYqqNXad
	CZBwMlKFYrVoo7tvAlLL5SF8UXAcWh1+InuelABJB0PT14p9rHinNyIjLUFCmL4C
	qveaNGM6UE4yrbbG+8lSGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8e9rwk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:34:59 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5YoMm009639;
	Mon, 11 Aug 2025 05:34:58 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2043.outbound.protection.outlook.com [40.107.223.43])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsefjxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 05:34:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hin/pcop5DGwTYfgKslKEA9uleenGqWV1oRnL5xgMxz+6ytyQqOOcfMQ2VaizmbHYT8Gc7eHrnf22Hz/n5udLrLVBznN3Ik4HtYWfq/ADfBd94cK8geyELLj7vHoO56Vyv+zkxPYT6WTPaaA0iMnjyL+Bj1AchuJlMXd4lgW9+J4qau3wFeZkanZEgygWFsypWSG/3suEgit+jzFkztQ4rCqS2N05zOdOu6nW84IvlLG8HTiah9NyBfE3ww1RftAeQfE8H2Oy5//dqtId2a6kIaJ7WwowmPZ24faVT6DjqUvQJN3X3YeStBo56wzDCFJGjGmR5UAvRS6Xu4n8kdEiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iVBg8lAf83GGbH1+fgxNiwr5wo4Z/cNcOXBGZmFcKhQ=;
 b=SX2oQSl+G3U09KgtNKlF/G3c81nQq8E+lc/wy8lXn5p8FLP37DMkQLvzS3NvCKQubVxZfndugOUu97x0u4t/ktuiOmMwbLzjb1k6f0U7asihjJIlukWDTt224F3LrybY8OHJxGHKEXd73VPB8Pc2aBI59xnEO7wA2fxYea4SQB2CfxSXNfHeSD9DMofHgm41ROA/ZfHcCfrLdQTL8MoDxu8F4GYzi1Nbj5LshU+kJ5cJZcylnrP7lnOQZH36+BFUkSU4VTnfRvWSxKXGpsB5sm7MZ0fBrxLVt1n0Yg7JynY6Sy9AvQjt7Gyjm/5eMPRimRG5TMF4GMDs6Q0zCnhcsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iVBg8lAf83GGbH1+fgxNiwr5wo4Z/cNcOXBGZmFcKhQ=;
 b=IJB5v3LPgsGR8VDQ0oKJeeG0Z8CP4kVx0jcwWryLtaTwDscb2Jj7dqz9GjW2dZyoqQrhtnIsrhLzUF8Uryj1EtKx7aSYDCbeZ0Oct1Os8LhJVgLOaGfc+GjfiV2xVpPZ+PF86LSsAhSmewg82V3UhUbnNYgBrJrFk2QesTBDtj0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPFA0AD88203.namprd10.prod.outlook.com (2603:10b6:f:fc00::d3a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 05:34:55 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 05:34:55 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>,
        Harry Yoo <harry.yoo@oracle.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH V4 mm-hotfixes 3/3] x86/mm/64: define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings()
Date: Mon, 11 Aug 2025 14:34:20 +0900
Message-ID: <20250811053420.10721-4-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250811053420.10721-1-harry.yoo@oracle.com>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR04CA0023.apcprd04.prod.outlook.com
 (2603:1096:100:2d::35) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPFA0AD88203:EE_
X-MS-Office365-Filtering-Correlation-Id: 492ecb74-9fcf-4e85-5b2d-08ddd898cd5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wCDQ3/qEAlzaF17o5J7jq5aFcVWoUFa+ir2BBdu1TXBIT34f0OrSTeZJhiej?=
 =?us-ascii?Q?ixeolcSvm6RUYtuFRIVx+Q9rqgqX0u1jRq29HYM7ZJJ9HxAXChDue1WzP27c?=
 =?us-ascii?Q?kUrfeNBjkrMBJp7S7mFXP1u0bPRqB6K7XjZJbztHQ6ttWSoh0RqpTJ9wzPst?=
 =?us-ascii?Q?fht0qxgLoL0BKSYUZ/7IkrH44khZNlY7SJzw4RBu6DuoWJ6Yda6CkdO97ajM?=
 =?us-ascii?Q?qHPRlTZ6P/l1uGJMG7z2MGzZSN8+RqIzQ1tj8jcfmYuTalbsZitPa+pHyXtI?=
 =?us-ascii?Q?O2sAbBhVNosDktEWBBTx4MwmPeTYMJoowQTSIP62AO9SRJEK1dxDb0pDRckl?=
 =?us-ascii?Q?ncwBWIxBbIiaKxhq+Z0pyd2Mb3/eDdqLa+bXQW/f9hQIfN+zhHzi0qMVFYQR?=
 =?us-ascii?Q?CnNLRyYETQi1Oa6quLGZ6KKzk6gw8eNPfoUhBLBpa/nXc2cL8QHHV8elhR0X?=
 =?us-ascii?Q?N+Az+rDi+jyZk9vFSTzk+FP3P3Dr+Tqs50z/64p7xE7z891u6gEDAo6UGSTA?=
 =?us-ascii?Q?2yUvYSUQIIhKzY1I7MorUypn1El3sLy50b8L4Wj14OD+2/ZN4EMFost25ZY2?=
 =?us-ascii?Q?bVuRK8Bm1u385dDcJSRjuQCA45tCyxZLyWgz+3iDTf1gekQ6hdlaYtFIHns/?=
 =?us-ascii?Q?VMKg5yQIULJPY3TSnkkela08sJpBGElOnFwbv0rpwBwMBC4BXFgp/oU1C6us?=
 =?us-ascii?Q?WPQyg4SRIZQ+NDtof0NovN8gTej58RC7HLyUpuTUNiYCDCy0K8QYyKKdHyLM?=
 =?us-ascii?Q?EM3nR1c9xovifP/WMua7JqiwXwm2zLV8CVE6553B+j1ZuFshIC7uTjuEjDwO?=
 =?us-ascii?Q?PKpsoxYIkMYGmykFd+HOZ4vKdmJfGS8hYJorW/cauiLqb/5cLkYe3TkSsQTJ?=
 =?us-ascii?Q?5QGWg6BV638ZojU+vspedC5FeUmBX5hcdEuIvK6V8Wfqg4gY48nL6pzqq2sN?=
 =?us-ascii?Q?1NqWgUzhEjidmRFCVo8pBOOCFNozPoyNUgrFQmHcvma+WYG22Vrx72ybdjD8?=
 =?us-ascii?Q?FWX3f0gtAkfxhm06Qe3jwhXlHAmXMpyOR91Uj+jQNy/71iEX++j2ZgR9Dxja?=
 =?us-ascii?Q?nVzZyKfpuyay7+u79xan+ysbQL1JRK/v8wub9ay4ozbixXhx1zXudHHBJ/hV?=
 =?us-ascii?Q?w6+rbKT3jYouetY4zRJLJvGsNuEdl4GvWAGZ/0CDwoqkscSx0/6uyom4s+UT?=
 =?us-ascii?Q?zmfpnf4zvqfcY9c5tPCAc4aEvPhK3YJWHXuUTGwzPR2vUqorNg+6GqtCmnGV?=
 =?us-ascii?Q?KwklKc/n+AoociuNCSY155dY4veZzEqHJT9sCX+AKST50EcWV6EvZBbmC8m8?=
 =?us-ascii?Q?7WTye57EtODuCTeSmO7mzbgwWMu6FqhhvlJnv47yxzaoDvT81+3zFsPZzG79?=
 =?us-ascii?Q?7ZsJUwV3ifWdeSp+FpAXzxhPQsVOtbTVJSFKZzBOEneA3UiIQF4+A240/nmQ?=
 =?us-ascii?Q?CV01t9mupR9AuEMiTvma78WPspZCnM0GxfJmy92WCjm0r71R1M+Cew=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VvsDH0UdRuFwIJS7UmPmBUwdXHvGDUyHy2aH3OOGGRS7l4JVfkvoeSOEzPLK?=
 =?us-ascii?Q?9Eu9mbgUlU5xIBnM0Lg5yViaDza7QKfd/XTbD/T1ojtXZjjJRZX056ewhTep?=
 =?us-ascii?Q?FBb3jT1skF+vy0uk8oD4MkcYr8wt17V2o6U5bhWHtzsY9sZNyCtbfHiokrO0?=
 =?us-ascii?Q?06sg4iq6wcj47313t22bk7ALWTe8zw2YWnN4vVXEuhe74W9/ea16VMbnZH7V?=
 =?us-ascii?Q?87kQU9/zdaTf+zMbA3TZUjL6J0UcMKZvZybQAlSBAPRBbXCnCyHvmLxDwNhj?=
 =?us-ascii?Q?sCtLYKN4lOWlRbck8XU1YKipxzbBZeFfXz2V2KepaNDYegAp9o+bin6JzeYJ?=
 =?us-ascii?Q?UFgRe4lYw4/H30DAlsxn/25N+uRfYSNDr/uImzJZdwzBoBahihRwmRsaYDdS?=
 =?us-ascii?Q?13oi0t9LJYL/pcrksjxSm2wD9reFEh0qQvdcvZjtpRyFJVvg8dNNYtZGKbob?=
 =?us-ascii?Q?KMp7+jBzc2DIh/iI9gVdWkiEXp4UuMQx2YwTiMEvd/i5XsLhWvJtuSOhBOJH?=
 =?us-ascii?Q?j6RNtAic3oqlXOJzEnAQe1wqZ1QdcEUEkqWIMkfgvcYA4MddTOt3yDFOKzVq?=
 =?us-ascii?Q?6HZWI0WUhH2ZQIidyk8In1+8kGVhrqyX5VU7sXX2G2rt6YPTBV4NUU/pdaoN?=
 =?us-ascii?Q?+lkCG4QVd2AJr+emU07cXyzP8XVaHy9GqJTAtUT1Jz5BwK1F7JG5y8bK0K9J?=
 =?us-ascii?Q?/xSulExP0KLjThCl5XqWsu5V85/NUPNAUjsfmYseSx0k8Sgm9e9beIRdP8+8?=
 =?us-ascii?Q?sJqJ57a/BhTJ0Bx7tfcicb68WrkM5v6JSoYlbJhE581G5GcpuuoPV85jJoke?=
 =?us-ascii?Q?X7RVpHPC/uQwBXfqtUPcQJ9f7Ld/f+/JKQw49vYr+hpXHdp+y4Iclm/XJral?=
 =?us-ascii?Q?BoQNR6zCNKAtyg6eJI/ibCg1qWXVhVBVNq7qSpdITq/IzV+kEzfbnKo+X/Y8?=
 =?us-ascii?Q?djb1h6f8GFbqarNKUzeztGK0mr3F5ZUkSyEdkwaEjTyWPfbKGWMm2LzBHlPH?=
 =?us-ascii?Q?mP5GWy1C8+LabmkFBRu/PqPpdElyHz0ddJO8ep8EuvBo7ucE8jCL6VoR2nus?=
 =?us-ascii?Q?HqbfqGBk4bPJ898pLYPKaYj+mMbWcDuiE0a0tFtV7/J8ltj9RJUg0iieRxzU?=
 =?us-ascii?Q?TBJMOhcIBamlAkmtp8vsNyDGxbe/bsg8490e9pQKIi2csv/BSzrR88PJ1m/3?=
 =?us-ascii?Q?UlPRX+i5Q4Jrw5nx+qIhj+OIkYfXfXpNi89uSH8lGPt9hmeZHKwj54W+AqRw?=
 =?us-ascii?Q?Wpj1w/PL4CrZO9VY8xiIAEnIPX2fBwMQKDt833xPJKWtbPtO0SIYAHDSQ2Q5?=
 =?us-ascii?Q?OyUCsl/ojkDqEqqE1BOU6UbQWnZ59TUI7K2PSxuZH3v/Gr5tyFlpMCNpPYxz?=
 =?us-ascii?Q?OCxhTKhjJY6ssQLpiuVE1JKGqHDPDw5SBUQvfIdB7lLZZSEC6B+i9TFoTob9?=
 =?us-ascii?Q?mBTfHwgpfYXfCJtYYLGhFGo9+5APLkCVI5p86/sfNKqHreE667O0G/yVui5Z?=
 =?us-ascii?Q?QnDGW+Y5SSDSaRoNCdwRThanjh0xNMP40XPdVZMGWowAacnM9llTNdWv18yu?=
 =?us-ascii?Q?MDmX+xFszIxXLUunPDKHW0Of2eNQhvNSlT3gThsP?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	4bshfhc7FvBkduIsTlpVdppJx3Z+gQBCk+YqC6Wfl6CG2IRBEiyGQsVYjge8ETUyhCYc9E7OOZqJ2BD7UpKEZAyF565UeKeDWKRlhj9A4mnRzIxgUQVoZwcAmrATAzCoF3Z0rJwyNKriL5cwF4WSrfOGIim3WHM76DHvQ5T2WAyxg3GESX+o+1QdZBvr7W0VNzLn4S2CQcAaHZhdxH86fagKhAhVVzNNrucXrtb9v69p6aaW+HSSHU7LfN+8L3lZPSL8hFYULc/68mbsUruWe1kUEw+Bs9/4tE76uVOvcmAjGlWS7OGxQtMY7jzGaEgHvxHTTi1QOOKlSos8XZC+UbjNItISXgbk6NCk51Wb3iEdDSvQarCroav6bL9whYhGQVRwlXhDUYA+vvrDpxnknCLiLoU/PVH6rMseEsF/zJ4JqVl5/2onN+VGodAkU1icbMqAVLK88kz/dMMnB8yRxuTMyQ9Do1uoP4MKbgb19X2OwybmK4yfrJXFCkLg0fONoDN8EHMowyimvoNWWczNNzWgV1pSd0R+INnsUla14eCauW4b+Ppo2eXn0gYDS1Hss12DyLI+oZJU7cdZQ26R1p17bMOv1EPyERE0zbk1LK0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 492ecb74-9fcf-4e85-5b2d-08ddd898cd5d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 05:34:55.0882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zsiOCA0A3v/UreXoBFRMAG1GozBf72Xf457NizAH388c0JB0+2dLK5PiO4i6qRGp7MyWcFqxlMtnkR3KbFjsEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPFA0AD88203
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_06,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110035
X-Proofpoint-GUID: vsH7B6WI1co5ZkuQtfwgg7a2zGx2ydM5
X-Proofpoint-ORIG-GUID: vsH7B6WI1co5ZkuQtfwgg7a2zGx2ydM5
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=68998103 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=andX2sbcIq9QJGdYwqsA:9 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDAzNSBTYWx0ZWRfX4lk4NxCp2Uap
 HuYbVHzAkGeQiX9vKQmzHEeJJsLaByNiWCdT7Kadw03xm2udhYsUYmMaTUYLrxAaNFeXYW9uVdD
 KvdVm2STUvjNcai4Z46pLSE1a0nh7A6kVa0XwEqbNhxo4chvcOTyii/iU3V+qd0pjn6o9rGUTB9
 1pngPmy4wkcpYRZzmkNj7LjFj7luaRBpRu3LTIJGfFUouWwZqBgK/9G27ir1wBUlgZEXDFoCrm1
 5U+04jdXn789BBX8wgZ9r6kcJowkHqwpfDe169qwAFJCSJZ/FgiZrwE5SoqD8bXYhGfPgLIcVLP
 ros70rCBfQFfOstvAoyPfgnF2zvQpk7Nl2/Lrh2RxdKH9cv+cKMhNA9iRynn00lIMEh1IvzbStY
 bOmyUyj5sPZ+H+V2pSre7nLfnoPx3WcGuopAE3RTg8Uj5goe4oPpk9++dA8/AJk+7WMpYt1N

Define ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to ensure
page tables are properly synchronized when calling p*d_populate_kernel().
It is inteneded to synchronize page tables via pgd_pouplate_kernel() when
5-level paging is in use and via p4d_pouplate_kernel() when 4-level paging
is used.

This fixes intermittent boot failures on systems using 4-level paging
and a large amount of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It also fixes a crash in vmemmap_set_pmd() caused by accessing vmemmap
before sync_global_pgds() [1]:

  BUG: unable to handle page fault for address: ffffeb3ff1200000
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0
  Oops: Oops: 0002 [#1] PREEMPT SMP NOPTI
  Tainted: [W]=WARN
  RIP: 0010:vmemmap_set_pmd+0xff/0x230
   <TASK>
   vmemmap_populate_hugepages+0x176/0x180
   vmemmap_populate+0x34/0x80
   __populate_section_memmap+0x41/0x90
   sparse_add_section+0x121/0x3e0
   __add_pages+0xba/0x150
   add_pages+0x1d/0x70
   memremap_pages+0x3dc/0x810
   devm_memremap_pages+0x1c/0x60
   xe_devm_add+0x8b/0x100 [xe]
   xe_tile_init_noalloc+0x6a/0x70 [xe]
   xe_device_probe+0x48c/0x740 [xe]
   [... snip ...]

Cc: <stable@vger.kernel.org>
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Closes: https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com [1]
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 arch/x86/include/asm/pgtable_64_types.h | 3 +++
 arch/x86/mm/init_64.c                   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 4604f924d8b8..7eb61ef6a185 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -36,6 +36,9 @@ static inline bool pgtable_l5_enabled(void)
 #define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
+#define ARCH_PAGE_TABLE_SYNC_MASK \
+	(pgtable_l5_enabled() ? PGTBL_PGD_MODIFIED : PGTBL_P4D_MODIFIED)
+
 extern unsigned int pgdir_shift;
 extern unsigned int ptrs_per_p4d;
 
diff --git a/arch/x86/mm/init_64.c b/arch/x86/mm/init_64.c
index 76e33bd7c556..a78b498c0dc3 100644
--- a/arch/x86/mm/init_64.c
+++ b/arch/x86/mm/init_64.c
@@ -223,6 +223,11 @@ static void sync_global_pgds(unsigned long start, unsigned long end)
 		sync_global_pgds_l4(start, end);
 }
 
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end)
+{
+	sync_global_pgds(start, end);
+}
+
 /*
  * NOTE: This function is marked __ref because it calls __init function
  * (alloc_bootmem_pages). It's safe to do it ONLY when after_bootmem == 0.
-- 
2.43.0


