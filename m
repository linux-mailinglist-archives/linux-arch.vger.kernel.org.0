Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBB0B19D5C3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 13:26:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgDCL0Q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 07:26:16 -0400
Received: from foss.arm.com ([217.140.110.172]:51928 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728022AbgDCL0P (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 3 Apr 2020 07:26:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6D737FA;
        Fri,  3 Apr 2020 04:26:14 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 916893F68F;
        Fri,  3 Apr 2020 04:26:12 -0700 (PDT)
Date:   Fri, 3 Apr 2020 12:26:10 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Kees Cook <keescook@chromium.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <20200403112609.GB26633@mbp>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
 <20200403005831.GI23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403005831.GI23230@ZenIV.linux.org.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Apr 03, 2020 at 01:58:31AM +0100, Al Viro wrote:
> On Thu, Apr 02, 2020 at 11:35:57AM -0700, Kees Cook wrote:
> > Yup, I think it's a weakness of the ARM implementation and I'd like to
> > not extend it further. AFAIK we should never nest, but I would not be
> > surprised at all if we did.
> > 
> > If we were looking at a design goal for all architectures, I'd like
> > to be doing what the public PaX patchset did for their memory access
> > switching, which is to alarm if calling into "enable" found the access
> > already enabled, etc. Such a condition would show an unexpected nesting
> > (like we've seen with similar constructs with set_fs() not getting reset
> > during an exception handler, etc etc).
> 
> FWIW, maybe I'm misreading the ARM uaccess logics, but... it smells like
> KERNEL_DS is somewhat more dangerous there than on e.g. x86.
> 
> Look: with CONFIG_CPU_DOMAINS, set_fs(KERNEL_DS) tells MMU to ignore
> per-page permission bits in DOMAIN_KERNEL (i.e. for kernel address
> ranges), allowing them even if they would normally be denied.  We need
> that for actual uaccess loads/stores, since those use insns that pretend
> to be done in user mode and we want them to access the kernel pages.
> But that affects the normal loads/stores as well; unless I'm misreading
> that code, it will ignore (supervisor) r/o on a page.  And that's not
> just for the code inside the uaccess blocks; *everything* done under
> KERNEL_DS is subject to that.

That's correct. Luckily this only affects ARMv5 and earlier. From ARMv6
onwards, CONFIG_CPU_USE_DOMAINS is no longer selected and the uaccess
instructions are just plain ldr/str.

Russell should know the details on whether there was much choice. Since
the kernel was living in the linear map with full rwx permissions, the
KERNEL_DS overriding was probably not a concern and the ldrt/strt for
uaccess deemed more secure. We also have weird permission setting
pre-ARMv6 (or rather v6k) where RO user pages are writable from the
kernel with standard str instructions (breaking CoW). I don't recall
whether it was a choice made by the kernel or something the architecture
enforced. The vectors page has to be kernel writable (and user RO) to
store the TLS value in the absence of a TLS register but maybe we could
do this via the linear alias together with the appropriate cache
maintenance.

From ARMv6, the domain overriding had the side-effect of ignoring the XN
bit and causing random instruction fetches from ioremap() areas. So we
had to remove the domain switching. We also gained a dedicated TLS
register.

> Why do we do that (modify_domain(), that is) inside set_fs() and not
> in uaccess_enable() et.al.?

I think uaccess_enable() could indeed switch the kernel domain if
KERNEL_DS is set and move this out of set_fs(). It would reduce the
window the kernel domain permissions are overridden. Anyway,
uaccess_enable() appeared much later on arm when Russell introduced PAN
(SMAP) like support by switching the user domain.

-- 
Catalin
