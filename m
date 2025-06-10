Return-Path: <linux-arch+bounces-12314-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 93339AD3CC7
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 17:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35898189EA66
	for <lists+linux-arch@lfdr.de>; Tue, 10 Jun 2025 15:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C9E2238C2D;
	Tue, 10 Jun 2025 15:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LXJ7BUlV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="X9lSz3Gf"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68B71D90C8;
	Tue, 10 Jun 2025 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568685; cv=fail; b=BxEkvPKEjjJDwV349XSpVGYfh8KAd6uPxJeKiXKVCTIsAVRmAWX60SvCp0h6uA1ulkUenN4VDce5EiyvDVd8vL/1Qpi+PsUyYw0ZbMKZ75FhSzvvJeOlI0/orRWwbTBi/lV6LCh6erWveJ0A8KfuEtC0P0ZYGuATdLv4Is0eh5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568685; c=relaxed/simple;
	bh=1RjTqebKKx4scLIqvhttyAlBOPmhlRIsM6/7kOhjrUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eTPsyjQj5E8OtPKr1WPWS+JDNHNAjTHGSKPuXEdPeyJ8ZSvKv9CtS75iU0Jm8ft4V/Hd6sKNJ20wjjZuV5K0iqhKIO3NswC7Chr3lyNdfE6AtddByb5gZnZOmdVDSp7mAOhoXTMoH4WSK0KQsVQ2Y9+m0IZZb5nezuuM/Vki6lA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LXJ7BUlV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=X9lSz3Gf; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55AEXeSF029113;
	Tue, 10 Jun 2025 15:17:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=1RjTqebKKx4scLIqvh
	ttyAlBOPmhlRIsM6/7kOhjrUE=; b=LXJ7BUlVqhJlBW6p0ft15hxV1V5NraCDeM
	l2faSJH62ytuiUjqn1G7Foo7y6QZDG6QrnqWdV9p//sGYxpLVcRbPOcxC7843214
	NXl8pOOMnB6HG0q6bFWwvVVg6QoVf9FhPq+Lfogq1/lKewR/nT5ek9wTAU4a5pyc
	+B6+bEx8+DkVeVlnvQHJxZYQIdLmyqgQUWYaqmt5dZ/kG6uwt5LCcZOSdN996pmq
	97Wnq58NeJYz0c1LHVZYrhMYth8VFqobTLdWgH4Q9sfC7JCMU841sDOEcT5ywy0s
	tVSY1F9UybMOARq9TZD53qSmk5mnXpkKyV/edOtRWNz1TSVWtgOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474d1v4gxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:17:39 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55ADf73W007539;
	Tue, 10 Jun 2025 15:17:38 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv8maq9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 10 Jun 2025 15:17:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NO1xWBsHcjv54bjxxCaUOEkukSRuaSydu7dHCI3ZXHVFNrG1W4lJ6S58lXA8+G8UIQ1xrAVRc/zAkXqTSsRGinXdu0ymMdmNPd9nTCuEOsHVkhV/3R+xH0O38ECvPdlEiedl7rpDrWAgiHFhPXL4hB2QhC0ATjVHNbGIX9I/kO63HfM79CUFoqkRysEzdeD2Ktsgw31vNZARUHQruGd3+5OhsFpLxvmVlITC5TSkJWOOC9JHQwfiufBR3qw2ubMLRxosyxop5RKER1iUUZ1KQHUrYRZbVcqG7ecd1uHwDdAx57x9ExeQy2jLJbCFFnV4OJuYvXVuhILP8Khp/aPvrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1RjTqebKKx4scLIqvhttyAlBOPmhlRIsM6/7kOhjrUE=;
 b=GuwqKbpaRZEVHtYZQ74FbxefAhmr5wesvgQLRkYUC3qjY0g65FcsHvWCzALq+V3pYVESVOhsPdJIZOyFZNhrCO9sh0/ONoJgzanjlY0EUuUeYRMV/xajr3eVLlDFDMO5NNeYi1h5/gXRQF/ceQPSOXcuE3cD5M+nWWUP1eL8gn9Tbcb9heCgux5hxcKB6fDYFUE5kB4oC0tKRoqWF4ucjRYlmcLjGqWRLucnvDm+2UIJ43/pFl3RTmziZsg4o5xgjvBV8G9Jf4cLGO2koyzKhu0MYfAcLhbCCrnRS2DbSGzY1NomMTZPkVEbY538rlRnY8NczgrlcGoEYcbVcn6K2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1RjTqebKKx4scLIqvhttyAlBOPmhlRIsM6/7kOhjrUE=;
 b=X9lSz3GfQ2zFpYZPttZGjljvtJYdqBlyWjFgfZiVykLSdtSJhikxCWRkchRTG9kgETnfr3mOyAaGGtwaVgxS6vMZVM1uPuHahcDiRhA+TZlbHkM4vB8ibr7ZWtwfdWGmgeibgb/m4MGD4uIsa0xqGlbUCdkEk+v30inXXx6eKU4=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BL4PR10MB8231.namprd10.prod.outlook.com (2603:10b6:208:4e6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:17:36 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8813.024; Tue, 10 Jun 2025
 15:17:36 +0000
Date: Tue, 10 Jun 2025 16:17:33 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, SeongJae Park <sj@kernel.org>,
        Mike Rapoport <rppt@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
        Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, Pedro Falcato <pfalcato@suse.de>
Subject: Re: [DISCUSSION] proposed mctl() API
Message-ID: <fcaa7ce6-3f03-4e3d-aa9f-1b1b53ed88f5@lucifer.local>
References: <85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local>
 <e166592f-aeb3-4573-bb73-270a2eb90be3@gmail.com>
 <d7ccb47b-7124-45e9-ace0-b0fa49f881ef@lucifer.local>
 <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8db6b39-f11a-4378-8976-4169f4674e85@gmail.com>
X-ClientProxiedBy: LNXP265CA0090.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::30) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BL4PR10MB8231:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b300aa0-b387-4154-66f1-08dda831ee53
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WMyMKC7OizxFBQ77lGWdqg3gvPc7V8daeFCtQZxCKs/OvpBkZRtImICi4hVF?=
 =?us-ascii?Q?apiXS2uwIAkoTPN1gSeRLtQD/EnyNrXClLKH4/iEakiravyZqnHk/JH+Zk1O?=
 =?us-ascii?Q?ueD9zhMAnLXvq/Vyj0IaHqeK0FQQ9fqiXJLlbpjF5OAdzWW/FZyD8HNKVuqM?=
 =?us-ascii?Q?1mYVFSOuYM7Hl5/zFAWhbiGF2QB6wga5T9OEJcXymEobaeCcaUL9KXSUf1p6?=
 =?us-ascii?Q?G3wtCYgCxq3STi1tim2z0OGrVGnYJMRLVuYTTWAyObJuRJWNCL7AO19x51O3?=
 =?us-ascii?Q?YaA2+U46GNhRpTxB2pYLr2/GtE1s/PwuJnuoZHD0TGpu4nZJ017AmEoht/Yo?=
 =?us-ascii?Q?aL4SEmX81tVawiPZgJWPSqaH95DFXyxmcmS83I1lkgCD98LHKi6IAnzxGY7Q?=
 =?us-ascii?Q?G/W9ZnWR7fdoJPTELEu56OA8O9QqBeNorkQ9L9IAobkeWiiHNk0eEF5HTX4I?=
 =?us-ascii?Q?ikhKw5wdPcWJal6IvycmxbuO4Ov75NtUXvpRRwKuRbR5QBI5QUbb7WUCTEMP?=
 =?us-ascii?Q?ZcuQH3obAVrjYfCPj946pdapm27YXLjbiWXkT5fdZIgev/aEYZfrldLijsVF?=
 =?us-ascii?Q?lGP10T7qpRZoRcwemHQJQpQT3XSPo7iKk8mjYa5/pxc7oI1lN6BtHefAQa91?=
 =?us-ascii?Q?4SHmF5Xpo+f0yrJhny7GIeaStWq8DA5tV34CfEzYK8hG1PI5881xtah+1SKt?=
 =?us-ascii?Q?/dllNERyy85uJ5lznzT2pLozb0hjmm+iq51xdz6CwDBT+PjB9EgTtd470yr+?=
 =?us-ascii?Q?o5ILnrSqdISHYmk3fw+3iaIJyzXA4fnmws0TRGCPvJaLGAP++X2qkfaPIiRy?=
 =?us-ascii?Q?UjvhjmMMTd0mNGQQ3h2gt1Mgb9jhPHxS5OfaX9YkFbpT6wvc+AiZ9Mx1uLm8?=
 =?us-ascii?Q?OHQ5DAKY6BUpLG+FrAtxRJEjP2zKN7sbbiGf41CSoECtsN4co6w+m/l6OsBk?=
 =?us-ascii?Q?769TtE+9ZAfwTzoR3b/yphIGaxJzaujhj0c6gumV5M127rhNKeQoTTwHA0hc?=
 =?us-ascii?Q?Kp2hKWVGx8XQJnJscKFlkJvuQFmXhG2+sgK560XTf1+VESw0/OSWDq3pkqZv?=
 =?us-ascii?Q?XHtlzXEvXGcv/bhjDKHxYW4E51i2XTwsXP66kyncuxHiBvqbIE8QG8032Vh7?=
 =?us-ascii?Q?H9+/42zzY2mxepmSK3gHnhnPWmecb8BExCQSnIMcxih+XmBRtGUbVR+A7o2D?=
 =?us-ascii?Q?28BwdtH12BX5vWfRC8oN2WdWv77gzy2JV3PuEWQ39HuXtLefFNDyHXvQ4HFc?=
 =?us-ascii?Q?l0QKPBfZhEk5C0WBtNENO8EbIFAdpwNBpINYyzIYnbuziczY56WLSPCvzIu5?=
 =?us-ascii?Q?8ySPiUI96hvl+qXYqL8ZcZk8jlmbxVQ60/9+FHCJ0a+ax5On5VyUrSsTexqo?=
 =?us-ascii?Q?Y4gP47Nk5BiF/D5IyAeJLf1kqglZO49yaSR4gZhpkDvdl3YJCnp6eqV22PA/?=
 =?us-ascii?Q?ghlg9Y4WS6Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t7QRI+MczXPl5Yx2tKRlSQ8zw75NbwRf8ujvxeP2VmezAEFXs0Clh5K4HlLm?=
 =?us-ascii?Q?cojYexWbWv6iQpVxlZPm3fMhm2q38EDFFT+lLQuRU8tg0nzJjNNgsM7NkigP?=
 =?us-ascii?Q?djzL8G0+FlyB8n1W0TM8FoSC+zlhQGSBBKBnSkHBP1k3TiihyADejv1glCpq?=
 =?us-ascii?Q?xS0bJp4BxP8mXmGOAV/gOrfayNAE8iiPsY2PHH6nhBIZFWag16zPpAdfMEuG?=
 =?us-ascii?Q?kGkZLjPR+JRlsHfaUTYYr5jRoMh2OI8VaAoYoWpCtT+SaxG2So4D8c8lNE4q?=
 =?us-ascii?Q?fhiJAxnAVtx+7sUbyjn1ONP/7WHAXfKhTzTyhX5hBEeosRtvriUujFxHUjDE?=
 =?us-ascii?Q?JlEgJ7MNfnPlJe+qLWon2E3OnUay3C+a7xRIi2JjYoGIFhO7SLVFSUZxzMvW?=
 =?us-ascii?Q?JRyKJkTAIdSNBchUFU/w/p1jQMICnjvLZwayeKvZDRUVTXwndeB5aTKNe5Ku?=
 =?us-ascii?Q?ygVeexcKZKiq183uztON7vewAv5zqB/O7J/FRUIE/4b4zLPdrh+iWAvSVoHb?=
 =?us-ascii?Q?wgvpYaJmINUOhVy+zGNmqA25/JALhvxSGVp/QhZRexc0BUyruTwKsYH+5aDG?=
 =?us-ascii?Q?IIXh+B7UQPBlZeQRN+x6ZSJ9GjMeVdKneicJ2xHT2zt6MrD1r720/IqLQTDj?=
 =?us-ascii?Q?sqoQztfGoaT84mrunfqCXD934hfWJvi/A+dcId0ULg4C2qPKYB5veJERmqfE?=
 =?us-ascii?Q?FOSfUAyYhBCcuiZK6EIBon/409Nj72nKv9PVaP7lC6cMwxwV3d2oiEM9ys0Y?=
 =?us-ascii?Q?Xl9MGAn1qHlisMLhTpJ1S27ie4fY/k12ZKbg+bm8T8lOOKkTC5UIXewhRXjX?=
 =?us-ascii?Q?b64pfIVBzTQTGmtWcv7NDkm3L2PA9Sgyz2t+HvjtR/S8rEuTtqolYtgXX4M5?=
 =?us-ascii?Q?FONAIQ/xBSdJ3M6sgICoUGh8Zl+UV6WM/EnYMf1wXAHTN1xooCTaF50WLMwu?=
 =?us-ascii?Q?8zd9jfq8m1G2EqLKCTBlNA5qejw6GRqfCxyeMRtNTlp2dmPz30XrRxdJsjdL?=
 =?us-ascii?Q?F8AO+OVRgGgcNvpGo1lAiGSgP0lGnH3OTf5of6hDjZeLh+N8RNbmMELEp8t/?=
 =?us-ascii?Q?zbEAxXpy70sm+PTTOuTQDGTNH6/3Df5VZadCvlJE8hrh30u3rSREByMZgN2A?=
 =?us-ascii?Q?fp1Ji5EPsgqifIVW7lvt+GfmHa37ptg2jHvyMb6uH1gCswGp5xATaSfdET8j?=
 =?us-ascii?Q?Raiiv2MYUcyG7+9vUwDbjatEdbrK5aMKk5RvijwaM8BWdP6saN2OWxABr1ux?=
 =?us-ascii?Q?qgrXIiQ1n6dFas5owOZuhj4zgCAhQTorBxR7DXyMvfXWNhxW1D4LEvCbibF1?=
 =?us-ascii?Q?/5BcdJ7OwUa1Vc/4kRJijbByRD5TVoFkEaAS27DMLImv1a9WJe9SU7HrmIm+?=
 =?us-ascii?Q?KEjBxzeuCDHjtasuW526/w/z+qL60m8nMkLj9f/E6VETUj4D5vDavHu2hCWL?=
 =?us-ascii?Q?TvzFyeEkPlY8OLws7zJ/ne/FAMssdp+/m1/TIj+TzHotutRx07tBSYr/ZXp3?=
 =?us-ascii?Q?wTI4LagpAqQ1IrBHHDjvarEYB4MMs9PZDWV22nJODC38SjFk1ubSyFd65cZ3?=
 =?us-ascii?Q?kbBdrDuCd/qQJ7tBH5j6a0gd/sbtgvOl7sIGjyvE3pfBgRwrFUiKpWSSc/Cj?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6mEZH14B/kXdBe5/Jt+1PZkEaXCeFlZVCt6+rWHvXjoAUVCRHUB50aSPa1xqShBxN5kcPfT3x5WIt//LvPxKDhUMa4AZdLlc74vFjnBGm87pUc3fYyH5a2Za0ePDT64O4ihjqXCj4ODdoaTi77RP0hVzoeiS+LTSAck1joHGBQt3ZXRo09prQNdqB5h9hsWStkizod1w724vwo/I0tyrxyFfvGAelyfMF9NjIDRQJp0sQAIH96tJPjLn+MCVKUJVfjQIF+RAXUdtdKN+l/qe/LX6uMweFlRdZ64wKILBbxV7EbE5RJKAPpUhSGtZR5Av0SVDd4KcvMVt0WN8SUitKDJ/13mQGH6ukih232ah23EDpY03TBzQLAGQ4WAvgCMwx51FgPiFQ45fuEypDDaA0qAdwjsefAFWY7rU09Y4PLKLoBxbtdKfbRJYLJXra3YOx3Spcmug5XOKEcLIuq4ARqwpGpu7YadnMdMK7MQkQOVVb6M1bub7BECA5zJCv2W1dZbKuPqN0ND5ADUI4zOjpZ2aMT7ZeD/MJBY8i0ORyjwVF5BTvjR5FSVhii5IPQ00Nzh+rLnnN1abdhpJBJadQbood9+KmV+MMy3kLruVmC8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b300aa0-b387-4154-66f1-08dda831ee53
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:17:36.2739
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VIHQqSurznSAT42qU4kEjWTCvDlhPhaM02AcyM/DbSq6lg27mUUlt4UvLpw8nGkDp54lG/Ta+ndnP8aYOANVCrh4t5sNAcNQtXiua3gcf1o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR10MB8231
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506100122
X-Proofpoint-GUID: WWqXizaySfZG0u8yF7LlJAOpexlV-5av
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEwMDEyMiBTYWx0ZWRfX/M7bsk4XJDi+ 8c4RnyYvhgix3SUjOV4wXXQFVajziNKDujsi9nfIV3lUb0a5lkvHbRNfkDx1IU10nsIIAaTvdyW Jg0hv2HeL2Xe/G3chLfEQ1C9HVNaeyxct+253J5cztYzozltIhO3tHt1WIoIfDod0xcbFqsaOhU
 50gSTfR8RTMKu47dXjvlGgrLTKGOhbN9J1cKfW4oQp5n7An2zgohvQgQ4jEZUVpp3wR9Yb7a83H IyT0F5sEZwWTZnln0fjGzpjIw6x4OzltOPNzGiBshIrhcbsQGkddf8Mvk3rWHaYHqWQZcxWsi20 HmzEbRo7aJsFcpMauyxkhoAYnnV6VXFNKXPsdkCoEvFPc7an4XMdOv8xgyEIqH2Cnt51ZyK28QR
 R1OCpQf3cU3BuRCjyL548otWAHXsfXgwNmVN65/4MfqiSA0ZGb8jyFDiIxnYeN/U+DhF9Hbn
X-Proofpoint-ORIG-GUID: WWqXizaySfZG0u8yF7LlJAOpexlV-5av
X-Authority-Analysis: v=2.4 cv=d731yQjE c=1 sm=1 tr=0 ts=68484c93 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=eKjrHVYcWXu7wmRAu4UA:9 a=CjuIK1q_8ugA:10

On Tue, Jun 10, 2025 at 04:03:07PM +0100, Usama Arif wrote:
>
>
> On 30/05/2025 14:10, Lorenzo Stoakes wrote:
> > On Thu, May 29, 2025 at 06:21:55PM +0100, Usama Arif wrote:
> >>
> >>
> >> My knowledge is security is limited, so please bare with me, but I actually
> >> didn't understand the security issue and the need for CAP_SYS_ADMIN for
> >> doing VM_(NO)HUGEPAGE.
> >>
> >> A process can already madvise its own VMAs, and this is just doing that
> >> for the entire process. And VM_INIT_DEF_MASK is already set to VM_NOHUGEPAGE
> >> so it will be inherited by the parent. Just adding VM_HUGEPAGE shouldnt be
> >> a issue? Inheriting MMF_VM_HUGEPAGE will mean that khugepaged would enter
> >> for that process as well, which again doesnt seem like a security issue
> >> to me.
> >
> > W.R.T. the current process, the Issue is one Jann raised, in relation to
> > propagation of behaviour to privileged (e.g. setuid) processes.
> >
>
> But what is the actual security issue of having hugepages (or not having them) when
> the process is running with setuid?

Speak to Jann about this. Security isn't my area. He gave feedback on this,
which is why I raised it, if you search through previous threads you can find
it.

>
> I know the cgroup proposal has been shot down, but lets imagine if this was a cgroup
> setting, similar to the other memory controls we have, for e.g. memory.swap.{max,high,peak}.
>
> We can chown the cgroup so that the property is set by unprivileged process.
>
> Having the process swap with setuid when the unprivileged process has swap disabled
> in the cgroup is not the right behaviour. What currently happens is that the process
> after obtaining the higher privilege level doesn't swap as well.
>
> Similarly for hugepages, if it was a cgroup level setting, having the process give
> hugepages always with setuid when the unprivileged user had it disabled it or vice versa
> would not be the right behaviour.
>
> Another example is PR_SET_MEMORY_MERGE, setuid does not change how it works as far as
> I can tell.
>
> So madlibs I dont see what the security issue is and why we would need to elevate privileges
> to do this.
>
> > W.R.T. remote processes, obviously we want to make sure we are permitted to do
> > so.
> >
>
> I know that this needs to be future proof. But I don't actually know of a real world
> usecase where we want to do any of these things for remote processes.
> Whether its the existing per process changes like PR_SET_MEMORY_MERGE for KSM and
> PR_SET_THP_DISABLE for THP or the newer proposals of PR_DEFAULT_MADV_(NO)HUGEPAGE
> or Barrys proposal.
> All of them are for the process itself (and its children by fork+exec) and not for
> remote processes. As we try to make our changes usecase driven, I think we should
> not add support for remote processes (which is another reason why I think this might
> sit better in prctl).

I'm extremely confused as to why you think this propoal is predicated upon
remote process manipulation? It was simply suggested as a possibility for
increased flexibility.

We can just remove this parameter no?

It is entirely orthogonal to the prctl() stuff.

Overall at this point I share Matthew's point of view on this - we shouldn't be
doing any of this upstream.

