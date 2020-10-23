Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE21A297046
	for <lists+linux-arch@lfdr.de>; Fri, 23 Oct 2020 15:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373212AbgJWNUr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 23 Oct 2020 09:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S372261AbgJWNUr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 23 Oct 2020 09:20:47 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FC3C0613CE;
        Fri, 23 Oct 2020 06:20:46 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id w17so1314789ilg.8;
        Fri, 23 Oct 2020 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xeo0p2qdmsop/TDGgLs89AOUyadmvF116Tgqv/kxuwY=;
        b=rA0a3idKXxsidmySKf+Rkby9uR/42z5EzIai/zfL40nh2Hp1baOLzQo7gW2oXp6ePA
         DnLct+f+IP/d/4cM15oO56yQrZTPSPN5VjRHlrpu8U5v8hi1rlnZklmudQayA4HiSwAi
         CAyx+A3fh7jqtpKrhJQDPd2G2qaaqjGmrxquAQ4+6rJddN6QenB2CeSmSYEajjHr3zAH
         GP6qBdC5ilUJC2ygVbDU3U2gEe3WkczEO6+YQew/W8uS8n2sOvq39AjJbmXeWgMwmMR6
         zP6eoYyCFf0QHzjnJLyIBfZo1ZDSox3835sl+fCVEXYWSIqUo04zFxpEcNok2fQZ2aiR
         E8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xeo0p2qdmsop/TDGgLs89AOUyadmvF116Tgqv/kxuwY=;
        b=ZfNdl4dVpjxX96OQnSdqQEFh5djw6ZZCiNDaz2LMyxXiFHjBpi8yz7zkD//qoDKlqy
         lHZLzH5OraNM2z5qZfMDWHW7QdMqZNcxCnuW/9nH2JK9WYir6haHlyJC2nUgzRgTktpl
         k5vaQRkeZZllSj765KkiCDfSB63USF/UWqJltfC1asPmfxvLAujzpfrJVoCh+HTf6+DL
         ZgpQMgOUlD11DOh5AklqouTJ898pyq7d7nUWIBsMqTCxAbNGuDyYDSwTyIBe4Ofn2DbG
         hgRlRtTh+puyPGD1m5MEUXXzizVVglu6eLPy+5eZ4b6lZCPzXWocI61BAlJIJjekkwnU
         6AlQ==
X-Gm-Message-State: AOAM530vZmmTRJmLv0HZ8Fzt7dAC+7JRgQ7AaDEcB+Q6hHiYftsmjJgM
        nTwIWJ68I4yjO/HqLZfzoa8YRvfRWh4lrSg8ydA=
X-Google-Smtp-Source: ABdhPJwQCcuMZaG2NyGoy2d/3qKC/ZI6eB7q5tOvNNnzAZjOE5Rr6ZPQU1MCYZyj0UEzOHE6kIz0bBqP6t6tmDeCl58=
X-Received: by 2002:a92:c213:: with SMTP id j19mr1656992ilo.205.1603459246105;
 Fri, 23 Oct 2020 06:20:46 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1601974764.git.syednwaris@gmail.com> <CACRpkdZcfR8Vyavpi4xM1zJab6SgapGBYqK9GR2mp-xh=LuVsw@mail.gmail.com>
In-Reply-To: <CACRpkdZcfR8Vyavpi4xM1zJab6SgapGBYqK9GR2mp-xh=LuVsw@mail.gmail.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Fri, 23 Oct 2020 18:50:34 +0530
Message-ID: <CACG_h5rHvWEUZSfHvF198_i+xjc_gN5ioXYniZqij0wx=3wnqQ@mail.gmail.com>
Subject: Re: [PATCH v11 0/4] Introduce the for_each_set_clump macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Robert Richter <rrichter@marvell.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        "(Exiting) Amit Kucheria" <amit.kucheria@verdurent.com>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux PM list <linux-pm@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Oct 7, 2020 at 2:09 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Oct 6, 2020 at 11:20 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
>
> > Since this patchset primarily affects GPIO drivers, would you like
> > to pick it up through your GPIO tree?
>
> Definitely will, once we are finished!
>
> I see Andy still has comments and we need more iterations.
> That is fine, because we are not in any hurry. Just keep posting
> it!
>
> Let's merge this for v5.11 when we are finished with it.
>
> Yours,
> Linus Walleij

Hi Linus,

Just thought of giving an update. The V-12 revision of the patchset
has been submitted (19 Oct).

Let me know if you face any questions regarding the V-12 patchset. Thanks !

Regards
Syed Nayyar Waris
