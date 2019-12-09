Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D109C116C47
	for <lists+linux-arch@lfdr.de>; Mon,  9 Dec 2019 12:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfLIL2r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 9 Dec 2019 06:28:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:60682 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726377AbfLIL2q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 9 Dec 2019 06:28:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E51C6B1A7;
        Mon,  9 Dec 2019 11:28:44 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     Will Deacon <will@kernel.org>,
        Felix Schnizlein <fschnizlein@suse.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org
Subject: Re: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Date:   Mon, 09 Dec 2019 12:28:44 +0100
Message-ID: <25032400.G9DUGnJgnc@skinner.arch.suse.de>
In-Reply-To: <20191209103110.GB3306@willie-the-truck>
References: <20191206162421.15050-1-trenn@suse.de> <20191206162421.15050-4-trenn@suse.de> <20191209103110.GB3306@willie-the-truck>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Monday, December 9, 2019 11:31:11 AM CET Will Deacon wrote:
> On Fri, Dec 06, 2019 at 05:24:21PM +0100, Thomas Renninger wrote:
> > From: Felix Schnizlein <fschnizlein@suse.de>
> > 
> > Export all information from /proc/cpuinfo to sysfs:
> > implementer, architecture, variant, part, revision,
> > bogomips and flags are exported.
> > 
> > Example:
> > /sys/devices/system/cpu/cpu1/info/:[0]# head *

...

> > ==> flags <==
> > fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm
 
...

> I don't understand why we need this on arm64

The first intention of these patches is to port x86 /proc/cpuinfo.

Because of the divergence of /proc/cpuinfo and the totally different
info exported there across architectures,
therefore it is also tried to get a unified interface across architectures 
where possible.

So for flags and bugs this may work out, right?

For the rest, it looks like people again only had their CPU in mind and
exported to userspace what currently was needed...

> and why it's an improvement
> over all the other schemes we already support for identifying CPU features.

Sigh...

> Given the pain we've endured over the years exposing this sort of stuff to
> userspace, I'm relucant to add more just for the fun of it.

If there should ever be something like a string describing the CPU...
In x86 it comes from the CPU itself.
Maybe we get a model description at some point as well...

Or any other entity which may also get exported on other archs..

Please remember this interface and watch out whether you could export
things under the same name as done on other architectures.

I'll revert everything but flags for ARM now.
But this is the best example for the need of a generic interface:

x86 -   /proc/cpuinfo:
flags           : ...
arm64 - /proc/cpuinfo:
Features        : ...

even it is exactly the same kernel interface, even x86 flags are used 
according to arch/arm64/include/asm/cpufeature.h:

  * We use arm64_cpu_capabilities to represent system features, errata work

But it is named differently in /proc/cpuinfo.
This should not happen again in /sys/...

    Thomas


