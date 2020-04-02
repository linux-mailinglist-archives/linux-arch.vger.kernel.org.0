Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17F019C8DC
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 20:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389665AbgDBSgA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 14:36:00 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34485 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389618AbgDBSgA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 14:36:00 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so2177258pfj.1
        for <linux-arch@vger.kernel.org>; Thu, 02 Apr 2020 11:36:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MBBRhcWlTmLjshW9NwjTAABOEAhTDX32vhb9ox45OjU=;
        b=IEfTzILKyLkhfpwHgMwKAHNo0SXkWWQIbDRvPlZWRptpe05omv5tLovfYlECAnyWcE
         tiE4YcdCHVMysKGnFUGnEjP0YzlOl8lC/YVB5X+cGbPq+ubht5zYup99LDWEVEf37kzF
         V2Lm4oZXPYl9YKd/oMwN6nHggdELP0qetvbBw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MBBRhcWlTmLjshW9NwjTAABOEAhTDX32vhb9ox45OjU=;
        b=fWYDA4vX6mBprUa1YYLjmwNjWfZ3LSDcERHmvjD5AsxEwYftyxw9PciKkqCcejRudk
         nOGk9fFXijY+0dM1aNis8h05XxfDkItqn4UrccAuurDeL0kD2m78mvKp8J7NCS9R6rY9
         4ulbk3COtcVljEDaqtVTwr13C5AI3GfAkpk/u1VNiKphID3p7dfAo88KgmaD/CL/ZH7p
         Oq+g00BSmNukSSs/+KhWhHfEH4QOfi51uq020Ge5ARw1jyKN1G4cmO5bsrnhQ+XRL8re
         ixpylh6202Bd7FPsOedY0BMHGooV4NUE+bfNtN7d8uZlt6jFZ7LStqgHbH1o7Kn8WuMh
         +KiQ==
X-Gm-Message-State: AGi0PuZUybgccDVl9Ab6rt/NMb3Cf1OWe92A+Frx0deNrrE6n5nbEvme
        SXSb7ia0N2QeMcdfuv31PQa3yA==
X-Google-Smtp-Source: APiQypL88WhZOnrTMVmaoC4rwp7riCtTsgSSYjJzsJsGIRi1RUlgzkKuTBBp5rtjR5K09Q2BMk3zag==
X-Received: by 2002:a65:62ce:: with SMTP id m14mr56221pgv.174.1585852559728;
        Thu, 02 Apr 2020 11:35:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h198sm4203102pfe.76.2020.04.02.11.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 11:35:58 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:35:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
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
Message-ID: <202004021132.813F8E88@keescook>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402175032.GH23230@ZenIV.linux.org.uk>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 06:50:32PM +0100, Al Viro wrote:
> On Thu, Apr 02, 2020 at 07:03:28PM +0200, Christophe Leroy wrote:
> 
> > user_access_begin() grants both read and write.
> > 
> > This patch adds user_read_access_begin() and user_write_access_begin() but
> > it doesn't remove user_access_begin()
> 
> Ouch...  So the most generic name is for the rarest case?
>  
> > > What should we do about that?  Do we prohibit such blocks outside
> > > of arch?
> > > 
> > > What should we do about arm and s390?  There we want a cookie passed
> > > from beginning of block to its end; should that be a return value?
> > 
> > That was the way I implemented it in January, see
> > https://patchwork.ozlabs.org/patch/1227926/
> > 
> > There was some discussion around that and most noticeable was:
> > 
> > H. Peter (hpa) said about it: "I have *deep* concern with carrying state in
> > a "key" variable: it's a direct attack vector for a crowbar attack,
> > especially since it is by definition live inside a user access region."
> 
> > This patch minimises the change by just adding user_read_access_begin() and
> > user_write_access_begin() keeping the same parameters as the existing
> > user_access_begin().
> 
> Umm...  What about the arm situation?  The same concerns would apply there,
> wouldn't they?  Currently we have
> static __always_inline unsigned int uaccess_save_and_enable(void)
> {
> #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         unsigned int old_domain = get_domain();
> 
>         /* Set the current domain access to permit user accesses */
>         set_domain((old_domain & ~domain_mask(DOMAIN_USER)) |
>                    domain_val(DOMAIN_USER, DOMAIN_CLIENT));
> 
>         return old_domain;
> #else
>         return 0;
> #endif
> }
> and
> static __always_inline void uaccess_restore(unsigned int flags)
> {
> #ifdef CONFIG_CPU_SW_DOMAIN_PAN
>         /* Restore the user access mask */
>         set_domain(flags);
> #endif
> }
> 
> How much do we need nesting on those, anyway?  rmk?

Yup, I think it's a weakness of the ARM implementation and I'd like to
not extend it further. AFAIK we should never nest, but I would not be
surprised at all if we did.

If we were looking at a design goal for all architectures, I'd like
to be doing what the public PaX patchset did for their memory access
switching, which is to alarm if calling into "enable" found the access
already enabled, etc. Such a condition would show an unexpected nesting
(like we've seen with similar constructs with set_fs() not getting reset
during an exception handler, etc etc).

-- 
Kees Cook
