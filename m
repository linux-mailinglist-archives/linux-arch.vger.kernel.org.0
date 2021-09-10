Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03ED4406FB8
	for <lists+linux-arch@lfdr.de>; Fri, 10 Sep 2021 18:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229466AbhIJQf7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Sep 2021 12:35:59 -0400
Received: from mga18.intel.com ([134.134.136.126]:41169 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhIJQf7 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 10 Sep 2021 12:35:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10103"; a="208226577"
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="208226577"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 09:34:47 -0700
X-IronPort-AV: E=Sophos;i="5.85,283,1624345200"; 
   d="scan'208";a="581420171"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.212.255.212]) ([10.212.255.212])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2021 09:34:46 -0700
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
References: <CAPcyv4iJVQKJ3bVwZhD08c8GNEP0jW2gx=H504NXcYK5o2t01A@mail.gmail.com>
 <d992b5af-8d57-6aa6-bd49-8e2b8d832b19@linux.intel.com>
 <20210824053830-mutt-send-email-mst@kernel.org>
 <d21a2a2d-4670-ba85-ce9a-fc8ea80ef1be@linux.intel.com>
 <20210829112105-mutt-send-email-mst@kernel.org>
 <09b340dd-c8a8-689c-4dad-4fe0e36d39ae@linux.intel.com>
 <20210829181635-mutt-send-email-mst@kernel.org>
 <3a88a255-a528-b00a-912b-e71198d5f58f@linux.intel.com>
 <20210830163723-mutt-send-email-mst@kernel.org>
 <69fc30f4-e3e2-add7-ec13-4db3b9cc0cbd@linux.intel.com>
 <20210910054044-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <f672dc1c-5280-7bbc-7a56-7c7aab31725c@linux.intel.com>
Date:   Fri, 10 Sep 2021 09:34:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210910054044-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


>>>> And we've been avoiding that drivers can self declare auditing, we've been
>>>> trying to have a separate centralized list so that it's easier to enforce
>>>> and avoids any cut'n'paste mistakes.
>>>>
>>>> -Andi
>>> Now I'm confused. What is proposed here seems to be basically that,
>>> drivers need to declare auditing by replacing ioremap with
>>> ioremap_shared.
>> Auditing is declared on the device model level using a central allow list.
> Can we not have an init call allow list instead of, or in addition to, a
> device allow list?


That would be quite complicated and intrusive. In fact I'm not even sure 
how to do maintain something like this. There are a lot of needed 
initcalls, they would all need to be marked. How can we distinguish 
them? It would be a giant auditing project. And of course how would you 
prevent it from bitrotting?


Basically it would be hundreds of changes all over the tree, just to 
avoid two changes in virtio and MSI. Approach of just stopping the 
initcalls from doing bad things is much less intrusive.

>
>> But this cannot do anything to initcalls that run before probe,
> Can't we extend module_init so init calls are validated against the
> allow list?

See above.


Also the problem isn't really with modules (we rely on udev not loading 
them), but with builtin initcalls


>
>> that's why
>> an extra level of defense of ioremap opt-in is useful.
> OK even assuming this, why is pci_iomap opt-in useful?
> That never happens before probe - there's simply no pci_device then.


Hmm, yes that's true. I guess we can make it default to opt-in for 
pci_iomap.

It only really matters for device less ioremaps.

>
> It looks suspiciously like drivers self-declaring auditing to me which
> we both seem to agree is undesirable. What exactly is the difference?


Just allow listing the ioremaps is not self declaration because the 
device will still not initialize due to the central device filter. If 
you want to use it that has to be changed.

It's just an additional safety net to contain code running before probe.


>
> Or are you just trying to disable anything that runs before probe?


Well anything that could do dangerous host interactions (like processing 
ioremap data) A lot of things are harmless and can be allowed, or 
already blocked elsewhere (e.g. we have a IO port filter). This just 
handles the ioremap/MMIO case.

> In that case I don't see a reason to touch pci drivers though.
> These should be fine with just the device model list.


That won't stop initcalls.


-Andi


>
