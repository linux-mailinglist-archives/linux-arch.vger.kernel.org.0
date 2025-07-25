Return-Path: <linux-arch+bounces-12941-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B83CB115C5
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 03:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 739F3588603
	for <lists+linux-arch@lfdr.de>; Fri, 25 Jul 2025 01:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A201DE896;
	Fri, 25 Jul 2025 01:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rTokkA0V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MrF2DdsE"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C957191F92;
	Fri, 25 Jul 2025 01:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753406559; cv=fail; b=mzTLPdX4CNUk1i+XCIGKd7IEAKXowb9hImu0fUCEUIECrjmii0O25CQ76u7RwiGSoBBIHzE2RHcSNic0V835wHP5o/vxeVQ0vO7gf6Dq6bkj++c+qNnL0k0W2tUmPWOMTvrE4sb6Bnoe7w7LUxjPjbPUSC4n8l6G40vnrKnoikQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753406559; c=relaxed/simple;
	bh=A5UL0BGWkY0B5cmDvkVAk52EIwYTb8AMIo+54+8VzpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EJNDL5zze9PDvb9xshtm1g6ftWwySh1NfUMT2FWGjdDyk9H2lN1uY2HqaIx+rFPpqVaAWkt5F2SZLBZ/Kk1ISoxt0O7QhYhiCM/Ek+fzcoHyhkjcn5zSzVFNnBy1e3h5csyvXDJ1D6FJ2EDsnUgucePnMlkSlB7ur34eMxo4WnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rTokkA0V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MrF2DdsE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56OLpecY009166;
	Fri, 25 Jul 2025 01:21:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X74rZ+FJ3CN47J2HjggBnCBdDTufSmIaU4MCWbm1zfw=; b=
	rTokkA0VggxxDggKAn0qZCXz3DS/+0o0wEebFJDXH9PyE0seGlpgO3GmTbVBFIee
	GMxmwMZo1s+SxZ9MHOmaBM88WgSLt4R2sSU7PZcN2/K4pvWFLQwqtWvwQS8YQF6x
	ztvTgILQKGBAsoBbvoqM6ejfj4nfESG2EiSjy4OXUzpLr1Y4yLvXXs2Hh+JZmUnv
	bVthHTP0V4omuDwzChRGBJe/AJDYk8yr/p4NnuyivYXtBHN6LfGDPH1d8qdDPeLJ
	B9qelZJSvt4ZVpZITjZ0YLhO1VEEU+q+aPRhymsYnVPIY/THWgtBVeSHDeqjq/wi
	vVQBoSJh0gvj3zmN40W7oQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 483w3wg5yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56OMPLKf031536;
	Fri, 25 Jul 2025 01:21:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2059.outbound.protection.outlook.com [40.107.236.59])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tjunrb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Jul 2025 01:21:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bUQMN/Jq1IVusRD0u5mTG+h1H3KE9chpBXOIX9AOn1bf5+GpWSwputM1RE7gQKzMsauaXWv/ydMKW5vwoBY/xtoSpaUvhnK+TA5qceVQYqah8n/7C7f2IXg/h+pppdO5D4CUbHQDAisc8NVoQ/kKmQSiMLAiQr3yPpBZQQdAfRL/UleRis4YoznEH9fxMRFCDHoDGkpQjdVqyVNMwP8omKEov+SKAwZUC5F/LQC3s8tThAuF6mXifVbKDTRvvtOKWDPCsohWIZqQ9A5SCumNefGzl4xnT1KHL6GxxK3Ead0JRkPB3kA6FznV7m52kIUsJCFCWY5FAIs5CttOKzFjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X74rZ+FJ3CN47J2HjggBnCBdDTufSmIaU4MCWbm1zfw=;
 b=ocAki8t3HKD1dTyMeIwtuhnwtBwXV1P2+YVQ4vKNPvySFhBaCCThCYUk7fmHxNzR/dRI9idY4/pTY4bejHeL1FD7N5mWt8A6V9DIfGh0bW1+biyd3p2Pb7y81jui6zWKjcYgE+N59b+0omUxTiriYZW5CsB308U5i7wvXREBcn6PxG/vV1SFQfujNQyA+Gdg8bNOyYcyDJscUQCe6XakhQj66XNhLEdhuv8tHkIDjlKlTGKm9JYgQRCqGyIG6bLU1ir0dT/1O8nvFw/mKx6g1Vvom+HRjZxbpjH4rXPg/Et4B9kh4qkRd3P51zorBbLxgRExMsajUTvBZomBAzPVKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X74rZ+FJ3CN47J2HjggBnCBdDTufSmIaU4MCWbm1zfw=;
 b=MrF2DdsE8f8pNLd3ykboaJRPfAgeYOFN4PPhQtC3E6vbKojWNKE+dizvidC87nn5ghYoe/ShzIPQtu/tM7jHi6gZxPPrCK8Bx2EJ+I2usqMfcyRA/tSx1oxt8Uicw3VP0VdXd5xscay4NOaZTDhTlYKU/x9HfKslVfV+L5skTe0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by IA4PR10MB8351.namprd10.prod.outlook.com (2603:10b6:208:56d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Fri, 25 Jul
 2025 01:21:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.021; Fri, 25 Jul 2025
 01:21:29 +0000
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
        stable@vger.kernel.org
Subject: [PATCH v3 mm-hotfixes 1/5] mm: move page table sync declarations to linux/pgtable.h
Date: Fri, 25 Jul 2025 10:21:02 +0900
Message-ID: <20250725012106.5316-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250725012106.5316-1-harry.yoo@oracle.com>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0061.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:118::7) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|IA4PR10MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ba90b1-d3d6-46fa-d388-08ddcb1994b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zdFijLnAdzc6WeEOPRIJHQf/9Iq0X2dHyKogBcWj8AsPchZ2FjOiXZjOhkca?=
 =?us-ascii?Q?8ERe26FZ3PnePtYI7G1aY7IvpvlaoGGTj4ebcLk9eGqGQfBFSIdTnEUMNk/e?=
 =?us-ascii?Q?g90sgJwi7no5HnhyhrXIHBrMVUPa2VP0aFXUga6svriuxuYfz1scHemM8QJW?=
 =?us-ascii?Q?ye0Ka5PSMyYXfWW5u3iIt+mXqTYsytmD/e2v1rIyRExewsQKxkhsKbNvWccV?=
 =?us-ascii?Q?DK14FXfKvkimnNv2kLuRMbCQrQgY49v5O/yCe0/gL5WSCs5S43LrajiJaRpD?=
 =?us-ascii?Q?/LMn04jxrR7sYse1UBxroMNSAFSdNtp8F6g0wUuRCcu83mgtboTY4OLjkG9j?=
 =?us-ascii?Q?HSjxCk11GwdVQ28oL4Noaz9yIfbEgDh4QNPwDUnbJQWRbc7xm1ajgbG/mMw/?=
 =?us-ascii?Q?+F0+7m1ZdEQoqfyoyOts34xbpyK/ZUamoVwdOdSfzw6un34M/+6wZLPH192t?=
 =?us-ascii?Q?s83HTAOcCP0VtcxKpaLYTcNymBXvURws9idXJ0RQt9HBBcwYHW8Bl6wZWCGT?=
 =?us-ascii?Q?qlIRxz4rAX3Xi55xU88gRDlXzdJ0TxmuAoooGR1eL4RpnyATIGvxeWfHYWkS?=
 =?us-ascii?Q?x8uIMgldpTc8783icimtHolIUCeQ6X4BTGEBKRL2HQvby3x9WlSaIqtXZpMC?=
 =?us-ascii?Q?IHHvrpMgLvM0FPvwMFlL/MR1VTIOyc2WuKjvLwofW1qH1f+EwJ1LrIYxKsPg?=
 =?us-ascii?Q?/RFxODct1JMr8qGVOJxHTyDP8MT3Ho2yCZoai3KW/C8D5OVYS9tvtbeuBWL7?=
 =?us-ascii?Q?NczuSOg3dwgpRcG6ongZFAdYAVPtKdWsBcETQ1Sh5n8NKc+Bb0YjDYW9TwZX?=
 =?us-ascii?Q?WX2ggRfui+xmBdKzj6HRio157v2hOq1uYEx5AQJZvsiLox3uLTPLCCQk/JHh?=
 =?us-ascii?Q?KRUHg7LFIiJG1IBpTr74d0hOKn5uYBsHrXlS6DBxw77UT+yew2dWZrABnecv?=
 =?us-ascii?Q?6dkLIcrpI3IbdTH9JKkT80b/I7Um3yJQtsibYKiICkf6bkdJ4YOMwvacEGsj?=
 =?us-ascii?Q?T2bFUJJEcMhAlWz/1RKpp0+ub/Axos40e093k//RHs2I+uv4KOgGXxu4dpYq?=
 =?us-ascii?Q?ztNmsX5+myegZkdHcjHfiBKXEVRRfM5hfgSUroVLc754CDaCWOV0/8z2bXwS?=
 =?us-ascii?Q?cE/XNxqAB09zHks7ajKXFJvEH4pR75uumcPZc38uOm9A+mKAxz5VnAIigyPK?=
 =?us-ascii?Q?BbMiMoMe4JPweoKPT7Ng2sEbxCzkCDnQYtAa2M2Kgh+6LX5/5KpjOnFLeaxb?=
 =?us-ascii?Q?I8+xG6ZIUP9PcH7ziuxVjAY6diA39ZHclatBh8taJdVDLqElmUspoLurO33T?=
 =?us-ascii?Q?JA+YzkPHg2wSGFCjMMWJ95PI7QKyJkXVzlqUX81nIAa/QXGkJtaJupc/q8Xx?=
 =?us-ascii?Q?WPE2f8kTYuOVmpDPQg2Jj82FBcK1uiuSF0zrFK784vW0oJ51djK6xXjsqYxS?=
 =?us-ascii?Q?tdD8kwCNaJQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DLTyBQYstpS4h4VUH3D32PWzQxe8OwpAkbkhkm80yrBXqJ2MXdnK/cXv7Hdb?=
 =?us-ascii?Q?zwYdM54J0ACbC1HnJi6SqtDaqp8bo8bZXfuu1ELCQa71rDTtyaJQCrCSlP0s?=
 =?us-ascii?Q?qdxIiPsBQIJM2+Gx3oOcLIVw01VoJXglWL3d7O3dn48i3XF5mDtK+m6UEybc?=
 =?us-ascii?Q?FPSb6j/pJfX1BeOlqgvdERraHCoL5kMbBljHdMWBSHl/pxH60SbfFrm+ByF0?=
 =?us-ascii?Q?+Yg/apii2nCoMvr6YEbMMVloMueOJxOq1ZSy+FSs4VbTEl36Qmnez3Ps007A?=
 =?us-ascii?Q?4rZWBI+5yITqr0RFIvPl5avR70Em/c5+g4KUhV9lmUiMpb/aEPLV9rRCa2Vb?=
 =?us-ascii?Q?FMmLqMRlAKznEzqyav/js1zKPuQt0eLykN98B2UN8sEcHc2zFAGqoah9lwNd?=
 =?us-ascii?Q?AKbJ87bjS2sE1IXerEi95hZ7eIY2opY3UXK47q7LJE9ktKp4490woPkjdDQn?=
 =?us-ascii?Q?VD8dvSyhzRV/lhptpn5ytQaRPNX8nDLlezii8ubnprv7tJeJ+S0+JqoFcj84?=
 =?us-ascii?Q?On456+R66CgvHmNr/HV3gRXDh0JGewW+4nRFdTfqNoqh2bEYL7EYFaCeNqW8?=
 =?us-ascii?Q?yHHTcsYA+zgD342CJF92Voul5wD7iLttb2LxKvSkclasegJe8m+5vcKeFJHZ?=
 =?us-ascii?Q?As8UNfQdSxo0OTaOcXqzPyXZG9LjL1y5W3s6+XJeB38OeWKRTRr9xk03Bajh?=
 =?us-ascii?Q?7wj/ok4vnL0kRNoz1QJGQ8BoM49XWZLMilLtsIe6lRuYzd//iZoY8KpNxPKe?=
 =?us-ascii?Q?c5eDeh7BvtX+brYhcJqfDDdDiKQVHpBqnD/JS12uUs7R0iwQOwWMAEmvKDvi?=
 =?us-ascii?Q?9m6et0RD/T1c2QxAcWA1J7rLKgsmPhOneGhhNSgOgdsBS74G/P9B2C/wNj4T?=
 =?us-ascii?Q?iw81bswsd3zZVxW+iEZqn3d7VJdR720S4dHpVHvxY5LXtfg26DgBabaERQ+A?=
 =?us-ascii?Q?EfG63xYyhNKfh8FNuZQsSdqgZAOegFyQnHNXbVCLfbJ1j1rW6hRHJJ+fKW66?=
 =?us-ascii?Q?omUnd6Gu0irpfb7eO9Izy1lpNRfZyr+fBs2r67avvqP70/FgGhMSWymytcXL?=
 =?us-ascii?Q?COT9VSvAj5przHZ4Rqp2HVt9WhBzQjk+MxwSU3H8Zt1nZzGzAnk8XqgbVeW4?=
 =?us-ascii?Q?1VhCMXQRnAnbqiFOcWPcEe40r42XJMTKA/nvumN1LO2wthW8YaNJeRukk+dr?=
 =?us-ascii?Q?4aZKcezxhhyf0e/jVAJDptZT7Z80oyj3JPT43pHvk2dASV+cpU/2RVV0XMYC?=
 =?us-ascii?Q?3B3q2sJ6l7uJ38SeSKGItJlSlSkTWH+1r2JZDyCv1ZcxO8Uc5+mawKug5iyf?=
 =?us-ascii?Q?XnMPiIWOs6eaMqE7m0P5T1mPyT94x6xpG9K5xG6XxZwvROFTZJqwYSNjB9h+?=
 =?us-ascii?Q?diRFs2sbvAyRZS0dqw9QSxM6qCUjpWCH9+lkDswxMAmWtQwaQvXCGOy8TGlJ?=
 =?us-ascii?Q?TV7rIRBqjKyFqPsXP0foM9xh+xPJU4YwaWz1LtXiL2+UyiCI59XYQQguQcxg?=
 =?us-ascii?Q?p2z891byLv+ATR2APcLZtpJovFTQcZHZil9fkpwjmOtnGo8Ah7Ew88sPnf1F?=
 =?us-ascii?Q?mzsl9NECm+ao8PG/IRdDpyhGbrLvgYi5igDUwKBX?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	98cZ4xiY+2N+KPxus/RohOPX0DHbwI0jbAj1Myd/wOmJupj6cKov6Lc/6lxtDlyeW3ad9YrmwWtPgiENemVCKI63IWWEJ0yLjyy402UjaVwzzCYgKxrS42ryLnWxz52oF3WW77ySB00PrN/1qd0f6oSXiK85WZf8hxMyct2ouwdl/0i0AvueYA8g7+F07ImcdRsixk4iVHsIhk0Xe4XQ810dvUYKRnbFpJrc261oNfXZQ0/+0i/KVMpv4WCQTQ3tzxkCpQ/eYqHJyzPhZeqEWqO3zIcj3imazB/8Wc9+9AxXUXwuqJPQeFrgZFQQbakTS7M0BaLqNoURYaQOx0Tmao9Jctn8ajl81rbc6DvSZdKmr4+4hC5wUPir0ODXVM0tKxoUGpdYlhjkIqNXlIjD6Yulnsk2ShrdrLjEvDuA8A2qvTo2EbxdLsDsGqq7kGQxkakjg3iShIlxsgNEUEuwTGH3pd7g6QfduvRB2xMnlWnkRCz/CaEGTWpCIxhQoELFaSFAcpzDiMRLDITkFfxasT+fmwl25WYLSYk/f/Uc0N0CWG8Z3JhTlH0A1PN//e+mprm37CT5di1BeY/7sE1kjDxaCo8+A0HAAvEZoClz5pc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ba90b1-d3d6-46fa-d388-08ddcb1994b3
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 01:21:28.9650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C+w5NjzoLFS+rzscxCgMgTLoSmC1K5yZsoZJ54tS62DUJc+V99YATQYT5pSm5XGgp/JOK1ADVGMQBJLAK0XLbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8351
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-24_06,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507250009
X-Proofpoint-ORIG-GUID: I_3aYQbumIC7MRYzzDxtAZbOB07pZfg1
X-Proofpoint-GUID: I_3aYQbumIC7MRYzzDxtAZbOB07pZfg1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI1MDAwOSBTYWx0ZWRfX5bXUnZ6E96lD
 aMcYk63CgiXPl2jboU66RHHYVkl+JlNZlsjrH5G2gsXaZqTAsjutr7ohQoef6cXYIfYZSmruYKm
 fc6xyaLwuipKp7ky6L70xqXoSTo6JwvBEOOWs6tC0KOx3/ayHf6H6UPMWEOyDZ/56dFJnnIYnJ4
 OGb81F+ub/A7YaV9HSlnBOBoWOtLLZOQu9ajgDDphzFoep9ejGpZe8CBOsDahxme99490hXMmId
 /nfAQ3wuZr/Zjm1G/RGdo+zg1teZjbfHPojS0JeKSDE6i4n/qYh+Ir+wZ5YmWOfkYnQQdd3cCuL
 u4PWmu0e8H0GS3ogqQT8MSQ23DEmPiG337csL+zT7/DvJAfJWMZG3EMUe3JB/n2Tfxlrt2Xb+4A
 ggZEDwi8R1/gIa8xdPNwqf+kDBRH9YJpylQWJhPwxPy6FSNhfhfaJvpz8TigaPs1sJdqS8K8
X-Authority-Analysis: v=2.4 cv=Jt7xrN4C c=1 sm=1 tr=0 ts=6882dc1d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=uplis4tbhEJsONv_2NwA:9 cc=ntf awl=host:13600

Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
linux/pgtable.h so that they can be used outside of vmalloc and ioremap.

Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/linux/pgtable.h | 17 +++++++++++++++++
 include/linux/vmalloc.h | 16 ----------------
 2 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
index 0b6e1f781d86..e564f338c758 100644
--- a/include/linux/pgtable.h
+++ b/include/linux/pgtable.h
@@ -1329,6 +1329,23 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
 	__ptep_modify_prot_commit(vma, addr, ptep, pte);
 }
 #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
+
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 /*
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..2759dac6be44 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
 
-/*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
-- 
2.43.0


