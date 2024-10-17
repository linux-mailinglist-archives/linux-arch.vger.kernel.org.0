Return-Path: <linux-arch+bounces-8255-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC07C9A2EE8
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 22:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E034D1C21E3B
	for <lists+linux-arch@lfdr.de>; Thu, 17 Oct 2024 20:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D31229124;
	Thu, 17 Oct 2024 20:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hfO0U7Fb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yCFy7uDd"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A90227B81;
	Thu, 17 Oct 2024 20:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729197811; cv=fail; b=CkGDLvJNDNPmM9gpzBPAnHlvvQ8MmaOHWBX1x2mEPNe4B16egvT4BW3ioWykie5E+0FT0Tyvn0jOeCvh6qSCf2SAIifl1LMLXyWkphQU8wvKwyCnTwvj/TLqOw83qdcOxXd5IoYfMj17cYA+3U8HIQWT0WMxr5lT7MGAflhsyJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729197811; c=relaxed/simple;
	bh=seRFlbig6bmMj4L85vquOgIQfJWEVSoox1fS5GDlnrM=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QMUNICCf0ywEklCnTFM/VV6yqzABFErhn50XLcCHvjN5rLP+DSdT2FIaXGPSTqj8X3GS+bbzzfXynH0t9xC/zcDk7Inz2PAl7DSwFx8OOcRNqyRGpOSCfUWI2MuuvUjP3pgV2nSk1lf3fCrhg03b3PS3YxtS+wCYFt6Y5JLwU98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hfO0U7Fb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yCFy7uDd; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49HFBvQb024544;
	Thu, 17 Oct 2024 20:42:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=JFjBK3TRj3stnAAc
	vD7TcUXrYRF59XCIoJApGcGNuJ8=; b=hfO0U7FbpvmYBw23xpHN3rJ9Ej46S3Cm
	Bs8VVeoDTUi+K9e9Nva4v8DegXIBhVk9Fcz5tR1LLviWzxwidMW3GfWv09PU6+WL
	cW3/CbYNiT8tERTUNO9W2V15IoRM5cvAeH0HdekyuhIziQ0r9LmxnKr5AGx8Mqg8
	spKcYac7xIhmh5qxt3gw4VcLwEaTbhcF6A9BcKjNOOTcqW84NAZ5n83pqpkkCuE/
	kXeipEqOpD2N5kTnsXXoNMsZV4tjUIPgXVdCSeyjncsVTPDnxWt+E7VogD94Z69N
	jfENNMuf5BvBfFeYYW18xRmjXRhwHqgN8xB82hGjZ3r56RfrRWXGuA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 427fhcpyqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:47 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49HKDTec014081;
	Thu, 17 Oct 2024 20:42:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2041.outbound.protection.outlook.com [104.47.70.41])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 427fjarege-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Oct 2024 20:42:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWWnf4by29EAk5VSoeqhjMfGxthxAChyydZe14lraHKt0E2/9CG3MT9YonIn64ufnWCF9+deLKQTu/Lck+fDtAvdPAq8yAbdiopz/KqYV3szF+83m7GqSi+5uYwCwi6qGFdy+6jSkHS4vFgrcDfAz5LGSOBCmnQL+1vIfWNm0PLN4NHG5eN92q5vImm/1XL6td4F53I4zqx+kkWDU+GcR9XsmwkieBKP3YiIBqeX2lLGvqftqVtDzS85H5p3XqdvSBSLEwnR1mXdvxcqyv53hqrR5txx6JBoISfoAyBP4wmEi7hJby+H/CQLRt7Kakm2WrjmJrC3LUlGHyUiC5+8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JFjBK3TRj3stnAAcvD7TcUXrYRF59XCIoJApGcGNuJ8=;
 b=F0jUsznQ0lEME9B3/dkU9Eip5tG7iQ0jiKvS8zcE2/4O4tQOrvcawu4EY87kN0rLj13+cztsLMbonJuDtJ7ZltC6m/RevexAMf3ILGQM9oQ19HJ2mfknxaGbzFaZAYBHg0MgvW4pEFxmtRoK7kYfaSdBZ6OqOESocjHVG1DWdMYCzdsdQPfxadTApoM+PVjc1a2Xw0wmDp5tzpb+XUqs3radTpYL5rGpiDsGJrv6TF63gboQ0P7hrvn4wvNtgYDuqWPqZz0xRtclxN7Bl4+z8gzWoZFgQfD3wmNBp69QGIg8nEBTgo8rWKPHl3kjIqgTmrcNCeIudC8gr/PcEh+zbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JFjBK3TRj3stnAAcvD7TcUXrYRF59XCIoJApGcGNuJ8=;
 b=yCFy7uDdi2OknQ4iPK688BuJPD+py9/Y/KdMSmwUCw+a2Xm3Tg/zDm9tcWvEPd8U4+K/n1XhSL4dCHFbtygL7EOWk5AiwtFbNuzNt1ZC0xs0oi0XA4231QlLFDTiK9r5Q8XiHqrD7fudbY+y0Xwudfy1/ZEGZ9evw00ow4ONMPg=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by DS7PR10MB5974.namprd10.prod.outlook.com (2603:10b6:8:9e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 20:42:43 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8069.016; Thu, 17 Oct 2024
 20:42:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>
Subject: [PATCH 0/4] implement lightweight guard pages
Date: Thu, 17 Oct 2024 21:42:34 +0100
Message-ID: <cover.1729196871.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.46.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0366.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|DS7PR10MB5974:EE_
X-MS-Office365-Filtering-Correlation-Id: 703da154-9af7-459c-87dc-08dceeec3fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m98Bo9X+p4VplSh8ISy0RUq5kh4xqQepdItIIQrscY5X2VmYllybz822jXgf?=
 =?us-ascii?Q?yL4XfmEWbXtxgBjwm+2JglPF0ZVfBDEwz9RsCzzZVZlZLr90kRmMRrVlrrch?=
 =?us-ascii?Q?wOfmrQCaG+GQ8R7xpjOOBLSBQHbOhSmCAUPHI/0hMs28oSdHIoU+4AFlXAN+?=
 =?us-ascii?Q?+1OHTbFlpgRmxaS20n+T+WnDPNR+V8k2EwHqxwJOr1ybhRzPg6vwWuQ7ymyz?=
 =?us-ascii?Q?6/Ii3ElzoxM7lgTVmCdFeS33fIug9oJZRIB6wWnJ+I0efd4+80WG4NTSNIDb?=
 =?us-ascii?Q?4zj9HpxGWTpoADqQj8rjINTAVXsI8D7NzkJUH5f9gKNAMAyjmww0Bp7K8NHE?=
 =?us-ascii?Q?MUkEcsulWONW+PYF4dN+DaVD+N0ELqfptK9Pg7NmU2LDrcQ4FpPQAPSrm+qT?=
 =?us-ascii?Q?cxKwXazF5G7I4z6HdGVHfl5N5VvzsEK9UYbmCp/NxZu7/TBSZ3y7wQRW64OA?=
 =?us-ascii?Q?wlNavMJ/LEh3vMariRTbVO0hiNZ4nGBYEhex4L/7EMDlcp4cP3pDK63gBFQl?=
 =?us-ascii?Q?yio+XQ6TXKnBaEccV3EZXTb8W7UfYwjORhxP+AsJg49Jk36HedfhkndVvjCh?=
 =?us-ascii?Q?7SWsJI4RKWdyVaXgMW+vcPK3STL79mrX+0tR7hd4rfLqIzcAtgtgxZf685O/?=
 =?us-ascii?Q?NCO44eaRwpm6qHfTXh4mFTUtVNXKWh898PIlWsv71We6eGrovOPcEPqYsvZN?=
 =?us-ascii?Q?Bb7ncOUhYB+Jn1qX1zFvlrSmpUiJMo43ioeXfxyZWK1AMB3rgwQCUxy7V0XJ?=
 =?us-ascii?Q?kDB76zNAJWPtGm3jk/JKIlly231b1e4Gw26+mIK/xStg3iErhXngs0Zlfuk9?=
 =?us-ascii?Q?v81c03xS5m5H/kOMorbLaywt8jSWnzMu5UWwTOS22dNhi5goXjmsj0TqPSSD?=
 =?us-ascii?Q?BmAvqCOUy+hukLfQnUmNO7yOdpFzWoWAlur0PXKXVMP/SfteFvc+/vIqv92b?=
 =?us-ascii?Q?q/bCjiS7FhYTjCHTCOeYRJIUxbnILYlyxAH3X52z7Wa/i3qDnUEltU40RC3M?=
 =?us-ascii?Q?a/2PovLYSVFML+tTbf57wu+ni8yEdyRjbEOL0nm41NgltAg1Lewr3uSQ4wUv?=
 =?us-ascii?Q?hLLDc5JN0z+6Uy/YVVOrVqEJDzqI1Vn806Ubd1sM19fnWCGPYtB+AuaLx1MJ?=
 =?us-ascii?Q?xUCPlRaqbpExB97aSNtsaTY5v2KAu1Ruwd8LoAc/kVubgsjN0rR3f6jLOSlA?=
 =?us-ascii?Q?K2+n9byO7/o0v6esqwc5XCpCFW+xIA7KmgJDWFYkgLcgpefb2mDGUMzT8CvF?=
 =?us-ascii?Q?C0hAYQERGkqeSWexIitlxJIko8mYM8Iepc//eu/kZGUgtpVInHwVaywnKsG/?=
 =?us-ascii?Q?5MCcHF4OjWUnobpOB0TE7GLn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r5waV27vnCSvaRE6GcBeCA9JehpDLIOVMNHLg4/olG/0RY1b74tBndQlNiDq?=
 =?us-ascii?Q?CcZCZ+LjplDe8Ox/cmxupBlb6FZ4kPgZ62+oftcP5K8m2XQZUzJsyDFS2xUP?=
 =?us-ascii?Q?3dJskPvjedXrAZdtOUFuUSXMdLznvwRonQzLvjMpOeIUDJNjHNMc+lGZnE3m?=
 =?us-ascii?Q?BJVS+NY9Ia+XC16F3YzVI2N1iVmVYcvvgzv8+rEw2Z1OpCjC0As7omNAbsob?=
 =?us-ascii?Q?2ancefKtiEMa+sdFGAm7CE8uTlMrg7/O+eeOkOlrSXqZqa1y0FQdvFOmxN/w?=
 =?us-ascii?Q?YYZox+bLZecC3Qut7tEsyZYAn9HUU2D7Q8GpQb2VdSq2BTV4WD0XB9shrcRl?=
 =?us-ascii?Q?X8oSWKUhIa80DsN2AY4HPfM8ElpkL9M7cxs4HZJAIkkO4njQl6c0ylePu5uH?=
 =?us-ascii?Q?LC0yHgSOH4GHldjuNNCib/fZIFduMXpHyqahUahNFNyJozFEv/rXrx+UnAml?=
 =?us-ascii?Q?q/CtUscjXcFXfEeEh7eICZ689EXFXhhNK9dDJd5TjmU8x67OPkjU1GowhXGL?=
 =?us-ascii?Q?hGS8ViuHmtyRWUkPynKpLgw0ClBPP6+VTWgXQMXTI0PK34B21omAde7OUius?=
 =?us-ascii?Q?u35UwEEXG4WYrxrqSsugzVgkIF81yf8dI6vWc+wTEjA6N9YhD0VlR/xJw0AX?=
 =?us-ascii?Q?ggmyHyEBUktNiTiRYHGF7e+9K/Ao7V6H2BgneRChrLpLxENspaisR6Zwdw2C?=
 =?us-ascii?Q?8vqxPFdkRy8RGdY6jcc1JEZdqeeB3ejJCuNHgR8hGVvJk9BSmwHmGpnkQLbQ?=
 =?us-ascii?Q?ZCqs6FwLqBImjl+3SaQYVETzQUXbG32A9Fbj4SXo+cgbagKqDlLqRU613MQ3?=
 =?us-ascii?Q?O6jpmlFtaxInTqsa2V+A/K6dxtJ9ZyAu/xndv65eylelfn97r9VGxyO+jbi+?=
 =?us-ascii?Q?4s22ioKhBrjq1Lmw1L7xyyYZupve86uOkA8YCPPaYrlUtph7cIxuERD0Bx1W?=
 =?us-ascii?Q?vcZvzUX0Vb7N2WehozIZUEAO+1TtTFKl6o+mWIcccBJhZHoJJtDiv6i9+62K?=
 =?us-ascii?Q?yuIzZ65VahddlSv09jw3uLILg53CroHwydXI3zvnBaooF8UyRZJDmUoMl/w2?=
 =?us-ascii?Q?PEQ/qZuSyobWnGbJsASC/KpuLJu7E61OsAfnUyOErRZ2Vb+GA6aS84JMCKQH?=
 =?us-ascii?Q?759YsNIL3dzEmSy37cNTB+0dvloDS0eGTFFyXK/gYQgI3gztiaR1ZrV3c79B?=
 =?us-ascii?Q?L37JiR2to+vM7UYwd9YlCTu0fS9hHdAPL1d9Nb1pYU341NCNlIhT8GMvV/VL?=
 =?us-ascii?Q?pR9TwFhEeqeU+/dViyMzekizE9dy1o8ot10HWOtBsqFfOtrQVQROMmBRxxjc?=
 =?us-ascii?Q?SsIDOKZ1ktzDJJkEdxXf85KTrFM2b+jR9tPu73LkABwpB36QOGqex3ayFkwf?=
 =?us-ascii?Q?xh6pT9AHnpXTbDO6vjL51cVO+RHt3mZRyc7jOn0FRs1VbJVVTh05X2U4VCOg?=
 =?us-ascii?Q?exVwfh+0Nrpi6RuPncenbyagh+JDBQcLzPwNIBFapwkHIEGVPhX7t4Q856nB?=
 =?us-ascii?Q?PVfjhjgxVMS5bi3Rxe3iE5WBexv+vXp3uUsR3jPctWd6CFj841uag5kqJ6bz?=
 =?us-ascii?Q?gKan7FWw2Nvn6GQHTLw6xEZLKevYX9/kgzJGKb9ILckfEl+CywrTF4oGUTpC?=
 =?us-ascii?Q?NA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2JYK3RJWv03RvdK8AjaABhc2kNNhOT15i8aJaMq9J0/w5oVddr5136ehBFwrXnON/+g6HjSvHql5tKWnMoVudvauBs8NxgVT0+KESVMplEc1rMc7VaGBGUEdCRb6Zp0KMBPxtRNQ7rdwE3OELNN+44b5P0QF52gISXemvZZk0rn48z2mXvGMNyVG34pU064aE7DIMqOQDMjq4K/Z4qqguXIRiai3Lm34Ov1ok0O90JDZWiZO7+/mUzkEL7Cs9aBsoEl4jdLbd7zXD9ksqHJTwE6kShe218RLjhpQXTXyPM3jCeBRCZXoNeWRTiXW2w5IFDpD1t/quUeCVLUAQ/GkV0VlaU9Aq4bELcxoOZAJIuXh+gBjFM/qoLY8QktJV7d9CwcsV6Kl2v09SI6o3Gw4GyITahGqGfz80VpShR64L9d3gZ675q/LrxFmdQqtJl73uY0S0d/9wZy7tySC3NTqSaOZXbwqtFxt7EUOINkcM5Mar2PNSFiBZC9ZWFK2l4p5vwTEQ6purM+o6yGWyPJijROnZLY40DYXgVpgWWK8lfe9ieS6m1jV4Kv5pMq5fM2IVxhW6MVv8fOD/Ye/iDGB8KlEsRxOz8w4LWIW9UUdBEI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703da154-9af7-459c-87dc-08dceeec3fac
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 20:42:43.0710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gLN3jMUhmwZC8fiaee1Qg1qGiL0hIizeB2pa5fKtj3ceT4ROEximdUzYvmrAGN184Dlt3yZS4SdskReUsKfmtq/r4FlnmWw2J8qzXsMWny8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5974
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-17_23,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 mlxlogscore=811 bulkscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410170139
X-Proofpoint-GUID: _zO60PHbznZfGshKT2uf37f1SbrFvXPH
X-Proofpoint-ORIG-GUID: _zO60PHbznZfGshKT2uf37f1SbrFvXPH

Userland library functions such as allocators and threading implementations
often require regions of memory to act as 'guard pages' - mappings which,
when accessed, result in a fatal signal being sent to the accessing
process.

The current means by which these are implemented is via a PROT_NONE mmap()
mapping, which provides the required semantics however incur an overhead of
a VMA for each such region.

With a great many processes and threads, this can rapidly add up and incur
a significant memory penalty. It also has the added problem of preventing
merges that might otherwise be permitted.

This series takes a different approach - an idea suggested by Vlasimil
Babka (and before him David Hildenbrand and Jann Horn - perhaps more - the
provenance becomes a little tricky to ascertain after this - please forgive
any omissions!)  - rather than locating the guard pages at the VMA layer,
instead placing them in page tables mapping the required ranges.

Early testing of the prototype version of this code suggests a 5 times
speed up in memory mapping invocations (in conjunction with use of
process_madvise()) and a 13% reduction in VMAs on an entirely idle android
system and unoptimised code.

We expect with optimisation and a loaded system with a larger number of
guard pages this could significantly increase, but in any case these
numbers are encouraging.

This way, rather than having separate VMAs specifying which parts of a
range are guard pages, instead we have a VMA spanning the entire range of
memory a user is permitted to access and including ranges which are to be
'guarded'.

After mapping this, a user can specify which parts of the range should
result in a fatal signal when accessed.

By restricting the ability to specify guard pages to memory mapped by
existing VMAs, we can rely on the mappings being torn down when the
mappings are ultimately unmapped and everything works simply as if the
memory were not faulted in, from the point of view of the containing VMAs.

This mechanism in effect poisons memory ranges similar to hardware memory
poisoning, only it is an entirely software-controlled form of poisoning.

Any poisoned region of memory is also able to 'unpoisoned', that is, to
have its poison markers removed.

The mechanism is implemented via madvise() behaviour - MADV_GUARD_POISON
which simply poisons ranges - and MADV_GUARD_UNPOISON - which clears this
poisoning.

Poisoning can be performed across multiple VMAs and any existing mappings
will be cleared, that is zapped, before installing the poisoned page table
mappings.

There is no concept of 'nested' poisoning, multiple attempts to poison a
range will, after the first poisoning, have no effect.

Importantly, unpoisoning of poisoned ranges has no effect on non-poisoned
memory, so a user can safely unpoison a range of memory and clear only
poison page table mappings leaving the rest intact.

The actual mechanism by which the page table entries are specified makes
use of existing logic - PTE markers, which are used for the userfaultfd
UFFDIO_POISON mechanism.

Unfortunately PTE_MARKER_POISONED is not suited for the guard page
mechanism as it results in VM_FAULT_HWPOISON semantics in the fault
handler, so we add our own specific PTE_MARKER_GUARD and adapt existing
logic to handle it.

We also extend the generic page walk mechanism to allow for installation of
PTEs (carefully restricted to memory management logic only to prevent
unwanted abuse).

We ensure that zapping performed by, for instance, MADV_DONTNEED, does not
remove guard poison markers, nor does forking (except when VM_WIPEONFORK is
specified for a VMA which implies a total removal of memory
characteristics).

It's important to note that the guard page implementation is emphatically
NOT a security feature, so a user can remove the poisoning if they wish. We
simply implement it in such a way as to provide the least surprising
behaviour.

An extensive set of self-tests are provided which ensure behaviour is as
expected and additionally self-documents expected behaviour of poisoned
ranges.

Suggested-by: Vlastimil Babka <vbabka@suze.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>

v1
* Un-RFC'd as appears no major objections to approach but rather debate on
  implementation.
* Fixed issue with arches which need mmu_context.h and
  tlbfush.h. header imports in pagewalker logic to be able to use
  update_mmu_cache() as reported by the kernel test bot.
* Added comments in page walker logic to clarify who can use
  ops->install_pte and why as well as adding a check_ops_valid() helper
  function, as suggested by Christoph.
* Pass false in full parameter in pte_clear_not_present_full() as suggested
  by Jann.
* Stopped erroneously requiring a write lock for the poison operation as
  suggested by Jann and Suren.
* Moved anon_vma_prepare() to the start of madvise_guard_poison() to be
  consistent with how this is used elsewhere in the kernel as suggested by
  Jann.
* Avoid returning -EAGAIN if we are raced on page faults, just keep looping
  and duck out if a fatal signal is pending or a conditional reschedule is
  needed, as suggested by Jann.
* Avoid needlessly splitting huge PUDs and PMDs by specifying
  ACTION_CONTINUE, as suggested by Jann.

RFC
https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (4):
  mm: pagewalk: add the ability to install PTEs
  mm: add PTE_MARKER_GUARD PTE marker
  mm: madvise: implement lightweight guard page mechanism
  selftests/mm: add self tests for guard page feature

 arch/alpha/include/uapi/asm/mman.h       |    3 +
 arch/mips/include/uapi/asm/mman.h        |    3 +
 arch/parisc/include/uapi/asm/mman.h      |    3 +
 arch/xtensa/include/uapi/asm/mman.h      |    3 +
 include/linux/mm_inline.h                |    2 +-
 include/linux/pagewalk.h                 |   18 +-
 include/linux/swapops.h                  |   26 +-
 include/uapi/asm-generic/mman-common.h   |    3 +
 mm/hugetlb.c                             |    3 +
 mm/internal.h                            |    6 +
 mm/madvise.c                             |  168 ++++
 mm/memory.c                              |   18 +-
 mm/mprotect.c                            |    3 +-
 mm/mseal.c                               |    1 +
 mm/pagewalk.c                            |  200 ++--
 tools/testing/selftests/mm/.gitignore    |    1 +
 tools/testing/selftests/mm/Makefile      |    1 +
 tools/testing/selftests/mm/guard-pages.c | 1168 ++++++++++++++++++++++
 18 files changed, 1564 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

--
2.46.2

