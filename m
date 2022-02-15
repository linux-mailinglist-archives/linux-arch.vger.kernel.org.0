Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00924B5F45
	for <lists+linux-arch@lfdr.de>; Tue, 15 Feb 2022 01:48:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiBOAsR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 19:48:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBOAsQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 19:48:16 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F6A1133E6;
        Mon, 14 Feb 2022 16:48:08 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nJm0h-001pkI-9F; Tue, 15 Feb 2022 00:48:03 +0000
Date:   Tue, 15 Feb 2022 00:48:03 +0000
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
Subject: Re: [PATCH 11/14] sparc64: remove CONFIG_SET_FS support
Message-ID: <Ygr4Q2/KxfF86ETa@zeniv-ca.linux.org.uk>
References: <20220214163452.1568807-1-arnd@kernel.org>
 <20220214163452.1568807-12-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214163452.1568807-12-arnd@kernel.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 14, 2022 at 05:34:49PM +0100, Arnd Bergmann wrote:

> -/*
> - * Sparc64 is segmented, though more like the M68K than the I386.
> - * We use the secondary ASI to address user memory, which references a
> - * completely different VM map, thus there is zero chance of the user
> - * doing something queer and tricking us into poking kernel memory.

Actually, this part of comment probably ought to stay - it is relevant
for understanding what's going on (e.g. why is access_ok() always true, etc.)
