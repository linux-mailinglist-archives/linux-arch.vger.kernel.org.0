Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEA82001E0
	for <lists+linux-arch@lfdr.de>; Fri, 19 Jun 2020 08:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727799AbgFSGU4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 19 Jun 2020 02:20:56 -0400
Received: from ozlabs.org ([203.11.71.1]:49909 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgFSGUz (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 19 Jun 2020 02:20:55 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49p7wL5jVwz9sRk;
        Fri, 19 Jun 2020 16:20:50 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592547653;
        bh=EKAlwH7KMWYrcFWL23SicxqJVWA6PUXsyMOdTXnR/PY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MgSsavcewAYAsBdDFbtoBeCs4pwI8Pw44ofaqZsWzbBvq/8XIIX5HBYIj1OGZ1RBH
         SBR3aXYv3KyrTy7uZZA6Ur26SBqzW3f7GzJbauWhV9BiSvkNmgcZwl45966TlljNL0
         0nC02luelmCpLqXFfsCx2pS9OC+R6l8V+mpwjFC5NjZuUC84niSlpcfs65KBIo7uW4
         0a5huAuSz3bWTfax5WFGP6PRj+NVuer2xaCuJpOiGu5FbQmcmIXXAcEr+86kSl8LY3
         K0TG3L7/8QwVal78sg2tT7Pb2WSUFxZN19KK+34iL6sa2mMOupHRyg6ziGP1+vzjs0
         fHbErT7mhl2zA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, Helge Deller <deller@gmx.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: rename probe_kernel_* and probe_user_*
In-Reply-To: <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
References: <20200617073755.8068-1-hch@lst.de> <CAHk-=wjpnu=882iD9ck9Ywt6R1LYX_Hv-oS7dBMsWZwDRGZ5jA@mail.gmail.com>
Date:   Fri, 19 Jun 2020 16:21:18 +1000
Message-ID: <87lfkjd19d.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> [ Explicitly added architecture lists and developers to the cc to make
> this more visible ]
>
> On Wed, Jun 17, 2020 at 12:38 AM Christoph Hellwig <hch@lst.de> wrote:
>>
>> Andrew and I decided to drop the patches implementing your suggested
>> rename of the probe_kernel_* and probe_user_* helpers from -mm as there
>> were way to many conflicts.  After -rc1 might be a good time for this as
>> all the conflicts are resolved now.
>
> So I've merged this renaming now, together with my changes to make
> 'get_kernel_nofault()' look and act a lot more like 'get_user()'.
>
> It just felt wrong (and potentially dangerous) to me to have a
> 'get_kernel_nofault()' naming that implied semantics that we're all
> familiar with from 'get_user()', but acting very differently.
>
> But part of the fixups I made for the type checking are for
> architectures where I didn't even compile-test the end result. I
> looked at every case individually, and the patch looks sane, but I
> could have screwed something up.
>
> Basically, 'get_kernel_nofault()' doesn't do the same automagic type
> munging from the pointer to the target that 'get_user()' does, but at
> least now it checks that the types are superficially compatible.
> There should be build failures if they aren't, but I hopefully fixed
> everything up properly for all architectures.
>
> This email is partly to ask people to double-check, but partly just as
> a heads-up so that _if_ I screwed something up, you'll have the
> background and it won't take you by surprise.

The powerpc changes look right, compile cleanly and seem to work
correctly.

cheers
