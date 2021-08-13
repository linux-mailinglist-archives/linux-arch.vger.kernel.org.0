Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3C13EB227
	for <lists+linux-arch@lfdr.de>; Fri, 13 Aug 2021 10:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239581AbhHMID0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Aug 2021 04:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239523AbhHMICk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 13 Aug 2021 04:02:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836E9C061756;
        Fri, 13 Aug 2021 01:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Si6+tA9D1y9EtzA7fh9EgJw213gBjxE8cIu39WNfpqM=; b=kKNETURQC2XIzBmc596h1eynqR
        cW9A2OBkLxe74dTeo8jpFByDwxQbOUshieUvzgWw/Zq+/gXYymQPfDZNItNGMCeGi+iS0mKUjlbEs
        18zhFj/1KoA0wT3RpKNHgNt/Zt/ooGDTQhqfQZMGVXaNP6a+pNLtY0xH72epEAWg+ZOMt3DbnmByN
        K1GvMeWF45WoTFmJ/QeavyyPhoGVojFuy3i+eQeyIXACx25wLMUoNE/Rigi79v3HBq8N30EgckY13
        FhI5tMlDrK/gsN9o1qI0HlZ9KKwJvKqgeGGKJiJnjc/OQXXiLTltL2hV8EMgIQ8j4YERJnv01ExH2
        36X0GZzg==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mES4r-00FT89-TJ; Fri, 13 Aug 2021 07:58:17 +0000
Date:   Fri, 13 Aug 2021 08:58:05 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
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
        "Michael S . Tsirkin" <mst@redhat.com>,
        Peter H Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kirill Shutemov <kirill.shutemov@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Kuppuswamy Sathyanarayanan <knsathya@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 10/15] asm/io.h: Add ioremap_shared fallback
Message-ID: <YRYmDcPNT6iYxTJc@infradead.org>
References: <20210805005218.2912076-1-sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210805005218.2912076-11-sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210805005218.2912076-11-sathyanarayanan.kuppuswamy@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

_shared is just a horrible name for these.  Please find a more specific
name, and document them instead of just adding to the macro forrest.
