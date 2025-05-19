Return-Path: <linux-arch+bounces-11996-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABFCABC8AA
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 22:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2157C3B58B5
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 20:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C7FF219A94;
	Mon, 19 May 2025 20:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XMPA9E3D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="e3AhaGOx"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EA91DE2CE;
	Mon, 19 May 2025 20:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688019; cv=fail; b=Tm8SOCGkEn5hwoJgJARltJtFZx6xoElZ6u2fNGbzYWemssHDSpTq2suFUC/buo6tJdiCg0gPpyKJ0m4b5kGngMiM40TeTCauAgDf14s3ZGDJpG1V0eKTxCgyM5LVJ+DkWTPGNbMHzcQNKLEikZoma7rQYFsapzbIGq+TqvV5pJc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688019; c=relaxed/simple;
	bh=Re67SleAxBNnx2K5PEB9RlXYZUe555sGGRUCb59364Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=arCMpT6//CvNdnh0jMWb4eloaFVSFL6Haeh3hdW/y80GoWCiwPS2UGx7rwCKy2GM0tv+CsM6eX9rewlL9Qz3F9QWICeJB8INMFM0jXmC2QiNhviBZKYAtbVMJ//dMGTFwQFVfGqsfmzBIVL6i91d5S3tdoFM3DN+jwopnxWMKyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XMPA9E3D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=e3AhaGOx; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54JGMo61026215;
	Mon, 19 May 2025 20:53:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xwiYykbLjT1zx47mtE4zv1uAEKu+ZFI7Qc4MYu3r2po=; b=
	XMPA9E3DAAxuAnIs4KaPEvk1ipp1o/zCqkxUTmQTXyCGG76tq6mQ3W1IcMcvNH6d
	5qjLB79mlQ0odw3+tBOGykBKkvL3mdH6sG8Jlm39CWypLLhGTOTnrQ0NZe/FauNS
	qDq2NyD5WZJpI1wtvlJGRr07aaC9YJTTsJwfgh3MzbApxyDJY9J6Mri+pnho6bW0
	gR8hEQ8gODdZD5vfcxnqV81SUkZiAE4QYLsMbCbqfDOkvmnlIQim5mQzuG3jfjDc
	wLqbI6GuX3JJKa5XIHEc3mebrIGqPn3piMKypYUeJ5mSe/wrfZGu9PshyNsLXrdH
	ke8RDooVOtfUqjfnbKNaIw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46ph84kyjp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54JIt9na037297;
	Mon, 19 May 2025 20:53:24 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2047.outbound.protection.outlook.com [104.47.58.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46pgw7x70m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 May 2025 20:53:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IK0nK4ONIpBmu1sPcqiifMjUXvGkEswJXL4dcrt5y/LdF01Q9tetAqZkDjPWo4DYZIe3JVXs2VKmE8V3L99QZ+3d3XUVbzOD9PlvZlbAl/34t7RaFet3acl2QXxiDOH5oAPgpAxN5bLI1aHfOnLdWz9snLOGLcwS8Aw7Jjh1HlS6xA1DmL+dQmmWvH/Ky6a2FTuVnael5LMnyYj+v0ZQU7kHX2slcl5aITM3EwnFYaWjqDyELGGnL6IanebgyCJfM+oNrALxzNvBGMXxSyVbxXk9AjCSGf3z7V6vM9PpgkEMZtSCvzWvzBf2ht/m7Bwi2/8bfzJTjZWLmFHVQ8pqEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xwiYykbLjT1zx47mtE4zv1uAEKu+ZFI7Qc4MYu3r2po=;
 b=WccU93g6TbWrSBPUPXqH0iUAVmfD4fNkY5C977vI5Z8dwiTWZFzwQ0nvMwqubUN+/iB7f7nTz4KspYpnmwCbKHg5mo+LK4WTdIeQyStQXRf84IRV/01WltxfxC1PfsndmfKTE12g6eWeLRVFPn4Li+LZfIdpkLVHQM3eBgGkzU8pUNFCvIqg/Ug8GBF7pFbxOUBJsnC1YWAB2kcCyDkHjQNIknZ+slIGFrX4wLe5P/M3eJrnymUhl4ekwsVxh2EsKmF13fc/74SzUPohgfTM/laPddNe8cgzVoyvWiV2Rz8iBz+o5dHv2Bhe71urjIis24xUAHwLProH/hkB0Hcipg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xwiYykbLjT1zx47mtE4zv1uAEKu+ZFI7Qc4MYu3r2po=;
 b=e3AhaGOx5AoKgsEETvDYs4DO2GLPVNXUgY6l1GHTqir60Li7rctCrikzKKYrdyOWU0QjedoapXfdteta0An8UuqnHGcghklUT2oTmjjemX9vI/gUxi4O4DXzeuN/BdUNFTcV8VPfBM3b/n0iEIkOeDdNABj3BkVxup6t1IsPz70=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ5PPF4B2F62DBB.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::79d) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 20:53:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 20:53:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>, Usama Arif <usamaarif642@gmail.com>
Subject: [RFC PATCH 1/5] mm: madvise: refactor madvise_populate()
Date: Mon, 19 May 2025 21:52:38 +0100
Message-ID: <96503fba082709bc4894ba4134f9fac1d179ba93.1747686021.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
References: <cover.1747686021.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0060.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1::24) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ5PPF4B2F62DBB:EE_
X-MS-Office365-Filtering-Correlation-Id: 0a37d98d-98b6-422e-417e-08dd971724df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1T1qDsjniqxuoPtMJXKbHHVEsrbdRoZnO+bS0l46c6flErwlhGKdAAWm/h9G?=
 =?us-ascii?Q?aTWaGLx9933mLPHh+5uFD1rSUdhvXjz+hsC00suVDj2zOc7wW39cYYRbDy1L?=
 =?us-ascii?Q?YjocT5lnVfnOasZh5TFYq48gpi8yO9yNopSpc2vKn6Nj3oPSnT9HQuolm4Lr?=
 =?us-ascii?Q?j3nR6dAfFS7bMMT4q4LZTY1Sk3Zr4Dv5OX6e0+hKEdrk6zkqPbPc7MrR+NMP?=
 =?us-ascii?Q?C1S86FijpnLdxwr8Z1THC8fOgs5hQy6wvnLPqmgRJdlyzAX5Vo4WI0qjsnGz?=
 =?us-ascii?Q?SQPRj1Slz6KE+gGDr+BaFf7kmuEE0AJSZkJdk4Bn5AP1aYd7ky91P1IOKLyS?=
 =?us-ascii?Q?oVgCrEM2BcRgq9h4Qr21mLO2p8CMfZiVM8Czov/jFtOtualkLudw8xorjQts?=
 =?us-ascii?Q?CHAza0+NXgVz8w0U0uw++zGyhpYt+WG+nWpF4WRTQ3ToJuI20LhH2GItjRTi?=
 =?us-ascii?Q?sOREQalGcTGU3ZGjfFQkpjN8/6hGzLmjbcy32gNnD7E/wQNwlJxJyboQPI4Y?=
 =?us-ascii?Q?Tnh1MalrKubbNyrdCFq8gtMKIoJfBvxc0y6KfgIuPILRdoy2VEmlNveVbJdF?=
 =?us-ascii?Q?1/7geLllGWf9WWc8r46B3Q5e/ebR5N8iGZH8mm2zNq6nA8T2AbNqIb4O2UQ2?=
 =?us-ascii?Q?vLRFA3zQXQj9jEwjFtWazAu3rxobYS9yxErh1MQ0d/XKb62E1By4EhZYcwbh?=
 =?us-ascii?Q?7AUdct6Uxhr0DvtmdC/ushO07fwYqD46ZW2VQcd4HyBvFwi2m0mRFhD++E58?=
 =?us-ascii?Q?b4a2xcqkcQenZ9msEtzk9AGsIN/6nz8kyUSfFG/mdIcjb6ONf50olD9JNGNX?=
 =?us-ascii?Q?HlI5xkUkrlpZ/Uv4wOYbKDaJekDcsn2WC6Uuk3vsu07bnaMZTDWuMGK5skgG?=
 =?us-ascii?Q?j9I9LZSiEKLFbE4l/JBmvr7esr4R0W1M12rf+u6sovn5l76zMQXrAFnn6lhC?=
 =?us-ascii?Q?4vLndyCepzbpoN89N9Bn+9gL5mnF4W717i8TOIfmzq4UUg+8DW96fW5gVk8p?=
 =?us-ascii?Q?wGqRk9wN/XFKTFRQQ+f+7cqmb6lJ7JdnYSbRA/qtOG6X/IoyNNYOLlxfVrkU?=
 =?us-ascii?Q?t5qUxXUVGWf0CHTHozfxkzFFzyARZ/xnHBvGUjK24uTMc/U1O6yhX7Uo/kHr?=
 =?us-ascii?Q?FpvPtk9YKhz7s4o+fXIgRMGcBkQjs8UTpmLLclG3CluhW1hoecBHfhIgmpUe?=
 =?us-ascii?Q?EJe4b2sE9tXoDqWFKAMUoX3XsoLeTIZmJNhlJLKIZvnjhpV+XkT3MXI3Iep4?=
 =?us-ascii?Q?BUd8WenfoYEZjx9ZehDifcZypsb6Ci3sFzjvCPOmGuv3ng2VOfcADSW/qSYw?=
 =?us-ascii?Q?HCStZxxN6kkotLSqpLf0vrBVYvCJanwt2b628+T59U/NFxazP+YnkTofjndr?=
 =?us-ascii?Q?sFYhbY05Ec2JI9LBbCQcmCezAzbfMXNwjJBjMQJfKGUXf7v46O2qzn+jVhB9?=
 =?us-ascii?Q?PJVOKbgnnPs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QmZmyvTu6U4W2N/vOjQc9q7Hu+kvxXFF4pkLuhgNDyFwKcQYu8QTSY4BIJWe?=
 =?us-ascii?Q?5z5s4yidLFOgqekChHBTR+ShTl/5Bx3CXuXBupDY8BKBv5fQAtgUeiAeI+SS?=
 =?us-ascii?Q?voatWtrS2q/GQW4xQ6ngOHLSpmHxC0jS4h2iN3qa0lV5pM5yqE5Gf2NkZ9fJ?=
 =?us-ascii?Q?Vzu5in7eYjJZi60K92RnRAXItdGmulvdG/MkTPB4bXdAXzM3gBzbpIiiurSN?=
 =?us-ascii?Q?ZJFFxxEE/NlbcXvUiQtcdmMOytQDj5winVED2baT/QMiH5o6SwzmwqkKmSfD?=
 =?us-ascii?Q?lLRNuGsGbtgvij9KZoEDGTeaDGpQ0mmJYP5zqHQi98iaffbEg5/wP07ChbOV?=
 =?us-ascii?Q?v5yv8E3gqfZuyXcRU7m5a1EtzABPuXGWOFmr9ZMXpstwMOeAXFtAUAlwHbET?=
 =?us-ascii?Q?VCZl6ymeuC5DsiPn8Flg/y+IXjWK7T7QXq2Ga6NQQT5rBU6uE9fszmiN8y9j?=
 =?us-ascii?Q?xs5PtLMaDwX6+s8eNe7e7e/UUBIOcwMdmMFLy+eZiTaF/eDY+YWnqEhoOP6z?=
 =?us-ascii?Q?3I1BS0w9JR1DIjvclJIJM8GrnGzrYRL7MEmZK21Ri7HHyiUiZfHMR/54oTsx?=
 =?us-ascii?Q?aj/diE+a5pGqmFIyQVBKlzQegyAuIBBYb9AceO6vP2hlVmrq8S1HJWEB6bzR?=
 =?us-ascii?Q?rMwoJ32aM9G0ZTbrZvtpvfQU9TRL9jtUfVJO2RjEOXCFTfIZgfehIZsDnEdu?=
 =?us-ascii?Q?+1p9o4kVtabcrMZkITZANzIMZDS7cXJaVvDQpHnQWnjtIgG39h+tMp7i2pAm?=
 =?us-ascii?Q?ueuVomBR3lAkMW5a9hNWcck2x8C5ST0PxO2X6W9PzUIzRQNBK+D0un6A7Szj?=
 =?us-ascii?Q?+69p+Mx2ogyuo/BuUHdjFiIY4GitnVX0EXxhVTxR1fW+umdLO03DKvF0khuO?=
 =?us-ascii?Q?+M8JIdANnx3SLryNvYmFXGZO+13V7PnCWk5Sx99TDiURMq9bR3ZI7Yh9hZV/?=
 =?us-ascii?Q?QIYSwDdoEF6Ea+KJxmNSeD9wpEQWksOOQtyagsODo+sOYGV6UxLarJzQPEUP?=
 =?us-ascii?Q?pj1H3LMUhGa/PuSo5X7u1AtWXV8FsE4OgqlZBouW9cdFeGcGX5MROil5oUNn?=
 =?us-ascii?Q?fIJSD3rnOLbb9Wo68CK1JLIRdnGsShIdnp6zrdMf/m/xVjvFLRKorDsgiR8W?=
 =?us-ascii?Q?9mwpMskqKruNEZnIQ6guFLKmV1OMUcgcNSBqqYya7k9po7I8G31yjsya7zP8?=
 =?us-ascii?Q?F3lP/40n0MKU5X/9rE4u6PStDgyQwaulepi5/ZO1TTnnCriNaNJujDQ13s6C?=
 =?us-ascii?Q?TDpQqGCJ4vGgFV+ZJUhbOSRdn7KBGLWalu2vWKHY5C6dRnGoV/IANwSm6k2G?=
 =?us-ascii?Q?Zah2ruIZvFVrwaSH8bfH3cGy9CF+4PluBlJ2D+VBw8XrJZkCSaifg2QxH2F+?=
 =?us-ascii?Q?/UD0UB4ENrarv0CZ60NA3iMzMzBDcjf9VUk0AT+0WDCBKEX7QcJDDs/fmHyj?=
 =?us-ascii?Q?yz0wAqTWeoNeO6V+U7Jdna08Sv8+8UDR0E5hrM/B7WMY7VTcPEG0MPRahZPb?=
 =?us-ascii?Q?6UvlDr1aWBNDsWVUvHfcxcY5GZz+Y2A3FNkhPQWYvCF8U2gr1WyWE+omBbRR?=
 =?us-ascii?Q?FBM1iJD9Rdh4LPp3NElcLd04r5+98CfpXsvCzCgPx4sw2dMDN8CdHwcBbeEn?=
 =?us-ascii?Q?9w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	T4Isx9jAm32s/i8odxM6+dCgjcRisY1ee7oJDw1ayHV6rbk+AD/dmvIdKWm/gB5KynQz+jcoBe3v2PPf68DlLtcxYtwUJFO52EUt1vyFzRYEODcQ9Ike5dCIX1/GanlEs4JRjCDCXHRmpjqTgLBLgsWbzIU3yR2Ct6SCaDfNmAEBPaEpdTRpbOJ004LRfIi0nFH7+42y8w6hbObGaPKISGtcr/wwUChQ38HmXITByY/dl1R2/2ewzs6QVyJtBLT9Dy1rRnv/1jQ5JTW29dL0BEUHPcK50jUVEFQ69HoO8PM/mi8NenmF0d3wJqVxnd1ImxqpgSiyC7shsqlNVC7wiZ5kZwdE/moyEzjuO30FFx/rHzJ7KjvC+4rRf2ZLpLPXbYXMoutAw9eOyrM3NLwDrFMfyfZ3vmlik1tVHXI2O4IinntQ8DDJr3eap8ipDIYVDctbNkr6WLHlC/Vir2WoKdcIM8BKC6KYlNbeUaDXU5GT37E2khGdRCiw3PplZj4XhtC0byQ80D1tYLFabX2HekdpGwlMpIBMRPqaBoGmFb1E3JklTkPNTGFi9KJ9Reb71kT5tPp7p14XYPetXIkJeU9z+4vtohC+djtmVM/5ZFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a37d98d-98b6-422e-417e-08dd971724df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2025 20:53:01.5905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AcWOfTWPuzGBn5ZOc3w7w/vWboh/pqp0H1ZQ+vWuYoUcQXwlUejEFqM/E0fUvyZPAFshXRGUpXcAtp51r60K57r8rAUJcoFq/ZOYJsf7rIU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4B2F62DBB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-19_08,2025-05-16_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505190194
X-Proofpoint-GUID: 8eoPyEtzWSN55N6vUt_N9f3DveQzoCHB
X-Authority-Analysis: v=2.4 cv=YPSfyQGx c=1 sm=1 tr=0 ts=682b9a44 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=TivQtNKgAV_h2yWK6KcA:9 cc=ntf awl=host:13186
X-Proofpoint-ORIG-GUID: 8eoPyEtzWSN55N6vUt_N9f3DveQzoCHB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE5MDE5NCBTYWx0ZWRfX0O/sMi+eeT1E tf9gKqIT+GU2hEXZ3O4voIPQbCdg51SBLFKldh81VJNNF7S7KfWcqIJQEjPpvB7zYEvbXHy1uZ9 nTBmdBnIofE0QyYZbPxsIkFCHBp51cCsmxHIWTnmQetB6QaBC3AeVNsK7Z/3UZ2kV4lzTqGsMhW
 DTQHNu3m63JbyNJVdxsyqXsPxyQprneXWxXGEk9l3yGDplWTYgp6rVMFix9mmSfr+MWmboWs4Yn CbO8MY+jNOfGrEVOAV++dPj864iz8fnULx5GodxpnnsUZQZ7c9wI3NRGmUdoT4utX8SMRDvPfPC P5A/KP83wt4kzannB3OOZeno/W5fqkGV5H5pOeFLjNNKm2A591EvA/kixl29KprA/xoRJUTo+lH
 BLBz5/bskrvWopOEYuPxEfNt8KfODkBV5kh4lLEOPdlUWvclMBadJmFhfHZO4Htc2bh1Bo3Y

Use a for-loop rather than a while with the update of the start argument at
the end of the while-loop.

This is in preparation for a subsequent commit which modifies this
function, we therefore separate the refactoring from the actual change
cleanly by separating the two.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index 8433ac9b27e0..63cc69daa4c7 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -967,32 +967,33 @@ static long madvise_populate(struct mm_struct *mm, unsigned long start,
 	int locked = 1;
 	long pages;
 
-	while (start < end) {
+	for (; start < end; start += pages * PAGE_SIZE) {
 		/* Populate (prefault) page tables readable/writable. */
 		pages = faultin_page_range(mm, start, end, write, &locked);
 		if (!locked) {
 			mmap_read_lock(mm);
 			locked = 1;
 		}
-		if (pages < 0) {
-			switch (pages) {
-			case -EINTR:
-				return -EINTR;
-			case -EINVAL: /* Incompatible mappings / permissions. */
-				return -EINVAL;
-			case -EHWPOISON:
-				return -EHWPOISON;
-			case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
-				return -EFAULT;
-			default:
-				pr_warn_once("%s: unhandled return value: %ld\n",
-					     __func__, pages);
-				fallthrough;
-			case -ENOMEM: /* No VMA or out of memory. */
-				return -ENOMEM;
-			}
+
+		if (pages >= 0)
+			continue;
+
+		switch (pages) {
+		case -EINTR:
+			return -EINTR;
+		case -EINVAL: /* Incompatible mappings / permissions. */
+			return -EINVAL;
+		case -EHWPOISON:
+			return -EHWPOISON;
+		case -EFAULT: /* VM_FAULT_SIGBUS or VM_FAULT_SIGSEGV */
+			return -EFAULT;
+		default:
+			pr_warn_once("%s: unhandled return value: %ld\n",
+				     __func__, pages);
+			fallthrough;
+		case -ENOMEM: /* No VMA or out of memory. */
+			return -ENOMEM;
 		}
-		start += pages * PAGE_SIZE;
 	}
 	return 0;
 }
-- 
2.49.0


