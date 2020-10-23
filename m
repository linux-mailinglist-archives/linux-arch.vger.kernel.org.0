Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53D13296D98
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462940AbgJWLZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 07:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:40590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S462887AbgJWLZV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 23 Oct 2020 07:25:21 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7521F20874;
        Fri, 23 Oct 2020 11:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603452320;
        bh=80IGgVr3jLT0tbKyUqY9AiiK9kcb+f4SmS4LteQxqm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hUUB8LRrYirMa7dtXS99Rfw/OcLZjncqFjJU853emGSXkp21c3O94EkA3aY/IDq4T
         oQcoVwm2lzKE2+mou3F94TBpdoMDQFhh2aJfUdKjnesllLLdWgmKfx40YI66uhZr6+
         K6Ge3tlkjn7ZZS9Nhkv+CJC1yQjQ3nR7lndklDCk=
Date:   Fri, 23 Oct 2020 12:25:15 +0100
From:   Will Deacon <will@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
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
Message-ID: <20201023112514.GE20933@willie-the-truck>
References: <87wo34tbas.fsf@mpe.ellerman.id.au>
 <2f9b7d02-9e2f-4724-2608-c5573f6507a2@csgroup.eu>
 <6862421a-5a14-2e38-b825-e39e6ad3d51d@csgroup.eu>
 <87imd5h5kb.fsf@mpe.ellerman.id.au>
 <CAJwJo6ZANqYkSHbQ+3b+Fi_VT80MtrzEV5yreQAWx-L8j8x2zA@mail.gmail.com>
 <87a6yf34aj.fsf@mpe.ellerman.id.au>
 <20200921112638.GC2139@willie-the-truck>
 <ad72ffd3-a552-cc98-7545-d30285fd5219@csgroup.eu>
 <542145eb-7d90-0444-867e-c9cbb6bdd8e3@gmail.com>
 <ba9861da-2f5b-a649-5626-af00af634546@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba9861da-2f5b-a649-5626-af00af634546@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Oct 23, 2020 at 01:22:04PM +0200, Christophe Leroy wrote:
> Hi Dmitry,
> 
> Le 28/09/2020 à 17:08, Dmitry Safonov a écrit :
> > On 9/27/20 8:43 AM, Christophe Leroy wrote:
> > > 
> > > 
> > > Le 21/09/2020 à 13:26, Will Deacon a écrit :
> > > > On Fri, Aug 28, 2020 at 12:14:28PM +1000, Michael Ellerman wrote:
> > > > > Dmitry Safonov <0x7f454c46@gmail.com> writes:
> > [..]
> > > > > > I'll cook a patch for vm_special_mapping if you don't mind :-)
> > > > > 
> > > > > That would be great, thanks!
> > > > 
> > > > I lost track of this one. Is there a patch kicking around to resolve
> > > > this,
> > > > or is the segfault expected behaviour?
> > > > 
> > > 
> > > IIUC dmitry said he will cook a patch. I have not seen any patch yet.
> > 
> > Yes, sorry about the delay - I was a bit busy with xfrm patches.
> > 
> > I'll send patches for .close() this week, working on them now.
> 
> I haven't seen the patches, did you sent them out finally ?

I think it's this series:

https://lore.kernel.org/r/20201013013416.390574-1-dima@arista.com

but they look really invasive to me, so I may cook a small hack for arm64
in the meantine / for stable.

Will
