Return-Path: <linux-arch+bounces-7487-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ABC989C1D
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 10:02:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5BC9280DDA
	for <lists+linux-arch@lfdr.de>; Mon, 30 Sep 2024 08:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E6B24204B;
	Mon, 30 Sep 2024 08:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="SnCzIUPM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xugAFsUj"
X-Original-To: linux-arch@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE3217BA6;
	Mon, 30 Sep 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683343; cv=fail; b=YaZGoWQ4DTcCTcH/HjUFHcvZhemso49BYvp3qgF0yOTbWOyAD7e/CbpSI3RTKBMKdgpPJA7N8IaYOThgNVSa/E8POSC6mklfsj8jT3q8F/c0WWmWamXxQ5FhH5fBI97PSSwvxA8vhA71hm4TEVuM6z0aW36i/rtWb8Lx+tln50A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683343; c=relaxed/simple;
	bh=Ke+C3QFIsbDWKCedgZdZtN+TW+cHUEwhTjpLcnPTNYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E70daxsphT4HcCAYNtKMg0EcILggNhFNZ2Di94HUOqXrOWN5qMOh9ShCABkXQ2Tf7DcCmPJIOZzWKSt4oVQA/JVyIpgk/YZoYw5kd8diwkpli78gxD687svoJOIAA6g8gpZ3Momfm6ccbEj+UkYX0XQBO1wag7WeqoDYfvWYZiU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=SnCzIUPM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xugAFsUj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48U2uGbJ024697;
	Mon, 30 Sep 2024 08:00:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=GztVbUhc04lyZpN
	9xSI4GOVexfrGgvLiSSB1upM4TcE=; b=SnCzIUPM1h3Xheqxr37Gl3rsRmdbqlD
	T4owFpEfD8n1T5UP+BokpAMRyjxEF77W5ZbhJ2ozFPePxFgQp3Fa65JblLSmBPsM
	H2BQexv3dZ7wPz6i0KUJsxNxBaCB70GuFE9X0vr8Hj5t3UvtQpDQ9syKEloz3RYW
	WQ1ss4n8sLYYZ5e7IFRtFvfT0ITNIHQgqiInObddibmk5r00v8fYaNfzDwAQBJ96
	wpY4YKujpDllu9g2ttK9tmsM329z5VlhmJeUwNDEYug8ujG6fa5mM6IUaOPWMlku
	yY16dXl85iKHrqLOdngE8VTxc/ZCle/qd+lc9vf1tvrV/mjGsfTx97Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9ucjmqg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:00:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48U7KFFn026224;
	Mon, 30 Sep 2024 08:00:32 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2040.outbound.protection.outlook.com [104.47.70.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x885qdh4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 30 Sep 2024 08:00:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alcyQQHkL6gwYYzj9RDh3IOOQ7PSN9/Bb1kGpjgZFLzX51m6oOskvpugHJjsYdWLOBJ4vvwi/AwI60K1EbTVUoP5V8TerpDqACC4Y/Rxs2l06rwM14NjivvszHIoV8dPoC5cNNZbLzY4vK+XLMuDcAktkrC2ZogrGXZlr5oX69P1XjktDPEg5qmDy82ZZ5RiCasmp99EzfEKEAvGMs33XSzXOcNApXc5uaz3EmysFxVdAYNUNlU2HkMYHs0YcWCW0ShS0FuOecm0oVEXDnbFrmvSeMnwhS8W2wWhSQVWR5CSTELYp9/pc/k/0T4HZMgXIYOGKt6soZH/MCGAULZzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GztVbUhc04lyZpN9xSI4GOVexfrGgvLiSSB1upM4TcE=;
 b=ACYMBYUkP7y9vg5E2y/gpfFPOTfd0QSgoU25MglmYDIJ+zyKZPCrkwPMJeE+lXMYWsTaCOduR6IL+34KRrciY9pkPUnDWNoI4hj5SLNJ3jI5qnxPgczEnWYzj3av2Vm2IW1neZUe6WQK7u3zslIBj5HDbyWLTKzhwRkwCTH3wtjEU8EI40HvFVUbgjEY6AsI7Wak40IM71sSdbKxbI16eBpnBJ90AQmWeYPJMPZMq5Bv7sN2ae9k10umCQOnNzCm9Vp1eY0LcJufwTgWt/8GOzb1jm43xTSHdvzx5vuDlbX1kV9iq8HyhFjxc5hvS6gJ963QEjI1khrr0GJrFGBT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GztVbUhc04lyZpN9xSI4GOVexfrGgvLiSSB1upM4TcE=;
 b=xugAFsUjJI0RzpJMOwfvNDTPaW3ATnnneoE+kR536Yrjm33vSFWE4rkDcuAqGv1yzcrjv7j11kZ1IJ+Y5Xjyo3SZmFswAgXF1GtgypXuZvJ9FsdDN7DnC+ZmIGILm7IhGIvVdTP0bB/WVzebRV5f0QFQiGjd/Afoc5xYuzhVxM8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by BLAPR10MB5074.namprd10.prod.outlook.com (2603:10b6:208:30d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.14; Mon, 30 Sep
 2024 08:00:29 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.014; Mon, 30 Sep 2024
 08:00:29 +0000
Date: Mon, 30 Sep 2024 09:00:23 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
        "Paul E . McKenney" <paulmck@kernel.org>, Jann Horn <jannh@google.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Muchun Song <muchun.song@linux.dev>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-arch@vger.kernel.org,
        Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
        linux-kselftest@vger.kernel.org,
        Sidhartha Kumar <sidhartha.kumar@oracle.com>,
        Vlastimil Babka <vbabka@suze.cz>
Subject: Re: [RFC PATCH 0/4] implement lightweight guard pages
Message-ID: <76dc6a7e-ada6-4d36-822a-f0075f90fe62@lucifer.local>
References: <cover.1727440966.git.lorenzo.stoakes@oracle.com>
 <ZvpSA7ks/qATHEq3@duo.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZvpSA7ks/qATHEq3@duo.ucw.cz>
X-ClientProxiedBy: LO4P265CA0112.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::15) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|BLAPR10MB5074:EE_
X-MS-Office365-Filtering-Correlation-Id: 75925d75-4d66-4238-2034-08dce125f2f6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|10070799003|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Jc9ya7W1Rhp88dCuLHtDRYW5H2TFg8pm9aHtUApVfGsNCk57yf0ng2ewyOdT?=
 =?us-ascii?Q?J5ZobKGynHxHtbZpa1z905iWFgDTZMAd4a5xFJupl+WOq7hTninxwW1iHEMl?=
 =?us-ascii?Q?e9tOCRkVno5OLUVnF6cjd0k5IPIuxM/Da4OzXC8VuR8RLVIlWh8gnJdpFlKe?=
 =?us-ascii?Q?JA6s8TS2WZPY50CAxKBPn4D0tgR/dLASpxb47oJI+YQpaKvjSkqJA9gZu2px?=
 =?us-ascii?Q?Ku2o9ZHR/t6ldyqNvrPN7T8zBeQTw812uqLMzSDpzRboXiA5yh3rEkrwvBnj?=
 =?us-ascii?Q?1K0/+mhKWjIq1W/KiQvudg5SCV3/7kQX5OxbDwn/WeOiWiR4lEnEf3Z/0J6B?=
 =?us-ascii?Q?8dwr039awGihgYtcBd8y4WzuGOdg7Qudj0iNb7O6PaFhpSfSyeWePxbO4wHJ?=
 =?us-ascii?Q?uuP3Y62Uh4T1Gdak+m0MLtHnfd32hdpQNUMBCVZmG3QlkmAzRZzGzMXA4SSy?=
 =?us-ascii?Q?ZvUba0XOoQS/A6VvB2ORbeEWvRalDHiGeResxctBJaXIsB+DAg4yFumPhnXK?=
 =?us-ascii?Q?YYRypwrsAces70VJAdCvyRLKJ1hXzExIdhzSZk+Q2BYFouELktVt5dJpPaPO?=
 =?us-ascii?Q?JvhqDpGXDwBOGHCXDtb/c/tBVnKiViz5Io+CiAeYkYojyXV+kvHJIXSHFx4a?=
 =?us-ascii?Q?j/VhNjm9XLb4vRO+Pk4Bpxt5s5EaGI40/Z3s68RFMrL97kLKYUGPZJXLsz4F?=
 =?us-ascii?Q?0DJv2o7O2IRwLhm5eWcmyX1VA2yx+4DTfCvXiff6Bi54sr4/cQhNL6ePW3ZL?=
 =?us-ascii?Q?75F7fCp3/DvGpyUlkHBDb9G8qMeI/I35cwLjQTpXRZIKtLIMo5VY0YtwmHGC?=
 =?us-ascii?Q?CdeOYFFY62Pa6qIK4Rf0KssfKkV0UhUE89yrbAFUpC7ZXrv+OaGp4uXOUZep?=
 =?us-ascii?Q?65KXS4bj9SOF2JQvG6DEt01P7iAR2iCOl5LRq07/8HMk7nKZn54lUZmx25BT?=
 =?us-ascii?Q?lzb4QLRuH9AXyhulr4MD9eOUV3yIqwIPHgxc65gvr93gxnzrE1GzSVu2xAGU?=
 =?us-ascii?Q?mq86hZaf887Rg9HN7nKAVT6fMzcDZTr1mdV+eA67cwxp5A31ZQkBpiGla+5U?=
 =?us-ascii?Q?5lPpcisrk9oijPZmTmwbqlX7akwFmw+N4/luCnk3mIpRRE0clb5o43CmjKU+?=
 =?us-ascii?Q?Xitl1ae+tCv+mw+PefpvkHQNxFhDzKWfZtCPdanj7Y3UrVpNOuOV7UyZjRtc?=
 =?us-ascii?Q?Z5n1kXAT08mjuEM58CQApoQrUi+dMaTPMvl33n0kYZyUeObOZqwfmTIII9qG?=
 =?us-ascii?Q?ECFGm1epVHpUK1OplHSvjP8APZx1IkGUcLElRRMtR1PDaB/C8fQS6ycbmvtE?=
 =?us-ascii?Q?yPDwZJBxx5MJK1TSiREmb0HxOjEWqviIGtBbTcxHr2pTLg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iB6u6GggJMpFDQVhrg2I0EDbfmtvhF2KliLlzPLQwz+XbXNNqiK1Fk8vL8F+?=
 =?us-ascii?Q?35RhROF9RYfXKFKdYgUX1lf1o+OOmaLnUMDRel3p9FzdMxMM6IsfnKU4z+8O?=
 =?us-ascii?Q?dckQQetV2XEhEGJ/kuWbkcDF0eSMsyfP7kNwnsM74Bs6uI9U+glm81FR/IiZ?=
 =?us-ascii?Q?+HiU3Amzom1mo7kIdwqE9uATumC0/ikXdCPaVbcMZTmz0aHAvWbh2IZwidme?=
 =?us-ascii?Q?2TivK2tpbol/bJCsPWahInJUyGf8xOJlczddEnDJ2xlhKRDMewxyD8LU0qqF?=
 =?us-ascii?Q?2pJrhe85AdaCrwvrIy1Muwrid18K1BFIkv8zDMrGjJRHmETAEp8wYgP80097?=
 =?us-ascii?Q?iDnJR0w6BuPD3gaeH5xMPDU7MB8aJF7W8StYbxlP6rr46GmaPew4Ii51Vb3l?=
 =?us-ascii?Q?7VhPPz/6u+RltRt6BuZUoz7ptRTC6tNuI8phwHFDKjiqwQLsfEGnFpsO0GWy?=
 =?us-ascii?Q?tSS4OAX8Pd/8uBbgeW+8JI6ipKLRkuzj3neHu/9yhSU/qMoVgX0WwoIF5WYG?=
 =?us-ascii?Q?glaM0NGDHsbybG8heLR4Mq3OR51o6GgN4gxsuKYYV9EaGchSHrqWMSi1c9a6?=
 =?us-ascii?Q?E9FUXtfZRVBjwIYlmr3MCnN36sYdiRPTBGEkd7Zha6IgQZdJ7UlPU9smaP5C?=
 =?us-ascii?Q?7sOgHD66MeVK+yI1wx6f1J3X0bLoG3AsSZPWgpUhVEF94Zjd1UbNLiK97kyP?=
 =?us-ascii?Q?wUS9efCjZGollVMNIg+xx5IKTW1irp8rLs0Ds9aSX9JTMvYA4YdUWrvCN6m6?=
 =?us-ascii?Q?iNFkk+KRwPBxYklu+mCEcNHO8i/xHojqmdHGBSLoFzMLT/OMIGAxhlUy6a69?=
 =?us-ascii?Q?PcmTpWJqk6sV0aeA1+YFDB87gKrNJaNcKmCvIx8RbO1juhZsoatqJQ3i1v/W?=
 =?us-ascii?Q?uyrxtYN1IHeP7bHxzfipOdr6zDIUpMyeFUWWUKHRgwpIxvrrTnIuSw/r3tHy?=
 =?us-ascii?Q?aaTFQ93K11+YJT9s4nBR16j+NaH9RLmqC/p2v6xcIZ1oIu2O31IlkauPWiFw?=
 =?us-ascii?Q?JGNbvg+b7wkXkSO7ADZb/34/7Bmjcmp0+oExBDIeLhxk+6SnP6E9bfq7zXpX?=
 =?us-ascii?Q?LfHTwYJNrPHSE5HElcb9uqZdWfrx/aFwr9DrmAGLOQU0qurehWRx3MEAOT9k?=
 =?us-ascii?Q?iYDZMEqb4BzN1LPUVbMJy3tVt9/Zx/2S0mpOuD5Oz0Bma0Ioj6kZMVv0Sh/b?=
 =?us-ascii?Q?wG5lsY8e0b6NP8RTEMxJwqMjeu/7QtrK6iT8qnRt3vRnNNFnsCNlJEisHgVI?=
 =?us-ascii?Q?bagBC829ieTa9wlpRGRcEdbJGrWz0p4qa4LoKknNHd4xzp0cxNYn45v+Dqcv?=
 =?us-ascii?Q?1ihliJL/Ykff0GMMZuqSHphex+h43f90294aUjPLAhAkwcV6B9EDhG391yB5?=
 =?us-ascii?Q?rvXEvK+UAipREd9WkHa6ranSVAthh/T3uAR89N0E2fA/KnJcBfEr7gQz9mvV?=
 =?us-ascii?Q?skKI8y1oUTa97A77VLB07qn7Z3Y1JD6MicN+XwEUgTRAa4VkzBew0/kOKXDe?=
 =?us-ascii?Q?23XKTc5l4s0OGu2xNezLGTm4IAeAvwuckI8chdKuciJe9fK9wF1O/flgqh6G?=
 =?us-ascii?Q?D3NVxfxtHrM6Xkvor+imzaYGUGi3VvIAY6yBq43tfYB6aroTVQOkCeXqgGRs?=
 =?us-ascii?Q?0m3ZgPKVmW5f9yI7vxlp3w0Sel95mHGGGkSKSofpx2s79ymwnQ5HQZAnj/2r?=
 =?us-ascii?Q?/+TPiA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	aGSZ93kNPtSqSeZmm1HnBXvEHKxwrVfJDy4DObn8LEgen2UDE/NV1aJqfpQ+bssS0VCyEEh3OP2rbcqEr30tFp4cgaR0IJbBW3h0oQI/ZEl9zntCH9hBTE0Qt6q6nR+jrjeGq1BZ7NUYmuoBaIp4pZ5pwfiNoaygG+cFg+lQrw3OjWc8yljNjanovOBu5DcSUQFs6nR+k+plw6bXW1brpyn7lLoz8WADD15YreFALURcKjIxWKgHf/iWQ6YaxL2aCPMdGFejilDA8/81Tv3GL8QtEYzqhKeOqC/BnJ0eTOs0CJTA8vlRHvmdw+OATK/EbY0X+XpEmVidbXDHO4PMMMag5cFRCHtapyQqFhzInRDENmAt+edKCMPLDvf4sgru5uwdF6FWfS8wpNuyqQT61ui5k+7oD2SPkCXJf/xLwOjGR0/TJxKWC2iw8BQaOp9LrtyGHxv4xAP0dF6TRlaJ0ybUcRogelu9SV7HqbyZEchc/6t+MgyAEiJ6/GcLspmiUuk9w7JYPb5EdGYv5PdwJK2pMXowCH/WKOIwlFtE8P/3eS8F5X2SWiOYLaELfOnKR0lxtI4F8VkiG+8VofH5Y3eoPRpLlma0CIGV/vS4Rg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75925d75-4d66-4238-2034-08dce125f2f6
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 08:00:29.2288
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eTh5JF4U+YxpNWy3o/uHxM2CtdX5KhbQQ1eDlSPARa/DsdD1k77qdeBvPVRjQ0lkSqgjuTaAgoIKF7EWaPG1dMIe69hy0APiDO2E6YHfqCA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5074
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-30_07,2024-09-27_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=462 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409300056
X-Proofpoint-GUID: B3EIONQdXIN-H4eE4p2SuYC1z9_c5JeC
X-Proofpoint-ORIG-GUID: B3EIONQdXIN-H4eE4p2SuYC1z9_c5JeC

On Mon, Sep 30, 2024 at 09:23:47AM GMT, Pavel Machek wrote:
> Hi!
>
> > Userland library functions such as allocators and threading implementations
> > often require regions of memory to act as 'guard pages' - mappings which,
> > when accessed, result in a fatal signal being sent to the accessing
> > process.
> ...
> > Suggested-by: Vlastimil Babka <vbabka@suze.cz>
>
> suse.cz, I believe. (They may prefer suse.com address).

Sigh yes I know, I know :)

Sorry Vlasta! ;)

>
> BR,
> 									Pavel
>
> --
> People of Russia, stop Putin before his war on Ukraine escalates.

