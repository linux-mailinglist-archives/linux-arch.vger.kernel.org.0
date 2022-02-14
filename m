Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6673B4B5842
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 18:15:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356972AbiBNRPp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 12:15:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356970AbiBNRPo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 12:15:44 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6B5652C4;
        Mon, 14 Feb 2022 09:15:35 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJewf-001kzp-JJ; Mon, 14 Feb 2022 17:15:25 +0000
Date:   Mon, 14 Feb 2022 17:15:25 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        will@kernel.org, guoren@kernel.org, bcain@codeaurora.org,
        geert@linux-m68k.org, monstr@monstr.eu, tsbogend@alpha.franken.de,
        nickhu@andestech.com, green.hu@gmail.com, dinguyen@kernel.org,
        shorne@gmail.com, deller@gmx.de, mpe@ellerman.id.au,
        peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        hca@linux.ibm.com, dalias@libc.org, davem@davemloft.net,
        richard@nod.at, x86@kernel.org, jcmvbkbc@gmail.com,
        ebiederm@xmission.com, akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: Re: [PATCH 07/14] uaccess: generalize access_ok()
Message-ID: <YgqOLZbFK7/B2HJT@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-8-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-8-arnd@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:45PM +0100, Arnd Bergmann wrote:

> diff --git a/arch/csky/kernel/signal.c b/arch/csky/kernel/signal.c
> index c7b763d2f526..8867ddf3e6c7 100644
> --- a/arch/csky/kernel/signal.c
> +++ b/arch/csky/kernel/signal.c
> @@ -136,7 +136,7 @@ static inline void __user *get_sigframe(struct ksignal *ksig,
>  static int
>  setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
>  {
> -	struct rt_sigframe *frame;
> +	struct rt_sigframe __user *frame;
>  	int err = 0;
>  
>  	frame = get_sigframe(ksig, regs, sizeof(*frame));

Minor nit: might make sense to separate annotations (here, on nios2, etc.) from the rest...

This, OTOH,

> diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
> index 5c12fb46bc61..000bac67cf31 100644
> --- a/arch/sparc/include/asm/uaccess_64.h
> +++ b/arch/sparc/include/asm/uaccess_64.h
...
> -static inline bool __chk_range_not_ok(unsigned long addr, unsigned long size, unsigned long limit)
> -{
> -	if (__builtin_constant_p(size))
> -		return addr > limit - size;
> -
> -	addr += size;
> -	if (addr < size)
> -		return true;
> -
> -	return addr > limit;
> -}
> -
> -#define __range_not_ok(addr, size, limit)                               \
> -({                                                                      \
> -	__chk_user_ptr(addr);                                           \
> -	__chk_range_not_ok((unsigned long __force)(addr), size, limit); \
> -})
> -
> -static inline int __access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> -
> -static inline int access_ok(const void __user * addr, unsigned long size)
> -{
> -	return 1;
> -}
> +#define __range_not_ok(addr, size, limit) (!__access_ok(addr, size))

is really wrong.  For sparc64, access_ok() should always be true.
This __range_not_ok() thing is used *only* for valid_user_frame() in
arch/sparc/kernel/perf_event.c - it's not a part of normal access_ok()
there.

sparc64 has separate address spaces for kernel and for userland; access_ok()
had never been useful there.  
