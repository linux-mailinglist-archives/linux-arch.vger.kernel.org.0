Return-Path: <linux-arch+bounces-9297-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CB69E7EB6
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 08:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BCCB16B2A0
	for <lists+linux-arch@lfdr.de>; Sat,  7 Dec 2024 07:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485E813211A;
	Sat,  7 Dec 2024 07:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZsL4aZN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18449381AF;
	Sat,  7 Dec 2024 07:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733557003; cv=none; b=mDpGTtQbu7p22T8FdBFN+lHlu4iZMYf/hFI6AA/XomITlHNpxMZOJRd2C9DLIdmwmhtyV6yPhNzdSvYsONRCTKB+VPgvSYUW1l16wSPowFHAzto0yfr6bE5lNyvQqot023X3seZU3hFbg86hNtRbAKkP+YDb/j+wGY7D/A4k4FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733557003; c=relaxed/simple;
	bh=9TX1vg/RCNPSqIDVVM5Oj3VMUTV+rCQORNzKqYqLZQI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I6qti3Wjsa4HF4TcRaLjcXLR3Co8/dJp+G+gl+eJwdqu7DY72dcmZ0CLF8MGJ2EmbEvX2vBQiEw3HuBtgiO/0GfVGIQldXxg1oaeO7HhCW+swcSlvZ8wC2p31JF/VnEYj+1q/ovRSAbN7soe3EAQ3vYV0H4581ezqpRcU8QQA8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZsL4aZN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6EEC4CECD;
	Sat,  7 Dec 2024 07:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733557002;
	bh=9TX1vg/RCNPSqIDVVM5Oj3VMUTV+rCQORNzKqYqLZQI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZsL4aZNcsLObtU/CTsMaLemEfFflFyEBnYTOoFR85zpTuHUuuxn27wNiYjep+oog
	 aTSN1WoRFWQEKiDg3nkCH0F7v3Wta0pppeM9IpPWwA5S389yAHUzOwtnbFNASgE5+3
	 +uK0cVQi/xZzdhBu8zPxX7j0B4n9J31TQj6Rt5CJz4dL8zQMU2zuYxZC+Zij0AuCp0
	 apRJsmTd4Q/r3RzvKeWx7Tl0tEZlQXRunI3qb4yLMcyCbk3UlQx4b//OPbvWPeKqlH
	 SxglF7ykGTPTsYbcsQM/OC8CdaisQRTLldWEhoflSQUGYN/6HByctPhoKCpBBjPTp6
	 f9RpD2MEAaFbQ==
Date: Sat, 7 Dec 2024 07:36:40 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	mhklinux@outlook.com, decui@microsoft.com, catalin.marinas@arm.com,
	will@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	arnd@arndb.de, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: Re: [PATCH 2/2] hyperv: Move create_vp and deposit_pages hvcalls to
 hv_common.c
Message-ID: <Z1P7CJ4Inz97feff@liuwe-devbox-debian-v2>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1733523707-15954-3-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1733523707-15954-3-git-send-email-nunodasneves@linux.microsoft.com>

On Fri, Dec 06, 2024 at 02:21:47PM -0800, Nuno Das Neves wrote:
> From: Nuno Das Neves <nudasnev@microsoft.com>
> 
> These are not specific to x86_64 and will be needed by common code.
> 
> Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

