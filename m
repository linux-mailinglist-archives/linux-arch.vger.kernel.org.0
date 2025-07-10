Return-Path: <linux-arch+bounces-12648-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F02FB00C18
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 21:21:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 270CE7AFFAC
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jul 2025 19:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D57D288538;
	Thu, 10 Jul 2025 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cy872Nl/"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2521E0B2;
	Thu, 10 Jul 2025 19:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752175285; cv=none; b=rq+BpIwGtC7KiIQxBLBK0QWMTFwSXgJ0ZuMJYnoASwWAqmiRriRCh23H3H2dP9U80yQG5I10U9Ct5+t89YFJMhRjiXK2OingFDXn5CtKx6v5JiV/G0JciMoH8MJZofTUoKdZbDMt0WQiNFzyKQKM8LgHBzFU+XW47pJvlEvFGtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752175285; c=relaxed/simple;
	bh=IIT3aYIMd7f75/9qiMZTlRieRdG0lit3iU4um0MO9N4=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sUEmOyUJ8YviroIl6n2MZVYRfOq30p/NAYu8YkkYT2cEPcU8znBE4vw49PhpcW22rp2IXGmjkh2ntYJ0iBe9F7DQQCZ8t5DvcjR2UasGcn+txd0Q6RdsUnIZu7erRTROVCf5tumR8S7RzbtHS280sP+3MJpQStKTOKgWMEd/yOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cy872Nl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4112C4CEE3;
	Thu, 10 Jul 2025 19:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752175284;
	bh=IIT3aYIMd7f75/9qiMZTlRieRdG0lit3iU4um0MO9N4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cy872Nl/YqchCJsns7dQxc8VuBnnziOur57O6LW1DQ//DNwCCYsqnGGRpXfAuaVtA
	 glh7LBHdTD7kvsTBC76LXydXupps/8v8gS+vP6fm/+PRjhRTJk8FYaO/IYkXtBmcrc
	 bb7g8h9qkD7UI3pEJvq0OSsA1xaZNTNZg01F4skJkxB7SKZPoyVQWz2CprBzn98DTL
	 d8eKrz35fzkq1jCfBWFeip8b+5heG3Tpgu4/fbNEBt5QpNyC/ipqocVZQrystHtQom
	 eJDCjPzp0tZOITuOK0v1QlcfhXfHq8yH/SPDBkBmT87D4U+X02FZcYurcvFZoFQwXT
	 s1lV/all/KDVg==
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 21:21:17 +0200
Message-Id: <DB8MAQC4V57F.1GGYO1PNPOV2X@kernel.org>
From: "Benno Lossin" <lossin@kernel.org>
To: "Boqun Feng" <boqun.feng@gmail.com>
Cc: <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <lkmm@lists.linux.dev>, <linux-arch@vger.kernel.org>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Will Deacon" <will@kernel.org>,
 "Peter Zijlstra" <peterz@infradead.org>, "Mark Rutland"
 <mark.rutland@arm.com>, "Wedson Almeida Filho" <wedsonaf@gmail.com>,
 "Viresh Kumar" <viresh.kumar@linaro.org>, "Lyude Paul" <lyude@redhat.com>,
 "Ingo Molnar" <mingo@kernel.org>, "Mitchell Levy"
 <levymitchell0@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Thomas Gleixner" <tglx@linutronix.de>,
 "Alan Stern" <stern@rowland.harvard.edu>
Subject: Re: [PATCH v6 2/9] rust: sync: Add basic atomic operation mapping
 framework
X-Mailer: aerc 0.20.1
References: <20250710060052.11955-1-boqun.feng@gmail.com>
 <20250710060052.11955-3-boqun.feng@gmail.com>
 <DB8BQGJNFDAY.BGQ8CZSFFOLH@kernel.org> <aG_Yah5FFHcA3IZy@Mac.home>
 <DB8HQLY48DFX.3PBBUTQLV14PC@kernel.org> <aG_nT3H8J-h2qwr5@Mac.home>
In-Reply-To: <aG_nT3H8J-h2qwr5@Mac.home>

On Thu Jul 10, 2025 at 6:16 PM CEST, Boqun Feng wrote:
> At least the rustdoc has safety section for each function. ;-)

I don't usually use rustdoc to read function safety sections. Instead I
jump to their definition and read the code.

---
Cheers,
Benno

