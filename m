Return-Path: <linux-arch+bounces-12650-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3448FB011E8
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 06:03:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E08E5841BE
	for <lists+linux-arch@lfdr.de>; Fri, 11 Jul 2025 04:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5878F7D;
	Fri, 11 Jul 2025 04:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="enFaDpXO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hXx4zaUr"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE457132103;
	Fri, 11 Jul 2025 04:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752206609; cv=fail; b=nL5l8w2+C0j+RDuj0zRxFk93am+j+UQUZc7vPTunSPd8eqo0abIIHxMz7Tkxav/+ZU5dY7xFk/oRFH1DGTsMGnasCs7ZVto03Jrdlye+r8Jp7DPswgGNz6XZFpZtleXeslUZU9BdprrNthEBnOwVJvCjxFR/RR1cJ6+IBQjSZjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752206609; c=relaxed/simple;
	bh=iBdzudkVia/TKHZ+5aIOzjbngI9TSkYT9h6JXdLHv3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JpvkbmFXwOepZ9Lwx7AkVZanaGsLGwwcWMKT7E+TVi442FBvQG7oRHvIelSUFhKRA7gLlpHRxWaJylIoVs6pUpCg62dVFFP1ERmoVMq9DaqQqTwyqlJ8JzI2Dfv6yqqEfjS1ES1xRVclNyHqaXjWP2JinM2B5nm2rdhfxb5Nmcs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=enFaDpXO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hXx4zaUr; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B3IGH5010882;
	Fri, 11 Jul 2025 04:02:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=JQTLbox2pS+Lbrgbke
	ahPNKz3wqW1IbMk8QdDmKtUwU=; b=enFaDpXOWi8GHZ//Y5vsssP7jVfko3lP0V
	zQJnaeyUUyW7Q092zdwG2f9Bg07F9B4MqQFr6yo9RyTwp9s3wubbXxvMG5RS/ehA
	b0wx/XQuTsYQLD9rnNfPkYOS2wN9sjeoPXn/MXL0QP9P+ScHum9RtT33/K2cqZfE
	GabN5/K/MpD+INq7B4Y4JqHvLTOdM0laPJ9ijc7Cj+9jzQnmPStMVa+Z3+3eL+lb
	p9dZfZAdwGWcFgXVdb2g/xpzI6f3iNgAYxhRRSLetmww4m7WtEqNzysSNmH4LvPX
	SKNFU+RRcyNZ7Eh/YVs8zvAEKGjWa90j1X7+QF4J3gGyyHKeWSKQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ttjq0112-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 04:02:22 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B0iP3Q023605;
	Fri, 11 Jul 2025 04:02:21 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdaghb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 04:02:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PV4SyCcm7hlBlciyagBr5xhJ4QxKT8XvYOFoJxbalRscx47YEGIR3EmSpej/4/6QFV5dYmnunlsRjiIFlAB0rc/uJTp8r6mxqzPpwnXsGRLVpmK9BXLPebtnj6M0qAY3fVvb2RI+zrzLET79dSXp+RXa5q49A4cDbr0DGHSRq4B3dYGgvptOb1sclG7GzspZbRO8TFA3VlTMuWLOD+uWXwy6mZWJkX3tfbArJHsuIsGwX0BbykpTEplH6+26P83GavHg+MGc9DPVhvsPjbeQUJR5clic1Ka4daHkS0W0MmfqoSIYbhv35+9cQo77AA9uRtd3FCRv3wS9/HrLLl+ecQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JQTLbox2pS+LbrgbkeahPNKz3wqW1IbMk8QdDmKtUwU=;
 b=OwZWTNzD7upuTzBiENqyJ2aZNvEFmOuV8dr8M5PJ2IPFV18a1IxQX7Zk+VYaLs0dUJaY42RZn5Z7gt/P9FiLYICsCWggEiLEM9Z+S0IAqxqf1u/9Fs0avgVgFpIbkmB7nPxKb71oTMihmmSq7KWySsVq/Y/IO4Y9YmWYL7L2YTYwiEI7oUEHAnWJ+PJcfTtOfuCkzEfVhXkif92vnnsRM86OqgJWy0godYkz+RlmeWznPEx3KYQ0L5sELjzD+JFJmhCzqL/d6h6Eey67D9wFbv01TTLMX/Mj0d6EscQ1L4J39DoT7f/VxPR+g5RjmJ3WAtQsLn8YbbPt0+Hr2Y8h0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JQTLbox2pS+LbrgbkeahPNKz3wqW1IbMk8QdDmKtUwU=;
 b=hXx4zaUrsNziIPJ7Kw8JIagM0rTDJxZ9lgZcGkzk8EkquGlQXXlwVgptE+PeJRhMxyrBF1bz6yznr4CKgB+BKVeumnxRQv2egHtLwk31F3cBlvZ7jAaADt91TTK/3eI+kIjqWoJ3I5W9efFYWB7zNthAt4401Qvn9//9lfpWZ48=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS0PR10MB6800.namprd10.prod.outlook.com (2603:10b6:8:13b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Fri, 11 Jul
 2025 04:02:18 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 04:02:18 +0000
Date: Fri, 11 Jul 2025 13:02:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>, Dennis Zhou <dennis@kernel.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@gentwo.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, stable@vger.kernel.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 2/3] x86/mm: define
 p*d_populate_kernel() and top-level page table sync
Message-ID: <aHCMwOqzLrO8tzaq@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
 <20250709131657.5660-3-harry.yoo@oracle.com>
 <20250709141359.dc03e32a2319d85a25faaf32@linux-foundation.org>
 <aG95eBlgTIDUKX7e@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aG95eBlgTIDUKX7e@hyeyoo>
X-ClientProxiedBy: SL2PR03CA0004.apcprd03.prod.outlook.com
 (2603:1096:100:55::16) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS0PR10MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 48d21ebb-afe3-40b3-63d2-08ddc02fba3d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AExGOOmJhY2Z4sVs5y8RetMns6LcMcYw9I3qYXsvyuWYHj+UMilFdRo3q2jK?=
 =?us-ascii?Q?gzyla2bUQElEjI5xCzDqJHJQZqXYDVxjgvcfb99L5qdE8A89WpLfYzizFMND?=
 =?us-ascii?Q?zujrGrTi1xcr5pFwAF1HDKALCZDd31dfHoxUeK8GyzWGwAUUEcknLJ7JFEFm?=
 =?us-ascii?Q?QnYlohgCbUkBDWaOeQduhlkBAyYGbwoEyn77GJ85M2lj0wL8tW0HSZuPAHlw?=
 =?us-ascii?Q?SKXBv7/MuTAJ8OGSlY328kQRev+/9berBzJp3VpsYBknZGOEczzpMHs2tlvf?=
 =?us-ascii?Q?Ft9OfdYQIeCwrMl06WtqGgQNqtNzYCudRoNmQr08Ef0sIanCVyjwcIPGkTYD?=
 =?us-ascii?Q?H1q/ha8baSah1tAhC5gbSx3qwK1OMpmC1OchIivCZt/6rVNJC7/eif4EUXx1?=
 =?us-ascii?Q?sxLSQ1pbEcSWQEp5y/Kpkw53d63l5Y4XitmIws6d97alpV0PR+h0hSHrVcDZ?=
 =?us-ascii?Q?NMg4usAofPAXIuv3ofNrDsnNKkMVjdwwACZbOSM55uQcR1ab3QwY8MkeeA6z?=
 =?us-ascii?Q?0uiqdj4xjs5Aw3gKBas5C+QIjclRec8VB49JgMitI7IqBSMet6v4MIbmb6U+?=
 =?us-ascii?Q?FWmYXrBy7surM+rhQJUKJzunSmlIhrDnwUAX4Lo8a6nG6vzOHab4ZOFw808S?=
 =?us-ascii?Q?sJhCShDbh74bAzsKZwET87XDIGZjxVciw/MovX1beX/qA6trDfkqXEzPZMpB?=
 =?us-ascii?Q?9ltD3zxukPqkpa4fNjH/hT5nw52+4mvjWu4+m5dgVzEbB3jetmY3Ixh+J5+j?=
 =?us-ascii?Q?lHm9VJX+MWO4FPJjYQbqzI7frbjshlumQ++a60fa1TnChqC8SAIBh7BeBPZv?=
 =?us-ascii?Q?ZDq6bNlnnFTsin/6vAbRvhSAnXd2u+DyvnBsLHxRylpHjflj1a1LkBjmlc6Q?=
 =?us-ascii?Q?Lg8oU/FpZHzm5L/wQF94jbglRXXiIQYfk9UAqiBFQvJlsJkjjzuRH1JgVsga?=
 =?us-ascii?Q?2LgD5yVvdZLnmzVLdqosuQ0JDuqx89A7XXc94zxRZK1ojCZktpU1urE5wLie?=
 =?us-ascii?Q?gkUZwrezJSPjiNLY8wGDwhjwsrzADdGvp7fm8SGE1r2xR39LeILC1jHjsbnN?=
 =?us-ascii?Q?XkGIsXAlynpr4az/qNInxdHkCsn1eO7XWClGiACWDRoZnW9yvMUGvpP1fBZv?=
 =?us-ascii?Q?vrI3vXeeElQDvdN8hPZ3+a95dGg3v9yQJJQD1jzHreVkps8RbOOfFK3vI/ML?=
 =?us-ascii?Q?ZwcrGwCxDZQvO0bngocv8gtI+oyhTF0W71X0RKgiMHMRIkZlANIHt0bsGFGw?=
 =?us-ascii?Q?nae/ChYsduqiBPTAIDxufIAZtanxQGW3299cnJNlspDxHTqX3LhBs/YPWZZb?=
 =?us-ascii?Q?fTujhz4PYXSCxJd9yY7W+A5yepqNEUoKZ1snGz+O0vae37H89SI4cGakcwEf?=
 =?us-ascii?Q?Xo4G0y6t9fAlH85BgTMTloKv+ScUOw/nijOy2hf543GQ4wI3ejynF3v1NfgB?=
 =?us-ascii?Q?Zw7IkvT6GCs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?V7gnmd6G8go7KymLj2O8Jrpjvk9SBmNjL+L3jUCIkK0pS5P8DY3Xo+YaPA/3?=
 =?us-ascii?Q?9jlkdVyCZIEFgqIrZ+2n/0b/HhS24Vl3+fKIHJH5mBzzQp29+L0hvIBmTapr?=
 =?us-ascii?Q?BKemOA63EjQfmblO0iDwkhAwDdagqcWbEgUn8kteAhLnvN1a+UDhuB2iSYhJ?=
 =?us-ascii?Q?2wJ8sLW327Gbgag/sHs2ejzVUE8J5UtCx+AdvJZmi4UPaDP6qopcahaMIZam?=
 =?us-ascii?Q?cZlHwdlP4Nl5d56zcb+/WXPLcqgkX+TE1YItftD7Mo9+/di5mzs9pm1470rh?=
 =?us-ascii?Q?jlGAEou0KOAow/hrra0GRnK1KRGw00PAFj8egprs1nFg94QsUkzCJTiES8rU?=
 =?us-ascii?Q?cs2QWiDaS6Pg3zNVi7YPtdK1NxBamgkHhfept9BzpbbzY4UhRLWM5p1dRJ15?=
 =?us-ascii?Q?p/NKoSxRG2H5sol9PmNK9ehDjnW3Qh15SMYKSILFLtPkfXy6hplFuHAin9du?=
 =?us-ascii?Q?A53CT7wjmufHFNGvGsacVMMRmvzV3Vbsv+MfIHFyHZlJgtEdKHjifslgm78R?=
 =?us-ascii?Q?yvbIy+vCvjAXfEoRnAU5EO2hAiKa97GDjtMCGQRkd9xmnOtcFkdsQZnmCkwi?=
 =?us-ascii?Q?9DF2lbZFqFUbJMWrByk/C2xxmqgaPr+894tBPWyX0GNgayjpPIVtpSm6GUKg?=
 =?us-ascii?Q?lfWIMrBB2mfckyP2Vc/xrtwfDueCQ4cQifSP3127g4F5vuKNutfU+ud9Q3Ij?=
 =?us-ascii?Q?idtji1y5suU4eP6fBf8KncMjagsHrk+F83pP8xL55P4ETYUYfgJFYRSt5Qwo?=
 =?us-ascii?Q?qqpRRevToWiKo3/YD3clWu8UJNavcMA2jc1W2QZlS6dh7eoZwlQ4qVQYTXiR?=
 =?us-ascii?Q?H+tEgHFQReTwizzBGovUr4gAwd53+RsaaVJoc+JCLKSMlqdhFs2dYgYOzQtd?=
 =?us-ascii?Q?DvSaGUm1Fdf0Cy5jyqsIbx5uH+E1r470G5dHHgSbWN1KYhPVCIFmovnKUYea?=
 =?us-ascii?Q?B7BT1ATosYsjKXI0YLXnFHJLulyQAMcOfcZnc0vvFM8gT5tnRSEviMlA6h6Z?=
 =?us-ascii?Q?GfH+U1BaVkRSOt7+KVX6+uxMKEoM0At1zJlN/Jzs4BxJ/rX0QxLaCAi6GwPZ?=
 =?us-ascii?Q?BH3MfoWfFRxxAu4Fl2qcX5NB/GSnANlS3mKOUU7ZYErF+IlCyrbQpj5UIrB5?=
 =?us-ascii?Q?cbQwqIlfwdzgLndKAzXdc1Huxta1hgF6pbJt9/c+j4NIKeRtd1Oljte9O/wj?=
 =?us-ascii?Q?MvRARpDlHek7m6vi+ibRQg4ZuqShzB+amISm3+2nLkNnn5EyCXD6qgTsIKmg?=
 =?us-ascii?Q?OAdpgqUP/ntwd44DWxGxIUX6gNeTPkr/qi+J3MKE1XWwzPnb2oVv3pXHAZVa?=
 =?us-ascii?Q?LqatSQ3IiRzcLr72n7OTB3TffIwcNprH7Mr9/WAZl503jfSKl0FTkB2IARB0?=
 =?us-ascii?Q?L8eI4qwJWXOLDZHYpJGKkpz6d1Rn8s/s9CESqC8s99I0f6zcIvSMPSK1I3GO?=
 =?us-ascii?Q?j6rol+JWmS50VKwHUKDw9BAvP5sMQnY0Cqv3nZYXq1MdthLkXYk5jMxZJgSH?=
 =?us-ascii?Q?EvCdYBPgFsRYo1qSQ4rPY4vTWgvp2NxaSuTOgb6jQ/1QzhpBGO2QdwhKg0qO?=
 =?us-ascii?Q?CpfPrWq/zSQwS5SuzgvgoHkS2bmbMs0rvnewUqj3?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	csVq3BXEov4WhD2DXLmY7qhUVoh/JMPo/zGPkFrso/J0AAVfmgSfLxf/lFDYnWYAXy0VQORNDq9dS8VQKl1ZnXhnL7in+CfWsfkXNmsz+CyZ44UsQs0bMNV1euYQRA3h6EAvFqV3nmGLI5bPL3MChvCmqIO+JmsdVZoQKGO2A/3WdqIatmTiivuLY71gE3QGzh5ttmGD9O+qjBXfZU3eiujFBqwtpjViTrkNCRJQjRn+g4hsoEvZX5OU11M8CNgImo2BdSkZehlE16A1S53HebsekzfY2N1YSZq1H0/c4sEMHBFkmyHEbsMU7DLBFxdGExR6fS5sPEB4f1ZJ5Udstba8Y2EyXFbxOsomss4xZD3x7eOcI87gf0eV/6GJxA8mFpOKJKxSzuzzUMZWLGobcQsJKRPKFif9NBjvtSVP38QY2SUGW7QblP5f7MSjO/wXHjqjl5xjKl3Umbksd5dfrPvfrVipPxTfveEcBkfAQy+wq9LDXg4skcB/6QNwHYERGxN3Ty2IWfUwDHsFjz0R7t3f1pOP+maEyB2cpuoDciI4QHfaqSw8vXk8JfTYKu/OEqyy+EcfvgElie076pZluyBoEtzjSYHlcZqgyF4AaJg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48d21ebb-afe3-40b3-63d2-08ddc02fba3d
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 04:02:18.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwuEq6jtE3qwvaLbsW7LLHaTGyKkENc2+eAlowcXfh2J2jHo9bqoKBjEa0aCZmeasQ/28X5n3sZdoc1VTTlGEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6800
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_01,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110026
X-Proofpoint-GUID: jmGvOhcEQzkIRZ_Pm1tMTJttWS5NLKn1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDAyNiBTYWx0ZWRfX19iTOfcNeA9V n0OnmYq97DcMQV9CWVsoSKQ6FHef5NfLRKErl9Y5ioN+WWkikzydAgue9QdPUAAwP4d7jc+cmw6 ExJi4R3+dOqnbKCR2RNJtDPSGhA22UNA4cVGgLRwQfyWwMViRvkWgyKsbJiSQ8y1hk7ib7Wsnrw
 bRX4+qucyBQ8ofDF9yndO7rX6MfOo/95WNTSD1/knJOqAeGtjVD2YBLHdUpCNw/kh7p/2TWv/e+ HuHRAbCLH8/+04EeanXWFzL3fD/vPdMfKLRNwly77eKCJ7MM2ftX3pd8BUnQwVxfiZA9sm6bCEs pCqgp0RedFf25hu8YbQwqd+2x80a3jvL3UODJAYxIlOiaa6CJiMcracoz5m/7698CUJpfPv4oZy
 Nf9AdSIfK8gg28KaHiWvRTKtZriAxuTT8OJoHpdV02a4vw+UTbVnVtiLNQlBTQBThwxKVlcu
X-Authority-Analysis: v=2.4 cv=EcvIQOmC c=1 sm=1 tr=0 ts=68708cce b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=W8aXzcmKYVkJJQoDRnMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: jmGvOhcEQzkIRZ_Pm1tMTJttWS5NLKn1

On Thu, Jul 10, 2025 at 05:27:36PM +0900, Harry Yoo wrote:
> On Wed, Jul 09, 2025 at 02:13:59PM -0700, Andrew Morton wrote:
> > On Wed,  9 Jul 2025 22:16:56 +0900 Harry Yoo <harry.yoo@oracle.com> wrote:
> > 
> > > Fixes: 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory savings for compound devmaps")
> > > Fixes: faf1c0008a33 ("x86/vmemmap: optimize for consecutive sections in partial populated PMDs")
> > 
> > Fortunately both of these appeared in 6.9-rc7, which minimizes the
> > problem with having more than one Fixes:.
> > 
> > But still, the Fixes: is a pointer telling -stable maintainers where in
> > the kernel history we want them to insert the patch(es).  Giving them
> > multiple insertions points is confusing!  Can we narrow this down
> > to a single Fixes:?
> 
> If I had to choose only one I think it should be 4917f55b4ef9,
> since faf1c0008a33 is not yet known to be triggered without enlarging
> struct page (and once it's backported it fixes both of them).

On second look, faf1c0008a33 is introduced in v5.13-rc1 and
4917f55b4ef9 is introduced in v5.19-rc1.

I'll go with Fixes: faf1c0008a33 because it's introduced earlier.

> Will update in the next version.
> 
> -- 
> Cheers,
> Harry / Hyeonggon
> 

-- 
Cheers,
Harry / Hyeonggon

