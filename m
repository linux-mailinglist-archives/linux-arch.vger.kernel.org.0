Return-Path: <linux-arch+bounces-12426-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7EAAAE28E1
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 13:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DD643A8C03
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 11:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3892036ED;
	Sat, 21 Jun 2025 11:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="leAih+20"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU008.outbound.protection.outlook.com (mail-ukwestazon11020091.outbound.protection.outlook.com [52.101.195.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9C18B0F;
	Sat, 21 Jun 2025 11:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.195.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750506098; cv=fail; b=gi5C2MhfsUKxysiGGxn2j/M/Kzik9Ocyy8WqpHUTPApqN9ZLjBYPhlaeFO/tGSPMhhWoOVkecZl+Oa6A+6j/9YogC6dezBjL3nNHLud42XTyOdDnukYvl9nKnO5gbWNPBSMv3T3ESO6l+FEbhmjB6rlHNsVo8zItpw9kMEIgYOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750506098; c=relaxed/simple;
	bh=00nxWPiLPi7Lplk85jZ/RNfebuNWHnTgDtEVTek+CR4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ny4EzmOpPc8zZ8RVoCKUzy7DUQZ6adB/ZkCh5shFerp2vosif4gz/FvAKL8jPOKdb9SzTWS+65kqCpeFX/IzlfU5pFkCMnoOfOPfVpG44yJnfVaasBxplQYUQX5iW9pMjOoHlhZCxAOejj6mpYx3KmjKexoQCIWCcV/n8y9aS0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=leAih+20; arc=fail smtp.client-ip=52.101.195.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WDMTx+ZoiRmC3wiH2f2RTJmDeWSGc+dcz1TtCiEeJVYmrH2+SpINRqTHysb/y0/LstPAQoiFHUi7jVK8Npg2RHKB8WhzHXX5gql0wyoa7nSgo7ntBHkeuPVOLaioovEfGb8dJg32k9UhVEY7h8fd6VhvDZcc4bhyNVJvdtLSMsShgJh+op0O/eciyWT6VNM+9MTOU1t+KT5LeZo1yxn/phsgTL1/IFmG1+xkyKhnYAVp5Fq/xmOeTttuDN4IY2uAkRy2BDdVESkVoT+Yo+kr5Mur1kLfNy5tQEWxSAWPcIjsLtd0dDx9aiyQJthP3b3pYp+jbiyUF4P8ADWM9TtFsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/DrYCyXbtdaqUFZtMwGuiFWJZx1b2COO+Z/esr7y9dQ=;
 b=kVpXBvbOeaJpZMz/gj2IINct6D5F4A+e0076tQ1KxL0sTc7l/pvGxlJSxtWrudflaTNt7x+lMJBehAJTPGlp//f9/D++a8qBxuJFWEbhbeWfueO4Q1Y9W5VSDnlSrHsf1+ZFbxQmJhBldOvSzdHUuU/Mm5nB2EekVizeHUHqVC64fYxuizCuTR6hMyny9w2c8egPuab1rDObxSnsJDjTdN70EVH3BBvDU/6gecx4dRJsfjLQ0m1ROZGz2E1KxE/i03tDGyxk6jVy/R7Yy2H4InZUhIqp/Nuxhj40IvMenru6kDZu/LD1DSazkBga2vk+dFP7q9A136EjcnytO5JNJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/DrYCyXbtdaqUFZtMwGuiFWJZx1b2COO+Z/esr7y9dQ=;
 b=leAih+20gA0hexMNfdCw4+TqXEQQ7ELCCNQqeRbLff/C1kAZC2q9BFniONj4apIItSUz+wC+piN1J9ygWh+MBn3kTpHyoH3xUFlPa2rXRJNtwf2AZR7v+ZyUvXnUEyKAw8llkwSvAzti/Mo8tBF2PGJhjArfgVbQVu0nWqY+1Ts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CW1P265MB7532.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Sat, 21 Jun
 2025 11:41:31 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.8857.026; Sat, 21 Jun 2025
 11:41:31 +0000
Date: Sat, 21 Jun 2025 12:41:29 +0100
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
Subject: Re: [PATCH v5 06/10] rust: sync: atomic: Add the framework of
 arithmetic operations
Message-ID: <20250621124129.6e879463.gary@garyguo.net>
In-Reply-To: <20250618164934.19817-7-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<20250618164934.19817-7-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0386.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::14) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CW1P265MB7532:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f36e618-e51d-4570-b348-08ddb0b89163
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|10070799003|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?V2dRFo/jivl2nCiih67VJafDV0UpzHVKBiHTV27h9q9YKvKpilY3ZhYie/dC?=
 =?us-ascii?Q?E5ZXCy32KRFtSVZyVPAHGwu5nJj6D2xe0oOKhgeWqTC9oVZ6wa+n1VhzHgAA?=
 =?us-ascii?Q?TCgY6IXfPVchpzAyhhmxO4fasK9m2w/rruXJv0Syumtoo7/fKbQpIVV/6oR1?=
 =?us-ascii?Q?cNO+BT5vYGIPZlyCu+oChdAdrZ2+44SqsIKlCRous0gCHXYc5gKQJBMejmBC?=
 =?us-ascii?Q?BjzMigT3jqxBUn3ZOH2dccbJsr9jwGy3P5rNYyvRzdhr7Ghsmhoz6UetvkLc?=
 =?us-ascii?Q?PI1bx5TH91SyRnU4hDr8gZuQSBUvdUdjYns+rBgPl5uNl/g7pAS4Thh3R4b9?=
 =?us-ascii?Q?KDgRco5WKJvingV+y8ZKSH7S6U/wLLn4/dUBhSQ/69yqqQXXppVGqU6fc5J7?=
 =?us-ascii?Q?LC27iZSpx2Hv0Am/UEabNaDzG3q10tIUtWFHZ23BHrzDuNCLpzI6y/gb0+x0?=
 =?us-ascii?Q?K2En02pBRNdzaj4ajQOL6iFLDWyCKmbuD1GjkUXGlWewTjKK5HO7ftdt/IUn?=
 =?us-ascii?Q?9ACEsz67DIO9PtL5Pb2fImRbYzLggO+NgkJBrKAikSUkcJIgf/3/8zNTwy3d?=
 =?us-ascii?Q?HIfy9OnxBEPGJCAOs8Bsi2m43eJDptDkUHhbvxyBwXslX9FiQJdgTVJsN9Sz?=
 =?us-ascii?Q?mF12+dq1k0H307xl3nqeSh6+MPCTGnmCinxL3g2xO10yk8xAcUAmfAUOPZFD?=
 =?us-ascii?Q?QxiwwX8R0oRtqiYiAgBsmpXLfXGfqWFP3sPEmECl3e/x7L2Xuo2tvxcgAMsf?=
 =?us-ascii?Q?kzD9V/icPKaBsR4diJtGve6Z3WzModCi9KsuOzSRJ0oKwAMzOnwpvDbCsxnZ?=
 =?us-ascii?Q?5fd/yj3L0vAXN8Gp/Cx6GjOzwStHF0rMV5H/ifhKascOaN4fBrShBis/h7Oq?=
 =?us-ascii?Q?Xo3vNOO/CMZYb0zDNTx/CW4Fz1sE5j/I4U48xrrbuyBya8+1lhrv8wa9fqwr?=
 =?us-ascii?Q?o0Nqh6zgsLJVPZyWHFT3pqJD/S3Vx8cNcEUL6EmCGOPBKFU2YN1ri8Yxw9h3?=
 =?us-ascii?Q?oRxd0bH8TG2+im9Wjg00p00aItks2x6N48SalpmYaZCdCWFsEbga/YKui9uj?=
 =?us-ascii?Q?2cHN4kcNENTOGfh99++xWdN7OuGtDgloS8LhODb/t+Y4vUtBrElJeenUna6E?=
 =?us-ascii?Q?Xui/b/1Rp5mDbLHMfdGifj1r1F7x94D5N/B6c/grHDkHw57A/a7XWjv00ioS?=
 =?us-ascii?Q?jSEsH4Be0DGiDjRGrYUuJO/bgJCR9ZpMkl0PDrzYpCXkqx7KYZA/8QO4Bat+?=
 =?us-ascii?Q?fCMAFIA6mIyKqQFAwrbDjM8nXKkLJ+3IAClvfATd/4cYfGhgXWpZvsGPrJFz?=
 =?us-ascii?Q?wdhXL7APU8L3ThZ0P0YYyhmQDiRsn83rQbILTzBw9Xs7S7V4ir1TeRxh+7Sl?=
 =?us-ascii?Q?J3u+X+Qr6B6rrK3ovHURYnG9gWDi9mYnE/gqCSbUg/ODjdeIeI6yTvOZRY9K?=
 =?us-ascii?Q?8WYtH4BapbM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(10070799003)(7416014)(376014)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IbEfm0wOJIcErhlOh97NHfCTuV8dhK7iiarXlTMr5XmXsY+rQtpj5NT70Ouh?=
 =?us-ascii?Q?VOPm3ElJxQWuW52Gk0w9vqw85ueoSC7Xm8Iey6r09rraqj1qqcnlRwyPtnlL?=
 =?us-ascii?Q?53xf/e6sFiCmcggTDjeFy0WHFr2pL5T4voRPSyFZpON3E0q53jbC+qpQVBoF?=
 =?us-ascii?Q?yUq8WEHAGVJ71KfOeLPXrHI4CAIeUA28wFLlJZgoOd8sybltv64Y86C3j9xM?=
 =?us-ascii?Q?duXX8w+1+jMW6wEAOYkLFgL0k6MwLXohkDoVCqbF4gdmy3z6MdCOK+X5JVrI?=
 =?us-ascii?Q?pv/lUhqsp9uIkx19zS3u/RhJjz5NdUIaOJkLV81k0AGpb3bxZHPXuprh2Zbe?=
 =?us-ascii?Q?yyXI8uN2HdbMzP338HajZGDWyUehYeZVP4O4LYfXUfa0fxBCv2aK+rjgmZ5U?=
 =?us-ascii?Q?ulAEHDIRaoZGGVxGrE92Tp1Wkp3ztw3gr2oa/LmPJ6FLH3fqNcqpZ7MDQrNy?=
 =?us-ascii?Q?eDwbNAZCenxRuUaYeqKkNdlcMXvMzILLc0c3/vQo9ZdiFyyHW2V+MvdG3z6S?=
 =?us-ascii?Q?SjVc35XQy0PCcIHwFtnxQlFJPtjCJQvugjarFfAn9VCyYaoZcmIt2t+llolX?=
 =?us-ascii?Q?ZVFU/4/UIEcjw6LaVoy2TUw8eM1cINYOfCR1fePfYUohkkK+/Xq/oQLcigBx?=
 =?us-ascii?Q?6Wtxj4sueFeTkgd1XVEfGo2tWjLm1dizAGrZAbo2lyD2U8chK0pNf39MAwtz?=
 =?us-ascii?Q?tyf9Wf7pBdZvPnoHIfhFJFYo912Yu7FRf+MmJDSTXG1EQ+qF655x2ayCHJLn?=
 =?us-ascii?Q?NxHCa6ByCPAwgpshgkEW06B1Wgh0JCtu5gEFpRTea63f4cxxLJvIwbUY+Sxm?=
 =?us-ascii?Q?X5g9PlgItuYJ8m1RcQBopW+Kddpj6M76EoB9OkoPTT9fkb0ZyKzL7pgQzvu5?=
 =?us-ascii?Q?NjZ3hlb/og7IjOkctWIyQNCgeFJZEJNWdq/VNnw9jxvfnE4vNSSvXacEFoKz?=
 =?us-ascii?Q?B0JjdkExC2kB5eqbmScLDrRaeikeBH2zV3qj+2KbHaKHm85lf6gSXH7xxcmk?=
 =?us-ascii?Q?MO3vv8bSfmhGNf81oHVZHhQFHEMFLTOF5wIQ8wuR3msrlmijMrBPGZ8db/Na?=
 =?us-ascii?Q?Jv3kPBC7m9kLoVPWVF4l/X52IMj6Gqksn8ADvUx2jJPpdSoMUz2yGIJUOHMk?=
 =?us-ascii?Q?YLLR8pKkwTKLw0sUk67yLVII2C57qYlFkz4lz+03XllnAMR0yjtvoqTnukuw?=
 =?us-ascii?Q?QoGDK1nhjcOYwofLCIcQ3PObWZokP0XVlGj//5Oj3Y0FSGgudedAyXan6FE7?=
 =?us-ascii?Q?ZAjKsWa7nQjBHO+cSuLRRa69nRje58Giuj9EpCx8IBNQxHJCKZm6GhN1ReiC?=
 =?us-ascii?Q?m6U0yhqPlR/mga5geAohdxBbAj4Ud2lsS6BTjEf61Ax90QQl31lfyYYW0lzp?=
 =?us-ascii?Q?klduPmwmzVccUvj7Kr7wR619Yz6yObTF9BbbVefLz6u1NP2GVQtkp7f0O3HE?=
 =?us-ascii?Q?lVa+0HcDWVyN2CikrWgKGKGs31KF1jmcZK55zwYdsBr5DTxowC0juQqQg1wl?=
 =?us-ascii?Q?FGkuyV2A0hbYasxUju1XqBmsmh71sFVI5uENNziLB2kGLLAAfqKmluVHoqT0?=
 =?us-ascii?Q?X5KVQx7du1Bu+kxR1lXBsVTR1VhVNUzrDRdxVvfJ/En7CPqvOn4ZTGy/mg2E?=
 =?us-ascii?Q?og=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f36e618-e51d-4570-b348-08ddb0b89163
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 11:41:31.7432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8/Vq16ceD3KFlefcJ0F61PWwd7doflfrvnZSXRMu3+ULNyaGlD5zZluSHrPGRhkG+YVXJLJaY3YjT1PgNcz1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7532

On Wed, 18 Jun 2025 09:49:30 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> One important set of atomic operations is the arithmetic operations,
> i.e. add(), sub(), fetch_add(), add_return(), etc. However it may not
> make senses for all the types that `AllowAtomic` to have arithmetic
> operations, for example a `Foo(u32)` may not have a reasonable add() or
> sub(), plus subword types (`u8` and `u16`) currently don't have
> atomic arithmetic operations even on C side and might not have them in
> the future in Rust (because they are usually suboptimal on a few
> architecures). Therefore add a subtrait of `AllowAtomic` describing
> which types have and can do atomic arithemtic operations.
> 
> A few things about this `AllowAtomicArithmetic` trait:
> 
> * It has an associate type `Delta` instead of using
>   `AllowAllowAtomic::Repr` because, a `Bar(u32)` (whose `Repr` is `i32`)
>   may not wants an `add(&self, i32)`, but an `add(&self, u32)`.
> 
> * `AtomicImpl` types already implement an `AtomicHasArithmeticOps`
>   trait, so add blanket implementation for them. In the future, `i8` and
>   `i16` may impl `AtomicImpl` but not `AtomicHasArithmeticOps` if
>   arithemtic operations are not available.
> 
> Only add() and fetch_add() are added. The rest will be added in the
> future.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic/generic.rs | 101 +++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/rust/kernel/sync/atomic/generic.rs b/rust/kernel/sync/atomic/generic.rs
> index bcdbeea45dd8..8c5bd90b2619 100644
> --- a/rust/kernel/sync/atomic/generic.rs
> +++ b/rust/kernel/sync/atomic/generic.rs
> @@ -57,6 +57,23 @@ fn from_repr(repr: Self::Repr) -> Self {
>      }
>  }
>  
> +/// Atomics that allows arithmetic operations with an integer type.
> +pub trait AllowAtomicArithmetic: AllowAtomic {
> +    /// The delta types for arithmetic operations.
> +    type Delta;
> +
> +    /// Converts [`Self::Delta`] into the representation of the atomic type.
> +    fn delta_into_repr(d: Self::Delta) -> Self::Repr;
> +}
> +
> +impl<T: AtomicImpl + AtomicHasArithmeticOps> AllowAtomicArithmetic for T {
> +    type Delta = Self;
> +
> +    fn delta_into_repr(d: Self::Delta) -> Self::Repr {
> +        d
> +    }
> +}
> +
>  impl<T: AllowAtomic> Atomic<T> {
>      /// Creates a new atomic.
>      pub const fn new(v: T) -> Self {
> @@ -410,3 +427,87 @@ fn try_cmpxchg<Ordering: All>(&self, old: &mut T, new: T, _: Ordering) -> bool {
>          }
>      }
>  }
> +
> +impl<T: AllowAtomicArithmetic> Atomic<T>
> +where
> +    T::Repr: AtomicHasArithmeticOps,
> +{
> +    /// Atomic add.
> +    ///
> +    /// The addition is a wrapping addition.
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```rust
> +    /// use kernel::sync::atomic::{Atomic, Relaxed};
> +    ///
> +    /// let x = Atomic::new(42);
> +    ///
> +    /// assert_eq!(42, x.load(Relaxed));
> +    ///
> +    /// x.add(12, Relaxed);
> +    ///
> +    /// assert_eq!(54, x.load(Relaxed));
> +    /// ```
> +    #[inline(always)]
> +    pub fn add<Ordering: RelaxedOnly>(&self, v: T::Delta, _: Ordering) {

This can be just

pub fn add(&self, v: T::Delta, _: Relaxed)

> +        let v = T::delta_into_repr(v);
> +        let a = self.as_ptr().cast::<T::Repr>();
> +
> +        // SAFETY:
> +        // - For calling the atomic_add() function:
> +        //   - `self.as_ptr()` is a valid pointer, and per the safety requirement of `AllocAtomic`,
> +        //      a `*mut T` is a valid `*mut T::Repr`. Therefore `a` is a valid pointer,
> +        //   - per the type invariants, the following atomic operation won't cause data races.
> +        // - For extra safety requirement of usage on pointers returned by `self.as_ptr():
> +        //   - atomic operations are used here.
> +        unsafe {
> +            T::Repr::atomic_add(a, v);
> +        }
> +    }
> +


