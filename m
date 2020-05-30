Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852BE1E8FF6
	for <lists+linux-arch@lfdr.de>; Sat, 30 May 2020 11:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbgE3JUy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 30 May 2020 05:20:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725889AbgE3JUy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 30 May 2020 05:20:54 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E189DC03E969;
        Sat, 30 May 2020 02:20:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id q9so2541833pjm.2;
        Sat, 30 May 2020 02:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bs9UYgoSrJr54RlOKcX9RuR9hr2tsGVOxFS0YjFci+U=;
        b=nkIiznnXDeCF1KvcW4aLGDkQV37ZDQTnvgj6Qctif8HyGgR6N1vtKTNWJRiJz33Fli
         z7zKy0SlwnZAf4/aprdq4ZD5HFInck80N6muDG7Yf12KOeKBVrsSJ9ZRsT1tUn8sVw0k
         ORNiFHJC/HZSnb1DLKygVeQmzLHWEA6W/+dPMvjr8iZRxxQn4u2mqU3EGhsDmJil2uMf
         BKm2TRispGb6nEg6+Vono/c6cPPuPtJafduR7v1LChFCjV0Ai3h0ZQ0J7yv3V8q1CdWM
         1/olHrxGHbHL20M1KOu6rZZjbF36ivkw95LkOvOz4Qg47v15sb7g3Hyse3x5bBCXv/AK
         KFDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bs9UYgoSrJr54RlOKcX9RuR9hr2tsGVOxFS0YjFci+U=;
        b=f50W1nU5sSSVlkmK3J4/wmb+i18rvbbE8CTFLyX1Fo/fGu7YXhmRfsRPccpH6sAfmN
         NJf+t7PfOjWk5o1t+7Jt3yjZGtXIGDioqwweQRRQYNyKki+BhmjJ9MG1l9niTXTy8PlH
         wKGR0lXsb7NLZGMW7ipG0hdzulf5QD2ZwbUfXgxJMis1oFkftWZXCphKtfcYoZeNZJfq
         LoDaFrEscjwFSEDVGDdOlAmhZ2/8otuJVyC41C+pnq6CJB3M1WO1qGi980EpYgMUFSP3
         ayi/rNMuEPFLvfrcadaynOUQcC/NQGi2dkcN+Q4p99TMiySkBPkVOueQM/NGMpTBAGxP
         Lv1A==
X-Gm-Message-State: AOAM530s4eYwGUlYCWh+f8TVO4Lblw3d44uVACDIoj5JeKhF9n9sdYPa
        Qvyl45KQJxk2H7/No53O8j5nsy3KAvl4zcSJrac=
X-Google-Smtp-Source: ABdhPJxZRMR0P9gBuQGFn/vs24p5Ultrlgik5g66vpVEr97ZIWJeBAsecw1LAkfejTfoWC01Obcq6d84xjViYsSKvlc=
X-Received: by 2002:a17:90b:3651:: with SMTP id nh17mr13762769pjb.228.1590830453188;
 Sat, 30 May 2020 02:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <17cb2b080b9c4c36cf84436bc5690739590acc53.1590017578.git.syednwaris@gmail.com>
 <202005242236.NtfLt1Ae%lkp@intel.com> <CACG_h5oOsThkSfdN_adWHxHfAWfg=W72o5RM6JwHGVT=Zq9MiQ@mail.gmail.com>
 <20200529183824.GW1634618@smile.fi.intel.com> <CACG_h5pcd-3NWgE29enXAX8=zS-RWQZrh56wKaFbm8fLoCRiiw@mail.gmail.com>
 <CAHp75Vdv4V5PLQxM1+ypHacso6rrR6CiXTX43M=6UuZ6xbYY7g@mail.gmail.com>
 <CACG_h5qGEsyRBHj+O5nmwsHpi3rkVQd1hVMDnnauAmqqTa_pbg@mail.gmail.com>
 <CAHp75VdPcNOuV_JO4y3vSDmy7we3kiZL2kZQgFQYmwqb6x7NEQ@mail.gmail.com> <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
In-Reply-To: <CACG_h5pDHCp_b=UJ7QZCEDqmJgUdPSaNLR+0sR1Bgc4eCbqEKw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 12:20:36 +0300
Message-ID: <CAHp75VfBe-LMiAi=E4Cy8OasmE8NdSqevp+dsZtTEOLwF-TgmA@mail.gmail.com>
Subject: Re: [PATCH v7 1/4] bitops: Introduce the the for_each_set_clump macro
To:     Syed Nayyar Waris <syednwaris@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, May 30, 2020 at 11:45 AM Syed Nayyar Waris <syednwaris@gmail.com> wrote:
> On Sat, May 30, 2020 at 3:49 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

...

> I am still investigating more on this. Let me know if you have any suggestions.

As far as I understand the start pointers are implementations of abs()
macro followed by min()/max().
I think in the latter case it's actually something which might help here.

Sorry, right now I have no time to dive deeper.

-- 
With Best Regards,
Andy Shevchenko
