Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D281D1BF7
	for <lists+linux-arch@lfdr.de>; Wed, 13 May 2020 19:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbgEMRLk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 May 2020 13:11:40 -0400
Received: from foss.arm.com ([217.140.110.172]:50822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727120AbgEMRLj (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 May 2020 13:11:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4431730E;
        Wed, 13 May 2020 10:11:39 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6BF743F305;
        Wed, 13 May 2020 10:11:37 -0700 (PDT)
Date:   Wed, 13 May 2020 18:11:35 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Luis Machado <luis.machado@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Alan Hayward <Alan.Hayward@arm.com>,
        Omair Javaid <omair.javaid@linaro.org>
Subject: Re: [PATCH v3 19/23] arm64: mte: Add PTRACE_{PEEK,POKE}MTETAGS
 support
Message-ID: <20200513171134.GE2719@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-20-catalin.marinas@arm.com>
 <a7569985-eb85-497b-e3b2-5dce0acb1332@linaro.org>
 <20200513104849.GC2719@gaia>
 <3d2621ac-9d08-53ea-6c22-c62532911377@linaro.org>
 <20200513141147.GD2719@gaia>
 <eec9ddae-8aa0-6cd1-9a23-16b06bb457c5@linaro.org>
 <e7f995d6-d48b-1ea2-c9e6-d2533e8eadd5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7f995d6-d48b-1ea2-c9e6-d2533e8eadd5@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 01:45:27PM -0300, Luis Machado wrote:
> On 5/13/20 12:09 PM, Luis Machado wrote:
> > Let me think about this for a bit. I'm trying to factor in the
> > /proc/<pid>/maps contents. If debuggers know which pages have PROT_MTE
> > set, then we can teach the tools not to PEEK/POKE tags from/to those
> > memory ranges, which simplifies the error handling a bit.
> 
> I was checking the output of /proc/<pid>/maps and it doesn't seem to contain
> flags against which i can match PROT_MTE. It seems /proc/<pid>/smaps is the
> one that contains the flags (mt) for MTE. Am i missing something?

You are right, the smaps is the one with the MTE information.

> Is this the only place debuggers can check for PROT_MTE? If so, that's
> unfortunate. /proc/<pid>/smaps doesn't seem to be convenient for parsing.

We can't change 'maps' as it's a pretty standard format with rwxp
properties only.

If you don't want to check any /proc file, just attempt to read the tags
and check the ptrace return code. The downside is that you can't easily
probe if a process is using MTE or not. But is this piece of information
relevant? The gdb user should know what to look for (well, it's been a
while since I used a debugger ;)).

-- 
Catalin
