Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D30B1D9C19
	for <lists+linux-arch@lfdr.de>; Tue, 19 May 2020 18:11:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbgESQLD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 19 May 2020 12:11:03 -0400
Received: from foss.arm.com ([217.140.110.172]:35664 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728953AbgESQLD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 19 May 2020 12:11:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6BCB830E;
        Tue, 19 May 2020 09:11:02 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60C603F305;
        Tue, 19 May 2020 09:11:00 -0700 (PDT)
Date:   Tue, 19 May 2020 17:10:58 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     Dave Martin <Dave.Martin@arm.com>, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Will Deacon <will@kernel.org>,
        Omair Javaid <omair.javaid@linaro.org>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>, linux-mm@kvack.org,
        Andrey Konovalov <andreyknvl@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Alan Hayward <Alan.Hayward@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Message-ID: <20200519161057.GE20313@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
 <20200513104849.GC2719@gaia>
 <3d2621ac-9d08-53ea-6c22-c62532911377@linaro.org>
 <20200513141147.GD2719@gaia>
 <eec9ddae-8aa0-6cd1-9a23-16b06bb457c5@linaro.org>
 <e7f995d6-d48b-1ea2-c9e6-d2533e8eadd5@linaro.org>
 <20200518164723.GA5031@arm.com>
 <55fe4d37-23ae-a6b7-8db1-884aaf4a9b9c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55fe4d37-23ae-a6b7-8db1-884aaf4a9b9c@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, May 18, 2020 at 02:12:24PM -0300, Luis Machado wrote:
> On 5/18/20 1:47 PM, Dave Martin wrote:
> > Wrinkle: just because MTE is "off", pages might still be mapped with
> > PROT_MTE and have arbitrary tags set on them, and the debugger perhaps
> > needs a way to know that.  Currently grubbing around in /proc is the
> > only way to discover that.  Dunno whether it matters.
> 
> That is the sort of thing that may confused the debugger.
> 
> If MTE is "off" (and thus the debugger doesn't need to validate tags), then
> the pages mapped with PROT_MTE that show up in /proc/<pid>/smaps should be
> ignored?

There is no such thing as global MTE "off". If the HWCAP is present, a
user program can map an address with PROT_MTE and access tags. Maybe it
uses it for extra storage, you never know, doesn't have to be heap
allocation related.

> I'm looking for a precise way to tell if MTE is being used or not for a
> particular process/thread. This, in turn, will tell debuggers when to look
> for PROT_MTE mappings in /proc/<pid>/smaps and when to validate tagged
> addresses.
> 
> So far my assumption was that MTE will always be "on" when HWCAP2_MTE is
> present. So having HWCAP2_MTE means we have the NT_ARM_MTE regset and that
> PROT_MTE pages have to be checked.

Yes. I haven't figured out what to put in the regset yet, most likely
the prctl value as it has other software-only controls like the tagged
address ABI.

-- 
Catalin
