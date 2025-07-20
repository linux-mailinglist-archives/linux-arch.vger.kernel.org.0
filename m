Return-Path: <linux-arch+bounces-12873-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C788B0B94F
	for <lists+linux-arch@lfdr.de>; Mon, 21 Jul 2025 01:43:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8EE143AD921
	for <lists+linux-arch@lfdr.de>; Sun, 20 Jul 2025 23:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A52D22FE08;
	Sun, 20 Jul 2025 23:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aoFWMhIr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DT+M0TvP"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588D22B5A5;
	Sun, 20 Jul 2025 23:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753055008; cv=fail; b=Z+PLMy7G/xxDbebXkuWNGvaZ+ON9fVO0+KZjyAClxQcHE/8MtphMLRFk5ebgSvz+/Qd6wSX9jOz1cx37mkeTHYUMDO9vz7YZZnlN1Tj9YFi9S1ZP8taoF8XxVpRv1JL6yMSzdeFACgiQpAxw0QapR5P1rHfwRzDfjpiZHHRd/EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753055008; c=relaxed/simple;
	bh=KSna9STvoWitvY+wSSY4zPu25Cs7geWioy0PI6zdigs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dEsaO9cZNH4seBcEm1aeLImgfqmS02SnEsiBT1ndzMnnJAepg9i6k4N484K/Gx4vXofYYendv19c1YDsEIVycSLX69drwOxNlEe+69UorsFbrIXfInt9wa4RYhyOSOZO2CSBfjnsoEFWzmyzOv/duNzjX/sZYTqIxQA3ygtDkn4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aoFWMhIr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DT+M0TvP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56KNcjwm000756;
	Sun, 20 Jul 2025 23:42:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=6OLCAaSp5iQ0AhGcMbXgkquD35l6QkEqnc9iLyhc060=; b=
	aoFWMhIryfHj9GIjBQJTOfW8eShthIgQpZnuvcvabQhA4qqMo0vDYu3gYNrAlHjE
	uP1ue8Q36/jfjijJDEke4ROHCBOFLuFZEaTKctIqKJpbIbW7wbAa73jZwlGZoahG
	cJgGhkMGZCneiapldfJ0UTMq+XYrwQNSthPhEHSGWBwj1P+k6XjlWBzSlCtx4Kvk
	G5hfULO9oHjqjnD35WSd/PP00C33xfHbFefGzx2JpkYkaqgZd3VSmelOpIDmcYDm
	keSxK0roGFaLdBjQ7gnULuhn/WlPGzvnrGLAx+4YyJlvY1lFR3BJPC1CuvITRUbD
	cOwXJr1aOT3yKUKzgVmfGA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 480576hhru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56KN59O3031545;
	Sun, 20 Jul 2025 23:42:35 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tdpj9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Jul 2025 23:42:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SpH1zs2qXHS+t22nULQcfQrFo4Szo+TwSrknJJbWvcvXHUExISp8Av9WCLVA1qrPBraA3pcLuWNEyB6zCQjWlcyXBseKK9/T8NA1p3pSfJxYsHYkDwSkJhkcomJm9OjXU/9smgryQaGLAfRAuNt0ZYkFA5pKjLZ5DIx/07W8pvIc2qaqRGgvLZgojwMQwP+kx8RdHKOm24REesUAmX8WbirqlvyS59AnfIzuIXXt5IdIhHkHFAduQFvpCZ9e+1qPMtS8xA9D5PV11BONm6O5U9fVYsdWvlPMlM7tKcqCZYvDWpWuE0TfJNeBsD8PidJH3j0VRZId4I1U4uL/6Wy+xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6OLCAaSp5iQ0AhGcMbXgkquD35l6QkEqnc9iLyhc060=;
 b=rIZ1XkyHFH9IEX/a9ZuqY+rR/j8ssy9BvGbrf7anGppWx8In1XV6QstH5O6icZ//mLPWhvO9ND1CAYPPmcj7CvE3JWvKOngAJrH/7tlkf5iz9HxD+6gSXUqT0YLPEdQ4xm9HOn+EvUpcIg56WXtJwxc6wGLuoqHr8oENqnhxD8TIrI+JkAV1/h0Wl+c2Cy7w7P44PARjer4iYgGv2f1nPruq8nSzoFebBqky3gaBASEvAMxMukH632UVliGn4vrBTTa2YpiWPhtAz1ZlAA5vvwj7RBEn2ovny237JudLZjChAzK2uwnFujkPsWetQ1oZDdwgrdSl0Su8EZ46REx8hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6OLCAaSp5iQ0AhGcMbXgkquD35l6QkEqnc9iLyhc060=;
 b=DT+M0TvP0y0EhpP+mOjcmT9kBIG7qqdq4N+jkQbieHLxQx9BYv/+JsH40UJ7qfonzw9HM5SBTlzS56Vkj09PfBVno0+epTi/IHZpr2K8ixDPv/CtuQMqJseCKCRDJWL1Xbk+042UjrpXL7DHp2lQRD9W1toucVtE3cCmzf72VC0=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by MW4PR10MB6395.namprd10.prod.outlook.com (2603:10b6:303:1ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Sun, 20 Jul
 2025 23:42:32 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8943.028; Sun, 20 Jul 2025
 23:42:32 +0000
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
Subject: [PATCH v2 mm-hotfixes 2/5] mm: introduce and use {pgd,p4d}_populate_kernel()
Date: Mon, 21 Jul 2025 08:42:00 +0900
Message-ID: <20250720234203.9126-3-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250720234203.9126-1-harry.yoo@oracle.com>
References: <20250720234203.9126-1-harry.yoo@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0196.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c3::6) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|MW4PR10MB6395:EE_
X-MS-Office365-Filtering-Correlation-Id: ce56369d-6b5a-40c6-d61f-08ddc7e71894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nneGnqr/NLzJbxdH6FS56qRkW/y8RmZE2V8pq+DmF4r1xBFqMZl2KZZvk+aZ?=
 =?us-ascii?Q?zqFB4y+35xN40o6qSlWlASb8eOU51/iXJLWJoWr0NSMeSGNw5QKuKhWFmwv9?=
 =?us-ascii?Q?JNJ6zYem6DUlqHERQlTECqrKSK40hsqqWuP/b/hG8iPabC01ijsl0bQYFllF?=
 =?us-ascii?Q?yE488TJclDN/7qEkASd/Q4xVXDgexam3nNi4BDfwK2slEE3hCnND0mU/xsjm?=
 =?us-ascii?Q?jFj799Oo4nFIHaFsciZ3vEU/frn50SVqDxH+3z8mQeOE4UGGlqY0CSo8ClLH?=
 =?us-ascii?Q?gw/wIlEyUM5A0JcYz2n9eoJ7zu8Aujh8+dqSMrPPXcRCP29xXSCt/eE8gHFk?=
 =?us-ascii?Q?+PyD1Qv1krVKRuUmweMZpOPcuz0cyjxqbnQgsnRzuiZPI61Y1wlHKF0yVs7r?=
 =?us-ascii?Q?Zbr+B4OvkWY3slgjpOEqA8NfbSkLjtL3jbvH/NFdrsUHHQLc8rnRP3FV5XW2?=
 =?us-ascii?Q?X0v4Bz+A3XItJrzZeyVsLAc/7snUVt7yyMe4oww04nq1r61J69QdVPdLg4q2?=
 =?us-ascii?Q?c9nkgFjK2s9jJAcqfmru/hMBxzOkjwiKW7V0sJPkdUXEGcKEmQQuxhkqoYph?=
 =?us-ascii?Q?Rf9DFNlmZXtal0FYS0RUr4fW3FiD8kIQyZjNQI3UZdHDsyZyWOfqu6yj+84W?=
 =?us-ascii?Q?Wxd0IOpGBCiDQv6NdO06RHuj74YAfwtbf62PnH3pCN55OEEtHG0FLZ9X3dJ7?=
 =?us-ascii?Q?tqZ4JslWlesmLH1fVj+YUKX9Y4lzHYFOWlTi3vv81qmOtjKxfrAAHm1MDw9m?=
 =?us-ascii?Q?Hj0qDWUtip7MAmLSnsE9QtwehilT1V+ThjM53iEViCF9etARkAdb/Me6smG8?=
 =?us-ascii?Q?9lxs79w9GWIvzHhkcTwQZR2dKDSZVbH6o7yEgHHZUvxcQEQe8CRAEgJuoosn?=
 =?us-ascii?Q?TMJnzgIu6GXs587VlnR6UlwGRtJnpDDAXw97FnXZoF+JVhMvQrSLTkmdD9SH?=
 =?us-ascii?Q?DcbJ2AvJl6IIZg+cp51v7bqLAxqrHVdFbuHizEsaxvLLWeGwOv0rvF8bIYrn?=
 =?us-ascii?Q?eKue0ZjogtPkSE9VOBI1h67GH+N7nTcFCwmDFssE2f2WjeREPT31o+5j7TqT?=
 =?us-ascii?Q?P2njvbLLa8dlS5RLKIKYU1QiCqLOgFn0oKUI1mGGwF7o3tTmD+p9VF0sLQDN?=
 =?us-ascii?Q?VROkXxCxevDveQhBPELfkQdirnb8fC/zqOkviEiMQ/q2hgwfVEF/qe6i+nWG?=
 =?us-ascii?Q?90ojjnB4wAukubpoUa/D9R7iVJQWVKSVMHdjx6ZwMDHfXVByEgqwcwmUP4gB?=
 =?us-ascii?Q?02nT0zpFrqS19LKnirUeT+iRJlLdXsglCK20ieUEKC/5eMJ+JevX2M4uIxy7?=
 =?us-ascii?Q?wrXwWpChitU2Ed7v91Tn2qUJL722Mah4gIaayWCei0ZgajQyzkgf1Ws/9Gf6?=
 =?us-ascii?Q?whjuv3Pw1tcci81Ra6UwtJa8Aj1p3LxacbmIyz1KiLHLVdgRv8JBCeU2VC13?=
 =?us-ascii?Q?kl6Q6HIIXUBZ/LkdC8ZW3wYvOSfeY0FIwvDpaKbPIdgM2KtBPxvo4Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?//qGYSmFfFDShPSEp0NlCAymNqpk9xUunCAefatrBDHC8S8ALakN/QF/1jZU?=
 =?us-ascii?Q?fJ2mW4atCjQDzZbplb8vAhiXuxbRb3naKxxH5JzyHlOb4lCN1lcdca2f2JWj?=
 =?us-ascii?Q?tz+0Z0BDgxi0z7NmLTOxfqfYyL3+QlFYoIUUmkF9ScFR0yGFSgnQOHLCB/Jv?=
 =?us-ascii?Q?0E68Y4yLJQu2c0zzMAB4S1BwdlvhOiV0wErlciPjZHdGhMhKMGz2na7rGm8k?=
 =?us-ascii?Q?X2cIn/4i0iCZOoXFBLqoa917nQue+kxVqjgVJoDSZ0pm/ZTfZ9Oq+uB4fVkY?=
 =?us-ascii?Q?+Xd5HF5UQgDf+i4TiyDs+HKZQClqanYhwFy7QX1YQhwe6zMXR4QBnEEBrzoP?=
 =?us-ascii?Q?Jp2GcYq6mBjSbhQkC+9kf0+XEE1kG4LszO8IGVJF5kgi2nJDtulAyPZF+WOP?=
 =?us-ascii?Q?IVhirkAYGaevMMlwIBRr/hPYf/Q0maLuxWbWShwBkKX/ptVeYCwM7Fox3RB3?=
 =?us-ascii?Q?7viCziAEIedk9cqECbwFwoZdkj/yci4oOe7kPtJyo/3S1sHBpXH84nfjgoEu?=
 =?us-ascii?Q?g0Is+bmk3frh9l4PA3r8dV8jJBMGu7jkVd58PczCs8gRENeKhXwzUNzpJ7So?=
 =?us-ascii?Q?Bf45cEhQnvFoPLsPM0qu0HveYdIogCVzL6rXTBLgkZh4BpJHSucCXtm2fd3z?=
 =?us-ascii?Q?3pMFIjvCiKgSMUuifXTLFCpE1ONEfl8VvqxG2cZL4kisS+xkoFF0LmJ6tsbY?=
 =?us-ascii?Q?DiHYwFwDKTnr85DlMgPH6+PuAXBRFq+haiH1wMGCiBFKOYt82No+eYoueG3p?=
 =?us-ascii?Q?VpTPXtzkjLw/DRNSAlmTbCo+Vy+llyq4rjwkomDFEWF2iyyo6JjE6CXmls2n?=
 =?us-ascii?Q?O/+B+5fkzEES5AcKfuBHZQoIVUQgAisngqy/KqxCm2/RbQ9FJM1NZKXNPEz0?=
 =?us-ascii?Q?S4t2fcwCcDAoWDYkqHD6sQJUfySdKkIzhsr0YLbH/mXnwlAoM63fozqITD/t?=
 =?us-ascii?Q?ifzwNN2wBJwWzPmfHMiDxTpwNt4B0KaVvY4vlg2tdX0PsTcEG79aD7EfnQz+?=
 =?us-ascii?Q?YeYIf+n+FFGCzNMWvjCX8QuVKBehd85RXEd09OYqoT8sWOzAJtEK/rOXNnTy?=
 =?us-ascii?Q?wAGhq1LoDiVab0M4K3FgOg2lfby6ZB68iGrOoHe6UxQAfEPXeBtyBh6auAbb?=
 =?us-ascii?Q?BrdEBLiUQF6TqveghZBZbJ6/N7c5pO/7YfhmIo+4uGzeVqk5j+2+saL143vl?=
 =?us-ascii?Q?zct63TLzCDmGVyFRvGeCYHwLPlG8r8QzfP6tl1G/l24l0IJvSV69gfJ8Iet8?=
 =?us-ascii?Q?IoOa/MTlD6bzyYx+ae9AfNnbrIW77K0/LJwAg+S+JNx5mWH5IaRbE+AkgUwy?=
 =?us-ascii?Q?KCT8eppaMgVRXbbRFFOEsF7j1J0W24ch4QNSn4ufouTI5UtTURB+NnWTqyXj?=
 =?us-ascii?Q?cVcW6a5FqQsJxYsfoIg4p1oglJ69b3I6pUpePkh/iNmZzR5NGkb9zawXsOG0?=
 =?us-ascii?Q?p1Flcco9waXTSWCLPXQbYqa5Ah0OcFaRyVUqHf2CFYzsmp0wN5PNYyrK/wN7?=
 =?us-ascii?Q?Ze8bg6LcYjIR0f/1P7JjPKubm8mlKpgwBc9AnJ8g2TovmZk3BpQk+YM/BCqX?=
 =?us-ascii?Q?mzmDvSwoFcGjBQRt8d6+UlQmtqSfNYn/7BxTRyLn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qUM5mT/RzsXmIoNChnlKHrt8qkhsMGHTW88fGgbPkNvso9jQpYb73cNJbSRgdt/bWcVMGVQqrKfAwj7tHI9xGgSUiZenEAJ5d8E454jzJwjafR0qY+MBnyLDcf6zOkGm+tBZkMKFOWmofItrC53HzGII5PRcZZidF7apFs5GJqDHFA6CoW3VVKzxnTAHEDkpnVGD0la8ZRb9faX9YjdQk3MIHvucfaIgq36sRPaPLWsmOfSN3g3jg7aQw3ZalnTdUqdApuXvrZdKxM5KitUmRc4urHcasZB8orkNt0HyKQ7xdSpfWUtu7nNwfbDBlli+4Qw8GCrglgn9D8U1Gt9VDahJkVfEBbZu6o3mgn4paEOTRKehO5nzixKobjsPQI0LVD1a0AfmXixiQKRjrHtdvQ2Y4fGMl9kjnN7gyL9x9P/nx8pg4urmSg7+fMkdL/jb3WfNFh2QqcUQoi7f6kSUQDEfzNCCGC9LAVVCbGNfkGwQh7WOej/SjhqetZiX+j8VvAX0a98MIambwsyQsV9YWNK5u/gBOqExQAkOlaDc/ErrvtEKd7d2DOsoEFNX4oEb7Cda3gfKrGC4PXYstKs1aQuUMrICp3Gzp8DfJogkB64=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce56369d-6b5a-40c6-d61f-08ddc7e71894
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2025 23:42:32.3540
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YzVrOTVpOIEQIulMxXXGzL9a1FFM/mJjBzO/6+NOoVmMM6S4t+pKOpMF6xn61nGWEH/vF67P6qI4y872gWIQUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6395
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-20_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507200228
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIwMDIyOCBTYWx0ZWRfXxpvbnvGGZDiY
 z6iniss32SfgVZYdSb17I7oSzlklBgBcRcg725vmbkHOXp/iMat06Rnq0A3JLL6wjGwkfi0akd3
 EH/3h/DKTEYZZH0x/Q+e80whM1fgFbDANZ7s5ZyQQuZShHI9LMMe3qoVIsN5hX2Yqwr4nxqVCYA
 xoCUw23TznzIBv8+JRJR6j3hNemSaK9V0DU8osGannoU+xkIAkq02C81+4ba3+ZXpIiX28s7xNA
 SAmqQr1hm8pO986LsH2KZUDH5p/3Jg7H9i2GT2Udh3K/sUXHN8WXnQby9qmQhE1xJ05dQk/tDUa
 d4x36Bx/xHwZRVKrR6n3rLu7mMBola9GCCYGVJs7TS2mepnYeowydqrYyQUT4nQ9FPvh+t7UQgk
 lK0Z5G3784wtpHF3jn+kLMHJ4Y95hz7PwSOuLnitSnGa4jHmZeb0C3nN6qdnediJ1Zvm3phn
X-Authority-Analysis: v=2.4 cv=doDbC0g4 c=1 sm=1 tr=0 ts=687d7eec b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8
 a=QyXUC8HyAAAA:8 a=yPCof4ZbAAAA:8 a=X7OBBLe7zzONDxeIk40A:9 cc=ntf
 awl=host:13600
X-Proofpoint-GUID: C1gHAjwVn_PArpfg3A1FBSWnZnvq3IIJ
X-Proofpoint-ORIG-GUID: C1gHAjwVn_PArpfg3A1FBSWnZnvq3IIJ

Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
populating PGD and P4D entries for the kernel address space.
These helpers ensure proper synchronization of page tables when
updating the kernel portion of top-level page tables.

Until now, the kernel has relied on each architecture to handle
synchronization of top-level page tables in an ad-hoc manner.
For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
direct mapping and vmemmap mapping changes").

However, this approach has proven fragile for following reasons:

  1) It is easy to forget to perform the necessary page table
     synchronization when introducing new changes.
     For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
     savings for compound devmaps") overlooked the need to synchronize
     page tables for the vmemmap area.

  2) It is also easy to overlook that the vmemmap and direct mapping areas
     must not be accessed before explicit page table synchronization.
     For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
     sub-pmd ranges")) caused crashes by accessing the vmemmap area
     before calling sync_global_pgds().

To address this, as suggested by Dave Hansen, introduce _kernel() variants
of the page table population helpers, which invoke architecture-specific
hooks to properly synchronize page tables.

They reuse existing infrastructure for vmalloc and ioremap.
Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
and the actual synchronization is performed by arch_sync_kernel_mappings().

This change currently targets only x86_64, so only PGD and P4D level
helpers are introduced. In theory, PUD and PMD level helpers can be added
later if needed by other architectures.

Currently this is a no-op, since no architecture sets
PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.

Cc: stable@vger.kernel.org
Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---
 include/asm-generic/pgalloc.h | 18 ++++++++++++++++--
 mm/kasan/init.c               | 10 +++++-----
 mm/percpu.c                   |  4 ++--
 mm/sparse-vmemmap.c           |  4 ++--
 4 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
index 7ff5d7ca4cd6..c05fea06b3fd 100644
--- a/include/asm-generic/pgalloc.h
+++ b/include/asm-generic/pgalloc.h
@@ -298,8 +298,8 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
 
 /*
  * Architectures can set this mask to a combination of PGTBL_P?D_MODIFIED values
- * and let generic vmalloc and ioremap code know when arch_sync_kernel_mappings()
- * needs to be called.
+ * and let generic vmalloc, ioremap and page table update code know when
+ * arch_sync_kernel_mappings() needs to be called.
  */
 #ifndef ARCH_PAGE_TABLE_SYNC_MASK
 #define ARCH_PAGE_TABLE_SYNC_MASK 0
@@ -312,6 +312,20 @@ static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
  */
 void arch_sync_kernel_mappings(unsigned long start, unsigned long end);
 
+#define pgd_populate_kernel(addr, pgd, p4d)			\
+do {								\
+	pgd_populate(&init_mm, pgd, p4d);			\
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)	\
+		arch_sync_kernel_mappings(addr, addr);		\
+} while (0)
+
+#define p4d_populate_kernel(addr, p4d, pud)			\
+do {								\
+	p4d_populate(&init_mm, p4d, pud);			\
+	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)	\
+		arch_sync_kernel_mappings(addr, addr);		\
+} while (0)
+
 #endif /* CONFIG_MMU */
 
 #endif /* __ASM_GENERIC_PGALLOC_H */
diff --git a/mm/kasan/init.c b/mm/kasan/init.c
index ced6b29fcf76..43de820ee282 100644
--- a/mm/kasan/init.c
+++ b/mm/kasan/init.c
@@ -191,7 +191,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			pud_t *pud;
 			pmd_t *pmd;
 
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -212,7 +212,7 @@ static int __ref zero_p4d_populate(pgd_t *pgd, unsigned long addr,
 			} else {
 				p = early_alloc(PAGE_SIZE, NUMA_NO_NODE);
 				pud_init(p);
-				p4d_populate(&init_mm, p4d, p);
+				p4d_populate_kernel(addr, p4d, p);
 			}
 		}
 		zero_pud_populate(p4d, addr, next);
@@ -251,10 +251,10 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 			 * puds,pmds, so pgd_populate(), pud_populate()
 			 * is noops.
 			 */
-			pgd_populate(&init_mm, pgd,
+			pgd_populate_kernel(addr, pgd,
 					lm_alias(kasan_early_shadow_p4d));
 			p4d = p4d_offset(pgd, addr);
-			p4d_populate(&init_mm, p4d,
+			p4d_populate_kernel(addr, p4d,
 					lm_alias(kasan_early_shadow_pud));
 			pud = pud_offset(p4d, addr);
 			pud_populate(&init_mm, pud,
@@ -273,7 +273,7 @@ int __ref kasan_populate_early_shadow(const void *shadow_start,
 				if (!p)
 					return -ENOMEM;
 			} else {
-				pgd_populate(&init_mm, pgd,
+				pgd_populate_kernel(addr, pgd,
 					early_alloc(PAGE_SIZE, NUMA_NO_NODE));
 			}
 		}
diff --git a/mm/percpu.c b/mm/percpu.c
index 782cc148b39c..57450a03c432 100644
--- a/mm/percpu.c
+++ b/mm/percpu.c
@@ -3134,13 +3134,13 @@ void __init __weak pcpu_populate_pte(unsigned long addr)
 
 	if (pgd_none(*pgd)) {
 		p4d = memblock_alloc_or_panic(P4D_TABLE_SIZE, P4D_TABLE_SIZE);
-		pgd_populate(&init_mm, pgd, p4d);
+		pgd_populate_kernel(addr, pgd, p4d);
 	}
 
 	p4d = p4d_offset(pgd, addr);
 	if (p4d_none(*p4d)) {
 		pud = memblock_alloc_or_panic(PUD_TABLE_SIZE, PUD_TABLE_SIZE);
-		p4d_populate(&init_mm, p4d, pud);
+		p4d_populate_kernel(addr, p4d, pud);
 	}
 
 	pud = pud_offset(p4d, addr);
diff --git a/mm/sparse-vmemmap.c b/mm/sparse-vmemmap.c
index fd2ab5118e13..e275310ac708 100644
--- a/mm/sparse-vmemmap.c
+++ b/mm/sparse-vmemmap.c
@@ -229,7 +229,7 @@ p4d_t * __meminit vmemmap_p4d_populate(pgd_t *pgd, unsigned long addr, int node)
 		if (!p)
 			return NULL;
 		pud_init(p);
-		p4d_populate(&init_mm, p4d, p);
+		p4d_populate_kernel(addr, p4d, p);
 	}
 	return p4d;
 }
@@ -241,7 +241,7 @@ pgd_t * __meminit vmemmap_pgd_populate(unsigned long addr, int node)
 		void *p = vmemmap_alloc_block_zero(PAGE_SIZE, node);
 		if (!p)
 			return NULL;
-		pgd_populate(&init_mm, pgd, p);
+		pgd_populate_kernel(addr, pgd, p);
 	}
 	return pgd;
 }
-- 
2.43.0


