Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC82294BC4
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 13:26:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439428AbgJUL0R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 07:26:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439351AbgJUL0R (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 07:26:17 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2BE1C21741;
        Wed, 21 Oct 2020 11:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603279576;
        bh=VXtH8gX2MQuBeBFSIfYu/3zWvbmK40hrN2v57eUoa8A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hcl5x8aaA3tCxlJNW7prkjkUgiZXeSY4LpWNXZY5f/h6bLH4cW8dlqW61aZwME7kh
         dHyNMxBLE3iXuo+DkwczVXSTWI9y8IfyPutP511lduH4gk/xUWw5N8/9g47c1oScuj
         LXCRIavplSAugm82IANJDNBwhcJm/3JuNv8SwnSM=
Date:   Wed, 21 Oct 2020 13:26:56 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 0/4] Add support for Asymmetric AArch32 systems
Message-ID: <20201021112656.GB1141598@kroah.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021104611.2744565-1-qais.yousef@arm.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 11:46:07AM +0100, Qais Yousef wrote:
> This series adds basic support for Asymmetric AArch32 systems. Full rationale
> is in v1's cover letter.
> 
> 	https://lore.kernel.org/linux-arch/20201008181641.32767-1-qais.yousef@arm.com/

That is not good, provide full rational in each place, not everyone has
web access at all time.

Also, you forgot to document this in Documentation/ABI/ like is required
for sysfs files, and I thought I asked for last time.

> Changes in v2:
> 
> 	* We now reset vcpu->arch.target to force re-initialized for KVM patch.
> 	  (Marc)
> 
> 	* Fix a bug where this_cpu_has_cap() must be called with preemption
> 	  disabled in check_aarch32_cpumask().
> 
> 	* Add new sysctl.enable_asym_32bit. (Catalin)
> 
> 	* Export id_aar64fpr0 register in sysfs which allows user space to
> 	  discover which cpus support 32bit@EL0. The sysctl must be enabled for
> 	  the user space to discover the asymmetry. (Will/Catalin)
> 
> 	* Fixing up affinity in the kernel approach was dropped. The support
> 	  assumes the user space that wants to enable this support knows how to
> 	  guarantee correct affinities for 32bit apps by using cpusets.

I asked you to work with Intel to come up with an agreement of how this
is going to be represented in userspace.  Why did you not do that?

Without even looking at the patch set, this is not ok...

greg k-h
