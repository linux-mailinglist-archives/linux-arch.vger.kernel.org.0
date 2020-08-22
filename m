Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C741F24E6F9
	for <lists+linux-arch@lfdr.de>; Sat, 22 Aug 2020 12:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgHVK4O (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 22 Aug 2020 06:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35546 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgHVK4N (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 22 Aug 2020 06:56:13 -0400
Received: from gaia (unknown [95.146.230.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E0ED2067C;
        Sat, 22 Aug 2020 10:56:10 +0000 (UTC)
Date:   Sat, 22 Aug 2020 11:56:08 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: Re: [PATCH v7 22/29] arm64: mte: ptrace: Add
 PTRACE_{PEEK,POKE}MTETAGS support
Message-ID: <20200822105607.GA16635@gaia>
References: <20200715170844.30064-1-catalin.marinas@arm.com>
 <20200715170844.30064-23-catalin.marinas@arm.com>
 <95f0294b-93fb-bc5e-5ae5-fd3ada2dc7ce@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95f0294b-93fb-bc5e-5ae5-fd3ada2dc7ce@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Luis,

On Thu, Aug 13, 2020 at 11:01:06AM -0300, Luis Machado wrote:
> There has been changes to GDB's/LLDB's side to incorporate a tag type into
> the peek/poke requests. This is an attempt to anticipate required support
> for other tag types, like CHERI's tags. Those are somewhat different from
> MTE's tags.

Please note that Morello (the ARM's CHERI implementation) won't go into
mainline Linux for the time being. It's a development board to
experiment with CHERI and the architecture may eventually turn out
slightly different. Also note that the current Morello hardware doesn't
support MTE.

The tags are indeed different from the MTE ones, though both are just
additional metadata associated with a set of bytes in memory. It happens
that a tag in both cases corresponds to a 16-byte memory range.

> The core file design for storing tags, which is in progress and currently in
> my court, is also taking into account other types of tags.

It makes sense for the core file.

> Given the above, should we consider passing a type to the kernel ptrace
> requests as well?
> 
> Also, since the ptrace requests would have to handle different types of
> tags, should we rename PEEKMTETAGS/POKEMTETAGS to PEEKTAGS/POKETAGS instead
> and make those requests generic?

I'm not sure how we could pass a type since ptrace() only takes a single
argument for the request. We could use a different structure than iovec
and encode a type in a field in the new structure but I'd rather keep
the generic struct iovec. So basically the "MTE" part in PEEKMTETAGS is
the type.

Internally, the kernel implementation will probably translate the
request into a common function call with a tag type but for the
user-visible ptrace() interface, I don't see what benefits it would
bring. If you have a better suggestion on how to encode the type, I'm
open to discuss it.

-- 
Catalin
