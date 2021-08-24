Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3561A3F6B6C
	for <lists+linux-arch@lfdr.de>; Tue, 24 Aug 2021 23:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238684AbhHXV5r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Aug 2021 17:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237178AbhHXV5r (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Aug 2021 17:57:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7011AC061764
        for <linux-arch@vger.kernel.org>; Tue, 24 Aug 2021 14:57:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id k14so21112611pga.13
        for <linux-arch@vger.kernel.org>; Tue, 24 Aug 2021 14:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA7HjuVr8UM0YrbUtH7xcK5mGIk2G9+Axy1XWOoFNYg=;
        b=WsBX54BBkcv11FQPj9OpoaF+eiQb8uX8aKiArIgUDrBIDwtG3b3K65ZX6ebBjitNbN
         w4lUM9y8oGz/tR3k3Zes2iqrAer9nCavy8Gef4NMWt8VTh8WP99eVbvwz7tkCjz4bHrq
         vAbZ8Ec6ssdwu8Vug8/ZEHTYcy8EBLuOfy6qwkqNjb6xNwc80u1Guda8rci8qOfunYZ0
         tpvzRodESKY7xx/aQWat6XsESTC/QWfHfZ+7nW5YmDN2ExMsidGq069RxDz3mdPWGeXC
         OP3Af9IIu+FHi8O+HMr5M/iBE1ePbCqYmUUW9YDYLHWdc0H+pZXOSjb/GoYe4tnuXRJP
         7sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA7HjuVr8UM0YrbUtH7xcK5mGIk2G9+Axy1XWOoFNYg=;
        b=IweeiIY1fTsKBpXybwrQJKUH3rvmHaq8ODAy19k6iQIJCXOFpJKKQ5tZh8Exp8wd0u
         5DMo8/dI/EVU7DJ6jrXXm4EUt3t1AvKIWavtMFD+vd37KczCH9wqdFKkZvxOIV8NJ9X9
         +27iWe02JpPBOBxTBnZUj+t3NHPQ7yI7Vv4qgGsPOuGL9zapoB33TypLusfMZ6V8/v0K
         /UY1M8kI4KMrsTsfy6cBMZ1wec/Wf5ka1AgUkF6g4IQ2gZBNzUmKN8Pvdbc8W7ZHF5H6
         avSbUNlMhVe6C/aBRaRObNTxSe3r2hHU7pW435I1pS+iQcEY7U4za2WFU6F9lpt0mG28
         62fQ==
X-Gm-Message-State: AOAM533pGYLglxlW1Xsh/C/ZEGY1GM2fOyP2GP1zQ730Kf6920mRGCHS
        0GWYJQfGIVypettWvXMwq1ZyqYGRRkNGy9sA3nL1rA==
X-Google-Smtp-Source: ABdhPJyr0CTHqNS+oxGCjiahAYIwaeoO77gnKnjQxNHphuUI7On2QWYfyaYCmnakkxWh6GLExG3xdOXsxrdjbXSK1NY=
X-Received: by 2002:a65:414a:: with SMTP id x10mr26273786pgp.403.1629842221742;
 Tue, 24 Aug 2021 14:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org> <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
In-Reply-To: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 24 Aug 2021 14:56:25 -0700
Message-ID: <CACK8Z6E+__kZqU8mVUnYhFc0wz_e81qBLO3ffqSDghVtztNeQw@mail.gmail.com>
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        X86 ML <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 23, 2021 at 6:06 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Mon, Aug 23, 2021 at 5:31 PM Kuppuswamy, Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:
> >
> >
> >
> > On 8/23/21 4:56 PM, Michael S. Tsirkin wrote:
> > >> Add a new variant of pci_iomap for mapping all PCI resources
> > >> of a devices as shared memory with a hypervisor in a confidential
> > >> guest.
> > >>
> > >> Signed-off-by: Andi Kleen<ak@linux.intel.com>
> > >> Signed-off-by: Kuppuswamy Sathyanarayanan<sathyanarayanan.kuppuswamy@linux.intel.com>
> > > I'm a bit puzzled by this part. So why should the guest*not*  map
> > > pci memory as shared? And if the answer is never (as it seems to be)
> > > then why not just make regular pci_iomap DTRT?
> >
> > It is in the context of confidential guest (where VMM is un-trusted). So
> > we don't want to make all PCI resource as shared. It should be allowed
> > only for hardened drivers/devices.
>
> That's confusing, isn't device authorization what keeps unaudited
> drivers from loading against untrusted devices? I'm feeling like
> Michael that this should be a detail that drivers need not care about
> explicitly, in which case it does not need to be exported because the
> detail can be buried in lower levels.
>
> Note, I specifically said "unaudited", not "hardened" because as Greg
> mentioned the kernel must trust drivers, its devices that may not be
> trusted.

Can you please point me to the thread where this discussion with Greg
is ongoing?

Thanks,

Rajat
