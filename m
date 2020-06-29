Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1944320D261
	for <lists+linux-arch@lfdr.de>; Mon, 29 Jun 2020 20:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729381AbgF2Ss6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 Jun 2020 14:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729136AbgF2Srm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 Jun 2020 14:47:42 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C001C02E2C4;
        Mon, 29 Jun 2020 07:01:28 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id e3so1342915qvo.10;
        Mon, 29 Jun 2020 07:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FrjxWdY/Gjwce8t0JyeJsnYTMhQlskObJO/oLUWzfo=;
        b=KsYeoNtN/hmKD60koJPvKXhY1HT5rh0BdsIymjK2OY+Ah5csm67fWOMInZoSB5MyiF
         z81tpEOU7gbEs2Eu9dK1IU73/ldLFTcOuXQ4NQt1zxjMaUlUH9xpuPmQkDZyG2XpHE5A
         z0rDQ6F3p6odfLFvjQ20/v+vqn3osPhCyUtrTurdqBrAHPO36wwugYL1OqGKXGdazN2M
         p5mNNLqMsIqkd1lea0NNKZvGNZ4NvI4uksXON6N73LrjpsMxdX6M9+heVdl/zTyGvkYj
         tkHXxI8XU7hiVfWyn9RhwdGCF2zdf8eMUPHFh6FNadOyOkvVyTEcnpjW7aa7VVLEWYLN
         vdxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FrjxWdY/Gjwce8t0JyeJsnYTMhQlskObJO/oLUWzfo=;
        b=DSuuW0+07wcgDzTyrYqX0uyN8GZtYZA9b0ZFzEyTViLNb4h6pZE597I9G0VIgucvJD
         aiZeyxbU/LSSBjt/pL+KcMGE7PdanaXo0F2JQdC4l7Q+lwLAbtqljTLF5jCwAHMlBPUx
         g9V1dJ5kIS/ynUdt8Uj9EbrQvD1UKTOBhjBgT3ZyiKXpXLYea3P9JO587LRoRz2KeeNv
         eZqifAnr1Wkk1Tbua5iQLkIIx1PjQ4rLVNJNpBwRZBFoa/yWLwkUM8sbJjjbKMZOzgjN
         W751EaDIWYcQSSdewozHh8vpCX0MUn8gZqR6oLzx/ggkpNe6LzEx+ImM9X0Jc6Xo6gRe
         H7ow==
X-Gm-Message-State: AOAM531JKlq/ZGAplHoVs4tch6+PMhfQcqxtbGk2MjY0gdNj9heTXIcP
        cO3qNZhciqnutr86w2breH3RRck7yxyKPa0VQlQ=
X-Google-Smtp-Source: ABdhPJwRvnHK4e9FuZZ286EO2eHunvWxUS+jw1hxD70l+wfbFL9aDwHZRKLC21a2KPKCyOwmNUkOhP18WuRSaAVXDjg=
X-Received: by 2002:ad4:4cc3:: with SMTP id i3mr8130354qvz.114.1593439286277;
 Mon, 29 Jun 2020 07:01:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200627143453.31835-1-rppt@kernel.org>
In-Reply-To: <20200627143453.31835-1-rppt@kernel.org>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Mon, 29 Jun 2020 17:01:14 +0300
Message-ID: <CAOJsxLE47WP9aMY3nh=E7C1a_esHt=sBFWCnsVA2umZ7TZ6TTA@mail.gmail.com>
Subject: Re: [PATCH 0/8] mm: cleanup usage of <asm/pgalloc.h>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Joerg Roedel <joro@8bytes.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Stafford Horne <shorne@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-alpha@vger.kernel.org,
        "list@ebiederm.org:DOCUMENTATION <linux-doc@vger.kernel.org>,
        list@ebiederm.org:MEMORY MANAGEMENT <linux-mm@kvack.org>," 
        <linux-arch@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        ia64 <linux-ia64@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org, linuxppc-dev@lists.ozlabs.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Jun 27, 2020 at 5:35 PM Mike Rapoport <rppt@kernel.org> wrote:
> Most architectures have very similar versions of pXd_alloc_one() and
> pXd_free_one() for intermediate levels of page table.
> These patches add generic versions of these functions in
> <asm-generic/pgalloc.h> and enable use of the generic functions where
> appropriate.

Very nice cleanup series to the page table code!

FWIW:

Reviewed-by: Pekka Enberg <penberg@kernel.org>
