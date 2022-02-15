Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E313B4B5F2C
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 01:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbiBOAhz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 19:37:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbiBOAhz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 19:37:55 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7889512D21B;
        Mon, 14 Feb 2022 16:37:46 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJlqf-001pf0-Dy; Tue, 15 Feb 2022 00:37:41 +0000
Date:   Tue, 15 Feb 2022 00:37:41 +0000
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
Subject: Re: [PATCH 09/14] m68k: drop custom __access_ok()
Message-ID: <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-10-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-10-arnd@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:47PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> While most m68k platforms use separate address spaces for user
> and kernel space, at least coldfire does not, and the other
> ones have a TASK_SIZE that is less than the entire 4GB address
> range.
> 
> Using the generic implementation of __access_ok() stops coldfire
> user space from trivially accessing kernel memory, and is probably
> the right thing elsewhere for consistency as well.

Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
(and trim the comment down to "coldfire and 68000 will pick generic
variant")?

> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/m68k/include/asm/uaccess.h | 13 -------------
>  1 file changed, 13 deletions(-)
> 
> diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
> index d6bb5720365a..64914872a5c9 100644
> --- a/arch/m68k/include/asm/uaccess.h
> +++ b/arch/m68k/include/asm/uaccess.h
> @@ -10,19 +10,6 @@
>  #include <linux/compiler.h>
>  #include <linux/types.h>
>  #include <asm/extable.h>
> -
> -/* We let the MMU do all checking */
> -static inline int __access_ok(const void __user *addr,
> -			    unsigned long size)
> -{
> -	/*
> -	 * XXX: for !CONFIG_CPU_HAS_ADDRESS_SPACES this really needs to check
> -	 * for TASK_SIZE!
> -	 * Removing this helper is probably sufficient.
> -	 */
> -	return 1;
> -}
> -#define __access_ok __access_ok
>  #include <asm-generic/access_ok.h>
>  
>  /*
> -- 
> 2.29.2
> 
