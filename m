Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3574412677
	for <lists+linux-arch@lfdr.de>; Mon, 20 Sep 2021 20:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387665AbhITS6a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Sep 2021 14:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354925AbhITS41 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Sep 2021 14:56:27 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10144C0A88CD
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 10:05:03 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t10so64169625lfd.8
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 10:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=QsSxLzq+ps4dQfN/nfLkDVGEJRoUNVw2MarI+2uXV9KE0AtrzhKx+qI0WZs8h23Sn/
         CAe3GHPOAKPXLZfEibFPhZiKWJIh7VgFay4UPqOp/tI/ALdW4lwCTcJIkobR53QMS+5U
         NGuoJf50rRach+FLajqQuJW9lPW2IFgECqmXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NGaD6AlZjPBokDnZ02tpVPzh3NsPwqmIjeFWkEkRoSE=;
        b=i9012mFhTx7PFZCQYqZUSGxWfDCeYRlXo7jmDWKiIZnZwHdQGhYAK8D1HhrZVyIMLT
         MjfmigBJPpQV6ThfhbuSg2ALs+WVPI/97+IePCmd7pNUwFvL8rJWweBs5cz0sbMsdCKn
         udNLiaBo0A5BOr0FdZR1nvgkqaA6EMtibj12NI5gPY8NdgM4wG2Jd34LY+XKryt0v+6I
         0/2oY1j5TCYZrPiUSUTj0xl/XOWHQ3ev68qeZAD1LgXYg8yO/NK7k611AqzBKT7HCgE2
         XeNsctrNzKmltVGKpqM8jzLSPUWu/22mMXBVf+N8DBZCt5DjLa9ppBvHKliY2592bTqK
         /u7A==
X-Gm-Message-State: AOAM532mQA/fWaB9ZDRtbVI4rSTUahndgdBCF03CHb/cNPr2eZqIKiz7
        HDRrRkkjTPifOjOn1uTRU2NyrVKsyxxGDYKs
X-Google-Smtp-Source: ABdhPJw4aKBIPEii3kvtNvAp7c7D+hshxQzwbK27p9p/LDq2ITLUBESm05Ub9KgaZBJ3OwplKonelA==
X-Received: by 2002:a05:6512:2354:: with SMTP id p20mr1155543lfu.214.1632157499822;
        Mon, 20 Sep 2021 10:04:59 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id t30sm1305014lfg.289.2021.09.20.10.04.58
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Sep 2021 10:04:59 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id b20so11808070lfv.3
        for <linux-arch@vger.kernel.org>; Mon, 20 Sep 2021 10:04:58 -0700 (PDT)
X-Received: by 2002:a05:6512:b8f:: with SMTP id b15mr7635650lfv.655.1632157498590;
 Mon, 20 Sep 2021 10:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wirexiZR+VO=H3xemGKOMkh8OasmXaKXTKUmAKYCzi8AQ@mail.gmail.com>
 <20210920134424.GA346531@roeck-us.net> <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
In-Reply-To: <CAHk-=wgheheFx9myQyy5osh79BAazvmvYURAtub2gQtMvLrhqQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Sep 2021 10:04:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Message-ID: <CAHk-=wgnSFePkt9_TxgdgFvMz6ZyofLFQLuV_Tc7MQVXYdgSng@mail.gmail.com>
Subject: Re: Linux 5.15-rc2
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-sparc <sparclinux@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Sep 20, 2021 at 9:18 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, this email ended up being a long explanation of what the code
> _should_ do, in the hope that some enterprising kernel developer
> decides "Oh, this sounds like an easy thing to fix". But you do need
> to be able to test the end result at least a tiny bit.

In the meantime, the build fix is trivial: make that broken sparc
pci_iounmap() definition depend on CONFIG_PCI being set.

But let me build a few more sparc configs (and this time do it
properly for both 32-bit and 64-bit) before I actually commit it and
push it out.

              Linus
