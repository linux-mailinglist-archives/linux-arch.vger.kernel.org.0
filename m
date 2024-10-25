Return-Path: <linux-arch+bounces-8584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 274329B1218
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 23:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E07C52830EA
	for <lists+linux-arch@lfdr.de>; Fri, 25 Oct 2024 21:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0CE20C31B;
	Fri, 25 Oct 2024 21:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RgBCdmV0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vVU7JNlu"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61B8217F57;
	Fri, 25 Oct 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729893558; cv=fail; b=kGgCnayNHPM15w0SdNZDHWffYtJu51DDS0UscOMB3KSofyM8L71ET4bT3PGHDefDre46JjDqv/9DIsKx7ub3C90iCXHMir/xaRGXGF+m8trfxaJYQLmSuzo61brumGkoqhjsfLISoYNnYjGP5zwZ/JqbegYBbplZcyiilaTbIC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729893558; c=relaxed/simple;
	bh=6u7L0z1qCEEKtEyOSCC6ZAnXgOmSXfLypwCsLg12W/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tAyV5uzfFQSr4rPruGIzlk1Rw6iJWbffQbD2InukFHMle1AKeo3pE2zAVxYF3yLISQ7fbIhcSoIUm65w3JhG+DwaKGRr4NmWgtxB77tvzWcl5qUKZuQzZcsaoRxvMi15wdENDkbBP3wmNZSDtNucVYUx7Hsm/6rClSq+LtKKdRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RgBCdmV0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vVU7JNlu; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdTCM004855;
	Fri, 25 Oct 2024 21:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=7npdWeOF1DUYzutvC4
	eMFd2G37/UAboOgmLiA1Uhx0s=; b=RgBCdmV0+XcvX6b/9n8tBrJx3GPbavURAk
	Nni6e1YH77mpq2oPHYwfBN3h8HmoKbCC+Jd3hIr99kBWC4khONqxSgF/YA3VkSu1
	Mz0NHf+1zdd60d/RZUdFnF8+NH97MH+76xLKomVifEtIYJbwALKf2dBHTMyjEBvY
	huzlYaZe2oVK7PFJbvc8SylRrGrb2Ji8UwETS8LoPL/BiXQAtcq6yrts2eljWWgP
	/LnBCUUnOXcwdyxqBy7j2/B/8mUOHWm1o6HDcxGVZ0Nkd2NiMnkrOlZZCVlU4kAs
	3TBl4IAkAAo82iRLkmkel4oorhBMIbpd0kNFoKk7VolXa6UO4Xxw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asp0v7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:58:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJjA81016441;
	Fri, 25 Oct 2024 21:58:37 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhedavu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 21:58:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dItL58KtXzSN/3dpq73vk+3sXdPqBRQ6UEQm4E/5WZu3TllVnNgAGHjPl7anl5/k0oJlglA5fAmujXi3a1UNr6LcnbUvKvNLEIpSZGY+uCjCTuxySkWwL54c+iynqoJX74ncx5ZHyZ71tweEe3ouULxBrRGtdSunZvcrgi5QseVQFH46pPSSBWyCaw9NuQFV9xmXpE9PWWJR92nAWr/yunhgwvfI/k8Sha8up+WsuRDfi7v2/P7+8/gPst1v3M8bv4DHR5dCf8G1Ai1NNBafNQZoONYbqUzobZmkM8mjHx8yTQQIGeen1RR4uCXnksxznppYWwKyoOIYwQ1nt4QG/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7npdWeOF1DUYzutvC4eMFd2G37/UAboOgmLiA1Uhx0s=;
 b=l5jMdu/HJqUZifDbYldNsIPEO+KYQzeKLhlQEsc2d2pChVZICnVITk1hsuUzNi27B0YVZ11uE19do+u6BiaXkagiC8h7UN1E2t1xI+N1CSRT2cHNmzMBsCasDqcuKU7SJkkzhjQ4qrjLgJmTyiFyVn3qsQXKRJRu76+rB1lpQmRkajVNLZGrLeeJjhLGkQT4/dMtQJYVYU6iRBAaXkU4RqFf10/wGSPduTSHR1mmCQ9qBYgrzu2CBTEv6kLbkWWjkCZoGSIwTdW1i54P1O30u+utDnvweqhyV5m+UaxAjOS5belVBL9IjlbTuYoH/SOYL46i6wph8RgznGFVPabDfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7npdWeOF1DUYzutvC4eMFd2G37/UAboOgmLiA1Uhx0s=;
 b=vVU7JNlud8mGE0WyJv5V20AA9MKbkvNt1c8D0QiIvxFW4SLKyzsgL/FU89LEjHkbuXBQ1+UhHrbSHurOxSj+7iMj0FNxUWHxKzxeaQZ/uRvQuwHnEEnlPdI0LxzHMwIzkWXwq7bI/ZJ+SzKFX3ZCNfZH+nayUJNbQxAPOY25ip0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB5687.namprd10.prod.outlook.com (2603:10b6:806:23f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Fri, 25 Oct
 2024 21:58:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 21:58:31 +0000
Date: Fri, 25 Oct 2024 22:58:28 +0100
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
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v3 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <046fe24f-6768-4b57-80bd-028514b0db51@lucifer.local>
References: <cover.1729699916.git.lorenzo.stoakes@oracle.com>
 <9be732fd0e897453116b433fe2f468ef7795602e.1729699916.git.lorenzo.stoakes@oracle.com>
 <8b1854b5-5c0a-43b1-aed7-aa4e8b8e8a1a@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8b1854b5-5c0a-43b1-aed7-aa4e8b8e8a1a@suse.cz>
X-ClientProxiedBy: LO4P123CA0358.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB5687:EE_
X-MS-Office365-Filtering-Correlation-Id: b80aa25e-0f35-452a-70d7-08dcf54029e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|10070799003|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/E3ees8SSxRviO7+Ori02R6NyBlTkk19kqmsUy3fUPj/YeCC++kFstWBWeTR?=
 =?us-ascii?Q?RluSAG2ALR29MWm7GOLKGGeXkM8nr2X2QrrTCGQIf6uj8zozCf941iXhK+3C?=
 =?us-ascii?Q?H6rI0YfLF95UWuV2ycwhlQ7w1gL/PfKkuhmYZPUXO8GCtmkF4y2ibUUSDVfF?=
 =?us-ascii?Q?e5dI6o6grFmunbCrDSkhgFGcpGD6wpQO1go64k3Oo6D2NgvX0R63V4SKV8Ik?=
 =?us-ascii?Q?bzEzHdJ17J1mJPYN8VNDXQcDp4M5WHvdQHfyA++I9ImkDy7sMFO8/FqbDDFk?=
 =?us-ascii?Q?tohPVYk0dsQHqrAHgVM8U+o9P1H8thsYzSiXV4Dd2rsZULh8eZvpzrgfECp2?=
 =?us-ascii?Q?WvWzFgt7G+nI7W0Q0uMcNTY0GIk+t62JjSA4cCfrloZDWrfCPkPcY6q6MUC5?=
 =?us-ascii?Q?hXWOrOT1FV3rjLxbJ4iPBQhw/Xpv3MsWqCZL11ibip/L+P7lDO9tbtRCzvVr?=
 =?us-ascii?Q?oFrIBawWCTB/sRBgUMOhnrctNiSXThJnVoYP2yW7q58PiuIuhmfsChpvTXC6?=
 =?us-ascii?Q?CbADKajoisYBrnpBKz8fgu7oLbdHIDTB9t8rIMwJzAGLm9WepalX27PyT4+O?=
 =?us-ascii?Q?mLN5UJLUSXhbOK8RbqpBHMTWcu43+r9+WiRcpLpH/5ZEvauOtU0CWQlCl0C+?=
 =?us-ascii?Q?p/bODjn7xetxX97irG8IH6wz4au7BIc/QSbhZW+Ztb2mvGTVGY6R9BEI3nXQ?=
 =?us-ascii?Q?GlvozjQL+1x9/GPLEnPiS8NyuWyihhu6HdEgjcxNwjMTuA5O0HwDwTAsCBef?=
 =?us-ascii?Q?kX5G3EWH2+Xyq8iet0KrfG/AMUuiTQuJ1DFU7NO5Ynnm+tWzVwsIIq0YSaJA?=
 =?us-ascii?Q?4Uqh4Rn3sfjnmgB0X0XRCMOn/ijUochQ7h5LNhkVMjffqZkQIS/Sk5kNotBi?=
 =?us-ascii?Q?c8y43w4cyjpUctEF7bNmoUyNK47PUVE/Jk1KlNiQV/IedyZxixsrpq0frsxH?=
 =?us-ascii?Q?Sr66tqaHK1S+36ieu0NhT62dIooOBHu81qoEHibXHDASilJwXkSKlASBTJtw?=
 =?us-ascii?Q?kAZLJ7MY9ltWVjA4K1WBKj1Q6+DOmyZqNwhYgd910xJpi8RKFL5ie3Kp45Ky?=
 =?us-ascii?Q?J6qB884ky2CHWG7Dw1DjCjenUaB8GAqhd8u/G6sHQOzBgPaMxW4dfgCzEQY2?=
 =?us-ascii?Q?VusuwcjnSMQO7YP47pTDZaTYZOPIYSHlfO+DqQEbTuEL1GSDEfcAwzkxxeua?=
 =?us-ascii?Q?tP6AwXaQf5BPZT4hn9l56W683ZVP5EMMtOinynqBuGo2OEookjI2uDk7y9hE?=
 =?us-ascii?Q?o+L9g0L7NCi1tv28IHrwCYJf9BFZMHmYXCgwRdWgvb/WQqReF+WyqdvcLYAQ?=
 =?us-ascii?Q?d+6yFwvInROt2WuOU77DHI6G?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vJJFyJA7BasyWy9BCQPLLd5W2lIuV7Idf10hioxg17xWz259UgvKtti8u6MH?=
 =?us-ascii?Q?xAoEzYT1TlSselCnFNXnuvud8ENWzxf1/YqoieXV1RyAdBlA3EXd/WPtY6ni?=
 =?us-ascii?Q?G3zksNf+gJ8/r5j5u2GhY1yfiL8QAHZnWBwDPDCwdb97zCZVZGyqNZxnzGnQ?=
 =?us-ascii?Q?xK9hakZAog2CCE0XF/kWDQGxq5wepNViS9lT+3/QlX22jrIGi9z8gGkVGrB/?=
 =?us-ascii?Q?Q5yQZv9Q4poWNE46QtESa0iA2EaMPh3tCtBHx+d+q+E9N9fnLbikJaTV3P72?=
 =?us-ascii?Q?+bjWyqc8gSeNqppj4P/up3lkLsIExtJlVE3LljiJ3YT30pu1Io3L3gubtEjy?=
 =?us-ascii?Q?xxkLsC3zuvCJMPrhwoGLoRZDRulrX/oUdpDHHl95VRKWuVtXcxh7ZFyWdCme?=
 =?us-ascii?Q?vticDKYWLOIfH38yYMnpana5IFkrWBnQHnPatKQ3ApPEIcPbbWa8bqPkMPh1?=
 =?us-ascii?Q?Xt73fGYJypwuJPVujrERCQ3HpgQ0i/qCXBbMQ2Oow7ERhAE9Fh6Dnk6g1S1t?=
 =?us-ascii?Q?fdxf0ztmjI//eL6Xa1XLqHeXnMHZwJva4DdWgwNdZm2RN4Piw0gN4Crkg5qq?=
 =?us-ascii?Q?Us3W1OezzdLJJBJfFTOuC7dR9N/aGK8/LbH0krNkO8xJEsbnfOLH4IWzOCBC?=
 =?us-ascii?Q?Zv7OTyfonDgwhXpnfbMrXAdnn25PsU3DvUjCToHs+YpoTgNubiq+K1FEwoNb?=
 =?us-ascii?Q?/4Wqqm51WxpBsqnPWxMhPYvnjuJOUht5dRpwIFZf/tKd1MUUae33w5StEPgJ?=
 =?us-ascii?Q?oA9rEFAb114jkY1cd1sY9Maj+yZ1bV317LRfIGrb54TyngwrHVAW34yKXrqr?=
 =?us-ascii?Q?zVNki51pHNYGKhPwKiQk3LBXASP+CPq5O16/GIq0cFF8wyX6j1fFwGsMihBQ?=
 =?us-ascii?Q?FY1TNdKBhwfzxNroXXTkHqoTa74kTftIkbQ4mMwr7Kk10w/og2F4xjmHhonI?=
 =?us-ascii?Q?VmVucbY/ayOKg0q0t4Ilx43HeSoNrwe2FmaWDUItEm/rUhWRmBF/30NxyAxe?=
 =?us-ascii?Q?g/WBTVKhGKInv0miGiVdQ4meqbSW6cgFWx0PIBkt3cbBJd4i1lKxXgsMPNND?=
 =?us-ascii?Q?JouiA5bMPdFSaFuLxjYxmszP5ycBU+m+D7pcvYfDQGVPK9iOb6qdRDT6BPsJ?=
 =?us-ascii?Q?Rd5GbSTx7ffTpfNO+UQB2xLK0W9fnn8/CbRADuJvzv0APIQp17Kf5LQ7WBUB?=
 =?us-ascii?Q?3Db6JbPvT5qbIddGjhSdDA8P8gaE8v1zRUggZt5/2K2dhEgMBISpn5eN/dEo?=
 =?us-ascii?Q?8+S3JTjtdXM5kBst3igu2LYKsMRbmyfHvkzWXvqeKeNLfAs1ZfUhXObZj3UX?=
 =?us-ascii?Q?pna/WLcOtLDfoTwY+w1eEY/Os8c2BJa6ogSq8rMNXDcibF+JRcTVcg4YRNbK?=
 =?us-ascii?Q?tb0Xzd1eZOy2FQKFXh81T9hjt3IRAXUl7gFZYA53QHWdgosyBOBflMzrQzVI?=
 =?us-ascii?Q?e38rvrmEHcGYGbUujlP7271szXrlYGOedFTjADq4cGeN1667JdBVE51A/kSZ?=
 =?us-ascii?Q?Zcs/9erUskdyD20Akn3Hi71A/3gioyYgbw+W0zYTd1babkkXYKoRmt19USAV?=
 =?us-ascii?Q?syOvmgaxgIVx0RLkcnympg2NmJVBRwGdHZ5gZcVx2dvbMFxfkH+A5iLoDe7l?=
 =?us-ascii?Q?9JLT7TH6yv8X4A3B0V9FlNo4AFdE2rqkv2gjWgtZzAYLMRIoRN/cyQ1F2cIh?=
 =?us-ascii?Q?jAPWog=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RqzVouw9tGNLrC7IbSIZGTS+NepnH7JaKI94mjXBbRHozisuRPlZjjoAB0Gh41qFqRF60RJGgIdI7zlJAoD3BgRXPEoS+wxeHUwiVNxBKD6kQRswpz1GptQyyNiolFx/x7A1XLdrIFfi8YgaU6pXYc5AnUZqppdSMJkVTuVgrHZJTp0noRDXyjAPaFpg2h1YtN+x1o6et1WumefsET+tR3qxHXpNzbxHr0KAUWBCirUJWNWUcm0iA7f4ZJK/au9CUfTdJ+99ijDDquEhwY0OGMwUi3+sqGJ1Jb9ogWL+96BENwGgRr8nxyzSq61TGRJ8t9w+YFpFu3h2a7gE/YaQxbAC8wyyH5f9K4B18IEuT6R1883kQ6RApw00Hc4WYqXmIm8VAwkQqPSwn+vDAO/rCEgQyWYzh3WHRUKQhgKnoi91PI8UC/JMVBkvt+59aE2jkmStil87k+jLJ0Q+xq1UT9WsN2qqKvOu89XryncUXCNrrY7yTxYihpxaK4MFt2etLsQQsaN749Z6+kdT0393LmSLQDp1j1BgO32+QDIf34sdjX4JOpQ5YPt05qfWTnBluiMZ2Fv9Q/v7VaNCXrQ6VkSYCPab/6xLc4BTRmvy0Gs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b80aa25e-0f35-452a-70d7-08dcf54029e4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 21:58:31.2176
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tv6hbxuq6pw3AO6lCOIqQSTfhb7A4lvfoxwUNwDI+e7UWwbQRikFjVdXJ9PHsrRH+573RAwuEE1OyPl8cJ1xEozUq5lTDMar+wycRPYkBtU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5687
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 phishscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250170
X-Proofpoint-GUID: jL-Zq0Ntj63Omg4yom9jh0Mj_tO4TnKt
X-Proofpoint-ORIG-GUID: jL-Zq0Ntj63Omg4yom9jh0Mj_tO4TnKt

On Fri, Oct 25, 2024 at 08:13:26PM +0200, Vlastimil Babka wrote:
> On 10/23/24 18:24, Lorenzo Stoakes wrote:
> > The existing generic pagewalk logic permits the walking of page tables,
> > invoking callbacks at individual page table levels via user-provided
> > mm_walk_ops callbacks.
> >
> > This is useful for traversing existing page table entries, but precludes
> > the ability to establish new ones.
> >
> > Existing mechanism for performing a walk which also installs page table
> > entries if necessary are heavily duplicated throughout the kernel, each
> > with semantic differences from one another and largely unavailable for use
> > elsewhere.
> >
> > Rather than add yet another implementation, we extend the generic pagewalk
> > logic to enable the installation of page table entries by adding a new
> > install_pte() callback in mm_walk_ops. If this is specified, then upon
> > encountering a missing page table entry, we allocate and install a new one
> > and continue the traversal.
> >
> > If a THP huge page is encountered at either the PMD or PUD level we split
> > it only if there are ops->pte_entry() (or ops->pmd_entry at PUD level),
> > otherwise if there is only an ops->install_pte(), we avoid the unnecessary
> > split.
> >
> > We do not support hugetlb at this stage.
> >
> > If this function returns an error, or an allocation fails during the
> > operation, we abort the operation altogether. It is up to the caller to
> > deal appropriately with partially populated page table ranges.
> >
> > If install_pte() is defined, the semantics of pte_entry() change - this
> > callback is then only invoked if the entry already exists. This is a useful
> > property, as it allows a caller to handle existing PTEs while installing
> > new ones where necessary in the specified range.
> >
> > If install_pte() is not defined, then there is no functional difference to
> > this patch, so all existing logic will work precisely as it did before.
> >
> > As we only permit the installation of PTEs where a mapping does not already
> > exist there is no need for TLB management, however we do invoke
> > update_mmu_cache() for architectures which require manual maintenance of
> > mappings for other CPUs.
> >
> > We explicitly do not allow the existing page walk API to expose this
> > feature as it is dangerous and intended for internal mm use only. Therefore
> > we provide a new walk_page_range_mm() function exposed only to
> > mm/internal.h.
> >
> > Reviewed-by: Jann Horn <jannh@google.com>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Just a small subjective suggestion in case you agree and there's a respin or
> followups:
>
> > @@ -109,18 +131,19 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >
> >  		if (walk->action == ACTION_AGAIN)
> >  			goto again;
> > -
> > -		/*
> > -		 * Check this here so we only break down trans_huge
> > -		 * pages when we _need_ to
> > -		 */
> > -		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
> > -		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pte_entry))
> > +		if (walk->action == ACTION_CONTINUE)
> >  			continue;
> > +		if (!ops->install_pte && !ops->pte_entry)
> > +			continue; /* Nothing to do. */
> > +		if (!ops->pte_entry && ops->install_pte &&
> > +		    pmd_present(*pmd) &&
> > +		    (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
> > +			continue; /* Avoid unnecessary split. */
>
> Much better now, thanks, but maybe the last 2 parts could be:
>
> if (!ops->pte_entry) {
> 	if (!ops->install_pte)
> 		continue; /* Nothing to do. */
> 	else if (pmd_present(*pmd)
> 		 && (pmd_trans_huge(*pmd) || pmd_devmap(*pmd)))
> 		continue; /* Avoid unnecessary split. */
> }

I quite liked separating out the 'nothing to do' vs. the 'unnecessary split'
cases, but I agree it makes it harder to see that the 2nd case is an 'install
pte ONLY' case.

Yeah so I think your version is better, but maybe we can find a way to be more
expressive somehow... if we could declare vars mid-way thhrough it'd be easier
:P

Will improve on respin if it comes up

>
> Or at least put !ops->pte_entry first in both conditions?

Ack yeah that'd be better!

>
> >  		if (walk->vma)
> >  			split_huge_pmd(walk->vma, pmd, addr);
> > +		else if (pmd_leaf(*pmd) || !pmd_present(*pmd))
> > +			continue; /* Nothing to do. */
> >
> >  		err = walk_pte_range(pmd, addr, next, walk);
> >  		if (err)
> > @@ -148,11 +171,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >   again:
> >  		next = pud_addr_end(addr, end);
> >  		if (pud_none(*pud)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __pmd_alloc(walk->mm, pud, addr);
> > +			else if (ops->pte_hole)
> >  				err = ops->pte_hole(addr, next, depth, walk);
> >  			if (err)
> >  				break;
> > -			continue;
> > +			if (!ops->install_pte)
> > +				continue;
> >  		}
> >
> >  		walk->action = ACTION_SUBTREE;
> > @@ -164,14 +190,20 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >
> >  		if (walk->action == ACTION_AGAIN)
> >  			goto again;
> > -
> > -		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
> > -		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pmd_entry || ops->pte_entry))
> > +		if (walk->action == ACTION_CONTINUE)
> >  			continue;
> > +		if (!ops->install_pte && !ops->pte_entry && !ops->pmd_entry)
> > +			continue;  /* Nothing to do. */
> > +		if (!ops->pmd_entry && !ops->pte_entry && ops->install_pte &&
> > +		    pud_present(*pud) &&
> > +		    (pud_trans_huge(*pud) || pud_devmap(*pud)))
> > +			continue; /* Avoid unnecessary split. */
>
> Ditto.

Ack!

>
> Thanks!
>

Cheers!

