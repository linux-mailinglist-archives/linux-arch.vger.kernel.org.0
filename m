Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA702506EB
	for <lists+linux-arch@lfdr.de>; Mon, 24 Aug 2020 19:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHXRwN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Aug 2020 13:52:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:42650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726697AbgHXRwM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Aug 2020 13:52:12 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BC4520639;
        Mon, 24 Aug 2020 17:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598291531;
        bh=MNFS6PDboLGT+g6mK9L7ub5vT45ys8YvcrT15I0Vo6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OS2ucrosJ0TpH9nz+YRfmit1/AlWinwW6eZ2DciR658Qt33t3OxyCkYG3zsNJdLdk
         2EunudEOwmXgoo+zIVyxgzf8pjBdIO4nicEWrNKCaQYOOY66W9FBYBUZVzDNtuiVFn
         FQ1tc1UX9bmQUPhN23aHV5VuFmTCN/mnYg996MTI=
Date:   Mon, 24 Aug 2020 19:52:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     "will@kernel.org" <will@kernel.org>,
        "ardb@kernel.org" <ardb@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "Mark.Rutland@arm.com" <Mark.Rutland@arm.com>,
        "maz@kernel.org" <maz@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        vkuznets <vkuznets@redhat.com>,
        KY Srinivasan <kys@microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>
Subject: Re: [PATCH v7 09/10] arm64: efi: Export screen_info
Message-ID: <20200824175229.GA1227015@kroah.com>
References: <1598287583-71762-1-git-send-email-mikelley@microsoft.com>
 <1598287583-71762-10-git-send-email-mikelley@microsoft.com>
 <20200824173502.GA1161855@kroah.com>
 <MW2PR2101MB1052C68771718B3FB47BB58BD7560@MW2PR2101MB1052.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW2PR2101MB1052C68771718B3FB47BB58BD7560@MW2PR2101MB1052.namprd21.prod.outlook.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 24, 2020 at 05:40:32PM +0000, Michael Kelley wrote:
> From: Greg KH <gregkh@linuxfoundation.org> Sent: Monday, August 24, 2020 10:35 AM
> > 
> > On Mon, Aug 24, 2020 at 09:46:22AM -0700, Michael Kelley wrote:
> > > The Hyper-V frame buffer driver may be built as a module, and
> > > it needs access to screen_info. So export screen_info.
> > >
> > > Signed-off-by: Michael Kelley <mikelley@microsoft.com>
> > > ---
> > >  arch/arm64/kernel/efi.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/arch/arm64/kernel/efi.c b/arch/arm64/kernel/efi.c
> > > index d0cf596..8ff557a 100644
> > > --- a/arch/arm64/kernel/efi.c
> > > +++ b/arch/arm64/kernel/efi.c
> > > @@ -55,6 +55,7 @@ static __init pteval_t
> > create_mapping_protection(efi_memory_desc_t *md)
> > >
> > >  /* we will fill this structure from the stub, so don't put it in .bss */
> > >  struct screen_info screen_info __section(.data);
> > > +EXPORT_SYMBOL(screen_info);
> > 
> > EXPORT_SYMBOL_GPL()?
> > 
> > I have to ask :)
> 
> It's also just EXPORT_SYMBOL(screen_info) in the x86, PowerPC, and Alpha
> architectures. I know that doesn't guarantee it's right, but I'll have to defer
> to the appropriate subsystem maintainers for whether it really should be
> EXPORT_SYMBOL_GPL.

Ok, fair enough, your original patch is fine.

thanks,

greg k-h
