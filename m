Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2EF1BAA85
	for <lists+linux-arch@lfdr.de>; Mon, 27 Apr 2020 18:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbgD0Q4q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Apr 2020 12:56:46 -0400
Received: from foss.arm.com ([217.140.110.172]:38266 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgD0Q4q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 27 Apr 2020 12:56:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADB1531B;
        Mon, 27 Apr 2020 09:56:45 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 297AA3F68F;
        Mon, 27 Apr 2020 09:56:44 -0700 (PDT)
Date:   Mon, 27 Apr 2020 17:56:42 +0100
From:   Dave Martin <dave.martin@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20200427165641.GC15808@arm.com>
References: <20200421142603.3894-1-catalin.marinas@arm.com>
 <20200421142603.3894-21-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421142603.3894-21-catalin.marinas@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 21, 2020 at 03:26:00PM +0100, Catalin Marinas wrote:
> The copy_mount_options() function takes a user pointer argument but not
> a size. It tries to read up to a PAGE_SIZE. However, copy_from_user() is
> not guaranteed to return all the accessible bytes if, for example, the
> access crosses a page boundary and gets a fault on the second page. To
> work around this, the current copy_mount_options() implementations
> performs to copy_from_user() passes, first to the end of the current
> page and the second to what's left in the subsequent page.
> 
> Some architectures like arm64 can guarantee an exact copy_from_user()
> depending on the size (since the arch function performs some alignment
> on the source register). Introduce an arch_has_exact_copy_from_user()
> function and allow copy_mount_options() to perform the user access in a
> single pass.
> 
> While this function is not on a critical path, the single-pass behaviour
> is required for arm64 MTE (memory tagging) support where a uaccess can
> trigger intra-page faults (tag not matching). With the current
> implementation, if this happens during the first page, the function will
> return -EFAULT.

Do you know how much extra overhead we'd incur if we read at must one
tag granule at a time, instead of PAGE_SIZE?

I'm guessing that in practice strcpy_from_user() type operations copy
much less than a page most of the time, so what we lose in uaccess
overheads we _might_ regain in less redundant copying.

Would need behchmarking though.

[...]

Cheers
---Dave
