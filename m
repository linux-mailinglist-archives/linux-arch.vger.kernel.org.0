Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D63940A758
	for <lists+linux-arch@lfdr.de>; Tue, 14 Sep 2021 09:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240218AbhINH2J (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 14 Sep 2021 03:28:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239257AbhINH2J (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 14 Sep 2021 03:28:09 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83601C061574;
        Tue, 14 Sep 2021 00:26:52 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id n13-20020a17090a4e0d00b0017946980d8dso1419681pjh.5;
        Tue, 14 Sep 2021 00:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hp6GUAgrHFu7b5baJ2ikcAxV/WkbZIz5NLHRCJHH//0=;
        b=ESZImyvw6EcVDRtmwwENKmlVK99GkWlIyipZteDq3OiKmImLMHq1fylxRO7GbaHkfs
         NI0FfA8XxOv0MPSVT1XdLHhld1nDVyNkYM+G6RmOcOHu5LtiY/mmtQ8cxwGXC3lGhQSb
         3A7+bDlLlwQB9bCMVKu2wQrpvRFzRwtgbwQ11pEyKUTmb1dcvcTTHuuJwHKslL7JZecK
         +3dXIC03s1KaVJpI1gGdqfqLSutcRJbFxjt3Lf5bJSW5d0e0FsFXCZktCBcPkpNg/uHl
         OTS8b4dd2nKuFN/QSPkdNBG5QZu4wLlAFAhAAYhri6n8PhrmfPKYpCIfVqUrdPsTFg1s
         ytuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hp6GUAgrHFu7b5baJ2ikcAxV/WkbZIz5NLHRCJHH//0=;
        b=WFRTQIbe7jIVEnQNusL0oRsjID2GZaZQa4S34g8fOiDt7TBXkgen00OBW8xf3VDAnH
         PXH3UOEfLibbByFv+8CGPpNQd+t1HHRFlDGU6KrbS9WWNTi4kGihmSotJl3OEs+kDymo
         9WFxotyZbh5USB3IyxNrA6uSY8fcUilR+tzeCSGuYuzspWWPdSbx+5qMJ59MoQvwfLfy
         rg9u/0hsYW9BLGoDCMOXHzS2bUAyiFpZmdJPQdUtrwBHTk/Osj/HI7JmCWEQ93D3/m8X
         gcZ7NogYT+cHTsKChSG2dyr8V/kkkRo6wZacVQOoz86ymxVGQIdbj5KI2TmFfjEljDdw
         my7g==
X-Gm-Message-State: AOAM533cdgmG3u+jbeT5qfmaEDzdlL4kaM7z1EhEnylsjkk5PWha0iMC
        OIqxHo4q6gM+/rujItAJhasuextlBsu5t/CuTtE=
X-Google-Smtp-Source: ABdhPJwDCIVl44gfdd1sKqX7nVUs+eR/MLALxF9c21ndqIA2Y/hvdtjZ2cgeOLIhKa6QUicMOSfpO29hrKScM4TqUD4=
X-Received: by 2002:a17:90a:cc6:: with SMTP id 6mr494466pjt.233.1631604412035;
 Tue, 14 Sep 2021 00:26:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210903095213.797973-1-chenhuacai@loongson.cn> <20210903095213.797973-3-chenhuacai@loongson.cn>
In-Reply-To: <20210903095213.797973-3-chenhuacai@loongson.cn>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Tue, 14 Sep 2021 15:26:42 +0800
Message-ID: <CAMU9jJqrBbD4RqL8EB=Wu0xsd69HzTcF=nfOzZQw8k0Cqy0xwQ@mail.gmail.com>
Subject: Re: [PATCH V2 02/22] Documentation/zh_CN: Add basic LoongArch documentations
To:     Huacai Chen <chenhuacai@loongson.cn>
Cc:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Yanteng Si <siyanteng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Huacai Chen <chenhuacai@loongson.cn> =E4=BA=8E2021=E5=B9=B49=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=885:54=E5=86=99=E9=81=93=EF=BC=9A
>
> Add some basic documentations (zh_CN version) for LoongArch. LoongArch
> is a new RISC ISA, which is a bit like MIPS or RISC-V. LoongArch
> includes a reduced 32-bit version (LA32R), a standard 32-bit version
> (LA32S) and a 64-bit version (LA64).
>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

BTW=EF=BC=9A
Alex's Reviewed-by tag  is missing.  :)
https://lore.kernel.org/linux-doc/31263309-cd53-6627-b647-4ffc86b4d405@gmai=
l.com/

Thanks,

Yanteng
