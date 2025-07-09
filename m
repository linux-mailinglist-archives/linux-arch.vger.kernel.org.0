Return-Path: <linux-arch+bounces-12603-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A6BEAFEA37
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 15:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3ACAB3A444D
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jul 2025 13:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14E1F292B5A;
	Wed,  9 Jul 2025 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LHoWG/GU";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dDEVWL9P"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D6E276025;
	Wed,  9 Jul 2025 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752067668; cv=fail; b=edlJqrdCCmockdqizs38QMbSeAS42Ifw1C5BSDGa6qSdgO0jv72DLFFnroIlwd4V1SNkKZl9uJmCi2Dw0cgFwbgMUSjRg203nXl2mxWBHKOZxtkiEbNsOWocOg6kXJvkJh1MmPVG4fciXhqNplAjZgaPsr+Y6wT71TgPOJCTkX8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752067668; c=relaxed/simple;
	bh=4sw//9/DAGTmwSfH9FK+PRHWn6zBvbWu/xU6e4P7ibE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=owunLXmaYleviofO/juUcqoH9BJRFe0Xd/2DBqqXneyMd2H0SLBzomgMbZ8FNRmHK3ysNAYbgWtrnaJJ4xnF1GG93t/blslmoa8mzaypZSpHVrSpMjly/5LZnix0FjHFSKRKvxiI5QS4NwUbg2C/4wtUn/tbl3XB5/ebK1YW0o4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LHoWG/GU; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dDEVWL9P; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 569D2BG3030131;
	Wed, 9 Jul 2025 13:25:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=h/TOS38LE4al5L4bsn
	rApge/WL9WMN8bknP/F9cq8ME=; b=LHoWG/GUi0QTvjQwcZ2gqsbYRX+iNxfc3A
	vPA80w19jkox/8SvE16PaoZ2rUTmBgHLaJ413JtxxPi7hqM/lDDghZUh4fZzTCZ5
	IBB+6nf+L6YI0EeooIez7KAemnFule6MRh3ESiDOXrat0jrxbejYd39MmbcbJPhq
	imG4epU/6fjIs2tNWCCYmzyNUgC1M/1a5cuhzCxLmThzYT8HSNRS+UMv4/pM8hAd
	5mC9S+aIok6ydfj8mDeNjDOtwk7AYLvKgefVDSSKJjhpuPgIifjx3wMpv9Z31EMI
	mk29MCYPXc2B1LWonypLCxI4C0XyQUs6xj4n5zTGakFzPY8b/1dA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47srxsr1n6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:25:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 569DA58M014002;
	Wed, 9 Jul 2025 13:25:06 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgb01j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Jul 2025 13:25:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEgCvfe175O0ryVTD4j1qkdRlyu/8Gl6zDKyDFWIpiCG2zOnMnI6b5lOqUcUCF1t+L30B7yMQkYnU1DbcnCRgD1hCMXAYdT2n+xJw7B3y/E2ZGWpuaCZn9gmshzb7muXO51k646cJUzGPsnMPPttFta6CMJpIVoj+oQBDlT73sPFxARb9pIAXhSte7lOkYS4aN2m6RW98KwK03OHRBLuVS2TAfMRrRtrCx5Pqfc7Tm/Mkx/7aUPSqYSkQGmi32K/+jirpFQvONkPQIxvHzlv4ElV0XyilppHUolgGP9SO8aiQnuqSmb21eCPmcxrQlv56rHrn4XYBLpZAtbvd1EM0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h/TOS38LE4al5L4bsnrApge/WL9WMN8bknP/F9cq8ME=;
 b=ltANfZ6d9xM1lRdJYjn+437yG3i5A7u4l2lVe6xgB18HEejEoNp6QSp24T8xaiEHrRF7oeS9zDDFQxVq+oZHFj17bWecA2/QdljDW9ofyQubrs5ClPgKFo5Z2Mbk2SSbpgJ9VlMW9HJ5+Rr9K/RSKdUMeX0CdrZ9pWevWb7d+3FcsDNkIzzrmDqbi78js0nT8eVnFzaiViFus+8VdqWusThgxbSR96nmybVoBha+uW3BrB62B5XGxCX+YgvelUWo/ATVLw4gGJQg7wamM3rg42xUyuSWIpDuRskA/AgTABPiklKNwKvYR1vXHhTNHMoWFrTz8b/6K07fg5nsZdNqnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h/TOS38LE4al5L4bsnrApge/WL9WMN8bknP/F9cq8ME=;
 b=dDEVWL9PAIUnueVDrQl3+tMzY/jlDCHNIBxq0uCROfq/9ktEpquz7pGaFR+V2PUcIPc+S4zLzk/zvyXbLFHRIGcXQXtyanKHXktTqMpmstkS+hzhWsk8D4BQkeg9PAPRzNiFcinOxfCwdQjoLvBC+I8QNkvGf7Ehb9Vdy6At8NU=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CYYPR10MB7674.namprd10.prod.outlook.com (2603:10b6:930:c7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.21; Wed, 9 Jul
 2025 13:25:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Wed, 9 Jul 2025
 13:25:00 +0000
Date: Wed, 9 Jul 2025 22:24:50 +0900
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
        Mike Rapoport <rppt@kernel.org>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC V1 PATCH mm-hotfixes 0/3] mm, arch: A more robust approach
 to sync top level kernel page tables
Message-ID: <aG5toshwZecWw8ZI@hyeyoo>
References: <20250709131657.5660-1-harry.yoo@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709131657.5660-1-harry.yoo@oracle.com>
X-ClientProxiedBy: SL2P216CA0183.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1a::13) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CYYPR10MB7674:EE_
X-MS-Office365-Filtering-Correlation-Id: a8f84d72-dd89-4d9b-dc51-08ddbeec0155
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kyxrTPbZZHdN4gF4egi6JNnZGbRQ918nzj6xco+CEEfTxQaE+Rmib1MEJ+32?=
 =?us-ascii?Q?yQPDPQJ4IUYlXJ/cb0Tsq0aAXy+WIvDL92B26fyktFw/nmuuxe4tCR6bwKwu?=
 =?us-ascii?Q?qULGPzguu8Fn+ioYLESyULxnN0Y0WLZsy9hEZ4UE1jNegyjfZ1vPRwz6bWP/?=
 =?us-ascii?Q?0pbN+iQkrxjFBv4WLX3o0ygP9o3aKqJhb6LnYXxC++S7sLgNpu9k6KxZC1uB?=
 =?us-ascii?Q?gPjor0VK5mh+fjtciHzcTC9x/G4doD0zK7p3stss2AQRgNqS6fvmoxbdyTGU?=
 =?us-ascii?Q?gqnS68Vaar2uA4RsosNcj3Vy8zM+7AICyyr8ahh7Ww8H0uVva27fMtkFiQ1i?=
 =?us-ascii?Q?UN/bdbVS4Gefs3wWZ6I32owPa4/IHX+Js6znHZ5Gn05PeNyfQVgv8Q7+7HjT?=
 =?us-ascii?Q?tyT5sgwGhQQNHD84HCB2EpkQ5aFm7XGPjFw7KV/A44ehGJmbSCv9YAZq2043?=
 =?us-ascii?Q?loF1P42txOrnapbmm2U2eJAguLXFormI/89YKLIHJ1O3X3zqbam3C4v+2HpO?=
 =?us-ascii?Q?Ub6GJbDyTcJpMvQXUUIhNM3xDb276kidTkoFf1vHXsLEFbwbWG5jZUx3OFgz?=
 =?us-ascii?Q?jBXDjqrHvnmW1JVHjnKRiBRizwSSyemxSbpC9YqF70cquKhWPSqJBJm+bte3?=
 =?us-ascii?Q?2w5U/sXXf7NRH5UbLYuDbgq5R/qb5gxRBxX3OKSxnEeqIj7ongadx2OiAZDD?=
 =?us-ascii?Q?W7W5PvJNhTnNQ61fO3WyOwVlrBTpYLDj72jKDWVp18j1o5IebwAjKc2XqcVA?=
 =?us-ascii?Q?gyItzlmkQQ6qLdEGKVg4JgiZW2JClz2oWMkq7NgBUk9vul2OIKi1ft2jrInz?=
 =?us-ascii?Q?PAXV7bUl1y5/EU71x+GFYrz+HfRa3uj+ZXYa3zN4nhGi9BqM0qqw2esSeDxn?=
 =?us-ascii?Q?YwthoYM1k5ZUw0+zetmYz6IrUjx/ICUO7UrjB7lq4Gp5MR23zi4rN9pq3oeT?=
 =?us-ascii?Q?Dhv0k3P9GrYdJGpY+BINyqDyvnYNG8/FV6oFocKnqCfHdWk1cao2q0nsFa1a?=
 =?us-ascii?Q?h3HYBMf3JfvxxMFTl4fA3iibEfEBDRwlKnvJDi2Qyjzil1ww2EnBP4jB5vRB?=
 =?us-ascii?Q?6lBPvdzHaBnh2XLCy6JkEGLiJKpjPfO6Piab62wiUf3x46I2DKKHFNF0Z3p6?=
 =?us-ascii?Q?NiPtT0mk8AveoVKSGaxPO53R/YqkP/f+0Q2XVlSTcHhw0tkoPmAFDsIEeznW?=
 =?us-ascii?Q?I6zYfsKdhasNbjFwWEkcBcTjFWhV3KDIwCUI79tyDHtf7C40zeBVA6aCL1mS?=
 =?us-ascii?Q?jVB7xsQYrbyIkiVdpt96DsODyt6hPvqLmiNzNlYTbVx0wl3QcIY6MuJ0Huyb?=
 =?us-ascii?Q?1kCdBxzbyBXrKEVz6taUPIDfsc4PdsOx5lSHQljV8z74/x+HW8Sj4kBGLbVY?=
 =?us-ascii?Q?PSCN7gceGHTYRTNL/eHM1MHDlQWspbMx1/Z2qetWAhMjBd8UXCgKI1zmc3W3?=
 =?us-ascii?Q?BImXc/5TfICrKdCOLwU1OAjel0n2AtRFORNZtX+nXrmyDxG9XMhr+A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2RR4KdHXwkUWAdmiL4EYpKfO/DJca7ZcTl1uPqGHJopS76b4jIOb5elR0K97?=
 =?us-ascii?Q?ckszum32h0JUjeGh8yFLeWaEKnX/dzEYOTrgI9wjQlsoTYEcNUzaMcYjunlS?=
 =?us-ascii?Q?ZdjlGudUUm5q8GwwO/BpKu847F38gIpbDD9mS+iKMYyiYbaYFTyQE7szKwdc?=
 =?us-ascii?Q?SRkFpoLTY5gToA03om/JJy0ndj0lqsSlbauTelkitJgizH9o6XIvrLS0y9qh?=
 =?us-ascii?Q?LKccJqSgyxo43lwtKkGpBHFccgATT1y2HNHngJNpOL4iNcdJ0On3jqO77E7J?=
 =?us-ascii?Q?JKXfPz+dlltUgWGLtfqpesth0hfqsdQsRCcnYnO2oc9IWjOyKsvArtjrLtNx?=
 =?us-ascii?Q?hNYWUoUEey0A1IsVHR54PjQrqg0pSUcsgtnJj4dOErbjCXg3ZAPGZYZdOYLq?=
 =?us-ascii?Q?q69o4abwz268hJyoYS7ak7/0CCgAxG1NLblxiAqU9tNI5xhwQC98/WQMDVID?=
 =?us-ascii?Q?CttCbD6m5l2iQAKMF8je0sQnYrisDPlGfa14eT1iVQoLBGivQzkugdm3vpuY?=
 =?us-ascii?Q?rUmFfkUFYyh+eXBHxpGAwUggG6NOV+9rdcIs7FdCnzt7gbLi/3SdpUl/d+kW?=
 =?us-ascii?Q?A373P+ighTW2y+KdqB8nBEGERFpmiK3mROyvFcMHQYbKi+3+SZKdwskagOyD?=
 =?us-ascii?Q?/uxpYvSc3gv2tg1prtq6AdEF3XOnK3libNHXQxz6vHKSTqvfOpZyH60serKu?=
 =?us-ascii?Q?8kS1NzO+QN8qhH3Ki6uGyL62GsKo4sDvxRIdWUvgwWVhnHpnLstY3p6ZPfd+?=
 =?us-ascii?Q?JlrylueW5GTydUq60hzAZvCLUjf/wt9q0WjqTlHXhyYTU42bPwFTmZqYabPG?=
 =?us-ascii?Q?dM27mggMa9rwHazBicSwNaQXRabvDPyI9YUelcJnZZmBWYPe7fuf0DTjUKNp?=
 =?us-ascii?Q?5iD7o58zkvEshHTTf0SQT6h9jugm6o9spgMNH8fD/p3RpM+SJSiJ+csPfJiW?=
 =?us-ascii?Q?g7lnKVBEUyjoI3QAs48aBNjHxzQWgEE5WNTMCST4F32cXbkXKrg6R4E4FuJd?=
 =?us-ascii?Q?/mGisj7EK57VCzj8OJTDY4+edOpiKF+z+Shco2bV2qFPSFZu25zczq5temHO?=
 =?us-ascii?Q?WuJ8t/gOCBVhl7qnYY8QFJgkG9tValGKCKtIIOr3Q/5CFhaLPK3b/7c8FSqv?=
 =?us-ascii?Q?G2YAX7rYht0nOUAfEonc5sN+9r7Z9p7kVcgnCLluYaXnt/RGgmAnawDw6pzs?=
 =?us-ascii?Q?VxVyHPqtZXdnx+QFRURrfexIybgMssgreFmfiUXo5G92mZmLxGY0YmNPOXeD?=
 =?us-ascii?Q?0Is6v1t/QOiNgUGBwskiFQo+CCPJP18p91RWvrrbdvpPauudGj09gN2Enj7p?=
 =?us-ascii?Q?RdN9AwVK6om2Hb7Ome1bfl887Z33bXkvvPmL8FMtWZrI3638JrKDbaHgJC9q?=
 =?us-ascii?Q?Yl3dPznh1PhMrAkh6LcM9z9xkKF/ItW55fUqWZ4ziQp0oYOaF+51oMm9ri+X?=
 =?us-ascii?Q?eaJHN+7sxcRg/bQiE/mz1FlVvyGqxJuwG44rHw8fAQfbJFbMacQQvKx6/uCo?=
 =?us-ascii?Q?NEQy6vxFteELVbrxoS01dHBCkLjLC6LXIBgoGD2rmOeLxOhxTz36tOiir4fB?=
 =?us-ascii?Q?LWumeJtE/Q1otzbOTw+3jlRjaK+/uMclFbW8npQi?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	p5LZC7FFw6zozSvuuSbKvmrDDiKTM4Vq6t1hLr012ewsAOaIimsCNgvqDwnlYLxHtx4RItaNQf9AEUq5K0/nBVIT07Wqxuen8HH7bendDgE3+8yjereJt8aXO0ddHHoYvzNPJjtW3miEL8xr4WG1ooPhVg9UzT1lHKIfO/8RoixEODI/aYFNI5LSntM2ZPxoXVKFpZN0S2cN7KAuyVhsPI0RXW1I+gD1wUaSdjGmkRwVJ/Ec6/yJIl+AWsSze9qVeafRA3Mw8ssk74NP4jt5NYV7nXkwjYj33culTc6gZGo20pu+JZjnOLvQOhfvgYhA+DVjBPC2O9g8Jm9+xELmYf4/rYFo2ZO8Gx57OZYHOS+CwV/3ehkPOKl/5cRLOZG0qlsSYwmfxWmP4jEzv0rwKBwQxMkckMXH41jcKssf46KGUwbeL3jEOHG80Y+GWh//pplLJAucAEDV/aAGRawV9WxZZqgCos5dvaGmkGC5i/ICkiBPrbX4cV7bKMobuRHAR5TdunPk+WC9DKbTtg85qurOkl0dqHxRL3NkGX6+y1tF6Cu3qpUrNRLfCJb2Wgr/bkbYNAXRK442ygoDkFjiQMPUTi8Y/rRMyHZ1ESaCapQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8f84d72-dd89-4d9b-dc51-08ddbeec0155
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 13:25:00.4598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kRZY26FzGMBvqKDG1s7IYwJxaiKhK6Uv70PQI1AlEKKDL5dBK5Maw8/ijry+DbGo+JM91Rim5AtIkz+q7P5Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR10MB7674
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-09_02,2025-07-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507090120
X-Authority-Analysis: v=2.4 cv=T5KMT+KQ c=1 sm=1 tr=0 ts=686e6db3 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=twkACJMuaBEVElg1KpsA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12058
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA5MDExOSBTYWx0ZWRfX7ZVKcKmg1PfZ CWbiQnagDMbLDuPpjBa0w3RGtA1b2RgcG5sRiY5/7SF/G5IdPsMXrlGjTZFkAwR0GaIngg9a1bu /IMGYplVAmByLLogfB5jnyAaJks8GLU3WWD2bSlV6hNjTACvUXX/pQr6qcrq8nNq06PiwgJxzdv
 4DXGUTlI4pe/PuEZyc+J6YL5w4r5bja4uExXHoUFQzs7KiwDVBFnNcWKJi3dpsxTjy7ZXP8vD+J FIafFI8sqp9/7iBQHhdUBawvYG4SiqTNYAgBryyAHpk13cu4AKYwRMJFgV3yMgqwX7rFweY1gNR kc9t3ArrR5YraYZumTPrd9RgaVJ7ETXJGoFEzle3i9+bw4kbH/8toWiXI8KWe5p+DrMoHC7OlpS
 P27mr5BL/N8bc8ilJetiebKy63y+qHMNDG2mym3RwcRuNQQnxA8HVvhCtNG8ppxgIa3EyvyR
X-Proofpoint-ORIG-GUID: _25cys5QVv27EsYiPayD84cCaS4xc86q
X-Proofpoint-GUID: _25cys5QVv27EsYiPayD84cCaS4xc86q

On Wed, Jul 09, 2025 at 10:16:54PM +0900, Harry Yoo wrote:
> Harry Yoo (3):
>   mm: introduce and use {pgd,p4d}_populate_kernel()
>   x86/mm: define p*d_populate_kernel() and top level page table sync
>   x86/mm: convert {pgd,p4d}_populate{,_init} to _kernel variant
> 
>  arch/x86/include/asm/pgalloc.h |  41 +++++++++
>  arch/x86/mm/init_64.c          | 147 ++++++++++++++++-----------------
>  arch/x86/mm/kasan_init_64.c    |   8 +-
>  include/asm-generic/pgalloc.h  |   4 +
>  include/linux/pgalloc.h        |   0

Oops, while I created include/linux/pgalloc.h at first, I removed it
during the development and didn't realize it's still staged in git.

Will fix it in the next version, but let me wait for some feedback
for a while.

>  mm/kasan/init.c                |  10 +--
>  mm/percpu.c                    |   4 +-
>  mm/sparse-vmemmap.c            |   4 +-
>  8 files changed, 130 insertions(+), 88 deletions(-)
>  create mode 100644 include/linux/pgalloc.h
> 
> -- 
> 2.43.0
> 

-- 
Cheers,
Harry / Hyeonggon

