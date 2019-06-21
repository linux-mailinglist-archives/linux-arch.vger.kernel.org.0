Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC24EBB8
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 17:17:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbfFUPQq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 11:16:46 -0400
Received: from foss.arm.com ([217.140.110.172]:34340 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfFUPQp (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 11:16:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C4CF5344;
        Fri, 21 Jun 2019 08:16:44 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 558C63F575;
        Fri, 21 Jun 2019 08:16:43 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:16:41 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Kevin Brodsky <kevin.brodsky@arm.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v5 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Message-ID: <20190621151640.GI18954@arrakis.emea.arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190613155137.47675-1-vincenzo.frascino@arm.com>
 <20190613155137.47675-2-vincenzo.frascino@arm.com>
 <1c55a610-9aa5-4675-f7de-79a1661a660d@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1c55a610-9aa5-4675-f7de-79a1661a660d@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 18, 2019 at 02:13:01PM +0100, Kevin Brodsky wrote:
> On 13/06/2019 16:51, Vincenzo Frascino wrote:
> > +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
> > +control it using the following:
> > + - /proc/sys/abi/tagged_addr: a new sysctl interface that can be used to
> > +        prevent the applications from enabling the relaxed ABI.
> > +        The sysctl is meant also for testing purposes in order to provide a
> > +        simple way for the userspace to verify the return error checking of
> > +        the prctl() commands without having to reconfigure the kernel.
> > +        The sysctl supports the following configuration options:
> > +         - 0: Disable ARM64 Tagged Address ABI for all the applications.
> > +         - 1 (Default): Enable ARM64 Tagged Address ABI for all the
> > +                        applications.
> 
> I find this very confusing, because it suggests that the default value of
> PR_GET_TAGGED_ADDR_CTRL for new processes will be set to the value of this
> sysctl, when in fact this sysctl is about restricting the *availability* of
> the new ABI. Instead of disabling the ABI, I would talk about disabling
> access to the new ABI here.

This bullet point needs to be re-written. The sysctl is meant to disable
opting in to the ABI. I'd also drop the "meant for testing" part. I put
it in my commit log as justification but I don't think it should be part
of the ABI document.

> > + - prctl()s:
> > +  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable or disable the Tagged
> > +        Address ABI.
> > +        The (unsigned int) arg2 argument is a bit mask describing the
> > +        control mode used:
> > +          - PR_TAGGED_ADDR_ENABLE: Enable ARM64 Tagged Address ABI.
> > +        The arguments arg3, arg4, and arg5 are ignored.
> 
> Have we definitely decided that arg{3,4,5} are ignored? Catalin?

I don't have a strong preference either way. If it's simpler for the
user to ignore them, fine by me. I can see in the current prctl commands
a mix if ignore vs forced zero.

> > +the ABI guarantees the following behaviours:
> > +
> > +  - Every current or newly introduced syscall can accept any valid tagged
> > +    pointers.
> "pointer". Also, is it really useful to talk about newly introduced syscall?
> New from which point of view?

I think we should drop this guarantee. It would have made sense if we
allowed tagged pointers everywhere but we already have some exceptions.

> > +3. ARM64 Tagged Address ABI Exceptions
> > +--------------------------------------
> > +
> > +The behaviours described in section 2, with particular reference to the
> > +acceptance by the syscalls of any valid tagged pointer are not applicable
> > +to the following cases:
> > +  - mmap() addr parameter.
> > +  - mremap() new_address parameter.
> > +  - prctl_set_mm() struct prctl_map fields.
> > +  - prctl_set_mm_map() struct prctl_map fields.
> 
> prctl_set_mm() and prctl_set_mm_map() are internal kernel functions, not
> syscall names. IIUC, we don't want to allow any address field settable via
> the PR_SET_MM prctl() to be tagged. Catalin, is that correct? I think this
> needs rephrasing.

I fully agree. It should talk about PR_SET_MM, PR_SET_MM_MAP,
PR_SET_MM_MAP_SIZE.

-- 
Catalin
