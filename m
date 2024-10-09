Return-Path: <linux-arch+bounces-7914-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4795A996E09
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 16:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEF1C21A58
	for <lists+linux-arch@lfdr.de>; Wed,  9 Oct 2024 14:34:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F419B51C4A;
	Wed,  9 Oct 2024 14:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="C4BAQQI7";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TertyEBa"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B617555;
	Wed,  9 Oct 2024 14:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728484424; cv=fail; b=MmVmpmV0S+MztrGdJpNAzu4GrBtN+J0VLGTEwC72LzjW1uR9y1oVb/1JT6rGMp0EE78cTa+YX4XhevoNP34LGpFCEIxvowcGI3BnzbHEXcB1ixJUXJJCHndWTaEcywUV7DsDma6x4sKU3r1QuNTOQkb1DLMsn5E/4MbL/NuSxbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728484424; c=relaxed/simple;
	bh=fPmk9I6rlIPOX+22fgVstENRN8ZJUQpAUTkKfGstzDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DqmDe3MId7FRoxKdPXVVxIBiOVc3vYRJWMo0aSSvZVcyjOcMJlsahAss7rfK+g45FHMKEDM+DorNRi2peLDAVFS2xEYauBPPRVDEIp63DMkC661ZRFhiU00SyxDEYSU2Bp4CiWp1k8HUoFpEf6RiBMiZRQ6Z6ffgo+JHWHaGHys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=C4BAQQI7; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TertyEBa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DfdBV004619;
	Wed, 9 Oct 2024 14:32:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=/x8wBvaPpjmHHwKUdR
	vLLISstp7VXcDCRWcub3zAciA=; b=C4BAQQI7GSGT5qeel0JcaOoFq+roE8kVgR
	snvtkgkQzqzJGazrwXqZ70/PIjkeMc4O7Gd1Qr1PFC3sPwRwxtH/agRrARncau0x
	Qs6aO09fDIAaFpr76hCwGHCUVK91lwURuzhfAwkcB0pT1sg6ipexssmbHHmW+6Rp
	f51aIkNW7ChHeHzQ8n+Gze7dg2aCJmYfxyGSn+GDii84Yha83TLmgbZo/sX6cYD4
	/BRiV3+Eq3GjTCZ1ZwNlNgKDeI30Rb/2KmVYZMiAgfpsFOZYFmkEhtPuZp0hQSHA
	ykgWhvCMVTbxZfGRB7TIXNBXEQG/dJqlQWsH+Yrr48oES83pN1LA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423034rq4t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:32:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499DqiZv019130;
	Wed, 9 Oct 2024 14:32:55 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uweyfym-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:32:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km0kRC08812ZoVxwZA5wfh0bRxxFAc8UvSBiafsOb7VnwTLhlSUvhuqR/r2neW/8YUsTPWd8lXWZ4XtOPOWRPXPRqtcT8h08GxE8dpvndruWKRhOhe0ZzRE9dxwta8vVT3qXM5kOc+deqHou9m+2Cnkih0ZTPygr0mHYYdBaEeP3WyOxOJcmDI5Xgaqe89X3eItCIjqot2lHJCd+0hzMwlCIEJkq+PCfhTFz8E844/iSHlOo3SjizAcvXbfFvslipxYqA5h1nSYd8pBsRg6x8P+6nJ6EEzPZspWm/PH3TsCZx1QdA2+N1up4dQixdnMlpqcmbgK3euGWYx6x42vCqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x8wBvaPpjmHHwKUdRvLLISstp7VXcDCRWcub3zAciA=;
 b=xa2HGqKgJDzJP0/KagEAs+RR9BKnjTVeCNP0iQGlI3JU12VEeZFnvpOqIfmD3PycwnLUIrabIBYBr6hh0sJyDp2VYMkTygg6K2ayQucLiXrc/2hm+apkP4u3OEEwBGIWPmdWt+vxy3oIAiBPOHu3DusM4vGR1qzWG9pUmsbw7ZGXEvV/yJt0+JHeEkDqvWjeQwoPYDy+5f1lj2Rxi6OaG/PnzLVf4Y5wXAt2O80RFlewTzGOp+EqYoFKAyj6ByxKnfklGf7/lDOpxWpn1GuDzq5VW7mtzTessWltLCuzAsE60f5HpXc8s8BoCQn/fEzcP1HIP6SlX1M5+SgI1XsdZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x8wBvaPpjmHHwKUdRvLLISstp7VXcDCRWcub3zAciA=;
 b=TertyEBaa5YlD4tnpOkcvcPv2wyzRCF7Bdxj2xZnYnWXMGfh433cMWCmIBA9pc5w2lYHRACiRiM+wajYxkuSnx1xENAh480dHVCGkQCVpKUaxt11W8raGXKkG+pTLk5iffQyOa8PTFHcnC6aHYaSNPDeuBJ05Bxn1ZD5z88ZucU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7370.namprd10.prod.outlook.com (2603:10b6:208:3dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 14:32:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 14:32:48 +0000
Date: Wed, 9 Oct 2024 15:32:46 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: David Hildenbrand <david@redhat.com>, Arnd Bergmann <arnd@kernel.org>,
        linux-mm@kvack.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andreas Larsson <andreas@gaisler.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Christian Brauner <brauner@kernel.org>, Christoph Hellwig <hch@lst.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Damien Le Moal <dlemoal@kernel.org>,
        Greg Ungerer <gerg@linux-m68k.org>, Helge Deller <deller@gmx.de>,
        Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, Linux-Arch <linux-arch@vger.kernel.org>
Subject: Re: [PATCH 5/5] [RFC] mm: Remove MAP_UNINITIALIZED support
Message-ID: <fcd1afe6-16f6-4a51-8bb4-08ece80337f4@lucifer.local>
References: <20240925210615.2572360-1-arnd@kernel.org>
 <20240925210615.2572360-6-arnd@kernel.org>
 <b7f7f849-00d1-49e5-8455-94eb9b45e273@redhat.com>
 <1a1f118e-9a7c-4c66-b956-d21eb36fce48@app.fastmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1a1f118e-9a7c-4c66-b956-d21eb36fce48@app.fastmail.com>
X-ClientProxiedBy: LO4P265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::13) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7370:EE_
X-MS-Office365-Filtering-Correlation-Id: 3802db9f-4932-4d35-b49a-08dce86f3f8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7N/M2g5aQ6AoKg5/kd9rwV9imS3w1u41fKu43dE6q76t7KB8iUoICxwSn8jJ?=
 =?us-ascii?Q?TBihNEDEvvtlpE+uDIRc3PMe7utv9hOLJ25qaQ87egGIi+yXOwhGTY2MqeVo?=
 =?us-ascii?Q?HPmzkMOZC6DscyyjXG2MThLqZ3nWl9tl5oeKwWuORPTTseWfQiNkGEqjxSQ0?=
 =?us-ascii?Q?QAjrPV8dC+m6Tu17XCNSsUXHd+mOkP4nvoebl0N2JoV11e5DAZfIUnZBD/aU?=
 =?us-ascii?Q?5S87/vQdo59BInQkb1HRui4qT2ro4PenCQzI0Yq21zPBY9YTRORU94HAisjX?=
 =?us-ascii?Q?jNg8MosnqqWsFrEjaXwydeYPRuzQTIWlt75RBsqSDLfTGOKNHMALvBpd70VL?=
 =?us-ascii?Q?WbepA350oUpkpeFYfFh1GYCkvcbF+L43X/CKwC4N/tA8Ez1cvIGqYvEYxRD2?=
 =?us-ascii?Q?W8nmtavQZconLJaPPZQvdSdpnPK9uP4QjNJN5xW4gWeiX+gL9froXp4Pv7p/?=
 =?us-ascii?Q?N7skAV2JLM8wP7xdwJU9ISEk+v2dUG3wNVNlOHtM8THiRBBXrljfEcVmAlUB?=
 =?us-ascii?Q?EN8ZBGnX2sRrGuuFyaZgwWYMJ3mC6mDlDiWO/q1Q1Xc+USJzWdYF4j7KGfSz?=
 =?us-ascii?Q?fUPEQK2DZzmSDdABXD4ISr1x/vcBwVLWQ5xeojnIa+d6SSguGSTUpEgjZWV0?=
 =?us-ascii?Q?qrvy8ClJ+JjFgsl1rpX4ZkzS0DzYxGU6txejmr44rVYwqm1TdBT5XyX1awii?=
 =?us-ascii?Q?T07MQ2t/rL4vT8SKVwrYdH3XfAroBrncUTGxVaImG+NVnPSPXyxgNWqU483s?=
 =?us-ascii?Q?uWcCOszgsqjHRSadQDkwkTxN6tbm647jfL+b3g6h1TgBJRFqu5hGsLQnnm09?=
 =?us-ascii?Q?gbq/LDUC/CCjO57HHimRacZ5sYLQVdmds1nDc30zBIemkrzrYtBj6hSYJHXo?=
 =?us-ascii?Q?NEoBR2zruYthKNv9lXCDfGclw079DENE0e8YNhf9+dvzqeiuW1AaVJAEtT7u?=
 =?us-ascii?Q?vTtQBm/Q5k5WuwSV12USIvyccRARKSenz6KJ8CDbgMEsJRjUsB3AchpKcvab?=
 =?us-ascii?Q?dT+W7Ewl+utga8c5QG3VlS7ZtIxlLgLM/8rroqXnEwP8pQ3DAzL+YF6dEjMu?=
 =?us-ascii?Q?L36maGUU6EfKh85BSNuzYpZ2C75oc9Yjh4wxf4EFr3JLPBg6JhAHeshHVioC?=
 =?us-ascii?Q?C7szbLZpxeUV50ySQqekenKXsMueUpPQqunDIKGnFanxu2JxUon1R5sBaVOg?=
 =?us-ascii?Q?seVscXRjpsfDXZLdbS36oK1/T50/SBLsRdKVWlLoDUc1z97Mlx2hBVZSYuo/?=
 =?us-ascii?Q?FCI5mgJQDLZTEq8I1/1xnMuAH78pWppJYdLqtj45iw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7TKMfW8DmRgAQAfVU1YAy+rqRds6e6RLtNRtNEEFdGzZH07xBU0+Xs+ujM2G?=
 =?us-ascii?Q?HT/L5mUlJQS5sH/qzidGWW0qc3IaOlnNnn/2HaJdTpOK07Xzp/Asxo+NFEkp?=
 =?us-ascii?Q?sHoSSl9kRLjo3r3XnnQga0MPIEwQfVHuWRlJFZq+NC3CzvBaZK1nLO1fBEwX?=
 =?us-ascii?Q?yDFbqdMEw2dooxsuSN+gkT7PLljsy8NrEm7T+rH/a4B5JsfPSxtLnND35SpU?=
 =?us-ascii?Q?xwUwXNpdxJfrfo1xMbPa1lgcSHs5/fq5oh7/wpdq1e6eC0AFKHryOfrE+i/C?=
 =?us-ascii?Q?kePTqJTpSP7M+nNkgb433jL9+qzm0fhp0Iz6MNvTBdipxq1qWM2UjhPjINT0?=
 =?us-ascii?Q?NM/YUFQTgu7NAqMSWQaZdY4dC8RXKSSFWoib9SsS00MYvjDg446kY4NEVYcJ?=
 =?us-ascii?Q?/quwv1gNGKm1JxH+/JFuAR3CEHs2wls6iyt03YPbUjVTo5137gn8xTKK8Y64?=
 =?us-ascii?Q?oDoZU0M64c9hXRhWJ2/HpVgGXdklYtqne3cmwm5l5ZgmV5zqreNxalmkYJxZ?=
 =?us-ascii?Q?xe7Sumz4jyMN60+1oxTiCTn4kYB8RrtBtioORAZ8WmLWw6BVBHsM/Kd5Gbyu?=
 =?us-ascii?Q?vlpUZpyRUUUvBvaZ6vblqdNTZzkf/8GlMehcUjlNtomTpjVDEwxpz8azJ9S2?=
 =?us-ascii?Q?sa61osnNzYOEZkJVPJvKTth6aWgZcWUJLuAAxVt/wXUc9BYKReLArdtywHdK?=
 =?us-ascii?Q?+2PsVrHQ6dNGG9IcJWxtkuuM5TAWeTV1X/C9UtG4TltVm/X0ev2F0kd3RHPS?=
 =?us-ascii?Q?Gm1R5elZo+vr/VQRpeVsWQgEH+RvEBIpOduzwKkyP/n59Ch+QnsWPW0jbdAi?=
 =?us-ascii?Q?JSoSjr9NLl1Iy1kGeSVxd2NhDknb08QHGBMS+Whn3tOqMv4hihWFk/PD16m7?=
 =?us-ascii?Q?X+OW+Fq2o+0I8ww8vaWMcck818GdFwXAEAgY5b7tYOiycBDFgcQ7H0gbtY+p?=
 =?us-ascii?Q?xLyl2opmEqS2NE+AkmkYvgBCiDqKnOY0XzXlYLsAICgcTRpx3rImsocd/+hP?=
 =?us-ascii?Q?hJqOG3TTB+il7LQQsmLHb3Vv05cWtqgg1Up4MLkFDSJUlNw29Vem9EYmk3QG?=
 =?us-ascii?Q?m1rhxaGpMfVkufiKVEe+SKVw7SDc2iIXXzq6cYd7oIKD2EHkr4lPGHvF3Xwo?=
 =?us-ascii?Q?myvQWT0PBrHfSxQMy03us1MI9+2z9V6C1wxper7/5Qo6emeGALQzNs2OEEJZ?=
 =?us-ascii?Q?7+fvSO9THRULKfwHd+mHzFhNGCpp4Sunwme99ca73fO8eaCDZ8eSdcrEgE2r?=
 =?us-ascii?Q?0p7bcip9SlOP6RwTLz8ecNwrdNrhOVt7IqezUvLHWEe8WDXX/3AIMIhN2j1N?=
 =?us-ascii?Q?tXlvleeu8NQ8ZYCK+jafyM3eyIqM5a4qET9Z+QIe81VOhgTfgcyPXs+BBoi0?=
 =?us-ascii?Q?sefjQfMHo1wUKTJxoWw3ZXQNK7rQxW0wPKRfqr1iRd/Vj9YY+OfUH5XUUEyw?=
 =?us-ascii?Q?/lA53pZ5w0iUSElV88oQkSK7m5DHh8+y6O/9PRQVnjzDLz8ElydRN5ztNe3j?=
 =?us-ascii?Q?lxT7+TiXVotblX4Kc6roVYjhuvoOeEpY8O3XHzKqwsYOLP4kcAZXq371NGHK?=
 =?us-ascii?Q?2oadHu6GUbcUxmocCJKZ/FhD0jBBBkbAAUBznISvZQiHgb5lbXPU7RAvD1zN?=
 =?us-ascii?Q?Ng=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n1ZjaYGcxhlrfnybMim6imnPPMamuArFxkVrt51ixlBxg6Y023IbbAuVGPrVi2kcnKqclAOMLWfKzdACgB60pvuIleVIs5l+FC9lWDnHaRCmY8LyU9wDYjL9yBzTlMEUuM7zmsuctYAgaEobapb2ksRh2B6PReoSuesLW2K//s4Gv7LldfTZLV7FaNE6Z6ae2+bDH3VsLqoE9tANBQ7aQE9ZT86QwXfJMmYGjbMpviL4s/Rc7E1A2N9IQzolqrUO9kX+gRo+FwJ+r3EJxu5YW8cR3Er8GmTRPJt4BEpxUcSNYKa9WO1ucxRguK6igpQIErDGL7SbROMK9iUt15JNMowGI897bQMB80hRNfypMWn8XnSZpJLCovVR7IooEQIs3O/NMca8jepf1L1CL/laiyJA6QR7ABBGTwjl1sfzrNhmlaLfH0bkYxuWwyHR/q/gjZG9Pczw03tqBPFzF2pSZeejH6BP1PU9xZGkL/m0NJ2FzyTIOXE30igfRa87de1M+iZAVIvKXV2ogGfAZScvRqYDsg4Zgw9zSArXYkVUkJ6Oxv2Nl3dW/HEvjYhfbsSqCsdFQgt+sDlblQ5qupT1ZjhJXb2lUh7DQHRFaf4+Xpg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3802db9f-4932-4d35-b49a-08dce86f3f8e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 14:32:48.5893
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hvL42HVkZlRIO5pZfcpCI0uVQGxRHsnSRLeY9Xjp1wk526ou1bvWMKxffe/hiBitWHEEGXhYDKpiS6z1wpBuyZNQpVwxTEGdanffPtHv+W4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7370
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_12,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=900 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090089
X-Proofpoint-GUID: EWmiXcNgyZcG3bW_48ouBLDLJCcMo8DG
X-Proofpoint-ORIG-GUID: EWmiXcNgyZcG3bW_48ouBLDLJCcMo8DG

On Thu, Sep 26, 2024 at 01:54:09PM +0000, Arnd Bergmann wrote:
> On Thu, Sep 26, 2024, at 08:46, David Hildenbrand wrote:
> > On 25.09.24 23:06, Arnd Bergmann wrote:
> >
> > The first, uncontroversial step could indeed be to make
> > MAP_UNINITIALIZED a nop, but still leave the definitions in mman.h etc
> > around.
> >
> > This is the same we did with MAP_DENYWRITE. There might be some weird
> > user out there, and carelessly reusing the bit could result in trouble.
> > (people might argue that they are not using it with MAP_HUGETLB, so it
> > would work)
> >
> > Going forward and removing MAP_UNINITIALIZED is a bit more
> > controversial, but maybe there really isn't any other user around.
> > Software that is not getting recompiled cannot be really identified by
> > letting it rest in -next only.
> >
> > My take would be to leave MAP_UNINITIALIZED in the headers in some form
> > for documentation purposes.
>
> I don't think there is much point in doing this in multiple
> steps, either we want to break it at compile time or leave
> it silently doing nothing. There is also very little
> difference in practice because applications almost always
> use sys/mman.h instead of linux/mman.h.
>
> FWIW, the main user appears to be the uClibc and uclibc-ng
> malloc() implementation for NOMMU targets:
>
> https://git.uclibc.org/uClibc/commit/libc/stdlib/malloc/malloc.c?id=00673f93826bf1f
>
> Both of these also define this constant itself as 0x4000000
> for all architectures.
>
> There are a few others that I could find with Debian codesearch:
>
> https://sources.debian.org/src/monado/21.0.0+git2905.e26a272c1~dfsg1-2/src/external/tracy/client/tracy_rpmalloc.cpp/?hl=890#L889
> https://sources.debian.org/src/systemtap/5.1-4/testsuite/systemtap.syscall/mmap.c/?hl=224#L224
> https://sources.debian.org/src/fuzzel/1.11.1+ds-1/shm.c/?hl=488#L488
> https://sources.debian.org/src/notcurses/3.0.7+dfsg.1-1/src/lib/fbuf.h/?hl=35#L35
> https://sources.debian.org/src/lmms/1.2.2+dfsg1-6/src/3rdparty/rpmalloc/rpmalloc/rpmalloc/rpmalloc.c/?hl=1753#L1753
>
> All of these will fall back to not passing MAP_UNINITIALIZED
> if it's not defined, which is what happens on glibc and musl.
>
>        Arnd

My point of view on this basis is to rip the bandaid off and get rid. Agree
with DavidH it's worth keeping some kind of documentation that these
existed around so somebody grepping and confused can see what happened...

