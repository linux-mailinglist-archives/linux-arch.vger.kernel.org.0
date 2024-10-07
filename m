Return-Path: <linux-arch+bounces-7775-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50898993328
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 18:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D06EEB259E2
	for <lists+linux-arch@lfdr.de>; Mon,  7 Oct 2024 16:27:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316501DACB0;
	Mon,  7 Oct 2024 16:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="prkcmbst"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4551DA62C;
	Mon,  7 Oct 2024 16:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728318421; cv=none; b=L2SCAuhbM6mJfc7iRDL2Yz7moJmaTrTzTeypMRxdSxjTreGdfxxLMKMLnFvDt9HElZAJ+7x0l6oIv9yVPdIXzDfS7ev5YEFVxnNqYAyHwHkQMfljoZEc99xqK75G4Nok8xf8unh964Oh/pGSL+n2wPzheNTlWhIob7sWEbiIczc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728318421; c=relaxed/simple;
	bh=E51cAw039sGKO+0n/PcKNXG85+KvGPhgm7rZPbowDhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R+wzwdsMJKo5aew/S/iZuziI7/qmpuNZfq5K+koKjgrRcKiFXbmnVtbRwoHVra/OTQ4nr2LrWG7CLIamwk6Q+h+/Nt6GO2mC6+7YZx50YhS1gc5kNmDIfKUSdKA9WwhKstd1Pp4uifNQ78/ViPA1/I9eFYtH0RT2EzAKolxbMvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=prkcmbst; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC26C4CEC6;
	Mon,  7 Oct 2024 16:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728318420;
	bh=E51cAw039sGKO+0n/PcKNXG85+KvGPhgm7rZPbowDhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=prkcmbst67g+qeppLZY5cSVTDa3n32T/+3uU7wIq06HUNtdZFyrXgklHYcK5XIjsB
	 L1RDbZZHtA+yh5o5XbvvoYxgq931+zMKcIWrBDT5Ug4yEupCoZW7lcJqNizCnHcTqj
	 fAkpw+0aRZgjk6c25adVWYjyWVE2c4IWFHSG9VMHOXLH6D8jDWYeM6PDyFV+TJUIsA
	 0HLYXd0snULKB5HaW14eiMVwpD8NuTgXQ5SNNbsuLixgBKkllSFlbcHZLwyZzqwBnE
	 xgFvVXlkeSQZLmH53i7KOloLnV0ssdyUm6UV4ybHgx+9mbsnCUQYZTrJatT6jds/ca
	 at+j8gKEIudHg==
Date: Mon, 7 Oct 2024 16:26:58 +0000
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
Subject: Re: [PATCH 0/5] Add new headers for Hyper-V Dom0
Message-ID: <ZwQL0v-VE4q3iXAt@liuwe-devbox-debian-v2>
References: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1727985064-18362-1-git-send-email-nunodasneves@linux.microsoft.com>

On Thu, Oct 03, 2024 at 12:50:59PM -0700, Nuno Das Neves wrote:
> To support Hyper-V Dom0 (aka Linux as root partition), many new
> definitions are required.
> 
> The plan going forward is to directly import headers from
> Hyper-V. This is a more maintainable way to import definitions
> rather than via the TLFS doc. This patch series introduces
> new headers (hvhdk.h, hvgdk.h, etc, see patch #3) directly
> derived from Hyper-V code.
> 
> This patch series replaces hyperv-tlfs.h with hvhdk.h, but only
> in Microsoft-maintained Hyper-V code where they are needed. This
> leaves the existing hyperv-tlfs.h in use elsewhere - notably for
> Hyper-V enlightenments on KVM guests.

It goes without saying that we need to make sure KVM still builds
correctly after this series. Please make sure to test that. Thanks.

Wei.

