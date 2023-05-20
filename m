Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72CD870A889
	for <lists+linux-arch@lfdr.de>; Sat, 20 May 2023 16:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjETOpw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 20 May 2023 10:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjETOpv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 20 May 2023 10:45:51 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2B221109;
        Sat, 20 May 2023 07:45:49 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 2991992009D; Sat, 20 May 2023 16:45:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 1CA6092009B;
        Sat, 20 May 2023 15:45:47 +0100 (BST)
Date:   Sat, 20 May 2023 15:45:47 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Arnd Bergmann <arnd@arndb.de>
cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Baoquan He <bhe@redhat.com>,
        Huacai Chen <chenhuacai@kernel.org>
Subject: Re: [PATCH v4] mips: add <asm-generic/io.h> including
In-Reply-To: <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
Message-ID: <alpine.DEB.2.21.2305201531101.27887@angie.orcam.me.uk>
References: <20230519195135.79600-1-jiaxun.yang@flygoat.com> <dae342ed-8999-4fa5-b719-322182580025@app.fastmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 19 May 2023, Arnd Bergmann wrote:

> On most other architectures, we also don't define __raw_readq()
> and __raw_writeq() on 32-bit because they lose the atomicity that
> might be required for FIFO accesses, but the existing MIPS version
> has them, so changing those should be a separate patch after it
> can be shown to not break anything.

 With MIPS we have:

	if (sizeof(type) != sizeof(u64) || sizeof(u64) == sizeof(long)) \
		*__mem = __val;						\
	else if (cpu_has_64bits) {					\
		unsigned long __flags;					\
		type __tmp;						\
									\
		if (irq)						\
			local_irq_save(__flags);			\
		__asm__ __volatile__(					\
			".set	push"		"\t\t# __writeq""\n\t"	\
			".set	arch=r4000"			"\n\t"	\
			"dsll32 %L0, %L0, 0"			"\n\t"	\
			"dsrl32 %L0, %L0, 0"			"\n\t"	\
			"dsll32 %M0, %M0, 0"			"\n\t"	\
			"or	%L0, %L0, %M0"			"\n\t"	\
			"sd	%L0, %2"			"\n\t"	\
			".set	pop"				"\n"	\
			: "=r" (__tmp)					\
			: "0" (__val), "m" (*__mem));			\
		if (irq)						\
			local_irq_restore(__flags);			\
	} else								\
		BUG();							\

etc. so we don't actually lose atomicity, because we always use 64-bit 
operations (SD above, store-doubleword) and we BUG if they are not there 
(i.e. with 32-bit hardware; not a build-time check as in principle the 
same 32-bit kernel image ought to run just fine both on 32-bit and 64-bit 
hardware).  A few MIPS platforms do use them, e.g. SB1250, which requires 
64-bit unswapped accesses to SoC registers.

  Maciej
