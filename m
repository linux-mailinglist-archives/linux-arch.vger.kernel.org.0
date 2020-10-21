Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5E41294BBE
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 13:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441981AbgJULZF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 07:25:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:39732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441960AbgJULYo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 07:24:44 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A51D21741;
        Wed, 21 Oct 2020 11:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603279479;
        bh=WDh7bCZH1qBW1gCrLs5xMuoDTOj6E3u3YgCvhYSsH4o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nf8FjzFzJPQaWW5gD4/Em4vXRbFwQOmVMpyb3u5HrvlEQD7aW8uJtA1tvA3x6nTep
         du8jduF+V621nopOmwZ0p2/0+BecB4mhYg+19eAT9XTzzGNm0PQVSr57SlhpzI/gC7
         fKFZM8sIciO8RXvbp8QQJN4c/17s3VBh64PxGzNU=
Date:   Wed, 21 Oct 2020 13:25:19 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
Message-ID: <20201021112519.GA1141598@kroah.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63fead90e91e08a1b173792b06995765@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
> On 2020-10-21 11:46, Qais Yousef wrote:
> > So that userspace can detect if the cpu has aarch32 support at EL0.
> > 
> > CPUREGS_ATTR_RO() was renamed to CPUREGS_RAW_ATTR_RO() to better reflect
> > what it does. And fixed to accept both u64 and u32 without causing the
> > printf to print out a warning about mismatched type. This was caught
> > while testing to check the new CPUREGS_USER_ATTR_RO().
> > 
> > The new CPUREGS_USER_ATTR_RO() exports a Sanitised or RAW sys_reg based
> > on a @cond to user space. The exported fields match the definition in
> > arm64_ftr_reg so that the content of a register exported via MRS and
> > sysfs are kept cohesive.
> > 
> > The @cond in our case is that the system is asymmetric aarch32 and the
> > controlling sysctl.enable_asym_32bit is enabled.
> > 
> > Update Documentation/arm64/cpu-feature-registers.rst to reflect the
> > newly visible EL0 field in ID_AA64FPR0_EL1.
> > 
> > Note that the MRS interface will still return the sanitized content
> > _only_.
> > 
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> > 
> > Example output. I was surprised that the 2nd field (bits[7:4]) is
> > printed out
> > although it's set as FTR_HIDDEN.
> > 
> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000011
> > 
> > # echo 1 > /proc/sys/kernel/enable_asym_32bit
> > 
> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
> > 0x0000000000000011
> > 0x0000000000000011
> > 0x0000000000000012
> > 0x0000000000000012
> > 0x0000000000000011
> > 0x0000000000000011
> 
> This looks like a terrible userspace interface.

It's also not allowed, sorry.  sysfs is "one value per file", which is
NOT what is happening at all.

This would be easy to see if there was a Documentation/ABI/ update,
which is also required, was that here?

thanks,

greg k-h
