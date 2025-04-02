Return-Path: <linux-arch+bounces-11223-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 582F3A7906D
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 15:57:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D6A43B9DFA
	for <lists+linux-arch@lfdr.de>; Wed,  2 Apr 2025 13:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76E023AE6D;
	Wed,  2 Apr 2025 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NYEnTYtT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wPdmMs1T"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6A523A993;
	Wed,  2 Apr 2025 13:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601938; cv=fail; b=NFmI+BZ00jDlJiAKmUxGw5BHRaN5LnJjST9x064Gsl5ohsbfnZ/QZ0fGFb8ae/e+HXEqBXySBaJ8HnBsV9vloIjZ8wmxNvwb7NhTqfqlt9MJXBSlkOiXCHZemyzAzBZnVzmkM5MxK0Ic++Qf5+o7o3mzCq4pG8RIyew2Udh5ZH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601938; c=relaxed/simple;
	bh=WPwMLZWy5D+QisV+WfFcJZShqpomLppy5D8Mc9Rni0k=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=G2FEW+x1eGLbNiA+JH2u7Rgu9LibwRjbywd1hnyR/uZduu1zH+amx3kv6kZLo04kGcV/WnlV9uzcSSnyZATKDsxMGbTfcJCEMjkidP9z+wfdPtonKky+i3/AgZoIW3yrUE1oJQ7pf/KTgbwV6JxB0tSEvaRTiwPdJnYTixh8S0U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NYEnTYtT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wPdmMs1T; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 532DN377010534;
	Wed, 2 Apr 2025 13:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NA90O0ygCdMRYNj0vc
	p6fezkJ0d5IXgno+1Elz1W2sk=; b=NYEnTYtT7rfEpfyMGIpB+QdXgQKEr31OS/
	Hhf0ElC5INBKrFxwAomkLLrdfjYq2Kr+iuLRtYmAYz/SzcAy5/B4V8pwz7MRLadB
	Z9FWl+2+Ss23cIUjdzUw05966TcrJxqs7ksXI2t5/bStw4N/KtjGHwzTyVPPFuee
	vcqGPCRuVXVqYlMWEQV137O6ehUHNU4bQvmkFu7YDGFudCYlpYIt6cZdGa3gUNzg
	faDimHJUG1y4dW24Vj6wSTaGuLd8+I89drigWuOJKsSKSSdT7SSoeHY8TFIICJYk
	ia66JI+vJJFM7BR4TeeXjycEYArFu7ypxNe+oBM6Z+Lid1MPszJQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45p7satfqb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 13:52:14 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 532DjOgM032907;
	Wed, 2 Apr 2025 13:52:13 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45p7aavnet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Apr 2025 13:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATDGWhzXDHLNrHoBYXYqTBvyOzBHjoybMI4SGD1W9L/EalscJ9nZ3kf6ZlwqaVi0D8lX40Vk16fRu2svECmVDk6y83kC5sanPJyOwZ97f+NsJfI2HbPf2nsK+CsUpaxni/Lxj6mNOpF1bpyUj0sc/vwXp12s7lwXwj+OWjYQKYlg/k/ksuLZhZg+W7PNDeU3FPOrGKMPX+nTycMYh+s8bZZOFoc9GV7yat554UeELXWb1Yp2YIznjy3++Y2eeSuwugAZRFkNrGPlP1tE1K9ay1lJEjSPEKwoCQFn5SDe1vB4K+cRdbaTSBmEfe5axEax5Q8SvmHs1p565rcOp0Fj+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NA90O0ygCdMRYNj0vcp6fezkJ0d5IXgno+1Elz1W2sk=;
 b=PsNXdtC901UWfLk/5x3vlXiliIHvlWfruEqEDK6vokcFBhyA0S1nn4mDTbeT2pyEMAgx4b0RXQJFak3eAL6/Qfb7b00N/LR96Gkzm9YveoeUh/bsW0V+R2yXDAZl7w/L7PtZw5e2A+CcsOIXl0kXTfPYWvMj9NraXojWn2vNf0ev0XeKedbGhQiXOhQZ9bU77uatmlbiXYfg+GGzWA0Xm0pHRQ8Nm4kFzXwmikY6WGtFPSehK/x0Nme9ZuEFauUNcNAlS/+CinV4gnqB0A9D6G8EbodVbSc9xBM79NlzChNoDxtgRe+vbL2cpq2b33DYVSR7fH+Oz3R8MqVTG1PI1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA90O0ygCdMRYNj0vcp6fezkJ0d5IXgno+1Elz1W2sk=;
 b=wPdmMs1TUsbWYuHRzbfevqSz9IoWSCZ9IIuvEyBUZV977INX656TCT8vrfFDqnvck9rDTLo8U23LF+mvo+oy4fb6ihXPvabVReSQAPC27qE4j0BUHAhzssqVI2DA89ZhKuHQV2mu6D4jjzhdBu79ToFG8TNM+gypy1NTIAupIHE=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by MW5PR10MB5808.namprd10.prod.outlook.com (2603:10b6:303:19b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.39; Wed, 2 Apr
 2025 13:52:10 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8583.041; Wed, 2 Apr 2025
 13:52:10 +0000
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/7] More CRC kconfig option cleanups
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250401221600.24878-1-ebiggers@kernel.org> (Eric Biggers's
	message of "Tue, 1 Apr 2025 15:15:53 -0700")
Organization: Oracle Corporation
Message-ID: <yq1y0wiwu1s.fsf@ca-mkp.ca.oracle.com>
References: <20250401221600.24878-1-ebiggers@kernel.org>
Date: Wed, 02 Apr 2025 09:52:09 -0400
Content-Type: text/plain
X-ClientProxiedBy: BL1P221CA0028.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:2c5::18) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|MW5PR10MB5808:EE_
X-MS-Office365-Filtering-Correlation-Id: e51f15d4-21d6-49c6-8be1-08dd71ed90bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Of4qWI6Pmm65Z1aVT4uggVSNAWevTk/HZJ7B+Km/2v1AV2wrtoAlUxg3GGHD?=
 =?us-ascii?Q?vfd/XkcqN5LveT89gB4wOKH4dTraqXhTjAL4FbYwwgHXpI1+PpJnwlHoubj4?=
 =?us-ascii?Q?2V/xWemTqq8NrFWH0K8w0OojpaU93Edci9SnGxlE3RzkzK5dpdYjeIcSl5VS?=
 =?us-ascii?Q?Monv+jZYtNI9T7FIfU0ca15zf8bfIBGEaDV83bbVSD9iX+yybpY3er0VzDn5?=
 =?us-ascii?Q?R8hkAUK179afAX50FxNhzwPEyLMutDb66/FJK+s7bav+axV876wu3xv0SJhv?=
 =?us-ascii?Q?Do1/K4NFGB18aeLp1BJgJwNMOmXeqOY5Qh64HeftpRFMg34i5yVoVlgvMA0m?=
 =?us-ascii?Q?eoOMcg82LMG8/Qcz+rccbdV7ymXI/mA/Ssbrs1Em54ceTn/WHcTVdW7FQRDc?=
 =?us-ascii?Q?w/UXCcr63n5RNV7XnwSXaEsu7Q8C/JcaIvSdhnDdGmCZZkuS0oqaVIWXoazS?=
 =?us-ascii?Q?PeYmiE2sJAleViyVJ/UqxIoXVvOKYnDWTJsFxj3LEPk9GQAD6Vd28lYH9obv?=
 =?us-ascii?Q?QiQf+tZcCpP3o+WmVMTu+Z9RI4Xrrjui525dtRBDNHDATxxysq7LCeJx2H7h?=
 =?us-ascii?Q?v3mPhbIPmH9M8VA0RgNEJSvQ4QBwmxpAgyUy6XZuglT3oWw3UW6CqmZA4yhG?=
 =?us-ascii?Q?W1kgvW5h4BEZxB3I6SFY8AtyPszLH1oyGh8VcNgopu+JxDI1MsbuA/+Ph+Un?=
 =?us-ascii?Q?x2hXNNGU7KnyRsNBT1f+LSb1sVD6gj9USLMvD/4CB/e/5hr4egugHyGEtd8g?=
 =?us-ascii?Q?jbz5vViAfxQ0OcuebOsAg/8OiEC1AcOVFf8kw1tjjidglGvJPtbAX+Sc1Lxa?=
 =?us-ascii?Q?bO2McPsDjdBbbkmJrAnTt7px/Ewo28wLxEhe+r+Qz339Ttsjmd2aJ7RRixqc?=
 =?us-ascii?Q?4szCkLvoAVw3X5PpzRUYWSqVX1LVdIJUxqDIXK/ZmMgLtZJKhE/HC4fjofI/?=
 =?us-ascii?Q?n9MmE0eKrwNL3OSJmy6Bh9ng+SbLxpUsqQJUFRXKvkUtuyju6bHm7iHdn8GZ?=
 =?us-ascii?Q?DHRN4IvFThYod5tIkNi+WsizhxR0nOxjdnw6wh9YjIaDPiNI2j4WmtCeZGFz?=
 =?us-ascii?Q?OrXxx3MqL0lrYwXF6qHBkt0MHfz1xEBTAOEZV0dKq5ojFdQSQfGXvEKxJy3g?=
 =?us-ascii?Q?rnLlNX9wb0s/sSEZhxqmOsLO0gC7tK4avilTmrQgV6EHWxEqiFIyJuSgT2qH?=
 =?us-ascii?Q?pX88pFoxx6PVdgZl6TF4dLPDpud3McOApeqOYPuYX3DvjhuTHhoR+0TLkC1P?=
 =?us-ascii?Q?fUloAmkPGyHZ2ol+68d2S3kKcMled5gWLGCwDXCjXy/+QGV9RVouITyDvIPK?=
 =?us-ascii?Q?vQs3UAwNkJ+O+2S9DF/oY/vik81Y8JEG36vRyXE/JMMhgIGjFuehbkJ0qiR4?=
 =?us-ascii?Q?6orsimqlUwXVdEwgTyBwrhOPHbUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vDUzD7DYIf/fTT1J7p9HqzYzHzQ9UhLjlTdsqPFhAiS1HIGA2amQCk1Lk+Dv?=
 =?us-ascii?Q?QlcI5dOQ6n95a3s/zO8b2URaxRMOBXgG6E0DHlSKigzZsi6tzjTQ+P7+j+6y?=
 =?us-ascii?Q?LqAw2xfvji9teKDxEDIdxuN1EkY4MGymBRHpTSxfFNsAwQsY+TgkPwYHBqpY?=
 =?us-ascii?Q?X2tZRl4c1Fu5t98mTUZlhbooKkOgiR6gIRThbeFlUvB+Dhyb31BZ/RmVvdLY?=
 =?us-ascii?Q?EKdDRQPV/NE+m9kyqtBgt17SGoxNlhwLTHc2Sjd14kWiosdbh5/OSgRwz2s/?=
 =?us-ascii?Q?voXLDhzS5Hm4f46ZvM1OjULFMBg2GfiDA3KoSPlj4aOWv+KvALQXrRrNMw9/?=
 =?us-ascii?Q?q5vXNar135tFqkJKB2wnAAAEgv7+6tWsRASSbb1hVvnblOssgobqW+CjwfU3?=
 =?us-ascii?Q?2KxZvs9QDvyuC4FM7MYzp3zU0V6X08kbEA2VzxOrStkk3wwYZDb7gjBQAVta?=
 =?us-ascii?Q?XVc78N1eu4daLG7o5BIAhsaSvnG7L72NLNTY/3xTUZe8jeRSX3M7HmaeusuP?=
 =?us-ascii?Q?NX32PHZBi2ri27IzqWyhOTmxHeO/VU1MKRpw3s+WYppznb3mQVWIBSUdjEWz?=
 =?us-ascii?Q?BSKR2Hgz3wSm3OWWoWUwpgeBleTFsPlfadfBo0i7U/QNb8iON7utTS9DI0gl?=
 =?us-ascii?Q?ejySHWTKzwiXjMdJp9/WJFl5gO0RXU+4RpGSw5h+Kt4jgrj0jMo3vzzRVDDR?=
 =?us-ascii?Q?Ltf7UIsbzJA44+THk9WGd2uSc4iu8E/J25rNwY8JhnlqI9Tcrd/GChBBwku6?=
 =?us-ascii?Q?PPI7h3yzmD9ETSaiNgjYhM/jvGJzVZM9kbh6mSpgoTnKN2+fGcNWWkBqn9Gy?=
 =?us-ascii?Q?9kyq6mJnTRo5vMhnVpebXjpOktCFWorW/gzJGwKyk5HQjJBgQ/R33tyx+/8C?=
 =?us-ascii?Q?X+3ZF73uoaMSuIWBiGPNnNWipmN7LbxtYXHWHvCHZ/V+q7G0HGcsq+JC2e7L?=
 =?us-ascii?Q?+i2Qm9olqO1xVLvr9SGRPYdDikqA0E3AIPpDZIsF1Fe834Hu38mWvps4k5lR?=
 =?us-ascii?Q?Fbqp0854vKBJ4Df0A0idm4aUfj4ETvwld373PFPYMdXqP7GQesQELV19K62T?=
 =?us-ascii?Q?2Djxy7I05oIgxoWLM0hq9sLXsnzQfQ45ddtl03MRiLbr0vB2TnDBwbDJeEQB?=
 =?us-ascii?Q?5GcS6qkgPA7kh3n761dj0of892lFrVP7FoTdx6VH9dttrAbKlWxjDed/W9/n?=
 =?us-ascii?Q?z3dEQ9gR0k7NM2y1nmDNwzfKvBiFJgwq/oS6CNeCNLy8qvWKvAycEyAxP/1D?=
 =?us-ascii?Q?h+kEyTpdHH6zsBdQWdczKvdBlRY4iPYWQb+gy3KecO+0IZ2dm6Oq1JoBnAps?=
 =?us-ascii?Q?QbJzd8Xbm4DXF+/+uSyvjwhJIAA2WPqoL1WZTCEyc59+7LVwIX4rPv5AeHB0?=
 =?us-ascii?Q?0cNTUGqyhumTfzCav1ZxXGNsEuR0jV/97teAwd2fU1D+Xabnb8sneZ7EpoJM?=
 =?us-ascii?Q?PSuLGx3tNi7lI+W5EBKN1jrBak6s0OcdyqP6fD+VvtPGK14JQ+z2XfGWqJNN?=
 =?us-ascii?Q?A5MM1K2Azi3VoEV0mWlsCHKj+E6NNVUqxQ0ai6Upu60p7fTLOv/VYUC44w2r?=
 =?us-ascii?Q?S91hlnkHHaJmTRHSJPo3R9e+51UJQybVY/McoJDwR6twQlDD0ibjqRRDTJcJ?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HjT5Gs5/7i8MQ/gejMDu1ACZa+Y+9BjPOscgBxS5JqHXelrJWjaV9cU7O47cL/52CZA8ABvuTdMlVVDTO26GvzjvpABIFAZ6BMJbHIcwoAnzWhHiyo/338xhCCA/ZUpe0AlvCixR+Otw2qdBgj/UlqQ4xE9EQoEp9VMn3ReSNY8wvfKOqJKJeooStia7BVcG2MZo14w26023absFcmUvZ+IFAAhWDOkmqwF08Ip1hD+vJtLRp2CD/kBGDfyiDJpsUL2/h0mmKvgsITRP7yFtqXZKBF4GtBmqA/bDiyhMWN56nmDWVTUN6/CXTJhl/6dTJsjF0wutxfiS8higw+oUJkc+hU2wGOJWsWWYMoNoY9OtI19yJoNvJowuSJwHflPjdgIyasvEUvIi89IRh8baW8c1xf+Hmgm0tkl1bJpcNuAxkQIrgRmwC5RQ0TDi5ztlgzimj0E4ngnhT544fuHtHKsd9bAhuVctwcdEzwDRSMgBThqdpXELRjulKSP9MZeUtt7JrJgmGa2sAMZU6l0z7ya3DeQRIdhmBdKGHS5vO+EnrocXMcbhlYXLoAyFYHNDHh2/J+F0XdNLmNeJhKxoubAxLfkRzhd1HQo9IlqgMdU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51f15d4-21d6-49c6-8be1-08dd71ed90bb
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 13:52:10.7194
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEBt9/yv768e5DbyMO3fxcX9I5QuwpRLNXZeaP3hEpPZqNBPECIUnHJLtOaLcqhttvy6UusQkP7OekXIMfULv9IlZB3SByv8D5XcmOvYKMk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-02_05,2025-04-02_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504020087
X-Proofpoint-GUID: X6AT5naApmKwpIjqt16oIfadNwHIXcAB
X-Proofpoint-ORIG-GUID: X6AT5naApmKwpIjqt16oIfadNwHIXcAB


Eric,

> This series finishes cleaning up the CRC kconfig options by removing
> the remaining unnecessary prompts and an unnecessary 'default y',
> removing CONFIG_LIBCRC32C, and documenting all the options.

Looks good to me!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

