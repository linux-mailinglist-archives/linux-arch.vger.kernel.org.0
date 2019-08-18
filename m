Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFE99141D
	for <lists+linux-arch@lfdr.de>; Sun, 18 Aug 2019 04:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfHRCUd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Aug 2019 22:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbfHRCUd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 17 Aug 2019 22:20:33 -0400
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E158217F4;
        Sun, 18 Aug 2019 02:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566094832;
        bh=OPY3V0VybgTAW/TfTy5ht1ElPNtB7wmhajw4Ua8nsM4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B8gICytMWtf9sSp2gWth8rJlo7ccG8GmZGksHlQpQZ2aQ2V8qKhezlSer8nu0kLsw
         IEgo5T4rtcStB86cO09141TYic+/RSvTqgkBH8LFADvO4nfXnVH+lllvshW+iwmFe8
         3khqevP1orkrp6CPHHDbbrjLKfcmdrkxyX/9Pjfg=
Received: by mail-wm1-f46.google.com with SMTP id o4so134739wmh.2;
        Sat, 17 Aug 2019 19:20:32 -0700 (PDT)
X-Gm-Message-State: APjAAAXneIX53JObRcmTJJKKw3D2DWw5JS3/zs9MEJLrx0/HMiYYnzDo
        j5YBamMSRi9j2Uj3FwRSqkwVL5/ppiG1muzPEjI=
X-Google-Smtp-Source: APXvYqzI7WQkVURNqZ2bMcrBH43jaDIpUzhzxYNWBXKHEb1Z1mqumimCqpgOybei9ECXbxr+D02Ru3e1mc41ffC8syc=
X-Received: by 2002:a1c:1f4e:: with SMTP id f75mr12874929wmf.137.1566094830733;
 Sat, 17 Aug 2019 19:20:30 -0700 (PDT)
MIME-Version: 1.0
References: <1565868537-17753-1-git-send-email-guoren@kernel.org> <20190816070348.GA13766@infradead.org>
In-Reply-To: <20190816070348.GA13766@infradead.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 18 Aug 2019 10:20:18 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
Message-ID: <CAJF2gTTBc3+SnKMbVU4A+tekyjkd_7XUmDCUfNCcA-CZf=JUyg@mail.gmail.com>
Subject: Re: [PATCH] csky: Fixup ioremap function losing
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-csky@vger.kernel.org, zhang_jian5@dahuatech.com,
        Guo Ren <ren_guo@c-sky.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thx Christoph,

On Fri, Aug 16, 2019 at 3:03 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Thu, Aug 15, 2019 at 07:28:57PM +0800, guoren@kernel.org wrote:
> > From: Guo Ren <ren_guo@c-sky.com>
> >
> > Implement the following apis to meet usage in different scenarios.
> >
> >  - ioremap          (NonCache + StrongOrder)
> >  - ioremap_nocache  (NonCache + StrongOrder)
> >  - ioremap_wc       (NonCache + WeakOrder  )
> >  - ioremap_cache    (   Cache + WeakOrder  )
> >
> > Also change flag VM_ALLOC to VM_IOREMAP in get_vm_area_caller.
>
> Looks generally fine, but two comments:
>
>  - do you have a need for ioremap_cache?  We are generally try to
>    phase it out in favour of memremap, and it is generally only used
>    by arch specific code.
Yes, some drivers of our customers use ioremap_cache to map phy_addr
which isn't belong to system memory.

>  - I have a big series pending to clean up the mess with our
>    ioremap_* functions, including adding a generic implementation
>    that csky should be able to use.  Unless this patch is urgent it
>    might make sense to rebase it on top.  Here is my current tree, I
>    plan to post it soon:
>
>         http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/generic-ioremap
I agree to use GENERIC_IOREMAP, but I want to add csky support
GENERIC_IOREMAP patch by myself.
You could remove "csky: use generic ioremap" in your patchset first
and I'll add support GENERIC_IORMAP patch later.
Then we won't get confilct :)

--
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
