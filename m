Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1273D5AEF48
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 17:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbiIFPtP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Sep 2022 11:49:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbiIFPsq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 6 Sep 2022 11:48:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE2E15A1A;
        Tue,  6 Sep 2022 07:59:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id q15so11617591pfn.11;
        Tue, 06 Sep 2022 07:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=1TNLh/TqVl+pYztTYCnt8rmiWXduntS2OeyHRPQbFpo=;
        b=j9oFDST+2KjJ0+9CMMgqbDqqGqeDRg0f7I1KYoxAiP05lV99ZZfNC2D/VZdGPkiFjO
         T/gqAst9HPwT+5EI8mKqnjXW/nC5QTHiVQgWFoIfJ2LFB8XH+9d+UwcRK6MI5r/eRBWJ
         oEU8q6nG4zfAKdNewGXBvhOKK90csPunH0MDeSo1k90ZeyOR6E5y6Ji3EcD7vN6jNvNm
         I1hFYXq8+sNPcBq5FMHJlgfhT+BUgJrw6zzWSjOmO+poB1h4gBaIvbt7zDXuz0PzLLb1
         tHcjeRpQCoMUGsXxNbDq7ZK5xXlgIQ/i/lBaHX759dbcQ7FdKqx7Tpn/B55ly+D52Wk9
         i7uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=1TNLh/TqVl+pYztTYCnt8rmiWXduntS2OeyHRPQbFpo=;
        b=yiC605BPEdS/hluyG/7RdInl5UPxA9pC/FRcMrkPciCxlU44SQkFkh8eZCovi/2D3f
         C9MUWAKbcGZ3bxLa/a5iIRJHvPUUwo8auDbiGHTatu3cWTEeKR4o8qMgtklEcWilwE1b
         OvHwSYmM0uJjaSzdR0N3Vng0HyvZ/nuOJp9xHzsKEDCMSDnDS3XmpxjFCPep+jCsv09P
         bqEAkXZrUsS0J+4QUf8vPDCdMOPdcW33fUVxCr07eqTJhQJWLThgBYnW/BdVeXD3IYr7
         FZyDroTUX/7WCbUKyRrXd6s50sIXILYb3JKodjdYZ9+2yRXFhOcNhCl5tc+NzXKWrtMc
         lANg==
X-Gm-Message-State: ACgBeo0finFqxPb1qjyrd+7raXhN5KG6IPrEaj/OmWk723YGsnlHzCCq
        ihuXsaTM/GJbBs3cBR6AhAqaY2vBZmDrNFQMi+Q=
X-Google-Smtp-Source: AA6agR4WUohF8rqLTyCUYBzt0qVrAGVXcksSxQBSaAJ03v/MQMuCjjvNPRIBSmcykwNUJPEEDJUd61q4dGibEyxUF0k=
X-Received: by 2002:a05:6a00:114c:b0:528:2c7a:6302 with SMTP id
 b12-20020a056a00114c00b005282c7a6302mr55731099pfm.37.1662476393734; Tue, 06
 Sep 2022 07:59:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220818092059.103884-1-linus.walleij@linaro.org>
 <CAK8P3a1x52F8Ya3ShQ+v6x_jANfUsEq0E55u+pOBNaYniRO7cA@mail.gmail.com>
 <CACRpkdZemHScp9WW-7LaGtcXuvT2qzs_7nXS60icSWtPkEwMHg@mail.gmail.com> <8d931abd-ce7d-45da-b47c-239d4c7cd72f@www.fastmail.com>
In-Reply-To: <8d931abd-ce7d-45da-b47c-239d4c7cd72f@www.fastmail.com>
From:   Matt Turner <mattst88@gmail.com>
Date:   Tue, 6 Sep 2022 10:59:42 -0400
Message-ID: <CAEdQ38FXieAyHHmP01czaMVC_wX8pzR=i0_-rhKMuzziJcFHNA@mail.gmail.com>
Subject: Re: [PATCH] alpha: Use generic <asm-generic/io.h>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        linux-alpha@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 5, 2022 at 4:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 5, 2022, at 9:30 PM, Linus Walleij wrote:
> > On Thu, Aug 18, 2022 at 12:28 PM Arnd Bergmann <arnd@arndb.de> wrote:
> >> On Thu, Aug 18, 2022 at 11:20 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> >
> >> > I'd like this applied to the alpha tree if there is such a
> >> > thing otherwise maybe Arnd can apply it to the arch generic
> >> > tree?
> >>
> >> Sure, I can do that.
> >
> > Could you apply this to the arch tree? I see no signs of life from
> > the alpha maintainers.
>
> Sure, I can do that. I also realized that we can actually fold
> all of asm-generic/io.h into linux/io.h directly once this is
> complete for all architectures. Probably better to leave that for
> 6.1 though.
>
> I wonder if I should also add send a patch to mark Alpha as
> 'Orphaned' like we did for arch/ia64 a while ago.
> It's already marked as 'Odd fixes', but the last pull request
> from Matt was over a year ago now.

Sorry, I've just completed a cross-country move and have generally
been very busy with real life for the last year or so.

My alphas are being unpacked now, so I'll try to catch up on things.
Feel free to take any alpha patches through the arch tree. I feel
confident that you have more of a clue about what's going on in kernel
land than I do.

Thanks,
Matt
