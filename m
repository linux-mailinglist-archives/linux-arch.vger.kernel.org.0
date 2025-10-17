Return-Path: <linux-arch+bounces-14186-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B54B7BE6A0D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 08:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 425064FDC9D
	for <lists+linux-arch@lfdr.de>; Fri, 17 Oct 2025 06:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AF93164DC;
	Fri, 17 Oct 2025 06:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pwGw5uBn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="he3d7SqB"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E7F315D25;
	Fri, 17 Oct 2025 06:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760681814; cv=fail; b=EDFwW9+CljqPFyVmF6OtGzJzyP45tdsZyyrVrNzEGtUbhA7sQGe93PzRam/8xUoenDzLXLxQeIXH4vd/xRHk5FKqizS6TczKQzFjsDfqbel5xPOy2uuF1zUiR4UqIs9MACiytuunUz7tuEjWT5CvkOyf/8zwGkchdMCmzkEkv5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760681814; c=relaxed/simple;
	bh=9662pNQYRpnMH6s43L4bZiNEHjuQxkb9nANkTR5BUys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FGdL9xkuJVbIZZLAlLUBOYc4ezGIgjGJwFoiXyWjF1vXQkfRZUIu6Q9iZhJon1MrdeLJ0J/BHOkKZop2X1xuAKV1hpkPwmextdQumcDi3vqGbVHkQ+8JtE1tgymi6FxMs4M0DbcoiqtYIAriiDiyJ5F8w0taYqTU0IpeP16fU3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pwGw5uBn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=he3d7SqB; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GLu482013069;
	Fri, 17 Oct 2025 06:16:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=; b=
	pwGw5uBns2DvsynR/7783b+s8Ir7RfPo2Fk/ebNOBSNFXSLqryGGz5gJh545Qc8J
	wi/jL1BKV8GJly0M8S1LTLsEpWLEFRv2IvsLQO6QgOJWtv2WttS67RalWiBrujO4
	XHf6tpZi5Ll7BvTbrNf19uZCbIL3y5x1CWJoO14KfUetqc6f+pW4jGYAsvHhkmYw
	jx14vTEB0wBMam3ijQKmMn3P6B3Hg57Ik0pTGUaS4utByyW2mkAegx/DTih6AUov
	+WeorWtTKMSWV0JDiLZAtb/zm6Dz3DyQsQ2gHKFReSQMTF7za1oJC0WEwuKhV/G/
	fJOOU0aPOzyZWoRiwnxyNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9c2djd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H40hrN013633;
	Fri, 17 Oct 2025 06:16:29 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010045.outbound.protection.outlook.com [52.101.193.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpcdpde-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 06:16:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgIYXgAA9d8pa9hwL5T348fm/Q1Zmz2SWa9CZfnvAl+v95FRqtnbayCQjfK6AIhgGe8r+bbOQHcTT2WazRG26dhfpKA9i4ApfuZ20iCV+N/cYo2Ef5MTB0geblzYqgnCtdWZqui6TNiMsi91JKoxSWC4t3xx0UF2KTJSj4SLTwh8e7grLBWG0vQg34B48QI3gFHzB8Zn3hW4oxo/BKpOjARVTOKJXhmVYn8GxGXl+xKfZKwm6JzLK5GJNApEIv8/Be43YPIeV0Yz36OAwhG6o0KoRLE4T9hkk+ojy1TY+l/YhlHoXfLGFJUYzUtPI34PNj+qUNjNgTVYato3o/8GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=;
 b=UK9Dl7ZdjBwLhvkI7+x+iho3uGo/B5RkuqsJfzlymmzTy7haqaCGYwL2KcsmbT9xSHqjrPAawcOoU4r28Acsx2KEurkdv3+xunEg6fD/ke5BSFo1YTkOBoTYzzM6Us/iaUmzTJTAguLMbcbr2drgKzyDlLvn4xx/kAGnQn3X+JPy5sDBhb3sWNN31pDJMwZrnQBH31NgTWjeTEmcxJc2oYUdiK7ANjZv4IUISMhFBj/7zwL5FfiCtO3cfjyfR8JHNiWg0hSOWZkxPiIBI0HikQugAb1BAPMdCbDR3Gk2NhetqXs8S6Def07CglU5Sd5zRQkylVPdbafOz3vFHChgpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8mN4iJDfW/klGeg6dj5QbMEuwZw7mcB8p3q+G9o8ks=;
 b=he3d7SqBj43aUUdbBlpKUFjCOS6LFbXQGXun/MHRtYzseaWo6q0zX5pt72pbEa7eDBsiTDc+L4oEMkrxR3yfJqIg29XFXY49KS2JtXTpADEGQXIMYAreY1+x5NxJM8iGElunTPpkeVrkCjGjyaWG307URp6aTpFmpEJ+Mp7RVqI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SN7PR10MB7045.namprd10.prod.outlook.com (2603:10b6:806:342::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 06:16:25 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::3c92:21f3:96a:b574%4]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 06:16:23 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Cc: arnd@arndb.de, catalin.marinas@arm.com, will@kernel.org,
        peterz@infradead.org, akpm@linux-foundation.org, mark.rutland@arm.com,
        harisokn@amazon.com, cl@gentwo.org, ast@kernel.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, memxor@gmail.com, zhenglifeng1@huawei.com,
        xueshuai@linux.alibaba.com, joao.m.martins@oracle.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com
Subject: [PATCH v7 7/7] cpuidle/poll_state: Poll via smp_cond_load_relaxed_timeout()
Date: Thu, 16 Oct 2025 23:16:06 -0700
Message-Id: <20251017061606.455701-8-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20251017061606.455701-1-ankur.a.arora@oracle.com>
References: <20251017061606.455701-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0337.namprd03.prod.outlook.com
 (2603:10b6:303:dc::12) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SN7PR10MB7045:EE_
X-MS-Office365-Filtering-Correlation-Id: 470ab131-9f09-4031-cef6-08de0d44b260
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7VnvH6bOuuH+e1yF3my8R2hICeyUC/MjdDaYEjEua399dErdtFfQhTp7YWH4?=
 =?us-ascii?Q?RXyjJRuBi6U4SbYS/n7IzqeHtSQcgDQ4TN2O6cHjpyJp5ntVN9T8c9SqXcL/?=
 =?us-ascii?Q?zuUQKRzDz18Pr4CQapLSlXBaHwsXgDBT8SMxzqSYjH4VUm8Nsygt84ryUsfz?=
 =?us-ascii?Q?fVh5Ref3vNgVfXELLgpHi0da6RvTh6ys/JQOkNUYgQvB/Ptplvhnpf71MeKl?=
 =?us-ascii?Q?NexAp2mQ2wSciR8Hj+T2Qvv7F86XesAD7KVM424dN8EhpD6qrw/1yaVF/5LB?=
 =?us-ascii?Q?GTiec9YTZKFYMop+0aZx2vMknbRAyElipBwvAu3olaJxtVEnHahpidPUeYuf?=
 =?us-ascii?Q?1cP54A7n9YWB3XqvwpQg9ftXiipkjReI74FKCS25QHEAaQ+NCXw8Hf9EF2Fj?=
 =?us-ascii?Q?TGjmUEfA9DolAHfrR7wYrTULVD4VbeGwsl9j/HLyCdX7WTklbuxQTD4l4QoT?=
 =?us-ascii?Q?0ABLe84OSIelrmpX/Pv9dCCu4jGl2y1BfyM9lBALCwvC2VUCZivH7OU3BxL2?=
 =?us-ascii?Q?BeZfveZ5oH0yLzckcpZ4KxhByNI7rfq+EnApkrf8DdhOjm/GpJSQ+EL3ZfEw?=
 =?us-ascii?Q?5KoTnVH8eC/9kI/MvdGXt8vIi6HRjicuNhV+dFC/PjMqptKfc4MKmwDGCxac?=
 =?us-ascii?Q?fflU1nWN+HYD52j8ZKv6a4WyK+2lZptBRoKdjjRK64f0OUr5QdePD+6dcBxs?=
 =?us-ascii?Q?4v4Jk02DseSiz9EkddvjHAH/Q0zQCB2WwIPoSS+ykhFli+uhU/FF5CCReXaR?=
 =?us-ascii?Q?4sitDTYicTG4FfNIWbR8hfMncC0BpJNoVlvG/QTLQ0SMRqbdE9J2YFxEoveU?=
 =?us-ascii?Q?PLPjBi58lcqeev6YhKIrvGyT+qzsXkBhOc5mJNQAFhsJb6aY/pyUDWzJ5bQS?=
 =?us-ascii?Q?dEER1EAVwx3oRpRNBM4Jmn6H+rSli6KTPtBlyykHneeA6O6GOMoMzr7treQ0?=
 =?us-ascii?Q?D3Kyt5r90hcWaq7Wt48cYJ1ZOUZEQmvqidqzubrrrwoYQeUrdOuUobCJtVy6?=
 =?us-ascii?Q?EMN6ShgdxRhCm1iqxq65C4RRhDwTALSBwuD8ESjRO5UQ5ylbwQ2Iov3Ty0Xa?=
 =?us-ascii?Q?sgVJh6lYHThqB1zWlHC5wgaV9DjfUcBqu+ggthypeRaGv5SitxZrAS3XnfjR?=
 =?us-ascii?Q?2Duq7B59Bic6YddpR0H9maGd4jmVY4NGCjYiJ1xd76pYsjPNkR5aSMGmI2k1?=
 =?us-ascii?Q?wt/2PoW3Em7PSYrRmRFSxE4t31MkMO7Ol4a1ckINkssR6ycfyIHnTxyjM7mj?=
 =?us-ascii?Q?hufk4o86VL2ebKFLvWLRFd95cW+jGSn5jKeR2wyEnJqa1o+gw+3o7R5bTKeq?=
 =?us-ascii?Q?88KswOu6K3ynP2FJ90GdxmjGvpkoozCKNc7a+B6bwrOiiIzJt6Y27f6bLwNH?=
 =?us-ascii?Q?WmLcR86Aqr7Lw+9ODFfuN8ZGN4CSlx4VT0N+kpljZkZliUObisWarG4Yk6vK?=
 =?us-ascii?Q?UdKwil/waFIFoLxPMKhtYk3wnZ+UDRBl?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?34ej76LF8jEIz4hgmyM7PSTbw9zSs6WxodJ0xRtd+0NAzpZhyodRtLptLe9Z?=
 =?us-ascii?Q?WnJmRVYm3VXzGmIYRTVjwT2mfat0dgd5hVA+uoLR+OZThT/ZSnHPVwtV0Qlh?=
 =?us-ascii?Q?GRnFzY9vFqZAJ73zgwBJ9Rt57ty6KVHh45npWx83AjWn+S4vy3TIrNL9nz3e?=
 =?us-ascii?Q?rSaij6QkTcbP7uH0A7d8AwCer7VfFV5PFBKnzDkQQE0eNs9Xg9QFkOaruXfy?=
 =?us-ascii?Q?ZmqvOSHzNJPZGJNvcaNEVUFS0RyyXn05bW0Py64Gxc5KLukb9P9jvOBURR5v?=
 =?us-ascii?Q?cOTI/kREigL6+IzsBaTBgWKCCcS0bGd2SLGL744jKaQXYxPP3g2YmMfYBXHl?=
 =?us-ascii?Q?xioMQI104nnX9SvZDcyLgkQkm4XvFB6xN9+i//ZpGwuJ9p7yJHUw5qQKbfps?=
 =?us-ascii?Q?Zrr6+m1sWGYyqqOcafQnKyn3AikQMtSLDGjPS161EQXqz1Ssn+xrrWLvIPX8?=
 =?us-ascii?Q?2EToYHjHY2QTXhK3hz36jKqT4pVlx6zj4If0nj3MZj9qvoTiO0Y3Yg8eO05v?=
 =?us-ascii?Q?nw/3wsaXIfY3BQ9/REccyVr2CH3vsBe652sjirC22smOIfY2NN5VRg5UpDqL?=
 =?us-ascii?Q?eaYIqv6nkoZxq2rDFbudEB6Sz7JrYChvo9FMe4tlRDYWIPH5c78BUTeAH3CW?=
 =?us-ascii?Q?csphN0/rHAmSYNWXP4pQ4DJdGuxnVANrcYwIr+l1HbchWx4N/8KnDCxd0GLX?=
 =?us-ascii?Q?FIfaQ7uNM5skNNugfqmkrGh7N4kDrSjARGbD97rB4+9EX3BE11PN11ujAPyr?=
 =?us-ascii?Q?e1NILmzyDdHjS1Xz34ipKfk1VAXG6coOumzfeZEkIOkpGO7dK2Nz/tNP4Peg?=
 =?us-ascii?Q?hMICweEFmgKf1e47tx/ub36u9vYf5JcfgLw+8W35uukEG7Wnxf5LNFqDNRLQ?=
 =?us-ascii?Q?s3iSlNqh0Kwt7wd7OFLmrwVmPGZp6ae0Bjn1D8yxrB1CTEjHY+GWgs4qjF2m?=
 =?us-ascii?Q?RP+5k6HAh59rBo9jYmyHsj7GPRvP+HgHNzpPAfcOjPUmB+D994KXpUE54kM6?=
 =?us-ascii?Q?+D1xQ/6h08PKuAnwfuxZqH/IyLIZGTC0KDlvNgqdBBiXNZPqK48fcVsBQNrF?=
 =?us-ascii?Q?UGqLSCDXFo6xBa3E+WCw2WiH+IXe5HwzyZIIN+WEf/LdXNrmfgNZR1EzicYU?=
 =?us-ascii?Q?67Hv5lbArjyrtvnygSSc9XVvSrHjDJLp3/MwACYxQtMw9yzaz0DKUp1jTjv+?=
 =?us-ascii?Q?ib/nAlPBKWETn56AtibWRfqrvkk+1FCHjdwsoazdc6ebjpbRXCja//oRNJUN?=
 =?us-ascii?Q?Tpz0WHEYMjALBikHDLgT4T/P61Rnh4Ktz4hjg9uxZKPkjERqmy1XsN2XkYIj?=
 =?us-ascii?Q?1VTX+TojKBKAcKMXBhI+if88SzFalsNeIG6rcvpaW8jK3WWgNKECDE+HEzMQ?=
 =?us-ascii?Q?Jp71O8z6pR0BrxK8Iyr2AveyauF/ji91vys9OebZs68FtVndHztNbI6lazqv?=
 =?us-ascii?Q?KMsEJixh8SODFgBdqKtvqL3PWQrSHoFduvGZKND60puOiA1ZgMA5EbAdrfHm?=
 =?us-ascii?Q?atklEx7Yag8fhRiNvjFtj6JSZ0YQ/ejBmCqn4CDVXzU9R+P4tJa7rTrr1qJj?=
 =?us-ascii?Q?5YEKEUwc/KoMuWbYs9RUaBROCWJ6N0RD4rDIzCJKaPHKhOueB9s+uFMI8sTq?=
 =?us-ascii?Q?fQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	R3NYhenRitcSqvNvu5Xri48rwOKTvftL7qCocLzg37OvT8TG2pYO4XCEGbz/Q3bZXkcNJGn+/0tLLczg5WA43wUuucKT1y9+It5EmyLes7Fdj7vYaYr1tXnhYVC91khbBizpBpVwMTgvCskQEv1xr3q2ou/fltPQS8bYb0qX6+gK6vLBIVZkVUwaHKS0Q+8B4XTCyQfs27ju20b01DiE0cLiLplwixTcV/2aosOtIhSUnwECvE9jO3CNKLyiclYVQzDgtHUBh61j1+W3LY/vQ9ooHTvmYwkQKGBsjJfuylqedf5bCKKtZlDuSsnmGMzpZ9wqDnNop+5hoggpTOUanz268ftjC3OTjkgtTru96xwksODmc9yPLEKhuslpU2ZknrEUZuOHrBT/n8mi8sQyU2xPBYTZgo6uFsCuQIIGW8ySvQ5Wza7M9OnrwOAL8nq6nGzWCjoyGb7+YFs6+VR+HVwAb1Si20ni6hiWKbrPb+UtjFsiYvRX5baNRTG3XZU+id1X8BOA70Xxa+/L8AwiRGOnJoG2jj6pDikXgRj38XxqaiuzDxwQuDDE/okaHhYWKGA1b++IqEgQZ1C6jU8aOc1WAyI8NSiC773+gdDYDpc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 470ab131-9f09-4031-cef6-08de0d44b260
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 06:16:23.5834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +BRW6u8aVh7pshavINGAdpyuwH7/EehZsz4bZ+ikJJAn/len7EbzIbFiOukVvo2YM2sTvgwmuwKQ7OWI3KFAIwhOCjAR0p22h7VAaKqp2TA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB7045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170045
X-Proofpoint-GUID: Ylk56qSQA1WWT2zXboZAwyveBh-OFI8a
X-Proofpoint-ORIG-GUID: Ylk56qSQA1WWT2zXboZAwyveBh-OFI8a
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68f1df3d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=x6icFKpwvdMA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8
 a=yPCof4ZbAAAA:8 a=M3kmbseIx2tHGidxfxIA:9 a=cvBusfyB2V15izCimMoJ:22 cc=ntf
 awl=host:13624
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX6k5p7ZfC7LxY
 jBe6gwWiwa2Zeh1PGusIo/fmUN+trygIJyMYxNTNcyg05a6TygPDe2gnbbrRLFkYGPrqLetelLT
 nZK6Na4lgKzXmbZ5AP8QUilS9aKExCQN0lK43Xmqme9LJgQXkJZgOrDEC/bGm9uONE7q8gdlR4V
 qs63KpLu+r9W0W67gM31H3FuXyyo3hb67zBW5Py47m5RT1bkxvNcRjW2wFmx80+z+LgEvns7InJ
 z6i6+ZDFBgPa+Xojhf76tZ6rvtA9pNHzg58GkclcJEKarhN83iZyQOle2FbKb4j3WrXOt7y0mb+
 1tq/QPrt9dJktFNqMujZNvza9HmW0LNTliBSqCPfM9S/s7cOqboTP4MjPg/pDVv/xWpMFP1DfRA
 Jbf8LYYm6Q15eZ/NdXrpUYLQhxxJF9FFN3EnSi4uyjU1ecw1NbI=

The inner loop in poll_idle() polls over the thread_info flags,
waiting to see if the thread has TIF_NEED_RESCHED set. The loop
exits once the condition is met, or if the poll time limit has
been exceeded.

To minimize the number of instructions executed in each iteration,
the time check is done only intermittently (once every
POLL_IDLE_RELAX_COUNT iterations). In addition, each loop iteration
executes cpu_relax() which on certain platforms provides a hint to
the pipeline that the loop busy-waits, allowing the processor to
reduce power consumption.

This is close to what smp_cond_load_relaxed_timeout() provides. So,
restructure the loop and fold the loop condition and the timeout check
in smp_cond_load_relaxed_timeout().

Cc: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 drivers/cpuidle/poll_state.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
index 9b6d90a72601..dc7f4b424fec 100644
--- a/drivers/cpuidle/poll_state.c
+++ b/drivers/cpuidle/poll_state.c
@@ -8,35 +8,22 @@
 #include <linux/sched/clock.h>
 #include <linux/sched/idle.h>
 
-#define POLL_IDLE_RELAX_COUNT	200
-
 static int __cpuidle poll_idle(struct cpuidle_device *dev,
 			       struct cpuidle_driver *drv, int index)
 {
-	u64 time_start;
-
-	time_start = local_clock_noinstr();
+	u64 time_end;
+	u32 flags = 0;
 
 	dev->poll_time_limit = false;
 
+	time_end = local_clock_noinstr() + cpuidle_poll_time(drv, dev);
+
 	raw_local_irq_enable();
 	if (!current_set_polling_and_test()) {
-		unsigned int loop_count = 0;
-		u64 limit;
-
-		limit = cpuidle_poll_time(drv, dev);
-
-		while (!need_resched()) {
-			cpu_relax();
-			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
-				continue;
-
-			loop_count = 0;
-			if (local_clock_noinstr() - time_start > limit) {
-				dev->poll_time_limit = true;
-				break;
-			}
-		}
+		flags = smp_cond_load_relaxed_timeout(&current_thread_info()->flags,
+						      (VAL & _TIF_NEED_RESCHED),
+						      (local_clock_noinstr() >= time_end));
+		dev->poll_time_limit = !(flags & _TIF_NEED_RESCHED);
 	}
 	raw_local_irq_disable();
 
-- 
2.43.5


