Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C4121AF02
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 07:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgGJFvp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 01:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgGJFvo (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 01:51:44 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 487A2C08C5CE;
        Thu,  9 Jul 2020 22:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RLTu3+HsCxbyd0XHLP7eqfjDQF9m/c45x4E/TaQCods=; b=TdwzKJ6KbOxKPNVPgtlBSB8eCE
        GiUZ/mHUxX+IkLfgDjuZWly7AhMRgob3HvY24kAOGFO07yG4CWvBAsYSneiAVMIlGfl4UYsHQ6/r7
        QEC9VXjWzgog2kozgtbitj5C0W6jnv/CtLWa/Z9J/dLfrjGQyH+YNPXWWyeVNVReuG5Ul1nz5OcHb
        Qx+GixWi/iLAkyBxaBnqMqXoOy1Z0o8ayJoShQ2zPXbf15O9YcvLUQg6FpDs5mv4VAiDi1ojjGcx5
        dqa+iwhvPqxEyuWAcxCaAbqlG41xKw8VCI/n3bgrKPBIrCAc1yBi6mD54voeiD6p/mdtiAdJadxjr
        0DzQw7HA==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtlwS-0007tK-I4; Fri, 10 Jul 2020 05:51:24 +0000
Date:   Fri, 10 Jul 2020 06:51:24 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Nick Kossifidis <mick@ics.forth.gr>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>, mark.rutland@arm.com,
        steve@sk2.org, gregory.0xf0@gmail.com, catalin.marinas@arm.com,
        linus.walleij@linaro.org,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        zaslonko@linux.ibm.com, glider@google.com, krzk@kernel.org,
        zong.li@sifive.com, mchehab+samsung@kernel.org,
        linux-riscv@lists.infradead.org, alex.shi@linux.alibaba.com,
        will@kernel.org, ardb@kernel.org, linux-arch@vger.kernel.org,
        paulmck@kernel.org, alex@ghiti.fr, bgolaszewski@baylibre.com,
        masahiroy@kernel.org, linux@armlinux.org.uk, willy@infradead.org,
        takahiro.akashi@linaro.org, james.morse@arm.com,
        kernel-team@android.com, Arnd Bergmann <arnd@arndb.de>,
        pmladek@suse.com, elver@google.com, aou@eecs.berkeley.edu,
        keescook@chromium.org, uwe@kleine-koenig.org, rostedt@goodmis.org,
        broonie@kernel.org, davidgow@google.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        dan.j.williams@intel.com, andriy.shevchenko@linux.intel.com,
        gxt@pku.edu.cn, linux-arm-kernel@lists.infradead.org,
        Nick Desaulniers <ndesaulniers@google.com>, tglx@linutronix.de,
        rdunlap@infradead.org, matti.vaittinen@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org, mcgrof@kernel.org,
        Palmer Dabbelt <palmer@dabbelt.com>, mhiramat@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net
Subject: Re: [PATCH 1/5] lib: Add a generic version of devmem_is_allowed()
Message-ID: <20200710055124.GA30265@infradead.org>
References: <20200709200552.1910298-1-palmer@dabbelt.com>
 <20200709200552.1910298-2-palmer@dabbelt.com>
 <20200709204921.GJ781326@linux.ibm.com>
 <20200710053850.GA27019@infradead.org>
 <a037dac961c989d027eab293a0280643@mailhost.ics.forth.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a037dac961c989d027eab293a0280643@mailhost.ics.forth.gr>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 10, 2020 at 08:48:17AM +0300, Nick Kossifidis wrote:
> ???????? 2020-07-10 08:38, Christoph Hellwig ????????????:
> > On Thu, Jul 09, 2020 at 11:49:21PM +0300, Mike Rapoport wrote:
> > > > +#ifndef CONFIG_GENERIC_DEVMEM_IS_ALLOWED
> > > > +extern int devmem_is_allowed(unsigned long pfn);
> > > > +#endif
> > 
> > Nit: no need for the extern here.
> > 
> > > > +config GENERIC_LIB_DEVMEM_IS_ALLOWED
> > > > +	bool
> > > > +	select ARCH_HAS_DEVMEM_IS_ALLOWED
> > > 
> > > This seems to work the other way around from the usual Kconfig chains.
> > > In the most cases ARCH_HAS_SOMETHING selects GENERIC_SOMETHING.
> > > 
> > > I believe nicer way would be to make
> > > 
> > > config STRICT_DEVMEM
> > > 	bool "Filter access to /dev/mem"
> > > 	depends on MMU && DEVMEM
> > > 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED ||
> > > GENERIC_LIB_DEVMEM_IS_ALLOWED
> > > 
> > > config GENERIC_LIB_DEVMEM_IS_ALLOWED
> > > 	bool
> > > 
> > > and then s/select ARCH_HAS_DEVMEM_IS_ALLOWED/select
> > > GENERIC_LIB_DEVMEM_IS_ALLOWED/
> > > in the arch Kconfigs and drop ARCH_HAS_DEVMEM_IS_ALLOWED in the end.
> > 
> > To take a step back:  Is there any reason to not just always
> > STRICT_DEVMEM? Maybe for a few architectures that don't currently
> > support a strict /dev/mem the generic version isn't quite correct, but
> > someone selecting the option and finding the issue is the best way to
> > figure that out..
> > 
> 
> During prototyping / testing having full access to all physical memory
> through /dev/mem is very useful. We should have it enabled by default but
> leave the config option there so that users / developers can disable it if
> needed IMHO.

I did not suggest to take the config option away.  Just to
unconditionally allow enabling the option on all architectures.
