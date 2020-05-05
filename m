Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8F121C568B
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 15:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729022AbgEENQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 5 May 2020 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729019AbgEENQ3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 5 May 2020 09:16:29 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C31C061A0F;
        Tue,  5 May 2020 06:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MB282HLZkeyYhgLoz3UzvjWBjtseuypJMoQRy7x6wmU=; b=1uVH8dV30INpdk9iqTu+UxJiJ
        ApkVzBDRp1hvwrn1MEk70bp0j+d5oqaTrdBJ62gec4/5fN7BzLR5xD6gCdG+lZO1FWDB5r7X3Rof6
        veb6S7/h86xM6xQEpIGOYHVW8Bl0S8VjUHKY9chFQ7mnjAx7CWTlWjeR+Qxl9OLnUYKI9iwA2Dqgf
        kn1gYq1vQIK1VufPto2p/wbwVobs88Z39Msi8Vinde2ujrHbb47O/5eQDGwEitDNqXOhR5M0ZMrWg
        eqpUIgwt4+wWF6Wd3xld/RFuWc1LY0W8VW3ik4aKyW7XyOCsR9sc/317qMD3vC5EVxoJce7n34mKW
        8YSpJA3OA==;
Received: from shell.armlinux.org.uk ([2002:4e20:1eda:1:5054:ff:fe00:4ec]:54034)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jVxQr-0002Yl-H2; Tue, 05 May 2020 14:16:21 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jVxQp-0007BJ-Ro; Tue, 05 May 2020 14:16:19 +0100
Date:   Tue, 5 May 2020 14:16:19 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Will Deacon <will@kernel.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        linux-man@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: RFC: Adding arch-specific user ABI documentation in linux-man
Message-ID: <20200505131619.GG1551@shell.armlinux.org.uk>
References: <20200504153214.GH30377@arm.com>
 <20200505104454.GC19710@willie-the-truck>
 <20200505124351.GF1551@shell.armlinux.org.uk>
 <20200505130629.GK19710@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200505130629.GK19710@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 05, 2020 at 02:06:30PM +0100, Will Deacon wrote:
> On Tue, May 05, 2020 at 01:43:51PM +0100, Russell King - ARM Linux admin wrote:
> > On Tue, May 05, 2020 at 11:44:55AM +0100, Will Deacon wrote:
> > > Michael has been nagging me on and off about that for, what, 10 years now?
> > > I would therefore be very much in favour of having our ptrace extensions
> > > documented!
> > > 
> > > We could even put this stuff under Documentation/arm64/man/ if it's deemed
> > > too CPU-specific for the man-pages project, but my preference would still
> > > be for it to be hosted there alongside all the other man pages.
> > 
> > Stuffing random things into the kernel tree is painful for some people.
> > 
> > For example, if you cross-build your kernel, then the stuff in the
> > tools/ subdirectory is totally useless (I think everything except
> > perf) because you can't build it.
> > 
> > Let's stop making the mistake of constantly shoving stuff into the
> > kernel source tree.
> 
> For userspace tools, I'm inclined to agree, but this is just documentation
> so it shouldn't cause any issues with cross building. But to be clear: I'd
> still prefer it to be part of the man-pages project, and would only consider
> it for inclusion in the kernel tree if it was rejected for being too
> CPU-specific.

I don't think that should be a concern; the man-pages project already
contains documentation that is specific to kernel versions, including
documentation for interfaces that are architecture specific (such as
prctl is a big one, ptrace to a lesser extent.)  syscall(2) contains
a whole bunch of architecture stuff about the calling convention for
syscalls.

Interestingly, I notice that syscall(2) is wrong for arm/OABI. I am
not surprised, because that documentation never came my way, and I am
the author of the kernel's OABI syscall interface.

It claims:

       arch/ABI      arg1  arg2  arg3  arg4  arg5  arg6  arg7  Notes
       ──────────────────────────────────────────────────────────────
       arm/OABI      a1    a2    a3    a4    v1    v2    v3

whereas, at the time I invented it, I decided that it shall pass
arguments in r0 to r6.  That's r0 to r6.  Not the APCS register
names that this document claims.  Not everything in OABI is APCS,
as illustrated here - APCS passes the first four arguments in a1
to a4, and then the rest on the stack.  The OABI syscall interface
doesn't do that.

I guess that's what happens when someone else writes interface
documentation and doesn't bother to get it reviewed by those who
created the interface in the first place.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
