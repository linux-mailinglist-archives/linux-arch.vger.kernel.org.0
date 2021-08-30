Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6BD13FBDC8
	for <lists+linux-arch@lfdr.de>; Mon, 30 Aug 2021 23:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhH3VA5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Aug 2021 17:00:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32938 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236258AbhH3VAy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Mon, 30 Aug 2021 17:00:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630357199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZDgZoaGxuF8+VxsBt8mWUj6L6RMapnQD42kDmE3TNZQ=;
        b=GH03Om/445Kfh0spCpfgBXGkgopeKaJKIqsbbIqGNoDmAlnZTvAthA2tI2dz9Aq5cuTnHb
        S/4bNzDF2aRH+g5BXDAau4HDRE6CwBE5H4ZiUVX0kxknRtFixsmYk2gTkESXfR+1kQusEc
        NugrIp20O33foRVdV+QJ3G9RR3jW/9o=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-3v-Iv5BJPXSC-q_1mKYGXw-1; Mon, 30 Aug 2021 16:59:57 -0400
X-MC-Unique: 3v-Iv5BJPXSC-q_1mKYGXw-1
Received: by mail-wm1-f71.google.com with SMTP id v2-20020a7bcb420000b02902e6b108fcf1so231576wmj.8
        for <linux-arch@vger.kernel.org>; Mon, 30 Aug 2021 13:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ZDgZoaGxuF8+VxsBt8mWUj6L6RMapnQD42kDmE3TNZQ=;
        b=D9PRnfJAVeosgPNseDBHntqrQ8BRxpeGvJMNBdl5QFVJg7lR7w+4YTncgQ08UfupjO
         rIxqmgCUB69kMTWCxR1YbyL6k9BgBP4gDlsU2+GpPRhnlXdQ0BO86HFmGV256Zm4pcPo
         f+WAAfGE928d/EAD1gFG4CAOoZfgiTL7nPmwQhxKDGGhgfGwpdg0G7Ng8D8GExRZn0MN
         N5h6mQg+9AepUkK/g+da9Xz1YiyPqPmpQmlQ4bvziX5Gi7mmQQD00tyjISpRkNG6+9kA
         Cpi9yK6qErWibhxQ5jYto70Ry59g3oL0lDG2bACkf9A1kAX8A1NPTDkKaNqdadBpXrlm
         edjA==
X-Gm-Message-State: AOAM532/DTbmWKutfpItO7Qb2OrISVYccVhrBe2M2WyfandS1Jaql3xc
        vOAK0YRu29WbunEnWi7+NTbSzHhRsswvO3kNnVUgA776Q/CJix+CWzvYxpeeN5O/CuJsvV0AabL
        Xl8LgWAjvQ7d78PJv9SqYFw==
X-Received: by 2002:a1c:7f48:: with SMTP id a69mr887138wmd.166.1630357196541;
        Mon, 30 Aug 2021 13:59:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjS6eag15Cf7xmVDHk/qvmWoQLzIdnk7dLXkY7XjvOHcTw6SiXs3ksmYcUzh73pyrAtLIGDA==
X-Received: by 2002:a1c:7f48:: with SMTP id a69mr887093wmd.166.1630357196296;
        Mon, 30 Aug 2021 13:59:56 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
        by smtp.gmail.com with ESMTPSA id z9sm12277068wre.11.2021.08.30.13.59.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 13:59:55 -0700 (PDT)
Date:   Mon, 30 Aug 2021 16:59:50 -0400
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
Message-ID: <20210830163723-mutt-send-email-mst@kernel.org>
References: <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 29, 2021 at 10:11:46PM -0700, Andi Kleen wrote:
> 
> On 8/29/2021 3:26 PM, Michael S. Tsirkin wrote:
> > On Sun, Aug 29, 2021 at 09:17:53AM -0700, Andi Kleen wrote:
> > > Also I changing this single call really that bad? It's not that we changing
> > > anything drastic here, just give the low level subsystem a better hint about
> > > the intention. If you don't like the function name, could make it an
> > > argument instead?
> > My point however is that the API should say that the
> > driver has been audited,
> 
> We have that status in the struct device. If you want to tie the ioremap to
> that we could define a ioremap_device() with a device argument and decide
> based on that.

But it's not the device that is audited. And it's not the device
that might be secure or insecure. It's the driver.

> Or we can add _audited to the name. ioremap_shared_audited?

But it's not the mapping that has to be done in handled special way.
It's any data we get from device, not all of it coming from IO, e.g.
there's DMA and interrupts that all have to be validated.
Wouldn't you say that what is really wanted is just not running
unaudited drivers in the first place?

> 
> > not that the mapping has been
> > done in some special way. For example the mapping can be
> > in some kind of wrapper, not directly in the driver.
> > However you want the driver validated, not the wrapper.
> > 
> > Here's an idea:
> 
> 
> I don't think magic differences of API behavior based on some define are a
> good idea.  That's easy to miss.

Well ... my point is that actually there is no difference in API
behaviour. the map is the same map, exactly same data goes to device. If
anything any non-shared map is special in that encrypted data goes to
device.

> 
> That's a "COME FROM" in API design.
> 
> Also it wouldn't handle the case that a driver has both private and shared
> ioremaps, e.g. for BIOS structures.

Hmm. Interesting.  It's bios maps that are unusual and need to be private though ...

> And we've been avoiding that drivers can self declare auditing, we've been
> trying to have a separate centralized list so that it's easier to enforce
> and avoids any cut'n'paste mistakes.
> 
> -Andi

Now I'm confused. What is proposed here seems to be basically that,
drivers need to declare auditing by replacing ioremap with
ioremap_shared.

-- 
MST

