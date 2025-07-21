Return-Path: <linux-arch+bounces-12881-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D3CDB0C397
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 13:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95053A9DA5
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 11:46:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33FC2BEFF0;
	Mon, 21 Jul 2025 11:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="infCmXV0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HRn74/Jc"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB8B28C86D;
	Mon, 21 Jul 2025 11:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753098438; cv=fail; b=ejyuy+WAK6p5zJFgFWPwqzuoj0N1xobQqmQWg9j2lOUyKM75ccr+ITxheeJfwzr1TCeyhUjFbpXGonlYq9Ab4PdRIszysbnclGc+SbhZrbMbfN4aJp6gaPzykUPe6K9AzCF5W4Tx9Y58WkEiXmjjW/Zqr74xk2MRJ+XY6t72pe0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753098438; c=relaxed/simple;
	bh=HGK+OB0E60tzQha+YdeYPIthekb0c1iiGllFDtWu1+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=biHB7+57MzOlwAHEs82UKVSfIxwLuL6IlEdOaIl+9vCRepMceQBK8O/cMHMOmKWMl7IBVo0mE1ypj+vFn88RQGnIRjz8h6h4BslRjdOkXk40nLsX8pIBIjlwemdwoiGAhMv2trV1qARQ5qMJOuoKPjDc3i6hdyBDG5sxBWljsTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=infCmXV0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HRn74/Jc; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LBBpKN012272;
	Mon, 21 Jul 2025 11:46:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=sBU1T0zSR2TZ1wXpLV
	c92ZG5snXdDucM1pvf68NyTy0=; b=infCmXV0v5qK2NLWvNvnQTu+ixf9J+18tw
	QLrQdGxIPJpEEuV7bVPlLjolM3MAp3Yj70zIyQOUxwTey2AIWGbRLUA1Es+UUpVs
	jecPClOlwxj7sd5xqWr4XA/cAp3BOOFLZtiYFd+GxGjMl8xLLxGOTUbnlF+RZ0F+
	AayzE6QPwijDFAOg3Mz362m1+MVmM1d+ix566hV3MLIz7y7wZ8asKZrdUG5xohAc
	zOGpyWwsi1NyZ/zImIgHDvIhe+fXz5nIKp+dWV11Cvq0K0rtSsXGLI+/PRBXEbey
	+sat/k6kzjL5MRTG3Qp2HfSXavLr2uVq5Z6aQKhjvTKY/8BWU2BA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805e2achv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:46:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56L9tx4p005916;
	Mon, 21 Jul 2025 11:46:20 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2075.outbound.protection.outlook.com [40.107.243.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7xn2t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 11:46:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TNWK5yMr1VzVJN/ZBzsXQ4mIeL4EkK9zdEPOnCF32sje+0rfC/rSZEk/XYmfnYPN6KX1Izu4f+XVqZJ42yODGxTHfo5g6hBM3nXqno0FEWfRcSBJboyBypjjhJ7lSQV5uMLELv82gdDBey+zGigOdq9jei5JfWbHD9Wc89bu1+uGZb+rMWrFyIRoiiLLypaOqvLNiHYr3rZZcJn/d9U7EunSc4MI6zF/FCUWvHuRtmCcizUU727iIO3uUdhFsnjnqe8HPjTO2be8oEYzMpXt6m/BYq6s/2sngpjOp/jNVMbwrsh9R7o95F3jZjOsezoMOFtO8j/2cDA5XWSHR0iNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sBU1T0zSR2TZ1wXpLVc92ZG5snXdDucM1pvf68NyTy0=;
 b=ttfkrH228WNG5zc83uvJsb72b7iRX3wiNGJJpBQM61swrCmjKtMzb9H3vOXbWtFMLBARBMW43Gmd+EA5SZimsJE4MBFAPP3EtLwld9YK4gImMnReLWtE569+LgplMQ461CqwUau0OhS2bUYbKGgrH3SPO3VN02+EbCnlXTzOzdJwht/Aqf23i5pg7JKddgT1F0NQ0LeWT/KD3K1R5beaIYy8bsbicV5TO1UeOlkIF4+pArV6p0XtaOgvdjC3xNyrGAXOGaoffU2ZGUJ6ldY831q3PPKytdq6n4uYHR+PpeW4Kl7nLRikBz2GVZOGPXC4LlSRYp4D3j756+xdUx2kPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sBU1T0zSR2TZ1wXpLVc92ZG5snXdDucM1pvf68NyTy0=;
 b=HRn74/JcXkkniAtlVGZNYO2SbXae7B1X+CJnJaMQfrAjvl4E7jtTKPH4BalS/Yq4cBTiIPjsb3qGtA72FItjkYBmcEOyM0wCkHJEeZFJ5fv5k+Z88EJg5l7gsYSpx9NmEuse4mqRO35A9oDsgT2lv4CpkKlDwXZBJFjo/ZVxt9Q=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ5PPF912A858AF.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7b9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.40; Mon, 21 Jul
 2025 11:46:16 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Mon, 21 Jul 2025
 11:46:16 +0000
Date: Mon, 21 Jul 2025 20:46:04 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.org>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Juergen Gross <jgross@suse.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>,
        Joao Martins <joao.m.martins@oracle.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Jane Chu <jane.chu@oracle.com>, Alistair Popple <apopple@nvidia.com>,
        Mike Rapoport <rppt@kernel.org>, David Hildenbrand <david@redhat.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        Joerg Roedel <joro@8bytes.org>, Uladzislau Rezki <urezki@gmail.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2 mm-hotfixes 0/5] mm, arch: a more robust approach to
 sync top level kernel page tables
Message-ID: <aH4ofKPyQXoBnLnL@harry>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
 <aH2CXyyrYbgtUXJB@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aH2CXyyrYbgtUXJB@hyeyoo>
X-ClientProxiedBy: SL2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ5PPF912A858AF:EE_
X-MS-Office365-Filtering-Correlation-Id: 56ff995a-71c4-4e94-f04e-08ddc84c32f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r++nzRDPTIXFR8zYDoe/74J7w8BBSM2Kl3wUQNZxBe2aJ42vnIRHdlRKvu7x?=
 =?us-ascii?Q?nMbwqW4t5dW7Eoqx+4Zp30vJ7A66ZsDrSROpq81ZGh2bQ85oDBOQUKHoA1Bo?=
 =?us-ascii?Q?NF7U7LBjmpf0XL3w6XbJaLUNkupj7tKeLgbURB9vN8855LHvYSMiGQ0MlRLC?=
 =?us-ascii?Q?gzfSINHe6SdM+1LEqB+Tm7YQ4/vXv20MxWr4dDG673H/gJ8ygi0K2LV0aQAM?=
 =?us-ascii?Q?brsvDBxFBPzOadPL8hH7ApOLMeYFoB4R9nM3XF4CDWEztPt0j7nvbJx68TYw?=
 =?us-ascii?Q?JDH77bN2eIwtOqirWZxHOsyjnn5f0TeMFWuc8bNICDqVscOonwhRaHYcz/Fq?=
 =?us-ascii?Q?KWUAUJnqG9E6wO6BG/nqB7CldXnkW0t9kEC6Ct95Xsh566mcZpwY5e/7CFmn?=
 =?us-ascii?Q?idSW+5n6SEeWYHKIlsCHSRBG+GFtNuHI06R8Rf/RPZT6/i+qK/1Vfy6+pa50?=
 =?us-ascii?Q?KwKfpQQQiCpw6/qG4wAT2Nto56FAUbGzs3M51ZG4qiAYtu+zoDGv4rbNsmna?=
 =?us-ascii?Q?+eOh2DNO7ZZEBmZLOSWWLiozSV51HkCcqitHgKIagSdeQ3+KqAtJTSsyntd6?=
 =?us-ascii?Q?MKTO1488d8WHYP4Xpf1SHZJsnRpIu1JIdkpLuFxF9is+el4KNkPi7h7aT1rn?=
 =?us-ascii?Q?P3bATaEJtRP9wqkEOFMZUDQJEe4PmsOfpAOrdrC9MQftFHUYhl9Dnk4GDcM2?=
 =?us-ascii?Q?tNkPk4kSiGI2PwfgjLHJa2n8ahjm+k1ofF3Rfe4Ct+7bO8fTjy418J/syfsF?=
 =?us-ascii?Q?SmhezX82YAHextDioyjK9uolYNHY9JIOXVo0IAL2C4sGiHUIrsc/AdoopDl+?=
 =?us-ascii?Q?Qd0NTMsIRfTNcQBB/dA2NQ+EMOQSQUx3CXX0rQEvjkV9vjiyppFArwNjxiRB?=
 =?us-ascii?Q?NNRQNFD4e8IU56c24eGULeUxT/Yb7LiU6io5p423VDMmGiJ28FkvCELiec95?=
 =?us-ascii?Q?yKbyql7iJwrEWq6w2H/d0haW77PSy1RzSu4DWmXFUBqNoVdw4GFYX8qHx59A?=
 =?us-ascii?Q?3YKHu1fbNVGIS0RitCzqTyDcrrF7ZC/DLzqNJ4qpEIrVMI520osOmypa512q?=
 =?us-ascii?Q?CVj/dHl1ZKeouTkoI8viE9OuPxZdu41XHJVmkPMC3R/l6O9ofHvgqyjtIipf?=
 =?us-ascii?Q?bT6dvlBtc+EXT7IedS/U/L8EcQ8KN5Sv2VuUptXu+zZ9gzm5E2eUpIs+nFFH?=
 =?us-ascii?Q?Oo+VyeCAE7T7zAKHWXHg3t447CE4o+NrulygDpbmlYbQKIAGYO08ku+qaVo4?=
 =?us-ascii?Q?wdBZVU8+UyDBaSAglsA4JSpn6regd7GpBvWsZ29W2GwJCqWK68uHvZPM1w4W?=
 =?us-ascii?Q?3WnYJ2AGCzNz/IlOXlqDOk/xA+fn4KHPoTcVU3fT0l3ncZk7T3glizREdjRD?=
 =?us-ascii?Q?3Riir6U/t2XudhJ6LRaSgHcESMGoy6nwP9n7Pf6Cux6PZZw99HdaCs2Inqmk?=
 =?us-ascii?Q?Fuyy2evwEoowQwKTxmpk1AphwsEz+azXG9NvICxWVGMxxmU2v02PahutPo1x?=
 =?us-ascii?Q?qCHp1JCPtYH84nM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HSmCj3ZgSKJ+gvIMEiN1oJ5F5z3msujNlLwcCSbTq9nxeLLIvwca6dWlbyrX?=
 =?us-ascii?Q?7aNaEywhSXXHhQb3WDzbowawqVYU9Lz7UW/26xLWcAX+0/ZsqBwNkhZ6n4pr?=
 =?us-ascii?Q?JvIJ/ZHui7TWCCBZzO2QjS3A41Q3BOJ8XLCwcqSpDmLBSD6QG868LthwAu2W?=
 =?us-ascii?Q?UyBue+5kwJ5SORkff3xMKRezmNtz3DBW+a943JbpJlVlyilM15bSxyqqxcRk?=
 =?us-ascii?Q?D3kA8+7XaonRQ1FZcTiidxOXLDdY9iYpN3sO1dpR7VTdmyBYMTaLTTHEMgK2?=
 =?us-ascii?Q?oJXb3MF/6t1whxSpR9VXApuG1f7zkxCOvNXFlgyDZC8isf59ioy2vTZF/xaf?=
 =?us-ascii?Q?EWMQRwBD98C+5JQPcDHJyKSNKRq/nG7djZP+AJeWmpI3Khwis5r870JBDhqN?=
 =?us-ascii?Q?jiNqSoacynhuzg8Y2Gc348DQ+WXDJu5wwW9Z/C69abaRXy5UZCATR0Rh5E/n?=
 =?us-ascii?Q?W/3N4Zj47dFQINMOjx7tJUZg76gQPiHfucNSSF5FLpiZZzd5Q4bPsZqJ//q0?=
 =?us-ascii?Q?q/yGdHoFNcGgXRroJK3ZfF1k7zq11hLJP2FIE8nV+emqTEJ+qdn9LuwYxtNl?=
 =?us-ascii?Q?qp0kkqr2BzWu0orHx58hH7UDGet/suJMsvaIDR3Yqo0x//ILigG5IpMfhDtZ?=
 =?us-ascii?Q?uoMSsUO6O2VQVOiqD8yINZaUrFt2D9v/aON0L/knoUheRgXn0rrsoeUiqt2K?=
 =?us-ascii?Q?9ygYOF16De3nWVPtHyc3+xASfWvRcdF484KaN46EXpJjchfRoPiLGMoqT33D?=
 =?us-ascii?Q?ty4L5jNvfWIUHOHdQLd/M2n3NkzF1rPjoRAlzn+npr3yNNeOtIChS1HVkhbS?=
 =?us-ascii?Q?G8CuJyIIYBMatA2n8HHyFS9ERB9fFmlQG27IPYOupb1cj5P7vD5ggjUEu3Jt?=
 =?us-ascii?Q?tvYCQwhUBeIewFf7SwqQICdPNbSeEL12QKpHqeiBQ2GxVGzrNOhh12rjt4/s?=
 =?us-ascii?Q?hUnZdZQXmxcdi68UKLBWjxtaW7kTjpmnnblwGZ0vIhFed/fJfWzQXfhaMnBZ?=
 =?us-ascii?Q?akhe8IcfNvs8sTnglDWPgFuXVmSGLWLenNOPww8MCupaPIjU4pLK+idVmyOO?=
 =?us-ascii?Q?Ubr8oFDAk6nZj3Y5MMxcRdB71ZfZFc8sf3kFKt2JDDu/LwEtLi8Xw63rpHRu?=
 =?us-ascii?Q?re6iC33RiSK9v38DhivrYJwvpCIpCLbF2aBajx/Z4Xn8FbuX/h5Pb/SffdKP?=
 =?us-ascii?Q?TI3NuPkJ07jFn8VY2ZWX7FCmebvtjEe2q8jPqegnEnKf/2rdcW35PhxetQDc?=
 =?us-ascii?Q?mNapfgdDsh+jO2F9IuD59ZTT6gWEEQiBrVJK8kdUAGcUWdS9x9lFBMQ8cDhw?=
 =?us-ascii?Q?Pim2bOPbY7DnMqn0WjqgfoKFSN557YZuzVNaHgMaHUY4q5uf9MO0YScCUkIi?=
 =?us-ascii?Q?lK4dK/IqkUCqLSVUOVTsNlO5RMiV5tdbItiu32RWuWcWPixn2BlUj+m/fDIH?=
 =?us-ascii?Q?65RsQvO7eoOSlmomSH2IjeM4dYslITxh2469pWuvzL+Eprx2wea+H+RtxmJJ?=
 =?us-ascii?Q?Tv8JNBWRCgTeFEH4x3BrqER9MPdCGph783Hx6+BDfB6VprSYjMp9LM7l95KO?=
 =?us-ascii?Q?a1RRoPwiVmXwW1YAjK/feLoVaAWxcd9FtiJBcZUG?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TGKvZCD28+NphW8ZbJx1F1ev2aW2/FUgMjdJYLh8yGbyezF4q5aAY68fENmT9ELhs7vzpWkNNi7rUMFwO1MAUg+NMjsHhKfNtO1us8aFiFNr1/LpkLGRLMsHezabtKkczg/3S9Uv4NuDqiTaHK997/N9YgPL+fN/FY9k2ZbeEMoqg3+NFCyicVH8NkVop8aJT7Ugs11zqBZgp03YS/ARjJuYUT/Wfm7c1FaX29vncd1FDY0lGByWN9vzDRrSmAY3ayY9WI1gzhCPU+KE8O91Ny30Cbdxj/NIHvZVpwwb40WfVuF7Q3THiid/271TUysldCYdYzbII4fKrwqttYc2VqLVFQAOLvSOrDXhz1JMBFDvr9qZSfASa3Xob1i2TX4vTX5j2/2eG/IqnBpHqEjDzCUzKTnZVv6qXyXq7yeXQ3bxnPz5iE+rJG5mkQ5KlaK1H1CJhFqEtM/yzuCScROBOX7YCKBeBncQXQe8R7fAjpqEm/oBNv++tsOIOn0dGWgnMhC+gycFSWUL0TVUuT6cVaUYdrRbMLJgOCIgc+rfNg94kjV8TSzW0AujuY4LfKyLQwgMrxXxcKQKaHOllm2vNOfrkBGB967QFWov5wvZTVI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ff995a-71c4-4e94-f04e-08ddc84c32f0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:46:15.7879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/hEF1cTLdcUqsW+JQ10LJhdlcvvv15llC0Gvc8ce1yDrONaJS1sG/SlcKgRusjbBTV1StJo4J4c+VfgtJShNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF912A858AF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507210104
X-Authority-Analysis: v=2.4 cv=WaYMa1hX c=1 sm=1 tr=0 ts=687e288d cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=lG2f1YkmR9W_M6Q_5ogA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: bPpgpYsqcO63BPLcyAc9Gco2chVc4jmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDEwNCBTYWx0ZWRfX6AFxqNHej1w1
 LFsPxiUx8kgJ9Jnp+hotNTjMk4Td9Kou85z04F0r2L1xD+NQwjCbIO7OUGoD2slZhUzI+yNwE/8
 6FeB5cMiT4/JUaGX+G2EkJPEu3QDUfvaSnX1kSdtgchtSv3h0X7cIGfm3/jISOAH+zCehJRgQxJ
 0BiLw1u8GNQQCGdjGeAJBlSQGgcAByjGvCRzVproNiPYPDN0rHJsgi9uH70twoTIHSWGxvqR0Hn
 A/9OBMSylpG65yN67BuanDlnfATdB7Q+PPqsmAiGI7GdtMuLkRafyWhMsb4vOgrTaVV3mTPIbC7
 Xk3FVjfkUGl24Cao3uDOd7yZIWPyylViC3g57q9iyGRU0EPGrU8jD0fBNRBp+6tON8uLfWltkID
 yGw9DCaaXx2Wdjdkzxkrrhr8NuLIwZ7USsT6nlvDN4Ou7e3ciXOI0kyG17B3q9BE6hH8WrlZ
X-Proofpoint-ORIG-GUID: bPpgpYsqcO63BPLcyAc9Gco2chVc4jmY

On Mon, Jul 21, 2025 at 08:57:19AM +0900, Harry Yoo wrote:
> On Mon, Jul 21, 2025 at 08:41:58AM +0900, Harry Yoo wrote:
> > RFC v1: https://lore.kernel.org/linux-mm/20250709131657.5660-1-harry.yoo@oracle.com
> > 
> > RFC v1 -> v2:
> > - Dropped RFC tag.
> > - Exposed page table sync code to common code (Mike Rapoport).
> > - Used only one Fixes: tag in patch 3 instead of two,
> >   to avoid confusion (Andrew Morton)
> > - Reused existing ARCH_PAGE_TABLE_SYNC_MASK and
> >   arch_sync_kernel_mappings() facility (currently used by vmalloc and
> >   ioremap) forpage table sync instead of introducing a new interface.
> > 
> > A quick question: Technically, patch 4 and 5 don't necessarily need to be
> > backported. Does it make sense to backport only patch 1-3?
> >
> > # The problem: It is easy to miss/overlook page table synchronization
> > 
> > Hi all,
> 
> Looks like I forgot to Cc: Uladzislau and Joerg.. adding them to Cc.

Apologizes for kernel bot reports! I should have tested it on non x86-64
architectures.

Looking at the kernel test robot reports it seems:

- ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() should be
  moved to <linux/pgtable.h> instead of <asm/pgalloc.h> because x86-32
  and arm exposes ARCH_PAGE_TABLE_SYNC_MASK via <linux/pgtable.h> which
  in turn includes <asm/pgtable.h>

  I'd keep p*d_populate_kernel() in include/asm-generic/pgalloc.h, but
  move the others to <linux/pgtable.h> and include it in
  include/asm-generic/pgalloc.h.

- On x86-64, ARCH_PAGE_TABLE_SYNC_MASK should be defined in
  arch/x86/include/asm/pgtable_64_types.h to align with x86-32.

Will repost v3 with changes mentioned above hopefully in a few days.

If you have any further feedback, please let me know!

-- 
Cheers,
Harry / Hyeonggon

> > During our internal testing, we started observing intermittent boot
> > failures when the machine uses 4-level paging and has a large amount
> > of persistent memory:
> > 
> >   BUG: unable to handle page fault for address: ffffe70000000034
> >   #PF: supervisor write access in kernel mode
> >   #PF: error_code(0x0002) - not-present page
> >   PGD 0 P4D 0 
> >   Oops: 0002 [#1] SMP NOPTI
> >   RIP: 0010:__init_single_page+0x9/0x6d
> >   Call Trace:
> >    <TASK>
> >    __init_zone_device_page+0x17/0x5d
> >    memmap_init_zone_device+0x154/0x1bb
> >    pagemap_range+0x2e0/0x40f
> >    memremap_pages+0x10b/0x2f0
> >    devm_memremap_pages+0x1e/0x60
> >    dev_dax_probe+0xce/0x2ec [device_dax]
> >    dax_bus_probe+0x6d/0xc9
> >    [... snip ...]
> >    </TASK>
> > 
> > It turns out that the kernel panics while initializing vmemmap
> > (struct page array) when the vmemmap region spans two PGD entries,
> > because the new PGD entry is only installed in init_mm.pgd,
> > but not in the page tables of other tasks.
> > 
> > And looking at __populate_section_memmap():
> >   if (vmemmap_can_optimize(altmap, pgmap))                                
> >           // does not sync top level page tables
> >           r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
> >   else                                                                    
> >           // sync top level page tables in x86
> >           r = vmemmap_populate(start, end, nid, altmap);
> > 
> > In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
> > synchronizes the top level page table (See commit 9b861528a801
> > ("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
> > changes")) so that all tasks in the system can see the new vmemmap area.
> > 
> > However, when vmemmap_can_optimize() returns true, the optimized path
> > skips synchronization of top-level page tables. This is because
> > vmemmap_populate_compound_pages() is implemented in core MM code, which
> > does not handle synchronization of the top-level page tables. Instead,
> > the core MM has historically relied on each architecture to perform this
> > synchronization manually.
> > 
> > We're not the first party to encounter a crash caused by not-sync'd
> > top level page tables: earlier this year, Gwan-gyeong Mun attempted to
> > address the issue [1] [2] after hitting a kernel panic when x86 code
> > accessed the vmemmap area before the corresponding top-level entries
> > were synced. At that time, the issue was believed to be triggered
> > only when struct page was enlarged for debugging purposes, and the patch
> > did not get further updates.
> > 
> > It turns out that current approach of relying on each arch to handle
> > the page table sync manually is fragile because 1) it's easy to forget
> > to sync the top level page table, and 2) it's also easy to overlook that
> > the kernel should not access the vmemmap and direct mapping areas before
> > the sync.
> > 
> > # The solution: Make page table sync more code robust 
> > 
> > To address this, Dave Hansen suggested [3] [4] introducing
> > {pgd,p4d}_populate_kernel() for updating kernel portion
> > of the page tables and allow each architecture to explicitly perform
> > synchronization when installing top-level entries. With this approach,
> > we no longer need to worry about missing the sync step, reducing the risk
> > of future regressions.
> > 
> > The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
> > PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
> > vmalloc and ioremap to synchronize page tables.
> > 
> > pgd_populate_kernel() looks like this:
> >   #define pgd_populate_kernel(addr, pgd, p4d)                    \               
> >   do {                                                           \               
> >          pgd_populate(&init_mm, pgd, p4d);                       \               
> >          if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)     \               
> >                  arch_sync_kernel_mappings(addr, addr);          \               
> >   } while (0) 
> > 
> > It is worth noting that vmalloc() and apply_to_range() carefully
> > synchronizes page tables by calling p*d_alloc_track() and
> > arch_sync_kernel_mappings(), and thus they are not affected by
> > this patch series.
> > 
> > This patch series was hugely inspired by Dave Hansen's suggestion and
> > hence added Suggested-by: Dave Hansen.
> > 
> > Cc stable because lack of this series opens the door to intermittent
> > boot failures.
> > 
> > [1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
> > [2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
> > [3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
> > [4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 
> > 
> > Harry Yoo (5):
> >   mm: move page table sync declarations to asm/pgalloc.h
> >   mm: introduce and use {pgd,p4d}_populate_kernel()
> >   x86/mm: define ARCH_PAGE_TABLE_SYNC_MASK and
> >     arch_sync_kernel_mappings()
> >   x86/mm: convert p*d_populate{,_init} to _kernel variants
> >   x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its
> >     sole user
> > 
> >  arch/x86/include/asm/pgalloc.h | 22 ++++++++++++++++++++
> >  arch/x86/mm/init_64.c          | 37 +++++++++++++++++++---------------
> >  arch/x86/mm/kasan_init_64.c    |  8 ++++----
> >  include/asm-generic/pgalloc.h  | 30 +++++++++++++++++++++++++++
> >  include/linux/vmalloc.h        | 16 ---------------
> >  mm/kasan/init.c                | 10 ++++-----
> >  mm/percpu.c                    |  4 ++--
> >  mm/sparse-vmemmap.c            |  4 ++--
> >  mm/vmalloc.c                   |  1 +
> >  9 files changed, 87 insertions(+), 45 deletions(-)
> > 
> > -- 
> > 2.43.0
> >

