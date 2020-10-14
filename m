Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E770228E380
	for <lists+linux-arch@lfdr.de>; Wed, 14 Oct 2020 17:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbgJNPp6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Oct 2020 11:45:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:46802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726954AbgJNPpw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 14 Oct 2020 11:45:52 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38A8D22246
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 15:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602690351;
        bh=9lOn7d49hdMJPBAKNJlKjJFXwOCSJN+nr4aroBt0z8Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=nTgLQYcNgiV4xvOcNFfqLSyoduB9LQwUmo1XmTF09eY04eNM9AZqsq/rx1nPTEgXD
         0iuygi538DbVwzDItQUCEkVx9WpDUcIaZ4JnnDqp3LPu5Moe5o9SgIRXCOdoE+kwVc
         NbH+N+n9MrrXEuLLWikuOiwUuZjfMiIt+mAlH0BI=
Received: by mail-wr1-f45.google.com with SMTP id e18so4424124wrw.9
        for <linux-arch@vger.kernel.org>; Wed, 14 Oct 2020 08:45:51 -0700 (PDT)
X-Gm-Message-State: AOAM531BJmDZjoIB6MFy0L/E09mQ9ZgR2ed/PGZWOZxqEXyEBswOfIt8
        BtZgfyz1FDWFMb/1XcNpkCR/luDhTSj5vVu33yxQgw==
X-Google-Smtp-Source: ABdhPJzQOydMjXK4UiJ3SXU5rT4smyYe2CcWv5kxCt2+PoOm7xJWs7FQA9thboa3WyHRS1tM8wCbwVh1dzX3hQW3mXI=
X-Received: by 2002:a5d:6744:: with SMTP id l4mr6472625wrw.18.1602690349612;
 Wed, 14 Oct 2020 08:45:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201014083300.19077-1-ankur.a.arora@oracle.com> <20201014083300.19077-6-ankur.a.arora@oracle.com>
In-Reply-To: <20201014083300.19077-6-ankur.a.arora@oracle.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 14 Oct 2020 08:45:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
Message-ID: <CALCETrVKLv5DPByFcj7E5SBbv4mFt7mGQ9j-HU7G5u_aPGCYsQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] x86/clear_page: add clear_page_uncached()
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, Linux-MM <linux-mm@kvack.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Michal Hocko <mhocko@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 14, 2020 at 1:33 AM Ankur Arora <ankur.a.arora@oracle.com> wrote:
>
> Define clear_page_uncached() as an alternative_call() to clear_page_nt()
> if the CPU sets X86_FEATURE_NT_GOOD and fallback to clear_page() if it
> doesn't.
>
> Similarly define clear_page_uncached_flush() which provides an SFENCE
> if the CPU sets X86_FEATURE_NT_GOOD.

As long as you keep "NT" or "MOVNTI" in the names and keep functions
in arch/x86, I think it's reasonable to expect that callers understand
that MOVNTI has bizarre memory ordering rules.  But once you give
something a generic name like "clear_page_uncached" and stick it in
generic code, I think the semantics should be more obvious.

How about:

clear_page_uncached_unordered() or clear_page_uncached_incoherent()

and

flush_after_clear_page_uncached()

After all, a naive reader might expect "uncached" to imply "caches are
off and this is coherent with everything".  And the results of getting
this wrong will be subtle and possibly hard-to-reproduce corruption.

--Andy
