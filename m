Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC26484290
	for <lists+linux-arch@lfdr.de>; Tue,  4 Jan 2022 14:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233745AbiADNer (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 4 Jan 2022 08:34:47 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:35796 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbiADNek (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 4 Jan 2022 08:34:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FC4761444;
        Tue,  4 Jan 2022 13:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C58C36AF4;
        Tue,  4 Jan 2022 13:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641303279;
        bh=1z/h3x51L7FOAPULIYKW8CsSkufkcXQ2B5gb0BntU0g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wPNHnV8ENpd0QivYscWqGqN5Stl2gXKGUSDq3caquRXQ58Jy1oqIoBDMBJxTEI+Ki
         JE5eO95Wbtz+PNchTZWyeavslH9nYz4jr18/Y9khM7i0KK3I4tp1Zz1656PrNtvwro
         XLfw9UZvYOyuMe5kuMRPrE0R4ramPZ3ajp7SRURM=
Date:   Tue, 4 Jan 2022 14:34:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH 0000/2297] [ANNOUNCE, RFC] "Fast Kernel Headers" Tree
 -v1: Eliminate the Linux kernel's "Dependency Hell"
Message-ID: <YdRM7I9E2WGU4GRg@kroah.com>
References: <YdIfz+LMewetSaEB@gmail.com>
 <20220103135400.4p5ezn3ntgpefuan@box.shutemov.name>
 <YdQnfyD0JzkGIzEN@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdQnfyD0JzkGIzEN@gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 04, 2022 at 11:54:55AM +0100, Ingo Molnar wrote:
> There's one happy exception though, all the uninlining patches that 
> uninline a single-call function are probably fine as-is:

<snip>

>  3443e75fd1f8 headers/uninline: Uninline single-use function: kobject_has_children()

Let me go take this right now, no need for this to wait, it should be
out of kobject.h as you rightfully show there is only one user.

thanks,

greg k-h
