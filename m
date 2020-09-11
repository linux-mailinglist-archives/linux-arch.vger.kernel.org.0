Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A880266899
	for <lists+linux-arch@lfdr.de>; Fri, 11 Sep 2020 21:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725787AbgIKTO4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 11 Sep 2020 15:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgIKTOz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 11 Sep 2020 15:14:55 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A2AC061573
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 12:14:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u8so6944688lff.1
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 12:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lUTLfTAHN/JEc/vY2NZSlPv25B0eM9+I2UvpN7fipvE=;
        b=Clxn1QsgKc2lKUePPSN2NAL/bI5bjfBFRul7KsPI2uaRRhC0MOrKjvIFIZdRmVowg5
         Sj/tT1SzRVgDZ+3t3dHFGme2ZZ2AzNzf/iHPNpa3Fuz0WH5hvvP/wmiJL+the/L7uCVO
         8PyXw3Q3ZjkkDqlxpbtvaLMr+QGOuNdWTmuIw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lUTLfTAHN/JEc/vY2NZSlPv25B0eM9+I2UvpN7fipvE=;
        b=cBkK2SuqYGlEpOClDK6hDgNuu3ZrchhgGi/Fco8Z5RYOihP3q2l/3Er4iL09QhkT/m
         H8v6iQUgiJ3QfwohO92hoAX5Ea8YkeBvhBv/S8bb64NNIDtF6hRn65u0P+IVJSPe+gKH
         dalqNegY80R7Av1jH/NwHx9+3FRkhE1C4QYhSy2VPkWB1KsghLV9nFS5YsXVVneyEkhb
         38/eDR+zdOlHpgDZgR2Vw+scc6u4qLuUdamLDnPIQ3VJ6tZTa06u/VCsIz/o/XVTbhR/
         Jlo+pW6ZipN8AtqVyNKmHzcsbwyzywDdPJ5m94jOBwd+aRvq/HiQaR0R9P/aw2K/zkpj
         ADOA==
X-Gm-Message-State: AOAM532cbZVA+XcaFruvMCMo/ZL1saSKooyMIb6iBTMOyiOpV03pWQPb
        /pWLyZ1Bbk2yVv69UThQi6aRKrYZJJ8R1A==
X-Google-Smtp-Source: ABdhPJw2FOAJfy5CCFQtONdnzX2vo93MvncQS0gDwVMrvIHFd9m+o+oMoJZuPqq+r6fRgWygCPb7jw==
X-Received: by 2002:a19:6c2:: with SMTP id 185mr686262lfg.441.1599851692963;
        Fri, 11 Sep 2020 12:14:52 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id h27sm544775lfj.87.2020.09.11.12.14.52
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 12:14:52 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id z17so6897325lfi.12
        for <linux-arch@vger.kernel.org>; Fri, 11 Sep 2020 12:14:52 -0700 (PDT)
X-Received: by 2002:ac2:4ec7:: with SMTP id p7mr651524lfr.352.1599851382451;
 Fri, 11 Sep 2020 12:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200911070939.GB1362448@hirez.programming.kicks-ass.net> <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
In-Reply-To: <patch.git-2c4880212370.your-ad-here.call-01599849957-ext-4686@work.hours>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 11 Sep 2020 12:09:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0cqRnqT=pBFx+wk3mQVzuCxQ3ea_nYOTyaCG4Ohkk_Q@mail.gmail.com>
Message-ID: <CAHk-=wg0cqRnqT=pBFx+wk3mQVzuCxQ3ea_nYOTyaCG4Ohkk_Q@mail.gmail.com>
Subject: Re: [PATCH] mm/gup: fix gup_fast with dynamic page table folding
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Mike Rapoport <rppt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linux-x86 <x86@kernel.org>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        linux-power <linuxppc-dev@lists.ozlabs.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 11, 2020 at 12:04 PM Vasily Gorbik <gor@linux.ibm.com> wrote:
>
> Currently to make sure that every page table entry is read just once
> gup_fast walks perform READ_ONCE and pass pXd value down to the next
> gup_pXd_range function by value e.g.:
[ ... ]

Ack, this looks sane to me.

I was going to ask how horrible it would be to convert all the other
users, but a quick grep convinced me that yeah, it's only GUP that is
this special, and we don't want to make this interface be the real one
for everything else too..

                Linus
