Return-Path: <linux-arch+bounces-7773-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA8E99330A
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:24:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 50CF21C22AE5
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41C01DA617;
	Mon,  7 Oct 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfy7teQI"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB431D9673;
	Mon,  7 Oct 2024 16:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318275; cv=none; b=WIs0mge/C3nPa7xrDEbdl7+qMrepvMj7DrZjkvX+erUB1+kRPdHNBTnvJBTRbxga8wD9KRMggCnHrvYBmS0lsnKJgmkO4wdP3MH3GoGDqvp5nPf3qDvN8twt+CyX4J8kppLPeXFwN57O1G61lR/ppqzcugq7zxTQQQh2+z1APRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318275; c=relaxed/simple;
	bh=a1JcLU++PvMGNCFUsJszByLFmsc1C6lg9yb+qFhNTIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tco4IP4dEFwVKq/rz/+1jRgdJdmczdCHrbp3nBrti+Ks080NFDMX9SJqs5mSRTvEmPTtFXylbZu2aB4cs9Zf3ZCown6MzfkoPU7WcrD2+EBFFHywlBwQaqoX802qeXdSwfJTaOt8aRdf2i4dnoIAbd4gFoYVBjZNUmGL6pWAs6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfy7teQI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 887BCC4CEC6;
	Mon,  7 Oct 2024 16:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318275;
	bh=a1JcLU++PvMGNCFUsJszByLFmsc1C6lg9yb+qFhNTIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sfy7teQIhL5ygBPO9PvspMwimRGwdpZ1TGqKnJT7wrjecPOi0JTBG0JoNQ407KWNi
	 1/9TAUpMJ4kknT6N47+WSLhJ8UGJaPuhuIpc7ZG72mWUWJBGt75M6LwRBvZd3dypqt
	 iVVuZghjowTmeKAiVDgay89vawOw5q7cEetFkI1sM+h+oQfIHPr6ZdxGHU6hJeVCpJ
	 ZD4QR45si63t/cr9VobO+78lHilJTxfHvKE4mUlKTGGAZeykGjL6mZgg1KO75hYn4D
	 lL17Q7+9fFI2vUBCpugg5Ih5lKgpdGqjh9JYxHx7tUWomV0KFDSqSUSq7VhjikUvPi
	 KiSzqOyCYjHwg==
Date: Mon, 7 Oct 2024 16:24:33 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org,
	virtualization@lists.linux.dev, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	catalin.marinas@arm.com, will@kernel.org, luto@kernel.org,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	seanjc@google.com, pbonzini@redhat.com, peterz@infradead.org,
	daniel.lezcano@linaro.org, joro@8bytes.org, robin.murphy@arm.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de,
	sgarzare@redhat.com, jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com, skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: Re: [PATCH 1/5] hyperv: Move hv_connection_id to hyperv-tlfs.h
Message-ID: <ZwQLQX-S-zSB5yZE@liuwe-devbox-debian-v2>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1727985064-18362-2-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-2-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Oct 03, 2024 at 12:51:00PM -0700, Nuno Das Neves wrote:
> This definition is in the wrong file; it is part of the TLFS doc.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

