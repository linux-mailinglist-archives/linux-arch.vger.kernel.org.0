Return-Path: <linux-arch+bounces-13115-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53CE1B205C2
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 12:38:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1439118A27B4
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 10:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC3C922A80D;
	Mon, 11 Aug 2025 10:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Op/ksseA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Da5kvDHM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4772A22FF2D;
	Mon, 11 Aug 2025 10:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908670; cv=fail; b=Qbf4hKws8DqfbUN5OuPMSzxy4pD+6jDhNTao9KOu8OYN+JVdchPvRvxcH1Vb5SWgotlCS90Mu8vwATePtEq31ltPVLfmka68ngvEc08/+jtJEhSPaiqML7kwrU/+rhFpsCCeRuilDhFa2MOH4OIlZ2W/wXkj0IFYlnNNKDwJGZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908670; c=relaxed/simple;
	bh=ex8l4uYARyUo3zkBqJGglmgjkKVfI+5abtgo/afuS6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mvAt4McbZZvwKTD05osuqgNNpuA/zxu1vVkfTFdRahr5JI5llMCVCLsGq7XUEjFnwBXGgscNquNsHnEsL5Vt2TTTIXNpK0r0P3z04uLC51l9MJdtg59azL06sx65/9+dxTYee9fbrXgNGIzLVlHaj2F3vGK0enO4EWuzl30efsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Op/ksseA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Da5kvDHM; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uBm1007805;
	Mon, 11 Aug 2025 10:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=iRv2FrN0HxEbXj/+Dt
	3jbJbxzyad+1K38mfknWwvmS4=; b=Op/ksseAsklhs9EsjHBVduehkNe0piphH/
	2vN/tONa9HeHruAnagg5HBHdvVXgogytc5Z4uKAzCitrfDxDicJ/jlaMGj9Gz2ok
	KXXGBBFtOrdPbyoCqfYThf1OW/mG0+N0ElcoEeUHNCVtPgpCqSNcrtthWkKWKPwo
	PGP7oagKW2ZTkjcbplnegoICDoMsxMhxyutw6Lx04nmqy4r7+bXohABMmTZ2hB7U
	mdj0YrhWyvdAjorvrjegxFdiIfaIYh5lAZEI77FWnHNOwdJx5nv6qJsvRCrneQR2
	ZqMvLGlzmRzltoDTrYqXLNvTHevQnuvjI/GsNaa30PfBIxlD2IOQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw8ea70c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 10:37:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57B8jqAw038576;
	Mon, 11 Aug 2025 10:37:01 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2079.outbound.protection.outlook.com [40.107.212.79])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsf0aeb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 10:37:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cYCHISTkoB9AuTjLcVAA+WYXLobroI7T9fTglbZOk7djSjrAE3Yt0nNIFyAPJFKDtO5B3/XgCMEoURO+ZeYvTMxL/RSQyPF++7s+8JvySDvf4j4/xxoRHTHYz3uuVidLpkf4BDQ7iXVpijFqmiQXio7SlcAhTuimAVmoDvhjVAapowx2EJaNnlHKAYx6e45eG0kk7L0s8W4nxQqYp+b64+SaFH/EeEFzHRqTJqSPTCR9g5VVy+HzW7ekRLcLTu+BxPqXpNLmIgBnwd2yTTBgAT6RcMOe9+uNa2GCHFV22qxo5d45NewaMY1zI1Gxh6ZxxdvLoQjQ6LJ2UpVwAjN4BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iRv2FrN0HxEbXj/+Dt3jbJbxzyad+1K38mfknWwvmS4=;
 b=Lw1+CorsvfhN9xFmoH+2vMfQiPmrCm91bIPxE0XSk2dU4O5tj+SdzZALPpTecaLxKwdpMow8Zt7WiGzSQfeWNtin4FE2YC7Kqv1nBQeqXYhM1Mz6T5FZWJ8wDGnDeYyav1K7LS8Iwkyh9g+1O+RoN1c3C6dDRjz+r6YGDGTjQ52DQNHIttx+ND2iqAHiIq8Lr76N0T8ggeGDoa4EgO001+uIsc45M4MZZiv0oOkVyeIIPaREl5e5WPXXNIP91Ha9ZvUnbK8D0kwhCSDWws696PvmOs4FIbkP+pv6duXfDLKtW1l1bG2BGUyU0CRdDqENAtEJ6fwBXzQ5ryFBzneh7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iRv2FrN0HxEbXj/+Dt3jbJbxzyad+1K38mfknWwvmS4=;
 b=Da5kvDHMtb7vls5alLMabGdQe/1HOZgri+zCZL2F2ufrbeLmif+QyQqXBZ2xPmJ35wqoaSyWJ99SqqLPGqMMi7/Z/PvkqRoBVKUPX8PqgTSPoxwJoMdeeCDX8Mp6aPx2BCLMAEQk420IpQ7XDNIxh0guF1soF2YmkcC3IRPbQnA=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CY5PR10MB6213.namprd10.prod.outlook.com (2603:10b6:930:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 10:36:58 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 10:36:58 +0000
Date: Mon, 11 Aug 2025 19:36:46 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Dennis Zhou <dennis@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Tejun Heo <tj@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Christoph Lameter <cl@gentwo.org>,
        David Hildenbrand <david@redhat.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "H. Peter Anvin" <hpa@zytor.com>, kasan-dev@googlegroups.com,
        Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Thomas Huth <thuth@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>, Michal Hocko <mhocko@suse.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        "Kirill A. Shutemov" <kas@kernel.org>,
        Oscar Salvador <osalvador@suse.de>, Jane Chu <jane.chu@oracle.com>,
        Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joerg Roedel <joro@8bytes.org>, Alistair Popple <apopple@nvidia.com>,
        Joao Martins <joao.m.martins@oracle.com>, linux-arch@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V4 mm-hotfixes 2/3] mm: introduce and use
 {pgd,p4d}_populate_kernel()
Message-ID: <aJnHvvb-lViNA5EQ@hyeyoo>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
 <1e8ca159-bf4a-47ab-b965-c7e30ad51b28@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e8ca159-bf4a-47ab-b965-c7e30ad51b28@lucifer.local>
X-ClientProxiedBy: SL2P216CA0177.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1b::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CY5PR10MB6213:EE_
X-MS-Office365-Filtering-Correlation-Id: fdb02414-1f00-487b-d75a-08ddd8c2ff9a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ygTA3Oiszu4QnQT+xFmGqzSLrUreNKqBeJsKHu1MNEdtojekcVWtxAO5s7vG?=
 =?us-ascii?Q?dUDkReKsg7DjGzWSHf/IopFhoYCvyyhU7NK3TwRBsZqmLranwUdehL5xC1wT?=
 =?us-ascii?Q?yqr3SYKjYByqU9CUowUs7V1O7foneIBug0Xzr+qC9ZWbhJFqsUU1ciJJl+Ab?=
 =?us-ascii?Q?E/Le1GmQJbm26WHGnFoI4ZmE7MqhU291VlyZpTp33YSnDW7YkoZDEWkYvc2u?=
 =?us-ascii?Q?nqq2Ev/6KFvMpyJ1vKeW45V5eNg4PaGfjwRmcWkAiTk7bsdp3YjZc/QEJJam?=
 =?us-ascii?Q?KxdgqvMp0SwKRP/etEV05ILAfFmScsJBSuMbQEKUddhvDkeapnUoZg59lKEp?=
 =?us-ascii?Q?GVu3bOAsoRjG1l1onuz0Nj38z6yiEtihX/s/kLBu5HJPwSpiM2RH49j+73e7?=
 =?us-ascii?Q?lRAkHVv3ZbVCQ3bkIRXUBzGXhB+eHBehp5Vc8cPWsKoIUL54GMZ8qqYoKor1?=
 =?us-ascii?Q?WVe6LXpwENBni8ebO4tGSHF03hkTO31LxIZDX0Zu0IBZoXeWEDUdFJgfGSXr?=
 =?us-ascii?Q?Gj8UV/f3sFvZbdKxxA2VsYNH9eS1cbH668Rawer8/vX14vHoi0zgV6Il+e+S?=
 =?us-ascii?Q?t6NG4ELi+kxYeo+g2JdGG3O5UtK4WLRyaJ/xwcUGpQlTUzuEgS1XAlxKXvwD?=
 =?us-ascii?Q?FYL4vS5LpdSbEFov1IysX43MQTsuM5XFopR+yAUmw9xVln4l2rw/jfGqrEre?=
 =?us-ascii?Q?VOIlkFheOBXcpE9YcWoUG1J34PmHO7XLth4oqf//sqhs9aLZ4twkQ0TtTQK/?=
 =?us-ascii?Q?RGBjeO5I2BzbWGIxhePTsxhMRJXiKyYQqU9eODGtyTKNF0/AVYrxz42/F2v6?=
 =?us-ascii?Q?W8Lc//g7mxyjK6n55gLjjIpfXTUvZPAFMwCB40GRW+hcF1NFoVs/oQ3MczMb?=
 =?us-ascii?Q?Wz+K6DfEkyJmRYNEl3kGnkxkVfsypIxmgrgp+XPJxb8l8YgFbaMWGsnRHAfH?=
 =?us-ascii?Q?Q/sybooK3dvGHxlH9evMpt4dd9LuK2X3C1EPHEiBRjjZQGK9MaW3q1M+bmci?=
 =?us-ascii?Q?HKaXnrrxkwQPp3UFVN8UdAk8BogZ80u7x40BUXT73Q5izd5cVQBk1KH3yG70?=
 =?us-ascii?Q?wz/oF6PrhFWz58tlEm/5nn7szUfGYBJjaY8TQRSqSu8rQvxCGiDYpzHUZUWH?=
 =?us-ascii?Q?tnEtYYQRJt8Z9GgDL2uYo0f1YN9fGf0CUXhXzf07/QZQ2IDUReCJcvwrrXYn?=
 =?us-ascii?Q?34UfNN/Vedy/cr5dsHIuot4ZTUh6p8UFLvxbVQrHVYIv7/1+QUd1oVkmJRC8?=
 =?us-ascii?Q?2zAGOb3vU2Cw+DejcCJrAhQOb9gTkoo836EUNRGQ71GfaQsOTH8yzMNOaOnZ?=
 =?us-ascii?Q?2yQ3onqoV+iHCnbJPgJRo9OK93WGtXB3t/g3Y5EBK+/PHdapHEEW9ZeUPWph?=
 =?us-ascii?Q?D2cG2OYGl7IKn19Ej6BfZqnmrEfS48FvbPkPXAhjgchwk/vI2Aysa8PazRlO?=
 =?us-ascii?Q?adZr0tChFdU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ISRtkGbC4gS9vRvJVgPiMCijYG4CW/RBhQrgpjfc4mgRw/k6uL9gywPh2cg1?=
 =?us-ascii?Q?K6BzOIAjRitmPw1noCZdRgjj51WEFdXlJ87oSUMw3fs27wosoOGiLV358Ty7?=
 =?us-ascii?Q?WDDoHvL4tkTJrTMhKhnxffs5WCQXZl7wTPaYEYfzfgGsrZ+cWAgCJuecsUeR?=
 =?us-ascii?Q?VN+T3TrvVSUdCFxHONq5klmZGq2eR6OvsFWAlF+n9NLsMC+ZzGSfuAM+vZvw?=
 =?us-ascii?Q?mb2VS1CO7MGts02ntfEI26QKnGImKf31nHu36UIjkNhS71kUF1YIdt3Lcun4?=
 =?us-ascii?Q?ct5C3h5hGe+c6EJdBBaPfUH9ZSpeqhnRQutaMgz07bQqvA0kjEsCNO57ORD1?=
 =?us-ascii?Q?xwUqj4mJsUTouH7B1T9H/sE6YGvkK2Z8g5RiUDRnnsUV5Xj43KrP47ECEy1P?=
 =?us-ascii?Q?clWs45XNC0q52cZr2yF5cz6ebTsRWRWxpu0fwZL7KQSfjBhO9nJ2sm9frDPE?=
 =?us-ascii?Q?dJxCUSJ6x2m+NWg+dpH/UJU/iufPhnZI94KET+yP1Ua/EzZqhNjy+8PoImoN?=
 =?us-ascii?Q?gslHoQz50FQfQ7T9SUyhvfxwdIclRHj0iSHA/7OAdb5QFn3vh0y5ag983kKb?=
 =?us-ascii?Q?JBRlF10WRlr4Iak1fuIUPD0ovu4Hk+bn3sBSYtpzaynYpaM6b+yJcpU2mMvg?=
 =?us-ascii?Q?ACRVR4NsZnA6cXHe5u+Eh5/4ztP6JGKQa4aaUEgNEcxVzpgZyvkjYZRvs5mR?=
 =?us-ascii?Q?lwVuIN17sZmiyOBf8ezq9XeDUxrtBp0dau4cd832263R5ILIcuLTt9mk7JjN?=
 =?us-ascii?Q?HjRQE6Rs4WGg5JUdwysCyQbHF/8Y265apkyr3lYElC+EKQRI+YDlyXjvOjVS?=
 =?us-ascii?Q?FkyjmiItNDnHDh572Ag1/4rqU5T1CRPsU4p1QIU633+9Pa5iyV/rjBVv1fH9?=
 =?us-ascii?Q?gdyfA0VTG4M8gpEaBWiNCvakS/7VfQh8v95j4gCOd3lCGIQS5X/KJud8P5Od?=
 =?us-ascii?Q?8FBVVFn8csgkgI+mJzTnC4e+UukmDsQdBy5POI9R4V7Aaofw/ZiIxAhpIJlX?=
 =?us-ascii?Q?hCOMintWtqK63jR4CFfmWgH9GG8jgOPPRa0JtqQeUzFPNKNIo7t7+egoRE1N?=
 =?us-ascii?Q?g5YVyEAcE311tolV+j5GIBXcoJXonqi33noxtbyuGxroQetsCyz6UkGdy4iW?=
 =?us-ascii?Q?UQCG7BrobgLuT2mrHD5vmhF0kgl5vq17yzJe3XxHaGufhs9TOFsNd/3Wrd7r?=
 =?us-ascii?Q?isoYIE37EjOx2Xyk0Px3zlVWvPieVIOPW6CyQHxEqCtCOd72B/y1ESJf9wTR?=
 =?us-ascii?Q?LNfrPQtm5Kq++q5AJ6f7uV+x9EwLZ/57vsOFJE1U1kzp49yD8U+2LUoAKfUq?=
 =?us-ascii?Q?bhEgxsBatECLkS9hg4kuhQVJSKqC2dKA8KGscIPuxkq49hWQHz4fEg5LuToq?=
 =?us-ascii?Q?TugRnBWtGzBDrfEY+30fabNRGiECPujvRj7R1ed0yV+HljGlZagtLY83xaAS?=
 =?us-ascii?Q?tIl1TE7ZZ7iHItqupsteoxe7dtPT5p94fBdzUR2uKqqcSXkrQqk1MRgUv6ZC?=
 =?us-ascii?Q?4d4dcnLQ3SBWsBbitqjlIaKnj6rU3DoM9FRVumFJzvlw8i+huQQ8yT3zrFA9?=
 =?us-ascii?Q?qrSOmz9khUAO6xbWW4RToHc0cfmiY+hqPUUZmekK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hhx9cdyUPTK/QokzRE+OsjK+Ss9MuscuNWFoTLcdTe3ruI9X4GVhJbTgXQ1PNIqcnMhAKEWH9QNVCcYC10ve+ySR3+rOE8GbT946vWC124y4ArTVaKJayDrjL4U1H32jBMLCLfeuGZ8VYbmM/SnqimEk5PP83LaLxOY8OG+kRsbCM6uh8D6mnDNyMfknYxt2dF+ZKiePj5HJf0OMMqKGZ8kZqw9Y+CrkMGUkREJVUzVeupMrClWsM9b7PZiTUxMo90VEWkGQjBIZ3dmYtbHIg+PZ4PXfVHcQj1ogZYl1sinNWncyUiUe9IAsgNtccmXSCzJfuq4NSDSy2XwqLanGLqB44qZtwwXs/RHh3eADvITMT5w83+Fic82x8e2o6kxsmYsToewr2NTSS4w3JQPpK9sI54iwiNWvVMvbSRVuQRr2Gl3ms97M/29FfN6LaoIQ253GcZU7+v8hFzmRTMIS8oySX3jb+J+CBwH4Wl47Frr9eghh7FxoTkylu4AaTrq1pkPNOWh+KdJfK4MiYmHUrOn1tnYkDFP3j3PGaRxtoEDoUjDo+xR3t0lScXlFh/dn5IJNVK8bw3auF+sQDeVTJ6iPC3ffeV8c/dFz5/7KuNc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdb02414-1f00-487b-d75a-08ddd8c2ff9a
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 10:36:58.4619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iz3xPhfBPAWJuKkA+Agk0P6LDTUDdk249g6yyjoI0wtTel3+bU/3u2P6rbuIwV7BHyOK2dqm/fkPxxEeZKX0UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6213
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_01,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508110070
X-Proofpoint-GUID: ZYL2c7MsO63dt0QeoQgRyfHslMbvJSDs
X-Proofpoint-ORIG-GUID: ZYL2c7MsO63dt0QeoQgRyfHslMbvJSDs
X-Authority-Analysis: v=2.4 cv=ePQTjGp1 c=1 sm=1 tr=0 ts=6899c7ce b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=2hYKtvtIEQXRq3MUDR4A:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12070
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA3MCBTYWx0ZWRfX+8UCe5yA/iX8
 ECkILkLCxKaa0pXC7rhXutt4yBTdxLFZ2hw0bnFDsu2iwxdPfinefghQ9gLWDk1VlbGhf8xzehg
 0QqJO2dTlTcolDzxuFAuDZwUOrSS3J7up0lgvqmPUF9Qucap9OtpbNDfQBdFO+cbORd9nDDeOaR
 6XH78rMH0XXT50j+np+bmjbevUkR1TCMMtEmdcWryhK76sm5g8krPg1LFaKEVkgU+ssxi49DEnp
 BdBzURzq9eESCKxOnSAfTMG38syrVxcYDkwTDKHJ/amJblM9MXrlDyCqmI/foRAm+L5r+cQ8ACD
 lowT9SEgm3oCKWaJvwIQ/E/4N+vdX9esL9TFyphLrS/Kg41Dbn206KqBWyY4A3j363dlGxjXmou
 M/A3U74gkLU6C3/8re8/znPBxWVcxyVonMDs20DzuY0gW6BQmHAzFTjFU586osIQ3jnEiyo7

On Mon, Aug 11, 2025 at 10:10:58AM +0100, Lorenzo Stoakes wrote:
> On Mon, Aug 11, 2025 at 02:34:19PM +0900, Harry Yoo wrote:
> > Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> > populating PGD and P4D entries for the kernel address space.
> > These helpers ensure proper synchronization of page tables when
> > updating the kernel portion of top-level page tables.
> >
> > Until now, the kernel has relied on each architecture to handle
> > synchronization of top-level page tables in an ad-hoc manner.
> > For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> > direct mapping and vmemmap mapping changes").
> >
> > However, this approach has proven fragile for following reasons:
> >
> >   1) It is easy to forget to perform the necessary page table
> >      synchronization when introducing new changes.
> >      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
> >      savings for compound devmaps") overlooked the need to synchronize
> >      page tables for the vmemmap area.
> >
> >   2) It is also easy to overlook that the vmemmap and direct mapping areas
> >      must not be accessed before explicit page table synchronization.
> >      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
> >      sub-pmd ranges")) caused crashes by accessing the vmemmap area
> >      before calling sync_global_pgds().
> >
> > To address this, as suggested by Dave Hansen, introduce _kernel() variants
> > of the page table population helpers, which invoke architecture-specific
> > hooks to properly synchronize page tables. These are introduced in a new
> > header file, include/linux/pgalloc.h, so they can be called from common code.
> >
> > They reuse existing infrastructure for vmalloc and ioremap.
> > Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> > and the actual synchronization is performed by arch_sync_kernel_mappings().
> >
> > This change currently targets only x86_64, so only PGD and P4D level
> > helpers are introduced. In theory, PUD and PMD level helpers can be added
> > later if needed by other architectures.
> >
> > Currently this is a no-op, since no architecture sets
> > PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> >
> > Cc: <stable@vger.kernel.org>
> > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
> > ---
> >  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
> 
> Could we put this in the correct place in MAINTAINERS please?

Definitely yes!

Since this series will be backported to about five -stable kernels
(v5.13.x and later), I will add that as part of a follow-up series
that is not intended for backporting.

Does that sound okay?

> I think MEMORY MANAGEMENT - CORE is correct, given the below file is there.

Thanks for confirming that!

-- 
Cheers,
Harry / Hyeonggon

