Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EF2248473A
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 18:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbiADRve (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 12:51:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:46496 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231519AbiADRve (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 12:51:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A2C7961558;
        Tue,  4 Jan 2022 17:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E226C36AE9;
        Tue,  4 Jan 2022 17:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641318693;
        bh=ama8ft/90bhZBchhcooGCsDUu/29PT/71uRDE49jrck=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LgrdMJAQHsVakmKdENaBkzJka8TsupnBcwYjrQYi6394fbOCtX3dMdpEfaYMiqSRF
         Ech5w8nvKbEB1JrYmD3w987MsixKSGLmuA5jPQ/kQn35gVnyX9jwzh2m/ssr48mvqQ
         EP6hdvmbu2kHXKr/1eFlBLZSiNxbnKoSKGUDry9Uv7lUWvrx/FlsOuPp9pQOfvt9AY
         gS3emjX0pKXl3YfzGzjDSg/eD8mFIh+oH89BOF0kdvAyX+Uw6Fw+6b3i7mq+x3Ih6D
         KzosYVcOBsEQS7/ZCM9uFF4iZb0hymJnnYtXiTGXOb7MOgk+5f5PQwei1CkueB8e4i
         lEJGcPRHPxkgQ==
Date:   Tue, 4 Jan 2022 10:51:27 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, llvm@lists.linux.dev
Subject: Re: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned
 attribute to the head of the definition
Message-ID: <YdSJH7empIUq9vbE@archlinux-ax161>
References: <YdIfz+LMewetSaEB@gmail.com>
 <YdM4Z5a+SWV53yol@archlinux-ax161>
 <YdQlwnDs2N9a5Reh@gmail.com>
 <YdQpSigW9X224obC@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YdQpSigW9X224obC@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 12:02:34PM +0100, Ingo Molnar wrote:
> 
> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> > > 1. Position of certain attributes
> > > 
> > > In some commits, you move the cacheline_aligned attributes from after
> > > the closing brace on structures to before the struct keyword, which
> > > causes clang to warn (and error with CONFIG_WERROR):
> > > 
> > > In file included from arch/arm64/kernel/asm-offsets.c:9:
> > > In file included from arch/arm64/kernel/../../../kernel/sched/per_task_area_struct.h:33:
> > > In file included from ./include/linux/perf_event_api.h:17:
> > > In file included from ./include/linux/perf_event_types.h:41:
> > > In file included from ./include/linux/ftrace.h:18:
> > > In file included from ./arch/arm64/include/asm/ftrace.h:53:
> > > In file included from ./include/linux/compat.h:11:
> > > ./include/linux/fs_types.h:997:1: error: attribute '__aligned__' is ignored, place it after "struct" to apply attribute to type declaration [-Werror,-Wignored-attributes]
> > > ____cacheline_aligned
> > > ^
> > > ./include/linux/cache.h:41:46: note: expanded from macro '____cacheline_aligned'
> > > #define ____cacheline_aligned __attribute__((__aligned__(SMP_CACHE_BYTES)))
> > 
> > Yeah, so this is a *really* stupid warning from Clang.
> > 
> > Putting the attribute after 'struct' risks the hard to track down bugs when 
> > a <linux/cache.h> inclusion is missing, which scenario I pointed out in 
> > this commit:
> > 
> >     headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition
> >     
> >     When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> header,
> >     which caused a couple of hundred of mysterious, somewhat obscure link time errors:
> >     
> >       ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
> >       ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
> >       ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
> >       ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
> >     
> >     After a bit of head-scratching, what happened is that 'struct dentry_operations'
> >     has the ____cacheline_aligned attribute at the tail of the type definition -
> >     which turned into a local variable definition when <linux/cache.h> was not
> >     included - which <linux/spinlock_api.h> includes into <linux/dcache.h> indirectly.
> >     
> >     There were no compile time errors, only link time errors.
> >     
> >     Move the attribute to the head of the definition, in which case
> >     a missing <linux/cache.h> inclusion creates an immediate build failure:
> >     
> >       In file included from ./include/linux/fs.h:9,
> >                        from ./include/linux/fsverity.h:14,
> >                        from fs/verity/fsverity_private.h:18,
> >                        from fs/verity/read_metadata.c:8:
> >       ./include/linux/dcache.h:132:22: error: expected ‘;’ before ‘struct’
> >         132 | ____cacheline_aligned
> >             |                      ^
> >             |                      ;
> >         133 | struct dentry_operations {
> >             | ~~~~~~
> >     
> >     No change in functionality.
> >     
> >     Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > 
> > Can this Clang warning be disabled?
> 
> Ok, broke out this issue into its own thread, in form of a patch submission 
> - so that others don't have to wade through a massive tree to find a single 
> commit ...
> 
> I'll of course drop these (non-essential) cleanups if the upstream policy 
> is to follow Clang's quirk/convention, but I find the forced attribute 
> tail-position a sad misfeature, due to the reasons outlined in this patch: 
> a straightforward build failure in case an attribute is not defined is far 
> preferable to spurious creation of variables with link-time warnings that 
> don't actually highlight the exact nature of the bug ...

I don't disagree with that sentiment. However, I went and looked at
GCC's documentation, which seems to agree with clang's warning here.

https://gcc.gnu.org/onlinedocs/gcc/Type-Attributes.html

"You may specify type attributes in an enum, struct or union type
declaration or definition by placing them immediately after the struct,
union or enum keyword. You can also place them just past the closing
curly brace of the definition, but this is less preferred because
logically the type should be fully defined at the closing brace."

Nowhere does it mention that it accepts the attribute before the type
keyword and neither compiler respects the attribute if it comes before
the keyword but at least clang warns: https://godbolt.org/z/E9fTecKPv

$ cat test.c
#include <stdio.h>

struct foo {
    int a;
    int b;
};

struct __attribute__ ((aligned (64))) bar {
    int a;
    int b;
};

__attribute__ ((aligned (64))) struct baz {
    int a;
    int b;
};

int main(void)
{
    printf("struct foo alignment: %zd\n", _Alignof(struct foo));
    printf("struct bar alignment: %zd\n", _Alignof(struct bar));
    printf("struct baz alignment: %zd\n", _Alignof(struct baz));
    return 0;
}

$ gcc --version | head -1
gcc (GCC) 11.2.1 20211231

$ gcc -std=gnu89 -Wall -Wextra test.c; and ./a.out
struct foo alignment: 4
struct bar alignment: 64
struct baz alignment: 4

$ clang --version | head -1
clang version 13.0.0

$ clang -std=gnu89 -Wall -Wextra test.c; and ./a.out
test.c:13:17: warning: attribute 'aligned' is ignored, place it after "struct" to apply attribute to type declaration [-Wignored-attributes]
__attribute__ ((aligned (64))) struct baz {
                ^
1 warning generated.
struct foo alignment: 4
struct bar alignment: 64
struct baz alignment: 4

Cheers,
Nathan

> =====================>
> Date: Sun, 20 Jun 2021 09:41:45 +0200
> Subject: [PATCH] headers/deps: dcache: Move the ____cacheline_aligned attribute to the head of the definition
> 
> When changing <linux/dcache.h> I removed the <linux/spinlock_api.h> header,
> which caused a couple of hundred of mysterious, somewhat obscure link time errors:
> 
>   ld: net/sctp/tsnmap.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>   ld: net/sctp/tsnmap.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
>   ld: net/sctp/debug.o:(.bss+0x0): multiple definition of `____cacheline_aligned_in_smp'; init/do_mounts_rd.o:(.bss+0x0): first defined here
>   ld: net/sctp/debug.o:(.bss+0x40): multiple definition of `____cacheline_aligned'; init/do_mounts_rd.o:(.bss+0x40): first defined here
> 
> After a bit of head-scratching, what happened is that 'struct dentry_operations'
> has the ____cacheline_aligned attribute at the tail of the type definition -
> which turned into a local variable definition when <linux/cache.h> was not
> included - which <linux/spinlock_api.h> includes into <linux/dcache.h> indirectly.
> 
> There were no compile time errors, only link time errors.
> 
> Move the attribute to the head of the definition, in which case
> a missing <linux/cache.h> inclusion creates an immediate build failure:
> 
>   In file included from ./include/linux/fs.h:9,
>                    from ./include/linux/fsverity.h:14,
>                    from fs/verity/fsverity_private.h:18,
>                    from fs/verity/read_metadata.c:8:
>   ./include/linux/dcache.h:132:22: error: expected ‘;’ before ‘struct’
>     132 | ____cacheline_aligned
>         |                      ^
>         |                      ;
>     133 | struct dentry_operations {
>         | ~~~~~~
> 
> No change in functionality.
> 
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> ---
>  include/linux/dcache.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/dcache.h b/include/linux/dcache.h
> index 41062093ec9b..0482c3d6f1ce 100644
> --- a/include/linux/dcache.h
> +++ b/include/linux/dcache.h
> @@ -129,6 +129,7 @@ enum dentry_d_lock_class
>  	DENTRY_D_LOCK_NESTED
>  };
>  
> +____cacheline_aligned
>  struct dentry_operations {
>  	int (*d_revalidate)(struct dentry *, unsigned int);
>  	int (*d_weak_revalidate)(struct dentry *, unsigned int);
> @@ -144,7 +145,7 @@ struct dentry_operations {
>  	struct vfsmount *(*d_automount)(struct path *);
>  	int (*d_manage)(const struct path *, bool);
>  	struct dentry *(*d_real)(struct dentry *, const struct inode *);
> -} ____cacheline_aligned;
> +};
>  
>  /*
>   * Locking rules for dentry_operations callbacks are to be found in
