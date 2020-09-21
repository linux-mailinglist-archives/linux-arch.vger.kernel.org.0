Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAC57272263
	for <lists+linux-arch@lfdr.de>; Mon, 21 Sep 2020 13:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgIUL0p (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 21 Sep 2020 07:26:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:54988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726596AbgIUL0p (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 21 Sep 2020 07:26:45 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A21E207BC;
        Mon, 21 Sep 2020 11:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600687604;
        bh=6qkUWBivB6d2mCVhMcxtD1M5XumohNNJi5WsqPmJtpY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vTQSeX82Ws5VIKwm/ih/WO0oRWpb2WIFKDP4RZRBG1BPT5keDxHQ7dDIZrwB5jXM/
         5Ezay2KVB4c2C8Iv2DcFmGqOcYalfzvB18sB24VnXjqusps8syKY7l3ZCLLcrYk6CY
         0KM7Ttgt75vR+tpliMhpcOxmYQOM3EEwxSlmMHK4=
Date:   Mon, 21 Sep 2020 12:26:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, nathanl@linux.ibm.com,
        linux-arch <linux-arch@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        open list <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v8 2/8] powerpc/vdso: Remove __kernel_datapage_offset and
 simplify __get_datapage()
Message-ID: <20200921112638.GC2139@willie-the-truck>
References: <cover.1588079622.git.christophe.leroy@c-s.fr>
 <0d2201efe3c7727f2acc718aefd7c5bb22c66c57.1588079622.git.christophe.leroy@c-s.fr>
 <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a6yf34aj.fsf@mpe.ellerman.id.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 28, 2020 at 12:14:28PM +1000, Michael Ellerman wrote:
> Dmitry Safonov <0x7f454c46@gmail.com> writes:
> > On Wed, 26 Aug 2020 at 15:39, Michael Ellerman <mpe@ellerman.id.au> wrote:
> >> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> >> We added a test for vdso unmap recently because it happened to trigger a
> >> KAUP failure, and someone actually hit it & reported it.
> >
> > You right, CRIU cares much more about moving vDSO.
> > It's done for each restoree and as on most setups vDSO is premapped and
> > used by the application - it's actively tested.
> > Speaking about vDSO unmap - that's concerning only for heterogeneous C/R,
> > i.e when an application is migrated from a system that uses vDSO to the one
> > which doesn't - it's much rare scenario.
> > (for arm it's !CONFIG_VDSO, for x86 it's `vdso=0` boot parameter)
> 
> Ah OK that explains it.
> 
> The case we hit of VDSO unmapping was some strange "library OS" thing
> which had explicitly unmapped the VDSO, so also very rare.
> 
> > Looking at the code, it seems quite easy to provide/maintain .close() for
> > vm_special_mapping. A bit harder to add a test from CRIU side
> > (as glibc won't know on restore that it can't use vdso anymore),
> > but totally not impossible.
> >
> >> Running that test on arm64 segfaults:
> >>
> >>   # ./sigreturn_vdso
> >>   VDSO is at 0xffff8191f000-0xffff8191ffff (4096 bytes)
> >>   Signal delivered OK with VDSO mapped
> >>   VDSO moved to 0xffff8191a000-0xffff8191afff (4096 bytes)
> >>   Signal delivered OK with VDSO moved
> >>   Unmapped VDSO
> >>   Remapped the stack executable
> >>   [   48.556191] potentially unexpected fatal signal 11.
> >>   [   48.556752] CPU: 0 PID: 140 Comm: sigreturn_vdso Not tainted 5.9.0-rc2-00057-g2ac69819ba9e #190
> >>   [   48.556990] Hardware name: linux,dummy-virt (DT)
> >>   [   48.557336] pstate: 60001000 (nZCv daif -PAN -UAO BTYPE=--)
> >>   [   48.557475] pc : 0000ffff8191a7bc
> >>   [   48.557603] lr : 0000ffff8191a7bc
> >>   [   48.557697] sp : 0000ffffc13c9e90
> >>   [   48.557873] x29: 0000ffffc13cb0e0 x28: 0000000000000000
> >>   [   48.558201] x27: 0000000000000000 x26: 0000000000000000
> >>   [   48.558337] x25: 0000000000000000 x24: 0000000000000000
> >>   [   48.558754] x23: 0000000000000000 x22: 0000000000000000
> >>   [   48.558893] x21: 00000000004009b0 x20: 0000000000000000
> >>   [   48.559046] x19: 0000000000400ff0 x18: 0000000000000000
> >>   [   48.559180] x17: 0000ffff817da300 x16: 0000000000412010
> >>   [   48.559312] x15: 0000000000000000 x14: 000000000000001c
> >>   [   48.559443] x13: 656c626174756365 x12: 7865206b63617473
> >>   [   48.559625] x11: 0000000000000003 x10: 0101010101010101
> >>   [   48.559828] x9 : 0000ffff818afda8 x8 : 0000000000000081
> >>   [   48.559973] x7 : 6174732065687420 x6 : 64657070616d6552
> >>   [   48.560115] x5 : 000000000e0388bd x4 : 000000000040135d
> >>   [   48.560270] x3 : 0000000000000000 x2 : 0000000000000001
> >>   [   48.560412] x1 : 0000000000000003 x0 : 00000000004120b8
> >>   Segmentation fault
> >>   #
> >>
> >> So I think we need to keep the unmap hook. Maybe it should be handled by
> >> the special_mapping stuff generically.
> >
> > I'll cook a patch for vm_special_mapping if you don't mind :-)
> 
> That would be great, thanks!

I lost track of this one. Is there a patch kicking around to resolve this,
or is the segfault expected behaviour?

Will
