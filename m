Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BD84C7F39
	for <lists+linux-arch@lfdr.de>; Tue,  1 Mar 2022 01:31:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiCAAcV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 28 Feb 2022 19:32:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiCAAcV (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 28 Feb 2022 19:32:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C81C7764C;
        Mon, 28 Feb 2022 16:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Ulo3aKo1xFoE/cfpZL+xmuPztKVuMRRxvY14DLWAKfs=; b=TZ2cQwur5niBWVC6LB4QbXcHpv
        yGq5XkdOUsSWNRkxXZ+xUu5Ne0aoSxjd3EFSlTw//uzlshcrTXL1WSIBeOMG//K6E9//LBKJUF9Lp
        d7Y8pI7iUxxk/8UV8I9dwPeOHRQJrBUaCR39kXJqEljuLwSEl4MHOJijW5OikAy/N25r3lTVtf1Ag
        oIBnjedmBuxSvxg8dfoYm9DWWD+PZV27EI5OegTGUF4/hMMKXqnxVwYbdXI8kc3CAp+2jMU4yuwUe
        xKeSe/NHCpEfdBmuKjHRWnZEZR6+VRP60/U5O3k1v3b2eE1uOwifrodWENU1y4R33yD4snwtAShBo
        RlwlILPw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57570)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nOqQP-0000ag-Kh; Tue, 01 Mar 2022 00:31:33 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nOqQK-0006cw-KE; Tue, 01 Mar 2022 00:31:28 +0000
Date:   Tue, 1 Mar 2022 00:31:28 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        Christoph Hellwig <hch@infradead.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, sparclinux@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-alpha@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-xtensa@linux-xtensa.org, linux-parisc@vger.kernel.org,
        openrisc@lists.librecores.org, linux-um@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V3 09/30] arm/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Message-ID: <Yh1pYAOiskEQes3p@shell.armlinux.org.uk>
References: <1646045273-9343-1-git-send-email-anshuman.khandual@arm.com>
 <1646045273-9343-10-git-send-email-anshuman.khandual@arm.com>
 <Yhyqjo/4bozJB6j5@shell.armlinux.org.uk>
 <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <542fa048-131e-240b-cc3a-fd4fff7ce4ba@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Mar 01, 2022 at 05:30:41AM +0530, Anshuman Khandual wrote:
> On 2/28/22 4:27 PM, Russell King (Oracle) wrote:
> > On Mon, Feb 28, 2022 at 04:17:32PM +0530, Anshuman Khandual wrote:
> >> This defines and exports a platform specific custom vm_get_page_prot() via
> >> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
> >> macros can be dropped which are no longer needed.
> > 
> > What I would really like to know is why having to run _code_ to work out
> > what the page protections need to be is better than looking it up in a
> > table.
> > 
> > Not only is this more expensive in terms of CPU cycles, it also brings
> > additional code size with it.
> > 
> > I'm struggling to see what the benefit is.
> 
> Currently vm_get_page_prot() is also being _run_ to fetch required page
> protection values. Although that is being run in the core MM and from a
> platform perspective __SXXX, __PXXX are just being exported for a table.
> Looking it up in a table (and applying more constructs there after) is
> not much different than a clean switch case statement in terms of CPU
> usage. So this is not more expensive in terms of CPU cycles.

I disagree.

However, let's base this disagreement on some evidence. Here is the
present 32-bit ARM implementation:

00000048 <vm_get_page_prot>:
      48:       e200000f        and     r0, r0, #15
      4c:       e3003000        movw    r3, #0
                        4c: R_ARM_MOVW_ABS_NC   .LANCHOR1
      50:       e3403000        movt    r3, #0
                        50: R_ARM_MOVT_ABS      .LANCHOR1
      54:       e7930100        ldr     r0, [r3, r0, lsl #2]
      58:       e12fff1e        bx      lr

That is five instructions long.

Please show that your new implementation is not more expensive on
32-bit ARM. Please do so by building a 32-bit kernel, and providing
the disassembly.

I think you will find way more than five instructions in your version -
the compiler will have to issue code to decode the protection bits,
probably using a table of branches or absolute PC values, or possibly
the worst case of using multiple comparisons and branches. It then has
to load constants that may be moved using movw on ARMv7, but on
older architectures would have to be created from multiple instructions
or loaded from the literal pool. Then there'll be instructions to load
the address of "user_pgprot", retrieve its value, and bitwise or that.

Therefore, I fail to see how your approach of getting rid of the table
is somehow "better" than what we currently have in terms of the effect
on the resulting code.

If you don't like the __P and __S stuff and two arch_* hooks, you could
move the table into arch code along with vm_get_page_prot() without the
additional unnecessary hooks, while keeping all the benefits of the
table lookup.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
