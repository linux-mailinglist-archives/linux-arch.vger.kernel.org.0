Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7BD54C2D7
	for <lists+linux-arch@lfdr.de>; Wed, 15 Jun 2022 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241752AbiFOHq4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jun 2022 03:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237420AbiFOHqz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 15 Jun 2022 03:46:55 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A25F40A10
        for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2022 00:46:53 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31336535373so52931307b3.2
        for <linux-arch@vger.kernel.org>; Wed, 15 Jun 2022 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6TunYOqloBF4qLChlgaS7iv3LW3vD06QMv7vYl8gqBE=;
        b=i2CcqUtrsIDkjaoSSAE5LJhiUeUlJuVADv1ngNNW36lXa09SoQcpveMkDEKuHpN1nK
         OSTwc5GQA1cqqaDU8xoKdGf4VNibWkBZs9lkprQc81915FZ28b+H0OiKrwIrp8m9ecHh
         OiQMFa6k9NgB2vpeqWO5iSFhzJOjrI3JaCBFzs55F40LdKMNz+QMAItb9zjeLNzsMn82
         i9IFvhjQDrz11c26V+4BzMXa+YIGzcEq276G5oduvKPOYUdPT3NvAs3AAmiF2gLaCs6C
         uNxnPmdvvksW8dsvscU7IRW0MAWz7UOtkH/7pQAMI8UW5cdoHzte4JFOFBr4G+NekyNW
         bpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6TunYOqloBF4qLChlgaS7iv3LW3vD06QMv7vYl8gqBE=;
        b=bmhGCG15wweklddFmwIcpz5horFDZbEKxGV51Vndb/oxELyd04vJwiOGjN67KJxBr3
         joYb0Brd2OQHkeG0+OaoJFM65rKd0uVMd7uCyegO6UYuhqI1uqV0xxSUf+WVT0PJ8XTD
         C3/6iw+K/Jd/TtABws+nICB+pUsmbFqTEKntKGnj8TQcfXwU7fLXHRUR/yRvGgTNhaZ/
         F+6w1xGs1WfAnfR9XJrv5fDxQ7gykkGOU+z9JtS9JihWGSMkbYiOyPYLxSBQuN8lqPto
         X/+rPSApD9alie5eoSHZ6QnWNsAunsDks2E2ib01iu35pZQOoRHO/JrlOpRmVteGJGWv
         HvcA==
X-Gm-Message-State: AJIora9sJRe+KuprVaZ+28WwJXTvyiAd29y6KFTAlkCuHcS4Us91t5In
        3k3msI61zehWUWFbHAmiMsWSUlBfwTz/joo7wKgu4w==
X-Google-Smtp-Source: AGRyM1saOw0vSmHtMDdGxukVnu8JafJ/oalySrc+hOJX6qe5P1u/hURE3aR4FUFhUD6VGWIdDVu0+xbTE+as4/0CPac=
X-Received: by 2002:a81:3a12:0:b0:314:6097:b801 with SMTP id
 h18-20020a813a12000000b003146097b801mr7498148ywa.512.1655279212429; Wed, 15
 Jun 2022 00:46:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220610113427.908751-1-alexandr.lobakin@intel.com>
 <20220610113427.908751-3-alexandr.lobakin@intel.com> <YqNMO0ioGzJ1IkoA@smile.fi.intel.com>
 <22042c14bc6a437d9c6b235fbfa32c8a@intel.com> <CANpmjNNZAeMQjzNyXLeKY4cp_m-xJBU1vs7PgT+7_sJwxtEEAg@mail.gmail.com>
 <20220613141947.1176100-1-alexandr.lobakin@intel.com> <CANpmjNM0noP8ieQztyEvijz+MG-cDxxmfwaX_QTpnyT5G33EGA@mail.gmail.com>
 <YqlITqttNYqT/xpN@yury-laptop>
In-Reply-To: <YqlITqttNYqT/xpN@yury-laptop>
From:   Marco Elver <elver@google.com>
Date:   Wed, 15 Jun 2022 09:46:15 +0200
Message-ID: <CANpmjNMd+r9Hq+vwWGoNhOg_W=x3Umo+i14TRvEMz6PhcHgXWQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] bitops: always define asm-generic non-atomic bitops
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Alexander Lobakin <alexandr.lobakin@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, 15 Jun 2022 at 04:47, Yury Norov <yury.norov@gmail.com> wrote:
>
> On Mon, Jun 13, 2022 at 04:33:17PM +0200, Marco Elver wrote:
> > On Mon, 13 Jun 2022 at 16:21, Alexander Lobakin
> > <alexandr.lobakin@intel.com> wrote:
> > >
> > > From: Marco Elver <elver@google.com>
> > > Date: Fri, 10 Jun 2022 18:32:36 +0200
> > >
> > > > On Fri, 10 Jun 2022 at 18:02, Luck, Tony <tony.luck@intel.com> wrote:
> > > > >
> > > > > > > +/**
> > > > > > > + * generic_test_bit - Determine whether a bit is set
> > > > > > > + * @nr: bit number to test
> > > > > > > + * @addr: Address to start counting from
> > > > > > > + */
> > > > > >
> > > > > > Shouldn't we add in this or in separate patch a big NOTE to explain that this
> > > > > > is actually atomic and must be kept as a such?
> > > > >
> > > > > "atomic" isn't really the right word. The volatile access makes sure that the
> > > > > compiler does the test at the point that the source code asked, and doesn't
> > > > > move it before/after other operations.
> > > >
> > > > It's listed in Documentation/atomic_bitops.txt.
> > >
> > > Oh, so my memory was actually correct that I saw it in the docs
> > > somewhere.
> > > WDYT, should I mention this here in the code (block comment) as well
> > > that it's atomic and must not lose `volatile` as Andy suggested or
> > > it's sufficient to have it in the docs (+ it's not underscored)?
> >
> > Perhaps a quick comment in the code (not kerneldoc above) will be
> > sufficient, with reference to Documentation/atomic_bitops.txt.
>
> If it may help, we can do:
>
> /*
>  * Bit testing is a naturally atomic operation because bit is
>  * a minimal quantum of information.
>  */
> #define __test_bit test_bit

That's redundant and we'll end up with a random mix of both.

What'd be more interesting is having a __test_bit without the volatile
that allows compilers to optimize things more. But I think that also
becomes mostly redundant with the optimizations that this series seeks
out to do.

The distinction is ever so subtle, and clever compilers *will* break
concurrent code in ways that are rather hard to imagine:
https://lwn.net/Articles/793253/
