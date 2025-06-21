Return-Path: <linux-arch+bounces-12424-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B306EAE28CE
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 13:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F867A9934
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5892F195B1A;
	Sat, 21 Jun 2025 11:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="LgBOArfE"
X-Original-To: linux-arch@vger.kernel.org
Received: from LO2P265CU024.outbound.protection.outlook.com (mail-uksouthazon11021087.outbound.protection.outlook.com [52.101.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060001F3FF8;
	Sat, 21 Jun 2025 11:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505540; cv=fail; b=phKIfrhQhKxtIgSsdCJloQUcAtV5ZwSMlPYRIa92RwJxjVnXBxJeM6jPRdU64Ctp6Pe9uqtU7rODoIvYknbtWzJ69rZ9cuoC7K2TudXo8FXVWDNkxDMulgLZQHhvIi713L4Na+SyK6HOGER0XLJDAntUaEGftY215MpLfV+ghEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505540; c=relaxed/simple;
	bh=hVhSPLLn09Ri9o60nJRlhodUPfwlxpSefcY+xLyMVNg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ugPKjKiF18NQoUHQe7LJAvQ43U367KWm1Yix0NCotwoXwmS3TmldVIuh16AkGYtxVoXG8Bin7EmixeGU8lL8gPZ97f9Xd4wDeaFSxTkuQN7w4d9MdZR9XchVSVsIjkO6EXT36lHtCyO8dr9+1FuBr8CCsPS4q0OUKvEx5fSUOXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=LgBOArfE; arc=fail smtp.client-ip=52.101.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z+uipt8w84NU3/do14Qj4QCbgkh6W0bxyPSgFxax4tBbjEIchuWZBOqU8l251WcBHiHPaMG/V5psp2vvGe171oPcVLpZCVWsSUKcPNlVNdWcYNZKrpPfgNQOpoP1q8CZtrTEsZJ6xMtzxGeP5w40V8vtpg0jANKviZGuCiKDd84Oiwdu8iDQfbM0VH2ez1nluQAIAVOMhOgpE0pSm7NJY/IZdyK3M0jIrTrBNzyipgNtPJITSuEw62OgTKETJ20JoO9vjOOu8hM9EE8sKuStOf1aZtLEkAk02nIzjThplwmKWE2Fyh8Hurd8a2iPdmEHHbaKCvKur9Kt6TWgFXkh1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xde3BdyQDjZAApM2il2yjFUBtbWnkhuFZ+agw8C02Ko=;
 b=gVXIF9k0VX2Khx3LoTprQ+UpN2uYIZQyxp1uHtyyV6w2ENM8zy9hS+m6lMiKusiRxYNddvuLzS20lrBewv+vBTuATmwiJGP5kiI3L0lzNc7/J80yDh6ax5Q0aWsD4MSpb+0xE3Y7aRGXVZIv9ZPfDCNbzNSOZG2aDkN/AbvIJ8y7Uf4Y69Kh3/XC4Bs1OmIRr2/HXaMXBLfRi20S+ziMwBGygqzy1X0mE1bsoqLqfpmsU1iEmuOGphlXCdSE0BLw/5iLGrBcku9w/hRfPixqOsKTihEX2bkt4wqErZWioCL+EcFYlrPeSkPkcIjUm6wv2FEwpW3mfQ2qAsZ4naRjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xde3BdyQDjZAApM2il2yjFUBtbWnkhuFZ+agw8C02Ko=;
 b=LgBOArfEop6ggGMmriP+XlrXZMieOlwSuAPv1yxgmn4KOx5kr1nd8/FA45BLWG0NIrnVorLqz85cuK9GQEOtwlVvb44Nm9q0HNw3Nf7RzcPRHgUsiWk0XQfIwHG/ggLERimtGgD+XihL4IFxCtPJz7boCQYFNXWDufocV+Y0IfI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by LO9P265MB7758.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3b9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Sat, 21 Jun
 2025 11:32:14 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.8857.026; Sat, 21 Jun 2025
 11:32:14 +0000
Date: Sat, 21 Jun 2025 12:32:12 +0100
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
Subject: Re: [PATCH v5 04/10] rust: sync: atomic: Add generic atomics
Message-ID: <20250621123212.66fb016b.gary@garyguo.net>
In-Reply-To: <20250618164934.19817-5-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<20250618164934.19817-5-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0364.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::9) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|LO9P265MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: 42d919a9-dca4-40dc-5237-08ddb0b74552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?s2bWIkHLScJc8BGmoDMh3q+2i18u3en+VSSVxy9IFir1mXURvFhaq9cKwvbt?=
 =?us-ascii?Q?598IDWUXqsUPSuQ3uZLCHo49tu2NV/81vHlSB4YuAVj9MhUGovhue5Jun9Wr?=
 =?us-ascii?Q?EKFvzUvoyY6D0xAtENERX6LFxTnv2v1uDoHbl+v6BcZiMiI45AWVFH4Ac90n?=
 =?us-ascii?Q?J6mKxyBBaNzjgnfpaXydtfHpuPQTu7b6AmWe6B0VrC63sT+senKUdKCOhHSJ?=
 =?us-ascii?Q?yudT/qcsbQCwWFww4eGOR3hS+ikHM6pLT3x4FeOoSSwz5sNivltmoe/rK+hh?=
 =?us-ascii?Q?PQdz612wPakxegm60mtDjrj/DhCzoT7fyz/s4QS4KcnT/LX2GREYFbw4TDtf?=
 =?us-ascii?Q?1TJZUgov+7FvpJ2wtPxnifEXrMPDN4VPNbJNomB6mRRuzODWPLUBnlqqpvYO?=
 =?us-ascii?Q?Y4SZcJGt+kH0E0OpSH/OJGIJwvN2J5m386AaLAZTANwJdeoQI+PvfHqQ5sgW?=
 =?us-ascii?Q?GZ+FD+anG0IvyavJxoCizH9jgAWRVsdI/WnGs1qVV2f0s7UZ8JofUqqyR+xK?=
 =?us-ascii?Q?8n4bpGoaUNv7+9RypW3cW06IIZ04Yw5oV2CrWzSn5xT934R74o1utY9XzaEm?=
 =?us-ascii?Q?NPxYD3yuReW6RH7oS3OC1s+reCnBPj9mNX9N/p/2k7KupqaUyUp8xOgekBYv?=
 =?us-ascii?Q?utX9/pxs6bdGtIbCzHNX9QylQD4InuaEsY95j2C6YAB4umGg2V24V+rXqQNm?=
 =?us-ascii?Q?ehQqdQ6uCd7KHMHdafvyX2HfeqSEvllJEDbTdU7jmbjQ7XHKIfygxDojXLmz?=
 =?us-ascii?Q?/LlBHVkNDqh4l7ycrXmvj0rEAiSS2Oh2Dmb3Ckbc3o6J1BRY80PL+idtrcef?=
 =?us-ascii?Q?CEnBzDiGG+BceTbm45+yx1maPy6NMjB+jIGV/7U8qWn5S3MOAT6RQFv58PYu?=
 =?us-ascii?Q?tzF6ab5GDDX/p8W/98nVRnZwU+P6CfbuvkMT0PtVZPTAvWiAXWsCcXxBNFGV?=
 =?us-ascii?Q?07tJ90aVlZlc2xDR4zDHRCM6LnVTiBa5KCUqj4FE+oO+ShcNZ/Ud2nC22dJI?=
 =?us-ascii?Q?0h+4Tk/KVq6R9QueFH3GGMbPyt0zOP0Xc4/L7UGtRsep2nxL9z6VjFW2ElvR?=
 =?us-ascii?Q?7wO9w6XsI+vwI2rRAmKnOCiI5MSgMC5v82B9GKus/CVTwRJVRfxi6aVwInVD?=
 =?us-ascii?Q?P+D5ZbUtYruVDiX0vabzJsCaHNIe4UpwYKP7XbB0SzkJsK2g+VgYAB56u1Rp?=
 =?us-ascii?Q?4R4tyL9rfLJ0KKUIzV0Q7K2vkLDZnbzKSSuA5uTLmVFXzjtoHmfhj9/T6Yum?=
 =?us-ascii?Q?Nhb0gd7/Ca4WLVKmK1bkFHwfWGLQRpWbMMHSOWPMs9UIyG+lCC/iGjDA24+R?=
 =?us-ascii?Q?+UZlxM7U9MT9K4OxAHuBRLOHPYxkuzZ3gVJ+/5vGI3qmEOzTEQ8DxtxXFNM+?=
 =?us-ascii?Q?S5/AezLs3cU0AejDnE+okFSko/TwgB2nFQ2qpD/hg3/Zfq6dqBn9n9gpoNZD?=
 =?us-ascii?Q?b7y+pRbqSfk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VhQcr5qLt27qu0aepvPs4y/iTk2FxCM/C5OQnpQwpqm9KWxin/TyOBrqa4NL?=
 =?us-ascii?Q?vQ8FLqacBHLtr6zO2bAUWhk3vFuhyKtasgRy+OQucn07aDBU/Q1gIDV56HEo?=
 =?us-ascii?Q?iC58D3I9m6bd0h8uVrILq/vEq7V9zHAt+4BO9u6ZaKkYajsKjC/62a8OpNoM?=
 =?us-ascii?Q?wtHc3jv/jIkdTv06EHiw++jgjXvB8XU9h0fH0cyQRROjiUw1sCMKj0FGk24h?=
 =?us-ascii?Q?Rq8p2hIV7cUfiRwTCME0byJqNy514KvCrJJGHEMDUTFUWJIXjO+H1LF1Q+kj?=
 =?us-ascii?Q?/UTEddW4RpGjAtNcHTYPL4+8BzvU1TP+pJGNvAg/cpc+hm/RWIH8hXa1MwqV?=
 =?us-ascii?Q?zss71NPYGo5GfEY7t2wNKl2EUuQ2iBmZPDlcQeRGmPmTlSPTz0X53VtiOcG8?=
 =?us-ascii?Q?aVRG+VUN6MzWw2YRDqZYVzCd/ctj0Nz3iiunPtrfAziCfDghp9Gh+Ng/YX2O?=
 =?us-ascii?Q?wPrxjSwGcjgppottIIMSyX+iLbiHUb6ILEtuQktvKaAHPIYuWEgLZ4DcpN5s?=
 =?us-ascii?Q?I6TyUToJ74ztGbnAFWUPwWsz5tYJOJF0XNvOFhBDPxWEsiGOh0aT8Cvcwl0J?=
 =?us-ascii?Q?/a1+16/PQFB68hWBt3yo0XFjJolbDmwOEPkYSJ/AtzLXHaCR66/V6Rd5BsoC?=
 =?us-ascii?Q?9RTj8Q8dBsZggelrU+hMHQor+rZGZ2fw2gCoeZ7J8dzBJtwAjOts4QLL5Zgl?=
 =?us-ascii?Q?uk/LoW+0s9z3vKk/ex/B7b45W3zmqyrvMhtbYCte9BnePHAWZa/BHywcka6H?=
 =?us-ascii?Q?PtDyvoMzX1hx0wO4k/O0CSa/0HbQ8PkHGam8NPefdax9iSIbMCfk4nls25k0?=
 =?us-ascii?Q?lXSDuCX8k1CdHobP6xRYaywWV+M3P2CaKcgKoDSn2g09GFptkkWFQr4udCqZ?=
 =?us-ascii?Q?BtP1zMsaGlxx7xj9BvVslq1HqC8QPmEJz/QDZIyeIAKphPrM9VqwDPnvuXPF?=
 =?us-ascii?Q?CgRwU410VcoYd8dldhH+zU2A2wPIQnHfa2aVyV3orvNCr3MMLs+VRmQHzCi8?=
 =?us-ascii?Q?dPGjv6XzsVZwAhqhksmoMrmWElR4jGs0TV2QJAN2Qx+rwTDh6KPhQeNs4LC2?=
 =?us-ascii?Q?yHtEy/WWm15g3+dC0nmWhjDFSvnQXSOroslG0Z9iOi67r4OQIOiEhdqg7hAM?=
 =?us-ascii?Q?P+9V6aD6vwUHZRzVf9/zq84VTEeaxZJX3wP7kUNYWPhZpnUX6ZaBtBM5Y6F+?=
 =?us-ascii?Q?Oyo+KkIjPYyzj3Xtity2TqnWSV6ZKy1fDu1duti7C10PeJ4qQnn07XHlKhSg?=
 =?us-ascii?Q?/K9KydSzpJvTECKAuWRwCjF0ued8yB5BPW4lt4xEeEx+3JWAbaX3Om3gHYgO?=
 =?us-ascii?Q?2HbYQdrAN4sqUh8VSbCTSyLp5hKyywy2nz246vxySXIdoObBOAsyVCxIBYZ8?=
 =?us-ascii?Q?czTMD3JoExmwIbaxe19OgUz2r+yzpMWsnhSbFgCthcf2R5vxHeqwVbXaP0LH?=
 =?us-ascii?Q?ecsenFpGRnxlAJPxAFue45gzOSH6I+Psld0eEW1IzhyNTfbyGmvaNp//mXq3?=
 =?us-ascii?Q?h0Td6wnJcUQGGRch8DUNACeRKx8sY/Y3iCU5qdIlI9sqypgyQOmjdgb+Ydzl?=
 =?us-ascii?Q?y37YfbVTV8a9apBt6uaRWPwMBnazRQ3DVte7sMqXJEguVGrbR1M8fgpbGMws?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 42d919a9-dca4-40dc-5237-08ddb0b74552
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 11:32:14.6673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BcFg1zynx8KENIO1gDTksb+fPeK7LhbmnXD7j7vaGxVxVhOg+Fs3YAQWP2oykiIFR8MNM3tTUj77KVp2eaxNLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7758

On Wed, 18 Jun 2025 09:49:28 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> To provide using LKMM atomics for Rust code, a generic `Atomic<T>` is
> added, currently `T` needs to be Send + Copy because these are the
> straightforward usages and all basic types support this. The trait
> `AllowAtomic` should be only implemented inside atomic mod until the
> generic atomic framework is mature enough (unless the implementer is a
> `#[repr(transparent)]` new type).
> 
> `AtomicImpl` types are automatically `AllowAtomic`, and so far only
> basic operations load() and store() are introduced.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs         |   2 +
>  rust/kernel/sync/atomic/generic.rs | 258 +++++++++++++++++++++++++++++
>  2 files changed, 260 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/generic.rs
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 9fe5d81fc2a9..a01e44eec380 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -16,7 +16,9 @@
>  //!
>  //! [`LKMM`]: srctree/tools/memory-mode/
>  
> +pub mod generic;
>  pub mod ops;
>  pub mod ordering;
>  
> +pub use generic::Atomic;
>  pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> new file mode 100644
> index 000000000000..73c26f9cf6b8
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -0,0 +1,258 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Generic atomic primitives.
> +
> +use super::ops::*;
> +use super::ordering::*;
> +use crate::types::Opaque;
> +
> +/// A generic atomic variable.
> +///
> +/// `T` must impl [`AllowAtomic`], that is, an [`AtomicImpl`] has to be chosen.
> +///
> +/// # Invariants
> +///
> +/// Doing an atomic operation while holding a reference of [`Self`] won't cause a data race, this
> +/// is guaranteed by the safety requirement of [`Self::from_ptr`] and the extra safety requirement
> +/// of the usage on pointers returned by [`Self::as_ptr`].
> +#[repr(transparent)]
> +pub struct Atomic<T: AllowAtomic>(Opaque<T>);

This should store `Opaque<T::Repr>` instead.

The implementation below essentially assumes that this is
`Opaque<T::Repr>`:
* atomic ops cast this to `*mut T::Repr`
* load/store operates on `T::Repr` then converts to `T` with
  `T::from_repr`/`T::into_repr`.

Note tha the transparent new types restriction on `AllowAtomic` is not
sufficient for this, as I can define

#[repr(transparent)]
struct MyWeirdI32(pub i32);

impl AllowAtomic for MyWeirdI32 {
    type Repr = i32;

    fn into_repr(self) -> Self::Repr {
        !self
    }

    fn from_repr(repr: Self::Repr) -> Self {
        !self
    }
}

Then `Atomic<MyWeirdI32>::new(MyWeirdI32(0)).load(Relaxed)` will give me
`MyWeirdI32(-1)`.

Alternatively, we should remove `into_repr`/`from_repr` and always cast
instead. In such case, `AllowAtomic` needs to have the transmutability
as a safety precondition.

> +
> +// SAFETY: `Atomic<T>` is safe to share among execution contexts because all accesses are atomic.
> +unsafe impl<T: AllowAtomic> Sync for Atomic<T> {}
> +
> +/// Atomics that support basic atomic operations.
> +///
> +/// TODO: Currently the [`AllowAtomic`] types are restricted within basic integer types (and their
> +/// transparent new types). In the future, we could extend the scope to more data types when there
> +/// is a clear and meaningful usage, but for now, [`AllowAtomic`] should only be implemented inside
> +/// atomic mod for the restricted types mentioned above.
> +///
> +/// # Safety
> +///
> +/// [`Self`] must have the same size and alignment as [`Self::Repr`].
> +pub unsafe trait AllowAtomic: Sized + Send + Copy {
> +    /// The backing atomic implementation type.
> +    type Repr: AtomicImpl;
> +
> +    /// Converts into a [`Self::Repr`].
> +    fn into_repr(self) -> Self::Repr;
> +
> +    /// Converts from a [`Self::Repr`].
> +    fn from_repr(repr: Self::Repr) -> Self;
> +}
> +
> +// An `AtomicImpl` is automatically an `AllowAtomic`.
> +//
> +// SAFETY: `T::Repr` is `Self` (i.e. `T`), so they have the same size and alignment.
> +unsafe impl<T: AtomicImpl> AllowAtomic for T {
> +    type Repr = Self;
> +
> +    fn into_repr(self) -> Self::Repr {
> +        self
> +    }
> +
> +    fn from_repr(repr: Self::Repr) -> Self {
> +        repr
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T> {
> +    /// Creates a new atomic.
> +    pub const fn new(v: T) -> Self {
> +        Self(Opaque::new(v))
> +    }
> +
> +    /// Creates a reference to [`Self`] from a pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// - `ptr` has to be a valid pointer.
> +    /// - `ptr` has to be valid for both reads and writes for the whole lifetime `'a`.
> +    /// - For the whole lifetime of '`a`, other accesses to the object cannot cause data races
> +    ///   (defined by [`LKMM`]) against atomic operations on the returned reference.
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    ///
> +    /// # Examples
> +    ///
> +    /// Using [`Atomic::from_ptr()`] combined with [`Atomic::load()`] or [`Atomic::store()`] can
> +    /// achieve the same functionality as `READ_ONCE()`/`smp_load_acquire()` or
> +    /// `WRITE_ONCE()`/`smp_store_release()` in C side:
> +    ///
> +    /// ```rust
> +    /// # use kernel::types::Opaque;
> +    /// use kernel::sync::atomic::{Atomic, Relaxed, Release};
> +    ///
> +    /// // Assume there is a C struct `Foo`.
> +    /// mod cbindings {
> +    ///     #[repr(C)]
> +    ///     pub(crate) struct foo { pub(crate) a: i32, pub(crate) b: i32 }
> +    /// }
> +    ///
> +    /// let tmp = Opaque::new(cbindings::foo { a: 1, b: 2});
> +    ///
> +    /// // struct foo *foo_ptr = ..;
> +    /// let foo_ptr = tmp.get();
> +    ///
> +    /// // SAFETY: `foo_ptr` is a valid pointer, and `.a` is inbound.
> +    /// let foo_a_ptr = unsafe { core::ptr::addr_of_mut!((*foo_ptr).a) };
> +    ///
> +    /// // a = READ_ONCE(foo_ptr->a);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for read, and all accesses on it is atomic, so no
> +    /// // data race.
> +    /// let a = unsafe { Atomic::from_ptr(foo_a_ptr) }.load(Relaxed);
> +    /// # assert_eq!(a, 1);
> +    ///
> +    /// // smp_store_release(&foo_ptr->a, 2);
> +    /// //
> +    /// // SAFETY: `foo_a_ptr` is a valid pointer for write, and all accesses on it is atomic, so no
> +    /// // data race.
> +    /// unsafe { Atomic::from_ptr(foo_a_ptr) }.store(2, Release);
> +    /// ```
> +    ///
> +    /// However, this should be only used when communicating with C side or manipulating a C struct.
> +    pub unsafe fn from_ptr<'a>(ptr: *mut T) -> &'a Self
> +    where
> +        T: Sync,
> +    {
> +        // CAST: `T` is transparent to `Atomic<T>`.
> +        // SAFETY: Per function safety requirement, `ptr` is a valid pointer and the object will
> +        // live long enough. It's safe to return a `&Atomic<T>` because function safety requirement
> +        // guarantees other accesses won't cause data races.
> +        unsafe { &*ptr.cast::<Self>() }
> +    }
> +
> +    /// Returns a pointer to the underlying atomic variable.
> +    ///
> +    /// Extra safety requirement on using the return pointer: the operations done via the pointer
> +    /// cannot cause data races defined by [`LKMM`].
> +    ///
> +    /// [`LKMM`]: srctree/tools/memory-model
> +    pub const fn as_ptr(&self) -> *mut T {
> +        self.0.get()
> +    }
> +
> +    /// Returns a mutable reference to the underlying atomic variable.
> +    ///
> +    /// This is safe because the mutable reference of the atomic variable guarantees the exclusive
> +    /// access.
> +    pub fn get_mut(&mut self) -> &mut T {
> +        // SAFETY: `self.as_ptr()` is a valid pointer to `T`, and the object has already been
> +        // initialized. `&mut self` guarantees the exclusive access, so it's safe to reborrow
> +        // mutably.
> +        unsafe { &mut *self.as_ptr() }
> +    }
> +}
> +
> +impl<T: AllowAtomic> Atomic<T>
> +where
> +    T::Repr: AtomicHasBasicOps,
> +{
> +    /// Loads the value from the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// Simple usages:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// let x = Atomic::new(42i64);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    /// ```
> +    ///
> +    /// Customized new types in [`Atomic`]:
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{generic::AllowAtomic, Atomic, Relaxed};
> +    ///
> +    /// #[derive(Clone, Copy)]
> +    /// #[repr(transparent)]
> +    /// struct NewType(u32);
> +    ///
> +    /// // SAFETY: `NewType` is transparent to `u32`, which has the same size and alignment as
> +    /// // `i32`.
> +    /// unsafe impl AllowAtomic for NewType {
> +    ///     type Repr = i32;
> +    ///
> +    ///     fn into_repr(self) -> Self::Repr {
> +    ///         self.0 as i32
> +    ///     }
> +    ///
> +    ///     fn from_repr(repr: Self::Repr) -> Self {
> +    ///         NewType(repr as u32)
> +    ///     }
> +    /// }
> +    ///
> +    /// let n = Atomic::new(NewType(0));
> +    ///
> +    /// assert_eq!(0, n.load(Relaxed).0);
> +    /// ```
> +    #[doc(alias("atomic_read", "atomic64_read"))]
> +    #[inline(always)]
> +    pub fn load<Ordering: AcquireOrRelaxed>(&self, _: Ordering) -> T {
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_read*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        let v = unsafe {
> +            if Ordering::IS_RELAXED {
> +                T::Repr::atomic_read(a)
> +            } else {
> +                T::Repr::atomic_read_acquire(a)
> +            }

This can be

match Ordering::TYPE {
    OrderingType::Relaxed => T::Repr::atomic_read(a),
    _ => T::Repr::atomic_read_acquire(a),
}

Or, also add the match arm for acquire and add a match
arm for `_ => build_error!()`.

> +        };
> +
> +        T::from_repr(v)
> +    }
> +
> +    /// Stores a value to the atomic variable.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42i32);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.store(43, Relaxed);
> +    ///
> +    /// assert_eq!(43, x.load(Relaxed));
> +    /// ```
> +    ///
> +    #[doc(alias("atomic_set", "atomic64_set"))]
> +    #[inline(always)]
> +    pub fn store<Ordering: ReleaseOrRelaxed>(&self, v: T, _: Ordering) {
> +        let v = T::into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_set*() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            if Ordering::IS_RELAXED {
> +                T::Repr::atomic_set(a, v)
> +            } else {
> +                T::Repr::atomic_set_release(a, v)
> +            }
> +        };
> +    }
> +}


