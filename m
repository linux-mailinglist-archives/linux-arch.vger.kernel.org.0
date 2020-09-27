Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E1F27A01C
	for <lists+linux-arch@lfdr.de>; Sun, 27 Sep 2020 11:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgI0JZi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 27 Sep 2020 05:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgI0JZi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 27 Sep 2020 05:25:38 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAC0C0613CE
        for <linux-arch@vger.kernel.org>; Sun, 27 Sep 2020 02:25:38 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id q8so7658088lfb.6
        for <linux-arch@vger.kernel.org>; Sun, 27 Sep 2020 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YmrerxLsDYMh/bkqTtdxYf9dKZLk+BUPlAAIqmKW+Kg=;
        b=Etk/NQgNueNG3pCn1cP9EiA81EAhV0eo3ir1H8266fAVMeDikRtqsl9O8MVaWrmQK1
         NX1+GgKlMFfd6IzlcAX85tsNL1fa9+WCXPQBnES+bZsPazw47PtGx823CsMoUaz7aw2u
         VbmGSNykeEKeVlkK0yaO/ERmFh2T0BO0reB11t7sVS0RuIQKZVeOwAFHPHMH6ikSA0eu
         aD0HAeG8M5nX7xMOFGFGdX0BU+gQRV2lKlGKpKGjT4o60Xa9IAZ6DGeKHoYK5Nya0f0d
         MhwG9nPq0m2f4QwyJVd/0+uz7BdwE7VDxvkapzLyMTfRkGaHqw4IjQybuVyiIyTegfJx
         wuXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YmrerxLsDYMh/bkqTtdxYf9dKZLk+BUPlAAIqmKW+Kg=;
        b=TauKHG0vRaXEIDun0eq6JgOR49BUXhdY+rfHNRw98Wkf69XODjzeBEFfZMobZecdry
         MxpbwmmZ1gGUzILowMOsr0bOeu7yQnXul0yYMrqtaPFtervL1NXVc1Q12eboQ1BF5BRv
         TJ2JCrDpKEVIggV6sSHpdFrnabi5Jan7/tK67kPeB1c9+dUAXeNceNzoLXrzwCkT91Xe
         bDz1c1SXNZVc2q8e7cQnCPD+0V3sIC9Or+AN3qz4nueXaVoIyy/dfTo/hR/8ugBdttIa
         d/eZp3d8PbDr7nWy6mcekv6DXY/LZfAMKHmIJ93zXlycstlOEo6xEU+g1CCSKXnpDAH0
         dhCg==
X-Gm-Message-State: AOAM531tfM6miiZP6kFtAPLJIWby2T5qFsZ4+svAcQrmAhx+8eF311mm
        3klV+qyBjstXjSOnwPsFt2YM/RWnHUncWgj3t8j+Tg==
X-Google-Smtp-Source: ABdhPJwJULgLjHe/a2sr/LvdH+5pKVGkZaiqS6R8otrTEm/iiiez/V7cPU39RQZ4WnDSRaLXAtulB/9BJtYtlSMuz1Q=
X-Received: by 2002:a19:6c2:: with SMTP id 185mr2074813lfg.441.1601198736857;
 Sun, 27 Sep 2020 02:25:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200907153701.2981205-1-arnd@arndb.de> <20200907153701.2981205-2-arnd@arndb.de>
In-Reply-To: <20200907153701.2981205-2-arnd@arndb.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 27 Sep 2020 11:25:25 +0200
Message-ID: <CACRpkdYZw11rJce-Wn_b0xfs-SQKNUQiO84UhxGK9MDfSD7M-w@mail.gmail.com>
Subject: Re: [PATCH 1/9] mm/maccess: fix unaligned copy_{from,to}_kernel_nofault
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Russell King <rmk@arm.linux.org.uk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 7, 2020 at 5:37 PM Arnd Bergmann <arnd@arndb.de> wrote:

> On machines such as ARMv5 that trap unaligned accesses, these
> two functions can be slow when each access needs to be emulated,
> or they might not work at all.
>
> Change them so that each loop is only used when both the src
> and dst pointers are naturally aligned.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That's a clever optimization idea, nice!
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
