Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9155C19C710
	for <lists+linux-arch@lfdr.de>; Thu,  2 Apr 2020 18:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbgDBQaN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 2 Apr 2020 12:30:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:48542 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgDBQaN (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 2 Apr 2020 12:30:13 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jK2is-008oQu-I7; Thu, 02 Apr 2020 16:29:42 +0000
Date:   Thu, 2 Apr 2020 17:29:42 +0100
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
Message-ID: <20200402162942.GG23230@ZenIV.linux.org.uk>
References: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27106d62fdbd4ffb47796236050e418131cb837f.1585811416.git.christophe.leroy@c-s.fr>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Apr 02, 2020 at 07:34:16AM +0000, Christophe Leroy wrote:
> Some architectures like powerpc64 have the capability to separate
> read access and write access protection.
> For get_user() and copy_from_user(), powerpc64 only open read access.
> For put_user() and copy_to_user(), powerpc64 only open write access.
> But when using unsafe_get_user() or unsafe_put_user(),
> user_access_begin open both read and write.
> 
> Other architectures like powerpc book3s 32 bits only allow write
> access protection. And on this architecture protection is an heavy
> operation as it requires locking/unlocking per segment of 256Mbytes.
> On those architecture it is therefore desirable to do the unlocking
> only for write access. (Note that book3s/32 ranges from very old
> powermac from the 90's with powerpc 601 processor, till modern
> ADSL boxes with PowerQuicc II modern processors for instance so it
> is still worth considering)
> 
> In order to avoid any risk based of hacking some variable parameters
> passed to user_access_begin/end that would allow hacking and
> leaving user access open or opening too much, it is preferable to
> use dedicated static functions that can't be overridden.
> 
> Add a user_read_access_begin and user_read_access_end to only open
> read access.
> 
> Add a user_write_access_begin and user_write_access_end to only open
> write access.
> 
> By default, when undefined, those new access helpers default on the
> existing user_access_begin and user_access_end.

The only problem I have is that we'd better choose the calling
conventions that work for other architectures as well.

AFAICS, aside of ppc and x86 we have (at least) this:
arm:
	unsigned int __ua_flags = uaccess_save_and_enable();
	...
	uaccess_restore(__ua_flags);
arm64:
	uaccess_enable_not_uao();
	...
	uaccess_disable_not_uao();
riscv:
	__enable_user_access();
	...
	__disable_user_access();
s390/mvc:
	old_fs = enable_sacf_uaccess();
	...
        disable_sacf_uaccess(old_fs);

arm64 and riscv are easy - they map well on what we have now.
The interesting ones are ppc, arm and s390.

You wants to specify the kind of access; OK, but...  it's not just read
vs. write - there's read-write as well.  AFAICS, there are 3 users of
that:
	* copy_in_user()
	* arch_futex_atomic_op_inuser()
	* futex_atomic_cmpxchg_inatomic()
The former is of dubious utility (all users outside of arch are in
the badly done compat code), but the other two are not going to go
away.

What should we do about that?  Do we prohibit such blocks outside
of arch?

What should we do about arm and s390?  There we want a cookie passed
from beginning of block to its end; should that be a return value?

And at least on arm that thing nests (see e.g. __clear_user_memset()
there), so "stash that cookie in current->something" is not a solution...

Folks, let's sort that out while we still have few users of that
interface; changing the calling conventions later will be much harder.
Comments?
