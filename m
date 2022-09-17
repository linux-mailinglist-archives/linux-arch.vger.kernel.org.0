Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A628C5BB7E7
	for <lists+linux-arch@lfdr.de>; Sat, 17 Sep 2022 12:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiIQKqk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 17 Sep 2022 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIQKqj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 17 Sep 2022 06:46:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432323BC48;
        Sat, 17 Sep 2022 03:46:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2D8F613EA;
        Sat, 17 Sep 2022 10:46:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 438E6C433B5;
        Sat, 17 Sep 2022 10:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663411598;
        bh=Mk9u72C3NZotIzny4010l2UK4Jk0C0zgSamSFp0eYLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ovU/AECAhGCtUPHtyXf+cmG7XLMCzz1w34ApEph+MfD/hCEi/3BpaeuHZSav5gXKa
         Slbh4uIjXsKGXmzv3MkxIiIo0FrrwtS0ADB5NRjWQZvx7E3W3awO/8rOLELKY/SqBx
         mm0tzLYgY6QEGOl2WazmhbHW4LS/n55UyaaA4dZEzbJX7MgyEoQWTWddE6AbKaAd9E
         fZy5d1aNSYIxNN/JAhYM9sBXDqNNIc1uLW7Jd/kCWHBqDTvwFgb3y6ZrKJN65FpDVG
         e0Y9cBKdGop2XTUsJlQHXCAlpvdLeR0wJcm4zSypfgDre145IERsJxRkTKPlZkvs7e
         Zy0JWdRhAW1Sg==
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-1278624b7c4so55623924fac.5;
        Sat, 17 Sep 2022 03:46:38 -0700 (PDT)
X-Gm-Message-State: ACgBeo3as5QJba7/pcYV2FdurLFEuJolMlIhxx6xr0Rof8dPcWxYAc2i
        ZGPztfx/4afkCyoeQgIlGRaDlw+L3ZyDEofUSGE=
X-Google-Smtp-Source: AA6agR6AXCrq3aWOoC8Bi8am/l0Ye9haGWBI6uFBZEnP+yhZkWRjM0dJRVT8vekDCLKDIhxkiAeAFyP9pJsD5YP+nOU=
X-Received: by 2002:a05:6870:a78e:b0:12b:542b:e5b2 with SMTP id
 x14-20020a056870a78e00b0012b542be5b2mr10574980oao.112.1663411597397; Sat, 17
 Sep 2022 03:46:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220916103817.9490-1-guoren@kernel.org> <20220916103817.9490-2-guoren@kernel.org>
 <CABgGipWdm+-pOrj-ROR8fsVO7JEr4m64z7+zNW1_NszW74e5SA@mail.gmail.com>
In-Reply-To: <CABgGipWdm+-pOrj-ROR8fsVO7JEr4m64z7+zNW1_NszW74e5SA@mail.gmail.com>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 17 Sep 2022 18:46:24 +0800
X-Gmail-Original-Message-ID: <CAJF2gTT-TOdoGuFdbR8Xwmfur-LNOCUq_sThr9ZpJeMKxudH1A@mail.gmail.com>
Message-ID: <CAJF2gTT-TOdoGuFdbR8Xwmfur-LNOCUq_sThr9ZpJeMKxudH1A@mail.gmail.com>
Subject: Re: [PATCH 1/3] riscv: ftrace: Fixup panic by disabling preemption
To:     Andy Chiu <andy.chiu@sifive.com>
Cc:     arnd@arndb.de, palmer@rivosinc.com, rostedt@goodmis.org,
        greentime.hu@sifive.com, zong.li@sifive.com, jrtc27@jrtc27.com,
        mingo@redhat.com, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Thanks! I would add your Signed-off-by: Andy Chiu
<andy.chiu@sifive.com> as the first author, next.

On Sat, Sep 17, 2022 at 9:32 AM Andy Chiu <andy.chiu@sifive.com> wrote:
>
> Yes, by disabling preemption and ensuring all sub-functions called by
> the busy waiting loop of stop_machine, which happens to be true on
> non-preemptive kernels, solve the problem from the original
> implementation.
>
> Andy Chiu <andy.chiu@sifive.com>



-- 
Best Regards
 Guo Ren
