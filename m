Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E44C5A981E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Sep 2022 15:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233346AbiIANK0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 1 Sep 2022 09:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233589AbiIANKD (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 1 Sep 2022 09:10:03 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073C0186FC
        for <linux-arch@vger.kernel.org>; Thu,  1 Sep 2022 06:04:19 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qh18so14255763ejb.7
        for <linux-arch@vger.kernel.org>; Thu, 01 Sep 2022 06:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=BS9JTLVXB8ZepzyWSOg0gq+nuA5a9vk/6VAXIw6crs0=;
        b=d8n2nKng3koAk6m9o88p/MaKCoWDhVy/bPNSwa4LpSJ0916XtqIvR0G9d+86aUpKuj
         /Vg8MXCBOvkQl1SxMeOKWxxdOg9UxtJkYvlpiKPvrM6X41USnX9SX1SWPh5I9eIutmjE
         IBJcXX8tl6jtwa5MZHxxl0ocIbZvs0SMu4pKCO/tgUM0RttKVAMBlBZCyQ+bRCMHWQhc
         ElgSCv0qco1iAsEdRJbO4jgbTUbxT+rkqlSXuv+9FMj9fB0eTby2LSnAt17l5MZqRaL4
         SuTsj+LRLsY60zXz9inPAfxrN3HDEEb/H/lVYNsxNb2U0+MpepV/ZpaTpw31X45ZAy/1
         LvYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=BS9JTLVXB8ZepzyWSOg0gq+nuA5a9vk/6VAXIw6crs0=;
        b=I0EE5eWv0SJiih3IOf7KQ7xXEeei1Du24gsUjRMVNMazEtPRfZ1cEnxzy+wSwGnQI8
         AHICXPKz9dnccqIHhmf4MEPenys7cwlJBBcaCw74L5qgWR3iI4dE93QolgjHjEzwWvGk
         BhI3We1OwzXDl8lKANr9VhZf5D4PKZXW3MXsS3t9O2kempaD9jwNObq+sT9ZByT+34pQ
         OnBlhPVPQIDpIWN89g3/MnhtLh8abz8/Fz2wwwiRfLoZ4tUKj4isU3T70NzUGuECpW8S
         H/c2Jbfk81jf7dbc4ov4+wq1ZsEzOBumCc8bN3KyL42NwYPQOeIZsM8lVLaD27MJnHsX
         ueAQ==
X-Gm-Message-State: ACgBeo0qjuC5YJDonODNOh3EuPAoihMly5r2EtWPZU0pGxGv1xquPpaw
        zxPYpwpyw3QGxOsu/RGAkAZ1fhJVYhyEAwvkq28VxA==
X-Google-Smtp-Source: AA6agR4Qpkz2hk59+fKeQNK9ToQu9Jwdes2NTsf+CfyPCjPsPIdgzq4Wp9TpAAbZE9muO5LD8P28VYxo5FX0PCdNAsA=
X-Received: by 2002:a17:906:9b86:b0:73d:72cf:72af with SMTP id
 dd6-20020a1709069b8600b0073d72cf72afmr23871472ejc.440.1662037429452; Thu, 01
 Sep 2022 06:03:49 -0700 (PDT)
MIME-Version: 1.0
References: <20220831214447.273178-1-linus.walleij@linaro.org>
 <5b1f418e-3705-4093-9a13-3fe7793ed520@www.fastmail.com> <CACRpkdapZCrhQjFfGM_mU2+kUTBO6tpDUAY5k7sDRZUNWAKnVg@mail.gmail.com>
 <911742ca-d653-421d-8c55-d0cc5d2be777@www.fastmail.com>
In-Reply-To: <911742ca-d653-421d-8c55-d0cc5d2be777@www.fastmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 15:03:37 +0200
Message-ID: <CACRpkdZn6y=40DH5ewkeS66L0sc9saq2fnMKaVhdYPrNnG6hOQ@mail.gmail.com>
Subject: Re: [PATCH] parisc: Use the generic IO helpers
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 1, 2022 at 2:20 PM Arnd Bergmann <arnd@arndb.de> wrote:

> According to the comment, the parisc version was originally
> meant to handle additional special cases besides MMIO or
> PIO, but this seems to have never happened. The current
> version looks basically equivalent to the generic version
> to me, except for a small bug I found (see patch below).

I saw this too, but didn't know what to do with it.

I'll include your patch as two of us clearly think it looks
like a bug.

The other pecularity is that iomap and the parisc iommu
unconditionally defines and uses 64bit MMIO accessors,
so I had to quirk <asm-generic/io.h> with a special
"give me 64bit IO even though I'm 32bit" mechanism,
we can discuss this after I posted v2.

> Changing parisc to GENERIC_IOMAP is clearly something we
> can do, but I agree that it would be out of scope for
> your series.

That's for later :)

Yours,
Linus Walleij
