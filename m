Return-Path: <linux-arch+bounces-15635-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A8ECEE54D
	for <lists+linux-arch@lfdr.de>; Fri, 02 Jan 2026 12:25:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8265D300D401
	for <lists+linux-arch@lfdr.de>; Fri,  2 Jan 2026 11:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05782EDD4D;
	Fri,  2 Jan 2026 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="xDQA6ZVq"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020096.outbound.protection.outlook.com [52.101.196.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CEB02ED87C;
	Fri,  2 Jan 2026 11:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767353126; cv=fail; b=n13JjBeDOFXbt8rtIgHGOTKK3kUWOXl995MtInUHKcuJ2nkftvWjLwkUydFbFY4t6zmNTrlj4JwAzlkVTvo9xGrszyjICvo+OCjE9ZBK1ymVqPoIu8trXFP4FKTjEakChBGgv+oiXiouAWG1drfqtSok74+wzNzPCxH1+WtwsBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767353126; c=relaxed/simple;
	bh=E4DrRfXO8BEx+RRTkN6d55nIKkv49jDQGFKy0DjYywM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tO5mm5MbcOVzYitODni3PjDb3UJBvZ0T/8BsWB2f0h8HdAsrFlRqJmOGs0rqQUfyR2HctAxKhLK1rvZb4999oY5p29/HSx6CaDOkkiDdyIlAVieW03ALrF9bh0tsTeCinDiOyCE8x/vMdOhOHNhbs5i913REO9MlK2rqfF4y44k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=xDQA6ZVq; arc=fail smtp.client-ip=52.101.196.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O/iCkn5E+o+MUrCE0qC3/hl99sXK8GiCryk6ubygwBF/Mm1BpUikbIsD3bMO14Z76haK6G58oxLVJcofG41KmH76hSWWHPEEL+Q43aU2/9bZWjvyNc288ZlQZc1i86oSYCjZJBjeHCM8JTLBGsnVxjb5mrrWfoMa1KXfWlHe4QbOwoWXvwsiePTP/yqhXiusmEAhnuB6KqJwqKxU51y+cmwR12M8gdgsoLY9MAbgxcBmnEfCcXdJ7ZynjL3IGZf+N/783zfq/P+EoyYzKr290cNNTogRn1SEdU9TfxnEX/McMqCY47W3wHDPUT/Ku8aFW349zvP2aO3u9QD1rsKtdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h1+c1QLxWWHghfCOxKuVLLlqM09o/xrDWVd+BCi2v48=;
 b=bY5WogEq/CA374rTWh9nte7S7ff97Y9EvB6MSeieRUHHwVGZbzIxeCf5nd6TYWGOOEZkV1Tt2uWEswuGsqC7TzhF2/beuOIF5acvXh27e9M+97/KiPqJMczhjp4LyMgYpP4vf4zB2aE/LcHxRJPUAFYd418Sn5byomBEslc3QKpmNoFlKN4e43K+Cw2aq9+LoE95FKZRTeAyaA1l30cVLaZjggXcnqkS9IDe54kHTYFtfSrsprFRbpzgG0d6hMpJi2pN+x5id+GpQ8YXSpjfYWl2zegYAKx3UnyZu1PRDCevYqH238SuZmmdpZjXzhJ9jmGac5KWazOnRntdd9eHVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1+c1QLxWWHghfCOxKuVLLlqM09o/xrDWVd+BCi2v48=;
 b=xDQA6ZVqwIqT2UG/VrGVY/Kj759TI/PwMZYdd47KeHQKs2qIxT8FIeL5sel+9gvTKcqK7nJGF/gJyUq2nrTILMpGlZZdxkf1+d/D6O0MyJ9huFRSVuI/Xz/Lo1PJ2yi9SZX3lX2Om06U9v2N4hIOzQTCu053saRFLryYAwiohzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB8706.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:490::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 11:25:22 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9478.004; Fri, 2 Jan 2026
 11:25:22 +0000
Date: Fri, 2 Jan 2026 11:25:20 +0000
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: sync: atomic: Prepare AtomicOps macros for
 i8/i16 support
Message-ID: <20260102112520.41fd5ae2.gary@garyguo.net>
In-Reply-To: <aVMaCTO1zOAHU6fR@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
	<20251228120546.1602275-2-fujita.tomonori@gmail.com>
	<aVJiR72gcz_uonoS@tardis-2.local>
	<20251229163616.732caffb.gary@garyguo.net>
	<aVMaCTO1zOAHU6fR@tardis-2.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0458.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a2::14) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB8706:EE_
X-MS-Office365-Filtering-Correlation-Id: f5227276-2cb8-4079-46a8-08de49f19e0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhszO8/JLelenRBVf33aWYPuVOFrdzMTWX2Uz+uobhYXwtj0QLsSbnIARpXc?=
 =?us-ascii?Q?QnUYehp0ND/1v00KoM4DEMxxjKOjdn/u12cd23HmvJ7MYbuL+ieern1CjIop?=
 =?us-ascii?Q?OoLuimOFPxZHt41eeZUgE2zR/Sd+ZaDOEIqVWsv722lF2WftI5+X9S/mL4Ki?=
 =?us-ascii?Q?xhCQwT+rlsbh0JYjHUr/6hfL/9KYgQ5SaZJBLMBaR+vxp/SQZ9CPxIOnPczs?=
 =?us-ascii?Q?tkc3sq+bhoLKYbVOmNDe9E3BZh6hrMHLiY6+I6Ju08ZmOtIDLXHczVSJGdp+?=
 =?us-ascii?Q?Nxk6mC1fAxMfI1+tJeuAB0mzz/RuPLIuhRHbw3AvXNMDO41SjRFDZTGTbFaS?=
 =?us-ascii?Q?GelahpAuLwdEbODjBZ7DxOuXKMiZEdCVHriUjMmwdO2CwK0l7b01QdvcMuF8?=
 =?us-ascii?Q?dYBKD4IvS16ax6DylTvZ5vLW6z8s1fvWYE/Pg8vwVvS3PiM4WVvIy2ApNYai?=
 =?us-ascii?Q?zTpo0Ux4G8bIh/I5ohYUbSfNY0Br85sfq7WRbZrvf3/KC9ndI6zBRnanrqZm?=
 =?us-ascii?Q?XnSXRog2RBI1w6PopKoKHEuASla1Z1ygMGOeYYHQyUqoXviTuwvxepjAjQbk?=
 =?us-ascii?Q?mlDJ66Qfu05LErWkiSXT5nH3oSLHiWKpAqpt5x8XytwY7Q6JpdiTyCAO39ag?=
 =?us-ascii?Q?lsIWzXMP27JAxBCZutJO5AEh/Ynz8R6QjzY9wLuK91OeO+YXkK3iRFoQrFew?=
 =?us-ascii?Q?dI8EI2DnWQK2WP5n+aPV5bvfSSK4lIHsOJhf9LkKpKmOqzbdz3faaQI9Ldro?=
 =?us-ascii?Q?OkGKLuLJ5aKffHMgkviFSF8ObK+LHwZfhq12sXh/O4VfwJXHKMgwExoASPLX?=
 =?us-ascii?Q?K+4lI/HdwOKyuShQLTcVa5XtpJKLtY8/FsNeRgQKCYbSTNR2teKCVKUVTJJh?=
 =?us-ascii?Q?SjlJVmSaYz+T3+6UI3NqZBBKCuz/GVUYHQaKhPymgl3jjTPVMNmJ3k/c+uy3?=
 =?us-ascii?Q?n6BXvV6stWrTjPl/ubjBmfyFefEyi1HcVF9K3cLU+syeg8S5ahVL5Hsgmbht?=
 =?us-ascii?Q?DXi2Qd2GHURCEDwQfBszl6pbM+8IVu3W3NmJ/VZV6Z9e9hohR5D9vjyebXcQ?=
 =?us-ascii?Q?qm+bxYCnCHjNANrChOqwmDz3SEfwb1pcjB+jjrIPGtIc8dD7AeHPCWTNwmS1?=
 =?us-ascii?Q?PYNFMh8ZFG0qsz36sCGaIaqmC4CohJfvGGvYXz0KejvPS5S0PBMpPpRKPBnA?=
 =?us-ascii?Q?OISh0ZVijjGc2siX7HTs93ET2rLfBaLuxt3v62kxT0hEmcH8Nz9rn26YORbE?=
 =?us-ascii?Q?METGMcwmaN2+KfqGqU66NlQ8vrRflB+ytFTzARBPAHZhNnSQptQyGpV+rZmK?=
 =?us-ascii?Q?dq9h7Ou62hazIB0dDp5n/req3POYoMz4pI8ZG6WAcg361ms+dxvylg/HC3WO?=
 =?us-ascii?Q?Jdp/yNe6MdPY+QoYxgOiuUCUOwN6JOK9Watlx2DOyGV4IDYcBS/fzFb+YBiM?=
 =?us-ascii?Q?9FhnLw3jn2OVSSfd50iXXtoVCpERPMYS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Pn5jyJrIWcIQOMfsBfIgOwO4bN4Ybt0KmRwBGrJh4wSIcGsMG+1cSCUGQCit?=
 =?us-ascii?Q?pZHksbPs2zgOBepEImdhLznTmG2GIQAQ2gdZl/o7Dnb93zS3ea2vsez/xmPU?=
 =?us-ascii?Q?ecLbvZIag/VaMvN+bgwJuYSTCSVAA4fp+qwZzcQYJ7+FmWqxERr5RwMLNy5z?=
 =?us-ascii?Q?j5Ph5lcSNXp2unPgFY7GjI3nVMjY4al7WteW6bmu5rnlxn+DHpip5w6icdQV?=
 =?us-ascii?Q?Rp1MP69IH8jNmUC1zbGuk9vofj1Euck/JaxJRBu5hRx4dhWXv2igHFp3XgjB?=
 =?us-ascii?Q?nhtne/BJAg6VNpgfzhHmo5BzLKPAtp9amxALsd0JBDZb0O0lnnlw79k5fk7I?=
 =?us-ascii?Q?iIXZerv/PmYvJAfxojVlbx+MXwKFApxitBpEmyfVZS0eE45PIO0qHYrY30JD?=
 =?us-ascii?Q?ghOli8mCFGTpA146KM8DAM1XMBkS5maFjF5FzmGqRBdadPO/1/tLsf77vFlG?=
 =?us-ascii?Q?eoZIKkkysqNQ9hLEfATAh8u/MHMfOXl2kQfi7B3/5JCNbSe9WEojjtdhpPhz?=
 =?us-ascii?Q?zuTTa6CqQx2J2Q4doDer/iGVOZaCAPepU12KB7kc4JO6CkgmCZ+7y7cRiGiM?=
 =?us-ascii?Q?FfjnWYTfol1l/+H7WfqYxA7HXsivSyDafRtYeLLKvT4KgFdGAQiV6yAAFo1Z?=
 =?us-ascii?Q?PRKdGtOvkQ+FU6OwODcNLfGV6C19TXNckNZ/k568QFbfQR6m9mJIjLQ7iidV?=
 =?us-ascii?Q?TuJsBeu9OPe9ZqKPdB89Ij4hFigSrXtgDeg95FjlU89DGl388NW3eLAVOGeZ?=
 =?us-ascii?Q?qrnF6HK2zodrsDIWtZKD4sfngAnf1SbT96OFPS5MA+2Iv275dd30aFfnMajZ?=
 =?us-ascii?Q?C202YhcNGtZh18ewQmRzYAJjtRwofa6nCM9x/SNDsLdnAgfMaFQCeXbgjlbG?=
 =?us-ascii?Q?EMl58YOGjCRnK6/4JOWY0HE9FLXwXDMhxh5Wvx2f9GD5YHs1ElCJ/yAV0aFJ?=
 =?us-ascii?Q?aeNPyJdNufpgBiZNWRh/Zr+jgsnPLZDhaDUrQwh5fKHn+ZX+Nqj9rjou5TOY?=
 =?us-ascii?Q?E/bfNk8jJAdqMdQqgOfZMuWSyGyVj7qp4029Mq5Vo+LP6edNTNvzbsKZsNwL?=
 =?us-ascii?Q?sVTeygcZD+7r2dfcXmLxMrlmtMqw+Sy/m70arpY66pJUs8exk/E1zkePkYIz?=
 =?us-ascii?Q?eu5tUP7btsT9vuJVWeKGrgPjrJRZHv1BtEJTOpkHUgmg7rv07GeZp//h//gh?=
 =?us-ascii?Q?ZZuXZd1XWzcA4l0lnzpUsDzIUUMrpxuRAb/5E33wX/AnjFSQkDkF6b3PJz7V?=
 =?us-ascii?Q?NOBXv2FVNwxbDZB8hoUANkUTTqVwPCUI0E/giuQ+hFhCak8fTc6IwSkXDtmn?=
 =?us-ascii?Q?pggKPisiIZEezj3gadx+a6gvTOvyplKJ0Rad+o8JKUtJFfcaLmhs3E5KQ//P?=
 =?us-ascii?Q?idRVZrMIbhmd0yqW304tDDrY5c/MNcGgv7Mye9ThHuTNp2J6zi02g8ViBQeT?=
 =?us-ascii?Q?CZbeRlQt6OGkIWf+vz8RhwOKDN1+GLfZdNpN3MgVxCi4eQiUnk286Bi/VVzf?=
 =?us-ascii?Q?zJT2/uOYTQpdHJKdhCWHtFJi/OvAPiQLBwH7BF1Px/COW6IwXY1e/Y0g49dK?=
 =?us-ascii?Q?hBdS93eNAW1X5ixWjNZ3fp8aRsrOlEmLG6R91UaBW1YZSso7tjPlWM6n0aDD?=
 =?us-ascii?Q?GsoFu5TfZXzPmdlb/Z9rzs2bpdpppJW92MeHaXyeOqBQwthar5urlv89BSD+?=
 =?us-ascii?Q?sJOYH9U8UAwTUrHqccGtz9w1wHJYsEejeJ/NrOHCb4CfvxdeAR9A67shr++E?=
 =?us-ascii?Q?h9SCuMN8xg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f5227276-2cb8-4079-46a8-08de49f19e0f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 11:25:22.1921
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wbniyqt/qhNHxfLuoCTAzV9YDPf8VBG8ByxLrkMY+pSUEyGzzsc0Sb5BVwg+wVAZIz6nnB2eyFS7+64+5OLlwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB8706

On Tue, 30 Dec 2025 08:17:13 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Mon, Dec 29, 2025 at 04:36:16PM +0000, Gary Guo wrote:
> > On Mon, 29 Dec 2025 19:13:11 +0800
> > Boqun Feng <boqun.feng@gmail.com> wrote:
> >   
> > > On Sun, Dec 28, 2025 at 09:05:44PM +0900, FUJITA Tomonori wrote:  
> > > > Rework the internal AtomicOps macro plumbing to generate per-type
> > > > implementations from a mapping list.
> > > > 
> > > > Capture the trait definition once and reuse it for both declaration
> > > > and per-type impl expansion to reduce duplication and keep future
> > > > extensions simple.
> > > > 
> > > > This is a preparatory refactor for enabling i8/i16 atomics cleanly.
> > > > 
> > > > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>    
> > > 
> > > Thanks! I have an idea that uses proc-macro to generate the Atomic*Ops
> > > impls, e.g.
> > > 
> > >     #[atomic_ops(i8, i16, i32, i64)]
> > >     pub trait AtomicBasicOps {
> > >         #[variant(acquire)]
> > >         fn read(a: &AtomicRepr<Self>) -> Self {
> > > 	    unsafe { binding_call!(a.as_ptr().cast()) }
> > > 	}
> > >     }  
> > 
> > Unless the proc macro is generally applicable to a wide range of subsystem
> > abstractions, I would still prefer to use declarative macros.
> >   
> 
> But the tt-muncher style is quite challenging for a boarder audience to
> understand and change (if necessary) the declarative macros. IMO, if we
> can have mod-specific proc macros (i.e. macros that are only usable in
> atomic mod) then it should be fine. Thoughts?

I don't think our current macro impl is too bad (not really tt-muncher I
think?), and it's still very readable to me.  Proc macros can also be
challenging for a broader audience, as it requires you to read parser code
:)

Unless the macro is complex enough (e.g. pin-init) or has very broad usage
in the kernel, I think it's still best to limit to declarative macros.

Best,
Gary

> 
> Regards,
> Boqun
> 
> > Best,
> > Gary
> >   
> > > 
> > > But I think the current solution in your patch suffices as a temporary
> > > solution at least.
> > > 
> > > Regards,
> > > Boqun  


