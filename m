Return-Path: <linux-arch+bounces-7216-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B029975C22
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 23:02:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABD31C217CD
	for <lists+linux-arch@lfdr.de>; Wed, 11 Sep 2024 21:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691781428E3;
	Wed, 11 Sep 2024 21:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwSaH4z5"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34BBA5337F;
	Wed, 11 Sep 2024 21:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726088564; cv=none; b=oOwFIaRHN1DVc10237TtdmCe0e5h9W2VhqwxZMJ1o2kcYf5/Gr165sgGHSIgjD7KbENVqMPMUUTCI6pO4amGPKFh3WWRNeEZpnUXpwjpUygnYlvI1qVPSwD9BqH+J0GW6mPmFCKD0GUkXwFb4ZxAklimROpvb9TvVMz7Be89imU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726088564; c=relaxed/simple;
	bh=JvlZjDzoLcyEYkVOzAptDUtLhc4EYmZCUaQ/PncJGJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTY5JLEG/FUZrZavkvbxgEJMOzFhGiD0bKrfwLMij/kdKkYw5j10k0JYcvkBuNHSTmaYRVV+KpJdK5LlI45XVffzukTXVOqqo7E9Drk9i/xsc1XomarNnjV1tQiTx6PtWv+Lnylzy2akcXplCTb7RF67Xboau4oPyhSSeWzDhxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwSaH4z5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A30C4CEC0;
	Wed, 11 Sep 2024 21:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726088563;
	bh=JvlZjDzoLcyEYkVOzAptDUtLhc4EYmZCUaQ/PncJGJo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gwSaH4z5zQEe0oLzCpZz0q0QWeFI7jwJjv+MruU+YxtT0v4LHdiU+6aZ1seFWDc/S
	 VCopgRY0OoilssTwQgXqyEwESGU69mjiUQeH+WLTXI8ryVtz70SORvZDxUEPKqe8+D
	 mCt2jjoHhR+gS1gPfk9R3rJa1A7SP0LhZOpy7tVwX9puN6Xmu/gStYzPzpzZGV75yZ
	 aqI8Qd4bjSLcYTUXPCIH6twbGTqYYuOIvF4WGTwvew7OTcmv7m4waxt72kOOHl5EzP
	 o+mbjlGOSSI9m0ngdPdNWVm0ibkjwnBqi9lJcap141oNjTUCRba8pKQCIq5i/7APBw
	 is9UUBVzPXB2w==
Date: Wed, 11 Sep 2024 14:02:41 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
	linux-arch@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	linux-kernel@vger.kernel.org, Nicolas Schier <nicolas@fjasle.eu>,
	linux-kbuild@vger.kernel.org
Subject: Re: [PATCH 1/3] btf: remove redundant CONFIG_BPF test in
 scripts/link-vmlinux.sh
Message-ID: <20240911210241.GA2305132@thelio-3990X>
References: <20240911110401.598586-1-masahiroy@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911110401.598586-1-masahiroy@kernel.org>

On Wed, Sep 11, 2024 at 08:03:56PM +0900, Masahiro Yamada wrote:
> CONFIG_DEBUG_INFO_BTF depends on CONFIG_BPF_SYSCALL, which in turn
> selects CONFIG_BPF.
> 
> When CONFIG_DEBUG_INFO_BTF=y, CONFIG_BPF=y is always met.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
> 
>  scripts/link-vmlinux.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index bd196944e350..cfffc41e20ed 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -288,7 +288,7 @@ strip_debug=
>  vmlinux_link vmlinux
>  
>  # fill in BTF IDs
> -if is_enabled CONFIG_DEBUG_INFO_BTF && is_enabled CONFIG_BPF; then
> +if is_enabled CONFIG_DEBUG_INFO_BTF; then
>  	info BTFIDS vmlinux
>  	${RESOLVE_BTFIDS} vmlinux
>  fi
> -- 
> 2.43.0
> 

