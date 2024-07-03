Return-Path: <linux-arch+bounces-5241-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F195926990
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 22:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFDE1B26943
	for <lists+linux-arch@lfdr.de>; Wed,  3 Jul 2024 20:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90F1418FDAF;
	Wed,  3 Jul 2024 20:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BW4YyhxP"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60454136678;
	Wed,  3 Jul 2024 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720038519; cv=none; b=SqLn0V9d5+M4lcPP70clq3JmxE77EwpzjZEJ6E1efSg/0Vp64D9NO3t32xDBhyj60chSZPVdTvW6sBcNOAIygqlc9HRcpsr9MZGwmIRzfzkfAHy3UrznxtLIDJ4/uZb4Olq8Kaxz4zkUg7sJhRjmWjoIbwEhVjefZFWWIuSWMQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720038519; c=relaxed/simple;
	bh=rWOY/eZHQ6NmW7nwT3ZK+FVd8KVqf6h8wNDPai7bkt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haUe80xRSfL2Wg/enH9mUVgT/5/zhLYnhDv58KMIbqYrcOOcGW0Mcu+/AWLfLhvNheNUpdowRJD++tUK+DKxx27kkXoyUG5/0VjB4fcnGRi02QvUUITOt18J4yM4LEFilvyn4Vhu4FsSl4Rgrk9v/mQQvtIG57AUPMUFq2GeNf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BW4YyhxP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD64FC2BD10;
	Wed,  3 Jul 2024 20:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720038518;
	bh=rWOY/eZHQ6NmW7nwT3ZK+FVd8KVqf6h8wNDPai7bkt8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=BW4YyhxPLFzfu81I5dST6ulSzXWgpJu2KCnP4Iw+8bLOXS7wdQSYotQCs8rzcD3/Q
	 vb+cn3KEsgIg6IXXKBElT22JcGij+Iqn6DMfIV3C+Ar/+EPQGo1p7N6tjzI6IlhcV9
	 zOAS6ZZNQlcLWPB2WgJP6maKJ2Lk91Fk6tIe42gxoHtaG52p/uh/LH+fQ3W1t7+k0F
	 heOcYOlRaV9uIQy5dvHA1LQyrf2WCBvPueVIGD/miZbmxrPaCz2t6LapUW2xA2NB1u
	 5Xxb+PW9JTP2Ha9PCUHyjsCdeeL59hI9+N1dDbLa34bCec4Qk3WaL2R8f5oJ8kbPwy
	 hSmTTJXrozlFw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 4F5D3CE0BC3; Wed,  3 Jul 2024 13:28:38 -0700 (PDT)
Date: Wed, 3 Jul 2024 13:28:38 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, lkmm@lists.linux.dev,
	Alan Stern <stern@rowland.harvard.edu>,
	Andrea Parri <parri.andrea@gmail.com>,
	Will Deacon <will@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	David Howells <dhowells@redhat.com>,
	Jade Alglave <j.alglave@ucl.ac.uk>,
	Luc Maranget <luc.maranget@inria.fr>,
	Akira Yokosawa <akiyks@gmail.com>,
	Daniel Lustig <dlustig@nvidia.com>,
	Joel Fernandes <joel@joelfernandes.org>, linux-arch@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Wedson Almeida Filho <wedsonaf@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@samsung.com>,
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org,
	Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
	Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
	Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Add the dedicated maillist info for LKMM
Message-ID: <eb163e7c-6c1a-4691-bf23-c8603d4d426b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240703162616.78278-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240703162616.78278-1-boqun.feng@gmail.com>

On Wed, Jul 03, 2024 at 09:26:16AM -0700, Boqun Feng wrote:
> A dedicated mail list is created for Linux kernel memory model
> discussion, and this could help more people to track down memory model
> related discussion, since oftentimes memory model discussions would
> involve a broader audience. Hence add the list information into the
> maintainers entry of LKMM.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Queued for v6.12, thank you!

							Thanx, Paul

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3f2047082073..a77bd8a49cd9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12796,6 +12796,7 @@ R:	Daniel Lustig <dlustig@nvidia.com>
>  R:	Joel Fernandes <joel@joelfernandes.org>
>  L:	linux-kernel@vger.kernel.org
>  L:	linux-arch@vger.kernel.org
> +L:	lkmm@lists.linux.dev
>  S:	Supported
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev
>  F:	Documentation/atomic_bitops.txt
> -- 
> 2.39.3 (Apple Git-146)
> 

