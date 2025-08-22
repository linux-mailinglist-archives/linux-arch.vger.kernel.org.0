Return-Path: <linux-arch+bounces-13249-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC8DDB30AB7
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 03:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6754B3AB541
	for <lists+linux-arch@lfdr.de>; Fri, 22 Aug 2025 01:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF551494C3;
	Fri, 22 Aug 2025 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RZSo1OIz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PuIXZg8p"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39DD7260D;
	Fri, 22 Aug 2025 01:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755825437; cv=fail; b=CxZq6vkTNtIcccsvKAAoR9pGCxDIDvyY9GZXo9OUB27QP127scfwZZ1WxNe0AHLFCCOSIyoQqVSwNq+tasZ1sOzjHuv2lnW/sYb7JzzMsRXnbQf219TcDssy4QG1PodaTYPvxPH+15jYaYpvvGY6zvSRHpLLR/GONRGgbaE64y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755825437; c=relaxed/simple;
	bh=7jBg1la+qF881v3plnZfh4zNWPniXJ/+cIKRbqv9dtA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=eCaA3y5tOnwt6Po7NPSIIx9FarFlBIv7PkDOKYH5RK5bOHuXUMSKZqjU2ybmIc9vfc4rrsMVlp5xG+UXbWSwxqIxKBO9dlWwWuv1hIzeXnJeuvpXmjxyG/LxU6C7xHJ64OGOOQ0sY5hrs+jMhj9zdln4VhuMBR+zQr+K6S7Tfjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RZSo1OIz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PuIXZg8p; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57M1FYLg016905;
	Fri, 22 Aug 2025 01:15:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Or3cKyBfIfPIG9eMmC
	yczIjx3Sok4swIwH/pfnI5n0c=; b=RZSo1OIzaEbxYcuUqpQvKe8CHffYRcW4t8
	7QhaNb06iZ3wgh6Oi5TbJd5lN19ReX6SsrfBrvGiStP+sZptGR/rfSG72dGIt3sJ
	bAEjlk38md7uYbt4o3K+QO8Hi/W987zHK6twbOCtcFwqr6EZ8AvNmr/jxOxmiuu+
	41IJW7jg8R7ZTnfXf/oY90TeDGFRkYl/8ZfzdjjZYQk/QBrZ6xHCj+etJOT7I+Za
	guE5EwKUw2WZd7A/zm52tnsUjtQ1dzjS0JvixvBi/OlIZUBPwvVTMBRbl35z29Hd
	/S6eLbZ4yg8jh1uYIjJGt7sfAOvx/IATdqLIC7DPJI9C1WLwOElw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tscq51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 01:15:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57M0MgWZ030401;
	Fri, 22 Aug 2025 01:11:27 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my3w366n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 01:11:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xT9pOmMGtQXtOifwaksXm68lFECCIvljHbOd/DM/t2UlNlWzVYOduP+03uw3PfxwR2/xopM8y+dllgbTen1pZDb7bdxF0AtJ5bhvd4ZBqvh3ISrGugC+ZwrzC9SnmEMFQOIR3RdUGk/2bTDc6xDbAMZtNgAWXfhNC01uRwJd8LdXS55KoR5bBZtlPI8rjGoeoWhG/PrEikG8yErigh2cYk1muRV+4Bv7qZnN/oatKprw7cEmM0aO55NOetucBq1AORoTo5ANytQ2YVNi7CnvcMgbgIhGisc4KdFmEBKwLni1PTBsrETnkwCPo0DA1IcoNf+bgO8BWk4H/Ju6UJZkFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Or3cKyBfIfPIG9eMmCyczIjx3Sok4swIwH/pfnI5n0c=;
 b=c6ckbtwD1nY5svYK1BJ24mLfTZeggWHrSjtBxK1yfAWrSs6CxTSAYvjLwUEcv/QiA3DCYdmg8tx8g3PlrUFHEEoRAuRjmYQiinFS3p94Tn6LzxaXVsTo47nSPEcIT2iNT2h5KP+7S+oGihNAbwK+ZrHPH0VNPNQLZgFuJ9wY8vEIOvm8G2lRirHushKigadRU0YC49qHThCxuMLFdfwJlVV7bo7sdzWCSH8H/OSKOakWLXzE+x8yXIJDRDObwT3UclDkxrIjMT6vU9xplYMUk9EwGp0UTXbX0Pua0X1sp2/GNx+Rk0B4klJzeFNUZki6rAt+ReSomUFqR4HPANQ24Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Or3cKyBfIfPIG9eMmCyczIjx3Sok4swIwH/pfnI5n0c=;
 b=PuIXZg8pwkb+i+Vsqp82rnXbr7ta/Fqo71zWhFetcKVgTvQiSfuUNtZFmFOu7/1XuVSKOE+d+EqkQSJUSwtbL+g5rhyRoT2PZSZKESSLdGLdQ/V45cgVvjnnubAXkfvoLNVTb0cfC+rw+l72WHluPz2SCSVguJLf1thuCIgBZm4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7574.namprd10.prod.outlook.com (2603:10b6:610:180::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Fri, 22 Aug
 2025 01:11:24 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%7]) with mapi id 15.20.9031.024; Fri, 22 Aug 2025
 01:11:24 +0000
Date: Fri, 22 Aug 2025 10:11:08 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andreyknvl@gmail.com,
        aneesh.kumar@linux.ibm.com, anshuman.khandual@arm.com,
        apopple@nvidia.com, ardb@kernel.org, arnd@arndb.de, bp@alien8.de,
        cl@gentwo.org, dave.hansen@linux.intel.com, david@redhat.com,
        dennis@kernel.org, dev.jain@arm.com, dvyukov@google.com,
        glider@google.com, gwan-gyeong.mun@intel.com, hpa@zyccr.com,
        jane.chu@oracle.com, jgross@suse.de, jhubbard@nvidia.com,
        joao.m.martins@oracle.com, joro@8bytes.org, kas@kernel.org,
        kevin.brodsky@arm.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        lorenzo.stoakes@oracle.com, luto@kernel.org, maobibo@loongson.cn,
        mhocko@suse.com, mingo@redhat.com, osalvador@suse.de,
        peterx@redhat.com, peterz@infradead.org, rppt@kernel.org,
        ryabinin.a.a@gmail.com, ryan.roberts@arm.com, stable@vger.kernel.org,
        surenb@google.com, tglx@linutronix.de, thuth@redhat.com, tj@kernel.org,
        urezki@gmail.com, vbabka@suse.cz, vincenzo.frascino@arm.com,
        x86@kernel.org, zhengqi.arch@bytedance.com
Subject: Re: [PATCH v2] mm: fix KASAN build error due to p*d_populate_kernel()
Message-ID: <aKfDrKBaMc24cNgC@hyeyoo>
References: <20250821093542.37844-1-harry.yoo@oracle.com>
 <20250821115731.137284-1-harry.yoo@oracle.com>
 <3976ef5d-a959-408a-b538-7feba1f0ab7a@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3976ef5d-a959-408a-b538-7feba1f0ab7a@intel.com>
X-ClientProxiedBy: SE2P216CA0048.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7574:EE_
X-MS-Office365-Filtering-Correlation-Id: 1835b6b9-67ca-451e-8269-08dde118cfb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XEtl242d7zGuz8eFf0EJCmFCtphtTyTyFDXexYWqaYflsA1axCn1tb9hepa2?=
 =?us-ascii?Q?y5wWkUH2O9HgI50TtcIWX8SerA+xcc6LTy/U164vb0YDUKcFnif0n+mwJ6kZ?=
 =?us-ascii?Q?L4AJXN7XoSkKdRpbPK/80/H4hEbd1CEaHihNmVz9VQ1UCLc/XhUeJCp1IMLZ?=
 =?us-ascii?Q?I53c3QIOMMV/rnCrGMnytryht6wZAluDMtpq35eEl3DrWLdxfe0NBynMhWWr?=
 =?us-ascii?Q?lfklgjc9jKuL3RZUqXn3i2YsOW/SJDvSBOHgdLhYlRcM5BB6vBzfmHQuvdWs?=
 =?us-ascii?Q?w8Q0xmXvrn5jQdCXZLhq4Xr4qpDsiD2i+XdR7qEUHoymOuGXOHJ6feDoCPOj?=
 =?us-ascii?Q?uOASsiBv82sB/HVtnraw5JRm5m/5/hp2qBW/8YzptkCmsIlF9F6D3yHVx66e?=
 =?us-ascii?Q?1/XCzFFHPhL7lRIHF5KdStIN/BVcCIo0Q2I/ewk1v+OU01ftciPQ2wjU5IQ5?=
 =?us-ascii?Q?y5oLixdc4Vdjbmb6bWitogBB+ZyM8YyUyhlz2cn2/0tZmUdWEqEkGck3kFVW?=
 =?us-ascii?Q?C48uX8uw8F4yNnwtvE2hS/pHnwWADqs+8kaoK0LRy83BYqh8s6HU90wrImzH?=
 =?us-ascii?Q?8Xa4DHFg4xO7n8IWbTiTJxiqOYea9EzJ52ngge6fFjkvYErgVraFbVspCt/O?=
 =?us-ascii?Q?FO/xmpHfVntbQxt4o5cvVo3BqCZWx0qVyc2TDT6XcuOgNDj/kdzftWJr3o+K?=
 =?us-ascii?Q?pio1suWLjmjGneQvPLFsNOsd2jdH59ja32Y8fpksVlXCM+UmkjEIhq82zM4G?=
 =?us-ascii?Q?p9zPxqq4hQbg7Mp7VeSl4Eo4AqQStk+4oFGWd+l6xhobNntbCKWuqANTQBjr?=
 =?us-ascii?Q?NWkhHEkISz2RYfUYyyIGXq6cmVIvuNLCUIl7BvEPncp9XjKhpOAsV8vj9KE3?=
 =?us-ascii?Q?RRMLGJqueILN2C475SsstgQobfMXk/klVvxl/Ah/5UEFPuAasHV2NOD45+NT?=
 =?us-ascii?Q?zzFTArWr2bF+Fkwd2pzr6ojZRMQlt0IGdHqH4asRFhqwINWKAAv+VdLDrKUU?=
 =?us-ascii?Q?ZGR2rYBetDfcmB1XVB4HzWEvyqrlQk/74ugV8DzoGr5Dobr6zesKSK3cTJSa?=
 =?us-ascii?Q?P66JqgJ4ZBEhg1V5FNSysexWn9120uwK3l3KL3tDhwvUy9KdmSO6f4JIFkCj?=
 =?us-ascii?Q?qg6jRgBAeWiO7eX8WdHcsyHOQ/j93RvTh1qNhEO1xs1ScdZ0Zs7WGRuDlbHe?=
 =?us-ascii?Q?R5jh6bU+FuzgA1C2B9hR54aXY8VZXVoiZnvy4shFeJoxg13dJbNiFl4E10vJ?=
 =?us-ascii?Q?W3wWs6pWkP3h0OkHUwpZIfZO7r9EQHz2vKa1ZGS4VXO9RMqxZOYGbzkwD5RL?=
 =?us-ascii?Q?kSVE0HCg9Yd/6OrRzPLoWIviOaTOIhndL/nf3FVj5LfWrtpvli8Y8Z09B8BQ?=
 =?us-ascii?Q?NY5hUznsyXd2YAmGLkugU7uqWv75ixCSlBJT4hoLxwyiphMbNmSu5LpU0Gls?=
 =?us-ascii?Q?3lsxicEyy78=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3T6HIHgsjG3Vhdpg+QLpoZxxjy/BNOHgTL20DGDtqm6ra2gQz2YQMQFNDpke?=
 =?us-ascii?Q?SSGSs1FR+XBHzcHF0UHamYDi53cpCw+lPfIRlNHnJ88DKO1n5Bk5/1e6YsHn?=
 =?us-ascii?Q?zPfuDgUDI7Cil9QguPVInSu9WKARCnCbq2WefVXfjai3NTg+3grjRgmhNj5o?=
 =?us-ascii?Q?dlIl0JvKODKih9iBjiM5J+/yiNDTpLE3HmtwNg3qm7cblBbiG3XKwbA9b7By?=
 =?us-ascii?Q?SSZNT6NOxh94Z3+1HM8FRMo1/pHFwdbor3UbEGh33umEBu3O970fvdRnH0GX?=
 =?us-ascii?Q?Sr0UAOzqgqUnIMOGjF0WQovfN1McM7cysvww3iVyIGHzkeq5jUMgedBSqnL+?=
 =?us-ascii?Q?fxwpQ2gQQtrZG4gOADrc61innpllYrsbZ2rSj7LmCXMPsBh1CgV/OMd26pJ/?=
 =?us-ascii?Q?YWCflKz51wqDoscwfZDRmjRfgP7WjGFT15idqHOErE6Ki1t4il3AAae4sRm6?=
 =?us-ascii?Q?K+tTP37VN/ln27oXbgxTE5pDDnMuRtgWQe3nHO6mbB9huVYb+jBq/tPUEgJM?=
 =?us-ascii?Q?kBMUhC9oS3m5b6ih22QD9zdofWwJdUrxjkXKn4AlcwrvJ77F17pzONPVNXxZ?=
 =?us-ascii?Q?J3WqJ/XEjaKgDFlKtBl/UT+GUwOoLqh4hkqgQL3lgePGMRedGZf0OMEuzDHi?=
 =?us-ascii?Q?YInOtpqRpP3Gu9J4JKiv3HknpIoYm7SgMylK5ezsezYuAgyvf3JqeNxZ3TDC?=
 =?us-ascii?Q?jvvTJh7uM/LIR+lSh5AeZgsow6G3xGdhIFBBvcbMsh9X+/FdgQ46xQqE9CdR?=
 =?us-ascii?Q?xqKb/E0DFwIDZ7IcJuLUiY6MhV445514lwO1eydZtfQkdIjHKktuVpxp8WSD?=
 =?us-ascii?Q?N+OsLv+LMgazFTRa38UenVAccGxsS3vT0p6Db/cUFHLjev9yvIX0Gr1NHUyh?=
 =?us-ascii?Q?3sGIH2YryavXLKZeJlIqutVoncG2NlEvWKi6o2xBU7LiyksjcRRYtcqWd67f?=
 =?us-ascii?Q?koeHThSCfhRZtGXEas/QXGMoVHlgnG+/OhKb76G3QYxRRv15J5U3+RS5rzFS?=
 =?us-ascii?Q?AOFOMaghFb+olOu5BrUyaD4eUiv1WIovQl7otygeMcPC3XLY0PRTHGw3dFrC?=
 =?us-ascii?Q?RpMi7kIM8TRsvTep7mnmFM+kFvv8Hs5pj17wjUuZ4m8frOopxGVE3d7pK2Yy?=
 =?us-ascii?Q?sW+6B4Uwjxn0WzDHTMeZUGw9ut8H8rRnDkiHJyZCPlbqIhAgEqeeTn1X32iI?=
 =?us-ascii?Q?RJbCp3NXSERGSlzys3O+P+ii+69SXc3FIINjwQwZi5P11rPAAKJZRH2RWcPP?=
 =?us-ascii?Q?6O3z1nkgSSpJKxefFBi6MGDByMXq5BNrI/l1OBF3Bb0eDRyYtWx+OMX/C1Cg?=
 =?us-ascii?Q?eCVuYXyYb4e5ChnQVIVCSIqhqXMl9aT/OeAceAhmOPKrlAS8Wc4nujN9LhY2?=
 =?us-ascii?Q?35vWPSk44TafOa1rBKEKDpWDLCHSORgpLS95YJGIZlAG/ukHiNzoe3oso+Kt?=
 =?us-ascii?Q?t0NNMflAxTSm16Jk1CuX6rkjs8MVOD4rRnLrN2vJGjMpbWZEc8jKBymBzWO1?=
 =?us-ascii?Q?LmMKy00dWA/WKXwAWjBDnH/P+lsNdVEu2aEXEaxqdTsvKSC7h9fg0kOcklJZ?=
 =?us-ascii?Q?BI02kAV/KwpyZZsKypF/fBxkte7wGC95v7GFAUOs?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OzW0KaJz3M6kZf8fcYgD4NC4KA2d8Ez0G3ZKoskioCw2y+WgnYEXOvF1k9B/RY8v7of8tPVUEw1pAeTE2mABzi5zLDchGksM0VEkrJEFOku6948U1pwVAq9ocbPkD5oBGcTQcONcOb8QIkculh2OqVV7NAuiYZrTJ693gQQSV/GkW9kNXPRxjCDdIQTCee2y93O4vvDxlpK7kPRql8qwqP0lP2OBXw8yfp0qiQinhPF9Wutb4Q6tX7vuX4P8Xu3DyrYGLXLttZw4jjrEeircIuxtAVcH83rXMFD9nGTl0BcBFQRCp6cNBNyZ+PYISuphktH7dkTjoCgMZEchBUp0MmE6lp3+BXuIdRIkHoXdZi5cvV8AC15zc2+UuXGoinnB37sebVnlRaOF0UUtRd0PDDp8P6n0lx7qLN6hSnXRCikoAUsGoSQuqk6nwbNdXCKhzqQ2BrL8ajyUFot8sltXnC1/AWLidJt3AHjWX3g60gL9VpB8XJrINmVYhJ1lBNDfZ1PvfnrrJWdbm4R9p2+ln/L4WqqdEo+e+tVtC8kN2tI0pzZRvegmJmGBr8n+FdhYclZdN8T3jq5JeXnzSYfcXoIrUqwwewTQMWGFKftpeP0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1835b6b9-67ca-451e-8269-08dde118cfb8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 01:11:24.1710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ms6t9KEWCrnsgRlA9gK4asAvGC9OuIhubeSrmnJSwiqp2CnjvBapWLjhHhebi3yPr8Ns+c9D3+YlE5Gc18VOKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_04,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 mlxscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508220009
X-Proofpoint-GUID: OBwLlpGj2dokzS6y77Gpk7WAnOwBmAFA
X-Proofpoint-ORIG-GUID: OBwLlpGj2dokzS6y77Gpk7WAnOwBmAFA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX0W8JL133su4m
 u2J7ofcHBYhfvrxs5YNtTvCT14x0I8tsOvZ5iY064+MV0qYs+wBNqFRV0LFm6z1BCxbu1jpiZKD
 uIC/czBlzMVOSl+fuLLyihS8jGkpLq3wnkcOgETMXdj6EwxmikZpAk00ubs5fHrRoupP6Ur8/YX
 /BuRa86pKLN5sA6h3WTyxWm5MNmi5eBKpwLkAU2lcWAPtx3M9XQ4tnICnBlkTsiksYleJIy9rqR
 crwvhcvJtVraVRMzpvbt2fIARpOi70kY1cVMdyIKlQyl8zF0QRDP5/nqSttUQCBXNSTnTnDDBbk
 ZUOrVj99qKBpCdQuwtYM4CRVtykTPzC9d7ceD7MVFTj4pTREtGXi0nOFHeoedwrz5KmGPW4KEaX
 CWZ/mJeEyj02OXKbLIWxA3ERse/dY1UbjedDgzA440KNROy1Ufw=
X-Authority-Analysis: v=2.4 cv=HKOa1otv c=1 sm=1 tr=0 ts=68a7c4ba b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=c-l3B2UTeUbyIcVUB2sA:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13600

On Thu, Aug 21, 2025 at 10:36:12AM -0700, Dave Hansen wrote:
> On 8/21/25 04:57, Harry Yoo wrote:
> > However, {pgd,p4d}_populate_kernel() is defined as a function regardless
> > of the number of page table levels, so the compiler may not optimize
> > them away. In this case, the following linker error occurs:

Hi, thanks for taking a look, Dave!

First of all, this is a fix-up patch of a mm-hotfixes patch series that
fixes a bug (I should have explained that in the changelog) [1].

[1] https://lore.kernel.org/linux-mm/20250818020206.4517-1-harry.yoo@oracle.com

I think we can continue discussing it and perhaps do that as part of
a follow-up series, because the current patch series need to be backported
to -stable and your suggestion to improve existing code doesn't require
-stable backports.

Does that sound fine?

> This part of the changelog confused me. I think it's focusing on the
> wrong thing.
> 
> The code that's triggering this is literally:
> 
> >                         pgd_populate(&init_mm, pgd,
> >                                         lm_alias(kasan_early_shadow_p4d));
> 
> It sure _looks_ like it's unconditionally referencing the
> 'kasan_early_shadow_p4d' symbol. I think it's wrong to hide that with
> macro magic and just assume that the macros won't reference it.
> 
> If a symbol isn't being defined, it shouldn't be referenced in C code.:q

A fair point, and that's what KASAN code has been doing for years.

> The right way to do it is to have an #ifdef in a header that avoids
> compiling in the reference to the symbol.

You mean defining some wrapper functions for p*d_populate_kernel() in
KASAN with different implementations based on ifdeffery?

Just to clarify, what should be the exact ifdeffery to cover these cases?
#if CONFIG_PGTABLE_LEVELS == 4 and 5, or
#ifdef __PAGETABLE_P4D_FOLDED and __PAGETABLE_PUD_FOLDED ?

I have no strong opinion on this, let's hear what KASAN folks think.

> But just changing the 'static inline' to a #define seems like a fragile
> hack to me.

At least that's what KASAN has relied on p*d_populate() to do...

-- 
Cheers,
Harry / Hyeonggon

