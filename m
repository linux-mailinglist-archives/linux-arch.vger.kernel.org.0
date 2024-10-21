Return-Path: <linux-arch+bounces-8397-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B03809A9169
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34ABA1F233F2
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8B11FE100;
	Mon, 21 Oct 2024 20:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ffx3N/cy";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="amdBPVtJ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27591FDFB1;
	Mon, 21 Oct 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729543423; cv=fail; b=RfsQogw/jpv2Of+6ZhhRe6JMxA9/j6ylfj5b0YkvFvIf684DJDcosMQDe8rIregjHE3FwxbPBrgEGt6gIyRJniyTKInBilWJxV1XNPa9BOPotwi/xQ93WHWjkplq2Oh61rZwUCef7e/yAVWioXse+MKCJgcX6HMoGTCi4Q4Zva8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729543423; c=relaxed/simple;
	bh=6w9xcDDRYJfQ1hDOz4XP7Ok+Twb87EMTCJx01mUS8xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iMEWCuMyWPwC3gFGX4Kh0PQt3s02qpx48zvvOAhB0P4mJs0C7j6B++NXM0JfYuhegQRqlniPETEBW44iWw650C4MHfUIZSvT78Nt2tOZpKBk3D1YDqQ+77GWAYjQ63aK+zVOA6hME1XF/W28V8do1Tq2wbzRr0ordIWaedWsftI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ffx3N/cy; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=amdBPVtJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKfci2011839;
	Mon, 21 Oct 2024 20:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9HILT2NQyhQPmDF9M0
	6BG03TWuhmG5v+NYDTee8CR0o=; b=ffx3N/cy9Pb+A49cNvuJwT3gLvhI8rc3E3
	OPh14ynhdia2HISARBgmyoGvWxVV0p6vDW48/5n6gWkl/87xyzOagxna5HJ7v4nb
	kD5u+5t1kwlCpthTvSTpwCViVjyVDQeHFMHWRCV+Zckb4ZvfMSLWQphZ5TuXeeFu
	dCPJO+TgtFGIcBuRsYGs9cV3KXQoj2lUtvX3j6TleOzvZQ9T6Z+E79ea8Ikw1hFH
	2iGogq1OjoGaPTk9ajGsZvhERYlt+2Z1NqinBofi8XjRlifzjx/wRtW8XPk7vGCO
	Puy4jiwYKJuXBKZGDAq/FgGbnW4iBDcDLW9gguY/CgAZ0p/0pAig==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asc4jr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:43:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKZ5HK012381;
	Mon, 21 Oct 2024 20:43:00 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c376m33g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:43:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xESor0mUcTaAO+nF0X/4OPzZtoc4Y31PpmsUtQVzjrdZFeV9h3oCl41UYAtPPkvD/LcxgXQtjlFFirBJCKrFJBf0eCZ8YkOo3E6WzLVggsI+esC8mRMgWHVTwuMKjHR34RO8R76ITBC7xRjf9QI7kQ1Ri9IthUYZJasUkrU769cIT9ek7unoMEatB+vuRW34W4udJwlfqZ3Wm0X17X58xZFY1Z5uv0SdYrFFUtB3pcXdcf+pKlbEKgNH8hREPCMmOB5oO81me1JHx/KV+m94VaQkfPXDeQoy53d2Imktwx1QsQDMH8P5SY6T5NfdEyB6twzkP3ZpR77V9tLFKHkikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9HILT2NQyhQPmDF9M06BG03TWuhmG5v+NYDTee8CR0o=;
 b=OGkGvcl1Zu/ooGytUPWW1cIyZylcQyb49B1ZAHBhSbyaTIx13TbQ+7adwoW38ZxXLmqMVU9xxczXND4q+kY39dC9T48fZPKZTgw5o1A+7jUgN+BP+1vuCW0UXIVMShLqwX+ksImA0UXkUx1nQbQFzCsFA66abgQwzjRZGmsXDqzIuhzaatFb74cuZMwW0PmxTubOz1bg6nZxWVIyuf5NAjWv9LuWEVfGZ8nSnpVHfIKxQDI2AAqtCaJVVbUpw/qAUL0A+G3fNxbxqHi1PlOdMcvJsJght0EKx3WVNR3Hf/8SIZ+eYNIZd570c2duO/ZVv04x7ZXSHZh7M0C6GtgytA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9HILT2NQyhQPmDF9M06BG03TWuhmG5v+NYDTee8CR0o=;
 b=amdBPVtJvByT2u31XFevac3QJ2qzfYyCFPhbQal4F52Ce7NmRVwKV3+axji6sJAp49dzrAn57pNcHuUjNoWSJe/YohtDKzLH1cpi1+oF+saD5RU5vi0gGEanuUid/rD419+YoCTnLMOhBznjPwvg9wBE2hcklBGxBmWD7xAVKxc=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4873.namprd10.prod.outlook.com (2603:10b6:610:c7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 20:42:57 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:42:57 +0000
Date: Mon, 21 Oct 2024 21:42:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>,
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v2 2/5] mm: add PTE_MARKER_GUARD PTE marker
Message-ID: <69d1e02b-aa15-4712-90f1-6166b551b992@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <081837b697a98c7fa5832542b20f603d49e0b557.1729440856.git.lorenzo.stoakes@oracle.com>
 <9c0991db-9bf8-414c-b3b0-446023df2a7a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c0991db-9bf8-414c-b3b0-446023df2a7a@suse.cz>
X-ClientProxiedBy: LO2P265CA0385.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: 6753d5cf-4987-4450-4964-08dcf210f160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JegrMYk5YnqwqkpKb3MY5X8+tFhxpt4KMEzNUsu1ifrJnym8L/0hyiR3BZLM?=
 =?us-ascii?Q?aGOP6RSeKrLMaZTxE2fpBdc3N264ghqEeS0ljEX6oQduCfEwPQPK0yoXsNjW?=
 =?us-ascii?Q?36NRbBUOxvRZbJIFJd8ejMRESQnvqWVH0CtxIfnnH6a0ZXteQbXljqreRYhV?=
 =?us-ascii?Q?D6idc/8r/rta5d0KJ0C0ANyruF/g4VbiFZ4Ujl53AlXfefp2sdAfnTtjmOGg?=
 =?us-ascii?Q?ctmyYJR9lwebf+lkNI4w3HuJcE2ksGjvwwcJtx/hPyUqW+MRgCk4AsR5TnmF?=
 =?us-ascii?Q?Xp5KGDiNkKPM9ht7DpFwXiizva4m9bSv+dlpssirYhZMnZeQ6Nwhb6Zp+a7t?=
 =?us-ascii?Q?ah/kZ/iw71gbPKitnbNWCGtScD21NrpOUwh39QIfQHBQr7ACzRVC4ZkvnN1J?=
 =?us-ascii?Q?WzOJrmjJFY0cy9WhGnjTqB5hbVohOlCROE9iAYYEQSpRQPFAAhFysQCJN/hK?=
 =?us-ascii?Q?/20iu7+KmpPMyYLdMT9jUhuAZErNwhK9mcO/fpPCPcGCFc8rNMfCzBtAoZsj?=
 =?us-ascii?Q?0EU36tr1HR6/O2FBVFk5cB/bl18qhAHt2Lscy2jM+9mRyp2X42qCBsegSeMb?=
 =?us-ascii?Q?tYco+i/FjvnHhlGYeWx3bhded3fZpOi+4lbjLq0bSLEP1JoPRGEIz97yTHev?=
 =?us-ascii?Q?nBzh09POk4xreVotbjfUXjyrO4GcUMQTElxp7YktdK2n4SWLrvFet54j7yDN?=
 =?us-ascii?Q?ZSeX3Vsr7iPkJDmYActIBpk2Pz37MR1e47j+jBPpsUZ/Fc/oZKQrnWEvKvR5?=
 =?us-ascii?Q?WHxC1CqyaK1erJLmRcaZ6fGmRYY5Zb4nH2VnCApA7GGnmvyzgQGOQypGlzNn?=
 =?us-ascii?Q?1pZZW7/1JR3q5wZEnWd+VBte9pN+jUaiFyMHc0wbk72YCnDKA3LmAISeUsRH?=
 =?us-ascii?Q?vukkgvax+VnWGXdO5ja7e8g1bonV7Z9HvFcTVSS5OIKpeLNyohXuhcuKGWLX?=
 =?us-ascii?Q?1jRhaa05p5p1/VlfuE2zbhF/Koslq7XUbykDXHVhFUMAbodOQfCYHlPJ1xnR?=
 =?us-ascii?Q?+TBo/QjmG34IgATfs48zBLNhPwEL4n7fLe2AIdR3mqXkNejMuDSCSyAg3yte?=
 =?us-ascii?Q?m1jqgz4G/sQnWsbcPtCyeOIFZD7okfl0OShZmsgthqXHx0rNqPMEC5Yq61mF?=
 =?us-ascii?Q?+Ez/3u2HhaH3eiophkBYwnMW0x6QHGbTNxNcoFGCQ6aKlPPVOxsth0GkQajx?=
 =?us-ascii?Q?QB6DPNAAcSBj2YWGYZle46z7Cl3LoRG9tnOqmWmkH4mx6UVg1Sa2+hDlxtdR?=
 =?us-ascii?Q?qSt0p4iV8p0f9yTsqF6T6kVFbQuiz76sQWnxcc3Nu5QcCOvS05w2g3cv9KOm?=
 =?us-ascii?Q?qlJRm7c9s1A+SxQqGCmqrJy/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SOZoLC9PuKBvlhd3bi/E2Iyfv+vryJc0UD1gNt+yWplpPY73eD0VzuOZspxx?=
 =?us-ascii?Q?wogpOP5IQc1oLlVa1xbMnjRxDg8I/jx4CVnWgl0z4MJOdnmGKBl1D2N0j7MK?=
 =?us-ascii?Q?SHVp9BJ6W9TSjNWND3uJlRsExngvvhfAaB5rHtUGewX9RNpXn6ItuQt2Ts6L?=
 =?us-ascii?Q?NkASukbIjzS/sJ2XUn2zAPHdkOCc5yAvc6z4Sbltctwak1yJhVDGFF2T6I3X?=
 =?us-ascii?Q?8LY0gGz2nJWLbKmHN9nFHPzuEhHPhdE4X3l+fCkMO0kF0ntGZ/Wx2hboyGqP?=
 =?us-ascii?Q?RemGu9cAeM8XjJMeR9dbuMwbOyNIIRikyYQSU/Z9gKatw2NSb2FMzz0G3IbY?=
 =?us-ascii?Q?CjtVP4i2sih1rqQxNhT6qKAaMVl0vgwSEu0j7sUEREk1VGZ/JyjHW7fURpiH?=
 =?us-ascii?Q?hRh5dSIrhe36fUfILwSsws8KdCqcBacwHn2Rs1SGheZ2T3OKcrR5OHIQNhYu?=
 =?us-ascii?Q?MbwluYOxnRWKaeF9x/IC48Yao5jJtcWqS48vsRrgk/PVm+JI6lmJefLXiHfI?=
 =?us-ascii?Q?ZKZ2fmKZyjzqrWtp+gfnGqiVH/RyGQFDw74SNMqDDPplacxXOz4kh+8HJox/?=
 =?us-ascii?Q?wafi8+CLfubcAajdrws6iLW25ZH+XXLBJtTy3gad3KWz3ScD11zn7D0LRWlh?=
 =?us-ascii?Q?ZGLvZtXqSXKZJ27DhEFm+FJb2zMsCqteCUO9uMGlJgYnz20ztCABjZAOMIa3?=
 =?us-ascii?Q?hgywRdUEk617pluD8fdHXKSpmpHE3+ZFFXeyPlb/J0yEAXhL2FJpMMx++/e/?=
 =?us-ascii?Q?tSZU1XN9l6OTAxCjL4+s5vlJh3mVpWmnyXosGBtKxbmx5OSvQqQ//kqRNrSA?=
 =?us-ascii?Q?nmQX99vDDR7DqssnzSicAQg88LgfzIYQ+Kqt3L21AgeoVqbSO1ult9nk2VEs?=
 =?us-ascii?Q?LBzCmswNnPQK0OACGczO9MoGfWdyF7Ri1gSgleJoM5GfQGfJok8sas+rIQkk?=
 =?us-ascii?Q?FSz0sJ5tVp8Lx8Wl9ws1cAY7tW2ERMSjCffnBmEwBkBY8Os1DwjPZxLZDLwq?=
 =?us-ascii?Q?j647dzYPvFPFLT0tQEhi0dPOeCN0PZ52653toNbFLRK9pyKzAAfD/OxH16WV?=
 =?us-ascii?Q?aCZjdgsjjatm4gcrjDGbGs2L62z6GNNslIyEWSEgAgpyjJt5558k8FFpSHD/?=
 =?us-ascii?Q?KIbpWkX66HdbShmVeb8WGAEsWJgP1JD9KLPJ2Xw2Wbr4cc2kVkAkCH1Qjogn?=
 =?us-ascii?Q?FF/TT4I0Nbl+uCGSSD+DBd6YCkxhdCkTeRBbYfANMWnLYULUbNQWlYcfunqw?=
 =?us-ascii?Q?8ZohtNev+7o4Kg+2HznYU3CA0hWWdQ/3ETj6GhEx1EAirmMlAvIMDH3uiUfL?=
 =?us-ascii?Q?99K3NYzexI70T5Jtxm5vTxKjbMmYWcQYczHmO0XICFKmNVH3daeDXbZZQImG?=
 =?us-ascii?Q?QJypWP9DOEMtJpzec7JrHRXKf+ik/eBvJn7IMYnOMxSJhYEmqi/P6C8kAntp?=
 =?us-ascii?Q?XXvCLfvN7OQELXq3FEQp7aj04AXkWBbMQq7U9HUhYDtfHTP/SZGDaIJq35ee?=
 =?us-ascii?Q?4h5b+EhPSHxEaqIw0qJyEw9IQgQk5ecQDw1HPpla5Mye4X1MbEDQLotAnONo?=
 =?us-ascii?Q?nwbDxB5uEbiGHzQnxvD+F5ENDblC9skhLPNdK0Mk6TAzxakrfjQqhBiPoFpc?=
 =?us-ascii?Q?Sw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3o47v0W8q99GXy12zRyurANEcrU144j9IZs4VLQQqV+0VL71qGJNUPvQZFlItuyhDu7O6UO0rwPI5Pp3MjBvtwPFqbPhGGkyirYrdkDsj8BJ85JrDxIl1sBPjNPg7hLo26Xb+d1CcIEFHL53hrrZ+TAuYrYo2ZjWC8pYGj7HTRk1+QLT4AX8rKhie2gX8SgG99NyWkqLq7UJUmS4nTk/OV36sJe1pYlc6qhgvyHqLiMPN9LCXKFcbnOpOeOZsqm+SlmkHZavFACYU6fOEZpqsYwaEtPSyZf/LNUCEID4tNPtM+u4SCkr8xtF8OK7BXAhTQkPDnHDYZ7zKwjmzaI181ka2EkiK7ICVpv7QznRhlC1mt8EmEn7bK+/ufUHQNaUQZIwvnG8FoKmvJ8254pG0y/S3za6eqSlWS5kP+94z27dBAzjBYwg1eChvc9+EMxB98nNl5ogYeSj2Eaf51C9AaU6Xka3CIUKDTNd2IuLlXgOHzODo1YjOOwlVNG9p8o8xd/XTMI4WeRlIhXA3E0T8VJiad9eaH/uBznWeS5bO8+MLpDP5729w4v3ilaw1uBAtM0pNEecrPxLkz5KdX3frida/kmURGX66H6BkGn6an0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6753d5cf-4987-4450-4964-08dcf210f160
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:42:57.1128
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+/jVv7qkfEYStHp7ysZW/FYutSX8KF9tl7raBxFvBmElGD9dLkZfrpDA3Ljw/mw5S/H72WJwlkaOQi6fCkh2Alendmf2Yb2aKk4g9sZgxc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4873
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_19,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210149
X-Proofpoint-GUID: I20iQExu7AGQiJJyjSN_DYhGpXg4e_4O
X-Proofpoint-ORIG-GUID: I20iQExu7AGQiJJyjSN_DYhGpXg4e_4O

On Mon, Oct 21, 2024 at 03:45:31PM +0200, Vlastimil Babka wrote:
> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > Add a new PTE marker that results in any access causing the accessing
> > process to segfault.
>
> Should we distinguish it from other segfaults? Is there a way? I can see
> memory protection keys use SEGV_PKUERR, but no idea if we have any free values.

Wasn't even aware that existed!!

I'm not sure a process can do anything particularly useful with this
information though?  Hitting a guard page would indicate a programming
error rather than something that might allow meaningful feedback to a user
like memory protection keys.

Do you think there's enough value int his to warrant digging in? And indeed
I imagine bits are in short supply for this and would need a strong
argument to get... so yeah I don't think too worthwhile most likely!

Thanks for the suggestion though!

>
> > This is preferable to PTE_MARKER_POISONED, which results in the same
> > handling as hardware poisoned memory, and is thus undesirable for cases
> > where we simply wish to 'soft' poison a range.
> >
> > This is in preparation for implementing the ability to specify guard pages
> > at the page table level, i.e. ranges that, when accessed, should cause
> > process termination.
> >
> > Additionally, rename zap_drop_file_uffd_wp() to zap_drop_markers() - the
> > function checks the ZAP_FLAG_DROP_MARKER flag so naming it for this single
> > purpose was simply incorrect.
> >
> > We then reuse the same logic to determine whether a zap should clear a
> > guard entry - this should only be performed on teardown and never on
> > MADV_DONTNEED or the like.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
>
> A nit below:
>
> > diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> > index 906294ac85dc..50e3f6ed73ac 100644
> > --- a/mm/hugetlb.c
> > +++ b/mm/hugetlb.c
> > @@ -6353,6 +6353,9 @@ vm_fault_t hugetlb_fault(struct mm_struct *mm, struct vm_area_struct *vma,
> >  				ret = VM_FAULT_HWPOISON_LARGE |
> >  				      VM_FAULT_SET_HINDEX(hstate_index(h));
> >  				goto out_mutex;
> > +			} else if (marker & PTE_MARKER_GUARD) {
> > +				ret = VM_FAULT_SIGSEGV;
> > +				goto out_mutex;
>
> Given we don't support hugetlb, should we WARN_ON_ONCE() if such unexpected
> marker appears there?
>
> >  			}
> >  		}
> >
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 0f614523b9f4..551455cd453f 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1455,7 +1455,7 @@ static inline bool should_zap_folio(struct zap_details *details,
> >  	return !folio_test_anon(folio);
> >  }
> >
> > -static inline bool zap_drop_file_uffd_wp(struct zap_details *details)
> > +static inline bool zap_drop_markers(struct zap_details *details)
> >  {
> >  	if (!details)
> >  		return false;
> > @@ -1476,7 +1476,7 @@ zap_install_uffd_wp_if_needed(struct vm_area_struct *vma,
> >  	if (vma_is_anonymous(vma))
> >  		return;
> >
> > -	if (zap_drop_file_uffd_wp(details))
> > +	if (zap_drop_markers(details))
> >  		return;
> >
> >  	for (;;) {
> > @@ -1671,7 +1671,15 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
> >  			 * drop the marker if explicitly requested.
> >  			 */
> >  			if (!vma_is_anonymous(vma) &&
> > -			    !zap_drop_file_uffd_wp(details))
> > +			    !zap_drop_markers(details))
> > +				continue;
> > +		} else if (is_guard_swp_entry(entry)) {
> > +			/*
> > +			 * Ordinary zapping should not remove guard PTE
> > +			 * markers. Only do so if we should remove PTE markers
> > +			 * in general.
> > +			 */
> > +			if (!zap_drop_markers(details))
> >  				continue;
> >  		} else if (is_hwpoison_entry(entry) ||
> >  			   is_poisoned_swp_entry(entry)) {
> > @@ -4003,6 +4011,10 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> >  	if (marker & PTE_MARKER_POISONED)
> >  		return VM_FAULT_HWPOISON;
> >
> > +	/* Hitting a guard page is always a fatal condition. */
> > +	if (marker & PTE_MARKER_GUARD)
> > +		return VM_FAULT_SIGSEGV;
> > +
> >  	if (pte_marker_entry_uffd_wp(entry))
> >  		return pte_marker_handle_uffd_wp(vmf);
> >
>

