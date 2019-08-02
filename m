Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 150047F4BB
	for <lists+linux-arch@lfdr.de>; Fri,  2 Aug 2019 12:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389789AbfHBKIk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 2 Aug 2019 06:08:40 -0400
Received: from foss.arm.com ([217.140.110.172]:48772 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728855AbfHBKIj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 2 Aug 2019 06:08:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2C9EB344;
        Fri,  2 Aug 2019 03:08:39 -0700 (PDT)
Received: from arrakis.emea.arm.com (arrakis.cambridge.arm.com [10.1.196.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B1D323F71F;
        Fri,  2 Aug 2019 03:08:37 -0700 (PDT)
Date:   Fri, 2 Aug 2019 11:08:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>
Subject: Re: [PATCH v6 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.rst
Message-ID: <20190802100835.GA4175@arrakis.emea.arm.com>
References: <cover.1563904656.git.andreyknvl@google.com>
 <20190725135044.24381-1-vincenzo.frascino@arm.com>
 <20190725135044.24381-2-vincenzo.frascino@arm.com>
 <b74e7ce7-d58a-68a0-2f28-6648ec6302c0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b74e7ce7-d58a-68a0-2f28-6648ec6302c0@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Dave,

On Wed, Jul 31, 2019 at 09:43:46AM -0700, Dave Hansen wrote:
> On 7/25/19 6:50 AM, Vincenzo Frascino wrote:
> > With the relaxed ABI proposed through this document, it is now possible
> > to pass tagged pointers to the syscalls, when these pointers are in
> > memory ranges obtained by an anonymous (MAP_ANONYMOUS) mmap().
> 
> I don't see a lot of description of why this restriction is necessary.
> What's the problem with supporting MAP_SHARED?

We could support MAP_SHARED | MAP_ANONYMOUS (and based on some internal
discussions, this would be fine with the hardware memory tagging as
well). What we don't want in the ABI is to support file mmap() for
top-byte-ignore (or MTE). If you see a use-case, please let us know.

-- 
Catalin
