Return-Path: <linux-arch+bounces-3040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA1088048A
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 19:16:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C29B2B234EB
	for <lists+linux-arch@lfdr.de>; Tue, 19 Mar 2024 18:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62122E64F;
	Tue, 19 Mar 2024 18:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="OQx9v96W"
X-Original-To: linux-arch@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2114.outbound.protection.outlook.com [40.107.101.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B2E2D052;
	Tue, 19 Mar 2024 18:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872170; cv=fail; b=AeL7KA4KlSyDT0FClWZD+hqPGVVeIkgULTNF+iJrSbpyr7GWlMEhFQrONGmllZLin9UDAIRq19T2VfdcCFHVzCtbTfcaqxYS4u9VXe3aiI/aYmguu6JlRDWZBUul5CzTq7GDPCVbnQmwf0Plw2pV0kkWZzGlTF9+X1ad5Iyy4iw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872170; c=relaxed/simple;
	bh=4tNJlZ/AdebjAtXjFlpO3okVK3ruYqxPqcoBlGW1JDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=YssSegRVoUMaQuzQqJejY/VB2KYuEIKn9tgRcEIOQau8Wrmwk1UVrnnmZMZ1xz6kVOQ6bT0GANj3TJ+mpXQZGnwfwTtD44zQPGXD6Bg542swnCAkIfLUhi29+48tOpG/dWXiiX8yu+5QKSHAM3/cs7XChqMs1V6qV7Ey+eDoZ4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=OQx9v96W; arc=fail smtp.client-ip=40.107.101.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOrGuy70ylpBREr5VUzuhbTnXdxr4cWuabFEXZllJ1XRsHai3nXpB0TyXVI64XDG2uG3Z8MSZPzmGk81P3Bzf7mwa/inybR5kXvAS1QuHlWqmQ0avNgN+g/TkcKHPnog6aaplcGD0KzoVRysU3SGW/JuVxK2XhFzTBU4PmjYxDv72Q0A8DUAAQWfbW2TsbPjv0OYX0NuqTpAv45d09tLzXaEPsjddvQ1H/SBAJXcvqqBSmIgt2ALN+SCGmt+/RPZjddLCcbt1hdsaJLJcz/udjf8Q0vz/iAAhLMe2aIXokAnOHk8TGBnUOuCpHutikooQ2XwHVUkuLfRkYrptaNszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bMIMlXWXYXaynI7EDwKoAfujpoSi7+wJYSi1W6XL3s=;
 b=WSQMlivp2+/Mq0PyLMLor+iSEzQSlUmYwe1rQWXErq5319j4DGzfJqPTm6lgmwDZf65Gy/YbcmR6HmuSoVz43EgzNzr6N3vjgYai7pJNR4U8MJN1IgfUL/ajp613tJW64JMiJS6pFu81HsAwI3yBrLu66eJiPkCIYbbYj32BIrmnTu7ZvQ40FetBlzzIRKscNes3nKj5TXuC+WPhBaTuo1FE8GBBshVYdEqFuXbe8Ekbu5p7piYXI4N1Fej+NfxuFOI1/yTeDOjgSHG09mqX0FbjQgHIPjDY3SDgTyelPWEhEIFweO7kwilrgU2m0lrmrbvGvMWCv6fmUfl5ZP1LHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bMIMlXWXYXaynI7EDwKoAfujpoSi7+wJYSi1W6XL3s=;
 b=OQx9v96W2095W2ohQbbJlpy8tJyxrE809aOd3+dAR2ghyvhZBkYBNvHPMqot8aLGMOsr9DWOhHCmFMdzRxapGCDzVQ+VGqsn/gc/3jM1HrnA3DidjVPLpP5JK3guZ2o59WT3ZhpoaQzXCMY8ElIyuZIsskpbYdlVFEhckbvg67o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5770.namprd17.prod.outlook.com (2603:10b6:510:111::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Tue, 19 Mar
 2024 18:16:07 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6657:814f:5df0:bb5b%5]) with mapi id 15.20.7386.025; Tue, 19 Mar 2024
 18:16:05 +0000
Date: Tue, 19 Mar 2024 14:16:01 -0400
From: Gregory Price <gregory.price@memverge.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	ying.huang@intel.com, dan.j.williams@intel.com, honggyu.kim@sk.com,
	corbet@lwn.net, arnd@arndb.de, luto@kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [RFC v3 3/3] ktest: sys_move_phys_pages ktesty
Message-ID: <ZfnWYcFLLVyP2Ng8@memverge.com>
References: <20240319172609.332900-1-gregory.price@memverge.com>
 <20240319172609.332900-4-gregory.price@memverge.com>
 <ZfnQ7n_7cZvk9BkC@casper.infradead.org>
 <ZfnUp7OAr6PFGAq_@casper.infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfnUp7OAr6PFGAq_@casper.infradead.org>
X-ClientProxiedBy: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5770:EE_
X-MS-Office365-Filtering-Correlation-Id: ad9f5aab-7606-4876-969c-08dc4840a4a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NTRLrF2RlueaN5US+RM6IjCchL8QoduRkJLqIYb2yI1BK7MwAXRO8lVvms7wlDKxktPrZT+uHwaVxL4gnSpH6CaK4KNA5j8CCfN+LKIJOht2+d2KXcl4en5LGl4Znmuq16LxbxFlOtmW0HGqRLFZWbtJbxbpi/Ohfu9ECVi0GGd18vWeXiqGPix3fL8PriuJAq8Ts9pfpjCx6EYQ16+PYLAWSSAlFUKlfUNxliTI7ryXJ5vCWzJCedjsQlNUUC9RIAtfTwIw8zYSY+IykepvagVGUUUUEMvUitNEfgB6s+TLeb458BakV3d8SJadgnglwYeJppTUCFj/UqT/i/OflmFNVE4N0p+q1DghpQfCadhZv6VsmoSI8yBVKCNnhnz6DXFrbdPFJJLbSK8v4wPK0+LbuX7t6CS9T+qauC1NpLsh4efIZyforZzH6Y/1TasUvsJCSr6MwFmY8o8r7bimpXsq/g9b1uskS5MEJRVo8FJwhtiKmCTFLE4GzjMD3YpykMDw5EfAwWbpSuweRRBSgMdyxAmsfudiHGmuZI/kvoXkTtjrOSthKWmxtq6alQEhkhWl3wNgnigkvGCxHd8yZ+usha2m7K2hRmRoAIsuhy8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(376005)(366007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OVRQb0TbK1TfuZLCotMt++VInKqP3M3H30w0Lprd46rxQoMe2kJ8Oa4y12BP?=
 =?us-ascii?Q?wUzwNOqJRiWOl2/+YjvNLq94qtkAk40aAUg4kllozEmo0kP6DnLMSOBZJ8XS?=
 =?us-ascii?Q?4KcmR8MTiy9tf6zfkJMHQ1cbJ4N6el5G/DVeuSxl+LLJTiEmPGdNc1yTEhIZ?=
 =?us-ascii?Q?SULO4Zs7ZFRuRrMM8ZOWV8U+RmU8WiokdgFsaGJ33NknbNtoPsw8K2kBEwn+?=
 =?us-ascii?Q?DbFcJfdosszLu+8DgUX7W5bDhKKhfBM0AYVCri8XxTkxHoZR+PXdoOe3hTmE?=
 =?us-ascii?Q?PDMb7NPbNQoVZXnAL6DUnHNV6LYkYiZ3WDMDF7/UXeh8sN+6G88UlhFOiM1G?=
 =?us-ascii?Q?kK8OJpzyMWllGh0SFj1mpF6+4vVNKX3rhjXSnVIfJoWFnQA1gtBQloikfMIL?=
 =?us-ascii?Q?Y4J1WyBy0pe3sNnMJrUw6BHMvo1JppcsYyOJ1xB9goKW2OUyaM/vhFhP+c0j?=
 =?us-ascii?Q?82ZjaeZyUQ621nMyuws7O3czbfct/OOw1WEOOvddo1pmUyMqORhikBAiYNpP?=
 =?us-ascii?Q?TjsiTFCbeQhm8QrK7DBfBiBvnzd6+VirEk0BTJAox6YzmXLLun6OwYh03OOg?=
 =?us-ascii?Q?Y+PdX+p2uPV3dBk7nXnOtoNKYhhc9n0lrxYlIme2tB41RbShqyknkk+UYw1K?=
 =?us-ascii?Q?F/zcgkvOMYufpdDHHcMZYW8x96IY1cDco4QvgmJhDVqcLa9f+EO3uUylKNvb?=
 =?us-ascii?Q?DS/HcEi07pfk6fa67AQ0nBdexYpVCDH0U+rWS5i6YSHPH2HTsYinJdTPvg73?=
 =?us-ascii?Q?F4O7q/AJiinVA4JXRZCSVKR79jzKA3+keLHK4Bw85TWQ+KYyZ6+AyPfZ6Y9D?=
 =?us-ascii?Q?NyZioKk0JMwg0t50jB5A66/W91awlivqV2sOqtwjQeXXGdSTHKJUmORH2Y9V?=
 =?us-ascii?Q?YvWCeNmDzCvkoXThGgAfXVRFumUblhOi/zIhBB2ENGk6TsYa76bdlRnKBTS1?=
 =?us-ascii?Q?JJaYeuWvBtDnBUC06TQoJPlleE7EylNL5aikE3GUxkJ6EmNLBoHEgPjG3voW?=
 =?us-ascii?Q?EFOSZa7qq3na7buLxINeIlobuzRpnwNsX2Rc/J/Ymcjl3nciKk+TnYlcrvjo?=
 =?us-ascii?Q?omsxw0SwCfYymEr3f/biIMzqoZTv3LJ0Lo0Zppj2aobxZMz53+Yw91Lw50LK?=
 =?us-ascii?Q?OQLRLaJ9ahMh0sG2Ff5Y+HxFhClRlcYCG6s5NFjiTOEVObOH5fHOiIspQs69?=
 =?us-ascii?Q?eK1TjnSueYMooxwZyOsJ+ro9hwnydnzfZcxD85gmhVxLi+aq10kqrznR3VA9?=
 =?us-ascii?Q?ItXrt0kBDisH/UnusSyPoblA5lplAO/yFo1UeYH8+DOR3qNaJsNc1tM8U4c9?=
 =?us-ascii?Q?lnXD45+iDlcgrimotaCtzwiA6YrOFZCXPe2mIwUXKr8g3ws8c22mZsvyHM73?=
 =?us-ascii?Q?y4mtcSb4jP/piKQcHuhxOR+lssp35iF4fvuI9rIJhStRGJ5vuS5uUL47c2hn?=
 =?us-ascii?Q?kyOwG6h/QIftMmEI8CFlqsHzBLKVtwEQ2xMF0IW7IzxoVXNW+slLqi3mz6yc?=
 =?us-ascii?Q?fyuzVgE0hD8g9xe2s8NvcCL2RUVvCJVzEnmFgn2vIY86zRYuMX5noePVA8PI?=
 =?us-ascii?Q?x+KRp4pM/bv4dmkibjX7Zex1ZWagBeoTLfS2RAw+juG5M6hLtrGyOnP1yxBR?=
 =?us-ascii?Q?Qg=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad9f5aab-7606-4876-969c-08dc4840a4a7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2024 18:16:05.9139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zZkuOYtliYnwTKZ650n3g7X56xcW0TLqj/K6O5DHb/5hupeIAxYYI9oam4Bz/Yqvp5aSxfvmcYKLRCRsvWDRXHwX8ajIhN9joI5M72t5Y6k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5770

On Tue, Mar 19, 2024 at 06:08:39PM +0000, Matthew Wilcox wrote:
> On Tue, Mar 19, 2024 at 05:52:46PM +0000, Matthew Wilcox wrote:
> > On Tue, Mar 19, 2024 at 01:26:09PM -0400, Gregory Price wrote:
> > > Implement simple ktest that looks up the physical address via
> > > /proc/self/pagemap and migrates the page based on that information.
> > 
> > What?  LOL.  No.
> 
> Also, how is this v3 and the first one to land on linux-mm?
> 
> https://lore.kernel.org/linux-mm/?q=move_phys_pages
> 
> Also, where is the syscall itself?  The only thing here is the ktest.
>

OH, I see the confusion now.

There were two other versions, and I have experienced this delivery
failure before, i'm not sure why the other commits have not been delivered.

Let me look into this.

~Gregory

