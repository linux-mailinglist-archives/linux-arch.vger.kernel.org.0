Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D73223D018
	for <lists+linux-arch@lfdr.de>; Wed,  5 Aug 2020 21:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728827AbgHET3D (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 5 Aug 2020 15:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728587AbgHERKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 5 Aug 2020 13:10:35 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C17EC06179E;
        Wed,  5 Aug 2020 10:10:17 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id v15so20124964lfg.6;
        Wed, 05 Aug 2020 10:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+69HNPUBLn+0j8xa7ztNqSpAC3bH5kdSFM7se7mw/Y=;
        b=RdzmbMMLETEqNtoVgyRCKj1pU2wD/0M8qEqvRXNRRNY+b914UvXZkxoVgayVQubBPC
         CE/souAwCoROj7cmbTcH2Md3LKEYbq7hyPYtIYReTO92nMUXfSeWszPI988KPS2REOZ/
         x8Lg5axuTOlNvJMwV7URNblxu16MjbinauMnuxvVDwlqKDPHVH06HlMC2htBpXCjb11y
         71kjYcUyosO0NzQGNjoXOZVONMcKv4BHAUmemA/OfyAvVhCb2Eag/fpp10a8cB3ymmQm
         ukYz/pLgzNQdHe5F/wMNFpu3aiLl6i8gq8ye/o/O6zNgd9JR7Oi+/mkdZRJPFt4uOCZ/
         Wj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+69HNPUBLn+0j8xa7ztNqSpAC3bH5kdSFM7se7mw/Y=;
        b=TXA78WnFRc7+kmsk06wFjNijSy6LcK6tOgi2FTu2ciKvRimGzMeuck5iG/SZL7JiD9
         GwZ+CFCpm9kMgB2Ld+pG1hFVfufKo3zPrBbmTqn5Y9qDfMdA7Oxl0qP3G/GesI4a61QB
         BSYpmKkZk7PrSKqdiRb3FQ6EYKkVdzL/XqXwnsI9TvlVXpZEOAEJRSlGTbcGNJnpRK2x
         vYCK9PIvqb8fjsv5ewo+yM54g6YjxZAwl4GhbGOenmAvFaTZgkumx8hW4yhBXqrY27xo
         7joA0Jryu0v1/H1v77ciO/uy29dQaFhQjKcJEMEA7s4BabD6KpMiYJ/pDsMWabNqNQ7V
         8NUQ==
X-Gm-Message-State: AOAM532WYA+IN1EbKq89uAf0HSpe48/1ZkI9I2oWCmM69FfDECjegqem
        4igrjEsW9b8kbHB0IENnsnh0LWeW4WNhD3NfjCE=
X-Google-Smtp-Source: ABdhPJwrfD4lQmBmRhZhj4oSbWRKgm3lTiWKFBcnnoErai4/oJd38wR2GismiRK0iE3hYzt+6N6iDQ3Zkito0n/twrM=
X-Received: by 2002:a05:6512:3b7:: with SMTP id v23mr2064439lfp.10.1596647415748;
 Wed, 05 Aug 2020 10:10:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200802163601.8189-1-rppt@kernel.org> <20200802163601.8189-18-rppt@kernel.org>
In-Reply-To: <20200802163601.8189-18-rppt@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 Aug 2020 19:10:04 +0200
Message-ID: <CANiq72kaw7EMePMbgYyKMCkBC+7CgERq4FV2Lp-fH+ea3H12vg@mail.gmail.com>
Subject: Re: [PATCH v2 17/17] memblock: use separate iterators for memory and
 reserved regions
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

On Sun, Aug 2, 2020 at 6:41 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                  |  3 ++-

The .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
