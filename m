Return-Path: <linux-arch+bounces-15599-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 36139CE7A17
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 17:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 70B0A300CB79
	for <lists+linux-arch@lfdr.de>; Mon, 29 Dec 2025 16:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 544FD335073;
	Mon, 29 Dec 2025 16:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="FBtljdWq"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO3P265CU004.outbound.protection.outlook.com (mail-uksouthazon11020109.outbound.protection.outlook.com [52.101.196.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B57331A45;
	Mon, 29 Dec 2025 16:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.196.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026190; cv=fail; b=dZETZKkZ8meBg/PSeCDkhuSgG3WpFOzsSP5+7igauNwbmjFkNfTOHTKqmn6Q06axHNE6xcnB5BRboEVMGylkyVF8esJky7izIFjOH9dqsERSAqlRHBoyGDDlENgsZodoWG/Rk0Hha3bXY/o28UnYIMmIL8kbNMEyFyjCuoI9vEg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026190; c=relaxed/simple;
	bh=iB5nq1ltlcFWbd1CjY0KCm0H3MQzRtJL23v4gURhzZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CNgLz7fSbGF9Ck5Fve9iRQ9eudML57rMROW//vmi48RhIA5AKIV4bifkhtPJ+lnMDj3a003tlbElMICVYO6/C2WixqVVgZ4t71sZYpPvbZJsoLoIxguWKl1jThaimOQjiz7zcykJErz5z8vtQiMe1BcJVOI7mEZAb/cj6+g458U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=FBtljdWq; arc=fail smtp.client-ip=52.101.196.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnz28faDWa0ABFjux798OdWUJO2Qo/GE1cJNj5IZy3w7XfGuMPCIeLLXmZtzCrW3NcspOlTRWdU0Uz6A961mn5jWmW9i3a6j+D0eRS/JIioABG72eoFvwZCesD/x9GGI9zMj4a6PX6EBsVynb+sUvoZ/Oooi/kQ0F6fYjh3T6Oj/4pSCAAhTdLBt/4gvvzSiIG6vzqdx381QQbxHrTq1kWNvHJRc58ipVYLXBvNCFnt+n1Q+SXg6fatmoCD0+YDWxdHfGYLK17KdLRAqyNhrGUuRsIZIllFTqcIqARfuZHQL4tnabVu/G5PMwp1l2ezQCsWX32xuDTS0eMAhoi0/8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNE7/EDRWC43ghc3PijLs9T6Yz4+4pWRpWyyjI7ibg4=;
 b=YcUZoYb33aclyyLnvgpfDsFJ/7/otgxXfNbB5UQp8R0nvFjqUm7C+oJVu4T2EYVHtOE1tBxlzBfi6UkUG98jxWwXkhOPd5MGDdmmgN1ugJ/gFTb4MeCntY0MivxxKatMvYRYtVdKaRHmIeVeYS6D0moz5SorEmqjDGZjCBFokoL8sMXZwK1n5XCoSBmpdNN3zEiaEHmimtjWuxBvMdPCv6yiO+/EK6BTTjbfUAnxPMzAdCgJFFwfA/jobqQsTKujbqZeBHYP+oQm0mKgockIR+joN2M5LH0NCMK5/3uepWl5tCfBogQJF+nEhf6ZkE/qE3cZx/Bg1sz8jG8ADcI8xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNE7/EDRWC43ghc3PijLs9T6Yz4+4pWRpWyyjI7ibg4=;
 b=FBtljdWqGTwKX0nYm5CV4Vpk7WVToVlVB/xYi9mHYavwS76TCOSkkJ+pkFIiebyrYSs4G3kgcmCBufsG5nXwdMiB3QKOhmUwdK7gplIyZahFd+hgtNMqMy29DEYhMoQWMuALNBtp/MR2Jbt13ykg5d6CznwaVF7ckNM6zjGUya0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by CWLP265MB5236.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1c4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9456.14; Mon, 29 Dec
 2025 16:36:23 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::ea6a:3ec2:375d:1ce0%7]) with mapi id 15.20.9456.013; Mon, 29 Dec 2025
 16:36:23 +0000
Date: Mon, 29 Dec 2025 16:36:16 +0000
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>, ojeda@kernel.org,
 a.hindborg@kernel.org, aliceryhl@google.com, bjorn3_gh@protonmail.com,
 dakr@kernel.org, lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v1 1/3] rust: sync: atomic: Prepare AtomicOps macros for
 i8/i16 support
Message-ID: <20251229163616.732caffb.gary@garyguo.net>
In-Reply-To: <aVJiR72gcz_uonoS@tardis-2.local>
References: <20251228120546.1602275-1-fujita.tomonori@gmail.com>
	<20251228120546.1602275-2-fujita.tomonori@gmail.com>
	<aVJiR72gcz_uonoS@tardis-2.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0696.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:37b::10) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|CWLP265MB5236:EE_
X-MS-Office365-Filtering-Correlation-Id: 8167a05b-56cd-44d9-6c71-08de46f8677f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|10070799003|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AslLgBlZlacbArGj59nWP2okwv5999pOINlwmNu/G/ZasoHhZ4ywlFaFyqLg?=
 =?us-ascii?Q?jLALlP6JLseiT+y39Y+AU1Nky/a/YOCSsC0AWtDlwgTRQa8GtNS2KBxPyjUL?=
 =?us-ascii?Q?6ZdPHwi8oDbfuu7dzK1Zgq44g+mUgvboALbfKdz3EGInmLs/SIYtdW0akiwk?=
 =?us-ascii?Q?zfQQT4/K0AKBzytFniznHH6QPD4zQA3H+zXdTnOBzjctv4F1w82Z1WuBoFz7?=
 =?us-ascii?Q?3PFHi2KUpQCcnPlh6KsXsqE/a5WZGrW5jQPg4Cn/lXiL9hEE9wTPVZNh8kVm?=
 =?us-ascii?Q?3vZnwkEhxCcq0mK/mJNJWI7PFdCmvW/QgYTpud9grTfsXS4VVmC0+YDtNbL6?=
 =?us-ascii?Q?mPr7+40pG81qAGFIEPK1poXgj/wORofxej801t/V2ZZEQAnFU+R+1TRzSgk3?=
 =?us-ascii?Q?wkpxi7+OTGNTtIPawzKena+51IidC67HOBgyr9hFmiXgREhyVWDQcSYi2gZH?=
 =?us-ascii?Q?/7LnJ5qMri2xxxil83rqDTZLK8uxkYshZqPofjCLABI60izVRheX+KL0jDUt?=
 =?us-ascii?Q?QUQvWYVVXVVMPTE2LBWdrdV5DZyaagbPgg1dkK+2NWmTutsLeX3Hbo2LQS+y?=
 =?us-ascii?Q?SHwc8m6ievXgJLGP/tgN55CXkoUN8mVwY9kdI5syCRJgeZ7mSBweM97Xk+Ls?=
 =?us-ascii?Q?qYZOzwk7YHpKPCiSJWGzw8x/VjsipTs1r9NzAEYqhqwqymprRPW+Ib5qZUkS?=
 =?us-ascii?Q?pd2U5kmdK1v8AVaJSU36ibJYHVLItvZ/xC7hJb3i8F65ws9d0wuL7A7gAEg4?=
 =?us-ascii?Q?3g1VL7EG/xWFzQbeSKpNCbF3yjiHUAiffTgH+D/xPX0UBfMhlALP7HZZHnRl?=
 =?us-ascii?Q?XD1VQ83F2wIzg2xwxJq91s/pfwOPzPT3FymxxhAbR1pQYSwrDpgWExGz49+M?=
 =?us-ascii?Q?FRqK/ZTLi6xrdYXU/bSfcDTY5uF4ns2ilnLgp9ft6fyVISAx8ZMy5wLM2rsj?=
 =?us-ascii?Q?li4aZs+zdCqkcPQv3f1zEz4ZESZxyCQy2knn5eRQIJ9IImRtY+wJz/gQfPTf?=
 =?us-ascii?Q?0gcUPjfSBrDIsKKEm+ubLyBNJGQ47cIfkNx9LScNYk2fQAz7Wv6NLde0h7jb?=
 =?us-ascii?Q?HXdPh/eY8Lf+Wqa6JPhm2Gaf6Gw1qENC8fSVKw7PtiGCUV30r0aABN2rEIIs?=
 =?us-ascii?Q?EpgUHAAM/tcPgPhE5mVxqp7jw9xS+VftGsVkQIEzoHdHWBbbap8w1fImsVQO?=
 =?us-ascii?Q?XM1q6fxMEVsIHNv0PT8hm7Vq6JNiCnxyW5IONLgQ2yp4gMT1CtLSeo0TAqch?=
 =?us-ascii?Q?Ggt0tboZf5vRZvCVxdjv306aikSuHSrMTbPiI4V2uxJJa2mgOk1b8avCCg9F?=
 =?us-ascii?Q?fTNsHgDswPan/lmRyCmVMaaf+hm460vfyJGPmQSKl4hFjYfzL/N7UiuIc6sl?=
 =?us-ascii?Q?3JeLORkCZF3O2nXT04SETRacLeT2BdjqzHnr3XnKohKmY6+WwBe9Je5Ixba/?=
 =?us-ascii?Q?PFObVWmVZjUpg5Foqf5DEKsLvhCCrcUS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(10070799003)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nLdGLztOVYtOPlHX/kEUjesfLEZGMNf9g9JSsnk4bPMqOphYukxPZXMhzxYi?=
 =?us-ascii?Q?S+QB5ivq+GuXA9sHOwr/kV4ZERYuw/ppEBdMPum4GzKmwsUTKx4qA7F3nHNp?=
 =?us-ascii?Q?xBlIjr98DfTnMqsuI0ikLwiDSnmCJIJvQC/Zp8plR4gPQW4pa1miPapPeZl9?=
 =?us-ascii?Q?3Us0Bozvfb3LTFH5CMuVT3NXjhHzuSSjExaPIQKbRPWOf2RNT6+5UDRrcHtt?=
 =?us-ascii?Q?m3lhhE0RzaoI2RyNDznH4TDykN0YA5HH36bekNqsALWkgueaBLOErOkcViwn?=
 =?us-ascii?Q?WAfzYeHkkm7943K63+GnDHZDCKKLXGYY/dOV8XWEzfXfOfWw8vR3aV6N4+Sk?=
 =?us-ascii?Q?SBcXgUFStQXQFDyeAOlftoJkINEA3oFXR/3YIgQLxKZAaW/uUxh8MgjQlNGp?=
 =?us-ascii?Q?0d2n8QJjPurwyBDrbaXJ+p8ZO9IiPVcN1IGI+0V6kRcqolqsPWuJMgnvlB+j?=
 =?us-ascii?Q?jRhz9Mq3lKAXeQVY3RSzHANwHD6wO5sPIcdEpGTzX8QNAIyH+8GlGR09GSl2?=
 =?us-ascii?Q?k0t09raznzc5Lx5U1myKQFZBuuPCGDQeAG1lTI3FxUdNYBIegc0zhbg9t8UU?=
 =?us-ascii?Q?2s0bHW4NMoJruJodaqpdvd02FQdon2t0f2wYPXQuDXrsIWB8dIziKid2POv3?=
 =?us-ascii?Q?bPG4jjTLXoEREdhTwEwteTBsYyAHMT0U3QVlSU07sy3X9o0oNmI+MfvLxIHt?=
 =?us-ascii?Q?2w0LayF69O+ia5hsO9au5YNRfC6vVwS8eZFMwsYrQ2Y/1v2gfhG+XmR6KIu/?=
 =?us-ascii?Q?VUBDXNE9k86g0Ph/LjR+eWR3Ifaddq4ClxGKyEIu0OBePSLz5c/j2heXYpFg?=
 =?us-ascii?Q?aSJJNfp/U5xE0eb+dKu4BnmS+EwVrGxkBllD1r5px2fBOPE4Rsct/Lg5Wd60?=
 =?us-ascii?Q?Y1QDsoj3dOyFXk8L5mQ3tXQ6L3E32s9fFEZ/jY2pcW7znjcVHuyd6KZXVdql?=
 =?us-ascii?Q?fovIH0TS3or58o2wetSyI5VFWrafuL6ThBJFktrb7xAR/KXWx6dNvfJj7X08?=
 =?us-ascii?Q?kHZhX4dsfQebWezRsQOy8wUWEIILU3jr3jB00UDQmdw1T42oM+IH/AVnjab6?=
 =?us-ascii?Q?iVCv2GGQEeDCzP20hC2Nukwn64PSpSmal3i8lWjpwPRL+V0j6e8ELyHg+KVf?=
 =?us-ascii?Q?MvwsItnH80rATtngfZw5pmFhPQCdbHXBXcogcr3rgDhBE639rLyj7Iz2KCvb?=
 =?us-ascii?Q?Hct7Hk5YbrdZD6vwF+Zl9qGOJCLz5jJfO0YUpsu/q/gb2RDcTQ9oLPQpFH9m?=
 =?us-ascii?Q?EiABi2rQu39YanFmvWo3PhVN/Yu0fH6fZx24h8aDaRaNVFc5pf0u8oDjyP4F?=
 =?us-ascii?Q?fl2b2ZEuZvtnGDbdtKMDXI087fqpYLFCT92XQMQv8QTUKhFz5PnlxiSHWACS?=
 =?us-ascii?Q?le1d/1YGdjTpxMxTHlvFu73p0galW7BzCoSF286Ztb5+oSNVaiPMZSarM7Kb?=
 =?us-ascii?Q?bT3Mwgz/msQxMkQUlFni+Iwi0IHysGWQSMiACjdHNjzbn21UtTHgzBrdpVK9?=
 =?us-ascii?Q?3V5BDRBlQ264Cazx8VCHhq9AsdyQ3xtnqA4kFeTwpZEiHz8TQSvUeegh4kPt?=
 =?us-ascii?Q?SkbQBTuix5jNfjmd+Xgew3bkYLU6JvbIsVl/frDxSpaCUz71is+JkF0Y4AmZ?=
 =?us-ascii?Q?TKJlPSMT0Of6JBAUt56425MTQxuTGMzhI3kUZaDEBNxFNBtbSMFnfZlHfQwQ?=
 =?us-ascii?Q?p+Y0IcM1MvsgzIYOCs27bYDnZ6EniOVUrmUGnjm3pScb7bPOB2i0EUhbcuSm?=
 =?us-ascii?Q?5XrOQxP4sg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 8167a05b-56cd-44d9-6c71-08de46f8677f
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Dec 2025 16:36:23.6630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KZX29fu1lbqLv/Qcs1AgkmZuRobcmzE6lIHwjEqRR3nLeWyzEDmifwvuPFIW6A15t0FFGUgJmBMcIqHoz08JQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB5236

On Mon, 29 Dec 2025 19:13:11 +0800
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sun, Dec 28, 2025 at 09:05:44PM +0900, FUJITA Tomonori wrote:
> > Rework the internal AtomicOps macro plumbing to generate per-type
> > implementations from a mapping list.
> > 
> > Capture the trait definition once and reuse it for both declaration
> > and per-type impl expansion to reduce duplication and keep future
> > extensions simple.
> > 
> > This is a preparatory refactor for enabling i8/i16 atomics cleanly.
> > 
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@gmail.com>  
> 
> Thanks! I have an idea that uses proc-macro to generate the Atomic*Ops
> impls, e.g.
> 
>     #[atomic_ops(i8, i16, i32, i64)]
>     pub trait AtomicBasicOps {
>         #[variant(acquire)]
>         fn read(a: &AtomicRepr<Self>) -> Self {
> 	    unsafe { binding_call!(a.as_ptr().cast()) }
> 	}
>     }

Unless the proc macro is generally applicable to a wide range of subsystem
abstractions, I would still prefer to use declarative macros.

Best,
Gary

> 
> But I think the current solution in your patch suffices as a temporary
> solution at least.
> 
> Regards,
> Boqun

