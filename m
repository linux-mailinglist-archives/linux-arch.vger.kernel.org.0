Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F043E445BC7
	for <lists+linux-arch@lfdr.de>; Thu,  4 Nov 2021 22:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhKDVrZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 Nov 2021 17:47:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:53016 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231154AbhKDVrZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 4 Nov 2021 17:47:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E73D6120F;
        Thu,  4 Nov 2021 21:44:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1636062286;
        bh=j99yLbawhP8nS65VSNwoVEG61+ELDW3rr3unGR3UBCg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=xYAjZ8zs9+oJOMxv1KXwonQ+aKbWfMmO7HfIsxDFjLoqTAj3LyGtnvu5GAHO6i8F6
         tTLnvU37UqoYDFqxPz0RM33U6DPFdsgJFgmUGeovTBXOeZZ1uqUtmKClxR9BsD+2R8
         BoNWN1J1HRZWj563lpDBMFRDadPRbxs05FsdJ6oM=
Date:   Thu, 4 Nov 2021 14:44:42 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>, arnd@arndb.de,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/4] mm: Make generic arch_is_kernel_initmem_freed()
 do what it says
Message-Id: <20211104144442.7130ae4a104fca70623a2d1a@linux-foundation.org>
In-Reply-To: <87ilyhmd26.fsf@linkitivity.dja.id.au>
References: <9ecfdee7dd4d741d172cb93ff1d87f1c58127c9a.1633001016.git.christophe.leroy@csgroup.eu>
        <1d40783e676e07858be97d881f449ee7ea8adfb1.1633001016.git.christophe.leroy@csgroup.eu>
        <87ilyhmd26.fsf@linkitivity.dja.id.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, 01 Oct 2021 17:14:41 +1000 Daniel Axtens <dja@axtens.net> wrote:

> >  #ifdef __KERNEL__
> > +/*
> > + * Check if an address is part of freed initmem. After initmem is freed,
> > + * memory can be allocated from it, and such allocations would then have
> > + * addresses within the range [_stext, _end].
> > + */
> > +#ifndef arch_is_kernel_initmem_freed
> > +static int arch_is_kernel_initmem_freed(unsigned long addr)
> > +{
> > +	if (system_state < SYSTEM_FREEING_INITMEM)
> > +		return 0;
> > +
> > +	return init_section_contains((void *)addr, 1);
> 
> Is init_section_contains sufficient here?
> 
> include/asm-generic/sections.h says:
>  * [__init_begin, __init_end]: contains .init.* sections, but .init.text.*
>  *                   may be out of this range on some architectures.
>  * [_sinittext, _einittext]: contains .init.text.* sections
> 
> init_section_contains only checks __init_*:
> static inline bool init_section_contains(void *virt, size_t size)
> {
> 	return memory_contains(__init_begin, __init_end, virt, size);
> }
> 
> Do we need to check against _sinittext and _einittext?
> 
> Your proposed generic code will work for powerpc and s390 because those
> archs only test against __init_* anyway. I don't know if any platform
> actually does place .init.text outside of __init_begin=>__init_end, but
> the comment seems to suggest that they could.
> 

Christophe?
