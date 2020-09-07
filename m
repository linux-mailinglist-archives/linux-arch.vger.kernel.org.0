Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B3E25FB97
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 15:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgIGNk6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 09:40:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:38264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729610AbgIGNkv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Sep 2020 09:40:51 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6570221481;
        Mon,  7 Sep 2020 13:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599485438;
        bh=5+5cu0m/GDXW1vdvbD9k7dHxXUwtrx3YfHl3e5jZzVw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KRrpWHcLtkZ3gsEWWQEUwiKCvFKuq+nxBQ17eXU7UnEmvJeWgaU3SCkt9a3hJWgsx
         FLThsuMmNCxz4K2Oz4Z8viDJXy/BmBg7IfsTrbiKWDEihgV76wvP8FTW7mluj45XcF
         jls9imQ81JnzCuK1kjqMeF696TtfPWoy3cmflzvQ=
Date:   Mon, 7 Sep 2020 14:30:30 +0100
From:   Will Deacon <will@kernel.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jeff Dike <jdike@addtoit.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Marek <michal.lkml@markovi.net>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Richard Weinberger <richard@nod.at>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] kbuild: preprocess module linker script
Message-ID: <20200907133029.GB12551@willie-the-truck>
References: <20200904133122.133071-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904133122.133071-1-masahiroy@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 04, 2020 at 10:31:21PM +0900, Masahiro Yamada wrote:
> There was a request to preprocess the module linker script like we do
> for the vmlinux one (https://lkml.org/lkml/2020/8/21/512).
> 
> The difference between vmlinux.lds and module.lds is that the latter
> is needed for external module builds, thus must be cleaned up by
> 'make mrproper' instead of 'make clean' (also, it must be created by
> 'make modules_prepare').
> 
> You cannot put it in arch/*/kernel/ because 'make clean' descends into
> it. I moved arch/*/kernel/module.lds to arch/*/include/asm/module.lds.h,
> which is included from scripts/module.lds.S.
> 
> scripts/module.lds is fine because 'make clean' keeps all the build
> artifacts under scripts/.
> 
> You can add arch-specific sections in <asm/module.lds.h>.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Tested-by: Jessica Yu <jeyu@kernel.org>
> ---

For the arm64 bits:

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
