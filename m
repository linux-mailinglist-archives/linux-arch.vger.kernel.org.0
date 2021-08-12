Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD2FB3EACF2
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238110AbhHLWMK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Aug 2021 18:12:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:12115 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230089AbhHLWMI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 12 Aug 2021 18:12:08 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10074"; a="215488885"
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="215488885"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:11:41 -0700
X-IronPort-AV: E=Sophos;i="5.84,317,1620716400"; 
   d="scan'208";a="517637294"
Received: from akleen-mobl1.amr.corp.intel.com (HELO [10.255.231.194]) ([10.255.231.194])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 15:11:40 -0700
Subject: Re: [PATCH v4 09/15] pci: Consolidate pci_iomap* and pci_iomap*wc
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Richard Henderson <rth@twiddle.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        James E J Bottomley <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        "David S . Miller" <davem@davemloft.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Jonathan Corbet <corbet@lwn.net>,
        "Michael S . Tsirkin" <mst@redhat.com>,
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
References: <20210812194330.GA2500473@bjorn-Precision-5520>
From:   Andi Kleen <ak@linux.intel.com>
Message-ID: <bc5d4268-2304-5c1d-8311-24d141cb5ced@linux.intel.com>
Date:   Thu, 12 Aug 2021 15:11:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812194330.GA2500473@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


> Why is it safe to make pci_iomap_wc_range() support IO ports when it
> didn't before?  That might be desirable, but I think it *is* a
> functional change here.

None of the callers use it to map IO ports, so it will be a no-op for 
them. But you're right, it's a (minor) functional change.

-Andi




