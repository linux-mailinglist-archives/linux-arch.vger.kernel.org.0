Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 920F4387383
	for <lists+linux-arch@lfdr.de>; Tue, 18 May 2021 09:48:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241224AbhERHt5 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 May 2021 03:49:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:38258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234891AbhERHt5 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 18 May 2021 03:49:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 67B5160FE7;
        Tue, 18 May 2021 07:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621324119;
        bh=ZvGkPYlYj2nqGmESCnOClTJykmU52wuUqDlRt38OfA0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DxfI8vWupsEgScwwsgAAWaxLJODkg+jRKN42nvXRZIK7KuL5kQQLP99tuTwCTBXnS
         uafZ90muV++LA/p87BnSyCSSaSthDNw8iBlfyRmq3XSQhoQPVu2hIXJIJ4bLVwGCNQ
         S6g5yQPH9vfxZAL3h5odLDBQ/uENnw/EUrtB8sOw+AsUfN0dwdy8Z9p0/fu00Or1YG
         HSfkXCgy+lvz5mtA05ZmHPfItVnnUAt6A9a1FiPhBIeOkuAuxW0MXsfBgkAd2C5L6J
         uVWbchBFvSPmyqEWTUmAMeA5EeJ7XTJN9VrrFIhLkPltUvZRkWLmk2Jq9qQqWHsU8C
         5eJ6eIHy6orkA==
Received: by mail-wm1-f51.google.com with SMTP id o6-20020a05600c4fc6b029015ec06d5269so929404wmq.0;
        Tue, 18 May 2021 00:48:39 -0700 (PDT)
X-Gm-Message-State: AOAM533NMaYYIwZuqdhQylWxIUqBT1el+NwbORnn4EgXzd0akBSt067k
        JcN8s6LxeFRoBo037rOrVzgNbyI2QKCvDthclI8=
X-Google-Smtp-Source: ABdhPJz4k8XxX24/Dox9+GySTr8wlMSmxqo+SuzqOQF2aXlWbf96HeHqVkq/eJMb4rVErJpv4OfcoAmTm6cuSeTNHgA=
X-Received: by 2002:a7b:c849:: with SMTP id c9mr3442580wml.84.1621324118063;
 Tue, 18 May 2021 00:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210517203343.3941777-1-arnd@kernel.org> <20210517203343.3941777-2-arnd@kernel.org>
 <YKNgz7YaAq0awwNQ@infradead.org>
In-Reply-To: <YKNgz7YaAq0awwNQ@infradead.org>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 18 May 2021 09:47:27 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2rWoOx22focNgLM=+BDocbgvC7ZNY8ymogmsuaqah8tg@mail.gmail.com>
Message-ID: <CAK8P3a2rWoOx22focNgLM=+BDocbgvC7ZNY8ymogmsuaqah8tg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] kexec: simplify compat_sys_kexec_load
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@alien8.de>,
        Brian Gerst <brgerst@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, May 18, 2021 at 8:38 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> > +     if (in_compat_syscall())
> > +             return copy_user_compat_segment_list(image, nr_segments, segments);
>
> Annoying overly lone line here.

Oops, I was sure I had fixed all of these when you pointed this out before.
I probably rebased a slightly older branch that did not have the fixes.

> Otherwise:
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Thanks,

       Arnd
