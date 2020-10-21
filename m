Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1CAD294BED
	for <lists+linux-arch@lfdr.de>; Wed, 21 Oct 2020 13:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439618AbgJULqt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 21 Oct 2020 07:46:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:45860 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439424AbgJULqt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 21 Oct 2020 07:46:49 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 357E420872;
        Wed, 21 Oct 2020 11:46:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603280808;
        bh=IhP3lyZ+WexWHr1Jj7OA4j41IvkQjIuh6wB9vNIGhG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A5oV5RmunEhFglW3z4WYM4Cc5Nz73CzljoG7RMly1y/41CIKWcs+c9ChNO7fCdA1A
         eqrE6puPsHu7JK38xVqm4IGLdnQVQ3RzHn4mz/LRUb2+AhNuBI6B0kbt6lEsk+J8Au
         01oes8V2r/p5FfTOOkNZo8QHJMdZVJHFFObRCdgE=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kVCZq-0031WL-7q; Wed, 21 Oct 2020 12:46:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 21 Oct 2020 12:46:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        James Morse <james.morse@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/4] arm64: Export id_aar64fpr0 via sysfs
In-Reply-To: <20201021112519.GA1141598@kroah.com>
References: <20201021104611.2744565-1-qais.yousef@arm.com>
 <20201021104611.2744565-5-qais.yousef@arm.com>
 <63fead90e91e08a1b173792b06995765@kernel.org>
 <20201021112519.GA1141598@kroah.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <a534ade95315a55c4ab3048727d846a1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: gregkh@linuxfoundation.org, qais.yousef@arm.com, catalin.marinas@arm.com, will@kernel.org, peterz@infradead.org, morten.rasmussen@arm.com, torvalds@linux-foundation.org, james.morse@arm.com, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2020-10-21 12:25, Greg Kroah-Hartman wrote:
> On Wed, Oct 21, 2020 at 12:09:58PM +0100, Marc Zyngier wrote:
>> On 2020-10-21 11:46, Qais Yousef wrote:
>> > So that userspace can detect if the cpu has aarch32 support at EL0.
>> >
>> > CPUREGS_ATTR_RO() was renamed to CPUREGS_RAW_ATTR_RO() to better reflect
>> > what it does. And fixed to accept both u64 and u32 without causing the
>> > printf to print out a warning about mismatched type. This was caught
>> > while testing to check the new CPUREGS_USER_ATTR_RO().
>> >
>> > The new CPUREGS_USER_ATTR_RO() exports a Sanitised or RAW sys_reg based
>> > on a @cond to user space. The exported fields match the definition in
>> > arm64_ftr_reg so that the content of a register exported via MRS and
>> > sysfs are kept cohesive.
>> >
>> > The @cond in our case is that the system is asymmetric aarch32 and the
>> > controlling sysctl.enable_asym_32bit is enabled.
>> >
>> > Update Documentation/arm64/cpu-feature-registers.rst to reflect the
>> > newly visible EL0 field in ID_AA64FPR0_EL1.
>> >
>> > Note that the MRS interface will still return the sanitized content
>> > _only_.
>> >
>> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
>> > ---
>> >
>> > Example output. I was surprised that the 2nd field (bits[7:4]) is
>> > printed out
>> > although it's set as FTR_HIDDEN.
>> >
>> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
>> > 0x0000000000000011
>> > 0x0000000000000011
>> > 0x0000000000000011
>> > 0x0000000000000011
>> > 0x0000000000000011
>> > 0x0000000000000011
>> >
>> > # echo 1 > /proc/sys/kernel/enable_asym_32bit
>> >
>> > # cat /sys/devices/system/cpu/cpu*/regs/identification/id_aa64pfr0
>> > 0x0000000000000011
>> > 0x0000000000000011
>> > 0x0000000000000012
>> > 0x0000000000000012
>> > 0x0000000000000011
>> > 0x0000000000000011
>> 
>> This looks like a terrible userspace interface.
> 
> It's also not allowed, sorry.  sysfs is "one value per file", which is
> NOT what is happening at all.

I *think* Qais got that part right, though it is hard to tell without
knowing how many CPUs this system has (cpu/cpu* is ambiguous).

         M.
-- 
Jazz is not dead. It just smells funny...
