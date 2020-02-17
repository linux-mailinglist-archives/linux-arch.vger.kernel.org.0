Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD892161836
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 17:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728995AbgBQQqR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Feb 2020 11:46:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:41174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728736AbgBQQqR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 17 Feb 2020 11:46:17 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5D1C214D8;
        Mon, 17 Feb 2020 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581957976;
        bh=/DaX8+TZSwBPiTZVH9FgOz76O3KL16JyFS/ijkhuk44=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XKRFlaKp1IYIDGXDUJvH5mH8wXq/PXWxby8tJqhb0Gldfy+UFk8+5flsOaGzmHdfo
         HlDNAYeeQrm/bDaFOCjFhUdWXO6SEKGWsxUiE0Of4uCTM0915fDbv4hNzC3UL8lKqY
         xrdgGSn1GXDrxC+bKBaQ4bujFS0dC8o+hjZV23us=
Date:   Mon, 17 Feb 2020 16:46:09 +0000
From:   Will Deacon <will@kernel.org>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        linux-arch@vger.kernel.org, ndesaulniers@google.com,
        0x7f454c46@gmail.com, avagin@openvz.org, arnd@arndb.de,
        sboyd@kernel.org, catalin.marinas@arm.com, x86@kernel.org,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, clang-built-linux@googlegroups.com,
        paul.burton@mips.com, mingo@redhat.com, bp@alien8.de,
        luto@kernel.org, linux@armlinux.org.uk, tglx@linutronix.de,
        salyzyn@android.com, pcc@google.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 19/19] arm64: vdso32: Enable Clang Compilation
Message-ID: <20200217164608.GA2708@willie-the-truck>
References: <20200213161614.23246-1-vincenzo.frascino@arm.com>
 <20200213161614.23246-20-vincenzo.frascino@arm.com>
 <20200213184454.GA4663@ubuntu-m2-xlarge-x86>
 <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cee3707-d526-3766-3dde-543c8dbd8e68@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Feb 17, 2020 at 12:26:16PM +0000, Vincenzo Frascino wrote:
> On 13/02/2020 18:44, Nathan Chancellor wrote:
> > On Thu, Feb 13, 2020 at 04:16:14PM +0000, Vincenzo Frascino wrote:
> >> Enable Clang Compilation for the vdso32 library.
> 
> [...]
> 
> >> +LD_COMPAT ?= $(CROSS_COMPILE_COMPAT)gcc
> > 
> > Well this is unfortunate :/
> > 
> > It looks like adding the --target flag to VDSO_LDFLAGS allows
> > clang to link the vDSO just fine although it does warn that -nostdinc
> > is unused:
> > 
> > clang-11: warning: argument unused during compilation: '-nostdinc'
> > [-Wunused-command-line-argument]
> >
> 
> This is why ended up in this "unfortunate" situation :) I wanted to avoid the
> warning.
> 
> > It would be nice if the logic of commit fe00e50b2db8 ("ARM: 8858/1:
> > vdso: use $(LD) instead of $(CC) to link VDSO") could be adopted here
> > but I get that this Makefile is its own beast :) at the very least, I
> > think that the --target flag should be added to VDSO_LDFLAGS so that gcc
> > is not a requirement for this but I am curious if you tried that already
> > and noticed any issues with it.
> > 
> 
> --target is my preferred way as well, I can try to play another little bit with
> the flags and see what I can come up with in the next version.

Yes, please. I'd even prefer the warning rather than silently assuming that
a cross gcc is kicking around on the path.

Will
