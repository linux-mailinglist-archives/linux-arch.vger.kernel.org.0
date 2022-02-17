Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8395D4BA973
	for <lists+linux-arch@lfdr.de>; Thu, 17 Feb 2022 20:15:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245078AbiBQTPk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 17 Feb 2022 14:15:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245024AbiBQTPj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 17 Feb 2022 14:15:39 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3B890265
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 11:15:24 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id lw4so9517540ejb.12
        for <linux-arch@vger.kernel.org>; Thu, 17 Feb 2022 11:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+RZ8CAgnGa1bk5gBxds4oezzFjZLQMV+wOvrmesI1Hw=;
        b=aC4vKGs+W+TwIvfSuol31sXb0DdwmBd+7ynpizLCKhXxCJFdEAZpxJvcWGa/FztIyE
         kaM//DxAJXCDh5aNx4GSOgCqArnp/pPXpeZOwL6NCOz09LePB9aHf9rLmhVNdEQhmOfG
         zcHXwBp2FYlRXI6tXnhZ/KCBgXws1BhNZED9tFrHvUNz3V476fnXQSLMeM+Shpqaev6m
         W07DvhrokY4sorGqrqwhi0S/cnzs7UTqO0cIGR6WWEAN8VmZadQ9VO/+zsTblOwHPeWg
         SsUN3Cw66rH7ga20AFYG5KTR6BdWsnByVkv9VANJJ9bhC1jZcqQ2NhN41BgDZLcdhMyk
         TY3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+RZ8CAgnGa1bk5gBxds4oezzFjZLQMV+wOvrmesI1Hw=;
        b=oZ0Yj+wgYatXfeNfJtHVzL4FykFCdccNlmfI/uFgC4MwkCVTXp9QWq99Y0dMuDNkT9
         MW4RNrS6QKh0CiNCCeGmei/NCo4QzZrO1Q3H2qUOn4LO80mVi3pqmOuLjZpP69hHhOHG
         6M18+pxImnGUqip0USWgsBLCh0Fbl6gxYBMkopgrE3jSCjJDs5KYSRdVz5er8Vh43XbJ
         RAKExeuCAewkTHh2pcMXICxM6vpI4C/kQuhB9cPmiwZI/OJGxM1gjzeeelDcbUuFZTt0
         n482x3zGYlIWV+KxUtTlQvzLPyvQDyS9e2f0QgRzjEjFTXF0xMH0AKNvSFXD4zF3pOyC
         lHng==
X-Gm-Message-State: AOAM533QWpDN4cSn8zqyLx+jaTXuMni9OhjPNVcP+3bHxvRlWx93E3Ch
        ssvBt3hDr5AUVRTYteTG+9sR6U55bxNGFP5F4x6jhg==
X-Google-Smtp-Source: ABdhPJw48Oadf8QR2zY/o5TdRU0UiMjXS1n08+Rvo/jef0cepMooOXBMnDr3m4SH0a9wsDyMLo89s3cuvktj12QRONA=
X-Received: by 2002:a17:906:4b52:b0:6cd:3863:b35e with SMTP id
 j18-20020a1709064b5200b006cd3863b35emr3488094ejv.415.1645125322737; Thu, 17
 Feb 2022 11:15:22 -0800 (PST)
MIME-Version: 1.0
References: <20220216131332.1489939-1-arnd@kernel.org> <20220216131332.1489939-14-arnd@kernel.org>
In-Reply-To: <20220216131332.1489939-14-arnd@kernel.org>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 17 Feb 2022 11:15:11 -0800
Message-ID: <CALCETrVOvYPN4_6hS8wpm2v9bGZupZ5x4=vZAseG57OUgvLGfw@mail.gmail.com>
Subject: Re: [PATCH v2 13/18] uaccess: generalize access_ok()
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Feb 16, 2022 at 5:19 AM Arnd Bergmann <arnd@kernel.org> wrote:
>
> From: Arnd Bergmann <arnd@arndb.de>
>
> There are many different ways that access_ok() is defined across
> architectures, but in the end, they all just compare against the
> user_addr_max() value or they accept anything.
>
> Provide one definition that works for most architectures, checking
> against TASK_SIZE_MAX for user processes or skipping the check inside
> of uaccess_kernel() sections.
>
> For architectures without CONFIG_SET_FS(), this should be the fastest
> check, as it comes down to a single comparison of a pointer against a
> compile-time constant, while the architecture specific versions tend to
> do something more complex for historic reasons or get something wrong.

This isn't actually optimal.  On x86, TASK_SIZE_MAX is a bizarre
constant that has a very specific value to work around a bug^Wdesign
error^Wfeature of Intel CPUs.  TASK_SIZE_MAX is the maximum address at
which userspace is permitted to allocate memory, but there is a huge
gap between user and kernel addresses, and any value in the gap would
be adequate for the comparison.  If we wanted to optimize this, simply
checking the high bit (which x86 can do without any immediate
constants at all) would be sufficient and, for an access known to fit
in 32 bits, one could get even fancier and completely ignore the size
of the access.  (For accesses not known to fit in 32 bits, I suspect
some creativity could still come up with a construction that's
substantially faster than the one in your patch.)

So there's plenty of room for optimization here.

(This is not in any respect a NAK -- it's just an observation that
this could be even better.)
