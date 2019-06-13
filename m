Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA28043B3A
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728117AbfFMP1O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:27:14 -0400
Received: from foss.arm.com ([217.140.110.172]:38718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729038AbfFMLhj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 07:37:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC6DC367;
        Thu, 13 Jun 2019 04:37:35 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B2D923F694;
        Thu, 13 Jun 2019 04:39:17 -0700 (PDT)
Date:   Thu, 13 Jun 2019 12:37:32 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kselftest@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Message-ID: <20190613113731.GY28398@e103592.cambridge.arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <20190612153538.GL28951@C02TF0J2HF1T.local>
 <141c740a-94c2-2243-b6d1-b44ffee43791@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <141c740a-94c2-2243-b6d1-b44ffee43791@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 13, 2019 at 11:15:34AM +0100, Vincenzo Frascino wrote:
> Hi Catalin,
> 
> On 12/06/2019 16:35, Catalin Marinas wrote:
> > Hi Vincenzo,
> > 
> > Some minor comments below but it looks fine to me overall. Cc'ing
> > Szabolcs as well since I'd like a view from the libc people.
> > 
> 
> Thanks for this, I saw Szabolcs comments.
> 
> > On Wed, Jun 12, 2019 at 03:21:10PM +0100, Vincenzo Frascino wrote:
> >> diff --git a/Documentation/arm64/tagged-address-abi.txt b/Documentation/arm64/tagged-address-abi.txt
> >> new file mode 100644
> >> index 000000000000..96e149e2c55c
> >> --- /dev/null
> >> +++ b/Documentation/arm64/tagged-address-abi.txt

[...]

> >> +Since it is not desirable to relax the ABI to allow tagged user addresses
> >> +into the kernel indiscriminately, arm64 provides a new sysctl interface
> >> +(/proc/sys/abi/tagged_addr) that is used to prevent the applications from
> >> +enabling the relaxed ABI and a new prctl() interface that can be used to
> >> +enable or disable the relaxed ABI.
> >> +
> >> +The sysctl is meant also for testing purposes in order to provide a simple
> >> +way for the userspace to verify the return error checking of the prctl()
> >> +command without having to reconfigure the kernel.
> >> +
> >> +The ABI properties are inherited by threads of the same application and
> >> +fork()'ed children but cleared when a new process is spawn (execve()).
> > 
> > "spawned".

I'd just say "cleared by execve()."

"Spawn" suggests (v)fork+exec to me (at least, what's what "spawn" means on
certain other OSes).

> > 
> > I guess you could drop these three paragraphs here and mention the
> > inheritance properties when introducing the prctl() below. You can also
> > mention the global sysctl switch after the prctl() was introduced.
> > 
> 
> I will move the last two (rewording them) to the _section_ 2, but I would still
> prefer the Introduction to give an overview of the solution as well.
> 
> >> +
> >> +2. ARM64 Tagged Address ABI
> >> +---------------------------
> >> +
> >> +From the kernel syscall interface prospective, we define, for the purposes
> >> +of this document, a "valid tagged pointer" as a pointer that either it has
> > 
> > "either has" (no 'it') sounds slightly better but I'm not a native
> > English speaker either.
> > 
> >> +a zero value set in the top byte or it has a non-zero value, it is in memory
> >> +ranges privately owned by a userspace process and it is obtained in one of
> >> +the following ways:
> >> +  - mmap() done by the process itself, where either:
> >> +    * flags = MAP_PRIVATE | MAP_ANONYMOUS
> >> +    * flags = MAP_PRIVATE and the file descriptor refers to a regular
> >> +      file or "/dev/zero"
> >> +  - a mapping below sbrk(0) done by the process itself
> >> +  - any memory mapped by the kernel in the process's address space during
> >> +    creation and following the restrictions presented above (i.e. data, bss,
> >> +    stack).
> >> +
> >> +The ARM64 Tagged Address ABI is an opt-in feature, and an application can
> >> +control it using the following prctl()s:
> >> +  - PR_SET_TAGGED_ADDR_CTRL: can be used to enable the Tagged Address ABI.
> > 
> > enable or disable (not sure we need the latter but it doesn't heart).
> > 
> > I'd add the arg2 description here as well.
> > 
> 
> Good point I missed this.
> 
> >> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
> >> +                             Address ABI.

For both prctls, you should also document the zeroed arguments up to
arg5 (unless we get rid of the enforcement and just ignore them).


Is there a canonical way to detect whether this whole API/ABI is
available?  (i.e., try to call this prctl / check for an HWCAP bit,
etc.)

[...]

Cheers
---Dave
