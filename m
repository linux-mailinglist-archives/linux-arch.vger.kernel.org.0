Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFE7C3C81C3
	for <lists+linux-arch@lfdr.de>; Wed, 14 Jul 2021 11:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbhGNJkF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Jul 2021 05:40:05 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:41845 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238271AbhGNJkF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Jul 2021 05:40:05 -0400
Received: by mail-wr1-f53.google.com with SMTP id k4so2370527wrc.8;
        Wed, 14 Jul 2021 02:37:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pdlAHlD2ZyPGKOx9n47bU66ewrFcmMaH8q4yPw3umtg=;
        b=uHezbfts0TlBr5xOzGSipo2npk8KZzJ6fyUk2TpF1vLxo4z4E5WoR96Jm0LiBZZtGk
         508pK9J3niwFg0AC1Pn7178Ame6QYMRpxyk8ELfOFvzB0U2DS4aJJJTkgXN0MIUZw6Ku
         c3Q3KKGsiVS+vkImgcWqkdFZFCnzMvBOifhWY1DL9tvOG3eBHdvptMqCXYlvLIUsMNCa
         FlckGGyTNtEzdxUwkdkC2ytz7pmN9x0aJon1KN5dWNFSJPCtwO/jpbFGBTBrOYdokivj
         WcaXKRrwuA+y/T2fKBFz2aONwZ6RsD/pZTcHe32ZcGWYU+FsT+rFOXFScdPfLVWF3O4v
         Fcug==
X-Gm-Message-State: AOAM530bbOS9L6ly0BDG4nEwAVxkoQFUi6ryFctTukGB4YGf2hdZ+nTu
        w/T5vGa43yCvVt0hFZUZ60w=
X-Google-Smtp-Source: ABdhPJwDm2zkfKKrv/S0cH9JkO+6NeItQ5d2FN0p+UGVUqF6iRudvuyggx3kNK15Xxym5U4Q8STlnw==
X-Received: by 2002:a5d:5141:: with SMTP id u1mr11691349wrt.193.1626255431766;
        Wed, 14 Jul 2021 02:37:11 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id a9sm1858431wrv.37.2021.07.14.02.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 02:37:11 -0700 (PDT)
Date:   Wed, 14 Jul 2021 09:37:09 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     sthemmin@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH 0/3] Additional refactoring of Hyper-V arch specific code
Message-ID: <20210714093709.v4ersuwmbvtqebat@liuwe-devbox-debian-v2>
References: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1626060316-2398-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jul 11, 2021 at 08:25:13PM -0700, Michael Kelley wrote:
> This patch set moves additional Hyper-V code under arch/x86 into
> arch-neutral hv_common.c where it can be shared by x86 and
> and ARM64 implementations.  The move reduces the overall lines
> of code across both architectures, and removes code under
> arch/ that isn't really architecture-specific.
> 
> The code is moved into hv_common.c because it must be
> built-in to the kernel image, and not be part of a module.
> 
> No functional changes are intended.
> Michael Kelley (3):
>   Drivers: hv: Make portions of Hyper-V init code be arch neutral
>   Drivers: hv: Add arch independent default functions for some Hyper-V
>     handlers
>   Drivers: hv: Move Hyper-V misc functionality to arch-neutral code
> 
>  arch/x86/hyperv/hv_init.c       | 101 +++-----------------
>  arch/x86/include/asm/mshyperv.h |   4 -
>  arch/x86/kernel/cpu/mshyperv.c  |  24 -----
>  drivers/hv/hv_common.c          | 198 ++++++++++++++++++++++++++++++++++++++++
>  include/asm-generic/mshyperv.h  |  10 ++
>  5 files changed, 219 insertions(+), 118 deletions(-)
> 

Applied to hyperv-next. Thanks.

> -- 
> 1.8.3.1
> 
