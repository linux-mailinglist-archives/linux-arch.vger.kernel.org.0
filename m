Return-Path: <linux-arch+bounces-12423-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 191DDAE28C0
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 13:19:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FD53BCDE0
	for <lists+linux-arch@lfdr.de>; Sat, 21 Jun 2025 11:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DADA820102D;
	Sat, 21 Jun 2025 11:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b="rFKlGpKn"
X-Original-To: linux-arch@vger.kernel.org
Received: from CWXP265CU009.outbound.protection.outlook.com (mail-ukwestazon11021084.outbound.protection.outlook.com [52.101.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB2A1991CB;
	Sat, 21 Jun 2025 11:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750504735; cv=fail; b=B5G7G4PQscoZdT/OQtkhzqW7EMtY2xrAHIpW/k0O4NhsiRXH2Y1gEkuDtB8xWBUSRhO48Fedg2UDDmzu2MwB3YIE02PiEj3FzGGDVd7HiTxWNfoYCmF3/a4vQtThMh4kWgRlw5st9wzp7gzSLOrCWI09xWK6mJn5+bBuu6GBALk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750504735; c=relaxed/simple;
	bh=rqRjLiyTnECBSf4wA69v329DTlnIl5MxFy7GL2l2qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4LDEHu1q+bc1xce6tlIHh8nKa8eCI9afHhPDBIDccyey5UGwHUdTbsU45Kr1q9d8HXiCzMCpFjM/ScfPiJ5I+vZAblwUXU1fXg8EI5OwKKQjGekMgSD6hiteu/Lk1VtBx5PkhuA4FrFKitsM4MVMji0VHVLZCto2Cw+SsZHw+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net; spf=pass smtp.mailfrom=garyguo.net; dkim=pass (1024-bit key) header.d=garyguo.net header.i=@garyguo.net header.b=rFKlGpKn; arc=fail smtp.client-ip=52.101.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=garyguo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=garyguo.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUnWuIb8RaVyuZ/aaLqbML+GpfIBzbHYIYCp/Z+yzamAfVt57oSLbNaXC1jLgGJsDPhj2pmGp6hs6RuJtRBhcYSINloQftsCczUbo4sYEiHztVo3OxKhpOjB8rDfRU1w2xShqMtC+D+3mLHyYp8ruj2M9mNrigo4Pw4di0RqL19tvKy5VJlGpKo/Wubs5HeFH7/p7Uw+cMtVyMnpG61c4sebsLrAKQauLBSOdRnEngSMJh1jfkukkv7YjpgFwB8C5ckCi5nFAoaEYQz02iIQdIAgIjbmXrgzTY4TFsJdmZUrUqCe1f3EuCG8qFvBjgX7EYBOKRq6kB6jZptFSxqCqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QTI0ft1BHOGWA5BJy4xSvbqCu+xSgIMIT5ItG8WOx7k=;
 b=SiAtKvmZ6oba/jciKiGHBFZ5NzPc0YPyscVKD7qmnxw8/2tAPzKEpNu4zvZgH0TeA1zKWu/4R/ywZlLKoOWecwbMSix3dpaTcE7QCz9UmvnKPbkDbEkervwFZyM5XnNcJKHAOLSJEEKhDdMKPhAHCjendTJHVj3VQ1kYnUcsNb8zDariWFUy0fWUZJLjmeywag1Ae7Remudvd+Pdg0Lw7nbBbls7OwLXuRAAcEnyn9vHzNxLtDbGjHeJr4ZzDo7bEmcvRjFNa6KCds/+hnpQmwt3ocpZtST4+hFI3taIZvn3ZLENpQdoMk0+AveuINIwsM9Vy/HbE7kKq9+1WjZoPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QTI0ft1BHOGWA5BJy4xSvbqCu+xSgIMIT5ItG8WOx7k=;
 b=rFKlGpKnlvuabRiB+RNCWWWEZbdmTv+skZHAb7yu0NiB8OJxliswTkAWv0TXFwTgrtOeRG5pLUS3F/JJ8bzrqJGM89GNDiHVzjG5aTQJo1Ma4JoCJ38dAaTG3WUUFWC6R0A8a3MsbvLBpderZAY1Fdhn6k7il4sLxyuHmB9f71E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:253::10)
 by CWXP265MB2968.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:c6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Sat, 21 Jun
 2025 11:18:48 +0000
Received: from LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7]) by LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1818:a2bf:38a7:a1e7%6]) with mapi id 15.20.8857.026; Sat, 21 Jun 2025
 11:18:48 +0000
Date: Sat, 21 Jun 2025 12:18:42 +0100
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
Subject: Re: [PATCH v5 03/10] rust: sync: atomic: Add ordering annotation
 types
Message-ID: <20250621121842.0c3ca452.gary@garyguo.net>
In-Reply-To: <20250618164934.19817-4-boqun.feng@gmail.com>
References: <20250618164934.19817-1-boqun.feng@gmail.com>
	<20250618164934.19817-4-boqun.feng@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0546.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:319::17) To LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:253::10)
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LO2P265MB5183:EE_|CWXP265MB2968:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f74dfa-effb-439d-24e0-08ddb0b5648c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|10070799003|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ee7gqjexU5bEe4HNUW4wsyRova7QogcOjlrrZPv1ZWc9rKtVotShPSR8TwnM?=
 =?us-ascii?Q?64Aum5Uewe/KKkS0vTJODEGZVyPIQyfBDjMHfv8ifGvCOi9Lkzkxx06lFomz?=
 =?us-ascii?Q?aEKS/AkeE8cOpGu7TW72NtPTvpDOxWnpG3OVBeey6W/GibJTYwa5qSvih7XW?=
 =?us-ascii?Q?n2j7NY7O8QjMlhPc0oFJnBfQGTaVBxSTBXImbeYWp0E5GxCbGEz8vVS0G4M1?=
 =?us-ascii?Q?VP5DgZ2XI7Lmfmz/znKm+2swenC8oCounjythYg+/TSOL5uH9SAforF8NBLq?=
 =?us-ascii?Q?hqppoaC7pd/c5kU56yB/M9kIMgLxllFxwmmEoWRw1jOWWx88oOoNxMNK52Zn?=
 =?us-ascii?Q?KzIIZanG71Yl/YkboBd75ps25UHI+qBZqIVIw6bTwrQmJB0IHvNSKL8LDz9d?=
 =?us-ascii?Q?H7JksNmvHSyNy6IdDOawA4tv90NchleAief7bs560jj2qs3q0m8ly4DK4J9L?=
 =?us-ascii?Q?adY4MFYy5eAc/zVKzFlwCdv+EjkrsTS5iL04fw/jSgmKW+Y5LZhDzM1bNOCU?=
 =?us-ascii?Q?X/C4cozjieW+5M5CDa1tt5jOqqnBThq9vctZ/9s49j5+GVq1jJFUtndZ59iX?=
 =?us-ascii?Q?XEWoEenkZaxVczDn/5j5yzf1WeTubkgn+JM1Wx0g5SKaZYEr82uwiG+Hi/Td?=
 =?us-ascii?Q?sSY0GMQdvMVGpL7r2XFooPo1kFBOiOkIHgTBXZzHZdZO9CWiQHHLWSf2Nuui?=
 =?us-ascii?Q?bAgF+0WoaNMLi/9UhYy4ORdT4bYCN3GJe67VTSD3sR1o7+Ue1O8nCe2YPbCj?=
 =?us-ascii?Q?Ci1ZPw1Yu6UentQw7822JvKyx2BWVp25zXbAiSUCzr3tq813tpZloNN3zC0h?=
 =?us-ascii?Q?2W2hwof74ST1v7CqhnuVKoWyPU1ubmaUB4Rp+WzA+cKe3/qR9oXSdbf04T97?=
 =?us-ascii?Q?att+inokv9SK3g8nwjxreVoqhczfAMt6A5ypPVB6VdsRDmsg+IMoYMPzWWg4?=
 =?us-ascii?Q?aRhsDblwRTJ4L/yIkZD6ooNj6KuDaOzfbB3QOP0dY+bwSb/uiq9VNPLKxSkO?=
 =?us-ascii?Q?Otf02erXPj8UqfBe8aL4DpXoBb3nkKhv9Sq8TvGV7XKUL7UGZEgche5EK1Pw?=
 =?us-ascii?Q?5pLHAfF7lnWXFrC8mFu2Yhde3gMhA77MlAY1Sen7dJ2UShYNqfpFS3vt/4Eu?=
 =?us-ascii?Q?CTl+ZcIW0duN7OYEATT1oLRyT1SDS8mT8OZ+umXq/u9O9RFi7psuCa1GZOeC?=
 =?us-ascii?Q?E1czeo8ybLF109R59zYW7gtYZs5zPvHBt82q2rkaBcEzPd0wyimTPup7Vvnr?=
 =?us-ascii?Q?SU53wyjU8z2RVsM3Kkyo4uFVqtcD9EDIxRMr5L5NXvllFGYsAVL4ZpOqzifA?=
 =?us-ascii?Q?a3kqxLKSqfTYnBxZKnrcvg+mYCmS/xufjhBF73xN/e35hEDSNSyGF1pqLLWD?=
 =?us-ascii?Q?7BWWdxuLu+bapHY0jAT3CoYN4iXzEaHyV4yYO69omvKElJQpOMZbMVpzf0z5?=
 =?us-ascii?Q?eU6plD5U8uo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tN5MMPG7kP9BElkiXwwH+XnXq5Rb5tkWAbtHB5+Ts5jCEG0Qz5gAqqRdRCFX?=
 =?us-ascii?Q?KPxPxZFEn+ek8LbwA36q8EJFwYi4lt8SSWMRxnywBvPCCKm5UVTBDM6Hk4nB?=
 =?us-ascii?Q?/H/S1+6BJLSU2PqKljqPkLCmnKwVqsIzghFtBpN1qIIZBl3b7hFHVqXJrtaw?=
 =?us-ascii?Q?EFCOk8fGDEypGNBRVP6GWqEsnDCwTqRtOtFSbIveGpPtqV3r8GQybNnU2uuc?=
 =?us-ascii?Q?HM1+6g984+CjqUUjjBcPMmXigVCwDstS42CIdlIHS/sDcCzMluRcvFaUxrhg?=
 =?us-ascii?Q?7Us+SXWfz37rAK1fUGqgOWx1HabRYD/yYHF/p1VN4RCKMS8dVHpIwUvL3m0Z?=
 =?us-ascii?Q?8wJRUedb7Wzl3Ki86mCMtHeAz/DFwYC755Wy5Gd7vI1XJtb0Z0g7NBTZXqIU?=
 =?us-ascii?Q?BjsewBfODgoPn5Sj4C3JrYF/Oor7mg/BEo94MMUGezDc5tgBQJerd4KZb46o?=
 =?us-ascii?Q?RV4qVGxLT2tuAgH8bqU4/7OJBU49m8AfYY7+PAN0WjwWsQeHmX9mKatrnDYe?=
 =?us-ascii?Q?V0uzZ0SeAToYfu+woPUflWf1MD8AlHeQQ8L/SRPu9LGaV4FNUt+edynUpYg6?=
 =?us-ascii?Q?b66QpiGDluJ7W5uljCLgKMHpMGUqfpz4d/JIKy7F6VCivokE36bsbrS/IwEt?=
 =?us-ascii?Q?tsftM5ovb7SlPQAlmZ2wqSeaRHyAA5y7t+3dZQqaqvB0hJ8NGCD6Mn7pS/HQ?=
 =?us-ascii?Q?uS9OTWU3Cdb7t5KF9ghE8RtcPCNrNvno+iE7xFwBG3eIzeLmmNOKbedUoVTZ?=
 =?us-ascii?Q?QlC7BaIJwN4DoOGaiqkyBryBNDO+38WrXU7eAK0EU/+89PfUJrE+w9dp1cTL?=
 =?us-ascii?Q?K/Ay1lK5xKD66iKLAzI5BcUNBbBBXxQbW+PxoRCsYfPK/SegcJTwywojIJ8e?=
 =?us-ascii?Q?6PZhYFxeLiHFoJriSo0NSziqZjdDEulon2yUcqc8i2b2Qw8+O4gLHe6yJXGT?=
 =?us-ascii?Q?uVTY0ZPeoXbLkeZaz0ZAdn4KAfqv/dxKZNl/7AWrwmsWJ2Q/GiEr/fO26pT0?=
 =?us-ascii?Q?GQVtMqESX462LP2TfJW5wjXthOF9R4tgWEpaiffnkXEDPMmzQMcYAcy/KNeh?=
 =?us-ascii?Q?tEdlNMrEmf5GgXbNUNDojsfliSERNjiSv826jM93CKian8/pBunnT0oExYk9?=
 =?us-ascii?Q?ERzs2arCEYTk4s+zMnyldKr/0z9JG5owwe51ek6bmGRSPGO8aWn3q5Fz7ALV?=
 =?us-ascii?Q?QOI38LnkacNlC7myS9aSWP8MfD7aUvBKY6fpopl744mBxtc0tQL3sPeGPB71?=
 =?us-ascii?Q?YPdfrLAGForVznzjyn3U64r5Ya78eVF715JYef8gAzwt7mOZao7wUIY4OY20?=
 =?us-ascii?Q?lNcYpOkWGnauRrQy7oNs/D1MGsF7hWKlbfN5CeD+jSofkSX0OOHDGM6/mUsv?=
 =?us-ascii?Q?ph515eST6LVbw2l/VXj/VT1lXvqLHX+VFyMlSV4MM3Wmneu/MKS4KEclsO8r?=
 =?us-ascii?Q?XMlBlzxptj2ZTyPkqAhz1MTyAIVJX9oRwo0Z5VZlgsOhNE0qXFNq1bG7VDtx?=
 =?us-ascii?Q?L+EctA8eJVV6ffK9quwCX/LlgAlMhsxAMuUw+CKOlRavQtCLy52Pbb5FiHS7?=
 =?us-ascii?Q?X1DOwBmLKlN176LAJ8miYZj+o+KEjIRcD1FYCwGkj8ZigFRRVDUkyRUg010z?=
 =?us-ascii?Q?Pg=3D=3D?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f74dfa-effb-439d-24e0-08ddb0b5648c
X-MS-Exchange-CrossTenant-AuthSource: LO2P265MB5183.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2025 11:18:48.0427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D34FkzLCtPbkpe5tR+pd95k/4UsRl8pIVnlho13qoZytkK3JfjmId3lWwzM5KYHsgngUx4sYzVKZbvJjOZP8vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP265MB2968

On Wed, 18 Jun 2025 09:49:27 -0700
Boqun Feng <boqun.feng@gmail.com> wrote:

> Preparation for atomic primitives. Instead of a suffix like _acquire, a
> method parameter along with the corresponding generic parameter will be
> used to specify the ordering of an atomic operations. For example,
> atomic load() can be defined as:
> 
> 	impl<T: ...> Atomic<T> {
> 	    pub fn load<O: AcquireOrRelaxed>(&self, _o: O) -> T { ... }
> 	}
> 
> and acquire users would do:
> 
> 	let r = x.load(Acquire);
> 
> relaxed users:
> 
> 	let r = x.load(Relaxed);
> 
> doing the following:
> 
> 	let r = x.load(Release);
> 
> will cause a compiler error.


I quite like the design. Minor comments inline below.

> 
> Compared to suffixes, it's easier to tell what ordering variants an
> operation has, and it also make it easier to unify the implementation of
> all ordering variants in one method via generic. The `IS_RELAXED` and
> `TYPE` associate consts are for generic function to pick up the
> particular implementation specified by an ordering annotation.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  rust/kernel/sync/atomic.rs          |   3 +
>  rust/kernel/sync/atomic/ordering.rs | 106 ++++++++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
>  create mode 100644 rust/kernel/sync/atomic/ordering.rs
> 
> diff --git a/rust/kernel/sync/atomic.rs b/rust/kernel/sync/atomic.rs
> index 65e41dba97b7..9fe5d81fc2a9 100644
> --- a/rust/kernel/sync/atomic.rs
> +++ b/rust/kernel/sync/atomic.rs
> @@ -17,3 +17,6 @@
>  //! [`LKMM`]: srctree/tools/memory-mode/
>  
>  pub mod ops;
> +pub mod ordering;
> +
> +pub use ordering::{Acquire, Full, Relaxed, Release};
> diff --git a/rust/kernel/sync/atomic/ordering.rs b/rust/kernel/sync/atomic/ordering.rs
> new file mode 100644
> index 000000000000..96757574ed7d
> --- /dev/null
> +++ b/rust/kernel/sync/atomic/ordering.rs
> @@ -0,0 +1,106 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Memory orderings.
> +//!
> +//! The semantics of these orderings follows the [`LKMM`] definitions and rules.
> +//!
> +//! - [`Acquire`] and [`Release`] are similar to their counterpart in Rust memory model.
> +//! - [`Full`] means "fully-ordered", that is:
> +//!   - It provides ordering between all the preceding memory accesses and the annotated operation.
> +//!   - It provides ordering between the annotated operation and all the following memory accesses.
> +//!   - It provides ordering between all the preceding memory accesses and all the fllowing memory
> +//!     accesses.
> +//!   - All the orderings are the same strong as a full memory barrier (i.e. `smp_mb()`).
> +//! - [`Relaxed`] is similar to the counterpart in Rust memory model, except that dependency
> +//!   orderings are also honored in [`LKMM`]. Dependency orderings are described in "DEPENDENCY
> +//!   RELATIONS" in [`LKMM`]'s [`explanation`].
> +//!
> +//! [`LKMM`]: srctree/tools/memory-model/
> +//! [`explanation`]: srctree/tools/memory-model/Documentation/explanation.txt
> +
> +/// The annotation type for relaxed memory ordering.
> +pub struct Relaxed;
> +
> +/// The annotation type for acquire memory ordering.
> +pub struct Acquire;
> +
> +/// The annotation type for release memory ordering.
> +pub struct Release;
> +
> +/// The annotation type for fully-order memory ordering.
> +pub struct Full;
> +
> +/// Describes the exact memory ordering.
> +pub enum OrderingType {
> +    /// Relaxed ordering.
> +    Relaxed,
> +    /// Acquire ordering.
> +    Acquire,
> +    /// Release ordering.
> +    Release,
> +    /// Fully-ordered.
> +    Full,
> +}

Does this need to be public? I think this can cause a confusion on what
this is in the rendered documentation.

IIUC this is for internal atomic impl only
and this is not useful otherwise. This can be moved into `internal` and
then `pub(super) use internal::OrderingType` to stop exposing it.

(Or, just `#[doc(hidden)]` so it doesn't show in the docs).

> +
> +mod internal {
> +    /// Unit types for ordering annotation.
> +    ///
> +    /// Sealed trait, can be only implemented inside atomic mod.
> +    pub trait OrderingUnit {
> +        /// Describes the exact memory ordering.
> +        const TYPE: super::OrderingType;
> +    }
> +}
> +
> +impl internal::OrderingUnit for Relaxed {
> +    const TYPE: OrderingType = OrderingType::Relaxed;
> +}
> +
> +impl internal::OrderingUnit for Acquire {
> +    const TYPE: OrderingType = OrderingType::Acquire;
> +}
> +
> +impl internal::OrderingUnit for Release {
> +    const TYPE: OrderingType = OrderingType::Release;
> +}
> +
> +impl internal::OrderingUnit for Full {
> +    const TYPE: OrderingType = OrderingType::Full;
> +}
> +
> +/// The trait bound for annotating operations that should support all orderings.
> +pub trait All: internal::OrderingUnit {}
> +
> +impl All for Relaxed {}
> +impl All for Acquire {}
> +impl All for Release {}
> +impl All for Full {}
> +
> +/// The trait bound for operations that only support acquire or relaxed ordering.
> +pub trait AcquireOrRelaxed: All {
> +    /// Describes whether an ordering is relaxed or not.
> +    const IS_RELAXED: bool = false;

This should not be needed. I'd prefer to the use site to just match on
`TYPE`.

> +}
> +
> +impl AcquireOrRelaxed for Acquire {}
> +
> +impl AcquireOrRelaxed for Relaxed {
> +    const IS_RELAXED: bool = true;
> +}
> +
> +/// The trait bound for operations that only support release or relaxed ordering.
> +pub trait ReleaseOrRelaxed: All {
> +    /// Describes whether an ordering is relaxed or not.
> +    const IS_RELAXED: bool = false;
> +}
> +
> +impl ReleaseOrRelaxed for Release {}
> +
> +impl ReleaseOrRelaxed for Relaxed {
> +    const IS_RELAXED: bool = true;
> +}
> +
> +/// The trait bound for operations that only support relaxed ordering.
> +pub trait RelaxedOnly: AcquireOrRelaxed + ReleaseOrRelaxed + All {}
> +
> +impl RelaxedOnly for Relaxed {}

Any reason that this is needed at all? Should just be a non-generic
function that takes a `Relaxed` directly?


