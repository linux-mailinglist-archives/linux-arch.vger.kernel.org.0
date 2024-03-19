Return-Path: <linux-arch+bounces-3039-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD77788047E
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 593221F22E55
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D52F2BAF0;
	Tue, 19 Mar 2024 18:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="lYGTjT/L"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2116.outbound.protection.outlook.com [40.107.101.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFDC2C19F;
	Tue, 19 Mar 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872088; cv=fail; b=F3AFIKfzjNrISlf1P6ZE6Q2GwWaVxXNH/wPerAcy24dj5hoVyl3sSTg3HaOax6+EiP+TgwwLG7bU4+sPD5JfrbDpHIdxrUDqwR7urkxOvwDVtcjBqCXi5y8n+V+b1rvS9ZXR0M3bRnZryxJJc5gBmZS+w/DQUDn3V9fR4am+A8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872088; c=relaxed/simple;
	bh=S5M+lYzrq90CuSjU5+pq2WdavrRQT8w2rE4m2MqMqkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=euab6eL1diDIByTF4y0aDqQsCjBkqIYB11XdTZqclTcJhuj1AdYEil3C4PpXJ0qLBB99dICsHx6JoD4+B5FPgwdJ+MbTLr0XkH/ABItfeTFblMBMwXH6BO1pobR0DYo8bIZYCj9lttppRVw7DDnH3pDdTAPaIpX2aChE/RXf4Jc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=lYGTjT/L; arc=fail smtp.client-ip=40.107.101.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YZqWN4HCCBF2iM/Ja50o+aqYMhBcolUNPwdNaQvMJginG2NcYXfS5OZm/ZXs5D2l7PSzeBbPJhnnH6vnnhbA4SBJaiBXmogpMM3BKOLvelhhu0K2POCktdED3HaaV/Gd+S1j40Ns2XYd/+D6GzWx+O91SzVfBxoRga48dnHdVCiITYLf5KJuIAaqX4+1TS4o/DvlxfScNcyNMU30nNEiVfU+g2Zf1ypgSyyC2HKK9gFuXsFOQ9EJBJWfEezd+i+8u3qLFsb538GUc4qdDuDTMdtQUrOQrxD378h9HdK0o7ZceNAMYVbBA7WYKwcB+yLs69xKfF/zWSzTK+iNLaY8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=szrqnx704GXn/hElzy7hXBwP+q0DUw7WxgkZguMT65s=;
 b=ULFAR5WiJwhb+U+uq7Y4T30owKrrZ5QwasYsuqOMALlaSsWKOfp6DoO7htUyrvradsTvO2Swr8IUFZYqFXG/94QiaZ0kRPfV+I10SMlBFyzdomj4q6TiFjz7OfEn98HR0Mu1ic3lFL9myRz9Hby821eM50DYTOsrpL7WnkMqlySp8dW6mwIkMT58oqSfPehRxiM5qcmhM3ZGfDkONLsjiyI8y336w7RazFhc/iFRH2RBIYhuZqZW42R6nkojzG+0AJpYPcZB1VWDESywUOQ1o6jsDnqjY9QNRarmenYfVjX8kwcK8WUkdCTcJILidUnsPuxvUOMXuSFmJ3tuR+fheQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szrqnx704GXn/hElzy7hXBwP+q0DUw7WxgkZguMT65s=;
 b=lYGTjT/Lom04OcHrENx3nV3ZRPTp6Cd6f7edaAp8ybfgqoaln29CicJGU4rVryNWJpd0nlMX/rn+AXR96IyXFQVG4uY/hNy3+OyNevZUrT2g+yKoSfiinT9Wf5THU5OW+88oI1ppMczOtUm3VrcJGwEtQ6quV/B5HM6v/I0iuLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5770.namprd17.prod.outlook.com (2603:10b6:510:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 18:14:41 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:14:41 +0000
Date: Tue, 19 Mar 2024 14:14:33 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <ZfnWCRwcZJ4KBmSH@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
X-ClientProxiedBy: SJ0PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:a03:331::24) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a6d935-87d2-499c-3e3f-08dc4840724e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rqOkvhnaOxXLYSN6KP/Z9Dy6H9em6t1Mjl9e/9Ci0acdRKFAi8xN+QmsWUAPU1+1sIqBXaIfAkS9eKpGx8Oaj5c9YCZz+FuPQSp5UiSP70qnKIOu9dNeQuInTE8gV+QUMEM9Lzr96yIhYc5FZDNtYBfyt5ZJDBcYUYkzuwJjgh5w/Sp+5VjcINGHt5kPiu9GimsLv1BMU0pVlhB2s9zrfVO2K7fqixV6up8WR7YOaVeG09b6ww8FyxH0eDmeLnfCIqg21XuPhMyLDkU5OzRF//zpQ9Em5o9DTPNs44j1mR5pg/3Lb6mXP25PNfxYlM2oSOehOzmrKHFjDIAtECaz2ZCNQrIgosi/2ca8NJKxCetHHZCeXRhasusXDKLqCSbRK+j2QCMnBKDmrlytTosfw5jEyw8HAgcBCLSADGxp2tCzfkh40ysV62wxNlXt4O7c2GlnXGbpuxNeCTSQff+wLHKaI1Pd+DXWoQh/mYhbD2jMM24cu8Tq+yU/Aq/Ydoy5lwRDRsi4o8KgdavMLAr5Gd5S7jOwl3L9fS1zz0ApZcqZ19ats2W4HWUJzFTYKyNJdi0vOLHW77NpS6u4tAHN1peIYGxsO61b1jQlLdq7x0jVKXiyM8DNQA1LmgWhWM7laTFtZFjUAyV3ozEs5Hlo2pvY78W9uuNrddsQAwWyRXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CF3+lZBrS6227smP0thPuLFTE6BUAYHeOtJLDBPvYXHkMd5QPoq3FzYayych?=
 =?us-ascii?Q?jNRpKV/sScEQ95edWusb9aTGdmfa+3d5xz+fK/uWL7GihvGofz6m7YYC9BIC?=
 =?us-ascii?Q?JHdE/NcClMh7xxJ3RdjEf1LYOApNEoWnRIZp8MIl0cz/KQ3VbbvILvo3wNAx?=
 =?us-ascii?Q?8KWOxcKoofBLoXxkFZcyjYwCehmuSFZZCc6q7EEnt1rw93pp9i9uPNTdX/Ah?=
 =?us-ascii?Q?eWyHx9XKlLJFi0gk3mafr/mkqXL6FkZGmKOqrYdB8g7eJ34v3AVUVv6qY4BV?=
 =?us-ascii?Q?A2i8Blis9foQY5MH51xNAEizaBW4FC1df0gjQAM5q/wPRVKZaaWGUAlJZNjf?=
 =?us-ascii?Q?WfahoKAOKO5DCrNXvpbquGT0YlxTYOgVvwbFbHf3M9jlfhxfPW2PwToB68lR?=
 =?us-ascii?Q?Z8hsm3qItNY3tjjkVRULV4wq/sGskHnuJZc6qkALrKL6/7n1+p+Mt62+3Laz?=
 =?us-ascii?Q?frwX+vnMQ1Gm6/cVgIHtj75lMdbDpN7XD+aLQ27TvFaSo1Un8QrdbovYrxcq?=
 =?us-ascii?Q?6811He4tiq+KcMFm7IklW9bXo7JSOX4VKvMCjH/jTkpnk0DLfK9W+uBgEgzt?=
 =?us-ascii?Q?43o7P8TnX+Wg4bGFuotuUQb56qL1vLrNpDYZdWFqv7bDiwsASsICPT1YRpjC?=
 =?us-ascii?Q?2RBZTmqqQGwLTe0w5tI8WeEptwPhMNmmlBO1MD/MzJTutLK2XnshVzvdqguD?=
 =?us-ascii?Q?OobFDD3YTU661NuFkO+y5LSrB6xc0byUdIbBjD9Qk4XF3Bqsz5kH5uK48eAp?=
 =?us-ascii?Q?Yms5Rj5/McwFNYtYPcodVVrMUZ8X9Lt6kgJtGPyD6d8Mf3j/sxeo4lXzxC7v?=
 =?us-ascii?Q?Dwx3ZkrN4orByVfR51/jNpiOBvLePMCDiEX+S9lsEE8b7ZpN46dcb4vq731D?=
 =?us-ascii?Q?Z/A5CiWZgJnCxQcUl6tghZciCQnsQgJeyjT4kYjjt/ptd8lbB5FWvZEcmWUN?=
 =?us-ascii?Q?r2CRxfnBvAwbVM36xtvJjb1ZKk6Cz4eMxHQi9CSUmACdSLpX96cJJuvNgOpT?=
 =?us-ascii?Q?Z9nqh7i1CxfUO3g2C6sifbPT5g+kiswsvPI038CEl9JM4taEGeEfqz9ZrUqa?=
 =?us-ascii?Q?i7p/sK70HdCpUpkfkdVoJeRl2eEtj9eot16rFILgcE5zlLxOFUMrF7NkjiHS?=
 =?us-ascii?Q?BohNx/yi9SXPtRr39SdRDk5CgwLu1kvNaR9vDefCiIxKCrZUbENn5M2qVnM9?=
 =?us-ascii?Q?6lD3amVw9jpgk2tkQ7NufnJiAVt5tCqS2CTLMJgIYJN5IneUYTz8cB0hHoZr?=
 =?us-ascii?Q?JQBbwnVh7U1QeNvAqcCkAjht1Od/XiABPoP9my75Zrmqg1hCK2MyOMSlF99r?=
 =?us-ascii?Q?6uBxKAryuMSEsvltYSqh2EYeBqSKQOivsn+OidufWjtXaSFY2083ySCHIFPT?=
 =?us-ascii?Q?qPJ8GX+LM9oJ7NwRnh3ev5UICnBGOrN48LlDj3BOTsB3HDu204za1kcT5Lcn?=
 =?us-ascii?Q?QLfpfCnhuLADIcpPB3Nij/56f3u1x5pKIqVz+wbKY2GXNXsiT+f/Q6cImKHW?=
 =?us-ascii?Q?3DkoqhHTQky0W55rlbMQGcMxTaj9uI7gkOwyRWJTUUrZR8e4a/wrzOuXC4vi?=
 =?us-ascii?Q?I9xNw0myQqLMAhMQ6WFL/o6S/04ubcc4EhPjPl6uUiqZpQPy5S7D3MVxKTYu?=
 =?us-ascii?Q?5g=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a6d935-87d2-499c-3e3f-08dc4840724e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:14:41.4679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8nVSJ5rV//08lUlccoeZyPi8ErwXcXr1+ZgxB615mMc8GGtwPwL86X9owx8s8UgJNs63c2RFJThOvafvRv4Vd6cak73P086qxhMikYl42U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5770

On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > Implement simple ktest that looks up the physical address via
> > /proc/self/pagemap and migrates the page based on that information.
> 
> What?  LOL.  No.
> 

Certainly the test is stupid and requires admin, but I could not
come up an easier test to demonstrate the concept - and the docs
say to include a test with all syscall proposals.

Am I missing something else important?
(stupid question: of course I am, but alas I must ask it)

~Gregory

