Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87019D48A
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 12:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgDCKDS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Apr 2020 06:03:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:59130 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgDCKDS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Apr 2020 06:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=yLhCR68Xx5hXytQdHGQlISjAF/TJxI6l40ZChrHYRsU=; b=doolofrtnnwkKzrDYH1z3uTz+
        Ga0SYykJLMFHS/skroRuv5Zpte0rMgHTC22elbzbJJkid/eQs9ERNRlQkP/Wj8QnOgEalVGFKMHYQ
        eOtTWbNewf52qneI28UDohL2SMl2Ypnfv+U56rxIo+n3dKpT9Gw0rB4VJOLRjnl+dUr2EAqyGFi3K
        DqcDI9N8CsDBZ64l9527i11cqv9kX3rDys+AK9QcDbwsirH7c0YJc2NuY7Knc4D6lMxEkAapq9Lh5
        JVJbgfHr4pFfxp5QtT4eXLJwY4ImacIlHVA1EHipja65a8hmeNELjKTyp1UKzpfZH7JCcFFHu3/BB
        PCWbI7QJA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:45070)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jKJAA-0008Rg-To; Fri, 03 Apr 2020 11:03:03 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jKJA9-0002Zz-E3; Fri, 03 Apr 2020 11:02:57 +0100
Date:   Fri, 3 Apr 2020 11:02:57 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Kees Cook <keescook@chromium.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <20200403100257.GB25745@shell.armlinux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004021132.813F8E88@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 11:35:57AM -0700, Kees Cook wrote:
> On Thu, Apr 02, 2020 at 06:50:32PM +0100, Al Viro wrote:
> > On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> > 
> > > user_access_begin() grants both read and write.
> > > 
> > > This patch adds user_read_access_begin() and user_write_access_begin() but
> > > it doesn't remove user_access_begin()
> > 
> > Ouch...  So the most generic name is for the rarest case?
> >  
> > > > What should we do about that?  Do we prohibit such blocks outside
> > > > of arch?
> > > > 
> > > > What should we do about arm and s390?  There we want a cookie passed
> > > > from beginning of block to its end; should that be a return value?
> > > 
> > > That was the way I implemented it in January, see
> > > https://patchwork.ozlabs.org/patch/1227926/
> > > 
> > > There was some discussion around that and most noticeable was:
> > > 
> > > H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> > > a "key" variable: it's a direct attack vector for a crowbar attack,
> > > especially since it is by definition live inside a user access region."
> > 
> > > This patch minimises the change by just adding user_read_access_begin() and
> > > user_write_access_begin() keeping the same parameters as the existing
> > > user_access_begin().
> > 
> > Umm...  What about the arm situation?  The same concerns would apply there,
> > wouldn't they?  Currently we have
> > static __always_inline unsigned int uaccess_save_and_enable(void)
> > {
> > #ifdef CONFIG_CPU_SW_DOMAIN_PAN
> >         unsigned int old_domain = get_domain();
> > 
> >         /* Set the current domain access to permit user accesses */
> >         set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
> >                    domain_val(DOMAIN_USER, DOMAIN_CLIENT));
> > 
> >         return old_domain;
> > #else
> >         return 0;
> > #endif
> > }
> > and
> > static __always_inline void uaccess_restore(unsigned int flags)
> > {
> > #ifdef CONFIG_CPU_SW_DOMAIN_PAN
> >         /* Restore the user access mask */
> >         set_domain(flags);
> > #endif
> > }
> > 
> > How much do we need nesting on those, anyway?  rmk?

It's that way because it's easy, logical, and actually *more* efficient
to do it that way, rather than read-modify-write the domain register
each time we want to change it.

> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.

There is one known nesting, which is __clear_user() when used with
the (IMHO horrid and I don't care about) UACCESS_WITH_MEMCPY feature.
That's not intentional however.

When I introduced this on ARM, the placement I adopted was to locate
it _as close as sanely possible_ to the userspace access so we
minimised the kernel accesses, so we minimise the number of accesses
that could go stray because of the domain issue - we ideally only
want the access done by the accessor itself to be affected, which
we achieve for most accesses.

Thinking laterally, maybe we should get rid of the whole KERNEL_DS
stuff entirely, and come up with an alternative way of handling the
kernel-wants-to-access-kernelspace-via-user-accessors problem.
Such as, copying some data back to userspace memory?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
