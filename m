Return-Path: <linux-arch+bounces-12980-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B7AB149AA
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 10:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 911057A164D
	for <lists+linux-arch@lfdr.de>; Tue, 29 Jul 2025 07:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8D26FA6C;
	Tue, 29 Jul 2025 08:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iZsNrOF5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FgZD/M8A"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3486222568;
	Tue, 29 Jul 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753776065; cv=fail; b=CT0At+SddOgYU9/jwNLG+jRnQQaB0nnz+OUIDOH7SRV2X5PxDdqoQS+KcmBk3vkwWkSFEO93eL+iP7EQ0Jej6eIj1A6a47g9PCKX6a0aUZATQH4upFXPxf6xG3amnUaufAv5zKs90T2UpkoaQTawT/8KxZ4K2ck4CeI2Uy4hDLU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753776065; c=relaxed/simple;
	bh=nYJ1A99huvj8Mq4yR2t+OnpL7JeHlQNHUsjysGY0pho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IgCXD2aZDNHuendi9MFKWiYWAwM2gxtygjRvu8e37INXaCx6utdLoGvkInQlr8tO0YmuFLy8od2k0S5ngjOjpPJwrJQnijLM8V5A0F83mpoYOWtjiYWAii5KO5J0lwxqDDwd3SqO2K2t6opn+rc24mm8jPYI+FTnmLcHzbh+pgY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iZsNrOF5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FgZD/M8A; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56T7g7ss030244;
	Tue, 29 Jul 2025 07:59:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0JHqISb+5UnK95Ze0+
	YR2udw4nE2u1cfK8VmzHZsk5w=; b=iZsNrOF5I1OszZAeThO5W3r/OwhiWBflQt
	Be01qaYOBfsHVfSvGqLjaEciUHS+Qdih69Zqf3FXVKTsKMIy3N7jS5miy7hRTmqL
	kbms4lW1Zt7XC1SAJY+ZNd5aKxuDArpkrvSbP/7lVSwBljVm2yU4w0GziWFVz/3Y
	vr7zp6d3yZoEu52xUPxdaMdJEDM4OjUgsoBta1gnR9Wr1FnmI82bA+I7KLXkgI/S
	8ETbPx7ecSCK4nbkSzC9GZC4IgnQ/wHfTvDLoh8S3cDW0NItcN2yxMfRLSPYpLV8
	MPzsjsHPhYEYeROij48VpCeMEgFyP7rJQrw1s05ZkbiLqZw25cLQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wq0e2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 07:59:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56T5xNFQ003128;
	Tue, 29 Jul 2025 07:59:44 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012041.outbound.protection.outlook.com [40.107.200.41])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 484nf9m8hf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 29 Jul 2025 07:59:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c8YXPgftM46sZnwarnvoLdKgmeUx0e0Az31Ou8Mg6mUOuZwJTLQXtEH5FWQ3fePGE+Ntl1N0EiWpPR2yguXfyIy2mITGa3TENqU5IW8Th73z6UP0+Zf2g8lAyT7GJ8xNr6o8PKAwjKdA7ozJoDGaC+jp1nlmWGBZw4ld9ZL4Vw2KiRxmqJbhjgMmFUIEcKyfoi2rTx8rde1kC3zpcppTVu8JT1Tzi1cEyMbYGObHeAPwXHAUVsDt/ArrEk4krpzzmT+DnNRFgQ5cvhEmMwXr0P+L/R4sASa19/RpVjg8b6VyWHvi3aUWKxYc3bucAZYQeA+n9JYX+S99Rtf+k+S76g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JHqISb+5UnK95Ze0+YR2udw4nE2u1cfK8VmzHZsk5w=;
 b=uZlviDuX8TQgipcYem9aSIroxNWf8Ni8O8eNNCIDwJlsrpJie3mj3SeKsB8oDb0HUqb+4ESiZlBex1f64kYkLsNsfblPceVTuhjLV1skGBf4sFyJf4X4Q1D1YVFYfh3FDi8zQUCzHLBFHc+FllgWLmzYMYNUDDHKw/ziCcasGTzxWMoCJ7GSJzLr1fKQtvm+a15XDxlUmJgaMhCG+BOcEmRlMfrpCHG3G46uiwsOAIhiB/82yMBqVFwueCthGthpVGTL1NSi2nnGIzJg7JpxMwL7La/84goGWg05juRQvMK5RX1Sx8GEhCvN28xLLNjAAKhXeYIBNhWjCnTaCn6cQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JHqISb+5UnK95Ze0+YR2udw4nE2u1cfK8VmzHZsk5w=;
 b=FgZD/M8A3AaaBQ4eSYSlp0ysLjUrWl7ySz2Cg19Kl+erl2az7c4UD21sXGrHaaSEF1hFK841vDUqD4QJ7XH1HFJTj0qa8lUSV+bYzdRmzzoWyTD9+SxzzLp7NcZB+/FvgABp0Hn+QsqyAtFQf/3cID72QRtjKwfr0W6Dqs0PhAk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH3PPF077CE0592.namprd10.prod.outlook.com (2603:10b6:518:1::785) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Tue, 29 Jul
 2025 07:59:38 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.8964.026; Tue, 29 Jul 2025
 07:59:38 +0000
Date: Tue, 29 Jul 2025 16:59:18 +0900
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
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 mm-hotfixes 2/5] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aIh_Vtqp-bBDGgO9@hyeyoo>
References: <20250725012106.5316-1-harry.yoo@oracle.com>
 <20250725012106.5316-3-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250725012106.5316-3-harry.yoo@oracle.com>
X-ClientProxiedBy: SEWP216CA0008.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH3PPF077CE0592:EE_
X-MS-Office365-Filtering-Correlation-Id: 3279546b-600f-424c-924f-08ddce75dd73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LU8KfARf/owe413dujwqk6sP4Kcc6FoBm26yUqsb4l6yKOeTQ23KXby65EUM?=
 =?us-ascii?Q?kolCC6AcQi2lC/XPbYM8yi/XRqgY971Je6aqjxu3cK00t407hq4zjU1CBG/N?=
 =?us-ascii?Q?crcYahNY7YQPc+5ux/u+Yj+XtFHQgbqt1S+32UbbwT5m8n/dGBabtl6jxxFt?=
 =?us-ascii?Q?zrR3Pgsq2zW60hfVnBCA6zGT5yEKtx/djVpTLfFtsMYxLxUuR93Z/PFI7oV0?=
 =?us-ascii?Q?d0j3P/uDkePLiD9sjUCCdPEGu794Xd+DFX5X9S8AAVcjKqMTCpTM4+ucmzgu?=
 =?us-ascii?Q?dgIhdjaOBeeCMRdubZxuBT2HpkF+rtQ+OiYxzZHrUHAHR10SG0UFazlUjawM?=
 =?us-ascii?Q?QeIxVcXuRgeU5eAUcR4OdQms3FBxYJmZda5ux1ZU1zUh4mxkgRAMGC9+03FU?=
 =?us-ascii?Q?vuzDZkNSm21fGOA3l431NSaebR3dATsPgPHVmcr/RkQfQrSkY3uHA/BWouYR?=
 =?us-ascii?Q?M1+lf+Xxstkkbf67JAZAqOAZ/9z3cI9IkwtLMGtlpLOWdSJ9GzyM+WMPDRjo?=
 =?us-ascii?Q?SjpQPGrKg6BFa/T7WeyPb34gW/xBCsLFihAtxEeXD9kr6xmviSnoYtS8ZWG/?=
 =?us-ascii?Q?7+jpTuRCO0Ul+AHowLnUvEFihu5YY+jeI7Q2ukVGdfI4IuMs0a8I99U7/eSd?=
 =?us-ascii?Q?ii7QtBPmmRP8P58yns9C/DtjDCq3TZP54Ik/BvTkWLuFY4YAVZ6ZUPYG6538?=
 =?us-ascii?Q?u3ZbUBVZt5tkdT9PNSgzQSGoDWc6fJmZ7zJ+usoeirVXgvkXuh69B2OYkxjl?=
 =?us-ascii?Q?FuNIc1xD5J/AVcSBQuRpBRccB42IGbInvBEMVAcTbpmXe8zMotvBHdkAIodF?=
 =?us-ascii?Q?gsiYAPslcuDlTxuP6oqkUbg4Q1IvVOYh+zH5QpW7WXJl/AQ0llisoQgtA4Lk?=
 =?us-ascii?Q?9SgAkhhFWUtdQ2q88o5Vm5CjXpAWLBg1soiC1xZmzvbRtM7S1buUuSBguUkk?=
 =?us-ascii?Q?bJZgYNhbhgatE6pEvJwakF1/8QdqD7keUo7Qa0/soM+NE0M+ZVPwFeEsF3b6?=
 =?us-ascii?Q?nsLDTt304rBx60qdWdJC9dnB5UvIw5EGnnTCx8d1sDKh3N8x7MVeMoDXFQ7o?=
 =?us-ascii?Q?1FTtoyvw8EGLuF1LdaCYYqHrR60zQXT30QchaywHZePUeL80GVTw+5vFtSxI?=
 =?us-ascii?Q?cL3rbBPPQod5h5G83yREoiNpNCuJXCcNnxFZHQwxC++XN4bym9QbiLjsAFvV?=
 =?us-ascii?Q?gaddFmAnDG/hqiljZ7cPMrb1rBpzk6eJi9KaKWsBidGlNUgdIaFUtL4aUIZ2?=
 =?us-ascii?Q?CyKw3ZXzG6suOOH+dxJSnzpGrufUrcLqvW3//PEWYTKYBomOtRLZcI+Eqgtc?=
 =?us-ascii?Q?H0hmOZxlLFfOI3Z2eCpIazzDEAm0iwvpqh7RuX3LyAwHYHSzcxdPtGbURDv6?=
 =?us-ascii?Q?/ttkFaKeaAGmAMLff4j7INAajvcQO59x3QObA+UQ9BnAOP6AbkyYeMOwd0cu?=
 =?us-ascii?Q?5YzEnOWMUww=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sr2aer3WFZrgOG/c67bGeyPE83yD1uk7+FZrRP14h9e6CAX499T0qsZeUdpz?=
 =?us-ascii?Q?vXeg8fjQg3Elv2ls1sO+2jmtRPEFYPvz61fZVikchnHxuDcYjqyv/wz/jGdu?=
 =?us-ascii?Q?cUpAezBGf0WfQwVKJh+jCb1KooOIyzB0TKpviEB4QIG5oczKumOurC9zZ89S?=
 =?us-ascii?Q?sX2sFNhYRpUOSDf3EoatqQPPDi2GF483x0d5IDlATL4bdQQw5xyS9ku8B+4N?=
 =?us-ascii?Q?Hr/1Jiwsbay7Jaoc32DWR+fNohAwXSt+ZT5WVHTW1SwGxMbz6AiMm3j1m6Mh?=
 =?us-ascii?Q?cA7/unnpvdYVbVGEqJuPoKPf1LHtMlu++yvglPTkuBUh5IVfpreIr+aO8s0B?=
 =?us-ascii?Q?X5uu17WWmHw9YkN2JQ8/usJdAjY7PFIcgBZX2C1zVLP8YrQ8Hpk0dccHIo+E?=
 =?us-ascii?Q?feaLaHYPpxWqmsFV2z20iwCQuB6Blu6oFxyIOPZ3PQjV/Wco3E7FF50gGoFF?=
 =?us-ascii?Q?dYJ8JGjzUlhdk8XCAAo8OHjdpjGVuHMgHro3q3iupMJXqFKWcPOBXJSKkFez?=
 =?us-ascii?Q?oUG8XmEXY/VJ9y/hUXgdS4p1bGi1KuHtZ6JcFZPliYsxZayGDsfQcIHfY8KC?=
 =?us-ascii?Q?N9/Ncnuxlf7cKC8lV4S3GakiD39qu/cBK/0Cvk2RByT7RyuGbDo7Lhaxk1vu?=
 =?us-ascii?Q?ujVDTfBsOZ53WzTZR6CAtiob/1IJWtVIbUsXhNb+fTpiy7XouHZGdYc6lzFF?=
 =?us-ascii?Q?svTRtbMEFOQvla//WNCcNw1KWZ7KM5I57zfaD3K9qghf3VkjKiium2GsXBMF?=
 =?us-ascii?Q?V0dEFZoeVfQ0dordO+j66IfVLUUqiynHcTbvA1HvT34X/A7OelAZkhMeWCrB?=
 =?us-ascii?Q?AXPUJcX7E3bblgEHZ8fVsk+V1PjvS66s7Ra8CjiCl4qSIZbZShbulBiE/QOn?=
 =?us-ascii?Q?XV+89YvVw0oVB21lDJ8e4W1oWaMPHUDiiMNEbJRbffLKzOjOEJVYnuLf3mQP?=
 =?us-ascii?Q?jKzPIhBhFnsXRQHhbB+6aU8UtNGh/Vtepw9QYiuAocwJgLK+JW7E9DSjVIzP?=
 =?us-ascii?Q?CRb0mjZeccT1GJ4LcRKkoUYpaDN/9JnWjhCkWxFTRf7i4gIaY0ijrqvlwOxR?=
 =?us-ascii?Q?kp8s1UA3qBvPH/mhOhETVWqhaGUDDUv05+S6WlnAMayjuXno43Ucw1j8NTsn?=
 =?us-ascii?Q?4Pe4rAYJry4afgDYTC53oRbl1hM9gCWlge2HdvocDmudI9a55bPy+BWWFUxJ?=
 =?us-ascii?Q?Jibqa/9GAQThHWCsJQsvbLo0uuWGa4I6MNXIF7YaDl6fzxTZ1R5vAxBMpP8m?=
 =?us-ascii?Q?75T+25ypNH8KfbG4Depms0mQAW5BdG+yXyuJSRZslAUroLqb899Wfn1+CDa3?=
 =?us-ascii?Q?+iZl0RyOZlxl6MdprwTTNO9zxvuA3b7SKkzF8hlX3mozjNbk9ICb4yNf9dei?=
 =?us-ascii?Q?JUlVNaFmYyJgac+QFed7Xv1/5pQHcjRXTbAN4Am8e61zGOhVPfcYFslkS8d+?=
 =?us-ascii?Q?LioQWHeo9a5MOsH6Zx64z7fA9yaE5L/rnFcVj/zoGdfAx7hax774qWYhKZVS?=
 =?us-ascii?Q?3JChE0SdQKYm1kFGSGkg5/qdXxqwbM0pS6TPyPN1AFzxBymkVrsEU5ACHoJB?=
 =?us-ascii?Q?WGVReMv35ygzlrKJo6mSEzHSmIfuv2UNK+J4NrWl?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pxqXZF7lUfPPSIV1NxQTmqmHN9u9stMxlARgz0nmfk+Ld5AdP1pTSp9Key/WJ58InzmU+otFX4052LNkee0WAmgw8cjuduau7xBQVi2UE3HxR6HK/cXClbOUlG1Q0usdvd/lnKzuxbOvke2CK/YkuGy9N+yfu2h6s466u5eolmD224X43BQ6v4uV9mobffgcA/BukNQdOFQ6FQDVdCdrvoWY3KXDJCtdVOARkVirhfKmvjAtmefuG4nsHu38KHSCLhBciUuBR4LSt/FrRzR+g94K2zVJE8LsiHlOqegfNusWRA0pgZbID6yb2O4/tpZ1QuSg+sEhyDAiYDqK6sWe0Am+I6d5R3TEXsiRdmlIdlVkYWt2mQZwHIhnOaWNOp4gC4GXNcrMraxD1eeW2maW7Tjp7jefrUNslHESGvkt4k6vyoVilMkys5HnG9OEkvu59mSsGfQyzcwKYZLFmjZAJiTbcwPSrMYR8YUF3pPFv/yg8qvFHHezOnZVoeKIcr8HKpnwj8kJr5RHiqD6/SuXu6PEdIl6Q8gvmXd/7uxdgBrDfZomalrZ3ttXVtclYKSytmDIiTlq5kAJmmAGMW0D0PjTM3KLAs3/Ywx1LVb4ciY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3279546b-600f-424c-924f-08ddce75dd73
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2025 07:59:38.1024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Omf0DwbHmO0xcXSOcgpe6yfamultuEC0aOKGjlkYpXmG934O0epFRCxhxlgPIHqxLDWxZ3vhLCVRP/Z36GjQow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF077CE0592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-29_02,2025-07-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507290061
X-Proofpoint-ORIG-GUID: 0M6jx3aSxjLsMM8AG-rNvJlD0Cf2kA4c
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=68887f71 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=qLPiMMKOEkLeJN1NtY4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI5MDA2MSBTYWx0ZWRfX505Ls/kNGNyt
 LkUSY3xU7LymSZi+49OeOhunhkjQDCb7D11KYofzt7oxm0XjhX0cgEkjwwkXR8t0y4VzkdqprtB
 mzjzw72QxAE93wsCy6FXreZWofFQhLzJjg49hWAeofxWcK0iRl1MzKBybvPxK14kxCXy89fFQty
 gvZ8hji89xFS2fRCt2Zwwh4NujczmcZoLJxbM7CRcuM606BW68t7+tc9Uyq5uE7SoLZWRgct8a6
 Tw45vE8wk51CN2WGlju0mtoSC92f7hwOGelZOp1umYrIgPc6gT/hxUz+hU4g3CcVv+nXLz3aBCF
 mWRHX41pkg/Gcw9UNXEK1yr3AN+itDb4Q+zMOOyJPDGA/1XRoBvLaZD4MFqx+Z46/UHtPOKuCB9
 Msptg194I0ziEswu6UecKKp3leUKNSIMEDiJKmddxPkICKyrqkf54Vv8INFR49VtqVLyTmPt
X-Proofpoint-GUID: 0M6jx3aSxjLsMM8AG-rNvJlD0Cf2kA4c

Adding some comment after looking at a kernel test robot report [1]
that seems to be rejected by linux-mm.

[1] https://lore.kernel.org/oe-kbuild-all/202507290917.T24WIcvt-lkp@intel.com

I will post the next version with it fixed and including only first
three patches that will be backported to -stable. (and post last 2
patches as a follow-up after that)

On Fri, Jul 25, 2025 at 10:21:03AM +0900, Harry Yoo wrote:
> Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> populating PGD and P4D entries for the kernel address space.
> These helpers ensure proper synchronization of page tables when
> updating the kernel portion of top-level page tables.
> 
> Until now, the kernel has relied on each architecture to handle
> synchronization of top-level page tables in an ad-hoc manner.
> For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> direct mapping and vmemmap mapping changes").
> 
> However, this approach has proven fragile for following reasons:
> 
>   1) It is easy to forget to perform the necessary page table
>      synchronization when introducing new changes.
>      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
>      savings for compound devmaps") overlooked the need to synchronize
>      page tables for the vmemmap area.
> 
>   2) It is also easy to overlook that the vmemmap and direct mapping areas
>      must not be accessed before explicit page table synchronization.
>      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
>      sub-pmd ranges")) caused crashes by accessing the vmemmap area
>      before calling sync_global_pgds().
> 
> To address this, as suggested by Dave Hansen, introduce _kernel() variants
> of the page table population helpers, which invoke architecture-specific
> hooks to properly synchronize page tables.
> 
> They reuse existing infrastructure for vmalloc and ioremap.
> Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> and the actual synchronization is performed by arch_sync_kernel_mappings().
> 
> This change currently targets only x86_64, so only PGD and P4D level
> helpers are introduced. In theory, PUD and PMD level helpers can be added
> later if needed by other architectures.
> 
> Currently this is a no-op, since no architecture sets
> PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> 
> Cc: stable@vger.kernel.org
> Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> ---
>  include/asm-generic/pgalloc.h | 16 ++++++++++++++++
>  include/linux/pgtable.h       |  4 ++--
>  mm/kasan/init.c               | 10 +++++-----
>  mm/percpu.c                   |  4 ++--
>  mm/sparse-vmemmap.c           |  4 ++--
>  5 files changed, 27 insertions(+), 11 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 3c8ec3bfea44..fc0ab8eed5a6 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -4,6 +4,8 @@
>  
>  #ifdef CONFIG_MMU
>  
> +#include <linux/pgtable.h>
> +
>  #define GFP_PGTABLE_KERNEL	(GFP_KERNEL | __GFP_ZERO)
>  #define GFP_PGTABLE_USER	(GFP_PGTABLE_KERNEL | __GFP_ACCOUNT)
>  
> @@ -296,6 +298,20 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  }
>  #endif
>  
> +#define pgd_populate_kernel(addr, pgd, p4d)			\
> +do {								\
> +	pgd_populate(&init_mm, pgd, p4d);			\
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
> +		arch_sync_kernel_mappings(addr, addr);		\
> +} while (0)
> +
> +#define p4d_populate_kernel(addr, p4d, pud)			\
> +do {								\
> +	p4d_populate(&init_mm, p4d, pud);			\
> +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
> +		arch_sync_kernel_mappings(addr, addr);		\
> +} while (0)
> +
>  #endif /* CONFIG_MMU */

The report [1] complains that p*d_populate_kernel() is not defined:

   mm/percpu.c: In function 'pcpu_populate_pte':
>> mm/percpu.c:3137:17: error: implicit declaration of function 'pgd_populate_kernel'; did you mean 'pmd_populate_kernel'? [-Wimplicit-function-declaration]
    3137 |                 pgd_populate_kernel(addr, pgd, p4d);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 pmd_populate_kernel
>> mm/percpu.c:3143:17: error: implicit declaration of function 'p4d_populate_kernel'; did you mean 'pmd_populate_kernel'? [-Wimplicit-function-declaration]
    3143 |                 p4d_populate_kernel(addr, p4d, pud);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 pmd_populate_kernel
--
   mm/sparse-vmemmap.c: In function 'vmemmap_p4d_populate':
>> mm/sparse-vmemmap.c:232:17: error: implicit declaration of function 'p4d_populate_kernel'; did you mean 'pmd_populate_kernel'? [-Wimplicit-function-declaration]
     232 |                 p4d_populate_kernel(addr, p4d, p);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 pmd_populate_kernel
   mm/sparse-vmemmap.c: In function 'vmemmap_pgd_populate':
>> mm/sparse-vmemmap.c:244:17: error: implicit declaration of function 'pgd_populate_kernel'; did you mean 'pmd_populate_kernel'? [-Wimplicit-function-declaration]
     244 |                 pgd_populate_kernel(addr, pgd, p);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 pmd_populate_kernel


I had incorrectly assumed that asm/pgalloc.h in all architecture would
include asm-generic/pgalloc.h. That's true for most architectures,
but a few architectures (sparc, powerpc, s390) don't do that.

As it turns out the assumption isn't valid on all arches, I think the
right thing to do now is to introduce include/linux/pgalloc.h and put
these helpers there, and include it from common code.

-- 
Cheers,
Harry / Hyeonggon

