Return-Path: <linux-arch+bounces-11289-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80B88A7C37E
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 21:04:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA0F2172911
	for <lists+linux-arch@lfdr.de>; Fri,  4 Apr 2025 19:03:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51223221736;
	Fri,  4 Apr 2025 19:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rMl7Kp0X"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2102722172E;
	Fri,  4 Apr 2025 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743793345; cv=none; b=BrZXFK4nEETaWeakPSzMf7cNVmD/+MBnKfjRP+j5zt0qoWPOw4oENoUtBiGrn0CIsDM/2EqNLBPsuFgga2riFFdzr66l6at6lH0kEZHGfKM+EEuUrW6Qaib83mA8Fnj51EYswB/WfYbZvP9Fyg9GDgvlVpPz6KG8u/fVW815Ws8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743793345; c=relaxed/simple;
	bh=40xI+9lkg/jtr0bGZm9jDigJflmRnKOMqz5P6zqYwV0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApOy9qy/woOXtgOwQJm/UcwnpVN1HuaXpN3Ex/O9QZPHJ3AxPDsYHz6s+IPor4hnMdzrsexY2wXrnQJX4qSmLltnXLFVZF43KGvCEHOBSOd+gRknd86t5+aDQoyPYvJzkIBCztRWrwXYYW/Y5c7y1q6M8uc7XkeU1cHccG8V63g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rMl7Kp0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 611F9C4CEDD;
	Fri,  4 Apr 2025 19:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743793344;
	bh=40xI+9lkg/jtr0bGZm9jDigJflmRnKOMqz5P6zqYwV0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rMl7Kp0XcTL/wiIcBVrN0I4Oed82UnINZTwMVg27SPzD83y0PDgX2ntHFrdjJ83Gj
	 nDr7acKqleK/+kxtuE8ENlbkfK3lt5wSedSDhaZ9vNOBS/Px5HaNpEbm0sIVCJ00q5
	 QDV0U+RsrmXR39Fyeo+qQnmmDYJQS1ijuQYfJ0TsoKP0rAsZOrKmvOddis1I1/D42a
	 7oE6tyiqqpiCVS7uNlHcVurt1XSYbwINaKhOzRj0JoXT7DPaXRDI7AQE1EbHc4hcFq
	 7iLxi2JxLOJ6kR9kbm83ajwvnZjH2ncJTfJveh03QEcWiZNLoyJbeIRjPltgllJ20M
	 4FWSIRKQXyUTg==
Date: Fri, 4 Apr 2025 12:02:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 6/7] lib/crc: document all the CRC library kconfig options
Message-ID: <20250404190222.GA1622@sol.localdomain>
References: <20250401221600.24878-1-ebiggers@kernel.org>
 <20250401221600.24878-7-ebiggers@kernel.org>
 <Z--aPZDWPiW05FNS@infradead.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--aPZDWPiW05FNS@infradead.org>

On Fri, Apr 04, 2025 at 01:37:17AM -0700, Christoph Hellwig wrote:
> On Tue, Apr 01, 2025 at 03:15:59PM -0700, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Previous commits removed all the original CRC kconfig help text, since
> > it was oriented towards people configuring the kernel, and the options
> > are no longer user-selectable.  However, it's still useful for there to
> > be help text for kernel developers.  Add this.
> 
> I usually document hidden options using comments instead of the help
> text to clearly distinguish them for visible options.  Not sure if there
> is a general preference either way, I just through I'd drop this here.

Using comments makes sense to me.  But on past patches affecting hidden options,
I've had people ask for help text specifically.  It also looks like help text is
more common than comments, even considering just hidden options.  So I think
I'll keep this patch as-is.

- Eric

