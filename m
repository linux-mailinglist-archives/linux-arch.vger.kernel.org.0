Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FAC1CB9DD
	for <lists+linux-arch@lfdr.de>; Fri,  8 May 2020 23:33:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbgEHVdd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 May 2020 17:33:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:60940 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgEHVdd (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 8 May 2020 17:33:33 -0400
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B44062496C
        for <linux-arch@vger.kernel.org>; Fri,  8 May 2020 21:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588973613;
        bh=ls4wVLtCuwHy+Ipjb7HA8vnN9MIN6Wmha+TzdYWtvKc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yXYCK8wdmW7DSPZEAko5JQmjTXcv8PdsFAV/LF5riUcPziJRL1l0KdBsFXB1VjVNZ
         1smnvum2Iul+xNULH/Fl11Qe7w0EUC26KWYgSqlE/DyLmrEY8OiaEzni0F6K9sRr6s
         dkBy9H/RZKOPCiNigG/2Fn8Nm57XOrfHr3C3iu+0=
Received: by mail-wr1-f52.google.com with SMTP id v12so3562472wrp.12
        for <linux-arch@vger.kernel.org>; Fri, 08 May 2020 14:33:32 -0700 (PDT)
X-Gm-Message-State: AGi0PualAeEJif3o5hjJEAPYvcc92RhqfoB09lpQ+K0hAVNL4q/kq0Ke
        oFfRyd9L/eFCxOHwPXmhY1eqNeNpUclOJw/R8I4HRw==
X-Google-Smtp-Source: APiQypKkfKc8nwfTQ52CA43jPndN8sjJe/HJmtfTKVOm8iPpMCUmgdfl9U9gxXEGBQZwhTi1KHad8bdjblEo8vujjkg=
X-Received: by 2002:adf:e586:: with SMTP id l6mr5031852wrm.184.1588973611034;
 Fri, 08 May 2020 14:33:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200508144043.13893-1-joro@8bytes.org>
In-Reply-To: <20200508144043.13893-1-joro@8bytes.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 8 May 2020 14:33:19 -0700
X-Gmail-Original-Message-ID: <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
Message-ID: <CALCETrX0ubjc0Gf4hCY9RWH6cVEKF1hv3RzqToKMt9_bEXXBvw@mail.gmail.com>
Subject: Re: [RFC PATCH 0/7] mm: Get rid of vmalloc_sync_(un)mappings()
To:     Joerg Roedel <joro@8bytes.org>
Cc:     X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, May 8, 2020 at 7:40 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> Hi,
>
> after the recent issue with vmalloc and tracing code[1] on x86 and a
> long history of previous issues related to the vmalloc_sync_mappings()
> interface, I thought the time has come to remove it. Please
> see [2], [3], and [4] for some other issues in the past.
>
> The patches are based on v5.7-rc4 and add tracking of page-table
> directory changes to the vmalloc and ioremap code. Depending on which
> page-table levels changes have been made, a new per-arch function is
> called: arch_sync_kernel_mappings().
>
> On x86-64 with 4-level paging, this function will not be called more
> than 64 times in a systems runtime (because vmalloc-space takes 64 PGD
> entries which are only populated, but never cleared).

What's the maximum on other system types?  It might make more sense to
take the memory hit and pre-populate all the tables at boot so we
never have to sync them.
