Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A664760B646
	for <lists+linux-arch@lfdr.de>; Mon, 24 Oct 2022 20:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbiJXSxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Oct 2022 14:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232727AbiJXSwh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 24 Oct 2022 14:52:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC20224A90;
        Mon, 24 Oct 2022 10:34:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E5661500;
        Mon, 24 Oct 2022 17:17:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2964C433B5;
        Mon, 24 Oct 2022 17:17:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W4OnCup5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666631860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0joR9m5MfF36iKnJOfK3TU4JQ6XnOTGKpE1xroKpqN0=;
        b=W4OnCup5gOPU0F9sVbRAhDz1YfbDgcVtsT5zZm8fxkWFH8QlP4LKuTC6ARb/4ATDp8w/1W
        CCDuos+lBAaTbcSwhdf/q9N8iqY1xl/kWWbeSWwm/vEu50CwFDzYa1ofruMc1cxK9QzNmf
        t+vcDeOf7nOyQGTvT2VGAme4/SxiP2I=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a8144f99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 24 Oct 2022 17:17:39 +0000 (UTC)
Received: by mail-vk1-f173.google.com with SMTP id h16so2250291vkn.4;
        Mon, 24 Oct 2022 10:17:38 -0700 (PDT)
X-Gm-Message-State: ACrzQf0qLIXypCUMqGeOiOukf248s+qYN28YnkOm4IFEsYD0QnGvPn0i
        3ownY4C99S5qa4SB4MrJ07YjDagFH3QeUSOKPik=
X-Google-Smtp-Source: AMsMyM7gGYX+0RDafH1G0b5Of2Pu4zvYtbj8eQ2m/vAdjPgpIYTB6R/Y9WoDz6ojgWA81toPxKKw5ZiS4OOZZEag660=
X-Received: by 2002:a1f:ecc6:0:b0:3aa:a785:5e2f with SMTP id
 k189-20020a1fecc6000000b003aaa7855e2fmr18797456vkh.6.1666631857723; Mon, 24
 Oct 2022 10:17:37 -0700 (PDT)
MIME-Version: 1.0
References: <Y1BcpXAjR4tmV6RQ@zx2c4.com> <20221019203034.3795710-1-Jason@zx2c4.com>
 <Y1ZZyP4ZRBIbv+Kg@kili> <Y1ZbI4IzAOaNwhoD@kadam> <Y1a+cHkFt54gJv54@zx2c4.com> <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
In-Reply-To: <CAHk-=wgK3Vs+7Kor-SisRHJYzV1tXD+=D4+W1XkfHOV2KN_OGw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 24 Oct 2022 19:17:25 +0200
X-Gmail-Original-Message-ID: <CAHmME9ox7JNqOOZHEHCgaS95rsn-dVr4QOnN1mfmFEn=i9_jvw@mail.gmail.com>
Message-ID: <CAHmME9ox7JNqOOZHEHCgaS95rsn-dVr4QOnN1mfmFEn=i9_jvw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: treat char as always unsigned
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-toolchains@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kalle Valo <kvalo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Larry Finger <Larry.Finger@lwfinger.net>, mikem@ring3k.org,
        wlanfae@realtek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Linus,

On Mon, Oct 24, 2022 at 7:11 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> IOW, I don't think these are 6.1 material as some kind of obvious
> fixes, at least not without driver author acks.

Right, these are posted to the authors and maintainers to look at.
Maybe they punt them until 6.2 which would be fine too.

> On Mon, Oct 24, 2022 at 9:34 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> Some of those may need more thought. For example, that first one:
>
> > https://lore.kernel.org/all/20221024163005.536097-1-Jason@zx2c4.com
>
> looks just *strange*. As far as I can tell, no other wireless drivers
> do any sign checks at all.
>
> Now, I didn't really look around a lot, but looking at a few other
> SIOCSIWESSID users, most don't even seem to treat it as a string at
> all, but as just a byte dump (so memcpy() instead of strncpy())
>
> As far as I know, there are no actual rules for SSID character sets,
> and while using utf-8 or something else might cause interoperability
> problems, this driver seems to be just confused. If you want to check
> for "printable characters", that check is still wrong.
>
> So I don't think this is a "assume char is signed" issue. I think this
> is a "driver is confused" issue.

Yea I had a few versions of this. In one of them, I changed `char
*extra` throughout the wireless stack into `s8 *extra` and in another
`u8 *extra`, after realizing they're mostly just bags of bits. But
that seemed pretty invasive when, indeed, this staging driver is just
a little screwy.

So perhaps the right fix is to just kill that whole snippet? Kalle - opinions?

Jason
