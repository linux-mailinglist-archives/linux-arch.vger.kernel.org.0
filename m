Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4C322AE7
	for <lists+linux-arch@lfdr.de>; Tue, 23 Feb 2021 13:59:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhBWM5x (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 23 Feb 2021 07:57:53 -0500
Received: from elvis.franken.de ([193.175.24.41]:49458 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232605AbhBWM5w (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 23 Feb 2021 07:57:52 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1lEXFU-0002LK-01; Tue, 23 Feb 2021 13:57:08 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 9FBAEC07B1; Tue, 23 Feb 2021 13:26:48 +0100 (CET)
Date:   Tue, 23 Feb 2021 13:26:48 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Alexander Lobakin <alobakin@pm.me>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Pei Huang <huangpei@loongson.cn>,
        Kees Cook <keescook@chromium.org>,
        Fangrui Song <maskray@google.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Corey Minyard <cminyard@mvista.com>,
        kernel test robot <lkp@intel.com>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH mips-fixes] vmlinux.lds.h: catch even more
 instrumentation symbols into .data
Message-ID: <20210223122648.GB7765@alpha.franken.de>
References: <20210223113600.7009-1-alobakin@pm.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210223113600.7009-1-alobakin@pm.me>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 23, 2021 at 11:36:21AM +0000, Alexander Lobakin wrote:
> LKP caught another bunch of orphaned instrumentation symbols [0]:
> 
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/main.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/main.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/do_mounts.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/do_mounts.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/do_mounts_initrd.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/do_mounts_initrd.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/initramfs.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/initramfs.o' being placed in section `.data.$LPBX0'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX1' from
> `init/calibrate.o' being placed in section `.data.$LPBX1'
> mipsel-linux-ld: warning: orphan section `.data.$LPBX0' from
> `init/calibrate.o' being placed in section `.data.$LPBX0'
> 
> [...]
> 
> Soften the wildcard to .data.$L* to grab these ones into .data too.
> 
> [0] https://lore.kernel.org/lkml/202102231519.lWPLPveV-lkp@intel.com
> 
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
