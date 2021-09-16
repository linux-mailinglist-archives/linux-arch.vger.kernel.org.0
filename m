Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5806640D47F
	for <lists+linux-arch@lfdr.de>; Thu, 16 Sep 2021 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234998AbhIPIbR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 16 Sep 2021 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbhIPIbR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 16 Sep 2021 04:31:17 -0400
Received: from mail-ua1-x929.google.com (mail-ua1-x929.google.com [IPv6:2607:f8b0:4864:20::929])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F1FC061574;
        Thu, 16 Sep 2021 01:29:57 -0700 (PDT)
Received: by mail-ua1-x929.google.com with SMTP id p9so3434816uak.4;
        Thu, 16 Sep 2021 01:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S+azbYW0mdd1Qc5k88P2aUPxZmLee7YzvhtA9mKKj7w=;
        b=I3yaV7zowM0oqeq7vcp2N9ny19O1x1+95Oo2qVcp4W4Zu2F5grPn3CorENn4/iF9Nd
         bWJtuKFS7dgYiajcIhW2yR4HP1YSC8lzVpdtFlGBkcIXcs1e5nA8cCfv1sDUOOdizsQV
         2HE5u2HHYl2/jF13qdg1yi9i2p5X4ykKw47JHzMdqcx0MU+iGxaTifQhTHhmCRhApmtF
         OT/9jvK014SJvBf2xJu/lD4DWNyWWvJC6AFBmB3eXotMmC0aruhVVF3RTmtEUX72nkgC
         HEF5YjQJwuhfKGfi1/qWngWR5q70cpsrPH9ewgpeXHDt0uHcib0iSdGVoqT2ANHiDqsY
         98lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S+azbYW0mdd1Qc5k88P2aUPxZmLee7YzvhtA9mKKj7w=;
        b=KOC+h9vQSAXXBrPldgVCust6bTm2SDH/hYMjFBhyyvQONOWe1VRkehbYQtIWQw/XxS
         DzexeFMTvW1NkI1Fg+mhu7jHXUVmzB0LUehxiPizTuF6N/R5dRSiwj0d6kEVUZOhopOe
         R5xkvs3MhWYeO4n8Q92duLMHeW+8nqSGCzEXr7tswO64caXr/YyrJ5+zZuh38KZK/6//
         WSugGNRd52Z/a+v5ie6iIWcpGcJNc5Ett9a2cWIXObvpcj6B20XQY/W10eFyIv4isWZ/
         Cr1jI6JWUqWrx91CVhXFvFpMSOgjYJk4Q5w4T3ZNGZQKDMBZEOrGkcf68d+Iz+wGHLX2
         v/ZA==
X-Gm-Message-State: AOAM530Qq6BltnrGQoML8buMkw0cNyF6yk+3EVi276X73d42etCxWtNn
        wgruRZshmhoeeX2nNMXALJzZ0WV3TWjRMIa4D34=
X-Google-Smtp-Source: ABdhPJxSz5M+1mvzj25XnLasX7/B+RlT+KUDPIlBp9Iwxhxc0ak2KvJHwfb2JX8WxFVsWq2jvwdk7C7zxCHQzm0VQys=
X-Received: by 2002:ab0:25ce:: with SMTP id y14mr3080596uan.22.1631780996415;
 Thu, 16 Sep 2021 01:29:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn>
 <20210903095213.797973-3-chenhuacai@loongson.cn> <CAMU9jJqrBbD4RqL8EB=Wu0xsd69HzTcF=nfOzZQw8k0Cqy0xwQ@mail.gmail.com>
In-Reply-To: <CAMU9jJqrBbD4RqL8EB=Wu0xsd69HzTcF=nfOzZQw8k0Cqy0xwQ@mail.gmail.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 16 Sep 2021 16:29:44 +0800
Message-ID: <CAAhV-H457T0w28B5byoCo89UgTozeYPhLNzc54nKCjdPpk84tg@mail.gmail.com>
Subject: Re: [PATCH V2 02/22] Documentation/zh_CN: Add basic LoongArch documentations
To:     teng sterling <sterlingteng@gmail.com>
Cc:     Huacai Chen <chenhuacai@loongson.cn>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi, Yanteng,

On Tue, Sep 14, 2021 at 3:26 PM teng sterling <sterlingteng@gmail.com> wrot=
e:
>
> Huacai Chen <chenhuacai@loongson.cn> =E4=BA=8E2021=E5=B9=B49=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:54=E5=86=99=E9=81=93=EF=BC=9A
> >
> > Add some basic documentations (zh_CN version) for LoongArch. LoongArch
> > is a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch
> > includes a reduced 32-bit version (LA32R), a standard 32-bit version
> > (LA32S) and a 64-bit version (LA64).
> >
> > Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
>
> BTW=EF=BC=9A
> Alex's Reviewed-by tag  is missing.  :)
> https://lore.kernel.org/linux-doc/31263309-cd53-6627-b647-4ffc86b4d405@gm=
ail.com/
Thanks for reminding me.

Huacai
>
> Thanks,
>
> Yanteng
