Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D58EE668A8B
	for <lists+linux-arch@lfdr.de>; Fri, 13 Jan 2023 05:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjAMEJJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 12 Jan 2023 23:09:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjAMEJH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 12 Jan 2023 23:09:07 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012124D4B9
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:09:06 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g10so8588253qvo.6
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EXUMvVNfXG4qSkejYmhEflbNl3f1wy9uAsg7bFSwbSc=;
        b=YZomyCx9zkrAbhPakcudoYBPZQ8rkARTHLtKi53pDnaU6mgLGZa3xZIRDUHeRfmNce
         GC1P6x1PEISxajWTwyAnBGitw9C9AP8NxUWXwmpcBLQQFp+crCOndn1tsVb6xKlm4KyD
         av00SfY68vg8S2VYP+YhHBi3oHDyAFOENLTVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EXUMvVNfXG4qSkejYmhEflbNl3f1wy9uAsg7bFSwbSc=;
        b=Wb//IRBuKL5XUa5jfHhuNij07CoOF+jc+XjlbzJOAJQJ4uEwPLRcrIlPtIN5atmOsT
         Kbo99Vgy8bsr2u/X9VXC7AsGlwT3ceKENNT+mByYn6cKT+kVz2jSzR6u0ZNCAOtFgxEU
         LL1QC8Rv1xFYM5XWrRuP/kQVZwiIJpC4+RXT9CXsCWvvLt2HM5PbpHhMTSn8AxHxoK9V
         rABysP6aJDE7FH4u6uQDpl4Va4SgIBbXJLHW9Nh//64t9FJmTHuIhKbkmZ2BPHfZYgGI
         W4CxrM7p/9hCuDhFysl4+E38B31tQBxrazgaIeohO+ORpTxgY/kLAc3WSuh5xyAE44mv
         vPiQ==
X-Gm-Message-State: AFqh2kpJOcjvzUOdClDD/7DBTZNs8M6h9l4y44n3cRHlhA3atW8t1g/b
        6Egw07lhP/7RD7iKnRCSsSrJ1omp7GbQYCrKmsQ=
X-Google-Smtp-Source: AMrXdXstqsNvGEtYqomE9TarVCy/2zwDcAOBdfotUb741CYF7NUkXo498btOsXEcGRAD7vXGPTNwWw==
X-Received: by 2002:a05:6214:3812:b0:531:d6eb:394b with SMTP id ns18-20020a056214381200b00531d6eb394bmr61003568qvb.4.1673582945970;
        Thu, 12 Jan 2023 20:09:05 -0800 (PST)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id bs13-20020a05620a470d00b006b95b0a714esm11769487qkb.17.2023.01.12.20.09.04
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jan 2023 20:09:04 -0800 (PST)
Received: by mail-qv1-f44.google.com with SMTP id h10so14096623qvq.7
        for <linux-arch@vger.kernel.org>; Thu, 12 Jan 2023 20:09:04 -0800 (PST)
X-Received: by 2002:a05:6214:5e87:b0:532:2dd4:825d with SMTP id
 mm7-20020a0562145e8700b005322dd4825dmr1103173qvb.94.1673582944399; Thu, 12
 Jan 2023 20:09:04 -0800 (PST)
MIME-Version: 1.0
References: <CAGudoHHx0Nqg6DE70zAVA75eV-HXfWyhVMWZ-aSeOofkA_=WdA@mail.gmail.com>
 <CAHk-=wjthxgrLEvgZBUwd35e_mk=dCWKMUEURC6YsX5nWom8kQ@mail.gmail.com> <CAGudoHE0tzL8OAqvwpDR4Nn_g70a8qBdE_+-fmhXF-DEx_K6kg@mail.gmail.com>
In-Reply-To: <CAGudoHE0tzL8OAqvwpDR4Nn_g70a8qBdE_+-fmhXF-DEx_K6kg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 12 Jan 2023 22:08:48 -0600
X-Gmail-Original-Message-ID: <CAHk-=wgEhGotFkQwTc5YiuQAc6Y0qiAkRXHsvSepkhkKb6jXpA@mail.gmail.com>
Message-ID: <CAHk-=wgEhGotFkQwTc5YiuQAc6Y0qiAkRXHsvSepkhkKb6jXpA@mail.gmail.com>
Subject: Re: lockref scalability on x86-64 vs cpu_relax
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-fsdevel@vger.kernel.org, viro@zeniv.linux.org.uk,
        Jan Glauber <jan.glauber@gmail.com>, tony.luck@intel.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jan 12, 2023 at 7:12 PM Mateusz Guzik <mjguzik@gmail.com> wrote:
>
> I did not want to make such a change without redoing the ThunderX2
> benchmark, or at least something else arm64-y. I may be able to bench it
> tomorrow on whatever arm-y stuff can be found on Amazon's EC2, assuming
> no arm64 people show up with their results.

I don't think ThunderX2 itself is particularly interesting, but sure,
it would be good to have numbers for some modern arm64 cores.

The newer Amazon EC2 cores (Graviton 2/3) sound more relevant (or
Ampere?)  The more different architecture numbers we'd have for that
"remove cpu_relax()", the better.

                   Linus
