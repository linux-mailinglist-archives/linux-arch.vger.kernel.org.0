Return-Path: <linux-arch+bounces-12874-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF552B0B952
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0234A168152
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE990233728;
	Sun, 20 Jul 2025 23:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DYyPQNvj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KSmEtvcM"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331E822DFB6;
	Sun, 20 Jul 2025 23:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055009; cv=fail; b=unOOef+FIA0aUiaaMg9nDJ7fw6UNGkcL0uS1N3gQnwwzsy2k4rCsGuaE54BYzB8zMMvBBx+OCEHHd75xTOwQAMfl7p6/7FbsPB1KfxUf2G8fayBWrLraE1HV2N7AdFmFvX3r2r22JL+VrNMZSmhXAGRvyC1g8+M0PMIrdyjDR8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055009; c=relaxed/simple;
	bh=kLtviFDupo7ThMzwbIrvMyuC55ah2uTMRbA8ovBjLKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mU1rz5tlnzoOEQ2dni9WIr9CWvWRaZ1NCwRr7tivnm7R0zB/FTVk5UXyahEcxuxU7IVkxzNISWun/Ty/vDHdBXSiSY6oLqDh1/eTsr3UiHUb7nGaK9j5i/vr1TF/YFD108h+YcBgZZ5JUZZ4imZE2sd/eO6BUIwDxBzLTHqzGAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DYyPQNvj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KSmEtvcM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KM4UC8027455;
	Sun, 20 Jul 2025 23:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=yR5FAjmmrW3yfH58A5amOIOSkfS52EoZqrfy4nCU52U=; b=
	DYyPQNvjE6JwxFAYMsSRbnsuNUfxdbPURvRaCWpan4Qmk0QZAszRV8kD1C/QB+An
	6smUSsah5KTd28XKi/hKunlQB3G/NEBGGM/oj9FB7OSvRrGsFBVVulVbWDubEZhp
	MBAhSZKnlmsehpT7GNw802vmlYJqVJSnGKsvOtGzjhO+XGwZGoCy28mVlP5Me4fc
	icalvBSnovuP1U1iL839XFQ1OkCpDlmSvSD6/y3qO8M1ubSoQXtq/2dri2YWP2Kp
	W/DoX3Wgm/phcMzrN0bx3jO2Yz02IOQL2frCgahwxVe8vrzFe7g8PCXjAVMS4+sF
	QR/NfQdVyAzFdqcGpY7aXA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4805hp9hy3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KJSZro010475;
	Sun, 20 Jul 2025 23:42:32 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4801t7etnp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yGCK6U308qtRa03ee04lRv58BXViPC4IVDYdADvAaV5UmWAZfy9tcFDBUaObBseAl3w/ZAM+S7fMaFSG41/ejIGRBhC64ialMm1CRhFtcSBKEg8NKnaF7TcS6Su6Y3YgfXhypKVRVeDP76hFXgAEeT3qWAYSmUUP+CPXRc/vySsd8VFEM8oOy3S/sirwg5XcopdIxmnbBf5xbqfv1sUvnnp2b7J3V8j7Uq0irVXfTOaSUea53P2PGr8DPD31yFFha9JyTKw1b7cJ6T9UolgcGJzgF9bEpXfWeR21rBYxK9YmTubv01tUIqJxsvdVCYH0YWiO2dCBySoHaIPQuuCqOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yR5FAjmmrW3yfH58A5amOIOSkfS52EoZqrfy4nCU52U=;
 b=tuQU9Gxqbo5fZpPtlwSC5OQhk6wUhLDb/cDSLf/4eMlsjuJd/fdQXDo+3U7jCmANNGZh/cReQiDEHBONpOkIR074HVPXRPJoRcvjniOb5k5a2u54XUrIlUJ/vSia1oI7fv7fd/xK+Lub9H+YwkxrO/PsnoAe5THCDyurmE7gTf8zrJnlfr6vswM/7m69JHkPzx5ilpIsNab1RpDOfMjg/faOetxnHwZpivRan/ArjZh6CV49KqlbFlIFAIagk7wbKGTM6HVg3JEdcFqyCn2Pf81O/Vxssb3SRs8uJ+IsLBcoyPhO6EMgdyxdkiWp2Y9LAAaMDmdZpxsP1+aOsEaLlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yR5FAjmmrW3yfH58A5amOIOSkfS52EoZqrfy4nCU52U=;
 b=KSmEtvcMPF4QVujP/LPs9dJWaMyO5yOyrZUAysjmYNtBA9eELE++L64xiQuCsPLCcJ2ndkIU3N8tvqPeL+JvB4rF3iKnigmGULnSnXdguIAx4seGGZ1QuvbGiSCHGvE7w5O1mRT619xh8Kg3jrblkkXUdYG1i/lSdf1bjJIzQqg=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:29 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:28 +0000
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
        linux-mm@kvack.org, Harry Yoo <harry.yoo@oracle.com>,
        stable@vger.kernel.org
Subject: [PATCH v2 mm-hotfixes 1/5] mm: move page table sync declarations to asm/pgalloc.h
Date: Mon, 21 Jul 2025 08:41:59 +0900
Message-ID: <20250720234203.9126-2-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:100:41::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e98954-bc55-47d7-7967-08ddc7e71684
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86otFwUSwX4teont63L5HnlMlLgz0iaJ6mgzHjVpPrUGojNUboIYNCX9pOSE?=
 =?us-ascii?Q?AA3hcLL+uyPa7C2j0wkIYC/bmr/ebv2AS22S2DdJ+aLn+Y75lvljj1U2Aw8N?=
 =?us-ascii?Q?5BQ0e2d02EKpkAAX56Ck3TO4dn/aasA4lk74Yb0JO7hqiXktpGSXQw7+RH8U?=
 =?us-ascii?Q?K9P61ZGM46ZXPqUhWqvsaRLe8gGiN5HvrqNU4dM/V8QV0UVJdQYPlie8Oid2?=
 =?us-ascii?Q?p/lD0aXEBuIDpkHu9+67UW3njEhCGdfKMDgeOnIQjGJEdoUOgWzrGuMINjUj?=
 =?us-ascii?Q?ZEbtcRfLpYiYyeseF06fJAZt9adya4Ypz6F5PYQ3Ths3+9d9/rYnZw+/CIQ/?=
 =?us-ascii?Q?ce7ZgvpKIEs0fnshVN2gThthQ7ihCj+kfeTXpUr7iu25t5Dex5FGZGOFD0sz?=
 =?us-ascii?Q?O1uLnlQ5sMbTAteY5sdM58zkiDC8URblrJCwLdftu29TosvrdFZLjGVC1yfS?=
 =?us-ascii?Q?1De0XRZ2svwZ6sj2/qVTyzZ0kqcoySCLr/QuqHg9b3ZmAIgiX4dBzsQMUDHT?=
 =?us-ascii?Q?k0eacgKOLQfjCsGlVfZIAOlhFbo4IysT1S7qA+I/7q6lPkk7jQtsO4HPgR5M?=
 =?us-ascii?Q?NAUwTS9w1dolLtLyVhUWynM/8XjnE2xTzb6zADKsJ4U+/i+0q/ojauE6yqKp?=
 =?us-ascii?Q?fVN9H1CQglri9N6F63Z7XFK5Mpu9DRGVhwgSFGS2gFES9UajZUYr23A5CqxA?=
 =?us-ascii?Q?LnLk8SOvHWYZAjh3Xfcp7H2iKz+/e0mKYcZDksdaZ5N4xjxwa05j0gSCYM3/?=
 =?us-ascii?Q?CI/IFmrF/7aKQ0Zvv8WQG00f3nTz+Vt1XMVK0IS8bysNsxjQYP4PryhqRDLL?=
 =?us-ascii?Q?hOqdY9bO2d+m+iHrwFV2bHzQidXoLMrhQga1aW7ZV5w5bkCz/dIQ/Y56jR5l?=
 =?us-ascii?Q?H50Ox5zMjGr2lBVot3buXICCqJwq8VPDLQF/4gDlBb8kNKEFnBNH7SF0zp5s?=
 =?us-ascii?Q?lFdcUGAJuDMcMRNgPt2RL4WoW4MNya9zyU0qj23JZoyzfc7LJNKVHGaW7cwz?=
 =?us-ascii?Q?dk2U12JsMfzRkJ32rb3zfH4q8bByzEOncEv4Om2o+VUjngc7yBHQS6BjzRwi?=
 =?us-ascii?Q?kqQFe40dAcRnou6t69Gb3tlLj1u2YDAat0LbzbeX9VDaiFtw7NORe1DOteQw?=
 =?us-ascii?Q?T/X1FrA6BNgErUKlMd9XSl96NAaWnYR/x3vyBTinfTTlKUxmPECzNcYEKDvv?=
 =?us-ascii?Q?addMbCR7AYoBwinT+LiwO7pXen7IRX1AIE9kvZ+C/GDc1Ut3n6GgxGdOEvKj?=
 =?us-ascii?Q?ZQ1P7TnNt35Jisqm42F2r74VYb35Nl3jJaXRA9QZC1MElhtQA+wokOisMFis?=
 =?us-ascii?Q?Lsq5dkCwNyPz9QD+zzXsYNQxqjJ4K+NBmZLXIznoAjoFWPL0Iq/8V6+iygQX?=
 =?us-ascii?Q?AG5HBEs/a8fwHnsw9ZCad72re5W1yNjvGyLADXHYuAJjBNb30o56XFf8ZEbO?=
 =?us-ascii?Q?40TpvS7e6Nkb/8plRgscMDMkVO91Kbi6bzPSUYk1nN8QMNmE0D/hLA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E9v4ml4A05znrfi+X6M8i+LhyoRR0T1RHhjCiikxHOOZIWwUuSDC0mpKnFt3?=
 =?us-ascii?Q?Y9XhNQpp57rsmZEGQbZK0gdk5efuSPOf0QrT+ixqQX4TatHLvh0l21FPOVhX?=
 =?us-ascii?Q?MabFqh/shn6+R4/9LbN21BEBb5xUtOeoOlbYj6Mp16lucxmpyjHLSimE1R+X?=
 =?us-ascii?Q?d6IdY2RTajHLN3c4bwLxonS/Jmveqanv/13Z0uIKcjUSpYDOSBPmn5KuaVhK?=
 =?us-ascii?Q?hFu/OfaUuh4YWT/8qAGX1M9hmkBJZpjw87u9JMpjZdjwNeMd/Mv+jIonimVS?=
 =?us-ascii?Q?DTB3TTU4OAABGyqQNAEFbwvg9J8IyQKCISRx72hzZHNVMhK2Ng5QAOz+f9Uo?=
 =?us-ascii?Q?6q2BK1wARI/VpDtGbXVSjbKl7EEBXy1uv9YqodbajC7HY4fxr9iTqBalVDLm?=
 =?us-ascii?Q?4Wg7omFa4Pt7s9szcN6jDg6wP13OCoM5DkMqMY3hJZ0rASVB3pOO9Od4PcLZ?=
 =?us-ascii?Q?lk7xZRv0Pq5EwuQZkOqgLkG3faOoqU/MnrLjAI+vVV4DUlLJWONZg4jYpXhD?=
 =?us-ascii?Q?cx7AmqAKBbqalPdxCtWPnLcJ0S8DAx/8yTbaLTZAj9PrDjJgP+XyIUZtqAZ9?=
 =?us-ascii?Q?QL5Ci6lPVNXCJaDysoVhrAFpF4uRduZt9SVu5sK5fEOKuyj81JLnq8qdyz4s?=
 =?us-ascii?Q?4MRG5hdFaM048IGqcSVsMLbTntx3ZYyAPUH8u43yoqf6YK2t0fxACVAvY8Tm?=
 =?us-ascii?Q?Nc9zlEIghlII7wdtVqNXQZk4udUmm+sPY+n3TqQJxllhrtO9QMxiZs1T7FHW?=
 =?us-ascii?Q?MvkbQufaPmosYA/lfsovlOqABg6hQ1gKQEZiH0lE0uL6N69ev1lTzfnUJiJO?=
 =?us-ascii?Q?V59bmvKyya43YUpVGdXtDuOqX+9Ra/rqmEKDnr/3Y5sB/jKBHEAP3IHHnKtG?=
 =?us-ascii?Q?KPYow901cw+xti/ChOM7agx12KaPJkyhd2yJ5wd7oyo4yFMFWr5qt4H/6PaL?=
 =?us-ascii?Q?3pSOFOmuvH+y6NUTmX+9iuDCtKwLeXWkF+pAXwuYqpLMfHCFssHeTZLOW5JT?=
 =?us-ascii?Q?an0QJ+mWxtwf0idEpg4701XPigGLUorWMMcTSDRSUpwQKVuKK3n8bFaGxlQ7?=
 =?us-ascii?Q?SLiukvj84zRHZ+LryluTmqUPpA3sZHFyZ6c1Sxw/p32T2j760fBIz12hHliH?=
 =?us-ascii?Q?EXW/D/Em/CkBpMLc92vnudgD04hVAtscotBqkxyuKo03Fe4+/rArLiEN62rU?=
 =?us-ascii?Q?cefHqv19MZzeaA6ysPbGAXT1gtykooyd4MBNg1VHjUgwKhIQpI3u9MEL19wb?=
 =?us-ascii?Q?G0v/co2rQyR24X2kwN2ZsdSBMiL/A7NaYaUoZK/gts09Jf3x6nk6/GySSZdY?=
 =?us-ascii?Q?8zYu6hkRfh7HN8o6d96UQAOUg+JSnmA8aZDD1T3wbg0TRZWw+3Ik49Icz5JC?=
 =?us-ascii?Q?td20Fir7bCnRQBKWf3pagWh0OL3/eQqWCW/AI1R9QBZjrcpbIBI3UfICPYJy?=
 =?us-ascii?Q?odM+hmxbJN8/ZRAEiQHDTLSDbi0yRqhBXSvwBLSP3qbwLYGDBjH9bs6JcM9D?=
 =?us-ascii?Q?ATJFEGq0RS7khST1Lem1PgHtTU1IgIEsKQ8SLGOS2kqEgfIlROcq5sS2/Mur?=
 =?us-ascii?Q?kF2XgBMN6xjIhtafxePRdFIMNMj9JlXPV+tRihix?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5mnNdbVI4ThWnT4aCEd+5r6Po7NGtPt4pmXFLYHqTC7pVY4ByJcuCxEyPBBNwwW4yNOZd7kukNS3s3A56+0J+xLD0wToKM7OaYYyqs20kvYwVwbY8Artcb1WtUj82a5zdWFHk/IGslupQrzdpHFsqQCC3ujJHqgrhXrhmYrzkPrFT04ycKJ+/ISUa9TupHJMLrcZ6Whyyhz4sAQvD2p7rtycGJ6q+MyKoxuYZQIlA6WRd6XcztTVa5aV9PhEheIUntEfBsxTiOzGuU4P6+N1RVvoNVp03q5ckGItkMc1TK7fTTRwrZmqrNZnRdXsHsU3b4DRMpZZw7RyWF3DINHQvve1Ue2Z0gt9TwREc+MSd2aFZVMI6HRW8ozYCQK2o4IbEv5rSXbzRRWotUNvQks6P1v5LVQ06e6skM1Wgt+sZTd7jGgd3jBX3MQ/x6rgEwkRDzL2qVb1C0QUEctZlovue9zYUBU+oNbVBnHN31UCbT2zI8iOhwiPrIYY36Tm3RgbX2uSC52WhCw+SmjQmr2HSKQLalfqPalXRcShtlhid2iqPIfRm9sPbBiVDo/FGR6I1SxrafLFGyGQh6w+ieI6RJaivA+aprAX7WWpDotu9NY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e98954-bc55-47d7-7967-08ddc7e71684
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:28.8175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 14sXHDurKgYcnIWB2YVfjUaEc0cADzocUqUhcU55IKWZwdOpbgkefrtXoqxu//eMc+4C6gznnzm0YFrxCF24vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Proofpoint-ORIG-GUID: NIyt4rs4EQvP8GYYq0yT1xcRpLf0l3pa
X-Authority-Analysis: v=2.4 cv=YY+95xRf c=1 sm=1 tr=0 ts=687d7ee9 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=GhCPV-VjlYWqgBCm5TUA:9
X-Proofpoint-GUID: NIyt4rs4EQvP8GYYq0yT1xcRpLf0l3pa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfX3LgFqrux1OP4
 w5DLVc51ADHmbMGufAbk9xutgOKvYC6oZViVZp9ma7gb7IrnpRx7x2fs2xu6zZDQkdsbATrvQsB
 B0j3DkEcyngidDjbQ7CPHBOLptXLtn+qrAxR6OR1U7BQ9TubGdy439Rvcs9ed+BCY2V7oCdXWKm
 MkKhAHgZ7FJ4jkdOFGclw32N51SdqB75axcmcSyO2v891x3sEwXLNuLHZ6x4ik5Jx4B9dKFToWn
 odzwL4nULrXJfkMeetloS10BTTwU5qzJxxfks0zOV0Eq2XonXp34oLHJ2d+4g8lrUNU1UnAe2Ik
 6GhN6N/+4S2N2QjvZbHM58rHfAAN31bBes2r/iFHMnCvtbySEzcImAlJL5xcNo1cvwGS5/wLUQ9
 pLiidtf+keku9uaH4EBkxQbhDOnePa+HwHJ4zZvWhFNCkg0H+aeZq6h664hjm8jzuwah/YB5

Move ARCH_PAGE_TABLE_SYNC_MASK and arch_sync_kernel_mappings() to
asm/pgalloc.h so that they can be used outside of vmalloc and ioremap.

Cc: stable@vger.kernel.org
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/asm-generic/pgalloc.h | 16 ++++++++++++++++
 include/linux/vmalloc.h       | 16 ----------------
 mm/vmalloc.c                  |  1 +
 3 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 3c8ec3bfea44..7ff5d7ca4cd6 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -296,6 +296,22 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 }
 #endif
 
+/*
+ * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
+ * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
+ * needs to be called.
+ */
+#ifndef ARCH_PAGE_TABLE_SYNC_MASK
+#define ARCH_PAGE_TABLE_SYNC_MASK 0
+#endif
+
+/*
+ * There is no default implementation for arch_sync_kernel_mappings(). It is
+ * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
+ * is 0.
+ */
+void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index fdc9aeb74a44..2759dac6be44 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -219,22 +219,6 @@ extern int remap_vmalloc_range(struct vm_area_struct *vma, void *addr,
 int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
 		     struct page **pages, unsigned int page_shift);
 
-/*
- * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
- */
-#ifndef ARCH_PAGE_TABLE_SYNC_MASK
-#define ARCH_PAGE_TABLE_SYNC_MASK 0
-#endif
-
-/*
- * There is no default implementation for arch_sync_kernel_mappings(). It is
- * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
- * is 0.
- */
-void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
-
 /*
  *	Lowlevel-APIs (not for driver use!)
  */
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 6dbcdceecae1..37d4a2783246 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -42,6 +42,7 @@
 #include <linux/sched/mm.h>
 #include <asm/tlbflush.h>
 #include <asm/shmparam.h>
+#include <asm/pgalloc.h>
 #include <linux/page_owner.h>
 
 #define CREATE_TRACE_POINTS
-- 
2.43.0


