Return-Path: <linux-arch+bounces-8348-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DDE9A6B08
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 15:51:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1753284825
	for <lists+linux-arch@lfdr.de>; Mon, 21 Oct 2024 13:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5E31F80AC;
	Mon, 21 Oct 2024 13:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6fjE2iE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FJdQ2VxG"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BD2E1E570F;
	Mon, 21 Oct 2024 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729518694; cv=fail; b=poIz4FDJKkXMxnx0Ew5qI3LzWNGqY5P0+puXrWB9PufVJwTCvj2k/TOzcsbcN6ekTQsdBi08LxxII7DwMjht7B9hkybLQTEVXgoQI0vfMd9LtqISkE6GWAghhmfzotZ0z9n9DGAgjRXQEC9VZWi/hVrmeE7gFQrBbm08TtEIg7o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729518694; c=relaxed/simple;
	bh=8/J8HUSmh00Vfs5NGkBxBWSv6u8iGkD58dIT7dzTud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=I5Nm8wYPsxIMCMGPQkjKpdEUxAdCnlq3Vsypvx1Y5y5LdveI3wMUb8I9ySUKVhhNJE0eX0jxuwWX1lYIFqjR5xABXevbNA7q3e0/L0YEwi6Uki17GVjFnrdtIfqJZtOlWMtG8cg/+I2I/TyGFdYOuYAN2f1S19Z5+wddRQ77gNY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6fjE2iE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FJdQ2VxG; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49L96djb029517;
	Mon, 21 Oct 2024 13:50:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=eRDEIxgveXUonqgf4G
	FoOYNVFA7uD4uRc4SYhGcdVAE=; b=f6fjE2iE/TR2kCPwpjDfsUz7Ilc7sJickt
	S0unugLIfdmOe7btu5dcLT9LgdCt07auSsb0gdB64ui8iHFlsf+xBp2h4qizTcRy
	Sjiqz0uvXQEEGJr4D2b5Dq4aYFzG2vS7RAE0vXVHaYigXTlqLG7oMtSwSzhz7aeX
	Cy6Va+ZLmDqPgAGpeBXmeBrVGpAsoSI7dB4qNwsvaiM7mAcHu1egc6UGFE+S6Wgu
	JhY75BlhAC3mR/ER66xf8rETSTwXS/lIVDsjtv3yJgHvLRgXi31N92Df0BfpEssq
	qapI/uMPskZgWsKgihyNKYyMplBCUAW/cIrmBZkx/LL2k9wSpJJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53uk5sh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 13:50:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LCApf9008226;
	Mon, 21 Oct 2024 13:50:35 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42c376bvwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 13:50:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ske1MkzRvYp+AI/ggCvYRik0wreE4Zs2c+8LCTd+i8Kn2zyfjNGwe5dXMfVAwLXK7TymEhbQG7904LXHSFqHzUAMAaLMt45URAEsU4l2fbrP7Vc6zB/xYhK4yrAc0xusfYuGDiZwRrUh4SUorLdVWEUT2H6Z006XqfaneMm+1QDuELnvZ+A8LVcIqihS4KdAuFsjfCjb0Yk9O8+zwIm4q9OS6AtvIqmB6U7bboyunV3ufiqOc1G3m2QWBbuI4PeOL8Nz736DZZYQ3azpjFWrpDOWvnv8A44do/BSwsGfbui2Y8sLBrnBhdcKOSQh8iA0Jzye325bblWiMpnET0mBeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eRDEIxgveXUonqgf4GFoOYNVFA7uD4uRc4SYhGcdVAE=;
 b=cPuepDmAQtjfjyxHDH3gyN/INVpsFD8I912o+pIyXfpNDkE2OA+RKfOQJHBqw/pTL2SXmvMtmUHoOom06CpOZFhgWYOF6ILsuhKAL2XWZM9uK56UKWupwOyuzW+Znyw8BPjoT93Dq89ixy+RA/w7E4wqaIZ77TheCpsE2T2HRw/dcc8gs8AfuG35pTCgg9NVKRxy18RyV+X99H9zK7O4IdG5vTJdmG+DD3wS1PNhfiP7ypPGzCIKWWj5VldQc7g0G0AVz8+tONjF2LrwJPJ53dC/TrmgFkvCD62Pk9ms0qB107vkA6OdM/FVwo7EcWofuWMiDZbaohj5kdBhC+urBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eRDEIxgveXUonqgf4GFoOYNVFA7uD4uRc4SYhGcdVAE=;
 b=FJdQ2VxGkXyfYyp+dvN84flFi9fHTemeYbyy2yZfa3DDCMX6QYv20NgUfcEao2RRi0WKmWJU8GA+wIZT0NMy8en+r+MCRZhqDXfarvJ1WTxEJw6FGfvftJSL/VK+4nrJXZHehVm7mpbDZT/1fk15nUCDaQOlKf6T95dA8Bj7Kh8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by BN0PR10MB5190.namprd10.prod.outlook.com (2603:10b6:408:12b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Mon, 21 Oct
 2024 13:50:31 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 13:50:31 +0000
Date: Mon, 21 Oct 2024 14:50:27 +0100
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
Subject: Re: [PATCH v2 1/5] mm: pagewalk: add the ability to install PTEs
Message-ID: <a75f90fa-0866-486d-9143-4e7cc29bb9e4@lucifer.local>
References: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
 <cf91e3936c2dee42aa8ac15af3e76c90c098d570.1729440856.git.lorenzo.stoakes@oracle.com>
 <fdd2be0a-cae9-4508-ba20-eb04c9a1e7f9@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdd2be0a-cae9-4508-ba20-eb04c9a1e7f9@suse.cz>
X-ClientProxiedBy: LO4P123CA0347.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|BN0PR10MB5190:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e0b6bb-bb94-4a00-bcf5-08dcf1d7543f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?md3an9Azzjaz5ZjL19jGEEa4MU5v7dyGFQWTi+5Lke65UBGBhCODdGtOhM7P?=
 =?us-ascii?Q?DCjllmhWwIjZkc0VzyF5A9D1phg8LdGPNuCamkZ6kXyXZjiB6WF0nBAinPQX?=
 =?us-ascii?Q?57i8AM9Ve3f+nHm4vm6SqpQ6F5ET/kooKrGAkwsO/rqqhgg+bJwRg9hG755M?=
 =?us-ascii?Q?1ztpOFIRhLm2E2T7I9aNVJtrkOlWY/dEbEZ0ZMUDGZwxEwGAslA2Lur7re5d?=
 =?us-ascii?Q?4Ttn5pdb3E5DIHVLcZ28AVw0tOGLHSv0t2MVUgu5d0jNq9FERGk+L1Pl57vr?=
 =?us-ascii?Q?6X5TaqddT0NYJ29WOELLbbaAH9dYd3To2NoKbdIQbRPUQ4qtmlqT0ActB6i/?=
 =?us-ascii?Q?9PtaaIreCuW56TdF0A9z0usD+T8Gt5sEZAntlGE1oIlj8/NjjelrdZbs4ov9?=
 =?us-ascii?Q?6FfQgCZoueoPS8W52GQUNEk2XwPpy3aTQxilNoR1NPTs8dlxyL0391aZmhO0?=
 =?us-ascii?Q?BJhbRH2kWcZNJdgHfFtValFQy2JTEGwzj9trxYf3hSjgwfFqinSjiRNBCuSH?=
 =?us-ascii?Q?ghEL/3eQWGSSn3ekCn2bAjlomAf8UjpArykzqH4mST4Ssu26k/9juj9lB2Gj?=
 =?us-ascii?Q?Yea4+5zhCzluL+YwEIkKpauVSPME493I7b291jMcQJexqoXZcXh7dCqONhyA?=
 =?us-ascii?Q?ZWnW3H0mhPzF5paWkzdEwS/SKc9Rd/wR8z2xSwoUt+FfgSpWQ4sQNOzL6DNw?=
 =?us-ascii?Q?a2C8JrBwtPiiCY+JFijWUcQViKIC/Fli24hrtvOaLHxvftbqqUa+uQ49wvNt?=
 =?us-ascii?Q?k1pk/c8ZUoOURS8VGdL/Mlguz18O2LvlMsMgiDi99cswGAYk/ZHOKFtxpEkY?=
 =?us-ascii?Q?8ppzy+cpjmHwLdHR9egju0RHTk3uW/T8cZwsbmL4F+OH/I07VD5/LMTWWWi9?=
 =?us-ascii?Q?DZ5NbfGNmPTqxJaOprTf/Oop8Sz7iozALG6U/pyLiNoi8WGz4e2slC1j/VYY?=
 =?us-ascii?Q?f93ygb2YjxDdLR4/GXmoQlCkWu8i2EoTKe5MIpHgfjdAPkQ8QykHAiakZllo?=
 =?us-ascii?Q?2zK/R9oHJjkyfLQ0/iJuPS3lUgDHP+4zJ93dsNjmSQptSKf8eAEoKidniNQ0?=
 =?us-ascii?Q?MiBnM3KkU62iUd2rjYOxB67oen3avMiAHeFGt9ZOlD7PPlxOLZaScPbxKpAZ?=
 =?us-ascii?Q?MxJOAlo+3zHmU8fSBvNIfL8pRqXsHzUN0lkHBa0BYZCxNz5aEZz3wdxwoW7s?=
 =?us-ascii?Q?yqdE+oyMlNWLcrb269oY8QlqHdbFfcAM/xUdLsOVbGhR6rvypTq0azruOroO?=
 =?us-ascii?Q?LZPVfqxVbgc6jefiRA7Eeggq+0QtOwT14SDAZrR9zgXNPDAV53a52ZzyJ1Wk?=
 =?us-ascii?Q?pkRJTmrmU3LJwuhziRNBJrJ5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/TKYwhyNx5otEfXja10Nb2MZvG+63m1zn0EHrbH4TICQMq4o5ZMqcSOsQmUD?=
 =?us-ascii?Q?OJcjvDdWt7EWoUp4cCEqSpeim1kppd/OA8Z/uzqYxoLpSfgDwbRq56hIuzj5?=
 =?us-ascii?Q?TFlP4c/ps3N8cR92mcnIjACQStsWmqJBaptlLKQUWcWtEWSuDzt0ADrG/9zn?=
 =?us-ascii?Q?WLCN8id4hJoBgk05X50UEMa+9TpvXslEHMVZuHwWWsEi3ijcPm9lwJpAblYo?=
 =?us-ascii?Q?dlm9YWrNOItVaKJNoB9immYSUzCm67pCMLvHZIIWJryemdf7OevM3aVGDv1E?=
 =?us-ascii?Q?il01Y66XqsKR2jeD6spj+11+BoR+juCHu7issNL1bcK5Iye6bir6QyXsmzLW?=
 =?us-ascii?Q?nSC+Yf23YpaBCqqTj8tMH+M1BlARuOtG6F5nsFWoKsXuim/j5dmM01WMjETS?=
 =?us-ascii?Q?MbpbicopJBxVY7I9RnpKI7qdgQW+5rWCi4b9/zkFtZFNv9j32EB2XdnzdMEc?=
 =?us-ascii?Q?1BkT6/4kUAL0m01qZwd3DVai30FuNPosQp/9vYDAPvPt0dVfct+ZZG3AevFV?=
 =?us-ascii?Q?7u1ezaWSgvG57l8MEM5x+/wtBhfnRw623Tx+olCsmpgToS6o3U1jwWUGX4n6?=
 =?us-ascii?Q?TeMxtCMR+tY17jT3TMlLzE2r0PafPR3cOJTxcWZnMhwydIZdnO/E2DcMh5OU?=
 =?us-ascii?Q?WCSPSUl4vmxZXj8HDB8LwF+cLaHJm8UGr1GdfuJt2XqY9g1HPcClcbls4bh/?=
 =?us-ascii?Q?csV9CUJ5y8/5k5UuvPn5vBqsP2RyDEmU7y642TdVaLAtAyB8l8OnspQZDMM9?=
 =?us-ascii?Q?9kU8HDIrM3SX0C/6QPhqxXYxhCSzwPDK25aD6lL78YDL5hPbS52XtKVkqMQ+?=
 =?us-ascii?Q?DVkVbkyARPGIfh2j7W81h0CBntBiFIXQqxKdDdtK7uu9IxTTov1vycs0IX7t?=
 =?us-ascii?Q?/o0M6dsYMs3VNPGvYIhMVz1ZegBAgf6YzGECP+Ej+P7fkUJmhnSYGB9eXJ2x?=
 =?us-ascii?Q?9nU9nt3qw6Xl1JLFWmkt6BYbCzn0vd6PZWG2MCSlDatTTkWGBVgjVXt04zUP?=
 =?us-ascii?Q?ij0jQyLmBB2S0VTYFgQ5ki5aXPkvhfwDVrLeUoiH6ffMeLH3SGzx4cJXMs8X?=
 =?us-ascii?Q?wEq1SSzFE73h5jz7ClCr+4iVTxyPLTMmyyTbwBDKBiAot9XETB6q0I40CcXp?=
 =?us-ascii?Q?Z//u7Sq5+/Xb79stujHur5MEDFmOsd4uYAAskCFZfuGuF1w1IoNj/w5eTX2q?=
 =?us-ascii?Q?c67igZrgpnNPVlAaqsz4B0Ekt9G4zw+pJs9FxWr/a8lMUPlpfCXIQURupLvs?=
 =?us-ascii?Q?d3Itib++eP5mfI4PN51kSAfmmqsplxNEv3NZ1eLkqIC+jtmfYKrCtkB3RIkq?=
 =?us-ascii?Q?09LuEP7tf+1SuNnMsW60IKXRBgBfLkuTIvB6arV83jyg950d7EGTHJvbhkgy?=
 =?us-ascii?Q?h7ABhOB6LivkHiw6X40fxQObEdeVnfM+HtOKAsFDkkCkbfGfUUHYu4vEnhGs?=
 =?us-ascii?Q?0/cnsJNs5VZ4/TZKXdDQcblv89xddSiy9xNXlAmKZb4maYQnHE04FVeHkQt7?=
 =?us-ascii?Q?mQkbUIZEzeQIX6oX9ijjZBKF6J4QoXxBgCG3+fzUT63RmzRScyx+ZJZcK5yx?=
 =?us-ascii?Q?FrPy0Mj1IyEdkGWTDbRpc9LXOPPPIPqj11GnIc9nCzVDIcSGffkDCTmpTjjd?=
 =?us-ascii?Q?7w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tG08cKg/s4GFZH7Cf1pLAvmHahFDkyxYZlJdW9pZTeqmIXj4Ph4x6HXuMcpPWsUDaDkkrSy8NeAOh/MiZ/8aiNm0+KHw6/5eBUiyUi4o2h2GYX5a5JvI02RmCLvWNL+F+9g7LpPs1S3jliT+sAq8zq+Srphqw/KQWLr2CtO75mer0d/cGHd29KZzOkqXV1oJ9/UnHea3pCPbywSDm6tVYXKz/rDo32WLP0wahyZaF6zPyhhgqdmCbv/isPJmTZBRWbsRe8GQWs89IAwFnsNvkInQgLlk1hZgiuBw2k3r+gvj53+QjhaiILP4XH25iIkC/BkimPopJPdrXT8bMFpCp2Zkv9s9vAbM5D2JGeFh712RWcHVVf9ymmvcXcmnm08QAXCglhNSdV9yt1LSB2izcC9lqoPkHUNPxmlOkoaEqaXE6Q0cB7llG/JdnRa9LwmDOWdi9A9RG7SpW0PpmkL83V3qm5s6XPjjjjwFT5n7u1c8soEFaoG8JR+UfHxbrT0tG10zSwMolEDR8yYKQcK3DgnzM5hlUFff9jxeUjlAckxcG47IPkPbnSmn6qaermQM7RivCENNwssSX3EyeMAfMvISIzBN0WXmSBwR36ek3Ms=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e0b6bb-bb94-4a00-bcf5-08dcf1d7543f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 13:50:31.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YHIUmEzxrkNDVhBLZdOtQDqj7JKghZSfeJA3fNrmAe5e5+DxOom9BkE+RYnXJicJY4kS1i4p7/dBJzvnrtqaPMptokCkcsljS7bTz1VYB+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5190
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_11,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 malwarescore=0 spamscore=0 mlxlogscore=640 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410210099
X-Proofpoint-GUID: pb_eI_zpgKvLmWKc5K8tVgrP-06x_mGn
X-Proofpoint-ORIG-GUID: pb_eI_zpgKvLmWKc5K8tVgrP-06x_mGn

On Mon, Oct 21, 2024 at 03:27:55PM +0200, Vlastimil Babka wrote:
> On 10/20/24 18:20, Lorenzo Stoakes wrote:
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
> > If a THP huge page is encountered, we make use of existing logic to split
> > it. Then once we reach the PTE level, we invoke the install_pte() callback
> > which provides a PTE entry to install. We do not support hugetlb at this
> > stage.
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
> <snip>
>
> >  /*
> >   * We want to know the real level where a entry is located ignoring any
> >   * folding of levels which may be happening. For example if p4d is folded then
> > @@ -29,9 +34,23 @@ static int walk_pte_range_inner(pte_t *pte, unsigned long addr,
> >  	int err = 0;
> >
> >  	for (;;) {
> > -		err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> > -		if (err)
> > -		       break;
> > +		if (ops->install_pte && pte_none(ptep_get(pte))) {
> > +			pte_t new_pte;
> > +
> > +			err = ops->install_pte(addr, addr + PAGE_SIZE, &new_pte,
> > +					       walk);
> > +			if (err)
> > +				break;
> > +
> > +			set_pte_at(walk->mm, addr, pte, new_pte);
>
> While the guard pages install ptes unconditionally, maybe some install_pte
> handler implementation would sometimes want to skip, should ve define an
> error code that means its skipped and just continue instead of set_pte_at()?
> Or leave it until such handler appears.

I'm not sure under what circumstances you'd want to skip though precisely?
There's nothing populated, and the user is defining the range in which to
install a PTE if nothing is populated.

If they wanted more complicated handling they could do multiple, smaller
calls. Things are inherently racey with these walks so there's no benefit
in doing everything at once.

>
> > +			/* Non-present before, so for arches that need it. */
> > +			if (!WARN_ON_ONCE(walk->no_vma))
> > +				update_mmu_cache(walk->vma, addr, pte);
> > +		} else {
> > +			err = ops->pte_entry(pte, addr, addr + PAGE_SIZE, walk);
> > +			if (err)
> > +				break;
> > +		}
> >  		if (addr >= end - PAGE_SIZE)
> >  			break;
> >  		addr += PAGE_SIZE;
> > @@ -89,11 +108,14 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >  again:
> >  		next = pmd_addr_end(addr, end);
> >  		if (pmd_none(*pmd)) {
> > -			if (ops->pte_hole)
> > +			if (ops->install_pte)
> > +				err = __pte_alloc(walk->mm, pmd);
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
> > @@ -116,7 +138,7 @@ static int walk_pmd_range(pud_t *pud, unsigned long addr, unsigned long end,
> >  		 */
> >  		if ((!walk->vma && (pmd_leaf(*pmd) || !pmd_present(*pmd))) ||
> >  		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pte_entry))
> > +		    !(ops->pte_entry || ops->install_pte))
> >  			continue;
>
> BTW, I find it hard to read this condition even before your patch, oh well.

Agreed, this badly needs refactoring, but felt out of scope for this change.

> But if I read it correctly, does it mean we're going to split a pmd-mapped
> THP if we have a install_pte handler? But is that really necessary if the
> pmd splitting results in all ptes populated, and thus the install_pte
> handler can't do anything with any pte anyway?

Yes... however nothing else here in the logic has special handling for
transhuge pages AND there is already an interface provided to prevent this
if you want, which we use in commit 3/5, that is to provide pud, pmd
walkers that set walk->action = ACTION_CONTINUE if transhuge.

Having said that, it kind of sucks that we are doing a useless split
here. Hmm. In the pte_entry() case you might very well want to split and do
something with the PTE. With the install you are only interested if it's
non-present...

It's not _completely_ infeasible that a user would want this, but it's very
unlikely.

OK so yeah let's add it and clean up this expression while we're at it, will
fix on respin.

>
> >  		if (walk->vma)
> > @@ -148,11 +170,14 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
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
> > @@ -167,7 +192,7 @@ static int walk_pud_range(p4d_t *p4d, unsigned long addr, unsigned long end,
> >
> >  		if ((!walk->vma && (pud_leaf(*pud) || !pud_present(*pud))) ||
> >  		    walk->action == ACTION_CONTINUE ||
> > -		    !(ops->pmd_entry || ops->pte_entry))
> > +		    !(ops->pmd_entry || ops->pte_entry || ops->install_pte))
> >  			continue;
>
> Ditto?
>

