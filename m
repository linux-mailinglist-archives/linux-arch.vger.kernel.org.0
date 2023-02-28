Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 573DF6A5E45
	for <lists+linux-arch@lfdr.de>; Tue, 28 Feb 2023 18:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjB1Re7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Feb 2023 12:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjB1Re6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Feb 2023 12:34:58 -0500
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296601EBD7;
        Tue, 28 Feb 2023 09:34:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bN8lETEGtH3eSCzqdqNXhuD99n9DHCrwwsYdF542otk=; b=tlM7n0Xf2FPdjnh6I1lRD/dMeA
        /hXzqbpV8RRtbLC1sDVsgtMEN7cikGeK3Z5yneR36FFONPjOZYDhLmOP/tyJMoxJHxpZVcoVnVV0M
        syx0lJ1Po6cnoqtkr5LVPcY5p0oj3P5gJV5Wm7cl3V/2lA269sPqGXI3qSuox0K2VHs51kQDHSTfm
        lUncCtO7g0VDFwoVXw7wGG2YSp29ouOnhFFV0dGyHRGISsU+Gw86N7WhFw1pGsETFEz5N+P6P8lb6
        0P3epZK72dBTYM3LK14Md4g++i+Xn8vyTQ2iKpNruxRo8PZF/qH7Ax8EFV0zWBStHnqUwCar2xFby
        +gfd/aUQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1pX3sK-00CtWb-2k;
        Tue, 28 Feb 2023 17:34:52 +0000
Date:   Tue, 28 Feb 2023 17:34:52 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arch@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, Michal Simek <monstr@monstr.eu>,
        Dinh Nguyen <dinguyen@kernel.org>,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, sparclinux@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 08/10] parisc: fix livelock in uaccess
Message-ID: <Y/47PMmpLDX5lPWx@ZenIV>
References: <Y9lz6yk113LmC9SI@ZenIV>
 <Y9l0w4M91DwYLO3N@ZenIV>
 <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84b1c2e4-c096-ed19-9701-472b54a4890c@gmx.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 06, 2023 at 05:58:02PM +0100, Helge Deller wrote:
> Hi Al,
> 
> On 1/31/23 21:06, Al Viro wrote:
> > parisc equivalent of 26178ec11ef3 "x86: mm: consolidate VM_FAULT_RETRY handling"
> > If e.g. get_user() triggers a page fault and a fatal signal is caught, we might
> > end up with handle_mm_fault() returning VM_FAULT_RETRY and not doing anything
> > to page tables.  In such case we must *not* return to the faulting insn -
> > that would repeat the entire thing without making any progress; what we need
> > instead is to treat that as failed (user) memory access.
> > 
> > Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> > ---
> >   arch/parisc/mm/fault.c | 5 ++++-
> >   1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/parisc/mm/fault.c b/arch/parisc/mm/fault.c
> > index 869204e97ec9..bb30ff6a3e19 100644
> > --- a/arch/parisc/mm/fault.c
> > +++ b/arch/parisc/mm/fault.c
> > @@ -308,8 +308,11 @@ void do_page_fault(struct pt_regs *regs, unsigned long code,
> > 
> >   	fault = handle_mm_fault(vma, address, flags, regs);
> > 
> > -	if (fault_signal_pending(fault, regs))
> > +	if (fault_signal_pending(fault, regs)) {
> > +		if (!user_mode(regs))
> > +			goto no_context;
> >   		return;
> > +	}
> 
> The testcase in
>   https://lore.kernel.org/lkml/20170822102527.GA14671@leverpostej/
>   https://lore.kernel.org/linux-arch/20210121123140.GD48431@C02TD0UTHF1T.local/
> does hang with and without above patch on parisc.
> It does not consume CPU in that state and can be killed with ^C.
> 
> Any idea?

	Still trying to resurrect the parisc box to test on it...
FWIW, right now I've locally confirmed that mainline has the bug
in question and that patch fixes it for alpha, sparc32 and sparc64;
hexagon, m68k and riscv got acks from other folks; microblaze,
nios2 and openrisc I can't test at all (no hardware, no qemu setup);
same for parisc64.  Itanic and parisc32 I might be able to test,
if I manage to resurrect the hardware.

	Just to confirm: your "can be killed with ^C" had been on the
mainline parisc kernel (with userfaultfd enable, of course, or it wouldn't
hang up at all), right?  Was it 32bit or 64bit kernel?
