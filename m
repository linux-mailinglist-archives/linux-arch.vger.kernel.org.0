Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC10F3DB966
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 15:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238982AbhG3NgJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 09:36:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:40744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238971AbhG3NgI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 30 Jul 2021 09:36:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3016C60F5C;
        Fri, 30 Jul 2021 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627652164;
        bh=Kxc+WnvFkFgpyTYYCMg+FHtM463+Ta69Z65pcvFy+nw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ho38LvuKv74hab1fk9TeMpOaOP6S+B8D6La1ytammZe5husN2Sln3hk0b/jsKKSP0
         Oz9B9qEtRAk1vmf+xAbnGmmd1qGPrQ9eU9guuq08fEy1thlwKJFnvdr7w53exlPS5B
         k3IeKepk+++IJ/FD/tQwIU77xPc6BY7A8E0E/yzZnR1X6UFUVaRYVOX9RitafiYcbV
         bib44KzdYE0lqK4kU4CYw8St0cKpzFa5VucXQ9aczPK2DoLoAKfefZLGOIjmQj1Tqw
         GMjjZmvtivOvJ8j07Wxuk3EZcIC+y0tVdQ6NY50ImRhnD1JcDVSgsJHoIXs89/F/p8
         Jl4YG45FZpqUg==
Received: by mail-ej1-f45.google.com with SMTP id e19so16854416ejs.9;
        Fri, 30 Jul 2021 06:36:04 -0700 (PDT)
X-Gm-Message-State: AOAM530U5TA7H9peY0mh8WKWGEoKFFky28NbbltMa8POY+az9yFOBLuP
        WuZNzjyeFFrLKF3kncT4pX//6+imT7nXEpC2Eu4=
X-Google-Smtp-Source: ABdhPJwuftgxHedyhF9ABjFcX5ntB4hnZJtnEQD3qNPIiKJ5o00xy/u2gbz8S8h+EITSt2YoA2WUUAyPzv0cemOlwyo=
X-Received: by 2002:adf:fd90:: with SMTP id d16mr3288984wrr.105.1627652152412;
 Fri, 30 Jul 2021 06:35:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210727144859.4150043-1-arnd@kernel.org> <YQPLG20V3dmOfq3a@osiris>
In-Reply-To: <YQPLG20V3dmOfq3a@osiris>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 30 Jul 2021 15:35:35 +0200
X-Gmail-Original-Message-ID: <CAK8P3a0YV0UVsui67WE4LiGM+RmQsDBOvFMaKArT5UmNLgN5GA@mail.gmail.com>
Message-ID: <CAK8P3a0YV0UVsui67WE4LiGM+RmQsDBOvFMaKArT5UmNLgN5GA@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] compat: remove compat_alloc_user_space
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christoph Hellwig <hch@infradead.org>,
        Feng Tang <feng.tang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 11:49 AM Heiko Carstens <hca@linux.ibm.com> wrote:
> On Tue, Jul 27, 2021 at 04:48:53PM +0200, Arnd Bergmann wrote:
>
> Our CI reports this with linux-next and running strace selftest in
> compat mode:

Thanks a lot for the report! I managed track it down based on your
output, it turns out that I end up copying data from the stack according
to how much the user asked for, and in this case that was much more
than the 8 byte nodemask_t, copying all of the kernel stack all the
way into the guard page with CONFIG_VMAP_STACK, where it
crashed. Without CONFIG_VMAP_STACK, or with user space that
asks for less data, it would just be an information leak, so others
probably haven't noticed the problem.

The change below should fix that, I'll double-check the other callers
as well before sending a proper fixup patch to Andrew.

        Arnd

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 4fabf2dddbc0..0d1f3be32723 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1438,6 +1438,7 @@ static int copy_nodes_to_user(unsigned long
__user *mask, unsigned long maxnode,
                if (clear_user((char __user *)mask + nbytes, copy - nbytes))
                        return -EFAULT;
                copy = nbytes;
+               maxnode = nr_node_ids;
        }

        if (compat)
