Return-Path: <linux-arch+bounces-12057-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C2ABFB94
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 18:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D10AC1BC5090
	for <lists+linux-arch@lfdr.de>; Wed, 21 May 2025 16:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2502222C8;
	Wed, 21 May 2025 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NZLDW6UG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xgeUoWhI"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD58E1DB92C;
	Wed, 21 May 2025 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747846180; cv=fail; b=mFF8vCJsYoIW3ncWzdvMHQu7osoSVH9DuSDhmyhHOsH3Wcy5uTyRP6PIIHr40f5hQhLzhAE/D5SavfSNNyamSptKLxXaPayh7xRhCIoGqSQAWZaDjkuSRUTVBFfnqV+NBq+x/NwiiA6jwdi+ozpRlrm2RNRSE0voFk5JvzSiHWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747846180; c=relaxed/simple;
	bh=0JlRb5HXQ0HTVbW8lCj2hxqUfPqf89Tv7f/32da3qws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=keM+8pb3jxHFgkBO4aJT7DXBiNULmii2FkYAXqLEwpLHNf33gr60e5l1GsNhO+UjUkjuwm2DwR1Lhy85kRmu7EaTKH6MBbArwGtxcy4xfY6NU/jJvl6oE/1+DORbCL2/98ksyRqi/1hf1AS+62c6eqdS9FVu2xRbPMiVe7K5gpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NZLDW6UG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xgeUoWhI; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGMtVW013871;
	Wed, 21 May 2025 16:49:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=0JlRb5HXQ0HTVbW8lC
	j2hxqUfPqf89Tv7f/32da3qws=; b=NZLDW6UGnhE+dQDib9Qkn9MiNGoi7Qq+TI
	ZTpPPbnrX4zOYD24Ti4gwX0wfIw+ytNphE0z/WOWOg/oS5DkU/NaPcZ6/UduTCuZ
	5YA04sPfl0zvU7AcSysxXkbJkjlrYYW7DqGMC+A9/ljzcAXFCx8lo7wiT+YGii9S
	Ro6IkE8OWsUedDzJs8TQ+gpdrRaM4ubEMnl/ZbpMtiO+zcQIDsIq93ltcAkJLkkE
	A/STG3jYAK/awhF6KLQRFJ7HV1DdlMf36Hyb+4mIs6S6yty1adZb1f/u5T2VUdE/
	jPctVtB3BGMbPKfB381UGyHSN8+MOwgNmmV/jsUx7NOj9mDM4BjQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46sj2qg46m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 16:49:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54LGgNgR020269;
	Wed, 21 May 2025 16:49:19 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46rweu3xqh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 May 2025 16:49:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lr1sSD3zJGp3lbVnEaLbNeAUwinVUhDSzGePVKrnwzeb3LF/VllZrJ1/el/agR5LSjmKoUhfq67Jn/BmRRWaH4Exhy0FGraHrbhQ7NpdpJQKdCPShPgh2VZhpVnfEP3Sz72YfGY1mzEK1/cse3bxtqT+kQXVJRAFSVjVXx+MsKP5NQ8AMccCXXKLZcljz0vx3Kk6ph1FxmAUOdvTADk5Yak8ayj8Ozl6bvQDbbfVaHsmtFW0njc4nUvNkGQwmMpG7fmLvy6ibB3IvoSCsBeydHJsQfSSzayReSGvWPP2oQOabNt0fzs76z73uBj4ZanuX+YaNa5dE6lknKWqlOdJoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0JlRb5HXQ0HTVbW8lCj2hxqUfPqf89Tv7f/32da3qws=;
 b=YIsPW0T/DhjoVN0a5o6OYIRq92rk9unOHyHnw+ZrLUCsSEaNThqSOO9hQ9YUgpNWTqLIMJ6qkcbrKDDThFCfZPepch+8pb7r6OqSrA2x+A3F4UQ1C26OSG3XWDJoijxSl/cykqntI7ub3Cy8mm+m2uvZWSBWDOLT30/ra11zQrXbEYsts6BHn9zuEQBeWe01T7jTH1Oy1XD+oniU9XICpzMCWlyW81F9OzDyexG0v84KUbq2U5FZT1bR7VZf0gNlAjh7DZGrhEe8gj9izKmeHytMr5LYw80WuaUuCpE9TwNdvSrjVWkRsFtqbUViirOC9JMbyveLXyyD2nYifiVE+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0JlRb5HXQ0HTVbW8lCj2hxqUfPqf89Tv7f/32da3qws=;
 b=xgeUoWhIG4O7CB9OF0A2QrgZ/OD5sPjyH4Rp8IWbsHCmpqOUXBrHxWbUBdIAqeuJzgxP05xsgTeD4TtjKIqMVQ0mjTqutNheJ+vjyuXd+FPsHhIqru276TKBzn2zQx3O8uhVd19cHT8QFj3oG8rZzsRtv6Zzc3KU9cFYoB1uFSs=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by BLAPR10MB4913.namprd10.prod.outlook.com (2603:10b6:208:307::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 16:49:18 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Wed, 21 May 2025
 16:49:17 +0000
Date: Wed, 21 May 2025 17:49:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: Re: [RFC PATCH 0/5] add process_madvise() flags to modify behaviour
Message-ID: <e4d9dd63-5000-4939-b09c-c322d41a9d70@lucifer.local>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
 <7tzfy4mmbo2utodqr5clk24mcawef5l2gwrgmnp5jmqxmhkpav@jpzaaoys6jro>
 <5604190c-3309-4cb8-b746-2301615d933c@lucifer.local>
 <uxhvhja5igs5cau7tomk56wit65lh7ooq7i5xsdzyqsv5ikavm@kiwe26ioxl3t>
 <e8c459cb-c8b8-4c34-8f94-c8918bef582f@lucifer.local>
 <226owobtknee4iirb7sdm3hs26u4nvytdugxgxtz23kcrx6tzg@nryescaj266u>
 <7a214bee-d184-460f-88d6-2249b9d513ba@lucifer.local>
 <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <djdcvn3flljlbl7pwyurpdplqxikxy6j2obj6cwcjd4znr6hwj@w3lzlvdibi2i>
X-ClientProxiedBy: LO4P123CA0336.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18c::17) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|BLAPR10MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: ec1580b4-1e01-4e86-0648-08dd98876d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ebaGnUtMfYp6/5SnIkuKTzEEPHMn4pm66COL9wArId4h8GHypObzaXAGHN6h?=
 =?us-ascii?Q?q1h6EMkS2LrM+/XwvN0cpRDgizBydGKvoj9O4TMcWe8E1uLREYpPL7lyHtuu?=
 =?us-ascii?Q?lMXmr6OMndrArN12f0g//cGVhnmwFBvtuXXYgwjoLHF5ZH5nkaXgpTxT+uhK?=
 =?us-ascii?Q?7drZhm/iFX+qubwXiFspNV+SWGZz1HjLwDK6oSwMtJ9dSdVuGEpSiBtez26X?=
 =?us-ascii?Q?Jdwv1znR7fGsI8E0wdk+NMe4kRT/Q03n/20lri7DWDMJyyQETF8s7QOLvyEr?=
 =?us-ascii?Q?hO7cIk7HhubNQmvYZV/em1eq6sDPlUIPQJs+YBcMnfWYSTfP2Ov+VwPyHtli?=
 =?us-ascii?Q?o3NpSublYt5OACpaO1vobrWgqvTDmZpZwzD6VH0j+fYPb3f56d30E59BZZIi?=
 =?us-ascii?Q?anlqYtRqoqBAIl6IHL2w4cH1G84jtAvm4W3wtm6niX6Gq1o3DxR3Gc9citot?=
 =?us-ascii?Q?Lex3aBPeWbXxwfWQ3j2DbAM9mV3DkGGhjpVIG8kotTd9h+IsOHS6JuP31iqP?=
 =?us-ascii?Q?QFTz+Ep5NIQs7dWSmpoQJZWb53ueZz9AtW6RG47Q9Ys77jkv+H0kUj2GeS2R?=
 =?us-ascii?Q?B144j70cNzp0TgAvUSK3Um/dXW+H8m+LEY7m2eNbVYLi8iuYXfYp/vUo23Op?=
 =?us-ascii?Q?VeCeWiO3x7uzX+aXfzVZjx/pPkzgMY4HYO7WAfpEJvfpslK1PuEJGiQAZ7Sh?=
 =?us-ascii?Q?L63akqbeBL9h7ZBaYENUVAxS7b24Hz7aox+Xp/Ipi3If8UDmQSBgxv+4Hh51?=
 =?us-ascii?Q?nYbIknlHWrHbzvDfWDoFdnLsLfpRK252gccQ5qbkq1UGOsUcB/GWAQOZ9r0Z?=
 =?us-ascii?Q?Jh58aRDuQhdyT4x6BZwamQJ9bkWdPJ2C7VQzm41WvTyFW8BKBacH/e10bYGk?=
 =?us-ascii?Q?/npqAXE7YY+MOEWi6Jf6Rjl0Rrd/BqKBu18cklCPwzHh3b+tD9/qFDlwY/eW?=
 =?us-ascii?Q?yexLJuVXG7ZfyjsoiqmtXh9Ik8QqvGkuVZR2eXqhlGiw2QO54UWnoR2zHL1a?=
 =?us-ascii?Q?xOFaZQtNpioUy4n9S3bnULAhk4O9DWGo0LhAJJC/jXZPBa+ycuLLPVYYtS9X?=
 =?us-ascii?Q?p5BC9csdXEzitmMHNDReK0lgklsVptE7pj6/qN6zXaktvOSomXncumtsCtkp?=
 =?us-ascii?Q?W19BbcsrQ6Rk2NxyLElD/Mfup8TuddTn3pgUXUMcskz1Y0Lws7N+u6DccA+6?=
 =?us-ascii?Q?TFErBWNRO643vFFC1m+nbcJEGOZtWB6RrBLWK/9d042AVIQqZrEcFCOsiYT6?=
 =?us-ascii?Q?g+R1cGw9VZhByGG5o5VLJGVCl61a6AuXV7/Ncrb6vLdTevvHZPxTlMWHkZl5?=
 =?us-ascii?Q?iRn9BYQ7faujjC4pZTP+nRb9Na94RSTnDVoGeteJWhcSyy4F1WPs84r79U/+?=
 =?us-ascii?Q?oTkaZY0Wb7Lik7+U/xcjHd0QNHkc2lTz1Zo/SnyO150APqSSYeaey6lJJpbA?=
 =?us-ascii?Q?q1IlSRQwUOg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gcr3ZamDrsqLfLqufmuODe5ydqSMMNdLuewGJVh2u0BI8gj2nCvNbX6hwYtX?=
 =?us-ascii?Q?ZPh805gMCcv17i8Gfx0kcHaVjBELcbD2j+oZ544cHVEzA6N2fPx3yA1xIjw7?=
 =?us-ascii?Q?Am0OshI+0A39aYSugs9DU9sXaH3kegfuiwm0xmo6cuyRnskUyl60GM1mhsT6?=
 =?us-ascii?Q?iIasPWhd8+rvwy3jw5NgXQFsULCYDQY7YNIBj+VEI38CTj9eG5ZzwzwkJ8G1?=
 =?us-ascii?Q?CqdkcQart/aNG/IWrpHn6tXVDamUpEYpatQDKRLheDjqYIA3EQxX2ZLemW2K?=
 =?us-ascii?Q?X8mna7YaUapUTnq0HMf4XdrpjqKfHAF/ci68bKIOaSPHOBjl2q6SFD+Zilr1?=
 =?us-ascii?Q?RyiLrq7Ggqj2XMoYhYOjiNuG96xhaVc1Jhsx56TBVZrMEMGomyb4Y1XJTefw?=
 =?us-ascii?Q?YU9InBgcoTSN6DkMNbGTCT+8S5qdm0sv2gS0GBJYb+Kwm6+t4XUMEVT52Gbf?=
 =?us-ascii?Q?gp4UEPfhrQ/aQP8D3/QyXCcLwpBBopK38KrOja9gDt5HVv/KP9GM3H8vitS5?=
 =?us-ascii?Q?ln9g5pYTi5zyPrraviqMoMyRJ8Lm6yUFmQsyljao369fNEMeakeQ2uA+j9oB?=
 =?us-ascii?Q?/8kDE8ThpVdWCKx6cqgbvy1hUSxDWl+rFDQhdR43acYK2ZKDZrTYagR29Vft?=
 =?us-ascii?Q?YFj6s9I4AMzhT9LZjNpPipiOqjZM0qf5lxbQu1MUKAl22aA6AWMltLOIa4IZ?=
 =?us-ascii?Q?L6CCBaJKcTMCYEpwsZUQ1vh/ibaag2GfjXomXbquUgdioZ6XKWPhApEDI2SA?=
 =?us-ascii?Q?nV9s4ftoLYR8votuhX2GtyBSZnZnm0eB0D3xtxonaYrWaf671VTlEcqqc9Pd?=
 =?us-ascii?Q?39UTGU543gfmd+TUepNvz/Pm9PeH4Tdk2Bf5M+ShJocMMbqZNo2v8KRQZP5a?=
 =?us-ascii?Q?x7Q9bfaEegL3ThjImY4CJyP0q+UN8oE19SXq3/QN1v1OIHLDuRTOQZystx7e?=
 =?us-ascii?Q?hx5NbMelFfhDjSaV7c3i/vicVy2GVp9jmeNbfr3f9zBKAwE5mHp0nfm8ybZ0?=
 =?us-ascii?Q?mHpqhwlh/EFnCa6kHgx4kou3EXHCXmg/DqpNzzGrvWNIzvqCf0AHfD/GJsyN?=
 =?us-ascii?Q?1HrMabh/YrkKLtMQxn4//eoQf22Jo9jly8DSGtkSDovDKpCX47FdaQcGZ4V8?=
 =?us-ascii?Q?ilCSy+bHZe0O+GVsL1SKOOLAwaiFjiC0Yg50zk2ee0ip1/QyamKRgYmK8xZS?=
 =?us-ascii?Q?WMIXr4EX47sHAHuCCMtK70zp1fH1qcl49joC6C7n2cwPjK6Uu61swYoxcMuz?=
 =?us-ascii?Q?FZv3Czn2PITtVnAhECO2Kx4qqIyUbtqKKnq3sX3vsJmy7iPSdmMJjdnXN43s?=
 =?us-ascii?Q?hNny2J4+F/Y+RuYfXdy/KlmrinvCE6lgAWNxGShGuuXDz5STah32dD5El9qQ?=
 =?us-ascii?Q?MSGHS0dDJOC7qcce9NuYxowFgAVH7oPNkfGWeXieJgxAHQliS516uzQNgR2S?=
 =?us-ascii?Q?JCIaULOT5i1EhiYwv/B5SEUU30/cqHGEV3KUtRTmbNL5IjC961VMm7iK1IXS?=
 =?us-ascii?Q?6K20ItJ4nWrdJ8Cjgl3xUzkDkF0Q+iHWQTCFsDw/SfPbf8lksB9gtwzF8k22?=
 =?us-ascii?Q?NKGKKi21tuBK9TuZ5Q25cbHMKHaRwyog5EzUpKvSFooROKS2DWyVdyU2Fvwu?=
 =?us-ascii?Q?OQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	sStirEYyfrztIOXP00+dykxyU3c07gq+flIJTPANWWExM0JfKB8T2FsyZ7QlkmSLXEdfVJm5veqXzyWQe1f2nWRVRw4VQJZbHu7ULvo3YX9DTUQjk00Gc1ERwKnReqUP8u/zJJ9u/BXrQDVp+xx8lS/Aw+pFZgntpFDDNuNI34SzXehfPZSgURA3yOFHnpCGXr/SSInFz9RL2pCBgOu18873S+WZg7JgNDs9EahGzgCY7aQJ15t5r4bfNGW3OvII4VKagBNm+lvgg20ektK5EJothOMxMGDoOu3ZPLQq/xvN1cf1oPZ5RmRusXrQngxqc2LOupfwR4zlGfitNrZMplRjVsufcD02q7N9QZd+pDKVbuNAcAAijcuhANbctYMX6AdHYUm3YmPOcWAqb0ll1KlvdWwuta/iyptjnAB2npKy3z+pK3WSee1S6C1Pek7tCM87uSND1gTLc+Dj/gfTRFuapU1SGKJzoWeucl9qLA9+22irWcAdVUrI60HbW4XIvZKsqKLzqjnTz3ZhdBRSPZJadBopFFkK58ZwzewN/zyzgWFKKGyqQVFdGiSaRonIhaOhNLuBJORYigoydKT8EmBvfvIXUpl7KL1VMNcGGGE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec1580b4-1e01-4e86-0648-08dd98876d20
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 16:49:17.6370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AowF5UL1+MV2qNw/yGlhPjMaXVXQGDqgRwZLvQwCwWzHz3xQCe3R1s+Q6/PciXkvquK4MDe6AzSiBJwwmD1fkhvOLic8KE39nt/SclX9pUM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4913
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-21_05,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2505210165
X-Authority-Analysis: v=2.4 cv=RpHFLDmK c=1 sm=1 tr=0 ts=682e0411 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=kf9L06iJetKXqZ3TvR4A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207
X-Proofpoint-ORIG-GUID: OvJisXQ-R9wGF6_3RT_LRxtLDeJxunpj
X-Proofpoint-GUID: OvJisXQ-R9wGF6_3RT_LRxtLDeJxunpj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIxMDE2NSBTYWx0ZWRfX/E8TB9hiq+Lz HiNwoyMxzuMvCp6RDQ0VGldUVonDJPYFl0EAIFoTt4gfiBTnVfpdQ8N7+TvX6MUFbAJPkNDElej hJCnYoBd59AQmJcdaIAa51hPzC/EI/7wXgS77auM5U25U0n9gB6w1u3g2wcL3wfHkDyH2feCOSd
 EtpSSNh9xptgzn+z3XCpSItkAuTelZlr98zr917O+81ZAPXF4L8RL3H9pNhnxV80EzPTTX0gnCS u4VdD8zKBnrDlwyKhiuwFKN076O9Kw3ST44dFgP8IPcImMb+kF7mMB1my/ey7J4WBwPtZap99Wg tCCIXldxowXOQc2EYhYrwONM1XNa+xPDtvPDc+qm8Sz85mqc4b1QezgnaUIuoFA8NpBY69zOgTi
 ynHASA+aF1NsYU44YTZV4aCkTx76yKWwnWfqEeGpjFsex0zGUq/suJpoKBeLuK3iyeXM4L8o

On Wed, May 21, 2025 at 09:28:43AM -0700, Shakeel Butt wrote:
> On Wed, May 21, 2025 at 05:21:19AM +0100, Lorenzo Stoakes wrote:
> > On Tue, May 20, 2025 at 03:02:09PM -0700, Shakeel Butt wrote:
> >
> [...]
> >
> > So, something Liam mentioned off-list was the beautifully named
> > 'mmadvise()'. Idea being that we have a system call _explicitly for_
> > mm-wide modifications.
> >
> > With Barry's series doing a prctl() for something similar, and a whole host
> > of mm->flags existing for modifying behaviour, it would seem a natural fit.
> >
> > I could do a respin that does something like this instead.
> >
>
> Please let's first get consensus on this before starting the work.

With respect Shakeel, I'll work on whatever I want, whenever I want.

These are RFC's, that is, Requests for Comment, intended to explore new
ideas and to show how they might look in practice so we can make the right
choice.

I feel like I've said this more than once now...!

>
> Usama, David, Johannes and others, WDYT?
>

But obviously it would be good to get some input from others, more so from
the actual maintainer (David) and reviewers though obviously everybody's
opinion matters.

Overall my view is prctl() is really something we should avoid here unless
we have absolutely no other choice. I've gone into detail as to why already
so won't belabour the point.

Thanks.

