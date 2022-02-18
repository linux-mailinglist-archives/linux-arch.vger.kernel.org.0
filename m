Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 436B34BAF94
	for <lists+linux-arch@lfdr.de>; Fri, 18 Feb 2022 03:22:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231493AbiBRCVX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 21:21:23 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:53010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231465AbiBRCVX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 21:21:23 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AE5985674;
        Thu, 17 Feb 2022 18:21:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKstJ-002dCt-8P; Fri, 18 Feb 2022 02:21:01 +0000
Date:   Fri, 18 Feb 2022 02:21:01 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "dalias@libc.org" <dalias@libc.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "jcmvbkbc@gmail.com" <jcmvbkbc@gmail.com>,
        "guoren@kernel.org" <guoren@kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "bcain@codeaurora.org" <bcain@codeaurora.org>,
        "deller@gmx.de" <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "geert@linux-m68k.org" <geert@linux-m68k.org>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        "hca@linux.ibm.com" <hca@linux.ibm.com>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>,
        "green.hu@gmail.com" <green.hu@gmail.com>,
        "shorne@gmail.com" <shorne@gmail.com>,
        "monstr@monstr.eu" <monstr@monstr.eu>,
        "tsbogend@alpha.franken.de" <tsbogend@alpha.franken.de>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        "nickhu@andestech.com" <nickhu@andestech.com>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "richard@nod.at" <richard@nod.at>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "davem@davemloft.net" <davem@davemloft.net>
Subject: Re: [PATCH v2 00/18] clean up asm/uaccess.h, kill set_fs for good
Message-ID: <Yg8CjZwjWYIibrsd@zeniv-ca.linux.org.uk>
References: <20220216131332.1489939-1-arnd@kernel.org>
 <00496df2-f9f2-2547-3ca3-7989e4713d6b@csgroup.eu>
 <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a3_dPbjB23QffnYMtw+5ojfwChrVC8LLMQqNctU7Nh+mQ@mail.gmail.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Feb 17, 2022 at 08:49:59AM +0100, Arnd Bergmann wrote:

> Same here: architectures can already provide a __put_user_fn()
> and __get_user_fn(), to get the generic versions of the interface,
> but few architectures use that. You can actually get all the interfaces
> by just providing raw_copy_from_user() and raw_copy_to_user(),
> but the get_user/put_user versions you get from that are fairly
> inefficient.

FWIW, __{get,put}_user_{8,16,32,64} would probably make it easier to
unify.  That's where the really variable part tends to be, anyway.
IMO __get_user_fn() had been a mistake.

One thing I somewhat dislike about the series is the boilerplate in
asm/uaccess.h instances - #include <asm-generic/access-ok.h> in
a lot of them might make sense as a transitory state, but getting
stuck with those indefinitely...

	BTW, do we need user_addr_max() anymore?  The definition in
asm-generic/access-ok.h is the only one, so ifndef around it is pointless.
