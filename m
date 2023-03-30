Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09A536D0798
	for <lists+linux-arch@lfdr.de>; Thu, 30 Mar 2023 16:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjC3OFb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Mar 2023 10:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbjC3OFa (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Mar 2023 10:05:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A84C7A9B;
        Thu, 30 Mar 2023 07:05:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFBF06209A;
        Thu, 30 Mar 2023 14:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A08C433D2;
        Thu, 30 Mar 2023 14:05:09 +0000 (UTC)
Date:   Thu, 30 Mar 2023 15:05:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Gregory Price <gregory.price@memverge.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        oleg@redhat.com, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de, will@kernel.org,
        mark.rutland@arm.com, tongtiangen@huawei.com, robin.murphy@arm.com
Subject: Re: [PATCH v14 1/4] asm-generic,arm64: create task variant of
 access_ok
Message-ID: <ZCWXE04nLZ4pXEtM@arm.com>
References: <20230328164811.2451-1-gregory.price@memverge.com>
 <20230328164811.2451-2-gregory.price@memverge.com>
 <ZCRl2ZDsNK2nKAfy@arm.com>
 <ZCO/vNYlGdwthZX2@memverge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCO/vNYlGdwthZX2@memverge.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Mar 29, 2023 at 12:34:04AM -0400, Gregory Price wrote:
> On Wed, Mar 29, 2023 at 05:22:49PM +0100, Catalin Marinas wrote:
> > On Tue, Mar 28, 2023 at 12:48:08PM -0400, Gregory Price wrote:
> > > diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
> > > index 5c7b2f9d5913..1a51a54f264f 100644
> > > --- a/arch/arm64/include/asm/uaccess.h
> > > +++ b/arch/arm64/include/asm/uaccess.h
> > > @@ -35,7 +35,9 @@ static inline int __access_ok(const void __user *ptr, unsigned long size);
> > >   * This is equivalent to the following test:
> > >   * (u65)addr + (u65)size <= (u65)TASK_SIZE_MAX
> > >   */
> > > -static inline int access_ok(const void __user *addr, unsigned long size)
> > > +static inline int task_access_ok(struct task_struct *task,
> > > +				 const void __user *addr,
> > > +				 unsigned long size)
> > >  {
> > >  	/*
> > >  	 * Asynchronous I/O running in a kernel thread does not have the
> > > @@ -43,11 +45,18 @@ static inline int access_ok(const void __user *addr, unsigned long size)
> > >  	 * the user address before checking.
> > >  	 */
> > >  	if (IS_ENABLED(CONFIG_ARM64_TAGGED_ADDR_ABI) &&
> > > -	    (current->flags & PF_KTHREAD || test_thread_flag(TIF_TAGGED_ADDR)))
> > > +	    (task->flags & PF_KTHREAD || test_ti_thread_flag(task, TIF_TAGGED_ADDR)))
> > >  		addr = untagged_addr(addr);
> > >  
> > >  	return likely(__access_ok(addr, size));
> > >  }
> > > +
> > > +static inline int access_ok(const void __user *addr, unsigned long size)
> > > +{
> > > +	return task_access_ok(current, addr, size);
> > > +}
> > > +
> > > +#define task_access_ok task_access_ok
> > 
> > I'd not bother with this at all. In the generic code you can either do
> > an __access_ok() check directly or just
> > access_ok(untagged_addr(selector), ...) with a comment that address
> > tagging of the ptraced task may not be enabled.
> 
> This was my original proposal, but the comment that lead to this patch
> was the following:
> 
> """
> If this would be correct, then access_ok() on arm64 would
> unconditionally untag the checked address, but it does not. Simply
> because untagging is only valid if the task enabled pointer tagging. If
> it didn't a tagged pointer is obviously invalid.
> 
> Why would ptrace make this suddenly valid?
> """
> 
> https://lore.kernel.org/all/87a605anvx.ffs@tglx/

Ah, thanks for the pointer.

For ptrace(), we live with this relaxation as there's no easy way to
check. Take __access_remote_vm() for example, it ends up in
get_user_pages_remote() -> ... -> __get_user_pages() which just untags
the address. Even if it would want to do this conditionally, the tag
pointer is enabled per thread (and inherited) but the GUP API only takes
the mm.

While we could improve it as ptrace() can tell which thread it is
tracing, I don't think it's worth the effort. On arm64, top-byte-ignore
was enabled from the start for in-user accesses but not at the syscall
level. We wanted to avoid breaking some use-cases with untagging all
user pointers, hence the explicit opt-in to catch some issues (glibc did
have a problem with brk() ignoring the top byte -
https://bugzilla.redhat.com/show_bug.cgi?id=1797052).

So yeah, this access_ok() in a few places is a best effort to catch some
potential ABI regressions like the one above and also as a way to force
the old ABI (mostly) via sysctl. But we do have places like GUP where we
don't have the thread information (only the mm), so we just
indiscriminately untag the pointer.

Note that there is no security risk for the access itself. The Arm
architecture selects the user vs kernel address spaces based on bit 55
rather than 63. Untagging a pointer sign-extends bit 55.

> I did not have a sufficient answer for this so I went down this path.
> 
> It does seem simpler to simply untag the address, however it didn't seem
> like a good solution to simply leave an identified bad edge case.
> 
> with access_ok(untagged_addr(addr), ...) it breaks down like this:
> 
> (tracer,tracee) : result 
> 
> tag,tag     : untagged - (correct)
> tag,untag   : untagged - incorrect as this would have been an impossible
>               state to reach through the standard prctl interface.  Will
> 	      lead to a SIGSEGV in the tracee upon next syscall

Well, even without untagging the pointer, the tracer can set a random
address that passes access_ok() but still faults in the tracee. It's the
tracer that should ensure the pointer is valid in the context of the
tracee.

Now, even if the selector pointer is tagged, the accesses still work
fine (top-byte-ignore) unless MTE is enabled in the tracee and the tag
should match the region's colour. But, again, that's no different from a
debugger changing pointer variables in the debugged process, they should
be valid and it's not for the kernel to sanitise them.

> untag,tag   : untagged - (correct)
> untag,untag : no-op - (correct), tagged address will fail to set
> 
> Basically if the tracer is a tagged process while the tracee is not, it
> would become possible to set the tracee's selector to a tagged pointer.

Yes, but does it matter? You'd trust the tracer to work correctly. There
are multiple ways it can break the tracee here even if access_ok()
worked as intended.

> It's beyond me to say whether or not this situation is "ok" and "the
> user's fault", but it does feel like an addressable problem.

To me, the situation looks fine. While it's addressable, we have other
places where the tag is ignored on the ptrace() path, so I don't think
it's worth the effort.

-- 
Catalin
