Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E9D23D002
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 21:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728064AbgHET1l (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 15:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728205AbgHERLn (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 13:11:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49B86C061757;
        Wed,  5 Aug 2020 10:11:43 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id x9so48587344ljc.5;
        Wed, 05 Aug 2020 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wXACrCF85ppHwQuHqdOjCkc1N78NkRlSijLNjTow210=;
        b=oziJJooKYyQ5sG761r04I5LKIuXOAb4zkqQY0rWC/xo2s+cTYTs9U7RyQWnqJ5pq1v
         Nbi4cMvrIp/CIcHu8pIr+eoqlm0BvwqSZf/j11GWMus1IVdOI8eFA+JP3OpxAqxrqH8K
         4U3LrHkbnbOlDfybyMuly/WmuqEo0ptHsHBq2XUlda4WU2cHiLw7ZD+AnmV8uuOJ/jgu
         3gjhgLG0ATcZI4I3fwTk7ZEPoMTcfQVSsz4xqNOlCB6RK7j7M3zBxlIMpYdsF8DV3rrq
         yNVU9YFhsTtYiIivGSgzfm9XcHZ9fq/Ugzzwuzkf0diKBR/hJ5MKs2YpE9NsOoFGUM2c
         kG+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wXACrCF85ppHwQuHqdOjCkc1N78NkRlSijLNjTow210=;
        b=fy2+1n+7THDOEOMfrVeJoNVXeUqTWB47Cc5jeeq3qV6qII/TPZkzjoM5F1zwN39SH7
         sJ9f4arOEr8QeMfM6ndrmRgQjA8pAsRkiBk269x2RFtnqX7vOaHgkpbfSK884linWLTX
         Q6LD9UEeZWg5R2weVdDlFCxgMhc66yJ88KgWHxOcTxPNtMvW8aGuR1WdczwUt/LFXiBx
         GZtQPgsyOV6Q933OBKv1D53VoUPs2u0gvM6fg3RomCgZ8ZYiDVCE0MiyCRcKY26cyUjJ
         n1XCVadQ6UvT+0vhUC9orPSvP9R8Hr/tcAkV0iIeOxPeimdtsCpVSaWCpUjG0P4+V7Ji
         +Bmw==
X-Gm-Message-State: AOAM533MjCaGTP9PVtFlKGkuWRVb4n3t+wyPMSIgeiiDRUMSvpo07Xwr
        dUNSKEd2lTISYT0l4kE0KfrqOQqNYUbaI3c/oGk=
X-Google-Smtp-Source: ABdhPJwaicIhf8YdyAekvXwX7eOOzcHPiY2LvmIo6u440HJ6sOevFi0lA9FP0nbD1iVE8pjbKUmnQK8GBjMj1kpsXT0=
X-Received: by 2002:a2e:b814:: with SMTP id u20mr1829339ljo.202.1596647501750;
 Wed, 05 Aug 2020 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200802163601.8189-1-rppt@kernel.org> <20200802163601.8189-17-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-17-rppt@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 Aug 2020 19:11:30 +0200
Message-ID: <CANiq72k-hZwbnttADQhi3+NrHkLDVe95jxLAPvLbvSOW41+HaQ@mail.gmail.com>
Subject: Re: [PATCH v2 16/17] memblock: implement for_each_reserved_mem_region()
 using __next_mem_region()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Ingo Molnar <mingo@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Simek <monstr@monstr.eu>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Stafford Horne <shorne@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        iommu@lists.linux-foundation.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-c6x-dev@linux-c6x.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mips@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linuxppc-dev@lists.ozlabs.org, openrisc@lists.librecores.org,
        sparclinux@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Aug 2, 2020 at 6:40 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                    |  2 +-

The .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
