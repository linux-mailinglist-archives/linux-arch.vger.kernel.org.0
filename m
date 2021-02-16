Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C07E31D143
	for <lists+linux-arch@lfdr.de>; Tue, 16 Feb 2021 20:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbhBPT4E (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 16 Feb 2021 14:56:04 -0500
Received: from elvis.franken.de ([193.175.24.41]:59633 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhBPT4A (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 16 Feb 2021 14:56:00 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lC6Qm-0007Yg-00; Tue, 16 Feb 2021 20:54:44 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id E4344C03C3; Tue, 16 Feb 2021 18:10:27 +0100 (CET)
Date:   Tue, 16 Feb 2021 18:10:27 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH mips-next] vmlinux.lds.h: catch more UBSAN symbols into
 .data
Message-ID: <20210216171027.GA9873@alpha.franken.de>
References: <20210216085442.2967-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210216085442.2967-1-alobakin@pm.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 16, 2021 at 08:55:25AM +0000, Alexander Lobakin wrote:
> LKP triggered lots of LD orphan warnings [0]:
> 
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data299' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data299'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_data183' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_data183'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type3' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type3'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type2' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type2'
> mipsel-linux-ld: warning: orphan section `.data.$Lubsan_type0' from
> `init/do_mounts_rd.o' being placed in section `.data.$Lubsan_type0'
> 
> [...]
> 
> Seems like "unnamed data" isn't the only type of symbols that UBSAN
> instrumentation can emit.
> Catch these into .data with the wildcard as well.
> 
> [0] https://lore.kernel.org/linux-mm/202102160741.k57GCNSR-lkp@intel.com
> 
> Fixes: f41b233de0ae ("vmlinux.lds.h: catch UBSAN's "unnamed data" into data")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Alexander Lobakin <alobakin@pm.me>
> ---
>  include/asm-generic/vmlinux.lds.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
