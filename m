Return-Path: <linux-arch+bounces-13182-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E59B296D7
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 04:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72B4E189F52E
	for <lists+linux-arch@lfdr.de>; Mon, 18 Aug 2025 02:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B49246BB7;
	Mon, 18 Aug 2025 02:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hZeqlQ0J";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="AcOiCTGx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D283A248868;
	Mon, 18 Aug 2025 02:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755483274; cv=fail; b=qi7YnhnnoL8pGzRIbZL7K8BzpluTeoyipGKaIZT7QUraDhrnMQa3DsQg4b2vmCDYPb0DICfntTzoiJUvr6lN8wKgbBpr0RRXmt4Tt6rgv6V+eCCkMLHAY0xzhovlsSrMAI0pbdRVhdkLrOjF1AWDib4AjT73N3yXOZ4NQ35LVgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755483274; c=relaxed/simple;
	bh=IKGgsrgMYTt7G9NcDbT6XY4qEeZOKx5/AjNEMIPIKP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jmDZKMxR2yqYHfu5ipeuQbbiLeZ58V17ywiIQfdBHJ3PHBvbXa8VdOEI6wdtNrUw8aoPcXdtE3E5W19yBM3DzXnHNvbLduUEEEEnpjo5zUuaGOJOJAb3Zn9yqHEu5LmPa5vHzAF7nK9rT85VcvgftFqVtIBgBTSwhkFv3gB0UA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hZeqlQ0J; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=AcOiCTGx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57HLj1HH004380;
	Mon, 18 Aug 2025 02:12:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6AdXyjYn/QFbSOdEeWKF+oZXC9Vp/wvgjuidu4VFayU=; b=
	hZeqlQ0JFV3U4iwhg42GBthe7j8Ct+BWhGxL/4+4pS+KfQ3RaRTnsj37iFYitAn0
	7oi/N6F37j2rFfI/24JcvKT1lSM6pclsChPvsOOiyaqpYJ7cnRBs34/koV1VO7qZ
	rLHQqDv8Y5tgcQyF+B95ivtqY+pM0bygg/rxcA3+6S9vxeRzbLNYf/uMQLc3+Wku
	jSD/h5eNFvUr7bYgfZxs/nF1Js+3zn3PNgfFIsk+9Fm8VKC6Td2j7/RqhvTiCVu6
	tF2BQMhPT+t3HtpZy4uvLF4IcooAxjBxpdvqcFzFBJ9jSARK909IMs6Wz6NH5lhk
	kkIWWgim5svp8s0cPT+t7g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48jj1e1xwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:12:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57I0UoqY036815;
	Mon, 18 Aug 2025 02:12:51 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48jge83jhd-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 Aug 2025 02:12:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPhb0cPDKwamx8Wx6MSjn6DnFZTlX7chrPgT5+0FCZ6swqZMjAlEzTF3n+Bolz2rt2EjTfb2PBGqEArkx2NAZ1lsMjNSN2C2bDUsP83XTZAdUqz5q6njEdH+VlW9wG6DKfH/2hMNS5BmnQx1Cbe/dVJz7LtPJ4DV66ziKBee+ALdzHcuVq/tmiazKb7NfwoLwpDowNu+PzP+IKYjWUqiT1gXrTrU/oh9agfDxg/PTHTyrckZ0EFafLUbjG3Z7jpV2lyVQf0DO2WRi9DyRfdg76oqdguFVLNLQdLkn0m1h32244Q8rnGjnVfctNeC2nfVZGRGhkrhcH56tEMSJXtgOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6AdXyjYn/QFbSOdEeWKF+oZXC9Vp/wvgjuidu4VFayU=;
 b=C9XrQ/YjC7ZR9IlIjNY/g1Axh6WnOMhVZvQpoOqRCYD4wWWENBgscLo6KI5+Q0orlCeq2JWRYcAIRdX+y/dSsSphBcHYvRH7bzCkn09zZdiKsLozqX0dqGjWWWQ1czOdgTcjlZlf5R46MjZLFuFCCRmSU4cvLoEpPYhqLv+BkqzCWZSWHBD71pXqOhXHWTze5/rGsiOkmnqfh1i2QkQWmpSjPg63Q/qsMY4+ZYZVBqupM4FPup6uOcPtZFv+vm6EzigD/Wj5Z5hi+Qib04+BZoodyAEG7vma9gl6LGdhxF6UpFTd02j1PT81+uSIDB5RdktEgDCODi2apn1eZH/JUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6AdXyjYn/QFbSOdEeWKF+oZXC9Vp/wvgjuidu4VFayU=;
 b=AcOiCTGxKckzp92O7Ne6nU+XddQCD5ElktfKCemka8XoAnv4Z+e3T4d4ZtmvsTAZXzFtzSlbXPt4Bv5oz6gwI+C9khKKPjo8BcN/FlTD7iMhy2PibfUM/2mFDctkyuYm+JIf7AMK4zYgM/8ES7q7kQG6bVFpG9hDsfgkg0fIJaE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CO1PR10MB4690.namprd10.prod.outlook.com (2603:10b6:303:9f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 18 Aug
 2025 02:12:48 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.019; Mon, 18 Aug 2025
 02:12:48 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "H . Peter Anvin" <hpa@zyccr.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.de>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Sccakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Ard Biesheuvel <ardb@kernel.org>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Ryan Roberts <ryan.roberts@arm.com>, Peter Xu <peterx@redhat.com>,
        Dev Jain <dev.jain@arm.com>, Bibo Mao <maobibo@loongson.cn>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Joerg Roedel <joro@8bytes.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: [PATCH V5 mm-hotfixes 2/3] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon, 18 Aug 2025 11:02:05 +0900
Message-ID: <20250818020206.4517-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250818020206.4517-1-harry.yoo@oracle.com>
References: <20250818020206.4517-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0185.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::9) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CO1PR10MB4690:EE_
X-MS-Office365-Filtering-Correlation-Id: 148676ef-4665-4d9c-14ce-08ddddfcb9fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L9aZSYBlfToaDbU86uV2q3juR7BNIy07DpLMewfJnZrPglgt2dVQuxFeKfCT?=
 =?us-ascii?Q?5+BTElzPQwCED16oCQh8tQKhXLzE+gHtmYlYAXAg9Uw7TLi6zD7svGDHRzzL?=
 =?us-ascii?Q?4bYzQItNgYMtwnnBUprVNo6AW9USPgvvYltXwquSOSuh8qFvPBCH0LG7CKlA?=
 =?us-ascii?Q?5xTZ6L3r5Be8QOfTGjuqTbtmnHzyQuCmDxo8X2QMnaXNyCkZg/SY4EEYBotz?=
 =?us-ascii?Q?lQhdhK7BLUkBKF2Vy9yKCI/znH0lv0CUufjByy+cTx3WBZnSUCkvaamyl3iM?=
 =?us-ascii?Q?5U396m+9cHVDXt7q3Esp0m+g2gPrzoykEzdAZSpBn4oq0v+8cYTS+BOTDHII?=
 =?us-ascii?Q?w9Y745+TP0CSEE6Zg9+UjWcKZlRGCb5s33FD4yPRMx0qwoxrwMwuI4CWsVYS?=
 =?us-ascii?Q?9N1AV0DrhX/72FsWJ0uBHlfDFijOcOZRqz3PTKCOEUqtqg0ImyGjp12YksSc?=
 =?us-ascii?Q?2evQ/Q9YNVfhkAs4KMVLVATwbfhwaSZtGdkCRWVjPlSCm3jjj1g8JsmLStRG?=
 =?us-ascii?Q?HEWdH2jDI6ZB2iCQQLoIAyisR5DCGqxnQSEc7MqaW/bS5z6dwYC3y/g21gkt?=
 =?us-ascii?Q?VJytJSkj1KztM4UxMdprANUT3IO68tMI8iZpYi/Dd1OiEwseiPL13FkW2atN?=
 =?us-ascii?Q?bUISWdjyEIKyV5yRyixo7quDIVi5gy3degK9mPhGV0G5pTVkIVM84Va5XRNB?=
 =?us-ascii?Q?Jx1g6ZsrcoZUdl2vSfABLdW/mcTFcEH0LLy57aSnkzYnLbgfnPvef4QeHIH2?=
 =?us-ascii?Q?N3yOm2o5hrHvd2mRuWzz5R/InoYDm3puKidmvLVBPPXYQoITRFaOqFRzTd46?=
 =?us-ascii?Q?psUzs+Aen8NeMyeFPV6c2TtH+6qT4VdtZfDrku0z2mGXPnf9YQz69Ka4yy+L?=
 =?us-ascii?Q?0X+IVG3SWUC+AX4d0xWs74fcrWAy/OaYNSK2yyQPCg1m75uB9B46MROQb7Tn?=
 =?us-ascii?Q?PRiu9U1VwdrCSOFnY+E2CZh4J0YhmXgHM6UlDhylYftxqV25zJM9bw/nMZ1l?=
 =?us-ascii?Q?m39QuOuXEJE0mN/giGjCgNgd/QRdGspGcI9cHhG+6mUlyPuro/Hhin9gNtIz?=
 =?us-ascii?Q?KpAvAJt1cm3K16ugMtg7kbjNFoi5wYyemVX7nt61GLxhzGH1oCk7oA4am+Z9?=
 =?us-ascii?Q?Onslrfq4wuu+ICtPlcRkGrwGFjLmaPA0njZfFQHJp2hq1c/E48jF8a9JIuTd?=
 =?us-ascii?Q?yDIalPLwWQvh76O9hLTTBrsSxLEvCTlmBMaqova4QUujGKmDDUj67bOy7T+v?=
 =?us-ascii?Q?IfLAErXph7qJZpkcbSdHWI8QwAw9prhgsYDytVux1u9AZDaK9m7IydghQunQ?=
 =?us-ascii?Q?RV3sRjCAAURiCRYvLs12803QVr9qE5kATBkWc0v6YiYvJ6Zqv9ZxubT4OBR2?=
 =?us-ascii?Q?6Swfi+gLFZoe1onMKaZCCzzBAL9Bl7daJ9FcgC5C1nwZwHoDZYAOd0OeWesF?=
 =?us-ascii?Q?knsz6Z2nJhM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0mjVAbfraG9RQMF55m3DFe0Ce6Fcb1bBY1nts44VYSf/buLcMnY11hWnbt1O?=
 =?us-ascii?Q?OaGCh5GAwElm+WJHUHlfAIwmEtGFfRIEdD2h4fO8Zn2b9IikDqolvDw03jGq?=
 =?us-ascii?Q?pGMFGuSQgUbQDF9jO3Lu0h+zjky+wqyzfqkvMI7/xp1gZ0GWt005m3tITOL7?=
 =?us-ascii?Q?67CmmkMbMYHnooQ/S2mG6wCVu+tzkQV/keT0cgSY5Q8b7IMRb2n8Uo8j369V?=
 =?us-ascii?Q?cYFRitMrjHF0IpJHb4sD+WE6FoUuI4sxts7ULl/bREzHaMhhpL/Ju51rfNm5?=
 =?us-ascii?Q?vRjDWiJTlwUXKc2fwEGu4gzeSaMsjGq+a6j74EjMh5q1jXpsFw3UCWqb1DMx?=
 =?us-ascii?Q?7iBCPqSQQ64otNsAlcHrWsyk6uohaqwamktLZPmqN059UlaAvzf/W0NOC1fE?=
 =?us-ascii?Q?KZ1VD60dMvwT4n8JM72bvMYBMKJqJcSb/zWood1kRlYhCg6JJcB36lLmoTVy?=
 =?us-ascii?Q?tC0/caadvTrjJuF7gNO9XbrB7/wN4Ir0HXIpG1m0/TRLEBYhGgr/pA4xR08n?=
 =?us-ascii?Q?FOTd9xqR1p4yuEjAMDTc8Ul284Ee60+BJMKddqW4jksoYmcAI7cqEc6OTJsN?=
 =?us-ascii?Q?NhEE4jVH0iNFtzpnUx9hWmBVJBi0S0cjc4+1qTpt3nJ0FGxlyTeW7uw7Vbvo?=
 =?us-ascii?Q?57EgfNcLSIzBT7dpuHw1nrRiatWOuUyEw6sYNqNWpRWdgE42nQXvyhWx8SuW?=
 =?us-ascii?Q?OEu0FEss0GjG6limYtr7u78WV8pW6MMgY9j6AQHc2XOo+hFofPpoke1YWgLi?=
 =?us-ascii?Q?FjPL/Ot1E0COaEY85u0qfc2dTPVXOEH1/wDMXfelR4Iap3E4S7CHxDBjNmwi?=
 =?us-ascii?Q?/Tvq9w2L1NDarRiDeNMS423cLQ7GKPwibyV3+Nh18fCuCtbn9qp6rBzrqY0/?=
 =?us-ascii?Q?Z44uq2OeXu/q3q3e7RGVhidn7QRtX2A97gKbr4yZiDMFROyyIONuJlc16uBB?=
 =?us-ascii?Q?qbh9xZSFfwrtA52EocyhL0IUiN5gVn7y1M3fizRFnOdzH8+y8TW7b7781wNa?=
 =?us-ascii?Q?7Ex0U0Kh2uGTL1e5hyRLfHiEiQwsNP4OZi4FXyn0RVkPwjgtuKHxd1n1QH+O?=
 =?us-ascii?Q?R6ylWiSNXZKnqEr1Dgse3zftzqnif+OYKGjw6oXY+aw6lJcRTtrHOuLN1jHI?=
 =?us-ascii?Q?iYT8VUOr+u4TxnItM4tZn1Yze1UaNtAIEVB2qqI7Za7u0dGSX3uuolhl6X8C?=
 =?us-ascii?Q?rr90HnoCiwm8RpRDrsnlUarTW5ufGg+oY2G8NJXXaKKa90LmpmOH36gtpTW2?=
 =?us-ascii?Q?/q6MTJMr0wHXRd0v75rB5S6hMvCXH6evvdAQ0zglJi6S6aub+9cz3Huu3hNv?=
 =?us-ascii?Q?fv4ZJEcGqnvFA3YUjvVzMAakBXaT6fzWCoiQvZQe32UFkwAk9jkVZ7k+Rhmy?=
 =?us-ascii?Q?Fen1zKYSJM0DuUNHk8beeH+Wl4dGEANp7wz9fnz9KGp0Dga/NX9SnVkgQfJF?=
 =?us-ascii?Q?m6ZEmKsKHkMZ2qnmXUqXckJNDh0YD5ZZsKhKHmiol1VovOUc5yoWz6Rhykuu?=
 =?us-ascii?Q?B2Ul6o28kkC7fqohQdh7WNAkLVFFAeEDAvcOzRaASUiXTgj16Vb2bjL0TZGq?=
 =?us-ascii?Q?6MAkBsoaaD70S3f4MP6qTj/ST6ACTWy7tE55wPES?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a1ESTDKrsZ7vFfb42VM2cPVaQKNyEkSjrvxbkJT/JBR1b1if9TgIJdhMOX0RPHZ2okQ3JKrI9W+gTo9BZw8wxSzg8EjI8KqPbXpnR6wLHGYfsBZgfV+U6P5ys9BhESXaF8ixXGsyYyxCVO/mV4Y9cokHb/V6/7+ufVnl+PgCd4zYUPbXhhXYDKTNqOHbmuJJb9TQ5k5jXWSqLzVRMP62GoociA6ViChQBOKEaW3SX8OKToNHudYSB3kPLaEEadkfWzWsggqbUO87M8znUopkxSBHurgBb7OwrqyMfFeQIHiBhwm3qhbLesMwKd7uEu9QFJouzVYoA0RPvMIOY6c0gDjLpTvxqwdygu6YF28qdswYHqUTNxFlk/cXQaXdnnz0W4HDL+LbMDLBxhWQTJmbMb2D+2kTMKBLX8GM8ovaWSpI5N7As6/ow4smtgDhDuU6yw4ul0FKA5WQsdCR9mWLShmlVrYIDHLaYuZYJVgFQPMFKCBW6m6MuB0Ogwywb9YyKUHCcaOpJ9E+0v/slW5OQi1oizDDg+Hozh9htzZlji4MgyZX8C50UAcjnDZFCG/n9PTm8UpUyz4dY1gzpipdSE8GAIaHgkXPtb6jeHfg3VI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 148676ef-4665-4d9c-14ce-08ddddfcb9fb
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 02:12:48.1056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mWrFSOwfKEMTAM6CEciOcgFPFaH8sQtbnwPFu/1HLQSYVmplpbjeSyoDi/DRJJTlQvyaORCnVRpwPZAONjTODA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4690
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-18_01,2025-08-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 adultscore=0
 spamscore=0 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508180019
X-Proofpoint-GUID: ftcX4-nH0cewo0ZLOTNRwvkox8HVY4O2
X-Authority-Analysis: v=2.4 cv=dN2mmPZb c=1 sm=1 tr=0 ts=68a28c24 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8
 a=3FZ4Hy8v-MDjy2TpQZEA:9 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE4MDAxOSBTYWx0ZWRfX02uZd8Q/+DAu
 wgMUBQNQZ9f4WoTb0RVDeSj8P2MIvAVDFi2MDrTTXcrRuRv7tL6fWwAHILaNIgUt6M/Z6CUhxYm
 i2HzNnBvURKkrtm90M5UehJQIZ+cYQKcg5y/l55MsDN8VkGGJne+ZR7oLYMamNkqtMopdRo0fpW
 c98xGvqhFpKbilLhx0t/HQ2q7kA8XnBXojg1oYaBDtiNGVnB+ZWvL4F4J6ZGXKM9xJBq4Skqcax
 +Svd/7YtvrFqMAAsMyBiYymIYUvKjKDSZRjIiiyIS3MTvNO3LjHLyb7zHebMa+qcoMbcTgltbKr
 c7jGxQskmDnKxThl6UJCkdutLjQio5gee7elUT+RmrOFPAHC/CFEyGEqVOnXyrrQPznpNBae4kV
 pPwh+AhbMeqA8x90bM2mz/E+bB1FCPqVRXoS6tTMrhFMxk/oiivWyStICGGKQSf9v9WfDbWK
X-Proofpoint-ORIG-GUID: ftcX4-nH0cewo0ZLOTNRwvkox8HVY4O2

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.
These helpers ensure proper synchronization of page tables when
updating the kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.
For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
direct mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables. These are introduced in a new
header file, include/linux/pgalloc.h, so they can be called from common code.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced. Currently, these helpers are no-ops since no
architecture sets PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

In theory, PUD and PMD level helpers can be added later if needed by
other architectures. For now, 32-bit architectures (x86-32 and arm) only
handle PGTBL_PMD_MODIFIED, so p*d_populate_kernel() will never affect
them unless we introduce a PMD level helper.

Cc: <stable@vger.kernel.org>
Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Kiryl Shutsemau <kas@kernel.org>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
 include/linux/pgtable.h | 13 +++++++------
 mm/kasan/init.c         | 12 ++++++------
 mm/percpu.c             |  6 +++---
 mm/sparse-vmemmap.c     |  6 +++---
 5 files changed, 43 insertions(+), 18 deletions(-)
 create mode 100644 include/linux/pgalloc.h

diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
new file mode 100644
index 000000000000..290ab864320f
--- /dev/null
+++ b/include/linux/pgalloc.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_PGALLOC_H
+#define _LINUX_PGALLOC_H
+
+#include <linux/pgtable.h>
+#include <asm/pgalloc.h>
+
+static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
+				       p4d_t *p4d)
+{
+	pgd_populate(&init_mm, pgd, p4d);
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
+static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
+				       pud_t *pud)
+{
+	p4d_populate(&init_mm, p4d, pud);
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
+		arch_sync_kernel_mappings(addr, addr);
+}
+
+#endif /* _LINUX_PGALLOC_H */
diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index ba699df6ef69..2b80fd456c8b 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1469,8 +1469,8 @@ static inline void modify_prot_commit_ptes(struct vm_area_struct *vma, unsigned
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -1954,10 +1954,11 @@ static inline bool arch_has_pfn_modify_check(void)
 /*
  * Page Table Modification bits for pgtbl_mod_mask.
  *
- * These are used by the p?d_alloc_track*() set of functions an in the generic
- * vmalloc/ioremap code to track at which page-table levels entries have been
- * modified. Based on that the code can better decide when vmalloc and ioremap
- * mapping changes need to be synchronized to other page-tables in the system.
+ * These are used by the p?d_alloc_track*() and p*d_populate_kernel()
+ * functions in the generic vmalloc, ioremap and page table update code
+ * to track at which page-table levels entries have been modified.
+ * Based on that the code can better decide when page table changes need
+ * to be synchronized to other page-tables in the system.
  */
 #define		__PGTBL_PGD_MODIFIED	0
 #define		__PGTBL_P4D_MODIFIED	1
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..8fce3370c84e 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -13,9 +13,9 @@
 #include <linux/mm.h>
 #include <linux/pfn.h>
 #include <linux/slab.h>
+#include <linux/pgalloc.h>
 
 #include <asm/page.h>
-#include <asm/pgalloc.h>
 
 #include "kasan.h"
 
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index d9cbaee92b60..a56f35dcc417 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3108,7 +3108,7 @@ int __init pcpu_embed_first_chunk(size_t reserved_size, size_t dyn_size,
 #endif /* BUILD_EMBED_FIRST_CHUNK */
 
 #ifdef BUILD_PAGE_FIRST_CHUNK
-#include <asm/pgalloc.h>
+#include <linux/pgalloc.h>
 
 #ifndef P4D_TABLE_SIZE
 #define P4D_TABLE_SIZE PAGE_SIZE
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index 41aa0493eb03..dbd8daccade2 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -27,9 +27,9 @@
 #include <linux/spinlock.h>
 #include <linux/vmalloc.h>
 #include <linux/sched.h>
+#include <linux/pgalloc.h>
 
 #include <asm/dma.h>
-#include <asm/pgalloc.h>
 #include <asm/tlbflush.h>
 
 #include "hugetlb_vmemmap.h"
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


