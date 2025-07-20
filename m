Return-Path: <linux-arch+bounces-12875-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE398B0B954
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9BC18982F0
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50066235071;
	Sun, 20 Jul 2025 23:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VcDqVKBo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zww5DM7u"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6CF230BC6;
	Sun, 20 Jul 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055010; cv=fail; b=cBX1EJxKEYYWL9XgEHzasBRVGwxfZV7/OjIUiNNLo6EiRIqvGNNEDw6s8MZf32WJTR+/98SU9MwTXMYNXWBpfAjvxXRoYbqWQ3yC6eqVY/qvMw+1JGrPWma6ZH8a9wos66eMxtIcT7zDTz4UM7EYygVA1XPa+IvRYDvGFDzWyEA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055010; c=relaxed/simple;
	bh=qyaq374jq2lGFaImbHt688q46biN02d6gVBhtNtQUgw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KRxurDN/EE1D8DH6o//iiIMSo1hSV2ae23Tlmu+cT4Q8FTkxFgWTzrymQFuesS4L2a+R6Ub6qovS/mWYuFnodCMWx8UOr62X1cS4kcugqYiR1x2gcmjikAMGfGKRAtSSDeVdpGOtUDP+Ezyi7B2pJiSpcTprQ0cA3fdu5FP6mA0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VcDqVKBo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zww5DM7u; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KM4UC7027455;
	Sun, 20 Jul 2025 23:42:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=YXYPa8so8Rezq//X
	Pjy9e80hmn5qMW95a2duZp0yP/s=; b=VcDqVKBo4nacIidIeOqhFHq46L/YNqFv
	I17IsgdEhoTHYVtDz8YykuLg8YnBcsPSpq3aep7RP/pw4BMmEOcooP50bGCjrVVA
	3FTzUFtvOZrEMCk4qqobZJhqIws6Hdc15H0hTgBE1Gu2DzW3tdkptKy68UEs/v9B
	3V+fjWvPIyfPnwTRpkjMWegYHypaqnosmiDcXUqKk159vJ4sLwMrMd/W5Sgmm+KC
	y8W1e+xM/zAqVsg6Pn2swhJPB4H9l453oSCbprrGNjhpxVCXcQji0rJdycm9KgqV
	CMvbdmhD6HQu8zkGwVNwszKJf6O4HOD1J4bTHe2ilgxPkqNrwc7rOg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hp9hy2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNebZr037661;
	Sun, 20 Jul 2025 23:42:29 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2069.outbound.protection.outlook.com [40.107.212.69])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7e8g2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMT+ekHgDxKP1jmTK6Ye2naewgn6ID+cuZrjygJdk2qg8xJysgsu6z0F7ukFfj5xO2F2Sew5YhjFLd104wJDjxDWXKzBEsrgakvlXAw4EYTWZJbPI76yHOhsOgUBF4KqIRifJRH840u5druLIXcST7XAxgK+/sji4eIP5mD//rRCIjmyjq/9Wevay81ceHAbJL0TH1AeCf1tyUKvl/DJ7IQ9l4TqpUF4ntZzq5zeQQv77SM9aB/o5+9jRBdzBnQ/V6KK050CBuFJ/PWwVH4xLtMTKKSvXhmxUYPJ9iaLlHcAmFc6GuTwJ/Nutzhmbpp/t1qzEAkyPUqAGdbdlz0g4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YXYPa8so8Rezq//XPjy9e80hmn5qMW95a2duZp0yP/s=;
 b=s1bq/P3KHNOiJS+x5Z8tGjkA06eKB23F/sc3PjifIKBv1tBBDhWe3/j6cJ2M1i/4DE6kFJKUKy+VZW2UE3csnVoMST0rXOhc9K+Sd0xJN6iIfddTi1V2ZvZ1f9vzZlDKt5ghg6LrOMt7Jh4a276MbTU2HAusMl9YkUkcla4XaSwlkmBn/7T4tbbdIHKzollaJTYyx62Dz1uoXuVeHB67c6JvwQmSW2lZi69dr7koBGcvPeigJZfGD4AHVu/1iPEIEzLUwlU+JtNUHT/EtiMYsYs1GkT1fuduR7nVufy2azWEEY5p6q1TnEJsMXkjm8q81QF9eTOhLlJSA4GJ7C8jbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YXYPa8so8Rezq//XPjy9e80hmn5qMW95a2duZp0yP/s=;
 b=Zww5DM7u1iFWQ9ipYj1ChFbGd0134t41Mcm7yMQlBINgFNqRySiBO537q0p6JDh56pfY7FgQZu6xF4cedfNpkMgbDr9d8ZUyLOFN066hrYpfQ+Ynysmg1qt8x6t7+0rU4Rzuzyw0m2lqRpnLIu4n3b+56kDr5K2zi9s5VRy42PE=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:26 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:25 +0000
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
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>
Subject: [PATCH v2 mm-hotfixes 0/5] mm, arch: a more robust approach to sync top level kernel page tables
Date: Mon, 21 Jul 2025 08:41:58 +0900
Message-ID: <20250720234203.9126-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SEWP216CA0011.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2b4::8) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b779d20-bce0-47d8-6aa1-08ddc7e71449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ln0zn5bUqfSc+KEnlu9ZLwRNwDhrYPjQW9jpjh0ZPDMoRwb6Ghal3ljU5Cuh?=
 =?us-ascii?Q?A/EdRxVOTXQJ0w8viCPfZd0afO5rQONAwdrB4aivFpo0JQtc+86MM+WN1GQu?=
 =?us-ascii?Q?g3Bk1LE2ZgATYMgicY4N3UQNSJ1np/9/PQxC1sMj8agVSDWNBYUaiO7HBadY?=
 =?us-ascii?Q?iOCX79mbWepihT3qy0wIsXI7zD74UWM5pO4RtirgruqTw9zUSyLNGgNyH3e5?=
 =?us-ascii?Q?HxNY1eMz+y6V3215nvVtuWwaQFTnuQ6OZhdF0YDBJEZaj0q7tL6RWLZhLhna?=
 =?us-ascii?Q?fNT+cXfxnp2iuTzfiSVQnPOc40YGeSKRWKzCYsmiotiiJosycWTeK6gWSjQi?=
 =?us-ascii?Q?yt01RxYPsJH0OBfMlzBXVUHK2YbRI6DDzRsfIwkXNrnBC/OXZhDarZW82ruN?=
 =?us-ascii?Q?Y6Omw+tvfUInL/Bpw8SkbfroMX+ikeIXqxZHYATugc8NJlYKKaJx9bhsz1Jk?=
 =?us-ascii?Q?ell0upT6SJaPPbMP5E+gR5JLUy992DEoVvNJ6cEieDb622IefGkb4J1Gy1aa?=
 =?us-ascii?Q?E6Ys7juqMyn9HbXTstJS28CnursN3Dna+hiemMbrASbZclCze8cutFlQXwMM?=
 =?us-ascii?Q?bolBmdJlYgkwjnij8mBZL1+wmmjrxG63dKYxv1sNHmCA0PfS4Xar3q16nXNy?=
 =?us-ascii?Q?mlnvlwxDCy4mRZBYUKfI9rgJPiObJ3REXqBIa5BFVSFhSaUffQzN+mZnoz1a?=
 =?us-ascii?Q?DmXGdV6Gv7244RcmYIzrn/N5vtOJUHo359RLog3+JURu6CsnR1WaeAocBk72?=
 =?us-ascii?Q?kvbDK/5YbNc+94yMSZQ7vgaQ0BGKnZov5IVnSzp0Uc4rktucaZ2xbHA6ndUf?=
 =?us-ascii?Q?UpGo6DpAgq5EhalZ8ajl0t7Vwv0ROtu6AhHa7rGIDP8eSM354BDfQFvNpVFM?=
 =?us-ascii?Q?SLg6j/GARCIl/U8YrTVjvtVwZnBjddwMzGr41N2O/KkLph1JfZnwlsWW9baX?=
 =?us-ascii?Q?1+PUWisxDzc7yPQOsjcKlDSMSc2R8jSOh2JEGpPJDmdIrHgfqp7BJk6w+r9Y?=
 =?us-ascii?Q?UxyhLQ/Krky5CHQ5fxZVn+UXUPNFNR0NYIjxeEAdD2myW9GA9aL3MkD4q9zP?=
 =?us-ascii?Q?l2tOjpTji94CWbPCbf+iwQ4HsguXpz0keUteo7/sQfZ5CkN9gQ8EjW8gtkG9?=
 =?us-ascii?Q?Kx+QzcHqy90JtSScvPCcHrS3e91jp6JDQ1tBX1HvHqckzaOSDUxGUoDfgvPE?=
 =?us-ascii?Q?PkNr6eL/2AIYsvrYo7xo8NrVGGtSUEWQ+pCV87DfLOZJQNVZyJO8YEZWajRD?=
 =?us-ascii?Q?hfwodwSw4ereVvYBbH800QO3h3ex/rvGIx7ziuAl6xIWtBfsviNZSHlw0BbW?=
 =?us-ascii?Q?zdVFYKAq+jbx2xfR5KGOb8M0nvM+wT6dKAjWmyQ7uSLDknrCXmuGkcHtQJt7?=
 =?us-ascii?Q?ct2j902NTKpYH9JmqM6WDfKvBCSafx+WGzdmCPpDBYyVE4BEkI2ciTWpAOPV?=
 =?us-ascii?Q?IuGjMoRLqtQwrh9ka/zoLh9Xa7EtciUckPek4+94ovIRTwqRv8XTIq78lxLR?=
 =?us-ascii?Q?FKiXFgFCYX6za/s=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BekR4/+pch4viTaLTVZv4yosScUZHlitk+i+21OmUrF7F1bNL8FSfhTWJ27Z?=
 =?us-ascii?Q?W6ShWhpR5mww8SwXLpQ4qm2rbyyajDsE6nYJUmMReLwndls51K1cazDDGrZr?=
 =?us-ascii?Q?lwo2LGuA75ACgHIcEljKvSkwBaw3acOK1tW4GenJNqzYWTDWHrhLSI8T1bvy?=
 =?us-ascii?Q?CISLVFxRpP7NBP9soXOt5vW502XquK1mBlWOktgX7teO3luKsvDMieCkr7sS?=
 =?us-ascii?Q?xCJhJhDfQ9cY2Bzp8S5QA1MSsyNWLbMDBiSwefPEPyTluI0X05g3K3m3qKwv?=
 =?us-ascii?Q?YHaOtuU6hhS37cp9f4s+0ZzAnr+29ZCfpl2ocq93z9tG6oEPMDgi21g5NOGU?=
 =?us-ascii?Q?vXhnbbOVJCvQFIZ8Ti+fwmToTgmp3jKBhn59mLkFeEqeQ3uHhVptVqsaZie+?=
 =?us-ascii?Q?nTCR7nsB4z9b0CZBeXofqMrEsHz5sw5ta/Po2dCKEiiO1LCtQqJZOvrSI7A2?=
 =?us-ascii?Q?jCoBKPFzfKcrQNhyY6I2iXvy6kxs2/Y2SsBExwKda7Yas2oA8nv058Vk8Ax6?=
 =?us-ascii?Q?6BKWtbrrRKJsqOm0xt7YszEyYA7QSXzgMfl88RvcaIwyD0nZ5bPm+0uusHu5?=
 =?us-ascii?Q?pj/dgruJOqijdjKr7kQ3w2RGeq8iK1s90oakRZSrQuwOuXzUmH3c2Ut1ZclK?=
 =?us-ascii?Q?eOxOJp+PfpfQAdlfeXaQjq22PZoWuY/YHGXqlCh/uDR+sx11XaKxLIZQkU6N?=
 =?us-ascii?Q?dNvPPaQQ0PLUqRMFKijJQYm0BE0qmXNGjD9bGP+H4+M8kY8QSQ5iKwCmc44q?=
 =?us-ascii?Q?NsMQ60SclSzoQaeHDBFwscLrCcmqWHuB/LwDvANQfR/uQkiHXZYSgPLvbij+?=
 =?us-ascii?Q?DQ9A/la99vUcNZYsZUdVdI6G+5afno7lBKjfvDyb3FDk2i6F4XX3st6G5hBT?=
 =?us-ascii?Q?X2+xA9oVZhp3LerIc54KFxWw/e7+IFDfGXHT3vqJNx5VbwM1l6wyXgfnoR/R?=
 =?us-ascii?Q?UuVHLR2aDXZWLSGC/NUmWaqLHpGmACGInVkV0cObu+FySzbRpJfP9FfLgFQd?=
 =?us-ascii?Q?Gyxf3Bzrwy8HJiWz68y/1euSoOLT4i3aufQq57oO9KUPM3yqA08SLlzcRTs7?=
 =?us-ascii?Q?k/R/c6t2vSyF4uPncKbBdvHQ3Hh+MDiSNbwpqXyTBjeFSxwkwXxZD3d9Uv1W?=
 =?us-ascii?Q?RGtMEhTXmbKHrvcgot7sXUyhtK55KYiuChg5ruySMU7wxiFzAwJEALwafxuq?=
 =?us-ascii?Q?g/w636sU5tdlM8WGSLUAqHLIgIjnggHm4pHAPeDMZ5bS3lP2sGdHSL7KpUa8?=
 =?us-ascii?Q?HqctJ6vqLResjfuWplgkbkrSDmH+NGcsyFTHMrB7Fw3u9RbGTgYmKzkwUJIS?=
 =?us-ascii?Q?5v588TStcwzcM+3WdqZmrW/RlX+e13L+jAVRnKa7QRlDnjPzWszj3JctDBg/?=
 =?us-ascii?Q?SZjcwY2uTV05pKiwyrETLRLCKtMPek2yM05pN/ihhuAM+kiIz6N6Mw5mJSdC?=
 =?us-ascii?Q?s+BZoLsrBo3HL1HFk67FjdE9wWM1wF5Acb2vFBu+ipvRvGRswiMosUnealyG?=
 =?us-ascii?Q?ZE/YqeEMTm9GpekNXelpSmVqvbMOPYcGOfxC1HoNwxnVJZReIYYccKybCGhG?=
 =?us-ascii?Q?LrOfBgD1IvcpGjRdIkOHa5kZfp19N3z6KrCBu00L?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	O72MmqUCkTBkGqU83AYPCQIvoF1bgoTCMd5guAcupoItOcPYO2p/z7D5hhtIKp1llxl86oo9911sbgyL5irr/LaopC8gLjFmkhLyJaVbIPWMjJmHSSztxyN7i2D8qaa7mjUUKwMiiBL8iKBBY2HrxKrS0MvvabdqumWBEpPMsp1J7vuumdtQc3ZCs+kPhh6p6bYeSHBABSEat7kXbNQYfs9e4kmP3dqm8ZHmEZiYOC8KsfVoTRkf1rZiL+6YUZi6X2JbQwQPloewY2lVHVJqaQsnyyHlGzE9iYQ1OC2J8/OilLeC5vLVMXlJLJxveCXJkZXgRn5XxWFwsOIPxDxAwUaD7WUYgbUDshzc79wS49NPRKurZrwLIFdcLWlyIqwHv/pSsf8RQPEJ2DybsGvpW+wTSLlzjZbJ2hazM9qbp1j/AK7OcehMi9TzBt1aYSVSbdalvQO8FFu1IRtQPIBs/wMzIDcZ7I+oNviVfJq7wo/FiLQkmCfLVv+OCwnnyKhaegbfHNk5e9a98Edo1tORsoNL4sHXHyzqUH9HdE7EZXbFx7tZmrdNT6mJb43VLDL373es3YxvjS+c8/IaibSzhFAkJoKNHvKCCxl9JboM5jA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b779d20-bce0-47d8-6aa1-08ddc7e71449
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:25.0848
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZDrpZHqbiljQXjmxxM7XmGZtPuIUvkxJBaRO5XPJhQPbLROphurPUkFr6zwUeFi917IGavngw2dPL+rriW6Euw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Proofpoint-ORIG-GUID: 2N9tvoiT9kML1FeFZUZOQSW6VvqIZSGg
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687d7ee6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=QyXUC8HyAAAA:8 a=vw_QiQTHml8d4L14nw8A:9 cc=ntf
 awl=host:12062
X-Proofpoint-GUID: 2N9tvoiT9kML1FeFZUZOQSW6VvqIZSGg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfX7aYt4AY0Ggvq
 eu5Qfv7MaRypbcOVEGsQkQ8y0TyG+cV92wcRbWxSkNOnZHb+FGgsft1qj/mBGnyqihnTWXZWgvW
 5rrzK30DPSCJwNUx5DGuCjhqr2z21Oe6a0HmIGev5wD9vpsOxd4ftQUlu1JTgTbqmpBLb82C+4J
 7I65qkfB/wvo+MVgBizlUjRsS0gczflE6/71OAfjyYMUdy1xmcdUB0EUWQZ0Yxpfaf7pnkzHxKo
 0dc1V3FUDOnlLA7mKQ6rkS1Ov5414Kik9rVHZfzikCNOomXVcSW+1YVnrlBYI1X+0isRhgNkxGs
 Fi0lN+lGNurufSrJ1dw/yysu3McGHO6Jr8ILaD+xfu3IPq5QrVLAj10Yj2H4aPANPqEeeGGb7YY
 syu35+XpeRTIe3BA4KWeUaHMUcBoM2hKNmIEehrr+0Gz+ZcmeyrEbZ7F03W3LA05HTVjqj3D

RFC v1: https://lore.kernel.org/linux-mm/20250709131657.5660-1-harry.yoo@oracle.com

RFC v1 -> v2:
- Dropped RFC tag.
- Exposed page table sync code to common code (Mike Rapoport).
- Used only one Fixes: tag in patch 3 instead of two,
  to avoid confusion (Andrew Morton)
- Reused existing ARCH_PAGE_TABLE_SYNC_MASK and
  arch_sync_kernel_mappings() facility (currently used by vmalloc and
  ioremap) forpage table sync instead of introducing a new interface.

A quick question: Technically, patch 4 and 5 don't necessarily need to be
backported. Does it make sense to backport only patch 1-3?

# The problem: It is easy to miss/overlook page table synchronization

Hi all,

During our internal testing, we started observing intermittent boot
failures when the machine uses 4-level paging and has a large amount
of persistent memory:

  BUG: unable to handle page fault for address: ffffe70000000034
  #PF: supervisor write access in kernel mode
  #PF: error_code(0x0002) - not-present page
  PGD 0 P4D 0 
  Oops: 0002 [#1] SMP NOPTI
  RIP: 0010:__init_single_page+0x9/0x6d
  Call Trace:
   <TASK>
   __init_zone_device_page+0x17/0x5d
   memmap_init_zone_device+0x154/0x1bb
   pagemap_range+0x2e0/0x40f
   memremap_pages+0x10b/0x2f0
   devm_memremap_pages+0x1e/0x60
   dev_dax_probe+0xce/0x2ec [device_dax]
   dax_bus_probe+0x6d/0xc9
   [... snip ...]
   </TASK>

It turns out that the kernel panics while initializing vmemmap
(struct page array) when the vmemmap region spans two PGD entries,
because the new PGD entry is only installed in init_mm.pgd,
but not in the page tables of other tasks.

And looking at __populate_section_memmap():
  if (vmemmap_can_optimize(altmap, pgmap))                                
          // does not sync top level page tables
          r = vmemmap_populate_compound_pages(pfn, start, end, nid, pgmap);
  else                                                                    
          // sync top level page tables in x86
          r = vmemmap_populate(start, end, nid, altmap);

In the normal path, vmemmap_populate() in arch/x86/mm/init_64.c
synchronizes the top level page table (See commit 9b861528a801
("x86-64, mem: Update all PGDs for direct mapping and vmemmap mapping
changes")) so that all tasks in the system can see the new vmemmap area.

However, when vmemmap_can_optimize() returns true, the optimized path
skips synchronization of top-level page tables. This is because
vmemmap_populate_compound_pages() is implemented in core MM code, which
does not handle synchronization of the top-level page tables. Instead,
the core MM has historically relied on each architecture to perform this
synchronization manually.

We're not the first party to encounter a crash caused by not-sync'd
top level page tables: earlier this year, Gwan-gyeong Mun attempted to
address the issue [1] [2] after hitting a kernel panic when x86 code
accessed the vmemmap area before the corresponding top-level entries
were synced. At that time, the issue was believed to be triggered
only when struct page was enlarged for debugging purposes, and the patch
did not get further updates.

It turns out that current approach of relying on each arch to handle
the page table sync manually is fragile because 1) it's easy to forget
to sync the top level page table, and 2) it's also easy to overlook that
the kernel should not access the vmemmap and direct mapping areas before
the sync.

# The solution: Make page table sync more code robust 

To address this, Dave Hansen suggested [3] [4] introducing
{pgd,p4d}_populate_kernel() for updating kernel portion
of the page tables and allow each architecture to explicitly perform
synchronization when installing top-level entries. With this approach,
we no longer need to worry about missing the sync step, reducing the risk
of future regressions.

The new interface reuses existing ARCH_PAGE_TABLE_SYNC_MASK,
PGTBL_P*D_MODIFIED and arch_sync_kernel_mappings() facility used by
vmalloc and ioremap to synchronize page tables.

pgd_populate_kernel() looks like this:
  #define pgd_populate_kernel(addr, pgd, p4d)                    \               
  do {                                                           \               
         pgd_populate(&init_mm, pgd, p4d);                       \               
         if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)     \               
                 arch_sync_kernel_mappings(addr, addr);          \               
  } while (0) 

It is worth noting that vmalloc() and apply_to_range() carefully
synchronizes page tables by calling p*d_alloc_track() and
arch_sync_kernel_mappings(), and thus they are not affected by
this patch series.

This patch series was hugely inspired by Dave Hansen's suggestion and
hence added Suggested-by: Dave Hansen.

Cc stable because lack of this series opens the door to intermittent
boot failures.

[1] https://lore.kernel.org/linux-mm/20250220064105.808339-1-gwan-gyeong.mun@intel.com
[2] https://lore.kernel.org/linux-mm/20250311114420.240341-1-gwan-gyeong.mun@intel.com
[3] https://lore.kernel.org/linux-mm/d1da214c-53d3-45ac-a8b6-51821c5416e4@intel.com
[4] https://lore.kernel.org/linux-mm/4d800744-7b88-41aa-9979-b245e8bf794b@intel.com 

Harry Yoo (5):
  mm: move page table sync declarations to asm/pgalloc.h
  mm: introduce and use {pgd,p4d}_populate_kernel()
  x86/mm: define ARCH_PAGE_TABLE_SYNC_MASK and
    arch_sync_kernel_mappings()
  x86/mm: convert p*d_populate{,_init} to _kernel variants
  x86/mm: drop unnecessary calls to sync_global_pgds() and fold into its
    sole user

 arch/x86/include/asm/pgalloc.h | 22 ++++++++++++++++++++
 arch/x86/mm/init_64.c          | 37 +++++++++++++++++++---------------
 arch/x86/mm/kasan_init_64.c    |  8 ++++----
 include/asm-generic/pgalloc.h  | 30 +++++++++++++++++++++++++++
 include/linux/vmalloc.h        | 16 ---------------
 mm/kasan/init.c                | 10 ++++-----
 mm/percpu.c                    |  4 ++--
 mm/sparse-vmemmap.c            |  4 ++--
 mm/vmalloc.c                   |  1 +
 9 files changed, 87 insertions(+), 45 deletions(-)

-- 
2.43.0


