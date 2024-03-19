Return-Path: <linux-arch+bounces-3041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC61188049C
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34141B22A70
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0C42C85F;
	Tue, 19 Mar 2024 18:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="f+uitWpL"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2094.outbound.protection.outlook.com [40.107.223.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E05381C2;
	Tue, 19 Mar 2024 18:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872342; cv=fail; b=bn2SwfD3Iie8ZmY06q7ugtDJ9gLKkMWpMLGEH9Xym5JzC+XOnIVuqd63yFrHcXH5x9Gx5AamqaDFj14SDAODcNMw5yW3W9y0itB92FyxhpSePiaHy8lXoraGvT5kDFEL+w0HY6A5CsUTaarFp0SgDuVJJwh/a2h0218E01/HJjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872342; c=relaxed/simple;
	bh=Ysfidoz8DO1qSsX3ok4+gGrrF7ByBSGxDdKs8W3f7TM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=AkU2DxK+96ha2JGBpeUZSs4rW+rY6bRXanDpjMClUWaaaG/OlBP4Kb6wWW6HQS4A7YWQhdZ1uUPmKDjgGuIsxQpBSHq3nUe96LolA9TAufHwsbFfj51JHIVrVp2BANt7sExvqFgiHS/re75+Dmsnx/p7ibPZJNtBLNvnq9Lz3TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=f+uitWpL; arc=fail smtp.client-ip=40.107.223.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANqCyho5ghhrdrY+Wm0rE/+l0dindpk9zgIa4aNps6Er5Gjw0bY68BKGxBmSeae4WCKyuMElng6o9+RI5tlT8CZwDyDbTAfsCdFIcuSUIUu01cnIUi4oO+Xm8CAwV7P7g376c2O8ZuFRG5Z59xYgMU8bFI0hM7g2Lu3bR66UTWv6EDYgDQ6V6dOxFlZXb44veCA2bzAvdO2tYWeNtKuEKNMhjugplidaW+3vYkxESA7gqTJSm8EujxbcVFeVNPGZdgSLvUFPIVzSv7RE6pTDAVSCxQKgP6KOWyOsyfbKEivdi2a0U9pJi2cLK10xa9GElipRZdklvGH72ZqpgroXXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJdPwOi3KftfsHn3rEhjdYZs3NLJkRmJnadJFtwNXu0=;
 b=YIWzOyaFlkJYBjIQDlGKcW/ixcrYWcDdlKv5tc+KJ1QVZBVyQl+ZO6Do9qVPU7nPpmAU1HOQYqhvAEBqxaYyLygibCE1tPAhe33SNXbYAXQQfwSb5/tc4fJYcVYcqwLEEyEsZfhARxbhWmxDo4+YIJGm8fjbGScSSESZw1AmhdIPdKks6YJAC9X9wikSZYmwMQFrwlOmtQ5BQcwNFAoJ0afuEwFzzqNlRcHzpS1EPn7QB1IQSiasyeoHjnx7bCRgWq+i7QrSw9NavVOwAOOUHzx499oqYgFAOLXqTVwNMn9g8VospPhjYa5JdwPIKfQgBfRGff2Mo9K5A2MQJ/Uq/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJdPwOi3KftfsHn3rEhjdYZs3NLJkRmJnadJFtwNXu0=;
 b=f+uitWpLnRthoQyNR1/6lt/x+tlk/2JZf4WP5elkUubAFJACKyBhZl/aAfIEer3pAkwymzUzDX+zvXk5rnkUVBuaaoS512+u+F1+/zB+YKy6tk4ASA5xhy+D4SdW2JU5dzArl58iQGty4zGGUenQmQDN3QYc/GLknc3K6gfsnyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by SA1PR17MB5635.namprd17.prod.outlook.com (2603:10b6:806:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.30; Tue, 19 Mar
 2024 18:18:57 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:18:57 +0000
Date: Tue, 19 Mar 2024 14:18:53 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktesty
Message-ID: <ZfnXDfjyHPz9JDSo@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnUp7OAr6PFGAq_@casper.infradead.org>
 <ZfnWYcFLLVyP2Ng8@memverge.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnWYcFLLVyP2Ng8@memverge.com>
X-ClientProxiedBy: SJ0PR03CA0068.namprd03.prod.outlook.com
 (2603:10b6:a03:331::13) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|SA1PR17MB5635:EE_
X-MS-Office365-Filtering-Correlation-Id: e33ef2ff-cc7c-4743-01cc-08dc48410aa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	j1kKulfJtBZ7U0bb7H+NLf1NWuNsd44QcujL2BAMK3cjJdl/45RCLvd266H83N5DwDWzle2SaKWfRncwIYXVAIXTGwSqRFwQdSm2iqkLWq1BektUKO+8i+r7FG+XguNuFhtGovlYORoB/ybnRxioUhmoo3VjUUGJEqTFq9Y8ix1QYoSvCvxyUpjCROOnfDSj4ozDI158WEA5kSF3ZbK1h+tY/2SF5OnSkpyUxTLl61M+SpKm1naJrPtNxjqxOFC/n9ZeGV2SkkO3IqTyN7SmmwGmFnBO98DRm2sG/aOpVPHHPmrYxSWk9kf+j56Z/QYw52qmNXJqnVwCqG4ylnhPermrmy6M4g3zua0S2vADsn5aahndAIK+9SjH5lbUz0Lbaih/qDDXJCdSHCfN5PO71ECfUJ55tu9v/y28dV8w1eSr3REBCVhrUa7BArpV9J0DrRdYusBiIJNL7jg/eXxB8Bg0p6cV7Xkd3eBwZRe7nwruDhxR5pwKrKe6tQIg+9WvkZJ6g5RHgabdWjxwJic9QRV2aweyJqn/jwF0FrDnkyLTpZFV0Un892WiZkbH9bQekIKZR0p5YFl6I9mye6kEejgofcJdH9e8qUDh2ccYsfM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BNnV4xQeEvQawkJ4VcTMN3hUcgs+kZvS+SvNulBHykUSGCfHxsrkKjHV+ZHy?=
 =?us-ascii?Q?QK+516V/VIfLZZ0zj9JmaRJvn8rLituWgI7QXLO2mS3hgONW3H2+bh8GLpoo?=
 =?us-ascii?Q?zJFEXjUp7lZ3S8bFqUxcYoXsU9Zv3Lr9bNCdWCt9cuBc0GP02Cg19iXgibZx?=
 =?us-ascii?Q?qvXfBdxZEoqq0BUbSbVMamPXikDYJS4wjkJDIB8Sbmi+YyfrH3jEgYOxQ28l?=
 =?us-ascii?Q?h0/+e3AbGzWqqId+NrZUBAfwvEDGitxU0XUd4mUOEll0W54RIkIC5O8LjLkX?=
 =?us-ascii?Q?6L3qFw7fOBV5L630wOq4QVX1nFujKTVn9O0/2meQ8XImzg+okuSu72xTh90Z?=
 =?us-ascii?Q?Y4vkxYBjYFppSxSKv0DFqVw3WO1tbWZdTkKK3b2dSSy1NuyovJ5Dd9Rg6I2N?=
 =?us-ascii?Q?k4jy2hqkgva4uaTMJVrWcjGBVLVNb/b/H2Nfm/WOIPjCH6KsuWvlu+DsvdE9?=
 =?us-ascii?Q?aILOnSF/xEBqTmLckI06ttGkpBvCs+aj7Ia+EJuWls2BiYRu+fIw7z2nu3pd?=
 =?us-ascii?Q?EZmyHXfhZV+jVRzHC4ptxdFBnars+kzbbIhJQf/kz+zNt91pUbRkg97jbB0p?=
 =?us-ascii?Q?WKANoKDHuhaq2EbKcyGV0FEx2tsL0sO4DZ6mDdO2qKThBb8fD6rr7emH2GWo?=
 =?us-ascii?Q?LLVf0UwBw+GAOTBCYt9wSsMs+M72KCT3VvTU8vFxxrHY/k+G8xrWRt9ejsCX?=
 =?us-ascii?Q?6rGKJwtaEEp82ioBzNrKrHswfG2jJE6UFNClJlNk8ooV96qQo+eVZYA+UQGd?=
 =?us-ascii?Q?S3aqsGPHf0Y+MM2YMkoOuDQjeLLJBP9c9jXdEXxAKLywlrYLTZNHeLcJQ++p?=
 =?us-ascii?Q?Pc0U1eZwVQQ1S7W2y87gZE08Opw4TlyFUreJ3lhtlWvlvhSNwKL8xg2vBA+j?=
 =?us-ascii?Q?W07OUYodBCBNYWRJtYgiXsJQMDxyRhtWpxGvEuWOTS9+6O5ijvYA/wy2Pxng?=
 =?us-ascii?Q?6gGhoboFkXCItgwdy6tDuc2I38cJWdSMrVMkE0r2ML1xCmld25zag1LQmCbf?=
 =?us-ascii?Q?66IlPBv9IFeXPMiveoPrweCcOpSaUZdaHsTfddgjD05TRjAG6U+shoa1PlFh?=
 =?us-ascii?Q?UPRIucqylNd/B0uCRzeZVo1bYOZSUDeluQVVU31t/nos3PsRh+tz8O0HCwF5?=
 =?us-ascii?Q?0GsiOmBodXmPAlrYzjysaYmIANfs9RtWr6qdiqnjjeT4d/TkaPGPdGxVSUnX?=
 =?us-ascii?Q?PFP0/oX/lunOM+ALB6wVbG7uoX0AQSDWuyBUF6/Ifz8NwwtFVgUSoCr6tPyy?=
 =?us-ascii?Q?UcENC7o2hcfbdVUpvjxxB2AXCohKz94lX2E90aMhgJTkmqT0wZuSgJdu4DCL?=
 =?us-ascii?Q?4UF6sertNeJ2x55hV1jcdAj2hx4I16fazc0UxwdKTaLzxby79iQf4WH5892O?=
 =?us-ascii?Q?royZPMKwaqUz5Wf+Hz60oPjHm6KGFPTQLpsLs/IThs+sfMZaWXbgCgtKafK2?=
 =?us-ascii?Q?tcocOIRotPTbD0w+iYZbozf8wb9uvvTZA7iA6fL5P8dYoueQVGjRr/3W9DP3?=
 =?us-ascii?Q?cGIn7eDifBwdif3EjFfkMgN1ljLUDabbEKbGKqY0Aprch5ZT/cL3BStth1jG?=
 =?us-ascii?Q?Wzk5kWUh0Je/NgwNIuukcG/WXsxLYS+EyFVNgme6qziTdW4AwH0rUdUWvKnY?=
 =?us-ascii?Q?+A=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e33ef2ff-cc7c-4743-01cc-08dc48410aa0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:18:56.9881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fCVXP7/hSweoxNyBWPjhgGS3sJ1cRsCmdVNGCiD9cl17gOgXPnGxW2QqNHD/k7wW/cK4bNpjlHhEW40Iq+iWyUJAb4XgMfj8zBTmnCdRnVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR17MB5635

On Tue, Mar 19, 2024 at 02:16:01PM -0400, Gregory Price wrote:
> On Tue, Mar 19, 2024 at 06:08:39PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > > > Implement simple ktest that looks up the physical address via
> > > > /proc/self/pagemap and migrates the page based on that information.
> > > 
> > > What?  LOL.  No.
> > 
> > Also, how is this v3 and the first one to land on linux-mm?
> > 
> > https://lore.kernel.org/linux-mm/?q=move_phys_pages
> > 
> > Also, where is the syscall itself?  The only thing here is the ktest.
> >
> 
> OH, I see the confusion now.
> 
> There were two other versions, and I have experienced this delivery
> failure before, i'm not sure why the other commits have not been delivered.
> 
> Let me look into this.
> 
> ~Gregory
> 

Full set of patches:
https://lore.kernel.org/all/20240319172609.332900-1-gregory.price@memverge.com/

I've experienced silent linux-mm delivery failures like this before, I
still do not understand this issue.

v1:
https://lore.kernel.org/all/20230907075453.350554-1-gregory.price@memverge.com/
v2:
https://lore.kernel.org/all/20230919230909.530174-1-gregory.price@memverge.com/

~Gregory

