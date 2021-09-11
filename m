Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF39407AF6
	for <lists+linux-arch@lfdr.de>; Sun, 12 Sep 2021 01:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234320AbhIKXz7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 11 Sep 2021 19:55:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45346 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234564AbhIKXz6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Sat, 11 Sep 2021 19:55:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631404485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XhzTiX0DZYV1X5ckSDoJZp4U7aZCZRTdTtc5atz14SI=;
        b=HIYOtFgY4HxMNyU0nzLti5A8vG2pVu6p4v3N2hqr9VCqnSjvaEgH03c0xLylchB2XX6JhZ
        MZja69E6+/mBnkFFoaH07qfH2BNOXewJXF/fF6FcQeepTpcoGIs0L1KGN//6havxYew7HX
        7hUkBeY6or6zno1I58JXf2KSUB2lf60=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-OlotW8cuP9uV0QNfb_KVfQ-1; Sat, 11 Sep 2021 19:54:44 -0400
X-MC-Unique: OlotW8cuP9uV0QNfb_KVfQ-1
Received: by mail-ej1-f72.google.com with SMTP id ga42-20020a1709070c2a00b005dc8c1cc3a1so2256637ejc.17
        for <linux-arch@vger.kernel.org>; Sat, 11 Sep 2021 16:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XhzTiX0DZYV1X5ckSDoJZp4U7aZCZRTdTtc5atz14SI=;
        b=4iWi6MQm7yB275RvAR7JjMqpg4gtsRxqwZMIoK+eYr8VOTesf1q6u8IXITNcfKaSoN
         i9wyZL/TP57OdnUlJQZLGJ7Q7wZG0PE1q6IAoqVUByxnYUSblQy7FGypO2ozZ3Laflol
         uAbxADUmRiHkzOI6PYtlbUFuQxf6iLVzMfybW61jeaCU6Xg8yHhPKm3dIT/LetzXtPco
         965LWPTWr+xljAQ3NuztHgEMGqsOAG5KlYXyGtljmnXdvkg/94HEAI3A9HwL/VqTl63R
         xjLQhFfR1QvcG4u/+/ALGZjKm/pzXNpNYVhs7P5VSE++qDKkx8ZgIYCF83VOTL28s95j
         Ylpw==
X-Gm-Message-State: AOAM531KLDFZ53Q7pParN8wQL5qMec/cTmhqBMbjhIAozrrAUPydlmmA
        Wzj6G26seDTooctWTHsz7YYZRJ9TEc7uXFBPTiTrCz5BYsvckFlxnS2ZAAu2gOVsNMR9WYmXPcN
        dlgM8cM3rgcq73YO5Qm3yPg==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr4944802ejs.230.1631404482985;
        Sat, 11 Sep 2021 16:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzUJ/Dz7qpoDYQNg7a7mY8Cl7pe7fwOabdq++HQzqfzjVSc2KbxoH+7byBLBBXMvIdUmNqg2Q==
X-Received: by 2002:a17:906:5855:: with SMTP id h21mr4944788ejs.230.1631404482774;
        Sat, 11 Sep 2021 16:54:42 -0700 (PDT)
Received: from redhat.com ([2.55.27.174])
        by smtp.gmail.com with ESMTPSA id n13sm1309780ejk.97.2021.09.11.16.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 16:54:41 -0700 (PDT)
Date:   Sat, 11 Sep 2021 19:54:36 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
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
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
Message-ID: <20210911195006-mutt-send-email-mst@kernel.org>
References: <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
 <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 10, 2021 at 09:34:45AM -0700, Andi Kleen wrote:
> > > that's why
> > > an extra level of defense of ioremap opt-in is useful.
> > OK even assuming this, why is pci_iomap opt-in useful?
> > That never happens before probe - there's simply no pci_device then.
> 
> 
> Hmm, yes that's true. I guess we can make it default to opt-in for
> pci_iomap.
> 
> It only really matters for device less ioremaps.

OK. And same thing for other things with device, such as
devm_platform_ioremap_resource.
If we agree on all that, this will basically remove virtio
changes from the picture ;)

-- 
MST

