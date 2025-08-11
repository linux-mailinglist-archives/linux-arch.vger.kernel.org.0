Return-Path: <linux-arch+bounces-13121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07788B2089C
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 14:19:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0E23426263
	for <lists+linux-arch@lfdr.de>; Mon, 11 Aug 2025 12:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5FAF1E8320;
	Mon, 11 Aug 2025 12:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b7Ct3BPn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LBiXjlzZ"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E979DF9C1;
	Mon, 11 Aug 2025 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754914743; cv=fail; b=KomATxnJQ2hBadQn98JehTq8iSr6BykqAqIaVShMipA1AoThMEKPzyiKaMjwdH47glxrgokn0xTSUoNVOnllL+b/8c1CLfsTQ8SjrvbwpZ8+1uUFjpOt4m4MX3rkB1KMr37WxOVK5xJyfmFcf9myYWkjFhpdWz81jkXms8OS2RQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754914743; c=relaxed/simple;
	bh=p80XO8t6UY1fMlkT64KQBJZlSvkSR00ybagR5bgnEq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uUng8d8s2pSiMldFoFbF9L28+l5GzYS+RyYfRoGOZLAhLmWmjYqOIOMuoOPEMUVeRkeHkzWiixlGw3OXjLBBayU3rSsqd/RnenAZTKhkMEAPdysa9S82v0SF6TtuyW1WO5SPJtaNqprlu3oLgHZZgnnrcWZOTwmDw9npvFCjDZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b7Ct3BPn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LBiXjlzZ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57B5uBgl023549;
	Mon, 11 Aug 2025 12:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=qf25gZ/BsRbygqTJcb
	Nss00Vn5FCI1NdYWscrz3EXr8=; b=b7Ct3BPnlDInPXM4mRj3+8SyHERjXwvJuz
	XQJaYK1HxY+dBGfKBHbqIBDUVj5PktlVG1qw8DaFvwEnXGAQBqF96zFhKP3ROWUm
	YMEdmiTcLr5wCcA4rZyY2tUEkPZDQeENzGtBMkVxxd9KICq+FOv3Ndvgs+rX8D3v
	16jh182s6NT8QDcxzzmOgu6iCXPVi6BnSjJnz58yagos21J2Kk8RB+7al/ncnxnN
	jx7iK10ArgPJ2MJcp3c1Wr/Cc3CgE3nz+4UjfTcpaw+MrvjByP8CcXnmmv1h4RfI
	xrKifDSJct5Oa+NSA3mGKA5xaBunJ9uv7CL7S3PDLUhvaj7n0/tg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwt8wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:18:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57BC60lb009846;
	Mon, 11 Aug 2025 12:18:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvseuefw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 12:18:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PySD47LR3oHImwsBaMLGzhav4fJS4Bsph8E6wDaPypuZygLeDo7L0OUaO0behHOJiIHVCHwkPj2PCmTSP6e+kTpYbfnVCiF17U0y0Klxd+IuUjeOmsTMEU4RAcCNnRlzshVsCVt9wJCdMR2vizwmptFme46v2+FG0mJVq59t3KpUnCgx9nst4b3G9bc7Fa7fTcB7MFhuKUds6bU6A5IFVM7NCwOW5xI10DfMoL9Pf/aU0ARsy339tBiouAuQYj4x7uJi4OgVboXQZcjJ7fA6xfVFcc5FtbF1nJkRpQr28ujP/M+T0oQ8JX2od0SO+K2rt4mAYD4Pf9MFWQnn+9u+Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qf25gZ/BsRbygqTJcbNss00Vn5FCI1NdYWscrz3EXr8=;
 b=AKRirBX38zcH+DuysGiQzoL482mw7iN1MqaiA12Mjza8Y5905r6WPD3/CC5c/UuVVmfO3OfreGgp6V+6Mp8xm9hBHVc4L5laiOJ5tVnLrmPy5d9ucoS24XCN83JNcrWZI5wrsjui3m7bm0TQVWTfTDKo1CJXY445SEYU/btS518oimdm5gSbzmYF/OiEssAQWRClY0qDxlW0hHTJkwfwIAGlWpsU3UhxIHJFehtaphtGeDCa7D7J2Ge78RzIxwT3yLprvW/BJcEW7NE8loNkDdXMxAy+WkP4b+rCklT8WiQjE81mrcC+FV/eD8P6UgYeshOD4ghBQuT6E2akqitDrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qf25gZ/BsRbygqTJcbNss00Vn5FCI1NdYWscrz3EXr8=;
 b=LBiXjlzZBxRgGwcBTiG6PD7K8KQLs2YjlINgSEtSN/Gx1B0QA8JGoAzKe9gUpqQhleUvegvJvLBfI58SH89lfYpgduOJOmRfJtYljO1cMn5DimA5AtM+70xFND3ewG006KgvcBrw8ZmxzzKt7+oH4yz3+36CNJOoNskOEVoCk3s=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by LV3PR10MB8059.namprd10.prod.outlook.com (2603:10b6:408:290::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Mon, 11 Aug
 2025 12:18:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9009.018; Mon, 11 Aug 2025
 12:18:15 +0000
Date: Mon, 11 Aug 2025 13:18:12 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Harry Yoo <harry.yoo@oracle.com>
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
Message-ID: <c3ec3012-4ba0-4b7b-bf0a-88f39ef029d8@lucifer.local>
References: <20250811053420.10721-1-harry.yoo@oracle.com>
 <20250811053420.10721-3-harry.yoo@oracle.com>
 <8c8c6895-53fa-4762-98a4-886a53903341@lucifer.local>
 <aJneGJSJcltEIT41@hyeyoo>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJneGJSJcltEIT41@hyeyoo>
X-ClientProxiedBy: MM0P280CA0046.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|LV3PR10MB8059:EE_
X-MS-Office365-Filtering-Correlation-Id: edae9af0-ab35-455a-fae8-08ddd8d125d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8QURIZfSMVqCbMsKMk9yPy6WHCxtxpjFbHH6iyjBsYOQpprpB0U+e9YzK8dH?=
 =?us-ascii?Q?8YQvAKJUuI80D4wtHr+XlZdlGk+CFiQ+EuAez6TjQlCt1U4OyCS4RD3jGtCL?=
 =?us-ascii?Q?d7WvBbHWdmS6Dn71CbdhZHTGbNmXbywsW1YhifeiPpvrqqMFO6Ej9qfN9KKN?=
 =?us-ascii?Q?8zJeQjHVUtEVXBzvKbODmA507WqQalJAuZAFNXHnSqXxvy/h5TF5iobKsk91?=
 =?us-ascii?Q?Ui5B39ocGg9pdKvrpQZ64561uN7VDl9oovXa7nVL7QFYHJacUkNp6sqAuwUC?=
 =?us-ascii?Q?OMqsrOFEYJrac3y/PlQcdzoZ5wdT3VQEyIfC3FyqS/RtMnBNKbnEANZIx5CA?=
 =?us-ascii?Q?JHP1GhqlNrwqruzQ1TYfi+vImi7n1tZYot0jjTKwDaiuELwIIzJZ5lX0efAC?=
 =?us-ascii?Q?eXeO+bTfBsna/QLgMnTzlnPc/F5glgN6iLVn6vi1BRlDTfdRwrRLd3g/bnCG?=
 =?us-ascii?Q?ArsCf0ra49O2Mfb9yUwBSYUnXUtXSN4NrxqxqaUbmGM1HFv8q7L2WGC8Z8fw?=
 =?us-ascii?Q?UoLkRdxE2tSDO3scEQrQ4th2JPabrbtqfPZwPKKNK5U67yO9Lxq3d0/4oH38?=
 =?us-ascii?Q?YFhBXjQBr4FpOemSOVXMuxiUbPVOEISKbZAXYZXSjafJ+Ode+PBz28HQQgwe?=
 =?us-ascii?Q?o0OBUar1FeuTIBpr5r5/afoCwWT4eeng/PbA1klxezwLh4PiJfpOS1B/+quW?=
 =?us-ascii?Q?fjtLhJPE9PdCFoaD/auA4znioMmLAtTz3n9uZSxAhfYqFAs9KPXqRHUdGlZA?=
 =?us-ascii?Q?urByBrd/Zn3GYnn9tlK5ioZ5EMqH+ekVT6AeTYlJwBZKt1QYBhdsILwyxq99?=
 =?us-ascii?Q?/eQADDh812Q1v6fLPWDlTm7jS3tOHwUyf2nCL4S/Zqk/uHrisG3xsXDSRcor?=
 =?us-ascii?Q?Rnt/yr5DXDarjHKa9FeIjuX04rr9jBfv5nOlzFmfcybCqN67roA9xANE3G+1?=
 =?us-ascii?Q?vWBR8bTcRkAo1BnMLgsnQo5P374E0o4CNC6wEGV2PrCmsKWbWlFb86Gu65uV?=
 =?us-ascii?Q?7jw2715gQz1RCv0VVHR0jYJ+yEqmT74p1dwoEXriIyqHddsGUTooiaoFgo5/?=
 =?us-ascii?Q?tNUOeChCJT+gIFc2qLTElkIZ76B+zcwZAYfIx/4bUUiDjZO9a1wRqzj+xZW3?=
 =?us-ascii?Q?q3MVsMLuutzM9Nz9FaXlqlHQX8h6o8c67ti7ruUA3MqMiUHYtFE6pAnABmIM?=
 =?us-ascii?Q?VhIui9flavlwaiv0Rp5mkdDneMGWU8fxpe1CSX7zENrV+IJXPSCJfx+5DOT3?=
 =?us-ascii?Q?qKRqgC/lIKT6d6VsXb9YhzTiImPNo59xZza2GEnnckQpuidTpYbtI/Gc+IME?=
 =?us-ascii?Q?DnowkwjcZXlWw8pxsa3GTOBLxecH9zfGz7A5aeVlH3BiMmXZQp8G+h6FvKM/?=
 =?us-ascii?Q?Xrq8gwD/G3RYeIkciP4wUkb+Ua8KcJ1QfhEvqQIseaHn6FfIrBeZiOmEcnMs?=
 =?us-ascii?Q?/GrGOxax9qM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vekkViEbqRPN69rHwBmghnTWws5oHbkBGsVsBezHc4aA/S5o33/ipovkecVP?=
 =?us-ascii?Q?wDr7AlSotFTjgf4SCxixaP87ccLoS2Ifj3Hluyhxur01RjKv64n3CeQkhdEz?=
 =?us-ascii?Q?PaXkDOKRauI9Lgf4FcPlxJiYCyMK6PZmmu3HY9kibYsxQ3iuBJhTdKHAWJGj?=
 =?us-ascii?Q?sqTpmK3IsqCMZC6KXYB8/jMeGAvv15ejhxwB5RVo2zVzLs7cy+z68OFlr7o8?=
 =?us-ascii?Q?tjTmt/maVCLrk7A7plHHAWKphqB8qr+U8rVopXC/O1V6om/PsOfkaQgMxZlF?=
 =?us-ascii?Q?zNcQsuFx3YCYQqo8nCGHP/11PVRpg6hiO7B++S9tzBvNrszihadMPcqKV6Ki?=
 =?us-ascii?Q?mVfGjO2f6B0Q4GqLfkb+PB6brqntkWjhM4KhUsQyc+5trueyH/z6Mkn6IrRX?=
 =?us-ascii?Q?yQjOUTVDIBa5bC39P6c7fnJjH8M4RKErunqQ57BPn3is+8uTV3beqhz5BVF4?=
 =?us-ascii?Q?D0qBKFqmdsEBv0bWbIXE0vFfy6oQwtw8OqQEUFbo+GexTyUQ7iB1HxzABjV+?=
 =?us-ascii?Q?9LljrkU2FNsJbceYfr5HhyrbPGRC3h1AJh7z3DSj2uaq/mQHFPFkH0UuKKqt?=
 =?us-ascii?Q?aL5EQxysKLAYF7S69Mi2N6X2LbUyUh8Sgdbkekcw5HRDX5YB/d+Y0MKmhR/w?=
 =?us-ascii?Q?pYJSSKdrjap+flN2L/EYPyyyofG797pb+FKSBoOy2uszpbApyoEMPrhczfe/?=
 =?us-ascii?Q?RI6ss+XA95uMd1X3rAS76/Qsy3FzclfF5nn9jEqCOwkRUUnk7Ns1TP32evmt?=
 =?us-ascii?Q?heCPYc5ERwQ0yD0U3klkM4UEjwZJYbGJ8XGSLP1ahdxnG9S+mVClerzClBLC?=
 =?us-ascii?Q?JkorOg2DEHcP4MS4tmJE0xSg8R2pUNoa3IrAdE/ZL4KXIesuD2nn5/mttn7P?=
 =?us-ascii?Q?CSE2Mq8RqFHn5UhLdkn51D/x6v82XaqCPtoTcR1fKLCfAdyWccyDcdDExwUA?=
 =?us-ascii?Q?BCwzZUAQNyEGel8YGMTHK0ymkvaSudVZkcW6sN5s+G+qlW6hKMcbqrisirtN?=
 =?us-ascii?Q?s5QCjLaXZ8dqCj2DyBgabIik93nyDbbbd6j03z5wyk5ESKNLkM7R2Dpt+QnX?=
 =?us-ascii?Q?+WW0rw7I/VD7cnKyGee8ZaBc3bsT0bJdH1v3Si1MCCPLDy2QHJQLFKpNde9S?=
 =?us-ascii?Q?yHbegfQglq8dCWVwFnEW2a51wU3dhzySp0vOLbuNM5RTcFkgDEVVBwMTxj7K?=
 =?us-ascii?Q?xXgjh8DOhDvAccvR1oFQCquoxFNjOx9bniNOogrU9Qwi4YN35anHCjmSbxzQ?=
 =?us-ascii?Q?e/6xdghCUmPx5phxBSMjjYzFgP7BR3ec97r9qQixlNj/RLY+Fya0hMPElECX?=
 =?us-ascii?Q?LMClm6yVrnOeZnYfKz5W5JtoaXbSzvqUHszq2iyaYCBVboRZ+B1XEJjCgdFF?=
 =?us-ascii?Q?NoHq/ovav5vauEnRx15kJW4tTEbnblQy2sMBcpz7TKT1BBYVQIPsyB54jeNE?=
 =?us-ascii?Q?exFTXQbAmXOA3R9dFEMWO32uSEFfydbC8uEgAY94Fxet6gLG4LBCMvT/5PUN?=
 =?us-ascii?Q?VvDEC1b8oKql3BrlczGW2jUgJOM42m/FxmUORnqV/aK1v9rPGiKpXAmauPwo?=
 =?us-ascii?Q?twB51l0FFBIKIZ4CrX+3cPmq2oigeR6ii0oGvlXLk1XMKq6PzXnuUabGfPZu?=
 =?us-ascii?Q?Qw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dVFNkJI6QyJpAQrBipGZC41iqeqLB45UI0LDHlA1PGJBASoAaVPcaUWhi1cBvxCmpsMoSTu2+O0ToIFuO7eScVI8AGc7aZMEK/VTH2oyntFjqIYou+uFWrD32htvgdmveVtXO6FWzwKfC/ljA5bPWFleuZKqWoqoYl3kuDBHGtu/JFpGUeNpueH+yzgNDZX4Wevrzar6a4rQZOq2XFea0lkBOVlVyJlXxBRGJ3GQN+/l6/RQaqOoIMCUWPHN40sQxqgeQvxvUvHZtYK4D3tJrzrWeZYBrc66dEi9pEKzJVzTn7XuyVeYd1w2lt2bUW3RJPVqe34f4Iidj1K2IqxMCNWDVvhJrqFmkXL7UcVMYRoDuzjZys6O4vOheqrxVt+c0xexqPMyC2eQX0HhODXxSM2WNpBG8inP18/oClnnQUZ4tMkcpNxMj/Ilo9mvzMbnSjL47pkExzPPSqA0VVxs8H9BuFlVX+Yu46lUbLujAHaEheVfaLD7OsvmS/w9eDWCqdVumRLI33wfPrdYlJJc8owC1UdHdmRTz8Y0yHUAOYlbLcLbLo6hemay5tsDxSK15GTVRgBbPHMumJihVPaDsQnE3Kycl1D2dRePV24a6KI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edae9af0-ab35-455a-fae8-08ddd8d125d7
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2025 12:18:15.2201
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BsjLRpaR23Q6qRaAdm0o1Mn2HQOeAO0GTWu9wYeXfg0Xhp8cg9UvtM6ULUoEDEhj/n/4H9xW53hXkGsvwjn1lb59/7c1YkPQqw/30p3h2O4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_02,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508110080
X-Proofpoint-GUID: eV0LIt_sBgA4rH74PEN3wrhKNbqCsXRh
X-Proofpoint-ORIG-GUID: eV0LIt_sBgA4rH74PEN3wrhKNbqCsXRh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDA4MCBTYWx0ZWRfX5Rj/FuEFAzC0
 iiefM0mMAj3HAsJLOV0xnrH0VKeOn3141H6G2hkJ76fimO5dU7G/lMZU9vyYZ+PxSpM1OY99pGo
 2PTPBJQe7Dmx+Bqm3SqJK1SfzKD7RteMX1szgkA8DaU+bQtLYk9i4O8l/d7wVEevB4bWYSNCJfc
 WQemHlKwKC8SYKING6ydjmN2Td88bi9aDulJGWvYeLUhEwo7SSFGa7b68YweXbTFtkZlQhjlUdT
 rl7J8sA8jrZLP64dMGLc+A9YRwbsjP6URrvWEtNjDmWZs5ccc0VstolsJiJP77EUIPzjZ1gIoJv
 4HIUDquWH/AX0RCuaw2b0ft53Bk8mGKwDcp1eTBBLVms1R+tHu2KWtGTMKNdaXwjHQh525i/fu1
 Cbxp3aHwNHocRwFN0EXnUKKUpgJqOivteGsQEYZddoen/6RYmLRR7CoNn5aEPFvyYXYm9qRE
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=6899df8c b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8
 a=yPCof4ZbAAAA:8 a=NYba__zSBiQ-AN9V9agA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12069

On Mon, Aug 11, 2025 at 09:12:08PM +0900, Harry Yoo wrote:
> On Mon, Aug 11, 2025 at 12:38:37PM +0100, Lorenzo Stoakes wrote:
> > On Mon, Aug 11, 2025 at 02:34:19PM +0900, Harry Yoo wrote:
> > > Introduce and use {pgd,p4d}_populate_kernel() in core MM code when
> > > populating PGD and P4D entries for the kernel address space.
> > > These helpers ensure proper synchronization of page tables when
> > > updating the kernel portion of top-level page tables.
> > >
> > > Until now, the kernel has relied on each architecture to handle
> > > synchronization of top-level page tables in an ad-hoc manner.
> > > For example, see commit 9b861528a801 ("x86-64, mem: Update all PGDs for
> > > direct mapping and vmemmap mapping changes").
> > >
> > > However, this approach has proven fragile for following reasons:
> > >
> > >   1) It is easy to forget to perform the necessary page table
> > >      synchronization when introducing new changes.
> > >      For instance, commit 4917f55b4ef9 ("mm/sparse-vmemmap: improve memory
> > >      savings for compound devmaps") overlooked the need to synchronize
> > >      page tables for the vmemmap area.
> > >
> > >   2) It is also easy to overlook that the vmemmap and direct mapping areas
> > >      must not be accessed before explicit page table synchronization.
> > >      For example, commit 8d400913c231 ("x86/vmemmap: handle unpopulated
> > >      sub-pmd ranges")) caused crashes by accessing the vmemmap area
> > >      before calling sync_global_pgds().
> > >
> > > To address this, as suggested by Dave Hansen, introduce _kernel() variants
> > > of the page table population helpers, which invoke architecture-specific
> > > hooks to properly synchronize page tables. These are introduced in a new
> > > header file, include/linux/pgalloc.h, so they can be called from common code.
> > >
> > > They reuse existing infrastructure for vmalloc and ioremap.
> > > Synchronization requirements are determined by ARCH_PAGE_TABLE_SYNC_MASK,
> > > and the actual synchronization is performed by arch_sync_kernel_mappings().
> > >
> > > This change currently targets only x86_64, so only PGD and P4D level
>
> Hi Lorenzo, thanks for looking at this!
>
> > Well, arm defines ARCH_PAGE_TABLE_SYNC_MASK in arch/arm/include/asm/page.h. But
> > it aliases this to PGTBL_PMD_MODIFIED so will remain unaffected :)
>
> Oh, here I just intended to explain why I didn't implement
> {pud,pmd}_populate_kernel().

I'd add that arm handles PGTBL_PMD_MODIFIED and therefore remains unaffected
just to be super clear.

>
> > > helpers are introduced. In theory, PUD and PMD level helpers can be added
> > > later if needed by other architectures.
> > >
> > > Currently this is a no-op, since no architecture sets
> > > PGTBL_{PGD,P4D}_MODIFIED in ARCH_PAGE_TABLE_SYNC_MASK.
> > >
> > > Cc: <stable@vger.kernel.org>
> > > Fixes: 8d400913c231 ("x86/vmemmap: handle unpopulated sub-pmd ranges")
> > > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Given that I missed you fixed the vmalloc.h thing, this LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> > > ---
> > >  include/linux/pgalloc.h | 24 ++++++++++++++++++++++++
> > >  include/linux/pgtable.h |  4 ++--
> > >  mm/kasan/init.c         | 12 ++++++------
> > >  mm/percpu.c             |  6 +++---
> > >  mm/sparse-vmemmap.c     |  6 +++---
> > >  5 files changed, 38 insertions(+), 14 deletions(-)
> > >  create mode 100644 include/linux/pgalloc.h
> > >
> > > diff --git a/include/linux/pgalloc.h b/include/linux/pgalloc.h
> > > new file mode 100644
> > > index 000000000000..290ab864320f
> > > --- /dev/null
> > > +++ b/include/linux/pgalloc.h
> > > @@ -0,0 +1,24 @@
> > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > +#ifndef _LINUX_PGALLOC_H
> > > +#define _LINUX_PGALLOC_H
> > > +
> > > +#include <linux/pgtable.h>
> > > +#include <asm/pgalloc.h>
> > > +
> > > +static inline void pgd_populate_kernel(unsigned long addr, pgd_t *pgd,
> > > +				       p4d_t *p4d)
> > > +{
> > > +	pgd_populate(&init_mm, pgd, p4d);
> > > +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_PGD_MODIFIED)
> >
> > Hm, ARCH_PAGE_TABLE_SYNC_MASK is only defined for x86 2, 3 page level and arm. I see:
> >
> > #ifndef ARCH_PAGE_TABLE_SYNC_MASK
> > #define ARCH_PAGE_TABLE_SYNC_MASK 0
> > #endif
> >
> > In linux/vmalloc.h, but you're not importing that?
>
> Patch 1 moves it from linux/vmalloc.h to linux/pgtable.h,
> and linux/pgalloc.h includes linux/pgtable.h.
>
> > It sucks that that there is there, but maybe you need to #include
> > <linux/vmalloc.h> for this otherwise this could be broken on other arches?
> >
> > You may be getting lucky with nested header includes that causes this to be
> > picked up somewhere for you, or having it only declared for arches that define
> > it, but we should probably make this explicit.
>
> ...so I don't think I'm missing necessary header includes even on
> other architectures?
>
> > Also arch_sync_kernel_mappings() is defined in linux/vmalloc.h so seems
> > sensible.
>
> Also moved to linux/pgtable.h.

Ah yeah damn, I missed that you do that there, ok well that's fine then :)

>
> > > +		arch_sync_kernel_mappings(addr, addr);
> > > +}
> > > +
> > > +static inline void p4d_populate_kernel(unsigned long addr, p4d_t *p4d,
> > > +				       pud_t *pud)
> > > +{
> > > +	p4d_populate(&init_mm, p4d, pud);
> > > +	if (ARCH_PAGE_TABLE_SYNC_MASK & PGTBL_P4D_MODIFIED)
> > > +		arch_sync_kernel_mappings(addr, addr);
> >
> > It's kind of weird we don't have this defined as a function for many arches,
>
> That's really a mystery :)
>
> I have no idea why other architectures don't handle this.
>
> (At least on 64 bit arches) In theory I think only a few architectures
> (like arm64 where a kernel page table is shared between tasks) don't have
> to implement this.
>
> Probably because it's a bit niche bug to hit?
> (vmemmap, direct mapping, vmalloc/vmap area can span multiple PGD ranges)
> AND (populating some PGD entries is done after boot process (e.g. memory
> hot-plug or vmalloc())).

No comment is more why we don't just do a standard:

#ifndef xxx
#define xxx (0)
#endif

Or something. Just odd.

>
> > (weird as well that we declare it in... vmalloc.h but I guess one for follow up
> > cleanups that).
> >
> > But I see from the comment:
> >
> > /*
> >  * There is no default implementation for arch_sync_kernel_mappings(). It is
> >  * relied upon the compiler to optimize calls out if ARCH_PAGE_TABLE_SYNC_MASK
> >  * is 0.
> >  */
> >
> > So this seems intended... :)
>
> > The rest of this seems sensible, nice cleanup!
>
> Thanks for looking at!
>
> --
> Cheers,
> Harry / Hyeonggon
>

