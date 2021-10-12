Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA87D42AE63
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 23:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235135AbhJLVCH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 17:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56567 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234191AbhJLVCD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 17:02:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634072400;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Exp5E6dmY1PTSyKlOFa3gXPk4wQssFca5mHGxtbGag0=;
        b=igCTC4SM7jQR6qapOSFWL9jNvG9gX07POR3VmciQplPTVSGQ3ElgA0RNw0ZP49hiCd7Si5
        xebfs9UCwTBAZMyKD6gHkCBYQ8Pz435UgOqpimFhX5oM7cXE+yZI0ZdDIWJk0ZFPvgbk65
        FFKsvX22zCQrcTmUlfWAgPnpz1omz5Y=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-601-LBmDFK78NzC0qT5dFiNYrw-1; Tue, 12 Oct 2021 16:59:59 -0400
X-MC-Unique: LBmDFK78NzC0qT5dFiNYrw-1
Received: by mail-wr1-f69.google.com with SMTP id k2-20020adfc702000000b0016006b2da9bso327102wrg.1
        for <linux-arch@vger.kernel.org>; Tue, 12 Oct 2021 13:59:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Exp5E6dmY1PTSyKlOFa3gXPk4wQssFca5mHGxtbGag0=;
        b=P6NeuFJ8HC/WAOB8YFn7hCdyqNJSw8MoD38A/53vW1kdB7QtUN4Qh6+qdGiro0wMrc
         AnJrVjFnx2yNCmDiBl4Q87vfVWC0vaiiA4WhezeKl5l3wf0IhhuZydKFrHH93fvK0cGM
         ZjjMVBvzfJI+G7t3v8a1Yf9k3c/kOPbwcY40UJsLAgOVLOjPfttLWrxYWXNgfS7bOhR6
         WZzgiG8rGYp+tspjch8CwQ/k8J1wmbMtccmECAAgvM2mgeUhp7tYSNY6s/UBkqQulD5K
         hXqLkTHHOzlqiI3f15vUMVHH8lkvujHR7aAGY2EEMkt68s7bWxbodmrEPKQtmxasSXqz
         CrnQ==
X-Gm-Message-State: AOAM530JBIAsE24rDc07D3gdsTkqkMvzB38bIyBv9R1NVC43R0/w+lJa
        cefZ/0ElGXTe8IDjv46eyHzfUiP7TLP5i8XO3ETy592Pypc50s0JakaB18N91IqEkqf55S75R6O
        YWgFYNEq2RmzwpYGe3DWYlg==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr10798886wrx.192.1634072398167;
        Tue, 12 Oct 2021 13:59:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwBCYQfAelhSD7s+gLgNmxS7cksGV+rHTpSwlJhhXjwMp934f0UVw7OkfCfZxHBrxbJpbKA6g==
X-Received: by 2002:a05:6000:1289:: with SMTP id f9mr10798853wrx.192.1634072398013;
        Tue, 12 Oct 2021 13:59:58 -0700 (PDT)
Received: from redhat.com ([2.55.159.57])
        by smtp.gmail.com with ESMTPSA id 36sm11465676wrc.92.2021.10.12.13.59.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 13:59:57 -0700 (PDT)
Date:   Tue, 12 Oct 2021 16:59:51 -0400
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
Message-ID: <20211012165705-mutt-send-email-mst@kernel.org>
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
 <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 12, 2021 at 10:55:20AM -0700, Andi Kleen wrote:
> 
> > I mean ... it's already wide spread.
> 
> 
> I meant wide spread usage with confidential guests.
> 
> > If we support it with TDX
> > it will be used with TDX.
> 
> It has some security trade offs. The main reason to use TDX is security.
> Also when people take the VT-d tradeoffs they might be ok with the BIOS
> trade offs too.
> 
> -Andi

Interesting. VT-d tradeoffs ... what are they?
Allowing hypervisor to write into BIOS looks like it will
trivially lead to code execution, won't it?

-- 
MST

