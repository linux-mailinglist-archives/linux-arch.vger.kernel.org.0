Return-Path: <linux-arch+bounces-13149-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB8DB23CD4
	for <lists+linux-arch@lfdr.de>; Wed, 13 Aug 2025 01:59:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 745877A3536
	for <lists+linux-arch@lfdr.de>; Tue, 12 Aug 2025 23:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3AF62DE6F3;
	Tue, 12 Aug 2025 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PjYQXFJn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56C12E92C0;
	Tue, 12 Aug 2025 23:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755043134; cv=none; b=LJVRfPH7+7SdBQ9XpXeYcdQiN6oWuFcr2aHqKEsbKsJgEF4feo7sye9RtdsvbMTNZOC/zHYy6IpIpE6F5mkI43yclGkD32r9jodB/evNCu5z67V673hGCB9xRqzjg7yMdbNFah418epdSU3RZ2RfP4cL1lRwBwMse7VXRpHTECc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755043134; c=relaxed/simple;
	bh=6RTpC3D8LV0nbW7I0DLWD1vO3AMzBQzn+vJfUMCi94o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHw7/Chtc5p/IV67XofhT6JTNR0NNnAKT6CAJQfMLhppbWcHnbWR+PK0YKgHzE99OpWOSU3lZ0BA+agW+NW6hAJVcoLa2ml+VieIduG8z6rjIB7w1KgJFjwi2lZSquSoxa6TwfCO8SCH1lAuL2uquXgIQlGjCOE83tj8dYs0SpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PjYQXFJn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE5FC4CEF0;
	Tue, 12 Aug 2025 23:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755043133;
	bh=6RTpC3D8LV0nbW7I0DLWD1vO3AMzBQzn+vJfUMCi94o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PjYQXFJn9iKvqzwdnILDMBZyIZTff9TliAadgE1bYFKAEExQ3FeU3YpM/INxxjmCU
	 05p8dwY2uSWRGCNqHUMK92ufC/MBPD7sBw5MHZmGaD8Vm9uMO6guqfP6f9XU7UIEfW
	 wkbMKG235glKvSIMMn6QA7SgeJRmxUQsDJ/qWDE1nQuRtWnGA6A/iPxmzU/YmVax4w
	 Xw7waM9D6y3HIH9csD+/hIiD1wGxK2mViZF5K6znwuuCaWzjA3JuSS/M+8tZJIrDei
	 gafFgMny6fH9f6gmO4QfLdEBeKOs4UZs2jc1DShkGIGW+R5mzE5bQBmRwFXPZgOZ69
	 HBhRLx2n2sqBQ==
Date: Tue, 12 Aug 2025 23:58:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	lpieralisi@kernel.org, kw@linux.com, mani@kernel.org,
	robh@kernel.org, bhelgaas@google.com, arnd@arndb.de, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH v4 0/7] hyperv: Introduce new way to manage hypercall args
Message-ID: <aJvVO8d1JdK9mchO@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
References: <20250718045545.517620-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718045545.517620-1-mhklinux@outlook.com>

On Thu, Jul 17, 2025 at 09:55:38PM -0700, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
[...]
> 
> Michael Kelley (7):
>   Drivers: hv: Introduce hv_setup_*() functions for hypercall arguments
>   x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 1
>   x86/hyperv: Use hv_setup_*() to set up hypercall arguments -- part 2
>   Drivers: hv: Use hv_setup_*() to set up hypercall arguments
>   PCI: hv: Use hv_setup_*() to set up hypercall arguments
>   Drivers: hv: Use hv_setup_*() to set up hypercall arguments for mshv
>     code
>   Drivers: hv: Replace hyperv_pcpu_input/output_arg with hyperv_pcpu_arg

Queued for inclusion into hyperv-next. Thanks!

