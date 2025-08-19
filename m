Return-Path: <linux-arch+bounces-13197-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E1DB2C9F4
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 18:46:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A67F3A8739
	for <lists+linux-arch@lfdr.de>; Tue, 19 Aug 2025 16:46:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9BCA283C87;
	Tue, 19 Aug 2025 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YL2kvj6J"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E21DED77;
	Tue, 19 Aug 2025 16:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755621986; cv=none; b=GZ7x0/R+3jvnr2D4N/xuUwgng1jFsPfOZKbq9s8A5iBG6NPY6rCYytplXwR516d9IsaZ10BTPJcCkyWvo/bFZweoNZtjwXN7VdKsXwdqMVlhJpVEtsgOKEikqNBwX+ajgP6Iq7iX5nD0rPazSWdk+uFNYB8hE3cMo16k/tywXJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755621986; c=relaxed/simple;
	bh=yh2PFqf5Sk00+ThxXGSU+4QCnMOX5dgtPjsvCKTMeK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CkLLU3Fsfh6nrA23VIxjYZuWbKP4UUeoqDMFeeDNjP6VO/0hvnKLOv8OOtc//hf9AK3O5knH+ColobtjTmmQeptH7Y3rmX55AsGBCxm6Hc4R5yK/XOtPBO5sJzFZ0FPL4opQ5G8I0dOL9htzxMbiJVRuqH5tO8TBOCrXShMVF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YL2kvj6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F04B8C4CEF1;
	Tue, 19 Aug 2025 16:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755621985;
	bh=yh2PFqf5Sk00+ThxXGSU+4QCnMOX5dgtPjsvCKTMeK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YL2kvj6JzQF0ReZG3uUUUxqvzr0QV2AwBBEpAoQA8zCH/jxzjDJwCFxwnjKKy86mu
	 l3FWCX28l+yMN4P/euMAmwautQT5a15fNUpb5XXS6S48wrtfAcP7ei0MBe5Ev78gvU
	 PSDf3tb6XBlVWYdtNyQwt497BLCBdyyZUu0jnvz0/C1mFmP3m1q+bWhH0FMlICF/R/
	 HuO1Mj/sEsYVAHpUJCpJaXQkpNmdJuKm0HK565IpgzLQExWfHKJw4Ble3JM6Mpqfit
	 MIZJ1UcI/c9B4cAD7k/XioQfjj5KRQE4HJqyMLm10jyNqveNbwEqSB9qyNbmogMozd
	 PdNL2B53wav/Q==
Date: Tue, 19 Aug 2025 16:46:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
	decui@microsoft.com, arnd@arndb.de
Subject: Re: [PATCH] mshv: Add support for a new parent partition
 configuration
Message-ID: <aKSqX_H9QVVR02pc@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1755588559-29629-1-git-send-email-nunodasneves@linux.microsoft.com>

On Tue, Aug 19, 2025 at 12:29:19AM -0700, Nuno Das Neves wrote:
> Detect booting as an "L1VH" partition. This is a new scenario very
> similar to root partition where the mshv_root driver can be used to
> create and manage guest partitions.
> 
> It mostly works the same as root partition, but there are some
> differences in how various features are handled. hv_l1vh_partition()
> is introduced to handle these cases. Add hv_parent_partition()
> which returns true for either case, replacing some hv_root_partition()
> checks.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

