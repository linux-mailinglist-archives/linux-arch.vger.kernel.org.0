Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904A93FAD12
	for <lists+linux-arch@lfdr.de>; Sun, 29 Aug 2021 18:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbhH2QSu (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 29 Aug 2021 12:18:50 -0400
Received: from mga18.intel.com ([134.134.136.126]:11013 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235624AbhH2QSt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 29 Aug 2021 12:18:49 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10091"; a="205298898"
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="205298898"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 09:17:55 -0700
X-IronPort-AV: E=Sophos;i="5.84,361,1620716400"; 
   d="scan'208";a="509319308"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.238.58]) ([10.212.238.58])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2021 09:17:54 -0700
Subject: Re: [PATCH v4 11/15] pci: Add pci_iomap_shared{,_range}
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-12-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210823195409-mutt-send-email-mst@kernel.org>
 <26a3cce5-ddf7-cbe6-a41e-58a2aea48f78@linux.intel.com>
 <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
Date:   Sun, 29 Aug 2021 09:17:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210829112105-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Let's be frank, even without encryption disabling most drivers -
> especially weird ones that poke at hardware before probe -
> is far safer than keeping them, but one loses a bunch of features.

Usually we don't lose features at all. None of the legacy drivers are 
needed on a guest (or even a modern native system). It's all just all 
for old hardware. Maybe in 20+ years it can be all removed, but we can't 
wait that long.

> IOW all this hardening is nice but which security/feature tradeoff
> to take it a policy decision, not something kernel should do
> imho.

There's no mechanism to push this kind of policy to user space. Users 
don't have control what initcalls run. At the time they execute there 
isn't even any user space yet.

Even if they could somehow control them it's very unlikely they would 
understand them and make an informed decision.

Doing it at build time is not feasible either since we want to run on 
standard distribution kernels.

For modules we have a policy mechanism (prevent udev probing by 
preventing enumeration), and that is implemented, but only handling 
modules is not enough. The compiled in drivers have to be handled too, 
otherwise you have gaping holes in the protection. We don't prevent 
users manually loading modules that might probe, but that is a policy 
decision that users actually sensibly make in user space.

Also I changing this single call really that bad? It's not that we 
changing anything drastic here, just give the low level subsystem a 
better hint about the intention. If you don't like the function name, 
could make it an argument instead?

-Andi



>
