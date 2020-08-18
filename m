Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D629F2490A9
	for <lists+linux-arch@lfdr.de>; Wed, 19 Aug 2020 00:18:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgHRWSQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Aug 2020 18:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgHRWSO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Aug 2020 18:18:14 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FDE3C061389;
        Tue, 18 Aug 2020 15:18:12 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id h8so11038955lfp.9;
        Tue, 18 Aug 2020 15:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nn5mkrGFBbPg90QSTX4ScoaPazdulb+v6hO8tmlQUhM=;
        b=OIqydpEtkNgTroF3lnVBbcPUKQ2ogcmEFiN7wEqPDoyKdbDTrVZZ+NzClaB1tmtiGg
         1q5dVw3gvA1HPNIt4f5Vr2bR4NBZwxXhiEUf3tzRwKt7NekpaA3/ibZvmA16+OG3grZ+
         Y0pgD14ByceFmFxwkAMy97PtaHPZGmMkTHmHfX1qI8cguewQrhSEyNet//D8uLt3URbX
         wtAIYHJxjbyMRdcrkRjXE+IjNA6JaY3Jp4v8SILylCVLQ416pwm5RG8VS/kkCIf9Vupf
         N2rIlz5ZIsghwkVWwHdlgrBINrap6VQaSjRwMPYFZcqiCFlD1Cw4CyHiSO7wqpA8NX8m
         GJbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nn5mkrGFBbPg90QSTX4ScoaPazdulb+v6hO8tmlQUhM=;
        b=T08e/G4Rv7ZydfUv5SrjM5//sHT1keh1xSGWshvjQVB6krwsWrejAyXW7yR+ho3jpW
         yhd6r9KlDJepdRrluYSvIgl4V834DWRsZF8urwaE8k7t91v8OT7+cGy0BMGCpYqOsWX4
         JCLmRKdbIjJS4c3sc4qRNPeydcAAwVj7TDG4l1VGVFr87VMOiqwjdAA+xqTChMw7FZv3
         G4r6ToJ6bLnG7KxSQ9VnwTsDtRz8CeUC4RNyVVt38bj03/w6vhWDDn4CRN7FAP0rl1S1
         UG0yqhh+7uKd6iTNIWq1i7g5N1hRCGzrWd8ibHDp6gPSUj7RYsDHTBE3xPJzBAMAc8Sj
         CAWA==
X-Gm-Message-State: AOAM530wrsGT0b34kll89/8Jiujhg5U2J38dXPFZKi56bNHC4BJPRxIx
        0p2gy8ivNPzL8wglXSdigCkat2Cx5/sphMQ/y8E=
X-Google-Smtp-Source: ABdhPJyYNUN3v5scOCVMaoKuHu78eqvAibUFuUkJdpzA5rqp/I7KCAgyGHrlcUN+z5qLySo7/N7W852szcke7k/pYlA=
X-Received: by 2002:a19:cb51:: with SMTP id b78mr10676996lfg.130.1597789091106;
 Tue, 18 Aug 2020 15:18:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200818151634.14343-1-rppt@kernel.org> <20200818151634.14343-11-rppt@kernel.org>
In-Reply-To: <20200818151634.14343-11-rppt@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 19 Aug 2020 00:18:00 +0200
Message-ID: <CANiq72mnzTv7SphVxsYy++rAPdaKVVLGGHauxNLY5D4dzq3CPA@mail.gmail.com>
Subject: Re: [PATCH v3 10/17] memblock: reduce number of parameters in for_each_mem_range()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@lst.de>, Daniel Axtens <dja@axtens.net>,
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
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Aug 18, 2020 at 5:19 PM Mike Rapoport <rppt@kernel.org> wrote:
>
>  .clang-format                          |  2 ++

For the .clang-format bit:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
