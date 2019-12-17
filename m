Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4CF12345B
	for <lists+linux-arch@lfdr.de>; Tue, 17 Dec 2019 19:06:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfLQSGP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 17 Dec 2019 13:06:15 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37523 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfLQSGO (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 17 Dec 2019 13:06:14 -0500
Received: by mail-lf1-f68.google.com with SMTP id b15so7629625lfc.4
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
        b=RfiBPyWeZAzQgIBtq60kIzhloZUPXwDzUfA7/StNCE0CG0dtDUhp2Ewy/xVxfm6KGP
         Df5Tk+VbkeJUcH9BCjIfG5UOSKgGvWdi5Az1/Qo1yD1OhxmYNXkDchH0t3cs5GTsnGGc
         mY0wPUPFyCbvMDhlKo0Sh/qqCC9ol32klGEME=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2FmdBG00eyF0mCLPHUhnZPiYsr9gMuTHxWDo5KEuXIA=;
        b=fExJXPWoApJlXyRvoqAruxbwbkpcz0EzAl+B459U95dgwk0Qg53RMhwBwOj6akJDm5
         TT9ViWG+ndPoXg+zgQAzOz199KT46Rx9VSpnAXEUCMxq9qAQvBScO+a3/TyOI0q07Apf
         UBidRQNdk0zA45UXjc6omsXN1fsCvoYFq1e0DbmwIxK302VsMt8TWJY+mwdIyDlS9G5/
         IFDkhzxo59GrW9x9rNAJ+lBlJomM511jyZeofyWJJdtz2Rxc4SVusiYyCQMtAv9y1KSu
         YEZBxUvgEO/AFMA/GNLkCB+7z0RDXS5HW3iDkcqVgDr8VnvjFiOhErr/Cj7nm8P/YBUE
         uIsw==
X-Gm-Message-State: APjAAAW0+j1I+jZpViakf1/UGIdIknriJ0m/++bA78zmFpx7jxzi2QSr
        o9dzg9b6Ud0XN1bnAiwCfUw/CmVqGcU=
X-Google-Smtp-Source: APXvYqzK0EN6LxZ6PeZkQ35QD+WNyXnn3w522Hsr7TYBAf4EaL5rOGTEP1EUYvziJPoQPLmQDNmhpQ==
X-Received: by 2002:ac2:4849:: with SMTP id 9mr3536785lfy.11.1576605972406;
        Tue, 17 Dec 2019 10:06:12 -0800 (PST)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id u20sm12969730lju.34.2019.12.17.10.06.10
        for <linux-arch@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 10:06:11 -0800 (PST)
Received: by mail-lj1-f180.google.com with SMTP id u71so4208725lje.11
        for <linux-arch@vger.kernel.org>; Tue, 17 Dec 2019 10:06:10 -0800 (PST)
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr4238381ljj.148.1576605970602;
 Tue, 17 Dec 2019 10:06:10 -0800 (PST)
MIME-Version: 1.0
References: <20191212100756.GA11317@willie-the-truck> <20191212104610.GW2827@hirez.programming.kicks-ass.net>
 <CAHk-=wjUBsH0BYDBv=q36482G-U7c=9bC89L_BViSciTfb8fhA@mail.gmail.com>
 <20191212180634.GA19020@willie-the-truck> <CAHk-=whRxB0adkz+V7SQC8Ac_rr_YfaPY8M2mFDfJP2FFBNz8A@mail.gmail.com>
 <20191212193401.GB19020@willie-the-truck> <CAHk-=wiMuHmWzQ7-CRQB6o+SHtA-u-Rp6VZwPcqDbjAaug80rQ@mail.gmail.com>
 <20191217170719.GA869@willie-the-truck> <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
In-Reply-To: <CAHk-=whBnZBVNwu8aVVp205EKk7xtsnQgSjs38a5=y9HyheXzQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 17 Dec 2019 10:05:53 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Message-ID: <CAHk-=wgsbrq6sFOSd9QrjR-fCamgzqCtFuO2_8qvJANA1+Jm6g@mail.gmail.com>
Subject: Re: READ_ONCE() + STACKPROTECTOR_STRONG == :/ (was Re: [GIT PULL]
 Please pull powerpc/linux.git powerpc-5.5-2 tag (topic/kasan-bitops))
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Axtens <dja@axtens.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-arch <linux-arch@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Dec 17, 2019 at 10:04 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Let me think about it.

.. and in the short term, maybe for code generation, the right thing
is to just do the cast in the bitops, where we can just cast to
"unsigned long *" and remove the volatile that way.

I'm still hoping there's a trick, but..

           Linus
