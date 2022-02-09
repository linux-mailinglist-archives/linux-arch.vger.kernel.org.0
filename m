Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7F8B4AF59A
	for <lists+linux-arch@lfdr.de>; Wed,  9 Feb 2022 16:43:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbiBIPm6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 10:42:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236209AbiBIPm5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 10:42:57 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5309C05CB8A;
        Wed,  9 Feb 2022 07:42:56 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 7205821106;
        Wed,  9 Feb 2022 15:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644421375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPanT84froBQDy0fnPPljPjc/sJJc6UFVNaQtZQNyJo=;
        b=SdlN6/o0bkHJLdF7/rqstxANEqRu2FGQdADvtFm36FXgWN7qy8cv5E9FmMIqemtYqj5JCx
        jcFKtYvkxRDAXyWddaU5BJQjRCKUXa8uB96+IfTENqG3s4IjsNq2JfIo9n1aVAoh4vUxkN
        ye8z9cU4lRKUrZHOL79VeCmsS2uUcBg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644421375;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cPanT84froBQDy0fnPPljPjc/sJJc6UFVNaQtZQNyJo=;
        b=0X+aVbHtAO76L1P2h7Y2RgH4e7i5tXnnZmX6Tcr6MKy1WuACuL/CGsKG7z3DXWtcr4kHZJ
        FFE4oGuZFBJRVUCA==
Received: from pobox.suse.cz (pobox.suse.cz [10.100.2.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 5BFF8A3B88;
        Wed,  9 Feb 2022 15:42:55 +0000 (UTC)
Date:   Wed, 9 Feb 2022 16:42:55 +0100 (CET)
From:   Miroslav Benes <mbenes@suse.cz>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>
Subject: Re: [PATCH v2 0/5] Allocate module text and data separately
In-Reply-To: <cover.1643282353.git.christophe.leroy@csgroup.eu>
Message-ID: <alpine.LSU.2.21.2202091639491.32090@pobox.suse.cz>
References: <cover.1643282353.git.christophe.leroy@csgroup.eu>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 27 Jan 2022, Christophe Leroy wrote:

> This series allow architectures to request having modules data in
> vmalloc area instead of module area.
> 
> This is required on powerpc book3s/32 in order to set data non
> executable, because it is not possible to set executability on page
> basis, this is done per 256 Mbytes segments. The module area has exec
> right, vmalloc area has noexec. Without this change module data
> remains executable regardless of CONFIG_STRICT_MODULES_RWX.
> 
> This can also be useful on other powerpc/32 in order to maximize the
> chance of code being close enough to kernel core to avoid branch
> trampolines.
> 
> Changes in v2:
> - Dropped first two patches which are not necessary. They may be added back later as a follow-up series.
> - Fixed the printks in GDB
> 
> Christophe Leroy (5):
>   modules: Always have struct mod_tree_root
>   modules: Prepare for handling several RB trees
>   modules: Introduce data_layout
>   modules: Add CONFIG_ARCH_WANTS_MODULES_DATA_IN_VMALLOC
>   powerpc: Select ARCH_WANTS_MODULES_DATA_IN_VMALLOC on book3s/32 and
>     8xx
> 
>  arch/Kconfig                |   6 ++
>  arch/powerpc/Kconfig        |   1 +
>  include/linux/module.h      |   8 ++
>  kernel/debug/kdb/kdb_main.c |  10 +-
>  kernel/module.c             | 193 +++++++++++++++++++++++++-----------
>  5 files changed, 156 insertions(+), 62 deletions(-)

Looks good to me apart from the typo I mentioned at v1. I will review 
again once it is rebased on Aaron's patch set.

Regards,
Miroslav
