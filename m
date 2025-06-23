Return-Path: <linux-arch+bounces-12433-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15BB4AE4CDC
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 20:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3255E3AB725
	for <lists+linux-arch@lfdr.de>; Mon, 23 Jun 2025 18:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85B19E7D0;
	Mon, 23 Jun 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="QG14x1r+"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO0P265CU003.outbound.protection.outlook.com (mail-uksouthazon11022140.outbound.protection.outlook.com [52.101.96.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73E04139D;
	Mon, 23 Jun 2025 18:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.96.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750703430; cv=fail; b=mhJVdWjpS65gmA7YBu8Kx4B6tQGrMXd2+Yd906TtyaPkrYj437xBN7+yEJGOFc/mTbGZZXHeU4GOKRmYEi8xG17oYmFqNx9RjMEshODZfqIvEcO1Cn6GcqzaL+P/08yOgl06YWPHBN3nB2ZyPqA6hhzrDbqMFH0hBxaa98iLBbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750703430; c=relaxed/simple;
	bh=G2c6m6sgHmm87d2HvJpzDbpBehEujeM62JdvKtDrN1E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fvsGIssbkh4o5ai3iTLoI23PHn0lx/Txg3cQqkEIbN4LpFYERhccWK86RwZGfSNjfZPGEcIJrDtRvoMnpc23mwRly4SV+vYnI6GEHBGlS7OMOTaGY1V9JIKt0XpetnfZBp9FwMz9Mvv5kvAe/ryts5sDkyPVWsDHdbHaTaqjTz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=QG14x1r+; arc=fail smtp.client-ip=52.101.96.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mVdO3Kk7NqVtZrHGfNmmobNNvAW3NUsLRpF/UAlfWNuvu5KUTjdElovAkRL4qPjUJbA7lVO9y70lbCFw6AA8vPkcSRxh2njppfprCs7f0fuY5wmXulgEeL2Kb24HbdbUr+eU+sAkegG38CQVBl1iAucCiDQfwD3xnGLEz8lKYKAlhGPD+95FzUJXFdaserm+P3cooeSg8ERVbBX2pBIl4uuYRUE4JODhD4TO+09hlPNZgC2buR8ltwkCUM9ctXLc4kfb9JZm1/AxUSgbwcxAzHROXfooR+N8Ct3kJDGGq3g3Mh89W1MU0ys7IsOMQ6SA5yTmNvfc9xiAjvgLAofNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tmBQ7Db2HNv0Yw4a2LpaptwbD7oYvonJevw7aJatOpA=;
 b=lqRb3CBoh8o3TCsTpvnvwB4Ku0LJmBKlIv5mqiFmqLFTnahqXwiZPnDAKpFxxySAeVi98Q1B3K4mVXyCxV4tan21LdG2vo2JfDGo4zf1IP1GHbVXxU5iOpeABqFyvu425RgP4mSCGq+R9in/nJQKAh746LknY1TQMQG79abLbTf9YGp3DcZnCkUIxRoI5oBBzfdJo3/H0KanA0Z3jFsIlyeMkMEMlFxB1nU1UoYEf4CvlfmGgpB2MbmBE0KBBv0VybLuGsOfWikChWGfrC+Rr5RCkBLS7SEuKxv1OENvh3sAXMm+KLAWZiJGlyUMkO/ScIS5mRiKgCzeuNU+fvKDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tmBQ7Db2HNv0Yw4a2LpaptwbD7oYvonJevw7aJatOpA=;
 b=QG14x1r+ywyw2ERA5XPQq91YqMfheSeVs+H+Nh9VyfqsHqpQ/T9rMYQSiknv0gqLQusvKNaiPswAUO8zjjP4RoZxfBYm120ggm3N4BVG0KV5WFpbZ/E/IoBuKBd7sOJQPC9rSSmsiIvMUFStd5zmpj/Yhm5E62ErIWhycq5UV2M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWLP265MB6033.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cf::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 18:30:24 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 18:30:24 +0000
Date: Mon, 23 Jun 2025 19:30:19 +0100
From: Gary Guo <gary@garyguo.net>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 lkmm@lists.linux.dev, linux-arch@vger.kernel.org, Miguel Ojeda
 <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, =?UTF-8?B?Qmo=?=
 =?UTF-8?B?w7Zybg==?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin
 <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl
 <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich
 <dakr@kernel.org>, Will Deacon <will@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Mark Rutland <mark.rutland@arm.com>, Wedson Almeida
 Filho <wedsonaf@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Lyude
 Paul <lyude@redhat.com>, Ingo Molnar <mingo@kernel.org>, Mitchell Levy
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <20250623193019.6c425467.gary@garyguo.net>
In-Reply-To: <aFjj8AV668pl9jLN@Mac.home>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<20250618164934.19817-5-boqun.feng@gmail.com>
	<20250621123212.66fb016b.gary@garyguo.net>
	<aFjj8AV668pl9jLN@Mac.home>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM5PR0301CA0015.eurprd03.prod.outlook.com
 (2603:10a6:206:14::28) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWLP265MB6033:EE_
X-MS-Office365-Filtering-Correlation-Id: 284c0c4d-8189-4857-45ed-08ddb28404f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AN6Ttgn2Wuw3UwQedjaZWmoMX8MRU3olrI8r98FfUiro69LwUuYYJYmVn1I3?=
 =?us-ascii?Q?mwUmk9x6wbbo/XAW8LAbjGohkasljsjfC5zyaklWJPlU3eqt0D0G08RlkpOK?=
 =?us-ascii?Q?vr4NifnoxS0/a87ld++t7qQdlHhac5RT/4MC0F2AjfxbbM3UWsgfCRFryTZu?=
 =?us-ascii?Q?fsgdZTuFZJjmjaudjxkBzv2sA3qcHyBbRuYTOTyJI3M7+UwRPXeT3BcM0qY7?=
 =?us-ascii?Q?c/huN2Tz/bpK/o9FySThhWjGBgKIhzLHHPGjb7Jl3Vh3eJEVjb17CFdPFmzo?=
 =?us-ascii?Q?uG3xeuHAvp/2LTkPHPa16V6UvtZ7N1SNSJtc4C+9G1s63BLfQ8BA5MfToO2C?=
 =?us-ascii?Q?cZh/2F/2YXDE+lVloA8OcegO/3br7gsgrYXrx0Eif+QR9xVwRKgHW8hDy1ND?=
 =?us-ascii?Q?Ekr68iQcIT96fLIKuvWl+V2Kpyk4QNoHPTBIDulOP8A6pp2/vRjMTKxvxjgG?=
 =?us-ascii?Q?h4kHcUr3CHLGo1nHGODYhT+1Q5K+khKzfeMibyw+FcmFYv5uBhs5cZLa9P8u?=
 =?us-ascii?Q?5D+iQ80/Z3OuDFu3Vrkqtga1GZQWKlNOCd+rZK233Yir1XrI56/QWj5xKn3H?=
 =?us-ascii?Q?nI9LWRVPolDxxlVp9Wpez7708Ld2BTx67Le6LNDfffudDubThBe2Wag1hTYU?=
 =?us-ascii?Q?9stqVM/Dww28Zka8dt5Hhb7O05ZEmMAJ0C+J2lwSTHd96z9QO4awYGD2jkxB?=
 =?us-ascii?Q?94ESLiSUhleoNx4vOc+YNgjmWEpIm+zZhygObxrjtGedTlnRVtVVIpIFprxh?=
 =?us-ascii?Q?HEKR5joVf20hrEqStm7N4x7SbivGylMpxHnTEm8+AY4wobWz++67h0YP8krV?=
 =?us-ascii?Q?ZSfDklICyPDDMep22A3wdFWlnzxlKBTqi2gI2EQS+9BOC9ne3FEAQgskNM1G?=
 =?us-ascii?Q?62euu3r5PED/8gjqRkGdKaXXIxFt0xRRjyahKghGPTE0zEnyo3thZk0U1xcy?=
 =?us-ascii?Q?WU2PUJMn0LlYPATaINTu/Pdjokhva4kkQdnhNhbOrTv5cJmVAlZDUSix9oES?=
 =?us-ascii?Q?Kfv4X/xqcuUFmz3ZhpTt293d9uiOdYNWtA1L+SlbTWjS60EmTFuyZCPZAuaG?=
 =?us-ascii?Q?GoiAyUt6S7Kx3WRts57pdFt2ajr7KwvqFOc6pm/JXPNkM94iQjHLYZTlwooO?=
 =?us-ascii?Q?4ExUgACfSnXCxRLmyNMDEtOlobmsrCbTZGilY0J6XmEZMeNIS0ZNf6ZnHjF+?=
 =?us-ascii?Q?M+uZLbW1OCG3Tg4RCAqWreCB7BlCZiwnrO4WNqbX5uj8/2eEPYexncnpyYiG?=
 =?us-ascii?Q?rVUexleK/FdyWS4wvjU3FrJsicx7GnuCcHfXG/fkgF79Ad3AcP0nWehe4A73?=
 =?us-ascii?Q?bkG2ei1Mtn+QjosEJS7CxA2r6HuAduF8TncAPzW0aVcQEa7Cm/lrdJTIKezm?=
 =?us-ascii?Q?RC/QZC/VJuqOeXNLzL0T/QufFV9QdzLVd9u7mDeVEuP4zbO4p5K7Q6BBOycg?=
 =?us-ascii?Q?Tl7+zvsnlHs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oSIoxpAmxHY4qr6Jt/UbbUVaVK2nX0OkqXv7qbddPcEngbyWMf1mPH/EmhTf?=
 =?us-ascii?Q?hp1DDXhmtAVx0ijwpyOY2TGqJPPEPHNUR0f19VYK9u2KGPAu4lR4/Qgt6msm?=
 =?us-ascii?Q?EvVCVHVcVn5ic4K/stZgI93yc7qZsQ84owXtdHbhkRn0qr6Ol7F1pLTfJVgn?=
 =?us-ascii?Q?6nyANv+b6N9t80LeWeP6TdESAvTXMWQb0chBIOl/U63s216Vsfx7+1AQOYm7?=
 =?us-ascii?Q?LFJhvoZENRd5P5s0YnFnxCu+j1Anc/WOWji4mx+yWvpCT+LdO4flJH4L65Q7?=
 =?us-ascii?Q?Q39EMtbmBxD/uNBL5OHIKcEeS7+OIlGT7yex2rnJ+10UQUbdChQOzhU19/+V?=
 =?us-ascii?Q?Tua/CuyI4tixSuiAHn4y7bvitGk/71aCtRPTaBXOBVS8+7Q1bTW23dWAplh2?=
 =?us-ascii?Q?raeYdV1RzJCXo2Po9dhWW911JVzzVNiv4lR+P+C7azW5MToVPeGHtV9C/XQi?=
 =?us-ascii?Q?fB7OKKO3IlXsURHzoJ/WIcwZAjOPIKbcyKbJ0FRHbHgKPzGevrlcVh576EmB?=
 =?us-ascii?Q?ONxtJwMJlGPGfb7JZZHcofNZsW3fwjHGWMNG+B8fC90C6Hju/exqnmUVumlv?=
 =?us-ascii?Q?PP/ErWrzt2jD1MgFr/z9LnQrKGXT1S30V01vtOaPZJjEK+eFqEg9sH2UTL6P?=
 =?us-ascii?Q?tcC3JtGKRjTpNAPqamhoKLeSXpXc8SUriWvWAUTV5UOXcSCKIVBpaRDhfALa?=
 =?us-ascii?Q?ehR44HkAouF5iKMTeHmKr9l8D6XyZmgLRGy3tWgaXMr+80nDkrk6G0Ch0618?=
 =?us-ascii?Q?Z8LBWWKiU8zbrpTPDgMWPRYihabN4fv6Xa2Eb7tU+jQFSeOrUYMZ5WzX9Qx0?=
 =?us-ascii?Q?nLE8/pwVdFTd24koulVFj1vNYNXu4pX7P+ZWk7EVlJbxoz1TfazFfS7adPae?=
 =?us-ascii?Q?xrlEB0jRgK8psASuhR0963hRTn3iNDRc6yqMIsreb+mpJcTy9RnJQLSqHNlc?=
 =?us-ascii?Q?2QDV1IeI8O6vRKSAne6Q+GjvW1rAjEOn8i0QLD6NdulK0iWRWOjmjF+DfK+x?=
 =?us-ascii?Q?7ikTrBGK3P7d9DUoT2TBEbk6dJGE8WUiL49J+BJOLGV7fwRMCSmyKaa08rUk?=
 =?us-ascii?Q?LZBVO5BceFLewCVIxir49u9bMLq6HTLKx5EOuYVXQ6qNvqzBBTx3TyWiuuXc?=
 =?us-ascii?Q?BZwGJUL502GF5HCWs0pdOq+Tbarei//sqeTs4pd+6oeuHM5wcoqiXh8/pyo0?=
 =?us-ascii?Q?WiBKMaB4pXGxPfj9ldxNN5ljkb4SCBCwuMxgfdKJdiuys9Z36vR4VuMLwKeN?=
 =?us-ascii?Q?ZZsQ6BBTHmNbo3MNH4KAjQfEeEWYxc2FnrsdATuZiDvwPJqlnAx7qiYv2I/u?=
 =?us-ascii?Q?5EcOMBKfYNpJ86NbkJD/8rRgvDehLn13/N5aLPunzVFBJ1vMY0asRZBXhSqE?=
 =?us-ascii?Q?r5oCORpCQaMVfUtT66bsNsOzZNr8DmvUEw5dvuB+MBMejnSJ/LY0n9IUhPi6?=
 =?us-ascii?Q?0rgaJwhcu+caT2NTl1kwaZ/uoWdPKN0bbOUSOFIqGtR6+80Qwpl8uS26aSom?=
 =?us-ascii?Q?APYPSs7e9b6mUZhFaQHSlXlrd8cGRSvpKE9OR4a5WjecOu2RExgODYlPTXVF?=
 =?us-ascii?Q?N6Kcb+YjIMWUzqQq8YDPZa4YjZclE8uPR8HoKqp8hpcCsb4Qqc0RXwF8TDDU?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 284c0c4d-8189-4857-45ed-08ddb28404f8
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 18:30:24.6771
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nPcfTfDmE9Rqrrlx01hMJF6X5PPsG29d13Imh041joroe9/qi4i0MasEUj4yNXCt/9UBrFk5oDvL5o6QS9L4HA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6033

On Sun, 22 Jun 2025 22:19:44 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> On Sat, Jun 21, 2025 at 12:32:12PM +0100, Gary Guo wrote:
> [...]
> > > +#[repr(transparent)]
> > > +pub struct Atomic<T: AllowAtomic>(Opaque<T>);  
> > 
> > This should store `Opaque<T::Repr>` instead.
> >   
> 
> "should" is a strong word ;-) If we still use `into_repr`/`from_repr`
> it's a bit impossible, because Atomic::new() wants to be a const
> function, so it requires const_trait_impl I believe.
> 
> If we require transmutability as a safety requirement for `AllowAtomic`,
> then either `T` or `T::Repr` is fine.
> 
> > The implementation below essentially assumes that this is
> > `Opaque<T::Repr>`:
> > * atomic ops cast this to `*mut T::Repr`
> > * load/store operates on `T::Repr` then converts to `T` with
> >   `T::from_repr`/`T::into_repr`.
> >   
> 
> Note that we only require one direction of strong transmutability, that
> is: for every `T`, it must be able to safe transmute to a `T::Repr`, for
> `T::Repr` -> `T` transmutation, only if it's a result of a `transmute<T,
> T::Repr>()`. This is mostly due to potential support for unit-only enum.  
> E.g. using an atomic variable to represent a finite state.
> 
> > Note tha the transparent new types restriction on `AllowAtomic` is not
> > sufficient for this, as I can define
> >   
> 
> Nice catch! I do agree we should disallow `MyWeirdI32`, and I also agree
> that we should put transmutability as safety requirement for
> `AllowAtomic`. However, I would suggest we still keep
> `into_repr`/`from_repr`, and require the implementation to make them
> provide the same results as transmute(), as a correctness precondition
> (instead of a safety precondition), in other words, you can still write
> a `MyWeirdI32`, and it won't cause safety issues, but it'll be
> incorrect.
> 
> The reason why I think we should keep `into_repr`/`from_repr` but add
> a correctness precondition is that they are easily to implement as safe
> code for basic types, so it'll be better than a transmute() call. Also
> considering `Atomic<*mut T>`, would transmuting between integers and
> pointers act the same as expose_provenance() and
> from_exposed_provenance()?

Okay, this is more problematic than I thought then. For pointers, you
cannot just transmute between from pointers to usize (which is its
Repr):
* Transmuting from pointer to usize discards provenance
* Transmuting from usize to pointer gives invalid provenance

We want neither behaviour, so we must store `usize` directly and
always call into repr functions.

To make things cost I guess you would need an extra trait to indicate
that transmuting is fine.

Best,
Gary

