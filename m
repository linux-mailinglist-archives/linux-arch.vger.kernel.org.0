Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F29F11172ED
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 18:38:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726265AbfLIRiM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 12:38:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726230AbfLIRiM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 12:38:12 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C097D2077B;
        Mon,  9 Dec 2019 17:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575913090;
        bh=DNOt7YwfijzafvFTDJTNGfZwwC8DEvzIY///7gEWRzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kxJjnrwcNDybdXxgvdWPzL0DUNMjXPbzxO4kT38PmL/Q4M42VSaeqvK7nh2ZEmiQw
         4VN/tHoAFQ3rQlEqIFFLOTWabOGmqsdqbHlBtThVfh8ij4STFaIAuyuHSNNMT6WCj4
         /8HFlnX27hhdPrwbaQRWU/d88y14Tdt1g7BxA1YQ=
Date:   Mon, 9 Dec 2019 17:38:05 +0000
From:   Will Deacon <will@kernel.org>
To:     Thomas Renninger <trenn@suse.de>
Cc:     Felix Schnizlein <fschnizlein@suse.com>,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Message-ID: <20191209173804.GD7489@willie-the-truck>
References: <20191206162421.15050-1-trenn@suse.de>
 <20191206162421.15050-4-trenn@suse.de>
 <20191209103110.GB3306@willie-the-truck>
 <25032400.G9DUGnJgnc@skinner.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25032400.G9DUGnJgnc@skinner.arch.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Dec 09, 2019 at 12:28:44PM +0100, Thomas Renninger wrote:
> On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> > On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > > From: Felix Schnizlein <fschnizlein@suse.de>
> > > 
> > > Export all information from /proc/cpuinfo to sysfs:
> > > implementer, architecture, variant, part, revision,
> > > bogomips and flags are exported.
> > > 
> > > Example:
> > > /sys/devices/system/cpu/cpu1/info/:[0]# head *
> 
> ...
> 
> > > ==> flags <==
> > > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
>  
> ...
> 
> > I don't understand why we need this on arm64
> 
> The first intention of these patches is to port x86 /proc/cpuinfo.

That doesn't answer my question. Why do we want a port of x86 /proc/cpuinfo
on arm64? Or do you mean something else?

> Because of the divergence of /proc/cpuinfo and the totally different
> info exported there across architectures,
> therefore it is also tried to get a unified interface across architectures 
> where possible.

But as you say, the information is totally different, so I think the scope
for a unified interface is somewhat questionable. Can you give some examples
of when a piece of architecture-agnostic software can sensibly benefit from
this interface in a way that couldn't be achieved already using a userspace
library, please?

> So for flags and bugs this may work out, right?

We don't have a 'bugs' entry on arm64, so I don't understand why you're
mentioning that as an example of something that works well here. The flags
thing is a set of architecture-specific strings, so why is having a common
interface at all useful there? Even if we exposed them via sysfs, existing
software will continue to grep them out of /proc/cpuinfo because it's more
reliable and new software would still be encouraged to use either the HWCAPs
directly or, even better, our CPUID (MRS) emulation.

> For the rest, it looks like people again only had their CPU in mind and
> exported to userspace what currently was needed...

Cool story: we tried to tidy up our /proc/cpuinfo format for arm64 because
we were aware that it was an ABI nightmare that wasn't fully understood, so
we played it very cautiously. Unfortunately, it turned out that real
applications got in the way and we basically had to follow an arm32-like
format to avoid breaking userspace. But it is what it is and I don't really
fancy exposing more stuff without decent rationale...

> > and why it's an improvement
> > over all the other schemes we already support for identifying CPU features.
> 
> Sigh...

... which this isn't. :/

> > Given the pain we've endured over the years exposing this sort of stuff to
> > userspace, I'm relucant to add more just for the fun of it.
> 
> If there should ever be something like a string describing the CPU...
> In x86 it comes from the CPU itself.
> Maybe we get a model description at some point as well...
> 
> Or any other entity which may also get exported on other archs..

Not sure who this is aimed at tbh.

> Please remember this interface and watch out whether you could export
> things under the same name as done on other architectures.
> 
> I'll revert everything but flags for ARM now.

Please revert the whole lot for arm64, I don't even want to see the iCPU
feature flags exposed like this without a good justification.

> But this is the best example for the need of a generic interface:
> 
> x86 -   /proc/cpuinfo:
> flags           : ...
> arm64 - /proc/cpuinfo:
> Features        : ...
> 
> even it is exactly the same kernel interface, even x86 flags are used 
> according to arch/arm64/include/asm/cpufeature.h:
> 
>   * We use arm64_cpu_capabilities to represent system features, errata work
> 
> But it is named differently in /proc/cpuinfo.

As I said earlier, that's the least of your worries. The *contents of the
string* is entirely different based on the architecture. Here's a quiz
for you:

	arm32 Feature    arm64 Feature    x86 flag    Same thing?
	"vfp"            "fp"		  "fpu"
	"idivt"          "cpuid"          "cpuid"
	"edsp"           "sve2"           "sse2"
        "aes"            "ssbs"           "ssbd"
        "swp"            "sb"             "ss"

So it's all well and good having everybody call these either "Features"
or "flags", but I think you're missing the real issue which is that the
values themselves are meaningless without architecture-specific knowledge,
at which point you can parse /proc/cpuinfo accordingly.

Unless I missed it, you also don't seem to handle compat tasks at all in
your patch.

> This should not happen again in /sys/...

I wish I could believe you.

Will
