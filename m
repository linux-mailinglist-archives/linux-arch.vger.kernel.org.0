Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A08C1BC093
	for <lists+linux-arch@lfdr.de>; Tue, 28 Apr 2020 16:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727985AbgD1OGc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Apr 2020 10:06:32 -0400
Received: from foss.arm.com ([217.140.110.172]:52454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726942AbgD1OGb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 28 Apr 2020 10:06:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D9E2731B;
        Tue, 28 Apr 2020 07:06:30 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 30FA73F68F;
        Tue, 28 Apr 2020 07:06:29 -0700 (PDT)
Date:   Tue, 28 Apr 2020 15:06:27 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Martin <dave.martin@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
        Richard Earnshaw <Richard.Earnshaw@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 20/23] fs: Allow copy_mount_options() to access
 user-space in a single pass
Message-ID: <20200428140626.GJ3868@gaia>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
 <20200427165641.GC15808@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427165641.GC15808@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Apr 27, 2020 at 05:56:42PM +0100, Dave P Martin wrote:
> On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> > The copy_mount_options() function takes a user pointer argument but not
> > a size. It tries to read up to a PAGE_SIZE. However, copy_from_user() is
> > not guaranteed to return all the accessible bytes if, for example, the
> > access crosses a page boundary and gets a fault on the second page. To
> > work around this, the current copy_mount_options() implementations
> > performs to copy_from_user() passes, first to the end of the current
> > page and the second to what's left in the subsequent page.
> > 
> > Some architectures like arm64 can guarantee an exact copy_from_user()
> > depending on the size (since the arch function performs some alignment
> > on the source register). Introduce an arch_has_exact_copy_from_user()
> > function and allow copy_mount_options() to perform the user access in a
> > single pass.
> > 
> > While this function is not on a critical path, the single-pass behaviour
> > is required for arm64 MTE (memory tagging) support where a uaccess can
> > trigger intra-page faults (tag not matching). With the current
> > implementation, if this happens during the first page, the function will
> > return -EFAULT.
> 
> Do you know how much extra overhead we'd incur if we read at must one
> tag granule at a time, instead of PAGE_SIZE?

Our copy routines already read 16 bytes at a time, so that's the tag
granule. With current copy_mount_options() we have the issue that it
assumes a fault in the first page is fatal.

Even if we change it to a loop of smaller uaccess, we still have the
issue of unaligned accesses which can fail without reading all that's
possible (i.e. the access goes across a tag granule boundary).

The previous copy_mount_options() implementation (from couple of months
ago I think) had a fallback to byte-by-byte, didn't have this issue.

> I'm guessing that in practice strcpy_from_user() type operations copy
> much less than a page most of the time, so what we lose in uaccess
> overheads we _might_ regain in less redundant copying.

strncpy_from_user() has a fallback to byte by byte, so we don't have an
issue here.

The above is only for synchronous accesses. For async, in v3 I disabled
such checks for the uaccess routines.

-- 
Catalin
