Return-Path: <linux-arch+bounces-6926-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44442968BF7
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 18:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7DB283B67
	for <lists+linux-arch@lfdr.de>; Mon,  2 Sep 2024 16:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C4C1A2627;
	Mon,  2 Sep 2024 16:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QUg6Z9hL"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072B2184550;
	Mon,  2 Sep 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725294153; cv=none; b=N0T8Lz2vNTddSdrZm8OHax5DCq1lDlDyFMI2vZ3DafYWIm/3kSAkXEpMFyWW9tz5dnR9NYBJsRW9/uQjlGwGsBE5OvpzvFMLBG+yCA8vSHADMaKJTB6DQ0CRjZBH9zsnHf2CjAKliIOzmiMvX3c4CbLj8fwl9s+ubHlHdOKLLyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725294153; c=relaxed/simple;
	bh=nvtTT8MoZrQTrKx7+op2Iok0h+eSZyy0JcWDhBE7fpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p05LGyfXAYF7NAF8BZRebB3OwS7ehfcNvhFP6nyx+A9FnPvzP15F/FYt59uB8NNp+aie71dA1/WXxPWbb2wvniN1X/u/Ulb4DbfySIFFXkhUSGPKYz06iEuo84MiHHi35aLgc8iScggiFcg7/cd09v8ylPqmVnJLlGsYr2yFCUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=QUg6Z9hL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07825C4CEC2;
	Mon,  2 Sep 2024 16:22:30 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="QUg6Z9hL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1725294149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7i7LatTMW246JEJqRynJBbfB0SkUZFOwib4oxE48Geg=;
	b=QUg6Z9hL27aiUmTAkq3svL9FYC9HUyvPV/heAXm/2S/5JYWBUpi/gBjm4wCNeaq//ekSsE
	HjrwO9l9KNNBLqZ+lZixt52Wewl9GX0oxmHqJkE+Xj6ERul7OczmAa5Ghd/TR5ErZfXi4w
	pK41Uyx6LH65g6RQ0G5WQK7m2TY2J8Q=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0e5eae3f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 2 Sep 2024 16:22:28 +0000 (UTC)
Date: Mon, 2 Sep 2024 18:22:24 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Adhemerval Zanella <adhemerval.zanella@linaro.org>
Cc: Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	Eric Biggers <ebiggers@kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	mark.rutland@arm.com
Subject: Re: [PATCH v4 0/2] arm64: Implement getrandom() in vDSO
Message-ID: <ZtXmQJx7wCA4fasq@zx2c4.com>
References: <20240902161912.2751-1-adhemerval.zanella@linaro.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240902161912.2751-1-adhemerval.zanella@linaro.org>

On Mon, Sep 02, 2024 at 04:15:45PM +0000, Adhemerval Zanella wrote:
> Implement stack-less ChaCha20 and wire it with the generic vDSO
> getrandom code.  The first patch is Mark's fix to the alternatives
> system in the vDSO, while the the second is the actual vDSO work.
> 
> Changes from v3:
> - Use alternative_has_cap_likely instead of ALTERNATIVE.

It also has the discussed header/include and comment fixups.

But anyway, this series of two looks fine to me, and I'll gladly queue
it up, pending Will/Catalin's ack on it.

Thanks for working on this.

Jason

