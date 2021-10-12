Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA05B42AB49
	for <lists+linux-arch@lfdr.de>; Tue, 12 Oct 2021 19:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbhJLR51 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Oct 2021 13:57:27 -0400
Received: from mga07.intel.com ([134.134.136.100]:64303 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229554AbhJLR50 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 12 Oct 2021 13:57:26 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10135"; a="290720335"
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="290720335"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:55:23 -0700
X-IronPort-AV: E=Sophos;i="5.85,368,1624345200"; 
   d="scan'208";a="562768804"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.209.115.208]) ([10.209.115.208])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2021 10:55:21 -0700
Message-ID: <4fe8d60a-2522-f111-995c-dcbefd0d5e31@linux.intel.com>
Date:   Tue, 12 Oct 2021 10:55:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v5 16/16] x86/tdx: Add cmdline option to force use of
 ioremap_host_shared
Content-Language: en-US
To:     "Michael S. Tsirkin" <mst@redhat.com>
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
References: <20211009003711.1390019-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009003711.1390019-17-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20211009070132-mutt-send-email-mst@kernel.org>
 <8c906de6-5efa-b87a-c800-6f07b98339d0@linux.intel.com>
 <20211011075945-mutt-send-email-mst@kernel.org>
 <9d0ac556-6a06-0f2e-c4ff-0c3ce742a382@linux.intel.com>
 <20211011142330-mutt-send-email-mst@kernel.org>
From:   Andi Kleen <ak@linux.intel.com>
In-Reply-To: <20211011142330-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> I mean ... it's already wide spread.


I meant wide spread usage with confidential guests.

> If we support it with TDX
> it will be used with TDX.

It has some security trade offs. The main reason to use TDX is security. 
Also when people take the VT-d tradeoffs they might be ok with the BIOS 
trade offs too.

-Andi

