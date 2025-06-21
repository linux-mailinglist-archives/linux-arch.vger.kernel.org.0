Return-Path: <linux-arch+bounces-12425-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4B65AE28DE
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 13:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53D453BEFF9
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 11:37:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813F41F3BAE;
	Sat, 21 Jun 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="fNXkP/tb"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021088.outbound.protection.outlook.com [52.101.100.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F83D16F0FE;
	Sat, 21 Jun 2025 11:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505887; cv=fail; b=f4OvlTnTUM4PSP12tPYJR/hscaQRDNbSTzqK2XDq93lAWFa4IwJk+iv3VPYkqaXywQjWdGrbJ7cVur4Fzl9R56xFpcVXdGCr++r7o8v1bhYafV6nOn8x/GiHn0YNI5dtC88Jus7Z8Wn4o0bZQuS3r/+0Wuso5gaLVyMlAgotYFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505887; c=relaxed/simple;
	bh=9ZyZjl+bmC8BjNfXVRna4dk2d51d81SrLBU9DfOU9M8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pvUNTU+XiWLgPa6sTzKi2OSwDXr4yudQUGrxFapoUFAUrolTIeenF5C6Vaqz2tRNQ/LsWBRwPpu3CEGm7PjRAkz+Oh3x6BqUAA5JODdE3FBESZ1yzDu6CMJfVHtD70uwRA0LjMPxH4xCQvYzA9i3l+1/hKDIaNCqz41HtFm7PRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=fNXkP/tb; arc=fail smtp.client-ip=52.101.100.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K1gJSXulYHfshM9CMqyUmnLveC4+g55WDnf0pX4cZUb3jyh+J6ZtdEpLjHPnopCmq1QMnkxMpO01moXodAuRZISjon5R+gdmN7JQ7d5M9/L6pFrVm+7G79dem7sgVHequtHGrdlv72daaJgHRmGC3/7xm1XVCaUnXfWeH6U36Jr7FU+jyHyL+MwPkn4a6d+RTeB98GWpfX5yTXIzp46dS0Ntb2VpoU6RaefNZnGRxpS3Sms3/HxsBesyISYDY03S8dqYlLb7j0D73ABIF1FbuiTa97pd2KRf+OL/iudDKkjHmqTKse3vrk1ud0c451X/q/04EAGWi5xvhkGMzIJpWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ApYoTj8fCTV4Kdod3Du13IgbSqC/rrkAukw1+DwBwQ=;
 b=HDEvXdnht5qXeDgYw+1mZA06x0Glpzc9oy1skfc24LfH/Sgdq0qeWI9M49GMguPILTGzmuR9UZZXIHyrFbQG38ZbYxDl7YqVCPc5kTYbhpFyA6ThwXhBhgCzxCSqO0R0SOY096hFbstUcfTrdh3xvsd1pu8ImWxOluzZs0Qzi5GOY0POkrDTrDDT2eoWpk5hIFrpEtjmO3G3i9kgEGv2ZYlwgRipZb++UnjrGst3EpO8BPQXXZVz0tSpjBVtPYEKutHiM65zue3iXRJsPzOYFDV4w+DmEiKhy8iIp+xZGSk847areaN6ROkgOTlA8Qri7uXZuM6RATCgpcqW0BWB8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ApYoTj8fCTV4Kdod3Du13IgbSqC/rrkAukw1+DwBwQ=;
 b=fNXkP/tb5MW2d7RxBbEbul2Oty0vMHGA5SPg5h1OSGxH6wMUeXYyRheLjqkKSNGwySUnuBMw0YmQFQr6T+5FT/ABw/RhUS0xEd+BtkB2VZQY71lbyKP2m+KHotm+H18ct0yTeP6c1gLJzfI7wme5imequq81LTVLrWltdhfIYnc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO3P265MB1978.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:103::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 11:38:02 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.8857.026; Sat, 21 Jun 2025
 11:37:56 +0000
Date: Sat, 21 Jun 2025 12:37:53 +0100
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
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Linus Torvalds
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>
Subject: Re: [PATCH v5 05/10] rust: sync: atomic: Add atomic {cmp,}xchg
 operations
Message-ID: <20250621123753.2009f05b.gary@garyguo.net>
In-Reply-To: <20250618164934.19817-6-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<20250618164934.19817-6-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0104.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::8) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO3P265MB1978:EE_
X-MS-Office365-Filtering-Correlation-Id: 622a9b48-ee6e-4c7a-ff06-08ddb0b810bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TYT9GyGD9La9sMxMfqpXamNs5zMInB2doQm6G/8XBKgWCaTu6btFQr2B9h/r?=
 =?us-ascii?Q?xYyxEsgfhO1e+uVZlJ2ZsHpYxKluizxQ2Cmnh58CgM/RxsmNIb+zuSQaPlSm?=
 =?us-ascii?Q?wB6QOaVAu4I7YEkGwgM1tDt6JTE/OiiULhtGOZlnPhxIMQMaygSs2FhioCj6?=
 =?us-ascii?Q?yNA9/NxBKj109n8ogxgbTRmfA3BDi/mBhiOIAa+HriW+CCVnoDlAzszB38Fk?=
 =?us-ascii?Q?/EJeaeB/rOgDmX89umlwD/TSltQ/BmrhoA35SyR7nPYSPttzESys9qog4Iav?=
 =?us-ascii?Q?83kGFAPxlVfosMm1GIg5RZ9Eaato2Oi/29z3aZHTqZiOwRSo0glfNIA9xSYn?=
 =?us-ascii?Q?SIy5twTgGz1jv5Hsac5kGp7vYxZr5SuUjo9WG3fD8Ehv7kZa5/yZtYd1VBZf?=
 =?us-ascii?Q?ib1t4gjH1FVUsnQE+OBCFqhu6oHSV+yLYTDAQF2YcW4j+XG1ObQyDIC9gVLi?=
 =?us-ascii?Q?yuGxXB2qUi6kIoYG8a1px3mTBRQkFFfeEIucWnEOC0c0vl56q7/ITyjSLgtP?=
 =?us-ascii?Q?d/FJAFf+EPMF8Ze9A8n7LpW+WCpcpYU+2kVHYhzi5243tVnSFyb9uYBqWool?=
 =?us-ascii?Q?BFpJP3KnsaUHh81cmN2k6rwUpgBhiNAA4UbNe5Q5j4qni72PHTuSajNZRCYz?=
 =?us-ascii?Q?aPBVXYcPX+TWo6HygCC5ZyFo+DCJPew+oq4bUOO+OKBOe3U+TLgTaBzaZiUG?=
 =?us-ascii?Q?YvYIgTOoQZ0jjy8bvofMDwS8OdOmtdXMUEUtadFi1BpLtrkbHH6yo9UwHvpm?=
 =?us-ascii?Q?ub53MfAlAnCAmELO2V89JyFY46ydtm+Fof0NZPCgFZo1qR4xj1lCFrQasUyz?=
 =?us-ascii?Q?In1/Ueo10NEh2O/CVR1uwKBDHetCd8cA7Wsu6R/cviba1c2gODNMlOJwj8jg?=
 =?us-ascii?Q?1eiaZO+XoGrxT9IfM3RB8tq5PquH2Y4J43xGPOxSYr5m1hpv43jQNoPUKRR1?=
 =?us-ascii?Q?m7a8OJ7PGXhvftJnn1BvJ1qkHAfKaoZnaWCPgU57SFyp/RHbDkdfhdVYQTjK?=
 =?us-ascii?Q?J02aHgvO/UQx5e2gzrPmnucIkp08wftc9++f8R7PxsLhq9ufQB6ymOy09QoR?=
 =?us-ascii?Q?WIdZ+ciTMy/XwUdx5V/QYzx3OX95bB75c31R/egKUxtPulbbc+WiFS4Pyu8a?=
 =?us-ascii?Q?cPdnGBAa4LnITufBfxw9LzvKyBmdFCjXmhvb7mBUwvZ17gkOkINzCtfTjjvW?=
 =?us-ascii?Q?vq6AYCrDTXVVAaVI9cTs0vsLjxvRWm/zeJSjEfzBcRKMqbJRUBSNHJBfPww7?=
 =?us-ascii?Q?gxs+Tqwo5srFAJbp38bnh2mp+w9lzOsirO5LlvmlcWYQvXsh3pkcYf2H3/wQ?=
 =?us-ascii?Q?SnFtz89HGZ2FdWYiXQvnX2vrRgXBe5eEXNy4sAEqT6ssmWDwWzxjxBsgMR8o?=
 =?us-ascii?Q?Jk6meQs8aV2ocelnkFfqWDJED07cnHNP9qp636CVUbvPXIX7HjqFxUJ4hIJ0?=
 =?us-ascii?Q?BqI10YVM488=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EgIOGWVVDTdWMOSv6yhbeWrMJiSmrzxqcsE/QHNfi5aLfa7q/t9p5eeGpxJe?=
 =?us-ascii?Q?RC4dv2U0IDmmTpyDFaIL1x1sr3lQ3rnO8Rtf0Ioe8LN2TKiJyFV+ww63+3Xi?=
 =?us-ascii?Q?5mJN6TwwF+X5jghFXm1q3v0fiwoGnpEUP23XtW7zAn3WK4RdtUq6N6mYBn/w?=
 =?us-ascii?Q?c6ek4PxyvIZ/UXEsjeP/CDm83Wc24DGQPsSCcimWmHZbKGY3FqHSWoPBRE1i?=
 =?us-ascii?Q?zNX29lTGFTwb2/cHNzgi9BxqcEb5u+Be7bFQBBUz0f5RSwUdlfqYuprPPjv5?=
 =?us-ascii?Q?1jc9P7YFnImDjSUBl3DaO3mKYCKolA80hyiWomxoCE7Hterga7oFJvUdirBK?=
 =?us-ascii?Q?mLMllUUZqqQDOlvstlilsSMKzFXX+T9m7ZZWkS1mn6rGxetlzRjXxHYvHfaL?=
 =?us-ascii?Q?YW+RIWS2BF6PfxvyXkMRCvhPPPdN1XwCtJyLRroTFt0m6XWpyYYcQ4lfb8Xu?=
 =?us-ascii?Q?1TTu4jMmupmG1SMxGaxoX44lXO843RjpUa8cXuqEbX8LuIET7uH8O375uNMF?=
 =?us-ascii?Q?dK+pjJP6VhJGk+CnU/sntfmWVIdFV3gyk1pwVh3fY2zyzTTla/FUbADqjCEw?=
 =?us-ascii?Q?gLsrGT35vYODEgUw+mhr9J5JKDAaZTI63VmyJ62ILfpp43PrHOwAVYniEifj?=
 =?us-ascii?Q?FP+Xtp2ZiLTRgKLEIOwPLzWR7Q7JMnqQUE4QrqSKDk8UcqAPGSxYw2vW6lLv?=
 =?us-ascii?Q?vMICWfsovtgZ2TWMIttp5LQ4xsLWp5jjA1+coC8QsiMt3I4suFCLTSPWU+WK?=
 =?us-ascii?Q?43eFFKI/nJ+Oe99xmHtrMkBkCwkEX512jNCZuBa0RHDaybg3GTWyl5rgwzRe?=
 =?us-ascii?Q?/hVKXUVgN2tDMEpd05lm0od2Xz7y0Nwc2Hc/x6ODWeO1Cxkrbz2Vkon9LV6j?=
 =?us-ascii?Q?1+qSwFuoSRXkkQPdQHL8VFLbaPcTxeNSUv+r3TcwVunHKfGR6guUruYcPV6N?=
 =?us-ascii?Q?VpsbuxmUFo/2CQh7dlQX+KhQWqgh7tZlo5Tux/zZCjdcfHKJVnap7PO9IUNk?=
 =?us-ascii?Q?1bIqZW+bH6K3OzEOOX4gJXMFQU+mdI0QBDHK1talzElUW9EIm50Y1exGl2sl?=
 =?us-ascii?Q?RXXQzUgfWpDlrs70sraZDZHUjfMri2cR+mF5e9Pg4tprEaF569Y6YWKkBg56?=
 =?us-ascii?Q?PFUa98NS+ffwsCfUSpFPiR42pcjjZtKSOym48OqWEleh/ykTkBcSIHoQrhQZ?=
 =?us-ascii?Q?lTvHmXxl2g7kzKVFzgFTEHru1ZzGFD3IoQ9RGf2n6y3NP+eregGRhtZR+CaN?=
 =?us-ascii?Q?OLQPE9Vl+ft2WsP6Xmb1/d0jTglXyqevG2XehNZofGsZJPPtQ65c5D0QZBUk?=
 =?us-ascii?Q?+HYOeyEW47cr3EUU68bQrfcOdJR+Tejmi8ydcg9qMRA501gH5+uFsXoiu0XV?=
 =?us-ascii?Q?SzlND1h9auheDN4d2jcm5JcambA3CkCMqnyQty83xKeNRBYP8yHsP9lQRpvB?=
 =?us-ascii?Q?3MVu98zkvTpSfzWNwT4OxVBuVVhlw381WBU3nOWFL1iygcCDaULP+yJD281g?=
 =?us-ascii?Q?BBGY3xYGRMFsbqn40VPH6xZRSfc7/x7vE4L6QKvFT04gytPEQY/iRCGW40eN?=
 =?us-ascii?Q?x75FKWIi+aSsBDa13VMnbk/pMkBqBTq7Njn9l8cZ1AFtIOfSCjL0gb+beaFG?=
 =?us-ascii?Q?iA=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 622a9b48-ee6e-4c7a-ff06-08ddb0b810bd
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 11:37:55.9443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6I3Ur+hMdHqndBR9JGL3PDKvx8bNdf6iO9S0HBodZagvdIeTWlEJpMNMn5u6iFGpm8NTDjSmvoCHnkkeFWZZ0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO3P265MB1978

On Wed, 18 Jun 2025 09:49:29 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> xchg() and cmpxchg() are basic operations on atomic. Provide these based
> on C APIs.
> 
> Note that cmpxchg() use the similar function signature as
> compare_exchange() in Rust std: returning a `Result`, `Ok(old)` means
> the operation succeeds and `Err(old)` means the operation fails.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic/generic.rs | 154 +++++++++++++++++++++++++++++
>  1 file changed, 154 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> index 73c26f9cf6b8..bcdbeea45dd8 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -256,3 +256,157 @@ pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
>          };
>      }
>  }
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasXchgOps,
> +{
> +    /// Atomic exchange.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Acquire, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.xchg(52, Acquire));
> +    /// assert_eq!(52, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias("atomic_xchg", "atomic64_xchg"))]
> +    #[inline(always)]
> +    pub fn xchg<Ordering: All>(&self, v: T, _: Ordering) -> T {
> +        let v = T::into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_xchg*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let ret = unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_xchg(a, v),
> +                OrderingType::Acquire => T::Repr::atomic_xchg_acquire(a, v),
> +                OrderingType::Release => T::Repr::atomic_xchg_release(a, v),
> +                OrderingType::Relaxed => T::Repr::atomic_xchg_relaxed(a, v),
> +            }
> +        };
> +
> +        T::from_repr(ret)
> +    }
> +
> +    /// Atomic compare and exchange.
> +    ///
> +    /// Compare: The comparison is done via the byte level comparison between the atomic variables
> +    /// with the `old` value.
> +    ///
> +    /// Ordering: When succeeds, provides the corresponding ordering as the `Ordering` type
> +    /// parameter indicates, and a failed one doesn't provide any ordering, the read part of a
> +    /// failed cmpxchg should be treated as a relaxed read.
> +    ///
> +    /// Returns `Ok(value)` if cmpxchg succeeds, and `value` is guaranteed to be equal to `old`,
> +    /// otherwise returns `Err(value)`, and `value` is the value of the atomic variable when
> +    /// cmpxchg was happening.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Full, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// // Checks whether cmpxchg succeeded.
> +    /// let success = x.cmpxchg(52, 64, Relaxed).is_ok();
> +    /// # assert!(!success);
> +    ///
> +    /// // Checks whether cmpxchg failed.
> +    /// let failure = x.cmpxchg(52, 64, Relaxed).is_err();
> +    /// # assert!(failure);
> +    ///
> +    /// // Uses the old value if failed, probably re-try cmpxchg.
> +    /// match x.cmpxchg(52, 64, Relaxed) {
> +    ///     Ok(_) => { },
> +    ///     Err(old) => {
> +    ///         // do something with `old`.
> +    ///         # assert_eq!(old, 42);
> +    ///     }
> +    /// }
> +    ///
> +    /// // Uses the latest value regardlessly, same as atomic_cmpxchg() in C.
> +    /// let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
> +    /// # assert_eq!(42, latest);
> +    /// assert_eq!(64, x.load(Relaxed));
> +    /// ```
> +    #[doc(alias(
> +        "atomic_cmpxchg",
> +        "atomic64_cmpxchg",
> +        "atomic_try_cmpxchg",
> +        "atomic64_try_cmpxchg"
> +    ))]
> +    #[inline(always)]
> +    pub fn cmpxchg<Ordering: All>(&self, mut old: T, new: T, o: Ordering) -> Result<T, T> {
> +        // Note on code generation:
> +        //
> +        // try_cmpxchg() is used to implement cmpxchg(), and if the helper functions are inlined,
> +        // the compiler is able to figure out that branch is not needed if the users don't care
> +        // about whether the operation succeeds or not. One exception is on x86, due to commit
> +        // 44fe84459faf ("locking/atomic: Fix atomic_try_cmpxchg() semantics"), the
> +        // atomic_try_cmpxchg() on x86 has a branch even if the caller doesn't care about the
> +        // success of cmpxchg and only wants to use the old value. For example, for code like:
> +        //
> +        //     let latest = x.cmpxchg(42, 64, Full).unwrap_or_else(|old| old);
> +        //
> +        // It will still generate code:
> +        //
> +        //     movl    $0x40, %ecx
> +        //     movl    $0x34, %eax
> +        //     lock
> +        //     cmpxchgl        %ecx, 0x4(%rsp)
> +        //     jne     1f
> +        //     2:
> +        //     ...
> +        //     1:  movl    %eax, %ecx
> +        //     jmp 2b
> +        //
> +        // This might be "fixed" by introducing a try_cmpxchg_exclusive() that knows the "*old"
> +        // location in the C function is always safe to write.
> +        if self.try_cmpxchg(&mut old, new, o) {
> +            Ok(old)
> +        } else {
> +            Err(old)
> +        }
> +    }
> +
> +    /// Atomic compare and exchange and returns whether the operation succeeds.
> +    ///
> +    /// "Compare" and "Ordering" part are the same as [`Atomic::cmpxchg()`].
> +    ///
> +    /// Returns `true` means the cmpxchg succeeds otherwise returns `false` with `old` updated to
> +    /// the value of the atomic variable when cmpxchg was happening.
> +    #[inline(always)]
> +    fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
> +        let old = (old as *mut T).cast::<T::Repr>();
> +        let new = T::into_repr(new);
> +        let a = self.0.get().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_try_cmpchg*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllowAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        //   - `old` is a valid pointer to write because it comes from a mutable reference.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            match Ordering::TYPE {
> +                OrderingType::Full => T::Repr::atomic_try_cmpxchg(a, old, new),
> +                OrderingType::Acquire => T::Repr::atomic_try_cmpxchg_acquire(a, old, new),
> +                OrderingType::Release => T::Repr::atomic_try_cmpxchg_release(a, old, new),
> +                OrderingType::Relaxed => T::Repr::atomic_try_cmpxchg_relaxed(a, old, new),
> +            }
> +        }

Again this function is only using `T::into_repr`, bypassing
`T::from_repr` and just use pointer casting.

BTW, any reason that this is a separate function, and it couldn't just
be in `cmpxchg` function?


> +    }
> +}


