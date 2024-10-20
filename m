Return-Path: <linux-arch+bounces-8301-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0389A550E
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 18:21:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D76A71F21DC0
	for <lists+linux-arch@lfdr.de>; Sun, 20 Oct 2024 16:21:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDD5194A70;
	Sun, 20 Oct 2024 16:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O5DTn7lp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bBfrPe3F"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF304194A43;
	Sun, 20 Oct 2024 16:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729441272; cv=fail; b=Vgib3pFWufXs46rc8IEuZ+DLMEHlAHlvNSBbpHWft26wSIY5GNoHtTQM0JItrYAp/1CbHPmvZN9gDtPb1MYGgWwXsuFx8GyLDXBe/hQ4YZ/Y03LWN0ZPAUOq2Eax4uXuVGbJ0f2Z9/mcRfJLuLR6bM46aemtXlqh5akxtIRt/Jg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729441272; c=relaxed/simple;
	bh=byyDknJIjXZlSl3WVNl4q0dawoW++M+678YQZqQBunE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=oWiCwBwqmsgZTaft90s8s5LawnUrI8epV5vS1WaD9NzKZ8Nj4SlB8eDgBMvfqdUBYx8x1/CoeFy9OVGRxSYE+5jZ0p5z/3fl/cCIyOfiwC2gAs153l82tHptWx+VxIKREMszIei53qzGJdzJaCN8UbUJP1hr0gG2AoGI9sjzAPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O5DTn7lp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bBfrPe3F; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49KDBlIK010994;
	Sun, 20 Oct 2024 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2023-11-20; bh=O8hJeffTehHXTsGL
	aORJom5Afz+X1YAv18lGNZrcb7c=; b=O5DTn7lp4OMWaTrckFK7kpua8Pig9x7t
	5OqGQOXRPslJRAMwulZ4zTIkolotEts1PXmgg7R52ZVb+Is7+mQ2uiCH8ChiHVwC
	DpxdbU82EDmmR2aQcKs1PG/m9fdNcBZB82xnrC8cMMONMm02GhUKAlKp8uSWpwBA
	HlPlUv9Rh5i9TGktJ/5th78omIucTMMFKKZKBH/M0iujuhJB1RcJAy/UYNtZv5cf
	Tn/ayWvR9ZQtE5Q3IVrO16MglWVoAD0Q3+PP06nTm4DIP9P8O6aGAkIXwS21grB0
	a5cnv1uER8p62LTUbsw+JYbdNMVxazbX/DVTrw+h3AE8Muvk3MVTHg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42ckkqs3hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49KD3tcf019698;
	Sun, 20 Oct 2024 16:20:17 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2045.outbound.protection.outlook.com [104.47.51.45])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37bjgg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Oct 2024 16:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EpQZCzFpQC5a7wqvpizHESLAZhv713TxZ6AshHDGlNn88I6903HUzDTxNrhwqDqTEQwag6M6ri9MshJIs/NKcNFHfXR+0lDELwY/NxAtymdQnEg/8oo25wW1Dehefeq3x3XwLffaT/E2+AnK9EOfBrgFuzh96xccyOvVcJE6H0sCjQ3ToUGrTgdY3fCRuL51LiFD3SNiCqgTDnjgnyjU5aoKP8iZyqrviEFn2TYLstywzLL/VD2f4vy46nIu4MBGm2u+onEPp2YVgf6igqQQT+nm7GX6QSWBZ5PivY7AWcymL3tF/8GOn92Au8gRnGCO+HdHWcasgitik9xtDdsLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8hJeffTehHXTsGLaORJom5Afz+X1YAv18lGNZrcb7c=;
 b=s1NRFPNrDUNBKiJo36ftmUbXg4UhNoqzzJZc1TE760KZiEfP6ssFdRtiMBGHFOp+DAaKcvMzjgnokmFRY0W48hiGKe9lAkUaCRGcSXfLUGS6SUpbckaH6IEjJpLuFrc4CULhwTTAhJVomuQaQS+wtqRnkUItnuBZB1rN+Ia6cG9W3GgEHYt5xXM14FFAdNfrp7dfvTyuwHAJ/NfaFIhbeYnPmuAEpXe7Hws8tYVgIz77r7gwiz0OphCZKHjMZ9hpdSo5EoOMHhTPwlqKNYj1HotHykoPAtQJBcYSD+rxuGIpghecSUaH/+BjSAjqTeTxiTNqoFwbcsy+35YRRZqaTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8hJeffTehHXTsGLaORJom5Afz+X1YAv18lGNZrcb7c=;
 b=bBfrPe3FqQ4DKLsnUowrA3n8X/npZHDbh+lCxefZZPG+GFG92NXfHsNt9BSDrJw5ifdNwXzN/zOkAZtw9Vp1+sfBzMPvj3HRkXSy3C18AwC3LrBM3elWsNkPTFbLxHi7wCMJrc42Clj+55sueLtn1QI8UjagRI95NkoOCAHqBo8=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS0PR10MB6703.namprd10.prod.outlook.com (2603:10b6:8:139::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.27; Sun, 20 Oct
 2024 16:20:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Sun, 20 Oct 2024
 16:20:13 +0000
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
        Jeff Xu <jeffxu@chromium.org>, Christoph Hellwig <hch@infradead.org>,
        linux-api@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v2 0/5] implement lightweight guard pages
Date: Sun, 20 Oct 2024 17:20:00 +0100
Message-ID: <cover.1729440856.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.47.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0011.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::19) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS0PR10MB6703:EE_
X-MS-Office365-Filtering-Correlation-Id: 32c3fd17-a14e-4a77-0d6c-08dcf12313af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qxJ77VFX2dva4EFVc5vaz4wXm0BWFCFAz/AYhn6DfFpUyx832JZZ7Z1jFLWK?=
 =?us-ascii?Q?cQEoPsf5hv8fKWwui9m1HUfKmQnFN+dV/9P3xhtYpK5P/VlfsjF4blEeajch?=
 =?us-ascii?Q?RzkEC0sEIZf+eXL7ueCpN4CjuN5zmuzgXqI308BCpI92zUkE3bbukee7Gq3D?=
 =?us-ascii?Q?/bSI71/CXvt8nXRLkY5CgOZXtPKpCeydwmiOCWjSbDUiCM78ilTx4maHvXaF?=
 =?us-ascii?Q?K/FpOUs/KC6ZvclUvXYLDjtvrF7cSf+gHAgg+tg5/HD0SPJZDlCm7uzQH0z5?=
 =?us-ascii?Q?6mcOawolpRzqb8pIdleYhZBwf4RSzIDdQeQZe2Xf0Mhu45rX0DW+eglp7OQJ?=
 =?us-ascii?Q?RZYAcEcoAv2Lt5aVSAwKKPS0/uW+ZnCcV4E1JRk+GBjPeQfNAjkdvjUSxW2W?=
 =?us-ascii?Q?hzeHfZBzvuguXF2xd0KEO38NCtNCWALiL7QpLCx2keeNjuETS61CsaniBvBh?=
 =?us-ascii?Q?rn8vZlM/7zCaGxV+wFvynvZvY3nfpnFBQmGmYDs0jKSmi0TEmMY86TeB1vOZ?=
 =?us-ascii?Q?nD5gPJvG7YUuXgfZTq7FwLSny9M/aA0T2/QUIxYO0Ey05z0z7P37M6vcp/48?=
 =?us-ascii?Q?kNvKCd6qB711RryoaOw63qML6bIOxnZ52kKUnSv5YQ/2Jqh/EslPwG809hgQ?=
 =?us-ascii?Q?t7PcD0dT5keVdd7IaWv81uGn+jzceeIdjcP3ZYmKKmqF+nIq8inSXx/Ygn65?=
 =?us-ascii?Q?66WTkxMYO4PbIiHJEWuRw4D+22uQBLXbKEokA+UOZFz9IU4GZXd+HKvWkQEJ?=
 =?us-ascii?Q?OqbE3P4ZdpVyS/16lKHkHlrBeTgBWZTGrQ2Qgly8u/jB1vCXC4YC57p77NMF?=
 =?us-ascii?Q?3kdDHGyJNDrsEj/QEb941673XpYPjW6WzP1OUdkyBBMZULQoIk3B1mn5IyPs?=
 =?us-ascii?Q?fX5ULaRvl8yVA8E4mGrffA98Cz+vGg1+Icl6+PqDA/6YaZ8P6aTGJcnwJhN0?=
 =?us-ascii?Q?AvO7Me2am7tdfLvwlZIhnWV4uLTK7H0Fpai0nFblzs7kNtfrMY+xe3rTPtdP?=
 =?us-ascii?Q?Dyi7fsnaFxeEI9Yz6jfwQBS8r/kVEUqBZuHzyQMnBZyCeZgIPWuxwttAO2iy?=
 =?us-ascii?Q?DmF+Fdh9BsWwECOJG4NZM+Ii/4/JsX0Q5TkUZ+PXaeCUVcJ8K4o0GDZ9JifG?=
 =?us-ascii?Q?Y8p1K/0Qmg+W60cK6VEcLxDex5FmuwRlVJNbBnBRNjGyF0STRSUegEdtaI2G?=
 =?us-ascii?Q?heFsF2lrkoKb7kJw+T7rEHuPh4DvewnF+6Qw+0GoCCXUDOtBxnF7ed8o2EAw?=
 =?us-ascii?Q?n6frbzCsCUwhxLpegkN20K8Ak19mWv1Wa5ssAnPJffjJg2MwFm99JMzTcgRh?=
 =?us-ascii?Q?Wwv6vnVJBv9VSS3Qy3mqcnec?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I+wzes16wR/Y6aRyInWvXXy3NLxvVbGW+aAxR26bfGYytRzv+ZxxgGbPuysc?=
 =?us-ascii?Q?2UICWRgNc8T3rgreHEx77UPGkzlNwJAhMufbQoUWxvSPkO97YiwAk/+I2nD9?=
 =?us-ascii?Q?XIo5pnwZyowF4JXfNa/03tx+e9/MukSveWfx7jEaNw7kke3/7atzLnQDLRPf?=
 =?us-ascii?Q?6z9lCCg63vmKhK7l3+dwHWUFaPux0J4MY7RkQ6PDiGT4BXV0wOf8SltPtacs?=
 =?us-ascii?Q?FFf6hqJhtSpv0wtYMUza2vQPEwAi808Z3gATx9/GrqBGGVKWSvM7Ehr35mLu?=
 =?us-ascii?Q?iLeY+4FZdBTJ03rfhsQ9uw3X4GJyEzI3uSELoar4Tk5Mi3LNwceot2TvBZOp?=
 =?us-ascii?Q?Iuy+VFdy9hsfZc9ilzCQOts4PiLF5CcRr+9REK7zd4oskDk39/Wh6o+MV4RD?=
 =?us-ascii?Q?1CdHP/UP5D4OEb77B3s65K7OnPVzZqpf00D4fvVPuhxY1TT65el55FDcc0DJ?=
 =?us-ascii?Q?MsLlFoia+8erEqVbup21MWoVPVrwjrKNW3vkPAJm33fAWXN7Zukym/zicCte?=
 =?us-ascii?Q?M3Etwb2nFeSNqGvaezCQWdCalM3MRcseNlZjoBHZqhOOVsCgeuxI/OJA/S+f?=
 =?us-ascii?Q?4n7ENDD8HDnlfi7llEA0a6NueHFNqDEYoS9rqbGfAda+0aIEPps3WgnwvEFj?=
 =?us-ascii?Q?GwLMTtpImdRdQ6h2LRQKm4OtNA1cwr9U8T/TT7xJFBTwmOG19Dgr4KSkpVfG?=
 =?us-ascii?Q?VgFLzXEi6iFbx8RMUHSpcljUr0fsKESA8RPnfNajfA4WRpuiwT3TnQsSqW0T?=
 =?us-ascii?Q?hbirsw9+xzzf0drBjK6F02OUMC7mQzg6aP+Zh24qILp8L3AmnWtQ7i51bPo7?=
 =?us-ascii?Q?6WgDjz5S3m1n4Nk1tBQv2b7/b+s/+VgVhCZD6WhrjOTe6ID2BgfOazWJKqCG?=
 =?us-ascii?Q?hVvQDjyW689L9Pthe10/8JrVLqHfnVmAeL2XGMuwohY4Xbf4Pq8aiIfX0HYg?=
 =?us-ascii?Q?mL7n1lsDxV7i3ZiMPFkorD9JFk2JD585hOoh3BZlsBS1lY9plrPdvkg2UAjH?=
 =?us-ascii?Q?7eT5rgcCc3bwd2RYtES6MtGPQ182DhGSBD3c3lvMn2QKpdAFIYxCkQBbKBF0?=
 =?us-ascii?Q?bfFKP3EehXFKiAqGAtfD0kasPBdhI8yhr42DjkZ8Ds+LVvVxhmQdQrGyS6JA?=
 =?us-ascii?Q?8eIcymC7gR3RIPT0j+M7q4bZjzEcQqzNR3k5PgozpjRCBd54mT/6Hs0Cz2PT?=
 =?us-ascii?Q?rFTJIon5pxB8i632zvubfr16t68btV0RwR+Yd2hr97SVGLkRlz0IhN2CO0Vc?=
 =?us-ascii?Q?o27StVDUu9JlqQrB/6Tm7jggugW7LSy/Y79EUar4+gl39TfYaR+ESt5luV9I?=
 =?us-ascii?Q?4jJwqmHQPnx4zrAOh9DCLalxfD63irrr1FwW7VqX9938axJSmDpUv6X7qrlN?=
 =?us-ascii?Q?HVUO5k+HK6EnIF11sSHW514wMSRCLVm6vqeoCyFTKwcsfL3QiisK+OpuzeAv?=
 =?us-ascii?Q?DPDFPxew1AhdNteDFLdeMbAywCxjQt2SSNz6mQEfbaS5Ed57Eev/rYsGt1BI?=
 =?us-ascii?Q?MLTFZoBUMibN1sRlDwYl0fT6GE972ksuudKv5T0WMprlurto3Zgt97HFAE+v?=
 =?us-ascii?Q?xakAtmQMj4jzlQzljUE4fJdu1S41jEqROBoX9+NmjESM4Yk3gvCg2iIGYO/s?=
 =?us-ascii?Q?+AXybFOycXjjr96bJT3tJLyJkXWFw/5JGl+bnqOlG+n9E2pymPqjcYJnLJuM?=
 =?us-ascii?Q?AZKI8g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rP0TmBMVJEIlSbCkWJA6K3+/WmUPZHKmgA2PUlG9/3FNz93MQfY7UgB3ZTZGMz6UwY5Sa2HPexhzuGKWhPBlPc7aSHEtf3vvvZmM2b1Tr76+uPoALGe3lcGkjBkL1iz4YV5Eq6wlgmIRoowBU/Ogp7WM0Qg1LYpZDVbmLb1dc62B10muMRf4DGgtXGXL4Rmaeu96AFvQa3RjwZzpqmEC4xT/z2Vnw80gntLe1pP8icMxX2QAqs87FlH9EKFPNauHAQWuErZCk2gqbTDgPm9nxasp42SxRcg7dPDRlcaopXl+I51sRLEwu2exF7n7O+86Iygws+zcUEuEEix7K98zHkG3/+E7HMfP71G5ciNhKH+LBnS8bsIFmGR8KVxfx+/0YcBVdd8l21OpqBhc+HXKYmyBTvjf2YSH3TvgUyqRT2h8RRKhuUBJ1ou49LvEk6fcOu5D7nuz1f6w6NFmnDQYdIwzs+YRgVP/msBjxnM/bpNOfK1aYyJhsP51eZWegj28BAKRQFUKItgCfBPjpiCkLeLZvPdteBzj/09EkRsh8eCGtbOSToCwFQBRF2MuwwzqaajQGat5UEj3DkhVGBpWqebq1EX6gAao4klbVaNDvAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 32c3fd17-a14e-4a77-0d6c-08dcf12313af
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2024 16:20:13.7833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoH3Tbm5a5eMBQOAcUabwwjGmZnck6R+4wPIF9yjzMgfnMK22XpxiuppvZBPRO89gjJMVha4wD74EaypsATxgPHMnA6ek0CgRFEwJ171J/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6703
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-20_14,2024-10-17_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410200114
X-Proofpoint-GUID: smzS4JAnZBTa-SVAqYzRIYA2ihRYzQIG
X-Proofpoint-ORIG-GUID: smzS4JAnZBTa-SVAqYzRIYA2ihRYzQIG

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

Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: David Hildenbrand <david@redhat.com>

v2
* The macros in kselftest_harness.h seem to be broken - __EXPECT() is
  terminated by '} while (0); OPTIONAL_HANDLER(_assert)' meaning it is not
  safe in single line if / else or for /which blocks, however working
  around this results in checkpatch producing invalid warnings, as reported
  by Shuah.
* Fixing these macros is out of scope for this series, so compromise and
  instead rewrite test blocks so as to use multiple lines by separating out
  a decl in most cases. This has the side effect of, for the most part,
  making things more readable.
* Heavily document the use of the volatile keyword - we can't avoid
  checkpatch complaining about this, so we explain it, as reported by
  Shuah.
* Updated commit message to highlight that we skip tests we lack
  permissions for, as reported by Shuah.
* Replaced a perror() with ksft_exit_fail_perror(), as reported by Shuah.
* Added user friendly messages to cases where tests are skipped due to lack
  of permissions, as reported by Shuah.
* Update the tool header to include the new MADV_GUARD_POISON/UNPOISON
  defines and directly include asm-generic/mman.h to get the
  platform-neutral versions to ensure we import them.
* Finally fixed Vlastimil's email address in Suggested-by tags from suze to
  suse, as reported by Vlastimil.
* Added linux-api to cc list, as reported by Vlastimil.

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
https://lore.kernel.org/all/cover.1729196871.git.lorenzo.stoakes@oracle.com/

RFC
https://lore.kernel.org/all/cover.1727440966.git.lorenzo.stoakes@oracle.com/

Lorenzo Stoakes (5):
  mm: pagewalk: add the ability to install PTEs
  mm: add PTE_MARKER_GUARD PTE marker
  mm: madvise: implement lightweight guard page mechanism
  tools: testing: update tools UAPI header for mman-common.h
  selftests/mm: add self tests for guard page feature

 arch/alpha/include/uapi/asm/mman.h           |    3 +
 arch/mips/include/uapi/asm/mman.h            |    3 +
 arch/parisc/include/uapi/asm/mman.h          |    3 +
 arch/xtensa/include/uapi/asm/mman.h          |    3 +
 include/linux/mm_inline.h                    |    2 +-
 include/linux/pagewalk.h                     |   18 +-
 include/linux/swapops.h                      |   26 +-
 include/uapi/asm-generic/mman-common.h       |    3 +
 mm/hugetlb.c                                 |    3 +
 mm/internal.h                                |    6 +
 mm/madvise.c                                 |  168 +++
 mm/memory.c                                  |   18 +-
 mm/mprotect.c                                |    3 +-
 mm/mseal.c                                   |    1 +
 mm/pagewalk.c                                |  200 ++-
 tools/include/uapi/asm-generic/mman-common.h |    3 +
 tools/testing/selftests/mm/.gitignore        |    1 +
 tools/testing/selftests/mm/Makefile          |    1 +
 tools/testing/selftests/mm/guard-pages.c     | 1228 ++++++++++++++++++
 19 files changed, 1627 insertions(+), 66 deletions(-)
 create mode 100644 tools/testing/selftests/mm/guard-pages.c

--
2.47.0

