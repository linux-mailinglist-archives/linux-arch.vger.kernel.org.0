Return-Path: <linux-arch+bounces-15540-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6B0CD9573
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 13:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 32BB2300CA17
	for <lists+linux-arch@lfdr.de>; Tue, 23 Dec 2025 12:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D30730E0D8;
	Tue, 23 Dec 2025 12:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fiplceAV"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021076.outbound.protection.outlook.com [52.101.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A29C2882CE;
	Tue, 23 Dec 2025 12:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766494006; cv=fail; b=YgvOw5b9yu8oraqDC60Z9dwfpcBPou5i/OW0FpX7wRrvyYoqwkmwzySem974dqFXjuMJglC0sLo2mfHJ/1qt+tF9CWvpANejsNPGm8sEj3BE3qOm9mwV50Hi5s/WzOhkIPUsdoX2swnkgpKYTPVhRdEJktZ4eme70LZrNJbHZ4k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766494006; c=relaxed/simple;
	bh=m+6YTI5vukfqryqYoOBpZ5ZrgmKgaKYRmodxcSgQkcw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fB8cfvn3tUM9mszRw+Kk/V24pKeMt2xvHPkH+/WGJSuuOoQcbKpnUpm301PQd1h2t87r/avw7P+AdcMK5rq71Z+c2+qy4izDaETxLqxpJ/s+bYFEbByiGBxpSa4AWUkoQqiZ9rXt+jN+1RBcbHGEg+1mMZsJeQkdWMg48naWc50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fiplceAV; arc=fail smtp.client-ip=52.101.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eVAMNbf+XRxGvlKPAvCh6FhXgpwzot2StFySSh15MqsWdwBQZjL+fxXnNbn+gZ2n8C0ChIaxDsIyprzuNZDAt3YdN1XN0aVmNRYcbaa0klAK/FEDAuoAQpNaM14N9pwXqyYunDGRMOmIhfbhETzJ5v2yYuIY3purcPkk4hFIVHT1DkXDipsxEOScGGTQnB++hzZKvRYOw8otR/aZ4nYZXH/ehkHJj0R2GJGmvjvSD9F10J20H01kTUS7NLbR8krFNW428pm+4j3dvfYd9AOLOhreegNkFI6BqK6z659CtlJkVb0ZD4iBfjOWPUBKycZSZT8DKRXkakw4oCTjU1s6DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N0VoXR+Olz4qnvsCWCxSTxRYyTONBMzlGYKvu21a4mk=;
 b=j3zuOG5OnaWsH2UPIa98s/Zpl6gohaF/MLm21xUF+TJwVRXY8qFOnY6LcJ+c9dlMZN6Whqvxb+vgWJgEbo7WGuC5/t321828x+Xz6m/HNi/DLHOCviJy4w7ipzXLd7xKfYZDL594diNMkblnE34m/FOwgh8IIgdRkw4EmO4bvOGa1I1vOOiGBSc8omo5DevGz1HLTnnbHgqLOrIU15YnEtV/33SIAXmKQmdRCD0EDZTPQ44EZQz03xrtWYNKBXXCMKLweQCGIzXEIMj6u5w7yKVpMTYah38MRFCHiceTq3s+9INBog9Z3p0EUnKFt1RX+En5glIMVetT2uC4o4+hCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N0VoXR+Olz4qnvsCWCxSTxRYyTONBMzlGYKvu21a4mk=;
 b=fiplceAV6ZMiBv6iBI6RIxOXKPu4IwmtpsZZm/khILPxTIn1FXqEZeYVCU+Tktem+Ioz6XQt6qQ5jlk6y//hgSO1ARkO6m99y4Fo7/j2Gb0JtLI76D9fbIJWlNJhFIQcUEVKSS4aMyxp1xmVoz8dwFZEqghDmLd2a0Ctl5KX+Uw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWXP265MB1862.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:3a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Tue, 23 Dec
 2025 12:46:40 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a825:7b26:a82f:d041]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::a825:7b26:a82f:d041%6]) with mapi id 15.20.9456.008; Tue, 23 Dec 2025
 12:46:40 +0000
Date: Tue, 23 Dec 2025 12:46:39 +0000
From: Gary Guo <gary@garyguo.net>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: boqun.feng@gmail.com, ojeda@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, bjorn3_gh@protonmail.com, dakr@kernel.org,
 lossin@kernel.org, tmgross@umich.edu, acourbot@nvidia.com,
 rust-for-linux@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v2 0/4] rust: Add i8/i16 atomic xchg helpers
Message-ID: <20251223124639.7771082d.gary@garyguo.net>
In-Reply-To: <20251223062140.938325-1-fujita.tomonori@gmail.com>
References: <20251223062140.938325-1-fujita.tomonori@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0029.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::14) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWXP265MB1862:EE_
X-MS-Office365-Filtering-Correlation-Id: e05230b8-aba1-4ea6-a091-08de422151c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6oe6hB30ryShC1I8FhjrenVhdTwyZpivP5zr7SoClhc4HDJxMc0O1KT2+cGh?=
 =?us-ascii?Q?A1idy2QbNlCM/NH4CfuCWxEkuJGQBhBYGwWjaCotLiAk7/OgjFIBK5/Abi9o?=
 =?us-ascii?Q?JN4yDB5/vo2MZtv+i6IqK9mhD4uQOT8Ec7qYKpboyZ+lQbZBdtwR+GpwkF2n?=
 =?us-ascii?Q?DJ7o3YZIZ++FOtPhfQi6r04hbveORFJnuxh4+3YVg6YEMjZTNatCrLgAlGJQ?=
 =?us-ascii?Q?AZxz9f4UfbkhVQDHqkUHidhmNe6amD26xBBFDSbjY4N/8EKMEdEPw+XNRrrx?=
 =?us-ascii?Q?2RlP1fkcCm1SNvTdsMoggaxUMmuZ1UwrJvCnMhH49PVxsJvBIBapmu5LHD2Q?=
 =?us-ascii?Q?3VVpI+CcMAc1TJPibzK8bWe4kL1bUSfgxhodXi4TgMTraZRnw2zFne+NtAmT?=
 =?us-ascii?Q?N3cAkTmIqDzP4L95vuqyNZ4TIDyHQfLrrbGaUvCWODJ4X8bO5KN4ForJuXGA?=
 =?us-ascii?Q?0XpzjlztyumwJBfqdSuZrty98BwBMaeTWDJqMHUSx+9T/NhBVOuy4dNRxI2b?=
 =?us-ascii?Q?stsE+Yy0HIu38GjTMZjDRRM7VMFUiUcFQwTwjCTlIr+ihc8fYBGmZz51k8sq?=
 =?us-ascii?Q?sSEtEOvcNXOsdE68pnb9dHjnbZFJk9DEUXSiJho0vp0nXoqEpi7bW0JtymRg?=
 =?us-ascii?Q?zZXTRz5IU7mxA9tXQxyeIH1bdY1kcOp3wPckD4Ap9FYc1Ng5mj4lWCRAAK0i?=
 =?us-ascii?Q?sdoNyYOkNn8pqFTK7JqdX4IUFzzKXsWH2RMyhdT4qELRkMxA7nKd8bci4YeQ?=
 =?us-ascii?Q?9dIdW4g2cuIVmCupE6vMozeQTjkTrwzNA2UY3tR6605H/517FK2iVNt4B7zV?=
 =?us-ascii?Q?7pFK+Q6janY6sKyfOjHkxUYEbc/Yt+Um4nRkefsBOf/fpBR7JuuJYX4Nwrml?=
 =?us-ascii?Q?hVSkU4YxfnoayXHTC6h6wH2qfo4dBV4BznvNWjiuThOE+OYpoJIsARZBd4Ur?=
 =?us-ascii?Q?SGt+5uxyte3AicRskSMor7PyT7QrL7Y5mgJrvT87E3lZrPgsnwo+byb0J/dk?=
 =?us-ascii?Q?mLfpYKw9zgo8H1z77NSY00lilJcwBDhtJvAdqG055LHjlYqUv4Dx9ttSpXzi?=
 =?us-ascii?Q?aeIbyLd4HIXW3sQrrPvb5+Ec1hjQklMDAXZsJmL1l2mRcMRkwzDoyp+ewQRS?=
 =?us-ascii?Q?2zRnT5FGlLdhLtFohDxWxo5M1Xj+ZqyH0kanlfXxMHy5Pi9b94cSYhiA4VLW?=
 =?us-ascii?Q?bBZu/kHwJA6uHEVyVkpVjxbctj6KOY/inyNQpOK17RjUb+qKRh/kyKfnm4b5?=
 =?us-ascii?Q?HCwksg4mMmX7t9Xs/8F+204QaG5idJ+Wc5uSHqNptvGK9KZZkcyczZozx8eG?=
 =?us-ascii?Q?TGhNxGPF+3gTsi+JmhR7SWB2HN5nCa1xIsY4mPvxKJue5t6H7Bfb8EK9Tphj?=
 =?us-ascii?Q?wyJ0oxks0FxiAPWe/Fa3+zLyRFbfCynLEdWpOiZ9kx7c0cud9akCnDXdqMFi?=
 =?us-ascii?Q?Wkhg9sJBU4u+cFO4w8n1m8bLL5w7SdhGtTACOxVexGgzz8fs+A/3qg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(7416014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Beod1WUdAgPOZadkTRcJwijPtOkw6TH+bWDXoIIn+kdvf1fiEVZMZxY5JKeF?=
 =?us-ascii?Q?68azotUVx9Pn1V845/wvuEGZAb8mQV3s4SBZVpqFCdZ2jEB0DoVl0uDblHB9?=
 =?us-ascii?Q?1z2fc0dHf4s/4lUz/k6l7ZL2BOmmmdzxj6FGq67zKcM2NpCOgCy/bMmKJP/a?=
 =?us-ascii?Q?TQ2S8iSVjxcGmv/sIKK0UByVKm3bCWZevrG6/7zqJExpPUIICGx1T4t1ea2g?=
 =?us-ascii?Q?bs/QR9y1v3MhBj9Nu3Awu9SvLlm8owA3Y2eZZ3uYGMRkkz+aM1CXY0LxBKGv?=
 =?us-ascii?Q?m0g/jHxbUcxnS5ajhxBjnnTXQlLwGWlXTXCiEjNEMC0hg1CGqG2Xd9vOMFba?=
 =?us-ascii?Q?zgLD0n3+yBxKerJETk5hdCw7U3qjgnGvatLz/KslZDFszcMIFAg0+MRVg4v7?=
 =?us-ascii?Q?7QdiRbdEjafqk70rPOsgcCcvj6ctPmGEuNU8A6EsKzHdzJh6EdILgkfDjDcD?=
 =?us-ascii?Q?6poL3+HwDrFpqGGnhvAbqHISjKnr+ziDCZumIYknm5oVCxHghNGCaR56zGkD?=
 =?us-ascii?Q?UOtcrfEvq+BDKTsz+ZuGBYmcxuNsQgqMI5D/GmhnKsiU891xndx5Pvhc8m50?=
 =?us-ascii?Q?4PtcIup++ENNYVUcRJdIOgV53pnonsMYK4kjwxO6xdYlt+HvhegO0DseUKye?=
 =?us-ascii?Q?Qz80asKiJes93dQJINnxfcYuv+BTtPkHlbkTmyXj0+IqbaVM9+1ysTOEPJXL?=
 =?us-ascii?Q?PS9qJeq3As49MlROTJ1YinT4olpu6q6PO7ZlR67BJHzHSQ8g0UzCocHw7Fau?=
 =?us-ascii?Q?2qVlXrARlPg19igAsu2pEO46E751rx9gFdzQFYcF/6hOb5LU8fs3feNI9H4G?=
 =?us-ascii?Q?GQgc11YScClj8mM0VmVkpRPJL/n29Stxt2tKvG/L8H7MgqTrJsoP1CQzmBWt?=
 =?us-ascii?Q?iQYz9LSdNSe+v4xZJF7mCCnTwyTfr71NPqL6Wan5Wsu+FudgSalPKjMUu95u?=
 =?us-ascii?Q?eMMGeBPhLUDVNTU1TnPytbIvPziwXsJSx6YyJB5BAxaYnwsLoZtwjC3DU1Ke?=
 =?us-ascii?Q?Qm0J0+lpBNJQMSjNRP3waGwWapPBiaWHx9JPLGEJAHfGWyZCzxN23Tgud1Rd?=
 =?us-ascii?Q?bLXo4wvXISRMVjexguh1nsUBJQQSiR8uRbxRWF56RsK7RfwD3BQfR8gNPzEf?=
 =?us-ascii?Q?BJ+RJoqu6cZ9oHNfFx5a/I6dQTaqkGMo2nMiu5ThWNV4v+43UTfNhqAENoeE?=
 =?us-ascii?Q?IK+Qgnq9/7SC6R6WKHtA5WGnCD4Y3Kh+yM1LbNf2oVwSmFgIiOhbLL6rt0kr?=
 =?us-ascii?Q?gZWfJrENAj8P998UChtxAnG42Mwbq5noApYcGdfWzSRIyPUeI/rUG2AFWkoc?=
 =?us-ascii?Q?1k5TCKNTZMxMZ5j8RBE8Q6Wn3pgOEiesiZmJovAHczh7LWXd5jlWt2KbWN4Q?=
 =?us-ascii?Q?mGm/lEdUI885wPno4wc/URdb8XvS/b9uAJaoIC/tYT1lnUZYCLstXWR3UVHm?=
 =?us-ascii?Q?tkdnK1KS0sdtkxDm1C6Jd+CJOh+3Etu4Ce145+22cNBxFk+5nc69y9jM6uVd?=
 =?us-ascii?Q?KwWpUR+joZR2n0P+n+18ppYLFBK0mwhTXXZLScIONMwZu1R9dRMaxxKpq9Oq?=
 =?us-ascii?Q?Nd5Me4heifYc4Ch0oF2Ok44TGotCJJ2/ljcJwskFAdyDtva5qD8oiP0xN4MK?=
 =?us-ascii?Q?pI66OlUhHRYf3iMxaCRiA86Q+3h2G2z6Z/cgeKFjH9dSB57JB0cCFPKBthGX?=
 =?us-ascii?Q?NrlHfieFhhmWzHRFNv+eJArz/st4eMFOEHeYFrubtDTby0idb0OdwnOhXehP?=
 =?us-ascii?Q?QLww8bo8MQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e05230b8-aba1-4ea6-a091-08de422151c3
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2025 12:46:40.7286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CqWIhP3UMtrvS/AjPG93ELUK/0X7TGhYqUI3/ywsbcnJQFwa7ED3hWcBjpEG9q89nEpuFIlLMeXb4/F4hoXoPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB1862

On Tue, 23 Dec 2025 15:21:36 +0900
FUJITA Tomonori <fujita.tomonori@gmail.com> wrote:

> This adds atomic xchg helpers with full, acquire, release, and relaxed
> orderings in preparation for i8/i16 atomic xchg support.


Any reason this series is not sent together with the user (i.e.
Rust support) that uses it?

> 
> The architectures supporting Rust, implement atomic xchg families
> using architecture-specific instructions. They work for i8/i16 too so
> the helpers just call them.
> 
> Tested on QEMU (86_64, arm64, riscv, loongarch, and armv7).
> 
> Note the architectures that support Rust handle xchg differently:
> 
> - arm64 and riscv support xchg with all the orderings.
> 
> - x86_64 and loongarch support only full-ordering xchg. They calls the
>   full-ordering xchg for any orderings.

Maybe it's just that I'm reading this differently, but I think this is a
bit confusing, as if there's an optimisation opportunity.

x86 is TSO, so even a relaxed xchg is a full xchg. So in this sense x86
has implemented all orderings.

Looking at loongarch ISA manual it's suggested that apart from load/store,
all other atomic memory instructions are also always full ordering.

The change themselves LGTM, so

Reviewed-by: Gary Guo <gary@garyguo.net>

Best,
Gary

> 
> - arm v7 supports only relaxed-odering xchg. It uses __atomic_op_
>  macros to add barriers properly.


> 
> v2:
> - Add comment about ARCH_SUPPORTS_ATOMIC_RMW dependency
> - Add Alice's Reviewed-by
> v1: https://lore.kernel.org/rust-for-linux/20251217213742.639812-1-fujita.tomonori@gmail.com/
> 
> FUJITA Tomonori (4):
>   rust: helpers: Add i8/i16 atomic xchg helpers
>   rust: helpers: Add i8/i16 atomic xchg_acquire helpers
>   rust: helpers: Add i8/i16 atomic xchg_release helpers
>   rust: helpers: Add i8/i16 atomic xchg_relaxed helpers
> 
>  rust/helpers/atomic_ext.c | 48 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
> 
> 
> base-commit: cae418334e4c402e410d3ee234935da33c7f904b


