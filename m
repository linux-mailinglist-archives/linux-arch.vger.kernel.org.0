Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50443186680
	for <lists+linux-arch@lfdr.de>; Mon, 16 Mar 2020 09:30:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730178AbgCPIa3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 16 Mar 2020 04:30:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:53400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730016AbgCPIa2 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 16 Mar 2020 04:30:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C03CF20658;
        Mon, 16 Mar 2020 08:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584347426;
        bh=GJ8GsEypd+i+4W9htj3qLpzQtn+OsOQ9mGSyV2/R7dA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aO/QdzZIFo1XvwNhvNiWRREapqKvMl1JtbC2hByDGtwxxWiPLc8FMNy1H3SN2m+Lv
         HrJyKp++eqtMyv7/6pUJ4mP2NYJy9OfRPytBOLRGsbhN+9dElVQQ92E7u4rwZ03INc
         K2y4pim3uAIqEEP/OBj07CjTShjFfqgLzx2t7lM4=
Date:   Mon, 16 Mar 2020 09:30:24 +0100
From:   gregkh <gregkh@linuxfoundation.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-hyperv@vger.kernel.org,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>, olaf@aepfle.de,
        Andy Whitcroft <apw@canonical.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jason Wang <jasowang@redhat.com>, marcelo.cerri@canonical.com,
        "K. Y. Srinivasan" <kys@microsoft.com>, sunilmut@microsoft.com,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v6 04/10] arm64: hyperv: Add memory alloc/free functions
 for Hyper-V size pages
Message-ID: <20200316083024.GA3204377@kroah.com>
References: <1584200119-18594-1-git-send-email-mikelley@microsoft.com>
 <1584200119-18594-5-git-send-email-mikelley@microsoft.com>
 <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2Hnm74aUMNFHbjMr4HwHGZn1+xa4ERsxAJY6hMzhEOhQ@mail.gmail.com>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Mar 16, 2020 at 09:22:43AM +0100, Arnd Bergmann wrote:
> On Sat, Mar 14, 2020 at 4:36 PM Michael Kelley <mikelley@microsoft.com> wrote:
> >  /*
> > + * Functions for allocating and freeing memory with size and
> > + * alignment HV_HYP_PAGE_SIZE. These functions are needed because
> > + * the guest page size may not be the same as the Hyper-V page
> > + * size. We depend upon kmalloc() aligning power-of-two size
> > + * allocations to the allocation size boundary, so that the
> > + * allocated memory appears to Hyper-V as a page of the size
> > + * it expects.
> > + *
> > + * These functions are used by arm64 specific code as well as
> > + * arch independent Hyper-V drivers.
> > + */
> > +
> > +void *hv_alloc_hyperv_page(void)
> > +{
> > +       BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
> > +       return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
> > +}
> > +EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
> 
> I don't think there is any guarantee that kmalloc() returns page-aligned
> allocations in general. How about using get_free_pages()
> to implement this?

Even if it was guaranteed, a pointless wrapper like this is not needed
or ok, and shouldn't be created, just use kmalloc.

thanks,

greg k-h
