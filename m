Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057E5270F79
	for <lists+linux-arch@lfdr.de>; Sat, 19 Sep 2020 18:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgISQXh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 19 Sep 2020 12:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgISQXg (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 19 Sep 2020 12:23:36 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 127BE2311B
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 16:23:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600532616;
        bh=yIMDaLtf/+YFizwPnR8klP42GqyYZ5ElGRoZQu6X97M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YUs5z6A+jbyOjViAggfd75LfVJAXVlL6S70XXy/bSyZscAbDzqAWG4OVuiRPoKllX
         8iDAYtkYLMWVWSGiZALQNnGWPtgEG54QgPP0UeehdM25bePxbkLBmtaA7MbAPhserV
         gTh/eYz4pD8V9OCDj3Y0DZjZnifKA2vn2zkFrfDg=
Received: by mail-wm1-f41.google.com with SMTP id w2so8091344wmi.1
        for <linux-arch@vger.kernel.org>; Sat, 19 Sep 2020 09:23:36 -0700 (PDT)
X-Gm-Message-State: AOAM5336G8Fy0GDUdodXFQ9jZIjcjK0N0+eBtCB8VZW7J44WGqrEdsA2
        NBcuPS58ORJI9EtBIgoqZ7mkexmHIGIUqp/MdvqwUw==
X-Google-Smtp-Source: ABdhPJwlQQiwz+pgI03nF2aOSUVgWBn9X9k20I0J0W3TutdYI4/0CQ+JWWhM7EREU/GlWxV9KL8iEAPcgKTxRTyI700=
X-Received: by 2002:a1c:7e15:: with SMTP id z21mr21042180wmc.21.1600532614589;
 Sat, 19 Sep 2020 09:23:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200918132439.1475479-1-arnd@arndb.de> <20200918132439.1475479-2-arnd@arndb.de>
 <20200919053514.GI30063@infradead.org>
In-Reply-To: <20200919053514.GI30063@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 19 Sep 2020 09:23:22 -0700
X-Gmail-Original-Message-ID: <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
Message-ID: <CALCETrVDqHG2chDsLWBHF39SXh6vjzE_xcEs+AWgOg5531BLuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] x86: add __X32_COND_SYSCALL() macro
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Eric Biederman <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christoph Hellwig <hch@lst.de>, Brian Gerst <brgerst@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Sep 18, 2020 at 10:35 PM Christoph Hellwig <hch@infradead.org> wrote:
>
> On Fri, Sep 18, 2020 at 03:24:36PM +0200, Arnd Bergmann wrote:
> > sys_move_pages() is an optional syscall, and once we remove
> > the compat version of it in favor of the native one with an
> > in_compat_syscall() check, the x32 syscall table refers to
> > a __x32_sys_move_pages symbol that may not exist when the
> > syscall is disabled.
> >
> > Change the COND_SYSCALL() definition on x86 to also include
> > the redirection for x32.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Adding the x86 maintainers and Brian Gerst.  Brian proposed another
> problem to the mess that most of the compat syscall handlers used by
> x32 here:
>
>    https://lkml.org/lkml/2020/6/16/664
>
> hpa didn't particularly like it, but with your and my pending series
> we'll soon use more native than compat syscalls for x32, so something
> will need to change..

I'm fine with either solution.
