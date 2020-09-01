Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDB4259ECD
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 20:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbgIASxL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 14:53:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731240AbgIASxD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 1 Sep 2020 14:53:03 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E489C061247
        for <linux-arch@vger.kernel.org>; Tue,  1 Sep 2020 11:53:02 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id w7so1343138pfi.4
        for <linux-arch@vger.kernel.org>; Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=iu/mivdeQ6AWpfUigREEipYqDA+JBPragzl35o9Nu9ycwxuP1pT/n/GUj28IBjGlJy
         tASUZD6UQpFduus8RxIUHnWDo/ii2QxBTb8+/rddFmc7Q2BvQtdvriL4oOcAbvX3fTik
         a3CX0t1k/eCXUbO98m4G5hAHF2rr9hmEGAwHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DW1zJLlrp+b/X5DsaUJywWHpm9f8YdypCEJotWWzal8=;
        b=E1JTHOL1n+Sn5ebUP81L9D2zmvz6A/UzDKoCZj59TtZRV8C4+LcT4LlAOvkkVZu9y2
         WDoQVqi/Gi0lE9IA1Zkd5FxnEw3vKM4+PQZ5PjrKJNzAASSpDzdMWbrbpUjK3bY4e1DC
         xuqtJ1+Rsh1gaXAq4YR+6FhpJZSyM07inWwBpq1u78vxY7pcX2EHgU4twV8mAUlTC63Z
         HE2WuJqA0uqco5pGCFXhzxPfpTjZFcwroHjeMP7YM6K7NutLyXbG+X/sYKLHZ7ooF5hb
         bge3x6SpaY70tDOQav/EkT45tv5J7HY7tRUPy5yAz4YGFFrcHF/M1UTcxpc0eqRinyro
         zG7A==
X-Gm-Message-State: AOAM530q8JzLjdEQyaF7aaQ51H6pRuJlnrA0H3n5EjNDYHrmaut9LZ4j
        EHXtjAdp/UwVbiVTx32nBbF23A==
X-Google-Smtp-Source: ABdhPJw/YsKunmr1Z0dpXo1/zK3rMUMV+IlY1oP54bh4p+BaEO8LJP6shIZse5erSoELJy0YDj4+Gg==
X-Received: by 2002:a65:4187:: with SMTP id a7mr2642045pgq.102.1598986382061;
        Tue, 01 Sep 2020 11:53:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m19sm2192249pjq.18.2020.09.01.11.53.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 11:53:01 -0700 (PDT)
Date:   Tue, 1 Sep 2020 11:52:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH 05/10] lkdtm: disable set_fs-based tests for
 !CONFIG_SET_FS
Message-ID: <202009011152.335EE467@keescook>
References: <20200827150030.282762-1-hch@lst.de>
 <20200827150030.282762-6-hch@lst.de>
 <CAHk-=wipbWD66sU7etETXwDW5NRsU2vnbDpXXQ5i94hiTcawyw@mail.gmail.com>
 <20200829092406.GB8833@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829092406.GB8833@lst.de>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 29, 2020 at 11:24:06AM +0200, Christoph Hellwig wrote:
> On Thu, Aug 27, 2020 at 11:06:28AM -0700, Linus Torvalds wrote:
> > On Thu, Aug 27, 2020 at 8:00 AM Christoph Hellwig <hch@lst.de> wrote:
> > >
> > > Once we can't manipulate the address limit, we also can't test what
> > > happens when the manipulation is abused.
> > 
> > Just remove these tests entirely.
> > 
> > Once set_fs() doesn't exist on x86, the tests no longer make any sense
> > what-so-ever, because test coverage will be basically zero.
> > 
> > So don't make the code uglier just to maintain a fiction that
> > something is tested when it isn't really.
> 
> Sure fine with me unless Kees screams.

If we don't have set_fs, we don't need the tests. :)

-- 
Kees Cook
