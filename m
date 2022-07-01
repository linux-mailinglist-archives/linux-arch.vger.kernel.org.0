Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 995FB56294F
	for <lists+linux-arch@lfdr.de>; Fri,  1 Jul 2022 04:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233550AbiGAC6R (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 30 Jun 2022 22:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232320AbiGAC6Q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 30 Jun 2022 22:58:16 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7FEDCC0;
        Thu, 30 Jun 2022 19:58:13 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 59so2711247qvb.3;
        Thu, 30 Jun 2022 19:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lOvmRX5TfFX/UtEGzQDHuFSxkP0i5beuEIqtb7CEA/w=;
        b=WelpAaI3njYPrQSfHDzi8D3Dc8rtvD01QTHIWuSTBpUCspUSZA5CiPOn1FmsBxK2d1
         n+NvrQ429oVmXtDqyobXXKenmqQR1H4B2ygsgygEyJJsgDS7yFbtnMTx/Yat7tla7IGb
         f81YC5UvSkGSiC8iaxaum9eibqhYQJgbGxT2mCiuwPfUJl9ROYkck29M4SFGJ5LzsLJP
         VMJvj4NIDqtL/H8VtZGuM3kOpVqOTkedC07tTTX3LXleA88NKqFOJjONifGSPFrF1T5M
         MZBE+oi0zJaomy+MpwcjtkMzDFGUMj1gM3gdD0ksFZaravUlIe1wlA6yFdxpI1+5Wu8A
         05kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lOvmRX5TfFX/UtEGzQDHuFSxkP0i5beuEIqtb7CEA/w=;
        b=L/Ey6K+NFvjIiDeGmydgB4/iZ8H/wCdtl3871B1Wbigq5wIZW1V0vI2xStCWbkIoCY
         JGc4GSNfKA3UCyfMtj07oq1HATb8+SQrgj+PLZNL/i5euaJxoPnM3Y/U50YhgPCX3iay
         EXS0csxzSuzTUEiSTNtLzdm4420FsAtG4lTLZZ18EXKjHB5FdsPT03GZSbjlbR3nn/ed
         xzDLf702kxnIWfOgYoJLcmAkCzZJ4ZDvBikzcjpPtTOWAplPm8CS55EEZBijMVuopEQu
         4r4Nv1LYSesihVUvja2d2LQbKhEyaKjGVVYFVVSnAX8sZPCdzr0cYLtD0o6Ou3xseCFP
         w1EA==
X-Gm-Message-State: AJIora+adoHolPnCDw3cOKZgtpsbgOK1Ylr5oy3fzhSvI2VTeo1cjU0F
        sY6Nvkae47g0K5QPYu9xacU=
X-Google-Smtp-Source: AGRyM1svRdiqfGdo6Px/LVasHA2ZAF5HGNiftP14Jt+t+yFx39TVmlT99mhU8zn9HSKzlmMDUj7R+Q==
X-Received: by 2002:a05:6214:27ed:b0:470:90a3:6b9e with SMTP id jt13-20020a05621427ed00b0047090a36b9emr14298448qvb.114.1656644292944;
        Thu, 30 Jun 2022 19:58:12 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:1dde:deb7:a57c:900d])
        by smtp.gmail.com with ESMTPSA id w4-20020a05620a424400b006af08c26774sm15988491qko.47.2022.06.30.19.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 19:58:12 -0700 (PDT)
Date:   Thu, 30 Jun 2022 19:58:11 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Alexander Lobakin <alexandr.lobakin@intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matt Turner <mattst88@gmail.com>,
        Brian Cain <bcain@quicinc.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>,
        Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, kernel test robot <lkp@intel.com>,
        linux-alpha@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/9] bitops: let optimize out non-atomic bitops on
 compile-time constants
Message-ID: <Yr5iw9Ruj+LdlB+R@yury-laptop>
References: <20220624121313.2382500-1-alexandr.lobakin@intel.com>
 <20220630165611.1551808-1-alexandr.lobakin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630165611.1551808-1-alexandr.lobakin@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Jun 30, 2022 at 06:56:11PM +0200, Alexander Lobakin wrote:
> From: Alexander Lobakin <alexandr.lobakin@intel.com>
> Date: Fri, 24 Jun 2022 14:13:04 +0200
> 
> > While I was working on converting some structure fields from a fixed
> > type to a bitmap, I started observing code size increase not only in
> > places where the code works with the converted structure fields, but
> > also where the converted vars were on the stack. That said, the
> > following code:
> 
> Hey,
> 
> Seems like everything is fine this time. I got some reports, but
> those aren't caused by any of the changes from the series.
> Maybe we can take it to -next and see how it goes?

Applied on github.com:/norov/linux.git branch bitmap-for-next

Thanks!
