Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF9F0439CE
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387680AbfFMPQ3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:16:29 -0400
Received: from foss.arm.com ([217.140.110.172]:39810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbfFMNXs (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 09:23:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3E6A63EF;
        Thu, 13 Jun 2019 06:23:47 -0700 (PDT)
Received: from e103592.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51833F73C;
        Thu, 13 Jun 2019 06:23:45 -0700 (PDT)
Date:   Thu, 13 Jun 2019 14:23:43 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-kselftest@vger.kernel.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 1/2] arm64: Define
 Documentation/arm64/tagged-address-abi.txt
Message-ID: <20190613132342.GZ28398@e103592.cambridge.arm.com>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <20190612153538.GL28951@C02TF0J2HF1T.local>
 <141c740a-94c2-2243-b6d1-b44ffee43791@arm.com>
 <20190613113731.GY28398@e103592.cambridge.arm.com>
 <20190613122821.GS28951@C02TF0J2HF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613122821.GS28951@C02TF0J2HF1T.local>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 13, 2019 at 01:28:21PM +0100, Catalin Marinas wrote:
> On Thu, Jun 13, 2019 at 12:37:32PM +0100, Dave P Martin wrote:
> > On Thu, Jun 13, 2019 at 11:15:34AM +0100, Vincenzo Frascino wrote:
> > > On 12/06/2019 16:35, Catalin Marinas wrote:
> > > > On Wed, Jun 12, 2019 at 03:21:10PM +0100, Vincenzo Frascino wrote:
> > > >> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
> > > >> +                             Address ABI.
> [...]
> > Is there a canonical way to detect whether this whole API/ABI is
> > available?  (i.e., try to call this prctl / check for an HWCAP bit,
> > etc.)
> 
> The canonical way is a prctl() call. HWCAP doesn't make sense since it's
> not a hardware feature. If you really want a different way of detecting
> this (which I don't think it's worth), we can reinstate the AT_FLAGS
> bit.

Sure, I think this probably makes sense -- I'm still getting my around
which parts of the design are directly related to MTE and which aren't.

I was a bit concerned about the interaction between
PR_SET_TAGGED_ADDR_CTRL and the sysctl: the caller might conclude that
this API is unavailable when actually tagged addresses are stuck on.

I'm not sure whether this matters, but it's a bit weird.

One option would be to change the semantics, so that the sysctl just
forbids turning tagging from off to on.  Alternatively, we could return
a different error code to distinguish this case.

Or we just leave it as proposed.

Cheers
---Dave
