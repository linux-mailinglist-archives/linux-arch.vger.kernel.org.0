Return-Path: <linux-arch+bounces-3043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AEE8804E1
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:32:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F22E7B2366B
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ADAA38DC3;
	Tue, 19 Mar 2024 18:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="OMIOPYp/"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2103.outbound.protection.outlook.com [40.107.94.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA3B34CDE;
	Tue, 19 Mar 2024 18:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710873151; cv=fail; b=SKaGCfAEGvyBEj7e9G4mY3equexzxW2j9SP9h1nTWEh7nyXkyMJnBL/nuLSeHALBnLqBRQPujEqBXXKqh6GxO5VgXFcAVxzs+zZxGgErA5T3KBqYzYRdFedoM7w98DBMlml1EZMMI7UIgt6paz3ww4GI3CcAREVNk1RdrZBs9Y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710873151; c=relaxed/simple;
	bh=RRTfdJQPZ2HCw9RNKPTG8xZSUZd5nC1zd3KsafreWDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MICjqDM7UyBqlm/0s88HZ09/YnYPP0gJ17vQ9gFW377K8+jdHSYPT6xeG/qbPEgvB03MT2ygs6Y8Sg6yEZ4ho7WDqc20UqdC32DZ3USdZ3WYyX+KdzkRjF72p8Cjde9GChnuR12Ni2dcQM7inqFeh5mgiRyC5xQL6X+a2EqQFmU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=OMIOPYp/; arc=fail smtp.client-ip=40.107.94.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TWt4PXJF6UUt5CVhnSxsNoEIjFIblmR2xcPXsilqLgscy/L7Qu3k7jYkll/gyAyAAyg298SzgOBNilViyucNEBwEHus5a9LbV8zeHHpe8bOdM2LPMujJFzfGpAcOIFKXPxI9n+ozW0ZXVxOXtt/q5WUYD3Nl0/6yl4AJkkrAlxYx/TwoeU3MPu7b1BjIYfXDdMLePgJ1aCVN9bIhWVre+D35nIMUi7BGiPcnb1Rr3KeC8OEo4r3/CaCwKj9qRcqrHg9hFrkoij8SisDvsvRKIlY7UXQw97Vlxh3oW5icQ673LL/fi4VFZs69J8Hpqp4QP62S7q4kU+o7b+GW5KVaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GYMuZTB9pewRuqGpdMNm7ZNfIRvs2hgMd3nrqSLo3xU=;
 b=YrPk3wl4CJdjprgeZ3WPvjUb7xxy0Znlk0uSDGN/c7U38mo2f6jwuevFjg2hWSOTswK6mYdjNRq1dHa2H8/QHh4jK+WqwCBoWC5q7fuU77czNZsvlghOnNxRZfY76gfruEBCOfnukICfqOSHkm42fBs5sOxG6b8+uvJybzJZ6oWjFys2wJGy0MkMFA7MSwKTPVgmiRG77aMaItfHtCtqAAznufR2N+CX53ksfpAMgXgEoQB0Ooq2kTIpjcStipyNF38ce32Ra1WiZeN6c0bA7x9q5I8agqvoG5p3HSl6AhewKrivLcV+jB35HAQwRmd5aeElModqJYYG1RQaW76C3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GYMuZTB9pewRuqGpdMNm7ZNfIRvs2hgMd3nrqSLo3xU=;
 b=OMIOPYp/vdDykG7Hq3GOW4gue2HRGdvEIuoeMzczrFHyR477YPQNYJM3TbxJuwLVt09LAthyrEgZxQubHf/F4uIvXm8+1b+nXR4K8C6GgqlA7qkO30lFFI8Ckl0FttAY3nzF1ylR30l+uuPw9ebYRJm1jX3/sguqKS61dVFTCKY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by CH3PR17MB6241.namprd17.prod.outlook.com (2603:10b6:610:143::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Tue, 19 Mar
 2024 18:32:26 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:32:26 +0000
Date: Tue, 19 Mar 2024 14:32:17 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktest
Message-ID: <ZfnaMa6x/O68ENsP@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnWCRwcZJ4KBmSH@memverge.com>
 <ZfnXcbd3h3Rj4IIS@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnXcbd3h3Rj4IIS@casper.infradead.org>
X-ClientProxiedBy: SJ0PR13CA0209.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::34) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|CH3PR17MB6241:EE_
X-MS-Office365-Filtering-Correlation-Id: a2dc5df7-9846-447e-3a28-08dc4842ecc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q3d6POV+OzkubII/tyaKvEsMaWZLsNnjgLD9spJWyx+zYbysafJm8DK19mQ+wwQg6HHtBVIaGYvEyWmRRiZpkCZiGmeQ85pMOHL12p+3ZsJcanddFghIb6z2Jewc+s1TbMiufo45DoA21ecVOcQpdGAzoA513fnr50hFsDQ0C73yHswSjS6SL9BKU4uTW0yzcBS2QCLVWC8R9BXNGIG0QxZCz/2T0ZexzDtK8oT1eR3RTuBFsPOGTB0OQCPqNhUSEipntR3hprASe8vO/FzPCS9tb2cEpvPTnnEeVhBeuBlKnb/m0aRvzLZEwzT4OiOD8rMCO1RjAjKTC+EksoON/eVlE1eieAOEogULvgH1jgQlenhdec9QEUu7zujCYs4g+EuLgIrQMUVKSOsMPa0fO9MyefhUjX8bF7feWjZTizYDQ+F6Fy19v7aGlsYPKLlAue/eDtbDLt17qWoHfLPwOfkYQhod61breICZ/pKrEe+/fiAke2G/P25ogA8+KK9gDHjHeETwftrhWTOsPUx5BoFFQESWUm6BbMIIpxnBqCda16SVxAIkfMn7GvaHko1u0aILFvKiUylmMFGSMAvHyBcQG5meGnsRtGXqG5hy57s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Op609ko6MWsmhA78P7+5bOSgdqfbk2oC6xZYeuolw8HPRcMrxrA5jgne91zZ?=
 =?us-ascii?Q?bCgEYts/AvSfhjejvkPSi55zKOMgbCwLP1NKzqr5AfPkWehjtVldiIdzr0GX?=
 =?us-ascii?Q?kHcfAhjnnO/NMS6GTwjC4NqyEYbfIy0vGJ+balICYbqm6gYcJfeMqAQiGbnk?=
 =?us-ascii?Q?ZnWDMaC86VQcMQq/TsMnvfPsOApzx/GiYPuUKPy48vWMqCQdXkE/+zsgUd6T?=
 =?us-ascii?Q?7huA8MImlsn8SnPCThsBZASbv/GXl60o2uWHGhHBfYOsC4+Vl9zCWMy3LNho?=
 =?us-ascii?Q?31LTPmQ+tOaWeuH9Lc4Zj0bsIr8uG9RsB4OVFpyAQzJMrOLgaFKnJ/xAFuWq?=
 =?us-ascii?Q?gj0/EXcMgqBA8DVa74JNRrtWpqGtJOUgb+PYu6SW6G1XXIg3/HYkyjqIR3Wn?=
 =?us-ascii?Q?hSb83jVClAK0FqFxx3azoZVA+yCVqXf9e6kzz7/HTi2qlwVRukKFVQepSjtI?=
 =?us-ascii?Q?WE1xC2qOZWAAEAdqcdJ1G7FGtkgdcyLC13wfwA6C69/4d4sdupvsyTlRMR9w?=
 =?us-ascii?Q?m5U12EtIGhVIlffRM6j50yhSmOJSvfGj3nbumvsm7GFwb8qRpk5ScZ0ogo9T?=
 =?us-ascii?Q?Gw8XVwM+RBt85vZNYd19F4InSzg4axTlFlPyphkzJYtPrE8e8X1CBDSrcc8/?=
 =?us-ascii?Q?kbwgd4+WboEl0LXp1HJ8kQfNcssNdxxafDw2eohSj4j53YD4Jn89t4eW5V2h?=
 =?us-ascii?Q?JZnmMVWcA5cvk80XfGrtPTF3MudjDU4lqOo0sNyXv73Zg/73nsI6oO2sKBwI?=
 =?us-ascii?Q?K1xsvGZFMITb9WkWcCYdi6v06ZQHqsM+UCSrH7THRBEvnfPaVDoLQj/tXyAR?=
 =?us-ascii?Q?RlDVsu8mbV/JsMDTvV9DyTxQ1+mk1W71geQfBTrPtn+GMujHvqOCltM37uzY?=
 =?us-ascii?Q?8BHkY8fUcRy0xZ3eWuocQj/sAzdBAaKUW/x7mXuiqW9GxuRucfu0L9cAHDSO?=
 =?us-ascii?Q?KYMNFRfD6xA+V8E/lla/C9FPhtgQVhYglOoGA147JCoWF3y/1xrj19Jx3C9n?=
 =?us-ascii?Q?75SkFXUltkx+i1wnvZJsExWeVpMoPDfG3ucFw1S+B4Uk/Gwd2nfD47r6ejoR?=
 =?us-ascii?Q?1BJVY/TsgEq8M30O3h3DGdKzZXh5bO9l0y95ZqwNE+zN+uT5o3w/QA9ACh8R?=
 =?us-ascii?Q?e6pX4Y2Z9U387lEgOXQ+AtIJOH1TIwMttZLMYzFaIGDStbd/JgrkPTssZaTo?=
 =?us-ascii?Q?AD9tci6aDqO8WlMd37ChkgmLDBBJ4uZRC3DlnmHjC9qbH3F0piEh7idpF7pj?=
 =?us-ascii?Q?aV02+FXunf9kaBrnL0RfGi11XpEhnFPS4Ai5iZ/oH5G2GMtjGykvBDEcPD9P?=
 =?us-ascii?Q?RiJS8QFzw6NoTeasxhk5BYXOXvEDElxVfn+OgJH5y3AP4MIA46tWedDtnTS8?=
 =?us-ascii?Q?l/fZ1F5zXf3ERPJp7kCXjRt6q/nXjQha5lMjAt1KInYtLhKYkCdnlNbVbsQy?=
 =?us-ascii?Q?SEGPdHlqHK4jNQXLuHL1h0QHmVFleCI/fpU9YpkUwZGgYq2gjZ0PtbqmzJBm?=
 =?us-ascii?Q?U34CImzhTgm9gP9t8u95RvsG7ezuBkK6l5aD7v9jRccGpormwQPz2NmydAjM?=
 =?us-ascii?Q?FZq1Ux4JYgRYD2uZTR69R6N5psfntGpEZc+d4fFGLEP3JYLZKfvEcx6zh2U5?=
 =?us-ascii?Q?OA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2dc5df7-9846-447e-3a28-08dc4842ecc6
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:32:25.8840
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYLxySmzOpQiptwxMEWtFPcFzm735g4X8+nw+TSXisvY6J2djBl9EZ9IubbrPTS4JwfzUi4HqSDMKg6tEO6pO8x6G34/EIvlmn3ZXobhK6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR17MB6241

On Tue, Mar 19, 2024 at 06:20:33PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 19, 2024 at 02:14:33PM -0400, Gregory Price wrote:
> > On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> > > On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > > > Implement simple ktest that looks up the physical address via
> > > > /proc/self/pagemap and migrates the page based on that information.
> > > 
> > > What?  LOL.  No.
> > > 
> > 
> > Certainly the test is stupid and requires admin, but I could not
> > come up an easier test to demonstrate the concept - and the docs
> > say to include a test with all syscall proposals.
> > 
> > Am I missing something else important?
> > (stupid question: of course I am, but alas I must ask it)
> 
> It's not that the test is stupid.  It's the concept that's stupid.

Ok i'll bite.

The 2 major ways page-hotness is detected right now is page-faults
(induced or otherwise) and things like IBS/PEBS.

page-faults cause overhead, and IBS/PEBS actually miss upwards of ~66%
of all traffic (if you want the details i can dig up the presentation,
but TL;DR: prefetcher traffic is missed entirely).

so OCP folks have been proposing hotness-tracking offloaded to the
memory devices themselves:

https://www.opencompute.org/documents/ocp-cms-hotness-tracking-requirements-white-paper-pdf-1

(it's come along further than this white paper, but i need to dig up
the new information).

These devices are incapable of providing virtual addressing information,
and doing reverse lookups of addresses is inordinately expensive from
user space.  This leaves: Do it all in a kernel task, or give user space
an an interface to operate on data provided by the device.

The syscall design is mostly being posted right now to collaborate via
public channels, but if the idea is so fundamentally offensive then i'll
drop it and relay the opinion accordingly.

~Gregory

