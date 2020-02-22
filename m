Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E686F168B1C
	for <lists+linux-arch@lfdr.de>; Sat, 22 Feb 2020 01:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgBVAmA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 19:42:00 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34010 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726697AbgBVAmA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 21 Feb 2020 19:42:00 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j5Irl-00Gerj-Gl; Sat, 22 Feb 2020 00:41:57 +0000
Date:   Sat, 22 Feb 2020 00:41:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Miller <davem@davemloft.net>
Cc:     torvalds@linux-foundation.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de
Subject: Re: [RFC] regset ->get() API
Message-ID: <20200222004157.GX23230@ZenIV.linux.org.uk>
References: <CAHk-=whdat=wfwKh5rF3MuCbTxhcFwaGqmdsCXXv=H=kDERTOw@mail.gmail.com>
 <20200221033016.GV23230@ZenIV.linux.org.uk>
 <20200221185903.GA3929948@ZenIV.linux.org.uk>
 <20200221.112244.1426580944977593272.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221.112244.1426580944977593272.davem@davemloft.net>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 21, 2020 at 11:22:44AM -0800, David Miller wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Fri, 21 Feb 2020 18:59:03 +0000
> 
> > Again, a couple of copy_regset_to_user(), but there's an additional
> > twist - GETREGSET of 32bit task on sparc64 will use access_process_vm()
> > when trying to fetch L0..L7/I0..I7 of other task, using copy_from_user()
> > only when the target is equal to current.  For sparc32 this is not
> > true - it's always copy_from_user() there, so the values it reports
> > for those registers have nothing to do with the target process.  That
> > part smells like a bug; by the time GETREGSET had been introduced
> > sparc32 was not getting much attention, GETREGS worked just fine
> > (not reporting L*/I* anyway) and for coredump it was accessing the
> > caller's memory.  Not sure if anyone cares at that point...
> 
> That's definitely a bug and sparc64 is doing it correctly.

OK...  What does the comment in
        case PTRACE_GETREGS64:
                ret = copy_regset_to_user(child, view, REGSET_GENERAL,
                                          1 * sizeof(u64),
                                          15 * sizeof(u64),
                                          &pregs->u_regs[0]);
                if (!ret) {
                        /* XXX doesn't handle 'y' register correctly XXX */
                        ret = copy_regset_to_user(child, view, REGSET_GENERAL,
                                                  32 * sizeof(u64),
                                                  4 * sizeof(u64),
                                                  &pregs->tstate);
                }
                break;   
refer to?  The fact that you end up with 0 in pregs->y and Y in pregs->magic?
In that case it's probably too late to do anything about that...

Or is that something different?
