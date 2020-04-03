Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5E9A19CDFC
	for <lists+linux-arch@lfdr.de>; Fri,  3 Apr 2020 02:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390138AbgDCA6x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 20:58:53 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:54420 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbgDCA6w (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 20:58:52 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jKAfH-009AzZ-B4; Fri, 03 Apr 2020 00:58:31 +0000
Date:   Fri, 3 Apr 2020 01:58:31 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Kees Cook <keescook@chromium.org>
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
Message-ID: <20200403005831.GI23230@ZenIV.linux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
 <20200402162942.GG23230@ZenIV.linux.org.uk>
 <67e21b65-0e2d-7ca5-7518-cec1b7abc46c@c-s.fr>
 <20200402175032.GH23230@ZenIV.linux.org.uk>
 <202004021132.813F8E88@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004021132.813F8E88@keescook>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 11:35:57AM -0700, Kees Cook wrote:

> Yup, I think it's a weakness of the ARM implementation and I'd like to
> not extend it further. AFAIK we should never nest, but I would not be
> surprised at all if we did.
> 
> If we were looking at a design goal for all architectures, I'd like
> to be doing what the public PaX patchset did for their memory access
> switching, which is to alarm if calling into "enable" found the access
> already enabled, etc. Such a condition would show an unexpected nesting
> (like we've seen with similar constructs with set_fs() not getting reset
> during an exception handler, etc etc).

FWIW, maybe I'm misreading the ARM uaccess logics, but... it smells like
KERNEL_DS is somewhat more dangerous there than on e.g. x86.

Look: with CONFIG_CPU_DOMAINS, set_fs(KERNEL_DS) tells MMU to ignore
per-page permission bits in DOMAIN_KERNEL (i.e. for kernel address
ranges), allowing them even if they would normally be denied.  We need
that for actual uaccess loads/stores, since those use insns that pretend
to be done in user mode and we want them to access the kernel pages.
But that affects the normal loads/stores as well; unless I'm misreading
that code, it will ignore (supervisor) r/o on a page.  And that's not
just for the code inside the uaccess blocks; *everything* done under
KERNEL_DS is subject to that.

Why do we do that (modify_domain(), that is) inside set_fs() and not
in uaccess_enable() et.al.?
