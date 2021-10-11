Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD0E4296E7
	for <lists+linux-arch@lfdr.de>; Mon, 11 Oct 2021 20:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234546AbhJKSbC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 11 Oct 2021 14:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31494 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234537AbhJKSbB (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 11 Oct 2021 14:31:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633976940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=G16gwMe6+CYnKg8tN/Sjy4s4dxSh+B0vWdkeXZ6WaCc=;
        b=Zl6EWmCQoR9O8W46q+A4dRrfHiQTShQFOTcz0tY7PrUuWMyL44KiH19MEOzhf5AxCgzXXQ
        SjoZZuDstLs8pcIf19wDm7AJ7RkABwi6eCGPySFC8DSvEZ0PkUoHx0WxvmuSY1rVjOlvZt
        mpSnNvhZtphISW5C+2iehx2nqi4Iztw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-234-IWDe4k8RP56OaaxuMfbZwA-1; Mon, 11 Oct 2021 14:28:59 -0400
X-MC-Unique: IWDe4k8RP56OaaxuMfbZwA-1
Received: by mail-ed1-f71.google.com with SMTP id v9-20020a50d849000000b003db459aa3f5so14031512edj.15
        for <linux-arch@vger.kernel.org>; Mon, 11 Oct 2021 11:28:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=G16gwMe6+CYnKg8tN/Sjy4s4dxSh+B0vWdkeXZ6WaCc=;
        b=IeJ7CuMybkl1Tbrd24TivBEqcxoyFH4kawACWm7MgXEqW/BVe6wicA98iF+kQVXbzu
         CxXKHSeC9RKT0yOLh0+nyu/3MHBXXjdaNVD2BoVlb5BeVZVnSrrz0G6VXzsrUQaXcHhn
         rzzUitq/fTZLplm1Bny87Eztx0fD+QoV2eMGr9hIMaBooRNzpEbgeOkfW7F3axDJ3+L1
         0222TkatBUwcz2Vdl4GdSeHyyuU73I9za52QAyflsaGkbNk3A9JxXO8Da1W9SMF3E+eD
         3W3QJOqkv/hw5ZHCKAK8oTEgw4T9Pq+GyzIuJO4acUnmUO78+VluEquipEJUPo+3ToHX
         xP7w==
X-Gm-Message-State: AOAM530v8sJDQH1KfOW5W8KzdKcxOXSuucZDjJT87GhtmlITEm4GP1od
        2boXWsEzp0639bL2z8BTSQVodEv1i4Tn858cHqD7/Hgogt5Xdt5c60ZAVFe7rlMAM34VpnxQTiX
        EeyxzNSZZi2o6u+q5AECMcg==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr29341697ejb.5.1633976938257;
        Mon, 11 Oct 2021 11:28:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJs31ZBNnkMDy6Y3/bA4NkSUevwMmxI5GLaEsaPOhFcbZtCu9lTE6tYoeFaMp5H2duksbEGQ==
X-Received: by 2002:a17:906:64a:: with SMTP id t10mr29341674ejb.5.1633976938096;
        Mon, 11 Oct 2021 11:28:58 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id w11sm4722003edl.87.2021.10.11.11.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 11:28:57 -0700 (PDT)
Date:   Mon, 11 Oct 2021 14:28:51 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Kuppuswamy Sathyanarayanan 
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
        Paolo Bonzini <pbonzini@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Message-ID: <20211011142330-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 11, 2021 at 10:35:18AM -0700, Andi Kleen wrote:
> 
> > Presumably bios code is in arch/x86 and drivers/acpi, right?
> > Up to 200 calls the majority of which is likely private ...
> 
> Yes.
> 
> > I don't have better ideas but the current setup will just
> > result in people making their guests vulnerable whenever they
> > want to allow device pass-through.
> 
> 
> Yes that's true. For current TDX our target is virtual devices only. But if
> pass through usage will be really wide spread we may need to revisit.
> 
> 
> -Andi

I mean ... it's already wide spread. If we support it with TDX
it will be used with TDX. If we don't then I guess it won't,
exposing this kind of limitation in a userspace visible way isn't great
though. I guess it boils down to the fact that
ioremap_host_shared is just not a great interface, users simply
have no idea whether a given driver uses ioremap.

-- 
MST

