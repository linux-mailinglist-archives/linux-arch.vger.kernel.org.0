Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557916D7A7E
	for <lists+linux-arch@lfdr.de>; Wed,  5 Apr 2023 12:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237396AbjDEK52 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Apr 2023 06:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230313AbjDEK51 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Apr 2023 06:57:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C863293;
        Wed,  5 Apr 2023 03:57:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 660BF636F1;
        Wed,  5 Apr 2023 10:57:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3690BC433EF;
        Wed,  5 Apr 2023 10:57:23 +0000 (UTC)
Date:   Wed, 5 Apr 2023 11:57:20 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arch@vger.kernel.org, avagin@gmail.com, peterz@infradead.org,
        luto@kernel.org, krisman@collabora.com, tglx@linutronix.de,
        corbet@lwn.net, shuah@kernel.org, arnd@arndb.de,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v15 2/4] syscall user dispatch: untag selector addresses
 before access_ok
Message-ID: <ZC1UEK43yOsXKvi4@arm.com>
References: <20230330212121.1688-1-gregory.price@memverge.com>
 <20230330212121.1688-3-gregory.price@memverge.com>
 <ZCYP+4gRZDqC0lRo@arm.com>
 <20230404104506.GA24740@redhat.com>
 <ZCxfdC+v4v6EEy4v@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCxfdC+v4v6EEy4v@arm.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Apr 04, 2023 at 06:33:40PM +0100, Catalin Marinas wrote:
> On Tue, Apr 04, 2023 at 12:45:06PM +0200, Oleg Nesterov wrote:
> > doesn't this mean that access_ok() on arm64 could use
> > untagged_addr(addr) unconditionally without any security risk?
> 
> Yes, from the security perspective, but there are ABI implications.
> 
> Currently untagged_addr() in access_ok() is conditional on the user
> process enabling the tagged address ABI (prctl() that sets a TIF flag).
> The reason we did not enable this by default was a slight fear of
> breaking the ABI since tagged pointers were not allowed at the syscall
> boundary. It turned out that the fear was justified since the
> unconditional untagged_addr() in brk() broke user space (see commit
> dcde237319e6 "mm: Avoid creating virtual address aliases in
> brk()/mmap()/mremap()"; the user was doing an sbrk(PY_SSIZE_T_MAX) and
> bits 56 and higher were ignored by the kernel).
> 
> I'd be ok with untagging the address unconditionally in the arm64
> access_ok() introduce another unaliased_access_ok() (I'm not good at
> naming functions) that preserves the non-tagged behaviour and we use it
> in brk/mmap/mremap().

Actually, I'm wrong here. There's no access_ok() check on the brk()
path. The unconditional untagged_addr() prior to dcde237319e6 messed up
the comparison between the old and new brk limit and shrank the heap
space for a process.

So, relaxing access_ok() to always do the untagging should not affect
the brk/mmap/mremap() cases.

-- 
Catalin
