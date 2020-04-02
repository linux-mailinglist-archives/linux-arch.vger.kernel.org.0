Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3147219C857
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 19:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388452AbgDBRux (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 13:50:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49726 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727439AbgDBRux (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 13:50:53 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK3z6-008rAv-W9; Thu, 02 Apr 2020 17:50:33 +0000
Date:   Thu, 2 Apr 2020 18:50:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, airlied@linux.ie,
        daniel@ffwll.ch, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, keescook@chromium.org, hpa@zytor.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH RESEND 1/4] uaccess: Add user_read_access_begin/end and
 user_write_access_begin/end
Message-ID: <20200402175032.GH23230@ZenIV.linux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:

> user_access_begin() grants both read and write.
> 
> This patch adds user_read_access_begin() and user_write_access_begin() but
> it doesn't remove user_access_begin()

Ouch...  So the most generic name is for the rarest case?
 
> > What should we do about that?  Do we prohibit such blocks outside
> > of arch?
> > 
> > What should we do about arm and s390?  There we want a cookie passed
> > from beginning of block to its end; should that be a return value?
> 
> That was the way I implemented it in January, see
> https://patchwork.ozlabs.org/patch/1227926/
> 
> There was some discussion around that and most noticeable was:
> 
> H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> a "key" variable: it's a direct attack vector for a crowbar attack,
> especially since it is by definition live inside a user access region."

> This patch minimises the change by just adding user_read_access_begin() and
> user_write_access_begin() keeping the same parameters as the existing
> user_access_begin().

Umm...  What about the arm situation?  The same concerns would apply there,
wouldn't they?  Currently we have
static __always_inline unsigned int uaccess_save_and_enable(void)
{
#ifdef CONFIG_CPU_SW_DOMAIN_PAN
        unsigned int old_domain = get_domain();

        /* Set the current domain access to permit user accesses */
        set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
                   domain_val(DOMAIN_USER, DOMAIN_CLIENT));

        return old_domain;
#else
        return 0;
#endif
}
and
static __always_inline void uaccess_restore(unsigned int flags)
{
#ifdef CONFIG_CPU_SW_DOMAIN_PAN
        /* Restore the user access mask */
        set_domain(flags);
#endif
}

How much do we need nesting on those, anyway?  rmk?
