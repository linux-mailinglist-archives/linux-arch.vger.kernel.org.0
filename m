Return-Path: <linux-arch+bounces-13120-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E23EB2087D
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 14:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DBCF7ABC20
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 12:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D7B62550DD;
	Mon, 11 Aug 2025 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oKVSWCA0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YEPzKzVv"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6EA26AE4;
	Mon, 11 Aug 2025 12:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914393; cv=fail; b=qLtFJ5ptPCqsYWA1L/PBV/CiXtwNbro05B2wj8Ng2CqyRYWncRfSnmc485HJCgONWrel5e2p7tOx9kRMPRP/66IH8bRAJPgHH4+3BfuPnPiuybCJKZa6FadvYbtiSMy3owj0eKNXqwXzACcylEf/L1Fbrhs7wf042hZ640ZMAWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914393; c=relaxed/simple;
	bh=4WJ0Jdo0/H1KhVVv7Z6LtSghlxleP1V0UYQFK0YJGYE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OWtR7BRTY+X5lI2Cin5jNVcJf5nDXHpPmmLvGRBEwiH8eke8jL3rU9AZjlNbapIedOLymf0PucfyHWzsO3z3wcFNz+2oF7/sNcHHI91ZcWJqxWXOO1m675gSQitCG//aPLiTlgMVMfkjWtnNbFPVNVtpco5O5U9KIlTmi5wwp+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oKVSWCA0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YEPzKzVv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uBLt007869;
	Mon, 11 Aug 2025 12:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VaIVw/6hZR9ypX2Uti
	Y/MRaDmzBv7q9zr32xDfVvCz4=; b=oKVSWCA02Af3P6TI0sPMwlnmpmweK7BRtv
	qb16dC5A3xT39cY9ihjS+J6lN6LxGUwljUW41VF/QGVEn7RoCtSqrd97vTzlXxnK
	AVB3gHqER9tIVGNXMaiN2aa4BY/TdKWWafHmSLmuUsJXQSBv/R1v3yy/QhOk430b
	6iQUBxF/NsTaKFp8oz77N1HrZesF6s4GZiyhQsKQ+Mo++ftiSBajAuLTTp2IqM0/
	4p+d/VFjjBEgezKjzVkZM94pCXT48t2oKZmSBVE2IQX3/0hJsiruztF6VcnKu0u9
	wXRzmA2KkvFKewF5iwalwB1TH53uVuORPQzI5jRLlai6qCRiT68w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8eab93-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:12:27 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BBBLnQ030164;
	Mon, 11 Aug 2025 12:12:27 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvs8jbcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:12:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pu9fCcke3BBbOtY+ZvEXJv4WjV5GIJK9MpiUo/clptf2RPC4PFBEbulaqW63kI+q0uFcqIJWTKnnXYPREwFq191WS4+i7LNI7q3sLlPF9CnYfJcmFxemojykWVgSBlsPlrAy9t8Xh6g/Y2YBDEe1sK0J7WOtsCfYzLoaWk9HWP2M9X7p+frWb/bp6+vvJjjE7RaPTzWi06Mf9Hgnh/0zvdV9R9ZlaN72+m7hs3vLMsKBhGyRZjtrOAX1DSW61UKmp5G85L0+AaginQVPU4Ztjplx9XG4e0AjIDECry4Oz2DS/L27YkWNV9Ch84jMxNr9lpxvP0TFdUDcMc+CzlsfGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VaIVw/6hZR9ypX2UtiY/MRaDmzBv7q9zr32xDfVvCz4=;
 b=Mzp3K+SLUhFfTBzRiKngmNEzhyZExZpyQsCqv0JiGS4rxAj6dDUTPelizDTB6DM99fikl0EnvQ09ZspnfiuIKzneJx8L5acsWpj9GjNRyyiBeDHDeu+lkuJNGyWWZ781OXXpex+176JuvwS2lIaVhSzM1C/y1cP1ewX4fdjDfVOOZJsMKknZbGdGa9Rt+kwo9KFSKjLbDGYzO7ql8MdYUWBny0m+D5foKM4z0s9LP+HTa8JhmaAQWI/7AcfzgR21ER7MvWlexIYDE9QR6ma4WGCeHNTNSSps/ruBY0NLuss9O1YrxiZzX/082qPqG/U/lNsJgO+hI/sqGJ8wmRvtZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VaIVw/6hZR9ypX2UtiY/MRaDmzBv7q9zr32xDfVvCz4=;
 b=YEPzKzVvcLfP17QA2qy/g1jCg0T84ScSxdGTmExCSjzalP/WwJwEWSdht5Zvrvzo37J8OsJrz3IXZzkpMryiZAaQr5VVBSCS93SXk8IlvBbKo3voEipZyn1Q0nazbaHSuAJzoOfF395Gxk5hNfr13Z7yDSOsJzHUqWofGMHj5dI=
Received: from DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) by
 SJ5PPF6A2C0CCA1.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:12:22 +0000
Received: from DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935]) by DS0PR10MB7341.namprd10.prod.outlook.com
 ([fe80::3d6b:a1ef:44c3:a935%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:12:22 +0000
Date: Mon, 11 Aug 2025 21:12:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aJneGJSJcltEIT41@hyeyoo>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
 <8c8c6895-53fa-4762-98a4-886a53903341@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8c8c6895-53fa-4762-98a4-886a53903341@lucifer.local>
X-ClientProxiedBy: SL2P216CA0225.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:18::8) To DS0PR10MB7341.namprd10.prod.outlook.com
 (2603:10b6:8:f8::22)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7341:EE_|SJ5PPF6A2C0CCA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 5486cef0-e2b8-4409-4736-08ddd8d05381
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EI/Ylp5wiJvuewF9g2IUjr5KzTeN6VaIMolK6vUWvJ9yvPDRL0LmkIMdDp5x?=
 =?us-ascii?Q?g5GiTXIOwB1AWsYw3I9yH5zsTxZO9Vm7QQieDmsfPr51JimgAPh9B+KkF2Rt?=
 =?us-ascii?Q?DP49G3kMG87ktPKPCDnaXXH9wWiGt3cgJVUFm11lnWh+ZO0wcFkW7SN6fLdK?=
 =?us-ascii?Q?r8w34JoX5OU/ia6qGi0GqIVlfiBLePTcUlqnmnCFIfBX4LUE5EkpVZxBavW1?=
 =?us-ascii?Q?IL2twl7nnv6mdbSeOyf69HW0cnozrm4Ny3h8j8wi6GXXEkDLCtAS7021Sr8t?=
 =?us-ascii?Q?CEHg022XCZCC6YwOacVDaSuBUjUOTNnWlSZeRA0K5PwrDwe+Fg8MP5b7yIDp?=
 =?us-ascii?Q?y+7zlMxQuIEUA4d45nvjTNYHSjCRKLXmelP/oPFAp0Fi2bV3tfv0wEWtAE3u?=
 =?us-ascii?Q?tccza65PPQq4Dg91rz0cmzaYfzQooLIGGSVa/KOgsp6mgdyc/FXPGqNmbdVD?=
 =?us-ascii?Q?Jy4NG8k7stE/oMxRUG9mdcTmVxxuQTa4ZYAoWHf6LQCuBlwFj97EWxYx2tkU?=
 =?us-ascii?Q?6AP2GpSr+xabXq5Ms2RypB2n15nqbPqystG06XuBHVd+IFKHkiKgC/lgsZSP?=
 =?us-ascii?Q?jc09mzVVPzUNYFfVQpXAVaY/DoAe2bjfQ7+biWet0p2vkMpyukmAvH+oT2aJ?=
 =?us-ascii?Q?3eqf4maOeKyLGxBe/rUF1fnocKsUAXVxsf52RoUKTXKNU86v8479VOqsDXwb?=
 =?us-ascii?Q?Cxbw3Wo4YFUjfB90GQuHA3WKjslRIQN4Ty+ot5ZBrAkCdFxKtRH+rvW8dPvP?=
 =?us-ascii?Q?Z2iy293zAZMumrCZRwjasSA6GEFtqwukGeYgOW1g2jGzlTy8sek1oFRMhNhW?=
 =?us-ascii?Q?EvJ2rPv4FRDgZEQk4sMIDEqQdVrGsV8nf0fsiZKXJsOWmZTksAyUZ3fu3/M9?=
 =?us-ascii?Q?r5BCA+j2VCO0QxyN+lY+YxR1mTgGT91ZA8LxsF/+yNSPKmq0uOhIRDPuAOnv?=
 =?us-ascii?Q?wXR/3irl/XHmC2N4/oCgLAJU5ptMm11fyS+nr1wDCqaiwgkNys2/qm0kPxw+?=
 =?us-ascii?Q?ExRHL/nyUhEYljH3oUv2J7fCGCkdSGgW5bM8xDB0qPiVre9Ftfz/CUGdeu41?=
 =?us-ascii?Q?x4himOUcQtkx8f0BASuPTPAwDXj02c/w7085UHUpuwUbvJMkCaMs8CKHtcmj?=
 =?us-ascii?Q?o39aMOWwV2wnZn7kUXP8QyVvyUregHKAs/ylJB71kAfOccbMaLv6BM1gr2zI?=
 =?us-ascii?Q?/UiyT3MleW3KVdBdGH66VwRYdzemfp+hj/tFWzOoB/cSuaIH1l+r1bhgrhio?=
 =?us-ascii?Q?tcNse+EjHDvRreuByzWjJlN7/YoyRyLaZ6inODT8Tlq9HzeH+3XCUVMBJrLj?=
 =?us-ascii?Q?B6IfdBPtWUxa4OTg1RcPV29ixGusmeufC8OSpzCyfwYEkdDAiHfkgsRsn/4Y?=
 =?us-ascii?Q?tFSnyvRjBBMSznzV4Ukm8rAMVv/6VSjQXJ/MPmvvOKigRIGpdUXPVOyNE6u+?=
 =?us-ascii?Q?JPsNg6FhJs8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7341.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?g4WSeQsrvGnTgWtNlgakMxYbfMSwAEs8VzQS8GR8pc/ENugVSIcDUxx195ks?=
 =?us-ascii?Q?UEuQ4Aog70hqFip1iRjm8Q3mytZWQsiHQpzPtyr+pAsB70P5ihtR9o7LBZw4?=
 =?us-ascii?Q?z3we4Bff1CSk1ZavnG0TZU86P6fBO0/4I9CkZVPBdRYvIvHrgjxSXu3W+lAO?=
 =?us-ascii?Q?Igv6ao2QcHpOVMGiKHy/M8uozGGz2x9moYY4N6LaufhqKwQbjrbXFSzIoe/q?=
 =?us-ascii?Q?T9SD0oPDMrD5WlPg7C4wCOUah2mvJ3yDGTJbCqWhDDe2S6qWfBNR2v5prevo?=
 =?us-ascii?Q?jH3dbXtb6IYG3jSwhLQkGTnUfvbgXYYWBOHVgNpnHsjFOt+lvM8r2l0cXNfM?=
 =?us-ascii?Q?vvDlNikuhrk8w1UWSedoZ4hZNbKdYRjw1w5cc554pdTXgLsqYGayhLPIaUPG?=
 =?us-ascii?Q?ssSC5HaHtCzoAMUVbBDdhGTp+01xiT8rkxUDE9bQwLNtadLCIuNS4Ln5hrHK?=
 =?us-ascii?Q?sEFJ3EdbsfQevGeJu2lbPZcMHSK3gDHjB9pP6R+Wu2XgB6I0Btv1kvrzTd5q?=
 =?us-ascii?Q?3mxHW87p/g7gRU9in3LFaA42Yoh3fuFzf7uWvQMBr5jHs0jzJ59PDe/q9ROD?=
 =?us-ascii?Q?wPqBqFjExqR85Az9xlIsW0M43x3LpFvrzALHdml6UI+cvppeOxrDW661DGs1?=
 =?us-ascii?Q?fkH9MNUqNmhi8euwn/6R6FGZ6uMqwgST2/PadiTVX+wkEWo6MM6bx54cRXdH?=
 =?us-ascii?Q?GVCZIsVjmoFbaIjI/NCq6wFN15EfRCgLBGOM7Px2c7RSdYVGreraodi02gCv?=
 =?us-ascii?Q?be9NZ3nXKPODCxqXo3xwmEWa+3/FmAwIKPGWHvvHgNUPaP7LkmibJIBkdxvB?=
 =?us-ascii?Q?aP/dEHVGJky5KjxwD/CshzlO6gCR/0vdUsHM7bmjpTdjDURdBGh/B+9ub8eQ?=
 =?us-ascii?Q?atN08qolwdafXPu+JPAN/IlDjKzwsAeEwnVbdo5S+W58ixzgAFxLL1nUuUZJ?=
 =?us-ascii?Q?nuSgMdPbeBeJW/6V75GDriqeo0FscD75Reo3qFwBeqKkwNRxz+zsj9t35TNB?=
 =?us-ascii?Q?lmIwGM9TkmCJXCrkD+DRdW1Anp3jGBdtOteTZwW54i9I4qiWCrbMrHhibjY4?=
 =?us-ascii?Q?eou1USzNW2Jb9qLlXTGUq9GFUiA/C4RyheRxRfxe4hKoAahjFszQzCtrRa9e?=
 =?us-ascii?Q?aRMBjguBUisNUAKX/J3wPt4NcAVhIDBNErk+0bEoFB++IXGTSgqXRg+oS5DJ?=
 =?us-ascii?Q?QcXI2vpwmzxc0bzdYvXoYeSs3aUR7mz6bI7E+lDk8PFjJEPyxc+HppcdTs2O?=
 =?us-ascii?Q?7KPxHB/cu3/+3QLrn6XgiXOvwspl8FLSvfa5oyAJ5SEqbNX30U28hKrjbKkc?=
 =?us-ascii?Q?EJdQbWjL+pvtU6/ann9cnIF38AE/ZTagOQZ9tCd9OQfCv5MKCHFHlI3GjxFp?=
 =?us-ascii?Q?TvhbnaVDFb0G/b5zzfeuFzFjafaMqQuyyJMnBVCK+Iiu3VTWAHlDqiJ5BNeU?=
 =?us-ascii?Q?U4BsfD7A9HS1cJMEwH/i+yUkvWm0nGe0NBE7TOEU/dSvMy/bW4gF7J9E8gmB?=
 =?us-ascii?Q?p36haA2wMCW70o02GOZXczucMlx7ZijCRw0b7GXw2QddhFulQ375hsmbm8Kl?=
 =?us-ascii?Q?WzFFeEskhMC0TaGb9Nq/27j4PslvtuYxAY66D+Id?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FPo453aaN8dr74asfnKcg4L32IcwywYhvcYzYPoXYojHpH4KtluwRQbht/QSvLQezF+g4opoSLjQYFPLQu7hb5Q1oxHT4p840qDy56UQUV70dN6fvWYEVI5MbmYq/6nN4BWegGwH6ZiLKMDAKOR0x4WnfZq0DU5sraTK1l+qvDpTF/GVPE3bBXXCj6sEkOePlWn5a8ecJeJCBxtmLGl7zAW5hQ2tcB58aXJmt6Q1YD61jLFnqoFh4aLUbVTs+fZQEShQfhvaaE1icbLm66V7UEf8hy1f1yTZ9pMSC5AS6bN0z7b7R24VurkwUDXHdDQSsiO1Rduqac1cof5+MSBLf64kY44ROJTy9g2cj7jmytI5/LZA2oTr8IV4R+PlOrKh7QOGs9CAAY3FC8YoNeFLv9YLa1tDIiYLvZ5pB3EukvN8r7FZMbCauYjw9QnMuOBspIpl3RsK51gFlX/LFifcWt4rGLlFW6lQ5XocE+urxVQyvm632g6OnkxBAT0OTNrJOcggkd88MKTSZVfcED3Py6BJJvSTAxGG3HGXYsfpUWNz26LS/fTA8O1UWcSpZkYCpMKl8iTzDaorZGsyDrTiGGne1HtxW0HbVJwR3W0N0Ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5486cef0-e2b8-4409-4736-08ddd8d05381
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7341.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:12:22.5111
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OTXomtBzFBPTXN5yy7++0NIF6+zDoOuurRPOTPDcDSN+U1cmiYGDqRbuOlsfXOMgS7j0jK4q/glE9gsCrc2sDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6A2C0CCA1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 adultscore=0 mlxscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110080
X-Proofpoint-GUID: 3E_lIoNxmxBHUs3HonLFKPIlgKCSgOlh
X-Proofpoint-ORIG-GUID: 3E_lIoNxmxBHUs3HonLFKPIlgKCSgOlh
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=6899de2b cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=u9EylAIxUBynLfAS_NoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfX/H9xKcwZqviC
 3Jxau47p6n5j2BEbB+XgHqsPMHWBKZkWF3YL/uqs9j5Zx+Zs7BtXxZytqyXSdLwu7wEsYHY3WFa
 krAzorRcO/B8D+xBAUly9u4pafrDN2ltjVJZkWQYqsrORGwByonI2llMY/ciiEqHD1sZZ+/Y2OW
 sZFaT67C70U4kjzf99D0r2l+N2XqD6mNzew6qcX0W7mbwhSFuvX6HASJ2j4WvbGi12L9j2MEfIz
 KcocQhEEMDtlLvTY7XYOOghcVvO1/yqWy1Ubdc5lUU3koYnJwVEZ3xhJN3/5OkaHjTjKJI88Ilf
 0auA2t30JqcfT8JoJ2Dor1iO9wECkKeuKuRPvIVoe1tDLvpze4EmXMiXSOpz1PcGr2ivL0ldC9g
 bY+LBvoynPadDx1BrmRYBPYSq/fcg97KkGVPoJU1oMogZNef4ZWsqf/vizNi1OFkIrat0z3l

On Mon, Aug 11, 2025 at 12:38:37PM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 02:34:19PM +0900, Harry Yoo wrote:
> > Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> > populating PGD and P4D entries for the kernel address space.
> > These helpers ensure proper synchronization of page tables when
> > updating the kernel portion of top-level page tables.
> >
> > Until now, the kernel has relied on each architecture to handle
> > synchronization of top-level page tables in an ad-hoc manner.
> > For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> > direct mapping and vmemmap mapping changes").
> >
> > However, this approach has proven fragile for following reasons:
> >
> >   1) It is easy to forget to perform the necessary page table
> >      synchronization when introducing new changes.
> >      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
> >      savings for compound devmaps") overlooked the need to synchronize
> >      page tables for the vmemmap area.
> >
> >   2) It is also easy to overlook that the vmemmap and direct mapping areas
> >      must not be accessed before explicit page table synchronization.
> >      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
> >      sub-pmd ranges")) caused crashes by accessing the vmemmap area
> >      before calling sync_global_pgds().
> >
> > To address this, as suggested by Dave Hansen, introduce _kernel() variants
> > of the page table population helpers, which invoke architecture-specific
> > hooks to properly synchronize page tables. These are introduced in a new
> > header file, include/linux/pgalloc.h, so they can be called from common code.
> >
> > They reuse existing infrastructure for vmalloc and ioremap.
> > Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> > and the actual synchronization is performed by arch_sync_kernel_mappings().
> >
> > This change currently targets only x86_64, so only PGD and P4D level

Hi Lorenzo, thanks for looking at this!

> Well, arm defines ARCH_PAGE_TABLE_SYNC_MASK in arch/arm/include/asm/page.h. But
> it aliases this to PGTBL_PMD_MODIFIED so will remain unaffected :)

Oh, here I just intended to explain why I didn't implement
{pud,pmd}_populate_kernel().

> > helpers are introduced. In theory, PUD and PMD level helpers can be added
> > later if needed by other architectures.
> >
> > Currently this is a no-op, since no architecture sets
> > PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
> >  include/linux/pgtable.h |  4 ++--
> >  mm/kasan/init.c         | 12 ++++++------
> >  mm/percpu.c             |  6 +++---
> >  mm/sparse-vmemmap.c     |  6 +++---
> >  5 files changed, 38 insertions(+), 14 deletions(-)
> >  create mode 100644 include/linux/pgalloc.h
> >
> > diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
> > new file mode 100644
> > index 000000000000..290ab864320f
> > --- /dev/null
> > +++ b/include/linux/pgalloc.h
> > @@ -0,0 +1,24 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _LINUX_PGALLOC_H
> > +#define _LINUX_PGALLOC_H
> > +
> > +#include <linux/pgtable.h>
> > +#include <asm/pgalloc.h>
> > +
> > +static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> > +				       p4d_t *p4d)
> > +{
> > +	pgd_populate(&init_mm, pgd, p4d);
> > +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> 
> Hm, ARCH_PAGE_TABLE_SYNC_MASK is only defined for x86 2, 3 page level and arm. I see:
> 
> #ifndef ARCH_PAGE_TABLE_SYNC_MASK
> #define ARCH_PAGE_TABLE_SYNC_MASK 0
> #endif
> 
> In linux/vmalloc.h, but you're not importing that?

Patch 1 moves it from linux/vmalloc.h to linux/pgtable.h,
and linux/pgalloc.h includes linux/pgtable.h.

> It sucks that that there is there, but maybe you need to #include
> <linux/vmalloc.h> for this otherwise this could be broken on other arches?
>
> You may be getting lucky with nested header includes that causes this to be
> picked up somewhere for you, or having it only declared for arches that define
> it, but we should probably make this explicit.

...so I don't think I'm missing necessary header includes even on
other architectures?

> Also arch_sync_kernel_mappings() is defined in linux/vmalloc.h so seems
> sensible.

Also moved to linux/pgtable.h.

> > +		arch_sync_kernel_mappings(addr, addr);
> > +}
> > +
> > +static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
> > +				       pud_t *pud)
> > +{
> > +	p4d_populate(&init_mm, p4d, pud);
> > +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> > +		arch_sync_kernel_mappings(addr, addr);
> 
> It's kind of weird we don't have this defined as a function for many arches,

That's really a mystery :)

I have no idea why other architectures don't handle this.

(At least on 64 bit arches) In theory I think only a few architectures
(like arm64 where a kernel page table is shared between tasks) don't have
to implement this.

Probably because it's a bit niche bug to hit?
(vmemmap, direct mapping, vmalloc/vmap area can span multiple PGD ranges)
AND (populating some PGD entries is done after boot process (e.g. memory
hot-plug or vmalloc())).

> (weird as well that we declare it in... vmalloc.h but I guess one for follow up
> cleanups that).
> 
> But I see from the comment:
> 
> /*
>  * There is no default implementation for arch_sync_kernel_mappings(). It is
>  * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
>  * is 0.
>  */
> 
> So this seems intended... :)
 
> The rest of this seems sensible, nice cleanup!

Thanks for looking at!

-- 
Cheers,
Harry / Hyeonggon


