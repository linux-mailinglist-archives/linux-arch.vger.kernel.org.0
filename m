Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4BC43D13
	for <lists+linux-arch@lfdr.de>; Thu, 13 Jun 2019 17:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732052AbfFMPjY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Jun 2019 11:39:24 -0400
Received: from foss.arm.com ([217.140.110.172]:43218 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731932AbfFMPjX (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Jun 2019 11:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CBCF43EF;
        Thu, 13 Jun 2019 08:39:22 -0700 (PDT)
Received: from C02TF0J2HF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EDD3E3F718;
        Thu, 13 Jun 2019 08:39:16 -0700 (PDT)
Date:   Thu, 13 Jun 2019 16:39:07 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <Dave.Martin@arm.com>
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
Message-ID: <20190613153906.GV28951@C02TF0J2HF1T.local>
References: <cover.1560339705.git.andreyknvl@google.com>
 <20190612142111.28161-1-vincenzo.frascino@arm.com>
 <20190612142111.28161-2-vincenzo.frascino@arm.com>
 <20190612153538.GL28951@C02TF0J2HF1T.local>
 <141c740a-94c2-2243-b6d1-b44ffee43791@arm.com>
 <20190613113731.GY28398@e103592.cambridge.arm.com>
 <20190613122821.GS28951@C02TF0J2HF1T.local>
 <20190613132342.GZ28398@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190613132342.GZ28398@e103592.cambridge.arm.com>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 13, 2019 at 02:23:43PM +0100, Dave P Martin wrote:
> On Thu, Jun 13, 2019 at 01:28:21PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 13, 2019 at 12:37:32PM +0100, Dave P Martin wrote:
> > > On Thu, Jun 13, 2019 at 11:15:34AM +0100, Vincenzo Frascino wrote:
> > > > On 12/06/2019 16:35, Catalin Marinas wrote:
> > > > > On Wed, Jun 12, 2019 at 03:21:10PM +0100, Vincenzo Frascino wrote:
> > > > >> +  - PR_GET_TAGGED_ADDR_CTRL: can be used to check the status of the Tagged
> > > > >> +                             Address ABI.
> > [...]
> > > Is there a canonical way to detect whether this whole API/ABI is
> > > available?  (i.e., try to call this prctl / check for an HWCAP bit,
> > > etc.)
> > 
> > The canonical way is a prctl() call. HWCAP doesn't make sense since it's
> > not a hardware feature. If you really want a different way of detecting
> > this (which I don't think it's worth), we can reinstate the AT_FLAGS
> > bit.
> 
> Sure, I think this probably makes sense -- I'm still getting my around
> which parts of the design are directly related to MTE and which aren't.
> 
> I was a bit concerned about the interaction between
> PR_SET_TAGGED_ADDR_CTRL and the sysctl: the caller might conclude that
> this API is unavailable when actually tagged addresses are stuck on.
> 
> I'm not sure whether this matters, but it's a bit weird.
> 
> One option would be to change the semantics, so that the sysctl just
> forbids turning tagging from off to on.  Alternatively, we could return
> a different error code to distinguish this case.

This is the intention, just to forbid turning tagging on. We could
return -EPERM instead, though my original intent was to simply pretend
that the prctl does not exist like in an older kernel version.

-- 
Catalin
