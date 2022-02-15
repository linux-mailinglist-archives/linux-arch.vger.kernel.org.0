Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6A844B6414
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 08:13:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234403AbiBOHOB (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Feb 2022 02:14:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbiBOHOA (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 15 Feb 2022 02:14:00 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57232C12C8;
        Mon, 14 Feb 2022 23:13:50 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJs1u-001uPd-Et; Tue, 15 Feb 2022 07:13:42 +0000
Date:   Tue, 15 Feb 2022 07:13:42 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, arnd@arndb.de,
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
Message-ID: <YgtSpk0boDjsyjFK@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-10-arnd@kernel.org>
 <Ygr11RGjj3C9uAUg@zeniv-ca.linux.org.uk>
 <20220215062942.GA12551@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215062942.GA12551@lst.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Feb 15, 2022 at 07:29:42AM +0100, Christoph Hellwig wrote:
> On Tue, Feb 15, 2022 at 12:37:41AM +0000, Al Viro wrote:
> > Perhaps simply wrap that sucker into #ifdef CONFIG_CPU_HAS_ADDRESS_SPACES
> > (and trim the comment down to "coldfire and 68000 will pick generic
> > variant")?
> 
> I wonder if we should invert CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE,
> select the separate address space config for s390, sparc64, non-coldfire
> m68k and mips with EVA and then just have one single access_ok for
> overlapping address space (as added by Arnd) and non-overlapping ones
> (always return true).

parisc is also such...  How about

	select ALTERNATE_SPACE_USERLAND

for that bunch?  While we are at it, how many unusual access_ok() instances are
left after this series?  arm64, itanic, um, anything else?

FWIW, sparc32 has a slightly unusual instance (see uaccess_32.h there); it's
obviously cheaper than generic and I wonder if the trick is legitimate (and
applicable elsewhere, perhaps)...
