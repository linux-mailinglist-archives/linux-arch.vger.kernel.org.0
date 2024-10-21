Return-Path: <linux-arch+bounces-8394-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8799A9132
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 22:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A300B1F23142
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 20:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5927C1FDF95;
	Mon, 21 Oct 2024 20:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BE7VIyNd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eng44eW4"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85671FDF85;
	Mon, 21 Oct 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729542521; cv=fail; b=CtWVSVmyUIGOmHyF3ZNsHSRO7dhdvMg3Ahcqdhpd3FC6IJgrO89tevvadtXICYF2d9kaUr+MV9hGGarpfLPt6uKwDRz8z9zuxiIu57grVeXdgQHbTkWlNy/XbwCmZy2XXBcUq/tYoEGKZfjRz9aP1+frDneLAZNMhHmCMmdMnjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729542521; c=relaxed/simple;
	bh=RW/WESB7n0sH/HXMTSo8weCbiJ9JZwZ16VmVY0c9a+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eMcRk3fi92J+4aKNMG2g8Voq5aak+aQ5ZAXNH/YYelDwkVXI6zT2f4PxV9eTgSoSkbEFtMpSEfuS5RGHYsvhVZhZ4MLQOcUj1HIHANtHOWsiJpPC+z/Luv+bMcm2IQ6kheNKAhIb3LLzWHGmF8kbVggrttqam/zN5j47OHlD0IU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BE7VIyNd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eng44eW4; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LKBcrI018559;
	Mon, 21 Oct 2024 20:28:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=9sESAMtA2jGOxGjafK
	x8kKZu7GjHm1AgF0Ti/l3Wp9w=; b=BE7VIyNd9RZRwPlTrNxcZRaYN/9yZPV5Y7
	Cpn1HyJ4VLJndkQtZhcVqHzjbOQ/JFixc6bs0cU0VnKxcupxYcZtz9eOHnT2AagV
	lsMmMRKix6wXSGrfS+6skutkUOBnDEVLlqeOepniNbo/lpv8GsO8tuj5Z8q0cL+t
	r3BuVEGzg6Y6x+AgO78dUNHECaCxaEKxloBGR8F/vN5PwSZQlo86oNGoZ23od1DI
	WeY0Hei11Lnaja3cMxRybiIYnoOyIg1nMa7GfbZgg83ch664etf9UGibxC//Ak6c
	w88nz3nY10dMI0eHwZbZOTlLQyWsGdRQx1JS1FTz3te6kFele3hQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqucft-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:28:03 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LK2gIN035330;
	Mon, 21 Oct 2024 20:28:02 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c377juyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 20:28:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F/y0pN8eGaDMTbBd89PLNdlKnS61mqFGrbR+58FfKfkoEO5bgHcwLSTdm5kBRZ6EAtOOiHCb6DcdYVQSuMLBno7HmEXXY5K4xNipAfbmJN6c/YgQRppCvaQQKCMaJB+vtL37LnvUgO4XsIEb6Hdm3MSMuREn4rfuLblCzjN11e9pl7kWma+jE7KMVjD6JmasPsSLMTWpKRDvbUsz6NOd5o5XY5UiiLS1+82SUAoZkl6ipksLlJY+II+biqSqjZFB/WH9Ip1BUcbrF0EAqQkCQr69+yR0bqhv7fTRLVMxibSCJxbFJgql8spQ/dAj/wMqer/Pm0Agu+/VE2CzNxtUZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9sESAMtA2jGOxGjafKx8kKZu7GjHm1AgF0Ti/l3Wp9w=;
 b=u10xH0WhtewCUQFDQHPZWAXmC5PduIp/AiMAUqlWZrqwixD+eLMbEhM1i5kgTn2abZGZmlwzHfbNCasSP8ZAjy6KXQwVuiosIK65A7Xbe9dSHOKoLGU8/oVGD3+EwImHUwyP10E1dOXpgEuGZkXjbtsG3PsUZITVMEcSAgXDnBju3XNLbfl5KGgIQw4a8MZGFfl0gR/MR8/y3qg6WP4HckkZM7RvOZCrn/n4EWaFBMbXgGPXOBULUtIAhRyOABAAoF+RfXvPY4o23U0IXD99v0ZCvHpj5CUJCeX8j/juiaucNWifeN099UNgQ3IcsLAOXR0+pY0Ul5NlTx6lt8Q08g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9sESAMtA2jGOxGjafKx8kKZu7GjHm1AgF0Ti/l3Wp9w=;
 b=Eng44eW4gK15cP9uiR5T3dZsG0Wo6zliApGJRXBaUjyJUd5UbN9Spd6VMr6vaqMzhlardWhhomc6XRK6vIhF3KwyUHdDbM5fLEGHob2FjpZ4IlxlCevGRyxea0NY5PML4lOHbd2+6OW8WOZBiadbfKuBDwtRTCVBifODAJ/hhXw=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by PH0PR10MB7008.namprd10.prod.outlook.com (2603:10b6:510:287::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Mon, 21 Oct
 2024 20:27:59 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:27:59 +0000
Date: Mon, 21 Oct 2024 21:27:55 +0100
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
Subject: Re: [PATCH v2 3/5] mm: madvise: implement lightweight guard page
 mechanism
Message-ID: <393b0932-1c52-4d59-9466-e5e6184a7daf@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <fce49bbbfe41b82161a37b022c8eb1e6c20e1d85.1729440856.git.lorenzo.stoakes@oracle.com>
 <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c37ada68-5bf5-4ca5-9de8-c0838160c443@suse.cz>
X-ClientProxiedBy: LO4P123CA0063.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:153::14) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|PH0PR10MB7008:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f6cd31-2724-400e-45f0-08dcf20eda64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wwClLb4dFVX4jEp5NBbwwvy0GCzARrWC7y6MMLeOVc+EwFaXWuCN+dvsVeOz?=
 =?us-ascii?Q?Rsi/MI5JDX1Wxi4v8yKAWSDBF8f+P6QeklfIlJcJKLBZgmlD5WTheXbcvZN3?=
 =?us-ascii?Q?BB49plqR1SJ94IzJWmXf7rsL0+IIhLSZIjwnyPVZ7Eo1OzeOtQw2DDxGUznZ?=
 =?us-ascii?Q?F5abqxhAN/T83nJFqNjyQe80S5WKEJI92w2skv9f17oOK05/5MqzImpzwxfw?=
 =?us-ascii?Q?en50wrAGZWIuo+KOs9vmEe5j7stzES9gBAACA8NIeZuuF65oOmJzTaXkuRvZ?=
 =?us-ascii?Q?W210eC7GXn0Zmio2q8LVWPzFbt1avw/oaYid+5O7P4qUMFjM438a3VsbIAg0?=
 =?us-ascii?Q?ig1H/dmeib2OZoJnS+l41zaSQt3GDWy7B5AmhwJvKppapfwDgbroCYFmmbdo?=
 =?us-ascii?Q?MOe0mk6AqWtI5vojauUJUcnWGR0HksXXcF4mpOW4zH9w0p2vemh5aonG3pJi?=
 =?us-ascii?Q?lI/d5X2XOwgW7kUBQy8LVedtqWWmKVqC8ORmVf45gO+ILYMS/Mo0KtAFe5sb?=
 =?us-ascii?Q?zhqCAw3Ia71/rB/Row+rAoCgMVCBNRo7XyY6vUQyKT9+NMiPMnf0onJYXlsQ?=
 =?us-ascii?Q?SnAp2QWK3oA0jZuDERgc4T/WyFydV1uM4+HdEFEgtwzL90AreeNDBz3uOe+Y?=
 =?us-ascii?Q?Yfr9fLvfII75oGeio8/XY8n/JEYACYgeBGufyrZC31eafKyDd37RJPWxXUNC?=
 =?us-ascii?Q?EQ9+rRUOwiP6rc0pLIb19yrWTwSoXsO5tcbsUp12KRsyphYZ1xdOSfa3P+KG?=
 =?us-ascii?Q?xow1BQh2dXko1ZWjPhZZOYIwGiuxw5QLkSJiYW8H1MbbiZDnliTkfDBtfihr?=
 =?us-ascii?Q?lPyOHs6GhSWQ8clUo3qMiJWY+Fk8PK0CyojCCCBVEE41Z5esxpbXhwOGLHKw?=
 =?us-ascii?Q?xSCE9PT7FedFKoZbcuETvnMWPyUOql7HvxBP3YhdxogAHZPVp2x6AxGQYOjg?=
 =?us-ascii?Q?iLV3YXgd38yonupvw9je3emu/71+NTRKT72kKkgUezzU4Gw/YdV9jMF5k9rY?=
 =?us-ascii?Q?gGfWg5R/F4knH2WWOh9wO6QkVYpMz2HjIkR1Rkusf38SOnZJGBCSgjPSVlxn?=
 =?us-ascii?Q?gHZqpF/GK0/a0Bdz3tUo3dUDashRGolnlGWI5JZ0Wwhlz1cXuoU9/z4R8qjK?=
 =?us-ascii?Q?VqXIV2vbOkMDOLNl6gvWT0dG0fY85pJWcFiX/qX23lOKDRqii23Fl3tgvlGn?=
 =?us-ascii?Q?eqGxWlhtNuYCvXhFkkHKwOfTZKj9OfbCTQ9u2IUjYVURnNegewJh6zFT9awA?=
 =?us-ascii?Q?h/WEHcOEQmbYVbSW/QwHCyRurTk3K9LiWY4GXJyFVKLvkr/RVBRAa8RBzRRC?=
 =?us-ascii?Q?FZex/j2xq2Y7KcQYFQvKNXd6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?m7xi7uORdr9UzOxxtHuulGHuBBsLKhOBdzpd6GPbdCPgOFxZRZPPHSfmWi8T?=
 =?us-ascii?Q?3JiIM9fAI+85z2IO4Vj+OePEmTwIl+a23C2EzzWKHtPU16zE8+nRCPmzuyRU?=
 =?us-ascii?Q?iq+H9Vz7q2TIp6XyelEe1pR6TvykHz0llUDZmYD2wHsoeKZTASLC2t+iexab?=
 =?us-ascii?Q?n9cxdA4g71WnZjSiCC+pvLH2mXw267BYhla4P4sYqGlu8oHbtpCSvMPnIgWr?=
 =?us-ascii?Q?gzTj5CT+odReAO+ZuaaogXZTCUCrpyjs5wa/DHoH5AXP78b3MtxqCp4pYdy0?=
 =?us-ascii?Q?LgPT6wgAn+8hcW5x8tOGoAHgQAAeHrgmVHBTn6N5h71ynCCkWH0j2fDzYYIV?=
 =?us-ascii?Q?XAxmWBeC2Dv8cvxlDTqn0D0HDlK/IPUoVsOtMIweVHMd2Z3H4rnpJIfVOzqg?=
 =?us-ascii?Q?bK3ib5aLAQSa1NOT7mvXvST/w0N0fssYYql8W4aOFrRG1AWAqu408MjMWpkL?=
 =?us-ascii?Q?atTtl0728TD/NBVFhfRl8pHRFJaZnDp9Kg58mSovleOEFze8A1KMkG2hawuy?=
 =?us-ascii?Q?LLkRqE2IwaXBrQ9CSqQw+xG+jtVlmxq25vAefdqsVn1tjd80pweF7Vj2jLJ4?=
 =?us-ascii?Q?vJ7/EGQS/1IjyeWeNr2PvgA+5aap1NmH9ry9rHg67vAY+T18KNHlEIutwA7L?=
 =?us-ascii?Q?HFMvK1YsOIiir2L/ZR5MBSkByKq5JQoFwD92gmMF9fzbExBohgb50fjsF/Tv?=
 =?us-ascii?Q?cvrb5v3eJb8F1CPIUPmozAuhfQ2uouNSygYOf0OHifQe8SoWqXn+StaMNBEv?=
 =?us-ascii?Q?/Fg8ojwUFgaL53W7AnpxUtPq78oz5lP6fDovKup4qwDmFz3KFtUXhiYaIDlv?=
 =?us-ascii?Q?TYIg+0nekwV7mjU2AYpqAA9bKsdLxs42IXUrp8gYIsTgjGNtTAqSh+/SCsRb?=
 =?us-ascii?Q?DYaHAZay5v/qUuH5dbGn/LLJMTS0OMlQBmsYupTaH2+ZuFj4xTIhvpaoZNrs?=
 =?us-ascii?Q?/hr9NZMLbfLuuewIpUztMOUvHzgQI5s9ucjSsUHuwxLoo2BmabJCYzZ4mCJi?=
 =?us-ascii?Q?URNaaKMMkgd7B05YTfRzypSfASc4aP9MTWuSx2uJecOo4LuysD0lTbT/Nf3M?=
 =?us-ascii?Q?KuLbfPhG/dqbvmaEnaD8vK+Rmw/fYxpz83sHfY6kqFuparKl9s1O6lMVgvIn?=
 =?us-ascii?Q?9L7OoraXeRdGTOlvtLguTAk+PYLwmU+30/t9NxO6HE6XlcklT4HXqFGlOCYr?=
 =?us-ascii?Q?9kY1D2dAfdd8DdXZiOekeoqXJOXBfvr1xFVmRKpVeP9Md3KNq9agh+yNm+hL?=
 =?us-ascii?Q?GWx6QGesGOGAgvq6Ch0OFayP+3b1X6GvZ5aW3LlPWRBLvyXUTaePBgNDqVuY?=
 =?us-ascii?Q?uNpnobAIYpZz9SRbgxggJ5GUTHCwPiFJpSyHwmMvPmuI82/gaGTPscQoT0w8?=
 =?us-ascii?Q?O2dM8cHbkuEZ17oUn5Wcx7wA04CDJO1HRGSycvj28AmgPaDJy+VBUOZ1auvj?=
 =?us-ascii?Q?GEpWN72DidEORmVKPIsZHw+8I3gFR/s55CAgBcaAjW/nt99T6ukP+gODrW6A?=
 =?us-ascii?Q?QO6yHR67TQddE5F2pIIF9S4D2S3/R3GnXivvXB7O24UCepwBxb2gfIePECz3?=
 =?us-ascii?Q?/Rj6iNh6LTwZ5xsLf2KbFbXyGBBNSRcQT63KOWHRYP+LpN8wE1OLQNXeXbTr?=
 =?us-ascii?Q?pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Vjc5//bSfq/jKnyFikFFZ77RCfSr8d0JgwTSmwRcHYP7jdraESW8FypVf/7HlVMwpQJR2uvHC0cQSkRF9xuRT27+fq1+xN5r2Kis6x6k65EVdz6z6j45g8yJOY/tGfnqOYyQ3EH4WC5D+Io7y2oUqn+z3WlUBRnxWqwSD0+lrTCMLJ2kNcbQnu6/1iIivpFL1RyrHqUoF0Y7SNf/ZiDZ+XZrBCLvbA03KBPAcP5cFRVDHPA80N/O0gxTSNK6C1DvjoE/I0gRHP/qPVyjw/6BJ7aBGF5zqa+kIkLsb8ZXuTClpTt6hiER4FsDA6QvvtCjVvlmJTj9bDfO5+XPwjbqspsIIFNpYlVuxLrxNbiEKYisoklXckjZJtiM38/uVglNZ7/bFa6+RchD8jbwpOFD5+3eqbu3A5rHk62OQT69wOe+0pbz9/mJZV4Sz1HoplDMtrgu0SOvj5bOrJTF1doirXnsTDZDpnjWqeg7zI1RZx0SHgnyZ9xJeAt/AHVC065VVXFzPfaLUCFCSyh7G3PXOO7wb7/rUuPB4+CqoGODlB/ee/EZh3OZ2/dvyUnQb7dWR9DTFiY0Mji84nLt8Z7b/2pWsl3JWoHs/ZU8/g+R+wc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f6cd31-2724-400e-45f0-08dcf20eda64
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:27:59.0196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMNfZuI+WPt1Ekojc2jW50Xvi5l15gtaI04zlRo2PczbOszRk8boblNQ+wCd3iBYfuuhnzJzZTcdR7n/8N6Jrf6+lvBViUm3fvfNKKnzxi0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB7008
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_19,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210147
X-Proofpoint-GUID: TuljucuXNgO687vdQmk26azeF-NYbzOV
X-Proofpoint-ORIG-GUID: TuljucuXNgO687vdQmk26azeF-NYbzOV

On Mon, Oct 21, 2024 at 10:11:29PM +0200, Vlastimil Babka wrote:
> On 10/20/24 18:20, Lorenzo Stoakes wrote:
> > Implement a new lightweight guard page feature, that is regions of userland
> > virtual memory that, when accessed, cause a fatal signal to arise.
> >
> > Currently users must establish PROT_NONE ranges to achieve this.
> >
> > However this is very costly memory-wise - we need a VMA for each and every
> > one of these regions AND they become unmergeable with surrounding VMAs.
> >
> > In addition repeated mmap() calls require repeated kernel context switches
> > and contention of the mmap lock to install these ranges, potentially also
> > having to unmap memory if installed over existing ranges.
> >
> > The lightweight guard approach eliminates the VMA cost altogether - rather
> > than establishing a PROT_NONE VMA, it operates at the level of page table
> > entries - poisoning PTEs such that accesses to them cause a fault followed
> > by a SIGSGEV signal being raised.
> >
> > This is achieved through the PTE marker mechanism, which a previous commit
> > in this series extended to permit this to be done, installed via the
> > generic page walking logic, also extended by a prior commit for this
> > purpose.
> >
> > These poison ranges are established with MADV_GUARD_POISON, and if the
> > range in which they are installed contain any existing mappings, they will
> > be zapped, i.e. free the range and unmap memory (thus mimicking the
> > behaviour of MADV_DONTNEED in this respect).
> >
> > Any existing poison entries will be left untouched. There is no nesting of
> > poisoned pages.
> >
> > Poisoned ranges are NOT cleared by MADV_DONTNEED, as this would be rather
> > unexpected behaviour, but are cleared on process teardown or unmapping of
> > memory ranges.
> >
> > Ranges can have the poison property removed by MADV_GUARD_UNPOISON -
> > 'remedying' the poisoning. The ranges over which this is applied, should
> > they contain non-poison entries, will be untouched, only poison entries
> > will be cleared.
> >
> > We permit this operation on anonymous memory only, and only VMAs which are
> > non-special, non-huge and not mlock()'d (if we permitted this we'd have to
> > drop locked pages which would be rather counterintuitive).
> >
> > Suggested-by: Vlastimil Babka <vbabka@suse.cz>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Suggested-by: David Hildenbrand <david@redhat.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> <snip>
>
> > +static long madvise_guard_poison(struct vm_area_struct *vma,
> > +				 struct vm_area_struct **prev,
> > +				 unsigned long start, unsigned long end)
> > +{
> > +	long err;
> > +
> > +	*prev = vma;
> > +	if (!is_valid_guard_vma(vma, /* allow_locked = */false))
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * If we install poison markers, then the range is no longer
> > +	 * empty from a page table perspective and therefore it's
> > +	 * appropriate to have an anon_vma.
> > +	 *
> > +	 * This ensures that on fork, we copy page tables correctly.
> > +	 */
> > +	err = anon_vma_prepare(vma);
> > +	if (err)
> > +		return err;
> > +
> > +	/*
> > +	 * Optimistically try to install the guard poison pages first. If any
> > +	 * non-guard pages are encountered, give up and zap the range before
> > +	 * trying again.
> > +	 */
>
> Should the page walker become powerful enough to handle this in one go? :)

I can tell you've not read previous threads...

I've addressed this in discussion with Jann - we'd have to do a full fat
huge comprehensive thing to do an in-place replace.

It'd either have to be fully duplicative of the multiple copies of the very
lengthily code to do this sort of thing right (some in mm/madvise.c itself)
or I'd have to go off and do a totally new pre-requisite series
centralising that in a way that people probably wouldn't accept... I'm not
sure the benefits outway the costs.

> But sure, if it's too big a task to teach it to zap ptes with all the tlb
> flushing etc (I assume it's something page walkers don't do today), it makes
> sense to do it this way.
> Or we could require userspace to zap first (MADV_DONTNEED), but that would
> unnecessarily mean extra syscalls for the use case of an allocator debug
> mode that wants to turn freed memory to guards to catch use after free.
> So this seems like a good compromise...

This is optimistic as the comment says, you very often won't need to do
this, so we do a little extra work in the case that you need to zap,
vs. the more likely case that you don't when you don't.

In the face of racing faults, which we can't reasonably prevent without
having to write _and_ VMA lock which is an egregious requirement, this
wouldn't really save us anythign anyway.

>
> > +	while (true) {
> > +		/* Returns < 0 on error, == 0 if success, > 0 if zap needed. */
> > +		err = walk_page_range_mm(vma->vm_mm, start, end,
> > +					 &guard_poison_walk_ops, NULL);
> > +		if (err <= 0)
> > +			return err;
> > +
> > +		/*
> > +		 * OK some of the range have non-guard pages mapped, zap
> > +		 * them. This leaves existing guard pages in place.
> > +		 */
> > +		zap_page_range_single(vma, start, end - start, NULL);
>
> ... however the potentially endless loop doesn't seem great. Could a
> malicious program keep refaulting the range (ignoring any segfaults if it
> loses a race) with one thread while failing to make progress here with
> another thread? Is that ok because it would only punish itself?

Sigh. Again, I don't think you've read the previous series have you? Or
even the changelog... I added this as Jann asked for it. Originally we'd
-EAGAIN if we got raced. See the discussion over in v1 for details.

I did it that way specifically to avoid such things, but Jann didn't appear
to think it was a problem.

>
> I mean if we have to retry the guards page installation more than once, it
> means the program *is* racing faults with installing guard ptes in the same
> range, right? So it would be right to segfault it. But I guess when we
> detect it here, we have no way to send the signal to the right thread and it
> would be too late? So unless we can do the PTE zap+install marker
> atomically, maybe there's no better way and this is acceptable as a
> malicious program can harm only itself?

Yup you'd only be hurting yourself. I went over this with Jann, who didn't
appear to have a problem with this approach from a security perspective, in
fact he explicitly asked me to do this :)

>
> Maybe it would be just simpler to install the marker via zap_details rather
> than the pagewalk?

Ah the inevitable 'please completely rework how you do everything' comment
I was expecting at some point :)

Obviously I've considered this (and a number of other approaches), it would
fundamentally change what zap is - right now if it can't traverse a page
table level that job done (it's job is to remove PTEs not create).

We'd instead have to completely rework the logic to be able to _install_
page tables and then carefully check we don't break anything and only do it
in the specific cases we need.

Or we could add a mode that says 'replace with a poison marker' rather than
zap, but that has potential TLB concerns, splits it across two operations
(installation and zapping), and then could you really be sure that there
isn't a really really badly timed race that would mean you'd have to loop
again?

Right now it's simple, elegant, small and we can only make ourselves
wait. I don't think this is a huge problem.

I think I'll need an actual security/DoS-based justification to change this.

>
> > +
> > +		if (fatal_signal_pending(current))
> > +			return -EINTR;
> > +		cond_resched();
> > +	}
> > +}
> > +
> > +static int guard_unpoison_pte_entry(pte_t *pte, unsigned long addr,
> > +				    unsigned long next, struct mm_walk *walk)
> > +{
> > +	pte_t ptent = ptep_get(pte);
> > +
> > +	if (is_guard_pte_marker(ptent)) {
> > +		/* Simply clear the PTE marker. */
> > +		pte_clear_not_present_full(walk->mm, addr, pte, false);
> > +		update_mmu_cache(walk->vma, addr, pte);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static const struct mm_walk_ops guard_unpoison_walk_ops = {
> > +	.pte_entry		= guard_unpoison_pte_entry,
> > +	.walk_lock		= PGWALK_RDLOCK,
> > +};
> > +
> > +static long madvise_guard_unpoison(struct vm_area_struct *vma,
> > +				   struct vm_area_struct **prev,
> > +				   unsigned long start, unsigned long end)
> > +{
> > +	*prev = vma;
> > +	/*
> > +	 * We're ok with unpoisoning mlock()'d ranges, as this is a
> > +	 * non-destructive action.
> > +	 */
> > +	if (!is_valid_guard_vma(vma, /* allow_locked = */true))
> > +		return -EINVAL;
> > +
> > +	return walk_page_range(vma->vm_mm, start, end,
> > +			       &guard_unpoison_walk_ops, NULL);
> > +}
> > +
> >  /*
> >   * Apply an madvise behavior to a region of a vma.  madvise_update_vma
> >   * will handle splitting a vm area into separate areas, each area with its own
> > @@ -1098,6 +1260,10 @@ static int madvise_vma_behavior(struct vm_area_struct *vma,
> >  		break;
> >  	case MADV_COLLAPSE:
> >  		return madvise_collapse(vma, prev, start, end);
> > +	case MADV_GUARD_POISON:
> > +		return madvise_guard_poison(vma, prev, start, end);
> > +	case MADV_GUARD_UNPOISON:
> > +		return madvise_guard_unpoison(vma, prev, start, end);
> >  	}
> >
> >  	anon_name = anon_vma_name(vma);
> > @@ -1197,6 +1363,8 @@ madvise_behavior_valid(int behavior)
> >  	case MADV_DODUMP:
> >  	case MADV_WIPEONFORK:
> >  	case MADV_KEEPONFORK:
> > +	case MADV_GUARD_POISON:
> > +	case MADV_GUARD_UNPOISON:
> >  #ifdef CONFIG_MEMORY_FAILURE
> >  	case MADV_SOFT_OFFLINE:
> >  	case MADV_HWPOISON:
> > diff --git a/mm/mprotect.c b/mm/mprotect.c
> > index 0c5d6d06107d..d0e3ebfadef8 100644
> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -236,7 +236,8 @@ static long change_pte_range(struct mmu_gather *tlb,
> >  			} else if (is_pte_marker_entry(entry)) {
> >  				/*
> >  				 * Ignore error swap entries unconditionally,
> > -				 * because any access should sigbus anyway.
> > +				 * because any access should sigbus/sigsegv
> > +				 * anyway.
> >  				 */
> >  				if (is_poisoned_swp_entry(entry))
> >  					continue;
> > diff --git a/mm/mseal.c b/mm/mseal.c
> > index ece977bd21e1..21bf5534bcf5 100644
> > --- a/mm/mseal.c
> > +++ b/mm/mseal.c
> > @@ -30,6 +30,7 @@ static bool is_madv_discard(int behavior)
> >  	case MADV_REMOVE:
> >  	case MADV_DONTFORK:
> >  	case MADV_WIPEONFORK:
> > +	case MADV_GUARD_POISON:
> >  		return true;
> >  	}
> >
>

