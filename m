Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF683AAD
	for <lists+linux-arch@lfdr.de>; Tue,  6 Aug 2019 22:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726058AbfHFUvv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Aug 2019 16:51:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:43144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfHFUvv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Aug 2019 16:51:51 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C26D2173B;
        Tue,  6 Aug 2019 20:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565124709;
        bh=gmv2NhynOlvsJo/XaSmVGbWDHCIS29JRNjVFyDL59Zo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bsXbu4Dx0vPRFZVn7Kylt0tqlWkV0eU7YaCb+zd7CGaaVwGbccAS8ljEFwgTMUBBA
         tkAC3iX3lvn0b6EK+PbvZtP8lpesaTAPP0jzqrw9KJIPXQc8G2mc0cmsC9mqj1bsHw
         Yqts5gAZNKCpKtQWQDT/pjUojR2gM2gDwG6IiW0E=
Date:   Tue, 6 Aug 2019 13:51:48 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Qian Cai <cai@lca.pw>, arnd@arndb.de,
        kirill.shutemov@linux.intel.com, mhocko@suse.com,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic: fix variable 'p4d' set but not used
Message-Id: <20190806135148.867b32afce5a64e4ed651ccd@linux-foundation.org>
In-Reply-To: <20190806143904.GE11627@ziepe.ca>
References: <1564774882-22926-1-git-send-email-cai@lca.pw>
        <20190806143904.GE11627@ziepe.ca>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, 6 Aug 2019 11:39:04 -0300 Jason Gunthorpe <jgg@ziepe.ca> wrote:

> On Fri, Aug 02, 2019 at 03:41:22PM -0400, Qian Cai wrote:
> > GCC throws a warning on an arm64 system since the commit 9849a5697d3d
> > ("arch, mm: convert all architectures to use 5level-fixup.h"),
> > 
> > mm/kasan/init.c: In function 'kasan_free_p4d':
> > mm/kasan/init.c:344:9: warning: variable 'p4d' set but not used
> > [-Wunused-but-set-variable]
> >   p4d_t *p4d;
> >          ^~~
> > 
> > because p4d_none() in "5level-fixup.h" is compiled away while it is a
> > static inline function in "pgtable-nopud.h". However, if converted
> > p4d_none() to a static inline there, powerpc would be unhappy as it
> > reads those in assembler language in
> > "arch/powerpc/include/asm/book3s/64/pgtable.h",
> > 
> > ./include/asm-generic/5level-fixup.h: Assembler messages:
> > ./include/asm-generic/5level-fixup.h:20: Error: unrecognized opcode:
> > `static'
> > ./include/asm-generic/5level-fixup.h:21: Error: junk at end of line,
> > first unrecognized character is `{'
> > ./include/asm-generic/5level-fixup.h:22: Error: unrecognized opcode:
> > `return'
> > ./include/asm-generic/5level-fixup.h:23: Error: junk at end of line,
> > first unrecognized character is `}'
> > ./include/asm-generic/5level-fixup.h:25: Error: unrecognized opcode:
> > `static'
> > ./include/asm-generic/5level-fixup.h:26: Error: junk at end of line,
> > first unrecognized character is `{'
> > ./include/asm-generic/5level-fixup.h:27: Error: unrecognized opcode:
> > `return'
> > ./include/asm-generic/5level-fixup.h:28: Error: junk at end of line,
> > first unrecognized character is `}'
> > ./include/asm-generic/5level-fixup.h:30: Error: unrecognized opcode:
> > `static'
> > ./include/asm-generic/5level-fixup.h:31: Error: junk at end of line,
> > first unrecognized character is `{'
> > ./include/asm-generic/5level-fixup.h:32: Error: unrecognized opcode:
> > `return'
> > ./include/asm-generic/5level-fixup.h:33: Error: junk at end of line,
> > first unrecognized character is `}'
> > make[2]: *** [scripts/Makefile.build:375:
> > arch/powerpc/kvm/book3s_hv_rmhandlers.o] Error 1
> > 
> > Fix it by reference the variable in the macro instead.
> > 
> > Signed-off-by: Qian Cai <cai@lca.pw>
> >  include/asm-generic/5level-fixup.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/asm-generic/5level-fixup.h b/include/asm-generic/5level-fixup.h
> > index bb6cb347018c..2c3e14c924b6 100644
> > +++ b/include/asm-generic/5level-fixup.h
> > @@ -19,7 +19,7 @@
> >  
> >  #define p4d_alloc(mm, pgd, address)	(pgd)
> >  #define p4d_offset(pgd, start)		(pgd)
> > -#define p4d_none(p4d)			0
> > +#define p4d_none(p4d)			((void)p4d, 0)
> 
> Yuk, how about a static inline instead?

Yes.  With the appropriate `#ifndef __ASSEMBLY__' to avoid powerpc
build errors?

